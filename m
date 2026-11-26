Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D1606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sHNUZkO3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7B510E987;
	Thu, 26 Nov 2026 09:55:10 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC7110E987
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxGPLuXXCMe0s3HCwnPt/sLlqqTfBf872/3pHp8isEMExHmXgF7XX610D5h5TVvb4LWdbPBDylBz8N7IXTTv9XtJzBQzeSppEpxjCUx2Ji7P3LNlRXVQYIFcCwIMyLg4lyUuC4DrsYiQmkGXDCPHdL3TChKVIK598L1y54SCMBe+UZJikKwIFSpHFDDAKeL3gvl432oCcGVR/bLPBKSe3a5wJFAl5khZTIMkdUDUcty+Q4SF5rp1qac6wL54YPoJiibvFpnaQ9m7FyMXvgKht6NRHCeIzckmhNX/kyf0+efSz9/D+mg3DIU5ZJuR0VKm/a/2hms4TMz2xKu4DV85Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXrZXEKMw/4ErqI12rDY4mG8NfivxULeQXc4AUouA+o=;
 b=pONcmo3PS1TuYTGFNbCDhKtcCJjtP3ScQLGrJ1Xc6r3yjpyeJN81+xTPQA04kbS7oMspui/KOcoFE99XcTDHdO/zae7MWCamFtHlU/HQzJMeTuDsmzX+iUOSXLmZsb6RsidlyIUJ+EiXhDbVpNhELdE5/UWXo4tRfHfKcRGu/HPPBzLORs6pLjTeTBWevcv6Arh3vUy0iQqbpQrH5QxLzMNYnuw6PHX8XY17vhWx/Sj1KDlPgMuTdNYq02l14ADWOJWhKWUc1Cji/ubOn9VSyDY5Y8Arl4hpHlVLOhJehc7mKyTeP2k2ylCMYkTer3zCIi6YKYSNATlcPlaZTqeDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXrZXEKMw/4ErqI12rDY4mG8NfivxULeQXc4AUouA+o=;
 b=sHNUZkO35yqw9mCPqaz7H8S1Zc1btSZT3gNe0ImHd2B7ERkDaBhCzc2ZKIvH/C1kMFInyb+rHPiOYNC3K99y3HtR0r6IDN3d6iV9mv+XdeuuIYVkHR0cgqRg7FFbYH0vzyglKJencZmFsa1v0CxVzVq5w/58LBB2se85QLMBQqU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:55:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 09:55:01 +0000
Message-ID: <297a813c-987d-4290-ac0c-9b4e849a3a45@amd.com>
Date: Thu, 26 Nov 2026 10:54:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] drm/amdgpu: unlink userptr bo_vas under the
 notifier_lock
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261126021124.3809452-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126021124.3809452-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 5522ccbb-c833-4e2c-6d22-08df4ba35663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|261021121427099003|261022075727099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: UIdC4aRJl585ujF0rJCAVKzr9q7hN8hPYdwxM/16wfCgboJtXOVfvzA7aGjWQ4xmJOWoJWQ3lkv1Lp1WP0Eya3kuw966TtDNLOHwckj1DGupi6FoifZnpET5cIMPm6t7QCyhMBx35QpBg0ao6YmIJZH8cofy4zNpSW/vIQGeufpkb5pYvPcUJWS6yD9tm1hbq5f+Mjgiy9IWttUQTRktJKpCG7gNiH14W2WDkaZKqgR+7GW5eMqvzXkHuiyUFZK7rx1RmmZJ5lMCCoFQ6sOm7/6lQXu4LdWMJCnC5eNRa2WQSbiGdqZS4NZrrqQeuUZY3z7n0A/fJm/017pxiaGvUZ4fZObmr98r6V61PT9Qg+dZbb7McJhNElbY5YbtzmErFJ+IVwnRzy2r1Yf590r0PmLLNAZ3L4qYnuwvK6ccJy8EntHsyLESoVXmc4RKsjocxk8MH4oESSzAvO9JIaE6fWaQXKcW4GKXzpRLmukQDSyxoFVwcyTRYJU5dJx1x4SqH8o0kuGmO+v6SERNtKkSMnWac++ofsO3GvrdlzXmk2+bxfwcmMq3lV76WhrOC7GBBXlSFUgerptGg9KoWk3g2dBscheG0efeL0hFo4/8xNkz2d/qknrAfWWkRI+tykfHxlv+tG9sKnN9tiIa1Yr85CyycHQUjU54BUg5GP6zYXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkpmY0hEejhXSExXV0NjWXkxelRISDcyLytWbSthUnVuRnBxbzMxZ0diUElH?=
 =?utf-8?B?c0ZIOVdKOWFQbDZUY09HbnZCRjlXYWFIN3NINk5GRUpXSjBJUHdDYjNxNVNk?=
 =?utf-8?B?eVRJUVRBYWF3eHd2Q2lJZElMVFFQNkdGTWhzeEJVd3R5SDJMaDh0Z3lwR1BR?=
 =?utf-8?B?a2xGc0dpeThxenZhZmdjZGpYcmNJeHBiYzBrWDY5RTk0b2llaFVMUG9HU1pT?=
 =?utf-8?B?WXZvME1PNGdJVG9NQ1JCY2kxUkFralRVaUZrRzNOcUxkT3MrUTNFeTlURjg1?=
 =?utf-8?B?ZnpHd0MvYm45YmViWVhHNmMxazFYb3JxOTBrU29CVUdPdFM4ZzA0Q3N6OWow?=
 =?utf-8?B?UUNTVWR2eHIyb3JPUWxFdG85T3crSVU5dkNOUEZ5b1hVRTd2MmlaRXQxMDlz?=
 =?utf-8?B?YnR6dDJ6Mm5kYml0L3NaQVBjdHcwaUkyODk0SVFPWXI1MjUwV3k2NUVOVzJY?=
 =?utf-8?B?RDMveFJCY0JYUnJLL1JmN3BtSTVja2JsS1Rla0pOZXZkSnBxUnNzWmFrcFU1?=
 =?utf-8?B?aHcyQkUvdVNNcy9IUEQ4R21yTnozY3VTWHA5SUlsSU9DckhFRzFvNHNNcnQ1?=
 =?utf-8?B?Rjg5SmY4MlJpaGdxOWpNWHlNcmpzeFVrcm1lemp3UU9TZnFGdTVOK2VGUTg1?=
 =?utf-8?B?SHMrOS83cGlFNzR3NG5KUDNBVUNLTGF4anZ0L1Q0d0hRZm55S3RYMjFFRStk?=
 =?utf-8?B?OGdlVHlLUlZBV3JlVlJZS1JIQUF0d0lPaHQ5Zmt0RjhyUjc4ejh6UEorcVdU?=
 =?utf-8?B?WnJNUldzdWJzUkgxdE1zTHlCMGZPc0kwR2ZlSEpGdWFzUjlzbzIxbENXUGVD?=
 =?utf-8?B?MUJySzdMeTVaNU9Sc1JaNWVaeWY3eFV1bzhFSTRobEdTWVJFUmtVOU1JZ0Zr?=
 =?utf-8?B?bnRYcGVWUUdoQlpCT0JlejcrUnR2MXdZV2F6RFFJRHBDSHlYcnlRcGR0cyt2?=
 =?utf-8?B?TVRLdkE5dndGL2F6VWwyVFd5UlJiQTUzdHFIbzY3L3p6ZzZWZDdPSnVmUGJI?=
 =?utf-8?B?aEVJa2J4dDNOMThsUWNMZGVnTWg1ZXJXMm9oN3NOUk9vUGg2dnFuSUd5TjB0?=
 =?utf-8?B?RTZuRE1YemQ3eWZNb2R5WGU4TUZhalZnUmgweCsrckFvVHplTW5SZHlIMzJZ?=
 =?utf-8?B?eHRkYUNRMWNBQllibmNkZmxEUWZhZGpNTXBsSGdzcGcrTWJ5cmZtTE0vdkts?=
 =?utf-8?B?RDBXbERGV3kvaWQwR0pLREl4TnVsZ0N1U3hTS04wNHhsY1RKNFc2bldvUmNN?=
 =?utf-8?B?OVhUY2FlTXk3d25YT1VUbzdVR1FYS3RDTkRtMVNrRnNyUzQwNEJtVGY4blNi?=
 =?utf-8?B?L2JwUWZnTklVMmlzWkVaUE1HRDZtSlgxYldyaEUycUNvcEx1VVdxT29xUHRU?=
 =?utf-8?B?YjExaU1CNHdQQzNhSXNOWmlvb2tNWEw3R1VkbmtYeG42eHdFYWZBWDdwNVFp?=
 =?utf-8?B?RUROOUhwdXFhczZiY2h3V1ZXZnBReE5ock1NSFNPVVc2dksxUENrWGVVcU1M?=
 =?utf-8?B?THhLakszOExBWDFCZFVRVUpCUjg2dy9oUTBZeE1vNkpUNVFZcmxSdDcxSHNL?=
 =?utf-8?B?alVocGMxTlNrbzBncTNyVmlzUko1SXYyTnpUUTZTejVMWWljKzhIdU9BT2dP?=
 =?utf-8?B?WHR0aVpoeVVDSjZYaTA1cjV5TzZsL2VJQlowR0JIR1JYeURLQXRWMFJCNnhq?=
 =?utf-8?B?c0YydFV2Mk1ZQW5hVThSVWl4eG1XeXBCU0lZOWYrbjdMRDdTUk1POGhWaWRt?=
 =?utf-8?B?cXYxSVc3S2tVVzZYdVZORGVweWI4LytQZjdlWHJNTjArS25qUHdWMjFrUjNu?=
 =?utf-8?B?MFpDdWJHUjN1VXJRRDBkN1Z0em8xblMzRE9oMjVnNUl6ZmxjT09GRHZGaHdl?=
 =?utf-8?B?RFR3ZmplcnBjT1VaQXQ0TFRRWjROZ1E4Zkx0dDBuVUJUNkYvdFAwVkcyUnBI?=
 =?utf-8?B?Vll5V21wYStwcGgyWTY5c20rUkIvS0MvcW9nYUJRWFJVKzh4QjJxZWZiNitD?=
 =?utf-8?B?K1lXTFhJaDJvQ1hVY3ZXMVo1TzRqSzg5VTdnTHJ2Ukc5NHIrSTVKdmpiQ1M2?=
 =?utf-8?B?bWxPeHY5UW9VbWlycExqb2JXZ0xFV2Q3eVZaSnhEMnFlbDVPZ0RaZmNyeTBs?=
 =?utf-8?B?cThsdTRvdm55Ym1XNGhTSmJYNXJmU1RrZUxieFc4YWo3VDlYRHNpUnBqSUxN?=
 =?utf-8?B?WllKbUc4S1c4OGJHamRSdVo3V2dnWGh4QXVYV1VEZ0MwM1VSb0MwZzAvRXVT?=
 =?utf-8?B?N2VxalBHTlZudmlOcS9ITmlsV0JBdVQ5ZVplNXZlNGFGT3JCTTlxVURCNStj?=
 =?utf-8?Q?2T3qwwzP4+MG8tvhZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5522ccbb-c833-4e2c-6d22-08df4ba35663
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:55:01.2360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmZvo12wu1hN6kugwmAKsOCpkWDKbwKmP1k6sceYALRYsmCUld9OhcA/fOKsXfVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 03:11, Jesse Zhang wrote:
> The userptr MMU notifier walks bo->vm_bo under notifier_lock, but
> amdgpu_vm_bo_del() removes and frees entries with only the BO and VM
> reservations held. Concurrent invalidation can access a freed bo_va.
> 
> On Navi48, racing userptr BO close with MADV_DONTNEED triggers:
> 
>   BUG: KASAN: slab-use-after-free in amdgpu_vm_bo_needs_update
>    amdgpu_vm_bo_invalidate
>    amdgpu_hmm_invalidate_gfx
>    __mmu_notifier_invalidate_range_start
>    zap_vma_range_batched
>    madvise_vma_behavior
> 
>   Freed by:
>    kfree
>    amdgpu_vm_bo_del
>    amdgpu_gem_object_close
>    drm_gem_close_ioctl
> 
> Take notifier_lock when unlinking userptr bo_vas to serialize with
> the notifier.
> 
> Fixes: 1c824497d8ac ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea8672451d98..87b06daff892 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2279,10 +2279,18 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  
>  	if (bo) {
> +		/*
> +		 * The MMU notifier of a userptr walks bo->vm_bo under the
> +		 * notifier_lock, it can't take the BO reservation.
> +		 */
> +		bool userptr = amdgpu_ttm_tt_is_userptr(bo->tbo.ttm);
> +
>  		dma_resv_assert_held(bo->tbo.base.resv);
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo))
>  			ttm_bo_set_bulk_move(&bo->tbo, NULL);
>  
> +		if (userptr)
> +			mutex_lock(&adev->notifier_lock);
>  		for (base = &bo_va->base.bo->vm_bo; *base;
>  		     base = &(*base)->next) {
>  			if (*base != &bo_va->base)
> @@ -2292,6 +2300,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  			*base = bo_va->base.next;
>  			break;
>  		}
> +		if (userptr)
> +			mutex_unlock(&adev->notifier_lock);
>  	}
>  
>  	spin_lock(&vm->individual_lock);

