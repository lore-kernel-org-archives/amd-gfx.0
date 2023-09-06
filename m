Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87E4EB8FD8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 14:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2166F10E672;
	Wed,  6 Sep 2023 14:25:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B412110E676
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 14:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnBhNKJbY70a1p1Zc2OOUowxwIyNJfTeSWnstRFquzq+iKV0XV+ASFrEZzpSp+mG50KJ60sGlZ8NA0YE8zZGZDY4Io4bl8QkiHMq/McOD8Oyy2BSR7D2e90IcbjuaxnD7wkgHsBGv1f2cDzL2Ga+0rAI6bI7yEB38KIB5yns4vWiJ93zaUCEMRG/Rwi3jbjcNqVYarDsK5M281OyAWAaXEeISCvUDtTY3aEKJF3ZFSuZ7pjRwkW6UTbIrb2kB/4lBAvY5cwwoDexyVtR+uCypTPOLd50jWlc3EDemO5VK+2OHB1+BiO2k3TR6zLujIHx1vu5J2/pX70E46h2vjAiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUPYTCBJqk1lGY60ejMTbiUX/1EgIr0h9MUsNW4pHVw=;
 b=JXpICu38EmSJPC3gE5Wl4g9SyfmPADLB/rmrORJEbZpuWpnm16GdxouZwXOWvSirze9rgghFJMiMRvkFamHWIOVDekWNMdA7Id5ZpiImt3bGkIcvxstPwr6dq2wXafNM5WA61MaPPXP3OyzlXJheKGWzt6AQ1Xngv9ZAlupA+SOhN2JH2LIKRXLpv3tHlnByDKOE82lWOBInRaWhwgqlekMl3JFgV66iFpMeOQC7JvWznwG33H3ORmOZ14HxqXgjYHAbUtuOhTkXI5trFsri5WezI4yj7qyc32rqTblM13cMrcBwPd1vvNZeS/+eIwRiSs+3q8dEUBiwYs2Yj01Q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUPYTCBJqk1lGY60ejMTbiUX/1EgIr0h9MUsNW4pHVw=;
 b=zsKrBSqL+r1L8tXNKzLpNBgJsvIXlV+mOuj5f+8+UhPD0X8gdc2Q27rlMQK7jj1jWOdEW/n6rXv6OWn1GumeJoosjNDX8w8Yp6zIz0w4xyQedft6KciYV4kZk5U8D1aQpuQ3DR0DAbwjdiTTcG5YQSKROQfMP2rZp2GQcvfuq8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:25:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:25:10 +0000
Message-ID: <4995b233-e9db-93a0-1ba6-60376cb5d024@amd.com>
Date: Wed, 6 Sep 2023 16:25:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/11] drm/amdgpu: fix and cleanup
 gmc_v7_0_flush_gpu_tlb_pasid
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-5-christian.koenig@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <20230905060415.1400-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 669570fb-e600-4222-97d0-08dbaee51388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NauJzhoU9Un/bTSeusyLk7S5V7r6rpW37mOO/fFw4nz+/PBs+xqhu2aoGG15nreVmFhkxM1T0MIHueO3H4PzdqIHW/WdmWeiumOMnAkoHqKctcADfqB0kDyo6AfosJOj3OMetdZUjs5E3FQO8C1OePazlH5kvACLfl8OJhpsIP0lt65Rj9/WWKBqk32F2+V0WsCYdHo8IDCXv6tLUsAnvvhQImgcfnWYgWlO/uNkOoQU2+f6XhLbAAv7qq9KUmPYPsoHyPEMsZTxTw0yxML3wAUCShHeqWS6HzjMQxzqqgfCmW1fLFVQ1tbZYOrFrUuIpt90G4HvAMwhStFlfcuybLBpucFoEOe/uh8+xs+Cxs2haWFE9hiOl2XXh9TBoboVKUZV/DNl6kbW1qJEvNXaBAzAafB/w6ebn09zM8kE2LZEIqKsGdf+poGI3LZzYjQgFyOQrHmEs1tKXAYXcIO744c0tqVhlb9nH7xTfx54qul2aJabbZ1ujl58lisQZMXoDkqU2yoJRxe6ok0QUuWT6pXQHuh0RKOTOiDLJF65oBEWXtPP+hLYH5oor4Y6GvJGdaezSThqzNrIz/CDaerIw5fzHOiDebTLw1uOLyx+3B+77/+KL7UjrmidG9Hnd3tGLfzZmddUeTZ9Ynspgry9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(1800799009)(186009)(451199024)(41300700001)(6666004)(6486002)(53546011)(26005)(478600001)(6506007)(83380400001)(2616005)(6512007)(66574015)(38100700002)(2906002)(66476007)(36756003)(86362001)(316002)(31696002)(66946007)(66556008)(31686004)(5660300002)(44832011)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBMcFpYRlRuL1JNUkRNNWRUZXJHOE5LZkZVZ2x4NjJoek0zWVZjQVl6dWlG?=
 =?utf-8?B?cTF5YzBNVlVTSndrZzRHQXJjUTROV2tObitqek13MEIvTS85VkRvb1RWZXhp?=
 =?utf-8?B?RzBRcDQ1b1IyRjhlMFo3OTJqTFNaTDFVZDFxNUdPZlB1dEFQam9obGovaUsx?=
 =?utf-8?B?L01FVy9ySWJQNFdmd0dIcTF6eFMxeGsxclo2NkVSTGViTU5yY2cwNVlUQWdP?=
 =?utf-8?B?K3ZEY1pOcURiS0x0MDVhUVlCaGIwMFlhcnVTRXVXK3NHZmFuMHRNZmNidkhq?=
 =?utf-8?B?bkNQbWZQWDJqMmpzVmxOdGNidkdpYmUreEtsa3dHeU1QTndZdTVnUUN2KzZl?=
 =?utf-8?B?ZDF5MEE1TXhzclpudHR3MGJTOTM1Z1FLQ3dGTVAxS1RWRmZZd1FiakM3TUJS?=
 =?utf-8?B?QzNuOGdFREVnVlphcXVRTWRYMzd6TWJnOTg0Z09FRlp0UW5YQVBqbzdDelVF?=
 =?utf-8?B?NjZzYnhaSzhlTHNOQ2JOYjJZTUN2dXVEOWtkOVNTR05YS1RzMUlCc1QvL29m?=
 =?utf-8?B?MEdFeFh6YXhKL0htRTZXK0lxTC9LUzZEWW93bStkVnFGVUpocytMWjIzSWFQ?=
 =?utf-8?B?bWU1NVY4ckU5N0MrdDFVVytZOUZScmxwYzZ0cVd6TFdvVURqZ0RXSEROU1Bx?=
 =?utf-8?B?aWJ5L1V2NytUOW40MnVTTFhCd1laMUhTanplQ2NNWWUxUmxUTEFKN2l2ZWxV?=
 =?utf-8?B?a3YyTnhYeU9qaHE4aStCNjNCaVZmc2QvcVFubGpWUFJqTG95b3d0Zm0yd1Jz?=
 =?utf-8?B?UmZ1cU1lWWptUUVJZjN1MnVQYzdpQ0pWR3JYQTc3U2Z1WWFPWkZIcWhmYlRH?=
 =?utf-8?B?cmdRUlRZU3NSZVhPZFE3K0hDR1lmQ0dkbjhjZm9nVXRHRnRMcC9heExFem1a?=
 =?utf-8?B?RFBIanpqWlhGSVJhTTZ1RWE5TnVVakl3Ri8xREJWT3kvYjlKcWNEUUx5QkRz?=
 =?utf-8?B?MHVvNFNaTUkzV1c1QlVKTnlwSGx1RGNOMkVCOFdTNFNhMmVNQkpTVVJETmtW?=
 =?utf-8?B?WVQzZ0hCL0lxWkFLUGFacnp4QW5FLy9TR3lRL2xNclYrbGt4TnZKTUF5S1ZH?=
 =?utf-8?B?YlFqNi8rWVNEeVZ1U3dwdnhNemVNd1NzRGVNdWpsTkpWd0pYdXpMeHJCSVYr?=
 =?utf-8?B?Q0dsN284Y3Y1aVlpNlpncTg4d3MrYzU0a0VsNEJGS2k3YStDUlNGaURkUTBJ?=
 =?utf-8?B?QzJTUnlVOXpyMlBjKy8wNVAyeXpKSDhwMThPSTl3UWRRd1FqdUZkc2VDSkwv?=
 =?utf-8?B?NitIMDBCTE5VeXNDZytQNzUzaGdvb1o1VEIweXZxcWh3WUFVMFRlN2lVUU9N?=
 =?utf-8?B?VXN0SmpTTlRFVDFaR25nSkM0alRkdS82MGxxWWczVElCZVdYcXoyVkFYajJJ?=
 =?utf-8?B?c2E3ZU16aUFha2RPSWF2cTBWNVVpUXArUVdyZGc3L3E3RXU4R2VsUWJBbzBG?=
 =?utf-8?B?VW9ORWlPZ0pGQ2tURmF3RDY5TlR1dERvTDF1OXByV0YyV0lJK2UzdjFWZUpW?=
 =?utf-8?B?d0U2U3gxa0FLNHpNZGZkT0dhS1BFbVQ2c3hueXgvWE85VW9STmdYV3lwRXRh?=
 =?utf-8?B?VlpzQ3N5SzgyVkljYnBoNU1GdkoxR3VuWnk1N0x4bEpJY1YxeDdhSjB1MzJF?=
 =?utf-8?B?WGt6ZE01WFVUVTdGSWxZU2VyeWM1ekVlUGROSXNhREpnVDhKWUJveGtyZi9h?=
 =?utf-8?B?cmhBSzhscVo1Mys2Znh3MVI4TTRSbmwvZTMrMFpVSEFpODFBdnNETi9QVGUy?=
 =?utf-8?B?ZXNiS1B3SHVCTHJ3Ni9YaHRpQzA5UkxWMU1HamhRWXdoeGRzcGV0NktmakRD?=
 =?utf-8?B?a2MzZ1JoaHpYcDZVWjRPbkRkd3FnSHhUSUxsN254NnBzWVRGVGZFUXJ6WDNY?=
 =?utf-8?B?L2tENmdLMGo1a0ZtZHZCaHRMV0xpb0Z6bFp5WCs3ZjhEUnRqWUFjRXNPWFp2?=
 =?utf-8?B?NFRuK09kUzQxVktQaU1QQVF1RnBLbUQ3VXhRbDU3N3BvNmpBZCtYdzlVMXVm?=
 =?utf-8?B?bVlhQzFSMUtYREZkVEJRZzJLbHhES2RLcHlaUnhDeHR0NG90aFV3K1czU0Nt?=
 =?utf-8?B?b3RqMlRsN3JlNTdHNHcyc09iKzBZYmg4cmZPTmJ3R2Q5clYrckxDdC9pZy9t?=
 =?utf-8?Q?iW3AanlGp6ZaIkHCGmE1nJlSI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669570fb-e600-4222-97d0-08dbaee51388
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:25:10.4363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3ytIgiX3ye2fbjC2PpUtTdjbuzfrndOaVK/1FuiaHjLcCMXV5Ax9PFGoPLFMreyj3/geOiyNRBjelUrCSb/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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


On 05/09/2023 08:04, Christian König wrote:
> Testing for reset is pointless since the reset can start right after the
> test. Grab the reset semaphore instead.
>
> The same PASID can be used by more than once VMID, build a mask of VMIDs
> to reset instead of just restting the first one.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 6a6929ac2748..9e19a752f94b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -33,6 +33,7 @@
>   #include "amdgpu_ucode.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_gem.h"
> +#include "amdgpu_reset.h"
>   
>   #include "bif/bif_4_1_d.h"
>   #include "bif/bif_4_1_sh_mask.h"
> @@ -426,23 +427,23 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   					uint16_t pasid, uint32_t flush_type,
>   					bool all_hub, uint32_t inst)
>   {
> +	u32 mask = 0x0;
>   	int vmid;
> -	unsigned int tmp;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EIO;
> +	if(!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
>   
>   	for (vmid = 1; vmid < 16; vmid++) {
> +		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>   
> -		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>   		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
> -			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
> -			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -			RREG32(mmVM_INVALIDATE_RESPONSE);
> -			break;
> -		}
> +		    (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid)
> +			mask |= 1 << vmid;

I am a bit concerned here about the change in code, in the previous code 
we were writing the 'first match out of 16' of tmp and of mask and 
programming the registers with (1 << vmid), whereas in new code set we 
are writing the 'last match out of 16' of vmid. Is that intentional or 
expected ?

- Shashank

>   	}
>   
> +	WREG32(mmVM_INVALIDATE_REQUEST, mask);
> +	RREG32(mmVM_INVALIDATE_RESPONSE);
> +	up_read(&adev->reset_domain->sem);
>   	return 0;
>   }
>   
