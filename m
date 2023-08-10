Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1058C04A6A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 22:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644E410E611;
	Thu, 10 Aug 2023 22:27:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B5F10E610
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 22:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXLUwEUddO5fqJxve9JBpINc6s9AM3gAMzkIsLQoSq73l7UsbEmO+njFVid/0jGJRzIEaT1JiTWP51mTQLD/6+kre4XUMNi46S0sYW5MphXnaP7eeN5FYINXc9AgJ2GbVFOKWENBaHeO6RdsPWvvYS5o2Z6uTpvF8mfcIwTHLX0CFGu+DhPpVptZKsYpr7DPjMxYzH84nffCZEZCMxO2ILgy2mLItmcpoiFF52+6TYUVbs/NypnS3dKxWxCtyzlm0BoIAbA5RphMTOoboY8SHPncNnSmrr+36QMUPkYEkkS1tzf9HSmngAUtGKBha5LKc9cFGqa+n5VHOuYB0eaDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmUaO5OQn7hhuQFKxn2aUay95u3206pq+VaxyD0EWnc=;
 b=dn03J3+4p/kURjV4ETZiGsZjWwc2P8O2hXeTBOcoTvKGxYqxvfjIXCEBcq40P1gMqJ93fWuzggUNyrF35Y6K5tfWTB2e9aieZ+c8AVPKK/tTo1xYGzGVuu8YTEWAvWd3eJn4njiYaUIYFYwiuyim7vyIcAWxuq2r6ZzIPS5T3x7udB0t5kumMF3KBgcYRiWWnPcVK+8Yz9h5hJaErg11JjX5vIF8OUukPVzAffL/+qU+7HylBu0DndglBw14luYI51YvBmj+H4rC7LpmKFwXyqlw4uy/xfbxoM7qaAhOLJdK1rC74nf+jg9U9Q3P6L2ywKuBSBMZhBKfLAMHkf0fNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmUaO5OQn7hhuQFKxn2aUay95u3206pq+VaxyD0EWnc=;
 b=ODR1CNr5ApGjRYH5E1lOKDv6cIqDytwXW8h+E99xwnz3jTnaf0dYzvzZ/6pNXOi1t64HvH3v8Z2DKEb4hGcG6K4Z1c+fzamrSlRGjkp3/rWrHvAJW4YwOFZJZWywJyGqm7DKUrkhk4Nk7tGstuxmfCZPWNUTR/q/P4yoM8C0ymk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 22:27:04 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::4d2a:6792:2239:9e72%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 22:27:04 +0000
Message-ID: <e5495ff6-b2ee-ca2d-78a2-4747c0c46668@amd.com>
Date: Thu, 10 Aug 2023 18:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
 <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::11) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: afab128d-92d4-4bc3-cd1c-08db99f0ec78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPsp3VJFqQLN+fk9aH379PHG3ckLavJVrEy8DYuDJbZlOZWe2yEvFPrBSKj/iYHhaRnLHzaTbrkpZNNvdil8oszl2Yf7EJ29G4mYGPSGEfrNYrjFexLnMt4SVxszogz9KBzq6KBp4ezIgGdnQcbtXwwfN8EDpZWwaYxr95YK4CL+sdcDMCmrDF2pJdV1AJYeKwcTyw1g/JjHKosHu2OV3mwa3avGnw/hMn9fxdlUiSU8xlRrq+qS+5kh/A2MNIKnmt2kIdyihOaDcOusv/0H2ROobxzXihVN1ettz9sGpUrSFHp03z7M4nI0kodBWC8PexPF99bMG8HZ61vmcaqt1EABwXUtpKLSEfZnFGCjW8uXuJOUBbJuDwlg1Sn2Am+s9KcSNzywtotv8mzIvSp5W4DYjqloCgMPwUBQ8tr6tiEsgQZt/NNTSnVkgoBR3+UNW1wKE21gcnwuj7Pa1dMX94d9IQzMo/8JFWSuI0gHQhjG1+cMR2B76tuhVdGxx41+OAUBOILOepgR4zeFmDJ/ZAsfM0ujGDLlKFoQJYQV6FBBV8hiWoK5l0DxzAVhP7/y/oZIiV/oo/Pqtv3EulhhLCbfRPgZxFHoDiuB/8PfR9ytskr4poBQhO+IqIMkFgikCsyWI6Tma2TT7tguMDf1Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(1800799006)(186006)(451199021)(8936002)(6666004)(316002)(41300700001)(83380400001)(5660300002)(110136005)(38100700002)(2906002)(6512007)(8676002)(31696002)(86362001)(26005)(31686004)(53546011)(6506007)(478600001)(66556008)(66946007)(66476007)(2616005)(6486002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Uwc0JXR3pES0J4TWd1MG42dFA3cVRxSWs1dmk4UUVlS1JTREovUEE0dkda?=
 =?utf-8?B?ampaVlc1K3VhVnlHTlNld2FkM2ZuWjM2dXRTZkl1T0poU254L2lDRjFTY2Jj?=
 =?utf-8?B?ME9kb3VTYUdXQ09aL3k0V1g2MkxGVGwrTHhlUjRta2Y5MnF5eU1udWIvYmU1?=
 =?utf-8?B?eUpaTGlKNHRFOGI1L2MvNnJYeURrS1QwS1NCK3czd0ZUSlUxK0doOW9YdkdO?=
 =?utf-8?B?ZTd3dktuNzVabE0zdjlhbnZIYWNKZ0xPSUFzTEVGaHZFdDV1V2h3VGNGaTJ0?=
 =?utf-8?B?dnBHS2JWamFIdmpZT3J3OVZmeVhYZjJhc1hQa2FBYWtMejA2Z1FDSDhoY25M?=
 =?utf-8?B?WXQwTStrY3BocTQ0a2JseDQ1YXYyS3NMUURMSGJsWTliMHJ5S0JUVTVIMmxz?=
 =?utf-8?B?bHNIOUlNOENabUkrUmpRcFQyS0pSL2NVM0lmMlFBekhxZ0U5MWJESG9Gb2ZH?=
 =?utf-8?B?d01FVVloQURFZXE5SHR2YUNSU0xNdE05NE1hNE9BSDFQaHg0ZFNyeVY4eUNk?=
 =?utf-8?B?Y29iaG9WWUxOd05Gb3RydHRCRW51aDFUWC8rVkRRWnpqYXdHVzRvMXo5Q3lm?=
 =?utf-8?B?SXd0U3pSY0JKZGRGTStWL0w3WEZXTVdNMGVrUmpWQWZzbWc4TDdsOWhDaVY3?=
 =?utf-8?B?M0l2U2RrMk9uUVloaWF5RG9pRWlLMWYrK1pBYjRlUktqM1h2WGdQcTVsUWxY?=
 =?utf-8?B?NEZnZC92Rm9sOHljU0F0VFFKQ3o3d1ZCNExhaWlmTlovOVhaSDcyNWwwRW9Z?=
 =?utf-8?B?YVRKRXdMTVRLekRXeWxQb2k4OWFzalFJYUQwUThaTHFuZDhVeTVIODJCR3NN?=
 =?utf-8?B?aWcwQmE5dkw3ZmJTK2pVYzFMVXR1RERKRGlkRkJqWmp6ck5GVmgxVlFXQmFa?=
 =?utf-8?B?VnI3azRFckFYUmp6RkFCM0VDK2tkY2xXYkhLcFlTTW9Fc1R0ZHpQdk5QVTcx?=
 =?utf-8?B?SW4xUUlpTTkyZ0grNkZobnJzb0FTb2NDUm5BSldFYnZIOEszUHNQYmlHQkNr?=
 =?utf-8?B?WWxheXVSOWJORU40SFVBVnU4TUVmdVlCTDhreWQ3Y2hlNDhvbjllZGFZT2do?=
 =?utf-8?B?WUJrOHRPL2tQWnM4QXhDemtTM2U4cUg5eVRHL0EvUGhoaUFhdTFLYVJmUGF2?=
 =?utf-8?B?dlpVcW1HVWZaT0d5OVdUNHZmVmRtdTZZSERXOGlFeVVkRmpOK2huLytYUnkx?=
 =?utf-8?B?b1NyN1hLU1hZZHBER0x3UWJHNGtDS2pQek5zOU1LNGh6ZURMNTR4dDdEbGpC?=
 =?utf-8?B?Vlphd05lTzVNOUJpWmZxQnZXdTV1dElOTXBHTHNSTGt0Q0haeExmQTVCSlRT?=
 =?utf-8?B?T0hEYkJVMTJOSTRFdUNWUzB1U1pXcGlwYkNTUWRhZTRVbFo5aUo2bm53WXlm?=
 =?utf-8?B?L3VHTXV6TUR2NnNIN1ptMTFrTjhsdUxJeTFvbENmYjh5K1U5YVpybFpuS01v?=
 =?utf-8?B?T3h2L1BrVzBoVWNna1ZkMm1zZWxwUm1rYzUwYUlia0wvNmpoQXJCYTB0akly?=
 =?utf-8?B?REpBOFNESU4yRVBlRnFsQSt5VzViSGxIUHpxdHNGL3liQmZYS09maGxldkYw?=
 =?utf-8?B?WWdHWlM5Qm9odEVoSHgvN0V0Y2ZINXpHaUJUQllkR3hSY0pCZjdYZFFTNU9Y?=
 =?utf-8?B?dzNGamx6MVBiTXl4dTJVbFVrZnlMelVpck1WZHM5RE1veW9RNXR5NFp1cDQw?=
 =?utf-8?B?UnRpWWJGRUpjYlJWb2JaSy9XbHVwaFNDM21rOEJ1b0lNMkt4WTBMTy84NlNV?=
 =?utf-8?B?TFhuMW0zaWJ6d1FLRDJ5RzErU1BXTHhzaXNEM3RleEFBaTZtaC9ZVDVSMWJO?=
 =?utf-8?B?V0VtUGdDZjBNUklrYXlmRUNwMHh0K2oyTTNIRktQRjBjdVFJVGFMM3JXN1F6?=
 =?utf-8?B?REllRzN1OXdTRm1waVhkbXQ3UWNhSm82emxBUkFGdCtWcElNOXZLYmc4VGlB?=
 =?utf-8?B?dUk0YzIza0ZIQ0J6OVlqQkUyVTZNRVBQMnJtOWdPdGthdzJQdUUvVkc0dVI2?=
 =?utf-8?B?TXByazhyT3F3Z2o4UFFyamRxRlUrc0xraGxPd0d3eGxQL2RsSmVJTldvWity?=
 =?utf-8?B?RE9SZmgvcGFDR01mTy9kU01nMklnRTI3UjcweFU2R2RObUFIRjBiaTdSdlFM?=
 =?utf-8?Q?vwB/jKIt9HhYyu58etDWhVozg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afab128d-92d4-4bc3-cd1c-08db99f0ec78
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 22:27:04.2503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24dzliZ9bqmSd80JBj4wKrtZ98/VcDfBWjyz5A0rYfyuaHR86KeHFn5TRTgNd4rNZfm8GK/od+IzpYSec8kYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

There is not UNMAP_QUEUES command sending for queue preemption because 
the queue is suspended and test is closed to the end. Function 
unmap_queue_cpsch will do nothing after that.

The workaround is new and only for gfx v9.4.2, because debugger tests 
has changed to check if all address watch points are correctly set, i.e. 
test A sets more than one watchpoint and leave, the following test B 
only sets one watchpoint, and test A's setting will cause more than one 
watchpoint event, so test B check out and report error on second or 
third watchpoint not set by itself.

Regards,
Eric

On 2023-08-10 17:56, Felix Kuehling wrote:
> I think Jon is suggesting that the UNMAP_QUEUES command should clear 
> the address watch registers. Requesting such a change from the the HWS 
> team may take a long time.
>
> That said, when was this workaround implemented and reviewed? Did I 
> review it as part of Jon's debugger upstreaming patch series? Or did 
> this come later? This patch only enables the workaround for v9.4.2.
>
> Regards,
>   Felix
>
>
> On 2023-08-10 17:52, Eric Huang wrote:
>> The problem is the queue is suspended before clearing address watch 
>> call in KFD, there is not queue preemption and queue resume after 
>> clearing call, and the test ends. So there is not chance to send 
>> MAP_PROCESS to HWS. At this point FW has nothing to do. We have 
>> several test FWs from Tej, none of them works, so I recalled the 
>> kernel debug log and found out the problem.
>>
>> GFX11 has different scheduler, when calling clear address watch, KFD 
>> directly sends the MES_MISC_OP_SET_SHADER_DEBUGGER to MES, it doesn't 
>> consider if the queue is suspended. So GFX11 doesn't have this issue.
>>
>> Regards,
>> Eric
>>
>> On 2023-08-10 17:27, Kim, Jonathan wrote:
>>> [AMD Official Use Only - General]
>>>
>>> This is a strange solution because the MEC should set watch controls 
>>> as non-valid automatically on queue preemption to avoid this kind of 
>>> issue in the first place by design. MAP_PROCESS on resume will take 
>>> whatever the driver requests.
>>> GFX11 has no issue with letting the HWS do this.
>>>
>>> Are we sure we're not working around some HWS bug?
>>>
>>> Thanks,
>>>
>>> Jon
>>>
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Thursday, August 10, 2023 5:03 PM
>>>> To: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>> Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for 
>>>> gfx v9.4.2
>>>>
>>>> I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit
>>>> different because it needs to support multiple XCCs.
>>>>
>>>> That said, this patch is
>>>>
>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>
>>>>
>>>> On 2023-08-10 16:47, Eric Huang wrote:
>>>>> KFD currently relies on MEC FW to clear tcp watch control
>>>>> register by sending MAP_PROCESS packet with 0 of field
>>>>> tcp_watch_cntl to HWS, but if the queue is suspended, the
>>>>> packet will not be sent and the previous value will be
>>>>> left on the register, that will affect the following apps.
>>>>> So the solution is to clear the register as gfx v9 in KFD.
>>>>>
>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>>>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>> index e2fed6edbdd0..aff08321e976 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>>>>> @@ -163,12 +163,6 @@ static uint32_t
>>>> kgd_gfx_aldebaran_set_address_watch(
>>>>>      return watch_address_cntl;
>>>>>    }
>>>>>
>>>>> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct
>>>> amdgpu_device *adev,
>>>>> - uint32_t watch_id)
>>>>> -{
>>>>> -   return 0;
>>>>> -}
>>>>> -
>>>>>    const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>>      .program_sh_mem_settings =
>>>> kgd_gfx_v9_program_sh_mem_settings,
>>>>>      .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>>>> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>>>>      .set_wave_launch_trap_override =
>>>> kgd_aldebaran_set_wave_launch_trap_override,
>>>>>      .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>>>>>      .set_address_watch = kgd_gfx_aldebaran_set_address_watch,
>>>>> -   .clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
>>>>> +   .clear_address_watch = kgd_gfx_v9_clear_address_watch,
>>>>>      .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>>>>      .build_grace_period_packet_info =
>>>> kgd_gfx_v9_build_grace_period_packet_info,
>>>>>      .program_trap_handler_settings =
>>>> kgd_gfx_v9_program_trap_handler_settings,
>>

