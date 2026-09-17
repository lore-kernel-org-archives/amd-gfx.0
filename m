Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FD2C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 07:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BEE10E636;
	Thu, 17 Sep 2026 07:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/TCPC8I";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5B410E636
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 07:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvSqoD9ds9JRTi0jglvnTEXnsCOtrTrQIfucLHjLfbpQu73AcwP/KeJjdoPxDoeLtDGmAfUTvOWgMJB7+D3L+Fp7kvWBWl+LjWOXqLU/clYyG473iOBzaEXA/u2wSQecVsvEe3huxh6ElkPErhswqLZEQ00H8gZcW88lMJeka2fCdXCgS9VtmoKNSfO5RT43FlsYVNnaoyRpPcCwEJWmODYJlsc3y1Kc+RKVYN8USQ0Bam0/E0u5H+hHPNtSM5njw2kxNiDLWQ40DdKcKY7+LhONdJ29tXEx5M6WMhkfKxVfOi499a/Y7qXMYVxg+Tglf5NK3O9UnpEcQKg1LmlxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma495E6GNkoZRa6SkA5/YUCtw16x4pWwGTwyNvdGAx4=;
 b=upltTd6jcIenJcAfOFuB95J7Z0g6ebtHbayvjIrUelc6/iZ2GfeMZ9OKUxZXpMe7dx9IXOnup03bWPvGHKBbdArSH3i71C5Bwc+67QSxIUyXvlmU+UODlmYnulwz/d6tggi2ZIyxwDfJtaGgL17NeJY9DRsLi3rVkfJiNvnN4WBW6BhtH+rf66mRO3xXwqLzGc46mBqXo4/OaQmVCM30FwzWvLFJ7Kfp09iditoxVtu7nAashtx5bIocK/EVCrURqfmv4pe3fdUKk6GHUT85CCE84b3IzlKCFOrpoSYAv36Q+IheE0n+ysP6LgIUk+BuTNefNjMdvFBJTlkWpJdnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma495E6GNkoZRa6SkA5/YUCtw16x4pWwGTwyNvdGAx4=;
 b=L/TCPC8IgkVAkUizuxutxHa/r7FNEWdA59c53HQGfGYBc1LfN4bcNanO2Kcygo5M4UUVyL5ndbfAZdKhkv30deJ5gXozCXxO1iDX9UxPpMASzWUtpXvqIT5qXX5T4NCSXxqSfsXaxa3gTjDjxW3IFh4ebliA9G/HItIxFz30kcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 07:39:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 07:39:37 +0000
Message-ID: <9352933c-a23e-46fb-819b-62c79b28906a@amd.com>
Date: Thu, 17 Sep 2026 09:39:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix recursive ww_mutex lock in
 amdgpu_trap_alloc
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20260915074245.457529-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260915074245.457529-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c12c011-0167-468f-2074-08df148ed380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4tkeK7FLF+4J/bFddKUVAbzsxIiuYIdBRCQJFjMSniBYh+j6xvJhOKu/Rj3jZkcT5+tXgbtN6HTpevMT8dgYdGe9deLetdh1+eKNgUpuoHYVDwf5kNl4xYYc9VC5dAVd2dwFj/0uBQWVbutR7qCROP2+do0RctuwKbUmA+TzEDS8dOECEjBGsKXMnAW/lnnEfsBslbsTCWM42Ojwp23sM8aC7iIGTH63N4+qLqGNIdGdbP1hxgFdA0PAzqfNnnfaElk5JF+gtHajOvRkSYLm/cbwmnfT3xdrMAdqlxkVR6fzYpS9li4/YOP6dnPpgpb6a3WCtXUGnsIk5LX58WhMxV9t5LdG5MLIvjY9SKhJjwLoPBHH2fajES2i2fdREnl9kl/YXdPKZISGn5XiFYoMj+XFjBUEEZM/UrAxnLAK/mzSe5Tl74Ev46RjS5dcCvKmh1/7pYA6gUCnklkE19l/wpj7HuU3w5HdwBjFkfQyrNJMp2toIPfFIsbj+ny0FmWw4WK/URXCsd9XceWWZ9jnXEmRECJwca7NecF+OfK4z90T3o8AQzNKdUrmnYO193JAbeRAOWhegChXreH4PdFt8nG8CElxxR8mV5CM/jCvB2Fb5UAlz1E8mxbXBZafhiFjZPbQOW+DMhJdsrAfyNJMUrbYPpNrHfmhqhvJnICogoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEoyRDJnYzEwa1hmU3pCWHNldHgyenRwYnVhOG1OYS9BaGN5a3NsZkFhVlZH?=
 =?utf-8?B?SmpXanRPaTlOb3N4djVZa210YmFPRFhUNjMwTzdyN3JqVVdLeVNkcnYyTlRz?=
 =?utf-8?B?THQxc2ZaVVBqSGVGVlh0a3R5Y0pWbEVUd2RMT1RlSHFVdnptaWlkWDRYOGcv?=
 =?utf-8?B?d1JPcmgrdDRTWnRneXd0Vy9qTWFwNjJiNFhNRFAxSjJtTCtaWDVXTzZyYVE4?=
 =?utf-8?B?M2JJY2hibisyaFlER01YT3REK3piMCtqTzU4SmpLa0JTWkpvRjZMcUduRnBE?=
 =?utf-8?B?N0pZVWZpbGlwb3ZpYjZib0srblJPMU5RV3dLQ3pQdkVkUUs2WDMrNkVCL2RZ?=
 =?utf-8?B?VnVOeUZiMEg5TGhCSjJJRVg1QXkxdXNFMGQzVEZuWkJINVU1UDdpZ3lsV1BQ?=
 =?utf-8?B?VlJXY1hrZUFPY0IySXlPTHoxWGFWL3FQYzFpRENrY29JL2l5WCt0RVYweEdv?=
 =?utf-8?B?MER1a00ydlRJUVpScjlCVzhBR2JjVXl1c0tXU3J6ZWcyd0NMbjZBbU9WLzZz?=
 =?utf-8?B?MHEwQzgwMko5Rk9kT2NmWlhIbE4vNnl3TWE3TDVLSzhVbFJaT1ZQTnVqRkpP?=
 =?utf-8?B?aXJlam5GU0pXZXB6ZURPek5MOE84RUtSeVczWWdSTXBIM1VjKzQwWS8vNEVn?=
 =?utf-8?B?Y1NzSWxvbDhmSkRBb01lNC9wN3NIM2lna1ZQMW5ydVFLUk4wZ0pCak1xVS94?=
 =?utf-8?B?d2ZuUjJETG1MMFgvRkk1RGU2L29QYW5BSm9SY2tJS3VKOUVSbFdzWGFDOXZp?=
 =?utf-8?B?WjZ5VlNkV0VyWUlIZkp4V3dxYUV1VTVpTXZkU3VrSW9La0dIRkdkNnFYcGkr?=
 =?utf-8?B?R3Rmb2JobWZqWDY4MUZSaitjNDZ2bGFKSXlBM3VZV20zeHlTSC9UM2Z5VzNK?=
 =?utf-8?B?aFJZU095UUpNSEhCRGd6WW4yVEs3T25vd1BacVhHQ0x1WkRsbEd1dU13S21D?=
 =?utf-8?B?YXZzQ1JYVHZuNU13d2NEZ3g0R2psZmovS2QyNTZRSktucmY0dXpYVVREZTFS?=
 =?utf-8?B?VlhMWVV5WGczZ1JLVksrYVB4a1llUGR5aTA0aTFjN2NZUy9VOUhCSy9VK0Nl?=
 =?utf-8?B?N3U2S0YzVjZxTVl2UUxSTmtzdDJsYVdJSUlxUXg4eExWUUZMcWhnYjgrZFdh?=
 =?utf-8?B?RE5QOU5sNUFRTFBTSndtVHJtT0F1MHJBS2JROU5UeHN6blMrZy9kb2swZHpy?=
 =?utf-8?B?N0E1aThNV056MEpxdU1jTkZ0ZHlkME5wQ0xHSk1JTTdBdG5QeWlkMlpWWDFv?=
 =?utf-8?B?VjJWN0lPU0tJYmIxOS9IZTFFZ2VxUDNXYXFXQWhsSlI2dG5iaUdXdS9tK2hm?=
 =?utf-8?B?QXl5bkFNU1dnRVBsZ3VhOFAwOHBpWGsrcHE1VEhNbVA1T3pCaXRaamVXRXVY?=
 =?utf-8?B?V216MERRLzBnLzJ5TklJNDRqZ2RTQXZ1bU9kRGJnTjlDRDZtdU1nam1nTml2?=
 =?utf-8?B?TVFjb2FiaFk4MWQ1MWJUWGhiSXdSeTR0cEFTUkI0MXNxR1BSNDlxa2s1MHFs?=
 =?utf-8?B?Y09QcU55SlpyQTNnc1pDKzNhMUU4OXFzY1J1Q1h0ODBWWmRaWXp0MlBZSGZt?=
 =?utf-8?B?V2JTLzcyMTBVWmV3SXRra1BEMExna0ZuZlRHODg2L0tMSmdjR25QU25Hc1Vx?=
 =?utf-8?B?cWwyT2hRN3VQTEZGSWd4eXBQdTVvNnNUVWhOcmhZaGhnVGtiMHhPeERrMEZJ?=
 =?utf-8?B?OTdHSGtIQUo1dm91alhkWFd6K3ZGVlVOUHVqUkxrcFZ2NE13UWJIRU5QZWMr?=
 =?utf-8?B?dkF4M2h6NU5hMCs2ZEw5WDg2OTQ0TTBxZ1BmTjV5eS9DdVVQbS9leGVGRFl0?=
 =?utf-8?B?MXhvNC9idTNzenRZaWdScUZDSWZZdVRnQjN4OEZpOHdISW85R2xQNFA5Yk80?=
 =?utf-8?B?ZlVBc05BZWdaZ3JpUG1OTUhNdFJTK3dDeEFlbUdxYXcrUjVyN00rYWVrWTMr?=
 =?utf-8?B?NVFrSUFOSHdXWjlJQlJNVEZhaFdnUldGVnN3aEVSdVNqcW03T28rZUcxQ0lP?=
 =?utf-8?B?Ky9pb0VGK1BVdlh0L3hsaGJiYXg1SWRJWk5kMkxRWXpHdUs1ZDZwNmlOT3h0?=
 =?utf-8?B?OCtCQkpPaGkrbjZwKzV0TnlUTm16MGdaa0J5MWx1WXplNkUxVFAzL3dKRGtq?=
 =?utf-8?B?cWRUWWZNQzA3TG4rSE9mNVArQ2wxSG91SDc5ZFBiQWtOM0Fqbm1FRW83TktB?=
 =?utf-8?B?OHVNdGlFZCtaaWl1VS9VM1pkVkhRSFZDVVVFUjBYVnUzV1JxNS9KMmtkQVpi?=
 =?utf-8?B?YWtZdDZ1QmpOTUdEQjBmVmg5dkx0SEhXRWh6Ym1PbENYZENQSXQ5TDFsMjVD?=
 =?utf-8?Q?+J9Nh61HcC6qitktPm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c12c011-0167-468f-2074-08df148ed380
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:39:37.8534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWAkgSBpaw/KYLhVudqwA1gybBTWb0tS436IXHrVqSQDUctIdDnynh1FurtN/OXl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
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

On 9/15/26 09:42, Srinivasan Shanmugam wrote:
> amdgpu_trap_alloc() first acquires reservation_ww_class_mutex via
> drm_exec, and then calls amdgpu_bo_create_kernel() while still holding
> that lock. amdgpu_bo_create_kernel() internally calls
> amdgpu_bo_create_reserved() which tries to acquire the same
> reservation_ww_class_mutex again — causing a recursive lock and
> triggering a lockdep deadlock warning on Navi44:
> 
>   WARNING: possible recursive locking detected
>   6.19.0-kfd-root #38 Not tainted
>   --------------------------------------------
>   kworker/0:2/959 is trying to acquire lock:
>   ffff8bb17995d9e8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: amdgpu_bo_create_reserved+0xd2/0x2a0 [amdgpu]
> 
>   but task is already holding lock:
>   ffffcc23c3397ba0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: amdgpu_trap_alloc+0xac/0x230 [amdgpu]
> 
>   Possible unsafe locking scenario:
>         CPU0
>         ----
>    lock(reservation_ww_class_mutex);
>    lock(reservation_ww_class_mutex);
> 
>    *** DEADLOCK ***
> 
>   Call Trace:
>    amdgpu_bo_create_kernel+0x1a/0x80 [amdgpu]
>    amdgpu_trap_alloc+0x18d/0x230 [amdgpu]
>    amdgpu_driver_open_kms+0x2f1/0x390 [amdgpu]
>    drm_file_alloc+0x20a/0x2d0 [drm]
>    drm_client_init+0x75/0x100 [drm]
>    amdgpu_amdkfd_drm_client_create+0x53/0x90 [amdgpu]
>    amdgpu_pci_probe+0x463/0x630 [amdgpu]
> 
> Fix this by setting bp.resv = vm->root.bo->tbo.base.resv when calling
> amdgpu_bo_create() inside the drm_exec locked section. This causes
> amdgpu_bo_create() to reuse the VM's already-held reservation object
> instead of acquiring a new one, eliminating the recursive lock entirely.
> The TMA BO requires no separate drm_exec_lock_obj() call since it shares
> the VM's resv and is implicitly covered by amdgpu_vm_lock_pd().
> 
> v3 (Christian):
> - Set bp.resv = vm->root.bo->tbo.base.resv so amdgpu_bo_create() reuses
>   the VM's already-held lock, keeping TMA BO creation inside the locked
>   section without a recursive acquire.
> 
> v2 (Christian):
> - Use amdgpu_bo_create() instead of amdgpu_bo_create_kernel() for the
>   per-VM TMA BO; eviction is handled by the VM's BO list via
>   amdgpu_vm_bo_add(), no pinning needed.
> 
> Fixes: c50a45b2e98d ("drm/amdgpu: Add cwsr functions")
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 67 ++++++++++++++++--------
>  1 file changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 31f653ec3fb1..29eba2968350 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -377,6 +377,7 @@ static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
>  int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		      struct amdgpu_trap_obj **trap_obj)
>  {
> +	struct amdgpu_bo_param bp;
>  	struct amdgpu_trap_obj *cwsr;
>  	struct amdgpu_bo *bo;
>  	struct drm_exec exec;
> @@ -386,6 +387,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		return -EOPNOTSUPP;
>  	if (!vm || !trap_obj)
>  		return -EINVAL;
> +
>  	cwsr = kzalloc(sizeof(*cwsr), GFP_KERNEL);
>  	if (!cwsr)
>  		return -ENOMEM;
> @@ -401,35 +403,59 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			dev_err(adev->dev,
>  				"failed to reserve for CWSR allocs: err=%d\n",
>  				r);
> -			goto err;
> +			goto err_exec;
>  		}
>  	}
>  
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
> -				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
> -				    &cwsr->tma_cpu_addr);
> +	/*
> +	 * Create TMA BO using the VM's already-locked resv so no new
> +	 * reservation_ww_class_mutex acquisition is needed — avoiding the
> +	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
> +	 * amdgpu_vm_bo_add() inside amdgpu_trap_map_region().
> +	 */
> +	memset(&bp, 0, sizeof(bp));
> +	bp.size        = AMDGPU_TRAP_TMA_MAX_SIZE;
> +	bp.byte_align  = PAGE_SIZE;
> +	bp.domain      = AMDGPU_GEM_DOMAIN_GTT;
> +	bp.flags       = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> +			 AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	bp.type        = ttm_bo_type_kernel;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.resv        = vm->root.bo->tbo.base.resv;
> +
> +	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
>  	if (r)
> -		goto err;
> +		goto err_exec;
> +
> +	/* VM resv already held — kmap directly, no separate reserve needed */
> +	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
> +	if (r)
> +		goto err_tma;
> +
> +	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
>  
>  	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>  	if (r)
> -		goto err;
> +		goto err_kmap;
> +
>  	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
>  	if (r) {
>  		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
> -		goto err;
> +		goto err_kmap;
>  	}
>  
> -err:
>  	drm_exec_fini(&exec);
> -	if (r) {
> -		amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
> -		kfree(cwsr);
> -		*trap_obj = NULL;
> -	} else {
> -		*trap_obj = cwsr;
> -	}
> +	*trap_obj = cwsr;
> +	return 0;
>  
> +err_kmap:
> +	amdgpu_bo_kunmap(cwsr->tma_bo);
> +err_tma:
> +	amdgpu_bo_unref(&cwsr->tma_bo);
> +err_exec:
> +	drm_exec_fini(&exec);
> +	kfree(cwsr);
> +	*trap_obj = NULL;
>  	return r;
>  }
>  
> @@ -473,6 +499,7 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>  		return;
> +
>  	tba_bo = adev->trap_info->isa_bo;
>  	tma_bo = (*trap_obj)->tma_bo;
>  
> @@ -480,15 +507,11 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		return;
>  
>  	drm_exec_init(&exec, 0, 0);
> -	drm_exec_until_all_locked(&exec)
> -	{
> +	drm_exec_until_all_locked(&exec) {
>  		r = amdgpu_vm_lock_pd(vm, &exec, 0);
>  		if (likely(!r))
>  			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
>  		drm_exec_retry_on_contention(&exec);
> -		if (likely(!r))
> -			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
> -		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(r)) {
>  			dev_err(adev->dev,
>  				"failed to reserve CWSR BOs: err=%d\n", r);
> @@ -500,7 +523,9 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
>  err:
>  	drm_exec_fini(&exec);
> -	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
> +	/* TMA BO not pinned — release CPU mapping and free */
> +	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
> +	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
>  	kfree(*trap_obj);
>  	*trap_obj = NULL;
>  }

