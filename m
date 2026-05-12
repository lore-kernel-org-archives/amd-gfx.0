Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E09CCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 10:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E739910E256;
	Tue, 12 May 2026 10:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vH8wzjk1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D35E10E256
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 10:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owaunlp5SSeSdFbg6Dyx6fs6AvIXRiF1aiI4qSuYtFu+//bm8LqQYXQDGJSl0405Z1g3B135iJNarKL1VXXZSFfS2hrPJTGT8zzPtN2DQxITn8Xtdl5W9skg/EaBipA747Fd4rYasiocbtcQgUYbbDYyky3agPhVnVSAJDgNZdxYf25i/WS7a8hV5F/mM1WBKE+5IbrIyFBS95PWc0TLRDLjvNO4H+H4SzngfwrV20QfWZ93gmqGvkKri9aUK6/KkJpNSdCTizgoNRP8vYjEp5KUlhfhsZTn5l1k46fwTKaDrj7e8xNp9Gku61xlvdSg7o9YlyXEUHsdxvVBX9o7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q8UBPOihWJhoqIy/hhyUdCXG9e1MYsHpVce81M94WQ=;
 b=nh+aujN9jROUGfTACwuXhCXW/s9bjFb9sPriGFy3aHqVo5HiFkYR6e5Sa9lHgSltB4cdfBs5VDcNOWlqQpVx/vKRoks7X3K8g6BmsopqfRvEsTDkHraKSq8yrHrs8tTQdE/ZKeqN81fqumJtiihxtDWC+ox4I5QoU1UFwxsxcasxs1zFp+xRA/6on5hKw5UQCqjkyuObEVswNn+QY/6xIq9voY2G7w7bAEvVzpbo833lMAt6zSc6ZYk+yTJhNEELHSg0pGPkPwmp33Ebtk7KaAw0FjlB6YEYNNzeVifpoLm/MoXhjTWtDOuBYKrpCGKe7TMZDR701/64IZcR+aNYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q8UBPOihWJhoqIy/hhyUdCXG9e1MYsHpVce81M94WQ=;
 b=vH8wzjk1GcoVLzWlGsXrbtR+UkvZtkye8ByDDXnul0EQIV/WZ4XRvLgWIawKxokdGMOcLXgjEFteKc1ik/Tu/N4Yea8WqJdWeLz9dlF2W4cnLoabkPGwDgyvwpLtBix2SOA3OBXr7rzsloT0aXv8LwTWpjT7t+0GUPGHdU8jfr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 10:49:23 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 10:49:22 +0000
Message-ID: <40cd6b05-6db7-40cc-a37e-eaefa0e3b2eb@amd.com>
Date: Tue, 12 May 2026 16:19:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: update the vm task info during signal
 ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512103208.1012595-1-sunil.khatri@amd.com>
 <5d6f5153-628a-47fa-be0c-eae8f2851113@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <5d6f5153-628a-47fa-be0c-eae8f2851113@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd70446-ac79-4497-1f07-08deb0142085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Y1NWXKPlgnKbJjqOswXHzlTabTxeGxVR8gALaDDjK4zMwXFidTao9/b6u+Q1fD0/U9obQ2ygR9Lpin1PGmRhr2OBLffsD1BqGCa/lmWLZ7R7X4nzhoOV7XBu1G+2x6jsozSqjyp3OneA7byq5Ck7RxSBKpRoHfxP8vSX7aqcRJN8z7g7fLyLIl5qqd1N+uYno3Pz78V3RMfGKfaAk6MsLYRnlXCeZHezBxPUilkIdgPp/+tjbMyURr1Eefj4gqAh5Bjxwf7dewZ3yrKN7BNZA688qNShCrXe/3Bu6OktTmmC9/FjTheuzxt59wwZ6HJMG8c2hoi1IBSt3enNMuWuMIvi6cYlfE7F8evje+q0egCJsDb747m6PEw5vUxYAjPiqsSaPZNrA4bnDnZmB7IldiFIxXn/EK1q6Uk12+WQCNeowV3Cw0CcWrjTJMeizJxaDNzFsnqIEwVAkEIYrLAaWAYvptHkMosn7u8GD6RUzo6kzzexx07jYBpgHOkIp2Z9Y6GLc76Y4TwoP2Czg2nVmYsBGkNtDzWyvwH+yZott21jDVDs5e1BCYnU/sWHS+RrgJUYHXCN28pA2XJGaamlIHUHfzHarUkbrtnGhAMLvMrb+t61D8EaLS0+IvseOYTHLGuf+UvEny3ys1GE2sQsQaXC4TPL2d5jxfpcdtPdoatyr/EOJG84FSJPLh7pFn0w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTh0K2FCZEVOUDkyV21ZZ1V4V0Jyc3I5SVlqMjROcWJvRWx5RDhuR210MENY?=
 =?utf-8?B?MG5hYnRadWd4OTJBTG1uQU5DNUc5c2ZmMUkrbzhQSXNKbEU4WHNlTk1lWFBW?=
 =?utf-8?B?emJZZW9UazJLRXFuZFFYL00xbE9CY2p5NFJ2L0hVNmtrbWJsZFl4MkJLcUJM?=
 =?utf-8?B?SndKemcyMDJuN0lrdlN3dzhNWkhYYnQ0MmpqbzBpK3Mzb3hla1RsSkpUaERu?=
 =?utf-8?B?anZtRm5TOG5kdk9rQjc3bzdVMkYrd3paSFpuSStZSnZuNE8va0YyeFVzVTZ6?=
 =?utf-8?B?YWNEeWZUSFJKQ2RZZDJsOWc5T293Ry9lRXR4b3B2SG9HTkpJdFN2c243ckx1?=
 =?utf-8?B?N2czZ1dFTlB6Ym56ZGVtUGJaa3ZYVWliMkFrQkt0T0J4cWdQam9MT25hWnJu?=
 =?utf-8?B?cWRtbno4eEFub3hJMVZwNUIyUkd5WFhvRktuTHJBYjBBRXN3M0RXZm5vTFJq?=
 =?utf-8?B?bXhZYm5uZFBhVGVPTXppTDJIWHc1K0VLZWV6a3kwdU5mMy92ZzdjcEtUemJo?=
 =?utf-8?B?MFZVWUVRdFRZQ0p4S0Z1TW11anZkakVDV3pRQ0x5aVFiM0dFTk9GV0pzUTBp?=
 =?utf-8?B?YndzTnZpek9FNktVSDVCaUZFQlFIMmhMeGdkSVdMK2dMbkdNaitQdk8yYlBx?=
 =?utf-8?B?S29ET2t1b2JCWDc4STY5bGNqOVBmWlBRTTc3UzRBQy96eFc5SGJxZUR3dzQ5?=
 =?utf-8?B?aVJsV01peVBSUEE4LzVIL0lZQjYrWXlTUWxEdTUvZnpYREtUYUU0aXpDS1BY?=
 =?utf-8?B?dFlic3M1aG45RFFQaUV5aDZDVmZWSEU0OVVXcGgxUzNPeFVHTk12bWZzTjY1?=
 =?utf-8?B?ZjdpTzZHUEk3SnNINDF2Z3hMU1dXNXRzYlQzRHhlSlk2S3VTcUFlMjBuMjlV?=
 =?utf-8?B?aThIRElpbjNkdVk0MzE5dnBVNzJQd2ZBaE4zRWRqMUZFUHFxWFNaODgrU2Jx?=
 =?utf-8?B?aGE1eHQzdHIzNUtOWmdBN2pjMVVTOVh3Q08weitBOVVEV0ZhOWpValF2M1dZ?=
 =?utf-8?B?c2lCU1RGT1VTTFBoL2hMM29NZTlQWmVJc0plOWF4Q0NtZ2JpQTM0ZHJXYnZp?=
 =?utf-8?B?b3dGRnZLOE1jOUM1V056Y3RFdENkSzYxRWRvT25JaXFwZjlhMm5qT0ZyVUFB?=
 =?utf-8?B?SEh4NnNrTnc3WkkyWGJTVnpMWGlZR3IzTHBOaUxHT2YxalNTNGFPU1g2Q05l?=
 =?utf-8?B?S25aN0xyZjJBVGFRQkJKaVBFTGNybnNLaGhNdVdTandxRlNHWlRoaXc3K0NT?=
 =?utf-8?B?VUZVZEtWVHZtSE5RRjJnQVArQTBiQWlQK0VBbytnbFJteDl5VTVEVlJ2T2hy?=
 =?utf-8?B?UW1GOWhXeVNpLzQwK2RFOHppRElqa2NLZ1dYZE9YMkkzWlpWL3FOMEZnTCth?=
 =?utf-8?B?UEcxNi9oVW9IR3FucEtBWmdkaHpSRC9xUU04U1ZZRXhYb1FZU3BYM0ZQaFdI?=
 =?utf-8?B?QTlKQkZZdGJrQ3pjdmJmdVY2RDcrM0dsMjVFUmhadXhocE5kNTB2eEtzWG1m?=
 =?utf-8?B?aHFyY0FXd29kM3RnSEcraXh5RUFhZ2hyY1o1Yk1JZnJjb1U1aDQ1R1hHTk5L?=
 =?utf-8?B?Vm5oVHNoQ0RLVm95VXRYZ3UzejQ4czRIaEQwallkWHRJM29oNVdYKzZhWXc1?=
 =?utf-8?B?dkhQU25wZW15UVlMb0Z5eDExaVAvYXp1RXh1NXgzcnVTL0xWTWZuUWZyRzBJ?=
 =?utf-8?B?U3d0cU1JRitJa1dSak1ERVc5MVV5VGM0MEN3K2psb3dDUUZtajNuWm1FOW1H?=
 =?utf-8?B?NWR5Z2FlKzJlY3B4RGpoSzRWK1VkdVlCM1p1dUlSWUVzdjdaK2xuL0tUeElq?=
 =?utf-8?B?eEtwTnJ6NFhmaWhsaUhVeGZpdVNhaVJTblY3UGhXampFaUhMeThDdGFDaDNV?=
 =?utf-8?B?SWJoRHNZaFVMME56TmsvTG5kVi9RRkdON2RPVFJ2N1NWdk9pWk53R1poOHRn?=
 =?utf-8?B?MlpGQjRuaDU4MG9mOXJhVFJTMlQrMEJEdWZlODE3UnVlVHpEV2E3YkZQZ3E2?=
 =?utf-8?B?M1o3M2UwN0t0VDVRUUZQRnVCcjRudjZ0L1RTUmRhazhDT2E0aVZoYnR4SFNV?=
 =?utf-8?B?ME1idmVYa2RKYWQ2L3BZZkxMRjBBTVlMbFRhb0kwOW5La2dwdExsazZBQmZo?=
 =?utf-8?B?d1BaR0xGQm1yWDNESjhJejUzK2YrdnV1Q0Q4Vi9ZZlk2cTJkMXgzQUVTWnc1?=
 =?utf-8?B?Q202UDUyR2wveDlRcTZrL0FsU1NBamZFbTJTY3Z1dXUxdWt1ZjNBa0lTUGxT?=
 =?utf-8?B?YVJzYlVJV085ZE55SEwxZnhoaVc3aWpJS0pmL1dEbHR2MHJtVEMyQzZMQm9F?=
 =?utf-8?B?RWQrZEp5MlMycHpFc0NpSHFrNFRJTHFaSW1lQXI2UlAwZVVKVm1VZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd70446-ac79-4497-1f07-08deb0142085
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:49:22.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2HRnZ5+FYKx0TTE+Lh9Z5/KkLDDNjgXVgttkcH/SJ5a00NIzzKIeDS3qu5dxOSCrRlRiAX6JOpkiAxamVCr6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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


On 12-05-2026 04:09 pm, Christian König wrote:
> On 5/12/26 12:32, Sunil Khatri wrote:
>> Pagefaults does not have process information correctly populated
>> as vm->task is not set during vm_init but should be updated while
>> real submission. So setting that up during signal_ioctl to get
>> the correct submission process details.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 008330a0d852..1dcde9b35f8b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -514,6 +514,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   		goto put_gobj_write;
>>   	}
>>   
>> +	/* Update VM owner at userq submit-time for page-fault attribution. */
>> +	amdgpu_vm_set_task_info(&fpriv->vm);
>> +
> Doing that in the signal IOCTL is probably a bit overkill since it is used quite often during the lifetime of the queue.
>
> We can't add it to the userq manager creation because that is often done by X/Wayland instead of the final application, but I think we can just add it to the queue creation.
>
> That should always be done in the process which is going to use the queue.

True i also thought of it and it is definitely a overkill, that's why i 
thought to have a check if its not NULL then set it else just pass it. 
But i agree during queue create time also it is fine. Let me send the 
new patch with queue create time.

Regards

Sunil Khatri

>
> Regards,
> Christian.
>
>>   	r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>>   	if (r)
>>   		goto put_queue;
