Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8518CD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 04:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223A810EC97;
	Thu, 11 Jun 2026 04:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPwu7KFM";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1370810EC97
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 04:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVPOpMInbr2CbcAaGqTrkznlAcDn/hAE4ZuwPACFgErj3lUo6raftUDvaD+qa6scgh9k4g3HVwkiRNV1J7qVxQ0TvOZ1GaqwHm1YXMil5/nIzbVx6mSIr2B0dQiWZRxJyKfhh7+Rj6UTdUrVxFE0xo0RKZsuC5mPY53JKFULiP6bIyqXC8Tv1XIMzJZB6Tkcv2lLlZcgD8csu3FB8YzVq3JNUEv28OQssiUwRiQMBKB627Lyez3yn7NkIj13p62dJhZYtVOD71e80k4v32kdyCZwSyjGZVL1DfzKJXwCiuZvxAoWaUpz8ynTCgVMhkke/MZsKPd9PIG7a2ifk6xCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7+DS/wE3drlSPoud+prapQCy9gD6+t0bvncLEdvm2A=;
 b=YEWlGjETpx4mDbVWnNji9sr5bXSL4npIxi+/eqLJCttXnXCIfPcpZNpQXPgeTz2cz1944u1cRMHhn28dLox70iBP/Bl/JNFtN5kBo3oOmx6sOe3gU2TigNoEiVJqV+2dJaZrrtTjLbMaKjGrBV6gZgeeZF6+w80TRKQi/UnYzprn56EjqM/BI6TX1q031BTU95UiMhD7pTgRLqA8WIZeYre1TPRY4XLtJO7EPs9Itiryl/+kYmYn5z5VfHrROwp3GHUSKP+NqPx7MYI4cWtbuN+Gwe8LIpodD+TXm4J+VCgbm0sWJycrM4QT6ooSOEURa+V9maqQ5X7XNhSxE1yLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7+DS/wE3drlSPoud+prapQCy9gD6+t0bvncLEdvm2A=;
 b=tPwu7KFM0MU3YfMjM8JzqixCGGjWPtLtLjvvJSyPAAAVxDZaPYv3svwvIfDRj0I8c+Vwr4Zs7wy84sd8mYc3ChaO5jwGkB9AKMvaXglEKw3ujd+K5gR/qs8vBKCovo+05+Ixe2L0K/nNF+YevUVGbh93PomJc2eL6MLiWoQCmIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 04:11:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 04:11:58 +0000
Message-ID: <a64c699b-69c1-4314-a0a2-35544c27d851@amd.com>
Date: Thu, 11 Jun 2026 09:41:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amd/pm: smu_v14_0_0: add DCLK metric handler
 via VCLK fall-through
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260610182333.3922-1-Priya.Hosur@amd.com>
 <20260610182333.3922-2-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260610182333.3922-2-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::27) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 845e6c34-8750-4859-fd74-08dec76f9480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 7qxiHNgGpMeNGEIhMqOF476MnMloxzS4nehMbQQT8QVGDZpxoB5bEZ/oslBTnjXApmjg0m/fP7NxbytaIFi3eCcsOw0o0r6zOTBMu4+XiYnr5KdP8qWtz0Jh3Xy1X46YXndHXwE9+NUlKhKx3JQRQnImA3AbtcogXcewDiT+ceOKaeK/u5UIjUohN67B1tlOjiQ43DE0BLwaiNSidQKc8UKDcFLRfYZ+tHmYKW4gMAHenZOWe0jHyG7iElA0KysVT2J10lf9OAvQKL/G53UPHxTEB8V4SNj6FalHli6bxdgOaCULA5AbYNuyni1XyoM0Wu6M0aDq9toyJTa4Bd34kgycEtohdxpWykJJOf12ty6mlQ7a67nZa0RT4j7sTWYlk0MOQbjAv8QRomImLsnteLurIddqHcxuIWKUAI2Z0OgImMFoVDOGfOIF0oHqnn4o/zNxpCfwM/itZMB9TiEr/bLegaCqMtP0JrI7COIMpfPasL0BM2zkIANieL9cBj6hbGVlYVZ8uMentB4CodKIWujukrSjdcODdOzfe1RcaBFCuHzj0tPi6rTtRdLJhahKzcmm6MPV06iuMM6c/omUI5Kw42GGgKBsGsXs1+bk89e/Q54aF95zFSEkyYaSSv0BT3gsO9wVUxBdQUf9uap6bGvOO2ajpE3gD98PI9B/C331EBqFemW7yBFWiLgg7xBr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVCdWtucnBLakNma0FhdkQ5YlgxZzhFMnRHWitLZld6NnBjcFlBa1NWOXo4?=
 =?utf-8?B?cDZMYTduMHdHNVEwaUdRNWlLeFIrU05xWnBTa2tCSWJHc2tRdENhSWsyOWky?=
 =?utf-8?B?YTdZOHNnRzhYSDVVdXVRNmQwdmJ1a0xwVTRZYStCaHAxaCtic2NsNXJzUm1Z?=
 =?utf-8?B?RVIvdjIyYWdSRWwrMkgxR29HclYzUG1VNkVnc2EwWEdWZngzUlQ5L1VEK01H?=
 =?utf-8?B?TktTM1JpOEhXbFFRWkExdk1sTVI2MVhLSmNaYjRIcGpPNVc0bUY2di91NDls?=
 =?utf-8?B?b3NLRnZVWHhzaDVPMExla0RlUE9zSW1yMGREMlNnd1RLUmh1bjNOdzAwaVE2?=
 =?utf-8?B?b3BJOGIzTVZzODNidGlqaUUzTXpSRXlyMEJJNk1LQlRqSGJ3WjZDSDVuMmlS?=
 =?utf-8?B?Z05LY21paTBuL1B0Qml6bkh3RDROWW5vbDJPSXpVYTFxWkF0R2NHQXRPRm9P?=
 =?utf-8?B?Q0ppbWI2SjZ0b2hsak9Sa1E5NWlsRWpRUWtjeUZ0cjZPL01CY1pZcnU2NUU4?=
 =?utf-8?B?a3N3VFBnVXc4Y3Q1VGZLcytneGh0bzY2OHIzYVM0QjRwQVphUlk0a1lYTnJJ?=
 =?utf-8?B?S2JPQlNZZGFtcG5SN2E2OTNFQXR3Ym45VmJTR3hHaHQ0YVpvU2NGZHFIczVK?=
 =?utf-8?B?UUtOS1gydFk0enR4a3pxRkNweDZNMUU0MkZraCtLcDZ2ejJXRENlYXE0aFNs?=
 =?utf-8?B?TWwzS2lvWCtuZlNWalI4dmpIcnNQYUFQRTNYWjdzNTQrelFzNXRnQkxPNndZ?=
 =?utf-8?B?S1JRVXM0eHY1amZRY1dKUE9XODJzSGxqSlYweVBnNWNEYVIvaGpvdkNqOFZi?=
 =?utf-8?B?dVZ4ZjlDVTkyTkFKcWVpaWt2NGdIQ0IrdElsbGxrYlNuN3JscGY2S2prREZ6?=
 =?utf-8?B?bVQrTkplcU1rcWFqQzV4WHpzQkwyYmsrTXQrV21ST0FOYnVMSEdwUllTVEhF?=
 =?utf-8?B?TkM3OG9XM0dNdk15UENNcGx6dmNuSUFvYkFiekN0c3VTZTQ4QlMyUzRBRERw?=
 =?utf-8?B?a0FMMFkxWVJ2cE5RL3lWRW9aYUt4RFhzaGFWTHd1ck1GOXVDcENreXVON1ln?=
 =?utf-8?B?UVVKVmJvdkNMV2RLT0RXN2N0RHB3WjVvY2Y2SVl0RHdOTnFVcmNRRUk5RTFK?=
 =?utf-8?B?S2pDR0FkS0R4RjJ3Wmlib0RJQi9FVkYwaExERE5NM002WUpqSXpzSGVmWnVM?=
 =?utf-8?B?RlVsOUw3ekRKeE80OXZKTG1sKzdwNXR3R0JOb0NqZVFsSUozZFZsYW94aEdP?=
 =?utf-8?B?UmJXc1lTU0g1czl1NTZKczF4UlBtc2NlU0hSTXZpU3pqNHorZ0RvWHNoeUxr?=
 =?utf-8?B?dFBERVlTRVFHaWl0RGVOQXhweFZBUFk4bUZpNG1MN2pTL1Rod0FldW1KMHJH?=
 =?utf-8?B?bEg5TVJQWHMwcmJJR215OTJKQTRRK004cnhab3AydWFXSHkvWm1vMnJxVGY3?=
 =?utf-8?B?MWVuNU01REJIdnhxeFdxdlQ0UEk2VTBHaGIvRmpHcWJDalJRTTJIMHhIK2ht?=
 =?utf-8?B?STh1L2dZMG5iSUhGdnFVUnJvYW9GbWE1QjRYV29NY25rdHhJbmdHYWRJVjR5?=
 =?utf-8?B?SGhUNmUxM1ZkYVZIdWZjei9zUldzWnl5UjAxU0R0TmlMd2h3YVo2clRaVi93?=
 =?utf-8?B?cEN6Y1MvV0xLcFRiZFBlNU1NTjJTa09lVlJpUzJHWlJDa2F5WWtoTGc4K0oz?=
 =?utf-8?B?czFDSjAxTjFYKzdmV3h2ZFFQd0lmQ3BaS3hKS3d4Z01GVDdpanFWK25aQmhG?=
 =?utf-8?B?d2Z6N0lHbytDc0xZME9aMG9taEFMamdUSm04UWJ2d25tWUdRcndDNktkSVZK?=
 =?utf-8?B?dXlGVmY5N24zMmxQdXF5eFV0a3RlaUI1NHQ3UFo5OTFLT2xqRXhBZm43Y25V?=
 =?utf-8?B?K3EwTHJtYkRKNmRDdkV1c1ZEdStpSFJ6NGRBSDhkd2s3bC92dE1Td2JGWTBU?=
 =?utf-8?B?azNTeFNQWU8ycStMTmJUY0RrNW53QXh6NWkwWlo3ZDIrTXp2eVZRd0lYLzVR?=
 =?utf-8?B?Z3E2RGQxS3hXbE0vendQcFhRemVueDVFR3liQ3R1Z3craEthdVE1NzRQR1hv?=
 =?utf-8?B?OTFJWGxDU0duNnNvbXV3SGFaWVVjMllnUjZ2dCtOemF4WHJTZkhPZkJpRTVn?=
 =?utf-8?B?bE9pdFpoL3EwWWY5MU9hYlZYY0pZRm8zMU0xMTBVMlNpcnpGUngrRTRoNERj?=
 =?utf-8?B?czJ5cEl1ekpqTUR1ZVJObGJsVG8rSzVVQjNLc2xUSkRFaU5FckxENVNNUkJs?=
 =?utf-8?B?QWVGQVozbHFJb2dJNnl3Wk1TL2ZheGsrYzRXU1hjL0FzNlVYTFJlbk8zdVZp?=
 =?utf-8?B?blR2K1F3ZCs1TllzT25lL09GdGlFd3h5aWdOUWtIUHdRTTRESEd2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845e6c34-8750-4859-fd74-08dec76f9480
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:11:58.1690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvA5tbDcrl28myTFhTr2fJ3etWq5iQQXYeBAcrHL1EOnNSnGra8CYC2+VxuNWOK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
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



On 10-Jun-26 11:53 PM, Priya Hosur wrote:
> Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
> fall-through case mapping both to VclkFrequency, since SmuMetrics_t
> has no DclkFrequency field and DCLK tracks VCLK on VCN.
> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a..79e0e2fca602 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -281,10 +281,9 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->SocclkFrequency;
>   		break;
>   	case METRICS_AVERAGE_VCLK:
> -		*value = metrics->VclkFrequency;
> -		break;
>   	case METRICS_AVERAGE_DCLK:
> -		*value = 0;
> +		/* No DclkFrequency in SmuMetrics_t; DCLK tracks VCLK on VCN */
> +		*value = metrics->VclkFrequency;

The code refers to separate clock tables for DCLK and VCLK. As per this 
they are identical, but still fetched separately.

Thanks,
Lijo

>   		break;
>   	case METRICS_AVERAGE_UCLK:
>   		*value = metrics->MemclkFrequency;

