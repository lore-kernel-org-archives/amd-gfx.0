Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F251C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7112B222D9
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of4s23Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7112B222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110FA6E0AA;
	Tue, 10 Mar 2020 13:23:39 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AC56E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 13:23:37 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f7so1321216wml.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G13cxxGcOuNmlU7sihHE0F52DK7hjkF/6WQktS6lb+4=;
 b=Of4s23Uahr9bEpiXTEifWl1juDI37OJzkFvn/NoTjgS9hOiGEdUbYYcUy3y/mGQumj
 frOKRIU0ZGDQ267+QEZewECZ4G0lpd85y6rq/JLz8O5Bwqgg18Ije2SsU1Lqhv5aQwaL
 b0PY1eWaITULu3jxKzBGugaGvcfFIWk4WAAwmUsm34ZpHUL+fP3PIxJNgEImqLozugRY
 fSlf65j12Gd/JXgSlTXPwmtJ6yfkfR9UYlyjA5SR0Tu2E/OZlrXM79GVf9VjbFNyZSSH
 7TPqtcQc+GtKlSkzlM/pNiyLg6EJFO0ZQnxuSuRYGJhJdVWpfMS/pMEj2s9kSuk/836c
 Juxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G13cxxGcOuNmlU7sihHE0F52DK7hjkF/6WQktS6lb+4=;
 b=uEDfzUuG+82jepAzphtsrW0fo6z5vIM0WQh4hVQSbzdExguKY1icWkzeJhfT3O/6u4
 r6+uq6LBPc7bncCTCpoExRQs90PhIUSpg7HsIHSYorK9MYat5R8eYlSEp6f/+IGqSRmM
 9QM6M/23Z6Yr04ZR9cUvndeiwuFYHpwiWbDwo8vP/sQCsoFx1SIhA/sw8WMn5XNAFMR7
 FmmvjNAVtMA560OyIyb/l5KU4zFjGJp2OwqcJ5RNcQEW7NKsw/mj57nYgaQ6LpId8Mt1
 crVkhMSrdPcaKFNLVHNrKGen2RRWC53f1uPAcAlzjJJZAPsSC0l5sVwOwS/LsqGuNyrR
 IRvg==
X-Gm-Message-State: ANhLgQ0pUDh+fPNP6sVPeKPWMWDD/LqHxYClsNBjLBDodiiRUdj1N27W
 RZGJAfaF+TETQ7VfH5JAEurvAKB0w2kGEXtnn9RbRQ==
X-Google-Smtp-Source: ADFU+vsOqIwHLb8g6MJzfQHr2WZOpFB1uUn3wSw8Wu2lrwsppc02dVHvmnSiYhDvDLaBN7I0i/90iyPG1AbA/4zb4jo=
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr2218941wmp.79.1583846616434; 
 Tue, 10 Mar 2020 06:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200309091215.26768-1-Stanley.Yang@amd.com>
 <20200309091215.26768-2-Stanley.Yang@amd.com>
In-Reply-To: <20200309091215.26768-2-Stanley.Yang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Mar 2020 09:23:24 -0400
Message-ID: <CADnq5_O9BV09fYr16fiRPWCrcCoUVkrXF6fdKdU9AkL6uz8Bjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: call ras_debugfs_create_all in
 debugfs_init
To: "Stanley.Yang" <Stanley.Yang@amd.com>
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 John Clements <john.clements@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 9, 2020 at 5:12 AM Stanley.Yang <Stanley.Yang@amd.com> wrote:
>
> From: Tao Zhou <tao.zhou1@amd.com>
>
> and remove each ras IP's own debugfs creation
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: If3d16862afa0d97abad183dd6e60478b34029e95
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c     | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    | 1 -
>  8 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index deca6343d0cc..1d513e4f9934 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1315,6 +1315,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
>  DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
>                         amdgpu_debugfs_sclk_set, "%llu\n");
>
> +extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);

Can we put this in amdgpu_ras.h and include that instead?


>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  {
>         int r, i;
> @@ -1387,6 +1388,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>                 }
>         }
>
> +       amdgpu_ras_debugfs_create_all(adev);
> +
>         return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>                                         ARRAY_SIZE(amdgpu_debugfs_list));
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7403588684b3..d12bb4a35780 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -565,7 +565,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
>         int r;
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "gfx_err_count",
> -               .debugfs_name = "gfx_err_inject",
>         };
>         struct ras_ih_if ih_info = {
>                 .cb = amdgpu_gfx_process_ras_data_cb,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> index 676c48c02d77..ead3dc572ec5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> @@ -32,7 +32,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev)
>         };
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "mmhub_err_count",
> -               .debugfs_name = "mmhub_err_inject",
>         };
>
>         if (!adev->mmhub.ras_if) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index 7d5c3a9de9ea..6201a5f4b4fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -30,7 +30,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
>         };
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "pcie_bif_err_count",
> -               .debugfs_name = "pcie_bif_err_inject",
>         };
>
>         if (!adev->nbio.ras_if) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 422cdd1ce3ad..57af4ea8fb58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1178,7 +1178,6 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
>  static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>  {
>         amdgpu_ras_sysfs_create_feature_node(adev);
> -       amdgpu_ras_debugfs_create_ctrl_node(adev);
>
>         return 0;
>  }
> @@ -1882,8 +1881,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
>                         goto interrupt;
>         }
>
> -       amdgpu_ras_debugfs_create(adev, fs_info);
> -
>         r = amdgpu_ras_sysfs_create(adev, fs_info);
>         if (r)
>                 goto sysfs;
> @@ -1892,7 +1889,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
>  cleanup:
>         amdgpu_ras_sysfs_remove(adev, ras_block);
>  sysfs:
> -       amdgpu_ras_debugfs_remove(adev, ras_block);
>         if (ih_info->cb)
>                 amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>  interrupt:
> @@ -1909,7 +1905,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
>                 return;
>
>         amdgpu_ras_sysfs_remove(adev, ras_block);
> -       amdgpu_ras_debugfs_remove(adev, ras_block);
>         if (ih_info->cb)
>                  amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>         amdgpu_ras_feature_enable(adev, ras_block, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 7854c053e85d..250a309e4dee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -93,7 +93,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
>         struct ras_ih_if *ih_info = (struct ras_ih_if *)ras_ih_info;
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "sdma_err_count",
> -               .debugfs_name = "sdma_err_inject",
>         };
>
>         if (!ih_info)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index f4d40855147b..9dd51f0d2c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -28,7 +28,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
>         int r;
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "umc_err_count",
> -               .debugfs_name = "umc_err_inject",
>         };
>         struct ras_ih_if ih_info = {
>                 .cb = amdgpu_umc_process_ras_data_cb,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index a54ce398ed77..0837f872741b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -598,7 +598,6 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
>         };
>         struct ras_fs_if fs_info = {
>                 .sysfs_name = "xgmi_wafl_err_count",
> -               .debugfs_name = "xgmi_wafl_err_inject",
>         };
>
>         if (!adev->gmc.xgmi.supported ||
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
