Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E062ECEACD6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 21:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8050110E266;
	Fri, 14 Nov 2025 21:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQjEy1pX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819FA10E266
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 21:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFi5o81NYaA04Ut0Jr7a21nc1IuASKG0ZZMdhJMTycO1MywYUPlnQZderlmwe9dtX9sIPKm+9+FjOcPWMYihne3sAx8Zkb1RtD/jfoUM9LcOMxHHcOR9zRnNgsgtpE/8P9oFxdFMthodQXeq4rrTyoYO3+ihnOotpQlwJkLhKg7Z0ZRrCZQ4laa0Y1mE/aNu6BzEGDCtxtDGc4JGpfG0Tn8wTfLUVd7kQvX+AJ4nOi/pzb6ZK3dtHn865rujQxn6eLn32/rKh9xneN/is7ewtuhPkVS7eeiEQyVOYDUm1NfRzBc0wwjlmAy+qdy72slyLfMyUtPdi3394szi0Nvvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y33P/ZN+3SrR+mnzI9Pj94mi8/L8m+V4/87iE3Ceueo=;
 b=mhBLge5roTp79h5d8fgvpHqDAtDFN0QJcG7dbJWJ9iNdq6czUPiOWtB6b5iuey+GuxpvBekf8l4fiFkZrsy9dGfA8t91IKH2iOtgt6PAm1LMmawfLbEMLNFVZfpPfmqawP13Ty/d2mcwJOZ4+14C4gm+IbwsgtBZ6H+z4jlyRDftrLVBrfsvNrFceIbaPSn5B2XPcXE5WQAwdiFu0VqGZe2glKjRB+Hrkz4UaZ0ZmyjyquL+EAAekEws/1z8rrUHlrM8RHBYIXdDfJMtUlx3/fCIXiBmmH7Gk/9eAyWla1yaofJhG3SwGQn7IjVdufAL0eb+w5TfBgWddyYkwngKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y33P/ZN+3SrR+mnzI9Pj94mi8/L8m+V4/87iE3Ceueo=;
 b=lQjEy1pXHFVDStwB7XZz+Jf/ogC1FrTzZCRKzznWc/HtTj5B1I0q5DAZcTG1uwhkbS/s02v0rtCe6JMfW+2Sk3tYp9GOLxibnHYU0xW2aetZukxl0W7zWmLiebmkod3sOwCDxHlVZSNtHzD+PIPFpatvv5NnrB3WS+plYkqZwrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 21:47:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 21:47:44 +0000
Message-ID: <8f5fead3-2f4e-4352-a4d1-2d316bdf23f7@amd.com>
Date: Fri, 14 Nov 2025 16:47:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: FORWARD NULL
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "Martin, Andrew" <Andrew.Martin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251114144033.1432008-1-andrew.martin@amd.com>
 <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aef6d1-3c57-401e-8e6b-08de23c771a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SC9YY2RMdENYaXZPNlBOYjZ6QjVUOWozU3JERjJWaWsrdTgyVm9qazJwTlZW?=
 =?utf-8?B?QWNibUxoM0hQdDZycEdjdVpUbXF1SmxNN1pwNnJmVWZtNnZiaWZvZDJXWHoz?=
 =?utf-8?B?WERsczdvQnh1ZGJhVFRiOFFkZ2xIcERkbXdpcG0yWERBVDh2czRDNUdjYW5q?=
 =?utf-8?B?RC8wQjUwaG9DNlBTRFNHdnEvUGFPQkVEYXNCV2V1R0o0T0FzUDB3TjNQS1B1?=
 =?utf-8?B?K05iSjNsdVduVzltajdCbDI2Mkxoa0VSU3ZxUkdPdzNreFg4UW5MNVM3L3RL?=
 =?utf-8?B?VzJ4bUJZLzVzNlRMU2FFeWUzUDdyWWFRU21IM2d3dHQ3bGl4ZXpsOEZFQlJa?=
 =?utf-8?B?MDFSTGlHeERzdCtCUUJ0bURCQjNPU3M2cG9yT0Z0Ly9JV3VEblRCTUw1cGc2?=
 =?utf-8?B?cGtYdGdvdXhxN3l0WThWN2c3OGN5OGxEVk85a0ZlUzNyN2FqY09BQjNtUWM5?=
 =?utf-8?B?OHZ3Znh2Q1JqZHFiUjB3WXdRSHU0Y2FtK1RmZFRCSEdRTmYyUlhVTUNIOEFB?=
 =?utf-8?B?Q21CakFnOWdDLzFHMEQ0U0hpMHNDQlR3NWFDSUJxcERXdktPUkMrWjhVYytj?=
 =?utf-8?B?aFF5Kzk4VnRiU3BKd1F6V010VTF4UW1UMFFTZ0RxMlpvZlJSM2UvY3RYSnBv?=
 =?utf-8?B?ZDBKemo5OVExcHdydHRBS1FxZlhRN1JDa1BHNFl4MnBINThJNHhoSGVTTlky?=
 =?utf-8?B?RGpZejFxN2RaR2ZmUVhidnVpQ2xwSUs2UmROVTlRcW9KRG9kSmtEckFucEE2?=
 =?utf-8?B?czd5YUZFUzZVRDJuU3A5eHoxTzQ0K250SE9OLzhJUFlGMDI1VUV4Lzh2dlA0?=
 =?utf-8?B?KzQraHdjdXFoNVJMb2RNSDQ3R0NTRnNLcUxHQnZIcHBmSkp0SnZnaGFnNWc1?=
 =?utf-8?B?SFMwZDJaSElXbzhzSDJER2t3YloyNDcrbVlFcE02T24xWjdpaWxSY2hZUHk2?=
 =?utf-8?B?WisyWG16RDcyWHFRNW9YSXdGSXRlRldONytkeTRhdkRWVUpBTG5pKzNBYmtV?=
 =?utf-8?B?cDg0YU96U3VmbzM4Vk55Ym92VkpOSDlvb0VrTnNXUGh1YkZERmVUNzJDckU0?=
 =?utf-8?B?SHRJRjU5dHN3UlVtdkZDek5nbTV6TXc5dHhETXVOSTJTMDR1Yy9YdkM1bmFy?=
 =?utf-8?B?U3U0a0R3QWxhQ1JVRXNaakp1TDFSY0J1anVpRHlsWFBXZ0tGU294dENmV0Vi?=
 =?utf-8?B?ODJZNnMwelRnZ1haaUQxVjduU3hiMTFjMXFuV25vdm5NV2djcG5KVEVnZUNP?=
 =?utf-8?B?VzhKT0I3ejBDcjVjVGdYSm83ZWhhYUlBZVlvZmNMVldKTzJ2WkZWcVRKbEdU?=
 =?utf-8?B?RkFGUVlLYS9iSGhnSFBRMFBxendqWS8veXdKSC8zdFU1bkdNTTN0cFpvb0RJ?=
 =?utf-8?B?V1dzOVdoQm9XTS9YOFZVQkxOUUk5R3pJR1NvK3NaQ1lmUnI4bEdjSjUvcFd5?=
 =?utf-8?B?OHAxWHpkN0dJSWlvOFJTVXQ3SG02SXBkbU9DME1FYmUyY0NYVnJVUzR3bmI4?=
 =?utf-8?B?NmNDV0xFUDV1QTREdE5wc09YRTN6b05yczI5dE91SnA3Y2xQWHJhaUFzWDgw?=
 =?utf-8?B?TVcvZzlySkN6cEVCWU8xdzkyTDNUQUw1V2xnMWJJTi9ET3RkZUFFOG9zTUxm?=
 =?utf-8?B?ZmxkOGlZUEwrMG04TE5VcUNObDQzajErNkdXSnpuZHc2aGVGdW52WGVML2gv?=
 =?utf-8?B?T1hoN295MkU5ZFB2YlhLWkdDQ3hUUUtLMWx6VUtsZVI0WTRkeldRaXlWaXo4?=
 =?utf-8?B?MVF2ZzU4STU2aHZnQTBCelJFNUxZM2Q4elhsMUhSTDF2ejlWMEYrRGVEaVJR?=
 =?utf-8?B?bWZXSHJQamZhZDN5SUoySDNnRUQxR0pjM1EwTnkra1M4b1cvZEV6ViszcjFU?=
 =?utf-8?B?TjV1bVBoZTdkN25aMW1OYnZlZlZ4ZVp4R0hySzZrUTEyd2Jvblp0QTdwQ29q?=
 =?utf-8?Q?QXeReqZVRsrlmOlN+RK9CTNi+1St3+d0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVKaUJ6MERGMjV3M2VCbzdBSjJaOHVBSWx4V2plMlVRKzRIeGJrVjNuUHJE?=
 =?utf-8?B?eGZvbnErazBnVXRuanNIZ1B2VjU5N0pTK3FkeWo5S3RWTHZreDlyNjNQT0pS?=
 =?utf-8?B?VEc4TVNGTG52SlJZR3ZOdkxGd2tUc2RJMlY5WjllT2paTmtkd2V1NEFoWHFz?=
 =?utf-8?B?Z0VwcW0yd3Rlc3BTbWRGZUFjdW1ObXpyRm5teXVmdEpZa1FFYlJwSGxMOUZY?=
 =?utf-8?B?MWNlRjBjUlRxNk84aWtrZEpod2YvdHBydER2Zlp6cW04YTBvRW5LWUpyVVdm?=
 =?utf-8?B?Q0Uvc0xFalRPdEVpMVhrdExJaUp1d05pZFRXaXFWamdBWlcxZ2xNQVUrTUJw?=
 =?utf-8?B?Q09nWEJQbzUveEorWWl3ZmhtbE81VFRnbVA0R0V2UW9FNkpUWllOOXVsRnFX?=
 =?utf-8?B?Q1dFcTRudEwyVkVsQ0R1QlFsOEd0UGhMRUNCRmdUZ1YzMzhhOW9Ta0tza0dN?=
 =?utf-8?B?ZXB1TzJzYXlsakV6TlpMZXF4YzVTYjFITC9UcVBLVnJOSndXRHMrOGJzMUk5?=
 =?utf-8?B?ZlRCanpmNy9XUDJBZ2taNWN5aCtaSnhPdW54alo3eTcrd1R0Tm9YdWpMNzV6?=
 =?utf-8?B?bGQ1WU5MdU56ZU96TFgyemY2UXNBQjlJb2IwaGpqTmJRZlJPcUd5clUxK2Qy?=
 =?utf-8?B?Q0ZvV0loRDNFK1FLbTNkZ2ZOUWtSQS9hT29ScUl1SEhIcG5vd291VnhaOVZV?=
 =?utf-8?B?UHYxbjROcFhEamVYSTZDczAvVmo1L01abXFXZEFqUk5yNEUvTHM2c3J3KytK?=
 =?utf-8?B?SG5PUHdDOVZDdi9IWTRSVk5PRGtNZzJWMGtCZW94Y0V4c0d5Sk1ETTY2bEZ4?=
 =?utf-8?B?a1RrVjZwc0NXRE9pbGo2ZEQ1VHRXeEVqSlVIWitvdjBodFcyanFLSzFpclh1?=
 =?utf-8?B?cW9nMVJMODVHdmI5RncyeS9yeVlkODVxUHpiMkJmTUVuUHlTYlFleHJiWXNF?=
 =?utf-8?B?c0VHMFJEMzZLczJ2V09sRkFhL1RaTW5BN0s4MHZPdW1YSFpnWXNQM0xsdkdp?=
 =?utf-8?B?TDFONjRPL05xbTV4eSswSGg4czMzMWdSL2l1d081bnBBOVZGbGh2U2I1M3Y3?=
 =?utf-8?B?OGt0OGhlbFpIbEFCNi9VTGJUbk1XZDBKSGcrMVMrUlZXK0daWGh4NHFLNXEz?=
 =?utf-8?B?eEl2T01jVEhKTDZvcXBTWEpEOTkyeUd1R1RzcWcrYnBhdU5naFN3djJMYmtz?=
 =?utf-8?B?cUF5Y2xvcFhBTUlLeU0yNE9nR3VLbVcrcCtMUXNaWVNKNC9tcDkvczZrWElD?=
 =?utf-8?B?OVU1cmZxY25RQ0JsTklsYzhpOWJ4SFpBUmdyd0ZMSFQzaklNSzRLcis0WldI?=
 =?utf-8?B?aWVzT3RhUEwyYytWMlpzOWgvT09maVVSSnQyKzFOdTZMTVlwdjdOVU9mYnhS?=
 =?utf-8?B?MHNPK1ZUelg4RXh2aFFFcXVtUkY4MHYweHQ1ZXI0SU1aUzNkSWVxMWpmMElY?=
 =?utf-8?B?Y0RGamF5d3pMRmRQQlBwVWo2YndhUmVYU1dnOHc1UnNGZk05RFIxNitrc01n?=
 =?utf-8?B?Qytybzhhcm1WekdyaHJYeEVyODA2ckNHVW5xN21reTlKek5TcTM1TEpTbkFY?=
 =?utf-8?B?WEtyaGM2NDhuakdPOGpFUXRGZk5uZEFuTzd3MGM1MmJWVlF2eW02K2hJdjgw?=
 =?utf-8?B?K3orbm1hd3kvQjlGcU9CaVZhakJMVDNSelp4SjU5c1dSS2R0bHRxY0dUN2l2?=
 =?utf-8?B?d0EycFJmajV3UjgxdU9BNDB5MjBRTVRDcGVXeWFsVEZtRllmQ2RZbi9nanJl?=
 =?utf-8?B?YkVPZmZ5YzgzL2VGNXlxU25EdzNZWURNN2ZZdXpiZ24rTlViNk1McGphWnNR?=
 =?utf-8?B?dFBrVmpoTGtCTzJQaDNyc1llcG04WTJjTzBHK29QYWxBYjk0TDhhWnV2U1h1?=
 =?utf-8?B?ZkFZaFg3d1NLV3VwT1hTbEtYTHlsSWQyZUVpSW1HU2JIZ3RGZ0xrWTBOaWFo?=
 =?utf-8?B?blBJc2MvZC9aN01CWDJ5WUVWVlRvdWZpVnlxMWFCZFc3WlVuckpKVnU0M0p5?=
 =?utf-8?B?SXB0MVlkcjRDeDcxQXRkd0xaWGFsN2doSXd2US9pdFgraklDY2FGT3YzZ2dK?=
 =?utf-8?B?QmtyMmNRQ2VsSGQ5Qm9TT3ZrN2RTR21XSWFzNUYzMDU0MTBzWGFob3huVytL?=
 =?utf-8?Q?5Vf/G6iEFN9zdSy7w/3/EeS7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aef6d1-3c57-401e-8e6b-08de23c771a3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:47:44.6678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mBL+/ORsCAZ+a9dSnG0GX2u2d1w4acaN7tNuDSverbL2WuwAs/ZvqASgVCX6vvup9HnOBsdAzMNAPeTWh4xPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

On 2025-11-14 12:02, Russell, Kent wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew
>> Martin
>> Sent: Friday, November 14, 2025 9:41 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Martin, Andrew <Andrew.Martin@amd.com>
>> Subject: [PATCH] drm/amdkfd: FORWARD NULL
>>
>> This patch fixes issues when the code moves forward with a potential
>> NULL pointer, without checking.
>>
>> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 6 +++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 +++
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> index 1ef758ac5076..71b7db5de69f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> @@ -104,6 +104,8 @@ static const char *amdkfd_fence_get_driver_name(struct
>> dma_fence *f)
>>   static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>>   {
>>        struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>> +     if (!fence)
>> +             return NULL;
> Felix can hopefully confirm, but we may need to have something here, since the references here expect something. Like in
> #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
>           job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)

For amdgpu Job fences the above makes sense. But KFD fences are our 
evictions fences. There is no job associated with them.

I don't think the NULL check is needed here. to_amdgpu_amdkfd_fence 
returns NULL if the f is NULL or the fence is not an 
amdgpu_amdkfd_fence, based on the fence_ops. But we're in a fence_ops 
callback here that should only be called for amdgpu_amdkfd_fences.

That said, if you need a check to satisfy a static checker, I suggest this:

     return fence ? fence->timeline_name : NULL;


>
>>        return fence->timeline_name;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> index ba99e0f258ae..42fa137bdb2f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> @@ -517,7 +517,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> uint32_t *flags)
>>
>>        for (i = 0; i < target->n_pdds; i++) {
>>                struct kfd_topology_device *topo_dev =
>> -                             kfd_topology_device_by_id(target->pdds[i]->dev->id);
>> +                     kfd_topology_device_by_id(target->pdds[i]->dev->id);
>> +             if (!topo_dev)
>> +                     continue;

This loop checks the capabilities of all the devices. If a device is not 
found, we should assume the worst and return an error, instead of just 
assuming that it'll be fine.


>>                uint32_t caps = topo_dev->node_props.capability;
>>
>>                if (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
>> &&
>> @@ -1071,6 +1073,8 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process
>> *target,
>>        for (i = 0; i < tmp_num_devices; i++) {
>>                struct kfd_process_device *pdd = target->pdds[i];
>>                struct kfd_topology_device *topo_dev =
>> kfd_topology_device_by_id(pdd->dev->id);
>> +             if (!topo_dev)
>> +                     continue;

I'd return an error here as well, because we obviously don't have 
accurate device info.


>>
>>                device_info.gpu_id = pdd->dev->id;
>>                device_info.exception_status = pdd->exception_status;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index f5d173f1ca3b..f40d93f82ede 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1685,6 +1685,9 @@ int kfd_process_device_init_vm(struct
>> kfd_process_device *pdd,
>>        struct kfd_node *dev;
>>        int ret;
>>
>> +     if (!pdd)
>> +             return -EINVAL;
>> +

We generally assume that functions are called with valid parameters. 
With that argument, we should probably remove the check for !drm_file 
below as well.

Regards,
   Felix


>>        if (!drm_file)
>>                return -EINVAL;
> Probably easier to just combine the !pdd and !drm_file into the same check.
>
>   Kent
>> --
>> 2.43.0
