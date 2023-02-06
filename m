Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7E2C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 16:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A638610E9DB;
	Mon,  6 Feb 2023 16:57:01 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F5E10E9DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 16:56:59 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1442977d77dso15841740fac.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cj6PQAnaut3sid1SADE0r+UxiO075z3/44lMLIqI3oA=;
 b=OCEPdA6/WRMQ0UGkQlv6AWJ5x4IAk/KGUDwAs4fZWCkjvLDwO/CBN9tbnmvSllSdAb
 rlDrdM7zsysSy6eWbncvXppBPGkowowZCCnt20GIFic3+Kx32n7O4SMa9UGvxDSjzAvc
 S/A6hHUFMPw4xrqb2YyBuVrGX+DE/kyETF2mpIzMv2xOJJ/THuwPbsDAI40hw0hTEZGB
 hRo4BikAHyw7/AXHyBA4NrjZ+1sPCOqeC4KoquuhfjFZ2bjvpcKZzDkeGLp5xBsiHznH
 mxo/VHJc16TMBvKO59Cj6JW2RqQixHlEvheyNXvDl+u87p+9BVQeYc3TLt3p2qsrtQBW
 zWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cj6PQAnaut3sid1SADE0r+UxiO075z3/44lMLIqI3oA=;
 b=ggPh+cSvaQQw039bATEFZ+KBEhU5CLQtGnt11e9iGsuc2RpAnVd8wjjlMDduh0dXZi
 0H2K92TfNvnN+w0AkiIfVQDEr6PywJw0A4KEEc4uQBWYQy+c8fE1ioj4PKPifwDGJmRi
 E8UttRp7Y+UdXcU+oWxk5RT7vWhlWzE+7WsBCKKV/GTx4axbn0qoZaRdYRApGq/kV7g0
 0WI8TGAC3YGNJd0dja03ie2sBmYv1/xv5HQdqb4WR3wJH+ebnqC7WHUqlWBNmJb22IgC
 ZO8clmZrqED3RJO0mHKZgUbtq5FTa0UyX42LbSMAV9EYrNkBKysUkFURnSmYp7nJkmvR
 jN6w==
X-Gm-Message-State: AO0yUKXdnJwY+y6xrJJamzz+OlZs5copIddvGphm7KhuhWMiMgLviwPX
 D0IIVcWCpAw3WeP6i/CjQrQIzhvtsbYX2nSjvac82ztB
X-Google-Smtp-Source: AK7set/hSnjyVQtMOmpUMdiOpS4O/YSfWvq3Q+7L5EzxpJfUlK3CH9mNsNSJT4rz3hAf8tNObKxTLi5JP+fimPtw0Ek=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr49493oab.96.1675702619193; Mon, 06 Feb
 2023 08:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
In-Reply-To: <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 11:56:47 -0500
Message-ID: <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
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

On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> Hey Alex,
>
> On 03/02/2023 23:07, Alex Deucher wrote:
> > On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >> From: Alex Deucher <alexander.deucher@amd.com>
> >>
> >> This patch intorduces new UAPI/IOCTL for usermode graphics
> >> queue. The userspace app will fill this structure and request
> >> the graphics driver to add a graphics work queue for it. The
> >> output of this UAPI is a queue id.
> >>
> >> This UAPI maps the queue into GPU, so the graphics app can start
> >> submitting work to the queue as soon as the call returns.
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   include/uapi/drm/amdgpu_drm.h | 53 +++++++++++++++++++++++++++++++++++
> >>   1 file changed, 53 insertions(+)
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> >> index 4038abe8505a..6c5235d107b3 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -54,6 +54,7 @@ extern "C" {
> >>   #define DRM_AMDGPU_VM                  0x13
> >>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>   #define DRM_AMDGPU_SCHED               0x15
> >> +#define DRM_AMDGPU_USERQ               0x16
> >>
> >>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >> @@ -71,6 +72,7 @@ extern "C" {
> >>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>
> >>   /**
> >>    * DOC: memory domains
> >> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
> >>          union drm_amdgpu_ctx_out out;
> >>   };
> >>
> >> +/* user queue IOCTL */
> >> +#define AMDGPU_USERQ_OP_CREATE 1
> >> +#define AMDGPU_USERQ_OP_FREE   2
> >> +
> >> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >> +
> >> +struct drm_amdgpu_userq_mqd {
> >> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> >> +       __u32   flags;
> >> +       /** IP type: AMDGPU_HW_IP_* */
> >> +       __u32   ip_type;
> >> +       /** GEM object handle */
> >> +       __u32   doorbell_handle;
> >> +       /** Doorbell offset in dwords */
> >> +       __u32   doorbell_offset;
> > Since doorbells are 64 bit, maybe this offset should be in qwords.
>
> Can you please help to cross check this information ? All the existing
> kernel doorbell calculations are keeping doorbells size as sizeof(u32)

Doorbells on pre-vega hardware are 32 bits so that is where that comes
from, but from vega onward most doorbells are 64 bit.  I think some
versions of VCN may still use 32 bit doorbells.  Internally in the
kernel driver we just use two slots for newer hardware, but for the
UAPI, I think we can just stick with 64 bit slots to avoid confusion.
Even if an engine only uses a 32 bit one, I don't know that there is
much value to trying to support variable doorbell sizes.

Alex

>
> >
> >> +       /** GPU virtual address of the queue */
> >> +       __u64   queue_va;
> >> +       /** Size of the queue in bytes */
> >> +       __u64   queue_size;
> >> +       /** GPU virtual address of the rptr */
> >> +       __u64   rptr_va;
> >> +       /** GPU virtual address of the wptr */
> >> +       __u64   wptr_va;
> >> +};
> >> +
> >> +struct drm_amdgpu_userq_in {
> >> +       /** AMDGPU_USERQ_OP_* */
> >> +       __u32   op;
> >> +       /** Flags */
> >> +       __u32   flags;
> >> +       /** Queue handle to associate the queue free call with,
> >> +        * unused for queue create calls */
> >> +       __u32   queue_id;
> >> +       __u32   pad;
> >> +       /** Queue descriptor */
> >> +       struct drm_amdgpu_userq_mqd mqd;
> >> +};
> >> +
> >> +struct drm_amdgpu_userq_out {
> >> +       /** Queue handle */
> >> +       __u32   q_id;
> > Maybe this should be queue_id to match the input.
>
> Agree.
>
> - Shashank
>
> > Alex
> >
> >> +       /** Flags */
> >> +       __u32   flags;
> >> +};
> >> +
> >> +union drm_amdgpu_userq {
> >> +       struct drm_amdgpu_userq_in in;
> >> +       struct drm_amdgpu_userq_out out;
> >> +};
> >> +
> >>   /* vm ioctl */
> >>   #define AMDGPU_VM_OP_RESERVE_VMID      1
> >>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> >> --
> >> 2.34.1
> >>
