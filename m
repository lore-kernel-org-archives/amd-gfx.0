Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30100D4336D
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 15:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6ACC10E86C;
	Thu,  7 Nov 2024 15:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="guLLehwR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2721310E32A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 15:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8985sZ9YPHjLbPKHXmR6kIaLvxIByTMWVA2D88IDibR6MkkKXUSBtnPGNg7hL7yDA2WCTu/7YzvWWJ96jwTMMsG0ZUlkHWJMKZiDzoz6srzkMWH4F+QoJzRmGYCPN1W2+wuCGRuTRNO499aOkIiJ7mNVl8eOYuHe3gthhdQjepG3B5o1EYDDv8SySlHDUhpEye90PHdxO4SOzAf6ruunhAhAeJNe2L88kO6VubIndTfB07XHPlkkvULWmkA2HP7cIx2yOfJsq/Iq7YBCsVBBcPankHuuJHjdZMzgCoVJpK/xFlhZIdTslCBkiCexuKtCsqwLcXymP3u8UfLi9Figg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eURHSVi9KD06LNELXtcZ7i8JxpbWRyvFoFDcAxK9wmY=;
 b=g3y+QmDX9HGsNKT7hQDkOpqcdPwkUncwItYNXFjovBZQ8nxJ0ZxbS/dp4a6G+DJPd2s1S7u7Q/fnqaz9I6Oi1GkYfmsjRyW1t73IY51fdh7VCzLqLave+HM1yNi1AOrbswQhUOHdzgGbNegvZlKiWUFXW1HxClv9QHl01bCoDnOS+3RIiP9T4LEh0H8fPi/Cn8ExN8hlANOQ9NELqAiGz1bsgr8WjPtwuLyYqTKkhnm6F6SRhqTV/TrPq43ZBRVHnx59c1mh37m0igX5d/4WqH6h9oaFm2c/oH+dnQjm8pbCMUmTWee8dEj/P8cUUgYqPa0oig9U+X5G7UTDlCdXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eURHSVi9KD06LNELXtcZ7i8JxpbWRyvFoFDcAxK9wmY=;
 b=guLLehwROZzVuHFjj1jsKyi93pPTm36oX2HDliBkCr15rcxpmxy5yAw3WA3FWidPmETWDNZD/4rYAjWb13Iw4pSV5ZV++rpnh6hNbH9VifQe108l7qlsAusqxk9J7PgRWBmEc/vJEHbdn2n6s4h5i1bqf5/1g7fAOvB73pe4WQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 15:03:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 15:03:39 +0000
Message-ID: <04762998-5ca4-494b-b02d-6578a56d00d9@amd.com>
Date: Thu, 7 Nov 2024 09:03:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] drm/amd/display: Fix Panel Replay not update screen
 correctly
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
 <20241105202341.154036-5-hamza.mahfooz@amd.com>
 <698cdf3a-e9fa-4f90-9c06-ebd8c771fcfc@amd.com>
 <89e9520b-d651-437e-b06f-ec44626876cc@amd.com>
Content-Language: en-US
In-Reply-To: <89e9520b-d651-437e-b06f-ec44626876cc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:806:27::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c932de-8729-4f20-b73b-08dcff3d5cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YThVZVQzaUs1YzVRbE15UkxhWkRibDhTUWZ3Uk1CUmU5ckhsdEdFbzhBWWUz?=
 =?utf-8?B?YmZnSG5vRlMvWW4xU0lPb2tOQk83RVB6NGFkamJrelczT2JVUG14WTZTWjA0?=
 =?utf-8?B?R3JLL2x6ZTN3c0VoQ3NmemhKRUtNNVQ4dlgxNldGeEx0QVVBL0tva0YvNXRO?=
 =?utf-8?B?NzltVzFGTy9mS1dCQUdQV0oxcjllVG9kUXNzei9iU0c4aklqdUpjTjRXbkJL?=
 =?utf-8?B?UnJlM2lWVzBYeHZHOHBIMmFMSFByOUlUZUdYNW1NazVZblNnaG5xUHNUUzI2?=
 =?utf-8?B?TkxlVjd4YldZeDdFSks2RTdIRzdVejU0RGwwYThHdkZVRllGbFYyM3NnT1h3?=
 =?utf-8?B?MDZ0QXYvQjN0MUMxY0NJMXRBdStRNnN6eTYyZnhiL01LUnBoRC9MSzVCaFd4?=
 =?utf-8?B?ZHZXQ2tqUURKSE9ZYkJPdVRUOFVjRDRFQ1IyREFXT3Q2RjRlZkhTYjBkS3R4?=
 =?utf-8?B?T2tlYjhMM1JENzVNckxpWlJLSE9sUlR4K29HU3dTVmNMYU5kaUNlYTMzVE4z?=
 =?utf-8?B?VnBSMjZHa2RBcEdtOXF0ZHdoM0RiUGVRa1JzWGVCMUtkbDdBVGN1WVNsVE4y?=
 =?utf-8?B?cWt0bzJ3WXpnSkZQT2gzRUMrdkc4b01IZHk0WFBRTkx0QjI3SzZONUVLZ21r?=
 =?utf-8?B?eDlSZkV6dE52ek9GVEFHQ1VoQ0VRVFpwcmlSL1p5T29YaE1yNlRvTGIxc1oz?=
 =?utf-8?B?V0RmdGphQ1NtUTNrUzUzYUM3amNqN3dFenQxUmszNktNc3lLMjF4WDV6UG44?=
 =?utf-8?B?dVNDcGpRZHVUSHI3RXZVR3Z0VTJqODZuMDJaSElMMy9QMGRzVnFMaFJaQnFL?=
 =?utf-8?B?SHQ0WW8rcFpYTkJ0UXdPQ2lJYVZqZkZ1Q1BmMFZOTUdFVlpETkNlaDVIQURQ?=
 =?utf-8?B?clRpNHlIZjFRV1JoeEVNL0MvcnRHSFVtVjFRNXNhbGhpNkFPV3M3c216TTdp?=
 =?utf-8?B?V3lXLzhyVEUxL3JtOTBsck1aNHg3NGdtRTM3RnVuZXdZQTJMc2VMNEJ1Nm53?=
 =?utf-8?B?S1JYaTI5VnhLODFKNkw0Z3dqK2F2Ni9Dek51UG04RnBhWW1sekU1VHBxd0Zj?=
 =?utf-8?B?djZ2VnlIQzF4Sy9DQWN4WTRGY01SZ3lUZHFLdzlNcFRvV3dVN2FhRDhDVUJz?=
 =?utf-8?B?bGpEdTFxTDJ2OG42dXlGR3pyQ3duSlhFakFRSkpiM25iY213TGhuSHVyU2Uv?=
 =?utf-8?B?M0FHL3kybzl6N0JSd2M4SjhSL1pDMUtmekkwblVMNmIrRmNtWEM4d0loYm56?=
 =?utf-8?B?K1h0NFN4dnh6UUs0ejJrYlM1S1lEMlZaQXpGOUJkSkY3bm9uK29lU3JodXVp?=
 =?utf-8?B?enp2YlZrZ0dmU1ZXT2pNd2ZvYVdHS05YM2JkTUZ6bkQxeFNLN0ZOQzdIOExS?=
 =?utf-8?B?RDRkOUpXemxYdjhWTDhwbDYraXN3WGxiRXdLU1VSUi9hRjdJZTdYeHpEOXRy?=
 =?utf-8?B?MTAvMXIzdzdWMWd0dmpzQzVKbVdGVE9NSEJvMWl3WnV4ajFpWURGcjBlN0xM?=
 =?utf-8?B?dHRYSGdXd1BKamZaZldDN0xtY09ZWll4R25aUTYydDBkMXBrT2M2ZnkyMXJt?=
 =?utf-8?B?S1lobkN4VXBmejkrUkNpdmJnR2pBN2R0Q21vVW9ERTNsSnF2NnZWTXRmbEY4?=
 =?utf-8?B?WEdTYjREc2hMdkF3cmRtS3FvMXNmUlZhZHFCQ3E5RFhVNUh4bW5OT2RaQTNs?=
 =?utf-8?B?cDN3Y3pjbWRUK0c2K2dKVUxta1k1bHJDUGJ5eVMvbjY3NCtYVThmNUJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRTeExSOTg1UklzQ0JTTkYyay9PMlZBN2lNYk9IM0k2S05MWW44NFJBd3Zy?=
 =?utf-8?B?MHRUT2N6UjZaaXp6T210THovUStOTEVKOVBBV1daSUdQYUR6SWl2aGNKaFRS?=
 =?utf-8?B?cnRhdU1EOW0vNTFta1lsZ1ByYUd5UTBwMTNRZ1ltNjFxTkhnL1Q3aUlIenJn?=
 =?utf-8?B?L0E1Q1d3TTFQVnNZV0Q4Z0xQMlRzWVJSQXJCbFlRazlJMDUzaGlIbkk2TnVO?=
 =?utf-8?B?SXNkVEpsbElDYVZ0b0FjTVNwMUE1bGQ2cFYzRjh2UDJEaUl6Q0JVZ2h2eUF1?=
 =?utf-8?B?czdWdGxYb2c3TDZBSlpIb1dXbzVoc2M4UjR5bmdLRm9tb3htSjR1bEdPcXN0?=
 =?utf-8?B?STNQNm9ZVjlVRGJ0VlY2K20wS2ZoMjUxUTVyd1BPN1FIckRBQXRKL2tDblE4?=
 =?utf-8?B?MzN6Z2FwRnc2RkViMUs0UGZJTytvL2JscEp5dXdWQUVJdGV0cWhlU3VwM2wy?=
 =?utf-8?B?QitSK2tGYnprK21YQkhsOTZMZjhsQU9aVENCS1hUUzBRWE1KaFZab2VaVm51?=
 =?utf-8?B?VFNqaWhvbVROcFhhcTVmanBZeWdYeG0zTkxaeG1hVEwyS3pINlZsMUg1cUpS?=
 =?utf-8?B?RU1Ydm5KUTlWTG9RTDVPN29qVXg4ZkZzUzQ5Q3FHVk5pbVhTUC80WjFZSGtH?=
 =?utf-8?B?cFZUZlVlNFJMcXVCZkdZTXdoTXA0bTRiL0V0MHJ5bFBDczhxNmR6MGdISFlj?=
 =?utf-8?B?VUFKZ0QxN2REd3orckx1YzEyVXkyV1NwbnlTZU05ZnJlUUcyNW1EZDI2S203?=
 =?utf-8?B?Y29XaGtRY0x5bnZMSlZ2NVFRVmtvQ0Vhd3NRMUlVZkJzNmhsajlMVC9YZk1K?=
 =?utf-8?B?RmNLOERPQ2RreVMxdndVY3FEdGxkRThKSm0zTXMxdU4vMUdoUlpBZ3ZjM1d1?=
 =?utf-8?B?TkVESXRJN1FQV1hWVHR5VFliVGVVUy81N1p4bTl1M2kvUjNWT0crTUlmMXgw?=
 =?utf-8?B?K1RHRlpLamVDZHBIVEJ4K2YvdVVuQ3NxeUxJNG5PRGRDRHp6Vk9NdTZJVllH?=
 =?utf-8?B?Q3NscVJHdGh6WHdKVk1Wc3JnOU9SZ3VDcURnZ09VbVZBWTBKcWlxb1ZSSDMy?=
 =?utf-8?B?WFFLSC9XcWhTSythRzhLWHpzYldZTjA5aE1zcTlwckd0dUVQT1FUSUJ3VDRW?=
 =?utf-8?B?MGVWUFdpNlUzV1ZQM1RSeUxFZEVqbko3cHR0dDdaWWdOd0pPdXhzV0s3Nk9U?=
 =?utf-8?B?TGx5b3lQOXcyQVRDZ2JKTlhqdGN4Wi9seU96ZGVPV25mTG1qZC9CanZsVTlD?=
 =?utf-8?B?SkxWME1sR0Z4dWdoYUhvMnl6YVdBWmk3ZHI1UEhJSUhlSk1Cbjh0WG1kSnBD?=
 =?utf-8?B?TDlsNmtEWlFDek5DMFliWkxXZytWM21BSnZQVjhxdFR6MHo2SGx0NFc0NzlF?=
 =?utf-8?B?NHR2T2t6Ni83N2tBdkNUTHZGOUx1NWZwa1RmNHFqRGhvUFNhaUlMN0ZacGNR?=
 =?utf-8?B?Ty9tNGNmbExkTmkwMjNlbHJHYWNjRkd6S3ViR2Z3MTgxYXNLTzhvalM3cTlv?=
 =?utf-8?B?b1k5ZThSTGxwakhlcVNhTGlTek5TaXl4cXFaZCtOdWF1RXAwVmszODQ2L2VP?=
 =?utf-8?B?VGtFbXBSck1RY1ozc3BZYWEzR3NkMU5GTVJVWGFKS29zK3JOY3B0c0lBbHQ4?=
 =?utf-8?B?VnRjMzFHM294N1JRanlaWGNMY0RYOGJvb05vTDZvcnZWblliOUlwQmFxQ1VK?=
 =?utf-8?B?WUxaR3VwcjArZUpjN0U3d1ZNZzkwUDc0eVNtVlM0R1VtVE9SdUxyeTk0eEJ5?=
 =?utf-8?B?TEpoSVMwSVlHekV3cDhZNTFFQVBLNWtmeG1DcjhXSlhDcGNOQ1RXVTJVbXVS?=
 =?utf-8?B?bVE3NXRuRS9US2dFRjFRSmdCa2JmeDZMYVUzTHQ2ZlZzNS9waldLbHNDczFR?=
 =?utf-8?B?UHhLU2dvbXlIbXFTY2NpdGVjTEkyT3l6bVlqZ05tMjExSzg0cUZtai80ZVVS?=
 =?utf-8?B?VWcxQUR3bzJDU0FROWpxNUZuUUhqdG1tKzE0allKRUZIZEpVM09HUEpTbkZu?=
 =?utf-8?B?SmQvaUR0OHpBUThiNFVubWNzRXgxb3N5YS9GMGwrRUZOcXJEcDNqcVF5MWpF?=
 =?utf-8?B?SzRCU1UyRVpjem1LWnA5NnhuMkpLc0VBZHp1emJPWFdzRE1UZGtleEtlN0pB?=
 =?utf-8?Q?r1HwsQ8rvh8VD2Gym6lQ/p6qX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c932de-8729-4f20-b73b-08dcff3d5cb7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:03:39.5534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fmg0RIYa/NNyIEOyisSLrxMU7GTUdYlUD8GJmeecG1MZ6qyKMpg5x2P89CMRiySt5BxtFjxlpRwPogXcjH3o9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

On 11/7/2024 08:15, Mario Limonciello wrote:
> On 11/6/2024 14:25, Mario Limonciello wrote:
>> On 11/5/2024 14:22, Hamza Mahfooz wrote:
>>> From: Tom Chung <chiahsuan.chung@amd.com>
>>>
>>> [Why]
>>> In certain use case such as KDE login screen, there will be no atomic
>>> commit while do the frame update.
>>> If the Panel Replay enabled, it will cause the screen not updated and
>>> looks like system hang.
>>>
>>> [How]
>>> Delay few atomic commits before enabled the Panel Replay just like PSR.
>>>
>>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>>> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
>>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>
>> As this is an issue reported in the drm/amd tracker and we have panel 
>> replay in 6.11.y with active reports of this issue a few other tags 
>> that this should close and associate with.
>>
>> Cc: stable@vger.kernel.org # 6.11+
>> Fixes: be64336307a6c ("drm/amd/display: Re-enable panel replay feature")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3686
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3682
> 
> And one of the reporterers for those bugs tested it helps their issue,
> so here is a tag for them.
> 
> Tested-By: Corey Hickey <bugfood-c@fatooh.org>

Tested-By: James Courtier-Dutton <james.dutton@gmail.com>

> 
>>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 111 +++++++++---------
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   5 +-
>>>   2 files changed, 59 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/ 
>>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 570640c25b4b..fdc1d2d1afd9 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -8863,6 +8863,56 @@ static void amdgpu_dm_update_cursor(struct 
>>> drm_plane *plane,
>>>       }
>>>   }
>>> +static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc 
>>> *acrtc_attach,
>>> +                      const struct dm_crtc_state *acrtc_state,
>>> +                      const u64 current_ts)
>>> +{
>>> +    struct psr_settings *psr = &acrtc_state->stream->link- 
>>> >psr_settings;
>>> +    struct replay_settings *pr = &acrtc_state->stream->link- 
>>> >replay_settings;
>>> +    struct amdgpu_dm_connector *aconn =
>>> +        (struct amdgpu_dm_connector *)acrtc_state->stream- 
>>> >dm_stream_context;
>>> +
>>> +    if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
>>> +        if (pr->config.replay_supported && !pr->replay_feature_enabled)
>>> +            amdgpu_dm_link_setup_replay(acrtc_state->stream->link, 
>>> aconn);
>>> +        else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
>>> +                 !psr->psr_feature_enabled)
>>> +            if (!aconn->disallow_edp_enter_psr)
>>> +                amdgpu_dm_link_setup_psr(acrtc_state->stream);
>>> +    }
>>> +
>>> +    /* Decrement skip count when SR is enabled and we're doing fast 
>>> updates. */
>>> +    if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
>>> +        (psr->psr_feature_enabled || pr->config.replay_supported)) {
>>> +        if (aconn->sr_skip_count > 0)
>>> +            aconn->sr_skip_count--;
>>> +
>>> +        /* Allow SR when skip count is 0. */
>>> +        acrtc_attach->dm_irq_params.allow_sr_entry = !aconn- 
>>> >sr_skip_count;
>>> +
>>> +        /*
>>> +         * If sink supports PSR SU/Panel Replay, there is no need to 
>>> rely on
>>> +         * a vblank event disable request to enable PSR/RP. PSR SU/RP
>>> +         * can be enabled immediately once OS demonstrates an
>>> +         * adequate number of fast atomic commits to notify KMD
>>> +         * of update events. See `vblank_control_worker()`.
>>> +         */
>>> +        if (acrtc_attach->dm_irq_params.allow_sr_entry &&
>>> +#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>>> +            !amdgpu_dm_crc_window_is_activated(acrtc_state- 
>>> >base.crtc) &&
>>> +#endif
>>> +            (current_ts - psr->psr_dirty_rects_change_timestamp_ns) 
>>> > 500000000) {
>>> +            if (pr->replay_feature_enabled && !pr->replay_allow_active)
>>> +                amdgpu_dm_replay_enable(acrtc_state->stream, true);
>>> +            if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
>>> +                !psr->psr_allow_active && !aconn- 
>>> >disallow_edp_enter_psr)
>>> +                amdgpu_dm_psr_enable(acrtc_state->stream);
>>> +        }
>>> +    } else {
>>> +        acrtc_attach->dm_irq_params.allow_sr_entry = false;
>>> +    }
>>> +}
>>> +
>>>   static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>>                       struct drm_device *dev,
>>>                       struct amdgpu_display_manager *dm,
>>> @@ -9191,9 +9241,12 @@ static void amdgpu_dm_commit_planes(struct 
>>> drm_atomic_state *state,
>>>               bundle->stream_update.abm_level = &acrtc_state->abm_level;
>>>           mutex_lock(&dm->dc_lock);
>>> -        if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
>>> -                acrtc_state->stream->link- 
>>> >psr_settings.psr_allow_active)
>>> -            amdgpu_dm_psr_disable(acrtc_state->stream);
>>> +        if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
>>> +            if (acrtc_state->stream->link- 
>>> >replay_settings.replay_allow_active)
>>> +                amdgpu_dm_replay_disable(acrtc_state->stream);
>>> +            if (acrtc_state->stream->link- 
>>> >psr_settings.psr_allow_active)
>>> +                amdgpu_dm_psr_disable(acrtc_state->stream);
>>> +        }
>>>           mutex_unlock(&dm->dc_lock);
>>>           /*
>>> @@ -9234,57 +9287,7 @@ static void amdgpu_dm_commit_planes(struct 
>>> drm_atomic_state *state,
>>>               dm_update_pflip_irq_state(drm_to_adev(dev),
>>>                             acrtc_attach);
>>> -        if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
>>> -            if (acrtc_state->stream->link- 
>>> >replay_settings.config.replay_supported &&
>>> -                    !acrtc_state->stream->link- 
>>> >replay_settings.replay_feature_enabled) {
>>> -                struct amdgpu_dm_connector *aconn =
>>> -                    (struct amdgpu_dm_connector *)acrtc_state- 
>>> >stream->dm_stream_context;
>>> -                amdgpu_dm_link_setup_replay(acrtc_state->stream- 
>>> >link, aconn);
>>> -            } else if (acrtc_state->stream->link- 
>>> >psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
>>> -                    !acrtc_state->stream->link- 
>>> >psr_settings.psr_feature_enabled) {
>>> -
>>> -                struct amdgpu_dm_connector *aconn = (struct 
>>> amdgpu_dm_connector *)
>>> -                    acrtc_state->stream->dm_stream_context;
>>> -
>>> -                if (!aconn->disallow_edp_enter_psr)
>>> -                    amdgpu_dm_link_setup_psr(acrtc_state->stream);
>>> -            }
>>> -        }
>>> -
>>> -        /* Decrement skip count when SR is enabled and we're doing 
>>> fast updates. */
>>> -        if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
>>> -            acrtc_state->stream->link- 
>>> >psr_settings.psr_feature_enabled) {
>>> -            struct amdgpu_dm_connector *aconn =
>>> -                (struct amdgpu_dm_connector *)acrtc_state->stream- 
>>> >dm_stream_context;
>>> -
>>> -            if (aconn->sr_skip_count > 0)
>>> -                aconn->sr_skip_count--;
>>> -
>>> -            /* Allow SR when skip count is 0. */
>>> -            acrtc_attach->dm_irq_params.allow_sr_entry = !aconn- 
>>> >sr_skip_count;
>>> -
>>> -            /*
>>> -             * If sink supports PSR SU/Panel Replay, there is no 
>>> need to rely on
>>> -             * a vblank event disable request to enable PSR/RP. PSR 
>>> SU/RP
>>> -             * can be enabled immediately once OS demonstrates an
>>> -             * adequate number of fast atomic commits to notify KMD
>>> -             * of update events. See `vblank_control_worker()`.
>>> -             */
>>> -            if (acrtc_state->stream->link->psr_settings.psr_version 
>>> >= DC_PSR_VERSION_SU_1 &&
>>> -                acrtc_attach->dm_irq_params.allow_sr_entry &&
>>> -#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>>> -                !amdgpu_dm_crc_window_is_activated(acrtc_state- 
>>> >base.crtc) &&
>>> -#endif
>>> -                !acrtc_state->stream->link- 
>>> >psr_settings.psr_allow_active &&
>>> -                !aconn->disallow_edp_enter_psr &&
>>> -                (timestamp_ns -
>>> -                acrtc_state->stream->link- 
>>> >psr_settings.psr_dirty_rects_change_timestamp_ns) >
>>> -                500000000)
>>> -                amdgpu_dm_psr_enable(acrtc_state->stream);
>>> -        } else {
>>> -            acrtc_attach->dm_irq_params.allow_sr_entry = false;
>>> -        }
>>> -
>>> +        amdgpu_dm_enable_self_refresh(acrtc_attach, acrtc_state, 
>>> timestamp_ns);
>>>           mutex_unlock(&dm->dc_lock);
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c 
>>> b/ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index 31441f0ec4b0..64a041c2af05 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -265,11 +265,10 @@ static void 
>>> amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>>>        * where the SU region is the full hactive*vactive region. See
>>>        * fill_dc_dirty_rects().
>>>        */
>>> -    if (vblank_work->stream && vblank_work->stream->link) {
>>> +    if (vblank_work->stream && vblank_work->stream->link && 
>>> vblank_work->acrtc) {
>>>           amdgpu_dm_crtc_set_panel_sr_feature(
>>>               vblank_work, vblank_work->enable,
>>> -            vblank_work->acrtc->dm_irq_params.allow_sr_entry ||
>>> -            vblank_work->stream->link- 
>>> >replay_settings.replay_feature_enabled);
>>> +            vblank_work->acrtc->dm_irq_params.allow_sr_entry);
>>>       }
>>>       if (dm->active_vblank_irq_count == 0)
>>
> 

