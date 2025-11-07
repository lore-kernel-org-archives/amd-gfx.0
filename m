Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EEECCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 13:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FED10EABF;
	Fri,  7 Nov 2025 13:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gI/lDkU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFDE10EABF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 13:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwyl24A0NZqiAx9jbCo8amwTiqXl/s3kwGCV9deXg9+CJt34mVgAYkNhBSnnkp+p5Vpw+EUZCJtjLVulN8EK/3T0EHbXuo0DsfqjgN+7na2sdtVe6aurrA5b38YHIbSisFnOi7NbOBKmGql0d1WEo1QBpKdIMAcdYc+Ev3zwEnOLrR18RLv4iUEOY3iDp9A74iozyAMnthUV/Fjp5WB7jdlflffUJGXnV0DSNg9Aw7NWO8uDfJbvuRMOW2z9VjzrjUVTIR2IyUIbhKoAJcGqYMufouISuL1te9rYi6XKjfiH3+bQYGLRPBPr2RwNsj7pJ2gszZ18Kh3ZM5FSMGeULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzCza0dPqucHPgql9GAEZ7iij7EFabRG8qvFD7Tgg5s=;
 b=ef1o3LKJ1ImWDQLhgqGf8DGWHb/CxVVWwZQdNv0mhCuWjB2Lb5a10zZfs85R/i7AxFOEsREfC8UsbLD+zGyNP7xuuiEprysHW2guLJv8dLRFbKLdswl4kV5f7stkqEQ0din+wBGyQpv6+qSDPUNozeVtp5m76b86EmMhT8SS5AbfYbY5rUJXqo7wvP7lljxG+u4xj8kIJLB/2Wz3ISFMu5P593nUI1FQHysNXj6uOnUXiIiQVzcOzlGPI2W+PgHVRB4wNfbIoura/22fyP8G8aRC0CahFnBmEmthAjxRh8oW3lwR247LatPaQmMCIX0ufsazD06h+OJIJiw6MvgkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzCza0dPqucHPgql9GAEZ7iij7EFabRG8qvFD7Tgg5s=;
 b=0gI/lDkUZ7Qcp7MgNk8456rGAHo2jFdGe3p2QDFCb7xFif7720eI7iN1UXpgiuN61aZ/eNwQ4AE34pNnqCw+YFh52Rh28QPn7bB9A8TG1wtgWA/ZsZKpbmB4iGDeJVjKHqM0bzhIPiQr6EES7BMdeC6VhWq4qb9RtjNV14L0wj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 13:20:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 13:20:03 +0000
Message-ID: <9c0fb677-caf5-4eef-b77e-0691f3950f6c@amd.com>
Date: Fri, 7 Nov 2025 14:19:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: avoid memory allocation in the critical
 code path
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
References: <20251106130637.2187-1-christian.koenig@amd.com>
 <b5f9eb6c-0b40-40cd-813a-09bd8442b28c@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b5f9eb6c-0b40-40cd-813a-09bd8442b28c@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d0097f-4900-4cf8-d3a1-08de1e005c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1oyZ1p3ZjI4N1E0bTl2SitWVHVXNUl6M3NBN3hUNHhHVnF0YzEwOWx6bG5N?=
 =?utf-8?B?SVRpcFVrWGxhWWRYb0l1Z1hVbmJ5WFYzNFB1WFFkM0ZlelpIZFY2d21MR0th?=
 =?utf-8?B?QXV3U1hRMEhEdW83U1k5d3JNQmJwb1BwSWhuekVOSDFlVWt1T0MzL3p5Vkcy?=
 =?utf-8?B?aVU3ZG9uQllUQUFCR2h4anZZMXkyMjlnbWJtZTZtVTFlNzlxT0F0WDZBWGY4?=
 =?utf-8?B?aGF1OXZDWlh0Z3piRVhETlg3WCt1T25GTG9zS2dUd20yVXZyRU1OanM2SElW?=
 =?utf-8?B?T2F1enpqdUwrUXpuYitGbjhiUVpQZDBNZEJuUCtKUnRabGNGK1hkVEVtTU55?=
 =?utf-8?B?U2VyU2phQXdWL04rQ0xsYml0NUsvUFd3cytjQ0VsbThQYnJDL1luTnQ3b1By?=
 =?utf-8?B?T3BjMGhoV3ppSVpYS3g2NHJCQ0JnbTB6MHFLM1h4WjNwTTBydlZNMkNLRUh1?=
 =?utf-8?B?SGlpK0pJM0U1Q0srU2o2VUdFUmRTVGU4cUp0RUpHVCtCbTBzOERxTDUvZHFt?=
 =?utf-8?B?T2pOZFBCZUJJd3Z3dWVuMzNxWlFBS2IrZEQzS29nOUx5aE50Z0h0NWgzNmVQ?=
 =?utf-8?B?dkJSS2hmMitDelR5Y1V4OUFyZTRIU3dLZXdYeHF3NmdSSXFRb1hlaVN5MjYz?=
 =?utf-8?B?VjdIRmVscUpGbVNBOWd4RCtCblhnMDRDbEN4clpOSFJwL1hsUFdWNTlwekJm?=
 =?utf-8?B?WFdIMjdDMU4yMTRtak1VQStDQjdJMDRUN0pnR0p5eUhZei9YZDVNNFJIZ09Z?=
 =?utf-8?B?WmVheGFoUzcyZlNWd1JFTWJqSDJXYmFFdnhLeTlrbmZiaFBzdWZOUU1Vbkkz?=
 =?utf-8?B?V1ZXamg5ejVBVVZYV29vNWg0WVhHZ00vc21hY3p0ejk2R005QUVtU0lMVHZY?=
 =?utf-8?B?eUloSG5XM0ZGeEdrMFhWZmYzTUlrOCthZlZjanlLOUkvcWxyRS93akN1Y0tz?=
 =?utf-8?B?cE1JMUxRdTBVU2EzeE9YZFlpREUvWWF5M2E3WkhaRUNJbU52WlFOTFZqeEto?=
 =?utf-8?B?RjFMdWlvbThyMVhCQ1JTWUc4VTRVVkJGNXhaUUZRU3RVWDRIdGZpV29rRmJ0?=
 =?utf-8?B?RzFOVlo5K2JwRWE4UTBhSlFHK2s4UFdvNUtNbkRLS3RnQ1ZuN3RORTc5Q2U3?=
 =?utf-8?B?eVpxL0ZPakJtU0MzMjJoOTlYVlBJamZPMkFyTWxHZzVDeDhiQTFGUW1jS2dz?=
 =?utf-8?B?QVpHUmFwYUxkQXFmWExtUDZ6Zzd5R1lXempuQXVPNzlEQ21RSDVSN01VZTVs?=
 =?utf-8?B?VWs2U0pYejQwdlVmeG1DaDJPWFVWaFMwZnN2MHU2ZzlNUDRHRWdac291eXNE?=
 =?utf-8?B?UndGQzBvTDdGSFRVbHNoY3NZSFQ1ckZjYjgyUmpQRlJMV1AyYUlKZENLSytr?=
 =?utf-8?B?ZUR0ZDd1ZmlNQkJMZE0xSlVzZnFVWk10MnlBeDk1RDVVbllEMXQ0RWdiYWRB?=
 =?utf-8?B?WldPUmtXNTI2RjR1Sm80RkZRQ3JlTXA5aU9uem80TGlrUXRPTmdNMlZoVmtx?=
 =?utf-8?B?c1V4Tml1M3kxemxGbkpQKzUwQTVPQ3ZuSjI4QkZuL3doTjd2OS90M2d1RUdv?=
 =?utf-8?B?RkdjcjA1dld2VFdiUmttdE9aUW1mWUgxdy9yUGwyWjI5V0ZhbnhzVXdyZUpN?=
 =?utf-8?B?NHBVQUZ0Y3VXYzhKN0FQbWJ3QWpTdlMvcktCcDg2am5VL0JaQ2FXSGFQMCtw?=
 =?utf-8?B?elgzQVgwMGZCQ1FHL0FIWTZvQ1B1VklEaXpzcDdiZUtuTHJvcWZPN29CNHFJ?=
 =?utf-8?B?MU9TSXUxS3M2M2oxYS85b0NEcXFtcUd1WnhEbG84clRpU3E2Q09hTmVQeWx3?=
 =?utf-8?B?MTJLYS8zYyttWTMxM3VUNFRrcm1ESnAwaWM5eGJQMVZGbVA4dVFSMm1kYjNB?=
 =?utf-8?B?bGJHSnA2U0gyWlVXWTVNRGU1M1BlYUFXZEJWTEg4VGx5L3VrQk9QV21oODNw?=
 =?utf-8?Q?G8L30b6rYEg6e1GjJmPKeQ5boHGBMkQ4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3cxSFZZZ0xxUld2a091WUhJSHVHRTJaRTJRUTc4Y1FiQlhkZWxJeTltM3RV?=
 =?utf-8?B?ZFVpYVF5bVBTVkszV0dHbFJRY01WSTZKRU9DUUtySHVSOFREV2d0b2pZUFBB?=
 =?utf-8?B?NkdUa2t0MjVkSUx0M2pBS05Cam9YU0pkb1dWb0VrK0tVcVcrZ2VmbFBVdmt5?=
 =?utf-8?B?K21vaDlpbTFZaktOamNzUVFFOTJTM2tCNHFqOUY5MkloY1ZXZzd0cE5SbVZT?=
 =?utf-8?B?RXZGaEd3RzJCTEtqNWl3M1dlY3RkSFNScDVsbHFlSm85a0FCeHNqY1JidTg3?=
 =?utf-8?B?alJ6eGVHbktkd04wMUxpZWRWL1NLd09lWUN0S0E1N2hBblUzQTk3NlBtUjQ4?=
 =?utf-8?B?bWlEbkFtTEhLV0lvSlRyT1k5eGs3bm9XdUlpVHpqTUljQ0N1dWtkU2ZwY0Vj?=
 =?utf-8?B?Q1R4MHpLZGI4VXBVRks1RW82UWRqV2xyNkdURHdkYVhuVkhvZzgveExIRTZW?=
 =?utf-8?B?YkVoRHVuYU8yTzkzWit1WFY0WmZRcy84dkJqOWlOclc3amxUbzZaUnFnUyt2?=
 =?utf-8?B?dnluQlZDUzNzVlc5MU1Qc2NkWGpqc0Z2QUViWkt3Z3NicXBxdzkvV1ZJOTI2?=
 =?utf-8?B?SkRVRTlHa3krUnk1N1lYQWZyOGhQS2l0OE9HWTFObmdoeTEzVTJIMU9POFpI?=
 =?utf-8?B?QVFwaFdLZVRXTWozNVpibkpIYWhCRlpYNEdzUGRJUml3ejlOLzZZb3FzTHR6?=
 =?utf-8?B?MG1DZWRMa3BMS3lvZXJPbndBRFI5UkZkbkEwU2ZjMzM4cHRtZnIrR2ljNksw?=
 =?utf-8?B?VkNPZEtldzNkTUV2cVVNWVgzZzZReVh0cnJ5eEVhQ1VYcVhzSm1yVEplNGpT?=
 =?utf-8?B?MDNNR0NCRjRZMHI0T3VEYjZkNzAzNldjYmc3QVNIOFB3UHQvUHBLd0dWcDlj?=
 =?utf-8?B?bU5zbThDUmVyWnBDZVBEZEZ2dCtTTE1kYTN6UDJpOTZiRnM5NEVWeXBFL21y?=
 =?utf-8?B?ZzN2QXVvRzNQcDdKWG9hS2dVWGN2WkMzMVUzM0xIUEI1ZmgvZ1V3Uzd1LzJK?=
 =?utf-8?B?bDI3dHo4VkQzTVJ2M2VYZUlTdThaVzhyUmtNVk8ya05Bdmc1TUxpKzhFR1Rz?=
 =?utf-8?B?ck52a3A4VWhJeU5KeHk1UjdJWnozdi9DYWUyNGhHUnZFcHJXUjJRWElWWXFn?=
 =?utf-8?B?VTRIMk5semVteWhTZ2FmNVRIRFhkQjNXd0tTWEc0dkJXTmRqQUxGc0tXdnlu?=
 =?utf-8?B?UFY3YW44MHNpOGNKVGlmREpoTkZhZi95djVKT3pqWUhlM052M2RWZVY2eDB6?=
 =?utf-8?B?U29mY25maFNyTFk0WEYxT2pUV1FZK0FNeVd1SjFIdkNrZzg2amhDZDVpcE4x?=
 =?utf-8?B?MDEza3lxaWExQnVQcmllcGdNWDM2bGpxeHBibzhwcHN6UlB5TjA5dzNHc1c4?=
 =?utf-8?B?M0lhQW1JM0RJMmJoeWQxeFpEamVuVGRNdGFlVVkyVGVmVVBpc21mV0U3L1pZ?=
 =?utf-8?B?QjNVV2w0Y3VsVmFsYkhFVVlBQk1rdFB5eisyVXRuSWg2UURuUzZzazRJUWN0?=
 =?utf-8?B?Z2phcnFEQmdWQ1A5N3BIYy9NUlZzVU5acHp0bzhwSUhCMUllcytBbVY4QXNL?=
 =?utf-8?B?OVVFNE9YT0xBTTAxRnUrWlhiWkRnK0szaWFOWEgwUGFNQ2pJdDZodUFrV0c4?=
 =?utf-8?B?RTdoVnpuUEFOaXRMZE9JWXFBbHRhWkdRdUc2NSt5aFpYSGZBR0M3cUhXK1pu?=
 =?utf-8?B?YjAwYTBLRXJ0N1NLdWh3K3VLMllJaDBpSmt2aFJiY0M5R2lmaSt3NFdaTno2?=
 =?utf-8?B?czNVMllld1RXL1EraEJUOE5neUtveDdFKzgxQmhYRGF3dkRPaTJ5KzZrV3pK?=
 =?utf-8?B?QWdCYSsxeXRYNk9nWUd1V25Ic3kram5adGtWS1YyYmhVRFBNd3duYWZYWjJh?=
 =?utf-8?B?Q3QreUJ6NXNLaXN2b0djV2N2VUxvdEx0bE9oT29SbzlES2JoSnRYYkIzK08r?=
 =?utf-8?B?Z0JDeWF3OVBORkNITjJxc2E5bytHcUpkUmpTMDdXV1BLRDNCZVJJdVBPbWho?=
 =?utf-8?B?Y0FRazRPMjdqQ01NSFJ3ak9VVnRDQlFoYjFQY3VjYlBqbjlNVDVrV0crVnRh?=
 =?utf-8?B?N1FGVE1PTzQ0VzJ0c2lVNzA2NGRtMUR4ZGg5NG1UN2RJRGxNRnNBdnBYT3RN?=
 =?utf-8?Q?oTGX7kgTvNI5z2K90IS75HtnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d0097f-4900-4cf8-d3a1-08de1e005c65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:20:03.4791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwgADUS0G2S6s4r+pdijNpCtrd6RQUv59Ox/fQvETqLdkKST0zEY7M8501YCBM6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

On 11/6/25 16:55, Tvrtko Ursulin wrote:
> 
> On 06/11/2025 13:06, Christian König wrote:
>> When we run out of VMIDs we need to wait for some to become available.
>> Previously we were using a dma_fence_array for that, but this means that
>> we have to allocate memory.
>>
>> Instead just wait for the first not signaled fence from the least recently
>> used VMID to signal. That is not as efficient since we end up in this
>> function multiple times again, but allocating memory can easily fail or
>> deadlock if we have to wait for memory to become available.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 51 ++++++-------------------
>>   1 file changed, 12 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 3ef5bc95642c..5f94a66511af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -201,58 +201,31 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
>>       struct amdgpu_device *adev = ring->adev;
>>       unsigned vmhub = ring->vm_hub;
>>       struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> -    struct dma_fence **fences;
>> -    unsigned i;
>>   +    /* If anybody is waiting for a VMID let everybody wait for fairness */
>>       if (!dma_fence_is_signaled(ring->vmid_wait)) {
>>           *fence = dma_fence_get(ring->vmid_wait);
>>           return 0;
>>       }
>>   -    fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_NOWAIT);
>> -    if (!fences)
>> -        return -ENOMEM;
>> -
>>       /* Check if we have an idle VMID */
>> -    i = 0;
>> -    list_for_each_entry((*idle), &id_mgr->ids_lru, list) {
>> +    list_for_each_entry_reverse((*idle), &id_mgr->ids_lru, list) {
>>           /* Don't use per engine and per process VMID at the same time */
>>           struct amdgpu_ring *r = adev->vm_manager.concurrent_flush ?
>>               NULL : ring;
>>   -        fences[i] = amdgpu_sync_peek_fence(&(*idle)->active, r);
>> -        if (!fences[i])
>> -            break;
>> -        ++i;
>> -    }
>> -
>> -    /* If we can't find a idle VMID to use, wait till one becomes available */
>> -    if (&(*idle)->list == &id_mgr->ids_lru) {
>> -        u64 fence_context = adev->vm_manager.fence_context + ring->idx;
>> -        unsigned seqno = ++adev->vm_manager.seqno[ring->idx];
> 
> Maybe vm_manager.fence_context && seqno are now unused and can be removed?

Good point!

Thanks,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>> -        struct dma_fence_array *array;
>> -        unsigned j;
>> -
>> -        *idle = NULL;
>> -        for (j = 0; j < i; ++j)
>> -            dma_fence_get(fences[j]);
>> -
>> -        array = dma_fence_array_create(i, fences, fence_context,
>> -                           seqno, true);
>> -        if (!array) {
>> -            for (j = 0; j < i; ++j)
>> -                dma_fence_put(fences[j]);
>> -            kfree(fences);
>> -            return -ENOMEM;
>> -        }
>> -
>> -        *fence = dma_fence_get(&array->base);
>> -        dma_fence_put(ring->vmid_wait);
>> -        ring->vmid_wait = &array->base;
>> -        return 0;
>> +        *fence = amdgpu_sync_peek_fence(&(*idle)->active, r);
>> +        if (!(*fence))
>> +            return 0;
>>       }
>> -    kfree(fences);
>>   +    /*
>> +     * If we can't find a idle VMID to use, wait on a fence from the least
>> +     * recently used in the hope that it will be available soon.
>> +     */
>> +    *idle = NULL;
>> +    dma_fence_put(ring->vmid_wait);
>> +    ring->vmid_wait = dma_fence_get(*fence);
>>       return 0;
>>   }
>>   
> 

