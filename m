Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A599EEB570
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 21:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A584410E94F;
	Fri,  8 Sep 2023 21:13:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06C610E94F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 21:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhmgwEetZ8YCynIa0tNlRBs3WoeNAtuTaIN8pgZ86LzbKNtZaWCqKK0fr9wmMhV0m0KUtw/tZQlGayJIjGx4aZxJiu65V/VdKUFbRUfJC8Nl07HnrXSNYUceIUvn6MBQhtVuT/LU6oMKHaGUKiGewTYKPgLPgDva17S1YRP9awj/jd1TSOmV6RhPj7ibWYr95uRZDM/5ptmjOXwAX4qeyvHjBPpzKJ5OvCo2rxJSRCduKlD4Fx72Cn1p1cSnzK+el8xcJ4mqppuFOkPDXpCCcjV96joRdDgIkmFKPfW+RF6xPhKFGV5hMgiq+NaASqozjqIua2rLOgUFtw9BK8YkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZqSsuUmasGbKqTM5VYdHRpRa6gxlGtXNNaDbxOLuKM=;
 b=gOBXGBQtVhNRyIb4nAYAROntQQTis14IwcVe/4ABuK2Kutb//g5lHhLPdvslBFhnPj1CvscKWmG0wWC3gzw9G/mC4bE0kLRLF3tTzD7wH22PT6axv2PGjOwcv1utwL+WqIXHCNe8rhtsJwEnLtlHPbNsV0TJTVMrXL7cJ/3BeEzQx6jozjBvcrUghzwK2VxwsrOygTU7ndyfP4NAK09ct8f8cJyAIXQWxmvd4KnI/jVp8oMxPCQBcicuE4Y5etrSmWzykkrsKTiUs/TzqeIukOtpAepmi5DYRIOvRl1Xu1HugqpQDSFq6uvE0pHSsxNmyNMlXbJzzrKCPaTzr0l7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZqSsuUmasGbKqTM5VYdHRpRa6gxlGtXNNaDbxOLuKM=;
 b=NJ4cg7b1rt+VkhdN1Q3t+GsPLE2cEpVxV0MUEDotNwWDqjKhWw4HmJUkVHxslWw2Ox0ouNQzDfbzaDYziaHcI7txbEsgFt/um2GmQ0dIe/IkJJTnHDQ/t46+spBs66rhpP4wsb616DiVa0N3gSjE9N1ae+nhzg/jYUyvXIUEq6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:13:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:13:20 +0000
Message-ID: <67051096-14c3-36c8-9f3d-009c2560cc99@amd.com>
Date: Fri, 8 Sep 2023 17:13:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 06/11] drm/amdgpu: fix and cleanup
 gmc_v9_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-7-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230905060415.1400-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bec0387-edf4-4a32-9004-08dbb0b06d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bf0QXgFQ9uornhcVxKW/2BUBAkMMrDqpA0ULIOwr3hAU95ni7IWpq/7TfQ+/3qxZjfyLtsV2paBU3KqWpFBHea/bdbNbcVH+Aiw1L8jXIjzb96qPaPmjTQKmZvR7YwgUF1alNAMQocBYal4xaHlRED9XP9BKRZNAj61oiZgBop/Qy2Z0bs4m2+x4DE+ekJsx+F4EBgBeUZ3OFrkiEu+5JVinIpEIB/n1tqyXkgOYOy+qmOd/GT9FyDT09FOR0hM9/5E3n0GlPy9YMIzWkjMrWWDJYBNkIWU1BGZ/Ok0ip1OJbAFtudNbgy8mzwlrjh7Uecgj3ohknLGo19KN3aU8WACKwJvaz0zMV9oh0Rgh8ed6HN7Lcj7J2ByD59UJ66UIJ1OORDR7CWx7mRph75zA0vQB8eb8LAmV8ksRtatv71jchFSVYJApOekREGOA22UeI/ZGXRB0YfVjYG707HpQtOo3sJt5+kvsDj8EhtYo/isItQWaKLqevsU9N29zcA3obKa4alEEGgJJHTxHQrKBo7qRvbF4apCB2HM0jBlf3XGZ2Zw/zIHcOhmO2PwmF7l5Jvgxj+xOl+UwCpkEIcGQaBcPLS0BarD5tisPGp+2rxqD3yeMnhePScvUN5HjkhkVgfYWV2+5JJKY4QOmH+pI/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(186009)(451199024)(1800799009)(6506007)(53546011)(2616005)(478600001)(6486002)(4326008)(66476007)(66946007)(316002)(66556008)(36916002)(8676002)(8936002)(6512007)(41300700001)(5660300002)(83380400001)(44832011)(26005)(31686004)(66574015)(2906002)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtwcE9SS2llNVBHRy9oS3VXdFNKcG9qdUl6MTRUdFFqSkdMSU1IR0xCTVhs?=
 =?utf-8?B?MTA0eXhQQXVTRVU1dDEwMmFRZVVUcWJMNkhXOXhsV1dvTVNVamhaUEE1YmVu?=
 =?utf-8?B?MUZPckd6NCtva09XTUw1R2ppcFU0bndtNStZbDRFcHh0QmsrR1Jwcy84TmhY?=
 =?utf-8?B?V1pHZ3ZUVlpkanZrSytPcWdWUFROaWRxbnkzNVVOK2pjVVFGc01nb0E1YXo3?=
 =?utf-8?B?YlBEOUk0VlRmRXlyZkhnWHcxQmYwazRsbzZJRml1cHpkcWhkWXhiUTl0eHdC?=
 =?utf-8?B?dGZBNVdySXQwSWZIaUYwdlZ5ZjdCTHhrN2JsaTlPb1lKZDNiWjdKQmVYZk9i?=
 =?utf-8?B?Qkw1ejZjc2U3RjlqazhCNHdJU1F1M1RpZnRyYjhDaVcxayt1UC85V28zd2tX?=
 =?utf-8?B?NDBCVm1GMDRDZXg4RXJndnNOTGF2QURORE9oU2VuSHVBcFFwOE1GNzJLSHhT?=
 =?utf-8?B?eDFwRzZrMVIvYi9TTTJJanBOY1ZvUCs3WkZwYjBkcXFCT2lQRzlDNnlSTkhZ?=
 =?utf-8?B?RDdiL0hPWFFYem5FOVJKa1AwcnRuQkw2a0FUcGY0bHhLZHgyVldGU1I4dkxt?=
 =?utf-8?B?YzlBVHBrUjZsQmh4UG1kdU9mV1NCeTZmTHVuVVBwaFhHV2ZUU29tM0txakl1?=
 =?utf-8?B?blVlbXZ5OFBmeUZRMGx4YXJnNlFxSTIvT0xFazFyeGY2TUdzOVgwL2VDajhq?=
 =?utf-8?B?QnY5TkRZRzEycjhvSGcreUZBdVJuU2tBUk55QVl2LzFMZktSTmFiUnZ1clNk?=
 =?utf-8?B?bVFkaUQwbDY0UFoyWHh1bnNub2hlaVpxQ0l2cUhqajhFOFY5OHAxMjNvV1pL?=
 =?utf-8?B?bzlFbmk4OUY0bnBVUWdPV2gzQ01CSHQ3RVNiRXZEdWtGaUVFcEhrUjRyd1lR?=
 =?utf-8?B?U2U5dWhmNHBBZjB2M2NUT291d3J4dSs1QTIwdVUwdHJ6UUhWWitlT0RHeDUw?=
 =?utf-8?B?YytZbnRvenFyN09FTG5ldnhPYXUwdjlNYmxXMDVkY2VqYWpIR0Q2VHpyeFkw?=
 =?utf-8?B?SXZqVWd0cmZUMHgxcE1qbWFneUNVVDJZQnRqYWJiRVBGMUdTdm1PUjNENytU?=
 =?utf-8?B?cXJKL0JzY052TVRWSXMrK2k5SE5TcjJRM2NiZ2ZDUkVnUTE4Q3JtQWtoM0Zh?=
 =?utf-8?B?Rjg2eW94L1ZQa1ljY3MrNEFkZTNZVGFHRDEvRlhLVGM4YTdXM0NiYWlFNjRI?=
 =?utf-8?B?d2J4L096ZVZTTmpaUHlEV1dCb01Gd2FSYXVydWNCcE4vcWdHbjQxMXhHZ1pp?=
 =?utf-8?B?dksvS1I1aE1ZdUZSRDJ2N2lZUVpQYWNYekhFSGhLaFVNY1F1M3lPbXI0QkdQ?=
 =?utf-8?B?dXdzU29HNCt2TU4xTmx4WDcyeXgzQnVJUnRIbVFrZTVZSHcvcUNyeVNvRW84?=
 =?utf-8?B?UFcrQkRCNkhKU215WHBXaVI2MFBtVGVLd3MvblNCdkQyTVc2ZE4rNld1M0kw?=
 =?utf-8?B?aGZBcXBtTzhsOVVaaUFyVHRXaEduaVIyUU5mZjZKMlFmejYzaFBORXhNWDVP?=
 =?utf-8?B?eE5WL1pLVitIWkdxSWVUSVJZU3NtRWxZVGRlTEdacjlSQTFFVFNrNFdTVGU0?=
 =?utf-8?B?dnZGV1FpcDJyQmMydmcrbk1sUmE0WjNkVGkyeTlkaVE4TUptbFlOUmFIREQv?=
 =?utf-8?B?KzVUQXE3UXdWd0Y3OExIcXoyL3BNWlFYVk1PWktkUnk5MEh0U2MzMU1tMG9E?=
 =?utf-8?B?Vno4SkRZZ1NubVQyeCtUUVBtYlNybzBBREtUVzRnRFlWSmxZdGllVkhmTS9h?=
 =?utf-8?B?aU15dFg5Z3l1OVpaUlFZSmFpd1U3Vmlrc0NpYkFCOHVIb1k4MG1PQUJIQUww?=
 =?utf-8?B?OEhTdER1Y2oveWN0WGJ5cFVBZjdKREJFZXBBMjUvTEJuMUM3dWpSNUsrMTBK?=
 =?utf-8?B?WXNuaTdHR3VQTlNZakJKdmpPaFlLSmJtQ2dwZkVYMWlGQ25EaFNBRXFiT1Rj?=
 =?utf-8?B?a2REQ2VGWkZKUUdhNmJaVUUrTXlRSEg5d2NFaC9IYmRPdndyL3U1a3FDQVNz?=
 =?utf-8?B?MjF5cUNiOHhZNjRLK1FxbmpjREZZTlZoWUZpaDNWUWNJMm9GOEpTMGJHRFlv?=
 =?utf-8?B?bDRlUzNQZGo3S29IN1lzQWU4Y01uSlZCcUNKTkFsS0lsRlY0VnptakJtUWh1?=
 =?utf-8?Q?ILpxw/faOseKazXjqKAKzTI93?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bec0387-edf4-4a32-9004-08dbb0b06d4b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:13:20.0022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVsuqz5sLbEdgPOVDZXqZi3YPO8Xpl0dbaR4m3kzA7S7r9SqaGx9spVXYH7zIjTGWb+W4UDzHyINkr3PDEJ2lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-05 02:04, Christian König wrote:
> Testing for reset is pointless since the reset can start right after the
> test.
>
> The same PASID can be used by more than one VMID, reset each of them.
>
> Move the KIQ and all the workaround handling into common GMC code.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
reset -> invalidate.

With that fixed the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  60 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  10 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 109 ++++++++----------------
>   3 files changed, 102 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 857051093900..b5f1a1218725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -32,6 +32,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_gmc.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_xgmi.h"
>   
>   #include <drm/drm_drv.h>
> @@ -623,6 +624,65 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>   }
>   
> +int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
> +				   uint32_t flush_type, bool all_hub,
> +				   uint32_t inst)
> +{
> +	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
> +		adev->usec_timeout;
> +	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
> +	unsigned int ndw;
> +	signed long r;
> +	uint32_t seq;
> +
> +	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> +	    !down_read_trylock(&adev->reset_domain->sem)) {
> +		return adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> +								flush_type,
> +								all_hub, inst);
> +	}
> +
> +	/* 2 dwords flush + 8 dwords fence */
> +	ndw = kiq->pmf->invalidate_tlbs_size + 8;
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		ndw += kiq->pmf->invalidate_tlbs_size;
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_0)
> +		ndw += kiq->pmf->invalidate_tlbs_size;
> +
> +	spin_lock(&adev->gfx.kiq[inst].ring_lock);
> +	amdgpu_ring_alloc(ring, ndw);
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +
> +	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +
> +	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> +	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +	if (r) {
> +		amdgpu_ring_undo(ring);
> +		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +		goto error_unlock_reset;
> +	}
> +
> +	amdgpu_ring_commit(ring);
> +	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
> +	if (r < 1) {
> +		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> +		r = -ETIME;
> +		goto error_unlock_reset;
> +	}
> +	r = 0;
> +
> +error_unlock_reset:
> +	up_read(&adev->reset_domain->sem);
> +	return r;
> +}
> +
>   /**
>    * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>    * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 9e7df2f69123..7732d4ef845e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -335,11 +335,12 @@ struct amdgpu_gmc {
>   	u64 MC_VM_MX_L1_TLB_CNTL;
>   
>   	u64 noretry_flags;
> +
> +	bool flush_tlb_needs_extra_type_0;
> +	bool flush_tlb_needs_extra_type_2;
> +	bool flush_pasid_uses_kiq;
>   };
>   
> -#define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, inst) \
> -	((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
> -	((adev), (pasid), (type), (allhub), (inst)))
>   #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
>   #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
>   #define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
> @@ -404,6 +405,9 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>   void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   			      uint32_t vmhub, uint32_t flush_type);
> +int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
> +				   uint32_t flush_type, bool all_hub,
> +				   uint32_t inst);
>   
>   extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>   extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4f6990ba71cb..39016b6900d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -954,87 +954,30 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   					uint16_t pasid, uint32_t flush_type,
>   					bool all_hub, uint32_t inst)
>   {
> -	int vmid, i;
> -	signed long r;
> -	uint32_t seq;
> -	uint16_t queried_pasid;
> -	bool ret;
> -	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EIO;
> -
> -	if (ring->sched.ready && down_read_trylock(&adev->reset_domain->sem)) {
> -		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
> -		 * heavy-weight TLB flush (type 2), which flushes
> -		 * both. Due to a race condition with concurrent
> -		 * memory accesses using the same TLB cache line, we
> -		 * still need a second TLB flush after this.
> -		 */
> -		bool vega20_xgmi_wa = (adev->gmc.xgmi.num_physical_nodes &&
> -				       adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0));
> -		/* 2 dwords flush + 8 dwords fence */
> -		unsigned int ndw = kiq->pmf->invalidate_tlbs_size + 8;
> -
> -		if (vega20_xgmi_wa)
> -			ndw += kiq->pmf->invalidate_tlbs_size;
> -
> -		spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -		/* 2 dwords flush + 8 dwords fence */
> -		amdgpu_ring_alloc(ring, ndw);
> -		if (vega20_xgmi_wa)
> -			kiq->pmf->kiq_invalidate_tlbs(ring,
> -						      pasid, 2, all_hub);
> -
> -		if (flush_type == 2 &&
> -		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
> -		    adev->rev_id == 0)
> -			kiq->pmf->kiq_invalidate_tlbs(ring,
> -						pasid, 0, all_hub);
> -
> -		kiq->pmf->kiq_invalidate_tlbs(ring,
> -					pasid, flush_type, all_hub);
> -		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -			up_read(&adev->reset_domain->sem);
> -			return -ETIME;
> -		}
> -
> -		amdgpu_ring_commit(ring);
> -		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
> -		if (r < 1) {
> -			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> -			up_read(&adev->reset_domain->sem);
> -			return -ETIME;
> -		}
> -		up_read(&adev->reset_domain->sem);
> -		return 0;
> -	}
> +	uint16_t queried;
> +	int i, vmid;
>   
>   	for (vmid = 1; vmid < 16; vmid++) {
> +		bool valid;
>   
> -		ret = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
> -				&queried_pasid);
> -		if (ret && queried_pasid == pasid) {
> -			if (all_hub) {
> -				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
> -					gmc_v9_0_flush_gpu_tlb(adev, vmid,
> -							i, flush_type);
> -			} else {
> -				gmc_v9_0_flush_gpu_tlb(adev, vmid,
> -						AMDGPU_GFXHUB(0), flush_type);
> -			}
> -			break;
> +		valid = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
> +								 &queried);
> +		if (!valid || queried != pasid)
> +			continue;
> +
> +		if (all_hub) {
> +			for_each_set_bit(i, adev->vmhubs_mask,
> +					 AMDGPU_MAX_VMHUBS)
> +				gmc_v9_0_flush_gpu_tlb(adev, vmid, i,
> +						       flush_type);
> +		} else {
> +			gmc_v9_0_flush_gpu_tlb(adev, vmid,
> +					       AMDGPU_GFXHUB(0),
> +					       flush_type);
>   		}
>   	}
>   
>   	return 0;
> -
>   }
>   
>   static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
> @@ -2335,6 +2278,24 @@ static int gmc_v9_0_hw_init(void *handle)
>   	bool value;
>   	int i, r;
>   
> +	adev->gmc.flush_pasid_uses_kiq = true;
> +
> +	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
> +	 * (type 2), which flushes both. Due to a race condition with
> +	 * concurrent memory accesses using the same TLB cache line, we still
> +	 * need a second TLB flush after this.
> +	 */
> +	adev->gmc.flush_tlb_needs_extra_type_2 =
> +		adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0) &&
> +		adev->gmc.xgmi.num_physical_nodes;
> +	/*
> +	 * TODO: This workaround is badly documented and had a buggy
> +	 * implementation. We should probably verify what we do here.
> +	 */
> +	adev->gmc.flush_tlb_needs_extra_type_0 =
> +		adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
> +		adev->rev_id == 0;
> +
>   	/* The sequence of these two function calls matters.*/
>   	gmc_v9_0_init_golden_registers(adev);
>   
