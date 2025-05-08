Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C98FC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 15:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102F210E0BD;
	Thu,  8 May 2025 15:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xOMdSFkV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D038710E0BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 15:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2XJEASC55i4UiK/RVkLyJZ+C2VtZPwiF+lNpalZvkS7xR41qCqShOvzoLIk53lZ8w6Vdzp14GKgH8Db/pFfXk2hsbSHHAfby3a53eWOhCrjc4P3YRtHMLj+C/5W0AdrsqdP6YjVM3cWJPK+Rvu0MmcEN7V4XSnsHQ9qjmWWI6YsONPXj9dASiK/K6wGOIpdk+FSdpeeqYJDAXCE37pk4Lef7R7Dqywo/RxzVz7aM153VDx7QMDC97/Tb0QBE85XH10KR64Pc0/bxvTgCwWZa9AoTSxF2hPI1TAFRmcJvNjIIHDRIKP9S4Kgn7ra3wz0X5vLctzMMKbYxOFCd7EGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCkQbXjdn0t7lx4vmQJuNep3VePKSTXknpWnUgq6k1c=;
 b=o99eZqcnWFjL/1SnXoEQSus1shx3bGM1j+ehAzBZz+Ov3KHQZ/R01k5LGciMfCULggDRIsw5/uU5jKOWEL/2/Z2aWV+tvD6AlYUYDBenr2+BUU4ODtY/Z3xxQ+0G/E9QGXhsH7FpHjf4+e14QJtmHO+YrIlZ4sNd2N6WFzWBStOPKue43QgJ0QVI6l3Q9d2fnmtd5Ap43Q5IQ1VmljomotTpLQFZjqeATYN6s9h8ypDMUYTIG9afGMcSTsDFwhbu1T0N6mxSA9eY6e0za9wEpBzju87QBXOLFbkHfxx5CNa9PdeULHvAnbro3HzTT/yOq8tT7dvIvMGdfPFwt/bj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCkQbXjdn0t7lx4vmQJuNep3VePKSTXknpWnUgq6k1c=;
 b=xOMdSFkVtQ0P48mEUg7XqnXiHaZ/jKHPdIJL0sKRFLqL++OlKasprx72X6bFUC+IXfrYoIhtNasWlvU7POQDho0C32xtBC22n7V+eWOKI91EO6uHCHTi0meWHmm37Y0gTrXPdQNWv581pC5OIeUHfCDxsONO7S3qlD79uk+GL6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 15:20:15 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 15:20:15 +0000
Message-ID: <6466df95-a64d-4894-b148-c153d299599b@amd.com>
Date: Thu, 8 May 2025 11:20:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0276.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::30) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 8729bf32-441f-4024-b8c9-08dd8e43d534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJ2UjZ0MzBnUTJIbWNsTTg1eWtCakpYalFJUmdTZkJxMktDMWVnYXo4UVIy?=
 =?utf-8?B?UUZkNllIdTYyN3Y0ZVFWSzJCczhRclBRRkpuL3RTYXlQQ2VlOXVlWDdyYzRk?=
 =?utf-8?B?U3VwVUY0MnFubHRseUloak9sUUZvbUVYbklMWVNKdE1FSjRnODlKeENvWkpp?=
 =?utf-8?B?QkNVdkl3TSthRUVlR2xDU2h3SHhyR3Z5OE1EVzlJVkJvcThkQ2NIeURUaWVk?=
 =?utf-8?B?N25pMFFsQ3ZkQ253NnB0bytSREFMei9Kak40RmhhQi9IVk1WYVN1U3BzY0Qw?=
 =?utf-8?B?VGt2WXA0RnFjTXZmeEd1Nms3NDlaWGExRm5kVVVPR1pqcGo5d0grdHhVZDBC?=
 =?utf-8?B?aEJhZnZTK241VWo2Qnd2ZEV0enV2SjBuUXZBK1g3OFVmQTQ4czVGb21BYmpR?=
 =?utf-8?B?UlNHVDJveXN3RUQ2djEzN2VvNW1HY25rbEE3VUNuWENHWGxPY2NYSkd0dUtp?=
 =?utf-8?B?MDZ4WFRqNEVrOWFzbDZtV3FRdkNma2JUMHFzRzZlN2NZR0pCVWFNRndHS29H?=
 =?utf-8?B?ZnRuTW1aVVlZT0N2S21LNFY5VVE4RXBJd0dvcHF6NlVUMEYvbTdqSEVZYzV4?=
 =?utf-8?B?QnRGSjFzZVk1cUVGM2xTNUcxTnF6alg1dzgxWDBFK0VZTS9RZHIxZnE3SUd2?=
 =?utf-8?B?SmtaVENPVStZM3Vsa2kyWGRwV1NDbCttLzBXM2dxUEwyMXA4UzhGd2h2eWRF?=
 =?utf-8?B?WnVhYVhwMHhFUGpPVHd6Yk10RHJQR3pvQ0RUeDY1QW15WXNZaVEvbUNPMWt6?=
 =?utf-8?B?dFBmSmtGNEdUWEVqZG5SNk1XSzE1VER4cFVMR3pTOHh4N2dsSFR0VUxqdTQx?=
 =?utf-8?B?QTFKUUsvS3dkL1EzeFU0eDBWMTg2Q2RsQjBsN1M4SVdIMlVva25hTW5MZ01j?=
 =?utf-8?B?bnFaUmtlMkF6VGNiNFoxTldjVGZnQWE5T0t0U1dDUnNVcDhCWk5tbDB5VGJh?=
 =?utf-8?B?dTNxRkRNVkhsSkhOb3VNOU9IT05RTG5mQWVEdENyUjNtQ2FhTURYa2tnVTQ5?=
 =?utf-8?B?N0ZiM0IvdE9yRTZ6SWd4dFdVSlV3eVN6MDl4MndoWEZYZisrdXhVdVBvMFJO?=
 =?utf-8?B?Y3VWZG9jcnA3V2dYeGh4TTJmZy92TytxdU4wTHVWL2dhR3JLOUpZWUxDMGpP?=
 =?utf-8?B?bEd1Z0JPc25tN0MyYmJ1S3VnWVNUU1U5ZGJCZWNMT1N6QnZWMTVvdWY0QStX?=
 =?utf-8?B?dG5PNlFMNzZXQkhzOUJweHN0NDh5emRWQjRNdXowcjZONHZHV21NWGZYd1Rz?=
 =?utf-8?B?YS85RGtyQzRyRGNFa0FLQ09mUDV4ck8zN2hqeGl2WEdBbTNFN3BpTlZlbEhr?=
 =?utf-8?B?ZDBJcW9xRmRUcUhnVUY4RWxHVkxyY25vK3ZuSlhwR1FhbFBNTmd5akpYbGwy?=
 =?utf-8?B?NnRZMkZhZW14OFhUV1E0eW9GeXlkK2Z2MGhSdmIwcHJWVXh6aXhiMGVZZFhm?=
 =?utf-8?B?ZHJqOXZnQjc4Nk9OdWtoOFBZby81VXRlbnNCYVBCUjE2YUVuKzZkVHEwWUkz?=
 =?utf-8?B?RHJlWDV1UWw5V05mMWZoY2pBVytjclFlTVlvckZGcXgwQ09rQWNuTVh0TkVV?=
 =?utf-8?B?U3F3ZHlSS2JlbndUeVVWU05zd0cyenlhUHI2Y1RWUmc0eXk2RXA0TkFUV2w4?=
 =?utf-8?B?d3VOTjJDSVpLcGl3YXVMYWQvanU0V2puN3RMRzFxQmIvWWhvL0NzYkl1YWMv?=
 =?utf-8?B?cDhsbjkyR0xla0N5dXJsTkdINW1LaGZqblBaRWx6dWY0UXM5QzNqcTlGUEdE?=
 =?utf-8?B?WVdxNzAwOFpEWS9US1U3ZnNlTFdHN3BEQ2pQK3BMb1NaNURVdWZWSlg0amZ0?=
 =?utf-8?B?eEdsQm9rZjcrVmlCQjJzcmhkZnFrd2xUcG5va1ZYdzJCYUFndWI5L24ydHp0?=
 =?utf-8?B?bk5NaHR1ODU2b1dFV1o5YzkwbU1MMlFiMXRORTlKYVQzMk90TVR2bE56d0Y3?=
 =?utf-8?Q?zjUJsIXWPLs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFqc1hRc3VsaWRmSkVzN1dReTBtMGVZSXNrYzJ5c1FQRXc4Z3k0UkVmOGFW?=
 =?utf-8?B?N2tZUjRlSFEwb0pINmtLZmhDeGFyQTZpL0dJaTJpY2NZNXVoa2JHL3Urd0Mw?=
 =?utf-8?B?M0lsRkVmM3Fvd1ZOUVZscjd5NVFwSDA4ck51Z3dHdUFpMUlzc2dqZHc1c3BM?=
 =?utf-8?B?WGhDM1Vmc1ZkOGJFNXVEU0QxQ1YxZkI4NDgraHV3RU1leDRzN0RZVUV3TnZB?=
 =?utf-8?B?clJRbjNwQXhnTC9WaTZza3ZwYjNhci9WVksrNzQzOGhmWEhCaEFLOGJJbHE0?=
 =?utf-8?B?K0NWZXpBaFhaMXZtejVYVDhSUmIvME90WFBBd2l4SVZxRTlUbU4vMGhnTTZU?=
 =?utf-8?B?aFpKbi91dGU0VVlEMkhtNXdoMnpGOUpPTStJVmtjbCtqck84WnFsOVFWeUlu?=
 =?utf-8?B?bm8yY0o4OE5YTjY2NnVkN2pJRmxTb3dzS1RhUk1YalYzUnByNHNDL1ZQYXhx?=
 =?utf-8?B?WUFpc0ZJTkNqVERLSGFZSDNpZk9KZjhJZlllcmVUS0VmY3hpc3FOelVqM3E3?=
 =?utf-8?B?YWdKdTR1Sk5Hc2tYUGRCV3pPK25WV0lrejMzckpjRjJzUTFRcklnODFxWFNI?=
 =?utf-8?B?L2V5bU5DTENnK1dRSm4wRXVUdngvMTJyK0JiU2V4N0pDYXM5Qzh0bjA0YUxl?=
 =?utf-8?B?OUNOeWhSdEY1MDRoSnhXV3ZwWWhraVlGTk5UNElNM1liRVlTUnZrMmZaaWFv?=
 =?utf-8?B?ZW43cTdjVUlwR3RoZThrTWNlN1JscFJld0dMVGZJY1R0aHU0MzltY3ZVVTk0?=
 =?utf-8?B?UVFnMTBxMHBMd0FYeDFmdmoxTUh1eUF2Nm03NDdKejNSZzJCMHM5UWtvZGkx?=
 =?utf-8?B?WEFWZjVpNlVRLzNxWU1jQWhIV1hTc2IybnNFQXFReVM5Sko4cVFheDVGNVhM?=
 =?utf-8?B?Q1RNVFkySEJjN3gzWERNbDFYMXdKaTVUVHVZTVl6b3ExdHBucEl6ckdEaWwr?=
 =?utf-8?B?QytqT0k1eDZPOHk3YUJERHJUbXRZQU9KbFRJaUxORmZuRTdnVktVY1hRUFFq?=
 =?utf-8?B?YVNxV0FtUG9EQktEZ0s1S2hURmxDbytveTNMeUtxRmkwazNEblQwYW1ZZ2F6?=
 =?utf-8?B?TFNyWW14eC9iNk0wLzVtWE1wLzNOUjIwL1FiK2xzb3pYUjVMcVlSRnRudkdj?=
 =?utf-8?B?MmFsb2VEWmhRV2V2MFI3bEljMEJyQnBMbnFHaVErUldia1dKV1laUE9nMW1w?=
 =?utf-8?B?djVSNEowVjZ0M3lZa1FEQVRLZ1o2QktkYVhvQXhsSU9ZQm0wWTV0SHV6UU1Q?=
 =?utf-8?B?MG5SeHU0WHc5OTdnckRiMkl0YkZsbi85STg5Y2k2L3N4V3FiZFlxeTY2THk5?=
 =?utf-8?B?cFVpTlBoZCtOZHpuQ3o4U05zWk1odEJlTElMQVFjaTI3TE51UzZrbGxib0pi?=
 =?utf-8?B?TzdCT2FWL25xWHE1SWJlQyt3OVpKNkhFY3ZWVnpOeDBVdEtLOXBtMTlHYWEw?=
 =?utf-8?B?SjZxWDRHYlZ5dndyNnh4T3FNRVg3bk1QZGZvUyt3M3hqRjhrUU9uWWtRMG9z?=
 =?utf-8?B?VWZvNGQ3akVrVzdmejI0dWNzU0hTRG4wUy84Y2NZNWtJMTdxNERYdFM4QmtB?=
 =?utf-8?B?dXZKdkNQQXVQaVV3SE1sSFNVWlIwNzhNNUVTM2RrNGhWMTdkd2VaZ0hOSlhS?=
 =?utf-8?B?ZWN1NEE4eFJrakppczRNb2NPTnB5clJMeHJMYmhDVTdiRER2WDU2emRaSzVY?=
 =?utf-8?B?M0Z2L0pSZ3BGNFYveERsbVAzZTF0YVV1ZCt4RXQySm4xWWdtc3JTWFJ6cHVJ?=
 =?utf-8?B?aHVqdTB1c1dvSFpYNTRzSGVDeXlTaVhneW95Mk5TT2VDSGwwV00zMys1dEo4?=
 =?utf-8?B?WUU5Mm4xd2RqdXdvcTFrTmJ2dlZGcnhVeG53WnNWUXcxR1g4VlB0MEF1K3lI?=
 =?utf-8?B?RGlpdFI2WjZ3ZFhDYWYwcGFJSHdaK3lIcCtCdzRQOEpxd3JlczdCbS8vYnFD?=
 =?utf-8?B?Zi93cTNXWTl4b20veTllUElZQU5oZmdUdWhBK0V4QUx2N0g2NmRIVWFMU1JB?=
 =?utf-8?B?S25MaE5jS1p2Zlg2ZWJmNllQc2hqZSt2VHhLaTRPOThOUFlQMEFWd3JCa1dl?=
 =?utf-8?B?b1JyRmhLWEtiNVpvdVp0N2Y5MnZFMnc3cTg2Yk95TG0xeElET0JrRzZ6dGRI?=
 =?utf-8?Q?3xJ6Z/7iQfmEv3ZVMHgLLpdSJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8729bf32-441f-4024-b8c9-08dd8e43d534
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:20:15.0182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CYSAmXA6Jqe+PDKnkacvKUR1Qd/VhQBEiAPlFLeCA0Hk3zBACrKLPh/IksBeGP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
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


On 2025-05-08 10:50, Christian König wrote:
> On 5/8/25 16:46, James Zhu wrote:
>> When XNACK on, hang or low performance is observed with some test cases.
>> The restoring page process has unexpected stuck during evicting/restoring
>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>> 1. when xnack on, retry pagefault will invoke restoring pages process
>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>     B. if there is no enough VRAM space left, searching resource LRU list, and
>>        scheduling a new eviction work queue to evict LRU bo from vram to ram
>>        first, then resume restoring pages process, or waiting for eviction
>>        timeout and try to schedule evicting next LRU bo
>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>     queue eviction will be triggered.So restoring work queue will be scheduled.
>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>     restoring pages is completed
>>     step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>     until evicting bo is completed
>>     step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>     write after the above two mm->mmap_lock's read are released, and in the
>>     meantime which will block all following mm->mmap_lock's read request.
>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>     restoring pages request, everything is fine. if not, which means that the
>>     mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>     eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>     the second and following LRU bo's evictiion work queue will be blocked by
>>     tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>     process will be stuck here.
>> Using down_write_trylock to replace mmap_write_lock will help not block the
>> second and following evictiion work queue process.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 72be6e152e88..5f6ed70559b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>   {
>>   retry_flush_work:
>>   	flush_work(&svms->deferred_list_work);
>> -	mmap_write_lock(mm);
>> +        while (true) {
>> +                if (down_write_trylock(&(mm->mmap_lock)))
>> +                        break;
>> +                schedule();
>> +        }
> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>
> As far as I know that is not something we can do so easily.
>
> Would it be possible to wait for progress instead of calling schedule() here?

[JZ]  At 1st beginning, I am thinking adding sync with restoring pages 
done.

but the original restoring work design philosophy is blindly scheduled 
after certain delay.

the changes with sync may take more time and risk. I would like Felix 
and Philip give comments

if there is efficient and safe way to fix it. Thanks!

>
> Regards,
> Christian.
>
>>   
>>   	if (list_empty(&svms->deferred_range_list))
>>   		return;
