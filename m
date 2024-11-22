Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD14E6918E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 19:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8359910E1A1;
	Fri, 22 Nov 2024 19:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXgSaXes";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B19410E1A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 19:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voqWn8Y+ucGz/HFYzxnHYhqQvExJjgBVPqnVQm0t4vMd+UcPEq4BwvStnBxsSnhgv/5zwDUie8PdFqhg/NoPP3W5vvuM9OB1ciO+fuYVxylDlaPqNLVm4ffgShaHq5Hw3REEmaWweL9bwX5vQqzGI6LPS55G9Rj3cpiqGrSlXlxSrchF9ztKyYGgtOJQDuZCPdhSYV6u1GMzevs6Yv56JA49oQCb3j9zf62hmU7spuZhdrboYxDhZv5r4LKTBZghlSYKd/pSl21PmCumj7ZJg3Ev/Ray2jRKybr5YwfEvdc54+4sFioOAN0Giifci7ssNDwm91QhOwI6eT/055Joww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmzwqayoX4uGKZt/cOCJC5hSRx9TickEJmG9/echhbY=;
 b=q+GFzw0gNYZyaFa7yiq5p8EUou0MXcLIyeLXGdGcMiW3uzOM050gKpzTszowB60wvHth+JxLK4K0kjRc2FmBLjBdm6smTZ+zwAC45Qc7gKGfWqol37Ok0EYGw4Mq+m9nN32GuJtKicpQY9gjqGqET6lhR1ynXyYLxeai3m/dcuCaR04uoOqZwG1DoBAt6NGcz9l5vFjDWAt5WV/4GdS5+0bBm2Dvw3Q/aHlhpFc8qcJ697kl0+cQx42CdJ8Q6Eiz+CQqBc9Dy+SCI51qGN+PCEDR0K3bKGP2qwbebLZ7Xs3wyjkCrwFcnXlMF7ah5aqeCOSE/I2kHU5+Q7D9D/34lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmzwqayoX4uGKZt/cOCJC5hSRx9TickEJmG9/echhbY=;
 b=LXgSaXesQNocTZm8skrgI4VsDNuiQlpXp0ZXtoqbF7rpfZ+I+VpL8FVx94EM771Kz/dHN+SenZsHS/BFGPiVFyM3Bc2z0XujOvuEhK93sJphZSG8A8ZMj/UafeQPZAKw4JjWirbkcoawYMwOldt49kH5e8mQVfNxU32J7WGQZQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 19:08:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 19:08:19 +0000
Message-ID: <1bc84604-0176-4bfc-a8bf-33591c5ad7fc@amd.com>
Date: Fri, 22 Nov 2024 13:08:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd: Invert APU check for
 amdgpu_device_evict_resources()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
References: <20241122155004.3565-1-mario.limonciello@amd.com>
 <CADnq5_MY8kwafb_-YxB9vBNyHe-j3tq-gu1SsLrBSz67C95vSw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MY8kwafb_-YxB9vBNyHe-j3tq-gu1SsLrBSz67C95vSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0110.namprd11.prod.outlook.com
 (2603:10b6:806:d1::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c42b32b-f638-4527-39d8-08dd0b2906bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnRLS2pKK2pwWFNpb0MzYVRKSlVlOUR4N1RpR3JjaUREcEtBeW5Lc3kzT0Zt?=
 =?utf-8?B?aW5nRngzQUhLVzF3YmRYYjZEQzNEUUdpSUs5VWFjZzRYZVhXUUhySFFMWmNG?=
 =?utf-8?B?UnN3dnBkaHg5ampOcVh3YTNyY0tMNHI2Ymp3YktNa1RhTEMxWDdMeGNEVWJ4?=
 =?utf-8?B?aU5lUENZK0NlemZmVnRzTStPTzZBYnJ4Y2dnTTBCTzlXZ09yL2dqTE9rYjlS?=
 =?utf-8?B?d1pOQVdiL1F4QWh0TTk1d1hybCtGLzQ5SkpJWXY2dWQ4MUdTbDZuYWthNlRK?=
 =?utf-8?B?Ty9lSGpIRFMzUkJXL2lFSFowc3l5SUpWWTlKNmd3Uk5oUWVVOFJ3cGRYU1ND?=
 =?utf-8?B?SUJJdTVORFU5QUVycnlIQU95WnhqaUdXc3c4eVRpWWlZaHAzRGVtSU4yMm1K?=
 =?utf-8?B?bHlLMkI2MHBxblYyTVdrdGRFUXdmaStFRVZyZG9wWmwwZ1Z3STExT3BRVnVP?=
 =?utf-8?B?ajZ3UnNXcEtpVDFIZnhQdlFZYXNQalJ3dEg5Snh0RTRSSjliR012dFNUOXhR?=
 =?utf-8?B?dUJzVHFwMXA0UWpUWUVwRko4ZXBxeW42UnpWOXVQS2ozTVY1Q2NCdGNMWW5h?=
 =?utf-8?B?NDNjNFBRYTIwM0ZOeHkyN0hJcGs1OG5KdTd3aHZTekpYRFkzRW5TWVhFZE4r?=
 =?utf-8?B?NXJGQXlkSUJqR254QkRrcTIrUTlKZE82RjZFb1piOSt6ZVErOHhSZVlKZUFo?=
 =?utf-8?B?UGk4M1EvQVVIcXREUkhUY0dDNHlVN2lZYXB1d2JlMHN6d1hSTnVCNktsbkJr?=
 =?utf-8?B?MHRHWjhBRWIzV1JqQ1l4a2hxOTdBYUlZRHVVZ1c5aXVpYWpUNEJJUWxrNFlK?=
 =?utf-8?B?OGg5WG9maCtOWTVXUjFpLzlhNHdUNjlUZTJFRWZXRUVUaXE2dElwRHVVVDJ5?=
 =?utf-8?B?c3dYU3NaOUExRTFlVk9oN0FFL1VBZHBhaVFZemU1SzdMaElMeGZPaDZBOU5h?=
 =?utf-8?B?a0RXbTAvSDdsMVJJVStpMmJ6bGZmR3czM09pNVpDc0F3Y2E1cDY0UVJxQnUr?=
 =?utf-8?B?aTh1a2h5NXVwYlJPUWZzVlNKTTdWVWg1Z01wbW5XZU5WSkVzNTdlMVl2bG0w?=
 =?utf-8?B?amtpaVMrN3lQeW95Mit5T09NeTBxVEhoY3ErMGdWcjFwb21qUVM5VmlnSFN3?=
 =?utf-8?B?MVUxeDNoWk4zTTBEQWVSOGtKVDFiaXNkN1VqR0ZTejViR1lTMmVWM1VYWTBC?=
 =?utf-8?B?dWhITVZ1R2NWOGQyRFFRdWVCOGR1RFRuOGF2eUl4TzA2bVpvV2FqOEZad3Q4?=
 =?utf-8?B?TmlpSHdMWkZpb3A1V1F6RWxQT0pORUhvdXVWeS9WN0V3bnFJUy9iNTZhcDY4?=
 =?utf-8?B?Rmw0dkZQNkd1UUhxQmtGT0Z0VVpLKzkzalhzTGVJZCtnaFZFWG5BK3JzazZt?=
 =?utf-8?B?OUlYc1lsbkFoRXhIVk9yWXNLVldvS05QajBxSkdjWnZlUVJuaUhuQjNmY1do?=
 =?utf-8?B?NjducVJraDdQSXpwaEJiWTFYMGdCK2loOVIycUxZdTU4My9hVE8wTm9NSFhu?=
 =?utf-8?B?MXBGbkJneXU1aG5xbWlRNVgrM0JVdnlkUGJjRkRKR21pNkUycExhbDRDUk1h?=
 =?utf-8?B?UVF1N0IzZ05WQVNxL2VEbUpSYzRrMFo2dnp3bEVLWTF6T2NyVEZ4T2ZFWEdz?=
 =?utf-8?B?YnYxWElhSlowblZKeG1RbncwNGR2TUFOQ2d4eDA4YnFrZ2d0UEd2SWtBTFNm?=
 =?utf-8?B?RGV4MUpVbnprbDF6RXVaVXdmY3hBeE5ZNVRqY0ZQV2huK25Ja2ltSkduZlRI?=
 =?utf-8?B?RWRLbFRENDl6SEVCWi82aHRJT29qWXUrVlEwNHBxYzBUZE10WlJSc0RmR212?=
 =?utf-8?Q?QymSda8ayTMRjN4RCGeZZ5Ciga1mCIiIlQ8Eo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JsdFZRUWVSazJTTjl5Tzh1emZscmNRYk5sQTBZMEVXYk1qN01ueFVJZEhX?=
 =?utf-8?B?b00wUUFmLzZiY3F6NmUvOUlTem95a0FWdUN1dmJvdXVLMmdKUmpqTXhKN0xz?=
 =?utf-8?B?M2FWSmpucE54ZVgyYnFLV1djSm9DWkNTemlvMjRpOXJFYWdhUHJqRWVRdWM1?=
 =?utf-8?B?N2REV1dvVysxNk9lbHJTdk9RT1NscWdVbWJiVXhQczdPZEc5WXZTVGpQUElE?=
 =?utf-8?B?SGwwOGNkNU91bGdUcTE1SEF3bFM0c1VFL2J1cGRscHQzVWg1aFRDeHhGUTZr?=
 =?utf-8?B?M1VqcEJrcW9udHpBSHNybTlnNVZNSUg2WHpZN1FrM0xFU3ZaWjV1bTlLVlpP?=
 =?utf-8?B?dU9OcUlvc1pHYi9QbEU1UnZuZ0UzWGR3ME1zcm5ZM25HNUNjeDU5V0M5bURB?=
 =?utf-8?B?WEFrNENnT2pqb3N1QSs0WFF0NTZmV2RxeFNwN2xxbjhsSDNBMGZNUUlQR3da?=
 =?utf-8?B?QkxJSXZGRUZPcEY1TFAwK09LazFJNTdORnpVamJrQjJMTm5aYlBzNEdnVStB?=
 =?utf-8?B?eHFFRkNpK2UzNmdQSXUyWmJyVkNTZFFYWmpza3g0L0hYd2VkLzl2Kzl5MXUy?=
 =?utf-8?B?VWxhb2dwQlY3TytFYTNVajdUeXhNYzFTS1l4Qjk3TEZRenRUUytsV2dCTjF1?=
 =?utf-8?B?aXpOMkZFQXk1L1hOMFBLbGpWa1JheVFlSUZzNFBxeUtJUlA2Z2FEY0FoVm5l?=
 =?utf-8?B?SmtlejJ1N2hSSGRZQWlOWTFXN2pNdkh6NTJndUIvUUpSd2pvOVBDZ1JYbnNq?=
 =?utf-8?B?Y01hOFVqcmdXcUhzREZyZ1ZjM2VybTVrNXZva3d4Mk1JNHkxVy9FN0pPNENk?=
 =?utf-8?B?SmlSeGhTakx6RnhGcUNSUFgyRzZNb3l6cDRFRE9Xb1J1amNqL1JuU1kvczZ4?=
 =?utf-8?B?S2JuUjM5MVc5bjBZNTdiUUt3Wkl2d25FTi9SbmUrVjdKRU9Ia2h5bTdWWmkw?=
 =?utf-8?B?Y3VUR0FmZkk5SjBGc3grbGVJeUhVdVl4VllZSFhMdkdZSnQ2b3RTQWpxeU9O?=
 =?utf-8?B?YmdFMFpXUWYvdm1RY1BEb0ZnMUUrUklSYWZtTnB1S1FUelFnMElTUk5RWllF?=
 =?utf-8?B?VjJ6c0dtQUN2Q0E1cDNobGV6Umx2dTdHVUo0YXV6dEhvRHovZ2pqWXJ1UEEy?=
 =?utf-8?B?TDhXTlNPTFZEOE03ei9pSFZ5YzNQcHZja2t1NzJwZ1ZkbWxPNXpDMEZpMHJG?=
 =?utf-8?B?OXBCbEhhSWJqS2srR01OZFNiZ0I1L0VZRkowS1A0enByaHpLbUdQZ3gxWEl2?=
 =?utf-8?B?eEN6MjdpdE1Na3cyR1ZZNm5YTlp5VGdkVnVHYkNsNiswcjhpUVR3eXhyR200?=
 =?utf-8?B?QTdsQXROT054SXJramdLK0FjVnYzK2VIVlo2R3lxdDZURWpvaEdsWW51SHhZ?=
 =?utf-8?B?dndCTFkrVHllemovM0NQdUN1MkhQUnZCMEh4b2c5ZmhDNnprWGc0QUdjeUxx?=
 =?utf-8?B?bFhLdnJzc0lZRWVpT2w1N21CM3dpTm0rVnI3cnB5c0d6ZmpZVzFaaXRNNFBh?=
 =?utf-8?B?ZDJrbVRpQVBpNGROVE9lL21ramFUZk82bFhKdzM2SUVCNzIreU9VU2ZkalBw?=
 =?utf-8?B?MURWbVF0WXZ2dGZWRG9qeGpRT1ZvWlVmcHlVNHNUOWRsdk1MNmpWSGJrWTN6?=
 =?utf-8?B?b0I3ZVBacGtUSTNFVDMvblM0blNRb3JBQjAvM25QUkNBbzd5TVNTbTI5RllM?=
 =?utf-8?B?VXVnNUV5bGdiNXZ2Szh0ellpSEFJeG1adTV6TFVibjN5OGpORngxaGwrSmZQ?=
 =?utf-8?B?dGUrRTUxWFR2YWVsdXYvMEo1OXdmQ3dZajVXVVVLVG5aL0QxTE96SzdYNndy?=
 =?utf-8?B?cTJyQ0dLc1VjaUdtemI2WVUxaVAxUm5NZnBBS2F0ejRPNmpKZWc5SkhRMEpI?=
 =?utf-8?B?MlVld3RBR2tGNS90b3BPMkptdVl1bFRRdTdXV0NFdTBZNUJCdlE3eUVLbWxM?=
 =?utf-8?B?UGNQRmlYQkVxbm5qUnNVQ1ZUM2xFeEdXQ3NVeDYrcVR2V2VpRUJmYTU3UVNX?=
 =?utf-8?B?QUlWN2R4SHdIenA5RTdUM3J3KzBRVElUcjRTZVB4OFpMdWpKQ3hEbjJjNmZx?=
 =?utf-8?B?Q3RqZXhtYUVnMmpoNW0wYXNkWlNnTEw3VVl6TGV1V2tBWG5IVjlZRGJIbEZW?=
 =?utf-8?Q?oEhMZRHpYuFe6IyKNC2iKIjSc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c42b32b-f638-4527-39d8-08dd0b2906bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 19:08:19.3190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99peRcS4mPmqvJJSm/hpSBfo6RSV3q4rZk7ktgPIHr7msETAEiHu4K2RzoSUH17mBus9ecTxW9HUvm679j52+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
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

On 11/22/2024 11:00, Alex Deucher wrote:
> On Fri, Nov 22, 2024 at 11:17 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Resource eviction isn't needed for s3 or s2idle on APUs, but should
>> be run for S4. As amdgpu_device_evict_resources() will be called
>> by prepare notifier adjust logic so that APUs only cover S4.
>>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> --
>> v2:
>>   * New patch
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 11d344166ba7..d511ba949dff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4744,8 +4744,8 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>   {
>>          int ret;
>>
>> -       /* No need to evict vram on APUs for suspend to ram or s2idle */
>> -       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
>> +       /* No need to evict vram on APUs unless going to S4 */
>> +       if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
> 
> Will the in_s4 flag be set at this point?

It won't, so this would mean APU's to S4 wouldn't be covered.  It looks 
like a gap in the prepare() implementation too.

I've adjusted it in v3.

> 
> Alex
> 
>>                  return 0;
>>
>>          ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
>> --
>> 2.34.1
>>

