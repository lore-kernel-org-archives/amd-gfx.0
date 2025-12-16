Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47EDD609D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F7510E864;
	Tue, 16 Dec 2025 16:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pvwolu2N";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468B110E86B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:56:04 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-34ab4879aa5so620008a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765904164; x=1766508964; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sde5Hp/usUUTTYM7JRZAr8JXVSmIyltn1GhdNicTmIE=;
 b=Pvwolu2NTMbWNTURYRWhIJWGu8xnTArsYKmwLVsPpO5wpOJJchcMNt1SjnWRIBwrTD
 r39bgFpmbplPwlBmyD6NiH3SeRQEVt1nOIqtM+ZdVLZR/aMyZgOwJAaXQdqJx0cVl5Pm
 D/E5fIk6pV2QxeTxxniFxg6xSEJ9zDzVdLOUJZGFbYCYGq/kIkr8y8Iye5rRfaxPAqDm
 1TZYrRkcJ+WyATlpW0E9L85s88OyetZbBKniJhMy1e+oT1e63tfM/cFFoUoNtELqshRz
 RCIGNHczOKyZfv5syXp8L/oDyeNiDJ+bw4XtADYjfAOX+6rnuvDtUJNGNhe05ch5nle0
 yQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765904164; x=1766508964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sde5Hp/usUUTTYM7JRZAr8JXVSmIyltn1GhdNicTmIE=;
 b=hLUNxHKXRjmNPXW/eexZ3XeiKMYEG1ZiRj7eBkRB1lzdIqma+I5uGtwOY2Nz0W8SHf
 PUazRgB+LoS4Wphrk10UCCxYlkZCHzRGgp727d+zjRG81WWBPkn2O3nTXo27FNN43bBQ
 kZR/YVu+S/KOp6bed5Sy/wf5wDHzer/rc2Twb9eJHsoDm8VtvQCYmAlbviWOiozz3srS
 Qk27+wHdQ2+AITsi10J3XFiVlAE3Wqcdza92KzCMyJJUD3IeYRxVD/tPMjRfJqJ0vre6
 ozrl3Ytd7sz8P2vxYtq4UzCsBNjo0FlRrnEMj4jUeAaFeKepQuFn7RzojCSRX6pCFOOM
 w9WQ==
X-Gm-Message-State: AOJu0Yx8u3xvPxmEiLHnjxaKxDZYL++T0gzlxMb6VQxHrbODkOEaYVxy
 A9DT2W2+nEyBIylW+Ue4GGwjtoICgTSE1VtB8L15ZmU/b1dSD8hX/58MMeyvgfg3y6DsGyZqatd
 fpNsYTyouHPtkZrWmRFic/oltrckbwlI=
X-Gm-Gg: AY/fxX5ejYPfHjdoN44m8bgV94Onjc6eXbv1szOeskCaPXxBxwA/KOoDcRTMsThi+i7
 LmEFBtzLMeDhn3NIb/Tkumpxa9kEHU39qUB7fWSR/VTkub+62vR2yFfzJbLqZD2hneq3le8HWYU
 zYMOfc1GqQWDi+IFKdVGi12FbuF8w0rI6ShHcpETo5oOb5aKXjGv1VQEvqdiTH3JzUCrCATWlpf
 FWBRKukB6bBky5WkNTiLryE5Ma6uZY/84gCL5rbVahZ0aha2ou0YaDbcx8oZ0nI0Yt6fnj5
X-Google-Smtp-Source: AGHT+IEmj2HzZjt9QopCdA7PzBHmedlOMScHPoFlMhkLW62EQPn9eou2NP8TmfPrpqoQQOD+IfKGNuWNzYrGvhRt6Ek=
X-Received: by 2002:a05:7022:e997:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-11f349aebdfmr6183039c88.1.1765904163592; Tue, 16 Dec 2025
 08:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-9-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-9-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:55:51 -0500
X-Gm-Features: AQt7F2q2fqnOfAVGG36mrkN33UOeh7cxXOEaCG5QyoVlBWNzud8psGBrUrJ1c8A
Message-ID: <CADnq5_O5YeGEr5ryrk4eQNJv68aW+B_RpdfVr4C0+g6mWS0dig@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/10] drm/amdgpu: Add ioctl to get cwsr details
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:05=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add an ioctl to return size information required for CWSR regions.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 398d6c8d343c..848405c37bd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1368,6 +1368,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                         return -EINVAL;
>                 }
>         }
> +       case AMDGPU_INFO_CWSR: {
> +               struct drm_amdgpu_info_cwsr cwsr_info;
> +               int num_xcc, r;
> +
> +               fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
> +               if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +                       return -EOPNOTSUPP;
> +               num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->=
xcp_id);
> +               cwsr_info.ctl_stack_size =3D
> +                       adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +               cwsr_info.dbg_mem_size =3D
> +                       adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> +               cwsr_info.min_save_area_size =3D
> +                       adev->cwsr_info->xcc_cwsr_sz * num_xcc;
> +               r =3D copy_to_user(out, &cwsr_info,
> +                                min((size_t)size, sizeof(cwsr_info))) ?
> +                           -EFAULT :
> +                           0;
> +               return r;
> +       }
> +
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index c1336ed4ff75..2bb9daafb560 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1273,6 +1273,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
> +/* query CWSR size and alignment */
> +#define AMDGPU_INFO_CWSR                       0x25
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1636,6 +1638,20 @@ struct drm_amdgpu_info_uq_metadata {
>         };
>  };
>
> +/**
> + * struct drm_amdgpu_info_cwsr - cwsr information
> + *
> + * Gives cwsr related size details. User needs to allocate buffer based =
on this.
> + */
> +struct drm_amdgpu_info_cwsr {
> +       /* Control stack size */
> +       __u32 ctl_stack_size;
> +       /* Debug memory area size */
> +       __u32 dbg_mem_size;

How should this be used by the application?  Should it be folded into
the save area or ctl stack, or is it just for future use?

> +       /* Minimu save area size required */

Minimum

Alex


> +       __u32 min_save_area_size;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.49.0
>
