Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9B8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 07:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23B410F523;
	Tue, 10 May 2022 07:30:05 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21CA10F523
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 07:30:03 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aeae3.dynamic.kabel-deutschland.de
 [95.90.234.227])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DBA261E6478B;
 Tue, 10 May 2022 09:30:02 +0200 (CEST)
Message-ID: <661503a2-064f-476d-3683-d7a0bd40fb16@molgen.mpg.de>
Date: Tue, 10 May 2022 09:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu/gfx11: fix mes mqd settings and map_queue
 packet
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220509190657.478625-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220509190657.478625-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Jack,


Thank you for the patch.

Am 09.05.22 um 21:06 schrieb Alex Deucher:
> From: Jack Xiao <Jack.Xiao@amd.com>
> 
> a. use correct mes mqd settings

Can you please elaborate? What is wrong with the old ones, and what are 
the correct ones?

> b. fix me field in map_queue packet

Can you please add some background? The new value is 2. What does it do?

It’d be great, if you could make it two patches.

> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |  7 +++++--
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 ++++++++++----------
>   2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7614f38ff381..8a1bec70c719 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -145,16 +145,19 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
>   {
>   	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
>   	uint64_t wptr_addr = ring->wptr_gpu_addr;
> -	uint32_t eng_sel = 0;
> +	uint32_t me = 0, eng_sel = 0;
>   
>   	switch (ring->funcs->type) {
>   	case AMDGPU_RING_TYPE_COMPUTE:
> +		me = 1;
>   		eng_sel = 0;
>   		break;
>   	case AMDGPU_RING_TYPE_GFX:
> +		me = 0;
>   		eng_sel = 4;
>   		break;
>   	case AMDGPU_RING_TYPE_MES:
> +		me = 2;
>   		eng_sel = 5;
>   		break;
>   	default:
> @@ -168,7 +171,7 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
>   			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
>   			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
>   			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
> -			  PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
> +			  PACKET3_MAP_QUEUES_ME((me)) |
>   			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
>   			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
>   			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 5d4d54cabf70..fcf51947bb18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -29,7 +29,7 @@
>   #include "gc/gc_11_0_0_offset.h"
>   #include "gc/gc_11_0_0_sh_mask.h"
>   #include "gc/gc_11_0_0_default.h"
> -#include "v10_structs.h"
> +#include "v11_structs.h"
>   #include "mes_v11_api_def.h"
>   
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
> @@ -637,7 +637,7 @@ static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
>   
>   static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
>   {
> -	struct v10_compute_mqd *mqd = ring->mqd_ptr;
> +	struct v11_compute_mqd *mqd = ring->mqd_ptr;
>   	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
>   	uint32_t tmp;
>   
> @@ -724,22 +724,22 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
>   	mqd->cp_hqd_vmid = 0;
>   	/* activate the queue */
>   	mqd->cp_hqd_active = 1;
> -	mqd->cp_hqd_persistent_state = regCP_HQD_PERSISTENT_STATE_DEFAULT;
> +
> +	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
> +	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE,
> +			    PRELOAD_SIZE, 0x55);
> +	mqd->cp_hqd_persistent_state = tmp;
> +
>   	mqd->cp_hqd_ib_control = regCP_HQD_IB_CONTROL_DEFAULT;
>   	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
>   	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
>   
> -	tmp = regCP_HQD_GFX_CONTROL_DEFAULT;
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_EN, 1);
> -	/* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
> -	mqd->cp_hqd_suspend_cntl_stack_offset = tmp;
> -

What was wrong with this?


Kind regards,

Paul


>   	return 0;
>   }
>   
>   static void mes_v11_0_queue_init_register(struct amdgpu_ring *ring)
>   {
> -	struct v10_compute_mqd *mqd = ring->mqd_ptr;
> +	struct v11_compute_mqd *mqd = ring->mqd_ptr;
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t data = 0;
>   
> @@ -910,7 +910,7 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_device *adev)
>   static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
>   				 enum admgpu_mes_pipe pipe)
>   {
> -	int r, mqd_size = sizeof(struct v10_compute_mqd);
> +	int r, mqd_size = sizeof(struct v11_compute_mqd);
>   	struct amdgpu_ring *ring;
>   
>   	if (pipe == AMDGPU_MES_KIQ_PIPE)
