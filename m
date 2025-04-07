Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E69C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 05:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE1610E1C7;
	Mon,  7 Apr 2025 05:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Uwf1IDM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96E810E2B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 05:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yuqiw+iwmqO35CXrcESfoj6+ZjwxEd+krW4SCKmQMVv3oA1tmL7rECm5uPsB9fEvZXr12z02rQiVzzIME4Df/9MB0sQPIgiYPjRn55Iqd+O3EMrFYxivHN9etkBlYSIMmfvWJrTKlt2sMVM9UvRkbPFSryHgjI58sSGVgZo60qpeH34U/wXmK+dYlE1tnMdnS4lQY/+d6lik1K1FqfpaH4dKxKvje+LqcTIwBDe3XPiPcEkOe6hTVC90AhxFze2gZ1QsNy/XoqBnOjSnEK3mBo/jp3Rt4uX9QS+vmzyq/o9nN2ePxfhIkZH2bhyrF2QzV1aHXwwLUy0j4QsicJ+Nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpOvWLiJ/ey2F/asRzT4fmdbW9ywe9P04SFeBAqfmKY=;
 b=N0BE5jwZaOmwMxHgeokamhjMehZCtdtFDIdrPdmf5BYKfoaCLSWOMolhgKGZP1HDQHrThaWPQ+4Pi0EpJiNHBjjP9WFOaj31UPS73CFTuZ+6rGXmexk1kfUMGFfB0siomrpuUYRdL0JghAd2L1CDH9Z722zM5X293hNpYqVpm+md3Mish5yifpMfx7lZPN2i2R3467B5DBk5bbpWqu3ynCIByxhED4IhlwgEHrMByjIt75Dd7gOqco1tyIXEbiRzw/epSJTdBUuKDK7as3qjuWuqlNwafMM8BmUjC48VKBaMJP2y/yKFcUTQiASO+8DmADesWEIUSnnTeZw0ik01Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpOvWLiJ/ey2F/asRzT4fmdbW9ywe9P04SFeBAqfmKY=;
 b=5Uwf1IDMMHDFmaneVzV06LHUBkhjIMajmBiN6gplK1cK3QgeTyenjEQtCWX/ELowu9jIxpKrqQfIf/m589EtEi69gNmpXDs0IwjHggea95UEGhXs+RlVSTV3IS/LuOwYBMOYeD9eEByLcl/9r3QMR3NQrFh3Obio4lLdSbt/7u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 05:58:49 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 05:58:49 +0000
Message-ID: <bb9f822d-722c-45f1-8432-d21c129c8a8f@amd.com>
Date: Mon, 7 Apr 2025 11:28:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: no need to set queue_active in
 mes_userq_resume
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250402121636.1689678-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250402121636.1689678-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f719b97-9068-475f-6812-08dd75994474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVBkbldseXNKODZwWk5iQkJ6bUhWdzNqcisraGpqT0ZnT1ZINWxLUnRYTWdM?=
 =?utf-8?B?NDFQaHlaU0VtRlZVcnBnVzh5SGNoSE5sUC9lVTdrdlNtRTVrRUFvdU9RSXRs?=
 =?utf-8?B?dUhUYUg2dFNwZVQ1c1V0ektKMmdDOGJaSThhRDBjbUJnU0FBWVR6SGZKWkNn?=
 =?utf-8?B?N2FiMytoOTl2NHdJemo1eXV3M3NvbUR0UmJNaUdoNlIwMmxHQ3B4R1drUWdo?=
 =?utf-8?B?SGh1WWI2QjJ4TktZaGMxVGtOQnFlRjh0TXl3MnIvRUZDRTNBZEl6VHRtMDA3?=
 =?utf-8?B?Wk00MVRuMXAyUjl2WmcwQjBsZ0tYNTlnNjMxdkdGSDJpK2xBS0JNaUlmK3hj?=
 =?utf-8?B?aXE0Z29kSXlSZk5WZGM1ZmFUTDNoYTViZmtHUUdZd2RWWjBVTzRsTFZLYzVw?=
 =?utf-8?B?UExteFVvQUlHdys4dG16K2lGMjdhblJQTEdLd05Fb2NrNGMwc2dudnN3RXdQ?=
 =?utf-8?B?V3B1bEVocmpCRlYzRm1KT0w3bzRDR0ROUURGcFZGSVYxeVE4Nm9KN09WVkJu?=
 =?utf-8?B?QmE0TGUzSmhqWDBlbEpMaGRyMEg4Q0dFWEdCM0tJMTBFZTZoeGV0MWczbGl6?=
 =?utf-8?B?ckNqNlYzOUJtd3JtVndreW8wWlJDQ2d3UFRqYnpyQXVVbmJYdm5ERy96TjJF?=
 =?utf-8?B?N1RDaTVGckNXdW5Fb3dwSE5QNVI1SmpBanphRzV2UmdqbmxHK2lhejFKSk1M?=
 =?utf-8?B?Z0hzOXA1QlJqTzVjeG8wOEpUWHdyYjhEUS91anpoUDB4R2VobU1iZ0t1bXBu?=
 =?utf-8?B?WjhuM1BjUEJoMFEvZVovOEMzdmkyVG9mTjVEVll0NXRsV1V4bEgxNllOSmRW?=
 =?utf-8?B?TitmYi8wUThCSTBmSWJyTHZ0Tm5XT01qVnlHRFp3aXYvRjRGU25ib1dTRmRV?=
 =?utf-8?B?YlFTd3VGRTZSU205Q0x5M0l4SFR0d0NzR2FVcGpWOTlCenR4Z0xhYksxejBq?=
 =?utf-8?B?VTk3aHlsWUVKZUkyd0hENlNPbFJyMHN5czJIS2dOcms2bktudmZUeDdCL0gv?=
 =?utf-8?B?TWxhNnV3TnBNcFZ3cjVIZEZPUHhrTWpKVndSVHlWM05BcVUyQVFTNGdTbHpT?=
 =?utf-8?B?QjNkcFZqQUFvVmFSVnR2Rjg5VlJldnA4ZFdlaHpLZkNBaWVtUUlLSmNhZ1o0?=
 =?utf-8?B?TmdNNEJ1KzVPU2VjWmJyV2crVDVwSW9sc2tBRmdtV1VYTTFjUzlpNFdpbDdZ?=
 =?utf-8?B?YURQTUp1cEYyZDA4clZXcndTSDh5VnVrQnVMZmFSaTlaYnk4UmZKdG5qalRz?=
 =?utf-8?B?WkJmNndMSndGN3VXU2Z5WS81UkE5anZtZ09ndWwzS2xQSjRTdjk4TXhUNXBs?=
 =?utf-8?B?M0xzaDM2WUc4Mm4rWkZFTlArVWV0Q09uVnNJaXZpbmU5SnM3OXd2UWFyaHo0?=
 =?utf-8?B?U01sR3MzQmViNFdKblBTSkM3SXZET3ViMUJuWEhEakhDNjlFR2NlZUNKSkpV?=
 =?utf-8?B?MmVDT1RoYkIxcXFBNlltaFpwMFRuYjJqYkVYSUQyRE1pR1ZyVHo0NS93Vjd2?=
 =?utf-8?B?RjlaQjRnbnAzVy94cVJFQ05kR3B6dWd6VkZGTC85RkJwTmNMcXUzbGlFMW4x?=
 =?utf-8?B?ZTBoQ0haa3lBWEo3MFRQbmpuaS9NUHZIbmtaMFJMSS95clozVXJwRXZWTUpP?=
 =?utf-8?B?M2NXRXArMEk4RlpYM0M3aXc1anVzMi81UlptVis5dCtmcEFTWUVLM2xhMkd0?=
 =?utf-8?B?ZzJrM2Q1Mk5odk9KTDRvdUhJOW5sL2IvRnRJN1FXeVp0M0NaMkpjV1hEcEdx?=
 =?utf-8?B?clVsYXNkR055NUVsbHJTZFZZaUFEeUsrMldpemhVb2FBeWNNUzZrU3pKeXJK?=
 =?utf-8?B?ZmVSZ0lhN1JWenBYT05JYkJKeEVSL1BrdW11NjRNQk41L1p0SDQ2U25NejIx?=
 =?utf-8?Q?fDWdGOVWz/T8k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnc1Wm8zc0JtMi9kOFJoZDlFZUwrYis5dm9sNjBmS3ZlK3dCMkhLWjRqSE45?=
 =?utf-8?B?ZjFxQ3Q5NFNpeG1FNTNqRjhhOVRqWHEraThvU3J3MGQyQnZEZzV1ZXhaSE5B?=
 =?utf-8?B?TnV6ZWpjaEhlWUhSYVFrMXRjaElTcGJjMWdUaUtyd2J2a2JRRUtnSDAxbUFS?=
 =?utf-8?B?bityTWpGZ2gyU3M2ODNJejYyTngvR3JscmMzVURWQVN2WWVoMWFMbHMvWGxL?=
 =?utf-8?B?cXY0dituRjE1Tmoydy9wMW41SlovaG1EWnFSQnFMYUwrVmM3RUVOSFVGWHYx?=
 =?utf-8?B?SzY4dTN0RmNsdjZOcjZzbGtZVVVzT004UUh2c0t5M0l1TFUvOU1ROVpCK1pP?=
 =?utf-8?B?amJ2S0xNNlNoTnhjK0NzanhYRU1vRDZQc0lMZnpaRzNHTk5Qc1NBeHZVTURE?=
 =?utf-8?B?L0plM2lXTE9kZWx5dldwQy9qeFpuMnJodkZPSVhDdHVuY2xvQ3RRSHdIZGF6?=
 =?utf-8?B?d0xLMHhWNHRicG14L1RzYXc1bkpqaGZOWjVnZGxhQ2VSSFdQOVQrQlhXZGM0?=
 =?utf-8?B?OUYwUXNGWnMyZlRVL1JQSVFweThQUUxabUZEUkkzS2hvdUZCMitoa2NSOEMv?=
 =?utf-8?B?LzBtbTVsUGJSS2MrdXF2WHQ4L240V2FTYVJwZzJBMlBZU1gxOXBQcWUwMnBS?=
 =?utf-8?B?V2tmQy95TmNBOEo4YlJoVkkzcysyNFJmNUg5ejFaUmFsMUU0SlhyTURLTXBF?=
 =?utf-8?B?dzl3SmNhMzd4N1FtR3ZadnNnek9jUW03ZVJmcElHcFlNelk1b2NqY0VBTVM0?=
 =?utf-8?B?VkJBTUlDUDRGSUpQWVFxemZYdnRPNzcvdVBZK3JLRWhiWStpcnl4QTk0Mitq?=
 =?utf-8?B?TmxwckhndFZIMWdCUXhrcDFqWFlwYVk2YmwyR0IxWU9wU2xwaExhY0hzdjRZ?=
 =?utf-8?B?NE1HWDZXcm9nRCtxc1p2YmU3Njc4K1ltU0dlZHRqUEN3eC9idEg0RFVlUVVY?=
 =?utf-8?B?M1FmVFpuNzZGMHIrZWgvbDR5dm5xbTJpcGQvS0FoclI2YW9TNzRhS3FyUzdY?=
 =?utf-8?B?TFJVUUQzRzVVNk1PcmNNOEJyUklXUjlOaWh3eFhpOUVsVUtYUm5YTW1XNHNk?=
 =?utf-8?B?T0hDZ2xsQ0pjeG5KMnJ3Y0o5L1VtekptcmNBQWJZaXpEN1RuSHdiNHMzTlFC?=
 =?utf-8?B?TFZFaGViRDVpOHViNUpoTElYdkl1c25VMldHejVBMjF2eVlBd2tWWWJZSEZT?=
 =?utf-8?B?dXMxZW5WN1FwVWgwbi9BMFBZOFFGRVZBdko5ME5rbGY3MXZRKzN1T3NXbTNW?=
 =?utf-8?B?YmkzaU5icTZoc2dMUW1zSkE3b3JCN1ZDclJRd1JEMXR6WURFN3hrT3R6VlJN?=
 =?utf-8?B?bUlacEFKZzJzUU1tN2o5VlRuY0dNOUhoWUxNdHA4MlFNelZKYWxlTktqRkV2?=
 =?utf-8?B?OHJvRGpSTG5iOEFBaU15N2x2QmpLNEJrUnVrcWM1dytCbDNUZ2JIdGVPTVRD?=
 =?utf-8?B?RTdCNWtYOEViMU12aW5RS0ZDZWJnVkVTeGI1czVyWTJNZElwZlZHenpXSE5E?=
 =?utf-8?B?OHhYRDZSeGpnUVladEJGcExPeEROdFA2bVJULzlENVpmZ3R0M2tPZVhFN3c4?=
 =?utf-8?B?cnpkMVZtYnpNcDRFb3kvcDhRa0tQNFE2RXNHc3JLVXVOUVJzbGViV2JZV1Aw?=
 =?utf-8?B?YjFFSFFxRlJMcWVqOGJrdGhuNW1UTTJTbExQdVczbFFnSVE3ay9OV3VzNjNE?=
 =?utf-8?B?WkNYTitrbklNS0pxaElYS0xBeDJHQUpWbUgxMVQ3Y2JNRnU4aEVQTVNzWTY1?=
 =?utf-8?B?Zk51NVVNbklXdDBQNmtmZXV0ZDZuR3Fmd2g5NEM1UUdKRGN4Skdrb2FTM3dv?=
 =?utf-8?B?bHNzVDdqT0Vva2tINkc4aHJXcjFGWXdaT0pSNU1UWHJzWG9DVW9yV29XOE1G?=
 =?utf-8?B?UlRXNDRITS9DTFJiWlB3Mi9vQWNDUmgxWVlkYTRYS01TQ0N4Zy9DaTlXQTdV?=
 =?utf-8?B?RE5hZGhubG5rYkYvQUhJbkVGMGs5ZjlkZWNXZExLVmNjcGh3WllsYXNmK1d4?=
 =?utf-8?B?amV6MlQ0YlBZMW9kbkFvMHV5VkxPR1ZPR2lFUXZzVmN6bG10MC9yYTB6ZjV0?=
 =?utf-8?B?TjJCZGF1d0V6a1k4OFBjWHdpZ21sVmZ4WUJRZDlRS3I2U2VOT0FNSGtDck8r?=
 =?utf-8?Q?WneSSyuUAR4LlZbF2v0qtSoM0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f719b97-9068-475f-6812-08dd75994474
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 05:58:49.8457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olIlfq+iOnS8FK4+OyVnowJRwgTDd4awDLqNyVxUHuPj3uzW/2EN93B0RvGY4jbW7fLdJQ83OG2z5Km/M3rsPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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

Ping

On 4/2/2025 5:46 PM, Sunil Khatri wrote:
> In mes_userq_resume calls mes_userq_map which set the
> queue_active state to true if it succeed and from the resume
> we dont need to explicitly set the queue state.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 8f6c12a78f3a..c596e534efbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -382,7 +382,6 @@ static int mes_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
>   		return ret;
>   	}
>   
> -	queue->queue_active = true;
>   	return 0;
>   }
>   
