Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED0AC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 21:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6908810E5D7;
	Fri, 19 May 2023 21:04:05 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F6810E584
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 21:04:02 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-38ef6217221so2311915b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684530241; x=1687122241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gdvfb9hdfbFjNqYQ1hqK4xbOeXFfvfWgssy7qY5DDWo=;
 b=hoUMYqyox6Qx+One59KY0qqmGydF35w2ytapU47GBzsR+lpJkQoYRoxVARrMM9IkTN
 hsREgFvrK3IUZtnAU/hY70rE5AU8ql/9/KK0KNjFu2+wyeYjY2VJM4CBzHmarVFJdKGl
 4z2HtnjjvVV9VoH4BBJm3GLyeP6cCQ1W0wtbKqLmQ6EFRVrku5qZ11uNDTMmQNJ2hHly
 fyKj1diC+eusabKH8c/Xl6ktFAm3LaCh1JaK7PDUarZUv0GPPiKQvmhI/OQ1eefmm5GZ
 2N6v27ufzTCVZU3PvHPkuhAjuJawmwAWgRKzbuiOuTxAuWM01xlQJLROqcwFzV4PKKfE
 d7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684530241; x=1687122241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gdvfb9hdfbFjNqYQ1hqK4xbOeXFfvfWgssy7qY5DDWo=;
 b=bS14zwKmyr6oaZdJw8dBYlGAJoYCfTWcLOJe5v1m8DCDk58v61ZyAN6kvNfcqTwQeH
 gZaqcXXAl4o5UqCJ36iDG83HeW6vziDyRoQ87NHOxaaKWLbzuV9ubOvtnLdYdZp/NgxY
 a2azDcAFKImcYlhwmvoZ0dWCbIgTkhQ289kcBQMTnKoRajDIh4hBlVWFdSRu9sd8OpQE
 eUxTq9bLwef9/mxh0+wEC2aUODCjH3UqSj34pvodTGkDgTwmaR2oWupdK84PAE7eiNrz
 oRdRParVpGsIgf3bNftYg+TFiwxJwPmGDR6M0CqigNnTkSxFShFP49UwQFS0tBvXLNkw
 iwow==
X-Gm-Message-State: AC+VfDyQSjGvo/F4yXeInY3Lc//lw4hjw35yX85loLPXQdeO+EQpRE7p
 tKf2kQmtVGu1YgwV2eHqSEaDksuOrfgPgeuejl4=
X-Google-Smtp-Source: ACHHUZ6sKqKU0LemkP+XWTTmxX+Cgi6D8LYGdpaWdZX+BICTyasgBXWlRxobJSpox/MQiZnPyAjLgwmro1kRfMHFcac=
X-Received: by 2002:a05:6808:2d9:b0:396:3d0e:6401 with SMTP id
 a25-20020a05680802d900b003963d0e6401mr2028748oid.13.1684530240997; Fri, 19
 May 2023 14:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-2-shashank.sharma@amd.com>
In-Reply-To: <20230424173836.1441-2-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 17:03:49 -0400
Message-ID: <CADnq5_OxREJKeLwMiu_kkA4HjBBcyW_D6vOzeo=vUsMWM3ocLA@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] drm/amdgpu: UAPI for user queue management
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 24, 2023 at 1:39=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch intorduces new UAPI/IOCTL for usermode graphics
> queue. The userspace app will fill this structure and request
> the graphics driver to add a graphics work queue for it. The
> output of this UAPI is a queue id.
>
> This UAPI maps the queue into GPU, so the graphics app can start
> submitting work to the queue as soon as the call returns.
>
> V2: Addressed review comments from Alex and Christian
>     - Make the doorbell offset's comment clearer
>     - Change the output parameter name to queue_id
>
> V3: Integration with doorbell manager
>
> V4:
>     - Updated the UAPI doc (Pierre-Eric)
>     - Created a Union for engine specific MQDs (Alex)
>     - Added Christian's R-B
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 95 +++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 4038abe8505a..083a1df8e8ef 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>  #define DRM_AMDGPU_VM                  0x13
>  #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>  #define DRM_AMDGPU_SCHED               0x15
> +#define DRM_AMDGPU_USERQ               0x16
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_VM, union drm_amdgpu_vm)
>  #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM=
_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>  #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AM=
DGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AM=
DGPU_USERQ, union drm_amdgpu_userq)
>
>  /**
>   * DOC: memory domains
> @@ -302,6 +304,99 @@ union drm_amdgpu_ctx {
>         union drm_amdgpu_ctx_out out;
>  };
>
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE 1
> +#define AMDGPU_USERQ_OP_FREE   2
> +
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> +
> +/*
> + * MQD (memory queue descriptor) is a set of parameters which allow
> + * the GPU to uniquely define and identify a usermode queue.
> + */
> +struct drm_amdgpu_userq_mqd_gfx {
> +       /**
> +        * @flags: flags to indicate special function for queue like secu=
re
> +        * buffer (TMZ). Unused for now.
> +        */
> +       __u32   flags;
> +       /**
> +        * @doorbell_handle: the handle of doorbell GEM object
> +        * associated to this client.
> +        */
> +       __u32   doorbell_handle;
> +       /**
> +        * @doorbell_offset: 32-bit offset of the doorbell in the doorbel=
l bo.
> +        * Kernel will generate absolute doorbell offset using doorbell_h=
andle
> +        * and doorbell_offset in the doorbell bo.
> +        */
> +       __u32   doorbell_offset;
> +       /**
> +        * @queue_va: Virtual address of the GPU memory which holds the q=
ueue
> +        * object. The queue holds the workload packets.
> +        */
> +       __u64   queue_va;
> +       /**
> +        * @queue_size: Size of the queue in bytes, this needs to be 256-=
byte
> +        * aligned.
> +        */
> +       __u64   queue_size;
> +       /**
> +        * @rptr_va : Virtual address of the GPU memory which holds the r=
ing RPTR.
> +        * This object must be at least 8 byte in size and aligned to 8-b=
yte offset.
> +        */
> +       __u64   rptr_va;
> +       /**
> +        * @wptr_va : Virtual address of the GPU memory which holds the r=
ing WPTR.
> +        * This object must be at least 8 byte in size and aligned to 8-b=
yte offset.
> +        *
> +        * Queue, RPTR and WPTR can come from the same object, as long as=
 the size
> +        * and alignment related requirements are met.
> +        */
> +       __u64   wptr_va;
> +       /**
> +        * @shadow_va: Virtual address of the GPU memory to hold the shad=
ow buffer.
> +        * This must be a from a separate GPU object, and must be at leas=
t 4-page
> +        * sized.
> +        */
> +       __u64   shadow_va;

You were planning to add the other pointers here as well for gds and csa ri=
ght?

> +};
> +
> + /*
> +  * MQD can be different for different GPU IP/engine. This union will
> +  * contain structures of MQDs corresponding to different engines.
> +  */
> +union drm_amdgpu_userq_mqd {
> +       struct drm_amdgpu_userq_mqd_gfx gfx;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +       /** AMDGPU_USERQ_OP_* */
> +       __u32   op;
> +       /** Flags */
> +       __u32   flags;
> +       /** Queue handle for USERQ_OP_FREE */
> +       __u32   queue_id;
> +       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
> +       __u32   ip_type;
> +
> +       /** Queue descriptor for USERQ_OP_CREATE */
> +       union drm_amdgpu_userq_mqd mqd;

Just thinking out loud here, I wonder if we should make this a
pointer/size element so that we could make this variable sized in case
some future MQD ends up being bigger.  I guess we could always add a
AMDGPU_USERQ_OP_CREATE2 if we ever need to expand it.

Alex

> +};
> +
> +struct drm_amdgpu_userq_out {
> +       /** Queue handle */
> +       __u32   queue_id;
> +       /** Flags */
> +       __u32   flags;
> +};
> +
> +union drm_amdgpu_userq {
> +       struct drm_amdgpu_userq_in in;
> +       struct drm_amdgpu_userq_out out;
> +};
> +
>  /* vm ioctl */
>  #define AMDGPU_VM_OP_RESERVE_VMID      1
>  #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> --
> 2.40.0
>
