Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 12:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FAB64F6E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 12:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FAB64F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF0C6E9C2;
	Fri, 19 Mar 2021 12:26:00 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514FF6E9C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1616156753;
 bh=1MoviW2VV181niEy5Wyy/YmITCMY/MwTzr48T9kXd+w=;
 h=X-UI-Sender-Class:Reply-To:To:References:From:Subject:Date:
 In-Reply-To;
 b=PE1BUwfk5f/StTPFkcUYlL3Kt2hbRlvf4Mfhv+Cx20l3M0WNm++fB6/SK9UqFn+o3
 F1AT+HpWovQUSWYcOuupKZ1LRqwHd6GWTfF07nJaz6M1OeavqPamCsXWRKm2gPQopq
 WARQuY0f43Vtaju5TEHOZPoFiYairLgBDZYeY0bM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.1] ([178.27.135.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1lqbzn3ImR-012sUo; Fri, 19
 Mar 2021 13:25:52 +0100
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
 <DM6PR12MB261918E31190A085F3802A6BE4689@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Harvey <harv@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
Message-ID: <6333f594-2228-c79c-aaad-1bc588bbf92d@gmx.de>
Date: Fri, 19 Mar 2021 13:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB261918E31190A085F3802A6BE4689@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Provags-ID: V03:K1:0KPAiq+YgYZuie8QhCzV/eDuBRTjP3bkfwKEo+2vU/k7Pn8Tipt
 8j4a7teJuB6kRk2VSq7aLwI2NRalPf6fOJszML6LfuoMEeg6gPv0iUKO6k5CljHWFye4dGG
 e2T8g3b4FcLP4BHVM3bAirNvp3/POs6l1KRFoBo4WEQGQEntOSRAJMHvdIWfAA6Rysph1Ip
 9EonvZEGExeJVdb8O6+Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qHECejSxFvM=:FWhu2ulLS9MXXbFKSw0000
 AOqoUloDfI/iAmHMsSGMkxsSSV4o9fj5NVWrHGgDZCFUhHesiSjKb1VWeTYa3D3deAnf0IiKR
 e6antyEdHUwwaCsxCazMVuZ+b6tPLCOC8LuOSgKpTVVONqez9SORCkAjG3hLr7lJpIl0wTAhD
 l9E30tzlM4di183DL/CmZ7e2fujGtVIN1KzEHyw1V9Qi3cR3KVNVbJc1idSfJsSVTWv+vXaCE
 WMO+LXFv0aD1XpDzX0UmkYNCm6VnYT8DVZTwkRfI2DRIvCFPlMly1XDokEqZ3vpQbvk38OMZS
 OWVo9YVH2vgMBupYxKu8E5Yl+Rgk5Ukk6rxzejVBzHY7jG3v0Xe6x2nEB5wLON75uwvw+Qrga
 Zc4q9bzobJQot/tJVtjSWDqMEqcz1JGvg6QoralRCWusMOLkZpBG4ngecEiClB7tA1xMqVpYl
 fu7upBUkIK/g4T2wLal7lHJWz7ELkMj7ocEHRtcZ7iFTGmNHJQVoN030h+XwuQ17CgzzZ6wUc
 J+ae/p2r7hgECl8VJgMVcjDqM//g7zFvOc+y4JRrqaa6j+9mJCihROQMD6+nI79YnJrocUFVP
 LoygjxnfX2lGfJ34/tHEfVSDjKf/coQaWxYE/ZbPQtrhW4GfO9Ky7nDVQvFfkt7aUw4aQbBdl
 r0WEgX+mD8hZUm5VyDIAGK7sZxAlsW/ooxJdF+law0lYZ8Q17vTxqdmEO8rKoPg/JPKMGHV12
 eArC69GmBMN+1reozTpMkqmbZXIRZKlcW9jB137gRqOmHRpbrLUnGnf/DyHXJ9w2gXsKKn+ER
 JwbhCqapSTsuT376Ljz8JretYZsux7IwYZmssoa3WNBomIyHFcEFPCPo4DDB986s8wWdvXrJx
 Wn/slDCoITwORt5ti1kA==
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
Content-Type: multipart/mixed; boundary="===============0656229528=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0656229528==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sbGfxR1yP2Fp2Vv7ef9PvkaMY4aIomcyS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sbGfxR1yP2Fp2Vv7ef9PvkaMY4aIomcyS
Content-Type: multipart/mixed; boundary="n8NaK535vUqjQW85cOzFPPM56bUCDqviD";
 protected-headers="v1"
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Message-ID: <6333f594-2228-c79c-aaad-1bc588bbf92d@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
 <DM6PR12MB261918E31190A085F3802A6BE4689@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261918E31190A085F3802A6BE4689@DM6PR12MB2619.namprd12.prod.outlook.com>

--n8NaK535vUqjQW85cOzFPPM56bUCDqviD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Evan,

this is a laptop with RENOIR hardware (Ryzen 4800H) and a discrete GPU=20
RX5500. There is an external monitor connected to the HDMI port (which=20
is attached to the iGPU afaict).

I would be happy to test further and help in nailing this one ;)

Greetings
Harey


Am 19.03.21 um 03:10 schrieb Quan, Evan:
> [AMD Public Use]
>=20
> Hi Harvey,
>=20
> Resuming after mode1 reset failed according to the error logs below.
> Also according to the lspci output of last email, it happened for a Nav=
i14 ASIC.
> However, I cannot reproduce that on my desktop platform with 2 x Navi14=
 ASICs.
>=20
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: MODE1 =
reset
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU ps=
p
> mode1 reset
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] psp mode1 reset succeed
> ....
> ...
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_v11_0_ring_create [amdgpu]=
]
> *ERROR* Failed to wait for sOS ready for ring creation
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_hw_start [amdgpu]] *ERROR*=
 PSP
> create ring failed!
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_resume [amdgpu]] *ERROR* P=
SP
> resume failed
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:amdgpu_device_fw_loading [amdg=
pu]]
> *ERROR* resume of IP block <psp> failed -62
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu:
> amdgpu_device_ip_resume failed (-62).
>=20
>=20
> Considering you seemed not running our latest driver according to the c=
omplaint blow. Maybe it's worth to try our latest driver(@Deucher, Alexan=
der where Harvey can get our latest code?).
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: smu dr=
iver
> if version =3D 0x00000036, smu fw if version =3D 0x00000038, smu fw ver=
sion
> =3D 0x00352100 (53.33.0)
>=20
> BR
> Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harv=
ey
> Sent: Thursday, March 18, 2021 8:17 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibe=
rnate
>=20
> Alex,
>=20
> I waited for kernel 5.11.7 to hit our repos yesterday evening and teste=
d
> again:
>=20
> 1. The suspend issue is gone - suspend and resume now work as expected.=

>=20
> 2. System hibernation seems to be a different beast - still freezing
>=20
> When invoking 'systemctl hibernate' the system does not power off (I
> waited for 5 minutes) and I have to hard reset it to start up again. It=

> then tries to resume from the swap partition and comes back up with onl=
y
> the external monitor connected to the HDMI port showing a picture and
> the builtin screen of the laptop staying black. Nevertheless the system=

> is freezed and not responding, neither to mouse or keyboard. After
> another hard reset I managed to get the following log from journalctl
> (only cut the relevant part):
>=20
> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.34=
66]
> manager: sleep: sleep requested (sleeping: no  enabled: yes)
> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.34=
73]
> device (wlp4s0): state change: disconnected -> unmanaged (reason
> 'sleeping', sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.35=
08]
> device (wlp4s0): set-hw-addr: reset MAC address to 14:F6:D8:18:8C:EC
> (unmanage)
> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.35=
75]
> device (p2p-dev-wlp4s0): state change: disconnected -> unmanaged (reaso=
n
> 'sleeping', sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:11 obelix NetworkManager[866]: <info>  [1616068271.35=
80]
> manager: NetworkManager state is now ASLEEP
> M=C3=A4r 18 12:51:11 obelix wpa_supplicant[954]: nl80211: deinit
> ifname=3Dp2p-dev-wlp4s0 disabled_11b_rates=3D0
> M=C3=A4r 18 12:51:11 obelix wpa_supplicant[954]: nl80211: deinit
> ifname=3Dwlp4s0 disabled_11b_rates=3D0
> M=C3=A4r 18 12:51:12 obelix gsd-media-keys[1691]: Unable to get default=
 sink
> M=C3=A4r 18 12:51:15 obelix gnome-shell[1496]:
> ../glib/gobject/gsignal.c:2732: instance '0x560b86c67b50' has no handle=
r
> with id '15070'
> M=C3=A4r 18 12:51:16 obelix gsd-usb-protect[1724]: Error calling USBGua=
rd
> DBus to change the protection after a screensaver event:
> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name
> org.usbguard1 was not provided by any .service files
> M=C3=A4r 18 12:51:16 obelix systemd[1]: Reached target Sleep.
> M=C3=A4r 18 12:51:16 obelix systemd[1]: Starting Suspend...
> M=C3=A4r 18 12:51:16 obelix systemd-sleep[2000]: Suspending system...
> M=C3=A4r 18 12:51:16 obelix kernel: PM: suspend entry (deep)
> M=C3=A4r 18 12:51:16 obelix kernel: Filesystems sync: 0.005 seconds
> M=C3=A4r 18 12:51:36 obelix kernel: Freezing user space processes ...
> (elapsed 0.002 seconds) done.
> M=C3=A4r 18 12:51:36 obelix kernel: OOM killer disabled.
> M=C3=A4r 18 12:51:36 obelix kernel: Freezing remaining freezable tasks =
=2E..
> (elapsed 0.001 seconds) done.
> M=C3=A4r 18 12:51:36 obelix kernel: printk: Suspending console(s) (use
> no_console_suspend to debug)
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] free PSP TMR buffer
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] free PSP TMR buffer
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: interrupt blocked
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Preparing to enter system sle=
ep
> state S3
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: event blocked
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: EC stopped
> M=C3=A4r 18 12:51:36 obelix kernel: PM: Saving platform NVS memory
> M=C3=A4r 18 12:51:36 obelix kernel: Disabling non-boot CPUs ...
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 86: no longer affine to CPU1
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 1 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 87: no longer affine to CPU2
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 2 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 88: no longer affine to CPU3
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 3 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 89: no longer affine to CPU4
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 4 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 90: no longer affine to CPU5
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 5 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 91: no longer affine to CPU6
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 6 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 92: no longer affine to CPU7
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 7 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 93: no longer affine to CPU8
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 8 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 94: no longer affine to CPU9
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 9 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: IRQ 95: no longer affine to CPU10
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 10 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 11 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 12 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 13 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 14 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: CPU 15 is now offline
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Low-level resume complete
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: EC started
> M=C3=A4r 18 12:51:36 obelix kernel: PM: Restoring platform NVS memory
> M=C3=A4r 18 12:51:36 obelix kernel: LVT offset 0 assigned for vector 0x=
400
> M=C3=A4r 18 12:51:36 obelix kernel: Enabling non-boot CPUs ...
> M=C3=A4r 18 12:51:36 obelix kernel: x86: Booting SMP configuration:
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
 APIC 0x1
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU1: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P001: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU1 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 2=
 APIC 0x2
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU2: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P002: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU2 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 3=
 APIC 0x3
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU3: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P003: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU3 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 4=
 APIC 0x4
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU4: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P004: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU4 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 5=
 APIC 0x5
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU5: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P005: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU5 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 6=
 APIC 0x6
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU6: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P006: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU6 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 7=
 APIC 0x7
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU7: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P007: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU7 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 8=
 APIC 0x8
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU8: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P008: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU8 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 9=
 APIC 0x9
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU9: patch_level=3D0x08=
600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P009: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU9 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
0 APIC 0xa
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU10: patch_level=3D0x0=
8600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00A: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU10 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
1 APIC 0xb
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU11: patch_level=3D0x0=
8600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00B: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU11 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
2 APIC 0xc
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU12: patch_level=3D0x0=
8600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00C: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU12 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
3 APIC 0xd
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU13: patch_level=3D0x0=
8600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00D: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU13 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
4 APIC 0xe
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU14: patch_level=3D0x0=
8600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00E: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU14 is up
> M=C3=A4r 18 12:51:36 obelix kernel: smpboot: Booting Node 0 Processor 1=
5 APIC 0xf
> M=C3=A4r 18 12:51:36 obelix kernel: microcode: CPU15: patch_level=3D0x0=
8600104
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: \_SB_.PLTF.P00F: Found 3 idle=
 states
> M=C3=A4r 18 12:51:36 obelix kernel: CPU15 is up
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: Waking up from system sleep s=
tate S3
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: interrupt unblocked
> M=C3=A4r 18 12:51:36 obelix kernel: ACPI: EC: event unblocked
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PCIE GART of 1024M enabled (t=
able
> at 0x000000F400900000).
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PSP is resuming...
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] reserve 0x400000 from 0xf41f8=
00000
> for PSP TMR
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAS:
> optional ras ta ucode is not available
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAP:
> optional rap ta ucode is not available
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=

> resuming...
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: dpm ha=
s been
> disabled
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=

> resumed successfully!
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
> M=C3=A4r 18 12:51:36 obelix kernel: nvme nvme0: Shutdown timeout set to=
 8 seconds
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] DMUB hardware initialized:
> version=3D0x01000000
> M=C3=A4r 18 12:51:36 obelix kernel: usb 3-3: reset full-speed USB devic=
e
> number 3 using xhci_hcd
> M=C3=A4r 18 12:51:36 obelix kernel: nvme nvme0: 16/0/0 default/read/pol=
l queues
> M=C3=A4r 18 12:51:36 obelix kernel: usb 1-4: reset high-speed USB devic=
e
> number 3 using xhci_hcd
> M=C3=A4r 18 12:51:36 obelix kernel: ata2: SATA link down (SStatus 0 SCo=
ntrol 300)
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] VCN decode and encode initial=
ized
> successfully(under DPG Mode).
> M=C3=A4r 18 12:51:36 obelix kernel: ata1: SATA link down (SStatus 0 SCo=
ntrol 300)
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] JPEG decode initialized succe=
ssfully.
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring g=
fx
> uses VM inv eng 0 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.0.0 uses VM inv eng 1 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.1.0 uses VM inv eng 4 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.2.0 uses VM inv eng 5 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.3.0 uses VM inv eng 6 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.0.1 uses VM inv eng 7 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.1.1 uses VM inv eng 8 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.2.1 uses VM inv eng 9 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.3.1 uses VM inv eng 10 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> kiq_2.1.0 uses VM inv eng 11 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring s=
dma0
> uses VM inv eng 0 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring v=
cn_dec
> uses VM inv eng 1 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> vcn_enc0 uses VM inv eng 4 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> vcn_enc1 uses VM inv eng 5 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> jpeg_dec uses VM inv eng 6 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PCIE GART of 512M enabled (ta=
ble at
> 0x0000008000000000).
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] PSP is resuming...
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] reserve 0x900000 from 0x800f4=
00000
> for PSP TMR
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: RAS:
> optional ras ta ucode is not available
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: RAP:
> optional rap ta ucode is not available
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU is=

> resuming...
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: smu dr=
iver
> if version =3D 0x00000036, smu fw if version =3D 0x00000038, smu fw ver=
sion
> =3D 0x00352100 (53.33.0)
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU dr=
iver
> if version not matched
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: SMU is=

> resumed successfully!
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] VCN decode and encode initial=
ized
> successfully(under DPG Mode).
> M=C3=A4r 18 12:51:36 obelix kernel: [drm] JPEG decode initialized succe=
ssfully.
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> gfx_0.0.0 uses VM inv eng 0 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.0.0 uses VM inv eng 1 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.1.0 uses VM inv eng 4 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.2.0 uses VM inv eng 5 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.3.0 uses VM inv eng 6 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.0.1 uses VM inv eng 7 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.1.1 uses VM inv eng 8 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.2.1 uses VM inv eng 9 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> comp_1.3.1 uses VM inv eng 10 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> kiq_2.1.0 uses VM inv eng 11 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring s=
dma0
> uses VM inv eng 12 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring s=
dma1
> uses VM inv eng 13 on hub 0
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring v=
cn_dec
> uses VM inv eng 0 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> vcn_enc0 uses VM inv eng 1 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> vcn_enc1 uses VM inv eng 4 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: amdgpu 0000:03:00.0: amdgpu: ring
> jpeg_dec uses VM inv eng 5 on hub 1
> M=C3=A4r 18 12:51:36 obelix kernel: acpi LNXPOWER:06: Turning OFF
> M=C3=A4r 18 12:51:36 obelix kernel: acpi LNXPOWER:04: Turning OFF
> M=C3=A4r 18 12:51:36 obelix kernel: OOM killer enabled.
> M=C3=A4r 18 12:51:36 obelix kernel: Restarting tasks ... done.
> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130
> audit(1616068296.433:95): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D42949=
67295
> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix bluetoothd[863]: Endpoint unregistered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) event7  =
-
> Microsoft Microsoft=C2=AE 2.4GHz Transceiver v9.0 Mouse: SYN_DROPPED ev=
ent -
> some input events have been lost.
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Starting Load/Save RF Kill Swit=
ch
> Status...
> M=C3=A4r 18 12:51:36 obelix bluetoothd[863]: Endpoint unregistered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Started Load/Save RF Kill Switc=
h Status.
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> EDID vendor "AUO", prod id 18333
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Using hsync ranges from config file
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Using vrefresh ranges from config file
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Printing DDC gathered Modelines:
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Modeline "1920x1080"x0.0  306.73  1920 1968 2000 2102  1080 1090 1095
> 1216 -hsync -vsync (145.9 kHz eP)
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Modeline "1920x1080"x0.0  122.70  1920 1968 2000 2102  1080 1090 1095
> 1216 -hsync -vsync (58.4 kHz e)
> M=C3=A4r 18 12:51:36 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Bluetooth.
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (--) AMDGPU(G=
0):
> HDMI max TMDS frequency 300000KHz
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> EDID vendor "AUO", prod id 18333
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Using hsync ranges from config file
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Using vrefresh ranges from config file
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Printing DDC gathered Modelines:
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Modeline "1920x1080"x0.0  306.73  1920 1968 2000 2102  1080 1090 1095
> 1216 -hsync -vsync (145.9 kHz eP)
> M=C3=A4r 18 12:51:36 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Modeline "1920x1080"x0.0  122.70  1920 1968 2000 2102  1080 1090 1095
> 1216 -hsync -vsync (58.4 kHz e)
> M=C3=A4r 18 12:51:36 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
> M=C3=A4r 18 12:51:36 obelix blueman.desktop[1725]: blueman-applet 12.51=
=2E36
> WARNING  DiscvManager:109 update_menuitems: warning: Adapter is None
> M=C3=A4r 18 12:51:36 obelix systemd-sleep[2000]: System resumed.
> M=C3=A4r 18 12:51:36 obelix systemd[1]: systemd-suspend.service: Succee=
ded.
> M=C3=A4r 18 12:51:36 obelix kernel: PM: suspend exit
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Finished Suspend.
> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D=
"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-suspend comm=3D=
"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Sleep.
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Reached target Suspend.
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Stopped target Suspend.
> M=C3=A4r 18 12:51:36 obelix systemd-logind[868]: Operation 'sleep' fini=
shed.
> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130
> audit(1616068296.540:96): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D42949=
67295
> msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1131
> audit(1616068296.540:97): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D42949=
67295
> msg=3D'unit=3Dsystemd-suspend comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.54=
37]
> manager: sleep: wake requested (sleeping: yes  enabled: yes)
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.54=
39]
> device (enp5s0): state change: activated -> unmanaged (reason
> 'sleeping', sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.58=
74]
> dhcp4 (enp5s0): canceled DHCP transaction
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.58=
75]
> dhcp4 (enp5s0): state changed bound -> done
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.60=
11]
> manager: NetworkManager state is now CONNECTED_GLOBAL
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Bootloader revisio=
n 0.3
> build 0 week 24 2017
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Reached target Bluetooth.
> M=C3=A4r 18 12:51:36 obelix systemd[1335]: Reached target Bluetooth.
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Device revision is=
 1
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Secure boot is ena=
bled
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: OTP lock is enable=
d
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: API lock is enable=
d
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Debug lock is disa=
bled
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Minimum firmware b=
uild 1
> week 10 2014
> M=C3=A4r 18 12:51:36 obelix kernel: Bluetooth: hci0: Found device firmw=
are:
> intel/ibt-20-1-3.sfi
> M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Supervising 3 threads o=
f 1
> processes of 1 users.
> M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Successfully made threa=
d 2118
> of process 1497 owned by '1000' RT at priority 5.
> M=C3=A4r 18 12:51:36 obelix rtkit-daemon[1157]: Supervising 4 threads o=
f 1
> processes of 1 users.
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.73=
72]
> manager: NetworkManager state is now DISCONNECTED
> M=C3=A4r 18 12:51:36 obelix NetworkManager[866]: <info>  [1616068296.73=
85]
> device (enp5s0): state change: unmanaged -> unavailable (reason
> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 12:51:36 obelix dbus-daemon[865]: [system] Activating via
> systemd: service name=3D'org.freedesktop.nm_dispatcher'
> unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.2'=

> (uid=3D0 pid=3D866 comm=3D"/usr/bin/NetworkManager --no-daemon ")
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Starting Network Manager Script=

> Dispatcher Service...
> M=C3=A4r 18 12:51:36 obelix dbus-daemon[865]: [system] Successfully act=
ivated
> service 'org.freedesktop.nm_dispatcher'
> M=C3=A4r 18 12:51:36 obelix systemd[1]: Started Network Manager Script
> Dispatcher Service.
> M=C3=A4r 18 12:51:36 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatc=
her
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:36 obelix kernel: enp5s0: 0xffffb20a00665000,
> 00:d8:61:e6:48:1c, IRQ 61
> M=C3=A4r 18 12:51:36 obelix kernel: audit: type=3D1130
> audit(1616068296.746:98): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D42949=
67295
> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.00=
12]
> device (wlp4s0): state change: unmanaged -> unavailable (reason
> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.00=
22]
> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=

> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.08=
67]
> device (wlp4s0): supplicant interface state: internal-starting ->
> disconnected
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.08=
67]
> device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reason=

> 'removed', sys-iface-state: 'removed')
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.08=
75]
> Wi-Fi P2P device controlled by interface wlp4s0 created
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.08=
81]
> manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device
> (/org/freedesktop/NetworkManager/Devices/5)
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.08=
86]
> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=

> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.08=
96]
> device (wlp4s0): state change: unavailable -> disconnected (reason
> 'supplicant-available', sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <info>  [1616068297.09=
08]
> device (p2p-dev-wlp4s0): state change: unavailable -> disconnected
> (reason 'none', sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:37 obelix gnome-shell[1496]: Removing a network devic=
e that
> was not added
> M=C3=A4r 18 12:51:37 obelix gnome-shell[1496]: Removing a network devic=
e that
> was not added
> M=C3=A4r 18 12:51:37 obelix NetworkManager[866]: <warn>  [1616068297.10=
07]
> sup-iface[2b6336e7b4770113,1,wlp4s0]: call-p2p-cancel: failed with P2P
> cancel failed
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Waiting for firmwa=
re
> download to complete
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Firmware loaded in=

> 1486688 usecs
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Waiting for device=
 to boot
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Device booted in 1=
5971 usecs
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Found Intel DDC
> parameters: intel/ibt-20-1-3.ddc
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Applying Intel DDC=

> parameters completed
> M=C3=A4r 18 12:51:38 obelix kernel: Bluetooth: hci0: Firmware revision =
0.0
> build 121 week 7 2021
> M=C3=A4r 18 12:51:38 obelix bluetoothd[863]: Endpoint registered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
> M=C3=A4r 18 12:51:38 obelix bluetoothd[863]: Endpoint registered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
> M=C3=A4r 18 12:51:40 obelix kernel: r8168: enp5s0: link up
> M=C3=A4r 18 12:51:40 obelix kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp5=
s0:
> link becomes ready
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.05=
71]
> device (enp5s0): carrier: link connected
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.05=
82]
> device (enp5s0): state change: unavailable -> disconnected (reason
> 'carrier-changed', sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
09]
> policy: auto-activating connection 'Kabelgebundene Verbindung 1'
> (c38c81cb-d88f-4897-9ece-659d13774b9a)
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
20]
> device (enp5s0): Activation: starting connection 'Kabelgebundene
> Verbindung 1' (c38c81cb-d88f-4897-9ece-659d13774b9a)
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
22]
> device (enp5s0): state change: disconnected -> prepare (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
28]
> manager: NetworkManager state is now CONNECTING
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
32]
> device (enp5s0): state change: prepare -> config (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
45]
> device (enp5s0): state change: config -> ip-config (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.06=
50]
> dhcp4 (enp5s0): activation: beginning transaction (timeout in 45 second=
s)
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.09=
53]
> dhcp4 (enp5s0): state changed unknown -> bound, address=3D192.168.1.1
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.09=
73]
> device (enp5s0): state change: ip-config -> ip-check (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.09=
97]
> device (enp5s0): state change: ip-check -> secondaries (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.10=
00]
> device (enp5s0): state change: secondaries -> activated (reason 'none',=

> sys-iface-state: 'managed')
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.10=
07]
> manager: NetworkManager state is now CONNECTED_LOCAL
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.10=
23]
> manager: NetworkManager state is now CONNECTED_SITE
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.10=
25]
> policy: set 'Kabelgebundene Verbindung 1' (enp5s0) as default for IPv4
> routing and DNS
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.10=
99]
> device (enp5s0): Activation: successful, device activated.
> M=C3=A4r 18 12:51:40 obelix NetworkManager[866]: <info>  [1616068300.21=
98]
> manager: NetworkManager state is now CONNECTED_GLOBAL
> M=C3=A4r 18 12:51:40 obelix wpa_supplicant[954]: wlp4s0:
> CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
> M=C3=A4r 18 12:51:41 obelix systemd[1]: systemd-rfkill.service: Succeed=
ed.
> M=C3=A4r 18 12:51:41 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:51:41 obelix kernel: audit: type=3D1131
> audit(1616068301.630:99): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D42949=
67295
> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix gdm-password][2147]: gkr-pam: unlocked logi=
n keyring
> M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1100
> audit(1616068304.670:100): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3
> msg=3D'op=3DPAM:authentication
> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_ke=
yring
> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix a=
ddr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix audit[2147]: USER_AUTH pid=3D2147 uid=3D0 a=
uid=3D1000
> ses=3D3 msg=3D'op=3DPAM:authentication
> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_ke=
yring
> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix a=
ddr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix dbus-daemon[865]: [system] Activating via
> systemd: service name=3D'org.freedesktop.home1'
> unit=3D'dbus-org.freedesktop.home1.service' requested by ':1.87' (uid=3D=
0
> pid=3D2147 comm=3D"gdm-session-worker [pam/gdm-password] ")
> M=C3=A4r 18 12:51:44 obelix dbus-daemon[865]: [system] Activation via s=
ystemd
> failed for unit 'dbus-org.freedesktop.home1.service': Unit
> dbus-org.freedesktop.home1.service not found.
> M=C3=A4r 18 12:51:44 obelix gdm-password][2147]:
> pam_systemd_home(gdm-password:account): systemd-homed is not available:=

> Unit dbus-org.freedesktop.home1.service not found.
> M=C3=A4r 18 12:51:44 obelix audit[2147]: USER_ACCT pid=3D2147 uid=3D0 a=
uid=3D1000
> ses=3D3 msg=3D'op=3DPAM:accounting
> grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"harvey"
> exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix addr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1101
> audit(1616068304.673:101): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3
> msg=3D'op=3DPAM:accounting grantors=3Dpam_access,pam_unix,pam_permit,pa=
m_time
> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix a=
ddr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix audit[2147]: CRED_REFR pid=3D2147 uid=3D0 a=
uid=3D1000
> ses=3D3 msg=3D'op=3DPAM:setcred
> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_ke=
yring
> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix a=
ddr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix kernel: audit: type=3D1110
> audit(1616068304.676:102): pid=3D2147 uid=3D0 auid=3D1000 ses=3D3
> msg=3D'op=3DPAM:setcred
> grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_ke=
yring
> acct=3D"harvey" exe=3D"/usr/lib/gdm-session-worker" hostname=3Dobelix a=
ddr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> M=C3=A4r 18 12:51:44 obelix gnome-shell[1496]: loading default theme (A=
dwaita)
> M=C3=A4r 18 12:51:45 obelix dbus-daemon[865]: [system] Activating via
> systemd: service name=3D'org.freedesktop.hostname1'
> unit=3D'dbus-org.freedesktop.hostname1.service' requested by ':1.51'
> (uid=3D1000 pid=3D1496 comm=3D"/usr/bin/gnome-shell ")
> M=C3=A4r 18 12:51:45 obelix audit: BPF prog-id=3D25 op=3DLOAD
> M=C3=A4r 18 12:51:45 obelix audit: BPF prog-id=3D26 op=3DLOAD
> M=C3=A4r 18 12:51:45 obelix systemd[1]: Starting Hostname Service...
> M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1334
> audit(1616068305.143:103): prog-id=3D25 op=3DLOAD
> M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1334
> audit(1616068305.143:104): prog-id=3D26 op=3DLOAD
> M=C3=A4r 18 12:51:45 obelix dbus-daemon[865]: [system] Successfully act=
ivated
> service 'org.freedesktop.hostname1'
> M=C3=A4r 18 12:51:45 obelix systemd[1]: Started Hostname Service.
> M=C3=A4r 18 12:51:45 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:45 obelix kernel: audit: type=3D1130
> audit(1616068305.213:105): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Usage of object.actor is=

> deprecated for ClipboardIndicator
>  =20
> get@resource:///org/gnome/shell/ui/environment.js:317:29
>  =20
> _init@/home/harvey/.local/share/gnome-shell/extensions/clipboard-indica=
tor@tudmotu.com/extension.js:93:9
>  =20
> wrapper@resource:///org/gnome/gjs/modules/script/_legacy.js:82:27
>  =20
> enable@/home/harvey/.local/share/gnome-shell/extensions/clipboard-indic=
ator@tudmotu.com/extension.js:877:26
>  =20
> _callExtensionEnable@resource:///org/gnome/shell/ui/extensionSystem.js:=
167:32
>  =20
> _enableAllExtensions/<@resource:///org/gnome/shell/ui/extensionSystem.j=
s:601:22
>  =20
> _enableAllExtensions@resource:///org/gnome/shell/ui/extensionSystem.js:=
600:37
>  =20
> _sessionUpdated@resource:///org/gnome/shell/ui/extensionSystem.js:628:1=
8
>  =20
> _emit@resource:///org/gnome/gjs/modules/core/_signals.js:133:47
>  =20
> _sync@resource:///org/gnome/shell/ui/sessionMode.js:195:14
>  =20
> popMode@resource:///org/gnome/shell/ui/sessionMode.js:163:14
>  =20
> _continueDeactivate@resource:///org/gnome/shell/ui/screenShield.js:510:=
30
>  =20
> deactivate/<@resource:///org/gnome/shell/ui/screenShield.js:501:44
>  =20
> finish@resource:///org/gnome/shell/gdm/authPrompt.js:528:13
>  =20
> finish@resource:///org/gnome/shell/ui/unlockDialog.js:870:26
>  =20
> deactivate@resource:///org/gnome/shell/ui/screenShield.js:501:26
>  =20
> ScreenShield/</<@resource:///org/gnome/shell/ui/screenShield.js:109:57
>  =20
> _emit@resource:///org/gnome/gjs/modules/core/_signals.js:133:47
>  =20
> _convertToNativeSignal@resource:///org/gnome/gjs/modules/core/overrides=
/Gio.js:169:19
> M=C3=A4r 18 12:51:45 obelix NetworkManager[866]: <info>  [1616068305.32=
68]
> agent-manager:
> agent[a9dc596cf875417d,:1.51/org.gnome.Shell.NetworkAgent/1000]: agent
> registered
> M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Can't update stage views=
 actor
> StWidget is on because it needs an allocation.
> M=C3=A4r 18 12:51:45 obelix gnome-shell[1496]: Can't update stage views=
 actor
> StWidget is on because it needs an allocation.
> M=C3=A4r 18 12:51:45 obelix gsd-usb-protect[1724]: Error calling USBGua=
rd
> DBus to change the protection after a screensaver event:
> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name
> org.usbguard1 was not provided by any .service files
> M=C3=A4r 18 12:51:50 obelix systemd[1]: NetworkManager-dispatcher.servi=
ce:
> Succeeded.
> M=C3=A4r 18 12:51:50 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatc=
her
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:51:50 obelix kernel: audit: type=3D1131
> audit(1616068310.133:106): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:52:15 obelix systemd[1]: systemd-hostnamed.service: Succ=
eeded.
> M=C3=A4r 18 12:52:15 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1131
> audit(1616068335.350:107): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 12:52:15 obelix audit: BPF prog-id=3D26 op=3DUNLOAD
> M=C3=A4r 18 12:52:15 obelix audit: BPF prog-id=3D25 op=3DUNLOAD
> M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1334
> audit(1616068335.470:108): prog-id=3D26 op=3DUNLOAD
> M=C3=A4r 18 12:52:15 obelix kernel: audit: type=3D1334
> audit(1616068335.470:109): prog-id=3D25 op=3DUNLOAD
> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.61=
25]
> manager: sleep: sleep requested (sleeping: no  enabled: yes)
> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.61=
30]
> device (wlp4s0): state change: disconnected -> unmanaged (reason
> 'sleeping', sys-iface-state: 'managed')
> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.61=
74]
> device (p2p-dev-wlp4s0): state change: disconnected -> unmanaged (reaso=
n
> 'sleeping', sys-iface-state: 'managed')
> M=C3=A4r 18 12:52:35 obelix NetworkManager[866]: <info>  [1616068355.61=
76]
> manager: NetworkManager state is now ASLEEP
> M=C3=A4r 18 12:52:35 obelix wpa_supplicant[954]: nl80211: deinit
> ifname=3Dp2p-dev-wlp4s0 disabled_11b_rates=3D0
> M=C3=A4r 18 12:52:35 obelix wpa_supplicant[954]: nl80211: deinit
> ifname=3Dwlp4s0 disabled_11b_rates=3D0
> M=C3=A4r 18 12:52:36 obelix gnome-shell[1496]:
> ../glib/gobject/gsignal.c:2732: instance '0x560b86fddb50' has no handle=
r
> with id '16906'
> M=C3=A4r 18 12:52:36 obelix gsd-media-keys[1691]: Unable to get default=
 sink
> M=C3=A4r 18 12:52:36 obelix gnome-shell[1496]:
> ../glib/gobject/gsignal.c:2732: instance '0x560b861ca0d0' has no handle=
r
> with id '128700'
> M=C3=A4r 18 12:52:40 obelix gsd-usb-protect[1724]: Error calling USBGua=
rd
> DBus to change the protection after a screensaver event:
> GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name
> org.usbguard1 was not provided by any .service files
> M=C3=A4r 18 12:52:40 obelix systemd[1]: Reached target Sleep.
> M=C3=A4r 18 12:52:40 obelix systemd[1]: Starting Hibernate...
> M=C3=A4r 18 12:52:40 obelix systemd-sleep[2193]: Suspending system...
> M=C3=A4r 18 12:52:40 obelix kernel: PM: hibernation: hibernation entry
> M=C3=A4r 18 13:00:43 obelix kernel: Filesystems sync: 0.020 seconds
> M=C3=A4r 18 13:00:43 obelix kernel: Freezing user space processes ...
> (elapsed 0.001 seconds) done.
> M=C3=A4r 18 13:00:43 obelix kernel: OOM killer disabled.
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0x00000000-0x00000fff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0x000a0000-0x000fffff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0x09bff000-0x09ffffff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0x0a200000-0x0a20cfff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0xa5fb2000-0xa60a5fff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0xa84ad000-0xa84adfff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0xa9ee7000-0xad5fefff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Marking nosave pag=
es:
> [mem 0xae000000-0xffffffff]
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Basic memory bitma=
ps created
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Preallocating imag=
e memory
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Allocated 500589 p=
ages
> for snapshot
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Allocated 2002356 =
kbytes
> in 0.47 seconds (4260.33 MB/s)
> M=C3=A4r 18 13:00:43 obelix kernel: Freezing remaining freezable tasks =
=2E..
> (elapsed 0.022 seconds) done.
> M=C3=A4r 18 13:00:43 obelix kernel: printk: Suspending console(s) (use
> no_console_suspend to debug)
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] free PSP TMR buffer
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: MODE2 =
reset
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] free PSP TMR buffer
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: MODE1 =
reset
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU ps=
p
> mode1 reset
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] psp mode1 reset succeed
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: interrupt blocked
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: Preparing to enter system sle=
ep
> state S4
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: event blocked
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: EC stopped
> M=C3=A4r 18 13:00:43 obelix kernel: PM: Saving platform NVS memory
> M=C3=A4r 18 13:00:43 obelix kernel: Disabling non-boot CPUs ...
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 1 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 2 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 3 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 4 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 5 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 6 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 7 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 8 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 9 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 10 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 11 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 12 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 13 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 14 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: CPU 15 is now offline
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Creating image:
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Need to copy 49841=
4 pages
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Normal pages neede=
d:
> 498414 + 1024, available pages: 3537589
> M=C3=A4r 18 13:00:43 obelix kernel: PM: Restoring platform NVS memory
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: EC started
> M=C3=A4r 18 13:00:43 obelix kernel: LVT offset 0 assigned for vector 0x=
400
> M=C3=A4r 18 13:00:43 obelix kernel: Enabling non-boot CPUs ...
> M=C3=A4r 18 13:00:43 obelix kernel: x86: Booting SMP configuration:
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
 APIC 0x1
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU1: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P001: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU1 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 2=
 APIC 0x2
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU2: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P002: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU2 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 3=
 APIC 0x3
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU3: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P003: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU3 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 4=
 APIC 0x4
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU4: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P004: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU4 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 5=
 APIC 0x5
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU5: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P005: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU5 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 6=
 APIC 0x6
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU6: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P006: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU6 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 7=
 APIC 0x7
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU7: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P007: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU7 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 8=
 APIC 0x8
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU8: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P008: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU8 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 9=
 APIC 0x9
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU9: patch_level=3D0x08=
600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P009: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU9 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
0 APIC 0xa
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU10: patch_level=3D0x0=
8600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00A: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU10 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
1 APIC 0xb
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU11: patch_level=3D0x0=
8600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00B: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU11 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
2 APIC 0xc
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU12: patch_level=3D0x0=
8600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00C: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU12 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
3 APIC 0xd
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU13: patch_level=3D0x0=
8600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00D: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU13 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
4 APIC 0xe
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU14: patch_level=3D0x0=
8600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00E: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU14 is up
> M=C3=A4r 18 13:00:43 obelix kernel: smpboot: Booting Node 0 Processor 1=
5 APIC 0xf
> M=C3=A4r 18 13:00:43 obelix kernel: microcode: CPU15: patch_level=3D0x0=
8600104
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: \_SB_.PLTF.P00F: Found 3 idle=
 states
> M=C3=A4r 18 13:00:43 obelix kernel: CPU15 is up
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: Waking up from system sleep s=
tate S4
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: interrupt unblocked
> M=C3=A4r 18 13:00:43 obelix kernel: ACPI: EC: event unblocked
> M=C3=A4r 18 13:00:43 obelix kernel: pci 0000:00:00.2: can't derive rout=
ing
> for PCI INT A
> M=C3=A4r 18 13:00:43 obelix kernel: pci 0000:00:00.2: PCI INT A: no GSI=

> M=C3=A4r 18 13:00:43 obelix kernel: usb usb1: root hub lost power or wa=
s reset
> M=C3=A4r 18 13:00:43 obelix kernel: usb usb2: root hub lost power or wa=
s reset
> M=C3=A4r 18 13:00:43 obelix kernel: usb usb3: root hub lost power or wa=
s reset
> M=C3=A4r 18 13:00:43 obelix kernel: usb usb4: root hub lost power or wa=
s reset
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PCIE GART of 512M enabled (ta=
ble at
> 0x0000008000000000).
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PSP is resuming...
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PCIE GART of 1024M enabled (t=
able
> at 0x000000F400900000).
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] PSP is resuming...
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] reserve 0x400000 from 0xf41f8=
00000
> for PSP TMR
> M=C3=A4r 18 13:00:43 obelix kernel: nvme nvme0: Shutdown timeout set to=
 8 seconds
> M=C3=A4r 18 13:00:43 obelix kernel: nvme nvme0: 16/0/0 default/read/pol=
l queues
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_v11_0_ring_create [amdgpu]=
]
> *ERROR* Failed to wait for sOS ready for ring creation
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_hw_start [amdgpu]] *ERROR*=
 PSP
> create ring failed!
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:psp_resume [amdgpu]] *ERROR* P=
SP
> resume failed
> M=C3=A4r 18 13:00:43 obelix kernel: [drm:amdgpu_device_fw_loading [amdg=
pu]]
> *ERROR* resume of IP block <psp> failed -62
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:03:00.0: amdgpu:
> amdgpu_device_ip_resume failed (-62).
> M=C3=A4r 18 13:00:43 obelix kernel: PM: dpm_run_callback():
> pci_pm_restore+0x0/0xe0 returns -62
> M=C3=A4r 18 13:00:43 obelix kernel: PM: Device 0000:03:00.0 failed to r=
estore
> async: error -62
> M=C3=A4r 18 13:00:43 obelix kernel: ata2: SATA link down (SStatus 0 SCo=
ntrol 300)
> M=C3=A4r 18 13:00:43 obelix kernel: ata1: SATA link down (SStatus 0 SCo=
ntrol 300)
> M=C3=A4r 18 13:00:43 obelix kernel: usb 4-1: reset SuperSpeed Gen 1 USB=

> device number 2 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1: reset high-speed USB devic=
e
> number 2 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAS:
> optional ras ta ucode is not available
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: RAP:
> optional rap ta ucode is not available
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=

> resuming...
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: dpm ha=
s been
> disabled
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: SMU is=

> resumed successfully!
> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-3: reset full-speed USB devic=
e
> number 3 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] kiq ring mec 2 pipe 1 q 0
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] DMUB hardware initialized:
> version=3D0x01000000
> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-4: reset high-speed USB devic=
e
> number 3 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] VCN decode and encode initial=
ized
> successfully(under DPG Mode).
> M=C3=A4r 18 13:00:43 obelix kernel: [drm] JPEG decode initialized succe=
ssfully.
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring g=
fx
> uses VM inv eng 0 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.0.0 uses VM inv eng 1 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.1.0 uses VM inv eng 4 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.2.0 uses VM inv eng 5 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.3.0 uses VM inv eng 6 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.0.1 uses VM inv eng 7 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.1.1 uses VM inv eng 8 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.2.1 uses VM inv eng 9 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> comp_1.3.1 uses VM inv eng 10 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> kiq_2.1.0 uses VM inv eng 11 on hub 0
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring s=
dma0
> uses VM inv eng 0 on hub 1
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring v=
cn_dec
> uses VM inv eng 1 on hub 1
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> vcn_enc0 uses VM inv eng 4 on hub 1
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> vcn_enc1 uses VM inv eng 5 on hub 1
> M=C3=A4r 18 13:00:43 obelix kernel: amdgpu 0000:07:00.0: amdgpu: ring
> jpeg_dec uses VM inv eng 6 on hub 1
> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1: reset high-speed USB devic=
e
> number 2 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1.2: reset high-speed USB dev=
ice
> number 4 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 1-1.3: reset high-speed USB dev=
ice
> number 5 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 4-1.4: reset SuperSpeed Gen 1 U=
SB
> device number 3 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.2: reset full-speed USB dev=
ice
> number 4 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.3: reset full-speed USB dev=
ice
> number 5 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.4: reset high-speed USB dev=
ice
> number 6 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: usb 3-1.4.1: reset full-speed USB d=
evice
> number 7 using xhci_hcd
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: Basic memory bitma=
ps freed
> M=C3=A4r 18 13:00:43 obelix kernel: OOM killer enabled.
> M=C3=A4r 18 13:00:43 obelix kernel: Restarting tasks ... done.
> M=C3=A4r 18 13:00:43 obelix kernel: thermal thermal_zone1: failed to re=
ad out
> thermal zone (-61)
> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130
> audit(1616068843.306:110): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix bluetoothd[863]: Endpoint unregistered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Starting Load/Save RF Kill Swit=
ch
> Status...
> M=C3=A4r 18 13:00:43 obelix blueman.desktop[1725]: blueman-applet 13.00=
=2E43
> WARNING  DiscvManager:75 on_adapter_removed: Warning: adapter is None
> M=C3=A4r 18 13:00:43 obelix bluetoothd[863]: Endpoint unregistered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Started Load/Save RF Kill Switc=
h Status.
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> EDID vendor "AUO", prod id 18333
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Using hsync ranges from config file
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Using vrefresh ranges from config file
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Printing DDC gathered Modelines:
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Modeline "1920x1080"x0.0  306.73  1920 1968 2000 2102  1080 1090 1095
> 1216 -hsync -vsync (145.9 kHz eP)
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (II) AMDGPU(0=
):
> Modeline "1920x1080"x0.0  122.70  1920 1968 2000 2102  1080 1090 1095
> 1216 -hsync -vsync (58.4 kHz e)
> M=C3=A4r 18 13:00:43 obelix /usr/lib/gdm-x-session[1352]: (--) AMDGPU(G=
0):
> HDMI max TMDS frequency 300000KHz
> M=C3=A4r 18 13:00:43 obelix systemd[1335]: Stopped target Bluetooth.
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Bluetooth.
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.3/usb1/1-1
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.3/usb1/1-1
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-3
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.2
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1/4-1.4
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.2
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb4/4-1/4-1.4
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4/3-1.4.=
1
> M=C3=A4r 18 13:00:43 obelix upowerd[1150]: treating change event as add=
 on
> /sys/devices/pci0000:00/0000:00:08.1/0000:07:00.4/usb3/3-1/3-1.4/3-1.4.=
1
> M=C3=A4r 18 13:00:43 obelix systemd-sleep[2193]: System resumed.
> M=C3=A4r 18 13:00:43 obelix systemd[1]: systemd-hibernate.service: Succ=
eeded.
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Finished Hibernate.
> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hibernate
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Reached target Hibernate.
> M=C3=A4r 18 13:00:43 obelix kernel: PM: hibernation: hibernation exit
> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130
> audit(1616068843.413:111): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1131
> audit(1616068843.413:112): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dsystemd-hibernate comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Sleep.
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Stopped target Hibernate.
> M=C3=A4r 18 13:00:43 obelix systemd-logind[868]: Operation 'sleep' fini=
shed.
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.42=
04]
> manager: sleep: wake requested (sleeping: yes  enabled: yes)
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.42=
05]
> device (enp5s0): state change: activated -> unmanaged (reason
> 'sleeping', sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.43=
57]
> dhcp4 (enp5s0): canceled DHCP transaction
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.43=
58]
> dhcp4 (enp5s0): state changed bound -> done
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.44=
76]
> manager: NetworkManager state is now CONNECTED_GLOBAL
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Reached target Bluetooth.
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Bootloader revisio=
n 0.3
> build 0 week 24 2017
> M=C3=A4r 18 13:00:43 obelix systemd[1335]: Reached target Bluetooth.
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Device revision is=
 1
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Secure boot is ena=
bled
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: OTP lock is enable=
d
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: API lock is enable=
d
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Debug lock is disa=
bled
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Minimum firmware b=
uild 1
> week 10 2014
> M=C3=A4r 18 13:00:43 obelix kernel: Bluetooth: hci0: Found device firmw=
are:
> intel/ibt-20-1-3.sfi
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.60=
12]
> manager: NetworkManager state is now DISCONNECTED
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.60=
27]
> device (enp5s0): state change: unmanaged -> unavailable (reason
> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 13:00:43 obelix dbus-daemon[865]: [system] Activating via
> systemd: service name=3D'org.freedesktop.nm_dispatcher'
> unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.2'=

> (uid=3D0 pid=3D866 comm=3D"/usr/bin/NetworkManager --no-daemon ")
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Starting Network Manager Script=

> Dispatcher Service...
> M=C3=A4r 18 13:00:43 obelix dbus-daemon[865]: [system] Successfully act=
ivated
> service 'org.freedesktop.nm_dispatcher'
> M=C3=A4r 18 13:00:43 obelix systemd[1]: Started Network Manager Script
> Dispatcher Service.
> M=C3=A4r 18 13:00:43 obelix audit[1]: SERVICE_START pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatc=
her
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix kernel: enp5s0: 0xffffb20a00665000,
> 00:d8:61:e6:48:1c, IRQ 61
> M=C3=A4r 18 13:00:43 obelix kernel: audit: type=3D1130
> audit(1616068843.610:113): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Supervising 3 threads o=
f 1
> processes of 1 users.
> M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Successfully made threa=
d 2283
> of process 1497 owned by '1000' RT at priority 5.
> M=C3=A4r 18 13:00:43 obelix rtkit-daemon[1157]: Supervising 4 threads o=
f 1
> processes of 1 users.
> M=C3=A4r 18 13:00:43 obelix NetworkManager[866]: <info>  [1616068843.86=
78]
> device (wlp4s0): state change: unmanaged -> unavailable (reason
> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 13:00:44 obelix NetworkManager[866]: <info>  [1616068844.12=
82]
> device (wlp4s0): set-hw-addr: set MAC address to 8E:7C:CA:62:5B:A4
> (scanning)
> M=C3=A4r 18 13:00:44 obelix NetworkManager[866]: <info>  [1616068844.37=
76]
> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=

> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 13:00:45 obelix kernel: [drm] Failed to add display topolog=
y, DTM
> TA is not initialized.
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Waiting for firmwa=
re
> download to complete
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Firmware loaded in=

> 1607510 usecs
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Waiting for device=
 to boot
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Device booted in 1=
5915 usecs
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Found Intel DDC
> parameters: intel/ibt-20-1-3.ddc
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Applying Intel DDC=

> parameters completed
> M=C3=A4r 18 13:00:45 obelix kernel: Bluetooth: hci0: Firmware revision =
0.0
> build 121 week 7 2021
> M=C3=A4r 18 13:00:45 obelix bluetoothd[863]: Endpoint registered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSink/sbc
> M=C3=A4r 18 13:00:45 obelix bluetoothd[863]: Endpoint registered:
> sender=3D:1.55 path=3D/MediaEndpoint/A2DPSource/sbc
> M=C3=A4r 18 13:00:46 obelix kernel: r8168: enp5s0: link up
> M=C3=A4r 18 13:00:46 obelix kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp5=
s0:
> link becomes ready
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
09]
> device (enp5s0): carrier: link connected
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
20]
> device (enp5s0): state change: unavailable -> disconnected (reason
> 'carrier-changed', sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
60]
> device (wlp4s0): supplicant interface state: internal-starting ->
> disconnected
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
60]
> device (p2p-dev-wlp4s0): state change: unavailable -> unmanaged (reason=

> 'removed', sys-iface-state: 'removed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
71]
> Wi-Fi P2P device controlled by interface wlp4s0 created
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
77]
> manager: (p2p-dev-wlp4s0): new 802.11 Wi-Fi P2P device
> (/org/freedesktop/NetworkManager/Devices/6)
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
82]
> device (p2p-dev-wlp4s0): state change: unmanaged -> unavailable (reason=

> 'managed', sys-iface-state: 'external')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.31=
94]
> policy: auto-activating connection 'Kabelgebundene Verbindung 1'
> (c38c81cb-d88f-4897-9ece-659d13774b9a)
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
01]
> device (enp5s0): Activation: starting connection 'Kabelgebundene
> Verbindung 1' (c38c81cb-d88f-4897-9ece-659d13774b9a)
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
01]
> device (wlp4s0): state change: unavailable -> disconnected (reason
> 'supplicant-available', sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
09]
> device (p2p-dev-wlp4s0): state change: unavailable -> disconnected
> (reason 'none', sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
14]
> device (enp5s0): state change: disconnected -> prepare (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
20]
> manager: NetworkManager state is now CONNECTING
> M=C3=A4r 18 13:00:48 obelix gnome-shell[1496]: Removing a network devic=
e that
> was not added
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
22]
> device (enp5s0): state change: prepare -> config (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix gnome-shell[1496]: Removing a network devic=
e that
> was not added
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
33]
> device (enp5s0): state change: config -> ip-config (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.32=
36]
> dhcp4 (enp5s0): activation: beginning transaction (timeout in 45 second=
s)
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.35=
49]
> dhcp4 (enp5s0): state changed unknown -> bound, address=3D192.168.1.1
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <warn>  [1616068848.35=
54]
> sup-iface[11828c54025c5ecd,2,wlp4s0]: call-p2p-cancel: failed with P2P
> cancel failed
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.35=
70]
> device (enp5s0): state change: ip-config -> ip-check (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.36=
06]
> device (enp5s0): state change: ip-check -> secondaries (reason 'none',
> sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.36=
09]
> device (enp5s0): state change: secondaries -> activated (reason 'none',=

> sys-iface-state: 'managed')
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.36=
16]
> manager: NetworkManager state is now CONNECTED_LOCAL
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.36=
29]
> manager: NetworkManager state is now CONNECTED_SITE
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.36=
31]
> policy: set 'Kabelgebundene Verbindung 1' (enp5s0) as default for IPv4
> routing and DNS
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.37=
01]
> device (enp5s0): Activation: successful, device activated.
> M=C3=A4r 18 13:00:48 obelix NetworkManager[866]: <info>  [1616068848.48=
35]
> manager: NetworkManager state is now CONNECTED_GLOBAL
> M=C3=A4r 18 13:00:48 obelix systemd[1]: systemd-rfkill.service: Succeed=
ed.
> M=C3=A4r 18 13:00:48 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D=
"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> M=C3=A4r 18 13:00:48 obelix kernel: audit: type=3D1131
> audit(1616068848.603:114): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/s=
ystemd"
> hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 13:00:51 obelix wpa_supplicant[954]: wlp4s0:
> CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DDE
> M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail
> [amdgpu]] *ERROR* Waiting for fences timed out!
> M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]
> *ERROR* ring sdma0 timeout, signaled seq=3D552, emitted seq=3D554
> M=C3=A4r 18 13:00:54 obelix kernel: [drm:amdgpu_job_timedout [amdgpu]]
> *ERROR* Process information: process  pid 0 thread  pid 0
> M=C3=A4r 18 13:00:54 obelix kernel: amdgpu 0000:03:00.0: amdgpu: GPU re=
set begin!
> M=C3=A4r 18 13:00:54 obelix kernel: BUG: kernel NULL pointer dereferenc=
e,
> address: 0000000000000029
> M=C3=A4r 18 13:00:54 obelix kernel: #PF: supervisor read access in kern=
el mode
> M=C3=A4r 18 13:00:54 obelix kernel: #PF: error_code(0x0000) - not-prese=
nt page
> M=C3=A4r 18 13:00:54 obelix kernel: PGD 0 P4D 0
> M=C3=A4r 18 13:00:54 obelix kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
> M=C3=A4r 18 13:00:54 obelix kernel: CPU: 9 PID: 1327 Comm: kworker/9:3
> Tainted: G           OE     5.11.7-arch1-1 #1
> M=C3=A4r 18 13:00:54 obelix kernel: Hardware name: Micro-Star Internati=
onal
> Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
> M=C3=A4r 18 13:00:54 obelix kernel: Workqueue: events drm_sched_job_tim=
edout
> [gpu_sched]
> M=C3=A4r 18 13:00:54 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/0=
xf0
> [amdgpu]
> M=C3=A4r 18 13:00:54 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 84=
 c0 0f
> 84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48=

> 8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00
> 48 8b 7f 08 4c
> M=C3=A4r 18 13:00:54 obelix kernel: RSP: 0018:ffffb20a04a27d40 EFLAGS: =
00010246
> M=C3=A4r 18 13:00:54 obelix kernel: RAX: 0000000000000001 RBX:
> ffff9e0c825c4000 RCX: 000000008080007c
> M=C3=A4r 18 13:00:54 obelix kernel: RDX: 000000008080007d RSI:
> 0000000000000001 RDI: ffff9e0c8a97f2c0
> M=C3=A4r 18 13:00:54 obelix kernel: RBP: ffff9e0c8a97f2c0 R08:
> 0000000000000001 R09: 0000000000000000
> M=C3=A4r 18 13:00:54 obelix kernel: R10: 0000000000000001 R11:
> ffffffffb54cba00 R12: ffff9e0c825c40d0
> M=C3=A4r 18 13:00:54 obelix kernel: R13: ffff9e0c8cf80000 R14:
> ffff9e0c81489000 R15: ffff9e0c814890c8
> M=C3=A4r 18 13:00:54 obelix kernel: FS:  0000000000000000(0000)
> GS:ffff9e0f9f840000(0000) knlGS:0000000000000000
> M=C3=A4r 18 13:00:54 obelix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029 CR3:
> 0000000228210000 CR4: 0000000000350ee0
> M=C3=A4r 18 13:00:54 obelix kernel: Call Trace:
> M=C3=A4r 18 13:00:54 obelix kernel:  stop_cpsch+0xa0/0xc0 [amdgpu]
> M=C3=A4r 18 13:00:54 obelix kernel:  kgd2kfd_suspend.part.0+0x2f/0x40 [=
amdgpu]
> M=C3=A4r 18 13:00:54 obelix kernel:  kgd2kfd_pre_reset+0x3f/0x50 [amdgp=
u]
> M=C3=A4r 18 13:00:54 obelix kernel:
> amdgpu_device_gpu_recover.cold+0x36e/0x95d [amdgpu]
> M=C3=A4r 18 13:00:54 obelix kernel:  amdgpu_job_timedout+0x121/0x140 [a=
mdgpu]
> M=C3=A4r 18 13:00:54 obelix kernel:  drm_sched_job_timedout+0x64/0xe0 [=
gpu_sched]
> M=C3=A4r 18 13:00:54 obelix kernel:  process_one_work+0x214/0x3e0
> M=C3=A4r 18 13:00:54 obelix kernel:  worker_thread+0x4d/0x3d0
> M=C3=A4r 18 13:00:54 obelix kernel:  ? rescuer_thread+0x3c0/0x3c0
> M=C3=A4r 18 13:00:54 obelix kernel:  kthread+0x133/0x150
> M=C3=A4r 18 13:00:54 obelix kernel:  ? __kthread_bind_mask+0x60/0x60
> M=C3=A4r 18 13:00:54 obelix kernel:  ret_from_fork+0x22/0x30
> M=C3=A4r 18 13:00:54 obelix kernel: Modules linked in: rfcomm
> snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
> ledtrig_audio cmac algif_hash algif_skcipher af_alg snd_hda_intel
> snd_intel_dspcfg soundwire_intel soundwire_generic_allocation bnep
> soundwire_cadence snd_hda_codec iwlmvm snd_hda_core nls_iso8859_1
> snd_hwdep vfat intel_rapl_msr intel_rapl_common soundwire_bus fat
> hid_multitouch gpio_keys snd_soc_core btusb mac80211 edac_mce_amd
> kvm_amd libarc4 uvcvideo snd_compress btrtl ac97_bus btbcm iwlwifi
> pktcdvd snd_pcm_dmaengine videobuf2_vmalloc kvm btintel videobuf2_memop=
s
> snd_pcm videobuf2_v4l2 bluetooth videobuf2_common videodev joydev
> snd_timer mousedev irqbypass ecdh_generic msi_wmi mc ecc cfg80211 rapl
> psmouse pcspkr sparse_keymap snd k10temp i2c_piix4 snd_rn_pci_acp3x
> snd_pci_acp3x soundcore rfkill i2c_hid tpm_crb acpi_cpufreq tpm_tis
> mac_hid soc_button_array pinctrl_amd tpm_tis_core vboxnetflt(OE)
> vboxnetadp(OE) vboxdrv(OE) usbip_host usbip_core sg fuse crypto_user
> bpf_preload ip_tables
> M=C3=A4r 18 13:00:54 obelix kernel:  x_tables ext4 crc32c_generic crc16=

> mbcache jbd2 sr_mod cdrom uas usb_storage dm_crypt cbc encrypted_keys
> dm_mod trusted tpm crct10dif_pclmul crc32_pclmul crc32c_intel
> ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ccp
> serio_raw xhci_pci rng_core xhci_pci_renesas wmi video usbhid r8168(OE)=

> amdgpu drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper
> syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm agpgart
> M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029
> M=C3=A4r 18 13:00:54 obelix kernel: ---[ end trace ff2438cc3b9cd967 ]--=
-
> M=C3=A4r 18 13:00:54 obelix kernel: RIP: 0010:kernel_queue_uninit+0xd/0=
xf0
> [amdgpu]
> M=C3=A4r 18 13:00:54 obelix kernel: Code: ee 48 89 c7 e8 a4 f9 ff ff 84=
 c0 0f
> 84 e3 d3 1f 00 4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48=

> 8b 47 10 48 89 fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00
> 48 8b 7f 08 4c
> M=C3=A4r 18 13:00:54 obelix kernel: RSP: 0018:ffffb20a04a27d40 EFLAGS: =
00010246
> M=C3=A4r 18 13:00:54 obelix kernel: RAX: 0000000000000001 RBX:
> ffff9e0c825c4000 RCX: 000000008080007c
> M=C3=A4r 18 13:00:54 obelix kernel: RDX: 000000008080007d RSI:
> 0000000000000001 RDI: ffff9e0c8a97f2c0
> M=C3=A4r 18 13:00:54 obelix kernel: RBP: ffff9e0c8a97f2c0 R08:
> 0000000000000001 R09: 0000000000000000
> M=C3=A4r 18 13:00:54 obelix kernel: R10: 0000000000000001 R11:
> ffffffffb54cba00 R12: ffff9e0c825c40d0
> M=C3=A4r 18 13:00:54 obelix kernel: R13: ffff9e0c8cf80000 R14:
> ffff9e0c81489000 R15: ffff9e0c814890c8
> M=C3=A4r 18 13:00:54 obelix kernel: FS:  0000000000000000(0000)
> GS:ffff9e0f9f840000(0000) knlGS:0000000000000000
> M=C3=A4r 18 13:00:54 obelix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> M=C3=A4r 18 13:00:54 obelix kernel: CR2: 0000000000000029 CR3:
> 00000001083b8000 CR4: 0000000000350ee0
> M=C3=A4r 18 13:00:54 obelix /usr/lib/gdm-x-session[1352]: (II) event7  =
-
> Microsoft Microsoft=C2=AE 2.4GHz Transceiver v9.0 Mouse: SYN_DROPPED ev=
ent -
> some input events have been lost.
> M=C3=A4r 18 13:00:58 obelix systemd[1]: NetworkManager-dispatcher.servi=
ce:
> Succeeded.
> M=C3=A4r 18 13:00:58 obelix audit[1]: SERVICE_STOP pid=3D1 uid=3D0
> auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatc=
her
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=

> terminal=3D? res=3Dsuccess'
> M=C3=A4r 18 13:00:58 obelix kernel: [drm:amdgpu_dm_atomic_commit_tail
> [amdgpu]] *ERROR* Waiting for fences timed out!
> M=C3=A4r 18 13:00:58 obelix kernel: audit: type=3D1131
> audit(1616068858.453:115): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294=
967295
> msg=3D'unit=3DNetworkManager-dispatcher comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
>=20
> Do I still have to apply the patches you mentioned against a vanilla
> kernel and, if so, to which - 5.7.11 or 5.12-rc3?
>=20
> Greetings
> Harvey
>=20

--=20
I am root. If you see me laughing, you'd better have a backup!


--n8NaK535vUqjQW85cOzFPPM56bUCDqviD--

--sbGfxR1yP2Fp2Vv7ef9PvkaMY4aIomcyS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRSRNvmxYqoNs6vm0SLlqqYsFRKCQUCYFSX4gUDAAAAAAAKCRCLlqqYsFRKCVgw
AJ9avDLSQcrd36GGgFhgezNq8TutrACgiDAPhRyDOkDMvBYbjJL3o2qM2vU=
=ARHv
-----END PGP SIGNATURE-----

--sbGfxR1yP2Fp2Vv7ef9PvkaMY4aIomcyS--

--===============0656229528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0656229528==--
