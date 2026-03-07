Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CABF55105
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Mar 2026 20:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DA210E199;
	Sat,  7 Mar 2026 20:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E1bpGMzU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C4610E199
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Mar 2026 20:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjC5jM/dtMugEYxh2zwgl9jedsA9SbeV5io6dZPX+Fw1bo7bw5BNmnDd6P/ZQO3WixoWRn0EiUDHBWyuJw+gxDXEM7t2TdaMaLVDyGwF2gV2wbzfvEkdURG6Wyt0Gihg2PKMBhBwp1CuncNBu2Y8/Evq7L7ZWGSDJOviOADwBQGD//VGfvMG4CCkeO/gxOwQej42i8zXWige8npckUe9MDfTzn2croi8I5I+LahHemO+I6i8SbChHXGBgZdQOv2kpHAoUcqMUf0GQUuJ2/stkyePPwiJXerRF1KgtGTQS2bA10sz/ddQuB4gOcPThpLYuRMQIEGEQfUZ7r/0SGs8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdAgKxYgK2r4gnSO6nO6zSImZR/fcgtygPvwtgJeDno=;
 b=q1KyBtUr6VpA3c+1BHbWdUvsRi6ukaf3AMVIAK7c36vCLCnIOncfsa5yU1MTO3SxJE/+mqv45u9yvv0vyXFLJJQlJ2+jp9Erl2wH2PEL45FlOMsMk3d4nqeB9l2FIPzp2W5q83d07dtk22iF9o+fWe0z70X6qwovvCPV9AxoFhbOjQ9xmtXEEOv4vfwfnlK8iEte6omy5DZEi9+0W2+p7jsBrAUPb9dNOKpSwJd7MGuOp/6aVRRFBLtlfd6ci1FDwGrhqWx3ctzUazWSXAUWLwpNGiPC2Dh1acHxW2YoJZ9oUG/kUI3F3rh3NgIyHv5a/qFGAowp/hBrzIRAzo4EHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdAgKxYgK2r4gnSO6nO6zSImZR/fcgtygPvwtgJeDno=;
 b=E1bpGMzUz6CWrvu8c+IHoFlAen5zL9g9mKLuE9FkiISkcDDIvR6pxKKEdFckxPy8LGai8AyvNf409QYgEt4U518J9StRB+w4FsXq7lZYtE1CEDZPhtzTn3z1Vtr7fOshSVefIuBG64H09BgF/yzc42rPFRCE5KY+FFu6OB+OcJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Sat, 7 Mar
 2026 20:19:02 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9700.003; Sat, 7 Mar 2026
 20:19:01 +0000
Message-ID: <cf184113-6db5-455b-87a0-85af727ea377@amd.com>
Date: Sat, 7 Mar 2026 14:18:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Fix more cases of NULL pointer deref at fini
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260305220540.1354776-1-mario.limonciello@amd.com>
 <7305e3af-1960-4612-9dc5-fbf718b7fb7d@amd.com>
 <1decb90d-1b7a-450e-b846-d3dbabfd81f2@amd.com>
 <6ce53965-3e67-4164-979e-259e6b57a379@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6ce53965-3e67-4164-979e-259e6b57a379@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:610:75::12) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: b28877b9-5365-4f56-70ea-08de7c86c583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: gnuPh9s66LKSaCEHI0NvuIRZ4IVOUAz5E7F7k3zzrhqloPbougOfMmFmA0Up5rkNAAa+is/vNmUbMx/FQP5EKdg4lb2dBxXrEMh4cyPOPss0FTU0v2VwpaK6Nd+PP3ErK3Jwr8rzz3m+uvtQgwDfrWmTsOVYnUfuypA7sQiYOs7HH7T5/LjlAJYGzDf3DINRI7gFFCIWttRxGEurspy7OMoZETQDvqg+yvhLbA9RjFWwyCIgmxkgVb7CKcieqnwW0uoYfoukfcU4KbCrCg73x6ikBxNao+QC4U1eBh5b7gww2N41cuWP076wC91kojdYygS/GrRIpcKf64uy+x0X6rb/+Os2G6xNMHetpWO1XvLYvosESfqH9wzq6qIBUPbtLGR2lZXX4U9MKWZrutJqTTF8TovdoKyuiiFdOvbgVn4xIDUgv475XVYkvuz05uFJ0m5TkcsOuYd4I4yIBhNgAThdevEi6QFEUacUEPUzzCKWJqWBKdjOhTa4YVHmXIXB76TpT8UFcPSDrLlf+oQftGGi7l6m0X15guyiL5ed6jUaFpwBGTLzUq+O8hLXg+dtZyYNQWmgbOClTtqsnvS75EYMBD+ysju0do9ZxaJEHLA0UeyMj8wUl9fC16MCkKqSrGrSxHlFubdYBCTg3qGMM3C3NpZ+F3ZSeBGQjGUgbbyMw3JlWW8K5Fd6yIS0cNcoBM4GO5pvEI7bHF8qQ/HjYIUmDjvezVge5Xb1lNEiiJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUZxcTFEQk5VS3V5RE1vQWlGd0U5WWpUc3VVMlVOYndUaUV0czdQV2wrNnZk?=
 =?utf-8?B?TnJqM3FxdVJSdmtabDVlQk9UTnZLUXR0TkFQeHZweUhpR1B3NGxzTU9jVTcz?=
 =?utf-8?B?SFhaNURkbXh0Yjg0ZWFkck1maU85WGMxVDNHVTQ3SW1RQlZ5aE5kQTVVTDVQ?=
 =?utf-8?B?Umx0TngxNjRndU50dnJYTDA4S2hMdi9nQVVmN0Y1dlF0Q2J4VGhVNkh4UWJ6?=
 =?utf-8?B?QXcxRUF1czBPbTBxejdVS3dWVzZzcENXNHpVblRQc1N5MU94UDhhWnhGOTkx?=
 =?utf-8?B?UWdWaGlJMmZVajhLZFBVMHZvcGpwVHVVWkc5anFlek1GQUx2b3ZreGdOOHVL?=
 =?utf-8?B?dHhUT1pzMXpYdW55MW55Skd0RjgyWGNaN2ZIUnpiTXIydXJaR2F5MWRHUExW?=
 =?utf-8?B?ZzBGUXpqdVJ5TXoyVk8vbWRXaFZOVUMrMHNFSm05THJRYkI5cjdoYVdvNVNC?=
 =?utf-8?B?V0kyQXpIMStOaTEvRzhwblBlZVk2YUNYUEtlck40bjVnWlAzbjYrb1NEVXRo?=
 =?utf-8?B?RHo4WTlXSDZsR2tkSVlJZ0xiM2ZNZ2NORE80NWlUL1gzN0IxZ0NIejdRK3Iy?=
 =?utf-8?B?cjVWRk1UUStzTGd3R0dvK2Z4US90RXR4aGJaTW5Wai9DTjBFYS9CbWFXRW1H?=
 =?utf-8?B?Y0VtK1dQcGhObFlBYWhoOEVPeFl0SjNkTTZaZmNNemVIT3dtZDFHUU5FbnAr?=
 =?utf-8?B?dDNSSENKNGpFT213QUhWRGNwcDBiWWkrUW1qbmZrNWtzTXBvMzBhTk9naFND?=
 =?utf-8?B?UmphaTlzTDhwWUxlV0Z4NWJBMC9QcEg3TXFOL2V3ZWZkOGtROFN3d1YwdlZ5?=
 =?utf-8?B?SXJhSmIvR0xoQ0c4VG9vakhGRHJTUk1LN2VkZjhiQUZabXVIZDJKOG1aNVJw?=
 =?utf-8?B?djdhMVhIYlhmbWl2dDJCZHJxN0hEbDBKQVNNK1g4MjZsOUZPLzBYcUpvbTFa?=
 =?utf-8?B?Y2RnR1RoTnN4M1dCS21Sekl5T2taT25vNzU5QmtBZy9pWjZmdWNIYnpGTTB3?=
 =?utf-8?B?ZDRIdk1UWURBWi8zRXJQa3JlU1RBNE9BRU5lYkFUQ01FdHlmaGRwcWd0dEpn?=
 =?utf-8?B?UFpUSEJraG1ua2g2Qk9LMFl6NkZGSlk4dHVCUW8raXUyYTFNNnVZaGlCMzU3?=
 =?utf-8?B?QXJTTU8ya1NMa0xwbzNabiticXRyOVFoYjRZNkVUT2RnMUxUMll4Z201c1pk?=
 =?utf-8?B?aEx6SE1xWHBXVE82ZHp6d05DajdTN0QyR3RQTUhLc0p1U3U3RFB4UDVyN1Ny?=
 =?utf-8?B?RmtIa0xDeEVHNzZ4cVl5ZVdHd3d5eXl2OW1hREhtQ0pGY1ZVT1hNMlRGYUda?=
 =?utf-8?B?WmN4ZFJwTzhycE1xUmJibzh0ODlVU21MbFEyenBUdWNvK2gxU054dS9pMTRj?=
 =?utf-8?B?dXMwNnIyakcrSjFtR1VPRkFBekRtbnowT0ZZMWRjUEc2OFcwRXY2Sm1jalhz?=
 =?utf-8?B?SDFEUHRGUkM1RW1JK0xjMVZVT01iSTBjUkxYS0RuQm13TmMzSDZHTUdsbXcr?=
 =?utf-8?B?RGFoZEhrRktUb3BLTVhPRDJldWhaWk1uYVRCM0xpTE5qY2tzemtLTkFielhI?=
 =?utf-8?B?VnJOaHgycGJYRm9mV2g2Z0JSU2tuUVpyS3hlWHIvdEl4UDc3ekRJV1hrZjdo?=
 =?utf-8?B?V1ZVelNYU3h1ak51OFhaSTF1dUg3d3FPSVhrWG9MbzZMMFNyL1J6d3lnNGU5?=
 =?utf-8?B?S0s4ZVR3elE4MUZIN3hSU1kzNmdxMUlzT0pWLzdBNk9mbU9JYjByZGhkb2Zo?=
 =?utf-8?B?VDRoUVZrU0dNNFFtMWdBbDh4UWZnZFZ1VU1TZTg0S1laRkQ3MjhncFB2NUV4?=
 =?utf-8?B?WmxyMktVQ3h2cmpJYWlTK2ZrSldNZllqeEtjSDNQOGtOQUlyOXFnMTFFaytF?=
 =?utf-8?B?bHFOK1J2bXBLNzhicnJkci9wN0ZVZTYxdks4Y2JZREthWjJUZ2ptRXBhc2dR?=
 =?utf-8?B?c2U5NXk4elE4YzF6UGxaeFZnWUNsQ2IxdnFoUGhOTHpVOTB0NU4wQkx5ckdG?=
 =?utf-8?B?TjdQSTk1WWExY3V0ZFREU1FTU3F3R3E5MU1STUUwaUNOUUdJRHZ1OHdLSXkz?=
 =?utf-8?B?SVRQRVlXckdhbkdPbFk2c2VrS2IxbzEzZkRqYXZPNitpOGh6Q2s4Mi84cGVM?=
 =?utf-8?B?SzBBbmtEU2V2aWFNbWoyaE9qR2QzUi9BZXhpYnNxbWFlV2NsazVjMTk4WGcz?=
 =?utf-8?B?Yk8vZTllcjEybVUyelpWVHB3K3VKVDM3T3lqYkhaSUhac0NpOWZKU1RCMEZJ?=
 =?utf-8?B?Rm03YjNJRXZpQS9kU1ZnTHhoZTVTYksvTlFjOU16SHVneHloTVB3OGVLeEZq?=
 =?utf-8?B?MXoyUDMxQ0RBdEFybVFERCtFWkYzQ1d3MkZhdVZBZEVyd2NaMzluUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28877b9-5365-4f56-70ea-08de7c86c583
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 20:19:01.7522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8uLEc2De4JGd7jVcBlNyr+zwq25a8JCIUYyIeeD6B83Ptn5DFw7Ovd+U0KEjQcLp9kUxWpHbuyqWWsgMpNUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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



On 3/6/2026 12:41 AM, Lazar, Lijo wrote:
> 
> 
> On 06-Mar-26 11:40 AM, Mario Limonciello wrote:
>>
>>
>> On 3/5/2026 11:07 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 06-Mar-26 3:35 AM, Mario Limonciello wrote:
>>>> I found more case that a NULL version causes problems.
>>>> Add NULL checks as applicable.
>>>>
>>>> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in 
>>>> powergated state in some paths")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>>> gpu/ drm/amd/amdgpu/amdgpu_device.c
>>>> index bc6f714e8763a..74cbe58484fe2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3463,6 +3463,9 @@ static void amdgpu_ip_block_hw_fini(struct 
>>>> amdgpu_ip_block *ip_block)
>>>>       struct amdgpu_device *adev = ip_block->adev;
>>>>       int r;
>>>> +    if (!ip_block->version)
>>>> +        return;
>>>> +
>>>
>>> ip block versions are set during discovery phase itself. This is a 
>>> very early init failure 
>>
>> Yes; this case is NPI system that not all blocks are in discovery yet. 
>> System panics at bootup with NULL ptr deref in multiple places instead 
>> of a clean recovery and keep fbdev.  This patch series sorts it out.
>>
> 
> Blocks not in discovery shouldn't be added to ip list or should be added 
> differently.
> 
>>> and ideally the fix should be not to call any fini for such an early 
>>> failure.
>>
>> As an alternative to this series?
>>
> 
> Yes, if it's a failure as early as in discovery stage, probably we 
> should skip amdgpu_device_fini_hw altogether.

I experimented some more and feel that the solution I came up with is 
correct. There are valid versions of everything at this time (the failed 
IP block isn't there at that time).

So how would you know to skip fini?  I guess check asic_funcs not to be 
NULL?

But then it's the same as the second commit is doing already.

> 
> Thanks,
> Lijo
> 
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>       if (!ip_block->version->funcs->hw_fini) {
>>>>           dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n",
>>>>               ip_block->version->funcs->name);
>>>> @@ -3496,6 +3499,8 @@ static void 
>>>> amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>>>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>>>           if (!adev->ip_blocks[i].status.hw)
>>>>               continue;
>>>> +        if (!adev->ip_blocks[i].version)
>>>> +            continue;
>>>>           if (adev->ip_blocks[i].version->type == 
>>>> AMD_IP_BLOCK_TYPE_SMC) {
>>>>               amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
>>>>               break;
>>>
>>
> 

