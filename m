Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916EAC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 01:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2076A60C3E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 01:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2076A60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4FCC89E1B;
	Wed, 11 Aug 2021 01:55:08 +0000 (UTC)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE50C6E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 01:14:27 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id B06B83F33F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1628644465;
 bh=nISQzOZa6zcD12Xe056xt64Hvu89twdTcdXwDxpYBdE=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=aLcIVfimfkrPyABDjGLozWH7GWLna1qVIiJqUikyPdwRmIyN86kiIP+8xSoY2POK+
 3fXPcIVLbU7sg+QbCGFup9B5McrL6ZQHk83yvI3Q1foEQs55G04IekOMBk7r0Yj3Y3
 +7i1aqfaeqmZLAHeFhqjWdwzs6ODNCNJV/Kmx1DTyOWhZ1W0HXYnsJTBDE4xU+hYqp
 DitElaT7MnUpGDk/xYabfmuB2xkjvNSGTrpCfkzOyUP0c0lJ6fJONJiAUKgEGa/oX2
 zQLMMcGsVvZrQixUYCxi8oeDzjn3CMH7eezgbToQWAUZbdjakyLE0S+dYo2L8Quteh
 4N/U7rsHPIk/Q==
Received: by mail-oi1-f200.google.com with SMTP id
 u77-20020acac4500000b029025c7e6f8b64so570031oif.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 18:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nISQzOZa6zcD12Xe056xt64Hvu89twdTcdXwDxpYBdE=;
 b=KYeFHg9RQtD1itp4UjouLF9+r5Mnzuz7Ng2ltW0KEnRe/bsYkj+BJAtMw7oJL6MvOs
 3X2VMVHoqRlv9ZjnUW79QLGC7+N03urfptsgYPFn4MDi/IeR0R2nFbKDR5qByc8yNIk+
 vaO3zwrjUe7aC6u07PYAqRGMa04kkKc3leqM5rZyApEx0+BBnOn309AIomeSglh5Ujtb
 PHWDqMYT//T5DZfHSSBH2GVkwEKW/EJkJdEzOAtwZeb5/DObreEP+A/0REDXk1pE3dGZ
 NEdjXmvKBBGVZdy9LDbaCliC1Vtrd54OsVjkw4/tz+SXurvpJTfXWrhW2lnsJ0aa5Z6Q
 9row==
X-Gm-Message-State: AOAM533YsmOmLqoUvvctzO6rQr9Ji74u23rlWeJ7RZq5zEe0RUjxPXRY
 vh0rr2vjugLkGGdPzZZoqJbSBZvbmmie0yK22IqE/GNYFd4REAynseMe+Iph98ojxDmJv/nAni7
 TJVhP/e5xX2uLarKYwBzlDHI0Sr8cQgfxm+b0w09AtLKWJxmNRY4T2hAj4FQ=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr23381892otq.3.1628644464236;
 Tue, 10 Aug 2021 18:14:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZBgHAZv0MChutunOZ8oJQDdJLDjS2s3UeV9U0p+LvkKKS+wnye9XlLZxIVnH9mBfn4B7DP3OAt121DDqTHFA=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr23381879otq.3.1628644463938;
 Tue, 10 Aug 2021 18:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
 <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
 <CADnq5_OXvhKajHW6yKde6mQHy=B3RZN4BYV-FYdnzNOoObqH+g@mail.gmail.com>
 <CA+EcB1MYQOBypQN6Ktdu52sfqg1N-sfzurSeTQDW1kPz9H+iUw@mail.gmail.com>
 <CAJB-X+UD7-aSKP1Ozc2UUbOZ5MYY6wD5jMUY3+MeS_KKQzaxdA@mail.gmail.com>
 <CADnq5_MhrwFe1aW=A6_XbaskpSmfYzU1PcCeXTc99=iYC+EW+A@mail.gmail.com>
In-Reply-To: <CADnq5_MhrwFe1aW=A6_XbaskpSmfYzU1PcCeXTc99=iYC+EW+A@mail.gmail.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Wed, 11 Aug 2021 09:14:12 +0800
Message-ID: <CAJB-X+UDjBBe7Od=EnoJCtNcQaWOogatxn1fXKRb+vckE0AjEA@mail.gmail.com>
Subject: Re: Req: about Polaris with RKL platform
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <superm1@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Anthony Wong <anthony.wong@canonical.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 11 Aug 2021 01:55:08 +0000
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

On Tue, Aug 10, 2021 at 11:09 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Aug 10, 2021 at 12:57 AM Koba Ko <koba.ko@canonical.com> wrote:
> >
> > On Tue, Aug 10, 2021 at 12:45 PM Mario Limonciello <superm1@gmail.com> wrote:
> > >
> > >
> > >
> > > On Mon, Aug 9, 2021 at 9:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >>
> > >> On Mon, Aug 9, 2021 at 9:59 AM Koba Ko <koba.ko@canonical.com> wrote:
> > >> >
> > >> > Previously, AMD had an issue about noise  with AMD-DG on the RKL platform
> > >> > AMD provided a parameter.
> > >> > #modprobe amdgpu ppfeaturemask=0xfff7bffb
> > >> >
> > >> >  I thought it's better to check and assign values in amd gpu.
> > >> > Have a trouble determining the type of pch(RKL or else),
> > >> > search in amd drm driver and can't find any about this.
> > >> > Would someone please guide me? if there's an existing function.
> > >> >
> > >> > here's a proposal, check RKL PCH in amd driver,
> > >> > the pch definitions must be splitted off from intel_pch.h in i915
> > >> > folder to include/drm/intel_pch_definition.h
> > >>
> > >> Yes, something like that would work.
> > >
> > >
> > > Can the issue that prompted this also happen with other ASIC with the
> > > newer SMU families?  If so, should it probably be added to all of them
> > > or further up in the code where the mask normally gets set from module
> > > parameters to add the extra check there.
> >
> > Would amd guys please clarify this?
> >
> > Currently as i known,
> > for smu series, amd upstream this commit only for smu7 and also
> > provide modue parameters.
> > 1.https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d03730ecbc5afabfda26d4dbb014310bc4ea4d9
> > 2. #modprobe amdgpu ppfeaturemask=0xfff7bffb
>
> SMU7-based and vega10/12/20 asics require this.  Newer parts were
> fixed in SMU firmware:
> navi10:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amdgpu/navi10_smc.bin?id=4fe6e53b96095101eebe4639cd2e2b6ecd84650d
> navi14:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amdgpu/navi14_smc.bin?id=8ab7abaf63e95c29e04e5811cb24730a81486096
> for newer asics, 21.10 and newer firmwares.  E.g.,
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amdgpu/sienna_cichlid_smc.bin?id=ef5ea5d1d3f0a72a92e0a09f6cff253560374a39
>
With thie commit,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d03730ecbc5afabfda26d4dbb014310bc4ea4d9
For SMU7-based, the module parameter is still necessary, right?

> Alex
>
>
> >
> > >
> > >>
> > >> Alex
> > >>
> > >>
> > >> >
> > >> > > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > >> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > >> > > @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> > >> > >
> > >> > >         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> > >> > >         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> > >> > > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> > >> > > +       data->pcie_dpm_key_disabled = is_rkl_pch() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> > >> > >         /* need to set voltage control types before EVV patching */
> > >> > >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> > >> > >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> > >
> > >
> > >
> > > --
> > > Mario Limonciello
> > > superm1@gmail.com
