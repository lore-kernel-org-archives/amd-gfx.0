Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE36C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 17:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8270B10EBEB;
	Wed, 29 Mar 2023 17:57:43 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E1710EBEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 17:57:42 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id r16so12153404oij.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680112661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YijMcgFk7zhJBr/Nnxg/klaAr20/RMmKPDrGQ15ZrRQ=;
 b=kksMpxGDoj7xB9+rzbsaPtQiNGDG4uWTq2VgOSkBAtL0hZGDu5UYWVMllyxZNS1ASA
 NxTSVjqn4OhvTLGnyse331qpfce8/zefCFd+5493S4sYRl9hT8B9odgmhEXqrzqhOcbn
 T603lPaUR3wc8VxM6I8ugucS5TnflwqgOXdVOm4b5k7TqEPlFGGzljY+zUyEJhEgJEYg
 wocMtPGCU4izT9qv4qy9bUTYszdgSD5IiNLF73yRye9DeocynFNKLD2/aIO2TGOHIwoz
 xbbcmLF7Uf68kT4kEo8Hk30ej5zYtqxeCFdddRFEChzsDtmoV+1Cw4mq9+nTTMJbzNQ2
 GGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680112661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YijMcgFk7zhJBr/Nnxg/klaAr20/RMmKPDrGQ15ZrRQ=;
 b=q9d8Wlcz2LAFEga6tNMO0R4xFFWvAIIcR1vrhYe5AmC/5C0xXdqMHdEBezVBhK9hOE
 jfWqsVT+YN8DXm3hDUNlz4ZjQ+7HhzOvnQ28ifKplKUnu0NAwKqkTB5hgztDDohSVNGs
 1Nqx1inOUs6kME3ywd7wG7BAQm8PHcAdWgu/b+ScGod0Cync+BC2Wx0SqzKN04lRBaAE
 BHc3pxbiwyUzSUX3O5PoWqf9byW5wi1/dFQmVjCAcPZoSVx5mE38rPsQmJyPmUBjawnq
 DFX4Vrcvwarw2+J4GtGYrzCKfyy3YTUP1mEPf6TRfHM3M7XvG5Um2T5JBxPhKzyog6Qi
 S9mg==
X-Gm-Message-State: AAQBX9e3Kg7yMAlqWwTj7xCey0rQ46k1jdlwUaempT9rH7spaNQBAwQ+
 Jo9NP9QRVZ4nOH92xB+hKmxkzzOIkgQK6qsD2wKF0i+JXao=
X-Google-Smtp-Source: AKy350ZTJAZZpnLdUSB0D6PBZA+N7piA1EXHcoCzLiY4KuM1GWY6gARuiO8w/wnLAaNNcN2EsOiiFvRzag0QDe3vGAM=
X-Received: by 2002:aca:210c:0:b0:389:4e54:79f0 with SMTP id
 12-20020aca210c000000b003894e5479f0mr2639574oiz.3.1680112661188; Wed, 29 Mar
 2023 10:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-2-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Mar 2023 13:57:29 -0400
Message-ID: <CADnq5_PL8sVkpmEff2P03s0PRHsfsqWh1z6GtKZJCR0EDwzdjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 12:05=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
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
> V3: Integration with doorbell manager
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index cc5d551abda5..e4943099b9d2 100644
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
> @@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
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

We may want to make the MQD engine specific.  E.g., shadow is gfx
specific.  We also probably need the csa and gds buffers for gfx as
well.  Other engines may have their own additional buffer
requirements.

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
> 2.40.0
>
