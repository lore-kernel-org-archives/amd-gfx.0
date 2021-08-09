Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBFC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 14:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F4E61004
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64F4E61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E8989B20;
	Mon,  9 Aug 2021 14:37:35 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E7A89B20
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 14:37:34 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 d10-20020a9d4f0a0000b02904f51c5004e3so13826238otl.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Aug 2021 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MGmHhy93aAs+wgFC3leAoGPzBrcw7Y65dgCc6VsVnf4=;
 b=Jx4YeSaUFT7LrQkAIcyEe05cc6PbBeCGftKnuHfHkn6PYx4pOV9sQfvPe/wiXsAeR/
 mtjT0nQMKr3zvkiAL1eT5xLnvgds90pblhx74OSJHjU1/2QSF7NexRasiSl3f74hOg4a
 JbGwnCzpg32Trj3yV7tr3oqI/smJnffRTjj3E3YPdqxka3o9cY3xRqJZs8cHZhfPGsNN
 0g2dzB0fnbAi0v4FYmyg64QD4Q+E43taO0nvwTHsYaoxphJ8xdwghv42nxDcnd+k6Ds5
 vjXwtCWjSgt90mkNHMSpJXx55Eh8Rxi7/FdP1bYlCEEsTq6nScpssb1y8qC7duYaQohW
 Af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MGmHhy93aAs+wgFC3leAoGPzBrcw7Y65dgCc6VsVnf4=;
 b=jX4ndmONOwX7jDmeRj5T5mlAKi/yXkO1dOpW2+O2LkOKtg4xI95S8srknleCCZonZF
 oNHXyHwsEj7OgmYwbG8HYojxH+cZE4COT6bS/60XGIbvTmoAONK1QBhBD7061d/HFYUD
 3BUaBHzJGk0MUHWzRkpGFe8pDrlO+chZb0ZyF6e5+rpDjn1dFF+PWTsZLgcj5pD20ZTR
 xbwTnFb/Mc73acEBNGLo3+rcwNP9koSI+cQce8lxtRSQDN9NtcVWyil3HgOdYbW97QC1
 qvh50GrbOEGcnkCI5wq7Tcr+iudouDN+DTkQ0IVqi47YZTfoGVscRspvByEyCAw+BP6b
 Eupw==
X-Gm-Message-State: AOAM53024XrcpyLL4w5V/XdC8p9UD/sdVJ16A+aE7I6ytWifFTYXmuRP
 Huub99Jjdz5b9EGjBZAaiTuJ1Rf/z6LJjxQQit4=
X-Google-Smtp-Source: ABdhPJxmL9vjok/1olSsvyT9YTDg+F2lb8fpD9Drb6TTUniuGODAFNUDmTjq0F4pwY8dIM3yqFe/GXLq4cqt5+86Wyk=
X-Received: by 2002:a05:6830:1e78:: with SMTP id
 m24mr11416425otr.23.1628519854340; 
 Mon, 09 Aug 2021 07:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+V5SLikZgkesXCoQ=EufSbj6ABLxKEtO71OSRwyJ1175Q@mail.gmail.com>
 <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
In-Reply-To: <CAJB-X+Xh1F_7WBvSDOJrtHYZX4YN4WRnLNnrqEG-zPC3h0HEwg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Aug 2021 10:37:23 -0400
Message-ID: <CADnq5_OXvhKajHW6yKde6mQHy=B3RZN4BYV-FYdnzNOoObqH+g@mail.gmail.com>
Subject: Re: Req: about Polaris with RKL platform
To: Koba Ko <koba.ko@canonical.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Anthony Wong <anthony.wong@canonical.com>,
 Mario Limonciello <superm1@gmail.com>
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

On Mon, Aug 9, 2021 at 9:59 AM Koba Ko <koba.ko@canonical.com> wrote:
>
> Previously, AMD had an issue about noise  with AMD-DG on the RKL platform
> AMD provided a parameter.
> #modprobe amdgpu ppfeaturemask=0xfff7bffb
>
>  I thought it's better to check and assign values in amd gpu.
> Have a trouble determining the type of pch(RKL or else),
> search in amd drm driver and can't find any about this.
> Would someone please guide me? if there's an existing function.
>
> here's a proposal, check RKL PCH in amd driver,
> the pch definitions must be splitted off from intel_pch.h in i915
> folder to include/drm/intel_pch_definition.h

Yes, something like that would work.

Alex


>
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -1629,7 +1629,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >
> >         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> >         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> > +       data->pcie_dpm_key_disabled = is_rkl_pch() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> >         /* need to set voltage control types before EVV patching */
> >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
