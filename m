Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 07:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8167E61177
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 07:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8167E61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F086E0CC;
	Thu, 11 Nov 2021 07:02:44 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CE26E0CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 07:02:43 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id d5so8144824wrc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 23:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=bmtc/nFIcbPfWio/mRPFwvZp3QiA+bf5qF+mFpSSypc=;
 b=eB26R/mG9WD6TrogFcubwLm99L7mkAjHNzKcV+PmLKqb4a/Vp2KOLyna9Kxx7nBDpM
 YKDnb4gmVCJOA5yhtJYs7oeo3JdRVkxgxNn/OQPHfNdXfCW8Px8KZeFGCB667Zf1I1F2
 oz3bponb52t4VhqpDU1VAQrg+ac0sh4BzwXW05lAZ/XiUruxcJdAwS99C+3HS1y+b86S
 8n8KRN8QkAHcsYjI3vk3+juPVMptzEII5Xhn+PQ7kAEKbyq9noZazQF0n1TtB+cE+xES
 0LsSQ03q5O9gveBuAq5yUpJsYpCp6mBti1i3bnlpr3lMmrmqWDFkrwOhNU440caderOm
 tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bmtc/nFIcbPfWio/mRPFwvZp3QiA+bf5qF+mFpSSypc=;
 b=qOyHHDlZxBhXmnUGGven88QDcUsXmGX/b5pxedEGEBdae82xpKviAuK1iTFpJbuxci
 ChxWhhCfKcnxPqyFUfeOK7sToaZ8xS9mltSLoBbsUEdKCVdTBZXl7I1yecxneNQV6XUI
 0U37xdfIRoelf/dr0fGNhCcuJH2jAvR9uE+ol3HkTYaSxEb9DaG7JLQRWaa/ox9tZomt
 QLHHkT8WE+7VmybUR5kVHR4Nq6VeOCGKisQ5PmgkYxR9AnWBgBWFsA9jveYh6PiDmRnI
 f1KuAfb8vB9zr3toy1oW5bpw/WwLPnrU0QhqlxvF68zMB34iKi4oRLbNfxr7jbXFkJv1
 04nw==
X-Gm-Message-State: AOAM532iz45owJwBhzydHRywQHogiD6bGxEgu9ez+nA4rq1gD29IA064
 xyTXECha1GXsLoQqP/ep1x4=
X-Google-Smtp-Source: ABdhPJzCj3yE7E2CrTlf3ri6BLNxmaNK86HKlgJtGTBrIYx0Z6FjQskA3Bf+XZhOTjZVGLL1kG3mNg==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr6245449wrv.102.1636614161351; 
 Wed, 10 Nov 2021 23:02:41 -0800 (PST)
Received: from [192.168.178.21] (p4fc204a3.dip0.t-ipconnect.de. [79.194.4.163])
 by smtp.gmail.com with ESMTPSA id l5sm8099116wms.16.2021.11.10.23.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Nov 2021 23:02:40 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add error print when failing to add IP
 block(v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, xinhui.pan@amd.com
References: <20211111041128.8043-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8749fa6f-b8ac-960c-cd9c-0baf063482fe@gmail.com>
Date: Thu, 11 Nov 2021 08:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211111041128.8043-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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



Am 11.11.21 um 05:11 schrieb Guchun Chen:
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
> v2: use dev_err to multi-GPU system
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ff70bc233489..4e3669407518 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -587,6 +587,9 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add common ip block(GC_HWIP:0x%x)\n",
> +			adev->ip_versions[GC_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -619,6 +622,9 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add gmc ip block(GC_HWIP:0x%x)\n",
> +			adev->ip_versions[GC_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -648,6 +654,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
> +			adev->ip_versions[OSSSYS_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -688,6 +697,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
> +			adev->ip_versions[MP0_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -726,6 +738,9 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add smu ip block(MP1_HWIP:0x%x)\n",
> +			adev->ip_versions[MP1_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -753,6 +768,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
> +				adev->ip_versions[DCE_HWIP][0]);
>   			return -EINVAL;
>   		}
>   	} else if (adev->ip_versions[DCI_HWIP][0]) {
> @@ -763,6 +781,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
> +				adev->ip_versions[DCI_HWIP][0]);
>   			return -EINVAL;
>   		}
>   #endif
> @@ -796,6 +817,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add gfx ip block(GC_HWIP:0x%x)\n",
> +			adev->ip_versions[GC_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -829,6 +853,9 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
> +			adev->ip_versions[SDMA0_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -845,6 +872,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add uvd v7 ip block(UVD_HWIP:0x%x)\n",
> +				adev->ip_versions[UVD_HWIP][0]);
>   			return -EINVAL;
>   		}
>   		switch (adev->ip_versions[VCE_HWIP][0]) {
> @@ -855,6 +885,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add VCE v4 ip block(VCE_HWIP:0x%x)\n",
> +				adev->ip_versions[VCE_HWIP][0]);
>   			return -EINVAL;
>   		}
>   	} else {
> @@ -893,6 +926,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
> +				adev->ip_versions[UVD_HWIP][0]);
>   			return -EINVAL;
>   		}
>   	}

