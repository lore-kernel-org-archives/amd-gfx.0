Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF5E85367
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 13:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E90810E14A;
	Fri,  3 Apr 2026 13:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="IZcKXniS";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A483010E14A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 13:43:57 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6339bDSR270868; Fri, 3 Apr 2026 13:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BAPJo9
 o55+bE8EGVX3xBVoIwgeOs3BJTux1NhSslC/E=; b=IZcKXniSZmS1LWEKUstfpB
 6eU83ZfSu01buRt/SvMCmlYtkOQGm1E7Qu6Q9bJaAFEfkBvLVa0Z/tz31+HZpaL9
 7QVKJAdxvsNVh19WVh0biv8egmBcYrVkF4OouvUfH1HWfrfULcz75BYXb2+GOkXa
 tD24RlccRB9VBTod3Wgp3ELSXRyMoaMe0kNkmMTLinU5UIKD15LUwAqN2yQp9+rx
 qenIrK92X8iRqWc7PgdkwAzXF2yq03eUwqEUzCOptSyRLNMnBX5FjnHS383vTRpB
 eo0/6bao1IrlfsdGq+GiKdf8dauUZe0BUsiA8MQxtymOPW1yV5eP3KvdEU4efZFQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcqymn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Apr 2026 13:43:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633DC5j8022227;
 Fri, 3 Apr 2026 13:43:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tane86y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Apr 2026 13:43:53 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 633DhqAW19989056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Apr 2026 13:43:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C365E58055;
 Fri,  3 Apr 2026 13:43:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06F985803F;
 Fri,  3 Apr 2026 13:43:48 +0000 (GMT)
Received: from [9.39.20.61] (unknown [9.39.20.61])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Apr 2026 13:43:47 +0000 (GMT)
Message-ID: <a77c81c0-f78b-4b63-8a0e-49251353e5f6@linux.ibm.com>
Date: Fri, 3 Apr 2026 19:13:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for
 non-4K page size
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774521183.git.donettom@linux.ibm.com>
 <b68780ba172175c68b313c48076185629fee9b7b.1774521183.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <b68780ba172175c68b313c48076185629fee9b7b.1774521183.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cfc41a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=vnVUVj9hlqEGorVS3iYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DD9iI2aldXmgTdofdFGhhgAdiADdossD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDExOCBTYWx0ZWRfXwl5v6ZLjbC1L
 Qo/ZsdLCrLXU+z6W5ousZPOWo283pMoAbgUTYUQgM6mq/cW8Tpk8eBKBoR6XWEXC6OVNfZ6D4A8
 6FEaO/hRH8F0mZDTzTddV52pHS2L8I179/YSGGgUaNjHE3VDqOVrvUurD1XVlS3/mqeU3cgUHME
 0Vs2NBbY9wdMYA4+IpgqzQtiDIV3kw37V4/WrxH5pa6ydAdypnZ1SLkeEzwzzq5/yc1jrfqVoXi
 /GiXy87iac85D7Z7IQQfzHLL8HzuZdiqUE46x0OSiFqaNdjvXDw+L/v5cUECG6G58NmuTYS+op3
 SsCabCV24cO+lF7Mh5CLcWrjV9O/0T0Xs/FYBxDxNMdnKyPehFLMytxfmvO8d+mX0zbaz0WYtXZ
 agbiwI3uN71CA8xW53uTJk61SoMbSTNuwamxuwXJgHjEPX8r/KoAkaWAxLcYFBD/uXkrmWs9G6o
 4mhFA/TJEGCSEo1+BpQ==
X-Proofpoint-ORIG-GUID: oAhVVwdWLO7xIW3ybjY9giz18Zn1XVL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030118
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


Hi @christian @Felix @Alex

Thank you for your help in reviewing this series. All the patches except 
this one have been picked up. Could you please share your thoughts on 
this patch?

-Donet

On 3/26/26 5:51 PM, Donet Tom wrote:
> AMDGPU_GTT_MAX_TRANSFER_SIZE represented the maximum number of
> system-page-sized pages that could be transferred in a single
> operation. The effective maximum transfer size was intended to be
> one PMD-sized mapping.
>
> In the existing code, AMDGPU_GTT_MAX_TRANSFER_SIZE was hard-coded
> to 512 pages. This corresponded to 2 MB on 4 KB page-size systems,
> matching the PMD size. However, on systems with a non-4 KB page
> size, this value no longer matched the PMD size.
>
> This patch changed the calculation of AMDGPU_GTT_MAX_TRANSFER_SIZE
> to derive it from PMD_SHIFT and PAGE_SHIFT, ensuring that the
> maximum transfer size remained PMD-sized across all system page
> sizes.
>
> Additionally, in some places, AMDGPU_GTT_MAX_TRANSFER_SIZE was
> implicitly assumed to be based on 4 KB pages. This resulted in
> incorrect address offset calculations. This patch updated the
> address calculations to correctly handle non-4 KB system page
> sizes as well.
>
> amdgpu_ttm_map_buffer() can create both GTT GART entries and
> VRAM GART entries. For GTT mappings, amdgpu_gart_map() takes
> system page–sized PFNs, and the mappings are created correctly.
>
> However, for VRAM GART mappings, amdgpu_gart_map_vram_range() expects
> GPU page–sized PFNs, but CPU page–sized PFNs were being passed,
> resulting in incorrect mappings.
>
> This patch updates the code to pass GPU page–sized PFNs to
> amdgpu_gart_map_vram_range(), ensuring that VRAM GART mappings are
> created correctly.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c   | 3 ++-
>   3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0ccb31788b20..f9f534119cbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -204,7 +204,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   	int r;
>   
>   	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> -	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
> +	       AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8);
>   
>   	if (WARN_ON(mem->mem_type == AMDGPU_PL_PREEMPT))
>   		return -EINVAL;
> @@ -230,7 +230,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   
>   	*addr = adev->gmc.gart_start;
>   	*addr += (u64)window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
> -		AMDGPU_GPU_PAGE_SIZE;
> +		AMDGPU_GPU_PAGES_IN_CPU_PAGE * AMDGPU_GPU_PAGE_SIZE;
>   	*addr += offset;
>   
>   	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> @@ -248,7 +248,8 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   	src_addr += job->ibs[0].gpu_addr;
>   
>   	dst_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
> -	dst_addr += window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
> +	dst_addr += window * AMDGPU_GTT_MAX_TRANSFER_SIZE *
> +		AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8;
>   	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
>   				dst_addr, num_bytes, 0);
>   
> @@ -266,6 +267,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   	} else {
>   		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
>   
> +		num_pages *= AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>   		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 143201ecea3f..15aff225af1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -38,7 +38,7 @@
>   #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
>   #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>   
> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1 << (PMD_SHIFT - PAGE_SHIFT))
>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
>   
>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 9ae424618556..b2d4114c258c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -48,7 +48,8 @@
>   #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
>   
>   #define VCE_V1_0_GART_PAGE_START \
> -	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
> +	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GPU_PAGES_IN_CPU_PAGE * \
> +	 AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
>   #define VCE_V1_0_GART_ADDR_START \
>   	(VCE_V1_0_GART_PAGE_START * AMDGPU_GPU_PAGE_SIZE)
>   
