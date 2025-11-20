Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D82CF649E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 00:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F39510E6C1;
	Thu, 20 Nov 2025 00:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlHFJh+s";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C5A10E6C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 00:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX864VvBvQRkyDGz7l5Pefp9sdrolIpPZqzq9jWpK98bSflTQ1qayZxnBOApchYBa4Yyej5qPCMepD0h/JqCkli7Ip5VF6dnS4rx4uBQm55vA6ANOd4c8wqBW4NXBvCFleDeNiP9+W7CnjJNEKy85yV/Cwhd+ihG4RxuXqy47OtPrdxwI4uj8ot9XuFL3fAGPi0WFVkF4uK2kpXKOc7P8y2x68/LAwZMImC79xLTek3Weob1033QqRi4MIYW6K7VXYdVQC+gpXepgTnYBGluuw/uU09iRHLRz5csPrtlmdJ64fFY64WSq59TcMgi+RtjhHRV2B/NT04ifrFdi7j6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Prh4WS0L/VIxCOntN3112th5/GzxPDhumnI1k7aAw=;
 b=EpSrHSStOKiP+C2XjGsPfo6K8RXGFcC9bUaXq6OOEqfEHr3QE/d+y3xDpRyGzFtoygcbir8TBh6FlXJ7oqsozWs0xXA0SqxL2y/EC/NPGFh3ePcf3i6Mxhc+D2sopA15eHEzXDcu6zfkBpILXRYVGVVPlhV47gsdF7bHkMMxk9QlBe9imjGoMGEP5RU/k3Z0bdm8fP0vQ0GI7blSQ745YsN4Ni7jeWY7MIBrYajVyuiPs643sEMm3BNumtvuTl3tvWDI5Jyc8zee1ngK6rryrgjECMxKrEP2Mx1L5Hk6hTq8OsyAJxJXr27t0Nw/zjPVp5mcr6hqYc6cC3e1O5hX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Prh4WS0L/VIxCOntN3112th5/GzxPDhumnI1k7aAw=;
 b=UlHFJh+sqhn2/Uq+bMp7Z4UZDMlDdLzQtAluY/6cyqKzTZZOyMMr3ur7vUVo6kE1JFPVQ+M7/LBhaqnC5hx9SlEMmmMMXQ0ukEyJNbeVVl7q02/QdGNQth2sOUmPq2r4AJZ7/zaNNECzve1KUXUvJgaLW8wt5dZXPTcRThs7wek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:22:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9320.013; Thu, 20 Nov 2025
 00:22:46 +0000
Message-ID: <e2801bd9-3a63-4c94-9e4c-ef64b2fcb67b@amd.com>
Date: Wed, 19 Nov 2025 19:22:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Use huge page size to check split svm
 range alignment
From: Philip Yang <yangp@amd.com>
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251118173228.1873433-1-xiaogang.chen@amd.com>
 <8382d7f5-4743-416d-87d8-8b892dff4976@amd.com>
Content-Language: en-US
In-Reply-To: <8382d7f5-4743-416d-87d8-8b892dff4976@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2dbe85-83b7-4d14-875b-08de27caeddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0pWWDR2NFk4K2pQN2FMSWN4TG9mWUxtZklkOWZwc21zTHIySjB6UVlvT3BG?=
 =?utf-8?B?WElKV1FJQ21LZGNidmNBdkdOS0VvTDl0ZGRWTzVRMC9Pcm9UNGtja2JxUkg1?=
 =?utf-8?B?WDZ5cjF6SGdtSVpBV05yc2JFcm40bVhNZWZuOUJKa3FMbEluWVRMb1Rrdzgr?=
 =?utf-8?B?Y3F4SjJTVzVZL3M3Q1doRWtoWGY5UmxiQ1lkMDhhWnRsU0J0cWU5VVNzL29X?=
 =?utf-8?B?V0plR0QxWGRIODQ0eU5EdkI5N2JxdXNTNkhwYnVjbWZUQTFGZXNrRmp1dzkx?=
 =?utf-8?B?M3prU2tmdGQ4RGNBV216OC9hdDkwdTVuZUJEcUlsU3pHdU5ieGorU0gwWmhW?=
 =?utf-8?B?M1g1TGJnbVlUTWtGTkIvc2lPOU1OUngwMkNrTzJXV1Y5c3hEbXdEZ3doSmpp?=
 =?utf-8?B?RjEwVTE3SDQyL0dNOGVMOW5lN0pCaFR2b2RyU1BzeFcrSUIwdzN5MEtMaUxK?=
 =?utf-8?B?YW44R3RzY0w4ZEtHNTFtdFVQaGNUeVBBRlY3dVVXZnVTREliUHorZndURzgv?=
 =?utf-8?B?dThDcFhlVkVJYWxCN0dpUlo3RGNMY1RWdFRSWHZqcUNtZS92V3BLZzFrUEFr?=
 =?utf-8?B?RmNwNyt0R0VTdjVrNzZZR1BRd1Q0b3B5TEZqS0lFdThBcWNIbVhxRG9LMi9T?=
 =?utf-8?B?WHNzNmhqY2JFV2FzZE5FTnJhd3J4cEJNcFJkREhZR1JyeGJqTGlwVXkrZzBn?=
 =?utf-8?B?MWlpS0dsZ01pOWR0NTZzSUNTYXB6Y1ZybE5XSVh6d1JUVFpsVmhHcDROSU9E?=
 =?utf-8?B?cm5ua0tNUWljRzEvRWIwcUE4ZFh5SXdwQXZBeDJiNDNiUVFaTVEwRFdyWXN6?=
 =?utf-8?B?WDhBWUZHbWVRTjNNelJvVmpsSmZneURUWkJWei9wczR4TnVrV2dFR3RGSk5Z?=
 =?utf-8?B?UTlNZVU3RzVaRFljVFRZZ0JhaEdEem5YSmJ0VE54QWlnTDhtNkVqQUFEempx?=
 =?utf-8?B?V01jSGt3aDVEcTg1d0F2UTJESGVpYmNLdzdORythTWR0YTRINW92UlNBYUFh?=
 =?utf-8?B?VUNueS84V1FDVGRsbjJzUzdjL3lHMDYzZ0JyQ3ZEWUl6MlFPT0w1ZU0wZ0U5?=
 =?utf-8?B?VDBoOHJLSUx6L1VPNXUrWjNSeERhZWZUWFhvNXZxUEdmclFobkFScGVLejRq?=
 =?utf-8?B?Ulo5SXJQWGdZdU9jc2ZFeHJiV0dHY1UxcG93ZDNQTXlpZkNPOHM3NHY5ZVMy?=
 =?utf-8?B?VmRKMmJidUJ2Q0lXUHhTRU1hODVadU1ERDZISEM4OTBPMUhBclJWZU1TSlZz?=
 =?utf-8?B?UWsxc0pQemdNalJpc1R4bDFjSVJjYjdvbm84QU1EeXliS2pYV3doN0FNcG1O?=
 =?utf-8?B?LzY3SlRnSUlrLzg3aTUvck5WdGVWLzlSbitVOTJuUVV3YllxL2wzSVpXTVBp?=
 =?utf-8?B?bUFZSFRqdHdwWFhkOHdjOGhkOXAvUmVRR3BiMXFHNGJGWjRCQ1ViRlZwUi9z?=
 =?utf-8?B?RlFzNWZlT2doWHVEWlpGdWZnZlkxeTBEWjJjSWlPNzVFSld4Wk9rV0VnQVpL?=
 =?utf-8?B?ekpjK2ZNK21HajBnamlEMnVyRkpSWlZXMlpMMkpGSXJBeGVuMU9hQVZRQ1J5?=
 =?utf-8?B?V3FzU2g2VE5IR05PZ3pKMnZkUmMzdzY4Y1Q2eDlMU2l5clFzaUlrQVpVZFNt?=
 =?utf-8?B?UjFmb3FKU0s0ck4vSGtmZzl3UjR5cmpUbjVVeWIzZDJZekt5dTdyVjN5WlFz?=
 =?utf-8?B?U1Z5MEpYSWRPUmZkU05MRVo1UHo0MjY3K1ZLWWxOOGhqOHFncnV1bkIvRDJN?=
 =?utf-8?B?WXBzMGN2TnJtbGpOd1EvcmR4TmxvbzJxbDhUcm5KQUd6cXNubE9qeDVKV0Zt?=
 =?utf-8?B?RWEybVdVUHZGRlUzbXM4NGNkWUNDV0NjNVJNcFFQeGVXSGlpMDZaVlBJR0M3?=
 =?utf-8?B?dG50emMzWU5XTVYwaytxTXZRVlJZZVczNW1SM3BTMHNyWlhoNnRPNzZMV05D?=
 =?utf-8?Q?eJpiqyX2hptZAsb8fJXKCu1llmbJqTGW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9pQ2FFdUxQTXg3S3BWZGNBNGVLdnZ4VHZxM29SNWNGUWVwMXBncEppVVQ3?=
 =?utf-8?B?SGRXUE9TdzZYQ0JzNlVpbElWTmZyZXlWMS9DSThrSXJPR0Y5a01zVE1aOGlm?=
 =?utf-8?B?dWc5YjB2Mmg3ZjV4azNSSytnTUgweG4rd0phZ3JzWjBRZWN4VVNLQnVvcnFm?=
 =?utf-8?B?NWlSSTBsMjdGODlSL3R0eXg2Z1JNdEhvMFo0TnZ4eC9GL2ZxcTUwUFB5d2Nz?=
 =?utf-8?B?V2h4dU0xc3dVRy96RSttQ0pOdG15SGQ2RkZ5a1hZMDFrMlZSVlVtT1RzTFVV?=
 =?utf-8?B?azZXa0dVVzgwTW5EMVRMVGtCeDl0eVZIZS9QS3VNcDZja1NWK2pBTitoNEtQ?=
 =?utf-8?B?Ui8xbTR5K2lkVE5WNXpuQXRzckVSSHV3Q0tKWVg4bmFZRlVXakEvSmpLZXhm?=
 =?utf-8?B?S1h1QnJNK2J6NHZ3WmR5ck5XWWlQNWhtNjZNd21xTFk3cUEzZlJzQnpHQ291?=
 =?utf-8?B?ZmhXU1pMQThENnVUSUM5MUNZNS8xenVSMlg5Sm56QitCZjNEMVNLYlYwNkFS?=
 =?utf-8?B?UjZMVmI1STg3NlB5ZzE5NTh3Y21MbWI5cTVha1V5VE50b09zbi85YzVyWGdQ?=
 =?utf-8?B?NUxqaFFmMWQzd0J0Q2tETXBrdDBHMHEwaFZMZ0pDdG1PUitlYUZuN3JFQTN5?=
 =?utf-8?B?N3VZQ2pRTGorU1FvRXFnZWNXS25PQTAySjF4dlFya1NFZGZ3bzZJcjNPRFB5?=
 =?utf-8?B?cXVaMVJ0RVdRQjNNY3ZTSWNMeW1XV3NxZXNUZnEwbXlDOVFjdGVqVlRwQUtZ?=
 =?utf-8?B?YVlKN1pCbmZ6SjBQV3BYUjcrYTBqRnNaUmVhUFJxeGJOMzROdjRJdE9xQTd5?=
 =?utf-8?B?ZllJdFJYeFppOVpyNHNIb1FkRWYxSWlJdS9NbzFwMjBiZ0xVaG5sVUtPWXgv?=
 =?utf-8?B?bDBPdk40OFBoc1lIUEVXMDFianA5dWJGOW1zR09pNGFRYkR4cDRUNWdkeGJX?=
 =?utf-8?B?QUZ0RGRKYkJsdks5MVdhaXBSeVVPVHlHRy9BbTduZ2F3cUhNOUVEN2ZCeXpu?=
 =?utf-8?B?S2lUeGZHWTk1L1dncDVBYzFyaWFDZUJMMklLcmFBWDdaNEdvWG5kaFRSOGl3?=
 =?utf-8?B?WGg2QWU3aTI1bmZFTmVPUnNJaGFBckNtSDQ4QmlxM1lFNEZ4bldVdVFpS3Y4?=
 =?utf-8?B?SXI0UFpVTi9FaWs3WTdLTEVpTkRkVHRqd1Z4S0pZU1lhZlFrZjlhYWVJYzQ2?=
 =?utf-8?B?dGQ3bU5FYy9CckQ4RE5lMDZTcUN6eVB6U3NpY0VMT1R2b0w5aUhtWi9kQXdt?=
 =?utf-8?B?UjNDYm10WmpwMGtoT2JFNnVjbDVVays1NURuSHJqSDZLcFlVckgvUElMdGlz?=
 =?utf-8?B?enZmZUdoUlRSZFhnY2R2TnlaeWhrVGNwTk41bTh0NHlycVk5QVlnNmJuQ01n?=
 =?utf-8?B?Qms1M1FMZityd1g4R3c1eWl4aE1WanB1ZUN0VVU3Y3VQTjNGQ2xZM1dBenZC?=
 =?utf-8?B?RFRTb3B0SGh3VHYxRFdaalZhVXFpNWt0eVhFTUVWbnFzTHpNWnZuUDlldVg1?=
 =?utf-8?B?bFMwTjI1TWNUbFZIT0JQaTB1V25nU0J3WTNzN2hxWHAvcjRKaEN3Z2RkZXNL?=
 =?utf-8?B?Tmxuc1EvL3VncWRXZS84MjdhZGhFdzdYKytoWTRpbnAvUzVVRHFDMFE0dEU3?=
 =?utf-8?B?bmFGQ05PYmNkUmV6ckdRYXl2dVRWVHAzeWJPcmRGdzByZkt1QUcwOFdMb3M3?=
 =?utf-8?B?VjB6ZmZBbXI1bzU0RXlBYzRoNzk2VDRMUjBQdk5EYS90Nkx2QnJrSEFseElu?=
 =?utf-8?B?TXNCTFYrQ3IrMW51d3BCMEYxa0JMaEZBVXdsV2pHcWhnN3FRekxVN3RlK3lp?=
 =?utf-8?B?QUdGUXA3V3g4L25vbFh1UVFab0lqZkZYa081WEwza01LaFIyeDRuTjB6OXp4?=
 =?utf-8?B?UUptSEdSVVFvMUdWdS8va2hKM2xtTU9TVlU4dzlFRlNOR0RPVTNvaWUzeXBW?=
 =?utf-8?B?UHJ4UHdsdnFTeHBXM2ZCaDcwbmZNKzJBbXFDUmtXaExQL2Nndzl0Z2JsUkl4?=
 =?utf-8?B?UkxjREZHang1Q1AvaW9Mdncxb2dQampGM21QbER3YVBQK2FVUm05SXpUWlcv?=
 =?utf-8?B?aEV1ZEdJQmhwbEZIQVdoaEx5UElSMTFWQ1RjRDduQ3d0UGlJVk0wclFvNlNB?=
 =?utf-8?Q?ruB0GAxyKY2CRQYJwNiNfAZS6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2dbe85-83b7-4d14-875b-08de27caeddb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 00:22:46.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIaMyaJ1BbFiGz34qXcp2c4+9NP993ByFoc/h5/bhn8E9GJiGko6dOtZVA0naZM6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

resend, to fix the code format issue.

On 2025-11-19 18:33, Philip Yang wrote:
>
> On 2025-11-18 12:32, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have 
>> split)
>>
>> When split svm ranges that have been mapped using huge page should 
>> use huge
>> page size(2MB) to check split range alignment, not 
>> prange->granularity that
>> means migration granularity.
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>:
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 63 ++++++++++++++++++++++++++--
>>   1 file changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 521c14c7a789..7bb94555e5f9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1145,12 +1145,39 @@ svm_range_split_tail(struct svm_range 
>> *prange, uint64_t new_last,
>>                struct list_head *insert_list, struct list_head 
>> *remap_list)
>>   {
>>       struct svm_range *tail = NULL;
>> +    unsigned long start_align = ALIGN(prange->start, 512);
>> +    unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
>>       int r = svm_range_split(prange, prange->start, new_last, &tail);
> move this function call after variable definition, easier to read.
>> +    bool huge_page_mapping = (last_align_down > start_align) &&
>> +                 (last_align_down - start_align) >= 512;
> >= 512 is redundant because start, last already aligned to 512
>>         if (!r) {
>>           list_add(&tail->list, insert_list);
>> -        if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
>> -            list_add(&tail->update_list, remap_list);
>> +        /* original prange has huge page mapping */
>> +        if (huge_page_mapping) {
>> +
>> +            /* tail->start is inside huge page mapping but not 2MB 
>> aligned
>> +             * or tail size is smaller than 512 pages
>> +             */
>> +            if (tail->start >= start_align && tail->start <= 
>> last_align_down &&
>> +                (!IS_ALIGNED(tail->start, 512) ||
> split from the tail, new range is the last part of prange, don't need 
> check size
>> +                (tail->last - tail->start) < 512)) {
>> +
>> +                list_add(&tail->update_list, remap_list);
>> +                return 0;
>> +            }
>> +
>> +            /* tail->last is inside huge page mapping but not 2MB 
>> aligned
>> +             * or tail size is smaller than 512 pages
>> +             */
> tail->last is the original prange->last, impossible inside prange.
>> +            if (tail->last >= start_align && tail->last <= 
>> last_align_down &&
>> +                (!IS_ALIGNED(tail->last, 512) ||
>> +                (tail->last - tail->start) < 512)) {
>> +
>> +                list_add(&tail->update_list, remap_list);
>> +                return 0;
>> +            }
>> +        }
>>       }
>
> to refactor the conditions

     unsigned long start_align = ALIGN(prange->start, 512);
     unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
     bool huge_page_mapping = last_align_down > start_align;
     int r;

     r = svm_range_split(prange, prange->start, new_last, &tail);

     if (r || !huge_page_mapping)
         return r;

     if (tail->start > start_align && tail->start < last_align_down &&
         (!IS_ALIGNED(tail->start, 512))
         list_add(&tail->update_list, remap_list);

     return 0;
>
> do the similar change for below split head.
>
> Regards,
> Philip
>
> @@ -1160,13 +1187,41 @@ svm_range_split_head(struct svm_range *prange, 
> uint64_t new_start,
>               struct list_head *insert_list, struct list_head 
> *remap_list)
>  {
>      struct svm_range *head = NULL;
> +    unsigned long start_align = ALIGN(prange->start, 512);
> +    unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
>      int r = svm_range_split(prange, new_start, prange->last, &head);
> +    bool huge_page_mapping = (last_align_down >= start_align) &&
> +                 (last_align_down - start_align) >= 512;
>
>      if (!r) {
>          list_add(&head->list, insert_list);
> -        if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
> -            list_add(&head->update_list, remap_list);
> +
> +        /* original prange has huge page mapping */
> +        if (huge_page_mapping) {
> +            /* head->start is inside huge page mapping but not 2MB 
> aligned
> +             * or head size is smaller than 512 pages
> +             */
> +            if (head->start >= start_align && head->start <= 
> last_align_down &&
> +                (!IS_ALIGNED(head->start, 512) ||
> +                (head->last - head->start) < 512)) {
> +
> +                list_add(&head->update_list, remap_list);
> +                return 0;
> +            }
> +
> +            /* head->last is inside huge page mapping but not 2MB 
> aligned
> +             * or head size is smaller than 512 pages
> +             */
> +            if (head->last >= start_align && head->last <= 
> last_align_down &&
> +                (!IS_ALIGNED(head->last, 512) ||
> +                (head->last - head->start) < 512)) {
> +
> +                list_add(&head->update_list, remap_list);
> +                return 0;
> +            }
> +        }
>      }
> +
>      return r;
>  }
>
>

