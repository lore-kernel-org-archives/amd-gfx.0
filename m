Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B6DC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 12:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB1C10F688;
	Mon, 18 Mar 2024 12:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjpHGuC9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119E110F689
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 12:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTxluKQLv/ZaPKQaNvucDrQjkO+dSBbga1AaLe4Js96jfPwsBldJpeAOOHeVl9t8WQe1mOXvk8ZP+Dd/ktVVW18Nr8I3iq2/wbrOzoObED4Q/wSzQdkvnUgIeieKEBjewtUnNkfV2jmI1rNjLlZ3yelLrMo3DE+q8CuLLuqsVaeIYT0f5i8FhZkiH5Z79/NHbVTZxC+losZrK2WwjspulIYTCqVR0NXCYp0XBGRmSVBTC4Zx9elE1RqydWC0PSeP50jCXqqIKvoOcMvB4+IftEBNcmqY9LaKgvS9L1V1+18nkmAYSFHOFe1VH6DSOqTm0G7zikrM954pglklnjgVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfkw/JFyaeqQmhtuh2lgHTe3cWVMUAod88FMkgjCdwg=;
 b=QqgTMEtAMGbdmAzd6lcApHsUscU/6LRuyohFE5HYLWQWPhzMqrmTYbawfVFIlHu+x93oJO+jmjqea/LZby8HGWr4XEmxVVQFSQUbdhsRtco0mElFBxqBfyky33C291R0Fs7PgN0p6wCqLoe3/Fjnu4LuMbzv/UsiW/cJS46TbiM96aDMNtUTlikNphgPVIl0wQwePgh2iOoJrLDpVgoQWNnSX4UpSOWqkgrcUt4EDWpJQQDLm7WXsmSbXp4CYsfYeLWSK0Aa6aG54mna+VlY6oX7laa105amunN+t4BRN0NOYSIbEfBquf6d3T2tvpbS4l3b/9d6a3nOHQ291o+zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfkw/JFyaeqQmhtuh2lgHTe3cWVMUAod88FMkgjCdwg=;
 b=jjpHGuC9y4n5EI7znw5KzC3mYW6IcW4z61cibuFz9H7y8MBXmaU+JlR2AC8MEEyBWP3ogQRJYjoeAolghJ9NHfkeGcgQVyQ4RY6hcUgJdlvyqpIvhnat6vVMTA3cYKYFtlpU6ThPr8v9lNdK/HEG4IQLMSrgf3WJdV/ALbKctQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:28:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 12:28:26 +0000
Message-ID: <036c4793-a9e0-4622-a148-7d49dbb0bd2a@amd.com>
Date: Mon, 18 Mar 2024 13:28:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the iounmap error of rmmio
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
Cc: srinivasan.shanmugam@amd.com
References: <20240315051725.2450734-1-Jun.Ma2@amd.com>
 <e9917d19-110e-4523-b268-8e79698466e3@amd.com>
 <60a6b7ad-cb2f-4c59-9b8e-e7082f44aaf8@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <60a6b7ad-cb2f-4c59-9b8e-e7082f44aaf8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1f2acf-defd-4d4e-71d7-08dc4746e8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDIrUO07OPVu2r+q3fC3WTR4zcGzJH+gHMf7JJQiWgcDnS5MDpL+bOLpQHsAJ+ffQ/luDhIWz9uNPCeyFuwp42Tkp8sZfQu6UTkZ8W1mneOP1OeOna1rQHmyuERECkSkLpntWl3fVYqvm28gDzRJ7fjshFDQQYHG/2BvexHPVXTVA5xRPsUw0G701q8u6PHhxmwUxXdjkvyhj8PqJ1Cg9XGjG8+UFWqp45PkE0ERMfTiwxV+w7zK5IHnT2q0X6CNgLFNqTDVAR7+pwnNCVRwaXPe7XZnvkEyWtFBiHe93HzA2wMCOCO+BR6/jMMJSVzuKcYXhI2lelFk45o/IdSs8KgHwZnOfrIUBkEL9saxV/hFXa5sHU4LHc37G5sh8g8QWCuoB2CY6mDpFw8RG0QELUWStqVmmsTjqxPphlbQR2D9FpErJesvR53JdqtHAOd6w/ftKDRFZO1ChIUx8s6HFxzfjBpXIztopleN8A/7GceCsH2MjVHKR0KVwnIjGAIcTHu+/6ERBbqmETyj/2rnuNsMFQHXydx3Fji9Pr+j5OBCI/YOfgh1anC2X/pOr3Bwu+YlAVce9Lk+vdhMAVYChG2FXZmvrOMMoBzn8PMKQ74lS0b+gserbqnmm6FFgZ4BJEzClT2c6vp373TOnsNLgOei3/5ky6Kf7BxvXCE3/vQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJVc3d0a05pTnEwRmJBeS9pK3VzNFpJY3FaTG9Jc0kzYlpKZzFnNkI1bjN2?=
 =?utf-8?B?TUVrdzBJQkt3bTBUZEJCWVFjRHM1SFA2TFJJTHVQcFJXTDNFUjk4ZjVHQytY?=
 =?utf-8?B?SWFKd0JleUk1NXdGcWw5azVvY3dnVU5CUDVpdUpPdGZsRWFqOWtKYmQ0dWFx?=
 =?utf-8?B?ajQ0TzJ4K2NOdG9RTXR0RTdpL0E2OUhsSUpOOURUUTlHdm1TVmhuby9vU25C?=
 =?utf-8?B?YlJXZDVZZkh1UEZlaTZ1ckxXaXhiSlJGY1RiaUtOZnZkaVRmNDFHZkhsM0Np?=
 =?utf-8?B?ajBHM015SUNiUmw2azd5SVd3Slg1L2FLUWZkSmx1ek05bk50bnNzanNBdHJq?=
 =?utf-8?B?dXRxMTJTdWdsQUdwM0dyR3lJUDlGYW5GNkEyNzBaWjdVMGNoNks4QjFGOUx3?=
 =?utf-8?B?TnV2YWlVOVluVXkyOUppZ240dVJMSDZNVFFQRFBkMWN0REppdldJK1gwVkFa?=
 =?utf-8?B?RnVrd3M1RkpObklBYWNVMHBaajZrM0NJN1U0TW55NGZqNDR1VjhoS2dmbmNF?=
 =?utf-8?B?aVQ2SDBLaWNOSEo3QWJWRmR6YjU3MmFrcFdXeDJkbWRWamt0QWppcmJ0L3pG?=
 =?utf-8?B?NUVHK2VrcGhXb1FhK0J0Ni8rTE1IbDVQTG1Za0lKOGI1REhNNEFQN0oydThn?=
 =?utf-8?B?c0E3WU5NOE81UGRUZXBJcjI3eWpvVVZlRzc2c1ErSHFLbG4wWXVuN1EvU0JM?=
 =?utf-8?B?RG16MmU5SmloVDdUQUR5Witaa1Zudzlnb0xIQmZYeUgxUHpDWERPTm5yc2U0?=
 =?utf-8?B?UWY3bmo5ZG1hYjJKcVZVeHZxY0RpY0UrRmx1SFpmMWM0Z0VweExqWXdBaXVw?=
 =?utf-8?B?RVp1VTM0Qk9zVFUvejIwcVNHOFR5UTdIMGhnbkRLbUhMV2Uxemt3cEtCYUkw?=
 =?utf-8?B?Y1hobVEwUVZ4R2ZWSFJORzZxTjR5YWc1QzFmZU1pdmR0eWtGU2hUOXZOcFVW?=
 =?utf-8?B?bVpJT2ZEOCtOaCtySTczYUgzUjU0d28yK1drT1lRRm83R3ZHODQ2bFJwQVc2?=
 =?utf-8?B?MTRzNkl4UHdUeERDZXV6UkdraVlDdkJZUjVJc3FyZlFPWldHQ0FOclk0eDQv?=
 =?utf-8?B?RFpEMTNNRjBFOGxRWGh4SVhHKytUVEp6ampoNlFacWNEZWxCc3VYbTlhMk1p?=
 =?utf-8?B?SGxnWjlsKzM0UGxXVXJRdFE1aTRBekhEK2EvV2RPY1BiZkQyWjBnWWFNMmdq?=
 =?utf-8?B?Zko0VHlQczhDbC9IVlBieFNFVWIrallJRlhQS2hVdGl1TjdjWW1hcVVqdGZu?=
 =?utf-8?B?My9GaWNGbTdpNHIvdkw3b2NjVjd2cUQ5L3B0WGZuR1Aya011dHNkblc3SURR?=
 =?utf-8?B?RFhNelBXNWNsdytUUnkrRU90dFl5M3RaOHRSQkExbEhwLytuUnh4dXRWY1dL?=
 =?utf-8?B?SHBxb1NLWHRNd1RQRjNPUStEaWxuanVnN29pVXQxTVFmU1ZxWmd0RCs5NVU1?=
 =?utf-8?B?NnVFaEJTL3Vrd2duSmxsTFdoQmV0ekFNd3kzdkRtTmEvdzkxblpWdk9TVFAy?=
 =?utf-8?B?Z0Y5QWhqUHZhdUU1VThQZzA0TEJPUUFMNDNCWGxJeXdkcWtRa2FJNnFlcU5S?=
 =?utf-8?B?T1prRUpPSmFMSTF4dGU0bSs5VWVCYm91b3daWWZweE1oTUlYOVJhOHpXRjUr?=
 =?utf-8?B?Z1hKdEVCa2lSSE5QMWI3dXdiODF1SWZ5Vk1rM1JCYW5tV3VUSUZBMTBQd1pw?=
 =?utf-8?B?U2xNNTRQWE5nUjE2dHl6SC8yNFNrM0pYUk1tK1phRmZBcFN3RCtvN3hXL0xH?=
 =?utf-8?B?aWFjTWtZblBuZmhCRzhuSWd3Z0doV24yUVlYSWVrWnJCSk9UNjYrL2NFckZv?=
 =?utf-8?B?WHpjUFgzS1dUQnc2OGJVbTJoZzBpMUtWYStlVnBndGZEQXZGanBVR0ZzMHR1?=
 =?utf-8?B?WW5jUnhWcWgyajdWMUlTZi9GMzJPa25ZNHhuSnhQeUplcmtnQ0tqOWxIWXdE?=
 =?utf-8?B?eW5xLzJua0phNFNrdG90TXQ4aFJJUktYQjN6dlZJN1VrTUpSQkdXUnlhcE1n?=
 =?utf-8?B?M3dNNnJ5T2g3eFljZ3MvazJiWTZiY0Q2MDEzMXpXTGhNd1ZjY3BKOGJWd1dS?=
 =?utf-8?B?alFQcFpiTmFwZG5nZU84cXRZb3VsZHhxNDlRMGp4eFBMZVZzdGNDSDUwa3RQ?=
 =?utf-8?Q?Lp4lqkGSAUvLB1tZbuO67y93b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1f2acf-defd-4d4e-71d7-08dc4746e8c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:28:25.9413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omphh5Kg972Livp2F+sJQmeY0Lt/M/HgKbiKLw/Qdfzc6+YRVaRyQj9qbC6H/1yb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
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



Am 18.03.24 um 02:43 schrieb Ma, Jun:
> Hi Christian,
>
> On 3/15/2024 3:16 PM, Christian König wrote:
>> Am 15.03.24 um 06:17 schrieb Ma Jun:
>>> Setting the rmmio pointer to NULL to fix the following
>>> iounmap error and calltrace.
>>> iounmap: bad address 00000000d0b3631f
>>>
>>> Fixes: 923f7a82d2e1 ("drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()")
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 39dd76e57154..d65a6aabefbb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4383,6 +4383,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>    
>>>    unmap_memory:
>>>    	iounmap(adev->rmmio);
>>> +	adev->rmmio = NULL;
>> Well that doesn't looks correct to me. You seem to be working around
>> broken initialisation code here.
> I got this error when I tried to rescan the gpu device after removing it.

Yeah, exactly that's the point. The whole smatch warning was just bogous 
since amdgpu_device_fini_sw() will always cleanup the mapping.

So the whole patch 923f7a82d2e1 should be reverted instead.

Regards,
Christian.

>
> Regards,
> Ma Jun
>>>    	return r;
>>>    }
>>>    
>>> @@ -4514,9 +4515,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>    #endif
>>>    
>>>    	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> Ok, well that alone doesn't look correct to me. The MMIO regions needs
>> to be unmapped independent if the driver is disconnected or not.
>>
>>> +		if (adev->rmmio) {
>> That looks just like a hack to me.
>>
>> Regards,
>> Christian.
>>
>>> +			iounmap(adev->rmmio);
>>> +			adev->rmmio = NULL;
>>> +		}
>>>    
>>> -		iounmap(adev->rmmio);
>>> -		adev->rmmio = NULL;
>>>    		amdgpu_doorbell_fini(adev);
>>>    		drm_dev_exit(idx);
>>>    	}

