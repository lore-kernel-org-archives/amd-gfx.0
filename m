Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AF3C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1957510E1F6;
	Fri, 31 Jan 2025 16:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHSaR6DS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E61110E1F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caqWc7bwKpwT6f3uClSr1Cv+r/xULhMzknK1CNzwf4cNV/KJiKvRs0AvoLRQJXtfPnw0t9HxNh1xHzQkz78FVyTs7fS9VjuSOXARPZFh9VXbnbwz5nkgslMDCW1F9yh5ndndIUBNc23D/XK0iarUyrS112Ulu6TEFdnRzBq8wvfToDuVcuq/6BJytSupsGKJAkupVIABrHe47Jh58L4YHR6vCWMBP9SE0aYS3ArWvHI4usrLoSdIrOEb/xXJSy0ybmTDnd/tLG7R2nKtn4E9E94U1yJsNYgHgsLB2aN9GzeQ8tbpdCV9cSJPGApM+SXQtacw8KHWv3a5biuP8l98xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGefNjRGGzaokW/P5F0qyrOABrMGZiuTLSsFVHTI/sg=;
 b=eaxLIbs6T52dQfnOj5JVdxNGwkD2SItTkID3R56Wc6BTWEFkYRBKZMvLUxTK3CJN0glwY2DAZmgDvaqc7SajR0Yjas3XojNT9B0d9ZTkHTFiFdmAI3kWriK5Jfze88wAQR6jxMjxuiTO/MIT843ZeTVvaM1GEukBwVrTygc2Sv7QUz5ojRCik/BYkaOIiAeCObgDezH2zq8ozzeZmyPdATu8usagzZjqt2PlnOrbFFFk+x/dwVEkTz7EDTPvNs1BhNYhV8Oef1GaeDDOBrYgZj0FDgfzxSbftJgOQ5+hbIKZoWQ8JV6Rsa90+uBQYjW9hZ/n1+SHR2mzsVXbAUT20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGefNjRGGzaokW/P5F0qyrOABrMGZiuTLSsFVHTI/sg=;
 b=aHSaR6DSpx/ot3x6ghLZnIy40vaYV2DcwQjPM/xP3SorxWzaM7VzKVTB1ma4ffOyTIZcHaCmr07loBTOA3lRyZSF81V4RoCZnE3PJV6MzozTKLSim2U7gt31LtWXINvVavoc6Zuv7WeufREDjE2I76aLoRGHX/k81W/Gt+1mmVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:41:01 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 16:41:01 +0000
Message-ID: <8b9995da-269c-4a96-b374-09e40e0df605@amd.com>
Date: Fri, 31 Jan 2025 22:10:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <8371968e-e270-490e-9454-b521edceef37@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <8371968e-e270-490e-9454-b521edceef37@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e7a3b7-172b-48df-3350-08dd42160b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWlqdTQ1RldZWjRzbG0rbllhZFg5YVpoYUdyRDFsRDA0ZUozdkJ3QmF5QWVj?=
 =?utf-8?B?Vk4yVlB2aHBvZWJlcll2NlRVc09WcUd1RVFqOWdOWXRQWlF4c1NnZ1ZWK3Zx?=
 =?utf-8?B?R2FTSE1qb04rQmVscUZNejg4aE1oV0hHWWt2eWZMQXc0QysvNmhjNnFBY0p1?=
 =?utf-8?B?bGowbW9zZEhWeDdNd2lCMnhLWWNSc3ZpN3RHM0p1dXJVTEI2K3ZiekNGaENE?=
 =?utf-8?B?VmQvUUZkVzRNNndaMC9YYWtCcURQTmc1THluYzlGSkV1VWVBUWpyU3hCZndj?=
 =?utf-8?B?aC9qVkR4bVZ3cEk0RU9JSlJhaHJyN3h2NE5MZ2tBZXhFc2ZqWHRrT1I3Q1Jt?=
 =?utf-8?B?TmpjcjIxcVFZVFMyQng0bDhCWGJPVDh6eEU1SlhLUm83a3pZNmFlRENaUGE0?=
 =?utf-8?B?ZDlrb2gzZ1EycUZldklYcVJhOFlZOG5YYTNKYWNxd3hXekJ1bWFEaXpBZS81?=
 =?utf-8?B?ZEJhRUdXYkgyOUFqcFh1a0JaRHNHSTUydkFaRDdTekFmVHNBdE9pb0ZHakRD?=
 =?utf-8?B?REg5bWJHY1dzalFZM0R4YXVjNFBnUWs2YXRNNHZORHNBeWpFaGMzODExYjJv?=
 =?utf-8?B?UW55WnlGa09ZRTZoK0xtVGszVkRJRVp1SjFzclRUeG1qNkVDSWxXbEtoWSsz?=
 =?utf-8?B?bFFUbVErTFlYcm5BaWZZS2tEMG8za29ZNXB4WGxCTW5JWFV4S3pQTWJrd05S?=
 =?utf-8?B?QzNKN29uNWs1czhJK1crZENnYmF0MTk0WExuYjZKaWtEQmEweFZOdnpVeTly?=
 =?utf-8?B?L3MrUjNqZzVrUDROaWVSb3FXZzN1NkFpYnU3RTlkT0ZuRVE0U3FML1hGa2V3?=
 =?utf-8?B?R3BVVXNLUUJhTnU1eVFmUXVsSkNERlBHK21WdkNJcmk5WHdBaUEyRGlKSldG?=
 =?utf-8?B?M3RvNktkV0JmWWJUZ0d3Y0lMVnpqZXF0RXQwbEtWRmh1NDBzS0QzZW1CMXEx?=
 =?utf-8?B?a3REVVdLOENBN1dQWFJwNGs3YktaSFJpSWpVTmNwaTh4OHFpaGpXZlZ0aWx6?=
 =?utf-8?B?M1RvcWo3QVA5eTZYdEMrNnBWMmRGNmEzUUQwOWVFMU5sc1NlZjlFSlBYdHBw?=
 =?utf-8?B?UzRpTlBOWjBxcUxVNGlDRWtOK0lkU3ZmZWpXUGIzYlhDNHR4aU5jdGRQd1p4?=
 =?utf-8?B?ejdQMEdtT2NPTm00cFdiMEFMMFYvRTQraGxjbXFhTUVOeXBTTUZwSTZ3czNM?=
 =?utf-8?B?cW5Cdk11bmlyaDhERVA3VExGOUVEV3k3ZGsyL3Jyc1FSVnJJM3BKU0xzY05Z?=
 =?utf-8?B?RUgwaWNmeURRVWVLTysvYzhHWFQrZHVKWVNZUWxuWVVDVEEzbGhBVDVmc3Bp?=
 =?utf-8?B?b0h5K2ViVyt3WVB6Y0xNRldEc01nVXIrT0lPWjF4WTJUeC8wOXprWElsTzEr?=
 =?utf-8?B?OWUyQ1dQazdIYXlzWTBUUFdQaVRLQ2F1bFJVVXNCRGtYMDVPMk8rZlZpMjBT?=
 =?utf-8?B?VUxaZG83ZFRMd1QwN2UxTW54TkMwQzBvbk5HMnc1RkhlbGo0eG9sWlRwRksv?=
 =?utf-8?B?UlpQcUdta0Y4Z1dOY0JQbVFpUm5RQ09iYlJFVVRFcXExY0VndCtNZHJ6NTFs?=
 =?utf-8?B?aVV4QUxEblNzUzRjclU0dlZUcXBKYWxWMmI4NERoMEFnUUNEOE10RmVHNzlj?=
 =?utf-8?B?Y29hbURwRlRsMFgwY2QrR1JhdFVVMkp6Qndac0RqU0xRdFIyNS9rWW9mc1Rk?=
 =?utf-8?B?cC9tQVRqY1Z5MGptL1JvZFMvQzhOMFY4YzhNdVBwR04zTTZYUzlaWS9xdU8w?=
 =?utf-8?B?S2ZkWjBwZVN6bFcwbzNPc0Urc1BiNXlScXBjU05BRlpUVTZHaENBYU9WSmdM?=
 =?utf-8?B?dUJndTB5WW83UVduNG91TVdSY0ZCQjBnNjEzL2JqbTFMN0t6K01LakZyNlF2?=
 =?utf-8?Q?xF43nqWabWHqj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THo5UlFWRk1EZ2NZSHk5Zkw1MkVzc1B4amdtZHd2SGFaTnBMZURhUkRwYnJM?=
 =?utf-8?B?T2swb3dBK09rYzdMVm5lLy9nV1FZOWVwdXhjYW5RWW94N0dWMW9iNithQlA1?=
 =?utf-8?B?V2N2Q2FlRkgxam14ZEI5TVJISnFhUkMxMHY2dVFYTy9RS0xPN3djbmRUTzR0?=
 =?utf-8?B?bnkzM3ZUaHdUV3FHNGFVcUJZQzZWQzE2ZzREVDcwUi9ZTkhXbEI3TzRyWjlU?=
 =?utf-8?B?c09uVlRacXdRaGpmYVFmNjVxeVl2M2x0TVpmcmo1ODlHYTF2QTlRaktnNUtk?=
 =?utf-8?B?NEMyRTFoUkc2aXIvbnpnK3RSQ2pPSFJnVk1zWWJVR3FHQWVteXZkODc1Z1Jz?=
 =?utf-8?B?WG9JTUVZdExUaHlvRHNhb1hwODdiNU4yVlBpYjFyS2ZCamZIVWg0U3oyMjhl?=
 =?utf-8?B?eUQxUlQyVjNoY0dpTTRKUEJMeGhUZUFrT2xNSGwrTWJpbTlvR3diL1Q4ODE4?=
 =?utf-8?B?RE1FOHJPVkgzbHpudFI1OWRTcHRrcHNMTGt0ZU5kSjVpeXYzejBxZEVoZGdw?=
 =?utf-8?B?aGRyUzZzUndqM2RwSnRsMFJaN0t4R3dQNXBRSnlNZENYQUE0Z2htUUw0VlFx?=
 =?utf-8?B?MnpxSnRtZVJ1blVQS0tzeFIrMVJWcGNoWHQ3dFkwdHVMMDZKZWRibWhHREU4?=
 =?utf-8?B?a0pWd0xIbW51SFJveTFuTFhmSDhxaG81c2NCMFNFWVdFeTFmc3NqVzdvQitR?=
 =?utf-8?B?VTBuZXlvYmd4aVVKdHlwZHV2dE9XalMwZ1FLM0M3N0RaZW92dTcxZTNYYjRp?=
 =?utf-8?B?TVEydnhsR0JxNjJSeVEyQ29yajV1d2ZzU0ZQZUwvSWY0L0oxUzFucnZyRDdw?=
 =?utf-8?B?c2Mwa3Y5dXNpV29WM1MwTDVJS1dSRmxTaHJQL2gxVFB5RlRQYTZMWjNnajhh?=
 =?utf-8?B?aDVCWkplMzVZNmlYQThNNlBrTEFLMjBJVTdDSVJUVGVRblVVcjVTMVdUenhP?=
 =?utf-8?B?c1h6dkhxS1JZY2NUbXBKRURzZk5UWWFMYWRuT1pnSEtFbVdKaFh4TTVWZTJW?=
 =?utf-8?B?MmNQamdLVWp3NXRMS3VMa2p3TlJ0RzFkeE4zK212eVJCaldIY3duVHkxeDM4?=
 =?utf-8?B?MjBRWlQ2VTJoVzcvSTU4NWgyNkl0UkpOT29WYWVIWFdJdGdra1pLcDlWMkxU?=
 =?utf-8?B?UlVvS3FMT21hUUc1MGE5REptMlNEbW13dkt2Q0xVWGxrR1MvaXh5ZldXM0Vt?=
 =?utf-8?B?NkNDdmR3WGZqcTNaVjVxbmNrTUxkNXU1MFdGVkN4TjA1a2plb0xwU05pdzFq?=
 =?utf-8?B?TC9vbjRwQ2trMDhCbEJnMjk3WFlpU0tKSXp6ZmNXR0M0eU9wRVRUejB6c3Bv?=
 =?utf-8?B?UlFUNkpCVms2Qm5NRTFMTXZvNjVsYzBWeU5RUUZvaHd4ZVFFQWp2UXNZMEVv?=
 =?utf-8?B?UFVkOU9Dd2MzdVZHbEhyYWZ5cEVNYm1OdmxPSlp3a3dQbkNSL1VPNW5tQ3ZC?=
 =?utf-8?B?NTQzbEU4eUowdWxibUx5QXIzakljSENtbm5CQjJzWmlRQ2VqcVM5L0R5RHhM?=
 =?utf-8?B?Wm9tby9wQ04ybFFBTW9lVU41RWdBZHRKOWlYRGVNZllDWkpna0JzWGp0U2Ns?=
 =?utf-8?B?V2NDZCs3SHY5QmNaQ1ZHUjBWeWl3U2RKSng5dlZCV0lzTmpJVURWazhVZ0xh?=
 =?utf-8?B?M3dOTCtxQmVwQVZGZ1hFbUxFSHFUaXAvUkQ0VER1aFVJU3lPSGh3WktZbzhX?=
 =?utf-8?B?dCtyU2NVTjRtSkxMRTJCNk93N1BmUTRsbXNGUUI5UWZuSG5wYWxUWmZNeXY4?=
 =?utf-8?B?SVU2RkZ1VWpCa1NHR2o3RVVLQkFhYkZjVzM2YmU1eXVkWUEzY2pCT3Z5dzBX?=
 =?utf-8?B?ZmRUZ2Y4VHBJalFEL21nb0ZuMlBYblpXNnFCSkc5Qk9jK3M2ZnZJcGFDVFpP?=
 =?utf-8?B?Y01jOS8xUk83SGhiTjVNUGxveU43ZzhrOWxGU1NaUi9iUFpXS3ljVVlkYlpO?=
 =?utf-8?B?YkFMdC9KcEFzRis0YWoxaGxhdUhsMWF5QzhnV1BiTHlXSktFdkZsQXl3VG5H?=
 =?utf-8?B?Nm5Cbk5jMWErelR6QWF4UTE5ZWFoUFFpTkRBUUp3cndUd3NjT3EyYmIwbEVB?=
 =?utf-8?B?RnpYcU93VGxydUxYQTFIYWx3NVdiNWNGRVh5QnB3cmF0dkMrWm1XSHdaTjkr?=
 =?utf-8?Q?hUHblhAqxZj3Xy82MdQBmrjz7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e7a3b7-172b-48df-3350-08dd42160b7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:41:00.9140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkBKN5DIiZIEUq6DwKueYhibe/9NDPLBmRB/HrwXnQ8vDeDyX0O1ffsFW4kL2AhWfUlDVQU7IHhN9a6deh3gPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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

Hi Christian,


On 1/31/2025 9:56 PM, Christian König wrote:
> Am 31.01.25 um 17:23 schrieb Sathishkumar S:
>> Add ring reset function callback for JPEG4_0_3 to
>> recover from job timeouts without a full gpu reset.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 ++++++++++++++++++++++--
>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index be0b3b4c8690..62d8628dccc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       if (r)
>>           return r;
>>   -    /* TODO: Add queue reset mask when FW fully supports it */
>> -    adev->jpeg.supported_reset =
>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>> +    adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>       r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>       if (r)
>>           return r;
>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>           return r;
>>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>> +
>>       r = amdgpu_jpeg_sw_fini(adev);
>>         return r;
>> @@ -1099,6 +1098,60 @@ static int 
>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring 
>> *ring)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +    struct amdgpu_ring *r;
>> +    int ret, j;
>> +
>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +        r->sched.ready = false;
>> +    }
>> +    /* publish update */
>> +    smp_rmb();
>
> Using smp_rmb() to publish the update is 100% incorrect.
>
> What exactly are you trying to do?
On JPEG4_0_3, there are possibly multiple contexts submitting jobs to 
all cores on the affected instance,
so I am changing sched_ready to false and using smp_rmb() to publish to 
other cores which are trying to
submit on this instance , for them to read the updated change 
immediately and stop submission before
I wait for idle on this instance, which makes sure other good contexts 
of jpeg get a chance to be migrated
out to any available instance before reset starts, that way good jpeg 
contexts get a chance to continue
without issues while this instance is being reset and made ready to 
continue decoding after reset.

Regards,
Sathish
>
> Regards,
> Christian.
>
>
>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +        if (r->pipe == j)
>> +            continue;
>> +        ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
>> +                        regUVD_JRBC0_UVD_JRBC_STATUS,
>> +                        jpeg_v4_0_3_core_reg_offset(j),
>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned 
>> int vmid)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +    struct amdgpu_ring *r;
>> +    int ret, j;
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        return -EINVAL;
>> +
>> +    jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>> +    jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>> +    jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +        jpeg_v4_0_3_start_jrbc(r);
>> +        ret = amdgpu_ring_test_helper(r);
>> +        if (ret)
>> +            return ret;
>> +        r->sched.ready = true;
>> +    }
>> +    /* publish update */
>> +    smp_rmb();
>> +    dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
>> +    return 0;
>> +}
>> +
>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>       .name = "jpeg_v4_0_3",
>>       .early_init = jpeg_v4_0_3_early_init,
>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs 
>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>       .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>       .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>       .emit_reg_write_reg_wait = 
>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>> +    .reset = jpeg_v4_0_3_ring_reset,
>>   };
>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device 
>> *adev)
>

