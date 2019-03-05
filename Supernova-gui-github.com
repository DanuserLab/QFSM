399,373 code results
@Bogdan-G
Bogdan-G/ThaumicHorizons – GuiFingers.java
Showing the top five matches
Last indexed on Jul 13, 2018
Java
   ArrayList primals = Aspect.getPrimalAspects();


   public GuiFingers(InventoryPlayer par1InventoryPlayer) {
      super(new ContainerFingers(par1InventoryPlayer));
      this.tileEntity = ((ContainerFingers)super.inventorySlots).tileEntity;
      this.ip = par1InventoryPlayer;
      super.ySize = 234;
      super.xSize = 190;
@RZhohov
RZhohov/SparseDisctributedMemory_P2P – MegaPeer.java
Showing the top four matches
Last indexed on Jul 11, 2018
Java
	private SDMImpl sdm;
	private BitVector ID;
	private String SPeerIP;
	private String GUI_IP;
	private BitVector slfResult;
	    Random rand = new Random();
	    int randomSPeer = rand.nextInt((max - min) + 1) + min;
		SPeerIP = superPeers.get(randomSPeer);
@liwuye
liwuye/finish – jiankong.java
Showing the top eight matches
Last indexed on Jul 5, 2018
Java
   this.setTitle(this.getTitle().replace(this.ip, ip));
   this.ip=ip;
   return true;
  }
  return false;
 }

 protected ServerGUI(String IP, String sub) {
    String operateStr ="mouseClicked,"+ x + "," + y + "," + e.getModifiers();
    
    SendOperate sender=new SendOperate(ServerGUI.this.ip, (operateStr));
    sender.changeIP(ServerGUI.this.ip);//同步ip
@FreyaFreed
FreyaFreed/Stockkeeper – StockkeeperMenu.java
Showing the top six matches
Last indexed on Jul 5, 2018
Java
	private GuiLabel password, defaultGroup;
	private int currentFields;
	private GuiTextField ipText;
	private GuiLabel ip;


	public StockkeeperMenu() {
		super();
	}
	@Override
	protected void actionPerformed(GuiButton button) throws IOException {
@PorfilioVMJ
PorfilioVMJ/PorfilioVMJ-s-Desktop-Mod – GuiOSTileEntity.java
Showing the top seven matches
Last indexed on Jul 11, 2018
Java
public class GuiOSTileEntity extends GuiScreen{
	
	private GuiButton exit;
	private GuiButtonExt enterIp;
	private GuiLabel currentScreen;
	private GuiTextField routerIp;
	SubBiOS bios = new SubBiOS();
	public int pcs = 0;
	
	ExtraStorage storage;
@zhewangzhewang
zhewangzhewang/FT_UI – DialogTcpIpConfig.js
Showing the top six matches
Last indexed on Jul 12, 2018
JavaScript
/**
 * @class app.gui.controls.DialogTcpIpConfig
 */

app.gui.controls.DialogTcpIpConfig = function DialogTcpIpConfig () {};
o5.gui.controls.Control.registerAppControl(app.gui.controls.DialogTcpIpConfig, app.gui.controls.HtmlDialogContainer);
@sophy94
sophy94/RemoteControl – Client.java
Showing the top six matches
Last indexed on Jul 1, 2018
Java
				break;
			}
		}
		return isIp;
	}
}

/**
 * serverManage的辅助窗体，内部事件封装了sendOperate的实现
 */
class ServerGUI extends JFrame {
	protected ServerGUI(String IP, String sub) {
		this.boo = true;
		this.ip = IP;
		this.port=SendOperate.DEFAULT_PORT;
@FreyaFreed
FreyaFreed/Stockkeeper-1.12.2 – StockkeeperMenu.java
Showing the top six matches
Last indexed on Sep 29, 2018
Java
	private GuiLabel password, defaultGroup;
	private int currentFields;
	private GuiTextField ipText;
	private GuiLabel ip;


	public StockkeeperMenu() {
		super();
	}
	@Override
	protected void actionPerformed(GuiButton button) throws IOException {
@trustathsh
trustathsh/metalyzer – IpAddressPanel.java
Showing the top six matches
Last indexed on Jun 28, 2018
Java
	public IpAddressPanel(MetalyzerGuiController guiController,
			String characteristic) {
		super(guiController, characteristic);
		if (characteristic.equals(CharacteristicLabels.IP_USER)) {
			super.setComboBoxLabel("IpAddress: ");
@flybetter
flybetter/workflow – BseriesEthMainWebPanel.java
Showing the top three matches
Last indexed on Jul 12, 2018
Java
package com.calix.bseries.gui.panels;

import java.util.ArrayList;
import java.util.Collection;
    	}catch(Exception e) {
    		Code.warning(e);
    	}
    	if(networkIp != null) {
        	super.populateFieldsFromData(params);
© 2019 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
