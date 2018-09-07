From: ozeng <ozeng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Moved fault hash table to amdgpu vm
Date: Fri, 7 Sep 2018 00:16:55 -0400
Message-ID: <12913b70-925d-2e17-2dc2-491ed8592610@amd.com>
References: <1536290910-6476-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0235621114=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536290910-6476-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Oak Zeng <zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: oak.zeng-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--===============0235621114==
Content-Type: multipart/alternative;
 boundary="------------7D9C35A99FD1DFBEFCB32E78"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7D9C35A99FD1DFBEFCB32E78
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

In this implementation, fault hash is made per vm, not per pasid as 
suggested, based on below considerations:

  * Delay the destroy of hash introduces more effort like how to set the
    proper grace period after which no retry interrupt will be
    generated. We want to avoid those complication if we can.
  * The  problem of the per vm implementation is that it is hard to
    delay the destroy of fault hash, because when vm is destroyed,
    prescreen function won't be able to retrieve the fault hash. But in
    this case, the prescreen function can either let the interrupt go
    through (to gmc) or ignore it. From this perspective, it is not very
    necessary to delay the destroy of hash table.
  * On the other hand, since ASICs after vega10 have the HW CAM feature.
    So the SW IV prescreen is only useful for vega10. For all the HW
    implemented CAM, we can consider the delayed CAM acknowledgment.
  * Making it per pasid need to introduce another idr to correlate pasid
    and hash table - where to put the idr? You will have to make it a
    global variable which is not very desirable.

The main purpose of this patch is to solve the inter-process lock issue 
(when hash table is full), while still keep codes simple.

Also with this patch, the faults kfifo is not necessary any more. See 
patch 2.

Regards,

Oak


On 09/06/2018 11:28 PM, Oak Zeng wrote:
> In stead of share one fault hash table per device, make it
> per vm. This can avoid inter-process lock issue when fault
> hash table is full.
>
> Change-Id: I5d1281b7c41eddc8e26113e010516557588d3708
> Signed-off-by: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Christian Konig <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c |  75 ------------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  10 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 102 ++++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  12 ++++
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  38 +++++-------
>   5 files changed, 127 insertions(+), 110 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index 06373d4..4ed8621 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -197,78 +197,3 @@ int amdgpu_ih_process(struct amdgpu_device *adev)
>   	return IRQ_HANDLED;
>   }
>   
> -/**
> - * amdgpu_ih_add_fault - Add a page fault record
> - *
> - * @adev: amdgpu device pointer
> - * @key: 64-bit encoding of PASID and address
> - *
> - * This should be called when a retry page fault interrupt is
> - * received. If this is a new page fault, it will be added to a hash
> - * table. The return value indicates whether this is a new fault, or
> - * a fault that was already known and is already being handled.
> - *
> - * If there are too many pending page faults, this will fail. Retry
> - * interrupts should be ignored in this case until there is enough
> - * free space.
> - *
> - * Returns 0 if the fault was added, 1 if the fault was already known,
> - * -ENOSPC if there are too many pending faults.
> - */
> -int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key)
> -{
> -	unsigned long flags;
> -	int r = -ENOSPC;
> -
> -	if (WARN_ON_ONCE(!adev->irq.ih.faults))
> -		/* Should be allocated in <IP>_ih_sw_init on GPUs that
> -		 * support retry faults and require retry filtering.
> -		 */
> -		return r;
> -
> -	spin_lock_irqsave(&adev->irq.ih.faults->lock, flags);
> -
> -	/* Only let the hash table fill up to 50% for best performance */
> -	if (adev->irq.ih.faults->count >= (1 << (AMDGPU_PAGEFAULT_HASH_BITS-1)))
> -		goto unlock_out;
> -
> -	r = chash_table_copy_in(&adev->irq.ih.faults->hash, key, NULL);
> -	if (!r)
> -		adev->irq.ih.faults->count++;
> -
> -	/* chash_table_copy_in should never fail unless we're losing count */
> -	WARN_ON_ONCE(r < 0);
> -
> -unlock_out:
> -	spin_unlock_irqrestore(&adev->irq.ih.faults->lock, flags);
> -	return r;
> -}
> -
> -/**
> - * amdgpu_ih_clear_fault - Remove a page fault record
> - *
> - * @adev: amdgpu device pointer
> - * @key: 64-bit encoding of PASID and address
> - *
> - * This should be called when a page fault has been handled. Any
> - * future interrupt with this key will be processed as a new
> - * page fault.
> - */
> -void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key)
> -{
> -	unsigned long flags;
> -	int r;
> -
> -	if (!adev->irq.ih.faults)
> -		return;
> -
> -	spin_lock_irqsave(&adev->irq.ih.faults->lock, flags);
> -
> -	r = chash_table_remove(&adev->irq.ih.faults->hash, key, NULL);
> -	if (!WARN_ON_ONCE(r < 0)) {
> -		adev->irq.ih.faults->count--;
> -		WARN_ON_ONCE(adev->irq.ih.faults->count < 0);
> -	}
> -
> -	spin_unlock_irqrestore(&adev->irq.ih.faults->lock, flags);
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index a23e1c0..f411ffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -32,13 +32,6 @@ struct amdgpu_device;
>   #define AMDGPU_IH_CLIENTID_LEGACY 0
>   #define AMDGPU_IH_CLIENTID_MAX SOC15_IH_CLIENTID_MAX
>   
> -#define AMDGPU_PAGEFAULT_HASH_BITS 8
> -struct amdgpu_retryfault_hashtable {
> -	DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
> -	spinlock_t	lock;
> -	int		count;
> -};
> -
>   /*
>    * R6xx+ IH ring
>    */
> @@ -57,7 +50,6 @@ struct amdgpu_ih_ring {
>   	bool			use_doorbell;
>   	bool			use_bus_addr;
>   	dma_addr_t		rb_dma_addr; /* only used when use_bus_addr = true */
> -	struct amdgpu_retryfault_hashtable *faults;
>   };
>   
>   #define AMDGPU_IH_SRC_DATA_MAX_SIZE_DW 4
> @@ -95,7 +87,5 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, unsigned ring_size,
>   			bool use_bus_addr);
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev);
>   int amdgpu_ih_process(struct amdgpu_device *adev);
> -int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key);
> -void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1d7e3c1..8b220e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2692,6 +2692,22 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   		 adev->vm_manager.fragment_size);
>   }
>   
> +static struct amdgpu_retryfault_hashtable *init_fault_hash(void)
> +{
> +	struct amdgpu_retryfault_hashtable *fault_hash;
> +
> +	fault_hash = kmalloc(sizeof(*fault_hash), GFP_KERNEL);
> +	if (!fault_hash)
> +		return fault_hash;
> +
> +	INIT_CHASH_TABLE(fault_hash->hash,
> +			AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
> +	spin_lock_init(&fault_hash->lock);
> +	fault_hash->count = 0;
> +
> +	return fault_hash;
> +}
> +
>   /**
>    * amdgpu_vm_init - initialize a vm instance
>    *
> @@ -2780,6 +2796,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		vm->pasid = pasid;
>   	}
>   
> +	vm->fault_hash = init_fault_hash();
> +	if (!vm->fault_hash) {
> +		r = -ENOMEM;
> +		goto error_free_root;
> +	}
> +
>   	INIT_KFIFO(vm->faults);
>   	vm->fault_credit = 16;
>   
> @@ -2973,7 +2995,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	/* Clear pending page faults from IH when the VM is destroyed */
>   	while (kfifo_get(&vm->faults, &fault))
> -		amdgpu_ih_clear_fault(adev, fault);
> +		amdgpu_vm_clear_fault(vm->fault_hash, fault);
>   
>   	if (vm->pasid) {
>   		unsigned long flags;
> @@ -2983,6 +3005,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>   	}
>   
> +	kfree(vm->fault_hash);
> +	vm->fault_hash = NULL;
> +
>   	drm_sched_entity_destroy(&vm->entity);
>   
>   	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
> @@ -3183,3 +3208,78 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   		}
>   	}
>   }
> +
> +/**
> + * amdgpu_vm_add_fault - Add a page fault record to fault hash table
> + *
> + * @fault_hash: fault hash table
> + * @key: 64-bit encoding of PASID and address
> + *
> + * This should be called when a retry page fault interrupt is
> + * received. If this is a new page fault, it will be added to a hash
> + * table. The return value indicates whether this is a new fault, or
> + * a fault that was already known and is already being handled.
> + *
> + * If there are too many pending page faults, this will fail. Retry
> + * interrupts should be ignored in this case until there is enough
> + * free space.
> + *
> + * Returns 0 if the fault was added, 1 if the fault was already known,
> + * -ENOSPC if there are too many pending faults.
> + */
> +int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)
> +{
> +	unsigned long flags;
> +	int r = -ENOSPC;
> +
> +	if (WARN_ON_ONCE(!fault_hash))
> +		/* Should be allocated in amdgpu_vm_init
> +		 */
> +		return r;
> +
> +	spin_lock_irqsave(&fault_hash->lock, flags);
> +
> +	/* Only let the hash table fill up to 50% for best performance */
> +	if (fault_hash->count >= (1 << (AMDGPU_PAGEFAULT_HASH_BITS-1)))
> +		goto unlock_out;
> +
> +	r = chash_table_copy_in(&fault_hash->hash, key, NULL);
> +	if (!r)
> +		fault_hash->count++;
> +
> +	/* chash_table_copy_in should never fail unless we're losing count */
> +	WARN_ON_ONCE(r < 0);
> +
> +unlock_out:
> +	spin_unlock_irqrestore(&fault_hash->lock, flags);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_vm_clear_fault - Remove a page fault record
> + *
> + * @fault_hash: fault hash table
> + * @key: 64-bit encoding of PASID and address
> + *
> + * This should be called when a page fault has been handled. Any
> + * future interrupt with this key will be processed as a new
> + * page fault.
> + */
> +void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)
> +{
> +	unsigned long flags;
> +	int r;
> +
> +	if (!fault_hash)
> +		return;
> +
> +	spin_lock_irqsave(&fault_hash->lock, flags);
> +
> +	r = chash_table_remove(&fault_hash->hash, key, NULL);
> +	if (!WARN_ON_ONCE(r < 0)) {
> +		fault_hash->count--;
> +		WARN_ON_ONCE(fault_hash->count < 0);
> +	}
> +
> +	spin_unlock_irqrestore(&fault_hash->lock, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index e275ee7..6eb1da1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -178,6 +178,13 @@ struct amdgpu_task_info {
>   	pid_t	tgid;
>   };
>   
> +#define AMDGPU_PAGEFAULT_HASH_BITS 8
> +struct amdgpu_retryfault_hashtable {
> +	DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
> +	spinlock_t	lock;
> +	int		count;
> +};
> +
>   struct amdgpu_vm {
>   	/* tree of virtual addresses mapped */
>   	struct rb_root_cached	va;
> @@ -240,6 +247,7 @@ struct amdgpu_vm {
>   	struct ttm_lru_bulk_move lru_bulk_move;
>   	/* mark whether can do the bulk move */
>   	bool			bulk_moveable;
> +	struct amdgpu_retryfault_hashtable *fault_hash;
>   };
>   
>   struct amdgpu_vm_manager {
> @@ -355,4 +363,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>   void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   
> +int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);
> +
> +void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 5ae5ed2..acbe5a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -265,35 +265,36 @@ static bool vega10_ih_prescreen_iv(struct amdgpu_device *adev)
>   		return true;
>   	}
>   
> -	addr = ((u64)(dw5 & 0xf) << 44) | ((u64)dw4 << 12);
> -	key = AMDGPU_VM_FAULT(pasid, addr);
> -	r = amdgpu_ih_add_fault(adev, key);
> -
> -	/* Hash table is full or the fault is already being processed,
> -	 * ignore further page faults
> -	 */
> -	if (r != 0)
> -		goto ignore_iv;
> -
>   	/* Track retry faults in per-VM fault FIFO. */
>   	spin_lock(&adev->vm_manager.pasid_lock);
>   	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	addr = ((u64)(dw5 & 0xf) << 44) | ((u64)dw4 << 12);
> +	key = AMDGPU_VM_FAULT(pasid, addr);
>   	if (!vm) {
>   		/* VM not found, process it normally */
>   		spin_unlock(&adev->vm_manager.pasid_lock);
> -		amdgpu_ih_clear_fault(adev, key);
>   		return true;
> +	} else {
> +		r = amdgpu_vm_add_fault(vm->fault_hash, key);
> +
> +		/* Hash table is full or the fault is already being processed,
> +		 * ignore further page faults
> +		 */
> +		if (r != 0) {
> +			spin_unlock(&adev->vm_manager.pasid_lock);
> +			goto ignore_iv;
> +		}
>   	}
>   	/* No locking required with single writer and single reader */
>   	r = kfifo_put(&vm->faults, key);
>   	if (!r) {
>   		/* FIFO is full. Ignore it until there is space */
> +		amdgpu_vm_clear_fault(vm->fault_hash, key);
>   		spin_unlock(&adev->vm_manager.pasid_lock);
> -		amdgpu_ih_clear_fault(adev, key);
>   		goto ignore_iv;
>   	}
> -	spin_unlock(&adev->vm_manager.pasid_lock);
>   
> +	spin_unlock(&adev->vm_manager.pasid_lock);
>   	/* It's the first fault for this address, process it normally */
>   	return true;
>   
> @@ -386,14 +387,6 @@ static int vega10_ih_sw_init(void *handle)
>   	adev->irq.ih.use_doorbell = true;
>   	adev->irq.ih.doorbell_index = AMDGPU_DOORBELL64_IH << 1;
>   
> -	adev->irq.ih.faults = kmalloc(sizeof(*adev->irq.ih.faults), GFP_KERNEL);
> -	if (!adev->irq.ih.faults)
> -		return -ENOMEM;
> -	INIT_CHASH_TABLE(adev->irq.ih.faults->hash,
> -			 AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
> -	spin_lock_init(&adev->irq.ih.faults->lock);
> -	adev->irq.ih.faults->count = 0;
> -
>   	r = amdgpu_irq_init(adev);
>   
>   	return r;
> @@ -406,9 +399,6 @@ static int vega10_ih_sw_fini(void *handle)
>   	amdgpu_irq_fini(adev);
>   	amdgpu_ih_ring_fini(adev);
>   
> -	kfree(adev->irq.ih.faults);
> -	adev->irq.ih.faults = NULL;
> -
>   	return 0;
>   }
>   


--------------7D9C35A99FD1DFBEFCB32E78
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Christian, <br>
    </p>
    <p>In this implementation, fault hash is made per vm, not per pasid
      as suggested, based on below considerations:</p>
    <ul>
      <li>Delay the destroy of hash introduces more effort like how to
        set the proper grace period after which no retry interrupt will
        be generated. We want to avoid those complication if we can. </li>
      <li>The  problem of the per vm implementation is that it is hard
        to delay the destroy of fault hash, because when vm is
        destroyed, prescreen function won't be able to retrieve the
        fault hash. But in this case, the prescreen function can either
        let the interrupt go through (to gmc) or ignore it. From this
        perspective, it is not very necessary to delay the destroy of
        hash table. </li>
      <li>On the other hand, since ASICs after vega10 have the HW CAM
        feature. So the SW IV prescreen is only useful for vega10. For
        all the HW implemented CAM, we can consider the delayed CAM
        acknowledgment. </li>
      <li>Making it per pasid need to introduce another idr to correlate
        pasid and hash table - where to put the idr? You will have to
        make it a global variable which is not very desirable. <br>
      </li>
    </ul>
    <p>The main purpose of this patch is to solve the inter-process lock
      issue (when hash table is full), while still keep codes simple.</p>
    <p>Also with this patch, the faults kfifo is not necessary any more.
      See patch 2. <br>
    </p>
    <p>Regards,</p>
    <p>Oak<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 09/06/2018 11:28 PM, Oak Zeng wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1536290910-6476-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">In stead of share one fault hash table per device, make it
per vm. This can avoid inter-process lock issue when fault
hash table is full.

Change-Id: I5d1281b7c41eddc8e26113e010516557588d3708
Signed-off-by: Oak Zeng <a class="moz-txt-link-rfc2396E" href="mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">&lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;</a>
Suggested-by: Christian Konig <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Suggested-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c |  75 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  10 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 102 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  12 ++++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  38 +++++-------
 5 files changed, 127 insertions(+), 110 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 06373d4..4ed8621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -197,78 +197,3 @@ int amdgpu_ih_process(struct amdgpu_device *adev)
 	return IRQ_HANDLED;
 }
 
-/**
- * amdgpu_ih_add_fault - Add a page fault record
- *
- * @adev: amdgpu device pointer
- * @key: 64-bit encoding of PASID and address
- *
- * This should be called when a retry page fault interrupt is
- * received. If this is a new page fault, it will be added to a hash
- * table. The return value indicates whether this is a new fault, or
- * a fault that was already known and is already being handled.
- *
- * If there are too many pending page faults, this will fail. Retry
- * interrupts should be ignored in this case until there is enough
- * free space.
- *
- * Returns 0 if the fault was added, 1 if the fault was already known,
- * -ENOSPC if there are too many pending faults.
- */
-int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key)
-{
-	unsigned long flags;
-	int r = -ENOSPC;
-
-	if (WARN_ON_ONCE(!adev-&gt;irq.ih.faults))
-		/* Should be allocated in &lt;IP&gt;_ih_sw_init on GPUs that
-		 * support retry faults and require retry filtering.
-		 */
-		return r;
-
-	spin_lock_irqsave(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);
-
-	/* Only let the hash table fill up to 50% for best performance */
-	if (adev-&gt;irq.ih.faults-&gt;count &gt;= (1 &lt;&lt; (AMDGPU_PAGEFAULT_HASH_BITS-1)))
-		goto unlock_out;
-
-	r = chash_table_copy_in(&amp;adev-&gt;irq.ih.faults-&gt;hash, key, NULL);
-	if (!r)
-		adev-&gt;irq.ih.faults-&gt;count++;
-
-	/* chash_table_copy_in should never fail unless we're losing count */
-	WARN_ON_ONCE(r &lt; 0);
-
-unlock_out:
-	spin_unlock_irqrestore(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);
-	return r;
-}
-
-/**
- * amdgpu_ih_clear_fault - Remove a page fault record
- *
- * @adev: amdgpu device pointer
- * @key: 64-bit encoding of PASID and address
- *
- * This should be called when a page fault has been handled. Any
- * future interrupt with this key will be processed as a new
- * page fault.
- */
-void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key)
-{
-	unsigned long flags;
-	int r;
-
-	if (!adev-&gt;irq.ih.faults)
-		return;
-
-	spin_lock_irqsave(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);
-
-	r = chash_table_remove(&amp;adev-&gt;irq.ih.faults-&gt;hash, key, NULL);
-	if (!WARN_ON_ONCE(r &lt; 0)) {
-		adev-&gt;irq.ih.faults-&gt;count--;
-		WARN_ON_ONCE(adev-&gt;irq.ih.faults-&gt;count &lt; 0);
-	}
-
-	spin_unlock_irqrestore(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index a23e1c0..f411ffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -32,13 +32,6 @@ struct amdgpu_device;
 #define AMDGPU_IH_CLIENTID_LEGACY 0
 #define AMDGPU_IH_CLIENTID_MAX SOC15_IH_CLIENTID_MAX
 
-#define AMDGPU_PAGEFAULT_HASH_BITS 8
-struct amdgpu_retryfault_hashtable {
-	DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
-	spinlock_t	lock;
-	int		count;
-};
-
 /*
  * R6xx+ IH ring
  */
@@ -57,7 +50,6 @@ struct amdgpu_ih_ring {
 	bool			use_doorbell;
 	bool			use_bus_addr;
 	dma_addr_t		rb_dma_addr; /* only used when use_bus_addr = true */
-	struct amdgpu_retryfault_hashtable *faults;
 };
 
 #define AMDGPU_IH_SRC_DATA_MAX_SIZE_DW 4
@@ -95,7 +87,5 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, unsigned ring_size,
 			bool use_bus_addr);
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev);
 int amdgpu_ih_process(struct amdgpu_device *adev);
-int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key);
-void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1d7e3c1..8b220e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2692,6 +2692,22 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 		 adev-&gt;vm_manager.fragment_size);
 }
 
+static struct amdgpu_retryfault_hashtable *init_fault_hash(void)
+{
+	struct amdgpu_retryfault_hashtable *fault_hash;
+
+	fault_hash = kmalloc(sizeof(*fault_hash), GFP_KERNEL);
+	if (!fault_hash)
+		return fault_hash;
+
+	INIT_CHASH_TABLE(fault_hash-&gt;hash,
+			AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
+	spin_lock_init(&amp;fault_hash-&gt;lock);
+	fault_hash-&gt;count = 0;
+
+	return fault_hash;
+}
+
 /**
  * amdgpu_vm_init - initialize a vm instance
  *
@@ -2780,6 +2796,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		vm-&gt;pasid = pasid;
 	}
 
+	vm-&gt;fault_hash = init_fault_hash();
+	if (!vm-&gt;fault_hash) {
+		r = -ENOMEM;
+		goto error_free_root;
+	}
+
 	INIT_KFIFO(vm-&gt;faults);
 	vm-&gt;fault_credit = 16;
 
@@ -2973,7 +2995,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	/* Clear pending page faults from IH when the VM is destroyed */
 	while (kfifo_get(&amp;vm-&gt;faults, &amp;fault))
-		amdgpu_ih_clear_fault(adev, fault);
+		amdgpu_vm_clear_fault(vm-&gt;fault_hash, fault);
 
 	if (vm-&gt;pasid) {
 		unsigned long flags;
@@ -2983,6 +3005,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock, flags);
 	}
 
+	kfree(vm-&gt;fault_hash);
+	vm-&gt;fault_hash = NULL;
+
 	drm_sched_entity_destroy(&amp;vm-&gt;entity);
 
 	if (!RB_EMPTY_ROOT(&amp;vm-&gt;va.rb_root)) {
@@ -3183,3 +3208,78 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 		}
 	}
 }
+
+/**
+ * amdgpu_vm_add_fault - Add a page fault record to fault hash table
+ *
+ * @fault_hash: fault hash table
+ * @key: 64-bit encoding of PASID and address
+ *
+ * This should be called when a retry page fault interrupt is
+ * received. If this is a new page fault, it will be added to a hash
+ * table. The return value indicates whether this is a new fault, or
+ * a fault that was already known and is already being handled.
+ *
+ * If there are too many pending page faults, this will fail. Retry
+ * interrupts should be ignored in this case until there is enough
+ * free space.
+ *
+ * Returns 0 if the fault was added, 1 if the fault was already known,
+ * -ENOSPC if there are too many pending faults.
+ */
+int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)
+{
+	unsigned long flags;
+	int r = -ENOSPC;
+
+	if (WARN_ON_ONCE(!fault_hash))
+		/* Should be allocated in amdgpu_vm_init
+		 */
+		return r;
+
+	spin_lock_irqsave(&amp;fault_hash-&gt;lock, flags);
+
+	/* Only let the hash table fill up to 50% for best performance */
+	if (fault_hash-&gt;count &gt;= (1 &lt;&lt; (AMDGPU_PAGEFAULT_HASH_BITS-1)))
+		goto unlock_out;
+
+	r = chash_table_copy_in(&amp;fault_hash-&gt;hash, key, NULL);
+	if (!r)
+		fault_hash-&gt;count++;
+
+	/* chash_table_copy_in should never fail unless we're losing count */
+	WARN_ON_ONCE(r &lt; 0);
+
+unlock_out:
+	spin_unlock_irqrestore(&amp;fault_hash-&gt;lock, flags);
+	return r;
+}
+
+/**
+ * amdgpu_vm_clear_fault - Remove a page fault record
+ *
+ * @fault_hash: fault hash table
+ * @key: 64-bit encoding of PASID and address
+ *
+ * This should be called when a page fault has been handled. Any
+ * future interrupt with this key will be processed as a new
+ * page fault.
+ */
+void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)
+{
+	unsigned long flags;
+	int r;
+
+	if (!fault_hash)
+		return;
+
+	spin_lock_irqsave(&amp;fault_hash-&gt;lock, flags);
+
+	r = chash_table_remove(&amp;fault_hash-&gt;hash, key, NULL);
+	if (!WARN_ON_ONCE(r &lt; 0)) {
+		fault_hash-&gt;count--;
+		WARN_ON_ONCE(fault_hash-&gt;count &lt; 0);
+	}
+
+	spin_unlock_irqrestore(&amp;fault_hash-&gt;lock, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index e275ee7..6eb1da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -178,6 +178,13 @@ struct amdgpu_task_info {
 	pid_t	tgid;
 };
 
+#define AMDGPU_PAGEFAULT_HASH_BITS 8
+struct amdgpu_retryfault_hashtable {
+	DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
+	spinlock_t	lock;
+	int		count;
+};
+
 struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
@@ -240,6 +247,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* mark whether can do the bulk move */
 	bool			bulk_moveable;
+	struct amdgpu_retryfault_hashtable *fault_hash;
 };
 
 struct amdgpu_vm_manager {
@@ -355,4 +363,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 
+int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);
+
+void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5ae5ed2..acbe5a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -265,35 +265,36 @@ static bool vega10_ih_prescreen_iv(struct amdgpu_device *adev)
 		return true;
 	}
 
-	addr = ((u64)(dw5 &amp; 0xf) &lt;&lt; 44) | ((u64)dw4 &lt;&lt; 12);
-	key = AMDGPU_VM_FAULT(pasid, addr);
-	r = amdgpu_ih_add_fault(adev, key);
-
-	/* Hash table is full or the fault is already being processed,
-	 * ignore further page faults
-	 */
-	if (r != 0)
-		goto ignore_iv;
-
 	/* Track retry faults in per-VM fault FIFO. */
 	spin_lock(&amp;adev-&gt;vm_manager.pasid_lock);
 	vm = idr_find(&amp;adev-&gt;vm_manager.pasid_idr, pasid);
+	addr = ((u64)(dw5 &amp; 0xf) &lt;&lt; 44) | ((u64)dw4 &lt;&lt; 12);
+	key = AMDGPU_VM_FAULT(pasid, addr);
 	if (!vm) {
 		/* VM not found, process it normally */
 		spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);
-		amdgpu_ih_clear_fault(adev, key);
 		return true;
+	} else {
+		r = amdgpu_vm_add_fault(vm-&gt;fault_hash, key);
+
+		/* Hash table is full or the fault is already being processed,
+		 * ignore further page faults
+		 */
+		if (r != 0) {
+			spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);
+			goto ignore_iv;
+		}
 	}
 	/* No locking required with single writer and single reader */
 	r = kfifo_put(&amp;vm-&gt;faults, key);
 	if (!r) {
 		/* FIFO is full. Ignore it until there is space */
+		amdgpu_vm_clear_fault(vm-&gt;fault_hash, key);
 		spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);
-		amdgpu_ih_clear_fault(adev, key);
 		goto ignore_iv;
 	}
-	spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);
 
+	spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);
 	/* It's the first fault for this address, process it normally */
 	return true;
 
@@ -386,14 +387,6 @@ static int vega10_ih_sw_init(void *handle)
 	adev-&gt;irq.ih.use_doorbell = true;
 	adev-&gt;irq.ih.doorbell_index = AMDGPU_DOORBELL64_IH &lt;&lt; 1;
 
-	adev-&gt;irq.ih.faults = kmalloc(sizeof(*adev-&gt;irq.ih.faults), GFP_KERNEL);
-	if (!adev-&gt;irq.ih.faults)
-		return -ENOMEM;
-	INIT_CHASH_TABLE(adev-&gt;irq.ih.faults-&gt;hash,
-			 AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
-	spin_lock_init(&amp;adev-&gt;irq.ih.faults-&gt;lock);
-	adev-&gt;irq.ih.faults-&gt;count = 0;
-
 	r = amdgpu_irq_init(adev);
 
 	return r;
@@ -406,9 +399,6 @@ static int vega10_ih_sw_fini(void *handle)
 	amdgpu_irq_fini(adev);
 	amdgpu_ih_ring_fini(adev);
 
-	kfree(adev-&gt;irq.ih.faults);
-	adev-&gt;irq.ih.faults = NULL;
-
 	return 0;
 }
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------7D9C35A99FD1DFBEFCB32E78--

--===============0235621114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0235621114==--
