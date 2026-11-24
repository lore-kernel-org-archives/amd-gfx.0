Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B3606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J2YG1ts7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E67110E04E;
	Tue, 24 Nov 2026 03:44:09 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E2510E04E
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 03:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TULhItMhjbRCi0Rzr4MN4AXJPgfcqorINFu9fH1c9RDrEuAfy52YdCpMx60zaAuJY0PLm+ZCG9rXXqqG9f9zutEsZTeKyhi7YHi1E5t+bfTZakE46UdYPIWKGKKQl+pOLmO8Y/lflLM7nNk70vsbW1Wck1MmhBEaYFjA7BJ8q4oEcZAwmLzklEpEf5a8WNH8CFvD4iOb0lQzLBNruXYYUNZRPKspo3L7F0H1r1HA74vOXQY73KhuCRqJW4jaa305fmW4BsEmsj+DQyUk2B7CDaLKYnd9Qiu1qVEy6qayHSsMHvlP1ikUqTK9lZSy5vHEwUG3FhJHzpEKZUPThH7Idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPdsGF6ev/hCcPzXPIA85g78HbYmzdgdzddOjXxKlAI=;
 b=Tn8vYO6N3W9h9LmT2D+d1DbPDFHMVeZNo1fcY2Jl0cH9fpSAIj0v46/bbNfPXNjQxugvrpm6Jb5VpgN+DQg36U5Sa6vI8d/EWk3mop1vUm8B4nUwyamN06A2EkhN7qYZOXE6quLrQM0fHBVgDtVscnbQOZu+rWnVGEvS6W4Lbkv+33DzTLHypsv5nYiCRTHjczbtDwmslgSFLhnAEtb1Y+d/QrTuISFDzjWgc6orFYt287IW7/QwLeklBhMSqstNR6NVGOz94kChXF2cZ0usWv0+1vu+vvnNfLHpBls2kJe3d+XZpJ/VLPCyLW5Nj8Gj9XVJdGKsqeAyKeh6LiAxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPdsGF6ev/hCcPzXPIA85g78HbYmzdgdzddOjXxKlAI=;
 b=J2YG1ts7sPeXnYtLTy//VCYV7LL9Swx3k2lHc0lzeQ7Iw8z8jlCxSxpvY5nwLw4khOfXvAL+izYQtDOEm1kxYyGm6OY4Q44agah2Y2nKWlQ5OEGEbkYZCWEJL/glscFZnasP+fA57cxqe0+srqp3dNW0swmsq4pNJzFqpNQHlf4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 03:43:55 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 03:43:55 +0000
Content-Type: multipart/alternative;
 boundary="------------LBtrlwR90Tj0Q0J9h5eD0dta"
Message-ID: <431ce2ef-0e38-4e8c-b0a1-112596466fb9@amd.com>
Date: Tue, 24 Nov 2026 09:13:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable traps for kernel queue VMIDs on GFX9
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20261124032648.1977968-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20261124032648.1977968-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b5c424-6bb8-43f6-9377-08df49dd29dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|11063799006|56012099006|10067099003|261021123027099003|261009223027099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: XvGSMZasQgKvSMOqrKhTUnZ16Zu4ONawM88uSlqGQb5wSrA8dW7Aal9PkWUmbLfMBHcxQE3ZOPBhB14KlL1GoBsWiulUbsvD2o/Rt7Oz1XbHETctk8jm4BTkcRo8fEImqbSX3XiQg+XM22ZjAkhbzf/qWGxdncPkYG/8R9PS8iPsMW7xJNw4/VbAZyqmC/tCUa12xFugoCwbKH9UU/8i6O8VIHFe4wm2HO/Ly8MPxLpJt2MlNrqkYydOEDcuq+h+zJzxuI7ws5/NRPXi3j2lfQpHt8oGbmPIS3UBbDiCRXjU+So1FE19Gyi8seiHX1JVwZWUQv3O0w3UBtlTbZx88ncST/qBU4M+ej3Gh4vTBapuui/mNI8vZ06yFCEXxvnkKCaAN+WCndy6w21SY+lbkuyTjeDq3RoJMR/zwtE7/vveAykEo7OtZNz4S0JBJSP40V32Em0rlBtTCPTq/Fs3B7imHKELBnGV1BSeZsvKTWtWc1izwjg1yP5+Dy6PgNZWNWYwPZI/8W45Y01KLKBH5oFH+Z4lBsautswfY3HFEpfOXJkZ2ptFc2ie0xWGyBm89gmP26vO6d5ihvW14ck+JVC9H/DIdKqM/sAoyWStEwWv4z2gxZpbeWWlwOuO/l96HJ2O/P6uQiLMEy/2jIOi3RvuLslo5wjVajGqlU8Fq6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0I1QkhuQXpKVEZlVzBESWoxQ0IwallCdFVDWkZ2ZThBdmlWRUYxWUFtai9i?=
 =?utf-8?B?bHA4dUEvRTh3UHI1c1ROR2xFenZYWlo0d0ZDMU42Q1RaeFJtb3FsUkZ5RFdD?=
 =?utf-8?B?c2V5cFBZNVBWRUpQVkR3cmZNSG0rK3M4ZG5CSUNFR3VmemNSZ0RCQ29keXVi?=
 =?utf-8?B?RWR2MHBxTkZ1TVZ1Z3NXYm5VcmhEYzdNcklWSDU4UVRLT0MyV1M3emxqeDdo?=
 =?utf-8?B?NFFEbGEvQjFLTUNyZ1V2VDNjcjlnL3owOUdKTnVZREU0RlBxYzZScnJ1VVlV?=
 =?utf-8?B?R2FQa0FXRUN3N3dQekhmYTZiZFhGdTZvTlhQVjlVcFRWTFJ4N3lxbmE2VlND?=
 =?utf-8?B?cERLbG9uWW9Cc2NyaE5SSnFCcjBUK1FiNkEyb3VJYVF3dzMxdkhLRk9uSUp1?=
 =?utf-8?B?T2x0U1QrQVVjS20wSzR0aW9mSWlkKzRpeHlndWNQajg4MFRSUkJTdktpa2lx?=
 =?utf-8?B?bFlWTHY1NlJBQnNDNnpNWmJxRjZNRDN0ZTluOGZNOHZmSTJFZktBeG9GZmgx?=
 =?utf-8?B?ak1ub2hkSVZOSzNLb2VaaWpQd2dIRlpKN3VFZ2h5aWU1eFdzQ1R2RFdGTVV3?=
 =?utf-8?B?OUdPTFRnWTJacjFQdmdqUVhBWFA2UzFBWXlKeStoL3NuM2w2OGo0bDVoWmRG?=
 =?utf-8?B?Sk9wSkhvTU1PTmJSSEh5Nko3ZUJLWWtGMnRTRUJ6alNJMEtzSVhtcXVoT0tU?=
 =?utf-8?B?YVpMUXR1K21PT1NNMXJvR3Q3WXp5THFiRFVpNWFkdUJFaE5DdHJILytnRnJG?=
 =?utf-8?B?TWw3eXZveFQyYkhuQWVTczZZcGMyTC9GRGdHc1NpTnRGOUt1TXV3ZnZJWm02?=
 =?utf-8?B?clVvc1lGTTV2elRGdU11bzZudUZqZ2JSRDh2d0tKNU9JN2JmWFJKVDJpYjhv?=
 =?utf-8?B?WVplZkZJS0tOY2NkdmVhSHdMNlJ2RkFsanRTZ0xtbnFKdVByTllkbjNJamNy?=
 =?utf-8?B?K2FVSmdHcUh0dmtHTFc5ZXVXM0hnM2crdHdCT0lLZUcvTlp6cHdWbFNkNWwy?=
 =?utf-8?B?dW4rR2k4bHgzM1VCNkliWmNlZUg5RXZzUHlhbUxEckZyNmZPK2szc2dIbWlC?=
 =?utf-8?B?SEp2ZXFaOHFwYlg3TTRCMFpDN0VKNkFaT0UrOFF2NGpMU1JPS3dIb2ZnMDFI?=
 =?utf-8?B?RVp4LzFRTWNFVXA0WEQ1bGxybUN2SUJuQm9pbGFxbEM0SzZRSlp6bFpxdnFu?=
 =?utf-8?B?UGtzcWxQd2J4cWtxOElWVlhWV1B6L2ExM0FQSzlkZW5ZWDQrWmc3VG5GZHR2?=
 =?utf-8?B?UEJ5c0lkS2lzOG1Ca1UwUDRJUUI3Vk1yNkV0OHY4YThRRTg3UnQxbU02Tk5O?=
 =?utf-8?B?Zkc4R0JsOHd6VElIR3pvOW14UUdpRHhnZjRzNTFyek4wQ2RyZVVSUkNhYWxk?=
 =?utf-8?B?aENvem10OTkwZmN3a1Q3VTNwdnV3RC8xV21mVjRZeTBVV0xHejVTL1R6OUFh?=
 =?utf-8?B?UjRnZ2xFVHh3c01qb0V1WURNYWlidXc2YjQyaVVkZEdzdEJsM1k4S0FwZTJR?=
 =?utf-8?B?ajdXRzl4d1RMUGxETmdkVEk3cVlQZExLRlc3OWNOWGVrRGUxQlVlOUVTN09l?=
 =?utf-8?B?bXc5T1ByUnZCMjRxZFV1R3hlR1VDdmFaM21tTG9NZHZJdmZubjN1WXVZS0FU?=
 =?utf-8?B?c0RhOHlHZmxGNFcrU2FsaEZuOFVKUm5CS2plRmI1Y0M4eUhOTWxrTG5IdklU?=
 =?utf-8?B?ZjJlbXA5Z1lOOXdHcUNUME1QR3RTV1QwbjR6U210eW0vNm84eXBhalVuVWdD?=
 =?utf-8?B?U2RqdFM1SEVDRVZ1YnBPN1I4T29YSjJiNzlIaVQ5eWtQN21MUjdzL205ekpu?=
 =?utf-8?B?RTB6LzU0dW5sRC9rMDY3RUZkNjlmRUxxT29nZ1RDZlQ1NU9TYkV0RnFuSXB3?=
 =?utf-8?B?allpb2Q3dlViaE82TFJLbFhia0tNKzF2L3UzQ01DNFFwb1FtN3FkU2JsUkFm?=
 =?utf-8?B?RDRmRTdtdnZvdVBoTTVUME1kb1lmbjdOQ1VDL0RVMnFHenE1YnVVYnZyUUcy?=
 =?utf-8?B?RGtNbzBPMk02cEFTNHpqVlkyWVZuaEJSWG90NnpTTGFRWUJUTWh6WUg5SkEr?=
 =?utf-8?B?UGJnWjF1d2ZkNlB2SVJod1UzM3o5eEJNc3Z1Q1YwbkdISVA2N2JFVFVoaG9v?=
 =?utf-8?B?aWErNkEvL3hYUlNkeFRWWGtWdEpVV3pGdXlSUnpOeDQ0dTJlL2xEYnFvcGNU?=
 =?utf-8?B?anM0UUFxRFpoZWNIdDVLV0doRVdyNkRnZ05QM2VVQThucGFtR2d3Q1JtWEl6?=
 =?utf-8?B?aGVmWjRuS21DRWU0QXc4V3g5SXUrMERlQXRpRmgwSVJsdXg1UnQwWG5xQ2t0?=
 =?utf-8?B?UzlPR1NkLy9Ca2Izb21DbFNTRFlBc1MxQ1dYa1lvaW1kNkQrMnR0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b5c424-6bb8-43f6-9377-08df49dd29dd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 03:43:55.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK2VTtUnoAQIzp38W6q8BaIEJ75pzg+SjQaj82krXgq5V6ldxyyioNOG9+VqomvjeK0Uar/a+dKcAyWViDsg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------LBtrlwR90Tj0Q0J9h5eD0dta
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/24/2026 8:56 AM, Jesse Zhang wrote:
> GFX9 enables traps per VMID in SPI_GDBG_TRAP_CONFIG.VMID_SEL (or
> SPI_GDBG_PER_VMID_CNTL on GFX 9.4.2), but only the user queue VMIDs are
> enabled. So kernel queue jobs never enter the trap handler and an L2
> trap handler set with AMDGPU_VM_OP_SET_L2_TRAP doesn't run for them.
>
> Enable traps for every VMID except VMID 0, like GFX 9.4.3 already does.
>
> Fixes: e259fae224e7 ("drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs")
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
> Change-Id: I40175d1fea21fccb42a4db54be86e5e7458c6ed9
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 +++++++++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  3 ++-
>   3 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f8a5e9151483..3d8fd62fa269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4064,11 +4064,17 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	if (amdgpu_trap_is_supported(adev)) {
> +		/*
> +		 * Kernel queue VMIDs get the first-level TBA/TMA from the
> +		 * gfxhub, enable traps for them as well as for the user queue
> +		 * VMIDs.
> +		 */
> +		unsigned long vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
> +
>   		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
> -			gfx_v9_4_2_debug_trap_config_init(adev);
> +			gfx_v9_4_2_debug_trap_config_init(adev, vmid_mask);
>   		else
> -			gfx_v9_0_debug_trap_config_init(adev,
> -							adev->vm_manager.vmid_uq_mask_gfxhub);
> +			gfx_v9_0_debug_trap_config_init(adev, vmid_mask);
>   	}
>   
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
> @@ -4952,7 +4958,8 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
> -		gfx_v9_4_2_debug_trap_config_init(adev);
> +		gfx_v9_4_2_debug_trap_config_init(adev,
> +			adev->vm_manager.vmid_uq_mask_gfxhub);
>   	else
>   		gfx_v9_0_debug_trap_config_init(adev,
>   			adev->vm_manager.vmid_uq_mask_gfxhub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index f54f54fe535e..612ced9754bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -836,14 +836,15 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
>   	}
>   }
>   
> -void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> +				       unsigned long vmid_mask)
>   {
>   	uint32_t data;
>   	int i;
>   
>   	mutex_lock(&adev->srbm_mutex);
>   
> -	for_each_uq_gfx_vmid(i, adev) {
> +	for_each_set_bit(i, &vmid_mask, AMDGPU_NUM_VMID) {
>   		data = 0;
>   		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>   		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index ca240f4298da..c4d5055f01e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -24,7 +24,8 @@
>   #ifndef __GFX_V9_4_2_H__
>   #define __GFX_V9_4_2_H__
>   
> -void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> +				       unsigned long vmid_mask);

My original change programmed the L1 TBA/TMA for kernel-managed VMIDs,

With this change, kernel-managed VMIDs can also enter the trap handler 
and reach the L2 trap handler.

Thanks for tracking this down.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>




--------------LBtrlwR90Tj0Q0J9h5eD0dta
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/24/2026 8:56 AM, Jesse Zhang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261124032648.1977968-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">GFX9 enables traps per VMID in SPI_GDBG_TRAP_CONFIG.VMID_SEL (or
SPI_GDBG_PER_VMID_CNTL on GFX 9.4.2), but only the user queue VMIDs are
enabled. So kernel queue jobs never enter the trap handler and an L2
trap handler set with AMDGPU_VM_OP_SET_L2_TRAP doesn't run for them.

Enable traps for every VMID except VMID 0, like GFX 9.4.3 already does.

Fixes: e259fae224e7 (&quot;drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs&quot;)
Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
Change-Id: I40175d1fea21fccb42a4db54be86e5e7458c6ed9
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  3 ++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f8a5e9151483..3d8fd62fa269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4064,11 +4064,17 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_trap_is_supported(adev)) {
+		/*
+		 * Kernel queue VMIDs get the first-level TBA/TMA from the
+		 * gfxhub, enable traps for them as well as for the user queue
+		 * VMIDs.
+		 */
+		unsigned long vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
+
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
-			gfx_v9_4_2_debug_trap_config_init(adev);
+			gfx_v9_4_2_debug_trap_config_init(adev, vmid_mask);
 		else
-			gfx_v9_0_debug_trap_config_init(adev,
-							adev-&gt;vm_manager.vmid_uq_mask_gfxhub);
+			gfx_v9_0_debug_trap_config_init(adev, vmid_mask);
 	}
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &amp;&amp;
@@ -4952,7 +4958,8 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
-		gfx_v9_4_2_debug_trap_config_init(adev);
+		gfx_v9_4_2_debug_trap_config_init(adev,
+			adev-&gt;vm_manager.vmid_uq_mask_gfxhub);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
 			adev-&gt;vm_manager.vmid_uq_mask_gfxhub);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index f54f54fe535e..612ced9754bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -836,14 +836,15 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
 	}
 }
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
+				       unsigned long vmid_mask)
 {
 	uint32_t data;
 	int i;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
 
-	for_each_uq_gfx_vmid(i, adev) {
+	for_each_set_bit(i, &amp;vmid_mask, AMDGPU_NUM_VMID) {
 		data = 0;
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index ca240f4298da..c4d5055f01e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -24,7 +24,8 @@
 #ifndef __GFX_V9_4_2_H__
 #define __GFX_V9_4_2_H__
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
+				       unsigned long vmid_mask);</pre>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
        <p> My original change programmed the L1 TBA/TMA for
          kernel-managed VMIDs,</p>
        <p>With this change, kernel-managed VMIDs can also enter the
          trap handler and reach the L2 trap handler.</p>
        <p>Thanks for tracking this down.</p>
        <p>Reviewed-by: Srinivasan Shanmugam
          <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></p>
      </div>
      <br>
    </p>
    <p><br>
    </p>
    <br>
  </body>
</html>

--------------LBtrlwR90Tj0Q0J9h5eD0dta--
