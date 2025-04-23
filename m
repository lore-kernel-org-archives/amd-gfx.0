Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49623C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 13:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DD410E6BC;
	Wed, 23 Apr 2025 13:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KrbCiXSR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97EB610E6B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 13:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvOk2e7aQe+duEP6EMQEd/TAbdA7TpgZ5ABIns2M+mJ8b0OReLkOdMd725EAPLxyUKgDLF3dhlx/UJ9HlRLo87VhvYInNNuMUjW3w+vbKsE7tzK8eVsFHMHVUMs9wPAgZbqrIzru7JTbNx7HDpfDf/MA+bt3G3qMhdOQ/7+LWrcII5opKaIjeUnGHaY1K1Cf0XuBLOh1hvgIdt0YFf8Av0AnvrKadWwo9+uAVKWI9/8Gp7fA88KSwZL7Qk2hU7BB5wUXw8qtWsr7C324A584ZlOnaDh1aM2x2lwFDZ2GsKwv12OPlPtZER2aOj8rIQ1EBwLkdcMncjO3PXDAdMrhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB3BZc6bl1RPGxg1IJIptGu52AtIJ1362NoQ+UzoXt4=;
 b=UQU3RNnu1LYB/bI6rIsniXca4o3RX8pvh6VmXUCxSx3Eiha7no7kYxYeXSsDBR9Zly/mu1BU0LoeLzomAZBe+SeeFha9hMWndA1CHiK8Uny/fV4ZzjgPA2kvP12lRbpvo2vVHrF9xB+qqhc6RgnG8FkqjSE7wjpWgJYJlLFrV108tTZU08DgGXOeipVCtFjIvSXeI+7qacZM8EOOB+zuwuGKs9kJQ/fleipUaQ7tpIdYwws4Xf+PaNhoFC0z2IblOCvBFJmvlL8WUBsRusTJWOooA+AzhbgQAH2HeBeyDp3hvEavvzvGXaDlj4bPMIBzSPMn4vGYf4F8IfO6yRcSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB3BZc6bl1RPGxg1IJIptGu52AtIJ1362NoQ+UzoXt4=;
 b=KrbCiXSRCa2OLghqf6irWneLgDTYs3EXY4Uhy2usCVC/zHSq6rsyYR3WgbV0VQ6IDlRXNVEosxu39fKXSxuQg+KyiQlpLJ7YQ6vESW9lzhdLsEE02NXiKg/P5Ollj+xgQMjpKXeG2+Qpxoun2IL22mYGfkycfA9/kI9Y1E1cVu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Wed, 23 Apr
 2025 13:58:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 13:58:29 +0000
Message-ID: <337da064-628f-4746-8609-e17c2d0b7d56@amd.com>
Date: Wed, 23 Apr 2025 15:58:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: properly release the eviction fences
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250423132604.4002242-1-Prike.Liang@amd.com>
 <20250423132604.4002242-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250423132604.4002242-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E11.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8544e61d-f0de-4179-65b5-08dd826eed53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXBRVmtucStXZFJCcVRsbUNwUCtDaDlOTkdJdWp1ZVo1UzdqWUZ6QVRKVS9m?=
 =?utf-8?B?RktUdUpYb3FyL01wa0JmMHFqdFFxbU0xdTZLNFI2eVN1K1F1MG9ZNjdHTC90?=
 =?utf-8?B?RWFaWHQySHc3RjhhczdFdFRyTDA1T2c4bVREWHZZbDFIUExGR1pOdkN0TmVX?=
 =?utf-8?B?MEpJcHpZUzEvTG1CcGN5ZlM0WWZHT2VXRmVNWDB2Unl0bGJQbUxkQ3c2S2xV?=
 =?utf-8?B?Y3ovS2tqTTVhdGtvMFZZRjZzRjR5M1pGT0J1dWdhWHlHNnMrc1FxRkJXUkZ2?=
 =?utf-8?B?RDlYazNXdEJKcmxnNUZ6MTh6V21TU3JPUUJrL29meEgxYmFRNk4yRE1BNllC?=
 =?utf-8?B?YmNESzZaWnpqZzZQNys1a2F0QlJOTFl1MnhCSmk3bjJUVXd4QUZDWHVIRDRz?=
 =?utf-8?B?MDhrRGJpYW9VdEd2T0dQd3psSkNjMHVBdXJhTm9aS1d0TlMzdytlSTZmY0Z2?=
 =?utf-8?B?M3hPR0h1RU5jdHNnbXptOHlBam1UTXRPMmZWNEFPZDdoNFJXT1FyM1NkV1di?=
 =?utf-8?B?QWFvTllTdGZzRVk3SU9UemF1MUszV0hBQUUvMzQxYXRaWHBYU3hML05mVEhI?=
 =?utf-8?B?djNqUDlNbnB1RWsyTWRpa3hVbnBuY0txc0xZakR4TzRlUEJqVTM5U3dVWDlG?=
 =?utf-8?B?VWVyNkZYWHVNbm14SVlTNjB5YW90amVUdkJFSmduTUZGMlk2QUVoRURaWXlS?=
 =?utf-8?B?WStrZEJOa1ZFZnlSQlZDSjdJL2xKUmdrWkVzTjRoYW1Sb2xPV2NhaDU4RjFx?=
 =?utf-8?B?NEllR1prN1phWmxrU1hwbnhNZkw4RnphelRaZFpqVlErWDlHWjZwSGJZNWZu?=
 =?utf-8?B?aVdlNm5Oa1JiblRqTk0zckE2aXFrc2x2K1RTQ0ZaeEZiQmVDbS9JMnVmeFFv?=
 =?utf-8?B?U1g0V0U4K1dmSzh6eUlGK2U1SG5scEZzOHRIZGNGT3c0VVB5MUxtN1ZxZmhX?=
 =?utf-8?B?YytMTkE2eEJHZnl0QllHUFlkV2RQSHo3WkZMeFZNOUVpRlozWENiYzlrZ1dx?=
 =?utf-8?B?aFBMRWFhNmtkQVpldFY2T082bDRHdXRQTzlFQjNHbExpYWRBV1ROVkdWTHRk?=
 =?utf-8?B?Tjd2UnUrNEMzcWUrS1daR0dBejNSTVpFNFVkVk9TN01CRFJ4NExtcUJiSWZ4?=
 =?utf-8?B?MmNjakw3STBVaDVjSUxEdnZTMDNEOFZlWG9saHBCZzdkT0M2WVRmSDlTK2lU?=
 =?utf-8?B?Nm5xL0QxVStLMlcvQ3A0Um5TTHluQzdoWWV5YUQzaGs1bENpZXFrK3Z0Vm5H?=
 =?utf-8?B?VGZUUjV2VmI1Q0ZpdjhDa0lJbGwyaW5lUjJnWnpWU1ZTK1pIQVVIU1hlckZn?=
 =?utf-8?B?WUhwNThIcjcycW9BSHNGQSt3ZDF6MTBCc2Y3MTJUTWVNU1dIOGVBRlRURmNo?=
 =?utf-8?B?OWpIZ0NFSVhhc1VOUVBXVXVpc1JDT2FNeTk0S1hZWkF2SU0xRlJzRHVnSEpo?=
 =?utf-8?B?TDlEWXZaZXNzN0g2MWVOcVdWUnVWL2RLalpCNzJndGlUbVJNMkZqS2d3NGZy?=
 =?utf-8?B?cTBGMkxLMzhGQ0RyclJWM3luYXBDUVJSeFU4TTNWSEhwT2VMMVhYMllJK3o4?=
 =?utf-8?B?bmhJcWtxRTQ5cmRqV05LcnlBTFFNd1A4RktWa3ZwZUFRQUd6ZUkyYlA5UjEv?=
 =?utf-8?B?dEdEa3gyTkJMMnR4TWlkVVFZZUdwUGhWQ1VheGFtV1RadjdXemdCc2lWUXh6?=
 =?utf-8?B?Q2NJZE9TQldQWU9LNDFqWEFtUUduc3RDUVdORlp2Ky9DS1R3WjlzNk9XY1RR?=
 =?utf-8?B?dnY4bHQwM1g5N3VtdGM4Sk90aHJ5bnhOVE9vVDQ4N1lZcUhHQXhLMFFXY0gx?=
 =?utf-8?B?OGxqRFR5citYNEtBaXIxZmpJaEtxN0plNEhhaGFLOEY1QWhyL2pscXp5T3Ar?=
 =?utf-8?B?aFlmOUpMZEs4NGhnWDBYbDZRNDlSNVUvdmNVMzhMOTlMQWM5YVVWbFpFVnVn?=
 =?utf-8?Q?xF3RCupLi00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTA1bVVCWVBwemRWZVVpT0pYQVZmeHZuUGFteGp4Z3REUjdNTDQxQTlZVzBa?=
 =?utf-8?B?bDZYaHBId3VzWlIvT1Bzd1FrR2k2N1lpWW9uSnVlaEV5dWxUMnVUTlZoVHlD?=
 =?utf-8?B?SmFtMmpDaXFmWnBnOGZ4bjlxUDc2QnJZSUhubUppYVUrZVVvSTlLbW5VdmZu?=
 =?utf-8?B?cHAyaTlOZTFHemEyV215UDF2OUtPTTY0Q0gxRklROEwrRXZ4aHhsSFQvUDgv?=
 =?utf-8?B?aVdNeWM0T0VvTTdUd2pxR056NWk3S2J4aEEveHRmdWczRjhjQnEzbzZLRW1K?=
 =?utf-8?B?MUUwem9wVCtRVEsvWlR5d1diT1ZpclFaM3BUYjhuaU4yTnhmelZuRm9ySnBt?=
 =?utf-8?B?Q0V4STBzeGljZzI0SURnUlZBWG0xRlNqK1ZCTzMva3JPSTNVdWJCUVliZ044?=
 =?utf-8?B?N2h3dkVUbnQ4NUJ5YXFBblEvUGlGZzhYcDdqSEN2ejFaSmNJTnVEUlRxNElk?=
 =?utf-8?B?N1pOenYvd05YNzR2OFBUeWt4YmwrRlRkck1RQkFORVlFeGVlcFNBQk9vVEoz?=
 =?utf-8?B?Si82YUM3bVlRM1czVDZ2MnVXeXFmM3J5ODFwUHU2REtCSC9oRy90MlcwWUNV?=
 =?utf-8?B?b0dkMnlRbHZsRUlHREdxek92RjZiTHFxSENtWTQxRTJRVDRlcnA3aXZaT3pM?=
 =?utf-8?B?Q0Vwb3dkSW9VMWJ2SmdvV3FWOC9vRzg1dW52MVhNL0kxY09uYlBweHpWUTdj?=
 =?utf-8?B?R0pROVFiYXBBZjBVZkpRQjVINXRjRml5SWRNaWZ5YUtuT0F4d0RuQ04wZmZm?=
 =?utf-8?B?c2NZRXAxV1VJRkJMalJPdlhqT214bHliNjRreGpoeHI4TDU1YmJjaU5YMFEr?=
 =?utf-8?B?Q3E2VXRwNTlEN0JaSU5qbzlNMndiQXpvV2dseGtXZEVGcmc1K3ZBM1ZlRk8x?=
 =?utf-8?B?K1ZKTFdEd2o2aXpUV2lXS0ZhZEs1NGxyTENGMURTdG1mNGs5ekVrcnhyU3Nj?=
 =?utf-8?B?MHNNRGRiWnYvSkhMa3ZjV2ZxRzlGQnVZQkJna3lRTFZCbXQ4d20zWDZ1RFlZ?=
 =?utf-8?B?WU05ZkMrM3ZuUUMzVHErcWp5V3N5aWVIM0dFRmRJajZFd2QzNmdGWVkrVjdB?=
 =?utf-8?B?V1dDcFlqS2dQQzcvS2UzY2IweVYxMnRrdmVXZTExZTBJY2lqeVpOd0pMYTYv?=
 =?utf-8?B?Zk10M1dhN29sVEc3WmQ4NG9xVFBGdGVOVHhmMUpDODcrbUN6Q2ROTVZYbnFF?=
 =?utf-8?B?UGtwVHNIS0VaYStNT2lQaTVTeHZsd0JzbTl5dWpib0t3ZjAzcVZ2ZC9RYlY3?=
 =?utf-8?B?M0hLWGkvOTBYNmNhS2dqcHV1WmpRVTVpbVFieVpuSlJ6YjZLZzZ4UWYrenFL?=
 =?utf-8?B?bnV5WVdYKzNRRURrR3VveUNBU0dab0lKN055V2VvbVoweS9KZHd5Uk92YWJP?=
 =?utf-8?B?aUpyRWVWNFR2ZWordUptWERDTWFlT1hGNzZJYzJQLzVmMkx0UHJrVStrUU9J?=
 =?utf-8?B?ZmxGb1FGYmdFcUU2eWdIbUFISENzVGtWNVpvdnE1a2tyVElONGZwMmR0UDNE?=
 =?utf-8?B?R3lpWFNRVDRLSkM3d1V0MGdoUmE1cERtL0R5RlkvY0JjczU0Rks4N0VjU2th?=
 =?utf-8?B?eXB0WGJOMmwzY2ltVXgyV0JxOEtkWDdVbmJZc09NQkJFdDBBNjBVUXlwc0Q2?=
 =?utf-8?B?Y0kxY0dhWkJRb1Qvc1FJdm5FTmk4cFZGSExyMGRla2dXc0R1MjhLdU9YVjg3?=
 =?utf-8?B?RHYrQ1U1YzJqZTJaT2lQaHRZeno3UWEyYzc5ekNPK3RrVHArUEtiN0J0RTNj?=
 =?utf-8?B?eURBcmNNTnlzMzVpbVZSUFhhYXFocnF0VG5RTW5DbWVOMGcyTWxablBKM1h1?=
 =?utf-8?B?UUxrMFVCSkViblVYMzlDdkg5OS9BVWN0cDhuTWI3cFl0bVBiUVVEaWE3K2Uz?=
 =?utf-8?B?eGtFRnd3dklETGhudGovUkwvQ1NTVk8vQnFReWFrS3lFSDcweGJIM043am9X?=
 =?utf-8?B?anlTRThTVVN4VjJVc1k4QTltdFpwaGFDd1AzZDNmcno5RmFBVysxS0VzbGN6?=
 =?utf-8?B?YnlZeHlsbzROMUZkd1dUNkxzN2pqQ2ZTM3U3SkRTWGpyc3I2Z09ER1Eza0px?=
 =?utf-8?B?d1J0U3U4eUZZandIaTJQV09xTjdOcUN1UER0Q2l4Z3pPYXJPMWRUeTgwRjBN?=
 =?utf-8?Q?8dQrhhx+TXBL1mqdtIRxO9xNZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8544e61d-f0de-4179-65b5-08dd826eed53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:58:29.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B0+eh7nFB/8IUNcQOC47xi2kS2VPLNSlgtvNv/ghLCARON9KM70OLPPtcpGPn1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

On 4/23/25 15:26, Prike Liang wrote:
> The following cases require releasing and deferring the
> eviction fences properly
> 
> 1) Detach the old eviction fences before attaching a new one.
> 2) Drop the eviction fence init reference.
> 3) Correct the attached eviction fence reference.
> 4) Free the eviction fence when the attached BOs are released.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 53 +++++++++++++++----
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
>  3 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index d86e611a9ff4..a47db865c530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -70,11 +70,6 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  		return -ENOMEM;
>  	}
>  
> -	/* Update the eviction fence now */
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	old_ef = evf_mgr->ev_fence;
> -	evf_mgr->ev_fence = new_ef;
> -	spin_unlock(&evf_mgr->ev_fence_lock);


That is certainly incorrect. The new fence *must* be made public before attaching it to the existing BOs.

>  
>  	/* Attach the new fence */
>  	drm_exec_for_each_locked_object(exec, index, obj) {
> @@ -82,6 +77,16 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  
>  		if (!bo)
>  			continue;
> +
> +		/*detach the old eviction fence first*/
> +		amdgpu_eviction_fence_detach(evf_mgr, bo);

That's completely nonsense. The old eviction fence is signaled at this state and doesn't need to be detached.

> +
> +		/* Update the eviction fence now */
> +		spin_lock(&evf_mgr->ev_fence_lock);
> +		old_ef = evf_mgr->ev_fence;
> +		evf_mgr->ev_fence = new_ef;
> +		spin_unlock(&evf_mgr->ev_fence_lock);
> +
>  		ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
>  		if (ret) {
>  			DRM_ERROR("Failed to attch new eviction fence\n");
> @@ -89,9 +94,10 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  		}
>  	}
>  
> -	/* Free old fence */
> +	/* Free the init eviction fence which was referred by the dma_init*/
>  	if (old_ef)
>  		dma_fence_put(&old_ef->base);

The comment isn't really helpful. Additional to that it's valid to call dma_fence_put() with a NULL fence to we can drop the extra if check.

> +
>  	return 0;
>  
>  free_err:
> @@ -189,7 +195,6 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  				 struct amdgpu_bo *bo)
>  {
> -	struct dma_fence *ef;
>  	struct amdgpu_eviction_fence *ev_fence;
>  	struct dma_resv *resv = bo->tbo.base.resv;
>  	int ret;
> @@ -205,10 +210,12 @@ int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  
>  	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
> -	if (ev_fence) {
> -		ef = dma_fence_get(&ev_fence->base);
> -		dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
> -	}
> +	/*
> +	 * The dma_resv_add_fence() already refer to the added fence, hence in this
> +	 * placement needn't refer to the armed fence anymore.
> +	 */

Please drop that comment.

> +	if (ev_fence)
> +		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
>  	spin_unlock(&evf_mgr->ev_fence_lock);
>  
>  	return 0;
> @@ -224,6 +231,30 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	dma_fence_put(stub);
>  }
>  
> +void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo)
> +{
> +	struct dma_resv *resv = &bo->tbo.base._resv;
> +	struct dma_fence *fence, *stub;
> +	struct dma_resv_iter cursor;
> +
> +	dma_resv_assert_held(resv);
> +
> +	stub = dma_fence_get_stub();
> +	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, fence) {
> +		struct amdgpu_eviction_fence *ev_fence;
> +
> +		ev_fence = fence_to_evf(fence);
> +		if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
> +			continue;
> +
> +		dma_resv_replace_fences(resv, fence->context, stub,
> +				DMA_RESV_USAGE_BOOKKEEP);
> +
> +	}
> +
> +	dma_fence_put(stub);
> +}
> +
>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	/* This needs to be done one time per open */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index fcd867b7147d..7e6c55a334e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {
>  };
>  
>  /* Eviction fence helper functions */
> +#define fence_to_evf(f)  container_of(f, struct amdgpu_eviction_fence, base)
>  struct amdgpu_eviction_fence *
>  amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
>  
> @@ -66,4 +67,5 @@ amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  int
>  amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  				    struct drm_exec *exec);
> +void amdgpu_remove_all_eviction_fences(struct amdgpu_bo *bo);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index dbe57996a481..6d3eacffbcb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1322,6 +1322,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	amdgpu_vram_mgr_set_cleared(bo->resource);
>  	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
>  	dma_fence_put(fence);
> +	amdgpu_remove_all_eviction_fences(abo);

That's a really bad idea. We only did that for the KFD eviction fence because we didn't had any other choice.

For the user queue eviction fence we should rather do that in amdgpu_gem_object_close() e.g. when amdgpu_vm_bo_del() is called.

Regards,
Christian.

>  
>  out:
>  	dma_resv_unlock(&bo->base._resv);

