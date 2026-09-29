Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB20ECA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 04:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151A010ECC9;
	Tue, 29 Sep 2026 04:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/ceW84c";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FC210ECC9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 04:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9sF9GI/jHuwaYFGtHTaWTwpcTwM8FELyn6yb7mCddLOTIsL9M0QIvQFkW/TqZGhVyUPaC8MdAGb369KpjBFn2DJB9pEuwIZmBh/SIvsbBKDLRvkMEPN16kCVAWR99qc/EqeMhDKa+fn77CaI0Tg0epsBpoAB+mcwgf6LvAAjMjmyqZ42T5uppQIiT/JPplqoNLe0wA9EsoJ0g9mByXCJtYQ6u4OXXFyDirirXn/VJYrOyytVUGBuZcqUmoUcw2lcMc8TpmFnL9TXFFRwBtSVhk6iFz4OqODbmeJi2F/z+2bb/kiW9cnlcQAjSwfMS9DcnBhK5AaBu/wLHSinT1Bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+CFkyUfKTUuq+bnfhcTnqmAdBCNEikfnK7KCykCPfU=;
 b=u0ZzRq7oGR2PFCWomlEXtk1Tqe+WlII36CaMAV26PxC2CM9OmkKeMAFJN0AfAOCE2gNq0pvB6THuGlfDdzbHGZUUqW8nptm83CEGBfk3eh7qQ/OncNPMtCqNl+8wG/MmGA+z7fmhQI1N3FdjbJYhRc+ifGJ2ODp9WPGk/vk1O8nbYchEUx0c4JaZL6FsmElbIdezSPWnlVQqZjBoxo6nHGg6YAAVVTYxEYJLsNJP7y26pcomGO96xRhiPxuNn8SlB3ythTdPlrvjiUHMskcLIh6f1jAkpxXKZzWMRYv3BvMzVuoguDhuXUKbQzN9AazI8raeL/4R519Xg3nUjC3Opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+CFkyUfKTUuq+bnfhcTnqmAdBCNEikfnK7KCykCPfU=;
 b=P/ceW84ckAhPUC4ylUIV3ArrDwXjVNEm/f23Epes2jZH7bhfmHEk8ZfovCqv0r3MaxCtfYWRDA/CVzVwFBP+3gI+MyszlfWsx3YykZfDnvL8PJ6R040w+JAUVbFaPTDTLaoPm/jisvrcNRcg/b3YVITVih6RVc5ciEQxMv8M6HY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS6PR12MB324412.namprd12.prod.outlook.com (2603:10b6:8:498::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 04:35:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 04:35:43 +0000
Message-ID: <512593be-44f1-449e-92e2-880cf38e0458@amd.com>
Date: Tue, 29 Sep 2026 10:05:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip MGCG programming on a VF for gfx v12_1
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com,
 Jane Jian <Jane.Jian@amd.com>
References: <20260924070141.2150726-1-YuBiao.Wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260924070141.2150726-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS6PR12MB324412:EE_
X-MS-Office365-Filtering-Correlation-Id: 142be02b-1b6e-4397-e187-08df1de31f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WBTaJ6p+4yqfEgRiB1DKrCgYs0BBTMZnCAu8eoM3edL20MWkewq1SaeV0fW6YBhJCevE8PsXOJFc0WEYsfN3OdM8zo5IDT3KwxQ8rDbm4E7KgUF+rSl0blwHhSJUfqOG0dTwGee8m2TfUb7q7MZj9Nv1zzcJKQQQUBDoHFwJC/nSFEoFx/Uy1rWGDAIurvqlwHhuNz2FeillsbFgUeolmNIVVeJ1J9LRGO+FAUhNGpFSM5efCpEhfc2QBGulrp2ADmRjWPQMXWzqg4PzTCfjuSBnc5xQQZt0xqdevFAZ4W0dW2K+hk3M50xJR5Yssn368MMNVdcNIew3TWmO48d59M/OR08ovGFk0rvVduoTVCcLSODt+Va8xB3m4Q2DDewlcc/d05tvCM3ABa48AERINV2TuaaHsS9sykBPpEmp0eVdmX4sqFJyD0rtcciq4+7mc0POIjDpI1nSclQ4e9noGu3jQBQdYknIK74NAUhGZqjMlSY3kj0lFu64NirItyGQjIDhsp92/n/GiaoKgsxusQ8AEwVq1iGOHVDByjJdgJNh015vlT+Ys1yf9SihJSDZKP8mjYt+uVzRdnIRjP1NFBpq9UEPh3yaQ3bsvF7K2a7LKwqQlRkRSsfmL7VqyOlZqcVWmuBEM8jKDGpEf9m6cDjtptuGeGZntGBaOMamTxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVpuaUx5dVR5dTYwZDQ1T3ZiZzdSck1LbjNSZXQza2V2d1hRdHhIYi9lSktt?=
 =?utf-8?B?RW12enpJTmoyZ21YaU5pM2ZoSHZNdy9URjhXVlM2cERwL0QwdE8xS0Q2SzFj?=
 =?utf-8?B?ZjB3ZThlUXVrcU9WNEQ5SjVWN2JlVzdZSGxkNmgvSDlzS1c1Y1E0UGpTWnNF?=
 =?utf-8?B?V3RkNXhtdHVxSENzSGx1SkdsTmZOV3BGbThickdEZHhNbktBaGZ2MEZHdXZN?=
 =?utf-8?B?QVdGZnVOczg0WE1ZRDB3azZ4R25lUDFrUWVPbTF6T3o5MUZvSmdKMDREdWNx?=
 =?utf-8?B?V3hSeWxBa0k5UElSeGx1RjBqanQ5dEhock5ZMm5nWlRpTkxodlRRaWJqaVlp?=
 =?utf-8?B?ZnhEL3RFMjZvcG9jTm1lVVY0cUFja25aT0g4eXdkcEpuUUlQbXdEY0p5TUZi?=
 =?utf-8?B?U1M5R3psQm5JVzUxbG5QMGViUnNXakJiQmc2NDNzK0tmRlBZYmFlRGhrZDBm?=
 =?utf-8?B?NzhyZjN6STFCbGhqMCtiQ2drT0ZSWklCMFM1ajVVVGhMOEhBckR0Qm9RLzl4?=
 =?utf-8?B?UkF2ZzJwYThLZ3IwSmFGNmZtVW1Mem5VYjdrbHV3cmJ5ZjJvZHZMb2JWU1du?=
 =?utf-8?B?ZkNRMEUxWHJWZDNpVER5MVl2alNoT2pDOTVjaUFJblVBUXhMZzYwRTRGb1dS?=
 =?utf-8?B?T3lzY00rUXArd3I1ZnZpL1NZQm1ic0JncFNlRGx2SHg5dWhzTytzSFBqM29l?=
 =?utf-8?B?WkFUelVjVWl0cnk3WTBVdFBwUVd4RFBsOUJiNzdhWDVPWTNMTTlvbzhFYmhG?=
 =?utf-8?B?WFlUU256ZFh3SDdZeGxYQ21iSzFrTEZyRStZK1ZWZGFKSW1CUzVFQ2s3aU1n?=
 =?utf-8?B?ZmlHZUwrMXlTbFFsRENHejNsVXdhSkdaR1RCYThxeC9XcSttbDBVNFFBRU55?=
 =?utf-8?B?R0NNTVp6U0xsRjBvYUxZMk8vckk4Q1plc0dRZzVoazlTTE1tUDV3NXpRQi9p?=
 =?utf-8?B?eDY5ckNjK2RhWGNGbEM3OTBXRjdtcFVmU0tCNm9NUmNGSG5VdEs0S2tYMVRN?=
 =?utf-8?B?U3NqOUQxbFdnbVJJaFJBWE40d1lqaFcyd3RXUGxuZnhDM0psbmZOV2xHLzI5?=
 =?utf-8?B?cFFRRzg2VVd5M0w2M0JpZTJlOEdXTHlXMUZqd0pRaXhtUjBjTnFLTWpmVHJV?=
 =?utf-8?B?YXBDTlBPYzIvL3BLVm5rUlZ5RTQyNEVkS3R1c3JQWXRvdGZyN1huU2FjRytC?=
 =?utf-8?B?TWk5eUgva0lGZ2VoWmNYWjF2YU0wcEk0OVNMbGxoeUdEWHF5U1VmUXlpMVU4?=
 =?utf-8?B?QTlWRUN5TmVWakY2ZTVrZGZka2toamhmaEwzbXFKb1lJb1I1ZnJsVmZwdHVI?=
 =?utf-8?B?VUsxcXkrUVBEUmZGS2QyWnhQTXNpNXNMVUo2R2F0MGVCdlNrTXFFdm1vS2pP?=
 =?utf-8?B?VkltS09HK3lwUXl0RzRnQ1FGRDJzbGJ5VCtHVXJpTTVnL0Q0UEdxUFFyZ3B0?=
 =?utf-8?B?d0pRM0lpZzhuTVVnN0p3bmxDNVIvTEhRWXlYbFFzZmZvb1dKaFcvVjRJcDRk?=
 =?utf-8?B?YmdzQVVtaDM0QStrUzNKK3BZcnd0b1hZVHphbE5oeVdERGNjUks0YTNiWVNv?=
 =?utf-8?B?L0lzWEJIdWtRSHRWTGtCL0VURDlwL3I4alBpTm5yL1Z0alltZE8rRUl3bW9y?=
 =?utf-8?B?cGl5Y2JDZmIrZGcweDM3cjUzRmltVzZhZDdrcVgxUzJ0WWxncVBTbVhXL2tY?=
 =?utf-8?B?VTBrRS9HVmc2YWdGRWNjajM1SkY0UUNqd05sZmdDeVEvK2sxdDR2WUJqQm82?=
 =?utf-8?B?aDlidGhwOXA5ek9HVXFDNkgvSGFUd0hmeFg3NHFDeHBzenhvY0R1dDJUMzd5?=
 =?utf-8?B?bU8rbFRRYzVvNFUrc0t1eHNhVFVKL1JlNjI0U2pWQzMrVGtGS2ZQbndZZzF3?=
 =?utf-8?B?anlHNGgybUlPcWtLdEpTS01QejdCR095QjZWeFNqcWJJS3hsMnRrNHFIektD?=
 =?utf-8?B?N3h5c1dwVFh0K2ZpU0JZTDVUcnhxRUxqS3lSbTVlbjJITXFnR0hqbVZpTlBt?=
 =?utf-8?B?QTY5U0lsa29TMjUwMjFzSWpwOUtxYWV0T3VmTlk3MWsxa1Q4dVFlZWFnUzRW?=
 =?utf-8?B?azNkNjQwVXkyQXJqQ0NJT2xHblB2WndoMTBVNXB3MWVFS1VpSUV4M2ZINTVD?=
 =?utf-8?B?OU15aG0zSncySEd5NWtFWU1nTXpaTzVxcUJtQjlac3JHS2phb3pOZ1NoT2lT?=
 =?utf-8?B?Ym1iMi9QK25BUHB4SE5VSkZNaEFHKzZXMGVnUERWVnpyOGFxMVlteU1xRmo3?=
 =?utf-8?B?Y3d5VjFvTjdUQ2FHWkNQdGMwNU9rM1NORnlnWVVZaHV0anYvdmM4NjNZcXR4?=
 =?utf-8?Q?E/n/FxPfjs/Il6By2a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142be02b-1b6e-4397-e187-08df1de31f5a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 04:35:43.5287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIMWX5Z3IWwyJ8kqYM43+1yYCivBa5lTkMrS/b0JX1eHlRFvf99QPLwEQ/C/wR3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB324412
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



On 24-Sep-26 12:31 PM, YuBiao Wang wrote:
> MGCG registers are PF-only. Skip programming them under SR-IOV.
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 4f6eac30b235..c9de9216bd65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2417,8 +2417,10 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
>   				return r;
>   		}
>   
> -		gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, false,
> -							       xcc_id, true);
> +		/* MGCG is device wide and owned by the PF */
> +		if (!amdgpu_sriov_vf(adev))
> +			gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, false,
> +								       xcc_id, true);
>   		/* GFX CGCG and LS is disabled by rlc fw */
>   		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
>   
> @@ -2440,8 +2442,9 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
>   			if (r)
>   				return r;
>   		}
> -		gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, true,
> -							       xcc_id, true);
> +		if (!amdgpu_sriov_vf(adev))
> +			gfx_v12_1_xcc_update_medium_grain_clock_gating(adev, true,
> +								       xcc_id, true);
>   	}
>   
>   	return 0;

