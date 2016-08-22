From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/4] amdgpu: add export/import semaphore apis
Date: Mon, 22 Aug 2016 10:42:17 +0800
Message-ID: <57BA6689.2010700@amd.com>
References: <1471506959-905-1-git-send-email-David1.Zhou@amd.com>
 <1471506959-905-3-git-send-email-David1.Zhou@amd.com>
 <cf458d97-d40a-d363-b5c4-2ae45dde9179@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1564368497=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cf458d97-d40a-d363-b5c4-2ae45dde9179-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Mao-5C7GfCeVMHo@public.gmane.org

--===============1564368497==
Content-Type: multipart/alternative;
	boundary="------------050801070309090100050705"

--------------050801070309090100050705
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2016年08月21日 14:23, Edward O'Callaghan wrote:
>
> On 08/18/2016 05:55 PM, Chunming Zhou wrote:
>> They are used for sharing semaphore across process.
>>
>> Change-Id: I262adf10913d365bb93368b492e69140af522c64
>> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   amdgpu/amdgpu.h          | 40 ++++++++++++++++++++++++++++++
>>   amdgpu/amdgpu_cs.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   amdgpu/amdgpu_internal.h |  2 ++
>>   3 files changed, 103 insertions(+), 2 deletions(-)
>>
>> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>> index 693d841..e716855 100644
>> --- a/amdgpu/amdgpu.h
>> +++ b/amdgpu/amdgpu.h
>> @@ -1379,6 +1379,19 @@ int amdgpu_svm_commit(amdgpu_va_handle va_range_handle,
>>   int amdgpu_svm_uncommit(amdgpu_va_handle va_range_handle);
>>   
>>   /**
>> + *  create shared semaphore
>> + *
>> + * \param amdgpu_device_handle
>> + * \param   sem	   - \c [out] semaphore handle
>> + *
>> + * \return   0 on success\n
>> + *          <0 - Negative POSIX Error code
>> + *
>> +*/
>> +int amdgpu_cs_create_semaphore_object(amdgpu_device_handle device_handle,
>> +				      amdgpu_semaphore_handle *sem);
>> +
>> +/**
>>    *  create semaphore
>>    *
>>    * \param   sem	   - \c [out] semaphore handle
>> @@ -1439,6 +1452,33 @@ int amdgpu_cs_wait_semaphore(amdgpu_context_handle ctx,
>>   int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem);
>>   
>>   /**
>> + *  export semaphore
>> + *
>> + * \param   sem	    - \c [in] semaphore handle
>> + * \param   shared_handle    - \c [out] handle across process
>> + *
>> + * \return   0 on success\n
>> + *          <0 - Negative POSIX Error code
>> + *
>> +*/
>> +int amdgpu_cs_export_semaphore(amdgpu_semaphore_handle sem,
>> +			       uint32_t *shared_handle);
>> +/**
>> + *  import semaphore
>> + *
>> + * \param   sem	    - \c [out] semaphore handle
>> + * \param   dev	    - \c [in] device handle
>> + * \param   shared_handle    - \c [in] handle across process
>> + *
>> + * \return   0 on success\n
>> + *          <0 - Negative POSIX Error code
>> + *
>> +*/
>> +int amdgpu_cs_import_semaphore(amdgpu_semaphore_handle *sem,
>> +			       amdgpu_device_handle dev,
>> +			       uint32_t shared_handle);
>> +
>> +/**
>>    *  Get the ASIC marketing name
>>    *
>>    * \param   dev         - \c [in] Device handle. See #amdgpu_device_initialize()
>> diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
>> index c76a675..a3ff34e 100644
>> --- a/amdgpu/amdgpu_cs.c
>> +++ b/amdgpu/amdgpu_cs.c
>> @@ -518,6 +518,34 @@ int amdgpu_cs_wait_fences(struct amdgpu_cs_fence *fences,
>>   	return r;
>>   }
>>   
>> +int amdgpu_cs_create_semaphore_object(amdgpu_device_handle device_handle,
>> +				      amdgpu_semaphore_handle *sem)
>> +{
>> +	struct amdgpu_bo_alloc_request req = {0};
>> +	amdgpu_bo_handle buf_handle;
>> +	int r;
>> +
>> +	if (NULL == sem)
> Since sem is ** then should we not check that *both* sem && *sem are
> non-NULL too? Further you can use the canonical form of (!sem)
>
>> +		return -EINVAL;
>> +
>> +	req.alloc_size = sizeof(struct amdgpu_semaphore);
>> +	req.preferred_heap = AMDGPU_GEM_DOMAIN_GTT;
>> +
>> +	r = amdgpu_bo_alloc(device_handle, &req, &buf_handle);
>> +	if (r)
>> +		return r;
>> +	r = amdgpu_bo_cpu_map(buf_handle, sem);
>> +	if (r) {
>> +		amdgpu_bo_free(buf_handle);
>> +		return r;
>> +	}
>> +	(*sem)->buf_handle = buf_handle;
>> +	atomic_set(&(*sem)->refcount, 1);
> Hi Chunming,
>
> When/where was 'amdgpu_semaphore_handle' introduced? I am not sure I
> like pointers being hidden behind typedef's as opaque types this can
> lead to really really bad things.. I only noticed sem was a ** because
> of the weird looking deference then address operator application, then
> deference again here, &(*sem)->..
Hi Edward,
semaphore was introduced last year, which is the wrapper of existing 
dependency.
Yeah, this whole sharing semaphore approach has been NAKed by Christian.
So we can skip this series now, we are going to use sync_file instead.

Thanks,
David Zhou

>
> Cheers,
> Edward.
>
>> +	(*sem)->version = 2;
>> +
>> +	return 0;
>> +}
>> +
>>   int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
>>   {
>>   	struct amdgpu_semaphore *gpu_semaphore;
>> @@ -529,6 +557,7 @@ int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
>>   	if (NULL == gpu_semaphore)
>>   		return -ENOMEM;
>>   
>> +	gpu_semaphore->version = 1;
>>   	atomic_set(&gpu_semaphore->refcount, 1);
>>   	*sem = gpu_semaphore;
>>   
>> @@ -608,8 +637,15 @@ static int amdgpu_cs_unreference_sem(amdgpu_semaphore_handle sem)
>>   	if (NULL == sem)
>>   		return -EINVAL;
>>   
>> -	if (update_references(&sem->refcount, NULL))
>> -		free(sem);
>> +	if (update_references(&sem->refcount, NULL)) {
>> +		if (sem->version == 1)
>> +			free(sem);
>> +		else if (sem->version == 2) {
>> +			amdgpu_bo_handle buf_handle = sem->buf_handle;
>> +			amdgpu_bo_cpu_unmap(buf_handle);
>> +			amdgpu_bo_free(buf_handle);
>> +		}
>> +	}
>>   	return 0;
>>   }
>>   
>> @@ -618,4 +654,27 @@ int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem)
>>   	return amdgpu_cs_unreference_sem(sem);
>>   }
>>   
>> +int amdgpu_cs_export_semaphore(amdgpu_semaphore_handle sem,
>> +			       uint32_t *shared_handle)
>> +{
>> +	return amdgpu_bo_export(sem->buf_handle,
>> +				amdgpu_bo_handle_type_dma_buf_fd,
>> +				shared_handle);
>> +
>> +}
>> +
>> +int amdgpu_cs_import_semaphore(amdgpu_semaphore_handle *sem,
>> +			       amdgpu_device_handle dev, uint32_t shared_handle)
>> +{
>> +	struct amdgpu_bo_import_result output;
>> +	int r;
>> +
>> +	r = amdgpu_bo_import(dev,
>> +			     amdgpu_bo_handle_type_dma_buf_fd,
>> +			     shared_handle,
>> +			     &output);
>> +	if (r)
>> +		return r;
>>   
>> +	return amdgpu_bo_cpu_map(output.buf_handle, sem);
>> +}
>> diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h
>> index ccc85d7..7c422da 100644
>> --- a/amdgpu/amdgpu_internal.h
>> +++ b/amdgpu/amdgpu_internal.h
>> @@ -134,6 +134,8 @@ struct amdgpu_semaphore {
>>   	atomic_t refcount;
>>   	struct list_head list;
>>   	struct drm_amdgpu_fence signal_fence;
>> +	amdgpu_bo_handle buf_handle;
>> +	uint32_t version;
>>   };
>>   
>>   /**
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------050801070309090100050705
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2016年08月21日 14:23, Edward
      O'Callaghan wrote:<br>
    </div>
    <blockquote
      cite="mid:cf458d97-d40a-d363-b5c4-2ae45dde9179-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">

On 08/18/2016 05:55 PM, Chunming Zhou wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">They are used for sharing semaphore across process.

Change-Id: I262adf10913d365bb93368b492e69140af522c64
Signed-off-by: Chunming Zhou <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 amdgpu/amdgpu.h          | 40 ++++++++++++++++++++++++++++++
 amdgpu/amdgpu_cs.c       | 63 ++++++++++++++++++++++++++++++++++++++++++++++--
 amdgpu/amdgpu_internal.h |  2 ++
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 693d841..e716855 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -1379,6 +1379,19 @@ int amdgpu_svm_commit(amdgpu_va_handle va_range_handle,
 int amdgpu_svm_uncommit(amdgpu_va_handle va_range_handle);
 
 /**
+ *  create shared semaphore
+ *
+ * \param amdgpu_device_handle
+ * \param   sem	   - \c [out] semaphore handle
+ *
+ * \return   0 on success\n
+ *          &lt;0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_create_semaphore_object(amdgpu_device_handle device_handle,
+				      amdgpu_semaphore_handle *sem);
+
+/**
  *  create semaphore
  *
  * \param   sem	   - \c [out] semaphore handle
@@ -1439,6 +1452,33 @@ int amdgpu_cs_wait_semaphore(amdgpu_context_handle ctx,
 int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem);
 
 /**
+ *  export semaphore
+ *
+ * \param   sem	    - \c [in] semaphore handle
+ * \param   shared_handle    - \c [out] handle across process
+ *
+ * \return   0 on success\n
+ *          &lt;0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_export_semaphore(amdgpu_semaphore_handle sem,
+			       uint32_t *shared_handle);
+/**
+ *  import semaphore
+ *
+ * \param   sem	    - \c [out] semaphore handle
+ * \param   dev	    - \c [in] device handle
+ * \param   shared_handle    - \c [in] handle across process
+ *
+ * \return   0 on success\n
+ *          &lt;0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_import_semaphore(amdgpu_semaphore_handle *sem,
+			       amdgpu_device_handle dev,
+			       uint32_t shared_handle);
+
+/**
  *  Get the ASIC marketing name
  *
  * \param   dev         - \c [in] Device handle. See #amdgpu_device_initialize()
diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index c76a675..a3ff34e 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -518,6 +518,34 @@ int amdgpu_cs_wait_fences(struct amdgpu_cs_fence *fences,
 	return r;
 }
 
+int amdgpu_cs_create_semaphore_object(amdgpu_device_handle device_handle,
+				      amdgpu_semaphore_handle *sem)
+{
+	struct amdgpu_bo_alloc_request req = {0};
+	amdgpu_bo_handle buf_handle;
+	int r;
+
+	if (NULL == sem)
</pre>
      </blockquote>
      <pre wrap="">
Since sem is ** then should we not check that *both* sem &amp;&amp; *sem are
non-NULL too? Further you can use the canonical form of (!sem)

</pre>
      <blockquote type="cite">
        <pre wrap="">+		return -EINVAL;
+
+	req.alloc_size = sizeof(struct amdgpu_semaphore);
+	req.preferred_heap = AMDGPU_GEM_DOMAIN_GTT;
+
+	r = amdgpu_bo_alloc(device_handle, &amp;req, &amp;buf_handle);
+	if (r)
+		return r;
+	r = amdgpu_bo_cpu_map(buf_handle, sem);
+	if (r) {
+		amdgpu_bo_free(buf_handle);
+		return r;
+	}
+	(*sem)-&gt;buf_handle = buf_handle;
+	atomic_set(&amp;(*sem)-&gt;refcount, 1);
</pre>
      </blockquote>
      <pre wrap="">
Hi Chunming,

When/where was 'amdgpu_semaphore_handle' introduced? I am not sure I
like pointers being hidden behind typedef's as opaque types this can
lead to really really bad things.. I only noticed sem was a ** because
of the weird looking deference then address operator application, then
deference again here, &amp;(*sem)-&gt;..</pre>
    </blockquote>
    Hi Edward,<br>
    semaphore was introduced last year, which is the wrapper of existing
    dependency.<br>
    Yeah, this whole sharing semaphore approach has been NAKed by
    Christian.<br>
    So we can skip this series now, we are going to use sync_file
    instead.<br>
    <br>
    Thanks,<br>
    David Zhou<br>
    <br>
    <blockquote
      cite="mid:cf458d97-d40a-d363-b5c4-2ae45dde9179-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">

Cheers,
Edward.

</pre>
      <blockquote type="cite">
        <pre wrap="">+	(*sem)-&gt;version = 2;
+
+	return 0;
+}
+
 int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
 {
 	struct amdgpu_semaphore *gpu_semaphore;
@@ -529,6 +557,7 @@ int amdgpu_cs_create_semaphore(amdgpu_semaphore_handle *sem)
 	if (NULL == gpu_semaphore)
 		return -ENOMEM;
 
+	gpu_semaphore-&gt;version = 1;
 	atomic_set(&amp;gpu_semaphore-&gt;refcount, 1);
 	*sem = gpu_semaphore;
 
@@ -608,8 +637,15 @@ static int amdgpu_cs_unreference_sem(amdgpu_semaphore_handle sem)
 	if (NULL == sem)
 		return -EINVAL;
 
-	if (update_references(&amp;sem-&gt;refcount, NULL))
-		free(sem);
+	if (update_references(&amp;sem-&gt;refcount, NULL)) {
+		if (sem-&gt;version == 1)
+			free(sem);
+		else if (sem-&gt;version == 2) {
+			amdgpu_bo_handle buf_handle = sem-&gt;buf_handle;
+			amdgpu_bo_cpu_unmap(buf_handle);
+			amdgpu_bo_free(buf_handle);
+		}
+	}
 	return 0;
 }
 
@@ -618,4 +654,27 @@ int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem)
 	return amdgpu_cs_unreference_sem(sem);
 }
 
+int amdgpu_cs_export_semaphore(amdgpu_semaphore_handle sem,
+			       uint32_t *shared_handle)
+{
+	return amdgpu_bo_export(sem-&gt;buf_handle,
+				amdgpu_bo_handle_type_dma_buf_fd,
+				shared_handle);
+
+}
+
+int amdgpu_cs_import_semaphore(amdgpu_semaphore_handle *sem,
+			       amdgpu_device_handle dev, uint32_t shared_handle)
+{
+	struct amdgpu_bo_import_result output;
+	int r;
+
+	r = amdgpu_bo_import(dev,
+			     amdgpu_bo_handle_type_dma_buf_fd,
+			     shared_handle,
+			     &amp;output);
+	if (r)
+		return r;
 
+	return amdgpu_bo_cpu_map(output.buf_handle, sem);
+}
diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h
index ccc85d7..7c422da 100644
--- a/amdgpu/amdgpu_internal.h
+++ b/amdgpu/amdgpu_internal.h
@@ -134,6 +134,8 @@ struct amdgpu_semaphore {
 	atomic_t refcount;
 	struct list_head list;
 	struct drm_amdgpu_fence signal_fence;
+	amdgpu_bo_handle buf_handle;
+	uint32_t version;
 };
 
 /**

</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------050801070309090100050705--

--===============1564368497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1564368497==--
