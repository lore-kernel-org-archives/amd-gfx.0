Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B6EC88E7F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 14:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED9810E27C;
	Tue, 15 Sep 2026 14:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nR5q0F70";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B340110E27C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:26:44 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d6ff2f2c4dso4957515ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789482404; cv=none;
 d=google.com; s=arc-20260327;
 b=ejf7c9Sw1xP+NPksp20w7fG4baNb50Yf002vTLhaSd8j11nXOfGrcpMqu7JpONq3uB
 UC1fA6Q3Fq7Dohhu2Ov/wHDxrERm6SmXwW71+ONws/ToxYONMx8nhdqtLFo3wFMpOlFt
 m+T8yhvi4VrrtZp/Z3qm9wBeyf2C7v3mrjcp75x4BMLR1BrNNBcUkgbBO1aXAyWhxMp0
 klcGFitn8/Z/BZV38g6R/vo5xeiYp8ZLYu5R/AEf/PXdsAKV992FRUbfisPS7KiFnRJu
 2/7Dd6aMtn1DcOFSHdmF4bVqq6fAEZx20OHTECSJTMN0CtNGc524dBGT7QXcj92i8ZNE
 hcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Da4NDbviDqbTEVYZxzy5e6nQVJN7XPhoPvELVyJ44tU=;
 fh=4UJ76InYkn4ZUBByGZye+U96VlXO28IZpTj6g+q1zYg=;
 b=f07cX/eqULRgS2z+MpyjDBXjhUoLoglzA7Maplzo+ynX0bHRFbOUEddFHAv6oWqZZc
 lJkDLCQfBQXpaX5LbbaQgiWNwr2pcwhEG/Wz16TpsGg5H+Jrkqz4vrYzOFNnRYHBUATz
 RJu1vPNYgkYN0kuUPuQkeRdW8NxErSHH+dhNG1Bu+TJNzNg0cuVYZsnnrhfrkW4i3SDE
 xxPWIe0WPEJgUrJgdZDdRioTmt+IjEIUe7rU0r3FcyM6r3ev8zXfEUM8SFHZ64qba/c+
 QDg1wmmYFfUZfIBrbi28CMQP6NLAHHshaCop0q6BSmVqLmdDAFfnZNrJWKeq6c+ky60P
 cBHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789482404; x=1790087204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Da4NDbviDqbTEVYZxzy5e6nQVJN7XPhoPvELVyJ44tU=;
 b=nR5q0F70ydkhlpmi68pilcjAfqlI43wIRTCCjUNpAeEyybPl9dV37HN7q1J6DEffhq
 iEwrx7mIFd4rS9jWR3eCyMnJ6lfClugD+NRHFwaJLfQVBBPMgjvSF9X/Ilh4J2tqDL6V
 0R8pO4MV+7T7sHFBP6tWuAS3WO8iuS3mFQHxknPgOxLYnIA76WT4HmUwga0RjOcgFsUZ
 8kM3f1L5JhrQI9YKteHNtvo+Rn+LXQFOiunL+unOybAGmtZmrmLmtkQHmbDr1JTejxNr
 diesmqYUXe+XTRs57J8AvnhXusGl7BrUSE4qmZPe6bArgB5UVH75XDLUq05RZowAZIwm
 3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482404; x=1790087204;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Da4NDbviDqbTEVYZxzy5e6nQVJN7XPhoPvELVyJ44tU=;
 b=cPBSzRO7yB7L2bE8Ki8Qqn0C7CBBGAvhYW/5Q2u/zevAQbAxqVjrmzu7JSJrPB8fAK
 euD5Dldko/+SRU0Mn/Fsf8DMNwzYmAcNw5n01L+CIxnMAdYGvyZlsgEEHyyvdMsmREc1
 MFHffEoOEf7ebCP0i8nlQQM4S6sQwHWG9AYfV3GS/5aQvC5xvw9aya4vxbfSblkqUFgL
 AHPUhpkfRhAOJUzUg8L4aKd0sYUjAgeMxIkeY5ZOU98LIccfAx3iqFkiKFA/Fq3MhFuV
 zLCH07KQeVmBL6Fsw5QAJ4vvO+P7jhF3prbTE4q6NoN8tfYN8JJEmO8PJPGnRNnvdR+j
 9HbQ==
X-Gm-Message-State: AFuF++mfTEab0CW8Boete5WtCCxVjxzC35oqSKma/ZFPkPEaoWTX/4zQ
 9nFET2Rr6236zOvZ1KA+XeQoXJ68M9ntUFRtwnQQhexRbGmhg7lklVnUvRwe0p8VUAaekif+aTg
 GKaAJCEVEabcLXMR//ifB8QyZKvERGIFNAg==
X-Gm-Gg: AYBFou21XKhIQ3GC1Ux30S/CqhtR1O0nhzlOWbBEsyC2h6xDSdMqZvWNkTNe0YosP2f
 71c7nqZ5Yda2YEcuok+UGfjYyWjtOPBTxgs5LYxV1s30JDn+VPN6P/YwTh7Ry0RMIPSUXJR4j4F
 uYkG9OgG1H8jbZFsa3APCXF3Kbvry7Cc1VEcPWh+dXQgDraTuqTazpJnea0r2vrGUJMl0J7GrsJ
 Bqn2kHqKeaoQjOciz/pAd1GMJK2US4w0yXRC8KzmsrnqNZFuZ1VCCDzbORZlIYLYMfovdo/FI5u
 jyuhTKB1SUFRvU0CTU/OjShJ/C6yDw2epIM5S8wT9/954cCMw1rN3leWUAFZGADN8FcoQPbhzjw
 CnFvbJet+/tn1QtK7cOcu89ZbsiQre+JJirdGSV2FYA==
X-Received: by 2002:a17:90b:2802:b0:39e:fbf:e7b5 with SMTP id
 98e67ed59e1d1-39e0fc00bccmr1959627a91.6.1789482403974; Tue, 15 Sep 2026
 07:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260915124024.14573-1-Hawking.Zhang@amd.com>
In-Reply-To: <20260915124024.14573-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 10:26:32 -0400
X-Gm-Features: AcwNN1Wdi1rigCV8P2z9f-9Qi3_agNu5zsH0igsFUNFKE4LQ2IkY1HtS4KXxYjc
Message-ID: <CADnq5_O9yBcCkgDt_zpgLtVo7t+oVej_uZUYJPiG0yiFH18OWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx_v12_0: Remove legacy CP programming
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Likun Gao <Likun.Gao@amd.com>, 
 Horatio Zhang <hongkun.zhang@amd.com>
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

On Tue, Sep 15, 2026 at 9:06=E2=80=AFAM Hawking Zhang <Hawking.Zhang@amd.co=
m> wrote:
>
> CP resume through MMIO programming is no longer
> supported on GFX 12.0 and later generations. Remove
> this obsolete code to prevent it from being carried
> forward into future GFX generations.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129 ++-----------------------
>  1 file changed, 7 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index ec1e142549c5..a9bd0c9f83b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -2707,108 +2707,6 @@ static int gfx_v12_0_cp_gfx_start(struct amdgpu_d=
evice *adev)
>                      adev->gfx.config.max_hw_contexts - 1);
>         WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
>
> -       if (!amdgpu_async_gfx_ring)
> -               gfx_v12_0_cp_gfx_enable(adev, true);
> -
> -       return 0;
> -}
> -
> -static void gfx_v12_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
> -                                        CP_PIPE_ID pipe)
> -{
> -       u32 tmp;
> -
> -       tmp =3D RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
> -       tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
> -
> -       WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
> -}
> -
> -static void gfx_v12_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
> -                                         struct amdgpu_ring *ring)
> -{
> -       u32 tmp;
> -
> -       tmp =3D RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
> -       if (ring->use_doorbell) {
> -               tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> -                                   DOORBELL_OFFSET, ring->doorbell_index=
);
> -               tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> -                                   DOORBELL_EN, 1);
> -       } else {
> -               tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> -                                   DOORBELL_EN, 0);
> -       }
> -       WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL, tmp);
> -
> -       tmp =3D REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
> -                           DOORBELL_RANGE_LOWER, ring->doorbell_index);
> -       WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_LOWER, tmp);
> -
> -       WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_UPPER,
> -                    CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MAS=
K);
> -}
> -
> -static int gfx_v12_0_cp_gfx_resume(struct amdgpu_device *adev)
> -{
> -       struct amdgpu_ring *ring;
> -       u32 tmp;
> -       u32 rb_bufsz;
> -       u64 rb_addr, rptr_addr, wptr_gpu_addr;
> -
> -       /* Set the write pointer delay */
> -       WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
> -
> -       /* set the RB to use vmid 0 */
> -       WREG32_SOC15(GC, 0, regCP_RB_VMID, 0);
> -
> -       /* Init gfx ring 0 for pipe 0 */
> -       mutex_lock(&adev->srbm_mutex);
> -       gfx_v12_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
> -
> -       /* Set ring buffer size */
> -       ring =3D &adev->gfx.gfx_ring[0];
> -       rb_bufsz =3D order_base_2(ring->ring_size / 8);
> -       tmp =3D REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
> -       tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
> -       WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
> -
> -       /* Initialize the ring buffer's write pointers */
> -       ring->wptr =3D 0;
> -       WREG32_SOC15(GC, 0, regCP_RB0_WPTR, lower_32_bits(ring->wptr));
> -       WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI, upper_32_bits(ring->wptr))=
;
> -
> -       /* set the wb address whether it's enabled or not */
> -       rptr_addr =3D ring->rptr_gpu_addr;
> -       WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr)=
);
> -       WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_ad=
dr) &
> -                    CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
> -
> -       wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -       WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
> -                    lower_32_bits(wptr_gpu_addr));
> -       WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
> -                    upper_32_bits(wptr_gpu_addr));
> -
> -       mdelay(1);
> -       WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
> -
> -       rb_addr =3D ring->gpu_addr >> 8;
> -       WREG32_SOC15(GC, 0, regCP_RB0_BASE, rb_addr);
> -       WREG32_SOC15(GC, 0, regCP_RB0_BASE_HI, upper_32_bits(rb_addr));
> -
> -       WREG32_SOC15(GC, 0, regCP_RB_ACTIVE, 1);
> -
> -       gfx_v12_0_cp_gfx_set_doorbell(adev, ring);
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       /* Switch to pipe 0 */
> -       mutex_lock(&adev->srbm_mutex);
> -       gfx_v12_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       /* start the ring */
> -       gfx_v12_0_cp_gfx_start(adev);
>         return 0;
>  }
>
> @@ -3511,9 +3409,6 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_devic=
e *adev)
>  {
>         int i, r;
>
> -       if (!amdgpu_async_gfx_ring)
> -               gfx_v12_0_cp_compute_enable(adev, true);
> -
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 r =3D gfx_v12_0_kcq_init_queue(&adev->gfx.compute_ring[i]=
);
>                 if (r)
> @@ -3544,10 +3439,8 @@ static int gfx_v12_0_cp_resume(struct amdgpu_devic=
e *adev)
>
>         gfx_v12_0_cp_set_doorbell_range(adev);
>
> -       if (amdgpu_async_gfx_ring) {
> -               gfx_v12_0_cp_compute_enable(adev, true);
> -               gfx_v12_0_cp_gfx_enable(adev, true);
> -       }
> +       gfx_v12_0_cp_compute_enable(adev, true);
> +       gfx_v12_0_cp_gfx_enable(adev, true);
>
>         if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
>                 r =3D amdgpu_mes_kiq_hw_init(adev, 0);
> @@ -3569,15 +3462,9 @@ static int gfx_v12_0_cp_resume(struct amdgpu_devic=
e *adev)
>         if (r)
>                 return r;
>
> -       if (!amdgpu_async_gfx_ring) {
> -               r =3D gfx_v12_0_cp_gfx_resume(adev);
> -               if (r)
> -                       return r;
> -       } else {
> -               r =3D gfx_v12_0_cp_async_gfx_ring_resume(adev);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D gfx_v12_0_cp_async_gfx_ring_resume(adev);
> +       if (r)
> +               return r;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                 ring =3D &adev->gfx.gfx_ring[i];
> @@ -3893,10 +3780,8 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         if (!adev->no_hw_access) {
> -               if (amdgpu_async_gfx_ring) {
> -                       if (amdgpu_gfx_disable_kgq(adev, 0))
> -                               DRM_ERROR("KGQ disable failed\n");
> -               }
> +               if (amdgpu_gfx_disable_kgq(adev, 0))
> +                       DRM_ERROR("KGQ disable failed\n");
>
>                 if (amdgpu_gfx_disable_kcq(adev, 0))
>                         DRM_ERROR("KCQ disable failed\n");
> --
> 2.17.1
>
