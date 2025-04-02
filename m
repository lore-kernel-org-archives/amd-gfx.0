Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485E7C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 14:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6B710E7D2;
	Wed,  2 Apr 2025 14:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OUDx1vtC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528F510E7D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 14:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMPwgrzLLawhsvVU9iiyabI7As/fBvtKdI8Ht0kAkUqloBA6S+TUqwADz2vmTg20FyJojMN7VetKR5Bo+KjODOv2R6ECNB+kJVuctY9RCVHs3VwHLVv7fXhuwhcfws347IRr8Nw9hLnc27qm/OzVLS8RfSQRjQfpFl/yHM/Gq6tF8wzehOAwQqiiktjdYjVFQYEK5L6mlvbANsFj7MV9EvYJ4iwK3JCLDiH4I/6Vo/BL2dZFpbsazvpOi7mn3q9PJ8mInyLWbfDT8sdYQT6UREprtgGVHaLZAyC1qW/MjP7lUJpXG8zNjIf9IYw9mCOZEooRxSZf2Kri++Re3wEf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWIsqEumwpbnkd/6iVQJDxjB8SXJYu2xAwDFhIXOlPE=;
 b=Jy9CQ6Pk9/CCVsyDPT/ezHmHP/6aJQLVg9Vb/T9OPVU7Qa1q76JHqzd//5qJVJnH0ZKx2aLlemjwcssgGb6+Sv3U+wjOL1FuXg391lo7F1fhEXVw4kYPU0pQ8ZJ4EfpmKb8J07vOSO7yBbuQ9gdcO9I1vTthCyV+cZ7vTMRlMzoqraU+1HmOPuYxKINaXl6xFmNSGO1qWw7dJT3kk6snlru67ga/n0yJsqVAoacIeysewhE+BQNJfnQwl0Lx31lv36QT/Wu+pb93s0yi4Uxfl1KwmsEa2T9lSA+YRI68uYJia6rEv3yYG5l6FbKHKgpK0zvwXX1PLoR9dhXpbCHBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWIsqEumwpbnkd/6iVQJDxjB8SXJYu2xAwDFhIXOlPE=;
 b=OUDx1vtC2S1aEMg0Fstyj74FJqYbMYpR+ZzJy7GF9RuHMGiDQYhS1xcW3sMaaNgtcZDfGClclWVmpXt1wsd+fXWR5kEBos2nmYQ7ftmGV1HWlipK0egJDLBqva/JjCAsAV6m28fz8LzuH1dh82gsK6Rgw88v4iauF2fy//JgZ2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 14:07:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 14:07:45 +0000
Message-ID: <68dfbe1c-c85b-4262-895a-509b4f3c3376@amd.com>
Date: Wed, 2 Apr 2025 16:07:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b89350-e461-4ed1-d5cb-08dd71efbdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkRCYWpTejZkUnRUOTV6cUtYZ0ZZMXVEVlYxSjBrK3RQRGlkNGFVcWZTRGFF?=
 =?utf-8?B?cUNxZVE0Ry8zM0luTlRIUnc3cjY4S3dySVExemRTRklyL29mQzltV1NkSWdF?=
 =?utf-8?B?QWVuWS90NHFFNGVBVzB2dlVXTzNTc3FzaW9VWEg3ZEVUWUJBaWlCV2k4cnJ4?=
 =?utf-8?B?OS8xZ0ZMdVRSam5jbE05RExvckhRdVk0VmhjSEx6K0Y2eGN1Uk9xaEpPN2g5?=
 =?utf-8?B?MGdYZzY5TnhQZ3JNdmFieWkvQ3I5Z3dRaDEyeUZlUitpaHZjWm8vbk9MRith?=
 =?utf-8?B?T2dSNVFYdGVuRG9yNk5HRHErdWhkWVRyUk42NENlbUpzMG5YU210dmxjK3o2?=
 =?utf-8?B?dWlKUE1vTVdoT0hSbStHT3VHb1BQaFptbG1lSXZ1UHZxRUhRWmpqMDFXajA0?=
 =?utf-8?B?RndmaGgvcC9KVkw2aFNvMUNDRis5QnNkR3loZWdMN0EzYStnbSsvaUU0TG5T?=
 =?utf-8?B?NGRXM2sxVHRRa2I1YUY0L3k2VnJlazk4ZDQ3Ymx5ZXpDd0I3WEJmK0FZTEwx?=
 =?utf-8?B?OGQ1ZHJsTlMwUy83TnZYaEEzTHkzV1ZzbGdqZlRiSnl5RXlyTHhXMDBsM1RE?=
 =?utf-8?B?MEhOVSt5L1JHVWhpN1I2T0JRWE5xb2xicVB3ZnI2aEV1VHA5cDZlSUdZWWNO?=
 =?utf-8?B?OXVuUHI2SS9aOEdKalA0Z3htT1dpNXZINjZOdkhqUEI2aENrT0xOME1md054?=
 =?utf-8?B?VmZ0OU5URHpnanFXYWhrS3lpa1dLcWRmWlJhMDJmcEI4TmNyUEJqUVI2TG85?=
 =?utf-8?B?SkZqZXBTVzk1aCsrTFVqUjFVVHA2eHFBWVU1ZnNUOU8vd1dBU2FIZlhiZ1R0?=
 =?utf-8?B?VVRsVzFRcHhRNWlPWmsxUXFUM2R0UmNOWGhsdmJUbHFqTU85YmdXalgvYjNu?=
 =?utf-8?B?Q2VLQ2lMcW5qam51R3ZQSUVZT2ZwOHQ5TDNxb0VZR0R2aUdFc1RNNkZ4LzJX?=
 =?utf-8?B?UWU1ci9Ua3Flek42YkNLZU93NU1CeVBwSkVYRVFaak0xMEIvWjRNTEM5ZVVO?=
 =?utf-8?B?RG5yQXZobW9LR2pvL3BZcVF0WWQ1a1EzL3pVdDlxTUxiZVUzYVZYVnJWVlRy?=
 =?utf-8?B?TDNCUHRlWjhrY1NOclJ3UlBtaHROMEcvNjZSWGZybTN3T3dEUDdrVlN0U1lV?=
 =?utf-8?B?TmtwN0k0VWZXMTdGUWQ2TklnWCtDd0dRQ1Y0V0pxL0o1SEpleGo4ZWZyYWpX?=
 =?utf-8?B?MmRuSlZiM2VCeTBuRFBrdWE0TUVOY0daMUZmQzNuNE5KRHFaSURBWGxmMnBX?=
 =?utf-8?B?SXVidW5rRGJXdVRNOGloSXZiL3VOWGQ3T1l5VGt0TExvSzhTS0JUZ1IvTWds?=
 =?utf-8?B?RnI4N0FIQnlDc0l1VjBsTmQwOXFZSGVsT0tZcmNvR3lVcWJPQlR0VkxOczNl?=
 =?utf-8?B?bWNYb1Z3ZlpZZFlwNnNyUElGSkU5TDVmcVZDL2pOMWdjS2dMOVdaS1liblRs?=
 =?utf-8?B?R0ZBd3p3aG5ESzFRMHdtRWU4c0lFa3lPVThRTnMzN01Hb05sTXBVeVljSlJ3?=
 =?utf-8?B?eTk0cDdzWWcwcm9pQUdiZWlDQ2YveUlma04wYkc5VkVEbjVLYWJuUnpiVHc3?=
 =?utf-8?B?c3pBNk96cDZqWkx5THVtVXN5YnNoalNDZk1BNng2QTQwNUM3V1hxTG8wanJv?=
 =?utf-8?B?QUlpd2pPQjdtaC91eC9FMVVDTCt1YVo3UVRNTTYwcEdXZnNLVjZJeWl1bkRE?=
 =?utf-8?B?Tmp2WWFLQjhLVXAvN1lETTJGNDhIcFNTcW52V3h4ZSt4a0dKeWQvR1dWZUdC?=
 =?utf-8?B?NDduTDVvM0VDMWN4Njd2TmZGL1NqK2RpQk91QXlGNzRkSXBQclVERzRuRDB3?=
 =?utf-8?B?YmlnSUVPSXVGNFRHdnA4eXJ6WDlraUw5bFFwLy9nTVlyUnVDWHJDUlZELzF4?=
 =?utf-8?Q?eKJNYbkBJmlzG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3o1VnYwM2p6elIwbUJUREtBM0hud2tBeWJ6ZjhoMzUxRWdCemdQbm9MWkFI?=
 =?utf-8?B?S0U5UTc1S1VzZE1lM0hseXFtTEkzbDlvZmU3TXJVV1BETzZmUks3K2FEN2dC?=
 =?utf-8?B?MmtGY3RzS1dBeUxvS2RBTHlFL1o2NTNramU2MkNKMTdDbzBMblRYeXVDRmVq?=
 =?utf-8?B?eWwyVmNGMXNXTVNxSFpOZ25nRDFab3UzeGNiNllpeTcvdEJEN0xLbWJaem9W?=
 =?utf-8?B?R1Q1S1VvNnJ4VXBWdmFYTU5tL29RenJhN21jZUJEMCtmT2lld1FGZUVlYUdR?=
 =?utf-8?B?VHBzc3llYS8vU0E5bzRxT3RsODVTTW1yK1RDdlFKbEN1aXdObklCUG9NTVJj?=
 =?utf-8?B?Q0NvUEQ3cFdKOXVSSXliamdZSXZHeWtqNzQyOHV4ajNBUSs0WEFEdlRlN1hy?=
 =?utf-8?B?eWZTa2hJOGR1ZVVXaFRmM2dlZmZMbU5aK2dOK21hU0ZybkZWVTJPcG8xajlL?=
 =?utf-8?B?NjlkOGgzOTUzbTg3VDFtRjdZWUxGK3ZZSzh2cjBYdk10OFQwUGtYUlk3cUs2?=
 =?utf-8?B?NUNFeGhBNDM0YTgyaGFaWE51dEpsUGc1Yy9ZdWM0cGhNcWVpTlpwdENoa3VG?=
 =?utf-8?B?RDNRSUF2ZFRXUm1tMUp3VHlPVTd2SkFhSUtIVTFOTmg5TUpPa1BQTXBWcVpC?=
 =?utf-8?B?ekFnUm1melo2c3JOcUZiWkN1aXVMQWNKaXJGWnNVekNXUWRRSmovZmZIdGx0?=
 =?utf-8?B?RFVqWStDU0tmN3hZVGpFeklOUTU3d2VkSFVaajF0Qk16WG0rK2tNZkU5SEZy?=
 =?utf-8?B?ZVg1OEdLWjg0MzRBeXEzQlVBYmxZczNCMm9DMjZSYXoxOForS05ZenU5MDhS?=
 =?utf-8?B?SHdXNlp0ZTVBVVhsNno0NlprdExmSWJ5UWpsK0daLzk2WlJBM0h1VVJiWFMr?=
 =?utf-8?B?WEhqUFBCZEhia3lvUTRnY1NIbGwzd3BYTlZnSDY3d3ovUVJLMUV5alRrSjY2?=
 =?utf-8?B?Qm5SMnZGRFVRdGcwNUljeXJYV1psbHZhc2hMY2FNZC8zcFRJWTZUdktMcXU1?=
 =?utf-8?B?a3B4UStwbllJdkVxY2tSZ2F5dmlsODRTeHZjWXp0dnhmUDB4OXUvQ0tyNDV2?=
 =?utf-8?B?RTh2QmZtVDQ3SDI3YnZYMlQ4aFFYTjR4MHNWcTFRVmVBYnN6T3NnOHJodlNG?=
 =?utf-8?B?U0drWmtJWkdEWGQ3Q0lUUXNtTzFteG1STU1Vbml6MjB2UDB2Y0lVbVAzQ3Zo?=
 =?utf-8?B?ZTlYc0xwWXRUT28xT3NPZ2FGVUs0S3gyb3VMbWhLRWdZZFl2TGUyV3dSdkdn?=
 =?utf-8?B?Vm4ybWZpVTlvOFk1Qzd5MUJ0NlJ1RHBQVmkwY0pqRVoxTEpFYjdQa1YyLzhs?=
 =?utf-8?B?ZzV4bWdqMkU0ekpuYmtHRlhHT3l6WjNLejZtbzRwaG9wMlRna1BNMVVxdEda?=
 =?utf-8?B?Q0FFcEp6Z25wbVB1bUl2SFQwNHY1UlhUUGhrZklOeGV6VnBQY2JqaWNsMkJi?=
 =?utf-8?B?VU91OGlUVUcrYUJORTFodnptSThRb0Y1R25kSjJ5YVpoTVhYZjJvNXhPQTM5?=
 =?utf-8?B?UktOcE9BZzlMZWxRVVB3V0ZMelV2MUxMNWE2R05ISklwRGNpUVBiUmxGeU5m?=
 =?utf-8?B?MWJPZU5oVmtoZUcxa1lJcHgwSjBzVThHa0JsbkNFblhGMTZka1V3QmtTenRh?=
 =?utf-8?B?SzhVbCtPU01xd1dYMmJLSWZ1K1FpRnhxdjFaamphdzJ6bE1Na1djNHZmRlpZ?=
 =?utf-8?B?TGl0aWhiNC95UUd4dEZXRDBaZFdURE1iU0JvanEyOXBpdnZDUDhZTlZ2NWsr?=
 =?utf-8?B?RkRQWlAvUkZBdVlFdi9ZQzVCbW9GMG9OTjhUYWhIMzc2Sk5rdCtvalNtZi8y?=
 =?utf-8?B?Mk52ei9wTzdEMU5ER1FPb0gxdDZhbXFBZ1dvRjZiSzArU1N5Zmczam5vcVBt?=
 =?utf-8?B?VDBKajgyZGU5WjFSM1JSVU5lbTlMTU9qTEtORW03RWlTNnR1OFdvWjlKTndv?=
 =?utf-8?B?QVlNNWZmejRWOHA2eVhNNzFEMHkrblh5Vnk2M3RGdkJVSG9ueXJ0NFZRVVVP?=
 =?utf-8?B?VVNWdWFrZCtTUzY1d3doaERBSndLeWRYejhlalBhQ1lRZEYzSFRsdmVIeGhW?=
 =?utf-8?B?RDZTaUgxRzB4UEVPSUhScmVXbFdsYmdTc2N2Z21NSVEzOWxwd1RURFE1NTE3?=
 =?utf-8?Q?JQQrDJgos1dHRwtgVjb611Wdh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b89350-e461-4ed1-d5cb-08dd71efbdb7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 14:07:45.4776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PKD5m5iirVgfLSjQKHIiGoMAbOu48sEW1Y2p2E/Yochy61xwdryEtIwE5WX0FJB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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

Am 02.04.25 um 11:14 schrieb Jesse.zhang@amd.com:
> Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
> we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
> This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.
>
> 1. **Remove Dynamic Callbacks**:
>    - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
>    - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.
>
> 2. **Prepare for Deprecation of Dynamic Mechanism**:
>    - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.
>
> v2: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 13 ++++-----
>  3 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 615c3d5c5a8d..23ea221e26de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
>  	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +	int (*stop_queue)(struct amdgpu_ring *ring);
> +	int (*start_queue)(struct amdgpu_ring *ring);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>  	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 0a9893fee828..b51fe644940f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -558,16 +558,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  {
> -	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
>  	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> @@ -589,18 +583,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  		page_sched_stopped = true;
>  	}
>  
> -	/* Invoke all registered pre_reset callbacks */
> -	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -		if (funcs->pre_reset) {
> -			ret = funcs->pre_reset(adev, instance_id);
> -			if (ret) {
> -				dev_err(adev->dev,
> -				"beforeReset callback failed for instance %u: %d\n",
> -					instance_id, ret);
> -				goto exit;
> -			}
> -		}
> -	}
> +	if (gfx_ring->funcs->stop_queue)
> +		gfx_ring->funcs->stop_queue(gfx_ring);
>  
>  	/* Perform the SDMA reset for the specified instance */
>  	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> @@ -609,18 +593,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  		goto exit;
>  	}
>  
> -	/* Invoke all registered post_reset callbacks */
> -	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -		if (funcs->post_reset) {
> -			ret = funcs->post_reset(adev, instance_id);
> -			if (ret) {
> -				dev_err(adev->dev,
> -				"afterReset callback failed for instance %u: %d\n",
> -					instance_id, ret);
> -				goto exit;
> -			}
> -		}
> -	}
> +	if (gfx_ring->funcs->start_queue)
> +		gfx_ring->funcs->start_queue(gfx_ring);
>  
>  exit:
>  	/* Restart the scheduler's work queue for the GFX and page rings
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..a8330504692d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1678,11 +1678,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	return r;
>  }
>  
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  {
>  	u32 inst_mask;
>  	uint64_t rptr;
> -	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
> +	struct amdgpu_device *adev = ring->adev;
> +	u32 instance_id = GET_INST(SDMA0, ring->me);
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
> @@ -1715,11 +1716,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
>  	return 0;
>  }
>  
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
>  	int i;
>  	u32 inst_mask;
> -	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
> +	struct amdgpu_device *adev = ring->adev;

Just a nit pick for further code. The general coding style is to declare variables like "i" or "r" last. E.g. longest lines first and short lasts.

It seems to be the exact opposite of what some people are used to.

I honestly don't care much myself, but some upstream maintainers insist on that.

Apart from that I only skimmed over the patches and Alex needs to take a closer look when he's back from vacation next week.

Thanks,
Christian.

>  
>  	inst_mask = 1 << ring->me;
>  	udelay(50);
> @@ -1740,8 +1741,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
>  }
>  
>  static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
> -	.pre_reset = sdma_v4_4_2_stop_queue,
> -	.post_reset = sdma_v4_4_2_restore_queue,
>  };
>  
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
> @@ -2143,6 +2142,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> +	.stop_queue = sdma_v4_4_2_stop_queue,
> +	.start_queue = sdma_v4_4_2_restore_queue,
>  	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  

