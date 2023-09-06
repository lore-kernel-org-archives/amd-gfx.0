Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64298EB8FD9
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 14:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AE710E673;
	Wed,  6 Sep 2023 14:26:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C67FE10E673
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 14:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL6rxWKbhv4SIQwJ4zRLMDTrxPb1dB1YjdwyUvx67woUZgJz/8yOhXw3163yQc2IZOFxjyAh0dJesiydivpL8HFbH2YIBM9UGRLCHE5pneCrZjrhDRlT8rXWiWKdnJ+dDW8UM/WRvdXjjeLIt6dHHzVmg+s4bZp4MR0lRglKQ1xLr2Uat4FPYx0uQoeW8f0E0uckkHoXdyoGhOnOxtUfL58Um6MmrrI2xiVodCnyqXkf8gP7lh3i8mG+1m9R59qGnQ8oAfykLdN8P8XQovg3nTzmIXve5lyzneu093U2ebBug85mqjP6BWHb8NgCdT0T4MxKbE8jre6lv2RTwZRd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFn4+ZsffpRN5V2M6RYj4rR83RormMd3fqKlafo2xp0=;
 b=eY4k72qm7tEAGcLarl6E9l1SIzJWztzIxjyAxyX3I7YqpbrZlkheIRbijUGT1ZEMDYY37NXWHhh3HeaR+0G8JzxODgZrinfRzomjR2UD5StwEWMR0/WUT/HDcvgO1D/cBN2kJX2/1SialqOVtRi1BwSZsIrQZ+9Po3UWHXr10PzyokxIJHJxAi2ZsRtLCGu9pJN4Zih0dKPdRJ2n+hxxKl9gZMjVIGLt+K5N9VTiLFAsBO3FSJgYAVAWQ+8I7g/09XcjRC3gHMvWyZKEvs4EG2U76Ak4UyaS43Ou6ML7NGkK27BQVte6dRAwOXyNUvPtS3H786Uv23E5V1gIoIZg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFn4+ZsffpRN5V2M6RYj4rR83RormMd3fqKlafo2xp0=;
 b=eRfx3Pfw0Qaeezt0e27qJg0wydusnc8OAZmq4xAD+TnQh3DUqQoqMM67uHESJMBCYIM4cDIXFaUeauNJyre1AZVOnCQ5q4ZtK8rmZmwVFfOkNncuzMcmFYz36IwKeTUCuzkVYLneF/UiQRy4QjMDuk5NdBpeGfppmW5cw06YVs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB5516.namprd12.prod.outlook.com (2603:10b6:610:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:26:48 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::dc06:ffb3:46ec:6b86%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:26:48 +0000
Message-ID: <9988ffcd-0e72-39b7-60d1-4f2191764e1f@amd.com>
Date: Wed, 6 Sep 2023 16:26:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 05/11] drm/amdgpu: fix and cleanup
 gmc_v8_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-6-christian.koenig@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <20230905060415.1400-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: e22c4bc9-0c1b-4b1c-9f59-08dbaee54dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJnagPLl/Ap8hJAAqi8z2lf6Cr9uNcGIKmiGXVCRXbxMiJ1ln86XX3SDMAHJqy70jYmvtzOaQ/j6bDK7jzjTXeHL+iElOz/hxePFa/ZzNYdbT1o42lWt+MXN+wIT1AF4V6FDZfkdLBbvYS9hKhI0OMmGVzJuBT8/jP5foqOrQjjVum9N/jf+4gnx/BOZWbjRg9CFfdSJIJKqnZbjSCakzM+3RqEpXl8E0O6z8obZonn/cIWPdypp11BnIW8g+cvEXx91rVYje3v9cX8EvxR0NHVG2kCLEOLyyn1PtcpYuHcFIwCcyj8CYeV1TL081p+Go7RVA9Y/CDgnQT2frHOuGCK7LDB4ph5/Ih82F/uez6I1OaR63giSkqhCd4wiZQlr/nFAYhISmpBB+MzuZB2TvBB7JTLpdyCuJFMxfFzoLDxqdLWeoMdjnqOql45nVki/7xPwmj7f5R+JZuTJL2aoryJdrpswk+bkYMd7S+MTumQddVIvwSyX/U2jWdXiiBnSFKKjG7QuMbqZDv6wDgE76Cv8xcr9qkhEc+A0IbUxInx+NLZ83+y1OmlclS31N4AmUuGeV+N0lPr0+MSC69BWWrSrxtAjtLSxcimh2cHm2Xa3YKwMgls7NFMP5CqF3XbQUBXBbeiUsCnqqUty44bQZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199024)(186009)(1800799009)(31686004)(53546011)(6486002)(6506007)(6666004)(36756003)(31696002)(86362001)(38100700002)(2616005)(66574015)(2906002)(26005)(6512007)(83380400001)(478600001)(66946007)(316002)(8676002)(8936002)(5660300002)(44832011)(66556008)(66476007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0czNGZtQkRyUnlNSVA2Y00zY05qcmYrTW5qekZsem1MTVZXNHlibTd4bC8w?=
 =?utf-8?B?cFNYQTBDaHYzNk5FSEU3YzJNdHZacWZYZHBrenBrcHVhYXVwNzZLdW9PWHl0?=
 =?utf-8?B?TEVIV3pBbjRUaWM1OFFjTDI1UjhXeXU5RDdUUWNvT2xKSkhYcEo3TG1IcW1F?=
 =?utf-8?B?R0JpeU5uSGNtUGt6bTlGYjVDMTJzdk01TkQ1UTdGc3JZeStpTExZcEFGNEQv?=
 =?utf-8?B?L1UweHN0Q1JzSWFYWWk1MTVBWjlveEZNbklrMDl0R1ozdjB3TitpbGkwMDlr?=
 =?utf-8?B?b1VienhRdTRVNS9FdnpsdmZiRE8zcVdPZ0VFdHR4d3o4eGhaUmU5UFdXOWlx?=
 =?utf-8?B?cDN3eGdLY3F1T2g5WUNRVnZEVXhoSkFCV0lqZlJIbFlwcFlDUTU4cEZOcjVC?=
 =?utf-8?B?OElsME9Ia2s1NHZyRTBPc1NzbE94K1BWL2pBdWRlQU9nYXdlbitwbkNrZUZi?=
 =?utf-8?B?Y09helBRVXVkbFRMbG5JMDMxWkFidDBmNGFjOEdYaWY1dTEwWUkraGFGeU5C?=
 =?utf-8?B?ZTlHWE9yRWp2S3lhNVVVOXNHemc2L1hOblhmZWFTYjl0d2RJZDVCK3RuaG4z?=
 =?utf-8?B?ZW5mZm9ZQ0lKdlVYeWlyMmEzYTVyTmU0UVMzZ1dOR2lKclR3bFovQzhrQjVF?=
 =?utf-8?B?MEdaWFl6TS8wWUNuT05wQ05pSHJWcW16Wm9mSXZ0bWFEM2Z1MThQZFRGdXE4?=
 =?utf-8?B?VlRBcWlzMU9iZktnRkFoM3VpK1kvTWswbml6UWN1NXNKbkZBZHNOVklJK1hx?=
 =?utf-8?B?dU5SSk5IaWFZSzRGTWNBQWQ4NjJSODB6Zko1cU1YeGFTT2NGZDlUd2VsMStX?=
 =?utf-8?B?SzMxQjlRKzJnUlNIOU81ZWNaVHFONFZ0cVFhcEZ2NThtSno0Mk92SSt0bVla?=
 =?utf-8?B?NlRZUDcwd1FSSkw1aWZiZlRjNFJGNEQ3ai9qbFkxeGRsMTgzMFd5T3RNZWhN?=
 =?utf-8?B?V3VqV0hvT0s1QzgwYkh5ODJ3QjQxeDcvTXZ3RlZOWW4vWVl3WndWT2dhdVd4?=
 =?utf-8?B?Ky9YRmFuNG5HdEg0V0phYzhxTU00Tjl6K0JlZ0lTNlRiTG9jbzhaaU5vTDlq?=
 =?utf-8?B?NmRVcDUwNG5uWHJqeGIxZkpCejMwck4zL2FQRlR1TzdpQW4rQUJxUm90T3dE?=
 =?utf-8?B?SWJpY2RxejZtenRWSEhOOWhXV1JqV1lBZGJoQjkxQUtza1VuMExlRVhncit4?=
 =?utf-8?B?Ni8wOVFWanJZTG9TWDlaTEFrNndwaDdBVmxkL012ZkZ0QlZObjRVV0lsMzBJ?=
 =?utf-8?B?UDE3Smt3TlhXRk1LQndPQTZHenNEVGg5M2I0WHM2NmVSbXlVZGo3endxZmhj?=
 =?utf-8?B?QkwrYmlZUHEzZ3BZTG1ROE5Yc1ZVM2hBNUlXZ0t6bnJDUGVmRE5SekFjeG9X?=
 =?utf-8?B?U0F3NFIwT053NXI0cTl1dC96dzZ5Y1AxUjlVZGUycW15bkx3b1VjUFNBakMy?=
 =?utf-8?B?VlhxSkFaMGZmakRuWisrV3dBSDQrNWlqaktna09iV3BJdUdGWmoxMGsvQ3p3?=
 =?utf-8?B?ZWdwQkVWOEJHbUJmYW1YWnpGd0crb05sOTNjaDVSM2dwOVNnMGRhbFVnemZx?=
 =?utf-8?B?VCtaR2paZlJrajlwZm9jQ2pmSXhlQjhIOHNwc2ozMEg4VVR2R1JUWG1DVDBW?=
 =?utf-8?B?REFFNENpZzdEKzlZSHpuWEN2RjFiZmxXcm5SVlZJdkdNUHFNUytwUUtxQkdB?=
 =?utf-8?B?eENqSTVHSm9Yc2IrNTU0MTRnZDhuYlh1TDlnUS9uZ2RCQ3JsbTQxQ0REL0Jm?=
 =?utf-8?B?YlBTTXJQdWhFMUR4VFJwSW1XM3owdlN4RGZMYU5jbTY1TnBLUmZQMmloUllm?=
 =?utf-8?B?K09KZWs0STlCMGFLaWtMTzJtK3ZULzFOYVFJOXRHcGY3T1ovVlFzL0dzNDU3?=
 =?utf-8?B?U05CUk1kenhxODk2bzdtaXNKaW5SK2FwUGJUTjI1dXZjc2UvdnlQRDJSb1NZ?=
 =?utf-8?B?Rml5dCsyakUzZXcvLzVVNnVSbDVya2tvUm4xYjY4RmlsZmNMR3dUTUVlb2lr?=
 =?utf-8?B?T0ZwUlFsMEN5QXBZODdPaVl3Wm5WS0ZUSnU0cGpJQmNwaW4rRGVkV29ySWl4?=
 =?utf-8?B?MmxLWkxsQ25UL2ZFTmR5RWNFUU84bzhTZ2FSMnE2dUhYcWpRL0JXRzZzdnRC?=
 =?utf-8?Q?WGC18KdNZgwJGljaABH8ug3s/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22c4bc9-0c1b-4b1c-9f59-08dbaee54dcb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:26:48.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9pUM35nLHhdGaAIvJ8TPQfgPYuDt2/leOASMmsgey31KJrg8RwC4FpfqeQTozbe4n73sfGP/EbULWPe7TLgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5516
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
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 5af235202513..2d51531a1f2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -31,6 +31,7 @@
>   #include "amdgpu_ucode.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_gem.h"
> +#include "amdgpu_reset.h"
>   
>   #include "gmc/gmc_8_1_d.h"
>   #include "gmc/gmc_8_1_sh_mask.h"
> @@ -616,25 +617,24 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
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

Same comment as previous patch, first vmid match vs last vmid match, is 
that intended logic change ?

- Shashank

>   	}
>   
> +	WREG32(mmVM_INVALIDATE_REQUEST, mask);
> +	RREG32(mmVM_INVALIDATE_RESPONSE);
> +	up_read(&adev->reset_domain->sem);
>   	return 0;
> -
>   }
>   
>   /*
