From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 16/21] drm/amdkfd: Add 64-bit doorbell and wptr support to
 kernel queue
Date: Tue, 24 Apr 2018 17:42:51 -0400
Message-ID: <ba222e85-d524-d611-0efe-11850ba48ff3@amd.com>
References: <1523395998-31314-1-git-send-email-Felix.Kuehling@amd.com>
 <1523395998-31314-17-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F219CD68EFA57F240BF3F343"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523395998-31314-17-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

This is a multi-part message in MIME format.
--------------F219CD68EFA57F240BF3F343
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A minor update to this patch is attached. The rest of the series is
unchanged and rebased cleanly on 4.17-rc2 on my system.

Regards,
  Felix


On 2018-04-10 05:33 PM, Felix Kuehling wrote:
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c         | 10 +++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c     | 25 +++++++++++++++++------
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h     |  7 ++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c |  9 ++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  |  9 ++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c  |  9 ++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h             |  1 +
>  7 files changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 36c9269e..5d7cccc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -214,6 +214,16 @@ void write_kernel_doorbell(void __iomem *db, u32 value)
>  	}
>  }
>  
> +void write_kernel_doorbell64(void __iomem *db, u64 value)
> +{
> +	if (db) {
> +		WARN(((unsigned long)db & 7) != 0,
> +		     "Unaligned 64-bit doorbell");
> +		writeq(value, (u64 __iomem *)db);
> +		pr_debug("writing %llu to doorbell address 0x%p\n", value, db);+	}
> +}
> +
>  unsigned int kfd_doorbell_id_to_offset(struct kfd_dev *kfd,
>  					struct kfd_process *process,
>  					unsigned int doorbell_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 9f38161..476951d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -99,7 +99,7 @@ static bool initialize(struct kernel_queue *kq, struct kfd_dev *dev,
>  	kq->rptr_kernel = kq->rptr_mem->cpu_ptr;
>  	kq->rptr_gpu_addr = kq->rptr_mem->gpu_addr;
>  
> -	retval = kfd_gtt_sa_allocate(dev, sizeof(*kq->wptr_kernel),
> +	retval = kfd_gtt_sa_allocate(dev, dev->device_info->doorbell_size,
>  					&kq->wptr_mem);
>  
>  	if (retval != 0)
> @@ -208,6 +208,7 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
>  	size_t available_size;
>  	size_t queue_size_dwords;
>  	uint32_t wptr, rptr;
> +	uint64_t wptr64;
>  	unsigned int *queue_address;
>  
>  	/* When rptr == wptr, the buffer is empty.
> @@ -216,7 +217,8 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
>  	 * the opposite. So we can only use up to queue_size_dwords - 1 dwords.
>  	 */
>  	rptr = *kq->rptr_kernel;
> -	wptr = *kq->wptr_kernel;
> +	wptr = kq->pending_wptr;
> +	wptr64 = kq->pending_wptr64;
>  	queue_address = (unsigned int *)kq->pq_kernel_addr;
>  	queue_size_dwords = kq->queue->properties.queue_size / 4;
>  
> @@ -246,11 +248,13 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
>  		while (wptr > 0) {
>  			queue_address[wptr] = kq->nop_packet;
>  			wptr = (wptr + 1) % queue_size_dwords;
> +			wptr64++;
>  		}
>  	}
>  
>  	*buffer_ptr = &queue_address[wptr];
>  	kq->pending_wptr = wptr + packet_size_in_dwords;
> +	kq->pending_wptr64 = wptr64 + packet_size_in_dwords;
>  
>  	return 0;
>  
> @@ -272,14 +276,18 @@ static void submit_packet(struct kernel_queue *kq)
>  	pr_debug("\n");
>  #endif
>  
> -	*kq->wptr_kernel = kq->pending_wptr;
> -	write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
> -				kq->pending_wptr);
> +	kq->ops_asic_specific.submit_packet(kq);
>  }
>  
>  static void rollback_packet(struct kernel_queue *kq)
>  {
> -	kq->pending_wptr = *kq->wptr_kernel;
> +	if (kq->dev->device_info->doorbell_size == 8) {
> +		kq->pending_wptr64 = *kq->wptr64_kernel;
> +		kq->pending_wptr = *kq->wptr_kernel %
> +			(kq->queue->properties.queue_size / 4);
> +	} else {
> +		kq->pending_wptr = *kq->wptr_kernel;
> +	}
>  }
>  
>  struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
> @@ -310,6 +318,11 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
>  	case CHIP_HAWAII:
>  		kernel_queue_init_cik(&kq->ops_asic_specific);
>  		break;
> +
> +	case CHIP_VEGA10:
> +	case CHIP_RAVEN:
> +		kernel_queue_init_v9(&kq->ops_asic_specific);
> +		break;
>  	default:
>  		WARN(1, "Unexpected ASIC family %u",
>  		     dev->device_info->asic_family);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
> index 5940531..97aff20 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
> @@ -72,6 +72,7 @@ struct kernel_queue {
>  	struct kfd_dev		*dev;
>  	struct mqd_manager	*mqd;
>  	struct queue		*queue;
> +	uint64_t		pending_wptr64;
>  	uint32_t		pending_wptr;
>  	unsigned int		nop_packet;
>  
> @@ -79,7 +80,10 @@ struct kernel_queue {
>  	uint32_t		*rptr_kernel;
>  	uint64_t		rptr_gpu_addr;
>  	struct kfd_mem_obj	*wptr_mem;
> -	uint32_t		*wptr_kernel;
> +	union {
> +		uint64_t	*wptr64_kernel;
> +		uint32_t	*wptr_kernel;
> +	};
>  	uint64_t		wptr_gpu_addr;
>  	struct kfd_mem_obj	*pq;
>  	uint64_t		pq_gpu_addr;
> @@ -97,5 +101,6 @@ struct kernel_queue {
>  
>  void kernel_queue_init_cik(struct kernel_queue_ops *ops);
>  void kernel_queue_init_vi(struct kernel_queue_ops *ops);
> +void kernel_queue_init_v9(struct kernel_queue_ops *ops);
>  
>  #endif /* KFD_KERNEL_QUEUE_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c
> index a90eb44..19e54ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c
> @@ -26,11 +26,13 @@
>  static bool initialize_cik(struct kernel_queue *kq, struct kfd_dev *dev,
>  			enum kfd_queue_type type, unsigned int queue_size);
>  static void uninitialize_cik(struct kernel_queue *kq);
> +static void submit_packet_cik(struct kernel_queue *kq);
>  
>  void kernel_queue_init_cik(struct kernel_queue_ops *ops)
>  {
>  	ops->initialize = initialize_cik;
>  	ops->uninitialize = uninitialize_cik;
> +	ops->submit_packet = submit_packet_cik;
>  }
>  
>  static bool initialize_cik(struct kernel_queue *kq, struct kfd_dev *dev,
> @@ -42,3 +44,10 @@ static bool initialize_cik(struct kernel_queue *kq, struct kfd_dev *dev,
>  static void uninitialize_cik(struct kernel_queue *kq)
>  {
>  }
> +
> +static void submit_packet_cik(struct kernel_queue *kq)
> +{
> +	*kq->wptr_kernel = kq->pending_wptr;
> +	write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
> +				kq->pending_wptr);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> index ece7d59..684a3bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> @@ -29,11 +29,13 @@
>  static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,
>  			enum kfd_queue_type type, unsigned int queue_size);
>  static void uninitialize_v9(struct kernel_queue *kq);
> +static void submit_packet_v9(struct kernel_queue *kq);
>  
>  void kernel_queue_init_v9(struct kernel_queue_ops *ops)
>  {
>  	ops->initialize = initialize_v9;
>  	ops->uninitialize = uninitialize_v9;
> +	ops->submit_packet = submit_packet_v9;
>  }
>  
>  static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,
> @@ -58,6 +60,13 @@ static void uninitialize_v9(struct kernel_queue *kq)
>  	kfd_gtt_sa_free(kq->dev, kq->eop_mem);
>  }
>  
> +static void submit_packet_v9(struct kernel_queue *kq)
> +{
> +	*kq->wptr64_kernel = kq->pending_wptr64;
> +	write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
> +				kq->pending_wptr64);
> +}
> +
>  static int pm_map_process_v9(struct packet_manager *pm,
>  		uint32_t *buffer, struct qcm_process_device *qpd)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> index f9019ef..bf20c6d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
> @@ -29,11 +29,13 @@
>  static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,
>  			enum kfd_queue_type type, unsigned int queue_size);
>  static void uninitialize_vi(struct kernel_queue *kq);
> +static void submit_packet_vi(struct kernel_queue *kq);
>  
>  void kernel_queue_init_vi(struct kernel_queue_ops *ops)
>  {
>  	ops->initialize = initialize_vi;
>  	ops->uninitialize = uninitialize_vi;
> +	ops->submit_packet = submit_packet_vi;
>  }
>  
>  static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,
> @@ -58,6 +60,13 @@ static void uninitialize_vi(struct kernel_queue *kq)
>  	kfd_gtt_sa_free(kq->dev, kq->eop_mem);
>  }
>  
> +static void submit_packet_vi(struct kernel_queue *kq)
> +{
> +	*kq->wptr_kernel = kq->pending_wptr;
> +	write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
> +				kq->pending_wptr);
> +}
> +
>  unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
>  {
>  	union PM4_MES_TYPE_3_HEADER header;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 06b210b..10d5b54 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -769,6 +769,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>  void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr);
>  u32 read_kernel_doorbell(u32 __iomem *db);
>  void write_kernel_doorbell(void __iomem *db, u32 value);
> +void write_kernel_doorbell64(void __iomem *db, u64 value);
>  unsigned int kfd_doorbell_id_to_offset(struct kfd_dev *kfd,
>  					struct kfd_process *process,
>  					unsigned int doorbell_id);


--------------F219CD68EFA57F240BF3F343
Content-Type: text/x-patch;
 name="0001-drm-amdkfd-Add-64-bit-doorbell-and-wptr-support-to-k.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amdkfd-Add-64-bit-doorbell-and-wptr-support-to-k.pa";
 filename*1="tch"

>From 6ef689698ee1599a5c72e2fbfa3c1b6b5e532cd9 Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Sun, 8 Apr 2018 22:03:51 -0400
Subject: [PATCH 1/1] drm/amdkfd: Add 64-bit doorbell and wptr support to
 kernel queue

v2: Removed redundant 0x before %p.

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c         | 10 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c     | 25 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h     |  7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c |  9 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  |  9 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c  |  9 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h             |  1 +
 7 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 36c9269e..c3744d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -214,6 +214,16 @@ void write_kernel_doorbell(void __iomem *db, u32 value)
 	}
 }
 
+void write_kernel_doorbell64(void __iomem *db, u64 value)
+{
+	if (db) {
+		WARN(((unsigned long)db & 7) != 0,
+		     "Unaligned 64-bit doorbell");
+		writeq(value, (u64 __iomem *)db);
+		pr_debug("writing %llu to doorbell address %p\n", value, db);
+	}
+}
+
 unsigned int kfd_doorbell_id_to_offset(struct kfd_dev *kfd,
 					struct kfd_process *process,
 					unsigned int doorbell_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 9f38161..476951d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -99,7 +99,7 @@ static bool initialize(struct kernel_queue *kq, struct kfd_dev *dev,
 	kq->rptr_kernel = kq->rptr_mem->cpu_ptr;
 	kq->rptr_gpu_addr = kq->rptr_mem->gpu_addr;
 
-	retval = kfd_gtt_sa_allocate(dev, sizeof(*kq->wptr_kernel),
+	retval = kfd_gtt_sa_allocate(dev, dev->device_info->doorbell_size,
 					&kq->wptr_mem);
 
 	if (retval != 0)
@@ -208,6 +208,7 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
 	size_t available_size;
 	size_t queue_size_dwords;
 	uint32_t wptr, rptr;
+	uint64_t wptr64;
 	unsigned int *queue_address;
 
 	/* When rptr == wptr, the buffer is empty.
@@ -216,7 +217,8 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
 	 * the opposite. So we can only use up to queue_size_dwords - 1 dwords.
 	 */
 	rptr = *kq->rptr_kernel;
-	wptr = *kq->wptr_kernel;
+	wptr = kq->pending_wptr;
+	wptr64 = kq->pending_wptr64;
 	queue_address = (unsigned int *)kq->pq_kernel_addr;
 	queue_size_dwords = kq->queue->properties.queue_size / 4;
 
@@ -246,11 +248,13 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
 		while (wptr > 0) {
 			queue_address[wptr] = kq->nop_packet;
 			wptr = (wptr + 1) % queue_size_dwords;
+			wptr64++;
 		}
 	}
 
 	*buffer_ptr = &queue_address[wptr];
 	kq->pending_wptr = wptr + packet_size_in_dwords;
+	kq->pending_wptr64 = wptr64 + packet_size_in_dwords;
 
 	return 0;
 
@@ -272,14 +276,18 @@ static void submit_packet(struct kernel_queue *kq)
 	pr_debug("\n");
 #endif
 
-	*kq->wptr_kernel = kq->pending_wptr;
-	write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
-				kq->pending_wptr);
+	kq->ops_asic_specific.submit_packet(kq);
 }
 
 static void rollback_packet(struct kernel_queue *kq)
 {
-	kq->pending_wptr = *kq->wptr_kernel;
+	if (kq->dev->device_info->doorbell_size == 8) {
+		kq->pending_wptr64 = *kq->wptr64_kernel;
+		kq->pending_wptr = *kq->wptr_kernel %
+			(kq->queue->properties.queue_size / 4);
+	} else {
+		kq->pending_wptr = *kq->wptr_kernel;
+	}
 }
 
 struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
@@ -310,6 +318,11 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 	case CHIP_HAWAII:
 		kernel_queue_init_cik(&kq->ops_asic_specific);
 		break;
+
+	case CHIP_VEGA10:
+	case CHIP_RAVEN:
+		kernel_queue_init_v9(&kq->ops_asic_specific);
+		break;
 	default:
 		WARN(1, "Unexpected ASIC family %u",
 		     dev->device_info->asic_family);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
index 5940531..97aff20 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
@@ -72,6 +72,7 @@ struct kernel_queue {
 	struct kfd_dev		*dev;
 	struct mqd_manager	*mqd;
 	struct queue		*queue;
+	uint64_t		pending_wptr64;
 	uint32_t		pending_wptr;
 	unsigned int		nop_packet;
 
@@ -79,7 +80,10 @@ struct kernel_queue {
 	uint32_t		*rptr_kernel;
 	uint64_t		rptr_gpu_addr;
 	struct kfd_mem_obj	*wptr_mem;
-	uint32_t		*wptr_kernel;
+	union {
+		uint64_t	*wptr64_kernel;
+		uint32_t	*wptr_kernel;
+	};
 	uint64_t		wptr_gpu_addr;
 	struct kfd_mem_obj	*pq;
 	uint64_t		pq_gpu_addr;
@@ -97,5 +101,6 @@ struct kernel_queue {
 
 void kernel_queue_init_cik(struct kernel_queue_ops *ops);
 void kernel_queue_init_vi(struct kernel_queue_ops *ops);
+void kernel_queue_init_v9(struct kernel_queue_ops *ops);
 
 #endif /* KFD_KERNEL_QUEUE_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c
index a90eb44..19e54ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_cik.c
@@ -26,11 +26,13 @@
 static bool initialize_cik(struct kernel_queue *kq, struct kfd_dev *dev,
 			enum kfd_queue_type type, unsigned int queue_size);
 static void uninitialize_cik(struct kernel_queue *kq);
+static void submit_packet_cik(struct kernel_queue *kq);
 
 void kernel_queue_init_cik(struct kernel_queue_ops *ops)
 {
 	ops->initialize = initialize_cik;
 	ops->uninitialize = uninitialize_cik;
+	ops->submit_packet = submit_packet_cik;
 }
 
 static bool initialize_cik(struct kernel_queue *kq, struct kfd_dev *dev,
@@ -42,3 +44,10 @@ static bool initialize_cik(struct kernel_queue *kq, struct kfd_dev *dev,
 static void uninitialize_cik(struct kernel_queue *kq)
 {
 }
+
+static void submit_packet_cik(struct kernel_queue *kq)
+{
+	*kq->wptr_kernel = kq->pending_wptr;
+	write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
+				kq->pending_wptr);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
index ece7d59..684a3bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
@@ -29,11 +29,13 @@
 static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,
 			enum kfd_queue_type type, unsigned int queue_size);
 static void uninitialize_v9(struct kernel_queue *kq);
+static void submit_packet_v9(struct kernel_queue *kq);
 
 void kernel_queue_init_v9(struct kernel_queue_ops *ops)
 {
 	ops->initialize = initialize_v9;
 	ops->uninitialize = uninitialize_v9;
+	ops->submit_packet = submit_packet_v9;
 }
 
 static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,
@@ -58,6 +60,13 @@ static void uninitialize_v9(struct kernel_queue *kq)
 	kfd_gtt_sa_free(kq->dev, kq->eop_mem);
 }
 
+static void submit_packet_v9(struct kernel_queue *kq)
+{
+	*kq->wptr64_kernel = kq->pending_wptr64;
+	write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
+				kq->pending_wptr64);
+}
+
 static int pm_map_process_v9(struct packet_manager *pm,
 		uint32_t *buffer, struct qcm_process_device *qpd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
index f9019ef..bf20c6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c
@@ -29,11 +29,13 @@
 static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,
 			enum kfd_queue_type type, unsigned int queue_size);
 static void uninitialize_vi(struct kernel_queue *kq);
+static void submit_packet_vi(struct kernel_queue *kq);
 
 void kernel_queue_init_vi(struct kernel_queue_ops *ops)
 {
 	ops->initialize = initialize_vi;
 	ops->uninitialize = uninitialize_vi;
+	ops->submit_packet = submit_packet_vi;
 }
 
 static bool initialize_vi(struct kernel_queue *kq, struct kfd_dev *dev,
@@ -58,6 +60,13 @@ static void uninitialize_vi(struct kernel_queue *kq)
 	kfd_gtt_sa_free(kq->dev, kq->eop_mem);
 }
 
+static void submit_packet_vi(struct kernel_queue *kq)
+{
+	*kq->wptr_kernel = kq->pending_wptr;
+	write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
+				kq->pending_wptr);
+}
+
 unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
 {
 	union PM4_MES_TYPE_3_HEADER header;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 06b210b..10d5b54 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -769,6 +769,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr);
 u32 read_kernel_doorbell(u32 __iomem *db);
 void write_kernel_doorbell(void __iomem *db, u32 value);
+void write_kernel_doorbell64(void __iomem *db, u64 value);
 unsigned int kfd_doorbell_id_to_offset(struct kfd_dev *kfd,
 					struct kfd_process *process,
 					unsigned int doorbell_id);
-- 
2.7.4


--------------F219CD68EFA57F240BF3F343
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------F219CD68EFA57F240BF3F343--
