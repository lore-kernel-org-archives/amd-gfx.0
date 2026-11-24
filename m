Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A7606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T/wD0p/a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429F610E7AC;
	Tue, 24 Nov 2026 06:38:24 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AA510E7AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 06:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY8AVqhsDzSz2T+yOe8AdrBY28lYzWYAFRQrI/xcKLFl7lfxDHBy8UjF+9sfCqpY2zlHdClLjIsqTZLmvo4mLpdBT1anomDQ3Ng3Il9YUiG9Yuhfy5yrita3vf5kkzcuqp4+vhe921RCxa6TASV7fHz/K/YvFGVAvcwoncvj+iUwUld6+wbrC0B4K0dzKUuE3vepcPD31yOpkptJbP+iFF031cq18n2inJ46sKseVEH/K13qnXsF0QwvbUTpDr0KiZYRr/JFm7XPCJERvPXMW+qkCU/OhEb3qpPZX+Qh7A7q0kuEG0ozyJ//LNzsdnyrF3O+54UrIDiOkq+rlLSKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlyBgQ5C4jeYWfAHZWjynsAW8T5BSTJ7XYdd7+I4ZV8=;
 b=sLN1Yh74eRAQBLL4cEGxYwGq22U6MZvBuuZ1ECPDxQoVoTW9hq9K4L9fHjBlFJkwx2P3PgghTWuyPk/koYa2EthYHxa4baCgqApuxK6M6+viWLrokfZ5KfBsLWSiXHzS6A35H+n45LXOadHrQiSWpRP7tH5sVbGib5n1iCz8O4vjEk+U31ieeWg4KeAZ9naJxtmrZz0P05OYchz8Z9ECwY7uijrybTEl7msxmj75wQskOBSfFGXyekKZUseLbNeVvySlBoQ2YXSnuU5jDUaZHJK5cVe7GgXgHjfyi3CtTRdpcnGPi17RDSsNK3AZ7L/KuIASdPhI2I/EOqvrmwmLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlyBgQ5C4jeYWfAHZWjynsAW8T5BSTJ7XYdd7+I4ZV8=;
 b=T/wD0p/aFGEPIsA/FlWeZxmYajVM+yEYjTSvy+ZSgQukN/BWEFRDYncsZF/oGkAOTaVGbb5Agsj53J9qxEODTdw09YPQV6ipRsO/EGIHJRhaaaeC0wq/afxoJpHZNMVwsdsGza4XFXSQ5HHjYQrBhWZ8JiUEp00OIrQqd9IyEq0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 06:38:14 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:38:07 +0000
Content-Type: multipart/alternative;
 boundary="------------7Qer15JqSvOP48S5XId7eFKV"
Message-ID: <9908d972-82d9-41c3-957b-7fe8d619a183@amd.com>
Date: Tue, 24 Nov 2026 12:08:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable traps for compute user queues with an
 L2 trap handler on GFX 11.0.x
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20261124061643.2043178-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20261124061643.2043178-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: MA5P287CA0164.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::16) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c66efc-f783-460b-473d-08df49f57fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261022075727099003|22082099003|18002099003|261009223027099003|3023799007|8096899003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|56012099006|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: HkvkNVvjyjyRzJ4MK05ilZtFWK5709xOPo0qft1cz7ilNXjXGUD12TiuBd9Ii61L/VAkOBxWxuoCz1EPTU13Fo89Y8btItIFDrdYqqMJDW27s/Rl+bxqC32oFshQ7pKg2Npyc9fn8yqVuH/ulFeFaI3XvwyS00yYqdOx7Ithcm0wV3MQzMzbcP1qITYsdGyzafsTj3NveRMFEdehnymnx/USZ0BWPRLwNSNbJ2WL6TOQK5FuB+C3R1Nqv+vUC6eyp6BczWmAndA8yo5VjSGopyz/4GAqCxoajwJOlHOMWjvkGdGMlVmKlIXkP1iPhpukC+1qFuTahArPp+bdiai0FDIaFM6R3nu/i87D15iKAHrFLBNZ2NpZXoUaovPwCQbTaggMU5U9tnWfiYTn/e3xb4FGcjquFu69cRYnCGPlQkE3eCb8xZUf09oET5l1KuUof9CWjyNeav4p/ya8UrcajkT5IerNpKNQ1ldSnCScIL9AnnAGq0J7OVy31SQF86NbWxbSLMckSf092pLFW4lRVrP8Jn+f3sPrczbxsAV4UHOIl/mspR2ZNh6/sEW5ktY7hzBrWUZL51xbmylxF3fOnAY4M1E42ngy1fgEVMXF9noP21wRe7DtLpuBa0Nc0BQO1KZb+L1oay/HvyulTJVF6kU6N+ogvq5sR3POs2AiGaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261022075727099003)(22082099003)(18002099003)(261009223027099003)(3023799007)(8096899003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(10067099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGQ1dWl2a0NUcnVPWE1xNHlrZERIZHp6TXQ5OHc0TExsQjVhREZQd2c5THdG?=
 =?utf-8?B?cmJ0K1NPUERaRHk5TUxwellDcGtYNjRaOVRKU1dIS25UWmNvV2xDS0FyNGFH?=
 =?utf-8?B?Ri9xRE9EVy8yb1ZCUjlVNXhHVE10ZDdDbWl6V0pXTm45c3VNRnZIaTNvSmVT?=
 =?utf-8?B?UWNOaWRSc3NZSHltNlZOK1BaeS9XK1lhaDc0QVFpWVdLWk5VcG0yWUd2RlZw?=
 =?utf-8?B?TlMxSk9PVkl5Q25UbWZVdWFlWE14NG5ZbEJQczJMenVRTkFuSGwyR3UwUjVx?=
 =?utf-8?B?WElsOFJQMnFXL2lyMVNYWnducDRmTlRNYnQwa0R4bEpqc1d1dXBUV0xCdDgx?=
 =?utf-8?B?L0J4MStnM1l1YmRXRk15d0c1bGVyYU1aTE1QVm9nb0VoMUEyVEJVYUpheCtr?=
 =?utf-8?B?WXh6WGdkNEVNZGVnM2Yxb3FCc09LbzJPRG9iaGl4aEhCYzZBTkYwdzNPWUxC?=
 =?utf-8?B?cTQ4VnJPbFA5Z0dodit2eDIxM2JCMGJQNW41WTYzRDJxMVNqaEhGZGlVemwr?=
 =?utf-8?B?U2QxK1VjL0FkQldYQ09NVnFrVWtrM2xSYmJMcmNEOW44WndvL1poRWdxVlF4?=
 =?utf-8?B?bmRJUnYrK0NITzQyVGxhR29ibklZS0VUUGVMUEszQ3pDZUYzM3pSNUJFMnJ1?=
 =?utf-8?B?UGZwVHJDS1EvZkFZSFpheFlsdW9wd3k0blNqQ05RVEt1b0k1NTdsTENMMGVu?=
 =?utf-8?B?eE5mUGdSekhZdTY1WWZ6Z3BVd29udWVJVVYzaDdjM2JOb3B0SlljVElBVm9h?=
 =?utf-8?B?bnkyQTZMY3ZPMmVTY1JQWEhBN3hHQUU2S2krRkkycVROMXp1QWJTY1lyeU9h?=
 =?utf-8?B?SjNkNW14S211enRwSmEwdmxwVjZtd3JyVXRGcTRGK1JxeHVtSFFWMnBiT0dT?=
 =?utf-8?B?Vzc0dk1rbWdVSm9QbkVhRndTc05MUGJtTVFFRHZxSVVuY04yUTVZN0M0Qmky?=
 =?utf-8?B?eHRqNjdGTlZEYVVSMHBRaEhKdzh2Wm9BcUI3dGRCdlZzQnd3b05CZnpBemxm?=
 =?utf-8?B?bzM4cFdZQ0FuWm5LOVVSRGxDd2NCV0s3a3lEZGJmOHVZRFVsNFpnSlhZRXI2?=
 =?utf-8?B?TUZkbmlZc2NPbE4yUmN1YnVNMU95b1JQZGZBQTBvNFJDLzBhZzA5NnM4MFA1?=
 =?utf-8?B?aDMrVHlhSUdiWTVta1lQWlo0NEVXbVFJYzNuZkZQTjY2Mjd0V25GL1NrU2Ew?=
 =?utf-8?B?UlgraVBhZFR3aWxGZ2NoczJyK0JudlJYblkvQkJYbjNnU2tnR1gxZzRkSzB4?=
 =?utf-8?B?a2Z2VFZ1VnJ3QzdkYmpvRnVxUDREaHFiWjNjZ085ZUxYZ1hHRHRmaEZLR0pB?=
 =?utf-8?B?NFZhdmtCc2R6VEJvZEZ3RS8ycGE3Ny9EQ1pxTzgrRTZEcm1HbVVNeVFlVEY5?=
 =?utf-8?B?NWhQQVAvSlBDVmY1M0ZpREJZWFkzS1dWZ3FGd25pVTNuSENWRGFnbldHMVZn?=
 =?utf-8?B?UVFoNHZuUjY0R1lIaHNYNXBtWVdjK0xRLzc2MkQvSzdFVWdBRFdpUDFXY3NU?=
 =?utf-8?B?ZVpKdWJqV3JoZGJFUUpzenhnYXl2M1RRN2swMTRBaVdTNkRPVzhBUnJpdmFF?=
 =?utf-8?B?Z0xRYzc5dXNuMERaNnEzNzkvRXNMZTZhRS9nOEhKa052MDFaajE5YTRJYUJr?=
 =?utf-8?B?UnErd0ptYkR5TXhoZ21nTURYREdpUW1LWnpnalNNMDRKRjNKY0YrK2VBOVdE?=
 =?utf-8?B?M3c1RHVCTXhqaFdFeTI4L0RadTQ5VHErVDRyS3VoeEFVVlFyS2hZL1VDdFpC?=
 =?utf-8?B?V2ovTGVlOGtQU0hjUXdyeGhEL0hNZXhDOE5NWm5KOUlSeDVlVFlKUnRMc2xp?=
 =?utf-8?B?NGM0TkpsK25nYmJYUDMxSVVqTmFHZ2xEVXNmb05yR2hkaWdSWmxLQ2tqdVpp?=
 =?utf-8?B?Wlp1UEF2dEsxbzZWSWp6eVdMbWIzMTJmSEZWb2l2ZWpLdFVSajE0ZnVsZDJx?=
 =?utf-8?B?UDNNTkUwWDVBQWlzV1BHYjZaU2Q0UzI2d0ZMc3lnOTVKckUzaUpIOTNwcHYv?=
 =?utf-8?B?dG0zY1h6MXR3ellIYWVTUDJBQmwwYklsaUI2TGZtNm02R3VwZ0txT2FqMmE1?=
 =?utf-8?B?T2I5QXhJdlZzUnFIUTNvWFZpV0JwY256YW1URVlVaVFpM0htTGdTbG41My9l?=
 =?utf-8?B?b2lvTE1wMjZLcmFETWNsbERqb3dhZEFuSWY5amtwNmE1UWNWUk1Ga3diRndU?=
 =?utf-8?B?YllnSTRMNmI1Zzh1TW9mV0JOUUo3L3pZWFJ5S3VyN3dSR1R1M2JNVGpFVXZ1?=
 =?utf-8?B?MURDVjRvdUJ6QnEvbzJDVlFkTmIzOWt1dXdneDRQeWpYd3gvaWlHeHptQWZu?=
 =?utf-8?B?anBWeWtGc0VaaDJSVWs5YnFCc1RoL0JyUGM2dXNEL1BtNDYreGlaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c66efc-f783-460b-473d-08df49f57fe6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:38:07.5397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2iibQooULz4tVCwBaK6lR//BLMA7BMjzc9RSN81htf+tBqoaQBjHrqao+iHqgIxqJvQiv90VvbUyvA6EXKf2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
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

--------------7Qer15JqSvOP48S5XId7eFKV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/24/2026 11:46 AM, Jesse Zhang wrote:
> On GFX 11.0.0-11.0.3 only waves in the first shader array (SA0) of each
> SE can enter the trap handler, see commit 69a8c3ae2dea ("drm/amdkfd:
> apply trap workaround for gfx11"). User queues are mapped with traps
> disabled there, so a handler installed with AMDGPU_VM_OP_SET_L2_TRAP
> never runs.
>
> Like KFD does for debug sessions, restrict the compute user queues
> created while a second-level trap handler is installed to SA0 of each SE
> through the MQD CU mask, and map them with traps enabled. The decision
> is made at queue creation and kept across unmap/map.
>
> The MQD mask is only the initial value: COMPUTE_STATIC_THREAD_MGMT_SE*
> writes from the queue override it, so the UMD must keep its dispatches
> on SA0 as well.
>
> Also set the mask for SE4-SE7, which were left at 0 and thus disabled
> SE4/SE5 on Navi31.
>
> GFX user queues are not covered: the GFX11 MES firmware does not program
> TBA/TMA for the GFX queue VMID.
>
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 21 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++++++++++++-
>   4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index fea1f2b32b42..6e7ad1411071 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -696,6 +696,8 @@ int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
>   		goto out_unreserve;
>   
>   	r = amdgpu_trap_update_l2_handler(trap_obj, tba_va, tma_va);
> +	if (!r)
> +		trap_obj->l2_trap = true;
>   
>   out_unreserve:
>   	amdgpu_bo_unreserve(vm->root.bo);
> @@ -729,6 +731,8 @@ int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
>   	}
>   
>   	r = amdgpu_trap_clear_l2_handler(vm, trap_obj);
> +	if (!r)
> +		trap_obj->l2_trap = false;
>   
>   out_unreserve:
>   	amdgpu_bo_unreserve(vm->root.bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 523f65cb3d3d..516840c6fa40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -45,6 +45,9 @@ struct amdgpu_trap_obj {
>   	struct amdgpu_bo *tma_bo;
>   	struct amdgpu_bo_va *tba_va;
>   	struct amdgpu_bo_va *tma_va;
> +
> +	/* A second-level trap handler is installed for the GPUVM */
> +	bool l2_trap;
>   };
>   
>   struct amdgpu_trap_info {
> @@ -107,6 +110,24 @@ static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
>   	       gc_ver <= IP_VERSION(11, 0, 3);
>   }
>   
> +/**
> + * amdgpu_trap_vm_dbg_wa - check if user queues need the trap workaround
> + * @adev: AMDGPU device
> + * @trap_obj: first-level trap object of the GPUVM
> + *
> + * On GFX 11.0.0-11.0.3 only waves in the first shader array of each SE can
> + * enter the trap handler, so traps stay disabled there. Compute user queues
> + * created while the GPUVM has a second-level trap handler are restricted to
> + * the first shader array of each SE instead, and get traps enabled.
> + *
> + * Return: true if new compute user queues of the GPUVM need the workaround.
> + */
> +static inline bool amdgpu_trap_vm_dbg_wa(struct amdgpu_device *adev,
> +					 struct amdgpu_trap_obj *trap_obj)
> +{
> +	return amdgpu_trap_has_dbg_wa(adev) && trap_obj && trap_obj->l2_trap;
> +}
> +
>   /**
>    * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler
>    * @adev: AMDGPU device
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index fff8f1de23ea..e05130dc80ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4245,6 +4245,10 @@ static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
>   		mqd->compute_static_thread_mgmt_se1 = wa_mask;
>   		mqd->compute_static_thread_mgmt_se2 = wa_mask;
>   		mqd->compute_static_thread_mgmt_se3 = wa_mask;
> +		mqd->compute_static_thread_mgmt_se4 = wa_mask;
> +		mqd->compute_static_thread_mgmt_se5 = wa_mask;
> +		mqd->compute_static_thread_mgmt_se6 = wa_mask;
> +		mqd->compute_static_thread_mgmt_se7 = wa_mask;
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 5fdaac36b9f3..4be550abab4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -179,7 +179,13 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>   	if (fpriv->vm.trap_obj) {
>   		queue_input.tba_addr = fpriv->vm.trap_obj->tba_gpu_va_addr;
>   		queue_input.tma_addr = fpriv->vm.trap_obj->tma_gpu_va_addr;
> -		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
> +		/*
> +		 * Only the queues restricted to the CUs that can enter the
> +		 * trap handler get traps enabled with the workaround.
> +		 */
> +		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev) ||
> +			(userq_props->cu_flags &
> +			 AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE);
>   	}
>   
>   	if (mes->use_rs64mem) {
> @@ -575,6 +581,11 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   			mqd_user->flags &
>   			AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
>   
> +		/* Keep the waves where they can enter the trap handler */
> +		if (amdgpu_trap_vm_dbg_wa(adev,
> +					  uq_mgr_to_fpriv(queue->userq_mgr)->vm.trap_obj))
> +			userq_props->cu_flags = AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE;

This makes sense to me. Reusing the existing GFX11 workaround path when 
an L2 trap handler is installed looks like the right approach. 
Restricting the compute queues to the trap-capable SA0 path should make 
SLTH behavior consistent on GFX11.0.x, and the SE4-SE7 mask update also 
looks reasonable.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


--------------7Qer15JqSvOP48S5XId7eFKV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/24/2026 11:46 AM, Jesse Zhang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261124061643.2043178-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">On GFX 11.0.0-11.0.3 only waves in the first shader array (SA0) of each
SE can enter the trap handler, see commit 69a8c3ae2dea (&quot;drm/amdkfd:
apply trap workaround for gfx11&quot;). User queues are mapped with traps
disabled there, so a handler installed with AMDGPU_VM_OP_SET_L2_TRAP
never runs.

Like KFD does for debug sessions, restrict the compute user queues
created while a second-level trap handler is installed to SA0 of each SE
through the MQD CU mask, and map them with traps enabled. The decision
is made at queue creation and kept across unmap/map.

The MQD mask is only the initial value: COMPUTE_STATIC_THREAD_MGMT_SE*
writes from the queue override it, so the UMD must keep its dispatches
on SA0 as well.

Also set the mask for SE4-SE7, which were left at 0 and thus disabled
SE4/SE5 on Navi31.

GFX user queues are not covered: the GFX11 MES firmware does not program
TBA/TMA for the GFX queue VMID.

Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++++++++++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index fea1f2b32b42..6e7ad1411071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -696,6 +696,8 @@ int amdgpu_trap_vm_set_l2_trap(struct amdgpu_device *adev,
 		goto out_unreserve;
 
 	r = amdgpu_trap_update_l2_handler(trap_obj, tba_va, tma_va);
+	if (!r)
+		trap_obj-&gt;l2_trap = true;
 
 out_unreserve:
 	amdgpu_bo_unreserve(vm-&gt;root.bo);
@@ -729,6 +731,8 @@ int amdgpu_trap_vm_clear_l2_trap(struct amdgpu_device *adev,
 	}
 
 	r = amdgpu_trap_clear_l2_handler(vm, trap_obj);
+	if (!r)
+		trap_obj-&gt;l2_trap = false;
 
 out_unreserve:
 	amdgpu_bo_unreserve(vm-&gt;root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 523f65cb3d3d..516840c6fa40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -45,6 +45,9 @@ struct amdgpu_trap_obj {
 	struct amdgpu_bo *tma_bo;
 	struct amdgpu_bo_va *tba_va;
 	struct amdgpu_bo_va *tma_va;
+
+	/* A second-level trap handler is installed for the GPUVM */
+	bool l2_trap;
 };
 
 struct amdgpu_trap_info {
@@ -107,6 +110,24 @@ static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 	       gc_ver &lt;= IP_VERSION(11, 0, 3);
 }
 
+/**
+ * amdgpu_trap_vm_dbg_wa - check if user queues need the trap workaround
+ * @adev: AMDGPU device
+ * @trap_obj: first-level trap object of the GPUVM
+ *
+ * On GFX 11.0.0-11.0.3 only waves in the first shader array of each SE can
+ * enter the trap handler, so traps stay disabled there. Compute user queues
+ * created while the GPUVM has a second-level trap handler are restricted to
+ * the first shader array of each SE instead, and get traps enabled.
+ *
+ * Return: true if new compute user queues of the GPUVM need the workaround.
+ */
+static inline bool amdgpu_trap_vm_dbg_wa(struct amdgpu_device *adev,
+					 struct amdgpu_trap_obj *trap_obj)
+{
+	return amdgpu_trap_has_dbg_wa(adev) &amp;&amp; trap_obj &amp;&amp; trap_obj-&gt;l2_trap;
+}
+
 /**
  * amdgpu_trap_vm_set_l2_trap - install the second-level trap handler
  * @adev: AMDGPU device
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fff8f1de23ea..e05130dc80ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4245,6 +4245,10 @@ static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
 		mqd-&gt;compute_static_thread_mgmt_se1 = wa_mask;
 		mqd-&gt;compute_static_thread_mgmt_se2 = wa_mask;
 		mqd-&gt;compute_static_thread_mgmt_se3 = wa_mask;
+		mqd-&gt;compute_static_thread_mgmt_se4 = wa_mask;
+		mqd-&gt;compute_static_thread_mgmt_se5 = wa_mask;
+		mqd-&gt;compute_static_thread_mgmt_se6 = wa_mask;
+		mqd-&gt;compute_static_thread_mgmt_se7 = wa_mask;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5fdaac36b9f3..4be550abab4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -179,7 +179,13 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	if (fpriv-&gt;vm.trap_obj) {
 		queue_input.tba_addr = fpriv-&gt;vm.trap_obj-&gt;tba_gpu_va_addr;
 		queue_input.tma_addr = fpriv-&gt;vm.trap_obj-&gt;tma_gpu_va_addr;
-		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
+		/*
+		 * Only the queues restricted to the CUs that can enter the
+		 * trap handler get traps enabled with the workaround.
+		 */
+		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev) ||
+			(userq_props-&gt;cu_flags &amp;
+			 AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE);
 	}
 
 	if (mes-&gt;use_rs64mem) {
@@ -575,6 +581,11 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			mqd_user-&gt;flags &amp;
 			AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
 
+		/* Keep the waves where they can enter the trap handler */
+		if (amdgpu_trap_vm_dbg_wa(adev,
+					  uq_mgr_to_fpriv(queue-&gt;userq_mgr)-&gt;vm.trap_obj))
+			userq_props-&gt;cu_flags = AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE;</pre>
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
        <p>This makes sense to me. Reusing the existing GFX11 workaround
          path when an L2 trap handler is installed looks like the right
          approach. Restricting the compute queues to the trap-capable
          SA0 path should make SLTH behavior consistent on GFX11.0.x,
          and the SE4-SE7 mask update also looks reasonable.</p>
        <p>Reviewed-by: Srinivasan Shanmugam
          <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></p>
      </div>
      <br>
    </p>
  </body>
</html>

--------------7Qer15JqSvOP48S5XId7eFKV--
