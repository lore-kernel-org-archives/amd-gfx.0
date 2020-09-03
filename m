Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60355C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2405A20716
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzCmcD8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2405A20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CFF6E11F;
	Thu,  3 Sep 2020 18:02:20 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC1B6E11F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 18:02:19 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a65so3746188wme.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2020 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EprQGO7TZnzLAcKfSZ4CHX072axWpE7E9vxywDXVya8=;
 b=ZzCmcD8pjV4rPu85NXCcBfGRL/3XnrEr3vR7ZpLeNbxmRZHqlL56/HCP+oNA8oTgkB
 LceRXs7BN2idl6WTvi9oEWiVVCVw7q5SllndSw8akPfGNFBW9nBcfgVWM9vzY8g9rtqt
 uDGxKGHX4im9PfjBfq5eQ1/RMiaGqHXgq4IVu1E8oUjZ+sQS8o1zv+HlUUhfYvzwpRCV
 RIvSUU8ky7ZwOoNOculd0wpLykBghIclrF83/p9t34Qk9k1+fMiDY7EGhEVtZI1SCTRt
 Lq1ywPYO7gv8yyjejnkjxHaa0MQOjsNrlpt/dd2Sc6YCDLeVvYxg0mQrwixNoOQjOJHW
 IafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EprQGO7TZnzLAcKfSZ4CHX072axWpE7E9vxywDXVya8=;
 b=O3VCmBULlyLZ8GWgKiMqM8QVm837s02wlsT4+Mqy2B0WcuXjlUp++VwRi5u0qkiSaF
 tb59N6xXxcmuzy7Tw66PercljBv/oaxb6IJ4cc/ZhGr7FJWy2c1eNyNiU6EGjMhIa25Q
 A5ZM9BiHEAk9LWg7Z/kXJiwGe27RGwf93oqxGIsWWAy1LU7dGSar64EOKt5u5aAp/xRg
 Ml6e/D4LABm7ay517vg6Gv5T8f/D1IeyDad+nAMANx5t7oBT5K+fAudJAUyuC/1oFvFc
 y5ffQkhlmwjahKvcyCqi8hk9JqQyOiY4Bkr+DzA6PVoMcKdnua95FTS7cputZKvh8+bD
 7ttw==
X-Gm-Message-State: AOAM533h/ad90tO+e1SshQNSJ5s3kgINMaWH02qPElAwUGVhmEB47PGn
 U1YGk2u64DZPhfJUUtcAaqDFouXEVFg0EzEWg30=
X-Google-Smtp-Source: ABdhPJyH0U218yo/jDJj7iWt0m8ADRDxyrYKx+o0043FPSMHtNVYUZDZUIgXzQKMYZSRI+1xxNbosZXquV1pSlexz+A=
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr3748820wmh.56.1599156137953; 
 Thu, 03 Sep 2020 11:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200903021756.316132-1-yebin10@huawei.com>
 <20200903063412.GA2470278@hr-amd>
In-Reply-To: <20200903063412.GA2470278@hr-amd>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2020 14:02:06 -0400
Message-ID: <CADnq5_PziWyyd0r7i1vdr+N3zdkQn19Lw79xkzBLUF8QbHuJPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Delete some duplicated argument to '|'
To: Huang Rui <ray.huang@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Sep 3, 2020 at 2:35 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Thu, Sep 03, 2020 at 10:17:56AM +0800, Ye Bin wrote:
> > 1. gfx_v10_0_soft_reset GRBM_STATUS__SPI_BUSY_MASK
> > 2. gfx_v10_0_update_gfx_clock_gating AMD_CG_SUPPORT_GFX_CGLS
> >
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 2db195ec8d0c..d502e30f67d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -7055,8 +7055,7 @@ static int gfx_v10_0_soft_reset(void *handle)
> >                  GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
> >                  GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__DB_BUSY_MASK |
> >                  GRBM_STATUS__CB_BUSY_MASK | GRBM_STATUS__GDS_BUSY_MASK |
> > -                GRBM_STATUS__SPI_BUSY_MASK | GRBM_STATUS__GE_BUSY_NO_DMA_MASK
> > -                | GRBM_STATUS__BCI_BUSY_MASK)) {
> > +                GRBM_STATUS__SPI_BUSY_MASK | GRBM_STATUS__GE_BUSY_NO_DMA_MASK)) {
> >               grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
> >                                               GRBM_SOFT_RESET, SOFT_RESET_CP,
> >                                               1);
> > @@ -7449,7 +7448,6 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
> >           (AMD_CG_SUPPORT_GFX_MGCG |
> >            AMD_CG_SUPPORT_GFX_CGLS |
> >            AMD_CG_SUPPORT_GFX_CGCG |
> > -          AMD_CG_SUPPORT_GFX_CGLS |
> >            AMD_CG_SUPPORT_GFX_3D_CGCG |
> >            AMD_CG_SUPPORT_GFX_3D_CGLS))
> >               gfx_v10_0_enable_gui_idle_interrupt(adev, enable);
> > --
> > 2.25.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C8215921a33564f5d7eba08d84fb1e505%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346973382780465&amp;sdata=91fBV5jvWLukcSerSI8WPwWc4bzWDJb3ZW86qDJ9kwI%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
