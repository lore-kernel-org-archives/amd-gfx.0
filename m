Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A11E7719F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 04:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF6210E3F5;
	Mon, 13 Jan 2025 04:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQIziGoe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B5710E3F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 04:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpOEtRbId/C5O150rYUzXieGDx6ndfYwBJcUFocHDgGqTP7mqJ+AMvpXZCsUOhJc2N8h+bgZtWhJ0rTRZeDPLPzDOEtlUWLl0DGDV/VGLx5pDpXK5vGxEAf0Utd4Z0pw2AevsFHt3wl8nTwju7ldSAfZ4qXE01iXiCTE8VSuyuajIXW46ZAVGPgDzqDR3gmeGGUEZ2QXC8cGdHcs4pKY+rw6UgzqVMwxlpwEUrwiikCt7LSJcDHDhOAs7+lutjTrnhQcwYUIDevJHg8kIZp+dHW/sZt9Xa4nAdyzWE9ctT6DCXqLPOTI0cbMyvN3zicYDUOmDzVmLcWyLO6UcgKxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/7xQKxFeN0v9ngnXUb3N+P2cJLBc6ecOYLI011JRS4=;
 b=U1h1GJWv2AnlLRCuXDtK54YhTCDQs7PjffNGM1VEsCrD3bpau/DpYF12+Fmb0slepI0Zs+10ivtB2d43E6aZENTDUl6ob1Tk1wdFCWjf5KAiyFbETi9sc84eovWJuIvUMbjPW4FWp++yrb9J0TNdEnbw91exd16opoOftOWnR+XdwFFY+vtZAI+6hV1ImO7+0aN9bjO+1C/QxGb75mDosrhUWYzTiOsrb7L7Gr2gtlFamqrU+Xlf5OFILAUFXCycOX9kCVElIyJ1eqsMsbhL3CuYqSJMCxRQU7LpbSM/j04T5V80B3ZKV0nfsK4h6klJKPWmssHHrBMWHSGzLL1aFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/7xQKxFeN0v9ngnXUb3N+P2cJLBc6ecOYLI011JRS4=;
 b=wQIziGoe6YJqQEM3XvgYaZaOsWl/Eb5MMTJGjLyU9DzSLflt/eHGaZk4g203RoBVLid7M+eiq79+UgKwMveVjZkF2YBQ3qtxFEMN+giunaVlwGxOd1nLT5baW4Z0iFo9ET6mNmWC6YwDmIVp2msSEpLSbQquA//6/s9vv5IwElg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Mon, 13 Jan 2025 04:28:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 04:28:46 +0000
Message-ID: <4fc84a82-7b07-449f-a383-eaa6bfc4f04f@amd.com>
Date: Mon, 13 Jan 2025 09:58:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Fill ip version for SMU v13.0.12
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250111052806.36431-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250111052806.36431-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d9c747-19a6-4c57-4ffd-08dd338ac528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TURWeDk2QXNWZHU3eXFKbkljRGxaZXhmMGIyRmZSYk9yQS8zVFRnQzNJZWFO?=
 =?utf-8?B?SEUxaVU2YjJrWnlvVnd5REFMdTNNeGFyS2pRMkN5MWF6aG45cHF4T2tJWkd4?=
 =?utf-8?B?NS9jUWVMbFZSSlBBZnE1UGdCTHc4aWpENEoveGhoSTNsNlJVNjJscWdCb2kr?=
 =?utf-8?B?dDBlaHdkcThmZGVkNUxxZzM3eVg2ek9nQkNVSHhuL3hmNC92QkorZlc2bDFF?=
 =?utf-8?B?RnhCN2lpT29xQXJ6WSsxTE9hVmVTUlV2UjluZGdwT0ZyUW95UWFRSlk4K0lO?=
 =?utf-8?B?ZS9MN3IxZ1A3TGtxVm5QWk9XYkVNaFFSWEx4dUlmeDYxZzVaNHlwb1h4WlRG?=
 =?utf-8?B?NnFydzF3RHlZQnMvTE0vM2tZN3BkaU5YcUNkZVczc3IrY2R0ZER6Tjhvello?=
 =?utf-8?B?ak5EZmZzUU9YUTRwUU5vUGZXU2V1NHRyd3F6YmFkT2dZODhQSS9DMXNVQkk3?=
 =?utf-8?B?eHhMN3lwaXYrOC9aMk5TclltMzRKVGMwaldsMllTRXNyOElNZzBHUlkxWnNC?=
 =?utf-8?B?STBxOU5uT2NBeitKQVM2Z2ZXb3JockljY1FEUUZ6ZCtJSWR4dWNtUUNHSVls?=
 =?utf-8?B?VWJDVkt6cm1Fck41SjhNdEpaVG5QSCtRNjJQYlBxWU8yc1NYZ01ncU9UenJn?=
 =?utf-8?B?M1EvUnlid0xqdjNOR0MrUTdFQm9VQTM3QmwwRHBSelFRSUtmZjIvbHNpcHdt?=
 =?utf-8?B?V2x6aUY4QWZkTE5IZmZKdzlGY2NiR24vZ1FXUkNpVFpjQ2s4Nis5aE5ad09a?=
 =?utf-8?B?QzRoYjVWcU5OQmRyZVpUUk55MG9ycjBNS2tsWHNzRG5rR0t6NS9reU9lcVpz?=
 =?utf-8?B?UGJpVkdRSjRGZ1ByNzNxMlB6em9nWkkrQ2p6enpBM2ViRThhZTAxUUV1bG1n?=
 =?utf-8?B?QWJzZVFiOWFxL3l3Unh1dWRXMUNsZU0vQll3YldOdkp3cStubTBKeTVxT1Ur?=
 =?utf-8?B?d28zV1EvRzRjb1FJR1llQ0hWcDBIMUVUYnl4bEw3QVgrMmpUUlRtWm1qMFZm?=
 =?utf-8?B?aEFiSVpIWTZzQlpmUGZiUTNlYllDOEE5NncxQkhGcmpzS3hVd0NWQldUS1U5?=
 =?utf-8?B?Qi9FVytCK0taOHdVRHB3MkFwb24vQWNWYm5QaWlvSUUvdWVUeDU2dk5WYkRu?=
 =?utf-8?B?bTIzQlZ6UnNYZ0RyUU5qSWhmR0ZYcnZUUitGKzhRNkZWSHBaeXE5R3hBMkcy?=
 =?utf-8?B?cDRjR3QyQ05yMkZzOEFNZWVnUWRmcGY1RnVIZmI3anhydzA0SHM0ZW1CeVBj?=
 =?utf-8?B?L3ptY3pwU1FxM1J0MGk3MlFjUDZpZWoyWFJpM3AvSkZiaTU0Rk12RTlSeU5W?=
 =?utf-8?B?Snl5aEhJbkQ5aXZMbXhLdmJNTTA1ZkNHUHNVckNvb1NxdWNJUEJBY2FGZjF3?=
 =?utf-8?B?WWtlWlArYjhyR0w4WTJUN0RrenVGb3hDT1NDRGFhc0lxa1ZJS2tiTGhwSHJu?=
 =?utf-8?B?RGk2UUk0bUp6bUNveXhUVnJ2NkdWUkRsMzR0RmxQVEZsR0tqZ2lldjJvc0Ex?=
 =?utf-8?B?OEE0RXlCSU9sV0lZNHlNNk5uNElZYzRIQWQyYXU1UnRvQVFXNml3UkQyUU5Q?=
 =?utf-8?B?aVVoQjEwNnJGVm1qaWwrRGthWUhIcUxpQ200cXgyL3J5ZnMwMENPR0oyR0ha?=
 =?utf-8?B?MkRkQm9kdGowdWVGeVNyeTEvQWxhcmdhdlFCSEJIUzNVOEZ6blhzSXNYbWdB?=
 =?utf-8?B?UUVGQjFITXRLNWRzdGM2TTVxaUNpTnJYT2dZY1hTV21NaGkwcW1hU3AxcXJk?=
 =?utf-8?B?R1dtejVRVG03N2UyMGVKMERkVXJOeDBpUHlSdmNCTW5SaVdNZzhUWEZCRTFJ?=
 =?utf-8?B?QU5HRkRRb0VRWXpybk1oZi9mNlhmMFdRVE1hWERBSnE5cjNnbVZGc2NuODNm?=
 =?utf-8?Q?Bt2rtk4xUqdyQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVozMmk0UXgvblZlT3ZudEkySy92aDZHUVpJRnBTNjA1elpvbEc1SDl6b3FE?=
 =?utf-8?B?ZnpjUm5EVHlqalFXaTJwanNTZUdiQTN5a090UWVzRlBrdlNaN2F2U0tOeWlU?=
 =?utf-8?B?aGp4all3QW5mZFBDNUgrNG84MlFieWJ0eUhrc2FodzZ4WkhOSkYveFRSNk45?=
 =?utf-8?B?M0cwNkdwd0pLS29lRG1HL01DQzhjVHVsb01FNGFkQ1d5bmhXK0E1cUExVUMz?=
 =?utf-8?B?Y0hwd21vRHBKdyt6Y0FyRjhoR3BTKy9xTWcxU3J5bTl0a0UxQkU5S0F3UkRZ?=
 =?utf-8?B?VnNWSVRIQ1hLNGxPY2FST1ZlVGlTRTNDSnFOOTdwc0RNbXM3ZFpOVlRSMjlJ?=
 =?utf-8?B?OHpNYW1CZm5YQk84T1NwckttNlVSdGcwTk0xcFowOG5ya003ZkFaeFVqZkVm?=
 =?utf-8?B?OGhUWDNPS0dkYlo2Nk5qWWtoNFpkNHJyTW01SEZDSWxLOVlYd2pQVzNrSEhv?=
 =?utf-8?B?WWZWZkpBUEdmU3JjZktHUGR1dE5iUkNqaEFsaUdoZGFzSllDVktST2c2WDUr?=
 =?utf-8?B?K2ZpbUt2Y01pK1hsdTZaRTJkUTZjV0lkcVRVaGJmeWRRdzBBVm5RVWtSOXk4?=
 =?utf-8?B?Rzd3eEF6TTdiYUUwU0l5Q3BpRVNJcVRrNWNDR3MxY0lseE01bFAyQkxlZlZ6?=
 =?utf-8?B?WDdRTHAzK25hVTJ2NmljKzJ6OTNCMEJxN1NiL2lwemRRWWlYaG9zYnFsUWxN?=
 =?utf-8?B?a0VrZWE4QXFBdjRqdmJYdEs1Skc0Mmh3M25VdzR5MFZhTlFGVVFoSllKbjgv?=
 =?utf-8?B?UEwyZm5oUk91RVZZeExvNERDdGtib2JyaHFlTDJ2eUZCdytjM3BHWDFaWEFE?=
 =?utf-8?B?YU5LMGR3dkJnZlYzWm5ZNVROUE0yRkZzQTQrd09IZ3BaYXgvSkh2N3F4bFBj?=
 =?utf-8?B?ZHBhQ1dpcmhBT0lDZFdWa2ZackdaNmxBeWFmNmNvZm1Qb0ZYSXVqdWdOZVh3?=
 =?utf-8?B?S1d5dmo2bzA2dzl3cDFYbUJDb09lSzVUVEsyMVBLVFRnWlFuVlA1ZURFS1Ni?=
 =?utf-8?B?WXBMSmc3ZTQ5aU5MbENWVE1wbzNkK0l6a0oyWnhERHFVSTlhbkRhNkUyWUwx?=
 =?utf-8?B?N3psKzlKSk1YcVNtMTZxaGNmbE1SRDRSNkNIbnNzVlhXWXpNdHZQditOOFNp?=
 =?utf-8?B?emRWb2t2MTJUTExWcllLQ0pvK3VoQllHc1lQS1ZVbzkwdEEyNzRNZWN2dWcy?=
 =?utf-8?B?RGV0OHdJVjRoaDZ6enRLbUUzZysxSk01bmplQkpoUVByQ0ZUTFFlNzVQRElQ?=
 =?utf-8?B?V0VsVFhkTTVmM0czUkluaktFaUV5YjI0dDdaRkNGa0ttaEswbFhUbW1iZGtP?=
 =?utf-8?B?eUNhZG5oWGpJYVpBTzIrV1ZiU0EvUGdpNHZQRXJNcDM2SE5EcXM4ZmRkZjBL?=
 =?utf-8?B?STM2d3NIZTJzUFVVNFQ3Q3R5OVR4YXNZNlFkQnpnREFMVTlPczhaNmh3aWR0?=
 =?utf-8?B?Wk5PT25zWDBFMmtHTzJkdEZpTUlyRXZLK3lKUS9wVW1sWS9NMm5pVzZuczFX?=
 =?utf-8?B?QndsL3pDOS9HcFhKWjhVSTQ1SEE5czgwNmRaZ2VVODBkMkFXdXpTS0dYMlR1?=
 =?utf-8?B?VjFXN1VRZStUdk1jWTJSNnlXMUE2UG5tK2YzREIxa0hkK1pFWWI3bWhrUG5P?=
 =?utf-8?B?VnNHZjFKdkFrZ1FPZUQwUXNVZlg0ckxEMUhuSkhoc25sYjkyUU5xWi94enl0?=
 =?utf-8?B?WlFaUVNFaW1NRzR0QkZTNjdObjhVOE45SGtGa0E3KzNuYWpoSTJIU2t1cG1D?=
 =?utf-8?B?VHJ1WlhveGZQUkNOOTFsYXlYWWdtTVZHTy85TWlpbk5hOU5PeEdKMGNCRmEw?=
 =?utf-8?B?Zyt5WFBzVENGMU00UnFjOW9mc0d1aHo5a0V0N0ExTUgra09UbFpUN01VMzgy?=
 =?utf-8?B?cFRhNHpURWdoczVsM0pwZ2M3cFo1a3pCTWJlN3J2TndvZnhzS2RxZWxqQ21B?=
 =?utf-8?B?Y2tpbTZ1eGlES2loT3o1YUY0RjA2QlEveGRMK1daV1hIVUJNK3hEcmtSRFlw?=
 =?utf-8?B?cWtDZG1kNVo3Q1grWTM2ekhGWGF1anZqUXU5c2RqQTJOZEZjVHB3NFlVR1NP?=
 =?utf-8?B?MFVBOG9LK1Jucmd4NkdLNUpBSnBlMnFlYUJlRzBNc0R3dkJ0N3AyQnhadUZx?=
 =?utf-8?Q?xwEydKg4r5VVXwb1et9cUF4Mv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d9c747-19a6-4c57-4ffd-08dd338ac528
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 04:28:46.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xwvXkRlvpWJZnk6mAb6mGEQCXJcHU0eDq2T+f9PA1CazIOQ41Z8a/1am2sUy+Og
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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



On 1/11/2025 10:58 AM, Asad Kamal wrote:
> Fill ip version in pm_metrics for SMU v13.0.12
> 
> v2: Remove ip version check(Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8ab30b2f7119..f358a8abe91e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -599,10 +599,8 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
>  
>  	memset(&pm_metrics->common_header, 0,
>  	       sizeof(pm_metrics->common_header));
> -	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6))
> -		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 6);
> -	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
> -		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 14);
> +	pm_metrics->common_header.mp1_ip_discovery_version =
> +		amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
>  	pm_metrics->common_header.pmfw_version = pmfw_version;
>  	pm_metrics->common_header.pmmetrics_version = table_version;
>  	pm_metrics->common_header.structure_size =

