From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 05/13] drm/amdgpu: unify MQD programming sequence for kfd
 and amdgpu
Date: Mon, 6 Feb 2017 15:16:09 -0500
Message-ID: <87993944-5fcf-1684-1003-366b15e735b8@amd.com>
References: <20170204045142.5596-1-andresx7@gmail.com>
 <20170204045142.5596-6-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2102864466=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170204045142.5596-6-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org, John.Bridgman-5C7GfCeVMHo@public.gmane.org

--===============2102864466==
Content-Type: multipart/alternative;
	boundary="------------247C2427837F2982E6D2D25C"

--------------247C2427837F2982E6D2D25C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

In the current KFD branch, we changed our equivalent of the MQD commit
function to copy most of the MQD registers in a loop and just update a
few registers manually to get the right programming sequence and work
around some HW errata. We were told that this is what the HW scheduler
does as well. You can see this on github:

    https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/blob/roc-1.4.x/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c#L364

Regards,
  Felix

On 17-02-03 11:51 PM, Andres Rodriguez wrote:
> Use the same gfx_*_mqd_commit function for kfd and amdgpu codepaths.
>
> This removes the last duplicates of this programming sequence.
>
> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 51 ++---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 49 ++--------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 38 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h             |  5 +++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 44 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h             |  5 +++
>  6 files changed, 97 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 1a0a5f7..038b7ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -29,6 +29,7 @@
>  #include "cikd.h"
>  #include "cik_sdma.h"
>  #include "amdgpu_ucode.h"
> +#include "gfx_v7_0.h"
>  #include "gca/gfx_7_2_d.h"
>  #include "gca/gfx_7_2_enum.h"
>  #include "gca/gfx_7_2_sh_mask.h"
> @@ -309,55 +310,11 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  	m = get_mqd(mqd);
>  
>  	is_wptr_shadow_valid = !get_user(wptr_shadow, wptr);
> -
> -	acquire_queue(kgd, pipe_id, queue_id);
> -	WREG32(mmCP_MQD_BASE_ADDR, m->cp_mqd_base_addr_lo);
> -	WREG32(mmCP_MQD_BASE_ADDR_HI, m->cp_mqd_base_addr_hi);
> -	WREG32(mmCP_MQD_CONTROL, m->cp_mqd_control);
> -
> -	WREG32(mmCP_HQD_PQ_BASE, m->cp_hqd_pq_base_lo);
> -	WREG32(mmCP_HQD_PQ_BASE_HI, m->cp_hqd_pq_base_hi);
> -	WREG32(mmCP_HQD_PQ_CONTROL, m->cp_hqd_pq_control);
> -
> -	WREG32(mmCP_HQD_IB_CONTROL, m->cp_hqd_ib_control);
> -	WREG32(mmCP_HQD_IB_BASE_ADDR, m->cp_hqd_ib_base_addr_lo);
> -	WREG32(mmCP_HQD_IB_BASE_ADDR_HI, m->cp_hqd_ib_base_addr_hi);
> -
> -	WREG32(mmCP_HQD_IB_RPTR, m->cp_hqd_ib_rptr);
> -
> -	WREG32(mmCP_HQD_PERSISTENT_STATE, m->cp_hqd_persistent_state);
> -	WREG32(mmCP_HQD_SEMA_CMD, m->cp_hqd_sema_cmd);
> -	WREG32(mmCP_HQD_MSG_TYPE, m->cp_hqd_msg_type);
> -
> -	WREG32(mmCP_HQD_ATOMIC0_PREOP_LO, m->cp_hqd_atomic0_preop_lo);
> -	WREG32(mmCP_HQD_ATOMIC0_PREOP_HI, m->cp_hqd_atomic0_preop_hi);
> -	WREG32(mmCP_HQD_ATOMIC1_PREOP_LO, m->cp_hqd_atomic1_preop_lo);
> -	WREG32(mmCP_HQD_ATOMIC1_PREOP_HI, m->cp_hqd_atomic1_preop_hi);
> -
> -	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR, m->cp_hqd_pq_rptr_report_addr_lo);
> -	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
> -			m->cp_hqd_pq_rptr_report_addr_hi);
> -
> -	WREG32(mmCP_HQD_PQ_RPTR, m->cp_hqd_pq_rptr);
> -
> -	WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR, m->cp_hqd_pq_wptr_poll_addr_lo);
> -	WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR_HI, m->cp_hqd_pq_wptr_poll_addr_hi);
> -
> -	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, m->cp_hqd_pq_doorbell_control);
> -
> -	WREG32(mmCP_HQD_VMID, m->cp_hqd_vmid);
> -
> -	WREG32(mmCP_HQD_QUANTUM, m->cp_hqd_quantum);
> -
> -	WREG32(mmCP_HQD_PIPE_PRIORITY, m->cp_hqd_pipe_priority);
> -	WREG32(mmCP_HQD_QUEUE_PRIORITY, m->cp_hqd_queue_priority);
> -
> -	WREG32(mmCP_HQD_IQ_RPTR, m->cp_hqd_iq_rptr);
> -
>  	if (is_wptr_shadow_valid)
> -		WREG32(mmCP_HQD_PQ_WPTR, wptr_shadow);
> +		m->cp_hqd_pq_wptr = wptr_shadow;
>  
> -	WREG32(mmCP_HQD_ACTIVE, m->cp_hqd_active);
> +	acquire_queue(kgd, pipe_id, queue_id);
> +	gfx_v7_0_mqd_commit(adev, m);
>  	release_queue(kgd);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index 6697612..2ecef3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_ucode.h"
> +#include "gfx_v8_0.h"
>  #include "gca/gfx_8_0_sh_mask.h"
>  #include "gca/gfx_8_0_d.h"
>  #include "gca/gfx_8_0_enum.h"
> @@ -251,53 +252,11 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  	m = get_mqd(mqd);
>  
>  	valid_wptr = copy_from_user(&shadow_wptr, wptr, sizeof(shadow_wptr));
> -	acquire_queue(kgd, pipe_id, queue_id);
> -
> -	WREG32(mmCP_MQD_CONTROL, m->cp_mqd_control);
> -	WREG32(mmCP_MQD_BASE_ADDR, m->cp_mqd_base_addr_lo);
> -	WREG32(mmCP_MQD_BASE_ADDR_HI, m->cp_mqd_base_addr_hi);
> -
> -	WREG32(mmCP_HQD_VMID, m->cp_hqd_vmid);
> -	WREG32(mmCP_HQD_PERSISTENT_STATE, m->cp_hqd_persistent_state);
> -	WREG32(mmCP_HQD_PIPE_PRIORITY, m->cp_hqd_pipe_priority);
> -	WREG32(mmCP_HQD_QUEUE_PRIORITY, m->cp_hqd_queue_priority);
> -	WREG32(mmCP_HQD_QUANTUM, m->cp_hqd_quantum);
> -	WREG32(mmCP_HQD_PQ_BASE, m->cp_hqd_pq_base_lo);
> -	WREG32(mmCP_HQD_PQ_BASE_HI, m->cp_hqd_pq_base_hi);
> -	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR, m->cp_hqd_pq_rptr_report_addr_lo);
> -	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
> -			m->cp_hqd_pq_rptr_report_addr_hi);
> -
>  	if (valid_wptr > 0)
> -		WREG32(mmCP_HQD_PQ_WPTR, shadow_wptr);
> -
> -	WREG32(mmCP_HQD_PQ_CONTROL, m->cp_hqd_pq_control);
> -	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, m->cp_hqd_pq_doorbell_control);
> -
> -	WREG32(mmCP_HQD_EOP_BASE_ADDR, m->cp_hqd_eop_base_addr_lo);
> -	WREG32(mmCP_HQD_EOP_BASE_ADDR_HI, m->cp_hqd_eop_base_addr_hi);
> -	WREG32(mmCP_HQD_EOP_CONTROL, m->cp_hqd_eop_control);
> -	WREG32(mmCP_HQD_EOP_RPTR, m->cp_hqd_eop_rptr);
> -	WREG32(mmCP_HQD_EOP_WPTR, m->cp_hqd_eop_wptr);
> -	WREG32(mmCP_HQD_EOP_EVENTS, m->cp_hqd_eop_done_events);
> -
> -	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO, m->cp_hqd_ctx_save_base_addr_lo);
> -	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI, m->cp_hqd_ctx_save_base_addr_hi);
> -	WREG32(mmCP_HQD_CTX_SAVE_CONTROL, m->cp_hqd_ctx_save_control);
> -	WREG32(mmCP_HQD_CNTL_STACK_OFFSET, m->cp_hqd_cntl_stack_offset);
> -	WREG32(mmCP_HQD_CNTL_STACK_SIZE, m->cp_hqd_cntl_stack_size);
> -	WREG32(mmCP_HQD_WG_STATE_OFFSET, m->cp_hqd_wg_state_offset);
> -	WREG32(mmCP_HQD_CTX_SAVE_SIZE, m->cp_hqd_ctx_save_size);
> -
> -	WREG32(mmCP_HQD_IB_CONTROL, m->cp_hqd_ib_control);
> -
> -	WREG32(mmCP_HQD_DEQUEUE_REQUEST, m->cp_hqd_dequeue_request);
> -	WREG32(mmCP_HQD_ERROR, m->cp_hqd_error);
> -	WREG32(mmCP_HQD_EOP_WPTR_MEM, m->cp_hqd_eop_wptr_mem);
> -	WREG32(mmCP_HQD_EOP_DONES, m->cp_hqd_eop_dones);
> -
> -	WREG32(mmCP_HQD_ACTIVE, m->cp_hqd_active);
> +		m->cp_hqd_pq_wptr = valid_wptr;
>  
> +	acquire_queue(kgd, pipe_id, queue_id);
> +	gfx_v8_0_mqd_commit(adev, mqd);
>  	release_queue(kgd);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 4a279bb..d226804 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3038,12 +3038,29 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
>  	/* set the vmid for the queue */
>  	mqd->cp_hqd_vmid = 0;
>  
> +	/* defaults */
> +	mqd->cp_hqd_ib_control = RREG32(mmCP_HQD_IB_CONTROL);
> +	mqd->cp_hqd_ib_base_addr_lo = RREG32(mmCP_HQD_IB_BASE_ADDR);
> +	mqd->cp_hqd_ib_base_addr_hi = RREG32(mmCP_HQD_IB_BASE_ADDR_HI);
> +	mqd->cp_hqd_ib_rptr = RREG32(mmCP_HQD_IB_RPTR);
> +	mqd->cp_hqd_persistent_state = RREG32(mmCP_HQD_PERSISTENT_STATE);
> +	mqd->cp_hqd_sema_cmd = RREG32(mmCP_HQD_SEMA_CMD);
> +	mqd->cp_hqd_msg_type = RREG32(mmCP_HQD_MSG_TYPE);
> +	mqd->cp_hqd_atomic0_preop_lo = RREG32(mmCP_HQD_ATOMIC0_PREOP_LO);
> +	mqd->cp_hqd_atomic0_preop_hi = RREG32(mmCP_HQD_ATOMIC0_PREOP_HI);
> +	mqd->cp_hqd_atomic1_preop_lo = RREG32(mmCP_HQD_ATOMIC1_PREOP_LO);
> +	mqd->cp_hqd_atomic1_preop_hi = RREG32(mmCP_HQD_ATOMIC1_PREOP_HI);
> +	mqd->cp_hqd_pq_rptr = RREG32(mmCP_HQD_PQ_RPTR);
> +	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> +	mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
> +	mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
> +	mqd->cp_hqd_iq_rptr = RREG32(mmCP_HQD_IQ_RPTR);
> +
>  	/* activate the queue */
>  	mqd->cp_hqd_active = 1;
>  }
>  
> -static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev,
> -			       struct cik_mqd *mqd)
> +int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
>  {
>  	u32 tmp;
>  
> @@ -3067,6 +3084,23 @@ static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev,
>  	WREG32(mmCP_HQD_PQ_WPTR, mqd->cp_hqd_pq_wptr);
>  	WREG32(mmCP_HQD_VMID, mqd->cp_hqd_vmid);
>  
> +	WREG32(mmCP_HQD_IB_CONTROL, mqd->cp_hqd_ib_control);
> +	WREG32(mmCP_HQD_IB_BASE_ADDR, mqd->cp_hqd_ib_base_addr_lo);
> +	WREG32(mmCP_HQD_IB_BASE_ADDR_HI, mqd->cp_hqd_ib_base_addr_hi);
> +	WREG32(mmCP_HQD_IB_RPTR, mqd->cp_hqd_ib_rptr);
> +	WREG32(mmCP_HQD_PERSISTENT_STATE, mqd->cp_hqd_persistent_state);
> +	WREG32(mmCP_HQD_SEMA_CMD, mqd->cp_hqd_sema_cmd);
> +	WREG32(mmCP_HQD_MSG_TYPE, mqd->cp_hqd_msg_type);
> +	WREG32(mmCP_HQD_ATOMIC0_PREOP_LO, mqd->cp_hqd_atomic0_preop_lo);
> +	WREG32(mmCP_HQD_ATOMIC0_PREOP_HI, mqd->cp_hqd_atomic0_preop_hi);
> +	WREG32(mmCP_HQD_ATOMIC1_PREOP_LO, mqd->cp_hqd_atomic1_preop_lo);
> +	WREG32(mmCP_HQD_ATOMIC1_PREOP_HI, mqd->cp_hqd_atomic1_preop_hi);
> +	WREG32(mmCP_HQD_PQ_RPTR, mqd->cp_hqd_pq_rptr);
> +	WREG32(mmCP_HQD_QUANTUM, mqd->cp_hqd_quantum);
> +	WREG32(mmCP_HQD_PIPE_PRIORITY, mqd->cp_hqd_pipe_priority);
> +	WREG32(mmCP_HQD_QUEUE_PRIORITY, mqd->cp_hqd_queue_priority);
> +	WREG32(mmCP_HQD_IQ_RPTR, mqd->cp_hqd_iq_rptr);
> +
>  	/* activate the HQD */
>  	WREG32(mmCP_HQD_ACTIVE, mqd->cp_hqd_active);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h
> index 2f5164c..6fb9c15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h
> @@ -29,4 +29,9 @@ extern const struct amdgpu_ip_block_version gfx_v7_1_ip_block;
>  extern const struct amdgpu_ip_block_version gfx_v7_2_ip_block;
>  extern const struct amdgpu_ip_block_version gfx_v7_3_ip_block;
>  
> +struct amdgpu_device;
> +struct cik_mqd;
> +
> +int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 442cd66..7755d58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4762,6 +4762,26 @@ static int gfx_v8_0_mqd_init(struct amdgpu_device *adev,
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
>  	mqd->cp_hqd_persistent_state = tmp;
>  
> +	/* defaults */
> +	mqd->cp_hqd_eop_rptr = RREG32(mmCP_HQD_EOP_RPTR);
> +	mqd->cp_hqd_eop_wptr = RREG32(mmCP_HQD_EOP_WPTR);
> +	mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
> +	mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
> +	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> +	mqd->cp_hqd_ctx_save_base_addr_lo = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);
> +	mqd->cp_hqd_ctx_save_base_addr_hi = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);
> +	mqd->cp_hqd_ctx_save_control = RREG32(mmCP_HQD_CTX_SAVE_CONTROL);
> +	mqd->cp_hqd_cntl_stack_offset = RREG32(mmCP_HQD_CNTL_STACK_OFFSET);
> +	mqd->cp_hqd_cntl_stack_size = RREG32(mmCP_HQD_CNTL_STACK_SIZE);
> +	mqd->cp_hqd_wg_state_offset = RREG32(mmCP_HQD_WG_STATE_OFFSET);
> +	mqd->cp_hqd_ctx_save_size = RREG32(mmCP_HQD_CTX_SAVE_SIZE);
> +	mqd->cp_hqd_ib_control = RREG32(mmCP_HQD_IB_CONTROL);
> +	mqd->cp_hqd_eop_done_events = RREG32(mmCP_HQD_EOP_EVENTS);
> +	mqd->cp_hqd_error = RREG32(mmCP_HQD_ERROR);
> +	mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
> +	mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
> +
> +
>  	/* activate the queue */
>  	mqd->cp_hqd_active = 1;
>  
> @@ -4815,7 +4835,7 @@ static void gfx_v8_0_enable_doorbell(struct amdgpu_device *adev, bool enable)
>  	adev->doorbell_enabled = true;
>  }
>  
> -static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd)
> +int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd)
>  {
>  	uint32_t tmp;
>  
> @@ -4867,6 +4887,28 @@ static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd)
>  
>  	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>  	WREG32(mmCP_HQD_PQ_WPTR, mqd->cp_hqd_pq_wptr);
> +	WREG32(mmCP_HQD_EOP_RPTR, mqd->cp_hqd_eop_rptr);
> +	WREG32(mmCP_HQD_EOP_WPTR, mqd->cp_hqd_eop_wptr);
> +
> +	/* set the HQD priority */
> +	WREG32(mmCP_HQD_PIPE_PRIORITY, mqd->cp_hqd_pipe_priority);
> +	WREG32(mmCP_HQD_QUEUE_PRIORITY, mqd->cp_hqd_queue_priority);
> +	WREG32(mmCP_HQD_QUANTUM, mqd->cp_hqd_quantum);
> +
> +	/* set cwsr save area */
> +	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO, mqd->cp_hqd_ctx_save_base_addr_lo);
> +	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI, mqd->cp_hqd_ctx_save_base_addr_hi);
> +	WREG32(mmCP_HQD_CTX_SAVE_CONTROL, mqd->cp_hqd_ctx_save_control);
> +	WREG32(mmCP_HQD_CNTL_STACK_OFFSET, mqd->cp_hqd_cntl_stack_offset);
> +	WREG32(mmCP_HQD_CNTL_STACK_SIZE, mqd->cp_hqd_cntl_stack_size);
> +	WREG32(mmCP_HQD_WG_STATE_OFFSET, mqd->cp_hqd_wg_state_offset);
> +	WREG32(mmCP_HQD_CTX_SAVE_SIZE, mqd->cp_hqd_ctx_save_size);
> +
> +	WREG32(mmCP_HQD_IB_CONTROL, mqd->cp_hqd_ib_control);
> +	WREG32(mmCP_HQD_EOP_EVENTS, mqd->cp_hqd_eop_done_events);
> +	WREG32(mmCP_HQD_ERROR, mqd->cp_hqd_error);
> +	WREG32(mmCP_HQD_EOP_WPTR_MEM, mqd->cp_hqd_eop_wptr_mem);
> +	WREG32(mmCP_HQD_EOP_DONES, mqd->cp_hqd_eop_dones);
>  
>  	/* set the vmid for the queue */
>  	WREG32(mmCP_HQD_VMID, mqd->cp_hqd_vmid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h
> index 788cc3a..ec3f11f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h
> @@ -27,4 +27,9 @@
>  extern const struct amdgpu_ip_block_version gfx_v8_0_ip_block;
>  extern const struct amdgpu_ip_block_version gfx_v8_1_ip_block;
>  
> +struct amdgpu_device;
> +struct vi_mqd;
> +
> +int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd);
> +
>  #endif


--------------247C2427837F2982E6D2D25C
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>In the current KFD branch, we changed our equivalent of the MQD
      commit function to copy most of the MQD registers in a loop and
      just update a few registers manually to get the right programming
      sequence and work around some HW errata. We were told that this is
      what the HW scheduler does as well. You can see this on github:</p>
    <blockquote>
      <p><a class="moz-txt-link-freetext" href="https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/blob/roc-1.4.x/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c#L364">https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/blob/roc-1.4.x/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c#L364</a></p>
    </blockquote>
    Regards,<br>
      Felix<br>
    <br>
    <div class="moz-cite-prefix">On 17-02-03 11:51 PM, Andres Rodriguez
      wrote:<br>
    </div>
    <blockquote cite="mid:20170204045142.5596-6-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">
      <pre wrap="">Use the same gfx_*_mqd_commit function for kfd and amdgpu codepaths.

This removes the last duplicates of this programming sequence.

Signed-off-by: Andres Rodriguez <a class="moz-txt-link-rfc2396E" href="mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 51 ++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 49 ++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 38 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h             |  5 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 44 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h             |  5 +++
 6 files changed, 97 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 1a0a5f7..038b7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -29,6 +29,7 @@
 #include "cikd.h"
 #include "cik_sdma.h"
 #include "amdgpu_ucode.h"
+#include "gfx_v7_0.h"
 #include "gca/gfx_7_2_d.h"
 #include "gca/gfx_7_2_enum.h"
 #include "gca/gfx_7_2_sh_mask.h"
@@ -309,55 +310,11 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	m = get_mqd(mqd);
 
 	is_wptr_shadow_valid = !get_user(wptr_shadow, wptr);
-
-	acquire_queue(kgd, pipe_id, queue_id);
-	WREG32(mmCP_MQD_BASE_ADDR, m-&gt;cp_mqd_base_addr_lo);
-	WREG32(mmCP_MQD_BASE_ADDR_HI, m-&gt;cp_mqd_base_addr_hi);
-	WREG32(mmCP_MQD_CONTROL, m-&gt;cp_mqd_control);
-
-	WREG32(mmCP_HQD_PQ_BASE, m-&gt;cp_hqd_pq_base_lo);
-	WREG32(mmCP_HQD_PQ_BASE_HI, m-&gt;cp_hqd_pq_base_hi);
-	WREG32(mmCP_HQD_PQ_CONTROL, m-&gt;cp_hqd_pq_control);
-
-	WREG32(mmCP_HQD_IB_CONTROL, m-&gt;cp_hqd_ib_control);
-	WREG32(mmCP_HQD_IB_BASE_ADDR, m-&gt;cp_hqd_ib_base_addr_lo);
-	WREG32(mmCP_HQD_IB_BASE_ADDR_HI, m-&gt;cp_hqd_ib_base_addr_hi);
-
-	WREG32(mmCP_HQD_IB_RPTR, m-&gt;cp_hqd_ib_rptr);
-
-	WREG32(mmCP_HQD_PERSISTENT_STATE, m-&gt;cp_hqd_persistent_state);
-	WREG32(mmCP_HQD_SEMA_CMD, m-&gt;cp_hqd_sema_cmd);
-	WREG32(mmCP_HQD_MSG_TYPE, m-&gt;cp_hqd_msg_type);
-
-	WREG32(mmCP_HQD_ATOMIC0_PREOP_LO, m-&gt;cp_hqd_atomic0_preop_lo);
-	WREG32(mmCP_HQD_ATOMIC0_PREOP_HI, m-&gt;cp_hqd_atomic0_preop_hi);
-	WREG32(mmCP_HQD_ATOMIC1_PREOP_LO, m-&gt;cp_hqd_atomic1_preop_lo);
-	WREG32(mmCP_HQD_ATOMIC1_PREOP_HI, m-&gt;cp_hqd_atomic1_preop_hi);
-
-	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR, m-&gt;cp_hqd_pq_rptr_report_addr_lo);
-	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
-			m-&gt;cp_hqd_pq_rptr_report_addr_hi);
-
-	WREG32(mmCP_HQD_PQ_RPTR, m-&gt;cp_hqd_pq_rptr);
-
-	WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR, m-&gt;cp_hqd_pq_wptr_poll_addr_lo);
-	WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR_HI, m-&gt;cp_hqd_pq_wptr_poll_addr_hi);
-
-	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, m-&gt;cp_hqd_pq_doorbell_control);
-
-	WREG32(mmCP_HQD_VMID, m-&gt;cp_hqd_vmid);
-
-	WREG32(mmCP_HQD_QUANTUM, m-&gt;cp_hqd_quantum);
-
-	WREG32(mmCP_HQD_PIPE_PRIORITY, m-&gt;cp_hqd_pipe_priority);
-	WREG32(mmCP_HQD_QUEUE_PRIORITY, m-&gt;cp_hqd_queue_priority);
-
-	WREG32(mmCP_HQD_IQ_RPTR, m-&gt;cp_hqd_iq_rptr);
-
 	if (is_wptr_shadow_valid)
-		WREG32(mmCP_HQD_PQ_WPTR, wptr_shadow);
+		m-&gt;cp_hqd_pq_wptr = wptr_shadow;
 
-	WREG32(mmCP_HQD_ACTIVE, m-&gt;cp_hqd_active);
+	acquire_queue(kgd, pipe_id, queue_id);
+	gfx_v7_0_mqd_commit(adev, m);
 	release_queue(kgd);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 6697612..2ecef3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_ucode.h"
+#include "gfx_v8_0.h"
 #include "gca/gfx_8_0_sh_mask.h"
 #include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_enum.h"
@@ -251,53 +252,11 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	m = get_mqd(mqd);
 
 	valid_wptr = copy_from_user(&amp;shadow_wptr, wptr, sizeof(shadow_wptr));
-	acquire_queue(kgd, pipe_id, queue_id);
-
-	WREG32(mmCP_MQD_CONTROL, m-&gt;cp_mqd_control);
-	WREG32(mmCP_MQD_BASE_ADDR, m-&gt;cp_mqd_base_addr_lo);
-	WREG32(mmCP_MQD_BASE_ADDR_HI, m-&gt;cp_mqd_base_addr_hi);
-
-	WREG32(mmCP_HQD_VMID, m-&gt;cp_hqd_vmid);
-	WREG32(mmCP_HQD_PERSISTENT_STATE, m-&gt;cp_hqd_persistent_state);
-	WREG32(mmCP_HQD_PIPE_PRIORITY, m-&gt;cp_hqd_pipe_priority);
-	WREG32(mmCP_HQD_QUEUE_PRIORITY, m-&gt;cp_hqd_queue_priority);
-	WREG32(mmCP_HQD_QUANTUM, m-&gt;cp_hqd_quantum);
-	WREG32(mmCP_HQD_PQ_BASE, m-&gt;cp_hqd_pq_base_lo);
-	WREG32(mmCP_HQD_PQ_BASE_HI, m-&gt;cp_hqd_pq_base_hi);
-	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR, m-&gt;cp_hqd_pq_rptr_report_addr_lo);
-	WREG32(mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
-			m-&gt;cp_hqd_pq_rptr_report_addr_hi);
-
 	if (valid_wptr &gt; 0)
-		WREG32(mmCP_HQD_PQ_WPTR, shadow_wptr);
-
-	WREG32(mmCP_HQD_PQ_CONTROL, m-&gt;cp_hqd_pq_control);
-	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, m-&gt;cp_hqd_pq_doorbell_control);
-
-	WREG32(mmCP_HQD_EOP_BASE_ADDR, m-&gt;cp_hqd_eop_base_addr_lo);
-	WREG32(mmCP_HQD_EOP_BASE_ADDR_HI, m-&gt;cp_hqd_eop_base_addr_hi);
-	WREG32(mmCP_HQD_EOP_CONTROL, m-&gt;cp_hqd_eop_control);
-	WREG32(mmCP_HQD_EOP_RPTR, m-&gt;cp_hqd_eop_rptr);
-	WREG32(mmCP_HQD_EOP_WPTR, m-&gt;cp_hqd_eop_wptr);
-	WREG32(mmCP_HQD_EOP_EVENTS, m-&gt;cp_hqd_eop_done_events);
-
-	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO, m-&gt;cp_hqd_ctx_save_base_addr_lo);
-	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI, m-&gt;cp_hqd_ctx_save_base_addr_hi);
-	WREG32(mmCP_HQD_CTX_SAVE_CONTROL, m-&gt;cp_hqd_ctx_save_control);
-	WREG32(mmCP_HQD_CNTL_STACK_OFFSET, m-&gt;cp_hqd_cntl_stack_offset);
-	WREG32(mmCP_HQD_CNTL_STACK_SIZE, m-&gt;cp_hqd_cntl_stack_size);
-	WREG32(mmCP_HQD_WG_STATE_OFFSET, m-&gt;cp_hqd_wg_state_offset);
-	WREG32(mmCP_HQD_CTX_SAVE_SIZE, m-&gt;cp_hqd_ctx_save_size);
-
-	WREG32(mmCP_HQD_IB_CONTROL, m-&gt;cp_hqd_ib_control);
-
-	WREG32(mmCP_HQD_DEQUEUE_REQUEST, m-&gt;cp_hqd_dequeue_request);
-	WREG32(mmCP_HQD_ERROR, m-&gt;cp_hqd_error);
-	WREG32(mmCP_HQD_EOP_WPTR_MEM, m-&gt;cp_hqd_eop_wptr_mem);
-	WREG32(mmCP_HQD_EOP_DONES, m-&gt;cp_hqd_eop_dones);
-
-	WREG32(mmCP_HQD_ACTIVE, m-&gt;cp_hqd_active);
+		m-&gt;cp_hqd_pq_wptr = valid_wptr;
 
+	acquire_queue(kgd, pipe_id, queue_id);
+	gfx_v8_0_mqd_commit(adev, mqd);
 	release_queue(kgd);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 4a279bb..d226804 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3038,12 +3038,29 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
 	/* set the vmid for the queue */
 	mqd-&gt;cp_hqd_vmid = 0;
 
+	/* defaults */
+	mqd-&gt;cp_hqd_ib_control = RREG32(mmCP_HQD_IB_CONTROL);
+	mqd-&gt;cp_hqd_ib_base_addr_lo = RREG32(mmCP_HQD_IB_BASE_ADDR);
+	mqd-&gt;cp_hqd_ib_base_addr_hi = RREG32(mmCP_HQD_IB_BASE_ADDR_HI);
+	mqd-&gt;cp_hqd_ib_rptr = RREG32(mmCP_HQD_IB_RPTR);
+	mqd-&gt;cp_hqd_persistent_state = RREG32(mmCP_HQD_PERSISTENT_STATE);
+	mqd-&gt;cp_hqd_sema_cmd = RREG32(mmCP_HQD_SEMA_CMD);
+	mqd-&gt;cp_hqd_msg_type = RREG32(mmCP_HQD_MSG_TYPE);
+	mqd-&gt;cp_hqd_atomic0_preop_lo = RREG32(mmCP_HQD_ATOMIC0_PREOP_LO);
+	mqd-&gt;cp_hqd_atomic0_preop_hi = RREG32(mmCP_HQD_ATOMIC0_PREOP_HI);
+	mqd-&gt;cp_hqd_atomic1_preop_lo = RREG32(mmCP_HQD_ATOMIC1_PREOP_LO);
+	mqd-&gt;cp_hqd_atomic1_preop_hi = RREG32(mmCP_HQD_ATOMIC1_PREOP_HI);
+	mqd-&gt;cp_hqd_pq_rptr = RREG32(mmCP_HQD_PQ_RPTR);
+	mqd-&gt;cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	mqd-&gt;cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
+	mqd-&gt;cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
+	mqd-&gt;cp_hqd_iq_rptr = RREG32(mmCP_HQD_IQ_RPTR);
+
 	/* activate the queue */
 	mqd-&gt;cp_hqd_active = 1;
 }
 
-static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev,
-			       struct cik_mqd *mqd)
+int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
 {
 	u32 tmp;
 
@@ -3067,6 +3084,23 @@ static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev,
 	WREG32(mmCP_HQD_PQ_WPTR, mqd-&gt;cp_hqd_pq_wptr);
 	WREG32(mmCP_HQD_VMID, mqd-&gt;cp_hqd_vmid);
 
+	WREG32(mmCP_HQD_IB_CONTROL, mqd-&gt;cp_hqd_ib_control);
+	WREG32(mmCP_HQD_IB_BASE_ADDR, mqd-&gt;cp_hqd_ib_base_addr_lo);
+	WREG32(mmCP_HQD_IB_BASE_ADDR_HI, mqd-&gt;cp_hqd_ib_base_addr_hi);
+	WREG32(mmCP_HQD_IB_RPTR, mqd-&gt;cp_hqd_ib_rptr);
+	WREG32(mmCP_HQD_PERSISTENT_STATE, mqd-&gt;cp_hqd_persistent_state);
+	WREG32(mmCP_HQD_SEMA_CMD, mqd-&gt;cp_hqd_sema_cmd);
+	WREG32(mmCP_HQD_MSG_TYPE, mqd-&gt;cp_hqd_msg_type);
+	WREG32(mmCP_HQD_ATOMIC0_PREOP_LO, mqd-&gt;cp_hqd_atomic0_preop_lo);
+	WREG32(mmCP_HQD_ATOMIC0_PREOP_HI, mqd-&gt;cp_hqd_atomic0_preop_hi);
+	WREG32(mmCP_HQD_ATOMIC1_PREOP_LO, mqd-&gt;cp_hqd_atomic1_preop_lo);
+	WREG32(mmCP_HQD_ATOMIC1_PREOP_HI, mqd-&gt;cp_hqd_atomic1_preop_hi);
+	WREG32(mmCP_HQD_PQ_RPTR, mqd-&gt;cp_hqd_pq_rptr);
+	WREG32(mmCP_HQD_QUANTUM, mqd-&gt;cp_hqd_quantum);
+	WREG32(mmCP_HQD_PIPE_PRIORITY, mqd-&gt;cp_hqd_pipe_priority);
+	WREG32(mmCP_HQD_QUEUE_PRIORITY, mqd-&gt;cp_hqd_queue_priority);
+	WREG32(mmCP_HQD_IQ_RPTR, mqd-&gt;cp_hqd_iq_rptr);
+
 	/* activate the HQD */
 	WREG32(mmCP_HQD_ACTIVE, mqd-&gt;cp_hqd_active);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h
index 2f5164c..6fb9c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.h
@@ -29,4 +29,9 @@ extern const struct amdgpu_ip_block_version gfx_v7_1_ip_block;
 extern const struct amdgpu_ip_block_version gfx_v7_2_ip_block;
 extern const struct amdgpu_ip_block_version gfx_v7_3_ip_block;
 
+struct amdgpu_device;
+struct cik_mqd;
+
+int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 442cd66..7755d58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4762,6 +4762,26 @@ static int gfx_v8_0_mqd_init(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
 	mqd-&gt;cp_hqd_persistent_state = tmp;
 
+	/* defaults */
+	mqd-&gt;cp_hqd_eop_rptr = RREG32(mmCP_HQD_EOP_RPTR);
+	mqd-&gt;cp_hqd_eop_wptr = RREG32(mmCP_HQD_EOP_WPTR);
+	mqd-&gt;cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
+	mqd-&gt;cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
+	mqd-&gt;cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	mqd-&gt;cp_hqd_ctx_save_base_addr_lo = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);
+	mqd-&gt;cp_hqd_ctx_save_base_addr_hi = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);
+	mqd-&gt;cp_hqd_ctx_save_control = RREG32(mmCP_HQD_CTX_SAVE_CONTROL);
+	mqd-&gt;cp_hqd_cntl_stack_offset = RREG32(mmCP_HQD_CNTL_STACK_OFFSET);
+	mqd-&gt;cp_hqd_cntl_stack_size = RREG32(mmCP_HQD_CNTL_STACK_SIZE);
+	mqd-&gt;cp_hqd_wg_state_offset = RREG32(mmCP_HQD_WG_STATE_OFFSET);
+	mqd-&gt;cp_hqd_ctx_save_size = RREG32(mmCP_HQD_CTX_SAVE_SIZE);
+	mqd-&gt;cp_hqd_ib_control = RREG32(mmCP_HQD_IB_CONTROL);
+	mqd-&gt;cp_hqd_eop_done_events = RREG32(mmCP_HQD_EOP_EVENTS);
+	mqd-&gt;cp_hqd_error = RREG32(mmCP_HQD_ERROR);
+	mqd-&gt;cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
+	mqd-&gt;cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
+
+
 	/* activate the queue */
 	mqd-&gt;cp_hqd_active = 1;
 
@@ -4815,7 +4835,7 @@ static void gfx_v8_0_enable_doorbell(struct amdgpu_device *adev, bool enable)
 	adev-&gt;doorbell_enabled = true;
 }
 
-static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd)
+int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd)
 {
 	uint32_t tmp;
 
@@ -4867,6 +4887,28 @@ static int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	WREG32(mmCP_HQD_PQ_WPTR, mqd-&gt;cp_hqd_pq_wptr);
+	WREG32(mmCP_HQD_EOP_RPTR, mqd-&gt;cp_hqd_eop_rptr);
+	WREG32(mmCP_HQD_EOP_WPTR, mqd-&gt;cp_hqd_eop_wptr);
+
+	/* set the HQD priority */
+	WREG32(mmCP_HQD_PIPE_PRIORITY, mqd-&gt;cp_hqd_pipe_priority);
+	WREG32(mmCP_HQD_QUEUE_PRIORITY, mqd-&gt;cp_hqd_queue_priority);
+	WREG32(mmCP_HQD_QUANTUM, mqd-&gt;cp_hqd_quantum);
+
+	/* set cwsr save area */
+	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO, mqd-&gt;cp_hqd_ctx_save_base_addr_lo);
+	WREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI, mqd-&gt;cp_hqd_ctx_save_base_addr_hi);
+	WREG32(mmCP_HQD_CTX_SAVE_CONTROL, mqd-&gt;cp_hqd_ctx_save_control);
+	WREG32(mmCP_HQD_CNTL_STACK_OFFSET, mqd-&gt;cp_hqd_cntl_stack_offset);
+	WREG32(mmCP_HQD_CNTL_STACK_SIZE, mqd-&gt;cp_hqd_cntl_stack_size);
+	WREG32(mmCP_HQD_WG_STATE_OFFSET, mqd-&gt;cp_hqd_wg_state_offset);
+	WREG32(mmCP_HQD_CTX_SAVE_SIZE, mqd-&gt;cp_hqd_ctx_save_size);
+
+	WREG32(mmCP_HQD_IB_CONTROL, mqd-&gt;cp_hqd_ib_control);
+	WREG32(mmCP_HQD_EOP_EVENTS, mqd-&gt;cp_hqd_eop_done_events);
+	WREG32(mmCP_HQD_ERROR, mqd-&gt;cp_hqd_error);
+	WREG32(mmCP_HQD_EOP_WPTR_MEM, mqd-&gt;cp_hqd_eop_wptr_mem);
+	WREG32(mmCP_HQD_EOP_DONES, mqd-&gt;cp_hqd_eop_dones);
 
 	/* set the vmid for the queue */
 	WREG32(mmCP_HQD_VMID, mqd-&gt;cp_hqd_vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h
index 788cc3a..ec3f11f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.h
@@ -27,4 +27,9 @@
 extern const struct amdgpu_ip_block_version gfx_v8_0_ip_block;
 extern const struct amdgpu_ip_block_version gfx_v8_1_ip_block;
 
+struct amdgpu_device;
+struct vi_mqd;
+
+int gfx_v8_0_mqd_commit(struct amdgpu_device *adev, struct vi_mqd *mqd);
+
 #endif
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------247C2427837F2982E6D2D25C--

--===============2102864466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2102864466==--
