Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B645F44841
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 11:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB55910E94A;
	Fri, 10 Apr 2026 11:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vibao2V/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2478010E05F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 11:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqwpfY/ofefGfPsb7aQ0cpCROS+VfD4C5mzG/dKh+ZkREQdXrU/FJspvgLJobtOk8aiApYFm2V8xkbDmqWzVUotKtcUwfptf+FrpSvGcx7UifIa1NGfCtE+oDj9moXmov9WtsDNveh5CchBJOB7ljfpA09XAp/9MFYurX3hrgvf8DF7qiRRZZgugqaPL/4Nh5sNWA3OeAfUoEZQmOw/oCGnDxe8vLw3g0wYUmKTG+ALRPban/71Je9MY8BAmT/iGOJvRyOsi1UJe4e81yPBL/FbxnM5nGjd9+psirlm6XZPGJ52vNMmL6ZfXjWe6RY+4ZXrQFMzu9ZcNxafi3QFHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz3XjeF+3bcb2VEH+mUEGHcXc+Eu20Yq+qBvrHaZkrY=;
 b=CI6LBqdvQ60XBnT6XNatiavTv5WdB7jfnyRBkPSNfEJmB+Frr8u492FZwmRe7AaQDEMy6Z4XqWfg9pA2n/tqI1cba8OjMe07fPq9TGFP+wM7tBgqXhB7cWsrxlymJGBNz5FY2qiEogs5i+CLU5jFdSSOYaaHZb0eK/CwYaz3Xdxf/Sz2mtRZY9PB48GOLDv54PlgLvb4NrDqKCcpEuz44s3lO4+uBTdRKEbx9XOMcZEyU8ztLxc5Ar5jxbRLlB4x8CYtaOIRYlIfXueezFMqFGDkfroz3fm5kkD5qGrE7YjsZF/ucdb2jQGwT9wFde5HBOzUTMfnpE4jjnY6yfQhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz3XjeF+3bcb2VEH+mUEGHcXc+Eu20Yq+qBvrHaZkrY=;
 b=vibao2V/royGUZkBN1N66EcdWbx20pBVUyrXxr/DN7RqYwVzvYLMM8eH52VUTlaSBsq99T6hi+aFAs9cfMgUp8Kv7EUAv2q7op2IuOtlhqDeinhsbJrk+/IJ1v1IXtWqvgG1ejlmnIqn21c41hrHsYii6gONuHRonqVgFs7aXnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 11:50:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 11:50:22 +0000
Message-ID: <8f7a2920-b8db-42ab-820f-63de5eb89e23@amd.com>
Date: Fri, 10 Apr 2026 13:50:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260408074537.3439191-1-Prike.Liang@amd.com>
 <9a52847a-eb80-4008-8d18-9707bd1751ca@amd.com>
 <PH7PR12MB6000867DFA188AEA5489ADE7FB592@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000867DFA188AEA5489ADE7FB592@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: d6015a51-3242-4bd9-8c87-08de96f758b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: CSAwE0XSHuUIv0NVgo7/jtkNcxVdMvbOQl42r9cmKOo7QV27U2w3yN4UqZIdS/yVw7Q0SuMCrP1U337baoaRDtrmkZUN50j6tbCMaoAwPGee4yByGxBnGqKw1CUJMwWF6EGLX097NavHhwXg6kEZY7UQY1iM72T0FL7Zc/yXKSKmNLx4Dd/HMp0LsOgRZN3+THXig6CLkuDjEWMwjkWmYEaT/IxvB4+cSU6jsDsizUSp8yyRWltMGlXUN/BESnlIJ8a6kXyja7PIAda8TjEd0DmIqtZuN4kajMDAc6xJBzJVDahg2yECj99Rf+7FQ/EGo5248kSQTjoPRRc7sFLQySFkEqj7RndeKl2/JO6VWiBJnjiVrp245l7VZr5OqiYVKa+3mRrzZYRMJ1IOaQTnrbu6LffZk5GGt6weSzPtEoL6AKySgU41Xfi9YGffaqNGD4we/cKww2mlJAZGWISdeUFNuky0XDySkbWNuGYzZBhszMF0SmNCzA0S4/CGQIvukg3GAMtdvzLbnYuII4CpDY/bSohehLTLk9ybo2S4jjlc1fF+SYy/EnecfvHdjxSqIeNdaJytOoEBy3N8IvCb2kdYRIYSUgODGZnkI5uSYf+75ivzTYLojt337+YuHymr+FHdMTMhZVKFl7JgQda3OZz0fei8K6zieVqJUJTRjtLlcJ3HZ73OLwnEMjru9vIsIUGcFqGRhjn6HDX3pNcmvocOhAUhUY6X51qWqbkCZoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRuT0gvMnE5aWxvV25SU2haMWYvTHVmQjRSRk1GUjhDSGxhYm44Sm9TRWVr?=
 =?utf-8?B?Qm5kYmpubk1hcng4a1dwR09TR1pnVC9VOURRY1ZxbENoQnVvbjhobUptVmp3?=
 =?utf-8?B?WFJLM2xpS3VzdXlDTk5ISlFNOEhkYW96aDZUWkttcXd5dTJQQmx3MjIyM1oy?=
 =?utf-8?B?dWdycHdCMFZ5MWVBTXNFVlNCbVk5a0haS0dkRmZhamJQTytRQzJkNnRGS25F?=
 =?utf-8?B?RVp5YXcwL0Y3WDFNODZPV1NpaFptMU93S3RnSUFTbnlCT3lXV096WDBpNTIv?=
 =?utf-8?B?a0U2bjBoOW85SHpKNU11VEpsUnNZalhaZmFvRllNY1kzOGNHbkFoSzdIK25K?=
 =?utf-8?B?MTcvL0hZQWhPdkJsa243SUhEODRoZStWaG1Rb3c0OCtPaysxTDg1R09QWVZx?=
 =?utf-8?B?cElCK0RkWWpxcGwwS0VrbUgwWkRFeUNrK0pIbVd4WC9mRTczY1k5bzVoZ3Nq?=
 =?utf-8?B?SC9DYjc3a01CU29iYXlxWTVtS3gxUkZoRW1Md2NIeDZ0Zm1NRjhFdVFtZ1Fu?=
 =?utf-8?B?ODdqa0tuaXZpSjY5ZHVwTHA4b2ZCUE11YUE4NWhlWi84ZHVkV00xOUxFUGIw?=
 =?utf-8?B?ZE5TdGI2UFBDVnZlZk5SVGN1c0RyeTdrM1llaGsvL1NFbGNyU2tIYVlQdFlM?=
 =?utf-8?B?dWQxM0doQ1dNaW1xWU1qOXdjTUpyd0E2OVRENVpSNy9SYzBxYXdwMWVJWHdJ?=
 =?utf-8?B?QitzK2duTnVMMHR2YTQ2djM5KzVUcGoxK09NbFBCR2lGSWZGYkx1UVNlTXZG?=
 =?utf-8?B?VS95Kzd3K2Z1Rm1Pd2YvUlQ1OWZwdWlSdWFHQ0VFL1pmSkYzWVVGeERkeXJv?=
 =?utf-8?B?MTZMcGJGdyt5T1JJYmJyYUViTFczcGFsRmJDSzdPTG9rRVhGVmh0ZjJsSjRL?=
 =?utf-8?B?bEhJU0VjMHZqbEFuSkVMUnVsaisvdUZIVWF1VWtFbEJRQ1JPOXVOZDJId283?=
 =?utf-8?B?WDFuSndYbXpubmhGTVpaZWxKd29VTm5hcGowYWxnelhrL2N0SE5WSEVvRWR3?=
 =?utf-8?B?eWVtejdkK1ZsTmNuMFAraXZTR29Xemord0NyWnRIeXZGQkdybno3aUg5K24y?=
 =?utf-8?B?RkZOdElaQ2h1V1ZidCtTd04veXJQelo2OXBjams3NDhQSzVOamtMdTVxWXl6?=
 =?utf-8?B?ZWo5VVRYTWcwNlZKRndKSWJ2cHlVL0NmWXI3OWhGOHlzaHhqZUZ3RndrSG9y?=
 =?utf-8?B?ekNlRVRGbEc3Z0pXQXkvT0FZMWVSSTdhdktNaldjQUZucUlQdm1wd09mc2Rv?=
 =?utf-8?B?V2VGdFkyUllVTUI2WUY0TkFoaUJPSTRpZXpwYWx6MHhzcTRZTjBPRTlkUzRK?=
 =?utf-8?B?cWRzWEtkWG9PbjR5bmYwNzc1MnVtVkJNQUpSSHptRXlXVHh2RWJiVlNEUi9a?=
 =?utf-8?B?aW1BWEV2bG8ycWc2K1U0UzlLT3ArUnY3dHI0TmhXajNKanlFWXJlM2twN1lw?=
 =?utf-8?B?WXE2SFp3cnNQU1VkZU5xZldvbEhBcGJ1dytaSEtwR1lGdWo5SktBMHlKclJ0?=
 =?utf-8?B?Rmx1eDdLUXJmRWxDNGpCNUlUT0dVZllZaWllTmxyVzF1WXh3ZFh6RHQ5NFZk?=
 =?utf-8?B?NmgyR0NSV25LamlxTEpWbjEvNjR1SzAwZldEc2M1akpja21lODlWRjU5cnBH?=
 =?utf-8?B?dHp2ZjZHcXFSaTROTFlzSDVLdkRxVWk4Vk1hanJ0N01xOGdJbkJWNTJtVTMy?=
 =?utf-8?B?aTY0by9zcmlTazVRWEFGU2JySVV6ZnBMMDUrQnJ6RCtyZWJBVTE4YWNEcWdH?=
 =?utf-8?B?ZmhuR0VFVTc1WTNLZ1BpbnBsem9PYmdBZGNTS2ZES1VEb1Z5RmhrcGY2d3Vv?=
 =?utf-8?B?WXBudFZESWtsYjhpRWdKMkZkazZuV2c5OXRzbDNBOVU1QXRpL1R0V3RHeUZh?=
 =?utf-8?B?VGhjUmVjR291NE04WjNwVE9sN2t5VjJJbzJMcXdsdDV1T3VWL3NLaWF0Snk5?=
 =?utf-8?B?b1RoNmk0UVV6ZGlZM0RKV1B1UDd0bkgwOGUvN2hKTmx4ZEFVclRBMzNaQ2xp?=
 =?utf-8?B?WG1vZW1oUU5XQjRpZ0lWN3NVN2c0aXNSSnJVMGN2RGtGOVJSMG9zdnBNbFpk?=
 =?utf-8?B?dU1MTkVwR2puWW5kUFM1Y3JOZGJYZ2FCSEVMaVR0M3cxc01yUS9GWjIxS0Vr?=
 =?utf-8?B?SWNZdW1kZC81eHFNQWtWd1ZMRXZsLzVpejlKaFMzNTNQYXp1RjJnM0lZL3lW?=
 =?utf-8?B?U0pqckptWmVXYkl5WHE5NU9XbWdWYkxZeEtuTENHN0dyVkR5UmtFd1M1OTA1?=
 =?utf-8?B?UVpUUVlMZXA4UTBRY0JoVjZoQ1Y4Y2RVdDF1eW93WnUvbXRjT2RRWTRGNXV0?=
 =?utf-8?Q?b4/j+q+nV35hrcCpJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6015a51-3242-4bd9-8c87-08de96f758b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:50:22.4617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9IQB0XCVBIi2otmqqHGIkrjfrsw7kjQpvYzoVDZ60mWu2iidQSEzjY0cAmzd/ag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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

On 4/10/26 10:32, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 8, 2026 4:27 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
>>
>> On 4/8/26 09:45, Prike Liang wrote:
>>> amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
>>> drivers and stores them in waitq->fence_drv_xa. When a new userq fence
>>> is created, those references are transferred into
>>> userq_fence->fence_drv_array so they can be released when the fence completes.
>>>
>>> However, those inherited references are currently only dropped from
>>> amdgpu_userq_fence_driver_process(). If a fence never reaches that
>>> path, such as it is already signaled when created or it is dropped
>>> through an error/cleanup path, amdgpu_userq_fence_free() frees
>>> fence_drv_array without putting the referenced fence drivers.
>>
>> Clear NAK to that as well.
>>
>> An userq fence must be signaled at some point and when that happens the
>> reference fence drivers can be put.
>>
>> What could be is that we have another call to dma_fence_signal() where we forget to
>> do that, but it should *never* be done in amdgpu_userq_fence_free().
> It looks like we’re missing the userq fence-array put on the signaled-fence branch in amdgpu_userq_fence_create().

Ah yes, I see. Good catch.

> If we ensure the fence-array is properly put/balanced earlier in the flow, then amdgpu_userq_fence_put_fence_drv_array() will
>  naturally become a no-op in amdgpu_userq_fence_free(). Meanwhile, keeping the *_put call in free() serves as a final backstop to cover any other overlooked/unbalanced paths.
> 
> If you still prefer that amdgpu_userq_fence_put_fence_drv_array() should not be called from free(), I can remove it and clean this up accordingly and only put it in the *create()

amdgpu_userq_fence_free() is completely removed by my recent DMA-fence independence patches. See them on the mailing list.

I'm currently working on fixing the reset handling and fence allocation. Please write a stand alone patch to fix this issue which we can push before my work lands.

Thanks,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 17
>>> +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 3be80a82788a..bd196599d3d6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -145,13 +145,21 @@ amdgpu_userq_fence_driver_free(struct
>> amdgpu_usermode_queue *userq)
>>>     amdgpu_userq_fence_driver_put(userq->fence_drv);
>>>  }
>>>
>>> +static void
>>> +amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence
>>> +*userq_fence) {
>>> +   unsigned long i;
>>> +   for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>> +           amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>> +   userq_fence->fence_drv_array_count = 0; }
>>> +
>>>  void amdgpu_userq_fence_driver_process(struct
>>> amdgpu_userq_fence_driver *fence_drv)  {
>>>     struct amdgpu_userq_fence *userq_fence, *tmp;
>>>     struct dma_fence *fence;
>>>     unsigned long flags;
>>>     u64 rptr;
>>> -   int i;
>>>
>>>     if (!fence_drv)
>>>             return;
>>> @@ -166,10 +174,7 @@ void amdgpu_userq_fence_driver_process(struct
>> amdgpu_userq_fence_driver *fence_d
>>>                     break;
>>>
>>>             dma_fence_signal(fence);
>>> -
>>> -           for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>> -                   amdgpu_userq_fence_driver_put(userq_fence-
>>> fence_drv_array[i]);
>>> -
>>> +           amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>>             list_del(&userq_fence->link);
>>>             dma_fence_put(fence);
>>>     }
>>> @@ -320,9 +325,9 @@ static void amdgpu_userq_fence_free(struct rcu_head
>> *rcu)
>>>     struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
>>>     struct amdgpu_userq_fence_driver *fence_drv =
>>> userq_fence->fence_drv;
>>>
>>> +   amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>>>     /* Release the fence driver reference */
>>>     amdgpu_userq_fence_driver_put(fence_drv);
>>> -
>>>     kvfree(userq_fence->fence_drv_array);
>>>     kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);  }
> 

