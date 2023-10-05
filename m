Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EA8E9370C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 13:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A1A10E3FB;
	Thu,  5 Oct 2023 13:44:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F50A10E3FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 13:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKafIkA8hiVR5b/5bM8Q4zQH21nssH7yFI86Iu9SKBXoM8cvaYesnjkwGo+PT7tFS9cGjil1I7GgOHh1Ex96aqID/yTU48ELneW9RxIceGz2rSfYIE/PwMGpJfkccoUFUjCT9LDGNzN8/ipgwe0k1yhtkVGxx4GInQyPzTeKXSjv61RHzjchnRvUrzcM8+cxw1xP0P0IhOumVeUJ2rHK6zVE1YTbpqe8gjZHW2uakPLChd9MF1dDl3M+2Xhx/x6Fsy216Q/nAekuLtRIzJDyqpeJrgIg8TlyRb8rq07FTgWXiuSklHiLt/l2MV+Y68V8GCHM9jzXjF382p2LSume+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+pbcrg4nDERHqKBaZNYb4uvqdrA5xkYPtaP9vi/ku8=;
 b=jSqNnD7nCtxN3xGuDYQM3S96qbMkEViQLddiTydt+/2X96HjDad5+M2htsEFcqpxAlD1xmzRdt52bsCQ1wyvrU/HEJAGbLmVPMlBT1YVQJfaawmwASodKDCRc6BBovayGnSy7D/ar2kCdjj4a7zp1OtMOEBJPaIYUgu/WR1whWsBoGE8CPT0mylkHpuC9Edjia953BzBU/K/iBJDjXTD4DfDjdKP+p7UUoLzFrPpKmDp9tw/ufikiYj2Ea8SYYdqSJaHQhNPSiF0g646xnuCfHVMQoJA+Y2GUuwEHwMCVMTbeI/nsIzl0ketm6E9J3XH1PAsPzVVyIl6dXwMbqrSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+pbcrg4nDERHqKBaZNYb4uvqdrA5xkYPtaP9vi/ku8=;
 b=BqGO4HUiStqkZ1J1Al161S5dKhhwrOGWXITUnX502IbqEnzLr6EOVekJfkkh2FmtvcxCEfL+4K2B+xFcSJo1MUjvfmBMCAoDcjenz9NQmdEUgyKbd19nS2cxOoGXySifmwtQWm+hqrqWBAiALrx8DnjusLDrkx3PYes7dY/iXNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 13:44:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 13:44:33 +0000
Message-ID: <5fac275c-d915-43d3-846c-477cf6be03ab@amd.com>
Date: Thu, 5 Oct 2023 08:44:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
 <20231003205437.123426-2-mario.limonciello@amd.com>
 <BL1PR12MB51447D279FB7F5AA88D328D2F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <3683532b-0dd8-4f0d-b1a6-a0a209bc295f@amd.com>
 <BL1PR12MB5144BAB16898B3A5644B3676F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <40f4b67e-a482-4dae-9af8-a365d3198157@amd.com>
 <4f7f21f3-d5b0-46b6-81f2-36dc354b25cd@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4f7f21f3-d5b0-46b6-81f2-36dc354b25cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:6e::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: a296cb6b-6ea7-4f8c-ee80-08dbc5a934e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSIEbLEFtI1rOL+VrRX4I4guaXSD4FcChkZYqLJhVHqIJTbZV07Z0v+iMSW7xoiU742N6Xi7vZSWvdKFt3JF9uhM9qd/hmk+xQ97AeN4ydTQMS1d/XyserKSBdghiqa/9oTT4C4gvh9C5zOmT/xwYtDRPnNWZh6vhHRbUtKYT2Xqe7ZBlym0/oH7l8J5zV5X4PSMzvmw0a97+fPv0/U+yqvvxig5X3gQtVN5stE29gSN8FKwoxwx5pHaWEPNIwZDtg0IN2IwqfkesN9WkkbEhE0E72Tntrske9T69+4Y76n1e2P+6WmbpFCSFrOMMobw4PbP5FWHZ3nE9u3weoy79TAKhJO9ou1KszyXcKAiEFiKX62YK0bIaWRt3c7YIJNi6tOenrWZTM5Ld4EbZxiE666sB75PfThKjr5ops2LK8Nz1R4k10m2etrzmwguhTaqfQsuTHErz1r9Z4fT4BIzTri28s3ed/RU1dqZdBEAKyEWFZvAMa5EQFZAF0haHpTIa4MqllKXP7wKyzu1vE7z970oCFJ6jha+S426FweU5gpjWQN0oq8m6pzyNEKtqYCktZ2NmX/ZDW6GWHkQCq1p8NG4J4lhyesZabkTC7Hz6R69EWG7JmGiTiNzcsNmgqfkELeVWOvSbtbqBrvZk9vc4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(110136005)(6486002)(2616005)(316002)(6506007)(6512007)(66476007)(41300700001)(66556008)(66946007)(44832011)(8676002)(8936002)(478600001)(4326008)(5660300002)(26005)(66574015)(31686004)(2906002)(53546011)(83380400001)(36756003)(38100700002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJNUkgrVDk2VElNczh5RFpCZDVnMnpPUGFtR1g1em1hYTYyMCtMSnpKaGU2?=
 =?utf-8?B?Y1RqNVRqWTRwTWpZRWJGbEZHUHVmc0p3R1V1cUhLV1VSYnVQdFI5SEt3Q3ZC?=
 =?utf-8?B?QXVZYTJRd3lPOXlOcVdYeHZlRFFrc3lCZkIzWHd5TXk3YjJWeEZubTJMZjNm?=
 =?utf-8?B?a0IyRlBteFJnMHN3Unl5cnkvcmp3T2o2RVluV0RKSnVHNmRRa2E0WW9Rdmc1?=
 =?utf-8?B?bzljNVhqMnBiTzkwMW92aHhMUDE1c1VqR0RocHlZZ3dqYUV4Sko1K0tETUZh?=
 =?utf-8?B?VC9RQjNEb1crZzRPem40QU8ybW1IWndpN2drL2ZpYjNhOTNlTHRxVEthYlR5?=
 =?utf-8?B?bVNjUitaOXpaelh3OVh6L3hPVkZxS2VlSjZzODc4dzF0SzFqRExkUllLME90?=
 =?utf-8?B?RE5nVnE1SDFEOURGbmZXclE2NkFoa0thTjhvclhxcEJYVmlBcnhjcnF0cWRO?=
 =?utf-8?B?djdveCt5MEJOT0dKN3plZUI2Yk13TDA0bEt4Y28rNmRuTzFqcG1BZkQ3Tkxm?=
 =?utf-8?B?ckJVTTk4cmdCQjlMaXNGdHhNemZiLytJMDAyRHNrVndzZVh4cjdpVjkyNDhz?=
 =?utf-8?B?OFZLSExYVk9iYzBUT3hveFpIREpMdEJlb2tSSGhPd1BDVG5DL2toVGdYbWZJ?=
 =?utf-8?B?QnZaZFoyeFFHc0UvVXNaMW1tVmNSK0duQUd6Q3dNNlZ2Z0c0QVNxUkg3bHN4?=
 =?utf-8?B?RmxlT0pzNXFQS2UrL01rTmwyWE5mRkc4aCtoakg1WlRsdFFOQ0ZSWWlsbjU0?=
 =?utf-8?B?NFlSKzAxcjNJdWFGVjA0ZzY4T0VmRmcxdjI1d0ZDbXJTekVpSjNRTXkwVHQw?=
 =?utf-8?B?SEo1cjZDOU9IZ3VaaHQvK2ZyR2x3MmRDc3dqQkFUeENpanhNQUhwOVlyajQ5?=
 =?utf-8?B?Q1lWVzgrNFhHOTJ4RFdxTFZGTWpJYy9ncFN1WWd5bmdPZnpMZlkxZDVXbTgv?=
 =?utf-8?B?amlUcnRYaXlDSUp4TmFWck1MeXFOcmdDTGluV1RUcGRoVDdSa0szRzJhMUUy?=
 =?utf-8?B?Ui9YRUk2eFRNNGk0aVhtNXFqLzJmLzR5UW8yNW1ZV2NwMXJXRy9HRlEra042?=
 =?utf-8?B?RjFVOWRsRWlMZDdzdDI5TmVEOGZyallrdzUyV2Y3Q1VVQStTWGhjL3FBZlZY?=
 =?utf-8?B?MjdiOHhoRldkZjlrdnpXU3kyaEVkdWlQQ3BWZjV1cld1a3M2SG40YVdnclJM?=
 =?utf-8?B?anp6UHlpaW03T1RXMjAvTDRSSFBLUHlhY0JYOVlrUFlydEdwMCs4MnpINHpz?=
 =?utf-8?B?MU9ubzkzT1RpNGhGcW5mMVk1Ymdyb0VUWWZlSjlMcHZXOFFKT0QxdDFzK2RG?=
 =?utf-8?B?ekpvOVJEdDFKbkVIa0tHblowL1IwUE55TXl1Q255VjkrOSt6S29YS2FUNFdp?=
 =?utf-8?B?bEQrZGpLRW11bG1DQUU5dEdJOHYweVgwTUNNenpPYmZLb1dLa29jQURjOXBH?=
 =?utf-8?B?K3BabVZWNVVLMVJUWDdvUTlZaWIzdXp4UlVUZFlic05UOHIrcXNOMVpxaVVP?=
 =?utf-8?B?cjdnWE42OGpOQk5zYmdtTE9URGxhRTBSNGF6ZGxoUitNZ08xcFl4cm41aVBt?=
 =?utf-8?B?dzZ1U0NDK0VOckt2TFdZYktYZ21yU3BQc2l2SzZ6b0puNG5HaVQ0aXlWb1N4?=
 =?utf-8?B?UDAxOUp4cTQ5QURTa2JUd2ZieHFWNU41VnpVTTltbUNCZWlQVzZyS3FSeFcy?=
 =?utf-8?B?MGlsVTVZMy9XMExFcVFXNDZkZzhXVWVzZWhsZkZEWVNrZlY2bzNMSERET083?=
 =?utf-8?B?TW9YdTJ0bUVvVkR3ckczYVY3c2NsRXNWd0J2ZkV4UXZIejUxcS9KeW5EdWRx?=
 =?utf-8?B?S095QlpncEllWlZsOUxjK2hYOVBnVmJBNW9uM0l2TFd3TEpuUEJvdjcrTDBW?=
 =?utf-8?B?TEJ3OGZweW9mQjBhMUtjVXlob2JMUGdnMXhrdzJOVnhJUGxZSDY0a0pYTFVu?=
 =?utf-8?B?RGVqUFUrd3dCVFpJdXFnVHpkMzhWVElDa2hJOVRrRis0YWgvNDBsYlltTkxH?=
 =?utf-8?B?M0dQZXpaR3laeEI5ekdlZTZqR09YTytXV3RmRVg3MU0rdzZySG1JbE9XaG5L?=
 =?utf-8?B?TUpYMEowc21FdnE2WHRRK1FjaUNmSVRFeHl6bDljZzlYYyt1dVhYZzd1alFY?=
 =?utf-8?Q?eWQSZlWqMAaPApy/CKh0b4d1y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a296cb6b-6ea7-4f8c-ee80-08dbc5a934e1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 13:44:33.2259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkWUvQVv6zuDcuppmAb6Ek5LMfKwGAzH0cpln0BuS31gzCam6jWhC4dXGUW5+BqJZ2LALModXEYbQZsAVkf50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
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

On 10/5/2023 07:35, Christian König wrote:
> Am 04.10.23 um 05:39 schrieb Mario Limonciello:
>> On 10/3/2023 16:22, Deucher, Alexander wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Sent: Tuesday, October 3, 2023 5:17 PM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Wentland, Harry <Harry.Wentland@amd.com>
>>>> Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and
>>>> complete() callbacks
>>>>
>>>> On 10/3/2023 16:11, Deucher, Alexander wrote:
>>>>> [Public]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>>> Mario Limonciello
>>>>>> Sent: Tuesday, October 3, 2023 4:55 PM
>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
>>>>>> <Mario.Limonciello@amd.com>
>>>>>> Subject: [PATCH v3 1/4] drm/amd: Add support for prepare() and
>>>>>> complete() callbacks
>>>>>>
>>>>>> Linux PM core has a prepare() callback run before suspend and
>>>>>> complete() callback ran after resume() for devices to use.  Add
>>>>>> plumbing to bring
>>>>>> prepare() to amdgpu.
>>>>>>
>>>>>> The idea with the new vfuncs for amdgpu is that all IP blocks that
>>>>>> memory allocations during suspend should do the allocation from this
>>>>>> call instead of the suspend() callback.
>>>>>>
>>>>>> By moving the allocations to prepare() the system suspend will be
>>>>>> failed before any IP block has done any suspend code.
>>>>>>
>>>>>> If the suspend fails, then do any cleanups in the complete() 
>>>>>> callback.
>>>>>>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
>>>>>> ++++++++++++++++++++--
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++---
>>>>>>    3 files changed, 46 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index 73e825d20259..5d651552822c 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -1415,6 +1415,8 @@ void amdgpu_driver_postclose_kms(struct
>>>>>> drm_device *dev,  void amdgpu_driver_release_kms(struct drm_device
>>>>>> *dev);
>>>>>>
>>>>>>    int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>>>>>> +int amdgpu_device_prepare(struct drm_device *dev); void
>>>>>> +amdgpu_device_complete(struct drm_device *dev);
>>>>>>    int amdgpu_device_suspend(struct drm_device *dev, bool fbcon); int
>>>>>> amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>>>>>>    u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc); diff
>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index bad2b5577e96..f53cf675c3ce 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -4259,6 +4259,43 @@ static int
>>>>>> amdgpu_device_evict_resources(struct
>>>>>> amdgpu_device *adev)
>>>>>>    /*
>>>>>>     * Suspend & resume.
>>>>>>     */
>>>>>> +/**
>>>>>> + * amdgpu_device_prepare - prepare for device suspend
>>>>>> + *
>>>>>> + * @dev: drm dev pointer
>>>>>> + *
>>>>>> + * Prepare to put the hw in the suspend state (all asics).
>>>>>> + * Returns 0 for success or an error on failure.
>>>>>> + * Called at driver suspend.
>>>>>> + */
>>>>>> +int amdgpu_device_prepare(struct drm_device *dev) {
>>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>> +     int r;
>>>>>> +
>>>>>> +     if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     adev->in_suspend = true;
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * amdgpu_device_complete - complete the device after resume
>>>>>> + *
>>>>>> + * @dev: drm dev pointer
>>>>>> + *
>>>>>> + * Clean up any actions that the prepare step did.
>>>>>> + * Called after driver resume.
>>>>>> + */
>>>>>> +void amdgpu_device_complete(struct drm_device *dev) {
>>>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>>>> +
>>>>>> +     adev->in_suspend = false;
>>>>>> +}
>>>>>> +
>>>>>>    /**
>>>>>>     * amdgpu_device_suspend - initiate device suspend
>>>>>>     *
>>>>>> @@ -4277,8 +4314,6 @@ int amdgpu_device_suspend(struct drm_device
>>>>>> *dev, bool fbcon)
>>>>>>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>>>                 return 0;
>>>>>>
>>>>>> -     adev->in_suspend = true;
>>>>>> -
>>>>>
>>>>> We also set this to false in amdgpu_device_resume() so that should 
>>>>> be fixed
>>>> up as well.  But, I'm not sure we want to move this out of
>>>> amdgpu_device_suspend().  There are places we use
>>>> amdgpu_device_suspend/resume() outside of pmops that also rely on these
>>>> being set.  Those places may need to be fixed up if we do. IIRC, the 
>>>> switcheroo
>>>> code uses this.
>>>>
>>>> The big reason that I moved it from suspend() to prepare() was so that
>>>> amdgpu_device_evict_resources() was called with the context of it 
>>>> being set.
>>>>
>>>> My thought process:
>>>> 0) prepare() sets all the time
>>>> 1) If prepare() fails complete() clears it.
>>>> 2) If prepare() succeeds it remains set for suspend()
>>>> 3) If suspend() succeeds it gets cleared at resume()
>>>> 4) If resume() failed for some reason, it's cleared by complete().
>>>>
>>>> Does it actually matter that it's set while evicting resources?
>>>
>>> Shouldn't matter for evicting resources.  We even have debugfs nodes 
>>> you can access to forcibly evict resources at runtime for testing 
>>> memory pressure.
>>
>> Then in that case I think what I'll do is put an extra call for 
>> amdgpu_device_evict_resources() in the prepare callback.
>>
>> It shouldn't do any harm to call three times in the suspend sequence 
>> instead of two.
> 
> Yeah, I think you should move the first call from suspend to prepare.
> 
> Evacuating VRAM doesn't rely at all on the suspend flag, but the second 
> evacuation only works after we turned of the hardware.

In the v4 of the series I've instead added an extra call to evict in 
prepare().  So it's 1x call in prepare() and then 2x call in suspend().

> 
> Regards,
> Christian.
> 
>>
>>>
>>> Alex
>>>
>>>> If so, maybe I'll just have both prepare() and suspend() set it 
>>>> universally and
>>>> both resume() and complete() clear it universally.
>>>>
>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>>         /* Evict the majority of BOs before grabbing the full 
>>>>>> access */
>>>>>>         r = amdgpu_device_evict_resources(adev);
>>>>>>         if (r)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index e3471293846f..4c6fb852516a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device
>>>>>> *dev)
>>>>>>         /* Return a positive number here so
>>>>>>          * DPM_FLAG_SMART_SUSPEND works properly
>>>>>>          */
>>>>>> -     if (amdgpu_device_supports_boco(drm_dev))
>>>>>> -             return pm_runtime_suspended(dev);
>>>>>> +     if (amdgpu_device_supports_boco(drm_dev) &&
>>>>>> +         pm_runtime_suspended(dev))
>>>>>> +             return 1;
>>>>>>
>>>>>>         /* if we will not support s3 or s2i for the device
>>>>>>          *  then skip suspend
>>>>>> @@ -2435,12 +2436,14 @@ static int amdgpu_pmops_prepare(struct
>>>> device
>>>>>> *dev)
>>>>>>             !amdgpu_acpi_is_s3_active(adev))
>>>>>>                 return 1;
>>>>>>
>>>>>> -     return 0;
>>>>>> +     return amdgpu_device_prepare(drm_dev);
>>>>>>    }
>>>>>>
>>>>>>    static void amdgpu_pmops_complete(struct device *dev) {
>>>>>> -     /* nothing to do */
>>>>>> +     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>> +
>>>>>> +     amdgpu_device_complete(drm_dev);
>>>>>>    }
>>>>>>
>>>>>>    static int amdgpu_pmops_suspend(struct device *dev)
>>>>>> -- 
>>>>>> 2.34.1
>>>>>
>>>
>>
> 

