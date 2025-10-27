Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAF3CCF9EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC83710E41C;
	Mon, 27 Oct 2025 09:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="STeW3p1K";
	dkim-atps=neutral
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED4210E115
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 08:31:40 +0000 (UTC)
Received: from relay11 (localhost.localdomain [127.0.0.1])
 by relay11.grserver.gr (Proxmox) with ESMTP id 8B534C379D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:31:38 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay11.grserver.gr (Proxmox) with ESMTPS id 75022C37B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:31:37 +0200 (EET)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id DEA08200BF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:31:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761553897;
 bh=6RwCK0VurZytvmkMh4u79GFzDSrKDS0i0KfMobygAGs=;
 h=Received:From:Subject:To;
 b=STeW3p1Krfs2GjK0zjoV3Qr5axi43W+bcK9ErPJ08tQfD1l0Gmb3M4z9m37HE5O/3
 U6KIqWC2QlaWcu5F/0saflbbz5hScQ/RoxGLOjtuioLTg2N2TUcTuCdrVBo1MvqheL
 MkFPsz265ZsqmAW96P3AFWuWr2fr+PpcANqx61N/CAneUdNR4cpAJRA/boTlCf+Mzh
 +Fmz/kKk0AzXQaUz1z3oj2gtdp0L+3ShP3NQoa4VdzsqI3Vdtt9LmCkFQkAUb3OLJn
 b1urbWJRaI7CppViMlJLZ16X7QrBDwm4cK5Gdro4hIi744eOymtlghmo8YDcyaletr
 n/tMpcxkcvPbQ==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.167.48) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lf1-f48.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-592fb5d644bso3854988e87.1
 for <amd-gfx@lists.freedesktop.org>;
 Mon, 27 Oct 2025 01:31:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWSCXhY7ViyRi8+BaEgqgrkKEeDQ7BhNb1bUH3VnowSGQSxN360FWwXvt0Pfcz1TDKsM0zQXWg8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqckFTJM42GEpAhKCkY7LU/zpKbFvW9m36niUtMhgee5QZxE47
 pqp+2gkP3+nQ8/OFka+enehbc0gFVFPBZeebXpr+OteDW9I4UwXhF28IxsdzlQmWW4fg48R54UV
 07mSjZ1jAbzIBjj3VPjwsZU7p0CJpR3w=
X-Google-Smtp-Source: AGHT+IEDMVW90A/430m6Bs5FRF8/ZQ9GPwk60tq16fOBZ0SWa2mn6iKG7CUxJ8SDua+Wch4rxP7AjPTA6NQfAbsFitE=
X-Received: by 2002:a05:6512:3e19:b0:592:f263:a8b4 with SMTP id
 2adb3069b0e04-592f263ab5amr5643668e87.50.1761553896271; Mon, 27 Oct 2025
 01:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-2-lkml@antheas.dev>
 <3792db59-7dc1-4e34-9436-84df4b6c3e10@amd.com>
 <CAGwozwFTDD2QrHy37axhanwQYv6ty9K_hfhxS05djKpv8HfY6g@mail.gmail.com>
 <2684d3ab-d7cf-4eab-acd4-91bdd5debb6b@amd.com>
 <058eda7c-ab93-40a5-b387-54f7a18f3922@amd.com>
In-Reply-To: <058eda7c-ab93-40a5-b387-54f7a18f3922@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 27 Oct 2025 09:31:24 +0100
X-Gmail-Original-Message-ID: <CAGwozwGELOK_4KNADW6OvGi4TyiJsrbtEceaXRpk4CRNpqweZw@mail.gmail.com>
X-Gm-Features: AWmQ_bl4UMyB6odidPWGa-1mQ9I-bfNM6bIzI__iqt3FqM0SxSO9BrzxRhuherU
Message-ID: <CAGwozwGELOK_4KNADW6OvGi4TyiJsrbtEceaXRpk4CRNpqweZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] platform/x86/amd/pmc: Add support for Van Gogh SoC
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Sanket Goswami <Sanket.Goswami@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176155389715.22554.8921113490360755015@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 27 Oct 2025 09:35:56 +0000
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

On Mon, 27 Oct 2025 at 09:22, Shyam Sundar S K <Shyam-sundar.S-k@amd.com> wrote:
>
>
>
> On 10/24/2025 22:02, Mario Limonciello wrote:
> >
> >
> > On 10/24/2025 11:08 AM, Antheas Kapenekakis wrote:
> >> On Fri, 24 Oct 2025 at 17:43, Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>>
> >>>
> >>> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> >>>> The ROG Xbox Ally (non-X) SoC features a similar architecture to the
> >>>> Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
> >>>> this support was dropped by the Xbox Ally which only S0ix suspend.
> >>>>
> >>>> Since the handler is missing here, this causes the device to not
> >>>> suspend
> >>>> and the AMD GPU driver to crash while trying to resume afterwards
> >>>> due to
> >>>> a power hang.
> >>>>
> >>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> >>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>> ---
> >>>>    drivers/platform/x86/amd/pmc/pmc.c | 3 +++
> >>>>    drivers/platform/x86/amd/pmc/pmc.h | 1 +
> >>>>    2 files changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/
> >>>> platform/x86/amd/pmc/pmc.c
> >>>> index bd318fd02ccf..cae3fcafd4d7 100644
> >>>> --- a/drivers/platform/x86/amd/pmc/pmc.c
> >>>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> >>>> @@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct
> >>>> amd_pmc_dev *dev)
> >>>>        switch (dev->cpu_id) {
> >>>>        case AMD_CPU_ID_PCO:
> >>>>        case AMD_CPU_ID_RN:
> >>>> +     case AMD_CPU_ID_VG:
> >>>>        case AMD_CPU_ID_YC:
> >>>>        case AMD_CPU_ID_CB:
> >>>>                dev->num_ips = 12;
> >>>> @@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct
> >>>> amd_pmc_dev *dev)
> >>>>        case AMD_CPU_ID_PCO:
> >>>>                return MSG_OS_HINT_PCO;
> >>>>        case AMD_CPU_ID_RN:
> >>>> +     case AMD_CPU_ID_VG:
> >>>>        case AMD_CPU_ID_YC:
> >>>>        case AMD_CPU_ID_CB:
> >>>>        case AMD_CPU_ID_PS:
> >>>> @@ -717,6 +719,7 @@ static const struct pci_device_id
> >>>> pmc_pci_ids[] = {
> >>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
> >>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
> >>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
> >>>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
> >>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> >>>> PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
> >>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> >>>> PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
> >>>>        { }
> >>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/
> >>>> platform/x86/amd/pmc/pmc.h
> >>>> index 62f3e51020fd..fe3f53eb5955 100644
> >>>> --- a/drivers/platform/x86/amd/pmc/pmc.h
> >>>> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> >>>> @@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
> >>>>    #define AMD_CPU_ID_RN                       0x1630
> >>>>    #define AMD_CPU_ID_PCO                      AMD_CPU_ID_RV
> >>>>    #define AMD_CPU_ID_CZN                      AMD_CPU_ID_RN
> >>>> +#define AMD_CPU_ID_VG                        0x1645
> >>>
> >>> Can you see if 0xF14 gives you a reasonable value for the idle mask if
> >>> you add it to amd_pmc_idlemask_read()?  Make a new define for it
> >>> though,
> >>> it shouldn't use the same define as 0x1a platforms.
> >>
> >> It does not work. Reports 0. I also tested the other ones, but the
> >> 0x1a was the same as you said. All report 0x0.
> >
> > It's possible the platform doesn't report an idle mask.
> >
> > 0xF14 is where I would have expected it to report.
> >
> > Shyam - can you look into this to see if it's in a different place
> > than 0xF14 for Van Gogh?
>
> Van Gogh is before Cezzane? I am bit surprised that pmc is getting
> loaded there.

The device only came out last week, so I suppose they had to add it

> Antheas - what is the output of
>
> #lspci -s 00:00.0
>
> 0xF14 index is meant for 1Ah (i.e. Strix and above)

lspci -s 00:00.0 -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] VanGogh
Root Complex [1022:1645]

> >
> >>
> >> Any idea why the OS hint only works 90% of the time?
>
> What is the output of amd_pmc_dump_registers() when 10% of the time
> when the OS_HINT is not working?

First sleep with initial data:
[   63.569557] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   63.569581] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:73f
[   63.569597] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:9
[   63.583472] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   63.583497] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:735677a0
[   63.583513] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:5
[   63.607472] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   63.607496] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[   63.607512] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:4
[   63.607687] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   63.607702] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[   63.607709] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:7
[   63.608417] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   63.608436] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[   63.608452] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:6
[   63.608603] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   63.608621] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:1
[   63.608637] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:3
[   64.764466] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   64.764490] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[   64.764506] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:3
[   64.764631] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[   64.764646] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[   64.764660] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:8

Second sleep (successful):
[  235.211752] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  235.211776] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  235.211790] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:7
[  235.211931] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  235.211946] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  235.211960] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:6
[  235.212083] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  235.212096] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:1
[  235.212109] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:3
[  236.520156] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  236.520177] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  236.520192] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:3
[  236.520330] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  236.520346] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  236.520360] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:8

Failed sleep:
[  152.839926] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  152.839951] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  152.839965] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:7
[  152.840115] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  152.840134] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  152.840148] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:6
[  152.840270] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  152.840276] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:1
[  152.840280] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:3
[  158.037073] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  158.037097] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  158.037111] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:3
[  158.037252] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_RESPONSE:1
[  158.037268] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_ARGUMENT:0
[  158.037282] amd_pmc AMDI0005:00: AMD_PMC_REGISTER_MESSAGE:8

So it is the same

> What I can surmise is, though pmc driver is sending the hint PMFW is
> not taking any action (since the support in FW is missing)

The hint is working... 90% of the time. Without the hint in the patch,
sleep never works.

> >
> > If we get the idle mask reporting working we would have a better idea
> > if that is what is reported wrong.
> >
>
> IIRC, The concept of idlemask came only after cezzane that too after a
> certain PMFW version. So I am not sure if idlemask actually exists.
>
>
> > If I was to guess though; maybe GFX is still active.
> >
> > Depending upon what's going wrong smu_fw_info might have some more
> > information too.
>
> That's a good point to try it out.
>
> Thanks,
> Shyam
>
>

