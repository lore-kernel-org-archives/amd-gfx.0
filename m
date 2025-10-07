Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4702CCA476
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B0410E6C3;
	Tue,  7 Oct 2025 15:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KTO9xPef";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4B610E6C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 15:04:51 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2680ee37b21so9647365ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Oct 2025 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759849491; x=1760454291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60SuCci27CQP6QRJiDxFiJ2rf1SKlLEJ7PoLoRRM1uw=;
 b=KTO9xPefnT2kh0t/C1rXWWPEuZAMmaB3aLrds/6u0Ip7UJJQml9KpCm4ftukl0jp84
 0KF5BiqtLbm3P+m8E56nf344atCf3w1zXs1ilVyd+XnVcs3qhDGARlhNS6kNA1nk1PGM
 6HaKjWJa400WXRqPdP/To9OP0KZDRgxBqcLfSExoBbo2IQxS++TDlZYpWSZ9oCSMYniG
 S1lSVEEg0OQQ4Xeqm+JE7cCJLoTV5iO+D8NYTqG3Clj+hceVD5CZP/rlrLsIU5vHWArQ
 WXEjV1ZPriMQlMfsHSG/JFrbaeyZeUET4R/PLXnkWjRXM7KqFfbjIJj1J2YH0L6Y92Sy
 PKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759849491; x=1760454291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60SuCci27CQP6QRJiDxFiJ2rf1SKlLEJ7PoLoRRM1uw=;
 b=T2cTqOErTfmFiA1I8EGZC4EGHQmhWk0sNgvcTjFGpXNNVkiKUvyuOKCwO7QnKqEgQi
 7TVKm3piY1BvSadRwtnROKQiiO6inLEgRxzZwXOxHb/FwqVnjXF7VqensbgKB7ezvQ3o
 D8Wi29XG+P5qzl9qbF2RLACwOjL47AYSgJhij3AflCv/3AHAFflQ2bNWSts9Gm9o3uwE
 wHIU8r0BDJ1AalEWSxysJBnD2dhpz/A/tQRfXAijWOc/mJmg83hX6ZcZXa7Nx3XV2i7L
 iHDnDHVrOu6raHY4zm/YCFnr0EnfXgZfN84PiTmtXJnjXmIGvVMRIWaVoGoyWdRI2Nv5
 TVcA==
X-Gm-Message-State: AOJu0YwkcfOVce+d+Eot9rb97GaWfjgJDO8LRHx5isySMj3n9J6Hyjss
 8uxdl9SDzyMNUQ4N3n0PgHFG4dQkyEHkHQqwHDQ3y8SpcsYGmtg/mX/4q7rao9Gw0UpaEag7tgv
 cgy41WslTgtyy7q282iY3C4jrdA4hal8=
X-Gm-Gg: ASbGncu9YFqTrS7EcKY+BrHdTBMzpnARbFNDNG0pEJW76G828rPeBB7wxKSAG94wPz3
 IJ/ZmsaLTZcn7bc52SurTdWZgxPncDOY/2hx4xsrMmQeLPvt6rT3hNwP34bOanbNHCsLewT8Yp8
 lH40PHiJgJSE8TlzZoyLZfpc7lgl/mN0KQ3o1uG5e73r9+OvNCHN0Y2xmkCzeR1QUbOCd+dQ4ft
 slWqa6znZAZEsxbLduRO/iQW46qEIA=
X-Google-Smtp-Source: AGHT+IE2S7ofj6mVczrHhZxguCUtSPXESMrf8RIOh8L5sfS01zblwNfuePsIiXdtbntU/F9kaMwLFnG3cvhSi1oQw8E=
X-Received: by 2002:a17:902:c410:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-290272e1cbfmr618275ad.7.1759849490233; Tue, 07 Oct 2025
 08:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251004063045.3901777-1-Victor.Zhao@amd.com>
In-Reply-To: <20251004063045.3901777-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Oct 2025 11:04:38 -0400
X-Gm-Features: AS18NWBz8pMnMEA872aTlt9K-AIoiFW26-ZfClxhfoMxJZ-_sDi8Bdx-FAaDOS8
Message-ID: <CADnq5_PvT1ANK2n4oTbYwYM5MivftSKx18Rjo_iSBz6bPsrjQg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: use GPU_HDP_FLUSH for sriov
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, HaiJun.Chang@amd.com, Lijo.Lazar@amd.com
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

On Sat, Oct 4, 2025 at 2:46=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> wr=
ote:
>
> Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for
> hdp flush. This register need to be write from CPU for nbif to aware,
> otherwise it will not work.
> Add kiq ring callback to emit GPU_HDP_FLUSH, in amdgpu_device_flush_hdp
> if no ring provided.
>
> v2: remove changes to flush_hdp callback
> v3: add mes fix

I think this should be two patches, one to add the hdp flush callbacks
for KIQ for the gfx IPs, and another to implement the KIQ support for
the no ring case.

Alex

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 73 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  5 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  1 +
>  9 files changed, 84 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a77000c2e0bb..57d3ea33dec2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -7269,6 +7269,8 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *=
adev,
>
>         if (ring && ring->funcs->emit_hdp_flush)
>                 amdgpu_ring_emit_hdp_flush(ring);
> +       else if (!ring && amdgpu_sriov_runtime(adev))
> +               amdgpu_kiq_hdp_flush(adev, 0);
>         else
>                 amdgpu_asic_flush_hdp(adev, ring);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 7f02e36ccc1e..ecd7908590de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1194,6 +1194,78 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, u=
int32_t reg, uint32_t v, uint3
>         dev_err(adev->dev, "failed to write reg:%x\n", reg);
>  }
>
> +void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id)
> +{
> +       signed long r, cnt =3D 0;
> +       unsigned long flags;
> +       uint32_t seq;
> +       uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mas=
k;
> +       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
> +       struct amdgpu_ring *ring =3D &kiq->ring;
> +
> +       BUG_ON(!ring->funcs->emit_hdp_flush);
> +
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
> +       if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready) {
> +               hdp_flush_req_offset =3D adev->nbio.funcs->get_hdp_flush_=
req_offset(adev);
> +               hdp_flush_done_offset =3D adev->nbio.funcs->get_hdp_flush=
_done_offset(adev);
> +               ref_and_mask =3D adev->nbio.hdp_flush_reg->ref_and_mask_c=
p0; /* Use CP0 for KIQ */
> +
> +               amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset,=
 hdp_flush_done_offset,
> +                                             ref_and_mask, ref_and_mask)=
;
> +               return;
> +       }
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +       r =3D amdgpu_ring_alloc(ring, 32);
> +       if (r)
> +               goto failed_unlock;
> +
> +       amdgpu_ring_emit_hdp_flush(ring);
> +       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +       if (r)
> +               goto failed_undo;
> +
> +       amdgpu_ring_commit(ring);
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +       /* don't wait anymore for gpu reset case because this way may
> +        * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> +        * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> +        * never return if we keep waiting in virt_kiq_rreg, which cause
> +        * gpu_recover() hang there.
> +        *
> +        * also don't wait anymore for IRQ context
> +        * */
> +       if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
> +               goto failed_kiq_hdp_flush;
> +
> +       might_sleep();
> +       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +               if (amdgpu_in_reset(adev))
> +                       goto failed_kiq_hdp_flush;
> +
> +               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WA=
IT);
> +       }
> +
> +       if (cnt > MAX_KIQ_REG_TRY)
> +               goto failed_kiq_hdp_flush;
> +
> +       return;
> +
> +failed_undo:
> +       amdgpu_ring_undo(ring);
> +failed_unlock:
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +failed_kiq_hdp_flush:
> +       dev_err(adev->dev, "failed to flush HDP via KIQ\n");
> +}
> +
>  int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>  {
>         if (amdgpu_num_kcq =3D=3D -1) {
> @@ -2484,3 +2556,4 @@ void amdgpu_debugfs_compute_sched_mask_init(struct =
amdgpu_device *adev)
>                             &amdgpu_debugfs_compute_sched_mask_fops);
>  #endif
>  }
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index fb5f7a0ee029..5bccd2cc9518 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device =
*adev,
>                                   struct amdgpu_iv_entry *entry);
>  uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint3=
2_t xcc_id);
>  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t =
v, uint32_t xcc_id);
> +void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id);
>  int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>  void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t u=
code_id);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 8841d7213de4..751732f3e883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> +       .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 66c47c466532..10d2219866f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdg=
pu_device *adev)
>                         if (version_minor =3D=3D 3)
>                                 gfx_v11_0_load_rlcp_rlcv_microcode(adev);
>                 }
> -
> +
>                 return 0;
>         }
>
> @@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(stru=
ct amdgpu_device *adev)
>         }
>
>         memcpy(fw, fw_data, fw_size);
> -
> +
>         amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
>         amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
>
> @@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v11_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v11_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v11_0_ring_emit_reg_write_reg_wa=
it,
> +       .emit_hdp_flush =3D gfx_v11_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 710ec9c34e43..e2bb8668150d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v12_0_ring_emit_reg_write_reg_wa=
it,
> +       .emit_hdp_flush =3D gfx_v12_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 0856ff65288c..d3d0a4b0380c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring=
_funcs_kiq =3D {
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_rreg =3D gfx_v8_0_ring_emit_rreg,
>         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
> +       .emit_hdp_flush =3D gfx_v8_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index dd19a97436db..f1a2efc2a8d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> +       .emit_hdp_flush =3D gfx_v9_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 77f9d5b9a556..b1fa4036befb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4798,6 +4798,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ri=
ng_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v9_4_3_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_4_3_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_4_3_ring_emit_reg_write_reg_w=
ait,
> +       .emit_hdp_flush =3D gfx_v9_4_3_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
