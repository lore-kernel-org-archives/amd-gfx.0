Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF8606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OdxHh1U+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43391123B9;
	Thu,  5 Nov 2026 12:26:39 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BC91123B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 12:26:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUL+P3d4fpEX9qMjJSAeVPxGqVUzmxzlbRc+zbvWAfsAhoE9hz70oOKlf5FeSXcF+bFTgnR7uPqRmODbC0FjfSM9tWQuUuTmiICvAAkC37oAb/3f53+PVIUlzc6CMHIxXpIgdyBgDLYxysalXaE16nJaHnROJgpf+KmSlXSqGA3zFohuMJZrfeMm+AMTwASD4xO0Jq8EH2ub5BGAC5I+4qVtZnRNgwSQ5MN9oqNc0q6SHp9ElWwhFaPpFqO9jVkxHlptL7IqCZKApyCXsBVJpRU17vpIpTDM47NAO5hloyh73GE0cwXRqh4kP6bUa9JRf2Mky0YaA2wFwSMNEFEBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhD1qnSPCxy3tmDcAsDEf+KP+y/DIDdzbR9wVZ/Ac6Q=;
 b=j5EoDrtsdHcs8PubDBtJtuBv0Qnn5zjimc+qnB3+0qrpQfaRy7vLy3m8GFIK+iTwXhE3dyfEXmPcTC7LB2tfyrXPdfow+J5jst8/GK8xJ3PDIYEjGuSyfCKF97xoqQrPtLE7Hlk5m7xeKzoRQCNlwW/OJpu+xUV/BSe/f04APRbdIIcw7Bl1U4DpH5K+ehkRO2ybRfrgxjohlo02J3yChhmN2Bk+RK7QVHeZylyNQUPz7JhwelHTG2E6qZnyu0S8M/9BJYBXTl5TPH9DnyE/ROAbdEvB6HGDcbypTKywcUiu7f1gAvpgmXU8hnz1d7B2MWlmjoUQ1GzCRtWyBWClmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhD1qnSPCxy3tmDcAsDEf+KP+y/DIDdzbR9wVZ/Ac6Q=;
 b=OdxHh1U+ynRH7Kg/M9W/77cRPYXUJ9s6t72bJnL14PM/uB+i3nHeQwXZ4RCSoyAJ/q1qAaLlhEdisysFp7EnAT4GUulA3x9Vv4DNWg2ljoNviNaLPJPIO6kbykHTDjVhmS10PTcj+Byu783UG04As9mDoMyHfCmnJI4EPvghppo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 12:26:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:26:31 +0000
Message-ID: <08bbe386-47fc-43ee-ae68-0f705000ee25@amd.com>
Date: Thu, 5 Nov 2026 13:26:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix the error handling of
 amdgpu_vm_init_entities()
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261105093834.971607-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261105093834.971607-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:335::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a5235e-7ac5-48cb-92a8-08df3b3805c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|261026121527099003|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006|261021121427099003|261022105027099003|261021135927099003|261009223027099003|261021123027099003|261022075727099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3h8a8x0Bff7AapftYxuH0Jt6Yz/8git4XbixjDtjMDF6A7j2N+li4kdHkY9P2PEeKD3PJes+Zu51Vwl1m9iv/2VqDp7pVXnvSyFGfM/D8RXheRSTgv4wG9u1oCB8Q0TNNEpthWzPnuvOfNvchOUQafRPAHQ7+uhkKnGg/eSUVtTRRvg1Iqbng5ig9OgC3kIN411SpaeXSvz8ekXvAjNoroGEgNZTyG10wYa6b3gzHY9LZToApYXCqgxoz/R0Y97pdnnQyZOMMviV+C0JAhTVRrjTyRxXQA6ArFkwVVAmK3e1ugRvjh+9c8yHjIRfYbeSqhNYaMqiI1G6ETOTb7oRfezRUm7bOqJ+Ce+gom4W0FCrPqhFboSrcK4tE25knATXpG11KcSw3AJahFA/eITg0+ufDAlIjuH4BYeEAnqY1aFm7588qz7gbQBfuX2l6G4pHfO0Nz14b9yjABylfXRMfV8Q3YbQ/IT8e8wpKhq3nTeXoLqVIXi2LnzDZwTqeQoxiy5w0+boLy4kiAAttPFW34vOJo2bW7B8E6f/iJpfM0j52Eyn4jv85Qs4dNJKrIgN8q41m0v5lCvdG4BbW5CMNqUamfbwSnC/rj6l/HJF3lEWvL7j0OxFrved7vjhddtwQ8uksDYHH+qQKazYOa2LhZaTAkXCe+Ihwd9fSOLbBV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261026121527099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021135927099003)(261009223027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck9YWEp6bERoS3NacEhDME5pV2JnRHoraXlhbE1TQ082S2E3a01HWlJNbmNV?=
 =?utf-8?B?djlNbUo3cnFNa0FIYXhrdzdaRkMyNFBuNVNEZkxqTTladmxCa2ZEUC9NUmhU?=
 =?utf-8?B?QlREOFprYmRLcllyaHhXUWJYZ24xUE1sNjJ6dkVJbTFCenlhL0oxRzF0ckUx?=
 =?utf-8?B?QzZURG9HZnNUQVFqOFhHdTRZUTdua3dsZkM4KzdtbUZoM3hUZHhOUDQyR3pC?=
 =?utf-8?B?NGVGZUVkYVJnS0xwbXVWNS9vOVN6SUc0eGdvZVo1aVRBdlB3S1VWYkRWeGdh?=
 =?utf-8?B?M2xvVElVZXErSytVdjZVb01VNjAyZ3JRVER2Y1k2d2p3enRLUk9mbk04QzBH?=
 =?utf-8?B?L3oydXM0NTZhb0dkZmtOb1oyMHQ4aExiaUZ3ZkVMNjdiUjVLa0EvZ3M0a2tx?=
 =?utf-8?B?NDY4U1N0S3V6ZHV4dWJWQ0w1WWtMQ2ZyUWxXZ3FQR2U3YVRraE95WWtQMzdP?=
 =?utf-8?B?aGtTM2FOTCtpTCtIK2xtRFB3RzdNb2dxMDhBTWttcnYwNDFkdHExVllWTWtE?=
 =?utf-8?B?cU11eVJtVzU5OUwrc1dSNnZRQ1FzQ1BoZmRwNFlLVUNQR25SNnFuYnZ3bGtP?=
 =?utf-8?B?dThJSXhhSUVqL3RRV0RxcXErMkNlamVSSjRqS1VjV1FVVjZQZjJEYXYyMDIr?=
 =?utf-8?B?SloyaTA1UXIvRElVejdYZXMvRjJnc3dtY3dURk1FV0NER2VGODAraVdUWC8r?=
 =?utf-8?B?SDRrUlF1SmI5bUozRXlVeXJIcHUyRlpTYlZkY2xySzhkVUpYY0J6Yk1mMHJH?=
 =?utf-8?B?WHg2ZzYxVUpxekZGdENOMnZvMWdqeWNXdVcwTzdqMTA1bURDeXJpNTJaajM3?=
 =?utf-8?B?MFVQM0NjQXFzbVIxblhvWHdKbHFKdzVtZ0NYdGFtNWpDL1hSdHBFdEUvSTQr?=
 =?utf-8?B?VmVqb1ZwdUpTQnRFQWRrR2t2M0VRd2RDZXh1WU5mODVTR2kxcHNKUkVRbkxz?=
 =?utf-8?B?ek9SZ0FQUVV5TEhhcWM4NTkvUEZJRWZCV2t2bUE3YlZ5ZVg5L3hlc081ZTFV?=
 =?utf-8?B?QURhNncwZ0NaK25mcjljeWtTY2RpZnlrK3FnSWMwRjFrSHJEeitsUFhZZVMw?=
 =?utf-8?B?alczY2lUYlJHNGNjN1VXUlJQa0dWOTdOcVViVnMzZHl2dzRjWndkVHZWbzVP?=
 =?utf-8?B?UUdWUEx0Q0NTM0JlNUtyVTUrTVBHSFY1RFJyOG9GSDNZa2djdCsvRGc1RHFn?=
 =?utf-8?B?bCtUTjNJelkwNDZhU2hsTjAyaXQzNHNCNjVmNy8zQjdYYnpkVldsY1RWTVBS?=
 =?utf-8?B?b0tuT1QwNlpuak9MTDBtbWl5SG9wK2dObDliNmhoenlxUzJnSFZTOGhpV3Vw?=
 =?utf-8?B?dGt4aDFXQlJwUmUxY0ZrN2c3dS81R0tpbnh6cnBsOUNBaVdlRm1TeWdvNVVk?=
 =?utf-8?B?K1EvMmxPZEdJczlDVCs3bGV4Z3RpY0ZMSWZoc0lQWUdwRUJLc1dvUC9zV1E1?=
 =?utf-8?B?TW9wSlhOWTdGdG5HUngrckFMRnVoTEpHc0YxSXZ1a25rdkl6R3lYSTlYc2Ry?=
 =?utf-8?B?L3FwSnVleHB0ZmtIWnQwWC9aNzhGVGtENTVod2VTYW9Dc2dMK01EOW5rR1JD?=
 =?utf-8?B?YStub0Z0NzZVNUhPdC9ueGN1c0tTZVJLcUUwNW9ITGxhdlNCamhKZnJKRFVI?=
 =?utf-8?B?cCtReC95TndIeWVQYms4aDRtR3U1QjZSazFaT0tzYTZEdSsxVWNFYThoYzk3?=
 =?utf-8?B?V0FGWXpQVVZGd29RUmhaTVp2TlgrVDkzV21BYlZjUnFjU29Bd2JncFh2Z3l5?=
 =?utf-8?B?OXJpUWZTb3RtQXQyQU1wTVM5Vm14QkNIeFF6anhjaEIzY2ord3NPYTJsWENR?=
 =?utf-8?B?T1Q1ZHlIbDBFbEFvN3hZbjl0dUcxZHJpbUlRdzNvVDI1aTBic1RWZnRoZGJh?=
 =?utf-8?B?WjJsdmtIK3k1d3prWjNHVDJJVEVPWHpQV3JqaFY5UG5RNTBYQkE4WHBEY1ZU?=
 =?utf-8?B?eTZ4bGxyZU9lcENjRjRSekY2VXpHMXI0eWl1aFY5K3R1cktzUitkT01PdWZ2?=
 =?utf-8?B?R0c0SUVDL1lJdWJCN0VIZ3pjcWxDcWVONm5lc3FNRDg0SGEvd2lBUXlXdVpE?=
 =?utf-8?B?ZDFhMVJHZXdEOC84Zlp4OEc5TWZncWd1UEVOczBucFlFbWN2VlVIZlhkWlNG?=
 =?utf-8?B?b3dZVmt1N1o3UGJoTmdtblVJdTM0bkx0Tld5blQ1YzEzcmdBNThXbjQ4Nksz?=
 =?utf-8?B?UW1EU1J2RGc4c1N0aXA5blU5Tm1xcDcyWEZBUVN4dTBOd3RHK0UxbFlvUHNT?=
 =?utf-8?B?UGRERGJpc1pRN2orZUV2MExoVzk3S3hGQnZyL1FrTjRwVVkySG81VU1wTWJO?=
 =?utf-8?Q?EOuTcsZFPv+8tiXlOH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a5235e-7ac5-48cb-92a8-08df3b3805c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:26:31.3191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGvo+hQwB50BAy1hhFZhnxbu7fmyS4mCIcuYfbxVJkb4090fQve7jeQBl+uy0pPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

On 11/5/26 10:38, Jesse Zhang wrote:
> When initializing the immediate entity fails, amdgpu_vm_init_entities()
> destroys that entity which was never set up, and when initializing the
> delayed entity fails, it returns without destroying the immediate one.
> 
> On navi48, with the allocation of the immediate entity's scheduler list
> failing through failslab while opening the render node:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:do_raw_spin_lock+0x7b/0x280
>    _raw_spin_lock+0x3c/0x50
>    drm_sched_rq_remove_entity+0x90/0x2a0 [gpu_sched]
>    drm_sched_entity_kill+0x86/0x5a0 [gpu_sched]
>    drm_sched_entity_fini+0x23/0x270 [gpu_sched]
>    drm_sched_entity_destroy+0x24/0x30 [gpu_sched]
>    amdgpu_vm_init_entities+0xc7/0x100 [amdgpu]
>    amdgpu_vm_init+0x5d1/0x1480 [amdgpu]
>    amdgpu_driver_open_kms+0x2b1/0xd10 [amdgpu]
> 
> Only destroy the immediate entity once it exists and the delayed one
> failed.
> 
> Fixes: 55bf196f60df ("drm/amdgpu: reset VM when an error is detected")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2ba33212d507..11d8aae223c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -533,12 +533,16 @@ static int amdgpu_vm_init_entities(struct amdgpu_device *adev,
>  	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
>  				  adev->vm_manager.vm_pte_scheds,
>  				  adev->vm_manager.vm_pte_num_scheds, NULL);
> +	if (r)
> +		return r;
> +
> +	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
> +				  adev->vm_manager.vm_pte_scheds,
> +				  adev->vm_manager.vm_pte_num_scheds, NULL);
>  	if (r)
>  		goto error;
>  
> -	return drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
> -				     adev->vm_manager.vm_pte_scheds,
> -				     adev->vm_manager.vm_pte_num_scheds, NULL);
> +	return 0;
>  
>  error:
>  	drm_sched_entity_destroy(&vm->immediate);

