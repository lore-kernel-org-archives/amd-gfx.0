Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96715C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEB0206BE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 18:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsU2tMbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEB0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333516E174;
	Mon, 24 Aug 2020 18:17:49 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B8B6E174
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 18:17:48 +0000 (UTC)
Received: by mail-pj1-x1042.google.com with SMTP id i13so4131383pjv.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rRSbg0MKuDJu/5qpy7QhnRdmQm1eFpv+o30Uw1ezwgU=;
 b=QsU2tMbrQaBiZB964Tmm5XzaI5m56PxAFTpnGYWRfpCP9gGOVJ0N3Q0boL6P73ykKf
 qmOMUabtEaazS2k1wyoAJjkxadZRYD3Pt0CooXfZE1aSoknpVRtps4BvnRE5GNs/jXAR
 P9xBHcOkTrDmbBncxdEZocfHRSt3wnmbu5CnlZY63WMDwhSqDGi3Z4AzgFiOPOzihtyc
 SipNpm5AZN5VNV32G5Cy0xPJHKwVVZdvbCCOq4F6r7TfDKxaIfrna0p/gFXQTfTvi2c+
 KgoFZ39YliJZJyi8uh/inUwLQ3sB9u+Y8QH33P5yqFzyKlXkg+dF8XgaHIv1huXog330
 dEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rRSbg0MKuDJu/5qpy7QhnRdmQm1eFpv+o30Uw1ezwgU=;
 b=mu88ZF1mc+QH8uOteYhDv7igL2Ac1qt9I9Im8lucFeCA76zwPnOAVnfALsgU0wUAk9
 B/D6VFRHdu1KU3vXqjFoXX+UsJjVi2sZkfqg3SOCBT+vHZE6fgWGWcrPlJE1cS6pK1DF
 AeYVrkikP1Cm/ARbci/kLzNLq7fOmC8OZya3ak+Z56VGubEi3soZku83wE8YicPmRGaH
 hHaAg2H1e/NukSDce9nRKeC0crsXCfoyqUXDDqv4Ou0Z0QeeNTAG+yZI0UuQIbNPtqNB
 8LM0Eokl2H7Q7v6ljKnsFrB+tXtOSO+t3gkpUQCJOmA5NNuj648NCfDJKyb2pGdWYlwz
 Y/Bg==
X-Gm-Message-State: AOAM5308kLOdfh9DbAykbkEqH8tjTuI5+OpBccjVCMys6JlBsIXtWzMv
 qykeCXwh6wO+1uqvbds+ThDYbmTlgOsTAdYhsR0=
X-Google-Smtp-Source: ABdhPJxy9R6aihlxIl8cHs2nsNLxcuHsmF21EnRdVbxNE+fdn7tLbnae7fiVAxXjOB+zTtHr7SWgOfIg7d6oGWhQFpE=
X-Received: by 2002:a17:90a:cb92:: with SMTP id
 a18mr414585pju.80.1598293068096; 
 Mon, 24 Aug 2020 11:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824114916.11808-1-samuel.pitoiset@gmail.com>
In-Reply-To: <20200824114916.11808-1-samuel.pitoiset@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 24 Aug 2020 14:17:11 -0400
Message-ID: <CAAxE2A4wbg2MYZvpBomm1=r5Ety4An2Yn=pUf7KbRu+XjZ-MkQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/amdgpu: add support for user trap handlers
To: Samuel Pitoiset <samuel.pitoiset@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1611303581=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1611303581==
Content-Type: multipart/alternative; boundary="00000000000092288105ada39a81"

--00000000000092288105ada39a81
Content-Type: text/plain; charset="UTF-8"

SET_SH_REG won't work with CP register shadowing. You need to use
WRITE_DATA or WREG32.

Marek

On Mon, Aug 24, 2020 at 7:57 AM Samuel Pitoiset <samuel.pitoiset@gmail.com>
wrote:

> A trap handler can be used by userspace to catch shader exceptions
> like divide by zero, memory violations etc.
>
> On GFX6-GFX8, the registers used to configure TBA/TMA aren't
> privileged while on GFX9+ they are per VMID and privileged,
> so that only the KMD can configure them.
>
> This introduces a new CS chunk that can be used to set the
> TBA/TMA virtual address at submit time.
>
> TODO:
> - add GFX 6,7 and 10 support
> - rebase on top of amd-staging-drm-next (this branch currently
> hangs my GPU at boot)
>
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 31 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 15 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 42 ++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 19 +++++++++++
>  include/uapi/drm/amdgpu_drm.h            |  8 +++++
>  9 files changed, 126 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index a512ccbc4dea..6ca5c4912e3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -104,6 +104,19 @@ static int amdgpu_cs_bo_handles_chunk(struct
> amdgpu_cs_parser *p,
>         return r;
>  }
>
> +static int amdgpu_cs_user_trap_chunk(struct amdgpu_cs_parser *p,
> +                                    struct drm_amdgpu_cs_chunk_trap *data,
> +                                    uint64_t *tba_addr, uint64_t
> *tma_addr)
> +{
> +       if (!data->tba_addr || !data->tma_addr)
> +               return -EINVAL;
> +
> +       *tba_addr = data->tba_addr;
> +       *tma_addr = data->tma_addr;
> +
> +       return 0;
> +}
> +
>  static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union
> drm_amdgpu_cs *cs)
>  {
>         struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> @@ -112,6 +125,7 @@ static int amdgpu_cs_parser_init(struct
> amdgpu_cs_parser *p, union drm_amdgpu_cs
>         uint64_t *chunk_array;
>         unsigned size, num_ibs = 0;
>         uint32_t uf_offset = 0;
> +       uint64_t tba_addr = 0, tma_addr = 0;
>         int i;
>         int ret;
>
> @@ -214,6 +228,19 @@ static int amdgpu_cs_parser_init(struct
> amdgpu_cs_parser *p, union drm_amdgpu_cs
>
>                         break;
>
> +               case AMDGPU_CHUNK_ID_TRAP:
> +                       size = sizeof(struct drm_amdgpu_cs_chunk_trap);
> +                       if (p->chunks[i].length_dw * sizeof(uint32_t) <
> size) {
> +                               ret = -EINVAL;
> +                               goto free_partial_kdata;
> +                       }
> +
> +                       ret = amdgpu_cs_user_trap_chunk(p,
> p->chunks[i].kdata,
> +                                                       &tba_addr,
> &tma_addr);
> +                       if (ret)
> +                               goto free_partial_kdata;
> +                       break;
> +
>                 case AMDGPU_CHUNK_ID_DEPENDENCIES:
>                 case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
>                 case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
> @@ -239,6 +266,10 @@ static int amdgpu_cs_parser_init(struct
> amdgpu_cs_parser *p, union drm_amdgpu_cs
>
>         if (p->uf_entry.tv.bo)
>                 p->job->uf_addr = uf_offset;
> +
> +       p->job->tba_addr = tba_addr;
> +       p->job->tma_addr = tma_addr;
> +
>         kfree(chunk_array);
>
>         /* Use this opportunity to fill in task info for the vm */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 26127c7d2f32..1e703119e4c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -88,9 +88,10 @@
>   * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
>   * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
>   * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
> + * - 3.40.0 - Add AMDGPU_CHUNK_ID_TRAP
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       39
> +#define KMS_DRIVER_MINOR       40
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 8e58325bbca2..fd0d56724b4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -58,6 +58,10 @@ struct amdgpu_vmid {
>         uint32_t                oa_base;
>         uint32_t                oa_size;
>
> +       /* user trap */
> +       uint64_t                tba_addr;
> +       uint64_t                tma_addr;
> +
>         unsigned                pasid;
>         struct dma_fence        *pasid_mapping;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 81caac9b958a..b8ed5b13ea44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -62,6 +62,10 @@ struct amdgpu_job {
>         /* user fence handling */
>         uint64_t                uf_addr;
>         uint64_t                uf_sequence;
> +
> +       /* user trap handling */
> +       uint64_t                tba_addr;
> +       uint64_t                tma_addr;
>  };
>
>  int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index da871d84b742..1f165a6295d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -197,6 +197,9 @@ struct amdgpu_ring_funcs {
>         void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>         int (*preempt_ib)(struct amdgpu_ring *ring);
>         void (*emit_mem_sync)(struct amdgpu_ring *ring);
> +       void (*emit_trap_handler)(struct amdgpu_ring *ring,
> +                                 uint32_t vmid,
> +                                 uint64_t tba_addr, uint64_t tma_addr);
>  };
>
>  struct amdgpu_ring {
> @@ -265,6 +268,7 @@ struct amdgpu_ring {
>  #define amdgpu_ring_emit_vm_flush(r, vmid, addr)
> (r)->funcs->emit_vm_flush((r), (vmid), (addr))
>  #define amdgpu_ring_emit_fence(r, addr, seq, flags)
> (r)->funcs->emit_fence((r), (addr), (seq), (flags))
>  #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as)
> (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
> +#define amdgpu_ring_emit_trap_handler(r, v, tba, tma)
> (r)->funcs->emit_trap_handler((r), (v), (tba), (tma))
>  #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>  #define amdgpu_ring_emit_switch_buffer(r)
> (r)->funcs->emit_switch_buffer((r))
>  #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r),
> (d))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 71e005cf2952..24916082de0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1076,6 +1076,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct
> amdgpu_job *job,
>                 id->gws_size != job->gws_size ||
>                 id->oa_base != job->oa_base ||
>                 id->oa_size != job->oa_size);
> +       bool trap_handler_needed = ring->funcs->emit_trap_handler && (
> +               id->tba_addr != job->tba_addr ||
> +               id->tma_addr != job->tma_addr);
>         bool vm_flush_needed = job->vm_needs_flush;
>         struct dma_fence *fence = NULL;
>         bool pasid_mapping_needed = false;
> @@ -1088,6 +1091,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct
> amdgpu_job *job,
>
>         if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>                 gds_switch_needed = true;
> +               trap_handler_needed = true;
>                 vm_flush_needed = true;
>                 pasid_mapping_needed = true;
>         }
> @@ -1099,12 +1103,14 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
> struct amdgpu_job *job,
>         mutex_unlock(&id_mgr->lock);
>
>         gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> +       trap_handler_needed &= !!ring->funcs->emit_trap_handler;
>         vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>                         job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>         pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>                 ring->funcs->emit_wreg;
>
> -       if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
> +       if (!vm_flush_needed && !gds_switch_needed &&
> +           !trap_handler_needed && !need_pipe_sync)
>                 return 0;
>
>         if (ring->funcs->init_cond_exec)
> @@ -1158,6 +1164,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
> struct amdgpu_job *job,
>                                             job->oa_size);
>         }
>
> +       if (ring->funcs->emit_trap_handler && trap_handler_needed) {
> +               id->tba_addr = job->tba_addr;
> +               id->tma_addr = job->tma_addr;
> +               amdgpu_ring_emit_trap_handler(ring, job->vmid,
> job->tba_addr,
> +                                             job->tma_addr);
> +       }
> +
>         if (ring->funcs->patch_cond_exec)
>                 amdgpu_ring_patch_cond_exec(ring, patch_offset);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 33f1c4a46ebe..59db577e8c8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5222,6 +5222,40 @@ static void gfx_v8_0_ring_emit_gds_switch(struct
> amdgpu_ring *ring,
>         amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 <<
> oa_base));
>  }
>
> +static void gfx_v8_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
> +                                           uint32_t vmid,
> +                                           uint64_t tba_addr,
> +                                           uint64_t tma_addr)
> +{
> +       if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
> +               static const u32 regs[] = {
> +                       mmSPI_SHADER_TBA_LO_PS,
> +                       mmSPI_SHADER_TBA_LO_VS,
> +                       mmSPI_SHADER_TBA_LO_GS,
> +                       mmSPI_SHADER_TBA_LO_ES,
> +                       mmSPI_SHADER_TBA_LO_HS,
> +                       mmSPI_SHADER_TBA_LO_LS,
> +               };
> +               int i;
> +
> +               for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +                       amdgpu_ring_write(ring,
> PACKET3(PACKET3_SET_SH_REG, 4));
> +                       amdgpu_ring_write(ring, regs[i] -
> PACKET3_SET_SH_REG_START);
> +                       amdgpu_ring_write(ring, lower_32_bits(tba_addr >>
> 8));
> +                       amdgpu_ring_write(ring, upper_32_bits(tba_addr >>
> 8));
> +                       amdgpu_ring_write(ring, lower_32_bits(tma_addr >>
> 8));
> +                       amdgpu_ring_write(ring, upper_32_bits(tma_addr >>
> 8));
> +               }
> +       } else {
> +               amdgpu_ring_write(ring, PACKET3(PACKET3_SET_SH_REG, 4));
> +               amdgpu_ring_write(ring, mmCOMPUTE_TBA_LO -
> PACKET3_SET_SH_REG_START);
> +               amdgpu_ring_write(ring, lower_32_bits(tba_addr >> 8));
> +               amdgpu_ring_write(ring, upper_32_bits(tba_addr >> 8));
> +               amdgpu_ring_write(ring, lower_32_bits(tma_addr >> 8));
> +               amdgpu_ring_write(ring, upper_32_bits(tma_addr >> 8));
> +       }
> +}
> +
>  static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd,
> uint32_t wave, uint32_t address)
>  {
>         WREG32(mmSQ_IND_INDEX,
> @@ -6890,7 +6924,8 @@ static const struct amdgpu_ring_funcs
> gfx_v8_0_ring_funcs_gfx = {
>                 5 + /* HDP_INVL */
>                 12 + 12 + /* FENCE x2 */
>                 2 + /* SWITCH_BUFFER */
> -               5, /* SURFACE_SYNC */
> +               5 + /* SURFACE_SYNC */
> +               36, /* gfx_v8_0_ring_emit_trap_handler */
>         .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_gfx */
>         .emit_ib = gfx_v8_0_ring_emit_ib_gfx,
>         .emit_fence = gfx_v8_0_ring_emit_fence_gfx,
> @@ -6909,6 +6944,7 @@ static const struct amdgpu_ring_funcs
> gfx_v8_0_ring_funcs_gfx = {
>         .emit_wreg = gfx_v8_0_ring_emit_wreg,
>         .soft_recovery = gfx_v8_0_ring_soft_recovery,
>         .emit_mem_sync = gfx_v8_0_emit_mem_sync,
> +       .emit_trap_handler = gfx_v8_0_ring_emit_trap_handler,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
> @@ -6926,7 +6962,8 @@ static const struct amdgpu_ring_funcs
> gfx_v8_0_ring_funcs_compute = {
>                 7 + /* gfx_v8_0_ring_emit_pipeline_sync */
>                 VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
> gfx_v8_0_ring_emit_vm_flush */
>                 7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for
> user fence, vm fence */
> -               7, /* gfx_v8_0_emit_mem_sync_compute */
> +               7 + /* gfx_v8_0_emit_mem_sync_compute */
> +               6, /* gfx_v8_0_emit_trap_handler */
>         .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
>         .emit_ib = gfx_v8_0_ring_emit_ib_compute,
>         .emit_fence = gfx_v8_0_ring_emit_fence_compute,
> @@ -6940,6 +6977,7 @@ static const struct amdgpu_ring_funcs
> gfx_v8_0_ring_funcs_compute = {
>         .pad_ib = amdgpu_ring_generic_pad_ib,
>         .emit_wreg = gfx_v8_0_ring_emit_wreg,
>         .emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
> +       .emit_trap_handler = gfx_v8_0_ring_emit_trap_handler,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index cb9d60a4e05e..4fc00f196085 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4162,6 +4162,23 @@ static void gfx_v9_0_ring_emit_gds_switch(struct
> amdgpu_ring *ring,
>                                    (1 << (oa_size + oa_base)) - (1 <<
> oa_base));
>  }
>
> +static void gfx_v9_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
> +                                           uint32_t vmid,
> +                                           uint64_t tba_addr,
> +                                           uint64_t tma_addr)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +
> +       mutex_lock(&adev->srbm_mutex);
> +       soc15_grbm_select(adev, 0, 0, 0, vmid);
> +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO, lower_32_bits(tba_addr
> >> 8));
> +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI, upper_32_bits(tba_addr
> >> 8));
> +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO, lower_32_bits(tma_addr
> >> 8));
> +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI, upper_32_bits(tma_addr
> >> 8));
> +       soc15_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static const u32 vgpr_init_compute_shader[] =
>  {
>         0xb07c0000, 0xbe8000ff,
> @@ -6720,6 +6737,7 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_gfx = {
>         .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>         .soft_recovery = gfx_v9_0_ring_soft_recovery,
>         .emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +       .emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
> @@ -6756,6 +6774,7 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_compute = {
>         .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
>         .emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +       .emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 3218576e109d..7eae264adb5d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -551,6 +551,7 @@ struct drm_amdgpu_gem_va {
>  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
> +#define AMDGPU_CHUNK_ID_TRAP            0x0a
>
>  struct drm_amdgpu_cs_chunk {
>         __u32           chunk_id;
> @@ -645,6 +646,13 @@ struct drm_amdgpu_cs_chunk_syncobj {
>         __u64 point;
>  };
>
> +struct drm_amdgpu_cs_chunk_trap {
> +       /** Trap Base Address */
> +       __u64 tba_addr;
> +       /** Trap Memory Address */
> +       __u64 tma_addr;
> +};
> +
>  #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ     0
>  #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD  1
>  #define AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD        2
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000092288105ada39a81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>SET_SH_REG won&#39;t work with CP register shadowing.=
 You need to use WRITE_DATA or WREG32.</div><div><br></div><div>Marek<br></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, Aug 24, 2020 at 7:57 AM Samuel Pitoiset &lt;<a href=3D"mailto:s=
amuel.pitoiset@gmail.com">samuel.pitoiset@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">A trap handler can be us=
ed by userspace to catch shader exceptions<br>
like divide by zero, memory violations etc.<br>
<br>
On GFX6-GFX8, the registers used to configure TBA/TMA aren&#39;t<br>
privileged while on GFX9+ they are per VMID and privileged,<br>
so that only the KMD can configure them.<br>
<br>
This introduces a new CS chunk that can be used to set the<br>
TBA/TMA virtual address at submit time.<br>
<br>
TODO:<br>
- add GFX 6,7 and 10 support<br>
- rebase on top of amd-staging-drm-next (this branch currently<br>
hangs my GPU at boot)<br>
<br>
Signed-off-by: Samuel Pitoiset &lt;<a href=3D"mailto:samuel.pitoiset@gmail.=
com" target=3D"_blank">samuel.pitoiset@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=A0| 31 +++++++++++++=
++++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0 |=C2=A0 3 +-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h=C2=A0 |=C2=A0 4 +++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.h=C2=A0 |=C2=A0 4 +++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 4 +++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=C2=A0 =C2=A0| 15 ++++++++-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c=C2=A0 =C2=A0 | 42 +++++++++++++=
+++++++++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 =C2=A0 | 19 +++++++++++<b=
r>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 8 +++++<br>
=C2=A09 files changed, 126 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index a512ccbc4dea..6ca5c4912e3a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -104,6 +104,19 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs=
_parser *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0}<br>
<br>
+static int amdgpu_cs_user_trap_chunk(struct amdgpu_cs_parser *p,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_cs_c=
hunk_trap *data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *tba_addr, ui=
nt64_t *tma_addr)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data-&gt;tba_addr || !data-&gt;tma_addr)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*tba_addr =3D data-&gt;tba_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*tma_addr =3D data-&gt;tma_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union dr=
m_amdgpu_cs *cs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_fpriv *fpriv =3D p-&gt;filp-&gt;d=
river_priv;<br>
@@ -112,6 +125,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parse=
r *p, union drm_amdgpu_cs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *chunk_array;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size, num_ibs =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t uf_offset =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t tba_addr =3D 0, tma_addr =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
@@ -214,6 +228,19 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_pars=
er *p, union drm_amdgpu_cs<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_CHUNK_I=
D_TRAP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size =3D sizeof(struct drm_amdgpu_cs_chunk_trap);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (p-&gt;chunks[i].length_dw * sizeof(uint32_t) &lt; size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_partial_kdata;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D amdgpu_cs_user_trap_chunk(p, p-&gt;chunks[i].kdata,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;tba_addr, &amp;tma_add=
r);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_partial_kdata;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_CHUNK_I=
D_DEPENDENCIES:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_CHUNK_I=
D_SYNCOBJ_IN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_CHUNK_I=
D_SYNCOBJ_OUT:<br>
@@ -239,6 +266,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_pars=
er *p, union drm_amdgpu_cs<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p-&gt;<a href=3D"http://uf_entry.tv.bo" rel=
=3D"noreferrer" target=3D"_blank">uf_entry.tv.bo</a>)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;job-&gt;uf_ad=
dr =3D uf_offset;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;job-&gt;tba_addr =3D tba_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;job-&gt;tma_addr =3D tma_addr;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(chunk_array);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Use this opportunity to fill in task info fo=
r the vm */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 26127c7d2f32..1e703119e4c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -88,9 +88,10 @@<br>
=C2=A0 * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctne=
ss<br>
=C2=A0 * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC<br>
=C2=A0 * - 3.39.0 - DMABUF implicit sync does a full pipeline sync<br>
+ * - 3.40.0 - Add AMDGPU_CHUNK_ID_TRAP<br>
=C2=A0 */<br>
=C2=A0#define KMS_DRIVER_MAJOR=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A039<br>
+#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A040<br>
=C2=A0#define KMS_DRIVER_PATCHLEVEL=C2=A0 0<br>
<br>
=C2=A0int amdgpu_vram_limit =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ids.h<br>
index 8e58325bbca2..fd0d56724b4d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
@@ -58,6 +58,10 @@ struct amdgpu_vmid {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 oa_base;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 oa_size;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* user trap */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tba_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tma_addr;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pasid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pa=
sid_mapping;<br>
=C2=A0};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h<br>
index 81caac9b958a..b8ed5b13ea44 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
@@ -62,6 +62,10 @@ struct amdgpu_job {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* user fence handling */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uf_addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uf_sequence;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* user trap handling */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tba_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tma_addr;<br>
=C2=A0};<br>
<br>
=C2=A0int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index da871d84b742..1f165a6295d9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -197,6 +197,9 @@ struct amdgpu_ring_funcs {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*soft_recovery)(struct amdgpu_ring *ring,=
 unsigned vmid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*preempt_ib)(struct amdgpu_ring *ring);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*emit_mem_sync)(struct amdgpu_ring *ring)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*emit_trap_handler)(struct amdgpu_ring *r=
ing,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vmid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t tba_addr, uint64_t tm=
a_addr);<br>
=C2=A0};<br>
<br>
=C2=A0struct amdgpu_ring {<br>
@@ -265,6 +268,7 @@ struct amdgpu_ring {<br>
=C2=A0#define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)-&gt;funcs-&gt;em=
it_vm_flush((r), (vmid), (addr))<br>
=C2=A0#define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)-&gt;funcs-&gt=
;emit_fence((r), (addr), (seq), (flags))<br>
=C2=A0#define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)=
-&gt;funcs-&gt;emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as)=
)<br>
+#define amdgpu_ring_emit_trap_handler(r, v, tba, tma) (r)-&gt;funcs-&gt;em=
it_trap_handler((r), (v), (tba), (tma))<br>
=C2=A0#define amdgpu_ring_emit_hdp_flush(r) (r)-&gt;funcs-&gt;emit_hdp_flus=
h((r))<br>
=C2=A0#define amdgpu_ring_emit_switch_buffer(r) (r)-&gt;funcs-&gt;emit_swit=
ch_buffer((r))<br>
=C2=A0#define amdgpu_ring_emit_cntxcntl(r, d) (r)-&gt;funcs-&gt;emit_cntxcn=
tl((r), (d))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index 71e005cf2952..24916082de0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -1076,6 +1076,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;gws_size !=
=3D job-&gt;gws_size ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;oa_base !=3D=
 job-&gt;oa_base ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;oa_size !=3D=
 job-&gt;oa_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool trap_handler_needed =3D ring-&gt;funcs-&gt=
;emit_trap_handler &amp;&amp; (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id-&gt;tba_addr !=
=3D job-&gt;tba_addr ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id-&gt;tma_addr !=
=3D job-&gt;tma_addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool vm_flush_needed =3D job-&gt;vm_needs_flush=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dma_fence *fence =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool pasid_mapping_needed =3D false;<br>
@@ -1088,6 +1091,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_vmid_had_gpu_reset(adev, id)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gds_switch_needed =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trap_handler_needed=
 =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_flush_needed =3D=
 true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pasid_mapping_neede=
d =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -1099,12 +1103,14 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;id_mgr-&gt;lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gds_switch_needed &amp;=3D !!ring-&gt;funcs-&gt=
;emit_gds_switch;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trap_handler_needed &amp;=3D !!ring-&gt;funcs-&=
gt;emit_trap_handler;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_flush_needed &amp;=3D !!ring-&gt;funcs-&gt;e=
mit_vm_flush=C2=A0 &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 job-&gt;vm_pd_addr !=3D AMDGPU_BO_INVALID_OFFSET;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pasid_mapping_needed &amp;=3D adev-&gt;gmc.gmc_=
funcs-&gt;emit_pasid_mapping &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;funcs-&gt;=
emit_wreg;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vm_flush_needed &amp;&amp; !gds_switch_nee=
ded &amp;&amp; !need_pipe_sync)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vm_flush_needed &amp;&amp; !gds_switch_nee=
ded &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!trap_handler_needed &amp;&amp; !=
need_pipe_sync)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ring-&gt;funcs-&gt;init_cond_exec)<br>
@@ -1158,6 +1164,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 job-&gt;oa_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ring-&gt;funcs-&gt;emit_trap_handler &amp;&=
amp; trap_handler_needed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id-&gt;tba_addr =3D=
 job-&gt;tba_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id-&gt;tma_addr =3D=
 job-&gt;tma_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_emit_tr=
ap_handler(ring, job-&gt;vmid, job-&gt;tba_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0job-&gt;tma_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ring-&gt;funcs-&gt;patch_cond_exec)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_patch_c=
ond_exec(ring, patch_offset);<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 33f1c4a46ebe..59db577e8c8f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -5222,6 +5222,40 @@ static void gfx_v8_0_ring_emit_gds_switch(struct amd=
gpu_ring *ring,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ring_write(ring, (1 &lt;&lt; (oa_size + =
oa_base)) - (1 &lt;&lt; oa_base));<br>
=C2=A0}<br>
<br>
+static void gfx_v8_0_ring_emit_trap_handler(struct amdgpu_ring *ring,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t vmid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint64_t tba_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint64_t tma_addr)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_=
TYPE_GFX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static const u32 re=
gs[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mmSPI_SHADER_TBA_LO_PS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mmSPI_SHADER_TBA_LO_VS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mmSPI_SHADER_TBA_LO_GS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mmSPI_SHADER_TBA_LO_ES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mmSPI_SHADER_TBA_LO_HS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mmSPI_SHADER_TBA_LO_LS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt=
; ARRAY_SIZE(regs); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_ring_write(ring, PACKET3(PACKET3_SET_SH_REG, 4));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_ring_write(ring, regs[i] - PACKET3_SET_SH_REG_START);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_ring_write(ring, lower_32_bits(tba_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_ring_write(ring, upper_32_bits(tba_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_ring_write(ring, lower_32_bits(tma_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_ring_write(ring, upper_32_bits(tma_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(r=
ing, PACKET3(PACKET3_SET_SH_REG, 4));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(r=
ing, mmCOMPUTE_TBA_LO - PACKET3_SET_SH_REG_START);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(r=
ing, lower_32_bits(tba_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(r=
ing, upper_32_bits(tba_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(r=
ing, lower_32_bits(tma_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_ring_write(r=
ing, upper_32_bits(tma_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t si=
md, uint32_t wave, uint32_t address)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32(mmSQ_IND_INDEX,<br>
@@ -6890,7 +6924,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_f=
uncs_gfx =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5 + /* HDP_INVL */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12 + 12 + /* FENCE =
x2 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 + /* SWITCH_BUFFE=
R */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05, /* SURFACE_SYNC =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05 + /* SURFACE_SYNC=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A036, /* gfx_v8_0_rin=
g_emit_trap_handler */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_ib_size =3D 4, /* gfx_v8_0_ring_emit_ib_g=
fx */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_ib =3D gfx_v8_0_ring_emit_ib_gfx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_fence =3D gfx_v8_0_ring_emit_fence_gfx,<b=
r>
@@ -6909,6 +6944,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_f=
uncs_gfx =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_wreg =3D gfx_v8_0_ring_emit_wreg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .soft_recovery =3D gfx_v8_0_ring_soft_recovery,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_mem_sync =3D gfx_v8_0_emit_mem_sync,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_trap_handler =3D gfx_v8_0_ring_emit_trap_=
handler,<br>
=C2=A0};<br>
<br>
=C2=A0static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute =3D=
 {<br>
@@ -6926,7 +6962,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_f=
uncs_compute =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7 + /* gfx_v8_0_rin=
g_emit_pipeline_sync */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VI_FLUSH_GPU_TLB_NU=
M_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7 + 7 + 7 + /* gfx_=
v8_0_ring_emit_fence_compute x3 for user fence, vm fence */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07, /* gfx_v8_0_emit=
_mem_sync_compute */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 + /* gfx_v8_0_emi=
t_mem_sync_compute */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06, /* gfx_v8_0_emit=
_trap_handler */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_ib_size =3D 7, /* gfx_v8_0_ring_emit_ib_c=
ompute */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_ib =3D gfx_v8_0_ring_emit_ib_compute,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_fence =3D gfx_v8_0_ring_emit_fence_comput=
e,<br>
@@ -6940,6 +6977,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_f=
uncs_compute =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pad_ib =3D amdgpu_ring_generic_pad_ib,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_wreg =3D gfx_v8_0_ring_emit_wreg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_mem_sync =3D gfx_v8_0_emit_mem_sync_compu=
te,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_trap_handler =3D gfx_v8_0_ring_emit_trap_=
handler,<br>
=C2=A0};<br>
<br>
=C2=A0static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq =3D {<b=
r>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index cb9d60a4e05e..4fc00f196085 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -4162,6 +4162,23 @@ static void gfx_v9_0_ring_emit_gds_switch(struct amd=
gpu_ring *ring,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; (oa_size + =
oa_base)) - (1 &lt;&lt; oa_base));<br>
=C2=A0}<br>
<br>
+static void gfx_v9_0_ring_emit_trap_handler(struct amdgpu_ring *ring,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint32_t vmid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint64_t tba_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint64_t tma_addr)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D ring-&gt;adev;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0soc15_grbm_select(adev, 0, 0, 0, vmid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO, low=
er_32_bits(tba_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI, upp=
er_32_bits(tba_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO, low=
er_32_bits(tma_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI, upp=
er_32_bits(tma_addr &gt;&gt; 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0soc15_grbm_select(adev, 0, 0, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
+}<br>
+<br>
=C2=A0static const u32 vgpr_init_compute_shader[] =3D<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xb07c0000, 0xbe8000ff,<br>
@@ -6720,6 +6737,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_f=
uncs_gfx =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit=
_reg_write_reg_wait,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .soft_recovery =3D gfx_v9_0_ring_soft_recovery,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_trap_handler =3D gfx_v9_0_ring_emit_trap_=
handler,<br>
=C2=A0};<br>
<br>
=C2=A0static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute =3D=
 {<br>
@@ -6756,6 +6774,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_f=
uncs_compute =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit=
_reg_write_reg_wait,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.emit_trap_handler =3D gfx_v9_0_ring_emit_trap_=
handler,<br>
=C2=A0};<br>
<br>
=C2=A0static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq =3D {<b=
r>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 3218576e109d..7eae264adb5d 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -551,6 +551,7 @@ struct drm_amdgpu_gem_va {<br>
=C2=A0#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT=C2=A0 =C2=A0 0x08<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL=C2=A0 0x09<br>
+#define AMDGPU_CHUNK_ID_TRAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0a=
<br>
<br>
=C2=A0struct drm_amdgpu_cs_chunk {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
hunk_id;<br>
@@ -645,6 +646,13 @@ struct drm_amdgpu_cs_chunk_syncobj {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u64 point;<br>
=C2=A0};<br>
<br>
+struct drm_amdgpu_cs_chunk_trap {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Trap Base Address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 tba_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** Trap Memory Address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 tma_addr;<br>
+};<br>
+<br>
=C2=A0#define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ=C2=A0 =C2=A0 =C2=A00<br>
=C2=A0#define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD=C2=A0 1<br>
=C2=A0#define AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 2<br>
-- <br>
2.28.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--00000000000092288105ada39a81--

--===============1611303581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1611303581==--
