Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC46CCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F041210E41D;
	Mon, 27 Oct 2025 09:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="O19v8UyD";
	dkim-atps=neutral
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A4710EAD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:09:04 +0000 (UTC)
Received: from relay10 (localhost.localdomain [127.0.0.1])
 by relay10.grserver.gr (Proxmox) with ESMTP id 7FBEC4616F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:09:02 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay10.grserver.gr (Proxmox) with ESMTPS id 56DAD4621D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:09:01 +0300 (EEST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id BC5B41FD894
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:09:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761322140;
 bh=c6HxS6Zvm7NRv10KSWFGgdQGO5/rBFIB+mc4eI/omCg=;
 h=Received:From:Subject:To;
 b=O19v8UyDei9/DnhlzQsEqZh0vjXwPWeLVmxk9HkMw64ZnVQQg1KFx4t+3J4ur8DHC
 nBu16NMOTyyLo4FSYdWlYFJFXhdfKGeGpFwXgyFHCwhr4k5lel+F/a6gy4xmzYsa2I
 xEWrfmvwZdxPHhMvg9rKtoWZ6QqieTNXPnjIKEKfiWt0+IexDZeOk9DLcK+1Rp7Ndl
 OxtAzNslOcbgishOxcPhYKfZnWF0b18CRbelCsDf4LCgeEuOysagO46YGRSMJiCto0
 z7WQh0ppA9TYyI93MwDtxeWNJgCF3mIOC3/ekhCFh4dRde5nCKVSh4e3rvwt5VUirw
 o+Wt7PPQU0/jg==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3717780ea70so30695141fa.1
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 24 Oct 2025 09:09:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWVFcWOj5/7mc3XprwBMqmqTr8X06CuSxm31N4mSjS/bNwL5Qtz/b8dmVknlsSFB/DdO1QFlptC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU0rBcSgbPdruzuVVURIxYLZBtJUqVBXFl2Nn1Gy4wPXpMZhtw
 OAzbQY4AdM6ryTbRmdXaz0kaFZO52M0/U+zSCssbesGD7p7pqQBYU6VPc25YTlhuUDpHs4gdzrX
 z+kNZD3O2Q+Io7ohSeWE3HRHz8gmHnWo=
X-Google-Smtp-Source: AGHT+IGrtGMUbTKY3EJtLEoExINvTxhF1uNJ6b9fMUw+NXU6QFCVEzK+bhBzwXzHYYPoTCBgDT/ICF7dvjwKtksorfc=
X-Received: by 2002:a05:651c:1a08:b0:336:df0e:f4ac with SMTP id
 38308e7fff4ca-377979febaemr77151861fa.25.1761322140301; Fri, 24 Oct 2025
 09:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <20251024152152.3981721-2-lkml@antheas.dev>
 <3792db59-7dc1-4e34-9436-84df4b6c3e10@amd.com>
In-Reply-To: <3792db59-7dc1-4e34-9436-84df4b6c3e10@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 18:08:49 +0200
X-Gmail-Original-Message-ID: <CAGwozwFTDD2QrHy37axhanwQYv6ty9K_hfhxS05djKpv8HfY6g@mail.gmail.com>
X-Gm-Features: AWmQ_bluSFRZs0j2QGdMRmJXJE4ND_MPKG9XbmD0AYwluvNUVV_Hqb-0t8edzEA
Message-ID: <CAGwozwFTDD2QrHy37axhanwQYv6ty9K_hfhxS05djKpv8HfY6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] platform/x86/amd/pmc: Add support for Van Gogh SoC
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176132214094.2527972.3784132337316023399@linux3247.grserver.gr>
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

On Fri, 24 Oct 2025 at 17:43, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> > The ROG Xbox Ally (non-X) SoC features a similar architecture to the
> > Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
> > this support was dropped by the Xbox Ally which only S0ix suspend.
> >
> > Since the handler is missing here, this causes the device to not suspend
> > and the AMD GPU driver to crash while trying to resume afterwards due to
> > a power hang.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/platform/x86/amd/pmc/pmc.c | 3 +++
> >   drivers/platform/x86/amd/pmc/pmc.h | 1 +
> >   2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> > index bd318fd02ccf..cae3fcafd4d7 100644
> > --- a/drivers/platform/x86/amd/pmc/pmc.c
> > +++ b/drivers/platform/x86/amd/pmc/pmc.c
> > @@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
> >       switch (dev->cpu_id) {
> >       case AMD_CPU_ID_PCO:
> >       case AMD_CPU_ID_RN:
> > +     case AMD_CPU_ID_VG:
> >       case AMD_CPU_ID_YC:
> >       case AMD_CPU_ID_CB:
> >               dev->num_ips = 12;
> > @@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
> >       case AMD_CPU_ID_PCO:
> >               return MSG_OS_HINT_PCO;
> >       case AMD_CPU_ID_RN:
> > +     case AMD_CPU_ID_VG:
> >       case AMD_CPU_ID_YC:
> >       case AMD_CPU_ID_CB:
> >       case AMD_CPU_ID_PS:
> > @@ -717,6 +719,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
> >       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
> >       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
> >       { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
> > +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
> >       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
> >       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
> >       { }
> > diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
> > index 62f3e51020fd..fe3f53eb5955 100644
> > --- a/drivers/platform/x86/amd/pmc/pmc.h
> > +++ b/drivers/platform/x86/amd/pmc/pmc.h
> > @@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
> >   #define AMD_CPU_ID_RN                       0x1630
> >   #define AMD_CPU_ID_PCO                      AMD_CPU_ID_RV
> >   #define AMD_CPU_ID_CZN                      AMD_CPU_ID_RN
> > +#define AMD_CPU_ID_VG                        0x1645
>
> Can you see if 0xF14 gives you a reasonable value for the idle mask if
> you add it to amd_pmc_idlemask_read()?  Make a new define for it though,
> it shouldn't use the same define as 0x1a platforms.

It does not work. Reports 0. I also tested the other ones, but the
0x1a was the same as you said. All report 0x0.

Any idea why the OS hint only works 90% of the time?

> >   #define AMD_CPU_ID_YC                       0x14B5
> >   #define AMD_CPU_ID_CB                       0x14D8
> >   #define AMD_CPU_ID_PS                       0x14E8
>
>

