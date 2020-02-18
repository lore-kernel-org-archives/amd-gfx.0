Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A46AC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 15:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF16207FD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr+mGjX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF16207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7449F6E30C;
	Tue, 18 Feb 2020 15:11:36 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C126E301
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 15:01:09 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id k11so24300909wrd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 07:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=SSsCoJJcblKvrZteXDmyv6nmx3mW4ry3nxcog+tSMos=;
 b=lr+mGjX+BsM4AJJta1uFl88ikfUjittHIO8N4tsgS/Yovq6LEY1WD861ciPv3ak8fm
 83/e5f2Z2Gq3bIGDCv/r3YdQ2luI6agPMIletNs8QlqCUdo3SQe30MZ4oLElK04991xK
 co8m7JXRih6ww57jHmogq2INEJ2Z2jRdJUSLHsZLZSpXtCbIpgLBz8gGQkg0nD9HZPjF
 J6p/l1Y12uyqz22tlikzpZXJJM2MiO2PR/q/ONqVy24UQbVw4zJO/v3685tVPptrcHJX
 Ga6Zv+vhnfNtjhsUsqrLNZy0MQf3SiMASCk0U6zToQjAhaagSEow666Kl7uxsYQ7RdOY
 KBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=SSsCoJJcblKvrZteXDmyv6nmx3mW4ry3nxcog+tSMos=;
 b=eT7o+1tmJfgxsPpvAUlJ60UDVPAePUk0K269U8N56dpLINOW8s5q95zRV53FaLgQ40
 G32A/NoC9Bd8/4kxk+Vu9uuq+FhxOYWSpttrkeCmp39vTCwrYSI+TqWugg2lWUTeL7R4
 Je987BkT2HA7LBAfytCLcPeh8K7/wUjr2WVo4rGjvIcffJBKEX+33DQmxvO0RsdMk8U7
 WoOLqnaYKjY2vqO8eksMxLysQWEmsDllfp0B3gBiKHV1MNGlhGOt1fEnDOKXF9Lazw+p
 wDeIVIP33qs63Y+g/KZO1QJujjWG5EBvRaU9/hr0usatvUGdvgRCtYSQB5pacNgx/3CZ
 VC3Q==
X-Gm-Message-State: APjAAAWr7K1wJGFBT5cAImS2guzLhVWqJCLn0SihOQD21wIFG/9l8a/v
 B5qkdFfrAVcBZ8kZ7JijVsP5ng0831LzR0z69zFLbw==
X-Google-Smtp-Source: APXvYqz+SrEWCSqi25xd05zAwyre4McpFDLOTkrIUoBu8AYqPPuCNrukqmKFIrn+GhUDWzm6TEYtVSPZDLGXHfbCaLg=
X-Received: by 2002:adf:e686:: with SMTP id r6mr29856223wrm.177.1582038067676; 
 Tue, 18 Feb 2020 07:01:07 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
 <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
 <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
 <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Tue, 18 Feb 2020 18:00:54 +0300
Message-ID: <CAGzVRjy8DRGxwgkz3-0=Jc06FNQRVzP3OrwdFwMNSAR09qvJgA@mail.gmail.com>
Subject: Re: writing custom driver for VGA emulation ?
To: "Bridgman, John" <John.Bridgman@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Tue, 18 Feb 2020 15:11:35 +0000
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
Content-Type: multipart/mixed; boundary="===============1220659383=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1220659383==
Content-Type: multipart/alternative; boundary="0000000000000b87a9059edaf18f"

--0000000000000b87a9059edaf18f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

*Hello Mr. Alex, Mr. C=C3=B6nig and Mr. Bridgman, *

*Mr. C=C3=B6nig, we have talked about MMIO problem before. You helped me a =
lot
about that and now driver is not giving any error about MMIO. That problem
was about bus configuration of my embedded system. It does not proceed more
than 4GB besides 0x0 adress is aligned for I/O and MMIO is allowed between
0xE0000000 and 0xffffffff. Fortunately, I now am able to claim 256 MB and
other 4 BARs adress between this range. I can attach lspci -v output. *

*Mr. Bridgman, I am using U-boot as bootloader and the system is 64 bit
PowerPc e5500 core. This means big endian kernel. *

*Right now, the driver 'amdgpu' is having error when *
*it tries to load smc firmware. I ve been trying to solve this problem for
months but I haven't solve it yet. *

*Other firmwares seems loading without any error. I was suspecting that
endianness is causing this problem but if it was shouldn't other firmwares
get fail before smc firmware gets loaded? *

*I tried all of the firmwares in repository but result remained same. *

*Full dmesg:*
[    5.426009] [drm] amdgpu kernel modesetting enabled.

[    5.430109] [drm] initializing kernel modesetting (POLARIS12
0x1002:0x6987 0x1787:0x2389 0x80).
[    5.437591] [drm] register mmio base: 0x20200000

[    5.440899] [drm] register mmio size: 262144

[    5.443888] [drm] add ip block number 0 <vi_common>

[    5.447465] [drm] add ip block number 1 <gmc_v8_0>

[    5.450953] [drm] add ip block number 2 <tonga_ih>

[    5.454442] [drm] add ip block number 3 <powerplay>

[    5.458018] [drm] add ip block number 4 <dm>

[    5.460979] [drm] add ip block number 5 <gfx_v8_0>

[    5.464466] [drm] add ip block number 6 <sdma_v3_0>

[    5.468042] [drm] add ip block number 7 <uvd_v6_0>

[    5.471531] [drm] add ip block number 8 <vce_v3_0>

[    5.475047] [drm] UVD is enabled in VM mode

[    5.477928] [drm] UVD ENC is enabled in VM mode

[    5.481154] [drm] VCE enabled in VM mode

[    5.712355] ATOM BIOS: 113-ER16BFC-001

[    5.714830] [drm] GPU posting now...

[    5.833704] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[    5.840950] amdgpu 0001:01:00.0: BAR 2: releasing [mem
0x220000000-0x2201fffff 64bit pref]
[    5.847930] amdgpu 0001:01:00.0: BAR 0: releasing [mem
0x210000000-0x21fffffff 64bit pref]
[    5.855688] [drm:.amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* Problem
resizing BAR0 (-2).
[    5.855706] amdgpu 0001:01:00.0: BAR 0: assigned [mem
0x230000000-0x23fffffff 64bit pref]
[    5.869663] amdgpu 0001:01:00.0: BAR 2: assigned [mem
0x240000000-0x2401fffff 64bit pref]
[    5.876582] amdgpu 0001:01:00.0: VRAM: 4096M 0x000000F400000000 -
0x000000F4FFFFFFFF (4096M used)
[    5.884160] amdgpu 0001:01:00.0: GART: 256M 0x0000000000000000 -
0x000000000FFFFFFF
[    5.890519] [drm] Detected VRAM RAM=3D4096M, BAR=3D256M

[    5.894093] [drm] RAM width 128bits GDDR5

[    5.896941] [TTM] Zone  kernel: Available graphics memory: 4062380 kiB

[    5.902177] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB

[    5.907402] [TTM] Initializing pool allocator

[    5.910464] [TTM] Initializing DMA pool allocator

[    5.919973] [drm] amdgpu: 4096M of VRAM memory ready

[    5.923659] [drm] amdgpu: 4096M of GTT memory ready.

[    5.927358] [drm] GART: num cpu pages 65536, num gpu pages 65536

[    5.932957] [drm] PCIE GART of 256M enabled (table at
0x000000F400000000).
[    5.939122] [drm] Chained IB support enabled!

[    5.948873] [drm] Found UVD firmware Version: 1.79 Family ID: 16

[    5.953647] [drm] UVD ENC is disabled

[    5.975818] [drm] Found VCE firmware Version: 52.4 Binary ID: 3

[    6.404774] amdgpu: [powerplay] Failed to send Message.

[    6.835902] amdgpu: [powerplay] SMU Firmware start failed!

[    6.840086] amdgpu: [powerplay] Failed to load SMU ucode.

[    6.844184] amdgpu: [powerplay] smc start failed

*[    6.847498] amdgpu: [powerplay] powerplay hw init failed *

*[    6.852281] [drm:.amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP
block <powerplay> failed -22*
*[    6.859883] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed *

*                                             [    6.864330] amdgpu
0001:01:00.0: Fatal error during GPU init  *
*                                         [    6.868689] [drm] amdgpu:
finishing device. *




*[    7.339427] pcieport 0001:00:00.0: AER: Corrected error received:
0001:00:00.0                                            [    7.345374]
pcieport 0001:00:00.0: PCIe Bus Error: severity=3DCorrected, type=3DData Li=
nk
Layer, (Transmitter ID)            [    7.353993] pcieport 0001:00:00.0:
device [1957:0824] error status/mask=3D00001000/00002000
         [    7.361047] pcieport 0001:00:00.0:    [12] Timeout    *

[    7.706137] amdgpu: [powerplay]

                last message was failed ret is 0

[    8.127667] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[    8.966331] amdgpu: [powerplay]

                last message was failed ret is 0

[    9.320290] pcieport 0001:00:00.0: AER: Corrected error received:
0001:00:00.0
[    9.326226] pcieport 0001:00:00.0: PCIe Bus Error: severity=3DCorrected,
type=3DData Link Layer, (Transmitter ID)
[    9.334845] pcieport 0001:00:00.0:   device [1957:0824] error
status/mask=3D00001000/00002000
[    9.341899] pcieport 0001:00:00.0:    [12] Timeout

[    9.387975] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   10.226636] amdgpu: [powerplay]

                last message was failed ret is 0

[   10.648275] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   11.486932] amdgpu: [powerplay]

                last message was failed ret is 0

[   11.908570] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   12.747228] amdgpu: [powerplay]

                last message was failed ret is 0

[   13.168866] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   14.007523] amdgpu: [powerplay]

                last message was failed ret is 0

[   14.429161] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   15.267816] amdgpu: [powerplay]

                last message was failed ret is 0

[   15.689456] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   16.528114] amdgpu: [powerplay]

                last message was failed ret is 0

[   16.949756] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   17.788411] amdgpu: [powerplay]

                last message was failed ret is 0

[   18.210051] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   19.048710] amdgpu: [powerplay]

                last message was failed ret is 0

[   19.470347] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   19.786774] [TTM] Finalizing pool allocator

[   19.789696] [TTM] Finalizing DMA pool allocator

[   19.793004] [TTM] Zone  kernel: Used memory at exit: 0 kiB

[   19.797209] [TTM] Zone   dma32: Used memory at exit: 0 kiB

[   19.801410] [drm] amdgpu: ttm finalized

*                           [   19.804496] amdgpu: probe of 0001:01:00.0
failed with error -22 *


18 =C5=9Eub 2020 Sal 17:43 tarihinde Bridgman, John <John.Bridgman@amd.com>=
 =C5=9Funu
yazd=C4=B1:

> [AMD Official Use Only - Internal Distribution Only]
>
> >And we already checked, 256MB is unfortunately the minimum you can resiz=
e
> the VRAM BAR on the E9171 to.
>
> Ahh, OK... I didn't realize we had already looked into that. I guess that
> approach isn't going to work.
>
> Yusef, guessing you are using a 32-bit CPU ? Is it possible to talk to
> whoever does SBIOS for your platform to see if you could maybe reduce
> address space allocated to RAM and bump up the MMIO space ?
>
> ------------------------------
> *From:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> *Sent:* February 18, 2020 9:19 AM
> *To:* Bridgman, John <John.Bridgman@amd.com>; Alex Deucher <
> alexdeucher@gmail.com>; Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: writing custom driver for VGA emulation ?
>
> The problem Yusuf runs into is that his platform has multiple PCIe root
> hubs, but only 512MB of MMIO address space. That is not enough to fit all
> the BARs of an E9171 into.
>
> But without the BARs neither the VGA emulation nor amdgpu not anything
> else will work correctly.
>
> And we already checked, 256MB is unfortunately the minimum you can resize
> the VRAM BAR on the E9171 to.
>
> What could maybe work is to trick the upstream bridge of the VGA device
> into not routing all the addresses to the BARs and actually use only a
> smaller portion of visible VRAM. But that would be highly experimental an=
d
> requires a rather big hack into the PCI(e) subsystem in the Linux kernel.
>
> Regards,
> Christian.
>
> Am 18.02.20 um 15:08 schrieb Bridgman, John:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Does the VBIOS come up with something like a splash screen, ie is VBIOS
> able to initialize and drive the card ?
>
> If so then another option might be to use a VESA driver rather than VGA.
>
>
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
> <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deucher
> <alexdeucher@gmail.com> <alexdeucher@gmail.com>
> *Sent:* February 18, 2020 8:50 AM
> *To:* Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com> <yusufalti1997@gmai=
l.com>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: writing custom driver for VGA emulation ?
>
> On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt=C4=B1parmak
> <yusufalti1997@gmail.com> <yusufalti1997@gmail.com> wrote:
> >
> > Hello AMD team;
> >
> > I have E 9171 GPU and want to use it on a embedded system which has
> limited MMIO space on PCIe bus (MAX 512 MB).
> >
> > I received feedbacks that I can only use VGA emulation with this memory
> space. I was unable to get 'amdgpu' driver working with Xorg due to I had
> many errors(firmwares are not loading) in each step and tired of solving
> them one by one.
> >
> > I want to write a simple custom driver for this GPU with kernel version
> 4.19.
> > Is it possible to print some colors on screen with a custom driver over
> PCIe communication ? or writing some words on screen as VGA ?
> >
> > If answer is yes, then which code pieces (on amdgpu driver folder) or
> reference documentation should I use? I have Register Reference Guide.pdf=
.
> >
> > I will be appreciated for your guidance.
>
> That is not going to do what you want on your platform.  The VGA
> emulation requires that you set up the card first to enable it, which
> in turn requires MMIO access and thus you are back to square one.
>
> Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.b=
ridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=3DQbfaIN%2F6LvgUihz5O0x=
41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=3D0
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CJohn.Brid=
gman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637176323587003958&sdata=3D6eKo51jnHbE1QWkDB%2BN%2FFLML=
B40HA2wVN3mU1l%2FeFhk%3D&reserved=3D0>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-g=
fx&data=3D02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d8=
99a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&sdata=
=3D6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=3D0>
>
>
>
>

--0000000000000b87a9059edaf18f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OnNhbnMtc2VyaWY7Zm9udC1z
aXplOjEyLjhweCIgZGlyPSJhdXRvIj48ZGl2IHN0eWxlPSJ3aWR0aDozMjhweDttYXJnaW46MTZw
eCAwcHgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJhdXRvIj48Yj5IZWxsbyBNci4gQWxleCwg
TXIuIEPDtm5pZyBhbmQgTXIuIEJyaWRnbWFuLMKgPC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
Yj48YnI+PC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj5Nci4gQ8O2bmlnLCB3ZSBoYXZlIHRh
bGtlZCBhYm91dCBNTUlPIHByb2JsZW0gYmVmb3JlLiBZb3UgaGVscGVkIG1lIGEgbG90IGFib3V0
IHRoYXQgYW5kIG5vdyBkcml2ZXIgaXMgbm90IGdpdmluZyBhbnkgZXJyb3IgYWJvdXQgTU1JTy4g
VGhhdCBwcm9ibGVtIHdhcyBhYm91dCBidXMgY29uZmlndXJhdGlvbiBvZiBteSBlbWJlZGRlZCBz
eXN0ZW0uIEl0IGRvZXMgbm90IHByb2NlZWQgbW9yZSB0aGFuIDRHQiBiZXNpZGVzIDB4MCBhZHJl
c3MgaXMgYWxpZ25lZCBmb3IgSS9PIGFuZCBNTUlPIGlzIGFsbG93ZWQgYmV0d2VlbiAweEUwMDAw
MDAwIGFuZCAweGZmZmZmZmZmLiBGb3J0dW5hdGVseSwgSSBub3cgYW0gYWJsZSB0byBjbGFpbSAy
NTYgTUIgYW5kIG90aGVyIDQgQkFScyBhZHJlc3MgYmV0d2VlbiB0aGlzIHJhbmdlLiBJIGNhbiBh
dHRhY2ggbHNwY2kgLXYgb3V0cHV0LsKgPC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj48YnI+
PC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj5Nci4gQnJpZGdtYW4sIEkgYW0gdXNpbmcgVS1i
b290IGFzIGJvb3Rsb2FkZXIgYW5kIHRoZSBzeXN0ZW0gaXMgNjQgYml0IFBvd2VyUGMgZTU1MDAg
Y29yZS4gVGhpcyBtZWFucyBiaWcgZW5kaWFuIGtlcm5lbC7CoDwvYj48L2Rpdj48ZGl2IGRpcj0i
YXV0byI+PGI+PGJyPjwvYj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGI+UmlnaHQgbm93LCB0aGUg
ZHJpdmVyICYjMzk7YW1kZ3B1JiMzOTsgaXMgaGF2aW5nIGVycm9yIHdoZW7CoDwvYj48L2Rpdj48
ZGl2IGRpcj0iYXV0byI+PGI+aXQgdHJpZXMgdG8gbG9hZCBzbWMgZmlybXdhcmUuIEkgdmUgYmVl
biB0cnlpbmcgdG8gc29sdmUgdGhpcyBwcm9ibGVtIGZvciBtb250aHMgYnV0IEkgaGF2ZW4mIzM5
O3Qgc29sdmUgaXQgeWV0LsKgPC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj48YnI+PC9iPjwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj5PdGhlciBmaXJtd2FyZXMgc2VlbXMgbG9hZGluZyB3aXRo
b3V0IGFueSBlcnJvci4gSSB3YXMgc3VzcGVjdGluZyB0aGF0IGVuZGlhbm5lc3MgaXMgY2F1c2lu
ZyB0aGlzIHByb2JsZW0gYnV0IGlmIGl0IHdhcyBzaG91bGRuJiMzOTt0IG90aGVyIGZpcm13YXJl
cyBnZXQgZmFpbCBiZWZvcmUgc21jIGZpcm13YXJlIGdldHMgbG9hZGVkP8KgPC9iPjwvZGl2Pjxk
aXYgZGlyPSJhdXRvIj48Yj48YnI+PC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj5JIHRyaWVk
IGFsbCBvZiB0aGUgZmlybXdhcmVzIGluIHJlcG9zaXRvcnkgYnV0IHJlc3VsdCByZW1haW5lZCBz
YW1lLsKgPC9iPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48Yj48YnI+PC9iPjwvZGl2PjxkaXY+PGI+
RnVsbCBkbWVzZzo8L2I+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5bIMKgIMKgNS40MjYwMDld
IFtkcm1dIGFtZGdwdSBrZXJuZWwgbW9kZXNldHRpbmcgZW5hYmxlZC7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPGJyPjwvZGl2PlsgwqAgwqA1LjQzMDEw
OV0gW2RybV0gaW5pdGlhbGl6aW5nIGtlcm5lbCBtb2Rlc2V0dGluZyAoUE9MQVJJUzEyIDB4MTAw
MjoweDY5ODcgMHgxNzg3OjB4MjM4OSAweDgwKS4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDM3NTkxXSBbZHJtXSByZWdpc3RlciBtbWlvIGJhc2U6
IDB4MjAyMDAwMDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+WyDCoCDCoDUuNDQwODk5XSBbZHJtXSByZWdpc3RlciBtbWlvIHNpemU6IDI2
MjE0NCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj5bIMKgIMKgNS40NDM4ODhdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgMCAm
bHQ7dmlfY29tbW9uJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj5bIMKgIMKgNS40NDc0NjVdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgMSAm
bHQ7Z21jX3Y4XzAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPlsgwqAgwqA1LjQ1MDk1M10gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAy
ICZsdDt0b25nYV9paCZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDU0NDQyXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVy
IDMgJmx0O3Bvd2VycGxheSZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDU4MDE4XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVy
IDQgJmx0O2RtJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS40NjA5NzldIFtkcm1dIGFkZCBpcCBibG9jayBu
dW1iZXIgNSAmbHQ7Z2Z4X3Y4XzAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjQ2NDQ2Nl0gW2RybV0gYWRkIGlwIGJsb2Nr
IG51bWJlciA2ICZsdDtzZG1hX3YzXzAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjQ2ODA0Ml0gW2RybV0gYWRkIGlwIGJsb2Nr
IG51bWJlciA3ICZsdDt1dmRfdjZfMCZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDcxNTMxXSBbZHJtXSBhZGQgaXAgYmxv
Y2sgbnVtYmVyIDggJmx0O3ZjZV92M18wJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS40NzUwNDddIFtkcm1dIFVWRCBpcyBl
bmFibGVkIGluIFZNIG1vZGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDc3OTI4XSBbZHJtXSBVVkQgRU5DIGlz
IGVuYWJsZWQgaW4gVk0gbW9kZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS40ODExNTRdIFtkcm1dIFZDRSBlbmFibGVkIGlu
IFZNIG1vZGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNzEyMzU1XSBBVE9NIEJJT1M6IDExMy1FUjE2
QkZDLTAwMSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS43MTQ4MzBdIFtkcm1dIEdQVSBwb3N0aW5n
IG5vdy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44MzM3MDRdIFtkcm1dIHZtIHNpemUg
aXMgNjQgR0IsIDIgbGV2ZWxzLCBibG9jayBzaXplIGlzIDEwLWJpdCwgZnJhZ21lbnQgc2l6ZSBp
cyA5LWJpdCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxi
cj5bIMKgIMKgNS44NDA5NTBdIGFtZGdwdSAwMDAxOjAxOjAwLjA6IEJBUiAyOiByZWxlYXNpbmcg
W21lbSAweDIyMDAwMDAwMC0weDIyMDFmZmZmZiA2NGJpdCBwcmVmXSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44NDc5MzBdIGFtZGdw
dSAwMDAxOjAxOjAwLjA6IEJBUiAwOiByZWxlYXNpbmcgW21lbSAweDIxMDAwMDAwMC0weDIxZmZm
ZmZmZiA2NGJpdCBwcmVmXSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj5bIMKgIMKgNS44NTU2ODhdIFtkcm06LmFtZGdwdV9kZXZpY2VfcmVzaXplX2Zi
X2JhciBbYW1kZ3B1XV0gKkVSUk9SKiBQcm9ibGVtIHJlc2l6aW5nIEJBUjAgKC0yKS4gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuODU1NzA2
XSBhbWRncHUgMDAwMTowMTowMC4wOiBCQVIgMDogYXNzaWduZWQgW21lbSAweDIzMDAwMDAwMC0w
eDIzZmZmZmZmZiA2NGJpdCBwcmVmXSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44Njk2NjNdIGFtZGdwdSAwMDAxOjAxOjAwLjA6IEJB
UiAyOiBhc3NpZ25lZCBbbWVtIDB4MjQwMDAwMDAwLTB4MjQwMWZmZmZmIDY0Yml0IHByZWZdIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1
Ljg3NjU4Ml0gYW1kZ3B1IDAwMDE6MDE6MDAuMDogVlJBTTogNDA5Nk0gMHgwMDAwMDBGNDAwMDAw
MDAwIC0gMHgwMDAwMDBGNEZGRkZGRkZGICg0MDk2TSB1c2VkKSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44ODQxNjBdIGFtZGdwdSAwMDAxOjAxOjAwLjA6
IEdBUlQ6IDI1Nk0gMHgwMDAwMDAwMDAwMDAwMDAwIC0gMHgwMDAwMDAwMDBGRkZGRkZGIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsg
wqAgwqA1Ljg5MDUxOV0gW2RybV0gRGV0ZWN0ZWQgVlJBTSBSQU09NDA5Nk0sIEJBUj0yNTZNIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1
Ljg5NDA5M10gW2RybV0gUkFNIHdpZHRoIDEyOGJpdHMgR0REUjUgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUu
ODk2OTQxXSBbVFRNXSBab25lIMKga2VybmVsOiBBdmFpbGFibGUgZ3JhcGhpY3MgbWVtb3J5OiA0
MDYyMzgwIGtpQiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS45MDIxNzddIFtUVE1d
IFpvbmUgwqAgZG1hMzI6IEF2YWlsYWJsZSBncmFwaGljcyBtZW1vcnk6IDIwOTcxNTIga2lCIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjkwNzQwMl0gW1RUTV0gSW5pdGlhbGl6aW5n
IHBvb2wgYWxsb2NhdG9yIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjkxMDQ2NF0gW1RUTV0gSW5pdGlhbGl6aW5nIERN
QSBwb29sIGFsbG9jYXRvciDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj5bIMKgIMKgNS45MTk5NzNdIFtkcm1dIGFtZGdwdTogNDA5Nk0gb2YgVlJB
TSBtZW1vcnkgcmVhZHkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+WyDCoCDCoDUuOTIzNjU5XSBbZHJtXSBhbWRncHU6IDQwOTZNIG9mIEdUVCBtZW1v
cnkgcmVhZHkuIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPlsgwqAgwqA1LjkyNzM1OF0gW2RybV0gR0FSVDogbnVtIGNwdSBwYWdlcyA2NTUzNiwgbnVt
IGdwdSBwYWdlcyA2NTUzNiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKg
NS45MzI5NTddIFtkcm1dIFBDSUUgR0FSVCBvZiAyNTZNIGVuYWJsZWQgKHRhYmxlIGF0IDB4MDAw
MDAwRjQwMDAwMDAwMCkuIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjkzOTEyMl0gW2RybV0g
Q2hhaW5lZCBJQiBzdXBwb3J0IGVuYWJsZWQhIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1Ljk0ODg3M10gW2RybV0gRm91
bmQgVVZEIGZpcm13YXJlIFZlcnNpb246IDEuNzkgRmFtaWx5IElEOiAxNiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS45NTM2NDddIFtkcm1dIFVWRCBFTkMgaXMgZGlz
YWJsZWQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuOTc1ODE4XSBbZHJtXSBGb3VuZCBWQ0UgZmly
bXdhcmUgVmVyc2lvbjogNTIuNCBCaW5hcnkgSUQ6IDMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+WyDCoCDCoDYuNDA0Nzc0XSBhbWRncHU6IFtwb3dlcnBsYXldIEZhaWxlZCB0byBz
ZW5kIE1lc3NhZ2UuIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
PlsgwqAgwqA2LjgzNTkwMl0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBTTVUgRmlybXdhcmUgc3RhcnQg
ZmFpbGVkISDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKg
Ni44NDAwODZdIGFtZGdwdTogW3Bvd2VycGxheV0gRmFpbGVkIHRvIGxvYWQgU01VIHVjb2RlLiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNi44NDQxODRd
IGFtZGdwdTogW3Bvd2VycGxheV0gc21jIHN0YXJ0IGZhaWxlZCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj48Yj5bIMKgIMKgNi44NDc0OThd
IGFtZGdwdTogW3Bvd2VycGxheV0gcG93ZXJwbGF5IGh3IGluaXQgZmFpbGVkwqA8L2I+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+PGI+WyDCoCDCoDYuODUyMjgx
XSBbZHJtOi5hbWRncHVfZGV2aWNlX2luaXQgW2FtZGdwdV1dICpFUlJPUiogaHdfaW5pdCBvZiBJ
UCBibG9jayAmbHQ7cG93ZXJwbGF5Jmd0OyBmYWlsZWQgLTIyPC9iPsKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+PGI+WyDCoCDCoDYuODU5ODgzXSBhbWRncHUgMDAwMTow
MTowMC4wOiBhbWRncHVfZGV2aWNlX2lwX2luaXQgZmFpbGVkwqA8L2I+wqAgwqAgwqAgwqAgwqAg
wqAgwqDCoDxiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA2Ljg2NDMzMF0gYW1kZ3B1IDAwMDE6MDE6
MDAuMDogRmF0YWwgZXJyb3IgZHVyaW5nIEdQVSBpbml0IMKgPC9iPsKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqDCoDxiPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA2Ljg2ODY4OV0gW2RybV0gYW1kZ3B1OiBm
aW5pc2hpbmcgZGV2aWNlLsKgPC9iPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPjxiPlsgwqAgwqA3LjMzOTQyN10gcGNpZXBvcnQg
MDAwMTowMDowMC4wOiBBRVI6IENvcnJlY3RlZCBlcnJvciByZWNlaXZlZDogMDAwMTowMDowMC4w
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPlsgwqAgwqA3LjM0NTM3NF0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiBQQ0ll
IEJ1cyBFcnJvcjogc2V2ZXJpdHk9Q29ycmVjdGVkLCB0eXBlPURhdGEgTGluayBMYXllciwgKFRy
YW5zbWl0dGVyIElEKSDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNy4zNTM5OTNdIHBjaWVw
b3J0IDAwMDE6MDA6MDAuMDogwqAgZGV2aWNlIFsxOTU3OjA4MjRdIGVycm9yIHN0YXR1cy9tYXNr
PTAwMDAxMDAwLzAwMDAyMDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPlsgwqAgwqA3LjM2MTA0N10gcGNpZXBvcnQgMDAwMTowMDowMC4wOiDCoCDCoFsx
Ml0gVGltZW91dCDCoCDCoDwvYj7CoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPlsgwqAgwqA3LjcwNjEzN10gYW1kZ3B1OiBbcG93ZXJwbGF5XSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2Fz
IGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgOC4xMjc2NjddIGFtZGdwdTogW3Bvd2VycGxheV0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRv
IHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDguOTY2MzMxXSBhbWRncHU6IFtwb3dl
cnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxh
c3QgbWVzc2FnZSB3YXMgZmFpbGVkIHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA5LjMyMDI5MF0gcGNpZXBv
cnQgMDAwMTowMDowMC4wOiBBRVI6IENvcnJlY3RlZCBlcnJvciByZWNlaXZlZDogMDAwMTowMDow
MC4wIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA5LjMyNjIyNl0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiBQ
Q0llIEJ1cyBFcnJvcjogc2V2ZXJpdHk9Q29ycmVjdGVkLCB0eXBlPURhdGEgTGluayBMYXllciwg
KFRyYW5zbWl0dGVyIElEKSDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgOS4zMzQ4NDVdIHBj
aWVwb3J0IDAwMDE6MDA6MDAuMDogwqAgZGV2aWNlIFsxOTU3OjA4MjRdIGVycm9yIHN0YXR1cy9t
YXNrPTAwMDAxMDAwLzAwMDAyMDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPGJyPlsgwqAgwqA5LjM0MTg5OV0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiDCoCDC
oFsxMl0gVGltZW91dCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj5bIMKgIMKgOS4zODc5NzVdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVz
c2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxMC4yMjY2MzZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNzYWdl
IHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxMC42NDgyNzVdIGFtZGdwdTogW3Bvd2VycGxh
eV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVk
IHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxMS40ODY5MzJdIGFtZGdwdTogW3Bv
d2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
bGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxMS45MDg1NzBdIGFtZGdw
dTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxMi43NDcyMjhd
IGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgbGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxMy4x
Njg4NjZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDC
oCAxNC4wMDc1MjNdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+WyDCoCAxNC40MjkxNjFdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEg
cmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+WyDCoCAxNS4yNjc4MTZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNzYWdlIHdhcyBmYWls
ZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+WyDCoCAxNS42ODk0NTZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQg
bWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxNi41MjgxMTRdIGFtZGdwdTogW3Bvd2VycGxheV0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNz
YWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxNi45NDk3NTZdIGFtZGdwdTogW3Bvd2Vy
cGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFp
bGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxNy43ODg0MTFdIGFtZGdwdTog
W3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgbGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxOC4yMTAwNTFdIGFt
ZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxOS4wNDg3
MTBdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAx
OS40NzAzNDddIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
WyDCoCAxOS43ODY3NzRdIFtUVE1dIEZpbmFsaXppbmcgcG9vbCBhbGxvY2F0b3IgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDC
oCAxOS43ODk2OTZdIFtUVE1dIEZpbmFsaXppbmcgRE1BIHBvb2wgYWxsb2NhdG9yIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgMTku
NzkzMDA0XSBbVFRNXSBab25lIMKga2VybmVsOiBVc2VkIG1lbW9yeSBhdCBleGl0OiAwIGtpQiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIDE5Ljc5NzIwOV0g
W1RUTV0gWm9uZSDCoCBkbWEzMjogVXNlZCBtZW1vcnkgYXQgZXhpdDogMCBraUIgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxOS44MDE0MTBdIFtkcm1dIGFt
ZGdwdTogdHRtIGZpbmFsaXplZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPGI+wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxOS44MDQ0OTZdIGFtZGdw
dTogcHJvYmUgb2YgMDAwMTowMTowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0yMsKgPC9iPjxicj48
L2Rpdj48L2Rpdj48ZGl2IHN0eWxlPSJoZWlnaHQ6MHB4Ij48L2Rpdj48L2Rpdj48ZGl2IHN0eWxl
PSJmb250LWZhbWlseTpzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMi44cHgiIGRpcj0iYXV0byI+PGJy
PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSIgZGlyPSJhdXRvIj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+MTggxZ51YiAyMDIwIFNhbCAxNzo0MyB0YXJpaGluZGUg
QnJpZGdtYW4sIEpvaG4gJmx0OzxhIGhyZWY9Im1haWx0bzpKb2huLkJyaWRnbWFuQGFtZC5jb20i
PkpvaG4uQnJpZGdtYW5AYW1kLmNvbTwvYT4mZ3Q7IMWfdW51IHlhemTEsTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQoNCg0KDQoNCjxkaXYg
ZGlyPSJsdHIiPg0KPHAgc3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFsO2ZvbnQtc2l6ZToxMHB0O2Nv
bG9yOiMwMDc4ZDc7bWFyZ2luOjE1cHQiIGFsaWduPSJMZWZ0Ij4NCltBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV08YnI+DQo8L3A+DQo8YnI+DQo8ZGl2
Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxBcmlhbCxIZWx2ZXRpY2Esc2Fucy1z
ZXJpZjtmb250LXNpemU6MTJwdDtjb2xvcjpyZ2IoMCwwLDApIj4NCiZndDtBbmQgd2UgYWxyZWFk
eSBjaGVja2VkLCAyNTZNQiBpcyB1bmZvcnR1bmF0ZWx5IHRoZSBtaW5pbXVtIHlvdSBjYW4gcmVz
aXplIHRoZSBWUkFNIEJBUiBvbiB0aGUgRTkxNzEgdG8uPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxl
PSJmb250LWZhbWlseTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6
ZToxMnB0O2NvbG9yOnJnYigwLDAsMCkiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250
LWZhbWlseTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0
O2NvbG9yOnJnYigwLDAsMCkiPg0KQWhoLCBPSy4uLiBJIGRpZG4mIzM5O3QgcmVhbGl6ZSB3ZSBo
YWQgYWxyZWFkeSBsb29rZWQgaW50byB0aGF0LiBJIGd1ZXNzIHRoYXQgYXBwcm9hY2ggaXNuJiMz
OTt0IGdvaW5nIHRvIHdvcmsuDQo8YnI+DQo8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5
OkNhbGlicmksQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQ7Y29sb3I6
cmdiKDAsMCwwKSI+DQo8YnI+DQo8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGli
cmksQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQ7Y29sb3I6cmdiKDAs
MCwwKSI+DQpZdXNlZiwgZ3Vlc3NpbmcgeW91IGFyZSB1c2luZyBhIDMyLWJpdCBDUFUgPyBJcyBp
dCBwb3NzaWJsZSB0byB0YWxrIHRvIHdob2V2ZXIgZG9lcyBTQklPUyBmb3IgeW91ciBwbGF0Zm9y
bSB0byBzZWUgaWYgeW91IGNvdWxkIG1heWJlIHJlZHVjZSBhZGRyZXNzIHNwYWNlIGFsbG9jYXRl
ZCB0byBSQU0gYW5kIGJ1bXAgdXAgdGhlIE1NSU8gc3BhY2UgPzxicj4NCjwvZGl2Pg0KPGRpdj4N
CjxkaXYgaWQ9Im1fLTE3MjcyNjE0MjU0NTkwNzM1MTJhcHBlbmRvbnNlbmQiPjwvZGl2Pg0KPGRp
diBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZjtm
b250LXNpemU6MTJwdDtjb2xvcjpyZ2IoMCwwLDApIj4NCjxicj4NCjwvZGl2Pg0KPGhyIHN0eWxl
PSJkaXNwbGF5OmlubGluZS1ibG9jazt3aWR0aDo5OCUiPg0KPGRpdiBpZD0ibV8tMTcyNzI2MTQy
NTQ1OTA3MzUxMmRpdlJwbHlGd2RNc2ciIGRpcj0ibHRyIj48Zm9udCBzdHlsZT0iZm9udC1zaXpl
OjExcHQiIGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIGNvbG9yPSIjMDAwMDAwIj48Yj5Gcm9t
OjwvYj4gQ2hyaXN0aWFuIEvDtm5pZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNrb2VuaWcubGVpY2h0
enVtZXJrZW5AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5ja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KPGI+U2VudDo8L2I+IEZl
YnJ1YXJ5IDE4LCAyMDIwIDk6MTkgQU08YnI+DQo8Yj5Ubzo8L2I+IEJyaWRnbWFuLCBKb2huICZs
dDs8YSBocmVmPSJtYWlsdG86Sm9obi5CcmlkZ21hbkBhbWQuY29tIiB0YXJnZXQ9Il9ibGFuayIg
cmVsPSJub3JlZmVycmVyIj5Kb2huLkJyaWRnbWFuQGFtZC5jb208L2E+Jmd0OzsgQWxleCBEZXVj
aGVyICZsdDs8YSBocmVmPSJtYWlsdG86YWxleGRldWNoZXJAZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayIgcmVsPSJub3JlZmVycmVyIj5hbGV4ZGV1Y2hlckBnbWFpbC5jb208L2E+Jmd0OzsgWXVz
dWYgQWx0xLFwYXJtYWsgJmx0OzxhIGhyZWY9Im1haWx0bzp5dXN1ZmFsdGkxOTk3QGdtYWlsLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciI+eXVzdWZhbHRpMTk5N0BnbWFpbC5j
b208L2E+Jmd0Ozxicj4NCjxiPkNjOjwvYj4gYW1kLWdmeCBsaXN0ICZsdDs8YSBocmVmPSJtYWls
dG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmciIHRhcmdldD0iX2JsYW5rIiByZWw9Im5v
cmVmZXJyZXIiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPC9hPiZndDs8YnI+DQo8Yj5T
dWJqZWN0OjwvYj4gUmU6IHdyaXRpbmcgY3VzdG9tIGRyaXZlciBmb3IgVkdBIGVtdWxhdGlvbiA/
PC9mb250Pg0KPGRpdj7CoDwvZGl2Pg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJiYWNrZ3JvdW5kLWNv
bG9yOiNmZmZmZmYiPg0KPGRpdj5UaGUgcHJvYmxlbSBZdXN1ZiBydW5zIGludG8gaXMgdGhhdCBo
aXMgcGxhdGZvcm0gaGFzIG11bHRpcGxlIFBDSWUgcm9vdCBodWJzLCBidXQgb25seSA1MTJNQiBv
ZiBNTUlPIGFkZHJlc3Mgc3BhY2UuIFRoYXQgaXMgbm90IGVub3VnaCB0byBmaXQgYWxsIHRoZSBC
QVJzIG9mIGFuIEU5MTcxIGludG8uPGJyPg0KPGJyPg0KQnV0IHdpdGhvdXQgdGhlIEJBUnMgbmVp
dGhlciB0aGUgVkdBIGVtdWxhdGlvbiBub3IgYW1kZ3B1IG5vdCBhbnl0aGluZyBlbHNlIHdpbGwg
d29yayBjb3JyZWN0bHkuPGJyPg0KPGJyPg0KQW5kIHdlIGFscmVhZHkgY2hlY2tlZCwgMjU2TUIg
aXMgdW5mb3J0dW5hdGVseSB0aGUgbWluaW11bSB5b3UgY2FuIHJlc2l6ZSB0aGUgVlJBTSBCQVIg
b24gdGhlIEU5MTcxIHRvLjxicj4NCjxicj4NCldoYXQgY291bGQgbWF5YmUgd29yayBpcyB0byB0
cmljayB0aGUgdXBzdHJlYW0gYnJpZGdlIG9mIHRoZSBWR0EgZGV2aWNlIGludG8gbm90IHJvdXRp
bmcgYWxsIHRoZSBhZGRyZXNzZXMgdG8gdGhlIEJBUnMgYW5kIGFjdHVhbGx5IHVzZSBvbmx5IGEg
c21hbGxlciBwb3J0aW9uIG9mIHZpc2libGUgVlJBTS4gQnV0IHRoYXQgd291bGQgYmUgaGlnaGx5
IGV4cGVyaW1lbnRhbCBhbmQgcmVxdWlyZXMgYSByYXRoZXIgYmlnIGhhY2sgaW50byB0aGUgUENJ
KGUpDQogc3Vic3lzdGVtIGluIHRoZSBMaW51eCBrZXJuZWwuPGJyPg0KPGJyPg0KUmVnYXJkcyw8
YnI+DQpDaHJpc3RpYW4uPGJyPg0KPGJyPg0KQW0gMTguMDIuMjAgdW0gMTU6MDggc2NocmllYiBC
cmlkZ21hbiwgSm9objo8YnI+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPg0KPHAg
c3R5bGU9Im1hcmdpbi10b3A6MHB4O21hcmdpbi1ib3R0b206MHB4O2ZvbnQtZmFtaWx5OkFyaWFs
O2ZvbnQtc2l6ZToxMHB0O2NvbG9yOiMwMDc4ZDc7bWFyZ2luOjE1cHQiIGFsaWduPSJMZWZ0Ij4N
CltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV08YnI+
DQo8L3A+DQo8YnI+DQo8ZGl2Pg0KPGRpdj5Eb2VzIHRoZSBWQklPUyBjb21lIHVwIHdpdGggc29t
ZXRoaW5nIGxpa2UgYSBzcGxhc2ggc2NyZWVuLCBpZSBpcyBWQklPUyBhYmxlIHRvIGluaXRpYWxp
emUgYW5kIGRyaXZlIHRoZSBjYXJkID88YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8
ZGl2PklmIHNvIHRoZW4gYW5vdGhlciBvcHRpb24gbWlnaHQgYmUgdG8gdXNlIGEgVkVTQSBkcml2
ZXIgcmF0aGVyIHRoYW4gVkdBLiA8YnI+DQo8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5
OkNhbGlicmksQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQ7Y29sb3I6
cmdiKDAsMCwwKSI+DQo8YnI+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWls
eTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0O2NvbG9y
OnJnYigwLDAsMCkiPg0KPGJyPg0KPC9kaXY+DQo8aHIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJs
b2NrO3dpZHRoOjk4JSI+DQo8ZGl2IGlkPSJtXy0xNzI3MjYxNDI1NDU5MDczNTEyeF9kaXZScGx5
RndkTXNnIiBkaXI9Imx0ciI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZToxMXB0IiBmYWNlPSJDYWxp
YnJpLCBzYW5zLXNlcmlmIiBjb2xvcj0iIzAwMDAwMCI+PGI+RnJvbTo8L2I+IGFtZC1nZngNCjxh
IGhyZWY9Im1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiB0YXJn
ZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj4NCiZsdDthbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnJmd0OzwvYT4gb24gYmVoYWxmIG9mIEFsZXggRGV1Y2hlciA8YSBocmVm
PSJtYWlsdG86YWxleGRldWNoZXJAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3Jl
ZmVycmVyIj4NCiZsdDthbGV4ZGV1Y2hlckBnbWFpbC5jb20mZ3Q7PC9hPjxicj4NCjxiPlNlbnQ6
PC9iPiBGZWJydWFyeSAxOCwgMjAyMCA4OjUwIEFNPGJyPg0KPGI+VG86PC9iPiBZdXN1ZiBBbHTE
sXBhcm1hayA8YSBocmVmPSJtYWlsdG86eXVzdWZhbHRpMTk5N0BnbWFpbC5jb20iIHRhcmdldD0i
X2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPg0KJmx0O3l1c3VmYWx0aTE5OTdAZ21haWwuY29tJmd0
OzwvYT48YnI+DQo8Yj5DYzo8L2I+IGFtZC1nZnggbGlzdCA8YSBocmVmPSJtYWlsdG86YW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmciIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIi
Pg0KJmx0O2FtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnJmd0OzwvYT48YnI+DQo8Yj5TdWJq
ZWN0OjwvYj4gUmU6IHdyaXRpbmcgY3VzdG9tIGRyaXZlciBmb3IgVkdBIGVtdWxhdGlvbiA/PC9m
b250Pg0KPGRpdj7CoDwvZGl2Pg0KPC9kaXY+DQo8ZGl2Pjxmb250IHNpemU9IjIiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTFwdCI+DQo8ZGl2Pk9uIFR1ZSwgRmViIDE4LCAyMDIwIGF0IDI6NTYg
QU0gWXVzdWYgQWx0xLFwYXJtYWs8YnI+DQo8YSBocmVmPSJtYWlsdG86eXVzdWZhbHRpMTk5N0Bn
bWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIiPiZsdDt5dXN1ZmFsdGkx
OTk3QGdtYWlsLmNvbSZndDs8L2E+IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7IEhlbGxvIEFN
RCB0ZWFtOzxicj4NCiZndDs8YnI+DQomZ3Q7IEkgaGF2ZSBFIDkxNzEgR1BVIGFuZCB3YW50IHRv
IHVzZSBpdCBvbiBhIGVtYmVkZGVkIHN5c3RlbSB3aGljaCBoYXMgbGltaXRlZCBNTUlPIHNwYWNl
IG9uIFBDSWUgYnVzIChNQVggNTEyIE1CKS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBJIHJlY2VpdmVk
IGZlZWRiYWNrcyB0aGF0IEkgY2FuIG9ubHkgdXNlIFZHQSBlbXVsYXRpb24gd2l0aCB0aGlzIG1l
bW9yeSBzcGFjZS4gSSB3YXMgdW5hYmxlIHRvIGdldCAmIzM5O2FtZGdwdSYjMzk7IGRyaXZlciB3
b3JraW5nIHdpdGggWG9yZyBkdWUgdG8gSSBoYWQgbWFueSBlcnJvcnMoZmlybXdhcmVzIGFyZSBu
b3QgbG9hZGluZykgaW4gZWFjaCBzdGVwIGFuZCB0aXJlZCBvZiBzb2x2aW5nIHRoZW0gb25lIGJ5
IG9uZS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBJIHdhbnQgdG8gd3JpdGUgYSBzaW1wbGUgY3VzdG9t
IGRyaXZlciBmb3IgdGhpcyBHUFUgd2l0aCBrZXJuZWwgdmVyc2lvbiA0LjE5Ljxicj4NCiZndDsg
SXMgaXQgcG9zc2libGUgdG8gcHJpbnQgc29tZSBjb2xvcnMgb24gc2NyZWVuIHdpdGggYSBjdXN0
b20gZHJpdmVyIG92ZXIgUENJZSBjb21tdW5pY2F0aW9uID8gb3Igd3JpdGluZyBzb21lIHdvcmRz
IG9uIHNjcmVlbiBhcyBWR0EgPzxicj4NCiZndDs8YnI+DQomZ3Q7IElmIGFuc3dlciBpcyB5ZXMs
IHRoZW4gd2hpY2ggY29kZSBwaWVjZXMgKG9uIGFtZGdwdSBkcml2ZXIgZm9sZGVyKSBvciByZWZl
cmVuY2UgZG9jdW1lbnRhdGlvbiBzaG91bGQgSSB1c2U/IEkgaGF2ZSBSZWdpc3RlciBSZWZlcmVu
Y2UgR3VpZGUucGRmLjxicj4NCiZndDs8YnI+DQomZ3Q7IEkgd2lsbCBiZSBhcHByZWNpYXRlZCBm
b3IgeW91ciBndWlkYW5jZS48YnI+DQo8YnI+DQpUaGF0IGlzIG5vdCBnb2luZyB0byBkbyB3aGF0
IHlvdSB3YW50IG9uIHlvdXIgcGxhdGZvcm0uwqAgVGhlIFZHQTxicj4NCmVtdWxhdGlvbiByZXF1
aXJlcyB0aGF0IHlvdSBzZXQgdXAgdGhlIGNhcmQgZmlyc3QgdG8gZW5hYmxlIGl0LCB3aGljaDxi
cj4NCmluIHR1cm4gcmVxdWlyZXMgTU1JTyBhY2Nlc3MgYW5kIHRodXMgeW91IGFyZSBiYWNrIHRv
IHNxdWFyZSBvbmUuPGJyPg0KPGJyPg0KQWxleDxicj4NCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fPGJyPg0KYW1kLWdmeCBtYWlsaW5nIGxpc3Q8YnI+DQo8
YSBocmVmPSJtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmciIHRhcmdldD0iX2Js
YW5rIiByZWw9Im5vcmVmZXJyZXIiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPC9hPjxi
cj4NCjxhIGhyZWY9Imh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0pvaG4uQnJpZGdtYW4lNDBhbWQu
Y29tJTdDY2RhNTQ2OWI2ZjVmNGFlNDNlNmQwOGQ3YjQ3ZDg5OWElN0MzZGQ4OTYxZmU0ODg0ZTYw
OGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc2MzIzNTg3MDAzOTU4JmFtcDtzZGF0YT02
ZUtvNTFqbkhiRTFRV2tEQiUyQk4lMkZGTE1MQjQwSEEyd1ZOM21VMWwlMkZlRmhrJTNEJmFtcDty
ZXNlcnZlZD0wIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj5odHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDthbXA7
ZGF0YT0wMiU3QzAxJTdDam9obi5icmlkZ21hbiU0MGFtZC5jb20lN0NlN2JmMjI0Nzc1YWQ0ODdk
MjQwNzA4ZDdiNDc5OTJmNCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2MzcxNzYzMDY1NjEzMjg1NjAmYW1wO2FtcDtzZGF0YT1RYmZhSU4lMkY2THZnVWloejVP
MHg0MVR3dmRHWXk3UVRTNUlWSnEzUlhZbEElM0QmYW1wO2FtcDtyZXNlcnZlZD0wPC9hPjxicj4N
CjwvZGl2Pg0KPC9zcGFuPjwvZm9udD48L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8YnI+DQo8Zmll
bGRzZXQ+PC9maWVsZHNldD4NCjxwcmU+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQo8YSBocmVmPSJtYWlsdG86YW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmciIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJy
ZXIiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPC9hPg0KPGEgaHJlZj0iaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wMiU3QzAxJTdDSm9obi5CcmlkZ21hbiU0MGFtZC5jb20lN0NjZGE1NDY5YjZmNWY0YWU0
M2U2ZDA4ZDdiNDdkODk5YSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2MzcxNzYzMjM1ODcwMDM5NTgmYW1wO3NkYXRhPTZlS281MWpuSGJFMVFXa0RCJTJCTiUy
RkZMTUxCNDBIQTJ3Vk4zbVUxbCUyRmVGaGslM0QmYW1wO3Jlc2VydmVkPTAiIHRhcmdldD0iX2Js
YW5rIiByZWw9Im5vcmVmZXJyZXIiPmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeDwvYT4NCjwvcHJlPg0KPC9ibG9ja3F1b3RlPg0KPGJyPjxicj4N
CjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KDQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9k
aXY+DQo=
--0000000000000b87a9059edaf18f--

--===============1220659383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1220659383==--
