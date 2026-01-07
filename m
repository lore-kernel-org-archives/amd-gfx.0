Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36FECFD641
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 14:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC2210E605;
	Wed,  7 Jan 2026 14:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SA7A2zS/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D1D10E605
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vbzz6TeKHIYFaYZF7Yu0yqcfX/dsFpMG/gVju3c8N0Y=; b=SA7A2zS//LJp7zgFT0mI5H++8h
 /36Lw+Y1gUTmSqXSrvvfKVfd+nsO9v7TVfGmj7sfjWMI9XP95CLSIHHA63ZWcN9GZbLlkWcTSOeyN
 ahBVTTrqbV9D8Q4lQOp3qhBsQLJsOM0+7AyAB9G+/SYuOc5YoqsThbyb0lA5okokMxgi/hIfl4kb9
 bSq8nPDZukEDZmFmvcsH5w/DRWYoS4dvrUxahRJZCLEhcYHcl07LMPcHfgp5IcbieRGmPbNTBxNk9
 xj0/SJYFIXcDKoXcqXUzgwMCOaJQMvizON8IBj+t3duIqYhIc9nvyiFpkID48VyvDc9QRjdngBIdA
 LWphQZ9Q==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vdUs9-002bBH-Vq; Wed, 07 Jan 2026 15:50:54 +0100
Message-ID: <d0aa8e39-1e8a-42f7-8eaf-21b8e0528a82@igalia.com>
Date: Wed, 7 Jan 2026 14:50:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] drm/amdgpu: Replace idr with xarray in
 amdgpu_bo_list
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-11-tvrtko.ursulin@igalia.com>
 <97e20c2a-9f58-49a7-84b8-c457a7d30140@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <97e20c2a-9f58-49a7-84b8-c457a7d30140@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/01/2026 09:35, Christian König wrote:
> On 12/19/25 14:42, Tvrtko Ursulin wrote:
>> IDR is deprecated so let's replace it with xarray.
>>
>> Conversion is mostly 1:1 apart from AMDGPU_BO_LIST_OP_UPDATE which was
>> implemented with idr_replace, and has now been replaced with a sequence of
>> xa_load and xa_cmpxchg. Should userspace attempt multi-threaded update
>> operations on the same handle it could theoretically hit a new -ENOENT
>> path. But I believe this is purely theoretical and still safe.
>>
>> Also, since we have removed the RCU protection around the handle lookup we
>> also removed the RCU freeing of the list.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>> v2:
>>   * Dropped RCU freeing of the list.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 81 +++++++++------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 11 +--
>>   4 files changed, 42 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 80dba6276aa8..ec3cbe70012a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -50,6 +50,7 @@
>>   #include <linux/hashtable.h>
>>   #include <linux/dma-fence.h>
>>   #include <linux/pci.h>
>> +#include <linux/xarray.h>
>>   
>>   #include <drm/ttm/ttm_bo.h>
>>   #include <drm/ttm/ttm_placement.h>
>> @@ -499,8 +500,7 @@ struct amdgpu_fpriv {
>>   	struct amdgpu_bo_va	*prt_va;
>>   	struct amdgpu_bo_va	*csa_va;
>>   	struct amdgpu_bo_va	*seq64_va;
>> -	struct mutex		bo_list_lock;
>> -	struct idr		bo_list_handles;
>> +	struct xarray		bo_list_handles;
>>   	struct amdgpu_ctx_mgr	ctx_mgr;
>>   	struct amdgpu_userq_mgr	userq_mgr;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> index fbac929f711c..59def86cdc04 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> @@ -37,14 +37,6 @@
>>   #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
>>   #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
>>   
>> -static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>> -{
>> -	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
>> -						   rhead);
>> -
>> -	kvfree(list);
>> -}
>> -
>>   static void amdgpu_bo_list_free(struct kref *ref)
>>   {
>>   	struct amdgpu_bo_list *list = container_of(ref, struct amdgpu_bo_list,
>> @@ -53,7 +45,8 @@ static void amdgpu_bo_list_free(struct kref *ref)
>>   
>>   	amdgpu_bo_list_for_each_entry(e, list)
>>   		amdgpu_bo_unref(&e->bo);
>> -	call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
>> +
>> +	kvfree(list);
>>   }
>>   
>>   static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
>> @@ -146,31 +139,20 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>>   
>>   }
>>   
>> -static void amdgpu_bo_list_destroy(struct amdgpu_fpriv *fpriv, int id)
>> -{
>> -	struct amdgpu_bo_list *list;
>> -
>> -	mutex_lock(&fpriv->bo_list_lock);
>> -	list = idr_remove(&fpriv->bo_list_handles, id);
>> -	mutex_unlock(&fpriv->bo_list_lock);
>> -	if (list)
>> -		kref_put(&list->refcount, amdgpu_bo_list_free);
>> -}
>> -
>> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>>   		       struct amdgpu_bo_list **result)
>>   {
>> -	rcu_read_lock();
>> -	*result = idr_find(&fpriv->bo_list_handles, id);
>> +	struct amdgpu_bo_list *list;
>>   
>> -	if (*result && kref_get_unless_zero(&(*result)->refcount)) {
>> -		rcu_read_unlock();
>> -		return 0;
>> -	}
>> +	xa_lock(&fpriv->bo_list_handles);
>> +	list = xa_load(&fpriv->bo_list_handles, id);
>> +	if (list)
>> +		kref_get(&list->refcount);
>> +	xa_unlock(&fpriv->bo_list_handles);
>>   
>> -	rcu_read_unlock();
>> -	*result = NULL;
>> -	return -ENOENT;
>> +	*result = list;
>> +
>> +	return list ? 0 : -ENOENT;
>>   }
>>   
>>   void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>> @@ -215,12 +197,12 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>   int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>   				struct drm_file *filp)
>>   {
>> -	struct amdgpu_device *adev = drm_to_adev(dev);
>>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	struct drm_amdgpu_bo_list_entry *info = NULL;
>> +	struct amdgpu_bo_list *list, *prev, *curr;
>>   	union drm_amdgpu_bo_list *args = data;
>>   	uint32_t handle = args->in.list_handle;
>> -	struct drm_amdgpu_bo_list_entry *info = NULL;
>> -	struct amdgpu_bo_list *list, *old;
>>   	int r;
>>   
>>   	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
>> @@ -234,19 +216,19 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>   		if (r)
>>   			goto error_free;
>>   
>> -		mutex_lock(&fpriv->bo_list_lock);
>> -		r = idr_alloc(&fpriv->bo_list_handles, list, 1, 0, GFP_KERNEL);
>> -		mutex_unlock(&fpriv->bo_list_lock);
>> -		if (r < 0) {
>> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
>> +			     xa_limit_32b, GFP_KERNEL);
>> +		if (r)
>>   			goto error_put_list;
>> -		}
>>   
>> -		handle = r;
>>   		break;
>>   
>>   	case AMDGPU_BO_LIST_OP_DESTROY:
>> -		amdgpu_bo_list_destroy(fpriv, handle);
>> +		list = xa_erase(&fpriv->bo_list_handles, handle);
>> +		if (list)
>> +			amdgpu_bo_list_put(list);
> 
> It's usually good practice to make *_put() functions take NULL as argument.

Done.

Regards,

Tvrtko

> 
> Apart from that looks good to me.
> 
> Regards,
> Christian.
> 
>>   		handle = 0;
>> +
>>   		break;
>>   
>>   	case AMDGPU_BO_LIST_OP_UPDATE:
>> @@ -255,16 +237,23 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>   		if (r)
>>   			goto error_free;
>>   
>> -		mutex_lock(&fpriv->bo_list_lock);
>> -		old = idr_replace(&fpriv->bo_list_handles, list, handle);
>> -		mutex_unlock(&fpriv->bo_list_lock);
>> +		curr = xa_load(&fpriv->bo_list_handles, handle);
>> +		if (!curr) {
>> +			r = -ENOENT;
>> +			goto error_put_list;
>> +		}
>>   
>> -		if (IS_ERR(old)) {
>> -			r = PTR_ERR(old);
>> +		prev = xa_cmpxchg(&fpriv->bo_list_handles, handle, curr, list,
>> +				  GFP_KERNEL);
>> +		if (xa_is_err(prev)) {
>> +			r = xa_err(prev);
>> +			goto error_put_list;
>> +		} else if (prev != curr) {
>> +			r = -ENOENT;
>>   			goto error_put_list;
>>   		}
>>   
>> -		amdgpu_bo_list_put(old);
>> +		amdgpu_bo_list_put(curr);
>>   		break;
>>   
>>   	default:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> index 1acf53f8b2f9..cf127bc66f53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> @@ -43,7 +43,6 @@ struct amdgpu_bo_list_entry {
>>   };
>>   
>>   struct amdgpu_bo_list {
>> -	struct rcu_head rhead;
>>   	struct kref refcount;
>>   	struct amdgpu_bo *gds_obj;
>>   	struct amdgpu_bo *gws_obj;
>> @@ -54,7 +53,7 @@ struct amdgpu_bo_list {
>>   	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>>   };
>>   
>> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>>   		       struct amdgpu_bo_list **result);
>>   void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>>   int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 6ee77f431d56..88f104041157 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1445,8 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>   	if (r)
>>   		goto error_vm;
>>   
>> -	mutex_init(&fpriv->bo_list_lock);
>> -	idr_init_base(&fpriv->bo_list_handles, 1);
>> +	xa_init_flags(&fpriv->bo_list_handles, XA_FLAGS_ALLOC1);
>>   
>>   	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
>>   	if (r)
>> @@ -1492,8 +1491,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>   	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>   	struct amdgpu_bo_list *list;
>>   	struct amdgpu_bo *pd;
>> +	unsigned long handle;
>>   	u32 pasid;
>> -	int handle;
>>   
>>   	if (!fpriv)
>>   		return;
>> @@ -1529,11 +1528,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>>   	amdgpu_bo_unref(&pd);
>>   
>> -	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
>> +	xa_for_each(&fpriv->bo_list_handles, handle, list)
>>   		amdgpu_bo_list_put(list);
>> -
>> -	idr_destroy(&fpriv->bo_list_handles);
>> -	mutex_destroy(&fpriv->bo_list_lock);
>> +	xa_destroy(&fpriv->bo_list_handles);
>>   
>>   	kfree(fpriv);
>>   	file_priv->driver_priv = NULL;
> 

