Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4FEC4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Dec 2022 20:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366D010E034;
	Sat, 24 Dec 2022 20:21:19 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7066710E034
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Dec 2022 20:21:11 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 e17-20020a9d7311000000b00678202573f1so4656869otk.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Dec 2022 12:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=koIEPIkGjKUfYILnXFUsgRFCs+WI/JLJbXfiimB3goA=;
 b=OCtb/6pn8pmaEe7a823ZcejD4IdFPJGr496YIH8uB5jEm8BPYlzKOugNjtNb8Voga7
 uyL/tYD46WIQWwBi6IEpihhYA70Hr9b0oJe7tnkvJYNffIwi8jyzXkSroQF3/cf3x60O
 s5L4509PdCBIEZLSvm4oxbm1fNAOEqDJ4bDzzG5n2LmmWX8wzkdOBSBc469LEN7FTd9r
 G5juf0TpAY9V7+62YaiPEkVtkg4kdSWCnb+VSLOEEtde/FHTnXfedRPMBtPU7H3PoI78
 uiNImsOCo29XQn3AKIIzUfmui+ygKSWTPRo1rNvVONK2YvknYuXEBGk8TyKTE9fauQST
 JFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koIEPIkGjKUfYILnXFUsgRFCs+WI/JLJbXfiimB3goA=;
 b=anC3kmUUUeZWCY/EpeWocrlz/0xRc/awWJsW5iHyHysNQa2s0QXRjFsD2VB9e4dHF8
 Q6k2i1+vC6OJuL6pVeKGiDD6RgpN/XNVZWInSoPHSrboQfHHg2ayWfXMrlaHA9BEgG9M
 ypZpwPaVGsGaPfFkr6X0sSs5bXlCefHNXsAuDlB9niw3H6EHz+XCMSXBjS2vMsrPxlx9
 hYlAsPqSMITXQQLWolQaW2helfQQHASr6B4LtbppnpK5oa57CxtHJbUGr0Sb1indL5pf
 yp/g6g5sGpkD0H9CqTl/9TjqMLBXr8mbigUoGFqep2troFcePoi7OdpxlmJxI18QqJHE
 PhXA==
X-Gm-Message-State: AFqh2kpor9oYq5peGSAqsrXX4I+2wHqRFz4Y4k+i3bf0qo4V6tzQFb2X
 r3cKNId70OhTwv3OEt9vGLz38NYCgasPGi0TYOwklA==
X-Google-Smtp-Source: AMrXdXslQF/BA1x3eLBMdHUb5zu5jT7FMtLK+DEHEWWgfCKqmBdyrssBe0OgzV6pQ4zkR0PCnb5+IZFkUxtWp19ptCk=
X-Received: by 2002:a05:6830:1bcc:b0:66e:9982:64a9 with SMTP id
 v12-20020a0568301bcc00b0066e998264a9mr845897ota.323.1671913270973; Sat, 24
 Dec 2022 12:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-2-shashank.sharma@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sat, 24 Dec 2022 21:20:59 +0100
Message-ID: <CAP+8YyGPy5oXpOcuWfaS1vNhGajG1VGZc4p_QiUxaLAFCtt5KQ@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 23, 2022 at 8:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 0d93ec132ebb..a3d0dd6f62c5 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>  #define DRM_AMDGPU_VM                  0x13
>  #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>  #define DRM_AMDGPU_SCHED               0x15
> +#define DRM_AMDGPU_USERQ               0x16
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>  #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>  #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>
>  /**
>   * DOC: memory domains
> @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
>         union drm_amdgpu_ctx_out out;
>  };
>
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE 1
> +#define AMDGPU_USERQ_OP_FREE   2
> +
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)

Can we document what AQL means here?


> +
> +struct drm_amdgpu_userq_mqd {
> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> +       __u32   flags;
> +       /** IP type: AMDGPU_HW_IP_* */
> +       __u32   ip_type;
> +       /** GEM object handle */
> +       __u32   doorbell_handle;
> +       /** Doorbell offset in dwords */
> +       __u32   doorbell_offset;

What are the doorbell handle/offset for? I don't see any of them used
in the rest of the series (we only check the handle isn't 0, which
isn't enough validation for a GEM handle to consider it valid), and
the kernel seems to allocate some kind of doorbell index in patch 4.
Does userspace need to know about that one? (similarly use_doorbell in
that patch seems like it is never explicitly written to)

The other questions I have are about how this interacts with memory
management. Does this have access to all BOs allocated with
AMDGPU_GEM_CREATE_VM_ALWAYS_VALID? What about imported BOs? How does
this interact with VA unmap/map operations? (AFAICT we have no way to
tell if pagetable modifying operations are complete from userspace for
now). What happens if we need to spill BOs from VRAM due to
(cross-process) memory pressure?

> +       /** GPU virtual address of the queue */
> +       __u64   queue_va;
> +       /** Size of the queue in bytes */
> +       __u64   queue_size;
> +       /** GPU virtual address of the rptr */
> +       __u64   rptr_va;
> +       /** GPU virtual address of the wptr */
> +       __u64   wptr_va;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +       /** AMDGPU_USERQ_OP_* */
> +       __u32   op;
> +       /** Flags */
> +       __u32   flags;
> +       /** Context handle to associate the queue with */
> +       __u32   ctx_id;
> +       __u32   pad;
> +       /** Queue descriptor */
> +       struct drm_amdgpu_userq_mqd mqd;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +       /** Queue handle */
> +       __u32   q_id;
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
> 2.34.1
>
