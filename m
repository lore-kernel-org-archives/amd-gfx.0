Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7B8D10F5D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 15:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFA210E657;
	Wed, 26 Nov 2025 15:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kegwYW9z";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C80910E657
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 15:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxK5rEIrL8jPbG5wjh9o8GW8mgR7wzszFSDFPianr9yrCChI/MdWLWLI+6UqgMxnufdwKLwewczHgN4gRCeoVGh/+mYINQE9OR7cwIU/WDCjgP1mqnd9s1UeTjbdzkzcgov2GUFhwv9GI4IXOAEtjr78YiuV0Z1/9bfUfyJoi0KHalfQaVXwmRmZJ+DlVRLhyCc+ceK/MyJ7c+Yse7Hk1YGKGKhS9SvV2vByOKNkgvxJuyjTwNN6U05Cs60nfcZDudsBS5j2bPaVV2XKyTIIsKzmJWxK4GrQbP7ZIQxpglDUN25sXWUxTZpJ+/EEnUOdHfBuJv6/E39pl5ggGjGkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFD4LsK9ZuIEreAKwi+njtmgFFJ0XHvLSI0JAet05DI=;
 b=q1KaYl2rqORIAvEoKGwH4UUTaTytu3411413SQhF2EgF9j+eEe+mGSqJGcyZY7UFcKREs8CFcd1lumSXf/4gy2ZUCqpZa27CkgBNj3J8Rc6jsaWGPbB0dTWMEecgDqE8flnZp1EcyHwowvSa1SFPO6GoikzlutGUUmzjBrVSedu2BncpGqX4ETf2edCVWjapUGwk9lcU9cY9lO49+OQGM1fMlV9TJAxMtijvUJr/RZ1COJfH+fHscFp5q6IQxyjuSufwy3Ws+cSXKrZ2dTzYbEm4Y32lwDkjqdxKK7iGOPQJZ6WlRS2Awg/eHOA18pOg5cFI6xGYZlX+FmXEojXYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFD4LsK9ZuIEreAKwi+njtmgFFJ0XHvLSI0JAet05DI=;
 b=kegwYW9zwCoNIE3tiH5hPdbMpZei3H0pSlbftEUDwqanVYV0AtZ8gkHb3sBp3Jo/hnWk9Kgbw8L5aW7kNh2B6Z5PWy72nNOQVl86yLbK5o8OK/Dz0ycCDnFI1J9UP01MtmQRzt9ybuU/tImOm1+9EIx3HZ5rzY07tTDIuBH+Q2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:04:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:04:57 +0000
Message-ID: <0bb74716-579d-4bb9-8988-3366ed6efadd@amd.com>
Date: Wed, 26 Nov 2025 16:04:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] drm/amdgpu: Improve page fault handling on GMC v6-8
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251126132952.150452-1-timur.kristof@gmail.com>
 <b4747792-6f2d-4875-88e7-5ed953f94fd7@amd.com>
 <CADnq5_OQz+icin-nO7Zy9qMOB97sw-igm-2f8UPPgx5N7z8Y1g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OQz+icin-nO7Zy9qMOB97sw-igm-2f8UPPgx5N7z8Y1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0990.namprd03.prod.outlook.com
 (2603:10b6:408:109::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3a26b9-40f5-4dda-22c3-08de2cfd2974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWY5dTZDTmU2cUFITndteVRneitURndQeEcvY1RoeDQxN1hXQkVnbGIybHdq?=
 =?utf-8?B?aGJaVUdiSEZsaVNxN2x1bDFod3laVGpzNTE3bWxtdTAwTDRBRTZUN1BHYThG?=
 =?utf-8?B?SHdJTjJuYnJaZkVDbTJhcjFQUmRxbUg0K0RlNlVzMGNxQmV3ZmEyWi94T0RQ?=
 =?utf-8?B?OUVIdlRiWTlEbDc2Y2NScTZMWVk5Q3JJTjFpRWRWZk10b3M2QUtNV2cyYk1R?=
 =?utf-8?B?bnlUaGNEb2hCbmJPd1JxZUx0aVM3ZFlUbHNSR3NVR2tVaWJaUTNrOU1NT3Z6?=
 =?utf-8?B?N25IM2pBcDlHYi9VVWNBTFVieHhVYXo0cHNWamlVYVd0WWtVTjk1VVlRNFJC?=
 =?utf-8?B?QjFYdnVURFdHMUErMUVUVnhEcHVUcllMLzdSWkxyRHRrRUFtekpJTURtL3RI?=
 =?utf-8?B?WnBrZjBHSHhxWTVSL0xyYlQyUHBUdittQUQzcUhiQzdGNk9VL3lVRnhMMnFx?=
 =?utf-8?B?SDhmZkJoUGQ3VllpR3kxVWV3RjdCb1pFcEsrLzlORytSVDdaN1k0aFpxNDRO?=
 =?utf-8?B?djFQZXFjUkdyc3JsRVk3WjFYeGFURGluVU4xVHRQR3c4cTUxS1MzbkJhamF4?=
 =?utf-8?B?aWh4b28yYkpKbFNqRkNRTXc2SkNrUWl1Qk45dzk4NkhHT2NtZGx2V0dDbkFL?=
 =?utf-8?B?MzFLUDNNTWV2SG92SU0zQnhpRXB1cUVxMTR5aHJCR2ErcG9GdDR0Y3dCWU5H?=
 =?utf-8?B?bnpLUGIyTlpZNkdJTlpveDFoaXhmdVc2N0JsK1B2c2hXL05YWW9pNjFTY2I4?=
 =?utf-8?B?Z0ZTNmpKdlBINFlFcHhQOUoraHZUazRCOTZ0OEVqdnlkNmFBbHl2cDFkNEdC?=
 =?utf-8?B?QkYyam1JenNYa2NBaFBHRWJ0K1lVeWE1TGRWdTBjNHp4SEdYemNjcS82RDMr?=
 =?utf-8?B?RS9vUG5abko1S1RnMEl2QXU0ZnlXaFh1SnoxSHVmUWxJQW1nQ0lBT1B3c2pR?=
 =?utf-8?B?dkNJeVA1aDEzMmlqaHlYcFNtKzNOV2lZNVdmQ3U1SWN0Vlh2cnVVdUZLNE5M?=
 =?utf-8?B?bFdoTktPSG1XNU0xTGNTOU91c2Jib2o4VnpGYU1TcVFqbTZQeXN2NEtaVTJS?=
 =?utf-8?B?YzdURnQzRnQ0R080aGt6ZkVLNW9idGJWaHc3cGxaNHFzSWp0WVhad21FS0xI?=
 =?utf-8?B?MmJyekpCWVRzVkUwc1RrOXhFajN2ZTFFK2VSTDErMENkOGtJU0czZkorR2ts?=
 =?utf-8?B?VTB3RUwxUDBIbkhzUThuQVVwVHFrMW5JaUNya1ExWU90M01RbllkbnYzNEpZ?=
 =?utf-8?B?Qk1TWnRiOHd1VkNDSGREQmhvVmxFd0llWFE2ek91UlU3U1R2UzlQbkVkZEVz?=
 =?utf-8?B?eVhqY0J5bnBvOFd2OXArN2hXQVlDb015czNOSmZISUVudm13OUk0cTFWY21H?=
 =?utf-8?B?ekoweSs5Wko4U0lJV3FkY2g0WTNlMTlwdHdOZzJzNmEwQjVDNnlkWldSVHFj?=
 =?utf-8?B?WjByNXpLYVdYa0RSbjllQjhQNXNkMzJSRnF5ZitoN2Zja2Y4aWpvWjJFWVhq?=
 =?utf-8?B?bkluVnhPaUlWMWgvbHl0bWNva2wzS1lmMWlTUWk4cXZMM0FTK1JlVjhvc0Nl?=
 =?utf-8?B?NmNkeWowZ0hiY01uaE5GdDMzeGJYQkc1RWszNktsVngzVEtiN3p2eWRKMjcr?=
 =?utf-8?B?WG96RXYvQ1U5VklBcGIrb25nWkVFWit4ei9SWkVaQm9tV2NIWEhWSGlXOWNh?=
 =?utf-8?B?T2d3UTZUWTEwcW12aCtpSllUWldISTdqOVJsbHJJblFwSmJnZUtwdkxlc2FI?=
 =?utf-8?B?dWtrYUM5QTI1MzU2MWxCMU5IcXQ2MzdZY2RjbEV5Rm9HRmN6aDdJbUlPWHc0?=
 =?utf-8?B?R0JYdmx6SFlBL3ZUNjFDQjI5Z2IvL1Q4akZVWldiUXR1RWJQWlIvK1o1WXht?=
 =?utf-8?B?eEtWQy9CSnJXeENpeENnN1R4Ujk5djUzOTE2blo5UWIvYUcyOE1hTDRsVU9Y?=
 =?utf-8?Q?FmtB/SCpkY/Uql9YTzR2hfmNboJe0gAK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmlsWkNNMFAyVDRPYjh0Y0hFS1NFbjlkM25OOEJpN3NWejZyS0NSK1VQLzZr?=
 =?utf-8?B?ZDhTd1AyeW0rRHorQTloWU5rem45OTRTWnNqN3ZyWlh6NjMzUmpqSncrdUJn?=
 =?utf-8?B?R2sxaGExUjk3V2ZCQnRaSGUwOEYyUHVReDBVS051S0tHcEV0MGVtemwyVWlI?=
 =?utf-8?B?a2NNbk83c3RPTXU0dU4wTmQzMXdWZnZsdlY4RVB5dVBzdy9zc1p6ZFlpcG1O?=
 =?utf-8?B?VXhydUhhTEdHSDVEcEF5YjdsUzR1aFdNUnp4dFd5UEhWeS9QSERtQ2E4ZHdr?=
 =?utf-8?B?bVRTQTIwZ0drVEVyNEtGU1ZVdnZnbE1XSSsvK04vTEFVOExwbEh5YlpnT3Qv?=
 =?utf-8?B?LzV5RHNnL1ZDd1ptc29EeTJrcHNLTkFFWE9xZnF2ODRkbFpmQTZ2WGJpZVF3?=
 =?utf-8?B?cHRaa0tsTjFPWkNGdFovNER4YkhHT3lPYjdhdEpTemFXWXh5V2NrYXdBQTZF?=
 =?utf-8?B?NVNTVEhWcmJhWmRXRFRneVpiYmZhR3l5WTNBS3ZMZVIzdWlLeEtOMndlaHBs?=
 =?utf-8?B?bVRPWkFqRnUyTG5RUlRvY1ZkRzdpWnVkM0MxdTdYTTcxSTRNM0EwdFJTWWR6?=
 =?utf-8?B?QTcxYVRhdlVSRTJkR1dFSi9KZTBRR1pxZmgyWjNSNnM0MmhGUEVXUUY5b2FS?=
 =?utf-8?B?S0RaZnFiY0VHQ3RwZWxNK25ldDBQbjd6a3NkZitFOTd6Vmg5ODdvOUh0NTlj?=
 =?utf-8?B?bEhta2R5ZGhTdWFBWEwvRldFZGpLdXdsN1ppY3c3VzBoNGowN3pOSVdpYktk?=
 =?utf-8?B?cE1zYzVoTXhIQUR0WHdKbUVQOFI1UFdQYXVpRkZnMnZvY0FWR1duRGVyamlI?=
 =?utf-8?B?Yk90M2EvVDdBNVdDWThreFhnN1dWUWJaY05DUWtTM3JmTEQ1RHJCMC9PZ0o3?=
 =?utf-8?B?YzVOcFl0Nm1laXdKRVptT1huSVVyYm9ndnRMeU9Hc21DTzZvTUhaMk5WN09J?=
 =?utf-8?B?SWF4LzkvejN4ZlcxTEkrWnFhNThsRVEwV1pxQ1ZCRnRLZENkNzNsU25sVERv?=
 =?utf-8?B?dW01WjdDNmkwdmplTExEa3hxWEJHZVpjcC94eGcrRE5LdGV3QzlZYll0aXpY?=
 =?utf-8?B?NTEvTmU5QU5vcVF6dVBHZkwrMHUybmVLbVBHOGJRaWRYNlkyVlk3NkhzM1pC?=
 =?utf-8?B?VDAwNXpLNnFuSGdmVHpqbmlrT3VLSEFGbUQ4OHRWdStOTUdDUXhWcHoyR2FJ?=
 =?utf-8?B?c1ZOakZKbUJHZlEwd3lkeEhSdkhCeXZibndqemFDMExGU09wc0owbnhyb2JK?=
 =?utf-8?B?SlpqTHQ0RzJiY0Y1QW0vSmRGNk1rU09nTTFMUkdQQ1QxUjdiNjJEVVV0SGpa?=
 =?utf-8?B?NGNJY3g2Q0dwRnpnd0k5V3IzemxHQU9pd244b2lZN2RnZkxLOFRRcWtPQ1pO?=
 =?utf-8?B?bEdPSjdKMGtvY1JJbGJjTkxrK0cxZXV1d0w5cC9qbjFUU0p2dnlmT0JVL000?=
 =?utf-8?B?YTdvaEphWVhxVnZRNE1nYXR1OWMyYnB5bVB2UUxMYUVyMjVFbXFNMGl3NUgr?=
 =?utf-8?B?QXEzNkh0OERyN0x3dTMraHFLK0dsai9wZ3hacE9TV3JDSWdMUS9zUzUzcjdu?=
 =?utf-8?B?eml2YmZHWnN1SnRCY2lleGthcFZQenYyamZjOWQ3dHRvSjlLeUtMa0dHbmNs?=
 =?utf-8?B?M0RkSlZsb0RQa1dtL1Zha25GM1RrU2N2ZTljNUprM2hlL1RmZEplbVVnVisy?=
 =?utf-8?B?akw1dWdDc0pUYWlLRXFDUldDbkZYN1lLbXBCMlczTXY3anlUV0szcFZiR1BN?=
 =?utf-8?B?dTZETzU2ZGpJSzlBWTJYODJGN2xBRXVIbXNmVXZSd1hsZ1l3ajduM2lsVWVt?=
 =?utf-8?B?K1l5VUpxMjF2cEIwa0Q5YmNMSzF1Q0U0OUtWd3RyVis2REFBK3dVTTE0L3Np?=
 =?utf-8?B?UXpXc1JZc2oxd0ZkZ2p0R1NkL01OOHNCRnlrblRsaStTclkwb1BUUHlnVVNJ?=
 =?utf-8?B?SVhxNU9SQVg1QXc1aXBEVFNHS1FIQnVCSEQybm4rUCt5R001YlFJeTJkSnQr?=
 =?utf-8?B?Vzl0RktOWi85UzBETTcrejgwMUswZTVvODFZQkxSREQweXh5cWRsdndoTGI3?=
 =?utf-8?B?a1l4Qjhyc1ZUM1Q5MXRDRjRaVzRWdFRIcEZYZldiS3dIUnN5WXNSaHdOa1BM?=
 =?utf-8?Q?zC94Q2wqY76eQGAWHgyw4R8zV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3a26b9-40f5-4dda-22c3-08de2cfd2974
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:04:56.8553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq6V4gU+5ex3mlMK+DAfeLbkTY0v+9Y9Wp2DVwOfTpZEQZLyikENd1FznRR2/YnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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

On 11/26/25 15:46, Alex Deucher wrote:
> On Wed, Nov 26, 2025 at 9:29 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 11/26/25 14:29, Timur Kristóf wrote:
>>> Enable the soft IRQ handler ring on SI, CIK, VI and
>>> delegate the processing of all VM faults to the soft
>>> IRQ handler ring.
>>>
>>> Why?
>>>
>>> On old GPUs, it may be an issue that handling the interrupts from
>>> VM faults is too slow and the interrupt handler (IH) ring may
>>> overflow, which can cause an eventual hang. This is a concern
>>> especially on SI and CIK where there are some HW limitations
>>> regarding robustness features with some shader instructions,
>>> which in practice means that users can see thousands of VM faults
>>> during normal gaming use even when the game or the UMD don't do
>>> anything wrong.
>>>
>>> With this series, we spend much less time in the IRQ handler that
>>> interacts with the HW IH ring, which significantly reduces the
>>> chance of hangs.
>>>
>>> There are also a few misc improvements to the GMC v6 code.
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.
>>
>> @Alex do you want to pick that up for amd-staging-drm-next or should I?
> 
> I'll be off the next few days so if you can pick it up, that would be great.

Going to take care of that tomorrow.

Thanks,
Christian.

> 
> Thanks,
> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Timur Kristóf (10):
>>>   drm/amdgpu/si_ih: Enable soft IRQ handler ring
>>>   drm/amdgpu/cik_ih: Enable soft IRQ handler ring
>>>   drm/amdgpu/iceland_ih: Enable soft IRQ handler ring
>>>   drm/amdgpu/tonga_ih: Enable soft IRQ handler ring
>>>   drm/amdgpu/cz_ih: Enable soft IRQ handler ring
>>>   drm/amdgpu/gmc6: Don't print MC client as it's unknown
>>>   drm/amdgpu/gmc6: Cache VM fault info
>>>   drm/amdgpu/gmc6: Delegate VM faults to soft IRQ handler ring
>>>   drm/amdgpu/gmc7: Delegate VM faults to soft IRQ handler ring
>>>   drm/amdgpu/gmc8: Delegate VM faults to soft IRQ handler ring
>>>
>>>  drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 12 ++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 10 ++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 20 ++++++++++++++------
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 10 ++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/si_ih.c      | 12 ++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 10 ++++++++++
>>>  8 files changed, 80 insertions(+), 6 deletions(-)
>>>
>>

