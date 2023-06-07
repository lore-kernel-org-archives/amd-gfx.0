Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED9C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 13:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E003610E039;
	Wed,  7 Jun 2023 13:35:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5D410E039
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 13:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fec1+ao5vo1b2KKwAwEqh1nJrw5/mnlW0x3S7GvFXlAWPw4D8wH6FbTKN49mKUnl8cPGwwix+ysyDuLuZBtkcvQZGOVxx5CbWs2VW8FSrZEMMQIAMtSOna1xdRLXg1G2ON9mwvH50Zkie1usgpv26wL7NgqNBaIveIyY+si0Irq5DSCHx6TY5bMYgj1L6cz83u0DnQ8n9df6ypBBGRW0pB8BCD1KChJaz0/fEA1InBqi4amwinzGGp5i2zaucT/Px/MlPxdHr8rUBTp5/UD9xGdZsusjo4WjHssd7N9iJbdYVdyA6WpN1mh/J2zA/XkWnIfL+v8rDQR+36E3TGjYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCQ8pnhX3/Jc2SlFqb4/f25xYYU+qgh3WgKFGkSFUUI=;
 b=kSXp1fVZW6CLFt0FxV/1/lyMOpdL3nGGJwmYRvl18dyZwX5v9xmK/IXDukvIK6WubiAB+gfAP1jPQ8ypGkktZ58eP0gc21FatYaaliaGrCaBAQ5sxZsLb6DMpp8HufSIEGPEdOagkHuzuRvg2+WL2GrksJQnTvdwFehaGkRdq+nhI8HwhFWwim2VWUFGpGOYd3iHG5KYxOP6i5uTQeTV43WTyD5DhmU0ggif+Xmg9Gwnxde3uckEzEnYA8/Rr2l24uCUsO7eMc5kqf2GdD5wm7eF82VgK/UzOuS2mOrAvIk31O4j4IRxQ7puAcn5hlzCcn+UmbwnlTwBH2Jt3GdZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCQ8pnhX3/Jc2SlFqb4/f25xYYU+qgh3WgKFGkSFUUI=;
 b=JpNMWidM3GxT1pZFvG/Ym9v98RHZQIdfQIWpV1NKzfvhOlMMerdZNtDCYWG5OO+dbd9Gr0+xHk6PQl2BL6U2cxOflviOWqKf4Dm7mjswu3Z6ARV4OtkTDHDIIE+qa3g15pcEruGagAIs6gK0w1m8xnSNtpsKt6OfBaKQKwt9tJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 13:35:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 13:35:16 +0000
Message-ID: <2b01312a-d9e0-1265-3adf-11859a291094@amd.com>
Date: Wed, 7 Jun 2023 09:35:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/07] drm/amdgpu: add option params to enforce process
 isolation between graphics and compute
Content-Language: en-US
To: Chong Li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230607105752.3905380-1-chongli2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230607105752.3905380-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ce5bc7-1caf-4b29-75e1-08db675c07b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8JKehDlFXKu0r7+Er4CRUeFOHDZAN7FCGbFpBIr8xpIW4UmpZtulSS48jzr+PjDHtjI1dPVrPxhwUcpc3B88QZuoxtueRFmhz9gH/IcbYp29CXeLgGK1urP7JydcCgEZyzWRGAkTv7yyLb29fmAU4p8eer/MIYH/B1l3ZP9b6knrb0DeYFod8iJelsevjbNfBDAeb9n/psR6WBNgYfzsnGs5bGPn1OVRwOw6U+THY5CN3jDGIdTnOusvdWn3smNmwOvQa6moAwY/Yr5MS3z2f98ndNQGYrR4cY0Jhz6djFFo06AjJIVMzGfZKc+2ipaTbhkwpNa5q3QRuH9RSUTxf6KkcxT40jvzWYdB2phbyM7V/ITplUVrC6czDl+2yqIsjmlZfURfHpG9EHd8u+X4dN8/7r5rFnsBtMvVD+UjhzkwruyFqyeqnzagAYkMKjFgRzFCG/8w8vjYfFwgdncJaeb0OTypavuWhycrvUzT2zNa4/8T4u7DzbiJ+nfeaSfenGmJNnhKuoujG4MzWlFEzsbmaWcVLNXakiMx6ZGyBRiFZi0Qvw9nMZWz75ctsDbmLbcljoorRDRjRtTdm6bbtlSZXYJFiy00W8VY+fXY9hh64lmySVaLDhq30fxdCeGHTx2U9p5gLBNHyxImOnw8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(478600001)(6486002)(2906002)(66946007)(66556008)(66476007)(44832011)(38100700002)(5660300002)(8936002)(36756003)(86362001)(8676002)(31696002)(41300700001)(4326008)(316002)(2616005)(186003)(26005)(6506007)(6512007)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNjSkdXR0ZKRElhQk1CdjR1SDBWejVpKzFzT0lacUFwaGJHM0krZDZFUWdr?=
 =?utf-8?B?L25HcXUweXFQZlNjNmtBV1o2cFVPNWZZSElMQjJOWTcxRmxIQmdXRS94NEI3?=
 =?utf-8?B?bkRrczhVcERXSUdjdlRxcGxWKzdjTUJPamVqTE5uUXdFaEIrZFd2aGRDbFRt?=
 =?utf-8?B?VElGeVlUMHNkMXZLOGNsdVdXQzY2N1NCMDdqSWJUTlZQZzdjMjNock96WUVJ?=
 =?utf-8?B?MTJObTg5NXFJTGUvYlBvTmpleG91N2d3b3pqWnRPeWxkd2VRbFR2dmZTUm1I?=
 =?utf-8?B?REQyc0VTV0pjMjVWdnhyQ3dqeEpKNU85bVMwa3RQYnNWeUNSUldFRjNOV0k4?=
 =?utf-8?B?UVJoUFNIUHJUS3labkVPL2VNMnNqa0xXOFlWd3BkM3NJNjVhdi96YnpNcmkr?=
 =?utf-8?B?NGZFNlRJN205b21tNWdMdXlqU2xTd0NDckRaMVlXRWF3VUFqbFcxYisyYUlD?=
 =?utf-8?B?bFRXY1hFYW90YzgvaVRac3piK0pqQXJXdWMwclExTkJhVmdnRGtQYkNCbThx?=
 =?utf-8?B?QjhlampBeDM1SEF0a3JjbXFQcXh2NzF5YUwvYUVOVG5mZitRN1UwWmxWelhW?=
 =?utf-8?B?RjRoMG81aUZlWXVKSmtBd0JpbmtYZ3pRNlJjTUpWVDJLWEEwTFhXSHJUaWpE?=
 =?utf-8?B?R3dlck5oUlYycGxlN0VYY0JIYXlVTTFPQjR3akVWYTllNTJBTGw0SzA0NlFY?=
 =?utf-8?B?QUVVOVNUb056VmNzNWxFV1pNdjkxcXd5UzlNQktzMjVUS1hDc3hhZzdSNmxQ?=
 =?utf-8?B?VzhtemNxTlVNYWYwVW5UUUYzQUJ5cXFEMSs5WjN5a0UyeHUrSnpvYkJLNnla?=
 =?utf-8?B?cEN5RkJPRFpkTGNFQlY0MVZKMlM1bEFVRHZ3TnA4TlI2enYxd0FmTlFSbXZL?=
 =?utf-8?B?YlJ2VmZoTzVtajh6QU1UZ2Z5SklTU1lSSXp5R2RQc3R4VW1nZ3pZYWdySEJU?=
 =?utf-8?B?VVZsYzBuZkJ3UkdQNExPZm8wVnRIbXdERzMwVnRhUERLQVExU3BXVU5SNm5C?=
 =?utf-8?B?bW8wVEVkNS9jWVlrR0tKazcrcWZjNHVsd2E0dFpGVkdXMDgxOFJPVGh2bDE4?=
 =?utf-8?B?SGpITFRYaUxoK2RqRlNlTVhCZGVpS21sallQL3JWa0VNdDVOWW0wN0w3ZUpv?=
 =?utf-8?B?MnBwZ2MvN3ltVmROUUlLTEVYQTYxcCtnVkZ1MTE2NUNUQ01IZEw2YVYrS1FL?=
 =?utf-8?B?Vk9oMnhDeVFZN0hRZDl6U3praXV2d1dCZUtkVndVanFMUzk3L3RVdU16Yitp?=
 =?utf-8?B?Z3didXV4eDc4LzhBSldTNkQ4VnU1UjRRdlFKVldIT2d5V2c2UkJVejgvWHQx?=
 =?utf-8?B?RTVKK1pvOEhIcUJsVlZEaDZwS3FtZEo4ODdqaEMzZ2lWTTlyRSsvMGJMK2ZW?=
 =?utf-8?B?VkRPNHhsT3JscC9nSjZDQ3lXMmdUZ1NUekZmdXFUaklpdXNrVVphVllhRi92?=
 =?utf-8?B?K2NPSHFWWGN2QjFYOHdnTTVpU0tqVzZXSTdXcGtoTDBtd2NVQi9QUHA5Y1hn?=
 =?utf-8?B?ZW40bDFmeUU1Z1ZXTW10M3lhb0RqQ0FOMnhQMW9wSCs4TDR1alY2QVRWNXI5?=
 =?utf-8?B?dGFZaGo2Wnk2WUF4d2wxeGZOMDZEZHk4VEY0UE8vbGdzQTdQVC8zbFVUZ1Y2?=
 =?utf-8?B?RG9aajB3dFhuTmNRdGdtZERrMGVFc2h3RmRkemxuTml0bFpXS2xQcE12VkhT?=
 =?utf-8?B?aU1GdU9VdWxkaGlYMHVTZW5yQzR1M2xDbVZUbmJrQVJ1MXRHTDVSM2UyMmxG?=
 =?utf-8?B?VnMyN3BqSHg5YXFYRUc5a3BreEVLK2dadFZwVm85Uy96M05jc3ZxM1VDOWl2?=
 =?utf-8?B?NnppMmVQbzNkRHJhT08yQk5XU0RCWk5LZ0Z5aFh0WThvdHlIQ2wxTzJUM3Nt?=
 =?utf-8?B?ZjNLQmZ1RE5Pb3ArczBjNnQ5aXhsckdsMng2S2JQZDhWRktXRlR1M0VRVkpk?=
 =?utf-8?B?MEhkNXdFcnZSSmRHSUViTmxNakFNY3VUT2dLUlZJZVNkNHQ3cHZ4R0RJQklP?=
 =?utf-8?B?a2p0aGpsRjJ4T25EeWZOMEhxY0ZzeStsNU9RdHZTWjVTWS9HYllkY3hGUGFM?=
 =?utf-8?B?TkRHdHZCcGRCVU03M044WjI0dlpFdVpLWU5rdUFwSTYvb1dtQjNFL2Ixbytl?=
 =?utf-8?Q?ynGJl+9OxIpZVxVTvijLcnj69?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce5bc7-1caf-4b29-75e1-08db675c07b4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:35:16.9200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiTBamcsx5/HUDxLg2jUf0rTDeLsVqnvgER9BRDQwhl10+ZU7VqKFJxjuo4PvkGfFKNfaXzvapxixh9UNRjB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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
Cc: christian.koenig@amd.com, zhengyin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I can't see the other patches in this series, so I'm missing some 
context. I don't understand what "process isolation between graphics and 
compute" means here. It seems to be unrelated to KFD compute. This patch 
seems to be mostly about handling of reserved VMIDs. Maybe you're trying 
to avoid running Vulcan graphics and compute concurrently? But this does 
not prevent concurrency with KFD compute.

Can you clarify what this is for?

Thanks,
   Felix


Am 2023-06-07 um 06:57 schrieb Chong Li:
> enforce process isolation between graphics and compute via using the same reserved vmid.
>
> v2: remove params "struct amdgpu_vm *vm" from
>      amdgpu_vmid_alloc_reserved and amdgpu_vmid_free_reserved.
>
> Signed-off-by: Chong Li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 17 +++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 22 +++++++++++++++++-----
>   5 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ce196badf42d..ef098a7287d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -215,6 +215,7 @@ extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
>   extern int amdgpu_use_xgmi_p2p;
>   extern int amdgpu_mtype_local;
> +extern bool enforce_isolation;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3d91e123f9bd..fdb6fb8229ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -153,7 +153,7 @@ uint amdgpu_pg_mask = 0xffffffff;
>   uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
> -
> +bool enforce_isolation;
>   /*
>    * OverDrive(bit 14) disabled by default
>    * GFX DCS(bit 19) disabled by default
> @@ -973,6 +973,14 @@ MODULE_PARM_DESC(
>   						4 = AMDGPU_CPX_PARTITION_MODE)");
>   module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>   
> +
> +/**
> + * DOC: enforce_isolation (bool)
> + * enforce process isolation between graphics and compute via using the same reserved vmid.
> + */
> +module_param(enforce_isolation, bool, 0444);
> +MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index c991ca0b7a1c..ff1ea99292fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -409,7 +409,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   	if (r || !idle)
>   		goto error;
>   
> -	if (vm->reserved_vmid[vmhub]) {
> +	if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)))) {
>   		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
>   		if (r || !id)
>   			goto error;
> @@ -460,14 +460,11 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   }
>   
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
>   			       unsigned vmhub)
>   {
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   
>   	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[vmhub])
> -		goto unlock;
>   
>   	++id_mgr->reserved_use_count;
>   	if (!id_mgr->reserved) {
> @@ -479,27 +476,23 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
>   		list_del_init(&id->list);
>   		id_mgr->reserved = id;
>   	}
> -	vm->reserved_vmid[vmhub] = true;
>   
> -unlock:
>   	mutex_unlock(&id_mgr->lock);
>   	return 0;
>   }
>   
>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
>   			       unsigned vmhub)
>   {
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   
>   	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[vmhub] &&
> -	    !--id_mgr->reserved_use_count) {
> +	if (!--id_mgr->reserved_use_count) {
>   		/* give the reserved ID back to normal round robin */
>   		list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
>   		id_mgr->reserved = NULL;
>   	}
> -	vm->reserved_vmid[vmhub] = false;
> +
>   	mutex_unlock(&id_mgr->lock);
>   }
>   
> @@ -578,6 +571,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>   		}
>   	}
> +	/* alloc a default reserved vmid to enforce isolation */
> +	if (enforce_isolation)
> +		amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
> +
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index d1cc09b45da4..68add23dc87c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -79,11 +79,9 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>   			       struct amdgpu_vmid *id);
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
> -			       unsigned vmhub);
> +					unsigned vmhub);
>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
> -			       unsigned vmhub);
> +					unsigned vmhub);
>   int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   		     struct amdgpu_job *job, struct dma_fence **fence);
>   void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea3d0be152fc..73900ab545c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2358,8 +2358,14 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	dma_fence_put(vm->last_update);
> -	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
> -		amdgpu_vmid_free_reserved(adev, vm, i);
> +
> +	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +		if (vm->reserved_vmid[i]) {
> +			amdgpu_vmid_free_reserved(adev, i);
> +			vm->reserved_vmid[i] = false;
> +		}
> +	}
> +
>   }
>   
>   /**
> @@ -2447,13 +2453,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	switch (args->in.op) {
>   	case AMDGPU_VM_OP_RESERVE_VMID:
>   		/* We only have requirement to reserve vmid from gfxhub */
> -		r = amdgpu_vmid_alloc_reserved(adev, &fpriv->vm,
> -					       AMDGPU_GFXHUB(0));
> +		if (!fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
> +			r = amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
> +			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = true;
> +		}
> +
>   		if (r)
>   			return r;
>   		break;
>   	case AMDGPU_VM_OP_UNRESERVE_VMID:
> -		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB(0));
> +		if (fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
> +			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(0));
> +			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = false;
> +		}
>   		break;
>   	default:
>   		return -EINVAL;
