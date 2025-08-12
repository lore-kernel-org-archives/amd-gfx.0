Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2D4CA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 21:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FF710E649;
	Tue, 12 Aug 2025 21:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UEMxqDCO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F1210E498
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 21:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL7zTaapfNNeoHYDn4YowNLCBBFi6pzO+hPObkeVJNC+AQFvL9RUhKmUjji/11qT85dp54byY/UZchyj5cBHWuFDPECARVTGbclZPRfw2xUlCZ6kpK7H19A/I/SxJQ56iCJV1HifkQgoIeWMe18jSB8Rv5gkVWgi9C5hvEFvEClB+9GMA5yJrV/H7GJaxXF1N5e/YBPA4ngSIHbeQ2mTu8Y/TujzlOGNeA/TItLqF4vo6U9kofLwjz/4bqX4B8JUb5N2AiEG6mbMsFBeUaJWA9Q1VjeFcblXepCWPGVc/mtD1s/2cRcI5YyrVHkvmjjafW7U2wd2AosZnJEQtVrBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ/6cu8vLeTIN9y//fIRJYN4jXes9ysUCr+nBXKofHY=;
 b=C4F+FRpmCrzWAOxGIsQRj2PPC1Buw++Z2Wiwdf6ktRvOLM8tBJ1bhoOEOZEV47mVBKzwSl/7vnemyPQcxxIV9ipIOhRna5emjn8uVBzB526zyOLKVO6wb5ZHXUufnWJ2SWWmxdDYTnhk8trS+nC4tlMa+oc+hkFT5iRq15GKyaS62zYyLjMrHflttcOhJTa5s4gywWaSe76esyjIne/cxO+CgMMMCqGUsh5hiSfLUUQnd69Tl93eHKXbM7KQEdIv8N+PXIqdq63j/t3l7/pfhQswJyLSbL9rJEp4Rj08VTbp+hkH8uHdGw5O7FL6gqWWXK6UiYL8NmhhpOvw7tcBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ/6cu8vLeTIN9y//fIRJYN4jXes9ysUCr+nBXKofHY=;
 b=UEMxqDCOwYceh4EpFQ576VYQ8FfPi2OlHAp/oSwcZkwSA7Ia9olt75bUkLy6E2JFAFxzUnfMZ/wPQjsqarlNwQ2Wty3XCuTQ7nZ3b6AN6jqZMj/k17spMjeGk/lBE/J3hNTasNoxbNljpN97dzutXWNtRLEIIZmnrqwZ8sg3XYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 21:39:27 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Tue, 12 Aug 2025
 21:39:27 +0000
Content-Type: multipart/alternative;
 boundary="------------0sa6yU7mXmrREi701d0J00gf"
Message-ID: <41fb0506-b1c0-48a8-9f75-554d16cab3ff@amd.com>
Date: Tue, 12 Aug 2025 17:39:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
To: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
References: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
 <d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com>
 <82e1b48d-ec52-f72e-72ba-eb8010edb7ae@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <82e1b48d-ec52-f72e-72ba-eb8010edb7ae@amd.com>
X-ClientProxiedBy: QB1P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::40) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: af394816-78d7-4cbe-a40c-08ddd9e8b66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEc4RWJDVW9oNVZ2dnJMSmYwV1lJMm5Sb2xjTFJUVlpuWEZQYmNudWg1NzR3?=
 =?utf-8?B?OXY1QU8wTXZ0cGZCTC9TTWQ5dGFQM0FpclVvT1RnWDZ1dGNEU3Z5OW5maGJt?=
 =?utf-8?B?TU5pRldqeTFTcE9Id2NLaEdPeEYzN0svTWxQZ3JLcHl3Z29yMGZiaDdCTWt1?=
 =?utf-8?B?bFkwL2ZmYmFwWlBIdzBNcXU1NVlYT0Jua0k5SmtkVUhicWlSSU0zbHlIRGNi?=
 =?utf-8?B?NjNEcDFnWkE0bkJnaG5YeEZ4SldEUkVBMWNHTGdJRHgweTNRUjQ3V2REWnRa?=
 =?utf-8?B?Y1B3ZGYzQjZyV2Y2Y2JoeFRoUGtOSzFRYXYvQWM1c3hMclFvWVdLT1FIaTVQ?=
 =?utf-8?B?S0JaNHpONHBaYlkwK2RzSlord1pkT2ZBeE1PTHBmNEt0WXBDSkhlNXRZbnF4?=
 =?utf-8?B?amdvVytkNGcyNFBJVk9PNXNoVU9XYjFyTC9uR1hMNmNlTC9HY0REaTlTK0xE?=
 =?utf-8?B?OHU2R1dDVE1ueWN6LzlSd25aZnJIK1VXQUt3OXVYK1krLzVYekhhVFlGbWY1?=
 =?utf-8?B?VzdMQVNVU3M4U2N0d0xDdXZiY1YyMWVhbDRRY3lwc2FVaU5DcFRibm0ydm1i?=
 =?utf-8?B?UW4rdGxsNWcxUXNjOXd6SEZ1SFpVc2dlWHMwclRtZ041Nyt1QkNYVGxMUy80?=
 =?utf-8?B?RHBuMEM3K29RYXlxYmQ1VHp3US8zVXRuR09nVzJvQm5aSC9KeWpDZ1JNeWw5?=
 =?utf-8?B?eTlYMXhYMG1Wbm9tR3BnNlFNMmlPeEZmb0FQTW9RQUZiQituZzZLdm5rUnRH?=
 =?utf-8?B?Mkt3VFFIL2Y0VHhpaXUxQVBBSWVtWEtqTjRWVWlBcFhudFZ0bGROWmZLak5C?=
 =?utf-8?B?OWJ2c1lIQ1pRaDI1bDE2bTJBdGhpelgxcktxSXBnOVNBNXNsM2hlWUpyRWQ1?=
 =?utf-8?B?TUdLZGhRV3Z4QlhyL25veEFHWnBLWEJEbHdwbXd3dmUwbEZXeUI5NHJScTVs?=
 =?utf-8?B?U2RFVXR4Mk5Ic2hHT1RwQ3h2QXRiS3VmRGh0LzFjd2RPTWdyM1JBMHFML2dy?=
 =?utf-8?B?ZjVQQlNQTmdDKzFaMWl6ZEg4NGgzRHlKWUVmSExQSGFCMUwvRDZzOHR5Y0p6?=
 =?utf-8?B?Y1VYTUFEV09XcWNielk5SFg4NkxUSXZyKzBlaFQrTEJQTEFsczNlM0dkZ1RV?=
 =?utf-8?B?eTVKc2dDaW8wMVRMdVBIMDJFaU9tZi9ieit3RnpEeHBGeEhvVjROL0tmRk1y?=
 =?utf-8?B?M1dBRXRjSytEUUZIa2dJUlE4MWtXaWhHc203aW9MNGpBRDBQNUFsaFFPZnNo?=
 =?utf-8?B?Z1hBdi9pR0NQVnh5RjVJYjg5REVpSGRaTFB0UTVBTGFyRnQ3Z1l2RjQxcjhy?=
 =?utf-8?B?Nmc0czFVMlloMTNUS0Nad1k0QUp1dURuVlB6VXVFZUdKS215RHl5d1ZIT2s1?=
 =?utf-8?B?V0tLdTIvbS9uYkdDWFlUN2pmWmVYOCtBTCtjR1FlSzhWbW1GUEZxYklCYitK?=
 =?utf-8?B?RjVDOFJlamZtV1NJTzk0bGRBWTBQSWxTSWU3VXFqVERHZVg4YkJlVnF6UzFU?=
 =?utf-8?B?QVRrNmJWR1hpNmZxOW1SQXFGN0QrdUp2ODdtVGxNc1liU0ZxdG5yb2svK0Vz?=
 =?utf-8?B?RHRkVzNnSTd0Z3RCTWdrVGhKNVh2UHVWRG8rY3NqZGoybkM5cUhhck52RXRu?=
 =?utf-8?B?WDVYeXdZUXNvckFSMWdJb3pkeVZpUEZEa2Q5TDNycVFnZzkyWm1sN3Nac25w?=
 =?utf-8?B?L2N1cEt0SkF5MWpvc0RWRmthM05oOTFlbW9KUUtmNmNPS0g2a1p5bHRYcjlU?=
 =?utf-8?B?NFdPNDFQanllc3R6Z3Y5UGROb3ZaSXNnVnZKSUpRYXFYWHI2Nm9wTjkvZE5H?=
 =?utf-8?B?SlAyakI1bk5HMTJKWTJNSGpscTlFemdiQ0FZOEZQeTUzYnkxZmZWM2VZNlRZ?=
 =?utf-8?B?UjNhcml4SnhHUEFWdzBKbFg2L1Qyazg2SkYzMGpjL3NtRXphZVVTTU1qcHFp?=
 =?utf-8?Q?Mk3763G2btM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0pSMWtBc01CQThaUUhxa0pUaDdEMWlIQnI4eVRIQVUxdzVvQWl0ZUx3NGE4?=
 =?utf-8?B?RkpNV0dXalJ1cWRnTC9RMVM4V1prZHRjd3FtYk5pRWtpbjVGdWxiemNGKy9v?=
 =?utf-8?B?SnlGVkUvNWtvV0NYQTF2SVpBVDZTeUxYbWlRKzFsTDN0aFJvRkpCVkh3RmhO?=
 =?utf-8?B?elpSYXkzdEJTODYwOVlKWmEwMVY2SzV1MWdUclFQOXVyVis5azAydWcwY0JS?=
 =?utf-8?B?MjViTGdPQ0EyM0JUK2pNbHU2ZENwL01HemxNZlkwaGY1ME8zeHh4YVJlQXFv?=
 =?utf-8?B?ZFh1WWNWR2t5eUlueWZzeVJWWHlGN3JiRkNGdlROSms5UzBNeFJHOUg0dWhs?=
 =?utf-8?B?YjRqM0hPUXZTL20zMnRBTTJRdExld1hMUmI4d21sV3plTGFTUkFQdVJXYkFQ?=
 =?utf-8?B?dWJOZXNSUEdlQWtrc0Z6d04xZ0pZNExNaEVaek1RdjhSVlBTbGRWYlZENERJ?=
 =?utf-8?B?VTNEaVVjUHpxNDlOQVM3eGhmNE5CNG5mSHR6RjFGMHpBd1VNSXZTSjVYeU5Y?=
 =?utf-8?B?VHhrNVhKUjAxSmF2eDI0b3NDNDFBZkY5Z1Z6NGF0N2RsNmYzaXlYUkJsZHdK?=
 =?utf-8?B?MWxkN0cxQ2gzNWwreUNwRmJROGRnWlZJNjFqRWR4Mk52dmM0eGJSL2RadEpR?=
 =?utf-8?B?OG9YZEpXQ3pLazRKM2x3RThvWHhNNnBrdFZKQU5qUW1tMnlVeVQvUmdPY3Iv?=
 =?utf-8?B?RHRYeStnMUwybTB1R1VzY1RHZXUyMFVQU01jS3YxYUJ0L0JGbmk2cksrY0lO?=
 =?utf-8?B?Ujk0Nno2aTk3QjRsOXhObG1qQjNKSDk4UG12U1c5SzRvcEhnNWMyNkJHMzc1?=
 =?utf-8?B?RFcrV1JOK0dUZUU1SVd4U1NBZ013YlhXaERJWEdwQ0tkRlpMeWs1YnJ3aytY?=
 =?utf-8?B?bjhVMXNMaVVxWGtkdXY0MDJmK0VUZmJUcVByUnozdW5QUTRKZDEzMFBRUzRM?=
 =?utf-8?B?alpSMlNNN3VubXFzWjhZSDhYS2hySCtSbStFVjFKTWVRbkEvZnJUR0ErbFhL?=
 =?utf-8?B?eXY0bWJjNk91YWozTGV6eDhjTVBNWUlnckw0Yk8xTmFvdTdSL21zcFV4MVhX?=
 =?utf-8?B?WUZUc04xQUhPZHF5bXpnYXR3emgwT3ljazlEK1IzTkVqckpUL21GbVZVYUV5?=
 =?utf-8?B?YW1vTnpRMjdEdG8zdXlsZG5aVWFTTjRNdFJ3K28rU0U1SDJqK0FsRE9IQ0VQ?=
 =?utf-8?B?UklDaXA4SzFTMWtpREFMdS9Ha2E1YTFMNHFHWFRCVktzRlFGV2dyT2xrN0d1?=
 =?utf-8?B?M0gzTUlqOG9SUHRUdGFsTnZkRGhXSU1zRFpoSk1oN1lQSXBhR2crTGJPaHU1?=
 =?utf-8?B?cyt5Ym1hSkhmMnl1ejlyaTBPamlydU9mNXgrOTJkdDdCcy9wemVXcFZab2JO?=
 =?utf-8?B?eDh0TE03TitqZzJSeTlYQnloZlNHY1k3UEg2N2Y5emxpOXVwZ29zcnAzWUp4?=
 =?utf-8?B?Y3dMMlYxWUVkVWQxWHpmQTdpbncyTTZrMlBzazVMckVMOFVuVWV5WXFXSnNq?=
 =?utf-8?B?RGZNamNwTnZCVG4zSEtkUjFBVU95RXk2NGM1OFZ2dFZoa3AraFllbFVxWG5C?=
 =?utf-8?B?a0RsalFMbkZWVU1TZVRhSFZFT0tCcTlQU0dIT0NxY3hDWnJCUXpKbWRSVTND?=
 =?utf-8?B?ek1vVUZ6RlBRUUtyaFVsb1ExKzV4VjliSm1uYnJNck52amVkdTRZaDZlOXpm?=
 =?utf-8?B?L202d0VDMzJMbHl2K203aEJmS2IxazZCWm1xVXJSVG04Q2liN3pkSjh2YSs4?=
 =?utf-8?B?VG5xRldEYW5veFB1SjBuaXV1THdZMmhsQ0NYM0V6am01NmUyK3FGaXJSLzdz?=
 =?utf-8?B?VmE4YjZiVU92VlZtM1l2V2lrMUl0cldmUW1MS2tVaGEzSTZRRUlXTGVmbW8z?=
 =?utf-8?B?Zy9obWZwQkVQUGRqODFLSGFhZm1Va1JRa0RZVVE1ak9aNDRkbjVqVUpSekZB?=
 =?utf-8?B?czA4UFVDSWVjWmNBd2VKcHhzU0UzL3J5a1A2azhJbWo1ZzJscGtCTlVCbGk4?=
 =?utf-8?B?UUpOaXNQMW41dU81eFlVcVBCaFJ3S0JUSWp3YVUrNlZ0c3JOak5HREt1blVK?=
 =?utf-8?B?ay93Q0pSb2VBZ1R5L3dnNEZjKzZ0N2N5WFRITCtGMHA3M2w4VlFZR1FmeWpk?=
 =?utf-8?Q?k61sMD9GOqD2T2xkWpSLcCBbP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af394816-78d7-4cbe-a40c-08ddd9e8b66c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:39:27.4218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/3mqONIIbPVMsFWadmdG+8N8KmheqVYuTOsh1XjTksGwL9CiY8WHA0Nj3T+scgUGDZPgQBK/OetdoTU2kl+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
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

--------------0sa6yU7mXmrREi701d0J00gf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sathis,

I think the issue is the /workload_profile_active/ is not protected by 
the lock /workload_profile_mutex/in idle and begin_use.
for multi instance case - all instances could be idle so the last one is 
trying to power off vcn as the fences is 0.
since it does not hold a global lock when counting the fences then when 
another instance has a new job, its /workload_profile_active/
is unknown as it could be ON as the last instance (idle handler) has not 
set it to OFF yet in its idle work handler. A context switch from idle 
to begin_use
will end up vcn power in OFF state. Also to make sure there isn't any 
fence miss - the /workload_profile_mutex/should be used for the
entire begin_use function and idle work handler.
I think Alex's patch just tightens it up to make race condition less 
likely happen.

David

On 2025-08-12 16:36, Sundararaju, Sathishkumar wrote:
>
> Hi David,
>
> On 8/12/2025 10:21 PM, David Wu wrote:
>>
>>
>> On 2025-08-12 10:56, Sathishkumar S wrote:
>>> There is a race condition which leads to dpm video power
>>> profile switch (disable and enable) during active video
>>> decode on multi-instance VCN hardware.
>>>
>>> This patch aims to fix/skip step 3 in the below sequence:
>>>
>>>   - inst_1       power_on
>>>   - inst_0(idle) power_off
>>>   - inst_0(idle) video_power_profile OFF (step 3)
>>>   - inst_1       video_power_profile ON during next begin_use
>>>
>>> Add flags to track ON/OFF vcn instances and check if all
>>> instances are off before disabling video power profile.
>>>
>>> Protect workload_profile_active also within pg_lock and ON it
>>> during first use and OFF it when last VCN instance is powered
>>> OFF. VCN workload_profile_mutex can be removed after similar
>>> clean up is done for vcn2_5.
>>>
>>> Signed-off-by: Sathishkumar S<sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>>>   2 files changed, 13 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 9a76e11d1c18..da372dd7b761 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>   	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>>>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
>>> -		mutex_lock(&adev->vcn.workload_profile_mutex);
>>> -		if (adev->vcn.workload_profile_active) {
>>> +		adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
>>> +		if (adev->vcn.workload_profile_active &&
>>> +		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
>>>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>>   							    false);
>>>   			if (r)
>>>   				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>> what if there is a context switch here? since the vcn_pg_lock is per 
>> instance - if another instance starts to
>> call amdgpu_vcn_ring_begin_use() the 
>> amdgpu_dpm_switch_power_profile() will not be called due to 
>> workload_profile_active is per device.
>> I think you still have a race condition.
>
> The situation you are explaining is bound to happen even in the 
> current form of locks without this patch as well, in both cases, 
> processes will run mutually exclusively at different times
>
> with the one holding lock finishing first and then the other continues 
> after, without defined ordering between them. workload_profile_active 
> is common for all vcn instances, it is ON before powering ON
>
> first inst and OFF after all the instances are powered off.
>
> Regards,
> Sathish
>>
>> David
>>
>>>   			adev->vcn.workload_profile_active = false;
>>>   		}
>>> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
>>> +		mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>   	} else {
>>>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>>>   	}
>>> @@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>   
>>>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>   
>>> -	/* We can safely return early here because we've cancelled the
>>> -	 * the delayed work so there is no one else to set it to false
>>> -	 * and we don't care if someone else sets it to true.
>>> -	 */
>>> -	if (adev->vcn.workload_profile_active)
>>> -		goto pg_lock;
>>> +	mutex_lock(&vcn_inst->vcn_pg_lock);
>>>   
>>> -	mutex_lock(&adev->vcn.workload_profile_mutex);
>>>   	if (!adev->vcn.workload_profile_active) {
>>>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>>   						    true);
>>> @@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>>>   		adev->vcn.workload_profile_active = true;
>>>   	}
>>> -	mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>   
>>> -pg_lock:
>>> -	mutex_lock(&vcn_inst->vcn_pg_lock);
>>> -	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>> +	if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))) {
>>> +		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>> +		adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
>>> +	}
>>>   
>>>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>>>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> index b3fb1d0e43fc..a876a182ff88 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>>>   	struct mutex            workload_profile_mutex;
>>>   	u32 reg_count;
>>>   	const struct amdgpu_hwip_reg_entry *reg_list;
>>> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
>>> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
>>> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
>>> +	u32 flags;
>>>   };
>>>   
>>>   struct amdgpu_fw_shared_rb_ptrs_struct {
--------------0sa6yU7mXmrREi701d0J00gf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Sathis,</p>
    I think the issue is the <span style="white-space: pre-wrap"><i>workload_profile_active</i> is not protected by the lock </span><i><span style="white-space: pre-wrap">workload_profile_mutex</span></i><span style="white-space: pre-wrap"> in idle and begin_use</span>.<br>
    for multi instance case - all instances could be idle so the last
    one is trying to power off vcn as the fences is 0.<br>
    since it does not hold a global lock when counting the fences then
    when another instance has a new job, its <span style="white-space: pre-wrap"><i>workload_profile_active</i></span><br>
    <span style="white-space: pre-wrap">is unknown as it could be ON as the last instance (idle handler) has not set it to OFF yet in its idle work handler. A context switch from idle to begin_use</span><br>
    <span style="white-space: pre-wrap">will end up vcn power in OFF state. Also to make sure there isn't any fence miss - the </span><span style="white-space: pre-wrap"></span><i><span style="white-space: pre-wrap">workload_profile_mutex</span></i><span style="white-space: pre-wrap"> should be used for the</span><br>
    <span style="white-space: pre-wrap">entire begin_use function and idle work handler.
</span><br>
    I think Alex's patch just tightens it up to make race condition less
    likely happen.<br>
    <p>David<br>
      <span style="white-space: pre-wrap"></span></p>
    <div class="moz-cite-prefix">On 2025-08-12 16:36, Sundararaju,
      Sathishkumar wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:82e1b48d-ec52-f72e-72ba-eb8010edb7ae@amd.com">
      
      <p>Hi David,<br>
      </p>
      <div class="moz-cite-prefix">On 8/12/2025 10:21 PM, David Wu
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com">
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 2025-08-12 10:56, Sathishkumar S
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
          <pre class="moz-quote-pre" wrap="">There is a race condition which leads to dpm video power
profile switch (disable and enable) during active video
decode on multi-instance VCN hardware.

This patch aims to fix/skip step 3 in the below sequence:

 - inst_1       power_on
 - inst_0(idle) power_off
 - inst_0(idle) video_power_profile OFF (step 3)
 - inst_1       video_power_profile ON during next begin_use

Add flags to track ON/OFF vcn instances and check if all
instances are off before disabling video power profile.

Protect workload_profile_active also within pg_lock and ON it
during first use and OFF it when last VCN instance is powered
OFF. VCN workload_profile_mutex can be removed after similar
clean up is done for vcn2_5.

Signed-off-by: Sathishkumar S <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..da372dd7b761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (!fences &amp;&amp; !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt)) {
 		mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
-		mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);
-		if (adev-&gt;vcn.workload_profile_active) {
+		adev-&gt;vcn.flags &amp;= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst-&gt;inst);
+		if (adev-&gt;vcn.workload_profile_active &amp;&amp;
+		    !(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_MASK(adev-&gt;vcn.num_vcn_inst))) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
 				dev_warn(adev-&gt;dev, &quot;(%d) failed to disable video power profile mode\n&quot;, r);</pre>
        </blockquote>
        what if there is a context switch here? since the <span style="white-space: pre-wrap">vcn_pg_lock</span> is per instance
        - if another instance starts to&nbsp;<br>
        call <span style="white-space: pre-wrap">amdgpu_vcn_ring_begin_use() the </span><span style="white-space: pre-wrap">amdgpu_dpm_switch_power_profile() will not be called due to </span><span style="white-space: pre-wrap">workload_profile_active is per device.</span><br>
        <span style="white-space: pre-wrap">I think you still have a race condition.</span></blockquote>
      <p>The situation you are explaining is bound to happen even in the
        current form of locks without this patch as well, in both cases,
        processes will run mutually exclusively at different times</p>
      <p> with the one holding lock finishing first and then the other
        continues after, without defined ordering between them. <span style="white-space: pre-wrap">workload_profile_active is common for all vcn instances, it is ON before powering ON</span></p>
      <p><span style="white-space: pre-wrap">first inst and OFF after all the instances are powered off.</span></p>
      <span style="white-space: pre-wrap">Regards,</span><br>
      <span style="white-space: pre-wrap">Sathish
</span>
      <blockquote type="cite" cite="mid:d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com">
        <p><span style="white-space: pre-wrap">David
</span></p>
        <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
          <pre class="moz-quote-pre" wrap=""> 			adev-&gt;vcn.workload_profile_active = false;
 		}
-		mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);
+		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
 	} else {
 		schedule_delayed_work(&amp;vcn_inst-&gt;idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&amp;vcn_inst-&gt;idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev-&gt;vcn.workload_profile_active)
-		goto pg_lock;
+	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 
-	mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);
 	if (!adev-&gt;vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
 		adev-&gt;vcn.workload_profile_active = true;
 	}
-	mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);
 
-pg_lock:
-	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
-	vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+	if (!(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst))) {
+		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+		adev-&gt;vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst);
+	}
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..a876a182ff88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -366,6 +366,10 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
+#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
+#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
+	u32 flags;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------0sa6yU7mXmrREi701d0J00gf--
