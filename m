Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2A8CD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038C910EB5B;
	Tue, 16 Jun 2026 21:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LsAk5xS4";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7EF10EB5B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:48:50 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bc0b90dd2so82856eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781646530; cv=none;
 d=google.com; s=arc-20240605;
 b=benroLJiM1ZQIixbYBSaEV6PiiQzZPhxJ08nKE9gh8oav/GcvFM/9D7OmoNg+08nvC
 ST6bTCDnVYg4Dbovjf3FKWKylQo63cAYThEEwPFE3Lwi7UBt5ZFYYrxvy81seEtwHLz/
 RlDE/4g9skcxVE9hP55byFKoT0PuMr1b7A/1s50zjBTMzoZX6/qCoiYBPi9ZNnitqnL2
 NQPuuErgJk5J8wLgn6s5+ikzv4Lq/RXWJbe10sM5ck5U28bT6cOFJ+/qewI2PNl7UZaM
 aP9L2acaV+ETBc9/ZDU2Db4g3Ig3MEd2W0zt3JEQ/SoQ6sSUQSWCWmT2pz2QJkS/AWJq
 r/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IVgQUmJZQJUHNJ22HV+TnP7tzdXJl/lubIR7+Ljou7s=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=P+CLwGau38dt94WS7rIj1ywqD7N+aO3sPYwiv3PDmlzDm/QmLvbh4F7imUCVEjET8f
 PPNRzque74S4GJt4O7tjKa7jtJnT9gTJ+18SkNaNkSYv07Dx1QJ5T+j7IHIjesJPI49d
 jOPbjuTY9bKIxoliC5s4YdiV5wVrrbEB/9FNMwz0oyA/YV1xGr7mQ3lsPTEuYS4VR2Np
 nLmJig0qZ7F4Th85oEFcEpi+dDFgpgoA89m1K7ZAwJ/jvzkEEyX5WvRI+9HnkbhfdN/6
 CzEM/x2F8CE7CvOz96AIj3UrDPc3LUiWA6o42g/yKMinDE72r8Da6jJQuE6iChtFjYNl
 Sn8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781646530; x=1782251330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVgQUmJZQJUHNJ22HV+TnP7tzdXJl/lubIR7+Ljou7s=;
 b=LsAk5xS4NPUwJlJJdlj4ffxZQHrXZZIWqtlM5OBcdQc5DrPu3HP+AOMGx/MgT7K4j2
 O+FGO1i5vBV8IZIdTz3oHp36UWFn8r7NxsLihqk3Kkm6eq80t63fyb9my2ArkX+9ZtfM
 lcf/qOOBrghfHjF2Tx0nsMr6veGGWCAAGx3K8WWpi1shaFatpmRjm9I2c8mZ2LzdYtpD
 WK0dGW/AGbrlbkB9O/AZfGhEbcS2bNHARTqpvs2oUuhkIFChuqQerOyRi+NnzRy1hyDa
 3ppejm6avewR0yBBp6BZrT0YVLGLaTlDxFlDwBUKMNqW2AwB7gANb7jiTH/sX6VIlweq
 rfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646530; x=1782251330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IVgQUmJZQJUHNJ22HV+TnP7tzdXJl/lubIR7+Ljou7s=;
 b=Dw8t/yDcU0z6mfbAF16Mq/rfrchR3wz7PAzjaHZYrAh+XFQx0d90idALEDk8zFpx5/
 M7FDRv5kZnlc+Mkr1WTrX146jj+AA9Sr4o5fYQnQhCQ4FxXg+2ebp7u0rkiNSIFRIqnb
 DZD6P6EOyAcyfw/D6SlQVssLZFTGcZ/iNqVZgwbOZb6tOHN3Kf0nws120+HPPpOYcCBU
 MDSVioLPsya/mggDYip49Jp71WbAn2d0OPZDZw9jg5NWbIiJskEHlGQ3m3uGa1SaDfcq
 OyPjtQle3sRDXj5cwT4Cmgq7h03kNOuBnITHPQVI+QKLxycRSq5ejhDJmBrW2xOlvoYd
 dubQ==
X-Gm-Message-State: AOJu0Yy3Yujzz9okD1KK3vQ3lhNPzAsHSHPla9sOtad3NI2ZD8ZK/cnz
 N9F1dQjyIFaLfdL0sD3j0SoweTSKVUOe00R3GnvyIQz3gykWGCIXfMYSp+HeillZP2dIxbRiGdz
 wnbLRmvm2YgjcJrycQ2ioaTnylRrI0NM=
X-Gm-Gg: Acq92OGUcpw/EdOyTro9qzcpE8051DWUu3mduUrswPiRD2V5TBtm3wy6d0wnO7MPYM5
 qooQpSM8YNv36VhhH6Qiwr23gr7vErouKsVgXU23C8Qy03E1TukMgL8WuIMXs5WQm9A3aerkuJZ
 G6v6B0Hu0flm05uIhTDe+6d1GQKMRFxLj+Ah2W+IbjH9U1F5XhZ86EVigWr6GtQhWrimRi3Pytb
 tbyAJx2OXyLGjomQpnheIeBNz/SkBj56Re1Xuh57HZhU7KKVcaVSu0LfxBMvwvwWONrXqv2P+nj
 tbPyhdmMWORWED+Saxq/mz4agUiAx/dvFx5Q90qDgUYixx6N1o780ktuM86zfW7ONVfozplb9g4
 SCNJ+
X-Received: by 2002:a05:7022:ef12:b0:138:2790:149b with SMTP id
 a92af1059eb24-1398f738756mr154299c88.7.1781646529729; Tue, 16 Jun 2026
 14:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
 <20260611035747.548780-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260611035747.548780-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 17:48:38 -0400
X-Gm-Features: AVVi8CcSqshFWl0qTeRP5LBxKnYkXFF_BM22fCYtv-akmEVMJf-4jLcWYzJqT3U
Message-ID: <CADnq5_OWccQZe+3XcqBYsieniPtq-utR8fa-_4ijsAVMOj05vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] drm/amdgpu/gfx12: handle error interrupts for
 userqs
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Jun 10, 2026 at 11:58=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>

Once again, feel free to take ownership of these.  You did most of the work=
.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> Call the new userq reset helper, and dispatch KQs first by ring_id
> before falling back to the user-queue lookup.
>
> v2: squash in fixes
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 +++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 380ba062134e..cb4d84c5f52b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5009,22 +5009,30 @@ static int gfx_v12_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>  static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> -
> -       me_id =3D (entry->ring_id & 0x0c) >> 2;
> -       pipe_id =3D (entry->ring_id & 0x03) >> 0;
> -       queue_id =3D (entry->ring_id & 0x70) >> 4;
> +       u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBE=
LL_ID_MASK;
>
> +       /*
> +        * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never shar=
e
> +        * a HW slot (compute_hqd_mask contract).
> +        */
>         if (!adev->gfx.disable_kq) {
> +               u8 me_id, pipe_id, queue_id;
> +               struct amdgpu_ring *ring;
> +               int i;
> +
> +               me_id =3D (entry->ring_id & 0x0c) >> 2;
> +               pipe_id =3D (entry->ring_id & 0x03) >> 0;
> +               queue_id =3D (entry->ring_id & 0x70) >> 4;
> +
>                 switch (me_id) {
>                 case 0:
>                         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                                 ring =3D &adev->gfx.gfx_ring[i];
>                                 if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> +                                   ring->queue =3D=3D queue_id) {
>                                         drm_sched_fault(&ring->sched);
> +                                       return;
> +                               }
>                         }
>                         break;
>                 case 1:
> @@ -5032,8 +5040,10 @@ static void gfx_v12_0_handle_priv_fault(struct amd=
gpu_device *adev,
>                         for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
>                                 ring =3D &adev->gfx.compute_ring[i];
>                                 if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> +                                   ring->queue =3D=3D queue_id) {
>                                         drm_sched_fault(&ring->sched);
> +                                       return;
> +                               }
>                         }
>                         break;
>                 default:
> @@ -5041,6 +5051,11 @@ static void gfx_v12_0_handle_priv_fault(struct amd=
gpu_device *adev,
>                         break;
>                 }
>         }
> +
> +       /* No KQ matched: HW slot is a MES-scheduled user queue. */
> +       if (adev->enable_mes && doorbell_offset)
> +               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> +                                              doorbell_offset);
>  }
>
>  static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.49.0
>
