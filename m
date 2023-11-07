Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFAAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 22:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C996110E545;
	Tue,  7 Nov 2023 22:11:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB12910E545
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 22:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDWdBBZXH+CzyJwd9l/jE15WkjxV2jjl0WWlnbDzdymJ78//OJxsUqfln0qA0rAyCC0eqseKJNTaKsvQSQHcBWDRFqmlZqSziN9GlALgupjwiuFzvnG0M80EpPJVnLOMqBabN1IztxPty010e1Ne0xDThuCJoFTmhBY/61Rvp2YB4FwIGXxaJBSPM6y0G3BjlcTqhXjsYsAFGFt2m8Txst2gZy1rBKkKHJKkTTyFT0jOWX2jMohmW2MVKyzBkGdSYonZFmLotUX6NLhHkdeG/v8L9r/xE6R25apcOJwNjt6DVo+CmiTS49i5nW3l51ipJ9isqFiSCsNZ3EM1PlZIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3w0SLmfVCjfqd/tc/NypKu785qZ5zaeAbB6x7TaBE4=;
 b=ftXJOoVwrVju2h/ArZrDBrrNjA3UCx8jGlUfpJTfi3iVMrhdLnXZCNk78kqs0j+pM05rNegKY6adVjkhH4YmoToeyZ3wqZkUbxNCCAgzOaPNP2Zl/VXdcnGnPlI4owTXK3CcqmeMCX9QfhAKiNEp6xyqdP+IUiunZ2WGtXWmqUG++FrKexHVK866SglcQQUBCeuK887XaxEgdyyX0X/0BPdcQsEMDkhUQHPjL6IYlxJJVlna2bXdp5W6C+UdbfnaEeLtGYU3sMNp52hHAmH7vFJznxfELJZ0/AcheiAsrCp3tfJGe1AnFDyZ5ZDDfrijErGpzjAkg+SlR1SRQ1F1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3w0SLmfVCjfqd/tc/NypKu785qZ5zaeAbB6x7TaBE4=;
 b=Y+XHPhkde34qwrXD2D6+mwKxQjtjChILUpLR8gtwcptQyft/8EHvElOKv5yBcHT5vuZwZIebhEJ34JJlm3+0Q0I0jig+aSL/mU23qF6+j9BtcUb7/Ht9F4C2KU8Y5JXmzBzPuaRZp0SzTw1mfA+jBFVLk0A/g6mUguT5B0tNIQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:11:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::19c3:4a94:9ddf:35aa%3]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:11:51 +0000
Message-ID: <8b63ff39-b1f2-4dc5-970c-29d96c63b18b@amd.com>
Date: Tue, 7 Nov 2023 17:11:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: New VM state for evicted user BOs
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-2-Felix.Kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231107165814.3628510-2-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 433a6144-143c-4f39-be98-08dbdfde8b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTYJWt4iWLXkrozY/LvUDY31P7cd5CfwY//Dvvk6Tv8myeifBYfs3LIYrcljnEoddPKYarh/dhghMj0tgKrsYvoAlia2EFXsvX9Qj3wGGMSo+9HyxpN6t08Jf2Mg/5CGJOLEu/79nV92M6yo4hdRmlsPKQHqWhjcV8qHDFdWtAXmtO2HHp41dAjMrnAwT6jJ7A6XZRuCZ+YU1QA9A1WIkocjZq57Jz0IMgbDqnp3F1B49qg7I9VXtIJYilcdX2Dmg3/ovAJXb7as08FLjtDnPPCf55p1BdvftZtz/2T/4kMzsX8Pjwh9WZetxm1OutuRwCSFvdRUFjeRsElGbVOn88Kl6/Fud24tFoO/8Lxiqh7/++UCy2PrZu5lgQE7MXUGUN5Nhmy725kW7/RNYDel1wNj2WMld8W9q6lgRfuQczparXyg/8qTYaIOOgwjw4BR9yLXV+7M/D8JMCy0h4+HWlbTxnstNWRO+LZKzHhiM1YEiFLu1BdOSkzfur/zUPw/SvafBA20pNhWYkJqLJkbyvYWBDZUZCkNuqRy4SmcCqRA49hT8VSh9R67BZwMP/OeAhRGiWkKgCP5FtrYemcBu/eyBQGCdVVTlInSEu563JgWd59jQidZCxSlYS9/IYqCaX/9P49/jq8H18qPSu/KiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6506007)(36916002)(53546011)(83380400001)(31686004)(6512007)(2616005)(86362001)(316002)(2906002)(41300700001)(4326008)(36756003)(5660300002)(31696002)(8676002)(8936002)(66946007)(44832011)(6916009)(66556008)(66476007)(26005)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjVxblZuUEVZMGo3Z3laMlVENGhRclJWVlhCRnk1eFhRVXNpZW0wdUNydFZ3?=
 =?utf-8?B?N0dmNW0xVkpQcjQwcmZYVCttV2VVQ1JjeVFYRVdDQzl5UXhxaVU0Y0l2MTU0?=
 =?utf-8?B?V0RWYnlXL282T1U2RWJ2cEMrV0F5ZlVhOVhxZklHeEpoTXJMOUtkU1hsNUV4?=
 =?utf-8?B?ZVFFbXNqNWJlY1Z3MlNjcUpDT2VNTGhoTE5zV21QZ2VZTXFtNUpKZmgvMUVH?=
 =?utf-8?B?QVVabDNaMHpXUlQ3Mmkrbm84c282UEl3SGhCdHFwcWNCWFVyTWtpZ2cvWmEw?=
 =?utf-8?B?cG9ySWI0UmVCcndQMysrSHJORXF0dDRCQXVabWRIOWZvWDhSZHhaaEdMNFFW?=
 =?utf-8?B?WU1GZkVMQXVCaHFSck85SGR6ZEZ5SzhsMzMzekRyU2pUZTRDNGRuUTd4Mlo4?=
 =?utf-8?B?SU11MXlHSmI1d2o5c1dWYnBiRndUdnZod2pxdmFSMWtTTk5jVStTdDFiazRm?=
 =?utf-8?B?R2ZRbXN3cHFTOEVRWGZUVGFMeWNpY3Zadk9QVWs3czdzUEtlellmMkkvU2Mw?=
 =?utf-8?B?N0Z3eUJxZjJIbWw5c0gvd2krR1RSNFNYTkdJbFB5d095ZytuOVRhaVZWbkRP?=
 =?utf-8?B?dGpacENLcmNhSUJwZ1ova3lucVdyck1uRWxCMHpOR0RiMVpSY2FFV014QTZ0?=
 =?utf-8?B?OElLWGxmTk9TaFhOYk9xbEZRemRQakFPek9rSWNSWHhyb3I5Y1djNlR4YXM1?=
 =?utf-8?B?UU9wT2g0dUh4WlltTVZvKytNRGtHZitCRFNEbFd2dEdjdC8veTY3Q0tkRWdL?=
 =?utf-8?B?Q0U3T3VTdWkvMG9FQWJGcVVLUEQ4TStqaUljams2UXUyS0RwMHFiLzBsdDAw?=
 =?utf-8?B?ZU1EcUZOMGpwTThDeU5hYVgwelEzR0M1dnRaN3ZOWFhKNjdKTUN6OWVMNUJk?=
 =?utf-8?B?VlFhdFYxdThLUVNISjRydGp4QTNtVW0rbGFnU3ZiWllKblh1bkZmRG9aMk5S?=
 =?utf-8?B?TjBCODJKTndKUWk0NXZqQXMwbVRwL3RieWhjLzVrY29kbDB2Z1lDcGh3Wm1Z?=
 =?utf-8?B?Ky9wdlkyRmorQkxFR2R6bTJvdkg2YmpwY21CbFJ3bWFXQ1EzL0dhU2hMUWQy?=
 =?utf-8?B?TUc3WkZPeVZyYUNENzFhMTkwLzZaR1J5ZmRHVmp2SWwvT2tFczYrYkxCOXBZ?=
 =?utf-8?B?ZGNGWXRTSjJEVlJzdmR3OG8zK3NRQlZ2V0VjYW44OTgzenlvUUdQS2NpaVh3?=
 =?utf-8?B?WnZLcEVuR3JxSEtENS9SMElNaXF0TjkyelJHNXZZMDZoVEt5V1NNU1ZJUDNV?=
 =?utf-8?B?WXAyM3dnWEpMREVFMUhJREQ1bG9OelZ1UWphSVZUZGU1TFQvTGZ2S0NvV1BD?=
 =?utf-8?B?MEJvcHg0bmVmN1kwdWhDci81V24rQ1FXbDFDSEFKRk5ISHZTWjhiMkEySFdI?=
 =?utf-8?B?WXEzdEJvMXpsT0IrZm1janc1RVlLMnJ2YWVVa3FXUXpFWm5sekpsZlBVZmd2?=
 =?utf-8?B?UFdQNEd3TWxqYTJHYzBMVmI1cEtaa2FWZlAxVUh6ZDIvZHk5c2xFYzUzaXY1?=
 =?utf-8?B?WHlSSXFXTnZSSU1QaFAyS3ZIQnZnK0YwdDRrSEFIeWVqa0JQNFNRT1VuOUNO?=
 =?utf-8?B?b0dhUXJNZ1hFZ0tWTmVOblgrNWdUU2JpUkRDVUZHNjYxTzBiaHVLK3MyS2d3?=
 =?utf-8?B?eEkzUXEvclR0NXVFUDBCSXQ0ZFo2RGdlNVBzS0ZYY2tUQWZGL1NFVzEvN1h1?=
 =?utf-8?B?MFZ6Y2dHS2NDdEFxR1ZiN2J5UTcxc216cUxSaS83azlRNkl1KzlSU0preEZV?=
 =?utf-8?B?ODBRd0VENXJ1TTJSak5XT2lYQkIraDh6VzRxNFo2SlBsY0p1aCtXVXdRYUl5?=
 =?utf-8?B?Y2ZkRVVSa09mYmR4WlhOOGlQbUhZTUN3RHBJZnlicHJLVkIwVWpPbzlNaDl6?=
 =?utf-8?B?ZUFTblVjQm1vOEFQOE1lOTFtQldvT2dZZ01tT0hoUVBQTGJIWlh1Qitsclg0?=
 =?utf-8?B?UmdLQjFZWlUxTDliNTNNQW16OHpDVFZ6L2ZJRkZWZmxjelVzajI5Tit0dER2?=
 =?utf-8?B?U290cU91MWJsbXY5MDM0MVFlbkpVNFk5bXhaMXlZQmNXQlp1UjJFTUdQVmx1?=
 =?utf-8?B?SDJwdkpMU3hJZlptTDZETG5FS0lOR1lORWRXdnNndENySFM0K25sL2RibEhQ?=
 =?utf-8?Q?9sOfucG0U7VXt6oIeeANSGfpP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433a6144-143c-4f39-be98-08dbdfde8b29
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:11:51.5385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yq+ARu+AH3M5JHh1QHaxYelG8SU/ybauc4ovrnYCKoFkZVAyP5sJJ3AynMkX5jO3BkcMwFFnykt+g2/v7ONt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

I know you have objected to this patch before. I still think this is the 
best solution for what I need. I can talk you through my reasoning by 
email or offline. If I can't convince you, I will need your guidance for 
a better solution.

Thanks,
   Felix


On 2023-11-07 11:58, Felix Kuehling wrote:
> Create a new VM state to track user BOs that are in the system domain.
> In the next patch this will be used do conditionally re-validate them in
> amdgpu_vm_handle_moved.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1442d97ddd0f..0d685577243c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>   	spin_unlock(&vm_bo->vm->status_lock);
>   }
>   
> +/**
> + * amdgpu_vm_bo_evicted_user - vm_bo is evicted
> + *
> + * @vm_bo: vm_bo which is evicted
> + *
> + * State for BOs used by user mode queues which are not at the location they
> + * should be.
> + */
> +static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	vm_bo->moved = true;
> +	spin_lock(&vm_bo->vm->status_lock);
> +	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> +	spin_unlock(&vm_bo->vm->status_lock);
> +}
> +
>   /**
>    * amdgpu_vm_bo_relocated - vm_bo is reloacted
>    *
> @@ -2110,6 +2126,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		vm->reserved_vmid[i] = NULL;
>   	INIT_LIST_HEAD(&vm->evicted);
> +	INIT_LIST_HEAD(&vm->evicted_user);
>   	INIT_LIST_HEAD(&vm->relocated);
>   	INIT_LIST_HEAD(&vm->moved);
>   	INIT_LIST_HEAD(&vm->idle);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 12cac06fa289..939d0c2219c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,9 +286,12 @@ struct amdgpu_vm {
>   	/* Lock to protect vm_bo add/del/move on all lists of vm */
>   	spinlock_t		status_lock;
>   
> -	/* BOs who needs a validation */
> +	/* Per VM and PT BOs who needs a validation */
>   	struct list_head	evicted;
>   
> +	/* BOs for user mode queues that need a validation */
> +	struct list_head	evicted_user;
> +
>   	/* PT BOs which relocated and their parent need an update */
>   	struct list_head	relocated;
>   
