Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D9C79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCA010F1D8;
	Thu, 10 Sep 2026 13:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o525MRkD";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8619910F1D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:47:06 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab17a1e6so149385a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048026; cv=none;
 d=google.com; s=arc-20260327;
 b=VV++gM/t/Q7T9MSNlNbFWs3iIN8A3xi7g84HdhlXo7dQtanO6VYgiCEd/JvgXboMqr
 JX2SMJUpKCH+xu0FXMpCs6uG/TB53xluHtlk7EDCKx8RYgAOEwR170UARB9YO6vfIhrn
 E2kF1vta0F4CZOt31qGJAMfq2MX3/rmiwfEqG1mBSXyB3xcPKffW9S3pGJZYEFvXlrDX
 MmGoX0ak7ndPk3p/rVaNCzJ6cFuoEpH6+iXGDPgha0wxxY+8CF3NQcMIA6le4CKWrxWo
 yEfUIjAJoU3NNLM08pBzPQLy11jo0dUUBpnRGN+H3mX8l56gwn3JEYxy+GADHusV6aiB
 dWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lltNUV+MTO1LVvi0zYfxWX96sSnsAWbH789nqBfy24c=;
 fh=Xpc/MOklghAy99Z5OWGMBN3ZCVDrR4lZGUOTJLtgLiQ=;
 b=cvX1B1LZAQkErjHMLjXLSBjGpY1YFt3BFb2lxA4kjzOeFK43A7ksIH+TzD+nQ9PtOd
 Hu4aqhpttlkcW8KsKPQ7ENvGbraX+dyJpkdKTQTn14xRQDQdvbmEo9Tf5TpX+Kce9Dtq
 /uNVxMOzj0GoVi5Svki5HnRUeUeF6WTy05XDacndCHqnmxm6lQbI2aL0Mlv+x3+TpxDo
 6ntbzgbi84Xsc5UYEl1Oqp0kU7+216a8AbXKlMicmWtYOa2PCz0dhsXvVdsrT1IlGprE
 kRXDVyhfcn4o0sz0icijpP6LzSTxDouinXJvWPv3ah9Ap1S0kpk/gg99+y04VoV+nCS6
 M0RQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789048026; x=1789652826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lltNUV+MTO1LVvi0zYfxWX96sSnsAWbH789nqBfy24c=;
 b=o525MRkDAFWbIM9M/JcGTITwsG5n8aA6gfZgcePFTSsbENGvCTuaTUF/8NmJx0WsUC
 C4KTIdH7XnkQI5bgwsplmPvK9c5o5ZVzPXGLfqRVkB1pmwzAc6NynF+x/eei38oHusfQ
 K1eS1n26rZgT+dhj3ptI0dkLbU9k2Zsz4bE3OblzkABtFgPITlaF1Fz8V1DtRCErTXnP
 mWieAMNKxomJVma3ZMybPVdrkzVnC5xjQxNiicsr2r1B6WosfNKUJrH9YrCPtIanva82
 QzmA4L0Scbqmlnoit+Y1pP9ZqT5Z4RpJc1XP901c2VRTIoOqxXp6Th+ZRDxzUK7J/oh5
 zz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789048026; x=1789652826;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lltNUV+MTO1LVvi0zYfxWX96sSnsAWbH789nqBfy24c=;
 b=EUqNroABitB26cAAR+XUT4EdgDWUaOSOyPgJuIWY/mIUqYG0FkiHMz6uzd14LXjFOS
 VbU+1sKcjeWnRZDI1tczvNfpT9NMLQVazVF279zXcARR54ROd/38twGq2VK/QySEeTQm
 ivOdzVNbgXOwL0CQAnpIkfhl2yezR55cNxUPEwz4wafTlCXE97fRTzXMwpttLAuqEJNE
 o/02WUmPHh1xs8sPXnpId/efWumpahXK5siALOMzr1kqnbj+smGTHW03RiTT3LrlNNo0
 iHgu/u8W6xgbZ28SHA37n3A02445q8p7HUn9bedL8aUFU4ElJATr95bF6UAIDcpwLBZ3
 SWWA==
X-Gm-Message-State: AFuF++nIuVTsVKKv1XcNIDmIQS9Vh/tv5TyAZ5HgQF7F12pF1icygpOh
 Yiwi4hif5UTFR6ZFyf4+iqLWPeWtG+kYVpcbjbQx71AkxtneIz0aoT6mjbPVtB3DdpihWJUpugu
 Rt22FvZsH3MHF9VNdWQuvP+Q2ndj+oD3Q/g==
X-Gm-Gg: AYBFou30dupVem+1TRvshjCHt/53tqDSHZdLJ2hXwRhFlifk1SiI3JnDLtBmgbfJLQ7
 skyrnNhe1v0/uMTa94PyAFu/SYb1muijQXcQZYveTmKFG6XOSA6jWarq6GOB+xtKg/iVzXwVZqz
 aBnPQjL1n52ZMj/jCPyeotgmU8U8NcQq0GPLueaXl/hpU3gId8chFCzSDyUrJdgLHDrTem9jM6M
 fJugmuulAsk2+Yd3ViGf1GnHqzmB50g35bQSa1UpewPMQBJEfFgE4UZ/CBh4NQwg7vzQEjzbAsE
 2YM9Y7POkxpHatcs8OzJTHCwxZ2SrPWx2BSLAUdShtSdLsADKshkB7vPlYDXgbHb5T4rPrWw9/U
 33Icla5joZoAyafa1e6OOxp191G+xcqUMS4BZgFHZ3wyU/O6oj59E
X-Received: by 2002:a17:90b:2801:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-39b3d7d056fmr31987582a91.4.1789048025808; Thu, 10 Sep 2026
 06:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260831195550.962209-1-David.Francis@amd.com>
In-Reply-To: <20260831195550.962209-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Sep 2026 09:46:53 -0400
X-Gm-Features: AcwNN1X-h8_UKcJo9oNW60JP_44PEGkxHo338R5yrzLZmrt5Y73CfgyCqVjpb-E
Message-ID: <CADnq5_OLyH13wyE6bCRLYkheYjuhR_4PabYBQQkR8WUeGmRDJw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Add trace events for pid
 register/deregister
To: David Francis <David.Francis@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <Sunil.Khatri@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 31, 2026 at 3:56=E2=80=AFPM David Francis <David.Francis@amd.co=
m> wrote:
>
> Some debugging applications need to track when a process starts
> or stops using the amdgpu driver. For those processes, add ftrace
> events that track when a amdgpu_vm task info is changed or destroyed.
>
> v2: Deregister in fini, not destroy.
>
> v3: Also report render minor and major
>
> cc: Sunil Khatri <Sunil.Khatri@amd.com>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 33 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 26 +++++++++++++++
>  .../amd/amdkfd/ctx_save_restore_area_address  |  0
>  3 files changed, 59 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/ctx_save_restore_area_addr=
ess
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index 5324030a13f5..546794097631 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -732,6 +732,39 @@ TRACE_EVENT(amdgpu_userq_state_changed,
>                       __entry->client_id, __entry->queue_type, __entry->d=
oorbell_index, __entry->to)
>  );
>
> +TRACE_EVENT(amdgpu_register_pid,
> +           TP_PROTO(uint32_t pid, int major, int minor),
> +           TP_ARGS(pid, major, minor),
> +           TP_STRUCT__entry(
> +                       __field(u32, pid)
> +                       __field(int, major)
> +                       __field(int, minor)
> +           ),
> +           TP_fast_assign(
> +                       __entry->pid =3D pid;
> +                       __entry->major =3D major;
> +                       __entry->minor =3D minor;
> +           ),
> +           TP_printk("amdgpu register pid %d render %d:%d",
> +                     __entry->pid, __entry->major, __entry->minor)
> +);
> +TRACE_EVENT(amdgpu_deregister_pid,
> +           TP_PROTO(uint32_t pid, int major, int minor),
> +           TP_ARGS(pid, major, minor),
> +           TP_STRUCT__entry(
> +                       __field(u32, pid)
> +                       __field(int, major)
> +                       __field(int, minor)
> +           ),
> +           TP_fast_assign(
> +                       __entry->pid =3D pid;
> +                       __entry->major =3D major;
> +                       __entry->minor =3D minor;
> +           ),
> +           TP_printk("amdgpu deregister pid %d render %d:%d",
> +                     __entry->pid, __entry->major, __entry->minor)
> +);
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index aac8ace9d7a6..6be83cd2e162 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -33,6 +33,7 @@
>
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_ioctl.h>
>  #include <drm/ttm/ttm_tt.h>
>  #include <drm/drm_exec.h>
>  #include "amdgpu.h"
> @@ -2530,6 +2531,12 @@ static int amdgpu_vm_create_task_info(struct amdgp=
u_vm *vm)
>         return 0;
>  }
>
> +static void amdgpu_vm_render_devt(struct amdgpu_device *adev, int *major=
, int *minor)
> +{
> +       *major =3D DRM_MAJOR;
> +       *minor =3D adev_to_drm(adev)->render->index;
> +}
> +
>  /**
>   * amdgpu_vm_set_task_info - Sets VMs task info.
>   *
> @@ -2543,6 +2550,18 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>         if (vm->task_info->task.pid =3D=3D current->pid)
>                 return;
>
> +       if (vm->root.bo) {
> +               struct amdgpu_device *adev =3D amdgpu_ttm_adev(vm->root.b=
o->tbo.bdev);
> +               int major, minor;
> +
> +               amdgpu_vm_render_devt(adev, &major, &minor);
> +
> +               if (vm->task_info->task.pid)
> +                       trace_amdgpu_deregister_pid(vm->task_info->task.p=
id,
> +                                                   major, minor);
> +               trace_amdgpu_register_pid(current->pid, major, minor);
> +       }
> +
>         vm->task_info->task.pid =3D current->pid;
>         get_task_comm(vm->task_info->task.comm, current);
>
> @@ -2803,6 +2822,13 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
>                          ti->process_name, ti->task.pid, ti->task.comm, t=
i->tgid);
>         }
>
> +       if (vm->task_info->task.pid) {
> +               int major, minor;
> +
> +               amdgpu_vm_render_devt(adev, &major, &minor);
> +               trace_amdgpu_deregister_pid(vm->task_info->task.pid, majo=
r, minor);
> +       }
> +
>         amdgpu_vm_put_task_info(vm->task_info);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/ctx_save_restore_area_address b/d=
rivers/gpu/drm/amd/amdkfd/ctx_save_restore_area_address
> new file mode 100644
> index 000000000000..e69de29bb2d1
> --
> 2.34.1
>
