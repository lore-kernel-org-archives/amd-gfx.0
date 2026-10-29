Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DED606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QYfLUXRs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179BE10E2EB;
	Thu, 29 Oct 2026 21:42:19 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4168410E2EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 21:42:13 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36a0eecf73fso26544eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793310132; cv=none;
 d=google.com; s=arc-20260327;
 b=Sm5JkmuZBuSy4Bxk4vVVvPymAY89HgDmBfp2juNndqeLJopsBQor7IxmPJSKfe/HZc
 PVk3UEBpm6YxLQ+JmXPM/70rH1AX4bPk/omGyUTM1I3YzVhieJmVap9MbZtNznVrYv8z
 poMt6qRlFJ+Nnl4P8F7MKlFXW+wbiHoqvNz1cR/hXTN7PdvEbpw9OqacLl9TT5t6Pmnv
 4E4UX5qCYtbCsIDM9ZHUbMOb3/0YhU2eSVusS+DK99Xh5FnLNJom3Ac/tlhjfj8cZVxl
 gZAm1Hzu37AzM/wsnD7oZdgj5KGDa6ylPPWKTxh+k+Bpu9HyhIUMu26wJQnl+rK5eZmi
 k38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PmmbsvA8By0O/Ei0aB60/GVCYLAgYkbG3NIV1KZA160=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=hBD7xle0dW/hfVWNAfOzgORQ4EWST8cKAXFUNEErNDF5cTLlT9abZ77ZML7AR5VURT
 BglboJrCQ/maITS22ytzRHVs4KlpjNGMcuGG4EuPD2rHBX3GxSJ9QiD4QxKVG9MJKrHk
 QtMXznGLCdOYcCPSGOpK5qlgRVUCDK1SsIZUMaxC9duLk6vsKeYHBm8hWwswkRy69F5r
 30G41TvAhI8vo5YxdmJBvm7KKIyg4Z5f03oTL6OePeyeDcw2vJUY0UscZlFuPw+vzEP9
 s4mBWR/fcUJJklq9zRRUZVWKkKTdGHsFNzTDSnVTaFZ/tMZxnqNLzSfHTsfh/ay82wWz
 Bufg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793310132; x=1793914932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PmmbsvA8By0O/Ei0aB60/GVCYLAgYkbG3NIV1KZA160=;
 b=QYfLUXRsVJokHqNRwWydsDtcAJSzMHq/Digfn8R1FeiAvnt7Y0SIYUs6hnJZ0n7zGe
 1hGAjpgEJ1caJE9JoIn+o+lAUCNtTmGb7Pl1ACA3pDpqpcIJkQ2KXHPfnZ3DfatAKchL
 RDSlKQ/tecOv95R8Eh+wZwq7aXN4ME2EDTuVUdtSRvsEEGJPD4BH+vHjuFWGmdosbhb1
 JhrAjm/xvS5SOm5KfUGCAVvKQlyrLihUQRqkvoOtAPfCBnuUWN6GjhGRpSMRs2jjJKeX
 +Ln3AZuIJ8bb5A6EI1v1pkKn50SEN+1OvlbDj72oKDsEBSHxBePYX3gxbl8dkMeqnnZa
 qy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793310132; x=1793914932;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PmmbsvA8By0O/Ei0aB60/GVCYLAgYkbG3NIV1KZA160=;
 b=lopRp2rVMpjN3LUYiwN3UJJEBqcUUKRoaGHBYR5KpMBL1csr8y1YMHbr0Ou3oSkiuG
 FRezgH7PEjWq85LuB5UVlDULyFQpjnyhTx87eSDiscLqoP4Vv2IdAua6HHkSKrIYbHyD
 hhHt8YV7/HosEmH8RwzpKLQpKxFrWo9lyLl8DzXKzh2rhgEsUZiQQ9W2XS1PtjJ/sC/e
 hHfHfMNCmKoO2lEuDk2P0e4yq4iOU5oiF0kTvV9dzyBSdOCz2kG5aFZCOp4Boc9PTgX9
 1ilcW/Z+5xp1ILqiAx9qwQ/oZXI+PixF/pGTkEYb+axarep3OFdSsU+fRN6Y3KKBGDi8
 1c0g==
X-Gm-Message-State: AFq9FYIcl8wJPwJ2VlUWC1n7ij82Oq/izrV7ueGce5tLgnURrfncU2VI
 LK4gPoEugiERHs8tZkJjCUPyT9LfI4KlRw9lwV5fWznpnrHoKzQdybj7BFD70Q6u+g4UbLLrCux
 pLPjTseGAMKAnQiU2HrhT8HKHgYfRezSyJTjb
X-Gm-Gg: AYBFou0hnfd4RJ1WUoM3eHfILG+LuqtRGfAgWiakWBu8gSui5z/Wl7VR+QAKeje54pz
 yqf1DYPV5S3DAAsC51V2bMRegpwyO0NwGjC46BU76kphxMfGWM+Pfva6A5FZnHZ0/cBzklNPykg
 0BtTrNv1Z1h64nu4Mr6s4VMt4PAfM9KBH4kKzK08o4DiuhDr3ed2gujg9xKFPzLqSRjyrykRDjO
 Xn5VowSfxQiW6o8tI7S3QAS2ukMcsMY7gtJbvIF37wwtdq0bxWvYyJbOT6KL83OrEJn5VS/1xvU
 fvcUj22FKx9yGm78u40EOJv0EzCKj87vcxPyx4k+ngzvppl5pxDRX2LypFHJmzeEE7EtKF/1lZN
 iw0ClTUnG1yHJ7oiRMaiuasCTAmZj67ycM94fpCVYvxubKNedZKnO+YGirQxmiNbDJuGaw3d67B
 8guWDKeHHztsc3/LWyvUShIQfQ
X-Received: by 2002:a05:701b:428f:10b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1ac4f91ef0emr763365c88.0.1793310132267; Thu, 29 Oct 2026
 14:42:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023140611.3095340-1-alexander.deucher@amd.com>
In-Reply-To: <20261023140611.3095340-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 17:42:00 -0400
X-Gm-Features: AclHuK91CBnFt2q8W-oJUNMCJlBkhMep-kiaslH7g0jBkKDb0CI5w-KOHS7bdHI
Message-ID: <CADnq5_PH4-EcmQRPL8sv2XQiwX3PONFV+jUFDrM2w9Cm+CA2DA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop async_gfx_ring parameter
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping?

On Fri, Oct 23, 2026 at 1:31=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> It's been enabled by default since it was added.  It's
> leftover from gfx10 bring up.  I doubt the disabled path
> still works anymore.  Remove it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   9 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |   6 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 145 +-------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 167 +-----------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |   3 -
>  6 files changed, 15 insertions(+), 316 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5a32b54b1e9b8..16c7d1381ae6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -213,7 +213,6 @@ extern u64 amdgpu_ras_mask;
>  extern int amdgpu_bad_page_threshold;
>  extern bool amdgpu_ignore_bad_page_threshold;
>  extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
> -extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
>  extern int amdgpu_discovery;
>  extern int amdgpu_mes_log_enable;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3e5634de077f1..cee7c0c772a55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -224,7 +224,6 @@ int amdgpu_smu_pptable_id =3D -1;
>  uint amdgpu_dc_feature_mask =3D DC_MULTI_MON_PP_MCLK_SWITCH_MASK | DC_FR=
L_MASK;
>  uint amdgpu_dc_debug_mask;
>  uint amdgpu_dc_visual_confirm;
> -int amdgpu_async_gfx_ring =3D 1;
>  int amdgpu_mcbp =3D -1;
>  int amdgpu_discovery =3D -1;
>  int amdgpu_mes_log_enable;
> @@ -668,14 +667,6 @@ MODULE_PARM_DESC(smu_memory_pool_size,
>         "reserve gtt for smu debug usage, 0 =3D disable,0x1 =3D 256Mbyte,=
 0x2 =3D 512Mbyte, 0x4 =3D 1 Gbyte, 0x8 =3D 2GByte");
>  module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, ui=
nt, 0444);
>
> -/**
> - * DOC: async_gfx_ring (int)
> - * It is used to enable gfx rings that could be configured with differen=
t prioritites or equal priorities
> - */
> -MODULE_PARM_DESC(async_gfx_ring,
> -       "Asynchronous GFX rings that could be configured with either diff=
erent priorities (HP3D ring and LP3D ring), or equal priorities (0 =3D disa=
bled, 1 =3D enabled (default))");
> -module_param_named(async_gfx_ring, amdgpu_async_gfx_ring, int, 0444);
> -
>  /**
>   * DOC: mcbp (int)
>   * It is used to enable mid command buffer preemption. (0 =3D disabled, =
1 =3D enabled, -1 auto (default))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0ae6e990c3102..143d55fed4617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -148,7 +148,7 @@ void amdgpu_gfx_parse_disable_cu(struct amdgpu_device=
 *adev, unsigned int *mask,
>
>  static bool amdgpu_gfx_is_graphics_multipipe_capable(struct amdgpu_devic=
e *adev)
>  {
> -       return amdgpu_async_gfx_ring && adev->gfx.me.num_pipe_per_me > 1;
> +       return adev->gfx.me.num_pipe_per_me > 1;
>  }
>
>  static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device=
 *adev)
> @@ -447,7 +447,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev=
,
>                 }
>         }
>
> -       if (adev->asic_type >=3D CHIP_NAVI10 && amdgpu_async_gfx_ring) {
> +       if (adev->gfx.me.num_queue_per_pipe > 1) {
>                 /* create MQD for each KGQ */
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                         ring =3D &adev->gfx.gfx_ring[i];
> @@ -503,7 +503,7 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *ade=
v, int xcc_id)
>         int i, j;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>
> -       if (adev->asic_type >=3D CHIP_NAVI10 && amdgpu_async_gfx_ring) {
> +       if (adev->gfx.me.num_queue_per_pipe > 1) {
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                         ring =3D &adev->gfx.gfx_ring[i];
>                         kfree(adev->gfx.me.mqd_backup[i]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 74b68b6048c89..456645d6b331f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6447,35 +6447,11 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_d=
evice *adev)
>         return 0;
>  }
>
> -static void gfx_v10_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
> -                                        CP_PIPE_ID pipe)
> -{
> -       u32 tmp;
> -
> -       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL);
> -       tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
> -
> -       WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, tmp);
> -}
> -
>  static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
>                                           struct amdgpu_ring *ring)
>  {
>         u32 tmp;
>
> -       if (!amdgpu_async_gfx_ring) {
> -               tmp =3D RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
> -               if (ring->use_doorbell) {
> -                       tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL=
,
> -                                               DOORBELL_OFFSET, ring->do=
orbell_index);
> -                       tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL=
,
> -                                               DOORBELL_EN, 1);
> -               } else {
> -                       tmp =3D REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL=
,
> -                                               DOORBELL_EN, 0);
> -               }
> -               WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
> -       }
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(10, 3, 0):
>         case IP_VERSION(10, 3, 2):
> @@ -6503,109 +6479,6 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct =
amdgpu_device *adev,
>         }
>  }
>
> -static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
> -{
> -       struct amdgpu_ring *ring;
> -       u32 tmp;
> -       u32 rb_bufsz;
> -       u64 rb_addr, rptr_addr, wptr_gpu_addr;
> -
> -       /* Set the write pointer delay */
> -       WREG32_SOC15(GC, 0, mmCP_RB_WPTR_DELAY, 0);
> -
> -       /* set the RB to use vmid 0 */
> -       WREG32_SOC15(GC, 0, mmCP_RB_VMID, 0);
> -
> -       /* Init gfx ring 0 for pipe 0 */
> -       mutex_lock(&adev->srbm_mutex);
> -       gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
> -
> -       /* Set ring buffer size */
> -       ring =3D &adev->gfx.gfx_ring[0];
> -       rb_bufsz =3D order_base_2(ring->ring_size / 8);
> -       tmp =3D REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
> -       tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
> -#ifdef __BIG_ENDIAN
> -       tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
> -#endif
> -       WREG32_SOC15(GC, 0, mmCP_RB0_CNTL, tmp);
> -
> -       /* Initialize the ring buffer's write pointers */
> -       ring->wptr =3D 0;
> -       WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
> -       WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
> -
> -       /* set the wb address whether it's enabled or not */
> -       rptr_addr =3D ring->rptr_gpu_addr;
> -       WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr))=
;
> -       WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_add=
r) &
> -                    CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
> -
> -       wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -       WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
> -                    lower_32_bits(wptr_gpu_addr));
> -       WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
> -                    upper_32_bits(wptr_gpu_addr));
> -
> -       mdelay(1);
> -       WREG32_SOC15(GC, 0, mmCP_RB0_CNTL, tmp);
> -
> -       rb_addr =3D ring->gpu_addr >> 8;
> -       WREG32_SOC15(GC, 0, mmCP_RB0_BASE, rb_addr);
> -       WREG32_SOC15(GC, 0, mmCP_RB0_BASE_HI, upper_32_bits(rb_addr));
> -
> -       WREG32_SOC15(GC, 0, mmCP_RB_ACTIVE, 1);
> -
> -       gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       /* Init gfx ring 1 for pipe 1 */
> -       if (adev->gfx.num_gfx_rings > 1) {
> -               mutex_lock(&adev->srbm_mutex);
> -               gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
> -               /* maximum supported gfx ring is 2 */
> -               ring =3D &adev->gfx.gfx_ring[1];
> -               rb_bufsz =3D order_base_2(ring->ring_size / 8);
> -               tmp =3D REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz)=
;
> -               tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufs=
z - 2);
> -               WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
> -               /* Initialize the ring buffer's write pointers */
> -               ring->wptr =3D 0;
> -               WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wp=
tr));
> -               WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring-=
>wptr));
> -               /* Set the wb address whether it's enabled or not */
> -               rptr_addr =3D ring->rptr_gpu_addr;
> -               WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rpt=
r_addr));
> -               WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(=
rptr_addr) &
> -                            CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
> -               wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -               WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
> -                            lower_32_bits(wptr_gpu_addr));
> -               WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
> -                            upper_32_bits(wptr_gpu_addr));
> -
> -               mdelay(1);
> -               WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
> -
> -               rb_addr =3D ring->gpu_addr >> 8;
> -               WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
> -               WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_ad=
dr));
> -               WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
> -
> -               gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
> -               mutex_unlock(&adev->srbm_mutex);
> -       }
> -       /* Switch to pipe 0 */
> -       mutex_lock(&adev->srbm_mutex);
> -       gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       /* start the ring */
> -       gfx_v10_0_cp_gfx_start(adev);
> -
> -       return 0;
> -}
> -
>  static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool=
 enable)
>  {
>         if (enable) {
> @@ -7268,15 +7141,9 @@ static int gfx_v10_0_cp_resume(struct amdgpu_devic=
e *adev)
>         if (r)
>                 return r;
>
> -       if (!amdgpu_async_gfx_ring) {
> -               r =3D gfx_v10_0_cp_gfx_resume(adev);
> -               if (r)
> -                       return r;
> -       } else {
> -               r =3D gfx_v10_0_cp_async_gfx_ring_resume(adev);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D gfx_v10_0_cp_async_gfx_ring_resume(adev);
> +       if (r)
> +               return r;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                 ring =3D &adev->gfx.gfx_ring[i];
> @@ -7586,10 +7453,8 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>                 gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UN=
GATE);
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index d44d21c0c332f..c9404aa3b5ad8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3731,9 +3731,6 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_dev=
ice *adev)
>                      adev->gfx.config.max_hw_contexts - 1);
>         WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
>
> -       if (!amdgpu_async_gfx_ring)
> -               gfx_v11_0_cp_gfx_enable(adev, true);
> -
>         ring =3D &adev->gfx.gfx_ring[0];
>         r =3D amdgpu_ring_alloc(ring, gfx_v11_0_get_csb_size(adev));
>         if (r) {
> @@ -3794,143 +3791,6 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_d=
evice *adev)
>         return 0;
>  }
>
> -static void gfx_v11_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
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
> -static void gfx_v11_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
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
> -static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
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
> -       gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
> -
> -       /* Set ring buffer size */
> -       ring =3D &adev->gfx.gfx_ring[0];
> -       rb_bufsz =3D order_base_2(ring->ring_size / 8);
> -       tmp =3D REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
> -       tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
> -       tmp =3D REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
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
> -       gfx_v11_0_cp_gfx_set_doorbell(adev, ring);
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       /* Init gfx ring 1 for pipe 1 */
> -       if (adev->gfx.num_gfx_rings > 1) {
> -               mutex_lock(&adev->srbm_mutex);
> -               gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
> -               /* maximum supported gfx ring is 2 */
> -               ring =3D &adev->gfx.gfx_ring[1];
> -               rb_bufsz =3D order_base_2(ring->ring_size / 8);
> -               tmp =3D REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz)=
;
> -               tmp =3D REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufs=
z - 2);
> -               WREG32_SOC15(GC, 0, regCP_RB1_CNTL, tmp);
> -               /* Initialize the ring buffer's write pointers */
> -               ring->wptr =3D 0;
> -               WREG32_SOC15(GC, 0, regCP_RB1_WPTR, lower_32_bits(ring->w=
ptr));
> -               WREG32_SOC15(GC, 0, regCP_RB1_WPTR_HI, upper_32_bits(ring=
->wptr));
> -               /* Set the wb address whether it's enabled or not */
> -               rptr_addr =3D ring->rptr_gpu_addr;
> -               WREG32_SOC15(GC, 0, regCP_RB1_RPTR_ADDR, lower_32_bits(rp=
tr_addr));
> -               WREG32_SOC15(GC, 0, regCP_RB1_RPTR_ADDR_HI, upper_32_bits=
(rptr_addr) &
> -                            CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
> -               wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -               WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
> -                            lower_32_bits(wptr_gpu_addr));
> -               WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
> -                            upper_32_bits(wptr_gpu_addr));
> -
> -               mdelay(1);
> -               WREG32_SOC15(GC, 0, regCP_RB1_CNTL, tmp);
> -
> -               rb_addr =3D ring->gpu_addr >> 8;
> -               WREG32_SOC15(GC, 0, regCP_RB1_BASE, rb_addr);
> -               WREG32_SOC15(GC, 0, regCP_RB1_BASE_HI, upper_32_bits(rb_a=
ddr));
> -               WREG32_SOC15(GC, 0, regCP_RB1_ACTIVE, 1);
> -
> -               gfx_v11_0_cp_gfx_set_doorbell(adev, ring);
> -               mutex_unlock(&adev->srbm_mutex);
> -       }
> -       /* Switch to pipe 0 */
> -       mutex_lock(&adev->srbm_mutex);
> -       gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       /* start the ring */
> -       gfx_v11_0_cp_gfx_start(adev);
> -
> -       return 0;
> -}
> -
>  static void gfx_v11_0_cp_compute_enable(struct amdgpu_device *adev, bool=
 enable)
>  {
>         u32 data;
> @@ -4722,9 +4582,6 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_devic=
e *adev)
>  {
>         int i, r;
>
> -       if (!amdgpu_async_gfx_ring)
> -               gfx_v11_0_cp_compute_enable(adev, true);
> -
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 r =3D gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i]=
);
>                 if (r)
> @@ -4758,10 +4615,8 @@ static int gfx_v11_0_cp_resume(struct amdgpu_devic=
e *adev)
>
>         gfx_v11_0_cp_set_doorbell_range(adev);
>
> -       if (amdgpu_async_gfx_ring) {
> -               gfx_v11_0_cp_compute_enable(adev, true);
> -               gfx_v11_0_cp_gfx_enable(adev, true);
> -       }
> +       gfx_v11_0_cp_compute_enable(adev, true);
> +       gfx_v11_0_cp_gfx_enable(adev, true);
>
>         if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
>                 r =3D amdgpu_mes_kiq_hw_init(adev, 0);
> @@ -4774,15 +4629,9 @@ static int gfx_v11_0_cp_resume(struct amdgpu_devic=
e *adev)
>         if (r)
>                 return r;
>
> -       if (!amdgpu_async_gfx_ring) {
> -               r =3D gfx_v11_0_cp_gfx_resume(adev);
> -               if (r)
> -                       return r;
> -       } else {
> -               r =3D gfx_v11_0_cp_async_gfx_ring_resume(adev);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D gfx_v11_0_cp_async_gfx_ring_resume(adev);
> +       if (r)
> +               return r;
>
>         if (adev->gfx.disable_kq) {
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> @@ -4792,8 +4641,7 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device=
 *adev)
>                         if (r)
>                                 return r;
>                 }
> -               if (amdgpu_async_gfx_ring)
> -                       amdgpu_gfx_disable_kgq(adev, 0);
> +               amdgpu_gfx_disable_kgq(adev, 0);
>         } else {
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                         ring =3D &adev->gfx.gfx_ring[i];
> @@ -5116,8 +4964,7 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>
>         if (!adev->no_hw_access) {
> -               if (amdgpu_async_gfx_ring &&
> -                   !adev->gfx.disable_kq) {
> +               if (!adev->gfx.disable_kq) {
>                         if (amdgpu_gfx_disable_kgq(adev, 0))
>                                 DRM_ERROR("KGQ disable failed\n");
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index e3d3ca8e7900c..6f6bf2b0bf534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2411,9 +2411,6 @@ static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_d=
evice *adev,
>         struct amdgpu_ring *ring =3D NULL;
>         int r =3D 0, i;
>
> -       if (!amdgpu_async_gfx_ring)
> -               gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
> -
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 ring =3D &adev->gfx.compute_ring[i + xcc_id * adev->gfx.n=
um_compute_rings];
>
> --
> 2.56.0
>
