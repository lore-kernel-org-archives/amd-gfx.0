Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1420CCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 12:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC5C10E50C;
	Mon,  8 Sep 2025 12:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9A2RhhM";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579C810E50C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 12:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwnnqfaKebiuNR6qiuLzTin0jZF3/vA5eSbvBF+X51fq1N06JBYu+j6NsXm8IPDUFBlwY02ANMGs/pjSCDTK0nEUWL8nlafB0Q7Js8Sb70BP92yIs8vwKHHCWCVrpZbzNFbwEontqoOKgYbrUYwO3P0DSbtv5Ol2wxP3S3zRCnVu1J1H49fofo12qAdfbFf7EeFgqv5UKq79+sYXm1Ol+mClcs/RyhE7hjzb0mFSjgzu8GWTdR1Pmn9ZgKF6Csd1A07N27vUcdfUU5UOs8+3sqWB2NfxiW3+ZKGyNO3cxA6oOS9VNu6DpfmiJvwT8hZpkRE03YyIvpzhrwY83hPnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gFEUpivJ9pwXYTmzM6tCvAs+AD51grR+OGrryzXiGk=;
 b=OIVG3MAPTVgxcQ77N0W/XVKRrQuPBsj/9zGaVhpkcbe2ntjcbvISJEPAb8hxGGTjQ8q6wwP42pEBotGOt+hGkydti9e/HE2a4Jq2GJHD5vYHSmBpg3SK45oTqtsnirtxv10rs9Gh5Yz6R5SWiPsyTpsYwepzuZsbowftT/GS0FpQZNsSW8/P4yK+6kj6Z0TZjLXu0L0cmtqruK5tEc9uelZ9Ly5BXyiM1eLuWtOMfT4PVzlEGUGhhyNhMan3RErlNlhtJaqhNha7P2sMTqbk9DO13MDXs2Oix7IPMSM12QYm3m5Byo7rzJhQIvJtfMMiryQdwh2gnl/JeMFUHqs1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gFEUpivJ9pwXYTmzM6tCvAs+AD51grR+OGrryzXiGk=;
 b=W9A2RhhMu8X3EVg3wedw8LxJMVcwnFPxTDGKbMywbMGVy/Qpi98S1xgJdHO1TINNh7e9JMfps5rM2JsoaKPHISEdvQn0HZTFQfyACeoGy6EcoH6d0rq25fENtlHVRcdEGbkcIfrmNDeESGTjHQjUz8GxYowmJAU6m4CctfmbUbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 12:54:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 12:54:11 +0000
Message-ID: <8c919bc1-0ea5-4b73-b73f-657adb6a8f50@amd.com>
Date: Mon, 8 Sep 2025 14:54:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <20250905124742.11305-2-christian.koenig@amd.com>
 <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
 <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: d27b9146-dcae-4569-1b0d-08ddeed6ce52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGpDSU44TXpRWmVMVFRFL2MrMDVmL2VTU3Vqc2thbVRPNDY1NExKTVBSTzl1?=
 =?utf-8?B?S2U1c2VMbFl4blpMTjJmYmoyL0FibkdoOGRlQ3RoYlVmcG4wc0wvZG9YZXFI?=
 =?utf-8?B?YWQ4NTlvcmFwTnVMc2JMOTd3bCtodURIeWltWDhvU0RSb1J0TTZqS3diRW9x?=
 =?utf-8?B?RktTUk9hQ2NrUUowRi9JRWg1NFdSZ0dNOFlFODhySndORzcyTmxLSVJOYVp3?=
 =?utf-8?B?bksrUjBkSTllRHBKa1M4eHFEdXNEcXRncE5uaktIUzh2WGNJS2ZWVlRDSE1j?=
 =?utf-8?B?NmVqZitXeDZQTkxqdlVSaVZKbm5leG1zWEt0UmcybTI5TDROWDdNUFljUlBI?=
 =?utf-8?B?Q09Qajl6QzVGdXZ0emVPN0xOM3ZqSXJhOTJ3NXVVK2xmclc3ZzJFa2YwYzJR?=
 =?utf-8?B?cm1XV09KL1h1bUsvRmVvcTdYNEdBYWNYV01kREowVWJDOGpvZ1IyNlJ3UXVB?=
 =?utf-8?B?cmtvaFY4N1JkTjI3YXFYT3dTTGZZRXljSm9TcUU2ZjlqSmJHTHlXUW5NWm1K?=
 =?utf-8?B?bHZ6MUp0dkw1eGpjWHFnMXhFOEJPc05YYjUzT0F0aVF5SG5zMENldzN5a2Vn?=
 =?utf-8?B?amYvenNCVHhsL1pmc04xWitWcnlCTUFybFdvV2Q1bjZnUVhVZjl5bUhSdVE0?=
 =?utf-8?B?S1hVcVhham9XSFVuVEN3bC9ISHdPZnQ2U0pDNm9iUkVSQXBQbFlaZjEwUG5T?=
 =?utf-8?B?cTNJcTF5cHplci95d1JPV3k5WWNxaTRuaUxvS0ovMnRxdVBmUUk5UVVibXhR?=
 =?utf-8?B?Qm02Y3I1TTZaUFpoU1BoNDBjbjJadThYdEVFSURVcGJTSzlpNStKaG5EYVlE?=
 =?utf-8?B?YUZhVnRaUFlaMnFOeFQ2NDlMcUtOYkF3bUlEVndqUzgyeHNSS0FoWFh2SGtY?=
 =?utf-8?B?d0tJZEs0cFpCWHRLamozUFVrcUxzZFB5dlpZb1ZuY0x2a29kTzBhL2JZZjdQ?=
 =?utf-8?B?akVwdVJXVmxzNTFhNkNGWFlJUk80a2pkWEx3T2RscHE5Y3dSMHZBMEdIYk9j?=
 =?utf-8?B?aldKNXFtWnA5NDMzYnplL0lyQXY4QktNVEQzZi9kTlBPbG1rUDVUakJpbWQ3?=
 =?utf-8?B?UjZxR0pKRW91dTRhTTBhd0tzZ09JR3NDdHhkWWswNExTMm9wVVFmZTZuVHFM?=
 =?utf-8?B?b1EvNlFod0ErNEM4V3JDTGR6eTJhZkd6a1FPdDVQNGNwQ1RaZldsakpFTG5k?=
 =?utf-8?B?YmhYT3ZpcStBZGZ3Q1RrK0dvR3JPancrdmdnZksySFVGYUtuczU1VSt6UFZi?=
 =?utf-8?B?NWVpcFNKK3JhdWlZa1p0eXRabGpqZ0tPd0dpYUhyZ2dHU04wb1dUWmhPTS9q?=
 =?utf-8?B?ekxESkdJazhtZVNwVzd4MkoxNWNMWFN4NHFtZ2NCSHJvRUMrSmJ2SDA1OG82?=
 =?utf-8?B?QURtMXIxOVZMN3VNaVlSZ0c3VnltNWFTTlRuMWdLazAyN1FNa3BHV2ZXVkg0?=
 =?utf-8?B?R0N6dXFzS0x5K0g0MDNDSXVxRTY2VUwzMEp5MS9yVGRpallwNEFHckpGV2xR?=
 =?utf-8?B?QUhIeGo2a241eXFFTXdUVjdqcldsVUtLVVZjYzNNRnlHRTZWN00zQVdlUnNl?=
 =?utf-8?B?K25xbmNZbGFJRkdFcXlpYVJMWGNhWEFaUVcxQm9WY2RpQzJDMU1tRnpwbmRs?=
 =?utf-8?B?dGJPbTRGaVB6SXlsN0szRHR3RThOWVlZNGltMUZHc3NjaVg1U3JyMlpvWloz?=
 =?utf-8?B?VkFzb2NVR1JZYzZZbGdHR2w1MXdFY21SMlNyQTRRN0U4QlZiOExwOVJQN3NB?=
 =?utf-8?B?YThCazBNMWR6ZXRNNVRaN29lZlg0RmlOQ21LMzA1czZGaEJsL3BTL1RNRkFL?=
 =?utf-8?B?MHZjWDlOYTJjQlhZUjFyb0gzMVo0RnRDNmZqQnhzUmptTlZFdHNHUGsxWkxS?=
 =?utf-8?B?TC9nK3N2ZTdwTnRjMS9pSjNkUkZvd1VvUU52NHcyN1pKUEtqTlpvZmp0SHhr?=
 =?utf-8?Q?C4d6lRs9fY4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjUxRk9pZ1dHSlpBdzFTS21SK0F6dHprZzBaVHRIZzFOVjBHUWs2VFRSZ0Jt?=
 =?utf-8?B?V1F0c2U2NXJmejAxUDJrQVZpSzBmTHpHOHNvMzhrdVVIbHcxWmtyNkxxRjNz?=
 =?utf-8?B?TktMaWg3TkFOVDgvSFMrWFMydmtacGtGNGRSdnNZUEZRanFBc1NjQlVqbDh4?=
 =?utf-8?B?MjdUQ3hGNXl0TzdIa2x0bXFBbFBMdllWYjlNQWVzL0p4UlRCa0l1Zi8vd2NI?=
 =?utf-8?B?MkVoYUcvRTZNaW1SQjFFWWtKWU93Z2I3RmxnU2J0SWVkSGdUdDdWTGF4T0pL?=
 =?utf-8?B?b3kybEdXbCszRjN6bng2MWhjYzZDd1hvb2s3MUF5cWxFeXh6dE42RVE2OGpr?=
 =?utf-8?B?VDJGSzZnN0paMTc1ZGFLaW9taW9sTWN5MFZ4Z3UzOUloWm0wTFBBWm1jWEFD?=
 =?utf-8?B?Vm9VT2pvUE5QRXZQQU52eXdmd1Z5VkRHRmxEeTEyK3ZmY3NualM2dDFHSVhQ?=
 =?utf-8?B?MGhkUVIvY3N5d0xDb3FnTVF4T2NqaGxIYnFBSnBCOU5BKy9OMklrNXFWdm8v?=
 =?utf-8?B?NDVyMGZKOVYwVjJiNXo5VWhFbTd4WWtPa2R5WUhKWkQrQ3FKNHJNdjRrbjYz?=
 =?utf-8?B?TUdYNW1MWlVHYzZGRWI1bUQ5QW1TOFJyUEN6N3BVeXh2RGM3SXdLV1JYQVN6?=
 =?utf-8?B?TEVqUDJGL3V1OUEwRU1RMEZWWmlWdDVrMTZMS2d1Z0Q4L3ZOOExHbzNtS1Js?=
 =?utf-8?B?NzlFOWU5bkJvNnpDM2I1VXZIbXVZcEIyOEJVM2RYSXphalNPUForRkt5b1FE?=
 =?utf-8?B?M0ljbW1kQTljcHpGZHJPT3hvZjZOaTdUbnlTejJaZ1NCbzZaVThGejNXZklo?=
 =?utf-8?B?ZzlnL0tOeCtIS1RJRDZydzA3Ykl0Yk11NUtCYVhqenZzM0NlVTZhY1l6a0hv?=
 =?utf-8?B?NXlVYTN5ZTNnWjNRL1FuMk5JMmZQeXM2d1l5OFhmcUhwdGpzZTRUcG4vYmJO?=
 =?utf-8?B?Y0kxTXBqVzFEQ2d1MlhXdEpwOHFZb0RzYm53SUJyVGU1MENMaFc3ZGgyNXBn?=
 =?utf-8?B?aHQwcExqNGVxejdXUDVtbUJFazZRSjdWdTYxL1pUR0V5clU4QjVIaUcvKzR1?=
 =?utf-8?B?WE5BM0ZTbTcyejhZZk9tM0pCRy91Zy9MM2swWGkzWHhEbldlN0tlNERaSHlL?=
 =?utf-8?B?RFB5U09FVE1aejBKYmErUGR2T21FYUhEM2NhTG5RZWx5UkNteG1qUjhOVCtQ?=
 =?utf-8?B?Tll4ZW5vSEpTWGU3bGxvcklRVmw4dmx4SERxdCtETjJ2cHJnRUl4dFNYVGZV?=
 =?utf-8?B?RnBJa3FzZkxxVGh2MG9tRWoxcGdSeFJTck9wd2tVbU9sWTlMS2N0TmFLdjEv?=
 =?utf-8?B?dGNtVXJtamplZGdSeTUxazF2djNyODNNdUt5a2U1eE1LR2JzVFZEYlQvU29a?=
 =?utf-8?B?STBNdjJpRllVemNlamNhckZzYmg0ZEZvTnBGcjBmOUlVNWI5ekU4QzlrNnQv?=
 =?utf-8?B?TXpWWVQrOHNLTVgzdWVZSEVpYTJDTW5ZbkE3bHM0TUxJTkxlVzVWVG9DSG9K?=
 =?utf-8?B?bWhYRG5zenFBbXl3ck9XN3NwOVJkYW5NdWNseHFyd2lyU0NZTFA4QnFHVXNz?=
 =?utf-8?B?QUxoSVJ1bC85djJqeUphS05xdjdHZmRYYWIrZEtTWkZjVWxQY1J6V3huTzlR?=
 =?utf-8?B?R2xCdnRvYlY3ZE4vaGQ2MHBaWHAyUmdZbzZzU3lXeUI0SHpHY3dMcUFHNkFW?=
 =?utf-8?B?OEFMOVpWenora0VlSFhhNnprUkdxS0NzZUZwRUIzTW9qVWY1Rk96RlBYY1Zw?=
 =?utf-8?B?eXJ6WGtFRUppSUtsTVpwckhPSmIrTDJZVU1hRkNpQmxZc2NCWWhwQngxVTc3?=
 =?utf-8?B?Mko0VzYxQitVMDVIemFPZVF4dEVTZGIrUk1lNDh2N1hTOXVMWnRFVUNRdXI5?=
 =?utf-8?B?eWRTT0xrcTNxeG50Qm1YRUwyMnUyZmlzRFZqNnZhaHUvTWtlM3RGVTExOERl?=
 =?utf-8?B?TU1CVjNGbEszeDhUOWpaTGxFazBXTzZ4aENiYWNUY3JWd2pPSCtaMjZUWTho?=
 =?utf-8?B?dnA0UXMxbDhDZXhvYzVkQ21wbThJMGxVYkluY3JQOExQR2VxVmRSZVlvdVRI?=
 =?utf-8?B?YVZPeS9QdDdoSVZ5Qkx5c1JReDJoQlN6ODJ1cSsxSlJMNkd2L0xZNzZOT0lY?=
 =?utf-8?Q?r6jGW9iKgtCSceQcaDCuPU+1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27b9146-dcae-4569-1b0d-08ddeed6ce52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:54:11.3263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk7XpfXmOzkuZuDb74bUU/TydwmUWbeOYQjaQofDW4LZk/4in7yKMosE/SMDuIU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
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

On 05.09.25 20:39, Liu, Shaoyun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> I can confirm that during world switch the entire gfx block (including gfx, compute and sdma for gfx10+) been switched together .

Yeah, but that simply doesn't work as expected.

The problem is that the world switch can't preempt running gfx shaders and compute shaders only when CWSR is available.

Now what world switch currently does is to wait for the gfx draw to finish, then pause the gfx queue and then other the compute queues.

When gfx starts first that approach works, but when the compute queue runs first we then try to preempt a compute queue which is waiting for the gfx draw to start.

Since we don't have CWSR for this compute queue this results in a lockup at the moment.

Regards,
Christian.

> 
> Regards
> Shaoyun.liu
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Friday, September 5, 2025 9:32 AM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; timur.kristof@gmail.com
> Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
> 
> On Fri, Sep 5, 2025 at 8:47 AM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Gang submission means that the kernel driver guarantees that multiple
>> submissions are executed on the HW at the same time on different engines.
>>
>> Background is that those submissions then depend on each other and
>> each can't finish stand alone.
>>
>> SRIOV now uses world switch to preempt submissions on the engines to
>> allow sharing the HW resources between multiple VFs.
>>
>> The problem is now that the SRIOV world switch can't know about such
>> inter dependencies and will cause a timeout if it waits for a
>> partially running gang submission.
>>
>> To conclude SRIOV and gang submissions are fundamentally incompatible
>> at the moment. For now just disable them.
> 
> Are you sure about this?  Thinking about this more, most gang submissions are between gfx and compute.  The entire GC block (gfx, compute, and sdma on gfx10+) gets preempted on world switch so all of the active queues would be preempted.  Everything gets resumed when the VF gets switched back.  VCN/JPEG gets switched independently so that could be a problem if you have a gang with VCN and GC, but I think all gangs within GC should in theory be ok.
> 
> Alex
> 
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 2ac9729e4c86..434a551365c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>                 }
>>         }
>>
>> -       if (!p->gang_size) {
>> +       if (!p->gang_size || (amdgpu_sriov_vf(p->adev) && p->gang_size
>> + > 1)) {
>>                 ret = -EINVAL;
>>                 goto free_all_kdata;
>>         }
>> --
>> 2.43.0
>>

