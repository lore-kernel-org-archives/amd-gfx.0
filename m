Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB6C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2318720756
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRBe7HPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2318720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9AFD6E241;
	Thu, 21 May 2020 20:25:50 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234BB6E241
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 20:25:50 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id n18so7731313wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m+9eCWmtBkdkDAYC0kEioH3UuHjPtEW+NGe9/Ffcn+k=;
 b=YRBe7HPUiv7FhRVucF2eXPmN+4M4Ibe+npdX7Qp6doJwBjfokfUrl6n+ySGVZodu/z
 RKibGuqudpd5VRc1Or1lJ61R/fsME45kzwHB9kETpyAXarnUZNIFr7RWMISBMh5foQTQ
 n3/mq7NbvxWMEwuDw6YjUH+hA41bufiaEhyuzzpimUd9XMW11mhwJ7aM3q8c/sMomwa6
 vZC3xEwJazDRyx+x97+WBrz3XMOkJOopSEDw/3ra5AArm2sxuF5bZU0H91IcgwDFr2Hd
 aPkqUPyY/lWyNvU7H4ANSxseoFvwPtRpTDrnrf8fnbsjP9vZakTS6TN09sOQit5F77kr
 nfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m+9eCWmtBkdkDAYC0kEioH3UuHjPtEW+NGe9/Ffcn+k=;
 b=HcmeeLwfBb5eq+NeBd7/pyiuHeldf+PnJueN7DHh+H+LzW8IdqyVo/TDsG6F5qmIM1
 NvyJF9mZxHN73YoudZRjzszPrA9vBp5eQFefJDnDh7JRIQ1cKGeiiCOhheCxXKLOHI1u
 gXVYbR/WhZN9tkSPMP07xT5o7qa+gSjzksHop6juuVJlsmCZIGthUlZCL3byrpvjuZuK
 tpNS/kk9DNOh4hlegnuObt676iiKAUGN2uNwBjLWpUlTruMSHQGxDOI/K+R+SNIwE6OS
 kjv8Ywy+sPOQmB2+rII+8swCu+8u+nY8UToPJshnjyLCAFJjPXuqvJY1riiginoIJibZ
 KvtQ==
X-Gm-Message-State: AOAM5304LLP2IqBCaG+IXfvuPGX/woJWnBPoJ0UTxPnxTXcbmQSE55IU
 MO5DHg/VZ4vgXlxNEo9MGlq04pv4sMqMXKe9fMI=
X-Google-Smtp-Source: ABdhPJyPUOzOxETKX+ysZzDAt6fXbz4dHxvz/ibUX0Cylp6ftW9MKNJ8UKzGxFIt4lnNCuFUPmYsiEkIHMI1itRR7O8=
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr1074314wme.79.1590092748764; 
 Thu, 21 May 2020 13:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200521195306.261777-1-Gavin.Wan@amd.com>
In-Reply-To: <20200521195306.261777-1-Gavin.Wan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 May 2020 16:25:37 -0400
Message-ID: <CADnq5_M6heZqmGt4mU3DQ+x=uE8mG4PhjbK8=AfuoOV3+voajQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
To: Gavin Wan <Gavin.Wan@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 21, 2020 at 3:53 PM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
> For SRIOV, since the CGCG is set on host side. The Guest should
> not program CGCG again.
>
> The patch ignores setting CGCG for SRIOV.
>
> Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index bd5dd4f64311..52b6e4759cf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
>  static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
>                                                bool enable)
>  {
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
>
>         tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
> @@ -6842,6 +6845,9 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
>  {
>         uint32_t data, def;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         /* It is disabled by HW by default */
>         if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>                 /* 0 - Disable some blocks' MGCG */
> @@ -6911,6 +6917,9 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
>  {
>         uint32_t data, def;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         /* Enable 3D CGCG/CGLS */
>         if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
>                 /* write cmd to clear cgcg/cgls ov */
> @@ -6953,6 +6962,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>  {
>         uint32_t def, data;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
>                 def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>                 /* unset CGCG override */
> @@ -6994,6 +7006,9 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
>  static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>                                             bool enable)
>  {
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         amdgpu_gfx_rlc_enter_safe_mode(adev);
>
>         if (enable) {
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
