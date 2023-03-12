Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81EAC6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C4210E4B9;
	Mon, 13 Mar 2023 08:18:32 +0000 (UTC)
X-Greylist: delayed 566 seconds by postgrey-1.36 at gabe;
 Sun, 12 Mar 2023 19:36:24 UTC
Received: from mifar.in (mifar.in [161.35.211.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1624810E254
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Mar 2023 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mifar.in;
 i=@mifar.in; q=dns/txt; s=mail; t=1678649216; h=date : from : to :
 subject : message-id : mime-version : content-type : from;
 bh=ZKoZMWmNKBjFqsAE0YZ7b/+fPWhn2EULH2Zsg3TcBXU=;
 b=aijfQkwI3FxJN+xwbA4bh927ALFeeFwayr4CgkcDGfsuo5hzyUXpGP1XO2SMfd4xX35Fl
 Gi3pM3EeM5kD1njvIj6mjMsK8PvHvU1zlXDSgBzjuaYJuoQ71U/9LPDTK3wq8Jmoyt9GZqT
 TSR1NkL07RNJZ2x71L03ZbG8Lnb4hW86S1uNzL+Cc0P53E3fQxXFGJKDbJoVCD9i3XQP8NR
 K4de1qGXs4oHK4FDxUfXp+wCU1qFx9FF1TKUc6CcXVM2fQcTMxqCS0pbIS03T+eQwBl2VHf
 J8TwMYbzZOG4viLis9hveZw+wtmJ7+ekers0dMrgXtsug0f4Qq1ASQ9hbdHQ==
Received: from mifar.in (dsl-hkibng21-54f867-87.dhcp.inet.fi [84.248.103.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ED448 client-signature ED448)
 (Client CN "mutt.mifar.in", Issuer "ca.mifar.in" (verified OK))
 by mifar.in (Postfix) with ESMTPS id 69FB93F261
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Mar 2023 19:26:56 +0000 (UTC)
Date: Sun, 12 Mar 2023 21:26:54 +0200
From: Sami Farin <linuxamdgpu@mifar.in>
To: amd-gfx@lists.freedesktop.org
Subject: [amdgpu] [RX550] 6.1.15+ kernel system freeze when display turned off
Message-ID: <20230312192654.lvam63yarnaaezir@m.mifar.in>
Mail-Followup-To: Sami Farin <linuxamdgpu@mifar.in>,
 amd-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 13 Mar 2023 08:18:21 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

6.1.14 worked OK for 11 days, then I got the idea of updating this stable
series.  In the morning screen was black and system completely dead, had
to press reset switch.  6.1.16 and 6.1.18 both have this issue.
If I just press ctrl-alt-L on Wayland Gnome to "power-save" the display
and wait a couple of minutes and try to resume, system just freezes.
Sure, not necessarily an amdgpu issue, but it's my first suspect.

System:
   Kernel: 6.1.14+ arch: x86_64 bits: 64 Console: pty pts/13
     Distro: Fedora release 37 (Thirty Seven)
CPU:
   Info: 6-core model: AMD Ryzen 5 1600X bits: 64 type: MCP cache: L2: 3 MiB
   Speed (MHz): avg: 3600 min/max: 2200/3600 cores: 1: 3600 2: 3600 3: 3600
     4: 3600 5: 3600 6: 3600
Machine:
   Type: Desktop Mobo: ASRock model: X370 Taichi serial: M80-A6007501776
     UEFI-[Legacy]: American Megatrends v: P6.20 date: 01/03/2020
Memory:
   RAM: total: 31.2 GiB used: 4.77 GiB (15.3%)
   Array-1: capacity: 128 GiB slots: 4 EC: None
   Device-1: DIMM 0 type: no module installed
   Device-2: DIMM 1 type: DDR4 size: 16 GiB speed: 2400 MT/s
   Device-3: DIMM 0 type: no module installed
   Device-4: DIMM 1 type: DDR4 size: 16 GiB speed: 2400 MT/s
PCI Slots:
   Slot: 17 type: PCIe lanes: 1 status: in use
   Slot: 18 type: PCIe lanes: 16 status: in use
   Slot: 19 type: PCIe lanes: 8 status: in use
   Slot: 20 type: PCIe lanes: 1 status: in use
   Slot: 21 type: PCIe lanes: 4 status: in use
   Slot: 49 type: PCIe lanes: 4 status: in use
Graphics:
   Device-1: AMD Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X]
     driver: amdgpu v: kernel
   Display: server: X.Org v: 22.1.8 with: Xwayland v: 22.1.8 driver: X:
     loaded: amdgpu unloaded: fbdev,modesetting,vesa dri: radeonsi gpu:
amdgpu
     resolution: 3840x2160~60Hz
   API: OpenGL v: 4.6 Mesa 22.3.7 renderer: AMD Radeon RX 550 / 550
Series
     (polaris12 LLVM 15.0.7 DRM 3.49 6.1.14+)
Network:
   Device-1: Intel I211 Gigabit Network driver: igb
USB:
   Hub-1: 1-0:1 info: Hi-speed hub with single TT ports: 14 rev: 2.0
   Device-1: 1-2:2 info: Thesycon System & Consulting GmbH E30 type:
Audio
     rev: 2.0
   Hub-2: 1-6:3 info: VIA Labs Hub ports: 4 rev: 2.1
   Device-1: 1-6.2:5 info: Mackie Designs EM-USB Microphone type:
Audio,HID
     rev: 1.1
   Device-2: 1-11:4 info: Holtek Keyboard [Diatec Filco Majestouch 2]
     type: Keyboard,Mouse rev: 1.1
   Hub-3: 2-0:1 info: Super-speed hub ports: 8 rev: 3.1
   Hub-4: 2-6:2 info: VIA Labs Hub ports: 4 rev: 3.0
   Hub-5: 3-0:1 info: Hi-speed hub with single TT ports: 4 rev: 2.0
   Device-1: 3-2:2 info: MGE UPS Systems type: HID rev: 2.0
   Device-2: 3-3:3 info: Logitech G203 Gaming Mouse type: Mouse,HID rev:
2.0
   Hub-6: 4-0:1 info: Super-speed hub ports: 4 rev: 3.0

00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Root Complex [1022:1450]
     Subsystem: ASRock Incorporation Device [1849:1450]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 50 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 50 14
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 52 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge [1022:1453] (prog-if 00 [Normal
decode])
     Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) PCIe GPP Bridge [1022:1453]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 25
     Bus: primary=00, secondary=01, subordinate=0a, sec-latency=0
     I/O behind bridge: d000-efff [size=8K] [16-bit]
     Memory behind bridge: fc700000-fcafffff [size=4M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
         LnkCap: Port #2, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1
<64us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x4
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #0, PowerLimit 0W; Interlock- NoCompl+
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
             Changed: MRL- PresDet- LinkState+
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp-
ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
         DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee02000  Data: 0021
     Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) PCIe GPP Bridge [1022:1453]
     Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: LaneErr at lane: 0 1 2 3
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Capabilities: [370 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
L1_PM_Substates+
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
         L1SubCtl2:
     Capabilities: [3c4 v1] Designated Vendor-Specific: Vendor=1022
ID=0001 Rev=1 Len=44 <?>
     Kernel driver in use: pcieport
00: 22 10 53 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 01 0a 00 d1 e1 00 20
20: 70 fc a0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00

00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 52 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 52 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge [1022:1453] (prog-if 00 [Normal
decode])
     Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) PCIe GPP Bridge [1022:1453]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin ? routed to IRQ 26
     Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
     I/O behind bridge: f000-ffff [size=4K] [16-bit]
     Memory behind bridge: fcf00000-fcffffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: e0000000-f01fffff [size=258M]
[32-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L1, Exit Latency
L1 <64us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x8
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #0, PowerLimit 0W; Interlock- NoCompl+
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
             Changed: MRL- PresDet- LinkState+
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp-
ARIFwd+
              AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
         DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd+
              AtomicOpsCtl: ReqEn- EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee08000  Data: 0021
     Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) PCIe GPP Bridge [1022:1453]
     Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: LaneErr at lane: 0 1 2 3 4 5 6 7
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl- DirectTrans+
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Capabilities: [370 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
L1_PM_Substates+
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
         L1SubCtl2:
     Capabilities: [3c4 v1] Designated Vendor-Specific: Vendor=1022
ID=0001 Rev=1 Len=44 <?>
     Kernel driver in use: pcieport
00: 22 10 53 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0b 0b 00 f1 f1 00 20
20: f0 fc f0 fc 01 e0 11 f0 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 1a 00

00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 52 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 52 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
(prog-if 00 [Normal decode])
     Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 27
     Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: fcb00000-fcdfffff [size=3M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot-), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp-
ARIFwd-
              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee09000  Data: 0021
     Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B
[1022:1454]
     Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Kernel driver in use: pcieport
00: 22 10 54 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0c 0c 00 f1 01 00 00
20: b0 fc d0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 52 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
(prog-if 00 [Normal decode])
     Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 29
     Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: fce00000-fcefffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot-), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+
CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp-
ARIFwd-
              AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: ReqEn- EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0a000  Data: 0021
     Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B
[1022:1454]
     Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
         RootCmd: CERptEn+ NFERptEn+ FERptEn+
         RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
              FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
         ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Kernel driver in use: pcieport
00: 22 10 54 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 0d 0d 00 f1 01 00 00
20: e0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 12 00

00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus
Controller [1022:790b] (rev 59)
     Subsystem: ASRock Incorporation Device [1849:790b]
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Kernel driver in use: piix4_smbus
     Kernel modules: i2c_piix4, sp5100_tco
00: 22 10 0b 79 03 04 20 02 59 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 0b 79
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC
Bridge [1022:790e] (rev 51)
     Subsystem: ASRock Incorporation Device [1849:790e]
     Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
00: 22 10 0e 79 0f 00 20 02 51 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 0e 79
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 60 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 61 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 62 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Kernel driver in use: k10temp
     Kernel modules: k10temp
00: 22 10 63 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 64 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 65 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 6 [1022:1466]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 66 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 22 10 67 14 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] X370
Series Chipset USB 3.1 xHCI Controller [1022:43b9] (rev 02) (prog-if 30
[XHCI])
     Subsystem: ASRock Incorporation Fatal1ty X370 Professional Gaming
[1849:43d0]
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 65
     Region 0: Memory at fcaa0000 (64-bit, non-prefetchable) [size=32K]
     Capabilities: [50] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee02000  Data: 0028
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1
<2us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x4
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+
EqualizationPhase1+
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [200 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [300 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [400 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=0us
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci_pci
00: 22 10 b9 43 06 04 10 00 02 30 03 0c 10 00 80 00
10: 04 00 aa fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 d0 43
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] X370
Series Chipset SATA Controller [1022:43b5] (rev 02) (prog-if 01 [AHCI
1.0])
     Subsystem: ASRock Incorporation Fatal1ty X370 Professional Gaming
[1849:43c8]
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 45
     Region 5: Memory at fca80000 (32-bit, non-prefetchable) [size=128K]
     Expansion ROM at fca00000 [disabled] [size=512K]
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0a000  Data: 0027
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1
<2us
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x4
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Kernel driver in use: ahci
00: 22 10 b5 43 06 04 10 00 02 01 06 01 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 a8 fc 00 00 00 00 49 18 c8 43
30: 00 00 a0 fc 50 00 00 00 00 00 00 00 0a 02 00 00

01:00.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] X370
Series Chipset PCIe Upstream Port [1022:43b0] (rev 02) (prog-if 00
[Normal decode])
     Subsystem: ASRock Incorporation Fatal1ty X370 Professional Gaming
[1849:43c6]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin C routed to IRQ 31
     Bus: primary=01, secondary=02, subordinate=0a, sec-latency=0
     I/O behind bridge: d000-efff [size=8K] [16-bit]
     Memory behind bridge: fc700000-fc9fffff [size=3M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00000  Data: 0021
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Upstream Port, MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x4
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation Fatal1ty X370
Professional Gaming [1849:43c6]
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Kernel driver in use: pcieport
00: 22 10 b0 43 07 04 10 00 02 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 01 02 0a 00 d1 e1 00 00
20: 70 fc 90 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 03 12 00

02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port [1022:43b4] (rev 02) (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation Device [1849:43c7]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 32
     Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: [disabled] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee01000  Data: 0022
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 2.5GT/s, Width x0
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #1, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation Device
[1849:43c7]
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [200 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [400 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=0us
     Kernel driver in use: pcieport
00: 22 10 b4 43 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 03 03 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 12 00

02:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port [1022:43b4] (rev 02) (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation Device [1849:43c7]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 33
     Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: e000-efff [size=4K] [16-bit]
     Memory behind bridge: fc900000-fc9fffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee02000  Data: 0022
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #1, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation Device
[1849:43c7]
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [200 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [400 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=0us
     Kernel driver in use: pcieport
00: 22 10 b4 43 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 04 04 00 e1 e1 00 00
20: 90 fc 90 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 12 00

02:03.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port [1022:43b4] (rev 02) (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation Device [1849:43c7]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 35
     Bus: primary=02, secondary=05, subordinate=09, sec-latency=0
     I/O behind bridge: d000-dfff [size=4K] [16-bit]
     Memory behind bridge: fc800000-fc8fffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee08000  Data: 0022
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #1, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation Device
[1849:43c7]
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [200 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [400 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=0us
     Kernel driver in use: pcieport
00: 22 10 b4 43 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 05 09 00 d1 d1 00 00
20: 80 fc 80 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 04 01 12 00

02:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port [1022:43b4] (rev 02) (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation Device [1849:43c7]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 36
     Bus: primary=02, secondary=0a, subordinate=0a, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: fc700000-fc7fffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee09000  Data: 0022
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #4, Speed 5GT/s, Width x4, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 5GT/s, Width x4
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #1, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
             Changed: MRL- PresDet+ LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation Device
[1849:43c7]
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [200 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [400 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=10us LTR1.2_Threshold=76800ns
         L1SubCtl2: T_PwrOn=60us
     Kernel driver in use: pcieport
00: 22 10 b4 43 07 04 10 00 02 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 02 0a 0a 00 f1 01 00 00
20: 70 fc 70 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 12 00

04:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1062 Serial
ATA Controller [1b21:0612] (rev 02) (prog-if 01 [AHCI 1.0])
     Subsystem: ASRock Incorporation Motherboard [1849:0612]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 46
     Region 0: I/O ports at e050 [size=8]
     Region 1: I/O ports at e040 [size=4]
     Region 2: I/O ports at e030 [size=8]
     Region 3: I/O ports at e020 [size=4]
     Region 4: I/O ports at e000 [size=32]
     Region 5: Memory at fc900000 (32-bit, non-prefetchable) [size=512]
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee01000  Data: 0025
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1
<8us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
         LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s, Exit Latency
L0s unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABC, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Virtual Channel
         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:   ArbSelect=Fixed
         Status: InProgress-
         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status: NegoPending- InProgress-
     Kernel driver in use: ahci
00: 21 1b 12 06 07 04 10 00 02 01 06 01 10 00 00 00
10: 51 e0 00 00 41 e0 00 00 31 e0 00 00 21 e0 00 00
20: 01 e0 00 00 00 00 90 fc 00 00 00 00 49 18 12 06
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00

05:00.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1184e 4-Port PCIe
x1 Gen2 Packet Switch [1b21:1184] (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation ASM1184e 4-Port PCIe x1 Gen2 Packet
Switch [1849:1184]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 37
     Bus: primary=05, secondary=06, subordinate=09, sec-latency=0
     I/O behind bridge: d000-dfff [size=4K] [16-bit]
     Memory behind bridge: fc800000-fc8fffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0a000  Data: 0022
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Upstream Port, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 26W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: EgressBlck-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation ASM1184e 4-Port
PCIe x1 Gen2 Packet Switch [1849:1184]
     Capabilities: [100 v1] Virtual Channel
         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:   ArbSelect=Fixed
         Status: InProgress-
         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status: NegoPending- InProgress-
     Capabilities: [200 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [300 v1] Vendor Specific Information: ID=0000 Rev=0
Len=c00 <?>
     Kernel driver in use: pcieport
00: 21 1b 84 11 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 05 06 09 00 d1 d1 00 00
20: 80 fc 80 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 04 01 12 00

06:03.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1184e 4-Port PCIe
x1 Gen2 Packet Switch [1b21:1184] (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation ASM1184e 4-Port PCIe x1 Gen2 Packet
Switch [1849:1184]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 38
     Bus: primary=06, secondary=07, subordinate=07, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: [disabled] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00000  Data: 0022
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #3, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation ASM1184e 4-Port
PCIe x1 Gen2 Packet Switch [1849:1184]
     Capabilities: [100 v1] Virtual Channel
         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:   ArbSelect=Fixed
         Status: InProgress-
         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status: NegoPending+ InProgress-
     Capabilities: [200 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Kernel driver in use: pcieport
00: 21 1b 84 11 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 06 07 07 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 12 00

06:05.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1184e 4-Port PCIe
x1 Gen2 Packet Switch [1b21:1184] (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation ASM1184e 4-Port PCIe x1 Gen2 Packet
Switch [1849:1184]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 39
     Bus: primary=06, secondary=08, subordinate=08, sec-latency=0
     I/O behind bridge: d000-dfff [size=4K] [16-bit]
     Memory behind bridge: fc800000-fc8fffff [size=1M] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee01000  Data: 0023
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #5, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
             Changed: MRL- PresDet- LinkState+
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation ASM1184e 4-Port
PCIe x1 Gen2 Packet Switch [1849:1184]
     Capabilities: [100 v1] Virtual Channel
         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:   ArbSelect=Fixed
         Status: InProgress-
         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status: NegoPending- InProgress-
     Capabilities: [200 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Kernel driver in use: pcieport
00: 21 1b 84 11 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 06 08 08 00 d1 d1 00 00
20: 80 fc 80 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 12 00

06:07.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1184e 4-Port PCIe
x1 Gen2 Packet Switch [1b21:1184] (prog-if 00 [Normal decode])
     Subsystem: ASRock Incorporation ASM1184e 4-Port PCIe x1 Gen2 Packet
Switch [1849:1184]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 40
     Bus: primary=06, secondary=09, subordinate=09, sec-latency=0
     I/O behind bridge: [disabled] [32-bit]
     Memory behind bridge: [disabled] [32-bit]
     Prefetchable memory behind bridge: [disabled] [64-bit]
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee02000  Data: 0023
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #7, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl: ASPM Disabled; Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
             Slot #7, PowerLimit 26W; Interlock- NoCompl-
         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- ARIFwd-
              AtomicOpsCap: Routing-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled, ARIFwd-
              AtomicOpsCtl: EgressBlck-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [c0] Subsystem: ASRock Incorporation ASM1184e 4-Port
PCIe x1 Gen2 Packet Switch [1849:1184]
     Capabilities: [100 v1] Virtual Channel
         Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:   ArbSelect=Fixed
         Status: InProgress-
         VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status: NegoPending+ InProgress-
     Capabilities: [200 v1] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 1f, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Kernel driver in use: pcieport
00: 21 1b 84 11 07 04 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 06 09 09 00 f1 01 00 00
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 12 00

08:00.0 Ethernet controller [0200]: Intel Corporation I211 Gigabit
Network Connection [8086:1539] (rev 03)
     Subsystem: ASRock Incorporation Device [1849:1539]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 28
     Region 0: Memory at fc800000 (32-bit, non-prefetchable) [size=128K]
     Region 2: I/O ports at d000 [size=32]
     Region 3: Memory at fc820000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
         Address: 0000000000000000  Data: 0000
         Masking: 00000000  Pending: 00000000
     Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
         Vector table: BAR=3 offset=00000000
         PBA: BAR=3 offset=00002000
     Capabilities: [a0] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns,
L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
         LnkCap: Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 <16us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 2.5GT/s, Width x1
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [140 v1] Device Serial Number 70-85-c2-ff-ff-49-e4-12
     Capabilities: [1a0 v1] Transaction Processing Hints
         Device specific mode supported
         Steering table in TPH capability structure
     Kernel driver in use: igb
     Kernel modules: igb
00: 86 80 39 15 07 04 10 00 03 00 00 02 10 00 00 00
10: 00 00 80 fc 00 00 00 00 01 d0 00 00 00 00 82 fc
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 15
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00

0a:00.0 Non-Volatile memory controller [0108]: Phison Electronics
Corporation E12 NVMe Controller [1987:5012] (rev 01) (prog-if 02 [NVM
Express])
     Subsystem: Phison Electronics Corporation E12 NVMe Controller
[1987:5012]
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 28
     NUMA node: 0
     Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [80] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 26W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1
<64us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 5GT/s (downgraded), Width x4
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [d0] MSI-X: Enable+ Count=9 Masked-
         Vector table: BAR=0 offset=00002000
         PBA: BAR=0 offset=00003000
     Capabilities: [e0] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [f8] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [110 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=10us PortTPowerOnTime=60us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=76800ns
         L1SubCtl2: T_PwrOn=60us
     Capabilities: [128 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap: MFVC- ACS-, Next Function: 0
         ARICtl: MFVC- ACS-, Function Group: 0
     Capabilities: [200 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 04000001 0000010f 03070000 75b86b4f
     Capabilities: [300 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: LaneErr at lane: 0 1 2 3
     Kernel driver in use: nvme
00: 87 19 12 50 06 04 10 00 01 02 08 01 10 00 00 00
10: 04 00 70 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 87 19 12 50
30: 00 00 00 00 80 00 00 00 00 00 00 00 0b 01 00 00

0b:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X]
[1002:699f] (rev c7) (prog-if 00 [VGA controller])
     Subsystem: Sapphire Technology Limited Lexa PRO [Radeon RX 550]
[1da2:e367]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 42
     Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
     Region 2: Memory at f0000000 (64-bit, prefetchable) [size=2M]
     Region 4: I/O ports at f000 [size=256]
     Region 5: Memory at fcf00000 (32-bit, non-prefetchable) [size=256K]
     Expansion ROM at 000c0000 [disabled] [size=128K]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1
<1us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x8
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn+
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee00000  Data: 0026
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [200 v1] Physical Resizable BAR
         BAR 0: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [2b0 v1] Address Translation Service (ATS)
         ATSCap: Invalidate Queue Depth: 00
         ATSCtl: Enable-, Smallest Translation Unit: 00
     Capabilities: [2c0 v1] Page Request Interface (PRI)
         PRICtl: Enable- Reset-
         PRISta: RF- UPRGI- Stopped+
         Page Request Capacity: 00000020, Page Request Allocation:
00000000
     Capabilities: [2d0 v1] Process Address Space ID (PASID)
         PASIDCap: Exec+ Priv+, Max PASID Width: 10
         PASIDCtl: Enable- Exec- Priv-
     Capabilities: [320 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap: MFVC- ACS-, Next Function: 1
         ARICtl: MFVC- ACS-, Function Group: 0
     Capabilities: [370 v1] L1 PM Substates
         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
               PortCommonModeRestoreTime=0us PortTPowerOnTime=170us
         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                T_CommonMode=0us LTR1.2_Threshold=0ns
         L1SubCtl2: T_PwrOn=10us
     Kernel driver in use: amdgpu
00: 02 10 9f 69 07 04 10 00 c7 00 00 03 10 00 80 00
10: 0c 00 00 e0 00 00 00 00 0c 00 00 f0 00 00 00 00
20: 01 f0 00 00 00 00 f0 fc 00 00 00 00 a2 1d 67 e3
30: 00 00 f4 fc 48 00 00 00 00 00 00 00 0b 01 00 00

0b:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI]
Baffin HDMI/DP Audio [Radeon RX 550 640SP / RX 560/560X] [1002:aae0]
     Subsystem: Sapphire Technology Limited Device [1da2:aae0]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 69
     Region 0: Memory at fcf60000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1
<1us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x8
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
EETLPPrefix+, MaxEETLPPrefixes 1
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee01000  Data: 0026
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr-
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap: MFVC- ACS-, Next Function: 0
         ARICtl: MFVC- ACS-, Function Group: 0
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel
00: 02 10 e0 aa 07 04 10 00 00 00 03 04 10 00 80 00
10: 04 00 f6 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 a2 1d e0 aa
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 02 00 00

0c:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Zeppelin/Raven/Raven2 PCIe Dummy Function [1022:145a]
     Subsystem: Advanced Micro Devices, Inc. [AMD] Zeppelin/Raven/Raven2
PCIe Dummy Function [1022:145a]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [64] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
00: 22 10 5a 14 07 00 10 00 00 00 00 13 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 5a 14
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 00 00 00

0c:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) Platform Security Processor (PSP) 3.0 Device
[1022:1456]
     Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) Platform Security Processor (PSP) 3.0 Device [1022:1456]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 57
     Region 2: Memory at fcc00000 (32-bit, non-prefetchable) [size=1M]
     Region 5: Memory at fcd00000 (32-bit, non-prefetchable) [size=8K]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [64] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable- Count=1/2 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [c0] MSI-X: Enable+ Count=2 Masked-
         Vector table: BAR=5 offset=00000000
         PBA: BAR=5 offset=00001000
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Kernel driver in use: ccp
     Kernel modules: ccp
00: 22 10 56 14 07 04 10 00 00 00 80 10 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 c0 fc 00 00 00 00
20: 00 00 00 00 00 00 d0 fc 00 00 00 00 22 10 56 14
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 02 00 00

0c:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 00h-0fh) USB 3.0 Host Controller [1022:145c] (prog-if 30
[XHCI])
     Subsystem: ASRock Incorporation Device [1849:7914]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin C routed to IRQ 67
     Region 0: Memory at fcb00000 (64-bit, non-prefetchable) [size=1M]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [64] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/8 Maskable- 64bit+
         Address: 00000000fee09000  Data: 0023
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci_pci
00: 22 10 5c 14 07 04 10 00 00 30 03 0c 10 00 80 00
10: 04 00 b0 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 14 79
30: 00 00 00 00 48 00 00 00 00 00 00 00 04 03 00 00

0d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Zeppelin/Renoir PCIe Dummy Function [1022:1455]
     Subsystem: Advanced Micro Devices, Inc. [AMD] Zeppelin/Renoir PCIe
Dummy Function [1022:1455]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [64] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer-
2Retimers- DRS-
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
preshoot
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
              EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [270 v1] Secondary PCI Express
         LnkCtl3: LnkEquIntrruptEn- PerformEqu-
         LaneErrStat: 0
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
00: 22 10 55 14 07 00 10 00 00 00 00 13 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 55 14
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 00 00 00

0d:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode] [1022:7901] (rev 51) (prog-if 01 [AHCI 1.0])
     Subsystem: ASRock Incorporation Device [1849:7901]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 48
     Region 5: Memory at fce00000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [64] Express (v2) Endpoint, MSI 00
         DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 0W
         DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 256 bytes, MaxReadReq 512 bytes
         DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
         LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta: Speed 8GT/s, Width x16
             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP-
LTR-
              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt-
EETLPPrefix-
              EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
              FRS- TPHComp- ExtTPHComp-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
              AtomicOpsCtl: ReqEn-
         LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
              EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
              Retimer- 2Retimers- CrosslinkRes: unsupported
     Capabilities: [a0] MSI: Enable+ Count=1/16 Maskable- 64bit+
         Address: 00000000fee00000  Data: 0023
     Capabilities: [d0] SATA HBA v1.0 InCfgSpace
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+
         AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
         HeaderLog: 00000000 00000000 00000000 00000000
     Capabilities: [2a0 v1] Access Control Services
         ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
         ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
     Kernel driver in use: ahci
00: 22 10 01 79 07 04 10 00 51 01 06 01 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 e0 fc 00 00 00 00 49 18 01 79
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 02 00 00



-- 
