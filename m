Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD7C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 18:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786CB22249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 18:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSX5u/8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786CB22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B424B6EE34;
	Wed, 21 Oct 2020 18:07:43 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3766EE34
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 18:07:41 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c16so3564298wmd.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IVcYwi8Oocxr/mih5m/KwBAX7yMSrVsDkaoogCZ8I7Y=;
 b=pSX5u/8SC2AHcGhmEFUM47QZe7q+2Tvwu/XXLpE3PM1lQLnq3uomUOQ79LvUVz1IrX
 ocu8h5l909xzOL6c0fhDq+CJIEqdv7pFIaBvym5+5vZL+c5oLfN4DcSspdpIjY37ojvZ
 LYCyPf8+apwtu0nR+81m3lP2VqHVCwPODkM5PoS3POBRUFPL1WoDkYQr7kttnxf1wTqQ
 7Zh3OiPhNkGJpeIhK5Ke+uNUyrjd2xyTch5iR2bre3tStGXyuG6XPw+/yW2zrW/Xzz4w
 79txo+Mem7CCbUjoYuiqTcigf+D0Fx/1631Vn0YXIH4yTj4W9HbbEGHZyHcZPxF6cuBD
 2hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVcYwi8Oocxr/mih5m/KwBAX7yMSrVsDkaoogCZ8I7Y=;
 b=K5PwSOLWNPfh0Cvt8zBQIvoxCCd4kVs1jVVkBc1rDt1E8ZeABVHSvRw6sHiMo+M/jr
 7fluIkNPZQW0LJsP1N9aqenE+3R761prsoo4FHQrPbTU2RRMHQcMFI17uacdZPOZJJDO
 X6kXQoXBH4frsAfe/zmpEGxJxS5qffbE8mUvvQz/UTXDWq6N5ndENUjqR2geXU0YKgN6
 2ywkLX7sFABDhBCf1itakl5r74ZugGJZH5glaia4H2qwFWEuu9xRXWGQU84LQc/Avd7y
 2gQtCKVp8vm+yxobDq0I08VQJxHFqZ7rjp//rQaTC/45MoScINEzEMfmdGrmNldrcGSI
 PQ7g==
X-Gm-Message-State: AOAM5306CrYFiNP1AA4j31rsdh6UUmPIHMeSx+v4JKq6jHJ/mTV8wg2Y
 W5yq4exwzpqGcfdFBpnTHVnPOhBczh3+cB/McIM=
X-Google-Smtp-Source: ABdhPJygWJSDi/9cLbWlawRW5yH7pXlypfRn/9BV0bLH09ORNjEOJDsKYSPa6QCxi2SHTxqdTx3ay4JstRdCHJOQg0s=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr4791370wma.70.1603303660554; 
 Wed, 21 Oct 2020 11:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201021165524.888802-1-likun.gao@amd.com>
In-Reply-To: <20201021165524.888802-1-likun.gao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 14:07:28 -0400
Message-ID: <CADnq5_N4gMQmWm8opP1uunSQMMmOHBBap4xMh0HeDDb8XRZepw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: correct the cu and rb info for sienna cichlid
To: Likun Gao <likun.gao@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 12:55 PM Likun Gao <likun.gao@amd.com> wrote:
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> Skip disabled sa to correct the cu_info and active_rbs for sienna cichlid.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Change-Id: I271682e11f3472cb5ba882e04329976059e06a13
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 402fe623c5d8..49ce4aaa2bac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4579,12 +4579,17 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device *adev)
>         int i, j;
>         u32 data;
>         u32 active_rbs = 0;
> +       u32 bitmap;
>         u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
>                                         adev->gfx.config.max_sh_per_se;
>
>         mutex_lock(&adev->grbm_idx_mutex);
>         for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
>                 for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> +                       bitmap = i * adev->gfx.config.max_sh_per_se + j;
> +                       if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&

I think this should be >= CHIP_SIENNA_CICHLID?

> +                           ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
> +                               continue;
>                         gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
>                         data = gfx_v10_0_get_rb_active_bitmap(adev);
>                         active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
> @@ -8829,6 +8834,10 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
>         mutex_lock(&adev->grbm_idx_mutex);
>         for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
>                 for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> +                       bitmap = i * adev->gfx.config.max_sh_per_se + j;
> +                       if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&

Same here?

Alex

> +                           ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
> +                               continue;
>                         mask = 1;
>                         ao_bitmap = 0;
>                         counter = 0;
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
