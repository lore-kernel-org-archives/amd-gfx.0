Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F401EE20AF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E2F10E7DF;
	Fri,  6 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QGvzoVBD";
	dkim-atps=neutral
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C50610E76E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:41:31 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso19055755e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770385290; x=1770990090; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FwqCRu3w8jjbtppuihcIzd+IgIGfj7o2PSwIQSoz7SI=;
 b=QGvzoVBDU/D8IcgkGEEhceMW2irDCGI0Maxr12fpt3dWmhfEAVFe0ZXchGEYBLH3jl
 L8o7DNesoB3II/TU9MLvshMlHsPZLubC5V5U2egl/f1DrgDHQTqHKoA3/sRiQD5BKok+
 4KIBcDOR9DBtuUv3PxR6XUAM8js49lk0K4LulbnRGtIXwlID2YrM81cN64Mi2aTayJ7T
 BZCv5HC3FHg13swxbyN5TopZTJYcTHlBpYIlfhplQWg6lPhuP405FaudY5jRa41OSd/M
 iAzF+JKA93HqD0pSMg8qlN6h3GAa8vTF3yVqkaBpxeg40GgBkvkbYkv/L/uMhiu0B5OJ
 0m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385290; x=1770990090;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwqCRu3w8jjbtppuihcIzd+IgIGfj7o2PSwIQSoz7SI=;
 b=b9eSQ64r8gmrqKwU1eOn343WF0yQvgwrsabqJZ3FJjkotapTIS+1cv08FOIiSlbqW0
 Wa6LofKgAbtE0jVYYupqSuW6dVOyBeZ/4palvBakKlJkrOrqL8rOF9AsvOSN0X5wR/ZP
 7jkbdwZlRxL8iX/86VWNMVz3IjlFSRwkDx0VQ8yhp8o2BuoPcVdTywaoBsg6BSBOwddr
 /Cmf9SqqDpnOT4TXF/E7C29OYO2wVsgngiP80YMcGMYkK7ampfR6TA9jz2EApE4RMnkd
 fnZJeTsMeCa6H5m2/4+J/kz7aZC+MEqjtWTBajGOzq68ZzbzyvSmg6SPx3odSOw0ZHUL
 gfQQ==
X-Gm-Message-State: AOJu0YwFlQnJkd9U4Ft8TeST1j4kIsYoOAkeTqdt94EvJ5VjysYobupD
 DowU6s1Ma2H4SO2viQupggKxc2IPGZDwiuckrdNGGuquDH+T6oM+JxJdvxTpweQEC+8=
X-Gm-Gg: AZuq6aKeZhaEJrM1ij+DzQhr76wCfrXa+5uBV/TiLdWQoWD4ErfSBcBToVwBnz6/ZWu
 b2lzYUYVQd4TZkpWbEcfZ9p2oicSO+A6fryLE6taUFrTvQItRxi04x4olJA+fAwSaYfjjUh9Ss2
 ywU8uyfDDRjjsxWlYwXNQ6HhOQPnWkSFSK/HU/RqMpzhtrSLg6cxmmwT9eq3VDYEcwOVmXjVFsl
 s80O1hArlAMAVnVQLA3LE8CMqIIAJoF4Hf6fPGpWnkRBeVD0wOq/uq3+Fcfbsb9BDE76rigM6zc
 xS9d8bp6xgpF6KKzrKgAKdCFUpVhdBH4uTjcaaYts8piqBYrXnVr0ZBlUFKlsNL8fJDf94htO1A
 X7mDPtvYh8u/vhj32xF80rfmAI3SvCW4UUdv/hlrxMSiFVNsEFQJ9LIJkOI0PJ7D8CZCyiVNTZW
 UbF/qaSQcdrojDxfZs
X-Received: by 2002:a05:600c:c48f:b0:480:4d76:daf0 with SMTP id
 5b1f17b1804b1-48320229d60mr35998615e9.37.1770385289947; 
 Fri, 06 Feb 2026 05:41:29 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a99asm140515745e9.11.2026.02.06.05.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 05:41:29 -0800 (PST)
Date: Fri, 6 Feb 2026 16:41:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] drm/amdgpu: fix possible fence leaks from job structure
Message-ID: <aYXvhj1fJ8ZFGyV4@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Alex Deucher,

Commit f903b85ed0f1 ("drm/amdgpu: fix possible fence leaks from job
structure") from Oct 22, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c:232 amdgpu_ib_schedule()
	warn: missing unwind goto?

drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    124 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
    125                        struct amdgpu_ib *ibs, struct amdgpu_job *job,
    126                        struct dma_fence **f)
    127 {
    128         struct amdgpu_device *adev = ring->adev;
    129         struct amdgpu_ib *ib = &ibs[0];
    130         struct dma_fence *tmp = NULL;
    131         struct amdgpu_fence *af;
    132         bool need_ctx_switch;
    133         struct amdgpu_vm *vm;
    134         uint64_t fence_ctx;
    135         uint32_t status = 0, alloc_size;
    136         unsigned int fence_flags = 0;
    137         bool secure, init_shadow;
    138         u64 shadow_va, csa_va, gds_va;
    139         int vmid = AMDGPU_JOB_GET_VMID(job);
    140         bool need_pipe_sync = false;
    141         unsigned int cond_exec;
    142         unsigned int i;
    143         int r = 0;
    144 
    145         if (num_ibs == 0)
    146                 return -EINVAL;
    147 
    148         /* ring tests don't use a job */
    149         if (job) {
    150                 vm = job->vm;
    151                 fence_ctx = job->base.s_fence ?
    152                         job->base.s_fence->finished.context : 0;
    153                 shadow_va = job->shadow_va;
    154                 csa_va = job->csa_va;
    155                 gds_va = job->gds_va;
    156                 init_shadow = job->init_shadow;
    157                 af = job->hw_fence;
    158                 /* Save the context of the job for reset handling.
    159                  * The driver needs this so it can skip the ring
    160                  * contents for guilty contexts.
    161                  */
    162                 af->context = fence_ctx;
    163                 /* the vm fence is also part of the job's context */
    164                 job->hw_vm_fence->context = fence_ctx;
    165         } else {
    166                 vm = NULL;
    167                 fence_ctx = 0;
    168                 shadow_va = 0;
    169                 csa_va = 0;
    170                 gds_va = 0;
    171                 init_shadow = false;
    172                 af = kzalloc(sizeof(*af), GFP_ATOMIC);
    173                 if (!af)
    174                         return -ENOMEM;
    175         }
    176 
    177         if (!ring->sched.ready) {
    178                 dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
    179                 r = -EINVAL;
    180                 goto free_fence;
    181         }
    182 
    183         if (vm && !job->vmid) {
    184                 dev_err(adev->dev, "VM IB without ID\n");
    185                 r = -EINVAL;
    186                 goto free_fence;
    187         }
    188 
    189         if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
    190             (!ring->funcs->secure_submission_supported)) {
    191                 dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
    192                 r = -EINVAL;
    193                 goto free_fence;
    194         }
    195 
    196         alloc_size = ring->funcs->emit_frame_size + num_ibs *
    197                 ring->funcs->emit_ib_size;
    198 
    199         r = amdgpu_ring_alloc(ring, alloc_size);
    200         if (r) {
    201                 dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
    202                 goto free_fence;
    203         }
    204 
    205         need_ctx_switch = ring->current_ctx != fence_ctx;
    206         if (ring->funcs->emit_pipeline_sync && job &&
    207             ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
    208              need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
    209 
    210                 need_pipe_sync = true;
    211 
    212                 if (tmp)
    213                         trace_amdgpu_ib_pipe_sync(job, tmp);
    214 
    215                 dma_fence_put(tmp);
    216         }
    217 
    218         if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
    219                 ring->funcs->emit_mem_sync(ring);
    220 
    221         if (ring->funcs->emit_wave_limit &&
    222             ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
    223                 ring->funcs->emit_wave_limit(ring, true);
    224 
    225         if (ring->funcs->insert_start)
    226                 ring->funcs->insert_start(ring);
    227 
    228         if (job) {
    229                 r = amdgpu_vm_flush(ring, job, need_pipe_sync);
    230                 if (r) {
    231                         amdgpu_ring_undo(ring);
--> 232                         return r;

The patch changed the other error paths to goto free_fence but this
one was accidentally skipped.

    233                 }
    234         }
    235 
    236         amdgpu_ring_ib_begin(ring);
    237 
    238         if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
    239                 amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
    240                                             init_shadow, vmid);
    241 
    242         if (ring->funcs->init_cond_exec)
    243                 cond_exec = amdgpu_ring_init_cond_exec(ring,
    244                                                        ring->cond_exe_gpu_addr);
    245 
    246         amdgpu_device_flush_hdp(adev, ring);
    247 
    248         if (need_ctx_switch)
    249                 status |= AMDGPU_HAVE_CTX_SWITCH;
    250 
    251         if (job && ring->funcs->emit_cntxcntl) {
    252                 status |= job->preamble_status;
    253                 status |= job->preemption_status;
    254                 amdgpu_ring_emit_cntxcntl(ring, status);
    255         }
    256 
    257         /* Setup initial TMZiness and send it off.
    258          */
    259         secure = false;
    260         if (job && ring->funcs->emit_frame_cntl) {
    261                 secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
    262                 amdgpu_ring_emit_frame_cntl(ring, true, secure);
    263         }
    264 
    265         for (i = 0; i < num_ibs; ++i) {
    266                 ib = &ibs[i];
    267 
    268                 if (job && ring->funcs->emit_frame_cntl) {
    269                         if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
    270                                 amdgpu_ring_emit_frame_cntl(ring, false, secure);
    271                                 secure = !secure;
    272                                 amdgpu_ring_emit_frame_cntl(ring, true, secure);
    273                         }
    274                 }
    275 
    276                 amdgpu_ring_emit_ib(ring, job, ib, status);
    277                 status &= ~AMDGPU_HAVE_CTX_SWITCH;
    278         }
    279 
    280         if (job && ring->funcs->emit_frame_cntl)
    281                 amdgpu_ring_emit_frame_cntl(ring, false, secure);
    282 
    283         amdgpu_device_invalidate_hdp(adev, ring);
    284 
    285         if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
    286                 fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
    287 
    288         /* wrap the last IB with fence */
    289         if (job && job->uf_addr) {
    290                 amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
    291                                        fence_flags | AMDGPU_FENCE_FLAG_64BIT);
    292         }
    293 
    294         if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec &&
    295             adev->gfx.cp_gfx_shadow) {
    296                 amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
    297                 amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
    298         }
    299 
    300         r = amdgpu_fence_emit(ring, af, fence_flags);
    301         if (r) {
    302                 dev_err(adev->dev, "failed to emit fence (%d)\n", r);
    303                 if (job && job->vmid)
    304                         amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
    305                 amdgpu_ring_undo(ring);
    306                 goto free_fence;
    307         }
    308         *f = &af->base;
    309         /* get a ref for the job */
    310         if (job)
    311                 dma_fence_get(*f);
    312 
    313         if (ring->funcs->insert_end)
    314                 ring->funcs->insert_end(ring);
    315 
    316         amdgpu_ring_patch_cond_exec(ring, cond_exec);
    317 
    318         ring->current_ctx = fence_ctx;
    319         if (job && ring->funcs->emit_switch_buffer)
    320                 amdgpu_ring_emit_switch_buffer(ring);
    321 
    322         if (ring->funcs->emit_wave_limit &&
    323             ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
    324                 ring->funcs->emit_wave_limit(ring, false);
    325 
    326         /* Save the wptr associated with this fence.
    327          * This must be last for resets to work properly
    328          * as we need to save the wptr associated with this
    329          * fence so we know what rings contents to backup
    330          * after we reset the queue.
    331          */
    332         amdgpu_fence_save_wptr(af);
    333 
    334         amdgpu_ring_ib_end(ring);
    335         amdgpu_ring_commit(ring);
    336 
    337         return 0;
    338 
    339 free_fence:
    340         if (!job)
    341                 kfree(af);
    342         return r;
    343 }

regards,
dan carpenter
