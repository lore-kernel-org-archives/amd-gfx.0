Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD1EC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Apr 2022 19:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F4710EA51;
	Sat, 30 Apr 2022 19:29:19 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848CD10EA46
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Apr 2022 19:29:18 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id l7so21197816ejn.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Apr 2022 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=rgBAwgkTHdYwQtKARVs7Ya1Ys4DKSdWxKu1cshY//3M=;
 b=nAn0/zlzedQSFRuQhzdaMJKMb8+y+soIPToiF6sxmQarUS/ueSnyHa9VjxC6vVsctv
 KrPpINn4V8aKgWcQsq1ntyM6xhz+/MBFOnvsVhmwwWYoMQI+vux6IIj7SDtMABQ4fUY4
 Ugj4d0+hnjlY0FNBEXXWiVXEFgNptX6lH5tvnCs7hggxEBA1N2dXbvB6NXqp4X26b3Mb
 7FbW2U6p0YjO/kk5hrYTzNdhywBRnwnSADXqWVoeL27lTqVIkQgkLcdW6gUXf4wfiBZP
 6r4xwAotMcojDjCkjoFDjAcZ97tlf4zuJlVg0TdUsky/2qYGuwHUiQqfMsRJyU0VLZG0
 aZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rgBAwgkTHdYwQtKARVs7Ya1Ys4DKSdWxKu1cshY//3M=;
 b=FKm3jG/iGV95+dj4LWcKnuDKPlmnbcC2sGkVWaIETXIZMMVeto1iL0wq8cLUTO0NhM
 dOxDxhFHHiKZZFHyOCLhjwF81fHIdX3OYfMCNf8AzB2gvsFgXJmoUarQcX+U4fn8YeLp
 J5hHlI+TlhTsDFzlk51mu0RQuCYwW9WeozKDvf1Q4wYpej6hJZZmQCd6qNjO4YaLiQ3p
 /aPK8onU3ysKsLan+y/6oMtx389YoEL6Po0be7HQ+aXKvFxD72qlebV3TWeoQbBgrDPT
 M6yI9EgmTEZvoMZ9c/82ZmvdyZrtA9HUsVLpS/LRNZVug7OHr6G+4N0HVksCzxPxoc4j
 YJLA==
X-Gm-Message-State: AOAM533tHoX93cX/TG3iExUACxlfZYc/n5iOOokmuZrsIxC9xeplH8tI
 0oDtKDyoQ84z6kplhE1+OdE=
X-Google-Smtp-Source: ABdhPJzbd55ZW9RqQjQOze20QzjN+C/83NLDz6mz/xUSvCLKpr2zCthhgll723e0csGbSmb4Smzb+g==
X-Received: by 2002:a17:906:4795:b0:6f3:d1cc:7127 with SMTP id
 cw21-20020a170906479500b006f3d1cc7127mr5023354ejc.461.1651346956948; 
 Sat, 30 Apr 2022 12:29:16 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:581f:99bb:cb4f:439c?
 ([2a02:908:1256:79a0:581f:99bb:cb4f:439c])
 by smtp.gmail.com with ESMTPSA id
 eo9-20020a1709069b0900b006f3ef214e00sm1891455ejc.102.2022.04.30.12.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Apr 2022 12:29:16 -0700 (PDT)
Message-ID: <85927512-377e-39b1-d812-ef9bddcc2f02@gmail.com>
Date: Sat, 30 Apr 2022 21:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Add out parameters to drm_amdgpu_sched
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220430151428.237089-1-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220430151428.237089-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.04.22 um 17:14 schrieb Arunpravin Paneer Selvam:
> - Add pipe and queue as out parameters to support high priority
>    queue test enabled in libdrm basic test suite.
>
> - Fetch amdgpu_ring pointer and pass sched info to userspace
>
> - Improve amdgpu_sched_ioctl() function
>
> The related merge request for enabling high priority test case are
> libdrm - https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/235
> mesa - https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/16262
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Well that is certainly a NAK since as far as I can see this breaks the 
UAPI in a not backward compatible way.

Then we absolutely should not pass scheduler info to userspace. That 
should be completely transparent to userspace.

So can you summarize once more why that should be necessary?

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 114 ++++++++--------------
>   include/uapi/drm/amdgpu_drm.h             |  14 ++-
>   2 files changed, 53 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index e9b45089a28a..fc2864b612d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -32,106 +32,72 @@
>   #include "amdgpu_sched.h"
>   #include "amdgpu_vm.h"
>   
> -static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
> -						  int fd,
> -						  int32_t priority)
> +int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
> +		       struct drm_file *filp)
>   {
> -	struct fd f = fdget(fd);
> +	union drm_amdgpu_sched *args = data;
> +	struct amdgpu_ctx *ctx, *ctx_ptr;
> +	struct drm_sched_entity *entity;
>   	struct amdgpu_fpriv *fpriv;
> -	struct amdgpu_ctx *ctx;
> -	uint32_t id;
> -	int r;
> -
> -	if (!f.file)
> -		return -EINVAL;
> -
> -	r = amdgpu_file_to_fpriv(f.file, &fpriv);
> -	if (r) {
> -		fdput(f);
> -		return r;
> -	}
> -
> -	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
> -		amdgpu_ctx_priority_override(ctx, priority);
> -
> -	fdput(f);
> -	return 0;
> -}
> -
> -static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
> -						  int fd,
> -						  unsigned ctx_id,
> -						  int32_t priority)
> -{
> +	struct amdgpu_ring *ring;
> +	u32 fd = args->in.fd;
>   	struct fd f = fdget(fd);
> -	struct amdgpu_fpriv *fpriv;
> -	struct amdgpu_ctx *ctx;
> +	u32 id;
>   	int r;
>   
>   	if (!f.file)
>   		return -EINVAL;
>   
>   	r = amdgpu_file_to_fpriv(f.file, &fpriv);
> -	if (r) {
> -		fdput(f);
> -		return r;
> -	}
> +	if (r)
> +		goto out_fd;
>   
> -	ctx = amdgpu_ctx_get(fpriv, ctx_id);
> +	ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>   
>   	if (!ctx) {
> -		fdput(f);
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_ctx_priority_override(ctx, priority);
> -	amdgpu_ctx_put(ctx);
> -	fdput(f);
> -
> -	return 0;
> -}
> -
> -int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
> -		       struct drm_file *filp)
> -{
> -	union drm_amdgpu_sched *args = data;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> -	int r;
> -
> -	/* First check the op, then the op's argument.
> -	 */
> -	switch (args->in.op) {
> -	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
> -	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
> -		break;
> -	default:
> -		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto out_fd;
>   	}
>   
>   	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>   		WARN(1, "Invalid context priority %d\n", args->in.priority);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto out_ctx;
>   	}
>   
>   	switch (args->in.op) {
>   	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
> -		r = amdgpu_sched_process_priority_override(adev,
> -							   args->in.fd,
> -							   args->in.priority);
> +		/* Retrieve all ctx handles and override priority  */
> +		idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx_ptr, id)
> +			amdgpu_ctx_priority_override(ctx_ptr, args->in.priority);
>   		break;
>   	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
> -		r = amdgpu_sched_context_priority_override(adev,
> -							   args->in.fd,
> -							   args->in.ctx_id,
> -							   args->in.priority);
> +		/* Override priority for a given context */
> +		amdgpu_ctx_priority_override(ctx, args->in.priority);
>   		break;
>   	default:
> -		/* Impossible.
> -		 */
> +		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
>   		r = -EINVAL;
> -		break;
> +		goto out_ctx;
>   	}
>   
> +	r = amdgpu_ctx_get_entity(ctx, args->in.ip_type, 0, args->in.ring,
> +				  &entity);
> +	if (r)
> +		goto out_ctx;
> +
> +	/* Fetch amdgpu_ring pointer */
> +	ring = to_amdgpu_ring(entity->rq->sched);
> +
> +	/* Pass sched info to userspace */
> +	memset(args, 0, sizeof(*args));
> +	args->out.info.pipe = ring->pipe;
> +	args->out.info.queue = ring->queue;
> +
> +out_ctx:
> +	amdgpu_ctx_put(ctx);
> +out_fd:
> +	fdput(f);
> +
>   	return r;
>   }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1d65c1fbc4ec..e93f1b6c4561 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -70,7 +70,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
>   #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> -#define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_SCHED		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>   
>   /**
>    * DOC: memory domains
> @@ -308,6 +308,11 @@ union drm_amdgpu_vm {
>   #define AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE	1
>   #define AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE	2
>   
> +struct drm_amdgpu_sched_info {
> +	__u32 pipe;
> +	__u32 queue;
> +};
> +
>   struct drm_amdgpu_sched_in {
>   	/* AMDGPU_SCHED_OP_* */
>   	__u32	op;
> @@ -315,10 +320,17 @@ struct drm_amdgpu_sched_in {
>   	/** AMDGPU_CTX_PRIORITY_* */
>   	__s32	priority;
>   	__u32   ctx_id;
> +	__u32   ip_type;
> +	__u32   ring;
> +};
> +
> +struct drm_amdgpu_sched_out {
> +	struct drm_amdgpu_sched_info info;
>   };
>   
>   union drm_amdgpu_sched {
>   	struct drm_amdgpu_sched_in in;
> +	struct drm_amdgpu_sched_out out;
>   };
>   
>   /*

