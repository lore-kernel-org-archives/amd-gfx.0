Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBAEE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 19:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B7E10E48F;
	Thu,  9 Jan 2025 19:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gy22a2vk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8153810E48F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 19:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5dznC58tJsMWL66ZmLe0SRKWg7xW9OXADrrvuUNLwIdISwGy1KslJvrO61S5YrZ8foJJ9Pw03ABXv5WUoRHCbQJO+uHDkibIUy8b1XLX3zvqOnqCPHpoQrlwKEkCzxkcaYCtjj3vPU6o0nDsWtTH3A7a0Zh4qPWviO1mv2oyQS6i2c3ZtFSiP8zA2zYQCqH+1322x1BxlcqjK1/L5P1znOlHn7B9x0NyxYWUhVxzyo4fayI7zBJRT0JP3C/NcpjDOrTzAIvtOvZBC/2CQxtK0Ja8JYHhWt1rtsuABsn0K/Jimu45i2Ei6HR/O7d7TNMZ3MNftxw/YbWeTfF+EhXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2eP6OiiLerN4x1JGEYV5z1dCxs+gRSUOn7urRwyKkk=;
 b=mYfNYf4WZRWGHR24/LhjEk+npuHiYJxdZK6Mz6OpvtX+SKZaTApSEZBScpyPbaNKIpuCGIbYrQkf8sc7hv1GLKWiAALmwPHPt0pgb0l6EfEDoSkjuE+oAUTuobpu7e0aAMBS/ENELvlahvKxMiRGR4mvVRBQ5ceBhg94ElzwkDLNYjBl00YVswQu/+uCA534fHjHOXPt/NKlKmSCgWgjj5wTELSVtTCxcFk5ZbwMKy+TL2yJBQ0ZwTfwbDRG/rk4ABbfw5ThwzylixdaI68bDuwLO8ixVckXIyVV5xCb6E/1KAjghPxTpgk58httdJy2ESlfErZP4O4FXwSl66LJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2eP6OiiLerN4x1JGEYV5z1dCxs+gRSUOn7urRwyKkk=;
 b=Gy22a2vkB1jeNWnibWuHqW3RgCLv3ge5uTu6gfyHfxMkvLlxPbT1Q5B9UtzgPa25po7OLLiSMYMug0MSOURUUDIdmPlOA16t8cIKE1d2oUceJHUTJyUi9hoGqw19NNIEO0w2G9q4NFhjDjPC8H28KuUhIxuihkab0gdtXcdtx8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 19:57:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 19:57:58 +0000
Message-ID: <63ce73ba-d6cf-41bb-a078-1c9239c2e265@amd.com>
Date: Thu, 9 Jan 2025 14:57:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark debug KFD module params as unsafe
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250108151829.1495321-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250108151829.1495321-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0250.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b98f47b-ec7b-459a-8c88-08dd30e7ea84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUVUVVROTUhudkdJYnBCZ3BhMjZyOTdrK0l2aksrNDMvRWhSa05ML3hDS2RW?=
 =?utf-8?B?bUF0dWgzcUZ6Y29oc3E1SUlNOWdRdzBvcmRLNEN5NnRkY1hkT09WL1ZWNnQ2?=
 =?utf-8?B?L1VaQXllcXhWK1VXd2dtWEpYdDhqSjdwUFNKNU9mbDZ0YVFadENGaTgxem1Z?=
 =?utf-8?B?emxJZkhMcnhGRFJ2ak5QeVh6emE4ZzZ0OHNOeCtNQ0VWek52OGhYVlZBdmY2?=
 =?utf-8?B?RWk3Ynpzd2ZUSmd3VkpSQnAxWjc1TVpIc0Z5Rmh1TTAyek1zUUdXTEhLVkVa?=
 =?utf-8?B?dCtyc1FUVUdWcmtNTE9YVGk4RHA1WXN1ZWV4alk4WkhNa3FZd0NQUExPMThN?=
 =?utf-8?B?QTd2TFVGOE5SRUoxeWJYS1pRS29UbDIzWmlXTHQzN2w5T2ZTbEFIN25OVFJu?=
 =?utf-8?B?TjluSXRHb1gwTXNISUdieTRYeTBsM1F1aGorNTZNcVFhZTlpV0lBMS9pcTNN?=
 =?utf-8?B?MFRzdW4zam8zcTNpYWFsanhJbmVkRE5HMlN0VlNsdU5ZLzF5WWJGMDIzL2pX?=
 =?utf-8?B?Q1JwaDB5WXlocGxEdVRLMmFOS2lHaUk1Wm5zSHY5OENSdm9QTW1UT0hHczll?=
 =?utf-8?B?S0dacGk0bTZFL0NoYlErSVNoalcyWGhyR2NvWkdCclIzNmlmaERidHpnMU1i?=
 =?utf-8?B?Q0xGcTlJYkRXcjhSQjg4TW9ib3N3bGZOVEhTK093UFAzQUtBV0huWWtxb20v?=
 =?utf-8?B?OXMwZGtQSGVyeDA4cUhWak81WFJtUGxDZUJ5eEpYdVFxSjRlQVQ2MGxLVWp6?=
 =?utf-8?B?Y0IxZDU4WXI5NzdtTk5VNkxnTDhjY1p1TkFMV3JuU2YzTnovUjBSU21TWjEr?=
 =?utf-8?B?R3pock5ST0hXZHJ2MDA0Y2h2dThrM0c2YkRZL2Fnczladkl6dVpVUlNWSnpx?=
 =?utf-8?B?SlFVaDNrb0t4ZHVTRzBDVnJkV3VHY2ViSXgxYVlUeTlUS0Vwall0VGhGbTB0?=
 =?utf-8?B?eHVXYWsvVEpkRTlwOVg5a2UxeDVTeDdPenFYMi92WXJmV3RJU1pCVzZxV0pm?=
 =?utf-8?B?MmovNWd2aWVuUU1MSDlQNzdGcTBERTkwZXhvR0xFcThwUldrTHpNRVp6WVMz?=
 =?utf-8?B?QXVhc1pwejVseXFlUzQwRkNDVlJRL1laMm5vTFlwOCtGU05Dc2R1WTBvdVRQ?=
 =?utf-8?B?TldVMU1lNHY2WVhCYTI5bDNjc3ZvOXp2N0ZNelYvcG5qaUIvaTBzTURqY3Bk?=
 =?utf-8?B?UHdLN3MzSFRWdnY1TU42bVlLVWRGdjlseHU2YXdMRkxaQUZHUDBzV29RdHk4?=
 =?utf-8?B?MWtaWmRkZU0vNmUvRkgxRVdMb3h6Sm5VTlBYWjk5d2RTdElMMHJaUjIvR1dv?=
 =?utf-8?B?NlAybFYxaEs1Ri9GdG1yZk9mbkdOdlpQNloyUm5VbkN6ZWRzRWRxcmpjeFBO?=
 =?utf-8?B?N3RuWjJTTHBUdmlhQm41K0tKby8xaENMSWllOE55aG1qeERXQ1dSK1RTcE5v?=
 =?utf-8?B?Ykw4OUlLTlZHYjRONUVwWmpMOWhaVURRYURacEVPQ3hDanJiVXk0VkJFbjBh?=
 =?utf-8?B?L2FTLzIvdXZxMGk4RlhIRGdpYXAvTkVPSWQxUERuMUdncnFtRWlGUEpsQkUz?=
 =?utf-8?B?L0ZqamN3cm55Rzh1TURmVnhxb1BheE9PQzZUWVVHMFdzcC9MbWNVS3d1Y2dH?=
 =?utf-8?B?c0xGMDZMVjFhVEhtMW5EbS9yelNxU3dJOEdqSTdjbFVIM1dONDFUZW9yMXZw?=
 =?utf-8?B?NVhldCs2Z0cxZU5tUFk2ck53MU1LMm5nZVh2L2lOQS9RRjR2ekkzeWlvMzNt?=
 =?utf-8?B?dUxqSGpqSU92TkkwTUZ5ZVVQSllPRlNqNkhPWUpRQlJIN3FsV29PK2NBanZu?=
 =?utf-8?B?bU9ZNytyeHo5aGg4T2g3OE1BZ0lHdy9IZVpiZ2J4OVA2NnpMVWczU3BYQllM?=
 =?utf-8?Q?xyfEjHVEPIBQO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFU1WHJlTzNhMTB4c0ZBUzFZTDB3U0NRWDlaL1V6ZlFpSXJjMmVtdlp2L0JG?=
 =?utf-8?B?bzNFRXZiTmlrbE1ZQVAzYXd2SFZJTXlZNjgyRnVKWDVDbGNYRlVCOFpmelhZ?=
 =?utf-8?B?RG9oMCtqVWYrM1dINldnRlFCdmRXWkorbVBJT2p2MHVSc1NuVWtQN0RGZ1lJ?=
 =?utf-8?B?KzcwNHZxdk9xa1hBa0ZIclBnc0MwbFZEc3I1SHRPeWVocHhVWVRNVGNObDFD?=
 =?utf-8?B?cWNSWXR5U1JKdjB6RXg3WnF4RFNWSGIzRi8zOEtuMXZwUEdFVTJCbVowMzVT?=
 =?utf-8?B?MzBTK0pSeVI3TzBieFQxeHdHKzY3TzM1Z0lYZk5Mc3dRakhhTnkzNTVKVHBK?=
 =?utf-8?B?NWNNbzNHVVN3VmZtbmlZRWY4VUtRa1lSTWF6OWFwcFg2Y2pONkRGTzBkYzRO?=
 =?utf-8?B?bTNBdE5EVDN6OUlCT2hOSm1CaVE4S0x3bThjYkpuc21PWk9WMnJLV1VaNmk5?=
 =?utf-8?B?WkJnNVVFNUJyeWtDekVQRDhQS2JmTUlxZENUNEJOM3g0ZGNtQVRJcjhBVGh2?=
 =?utf-8?B?VGFKamxWcmRTRURkTTM4TmxXTGQydEk5NExqc0FsdWdlT3E4VEp0V0dlVGts?=
 =?utf-8?B?ZjVzdG5LeTdzUHJQVnFJbkJhc1d6MDlGVDVHSTV2L1Q0c29EeUx1ZlNZQWpF?=
 =?utf-8?B?WE0rV0V0ZTNlY1pnSkNsR0xrY2VxM0txZFJmdHViTU9KQ0xJbjg0R01oL3NF?=
 =?utf-8?B?VFJDVU9JVENLYjdJMVlyQmMwV2R0b2x4L1FLVEF2eUFTZVQ1cDJ1THRUcHRK?=
 =?utf-8?B?TG5sZUN3ZUdKL1ZsbytucmxGNWI2ZDZza0pkckxoYWh3YXJuN2ZzN0ZYYzA3?=
 =?utf-8?B?R2RYT0d3SXo1WnNyVisyTkhFTGhlbkNUaUxZdlNteUpxV0kzRi9oU3lvOFlE?=
 =?utf-8?B?TGpsSm8rMDNkTndBc0luU2VmZVZKRFZndWhZeG04ZlV3ME02OUs0bkM1b200?=
 =?utf-8?B?S1B3TWM2Mk1TeUNYRTRHSmU2MUp5b09WNGtQVlNRdGI3ZG1vanRGVm5tRCtw?=
 =?utf-8?B?SWx6RDVYZWdwWUE1SGxpTnF6bng3Z0xjM2duYlZLRGNaVkJna0xPUlFSUHVR?=
 =?utf-8?B?eWFuSi9TUFptSFFVRWFZSEhuS0ladHBDU3hyR0xRcGNyTGc5YUgyOGUraFh5?=
 =?utf-8?B?aEhSU3R2Um9ETzFmREpxMVZ4RktyVlFuWFZNNzhnam9NNDJBRUlPU0p6ZVds?=
 =?utf-8?B?NnhYZ3liUWh5YTg1VXc4aTljUUFsZVFKRUxqRTJzU1JvRFRRSlJ6WjR3SXlH?=
 =?utf-8?B?ODdzTitKaVBURFlaeFR2RXJacExGTlFVQUZuS2FGZXhHOUphcDdTYlNQTkVq?=
 =?utf-8?B?blJtU2xmejhHZUpyQnY3cEZINEhSNjVtWVRlajBieXhiVXFqalJyRnYxa0ZO?=
 =?utf-8?B?MHJnUkh1TGhheE85VjI2MDh6Wk1jS3ZkeUIyOEFsQjBucUgrakpLRFdWRFNN?=
 =?utf-8?B?RmpzL2FZTGZkR2tOU2ZYOGVGQ01sLzBRdTNraWxtdmZxTTJnWVlaNlYrQ0g0?=
 =?utf-8?B?T3F2WUNGbWh2TGlmRDBweWw5SFZsaVFlSHpqcTZ4NDNGeURxdEdDY2w4QUcv?=
 =?utf-8?B?bVdKdFNxdEYvcXRiaWVyZlpJVkU0NUpDMXJISmxSR2RCVGtMTlZSN0JWcENP?=
 =?utf-8?B?a0dUdGIzN2k1UFdyQW56K28yQ0tTTG1UY2hpUmpjYmU1YUoxZ1BmSExzcEhH?=
 =?utf-8?B?WWlCZG9kajdNZGNVME96Yi9ZVlVoQ0ZocmM4ZzN3ZDZVbVJWUzRzbnZ0cWNv?=
 =?utf-8?B?d2Fxck1mZ2hOeTU2WkR4QWh2MXRWMGFXVHk5S3RSbEpXYU1iakhmeG9IN2FY?=
 =?utf-8?B?TXcwd21qU2VMd1laZ3JZUXhaWHg1NTY1d09mOEFTRXpuM0s3Sm83bnVoWDFM?=
 =?utf-8?B?cUlFdjF2WFF5MGhDZ0VDeENZUGVCakZ5dEt3aFI3aTdEQjBwVjVUbHdrVmhQ?=
 =?utf-8?B?RkhJK3pBOUU1UHdKR3NuQkhqMHdSM0VoeUJ6S3g0Z1NoQVA3cWhHbjJ2U1pJ?=
 =?utf-8?B?cWt2UjVYUUxseGNrVmZHNjFTRXRKVHJDbExUZnRkK3BYeldQQW1oRzZLZmdh?=
 =?utf-8?B?UExpMUdaZnAwa3dPYS9TbkRMaktCcnRhVjJVcXNpM0V4dUIza1dxMVo3TGx4?=
 =?utf-8?Q?7WJzk8aM03ruc2NtrPrwKDFq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b98f47b-ec7b-459a-8c88-08dd30e7ea84
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 19:57:58.8154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 839asWDdlPBpIY3tim6tR005araouh+NLDohA0HMlVt9cm+fR9fLKuBXsppXA/hHhbeF1AU3COKzcMK0qi6r9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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

On 2025-01-08 10:18, Kent Russell wrote:
> Mark options only meant to be used for debugging as unsafe so that the
> kernel is tainted when they are used.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index acb9dc3705ac..1371b56beba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -751,7 +751,7 @@ module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
>    * assigns queues to HQDs.
>    */
>   int sched_policy = KFD_SCHED_POLICY_HWS;
> -module_param(sched_policy, int, 0444);
> +module_param_unsafe(sched_policy, int, 0444);
>   MODULE_PARM_DESC(sched_policy,
>   	"Scheduling policy (0 = HWS (Default), 1 = HWS without over-subscription, 2 = Non-HWS (Used for debugging only)");
>   
> @@ -801,7 +801,7 @@ MODULE_PARM_DESC(send_sigterm,
>    * Setting 1 enables halt on hang.
>    */
>   int halt_if_hws_hang;
> -module_param(halt_if_hws_hang, int, 0644);
> +module_param_unsafe(halt_if_hws_hang, int, 0644);
>   MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (default), 1 = on)");
>   
>   /**
> @@ -810,7 +810,7 @@ MODULE_PARM_DESC(halt_if_hws_hang, "Halt if HWS hang is detected (0 = off (defau
>    * check says. Default value: false (rely on MEC2 firmware version check).
>    */
>   bool hws_gws_support;
> -module_param(hws_gws_support, bool, 0444);
> +module_param_unsafe(hws_gws_support, bool, 0444);
>   MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
>   
>   /**
> @@ -843,7 +843,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = defa
>    */
>   int amdgpu_no_queue_eviction_on_vm_fault;
>   MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
> -module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
> +module_param_named_unsafe(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
>   #endif
>   
>   /**
> @@ -851,7 +851,7 @@ module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm
>    */
>   int amdgpu_mtype_local;
>   MODULE_PARM_DESC(mtype_local, "MTYPE for local memory (0 = MTYPE_RW (default), 1 = MTYPE_NC, 2 = MTYPE_CC)");
> -module_param_named(mtype_local, amdgpu_mtype_local, int, 0444);
> +module_param_named_unsafe(mtype_local, amdgpu_mtype_local, int, 0444);
>   
>   /**
>    * DOC: pcie_p2p (bool)
