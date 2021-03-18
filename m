Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E234C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 12:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D1464E89
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 12:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D1464E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51ECE6E116;
	Thu, 18 Mar 2021 12:19:09 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3596E116
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1616069945;
 bh=dYJJURo6YkrlzIBfIunClFsad82ME9/cHgdXdVt6miw=;
 h=X-UI-Sender-Class:Reply-To:To:References:From:Subject:Date:
 In-Reply-To;
 b=jtW/ZpViVaE+vW4TPyLQPJagdVZIBErwPsaLA5JmoPZ1LYpTjtmTLsliP9byQEALF
 7tpybWUdBqAUROIeB6N0xWesqZzKGG5bcMgqlmKZMCf1JsfWbcXe1w7eEcbSQ17PpE
 c2ZnpdcONngbzyu/PDk8avSIrAl7kz/RdPc4Kv54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.1] ([178.27.135.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1lH3fJ3Rjp-00U5xF for
 <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 13:19:05 +0100
To: amd-gfx@lists.freedesktop.org
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Harvey <harv@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
Message-ID: <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
Date: Thu, 18 Mar 2021 13:17:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-Provags-ID: V03:K1:LppAQ4XC6xGUqKOl2tphH/AsaWRo+0Unqbewrfd3NjGJJzeFI2N
 RylDKy7y0jWaEQZfNTzAvBdrvovq7TtNLDWOL8gslNTUrVEIRxHfJMAjYvlnOZe7MHZmhEz
 ZMEaMBYKfvqxOEEy0KEfRwKurk2IcHf6k58W9cy0c8nQSkKbtWycZxvsfLb7q1GRGuB87NA
 zcCmSGVOyM+X3gkqtBo7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OORZvIJ5RPo=:nWYzrOq/Phr8R6dxGDVINF
 /jjTft3iZfezlomZqwXInvbhxqBmmW979tOv30OYhoKz089APgFO9bR4Cp0p7bNcgSPiEzexu
 3LZYALYmOFTSXFIWz9EOekGZcK57ptjJHLmPg+MWUUH9QY1k4/7pncM8o6NE1p6rXVDlAmChO
 W39Nu9DJ1XjjctLMRUeTcezWv51EjB0Qs1O5BZ0g+26FF6c3fdMazkI/BU3S18UOkz6KMfrY7
 n3cxEo/CABRUfRVsVxqQW69P88TlqvAEq9Xc/+YSll5S5EX1QA2w3fukpBM5eCU1FfvM25img
 +Qk3zbpVeTVmamtLbSdErRu1KhrlKeRQ+nLqQLKU+iUfKVoWsuNnrrIsTtBo5yAJwMVB6a699
 pGmySY+oo1OEuAvzk+pwzVxSzJ+6uW/I06MhNZ+Aruo6MgEV5LAqzMSD+mE/XMLSjwbVSpvM5
 Lbl1fa2Hc5U/UoqYHGxRRawGavyiyEDWXI4Ugks4l5vxLuhYnImYYjK02RsATwJ+SipF1gXpf
 dx5qFvhqA8oexE27VNe12G1SFL0919DIEMthoMnc6AoI5mL2wsm2nprDSKjQnRCqvtC0l3nx6
 dJ1VbOm3PAGz1/In5izh2ald/xc2P71Ry5fcp7Ltb0RT7mgOAmmOSYX4ytP0N2hbA6XGtUx74
 iyscXSM5rnpPYwujtRC3r4ChA/tvs1EcAfONjrRbzGTDdemPESez6XsorRa8DXIF+8W6jzneN
 X8GP6TZlIFyk5qBYdnMPHc019rvK3pAaK6mlbA4TsD8vqGPDjNqPUa0pCq0xlu6TU0sPG99KJ
 sa6G2kQYZlPgt+pwDZzC9lgSNXftVQ1PH/KLkC2h3pYzVbNM//6uwgrmLTQRpSW4EZUhbkG2X
 8NgZNvYZb57QWNX9NfSw==
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
Reply-To: harv@gmx.de
Content-Type: multipart/mixed; boundary="===============0040233847=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0040233847==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UvdCnPcyWlt7Wa8GhpBO06kwUTbLBGl4F"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UvdCnPcyWlt7Wa8GhpBO06kwUTbLBGl4F
Content-Type: multipart/mixed; boundary="oyj3uzet55VVAXcvPGEVw2XoswB0MDptB";
 protected-headers="v1"
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
To: amd-gfx@lists.freedesktop.org
Message-ID: <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>

--oyj3uzet55VVAXcvPGEVw2XoswB0MDptB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Alex,

I waited for kernel 5.11.7 to hit our repos yesterday evening and tested =

again:

1. The suspend issue is gone - suspend and resume now work as expected.

2. System hibernation seems to be a different beast - still freezing

When invoking 'systemctl hibernate' the system does not power off (I=20
waited for 5 minutes) and I have to hard reset it to start up again. It=20
then tries to resume from the swap partition and comes back up with only =

the external monitor connected to the HDMI port showing a picture and=20
the builtin screen of the laptop staying black. Nevertheless the system=20
is freezed and not responding, neither to mouse or keyboard. After=20
another hard reset I managed to get the following log from journalctl=20
(only cut the relevant part):

M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.3466=
]=20
manager: sleep: sleep requested (sleeping: no  enabled: yes)
M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.3473=
]=20
device (wlp4s0): state change: disconnected -> unmanaged (reason=20
'sleeping', sys-iface-state: 'managed')
M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.3508=
]=20
device (wlp4s0): set-hw-addr: reset MAC address to 14:F6:D8:18:8C:EC=20
(unmanage)
M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.3575=
]=20
device (p2p-dev-wlp4s0): state change: disconnected -> unmanaged (reason =

'sleeping', sys-iface-state: 'managed')
M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.3580=
]=20
manager: NetworkManager state is now ASLEEP
M=C3=A4r 18 12:51:11 obelix wpa_supplicant[954]: nl80211: deinit=20
ifname=3Dp2p-dev-wlp4s0 disabled_11b_rates=3D0
M=C3=A4r 18 12:51:11 obelix wpa_supplicant[954]: nl80211: deinit=20
ifname=3Dwlp4s0 disabled_11b_rates=3D0
M=C3=A4r 18 12:51:12 obelix gsd-media-keys[1691]: Unable to get default s=
ink
M=C3=A4r 18 12:51:15 obelix gnome-shell[1496]:=20
=2E./glib/gobject/gsignal.c:2732: instance '0x560b86c67b50' has no handle=
r=20
with id '15070'
M=C3=A4r 18 12:51:16 obelix gsd-usb-protect[1724]: Error calling USBGuard=
=20
DBus to change the protection after a screensaver event:=20
GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name=20
org.usbguard1 was not provided by any .service files
M=C3=A4r 18 12:51:16 obelix systemd[1]: Reached target Sleep.
M=C3=A4r 18 12:51:16 obelix systemd[1]: Starting Suspend...
M=C3=A4r 18 12:51:16 obelix systemd-sleep[2000]: Suspending system...
M=C3=A4r 18 12:51:16 obelix kernel: PM: suspend entry (deep)
M=C3=A4r 18 12:51:16 obelix kernel: Filesystems sync: 0.005 seconds
M=C3=A4r 18 12:51:36 obelix kernel: Freezing user space processes ...=20
(elapsed 0.002 seconds) done.
M=C3=A4r 18 12:51:36 obelix kernel: OOM killer disabled.
M=C3=A4r 18 12:51:36 obelix kernel: Freezing remaining freezable tasks ..=
=2E=20
(elapsed 0.001 seconds) done.
M=C3=A4r 18 12:51:36 obelix kernel: printk: Suspending console(s) (use=20
no_console_suspend to debug)
M=C3=A4r 18 12:51:36 obelix kernel: [drm] free PSP TMR buffer
M=C3=A4r 18 12:51:36 obelix kernel: [drm] free PSP TMR buffer
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: interrupt blocked
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Preparing to enter system sleep=
=20
state S3
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: event blocked
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: EC stopped
M=C3=A4r 18 12:51:36 obelix kernel: PM: Saving platform NVS memory
M=C3=A4r 18 12:51:36 obelix kernel: Disabling non-boot CPUs ...
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 86: no longer affine to CPU1
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 1 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 87: no longer affine to CPU2
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 2 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 88: no longer affine to CPU3
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 3 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 89: no longer affine to CPU4
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 4 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 90: no longer affine to CPU5
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 5 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 91: no longer affine to CPU6
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 6 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 92: no longer affine to CPU7
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 7 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 93: no longer affine to CPU8
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 8 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 94: no longer affine to CPU9
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 9 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: IRQ 95: no longer affine to CPU10
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 10 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 11 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 12 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 13 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 14 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 15 is now offline
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Low-level resume complete
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: EC started
M=C3=A4r 18 12:51:36 obelix kernel: PM: Restoring platform NVS memory
M=C3=A4r 18 12:51:36 obelix kernel: LVT offset 0 assigned for vector 0x40=
0
M=C3=A4r 18 12:51:36 obelix kernel: Enabling non-boot CPUs ...
M=C3=A4r 18 12:51:36 obelix kernel: x86: Booting SMP configuration:
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1 A=
PIC 0x1
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU1: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P001: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU1 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 2 A=
PIC 0x2
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU2: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P002: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU2 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 3 A=
PIC 0x3
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU3: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P003: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU3 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 4 A=
PIC 0x4
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU4: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P004: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU4 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 5 A=
PIC 0x5
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU5: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P005: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU5 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 6 A=
PIC 0x6
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU6: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P006: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU6 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 7 A=
PIC 0x7
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU7: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P007: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU7 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 8 A=
PIC 0x8
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU8: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P008: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU8 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 9 A=
PIC 0x9
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU9: patch_level=3D0x0860=
0104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P009: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU9 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 10 =
APIC 0xa
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU10: patch_level=3D0x086=
00104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00A: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU10 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 11 =
APIC 0xb
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU11: patch_level=3D0x086=
00104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00B: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU11 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 12 =
APIC 0xc
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU12: patch_level=3D0x086=
00104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00C: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU12 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 13 =
APIC 0xd
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU13: patch_level=3D0x086=
00104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00D: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU13 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 14 =
APIC 0xe
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU14: patch_level=3D0x086=
00104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00E: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU14 is up
M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 15 =
APIC 0xf
M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU15: patch_level=3D0x086=
00104
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00F: Found 3 idle s=
tates
M=C3=A4r 18 12:51:36 obelix kernel: CPU15 is up
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Waking up from system sleep sta=
te S3
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: interrupt unblocked
M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: event unblocked
M=C3=A4r 18 12:51:36 obelix kernel: [drm] PCIE GART of 1024M enabled (tab=
le=20
at 0x000000F400900000).
M=C3=A4r 18 12:51:36 obelix kernel: [drm] PSP is resuming...
M=C3=A4r 18 12:51:36 obelix kernel: [drm] reserve 0x400000 from 0xf41f800=
000=20
for PSP TMR
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAS:=20
optional ras ta ucode is not available
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAP:=20
optional rap ta ucode is not available
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=20
resuming...
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: dpm has =
been=20
disabled
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=20
resumed successfully!
M=C3=A4r 18 12:51:36 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
M=C3=A4r 18 12:51:36 obelix kernel: nvme nvme0: Shutdown timeout set to 8=
 seconds
M=C3=A4r 18 12:51:36 obelix kernel: [drm] DMUB hardware initialized:=20
version=3D0x01000000
M=C3=A4r 18 12:51:36 obelix kernel: usb 3-3: reset full-speed USB device =

number 3 using xhci_hcd
M=C3=A4r 18 12:51:36 obelix kernel: nvme nvme0: 16/0/0 default/read/poll =
queues
M=C3=A4r 18 12:51:36 obelix kernel: usb 1-4: reset high-speed USB device =

number 3 using xhci_hcd
M=C3=A4r 18 12:51:36 obelix kernel: ata2: SATA link down (SStatus 0 SCont=
rol 300)
M=C3=A4r 18 12:51:36 obelix kernel: [drm] VCN decode and encode initializ=
ed=20
successfully(under DPG Mode).
M=C3=A4r 18 12:51:36 obelix kernel: ata1: SATA link down (SStatus 0 SCont=
rol 300)
M=C3=A4r 18 12:51:36 obelix kernel: [drm] JPEG decode initialized success=
fully.
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring gfx=
=20
uses VM inv eng 0 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.0.0 uses VM inv eng 1 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.1.0 uses VM inv eng 4 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.2.0 uses VM inv eng 5 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.3.0 uses VM inv eng 6 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.0.1 uses VM inv eng 7 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.1.1 uses VM inv eng 8 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.2.1 uses VM inv eng 9 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.3.1 uses VM inv eng 10 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
kiq_2.1.0 uses VM inv eng 11 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring sdm=
a0=20
uses VM inv eng 0 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn=
_dec=20
uses VM inv eng 1 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
vcn_enc0 uses VM inv eng 4 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
vcn_enc1 uses VM inv eng 5 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
jpeg_dec uses VM inv eng 6 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: [drm] PCIE GART of 512M enabled (tabl=
e at=20
0x0000008000000000).
M=C3=A4r 18 12:51:36 obelix kernel: [drm] PSP is resuming...
M=C3=A4r 18 12:51:36 obelix kernel: [drm] reserve 0x900000 from 0x800f400=
000=20
for PSP TMR
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: RAS:=20
optional ras ta ucode is not available
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: RAP:=20
optional rap ta ucode is not available
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU is=20
resuming...
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: smu driv=
er=20
if version =3D 0x00000036, smu fw if version =3D 0x00000038, smu fw versi=
on=20
=3D 0x00352100 (53.33.0)
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU driv=
er=20
if version not matched
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU is=20
resumed successfully!
M=C3=A4r 18 12:51:36 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
M=C3=A4r 18 12:51:36 obelix kernel: [drm] VCN decode and encode initializ=
ed=20
successfully(under DPG Mode).
M=C3=A4r 18 12:51:36 obelix kernel: [drm] JPEG decode initialized success=
fully.
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
gfx_0.0.0 uses VM inv eng 0 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.0.0 uses VM inv eng 1 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.1.0 uses VM inv eng 4 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.2.0 uses VM inv eng 5 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.3.0 uses VM inv eng 6 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.0.1 uses VM inv eng 7 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.1.1 uses VM inv eng 8 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.2.1 uses VM inv eng 9 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
comp_1.3.1 uses VM inv eng 10 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
kiq_2.1.0 uses VM inv eng 11 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring sdm=
a0=20
uses VM inv eng 12 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring sdm=
a1=20
uses VM inv eng 13 on hub 0
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn=
_dec=20
uses VM inv eng 0 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
vcn_enc0 uses VM inv eng 1 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
vcn_enc1 uses VM inv eng 4 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring=20
jpeg_dec uses VM inv eng 5 on hub 1
M=C3=A4r 18 12:51:36 obelix kernel: acpi LNXPOWER:06: Turning OFF
M=C3=A4r 18 12:51:36 obelix kernel: acpi LNXPOWER:04: Turning OFF
M=C3=A4r 18 12:51:36 obelix kernel: OOM killer enabled.
M=C3=A4r 18 12:51:36 obelix kernel: Restarting tasks ... done.
M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130=20
audit(1616068296.433:95): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967=
295=20
msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd"=20
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"s=
ystemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:51:36 obelix bluetoothd[863]: Endpoint unregistered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) event7  - =

Microsoft Microsoft=C2=AE 2.4GHz Transceiver v9.0 Mouse: SYN_DROPPED even=
t -=20
some input events have been lost.
M=C3=A4r 18 12:51:36 obelix systemd[1]: Starting Load/Save RF Kill Switch=
=20
Status...
M=C3=A4r 18 12:51:36 obelix bluetoothd[863]: Endpoint unregistered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
M=C3=A4r 18 12:51:36 obelix systemd[1]: Started Load/Save RF Kill Switch =
Status.
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
EDID vendor "AUO", prod id 18333
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Using hsync ranges from config file
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Using vrefresh ranges from config file
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Printing DDC gathered Modelines:
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Modeline "1920x1080"x0.0  306.73  1920 1968 2000 2102  1080 1090 1095=20
1216 -hsync -vsync (145.9 kHz eP)
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Modeline "1920x1080"x0.0  122.70  1920 1968 2000 2102  1080 1090 1095=20
1216 -hsync -vsync (58.4 kHz e)
M=C3=A4r 18 12:51:36 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Bluetooth.
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (--) AMDGPU(G0)=
:=20
HDMI max TMDS frequency 300000KHz
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
EDID vendor "AUO", prod id 18333
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Using hsync ranges from config file
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Using vrefresh ranges from config file
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Printing DDC gathered Modelines:
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Modeline "1920x1080"x0.0  306.73  1920 1968 2000 2102  1080 1090 1095=20
1216 -hsync -vsync (145.9 kHz eP)
M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Modeline "1920x1080"x0.0  122.70  1920 1968 2000 2102  1080 1090 1095=20
1216 -hsync -vsync (58.4 kHz e)
M=C3=A4r 18 12:51:36 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
M=C3=A4r 18 12:51:36 obelix blueman.desktop[1725]: blueman-applet 12.51.3=
6=20
WARNING  DiscvManager:109 update_menuitems: warning: Adapter is None
M=C3=A4r 18 12:51:36 obelix systemd-sleep[2000]: System resumed.
M=C3=A4r 18 12:51:36 obelix systemd[1]: systemd-suspend.service: Succeede=
d.
M=C3=A4r 18 12:51:36 obelix kernel: PM: suspend exit
M=C3=A4r 18 12:51:36 obelix systemd[1]: Finished Suspend.
M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D"=
systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D"=
systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Sleep.
M=C3=A4r 18 12:51:36 obelix systemd[1]: Reached target Suspend.
M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Suspend.
M=C3=A4r 18 12:51:36 obelix systemd-logind[868]: Operation 'sleep' finish=
ed.
M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130=20
audit(1616068296.540:96): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967=
295=20
msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd"=20
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1131=20
audit(1616068296.540:97): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967=
295=20
msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd/sy=
stemd"=20
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.5437=
]=20
manager: sleep: wake requested (sleeping: yes  enabled: yes)
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.5439=
]=20
device (enp5s0): state change: activated -> unmanaged (reason=20
'sleeping', sys-iface-state: 'managed')
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.5874=
]=20
dhcp4 (enp5s0): canceled DHCP transaction
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.5875=
]=20
dhcp4 (enp5s0): state changed bound -> done
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.6011=
]=20
manager: NetworkManager state is now CONNECTED_GLOBAL
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Bootloader revision =
0.3=20
build 0 week 24 2017
M=C3=A4r 18 12:51:36 obelix systemd[1]: Reached target Bluetooth.
M=C3=A4r 18 12:51:36 obelix systemd[1335]: Reached target Bluetooth.
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Device revision is 1=

M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Secure boot is enabl=
ed
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: OTP lock is enabled
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: API lock is enabled
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Debug lock is disabl=
ed
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Minimum firmware bui=
ld 1=20
week 10 2014
M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Found device firmwar=
e:=20
intel/ibt-20-1-3.sfi
M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Supervising 3 threads of =
1=20
processes of 1 users.
M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Successfully made thread =
2118=20
of process 1497 owned by '1000' RT at priority 5.
M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Supervising 4 threads of =
1=20
processes of 1 users.
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.7372=
]=20
manager: NetworkManager state is now DISCONNECTED
M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.7385=
]=20
device (enp5s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 12:51:36 obelix dbus-daemon[865]: [system] Activating via=20
systemd: service name=3D'org.freedesktop.nm_dispatcher'=20
unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.2'=20
(uid=3D0 pid=3D866 comm=3D"/usr/bin/NetworkManager --no-daemon ")
M=C3=A4r 18 12:51:36 obelix systemd[1]: Starting Network Manager Script=20
Dispatcher Service...
M=C3=A4r 18 12:51:36 obelix dbus-daemon[865]: [system] Successfully activ=
ated=20
service 'org.freedesktop.nm_dispatcher'
M=C3=A4r 18 12:51:36 obelix systemd[1]: Started Network Manager Script=20
Dispatcher Service.
M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:36 obelix kernel: enp5s0: 0xffffb20a00665000,=20
00:d8:61:e6:48:1c, IRQ 61
M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130=20
audit(1616068296.746:98): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967=
295=20
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0012=
]=20
device (wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0022=
]=20
device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0867=
]=20
device (wlp4s0): supplicant interface state: internal-starting ->=20
disconnected
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0867=
]=20
device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reason=20
'removed', sys-iface-state: 'removed')
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0875=
]=20
Wi-Fi P2P device controlled by interface wlp4s0 created
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0881=
]=20
manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device=20
(/org/freedesktop/NetworkManager/Devices/5)
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0886=
]=20
device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0896=
]=20
device (wlp4s0): state change: unavailable -> disconnected (reason=20
'supplicant-available', sys-iface-state: 'managed')
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.0908=
]=20
device (p2p-dev-wlp4s0): state change: unavailable -> disconnected=20
(reason 'none', sys-iface-state: 'managed')
M=C3=A4r 18 12:51:37 obelix gnome-shell[1496]: Removing a network device =
that=20
was not added
M=C3=A4r 18 12:51:37 obelix gnome-shell[1496]: Removing a network device =
that=20
was not added
M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <warn>  [1616068297.1007=
]=20
sup-iface[2b6336e7b4770113,1,wlp4s0]: call-p2p-cancel: failed with P2P=20
cancel failed
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Waiting for firmware=
=20
download to complete
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Firmware loaded in=20
1486688 usecs
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Waiting for device t=
o boot
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Device booted in 159=
71 usecs
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Found Intel DDC=20
parameters: intel/ibt-20-1-3.ddc
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Applying Intel DDC=20
parameters completed
M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Firmware revision 0.=
0=20
build 121 week 7 2021
M=C3=A4r 18 12:51:38 obelix bluetoothd[863]: Endpoint registered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
M=C3=A4r 18 12:51:38 obelix bluetoothd[863]: Endpoint registered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
M=C3=A4r 18 12:51:40 obelix kernel: r8168: enp5s0: link up
M=C3=A4r 18 12:51:40 obelix kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp5s0=
:=20
link becomes ready
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0571=
]=20
device (enp5s0): carrier: link connected
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0582=
]=20
device (enp5s0): state change: unavailable -> disconnected (reason=20
'carrier-changed', sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0609=
]=20
policy: auto-activating connection 'Kabelgebundene Verbindung 1'=20
(c38c81cb-d88f-4897-9ece-659d13774b9a)
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0620=
]=20
device (enp5s0): Activation: starting connection 'Kabelgebundene=20
Verbindung 1' (c38c81cb-d88f-4897-9ece-659d13774b9a)
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0622=
]=20
device (enp5s0): state change: disconnected -> prepare (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0628=
]=20
manager: NetworkManager state is now CONNECTING
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0632=
]=20
device (enp5s0): state change: prepare -> config (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0645=
]=20
device (enp5s0): state change: config -> ip-config (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0650=
]=20
dhcp4 (enp5s0): activation: beginning transaction (timeout in 45 seconds)=

M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0953=
]=20
dhcp4 (enp5s0): state changed unknown -> bound, address=3D192.168.1.1
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0973=
]=20
device (enp5s0): state change: ip-config -> ip-check (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.0997=
]=20
device (enp5s0): state change: ip-check -> secondaries (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.1000=
]=20
device (enp5s0): state change: secondaries -> activated (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.1007=
]=20
manager: NetworkManager state is now CONNECTED_LOCAL
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.1023=
]=20
manager: NetworkManager state is now CONNECTED_SITE
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.1025=
]=20
policy: set 'Kabelgebundene Verbindung 1' (enp5s0) as default for IPv4=20
routing and DNS
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.1099=
]=20
device (enp5s0): Activation: successful, device activated.
M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.2198=
]=20
manager: NetworkManager state is now CONNECTED_GLOBAL
M=C3=A4r 18 12:51:40 obelix wpa_supplicant[954]: wlp4s0:=20
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
M=C3=A4r 18 12:51:41 obelix systemd[1]: systemd-rfkill.service: Succeeded=
=2E
M=C3=A4r 18 12:51:41 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"s=
ystemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:51:41 obelix kernel: audit: type=3D1131=20
audit(1616068301.630:99): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967=
295=20
msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd"=20
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix gdm-password][2147]: gkr-pam: unlocked login =
keyring
M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1100=20
audit(1616068304.670:100): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3=20
msg=3D'op=3DPAM:authentication=20
grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyr=
ing=20
acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix add=
r=3D?=20
terminal=3D/dev/tty1 res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix audit[2147]: USER_AUTH pid=3D2147 uid=3D0 aui=
d=3D1000=20
ses=3D3 msg=3D'op=3DPAM:authentication=20
grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyr=
ing=20
acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix add=
r=3D?=20
terminal=3D/dev/tty1 res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix dbus-daemon[865]: [system] Activating via=20
systemd: service name=3D'org.freedesktop.home1'=20
unit=3D'dbus-org.freedesktop.home1.service' requested by ':1.87' (uid=3D0=
=20
pid=3D2147 comm=3D"gdm-session-worker [pam/gdm-password] ")
M=C3=A4r 18 12:51:44 obelix dbus-daemon[865]: [system] Activation via sys=
temd=20
failed for unit 'dbus-org.freedesktop.home1.service': Unit=20
dbus-org.freedesktop.home1.service not found.
M=C3=A4r 18 12:51:44 obelix gdm-password][2147]:=20
pam_systemd_home(gdm-password:account): systemd-homed is not available:=20
Unit dbus-org.freedesktop.home1.service not found.
M=C3=A4r 18 12:51:44 obelix audit[2147]: USER_ACCT pid=3D2147 uid=3D0 aui=
d=3D1000=20
ses=3D3 msg=3D'op=3DPAM:accounting=20
grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"harvey"=20
exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix addr=3D?=20
terminal=3D/dev/tty1 res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1101=20
audit(1616068304.673:101): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3=20
msg=3D'op=3DPAM:accounting grantors=3Dpam_access,pam_unix,pam_permit,pam_=
time=20
acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix add=
r=3D?=20
terminal=3D/dev/tty1 res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix audit[2147]: CRED_REFR pid=3D2147 uid=3D0 aui=
d=3D1000=20
ses=3D3 msg=3D'op=3DPAM:setcred=20
grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyr=
ing=20
acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix add=
r=3D?=20
terminal=3D/dev/tty1 res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1110=20
audit(1616068304.676:102): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3=20
msg=3D'op=3DPAM:setcred=20
grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyr=
ing=20
acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix add=
r=3D?=20
terminal=3D/dev/tty1 res=3Dsuccess'
M=C3=A4r 18 12:51:44 obelix gnome-shell[1496]: loading default theme (Adw=
aita)
M=C3=A4r 18 12:51:45 obelix dbus-daemon[865]: [system] Activating via=20
systemd: service name=3D'org.freedesktop.hostname1'=20
unit=3D'dbus-org.freedesktop.hostname1.service' requested by ':1.51'=20
(uid=3D1000 pid=3D1496 comm=3D"/usr/bin/gnome-shell ")
M=C3=A4r 18 12:51:45 obelix audit: BPF prog-id=3D25 op=3DLOAD
M=C3=A4r 18 12:51:45 obelix audit: BPF prog-id=3D26 op=3DLOAD
M=C3=A4r 18 12:51:45 obelix systemd[1]: Starting Hostname Service...
M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1334=20
audit(1616068305.143:103): prog-id=3D25 op=3DLOAD
M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1334=20
audit(1616068305.143:104): prog-id=3D26 op=3DLOAD
M=C3=A4r 18 12:51:45 obelix dbus-daemon[865]: [system] Successfully activ=
ated=20
service 'org.freedesktop.hostname1'
M=C3=A4r 18 12:51:45 obelix systemd[1]: Started Hostname Service.
M=C3=A4r 18 12:51:45 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1130=20
audit(1616068305.213:105): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Usage of object.actor is=20
deprecated for ClipboardIndicator
=20
get@resource:///org/gnome/shell/ui/environment.js:317:29
=20
_init@/home/harvey/.local/share/gnome-shell/extensions/clipboard-indicato=
r@tudmotu.com/extension.js:93:9
=20
wrapper@resource:///org/gnome/gjs/modules/script/_legacy.js:82:27
=20
enable@/home/harvey/.local/share/gnome-shell/extensions/clipboard-indicat=
or@tudmotu.com/extension.js:877:26
=20
_callExtensionEnable@resource:///org/gnome/shell/ui/extensionSystem.js:16=
7:32
=20
_enableAllExtensions/<@resource:///org/gnome/shell/ui/extensionSystem.js:=
601:22
=20
_enableAllExtensions@resource:///org/gnome/shell/ui/extensionSystem.js:60=
0:37
=20
_sessionUpdated@resource:///org/gnome/shell/ui/extensionSystem.js:628:18
=20
_emit@resource:///org/gnome/gjs/modules/core/_signals.js:133:47
=20
_sync@resource:///org/gnome/shell/ui/sessionMode.js:195:14
=20
popMode@resource:///org/gnome/shell/ui/sessionMode.js:163:14
=20
_continueDeactivate@resource:///org/gnome/shell/ui/screenShield.js:510:30=

=20
deactivate/<@resource:///org/gnome/shell/ui/screenShield.js:501:44
=20
finish@resource:///org/gnome/shell/gdm/authPrompt.js:528:13
=20
finish@resource:///org/gnome/shell/ui/unlockDialog.js:870:26
=20
deactivate@resource:///org/gnome/shell/ui/screenShield.js:501:26
=20
ScreenShield/</<@resource:///org/gnome/shell/ui/screenShield.js:109:57
=20
_emit@resource:///org/gnome/gjs/modules/core/_signals.js:133:47
=20
_convertToNativeSignal@resource:///org/gnome/gjs/modules/core/overrides/G=
io.js:169:19
M=C3=A4r 18 12:51:45 obelix NetworkManager[866]: <info>  [1616068305.3268=
]=20
agent-manager:=20
agent[a9dc596cf875417d,:1.51/org.gnome.Shell.NetworkAgent/1000]: agent=20
registered
M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Can't update stage views a=
ctor=20
StWidget is on because it needs an allocation.
M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Can't update stage views a=
ctor=20
StWidget is on because it needs an allocation.
M=C3=A4r 18 12:51:45 obelix gsd-usb-protect[1724]: Error calling USBGuard=
=20
DBus to change the protection after a screensaver event:=20
GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name=20
org.usbguard1 was not provided by any .service files
M=C3=A4r 18 12:51:50 obelix systemd[1]: NetworkManager-dispatcher.service=
:=20
Succeeded.
M=C3=A4r 18 12:51:50 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:51:50 obelix kernel: audit: type=3D1131=20
audit(1616068310.133:106): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:52:15 obelix systemd[1]: systemd-hostnamed.service: Succee=
ded.
M=C3=A4r 18 12:52:15 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1131=20
audit(1616068335.350:107): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 12:52:15 obelix audit: BPF prog-id=3D26 op=3DUNLOAD
M=C3=A4r 18 12:52:15 obelix audit: BPF prog-id=3D25 op=3DUNLOAD
M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1334=20
audit(1616068335.470:108): prog-id=3D26 op=3DUNLOAD
M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1334=20
audit(1616068335.470:109): prog-id=3D25 op=3DUNLOAD
M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.6125=
]=20
manager: sleep: sleep requested (sleeping: no  enabled: yes)
M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.6130=
]=20
device (wlp4s0): state change: disconnected -> unmanaged (reason=20
'sleeping', sys-iface-state: 'managed')
M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.6174=
]=20
device (p2p-dev-wlp4s0): state change: disconnected -> unmanaged (reason =

'sleeping', sys-iface-state: 'managed')
M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.6176=
]=20
manager: NetworkManager state is now ASLEEP
M=C3=A4r 18 12:52:35 obelix wpa_supplicant[954]: nl80211: deinit=20
ifname=3Dp2p-dev-wlp4s0 disabled_11b_rates=3D0
M=C3=A4r 18 12:52:35 obelix wpa_supplicant[954]: nl80211: deinit=20
ifname=3Dwlp4s0 disabled_11b_rates=3D0
M=C3=A4r 18 12:52:36 obelix gnome-shell[1496]:=20
=2E./glib/gobject/gsignal.c:2732: instance '0x560b86fddb50' has no handle=
r=20
with id '16906'
M=C3=A4r 18 12:52:36 obelix gsd-media-keys[1691]: Unable to get default s=
ink
M=C3=A4r 18 12:52:36 obelix gnome-shell[1496]:=20
=2E./glib/gobject/gsignal.c:2732: instance '0x560b861ca0d0' has no handle=
r=20
with id '128700'
M=C3=A4r 18 12:52:40 obelix gsd-usb-protect[1724]: Error calling USBGuard=
=20
DBus to change the protection after a screensaver event:=20
GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name=20
org.usbguard1 was not provided by any .service files
M=C3=A4r 18 12:52:40 obelix systemd[1]: Reached target Sleep.
M=C3=A4r 18 12:52:40 obelix systemd[1]: Starting Hibernate...
M=C3=A4r 18 12:52:40 obelix systemd-sleep[2193]: Suspending system...
M=C3=A4r 18 12:52:40 obelix kernel: PM: hibernation: hibernation entry
M=C3=A4r 18 13:00:43 obelix kernel: Filesystems sync: 0.020 seconds
M=C3=A4r 18 13:00:43 obelix kernel: Freezing user space processes ...=20
(elapsed 0.001 seconds) done.
M=C3=A4r 18 13:00:43 obelix kernel: OOM killer disabled.
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0x00000000-0x00000fff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0x000a0000-0x000fffff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0x09bff000-0x09ffffff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0x0a200000-0x0a20cfff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0xa5fb2000-0xa60a5fff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0xa84ad000-0xa84adfff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0xa9ee7000-0xad5fefff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pages=
:=20
[mem 0xae000000-0xffffffff]
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Basic memory bitmaps=
 created
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Preallocating image =
memory
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Allocated 500589 pag=
es=20
for snapshot
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Allocated 2002356 kb=
ytes=20
in 0.47 seconds (4260.33 MB/s)
M=C3=A4r 18 13:00:43 obelix kernel: Freezing remaining freezable tasks ..=
=2E=20
(elapsed 0.022 seconds) done.
M=C3=A4r 18 13:00:43 obelix kernel: printk: Suspending console(s) (use=20
no_console_suspend to debug)
M=C3=A4r 18 13:00:43 obelix kernel: [drm] free PSP TMR buffer
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: MODE2 re=
set
M=C3=A4r 18 13:00:43 obelix kernel: [drm] free PSP TMR buffer
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: MODE1 re=
set
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU psp =

mode1 reset
M=C3=A4r 18 13:00:43 obelix kernel: [drm] psp mode1 reset succeed
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: interrupt blocked
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: Preparing to enter system sleep=
=20
state S4
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: event blocked
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: EC stopped
M=C3=A4r 18 13:00:43 obelix kernel: PM: Saving platform NVS memory
M=C3=A4r 18 13:00:43 obelix kernel: Disabling non-boot CPUs ...
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 1 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 2 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 3 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 4 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 5 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 6 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 7 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 8 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 9 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 10 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 11 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 12 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 13 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 14 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 15 is now offline
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Creating image:
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Need to copy 498414 =
pages
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Normal pages needed:=
=20
498414 + 1024, available pages: 3537589
M=C3=A4r 18 13:00:43 obelix kernel: PM: Restoring platform NVS memory
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: EC started
M=C3=A4r 18 13:00:43 obelix kernel: LVT offset 0 assigned for vector 0x40=
0
M=C3=A4r 18 13:00:43 obelix kernel: Enabling non-boot CPUs ...
M=C3=A4r 18 13:00:43 obelix kernel: x86: Booting SMP configuration:
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1 A=
PIC 0x1
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU1: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P001: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU1 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 2 A=
PIC 0x2
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU2: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P002: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU2 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 3 A=
PIC 0x3
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU3: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P003: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU3 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 4 A=
PIC 0x4
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU4: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P004: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU4 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 5 A=
PIC 0x5
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU5: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P005: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU5 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 6 A=
PIC 0x6
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU6: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P006: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU6 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 7 A=
PIC 0x7
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU7: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P007: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU7 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 8 A=
PIC 0x8
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU8: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P008: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU8 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 9 A=
PIC 0x9
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU9: patch_level=3D0x0860=
0104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P009: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU9 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 10 =
APIC 0xa
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU10: patch_level=3D0x086=
00104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00A: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU10 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 11 =
APIC 0xb
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU11: patch_level=3D0x086=
00104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00B: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU11 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 12 =
APIC 0xc
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU12: patch_level=3D0x086=
00104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00C: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU12 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 13 =
APIC 0xd
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU13: patch_level=3D0x086=
00104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00D: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU13 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 14 =
APIC 0xe
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU14: patch_level=3D0x086=
00104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00E: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU14 is up
M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 15 =
APIC 0xf
M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU15: patch_level=3D0x086=
00104
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00F: Found 3 idle s=
tates
M=C3=A4r 18 13:00:43 obelix kernel: CPU15 is up
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: Waking up from system sleep sta=
te S4
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: interrupt unblocked
M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: event unblocked
M=C3=A4r 18 13:00:43 obelix kernel: pci 0000:00:00.2: can't derive routin=
g=20
for PCI INT A
M=C3=A4r 18 13:00:43 obelix kernel: pci 0000:00:00.2: PCI INT A: no GSI
M=C3=A4r 18 13:00:43 obelix kernel: usb usb1: root hub lost power or was =
reset
M=C3=A4r 18 13:00:43 obelix kernel: usb usb2: root hub lost power or was =
reset
M=C3=A4r 18 13:00:43 obelix kernel: usb usb3: root hub lost power or was =
reset
M=C3=A4r 18 13:00:43 obelix kernel: usb usb4: root hub lost power or was =
reset
M=C3=A4r 18 13:00:43 obelix kernel: [drm] PCIE GART of 512M enabled (tabl=
e at=20
0x0000008000000000).
M=C3=A4r 18 13:00:43 obelix kernel: [drm] PSP is resuming...
M=C3=A4r 18 13:00:43 obelix kernel: [drm] PCIE GART of 1024M enabled (tab=
le=20
at 0x000000F400900000).
M=C3=A4r 18 13:00:43 obelix kernel: [drm] PSP is resuming...
M=C3=A4r 18 13:00:43 obelix kernel: [drm] reserve 0x400000 from 0xf41f800=
000=20
for PSP TMR
M=C3=A4r 18 13:00:43 obelix kernel: nvme nvme0: Shutdown timeout set to 8=
 seconds
M=C3=A4r 18 13:00:43 obelix kernel: nvme nvme0: 16/0/0 default/read/poll =
queues
M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_v11_0_ring_create [amdgpu]] =

*ERROR* Failed to wait for sOS ready for ring creation
M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_hw_start [amdgpu]] *ERROR* P=
SP=20
create ring failed!
M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_resume [amdgpu]] *ERROR* PSP=
=20
resume failed
M=C3=A4r 18 13:00:43 obelix kernel: [drm:amdgpu_device_fw_loading [amdgpu=
]]=20
*ERROR* resume of IP block <psp> failed -62
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu:=20
amdgpu_device_ip_resume failed (-62).
M=C3=A4r 18 13:00:43 obelix kernel: PM: dpm_run_callback():=20
pci_pm_restore+0x0/0xe0 returns -62
M=C3=A4r 18 13:00:43 obelix kernel: PM: Device 0000:03:00.0 failed to res=
tore=20
async: error -62
M=C3=A4r 18 13:00:43 obelix kernel: ata2: SATA link down (SStatus 0 SCont=
rol 300)
M=C3=A4r 18 13:00:43 obelix kernel: ata1: SATA link down (SStatus 0 SCont=
rol 300)
M=C3=A4r 18 13:00:43 obelix kernel: usb 4-1: reset SuperSpeed Gen 1 USB=20
device number 2 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1: reset high-speed USB device =

number 2 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAS:=20
optional ras ta ucode is not available
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAP:=20
optional rap ta ucode is not available
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=20
resuming...
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: dpm has =
been=20
disabled
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=20
resumed successfully!
M=C3=A4r 18 13:00:43 obelix kernel: usb 3-3: reset full-speed USB device =

number 3 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
M=C3=A4r 18 13:00:43 obelix kernel: [drm] DMUB hardware initialized:=20
version=3D0x01000000
M=C3=A4r 18 13:00:43 obelix kernel: usb 1-4: reset high-speed USB device =

number 3 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: [drm] VCN decode and encode initializ=
ed=20
successfully(under DPG Mode).
M=C3=A4r 18 13:00:43 obelix kernel: [drm] JPEG decode initialized success=
fully.
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring gfx=
=20
uses VM inv eng 0 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.0.0 uses VM inv eng 1 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.1.0 uses VM inv eng 4 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.2.0 uses VM inv eng 5 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.3.0 uses VM inv eng 6 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.0.1 uses VM inv eng 7 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.1.1 uses VM inv eng 8 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.2.1 uses VM inv eng 9 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
comp_1.3.1 uses VM inv eng 10 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
kiq_2.1.0 uses VM inv eng 11 on hub 0
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring sdm=
a0=20
uses VM inv eng 0 on hub 1
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn=
_dec=20
uses VM inv eng 1 on hub 1
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
vcn_enc0 uses VM inv eng 4 on hub 1
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
vcn_enc1 uses VM inv eng 5 on hub 1
M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring=20
jpeg_dec uses VM inv eng 6 on hub 1
M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1: reset high-speed USB device =

number 2 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1.2: reset high-speed USB devic=
e=20
number 4 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1.3: reset high-speed USB devic=
e=20
number 5 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 4-1.4: reset SuperSpeed Gen 1 USB=
=20
device number 3 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.2: reset full-speed USB devic=
e=20
number 4 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.3: reset full-speed USB devic=
e=20
number 5 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.4: reset high-speed USB devic=
e=20
number 6 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.4.1: reset full-speed USB dev=
ice=20
number 7 using xhci_hcd
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Basic memory bitmaps=
 freed
M=C3=A4r 18 13:00:43 obelix kernel: OOM killer enabled.
M=C3=A4r 18 13:00:43 obelix kernel: Restarting tasks ... done.
M=C3=A4r 18 13:00:43 obelix kernel: thermal thermal_zone1: failed to read=
 out=20
thermal zone (-61)
M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130=20
audit(1616068843.306:110): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd"=20
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"s=
ystemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 13:00:43 obelix bluetoothd[863]: Endpoint unregistered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
M=C3=A4r 18 13:00:43 obelix systemd[1]: Starting Load/Save RF Kill Switch=
=20
Status...
M=C3=A4r 18 13:00:43 obelix blueman.desktop[1725]: blueman-applet 13.00.4=
3=20
WARNING  DiscvManager:75 on_adapter_removed: Warning: adapter is None
M=C3=A4r 18 13:00:43 obelix bluetoothd[863]: Endpoint unregistered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
M=C3=A4r 18 13:00:43 obelix systemd[1]: Started Load/Save RF Kill Switch =
Status.
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
EDID vendor "AUO", prod id 18333
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Using hsync ranges from config file
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Using vrefresh ranges from config file
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Printing DDC gathered Modelines:
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Modeline "1920x1080"x0.0  306.73  1920 1968 2000 2102  1080 1090 1095=20
1216 -hsync -vsync (145.9 kHz eP)
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0):=
=20
Modeline "1920x1080"x0.0  122.70  1920 1968 2000 2102  1080 1090 1095=20
1216 -hsync -vsync (58.4 kHz e)
M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (--) AMDGPU(G0)=
:=20
HDMI max TMDS frequency 300000KHz
M=C3=A4r 18 13:00:43 obelix systemd[1335]: Stopped target Bluetooth.
M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Bluetooth.
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.3/usb1/1-1
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.3/usb1/1-1
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.2
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1/4-1.4
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.2
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1/4-1.4
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4/3-1.4.1
M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add o=
n=20
/sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4/3-1.4.1
M=C3=A4r 18 13:00:43 obelix systemd-sleep[2193]: System resumed.
M=C3=A4r 18 13:00:43 obelix systemd[1]: systemd-hibernate.service: Succee=
ded.
M=C3=A4r 18 13:00:43 obelix systemd[1]: Finished Hibernate.
M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 13:00:43 obelix systemd[1]: Reached target Hibernate.
M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: hibernation exit
M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130=20
audit(1616068843.413:111): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1131=20
audit(1616068843.413:112): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Sleep.
M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Hibernate.
M=C3=A4r 18 13:00:43 obelix systemd-logind[868]: Operation 'sleep' finish=
ed.
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.4204=
]=20
manager: sleep: wake requested (sleeping: yes  enabled: yes)
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.4205=
]=20
device (enp5s0): state change: activated -> unmanaged (reason=20
'sleeping', sys-iface-state: 'managed')
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.4357=
]=20
dhcp4 (enp5s0): canceled DHCP transaction
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.4358=
]=20
dhcp4 (enp5s0): state changed bound -> done
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.4476=
]=20
manager: NetworkManager state is now CONNECTED_GLOBAL
M=C3=A4r 18 13:00:43 obelix systemd[1]: Reached target Bluetooth.
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Bootloader revision =
0.3=20
build 0 week 24 2017
M=C3=A4r 18 13:00:43 obelix systemd[1335]: Reached target Bluetooth.
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Device revision is 1=

M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Secure boot is enabl=
ed
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: OTP lock is enabled
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: API lock is enabled
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Debug lock is disabl=
ed
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Minimum firmware bui=
ld 1=20
week 10 2014
M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Found device firmwar=
e:=20
intel/ibt-20-1-3.sfi
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.6012=
]=20
manager: NetworkManager state is now DISCONNECTED
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.6027=
]=20
device (enp5s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 13:00:43 obelix dbus-daemon[865]: [system] Activating via=20
systemd: service name=3D'org.freedesktop.nm_dispatcher'=20
unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.2'=20
(uid=3D0 pid=3D866 comm=3D"/usr/bin/NetworkManager --no-daemon ")
M=C3=A4r 18 13:00:43 obelix systemd[1]: Starting Network Manager Script=20
Dispatcher Service...
M=C3=A4r 18 13:00:43 obelix dbus-daemon[865]: [system] Successfully activ=
ated=20
service 'org.freedesktop.nm_dispatcher'
M=C3=A4r 18 13:00:43 obelix systemd[1]: Started Network Manager Script=20
Dispatcher Service.
M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 13:00:43 obelix kernel: enp5s0: 0xffffb20a00665000,=20
00:d8:61:e6:48:1c, IRQ 61
M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130=20
audit(1616068843.610:113): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Supervising 3 threads of =
1=20
processes of 1 users.
M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Successfully made thread =
2283=20
of process 1497 owned by '1000' RT at priority 5.
M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Supervising 4 threads of =
1=20
processes of 1 users.
M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.8678=
]=20
device (wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 13:00:44 obelix NetworkManager[866]: <info>  [1616068844.1282=
]=20
device (wlp4s0): set-hw-addr: set MAC address to 8E:7C:CA:62:5B:A4=20
(scanning)
M=C3=A4r 18 13:00:44 obelix NetworkManager[866]: <info>  [1616068844.3776=
]=20
device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 13:00:45 obelix kernel: [drm] Failed to add display topology,=
 DTM=20
TA is not initialized.
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Waiting for firmware=
=20
download to complete
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Firmware loaded in=20
1607510 usecs
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Waiting for device t=
o boot
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Device booted in 159=
15 usecs
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Found Intel DDC=20
parameters: intel/ibt-20-1-3.ddc
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Applying Intel DDC=20
parameters completed
M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Firmware revision 0.=
0=20
build 121 week 7 2021
M=C3=A4r 18 13:00:45 obelix bluetoothd[863]: Endpoint registered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
M=C3=A4r 18 13:00:45 obelix bluetoothd[863]: Endpoint registered:=20
sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
M=C3=A4r 18 13:00:46 obelix kernel: r8168: enp5s0: link up
M=C3=A4r 18 13:00:46 obelix kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp5s0=
:=20
link becomes ready
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3109=
]=20
device (enp5s0): carrier: link connected
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3120=
]=20
device (enp5s0): state change: unavailable -> disconnected (reason=20
'carrier-changed', sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3160=
]=20
device (wlp4s0): supplicant interface state: internal-starting ->=20
disconnected
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3160=
]=20
device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reason=20
'removed', sys-iface-state: 'removed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3171=
]=20
Wi-Fi P2P device controlled by interface wlp4s0 created
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3177=
]=20
manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device=20
(/org/freedesktop/NetworkManager/Devices/6)
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3182=
]=20
device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=20
'managed', sys-iface-state: 'external')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3194=
]=20
policy: auto-activating connection 'Kabelgebundene Verbindung 1'=20
(c38c81cb-d88f-4897-9ece-659d13774b9a)
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3201=
]=20
device (enp5s0): Activation: starting connection 'Kabelgebundene=20
Verbindung 1' (c38c81cb-d88f-4897-9ece-659d13774b9a)
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3201=
]=20
device (wlp4s0): state change: unavailable -> disconnected (reason=20
'supplicant-available', sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3209=
]=20
device (p2p-dev-wlp4s0): state change: unavailable -> disconnected=20
(reason 'none', sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3214=
]=20
device (enp5s0): state change: disconnected -> prepare (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3220=
]=20
manager: NetworkManager state is now CONNECTING
M=C3=A4r 18 13:00:48 obelix gnome-shell[1496]: Removing a network device =
that=20
was not added
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3222=
]=20
device (enp5s0): state change: prepare -> config (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix gnome-shell[1496]: Removing a network device =
that=20
was not added
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3233=
]=20
device (enp5s0): state change: config -> ip-config (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3236=
]=20
dhcp4 (enp5s0): activation: beginning transaction (timeout in 45 seconds)=

M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3549=
]=20
dhcp4 (enp5s0): state changed unknown -> bound, address=3D192.168.1.1
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <warn>  [1616068848.3554=
]=20
sup-iface[11828c54025c5ecd,2,wlp4s0]: call-p2p-cancel: failed with P2P=20
cancel failed
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3570=
]=20
device (enp5s0): state change: ip-config -> ip-check (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3606=
]=20
device (enp5s0): state change: ip-check -> secondaries (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3609=
]=20
device (enp5s0): state change: secondaries -> activated (reason 'none',=20
sys-iface-state: 'managed')
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3616=
]=20
manager: NetworkManager state is now CONNECTED_LOCAL
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3629=
]=20
manager: NetworkManager state is now CONNECTED_SITE
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3631=
]=20
policy: set 'Kabelgebundene Verbindung 1' (enp5s0) as default for IPv4=20
routing and DNS
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.3701=
]=20
device (enp5s0): Activation: successful, device activated.
M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.4835=
]=20
manager: NetworkManager state is now CONNECTED_GLOBAL
M=C3=A4r 18 13:00:48 obelix systemd[1]: systemd-rfkill.service: Succeeded=
=2E
M=C3=A4r 18 13:00:48 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"s=
ystemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
M=C3=A4r 18 13:00:48 obelix kernel: audit: type=3D1131=20
audit(1616068848.603:114): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd"=20
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
M=C3=A4r 18 13:00:51 obelix wpa_supplicant[954]: wlp4s0:=20
CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail=20
[amdgpu]] *ERROR* Waiting for fences timed out!
M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]=20
*ERROR* ring sdma0 timeout, signaled seq=3D552, emitted seq=3D554
M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]=20
*ERROR* Process information: process  pid 0 thread  pid 0
M=C3=A4r 18 13:00:54 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU rese=
t begin!
M=C3=A4r 18 13:00:54 obelix kernel: BUG: kernel NULL pointer dereference,=
=20
address: 0000000000000029
M=C3=A4r 18 13:00:54 obelix kernel: #PF: supervisor read access in kernel=
 mode
M=C3=A4r 18 13:00:54 obelix kernel: #PF: error_code(0x0000) - not-present=
 page
M=C3=A4r 18 13:00:54 obelix kernel: PGD 0 P4D 0
M=C3=A4r 18 13:00:54 obelix kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
M=C3=A4r 18 13:00:54 obelix kernel: CPU: 9 PID: 1327 Comm: kworker/9:3=20
Tainted: G           OE     5.11.7-arch1-1 #1
M=C3=A4r 18 13:00:54 obelix kernel: Hardware name: Micro-Star Internation=
al=20
Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
M=C3=A4r 18 13:00:54 obelix kernel: Workqueue: events drm_sched_job_timed=
out=20
[gpu_sched]
M=C3=A4r 18 13:00:54 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/0xf=
0=20
[amdgpu]
M=C3=A4r 18 13:00:54 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 84 c=
0 0f=20
84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48=20
8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00=20
48 8b 7f 08 4c
M=C3=A4r 18 13:00:54 obelix kernel: RSP: 0018:ffffb20a04a27d40 EFLAGS: 00=
010246
M=C3=A4r 18 13:00:54 obelix kernel: RAX: 0000000000000001 RBX:=20
ffff9e0c825c4000 RCX: 000000008080007c
M=C3=A4r 18 13:00:54 obelix kernel: RDX: 000000008080007d RSI:=20
0000000000000001 RDI: ffff9e0c8a97f2c0
M=C3=A4r 18 13:00:54 obelix kernel: RBP: ffff9e0c8a97f2c0 R08:=20
0000000000000001 R09: 0000000000000000
M=C3=A4r 18 13:00:54 obelix kernel: R10: 0000000000000001 R11:=20
ffffffffb54cba00 R12: ffff9e0c825c40d0
M=C3=A4r 18 13:00:54 obelix kernel: R13: ffff9e0c8cf80000 R14:=20
ffff9e0c81489000 R15: ffff9e0c814890c8
M=C3=A4r 18 13:00:54 obelix kernel: FS:  0000000000000000(0000)=20
GS:ffff9e0f9f840000(0000) knlGS:0000000000000000
M=C3=A4r 18 13:00:54 obelix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029 CR3:=20
0000000228210000 CR4: 0000000000350ee0
M=C3=A4r 18 13:00:54 obelix kernel: Call Trace:
M=C3=A4r 18 13:00:54 obelix kernel:  stop_cpsch+0xa0/0xc0 [amdgpu]
M=C3=A4r 18 13:00:54 obelix kernel:  kgd2kfd_suspend.part.0+0x2f/0x40 [am=
dgpu]
M=C3=A4r 18 13:00:54 obelix kernel:  kgd2kfd_pre_reset+0x3f/0x50 [amdgpu]=

M=C3=A4r 18 13:00:54 obelix kernel:=20
amdgpu_device_gpu_recover.cold+0x36e/0x95d [amdgpu]
M=C3=A4r 18 13:00:54 obelix kernel:  amdgpu_job_timedout+0x121/0x140 [amd=
gpu]
M=C3=A4r 18 13:00:54 obelix kernel:  drm_sched_job_timedout+0x64/0xe0 [gp=
u_sched]
M=C3=A4r 18 13:00:54 obelix kernel:  process_one_work+0x214/0x3e0
M=C3=A4r 18 13:00:54 obelix kernel:  worker_thread+0x4d/0x3d0
M=C3=A4r 18 13:00:54 obelix kernel:  ? rescuer_thread+0x3c0/0x3c0
M=C3=A4r 18 13:00:54 obelix kernel:  kthread+0x133/0x150
M=C3=A4r 18 13:00:54 obelix kernel:  ? __kthread_bind_mask+0x60/0x60
M=C3=A4r 18 13:00:54 obelix kernel:  ret_from_fork+0x22/0x30
M=C3=A4r 18 13:00:54 obelix kernel: Modules linked in: rfcomm=20
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic=20
ledtrig_audio cmac algif_hash algif_skcipher af_alg snd_hda_intel=20
snd_intel_dspcfg soundwire_intel soundwire_generic_allocation bnep=20
soundwire_cadence snd_hda_codec iwlmvm snd_hda_core nls_iso8859_1=20
snd_hwdep vfat intel_rapl_msr intel_rapl_common soundwire_bus fat=20
hid_multitouch gpio_keys snd_soc_core btusb mac80211 edac_mce_amd=20
kvm_amd libarc4 uvcvideo snd_compress btrtl ac97_bus btbcm iwlwifi=20
pktcdvd snd_pcm_dmaengine videobuf2_vmalloc kvm btintel videobuf2_memops =

snd_pcm videobuf2_v4l2 bluetooth videobuf2_common videodev joydev=20
snd_timer mousedev irqbypass ecdh_generic msi_wmi mc ecc cfg80211 rapl=20
psmouse pcspkr sparse_keymap snd k10temp i2c_piix4 snd_rn_pci_acp3x=20
snd_pci_acp3x soundcore rfkill i2c_hid tpm_crb acpi_cpufreq tpm_tis=20
mac_hid soc_button_array pinctrl_amd tpm_tis_core vboxnetflt(OE)=20
vboxnetadp(OE) vboxdrv(OE) usbip_host usbip_core sg fuse crypto_user=20
bpf_preload ip_tables
M=C3=A4r 18 13:00:54 obelix kernel:  x_tables ext4 crc32c_generic crc16=20
mbcache jbd2 sr_mod cdrom uas usb_storage dm_crypt cbc encrypted_keys=20
dm_mod trusted tpm crct10dif_pclmul crc32_pclmul crc32c_intel=20
ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ccp=20
serio_raw xhci_pci rng_core xhci_pci_renesas wmi video usbhid r8168(OE)=20
amdgpu drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper=20
syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm agpgart
M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029
M=C3=A4r 18 13:00:54 obelix kernel: ---[ end trace ff2438cc3b9cd967 ]---
M=C3=A4r 18 13:00:54 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/0xf=
0=20
[amdgpu]
M=C3=A4r 18 13:00:54 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 84 c=
0 0f=20
84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48=20
8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00=20
48 8b 7f 08 4c
M=C3=A4r 18 13:00:54 obelix kernel: RSP: 0018:ffffb20a04a27d40 EFLAGS: 00=
010246
M=C3=A4r 18 13:00:54 obelix kernel: RAX: 0000000000000001 RBX:=20
ffff9e0c825c4000 RCX: 000000008080007c
M=C3=A4r 18 13:00:54 obelix kernel: RDX: 000000008080007d RSI:=20
0000000000000001 RDI: ffff9e0c8a97f2c0
M=C3=A4r 18 13:00:54 obelix kernel: RBP: ffff9e0c8a97f2c0 R08:=20
0000000000000001 R09: 0000000000000000
M=C3=A4r 18 13:00:54 obelix kernel: R10: 0000000000000001 R11:=20
ffffffffb54cba00 R12: ffff9e0c825c40d0
M=C3=A4r 18 13:00:54 obelix kernel: R13: ffff9e0c8cf80000 R14:=20
ffff9e0c81489000 R15: ffff9e0c814890c8
M=C3=A4r 18 13:00:54 obelix kernel: FS:  0000000000000000(0000)=20
GS:ffff9e0f9f840000(0000) knlGS:0000000000000000
M=C3=A4r 18 13:00:54 obelix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:=20
0000000080050033
M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029 CR3:=20
00000001083b8000 CR4: 0000000000350ee0
M=C3=A4r 18 13:00:54 obelix /usr/lib/gdm-x-session[1352]: (II) event7  - =

Microsoft Microsoft=C2=AE 2.4GHz Transceiver v9.0 Mouse: SYN_DROPPED even=
t -=20
some input events have been lost.
M=C3=A4r 18 13:00:58 obelix systemd[1]: NetworkManager-dispatcher.service=
:=20
Succeeded.
M=C3=A4r 18 13:00:58 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0=20
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r=20
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=20
terminal=3D? res=3Dsuccess'
M=C3=A4r 18 13:00:58 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail=20
[amdgpu]] *ERROR* Waiting for fences timed out!
M=C3=A4r 18 13:00:58 obelix kernel: audit: type=3D1131=20
audit(1616068858.453:115): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D429496=
7295=20
msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"=20
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'

Do I still have to apply the patches you mentioned against a vanilla=20
kernel and, if so, to which - 5.7.11 or 5.12-rc3?

Greetings
Harvey


--oyj3uzet55VVAXcvPGEVw2XoswB0MDptB--

--UvdCnPcyWlt7Wa8GhpBO06kwUTbLBGl4F
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRSRNvmxYqoNs6vm0SLlqqYsFRKCQUCYFNEzQUDAAAAAAAKCRCLlqqYsFRKCS5n
AJ40EfUc0GETwTUsV+gOkS2z7vucnwCdHNMohMmC1j2tavv36cgQYxOuAJc=
=Sul1
-----END PGP SIGNATURE-----

--UvdCnPcyWlt7Wa8GhpBO06kwUTbLBGl4F--

--===============0040233847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0040233847==--
