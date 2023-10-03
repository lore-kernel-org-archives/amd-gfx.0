Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508D5E8FDB7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 21:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD58F10E31A;
	Tue,  3 Oct 2023 21:16:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF0410E31D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 21:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8y2P86z1jHQyrmeQWZhAao54Wv07po2TRTQgjSPB4AQtRvVEYmEhnajMgoz5xPwYiNVlYJYxqY4YirElGo90wTXvK2DqQTf2GTyQqpui1/bck2wkkQOr2wyGvXd5a3Q8nFur0rQDOnXv4AOsjVA5z+u6OKLzVbfI0iYaBcDmlbLfmPAb1TD6S6DGhqFQZHJMMkl7MZ3YW+Rym8toSQCEMcX+Twrgtp6t9faJaXcVhxu8bQl1wFn6VFh40k07CeiEa7ATLR6EBmbR2fdxUPoaVxJsV5Kvd8iG2mysVHAol67dtezE8QOJKqvsoID/ApcDhBJFUUvuoP+KL7I9toKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FjRnQlVRrBWwgqn2Sk3kk8zvmX4Q0oa2oUwkgemqbk=;
 b=QxEVS+HlQz3CpD9lp0MZI0IIOqGLmXBYkBNJlghNt4z3OQeb+lrSHYNDYb8QKFrtHjda3XgtWWFoKNZ1fO2p7EIspu0NZRmoPkoqd9aVRx3SrepT6IjXsD+J8Q5YKmiYF6HxsP27DxP3sODDPU6alp6ABMqTdmHRyT+gFdk+FHNBwjG/3kUSTquqt5J2aq3Vbc7zphx6ZmrqSyz6sSf+bzHZqMY/RDMty5V44NLj27px3tKBfcaaeC/05VjCF6U1cDLVBAuTP8/zln2CAxv955lhgpnZCC9kM7+d1HFLRO4qHoTA5i0fFQtRSAWD7edrgWoxFmqsHNE4DDJVAV98hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FjRnQlVRrBWwgqn2Sk3kk8zvmX4Q0oa2oUwkgemqbk=;
 b=jVJt5nkQGvE4I6DEKKkBBzw8HsvS1I9whbb/kZLMM0muRyYW8dgVKM+PPQQ2q6YlTT/wChRcgaqW+RdenyuW1sg8VfAnrDNJ+MF/hRu3mXGKVmhvMA7wKJWPrR6A9nAbT7bq4jG9OU6p+ys3HmUvALsqpk1mtBg6zY8Ii3pia/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 21:16:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 21:16:35 +0000
Message-ID: <3683532b-0dd8-4f0d-b1a6-a0a209bc295f@amd.com>
Date: Tue, 3 Oct 2023 16:16:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
 <20231003205437.123426-2-mario.limonciello@amd.com>
 <BL1PR12MB51447D279FB7F5AA88D328D2F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB51447D279FB7F5AA88D328D2F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:806:6e::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb88716-0442-4962-c827-08dbc4560626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IeA+cECpzBMPDwNrABILB2VYY2EZ2KBpt5F8o9ozbQQdJt1mjwX4xQLco55g0q5pTQ3Fd1EP3y0+fC9O2kmI7NwgIL/9fi1RyhXiYMwCeX5vICM26GjgQMbZSWxy8UtY7WwOfJiGUpZkN30SiCac5Ghg2TbJMW/S2C37HxW6Kda8GOkJOVs0uYb8UjRSpTXO6Lbf9xSfJZLY88wZpEbOrLVqerkBlOyUbxKd16Bw0YEJgnITiUCAbnTVIDNtW5TDIkP8VqmEwiKtssoEeqKl3dx7F9Zk3od3AKEFSF7xoXCAo2Rd79uMNi6A3RYXqnxmKKqKYrr+3MX0toC83zkFsAmIEZ1BoZHjuGrzUeL1eD3KW9YTIKoS0Mcdgjgoa1SBE/hmI1avGd07hgy0Q5oq9ufNuPId6H2qtky4MT/19q93ilwPZpU5GRGTeRfyoJiN9k6e6jiT+SVs1fbx22fcKDaGq4q4axDcpHeuoPyFpupXk2lN2uKcfWErsiLXYwlkgW2gw6h3oxZrGfHKz3ntKDIT10SMJQ/BUvg5R4Y5KF/Zhva6JIVUR2ZRYvHtZLfFto3ocCQwjS4C594MvPq/h3H0gwdyoEt20Nd+DyuCfL+4uz3LkKiGZD9Bg6W9XzzjYfoOwqnosGConGH1tS5cMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(86362001)(5660300002)(66556008)(110136005)(66946007)(2616005)(26005)(6512007)(31686004)(2906002)(6506007)(53546011)(38100700002)(6486002)(478600001)(36756003)(66476007)(8936002)(4326008)(31696002)(44832011)(316002)(41300700001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlYxNjRLaWtBdTdmSmhKeVRpUUtvVS82bGtGUUk2VVhwR1hiZzVvOXovRXdB?=
 =?utf-8?B?OU5iTlFEUTVCS2oyci8xUGlyMkIvbFZUaW5LNXJqbjNDOFcrNFE2MlVHVTlF?=
 =?utf-8?B?YmxkQ0RFY0JneElpQjM4aWhRdnRzejZGbERUUWxmSmlUOEt3ckdPVUVKQWht?=
 =?utf-8?B?dTJqN3FLYXZXK1dqNzhObUxJMm03aU83WDRTMGNoNFBaRm96ZWtoeWlGQ2p4?=
 =?utf-8?B?NFNLVG5URGI4ZmRQc0pUajRZTWRnS1VaT1BLaERpOHhGS0I1SUlFcHI2TjIx?=
 =?utf-8?B?TEUwaDIrQ1FlQ1RGOGpheXhXLzRMVGw3NzlrcHl0TVZrMGFYd0pTakpFbitt?=
 =?utf-8?B?MWpiWTcrZVJxTEswMEVzblQ4OVg2Ui9qUERXL1hwcjNKWG5abTN6ckVXWCs4?=
 =?utf-8?B?VCsvbUd6M0VVdzJQNm4ycnJsektUQ0h2bjVPc2ZnRzMzYThQSjY2eHZFRm9R?=
 =?utf-8?B?R1YzVndIRmVpRElFTE1ZbkMyQzJzV1NTRGo4WTBXdy9Xbk9mWUJUd2tTRWtm?=
 =?utf-8?B?SjRSUGtuNTRtRUwyallxV2dIdmlPb1lPZDF4TFZkRzhWTGgrenJMTlduTXlO?=
 =?utf-8?B?QmorQ200V3N0cEErSVRycC82L0ZzUTVlVWd3ekVVYlRsL0JoYWVTVU1OQlpl?=
 =?utf-8?B?WVR0ajlxQVVGQmlMZ3hhd3I0UDlVTm5UbldaOThqaWo1cVlVaWNadzduTWsz?=
 =?utf-8?B?T3NWb0VzYThzS0VNek5QNk5DMCtiMUx5RWcyTHA5L0d0dURmM0JFWFBXTVBv?=
 =?utf-8?B?ZGxCWDVsOWZNT0lFcTZuazlRQ0dhNXhWdEtGN3p0QnNhaG8yTGlJY29FUWF2?=
 =?utf-8?B?a2xSeXlDaHFPaHNGUWRlaEZOSnBGK1pidFF1QzlKYjJUaDhFQ1kwQUE3UXJy?=
 =?utf-8?B?WUU0VEZnUDcyc0lIWmYrYTUvdElSa2ZsbG5ZMHdQVzZVamVkUEw0dVF0VUho?=
 =?utf-8?B?N3duTUFBMGxtakZ4VStmT2tCWDVUR0tIeXR2SW9UQmtldHovTEwxczdXaHEx?=
 =?utf-8?B?eE8zLzd4UjdEUzByUk5ObUgzV0xYdnVYeHNpQ1MzYXlYZzM0OW9YNWYwUTc5?=
 =?utf-8?B?d2J6U204a1BsejZyTThMcXRLRTU3MlRwenNQMWI3R09xRmNoR0IwekJSV2cw?=
 =?utf-8?B?U0hwTGkvcklaUXhHdDRWQlNjRnhaOVcySGtDdTE2NzQxUDJOaHM5TTB6MjUr?=
 =?utf-8?B?Vjk0RkZUS2p5dm5QUSswWFd6b0NQT3FWc2c3bSt3OU4vNkd0WkZnR2Z6SUtG?=
 =?utf-8?B?RWFrRHlIZDd6TzRqWFd0WlhjNjZHZklxY0huQzIxTmpJUWVrdnJIOGxBU0xT?=
 =?utf-8?B?c1RrSVNSSllqM1hiYkJKYVdzTDJmSmpaQjM0WjRqN2N1dnNiMllMellacitY?=
 =?utf-8?B?VTFyMkdUQklZSll6a3pFTlpxT1R1VUZBVHJKQTdoUXh2K3JUZG5SYlZGQUFO?=
 =?utf-8?B?MlFrMDJEaTZJUFpRVk41WTJka1B1S0w0NVYvSXpFeFdKKzdvK3llRy9oYjVq?=
 =?utf-8?B?YWtLemF3WXJWRDQ3Mm5QTFJGRVpHN0RjT2lpektXeTJCakZPV1piWE0vUVVE?=
 =?utf-8?B?YklVZWt0Z1c3czlLWTRkTVNVMSttMWRBMXd3bDlteE5NY1ZmK1NPbS95ZitD?=
 =?utf-8?B?R2lydU9waWY0d1lnaWxhaUVoQ2hKOEhiSERZQmo4aENwWUxkZXJxdVYwVEMy?=
 =?utf-8?B?OW1kellJd3NoWFdLaGQzTzE2Y1RZVUV2RithUXJPd1hvcDlxZDhtaTkrTmtD?=
 =?utf-8?B?Q0Ira0xWVkJrUjhKQ25hQVlZNDE3bE94YmVybld3RTd0bm1DeUQ0ZlkxQU1R?=
 =?utf-8?B?MHJvNDdvbTlIaFR3NmlDRkx0S3M4MHkzc3JPVGw0c1hUNGkveXMrenp1YS90?=
 =?utf-8?B?WlVMNEtTL2c3MGxnLzVXc05Jb0FLSEdHMzdmeVZJVVYxdGtQNjg3RitueHd6?=
 =?utf-8?B?WWZ0ZGp6WFpCbllIRW1CZGFWbEQ3VDlidEFWYnJzVjFXcFBldHJCOFBQYmlw?=
 =?utf-8?B?aFlkV3Nlcm9vR3BCMnRWUVlvWlc5eHFRbWxyQ0JxOGV4bXE0TkVzZ2UvUUNz?=
 =?utf-8?B?WjFOb2l3YjVIOHpZdFpEY3BoczVkKzFkaFd1TDBEOGZXQTRjSHJaaTZpb0E2?=
 =?utf-8?Q?+rFOIyUg43NxVj8cHoSZJBmB8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb88716-0442-4962-c827-08dbc4560626
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:16:35.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE+xesIMO6yhyHjgxLChNMZKtaPCZpS1GrXFMUTG1Ax3uDaK4IOnToEJhFMIpHf8cErV5IChjQkaq98eUdZfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/3/2023 16:11, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Tuesday, October 3, 2023 4:55 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Subject: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
>> callbacks
>>
>> Linux PM core has a prepare() callback run before suspend and complete()
>> callback ran after resume() for devices to use.  Add plumbing to bring
>> prepare() to amdgpu.
>>
>> The idea with the new vfuncs for amdgpu is that all IP blocks that memory
>> allocations during suspend should do the allocation from this call instead of
>> the suspend() callback.
>>
>> By moving the allocations to prepare() the system suspend will be failed before
>> any IP block has done any suspend code.
>>
>> If the suspend fails, then do any cleanups in the complete() callback.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
>> ++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++---
>>   3 files changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 73e825d20259..5d651552822c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1415,6 +1415,8 @@ void amdgpu_driver_postclose_kms(struct
>> drm_device *dev,  void amdgpu_driver_release_kms(struct drm_device *dev);
>>
>>   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>> +int amdgpu_device_prepare(struct drm_device *dev); void
>> +amdgpu_device_complete(struct drm_device *dev);
>>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);  int
>> amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>>   u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bad2b5577e96..f53cf675c3ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4259,6 +4259,43 @@ static int amdgpu_device_evict_resources(struct
>> amdgpu_device *adev)
>>   /*
>>    * Suspend & resume.
>>    */
>> +/**
>> + * amdgpu_device_prepare - prepare for device suspend
>> + *
>> + * @dev: drm dev pointer
>> + *
>> + * Prepare to put the hw in the suspend state (all asics).
>> + * Returns 0 for success or an error on failure.
>> + * Called at driver suspend.
>> + */
>> +int amdgpu_device_prepare(struct drm_device *dev) {
>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>> +     int r;
>> +
>> +     if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>> +             return 0;
>> +
>> +     adev->in_suspend = true;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * amdgpu_device_complete - complete the device after resume
>> + *
>> + * @dev: drm dev pointer
>> + *
>> + * Clean up any actions that the prepare step did.
>> + * Called after driver resume.
>> + */
>> +void amdgpu_device_complete(struct drm_device *dev) {
>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>> +
>> +     adev->in_suspend = false;
>> +}
>> +
>>   /**
>>    * amdgpu_device_suspend - initiate device suspend
>>    *
>> @@ -4277,8 +4314,6 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool fbcon)
>>        if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>                return 0;
>>
>> -     adev->in_suspend = true;
>> -
> 
> We also set this to false in amdgpu_device_resume() so that should be fixed up as well.  But, I'm not sure we want to move this out of amdgpu_device_suspend().  There are places we use amdgpu_device_suspend/resume() outside of pmops that also rely on these being set.  Those places may need to be fixed up if we do.  IIRC, the switcheroo code uses this.

The big reason that I moved it from suspend() to prepare() was so that 
amdgpu_device_evict_resources() was called with the context of it being set.

My thought process:
0) prepare() sets all the time
1) If prepare() fails complete() clears it.
2) If prepare() succeeds it remains set for suspend()
3) If suspend() succeeds it gets cleared at resume()
4) If resume() failed for some reason, it's cleared by complete().

Does it actually matter that it's set while evicting resources?
If so, maybe I'll just have both prepare() and suspend() set it 
universally and both resume() and complete() clear it universally.


> 
> Alex
> 
>>        /* Evict the majority of BOs before grabbing the full access */
>>        r = amdgpu_device_evict_resources(adev);
>>        if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index e3471293846f..4c6fb852516a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device
>> *dev)
>>        /* Return a positive number here so
>>         * DPM_FLAG_SMART_SUSPEND works properly
>>         */
>> -     if (amdgpu_device_supports_boco(drm_dev))
>> -             return pm_runtime_suspended(dev);
>> +     if (amdgpu_device_supports_boco(drm_dev) &&
>> +         pm_runtime_suspended(dev))
>> +             return 1;
>>
>>        /* if we will not support s3 or s2i for the device
>>         *  then skip suspend
>> @@ -2435,12 +2436,14 @@ static int amdgpu_pmops_prepare(struct device
>> *dev)
>>            !amdgpu_acpi_is_s3_active(adev))
>>                return 1;
>>
>> -     return 0;
>> +     return amdgpu_device_prepare(drm_dev);
>>   }
>>
>>   static void amdgpu_pmops_complete(struct device *dev)  {
>> -     /* nothing to do */
>> +     struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +
>> +     amdgpu_device_complete(drm_dev);
>>   }
>>
>>   static int amdgpu_pmops_suspend(struct device *dev)
>> --
>> 2.34.1
> 

