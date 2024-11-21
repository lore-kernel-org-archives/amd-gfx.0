Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE2D6ED2F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F5D10E948;
	Thu, 21 Nov 2024 13:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHTJY39Q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE85010E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zna7XtYfw78CU4n1t9lHg1zPiftnbuaex8aFNxk/6djBtV5gMxZNuPIDc4w6/i+65xtb9ZWhCjVRqv9lUe3CMLhulH4O0r81uHYbZrS+bBxDePfhbeg31Cm0jZMsvKPlXHBq18tvm7ieY5PnhK5A1lhbBLB93mk+Ngvp4dfsrO945070JT8vvGE+kdPWYfkPSQOqQIuo3q1qrJ4aJfErMhgzNqyTNQh0nMwn6lCVX+F0S579ZWIL3NPYmAt0PkTDKGm3QjcOLXkNf7fLvPDBxQLdNLXaAUm2OS9mZgU/SItrhemyheBxb/e9cu58T6G5YRY5nAndwB3Yc0hFJybUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojq5PxBniWIUwEhXLJBJGlwKoDIi+AUawobufKeoLPs=;
 b=ecFzFozMSvc41v9CVC1AEIpkmo1LxT/KGiTEmnOeinUPhDE4b7Wuqe3sW3lwlkCunkc+e/mrWEdRu2rGagEEJ7aTWNJEibKViPHYVuoBm15Pk0ruUHbL9dITriZjpVeHV/A5XpgtFqy+acfhR/jZudMZuPNFMsahLnuZMcvVe3Zl8tT3Sk4zhsDLGWbqKCBYuh1QtwFmEqyjrVKNBXtC5/UDQKgIsrEE7bgpjyDreyIrmgWqi+FqlXZzwxrvRceLTra6plG9SRJ5I54iXiYLyNPsuDtvI9fgSDUXk9iUgSh+fRpGV+x1iw5XaVFvPFGG8jXK43Lyuh/Kv0CYolYYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojq5PxBniWIUwEhXLJBJGlwKoDIi+AUawobufKeoLPs=;
 b=UHTJY39QfV31sfyFDymfIkpm2A3sJRbvOQ9+xVUzH+1CXuWlVF2+HpGikldj9pWxt6vUDyNOzEwOc6EhP1mSBJ4H6bGkSl8/n1Q3srPOymU/FosP2YRQmmA7dpk78MaX6LoXCu5Qi/Sp2dMunPVzmf5/WYTxkzRKxiRySx8Fwxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16; Thu, 21 Nov 2024 13:33:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 13:33:46 +0000
Message-ID: <ac1777be-60fa-4911-a147-124159167793@amd.com>
Date: Thu, 21 Nov 2024 19:03:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
To: Yuan Feng <yfeng1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241119153723.2635-1-yfeng1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241119153723.2635-1-yfeng1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 62043ea4-68fa-44bc-f07b-08dd0a311fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHdZZjYyYjlBOEtxNm5JaDBzVTJQK0Z5RXpHa3ErdWQ2NVpCTTE3RlNyeDJk?=
 =?utf-8?B?WGw4QjdEQmhkMW9aQmo2RE40aW9GZVVxUitFQnI3WEY1dE1DZ3I4QU5hNVhS?=
 =?utf-8?B?alg5b2UwZzIwYXNTY2xTSEVnZ0M5MVZSdzZ4Y1ZyVXJET0ErMTMvY0tRNVZw?=
 =?utf-8?B?MDVudndGZ00rYnVEVjZoQm91blh6M0hSN3FKaFZDSXY4RFZnQWRiaGlPcDBt?=
 =?utf-8?B?algwUmVlZS9aK3JjMS9IcEJOd1hrRWJkM09xVDd5MHJzNUk5Mi9qcFkyOHQx?=
 =?utf-8?B?Y0Q0cGVaNzl1NFI0ZFVaSDhvbHF2TTgvb05lRG5ROVBWZFZGSlExd0ZoNmNp?=
 =?utf-8?B?dmNzckV1MXJSZVNJYkpFZnNuMEszSmVlVUlJMjdaaUVVckwvV2l5eDl6cmw0?=
 =?utf-8?B?UUlhRGdnUnNWdW85MjB3dTFKdU1UOEVSSmhSOFZCcWU1U1lUbk1ZQUJUVzRm?=
 =?utf-8?B?STJUZ3dMclhBd1MzSTJ6OVM5SjRWeEJGbk0zQnNoQkVTUDhnRXdFbDNpZ0tL?=
 =?utf-8?B?KzNkZjZvbXF2VWNzNjBBbzlrSzFwUmFIcUd3WXpHdHovbVpCdTdqVmh2TytD?=
 =?utf-8?B?eVpmYmMrUm1paDlvd2RGSmNNTERqZGZUUk1PbW9YL3FOM1lNeGVsMW1QZDM0?=
 =?utf-8?B?SVQzay9xUmkyRDRrbFBZQVRKdjdZZGJvZXR1ckx3S2pyYy9NU3lxZXZubXh6?=
 =?utf-8?B?RDBONkovS2hUZXRmUjlPM0JxYTZYRTJENnhkZTF3OURkeDVBVnhPTFFvelcw?=
 =?utf-8?B?b0RHT2Q0NWpkdy9MS3FaQlhVcHgxdldwdU1KUEs0bUk1ZkNveHBVUUlyL3FP?=
 =?utf-8?B?L1dTUVBraFpFSm5PdE5IWkdHT1dxdThTMzh1RmR0N3puajR3T0JiWDB4d1Nn?=
 =?utf-8?B?SUZ1K3ZHenEydFF0VWhTVEVva3BidnRPUVI0M1duS0VJNS9TUVlVN0lkL1Vj?=
 =?utf-8?B?SU9xcUtZcWZ2OXNRUUFvVkF2a2VRZjlZeTNzRzBSenJqZ3Fia0hxRk9Ra01a?=
 =?utf-8?B?M01hOTdZS1JiQklBY0pqbDZoY0RQWWZJVlpnL2QxazY3UnlUVm5PaDlQVFBG?=
 =?utf-8?B?Ym92b1ZHSEhLL2crSEQvWjFmVW5ZbUJUWW5vSVM0QXp4TWdTVnRhbGdwS252?=
 =?utf-8?B?VGRWMjFHYkVGVitRaGpMVVQzVGIxNlhZYTUydXQ4V0RDZGRhUTJhYVVZODNl?=
 =?utf-8?B?VWhXSWhiNzd5VkdSUHp5alJpYm8wc2xRZEJMZnpaUWtGaUx6S0pmSmo2WHRr?=
 =?utf-8?B?ZGR5VVlLd0oxM2JLYWxGMkYyRDNjWVNNdzdLaWJyM1Z0WmNzUWhJb01wMW5n?=
 =?utf-8?B?Y0lsUTNNejB1VGF3YjU2R09XenlobXFXOE5Fek5vTmY2SkxSblJJc2lsalY2?=
 =?utf-8?B?bHNhQXg0SW5YY0gxemNsU1Q2SFVuMDlVNjBhZ3RKb1JYZXlRcEVudy9samx0?=
 =?utf-8?B?clJJeGhaZWJXOWdKWFVjWXZjWUhyWnBaYzhuNWlua0tmZkIzblEzc2Nla2Y3?=
 =?utf-8?B?dHVVQmJDcjkvc0pycHIrTDdFbnR1dXpCb3RmT05hNGFIYm9zYXdiS3ltWEZJ?=
 =?utf-8?B?bU1qQ2lScTB6bmVrWHU3eWZ4Ukoyei9WQ09oOUpjeFdtSFd5MXRqM21RdkVQ?=
 =?utf-8?B?aUFyWXZtTmhEQTZLMVJsVWpVdnZHZ3BUWEd0WUFiU2g3YnRVdnpyNVliQXkx?=
 =?utf-8?B?VDhKSnFSc0hTbzZwNVkvRFNGa0txNC94dXRIczl5VDV2eWtjNStqQnYzbGR6?=
 =?utf-8?Q?l+XqwrDHIWTWrMm/MHpVWg94DQuhNrdBi0h7gb4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5NQ2V2RzloeWRzLzR0OEhYUnErdXFGVk0yajN6L1NjZytvRGc4T3FUQkVI?=
 =?utf-8?B?UTM1Z3lWcVU0R2VYWHpjd2tkZkJGZEhSaWdWc2tlUEd3YzhVUzR6Uk1takVD?=
 =?utf-8?B?c1Y2M09uNnVYN2NOakxwTjAyZzczMzJ0ZFRrdkVQVVYxbWk2TEVEZTZVbkZR?=
 =?utf-8?B?ZFF0ODVKbDVKR3JsTm0yK2NCaVJ4MnE2N05EVkl2bWU2b056cXZJOTRlUFZm?=
 =?utf-8?B?VXVyckhJWWZwVlhvRS9rMHVjU2I3QUpCbGtKMmIzbDF2R0tJUktkSkRsUUt2?=
 =?utf-8?B?OEg0ZDJXNDdHbWZIS1RpUExWN2p6Sk9JSys1aGZKYW9IbHRIYnRpc0lRNjFw?=
 =?utf-8?B?M3RkUFhKR01GZ1h3em9NdEROTHE4TWdCVU5jdHE3ZWNzNnhNMks1UWRVVG44?=
 =?utf-8?B?ZkhQeTI2eENhV1BRSkV6b1NQSEw3MTFIbHZ6Snk5ZDlFUW5yS3pkcndKNmdM?=
 =?utf-8?B?VDFFaEFHM2xDR2J0WXdLeU55Q3d4eUdYK2JpNWZyWlJRc0lQcWFRaUZMWnVS?=
 =?utf-8?B?ZWZxdjcwRU5XckplMzdPSUE0ZWhPcTh0aS9HYlU4R0VXVWw2M3Fpa1ZndmE3?=
 =?utf-8?B?c0RtSnFjY3lBVU9TaWVWUmdzcGVqRTlvNkIwMXNoMC80SURsVmpZMWlFSTZK?=
 =?utf-8?B?ZWtvWVlYeXdyOFF4Yk41K1AxeE9YZ1g1Y2pJOFR1bnVUcVFNenF1U2xKYnlR?=
 =?utf-8?B?b0pwUWYzUEU2VEM1K2kwTkZoTzA3c2dadURTSHBVUWxlR3RDZWR0S1JNVkZD?=
 =?utf-8?B?Y1VxeTBBYTdhN0dDRVFGajM2S2g0dVJKRXdVNTdrTjE2YkdaUlJ2MC9iMGVX?=
 =?utf-8?B?Ly9zZHNQWTgzcnpzT1dObFg1UVFGWFQ5cHBlSnNhSlRCWnYzSERpVDgxSXBa?=
 =?utf-8?B?ODNSdTAxdjJFVURlMjBGRVJPb3lHUnAveFNMMHJERkNVT2NqbWhQY1plbUhX?=
 =?utf-8?B?ckJOeWxJVlV1cUFmVVYvNDUvcmJPaWJxMDVUSzBQWFh5UlNLRkhPZnhyWGMr?=
 =?utf-8?B?aWFPOW0wK2VXVm9uZ2VFaUVMQlByM3FwV2daLzZNZ0dXUlBsdnZKOFpPQy9L?=
 =?utf-8?B?K2ZVR3hDYytPZGw5WmdMQ29aUnpiODBsaFlIcU9nUkVtemJxcThZeEVMVFFL?=
 =?utf-8?B?a2J5ck1lN0xHREVaank5cDFsNXlTaUZ4NTVGemt3OTVYRkhWbGp1WllQYVcz?=
 =?utf-8?B?OHJKU2hEUzBKZEwwMUlvbm00TENhd0ExdEMrYmNqUDRlL2F3cE4wMWxZMFpE?=
 =?utf-8?B?alA4Z3BFN0ZGcFEzR01Vd1A0WTNYbnVoMnFJTS9kQVl4Vm91MnB1ejZodWZD?=
 =?utf-8?B?OGw5WFFGam1VT2oyZzhPK2d3YkJLM21nUy9OSWxxSzZsM0RHeFlCbjN4aE5C?=
 =?utf-8?B?c21NVktQM25lYzlaUHVsb0JONFMyMzZVQ2pNb1lPdXJqdDBCRlNxaWxCa25R?=
 =?utf-8?B?WWZrVllvTXlUVXZVU0xlZjBXVnBqMzYwUHlCTDZIdjBWOVJyMzJFK2J1SU1i?=
 =?utf-8?B?WTdoWWF5QVFuc2RNREdIVGxodzNOTWhWRWV4aEtKVFhjYWMvNGlUb3plUyt0?=
 =?utf-8?B?aEpFVkw2Z1dVdXpDN3luYmlGWkpUUlFvbmtaWUFGK3NSNldGTGJESnNNdTFx?=
 =?utf-8?B?NTc1ZzJHZXBhRWtOZVVNK3ZnSXZJSVI2OXlGb1FzUVFRRGtOV0t1c2tTemJT?=
 =?utf-8?B?QWVEVkF5REhkYlhuWFdHMjBab3lJZXQ4YXk3NkxvWEs1ck0yK0FTeEsyWkZD?=
 =?utf-8?B?SXEyMFdMYytFQmVvaU1yRDhDYjZ6R2ZzaFdiRldPWTdoeG5WN3REcXpvb2k0?=
 =?utf-8?B?ZGtsK2UyQysrYW5Vc1BydGRQL0V2L1lRNnRvclpXK0dObTVQQWdDY2NmaWt5?=
 =?utf-8?B?Z0V6clVHYm80TklkTjNnRFE1Z2piY0dxWnFENllYUWwzR3hidjlheWtxOWF1?=
 =?utf-8?B?Q1VZMjdUOXF2SnBRaXFlWU92MDZGb0o5c1F2M09hMW5iNjZMSGN6WlJOTDc3?=
 =?utf-8?B?SkMxZFkzK3VxQXMvSUxydG1aTWdVS0JUMVNpaWxZWFhyUm13NUltWmw0UTFu?=
 =?utf-8?B?S3ZMRXR2T3A1bS9PQmpyQjhIUG15azJuL1NlQmVOamNvUWpnMHRibmpMTGRy?=
 =?utf-8?Q?MlvX0fAzpHnZLadfxHhKYyfPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62043ea4-68fa-44bc-f07b-08dd0a311fbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:46.2592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl3/E/KUanQA94UVOhdtljXiY42HedCZubtH8by+HhVmCTcIZT2UnUBswsAo3wM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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



On 11/19/2024 9:07 PM, Yuan Feng wrote:
> On SRIOV, guest driver and host driver might deploy different versions
> of MEC firmware binaries that lead to potential compability issues cause
> system hang. To solve this, host and guest deploy MEC fw with two level jump
> table.
> 
> Signed-off-by: Yuan Feng <yfeng1@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 03654bfda58a..6011332cce92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -45,6 +45,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
>  MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
>  
>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
> @@ -574,7 +575,11 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  {
>  	int err;
>  
> -	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +	if (amdgpu_sriov_vf(adev))
> +		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   "amdgpu/%s_sjt_mec.bin", chip_name);
> +	else
> +		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>  				   "amdgpu/%s_mec.bin", chip_name);
>  	if (err)
>  		goto out;

