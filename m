Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04855ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 09:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644FD10E8C9;
	Wed, 14 Sep 2022 09:11:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E2F10E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 09:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7ScERLENk2tNopE2znfrCAtnDlEdEQSqwINCRwe+MfGoaeUIJdnh0uxNaKj+PzrNnd5TSgjk+gmj/VHcx12AXZRmACJ+2skmOZt+bPeEDAP6wHO+CfVCf/R5H95wXkSTPriZDaW0KEz71Kbj5LpqxUWAm6qeDhftGSwu/1+ILCjf0BJ/IooZvjuwPM4hvmY0ENp4PYFGB7L2aRTw5oLCzkUDiP1hLRrPtiVqB5XnNGFbbnOBYNCdqwq7TedU2e8Mpf5BGBW2wVCPo/nAroLnQVzCZ56fR/u66CuVtCO/KoXBSdtco3WuKqUzenxGFb8d+ACZjvzv4IM09ERKf7LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3r0H/ZA2uelgbhfRWMWocsIVFuu9rk29dmHlyMDwTA=;
 b=hf/953iEdpCMReJ6ln8G8EucZQdUEVPY9D3HmWqsJ9s25W6f9s7lRQOExCdUPaljgHCrUNL5D41ObQXtFYQZ3lpK89fm3i3LjbsryFryupNrK7Xm5WKfWGzyt2Fn0YoXHezBRKmtME1aRSp5YTapAENONmFz+3HPnHsxPsY8YldnEtEqUcYBjkdE9G8QLu+BQUZE7HGKN4khjTdQJPWsylrbx00EiIKKk4GdPu+TFf/J/XBRsRX+lE8W+OavOXZgLBdZ4jcRn2bHWDINA8tLJwPvS1iOfAGwQL4gG2ALv9pLRtUIjQTiFD6l4kqvKbelRmGRona2BdREtbRVXGiDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3r0H/ZA2uelgbhfRWMWocsIVFuu9rk29dmHlyMDwTA=;
 b=PoiLojcAGO7UvrjRDoysW4nIo7xR1AGmHSsX2YHgXuPJHK6bSGBBVPc+RUBFdyhwaeR6w6xBysp3LAr+ftF1AS/0ZAdPLuoHUU8hxO+MUqNm5lvHH4U3VyrmLTyA+H0FSKl6XVT9vsf6fV4yF1vg/LlCmBeu/8anZvcC8RM2cLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 09:10:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 09:10:53 +0000
Message-ID: <918a0fb0-848c-df74-f2bb-fe85953d1cb3@amd.com>
Date: Wed, 14 Sep 2022 11:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220913200507.8849-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220913200507.8849-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: a38af7b0-fb33-4254-28bc-08da9631069e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIh7utpeqb92W36WEn0a7S84Wcl6cyvWM6PSMVUA82+fyrLAfjkIvfG72Joh0ltGYip3P/tiT6nXi3jG01gZIcSeJOMo+ZzNT8PmgzqgghEdtlQbUWNH7U9xzEXB7iQj2qHVhlWr6RW2fJ1LiUuGjBf3gDQbR2bgQV9HFqWBMnMTGloj8EPlQz5/KzZPUP0OmNjuacR+DskR2XIStetYcTT2AplyGyb3ZzA+m4+SCuCQP/HIxYdVcC2ckVjt7Cp8KA5dAL2iJiOMSAizbA/YTMriWhume+rNIuHrxHBI4PEq5JtKicAZjgtKhC6jfqmBEvNNyotpukYM8GNMMI8zRHuVmWIlLK71uDIVAzAO3S42aMG25mSj9SLD1Vf8G/SUf70EvM6NzOISgad9R95u+nIKh9C2xJgtzkKzGN8FW0PSZxSZsxBUwKkzdw/BUn+tv+qH3/ipm5u6RjQW6vXD8MixAQMdh0+yzHpnztjwxXI3WD7yjHaCNR5B0gkCrPtWiqaUoM8lhwc1gj0pFgIn75pPxkjbYxizMHsgDUGgmFMr7v2ilAWy7ChHYydeR3LVpK+YBb6b12nVEe5xYktnCARXvcR0xz3Ei7skR+heEFNTNZzRI/BpUJmbNLtG1Xhmbh08rXyGTDGkRXlaC5BhQGyFc+nPlZfo85JNflRhklVXMsOm2VaSLrjVyRqAYX0A7y/RKR4pFAoWJQrSYIXxCVCq4s7PgYQI0pakuZEvEHHwIIvUhLymhbdNXtw/oZZtdABRYeXQmIpVZYDu6FPGBTYeietUIo+Cr1gBywKAit0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(186003)(6512007)(8936002)(6666004)(31696002)(478600001)(6486002)(2616005)(4326008)(38100700002)(8676002)(6506007)(31686004)(83380400001)(2906002)(5660300002)(86362001)(66556008)(316002)(66476007)(41300700001)(66946007)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURXUE5oVXAvUGIvZWJLbmd6RmZ1VFRJR0hCQUdrcHFPYUhGd2d0c2tVeURL?=
 =?utf-8?B?QWZONUNmSC9EdmFTVkZzRUo2eFBZNjA0cTZHcDNyVmk1TXNOT0hDZ21iUnU1?=
 =?utf-8?B?SlI2SFYvUzhTMm1DVm5laGM2L2pXK2x4aXdTSVpkQmN3WjFtWUtZZTlxL2pM?=
 =?utf-8?B?RmpIOGJmOFF1cFBwU0dVOEN2c2VYcnprVzEvbmZyenR5cW1pUjZma0NtMW5z?=
 =?utf-8?B?c0IweS9reHRWWGhjSUg3WC9ZQXZjcDcvelJVcGxvN2FZZVlKcWR2a3d5WTVG?=
 =?utf-8?B?WTlvOHpWQnNTYlNKUStHVGNCRkRZK0U1RlVLNlVNeHlUSU5ZbFNGaVMrdU1M?=
 =?utf-8?B?NFBwdHlrbHJ5YmluM3ZDRGV6S0Z6WWNJVS9WR3NYSjlSYVYraFdtc0ZsVzRz?=
 =?utf-8?B?alRFWnluQlpnWXRGV0ZlL2dhajVSeGxOVVhCWGErUUhWNlBHVVZLTGxBR21s?=
 =?utf-8?B?RVJtdExHc0JaYitOUmoxZFJrbDF6SkZhTEtjNkVFLzBJTHYzblRLRUVqZU9v?=
 =?utf-8?B?UW9oUllkTUtnblJwaFRSSExDTFoyWndveGlDbGRXZUNHMTZYN3c2VTIwdVFm?=
 =?utf-8?B?UEY1OEdKRHEzQ3didm43VkdvYUJpaDN2WGtORzJuQnY0bENpU0U3MnJFSkxS?=
 =?utf-8?B?cWlHbXY5WVVNNW9UZE93cjhYYzdlb2kwQ3FOVWpvUTI1RzFsVnBydlUrSEtj?=
 =?utf-8?B?NXhMY2hBektQcWRsbEZoUXNRcHB6UGxEUDNaeVNzc2kxOEo2R0o3dzhQNTIv?=
 =?utf-8?B?OEI1akdpa0hMWTJ6V3VxMWZTaTN2ZU9ML0d2ZVVrK0txN2lXV2w4TjE3ZG1N?=
 =?utf-8?B?TG5wOFBJZ1hrdWcxbHRUR3R4NWFqKzJEcHJ1ZWVBeDlvUEhtU3RuZ3NJUmFZ?=
 =?utf-8?B?azd5d0xDL21IdUFQU2FON2V1V2tiVUlFZFFpYU1jOEw2VUZ5MWdsRG9WWWFl?=
 =?utf-8?B?d2E1cW41cGk5cDBvcjhKMy9NUC8ycFl2MFJRZDAwampKblJCUVpyNnNHWW8v?=
 =?utf-8?B?VTlFQzFYdFo2UENWcmdRVUl6Zk9ILzh3VElsNWtRNGJnUmxJVVJQZEJQbnho?=
 =?utf-8?B?WnFoSTJNcDlGSjMvdldNSGNvWUFGcjFpanIxYjNjM29JRDJObCtFbHJjU1l4?=
 =?utf-8?B?SGcraFIyS2ZHMXkrdm9TOHRyenZWT2U4Z2xxNFN0RVhpN2huUGp2bFd2TjBM?=
 =?utf-8?B?dDkyK1FNOTdCWU45c3BNZjZ3M2NWZWplOVRoVDNtMTFhQTlBNU5MUUJzYUNT?=
 =?utf-8?B?aDBhZVhGMk0yWkJrSnVMQmpRUjlvaEhEQnZxRzBpMW1nd2REcGFxenpBVnEy?=
 =?utf-8?B?WXBVT09BUkpja1JOL3NrS0VaVmV5NzBPUmhvSXZRYnJFVGRWaHJrbkFXLzdx?=
 =?utf-8?B?UFF1aDZjL2o0YlNRMXJUemI2Z1dKeXJ0eDhKOTQveGo5ZkNtT0Q5cythTXVP?=
 =?utf-8?B?Um8ya1QxR0w3Vlh4SkgvYWU0TjEwMS9YR1pRalpFMjdqY0hCSnlKZVpCWG8r?=
 =?utf-8?B?cEVMZjBpYU5xanh4K0dxVUlLOVczUmRqVFhoM1lTQ25QQ252UXR1c3FPQVdi?=
 =?utf-8?B?U2VjejFLczRONzdrRW02WnhZNm1wNWdLYW9TZWlGMG5GNW95TTliMG1DeFdi?=
 =?utf-8?B?Qmh3cmRkc3E4OVFSckU1OTNHNE9iWUdQVitMZFpYVFFrN3UrWG9nMXVlUEpt?=
 =?utf-8?B?ZVREYk91MzRHenFGelcyZkx2WlIzVW9vbEdQdllGWlBDUXU3QlB6bXpjeTlv?=
 =?utf-8?B?bUhCRm9hdWVVQUJIc0NGZzBkdG1LdW8yYnhLNjBvaTgyWFFiL3I2NVhsa0tw?=
 =?utf-8?B?NytMbTdvbjRCbDhWSWhJVExRblBucjdmK01LM2h6VnlXUmkyRXRHUDlmcGpI?=
 =?utf-8?B?SkdML2Vqdko4TEhBN3dpNk5ZaWNSUHc1ZzR2OVg4Q0V0QThNMHdWeExwMENG?=
 =?utf-8?B?RG9FdlFKN0ZEUmg0N1pzNWZkYnJxc1pXSWZ1ZlJtOGJ2dHhGeGhIYk9YT0NE?=
 =?utf-8?B?TTNtMnZ0ci9sdEJFVURBaG13SEQ5ZFpraVhveXViVk5aaEJwcTdIemN3eGJk?=
 =?utf-8?B?djVaU2xBV0poeEFSR2NJSlpTb2pHTENITUVtd3VmekdrM2RpYzdYa1VPam9v?=
 =?utf-8?B?ZjZWcG9MbTdhMEhVb0kyQnNsUnAzV1VaQVA3SHBLYWpFMjFTV044U1dxY0N2?=
 =?utf-8?Q?iKS2Y6CvHWrisBbUvUd6983JiJLJ2qudifrk4hrXla8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38af7b0-fb33-4254-28bc-08da9631069e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 09:10:53.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcvEd1ejpT9XFnbOG3HOKBJXtyBDrKr0V+afCo28ACAzSqJ5S8NRzMLGqNg3/6kI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.09.22 um 22:05 schrieb Philip Yang:
> Free page table BO from vm resv unlocked context generate below
> warnings.
>
> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
> pass vm resv unlock status from page table update caller, and add vm_bo
> entry to vm->pt_freed list and schedule the pt_free_work if calling with
> vm resv unlocked.
>
> WARNING: CPU: 12 PID: 3238 at
> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
> Call Trace:
>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>   unmap_vmas+0x9d/0x140
>   unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 47 ++++++++++++++++++++---
>   3 files changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 59cac347baa3..27e6155053b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	spin_lock_init(&vm->invalidated_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> +	INIT_LIST_HEAD(&vm->pt_freed);
> +	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
> +	spin_lock_init(&vm->pt_free_lock);
>   
>   	/* create scheduler entities for page table updates */
>   	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
> @@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
>   	}
>   
> +	cancel_work_sync(&vm->pt_free_work);

We should probably not cancel the work here, but rather just wait for it 
to finish.

>   	amdgpu_vm_pt_free_root(adev, vm);
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..b77fe838c327 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -276,6 +276,11 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> +	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> +	struct list_head	pt_freed;
> +	struct work_struct	pt_free_work;
> +	spinlock_t		pt_free_lock;
> +
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> @@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 88de9f0d4728..c6f91731ecfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    *
>    * @entry: PDE to free
>    */
> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool unlocked)
>   {
>   	struct amdgpu_bo *shadow;
>   
>   	if (!entry->bo)
>   		return;
> +
> +	if (unlocked) {
> +		spin_lock(&entry->vm->pt_free_lock);
> +		list_move(&entry->vm_status, &entry->vm->pt_freed);
> +		spin_unlock(&entry->vm->pt_free_lock);
> +
> +		schedule_work(&entry->vm->pt_free_work);
> +		return;
> +	}
> +

I strongly prefer to handle this in amdgpu_vm_pt_free_dfs() or even the 
caller of this instead and keep this here the low level free function.

>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {
>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> @@ -641,6 +651,29 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +void amdgpu_vm_pt_free_work(struct work_struct *work)

I think we could make this one here static if we introduce a 
amdgpu_vm_pt_init()/amdgpu_vm_pt_fini() function. But not a must have.

Christian.

> +{
> +	struct amdgpu_vm_bo_base *entry, *next;
> +	struct amdgpu_vm *vm;
> +	struct amdgpu_bo *root;
> +	LIST_HEAD(pt_freed);
> +
> +	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> +
> +	spin_lock(&vm->pt_free_lock);
> +	list_splice_init(&vm->pt_freed, &pt_freed);
> +	spin_unlock(&vm->pt_free_lock);
> +
> +	root = amdgpu_bo_ref(vm->root.bo);
> +	amdgpu_bo_reserve(root, true);
> +
> +	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> +		amdgpu_vm_pt_free(entry, false);
> +
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -652,16 +685,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>    */
>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
> -				  struct amdgpu_vm_pt_cursor *start)
> +				  struct amdgpu_vm_pt_cursor *start,
> +				  bool unlocked)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
>   
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -		amdgpu_vm_pt_free(entry);
> +		amdgpu_vm_pt_free(entry, unlocked);
>   
>   	if (start)
> -		amdgpu_vm_pt_free(start->entry);
> +		amdgpu_vm_pt_free(start->entry, unlocked);
>   }
>   
>   /**
> @@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}

