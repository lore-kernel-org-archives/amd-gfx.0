Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C4FEEB570
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 20:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF2010E950;
	Fri,  8 Sep 2023 20:44:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E519610E950
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 20:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+jPH7Aeqv9mdpsaxf0XcqTcMesEbmDpr9i5wu8lRH3LViXGTjkCqf4SKtqOErMmJTrlICu7ch2e3uOCc3HFgpd5X/2AC6KaNdkPfkFXWWiHfwxmcK+83CEIWapb8JtIwcTIH3n1iqCISlNnAxun017H4LamFbmgsRejGdRUJKENdZtc9pMaY71fTPf+uYCNuhi2S2oy3LD0x8INSmvam9Od77rBFLsrACPhM72XajmeuuIQDor4ywVRuVAQAE2FrgnU7jSpwYQNyGxzp3+UYzqt+qTsxIAKw0TARBCFNXnHrqYsXMyThHIz5NpHZBdpBwzfo8dS7/pLr2aZwgE4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk7gVDFADDNLcYnQOnmklmHsDXgvuLT3oOfwwTrAE7k=;
 b=kAbdZkt1SFoop8jZzhLeEyJqsYgvcu3o6FR23XqwmVD/LU0ynxzaqBS47ozubYQefFRro0ZkBAKZwyfCLPWXtEE0HtX+SBxhIquFjMGMZlbgIH68b5SwAFohKUJnUBzczZJmd3XXWPySDxzbylhf9WHfUuqizP7A1Vu4JpU/jPq5U1xitM0e7StxnjbVSjm0rl3qmTejVmxCvZc59+I6uEFrhwW6B0GYrYjG0x06Dp01P2aD7DD0pwzazNHK87GlTGhWyP+g7VS2OH5Ds6FfNRTG+JQE5IQ53KEavx4fUogNWB6NYKzPlr7emmjJ0N4Cz1GQKTnNfUAZMn1Mf9xO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk7gVDFADDNLcYnQOnmklmHsDXgvuLT3oOfwwTrAE7k=;
 b=03CxxYFG86a/gIbfI/1pNNjFokCfGK4bAxxUDLOcrdOYjQXi9FWRlU8hidUfGDw8bsygofYug7jxiLKdT265qkpelDZ1WWftT8DF/lN1KHcUX+RScm+RbE2vyE+mEUzNs6jRGtdWDXVBO6Qp6ajwfiugs7NvDkKi4QLxernbvHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 20:44:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:44:39 +0000
Message-ID: <690e33cb-d26f-316f-728c-586512db6843@amd.com>
Date: Fri, 8 Sep 2023 16:44:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/11] drm/amdgpu: fix and cleanup
 gmc_v8_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-6-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230905060415.1400-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 617c57ea-35ff-41a9-404b-08dbb0ac6bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxRnDz2q64RfXWJUK0OwtKAWfJf6MLh8u0yY1y2BlXIu1jt/2zSvjztQk90Yt0ADG3B5qAvh2UUK/EoyeFgDaIoCaIn0tdjqKnmXxlhn8SCE3mpQN73GL6z7mHpeee89BpPlQm+9DG6EUTDrufZnXhcrnCzn5NHIGmjDUYK6K3CV0SZsF6VS2t7a6cO154j61TnnfLfBFfhzLwsebeesI4G1AyS2wbmpShpbQMsXa6BRsLS1kxslj+anjtXeDyPXCn4bl9T4i54KsiemL69YCF0WrSeXOU7jZcmEYhN6WB1+ISgQGVYIY7+hs0+1jmp3IzgxJV3bOkw4LpbX69Lhg7Q8xQ30H7fXBc2rZjY52+YLxaZ/tUL6GjCFANL10YriV5vnSR48AfDHajwXW/79KpbVcLl5VS3vKXaKOgHagOmwzxKfiAnqTB3QmhgvidTBVfMmYe4lo3Ij+T9C3lTw4CKHFcRN4ZI/g8NIRcCbj88XV7DQZJpnwPgot4XeoZ6M/7dK28nuHbdCqsljtyvOLu5H7g9UMQtrvk4oVuJzOs6UALkVamS6wqsZ+ZJIsLAldDkqW8DuB6CJAMkxABy17f7gsEb6IhCYowvoLs5Il9psfs3pmOi9JzTq+0XMabmVhQdgiVbDcmy6Ymx7PfOgVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(6506007)(36756003)(31686004)(8936002)(66476007)(31696002)(38100700002)(5660300002)(86362001)(83380400001)(44832011)(2906002)(8676002)(41300700001)(2616005)(66574015)(478600001)(6916009)(36916002)(316002)(6486002)(66946007)(53546011)(6512007)(26005)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmFMZnZ4dEVETzRaOFZSZFN6ckVqRlZuaWR4WE01b2JldmlzWU9TalZvQXgx?=
 =?utf-8?B?NzdvdDJwcU9TVFRYWVlOUGtESS9zOHZOczBEN1NUdDRBTlFQamRFQ25odHl6?=
 =?utf-8?B?LzN3OTM4Z1BVOEtqRjZ2OVZHNHpURis3d3hoTi95MWZybXBIczZ5aitacmhB?=
 =?utf-8?B?cTZ2MEM2SU91bnlzRStuaEswdndtUWc5MFM0TERFVExIdUFicXBGTjU3eDND?=
 =?utf-8?B?U1dIa1hBdWZHRGtZcVg0S0ZuSFhBT1lIWUd2dkhwaFRUVzY0cHBOdjI1V2Vn?=
 =?utf-8?B?dHRwZDdmSUhKTTdpY2tjNjVqd3k1aFZ2Si9KOHY2Y3c5ZFFWd0JwejdkN2I0?=
 =?utf-8?B?SjdDYzBXcEU2YU94NDJSQ2gwZllVMlNlUC93VnluZEtMNk1KSStZckwvUFJJ?=
 =?utf-8?B?R3hDY2NoK0hwYjMzYTNPbnJvRnRRaEQwc1NCNHlzdTByZFNHWmZvVmd2ZDJh?=
 =?utf-8?B?QjZrNytLV3U2OVJvTFJ0MllUaU5YT2lxaXVBenhTQ0hRVkszRmJESGY1Q1lq?=
 =?utf-8?B?dXRrZWNDS25TaFE2UWxkSExWNzZLL2ZrV2dxZEdWejZuSllYV0ZyWFR3cDBo?=
 =?utf-8?B?dTNJTERwQkZ5OFBLZHRJYTczbjJVcWZFN0pqQ01GcE9pSUlMMFBtbWRvNUZs?=
 =?utf-8?B?MFNORm5CNGlXcGdvbXQwYzA3S21veUc0WFFIdG4xQVJZbVJtT1RsbXVKM05G?=
 =?utf-8?B?dHZ1Wi9adER6cnhNZ2JEM1hSVHkxWTBZRXZaT0N4elNCL2picU1xWHdBMVJn?=
 =?utf-8?B?dEd5Y1dLSTBWaW96ZVdMUi96ZWFhZGp6enlXSzdjVFhkUVNvaEZvRmhHU2wx?=
 =?utf-8?B?YTFZcnJLdkc3OG52Y0sxUW5wL1liQUxvVEZ2NGdzeENKN0hZNVl5TkNhY1d4?=
 =?utf-8?B?TU1BQ0xSTit0dTBXUVpkRTdkcDVIVEY1T2N1M1RKangvcER6bUFYSFZoNUlY?=
 =?utf-8?B?cHN4WFBOVzNJK3F3T1N4WVB4UEpLcUkxMWEzVWR3d3ZzRFZOdkFVSzhYN2Yx?=
 =?utf-8?B?ZnFSc1N4azBLdGdBRE9iTDdCTlFuaW1ZQ0ptNktpamx1amllTStMdHJRK1d2?=
 =?utf-8?B?aVd2TjVWQmE3aWV3bEhJZnlqNmk5MkJaR08xNC9XeTErNmJHQkhDQktoU3pt?=
 =?utf-8?B?K3NNV1lMNXRUZHB5MldXU0VTS3Vvcm9vZ2s0bUEzenNsSGt0UDF1bkhIYzlU?=
 =?utf-8?B?eTdBT2hia3VxdGlCWjhyZGNobEFlQ2FEQkxCcVdlbTAyS2dneU91M0NnK2hY?=
 =?utf-8?B?VTJZanQ4VTZxR21VaHdyNlFYUGFrb3A0cVhmazlubGNBQ1JSRkRhdkNvV2R6?=
 =?utf-8?B?VjBESHZnSUlITEsvVkg0QkdKR3E1eXlzMUNVZHJ3ZHVLS2xNV0FyTkIyMWg0?=
 =?utf-8?B?VEF4OWo0bHh4QW5OT3VGVUNsNUcwTzQ5ekxWWU9mNmwvSUZQYy9nMXc0MWlt?=
 =?utf-8?B?cHo3cDRPOVBuNXFMYWdhRFg1N1k2a0dLRFdneFpyM1Bna1FFOEd0dDB4LzUr?=
 =?utf-8?B?cGMxc29oRzJ2Z2YrSjRJNTE1M0tJWW04Rm1LNEVsZUNOMGs1Mk9ZMDllNkZN?=
 =?utf-8?B?QzRuVWRTaE93b0ozQWUxWEtaL0N5NHhJVllramdoSk1SN2theWtzaUxJaDJS?=
 =?utf-8?B?U09LQ2JUR3NQa05mYkQ2aS8vMmpFa2I4My9YM0x0MGRrZjNJVGE4UWRucXMx?=
 =?utf-8?B?Nk41ZEpETDZ4YjFqeXhtNTM2VnB5eXlhdFBjZy93OEtyR3BUK0tGaU45dVd3?=
 =?utf-8?B?MVdHc2FHL0E4aEY1RHlvLzhnQ1hNS3RVZU5HSlhNK0xQZ1JQY0oxU011amFB?=
 =?utf-8?B?QmZ1NUoydTFwcVVONDl4QXdDM3FlT3BYb1l0QllUcU9EV3VBMHNmVjhrVGww?=
 =?utf-8?B?SEdQbTdySE9jODZZOVdMYzRvYkpHYlJLOGdrOHRCZE1rMWIraFJzOWJyRDUx?=
 =?utf-8?B?UG1wSTJ1R1JuandnTVVybFZjQTNEd2RjVml1K05BNzNsRkFQQUJwUTAwVVZq?=
 =?utf-8?B?RE45OUZoUEZ5elZ4dVp5d2IveFdZblc5Zk9Ca1dHRFFENVdlaEplMXFsNjEr?=
 =?utf-8?B?MTRkSmwyWmQxbWtYZFdoWG9wSGJNS2VHbjhIMnJCWTRPSVRoMXlPbVlwcTAw?=
 =?utf-8?Q?cfrWC16RjZcBabjlxhWdykian?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617c57ea-35ff-41a9-404b-08dbb0ac6bab
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:44:39.1536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYmrmxtVxXFl0cnElIkuoUMujuFSmZYHUqCzF1M2l0/zd3p+gi9ORl6ymZH8OIPoiFw74G6Stvcji2MLDw3bfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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


On 2023-09-05 02:04, Christian König wrote:
> Testing for reset is pointless since the reset can start right after the
> test. Grab the reset semaphore instead.
>
> The same PASID can be used by more than once VMID, build a mask of VMIDs
> to reset instead of just restting the first one.

I think you mean "VMIDs to invalidate", not "VMIDs to reset". With that 
fixed, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


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
