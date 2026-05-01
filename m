Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCAECD3427
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 13:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FAB710F51E;
	Fri,  1 May 2026 13:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M9jPeJn/";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B46910F51E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 13:26:50 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2daaab98000so86670eec.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2026 06:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642009; cv=none;
 d=google.com; s=arc-20240605;
 b=LU/3LpMV/s5O6UeEYkYPMhWPcxxg887q945dhqJPRMbYpTWn3fOEEG1jnY2GEWxcJp
 L3ZZiFd6hAKOiruSVHpFrDWpir6izWGeqCJ3kpirbBZOIyasWFcRatK1BsVC4hx6J0gH
 /OwSFxG4JyZiucITw0zsS76jvPbzj/ZMBFfjUgh0BxLywjcjO8EBbp6TI2kHUaI1F9GT
 L1dbMa+udAo4X/FZZ+DjQ8aUzB00otvdMqw8aPV+n4C3SX81gAcXZQW02/CPrXVKA8xF
 Kq2oN0/ZO9nklZY9z+AmAELajNuvhQ3mwF+cqM6rjRQOogYd1zcQ6gJyTEoKLwPjoppD
 psHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dygJ5nXAiVf4s4X/SYVdfRczbwvGfIX3uBenxTAJZ2E=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=NAJRNQSrNoFjDjKBfHaAfBibXaIe2lPYwCUA7TbIXnNDzj1HA+iWMZ6rbfgNAvw5R7
 Zdk8+8hteKaWlIeT4iXMMyygp2RIOUVaYbN5rbOr8Ez4juBfPkvNugD3Q4RoBu9tr996
 dEAotwHVBNtg9CjafKA8tqwhvCJhGwasVO8KThGyOkmMSe/eJsGsOAek8BKEeW3cAd8o
 SPjPDbZyj4GeuixUT+lR76HXy3K3OHZRS8PhbsuGF4I08JqiSpP0iCjkHbObcFHjGSr0
 dwIMQxOslmPD6ps7ocwHVpZ2P1iQ3rDf2IyzOr1uU3ERhWlO9fJz0iiiXSoWyEs3l8of
 gJxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777642009; x=1778246809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dygJ5nXAiVf4s4X/SYVdfRczbwvGfIX3uBenxTAJZ2E=;
 b=M9jPeJn/JBxIvO6V67r9LRLQ6ozUiOURSw+R/z5Zi7AVw8SvdIO42dZ28EcvPHR0wO
 ok8qyOGKis5MiXIlBH7AoKTUixtUFCy9bZYQLJvGzcwlO2zUQUYDNuNRWz0p11O9ocVV
 z2PoSXZvnXY0FTTGhgRIgjH9FBCyIX+KY9yzFDL40mIGX5/Wq252FZRRzQpSDdM9WWjx
 YncZClhc9FbNcPd8YLm9kpgRD9vOyDRNwVlleilNsHqcLFT0yjcVLKr5/1OsRpP9+EKt
 iNnCLBykCMFzoj2C2n983VCvLsO7Wi8khOt0LuowCofeRuWi8Hl9q3WXrnZzSU/6uw5/
 lKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777642009; x=1778246809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dygJ5nXAiVf4s4X/SYVdfRczbwvGfIX3uBenxTAJZ2E=;
 b=ZhJw2841QNUarMSlONJMtDm9BJ+xNFrkERybIFbnb85Md5bit4DXb8FGRWqMyeWQO2
 HlQhi8XxW/PHjsFBAu1kQFsS791PHSA/TwpbZIBFYCuE42ICPCaBAFmljbEx/NqYKeQX
 RkTsaU70jEKpOvUCKUAzrQuLQPCnU/06jufYcQyf+65SdMnUHTbRoNRyIUmCfkSeJP+i
 T3yrmFmnm3OaSknU342gobElhfXZy/gqfeE3iOk19e34ywCdgTEbuQfAK7Hmq/dkEuQF
 FFjyMQIELyFeMAhnf6In+EYTv0us9S/WTukYNFLW8Bw3Vh2GpFk7eLSFQbkomswBFpYv
 BOdQ==
X-Gm-Message-State: AOJu0YzGK+Uh4oeLbkiK/lPHa2C7XcOIqivo6G2Ycp2TdwQGaxXG7peK
 CT8EtwDCtd7OQyfaccfJoY5Z9bfPqZSLMctAeM2d4vghsBSNk80sqbEbJab7R5mRBnm9dBtaXba
 /kJfHmmLjuGOTR3oBdQymHB2C/o8rH2JG7A==
X-Gm-Gg: AeBDieuYojRF67VvXRdwPdJF5I4vGOQHWt1ov1LppNfE0Q2a5Q3H+XzMPtazIa3H6lr
 aTqnR2oKHwbdsfyEuxxWTXPTnqYIKJ745F/oOi4hRJ3fUcJo17gekNLET/wkvsZ5XfWTmjJQwoH
 rrA8ZF5p++7oW+j2A4llzwvwGk/97KdPthEJuS9IKOPZqZ54SEw2pVCI1xxBD3S3GcmUVQ1g9KS
 sn/qa5l9qrJzrSj4ZS2oM8U/405CSNY7iaWovYtlzR+HcNkIeI3a6RfOC04v/TfzAsoaSbYDvxg
 9ViYSJvQhaLCaiRHQOyGxm7xc3gBlQbGSNLf66sB93s/nVuB1lZaA2K0q++mScX76CcgLDZOMm4
 R6q24
X-Received: by 2002:a05:7022:207:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-12dead3a2fdmr1807067c88.7.1777642009178; Fri, 01 May 2026
 06:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 May 2026 09:26:37 -0400
X-Gm-Features: AVHnY4L475H3cs2fQTaIaPVyaBvLC8yia2cJtLR52N7CFSWT44YAWG8ycNrtm20
Message-ID: <CADnq5_Om5f9MUrfaKAfHaoW1p8ui8qEPY9Ru4DRv4Vq5QCtCwQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] drm/amdgpu/mes: add NOTIFY_WORK_ON_UNMAPPED_QUEUE
 op + ADD_QUEUE fields
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Apr 30, 2026 at 12:29=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: "Jesse.zhang" <Jesse.zhang@amd.com>
>
> Kernel-side abstraction work for the SDMA usermode-queue plumbing
> landed in subsequent per-engine patches:
>
> - mes_add_queue_input gains is_user_mode_submission and
>   unmap_flag_addr.  Without is_user_mode_submission MES treats SDMA
>   queues as kernel-managed and uses the end-of-MQD slot for the unmap
>   flag, so PROTECTED_FENCE at the tail of every SDMA IB looks like a
>   "queue done" signal and MES gangs the queue out forever.
>
> - mes_misc_opcode gains MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
>   with a notify_work.priority_level payload.  This wakes a gangs-out
>   SDMA UMQ so subsequent IBs get re-mapped (SDMA has no
>   CP_UNMAPPED_DOORBELL HW intercept).
>
> Also surface the matching firmware bits in mes_v12_api_def.h:
> is_user_mode_submission / enable_perf_profiling /
> exclude_process_limit / is_video_blit_queue bitfields in
> MESAPI__ADD_QUEUE, and the unmap_flag_addr packet field.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 +++++++
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 12 +++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index cafc5caae822..705056de94b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -265,6 +265,8 @@ struct mes_add_queue_input {
>         uint32_t        exclusively_scheduled;
>         uint32_t        sh_mem_config_data;
>         uint32_t        vm_cntx_cntl;
> +       uint32_t        is_user_mode_submission;
> +       uint64_t        unmap_flag_addr;
>  };
>
>  struct mes_remove_queue_input {
> @@ -343,6 +345,7 @@ enum mes_misc_opcode {
>         MES_MISC_OP_WRM_REG_WR_WAIT,
>         MES_MISC_OP_SET_SHADER_DEBUGGER,
>         MES_MISC_OP_CHANGE_CONFIG,
> +       MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE,
>  };
>
>  struct mes_misc_op_input {
> @@ -397,6 +400,10 @@ struct mes_misc_op_input {
>                                 uint32_t tdr_delay;
>                         } tdr_config;
>                 } change_config;
> +
> +               struct {
> +                       uint32_t priority_level;
> +               } notify_work;
>         };
>  };
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index e541a43714a1..cd6e60184a06 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -381,7 +381,11 @@ union MESAPI__ADD_QUEUE {
>                         uint32_t exclusively_scheduled : 1;
>                         uint32_t is_long_running : 1;
>                         uint32_t is_dwm_queue : 1;
> -                       uint32_t reserved        : 15;
> +                       uint32_t is_video_blit_queue : 1;
> +                       uint32_t is_user_mode_submission : 1;
> +                       uint32_t enable_perf_profiling : 1;
> +                       uint32_t exclude_process_limit : 1;
> +                       uint32_t reserved        : 11;
>                 };
>                 struct MES_API_STATUS   api_status;
>                 uint64_t                tma_addr;
> @@ -393,6 +397,12 @@ union MESAPI__ADD_QUEUE {
>                 uint32_t                queue_id;
>                 uint32_t                alignment_mode_setting;
>                 uint32_t                full_sh_mem_config_data;
> +               /*
> +                * MC addr where MES writes 1 when it unmaps the queue.  =
Used
> +                * by user-mode SDMA UMQs so the kernel/userspace can det=
ect
> +                * the unmapped state and re-arm work via NOTIFY_WORK_ON_=
UNMAPPED_QUEUE.
> +                */
> +               uint64_t                unmap_flag_addr;
>         };
>
>         uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> --
> 2.49.0
>
