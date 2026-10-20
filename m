Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B0606A33A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RjBonmaL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A3810E2B0;
	Tue, 20 Oct 2026 13:37:34 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0613E10E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLYEyooyGt8RlDQZ63U1pl+XCfWs5+emecAXIEX5ERa6f3Py4Ujcjb+JdHHXt8nAcTX6AegGQx3aOOnNMOWXSpLtj43BO6TYubxZ9fufsusSyjUDdyEQvfp4mLOiq2JwZ708iU2j4tKt5dOIU3VQptfXQo1euSDQkGrux+EtG2i+0pQqZcYMrKNlcIteUnX51qdG+OMZwiYvyjqeSY/CghyuYYAQH7S4f6+sm5MeV5m11852TnkFgCaMj6ksVdjKS2JxlvIjiuw9vlhZtFhfnjc4CMh8N8U17aQig33k9p/6S8qW4XncEhA5MWLnXosRh8Vrx5DHTTjp0UiorrQUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X2oGkpRE5Ihl9R4S/zqBV01FcqXLLIUOIf1oFbysmA=;
 b=Fic9NO3LM5+XcWxTIA1Gz1/dIe814d/pd7Ga2Ckio0JAOm4fgjuLWHsOdzN9OFWtf+LvREb6ARlYY0RBqy9wIjyo6bM344l/inGK9isc9Y1+QuibGesNkLJoT8gkX1vYmb1Yi+bzPhY0UMAgkoZj37xAZDvRQ3el6DG8nPIE7WUy9+wL3ywTkMuttYOJ+CftaM4frFG0ToywkrciiqpQNXywRLyMEVgwRbhU0QW1/9lKhptsvkTHV7AeqHC0Sc0qHAFsYuKGDdCmK4Zi8bAuiO0GjsFoiBXHMkkK5S9lNwOEa1qGpQbpa9p+ug88MmhlHonovebKVHzgj5BZ7xnjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X2oGkpRE5Ihl9R4S/zqBV01FcqXLLIUOIf1oFbysmA=;
 b=RjBonmaLdUomHGxT9y4brrH/PF1YRanb+dujCshos0IXjCxCNQjKb2vGm0u+e8tUaAIOd3SWLgdpzZLV9fE/RQKmzSBYtFcyE9Lc9wgmPs++lEyeANZ66Sj1igN92sIVktk/56OVkFf8gc5gzXWWj8oY58kT7MGOVZOd8QDOzeA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Tue, 20 Oct
 2026 13:37:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 13:37:24 +0000
Message-ID: <af6a9ffd-9687-4c57-8d0b-d40aa611bd9a@amd.com>
Date: Tue, 20 Oct 2026 15:37:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Size the buffer_funcs array by maximum
 number of SDMA instances
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
 <20261020132739.31852-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020132739.31852-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6f703e-0557-4413-c025-08df2eaf4625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8pfSvZQjGngX/Bh2n/lU0zaBZaX3cZcUApmfooUDAtR4Pm9ynUaiZbacQ3c0X7YqaO665T3IF3bZOhNoj6zvMZgYLaJlRoMii+aWgJ7nHDw3p/KM4h0dbZloOY5nDAyLYXgsmZiODpM75ec9i+xq+kAdwPw7rbhG3ChZDKcHZ3ryIp0dyCMO6AdHHMQFd5nQbhgCvYDC+8eEe+o261+XkA7On1u96kc6vnw1xX6XAq840TgCWFBXAii6ArRWU+tVfa/QbuhVk6Th5kFhZRtPwjghxjPCxB3eNaCoNpaf8ZV5N0yBxsoIAkvtb1kzp0qLucfN0hCyHXWSNMlFB5QwclTam2eRTNBWxowRtBnBfVr9ivKE8/wP1pdZCLZZM5KHxd7pbobf7FkOawHMb/9l2eQH3xPB3YSuJPBxfHizEkxfZzUXUuwHhm/XfmvjI3AICwOMEk5PP6KQOWfskvq+ntYZDYKrolQMBwbdNWldLmmy2Urpmeo81yuNGnsHb6KLSgcMe7QMVZih/wxrQjkAcQNAO0Lf3SPQ7OsZj69Q9hulB7GU4lqEYwMJAa2i2U7Msfe2lHFjb+ZumYZvhvpVvT2Q5EJbqhUHbuAmT73RegBkYtfC36RUQ86XPRX6iLKhhaPkxpLt1HTYwruqlom0T06Y+TQfyss+5QJhID/VCJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1laEtXZzlhaFN5SlZrV3FHbHY4RndWU0ppVFlCR1ZVMTAvNU9KQytGbSt1?=
 =?utf-8?B?U0xhcnZ1c0gzUEtsWWhNOWJCeFdEdVFDeExxK0RZRWRSckpxY1JwOHhjRVNU?=
 =?utf-8?B?S1htcWdHbHpsTUkyNUpNbW1nRy84UnJwVWNENnZLclFhT2pwK3dheVcxRzJB?=
 =?utf-8?B?RWhmejNNRGVtZGVJYXExcWFWbVJyNG1RNVIxOTlncytwa1A4Z05UTmttUnBP?=
 =?utf-8?B?ZnlFYjdnZFBTbEtya0cwZ3pkVmZpTEZVN0c5U3Q0NklmQUV5ZlpXUUtERTIy?=
 =?utf-8?B?QzBYY1hkcVorQVczVmxTdVprUXVsbWJLQll2UWFIL1BMUjRJQ09ndFVSN1Qw?=
 =?utf-8?B?ZTA0eVVtQW1HczhaaUJmc2VKUGg3ZDdZd0hhTzJoOWZUY1l6VFlFSnMzTHRa?=
 =?utf-8?B?L0RwcXErZWNVNXM1clY1L0FVVzRRdXdIK094MWV2Rk1adlA4MTllcE01VU1K?=
 =?utf-8?B?Zzk4RlFDcnVCblVkeWE2ckdxcEJLbXRHL2Q2YkJ2T2sxcTRGS2FSYnhpUFdh?=
 =?utf-8?B?WFdRVE9ub0xuWXFheWl3WCs4R3dsUTJQZ1RvdXhWckV1ZmViL0s0TXptYnF5?=
 =?utf-8?B?QU5yN0N6aXFWOFZ1MkRFS21RRUY2bWsyR1pGRzVEQytYMWl2UUJSaEpMZStI?=
 =?utf-8?B?YXR6TTVBN1pZZnlieWxoS1UyV050L1lwL1JTQ1N0R1ZHcStaelNCSUlCMmRX?=
 =?utf-8?B?ZFMwOWs2OEpiNTQ0aTdVa1NmVHpBaGhTd05nckd4WnNVTTVXRkpxQUNoeDZk?=
 =?utf-8?B?NmRPdlZwWFZZSW1uZmVnYzNPY1RheHJ2cC9uRnp0cmRFSWNoZGF6RVFOU3hq?=
 =?utf-8?B?c2xRTzA3dk0zODVmaGVPOUJITVNJOE1yMStiSXNMTkU4djB6Yy9VU1FldWNN?=
 =?utf-8?B?REtQMDBERW0rTkZlZ0NzSi9vdS91RlVYUFBSU0xrLzN3aFBxQldWUXVFWjd2?=
 =?utf-8?B?ZXlGTTFxaFhlWEdmSmxuYWt2VXI3MFRCQldDUHZPQkdMcGJZMHYrNVpWZ3F0?=
 =?utf-8?B?MkppV2d4cVk4c0hrOVFWZkJ5Q0w0TjQvbk1Ka1I5MGh2SFF0KzBqa3NKQjB6?=
 =?utf-8?B?T1dVSEtVbU1RNTlabzdvOW8rblhnaUxhKzVSclhxZytRNHFCb1Jza1VoNHlJ?=
 =?utf-8?B?d3J0SmVNbE5WWUtuYVZnS244SFBveHJoU1c4Mk1QcXlnaVN4NEVrSXV0T2JH?=
 =?utf-8?B?T3ZzNDJxdFhadzMwaVA5MVFWNUJ4aExmaGlOQkZ5QkZDY0U1cjhNbzRyaHhs?=
 =?utf-8?B?aGFGVlVWRUJvakl2ZkhXTnhydDFrNmF2TW0wMThWcnd6cjRGT1FwakFoUXpi?=
 =?utf-8?B?SnpOREJ6YnE0NXEzMVhNLys0RUFGdlVTMzNjSzh4TXF5WXI5Nm1WYjEyR21w?=
 =?utf-8?B?Z2oyVlhQNVlEWXhlMm9YTXF5Q0FhSXFqOC9FakdTK3MwUUwrMDFxMXVaNi93?=
 =?utf-8?B?azg5TjlyWlFoeGhFVnN6bFlsZWgyNGkwdHNaUzBPVkthVFFvOE5TaFZLQmRi?=
 =?utf-8?B?MlQwaXVaZVpPbS9abUhOUngrQk0yUVZsRitPWHFSVEdNKy9iWTEybUZDSHFT?=
 =?utf-8?B?QmRVVHU3czNDREZCdUVzZS81SzBoSU9zajNWNW5NaUFGYXRvOU5nUWgvTkt2?=
 =?utf-8?B?dGs5MVhOWlovdkZuNk11VWowQVVrTUxUQ0s5b1ZlNjUrL2VGOG5mMEFqdXFE?=
 =?utf-8?B?MmNZUmN6T29VQjZsZFd4QTJEUHNjTzQ4bWpNdDY1RUNMS3ZpaXlBNExPcU11?=
 =?utf-8?B?ZG01RXU5dTBacGZFVE1veUl2Q1BrUTNMdzlWc01hVGNYeXJuNHFOM0x5a2Fn?=
 =?utf-8?B?QXZldlNSdjY3c3JTTGRvRzU4cEdrUVBib3JIcWRoY2l6bUVXVEZOdnBKZ2VN?=
 =?utf-8?B?RWgxWXBKRm0yanNnVUpBck9GN1pCQjhiREE2a2d1T0RLQTNHMTIyaUxvSW5V?=
 =?utf-8?B?R0UyQlBLRSs3c0hkM3FYNkRDWjFhNmlBc0NaY291TElCUEh0Y2J5cFNIR0sz?=
 =?utf-8?B?amJJbldqU3hrdWpwVXg0c1BEZHEyT2NFMnBWYjJFRVNjSWVCV0FidDc1RHNl?=
 =?utf-8?B?VllGa3I5QWVpQW95Y1RhT2ZHZ3A0YlNsMkNvcGtZMHl5OXh3VzdDNUdjNjF4?=
 =?utf-8?B?V29qdkRzNjU0ekhHUzNibEh6SE54WjdGbDRIZE5uVnRTTHN5azVMOU5MU0ZL?=
 =?utf-8?B?djNhT3NvZFpyZWt5eDh0Y2U3MjUyUDc0VE5tcmZ3YjA2MzBUQWZpSGFkdFBT?=
 =?utf-8?B?bUNET280NmpGU1dZcjJROVM0TGNRT0ZwR2xNNHdSSERuSkxJRkJQbDU1d2R5?=
 =?utf-8?Q?fW+L/ecOVawDrRnyzN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f703e-0557-4413-c025-08df2eaf4625
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:37:24.2467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMVFSClaJdQnpf+NVYEvgFWDDUKsq58eVSqvi1VYF603cclDcRe/rY6JT2zBz4bV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 15:27, Tvrtko Ursulin wrote:
> The array is populated from a loop capped by adev->sdma.num_instances so
> it makes sense to size it using AMDGPU_MAX_SDMA_INSTANCES and save some
> memory.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index adb6cfae5052..9856a2fc2d08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -30,6 +30,7 @@
>  #include "amdgpu_vram_mgr.h"
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_gmc.h"
> +#include "amdgpu_sdma_types.h"
>  
>  #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
>  #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
> @@ -89,7 +90,7 @@ struct amdgpu_mman {
>  
>  	/* buffer handling */
>  	const struct amdgpu_buffer_funcs	*buffer_funcs;
> -	struct drm_gpu_scheduler		*buffer_funcs_scheds[AMDGPU_MAX_RINGS];
> +	struct drm_gpu_scheduler		*buffer_funcs_scheds[AMDGPU_MAX_SDMA_INSTANCES];
>  	u32					num_buffer_funcs_scheds;
>  	bool					buffer_funcs_enabled;
>  

