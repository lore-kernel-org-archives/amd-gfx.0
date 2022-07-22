Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77010C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15F78BEC1;
	Fri, 22 Jul 2022 13:17:24 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AABB8BD11
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:17:24 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id z22so5815128edd.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HUQCoYxB2Bh1aayiX9TOnZEyA2CtM0DAhw9bCrQNoXU=;
 b=ZrzU5j9op/a6nP9qdbi1IJoNZLYbedslFSQ/TyJpZc8uvH0BIkObDqO2ZRY/1YLAHr
 akHQh4xR8E5CXuGyqCnnXRKedj/GGkI2ly+eoAtD5TI/yCTyjpnGmVz7uQ1WYDKwMlkO
 NDjov0f0b2MPgQEGyZyBbcedLpRuqNL/3KG+ibyPDPz5LnA9KvWtbtOkk/GlhXp5d741
 myu0/p4ZfcYxYr3Bx+JY+K5AXknwHmNyaDHqi+NycYNuZnjvHrp2IrYwmXtVQa0SivW/
 +6XlJKk5hIeX08RCdF+DqZPDVeGm+EGnNmJTH75xMXyIlJXmDLKwF1ru8vfV9YSbYoIi
 qiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HUQCoYxB2Bh1aayiX9TOnZEyA2CtM0DAhw9bCrQNoXU=;
 b=2LHNsEPnkxlqROjY75wNXBfE5PosT6rtMySJ0befQ2zqv7ZEyuaisW+qDMi4kcTlxb
 xo79JIZm/zv9PczwcE6Uk5J9i3YckaoH/e2s2yFLJoNNj7IjUx85/B63wciWFX6znMUg
 ts2iI70129kafvo31I3sBRA+/rRVLXu+cQNslq5JP3kiXCCY/03kZeg28O7TfMJxhFRv
 6F9+5XuaBbdxmul7rM1kuLdVTsA7T8MpFh2JR8klLhLyhEW6hV7wtsAUUcmBNPnDZTHc
 qU5QwDEHl68EMHk4YjICLhmyx+d5zLy46MoIomM2mG4tB0bNEj1VCiuhwPDxs5aB1rJl
 PQaQ==
X-Gm-Message-State: AJIora+BUlnpOVyhNntUVNpVY0iKziYsvZN6lZ47mECDU8fe/JFOsM7h
 Rt5B6VyEZ8SX8AxqJMfGVDGALf5+iXATUW04xwmg6lOP65g=
X-Google-Smtp-Source: AGRyM1sMDXPei/Y1qx5sR5gG7dDsgE0Cc2p8fGRyfbzDRww2ZSLOSD6d/wCQjpS/pn/zNVipZd64yX5TOHQfe182uh0=
X-Received: by 2002:a05:6402:1e94:b0:43a:9e92:bf2 with SMTP id
 f20-20020a0564021e9400b0043a9e920bf2mr656314edf.248.1658495843087; Fri, 22
 Jul 2022 06:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
 <20220721095210.37519-5-horace.chen@amd.com>
In-Reply-To: <20220721095210.37519-5-horace.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 09:17:11 -0400
Message-ID: <CADnq5_PfNu+1O27W8KPr_eKwBx7+H45Jc8dRZNEbuasZYRZa4A@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/amdgpu: refine virtualization psp fw skip check
To: Horace Chen <horace.chen@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
>
> SR-IOV may need to load different firmwares for different ASIC inside
> VF.
> So create a new function in amdgpu_virt to check whether FW load needs
> to be skipped.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 17 +++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 29 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
>  3 files changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6540582ecbf8..a601d0f67b1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -334,11 +334,12 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
>                 ret = psp_init_cap_microcode(psp, "aldebaran");
>                 ret &= psp_init_ta_microcode(psp, "aldebaran");
>                 break;
> +       case IP_VERSION(13, 0, 0):
> +               break;
>         default:
>                 BUG();
>                 break;
>         }
> -
>         return ret;
>  }
>
> @@ -2389,19 +2390,7 @@ static bool fw_load_skip_check(struct psp_context *psp,
>                 return true;
>
>         if (amdgpu_sriov_vf(psp->adev) &&
> -          (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA0
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA4
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA5
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA6
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA7
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
> -           || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
> +           amdgpu_virt_fw_load_skip_check(psp->adev, ucode->ucode_id))
>                 /*skip ucode loading in SRIOV VF */
>                 return true;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index ab55602ff534..ba367799d087 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -807,6 +807,35 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>         return mode;
>  }
>
> +bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
> +{
> +       /* this version doesn't support sriov autoload */
> +       if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 0)) {
> +               if (ucode_id == AMDGPU_UCODE_ID_VCN1 ||
> +                   ucode_id == AMDGPU_UCODE_ID_VCN)
> +                       return false;
> +               else
> +                       return true;
> +       }
> +
> +       if (ucode_id == AMDGPU_UCODE_ID_SDMA0
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA1
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA2
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA3
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA4
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA5
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA6
> +           || ucode_id == AMDGPU_UCODE_ID_SDMA7
> +           || ucode_id == AMDGPU_UCODE_ID_RLC_G
> +           || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
> +           || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
> +           || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
> +           || ucode_id == AMDGPU_UCODE_ID_SMC)
> +               return true;
> +
> +       return false;
> +}
> +
>  void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
>                         struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
>                         struct amdgpu_video_codec_info *decode, uint32_t decode_array_size)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 239f232f9c02..cd6fce05978f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -343,4 +343,6 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>                        u32 acc_flags, u32 hwip);
>  u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>                       u32 offset, u32 acc_flags, u32 hwip);
> +bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
> +                       uint32_t ucode_id);
>  #endif
> --
> 2.25.1
>
