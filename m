Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05602C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 22:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F90910E9EF;
	Wed, 26 Feb 2025 22:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLnQNTrg";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A4410E9EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 22:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SStbsLz6IwQL/UxOIXJUngUTF2vCUScQMRz4HoJsY37p0v97gAzhQPEsACuhHiy4AY5O7xXxQ+2AYMDcE3ATHklVl5ai65oz+rrcv55qe6JliKamiszvT3e4voAFesvmGfjoCWO5IFRrCK+eTy2fFhwBkZ6TEY6KMNL+FazbLqZoc5wBj83dMYn/cnPo3Tc4qnapxO57YUZO9tiDfjhVZGbLELuIjlVpg+XEX/FKJnZUMLZt97y3Lim4uT0YsUD03E9pPJ6rEyrD4sm8h1mK0blouH3O7GKzX6EubXXyIGokiWy6E7YzdHeoDT3+/nhM9wx04B2LVc+67q+4j4swPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avgprvq0fjx2XttfWBTbE48/5XLgRvU5xbAk8TEzXQ8=;
 b=SIQ24krAvf5VSu2mqCevHCtT1un9D+X6D2A7PM0lLcngRM38uYe+qrRbzOTIWK5vZLIboU6kT70780dIryyB1XI9gwLmxdkN/3aBYekdIQA9bjs3rHvG/mYagCkDeqJB0QNJCt9YUePwACgs98XuExx3TGMwhYHosRiHnG8rM9DNijSqsOnCqry8MZSTfEi1zB1cvsWTI4I7wTJMJKN4gX/KlQkz6fA6ID/LajeOZrUQDTF+KdAVXFqRUK/u9XRh5T87prehrwSo54kp6uunQGSiCOO2gIwh+S69kOgzsYLaHXvRtnBjqbgJK3brd2mExh2pdoeLGA1Rd+UQKUIuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avgprvq0fjx2XttfWBTbE48/5XLgRvU5xbAk8TEzXQ8=;
 b=RLnQNTrgKDgovp/hLhRuGhFTFlSW5A4463c259yaoXghvnqKBLyvCsOzgIgGJZHuvVaj3uQ68MLYzeC8MVi+PnH7aHhPC+rMr3CZYLMSRus9sxT/LsV/5ljHNGThFIZ2OC7A72xq4faqfXFnu3QXry5400CKulI2OspW0iVhdtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 22:41:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 22:41:45 +0000
Message-ID: <32b44688-ef6b-4281-bd0a-1c5be5d96959@amd.com>
Date: Wed, 26 Feb 2025 17:41:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove kfd_pasid.c from amdgpu driver build
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250224225942.278208-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250224225942.278208-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d982960-f459-4a11-be43-08dd56b6bf41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0xtTG0zOStrT3pBdUJtaVRpampSZmw2MTRiTnowM1FWM041cEVpL05MYk5J?=
 =?utf-8?B?K1JkVlEwYS83S0t5aDZYUW1GaWtjNDlWMFlEb2pFY2o4ZnZJUUxLaTd1MGor?=
 =?utf-8?B?K0VBNW4xRllId2V2RjNPT1BPUGhXbjhjVzd2Uk9OcDFiWkRvbXlkV2dIdDJ3?=
 =?utf-8?B?Y2xxZlpnSXNGdHJtVzJFQnVNYldjY3o0MGMvbDh1V3UxQU0xaDg5Uk5uZ1VS?=
 =?utf-8?B?eFN4NFJtZ2R5VUIyc1VDeVFZR2Y3TlJPb3dSZCtmZWdFTkFKRUhuUCtqMWZK?=
 =?utf-8?B?YTVkZ1Y5MG5JZ3QwZG5lN3dTZTBCOFJsZXMyMklyODBIVnI0bDBFaVNYQXd0?=
 =?utf-8?B?MWlJTVI2cjlDS1RPMEdXd2tXN251VmNTejlZVHRlNktwcHFVSytUSDBsRFVK?=
 =?utf-8?B?TlB2eUV6RUUwaGtZTmtPR0VZVTFQS2hvK0RSc2ZTQk4wSjh4elcxWkd3VjBx?=
 =?utf-8?B?TE9YUUFUelA3Yk1IVkJWaDg4NUJFdTlOc2xEcDRxbVgxdkVyYisvVUU0TkE4?=
 =?utf-8?B?aVB0R0NVUkY2Tnk1MVl6SHVJZ25FMGc5cUh2UGs4ZW9vTlI0SS92Qzh1OHpD?=
 =?utf-8?B?L2NITVFxVnNBMHZUNW4rZUhMcTkwMzZaZUlTTXJPc1JhQU5hT0d4ckFpeUQ1?=
 =?utf-8?B?cFpORms5YkxwMzczSXJuNHJucVBCRi9wM1dDSnhTelZIMmk4Y2pYaTZTZW9F?=
 =?utf-8?B?ODVJRGU1b253NDRzcEJWN1BWYzBnNXVTSHA4cXQ3WStqVW82TlduS3pjOFA3?=
 =?utf-8?B?YllsTHZTM0V1Y1R6QWEzTkwveWwzWUlDNGNJL3ZPOFRPbWZFR2FoZXVNRWdu?=
 =?utf-8?B?QzdxZ1lhU1F2bVR0Qm5iNlB3NFBjcnN5SkhXWmtkdC9kKy92N1lPcjRzSUZv?=
 =?utf-8?B?ekNiaWtNdWcvNzhGQjA2RFJ1VFlQUW1kcXNEeHdSb3pJeW5kZVpGMkxndExt?=
 =?utf-8?B?aytVNVJEMStlZjhydHNtNFlDTnJLZExOOWVKNStmZTJuY01tcFZtOGJ4ZThH?=
 =?utf-8?B?N2xoemF4QmN4b1JMaHo2aVZZWERsbE5qQk94bmpweEs2TUgrUTVVM1BISTQ0?=
 =?utf-8?B?QnFjdlRtV1FuTHg5Uzg1d1JZRjByZEQvSDFYZndINlBmQ2JwRjdRY0kzcmJI?=
 =?utf-8?B?a0FrbVQyZnNSY2s3cDBwZm1UY3p5TWtvMFh1UEl6cGIyQ2ZZZzBIN3pzbXJU?=
 =?utf-8?B?R0hZRmE1RU5xVExGQk1XMFZNZE5ZakpjTkxTeTJHRmVGVUo4ZkJzUkNsSnB5?=
 =?utf-8?B?S29zU3FzVm80ZVI5c3pWUklyeThnNU91RGl0b201bjMzcWk0ckJIdjhJMjlz?=
 =?utf-8?B?Ty9VdGZFZHBya2s0QWFyUlJLd2ZrWUFxTFk0R1crSTJBZWwxZ1luWTJhVzE5?=
 =?utf-8?B?MzBLRlBnMEk3K2trd2dGNEN5Qjh6eDZXcjUxajdjbjNSc3RqWC9DY3I4M0RZ?=
 =?utf-8?B?azhpa3pMTXprSlVyd1pPdmdVdFR6bUluaFRSYWVlcVlmYllIMjFtK0ZraDlC?=
 =?utf-8?B?eFlvQ29xTEVndlp4T29GK2J2UlNWREUzYjQzVlI1MjFHVHFUVGVRalZsNkZa?=
 =?utf-8?B?WVlIK3RBeUIwVE9PanBQcjZtKzJTMW1zMXhmVVBEazhZMTdrOEs1MkFTL1Y4?=
 =?utf-8?B?Vy83UUpOQzkzNi9sU1QzaG5CL0NTdHk2NlJaM1VBMkQ4cmxSQ0F0T3RCY3FR?=
 =?utf-8?B?NXFKYWJYNHY4ODhTRjJVQUpIeVpvOHhqM0M5ZU1KWlhoRlQvaWZzcTdjaXNr?=
 =?utf-8?B?dXZWTjZGL3FYV0lTNWFuN1hXNWhVYkdibnloMFJwcTJtV21VL0RXc21pajVw?=
 =?utf-8?B?cWQvMkgwWkN2SFN4bk9zUTExZzFONEloUnR1MlZFMFhzWkNXbmwwYTZqWXNj?=
 =?utf-8?Q?JDEFJ6eeEMBWF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW93NTBXTXJrV29EQWpBV0pOYVJENzFYeWIyVGwycWlIMTJQYTBFRXc5aUVB?=
 =?utf-8?B?RkNNUEJ4bTc5aHcwcld5RkQvRWMzU2s5dlJFNklNR3VLSXlTZFMvK1hhVkk0?=
 =?utf-8?B?S2Y0aW1OcFAyWWZKS01odURXQ0ZidTMwSUdDMWtCQ0FvQlhZNXpXSFBhWEdN?=
 =?utf-8?B?V3I0VSs1SzVWV3BSVmg2OTFUaW05OHpwcmV3R2VDUng0eDZiN1lxSTkvZXhS?=
 =?utf-8?B?SldSUVo2NkJtSjJnbk9UODBhSkFqVVJqek1wL2NtYXdYTjI4bUFmRC91MUY1?=
 =?utf-8?B?a0djVUZsdURLbW1lUzZaUWUyeEZ6aXNZWDI0RDc2WmhoWGVRcDYxUU5GL3Ju?=
 =?utf-8?B?SCsrait3V2xiRXg2SURkaHljMkljWEdFR1lwKzFkZnppMHpZNlQ4Z3JJbHpR?=
 =?utf-8?B?UGxZN2Q5QU9WYUFrZFNJYnhoMDRpMlpveHJMWS92NlluY09RVEdtR3laN2ov?=
 =?utf-8?B?UzI4dzJmbFZsaTdZZnYwRzYzUlNBcG93YXF1NFBPL0xhZmY4OXN4OWR0MnFW?=
 =?utf-8?B?TytBKzNPQ09sNXdaSWNQUFB0NzlIbkpLTFZrQWc3VHpsUTZ0Y1BzMnFUbjZG?=
 =?utf-8?B?TFV3dFMyNzhmZlpTeTBLL3FOaWQ1UFJEWFNGQjlTQ2IyZ3FSWnRFOFAyL2ky?=
 =?utf-8?B?Y3hNRW00ckRwbVd4dVIrZzFLRGN2N1BTNDllVjdmRUFGY3pBcGhTV2VIcXNh?=
 =?utf-8?B?ZERYRzBDajhEWml4bWxVcWJ1MUtCTWFnaDN5S2UyWmJiVllOUWZmUFhQd05v?=
 =?utf-8?B?QVcxUVg4UjVaTDNZT0tXNzB2djdFVHVseS9CQWNiSHB1TGhEN2N4NTF5ekFl?=
 =?utf-8?B?eFJ2Qzk2YUhTOHdMMFZVdVVyUzdkazYzWjVwbUdYMk0rNFlWVjQ5b1J0OUJD?=
 =?utf-8?B?eUVaVXphaHoyZmN4bmkzbHgzSUhjU0NYNUxYZFZ2cG5nLzlBckNxM1Zhd3A0?=
 =?utf-8?B?cVdFWWxNT2taNlo3NFdzdnNzOEluN2JDY05QWWg4S1RHcjFYMG1LTEhXWkty?=
 =?utf-8?B?K0VHdXJad1NPT05NUG9CZCtCaWhYVU1pMXR2TVZOcTczOGlYZWh3aUNaaVBN?=
 =?utf-8?B?ZzZUVy91clRjaWxKbWhTOVNEZFhCS2kwbzBaMjlScUVURlh3RURnQXpjZW5F?=
 =?utf-8?B?QUpRVEdINFdIYUc1eWRkOWhVcytEN0RZcXMzcXdhNms0bFY4Ui9NVEp6cVFI?=
 =?utf-8?B?ZHBBM3k2OFZGV3hsLytHWnQzTnRPajBvQWc1alZ1Y1FJU081QUhJTHFLL2NJ?=
 =?utf-8?B?eDVldzVOWVpkQ2VMNDMxRnh1VDAzbkc5MUZ2S3BnM2VIR0xNVWo0cWp0VGhH?=
 =?utf-8?B?UGlPMldiNVZGRGFNQlFlaFppWURXMVlNWjhlMk5xRURKZHdSQnRTTWdKSEJt?=
 =?utf-8?B?Yk5NblFmNnl5L3FveEg2ZzJWTmhCZVNHWEJtYXZRM3ZlT2RTQ3AvMUJacnNE?=
 =?utf-8?B?S0VYQ1hCemtLaWFuRHBNVm9ueVVRTmUxRGZZNzAvWDFVcWxjTGZzdUJmMG1U?=
 =?utf-8?B?Y00xWlVFRGJSMEgxdm5iZTBJbTRGUE9xalBFRVNHNkNUUm03cEgwOE4yWnVJ?=
 =?utf-8?B?amU3RGwweEo5THB5cTFZQ0hKeHNNNEJtQUNDa3RQQlNqYm14Sjl3dHFkbUI3?=
 =?utf-8?B?TFFiOWpWOVhjNVJ1dVlQeTVTaFlzL2Fyc2tTQVRaUjU2UVRYQVlkR21nNEw0?=
 =?utf-8?B?WlcwYnVtZ2s4SDFLRzdqNmZ5dUh6T2lWemkvRlRCZFJFdlhtaTMzbmpZV3ZG?=
 =?utf-8?B?c1hRb0kyWVgzZkI2Wk9mUmovYU1GM3ptRXQxMlBhakFscjFLV1lHWnh0TGdS?=
 =?utf-8?B?VGRlakhOYVY5RjBzVGE2eXVzV1JEcDc3WG5KVEdHT3JnY2UvTmc2QklGSVZK?=
 =?utf-8?B?TXoyRGU0dHFWMEdQQ0UwcWY3Ny9vTGp2TnFtd093bUcydEN1N3QxaDI0angz?=
 =?utf-8?B?RTk5K28wcHRzdE95MXFlbUUrUXN2YkUvZzNudTkxTllJWVhoZEk5OCtIWjNw?=
 =?utf-8?B?dmFPbkN4SGtDSjJ6UmJQcFdPVWowMGdoTVozMjNIT0xVMC9UTXlaNldpcXBq?=
 =?utf-8?B?ZWRvRnYySUwxMHlOdFdlaVNXYkFMS0Nra2hub3doblkvREhQcDdzRnc2VHpo?=
 =?utf-8?Q?LBRWX0s5IbVvzQGhKph+wgG8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d982960-f459-4a11-be43-08dd56b6bf41
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 22:41:45.1281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bq5jWWWsNY55hK0oTSt2EUrmVKHKwvrdCvEXUgso/e+72iRPFxNNLfdPR/SUYWRtT0+fdLrfRHkv7W4KE3Enzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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

On 2025-02-24 17:59, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Since kfd uses pasid values from graphic driver now do not need use kfd pasid
> fucntions.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/Makefile    |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_pasid.c | 46 --------------------------
>   2 files changed, 47 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
> index 0d3d8972240d..0ce08113c9f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -27,7 +27,6 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
>   		$(AMDKFD_PATH)/kfd_device.o \
>   		$(AMDKFD_PATH)/kfd_chardev.o \
>   		$(AMDKFD_PATH)/kfd_topology.o \
> -		$(AMDKFD_PATH)/kfd_pasid.o \
>   		$(AMDKFD_PATH)/kfd_doorbell.o \
>   		$(AMDKFD_PATH)/kfd_flat_memory.o \
>   		$(AMDKFD_PATH)/kfd_process.o \
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> deleted file mode 100644
> index 8896426e0556..000000000000
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR MIT
> -/*
> - * Copyright 2014-2022 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#include <linux/types.h>
> -#include "kfd_priv.h"
> -#include "amdgpu_ids.h"
> -
> -static unsigned int pasid_bits = 16;
> -static bool pasids_allocated; /* = false */
> -
> -u32 kfd_pasid_alloc(void)
> -{
> -	int r = amdgpu_pasid_alloc(pasid_bits);
> -
> -	if (r > 0) {
> -		pasids_allocated = true;
> -		return r;
> -	}
> -
> -	return 0;
> -}
> -
> -void kfd_pasid_free(u32 pasid)
> -{
> -	amdgpu_pasid_free(pasid);
> -}
