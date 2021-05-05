Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95528C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B834610A7
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 18:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B834610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED72F6E4F3;
	Wed,  5 May 2021 18:17:13 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B346E4F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 18:17:12 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id v24so3011645oiv.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 May 2021 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yMga+F0sarwvXAQ73gLef3jkK3OleUQSkp+MNTNNsjs=;
 b=lIze+PKQHQ/uVo3W9DqhO6RM0Iu+I7xVuW7ASwa5KSG9rasci+cDK+lqXxA6jEnw26
 N1NVJbw6K4vymXqmryl/sLPoAYje30KZd8TUyn/GOkPRE420A2wXKy76r8Ww42sGuKd8
 w4ZK51O7Bxizmw5BKiidnAvnO1KAch1PTXOJQeT0k89dSfD8nmBnOS1HnmpSH3jrI2Fv
 n4uaO4p42KFhewigExoy0Jz5lxpf+DoGPSy4CRAzCtCrkwyMBh1B5NflUSvhYvI3i/xC
 vpuSZWBibkmXFCj+GF4A/v0Nn4T/H+YclaeYklyUtyqZstVxX4lew2xHGwdpMjxK4R74
 kJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yMga+F0sarwvXAQ73gLef3jkK3OleUQSkp+MNTNNsjs=;
 b=GsaK/tcFxd+FctNGrMu2Zr5+/t8JrFvxctPnGnjsMGTcVbtFbATSDBpcjSmXKEv5WG
 tGeU4TLUnjsdoDfE8zPcGIqfrHspU+B8donMP96lO0zoK0whk9Ip3kf+d91Sh2aBoJNR
 gibcJ4gzRLBK7CPpvPxzdDbpaJtODhF48ufcdq6VmCtEvgSCsZYpFZBbJyv27zsGQ9/m
 zaL+88VkOCZhxm8BNq9Uk6xV02zxRHNOX2rMMJSVuuzJWIRonMY20ga8rR9o/8MhFUrj
 6qPX2S+3XL1eb7j+XPDKCzItvwIYdAfORW+tw8poXvzYMK/l4zof4d/sTa6glHOeQlzr
 HJBA==
X-Gm-Message-State: AOAM530jH129SURYc9OUpOVEwIXgc+x6VUHrtOD5/osE3GxU3bxVArvX
 rwdqRWU9yUm5UVBJJ9egTc/RslZUjksJAomUBYA=
X-Google-Smtp-Source: ABdhPJyjbL1+kJjrECJFT/Fp5VS29gDsCkqIyP2Uu9tDbx4ZRtCd14bA/n1E9YfdvlPvapQ4rHOXdwgUB8ORw2JjDy8=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr146807oii.123.1620238631793; 
 Wed, 05 May 2021 11:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210505012749.1803406-1-bas@basnieuwenhuizen.nl>
 <f9ef6f14-8f59-9b41-2b65-6191ddb3097c@amd.com>
In-Reply-To: <f9ef6f14-8f59-9b41-2b65-6191ddb3097c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 May 2021 14:17:00 -0400
Message-ID: <CADnq5_PmR6e-0Q=3nx-9O8EtHoHKdBdvjpWWssHs64LLyyjZ0g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Init GFX10_ADDR_CONFIG for VCN v3 in DPG mode.
To: Leo Liu <leo.liu@amd.com>
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
Cc: Boyuan Zhang <boyuan.zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!  Do we need a similar fix for other VCN variants?

Alex

On Tue, May 4, 2021 at 10:14 PM Leo Liu <leo.liu@amd.com> wrote:
>
> Reviewed-and-Tested by: Leo Liu <leo.liu@amd.com>
>
> On 2021-05-04 9:27 p.m., Bas Nieuwenhuizen wrote:
> > Otherwise tiling modes that require the values form this field
> > (In particular _*_X) would be corrupted upon video decode.
> >
> > Copied from the VCN v2 code.
> >
> > Fixes: 99541f392b4d ("drm/amdgpu: add mc resume DPG mode for VCN3.0")
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > index 3f15bf34123a..cf165ab5dd26 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -589,6 +589,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
> >       WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
> >                       VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0),
> >                       AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
> > +
> > +     /* VCN global tiling registers */
> > +     WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
> > +             UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
> >   }
> >
> >   static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
