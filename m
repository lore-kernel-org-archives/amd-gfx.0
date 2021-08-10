Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644DDC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 15:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2403260F25
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 15:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2403260F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBCF89E7B;
	Tue, 10 Aug 2021 15:09:49 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831DF89E7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 15:09:48 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id u25so29249885oiv.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=liJrzWlBijedqRsDtvXgIMyCLIJ7QSzaeJwdfq7yNoU=;
 b=pwcvOeC3oHKNTK4C6Bws54fgLeOQLWMsYm+OXxq5/aDOR5aix38D+pNBcbIiAs55zH
 tnWyREYYFg6z+Xt8ujubAv1j7gOpWuCkqfoHEowxb4i+7giNrmlohfBXR35rCqtSp3lE
 MMU1NVceve+Zs94TS/J6tJRd7IUMx6naVfQymn2AEMoDfzGNJ7ciij+Ne/KUi2mtsG9U
 fiDgaEne0in9/gD67dwm3qnfxi+j0c/GojKkmlpUao2802ZXZxeq2kwKwPtdQ6PiIeOZ
 RiNHT3u+MKrA7ifhe2wnhHVepxBVq/PKZAF/NChia/K7hhIUhkClP1jbgeJ6vRRJTiL9
 N+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=liJrzWlBijedqRsDtvXgIMyCLIJ7QSzaeJwdfq7yNoU=;
 b=M8eAcft6KZA/1ghPyWfrbJBX6Fm2RD9n4NWRy3BdjUMZl77Np2PjTYqnEZLPVM62qD
 5pc0mHq8ewb3PdZHSoztRXh9TclrBjbPvefNVZknXj2EH1rBj3I7FyEyNmrh1YBXFkHw
 rfz1DUSWtD4hATV3PemfJ+xnA6OKeOB90Yy7n9AI2CrfSn1zsnA17Tz3Y1kVwWkuVYB9
 L1zC3prLK44E7jVFY9x1O3MjBkCso5n/+eAADtzDdEUKrIRhxeTNoteNTe3Da0dWyvvS
 EM7dfCw8hnXlHAR7uoZLUO8UwXBTo3HbspXeVmsBfAziTHpLYYk4+VyETjjv9ALCJAbY
 BZYQ==
X-Gm-Message-State: AOAM533oJmBVhzThAXnusmM9b9LacvxJiW9qk0/lkDiwuf9PlDkABbUq
 XWC76aizLJK9w/7UuuJ07/kuweZXrHUG8vh6jRU=
X-Google-Smtp-Source: ABdhPJyyAP6WZzqEZN8skze0THRzB9cXJ3FvrPdB/K2XDvToo44PBP4Uz25JroGwAf1QDSC4Evm10lVO1bGeHUfgek8=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr20482029oiw.123.1628608187598; 
 Tue, 10 Aug 2021 08:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
 <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
 <CADnq5_OXvhKajHW6yKde6mQHy=B3RZN4BYV-FYdnzNOoObqH+g@mail.gmail.com>
 <CA+EcB1MYQOBypQN6Ktdu52sfqg1N-sfzurSeTQDW1kPz9H+iUw@mail.gmail.com>
 <CAJB-X+UD7-aSKP1Ozc2UUbOZ5MYY6wD5jMUY3+MeS_KKQzaxdA@mail.gmail.com>
In-Reply-To: <CAJB-X+UD7-aSKP1Ozc2UUbOZ5MYY6wD5jMUY3+MeS_KKQzaxdA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Aug 2021 11:09:36 -0400
Message-ID: <CADnq5_MhrwFe1aW=A6_XbaskpSmfYzU1PcCeXTc99=iYC+EW+A@mail.gmail.com>
Subject: Re: Req: about Polaris with RKL platform
To: Koba Ko <koba.ko@canonical.com>
Cc: Mario Limonciello <superm1@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Anthony Wong <anthony.wong@canonical.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
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

On Tue, Aug 10, 2021 at 12:57 AM Koba Ko <koba.ko@canonical.com> wrote:
>
> On Tue, Aug 10, 2021 at 12:45 PM Mario Limonciello <superm1@gmail.com> wrote:
> >
> >
> >
> > On Mon, Aug 9, 2021 at 9:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> On Mon, Aug 9, 2021 at 9:59 AM Koba Ko <koba.ko@canonical.com> wrote:
> >> >
> >> > Previously, AMD had an issue about noise  with AMD-DG on the RKL platform
> >> > AMD provided a parameter.
> >> > #modprobe amdgpu ppfeaturemask=0xfff7bffb
> >> >
> >> >  I thought it's better to check and assign values in amd gpu.
> >> > Have a trouble determining the type of pch(RKL or else),
> >> > search in amd drm driver and can't find any about this.
> >> > Would someone please guide me? if there's an existing function.
> >> >
> >> > here's a proposal, check RKL PCH in amd driver,
> >> > the pch definitions must be splitted off from intel_pch.h in i915
> >> > folder to include/drm/intel_pch_definition.h
> >>
> >> Yes, something like that would work.
> >
> >
> > Can the issue that prompted this also happen with other ASIC with the
> > newer SMU families?  If so, should it probably be added to all of them
> > or further up in the code where the mask normally gets set from module
> > parameters to add the extra check there.
>
> Would amd guys please clarify this?
>
> Currently as i known,
> for smu series, amd upstream this commit only for smu7 and also
> provide modue parameters.
> 1.https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d03730ecbc5afabfda26d4dbb014310bc4ea4d9
> 2. #modprobe amdgpu ppfeaturemask=0xfff7bffb

SMU7-based and vega10/12/20 asics require this.  Newer parts were
fixed in SMU firmware:
navi10:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amdgpu/navi10_smc.bin?id=4fe6e53b96095101eebe4639cd2e2b6ecd84650d
navi14:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amdgpu/navi14_smc.bin?id=8ab7abaf63e95c29e04e5811cb24730a81486096
for newer asics, 21.10 and newer firmwares.  E.g.,
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/amdgpu/sienna_cichlid_smc.bin?id=ef5ea5d1d3f0a72a92e0a09f6cff253560374a39

Alex


>
> >
> >>
> >> Alex
> >>
> >>
> >> >
> >> > > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> >> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> >> > > @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >> > >
> >> > >         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> >> > >         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> >> > > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> >> > > +       data->pcie_dpm_key_disabled = is_rkl_pch() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> >> > >         /* need to set voltage control types before EVV patching */
> >> > >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> >> > >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> >
> >
> >
> > --
> > Mario Limonciello
> > superm1@gmail.com
