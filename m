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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFFC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 19:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9016C24125
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 19:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9XAr4Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9016C24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB056EA6F;
	Tue, 18 Feb 2020 19:08:22 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E32726EA6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 18:59:43 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id s10so3883216wmh.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 10:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/nF0YWYLS1PKYgYEay9n5fu8TlohNqATjr9CfN0ezas=;
 b=G9XAr4Dx+nUd0D5Olmc4M8WAdAd58sZ7C9HDIz5ue2G1qxDms4Berhckn0a5n/uDNY
 AIP+idwmzWJea8Z98gCUWu6hYIQJVpdhLfnwfjbBuFobAnfkN74nVOpncZ9WjBGcCaLp
 dyZSQwrjZ+qytrxHJxg1DsoeMPWZo1d8LuC0v04O4ADTPwAM2f+SD+ROz8sT/lhlvVVz
 LD9Uoy6RICZaPZG20VWVFLlCCVrMbzcOqcjF71wFVqROj/GmFyQAeAx8iU5xaaAccj44
 DbgIwneOLdtNRvfyyJOyMBd0716a4Gzer9RpsCNVjxt5mRF5apj+ClBeggqC6QL1Nogi
 4tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/nF0YWYLS1PKYgYEay9n5fu8TlohNqATjr9CfN0ezas=;
 b=jfZBlhxDlQYGYsUyX665tv1NHVlFAXmscjWpVOLhwAGIwWwEoW8AhLhBbZPMq5s+EW
 EgLox61VhL7UfNKzundrQD6eEkePU8oIsXv33wggA7qDHZYldyzkb9v6XZLtfbrGKLv/
 0aFLgzmX/E+k+ZB5qsbImUoP4MfkvHuhS7ZomaVXbXjWrP2Npc9ZwBlAoyLvWg9GcWVA
 YajFNaNNfrhHUw+OamOBtP48KnHB2xBKEfiFG/BcWC1u598n/LnsX2CC+/gHOdBNSKF6
 hUqaue5Lta/v6UHxDXmSH1ZxapkFE4VwPvubPCKi5K8PY8CicSSOyqDnvmnSk3HB9os5
 uMiQ==
X-Gm-Message-State: APjAAAVLWsciFwtyIHc1QdSk9ue6mc61n0Kjz7/gGCuklEzPodBfyF24
 CB5fzN+w0l4Adu/LPfhHYvLOXmI/FKTPGAmylI8=
X-Google-Smtp-Source: APXvYqyOutdYXu19HJq3wJp8hJ3wDwMBlBBD0gJCcgoYgD7yFH407glvzPQJHbDz/DQOEsqq5x0m7EiP4Xu5pR48QPw=
X-Received: by 2002:a1c:964f:: with SMTP id y76mr4511305wmd.62.1582052382407; 
 Tue, 18 Feb 2020 10:59:42 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
 <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
 <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
 <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
 <CAGzVRjy8DRGxwgkz3-0=Jc06FNQRVzP3OrwdFwMNSAR09qvJgA@mail.gmail.com>
 <cf2ec61f-4a27-262f-ea8f-ad148d7faf8a@gmail.com>
In-Reply-To: <cf2ec61f-4a27-262f-ea8f-ad148d7faf8a@gmail.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Tue, 18 Feb 2020 21:59:31 +0300
Message-ID: <CAGzVRjy93E_CBWMdW0BNCN+ctAsb5AYwJ1ASD1ojfBEt9=cZ9Q@mail.gmail.com>
Subject: Re: writing custom driver for VGA emulation ?
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Tue, 18 Feb 2020 19:08:21 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0338861054=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0338861054==
Content-Type: multipart/alternative; boundary="00000000000044fee8059ede464c"

--00000000000044fee8059ede464c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christian,

Even if powerplay fails, gpu driver seems still working according to output
of "lsmod' command. I can see amdgpu there. Is that means driver can do its
job without powerplay support ?

If so, how does userspace programs like Xorg or as you mentioned Vesa can
interact with driver. I see no driver node named 'amdgpu' under '/dev/'
directory or subdirectories ? Does this driver provide a driver node ?

By the way, thanks for your interest.

Best regards.


Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>, 18 =C5=9Eub 2020 S=
al, 18:33
tarihinde =C5=9Funu yazd=C4=B1:

> Hi Yusuf,
>
> good to hear that you were able to solve your MMIO problems.
>
> And yes amdgpu has unfortunately some bugs on big endian systems.
>
> But as John noted when you solved the issues with the MMIO BARs you can
> also use the Vesa driver with the VGA emulation.
>
> Regards,
> Christian.
>
> Am 18.02.20 um 16:00 schrieb Yusuf Alt=C4=B1parmak:
>
> *Hello Mr. Alex, Mr. C=C3=B6nig and Mr. Bridgman, *
>
> *Mr. C=C3=B6nig, we have talked about MMIO problem before. You helped me =
a lot
> about that and now driver is not giving any error about MMIO. That proble=
m
> was about bus configuration of my embedded system. It does not proceed mo=
re
> than 4GB besides 0x0 adress is aligned for I/O and MMIO is allowed betwee=
n
> 0xE0000000 and 0xffffffff. Fortunately, I now am able to claim 256 MB and
> other 4 BARs adress between this range. I can attach lspci -v output. *
>
> *Mr. Bridgman, I am using U-boot as bootloader and the system is 64 bit
> PowerPc e5500 core. This means big endian kernel. *
>
> *Right now, the driver 'amdgpu' is having error when *
> *it tries to load smc firmware. I ve been trying to solve this problem fo=
r
> months but I haven't solve it yet. *
>
> *Other firmwares seems loading without any error. I was suspecting that
> endianness is causing this problem but if it was shouldn't other firmware=
s
> get fail before smc firmware gets loaded? *
>
> *I tried all of the firmwares in repository but result remained same. *
>
> *Full dmesg:*
> [    5.426009] [drm] amdgpu kernel modesetting enabled.
>
> [    5.430109] [drm] initializing kernel modesetting (POLARIS12
> 0x1002:0x6987 0x1787:0x2389 0x80).
> [    5.437591] [drm] register mmio base: 0x20200000
>
> [    5.440899] [drm] register mmio size: 262144
>
> [    5.443888] [drm] add ip block number 0 <vi_common>
>
> [    5.447465] [drm] add ip block number 1 <gmc_v8_0>
>
> [    5.450953] [drm] add ip block number 2 <tonga_ih>
>
> [    5.454442] [drm] add ip block number 3 <powerplay>
>
> [    5.458018] [drm] add ip block number 4 <dm>
>
> [    5.460979] [drm] add ip block number 5 <gfx_v8_0>
>
> [    5.464466] [drm] add ip block number 6 <sdma_v3_0>
>
> [    5.468042] [drm] add ip block number 7 <uvd_v6_0>
>
> [    5.471531] [drm] add ip block number 8 <vce_v3_0>
>
> [    5.475047] [drm] UVD is enabled in VM mode
>
> [    5.477928] [drm] UVD ENC is enabled in VM mode
>
> [    5.481154] [drm] VCE enabled in VM mode
>
> [    5.712355] ATOM BIOS: 113-ER16BFC-001
>
> [    5.714830] [drm] GPU posting now...
>
> [    5.833704] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
> fragment size is 9-bit
> [    5.840950] amdgpu 0001:01:00.0: BAR 2: releasing [mem
> 0x220000000-0x2201fffff 64bit pref]
> [    5.847930] amdgpu 0001:01:00.0: BAR 0: releasing [mem
> 0x210000000-0x21fffffff 64bit pref]
> [    5.855688] [drm:.amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* Proble=
m
> resizing BAR0 (-2).
> [    5.855706] amdgpu 0001:01:00.0: BAR 0: assigned [mem
> 0x230000000-0x23fffffff 64bit pref]
> [    5.869663] amdgpu 0001:01:00.0: BAR 2: assigned [mem
> 0x240000000-0x2401fffff 64bit pref]
> [    5.876582] amdgpu 0001:01:00.0: VRAM: 4096M 0x000000F400000000 -
> 0x000000F4FFFFFFFF (4096M used)
> [    5.884160] amdgpu 0001:01:00.0: GART: 256M 0x0000000000000000 -
> 0x000000000FFFFFFF
> [    5.890519] [drm] Detected VRAM RAM=3D4096M, BAR=3D256M
>
> [    5.894093] [drm] RAM width 128bits GDDR5
>
> [    5.896941] [TTM] Zone  kernel: Available graphics memory: 4062380 kiB
>
> [    5.902177] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
>
> [    5.907402] [TTM] Initializing pool allocator
>
> [    5.910464] [TTM] Initializing DMA pool allocator
>
> [    5.919973] [drm] amdgpu: 4096M of VRAM memory ready
>
> [    5.923659] [drm] amdgpu: 4096M of GTT memory ready.
>
> [    5.927358] [drm] GART: num cpu pages 65536, num gpu pages 65536
>
> [    5.932957] [drm] PCIE GART of 256M enabled (table at
> 0x000000F400000000).
> [    5.939122] [drm] Chained IB support enabled!
>
> [    5.948873] [drm] Found UVD firmware Version: 1.79 Family ID: 16
>
> [    5.953647] [drm] UVD ENC is disabled
>
> [    5.975818] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
>
> [    6.404774] amdgpu: [powerplay] Failed to send Message.
>
> [    6.835902] amdgpu: [powerplay] SMU Firmware start failed!
>
> [    6.840086] amdgpu: [powerplay] Failed to load SMU ucode.
>
> [    6.844184] amdgpu: [powerplay] smc start failed
>
> *[    6.847498] amdgpu: [powerplay] powerplay hw init failed *
>
> *[    6.852281] [drm:.amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP
> block <powerplay> failed -22*
> *[    6.859883] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed *
>
> *                                              [    6.864330] amdgpu
> 0001:01:00.0: Fatal error during GPU init  *
> *                                          [    6.868689] [drm] amdgpu:
> finishing device. *
>
>
>
>
> *[    7.339427] pcieport 0001:00:00.0: AER: Corrected error received:
> 0001:00:00.0                                             [    7.345374]
> pcieport 0001:00:00.0: PCIe Bus Error: severity=3DCorrected, type=3DData =
Link
> Layer, (Transmitter ID)             [    7.353993] pcieport 0001:00:00.0:
> device [1957:0824] error status/mask=3D00001000/00002000
>           [    7.361047] pcieport 0001:00:00.0:    [12] Timeout    *
>
> [    7.706137] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [    8.127667] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [    8.966331] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [    9.320290] pcieport 0001:00:00.0: AER: Corrected error received:
> 0001:00:00.0
> [    9.326226] pcieport 0001:00:00.0: PCIe Bus Error: severity=3DCorrecte=
d,
> type=3DData Link Layer, (Transmitter ID)
> [    9.334845] pcieport 0001:00:00.0:   device [1957:0824] error
> status/mask=3D00001000/00002000
> [    9.341899] pcieport 0001:00:00.0:    [12] Timeout
>
> [    9.387975] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   10.226636] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   10.648275] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   11.486932] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   11.908570] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   12.747228] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   13.168866] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   14.007523] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   14.429161] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   15.267816] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   15.689456] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   16.528114] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   16.949756] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   17.788411] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   18.210051] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   19.048710] amdgpu: [powerplay]
>
>                 last message was failed ret is 0
>
> [   19.470347] amdgpu: [powerplay]
>
>                 failed to send message 261 ret is 0
>
> [   19.786774] [TTM] Finalizing pool allocator
>
> [   19.789696] [TTM] Finalizing DMA pool allocator
>
> [   19.793004] [TTM] Zone  kernel: Used memory at exit: 0 kiB
>
> [   19.797209] [TTM] Zone   dma32: Used memory at exit: 0 kiB
>
> [   19.801410] [drm] amdgpu: ttm finalized
>
> *                            [   19.804496] amdgpu: probe of 0001:01:00.0
> failed with error -22 *
>
>
> 18 =C5=9Eub 2020 Sal 17:43 tarihinde Bridgman, John <John.Bridgman@amd.co=
m>
> =C5=9Funu yazd=C4=B1:
>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> >And we already checked, 256MB is unfortunately the minimum you can
>> resize the VRAM BAR on the E9171 to.
>>
>> Ahh, OK... I didn't realize we had already looked into that. I guess tha=
t
>> approach isn't going to work.
>>
>> Yusef, guessing you are using a 32-bit CPU ? Is it possible to talk to
>> whoever does SBIOS for your platform to see if you could maybe reduce
>> address space allocated to RAM and bump up the MMIO space ?
>>
>> ------------------------------
>> *From:* Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>> *Sent:* February 18, 2020 9:19 AM
>> *To:* Bridgman, John <John.Bridgman@amd.com>; Alex Deucher <
>> alexdeucher@gmail.com>; Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com>
>> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: writing custom driver for VGA emulation ?
>>
>> The problem Yusuf runs into is that his platform has multiple PCIe root
>> hubs, but only 512MB of MMIO address space. That is not enough to fit al=
l
>> the BARs of an E9171 into.
>>
>> But without the BARs neither the VGA emulation nor amdgpu not anything
>> else will work correctly.
>>
>> And we already checked, 256MB is unfortunately the minimum you can resiz=
e
>> the VRAM BAR on the E9171 to.
>>
>> What could maybe work is to trick the upstream bridge of the VGA device
>> into not routing all the addresses to the BARs and actually use only a
>> smaller portion of visible VRAM. But that would be highly experimental a=
nd
>> requires a rather big hack into the PCI(e) subsystem in the Linux kernel=
.
>>
>> Regards,
>> Christian.
>>
>> Am 18.02.20 um 15:08 schrieb Bridgman, John:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Does the VBIOS come up with something like a splash screen, ie is VBIOS
>> able to initialize and drive the card ?
>>
>> If so then another option might be to use a VESA driver rather than VGA.
>>
>>
>> ------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>> <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deucher
>> <alexdeucher@gmail.com> <alexdeucher@gmail.com>
>> *Sent:* February 18, 2020 8:50 AM
>> *To:* Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com>
>> <yusufalti1997@gmail.com>
>> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
>> <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: writing custom driver for VGA emulation ?
>>
>> On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt=C4=B1parmak
>> <yusufalti1997@gmail.com> <yusufalti1997@gmail.com> wrote:
>> >
>> > Hello AMD team;
>> >
>> > I have E 9171 GPU and want to use it on a embedded system which has
>> limited MMIO space on PCIe bus (MAX 512 MB).
>> >
>> > I received feedbacks that I can only use VGA emulation with this memor=
y
>> space. I was unable to get 'amdgpu' driver working with Xorg due to I ha=
d
>> many errors(firmwares are not loading) in each step and tired of solving
>> them one by one.
>> >
>> > I want to write a simple custom driver for this GPU with kernel versio=
n
>> 4.19.
>> > Is it possible to print some colors on screen with a custom driver ove=
r
>> PCIe communication ? or writing some words on screen as VGA ?
>> >
>> > If answer is yes, then which code pieces (on amdgpu driver folder) or
>> reference documentation should I use? I have Register Reference Guide.pd=
f.
>> >
>> > I will be appreciated for your guidance.
>>
>> That is not going to do what you want on your platform.  The VGA
>> emulation requires that you set up the card first to enable it, which
>> in turn requires MMIO access and thus you are back to square one.
>>
>> Alex
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>>
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.=
bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=3DQbfaIN%2F6LvgUihz5O0=
x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=3D0
>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CJohn.Bri=
dgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637176323587003958&sdata=3D6eKo51jnHbE1QWkDB%2BN%2FFLM=
LB40HA2wVN3mU1l%2FeFhk%3D&reserved=3D0>
>>
>> _______________________________________________
>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook=
.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-=
gfx&data=3D02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d=
899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&sdata=
=3D6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=3D0>
>>
>>
>>
>>
> _______________________________________________
> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--00000000000044fee8059ede464c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG8gQ2hyaXN0aWFuLDxkaXY+PGJyPjwvZGl2PjxkaXY+RXZlbiBp
ZiBwb3dlcnBsYXkgZmFpbHMsIGdwdSBkcml2ZXIgc2VlbXMgc3RpbGwgd29ya2luZyBhY2NvcmRp
bmcgdG8gb3V0cHV0IG9mICZxdW90O2xzbW9kJiMzOTsgY29tbWFuZC4gSSBjYW4gc2VlIGFtZGdw
dSB0aGVyZS4gSXMgdGhhdCBtZWFucyBkcml2ZXIgY2FuIGRvIGl0cyBqb2Igd2l0aG91dCBwb3dl
cnBsYXkgc3VwcG9ydCA/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JZiBzbywgaG93IGRvZXMg
dXNlcnNwYWNlIHByb2dyYW1zIGxpa2UgWG9yZyBvciBhcyB5b3UgbWVudGlvbmVkIFZlc2EgY2Fu
IGludGVyYWN0IHdpdGggZHJpdmVyLiBJIHNlZSBubyBkcml2ZXIgbm9kZSBuYW1lZCAmIzM5O2Ft
ZGdwdSYjMzk7IHVuZGVyICYjMzk7L2Rldi8mIzM5OyBkaXJlY3Rvcnkgb3Igc3ViZGlyZWN0b3Jp
ZXMgPyBEb2VzIHRoaXMgZHJpdmVyIHByb3ZpZGUgYSBkcml2ZXIgbm9kZSA/PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5CeSB0aGUgd2F5LCB0aGFua3MgZm9yIHlvdXIgaW50ZXJlc3QuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJy
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0
ciI+Q2hyaXN0aWFuIEvDtm5pZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBn
bWFpbC5jb208L2E+Jmd0OywgMTggxZ51YiAyMDIwIFNhbCwgMTg6MzMgdGFyaWhpbmRlIMWfdW51
IHlhemTEsTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KICANCiAgICANCiAgDQogIDxkaXYgYmdjb2xvcj0i
I0ZGRkZGRiI+DQogICAgPGRpdj5IaSBZdXN1Ziw8YnI+DQogICAgICA8YnI+DQogICAgICBnb29k
IHRvIGhlYXIgdGhhdCB5b3Ugd2VyZSBhYmxlIHRvIHNvbHZlIHlvdXIgTU1JTyBwcm9ibGVtcy48
YnI+DQogICAgICA8YnI+DQogICAgICBBbmQgeWVzIGFtZGdwdSBoYXMgdW5mb3J0dW5hdGVseSBz
b21lIGJ1Z3Mgb24gYmlnIGVuZGlhbiBzeXN0ZW1zLjxicj4NCiAgICAgIDxicj4NCiAgICAgIEJ1
dCBhcyBKb2huIG5vdGVkIHdoZW4geW91IHNvbHZlZCB0aGUgaXNzdWVzIHdpdGggdGhlIE1NSU8g
QkFScw0KICAgICAgeW91IGNhbiBhbHNvIHVzZSB0aGUgVmVzYSBkcml2ZXIgd2l0aCB0aGUgVkdB
IGVtdWxhdGlvbi48YnI+DQogICAgICA8YnI+DQogICAgICBSZWdhcmRzLDxicj4NCiAgICAgIENo
cmlzdGlhbi48YnI+DQogICAgICA8YnI+DQogICAgICBBbSAxOC4wMi4yMCB1bSAxNjowMCBzY2hy
aWViIFl1c3VmIEFsdMSxcGFybWFrOjxicj4NCiAgICA8L2Rpdj4NCiAgICA8YmxvY2txdW90ZSB0
eXBlPSJjaXRlIj4NCiAgICAgIA0KICAgICAgPGRpdiBkaXI9ImF1dG8iPg0KICAgICAgICA8ZGl2
IHN0eWxlPSJmb250LWZhbWlseTpzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMi44cHgiIGRpcj0iYXV0
byI+DQogICAgICAgICAgPGRpdiBzdHlsZT0id2lkdGg6MzI4cHg7bWFyZ2luOjE2cHggMHB4Ij4N
CiAgICAgICAgICAgIDxkaXYgZGlyPSJsdHIiPg0KICAgICAgICAgICAgICA8ZGl2IGRpcj0iYXV0
byI+PGI+SGVsbG8gTXIuIEFsZXgsIE1yLiBDw7ZuaWcgYW5kIE1yLg0KICAgICAgICAgICAgICAg
ICAgQnJpZGdtYW4swqA8L2I+PC9kaXY+DQogICAgICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj48
Yj48YnI+DQogICAgICAgICAgICAgICAgPC9iPjwvZGl2Pg0KICAgICAgICAgICAgICA8ZGl2IGRp
cj0iYXV0byI+PGI+TXIuIEPDtm5pZywgd2UgaGF2ZSB0YWxrZWQgYWJvdXQgTU1JTw0KICAgICAg
ICAgICAgICAgICAgcHJvYmxlbSBiZWZvcmUuIFlvdSBoZWxwZWQgbWUgYSBsb3QgYWJvdXQgdGhh
dCBhbmQgbm93DQogICAgICAgICAgICAgICAgICBkcml2ZXIgaXMgbm90IGdpdmluZyBhbnkgZXJy
b3IgYWJvdXQgTU1JTy4gVGhhdA0KICAgICAgICAgICAgICAgICAgcHJvYmxlbSB3YXMgYWJvdXQg
YnVzIGNvbmZpZ3VyYXRpb24gb2YgbXkgZW1iZWRkZWQNCiAgICAgICAgICAgICAgICAgIHN5c3Rl
bS4gSXQgZG9lcyBub3QgcHJvY2VlZCBtb3JlIHRoYW4gNEdCIGJlc2lkZXMgMHgwDQogICAgICAg
ICAgICAgICAgICBhZHJlc3MgaXMgYWxpZ25lZCBmb3IgSS9PIGFuZCBNTUlPIGlzIGFsbG93ZWQg
YmV0d2Vlbg0KICAgICAgICAgICAgICAgICAgMHhFMDAwMDAwMCBhbmQgMHhmZmZmZmZmZi4gRm9y
dHVuYXRlbHksIEkgbm93IGFtIGFibGUNCiAgICAgICAgICAgICAgICAgIHRvIGNsYWltIDI1NiBN
QiBhbmQgb3RoZXIgNCBCQVJzIGFkcmVzcyBiZXR3ZWVuIHRoaXMNCiAgICAgICAgICAgICAgICAg
IHJhbmdlLiBJIGNhbiBhdHRhY2ggbHNwY2kgLXYgb3V0cHV0LsKgPC9iPjwvZGl2Pg0KICAgICAg
ICAgICAgICA8ZGl2IGRpcj0iYXV0byI+PGI+PGJyPg0KICAgICAgICAgICAgICAgIDwvYj48L2Rp
dj4NCiAgICAgICAgICAgICAgPGRpdiBkaXI9ImF1dG8iPjxiPk1yLiBCcmlkZ21hbiwgSSBhbSB1
c2luZyBVLWJvb3QgYXMNCiAgICAgICAgICAgICAgICAgIGJvb3Rsb2FkZXIgYW5kIHRoZSBzeXN0
ZW0gaXMgNjQgYml0IFBvd2VyUGMgZTU1MDANCiAgICAgICAgICAgICAgICAgIGNvcmUuIFRoaXMg
bWVhbnMgYmlnIGVuZGlhbiBrZXJuZWwuwqA8L2I+PC9kaXY+DQogICAgICAgICAgICAgIDxkaXYg
ZGlyPSJhdXRvIj48Yj48YnI+DQogICAgICAgICAgICAgICAgPC9iPjwvZGl2Pg0KICAgICAgICAg
ICAgICA8ZGl2IGRpcj0iYXV0byI+PGI+UmlnaHQgbm93LCB0aGUgZHJpdmVyICYjMzk7YW1kZ3B1
JiMzOTsgaXMNCiAgICAgICAgICAgICAgICAgIGhhdmluZyBlcnJvciB3aGVuwqA8L2I+PC9kaXY+
DQogICAgICAgICAgICAgIDxkaXYgZGlyPSJhdXRvIj48Yj5pdCB0cmllcyB0byBsb2FkIHNtYyBm
aXJtd2FyZS4gSSB2ZQ0KICAgICAgICAgICAgICAgICAgYmVlbiB0cnlpbmcgdG8gc29sdmUgdGhp
cyBwcm9ibGVtIGZvciBtb250aHMgYnV0IEkNCiAgICAgICAgICAgICAgICAgIGhhdmVuJiMzOTt0
IHNvbHZlIGl0IHlldC7CoDwvYj48L2Rpdj4NCiAgICAgICAgICAgICAgPGRpdiBkaXI9ImF1dG8i
PjxiPjxicj4NCiAgICAgICAgICAgICAgICA8L2I+PC9kaXY+DQogICAgICAgICAgICAgIDxkaXYg
ZGlyPSJhdXRvIj48Yj5PdGhlciBmaXJtd2FyZXMgc2VlbXMgbG9hZGluZyB3aXRob3V0DQogICAg
ICAgICAgICAgICAgICBhbnkgZXJyb3IuIEkgd2FzIHN1c3BlY3RpbmcgdGhhdCBlbmRpYW5uZXNz
IGlzIGNhdXNpbmcNCiAgICAgICAgICAgICAgICAgIHRoaXMgcHJvYmxlbSBidXQgaWYgaXQgd2Fz
IHNob3VsZG4mIzM5O3Qgb3RoZXIgZmlybXdhcmVzDQogICAgICAgICAgICAgICAgICBnZXQgZmFp
bCBiZWZvcmUgc21jIGZpcm13YXJlIGdldHMgbG9hZGVkP8KgPC9iPjwvZGl2Pg0KICAgICAgICAg
ICAgICA8ZGl2IGRpcj0iYXV0byI+PGI+PGJyPg0KICAgICAgICAgICAgICAgIDwvYj48L2Rpdj4N
CiAgICAgICAgICAgICAgPGRpdiBkaXI9ImF1dG8iPjxiPkkgdHJpZWQgYWxsIG9mIHRoZSBmaXJt
d2FyZXMgaW4NCiAgICAgICAgICAgICAgICAgIHJlcG9zaXRvcnkgYnV0IHJlc3VsdCByZW1haW5l
ZCBzYW1lLsKgPC9iPjwvZGl2Pg0KICAgICAgICAgICAgICA8ZGl2IGRpcj0iYXV0byI+PGI+PGJy
Pg0KICAgICAgICAgICAgICAgIDwvYj48L2Rpdj4NCiAgICAgICAgICAgICAgPGRpdj48Yj5GdWxs
IGRtZXNnOjwvYj48YnI+DQogICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICA8ZGl2
IGRpcj0iYXV0byI+WyDCoCDCoDUuNDI2MDA5XSBbZHJtXSBhbWRncHUga2VybmVsDQogICAgICAg
ICAgICAgICAgbW9kZXNldHRpbmcgZW5hYmxlZC7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8YnI+DQogICAgICAgICAgICAg
IDwvZGl2Pg0KICAgICAgICAgICAgICBbIMKgIMKgNS40MzAxMDldIFtkcm1dIGluaXRpYWxpemlu
ZyBrZXJuZWwgbW9kZXNldHRpbmcNCiAgICAgICAgICAgICAgKFBPTEFSSVMxMiAweDEwMDI6MHg2
OTg3IDB4MTc4NzoweDIzODkgMHg4MCkuIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNS40Mzc1OTFd
IFtkcm1dIHJlZ2lzdGVyIG1taW8gYmFzZTogMHgyMDIwMDAwMCDCoCDCoCDCoA0KICAgICAgICAg
ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDC
oCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDUuNDQwODk5XSBbZHJtXSByZWdpc3Rl
ciBtbWlvIHNpemU6IDI2MjE0NCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoDxicj4N
CiAgICAgICAgICAgICAgWyDCoCDCoDUuNDQzODg4XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVy
IDANCiAgICAgICAgICAgICAgJmx0O3ZpX2NvbW1vbiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAg
ICAgIFsgwqAgwqA1LjQ0NzQ2NV0gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAxDQogICAgICAg
ICAgICAgICZsdDtnbWNfdjhfMCZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAg
wqA1LjQ1MDk1M10gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAyDQogICAgICAgICAgICAgICZs
dDt0b25nYV9paCZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1LjQ1NDQ0
Ml0gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAzDQogICAgICAgICAgICAgICZsdDtwb3dlcnBs
YXkmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNS40NTgwMThdIFtkcm1dIGFk
ZCBpcCBibG9jayBudW1iZXIgNCAmbHQ7ZG0mZ3Q7IMKgIMKgDQogICAgICAgICAgICAgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNS40NjA5NzldIFtkcm1dIGFkZCBpcCBi
bG9jayBudW1iZXIgNQ0KICAgICAgICAgICAgICAmbHQ7Z2Z4X3Y4XzAmZ3Q7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAg
ICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJy
Pg0KICAgICAgICAgICAgICBbIMKgIMKgNS40NjQ0NjZdIFtkcm1dIGFkZCBpcCBibG9jayBudW1i
ZXIgNg0KICAgICAgICAgICAgICAmbHQ7c2RtYV92M18wJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAg
ICAgICAgWyDCoCDCoDUuNDY4MDQyXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDcNCiAgICAg
ICAgICAgICAgJmx0O3V2ZF92Nl8wJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDC
oCDCoDUuNDcxNTMxXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDgNCiAgICAgICAgICAgICAg
Jmx0O3ZjZV92M18wJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDUuNDc1
MDQ3XSBbZHJtXSBVVkQgaXMgZW5hYmxlZCBpbiBWTSBtb2RlIMKgIMKgIMKgIMKgIMKgIMKgDQog
ICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAg
IMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNS40Nzc5MjhdIFtkcm1dIFVW
RCBFTkMgaXMgZW5hYmxlZCBpbiBWTSBtb2RlIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJy
Pg0KICAgICAgICAgICAgICBbIMKgIMKgNS40ODExNTRdIFtkcm1dIFZDRSBlbmFibGVkIGluIFZN
IG1vZGUgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAg
ICAgICAgIFsgwqAgwqA1LjcxMjM1NV0gQVRPTSBCSU9TOiAxMTMtRVIxNkJGQy0wMDEgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsg
wqAgwqA1LjcxNDgzMF0gW2RybV0gR1BVIHBvc3Rpbmcgbm93Li4uIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQog
ICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNS44
MzM3MDRdIFtkcm1dIHZtIHNpemUgaXMgNjQgR0IsIDIgbGV2ZWxzLCBibG9jaw0KICAgICAgICAg
ICAgICBzaXplIGlzIDEwLWJpdCwgZnJhZ21lbnQgc2l6ZSBpcyA5LWJpdCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiAg
ICAgICAgICAgICAgWyDCoCDCoDUuODQwOTUwXSBhbWRncHUgMDAwMTowMTowMC4wOiBCQVIgMjog
cmVsZWFzaW5nIFttZW0NCiAgICAgICAgICAgICAgMHgyMjAwMDAwMDAtMHgyMjAxZmZmZmYgNjRi
aXQgcHJlZl0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAg
wqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1Ljg0NzkzMF0gYW1kZ3B1
IDAwMDE6MDE6MDAuMDogQkFSIDA6IHJlbGVhc2luZyBbbWVtDQogICAgICAgICAgICAgIDB4MjEw
MDAwMDAwLTB4MjFmZmZmZmZmIDY0Yml0IHByZWZdIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBb
IMKgIMKgNS44NTU2ODhdIFtkcm06LmFtZGdwdV9kZXZpY2VfcmVzaXplX2ZiX2JhciBbYW1kZ3B1
XV0NCiAgICAgICAgICAgICAgKkVSUk9SKiBQcm9ibGVtIHJlc2l6aW5nIEJBUjAgKC0yKS4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8
YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1Ljg1NTcwNl0gYW1kZ3B1IDAwMDE6MDE6MDAuMDog
QkFSIDA6IGFzc2lnbmVkIFttZW0NCiAgICAgICAgICAgICAgMHgyMzAwMDAwMDAtMHgyM2ZmZmZm
ZmYgNjRiaXQgcHJlZl0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAg
ICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1Ljg2OTY2M10g
YW1kZ3B1IDAwMDE6MDE6MDAuMDogQkFSIDI6IGFzc2lnbmVkIFttZW0NCiAgICAgICAgICAgICAg
MHgyNDAwMDAwMDAtMHgyNDAxZmZmZmYgNjRiaXQgcHJlZl0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAg
ICAgIFsgwqAgwqA1Ljg3NjU4Ml0gYW1kZ3B1IDAwMDE6MDE6MDAuMDogVlJBTTogNDA5Nk0NCiAg
ICAgICAgICAgICAgMHgwMDAwMDBGNDAwMDAwMDAwIC0gMHgwMDAwMDBGNEZGRkZGRkZGICg0MDk2
TSB1c2VkKSDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDUuODg0MTYwXSBhbWRncHUgMDAwMTowMTowMC4w
OiBHQVJUOiAyNTZNDQogICAgICAgICAgICAgIDB4MDAwMDAwMDAwMDAwMDAwMCAtIDB4MDAwMDAw
MDAwRkZGRkZGRiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDUuODkw
NTE5XSBbZHJtXSBEZXRlY3RlZCBWUkFNIFJBTT00MDk2TSwgQkFSPTI1Nk0gwqAgwqANCiAgICAg
ICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAg
wqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1Ljg5NDA5M10gW2RybV0gUkFNIHdp
ZHRoIDEyOGJpdHMgR0REUjUgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+
DQogICAgICAgICAgICAgIFsgwqAgwqA1Ljg5Njk0MV0gW1RUTV0gWm9uZSDCoGtlcm5lbDogQXZh
aWxhYmxlIGdyYXBoaWNzDQogICAgICAgICAgICAgIG1lbW9yeTogNDA2MjM4MCBraUIgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAg
ICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1
LjkwMjE3N10gW1RUTV0gWm9uZSDCoCBkbWEzMjogQXZhaWxhYmxlIGdyYXBoaWNzDQogICAgICAg
ICAgICAgIG1lbW9yeTogMjA5NzE1MiBraUIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAg
wqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1LjkwNzQwMl0gW1RUTV0gSW5pdGlhbGl6
aW5nIHBvb2wgYWxsb2NhdG9yIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAg
ICAgICAgICAgICBbIMKgIMKgNS45MTA0NjRdIFtUVE1dIEluaXRpYWxpemluZyBETUEgcG9vbCBh
bGxvY2F0b3IgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAg
wqA1LjkxOTk3M10gW2RybV0gYW1kZ3B1OiA0MDk2TSBvZiBWUkFNIG1lbW9yeSByZWFkeSDCoA0K
ICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAg
ICDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDUuOTIzNjU5XSBbZHJt
XSBhbWRncHU6IDQwOTZNIG9mIEdUVCBtZW1vcnkgcmVhZHkuIMKgDQogICAgICAgICAgICAgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNS45MjczNThdIFtkcm1dIEdBUlQ6IG51bSBjcHUg
cGFnZXMgNjU1MzYsIG51bSBncHUNCiAgICAgICAgICAgICAgcGFnZXMgNjU1MzYgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsg
wqAgwqA1LjkzMjk1N10gW2RybV0gUENJRSBHQVJUIG9mIDI1Nk0gZW5hYmxlZCAodGFibGUgYXQN
CiAgICAgICAgICAgICAgMHgwMDAwMDBGNDAwMDAwMDAwKS4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAg
wqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1LjkzOTEyMl0gW2RybV0gQ2hhaW5l
ZCBJQiBzdXBwb3J0IGVuYWJsZWQhIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0K
ICAgICAgICAgICAgICBbIMKgIMKgNS45NDg4NzNdIFtkcm1dIEZvdW5kIFVWRCBmaXJtd2FyZSBW
ZXJzaW9uOiAxLjc5DQogICAgICAgICAgICAgIEZhbWlseSBJRDogMTYgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAg
ICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgwqA1
Ljk1MzY0N10gW2RybV0gVVZEIEVOQyBpcyBkaXNhYmxlZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAg
ICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDUuOTc1ODE4XSBb
ZHJtXSBGb3VuZCBWQ0UgZmlybXdhcmUgVmVyc2lvbjogNTIuNA0KICAgICAgICAgICAgICBCaW5h
cnkgSUQ6IDMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+
DQogICAgICAgICAgICAgIFsgwqAgwqA2LjQwNDc3NF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBGYWls
ZWQgdG8gc2VuZCBNZXNzYWdlLg0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDC
oCDCoDYuODM1OTAyXSBhbWRncHU6IFtwb3dlcnBsYXldIFNNVSBGaXJtd2FyZSBzdGFydA0KICAg
ICAgICAgICAgICBmYWlsZWQhIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgNi44NDAwODZdIGFtZGdw
dTogW3Bvd2VycGxheV0gRmFpbGVkIHRvIGxvYWQgU01VDQogICAgICAgICAgICAgIHVjb2RlLiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiAgICAgICAgICAgICAgWyDCoCDCoDYuODQ0MTg0XSBhbWRncHU6IFtwb3dlcnBsYXldIHNtYyBz
dGFydCBmYWlsZWQgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAg
IDxiPlsgwqAgwqA2Ljg0NzQ5OF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBwb3dlcnBsYXkgaHcgaW5p
dA0KICAgICAgICAgICAgICAgIGZhaWxlZMKgPC9iPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICA8Yj5bIMKg
IMKgNi44NTIyODFdIFtkcm06LmFtZGdwdV9kZXZpY2VfaW5pdCBbYW1kZ3B1XV0NCiAgICAgICAg
ICAgICAgICAqRVJST1IqIGh3X2luaXQgb2YgSVAgYmxvY2sgJmx0O3Bvd2VycGxheSZndDsgZmFp
bGVkIC0yMjwvYj7CoMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KICAgICAgICAgICAgICA8Yj5bIMKgIMKgNi44NTk4ODNdIGFtZGdwdSAwMDAx
OjAxOjAwLjA6DQogICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV9pcF9pbml0IGZhaWxlZMKg
PC9iPsKgIMKgIMKgIMKgIMKgIMKgIMKgwqA8Yj7CoCDCoCDCoA0KICAgICAgICAgICAgICAgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PGJyPg0KICAgICAgICAgICAgICAgIFsgwqAgwqA2Ljg2NDMzMF0gYW1kZ3B1IDAwMDE6MDE6MDAu
MDogRmF0YWwgZXJyb3IgZHVyaW5nDQogICAgICAgICAgICAgICAgR1BVIGluaXQgwqA8L2I+wqDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPGI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqANCiAgICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4N
CiAgICAgICAgICAgICAgICBbIMKgIMKgNi44Njg2ODldIFtkcm1dIGFtZGdwdTogZmluaXNoaW5n
IGRldmljZS7CoDwvYj7CoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAg
ICAgICAgICAgPGI+WyDCoCDCoDcuMzM5NDI3XSBwY2llcG9ydCAwMDAxOjAwOjAwLjA6IEFFUjog
Q29ycmVjdGVkDQogICAgICAgICAgICAgICAgZXJyb3IgcmVjZWl2ZWQ6IDAwMDE6MDA6MDAuMCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICAgIFsgwqAgwqA3LjM0
NTM3NF0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiBQQ0llIEJ1cyBFcnJvcjoNCiAgICAgICAgICAg
ICAgICBzZXZlcml0eT1Db3JyZWN0ZWQsIHR5cGU9RGF0YSBMaW5rIExheWVyLCAoVHJhbnNtaXR0
ZXINCiAgICAgICAgICAgICAgICBJRCkgwqAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAg
ICAgICAgWyDCoCDCoDcuMzUzOTkzXSBwY2llcG9ydCAwMDAxOjAwOjAwLjA6IMKgIGRldmljZQ0K
ICAgICAgICAgICAgICAgIFsxOTU3OjA4MjRdIGVycm9yIHN0YXR1cy9tYXNrPTAwMDAxMDAwLzAw
MDAyMDAwIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgICAgWyDCoCDCoDcuMzYxMDQ3XSBwY2llcG9y
dCAwMDAxOjAwOjAwLjA6IMKgIMKgWzEyXSBUaW1lb3V0IMKgDQogICAgICAgICAgICAgICAgwqA8
L2I+wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDcuNzA2MTM3XSBhbWRncHU6IFtwb3dl
cnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKg
PGJyPg0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ug
d2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAg
ICAgICAgICAgICAgWyDCoCDCoDguMTI3NjY3XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAg
ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDI2MSBy
ZXQgaXMgMCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDC
oCDCoDguOTY2MzMxXSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
DQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDC
oCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAg
ICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDkuMzIwMjkwXSBw
Y2llcG9ydCAwMDAxOjAwOjAwLjA6IEFFUjogQ29ycmVjdGVkIGVycm9yDQogICAgICAgICAgICAg
IHJlY2VpdmVkOiAwMDAxOjAwOjAwLjAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAg
ICAgICAgICAgIFsgwqAgwqA5LjMyNjIyNl0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiBQQ0llIEJ1
cyBFcnJvcjoNCiAgICAgICAgICAgICAgc2V2ZXJpdHk9Q29ycmVjdGVkLCB0eXBlPURhdGEgTGlu
ayBMYXllciwgKFRyYW5zbWl0dGVyIElEKQ0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDC
oDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDkuMzM0ODQ1XSBwY2llcG9ydCAwMDAxOjAwOjAw
LjA6IMKgIGRldmljZSBbMTk1NzowODI0XQ0KICAgICAgICAgICAgICBlcnJvciBzdGF0dXMvbWFz
az0wMDAwMTAwMC8wMDAwMjAwMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAg
ICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCDCoDkuMzQxODk5
XSBwY2llcG9ydCAwMDAxOjAwOjAwLjA6IMKgIMKgWzEyXSBUaW1lb3V0IMKgIMKgDQogICAgICAg
ICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKg
IMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIMKgOS4zODc5NzVdIGFtZGdwdTogW3Bv
d2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAg
wqA8YnI+DQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBz
ZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgPGJyPg0K
ICAgICAgICAgICAgICBbIMKgIDEwLjIyNjYzNl0gYW1kZ3B1OiBbcG93ZXJwbGF5XSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAg
ICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0
IGlzIDAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsg
wqAgMTAuNjQ4Mjc1XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
DQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDI2MSByZXQgaXMgMCDCoCDCoCDC
oA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAg
ICAgICDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCAxMS40ODY5MzJdIGFt
ZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAg
ICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAg
wqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxh
c3QgbWVzc2FnZSB3YXMgZmFpbGVkIHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAg
ICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKg
IMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIDExLjkwODU3MF0gYW1kZ3B1OiBbcG93ZXJwbGF5
XSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4N
CiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVz
c2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAg
ICAgICAgIFsgwqAgMTIuNzQ3MjI4XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDC
oCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCAxMy4x
Njg4NjZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAg
ICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKgDQogICAg
ICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIDE0LjAwNzUyM10gYW1kZ3B1OiBb
cG93ZXJwbGF5XSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAg
ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDC
oCDCoDxicj4NCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGFzdCBtZXNz
YWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+
DQogICAgICAgICAgICAgIFsgwqAgMTQuNDI5MTYxXSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAg
ICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDI2
MSByZXQgaXMgMCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAg
WyDCoCAxNS4yNjc4MTZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGxhc3QgbWVzc2FnZSB3YXMgZmFpbGVkIHJldCBpcyAwIMKgIMKgIMKg
IMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAg
ICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIDE1LjY4OTQ1Nl0g
YW1kZ3B1OiBbcG93ZXJwbGF5XSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0K
ICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAg
ICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAgwqAgwqANCiAgICAgICAgICAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAg
wqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgMTYuNTI4MTE0XSBhbWRncHU6IFtwb3dlcnBs
YXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJy
Pg0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2Fz
IGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAg
ICAgICAgICAgWyDCoCAxNi45NDk3NTZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBp
cyAwIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
DQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIDE3
Ljc4ODQxMV0gYW1kZ3B1OiBbcG93ZXJwbGF5XSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAg
ICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgbGFzdCBtZXNzYWdlIHdhcyBmYWlsZWQgcmV0IGlzIDAgwqAgwqAgwqAgwqAgwqAN
CiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAg
ICAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgMTguMjEwMDUxXSBhbWRncHU6
IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAg
ICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKg
IMKgIMKgPGJyPg0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWlsZWQg
dG8gc2VuZCBtZXNzYWdlIDI2MSByZXQgaXMgMCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoDxi
cj4NCiAgICAgICAgICAgICAgWyDCoCAxOS4wNDg3MTBdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQogICAg
ICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxhc3QgbWVzc2FnZSB3YXMgZmFpbGVk
IHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAg
ICBbIMKgIDE5LjQ3MDM0N10gYW1kZ3B1OiBbcG93ZXJwbGF5XSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAyNjEgcmV0IGlzIDAgwqAg
wqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAg
ICAgICAgICAgwqAgwqAgwqAgwqAgwqA8YnI+DQogICAgICAgICAgICAgIFsgwqAgMTkuNzg2Nzc0
XSBbVFRNXSBGaW5hbGl6aW5nIHBvb2wgYWxsb2NhdG9yIMKgIMKgIMKgIMKgIMKgIMKgDQogICAg
ICAgICAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKg
IMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIDE5Ljc4OTY5Nl0gW1RUTV0gRmluYWxp
emluZyBETUEgcG9vbCBhbGxvY2F0b3IgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqANCiAgICAgICAgICAgICAgwqAgwqAgwqAgwqA8YnI+DQog
ICAgICAgICAgICAgIFsgwqAgMTkuNzkzMDA0XSBbVFRNXSBab25lIMKga2VybmVsOiBVc2VkIG1l
bW9yeSBhdCBleGl0OiAwDQogICAgICAgICAgICAgIGtpQiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oA0KICAgICAgICAgICAgICDCoCDCoCDCoCDCoCDCoDxicj4NCiAgICAgICAgICAgICAgWyDCoCAx
OS43OTcyMDldIFtUVE1dIFpvbmUgwqAgZG1hMzI6IFVzZWQgbWVtb3J5IGF0IGV4aXQ6IDANCiAg
ICAgICAgICAgICAga2lCIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAgIMKg
IMKgIMKgIMKgIMKgPGJyPg0KICAgICAgICAgICAgICBbIMKgIDE5LjgwMTQxMF0gW2RybV0gYW1k
Z3B1OiB0dG0gZmluYWxpemVkIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgDQogICAgICAgICAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
wqA8Yj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KICAgICAgICAgICAgICAgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KICAgICAgICAgICAgICAgIFsgwqAgMTkuODA0NDk2XSBhbWRncHU6IHByb2Jl
IG9mIDAwMDE6MDE6MDAuMCBmYWlsZWQgd2l0aA0KICAgICAgICAgICAgICAgIGVycm9yIC0yMsKg
PC9iPjxicj4NCiAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgIDwvZGl2Pg0KICAgICAgICA8
L2Rpdj4NCiAgICAgICAgPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6c2Fucy1zZXJpZjtmb250LXNp
emU6MTIuOHB4IiBkaXI9ImF1dG8iPjxicj4NCiAgICAgICAgPC9kaXY+DQogICAgICAgIDxicj4N
CiAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiIGRpcj0iYXV0byI+DQogICAgICAgICAg
PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPjE4IMWedWIgMjAyMCBTYWwgMTc6NDMN
CiAgICAgICAgICAgIHRhcmloaW5kZSBCcmlkZ21hbiwgSm9obiAmbHQ7PGEgaHJlZj0ibWFpbHRv
OkpvaG4uQnJpZGdtYW5AYW1kLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPkpvaG4uQnJpZGdtYW5AYW1k
LmNvbTwvYT4mZ3Q7DQogICAgICAgICAgICDFn3VudSB5YXpkxLE6PGJyPg0KICAgICAgICAgIDwv
ZGl2Pg0KICAgICAgICAgIDxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCiAgICAgICAgICAgIDxkaXYgZGlyPSJsdHIiPg0KICAg
ICAgICAgICAgICA8cCBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWw7Zm9udC1zaXplOjEwcHQ7Y29s
b3I6cmdiKDAsMTIwLDIxNSk7bWFyZ2luOjE1cHQiIGFsaWduPSJMZWZ0Ij4NCiAgICAgICAgICAg
ICAgICBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
PGJyPg0KICAgICAgICAgICAgICA8L3A+DQogICAgICAgICAgICAgIDxicj4NCiAgICAgICAgICAg
ICAgPGRpdj4NCiAgICAgICAgICAgICAgICA8ZGl2IHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJp
LEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0O2NvbG9yOnJnYigwLDAs
MCkiPiZndDtBbmQNCiAgICAgICAgICAgICAgICAgIHdlIGFscmVhZHkgY2hlY2tlZCwgMjU2TUIg
aXMgdW5mb3J0dW5hdGVseSB0aGUgbWluaW11bQ0KICAgICAgICAgICAgICAgICAgeW91IGNhbiBy
ZXNpemUgdGhlIFZSQU0gQkFSIG9uIHRoZSBFOTE3MSB0by48YnI+DQogICAgICAgICAgICAgICAg
PC9kaXY+DQogICAgICAgICAgICAgICAgPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxB
cmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNpemU6MTJwdDtjb2xvcjpyZ2IoMCwwLDAp
Ij48YnI+DQogICAgICAgICAgICAgICAgPC9kaXY+DQogICAgICAgICAgICAgICAgPGRpdiBzdHls
ZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNp
emU6MTJwdDtjb2xvcjpyZ2IoMCwwLDApIj5BaGgsDQogICAgICAgICAgICAgICAgICBPSy4uLiBJ
IGRpZG4mIzM5O3QgcmVhbGl6ZSB3ZSBoYWQgYWxyZWFkeSBsb29rZWQgaW50bw0KICAgICAgICAg
ICAgICAgICAgdGhhdC4gSSBndWVzcyB0aGF0IGFwcHJvYWNoIGlzbiYjMzk7dCBnb2luZyB0byB3
b3JrLg0KICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgIDwvZGl2Pg0KICAg
ICAgICAgICAgICAgIDxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksQXJpYWwsSGVsdmV0
aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQ7Y29sb3I6cmdiKDAsMCwwKSI+PGJyPg0KICAg
ICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICAgIDxkaXYgc3R5bGU9ImZvbnQtZmFt
aWx5OkNhbGlicmksQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQ7Y29s
b3I6cmdiKDAsMCwwKSI+WXVzZWYsDQogICAgICAgICAgICAgICAgICBndWVzc2luZyB5b3UgYXJl
IHVzaW5nIGEgMzItYml0IENQVSA/IElzIGl0IHBvc3NpYmxlDQogICAgICAgICAgICAgICAgICB0
byB0YWxrIHRvIHdob2V2ZXIgZG9lcyBTQklPUyBmb3IgeW91ciBwbGF0Zm9ybSB0byBzZWUNCiAg
ICAgICAgICAgICAgICAgIGlmIHlvdSBjb3VsZCBtYXliZSByZWR1Y2UgYWRkcmVzcyBzcGFjZSBh
bGxvY2F0ZWQgdG8NCiAgICAgICAgICAgICAgICAgIFJBTSBhbmQgYnVtcCB1cCB0aGUgTU1JTyBz
cGFjZSA/PGJyPg0KICAgICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICAgIDxkaXY+
DQogICAgICAgICAgICAgICAgICA8ZGl2IHN0eWxlPSJmb250LWZhbWlseTpDYWxpYnJpLEFyaWFs
LEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0O2NvbG9yOnJnYigwLDAsMCkiPjxi
cj4NCiAgICAgICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICAgICAgPGhyIHN0eWxl
PSJkaXNwbGF5OmlubGluZS1ibG9jazt3aWR0aDo5OCUiPg0KICAgICAgICAgICAgICAgICAgPGRp
diBpZD0ibV8tNTQ1MzM1NTk4NzczNTE0NTQwM2dtYWlsLW1fLTQ0MDUwODA1OTg0OTQ1MTU4NTVt
Xy0xNzI3MjYxNDI1NDU5MDczNTEyZGl2UnBseUZ3ZE1zZyIgZGlyPSJsdHIiPjxmb250IHN0eWxl
PSJmb250LXNpemU6MTFwdCIgZmFjZT0iQ2FsaWJyaSwgc2Fucy1zZXJpZiIgY29sb3I9IiMwMDAw
MDAiPjxiPkZyb206PC9iPg0KICAgICAgICAgICAgICAgICAgICAgIENocmlzdGlhbiBLw7ZuaWcg
Jmx0OzxhIGhyZWY9Im1haWx0bzpja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbSIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb208L2E+Jmd0Ozxicj4NCiAgICAgICAgICAgICAgICAgICAgICA8Yj5TZW50OjwvYj4gRmVi
cnVhcnkgMTgsIDIwMjAgOToxOSBBTTxicj4NCiAgICAgICAgICAgICAgICAgICAgICA8Yj5Ubzo8
L2I+IEJyaWRnbWFuLCBKb2huICZsdDs8YSBocmVmPSJtYWlsdG86Sm9obi5CcmlkZ21hbkBhbWQu
Y29tIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5Kb2huLkJyaWRnbWFuQGFtZC5j
b208L2E+Jmd0OzsNCiAgICAgICAgICAgICAgICAgICAgICBBbGV4IERldWNoZXIgJmx0OzxhIGhy
ZWY9Im1haWx0bzphbGV4ZGV1Y2hlckBnbWFpbC5jb20iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmFsZXhkZXVjaGVyQGdtYWlsLmNvbTwvYT4mZ3Q7Ow0KICAgICAgICAgICAgICAg
ICAgICAgIFl1c3VmIEFsdMSxcGFybWFrICZsdDs8YSBocmVmPSJtYWlsdG86eXVzdWZhbHRpMTk5
N0BnbWFpbC5jb20iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnl1c3VmYWx0aTE5
OTdAZ21haWwuY29tPC9hPiZndDs8YnI+DQogICAgICAgICAgICAgICAgICAgICAgPGI+Q2M6PC9i
PiBhbWQtZ2Z4IGxpc3QgJmx0OzxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc8L2E+Jmd0Ozxicj4NCiAgICAgICAgICAgICAgICAgICAgICA8Yj5TdWJq
ZWN0OjwvYj4gUmU6IHdyaXRpbmcgY3VzdG9tIGRyaXZlciBmb3IgVkdBDQogICAgICAgICAgICAg
ICAgICAgICAgZW11bGF0aW9uID88L2ZvbnQ+DQogICAgICAgICAgICAgICAgICAgIDxkaXY+wqA8
L2Rpdj4NCiAgICAgICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICAgICAgPGRpdiBz
dHlsZT0iYmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj4NCiAgICAgICAgICAgICAg
ICAgICAgPGRpdj5UaGUgcHJvYmxlbSBZdXN1ZiBydW5zIGludG8gaXMgdGhhdCBoaXMNCiAgICAg
ICAgICAgICAgICAgICAgICBwbGF0Zm9ybSBoYXMgbXVsdGlwbGUgUENJZSByb290IGh1YnMsIGJ1
dCBvbmx5DQogICAgICAgICAgICAgICAgICAgICAgNTEyTUIgb2YgTU1JTyBhZGRyZXNzIHNwYWNl
LiBUaGF0IGlzIG5vdCBlbm91Z2ggdG8NCiAgICAgICAgICAgICAgICAgICAgICBmaXQgYWxsIHRo
ZSBCQVJzIG9mIGFuIEU5MTcxIGludG8uPGJyPg0KICAgICAgICAgICAgICAgICAgICAgIDxicj4N
CiAgICAgICAgICAgICAgICAgICAgICBCdXQgd2l0aG91dCB0aGUgQkFScyBuZWl0aGVyIHRoZSBW
R0EgZW11bGF0aW9uIG5vcg0KICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdSBub3QgYW55dGhp
bmcgZWxzZSB3aWxsIHdvcmsgY29ycmVjdGx5Ljxicj4NCiAgICAgICAgICAgICAgICAgICAgICA8
YnI+DQogICAgICAgICAgICAgICAgICAgICAgQW5kIHdlIGFscmVhZHkgY2hlY2tlZCwgMjU2TUIg
aXMgdW5mb3J0dW5hdGVseSB0aGUNCiAgICAgICAgICAgICAgICAgICAgICBtaW5pbXVtIHlvdSBj
YW4gcmVzaXplIHRoZSBWUkFNIEJBUiBvbiB0aGUgRTkxNzENCiAgICAgICAgICAgICAgICAgICAg
ICB0by48YnI+DQogICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAg
ICAgIFdoYXQgY291bGQgbWF5YmUgd29yayBpcyB0byB0cmljayB0aGUgdXBzdHJlYW0NCiAgICAg
ICAgICAgICAgICAgICAgICBicmlkZ2Ugb2YgdGhlIFZHQSBkZXZpY2UgaW50byBub3Qgcm91dGlu
ZyBhbGwgdGhlDQogICAgICAgICAgICAgICAgICAgICAgYWRkcmVzc2VzIHRvIHRoZSBCQVJzIGFu
ZCBhY3R1YWxseSB1c2Ugb25seSBhDQogICAgICAgICAgICAgICAgICAgICAgc21hbGxlciBwb3J0
aW9uIG9mIHZpc2libGUgVlJBTS4gQnV0IHRoYXQgd291bGQgYmUNCiAgICAgICAgICAgICAgICAg
ICAgICBoaWdobHkgZXhwZXJpbWVudGFsIGFuZCByZXF1aXJlcyBhIHJhdGhlciBiaWcgaGFjaw0K
ICAgICAgICAgICAgICAgICAgICAgIGludG8gdGhlIFBDSShlKSBzdWJzeXN0ZW0gaW4gdGhlIExp
bnV4IGtlcm5lbC48YnI+DQogICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAg
ICAgICAgICAgIFJlZ2FyZHMsPGJyPg0KICAgICAgICAgICAgICAgICAgICAgIENocmlzdGlhbi48
YnI+DQogICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAgIEFt
IDE4LjAyLjIwIHVtIDE1OjA4IHNjaHJpZWIgQnJpZGdtYW4sIEpvaG46PGJyPg0KICAgICAgICAg
ICAgICAgICAgICA8L2Rpdj4NCiAgICAgICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSI+DQogICAgICAgICAgICAgICAgICAgICAgPHAgc3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFs
O2ZvbnQtc2l6ZToxMHB0O2NvbG9yOnJnYigwLDEyMCwyMTUpO21hcmdpbjoxNXB0IiBhbGlnbj0i
TGVmdCI+DQogICAgICAgICAgICAgICAgICAgICAgICBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0g
SW50ZXJuYWwgRGlzdHJpYnV0aW9uDQogICAgICAgICAgICAgICAgICAgICAgICBPbmx5XTxicj4N
CiAgICAgICAgICAgICAgICAgICAgICA8L3A+DQogICAgICAgICAgICAgICAgICAgICAgPGJyPg0K
ICAgICAgICAgICAgICAgICAgICAgIDxkaXY+DQogICAgICAgICAgICAgICAgICAgICAgICA8ZGl2
PkRvZXMgdGhlIFZCSU9TIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcgbGlrZQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICBhIHNwbGFzaCBzY3JlZW4sIGllIGlzIFZCSU9TIGFibGUgdG8NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW5pdGlhbGl6ZSBhbmQgZHJpdmUgdGhlIGNhcmQgPzxicj4N
CiAgICAgICAgICAgICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICAgICAgICAgICAg
PGRpdj48YnI+DQogICAgICAgICAgICAgICAgICAgICAgICA8L2Rpdj4NCiAgICAgICAgICAgICAg
ICAgICAgICAgIDxkaXY+SWYgc28gdGhlbiBhbm90aGVyIG9wdGlvbiBtaWdodCBiZSB0byB1c2Ug
YQ0KICAgICAgICAgICAgICAgICAgICAgICAgICBWRVNBIGRyaXZlciByYXRoZXIgdGhhbiBWR0Eu
IDxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgIDwvZGl2Pg0KICAgICAgICAgICAgICAgICAg
ICAgICAgPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSxBcmlhbCxIZWx2ZXRpY2Esc2Fu
cy1zZXJpZjtmb250LXNpemU6MTJwdDtjb2xvcjpyZ2IoMCwwLDApIj48YnI+DQogICAgICAgICAg
ICAgICAgICAgICAgICA8L2Rpdj4NCiAgICAgICAgICAgICAgICAgICAgICAgIDxkaXY+DQogICAg
ICAgICAgICAgICAgICAgICAgICAgIDxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksQXJp
YWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQ7Y29sb3I6cmdiKDAsMCwwKSI+
PGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICA8L2Rpdj4NCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgPGhyIHN0eWxlPSJkaXNwbGF5OmlubGluZS1ibG9jazt3aWR0aDo5OCUiPg0KICAg
ICAgICAgICAgICAgICAgICAgICAgICA8ZGl2IGlkPSJtXy01NDUzMzU1OTg3NzM1MTQ1NDAzZ21h
aWwtbV8tNDQwNTA4MDU5ODQ5NDUxNTg1NW1fLTE3MjcyNjE0MjU0NTkwNzM1MTJ4X2RpdlJwbHlG
d2RNc2ciIGRpcj0ibHRyIj48Zm9udCBzdHlsZT0iZm9udC1zaXplOjExcHQiIGZhY2U9IkNhbGli
cmksIHNhbnMtc2VyaWYiIGNvbG9yPSIjMDAwMDAwIj48Yj5Gcm9tOjwvYj4NCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGFtZC1nZngNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4NCiZsdDthbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnJmd0OzwvYT4gb24gYmVoYWxmIG9mIEFsZXgNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERldWNoZXIgPGEgaHJlZj0ibWFpbHRvOmFsZXhkZXVjaGVyQGdt
YWlsLmNvbSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZsdDthbGV4ZGV1Y2hlckBnbWFpbC5jb20mZ3Q7PC9hPjxicj4N
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPlNlbnQ6PC9iPiBGZWJydWFyeSAxOCwg
MjAyMCA4OjUwIEFNPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGI+VG86PC9i
PiBZdXN1ZiBBbHTEsXBhcm1hayA8YSBocmVmPSJtYWlsdG86eXVzdWZhbHRpMTk5N0BnbWFpbC5j
b20iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPg0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmbHQ7eXVzdWZhbHRpMTk5N0BnbWFpbC5jb20mZ3Q7PC9hPjxicj4NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxiPkNjOjwvYj4gYW1kLWdmeCBsaXN0IDxhIGhy
ZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyIgcmVsPSJub3JlZmVycmVy
IiB0YXJnZXQ9Il9ibGFuayI+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZsdDth
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyZndDs8L2E+PGJyPg0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPGI+U3ViamVjdDo8L2I+IFJlOiB3cml0aW5nIGN1c3RvbSBkcml2ZXIN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvciBWR0EgZW11bGF0aW9uID88L2ZvbnQ+
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgPGRpdj7CoDwvZGl2Pg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICA8L2Rpdj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgPGRpdj48Zm9u
dCBzaXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExcHQiPg0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8ZGl2Pk9uIFR1ZSwgRmViIDE4LCAyMDIwIGF0IDI6NTYgQU0NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBZdXN1ZiBBbHTEsXBhcm1hazxicj4NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8YSBocmVmPSJtYWlsdG86eXVzdWZhbHRp
MTk5N0BnbWFpbC5jb20iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPiZsdDt5dXN1
ZmFsdGkxOTk3QGdtYWlsLmNvbSZndDs8L2E+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgd3JvdGU6PGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDs8
YnI+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmd0OyBIZWxsbyBBTUQgdGVh
bTs8YnI+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmd0Ozxicj4NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZ3Q7IEkgaGF2ZSBFIDkxNzEgR1BVIGFuZCB3
YW50IHRvIHVzZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGl0IG9uIGEgZW1i
ZWRkZWQgc3lzdGVtIHdoaWNoIGhhcw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGxpbWl0ZWQgTU1JTyBzcGFjZSBvbiBQQ0llIGJ1cyAoTUFYDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgNTEyIE1CKS48YnI+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmd0Ozxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZ3Q7IEkg
cmVjZWl2ZWQgZmVlZGJhY2tzIHRoYXQgSSBjYW4NCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBvbmx5IHVzZSBWR0EgZW11bGF0aW9uIHdpdGggdGhpcw0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1lbW9yeSBzcGFjZS4gSSB3YXMgdW5hYmxlIHRvIGdldA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYjMzk7YW1kZ3B1JiMzOTsgZHJpdmVyIHdv
cmtpbmcgd2l0aCBYb3JnIGR1ZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRv
IEkgaGFkIG1hbnkgZXJyb3JzKGZpcm13YXJlcyBhcmUgbm90DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbG9hZGluZykgaW4gZWFjaCBzdGVwIGFuZCB0aXJlZCBvZg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNvbHZpbmcgdGhlbSBvbmUgYnkgb25lLjxicj4N
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZ3Q7PGJyPg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZndDsgSSB3YW50IHRvIHdyaXRlIGEgc2ltcGxlIGN1c3Rv
bQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRyaXZlciBmb3IgdGhpcyBHUFUg
d2l0aCBrZXJuZWwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZXJzaW9uIDQu
MTkuPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDsgSXMgaXQgcG9z
c2libGUgdG8gcHJpbnQgc29tZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bG9ycyBvbiBzY3JlZW4gd2l0aCBhIGN1c3RvbSBkcml2ZXINCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBvdmVyIFBDSWUgY29tbXVuaWNhdGlvbiA/IG9yIHdyaXRpbmcNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzb21lIHdvcmRzIG9uIHNjcmVlbiBhcyBWR0Eg
Pzxicj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZ3Q7PGJyPg0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDsgSWYgYW5zd2VyIGlzIHllcywgdGhlbiB3
aGljaCBjb2RlDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGllY2VzIChvbiBh
bWRncHUgZHJpdmVyIGZvbGRlcikgb3INCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZWZlcmVuY2UgZG9jdW1lbnRhdGlvbiBzaG91bGQgSSB1c2U/DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgSSBoYXZlIFJlZ2lzdGVyIFJlZmVyZW5jZSBHdWlkZS5wZGYuPGJy
Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDs8YnI+DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmd0OyBJIHdpbGwgYmUgYXBwcmVjaWF0ZWQgZm9yIHlv
dXINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBndWlkYW5jZS48YnI+DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFRoYXQgaXMgbm90IGdvaW5nIHRvIGRvIHdoYXQgeW91IHdhbnQNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvbiB5b3VyIHBsYXRmb3JtLsKgIFRoZSBWR0E8
YnI+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW11bGF0aW9uIHJlcXVpcmVz
IHRoYXQgeW91IHNldCB1cCB0aGUNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
YXJkIGZpcnN0IHRvIGVuYWJsZSBpdCwgd2hpY2g8YnI+DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW4gdHVybiByZXF1aXJlcyBNTUlPIGFjY2VzcyBhbmQgdGh1cw0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHlvdSBhcmUgYmFjayB0byBzcXVhcmUgb25lLjxi
cj4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8YnI+DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQWxleDxicj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fPGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZC1nZnggbWFpbGluZyBsaXN0PGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc8L2E+PGJyPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxhIGhyZWY9Imh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0pvaG4uQnJpZGdtYW4lNDBhbWQuY29tJTdDY2RhNTQ2OWI2
ZjVmNGFlNDNlNmQwOGQ3YjQ3ZDg5OWElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3MTc2MzIzNTg3MDAzOTU4JmFtcDtzZGF0YT02ZUtvNTFqbkhiRTFRV2tE
QiUyQk4lMkZGTE1MQjQwSEEyd1ZOM21VMWwlMkZlRmhrJTNEJmFtcDtyZXNlcnZlZD0wIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5v
cmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDthbXA7ZGF0YT0wMiU3QzAxJTdD
am9obi5icmlkZ21hbiU0MGFtZC5jb20lN0NlN2JmMjI0Nzc1YWQ0ODdkMjQwNzA4ZDdiNDc5OTJm
NCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzYzMDY1
NjEzMjg1NjAmYW1wO2FtcDtzZGF0YT1RYmZhSU4lMkY2THZnVWloejVPMHg0MVR3dmRHWXk3UVRT
NUlWSnEzUlhZbEElM0QmYW1wO2FtcDtyZXNlcnZlZD0wPC9hPjxicj4NCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPC9kaXY+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
L3NwYW4+PC9mb250PjwvZGl2Pg0KICAgICAgICAgICAgICAgICAgICAgICAgPC9kaXY+DQogICAg
ICAgICAgICAgICAgICAgICAgPC9kaXY+DQogICAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAg
ICAgICAgICAgICAgICAgICAgIDxmaWVsZHNldD48L2ZpZWxkc2V0Pg0KICAgICAgICAgICAgICAg
ICAgICAgIDxwcmU+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQo8YSBocmVmPSJtYWlsdG86YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmciIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPC9hPg0KPGEgaHJlZj0iaHR0cHM6Ly9uYW0xMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRl
c2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAx
JTdDSm9obi5CcmlkZ21hbiU0MGFtZC5jb20lN0NjZGE1NDY5YjZmNWY0YWU0M2U2ZDA4ZDdiNDdk
ODk5YSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzYz
MjM1ODcwMDM5NTgmYW1wO3NkYXRhPTZlS281MWpuSGJFMVFXa0RCJTJCTiUyRkZMTUxCNDBIQTJ3
Vk4zbVUxbCUyRmVGaGslM0QmYW1wO3Jlc2VydmVkPTAiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeDwvYT4NCjwvcHJlPg0KICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+DQog
ICAgICAgICAgICAgICAgICAgIDxicj4NCiAgICAgICAgICAgICAgICAgICAgPGJyPg0KICAgICAg
ICAgICAgICAgICAgPC9kaXY+DQogICAgICAgICAgICAgICAgPC9kaXY+DQogICAgICAgICAgICAg
IDwvZGl2Pg0KICAgICAgICAgICAgPC9kaXY+DQogICAgICAgICAgPC9ibG9ja3F1b3RlPg0KICAg
ICAgICA8L2Rpdj4NCiAgICAgIDwvZGl2Pg0KICAgICAgPGJyPg0KICAgICAgPGZpZWxkc2V0Pjwv
ZmllbGRzZXQ+DQogICAgICA8cHJlPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPGEgaHJlZj0ibWFpbHRvOmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiB0YXJnZXQ9Il9ibGFuayI+YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc8L2E+DQo8YSBocmVmPSJodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng8L2E+DQo8L3ByZT4NCiAg
ICA8L2Jsb2NrcXVvdGU+DQogICAgPGJyPg0KICA8L2Rpdj4NCg0KPC9ibG9ja3F1b3RlPjwvZGl2
PjwvZGl2Pg0K
--00000000000044fee8059ede464c--

--===============0338861054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0338861054==--
