Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA7FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 11:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB2D6EB65;
	Thu, 25 Nov 2021 11:41:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246636EB65
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 11:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYI4rCamHxRlGpE+ZPTMt6DlJpAFCDW6PfB86S2BbE6AlM39X9+ESktquu/VvNYUjNozvip25CBtxVG4vSL2PSd0T9AqzhZ8pEVCShdv9+4TAePbS7rrlJV7qSZDGEKkWRshQc6NU+V9Zee9+AKIe4sPoyQ1KnZKx5MzffpCjue3lOv1NXSU2rhTn3dKdLqmmQfApPsNjJlsJWhYnTdYO6VDRGlOwYQfaTQgwJ5xVvpcP2KGsPZY7XAJF59vb/0x1zEypnuDJw/7T/+CclqUrYQ63RCwIAaBYHIBaMPSMihQTakvMtp8MSY0UbEOQovV0L7LT1FJGIHBOUrRS3rLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owy8KI2NdxdrOFHjzxFcTwaIb6bCCekGQrD+0GDU0r4=;
 b=looID04MLmVI3iM9EA3K8nPWJ7Bzcq9iZ4pCFAHSvc+ZWSlbyUYzXvKw6nXiBUdiwszJQFgIoar88QgzD7mBUL8AmFaZv145R80/ea9kTMlzliXsuH/w9Atr/RW26S1U5xF6llIgFSOeDd94euRfarT9safq1/yjDTShcuZTjv9SBo5We3FFa/sYgY20R3+7FGApKSHOBl2Jci0dW2HY0KcQ8SB0TisyxaC4KjvVn/86JthRx4Z6Hm2ULXOitJ3TBWojj38aHXvRpyzZjeMaC8aWk07UVQXegJDn00vyFCvn8OaPLOdU8c1Nl4T0mRwQ0ma324bqHhTKUsq8Y5YmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owy8KI2NdxdrOFHjzxFcTwaIb6bCCekGQrD+0GDU0r4=;
 b=xDhwUwca8T94xiJU92B7gXw5XZiGcCeZoVnvDzVTG7pK43UGRtju6DHgEwQZl2bKczvv/7xKalC0mk988HjBEGkP39vEncpzX3yAv+Xmr40QMTJvsjR4zXESlpOY0phWH5EcmFW4g20TMdf7LFujmJ9D+A+xo95odd/IwXrP190=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 11:41:26 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 11:41:26 +0000
Message-ID: <931f1390-1522-2091-9002-8206cbf8b8fa@amd.com>
Date: Thu, 25 Nov 2021 17:11:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/9] drm/amdgpu:Define the unified ras function pointers
 of each IP block
Content-Language: en-US
To: yipechai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211125105701.15860-1-YiPeng.Chai@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211125105701.15860-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0012.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:41:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb86b563-9b28-4498-ba73-08d9b0088373
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2490F1BE8ED713720F3C4DD297629@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wy2KJygZu61MzbZkUuvlUHkCznuJgJvJqyTqsdLZnu7wHJtQiWeqJKZhwDyhCfI+VkNVIB4olbQNkkvcGQ8NcHo3x7CAuNUC+V9DQtUpjejL5tL/OV28niyvyXJaha5cF0o7LVpoXMbZf2wtVHPqtOwHeu2OfEygn2qrzIaRn3QjauTl+N8lYoOYh0Eh/UReMOHgyM82t+YOV1egy5kYJgFmv7jSyVk4Trk/ES71pD8c8Iv9dCzLJWS/xqbbH3zIk4/Cz5Xi+W3U75sQ48YYeq8jrm3MZWziVIwCg5B4kW4P5sz2FqG/OeQJ2eQVfb8JCVMr9UlWaF64zw7I8sBFLvvu68ufqEBvKsPDEAQzMA8lsdjonlgo0KrdflNxEFkhmYB+waWNlKZKk7JT57VJcddRxcMW4DThZoV5phg3pdzzYPlcxYTcLBPwwwWIWPIWYPHZfjiWE7aEn1TC0ZGSF1bf5sbjGOo89XOJZNUxMbut0uds0owfN725y1mfpdwmtaJN7OBU/QLBHiignDqCmwAFdLxxvw8/xlVyjYJkZ4oN0lVi83EnBqCLGHXNK7KPawLDITGcAj+1qBA9CWZyoiKLhHOdKihqW4VtuVuuQgK2zvXK3polP68DTDVCuEYK62DsvSQ0MSyd6pJh/S3yuNZyaTWMHkCgaNkWeIrfkVq/GdWqZrsBKT8lw7iuMHp8yMFX9nXFeClXp5PoNFkjJdBmtSEFyIAtNbMMZf8Z+Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(956004)(53546011)(6666004)(66476007)(66556008)(2906002)(38100700002)(31686004)(31696002)(4326008)(83380400001)(8676002)(5660300002)(36756003)(16576012)(8936002)(508600001)(26005)(186003)(316002)(66946007)(86362001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Syt5YUtrM1F5NUtPTUtXbGVUdm5VZkhER3lvN0pYWjVWV2JnYjFURksySUxy?=
 =?utf-8?B?aDA5MWM1RHMrYVp0eWkycC82NmNha282UnFKLzNxVkhKclJwTFU1c25xT3lP?=
 =?utf-8?B?d01qa2YrT3RaSmxDR2dFMGsxWG1SYlJiaHpoMGhseG45SWtOZnVwOHVtc2lo?=
 =?utf-8?B?eWNTOXRBS0NFdDVvSGF1NWdzR0QyQXBBbU15SXh0SnVMRmQycWlGc2Y4eVNq?=
 =?utf-8?B?alFUQ0UwM2VVaWpzRzFFeVRoOTRveHZtZjhUNit1WUxvenl4REZNTHFDb1Zn?=
 =?utf-8?B?WWhFdTNaZC8wdDNYVyt6cllCU1BWdzZ4emh6NDhVZ0w0VnNOV0ZVdmVrV2ZH?=
 =?utf-8?B?bGVGWTVpb0J5S0QyR2luYkJxd2lHQ085aEtCUWZmcUhKaEZ2aWVtQXduemNW?=
 =?utf-8?B?Si9mTys4TERYVDYvUTBJeWV1VUpoekFxdHRSWHByS1NFdVRVaC9aOE5wQ05G?=
 =?utf-8?B?ZG44dnJtWkJwWUxRbXBxQjJRaVBUcEZ4UFNQTW5kelN0SXhPTHBzWWN6emNk?=
 =?utf-8?B?M1EzZVVsNnk2NWpRTGRLUFpJajhLa2JZUTRpczdtMW4yMkYvY09kSXJKZkJB?=
 =?utf-8?B?NkZmcS9NWlBPbEZyYXoyZ0tMRy8zWE9KQzBDcGpUNzFyQSt3aHh1aEZPWm5Z?=
 =?utf-8?B?b0tMc21JdnlENjJZOExUWVEyU1F2NW41RHUxbkpyU3krSnhocVd3RkN0YUJN?=
 =?utf-8?B?OU1BeFVzNFRqakY0TnF5ZSt0c1dtNmZObWZ6TlNDcHE3aE1UaXplVHBxdmt5?=
 =?utf-8?B?SnFPZjE2Sml0WlVkNm5pdDFENDhocC92UjVYYTRtWkUwRUxES2l3UFQ4KzNF?=
 =?utf-8?B?Q1pRQnFKcUdRYyszL2hRMm5YK2h0V01qM0NCWmU2VE5jQnJybDJ6NzhNbnVC?=
 =?utf-8?B?d0NJTlMxRHdldXp2UTZVZXJwdGd3Nkt5b05IN3ArUXNhaElnclVtek0wbFVZ?=
 =?utf-8?B?S290ejQyR3ExRHhUQTRFeXg0bHZsTU12d0dOR2FMMk42ZnZaSFRQU3d0RjlE?=
 =?utf-8?B?NG1LVjNucWVSaVlBS1VieUZWTXJBYzg0QkRqMTRTR0Y5WmJhanlwekI1VjM3?=
 =?utf-8?B?ajVlQS9JZzc2c2lQRmVmMnhUa0NxZ0laMGNuRmQzSFBFajVLU2Z0THl0L3JY?=
 =?utf-8?B?M2FOUFl1MEhCSktDUmZXb0ZYcTlpay9VWGhSK2xHN3JHYWJlamtaL1JSckVz?=
 =?utf-8?B?cDQ0aFpuSklUVlBVTzZrS2hqTmdtRW5mTmw3UDRvdjhUUm5udjRnR3A5TzRi?=
 =?utf-8?B?QmNtUTVHZ1RPbjhvNlNYblM4WTZ5T2ZjSnRRdkJiemRtZjZCTytwTVQzaUJs?=
 =?utf-8?B?aWk4cFRmS0pmWGxBQnJBZEpEY2crdFBUQWNJK0dhSHJvYzlLUys0eFhVT1dw?=
 =?utf-8?B?MWhDTUYwMU9rakZaSjkwcjl0NjlwbFlsaTByeFplYjRwZ1UvUXpROHJXZkxZ?=
 =?utf-8?B?b2dTZitIcm5yS2FxL1ZMZEhCOThQQmNtK2wzM1g2Rm1YUDY4ekhkU3RwVkw2?=
 =?utf-8?B?NU5kNFowSS9VNWc2VjB1R3Q5U0l0NENZT3h5cGRGMFpocEVaanVoejUrZ1JC?=
 =?utf-8?B?WkF5ajJEQmthRWhCZ2FZc3Q5M3VDbmpzeEkvbVVrQU83WERnY2c5NFJvVk1U?=
 =?utf-8?B?ZkJ2TjBlTjZnMW91T0NpTFNuanhIRExDRytPdDBhSENiUHVVa3JHcUhlT3lq?=
 =?utf-8?B?MGw4NlpwZndRNnBSK0lCcFV0K3lhYUduRS9jdmVCd2ZXUExOc3dJMzg0TzZ0?=
 =?utf-8?B?TzR5Q29sa0Y4M3BHSGo4eEdkK3BGWGVRYjVUVi84b29JZjdlcHRHRHBPbHFw?=
 =?utf-8?B?RFdaNWdtWHVrNmw2QWlPUEFYamxpYlVUM3pHazdZaG45bzZPb0dERkZNSTRw?=
 =?utf-8?B?dlNxVFlRTHdDT1hjbHdmWVZNTWRsZC9MWEc0R1ZGWXRrN084bXpZcDNEbWpq?=
 =?utf-8?B?QmQwM0JvNFdXMjBpWDB5TW4xNVdRQ0pVcHlpbHozSGVXMjRQVzgrbklaRGlP?=
 =?utf-8?B?SEJHLzdaYmk3UDVYS255VFNQMkVncTdQOWpzMERzMlFRblJnSXI1bWVocnFp?=
 =?utf-8?B?QytFdUR0ak9YandHRUVXR284M29ISFc4OEpJNGhVdGV1ZHhsNDRCTHFDWmF0?=
 =?utf-8?Q?AC1I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb86b563-9b28-4498-ba73-08d9b0088373
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:41:26.5789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKlbYDhQNARPy1E3mU9F6La5ig25rAEPIe4ghzevXKERZ94kdV2cZn+nmOz3Mi8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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
Cc: yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/25/2021 4:26 PM, yipechai wrote:
> Define an unified ras function pointers for each ip block to adapt.
> 
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 36 ++++++++++++-------------
>   2 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 90f0db3b4f65..dc6c8130e2d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2739,3 +2739,23 @@ static void amdgpu_register_bad_pages_mca_notifier(void)
>           }
>   }
>   #endif
> +
> +/* check if ras is supported on block, say, sdma, gfx */
> +int amdgpu_ras_is_supported(struct amdgpu_device *adev,
> +		unsigned int block)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	if (block >= AMDGPU_RAS_BLOCK_COUNT)
> +		return 0;
> +	return ras && (adev->ras_enabled & (1 << block));
> +}
> +
> +int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
> +		schedule_work(&ras->recovery_work);
> +	return 0;
> +}

These changes look unrelated. Maybe as another patch to move from .h 
file to .c file.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index cdd0010a5389..4b7da40dd837 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -469,6 +469,19 @@ struct ras_debug_if {
>   	};
>   	int op;
>   };
> +
> +struct amdgpu_ras_block_ops {
> +	int (*ras_late_init)(struct amdgpu_device *adev);
> +	void (*ras_fini)(struct amdgpu_device *adev);
> +	int (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
> +	void  (*query_ras_error_count)(struct amdgpu_device *adev,void *ras_error_status);
> +	void (*query_ras_error_status)(struct amdgpu_device *adev);
> +	bool  (*query_ras_poison_mode)(struct amdgpu_device *adev);
> +	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
> +	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> +	void (*reset_ras_error_status)(struct amdgpu_device *adev);
> +};
> +

Generic comment - Since all the operations are consolidated under _ops, 
it makes sense to rename the <ip>_ras_funcs to <ip>_ras.

Ex: amdgpu_gfx_ras_funcs => amdgpu_gfx_ras, amdgpu_xgmi_ras_funcs => 
amdgpu_xgmi_ras and so forth.

In future, these ras blocks may have data members to keep IP specific 
ras data.

Thanks,
Lijo

>   /* work flow
>    * vbios
>    * 1: ras feature enable (enabled by default)
> @@ -486,16 +499,6 @@ struct ras_debug_if {
>   #define amdgpu_ras_get_context(adev)		((adev)->psp.ras_context.ras)
>   #define amdgpu_ras_set_context(adev, ras_con)	((adev)->psp.ras_context.ras = (ras_con))
>   
> -/* check if ras is supported on block, say, sdma, gfx */
> -static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
> -		unsigned int block)
> -{
> -	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> -
> -	if (block >= AMDGPU_RAS_BLOCK_COUNT)
> -		return 0;
> -	return ras && (adev->ras_enabled & (1 << block));
> -}
>   
>   int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
>   
> @@ -512,15 +515,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   
>   int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
>   
> -static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> -
> -	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
> -		schedule_work(&ras->recovery_work);
> -	return 0;
> -}
> -
>   static inline enum ta_ras_block
>   amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
>   	switch (block) {
> @@ -652,4 +646,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block);
>   
>   bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
>   
> +int amdgpu_ras_is_supported(struct amdgpu_device *adev,	unsigned int block);
> +
> +int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
> +
>   #endif
> 
