Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF94C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 20:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7011810E42B;
	Tue, 13 Sep 2022 20:11:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8EE10E42B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 20:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiD1FZJUXVFm2uQQYlPpt1OinZz+WcxDGE9Ac7NNOlVoj8MvodILI1iJH6DOlcWyvZWKnOe5QdS91flFEARjJ1AvXinz7Y+jrZ9c7Ig2OrZvg6sFeAlzSlysQ1f3cvZyNN1ebf6z0R4Ak7Qg10FGMb1EQAxkgSzCtPJ/fcHEkbc6AhdrLj6HhFXeI+sfaNeEAoYKvLJYpbFUPQA7Th2wN6io+jyWiOi5tj8cS1A6iXnjRomQqGOFWzOnneiXqflaelzBTJtKg8kJC9IAqLqS6M8XisipN5jSPQ3TuN3qiY0GRHdIOfE+xV+7qWTn8oV7yeikZL2sF8eSMRRpkCV5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeVKx3v03mBgL+vE/pESsrTC9A1x8NyFMDZbIo+to74=;
 b=Au3ibmuNQLC2NgswPMUg75IPAIWpUBSyrmYe8Lv3EZdV3IBWVzXP8dSapVwKgJ3brqCtl2r8bFVb6idFixYWT2D/jAZoVy6vIIEPIRqZoAYO5thbORBQf5DY+hK2xBVFivA0DHmG2NfwQFG5r83umzKlCSz8sPRsKIgFf835Cea5ipb8ZTYFnvi7yKVMcfgQPeemxte5E6H5/kZKXDuiQxTJodmep71im5WE3Ihqas8gaQcUazlHsLfvd448bUeZE2ioNP4QMBZg8rCKjuQOLR1ULetZM2tWq/8O6i0CYflL6LOQf2QHgQB1YnE6YpIm9fXOYY5ORTFnC2VSzkvDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeVKx3v03mBgL+vE/pESsrTC9A1x8NyFMDZbIo+to74=;
 b=vxsmVys3qYknI9Bxo9xMzB5eMG5y/QXvnbjzzgqaorVYr1H47jqYiCHctsCQ7oXNzdSWQ5mjRaH2+btbyIwuvOTRGOYcFVCOCuHBfIE4pP/wkqKusZrHbZYo4s+wQFCppWcHMZxOOpAfmnk4DNjZQ5dCSiHeqgw6yhNW/sUajMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 20:11:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 20:10:59 +0000
Message-ID: <05e8e202-4a15-2cbb-3c27-4f5c18270c9e@amd.com>
Date: Tue, 13 Sep 2022 16:10:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220912175817.17985-1-Philip.Yang@amd.com>
 <20220913131926.24766-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220913131926.24766-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2d5de6-8cbd-4ed1-47e9-08da95c41349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kjMfrlJL4aXjytVPPLsapJaTLB5tiCrveqE5o0q2+A/qPNH3809zEvL0bpwr7wZbQFpAavF9pFqMXRrWEk8Xz7Oj7CovVpYm2HySAtzmvPCD4J3YcXagPl4ndkk7J4GtPIwMqy8Auq3uUdN9xcXT294GRguQM9xV2+aUCCPXkUtjCTsrAEeKaXo3gdAMvV8BH4gmyPbkyGzMoPRnrhsz/X+4bbgOEjiL0OiuHpbUh/TKYgrAgggZNWPn+jO5QCPjAmK2Up4pNNTJwU/fh3ja7GWlN6BrgQ6KBmdV/17gvIFxF145Q35DpMsR8KLYZBkXy2+QsNRyn8UbBhv/dCPojwJMnBR89k1GtceTekDCdnnu2z8dUT4rxJOYAaZunypiLrG9Z/MjUUHuzowyYRiBN5MUlfJ0U1yk8IZz06s0HFBgxB/cnSOXkKR/H9etyKzQKSGK6NuIrOzk7PUbm3rS5jA/lg3Y8ogqQ8gDq7Q43jg+Ng7iKvFwSeaFnyhL0SKuQlHa44zYRLF6pCPsllKSKynvdFt6TC9CEgN7Ex0RRK0zmHVriE1Z2kwFs7h/QIUQM9TiWaDBgsCvEFuoCVKZ/w9SCoqrOGUWFRV6ypdnyQCa8LMTIlv5rdRxZEKbigZ1SCCvdM6p+S4k8RqNmQY4o76ByojQ19ElQyoNd4uhTHJmdUYqyKXhjNd9CkJ2DXQNPWGM9SatgvRIUbOFERBei5VErTozT2V0uud5CvV3byV2WfYzwNiQMc/WLsyD3k51rJNuwLNeT2Uf5IW/Na1bP0aZFHzm1T52m42tt0cWpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(2616005)(186003)(6512007)(478600001)(36756003)(8936002)(6486002)(41300700001)(86362001)(5660300002)(26005)(31686004)(66476007)(2906002)(31696002)(38100700002)(316002)(44832011)(66556008)(83380400001)(66946007)(8676002)(6506007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlIQ2xZU29vYkhkMU5tWWRXQmpObldxRjY2S1RqNE9uRGxId3ZLdHE5d2hE?=
 =?utf-8?B?UlBjOS82SWhLT1A3MVgvYW1GWHI3RlRpbjVZdTFncVE1TkRhakd2Y3EvMUcr?=
 =?utf-8?B?QjVjTkRiY1hPRUhsUVYxaE5BRHRYaU5ldkNSamFYODVSempZTks3V1pFMHY3?=
 =?utf-8?B?QldlVFJ4LzRlMWtwcElGcXY3M3Fvb21NcGp5Szc5VndndVk4dCtENVd0K1Bm?=
 =?utf-8?B?UFdyQXhIWWpneElwUlk0VGdQMkViR3B0TlhMQXhoK3YrVUlEV243YnhhbkpK?=
 =?utf-8?B?VElvVS9ST082R1BBcmM0cjFpVjFSUW04cU0xTUVvZFVSVFpjTk5xY1RMK0VO?=
 =?utf-8?B?SytZTkxhZWdvWlJ6Y2crUDRqQy93OGRVVGFERmtkS00rSHMzSmhLYXpybTEz?=
 =?utf-8?B?aWt6WjZaZ3RhZS8xYTB4b09CVkZQRWFMeVpDVnVvQjhDNERWM2YwczFZenRX?=
 =?utf-8?B?Z0pxVW40Z1U4SzFncWROQ0FFQ2ZZZFkxVGFkdTJjcG9vNzBnWEhManUyR3NQ?=
 =?utf-8?B?V0JnMXcxVlJ0VUtvMUNMT2dqQitmM3dTL0ZOWjZjTG5pMStjd1lyYkVKck90?=
 =?utf-8?B?dE90RExhSXpSSTBlakxuT05yY3FzbzZPcUwwVXg1dGllNFc1VUNGWnFTT2Zl?=
 =?utf-8?B?ZDdxT3BRejVuMVpHRjlrRnFmZDFMSisxQkI4dGxqN2hQQ2owMEswNVBFZVQ5?=
 =?utf-8?B?bVpyZkhwYVFHTVRxK0FuWTBBYVlWOEhxYTVxTGN0SUxZS1MrazBPNTNNaEpV?=
 =?utf-8?B?RllNK3FacGRTM1FpbDh4NHhhZFNkbmpUMi9sUi82OS9VU1hnS2pFOElEZWE3?=
 =?utf-8?B?Wk5MZ0hxeHZFUlJrQVZrT3JyMGZ0d1NGVFVzUThKZXdOMTFjSHBCZGQ1ZVc0?=
 =?utf-8?B?SDR1M25qMi9PVFJ4U2RwbzlhMitHWG1lVXV4OEdQdmtuYktWbEYxNEtsSUFG?=
 =?utf-8?B?cUFaMG9LMnY3Wm85eWkyZVBxQzFmS1BuMnpmeWR4K1poUGZIS1R3VFNtVFBW?=
 =?utf-8?B?TWl2VDE2OW5YVGZ4MDEyMFJleEdtaVVyQm9mVVJHbGx3dmZONTJaenl3VEhN?=
 =?utf-8?B?bTVOenVnUDlUeWE5d1d2NWN2MWNycStWSHk0U3pYaTByOHlKeE5XUGE5a29u?=
 =?utf-8?B?aXphQTNaMjJnaWc3Mlh1RHdJYW5SV0lGbm1nL3hMWmRiYkJVNW1Pb1FrZDhY?=
 =?utf-8?B?cUNaNGd5cm9HWUp1RFZ0RWRWaHRYR2R5QnlSRlBxYm9vUDArN1RkMUYrWHEx?=
 =?utf-8?B?d2J3VG9aeFk2c2RzK1YrOG1ab1d2bSt2VWRtUE9aU3hCM1FZZUtvT2FNNFRi?=
 =?utf-8?B?TW0wa0pyWnlQU3I1cjRhSExxZytMcWg2S1lyOEptMFc1TURqTTE1Z3h4bnlW?=
 =?utf-8?B?bmZBQWs4S0ErV2pPK0VUZnJTZGN2NGd5UU1RR1FmRUoyWEQxUFpIVUF3a2xB?=
 =?utf-8?B?UmpCbi9FMFRNOTk1RURINWJTb0o2UjVTQTJsU1BEYnNnZDlWbk1ROExUU3FP?=
 =?utf-8?B?TVpqWmsrcXFpKzhIV3hEQjUwQlVDM1AzSk9mV24wWkJRa0FzUGJXZWhWRGlh?=
 =?utf-8?B?VDc3czd2bFpjWlY1Yi9LWWFkK09KcGppRHgvbnp5NDV6MGJmWXNTQlRta2Uw?=
 =?utf-8?B?ZFczSzFKTFU4K0JNSHptMmp0WkxnS3ZhVG41VHBUd1lYSkwwRmxzenN5Zlpq?=
 =?utf-8?B?Y3JZOXNYUHZxbmdWU2lXTTRNMEZuU0ZwUjdMeE44OE1ycFlaMWlWdHJhQnhy?=
 =?utf-8?B?UURPMUh2TGgwc2RZMTh6LzlrOGEvVFRyNUEvbndSNEZ5eGNLUy9BSXEwZCtu?=
 =?utf-8?B?OVdGUGtqTlJMenBQZ2dwVVVreW5aWlFVMzJhRWY5ajV6NTFEU0I0VnByU3Ur?=
 =?utf-8?B?bFNMV09FZVVvRm9sdi8xaGFxNk1Sd0JWWnRaRkJmcTlLQitBZldDb2pWMVd5?=
 =?utf-8?B?NE5BekQvR0lSRFpmQmZIVzk1NUFuVEcyaHlDNUpwQkVUMTlzclpnKzVzYmJX?=
 =?utf-8?B?bXRCbEp4TDlja1E5bmxLOEVrcmhnSzhiL3NKd0VXaHZjeWN5em9CUWJzM1NS?=
 =?utf-8?B?TDBJSzVEajcyK0l0WkNta0FzQ29IU2R4UmhUMWY5b2h5WEFabEFoVTVBUGl4?=
 =?utf-8?Q?6CyCQJfbx2N5ShoaQ5T/GTnFl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2d5de6-8cbd-4ed1-47e9-08da95c41349
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:10:59.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCj+AtJc0img6bgxMPc6iKEBj5lkVbImNGJWpv9xS23H14mFjmOLVpZzHFEz6ZinkCY9BDPXjIWTTZ+3WDlw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

Am 2022-09-13 um 09:19 schrieb Philip Yang:
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
> WARNING: CPU: 0 PID: 1475 at
> drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
> Call Trace:
>   dma_resv_iter_first+0x43/0xa0
>   amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>   amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>   amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>   svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>   svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1d3/0x230
>   unmap_vmas+0x140/0x150
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
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {
>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> @@ -641,6 +651,29 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +void amdgpu_vm_pt_free_work(struct work_struct *work)
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

I'm not sure why you need this extra reference. If your concern is, that 
the root bo could disappear while the worker is running, it could 
disappear even before the worker started running. In that case, you 
should take the reference before scheduling the work. But I think 
cancel_work_sync in amdgpu_vm_fini protects you from that. Therefore I 
believe there is no need to take an extra reference here.

Other than that, the patch looks good to me.

Regards,
   Felix


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
