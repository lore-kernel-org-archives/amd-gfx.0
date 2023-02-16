Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2C2C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 18:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2995C10E34D;
	Thu, 16 Feb 2023 18:50:42 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F0A10E34D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 18:50:40 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-16df32f2ffdso3678618fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=up6tmDL/MaVIpODKTzMNCHa1uFkgs53ewgHib6nzUIk=;
 b=Y7blUyG6NqCSlFCuuj+M6N2Euak66kP89szbe6sWCJK0R7wflBjfONi22lL3LkcQV+
 KYAZFkrxWjlqPd+fDYjF1O7sL0IAf1UeG14oqbks00m4w+7t6OFtMdxXv2lb1v3of8Pi
 diP4BBcs0GqepIzcbSKeZva1IcwUzb9YXch5BdqaPxLQVBWyv5cO3uIv37j4A3riA3Ri
 cJpN/OaCbt/HngPd7lLaOQJNW7vkwqxkHfUUVptAHfVWf+Qx1LZiP9j5LPbaejhKJGOQ
 gwAItQ+Uh2rbYipfbh7yotzX4Ot53I57yMnw4L7lBP4Z/6A6edGd38Uqx5MRGhtkOS+1
 dISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=up6tmDL/MaVIpODKTzMNCHa1uFkgs53ewgHib6nzUIk=;
 b=ivZHcyw23odhcM0nykzGcp78lg9QY8l7spwyIFwDH+lIFN9Cp++Ooi2DB4Bf+swlj4
 X3O8nAK0TJBjgrPslTkLmE/5dxdE9vP3iuDS7fnQbU6OLCCi16zYbmFNBN0tjllg587u
 T+hWoHIFmd1cpLUlym3DNDJfKXeZ/JeqLhbb+CVnyYCYxsYkP3WBNXo83R4eBJ64jtLZ
 FgnRXD8Wd5VgvZB6eLFgDwVyB0bLfOLc/XUJC32l7Ve9IIozQvoGj0SNH5uvpx8SO0cF
 lGKTxucVd8O6qjYai8NRmi+sRVvalRNWOA8Y0RcsxpO2C+YiqIe4BRpmyHQG65eYzEI8
 colg==
X-Gm-Message-State: AO0yUKXIeiHlTJa0REfDlFW6pNSfZ7dryI2GdZeK3Qsr9hzP1zgEqNSn
 3eE48zZnPPVXH7dfi3/e/sT0jfjFAEXe/BkWWrZt+Xz1ZTc=
X-Google-Smtp-Source: AK7set/vTV480d1OOTKm8MLywqrwlpoA3RtG+brd+GoxZcAtwzEDE/NlsibVZZ8DcEMVh5ukhWc/FTsU5RrkSrJUDh8=
X-Received: by 2002:a05:6870:1707:b0:16e:5bc4:ef0d with SMTP id
 h7-20020a056870170700b0016e5bc4ef0dmr299206oae.96.1676573439340; Thu, 16 Feb
 2023 10:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20230215184356.2205-1-shashank.sharma@amd.com>
 <20230215184356.2205-2-shashank.sharma@amd.com>
In-Reply-To: <20230215184356.2205-2-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Feb 2023 13:50:27 -0500
Message-ID: <CADnq5_OKUF8=a=XyCJdgUyw+UxB+GvrFpgQ59sVU5iYoGtG_mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] drm/amdgpu: UAPI for user queue management
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Arvind.Yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 15, 2023 at 1:44 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 4038abe8505a..2bc4869ee279 100644
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
> @@ -302,6 +304,59 @@ union drm_amdgpu_ctx {
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
> +struct drm_amdgpu_userq_mqd {
> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> +       __u32   flags;
> +       /** IP type: AMDGPU_HW_IP_* */
> +       __u32   ip_type;
> +       /** GEM object handle */
> +       __u32   doorbell_handle;
> +       /** Doorbell's offset in the doorbell bo */
> +       __u32   doorbell_offset;
> +       /** GPU virtual address of the queue */
> +       __u64   queue_va;
> +       /** Size of the queue in bytes */
> +       __u64   queue_size;
> +       /** GPU virtual address of the rptr */
> +       __u64   rptr_va;
> +       /** GPU virtual address of the wptr */
> +       __u64   wptr_va;
> +       /** GPU virtual address of the shadow context space */
> +       __u64   shadow_va;
> +};

We should test this with SDMA user queues as well to make sure we
haven't missed anything that it needs.  If sdma or vcn have major
differences, we might want to consider making drm_amdgpu_userq_mqd a
union.

Alex


> +
> +struct drm_amdgpu_userq_in {
> +       /** AMDGPU_USERQ_OP_* */
> +       __u32   op;
> +       /** Flags */
> +       __u32   flags;
> +       /** Queue handle to associate the queue free call with,
> +        * unused for queue create calls */
> +       __u32   queue_id;
> +       __u32   pad;
> +       /** Queue descriptor */
> +       struct drm_amdgpu_userq_mqd mqd;
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
> 2.34.1
>
