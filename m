Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD58C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 22:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEA010E938;
	Fri,  3 Feb 2023 22:08:06 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB5C10E944
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 22:08:04 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id s17so5373743ois.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Feb 2023 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uchsUM6lQF18pQ78dwKeUQi72jurFBFwhUfv/BLDnek=;
 b=ZhkVmJPdyKhWsSPhSyd7wGFPwQkc82wi5BvymdvSR/eQeLLFJ6Ai4uxspv+/c3IsNP
 6fm1DK2CO8k8VYQd1RdkZJEylscLyOzcvE+csc3k+9MHL1Oz0yOrorvbjHwUyqMhafj4
 8d4OKQ3pzVjKvw+5Ylt261gQ+1EnBG9H1vX6nMFec5IT15boYd2HKHiTjflUdYrrLb1+
 HDvyr6HoHbM6Z9rA8/Az8kJX9U6AGfnPjwBbFtHCZkjkFRd1n6L5U7tbcAro1x+K67l5
 jHkTEuIzrCfu3/9Cx58vCLA9PbLy+evzqcehvxeazZCu89MpVq/XFJWbpiudh31kyDZ9
 ghFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uchsUM6lQF18pQ78dwKeUQi72jurFBFwhUfv/BLDnek=;
 b=7gNQuYNB7aoGUWaAHJt9JoqmZioqtm2DF5qwHghdg2lJG17v3xnjPdKpEvYtSS24El
 ngC0FFSpb0YBQ+TmjIwM6UyL1fjHwZwwJJh1bI+VirEoc9H4STDWw2L5CMr0XsJ/T5ZO
 IXoTy+ZeNdv1Ew7Cgq7wC5mvfVor/2zuGIVeWt4nzXclIXv9lTW0vEiZVhsasD/Ue4px
 64J/uoIJmDpDe2agbGge3ZeGE4TT2ZUMiASEZ/wNM23XB/fYXSQnmpTCL/OauZLCLtzm
 l3sX8IWCKmdF/hnUXWtJwCTNG1oKXxE2/YRD0qEzjfPN9GAi+rkZA2dXFtDQzUpVzg3u
 LAGw==
X-Gm-Message-State: AO0yUKX1A7RVYI2oZHznxryxABPYLjZUSBWZq6+P9A9F0TUtIUg7Whaz
 P6yBNHwvsSdij523FvavU16fyrDv1al4DjZagDtWdpxs
X-Google-Smtp-Source: AK7set+SELpUte/5hY9mq/cwC0h/8RKlvuX+egwftH0Q2W0YqYCZz2rotYHJSwNaMlQU+df/REKu6NIlsUVozj+wZek=
X-Received: by 2002:aca:e1c2:0:b0:35b:d93f:cbc4 with SMTP id
 y185-20020acae1c2000000b0035bd93fcbc4mr490683oig.96.1675462084054; Fri, 03
 Feb 2023 14:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
In-Reply-To: <20230203215409.2021-2-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Feb 2023 17:07:52 -0500
Message-ID: <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
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
>  include/uapi/drm/amdgpu_drm.h | 53 +++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 4038abe8505a..6c5235d107b3 100644
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
> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
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
> +       /** Doorbell offset in dwords */
> +       __u32   doorbell_offset;

Since doorbells are 64 bit, maybe this offset should be in qwords.


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
> +       __u32   q_id;

Maybe this should be queue_id to match the input.

Alex

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
