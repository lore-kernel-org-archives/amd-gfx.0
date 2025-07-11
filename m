Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0CC8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5994C10EA2C;
	Fri, 11 Jul 2025 12:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iG9zDc7w";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B96610EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAbfcX1zovnBqq4k844fsSQtFRPRu+rwhF2qqRKSmCP2C3lCKlos2Z603Vu+ZvD4Me7yFEAnAv5hIo6vLZZ6NIgj61YTWW96Tnzaf4tEIek4zVyU5T2pTYdIQNasZDeE3FIKzM7di1vYu/O2M9KyaY8lbp9LgSeMnWE6iI9FWWj+MhRu008kOy10vGkkhUNWyff8UkFLYoEnSeY28ZRAHg0lzQaylEH2i8ANcockzk0L/h8LMMShIKzoDnBsTO/RDoGUmPGxwqiTddXk6Ytd0a//yArfUYJ+aaZJYOF5nnwk22+J6GozIKPp3S2Tn5yQYPE0LbM/BHMsOpdGumcW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koaAbtMm+fc/gsUehPaNtMEqDoz92UOwD/NoJo98v7A=;
 b=isitB1JU552KFn6hV82kmpocm5slF5F09x3dQ0wupwq1GoNhm8tVmfPIng9b874ygNAf9kVfD6bxq5E2gsBfBwhyBEjEmeCsiN2loD3dxq14YpgH5I2+bXUDEY5d37SWYzfKfFejRbs/0ebsMwA62z8SddVkGPcAzOol6g7dU70TLKgaMfau6cNn7A6Y/XtHLRsx4ANlvFCU8i8jS68Jrb2kIHP3bRnxVKn8NQ3oByn8RaLp79Kg4DvQB/KNIPSZU4kFqyYT7uEYUT2N57SsJnmX2ksGgllcIt9O81rjhpzKRzcwUMEIoB3O5zmwHm3fPsMLQ5zhewc6OaZDHgScVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koaAbtMm+fc/gsUehPaNtMEqDoz92UOwD/NoJo98v7A=;
 b=iG9zDc7wMi2uZtzzjjrAlHyO7CgSf0EltNxDUiuWndhTU4O6l8f+sgdwNoAI82nA4qUUZBXiGLHGmRRzHG/2GSSpKGOY6wONTNfHk6xTTwZBhH82RBbkOfpdT75hBMjYFFdSIMvp4CLeK0SR3BAq5MOIYthPKfJEpqXaWdjMtmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 11 Jul
 2025 12:08:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 12:08:20 +0000
Message-ID: <2f056c77-8c26-4bf3-aa89-2965c7896139@amd.com>
Date: Fri, 11 Jul 2025 14:08:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-4-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711093930.1411470-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ee5ac3-e077-40bc-f0f2-08ddc073a03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tjc0dnNFOEU5TXd0UGwwbEVmNW9FZERYOFFTbE5DWlp6cWxidDVMck9EV2RD?=
 =?utf-8?B?c2JYMkhHbm5oNThRcHd3WVRDNFhZUEZ5SnNmQjVUby80dkFNakcrZXFPd0NU?=
 =?utf-8?B?QVFBNE1SVnk5YWt3dG5CdWtOVzlkNXNvV2ZRejFEeFltbyszaWxMQk5RQVl6?=
 =?utf-8?B?a05TZUZMUVhPRnVsdE5YeUY4bHd6TEQwM29TSjgzZFV1MFY3TkZrTHpFbFIx?=
 =?utf-8?B?Q0kwam91dUIrMXVIeFl4TkpaeklTRGdiUUpmbnRFbXhWcGZLbldmTTA3MVFw?=
 =?utf-8?B?Qis2NTg1NlV1M3lkOGtGb24zMVhhMmRQdDJXblVvbjBaVlFMYjkyRWxvY3VN?=
 =?utf-8?B?YVdwTHB3ZkpJdG1acWNCUUE0R2FKbzZnUnVwUzhsUC9xZjZwdUpWandqSkFQ?=
 =?utf-8?B?a1J0bTlPYXF3MnZDLzB0QlB1aURERXE2Nk9xUGpJeGFnWmM2bXZCUFNjbkht?=
 =?utf-8?B?cHJ4RVBUdUtZcmFYVXBFL2pUTGRGUFljQW0yRnJKTDVUb0lUWnNNaklGS01J?=
 =?utf-8?B?TzI2S0RQTzJiWDIyTEVEeno3YURGbndPaGpIRkNybDJPYlNkdlZhVjJHemhL?=
 =?utf-8?B?S3oweXhua2poUkFkNXM2QUg5QkMyZ2pIWkpEdGJQcFlrWisxOFc1aUV4UC9r?=
 =?utf-8?B?T0oxcDBGbkk3TEpxcHlpVk56b21BM2JYTDc5SFBDTTZkZTFrK2l2QklTM3JQ?=
 =?utf-8?B?a1psQVNNbGtaMm1Yakl1dGxYNHh3ckdPbEc3b2JEamVYanhVRlVha1JZcWhB?=
 =?utf-8?B?T2hEcnNMdmVxcW5NZEsyUmlGa2U5TXBmZlZVdmNhQjVmTmsybTNKTzZDVVhs?=
 =?utf-8?B?bUNwRW5lZURPaHlUZkVhekIvZkY2Zmk5NnBtK0w4MjduSEtXeFlwWkQvbjJ4?=
 =?utf-8?B?Q00rSVFzaC92aGtYUGM0dmRsajZYaEdsMit5YXg4OUtLUE05SlU0T0hYUjcy?=
 =?utf-8?B?NjBYVEFFM0twaWtKYVZhd3NCaStFZUxhM05weVhoOHUvaVdYN09WZGU3VEhu?=
 =?utf-8?B?KzJFN0RnNTN0cXpJc2d3aDQydktvK0lhSG5laHdsZHQrSlhsQVU5bDdSc0d4?=
 =?utf-8?B?SWNjMEo5ZHFvUlBaSHRiVHJKTzlGT1pLbk9lNW4xMEJNVWZyR1VySTNvSHVZ?=
 =?utf-8?B?ZmZkYUZHNEJ6dkxtbDFpYmNEN0d0NWt0WVVSTUdjYlR5UVIxVjYydjVucjZ5?=
 =?utf-8?B?Z0JoQjFmNkxYakorQVZEY01JOTZKR2Rub0lLeDZZNE1Yd1ZDc0IrYyszc0cv?=
 =?utf-8?B?Umg2OHVOTFV3aGRGZk5NSGYvZUJURGRwa3NQSVRIdEJPZEhHVlFVRlZ4K25F?=
 =?utf-8?B?ZTdBc3V3cDV5REUvNUJ6STdGUkd1ZmswSWJQK2lWZEorcDBOcHZTNEdZay9R?=
 =?utf-8?B?ZWhjSmxUU3kreHJpQ0ozQmRUTWFmYkFxWUtFNkhrRU50eEl4M1kreTB0UnQ0?=
 =?utf-8?B?eTYydzBXQUZGdTB1cEQzWUdCZDczY0pZaENxRHhyYTZ0aDh5bkpPeWhIYTAz?=
 =?utf-8?B?Tkgwbjg3Y1FPNEtlN2RFMU80azVtc0lGd3lrRUlzQmJMdWg1K0c3TmV3RHBF?=
 =?utf-8?B?dlpzeFNZTWpWWDJzTitFWGFSdElCQS9BbndwdnIwWDNrR1RMeDBNL3krU0Ni?=
 =?utf-8?B?NGk4VXVkdVNWSFF1MFFObEJOK1pETmJuazJGZlQwcElCZkwzMDVrUnY0N2JS?=
 =?utf-8?B?cHkyT3JEcjgwdy9rNlpLQ2xHTWUzU3dsZVZuLzBiejF4KzdQVHZud2psR1dv?=
 =?utf-8?B?YytJckZxdTk2K1JTMW5OMWZTTi91aHVwUmV0L1hZVDVySS91Rk1uQXJmd3Ez?=
 =?utf-8?B?V2pTRmY4Ykptb1lqTnpQZ3NIUGJtRHo5ejlKS0ZaTHBYZlRIV2FpamhSM00w?=
 =?utf-8?B?YytNUkcxQytVdTY3M1BKTno2SFJWUFFUdGl4dFhubTZ5S29hL0oxNTBiTHJr?=
 =?utf-8?Q?eq2gn8jHpBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2RYMmxXNldwUUNWOHNvRThnejdlT3pLdG94MTNsTlpLSmhmcC9renM2QUMx?=
 =?utf-8?B?bXVLYlk5S2tpNHVjeHFIRmhIR09pSE5Pb1V6YmVJS2RXOTdOYS9yR2RHYkI0?=
 =?utf-8?B?QTlRWTNtVS9PRG5vbHNYUkpzYVlxQ1Jvb3NJSld0U1pHRURCWkd1UU9Oa0Vt?=
 =?utf-8?B?eXpyaUVGcjRmRjArUkpuSDdXMDVieVdCN0Z5S0xJZXNDTFk3UzRFZ01BODlW?=
 =?utf-8?B?YmhwSWZiODlUb0RZYUhaTzV2MnRFYXlRREJkLzR1WjMzVVBRcHo1WUt4YlJM?=
 =?utf-8?B?UFdRTHNna05hY2JFeVI2YlMvWlJYRU04TWxzdW9sdmw3L0VkZkgwNDZaNzlx?=
 =?utf-8?B?VEhHUW10OWZ0dWliNzZvRTY0K1lHMHR3UXNRNUcrWTRkNWJRaGF2RGdWblU3?=
 =?utf-8?B?NXh2TzRWZHFKN1hnQXJSamRzSnFFN0FNWnRCRCtIMzdPbUtGdlF0NHNVKzdE?=
 =?utf-8?B?Y3hSZy85bEZtU1BCbEN2N1AyR094cjlRVm9DT1duSGtnY2djditwSnFoMkdq?=
 =?utf-8?B?aW1WaWdSTDhiWERJYmw3aTc1MzFnd2hZeWxCMGJJQS9CUmFieEUvMVl5NzVR?=
 =?utf-8?B?ZHJRTFd2eFl1OFRPOFd0NmQ1YXIzSzB5OE9IOTFzQWtwNHp0YUt3U25HMEN1?=
 =?utf-8?B?ZUVlandqSktCVy9SckxyWFRqdnZDYWcyVGJJSTA1VFdMYmtDMXpBa01saFhX?=
 =?utf-8?B?R3hnODZjbDd3SkliRGprbmhZaE5ZcUdUSGQ4OTNVVm5GcjVDdEpac1FtL2FY?=
 =?utf-8?B?SjFKb0IrMzFWOTB4TXMzSFN1WWxmaERlZmlXb0t5VUpIc01QVENUWU1tZ0dY?=
 =?utf-8?B?MEdsSlBVWjE2YTU3alFCaTBsTCtKNkZnZE1valg5K2xuQm9VZzZHY21JdHZI?=
 =?utf-8?B?Z3JKeEFDUERCZ0t6czhvcEQwSTlrWklaYWcvMXJGd3RnQkM2U0RLVlNlUGxK?=
 =?utf-8?B?bGtSQnZjcFhLN1ZpRmk3akNZbnhicHFjemRKcmNwOTBlRml2SzBydjE2cVZa?=
 =?utf-8?B?aHdOUVhxSStrTFFFekkwd05MZ0RGT3BISUlhajhwK3ViWWdRUFVUWmhpWkgy?=
 =?utf-8?B?bjk1dkhUbnN1TmhtZG9pMmR6UnZBaHV3TFVoL0VCOTNRdnNsY1IraWkvTU40?=
 =?utf-8?B?NzdNaGl1UUVuQU04WDBVeFErVUFkNklDbW5WUktFQUVxalVvWis5c1g0TUVU?=
 =?utf-8?B?TlQ0K3ZQell6SDFYVjExNElVd0VOOE5uNjB0SEpFR1M4UVZmUjErUWlnTGFa?=
 =?utf-8?B?cGlReGRyd3NuL2preUtrM1Z1WVNNUlYrTEFCalppN1lBeEoxSTRON0ZCV0hP?=
 =?utf-8?B?ck1iNmZBdEZyNFFGUVRScWtSdSs5Q2lSNjNET3lvcHoxc3ArN2tTSlJPbWlx?=
 =?utf-8?B?a0VIY0UvQ2JneUhya1FMQUhwanZOMFY0K1ViNXhFVHZVQWpFRkdOSTNHcVVI?=
 =?utf-8?B?Smx3UG10NGloOWZlRXM2djhZbFV1ZzVRRitGZWwzUmJDS21YL2E5RldwUjJL?=
 =?utf-8?B?bWxBY3l2bXpJNXZ4bEJ2MFQ5Nmhhbm1odVNhajA3WUlGWjJlM2xNRlo1N3JE?=
 =?utf-8?B?TThWSzhNb3Y4YzBYQ3RuTUN1Mzl4bDFUVTNJNXVKRWNLWGd0LzBuTVJxZVl0?=
 =?utf-8?B?NFFodFFFSnA2WURiN3VCMmdCMkhjNjRUZWlHWlFVcW9JNDNvU1FRTXI4Q2dZ?=
 =?utf-8?B?MVUydUtFUktzbnRqK1QrNUFSa0pKcUxvUDI2cHUveDhkNXQrK3g2WUVncGtX?=
 =?utf-8?B?WUYwUG9aSUZoZ0N5N25QVVhRdlVNWVRPSHNMUGhHRTBqdW9zU2IrRm9QeHFp?=
 =?utf-8?B?SXRpdjJQQTFPVnJkRXpiRHlUWk1qZDhTQVMvL21FeE56aDNSOHl6UTZjQUhV?=
 =?utf-8?B?R2gybTRqSlk2bFRBdU1Fc09xU2MvbWlQV2plSHNIa0YvS3pHT2pvSG91Q2tX?=
 =?utf-8?B?emRZazZJZlJQcFE2Vy9Kc0ptTCt6KzdORm5KVWVqS2ZIN2tSSG9mSW8rN1M1?=
 =?utf-8?B?Mnp3RjNleDdWaGZ6K2RUcGR1cmlNb25OaW9pVlplNFNaUzdyRTJPSWdKdXVO?=
 =?utf-8?B?UjVicFRkRGowZlpOb1BTcnhJU1JJVzk2Z0tjaGV2MWszK0MwcnU3TmxpL0Zy?=
 =?utf-8?Q?O9ARsQGzFLjwux8309kJFz7d4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ee5ac3-e077-40bc-f0f2-08ddc073a03e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:08:20.0250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5L1rdEHepRdR3HOOssU7nY+EyZzi2BPTqCyd1Ytbx8NVJm6Y/TBGgJKk1+v9yxEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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



On 11.07.25 11:39, Prike Liang wrote:
> It needs to validate the userq object virtual address to
> determin whether it is residented in a valid vm mapping.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 38 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 ++++++++++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 15e833b1b3e3..a41dd38b0adb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,6 +44,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  	return userq_ip_mask;
>  }
>  
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +				u64 expected_size)
> +{
> +	struct amdgpu_bo_va_mapping *va_map;
> +	u64 user_addr;
> +	u64 size;
> +	int r;
> +
> +	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
> +	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;
> +
> +	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!va_map)
> +		goto out_err;
> +	/* Only validate the userq whether resident in the VM mapping range */
> +	if (user_addr >= va_map->start &&

This check is unecessary.

> +	    (size != 0 && user_addr + size - 1 <= va_map->last)) {

The size != 0 check is unecessary as well and you need to be careful with wrap arounds.

Better write this like that (va_map->last - user_addr + 1 >= size) 

> +		amdgpu_bo_unreserve(vm->root.bo);
> +		return 0;
> +	}
> +
> +out_err:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -386,6 +416,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = -EINVAL;
>  		goto unlock;
>  	}
> +	/* Validate the userq virtual address.*/
> +	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
> +	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
> +	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
> +		drm_file_err(uq_mgr->file, "Usermode queue input virt address is invalid\n");

No error message on invalid userspace parameters please.

Apart from those comments looks like the right thing to do to me.

Regards,
Christian.

> +		r = -EINVAL;
> +		goto unlock;
> +	}
>  
>  	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>  	if (!queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..704935ca0c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
>  
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +			u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 15aa1ca67a11..75b9a6294b53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
>  	struct drm_amdgpu_userq_in *mqd_user = args_in;
>  	struct amdgpu_mqd_prop *userq_props;
> +	struct amdgpu_gfx_shadow_info shadow_info;
>  	int r;
>  
>  	/* Structure to initialize MQD for userqueue using generic MQD init function */
> @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  	userq_props->doorbell_index = queue->doorbell_index;
>  	userq_props->fence_address = queue->fence_drv->gpu_addr;
>  
> +	if (adev->gfx.funcs->get_gfx_shadow_info)
> +		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
>  	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>  		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>  
> @@ -247,6 +250,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  			goto free_mqd;
>  		}
>  
> +		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
> +					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
> +			drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
> +			r = -EINVAL;
> +			goto free_mqd;
> +		}
> +
>  		userq_props->eop_gpu_addr = compute_mqd->eop_va;
>  		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
>  		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> @@ -274,6 +284,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  		userq_props->csa_addr = mqd_gfx_v11->csa_va;
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
> +					shadow_info.shadow_size)) {
> +			drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
> +			r = -EINVAL;
> +			goto free_mqd;
> +		}
> +
>  		kfree(mqd_gfx_v11);
>  	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>  		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -291,6 +309,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>  			goto free_mqd;
>  		}
>  
> +		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
> +					shadow_info.csa_size)) {
> +			drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
> +			r = -EINVAL;
> +			goto free_mqd;
> +		}
> +
>  		userq_props->csa_addr = mqd_sdma_v11->csa_va;
>  		kfree(mqd_sdma_v11);
>  	}

