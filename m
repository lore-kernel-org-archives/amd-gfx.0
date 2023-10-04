Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC99E8FDC6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 03:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44CF10E0B8;
	Wed,  4 Oct 2023 03:39:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1545610E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 03:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGmBHlVW9uu3vr3shY+tv1l6gm+5Yee9KRlhhnZTlcbkKRLcJ7yWGMh1QZfG6NrO6Vd+0j1Nd/TIrVFivtypfEwtDTwU2r+0RmDnqoYgx0CYAm3jXjY9AGiabe5OKTWRYV2uj0/jte0bqB7bNuhka8nkPB+9YI4hzrDYeiFMeVcUfC+hMpRewv+aQEY7qHpiHo2TDkp3TFpyH1yG8SFWcc8VB691M+94G8780OAok+NUIc8KUGiHDzY9tKVKgsCQQzRBqScw6brc+dEjvjqbq4xi6lBk6E4/U1/YZVLB1MNvBX3Qg5vyfa6iPG93MgUXcdKlM3LMIoHTuzYk1L+UpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlxPWbBTb+HlfJfSBWVH904jFYvvntJNHwmb0oLstJs=;
 b=SrWH7DODn+9DU+Zk822tGKX5jJpwoF+TxkjoqDCmlvPi48vMAj/K/sVM2485DjQD2dcy/z1lyTfuhmek+CNkiZp8X32wOYzGHBRpiojRSPvdp7qz0ssr7MvSQnihXCDdV7NZsXcRAWvddKhmHKszkAUud32qMvUwVhLZlVCNwUFz1k/UCZnYiaJgymr1JRz5pyPsIrOcMjHU+a9bYvhgtB4aS6qo4Yf0JVSehZ5eoxjYvba2YQDYyAt7mVtEs45/efNAJrs3QlDh/Da0WTAt/Wu45AQu57C4871Ok/odzUVLQTCuS0FD8pynnMN8hyWZlTW0USB4qRSM1tonmQMwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlxPWbBTb+HlfJfSBWVH904jFYvvntJNHwmb0oLstJs=;
 b=1Q/Na4Rc50w/QuPx3SKX9QqFgokjNn+/dXmQdvVOvzvTvVzTgksnRGHZe0AOWYdVrxzSi2Ow4dpwGAsgy48zz09pITKaNTxYsDv3/Y5igC68QwM5vzAtSFjX87akoRwCYTLYDct0uQWgPEiHkrYcNK7lT2tv2cRzLXT/sooH1as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 03:39:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 03:39:29 +0000
Message-ID: <40f4b67e-a482-4dae-9af8-a365d3198157@amd.com>
Date: Tue, 3 Oct 2023 22:39:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
 <20231003205437.123426-2-mario.limonciello@amd.com>
 <BL1PR12MB51447D279FB7F5AA88D328D2F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <3683532b-0dd8-4f0d-b1a6-a0a209bc295f@amd.com>
 <BL1PR12MB5144BAB16898B3A5644B3676F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB5144BAB16898B3A5644B3676F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:5:333::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5044c598-242c-4ed5-cf71-08dbc48b839a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nR6Emh8SGFl0I8Rne0bDPEXsH43iGQAtbpsQ908oEfkAyuwLouPmGtqzVL6lzuVT27DfarqALOHogA4vIB++80OmjWotMqD/1LcG4/NCv12ryy0pMrFnzkWkhgEWHoIACh1o/bYfStgg0ReB90+cn0ALSga0+MqoxhxpS2qUWevBRv0QP7uiUp6DinPoY9GwgN3enFswA3PHkNF9Ed3XIflTg5D3UxL5or6jX6/1DTtQ+apsRrcv6UUXOLxF27UG0KaZ3VlwrxdmIocBUIgTJYicpf3ujBLXzgE6nqn3kAQpg4WLMejD5trEiCvI2qWu7rxxILb8jcoYAjGcyBoIvws99ouRMW9fjgwT/Lfm/3pd/5WAZ9/TgFMCyFh/2dqCzoQsilljbB3zvXBEypbHws0ijQksFJi0TgDgP6wmSwerIBSgmQe11Q5oT2JqnhZrRl/1YEWi5fDWzozEmd2/S7ogld0Oa4qs07+iqa7NmCOoqXD6a99zEm34tJ/ccgUZ/fFeK3XEyzLLqLr4MYLQZtBppF1sCk5bWGXoy9iNe2JhqjyrX8edabJRPZ3fHx4Nhg5lPv65Hmm/TBLlLTJttXVOGZojC3OltMj+Q5EOx66r4kXaCFEO+uGD2f2fGivyAYMeZt9w6DPIdICPOsb9/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(26005)(38100700002)(86362001)(36756003)(31696002)(316002)(83380400001)(4326008)(8936002)(5660300002)(44832011)(8676002)(66556008)(41300700001)(66476007)(110136005)(66946007)(2906002)(6666004)(6506007)(53546011)(31686004)(6512007)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cSs2M2x1dm1aRkVndi9uem53bWxQR1RSbWg3YzE0WHdZdmRJV3ZpbmRuVFIz?=
 =?utf-8?B?Nmp6WW15bVRkZTNLY1U1SHFtN0p0Q1JIdHdHN2lXRzFhL3JrMUczNGVPVStv?=
 =?utf-8?B?cGNLWmtIUUZuekJXTTMxYzF4bWNZU1pKNllwQ2dXZ3lvcjFxR005MWpoMzAr?=
 =?utf-8?B?NSt4bFA0bWtmSTJDMyt3dnM3L0V2aVVGdXM0QkpnNTQ1dlQ1K1VrOWp4T0hU?=
 =?utf-8?B?U3Yya2VocXpvaUQ1dVh3VHlPc2tPMkZ2cXJNT2I5TDIyYWN2eWNFQkRML3BD?=
 =?utf-8?B?NjhuS2M4NnRNc3lzS3ZiTUVIYzBqMmgvVzc5cHc5UGl2akdrNFB1d3RqcnFz?=
 =?utf-8?B?bXVZUDVWS0MyUW92b3BSWi96MkhIaTJ3YWVJZEo3VVNmWVZFWlhEMG5aeVZJ?=
 =?utf-8?B?WkUyTzZ4dzUwMkYrVkpPdFZkeTVBc21FQU9jb2Q1ZUlpUFBlTlYzVmlSUEhi?=
 =?utf-8?B?SlRHQzA0OWYyNXpNaW84WmthWGhzVHYwOE15NlA1WEtRY2NtaWRxZzVTQnQw?=
 =?utf-8?B?ZWMrSFBhWVUxd2NIMU1JK2hJMUNkYUhkV3JSZGZWK2Vic1ZaVGRuWktIb1h1?=
 =?utf-8?B?ajF2ZGZFc0lWQ2VEa1FHVzZRZC91ckpCMWdBTGdRbUVML2x2Yi9mZmRXSG1w?=
 =?utf-8?B?bmNwZUw2bGorbEk0ZFVDWjU3T1Z5S3BON2RQQUNTVURhNkdnWk93RnBuYmFM?=
 =?utf-8?B?RVNCaEt2bFhyQlpmb1pRM1ZWcWI2b202UGFxNTU1dFFqWXFMbmoyQk1GbEl0?=
 =?utf-8?B?YnlPbEpLVFlscktDd0hVYmI3Z0M0Nm5wR0RZY1c4b25OcHNhZ2lmMFdKTkhY?=
 =?utf-8?B?VFZsMFJNcVJvSXRjNURRbDZsaVl2VVg1TExvaXJlWTMxWUdhUk00Z09XMVFN?=
 =?utf-8?B?R2gzNlIxdFdhK0VBSFJ4aUdHTlpKclhHc1RHdnZ2ZzVycW5yaVB4TmQ5c0t2?=
 =?utf-8?B?cTVoUWo5VWswaVgrc0ZmZlAvM25Gb2N3dW43ZFRER1NrUzBBeXpsb3hXazVL?=
 =?utf-8?B?R2FzRStMRDd0NXFwUnk2aVlSYnFiREoyUXJjUW1WbTAyeWppanh3NVNGK3l0?=
 =?utf-8?B?b2h5YlhYS3R3NnJnaEtPY2poK2ZRaVZuZE9FYllkSThjUWdGeEJaMmNPMHE5?=
 =?utf-8?B?WVFhVUhnRDRVTnFZRC9GUVErb2poZG1LK1B1YzVNdHZLanU3N05zWWFTS0FG?=
 =?utf-8?B?WHV3d0YvTzFIYXVQeS9pWmpWbnVCclFOU0NPTHlQL0o0cHB5UnZRM1A3MVFa?=
 =?utf-8?B?UzBSWXNKUVh2WWREQjlpREFUR1p1cWtMbDdwbUEvOU9qbWxXcys3SGtSZ3d3?=
 =?utf-8?B?bUxDcUdZOUNXZ3BhZUpWMEplQlQycW9LR2dRMnF1OGQyeUZCWDhxaVJ5ckhv?=
 =?utf-8?B?WE9mNkJtVU5VZTZBR3ZaU2VYcGhHYStGUE5UTG9NMndWZm02cVNKS0RVR25C?=
 =?utf-8?B?TEp0NzZPNkhNT0lzRzZ1RjhmS0dTMjRBandsVHZGbWhiZDBadmhhaUJJZGE1?=
 =?utf-8?B?NFJ2MUNEL2M1TDc5bmV3VmxQR210ZmhZN1FTTjNseHEwbDFSbTRKd3dxZWR2?=
 =?utf-8?B?MExVaEp1MTVzZ0NPc2tWUEFlTzdYL1liRkVOS01RdVZzWllETVNSNmd1QUpm?=
 =?utf-8?B?SWlNTjVtb0ltQ3ZyUEVwTjdQbHN0ZFlqekZWQURwd29KRkZCRFdoMENMSCtL?=
 =?utf-8?B?Qnc4VTdYa0ZWWS9OQnB2N2ttVDR3NjdQclBneS9wOGdrbEp0SG9nTjBZUE90?=
 =?utf-8?B?M1JMbWRlMVUvOEYwd01sQ1podXhENTlUOWJseDRwbHBTR0pPRngrMlR2d1RW?=
 =?utf-8?B?cXAwT2xsK0lZNSthc2o1R2lCUVJrUU05amk4SnROeEtUVWZLeGZPclFBNWFq?=
 =?utf-8?B?b2FVWGZmbHRXcXhqbGUvenF6SkNPVktKdUlNSXR6dE5sWlFVTnBzeVpRRHRv?=
 =?utf-8?B?OUprMGFic0h2Qk1LQ2I5MnI5aTd3OHJuL2JPcFdsS0FTQ1VmZUdldzBmenZT?=
 =?utf-8?B?NWVKMmI4em81ejIyc3hvODQ0REpBblZFOUpKV3QvVno3YUNUMzE5UFpEWGdu?=
 =?utf-8?B?cUVXWDdBOEJMNkRWMmdRR0FLaktjaG04eWVSZGhpTGsxMnA2UHYydXlydzZS?=
 =?utf-8?Q?/+JTFcQAaEkH1N5duCo3FP8xa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5044c598-242c-4ed5-cf71-08dbc48b839a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 03:39:29.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6Qq7pKyvfYpzX0h4x9Ky4Xd+GI6174qqklCzBeZ62TejjiDKCUT976ruDgIlVMWF4rP5GgFLvgCjE3k0XAvDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
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

On 10/3/2023 16:22, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Tuesday, October 3, 2023 5:17 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Wentland, Harry <Harry.Wentland@amd.com>
>> Subject: Re: [PATCH v3 1/4] drm/amd: Add support for prepare() and
>> complete() callbacks
>>
>> On 10/3/2023 16:11, Deucher, Alexander wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Mario Limonciello
>>>> Sent: Tuesday, October 3, 2023 4:55 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
>>>> <Mario.Limonciello@amd.com>
>>>> Subject: [PATCH v3 1/4] drm/amd: Add support for prepare() and
>>>> complete() callbacks
>>>>
>>>> Linux PM core has a prepare() callback run before suspend and
>>>> complete() callback ran after resume() for devices to use.  Add
>>>> plumbing to bring
>>>> prepare() to amdgpu.
>>>>
>>>> The idea with the new vfuncs for amdgpu is that all IP blocks that
>>>> memory allocations during suspend should do the allocation from this
>>>> call instead of the suspend() callback.
>>>>
>>>> By moving the allocations to prepare() the system suspend will be
>>>> failed before any IP block has done any suspend code.
>>>>
>>>> If the suspend fails, then do any cleanups in the complete() callback.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
>>>> ++++++++++++++++++++--
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++---
>>>>    3 files changed, 46 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 73e825d20259..5d651552822c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1415,6 +1415,8 @@ void amdgpu_driver_postclose_kms(struct
>>>> drm_device *dev,  void amdgpu_driver_release_kms(struct drm_device
>>>> *dev);
>>>>
>>>>    int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>>>> +int amdgpu_device_prepare(struct drm_device *dev); void
>>>> +amdgpu_device_complete(struct drm_device *dev);
>>>>    int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);  int
>>>> amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>>>>    u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc); diff
>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index bad2b5577e96..f53cf675c3ce 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4259,6 +4259,43 @@ static int
>>>> amdgpu_device_evict_resources(struct
>>>> amdgpu_device *adev)
>>>>    /*
>>>>     * Suspend & resume.
>>>>     */
>>>> +/**
>>>> + * amdgpu_device_prepare - prepare for device suspend
>>>> + *
>>>> + * @dev: drm dev pointer
>>>> + *
>>>> + * Prepare to put the hw in the suspend state (all asics).
>>>> + * Returns 0 for success or an error on failure.
>>>> + * Called at driver suspend.
>>>> + */
>>>> +int amdgpu_device_prepare(struct drm_device *dev) {
>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +     int r;
>>>> +
>>>> +     if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>> +             return 0;
>>>> +
>>>> +     adev->in_suspend = true;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * amdgpu_device_complete - complete the device after resume
>>>> + *
>>>> + * @dev: drm dev pointer
>>>> + *
>>>> + * Clean up any actions that the prepare step did.
>>>> + * Called after driver resume.
>>>> + */
>>>> +void amdgpu_device_complete(struct drm_device *dev) {
>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +
>>>> +     adev->in_suspend = false;
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_suspend - initiate device suspend
>>>>     *
>>>> @@ -4277,8 +4314,6 @@ int amdgpu_device_suspend(struct drm_device
>>>> *dev, bool fbcon)
>>>>         if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>                 return 0;
>>>>
>>>> -     adev->in_suspend = true;
>>>> -
>>>
>>> We also set this to false in amdgpu_device_resume() so that should be fixed
>> up as well.  But, I'm not sure we want to move this out of
>> amdgpu_device_suspend().  There are places we use
>> amdgpu_device_suspend/resume() outside of pmops that also rely on these
>> being set.  Those places may need to be fixed up if we do.  IIRC, the switcheroo
>> code uses this.
>>
>> The big reason that I moved it from suspend() to prepare() was so that
>> amdgpu_device_evict_resources() was called with the context of it being set.
>>
>> My thought process:
>> 0) prepare() sets all the time
>> 1) If prepare() fails complete() clears it.
>> 2) If prepare() succeeds it remains set for suspend()
>> 3) If suspend() succeeds it gets cleared at resume()
>> 4) If resume() failed for some reason, it's cleared by complete().
>>
>> Does it actually matter that it's set while evicting resources?
> 
> Shouldn't matter for evicting resources.  We even have debugfs nodes you can access to forcibly evict resources at runtime for testing memory pressure.

Then in that case I think what I'll do is put an extra call for 
amdgpu_device_evict_resources() in the prepare callback.

It shouldn't do any harm to call three times in the suspend sequence 
instead of two.

> 
> Alex
> 
>> If so, maybe I'll just have both prepare() and suspend() set it universally and
>> both resume() and complete() clear it universally.
>>
>>
>>>
>>> Alex
>>>
>>>>         /* Evict the majority of BOs before grabbing the full access */
>>>>         r = amdgpu_device_evict_resources(adev);
>>>>         if (r)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index e3471293846f..4c6fb852516a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device
>>>> *dev)
>>>>         /* Return a positive number here so
>>>>          * DPM_FLAG_SMART_SUSPEND works properly
>>>>          */
>>>> -     if (amdgpu_device_supports_boco(drm_dev))
>>>> -             return pm_runtime_suspended(dev);
>>>> +     if (amdgpu_device_supports_boco(drm_dev) &&
>>>> +         pm_runtime_suspended(dev))
>>>> +             return 1;
>>>>
>>>>         /* if we will not support s3 or s2i for the device
>>>>          *  then skip suspend
>>>> @@ -2435,12 +2436,14 @@ static int amdgpu_pmops_prepare(struct
>> device
>>>> *dev)
>>>>             !amdgpu_acpi_is_s3_active(adev))
>>>>                 return 1;
>>>>
>>>> -     return 0;
>>>> +     return amdgpu_device_prepare(drm_dev);
>>>>    }
>>>>
>>>>    static void amdgpu_pmops_complete(struct device *dev)  {
>>>> -     /* nothing to do */
>>>> +     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +
>>>> +     amdgpu_device_complete(drm_dev);
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_suspend(struct device *dev)
>>>> --
>>>> 2.34.1
>>>
> 

