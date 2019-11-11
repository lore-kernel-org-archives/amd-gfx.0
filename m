From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Avoid using doorbell_off as offset in
 process doorbell pages
Date: Mon, 11 Nov 2019 15:43:26 -0500
Message-ID: <a21e8321-51bf-f840-f891-2335be774131@amd.com>
References: <20191101201016.5973-1-Yong.Zhao@amd.com>
 <20191101201016.5973-2-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1984142243=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191101201016.5973-2-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1984142243==
Content-Type: multipart/alternative;
 boundary="------------CC5366C46AF467F5E40B6DD6"
Content-Language: en-US

--------------CC5366C46AF467F5E40B6DD6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2019-11-01 16:10, Zhao, Yong wrote:
> dorbell_off in the queue properties is mainly used for the doorbell dw
> offset in pci bar. We should not set it to the doorbell byte offset in
> process doorbell pages. This makes the code much easier to read.

I kind of agree. I think what's confusing is that the queue_properties 
structure is used for two different purposes.

 1. For storing queue properties provided by user mode through KFD ioctls
 2. A subset of struct queue passed to mqd_manager and elsewhere (that's
    why some driver state is creeping into it)

Maybe a follow-up could cleanly separate the queue properties from the 
queue driver state. That would probably change some internal interfaces 
to use struct queue instead of queue_properties.

Anyway, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

> Change-Id: I553045ff9fcb3676900c92d10426f2ceb3660005
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             | 12 ++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c              |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  8 ++++++--
>   4 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index d9e36dbf13d5..b91993753b82 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -258,6 +258,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	unsigned int queue_id;
>   	struct kfd_process_device *pdd;
>   	struct queue_properties q_properties;
> +	uint32_t doorbell_offset_in_process = 0;
>   
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
> @@ -286,7 +287,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id);
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
> +			&doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
>   
> @@ -298,12 +300,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
>   	args->doorbell_offset <<= PAGE_SHIFT;
>   	if (KFD_IS_SOC15(dev->device_info->asic_family))
> -		/* On SOC15 ASICs, doorbell allocation must be
> -		 * per-device, and independent from the per-process
> -		 * queue_id. Return the doorbell offset within the
> -		 * doorbell aperture to user mode.
> +		/* On SOC15 ASICs, include the doorbell offset within the
> +		 * process doorbell frame, which could be 1 page or 2 pages.
>   		 */
> -		args->doorbell_offset |= q_properties.doorbell_off;
> +		args->doorbell_offset |= doorbell_offset_in_process;
>   
>   	mutex_unlock(&p->mutex);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> index d59f2cd056c6..1d33c4f25263 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> @@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
>   	properties.type = KFD_QUEUE_TYPE_DIQ;
>   
>   	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
> -				&properties, &qid);
> +				&properties, &qid, NULL);
>   
>   	if (status) {
>   		pr_err("Failed to create DIQ\n");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 7c561c98f2e2..66bae8f2dad1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -907,7 +907,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct kfd_dev *dev,
>   			    struct file *f,
>   			    struct queue_properties *properties,
> -			    unsigned int *qid);
> +			    unsigned int *qid,
> +			    uint32_t *p_doorbell_offset_in_process);
>   int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
>   int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
>   			struct queue_properties *p);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 8509814a6ff0..48185d2957e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -192,7 +192,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct kfd_dev *dev,
>   			    struct file *f,
>   			    struct queue_properties *properties,
> -			    unsigned int *qid)
> +			    unsigned int *qid,
> +			    uint32_t *p_doorbell_offset_in_process)
>   {
>   	int retval;
>   	struct kfd_process_device *pdd;
> @@ -307,8 +308,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		/* Return the doorbell offset within the doorbell page
>   		 * to the caller so it can be passed up to user mode
>   		 * (in bytes).
> +		 * There are always 1024 doorbells per process, so in case
> +		 * of 8-byte doorbells, there are two doorbell pages per
> +		 * process.
>   		 */
> -		properties->doorbell_off =
> 		*p_doorbell_offset_in_process =

You need a NULL pointer check here because you call this with a NULL 
pointer from the DIQ code.


>   			(q->properties.doorbell_off * sizeof(uint32_t)) &
>   			(kfd_doorbell_process_slice(dev) - 1);
>   

--------------CC5366C46AF467F5E40B6DD6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 2019-11-01 16:10, Zhao, Yong wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao-5C7GfCeVMHo@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">dorbell_off in the queue properties is mainly used for the doorbell dw
offset in pci bar. We should not set it to the doorbell byte offset in
process doorbell pages. This makes the code much easier to read.</pre>
    </blockquote>
    <p>I kind of agree. I think what's confusing is that the
      queue_properties structure is used for two different purposes.</p>
    <ol>
      <li>For storing queue properties provided by user mode through KFD
        ioctls</li>
      <li>A subset of struct queue passed to mqd_manager and elsewhere
        (that's why some driver state is creeping into it)<br>
      </li>
    </ol>
    <p>Maybe a follow-up could cleanly separate the queue properties
      from the queue driver state. That would probably change some
      internal interfaces to use struct queue instead of
      queue_properties.<br>
    </p>
    <p>Anyway, this patch is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao-5C7GfCeVMHo@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">
Change-Id: I553045ff9fcb3676900c92d10426f2ceb3660005
Signed-off-by: Yong Zhao <a class="moz-txt-link-rfc2396E" href="mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org">&lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             | 12 &#43;&#43;&#43;&#43;&#43;&#43;------
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c              |  2 &#43;-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  3 &#43;&#43;-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  8 &#43;&#43;&#43;&#43;&#43;&#43;--
 4 files changed, 15 insertions(&#43;), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d9e36dbf13d5..b91993753b82 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -258,6 &#43;258,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	unsigned int queue_id;
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
&#43;	uint32_t doorbell_offset_in_process = 0;
 
 	memset(&amp;q_properties, 0, sizeof(struct queue_properties));
 
@@ -286,7 &#43;287,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			p-&gt;pasid,
 			dev-&gt;id);
 
-	err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &amp;queue_id);
&#43;	err = pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &amp;queue_id,
&#43;			&amp;doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
 
@@ -298,12 &#43;300,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	args-&gt;doorbell_offset |= KFD_MMAP_GPU_ID(args-&gt;gpu_id);
 	args-&gt;doorbell_offset &lt;&lt;= PAGE_SHIFT;
 	if (KFD_IS_SOC15(dev-&gt;device_info-&gt;asic_family))
-		/* On SOC15 ASICs, doorbell allocation must be
-		 * per-device, and independent from the per-process
-		 * queue_id. Return the doorbell offset within the
-		 * doorbell aperture to user mode.
&#43;		/* On SOC15 ASICs, include the doorbell offset within the
&#43;		 * process doorbell frame, which could be 1 page or 2 pages.
 		 */
-		args-&gt;doorbell_offset |= q_properties.doorbell_off;
&#43;		args-&gt;doorbell_offset |= doorbell_offset_in_process;
 
 	mutex_unlock(&amp;p-&gt;mutex);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index d59f2cd056c6..1d33c4f25263 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 &#43;185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev-&gt;pqm, dbgdev-&gt;dev, NULL,
-				&amp;properties, &amp;qid);
&#43;				&amp;properties, &amp;qid, NULL);
 
 	if (status) {
 		pr_err(&quot;Failed to create DIQ\n&quot;);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7c561c98f2e2..66bae8f2dad1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -907,7 &#43;907,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct kfd_dev *dev,
 			    struct file *f,
 			    struct queue_properties *properties,
-			    unsigned int *qid);
&#43;			    unsigned int *qid,
&#43;			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
 			struct queue_properties *p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8509814a6ff0..48185d2957e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -192,7 &#43;192,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct kfd_dev *dev,
 			    struct file *f,
 			    struct queue_properties *properties,
-			    unsigned int *qid)
&#43;			    unsigned int *qid,
&#43;			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
 	struct kfd_process_device *pdd;
@@ -307,8 &#43;308,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		/* Return the doorbell offset within the doorbell page
 		 * to the caller so it can be passed up to user mode
 		 * (in bytes).
&#43;		 * There are always 1024 doorbells per process, so in case
&#43;		 * of 8-byte doorbells, there are two doorbell pages per
&#43;		 * process.
 		 */
-		properties-&gt;doorbell_off =
		*p_doorbell_offset_in_process =</pre>
    </blockquote>
    <p>You need a NULL pointer check here because you call this with a
      NULL pointer from the DIQ code.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20191101201016.5973-2-Yong.Zhao-5C7GfCeVMHo@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">
 			(q-&gt;properties.doorbell_off * sizeof(uint32_t)) &amp;
 			(kfd_doorbell_process_slice(dev) - 1);
 
</pre>
    </blockquote>
  </body>
</html>

--------------CC5366C46AF467F5E40B6DD6--

--===============1984142243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1984142243==--
