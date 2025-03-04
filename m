Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A1C282D0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 22:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB9810E009;
	Tue,  4 Mar 2025 22:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upr3ETZN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495F210E009
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 22:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6UCTZdF/f5pFlrILFkaTS2p+QFc/qGBUxoNi/ToBHDFnIjFBkObsxjA/+bgy665H41Bubk9Fbr7ej5OopDxJJY2O5R3MDTWwCVBFZCtBlev+UNYsFwtUiyEF4s0o6O5gvQFEGgMwmBa3rtkK0zInDNSajQPPdAS3GgYIhCNe4kuLN8R1v081ZVANhwzLI+5vUrDF4ZQLQkpXSZCOlS+pQjz9fTueSSn84ul9x1Olm28n6w08AP71K01htXHjjh1gCxcifYNRjginOkSkRhWzffxogkdfDlJ4HR+PlJeVzgUpQnYPxm1Ius92xEOAQ/y+c5hdeJ7uL5asYfs/gck2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TTlJ01FkTpmZX3g1UWyZWHag0Z45V1Jwg2+V2XLbk4=;
 b=nVifBqyPLQSDm9fmq1lK81hufN5vgZOrbC4sziC5uJAQ0QvQOnN8rY3qESaKX0gRsHyMH/nh7Am/E1bvIcc2cv0b4l83D9zLnlGhzKcXF2IyOg9HEJ6eqkrMeD7IAqInmgAaP918plxd8xmWl3LglJeyEBMatHS6qx7TYiNx5TkeWRCxcrCvXQUKDXe2f04CkuiHs00lNgBfL0APWJAyxloP+jg467cxEonzJsNF9HeGfA8SNYW8CDpPYeI4KWfyOTh5pDDrGSsGXW8h34ZUJVUcoQ/FAxKq+c+aMw0LmdWss0vqkdSeGZ+R1OvpyC7dqFKuH1D0dN/0g0dxaWynMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TTlJ01FkTpmZX3g1UWyZWHag0Z45V1Jwg2+V2XLbk4=;
 b=upr3ETZN/eBMXI7H/XRgmkFhGUZnpIi5KsvOc0fkAmxj08ijeULsLXtK/QXZdckhMHiYn8G0KnIRyPjSW2u/f7NBkgTZ1yLtdEC4pZYn5a2a2M6VZswAZ9vcjPqUPbFu2sgMZevEEvfvxMl+BSsmGFGkshK5D6TcaMIKxXiOe1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 22:59:33 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 22:59:33 +0000
Content-Type: multipart/alternative;
 boundary="------------RbavMG1RWikoTGQFE9LFgZ1w"
Message-ID: <53a31f36-5eec-4e5f-86e9-3196c853c62c@amd.com>
Date: Tue, 4 Mar 2025 16:59:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165839.8433-1-xiaogang.chen@amd.com>
 <af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com>
 <da6aa7ea-bf95-4e5d-8c37-5a2c43c4fc2f@amd.com>
 <ab954442-5bf6-4d2b-8d08-a6078b0dd6fc@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <ab954442-5bf6-4d2b-8d08-a6078b0dd6fc@amd.com>
X-ClientProxiedBy: SA0PR11CA0136.namprd11.prod.outlook.com
 (2603:10b6:806:131::21) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb640ab-d31d-42b2-61a3-08dd5b703a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkhmOFZJT0tGamVFV1NYQkhUOFR1bGhBNTJvUkJXcDZLRFdlTk1VT2wvVTJW?=
 =?utf-8?B?VlNKa0wvdnNqLzVDUjhqY2pOYU1hQzZPQUZ3emhnZThScHE5Ylc0YmhPVW83?=
 =?utf-8?B?WkJPc21peVpoQlBMNWxOZWhCeGozZU9DTkJPY1NzVzQ4R2xCVFl1UG5aRkhP?=
 =?utf-8?B?Uzk2dmhLZzRSU3pPajV6MElpRmM4L1gvanpBZFFvcmw3YTJvelpHUTQ3VU0x?=
 =?utf-8?B?N3NLWmN2OGhMcm9PTFovUHRFYjFNTFdjSWhtS3hRdVU3Rk5SM0R0eGJPKzh0?=
 =?utf-8?B?d1dBL002eVNObG4wMWtONGJjRFpENGZYYmFwaXNrakVWa3V6Z1JCd3Avb1ZY?=
 =?utf-8?B?TEdLK01FdStoK2d4T1gvMXc1OSs1T3VQcFZRVjBKaXpLMHhDOU5lMkZaT2dn?=
 =?utf-8?B?WEhhazE1MkRhQWNEbW84TDdoRW8zVGhtbGVySU5YNFR5dDIweGs2OFROQVZz?=
 =?utf-8?B?ZlVyWkEvSHg2WHdWUy9sMkJJZTJoMldaUThTQkpmdEZGbG81VkEzalNlRytS?=
 =?utf-8?B?NXB3UHhyTlFOc2xEZllmTm9USCtqTkFiV2VoeDZqTTJCbnJFYjNEWC9udFpq?=
 =?utf-8?B?L3Npc3E2b1IzZWFCOEdJTWFqdzZXTG1pMldrUWlCSFhmS2xIbUt4ZlI5R0dk?=
 =?utf-8?B?OHg5Q1kyR2xsNVhsaHJqTVVXb0lhdXNCaDNsaHJEY1VKWDNyMk9RUHdwUHEy?=
 =?utf-8?B?RXEyR2ZGWElEeXdKbHRGSWlpZit5N1gxbHNJallZTlF6WG5wdVgwcTlBWjRZ?=
 =?utf-8?B?dEFxS3Y3ZXFNWHdhNnVxeWRmR1NHUkJGZGwvM1pxMndKL2E3NGxUWWFUNWlm?=
 =?utf-8?B?dVlWWThYbXg0TTlGZkxObGRCeStoWEVCc0VWWUdBbUJHNmlWdTl3ZUxublRN?=
 =?utf-8?B?aHU4ZXRiQUtWNEhMdEhjREpUNXFKUWd2UXFoWkZKd1JiRXdpcGFWaWhLUGxQ?=
 =?utf-8?B?Mmx5UE9YSHRvNjJoMklZR2VPL0ZkcDlsNGNRMml6c0lUbnp3TFU5QnhGcmZ3?=
 =?utf-8?B?ZXE0eGcvWXEzcUY1TmkwbVFGYzhXM1Q2b3R2aDI2NU9obGZDU29TQmp3L2RN?=
 =?utf-8?B?dTYxNmp1ZHZrbkhVL1FCeE0rZEtJbjB5V1Zuc1J4OWY2cG53UC9lMngvUEt3?=
 =?utf-8?B?TFN5Q0NqNjBjUW1peVpaNGlML1Z0SEM2SmQ1RzJLUndDMlcvTk1CTFlvdzRa?=
 =?utf-8?B?dTRjcTVEL09FZ09wYXZKRTJNUUZ2enQ2a3FnbUxVNktIdGx6cVAwb0ZWRnN0?=
 =?utf-8?B?OUZuZjZRaW8zeXpnbk91R29FQkxTMzRvcTIrbVFwZkttS2JXRjQraVpZZ0Vh?=
 =?utf-8?B?bFJSRWMyTUNXWGVGOW1QYWFPejBtaGNOR0JxbllpZnFyS2FzTVVQNkFZT3BP?=
 =?utf-8?B?NFB5OEVmTGxOd3NVNUtoaHkrVHVuVWg3cndMOVBkSnRuVHA2VnVLaWE0UDJX?=
 =?utf-8?B?N2lmRmtlcWlvZDN6Vk1hSnZJNGx1SUY3ZVRKWEQwanE5YjBuemFSR0NuNlh3?=
 =?utf-8?B?YUhzL3krclVGeFhGa2hKS20yNWxpOU1mV2dyMnRqRTZyKzN5MjE2bVdPMFJW?=
 =?utf-8?B?SnZNdlYzekdGcngyRDVaWURrTXNobmFZZTh6Y0Zwb0NSUkVkYjhzRTlOQkRU?=
 =?utf-8?B?VFJ2VWEvaytSa296eFRxVEkyTHNRalh6ZUF4RTY5cGVoc2ZGVDBqc2RaQWVu?=
 =?utf-8?B?ZEFhYUdjTjRWc0xZb2JNMjA3THlmc3h1OWZONllsV0oycHNsZlBMUFFSeWt6?=
 =?utf-8?B?VnJBaTFCOE9EbTVlV3ZoK0lhYkk1eXhRNkIwTitVZWo1RmIxWTRRNEkrOVo0?=
 =?utf-8?B?R3BDNWpIeUlrTVpqcnpFNmtNTW5ESGdSdWZHQ25lcFZsVmNaSmhyam9sbzBy?=
 =?utf-8?Q?so9Sk/Ot+6sr0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJvYXRTaHZ0WlBXWEQxZFhmWU9UamRhdzRZRmRCbFJ3QzZZekxya0hNcy90?=
 =?utf-8?B?RWZCTi9wemdTdUxvai94bjhTemJRemNWbmVTanpwWDRkODd6cWo0eHBXNWF2?=
 =?utf-8?B?cHlNM0VYSHd2akhadjBaLzV0Sk02cVRTcWtQWFIxQ0dBSVlpYUtGajdiNlpn?=
 =?utf-8?B?aEx1NUY2MVgzSTVaV1E4bGVHTmxuNjlZSXI3VU0rUkxWdXhTWTN3UkdUMnRF?=
 =?utf-8?B?aEduRGVPOEV5SklHYkxFaWtkRjZscWhCenpQa3d2TXRERU96dEt1ZTMrQjlj?=
 =?utf-8?B?T2lGVmphSWdqK2hsK3hha2pQNDlPMXJ1V1JVWUZBQnVldkdDYVFpRkt4d0pL?=
 =?utf-8?B?UHV0bGE2NnlwRE1TaURRTCtmbDJaVjRyeEs1R0xmanNWZmhNOFI4YkM3QUNE?=
 =?utf-8?B?WGtESWIwZXhtaFlJaGtsZEFCVFJGTUViM0FLWUVxd0dQMzRmMFp4emNPamVX?=
 =?utf-8?B?eFQ1RjJ3T0Y3ZEdXTExJYTNWN1VNVDhoMGd0Wm5iaEJ2bUZHanlSK0ZNVita?=
 =?utf-8?B?K2prUDBEOS9VbHN3d1FyTkZDVkdvclVBKzA3aThtTENKYjVXSW80aDh2ejZH?=
 =?utf-8?B?NURYNXltVk0xOGh2SHByYnlhQ3NtZlV2QVpGOGZ6NDloMUdVaUkzSjlLYkdP?=
 =?utf-8?B?RVVpMFdSYlBlS25HQ1RDdm1JVnJSVm1XbmlQQTNHNzN5WFY4NzFVRjBaU0NV?=
 =?utf-8?B?QzR1bFYxdE1pdmNMMW9xSUZTME5BSUV6M2hLdmNsOXdVOEFyVFVraHFTSHli?=
 =?utf-8?B?N0oyempEdXJKWk82TU5xVXZta3Z1c3R2cUxQdnlCVmYzSmhFUW9EZDRkQURN?=
 =?utf-8?B?RC9aWU1aTDZZVjNKVldIRkF0NzZPb3ovSlkzMlhKOHhXZ1JrTTZYUHJZc01W?=
 =?utf-8?B?VkpMUG9VT0NDZlFVaU94K2NMdk12UzA2LzhYL245a0hoUXpFUlFTcnJXODcx?=
 =?utf-8?B?Wmh1a09SVGhWY21mK2IwdVpSaEdjbjM4SFB0N2ZiRWZacXFGdk1vaXhaeDl2?=
 =?utf-8?B?RS9LL2tCZWNkMlptUzFTSERxa083WHNRSy9OT2t5c1BOQjFVVHUzUlZmenhi?=
 =?utf-8?B?TkVhbXk1anRRWDFBR05WRzFOdG1ocjR3VnJId0xLemZJUU0wcnRVaVFUdGsw?=
 =?utf-8?B?QWRnRm80V1FiTFB0ditPUjJyT3BnZ1NPY3lyTGlFcTFsNDFOMjl5VWxyMHM2?=
 =?utf-8?B?bVM5emJlMXRVVkxQamVGK2QycWNkdGhxSTZhOFY5dkwxSFR6cU51L0J0clo0?=
 =?utf-8?B?Y3gxYTFlcmhqek0xSmxkMWJVaDJCVG1jdC82ZittK0RyWWpNOWxzM1dIM1Zh?=
 =?utf-8?B?eWNxZml4MWZCeHJRRUt1bHVORy9TMHRnT1Q0QVZ5N3V6YXQra2lUMzRyWkRh?=
 =?utf-8?B?aWJkS3JzL1hNQk9YMXRlaWNnVUVaYWllOWpFZkpqTkswU05oOXA2QUxyZjRH?=
 =?utf-8?B?WHRIQW0zbXFIL3k2ZS8zUXpwbmRNV013UWdwQW9FcWQzbi9ETGJiMVNYcWdP?=
 =?utf-8?B?R0o5RndIOGdYc2VudGd2RFJON2EwZGlrWXVMYjlzTCthRnZXRDE0QWtDSUxp?=
 =?utf-8?B?czRoTHpHMnhGQzVrY0RKRWc3eWFHbEJxdytGYnYrMkNDbElXM0owV3lFOCtV?=
 =?utf-8?B?czE2Nlp2WjR1V3FSbjJKOXVSZmtSRUJXNllUN1Z3b2JoMndjVEdsQ0E1NHJa?=
 =?utf-8?B?ejNjbXNHK2V6OG5OK2l4ZkRDK0Fpay8zcElKaG1UYVJNRVBUaTc0MkphZ09m?=
 =?utf-8?B?SnBLallqWjZhaXRlcmF6UWtpbjZRdnRUUk5ObEJGdDV0RDI0RTRhTjd3d284?=
 =?utf-8?B?cXZkZURYemtqTGpoMzYzWmFWZjBKb0VrRG8zREFyL0tONGZCZUhqVlFZaTdY?=
 =?utf-8?B?VTV2aFU1YVkwTXJlWFZocXQ1eFI0UkR2UktwT0YwSHRiZnA1OFFpUjFyL21w?=
 =?utf-8?B?THpSTk5lTmFyZjFaaitLb0poNjV5cWhsdmxFOXZnbjFQMEZqWGpyNHJkT29q?=
 =?utf-8?B?TUhZanVRL3oyUFJ1UEFPcUsxK002SlpKQkFDa0xvRHQ3bklzNVBMeGtMUGdV?=
 =?utf-8?B?cTlZamhtU1lWa1hsK2s4L1VIWktxK2k5MTdScUJXZ1gzOUJGUjl3SFl4TXRD?=
 =?utf-8?Q?/dqQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb640ab-d31d-42b2-61a3-08dd5b703a44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:59:33.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWlKk2hJBYQpChjkbwcJ8l1AHQQ2//xmg6aY/1ElnuMx+eAvKydwjxuj7sWSNkkk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

--------------RbavMG1RWikoTGQFE9LFgZ1w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/4/2025 12:32 PM, Felix Kuehling wrote:
> On 2025-03-04 13:23, Chen, Xiaogang wrote:
>>
>> On 3/3/2025 11:21 PM, Felix Kuehling wrote:
>>> On 2025-01-31 11:58, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>>>
>>>> When register a vm range at svm the added vm range may be split into multiple
>>>> subranges and/or existing pranges got spitted. The new pranges need validated
>>>> and mapped. This patch changes error handling for pranges that fail updating:
>>> It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.
>>>
>> Current way is returning the last sub range error code if it got issue during migration, validation or map. If the last error is -EAGAIN, but there are other error codes at middle for other sub ranges we still return -EAGAIN. That causes same procedure repeated until the sub ranges that have other error code becomes the last one.
>>
>> I noticed it when looked at large range(more than 100GB) registration which split into multiple sub ranges. There were multiple unnecessary repeats until hit return code that is no -EAGAIN.
>>
>> As you said we may return immediately if hit no -EAGAIN, and hope app terminates. But if app does not terminate kfd drive will hold unused pranges until app stops.
>>
>>>> 1: free prange resources and remove it from svms if its updating fails as it
>>>> will not be used.
>>>> 2: return -EAGAIN when all pranges at update_list need redo valid/map,
>>>> otherwise return no -EAGAIN error to user space to indicate failure. That
>>>> removes unnecessary retries.
>>>>
>>>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
>>>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index e32e19196f6b..455cb98bf16a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>>   
>>>>   out_unlock_range:
>>>>   		mutex_unlock(&prange->migrate_mutex);
>>>> -		if (r)
>>>> -			ret = r;
>>>> +		/* this prange cannot be migraed, valid or map */
>>>> +		if (r) {
>>>> +			/* free this prange resources, remove it from svms */
>>>> +			svm_range_unlink(prange);
>>>> +			svm_range_remove_notifier(prange);
>>>> +			svm_range_free(prange, false);
>>> Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.
>> When return -EAGAIN app will do whole range registration again including rebuild sub ranges. And at this stage we do not know if subsequent sub ranges will be success or fail. So I release current sub range resource if it got error(including -EAGAIN). After processing all sub ranges if decide to have app do it again, the redo procedure will rebuild the released sub ranges.
>>> I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?
>> I made a test app to check the behavior of registration of large range for debugging a real issue. I do not know if real app will continue to run when hit no -EAGAIN error code. The purpose here is making driver handle this case more general.
>>>> +
>>>> +			/* ret got update when any r != -EAGAIN;
>>>> +			 * return -EAGAIN when all pranges at update_list
>>>> +			 * need redo valid/map */
>>>> +			if (r != -EAGAIN || !ret)
>>>> +				ret = r;
>>> This is a good point. But the explanation is a bit misleading: "all pranges ... need redo" is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.
>> ok
>>> I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.
>>>
>> As said above it is a another way to return immediately if hit no -EAGAIN.  but should kfd driver release unused pragne resources any way?
>>
> No. Freeing the prange doesn't free any big resources, like VRAM. If VRAM is used by the range, the page mappings in the CPU virtual address space hold reference counts on the underlying BO. And that doesn't go away until the address range is munmapped. If anything, you may end up using more VRAM resources because the next time you validate, you may create a new VRAM BO, but the old one may not be released yet. You may also create problems for later callbacks (MMU notifiers and migrate-to-RAM) for those virtual addresses because you're destroying the SVM range structures that would be needed by those callbacks.

yes, there are still something left that need svm data structures to 
back up though sub range got valid/map fail. And vram bo may be created 
again at redo procedure if call svm_range_free. I think mmu notifier is 
not an issue since also call svm_range_remove_notifier(prange) that 
removes mmu callback for this range.

Seems we have to carry on these unused prange data structures until app 
release them.

Thanks

Xiaogang

> Regards,
>    Felix
>
>
>> Regards
>>
>> Xiaogang
>>
>>>> +		}
>>>>   	}
>>>>   
>>>>   	list_for_each_entry(prange, &remap_list, update_list) {
>>>> @@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>>   		if (r)
>>>>   			pr_debug("failed %d on remap svm range\n", r);
>>>>   		mutex_unlock(&prange->migrate_mutex);
>>>> -		if (r)
>>>> -			ret = r;
>>>> +
>>>> +		if (r) {
>>>> +			/* remove this prange */
>>>> +			svm_range_unlink(prange);
>>>> +			svm_range_remove_notifier(prange);
>>>> +			svm_range_free(prange, false);
>>> Same as above.
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>> +
>>>> +			if (r != -EAGAIN || !ret)
>>>> +				ret = r;
>>>> +		}
>>>>   	}
>>>>   
>>>>   	dynamic_svm_range_dump(svms);
--------------RbavMG1RWikoTGQFE9LFgZ1w
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/4/2025 12:32 PM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ab954442-5bf6-4d2b-8d08-a6078b0dd6fc@amd.com">
      <pre wrap="" class="moz-quote-pre">
On 2025-03-04 13:23, Chen, Xiaogang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 3/3/2025 11:21 PM, Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 2025-01-31 11:58, Xiaogang.Chen wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When register a vm range at svm the added vm range may be split into multiple
subranges and/or existing pranges got spitted. The new pranges need validated
and mapped. This patch changes error handling for pranges that fail updating:
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Current way is returning the last sub range error code if it got issue during migration, validation or map. If the last error is -EAGAIN, but there are other error codes at middle for other sub ranges we still return -EAGAIN. That causes same procedure repeated until the sub ranges that have other error code becomes the last one.

I noticed it when looked at large range(more than 100GB) registration which split into multiple sub ranges. There were multiple unnecessary repeats until hit return code that is no -EAGAIN.

As you said we may return immediately if hit no -EAGAIN, and hope app terminates. But if app does not terminate kfd drive will hold unused pranges until app stops.

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">1: free prange resources and remove it from svms if its updating fails as it
will not be used.
2: return -EAGAIN when all pranges at update_list need redo valid/map,
otherwise return no -EAGAIN error to user space to indicate failure. That
removes unnecessary retries.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e32e19196f6b..455cb98bf16a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 out_unlock_range:
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
-		if (r)
-			ret = r;
+		/* this prange cannot be migraed, valid or map */
+		if (r) {
+			/* free this prange resources, remove it from svms */
+			svm_range_unlink(prange);
+			svm_range_remove_notifier(prange);
+			svm_range_free(prange, false);
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">When return -EAGAIN app will do whole range registration again including rebuild sub ranges. And at this stage we do not know if subsequent sub ranges will be success or fail. So I release current sub range resource if it got error(including -EAGAIN). After processing all sub ranges if decide to have app do it again, the redo procedure will rebuild the released sub ranges.
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">I made a test app to check the behavior of registration of large range for debugging a real issue. I do not know if real app will continue to run when hit no -EAGAIN error code. The purpose here is making driver handle this case more general.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+
+			/* ret got update when any r != -EAGAIN;
+			 * return -EAGAIN when all pranges at update_list
+			 * need redo valid/map */
+			if (r != -EAGAIN || !ret)
+				ret = r;
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">This is a good point. But the explanation is a bit misleading: &quot;all pranges ... need redo&quot; is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">ok
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">As said above it is a another way to return immediately if hit no -EAGAIN.&nbsp; but should kfd driver release unused pragne resources any way?

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">No. Freeing the prange doesn't free any big resources, like VRAM. If VRAM is used by the range, the page mappings in the CPU virtual address space hold reference counts on the underlying BO. And that doesn't go away until the address range is munmapped. If anything, you may end up using more VRAM resources because the next time you validate, you may create a new VRAM BO, but the old one may not be released yet. You may also create problems for later callbacks (MMU notifiers and migrate-to-RAM) for those virtual addresses because you're destroying the SVM range structures that would be needed by those callbacks.
</pre>
    </blockquote>
    <p>yes, there are still something left that need svm data structures
      to back up though sub range got valid/map fail. And vram bo may be
      created again at redo procedure if call <span style="white-space: pre-wrap">svm_range_free</span>. I think mmu
      notifier is not an issue since also call <span style="white-space: pre-wrap">svm_range_remove_notifier(prange) that removes mmu callback for this range.</span></p>
    <p><span style="white-space: pre-wrap">Seems we have to carry on these unused prange data structures until app release them.</span></p>
    <p><span style="white-space: pre-wrap">Thanks
</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <blockquote type="cite" cite="mid:ab954442-5bf6-4d2b-8d08-a6078b0dd6fc@amd.com">
      <pre wrap="" class="moz-quote-pre">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Regards

Xiaogang

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+		}
 	}
 
 	list_for_each_entry(prange, &amp;remap_list, update_list) {
@@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		if (r)
 			pr_debug(&quot;failed %d on remap svm range\n&quot;, r);
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
-		if (r)
-			ret = r;
+
+		if (r) {
+			/* remove this prange */
+			svm_range_unlink(prange);
+			svm_range_remove_notifier(prange);
+			svm_range_free(prange, false);
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Same as above.

Regards,
&nbsp; Felix


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+
+			if (r != -EAGAIN || !ret)
+				ret = r;
+		}
 	}
 
 	dynamic_svm_range_dump(svms);
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------RbavMG1RWikoTGQFE9LFgZ1w--
