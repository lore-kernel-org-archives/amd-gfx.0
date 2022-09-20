Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CC8ECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 15:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B3E10E6EE;
	Tue, 20 Sep 2022 15:17:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582B210E6E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 15:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW+/KxIEi7+rWyj2NXNDa/HRTUfTBWbzRm/ZYT44uBaEYnO2kAGkSVw+RMN77ANQo0qbChDSZPkz49WyNj7PIDtftks4nj89RzxJbJoCljTjSw/tN12uz6UYYzV/O2QpXB7+3Myar1x9dkUAUVUa/ZbhBPvOTY48b59uwxndjPSZR/mmVFfS9rB10q/R7UkRmTa0dHL94G7B37PNgH4YBQGI3cobL6p6hDIznMG04jv127G7Ju0iFIhS+d9sQly5A3BrZyARoBwt2VNoxgv8sJMlFkDA2OKjOa4wnKbH8D4dM1aJ6f/5ZMIpsSCsGLJIU57pZY1dsOPDxwVtp621oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z9tgD0CQPsTGT49lESMHKHIWVH6BmwI7TnMaqKw2YE=;
 b=JKw++uuMQ6Oem1PNFCWDuBtl42B5r/dwWZdSM4i8Pnei7Mh0POhwv0bNPAUzn4APgavHV/+dTd50QnVzQs9+acSRW246IVGNY8kJa9us54JD8AzfyoR2YoeBynkzVwhuY7FQpC0skdbOJlSzbbGvHgc4v2a00RiJcKPf+Lp3EHAxWFdfnEHLdEpwuR1mC9uQ+wYiOBffXRfQcKFDJ3TWEXgBXfhie321JaY7CDvRy5/YFZgTJ8BVyZtH6qtmkON6qmUGrtXF2xB+7hkYNe0aJQfODzYfsJVlhUpkpiP0YKQlpjLeIqnwfwyeRdESAvWoxz7pJPJueKDOaxktXwosdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z9tgD0CQPsTGT49lESMHKHIWVH6BmwI7TnMaqKw2YE=;
 b=3lCoVqWslmHBkQL++i7CHIQjkI4NODKms1sTiXSJh5VHktppVzPUqO7rsgFh8+jawzJWUu0PBKZ6JeJ9a3x6Y8J+x5pn8u2/Eg28b5jSD6TDS3RHE1eYLj3f/XLXpEajPYmsX5f9SmYFbuo1RYkNUR5zWam+eKXefl1cVRWurIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 15:17:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 15:17:31 +0000
Message-ID: <8ce5a19b-9b3b-385c-485e-5958791baaee@amd.com>
Date: Tue, 20 Sep 2022 11:17:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 7/7] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220919171553.11286-1-Philip.Yang@amd.com>
 <20220919171553.11286-8-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220919171553.11286-8-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaa1ea8-fe45-49b4-530a-08da9b1b3cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wf+yN7Njpw6/Wl8SPjJh6AVNao62BuQgwmEYBv2io2EWYRSBbBONHYYUFKKR2cWa2l/4aZSYDL2Knppf8FoNt2KwcySN9O9UUS4MFg7CRJhQPAwP2+M5g+4Apv9rZW2lLq6Sm5hr9Dw225CqWgJUT4W0yxKrvJLTdcdDVZKEmBkKO36lN3WgUMcGxXkp+Ulb/gIyl1vJOkAJ8MKkDvjDGUIW1DGe/AGGa54oNPQB2oNEnNMSIEoeazcgKUwGEOPlyIgNjo7R4k5W5x6L8Jhg43n9cP3tUXJtqDzapiJjisMl3cdxrMFnsmGYaOwewX4yVFhzipTYRpvoi0nv/m4OnXnHqzMNy8buVJaONVlAqKFH8Mz6bppKUfbIVv5GLOunIdbgCb5R84K+lP9CbkCd8a7gBqEQlX3R0d7oRaUtzmR+O601wsQSKP/K0wVAnXx3afks0narR6FW46AxATqjhfGYsymuo5LOvvZuZttrnnoQebUywAmTkTMoWea3zF3XO71zz+sRky7jnq+jp8C/nEZVc6gsm5eI4g5t8xKlbX67Wq/fqSuZ1+x1NsRNGJR19E1CGhw5x3f93mLWMD0MQnq+jo447BgabD2sIObCak2RKI/ZZyBo1SUi6avv4KD5/pM0Ue347E4pNuxvO9ngq+osBODLdGXCkru1zKFTa7L2YvfvT4TbeoK13erF+b1MWR+dtVkuCfByFfe+LOaSiWa+3AlLQuYUvjpQuJUji1Q2LXbhi3VM273egVYCk+jw0AB/NepJiH88mcLfyexKE3+KxYhn4RwOE8Fa87Xb0AY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(6486002)(478600001)(316002)(6512007)(5660300002)(41300700001)(8936002)(83380400001)(8676002)(4326008)(66946007)(66556008)(66476007)(26005)(86362001)(6506007)(36756003)(44832011)(31686004)(186003)(31696002)(38100700002)(2906002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS9Ud0tJVlVwVUtuV2FhcTd0SHVjckhQcnF4SjNGS2wvT1YrWG8rVndKd056?=
 =?utf-8?B?K25YY2FZSmRoRWpFTTJGR0JRU0REZXVLRUtFSEc4V0NGSWI5N0pXWTdvSVor?=
 =?utf-8?B?N0lZeGNGcmxQcmI2dmo1M3dMTXlJWHRFQm0wSjNzck50ZnpMeVUwSzBCQmdx?=
 =?utf-8?B?U2hxdXErM3EzdEpRVi80N0R1OHlPYWcxOExFSWh4ODV3NzBzSEdOK3V3R050?=
 =?utf-8?B?bnBkdzlwLzdyZm8vd0RqZnRtNnoxdlI2b0JuQndocExKR3FhM2x1Tkg5MW9w?=
 =?utf-8?B?U3U4NVNHYU1nNE02YWlQamdlYnN1UzJpZVh5UU83Rnk3SE4rYU15emhZUFI2?=
 =?utf-8?B?VmdsNFVtQytheU93QmEwNUJiZjJEejhpcDMxeXN1YzVscUFSZjlkL3lWNVdq?=
 =?utf-8?B?d1dVeTZDaTZEblJiU1lhWE95NFd6Y2lFZC9SSGNGQmVha1o4TVFkU1BFWWpw?=
 =?utf-8?B?a1R4cGIva0VEdUdORkdkODlsWG94OWg0RkRYd0p6OFhvc3R6OGZGc1VlVTF3?=
 =?utf-8?B?SmVJT0E3K09MZWxGZ1pBMDVNL01hQ0p2OWFmMmRIeGtaWnBXM0VMcU5FeVQr?=
 =?utf-8?B?TEg2dzVMeXptWkdPaXlYYWFDSDhaazRidFMzMGd0MFo2REZkRUxadjZJZVNG?=
 =?utf-8?B?MkV1VVFiVzdGdTc2MVg4WEZwalFjQWlNZjNkNmhHZjRRQ2N4S21WRTRlenVI?=
 =?utf-8?B?N082VWRISnllVGovMGpSRzkvSDhMaDVkV0dZTW5waGlhdzJUMC9tRnpMdlh0?=
 =?utf-8?B?eFM0Q0Rpd0kwMWdPM0RNTUN6SnZkZEViY2NrSnZ5cXpwdmZ3cGd2aSsvOHJo?=
 =?utf-8?B?YmRMaVNCY2NET2ZNMXo4UmxZYTZnRU1zOUJZK1cyc3lGV3lmWGRnN1d4Z0FS?=
 =?utf-8?B?Sjlxa2IzTk91RWlpbFBaVzRzWHlMcXRIUVgyd0pNMVNuYUYycVVqbGpjMDZY?=
 =?utf-8?B?cEFFZmVyb3BZa3ZsVzZ4RUN5OHB1U3RqdWdsa0Nka0RXc3VYYzVEOXpCZHhl?=
 =?utf-8?B?TnZEY0VtKzNjdzJKT1g5UlBXTTh1SktRME1NaGg1NmQ0UkxCOFptbFZiMGs0?=
 =?utf-8?B?Zm9Hbm5hTEFIUVljVENMcHpyQ0haSmh0SWtxZURIaVRFTkxqWDFhWkpSMGlU?=
 =?utf-8?B?UWQzVkZMVTlCNE1UZys4SE1mUHVwZSttOUVTTmlYRGtFR2RrOFZzMWxWOWho?=
 =?utf-8?B?UnNhRlRQRC80Yis4emtlamtEbFVWNkc0UlBvSHhlY1pxNzdZY3dyN3BFdXhx?=
 =?utf-8?B?eUk2dzVabXVZVURDRy9WQ3hyci9tWWtEQ01aRithNzNRWnM1OW5xVEJYdzBZ?=
 =?utf-8?B?V3FnK0R6MjV1YmVCNjlEUkw2b3RzQXRQOS9vTHpnamZ5am9HU1VZc3ZwNXhX?=
 =?utf-8?B?RVlDdHhpWTJYTkVjY292K2ZpZ1YzMmhESXF0dEVLWkVrcU5RSFpMbDQwdlBG?=
 =?utf-8?B?QXF4WlNpSEMvWjRhVXpnTXZlUXVlKytTcmduYWlmMkQ2S0ROUnU4TFdpdldi?=
 =?utf-8?B?UGRVNjJrWEFKeDRkUmoyckZ5SkFCSFg5azhsZWNyTm9GU2VPOEl2Q0NQZ1lp?=
 =?utf-8?B?YWptc3pUOXR1OWxtRDR0TmxVYXFYZXlXNk05aXNYeGhONTlBcmxEMVpkWFFX?=
 =?utf-8?B?ZUJMWlRBekpqV1ZiREZNTVRJN3lqb29YTGlRQWhFRkhqSElMK1NmUGNSdGV5?=
 =?utf-8?B?d2w4NG5Lc3hLMXZHZTh6VjlSNnJrQzh5ZFdmU1BHSjFKNDZLYTJQRXd6WkhK?=
 =?utf-8?B?QXI2aG5OMWcwV0lIc01aRVpPbExnU29zMlE4NjNIUmpKN2xnZ3E3K1A2SFA4?=
 =?utf-8?B?bUNzclpZVDZyZk1JL3lBeC9wcFVsUEViUXpGVWFVTHB2UWRFUG5rYXEwMFpC?=
 =?utf-8?B?NXhjSnJuSWFsMDZWTy9lMG1zcm02d1RGb1NxeEYwTHZvdDlSa0grNzN5Y1BQ?=
 =?utf-8?B?UlFtMGMxVzNXT3dDZDFTOGxVcTBESHFWSGkrbGNrTnd2aHpscUlLRmd0bHZM?=
 =?utf-8?B?QWZhbDZPaHpUMVBmUkIveGdSWWFGeHFCQ1R2TzhYY1pRS1lIald2alhkUDQ0?=
 =?utf-8?B?Y0pmOUlGcE10NVFaWGpCOHQvYUNKM1lnWGNBeGE3eTJhRzhmTkNRM1RpS2VE?=
 =?utf-8?Q?S+MHHUR7RaA6puuM23HCQbB2n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaa1ea8-fe45-49b4-530a-08da9b1b3cfb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 15:17:31.8528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUoBZ8Ki8vUZz4I/v3ICYqd1pCFvn8D+YWyVLlGadOefbkgpZwTLszoZCDIMS8bKcc2Eq9GJKp1EIuTauKVH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-19 um 13:15 schrieb Philip Yang:
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

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
>   3 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b2e96682b9bb..83b0c5d86e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2055,6 +2055,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> +	INIT_LIST_HEAD(&vm->pt_freed);
> +	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   
>   	/* create scheduler entities for page table updates */
>   	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
> @@ -2256,6 +2258,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	flush_work(&vm->pt_free_work);
> +
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index e6dd112d865c..83acb7bd80fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -278,6 +278,10 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> +	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> +	struct list_head	pt_freed;
> +	struct work_struct	pt_free_work;
> +
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> @@ -473,6 +477,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 61a4b7182d44..358b91243e37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -644,6 +644,27 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +void amdgpu_vm_pt_free_work(struct work_struct *work)
> +{
> +	struct amdgpu_vm_bo_base *entry, *next;
> +	struct amdgpu_vm *vm;
> +	LIST_HEAD(pt_freed);
> +
> +	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> +
> +	spin_lock(&vm->status_lock);
> +	list_splice_init(&vm->pt_freed, &pt_freed);
> +	spin_unlock(&vm->status_lock);
> +
> +	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
> +	amdgpu_bo_reserve(vm->root.bo, true);
> +
> +	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> +		amdgpu_vm_pt_free(entry);
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -655,11 +676,24 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
> +	if (unlocked) {
> +		spin_lock(&vm->status_lock);
> +		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> +			list_move(&entry->vm_status, &vm->pt_freed);
> +
> +		if (start)
> +			list_move(&start->entry->vm_status, &vm->pt_freed);
> +		spin_unlock(&vm->status_lock);
> +		schedule_work(&vm->pt_free_work);
> +		return;
> +	}
> +
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>   		amdgpu_vm_pt_free(entry);
>   
> @@ -676,7 +710,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -969,7 +1003,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}
