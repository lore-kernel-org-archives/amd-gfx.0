Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2CCCF6491
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 04:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C5610E02C;
	Mon, 30 Sep 2024 04:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XZRth+ba";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2F510E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 04:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSRM3zYSBvC+6YubFQwOhjMR5Q/kT5YZktsoT4XHxkoMzYcjkEd1PHSHL5LTNvTHuK4NUyfTUFFMq2uz8KQVDmt8Fr2SStCDSjnShDU9wVGE7JAO2kVBP35hDFlg23IjPdWkdw6QSUR0rlDq83ktDLqqp9GCbKGUOuA4f1Cd150DTlG3YHv906g5/KPyRgchK6bL9TER9+mhErWT6o+qWwocJb9Szm3234Jg6sH4Krgrr8AcSDOxLjaWbLvmwURZOCmJXjAijR/sZInp2cDl3LwM1QEq16y9fUFIToCK9xRK8slvBE2ByUfxAmQ5kixP8YtC3Ef8Zywz954Z9P10bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljc3qSCPKl0yxiLcjzJSIxSMhftwn6Cq91j8pz6s5Do=;
 b=CDXqxUgWsY4TQTIEyR1cqO33kD+kavLsaaLCdaJsvM1ZRu1dNrrsMYCvhQZz4rIPULIBa33sYuPo05zLlG4x8jjgEz04a/ekPLcKLmbhGOsF8gJ/3w6MpS9n1dAZApbpyIbyqCRkZ2O4AZq0qdsTpM2RgeYljzFvdkg1Y9sziY9IMdscCzGNr4G98LaoEAVBCa+nkobr4Kj484GZxK9z6kqoGBzIV0wL+bV5rfu5d4fDjewjddryWNd93cMrTsvv1MQ8Z8Osf+TALrCGq2zDNLnL4VXsW/JiL7MswlVdJ+WPx/rbbo15v7FCbVCKaP/J9qR+4Gxtbf/04VqaMi3Fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljc3qSCPKl0yxiLcjzJSIxSMhftwn6Cq91j8pz6s5Do=;
 b=XZRth+bag6nf6mQd06s4BkieIYYFhRSTFgGCd1bKhqHt95LutOl1j2EZ3HhDdEtxx+bWMmzlhET6RtYswzLMNbMh/N8UT21hv7jUgzMFNT17r/G3G7kFSnMhHA66RTeKbJTxnRBRwP4CLYBGpoP68/Ez8EzHata278Bk1CinzSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 04:24:20 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 04:24:19 +0000
Message-ID: <3d0fa6e4-a211-4956-b119-1275e48ab131@amd.com>
Date: Mon, 30 Sep 2024 09:54:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/pm: implement dpm sdma reset function
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240929104856.46010-1-jiadong.zhu@amd.com>
 <20240929104856.46010-2-jiadong.zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240929104856.46010-2-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 0544fc1a-37f2-4edd-161b-08dce107c09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVlSGtkNGdZUXJwSWtabXdsc3ByMzJia21JSjU3eE5kVldTYmdFN1BWZ0du?=
 =?utf-8?B?dzZMR21tWW9qWDNDWXV5OThlTVNDZnhhcXArbTNDTkFjNXp2KzNzbVkxYzRn?=
 =?utf-8?B?b0Q5VFF2V3B1b1N3c1I0MXpaVVhKTVhVbGplNkJnZ2tUemlLREl1dEc2OWVD?=
 =?utf-8?B?T3d6RW95NzUxbXBWNGliRnQwdjZwNUdnc1JGNTNONURBNUx0WnVHK2pWdGFP?=
 =?utf-8?B?OW8xY014bmRkOWFDWlNFck90aGpVa3dzN0ZJbVMzRTJZMytFL09qZkxaUzRo?=
 =?utf-8?B?RXBlNlBsSE1PNGV4M3JTc1BQMkdsS09OZ2hhaEdVVU12UE9XVFppVVZFMyth?=
 =?utf-8?B?NHNrKzlwOGdWeTQ5ZFE5WDdXdWs4bXdQaFlraTNaTlRUL0FpTlc3RXhST3Rl?=
 =?utf-8?B?ZThnVDZON3JhSTBOcUZpVkpadnZkb05IUmhHdXoxQlV4WElUQTZ4S1JYalBH?=
 =?utf-8?B?Y3VFT0xSK1hSZjVqaU03UExoUzNha3NlSzI2T2VORU0ybi81REdoMDgvODhY?=
 =?utf-8?B?eXZWZDlWWkU0bjBHalZKeTBrWnhwcUc1S0ZjdXR0cTJKRnBXejRuQ2NGc2V6?=
 =?utf-8?B?SnVDUEQzWTV6THgrZkJEVm9ub3NJMXV1V3hueG9rOGdQeHVjZ2xhSWl1OHd1?=
 =?utf-8?B?b2E4Wm5oNTdNWUNLUGN0dlIzQjRyamRkdDVHMUhGcU13K3VXMUs4cjZWK1ND?=
 =?utf-8?B?V21sRDFEelp2UmFFMDJjd3ZQT1drUTZjVlFQV09DSkFyeHpUVEQveDNCUFpo?=
 =?utf-8?B?QzdHOEhMK0hRbTZjL2dQZDhaNVk2dk53QnZQaGE2MDR3ZWV5cUVwd0pTT0RW?=
 =?utf-8?B?aml0SWxNdlpqanZLc1lTb3BEWGZTalVFUkYzQW9oSU1SdkJIY0M5ZHdrdU5F?=
 =?utf-8?B?WVFwRy9uWTVuZ0pldWxoc0tGdUs4MEhLQTJaNlA4YXdjaVlCSDNoRXdaam5V?=
 =?utf-8?B?RHY0ZVZ6L2h6cVdGeTJYTDFMYmhNWTJSenp4Rk05Mk5QZTlpVkxGcER6bjB2?=
 =?utf-8?B?WVZEczI1NWV6TGpJTWFSenNQTjJ5aWJTZkVlamJnYXcvV1RINW9DNUxNbjFI?=
 =?utf-8?B?WjUyem9MN3Y3UnhaQnJSelM1VkhMR3BEdVZLcWRGeFhVU1F3cDNwbE1MdE1a?=
 =?utf-8?B?RWRLQlAxSDRNTW1BdCtBVEFoOHlZdFFHUUdCaVp1NHlIM2t2N0JtV1JGOTFp?=
 =?utf-8?B?YzJqY2dWeUVGcW9aa3NUQnllaUFpZ1B3MkN4RkJrNDZBSEdOaC9reU1DMzdx?=
 =?utf-8?B?NGZhSlNOYVFvWDR1Uno3L1UvSldRQUhQa0R5SzVCVEM4cnRmWHhFM1luWUla?=
 =?utf-8?B?MksyUFo3TUJWZkQ1UGNqSCsrVWM2dUZQNUMxMlZ5OWQyZHF4WjNNSk1qNzh5?=
 =?utf-8?B?eEtnUmpYS3JQYkloN2N2ZHAyU0QyUWpoUlhqS3NmdHZuWTEwclRxbGxFSkcx?=
 =?utf-8?B?Tjc4OVpCY2t6R2ZlODdjZnBFOFdHOE5YRktmMWR5dk4wRWl2dU1nQ011cTU5?=
 =?utf-8?B?Q0pGYVJ6ZVd6Ym1aU08yWDkwVUhRN3BCSEwwYy9rUGtnQmFGc2FhWEdRWS82?=
 =?utf-8?B?UUg1Q0xYdWZRdnluUWl2VHpZU1VSNythVGs2ZXZYNmdxczhNRldlUHU0NzlQ?=
 =?utf-8?B?WlFDUGd1ZWU2ejFLUkpKVEsrWW1GTzB0OUpweTBqL0NmTmdjRnVDc3V0Z1J5?=
 =?utf-8?B?a1huUnVHQ2NEdllWd1h2Zmg4NHRVdzBMLzFGM2JVK09wK3pmQ3p1eFBZczBP?=
 =?utf-8?B?T3ROYjEvV25FMzRVV1gyOTNnR1BWaEdiaFF5YXlPYktVOCt5aGMzdXN4VkNW?=
 =?utf-8?B?d2FROXVPblhuUVJkdlRiQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjR5TFlYZUxtMENVZmU3cXdJSyttVXJvZjROSVF2R3pxdklyamFiTVVlWmxI?=
 =?utf-8?B?Qlp3MjhKS2RYd29iZmh3cVJ1Z2ROSGxTWTkxN3BGS2tBSDExRERtZENwQ2sr?=
 =?utf-8?B?Q0cxQnJpM0t0SDRMN1p2WWxjOEFDUXJPS0JtTnorN3pMdUpLaG1YN2xhTEVL?=
 =?utf-8?B?cGF0d3BMZmdCZ1ZtRTlhVXZJcDRNbDNLdG9yaC9ia3YxcWhTYkpCKzVWbnJt?=
 =?utf-8?B?ZUFSSUZTVGp0YUlUODZTQVdlZzMyV2dSU29CQ1VZRGNqTkQ1QlRxZnNqdlFr?=
 =?utf-8?B?V3ppeWdUZHBvQVA2M2lBcXhGdEFPRG5xdmtrSSthVmNOVEdBZGZxTmdadTB0?=
 =?utf-8?B?NzFsRWlkcExzOGpxZjhmMDAvVDJMVnRvOFVxbmpnQWgxUU1vbStrNVFEeTlr?=
 =?utf-8?B?WG9JWEloZFlXOWJTck5XWllnaXlGQ0dkaWJ2Mm1JcklxamhEdlpzUnlaUFJv?=
 =?utf-8?B?ckJPc2hKOGgyTmV1bUNIQ1NmYlpJdkdNeVpxbTlwYmxRcG8zNU83NXZpNG9o?=
 =?utf-8?B?enZqM28rSWxkTE1jaEdaVVdjVWRWNzNkRUxQN1NPV2ZXWlJON3NQcmRZT3BZ?=
 =?utf-8?B?RmtrM3AzSzRBUXpCclpHUUlhZEROYVNuSy9oeEM5ZHBDZFZzbmhES212QzZS?=
 =?utf-8?B?S0g4YVRHcGkycGtMb2JxY2FVaXRYemZtbVhJUkVnTSt0TFR1TFo3STdHejl5?=
 =?utf-8?B?TzVJcGoxVitsb0lrR0V3ZkEvTitaU0VoMTJaQmg0alBRQjVWZXFxQVU1R2V5?=
 =?utf-8?B?Rk01dnMxNGp3aTVtRHJPZzJrQThuMmJVZUUyTmpnZWZoVFQ4WHZ2bUd3dGVI?=
 =?utf-8?B?bFp2dS82QkdQT2s1Tk90aTI4TmNzNXlFSVRvenVDcWF1MmEzdFBlRjBYZXY0?=
 =?utf-8?B?SFZEb1g5VzBZalUyL1JXcHU4RFQ5MHYyZ3RDYW92WVZsRDF3UlhiaURPRmxu?=
 =?utf-8?B?d01WWEU0SFlrNjFqQmF5SktmSzVNOUwxbDhwK1QxRFV1bnN2TjFsdkpQd20v?=
 =?utf-8?B?aHVpQXhYQjhnaTVUY1dQYzFuSVVPeGlIaWJkbThMdVNwZ0ZBbG1ld1dyazlj?=
 =?utf-8?B?L2F6OFowTnlEVThWcVgwMjgvSkliTGJLWUJJbHJEcUdqZ1phNUpFL1J0THJE?=
 =?utf-8?B?d01VUGZ0bzdkRWJBMzczdDYvdlpkbjZVVTFsTms3Q0NjNEFVLzZ2Y0dUU0FW?=
 =?utf-8?B?dUtwZmhtcVA3RmYydmt4bkFJbDRrWGpFcVRQKytuY0xCM1g5bWx3NUNlUEJF?=
 =?utf-8?B?aVphT1lMS3ZuSk4yaFpLWWVsQXQ5UEZtR2pReEJZdU1DSUs2ZjloUTdkSXVB?=
 =?utf-8?B?WkkzUVBHMVlhM0dNUS9mckZaTExnNVZOOGl2V003MWhtVGxETk9Ba3krd3Z1?=
 =?utf-8?B?akh5cUdVU2lvbXFDN2ZhaU5MYThrejZDcWU3T1VTZnVsN2xvbWNPSUtqTlIw?=
 =?utf-8?B?RTAzUzJ0TURFVzNWZlBkQXRiNzk3MUl0T2p4RXZrVlVnUnBraEkvMDNWN1l4?=
 =?utf-8?B?b1NMeTRkQUF5dkJuYk9BWDUrQjVBL0I1V0ZCTGR4VmNpRW1HTkJhSU9QTVZT?=
 =?utf-8?B?NEllL2E5WitWR2J3ZUtiNEkrNmZydXN3UVlmTlFaVXpKNjk1M001VG1jQ0ZD?=
 =?utf-8?B?U2RJQVByRkg3WDF5dTRuK0JUazVRVjNPdlRzdzVzOERZNnNZdW9JOUtETmZi?=
 =?utf-8?B?c1kxU285MmdzR3ZaVlhmNGQ2MUtkbzNycm1GQ1JrcGZTenRUckZWV2E2b0lS?=
 =?utf-8?B?YWsyYlh4TURRaTRDNG9KQkdlSENIOEtBd2pPbFd6bXRkOWMzWHU2WkpjbUpx?=
 =?utf-8?B?eWZlNGZTbHAwNTVPY041emg0bEowNDFxczJEbDJFczhXTE5UcVFxQ3VoSWFN?=
 =?utf-8?B?Znl2KzhyQ3pWd2NLZFBxUlFlZ2R4S1UrMHdwakJHSWxhbGpFNDJrK216NkRa?=
 =?utf-8?B?eFZFQTN2VndYdHBpd0JMcG5mcUpMUHJLM2VBRzF2ZFVHQTU2UkhoM0kzRDNo?=
 =?utf-8?B?SUVOSUJ3Tlh0Vk96ekcxTjc5UGZXYkhUYVZ6MHlpMlY3Y3kwTkp5M2I1QTJT?=
 =?utf-8?B?elQ4VXJTZGtwUDg2QUJTZkxlRDJIeE8rek1ZZ1puUGdWcnVNeGpUQlQzTDZk?=
 =?utf-8?Q?ZFb3tulb65th3NJVpl97g9+vr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0544fc1a-37f2-4edd-161b-08dce107c09e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:24:19.5463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL1jgydYotwy3CLB6YS0wzu7h6RCJXDaPEdNiWb2Ys6Uj6UwE7CF9YsCWoZXp8JE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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



On 9/29/2024 4:18 PM, jiadong.zhu@amd.com wrote:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> 
> Implement sdma soft reset by sending MSG_ResetSDMA on smu 13.0.6.
> 
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 15 +++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h          |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 10 ++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h    |  6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h     |  3 ++-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++++
>  6 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 9dc82f4d7c93..9e7a652d119b 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -700,6 +700,21 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
>  	return ret;
>  }
>  
> +int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	int ret;
> +
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret = smu_reset_sdma(smu, inst_mask);
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>  				  enum pp_clock_type type,
>  				  uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index f5bf41f21c41..41fb6ef984bf 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -597,5 +597,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
>  			     int policy_level);
>  ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>  				      enum pp_pm_policy p_type, char *buf);
> +int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4a6b4ad97f06..590d004046ef 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3820,3 +3820,13 @@ int smu_send_rma_reason(struct smu_context *smu)
>  
>  	return ret;
>  }
> +
> +int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
> +{
> +	int ret = 0;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma)
> +		ret = smu->ppt_funcs->reset_sdma(smu, inst_mask);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index b44a185d07e8..5487d9d84a4d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1371,6 +1371,11 @@ struct pptable_funcs {
>  	 */
>  	int (*send_rma_reason)(struct smu_context *smu);
>  
> +	/**
> +	 * @reset_sdma: message SMU to soft reset sdma instance.
> +	 */
> +	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
> +
>  	/**
>  	 * @get_ecc_table:  message SMU to get ECC INFO table.
>  	 */
> @@ -1630,6 +1635,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
>  int smu_send_rma_reason(struct smu_context *smu);
> +int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
>  int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
>  		      int level);
>  ssize_t smu_get_pm_policy_info(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index e71a721c12b9..855eb57c734d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -275,7 +275,8 @@
>  	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
>  	__SMU_DUMMY_MAP(SelectPstatePolicy), \
>  	__SMU_DUMMY_MAP(MALLPowerController), \
> -	__SMU_DUMMY_MAP(MALLPowerState),
> +	__SMU_DUMMY_MAP(MALLPowerState), \
> +	__SMU_DUMMY_MAP(ResetSDMA),
>  
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 52f3c537bb3f..6ca9bc6660cb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -182,6 +182,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
>  	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
>  	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
>  	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
> +	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
>  };
>  
>  // clang-format on
> @@ -2697,6 +2698,20 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
>  	return ret;
>  }
>  
> +static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
> +{
> +	int ret = 0;
> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu,
> +					      SMU_MSG_ResetSDMA, inst_mask, NULL);

This will need a check of FW version and IP version. Not all FWs support
reset and this file also handles other SMU 13.0.x IP versions.

If not, the below message will always show up even if unsupported which
could be misleading.

Thanks,
Lijo

> +	if (ret)
> +		dev_err(smu->adev->dev,
> +			"[%s] failed to send ResetSDMA event to SMU\n",
> +			__func__);
> +
> +	return ret;
> +}
> +
>  static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
>  {
>  	struct smu_context *smu = adev->powerplay.pp_handle;
> @@ -3342,6 +3357,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>  	.i2c_fini = smu_v13_0_6_i2c_control_fini,
>  	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
>  	.send_rma_reason = smu_v13_0_6_send_rma_reason,
> +	.reset_sdma = smu_v13_0_6_reset_sdma,
>  };
>  
>  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
