Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30B5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 21:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C0561152
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 21:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63C0561152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D1E6E125;
	Thu, 23 Sep 2021 21:46:28 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987106E125
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 21:46:27 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 j11-20020a9d190b000000b00546fac94456so10517128ota.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0+ctgoE3MwllCz+5pdX8PCcupqzGG9vwbEhVrL+pDbg=;
 b=Ag8+5DW71Pmbo+y8LAbEcYEpOtkx0KmWM/Cd2AxU0Mfhp5qUDvWInZEoygwI/726yf
 sttQKVsOYgwSkZvrBmQoHgVZYRMz1FJZ8irbCdKqotgMj5qc6LJ5UWHofwX22YADia80
 Ch0698aDPx6SKpQnAybW/IRyRK6OXyms4cH1WsjyeocsmSf2EG1kzrlGvaI6KuO8T+w4
 V1ZUgwPtTnH5DbOyYV1aBv7XE1h8Rfx5fw7drEy2PIfwAPvDUaFLiP3keMUoj6ZdWpdQ
 I4ss52VQgoyQhGkFRiG0/OQpeHdKWYLGmjx+ICOcHnBHB9NOnsIri1Z18HecT6IMxsLu
 f/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0+ctgoE3MwllCz+5pdX8PCcupqzGG9vwbEhVrL+pDbg=;
 b=EfNMo0whCwpCc71/9Luhr1HNf5Wd3/8Kz2Tuwk1FR/wQyKZR+nU/pAmVUf3dK4LQ5y
 yMYXH8D/q6CINRAk2wONEynWk434bbgW+1NCDanreAWGXPTuUMjz4n+F6aYjOqAUDXlG
 AFLtprOdVioeufZINjotgrP2KvYP2GiaL3o9LtOajuF3XxAQ8w5oF9qNnyLVZ2/a44SB
 lIFtdZYYzG8Rp8Ni3Gg8FIviau6r7hdRRTf18c86BtYEd7hJ8D+/v7X0qDoEmP1u4O6V
 MiUQ9p//dSQn8N6KXS9ys0WFTfNgM3KoAmqchRNiyCwNv+WMmhYdye8A3qJEWbTgw9E7
 6Ibg==
X-Gm-Message-State: AOAM5334IrJykjQUmP2sfzui8kuL3HwzQCLUjSWmHKaW2rywztnRhU0r
 Y1RiHHy7GLjPpeB5sEeY5cDtGlJcqu/noG+0oDI=
X-Google-Smtp-Source: ABdhPJwM4pFYBRfzPTUK4ym/iNe018nggBR13eVafNlxHFzzd00PA2TSFEOr57kjSY45CRXm8hEahgtkdovNFcEGTIQ=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr869822otd.200.1632433586942; 
 Thu, 23 Sep 2021 14:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-61-alexander.deucher@amd.com>
 <2bec6445-429a-c12e-f807-6105d99051a3@amd.com>
In-Reply-To: <2bec6445-429a-c12e-f807-6105d99051a3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Sep 2021 17:46:16 -0400
Message-ID: <CADnq5_P44JBRdubzywjJb4FF5_uGra80VOuV_ZHRPvBRW1BP9w@mail.gmail.com>
Subject: Re: [PATCH 60/66] drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type
 by default
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Sep 23, 2021 at 2:47 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/21/2021 11:37 PM, Alex Deucher wrote:
> > For new chips with no explicit entry in the PCI ID list.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index c21eac6216a8..c7da1f7cc880 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1796,12 +1796,12 @@ static const struct pci_device_id pciidlist[] = {
> >       { PCI_DEVICE(0x1002, PCI_ANY_ID),
> >         .class = PCI_CLASS_DISPLAY_VGA << 8,
> >         .class_mask = 0xffffff,
> > -       .driver_data = 0 },
> > +       .driver_data = CHIP_IP_DISCOVERY },
> >
> >       { PCI_DEVICE(0x1002, PCI_ANY_ID),
> >         .class = PCI_CLASS_DISPLAY_OTHER << 8,
> >         .class_mask = 0xffffff,
> > -       .driver_data = 0 },
> > +       .driver_data = CHIP_IP_DISCOVERY },
> >
>
> While listing the devices one by one, some of the below flags are also
> used to indicate the device type/support. Since the patch is replacing
> this method, I guess the series needs to address this one also
> (especially AMD_IS_APU, it is used extensively).
>
> enum amd_chip_flags {
>          AMD_ASIC_MASK = 0x0000ffffUL,
>          AMD_FLAGS_MASK  = 0xffff0000UL,
>          AMD_IS_MOBILITY = 0x00010000UL,
>          AMD_IS_APU      = 0x00020000UL,
>          AMD_IS_PX       = 0x00040000UL,
>          AMD_EXP_HW_SUPPORT = 0x00080000UL,
> };

I think we could either deprecate the use of these or derive them from
the IP versions for the flags that are currently derived from DIDs.
E.g., if we introduce support for a new IP (say SDMA 7.1) and it's not
stable yet, we could add code to set the AMD_EXP_HW_SUPPORT flag if
that IP version is found.

Alex


>
> Thanks,
> Lijo
>
>
> >       {0, 0, 0}
> >   };
> >
