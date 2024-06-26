Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5258DC30653
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9BD10E0D6;
	Wed, 26 Jun 2024 20:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZUZgN4N";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB2410E0D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc8Jzpn7YABkRNTVyq1n6VwDxS92fitqOI0wW8FXwt/yzTdOLJITxnHniwIln5SJ6GBvcey4suJUs//u+wbz8jSCk1VqneNnTrw+yanmHHitB+n8PtIm8b6cMe25AyNzvZU/hxQKTZAnIgX98+UNjq9NBEImPBpPTm0k+89HkUpPv70V1JxD8LzieTUXqiPQo1qePT/0tTSfK3v0lpUYGXwbWeu0AEAdzgQv2jOK+3J/5IYiUevsm1aiCyfxSaBLGsq46FVUyA+TqHKRQFRkh48puMM6Ib7TePoyu8nJ7vzXoWvV2yVf/Rv3UWdAWwrblGRsTx07h8DHUORvnJIryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEv71JZFAqsmTYcnGR/HbNCDSoTwbKv/Kna1YX8vDvY=;
 b=DRnoDzGXuvn3wWXHApfBVOQ4y1JjkseYkLMgpo9xJKI6zQn+JwWy4k4l9rOU5xLN2nXbWlTauIRbkOkjpduO08yadewZUMXshORYTrXqSxRiEbxPY/xY/NJLhSS71UnhzQOR9KwtcHyyGeZ+McHdAql1cxehlbL1blGDGVUNUh6uz9pvJq/GeTZX9ojAhaQrEbGc1WuZpWOnCLTtm/MaLtPfOqUIgv493pK67XOlE+6U8mct7AbS5Sw35JLZHjsj0m3jawvFbZTtQSezd1VS6cOA0uAobn6SQuKt/Lu7sUuJXe6GJI8K4i4bwLLuhg73XXsOQfK9ZJL3xudZbCFfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEv71JZFAqsmTYcnGR/HbNCDSoTwbKv/Kna1YX8vDvY=;
 b=hZUZgN4NAI40GDwk2MNPrmvk0CsudskVYiZrcWVJEKTutmZzM/KUNtUzF0P2PxDAZwVKHmAACt2PGwos1AB+e2t0lUfmSk57xKMvtSVt1//xrH3ikuarAUlWuHW5hsCm1yi3yyCai5SbrGwOoO9tCZ18hPyAuxjsDUmkAveAo9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 20:21:32 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 20:21:32 +0000
Message-ID: <96db1dcf-5ad0-4875-afea-c76663cc6381@amd.com>
Date: Wed, 26 Jun 2024 16:21:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] drm/amdgpu: remove
 AMD_FMT_MOD_GFX12_DCC_MAX_COMPRESSED_BLOCK_* definitions
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-5-marek.olsak@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240626183135.8606-5-marek.olsak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::21) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ac4d08-1b95-4d95-13e7-08dc961d918c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3YwdENjU3RURnNHZjYrU0lSS1FZdFpaeS9LWlZRSzFSRUV5ZnpwdURWTUxC?=
 =?utf-8?B?OFpLa0hHQ0tQdFBudm0zQVF4MDE1QUV2SVArbFJXRTU3eExIeVg0WXFUUVJF?=
 =?utf-8?B?Zjd1d3U2dGNScko4SzNCT0oyUlpyVEkwMlBINDNKdHFXVXh3bWg1UHpZMW16?=
 =?utf-8?B?b2Zla29yclBSQnFkbU42T1dqSm5FTU9yekhwbkYyejJrVmNBNFBqaXZheVNF?=
 =?utf-8?B?NnlYRThIY295UnhXNUhvTXJ2QVNaYXZvV29IZXBJc3B5RHd4VklmYllrVmNa?=
 =?utf-8?B?d3dJenlKU0ZGeGNhdkUwbm1Ea0owYXRObEl5OFdZWVp3NVZxUUtFbnpYaGtz?=
 =?utf-8?B?YWY1STViMC9MVmUrWkRDSUo1anRqVWZFRURMOUI3dDZXZnNacWxIaXdwNmZ1?=
 =?utf-8?B?R2w3cFBzbjlNMGFKQ0l1NlI5K1RtWVJpWHdwbUJwNGFGYmY1RkFlKzNsTStP?=
 =?utf-8?B?WHJxQWRKcUZLMWZMN0NLTm9Xb0U2Tkp0eVdWbVFSalZNUG82bE41M1I4UE5Y?=
 =?utf-8?B?SFpjbDRQKythcDdsa1d3QXBEenY0Wi9jdzkxbjVpamdQVUkwZG9vTjRCalBO?=
 =?utf-8?B?Yjg3YmhNbXMrQ1Y4SGd5ZjVXL043S3c4NjVGQlVZemxzbGtDWVU0blRzdXp6?=
 =?utf-8?B?S3psUGxIY3ZGVGs2aWs4ci8xMzZLQVA0UlVLeFNCbC93cVVyRFI1V29uNW1Q?=
 =?utf-8?B?TThvYm9OZnZHbU1ISlhWY1FYazY2YWJURWpmU3hiR1FXdWxBY2FyZ2p3elNj?=
 =?utf-8?B?bnVNUWZJTjh6elhGYTdkRklUSTRNbk1vWUtmZ1NaOVcreFRydGZYM29VUlh2?=
 =?utf-8?B?cFJwTXNpdjIrVGdPSlpXK1RiMElsTkw3ekJ3NUtYZmx1Qk4xVE5JR3NIWnY0?=
 =?utf-8?B?UEUxejlWb3JtRTE2SG01YTFGMVNDWlpCMlVwakJsd0s2azhKc2lOM2E3Qitn?=
 =?utf-8?B?VlM0dzFPc2FVbVJhZEJlREN4YkpMVkJSTll0bUt3dnBteExTaEo0NnNaTW5p?=
 =?utf-8?B?bHFMUVpQSGZFbGFTQWZEdWdwcStoREhzUk1YZUpPSVNwcmpzMHo0RGQzQi82?=
 =?utf-8?B?LzdVK20wQy9GeVp2SW5wTHNwaVppNHh1ckhGbEg4NXMrL3hKbEptanFrTENz?=
 =?utf-8?B?WkxRcm83eVVPYjhxbjJycFd6aHk4UkpUQU1ldU1HTFV0M0s3ckZ1ZGZKb2dL?=
 =?utf-8?B?aWpLNE91ZHE0MUk2YmliSklsRXVSSHNvQXI3b09KdjBMM3E3aEFjTmFiK1dW?=
 =?utf-8?B?eTZaL1FQb1NoWGtIT04xUWNwM1ZVYnQyaWsra0JPdVZMWmU5bG9vUzI3aG5B?=
 =?utf-8?B?aUtLbGZWdHQzQjNQVEtJKzFudnBsUmh1R0NLNXhiTXYxMDhaVEo0S1QyZjJp?=
 =?utf-8?B?T3h3S0hZRGRBN2Fkdks0OVlGaDlHcldWbTNIYjE1K0FnbWpSMDkvenJXK1ZZ?=
 =?utf-8?B?ZHFYWTVyN3M1TUZxRndnUStqU3FSUHJvSituRXpXTWZFR3RKN09uWjAvdWQ3?=
 =?utf-8?B?KzdEMkFleFdUZkVOYUpCYU5oUUNGVlFhZTJaYlZTOHBwS0preVBsc3Z3VGVF?=
 =?utf-8?B?YnRiS1ZYdHFQdU5yV01FYjVwTktDUG5ZQkxrUXhqTE0rNzVldmVMNlhETDh6?=
 =?utf-8?B?dHhmLy9HMVZ0YmVBbEs5c2h6VzROYmNKbDMwNEdxSmdDY0haaHErN0xraU1F?=
 =?utf-8?B?UGpLenZmckIvL1NOL3R1SUloMGlzSFl2QkRXUTB6cVBEK01FUWcwLzNGTm8y?=
 =?utf-8?B?YUY1KzB6U1ZoODBLN1FnSEc1KzNGb0dFUWM4eUQ5VkloNzZvYzM4ZjhmY2sy?=
 =?utf-8?B?bzlmL1RkUFJqUmY3WEp5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(376012)(366014)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy9YRzV0ZjZCRlhlMmM4WTFTYUpZeWlqcGYxeTdzRGhzTGd6Nm1JbXc3WjNa?=
 =?utf-8?B?WjN0UXdDelcxRGxjeVhoZkVERGE1ZnR6QjFHR0prd1M4SmNOa0JEeG5rdWtn?=
 =?utf-8?B?dkVvbDZSb0E2Zm85T0hEZFEzdUZ1TGptTExmZEZWa2pBWGFBTTJkWFNQKzlS?=
 =?utf-8?B?VW1VdE1jeGJuRFE4Unh5Z2QyMHJ2dFkwV2tIbjk1bzdpQUYzOGRBNjZIKzRS?=
 =?utf-8?B?eFdiZDAwZERwS2VMdTl3N3IyS3JIVnZCeWJDU3FoUWpJajFIVWdwdmNaV0xU?=
 =?utf-8?B?S3pJWVdjejBQRjJwK2wzRVZPb2hkRWx3WGtMbTY4bDB4alk2QnYzeU1lTnQz?=
 =?utf-8?B?MXcrQmg4Z0ZLVnZaK1NueVRGUHE0L0xTUWhrVDVEWWxLUXNtN1pSUGIyQWgw?=
 =?utf-8?B?dDBFekhKWnJuRVRrWFd1OFllYitVSGF2V3l4VUEyNTVVc1R5dVcwOVNoMmNJ?=
 =?utf-8?B?NGR2enZsc0tGSC9HeEtOZTM1YXJhaWZ1VGY0MjFlUTFpWmt0d2ZQSDBoSlBG?=
 =?utf-8?B?T2hrajljTDZCcEVRcWxpcW4wdEN6Qk9JWEVYdjc4TU9jZkN0VEtDcUFJdm95?=
 =?utf-8?B?cWRmLzJzb2hmampoWHdvTnBsUDl2YWxhc2owcGJXK05yTXhYZWNuT05IK0g5?=
 =?utf-8?B?NWc2M2lGbkIzWTE1dUdDWnArYkluM1VQWFRFT1p6MWVDNnNYUng3NUxGdlB2?=
 =?utf-8?B?NnlZYmZHMkhDWUtMSWYzZUFXQlFEWDkrRmhnZEF3ZVY5ZzU1SkZacmZSVUFa?=
 =?utf-8?B?dERhL2FxYkFxa1NRREo4K1hCN09lSWRtWDNNZUdzVXNySXc5Q1R1b0wxTEhr?=
 =?utf-8?B?K0xRelBQNE9lSXE1aFI5OUdtMWVVTWNwOHd1eWJrQnQydjBtYUh3T1B4QURn?=
 =?utf-8?B?ci85L0FyOTlSa2lPdUJjMDF5K1pEVTFTeGs1aFVUTVVFL0hvRG13MEVkVXpa?=
 =?utf-8?B?MlprdnRJbFFJNDZ0VTh4Ly9uUkIvQ2U5LzQ3QzU5cUp3V3RSSWNzVTg0NERB?=
 =?utf-8?B?aHJpNjhBWFlqTTZmdzdwRXNpOUtVdjErVmlUeVZ3MDZZcUFvYWFoZTAwNXhR?=
 =?utf-8?B?OE1TU2UrU0VtQ0NDUXhtTVcwTmZYYUIyVGFYUXZlektqWTlJU0lodC9rempR?=
 =?utf-8?B?WjNQSVFaVmo5UHBEU1h3amFHTjlyZWxZUmRvb1RkVGwvV05GWFA0ak9hZC9W?=
 =?utf-8?B?MStRNGhwY21Gbysza0JYNUVCTlJDK0wrNVZQVms4b3RKM1JzSEEzYXBaUmJO?=
 =?utf-8?B?bGJrRjB3U2V1QmhIODNObGcvTnl4UVBBa0c5N1J4blVSOXpUaEVGMGxwUjhP?=
 =?utf-8?B?N3cxaWtvRmZHVGx2RnFxV1hhVVl0VEQ5NXlwcmtMU2tuYVBpMEN1Uzd4OUxW?=
 =?utf-8?B?MlNUbFNiYWl2WGxQVXpWb1Z4NjVmZ0xvMy9HQjVMRjlTOVpVZmkzZ24zemJw?=
 =?utf-8?B?aFZRaldza2w1WmRJUTVqRTZ3cjV3aFEzRW11akZtUk1lSS9EaTh2VEgvcGM4?=
 =?utf-8?B?NzAyNUQ3SnZIM0lmMkdmU3RxVHdUVGw1WmkwQVlzTUZwUWJucWFaVTRuOG1U?=
 =?utf-8?B?bXJscG1MdzdpTFB1a1p0bTVEVWFDRUZ4UHE0UHJLNUlWQnpONTJEVTZ2WUFq?=
 =?utf-8?B?WVcrYWpsNHRmOTQ4ajdJYlVPbGJEMThyUTRpbFRJbXVwTE9NNXpGQWdpMTNB?=
 =?utf-8?B?Mkh4bG8wb1N6UFo2YjdjQVd1SmFMalVZWldhQnhmcXorOFlTTzBKdG9PUVVS?=
 =?utf-8?B?dmFIelF5akg3NkFCSlVreXIrZlQyeDZYSWEraExiVmVDOFgwMGFKKzAzQ0Ev?=
 =?utf-8?B?RWZNZE9DTUoxeVA5K1JwekJvVThQUm5OTmtVTUdXelhYV3h5eGtjUUlBcWRo?=
 =?utf-8?B?eG1YbnJHbU05NEN0MVk5eFkwdHM4RVdrZ3NhMU0wTE80bllNUXQ3UEgvYm1q?=
 =?utf-8?B?Wk5XcUpJZlhjS1YzWlZtaE1na2RQM2RCaHF3RWNnQUdZSERFM0NrRTkxc0h5?=
 =?utf-8?B?V0N4M2ZpRnNub21VMUhuMjdBY0U2MHcxMFV4RVlrNGpoenk2MVdJTUprUXRS?=
 =?utf-8?B?bzRhSkpkREIzZDZVd1pRTk5sY09BeFJOdVByczN5UHJLQXNncElKcGQvY0ZS?=
 =?utf-8?Q?iGvFqUKE7xPREp+CswVo2WIam?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ac4d08-1b95-4d95-13e7-08dc961d918c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:21:32.0939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iP+wyNj7mbjyYdH9kmNpSNreTMzgNXRhVNjQIZVhhzsSqJyEzNDm4tySCXwQlUpWu66PcmLtPARatQw7skkGmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 6/26/24 2:31 PM, Marek Olšák wrote:
> They were added accidentally.
> 
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
> ---
>   include/uapi/drm/drm_fourcc.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index d0063ac6e09f..4168445fbb8b 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1540,9 +1540,6 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>   #define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_SHIFT 18
>   #define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_MASK 0x3
>   
> -#define AMD_FMT_MOD_GFX12_DCC_MAX_COMPRESSED_BLOCK_SHIFT     3
> -#define AMD_FMT_MOD_GFX12_DCC_MAX_COMPRESSED_BLOCK_MASK      0x3 /* 0:64B, 1:128B, 2:256B */
> -
>   /*
>    * DCC supports embedding some clear colors directly in the DCC surface.
>    * However, on older GPUs the rendering HW ignores the embedded clear color

-- 
--

Thanks & Regards,
Aurabindo Pillai
