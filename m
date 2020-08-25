Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585DC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533612078A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdHL+byT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533612078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCC46E866;
	Tue, 25 Aug 2020 07:05:00 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D226E866
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:04:58 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id r15so11527191wrp.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=9SC8h1Qf6ryplLJJykzqvUiVrSKOsyQIXLYjZd9hBZc=;
 b=JdHL+byTjT6mMmGrEygiO42SWp9hGloQM+lPdIlFm9sHzupytpa7D8zTa1TizZ2R2T
 o9JMMsl5pwnF1nQRaVfNuwEWc4H838HQsIXeK7KnCIh+2O2F1DXI1ssN0DbnI0gRqrfj
 YM+VT9l/2l4I3VSjUn/BMfjTLF7GAZxC76K0HorFzUzGkzNGcG4O5D+sDZYWMd18p6sF
 +VwK8Yk1KwEdEZnKfinoQ9YAUkconCK5Q7P6UEnOVngEpTAQA+W9aE2cA0zlVB3uqhm8
 Mr2B979d7U9TMfsH3fsq/YFWjqEPvyJFnbICcW4oM/cHFtz31UWfWtcpx5mkUc5TGJWc
 rI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=9SC8h1Qf6ryplLJJykzqvUiVrSKOsyQIXLYjZd9hBZc=;
 b=LQpH/5t1vdXb+mp3sqftdE9lah3GhI/FaNUxwDFWSX1JOVOn6lWvbqjMFUvwtUm886
 n2hcCoUremykMR0q4jY9ZbAl645MwZJ3i0keJtKuZiM01EQAdXkC2dhrQ7wGmbFsE7PW
 zBeaWEa/xC3zKkpMQd3e/10bfiZirPp5c8L+X4AUA4x/MeVsBYKpaG6L2H3R60R92mSa
 BF8wsxDdZ6qCiEUCmd3JsbjprxsKQl2ZDoDmEQuX4iwVXyaYw2ao+0Ie7XN8ast7sWF7
 uqGzS9WuQH8xv5x/Q74mkyKkIaTU5bym859jNxgfBoR4jfzfggKbl1c6cXb6G0grDVME
 Fsyg==
X-Gm-Message-State: AOAM533ec50oj1Aj2B4imrThGv4ajqhr5iBQJMxWSF+jVm+OmbvaM1Yn
 kUMEM49Q/eV2nJlY00Bc9lSXfY71okUAxg==
X-Google-Smtp-Source: ABdhPJzcm9RRSc/gfHBbuQUB4hITHn8PihhFWBfATev0Nk9WhlHoafJg2V6oEZ3RBGYcw3JIeJ9wrg==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr8702627wrc.141.1598339096605; 
 Tue, 25 Aug 2020 00:04:56 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:13a:17a0:fb6f:ee00:90ce:69a?
 ([2a01:e0a:13a:17a0:fb6f:ee00:90ce:69a])
 by smtp.gmail.com with ESMTPSA id v16sm4034469wmj.14.2020.08.25.00.04.56
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 00:04:56 -0700 (PDT)
Subject: Re: [RFC PATCH] drm/amdgpu: add support for user trap handlers
To: amd-gfx@lists.freedesktop.org
References: <20200824114916.11808-1-samuel.pitoiset@gmail.com>
 <CAAxE2A4wbg2MYZvpBomm1=r5Ety4An2Yn=pUf7KbRu+XjZ-MkQ@mail.gmail.com>
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Message-ID: <19c92b40-8d0a-c88b-e46f-f680d80f26a0@gmail.com>
Date: Tue, 25 Aug 2020 09:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A4wbg2MYZvpBomm1=r5Ety4An2Yn=pUf7KbRu+XjZ-MkQ@mail.gmail.com>
Content-Language: en-US
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
Content-Type: multipart/mixed; boundary="===============1767111924=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1767111924==
Content-Type: multipart/alternative;
 boundary="------------97B12D8606E91BC283E03220"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------97B12D8606E91BC283E03220
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/24/20 8:17 PM, Marek Olšák wrote:
> SET_SH_REG won't work with CP register shadowing. You need to use 
> WRITE_DATA or WREG32.
You are right, will fix.
>
> Marek
>
> On Mon, Aug 24, 2020 at 7:57 AM Samuel Pitoiset 
> <samuel.pitoiset@gmail.com <mailto:samuel.pitoiset@gmail.com>> wrote:
>
>     A trap handler can be used by userspace to catch shader exceptions
>     like divide by zero, memory violations etc.
>
>     On GFX6-GFX8, the registers used to configure TBA/TMA aren't
>     privileged while on GFX9+ they are per VMID and privileged,
>     so that only the KMD can configure them.
>
>     This introduces a new CS chunk that can be used to set the
>     TBA/TMA virtual address at submit time.
>
>     TODO:
>     - add GFX 6,7 and 10 support
>     - rebase on top of amd-staging-drm-next (this branch currently
>     hangs my GPU at boot)
>
>     Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com
>     <mailto:samuel.pitoiset@gmail.com>>
>     ---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 31 +++++++++++++++++
>      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
>      drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  4 +++
>      drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  4 +++
>      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 +++
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 15 ++++++++-
>      drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 42
>     ++++++++++++++++++++++--
>      drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 19 +++++++++++
>      include/uapi/drm/amdgpu_drm.h            |  8 +++++
>      9 files changed, 126 insertions(+), 4 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     index a512ccbc4dea..6ca5c4912e3a 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     @@ -104,6 +104,19 @@ static int amdgpu_cs_bo_handles_chunk(struct
>     amdgpu_cs_parser *p,
>             return r;
>      }
>
>     +static int amdgpu_cs_user_trap_chunk(struct amdgpu_cs_parser *p,
>     +                                    struct
>     drm_amdgpu_cs_chunk_trap *data,
>     +                                    uint64_t *tba_addr, uint64_t
>     *tma_addr)
>     +{
>     +       if (!data->tba_addr || !data->tma_addr)
>     +               return -EINVAL;
>     +
>     +       *tba_addr = data->tba_addr;
>     +       *tma_addr = data->tma_addr;
>     +
>     +       return 0;
>     +}
>     +
>      static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>     union drm_amdgpu_cs *cs)
>      {
>             struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>     @@ -112,6 +125,7 @@ static int amdgpu_cs_parser_init(struct
>     amdgpu_cs_parser *p, union drm_amdgpu_cs
>             uint64_t *chunk_array;
>             unsigned size, num_ibs = 0;
>             uint32_t uf_offset = 0;
>     +       uint64_t tba_addr = 0, tma_addr = 0;
>             int i;
>             int ret;
>
>     @@ -214,6 +228,19 @@ static int amdgpu_cs_parser_init(struct
>     amdgpu_cs_parser *p, union drm_amdgpu_cs
>
>                             break;
>
>     +               case AMDGPU_CHUNK_ID_TRAP:
>     +                       size = sizeof(struct
>     drm_amdgpu_cs_chunk_trap);
>     +                       if (p->chunks[i].length_dw *
>     sizeof(uint32_t) < size) {
>     +                               ret = -EINVAL;
>     +                               goto free_partial_kdata;
>     +                       }
>     +
>     +                       ret = amdgpu_cs_user_trap_chunk(p,
>     p->chunks[i].kdata,
>     +  &tba_addr, &tma_addr);
>     +                       if (ret)
>     +                               goto free_partial_kdata;
>     +                       break;
>     +
>                     case AMDGPU_CHUNK_ID_DEPENDENCIES:
>                     case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
>                     case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
>     @@ -239,6 +266,10 @@ static int amdgpu_cs_parser_init(struct
>     amdgpu_cs_parser *p, union drm_amdgpu_cs
>
>             if (p->uf_entry.tv.bo <http://uf_entry.tv.bo>)
>                     p->job->uf_addr = uf_offset;
>     +
>     +       p->job->tba_addr = tba_addr;
>     +       p->job->tma_addr = tma_addr;
>     +
>             kfree(chunk_array);
>
>             /* Use this opportunity to fill in task info for the vm */
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     index 26127c7d2f32..1e703119e4c2 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     @@ -88,9 +88,10 @@
>       * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for
>     correctness
>       * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
>       * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
>     + * - 3.40.0 - Add AMDGPU_CHUNK_ID_TRAP
>       */
>      #define KMS_DRIVER_MAJOR       3
>     -#define KMS_DRIVER_MINOR       39
>     +#define KMS_DRIVER_MINOR       40
>      #define KMS_DRIVER_PATCHLEVEL  0
>
>      int amdgpu_vram_limit = 0;
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>     index 8e58325bbca2..fd0d56724b4d 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>     @@ -58,6 +58,10 @@ struct amdgpu_vmid {
>             uint32_t                oa_base;
>             uint32_t                oa_size;
>
>     +       /* user trap */
>     +       uint64_t                tba_addr;
>     +       uint64_t                tma_addr;
>     +
>             unsigned                pasid;
>             struct dma_fence        *pasid_mapping;
>      };
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     index 81caac9b958a..b8ed5b13ea44 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>     @@ -62,6 +62,10 @@ struct amdgpu_job {
>             /* user fence handling */
>             uint64_t                uf_addr;
>             uint64_t                uf_sequence;
>     +
>     +       /* user trap handling */
>     +       uint64_t                tba_addr;
>     +       uint64_t                tma_addr;
>      };
>
>      int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>     index da871d84b742..1f165a6295d9 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>     @@ -197,6 +197,9 @@ struct amdgpu_ring_funcs {
>             void (*soft_recovery)(struct amdgpu_ring *ring, unsigned
>     vmid);
>             int (*preempt_ib)(struct amdgpu_ring *ring);
>             void (*emit_mem_sync)(struct amdgpu_ring *ring);
>     +       void (*emit_trap_handler)(struct amdgpu_ring *ring,
>     +                                 uint32_t vmid,
>     +                                 uint64_t tba_addr, uint64_t
>     tma_addr);
>      };
>
>      struct amdgpu_ring {
>     @@ -265,6 +268,7 @@ struct amdgpu_ring {
>      #define amdgpu_ring_emit_vm_flush(r, vmid, addr)
>     (r)->funcs->emit_vm_flush((r), (vmid), (addr))
>      #define amdgpu_ring_emit_fence(r, addr, seq, flags)
>     (r)->funcs->emit_fence((r), (addr), (seq), (flags))
>      #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as)
>     (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws),
>     (ab), (as))
>     +#define amdgpu_ring_emit_trap_handler(r, v, tba, tma)
>     (r)->funcs->emit_trap_handler((r), (v), (tba), (tma))
>      #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>      #define amdgpu_ring_emit_switch_buffer(r)
>     (r)->funcs->emit_switch_buffer((r))
>      #define amdgpu_ring_emit_cntxcntl(r, d)
>     (r)->funcs->emit_cntxcntl((r), (d))
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     index 71e005cf2952..24916082de0b 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     @@ -1076,6 +1076,9 @@ int amdgpu_vm_flush(struct amdgpu_ring
>     *ring, struct amdgpu_job *job,
>                     id->gws_size != job->gws_size ||
>                     id->oa_base != job->oa_base ||
>                     id->oa_size != job->oa_size);
>     +       bool trap_handler_needed = ring->funcs->emit_trap_handler && (
>     +               id->tba_addr != job->tba_addr ||
>     +               id->tma_addr != job->tma_addr);
>             bool vm_flush_needed = job->vm_needs_flush;
>             struct dma_fence *fence = NULL;
>             bool pasid_mapping_needed = false;
>     @@ -1088,6 +1091,7 @@ int amdgpu_vm_flush(struct amdgpu_ring
>     *ring, struct amdgpu_job *job,
>
>             if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>                     gds_switch_needed = true;
>     +               trap_handler_needed = true;
>                     vm_flush_needed = true;
>                     pasid_mapping_needed = true;
>             }
>     @@ -1099,12 +1103,14 @@ int amdgpu_vm_flush(struct amdgpu_ring
>     *ring, struct amdgpu_job *job,
>             mutex_unlock(&id_mgr->lock);
>
>             gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>     +       trap_handler_needed &= !!ring->funcs->emit_trap_handler;
>             vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>                             job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>             pasid_mapping_needed &=
>     adev->gmc.gmc_funcs->emit_pasid_mapping &&
>                     ring->funcs->emit_wreg;
>
>     -       if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>     +       if (!vm_flush_needed && !gds_switch_needed &&
>     +           !trap_handler_needed && !need_pipe_sync)
>                     return 0;
>
>             if (ring->funcs->init_cond_exec)
>     @@ -1158,6 +1164,13 @@ int amdgpu_vm_flush(struct amdgpu_ring
>     *ring, struct amdgpu_job *job,
>                                                 job->oa_size);
>             }
>
>     +       if (ring->funcs->emit_trap_handler && trap_handler_needed) {
>     +               id->tba_addr = job->tba_addr;
>     +               id->tma_addr = job->tma_addr;
>     +               amdgpu_ring_emit_trap_handler(ring, job->vmid,
>     job->tba_addr,
>     +  job->tma_addr);
>     +       }
>     +
>             if (ring->funcs->patch_cond_exec)
>                     amdgpu_ring_patch_cond_exec(ring, patch_offset);
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     index 33f1c4a46ebe..59db577e8c8f 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     @@ -5222,6 +5222,40 @@ static void
>     gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>             amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 <<
>     oa_base));
>      }
>
>     +static void gfx_v8_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
>     +                                           uint32_t vmid,
>     +                                           uint64_t tba_addr,
>     +                                           uint64_t tma_addr)
>     +{
>     +       if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
>     +               static const u32 regs[] = {
>     +                       mmSPI_SHADER_TBA_LO_PS,
>     +                       mmSPI_SHADER_TBA_LO_VS,
>     +                       mmSPI_SHADER_TBA_LO_GS,
>     +                       mmSPI_SHADER_TBA_LO_ES,
>     +                       mmSPI_SHADER_TBA_LO_HS,
>     +                       mmSPI_SHADER_TBA_LO_LS,
>     +               };
>     +               int i;
>     +
>     +               for (i = 0; i < ARRAY_SIZE(regs); i++) {
>     +                       amdgpu_ring_write(ring,
>     PACKET3(PACKET3_SET_SH_REG, 4));
>     +                       amdgpu_ring_write(ring, regs[i] -
>     PACKET3_SET_SH_REG_START);
>     +                       amdgpu_ring_write(ring,
>     lower_32_bits(tba_addr >> 8));
>     +                       amdgpu_ring_write(ring,
>     upper_32_bits(tba_addr >> 8));
>     +                       amdgpu_ring_write(ring,
>     lower_32_bits(tma_addr >> 8));
>     +                       amdgpu_ring_write(ring,
>     upper_32_bits(tma_addr >> 8));
>     +               }
>     +       } else {
>     +               amdgpu_ring_write(ring,
>     PACKET3(PACKET3_SET_SH_REG, 4));
>     +               amdgpu_ring_write(ring, mmCOMPUTE_TBA_LO -
>     PACKET3_SET_SH_REG_START);
>     +               amdgpu_ring_write(ring, lower_32_bits(tba_addr >> 8));
>     +               amdgpu_ring_write(ring, upper_32_bits(tba_addr >> 8));
>     +               amdgpu_ring_write(ring, lower_32_bits(tma_addr >> 8));
>     +               amdgpu_ring_write(ring, upper_32_bits(tma_addr >> 8));
>     +       }
>     +}
>     +
>      static uint32_t wave_read_ind(struct amdgpu_device *adev,
>     uint32_t simd, uint32_t wave, uint32_t address)
>      {
>             WREG32(mmSQ_IND_INDEX,
>     @@ -6890,7 +6924,8 @@ static const struct amdgpu_ring_funcs
>     gfx_v8_0_ring_funcs_gfx = {
>                     5 + /* HDP_INVL */
>                     12 + 12 + /* FENCE x2 */
>                     2 + /* SWITCH_BUFFER */
>     -               5, /* SURFACE_SYNC */
>     +               5 + /* SURFACE_SYNC */
>     +               36, /* gfx_v8_0_ring_emit_trap_handler */
>             .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_gfx */
>             .emit_ib = gfx_v8_0_ring_emit_ib_gfx,
>             .emit_fence = gfx_v8_0_ring_emit_fence_gfx,
>     @@ -6909,6 +6944,7 @@ static const struct amdgpu_ring_funcs
>     gfx_v8_0_ring_funcs_gfx = {
>             .emit_wreg = gfx_v8_0_ring_emit_wreg,
>             .soft_recovery = gfx_v8_0_ring_soft_recovery,
>             .emit_mem_sync = gfx_v8_0_emit_mem_sync,
>     +       .emit_trap_handler = gfx_v8_0_ring_emit_trap_handler,
>      };
>
>      static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
>     @@ -6926,7 +6962,8 @@ static const struct amdgpu_ring_funcs
>     gfx_v8_0_ring_funcs_compute = {
>                     7 + /* gfx_v8_0_ring_emit_pipeline_sync */
>                     VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
>     gfx_v8_0_ring_emit_vm_flush */
>                     7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3
>     for user fence, vm fence */
>     -               7, /* gfx_v8_0_emit_mem_sync_compute */
>     +               7 + /* gfx_v8_0_emit_mem_sync_compute */
>     +               6, /* gfx_v8_0_emit_trap_handler */
>             .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */
>             .emit_ib = gfx_v8_0_ring_emit_ib_compute,
>             .emit_fence = gfx_v8_0_ring_emit_fence_compute,
>     @@ -6940,6 +6977,7 @@ static const struct amdgpu_ring_funcs
>     gfx_v8_0_ring_funcs_compute = {
>             .pad_ib = amdgpu_ring_generic_pad_ib,
>             .emit_wreg = gfx_v8_0_ring_emit_wreg,
>             .emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
>     +       .emit_trap_handler = gfx_v8_0_ring_emit_trap_handler,
>      };
>
>      static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     index cb9d60a4e05e..4fc00f196085 100644
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>     @@ -4162,6 +4162,23 @@ static void
>     gfx_v9_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>                                        (1 << (oa_size + oa_base)) - (1
>     << oa_base));
>      }
>
>     +static void gfx_v9_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
>     +                                           uint32_t vmid,
>     +                                           uint64_t tba_addr,
>     +                                           uint64_t tma_addr)
>     +{
>     +       struct amdgpu_device *adev = ring->adev;
>     +
>     +       mutex_lock(&adev->srbm_mutex);
>     +       soc15_grbm_select(adev, 0, 0, 0, vmid);
>     +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO,
>     lower_32_bits(tba_addr >> 8));
>     +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI,
>     upper_32_bits(tba_addr >> 8));
>     +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO,
>     lower_32_bits(tma_addr >> 8));
>     +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI,
>     upper_32_bits(tma_addr >> 8));
>     +       soc15_grbm_select(adev, 0, 0, 0, 0);
>     +       mutex_unlock(&adev->srbm_mutex);
>     +}
>     +
>      static const u32 vgpr_init_compute_shader[] =
>      {
>             0xb07c0000, 0xbe8000ff,
>     @@ -6720,6 +6737,7 @@ static const struct amdgpu_ring_funcs
>     gfx_v9_0_ring_funcs_gfx = {
>             .emit_reg_write_reg_wait =
>     gfx_v9_0_ring_emit_reg_write_reg_wait,
>             .soft_recovery = gfx_v9_0_ring_soft_recovery,
>             .emit_mem_sync = gfx_v9_0_emit_mem_sync,
>     +       .emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
>      };
>
>      static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>     @@ -6756,6 +6774,7 @@ static const struct amdgpu_ring_funcs
>     gfx_v9_0_ring_funcs_compute = {
>             .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>             .emit_reg_write_reg_wait =
>     gfx_v9_0_ring_emit_reg_write_reg_wait,
>             .emit_mem_sync = gfx_v9_0_emit_mem_sync,
>     +       .emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
>      };
>
>      static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>     diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     index 3218576e109d..7eae264adb5d 100644
>     --- a/include/uapi/drm/amdgpu_drm.h
>     +++ b/include/uapi/drm/amdgpu_drm.h
>     @@ -551,6 +551,7 @@ struct drm_amdgpu_gem_va {
>      #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>      #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>      #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>     +#define AMDGPU_CHUNK_ID_TRAP            0x0a
>
>      struct drm_amdgpu_cs_chunk {
>             __u32           chunk_id;
>     @@ -645,6 +646,13 @@ struct drm_amdgpu_cs_chunk_syncobj {
>             __u64 point;
>      };
>
>     +struct drm_amdgpu_cs_chunk_trap {
>     +       /** Trap Base Address */
>     +       __u64 tba_addr;
>     +       /** Trap Memory Address */
>     +       __u64 tma_addr;
>     +};
>     +
>      #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ     0
>      #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD  1
>      #define AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD        2
>     -- 
>     2.28.0
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------97B12D8606E91BC283E03220
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/24/20 8:17 PM, Marek Olšák wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4wbg2MYZvpBomm1=r5Ety4An2Yn=pUf7KbRu+XjZ-MkQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>SET_SH_REG won't work with CP register shadowing. You need
          to use WRITE_DATA or WREG32.</div>
      </div>
    </blockquote>
    You are right, will fix.<br>
    <blockquote type="cite"
cite="mid:CAAxE2A4wbg2MYZvpBomm1=r5Ety4An2Yn=pUf7KbRu+XjZ-MkQ@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Mon, Aug 24, 2020 at 7:57
          AM Samuel Pitoiset &lt;<a
            href="mailto:samuel.pitoiset@gmail.com"
            moz-do-not-send="true">samuel.pitoiset@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A
          trap handler can be used by userspace to catch shader
          exceptions<br>
          like divide by zero, memory violations etc.<br>
          <br>
          On GFX6-GFX8, the registers used to configure TBA/TMA aren't<br>
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
          Signed-off-by: Samuel Pitoiset &lt;<a
            href="mailto:samuel.pitoiset@gmail.com" target="_blank"
            moz-do-not-send="true">samuel.pitoiset@gmail.com</a>&gt;<br>
          ---<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 31
          +++++++++++++++++<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  4 +++<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  4 +++<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 +++<br>
           drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 15 ++++++++-<br>
           drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 42
          ++++++++++++++++++++++--<br>
           drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 19 +++++++++++<br>
           include/uapi/drm/amdgpu_drm.h            |  8 +++++<br>
           9 files changed, 126 insertions(+), 4 deletions(-)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          index a512ccbc4dea..6ca5c4912e3a 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          @@ -104,6 +104,19 @@ static int
          amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,<br>
                  return r;<br>
           }<br>
          <br>
          +static int amdgpu_cs_user_trap_chunk(struct amdgpu_cs_parser
          *p,<br>
          +                                    struct
          drm_amdgpu_cs_chunk_trap *data,<br>
          +                                    uint64_t *tba_addr,
          uint64_t *tma_addr)<br>
          +{<br>
          +       if (!data-&gt;tba_addr || !data-&gt;tma_addr)<br>
          +               return -EINVAL;<br>
          +<br>
          +       *tba_addr = data-&gt;tba_addr;<br>
          +       *tma_addr = data-&gt;tma_addr;<br>
          +<br>
          +       return 0;<br>
          +}<br>
          +<br>
           static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
          union drm_amdgpu_cs *cs)<br>
           {<br>
                  struct amdgpu_fpriv *fpriv =
          p-&gt;filp-&gt;driver_priv;<br>
          @@ -112,6 +125,7 @@ static int amdgpu_cs_parser_init(struct
          amdgpu_cs_parser *p, union drm_amdgpu_cs<br>
                  uint64_t *chunk_array;<br>
                  unsigned size, num_ibs = 0;<br>
                  uint32_t uf_offset = 0;<br>
          +       uint64_t tba_addr = 0, tma_addr = 0;<br>
                  int i;<br>
                  int ret;<br>
          <br>
          @@ -214,6 +228,19 @@ static int amdgpu_cs_parser_init(struct
          amdgpu_cs_parser *p, union drm_amdgpu_cs<br>
          <br>
                                  break;<br>
          <br>
          +               case AMDGPU_CHUNK_ID_TRAP:<br>
          +                       size = sizeof(struct
          drm_amdgpu_cs_chunk_trap);<br>
          +                       if (p-&gt;chunks[i].length_dw *
          sizeof(uint32_t) &lt; size) {<br>
          +                               ret = -EINVAL;<br>
          +                               goto free_partial_kdata;<br>
          +                       }<br>
          +<br>
          +                       ret = amdgpu_cs_user_trap_chunk(p,
          p-&gt;chunks[i].kdata,<br>
          +                                                     
           &amp;tba_addr, &amp;tma_addr);<br>
          +                       if (ret)<br>
          +                               goto free_partial_kdata;<br>
          +                       break;<br>
          +<br>
                          case AMDGPU_CHUNK_ID_DEPENDENCIES:<br>
                          case AMDGPU_CHUNK_ID_SYNCOBJ_IN:<br>
                          case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:<br>
          @@ -239,6 +266,10 @@ static int amdgpu_cs_parser_init(struct
          amdgpu_cs_parser *p, union drm_amdgpu_cs<br>
          <br>
                  if (p-&gt;<a href="http://uf_entry.tv.bo"
            rel="noreferrer" target="_blank" moz-do-not-send="true">uf_entry.tv.bo</a>)<br>
                          p-&gt;job-&gt;uf_addr = uf_offset;<br>
          +<br>
          +       p-&gt;job-&gt;tba_addr = tba_addr;<br>
          +       p-&gt;job-&gt;tma_addr = tma_addr;<br>
          +<br>
                  kfree(chunk_array);<br>
          <br>
                  /* Use this opportunity to fill in task info for the
          vm */<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
          index 26127c7d2f32..1e703119e4c2 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
          @@ -88,9 +88,10 @@<br>
            * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for
          correctness<br>
            * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC<br>
            * - 3.39.0 - DMABUF implicit sync does a full pipeline sync<br>
          + * - 3.40.0 - Add AMDGPU_CHUNK_ID_TRAP<br>
            */<br>
           #define KMS_DRIVER_MAJOR       3<br>
          -#define KMS_DRIVER_MINOR       39<br>
          +#define KMS_DRIVER_MINOR       40<br>
           #define KMS_DRIVER_PATCHLEVEL  0<br>
          <br>
           int amdgpu_vram_limit = 0;<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
          index 8e58325bbca2..fd0d56724b4d 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h<br>
          @@ -58,6 +58,10 @@ struct amdgpu_vmid {<br>
                  uint32_t                oa_base;<br>
                  uint32_t                oa_size;<br>
          <br>
          +       /* user trap */<br>
          +       uint64_t                tba_addr;<br>
          +       uint64_t                tma_addr;<br>
          +<br>
                  unsigned                pasid;<br>
                  struct dma_fence        *pasid_mapping;<br>
           };<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
          index 81caac9b958a..b8ed5b13ea44 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
          @@ -62,6 +62,10 @@ struct amdgpu_job {<br>
                  /* user fence handling */<br>
                  uint64_t                uf_addr;<br>
                  uint64_t                uf_sequence;<br>
          +<br>
          +       /* user trap handling */<br>
          +       uint64_t                tba_addr;<br>
          +       uint64_t                tma_addr;<br>
           };<br>
          <br>
           int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned
          num_ibs,<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
          index da871d84b742..1f165a6295d9 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
          @@ -197,6 +197,9 @@ struct amdgpu_ring_funcs {<br>
                  void (*soft_recovery)(struct amdgpu_ring *ring,
          unsigned vmid);<br>
                  int (*preempt_ib)(struct amdgpu_ring *ring);<br>
                  void (*emit_mem_sync)(struct amdgpu_ring *ring);<br>
          +       void (*emit_trap_handler)(struct amdgpu_ring *ring,<br>
          +                                 uint32_t vmid,<br>
          +                                 uint64_t tba_addr, uint64_t
          tma_addr);<br>
           };<br>
          <br>
           struct amdgpu_ring {<br>
          @@ -265,6 +268,7 @@ struct amdgpu_ring {<br>
           #define amdgpu_ring_emit_vm_flush(r, vmid, addr)
          (r)-&gt;funcs-&gt;emit_vm_flush((r), (vmid), (addr))<br>
           #define amdgpu_ring_emit_fence(r, addr, seq, flags)
          (r)-&gt;funcs-&gt;emit_fence((r), (addr), (seq), (flags))<br>
           #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab,
          as) (r)-&gt;funcs-&gt;emit_gds_switch((r), (v), (db), (ds),
          (wb), (ws), (ab), (as))<br>
          +#define amdgpu_ring_emit_trap_handler(r, v, tba, tma)
          (r)-&gt;funcs-&gt;emit_trap_handler((r), (v), (tba), (tma))<br>
           #define amdgpu_ring_emit_hdp_flush(r)
          (r)-&gt;funcs-&gt;emit_hdp_flush((r))<br>
           #define amdgpu_ring_emit_switch_buffer(r)
          (r)-&gt;funcs-&gt;emit_switch_buffer((r))<br>
           #define amdgpu_ring_emit_cntxcntl(r, d)
          (r)-&gt;funcs-&gt;emit_cntxcntl((r), (d))<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          index 71e005cf2952..24916082de0b 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          @@ -1076,6 +1076,9 @@ int amdgpu_vm_flush(struct amdgpu_ring
          *ring, struct amdgpu_job *job,<br>
                          id-&gt;gws_size != job-&gt;gws_size ||<br>
                          id-&gt;oa_base != job-&gt;oa_base ||<br>
                          id-&gt;oa_size != job-&gt;oa_size);<br>
          +       bool trap_handler_needed =
          ring-&gt;funcs-&gt;emit_trap_handler &amp;&amp; (<br>
          +               id-&gt;tba_addr != job-&gt;tba_addr ||<br>
          +               id-&gt;tma_addr != job-&gt;tma_addr);<br>
                  bool vm_flush_needed = job-&gt;vm_needs_flush;<br>
                  struct dma_fence *fence = NULL;<br>
                  bool pasid_mapping_needed = false;<br>
          @@ -1088,6 +1091,7 @@ int amdgpu_vm_flush(struct amdgpu_ring
          *ring, struct amdgpu_job *job,<br>
          <br>
                  if (amdgpu_vmid_had_gpu_reset(adev, id)) {<br>
                          gds_switch_needed = true;<br>
          +               trap_handler_needed = true;<br>
                          vm_flush_needed = true;<br>
                          pasid_mapping_needed = true;<br>
                  }<br>
          @@ -1099,12 +1103,14 @@ int amdgpu_vm_flush(struct amdgpu_ring
          *ring, struct amdgpu_job *job,<br>
                  mutex_unlock(&amp;id_mgr-&gt;lock);<br>
          <br>
                  gds_switch_needed &amp;=
          !!ring-&gt;funcs-&gt;emit_gds_switch;<br>
          +       trap_handler_needed &amp;=
          !!ring-&gt;funcs-&gt;emit_trap_handler;<br>
                  vm_flush_needed &amp;=
          !!ring-&gt;funcs-&gt;emit_vm_flush  &amp;&amp;<br>
                                  job-&gt;vm_pd_addr !=
          AMDGPU_BO_INVALID_OFFSET;<br>
                  pasid_mapping_needed &amp;=
          adev-&gt;gmc.gmc_funcs-&gt;emit_pasid_mapping &amp;&amp;<br>
                          ring-&gt;funcs-&gt;emit_wreg;<br>
          <br>
          -       if (!vm_flush_needed &amp;&amp; !gds_switch_needed
          &amp;&amp; !need_pipe_sync)<br>
          +       if (!vm_flush_needed &amp;&amp; !gds_switch_needed
          &amp;&amp;<br>
          +           !trap_handler_needed &amp;&amp; !need_pipe_sync)<br>
                          return 0;<br>
          <br>
                  if (ring-&gt;funcs-&gt;init_cond_exec)<br>
          @@ -1158,6 +1164,13 @@ int amdgpu_vm_flush(struct amdgpu_ring
          *ring, struct amdgpu_job *job,<br>
                                                      job-&gt;oa_size);<br>
                  }<br>
          <br>
          +       if (ring-&gt;funcs-&gt;emit_trap_handler &amp;&amp;
          trap_handler_needed) {<br>
          +               id-&gt;tba_addr = job-&gt;tba_addr;<br>
          +               id-&gt;tma_addr = job-&gt;tma_addr;<br>
          +               amdgpu_ring_emit_trap_handler(ring,
          job-&gt;vmid, job-&gt;tba_addr,<br>
          +                                           
           job-&gt;tma_addr);<br>
          +       }<br>
          +<br>
                  if (ring-&gt;funcs-&gt;patch_cond_exec)<br>
                          amdgpu_ring_patch_cond_exec(ring,
          patch_offset);<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          index 33f1c4a46ebe..59db577e8c8f 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
          @@ -5222,6 +5222,40 @@ static void
          gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring,<br>
                  amdgpu_ring_write(ring, (1 &lt;&lt; (oa_size +
          oa_base)) - (1 &lt;&lt; oa_base));<br>
           }<br>
          <br>
          +static void gfx_v8_0_ring_emit_trap_handler(struct
          amdgpu_ring *ring,<br>
          +                                           uint32_t vmid,<br>
          +                                           uint64_t tba_addr,<br>
          +                                           uint64_t tma_addr)<br>
          +{<br>
          +       if (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_GFX) {<br>
          +               static const u32 regs[] = {<br>
          +                       mmSPI_SHADER_TBA_LO_PS,<br>
          +                       mmSPI_SHADER_TBA_LO_VS,<br>
          +                       mmSPI_SHADER_TBA_LO_GS,<br>
          +                       mmSPI_SHADER_TBA_LO_ES,<br>
          +                       mmSPI_SHADER_TBA_LO_HS,<br>
          +                       mmSPI_SHADER_TBA_LO_LS,<br>
          +               };<br>
          +               int i;<br>
          +<br>
          +               for (i = 0; i &lt; ARRAY_SIZE(regs); i++) {<br>
          +                       amdgpu_ring_write(ring,
          PACKET3(PACKET3_SET_SH_REG, 4));<br>
          +                       amdgpu_ring_write(ring, regs[i] -
          PACKET3_SET_SH_REG_START);<br>
          +                       amdgpu_ring_write(ring,
          lower_32_bits(tba_addr &gt;&gt; 8));<br>
          +                       amdgpu_ring_write(ring,
          upper_32_bits(tba_addr &gt;&gt; 8));<br>
          +                       amdgpu_ring_write(ring,
          lower_32_bits(tma_addr &gt;&gt; 8));<br>
          +                       amdgpu_ring_write(ring,
          upper_32_bits(tma_addr &gt;&gt; 8));<br>
          +               }<br>
          +       } else {<br>
          +               amdgpu_ring_write(ring,
          PACKET3(PACKET3_SET_SH_REG, 4));<br>
          +               amdgpu_ring_write(ring, mmCOMPUTE_TBA_LO -
          PACKET3_SET_SH_REG_START);<br>
          +               amdgpu_ring_write(ring, lower_32_bits(tba_addr
          &gt;&gt; 8));<br>
          +               amdgpu_ring_write(ring, upper_32_bits(tba_addr
          &gt;&gt; 8));<br>
          +               amdgpu_ring_write(ring, lower_32_bits(tma_addr
          &gt;&gt; 8));<br>
          +               amdgpu_ring_write(ring, upper_32_bits(tma_addr
          &gt;&gt; 8));<br>
          +       }<br>
          +}<br>
          +<br>
           static uint32_t wave_read_ind(struct amdgpu_device *adev,
          uint32_t simd, uint32_t wave, uint32_t address)<br>
           {<br>
                  WREG32(mmSQ_IND_INDEX,<br>
          @@ -6890,7 +6924,8 @@ static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_gfx = {<br>
                          5 + /* HDP_INVL */<br>
                          12 + 12 + /* FENCE x2 */<br>
                          2 + /* SWITCH_BUFFER */<br>
          -               5, /* SURFACE_SYNC */<br>
          +               5 + /* SURFACE_SYNC */<br>
          +               36, /* gfx_v8_0_ring_emit_trap_handler */<br>
                  .emit_ib_size = 4, /* gfx_v8_0_ring_emit_ib_gfx */<br>
                  .emit_ib = gfx_v8_0_ring_emit_ib_gfx,<br>
                  .emit_fence = gfx_v8_0_ring_emit_fence_gfx,<br>
          @@ -6909,6 +6944,7 @@ static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_gfx = {<br>
                  .emit_wreg = gfx_v8_0_ring_emit_wreg,<br>
                  .soft_recovery = gfx_v8_0_ring_soft_recovery,<br>
                  .emit_mem_sync = gfx_v8_0_emit_mem_sync,<br>
          +       .emit_trap_handler = gfx_v8_0_ring_emit_trap_handler,<br>
           };<br>
          <br>
           static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_compute = {<br>
          @@ -6926,7 +6962,8 @@ static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_compute = {<br>
                          7 + /* gfx_v8_0_ring_emit_pipeline_sync */<br>
                          VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /*
          gfx_v8_0_ring_emit_vm_flush */<br>
                          7 + 7 + 7 + /*
          gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence
          */<br>
          -               7, /* gfx_v8_0_emit_mem_sync_compute */<br>
          +               7 + /* gfx_v8_0_emit_mem_sync_compute */<br>
          +               6, /* gfx_v8_0_emit_trap_handler */<br>
                  .emit_ib_size = 7, /* gfx_v8_0_ring_emit_ib_compute */<br>
                  .emit_ib = gfx_v8_0_ring_emit_ib_compute,<br>
                  .emit_fence = gfx_v8_0_ring_emit_fence_compute,<br>
          @@ -6940,6 +6977,7 @@ static const struct amdgpu_ring_funcs
          gfx_v8_0_ring_funcs_compute = {<br>
                  .pad_ib = amdgpu_ring_generic_pad_ib,<br>
                  .emit_wreg = gfx_v8_0_ring_emit_wreg,<br>
                  .emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,<br>
          +       .emit_trap_handler = gfx_v8_0_ring_emit_trap_handler,<br>
           };<br>
          <br>
           static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq
          = {<br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
          b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          index cb9d60a4e05e..4fc00f196085 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
          @@ -4162,6 +4162,23 @@ static void
          gfx_v9_0_ring_emit_gds_switch(struct amdgpu_ring *ring,<br>
                                             (1 &lt;&lt; (oa_size +
          oa_base)) - (1 &lt;&lt; oa_base));<br>
           }<br>
          <br>
          +static void gfx_v9_0_ring_emit_trap_handler(struct
          amdgpu_ring *ring,<br>
          +                                           uint32_t vmid,<br>
          +                                           uint64_t tba_addr,<br>
          +                                           uint64_t tma_addr)<br>
          +{<br>
          +       struct amdgpu_device *adev = ring-&gt;adev;<br>
          +<br>
          +       mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
          +       soc15_grbm_select(adev, 0, 0, 0, vmid);<br>
          +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO,
          lower_32_bits(tba_addr &gt;&gt; 8));<br>
          +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI,
          upper_32_bits(tba_addr &gt;&gt; 8));<br>
          +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO,
          lower_32_bits(tma_addr &gt;&gt; 8));<br>
          +       WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI,
          upper_32_bits(tma_addr &gt;&gt; 8));<br>
          +       soc15_grbm_select(adev, 0, 0, 0, 0);<br>
          +       mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
          +}<br>
          +<br>
           static const u32 vgpr_init_compute_shader[] =<br>
           {<br>
                  0xb07c0000, 0xbe8000ff,<br>
          @@ -6720,6 +6737,7 @@ static const struct amdgpu_ring_funcs
          gfx_v9_0_ring_funcs_gfx = {<br>
                  .emit_reg_write_reg_wait =
          gfx_v9_0_ring_emit_reg_write_reg_wait,<br>
                  .soft_recovery = gfx_v9_0_ring_soft_recovery,<br>
                  .emit_mem_sync = gfx_v9_0_emit_mem_sync,<br>
          +       .emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,<br>
           };<br>
          <br>
           static const struct amdgpu_ring_funcs
          gfx_v9_0_ring_funcs_compute = {<br>
          @@ -6756,6 +6774,7 @@ static const struct amdgpu_ring_funcs
          gfx_v9_0_ring_funcs_compute = {<br>
                  .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,<br>
                  .emit_reg_write_reg_wait =
          gfx_v9_0_ring_emit_reg_write_reg_wait,<br>
                  .emit_mem_sync = gfx_v9_0_emit_mem_sync,<br>
          +       .emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,<br>
           };<br>
          <br>
           static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq
          = {<br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h<br>
          index 3218576e109d..7eae264adb5d 100644<br>
          --- a/include/uapi/drm/amdgpu_drm.h<br>
          +++ b/include/uapi/drm/amdgpu_drm.h<br>
          @@ -551,6 +551,7 @@ struct drm_amdgpu_gem_va {<br>
           #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
           #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08<br>
           #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09<br>
          +#define AMDGPU_CHUNK_ID_TRAP            0x0a<br>
          <br>
           struct drm_amdgpu_cs_chunk {<br>
                  __u32           chunk_id;<br>
          @@ -645,6 +646,13 @@ struct drm_amdgpu_cs_chunk_syncobj {<br>
                  __u64 point;<br>
           };<br>
          <br>
          +struct drm_amdgpu_cs_chunk_trap {<br>
          +       /** Trap Base Address */<br>
          +       __u64 tba_addr;<br>
          +       /** Trap Memory Address */<br>
          +       __u64 tma_addr;<br>
          +};<br>
          +<br>
           #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ     0<br>
           #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD  1<br>
           #define AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD        2<br>
          -- <br>
          2.28.0<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank"
            moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          <a
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
            rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
  </body>
</html>

--------------97B12D8606E91BC283E03220--

--===============1767111924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1767111924==--
