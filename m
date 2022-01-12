Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3225C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 07:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B2010F91D;
	Wed, 12 Jan 2022 07:33:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB4B10F91D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 07:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9U9YFrBWrRStUQ3DyMplL3ZXYlzSgvGpoAsQeAOobFuOiNOiHV6CPxQFgwBcA51hLxGAI+r8Agu+nu4m75xQ+oRWVuo0f5T7ym1yqwqNLkm/1JzhEv0pO0dTqgZUihRX93SveXX/osI5++dx+XGddUU6JOOQ+MQTm9TJ9u3boSIUMjuWG+e05Gmb//qcn88ehDtE7pEH3je22D7eZDov5LDvXVxsZ7wzR9GOqiY8S3gM4JDDj85SkKqfZrHDPHbCTPVxwZ6NT23OngBz/F+U7vJFCoslfanUNdgPMjrAN5JN3uTJst/Bj39YLOH34SjiIr5IsYhN9b2D5Aj7Zr+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcArpB9EOyJCDi+ldpREmwECLcqqFl1781Kk8KAZWGA=;
 b=n/C1ziGoc1e8oyJ0GZZBVAiOpyass8H7bOhP0dLkP+XOE1K4CeZcywLEC3+6oKhkuWiZW1/slGSpHJFWlm+pgFzZ6Hqh/ASupdkkCajMOGZEJ0XRpDXuuMfmJS9sxL/a9r5WinszLEiRM3ihR9icW/mPGrPuuNvgcrp1Z5yZdlM7V5JWKb+X3B04+jVWnBRzG2PgvjgA793gbxZq5FKJfMm9iCNmG78k9ZlhhOwyFLot587apiyJa2LRJy9biicrfPjO9XriWO//zM+mAVTcymQ64i9kloRksKhISItkI8C+PCJ8kUwkJ4wf87qcbciPEjfaqGBjjF9GTHBSHxa0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcArpB9EOyJCDi+ldpREmwECLcqqFl1781Kk8KAZWGA=;
 b=xyNh5RYE816i9M75yJTwZ9GFgeYg+hVVD1vTdZyZfGleuZeKELuerA6GubIxyga7udM+EL1AqzUd/16bYgKEmWSxxUVN1Gx2PgOf8mTgMexR8FA4LI3HqTGurHmVi5qRFvIzra/pL8FiL5ZH80kQPGGkdiKsSWcOjUg6emorYzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by BYAPR12MB2918.namprd12.prod.outlook.com
 (2603:10b6:a03:13c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 07:33:15 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 07:33:14 +0000
Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220104191211.1707514-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ba169e67-329b-6ff4-a0c4-e11779f032e5@amd.com>
Date: Wed, 12 Jan 2022 08:33:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220104191211.1707514-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:200:42::47) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e30756f-f38e-4420-dbb9-08d9d59dcb32
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29186F21A45E5DE051BF735D83529@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92Qr4ApIf5VnCQT0ad14mITlMYhXba5rOh7GpBR5SyEyGoShi8+yvC5RNXDS+FxrWWeLWUs0Yva8yEzn9i2TKbMCuz+culmXugoxnnojbEkEd/SgIo6pTJdkI3B0kbzCG3aBCT3yHfsxh9r+4nblwFJKwBtFws52vcCVY0KFe8CqLgUooYucevvRzaBJRUVpk+IG7leyEL5vgI20ytVGWTzjX5htpfZHBq+bj/9ClQyls+KM+EKhlE2U+sFyfWITgUCjMx2wyKz6aKYiqvQ19PF5jNrzPtnYxbAjWfBnCEnNedBeRoRK/x3RR5CILZoazZ1ig52imovrBUWO8EPpJtf8CwUj2HwTDU4LHvaAD000sD2UWm2C/F8cXnh1R0bP2RFvNNspDHQqRSsqSuiSC+WtQhrgYI+lpGMZoxoVQ6h9qJ65q8gPoRbVXm6Lv9YVnJ6SHnbozoO5za0gSQrW9hkIfXNxUjSDPfbgZdspPJKdq3bp5b4Dxyh3fG0tCLjgnlibIFdtiz9wIdH1oxA/TFv+eCoQQSkDxOu2qgcWGU2km+w7m/MGwnXjFvKt1Jw86uoRY/vKTCHrcUgsWlntFdSjfJfNdKIe3EnPFjl0IbW+nirgtTId+0uISyLamM242s3R9b9Ech9dIVsnC2PoKcayJCydRBE+edjZiC7xV5/yhYeICY4z3CqibGXgeyRcwtVWPjZPfoNqYzJzFTszD3vFqjAZNtgpPZBIAEaWAMkQMAbcUnsknVhpvyiYxyqI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(508600001)(8676002)(26005)(31686004)(66476007)(83380400001)(66946007)(2906002)(5660300002)(4326008)(66556008)(86362001)(8936002)(36756003)(31696002)(186003)(38100700002)(6666004)(6512007)(2616005)(316002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlViQWFMRW1Md2Y1TWtYK1hSOXIvSy9FOGIxQmtlNmMxYW9pREJ1NHVtKzNj?=
 =?utf-8?B?Qm5oMGlEU1JIelRYeHFXelM2Zk5NUjVyS2ZXeEdFUGpiMGhsT3pmSEtTdGVy?=
 =?utf-8?B?d2tzYTZLMHljRWpQYW0rTitIMWw2clJYemtkK2kwMkliU253Tlpweklibzdw?=
 =?utf-8?B?MUM1ZjZXSDFraEJUdjlSaDI5VHgyQkw0SEZnbmkvNHIyWFFvQWpWR1RZcng3?=
 =?utf-8?B?VHd1V1pxNWUvampEZU9zTWtxaHRwOUI2V3c4cWkzUFVFTFY0ZnlXeHE4RElP?=
 =?utf-8?B?dXhoQnpBYVJrS2c5YnVyNkFYcjBEQVZDZTRoWWxjT1VpQ2xXWE0vVE5qRTVz?=
 =?utf-8?B?ZTdBV1FDdk5FeFZxN0VqRDRmZkJnY0xqT25nOG10SEpPa08wME45T2x3WFdU?=
 =?utf-8?B?RWlhR3hNWTVkMDNOVDE5cll2N05NV01BNWlKN3BnZkpEVzdSODBrQ01BRmxz?=
 =?utf-8?B?dGRNYkk4VTNUVkhNeUdMclpDdVptSVNDNE1BZTcrRHEwQkcyZlhuQURvUGtl?=
 =?utf-8?B?Ymw5aVAzM2gxdDFsOEZ2Vzhzc3pBczIxQVpRZ0c4Mlg2SURNOHgxWGYvb2xY?=
 =?utf-8?B?ZStuYk85S0lqTmFXVnZxVFVsbWVGSmlrYkhDbVFUUVdoUW5hUVVYcisyQlJi?=
 =?utf-8?B?VVhlQ3hCSW5kc0dIL1d6eW9XZnhVakhvcGV0dURjNDA3ams4aVNob1Baa0Vl?=
 =?utf-8?B?UVpTV2FBaW5jQjlqQ015Z0Q3QVNIbXJMZVpmd25QbWtUSGVJUFo5RE13UmNR?=
 =?utf-8?B?azJqdUtFWkdjWjdUN1ZZNUVJUTJpWHZCUDAvQjBaRlpkMmVaMnhGVUxBY0pm?=
 =?utf-8?B?eERkMmFHOFEvVVZFVlNRcGJEUHhuZnNDTVhPdHVGbW1VREFNbXRZdVViUEEz?=
 =?utf-8?B?RUcrTWtDM1hjaytqaU4yQlpieFlaaXFJVkkzTXZSRHRSYmlJWENKTXEwRVRz?=
 =?utf-8?B?SjRsc0VrZFJ3bkpVbVBHQzgyeFpQZGVZazR0OURSRzlVbTZSM3FScFZKV3lK?=
 =?utf-8?B?MzVjTFFqaWRlc2QyMzAvcmlka0ZSVnEwajhCcnF2dmlLWmVLUUZHRXEybXA2?=
 =?utf-8?B?dk9ldzByOFZlOTcyK0lLaTRoV3VRbnNXR0hlcHhpWitzQkV5QkFFYTV5Ykw5?=
 =?utf-8?B?akI1OTlRR3dla2luaVhIOXJoSWlqandLY01DZkNJWit1M212MW82TCt5MGlS?=
 =?utf-8?B?OEdSWVB4b3JmbWVSZVk2dnlRcGtYV0JlN3ZiSGx0V3M3V1VIMHdoTzlRZjla?=
 =?utf-8?B?cy9maFhVTU5HamQ3RHRNbk9aVXBrbFpmUzBqaGU4a2EwQ2xNdktQZHEvZUt3?=
 =?utf-8?B?TkE0Mmxuc3drTThRMTVTV2hlVGtCT0tOYkppTXhHRStYZjZ2bkVydWJqcDdr?=
 =?utf-8?B?Tzdib0NQUDc1eUFHWmdPWkIvNzYwOTRrQXBwenl0RlZGVElDNzErOXNiVDFG?=
 =?utf-8?B?UDZublRnK3ZrSnhqTnZrOW4rcE1Gd0lJN3g5U3pndDIyc0p0MDd0ZmVKSWVt?=
 =?utf-8?B?L3RUSW9CKzUyYVd0NlZ3UFlpcGdEYlNSSUE4UldOWGhyODNNMGQxbHZacFMv?=
 =?utf-8?B?NVdQQUErYklrRTdYS2k2UXo2MW5hSlQwc1RaWXdVdmFtb2lXTkc1dWpKREV4?=
 =?utf-8?B?eG1Ka3kvZ1hnSUJtT3ZBVFhRTVhoTHB3cGYxVmNmYnhseWVBakFYL2pOeFgy?=
 =?utf-8?B?SnM5NGpBbDNWNnpuR2x5cmpTMytIdU5sRU5mMW4ycm1hTEY5YTNhQVhIZU0z?=
 =?utf-8?B?NGpZT2YrcHdOdXpzbnowY29LaG9UWW9wak5wcSs1SWFhSjI4c0prb09UWnZD?=
 =?utf-8?B?cnJHZW9rK2lpWFVDSkFnN2o1RUF2OVB1Y3RPYVVYWGcwTDg2dTVETmNVWkdq?=
 =?utf-8?B?VDBoeGFnNGU3cUxkeWh1aXZhaGtIUlByTE0yZUw5N3dENU5xWlZWK295MTg0?=
 =?utf-8?B?ZWhsOWYzaUM2dGszcXRnaVhXYkVRVEh1KzRBUWdsTUVHNlRFeGxnc1dqOVRh?=
 =?utf-8?B?L3dUdjVMTitwOTIySHJNa3U4SHlaU0tORk9pbmtqM1MrdFFhUGMwOG1rcUNG?=
 =?utf-8?B?cVE2aWN2UytORTdLK1ZPMkpHZzhxTS9pVW9DeUVhS2l3ZXo5N29pdnhtYTcv?=
 =?utf-8?Q?xmjw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30756f-f38e-4420-dbb9-08d9d59dcb32
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 07:33:14.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZTdjrw79f9tr5APK7NQPYQqLVF09+N7CFHZxeQzDOL386qwW/MgftzD+8/5DDVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.01.22 um 20:12 schrieb Jonathan Kim:
> For better performance during VRAM access for debugged processes, do
> read/write copies over SDMA.
>
> In order to fulfill post mortem debugging on a broken device, fallback to
> stable MMIO access when gpu recovery is disabled or when job submission
> time outs are set to max.  Failed SDMA access should automatically fall
> back to MMIO access.
>
> Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
> page-table updates and TLB flushes on access.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
>   2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 367abed1d6e6..512df4c09772 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -48,6 +48,7 @@
>   #include <drm/ttm/ttm_range_manager.h>
>   
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_object.h"
> @@ -1429,6 +1430,70 @@ static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
>   	}
>   }
>   
> +static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
> +					unsigned long offset, void *buf, int len, int write)
> +{
> +	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> +	struct amdgpu_job *job;
> +	struct dma_fence *fence;
> +	uint64_t src_addr, dst_addr;
> +	unsigned int num_dw;
> +	int r, idx;
> +
> +	if (len != PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (!adev->mman.sdma_access_ptr)
> +		return -EACCES;
> +
> +	r = drm_dev_enter(adev_to_drm(adev), &idx);
> +	if (r)
> +		return r;
> +
> +	if (write)
> +		memcpy(adev->mman.sdma_access_ptr, buf, len);
> +
> +	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, AMDGPU_IB_POOL_DELAYED, &job);
> +	if (r)
> +		goto out;
> +
> +	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
> +			amdgpu_bo_gpu_offset(abo);
> +	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
> +			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);

I suggest to write this as

src_addr = a;
dst_addr = b;
if (write)
     swap(src_addr, dst_addr);

This way we are not duplicating getting the different offsets.

> +	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
> +
> +	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
> +	WARN_ON(job->ibs[0].length_dw > num_dw);
> +
> +	r = amdgpu_job_submit(job, &adev->mman.entity, AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> +	if (r) {
> +		amdgpu_job_free(job);
> +		goto out;
> +	}
> +
> +	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
> +		r = -ETIMEDOUT;
> +	dma_fence_put(fence);
> +
> +	if (!(r || write))
> +		memcpy(buf, adev->mman.sdma_access_ptr, len);
> +out:
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
> +static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
> +{
> +	return amdgpu_gpu_recovery == 0 ||
> +		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
> +}

This should probably be inside amdgpu_device.c

> +
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>    *
> @@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	if (bo->resource->mem_type != TTM_PL_VRAM)
>   		return -EIO;
>   
> +	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
> +			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
> +		return len;
> +
>   	amdgpu_res_first(bo->resource, offset, len, &cursor);
>   	while (cursor.remaining) {
>   		size_t count, size = cursor.size;
> @@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_GTT,
> +				&adev->mman.sdma_access_bo, NULL,
> +				adev->mman.sdma_access_ptr))
> +		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
> +
>   	return 0;
>   }
>   
> @@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>   	ttm_device_fini(&adev->mman.bdev);
>   	adev->mman.initialized = false;
> +	if (adev->mman.sdma_access_ptr)

You can drop that if. Free functions can usually take a NULL pointer.

Apart from those nit picks looks good to me as well.

Regards,
Christian.

> +		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
>   	DRM_INFO("amdgpu: ttm finalized\n");
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..b0116c4a768f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -98,6 +98,10 @@ struct amdgpu_mman {
>   	u64		fw_vram_usage_size;
>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>   	void		*fw_vram_usage_va;
> +
> +	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
> +	struct amdgpu_bo	*sdma_access_bo;
> +	void			*sdma_access_ptr;
>   };
>   
>   struct amdgpu_copy_mem {
> @@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>   int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
>   
>   void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
> -
>   #endif

