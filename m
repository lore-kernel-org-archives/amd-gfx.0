Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7B6C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ADA910E389;
	Fri, 31 Jan 2025 16:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NBf+8zC/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8655010E389
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFWKCLdsgZn8K2xgMo1L2ls6RA1ZyW0xi4agpULxxmy2pg9zWB9exRQkWv1f5YGaKTMTOKpidSH/aelXMoMzfh6/AreazP6/1IcfF2HSF5ymH4aQGkSHTlWS4GijDPf9NzIrsxU0CsDqo15GFKbMbNAmLkMK4CxlXwqzwx9PGEuiWQrhGkt4yGcotUYlkaQBLYHf1Ra/2UH4RgAIFNJgqu1Fs948FntT7esd0hlL4h+WEa+Feo5aGoAHgYCoXxr2W4vrqA+sSVbeev0zZtsIaGoixgWkrQq2rdf9hydKTETCM1wYntMlkMC7qimlLc7ffknNFVoSWILHy3XUR1Bb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSLtwSzixYPgXDnslmTh455RlUg/CO+ED+qK2JMq6mY=;
 b=aPaobG/ZRCJuGpdxR67KdOeGsOx7OlL+q/SfPUoZUvbgONOLsY4UsD17gwg9nj4dA5QXb1FYCeqyINfjJfcXJrjvpAH88aUtDdJZVV8wTJDp42kK7yMl8tHddouKBNbYpXi6nftuAwpVG7ummm0sQaqdrhmyR/mb6WOIr24QWVVNEnMu08ziarZKdYXQfgRHnMsAGyGeaSmeh26/E2ypsaQEisWYWzDcu1hnmQmTd3taADK8kUtEh5VLwX4XeUyrFgRINuXVDiiKuZzXOvNwh9fTozD67Wj6CasLUSYUe/ttDwXmn3cHpgxdAw1Px2vQ6Jb8efKH6NbrbnG5/9c1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSLtwSzixYPgXDnslmTh455RlUg/CO+ED+qK2JMq6mY=;
 b=NBf+8zC/n5WIjE5bSqV3SnwZSEpBJ5J5u0/isJiRX/AGGt3+HAK8eHbJ4kOWsPavBEEtKxSchpA5rRdX33iyaJtyL1Yw7hcXgwtldp7amREWnO5ZiUbIJQoJrCPnbBRp8yDMaO6DdOtkZGAa110adyEIyYLmW3EVALt00X3cH5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 16:26:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 16:26:19 +0000
Message-ID: <8371968e-e270-490e-9454-b521edceef37@amd.com>
Date: Fri, 31 Jan 2025 17:26:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: afbf5ce7-85a5-4772-87dd-08dd4213fe34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?US9FdTdLRnEycXVaVE1aOTMzTmFKN3B4SmZuWXVXY1hTdWtjRGVJL1hmTDV5?=
 =?utf-8?B?dkVYVGMzWjNDNTlkbjd1MzY4UlZ3Y3FBSGZ2R2kxdDd1cUhLZ3BCeUhiNkNQ?=
 =?utf-8?B?T28vZEFVL244K0d3d2dxOXhEV1phOWlZZmttQjdSL2J3UUprNGZIR0RRUThp?=
 =?utf-8?B?STI1WjdOMFczT0xoelQ2YzVlalhLYnV0NnhMU3FOSWdBSkREOXFpaHU1SDNp?=
 =?utf-8?B?ZjZaeGd6NzJndVgyWnNEenZwVnlabmpKd3RxNHN6NFBYRllkR0NOeitPNHJW?=
 =?utf-8?B?VHRoSW9kcmdnU0RKV2t3MG9UR3lZUzFIdDExVkkrOW85MmFLT2NZYVFST21O?=
 =?utf-8?B?eG9COHROZWZSa0Y3OUVMdURFRmRkRnR5MFFBYWhZbk1VeE9reWU2d3VrUzhu?=
 =?utf-8?B?SVYwOEFyV2ZpMzRaQ3pDekY0R1pYV2hPWjNJa1pEMXA4TEljbzlBS3JVcVBs?=
 =?utf-8?B?Z3lMZVBxcjNDa285cFQvblhIYzN5SmphdzFQVU9lRXgwMHNnVFp5OFIrbWFZ?=
 =?utf-8?B?MUU1UHg4MzVJUDFvSkMraHVJUEMxdzJueHc3QXBLNlVVK1g5MUFUSUNxMTBW?=
 =?utf-8?B?UzNicm9mcHVoRkZCTlV4dlhCMG5odUxNRFBRTXU5T1dmNjFnQ1Bxd3FWSEsz?=
 =?utf-8?B?c0ZlU3NGZWplV0ZJUFVNTXplNDkybTYzYS9VNUQwbTJ5Q04yb3ZnK0lvRC9K?=
 =?utf-8?B?L09yRHFkeUlybUVUWDk2SGEzeVFJWnBaZ0lIeU9Vd2xvZzZoa2ZYQzBGTWRK?=
 =?utf-8?B?Y3dZYTJ3aElyb3JVTzNId2tKTG9PYlFNQXFmMStDZTAvRGgwWWo0dDhFdEwv?=
 =?utf-8?B?RVphdUtNeFhFOUZkR2lxeEUyWXA1cEZHWmNFVkFlb0czOGRkd2txejRvMHdK?=
 =?utf-8?B?Mi9ScWJ0Z1lTSzM0TjJtRTlYa1YyQ1pzbkxEVytuM2tTbGFGYUFWQ3FnamZL?=
 =?utf-8?B?azU4YWtTR1QvN1BmcG00MlNrSHRKMlJPTFQ0d285MWRWUXp6WGpWWW9oL1p1?=
 =?utf-8?B?NllGdGpGdmFOL3NvMFozaUdzS2xDZWlzNS94dWlqb0JqbGUwMUVGd2dhYXo0?=
 =?utf-8?B?QzhFbWdrSzRKcVZ0bHozSHc4MFhzajg2NVUrVWRmWHRWTDloYzUwRE9OdklT?=
 =?utf-8?B?and0MWdmWjhqQ3VCTm9iZWFQREN3ZDJuTExScndhczhRR1lhcHhhM0hScEph?=
 =?utf-8?B?UVYwZnZWTmlUdDQ3VFY5K283UGVqTkk4alJSY2xVWU5WaC9mN2F3ZmtFbXBn?=
 =?utf-8?B?b1NDdkJBUWp4Vlg4Ni9VQlFESkRCbDZucHFlajgvL1g2ZUZSRnRqU3VPWkF1?=
 =?utf-8?B?Zm15em1hMlZFaEhxWWxqVzY2cHF2cXF5SENyenVOdmVXR3YxNG12eDloUGEr?=
 =?utf-8?B?UXR1em1wM3BMNjROd09OVlNnRHYwN3dNeFRoT01wR0o4d3hXelMyWVZEajFa?=
 =?utf-8?B?TFdsVXgvc1FPM0g2U2JpY2orWE80UHRETzI0clMrelo2ZXA0OFVKdDZQVHA4?=
 =?utf-8?B?QTRYSW15dzVJYXQ5SWFibUI1djNQQ0RkWUU1dUpKT09RLzNKR042VU1RWHor?=
 =?utf-8?B?eHJlL3o1VGZQWUdJcmptZlhha3FBQUpEWVZPMTBQczZaTVl2N1d1WXpvd01y?=
 =?utf-8?B?V2RLK25tU2t0MjlnODBBK0N4eDFPV0FqMkxJTnZGUVZDRDdkMkN3UDVDdS9k?=
 =?utf-8?B?bEdzNmxRbENEMHZadEhyTmE0dkFaeFZMRU53WkRUdGRHL0UzR3BBTllIM1JC?=
 =?utf-8?B?VXpYblNMbmZsNEhZR2t1V0RtS0d2OU96SHdkWjJQa2R4VmRpQ1Q1RlhwTTFU?=
 =?utf-8?B?WmFHcWYzU0JWZnJZcUN4a1RGVWVVZXlPbDFhV2MydkU4ZFc3aHEwc1dBN0Nn?=
 =?utf-8?Q?KUhfozA6IY+m2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhsMjZ2VjVzMWw5UnQ4cDN6WWc4MlpzQzBJWGpFR2NQNFZjY2pSUHd2WkN1?=
 =?utf-8?B?elQ3YUZhL3RHQzZwUHE3cWJEMktjajlESmFneDBnWGZKSzYyU0JQZjN4Zi8w?=
 =?utf-8?B?c0oxVjV3MUc1M1FaeTdKZDhWcE13M1JtNU0yRzErMGZROHRvRDBNdWRaa3lq?=
 =?utf-8?B?STZTWk9mNDl1Z21kQjdUMG9JUFh5eFZseG1SdXBVZ3NheUR6TnEva1RkMTVW?=
 =?utf-8?B?RUxaMExGek0vLytHZHdwK012VDgwUzlIUnAvaldHWFRUR2pEUjZUaTFlUWk1?=
 =?utf-8?B?dTZMOWpYSDQ3V1ZTdUpuYTlHaEJRSlQ1dGd6N2VIQjlEUWVRL2YrYmxNTXdS?=
 =?utf-8?B?b1NmUWRzdGkzb1puWkFvUzZnMnZDSFpuT2ZGenJXTFhUREU4Umx3M1liQ1o2?=
 =?utf-8?B?aDdyRHBpdDdvUUpLMHkxcW8yMWZ5VS84ME5IUHFSc2dudUp6Tk9uMEo0ckVG?=
 =?utf-8?B?NjByZXNINndSUVdaMGQ5dTltT0JmM0ZzT3NqTUthZVdaVHhQd3JDVnZjWVFP?=
 =?utf-8?B?dlNZNXdmZlJSYU55dGV6SjVKRlJ6R1dXOFFQUm51SFQycFRtcHgrV2MxOVdS?=
 =?utf-8?B?OGwyeDRjdFVvMWJBajNtbnJzdktXQ3FreHZpTjNnK212TDdtbitKZmw4cXFt?=
 =?utf-8?B?V2M5VmFDOEdEU0l2NkJrMFJuekxoYTJpNE04RVlCV3NHQVAyYXVkOUVRMkJK?=
 =?utf-8?B?TjF6bHcxMm9JbUhzVm1janlIZE1haG11Wk9xQitiZFNRQkFpZGJpVXpZWUlZ?=
 =?utf-8?B?YTNlQ1diMzlWYTdYUW1mKzJ4aWYrbkdvQ1RXV2FxZkdYdXZvcVlNM0ptdlBi?=
 =?utf-8?B?UnZVSERidm4zYjNUVDZyYisxQXJWSTF3dG91OU9LMWtzbjVLUHdhOGtNK1hy?=
 =?utf-8?B?bEdxcWNYY0ZmTTlMUzlZNmt3cURGUEhFc3dZMDZOUGNrUW9jZjJoYWMzZ250?=
 =?utf-8?B?NTVraTVGa09OWCt3MjFYVkEyNHlmbFRoekVTRlAxS3RNckM3dnBIRkl3VDFE?=
 =?utf-8?B?bUtUdWlkdXpmbGtPbGpDOFJXdEhJZ3NrL25XTFd5QlRjK2NlRytRMnk1cDB0?=
 =?utf-8?B?NXlzVnBBWFlVdXZZRzEybWtSem1kQzV5N0NlMDl3QkQ0WTNSSzUwSFFlN1BR?=
 =?utf-8?B?S04xZGU2cGtHcG1BcENlOGVUMDJ3TEpscVJWZTlHMzhETkxtS0xOdUYvbWlp?=
 =?utf-8?B?UlZMdmdYbXFLaUR2MGUzMk91ejh1UU5mc0k1THZhSHVvS2Z6TXhOUVNUMXVQ?=
 =?utf-8?B?anF6QjkxMlJjdmNUckRmMmNvelRINnY5QnRsMENnMUNidk1XSnZKZC9hWUF0?=
 =?utf-8?B?M04rZ2JHbWZoN25kNWo2SUUrT0Vub1JGRlllelJvOEQyOWFkc2FMYkxRa0cy?=
 =?utf-8?B?b29CT2JNWU1OUE5rSWlPaktCRnRsSDhjcDI0R3ExZ1VPTHN3S1ZmMFJBQ0l6?=
 =?utf-8?B?THNYRnBrUDBBWm5tQ3RHSklWNEk0eThTR20veXJMdVZndmJTKzhDWkFiTTlt?=
 =?utf-8?B?dVRFSkZwTWQ1WFNiV29vamFhdktJbXlLcG54bE9MdS9wSDNBL3AxUEt1OWZQ?=
 =?utf-8?B?QUttTUxzM3hMWlNFUEs3T1dHbCtIaFIycGxzeTVod1hBL09DYUFmOXJ3R0cv?=
 =?utf-8?B?VnBrSVU5aDA5eTVNSHplNFZucjVITGN1bnJqL295NjFqeUtJQjdpVkhqS2pK?=
 =?utf-8?B?WFJBRGF0OVhDejMzRUI0RTFjc3NEaFlQL0Q1QVVvd1hoTWNRNnpheUdoMTk2?=
 =?utf-8?B?YlFEaFdoZHpVc0RYcFNqYUxJY1k3SGtxSVdtUFhMZ0ZSUENjNnh2WkJHN2dT?=
 =?utf-8?B?Y0JYMlhDN1JTSktOcWZ4TTVXSnhhKzhGTDhRNE5ZWFprekNWc2ZiV1duU2xI?=
 =?utf-8?B?dnVQaFdVclRyN2N2c1lRdmRVV2ZiOGRsNnBtenB4M3N5em11OEd6WXlHTncy?=
 =?utf-8?B?Z2VneldzMlAzQ2xHcW14M1NnaXE0RUxsUWc2SnNiSnZldXBzWXJ2dmkrQWhh?=
 =?utf-8?B?bHFkdkxuNWpEd3dQeGJCU2dNV1BaRHJ4MitYTDg1OTNsa2wyek11SXNyNFV2?=
 =?utf-8?B?YXNRME5JVXlkNGMweFUxK1hJR0lCcVFwaWU4SEVPUWYvT0VYakEwQ1dlZDhX?=
 =?utf-8?Q?FcZj1pE/VRtFzxWRklHxv2E8U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbf5ce7-85a5-4772-87dd-08dd4213fe34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:26:19.5708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4P40TXZAujROd7+DXN5brFv4cDekWM46eefKwpCEVDME6yDL93cE3dx0zOQt9fA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

Am 31.01.25 um 17:23 schrieb Sathishkumar S:
> Add ring reset function callback for JPEG4_0_3 to
> recover from job timeouts without a full gpu reset.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 ++++++++++++++++++++++--
>   1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index be0b3b4c8690..62d8628dccc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->jpeg.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
> +	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   	if (r)
>   		return r;
> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +
>   	r = amdgpu_jpeg_sw_fini(adev);
>   
>   	return r;
> @@ -1099,6 +1098,60 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring *r;
> +	int ret, j;
> +
> +	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +		r = &adev->jpeg.inst[ring->me].ring_dec[j];
> +		r->sched.ready = false;
> +	}
> +	/* publish update */
> +	smp_rmb();

Using smp_rmb() to publish the update is 100% incorrect.

What exactly are you trying to do?

Regards,
Christian.


> +	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +		r = &adev->jpeg.inst[ring->me].ring_dec[j];
> +		if (r->pipe == j)
> +			continue;
> +		ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
> +						regUVD_JRBC0_UVD_JRBC_STATUS,
> +						jpeg_v4_0_3_core_reg_offset(j),
> +						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
> +						UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring *r;
> +	int ret, j;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	jpeg_v4_0_3_wait_for_idle_on_inst(ring);
> +	jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
> +	jpeg_v4_0_3_start_inst(ring->adev, ring->me);
> +	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +		r = &adev->jpeg.inst[ring->me].ring_dec[j];
> +		jpeg_v4_0_3_start_jrbc(r);
> +		ret = amdgpu_ring_test_helper(r);
> +		if (ret)
> +			return ret;
> +		r->sched.ready = true;
> +	}
> +	/* publish update */
> +	smp_rmb();
> +	dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
> +	return 0;
> +}
> +
>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>   	.name = "jpeg_v4_0_3",
>   	.early_init = jpeg_v4_0_3_early_init,
> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>   	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>   	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = jpeg_v4_0_3_ring_reset,
>   };
>   
>   static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)

