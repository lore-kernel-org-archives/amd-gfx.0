Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91911FCB61C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 16:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126A310ED7C;
	Fri,  6 Mar 2026 16:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVFD56rh";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E6D10ED7C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 16:18:04 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1273c690e5bso422275c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Mar 2026 08:18:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772813884; cv=none;
 d=google.com; s=arc-20240605;
 b=JBk9TeKuqIVSHggPkIQNNI9LvKngnyU57F7rvCTqiR56XNRIpsJEsef64C//QBmO8L
 YVBC84y3UhNDrgmE1h7T41ZFMhF/qCio4Wmu73e7izNhdYeJl+eE1Fy0EKsXN97LP1Gf
 Sg8qEummULxTvyasz9GcBX7akWGs9u33P/+xoqTNp/jF8AjskM8xsdcKgoeoHJIg6f1Z
 wCvn3BR3ccbrreKELOvNx1dyUtcenctaTPIzkmhy4ZrcehSt4R6rCpNjZAoLA5MOfw0a
 9U1q8Hl2xBuRt587vFGhrWCA4Gz+G9niXAVVL8kp3vPgzXUYtJLzZb0f0kCdqnJPdjPx
 Eszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZH4npDyi1yu9hOpVWDZSFiPfyTOho6DZmRWYwBPNeCA=;
 fh=6hBdGxWZeSTkApqL+P0Qapfditfmkabrxr7UR/lA7hs=;
 b=U/sTVsK7e9sYcIJSrpOAt/ZUEp190re7O6VwVIiiFrnhZqhM80u3ddwWen6kj/9/X4
 aId1g1Fzm2Adt8lJlb4XlOp2YnecTyN//valQ/XtVCPyp4L9B0iKqQcfYIY4oTF2AVDq
 g5wm8VI2Hn9fZI9YYyYq2/HtjR6JDSIxVoyo2CVT6UvuuSiBpejyw7YGcAcOXlwKxHWO
 CDA7fHEJN4uhnJFTtELSc9m4deTug/Pk8BU0BHVpGiKHVkxmceewLnumL07wDMYKfkiz
 X28fUX5FehfGel2XS6rr8dwbnZjog+ANhL9qXCBskiH93XX62T5p2VTffa+0kL0ld54I
 epCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772813884; x=1773418684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH4npDyi1yu9hOpVWDZSFiPfyTOho6DZmRWYwBPNeCA=;
 b=ZVFD56rh8pdNkx2gK5R/4YnrlEH5TEHphw8oW23BaFxQ04F/jdyHRe6dmpeDcTArBp
 xPmUrNJJ/662F3DmWNDzN9CPIPYNijcFLan/zZQsSgSR4s1bo+VUZShtoFoqGJYpQTCq
 E/arM1xHYZJyr0ql7QmeZiZhLWwpTpoZ8HR/VlUmcrwfYwSPq+4JfmfFUxxjRMMe6s5N
 6ySNgqfbR08JIDwp5iKozIdQHgeEasRDp6uzthnTXyI2LfJoqBW+cdsf9GMZ2AjmXAXe
 H2Lctwp1aEu9gOmqMSpvBaG1JtpnoAgepWjbSabPcTJvxpACY1yljaMqYdJ551hGVm1r
 mOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813884; x=1773418684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZH4npDyi1yu9hOpVWDZSFiPfyTOho6DZmRWYwBPNeCA=;
 b=FHUc+WHIIm4mwPtz2MllQummxx1XWxtriYh6ZIkr/xvP737ozq9qgd0sjKKu92+A9u
 ZWM1wjIcfWbXB+BsAZoPtM7/c+KQcocj63L9gkvACm0cLRK9R+J4oObfmGH9HTHq6S7F
 n1TFca7ZiqnzS24kKv7GLaxy8HBrB7aSle6vQvUsxxT+hnYLpHeavw7tRv46OBtOuMbQ
 u/uV5odKdbjCzINqFUFUe8acs/xr134/CXWgMcxd2SdyBpLh1p8w+/DzSzcH09gEXG/7
 EgGsDS99bdgMtg6d5Hx2d6S4AZXGOZOlk2HBjDZpPcr8wTTFmy6tEob5XZpWxI2sOSU6
 T2ag==
X-Gm-Message-State: AOJu0Yw1aF7ZWeux4dvfX+kHTHfklyU7Lp0++s8M+bpHEWHJ7As6slmm
 1QZb1K70HMewXe+igDkeXa4/5ecUuyxCR3NWqDmH6rrpjrJ/BiKLSAf+6Bh8+nXbgf4awv33Ad4
 CP7DQrBWR3oXSMLTkETdtHm7zRpyCUNM=
X-Gm-Gg: ATEYQzwVOKGvXWJ6HiMlOzCsjIMT1srCrEZL0RELjrZVeCp7YGueYUqtSS2ZX4xr99l
 WMK/mxMrLYv1/5zEfzZJpFuHSJc+fPFmVU6Go9t0PJX2t2H+bj9lBaTqtF9ZuQP8i4PrMYBKLFB
 fA4x3L0JQ6zlwuh6TEtvtt+dF/+XKvx9KcGf62ndOyi1A0QnqTdIsFfRLYrF6OKfRcbqQQ5erXb
 H16rXUcSi8dxrgxFtzjyKwIV0PW2VuN9JErRqmPVCYtg+pKNCMmS0lMFaHDktTQ01UMwTzNjh9D
 Za7UzcU0X1TcyU9O+RAblWLgDLxLm9iZVrbokXmsD9l4imyf8+sC6CdfNHZ4weX4dhnu7g==
X-Received: by 2002:a05:7022:f414:b0:123:308f:667b with SMTP id
 a92af1059eb24-128c2d90423mr737056c88.2.1772813883435; Fri, 06 Mar 2026
 08:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20260303161921.435188-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260303161921.435188-1-Chenglei.Xie@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Mar 2026 11:17:50 -0500
X-Gm-Features: AaiRm50z1uOXhgRxjRca2Wqp2s6QV_7ym4ZsgMndheZDcGxzHuGADro7IgAxgTM
Message-ID: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3
To: Chenglei Xie <Chenglei.Xie@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jeffrey.Chan@amd.com, Zhigang.Luo@amd.com, 
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 3, 2026 at 11:29=E2=80=AFAM Chenglei Xie <Chenglei.Xie@amd.com>=
 wrote:
>
> After GPU reset, the hardware queue is cleared and all pending fences
> are lost. However, the fence writeback memory remains stale from before
> reset, while software continues emitting fences and sync_seq keeps
> incrementing. This causes amdgpu_fence_emit_polling() to wait for
> fences that were lost during reset, resulting in -ETIMEDOUT errors.
>
> Fix this by updating the fence writeback memory to match sync_seq after
> GPU reset in gfx_v9_4_3_xcc_kiq_init_queue(). This aligns the hardware's
> view of completed fences with software's view of emitted fences,
> preventing timeouts when waiting for fences that no longer exist.
>
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index ad4d442e7345e..6b5fcdd987693 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2135,6 +2135,15 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct am=
dgpu_ring *ring, int xcc_id)
>                 gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
>                 soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id))=
;
>                 mutex_unlock(&adev->srbm_mutex);
> +
> +               /* Update fence writeback memory to align with software s=
tate after reset.
> +                * After GPU reset, the hardware queue is cleared and all=
 pending fences
> +                * are lost. The fence writeback memory may be stale from=
 before reset. To prevent
> +                * waiting for lost fences, update writeback memory to ma=
tch sync_seq.
> +                * This avoids waiting for lost fences and prevents timeo=
uts.
> +                */

This doesn't make sense.  No other kiq_init_queue() function does
this.  When the GPU is reset, amdgpu_fence_driver_force_completion()
should get called for each ring.  That will set an error on the fence
and update the fence sequence.  Why is that not working?

Alex

> +                if (ring->fence_drv.cpu_addr)
> +                       *ring->fence_drv.cpu_addr =3D cpu_to_le32(ring->f=
ence_drv.sync_seq);
>         } else {
>                 memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
>                 ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask =3D 0x=
FFFFFFFF;
> --
> 2.34.1
>
