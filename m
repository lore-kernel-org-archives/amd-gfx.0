Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A89EC5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012AA8916D;
	Mon, 17 Aug 2026 15:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="At+c3OpU";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523D88916D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:50:07 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-392af6bda98so398632a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 08:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786981807; cv=none;
 d=google.com; s=arc-20260327;
 b=Mm+R7PFUMHx1U1Qe9HoFWdVSHBN2e5ZWLzvwi0Ie+gitF5TjN4axStRgTLQGbACHdQ
 LVxQuM28oN6dqC69MXu8sH8RZ77uaE5wKGR6JhO8Htf718Or2sFYuXIlUk4P9HNUI965
 mEJLdUtoOc6EckuQ23vWWwa7MHkybdTt4dmTKaFo9SS59RW+SFnXoGDd0O20VS7UB8VR
 i2ER/rRMmMVaHh7RL+tbf8RovO9ymDDpS4mnY4o8522QN4dKE5hyH72hfILaYqBPznWh
 wHrwa7kjwCamRos/Yip6XrRWxWg3ZmCgkeDprIX83WPAN+7oLKMiZnnsxMYqRXxYqpeB
 +16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+mS7CI5znZ7VAP2bJOpsmLm22U/E7yLjGdlEJQ0epFQ=;
 fh=YFqqTxdR3R9j06ZYM4qB+o3OGNiDDAN5wTvPWvcIcoo=;
 b=A2/b3pIwvbggVEKMsNRgRav5EP77xsuorkCr87PiH9CvItKwD2tNCQpzajDuLCJXnl
 Qu3wNWH6H5hUNJEtm9aPkVC72wMhXlWVGBCIJqG8VJH/EfxN4F8D8qqCPs/h7ouonDFg
 9B66XQTBqpr9rYQyT+zMw5JtFm+2uR1FyYUC1kztd6nkDDh5VDBA2WAbmFKJ5af9kbyj
 0VNKTQM8egu1tPsP0m8PJj1sGy8OZK1BFUJWhzAkHyDfGW/5teFrbQ4vtojLpTm6qYDH
 A10tjgOCu8XT5zll+adVSNyHONas+Rp1Xu7J0XxeBJD6CXrw6gUd74JNqqiZFM5hlTpP
 Qvqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786981807; x=1787586607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+mS7CI5znZ7VAP2bJOpsmLm22U/E7yLjGdlEJQ0epFQ=;
 b=At+c3OpUoL1Vb5aDeLQHr84j6iv5Jf+M1JNnPMcoxRymg3t4fD0JWD9Vl9mkJ6Vz+o
 VJRFo+BHRLmJACW1d/XqcIPixImqHmVtONZGXBRdx2YVkX7HT7d5kPqVukpcoVI7rC6c
 /j88VHWm62bIr3lOE70CE4jAbKW+FdZ76I3Xwfoxv5rOQAnW0apNGASzr64eiS12Po4U
 7KZWl2ysP4sP5Rbl9OKKOYWku8iT4oE+0Vr2hE5koqXUORccJPtUqw6c6YoEvV1u5Nvb
 GF7fmLYZ/5lKq0Hdp/y/xAAj1YJGqQfQUjfvO1ApnAtyfVtmls0Y6F4gZQJflatY4kMR
 +UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981807; x=1787586607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+mS7CI5znZ7VAP2bJOpsmLm22U/E7yLjGdlEJQ0epFQ=;
 b=tZJWXbQHxrF0y0gzTYZVCuxmjo9lt/5QmJP1sHPa1Y3KiATHpNJ9iGO4j+iBS/G6Vz
 P1ElH6EVPojPaXpAJa4MlfE+pZBEJPX42GNKtCN+quQevrl/5gvj979XswQVyw/mA9CN
 Nvtraa5rgogf5uzQDpBhZxvpwtG6lQmS0etY72itETRuaTLgKz2viDSAUIhompJzAONO
 gFiEQUHkbeAe96dKSdLuXMLm0gJcvqc0oDjXsXBMZy+meov+acx+miSr7h72HfOX1aIY
 8FfWNcwIwUAhYNtEUjDRlb82r9H9KBF54v3fn+7Kaez4Y8WZ3oKMCGrs4Stp18f+dITF
 0RNA==
X-Gm-Message-State: AOJu0YxoWZAbKzL/igUV0XU+nw+kADerYWqYSx/SeSmYe2JhFbJXPXTN
 oBHr20ZulmM6SXw3659REFuJ3vve8QKNBwmUj2SNgoHI4YBc94tfwu9Y2ws83i2PYcUlf31rQEv
 Uzqio0SIiMG6CcqTs47FbgxDSV8+0Aqk=
X-Gm-Gg: AR+sD13pExgA9ajXQUyR+bmz5mNk/DxTNT+B/cTFFC5KztzgQ/sLk5VClg7T3Xv6+Em
 LMYeGa0lmX2Zp5AeY7PKV/m8Vs5XxrMv6AqN+tMJZOQ1Z4ntG7ew7OApaarfC4PSmpyDLU0iGgs
 2fqfHk4jNce3NyKIHHW+OWxCPluXxKjEFswWkSx7aqlfErpk/h+/4RCGdYUiLqo45PGuFP5/EZS
 oUPiHkMp7GcWSRlQf+Zn/w3h51DPg70bQUCjHz/EfE7XynLUxX2o+wJcdysVLBkGX5LWdvba1dU
 5pFQ5OI9i5Et8lsk8FqsaBxdfuW4LjkHsC/48gRlNelqDHLxuwmFpYqZlqjZzbTcoK8KQLe8+PQ
 SOBEX8B1oWtYfIB5neE8MfAOMKFR48ag=
X-Received: by 2002:a17:90a:2ce3:b0:395:4df3:8800 with SMTP id
 98e67ed59e1d1-3954df388e5mr2752052a91.0.1786981806590; Mon, 17 Aug 2026
 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR12MB8600A6C7595378BECA3E4A999FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600A6C7595378BECA3E4A999FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 11:49:54 -0400
X-Gm-Features: AcwNN1V67yHExTs9iwrvYJZ3LNWw9wOcPLibEKj91ytbR-2EwjJCe2TjegH4-vs
Message-ID: <CADnq5_MAW7_GOR3sEeGB5xQAEuCugBqZuU0jiUwkjBv7ckwMfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in CRIU
 queue restore
To: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Aug 13, 2026 at 1:15=E2=80=AFPM Marioukhine, Vladimir
<Vladimir.Marioukhine@amd.com> wrote:
>
> AMD General
>
>
> Both create_queue_cpsch() and create_queue_nocpsch() unconditionally
>
> call mqd_mgr->restore_mqd() when a CRIU restore is in progress
>
> (qd !=3D NULL), with no NULL guard. On any system where restore_mqd is
>
> not implemented, a user holding CAP_CHECKPOINT_RESTORE can trigger a
>
> kernel NULL pointer dereference and panic the machine by issuing
>
> KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore object.
>
>
>
> Add a NULL guard for restore_mqd right after mqd_mgr is resolved,
>
> before any resource allocations, returning -EOPNOTSUPP if the callback
>
> is not implemented. This avoids complex error unwinding and is
>
> consistent with the existing checkpoint_mqd guard.
>
>
>
> Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
>
> Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
>
> ---
>
> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
>
> 1 file changed, 10 insertions(+)
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>
> index ea9d87450eae..25b738200e7e 100644
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>
> @@ -769,6 +769,11 @@ static int create_queue_nocpsch(struct device_queue_=
manager *dqm,
>
>                mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>
>                                             q->properties.type)];
>
> +            if (qd && !mqd_mgr->restore_mqd) {
>
> +                           pr_debug("restore_mqd not implemented for thi=
s GPU\n");
>
> +                           retval =3D -EOPNOTSUPP;
>
> +                           goto deallocate_vmid;
>
> +            }
>
>               if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
>
>                              retval =3D allocate_hqd(dqm, q);
>
>                              if (retval)
>
> @@ -2134,6 +2139,11 @@ static int create_queue_cpsch(struct device_queue_=
manager *dqm, struct queue *q,
>
>                mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>
>                                             q->properties.type)];
>
> +            if (qd && !mqd_mgr->restore_mqd) {
>
> +                           pr_debug("restore_mqd not implemented for thi=
s GPU\n");
>
> +                           retval =3D -EOPNOTSUPP;
>
> +                           goto out_deallocate_sdma_queue;
>
> +            }
>
>                if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
>
>                              q->properties.type =3D=3D KFD_QUEUE_TYPE_SDM=
A_XGMI)
>
>
