Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B780EC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 14:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543BD10E927;
	Thu,  8 May 2025 14:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/ovPIix";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0113A10E927
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 14:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfGJw6jB0U5vJRnxl/nPAwEfZCGX9ob7Uwkvrd8TAWjVG30j0hMir1yjHigbn27dXPqfCloxNJT9b1azpAoXmOdqqHLama5cV6nV7c2PAKRUpde/cf3IImgLLSwgHYJxW4TuT9hOwdaXD+TFO9FuW+1tKsA51zQH9LRJmxKCyMFlTu56n/sqZg6JSEDbgiBJk1ngpn1fmQ2sGrqYcnBQeBib2z9+fKdVk4Ra6M5a6IVN3SP1HTRG3Pm1bNvKNOTmGl0JasIv0gQylp9YwUXpJvBQcdVQI/skwrwkyp+WckmvvUTfAulkS6jT95efW0nOqb7uBuIEzPCOzYtVU9VC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdo0mgwvlgSkaCG+4e1TpOxGATb09zLo87Ot1af0DQ4=;
 b=bVRx1zqvT3pmppefNEYKxRx3h8wphqK4TEOtT/BJt8EcjBmEwS7I8yYCTgbiYYVE4arX9y3pgHhiTTwiUiocx4iJTM6YzDtSWvg5oWUDwR+6AzoaQeOZRBAAbSodyHjeYs8HV7xjsW4QfKouhzdfHEjGivUdkBjlHHClaBSeHu0aPT/zTnTbPg7uZkCkExt6vQMoo2H/M9qwFG+ZrAspYDDid6F+4i7BPMjiH9y889OvaAOt2NoR4N/unEn/ycnbmNf/k7ibsy33DuFen+5nzbSVWAyjln0I7xGp1x7eAfnQ2eHYu32uWTaxjZ9UML1wmo7/0IwQzaKSoNqOvxBenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdo0mgwvlgSkaCG+4e1TpOxGATb09zLo87Ot1af0DQ4=;
 b=J/ovPIix/OOJmvHPcMuPbsb+cROeMP6sa+3pm4Xy1TQSL/kJsAmmGYm3Sk/HNCq1R03WOKKfQV2dqxrJ7iYcf5ULo0RKpbLlre0hXjyRoG4FkBeBBcjz0MCSrOKzUniAefNW24pPlSf2KzBU9Dfdi8Bp2Opn6PIVyMRTP6mywd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:51:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 14:51:01 +0000
Message-ID: <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
Date: Thu, 8 May 2025 16:50:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com, jamesz@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250508144651.16745-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 97765b98-cf13-4920-f70e-08dd8e3fc028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmM5eVdkeXZ2aGgvdi9ubnduR3l2S09wcmpnQ0tPSmJmYU13cDZ2Ym9nRE9a?=
 =?utf-8?B?Zmx4dERCR0dnZ2VRREpNMDZNWkxUWUcvdXQ4b3lRVGgrMmJFSC9nK05BMjJy?=
 =?utf-8?B?MUc5V0NzclVEeGNYMC80MmkwVWxZU0t5R0VGSDZ1TktqOGdCcEZJSFFnS1hy?=
 =?utf-8?B?VjlUZ3J6VDNHSFV3TE9kQmZFUXF6VG9Pdy8rbmkzQUx4Uis1dHhOTnlRZnp1?=
 =?utf-8?B?QkxFM0tvK2xSQVFBcVQvQmFvRDlubVFhd2Y3RnJqQU9yeWF6bnZOaDM1THZ0?=
 =?utf-8?B?RE5GbUZqWVlUM3pTYTF0TktYUTVGVFgvS1d0YTFQR0Y4TXd1SnF0Sjg2Y293?=
 =?utf-8?B?UlQ4V0VhYkFZaHNGeEx4TXNIWXgzV0pPQ3psN3V5NHpZekpNMFFTQnlnTitN?=
 =?utf-8?B?YmtSME8ydW14UVlDWDFPRXhpZGV3K1hZR0hkSmc3OE1BRTNYZHkvWXVJMm5B?=
 =?utf-8?B?MjhOTkxiamVEbFNEUC9HT3RydzF3RXU0d244endpem9TbXFwQ2lMMGs3MFkv?=
 =?utf-8?B?TFRoQ1VFNnhsVmd0OS80dXpRZU9OSFhhb2Qrb3ltUHpOT0tuZ0htLzFsWnRp?=
 =?utf-8?B?bldIU2pmZTB4eTFiU1F5dWlOQmpSak84MHZselBMMU1yeGdOUHliZXNDRk1t?=
 =?utf-8?B?UzkzNkdQblZ1VG53WkoybE5FNDNCTjJBT3BNV0hUd1lWRlFSNllSU3BRVC80?=
 =?utf-8?B?aXRaZWw1T0R1MDdzL1VCdzV0cEc3amZlbjJTZ3M1U01aMEFpR0tXd0IzQnYw?=
 =?utf-8?B?NE1EYVpSQjQ1Nms3OHBQbnNtN0U3TWd5VWNMUmIzS1IwdldkSHlvaFRhSnFm?=
 =?utf-8?B?R1JRd2crWi91UE5WL05LOHg5WCtLSU1SZVp3YU4wSlQrRyt6dE1lUUVrU0pY?=
 =?utf-8?B?NVk4ekRRRndGM0YxMXZncGtsSXFEamxRMklWZEJLOFN6V25odllxdVJ2LzNN?=
 =?utf-8?B?Y3h2L0pjNUtkaHRNbFU1ZGwrM054dENlVGdHc2dGVVJYd1g0QzVzbTNTL2Ix?=
 =?utf-8?B?ZDB0MS8wUFVjeHZpdG1XSVRxdmVkSzBFbXRKZ084bkJlUEF1OGMwSHB1c1Vr?=
 =?utf-8?B?K3JNMi9tOHozYS9NOFY5c1U5ZnAzQk9DWkk5anFhTjVPbEZPSE84d2gyQm1R?=
 =?utf-8?B?MnBkaEl1S1djazFKZVNQU3F0U2QvRjMrOElFSnZPNU8yZ3l5YmFnUVZNbkFW?=
 =?utf-8?B?alFEeGczWHJXRVRVSURFa25nME5UYnlWWFJNZjdoMXdNTjArNFNDWGpWVHJO?=
 =?utf-8?B?SFFKOG8yT2hrTi9IRFBGYjNObjNjZ0ErOVFldnBkUVBISmplR3k1N3dDRnVh?=
 =?utf-8?B?UTZ5Nkk5Sm9EdGM0Y0pteGh3M21Ycld4YUVnM3Q1bzRtQVZlSHhacWJtWVg3?=
 =?utf-8?B?U2V5R1BJaGw3Q0FueDAzMjF6WlVSRmdocWtRbjNlcFJoMVo1Q1ZieU5yWUtI?=
 =?utf-8?B?bExYVGRGTjhlSm9adzF2d3pVWkpXamdjWnRlR0RrSDc0VVV1d01QeTZnZnA4?=
 =?utf-8?B?NFdHZmNJQ05DYnZTUXNpTzl1c0hlbEMrcEVVVkNIQVdzeW1rcUd5cmhBeFJu?=
 =?utf-8?B?QmdwcTJHazRQQThycGg2L1VpMWk3TnlFb1AwbDRiUm1PN0xPazE3aWNueTJi?=
 =?utf-8?B?aTNQc1lOeXVEb2tKUHp6ajFXRUtXcmlkZVN1TDRNZzBuSUs0blpyREhyeFBJ?=
 =?utf-8?B?SDZaa3hVUGJOaXhKR2dxcFFyWWFKUjZXdHRrbzFaUzNiTDc1RlY2UGt2TUgv?=
 =?utf-8?B?aXlza3dxMXJ5eDdqczlOS2RjZm1FK1lxWFJPQVdhSVY4SmxmZE9PallsQjhR?=
 =?utf-8?B?SFhoSUxTcVhpYXpnaXVKTEpwK28wSUdEWlh0VTM3RDNsNUhJZkt6STFNNlRm?=
 =?utf-8?B?enVsQkJ6cVRJY29kVFltNjdqbU1LUHRaQVFKR0EyUml0QWo1VE90SXYxOUpj?=
 =?utf-8?Q?UZo5J7OEN/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmljUWl2Ykt2MkJpT1hpVVdoUmwyc21SK1RGaEM4VHdZY0U2cHBTUXZ3UTVz?=
 =?utf-8?B?aFBGVUNqSkQ4dU9icUpiUVNxMmx1ZWtLdUJtaDlIMURnZTNBSGpKcnRXd2xs?=
 =?utf-8?B?MEFPOE8vMFhIaDhsYnpPTE84NG1MNUVBWWtCQTFwWXRyeVk1dzNLWXVSb0pI?=
 =?utf-8?B?ZzVkVkxRVHU5Sk9XcUoybGdyeExxYS9XamVvUUJaU3dpWVN0b04xb1lNYmw2?=
 =?utf-8?B?Nlh2bUEwODAySGtCOVhmNGZ0TEYwWnlLM3liUTNYeEJXN0EyZzE2ejM4eEh1?=
 =?utf-8?B?TzlveHhYc2djTzlCQkQvRGFtTkhVYlBaZC94K2pTNWdDOTlaelRRUEpVeVpS?=
 =?utf-8?B?VGszbEVFL2YzaFYyMjFKNlYvTGxHL0kzUmFGZ04vaWNxb3IzOC8weGJSc2xI?=
 =?utf-8?B?eXJ3M01hbDhPak44S25EdVhiRkdwVURCY0VlNU9sTGlTRjFzWlI3a2IzZE9q?=
 =?utf-8?B?YTNSNThXUVhncVkrak9PNzlpWnIzNVlQeTVnTjhBTDhVUVgxQ1BzRmNJbVBm?=
 =?utf-8?B?ekV5bHhseHNTbURJOTRsQjR5TzlCV291OXdhenVnRWN2MjZwUmlXSGRLd01V?=
 =?utf-8?B?dm44T0VVRUQ4Smo2OGZjZkpWV1Yvd3NUU0NUcnladlVvY1pGM09Vd3NXWk5Z?=
 =?utf-8?B?ak0wUXhMOUhiZ2YwS1h3UmtmT2NYZkQ5bDR6Q2krVUFXNlBibms4eURTRzdD?=
 =?utf-8?B?R0MrQlNEa0wzWTYvZCtyY0tweTN6aHp3NGhsd2hlZ1NFRFNwOW9PY2lqc0FW?=
 =?utf-8?B?QnFpU1FhcXlZNi84Q0N2SHVVYlY5S3VWbERwNFJuUzhLRjJmSkUwNGhKNHBt?=
 =?utf-8?B?RGpYTFpZKzQ0amxDc2V5MjB2bzJEVDZZZ3V0YWlnV0F3cmJLTU5XaHh1T1FG?=
 =?utf-8?B?V1M2eXc0bzlDSWZNRjVwdDF2aEFTQXhHZzUyYit1aHVwWlZBejlPZTJlMzZk?=
 =?utf-8?B?WWU1Y05qZ3g0TnNhRFJOSUh1Q2tRNndVRS90UWF6SmpKMUlPUlFrV0lPbWUv?=
 =?utf-8?B?V2wwNXc2ME1BS05sYjR2L3BTbnVzMzhrRnFvRHpSbTVmcndWNkFwR1ptWXZh?=
 =?utf-8?B?NmZsbmpibzRsaVdGZnY2TVVJZzh4KzJkUThsak85Y0hyZGgzVDRFc2RaOTEy?=
 =?utf-8?B?cVN2dDJXN1lUZU1kUlZnSzJRYzV5SHBTeHpIa0tFUGE5MENIdFlHV2N4TXVh?=
 =?utf-8?B?djZyUlN1ZUdLVnBIMU0vS2VvTTN5NEt1ckpnVHZPbXd0YnQ4Ti83UWpxZUty?=
 =?utf-8?B?MW1ZdXRRbitoQmtxVEtXY3ZnV3R4QnJtaXlVTHczV3A2RWc1dXhnQjRldmpU?=
 =?utf-8?B?cEV2R1BsaGprcmJCN3Y3WWczOUZHZnhBb0M4VU5qNGdSVXJIcHJuTGxzM2tV?=
 =?utf-8?B?YmZycHBBUHU5VXJ0dFB3OFVHa1BwcFhIOGRTQUI4MDdtV1ZOZnVla2ZRQzZB?=
 =?utf-8?B?YWQ0YTN2eERtNVVtNmZrbEJJZGlPUzJaME4yNkhPdm5sVy8xeVdJMk5pYnhk?=
 =?utf-8?B?akVwTllISC9XaExjVk05Y2RWS1FXZEh5THgwSW1pQnBnaU5SazJQbjhJYVN4?=
 =?utf-8?B?d1Q5T1REVnk0QkNpSUp3bDE0NXVXYTVqU2hSalpSenZsTzRXeit0a0hvMTVY?=
 =?utf-8?B?YlVzdytiTW82c0x6dHluSTNoVmVLcEFXZEdDS1BVb2ZxVDFiWE90WGxNcGl2?=
 =?utf-8?B?aHRvZGFuSjJkbXJGV1B3WDgwaUU1UHZUZkFnMjNaREhHaVozcEtERnBmYm9s?=
 =?utf-8?B?ZnVMMDdrUlJaLzZOSkE0N0NUVVc1MVVsSEdHMVFnb3dmcjlSUCs4K01KMnJY?=
 =?utf-8?B?MndPWVN6YW4yK2tOOGlqR3dDUlNlbG1KNGZ0SndQejhCZ1B3ZWlUUEkwd2dt?=
 =?utf-8?B?REo3bm4vK2lKVUgwOFcxV2NiYzVKenNlaHE2RjNadHNVWVo3QkJ0NVJQRTls?=
 =?utf-8?B?eEd4cThTMUdDZzJlWWhoTkcwMm96WGpoc3hZS1ZtcDBwN0luZTV1TEFaNWVl?=
 =?utf-8?B?bmJRQmE0ME1rZ2NqZFhzTHlkNWJpLzhhWk5PTmZiRnM3UHVzd0NiWWcxU1Bs?=
 =?utf-8?B?a1dkVkkwcVBWVUozbzhPSUgxblJNTCtCQzhrWW9OK00rK3VSMVJqeFc2b2ZZ?=
 =?utf-8?Q?aZMVsJ9ZXJBmf5WB3i3cNQw5U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97765b98-cf13-4920-f70e-08dd8e3fc028
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:51:01.7276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGh7+9b0IPWFIM0a3qYYnN1k6HC4nk4RjEoTtWUVZdJ+VgaNiffIr5IzS4XuOsyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

On 5/8/25 16:46, James Zhu wrote:
> When XNACK on, hang or low performance is observed with some test cases.
> The restoring page process has unexpected stuck during evicting/restoring
> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
> 1. when xnack on, retry pagefault will invoke restoring pages process
> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>    B. if there is no enough VRAM space left, searching resource LRU list, and
>       scheduling a new eviction work queue to evict LRU bo from vram to ram
>       first, then resume restoring pages process, or waiting for eviction
>       timeout and try to schedule evicting next LRU bo
> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>    queue eviction will be triggered.So restoring work queue will be scheduled.
> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>    restoring pages is completed
>    step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>    until evicting bo is completed
>    step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>    write after the above two mm->mmap_lock's read are released, and in the
>    meantime which will block all following mm->mmap_lock's read request.
> 5. in step 2, if the first eviction bo's size is big enough for step 1
>    restoring pages request, everything is fine. if not, which means that the
>    mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>    eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>    the second and following LRU bo's evictiion work queue will be blocked by
>    tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>    process will be stuck here.
> Using down_write_trylock to replace mmap_write_lock will help not block the
> second and following evictiion work queue process.
> 
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 72be6e152e88..5f6ed70559b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>  {
>  retry_flush_work:
>  	flush_work(&svms->deferred_list_work);
> -	mmap_write_lock(mm);
> +        while (true) {
> +                if (down_write_trylock(&(mm->mmap_lock)))
> +                        break;
> +                schedule();
> +        }

Oh, stuff like that is usually an absolutely clear NAK from upstream.

As far as I know that is not something we can do so easily.

Would it be possible to wait for progress instead of calling schedule() here?

Regards,
Christian.

>  
>  	if (list_empty(&svms->deferred_range_list))
>  		return;

