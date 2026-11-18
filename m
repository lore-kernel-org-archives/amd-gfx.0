Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1D606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=damsy.net header.i=@damsy.net header.a=ed25519-sha256 header.s=v1-ed25519-20260822 header.b=ZVuWVCyt;
	dkim=pass (2048-bit key, unprotected) header.d=damsy.net header.i=@damsy.net header.a=rsa-sha256 header.s=v1-rsa-20260822 header.b=zWOwxE1E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F097C10F696;
	Wed, 18 Nov 2026 09:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="ZVuWVCyt";
	dkim=temperror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="zWOwxE1E";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B1610F70C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 09:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260822; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794994507; bh=v3Is7YJSGDJQnvK2QjE9cvL
 +05rsPdhSLYpYLhBX9GY=; b=ZVuWVCytW7S71YqfZ4cbqyhmgLQtAfAZaIbsxpWyY2IU26DQLh
 xALFA1Z9q2mzhbKKLu+4Zh8UVV32JgNewpCA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260822; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794994507; bh=v3Is7YJSGDJQnvK2QjE9cvL
 +05rsPdhSLYpYLhBX9GY=; b=zWOwxE1EY0/xTyOq11Ifg1WCLCE4l4KRoRdZ1cD3/adL9P/r6w
 sQu06m1gaFY/ZR+cJ6saoZdYq//66aR52lr4I7CYV/Bk8ZIEiAm0Y2EYwlzUgB6NVGQZCdbThm2
 yB0mr03S+JoQcMOBi9CyHc+Nh2zAw1cYx5c+9JEz3d8ip1n/aHlX9HCJUtOd+D0/gYJTzW0tKHO
 zXbggLx7jTDw0vuPhbsL6z3VSPpBoiLoCzXjbSSedNKJ7zH6IyAQY2Mf6T9upEw0XdtVQNc67xQ
 nPCwjUZ72zv9yBMBEBzF6ZiALoerCWFaM0xnz1bFRpTI6nfSMEZNa9t9SAE1kx3zo7Q==;
Message-Instance: m=1; h=sha256:O8XZyZhk9smECfjD0zccyC7kHqz+RyBMYZQjwb0c
 Ya8=:OYBp+uKV+ZNwX6TP+c1TH3J0qEAJdOMfZLq70n/hXbs=;
DKIM2-Signature: i=1; m=1; t=1794994507; d=damsy.net; mf=PHBpZXJyZS1lcmlj
 QGRhbXN5Lm5ldD4=; rt=PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+,PHlvZ2VzaC5tb2hh
 bm1hcmltdXRodUBhbWQuY29tPg==,PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg==;
 s=v2-ed25519-20260822:ed25519-sha256:cyETOCa1//5Y8KTWYhJ94Nc/0094/EPxZVvP
 hjT+CaBuDqWrVADXJQDzjQr/hY+Rddmsybl5tGImeR9jmYn9Cw==|v2-rsa-20260822:
 rsa-sha256:CQN4SQ9yAudy1+dRwd0mclsPUIETo1fkzOTCErDOcRWscxpmG1ayEu5IEKh12/ZT
 ngIQxye5jpfFp6tLdilAfFxDzlv5BgwwgrWTH9h2Ka/nOL6M0MumwlmXzuFVRe/bvH9a66aF
 V81bZoZKMXXTHBIzXobcSQRMrjySNPFZojVKu5BxtJqewQPx/YsXVoI6y78nFkOVnb/5GYSp
 dGOorSgQHe9DDEUGE0Quow21nOPHRgmpWCZqWTLwPCLNUEXKyrJsI8TCGeqoRotx/pLHrO6D
 3SSAtK0uGfJAD8IH3LVXWfqCqYH3edYRlpnTkf2NuJsW6Sewh6VJT9neWYTs0w==|
 v2-mldsa44-20261103:mldsa44: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
 5gAAAAAAAA8pPUo=;
Message-ID: <87bf630a-af0d-4dd8-925f-d13397b0079a@damsy.net>
Date: Wed, 18 Nov 2026 10:35:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: Add INFO IOCTL query for doorbell ranges
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
References: <20261117192304.809813-1-alexander.deucher@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20261117192304.809813-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 17/11/2026 à 20:23, Alex Deucher a écrit :
> Each IP gets a subset of each doorbell page.  Add a query
> so userspace can query the ranges.

If the offset for each IP has to be inside a range then the kernel 
should validate what UMD uses in amdgpu_userq_get_doorbell_index


> 
> Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h           |  6 ++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d7872acb4d790..42109f7706294 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1453,6 +1453,26 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			return -EINVAL;
>   		}
>   	}
> +	case AMDGPU_INFO_UQ_DOORBELL_RANGE: {
> +		struct drm_amdgpu_info_doorbell_range db_range = {};
> +
> +		switch (info->query_hw_ip.type) {
> +		case AMDGPU_HW_IP_GFX:
> +		case AMDGPU_HW_IP_COMPUTE:
> +			db_range.offset_bytes = adev->doorbell_index.kiq * 4;
> +			db_range.size_bytes = (adev->doorbell_index.sdma_engine[0] -
> +					       adev->doorbell_index.kiq) * 4;
> +			return copy_to_user(out, &db_range,
> +					    min((size_t)size, sizeof(db_range))) ? -EFAULT : 0;
> +		case AMDGPU_HW_IP_DMA:
> +			db_range.offset_bytes = adev->doorbell_index.sdma_engine[0] * 4;
> +			db_range.size_bytes = adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances;
> +			return copy_to_user(out, &db_range,
> +					    min((size_t)size, sizeof(db_range))) ? -EFAULT : 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
>   	default:
>   		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 29009f6aabde9..86d42a5d683c0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1289,6 +1289,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>   #define AMDGPU_INFO_GPUVM_FAULT			0x23
>   /* query FW object size and alignment */
>   #define AMDGPU_INFO_UQ_FW_AREAS			0x24
> +#define AMDGPU_INFO_UQ_DOORBELL_RANGE		0x25

Should KMS_DRIVER_MINOR be incremented to let userspace know that this 
query is available?

Thanks,
Pierre-Eric


>   
>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
> @@ -1668,6 +1669,11 @@ struct drm_amdgpu_info_uq_metadata {
>   	};
>   };
>   
> +struct drm_amdgpu_info_doorbell_range {
> +	__u32 offset_bytes;
> +	__u32 size_bytes;
> +};
> +
>   /*
>    * Supported GPU families
>    */

