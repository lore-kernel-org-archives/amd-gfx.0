Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E8EC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 04:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D6010E1A6;
	Wed, 16 Sep 2026 04:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b4mW1uS9";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A012C10E1A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 04:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByUorihsSfoYPPYuYz8Erzvi1WNf69G6LLBrjeorxBTVOQ1uFlgfnt3tOD/skAoS+uRImnJtdW1Rj5W/WLQqNdH0pAKH8SaUK6KxhIcYVulMo6gSj3+Ipze+BRJODBI/kWiBWvNrnwO0CyI5ZQUyASKsVhSDbx0AR+6olAKWomDiPVWZvWu9fUYgcst/xoUvToiXLZMAcesq4f3U416qQgrxChuJS0FDXI+22fMFvO5uJMsHjkVvEx0Ri2e3ZrjEz9iEiTop5xFWquP18A8E1LfO+BfNiatJcAGjC1T7ZVEc+LMTen0S74eQIvB2nAf0c1syrckou5L3N4MQSy0LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILsjimRX/EX+LOokKwkKgT669BRlt8QJJBu2+d3O260=;
 b=NyuboHQh0sVdK5tDKQpaQy8nPRu+7/rfi8QLu2cpANzL7pcPKxnVr7pDkpPU+u7sXWENCA2qcQ+F/HlnLQMjorVnd2Ib8UyosNJSx+w4ciIqS7taPhCMLIGL78+8Ld9z3oOGTJIHDE7XvvwUGHGBZrskkZgvf8L8oLopqMj3WgRbTUf2D5IXj13Pkqrah5clq3juoWOhHHiqPGcFIbwKTjD4nJWnc33GMG94vBHGE4jCN2asQaaa6gle2+uM98fGjjPSOiUMF8cbSg7UBHG5+RHjzjHKCh/DcgPMPlOTGOmjO23k4egtG/r2b7IiRfBWjEF5aKlkNg2/Ov75/94SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILsjimRX/EX+LOokKwkKgT669BRlt8QJJBu2+d3O260=;
 b=b4mW1uS9P+ZZnzBPTppQ5x7ve3OeHt36u9hPbPTfEi0JfH1Pitfjl5Ld5PoduwFCAbtaUVh4KwDSHmLw8X8wWdocJnwk9FIU2eM9Tzyq0BvWiRm5BbhprcSSExbUaRQxmne7ajzkY8Lb7D0+0eKAGRR8jwCobzTHfOQCx+7+0JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 04:52:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 04:52:47 +0000
Message-ID: <3d709b25-8a33-4a16-9594-10274439e5bb@amd.com>
Date: Wed, 16 Sep 2026 10:22:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix SMUv14/15 power context allocation
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20260916044100.1656293-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260916044100.1656293-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3f6568-d55e-4315-7d61-08df13ae5a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q1+y6qOAq5JmjIMyv2uC6surUZzRADRRZUR5eFW2JrtgHPW3gkNGWMcDmY3O86h8f5+M3Vn8Vy4fXz7w1C9btAzRHj4+vskp0VfO3m06NpPIKuv1COR43b6uFPcfwsCPAtLWzyF1YFTPGsU1hU4nrf1VTmgd4+AKXjZi6sFbVjDRYGsomrtV/itWRBLeysINXpgVJrI1YcJPXgolXldB0faweInlr4rVzbWQQMjbxD20A6FRyB8FaqaEx5jN8623A7SG7s9xKYI6hqTqWngaUAzeZciVbAoZVzDRVONfBVqQoiceypGw2rnmMEEt/dssPj0ZQQ+qSuKvk42V4xXhJxCiQ5v51u/zL70oNzrevqomq+nvL5caAxqMY7P0oedB/+S0jmAqoAYi7mReqluADmgYc8A33EltXGSO4meEvYc/LsaGCgnpEADYi274wdw8c3dqFjnkYGh5hVUXD1cKjIy3dOMgVBKyARaBmFhUdww9JPvRSjNMkgzKJo0vVyX7Trs3Hdp3bL/deTf2PDsvwfXfnNweMpwpTml9hqyXCLiqDYdh3DhAzq7wpL0L0NAHy6C+/uMBVSSU2OcABBrskf96d2nIYkwquJTEE1NoADe+LeB4V8Nj7uAXCVyJIx4ZSBb6bHEUu3IJrp/wpJJIuTs3fTSXUZ6bDavpG6XqK1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRmb00zczRubGFOVG91UitxMTFiNjNIYzljZ0VBRDZIM2ZrQ05haWZvb0lC?=
 =?utf-8?B?N3NsQlk4STVBblduaUsySlZPSzc5SFhDamFQZThhbVFna3gxSXZPcEI2aUI2?=
 =?utf-8?B?MHpITGgxcXJSYUdJR0p4RzBwWG5EVkNGb3I4dTBnQitRTTlnUExNRlRnYVhk?=
 =?utf-8?B?d0laZTRVMmJnYUYydVdvWVZyRHRlaHcxOUgycGVFSmV2UE5jZlVOUHFoRGt1?=
 =?utf-8?B?YjN1QVNLVTRzdDc4M2h3OTJKRGcrblF2cWJOL1o5d1J6Wm1LbTFUOW9xbUZx?=
 =?utf-8?B?RzgrVG54UzFGa3lqR1lzUW5NSkQzaGpYWG1oM2ViaG82blBsa3p4YjhqUGJY?=
 =?utf-8?B?WDJsNHNBeElSMWw2UGxvblhPY1ZqdVQyT2dXQ3doamQyZitFak1GbU0zYlZE?=
 =?utf-8?B?VFB4b3NCYkpOa3hLWkJnL3Z1NkgyVmpSNlhYM1RJMGJ4ajZ2Vm1SQkJQcG1p?=
 =?utf-8?B?THFrVnNuSUJ0YVM3SXB1M2ZHTVAva3A2eUIzaTYvMzNMRjJRY2FiQTF3OU4w?=
 =?utf-8?B?NWVHQTM5OXRlajJ1YmZsUjNSR0pKeU5yU0NYME4vQnBnVkNONDNlYldTTlNH?=
 =?utf-8?B?Zk5tS1JFMGcxWW4zUGJZemxKUzRtQ0oyU2t2R0d6em1DbVhoZE5zSytxV09o?=
 =?utf-8?B?d09hb1RLOGtzWHVadHd1MUw0QStMQVVQR3Z0NkdQejdyMGQ5V2dJNGJ1WEE0?=
 =?utf-8?B?T09CODRabU0vTm1sZFdvT0NBa2FHWjh6VE1wSXdjU1diTm9EZ1JFcU54c1ZI?=
 =?utf-8?B?dGNoRGpSZm45WW9CNzFBUGFnOXlFWXgyZzVsM1hDMkJCaVMrbWlIdlV5Sk9G?=
 =?utf-8?B?aE4wVWFydi9iUFI1RzJ3Y2Q3b3piOElEeUduQnJVRUM3QWZWSlo0NnpZR0g5?=
 =?utf-8?B?ZFJ2aFFiTi8vREU3b1dhVFhGRHBRR01OR29hTXBRQzkyQ3lraFFaZ2VFd1hV?=
 =?utf-8?B?Z3pBU3NHWm9oNGpZVjlhUk5kRy9IOGdkckhaY2tIWU1nVWRsQ0F0NDlFN2xt?=
 =?utf-8?B?RDY2ZUZlZFZPNXVwUE9nSnpHTHltamIyOER0UmtnVTI5WjlRNnNZSGpJK3g4?=
 =?utf-8?B?SG9kKzRzTkhsQWFNQUFnTWhUcFRHa0RmWVhYaUUwOXZvRzF2dG04NlE4T2JG?=
 =?utf-8?B?Yit3QmlsSEo2aUUzeW5vR2hxZkNWVHpQZ1VDZzQvNWxFNEFXak92aGNpQXZt?=
 =?utf-8?B?eXpGUUJkU0w5VlNESVlJR2ZvRXNmM1UrWUw2NEw4TEN1RUxPcXJHaG8vVC9w?=
 =?utf-8?B?MUZ4TkhZdkNBaDJkZjQyYkxuWC9JZ01YWEx4YVo3dWFLUXdEdXVOQXp0alNj?=
 =?utf-8?B?VnIwTHRvbWVrcTVNUGJIbUcvNFFyTUVMUVNtS2ZhWlVVUXlqRHIwWkp0Wkh3?=
 =?utf-8?B?RFBQQ2d5NDludTY2blRIQ3RienNmNWplSDRxblM5V2U0WSsydmpoVTZCR2Uz?=
 =?utf-8?B?MEoxd0gyY09LMDZ4bVU1MWlRZTN3UEF2cnR2ZGxNNXhMWE5iWTY0Q1BSSE92?=
 =?utf-8?B?KzYzRWVMcGhjTjZRTzgvM3FKUFlLbnV1KzNVNzdKa1AzM3lMcWoyWFdCV2dn?=
 =?utf-8?B?ODREUWNscDlXUnlqaGp3QmlFZFlVbUk5ZzY4cDg0NkFldDRlbFZncytMNjZZ?=
 =?utf-8?B?bENMcmFJNGRvbllNVDVFNTd2SDRMeFFFWkRSdHZEYWxQZnBLMUhNZVk5dWU5?=
 =?utf-8?B?VFN0b0FwZHQveElHZ1VjNlBlY093dVg2Y2NqNWxLY3lFWE16VUh1RzFIUjNQ?=
 =?utf-8?B?SGRlSklCVDRwU1E3aEVlWG9yTDZVTkdPRkxNU2l1VmdOSzlVMUs1NjVBcmdT?=
 =?utf-8?B?R0FLMnJSRnlPM1NGdFpSZXk1ZlYxNEdKaUxJSEFoTnVsS2RhOU5HbGEvYmk1?=
 =?utf-8?B?Y2Vnd3o0d0diR1ZzYmRSdVMxdnNBbUZudTdmUUNYOGxMNGpjeUFESDlwQ1dw?=
 =?utf-8?B?eUtBdVAyNmE5cUhYcDdqSkZrZkgxdUsra0N2a0ZJN1I0TjBwanZsV25DSXZa?=
 =?utf-8?B?MGh1ZTRicnA2RlVBY3g5bGlxcDVwNVBaSkxjb3Jmc2s0TGJRajUwaTIrUE91?=
 =?utf-8?B?MlZPTEhEQS9maTNQMTBDSndsZlFuVHRYMEtsRm5wOUpjOTVHNXJVVVVZYXd3?=
 =?utf-8?B?UHM1Qkc1eUpNOUxJT2s4UzFhV0FrUXdvNmdSTFREcGIxSTVHUFNvRi9tN1Vo?=
 =?utf-8?B?VndmYUw4Q2d2eGVOalFaUUlhOE5wZlJNYTltVjZMK3lHSGNudHoyM1BSYkdw?=
 =?utf-8?B?TmljcFREVjQ1cW5iMnk0OXpveCtVMTQ5Vm0wbE5TVmFSVUNIN05ad1QrVERM?=
 =?utf-8?Q?K7Qc6tMz2iLGiKOmgx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3f6568-d55e-4315-7d61-08df13ae5a34
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:52:47.0258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nu87GK/c9YGM8xGIUGXTMnvDgAk7yXqQyowjA7um0A1wtv8Wf/AmViUZMo9m/pC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

Please ignore this. Sent another with a second patch to drop redundant 
variable.

Thanks,
Lijo

On 16-Sep-26 10:11 AM, Lijo Lazar wrote:
> Allocate the right power context objects in smu v14 and smu v15
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 80dac277d1ae..f2e6105b0d79 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -396,10 +396,10 @@ int smu_v14_0_init_power(struct smu_context *smu)
>   	if (smu_power->power_context || smu_power->power_context_size != 0)
>   		return -EINVAL;
>   
> -	smu_power->power_context = kzalloc_obj(struct smu_14_0_dpm_context);
> +	smu_power->power_context = kzalloc_obj(struct smu_14_0_power_context);
>   	if (!smu_power->power_context)
>   		return -ENOMEM;
> -	smu_power->power_context_size = sizeof(struct smu_14_0_dpm_context);
> +	smu_power->power_context_size = sizeof(struct smu_14_0_power_context);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 2269703869f9..dfc1022112d5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -338,10 +338,10 @@ int smu_v15_0_init_power(struct smu_context *smu)
>   	if (smu_power->power_context || smu_power->power_context_size != 0)
>   		return -EINVAL;
>   
> -	smu_power->power_context = kzalloc_obj(struct smu_15_0_dpm_context);
> +	smu_power->power_context = kzalloc_obj(struct smu_15_0_power_context);
>   	if (!smu_power->power_context)
>   		return -ENOMEM;
> -	smu_power->power_context_size = sizeof(struct smu_15_0_dpm_context);
> +	smu_power->power_context_size = sizeof(struct smu_15_0_power_context);
>   
>   	return 0;
>   }

