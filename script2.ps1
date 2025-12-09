Add-Type -AssemblyName System.Windows.Forms   #Carga las librerías, donde System.Windows.Form contiene las clases de los controles (Form, Button, TextBox, etc)
Add-Type -AssemblyName System.Drawing      # System.Drawing contiene las clases para gestionar gráficos, colores y dimensiones

# Create form
$form = New-Object System.Windows.Forms.Form  #Crea la venatna donde estaran todos los controles 
$form.Text = "Input Form"  #Establece el título    
$form.Size = New-Object System.Drawing.Size(500,250)  #Establece el tamaño de la ventana 
$form.StartPosition = "CenterScreen"      #Define la posición de la ventana, que en este caso aparecera centrada en la pantalla 

############# Define labels
$textLabel1 = New-Object System.Windows.Forms.Label #Crea el objeto de Etiqueta 1
$textLabel1.Text = "Input 1:"
$textLabel1.Left = 20
$textLabel1.Top = 20
$textLabel1.Width = 120

$textLabel2 = New-Object System.Windows.Forms.Label
$textLabel2.Text = "Input 2:"
$textLabel2.Left = 20
$textLabel2.Top = 60
$textLabel2.Width = 120

$textLabel3 = New-Object System.Windows.Forms.Label
$textLabel3.Text = "Input 3:"
$textLabel3.Left = 20
$textLabel3.Top = 100
$textLabel3.Width = 120

############# Textbox 1
$textBox1 = New-Object System.Windows.Forms.TextBox #Crea el objeto de Campo de Texto 1
$textBox1.Left = 150
$textBox1.Top = 20
$textBox1.Width = 200

############# Textbox 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Left = 150
$textBox2.Top = 60
$textBox2.Width = 200

############# Textbox 3
$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Left = 150
$textBox3.Top = 100
$textBox3.Width = 200

############# Default values
$defaultValue = ""
$textBox1.Text = $defaultValue
$textBox2.Text = $defaultValue
$textBox3.Text = $defaultValue

############# OK Button
$button = New-Object System.Windows.Forms.Button   #Crea el boton "OK" con sus respectvas posiciones 
$button.Left = 360
$button.Top = 140
$button.Width = 100
$button.Text = "OK"

############# Button click event
$button.Add_Click({   #Se encarga de definir la acción que ocurrirá cuando el usuario haga clic en el botón
    $form.Tag = @{  #Se almacena todo lo que se ingresa en el los recuadros de la GUI 
        Box1 = $textBox1.Text
        Box2 = $textBox2.Text
        Box3 = $textBox3.Text
    }
    $form.Close() #Al finalizar se cierra la ventana 
})

############# Add controls
$form.Controls.Add($button) #Añade todos los controles al formulario 
$form.Controls.Add($textLabel1)
$form.Controls.Add($textLabel2)
$form.Controls.Add($textLabel3)
$form.Controls.Add($textBox1)
$form.Controls.Add($textBox2)
$form.Controls.Add($textBox3)

############# Show dialog
$form.ShowDialog() | Out-Null

############# Return values
return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3
