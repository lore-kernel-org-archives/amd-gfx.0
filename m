Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802D3C9EC64
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4FA10E343;
	Mon, 12 Jan 2026 10:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cwt5efRD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F9810E33E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+J9WXWKDD2lUL2VCEB8jaHM7AobRGORvqNYSYW45mf0=; b=cwt5efRD8EKUXeV8unkUriVasJ
 wdrH2FTrmbx/5lKeYteHM4C/IxBrlga8xHKlOVNJicYri+EBrlo19s9CdCtMiEx/KjWRzkjFLI695
 +fezZcZO5VlAbG4qjK+ICHsSy1lhCo+60QtKktxDwoLMk74+QuBjhtCYaW9NBAeecjS0DQOQOn+aH
 +3ewAqF6na5sVZGsAnFemwQV03WAlZ3gKAqigpqB5DH2CGHoimJjZEmfyg2K2gx4Dji32tk5mWnXv
 /7h7P/cDqlQ2SMUZjfwh4PxjYoizKP8oI3nVPHy5Q8+IxS6gwY0NuPKZMWhaSeRhZ93cS/SwRoz8t
 qmXHKbzg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4Z-004LdK-7U; Mon, 12 Jan 2026 11:22:55 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 11/12] drm/amdgpu: Remove output parameter in bo list
 handling
Date: Mon, 12 Jan 2026 10:22:43 +0000
Message-ID: <20260112102244.63308-12-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Removing the output parameter from a few functions should result in more
readable code and also enables us to save some lines.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 84 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 17 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 54 ++++++-------
 3 files changed, 71 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 62336890ed40..825ecde6a95f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -58,9 +58,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
 	return (int)a->priority - (int)b->priority;
 }
 
-int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
-			  struct drm_amdgpu_bo_list_entry *info,
-			  size_t num_entries, struct amdgpu_bo_list **result)
+struct amdgpu_bo_list *
+amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
+		      struct drm_amdgpu_bo_list_entry *info, size_t num_entries)
 {
 	unsigned last_entry = 0, first_userptr = num_entries;
 	struct amdgpu_bo_list_entry *array;
@@ -71,7 +71,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	list = kvzalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
 	if (!list)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	kref_init(&list->refcount);
 
@@ -126,8 +126,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
 
-	*result = list;
-	return 0;
+	return list;
 
 error_free:
 	for (i = 0; i < last_entry; ++i)
@@ -135,12 +134,11 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	for (i = first_userptr; i < num_entries; ++i)
 		amdgpu_bo_unref(&array[i].bo);
 	kvfree(list);
-	return r;
+	return ERR_PTR(r);
 
 }
 
-int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
-		       struct amdgpu_bo_list **result)
+struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id)
 {
 	struct amdgpu_bo_list *list;
 
@@ -148,11 +146,11 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
 	list = xa_load(&fpriv->bo_list_handles, id);
 	if (list)
 		kref_get(&list->refcount);
+	else
+		list = ERR_PTR(-ENOENT);
 	xa_unlock(&fpriv->bo_list_handles);
 
-	*result = list;
-
-	return list ? 0 : -ENOENT;
+	return list;
 }
 
 void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
@@ -161,22 +159,15 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 		kref_put(&list->refcount, amdgpu_bo_list_free);
 }
 
-int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
-				      struct drm_amdgpu_bo_list_entry **info_param)
+struct drm_amdgpu_bo_list_entry *
+amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in)
 {
-	struct drm_amdgpu_bo_list_entry *info;
-
 	if (in->bo_info_size != sizeof(struct drm_amdgpu_bo_list_entry))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
-	info = vmemdup_array_user(u64_to_user_ptr(in->bo_info_ptr),
+	return vmemdup_array_user(u64_to_user_ptr(in->bo_info_ptr),
 				  in->bo_number,
 				  sizeof(struct drm_amdgpu_bo_list_entry));
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	*info_param = info;
-	return 0;
 }
 
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
@@ -184,27 +175,24 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_amdgpu_bo_list_entry *info = NULL;
 	struct amdgpu_bo_list *list, *prev, *curr;
 	union drm_amdgpu_bo_list *args = data;
 	uint32_t handle = args->in.list_handle;
+	struct drm_amdgpu_bo_list_entry *info;
 	int r;
 
-	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
-	if (r)
-		return r;
-
 	switch (args->in.operation) {
 	case AMDGPU_BO_LIST_OP_CREATE:
-		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
-					  &list);
-		if (r)
-			goto error_free;
+	case AMDGPU_BO_LIST_OP_UPDATE:
+		info = amdgpu_bo_create_list_entry_array(&args->in);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
 
-		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
-			     xa_limit_32b, GFP_KERNEL);
-		if (r)
-			goto error_put_list;
+		list = amdgpu_bo_list_create(adev, filp, info,
+					     args->in.bo_number);
+		kvfree(info);
+		if (IS_ERR(list))
+			return PTR_ERR(list);
 
 		break;
 
@@ -215,12 +203,20 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
 
 		break;
 
-	case AMDGPU_BO_LIST_OP_UPDATE:
-		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
-					  &list);
+	default:
+		return -EINVAL;
+	};
+
+	switch (args->in.operation) {
+	case AMDGPU_BO_LIST_OP_CREATE:
+		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
+			     xa_limit_32b, GFP_KERNEL);
 		if (r)
-			goto error_free;
+			goto error_put_list;
 
+		break;
+
+	case AMDGPU_BO_LIST_OP_UPDATE:
 		curr = xa_load(&fpriv->bo_list_handles, handle);
 		if (!curr) {
 			r = -ENOENT;
@@ -240,21 +236,17 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
 		amdgpu_bo_list_put(curr);
 		break;
 
+	case AMDGPU_BO_LIST_OP_DESTROY:
 	default:
-		r = -EINVAL;
-		goto error_free;
+		/* Handled above. */
 	}
 
 	memset(args, 0, sizeof(*args));
 	args->out.list_handle = handle;
-	kvfree(info);
 
 	return 0;
 
 error_put_list:
 	amdgpu_bo_list_put(list);
-
-error_free:
-	kvfree(info);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index cf127bc66f53..bde912150824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -53,17 +53,16 @@ struct amdgpu_bo_list {
 	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
 };
 
-int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
-		       struct amdgpu_bo_list **result);
+struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id);
 void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
-int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
-				      struct drm_amdgpu_bo_list_entry **info_param);
+struct drm_amdgpu_bo_list_entry *
+amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in);
 
-int amdgpu_bo_list_create(struct amdgpu_device *adev,
-				 struct drm_file *filp,
-				 struct drm_amdgpu_bo_list_entry *info,
-				 size_t num_entries,
-				 struct amdgpu_bo_list **list);
+struct amdgpu_bo_list *
+amdgpu_bo_list_create(struct amdgpu_device *adev,
+		      struct drm_file *filp,
+		      struct drm_amdgpu_bo_list_entry *info,
+		      size_t num_entries);
 
 #define amdgpu_bo_list_for_each_entry(e, list) \
 	for (e = list->entries; \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5d53767aa941..8a6536994da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -145,24 +145,19 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
 				   struct drm_amdgpu_bo_list_in *data)
 {
 	struct drm_amdgpu_bo_list_entry *info;
-	int r;
+	struct amdgpu_bo_list *list;
 
-	r = amdgpu_bo_create_list_entry_array(data, &info);
-	if (r)
-		return r;
-
-	r = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number,
-				  &p->bo_list);
-	if (r)
-		goto error_free;
+	info = amdgpu_bo_create_list_entry_array(data);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
 
+	list = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number);
 	kvfree(info);
+	if (IS_ERR(list))
+		return PTR_ERR(list);
+
+	p->bo_list = list;
 	return 0;
-
-error_free:
-	kvfree(info);
-
-	return r;
 }
 
 /* Copy the data from userspace and go over it the first time */
@@ -850,6 +845,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct ttm_operation_ctx ctx = { true, false };
+	struct amdgpu_bo_list *list = NULL;
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
@@ -862,23 +858,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (p->bo_list)
 			return -EINVAL;
 
-		r = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle,
-				       &p->bo_list);
-		if (r)
-			return r;
+		list = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle);
 	} else if (!p->bo_list) {
 		/* Create a empty bo_list when no handle is provided */
-		r = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0,
-					  &p->bo_list);
-		if (r)
-			return r;
+		list = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0);
 	}
 
+	if (IS_ERR(list))
+		return PTR_ERR(list);
+	else if (list)
+		p->bo_list = list;
+	else
+		list = p->bo_list;
+
 	/* Get userptr backing pages. If pages are updated after registered
 	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
 	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
 	 */
-	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+	amdgpu_bo_list_for_each_userptr_entry(e, list) {
 		bool userpage_invalidated = false;
 		struct amdgpu_bo *bo = e->bo;
 
@@ -906,7 +903,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (unlikely(r))
 			goto out_free_user_pages;
 
-		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
+		amdgpu_bo_list_for_each_entry(e, list) {
 			/* One fence for TTM and one for each CS job */
 			r = drm_exec_prepare_obj(&p->exec, &e->bo->tbo.base,
 						 1 + p->gang_size);
@@ -926,7 +923,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+	amdgpu_bo_list_for_each_userptr_entry(e, list) {
 		struct mm_struct *usermm;
 
 		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
@@ -979,13 +976,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 				     p->bytes_moved_vis);
 
 	for (i = 0; i < p->gang_size; ++i)
-		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
-					 p->bo_list->gws_obj,
-					 p->bo_list->oa_obj);
+		amdgpu_job_set_resources(p->jobs[i], list->gds_obj,
+					 list->gws_obj, list->oa_obj);
 	return 0;
 
 out_free_user_pages:
-	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+	amdgpu_bo_list_for_each_userptr_entry(e, list) {
 		amdgpu_hmm_range_free(e->range);
 		e->range = NULL;
 	}
-- 
2.52.0

