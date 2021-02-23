Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE461C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D1061494
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D1061494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659A46E843;
	Tue, 23 Feb 2021 16:35:12 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91956E843
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 16:35:11 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id c16so16218965otp.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 08:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dw5DeIBdVI3xZEvM45CGS+M97Sm1xEE16ipjH8riUhQ=;
 b=OQPuK94DeT7KLaSq6DvKNPeE+/VkXJGhGQJie5VEcDsMDIYuitFvKGgpCRMWc56//v
 b3748lChuK5zSEppvS+mJIN+duwUaFtKHpjxtlqMewqLH32V8XrR4dCa35VMSXgw2exS
 /mfrwUVMpmZjQLzu25zrmNxlUJGi8RQZ3Ef1Ek5corNrOiZMDn8KmZ01RSlAx8Fx/7oR
 ltUajz2AAC1DKO4L5McsGvI/LaxKxVLY10lbx7+gLoxRf6eZEquAOi6n2D2efb6sIDl3
 dj+x1oKERQbEpPoggZ702caeoqiunwj5FzYQ3VzAU6ups4EjLqFqFyGTRVJ/Yt6c5vi2
 A4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dw5DeIBdVI3xZEvM45CGS+M97Sm1xEE16ipjH8riUhQ=;
 b=bqmq6a+lSPHXdp9flGLx/zDv60kTB2A9cslQmUZLMHcEuk8EHDP/1arxblJ5o7dSvA
 SbiSzCU3MkwMmZOL+jt2V6uGNS8v9VV1K365L8hfeKTb1doPSEZy+aIbzGePSPDJfExR
 vx0oufAbEYg4r5GOpRIdHbHbBhy/JJHRQMUCeItx8smFOXRD3y/HF0rqkx6VtkhL3aQo
 uX9I9i3HzdrLPY+XTUF+YMYuX+094q1SN94LBe7T87bC/3+J0aVbxTmlMQCGVlXYyEuq
 1ok+5hubVKyjij27FTTlWxKePG+RqfK123uoP/q4zXGPwhp2lakG5w49g0NHUuI8FZkL
 M5wg==
X-Gm-Message-State: AOAM531p8ddbM6KLmCp3tf6+6sR9neVv6gB77zy0OauZXdUOzgbOB/8Z
 gaycIva17aRKxKZXkg/O556kdoHyukUdsu3iRzY=
X-Google-Smtp-Source: ABdhPJyBs52o+3e/hlq1Q18oFqr4oCNZOeid5zCWKjbDyqTiAJjrw1k/trrvz03k/GN0nL7/4kDDJm9ZI2j3GvCXie8=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr10419444oti.132.1614098111301; 
 Tue, 23 Feb 2021 08:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20210219011954.28566-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011954.28566-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Feb 2021 11:35:00 -0500
Message-ID: <CADnq5_PE5fW6ShzCrE6bUiRWHm=Urbs3GWfdXjtsNJ8FkEvGaQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Init the cp MQD if it's not be
 initialized before
To: shaoyunl <shaoyun.liu@amd.com>
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

On Thu, Feb 18, 2021 at 8:20 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> The MQD might not be initialized duirng first init period if the device need to be reset
> druing probe. Driver need to proper init them in gpu recovery period
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Iad58a050939af2afa46d1c74a90866c47ba9efd2
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 65db88bb6cbc..8fc2fd518a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3696,11 +3696,18 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
>         struct amdgpu_device *adev = ring->adev;
>         struct v9_mqd *mqd = ring->mqd_ptr;
>         int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
> +       struct v9_mqd *tmp_mqd;
>
>         gfx_v9_0_kiq_setting(ring);
>
> -       if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
> -               /* reset MQD to a clean status */
> +       /* GPU could be in bad state during probe, driver trigger the reset
> +        * after load the SMU, in this case , the mqd is not be initialized.
> +        * driver need to re-init the mqd in this case.
> +        * check mqd->cp_hqd_pq_control since this value should not be 0
> +        */
> +       tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
> +       if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
> +               /* for GPU_RESET case , reset MQD to a clean status */
>                 if (adev->gfx.mec.mqd_backup[mqd_idx])
>                         memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
>
> @@ -3736,8 +3743,15 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
>         struct amdgpu_device *adev = ring->adev;
>         struct v9_mqd *mqd = ring->mqd_ptr;
>         int mqd_idx = ring - &adev->gfx.compute_ring[0];
> +       struct v9_mqd *tmp_mqd;
>
> -       if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> +       /* Samw as above kiq init, driver need to re-init the mqd if mqd->cp_hqd_pq_control

Samw -> Same

I think this also needs to come before patch 1.  With these comments fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +        * is not be initialized before
> +        */
> +       tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
> +
> +       if (!tmp_mqd->cp_hqd_pq_control ||
> +           (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
>                 memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
>                 ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
>                 ((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
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
