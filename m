Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93680CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210F210E8F7;
	Tue, 16 Jun 2026 08:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LVmQQVWk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363F310E927
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxoO/kwzjFkXKWZ0b4tQWiTWFH3u1/vN5J390ritcCPm2wjOgE1ZRw8SAXDW/xzOAGPgoddhU0lK3vlSA4QJdAD6TTLKXmgOHugny2KnsXmu/DFGu3V7VgfETvNrDzoLCNobbNRCXfBUD/MTgBD9i0wOx6EBdJuoAI3QVXA6oAZ721c1w7JD3HMp2bGqgUv8BKVJ2pOtW4V7pkAYJON6QSfA81FjCV5vx02nIhw3D89LDEyP4C8mVIS6fYpw3YevWL87Of5MpvIMKVjjsyb6A/WsuwnQhcitwkwraTmky8dknOP9/ua3cqFuQgMqpwuMBfiKMl/uXEJ2F1ArP+RO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYoqcSQ8Nw9JbtTyVJF92ES6wAT/IDtT4N3jrCyGLB8=;
 b=UrFxEp3LIKn5A+OZfW2FBpp7IjYx8PIFnS5bZMC3QExwKGzR7LfV5h3HZWkY/MxiK0MbekKdPMW6epmIPEITAertfotxDGv0LQBKu3tYDgjUTk1+/KJG9V2KA9VZlUrnvE7kaJsX5o/oO4tkDcV+INJ292HPjMtwDgylbiKxGVp9Tbk3qZ2JrLX/g4kvcYVES7tOoCtcaz6r/SL56wGLnlTq3EKnoj1Brte8VCeI5Fo4cew8m7cRjIT8EDfCZ8l9dkk7T09iOU0tCMzyEiX/9hvjcmvSHr+Kxkb6u3qHBybiYg3YvNvVoW+enXmv3+kiCnTyif3vSuifEBLPPS7dCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYoqcSQ8Nw9JbtTyVJF92ES6wAT/IDtT4N3jrCyGLB8=;
 b=LVmQQVWktvSg6VauE9BkK7ppEJoWU1KYRJ1jL/nZ2uOtuvm8/mNXjRkMxGSKRnpuKpMPzYK/uWSsnHwk4Z9F6vn4I8pK09GfiAZAYW6xdaGG39agzSX/BBPd6M90Ie2HbQVCtkWz/rUUqwby+J6VpidtG/56SvQ/1fBHKG2kvuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 08:33:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 08:33:56 +0000
Message-ID: <df020cb1-0612-4b5a-a7d2-154ca1b771f1@amd.com>
Date: Tue, 16 Jun 2026 10:33:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: clean up discovery and preempt sysfs
 entries on shutdown
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:256::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e287bd2-8d12-44ce-5383-08decb820156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: AX+iVky4rM0fDvZFc5EFnxnV5AnJDGe+TrJ9TwIZJFjjoGse0Mhq4aX9Zj3ZWfYT2/Vi0ZPcSpCVFL//oP0s+GQ6F+b7LqwHcyRjqYYXIhqJODms6A8Wq//Y+q11/kJ4TTNQYU8leRUK6g4tlRQ3FKPdGLjjopR/+VgAtAy7sHCmwcwHFov0aro+v21NWyqVRMdDss8beO8xDP7L5+/lcKLzhgb3nJeeamVG/lK7vjeWALmZit6VmcZxUsB/tJkvRB+0WL/j1WX3Y9cC7YqQjaXHVzLWRyUc5nPBGH8dBkJlerYO7tKsm4JqCBK4jLF6QULDO5NSOT0cguvKUmQ4iSGt8OndsqSo5Gj5ojoPhvZNroUf3E8cXiDemZE6viAgZgdVbVg92sc/0tXkiyLLZLyi7DpJSLOsggU3zt/jRIIFNdd96Fn8Za4O3ys9EzQXK3sQ/WmdSwYDUE8Ci4hwZ0V075+pcyFIW4IChp3aEV3plKRT1FVs2G3fX9cKHe86dP431CerOpTIja6pwtAzpfUt9kWiDHaDW3jWFoTRv6IQ55iQdjrkSI/bKARWSnQWk7CW7X9KErBaPLq9h2oGtuSe4VcLipwtbnfFtFnKo0XcYk5vIg9NH+QQcXAH24cIGXC5Xz3r/qeDYOTsF/yIfMm7i7zF3obkRyTkI9y1hzAgCXABYYKK1y/esaGLY4b4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFVLZU9JN0hORm1DVzArbXFqWldtWDhaYk5XQSt2OWZCWnFQT1ZkbnFYZG85?=
 =?utf-8?B?VG8ydFdmcE1vYnNFUDRNcGdKVEpqQVc4Y1NqTWs3RVVESkUybWF1eVBmU0Vl?=
 =?utf-8?B?ZVRSdGZXSVc5MmppNnF1U2dwbFJrZ29DNnBkWlErenltaHJUR3JBRVFZZFhk?=
 =?utf-8?B?Y1puMGViWFk4T2lrNUFLWjF2YnExdE5NWU9DS1JVRktHdUowN3pTemkyMFM4?=
 =?utf-8?B?ejRTTURYSEtrNlNuUjFVcTRJWFN2VFg4VjcvQXB0VFpkd0c1dVFrSmRWVy9j?=
 =?utf-8?B?QUlwTkJ0c1JneVk2ZFVGcGczZmNmUkovNFJHZUhMU0lNTTg5WnpOKzUwb2Mx?=
 =?utf-8?B?T0FqN1VyZ3dFZ1NWYm9qUlNmc2t6TjRWTE5UdFpmZ3hRUHFyaGxwVzN3RVFz?=
 =?utf-8?B?TngxRGR4aFB6b3RId2VZeHhlZHRiTlpOREl4azF1ZzhreDFlZ08wWm84SUg0?=
 =?utf-8?B?bWFMR0RiYXZ2cTcwcjRnWTF2U0dpT2NTQlRjK2hhV0E3d1ZuUklIazZGQVpW?=
 =?utf-8?B?c20wcGhMM2l6ZXA0cHQ2ZEpHZ1AwUTd0V1BHcldwRUovdWRMMmlCKy9tQjkr?=
 =?utf-8?B?VU8ydzZ6SHd3Q0NtSGhrRDNzbHFwM25IT2l4SmxhVzZDWk92UlI2eGpCSTE1?=
 =?utf-8?B?MWxwSWtRaXZjQkY4RVIyRmV1VFRMdCt6Y0NqS1FxOGxIV05xVW05V3FCK3FB?=
 =?utf-8?B?Vk5vai8xN3ZSZEpRbmtoZlB6OGhvUzF6VGVId1dNQXYzeFhEdGhJck13eWds?=
 =?utf-8?B?ZEpUa2FCMERTZmkzQmVGaWNGTjZvK0pLb3hyV2U2VVppTFhKRU9GaS9RL1hE?=
 =?utf-8?B?bTBwN2xjcmNoV1RkZEtsclNsSDdnanZWV1JzVHpUckY0UEloQlZLTUxNUUl4?=
 =?utf-8?B?NDhrbENvR004SFdPLy96OHRjREZuZElqZitsMmNTaldHM01HamVUazhBMjhF?=
 =?utf-8?B?WHJRUVFtRGZ0Mkp1TW9sZzcwaVBSTEhXcmw1Nk9qMDNOenNHRyszTmZUZ1RC?=
 =?utf-8?B?NDR2Zk5mMlpCSUVKWVhlZ2FkSnFHK2RrTFRPdzJXMHhDaFl5VU5GVmhLVmo3?=
 =?utf-8?B?MS9aK1ZtU1JsdGdHeG5FOXlJeU1EMUs2RVZjTTlpK2hTc09UMlBVajBtQ1FX?=
 =?utf-8?B?bERVcU9qTmN2RzFtdFJ3SEJZajZEWWRBMzNiV2pZTGorVDJ2MS80MWdTdVFM?=
 =?utf-8?B?cFRIRHdCZnhRVlhyS3ZySGVwY1h6aHNFdzB1czhtRkxPMks5SWlhdHB2RFgr?=
 =?utf-8?B?Ry82NVFSOTZ1bkpzNnVrYUJUeXBiWlAvVXFoMEpWOWg2MGZqS2NqYjJoY1Fl?=
 =?utf-8?B?UVRQSjBUZy9Vajg1NHZNTVZEUlBLWmI5a1hTdnAvNDN4citpMUkxQTVHS1dn?=
 =?utf-8?B?YUpXQmp6SUJGQ0gvTWJESEpKSnc1WWJOaE04YTRMeFZiSFhTOUtmencraWJi?=
 =?utf-8?B?aUQrcXBTT2E2MEYzM0V0VEhYNGR2TGtUVlJqSy9QbUR6NlZXTE92enpkUERh?=
 =?utf-8?B?ekNpYXFybUh0Rkl2dDcvV3plUzhxTE8xV0JNMzdLMDhpRGlYTkc1L1V3dUpT?=
 =?utf-8?B?SWMzeDRHd1F6Mjh5bU9UclRjMk9VMlZkbmJXditqSmREL2ZHazFFMVZleGtE?=
 =?utf-8?B?TEpRN21iMXJiREh3MWpjZnA4dEhaa1NJWUliMER5MmVlZXpMaUpabXVEeGdM?=
 =?utf-8?B?TjVDQXg3c1JOdmdHcjZTYXJaVHFvVy9RenZ5Ykp3bStEdW1yd2FEM0haTlpz?=
 =?utf-8?B?SzlGY1FoUzlSU1BOS04reWVSNzI5bU1kOUZHTE5wM0pBNU43Sm55SmlIczRz?=
 =?utf-8?B?ZXpabXJua3p4dnRHUzZwTWxRWjJQZWIrVGNra1U4bi9iQjZpSDlFdy91eVAv?=
 =?utf-8?B?TnRVTjV0UWVhaTZteVpjOGpyRmRTK0poUGQweTZlL0VnS3hFTFNGMDdDc21P?=
 =?utf-8?B?Ynl5cFhUczE4YWg4NTZCN281SlUzeFNsK0VRRGpoVTFPM2tFbFVHVXZ0d0lm?=
 =?utf-8?B?S2xydUhZNFpSbFFzWHozaTFuZDQ1d2dGR1NVM29KYzlmZEpEOXJ3KzhhNitz?=
 =?utf-8?B?T2xnbHkzRDYzYkRSMzExbVhUTW5sZkRFR2pkT2FmTjRRVXRVaGVQSDFDVG14?=
 =?utf-8?B?ZXJIaGYvVDdyVHhCdDdBbjEwb2VLUTlpcFVCUzJRK2p1dUVBcHFnUUkxZXZO?=
 =?utf-8?B?c29LYjI4c0lxUFVuUHZzeEF0MzRPSzk2djcwTEkvMEt6NDkyd3NFT1k1Ykt6?=
 =?utf-8?B?cHcycDNVaTBYKzRoNTZJa0hnVVFoRm90YTlQMGJhb0tQV2IyNzdpVUhRY1lz?=
 =?utf-8?Q?6PC76TkDLFTwubxZYG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e287bd2-8d12-44ce-5383-08decb820156
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:33:56.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrPA/hu3vHf97i1Zo45r3K7qYGiWyoR8mYJFD0i2B703EKcychXsTu4l+ZjdyUAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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

On 6/1/26 07:05, Geoffrey McRae wrote:
> Fix a sysfs duplication error when reinitializing the device:
> 
>   sysfs: cannot create duplicate filename '.../ip_discovery'
>   kobject_add_internal failed for ip_discovery with -EEXIST
>   ...
>   Failed to create device file mem_info_preempt_used (-17)
> 
> The failure is caused by stale sysfs entries not being removed during
> device teardown, leading to -EEXIST when the driver is reprobed. In
> particular:
> 
> - amdgpu_discovery sysfs kobjects were not fully torn down early enough,
>   and ip_top remained non-NULL after cleanup
> - the preempt manager sysfs attribute was removed only conditionally
>   and not during the common hw fini path
> 
> Fix this by:
> - calling amdgpu_discovery_sysfs_fini() and
>   amdgpu_preempt_mgr_sysfs_fini() from amdgpu_device_fini_hw()
> - making amdgpu_discovery_sysfs_fini() externally visible and clearing
>   adev->discovery.ip_top to prevent reuse
> - centralizing preempt sysfs removal into a helper and reusing it from
>   both fini paths
> 
> This ensures sysfs state is fully cleaned up before reprobe and avoids
> duplicate kobject/file creation.
> 
> Change-Id: Ib91bf9eac4a1901c05bdb17b20de3e4122323b34
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c   |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 14 ++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h         |  1 +
>  5 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff224163bab..ef5cc4997656 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4200,6 +4200,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  
>  	if (adev->mman.initialized)
>  		drain_workqueue(adev->mman.bdev.wq);
> +
> +	amdgpu_discovery_sysfs_fini(adev);
> +	amdgpu_preempt_mgr_sysfs_fini(adev);
> +

That should probably rather be in amdgpu_device_sys_interface_fini()

>  	adev->shutdown = true;
>  
>  	unregister_pm_notifier(&adev->pm_nb);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 7c2212985273..a2ae26bb11ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -704,8 +704,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> -static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
> -
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
>  	amdgpu_discovery_sysfs_fini(adev);
> @@ -1391,7 +1389,7 @@ static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
>  	kobject_put(&ip_die_entry->ip_kset.kobj);
>  }
>  
> -static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
> +void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  {
>  	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
>  	struct list_head *el, *tmp;
> @@ -1400,6 +1398,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  	if (!ip_top)
>  		return;
>  
> +	adev->discovery.ip_top = NULL;
>  	die_kset = &ip_top->die_kset;
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index e0010f6a3eda..cff33ab2cb25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -41,6 +41,7 @@ struct amdgpu_discovery_info {
>  	bool reserve_tmr;
>  };
>  
> +void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index 34b5e22b44e5..eab81206c050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -46,6 +46,17 @@ static ssize_t mem_info_preempt_used_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(mem_info_preempt_used);
>  
> +/**
> + * amdgpu_preempt_mgr_sysfs_fini - remove PREEMPT manager sysfs attributes
> + *
> + * @adev: amdgpu_device pointer
> + */
> +void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev)
> +{
> +	if (adev->dev->kobj.sd)
> +		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +}
> +
>  /**
>   * amdgpu_preempt_mgr_new - allocate a new node
>   *
> @@ -137,8 +148,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>  	if (ret)
>  		return;
>  
> -	if (adev->dev->kobj.sd)
> -		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +	amdgpu_preempt_mgr_sysfs_fini(adev);

That looks superflous now.

Regards,
Christian.

>  
>  	ttm_resource_manager_cleanup(man);
>  	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2d72fa217274..00acec7226f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,6 +140,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);
>  void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);
>  int amdgpu_preempt_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev);
> +void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev);
>  int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  

