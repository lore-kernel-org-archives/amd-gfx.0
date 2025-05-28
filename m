Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B872DC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 11:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A19A10E16C;
	Wed, 28 May 2025 11:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CXDs4Mqw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7440E10E16C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 11:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AesXWh3SetHhBusBGvWSOOzqxcrx8rD+jdQS3dUNUABEx9Uk1oVX9iZXmU6ICEpc5af/9ARbke1aeXHkY7LbceJZiu9ws8q17jyHTyF7mQPWXRpWD3Y/Xz9fBhjsAYDCESR67MGE7RDs+1ULoTqYLGLxuMb8jCUwXRWtijI6h6FH6Db+4H3Mtukjq9dCu9GZA68TX33t60195t2CB1vRzj1Ip9NfwdGY0vt5ct9zOpDNWh80zdE1M7NwnLe+KxAopbgr5AjFpJx7xK6SIhibtSCWmXToWlyANF33oxuNBVOSfgB46FTcSAOF1ghzSwhiMxfiQ1V6Y23Zv6Q9ibVGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DijOhuQcPkRx+iHXp+DGgvkuEuAqPd9XvErwt8cbKFQ=;
 b=eglrDmt5MMGGUf+oQV0OffKQuQoIAY4h+3D8J1sWCZcyWIIgaRNQp+YgUI3yEKsDo/ABTAxnSKF7SErbADD1Ecw8PyexzjAtumh2gloXBOcHIR69tPU33hzJF3Eptsp9mg7fNHkPl6BrR5e3/CRu5DjVLbMF5Jn6COLkiQM6eF4yy1BLJ34cdYal8aNcpjlyj1z7re6NLarv2VWeSRYMpNoU+lfBc5cWTXZX/zxtKHArTKVC2wk3FgbkTUDL6KN/5WBbXhpt+o7JxD1XaKeq0O6DcwwTkjE2BT/024phgMvEaYuhdKV7eIr1b54vBSxBwd9NH1CV94RO7lewsLSK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DijOhuQcPkRx+iHXp+DGgvkuEuAqPd9XvErwt8cbKFQ=;
 b=CXDs4MqwGQviIF86wm4JPiC2STR4lMZZ9UNFHym0ueoZkD+PVrmb8L/EEIIjTVqZ4a8PT5UFdaYBx/4C+cQSYEISxdPSVCbmUtEeLjQhPq6YcCkScfX74hpNwzcXh1W1o6uBLjl2aiPd24z1KkXZxxfyztE3aO+5GAEwXdc1Hr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 11:40:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 11:40:16 +0000
Message-ID: <a85033a1-aea8-47a7-ac43-7e5c4a5d134b@amd.com>
Date: Wed, 28 May 2025 13:40:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] drm/amdgpu/gfx10: re-emit unprocessed state on kgq
 reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-13-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250528041914.5844-13-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:208:234::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: d23ada34-683c-4847-dc4e-08dd9ddc6a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGNCZnl2bWwreW0zSUFCRjhHR3NNandxTnVVV1Y3em00L0w0M0gxR292VWU5?=
 =?utf-8?B?dlNHL0ZJc0g0YWZvaWZYS1dFcTdxUlhEU1lpWUhQcDVMbXhyRlM4MFkvUzZU?=
 =?utf-8?B?TjFGenM2K3M2RWhvaXdjRWFLcnlpVE9lYTVSaGFaS3l3SkJmWGhUT2RyWFpO?=
 =?utf-8?B?d0Y3RGF6RVV0VVplVEJ4QTNxVmYzUXZMOXFuVWdVNGx2MUd3YWlWUjJ3c3dX?=
 =?utf-8?B?blZUeGgvUXpOWU42a09lMVhFeUNrVVhGRHAzUURQdHRuOS8xU0QxT2RNMTZT?=
 =?utf-8?B?d2t6N1FMZk9VeFlVeE81Tm5WM3FNcG56NDliZ1oxNUpWZkFWeGJaWkxMczdD?=
 =?utf-8?B?N1pnbTlmcmdhek5jNUJJR25sRFpNcXpnT1NnY0tVWkpsam5Jdm0vb3hZczJ3?=
 =?utf-8?B?ZWxZUldZZ3dzVzEySFJoamNOeHQrczJTN0FwSTNZNmlaZVV3d1I4RERxV0gv?=
 =?utf-8?B?LzZPZ3QxUm5wSU5CYnNYc3I2VUNxRGJYOUxRNEdwMm4vUnZFcC8xd1UvbHZW?=
 =?utf-8?B?TU9SU1dyMStTRFFPNldZclJOd3lVSkozL1dUdXFCMGliRWRvTTE1UW5CaVB4?=
 =?utf-8?B?ZmNQaldZdVNuZ3dUaVFEa3RqMkdOMmRIOWxQQTQwVDZmWFVSaXZmcS9OanJM?=
 =?utf-8?B?WUp3c1kwVStEektvdkU0a2pITUhMUnYrV3Q1VE9zaTBuNDBHWlRkZ1N4QmZn?=
 =?utf-8?B?L3pocjdrRm1LcGwxeXVTT290K1VudXBsd1N0VCtveWsvTzYyRW5VakNJSmVO?=
 =?utf-8?B?c25KZGNMVzNEMUJtQXN0eHU2dklueTlFdHRTZThGWlhjVEdHczNRelRYSFY3?=
 =?utf-8?B?Mm9mT25RcjlxQ0ZCbzR1U0Z5OWZEZXllYkhFd0MwbU9WSzdXNGtJNHhWdUUw?=
 =?utf-8?B?aWRrVEpsNHZqeWlrbFRuejFYMjhqWUU5aUdvM2ExcXovMFJ0ZlNZRjlRcXph?=
 =?utf-8?B?YkVUWmNFRkc2aGJVc0NlYnJmdndxb0RoS0RrTjdjQ2hCS1BQSTJYdXlQaEpp?=
 =?utf-8?B?YXlvTFU0Zk5FaW9QMVVvenIvLys1QlI2YlJkdXVqKy85UW1MSk1USHNYOEkv?=
 =?utf-8?B?LzNuMkRvMldIbGQvbUpRWGxlK3FCS3JJSml5Y1cwVkgxNUZFNzVrM0RiNzlz?=
 =?utf-8?B?Y3A3eFNYeU1aOFppYStmNUZRT0xYN0xQUGpJWTdBbHVyNnppZzVuV2hvVlAw?=
 =?utf-8?B?MWIyOER0ZnBkcDErWUFoMzEvMC9lcERrc1M3TFhNNUdDeC85b2F2Ti83cXZC?=
 =?utf-8?B?UVMzalJuMVZhWXJlQTd1T3k0NVcrbk15RFlndFh6SnVSK0dTNWRNWmpubmkz?=
 =?utf-8?B?N0xZYUZGdGhJNHhmNlRwWCsyeWFoK0FOY0ZYSnZ2eldPbVJYUmFqaktzNnZy?=
 =?utf-8?B?S2tLS3N5L3JCK3dFays4STVocGJMMjZQa2VITnplMWErL1ppQzEyMXFDTXFN?=
 =?utf-8?B?dml2aW1MaE5DMFQxUXZ1WGI5Q1N4bllOTHk1cVJzS3lRdnFmK2xNY3NOSnlr?=
 =?utf-8?B?U1lWczluSDFSWjhFM2NoUEJ5QUE1WG5wRlc0RXdIRldKWDYyWFlmTk9LRjBs?=
 =?utf-8?B?LzVnUlQ2QjFFTG83bWM3V3FPZk9aOS9SSUZnQVE2RXl3eGplSUZTb0lxVkgw?=
 =?utf-8?B?aStmRjBxaDlMMDdvamJsVzFKUkEzQlg0R0UvTm42c2ExK1BmYWh6UDBpbTZh?=
 =?utf-8?B?dTd1OC9GQ3pVWUpzOFc0VXZtSkZMVDByejRTdG9oaHlhQld6bHAxdlY5b3lP?=
 =?utf-8?B?RStZc1J0YWdxS1VhaDJFTzVkdU5qZUphcm5IY25BM1ZLR1VCbU44bG9NcXpY?=
 =?utf-8?B?NDlvWWFvQW1kbW1OWmdudUhSWUh3L3U2dzRvV281dTQzODR0UXdmTUk5WGo3?=
 =?utf-8?B?eWNlbmYvNDZENUtYNk9HYjNac054Q3NTUEhHVGw1MHVBNDcrTS9DUG9qdE9x?=
 =?utf-8?Q?+Apvs/7Bp44=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhTS20zWXhBcDJVdDJtdHZVU3FRS1k3bExLc2c0OFBiVVZVeW9kQTZLaWhV?=
 =?utf-8?B?SzVDa1dzSHZQQVl0MUxXa0dOemdmMCtkQm1wZFhYbmRtNmpuZTVuWHF1bVg1?=
 =?utf-8?B?NHBQK29HYkRES0FOd1p0RmdRVTNiM0lzb2RRTWtGdWdMcXNxa1FWbnIzTXhB?=
 =?utf-8?B?bUJXTWVieUQ3Vjl0R25ZRUU4cWwybHlsUHVxZzJXVmtNdGwzUDROOWR3WXMv?=
 =?utf-8?B?STgvVGVMRlVIMWNRRFBnb3BYRGlEdWFOejhtWWVxUWhackpMSnVlME5vTGxW?=
 =?utf-8?B?QUJKaHpOSzhQbHBXZ2k4cWsyV0VaMnR0NTNoMG1TdmROVCtLdG5mQkxaODMw?=
 =?utf-8?B?RlcwajBrN2k5V1pnRmp4MVY0cFRibmd3dzNKMmRPaU5mdmxWVWNONGJQeVJT?=
 =?utf-8?B?ZHFFRmRPUjdLS0ZmSnVnUkFvbUJ1QWNZVWwrWmhVVkw4WUF3RXBVRXFkYlB0?=
 =?utf-8?B?M2FNUU1rTlBaS0lsekV2T3p2bHZ6MDQ2OTlibUY3QTJxM0hxdXFiVXJZUXg3?=
 =?utf-8?B?bGZVTk54Y24yK1l4Si9Nb0hGQ2trY0VENUswRVQ0cXR6OWJFbHNyWHk0eG0y?=
 =?utf-8?B?NFJlVG02MHliWm41UXZ0RXMyZWtSNHdWaTBhaHVXVkRQejUxQUFHOGxnRWRr?=
 =?utf-8?B?YnBZbUZ4SmpjUzE2ZDM5cDMwQmJSVzdOMHQ4SHViZjN5Q1o3RW5USmM2eGZz?=
 =?utf-8?B?dXRJR2VraDBocmZZaGhtMjNiV3BHbFNtRXpWemZPSExoUklZbkRjeVF1TnFW?=
 =?utf-8?B?T0N6cTBwQW5sNGRqbUZ4Zm4yZ2dnYTJYZU1WeFVqdFpScGVwRS96VlVTTDlK?=
 =?utf-8?B?enlmaURWVHRLNzRWUVk5eFY3cllQUlNMOHRDallod1Q1TkFJL3FOYkVWR2FT?=
 =?utf-8?B?Q3NndnF6WTRXaFJyb3VRclg2TG5TbE9jcm5wd241ZEVaSllaK1lUSTFDK1BW?=
 =?utf-8?B?bjdwdnpSQlQ4UkdKSEI5ZVNpcVB3WTFqUmV5Wll6eGZJYU95dUo1Ti9rNStx?=
 =?utf-8?B?QWRDSDk2cU9XVS96TjRIRDFweEEvUVAwbTBJV3hOL1hBcitnQWdHOTZuTTlW?=
 =?utf-8?B?RFY3aUoxaC9mOTd4UWE2VnJZZ3NOOXR1OEFIREpZTXErMFJtVWVpejFUaytL?=
 =?utf-8?B?SlpmdFYvYnIxcTRydXUyTDdlbFNobXZlZE9HYnVLVk02alYxOHVhS01aNUhW?=
 =?utf-8?B?VWFRamhtV2xIN25tYlFITVFsZHdaVFlvVjBiZUZvcXhZSW9oak11VU1QZmIv?=
 =?utf-8?B?TWI1SEV4cktyOGJybEx3M3FLcXpIaHRUZFh5dEJtazlaNTNIOHovQTRrYlNp?=
 =?utf-8?B?ZFR0Q3hlN1NVQmRYeTF4NEJRSkxqVTlBZElYa0U1SGtNbm4wZ0hBeEdMeDhS?=
 =?utf-8?B?djlmRlFJQXpnRUdNSlRIdUZWditFTVRlNFhveDNaS1AxbTc3cWFGMFBrM3ZB?=
 =?utf-8?B?a3NqcUlFZmYvbll6L2hjYm5UREZzYWNlQ0h4d0FUWEpZZjd0ek5SM2NOcFNF?=
 =?utf-8?B?TlA4dm9CaHFiSmlVbFcyc01FdmgzU3p5S1A4NE9ibjhGbk9RaHpTR0pFQmov?=
 =?utf-8?B?aGhleGdIY291ZUtMM2l3OFBzcGQ3RlRhbkxNWjI2NENNRFBVNEN4UVVRYnYx?=
 =?utf-8?B?NVJmdTRwWTluSzRXN2dFcG5rYnU1cWw4bzFSWDJScTNEc3VXRm1rNEk5bjJ6?=
 =?utf-8?B?cjZ6b0NKbFZTbmU4UVdsMVpBakxRYXMxQ2x6Mzc1eG9wOEpxMzM0QW5DYVM2?=
 =?utf-8?B?aGxMOVc5bzBZbFBCMVV4S2VvZnoyei8yT0RvcDRmUkVrc3ljV2l4N2FISGJh?=
 =?utf-8?B?bGlPTlkxWHNldEcrWW1Nd3luWExDOW9BbjIyNVFTZ3IvaDUvQkMvTWhNSEVu?=
 =?utf-8?B?UEZvYkVRTE1ab0wrbnBseklKczRoSWdMSktHaGNBakJMakwvUGYzeEhhcXY2?=
 =?utf-8?B?R05qVXF0dmRpcEl0S2UrdXI4YlFLelcvMjdJT2RqUlZIdFdkaHg2eHF3TGE0?=
 =?utf-8?B?WDNkQ20zM05UbVZ6Q2ozYkNycmVRRmpVMjRDZHI2Y2E3d2NFNGJZZkJGeUJo?=
 =?utf-8?B?YVA2Qi81a3I1a2pHalRRVXc5QTJCNUl3NThSeXBNRmo1QUl5WHdMR1NST1dP?=
 =?utf-8?Q?3B6RgwrmjX0uBjp3tLRiI2kDZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23ada34-683c-4847-dc4e-08dd9ddc6a97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 11:40:16.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuREI82yUZ7RYoCt0GwcNJsyEdwY2JCOwdkUZFtxOpDz5k8vKx8DQjHjapiotOt+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

On 5/28/25 06:19, Alex Deucher wrote:
> Re-emit the unprocessed state after resetting the queue.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 3193eb88b6889..f6e04cf21abcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>  	struct amdgpu_ring *kiq_ring = &kiq->ring;
>  	unsigned long flags;
> +	unsigned int i;
>  	u32 tmp;
>  	u64 addr;
>  	int r;
> @@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
>  	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>  	amdgpu_ring_commit(kiq_ring);
> -
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
>  	r = amdgpu_ring_test_ring(kiq_ring);

I don't think we should do a ring test on the KIQ here That basically doesn't tells as much and might cause additional problems.

> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r)
>  		return r;
>  
> @@ -9584,7 +9583,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  		return r;
>  	}
>  
> -	return amdgpu_ring_test_ring(ring);
> +	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
> +		return -ENOMEM;
> +	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +			       ring->ring_backup_seq, 0);
> +	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +		amdgpu_ring_write(ring, ring->ring_backup[i]);
> +	amdgpu_ring_commit(ring);

I'm not sure if the commands are always relocatable. We should probably just instruct the ring to re-start with the original RPTR/WPTR.

That would also avoid the need to save/restore the ring content with the CPU.

Regards,
Christian.

> +
> +	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>  
>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -9612,9 +9619,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
>  				   0, 0);
>  	amdgpu_ring_commit(kiq_ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r)
>  		return r;
>  
> @@ -9891,7 +9897,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>  	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery = gfx_v10_0_ring_soft_recovery,
>  	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
>  	.reset = gfx_v10_0_reset_kgq,
>  	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,

