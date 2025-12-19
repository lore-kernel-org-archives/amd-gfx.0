Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3060AD74968
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA58610EED9;
	Fri, 19 Dec 2025 08:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ndDfpwnA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B1E10EEE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1PsquyQf0OCiisy6c/J1jXI4r6f1YAG/ZTYg0W+3cMg=; b=ndDfpwnABeJCixQjXE3LbIDEkt
 TpErbJOUxjsKrEmYvA+D5DUa98EHPDjD/z3hNBgLJ82RaySW56U8GWxb8ieVB6YuVvZ0lQ6JgPC0S
 g/HQvEDpTAHb3umMQ5C1PYpYgpFj4M2WVVKSWvao/BerPPYIvuP0uaO9qSQS9PEuKrrRyK2FFJsrA
 huN5bysMTlr+Nkcfh2gl/U9vxARThnqylpWntRhDP8SgwBcvfad0poOl1KC6XUHyU++GaHBMmHTLy
 s2Tx/qzzwB6c3Gj2sKCj6iUiiJzpnj/G6MIDT3DMnUsjiabRvCpelryD7JBV0pvZLT0eSm71JgWvy
 oGPvwb7Q==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vWW6b-00EYfn-F4; Fri, 19 Dec 2025 09:44:57 +0100
Message-ID: <a67385ca-4eba-416d-8fea-92fad98e89dd@igalia.com>
Date: Fri, 19 Dec 2025 08:44:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] drm/amdgpu: Remove output parameter in bo list handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-3-tvrtko.ursulin@igalia.com>
 <c0ab731a-c32c-49ea-b380-1dba8b20894f@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <c0ab731a-c32c-49ea-b380-1dba8b20894f@amd.com>
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


On 19/12/2025 08:12, Christian König wrote:
> On 12/18/25 16:04, Tvrtko Ursulin wrote:
>> Removing the output parameter from a few functions should result in more
>> readable code and also enables us to save some lines.
> 
> Oh, yes please.
> 
> That was just because somebody had a personal preference for this coding style and it resulted in at least one CVE entry for amdgpu a couple of years ago.
> 
> I should have pushed back on this harder when I've seen it initially.
> 
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 86 ++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 17 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 58 +++++++-------
>>   3 files changed, 75 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> index 628d32fd2fae..0ab307317145 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> @@ -67,9 +67,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
>>   	return 0;
>>   }
>>   
>> -int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>> -			  struct drm_amdgpu_bo_list_entry *info,
>> -			  size_t num_entries, struct amdgpu_bo_list **result)
>> +struct amdgpu_bo_list *
>> +amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>> +		      struct drm_amdgpu_bo_list_entry *info, size_t num_entries)
>>   {
>>   	unsigned last_entry = 0, first_userptr = num_entries;
>>   	struct amdgpu_bo_list_entry *array;
>> @@ -80,7 +80,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>>   
>>   	list = kvzalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
>>   	if (!list)
>> -		return -ENOMEM;
>> +		return ERR_PTR(-ENOMEM);
>>   
>>   	kref_init(&list->refcount);
>>   
>> @@ -136,8 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>>   	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>>   
>>   	mutex_init(&list->bo_list_mutex);
>> -	*result = list;
>> -	return 0;
>> +	return list;
>>   
>>   error_free:
>>   	for (i = 0; i < last_entry; ++i)
>> @@ -145,24 +144,21 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>>   	for (i = first_userptr; i < num_entries; ++i)
>>   		amdgpu_bo_unref(&array[i].bo);
>>   	kvfree(list);
>> -	return r;
>> +	return ERR_PTR(r);
>>   
>>   }
>>   
>> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>> -		       struct amdgpu_bo_list **result)
>> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id)
>>   {
>>   	struct amdgpu_bo_list *list;
>>   
>>   	xa_lock(&fpriv->bo_list_handles);
>>   	list = xa_load(&fpriv->bo_list_handles, id);
>> -	if (list && !kref_get_unless_zero(&list->refcount))
>> -		list = NULL;
>> +	if (!list || !kref_get_unless_zero(&list->refcount))
>> +		list = ERR_PTR(-ENOENT);
>>   	xa_unlock(&fpriv->bo_list_handles);
>>   
>> -	*result = list;
>> -
>> -	return list ? 0 : -ENOENT;
>> +	return list;
>>   }
>>   
>>   void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>> @@ -170,8 +166,8 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>>   	kref_put(&list->refcount, amdgpu_bo_list_free);
>>   }
>>   
>> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>> -				      struct drm_amdgpu_bo_list_entry **info_param)
>> +struct drm_amdgpu_bo_list_entry *
>> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in)
>>   {
>>   	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
>>   	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
>> @@ -182,27 +178,24 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>>   	/* copy the handle array from userspace to a kernel buffer */
>>   	if (likely(info_size == bo_info_size)) {
>>   		info = vmemdup_array_user(uptr, bo_number, info_size);
>> -		if (IS_ERR(info))
>> -			return PTR_ERR(info);
>>   	} else {
>>   		const uint32_t bytes = min(bo_info_size, info_size);
>>   		unsigned i;
>>   
>>   		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
>>   		if (!info)
>> -			return -ENOMEM;
>> +			return ERR_PTR(-ENOMEM);
>>   
>>   		memset(info, 0, bo_number * info_size);
>>   		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
>>   			if (copy_from_user(&info[i], uptr, bytes)) {
>>   				kvfree(info);
>> -				return -EFAULT;
>> +				return ERR_PTR(-EFAULT);
>>   			}
>>   		}
>>   	}
>>   
>> -	*info_param = info;
>> -	return 0;
>> +	return info;
>>   }
>>   
>>   int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>> @@ -210,27 +203,24 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>   {
>>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>   	struct amdgpu_device *adev = drm_to_adev(dev);
>> -	struct drm_amdgpu_bo_list_entry *info = NULL;
>>   	struct amdgpu_bo_list *list, *prev, *curr;
>> -	uint32_t handle = args->in.list_handle;
>>   	union drm_amdgpu_bo_list *args = data;
>> +	uint32_t handle = args->in.list_handle;
>> +	struct drm_amdgpu_bo_list_entry *info;
>>   	int r;
>>   
>> -	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
>> -	if (r)
>> -		return r;
>> -
>>   	switch (args->in.operation) {
>>   	case AMDGPU_BO_LIST_OP_CREATE:
>> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
>> -					  &list);
>> -		if (r)
>> -			goto error_free;
>> +	case AMDGPU_BO_LIST_OP_UPDATE:
>> +		info = amdgpu_bo_create_list_entry_array(&args->in);
>> +		if (IS_ERR(info))
>> +			return PTR_ERR(info);
>>   
>> -		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
>> -			     xa_limit_32b, GFP_KERNEL);
>> -		if (r)
>> -			goto error_put_list;
>> +		list = amdgpu_bo_list_create(adev, filp, info,
>> +					     args->in.bo_number);
>> +		kvfree(info);
>> +		if (IS_ERR(list))
>> +			return PTR_ERR(list);
>>   
>>   		break;
>>   
>> @@ -242,12 +232,20 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>   
>>   		break;
>>   
>> -	case AMDGPU_BO_LIST_OP_UPDATE:
>> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
>> -					  &list);
>> +	default:
>> +		return -EINVAL;
>> +	};
>> +
>> +	switch (args->in.operation) {
>> +	case AMDGPU_BO_LIST_OP_CREATE:
>> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
>> +			     xa_limit_32b, GFP_KERNEL);
>>   		if (r)
>> -			goto error_free;
>> +			goto error_put_list;
>>   
>> +		break;
>> +
>> +	case AMDGPU_BO_LIST_OP_UPDATE:
>>   		curr = xa_load(&fpriv->bo_list_handles, handle);
>>   		if (!curr) {
>>   			r = -ENOENT;
>> @@ -267,21 +265,17 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>>   		amdgpu_bo_list_put(curr);
>>   		break;
>>   
>> +	case AMDGPU_BO_LIST_OP_DESTROY:
>>   	default:
>> -		r = -EINVAL;
>> -		goto error_free;
>> +		/* Handled above. */
> 
> I think I prefer to keep that a single switch statement. This looks a bit mixed up to me.

I agree it looks odd.

What I wanted to is limit the allocations to only the operations which 
need it. Otherwise it seems to me it is pointless for 
AMDGPU_BO_LIST_OP_DESTROY to allocate something it does not touch.

Also the invalid args->in.operation check is currently after the first 
allocation.

A more elegant solution did not come to me yesterday.

> 
>>   	}
>>   
>>   	memset(args, 0, sizeof(*args));
>>   	args->out.list_handle = handle;
>> -	kvfree(info);
>>   
>>   	return 0;
>>   
>>   error_put_list:
>>   	amdgpu_bo_list_put(list);
>> -
>> -error_free:
>> -	kvfree(info);
>>   	return r;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> index 0989f1090c63..085ca94f97a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> @@ -58,17 +58,16 @@ struct amdgpu_bo_list {
>>   	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>>   };
>>   
>> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>> -		       struct amdgpu_bo_list **result);
>> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id);
>>   void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>> -				      struct drm_amdgpu_bo_list_entry **info_param);
>> +struct drm_amdgpu_bo_list_entry *
>> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in);
>>   
>> -int amdgpu_bo_list_create(struct amdgpu_device *adev,
>> -				 struct drm_file *filp,
>> -				 struct drm_amdgpu_bo_list_entry *info,
>> -				 size_t num_entries,
>> -				 struct amdgpu_bo_list **list);
>> +struct amdgpu_bo_list *
>> +amdgpu_bo_list_create(struct amdgpu_device *adev,
>> +		      struct drm_file *filp,
>> +		      struct drm_amdgpu_bo_list_entry *info,
>> +		      size_t num_entries);
>>   
>>   #define amdgpu_bo_list_for_each_entry(e, list) \
>>   	for (e = list->entries; \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 203223fd0b54..a4cdaebaefe5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -152,24 +152,19 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
>>   				   struct drm_amdgpu_bo_list_in *data)
>>   {
>>   	struct drm_amdgpu_bo_list_entry *info;
>> -	int r;
>> +	struct amdgpu_bo_list *list;
>>   
>> -	r = amdgpu_bo_create_list_entry_array(data, &info);
>> -	if (r)
>> -		return r;
>> -
>> -	r = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number,
>> -				  &p->bo_list);
>> -	if (r)
>> -		goto error_free;
>> +	info = amdgpu_bo_create_list_entry_array(data);
>> +	if (IS_ERR(info))
>> +		return PTR_ERR(info);
>>   
>> +	list = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number);
>>   	kvfree(info);
>> +	if (IS_ERR(list))
>> +		return PTR_ERR(list);
>> +
>> +	p->bo_list = list;
>>   	return 0;
>> -
>> -error_free:
>> -	kvfree(info);
>> -
>> -	return r;
>>   }
>>   
>>   /* Copy the data from userspace and go over it the first time */
>> @@ -857,6 +852,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   {
>>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>>   	struct ttm_operation_ctx ctx = { true, false };
>> +	struct amdgpu_bo_list *list = NULL;
>>   	struct amdgpu_vm *vm = &fpriv->vm;
>>   	struct amdgpu_bo_list_entry *e;
>>   	struct drm_gem_object *obj;
>> @@ -869,25 +865,26 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   		if (p->bo_list)
>>   			return -EINVAL;
>>   
>> -		r = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle,
>> -				       &p->bo_list);
>> -		if (r)
>> -			return r;
>> +		list = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle);
>>   	} else if (!p->bo_list) {
>>   		/* Create a empty bo_list when no handle is provided */
> 
> I think we can drop this handling.
> 
> This was just a broken fallback for the closed source driver which the OpenGL stack never used, need to double check with the RADV guys but I don't think they ever used this as well.

The whole else if block? Okay, I will put that as a separate patch in 
this case.

Regards,

Tvrtko

> 
> Looks good to me otherwise,
> Christian.
> 
>> -		r = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0,
>> -					  &p->bo_list);
>> -		if (r)
>> -			return r;
>> +		list = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0);
>>   	}
>>   
>> -	mutex_lock(&p->bo_list->bo_list_mutex);
>> +	if (IS_ERR(list))
>> +		return PTR_ERR(list);
>> +	else if (list)
>> +		p->bo_list = list;
>> +	else
>> +		list = p->bo_list;
>> +
>> +	mutex_lock(&list->bo_list_mutex);
>>   
>>   	/* Get userptr backing pages. If pages are updated after registered
>>   	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
>>   	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
>>   	 */
>> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>>   		bool userpage_invalidated = false;
>>   		struct amdgpu_bo *bo = e->bo;
>>   
>> @@ -915,7 +912,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   		if (unlikely(r))
>>   			goto out_free_user_pages;
>>   
>> -		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>> +		amdgpu_bo_list_for_each_entry(e, list) {
>>   			/* One fence for TTM and one for each CS job */
>>   			r = drm_exec_prepare_obj(&p->exec, &e->bo->tbo.base,
>>   						 1 + p->gang_size);
>> @@ -935,7 +932,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   		}
>>   	}
>>   
>> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>>   		struct mm_struct *usermm;
>>   
>>   		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
>> @@ -988,17 +985,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   				     p->bytes_moved_vis);
>>   
>>   	for (i = 0; i < p->gang_size; ++i)
>> -		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
>> -					 p->bo_list->gws_obj,
>> -					 p->bo_list->oa_obj);
>> +		amdgpu_job_set_resources(p->jobs[i], list->gds_obj,
>> +					 list->gws_obj, list->oa_obj);
>>   	return 0;
>>   
>>   out_free_user_pages:
>> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>>   		amdgpu_hmm_range_free(e->range);
>>   		e->range = NULL;
>>   	}
>> -	mutex_unlock(&p->bo_list->bo_list_mutex);
>> +	mutex_unlock(&list->bo_list_mutex);
>>   	return r;
>>   }
>>   
> 

