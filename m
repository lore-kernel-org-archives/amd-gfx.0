Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD65103E160
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA84110E7C4;
	Wed, 18 Mar 2026 10:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/D6uRKa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDA110E7C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIw2CDjW/cEejRIQmG2AJCT7QZ+6UsnRKGOHX+T4aBNDRUGg8RkaFVPLhP9ebHZ3e+zTZfSiC3XoMVbkmYjqG2I8d8DOuYnWagwoO5W/rYxbPHkCfuMq77jEy0T0p+sMJNihpNPEQqZhoANhYP/XwuHo9Sr7aQrruAaJvv5FFkSTV4iDErNjkyLzHL7oDM4Raslzd7Nk+Rg5nw8tPi23zT5q2/os2jx9DJIpL1IATqUd4L/6yTXAUy0hM8o2XlZ15MGFbPZVmZP3eJbT7lQX+qYkNfcQDCbtphgSWKqw/4rh46aZcFtoi9gPc1vi+b92S/b7r+Jayv4+gLBWfYOQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOJdD4l8FPgGbVylNlvmtcY4SO3wFKktQ0czBdT7gw8=;
 b=J1Ww//ACDDtwmBBEOmcGVDZ1+s73ACkGL+HJXMR3cW6QXkjZgY5THf/+Ip4UKbyRG6eSBFfoOLAvH6fhJAT9AEyc/2tZll7BN7Rx3n+9QH6iwF+JRif+MPynTq53i8mdDV/7JssP/Yntj67OjOgUzdur0r3Ibmp/Mm0swik4QakG+gvbu55iap96axOcFtsejCe8cCgNwrCClGc+Ob4T6IsuqlMuifSCyrDSliT6ThFUYSjgWrP+uPpt6u46fXVaio9cKnfgcefygm3gdcEP4Jf8XImqKFaROCmdNFIIyRXDvS64vZXoenDMmY57xGd9mTlIOAsA79VUYqF/GVNZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOJdD4l8FPgGbVylNlvmtcY4SO3wFKktQ0czBdT7gw8=;
 b=y/D6uRKaQzL3i0LEhrXhdwFtRZyjZXUlXmgfhfA4YY2LXjC5SlVoroAslSwzMWaVBlHwMNSNsHa3sizJwtC30EEZX0O3SJCoDjd1VNnotg0F2bsEgiPLisQy1ecGhR86kstPaRoJWQz/Iifbcfbt7PcGElkdqWCvOeSu4ZJnxec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 10:58:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:58:00 +0000
Message-ID: <edc9d882-76f3-4d1a-a9a5-698752984716@amd.com>
Date: Wed, 18 Mar 2026 16:27:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: e5603bd6-cb95-49ce-ce52-08de84dd384d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Q4Ffj3pXWiknqcxk2+R+vH9ve3T0K3XI5KzRTK8VuL2UU82uLQYnBHrDZzNBAgcBztWQQymVVmdlj8f429XiSGmE5zKYeyNWkxvmv2Tq2WU5HEJ3xGUPhQLgcUJ7bDne4y3j/NZWwIfPro8RRaRIdnYbUrRxW9yDfDGsFnfmx+LIJycBgwhDAiYqG82LXZ9Uy0AcjJNybag1vsyl0LV+u/SKjx9g1Bueyto5lWpTeLlcjIMV3L14+hHKBn28Sz3LGKa+Y7KLNtl9nsiV2sDc/8bB31h+L4BAaR1q57V71u9J5d1UpyCtiD7TLMme8hsqR5nbEGZaup30H/aTyOXxbgVMag548zrHmyIgaitq/9givm9OARu59KoCkburLgOWIl1Z08xfnOXdSFW3kD3hC3vyiNNM4Swvy7AyRsvditKBughi1TwJXca/U4s/R4oDaT+tmeMJr51d/VsWVhK1vNpg4OO4IjIWi65DDfO/L1yJpbFVX8lDVVALk2jdXOD1RZptIiArDRrK7MzYcgoOUN9nlHCYbzNQS/CoGNDa/OAyZWmPH/sJ6RJvKU7vsOAez+EwIzJZnYWGhpSpSgaWcXAqS2xTaighwY2LS5hJvH1pGYSSVnvrX+2AzXtSuysqK4VmlsFeiFca8FytvXCApyrplr1N6W9064leHCKIwlJ0zv9ZKhZqLzaJdW7lSU+zUAQBUO61asPdKDa/mENlwRR/Pg5dZzQI6NioZSZ4iPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JuZ1FvWlMweEluVjBiSXk4MnR6UzRQbXZGU3Q5Vlh3T0VrS2FodWJKK0hP?=
 =?utf-8?B?elBCekpKdUdYNjBOSFBBalVhbC9KamI4MFp3dldyYml1MVRLL1MwVHdYRHNv?=
 =?utf-8?B?VzVyQmQyVFVqNENjRndjU0lBTlZlWk5vdHlPNmRJMEpoaEhabk43OFBzYUY3?=
 =?utf-8?B?QzR1ckdQNndMb0xDK0hWUXpTWDRqQk10Nk5MV0xNdnRhd1FJUWhQZmc0UGdQ?=
 =?utf-8?B?MFlLelZ0Um4yRjlaYnJIQ2dTaFdaUUhad3BVMm11L3ZLSGR0TFJ6LzBTVlN1?=
 =?utf-8?B?T25YV2x2SmxsV0dxVVVLWnh1QngvdG1TeXc3K0dRNVNjbExndjA0TG1pSitQ?=
 =?utf-8?B?ZVdkUGt6Umt4WE1IcGF6NWs1cmEzSjBZbHBTSWlkU1ZDYmlzT1JqbGNHVGsz?=
 =?utf-8?B?MGkreXVLa1Y5QU5LSG92MUdiUXRpaXB2K1VWWjFwZ1lQeFZ2VUJRcy8xTFlG?=
 =?utf-8?B?eUI3aG1iSGdwcXhiWVhvSE5qMnN0aHIwcTcyUXpESXp4SkFvaC93MGt6OHdv?=
 =?utf-8?B?Tmg3T1N1c3ZqVFVkK1pnR2xndzQ5TWRsQ3ZPZ0ZXZVArc3JGRWkyR0tkUlVk?=
 =?utf-8?B?eHpqNWl1YTJGd0lCcnkvZ090U2RHZm5LZFNjQnVEM2VlU1hXQklhTmNlcFZh?=
 =?utf-8?B?NXlkb1E2Q3Q5aWV0TGg4RVVvcUFhdzJvQ21lTlNmNkxXbU4vRUFlQzc3VWdv?=
 =?utf-8?B?dkR2bjNrU1RZQ0hsd3IwTXYzL2QvclJRSnFHeG5HUXZYNWJIMnZuRU9kdWk5?=
 =?utf-8?B?WTEzWGcvcFovczZFM0FueEZEZ1NNekVxY3FwbTFVMEZUTWJhaTYxaGxyNmx0?=
 =?utf-8?B?RmFvQnM4UDU5RjhkZ1BmcGN6NUprRklUYzZWRHlZaVVaWUdaZlhDelBoamIr?=
 =?utf-8?B?MGV6ZHdWeDJ6U3dqYXpTKzNuYllwbWdYa1NmNXRac0lTWGwweWNicDFlUC9n?=
 =?utf-8?B?RmhCN3NtN3lIMUpTOEhPTklzQkV4ZWQ2UmplYVV3WDQ0UmRIZ0xlZWlwWFVa?=
 =?utf-8?B?UVZ5bEtNcTdMaEk2ZXJCVVVwRllRZDNSR1dwdWxJQXd4dkRGUy9mNXNRTFJG?=
 =?utf-8?B?cE9kUHFiaFFqY1NlOXdBMHlkalhzZ0NOdHJRS0RYNGxYa1RWdERHRjNqVmxX?=
 =?utf-8?B?L2JFekNlbmlNTHJuNjFpRHdQMFY5WmUxVUd2dmIxQWRyc0ROMHhBVHZBQVpJ?=
 =?utf-8?B?bkhteHV3bVE1TldsOS8wUi9GMEJBenFMQmdCM3djV0tXSyt3d2pQcU4yS0lj?=
 =?utf-8?B?YVZ6QkN1Vm1tSkptY3ZhbTBCWlMxUkNrS1dBUGU3OVJUNnJhcHBGeGVJWVp0?=
 =?utf-8?B?OXo4bitra2xaNUJDTVdRWTlFbTdYREpyQzZXdFdXRlN6WnBXOWRub0F6ejRG?=
 =?utf-8?B?dEw4WEJVNkNYMGpvVm42dXpMWkJBN3ZyalpXbjI3dERjd1VJaXIvNjdFajFF?=
 =?utf-8?B?MWZ0VEE2NWdobkgzeG0zWTg4Uzh3WmlDN2pxUHFZYjhGdUtEbnREY3Y1ajBL?=
 =?utf-8?B?WVZlTk5DN2pLUnZQUk1rNFc1RUFBQUdhRFRsMW16UStCUGdTTnVKcWttSXdZ?=
 =?utf-8?B?enpDalV5aWxRdU1KRC96dnRxZ3JaVmFDbkJOM0RNVlQ0UWMvaUdPWXUzc0k0?=
 =?utf-8?B?SkliUUxLa3Baak5id21tbzMveFFRQTZ0Ykc3ZTBnUUhTZU8xQVEyV1NzUmh3?=
 =?utf-8?B?WDNmemROMnFXbHZhMmxyN050UFdJQlIxOStleTczZjI1ZDVKTHRiSnpkdUgw?=
 =?utf-8?B?bm5mdVVQb0N3ZGJqdW5kMDU3dUpoSzQ5TS9JT0tWMmhDUHB5dUZtSVV5SzRl?=
 =?utf-8?B?NXFrUDRaN3VHZXp6QUgydms1R1dMTFV4aXhKVy9oR1Y4YXlFVktocG1kRVNW?=
 =?utf-8?B?aXR3KzJzT2pCWDFNNkNaOVJJRmNPbWt6R1p1eXZWZUsvS0VycW43MjRVb2kw?=
 =?utf-8?B?cDB2djExSi9XSXloNXluVnBMUW9SRjljRys2ZnZHQk5TVUtIeWM5dWl6cG5K?=
 =?utf-8?B?MmRpL3U5N1JiTkVJaE1BZnV3KzJMSDJwa2lQbVJYZi9ITmswdHZMdkV6TXdW?=
 =?utf-8?B?a3FPcERNaUx4M2dVZlMxR0pVNGViRFNOLzVPV2hwOEdTcWNkdFdsOVVtelp2?=
 =?utf-8?B?QkJvNCt1MVBHWFEvRDZ1WjFmS2lwckY0VW5McUFPM3hjVUwraXAybVdUbmE5?=
 =?utf-8?B?QVpocVEzMHdQNzlYdEdxZjNOa1Z6eGhyRFJZZmVRZXRsMnlkY3VYUExzd2Nn?=
 =?utf-8?B?UnI2WE1xcWkvQ0dQNkd4SnkrMUlQWDdRTHdyWFl1c0M2cUVhbkZjVVY4M2Z1?=
 =?utf-8?B?WmVNYzEzMEVmdnFMektvS05ybVIvb29DTlp4dkxVejZjbTNxa1FQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5603bd6-cb95-49ce-ce52-08de84dd384d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:58:00.4112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afZcXld3gQ0Pb3AbDkz7cKNVk6PrSL3bK/i20hreS+NTIkfdrr9LtVWOjd/8Eifw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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



On 18-Mar-26 4:00 PM, Srinivasan Shanmugam wrote:
> When a GPU fault or timeout happens, the driver creates a devcoredump
> to collect debug information.
> 
> During this, amdgpu_devcoredump_format() calls
> amdgpu_discovery_dump() to print IP discovery data.
> 
> amdgpu_discovery_dump() uses:
>    adev->discovery.ip_top
> 
> and then accesses:
>    ip_top->die_kset
> 
> amdgpu_discovery_dump() uses adev->discovery.ip_top. However,
> ip_top may be NULL if the discovery topology was never initialized.
> 
> The current code does not check for this before using ip_top. As a
> result, when ip_top is NULL, the coredump worker crashes while taking
> the spinlock for ip_top->die_kset.
> 
> Fix this by checking for a missing ip_top before walking the discovery
> topology. If it is unavailable, print a short message in the dump and
> return safely.
> 
> - If ip_top is NULL, print a message and skip the dump
> - Also add the same check in the cleanup path
> 
> This makes the coredump and cleanup paths safe even when the
> discovery topology is not available.
> 
> KASAN trace:
> [  522.228252] [IGT] amd_deadlock: starting subtest amdgpu-deadlock-sdma
> [  522.240681] [IGT] amd_deadlock: starting dynamic subtest amdgpu-deadlock-sdma
> 
> ...
> 
> [  522.952317] Write of size 4 at addr 0000000000000050 by task kworker/u129:5/5434
> [  522.937526] BUG: KASAN: null-ptr-deref in _raw_spin_lock+0x66/0xc0
> [  522.967659] Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
> 
> ...
> 
> [  522.969445] Call Trace:
> [  522.969508]  _raw_spin_lock+0x66/0xc0
> [  522.969518]  ? __pfx__raw_spin_lock+0x10/0x10
> [  522.969534]  amdgpu_discovery_dump+0x61/0x530 [amdgpu]
> [  522.971346]  ? pick_next_task_fair+0x3f6/0x1c60
> [  522.971363]  amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu]
> [  522.973188]  ? __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu]
> [  522.975012]  ? psi_task_switch+0x2b5/0x9b0
> [  522.975027]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
> [  522.975198]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
> [  522.975366]  ? __schedule+0x113c/0x38d0
> [  522.975381]  amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]
> 
> v2: Updated commit message - Clarified that ip_top is not freed, it can
>      just be NULL if discovery was not initialized. (Christian/Lijo)
> 
> v3: Removed the extra drm_warn() for sysfs init failure as sysfs already
>      reports errors. (Christian)
> 
> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in devcoredump")
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f7f37d93d0ce..6be1f971a31a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>   	struct list_head *el, *tmp;
>   	struct kset *die_kset;
>   
> +	if (!ip_top)
> +		return;
> +
>   	die_kset = &ip_top->die_kset;
>   	spin_lock(&die_kset->list_lock);
>   	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> @@ -1419,9 +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
>   	struct ip_hw_instance *ip_inst;
>   	int i = 0, j;
>   
> +	drm_printf(p, "\nHW IP Discovery\n");
> +
> +	if (!ip_top) {
> +		drm_printf(p, "ip discovery topology unavailable\n");

Is this type of printing really required or just skipping the whole 
section good enough?

Thanks,
Lijo

> +		return;
> +	}
> +
>   	die_kset = &ip_top->die_kset;
>   
> -	drm_printf(p, "\nHW IP Discovery\n");
>   	spin_lock(&die_kset->list_lock);
>   	list_for_each(el_die, &die_kset->list) {
>   		drm_printf(p, "die %d\n", i++);

