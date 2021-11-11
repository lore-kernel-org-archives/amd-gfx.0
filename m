Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 04:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4A461261
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 04:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E4A461261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CA06E8F2;
	Thu, 11 Nov 2021 04:00:07 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A1B6E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 04:00:06 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id be32so9214214oib.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 20:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q/FmW3MJJ362Vvkjtl+lRtW5+3RTNhuX90YhmCpPsxI=;
 b=SkiRP6OZ5+3QQWuL11d+S9BOw44KZlzuJkg8se1w3o6Nu2T3Zcfe/SfbSWfjEkqi5z
 t2X8jVMVALwyXpBvT3dWylUkf5JWNuadwcNyTOVBchhvjSHx/l7ZjdYtE4QcpMj8Pcnd
 s1j1ya1RNplX51erH2o3zG5Pn3+o3/FiFsevUTvVkCL7h4YYLiMaaiSjas6+cRKo+3aW
 d7C22EqMW96s4JhoQjrBq5JusuMwXbXrOa+0g53ztXeixKKhjvjnIH5Iu3eC2MTRUWsE
 YS1ye+UF5ocesSq4zJKRGSfI7WDUi9X7VCGRzNFnRc6kVwVjmqDa7folDm2wK8lvJCpc
 V5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q/FmW3MJJ362Vvkjtl+lRtW5+3RTNhuX90YhmCpPsxI=;
 b=vd/q6vWuJcvov/j0ypt1TeVivEniev4UN/WHBVuoeTEv2vt2Oo6UHqTUxhSVeFqaMs
 P0pDfsDPhzrBl0Ar67kKPy1DHR7fmiakcd6GJ7Lm7HSSiBFc9OgIbVz/luF5W8IyXYnC
 ltjoGdRibvPOp6P5F+jLcyZfiW1Kj4M1iM9Wl7Sn9KdhaIYTYczr97hODpLyCM/j4b13
 2XYKp/mWAPP88r8awFEYsRfNpHSgB3RYHGMNxToTn0wSNsK02yC+ArECYAZUhXf3bv9t
 2l9/rn+mjfDosyZYbiVzr//P0k1d0B8/LRaX51La/ao8diLh3Ef9k9Sd55oEiYXIn5/2
 tJeg==
X-Gm-Message-State: AOAM530mzUcD1agtmqFANXb2WoKNA6VThQ+2JZ1fdQodPZVTc0kBZ0cR
 hKYltWl5oCmMgHnX5/BSNq145BV0JhCou0/9HrQ=
X-Google-Smtp-Source: ABdhPJw8GowVwGSYTiWXkJD6ontOVIQL52j0Mo73I8sh7bpgv63enp4RwRR1klMpdXfuAt5+/uafTaRr/nMG+KBRJzc=
X-Received: by 2002:a05:6808:144b:: with SMTP id
 x11mr3682744oiv.123.1636603205763; 
 Wed, 10 Nov 2021 20:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20211111032108.20859-1-guchun.chen@amd.com>
In-Reply-To: <20211111032108.20859-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Nov 2021 22:59:54 -0500
Message-ID: <CADnq5_MGUZCGjF5QiJJtzp4yuTr5ccC4CrNy_oxvW=_pqtbRGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add error print when failing to add IP block
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 xinhui pan <xinhui.pan@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 10, 2021 at 10:21 PM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Driver initialization is driven by IP version from IP
> discovery table. So add error print when failing to add
> ip block during driver initialization, this will be more
> friendly to user to know which IP version is not correct.
>
> [   40.467361] [drm] host supports REQ_INIT_DATA handshake
> [   40.474076] [drm] add ip block number 0 <nv_common>
> [   40.474090] [drm] add ip block number 1 <gmc_v10_0>
> [   40.474101] [drm] add ip block number 2 <psp>
> [   40.474103] [drm] add ip block number 3 <navi10_ih>
> [   40.474114] [drm] add ip block number 4 <smu>
> [   40.474119] [drm] add ip block number 5 <amdgpu_vkms>
> [   40.474134] [drm] add ip block number 6 <gfx_v10_0>
> [   40.474143] [drm] add ip block number 7 <sdma_v5_2>
> [   40.474147] amdgpu 0000:00:08.0: amdgpu: Fatal error during GPU init
> [   40.474545] amdgpu 0000:00:08.0: amdgpu: amdgpu: finishing device.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ff70bc233489..b68e5237fd16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -587,6 +587,8 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add common ip block(GC_HWIP:0x%x)\n",

dev_err() is more friendly to multi-GPU systems.  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                       adev->ip_versions[GC_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -619,6 +621,8 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add gmc ip block(GC_HWIP:0x%x)\n",
> +                       adev->ip_versions[GC_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -648,6 +652,8 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
> +                       adev->ip_versions[OSSSYS_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -688,6 +694,8 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add psp ip block(MP0_HWIP:0x%x)\n",
> +                       adev->ip_versions[MP0_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -726,6 +734,8 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add smu ip block(MP1_HWIP:0x%x)\n",
> +                       adev->ip_versions[MP1_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -753,6 +763,8 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
>                         break;
>                 default:
> +                       DRM_ERROR("Failed to add dm ip block(DCE_HWIP:0x%x)\n",
> +                               adev->ip_versions[DCE_HWIP][0]);
>                         return -EINVAL;
>                 }
>         } else if (adev->ip_versions[DCI_HWIP][0]) {
> @@ -763,6 +775,8 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
>                         break;
>                 default:
> +                       DRM_ERROR("Failed to add dm ip block(DCI_HWIP:0x%x)\n",
> +                               adev->ip_versions[DCI_HWIP][0]);
>                         return -EINVAL;
>                 }
>  #endif
> @@ -796,6 +810,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add gfx ip block(GC_HWIP:0x%x)\n",
> +                       adev->ip_versions[GC_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -829,6 +845,8 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
>                 break;
>         default:
> +               DRM_ERROR("Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
> +                       adev->ip_versions[SDMA0_HWIP][0]);
>                 return -EINVAL;
>         }
>         return 0;
> @@ -845,6 +863,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                                 amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
>                         break;
>                 default:
> +                       DRM_ERROR("Failed to add uvd v7 ip block(UVD_HWIP:0x%x)\n",
> +                               adev->ip_versions[UVD_HWIP][0]);
>                         return -EINVAL;
>                 }
>                 switch (adev->ip_versions[VCE_HWIP][0]) {
> @@ -855,6 +875,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                                 amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
>                         break;
>                 default:
> +                       DRM_ERROR("Failed to add VCE v4 ip block(VCE_HWIP:0x%x)\n",
> +                               adev->ip_versions[VCE_HWIP][0]);
>                         return -EINVAL;
>                 }
>         } else {
> @@ -893,6 +915,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                         amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>                         break;
>                 default:
> +                       DRM_ERROR("Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
> +                               adev->ip_versions[UVD_HWIP][0]);
>                         return -EINVAL;
>                 }
>         }
> --
> 2.17.1
>
