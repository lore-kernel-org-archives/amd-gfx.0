Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40684CCF9EC
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C4610E418;
	Mon, 27 Oct 2025 09:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="oWFTtRDT";
	dkim-atps=neutral
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6B210E392
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 08:41:38 +0000 (UTC)
Received: from relay12 (localhost [127.0.0.1])
 by relay12.grserver.gr (Proxmox) with ESMTP id 84130BCF32
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:41:36 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay12.grserver.gr (Proxmox) with ESMTPS id 90C2DBDBF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:41:35 +0200 (EET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id CD110200BF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 10:41:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761554495;
 bh=7bgq8scNhrB3Jg+UhfmEUiMsC76/nwmnGV6s5QJWkBA=;
 h=Received:From:Subject:To;
 b=oWFTtRDT8JAvrBRT44mqWS5ppQ2qCYCnvirEqg6tueAhG73W3Xu4DiTzDsIH8eoLJ
 rCMkVHOtekuicCoZc5R1+CBXDM9Jvur3YejbtO3gZ7vuBfa2eKt+NgZjroB63l5fl5
 lYaJzBwgcvAPmdQf3BTF7uW0K9B+UOX+CUedrCitzJ2LAIsakQggY7j8TIra7Oh7ld
 quIPgaGlf9HHHPExr0izKsr6/y3LsoIUGM03e5fEc/rFUesHANVVmqISxZyW4SWOpS
 KunHtqcZeMqE2adlMXwE3B9BBLxBif8hO1FEXxMnE9wYNCKNIYTFtBoOq8WdtlqbAA
 fJmALzkodNK+w==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-378ddb31efaso51645971fa.3
 for <amd-gfx@lists.freedesktop.org>;
 Mon, 27 Oct 2025 01:41:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVn/XsIJuBjDdVrCgIhGUYx/J3ns3yFFjYIWR0a/ltnDSX2V36JFRIbYHlXnRKRbGlteMkwJDkC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqCSLKUonWRgSx/1G8NQi1ogT4wgUlcka+tvwnLtXqeBHMs6Ce
 NVEVJNlwee30qrfmdCPSdOo0joDvr0dTZFqP6R0yf+ElMFLIMqkCsUM19Mmz42aQBpNpO1pYNzP
 nXn5o2/dCBKF/TGyUsS1JkNuziZi9fYQ=
X-Google-Smtp-Source: AGHT+IHQrnWhGSRKKWzvZYeImwBcHAM+gDl49kuOa35hnvx7oyBlnaIVQ+Sq6FuvfFsTVRdbbwTudFAhJBdtsJzwEZM=
X-Received: by 2002:a05:651c:1595:b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-37797a1439bmr102634311fa.26.1761554494137; Mon, 27 Oct 2025
 01:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-2-lkml@antheas.dev>
 <3792db59-7dc1-4e34-9436-84df4b6c3e10@amd.com>
 <CAGwozwFTDD2QrHy37axhanwQYv6ty9K_hfhxS05djKpv8HfY6g@mail.gmail.com>
 <2684d3ab-d7cf-4eab-acd4-91bdd5debb6b@amd.com>
 <058eda7c-ab93-40a5-b387-54f7a18f3922@amd.com>
 <13fd3b12-03a0-457f-a5da-fe018b032211@amd.com>
In-Reply-To: <13fd3b12-03a0-457f-a5da-fe018b032211@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 27 Oct 2025 09:41:22 +0100
X-Gmail-Original-Message-ID: <CAGwozwGLfcYdpetwTk=QH+k29u8SdroFxfkxb-KbAXh36sr1XQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmPAVmdP3bYKUv3LzGXCwTY0wQJciqhi0ctU4JYKLg0UaCVGWdkVe6fI_U
Message-ID: <CAGwozwGLfcYdpetwTk=QH+k29u8SdroFxfkxb-KbAXh36sr1XQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] platform/x86/amd/pmc: Add support for Van Gogh SoC
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Sanket Goswami <Sanket.Goswami@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176155449510.58163.12442044152314652188@linux3247.grserver.gr>
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

On Mon, 27 Oct 2025 at 09:36, Shyam Sundar S K <Shyam-sundar.S-k@amd.com> wrote:
>
>
>
> On 10/27/2025 13:52, Shyam Sundar S K wrote:
> >
> >
> > On 10/24/2025 22:02, Mario Limonciello wrote:
> >>
> >>
> >> On 10/24/2025 11:08 AM, Antheas Kapenekakis wrote:
> >>> On Fri, 24 Oct 2025 at 17:43, Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> >>>>> The ROG Xbox Ally (non-X) SoC features a similar architecture to the
> >>>>> Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
> >>>>> this support was dropped by the Xbox Ally which only S0ix suspend.
> >>>>>
> >>>>> Since the handler is missing here, this causes the device to not
> >>>>> suspend
> >>>>> and the AMD GPU driver to crash while trying to resume afterwards
> >>>>> due to
> >>>>> a power hang.
> >>>>>
> >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> >>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>> ---
> >>>>>    drivers/platform/x86/amd/pmc/pmc.c | 3 +++
> >>>>>    drivers/platform/x86/amd/pmc/pmc.h | 1 +
> >>>>>    2 files changed, 4 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/
> >>>>> platform/x86/amd/pmc/pmc.c
> >>>>> index bd318fd02ccf..cae3fcafd4d7 100644
> >>>>> --- a/drivers/platform/x86/amd/pmc/pmc.c
> >>>>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> >>>>> @@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct
> >>>>> amd_pmc_dev *dev)
> >>>>>        switch (dev->cpu_id) {
> >>>>>        case AMD_CPU_ID_PCO:
> >>>>>        case AMD_CPU_ID_RN:
> >>>>> +     case AMD_CPU_ID_VG:
> >>>>>        case AMD_CPU_ID_YC:
> >>>>>        case AMD_CPU_ID_CB:
> >>>>>                dev->num_ips = 12;
> >>>>> @@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct
> >>>>> amd_pmc_dev *dev)
> >>>>>        case AMD_CPU_ID_PCO:
> >>>>>                return MSG_OS_HINT_PCO;
> >>>>>        case AMD_CPU_ID_RN:
> >>>>> +     case AMD_CPU_ID_VG:
> >>>>>        case AMD_CPU_ID_YC:
> >>>>>        case AMD_CPU_ID_CB:
> >>>>>        case AMD_CPU_ID_PS:
> >>>>> @@ -717,6 +719,7 @@ static const struct pci_device_id
> >>>>> pmc_pci_ids[] = {
> >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
> >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
> >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
> >>>>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
> >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> >>>>> PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
> >>>>>        { PCI_DEVICE(PCI_VENDOR_ID_AMD,
> >>>>> PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
> >>>>>        { }
> >>>>> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/
> >>>>> platform/x86/amd/pmc/pmc.h
> >>>>> index 62f3e51020fd..fe3f53eb5955 100644
> >>>>> --- a/drivers/platform/x86/amd/pmc/pmc.h
> >>>>> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> >>>>> @@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
> >>>>>    #define AMD_CPU_ID_RN                       0x1630
> >>>>>    #define AMD_CPU_ID_PCO                      AMD_CPU_ID_RV
> >>>>>    #define AMD_CPU_ID_CZN                      AMD_CPU_ID_RN
> >>>>> +#define AMD_CPU_ID_VG                        0x1645
> >>>>
> >>>> Can you see if 0xF14 gives you a reasonable value for the idle mask if
> >>>> you add it to amd_pmc_idlemask_read()?  Make a new define for it
> >>>> though,
> >>>> it shouldn't use the same define as 0x1a platforms.
> >>>
> >>> It does not work. Reports 0. I also tested the other ones, but the
> >>> 0x1a was the same as you said. All report 0x0.
> >>
> >> It's possible the platform doesn't report an idle mask.
> >>
> >> 0xF14 is where I would have expected it to report.
> >>
> >> Shyam - can you look into this to see if it's in a different place
> >> than 0xF14 for Van Gogh?
> >
> > Van Gogh is before Cezzane? I am bit surprised that pmc is getting
> > loaded there.
> >
> > Antheas - what is the output of
> >
> > #lspci -s 00:00.0
>
> OK. I get it from the diff.
>
> +#define AMD_CPU_ID_VG                        0x1645
>
> S0 its 0x1645 that indicates SoC is 17h family and 90h model.
>
> What is the PMFW version running on your system?
> amd_pmc_get_smu_version() tells you that information.

cat /sys/devices/platform/AMDI0005:00/smu_fw_version
63.18.0
cat /sys/devices/platform/AMDI0005:00/smu_program
7

> Can you see if you put the scratch information same as Cezzane and if
> that works? i.e.
>
> AMD_PMC_SCRATCH_REG_CZN(0x94) instead of AMD_PMC_SCRATCH_REG_1AH(0xF14)

I tried all idle masks and they return 0

Antheas

> Thanks,
> Shyam
>
>
> >
> > 0xF14 index is meant for 1Ah (i.e. Strix and above)
> >
> >>
> >>>
> >>> Any idea why the OS hint only works 90% of the time?
> >
> > What is the output of amd_pmc_dump_registers() when 10% of the time
> > when the OS_HINT is not working?
> >
> > What I can surmise is, though pmc driver is sending the hint PMFW is
> > not taking any action (since the support in FW is missing)
> >
> >>
> >> If we get the idle mask reporting working we would have a better idea
> >> if that is what is reported wrong.
> >>
> >
> > IIRC, The concept of idlemask came only after cezzane that too after a
> > certain PMFW version. So I am not sure if idlemask actually exists.
> >
> >
> >> If I was to guess though; maybe GFX is still active.
> >>
> >> Depending upon what's going wrong smu_fw_info might have some more
> >> information too.
> >
> > That's a good point to try it out.
> >
> > Thanks,
> > Shyam
> >
>
>

