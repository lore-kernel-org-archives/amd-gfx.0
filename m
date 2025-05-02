Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E37C3ABA3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 12:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E83210E8CA;
	Fri,  2 May 2025 12:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2CWQaj9";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE2E10E8CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 12:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP8SA/gLyGpDpjh7XJxccUJ8CVm9UG/xQlV3/CnDYVSp+fEIQXHsVRG6MF+a3KKtwWRzHr/AeM7SbvfIp0XxKn2gbeyNsoJKeShW/LokXca/ZjB4s3Lh8EFhDg9SRTFyvZ3yxY5lEiCnngiwM4yM9NF1wWBD3U3QlOCizAyDz4W6V4lXRmWbyIY1upiXGGdXb9qllHgJnn/dAQZE1rcW/bSK9ofd/Ge3P2WfNGuSB0keSNKUyjUnSUOywOY5nZLh95djlJu1k4IQ0M+M5gSBd9g3qRD1Q9RD1MxXXK6U1dwKvkZa85Bz9Bpo9NSsjbQHk5+ubycSjD2pwL0sdBC5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3tQAb0H9qY8WWXt/wSfEFMHfHxX8GOIjMsSXask1O8=;
 b=O7LXLx0aPUxxiL1aZbKdtH+eJvVjQ9mwngmsHAzVOWH52oODbaklsPrtTvlnGFkOK1YHOPPC4y7pSK8yeI+ugDpYlWW4VLJFR3d+R+1elgGOVH3fJA0E29i9Xa/lDTZ7gMYWiqMfXDuaFRC8GXUHflH6S4wr7s4fz83HDE+q9rikoTdZL3NzWAmT3p1/YvKbabpgscfLPs0s1JiitePL2ncoHA+Aa7XgB34hm+4yyUhAGgyMY1IcsM0R8wFZ6EvvOSw9t25r31n/+zoJMf/xGGHuPiHc02AOCJRxgqqPmVdOKpEO4qQBWl8O2Tl5JYp8cDc8gJNBW0bRzKTQQn91uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3tQAb0H9qY8WWXt/wSfEFMHfHxX8GOIjMsSXask1O8=;
 b=E2CWQaj9/hXPr8fPHEsGdzstVlvhiOBtTyZBbuugWIjc7EMOyzlqZevAjZyzrmAzVr0P/LD2c0/hzEltbiv03s9qXB705PIJvPdJ1+78ybQ/SWuw3hC4zr1FIUgyXbCVUbul3QsTUXMXLvuVeNFYuD/sucLb1bU+yxiuTK4FTTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 12:30:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 12:30:07 +0000
Message-ID: <7d6f16ec-0fde-4656-8f84-f5ba836e5f2d@amd.com>
Date: Fri, 2 May 2025 14:30:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/userq: Fix lock contention in userq fence
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0028.namprd15.prod.outlook.com
 (2603:10b6:207:17::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f956d2-eba7-49a6-3dae-08dd89751271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2JRbkRwRVhyd1Y0ZUw1RFU0RlJPR2ZPTm1SY0l3QnpLNll5TXdtaVRUa2JV?=
 =?utf-8?B?VWJESkh2RE1Wd1RQRVV6WGZSMktTeXcrMXJydUwzVW1yMWI3MEY4MnI5Z3hK?=
 =?utf-8?B?RXBkQzR4ekFhaldSdUhzOHpKS1IxUDllMDVCTXZMNmlobFRybjVDVnNWWGJp?=
 =?utf-8?B?TVpuZnBqMEd6UTA3dnBCbi8yYzliTitRVVJjQUg2eFhHSlBWZTVkcmM4aHdk?=
 =?utf-8?B?aVFEaEtURlh4M1dTbnZHTXN6VStKanAxWUp4aXcrUVVOZHI4eHJHMVA0RnBU?=
 =?utf-8?B?cjQ0MmloVGxyaGE0Q3ZtZngybHFRSExsRW5SYUM1SWdGOUlxSVRvNllmcDJ6?=
 =?utf-8?B?dzVraE1od1lKU3hkcTBSc1B0a2xEcUJacHdaQ0l3dXFteXdvc2pnVit1OFB4?=
 =?utf-8?B?cW4xSHJoR3p6K3N4Ky9kMmYweGFLMGV3Z0wyTExyS2dXdFhZQ1RKMFdGWXU5?=
 =?utf-8?B?SWx3L0hUYnp6ZHVoSk85UzFzTkw4QWNSK3QwUTRObVZCbXJkckNoNnpNcHhN?=
 =?utf-8?B?T2FGeWFhcUFhc2trMU9UdC9VNEdMaU93Unh0VmUyYjBSVkpyZTJra0JwVisr?=
 =?utf-8?B?K2ZZMW1EMk0zRjIwSkkwQ2xPZEFjS2JoZHZ0NFNwQTJHREhndXR4SnlHa0NJ?=
 =?utf-8?B?RXhkZ2JXTDZsL0pLVHdpbU5vWkhpSENJUy9OSlZBOExuTkdBMDd5ell6L0JO?=
 =?utf-8?B?b2RETWM4YjdWRjhVTDFZeGR3dUhNcW0rTDNWV203dDhuQUxWSVVCSGgyUGtT?=
 =?utf-8?B?TUpkazBSNkNDNXNHS2dWUU1udkt6TWwrTE8vS0o4L2p6VXJtWittZlE1aXhh?=
 =?utf-8?B?cmR6T09zbHNQQWpYS3VLTG9aVUZwQUx2RXBzRXNsK3V2Y3A5ZytzM09YM1BB?=
 =?utf-8?B?NEVPZ29RbEphMzVFU0J2aGk2dHZkMTNDOTJmTTJhSkFUSVRWL09qb3R6K1Zh?=
 =?utf-8?B?WmovSyt6N2hNK2pHblBsa2R0d2F0MkhXV2J2MEZYeWJVcEJyMC93VUxDcUZR?=
 =?utf-8?B?UVNCeEFYNm1QK2hqUlRXd3l6alBZditBemc5L0d6QWR0MFBSV0pBalhKWXo5?=
 =?utf-8?B?UlBEcG5IcVdWakZHYkxBbi9LaGhXOEVDTTY5a0VqcXo0MUt0aVFSVE1qZVJM?=
 =?utf-8?B?QmRIVFFMZzU3Qk14UUtJdjdiNnFEYk80MTNCd3krcWFCemhoL2k3QlR2dmlp?=
 =?utf-8?B?RkkrVjdGRXkyTWZTZWEyaDc2VEJlM1pxUlkyL0J6T21HYWRNSlNlUDhjMzNw?=
 =?utf-8?B?R3N0R3pvWXBucm9KVHdocGI4Mzk0WmoySzV6TlIyOEp5S2djYWJIOHdOTVlu?=
 =?utf-8?B?K2h0S0tUeTE4N2hTci9IMXhpYkIzZ1JyZHpYZTZoNVdwRkZBMHhmT0NUUjZC?=
 =?utf-8?B?cGNpb01xY2lBWW05cm9oUmN0YWpnOFlad1JVa2p1dEVlQmgxMzdvdVRSRGha?=
 =?utf-8?B?YlI1c21GTGp1TGFBcW16Z2NyVG9oaDRkWExDRlV5OWlGQzlIS2xLOGt3QXQ1?=
 =?utf-8?B?cnhka281TVVqOC9idUozdGExWUlpb2xjbTQ0L0RWelF6M2R0aVNnb2VxQWR1?=
 =?utf-8?B?VENORC9KVWtUTXdsdGJkNGJLTzQ3dUZyN3FqY3ZuMjZBS2NUbjFSS2FiTFFP?=
 =?utf-8?B?RUEvVWxtS0FsdE55REVuaCtNYUtwOG5zQ2JVOUtkTWVLY1FUQXlJSC9oUzMw?=
 =?utf-8?B?eE0ydkxZRElyR2pYOW1QeENtc29qNWtCZXV6OHBQK01LclNzcmFJQW4vZ3Yy?=
 =?utf-8?B?VVB3UUwyZWY4ZkxRaDNXTS81cE5XaDFab3BRcXFDZU9rNlo2azFRQ1pabEd3?=
 =?utf-8?B?N0ZLaDVpN3BKTnRWQ1Btd1Z1MTZsUWxBUk1YbnptTFNpMkpHRHlsMjdJeWJR?=
 =?utf-8?B?S01kTTM0YzA3bFBoQ3hHTnBDNk5rdUVZK3NJekd6bmo5R0hRVWp6dDRlMVNw?=
 =?utf-8?Q?SAX+cz2Vph4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFlQmJyUitEUEI0SjVsWjV3VWdCN3MrQTZ2dXF3TFJGSDFnY2NuNnBjd0Qz?=
 =?utf-8?B?c0ZRM0dlQ2QzWlFkNkJYMld5enBSMlRYUDdxQlZkU3EzdnNyNjArR2I2YmI2?=
 =?utf-8?B?QS8vSEdMRFpkZGNweG1yV3NiNXp5R1l4ZHM3cEUxWnF1SGJidDRhazVWZnZh?=
 =?utf-8?B?SHVNRndRZzV2Rlp0emVUMTlhKzdNSnUxZXFiSlBvbkpQY28xUnBoMnhkMjhW?=
 =?utf-8?B?U3hQckFxRlFlMC9lTmdwbCtOaDBONS8wUU1TU0R4amducGFla253RVNXT01J?=
 =?utf-8?B?SjJFQ0cwMDY1L3FZdTRoV0xXclNJcVVxb1lEb1pmL3FPUGcwbmgzZ0Y0b3RT?=
 =?utf-8?B?Y2NBU2hSVHlRa2lJdDVORTUyaXRDeVlkdGE4aEw1UDdvR0ZNa1BQNVhTZGhs?=
 =?utf-8?B?dXU1L1ZtMTREM3o2Kys3bWdRVkpKTDVBcXpzcjd5YkIxVDVWNzhuTVY3dE0w?=
 =?utf-8?B?bzRuUGlHK24rcEpKejY0U3kyZ040elA0amJsM1JWY2MrajZNNkFmTzRpQ2J3?=
 =?utf-8?B?TU1DTDVIa0tqT1lHWDhGK0JBSlFCaTBxNEF6Y3JEVG9JdmgwWTVCcS80Nnd1?=
 =?utf-8?B?RUpGc1lRK0Z4b3pRVmxuS3AwaldOUlpKVUhXWjdzUERmTk80QUIwYUdtSW9l?=
 =?utf-8?B?cnQ3a0tiYkViaHNxMkZJbHhDejR1TGRRdFZodGh2d1FwanZLRU5pZkpaRU0w?=
 =?utf-8?B?dWprR2lSMkdHclMrT0craWlVbDA0dDllbElFT3VnZU1qR3dUcGhnUXpRRjhn?=
 =?utf-8?B?c2IyMUxCYytsT0pwOGY2bmV2clVCU2FPMkVxbHAyd2hCYUxhRnVNOEdwUGJO?=
 =?utf-8?B?bHhCMm9uRFZiSS8rVVRoQ0RBQWw0WGU2dk14ZUh1K29hRkx0bVoydlpiU1h6?=
 =?utf-8?B?OXA5WVkraGFhU1Z0MU12emxWS25MVDl1eWUrNy9CUFZLUFdBTVY3RzZGNHcx?=
 =?utf-8?B?WkpFUHFhVGZzeS9JQk95Sll2N25tUk9adUpURHlLeUJqYlVpdDVUWWFxODhR?=
 =?utf-8?B?NTJzN2pNM1Zibm5CcDFKb1pVT2h2bUZpYXpVSnRpZ29qZmRuTHkrZWVFbkIy?=
 =?utf-8?B?aTNwbjBzTXV0dm11R0w2RWl0dlIvQklBWVpPK0RadDZSL1F4ODFDcmFnZFRi?=
 =?utf-8?B?Q3hjM2xaaDUxM09rdGo0RXVmUDRnRVN0QlMvZDJPYnF1a2dGN2VXc0NLWFRI?=
 =?utf-8?B?ZFllVUFTWVgrQ2RaRzBSM2VpZ2ZLU3pwNnhQZWNqekU4ZmFOTE92UGJnRm1p?=
 =?utf-8?B?QWRtcWREZTNDdG5lMjc5TnYycnI5bVRNbTRDakRYcUVhTHNkdGE4T3NnRGV5?=
 =?utf-8?B?Z0JMZ2hORld1M05SWHBmdTlIYzJUWHlBQk43R1BjcUk4Qy92c3BrYnBqREQy?=
 =?utf-8?B?aEZ2b1JBRlYvZXBKZURlRWV2cGZFdjN0Yk03ODFlNThGQ2QwRmVyTzhNT3k1?=
 =?utf-8?B?UG1HR1A2cXI1QVRmUGs1aWdYa1hGb2oxY2tEeHFrcEZONEtETnd2T2QxN0o4?=
 =?utf-8?B?TEF0ZEk2eENMTm1yVmVaUTkveTZGNXA3OHM3ZjZ2dFd1NEZOdU8wVkdhbVl5?=
 =?utf-8?B?b3l6VUJuV0FoT2xmMzJTRnJnaUl2TDZKTFg3ZnhDL29wSUppdFE4SVVhaUNH?=
 =?utf-8?B?QnFrU1RaZmNZTXYzMEN5SE15aW9mNkE5NEFyNFlJUWU4YzJTR0NOR0FRQTl1?=
 =?utf-8?B?NjJpczNFZ1lqVEJZQUlZTXorUm10eHhUWklUSkNZODVReWNwdE1PYjd4NTNv?=
 =?utf-8?B?cThhalZ3RDloU0QwM1dMUUNkTWtyQnJIQ3dQaStpNG5ua0czdGU2N0I4MWpt?=
 =?utf-8?B?QjUremxQbjFUdFpqOGozakZHMldITHFwbzBLeGRGbWpoQ3I1YkExdkZhY1NX?=
 =?utf-8?B?ck8rWEgzR01jSVNTdjVKYjloWXNXMjZrQXRUWFowa1BXYXp4cnVsQW54Ui9W?=
 =?utf-8?B?cVpHcW5GLzZuZUJOY3hpUk5EOS95NUlWek1uOEpncktNU1hOMGRiSnc1ampJ?=
 =?utf-8?B?Mno3b2ZIVlV1d1NqdWdneTR6WmRsZytqSEpMcFhGOUZBVE0xcEVtOWpValVI?=
 =?utf-8?B?cUYrdVEvNzRVZkFHVnBjTE12bTVCVk9lU0I2YjUxc2ZBR2RzV25vd3dPOHlP?=
 =?utf-8?Q?R81p+BDmPBwBP5q58HOxaXX20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f956d2-eba7-49a6-3dae-08dd89751271
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:30:07.2527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TETA2Wiaj+fwQWoECh0bNRtT0yOiE9YoI4Jibt28WeooFBE2AMTv7EvEQnBs8CvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
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

On 4/9/25 07:48, Arunpravin Paneer Selvam wrote:
> Fix lockdep warnings.
> 
> [  +0.000637] ================================
> [  +0.000004] WARNING: inconsistent lock state
> [  +0.000004] 6.12.0+ #18 Tainted: G        W  OE
> [  +0.000004] --------------------------------
> [  +0.000004] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [  +0.000004] Xwayland/1952 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [  +0.000005] ffff8884636f4740 (&fence_drv->fence_list_lock){?...}-{2:2}, at: amdgpu_userq_fence_driver_destroy+0xb8/0x540 [amdgpu]
> [  +0.000208] {IN-HARDIRQ-W} state was registered at:
> [  +0.000004]   lock_acquire.part.0+0x116/0x360
> [  +0.000005]   lock_acquire+0x7c/0xc0
> [  +0.000005]   _raw_spin_lock+0x2f/0x60
> [  +0.000005]   amdgpu_userq_fence_driver_process+0x75/0x400 [amdgpu]
> [  +0.000185]   gfx_v12_0_eop_irq+0x29f/0x420 [amdgpu]
> [  +0.000210]   amdgpu_irq_dispatch+0x2a4/0x7b0 [amdgpu]
> [  +0.000191]   amdgpu_ih_process+0x1e1/0x3d0 [amdgpu]
> [  +0.000185]   amdgpu_irq_handler+0x28/0xc0 [amdgpu]
> [  +0.000183]   __handle_irq_event_percpu+0x1bb/0x590
> [  +0.000005]   handle_irq_event+0xab/0x1d0
> [  +0.000005]   handle_edge_irq+0x1fd/0xc10
> [  +0.000005]   __common_interrupt+0x83/0x190
> [  +0.000004]   common_interrupt+0xb1/0xe0
> [  +0.000005]   asm_common_interrupt+0x27/0x40
> [  +0.000004]   cpuidle_enter_state+0x2ba/0x530
> [  +0.000005]   cpuidle_enter+0x4f/0xb0
> [  +0.000006]   call_cpuidle+0x46/0xd0
> [  +0.000005]   do_idle+0x367/0x430
> [  +0.000004]   cpu_startup_entry+0x58/0x70
> [  +0.000005]   start_secondary+0x224/0x2b0
> [  +0.000005]   common_startup_64+0x13e/0x141
> [  +0.000005] irq event stamp: 88271
> [  +0.000004] hardirqs last  enabled at (88271): [<ffffffffad9ca7a1>] _raw_spin_unlock_irqrestore+0x51/0x80
> [  +0.000005] hardirqs last disabled at (88270): [<ffffffffad9ca424>] _raw_spin_lock_irqsave+0x74/0x80
> [  +0.000005] softirqs last  enabled at (87858): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000005] softirqs last disabled at (87849): [<ffffffffaa67377e>] __irq_exit_rcu+0x17e/0x1d0
> [  +0.000005]
>               other info that might help us debug this:
> [  +0.000004]  Possible unsafe locking scenario:
> 
> [  +0.000003]        CPU0
> [  +0.000004]        ----
> [  +0.000003]   lock(&fence_drv->fence_list_lock);
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a4953d668972..24d19b920100 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -159,10 +159,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	struct amdgpu_device *adev = fence_drv->adev;
>  	struct amdgpu_userq_fence *fence, *tmp;
>  	struct xarray *xa = &adev->userq_xa;
> +	unsigned long fence_list_flags;

Drop that.

>  	unsigned long index, flags;
>  	struct dma_fence *f;
>  
> -	spin_lock(&fence_drv->fence_list_lock);
> +	spin_lock_irqsave(&fence_drv->fence_list_lock, fence_list_flags);

And just use flags here. xa_lock_irqsave() also uses the flags parameter to save the interrupt flags.

With that done the patch is  Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>  		f = &fence->base;
>  
> @@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  		list_del(&fence->link);
>  		dma_fence_put(f);
>  	}
> -	spin_unlock(&fence_drv->fence_list_lock);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, fence_list_flags);
>  
>  	xa_lock_irqsave(xa, flags);
>  	xa_for_each(xa, index, xa_fence_drv)

