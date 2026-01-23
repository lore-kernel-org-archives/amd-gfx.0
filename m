Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8E3D778AF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F0710E160;
	Fri, 23 Jan 2026 20:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SsREtQVz";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D3810E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:48:46 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-123387e3151so215013c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:48:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769201326; cv=none;
 d=google.com; s=arc-20240605;
 b=ECXIsHGYiaYtppYkQiCkKW8HshE7IVZ5cT16dfABetDv/MLM1lfqg9FztqjZXzN3QV
 l6CN9BuJmIfMx6eJQKWZzE2JQwuJL2Xt6jcxCm5zI2t/rSMUgvSJxApIvHd0Jck4v+Ip
 pKeRaxXCsOwgYs+BTU3PYEXizYCAbkJQvufgSaL9Z3sa1efr0emXkLs38oeXJCnEwQFb
 ZyefxJfJMY3KkaS3xKW+w5k+dsy//m1z19GYNHyftKM+bVAlQRcS5EtmaDijmH+VYU91
 7WLCKafq58zE/kN23kJeFr+nliZ2PgaqoxIh3qEv+OZO82lYcOnmMlV3L4FwkG9wwUer
 218g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gfOlMgM/4l7jhooH+dac8Y3Ts9JnB7nDolThM9dQ+zo=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=lZq7+dIHtEfTse//CuDnR6zU8/qQACfke8x4ylDql4UJpg8JVTYaHOwxEJR/jV/dW3
 3s+L1J2q62JZawzTEO/LsUYPzU0wCPJ4YKkMjY736Rhwcergy8IS/49YEVCymH/4XXsY
 qbJF22u9xwIK3iRMQKS6CDJ1moceXrpnl20NtpLLdvZxSSpogk1NSSn4+oz9Naswx408
 KleKU4v01P55tQ3/m/VoQfPNvpCzQczJyWJXFJv8ns/jHHBVCh7Zh2S8IuS8JF4ryc+g
 VCXTTvZz+r8Z5EJf++A+C0pF3Z8ceEMaClNU++pVX5zz33dXxhYGWfMWQ6cFLyqg6y9n
 mUgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769201326; x=1769806126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfOlMgM/4l7jhooH+dac8Y3Ts9JnB7nDolThM9dQ+zo=;
 b=SsREtQVzDj3eH9Yexw8CeNnlvbSwwSiAtN8fXMSElBosIioAVBwPjt0OnGTYwBWUBX
 o4RmWSOrgfeSgsO48Hj8zBS8Xspra9ROdmYy9I281yyesQYxnBsFweyKuOOmPtvC9O11
 JgH5wBvrvflfVfaU0s0KC43bV7DKQwRpwXFbBck3Q74Rwt2CUS/vKQ1tbm4sm1sjayol
 iZ/pgbpw6E1aG1jfGU5NgX8DP3hfD47Qktv6tko4dlpK1dR95zxeujFrWttAUiD1v90/
 tlJN+1HCr1fa3RZHFgRCcwfDptnq9lhqmVEhTgKlVigCfZI5eyJLWS32OjHhCiPMtqs0
 lFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201326; x=1769806126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfOlMgM/4l7jhooH+dac8Y3Ts9JnB7nDolThM9dQ+zo=;
 b=OW+1RsQqCLHRPKXaGvuxtkcds1ho/zkSh9WhUk1zjbL0AN+U25RWG5ZTXT0quCfVHa
 jXgrEKXRWCN+wJr6aITm7jjqYjmW8UouhyP+5ppjS8raMC9xODDI5YD3KFX9XBBTNDCW
 qeIsNMPermCnqTdBssLYuQkAzdwKvrCapxBxMNGi/sBuBj52bDwcO44L/mf0rHOIixPa
 WDlmqaRAQ8l8ahjUmwVxZmeCPj9HfhsBC+asAGWWYEzglqatshfJH/CQzxYWjTP1N8KG
 sJQJYjFWm8LZIlQbjVQ4RYcjjbCL5iakaPaEGEayvlupGeb7eiyOyvYa6CIo+T3WlPqj
 Yw7g==
X-Gm-Message-State: AOJu0YzpcYR5jwD6tGOima1wHZY2vBPeTCroRIhsXOogtwlh8IEuIX3n
 BI455v+I3PN2Deph4RlO5CJe63OtgF77BOVW73aWggAW/kz+LFlz/rCKv1l/oO2WaR5WhO3r6+k
 izNXqESrNarog4dbyG9zP3gy0HS3FxKS2HQ==
X-Gm-Gg: AZuq6aKKbkKSv+KBl0hQds/MxBWBja4gKvuiEe8Cok0HjruksN3rh2SOX2GOWl3qweJ
 BtEMiL60x2BcCVOxgCjIy0ejdAzmp8jQaC7o8F5fSh7/hAjOgvgLA4N8mbSLpv04c4sr9sXkUoS
 gSYtlHlQFsAGMLsCPJeCqOA4SwPIEMS/Z3zKRjUCsANjevV4iSCeX3zNuXdpsoE8EqOCY/37hQs
 AVPhrl7A+u3DRNc4Jsgi5HjwIK/l3zvEzl7oEqipbOC2b5KN06VQP4qDh00AOq0stBy+0u+Cw6y
 3hjDa20=
X-Received: by 2002:a05:7022:618d:b0:123:2d38:929b with SMTP id
 a92af1059eb24-124856af930mr181980c88.6.1769201324295; Fri, 23 Jan 2026
 12:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-9-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-9-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:48:33 -0500
X-Gm-Features: AZwV_QgHJ_MKVTmwB7OUbDp0HxF8xG-TxO8w0ZPz7feL0LNdTE0NTWps2CI3IBw
Message-ID: <CADnq5_PYZwCi0wOCnacsuPasqf-AzOHJvSxy0X6CD9OActoa2Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] drm/amdgpu: Add ioctl to get cwsr details
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

On Thu, Jan 22, 2026 at 6:02=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add an ioctl to return size information required for CWSR regions.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index fed15a922346..992bcdf3fc1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1426,6 +1426,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
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
> index ab2bf47553e1..c178b8e0bd3f 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1269,6 +1269,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
> +/* query CWSR size and alignment */
> +#define AMDGPU_INFO_CWSR                       0x25
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1648,6 +1650,20 @@ struct drm_amdgpu_info_uq_metadata {
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
> +       /* Minimum save area size required */
> +       __u32 min_save_area_size;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.49.0
>
