Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59979C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 10:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFC310E612;
	Mon, 13 May 2024 10:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uLW//Z/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D469A10E612
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 10:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYfZYuVj26QDlMo4Lj1zvV+NxThWZmVKbtTAtAzBKO5wjqXP1yKwKHYa6oDYoN3qUDxyjYLL85yd8s2lDeAST49Jp+YB/AB+nO+78wODNVBTO7brSN38d0bNwS17mwdzejctBKw5tweBE/I+r824KrHHbyKAeFnhPZ/jn1ckKcrr2CsVPgI5c0s718A80DXD4TrktmdhbFb6F2zLlW1axarnEbWJdO2GfvLBHkwc54UVcnX3cFc8sPVInUc8qCfAUyObXZIZ97+wt4WYEPsKDLLTEW/fnlikq1ADzW3xSh93YahTpnUNyyK4NTAVHN+XS+jltboSt7pFjr5GIm0uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/0xzjW7H2GZ+Xa/9BB06ZrRqEQLt8YaqjzXvSPDPl8=;
 b=kHlnYeVMQ6cqSxQLZlVED+e8P7uXP1ZjiTbvpO4SyUd3TtlmprGddWt7OCI1tqavNlHJiEMmF1T/7vOb3VIlYdMLCuIQmYSLlbgQD2cPVHdzeLgi9BUc/G6YiuT9rZvIA06lEr1llk7GLth4KxCMAOQtt8XLEs+tCeCfKtoWNZkbRijYM5nLpBbTjNnxNToyA6XpBbeFJsw+A6qQ2AW5WZJF3w5t+J+8XkQuGepeGiDBCn//P7zR40YeauJ57HWKnqT8jh12jkeKIFZzMcYvJiBketcOdnpFiaJAlsiy0MdpJRAQ08KzgnGYIUf716Lxj4FNw2pws34wuCiZ231FRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/0xzjW7H2GZ+Xa/9BB06ZrRqEQLt8YaqjzXvSPDPl8=;
 b=1uLW//Z/BIOYjYC8CzKsrE8XqcEl7N92aLo5YbLAH5qr0x7MpoUWTSSIVIkogi90q+Pw6sxiYpmuaWYw/FmLEgG2IyrU5gCWNFQPtfdE2z32sOCVAACW4pgRt2kS/wynZrzMtBlxQKuU3oiWG773UsZ/VPZRiZ8pl+2Q0x8Nvpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:25:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:25:37 +0000
Message-ID: <c9ae408c-e852-441b-a9a1-3bd0fa3b2de1@amd.com>
Date: Mon, 13 May 2024 15:55:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Fix null pointer dereference to aca_handle
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 christian.koenig@amd.com
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-3-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240513085616.584249-3-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 84482911-d6e4-44f8-2a8e-08dc73370783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnZTZTZ6NEY1cFhyeHEzTzM5VkZkZlVLMHNFVGFocVEvc1dqUkZiaTRmTDRO?=
 =?utf-8?B?MjVwMm1jRlNrWm12cEYvd2hzMXF6djFMeDhMQjFoZVFoOXVzamU5TStFZ2VW?=
 =?utf-8?B?Y0ljYXBndndvWEs5amR6SVZvWjZUQUxGZGN4ZWpZQmVmMFN0eVA1a0N6TzVv?=
 =?utf-8?B?aXNpUEFkZC9GbUlJU0VCWFlWa0Zvb1ZlZm5nQVE4bVd1aUJvKzlqR0Y5aDdw?=
 =?utf-8?B?SGlNb2R3NHpsem9EZVUzRlJERXRRNnFNU1hMbHQ0MmQzcGxpZXV6dkZUTDcy?=
 =?utf-8?B?NFN6cmU4dkgxL2wvSXltUXRyRHd5S1RVTnk0VCtJc3JoMWlMVy9PT09Wbm5U?=
 =?utf-8?B?RGtuelQ1bFJReC9SMXA5cU1yck44ZGlndnlnTW9MZkpWSEhtK3A4SHRjcEc0?=
 =?utf-8?B?L0hQSU5jUlFpelNiRkVJdWhFVEhqQ2RsczRFaEVkUFNRODZkbUlPNHEvWG5Y?=
 =?utf-8?B?MDlKOFkvaitwd3lwaDd3V3V0V3lYS1pJbWhCbW1kem9xU1pweC9CS1RCMHBJ?=
 =?utf-8?B?THNwREJnM1p2OVU2bUF1VHRIWkxkQVk1U1dDZU02WHBEQkZ2SmdUbTY3OFBv?=
 =?utf-8?B?a3NOVXpMQk9KV2YxaUtrVlJGK1JobHY2dEp6Q0phT2ViZkVBN3ZleHk1TkJD?=
 =?utf-8?B?dU50MEZaVFlEQ2g4Y3BkQXh4SEhKdmRQdDJzdlNqcURrNUlCcVpsRG04R0FQ?=
 =?utf-8?B?TzQ5aERjNGtKWHFOTXp0K1ZiWjZXaGtleXJBWWVBWURQcUwyZzgxLzFMYWJZ?=
 =?utf-8?B?cnBVWS9SNWhBUXErdDBIVEJEbTRpQms0U3FaQnNuM3FQOUJwTHhuWFYvbE5H?=
 =?utf-8?B?VFVLTTRlQXZWMXFheVVJaHA5NVZ1SzZCME5TVUxaejJNK0dubkJlb21UQjBK?=
 =?utf-8?B?YTR1U3NsNEVCQmx5UnhXc2ovWEpMVWdpaWJPcXhmbnJsczFwUjBNbWY1L28y?=
 =?utf-8?B?bVV5ZXJlbjgwZkJvWlFXaHYyTjdndEhmdFlvM2w2aHM1dFpLNUtFVXRDQzdH?=
 =?utf-8?B?eG1hR00zRmExbXlzOWFYM1h0a0Vzc3NVNTdrb1JIVXhSY2NqZlJOMUVadFpv?=
 =?utf-8?B?Q0cwQVZiM05USVFTcVBHNnlsWGpMSWVuN3JVa09oeE1wNlFGR1VPUTBodW02?=
 =?utf-8?B?K0txd2lrZWtSOUJmdHVSRE1wL2hGU1NTTWE2YUticnN2OHVQUDAzUVE0Y3Va?=
 =?utf-8?B?LzNUaUZJUktKOFFuT1ZCdlJjdmZseWZRVXY0QmJwZ3hrWThyN1U2T2RFeWNE?=
 =?utf-8?B?dTZhKy82SFNRSlpCQW1KZmRDekJiYUhGQ2ptaVdTcU9ibnVLbndOU0FqTjZJ?=
 =?utf-8?B?Vm9PUGxSM09uTVRUeGQwMnVUajAwZkNNUkcyMy9hN1N0K0JLM3FDdjJWSUJx?=
 =?utf-8?B?NTNveVRIeWVMa2hJMzZJaitEZGRBRWdmSUhnc1dsWXBQcHlvNVBFYXJYQmJU?=
 =?utf-8?B?RGJmVXlFOGNxeUxGUVA1N3Z3RUVnTUJ5ZGJTQUdOTWhQc21zbGhYUTJkV1pt?=
 =?utf-8?B?TndCZ3Z2YUk4SnQzZnpZakVRL1Z2UVVITGNJbGFYVGFOY1UxV0xPKzNVdVFp?=
 =?utf-8?B?VnBiK3ZjbWcxMUU5T0VHWEtaM3J5eldKTjhJMWVoYThUbHp0Q1RzTmswSjly?=
 =?utf-8?B?UzZXczI4cXhRVlQ2ai91TGJydjE3OWRHMGRRYlJ3Y0FxUTd4aXhnallybWd2?=
 =?utf-8?B?OWowSW9hclNRQmlQcmUxc0J6UlRLVXc3RWhnaEdUajdhRVU0R3IwZ2dnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRUMVF5QjZmbmRGdEFGQ3M5TXJ6ZTgxcFYwV1g2NWdreFdqTW9MZC83L1Vs?=
 =?utf-8?B?SmNFUjU5eENUQW1IZ1lSUHVWWnZTQU5NZ0lWcitySUhIb2xBQ2Y0SjBNNE9a?=
 =?utf-8?B?RGJNdDQ2bzM4dnNHb2R2OFpXbzF3U2hVS3dEOVdueFExRXVoWWw5T0NLQUVu?=
 =?utf-8?B?Mk5NOTkzRk9TelZSbktWbjZzTGMwdVllYUswSHdyaWNNbHltTEpaTjNkcHBJ?=
 =?utf-8?B?MWNBQ2dPZWZBdjl0VmpheWxXZDBhNm1OMGh2RzBlaDY0dFA4eENDN1Z5bjNs?=
 =?utf-8?B?TDdQNDBiQ3oxdkk2U014Z2I1bVM3TEMzMDlGUDhFc2V3bFZIUnVsTTl4OFc5?=
 =?utf-8?B?aXZLR3Z0bjJwOXIyZC9yTzBQdzMvL3dBODV5bFNmaU5CZThkT215dmhCVVNX?=
 =?utf-8?B?MEh2SGxSaENjSjZtSmgyVjRtb1FXKzlsSlpaTWRYWVNwMWhGS002NUpmaEVL?=
 =?utf-8?B?YnovZGoyQ0NvL2czaFpDcnlEY0ptZFdpSXY4QkJ3eG9HZytTTWpMSzY5SHVn?=
 =?utf-8?B?Tmxrb2daNE1BR05zNEx4TWcwRlNJOFh5WjAzS2EvNGFKZGdWYnZ1cGMvTG55?=
 =?utf-8?B?NXppZi95L3BaTTNwK3NDOVZhY2NMU0V4aU9uRnAxK2lUYkhTcWpqL09TUjl2?=
 =?utf-8?B?MG1nT3B0MnMzSzlmaDN0ekVxR3lsdVRqNDJiQWVCd0RRRVhQUFM4T1hHYlh4?=
 =?utf-8?B?WjF3N0xnb1VmUTFNWjJkVEQ5cHlHWmZoVndVZ0lLMC9wT2N1dDY5em9oaHVs?=
 =?utf-8?B?TWVZNmQwVk8rK2QwZ25GejVUTU9pNEwxYk0xeFBzeFFqUzZPczBXVnd1L3Bi?=
 =?utf-8?B?Rk5VeG8zQ01EVFNnMFVNWFV1U044OTBwOENWcEY2cVJXeGFCR29QZmJGdVVk?=
 =?utf-8?B?SWNhSHgzQzc3cjc2QXkvY2xKcWQxRTAzZjFUT0h1QzExSDBCZU1UbGRaeEV4?=
 =?utf-8?B?UEpsRW1wajh2a213TmN3aUtycmJHejdtU05DM2dZSTdOakIrVy9qZTgrWWRO?=
 =?utf-8?B?ZFlwaEx2M2F6UU5sNi9Ca1huSmdQdGxLTFhQN1BhNGVMVE1ERmFtNFV4MDFO?=
 =?utf-8?B?dVJmQllpWkpQTGoySklqTS94M3JCRTV2YkdndVRNVFo1ZzdNdkhBS3Ayclhh?=
 =?utf-8?B?VnlJaWJyZ1hZMFV3a1RDcFRXYTJqeWhsRkZIU3NiNFpIczRjQjNCcEwrUTVy?=
 =?utf-8?B?WjByOCtOOTJ6Mm1sU1JTL1ZvbEFqL1V0YlNoelBENzJiQkxCdUpGdUlJaHVu?=
 =?utf-8?B?S0lPQjVjbzBiQVkza0w1M0RMUnlRNDBIcmRKN1h3eDRBTVVJMlNDMmh4QUlN?=
 =?utf-8?B?UXBsOW1xd1VVbXhkQjRKeGIxTmd5aE81KzVWU3NDZk1Lakk5RFJ1aElPYjlO?=
 =?utf-8?B?NXJRU1RzcEFmZzF4RjFSbzQ2WldaZGUrSnRSZW9yTnRzekZ2TjV1N2F5RmZw?=
 =?utf-8?B?cjc3V0g2N2c2d0tRdDFvNTJoQXhxVUQ0L1Nma2JTR1ZJVUFZMXMvT2tPRzBk?=
 =?utf-8?B?RjJwVnBnUVIxamMwdVNQQkZvM2pla0JLY2YvVWw3TGp3NWswd2RVUEY2ZERP?=
 =?utf-8?B?UnM3dSs3V3BnWVllMWdOSzlTMmpQZHhHczkzT0tDWU43ZG1PSW1jY3FZNFdk?=
 =?utf-8?B?ckY0aGpONDR2MjRETGEzcHpIS0dWb1VHRTNoVlIxWDh2YzhFc3VBWlRMRkQ1?=
 =?utf-8?B?c21MU1JISFFvU05qNWp4NTgzUkRES3llbHozcGdtOTMvM3pIMC84Y2tyRzFN?=
 =?utf-8?B?VzBwa3lhVU40RVliQ0FjSkViTzhmaWdZL2FBUTdFaStDdmU3M2pQN0d0azhR?=
 =?utf-8?B?UUJsQmEvZGlDNFlIa0xVamdacWM2RWpNSHE2YmZKaUVucnplOGowYnBxeG5L?=
 =?utf-8?B?ZG9hbGg4bTQrUVJMZ1hoamxiTFA5UVpUcnBtNWM2SGNNU0RzU3VvZzVGQkVY?=
 =?utf-8?B?UFVNMlN4NUpLcDBrcXRuZzJPdVpXVzlOMG1UME0yVHlyWUp5dmxOY01xU0xY?=
 =?utf-8?B?aFArZ0c5VFRWQjlpb1drVHo4U2VFZHBCV0xuRW9KYjVpNENKYlVzcjRMZ2VW?=
 =?utf-8?B?R3dVSkU0RE4zbFZ5cFF4U3gvUHFiT1pqQWhqNHNsclZNc08wd21JL01ucG0x?=
 =?utf-8?Q?NHKdp8C3drJTPgowds5gMvm9k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84482911-d6e4-44f8-2a8e-08dc73370783
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 10:25:36.9653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJNbn1IY+T0xbqWyWyh+c4rXvsO2DKoVc3MeZ0wpWqyewa6ohrbRBSEKqAluEq4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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



On 5/13/2024 2:26 PM, Ma Jun wrote:
> Check handle pointer before using it
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 28febf33fb1b..e969a7d77b4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -279,7 +279,7 @@ static struct aca_bank_error *get_bank_error(struct aca_error *aerr, struct aca_
>  int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
>  				   enum aca_error_type type, u64 count)
>  {
> -	struct aca_error_cache *error_cache = &handle->error_cache;
> +	struct aca_error_cache *error_cache;
>  	struct aca_bank_error *bank_error;
>  	struct aca_error *aerr;
>  
> @@ -289,6 +289,10 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
>  	if (!count)
>  		return 0;
>  
> +	error_cache = &handle->error_cache;
> +	if (!error_cache)
> +		return -EINVAL;

Similar as in patch 2. error_cache is not a pointer variable.

struct aca_error_cache error_cache;


Thanks,
Lijo

> +
>  	aerr = &error_cache->errors[type];
>  	bank_error = get_bank_error(aerr, info);
>  	if (!bank_error)
