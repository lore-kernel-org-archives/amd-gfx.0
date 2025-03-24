Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68175C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 21:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD5510E4D8;
	Mon, 24 Mar 2025 21:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FUYLiE1/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9507810E4D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 21:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX22qfRexUGoOHfIL8Wu86dITuPBprlC91WTSw3eosvRi1iDcfXwsjkC5YOMR932Ot2TAoEefK2i3xhfoRzcozLW4xSH2l1yrY+oXpJZoQw9a6h+Zt/D2EPuXrpsYwsam/Bj+MPX0LeRi7xt6fMAJDJFEXHG9ZYrC0diBune9B1ly5Db3mHWK9ohEhANLbEklNjMT1DnjS3YBLc4WJtxxVi9epy7MaNBByz7rhhcaeMXoLp1yXBibGx3H++BBDIBGkzMOsiNQWXz/dxhqcAV/uqCiXOmJpw8GP47za3NscneU8UI8DLt/E0C/XY3C20MRi8XmezTC1Y91BpvYD8Miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLyhlmBE3HKzRdnpc2dWOS6GY7QIZKKm0OsTMYYMfh8=;
 b=ijTg1sVy1Km1baI/7zmgfqurr6tedWixkRNHiAcdcbc6xpzM4ZBCOKY4lyWrHNf0ZfcQ5eHfKyrc1FgpxPS0jmajOtFYQdYB14CNujwpRdxo7Cup4k6G/giFeooosMVbxKPLg2n5tgSGizom+bc46hdU6ZIhN0IGBDMZSqcyaXSg+11APio6f1jSaBdJ6DbOoicrtffj9h9BCCEt0nRyhiHODDjAmqCcFjtq+pOlySuCOVW7J00S3guKw9ek2/hUeiTAFjIK2JF5LALoek5AQobaetQ2+dcXjcAkXDaqH2uptnLV2rJxHmfobStzK5tIS5CKDbRvFZg4wOUzrtzhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLyhlmBE3HKzRdnpc2dWOS6GY7QIZKKm0OsTMYYMfh8=;
 b=FUYLiE1/cfSJzHSAqDYtA77f1Ap1dgvlk1XRl6+ja9hdUSiru22pMXJrMbgh6EAdmc2JRVJ1fQo9KMTEAz65A7wwDN3VdrVlyJAC0HLyjo868rPSVBbaxdDWuZ5cndwKOyxLb5m/p1TtnU0SjHeksLuJzrrUYHb16Mso9cMXg5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 21:59:14 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 21:59:14 +0000
Message-ID: <fa5e05e2-f3c1-4481-ad87-60688f821c71@amd.com>
Date: Mon, 24 Mar 2025 17:59:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: increase max number of queues per process
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com
References: <20250324172540.128507-1-jinhuieric.huang@amd.com>
 <CADnq5_OKVowRi_ivnE4O0NDPLCW3RTq4LKM-1M86hUnDcbB8fQ@mail.gmail.com>
 <e38a6e0a-34f1-45db-bebb-f260eba421ec@amd.com>
 <CADnq5_OHXK6DZO+nNDuaZQW61U5Hghie2qNHB9pfUe4T0gxE_g@mail.gmail.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CADnq5_OHXK6DZO+nNDuaZQW61U5Hghie2qNHB9pfUe4T0gxE_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::21) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca6c4fb-9097-46a7-6004-08dd6b1f1da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnB5SDB2TnBFc05FS21VQjIrRUltUVcvakZxUVNzUWFVZWJNRk1iRG5uOGl2?=
 =?utf-8?B?Q1dHdnJTMWU0VUE4OElvWnYvcTVDdis2TmtIYjU2UG5CNlBuZ0VJcXN2MzJv?=
 =?utf-8?B?UVMzQUU3dFc1ZmRuMEdQakZ6aU02T1l5VHhVZmE4enQ2YVNhZmF5TGRxYkxq?=
 =?utf-8?B?Rjd4dldnVE05OHVEcDdZNGswSDdvK3ZIWVpxSXJhdFBWYjdITlVqUHozejdJ?=
 =?utf-8?B?cjJNc2xwUTBzSHNMWnlUcEpkM0szaHB0MnBqMkQyRnhQL29zQnJ1Y0Q1akMv?=
 =?utf-8?B?YUxmenRwU2s4ZlRjd3JJUUEwcFNORytmVExNTHBzRllIdE9YUW5IcTBTVTlS?=
 =?utf-8?B?MHZtVjlIc095RXU4M3dTRkZhUGRCSnowQlltYzU1UzhITGp5NFY3bE1CS0ZG?=
 =?utf-8?B?elJncUhZTTRUWlM5NEVuQkJrOXRPR01LZjZlTHhsWjIyenN6dFlTbXpYWEVB?=
 =?utf-8?B?RCtlMzRBaGI0VW1iRGpjTEF2WnVnM1JwM1NZNHVyRFhSYS9NQk5vRWdLUTRi?=
 =?utf-8?B?UEZaMjlROEFlc3NKNFlJOE9Vd1p2bDhORUR0SmpneGlWT0JzK2Zldnk1TFVj?=
 =?utf-8?B?bWZYdFF4S3BQdlFCQnJtMkc5eGVrd21MYjRIY3VjcUhsbnhQQUVxTjdFbTFG?=
 =?utf-8?B?S1R6T3M3d0hlcEJXNVV1TmxNMmx4c1k3aUppMXR1QXoxZEpHMVhpWWYwbUNu?=
 =?utf-8?B?V2hSeTcvMHlPeThncnR2YW5EeEUrSXNqNGpWbElkaUhzalA5RXVnL1ZRU1hm?=
 =?utf-8?B?OWVTdGkxaHQyVEdVZklwRXhBMDNEdzVaTy9aclVJT2pYcUhuK25HTUNnZmdk?=
 =?utf-8?B?UlV6V2M5YVBQMXFjMjlucGtxa0VoYmsxVGdpYS9jcnRrOTYzd295aXk2SHdr?=
 =?utf-8?B?TTBIWTYrUlRTb0UxOFB2OVJUeXJDNW1URUJOQzF5bDV4Z0hFNFlIVTdGODBX?=
 =?utf-8?B?TjRNalRhWFZzakU1dmNkeGkrUE95MjJ2WkNCVnFOMWQwMnhVRXVRZHJaU3V2?=
 =?utf-8?B?YzFLNy95SllHZ2NnU0ZicFhuODIrT3J4UzRxT3VqQVNVMW1oSXZwNmt0SVVi?=
 =?utf-8?B?dml0R3RKRklOLzQ3UXRadzhleEtEMDJYdDRzb3RrNGVWd3ppZjdGVmpBcUtS?=
 =?utf-8?B?T0xoZ1NtSzFyWUNRcEZQb3N0dlA0WmxrYjRWeVgzUmg3Ti9GY3ZTRDZKT1ZJ?=
 =?utf-8?B?N2NDV3FyRlV5aHFERFBXZW5VVHdKd2M1R1hXSDJSYnZMRGp1L0FUd3RyRDMx?=
 =?utf-8?B?d1NmMjBTd0wyOGl5dUw3aytHTHBmQTI4ekE2RHNReWhCZHpoaGthKzROMWNL?=
 =?utf-8?B?QTllUDlZdDh2SFVNcXptb3IvWVIxcXRUMnpmS002YXVZSlkxQUlKMytNTHJy?=
 =?utf-8?B?elpJRzVzMXMxWEltSGlycEZjRUJQZ1F2RTFnUmQ2S0gvQmlUekRKUXhwbmJF?=
 =?utf-8?B?MnpNeWJwbXNBNGZqMS90MWtWcUVDbWFxR3NYeUxhek4xWCt6bWF3OS9GTXI5?=
 =?utf-8?B?ZDRkcUdOdFI5d0VGWkVOc2thdUVqZnZpV25uTk01b0txSy9SN1I4TXpZYU0r?=
 =?utf-8?B?WFdYeSsxNWtiOC9uZ0EzRndkbzN5WWE4d0o5NG93dTRteVNJbnM5aWRvdXh2?=
 =?utf-8?B?RFhrOFA1UlJGMnRyeFRvaGduQ0syNXJYWlIzaU9xYTVpUVRJdERSUFVkUzgr?=
 =?utf-8?B?aUxoVVZKZDlFYkgzZjc0M1I4TmVHQzRiVCs3K2RESjQ5ZWs4ZHRIZFRCN3Fz?=
 =?utf-8?B?ODZucWFvUHhCTWROZW81c3g2K3hvYnNwRTJEQUJMSWhSSFdBalBsQ2dvUUZq?=
 =?utf-8?B?YldpUm1oaXZTMWVpcHBnNkJjSXFLbkgwVzZFVnpNbTgxVEVqNXMxUGdOS1p4?=
 =?utf-8?Q?pQZFDOe9k47kw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWE0TXptd0d4VlFpa3QvOFhaZmdrZkw4bjFOMUg3ZmJJV21td2Q2SGFVYTF6?=
 =?utf-8?B?K01SNnQzbU9rb1BaQS9DVlkvMHZNbU9Pb1Yyb3FFc3VQeTh0cGpMbE5HVUdK?=
 =?utf-8?B?Sklvb3hmdVFod0VmQmY2ck8veGpuRWdoaTNZdFZ5NERKdlRrZjVMeXlYYWVt?=
 =?utf-8?B?eC9SZXJTV0lhdUtBL0I5aFlsN0JZU1BwMWI4NExuclNBdThZaTJUMjlKRGls?=
 =?utf-8?B?b3FoZ1RwSmJrUFVIQ0VwRmVlSFZZUm94RGI2dkZyS0MrSEk4M0xCeW43NFNK?=
 =?utf-8?B?a0R5MHFhbXhVVHhKUUhUN01HWDJFZ2NXRlpNV0pVSXpjTy80N2Z2Vm5tWHIv?=
 =?utf-8?B?OWp1S01FN1VoRWtWUlJSaCtmRlJpRlE1VlJEeDJiQ2NaSEk3cUpDNDNvcEpT?=
 =?utf-8?B?U3FmZEFQOFhwTW5XcitGZ3FlTXJiejFsaEJVbTlaL25SRXo4NHRKL1pTRGlz?=
 =?utf-8?B?a2pScGwyWFlTQjRSVXUxWXcyUFVHSDhKZUo0bTlWRXZFamNwSkpDUWJjZmov?=
 =?utf-8?B?TkRMaUwvS1Y1VFVZWDdXa05aUk5tZ3haSVJqT29KemZZR3RFMlRsTnpkM1Rk?=
 =?utf-8?B?cFRlRXErSVJCWUMrZlZubHNuWThmYmpVMTNGZUFoUWxwbHc1RUFBUGJKWGw4?=
 =?utf-8?B?MnBzcTRlR1UrUndkNmVzVkFieWtSV1hqQlpkTUs5WTZKUEMrUzZOL2UyaGpJ?=
 =?utf-8?B?OG5DQnB5Z1g2KytBZUMyNTZsTHdBUkd0TGVkS2x5V2J2ampBNi8rZ2kzVC9w?=
 =?utf-8?B?dzVUdXNEcGJzNzRBcVFJaDNKZzQ1MzZOaUt2ZU5JeTQ2aktFbDJLeFF6aHgw?=
 =?utf-8?B?MlFNcDNod1ZUN3ovSnRndWw3cFV1ajFUMUtlYkRXclRBY2JhSUtGWW5lL2k1?=
 =?utf-8?B?UnhDeVpGZTE2cHBQU0V1anVteDJoUVVwbzQweGdXdTBTRy8xbDNFS3hNWFpN?=
 =?utf-8?B?UU15MHhTb05rMzJHUE5RcnVHeFBtTzY3N2J4OTJhOXNjSXBLNXJTcUdIc3o0?=
 =?utf-8?B?U0ZrRWlLcnRsWEp4c0UrS3UybzdBQ2R5VktkZW9iZWw5Z2FsUUpxNmFITFRz?=
 =?utf-8?B?Wi9kWjVsK3dHQWhLU3pBU3R1UkpNVktrQm9FR3YxS0FmcTBUbHdVL2VNbjBB?=
 =?utf-8?B?M2VWaDZHSmUxUEVxanBHb3EreVZLOUI1eGRUeXQyaFJXUXk3NEoxRWVXK29C?=
 =?utf-8?B?YnpRMW9rVTk3blF5U01xMW9vL3U3a0F5TVc1c3NtMnMyNmswR2xFRklybmxT?=
 =?utf-8?B?RkJlMnpGQUpibVFFbmF0L1NPWktIVVF5MG83WXcvWGpWZ3poVk9TNkQzRzls?=
 =?utf-8?B?cHhpNDA5SWZWMzVGVS9YbTI1TzA2UVpZRWVzK3YvTnEyYlZDN1F3ZTVjaDFt?=
 =?utf-8?B?L25RNGovOCtmS09YQXk5YjlyMkZTQ2F5OEl1dDRRaG1SRElQTDk5eGVZK2U5?=
 =?utf-8?B?SVJRemtWZTBUNFNUaFdUbVNVTU1BTE1RQ3F0TUdOVGJqYXNoV08vU3ZEUmpZ?=
 =?utf-8?B?RTYyeU9RZ2ZuK0UrSEhuQ2Rnb2d1bk9sVU1HTlZjbkVRaUliWC9KQTFzK0VM?=
 =?utf-8?B?SktQcHpQS3dGbnUvN1VyRHVoUzI3ck05M2JOQnJXcWJBSE9UWXQyMzRZaVh1?=
 =?utf-8?B?aFRpWUx4c3hKV2laNHpQTW9pRzVKZEhIRHhJNFlIOVZjdlRtZ3FNc2pLZmhv?=
 =?utf-8?B?V0lWS2hjRUk3bENXOFBucUR3eHhLV1BDRXN1MktlUmMzd1hDbmVmTDd6Z3lU?=
 =?utf-8?B?K2ZZalZqTnBGajBrTE5tL0tCdVFjWEFVZWlnRG9MN3pYV2p5RVFNQ1l0aGZj?=
 =?utf-8?B?enE5SkxlWUNPNHhiRmY2RERsOTlzZ3RXYWVhMXlqV3EzdlRkNDNVSklQakZJ?=
 =?utf-8?B?enArTUsxQjZrU3ZJSkdmeXpLWFpoMVFDUTZiZzNaREduUVI1YUlqTFZCTmVX?=
 =?utf-8?B?TmVMS1hwK0RVakRSL0Rxa2o0V2RuVURsTFVrbmVobDZ4bzV2dkNxeFh1bEt4?=
 =?utf-8?B?RHhtNzBVekx6U09zTFkwWUVyRDJZYWVxQUFOVTlwNWY5T3dwNDl1UERyNlow?=
 =?utf-8?B?elg4OFFyM2FTRFcxdFRVaFRTMlZVSmw0d3krcGlhR3owc0IvS2FnQ3VpRGU2?=
 =?utf-8?Q?ShK0sM+eJ2TEeG285i5pJMzsi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca6c4fb-9097-46a7-6004-08dd6b1f1da9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 21:59:14.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh0rQQ/Ia36R+1588OCi3aYGbPaX+yrq5kxzT3muNpavuiMT08bMIBxiq1CaaouKr9GP4IiaXUGkpM2oCwo1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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


On 2025-03-24 17:21, Alex Deucher wrote:
> On Mon, Mar 24, 2025 at 5:07 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>>
>> On 2025-03-24 15:32, Alex Deucher wrote:
>>> On Mon, Mar 24, 2025 at 1:26 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>>>> kfdtest KFDQMTest.OverSubscribeCpQueues with multiple
>>>> gpu mode fails on gfx v9.4.3+NPS4+CPX which has 64 gpu
>>>> nodes, the queues created are 65x64=4160, but the number
>>>> 1024 0f KFD_MAX_NUM_OF_QUEUES_PER_PROCESS is not enough
>>>> and test fails at function find_available_queue_slot().
>>>> So increasing the nubmer will make the test passed.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index f6aedf69c644..054a78207ffe 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -94,7 +94,7 @@
>>>>           ((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), GFP_KERNEL))
>>>>
>>>>    #define KFD_MAX_NUM_OF_PROCESSES 512
>>>> -#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
>>>> +#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 4160
>>> Doesn't this limit have more to do with the number of doorbells you
>>> can fit into a 4K page?  If you only allocate 4K for doorbells how can
>>> you increase this?
>> The doorbells size is allocated dynamically as multiple pages based on
>> KFD_MAX_NUM_OF_QUEUES_PER_PROCESS in KFD. Currently with 1024 of this
>> macro 2 pages are allocated, and after changing to 4160, 9 pages will be
>> allocated. Please refer in function kfd_allocate_process_doorbells().
> Thanks for the details.  Since most apps don't use that many, it seems
> like a waste of doorbells.  Should this be limited to certain
> partition modes?

No, it is generic for all GPU nodes/partitions available per process. It 
just creates more capability of queue's max number with more memory 
cost/waste.

Thanks,
Eric

>
> Alex
>
>> Thanks,
>> Eric
>>
>>> Alex
>>>
>>>>    /*
>>>>     * Size of the per-process TBA+TMA buffer: 2 pages
>>>> --
>>>> 2.34.1
>>>>

