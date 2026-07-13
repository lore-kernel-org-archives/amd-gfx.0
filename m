Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D652C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 21:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2278A10EB0B;
	Mon, 13 Jul 2026 21:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZcmNpds2";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BD210EB0B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 21:00:54 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso10107885ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976454; cv=none;
 d=google.com; s=arc-20260327;
 b=rq6SbH8r6xjGfmf3+LcVEeC0Qmu9YQverHtJaw1vNlveDN8a6rcok7ftMexDkOt/lP
 GInKBWIWf3OxXQEmJNuKxYMFmthQIm9DZaa5TlB/odcu0DuqKXVXp515xr0eQ5GSYdiu
 28AQtM87dAhsK8TqT8GuAQ6rtNS8yTlLG23cohIy05un7n/2xQCL94d/6RPiCfzna1um
 NKZWVvWEG9vvhwg8mdgrWZ9/RN4HBhWre8n6YGQGucZQN9xsdWgkEWo1ovzBVbq90pu6
 Ybr53Q4qPByWSSZS3HfPRlah3Y5qr032y+6TIanwK/ZYR5zZB12h0+h5KjGJkQJzzawx
 yVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bNpPiRgzRJWAtGU6MqEaeHnpnGRLxUroBVrpCrP2DDA=;
 fh=2IpRurXvhGNuEJ/vy0+lo89l8gwfXFVnUF8ibJZ+6WU=;
 b=U0Z/AzfdHPLAnaPrb4JS6+RfMvpsDDm6VmyHjm6f3ti2JraAVq0UqCGre+Clkge+Tb
 SCayY+Phhh38m1DnHmBhc5qZGboGpowBJFF9VugQgsS4fYdiaY8AFXQLS2BbGFMtKyau
 rIQBdqk/Y4thEI+rsS6+kPsmMolzPzavIGlf/b5VlLu90oXRhyT3y1Sf99ocR5b9BoxB
 EUFRvSa3dYq6cKrGLnrsHGFb3kNpWzlOxnLmE9HChuipY/4lDMd82VfIG4w8lV5l9lbf
 sGgiFt7xvHu1J+mMD8jIxF/eH+XXtZCUpavyUarsgi33+2L3aAP8MkFXBMQqdQS/NJ7w
 0IEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783976454; x=1784581254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bNpPiRgzRJWAtGU6MqEaeHnpnGRLxUroBVrpCrP2DDA=;
 b=ZcmNpds2YrLgUv3NYZG9tgCOsDmo3fmFZ1bHRYpiz+xOQEfHJltOQSPZU2JZM1CQ/W
 9FmEddg8ocNM68dLdmPaiwVM/W+riCu78xGWzr7/3fNo+BfAUoUcWe3f1XUtCJzrebM4
 dIbiD3wWFxTb6CiBN7dzpMg1CUQtwHXi24qwJx7IwHTbXRRdulW2pREk5OeWK6v8nthw
 q0DDJ7J20SjIRZM7k8g5aAgoLNLqjU9Cb6WKqpfkwgVpkr3iEF67FgU96jNN0v8Bb+2c
 Y3slrYHcj2zFf9Qx2z9GuWHPtS8G6jNGj7F9BLObWfsn9wNuQ9Q7jCka4kA19qAz9FDs
 CTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976454; x=1784581254;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bNpPiRgzRJWAtGU6MqEaeHnpnGRLxUroBVrpCrP2DDA=;
 b=YniCfYEugqmDGEUVJe0oMxbWiFy2mHCmrCJOGZfeRFFpl50f/blgs0jOnEuNGt8+go
 eG1iz6tdNDW4TokEccikYqmIvpVIOiqxYCxpsZQ2k4yQMwJRn2tU6fAhCHZOjTE3f+FG
 cdGd/evvU/Mx7eUqpBcL097UrjqYZq8DtZ4JtjPQR4BULKWomujyXPuHXah3s7e0Srcv
 yNO6dxmJI4E/CfYY9pLK6kmnMKu1bbRaq2DnJplLisAz5JE4bpcCVZbO6miSNdBB+CYz
 O70QwXQ1bZIJiJ4isKPGO8rnCJPS3oUeG9eGrmHbhE+VPfiHGGi22fhPXHyHzNdtSJUS
 GtkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsW5xdMg01UdysTDUoWpwhQf+EjIM4R4tNZSECdfzIPiuyCU0Z3EqvIh3FFG0khYGRs5SPIgQe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+baLC5wg2DiRC0l8/Isz/tFSL85GR5T5Lgm14xhMwYnzC+Uxm
 WPSjY0gw/U6dFB1LClpj18DyMup/Qa0y3AbcD1WWS7+POluQkbEHoouuzYDxg6Md3KASjGPwhhK
 WnvK+DWjXvin6G/AZM16TCB0ScRNma9kfwA==
X-Gm-Gg: AfdE7cnNlfipXurdnt7EQf/kwWliZM2nl6f135uFjQnKPBZ31CBC1ErJIoWrpWCM+do
 bSDrBqwTcRV2Dphuimv2O/Szp9dd1hZEIZ9o9h0ghTu58YQ7pHIHKbJmsxTx4O9ZbPfevcN1C4A
 wvqb2gV86bQ63P7otV+5P5l44KfLxbWTTacsGYdhreg4E7ivltX4zCbP/LIUmJ41uA7vVSZa2gm
 F1eloVIrdKh+EaHBjKPW63PJTjvibwOV3WZkL9May2bqq1TdITM/l11+E36RpXsZmb2xe0jthrf
 Cdig/FwSWFcKmYvdwiIMX/bTD5tBqKQPHWRQEQzrqseqL+1l8mR9ukjhGes=
X-Received: by 2002:a17:903:19c3:b0:2cc:7d4a:3f59 with SMTP id
 d9443c01a7336-2ce9f187e8cmr82387845ad.6.1783976453600; Mon, 13 Jul 2026
 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
 <20260713164321.3350036-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260713164321.3350036-5-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 17:00:41 -0400
X-Gm-Features: AVVi8CcTs8junAfcZYyDpVs98cL5MwiGF79kYLdMO0N9bf8NJ3uPF6ECk6rUw_8
Message-ID: <CADnq5_NMu8eVhhrnkKVui2_cY8yn7Opr7OOqW4V2Svc=fpnhFw@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] drm/amdgpu: Remove queue-scoped WAIT_EVENT records
 on queue teardown
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jul 13, 2026 at 1:39=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Pending WAIT_EVENT records for queue-scoped events store queue pointers
> and own queue references while queued.
>
> Remove all WAIT_EVENT records associated with a user queue before USERQ
> drops its queue reference during queue teardown. This mirrors the
> EVENTFD queue cleanup path and prevents pending records from keeping
> stale queue state after the queue is removed from USERQ ownership.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 5bf231d7a630..b3ac1e81c9ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *user=
q_mgr)
>         return &fpriv->eventfd_mgr;
>  }
>
> +/*
> + * Get the per-file wait-event manager associated with this userq manage=
r.
> + */
> +struct amdgpu_wait_event_mgr *
> +amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +       struct amdgpu_fpriv *fpriv;
> +
> +       if (WARN_ON(!userq_mgr || !userq_mgr->file))
> +               return NULL;
> +
> +       fpriv =3D userq_mgr->file->driver_priv;
> +       if (WARN_ON(!fpriv))
> +               return NULL;
> +
> +       return &fpriv->wait_event_mgr;
> +}
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>         int i;
> @@ -1040,6 +1058,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>                         return -ENOENT;
>
>                 amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
> +               amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, qu=
eue);
>
>                 amdgpu_userq_put(queue);
>                 break;
> @@ -1426,6 +1445,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr =
*userq_mgr)
>
>                 amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(user=
q_mgr),
>                                             queue);
> +               amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mg=
r(userq_mgr),
> +                                              queue);
>
>                 amdgpu_userq_put(queue);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 187bfd66eb13..6a53cd3208da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -203,4 +203,6 @@ int amdgpu_userq_input_cwsr_params_validate(
>         struct amdgpu_cwsr_params *cwsr_params);
>  struct amdgpu_eventfd_mgr *
>  amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
> +struct amdgpu_wait_event_mgr *
> +amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
>  #endif
> --
> 2.34.1
>
