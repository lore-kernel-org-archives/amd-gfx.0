Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EC5C021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 14:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BB210E4F1;
	Mon, 17 Feb 2025 14:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vaO+JsXB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340E010E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 14:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNAqRIwL5zyNq5UElqmYeBR93FPlO7+QCUL1SlyRoQPgAvSIx8t4XXhm0mbo8+vJfjKikaiKCHXo96glBNbOfI3V1OtxFQsK7aA7GHBKmrb3jj75r8CGfO3mLQYT5olpf6qdLS7y71/84aSuWhOLGkCKnwqjddd13ErQ6OQmOsfjrcKJdbeEmkaaPvqsrTD/bypcqGm73Z/q8obtza8KkDm6rxIDwl0sVcr8nFlFjGJLSB3U2X8TvZ3zTNARGuGlAwT+UANFuH7Xi1hP5nUeNdyt/XQWp9QEOyZ3f0b/P9nmZw81JF8E30Y6HBeXNttPUkepMs4JAUEyVK0kfagH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF432NzzncPR9lSVlWXBUHfc/yNhplnBdwvaM1HZnFc=;
 b=fbybG05x0AkQdJMD/EHQQ/RArKO/R8QEzh/ivJyHi95Qj7C7+WGnpkJfuAkg6oSDb1K1ZLkcE8dts+to/z3NQF/wMhfSNRmaqJ3dg93wRH8UPsBZYBJ75B8iJtXlXmL5kSHq16BbmQF4ie357lhCJhzkG6CMwTco/ODGOLDT2sOMhrnVG0jI1k47LkSPkY6/aNwz/pTz6EZuPpSZKD4k32YmdOQaWG7dq5bo1JOyn2UDp2EUxSlL8u1/ilFS07DPnnTkcyrEdzR0RYAZQttIhf2WVI4L7t998jsNtl4gnsZYaay+wbzq970qFa+sgvLoloi7BGf8KxX8ki4WVqBtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF432NzzncPR9lSVlWXBUHfc/yNhplnBdwvaM1HZnFc=;
 b=vaO+JsXBVlnA/3ots+MiZzE7pMs5QxUfXYw8S0QrY8bNGvOepe1IE0ZjzuOhvIm+vvSqC1Vcv6jC+a2dfnT93A2EeOFFx9PzGYUZVFM7ScypX6/bdpmcBnarSErmXtHOa7k/xy3bdLrps2S1mP8UKpMzaZ17ldpC9bjY+HUN7g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 14:18:35 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:18:35 +0000
Message-ID: <789dee33-a962-4824-b82a-375a36168420@amd.com>
Date: Mon, 17 Feb 2025 19:48:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: keep enforce isolation up to date
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250214173522.2373211-1-alexander.deucher@amd.com>
 <363007c1-064a-4017-abaf-a2b69bbc4679@amd.com>
 <CADnq5_OmnYXoc94h0LjG52wqwkOCAaB6eefYoqiJZY3k-hVm2Q@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CADnq5_OmnYXoc94h0LjG52wqwkOCAaB6eefYoqiJZY3k-hVm2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: b51442a7-57bd-4447-c2aa-08dd4f5df743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFgyY1NmN3FHQmtWdjlhbXNPbytveHJiRjdGQlFEc1FJMFl5TUw3djBVeVkz?=
 =?utf-8?B?L295NGsxSmtBWGw4dFpMeTBJbWM5a2ZYMThBUmp4QTZnL3VCTkRzYVdxRy9m?=
 =?utf-8?B?cFhFa0k3dERlRUdaWVVUU1NEODVPcCtLd00rNUphOXBvS0hzcHZnVUlrbUV0?=
 =?utf-8?B?ZlorUGt5eFlZZHN4eVdJMkI4b21qMjh3M01EMDk5SE42Y1FEZGUxNFlnRVUy?=
 =?utf-8?B?NFEzRW1iTW5EdjMzVWZLUG8wM1czdklQbytkNUlxL1RFN0dUUUlGNUZUY1py?=
 =?utf-8?B?WVo3Nnh6ZFhWN3VHa0ZNRVQxQjUwZ2d5SVpMcFZCZ1RnY01vSWNucU5EVjh4?=
 =?utf-8?B?ZkhPNnNjQ2NiQ2RIZDMyOG5GemFQRFQ0QW5QU3RKQXNnWjl0UDVrWG5iYXo0?=
 =?utf-8?B?VjZWbDRzdi9tTER2N0V2NTRHN3BUVXBpU2J2Z2F5enM5TDZQaVpDaDh5UXVQ?=
 =?utf-8?B?a3ZQUEF6b2tOVEE3Tm1DVkorREpmcHB6UDVSejJvbEcyYUNVWm85WjVNMU1l?=
 =?utf-8?B?VkZkVnhINXBiR0hPSUpxNExMU0lvSU4rYVJlT1cxT3ZhdFpJQmFHenpMNGVT?=
 =?utf-8?B?V2lXSDcvcG5oTnR2cXhyK01tZjBWZ3R5cUpkZ1pRZUQ5dWZ0RUxPNFdHbmN2?=
 =?utf-8?B?SkNIcjd1UWg5djRCZVNaVjMxcWMyR29yU0dUNE54R0x4cVJWYXRxSjd1RUp2?=
 =?utf-8?B?dlpUTmpidnF0b1A4NUlHUEdJKzVkV1J6bUNpSmtTTm1mbG5qTXg4YUVNOFdk?=
 =?utf-8?B?SkdYNER3dDd5WlluUG5Gczc4bnVqc1pOSlNDRjlsRGdDaG4yb1dpZnFJTEx1?=
 =?utf-8?B?VVFBMzB0U0xKS3JNUkJDdmo0K2VtR3JqZlZyWXJQbGRlMU5kN2VPT2tNS1cr?=
 =?utf-8?B?eTNwVWFvUUJzZURDVFNLTU94ZzJKWEYzYTg3dmxMaVBId0NmMzhpc1VzWG1P?=
 =?utf-8?B?Qk85UTRnb0NOSy9xU3gwVm9yYXJ4ekc0QjVNYityK2x2WSsvU29JQnE5ZFBw?=
 =?utf-8?B?UlIrN1laVG1mbkhjSldvUW04QWZ2cWNndXFFaG41ZmU1STF4ekVCZzdPalQ1?=
 =?utf-8?B?YzQ3Q3ZnNHhlOEJLQnRpV2pjbWJaejlVWm8wWHZDSTlQWUFDMDJWbURWMVcv?=
 =?utf-8?B?WENKNmpMVWtrNmZOekE2RzlNemhRMXpvSGJkN2NmQVNuQVJzYVN5Y0Uxa21p?=
 =?utf-8?B?Q2lUU1BLLzc0VEJBQ2l5K0pHRUFZUUFKUmY5d0R3UmpaVU1tNFpON2xGcER3?=
 =?utf-8?B?ajhPekZpK29aNzhHdzZGWnZUd0pKL1Nvd1FBUXU0SzAybUpnR0t6VGdNTzdS?=
 =?utf-8?B?L041eEt1WEhGeVI4QmZPY1ZxbS9BVDlrNEVqZm9LZ3JMWjlTQUVWcVI4MDlJ?=
 =?utf-8?B?Tkp3clR2Q3VqVXdNWVEyOVczTzlZcllOSkpIWVNsOVd0S1F2L1pEeFE3MGxi?=
 =?utf-8?B?a285NlNjOGZ3TWZocWJuUUFNSDlWLzA2MFNOMDR3SW8wc0wyNmhFd0lROWdx?=
 =?utf-8?B?ZnZ1M1hhTGd3TTJxTDRxb2JQanZqdTV3My9GbldyZ2EwOWwrbnc1UVhkb2FC?=
 =?utf-8?B?UURNV05UeWNxMm5xZzFPVmhUYld3Y3pUUFU5aE14K2hvek42MzBsNHpYMGhL?=
 =?utf-8?B?OUNoanRURC9rWmN5Z01GNjZZb3VIcFZxemZCUXVBR05nazdkNktZazFDUUdo?=
 =?utf-8?B?NzFwS3RQeWhncVovZ1ZtNTNZV0RoOEpPTk5KdWtEV3hLTTI3Q0pmN2lTcVk5?=
 =?utf-8?B?MWpYUnExZ09TWFN6VmUwR3lRWGQzdTZpNzNaa1NKZzJZWEhCRlFxKzNqcUFp?=
 =?utf-8?B?OG1YcHpTVHBEMmREQ1NocnRLTWVHQTdTc1JzNFg0QW5nZ2tlZXo1MGpSdzdu?=
 =?utf-8?Q?Hq0lhLZ3qrazj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZ4Mi9jdm56Z0lSaHFmaDlYTU1BaFRPVnBqZ0ZjRUxUUG0zN0dkak90VHBn?=
 =?utf-8?B?UER0L2xmZUphS0hYZXJyM1lOaERvUzNNUE9PVkNOTXV5eXFTY2JMMGtyK0pR?=
 =?utf-8?B?VEM4VXZQRDZtZndiMHg0U1RjMEt6ZndrS1NGSFVPdUw5SzR6TlFzVWsxUHlS?=
 =?utf-8?B?ckdDeVEzbnROUUU0SHdlUFdncVJmd0VTMmlrNDRNVGJSRGJOL0orenV4c0N4?=
 =?utf-8?B?V2thVE14SjhxRmRYTlBqbFloTm54SlZEVGVXc0ZNQ3FHTGp6S3lBcjl4b1hP?=
 =?utf-8?B?OFAxZHpFV0h5L3hOdFJZVkxUQkxKWGxWRG42aGU4SUpEV2VJR2k2a3kwbXlx?=
 =?utf-8?B?bzhQeWhQaUMwUFdqYkJBMEQrK1Vic3E3RmRWdDdVQkNncDNFeWZaRXFacnJY?=
 =?utf-8?B?WjBjaDB6SFZHeExPcjQyR1h0VjNIMytpUTNTbS9jSHZMQmgyTGZkNlBzYnFV?=
 =?utf-8?B?dEhyNExRMHcxdmhWS2ZHL3JDdlg5WjA1NVNGcEhUUHNGbElEbDI5M1c5UUJS?=
 =?utf-8?B?SkphMHdOUy9Yd0RoNzhRSTlYa2dUMjVzRFVhSlM1K2V5NkwyWkZNMjgxSXJi?=
 =?utf-8?B?K1BqTzJPSVVTRkxTd0N1SGNZVStzTmNFcTdKOEtiT1VBZ01OVjFBczdFYng0?=
 =?utf-8?B?VmJtcnVNME5odnR3ZytZTjdmdEE2OEU3c1czWWo1b0N6U01FS2hVTGNmZGtX?=
 =?utf-8?B?OGpscnVKSlN1V01LczZuelBjTU9wSGdpRUJnWm5TWDNmM1QvdENpa1BWM2E3?=
 =?utf-8?B?dXhPZGlVb0I4UzhFU3J5dUZpdHo2L3lvSGNMYVNIQlFsQlhwSnZRWmZnazNk?=
 =?utf-8?B?L1Q1YkZtTGdZa2RZK3ZtWFFMQmp6Y2RuYkJodDJ0amwwb25Gc3JRSm1aaHkx?=
 =?utf-8?B?ZDFlOWVid2lua3JXUmNGWkRjWXc4c1ZhKzgvaHMycCtuci8rZlV2SXhZUDRU?=
 =?utf-8?B?RnM0RnJEUGNBRFZSRXdUZEVKS3VKYlBOTVZ4dzZjeVhEY1ZUSXVpbVpvK2N6?=
 =?utf-8?B?UHhZM29VT3NxdENRN3RFQlowcXBsYWdYYTZpRkVPb1V0TXRVcjdBN2VJalJN?=
 =?utf-8?B?bm5mb1dqOEp2eFhMTU5yRlJDekM4QkN5UVRRTHhvSW1VNjg4Sm1CVk1ML3Ey?=
 =?utf-8?B?NnE5WWZ3aGlsakZYNUVLRU9ranIzRUtoVHZkOUpCTVh5alBaSDd2ZDN1N3Mz?=
 =?utf-8?B?emhJZ00xVUQwNEcyUnN1bE1KZ3o1NGk4SmhSR3FMNTRjOGVpRWdhNy9FZW4v?=
 =?utf-8?B?ZTVYL25iaUlsdHUzelBiWEx5NnE5U1lFek8xSlpPQXYzVGFaNy82Vnh3OGhJ?=
 =?utf-8?B?cDJxd1VkVjRSS3BOVThrWmQzSUNZajlJMU1sVytzUkRyUVF6aDRrQnYzTVhi?=
 =?utf-8?B?dmthc3hVdkhXdEw1Skt2dkgyMVpSRlRUbkRGY3drYlFQKzVnTE95TDJhalFk?=
 =?utf-8?B?VDhHWWx0OVloQlZ4aWlQRjByVElOd0NIRGpsZytWeEw5S3R5ZmVaZE55Tm9U?=
 =?utf-8?B?WDhHSEpTNGNLdkREMU9HbGZiazNVbGFtN3BLZkoweGhLeTlpcXU2VUJHQkRl?=
 =?utf-8?B?d2NsSjNsSE5lM2xBWEJlT2dCWmREcHgyZExxNDcwZGl4YThOUW5mVFdMZVhZ?=
 =?utf-8?B?WDg0U3Z4NStxOFZqazFDb2ZlRlJYODJBTStOOXIwVitqYlE0T0FXRHBPejVy?=
 =?utf-8?B?dDJTNFQwYWt4ekE2dGZldEkycGJzY2hpTjVCOG1MK2ZTMjY0L1N2OXRwdklS?=
 =?utf-8?B?VGFqMGsySmlZcGpZOUxKQTJITFdZbFBKN3UwRVpaZEZtRG1GbnYwcGJNWm8y?=
 =?utf-8?B?TUltWHIxVG9LMFVRaXUydExHQUZmNmZWcGpneHRKNWdYOTI1K0tpNzdOQTd5?=
 =?utf-8?B?d3Jldk9XQkxHbkRsdXU3YmZZNUtYTXQ0b29zWFArYUVqb2UzZXR5MnlIWTFt?=
 =?utf-8?B?SHFldnUwUS9OSjJYTlZWZ3FiczJWZ0tZUkZVOG9HR1NSWit4M0E3bTRQbWV0?=
 =?utf-8?B?WjEwTllld3BUekZhVHFBdVpOOGlzSjN2cElCWnkyZUl2a2FYbW9YM2pFYmtL?=
 =?utf-8?B?NVd2aWpVUktFS2E2VDdKMFZtVUwwa1FzanFHOVRmaThzZVA1UDlxWktOakIy?=
 =?utf-8?Q?Fv6bLj3hu87sLOlbUE3Cx2YWP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51442a7-57bd-4447-c2aa-08dd4f5df743
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:18:35.8716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivqe2zTZsF0iv4N+ozWXrvA5QBGWwVtCSwFBdBMLM2s4uDqlxMdRhfgZoXbo/+muvdpxcf3piPL5kJ3KEqaLfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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


On 2/17/2025 7:44 PM, Alex Deucher wrote:
> On Sat, Feb 15, 2025 at 3:02 AM SRINIVASAN SHANMUGAM
> <srinivasan.shanmugam@amd.com> wrote:
>>
>> On 2/14/2025 11:05 PM, Alex Deucher wrote:
>>
>> Re-send the mes message on resume to make sure the
>> mes state is up to date.
>>
>> Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Shaoyun Liu <shaoyun.liu@amd.com>
>> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 ++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 20 +++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  4 ++++
>>   5 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index b9bd6654f3172..a194bf3347cbc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1665,24 +1665,19 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>>    }
>>
>>    mutex_lock(&adev->enforce_isolation_mutex);
>> -
>>    for (i = 0; i < num_partitions; i++) {
>> - if (adev->enforce_isolation[i] && !partition_values[i]) {
>> + if (adev->enforce_isolation[i] && !partition_values[i])
>>    /* Going from enabled to disabled */
>>    amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
>> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
>> - amdgpu_mes_set_enforce_isolation(adev, i, false);
>> - } else if (!adev->enforce_isolation[i] && partition_values[i]) {
>> + else if (!adev->enforce_isolation[i] && partition_values[i])
>>    /* Going from disabled to enabled */
>>    amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
>> - if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
>> - amdgpu_mes_set_enforce_isolation(adev, i, true);
>> - }
>>    adev->enforce_isolation[i] = partition_values[i];
>>    }
>> -
>>    mutex_unlock(&adev->enforce_isolation_mutex);
>>
>> + amdgpu_mes_update_enforce_isolation(adev);
>> +
>>    return count;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index cee38bb6cfaf2..ca076306adba4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -1508,7 +1508,8 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>>   }
>>
>>   /* Fix me -- node_id is used to identify the correct MES instances in the future */
>> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
>> +static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>> +    uint32_t node_id, bool enable)
>>   {
>>    struct mes_misc_op_input op_input = {0};
>>    int r;
>> @@ -1530,6 +1531,23 @@ int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_i
>>    return r;
>>   }
>>
>> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
>> +{
>> + int i, r = 0;
>> +
>> + if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
>> + mutex_lock(&adev->enforce_isolation_mutex);
>> + for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
>> + if (adev->enforce_isolation[i])
>> + r |= amdgpu_mes_set_enforce_isolation(adev, i, true);
>> + else
>> + r |= amdgpu_mes_set_enforce_isolation(adev, i, false);
>> + }
>> + mutex_unlock(&adev->enforce_isolation_mutex);
>> + }
>> + return r;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>
>>   static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 6a792ffc81e33..3a65c3788956d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -532,6 +532,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
>>
>>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
>>
>> -int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
>> +int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>>
>>   #endif /* __AMDGPU_MES_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 530371e6a7aee..fc7b17463cb4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -1660,6 +1660,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>>    goto failure;
>>    }
>>
>> + r = amdgpu_mes_update_enforce_isolation(adev);
>> + if (r)
>> + goto failure;
>> +
>>
>> Hi Alex,
>>
>> Should this also be moved to mes_v11_0_hw_init. Please let me know your thoughts?
> I'm not sure I follow.  This is in hw_init.
>
> Alex

Sorry, my mistake mes_v11_0_sw_init pls?

Thanks!

Srini

>>   out:
>>    /*
>>    * Disable KIQ ring usage from the driver once MES is enabled.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> index 6db88584dd529..ec91c78468f30 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -1773,6 +1773,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
>>    goto failure;
>>    }
>>
>> + r = amdgpu_mes_update_enforce_isolation(adev);
>> + if (r)
>> + goto failure;
>> +
>>
>> And Similarly here also?
>>
>> Thanks!
>>
>> Srini
>>
>>   out:
>>    /*
>>    * Disable KIQ ring usage from the driver once MES is enabled.
