Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650EFC3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 07:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E72F10E3B2;
	Tue, 20 May 2025 07:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzkraY4t";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9E210E3B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 07:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6zuZC1HncSmLdAs2mMi9vQaLbnh37EDzEQDmNByR9/2Pajf67ZexGmuwGIvv4ZPXJ6qqPsHvyVwh8JPJa1bkgWw/Rh7g0fFDF19waakxe8pKCZASr7fQCpCSVSCQs0JOjHYbIXKgwloq3HUUP/ZNO2fDkmQTaWYX7Ihj3UOoqbMsKDjTuNrMCMnzPvCwxYfbUnUK8qB3WPxHU9q2QsUgEXcFRUzoeGxSZH/JLzQn2mWRNu6Qasp3xunXeU3SnmoulMPU0HYziFYtf4pvZ5962s74wW/rUfsm/Kj19dEEy9VVTIIt8gLt9k4FEMQoQ0rKOTt5sKwfBxEnezx2FyThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRQMZR/TvYhVFXhsKzIC3sPTnqOqW8jEp74tvZ17qP8=;
 b=IoBJGcqX8isdlyHdx4x6q438tvpiwk/50YCfiNNrQ6/kM5h6mjg7avXmDr5BoVd1e/mqqIMTaBU+DaBBxkZ7+lDkYBLLom18PNNnfLFszpomBjgP+E58B/AtX/Vsa2MoxqMZOQSU8X3TmqC28R6Vktla7xRP0vCeQIi7PN4Y4ZQmMML2A1FU7LiKmg5V3JcDMX0VdryX0pbHo4z+G9j1wfQ4b0JtM6oKBvVAMXCoJCzYUdT1Ed7u15/2UdJtFUJDZT4LQzUngzRcA8CjuOu2YBOKl6RMscnWYFxzVW/D7wWHjDt4Ki6xVmfsA4FM7LFPpLJ4R/YAkfaX7x3gB0PLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRQMZR/TvYhVFXhsKzIC3sPTnqOqW8jEp74tvZ17qP8=;
 b=kzkraY4tGCD3rIzvT0ROFgRJCnX8EjMay0KnH6vtMF9VEJhMHSoHuhKwy4ehg5ooUjPfg0UAuIvMHsvQqAWcaXXm2UPyjTnES+cDJAPwDTQ/xA3cScHD1Zf7Tv7H9+tP16RzYEntcG8Ve7x5vVr92bSMe2AittCNNiodeOyNiFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:31:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 07:31:35 +0000
Message-ID: <4b05bdd8-d4e8-48be-acc0-49658642270c@amd.com>
Date: Tue, 20 May 2025 09:31:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] drm/amdgpu: Make amdgpu_ctx_mgr_entity_fini static
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
 <20250519163713.11367-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519163713.11367-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 23849a2d-28cd-43e1-b798-08dd977059af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3hVdFZna0JReGViSWxWNXdjV0UvSHBaNFFOSHlnMExTMUpDUENscXdNWlpS?=
 =?utf-8?B?TEp0ME93Vmk3Zzg0RTl3VEZyL1hMa0crMURBUjdLc0lVN2hzdkhsaEZlNEZ5?=
 =?utf-8?B?Qzh0TXB1QkU4WXQvUzdmZFFlOUdWV3VGUW1DcUVNT3NsNzFlbUpFcXNyWVlI?=
 =?utf-8?B?WGlsUTNTZVlKQmxqNDZGZE5rbGhxSmtOUDdRZXp0WkFheHR6emlyNkVpM0RJ?=
 =?utf-8?B?WlZiMjFwRTk5RmM2cGVyMko2U3kyOUdGczBpMU5NcEtxcVVmcENHSzVmMWt2?=
 =?utf-8?B?VEdjcHJuQ0NhVFBSV1c4QXUvLzJoNEVvSDQzTnB4aUJJQ3JNSFplMEtiWkF0?=
 =?utf-8?B?a2dlSXVuRDI4WWs0Vzc2NXN4eExYajZsUE9VcTRkb3hnY1BZY1kxVTB0TzVC?=
 =?utf-8?B?RmREV0RJamcza0ZPS0hRV0xuZXJ3bHh2ZmxDdFczSlFwdUFmSEg4WWNpRUpy?=
 =?utf-8?B?ZExVMGdWejFjWlFib1REUmRTanI3UEZ5aEdWQTQ5YnEzRHVZb1BZTDVQWmRO?=
 =?utf-8?B?U3hWdEM1TjBRTG80SllQa1VSNGVLR1V0YWp5WTI1RSsySGloalp0THFGOS9t?=
 =?utf-8?B?MGoxdTRwMWdwOFhERXJIVkVueXNZZ051ZUhzNld6NUJBNzBNbExWWEt4NWxw?=
 =?utf-8?B?OFlramNjU1JWdGhsTVEyVlhlejc4MFlKS0l4SGJkYmdOWCtJd3dYdE1Ha2x2?=
 =?utf-8?B?dUEzb0ZkQUhQM0wxVzVHczFmbXl5YUN5Y1IrMTFZekdlYURJNDRqSVY0aXU4?=
 =?utf-8?B?VUVJaWVxdHNwVHFKcmVLMVd0SHhvRUc1RExhWmlzMDEyYlRGZHE3VmM2QkEy?=
 =?utf-8?B?c1JIdjcxVFhZWGM3SzRISVAwU3h6aFgrMnZCMnQ1YkIvVGdyT1M0M2JBdUdm?=
 =?utf-8?B?SmtFM2IrOWQwalk1c01CdDBmRmxYblVIaWt0bG5Jd0JuTjNhZ0hNSE5zbkIy?=
 =?utf-8?B?OEdyek04VzJQR2tLUzZlQzR1K0oxWGgxY2hHdkxqRklSYk95OVZ3QmdvS2ZG?=
 =?utf-8?B?SlJBLzgrMUppY01acStmTjVHckthT2J3Zmkvb09xZjZVZlljaERIdnlDR1N2?=
 =?utf-8?B?M3hKUmt2TEtKb245VjA3MlVBV29ReVJEaGwzS0dRUUpQdjBCUS9zVG5YbFly?=
 =?utf-8?B?dVZHTmc4bWVUVU52U2R5SnNyL2hYUURIbG9zMCt6ZW1GaUwyL2ZmSml5Z1VN?=
 =?utf-8?B?cVM5NW9JRjdxQjlNUWxrVzdWNFJ5MVFiZTlUblBsdlpseTROa0o0V2tOc3dB?=
 =?utf-8?B?dkk3YVZkVTlJWXEwMUc5bVFLUG5NOGdheHIyT1hFOFArcmlTSGREMC84YUhx?=
 =?utf-8?B?UXNVakMvVlRlbFlnTVpjVFFzaC8wNUtNanFIVE1mOVI1YVVXS2MxcHFodjQy?=
 =?utf-8?B?WkhQQ0JoT1pIbWZERGowcVJ4WUExcTAzcnQrM0ZiNWtLVTg0UWFpOFNXMEkx?=
 =?utf-8?B?aW9ZSk9RdEFNYXVOdnZSWXBKZ3d5ZytKTk5VM0xUZVJaWG03US8xNm1SRmkx?=
 =?utf-8?B?OGZZdWVkT29hSC9RUHJKV1ZIb3RGVGpoKzZTeEh5c1FvQnl3ajVwUXMrQ3dh?=
 =?utf-8?B?eHFqbDU0Y0hYbGVqRHBMWG8zV0tZYktSbldOdnhoSCtUSEIvRGRVRlBvajdp?=
 =?utf-8?B?cnV3RFJXRGdtMm9Tdnp4K09naG5NSUkxeFBaMlFUb1d2K3F1WVo2S0xlb3Iw?=
 =?utf-8?B?K01EUDhxdXo2NjZHRDJuTVVFK29Wbk1LamZyalIrYkRMd1M3VWpXMFYrVTVa?=
 =?utf-8?B?SXRkQnNSdEp3Mm9XTXErNGl5MGNLTlpRVkEwVFdhM0M4ZGFwcEY4TGZlbGxT?=
 =?utf-8?B?RVhWc0JFdUV4dnppNlJQY05wSVRVZUdIMVI3UWgwQmovUjJaQzE2UlM1aS81?=
 =?utf-8?B?TVBBd1A1KzMwZkxYUkxEMkgvMkxNemlOQ2tDTzY5Q3FGM2VIWGxMM2lZdkdr?=
 =?utf-8?Q?k4CMoBpypsE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU0vdGtMQnFVK1FXTmJKTWFWUm0zcVk1OEMwN0ticjF4MjVvamUvbkZNZ3Rk?=
 =?utf-8?B?bjVqR3llMXg5clY0dngwZ0FlcGZsektLSlJSRWkzdkxndEN5Ym5TeU9rQTNq?=
 =?utf-8?B?TTZUbXhzNGpmRlVYRHAvdDBKNTNvK3NWVUUzSWx3UmNmcFpXYUtnYTBsMlpm?=
 =?utf-8?B?KzZRaHRjRnpOZDdKUkRTcGNpaXBhczByQ0NkQVM1ajJxb3c2dDVjRUh4T081?=
 =?utf-8?B?Yk9BZ0pkK2d5YmRuMWN6SGRUU29NVEo1Q1o5TWVWcEYwZkExamprTlRxUUFX?=
 =?utf-8?B?WGszM0NGaVF2UzNnVTRXRDhSY1VCQmpMTmFORjQ3KzlvbGVTenFvRE5uNWlT?=
 =?utf-8?B?bFh3dzJ0aEVVQnAvSWhzd0FnMVRGcGlDS0RjYzFVNlB4YitSSERCcjdrN09t?=
 =?utf-8?B?aDhLWVduaGx2YkROcWxpcHBObXFjeHhpY1RnWHVyRkFmOFBNc1UwV0lHcHQz?=
 =?utf-8?B?R0ZXV2JJR2RJVExPcEkraHdnejZFT2N0bmhmaXhvTDNvNlVVTEVpek9QZ2o0?=
 =?utf-8?B?TU5tczNtbkNJZ0VQTXJ0ejBTdU4zSC9obW5YcW8zZnBFWGlpcEd2bzA2RzRQ?=
 =?utf-8?B?OGwwdGx4UlozZFNlOXRGaEszaDJqdXViblk5QkI3alVGbHF5SkNDZkEzQlpt?=
 =?utf-8?B?OVVuQ29MQWpiakNEM3BFQjhPdjlLM3J1d0VXczAyOFZkT08zNDFWbHNiNVRU?=
 =?utf-8?B?VmxBckxDRm9TaUVmRzNtV0xCSnhvZis3a3ZlWWNpc0VBaVlONkFQUnVuWTNo?=
 =?utf-8?B?bGdLLzJHaVAyWjJmNFNYZzB4ajIvMTNwS2x4STFMNlh6NE5NOWNmN3FlbitR?=
 =?utf-8?B?RTMyWHUxL2Z6c0x4VkJhVVc3V2l0cEFBSEV3MG1YdnlJSzN5bXFrcTh3QUtZ?=
 =?utf-8?B?NGtDcC9DdFBtUzJDNWJFTWVxbmVFSldocmw1SS9VSlprUlR3ZVcvUm1sZUx1?=
 =?utf-8?B?ekFmTDZQUlZPdHdvTlJKWGFCQkFpQ1F3M0lhaWg2ZnNSZWZoMGZBcExDM0w3?=
 =?utf-8?B?azlyY0FpN3dtb1c2aXkwWmdpZi9xOXdYSzF5WWxrUkxyR3hGNEF6ZzR0K08v?=
 =?utf-8?B?U0kzL0VFUlhmZkZvaXorTXUySW8xN1NFLzNRS1lLRjZWWmpyTjVNNm5vZko2?=
 =?utf-8?B?MFR2QUVhb3VNYXltUFhvVVZiWGJWajYwT25HZ2luZFRYQ1BKL0RJUE5yMkgr?=
 =?utf-8?B?cTFtcXBaeUdjbkQ5b0tMdHpVRFdGaDE1RTJLdWlKempxSG44bXhON2N3RVF2?=
 =?utf-8?B?WnBDd3dDVm9kbDNXZ1ovUkIrRXU5VnliL0lUZVQ4UVlvWHgvR3V2QnN1OWZR?=
 =?utf-8?B?ZHhNN2lkUnN5SFNNK05aaTlIOXRLTDhnbmo4T29SUHVtYnFmNGlUWGRWUXNr?=
 =?utf-8?B?RVlLcmtrQ0Qzc05McFl0MDRPYk8rU1JoaEJqdU1FTkFOaTkxa2llK09JdzlM?=
 =?utf-8?B?dEJ1OHhVTDJJMmRlcWEvNm5GRVNXaTNnWmpQck9xMmIzak4rZnYranZwQVR1?=
 =?utf-8?B?d1MxRXQrK3lUT1kwRnNYUXNBUElScHNxbUNvYXlwZzlCRktOblFlVk5uS0ov?=
 =?utf-8?B?akl6bXBReDdzeFErZjFNNkpzanBJRGpEdVAraUZRcWpKdGhmdXI2c0hzSXoy?=
 =?utf-8?B?eElJYTdKdEZxQVRTOGlXeWZMSll0YXppaDdpZElySk9TWFRoMGRRNk9FZkJq?=
 =?utf-8?B?VDdhRi9pTklxWk9XaVBNZXNReGRYSm0xa0RXY3ZOYmdjem1RSUVCMFBRcUlR?=
 =?utf-8?B?VTE0Z2c3T0pQc2NsYWg0MkpLeG5xeEFYYXNyU2N3aFlKMUFnVTFHYlhyWTVt?=
 =?utf-8?B?WVUyK1RLb0hiRTJUOGVsWFErSWphejVJSnREMmhTd0pzR1NwVEpUcTd6Nm1L?=
 =?utf-8?B?WnA1M3pEK29FVGgyekJHbk9aSFVyN0xuSEkzalA2UCtZZTI5Nmd1eDJMUm83?=
 =?utf-8?B?bk4yUzJIMnVpR0kzdjhZSnBzNFRCSHNjdHFpOFFmWWtPN1JOTFhsS0k0MGhC?=
 =?utf-8?B?USs3V1o2ZFAxRFZJcmxudUhmdGxTcGd3ckdwVi94dFIwQktWelM2UGZKMGVw?=
 =?utf-8?B?UzVpbDZaZmhtbW9TVTBxbjBMNDhCRFAvbXZmWkpFdUxCdWM4RW9LN214ZFFm?=
 =?utf-8?Q?PimU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23849a2d-28cd-43e1-b798-08dd977059af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:31:35.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsqc15xofgZOC6yFm03Hes35+NeLbgvX7eqHo2UgsebdcTNOM1oNV84b2ix+serK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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

On 5/19/25 18:37, Tvrtko Ursulin wrote:
> Function amdgpu_ctx_mgr_entity_fini() only has a single local caller so
> lets make it local.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>


Alternatively we could also just inline it, but either way Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c43d1b6e5d66..4ff8552e872d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -919,7 +919,7 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  	return timeout;
>  }
>  
> -void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
> +static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	struct amdgpu_ctx *ctx;
>  	struct idr *idp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 85376baaa92f..090dfe86f75b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -92,7 +92,6 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>  
>  void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>  			 struct amdgpu_device *adev);
> -void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>  void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,

