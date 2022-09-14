Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFE8ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 17:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1719010E9AF;
	Wed, 14 Sep 2022 17:46:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8800C10E9AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 17:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxK35eKIkb5jlPsDZojdSZh2K9+rLX/gmtSMLcjvdf+wJ/55x4Q12aVil/lELKvnzRYeOByVCU798LNIw9uhC7cZZPj2nvZK/RQWLWOKBofv+lm8wmuQgN3JnCd4FZEtgGMxfVttlmVpDjBezUCCGEbP9y5+hGR1vr8bQoUSHv0nxPfGadpvd3tp9fwNk+IzQwH24iWK0Fy67DGEtIECCMUwhft1JV/mw9AEdUR5z2toUYLr3uGs1BsCO56SYFKeDGVb3ODD2+4mVcs7W2QXIB4WyL39pq9R8AQ848vOF8QKF3JNegbjLSad9Ig/P2R0udJiNQ0oRYbaFsrCuFRLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMmkFMYwjJigEWYc37qC8R9h/gLn4uVLI19XD4WkrUU=;
 b=Eh6McXujxpx4XaNW3e89gFV1fcKMXI6ivDNzUpoqjNDhXFrY4YGy1PDIphTz4PBfYjUPnTY5Op4P3Y2oJIiHQc1zfT+xTjSon5ASEqgTzOLUH3xZp/0npeW50RHD7lmg4kEFurW3XGwtg4Jjo2H46KWf2+NzWb9peb9g/YFNGlBaANs9/4tnXtzteHSVbcZaUy6OYcJFhbxVT6mqjSr2RdcklyaCJFqwMHWdvFyyueHX8a9qg9H4bqu0IOAAm6GLaZL+JzX8LP3NMeUXAq+qJ6m1G7K0vMrqgnE81SaHSn6yrZSC5VpREbTu2A09xpZdZaY9CsAENmJmXXeuqRmakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMmkFMYwjJigEWYc37qC8R9h/gLn4uVLI19XD4WkrUU=;
 b=I3MjDqtAZ/Vge6zBxcO67bjwZo7HRQiieMUfZDs/b4yj/n6XzeFH1KV5NdT6X/YYcMzZo33ZW5FZ+Rpn20YeO70bB2+sHpCYpXUSmw5kDSmYS4h7vj6a3Ac1UQSDCf69k4rxldfBOOh9Sge1DfWJRo5n9AEVpS5rjVnj6XkWfWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 17:46:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:46:00 +0000
Message-ID: <e95c37e7-d8c8-3802-63a1-92b5f6b579ef@amd.com>
Date: Wed, 14 Sep 2022 13:45:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220914160842.9610-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220914160842.9610-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: d2234768-38f6-497c-1de2-08da9678fc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7MtgCmS8UyLGlL5HgrI9hxWygBW1VWBVfaUf120vnjxrownAsF5psavego69Hf2uzfW5FKgwxLix9+nAjr/IVgYB6rGEBUAl/cA7KQmcNRT0b1Xi1OkVKJXDNXmYEra6L0w/2sjuvDSHSJpnH9SK93o2+KKuHrIXKv8hPMmhxqZwtm3Qs9dAQ+jDuQV04ROuTPOIQRqJrQF9sVMCJogjxBJgcpNczI3coeHF1UV4UABWDiYi5TtPZCIbII0zu+w09anS4ABBY2rSLUr/7ZEF/tiowuxq185LR4uydbsW7KCZslxpomivPqiTuxouaprpRzqwZkxg8su3mhgikvkrg0tkNN7LOySP76QLBKLfNyrA6IBzakDsucbNhEX28zguQb84MNTwZipxtRmkSQ2q3iF0+uTGpMJBFaZYCfA1inLNql6SKjtNiYlMKPfDbAbteXRypMsy9e697pYq5TEaNUg6OpbS9VXzCblFtSF9YVpaxKlXZpVyO1fW6DhwpsHJNDWQ27ZpqPmXek+l9203ykXjd6tDcZDPKcf3dlS0uIPtAKWUUnoWuUeU2wvzHddV+OBZV3YSwOPOYOhZnjo4HB2TMh+E8VUSgCo9aPGfkZqpU2Bv1QYRXEOHGFV61RFFoo9nqkAicgNrZT6rCCUQQT/sB2kDxwIv+OeIOlpSWMrS9l3PhkXelC4z7k/YrCQCPduB513bxGtzR5vM9aW8KWGsNXV9p40UHH6AeYKRiZKp9XiaoIuCCKoUgyY+rlrl2X9hkWgZSb3kvhFakzBsTw4s5TP8SLx73hnCSdruWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(86362001)(6506007)(31696002)(4326008)(478600001)(2906002)(8676002)(8936002)(316002)(66556008)(38100700002)(186003)(41300700001)(6486002)(31686004)(36756003)(44832011)(2616005)(66946007)(83380400001)(5660300002)(26005)(6512007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFl5bHFmLzZ1RUsrTVNibVRNZE81bnphclNRRlNud0tkZkViaUNEWTJzeUZj?=
 =?utf-8?B?b21QcENMUlQvdk85aHJoTnFDNHZUaGQ4RnVJK0NtZk8ranVoM05iMTloRGtN?=
 =?utf-8?B?R0oxSTVsNmo5d1VodXZBeWxxSFBJNC9NWkJZM1hONTZ5QllNY0V0MzdDaURU?=
 =?utf-8?B?bnFVR0owelVuRHQ0TXJIL3d6b3VobDZlZ29XUE1lVGVvdVpoa3BzS3Erd0VI?=
 =?utf-8?B?c2ErUlNMeVJJcWVtM1M4SnVGQWxIeGlmbTIwYlRSRExDNndzQ3owY29jTkxs?=
 =?utf-8?B?ZW1SUXJsNFpFVk9YZmdabWhld3VmZU5xaVQyYWRoZGE4cGIwUmxLY1REdHM4?=
 =?utf-8?B?Rlo2Y2xtb0ZLVENRSHRmd3A5VmpqTkZiTHhFS2lEc2JTYTBwcmJmSVgvWE5K?=
 =?utf-8?B?eW1NSFhWY3ZZaVVlbFpBU1lBMVluYjM5VGtzL3hNUjA4bWJTOWliU1JIeUU0?=
 =?utf-8?B?M0RwVEFnUCtiSmt0MmN0Wkc4TmFXZ3pkQU1YUmJGb01nNXVDQ0x2ZW5xcWsr?=
 =?utf-8?B?aUlPVWZQblJUQ0lQWWV5TXRDQXRqaFRmUkNwUFkxeUJ2VVlMQmk1R2xvM3hV?=
 =?utf-8?B?WW42bHloTStOcHlvT2U3UEc0cVNIMHN1cFRhWkJzaThONkRGVEY2alNSNnFR?=
 =?utf-8?B?Tnc2V0dBQ3N4MzVEM2ZWR3p1Y0l0TGc5b1Z2QmYwZVZZdHFWWmQwemdlYXhh?=
 =?utf-8?B?L2VpRGR2bTllU0FWRy8vdzB2czZ6MGFHOXpjVDBUWXFsekYveDBya3hoaWdD?=
 =?utf-8?B?eDRiVWxnN3lTeS9INk5mSEtMS1UxOEo4ZE1FTHFvbnlhRkFTRW5Cc3I5K3Q3?=
 =?utf-8?B?ME9KSi94KzQ2bzgvSkVka0pBaW1qVzJHR0NZV0FFNFdXT0pxMVNaUEFKOXYw?=
 =?utf-8?B?ek4wNitDd3lyMWxPVVNkZDZuZFRwZnJtZ3laWHJqQ1E0KzQ1Y2xPdXhLbzVr?=
 =?utf-8?B?VWJ2TUNrSStHZGRFVjIvZHhGYTN0MHpnU3BaS0RuVkNDamM5N0Q0aXc3Vmkx?=
 =?utf-8?B?dkliUlBsSnhkS0loMzI3NlNwRURiUWY2ajY0UGdkeEtQbmdDMWF1UGlKZ0FH?=
 =?utf-8?B?K0lLWVN3eW9RWE5YemMzK1BraVJLYmZHUjlxZEVHc2lNNHFtNVgzWnp3Z2w0?=
 =?utf-8?B?cm1hUHNaMWI2V1U5SHVEMFJjVXB4bHdKVFVMMHM2Sm83NXFTZHJEUk5Ka0Fm?=
 =?utf-8?B?bDBEVm1rTHQ2K3JvK2JUTmJBOXMwK1dtbjc2NEFHcHBoY05vV3ZiTzBPUnJG?=
 =?utf-8?B?dFdBTWRoeWpuT2dEREJYVzVzY0xtdGVWWTFaa1NGZmg1anRjMWtTTTB2V0FJ?=
 =?utf-8?B?VDl5aGpTUzNvWDdOVlFvRGdFQmNBN21iTmlpekJnSGVZVHpkTWpIS2ZvdThZ?=
 =?utf-8?B?V0ZKOTRVVGpQbjNpM1V1TEp5ZnEyd2Q1MnFTNmVzRjBURXRQNzdocFY3Z2gx?=
 =?utf-8?B?bk9zckc0UlJrRXFjR0g3d3dua285Smw3bnMwT3dVdVZLelpSc3lwQ0REOU9H?=
 =?utf-8?B?elA4SjVaSlNaMG45TmpGTytLYTYxb0NSTU1PdmNGYmtqeExTN25RVG1wTkpZ?=
 =?utf-8?B?emNUSWlhS2IwMy9GbzU4dm43cFpaZE1GV0MzMTF4bGc3Z3BmRGVGOVJ5a0Fa?=
 =?utf-8?B?SzdmMTlON2Y3NVFOdU92aGVTZ3p1ZnV1WU5zanBFdkw2ZUpqUGVFcDhHUnBs?=
 =?utf-8?B?Y3pnVjhyVWp1QmR0eUVTU3hadzZZZ200L0MrSFlqU3A4VldNbjRIemdzdG5s?=
 =?utf-8?B?YlpUOGtGdHVNOHZzNmxLQnZKeEhWbmJDcWdBenNiQU1UbUw5eXFrVUNzeWtC?=
 =?utf-8?B?bE03cXgzc3k2bzVHZUczQzN0T1NwbGZpOSszdDE0Q1J1K051L3VzU3RNaVVM?=
 =?utf-8?B?Y3pJWGx0cWhENEEzOG9hT2tGVllreUgrSThrSGxjbEgvTS9DQXUwS1RudHdz?=
 =?utf-8?B?UDZlZ2diaUR6WC94WnVpRXdId2VrcFA1WDdJR1BhWWprak5qOEhxai80Tkth?=
 =?utf-8?B?OHA0QUhXb21mV1ZBMXk1WllIajBTZ2tVNitEeTVGN0Y1OEtFVlF3ZjFPR3Vj?=
 =?utf-8?B?THZuVDVZU05ZSURibk92VWxwbm9mRVo3M1lOc1RhY2ZJdkQ4dVYreDJsdHRT?=
 =?utf-8?Q?hrzYFBpcU/kHf7zap6D2qdPkY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2234768-38f6-497c-1de2-08da9678fc52
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 17:46:00.1390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tws9jtIv0OU2S0UzgiGHrqEtK0LTJ81WPWewPpQGkea6g2vy7zrxZ5XtRQu1it3xybhAVouvl0UbiaxzFEwog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

Am 2022-09-14 um 12:08 schrieb Philip Yang:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
>   3 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 59cac347baa3..20cfc8c9635b 100644
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
> @@ -2223,6 +2226,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	flush_work(&vm->pt_free_work);
> +
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
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
> index 88de9f0d4728..c16579471f22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -641,6 +641,27 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
> +	spin_lock(&vm->pt_free_lock);
> +	list_splice_init(&vm->pt_freed, &pt_freed);
> +	spin_unlock(&vm->pt_free_lock);
> +
> +	// flush_work in amdgpu_vm_fini ensure vm->root.bo is valid
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
> @@ -652,11 +673,24 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
> +		spin_lock(&vm->pt_free_lock);
> +		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> +			list_move(&entry->vm_status, &vm->pt_freed);
> +
> +		if (start)
> +			list_move(&start->entry->vm_status, &vm->pt_freed);
> +		spin_unlock(&vm->pt_free_lock);

Question for Christian: list_move will take the entry off another 
vm_status list (evicted, idle, invalidated, relocated). I don't think 
this is safe without holding a reservation lock in most cases. Since the 
point here is to maintain a list of PTs to be freed without locking a 
reservation, is the vm_status really the right way to do this?

Regards,
   Felix


> +		schedule_work(&vm->pt_free_work);
> +		return;
> +	}
> +
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>   		amdgpu_vm_pt_free(entry);
>   
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
