Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF3AC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72DF10E518;
	Tue,  7 Feb 2023 14:36:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A360410E518
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKpR+/hBX/RNBHKOB2whXJQ62knc7uHqoYNHNA6Fa8zQBCrOSZVnz9aRwugmy23roaZqPVx9WF/edHaD9Bye4Y9gzfIaooqh0LjSCuFZzAWM2/EplmAM4LuUoPCbC5pDVqXbgIszzJA+LECxfAmE3ZAw9MEFHvDRDnEhsut1sCyw6MKDezQrY8IH8iV5uvuBbe4HCLAPWpOO+Z+zwzjfLDZy7PuPYKF4i2ynnxJk6k9WRXUI+Qfi9sk6u1trVSsBsI/n9FDfGZVN/Tpdqv30ubofNqF6szpaKhF7GMeCIHrXZRTm9K4kC7e8QIXaaiYNNGBoDi45mCzEJtOI9Lzeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnhYy2j/cRC+BGzwHn6MKpbVPFuSCn5Ds2wdJRooMlA=;
 b=hUY0wU69gW8O/+h8+Lv/kBBLx3oVVTvIbvQ3lbfZtkaOCelmoRzZcIe6u6oOBjzVPRL0jmQKnvePAdewTeTmeyFoZI6fNH6fsk3s5MwctO5g009/a22MOQBXrHYiX1WZWqIzwcyBvGb8ft3gC89DfEANXz5kEB17JvP3t2oW/9Yq3tUWY9YG8cK95V9bWLliWVM4CuUBWQCEGtRRx+rpGOHviAaySd5tFfVel7OODmsGZtZoonhzMMWhD1Wtk3wzmbjWxcSgiluIW2OrtYQr1L4v/2qtBTaBHIUJO+JJ4gizKPgOLgDCcXf9l6EdFYnEf1oXNdmiHHruXRWUY+Itug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnhYy2j/cRC+BGzwHn6MKpbVPFuSCn5Ds2wdJRooMlA=;
 b=N4nEkDPiR1Lr+nn50mAPhl1OWowg2RmHjWMNtILBAn2muGKwWNA6ZtA3/FkhUdQQR8ilL6sBak+Y4aHFemFFCRi3XdgKkN4Ze7bUK3qM/MnzddiY8RanPnu2zG54D/pTjHrVZGlVvbwk8VXFTj3CNp92ftNthNnki3ck53e6l6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 14:36:18 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 14:36:18 +0000
Message-ID: <4826177f-2f4f-3f56-b12e-28537f9d6d79@amd.com>
Date: Tue, 7 Feb 2023 15:36:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
 <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
 <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
 <bb992153-fa99-7b50-a188-e49a8d673439@gmail.com>
 <e5762028-238e-f317-8ba7-9c284d7a80af@amd.com>
 <CADnq5_ORm-=seDMuV8Z=c7K+zPypbvu=huzPmHSe1A44m_cTyQ@mail.gmail.com>
 <7cde3170-49c3-9b15-4289-df754ca4804e@gmail.com>
 <CADnq5_Pw6hjpSce1Oy+Y4O_CQxdmqurNSbTHK6tuhzKPzx=ucA@mail.gmail.com>
 <53e67546-cf9b-860e-d39f-f0258c3a5d31@amd.com>
 <CADnq5_PcO_0ywABh1wxd3mP69pwLRRvb0HR=Y8fT3rmt4vMWvw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PcO_0ywABh1wxd3mP69pwLRRvb0HR=Y8fT3rmt4vMWvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: ea60748c-e883-48cd-1296-08db0918ac79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoHw46xkub5d05QsZlZNNz9OBGi+9Cp2pzokMAgt7Y/2iieMqd+RvdhwF78aO443Ftx6hnpDRWMTLtKP5OzBpkNq5rkSTs/0lUb3Gb7ZA42kdijkfcIKzssjrHSn34RC4fFlyy1fBb9GnnaqrtVyTcyvAg2EzUIDLC4K6/r350BjHKXCQj/P7eEa7wMtl0/zPwFELJcWfqWKC3Y8oZDpWEgXG1Z19z91AaYnp/cNXH+uI/A2RSdScn8bJh0h0hWt6vxlU18tDWXEBE6b2rvSfyI6/jDooy02AvZv+6/F3v/qMTWuTuT6Aoeo20RWHoZKhmw698pIvRed4PAXT/YMbdtDCoAEk6goe6i/qBDe16QTgT+2NwKUHkRW+66qFR86nuICeqP2RaG1RACLnd3bMNlttula1aoh22exawLxWka+NjErKeg1k1s8cRRNn2LMHk+jAcD6GoMegFiY31b5BICc9HaW9/guz3XoUT6Ox43hsO0oLy5OHUuM80DChyWsJR2EnRmvm9I8wo5kxAM7nuZkIM/4YF/A3bT+dTQPfXQQSGsIjAZWpy2fSVLBoSNZoI2C/NxSg0V0aJ1n8Q9LgJOOrmM/2V45WUzLYOkvd0RtvnZrhzv09WVGwcg9LUeCmZpMjJVM+Hzb6PujtbLfvL7gpOsU3dSMl8ymKWVQKsi9kP691PjVQCD92bG15//p0ON1ejGTaGu+3yrD6tByZZCIx1SI9xsHEChiqD40Uxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(6506007)(2906002)(66476007)(38100700002)(66946007)(83380400001)(41300700001)(4326008)(8676002)(6486002)(2616005)(8936002)(5660300002)(66556008)(6666004)(44832011)(478600001)(53546011)(6512007)(6636002)(86362001)(36756003)(110136005)(31696002)(66574015)(316002)(26005)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGFEMS9hdS9JcFhoRVBUMGF2T3luWTRrTDlLQVFxTHJ6b0s1NWxFMWRUQ3Nt?=
 =?utf-8?B?UWdkbDFKZlhVaktnVG5maDA3LysrR1p5WCt4c1JXR1lwb3N5akRVb0lGeURO?=
 =?utf-8?B?QXpseXVoOEFFOHB1bkFFblFyTk5KaDA3R0M5QnlveDRsalEyZUFFVmoxcGk2?=
 =?utf-8?B?NC9ObjlraFN1RXpHS054Qk5yblVFN2lONlY2ZDJKOWNxZ1ZHUlIvc0QyUHhn?=
 =?utf-8?B?UFBzSVE4M1p2OTgzTUM0eUZrVVpFV0F3eUhpSnQ3RGc5MVRLWEdvZUZEOGIx?=
 =?utf-8?B?RFFmWkhvTXEwd1lhN29xd1R4Z3lXWlNSMDYreVZINHZkTFIxaXplc1ZiWExp?=
 =?utf-8?B?dzZxOTZJTGZQek12OVgvYW5Xdkt5THhmREYwQnppQ1lWeGc2Y3FqS2lZL2Ev?=
 =?utf-8?B?RXVEYk81VHk0dkJLZlo4b2ZzVDU5WHVGTENLZXNPVnNpc1A4S0xueXo0ZFhI?=
 =?utf-8?B?NEtmMmh2RTVrc0U3TG1jUmovRzUzZWtQTDVtNEhjdk5zdkJld09OdW1veW12?=
 =?utf-8?B?V1Rnd1M3V2xVbHdBU1N0YjZNdTFEZmJLYUhOOFpDV3ZKY0pRK2hkcjRDOXcz?=
 =?utf-8?B?M2RSdWtjNUd1NjF2eDlPNzN4b1VCbVpOd1gvK0dwSEE5aHhrZGRQWm1mT2I1?=
 =?utf-8?B?SXpmK0QxNGFrU2lORXBwWFMvN3UzVG52N3JMN0NPa25LeHN0YWdUTitWeWln?=
 =?utf-8?B?TzEwOFkyVWpIUEM2TWxWTWR0V1ZhdjVYK21FSytjK3BCaFVKNldrQnhKZ1Bt?=
 =?utf-8?B?b3JHY3JGYzJBdjgrajNlUHNUV1p5RWdrSUxOMWlZYUJ6aEFadVVaM05CckpY?=
 =?utf-8?B?NEVwV2pKQXhoL0hJM3BDbW5EOG5GTy9yT1RxRGhTdEh3cWhHQlJSbVZWS3hI?=
 =?utf-8?B?UURacVE4Q3VBbFk4N2JMbXlGVHpGRk5mNDZpTGdIckVQMXdPOVYrcWswckls?=
 =?utf-8?B?NDRoaHUyUG5xMytLVkxydG1lUXd5SEhRS1BLaUFuR1lBWThPT3NXTTlmZkxG?=
 =?utf-8?B?Qk9yYnZpNG5tUDNnMUQ5T1IrZ3ZZMjAwZ3I4Y2huSExRVjVxN1cxS0hDNHNx?=
 =?utf-8?B?SUwyTDZWWEUxSFVod1ZyblVjeUhUR21wUDAwY29EYTJwazhsNTlzL2lTVzJs?=
 =?utf-8?B?U3pHeEw5eGJ5UTJ1VER0aFBMaUw1bUpjUnJpaFliQkQ1YjdzdzJXUWZDZ2F3?=
 =?utf-8?B?UkU1L2hMbFNXSTliN3lwRTVXR21FTFhTYVM4eEZNY2Rpbm5vQTlSakJUcnZK?=
 =?utf-8?B?QkdIL2lSQXJIczdFQUE3b0p1bHJmUHBLRms3aE5taTU3dXZTZm9JVElkUDNU?=
 =?utf-8?B?Y2piS1VVamQvaHFKdzl1NHg3S0xGTnh4MTB4US9HellSQ2Y1Sjc4RUhBQnU2?=
 =?utf-8?B?VXN3cjV6VnN4a3g3TnVsbWdGMnYxZnZHdVE4aFF6M1Y1S0VPbzdpUENUV0Y0?=
 =?utf-8?B?b2tSTWVrRjMvWUxSck1rNWQrQVNYUmd3VWNHUzN0ZVdsUjYybVRvTEdjdE51?=
 =?utf-8?B?NTMrVC96WkRXV0NuWWxkdjltbXlKejZNREpNSnE2Tnlibm5ZQ1dXYzhjT1RJ?=
 =?utf-8?B?SWFyL1JFZkdHbnhKZ0NkNWdOQ3dpRW5RKzZOY09LaDAwdWMxOWc1RUFxMVA0?=
 =?utf-8?B?ZFdBS3U1OEJaaHBVYmd0VDUwY2VGc0xHbkdiRU84V3p5SkJBVVJFaFlkTWgz?=
 =?utf-8?B?QXBNa2huQlFhUFAxcHJwTTJzTFh6d01GcmNDK0lIZE5EM3ZUVXY5RVhzeGQx?=
 =?utf-8?B?a1Z2Qm9lUHlSME51YUt4bm5ETXZXVHFZOGZYeFJ2S1ZNZFZ3Q2xGelZHQkl3?=
 =?utf-8?B?SkJUUEI5bXNxWTAwNXFheHJQbG4wTklJNndldGdGb0tBSFdnMFE2MmZoWSs2?=
 =?utf-8?B?UFplc3BjUUVqcFRCVy96K2VBTjRLSHJ5TStCb0o0OHlIcnVZMTBXMWxRbHNH?=
 =?utf-8?B?clU2M3ZVZ1h1QXQ5VDczRERpS1JwVmZFeTFVUEFCY3BNV01PRWhkNDZVeFZz?=
 =?utf-8?B?cXg5OUlqVmpLbHZHcHFNVHNhK0Jyb0wvNjM1QVp6ekpTdXFaL2l5d3h5bXlL?=
 =?utf-8?B?T0JWOHVoSENmVnB2NzVMM3NPa2wwcjZOOGJYYyt6cVRqWld4V0c4SzIxN2VW?=
 =?utf-8?Q?R/WiptNY9VlbS/nSYIkfiMk3+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60748c-e883-48cd-1296-08db0918ac79
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:36:18.3037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA5VZwV56v8URxEe+Lh7uPRY3q4aIh/LveTozgsyVDRTAFlt2nZiKc3HQGbHLJdoNvmyog9ozOmOescC9hnPEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 15:20, Alex Deucher wrote:
> On Tue, Feb 7, 2023 at 9:19 AM Christian König <christian.koenig@amd.com> wrote:
>> Am 07.02.23 um 15:17 schrieb Alex Deucher:
>>> On Tue, Feb 7, 2023 at 9:11 AM Christian König
>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> Am 07.02.23 um 15:07 schrieb Alex Deucher:
>>>>> On Tue, Feb 7, 2023 at 2:38 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>>>> On 07/02/2023 08:03, Christian König wrote:
>>>>>>> Am 06.02.23 um 22:03 schrieb Alex Deucher:
>>>>>>>> On Mon, Feb 6, 2023 at 12:01 PM Christian König
>>>>>>>> <christian.koenig@amd.com> wrote:
>>>>>>>>> Am 06.02.23 um 17:56 schrieb Alex Deucher:
>>>>>>>>>> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma
>>>>>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>>>>> Hey Alex,
>>>>>>>>>>>
>>>>>>>>>>> On 03/02/2023 23:07, Alex Deucher wrote:
>>>>>>>>>>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma
>>>>>>>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>>>>>>>>>>>> queue. The userspace app will fill this structure and request
>>>>>>>>>>>>> the graphics driver to add a graphics work queue for it. The
>>>>>>>>>>>>> output of this UAPI is a queue id.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>>>>>>>>>>> submitting work to the queue as soon as the call returns.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>        include/uapi/drm/amdgpu_drm.h | 53
>>>>>>>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>        1 file changed, 53 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>>>> index 4038abe8505a..6c5235d107b3 100644
>>>>>>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>>>>>>>>        #define DRM_AMDGPU_VM                  0x13
>>>>>>>>>>>>>        #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>>>>>>>>>>>        #define DRM_AMDGPU_SCHED               0x15
>>>>>>>>>>>>> +#define DRM_AMDGPU_USERQ               0x16
>>>>>>>>>>>>>
>>>>>>>>>>>>>        #define DRM_IOCTL_AMDGPU_GEM_CREATE
>>>>>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
>>>>>>>>>>>>> drm_amdgpu_gem_create)
>>>>>>>>>>>>>        #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE
>>>>>>>>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>>>>>>>>        #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE +
>>>>>>>>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>>>>>>>>        #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
>>>>>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union
>>>>>>>>>>>>> drm_amdgpu_fence_to_handle)
>>>>>>>>>>>>>        #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE +
>>>>>>>>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>>>>>>>>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE +
>>>>>>>>>>>>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>>>>>>>>>>
>>>>>>>>>>>>>        /**
>>>>>>>>>>>>>         * DOC: memory domains
>>>>>>>>>>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
>>>>>>>>>>>>>               union drm_amdgpu_ctx_out out;
>>>>>>>>>>>>>        };
>>>>>>>>>>>>>
>>>>>>>>>>>>> +/* user queue IOCTL */
>>>>>>>>>>>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>>>>>>>>>>>> +#define AMDGPU_USERQ_OP_FREE   2
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>>>>>>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +struct drm_amdgpu_userq_mqd {
>>>>>>>>>>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>>>>>>>>>>> +       __u32   flags;
>>>>>>>>>>>>> +       /** IP type: AMDGPU_HW_IP_* */
>>>>>>>>>>>>> +       __u32   ip_type;
>>>>>>>>>>>>> +       /** GEM object handle */
>>>>>>>>>>>>> +       __u32   doorbell_handle;
>>>>>>>>>>>>> +       /** Doorbell offset in dwords */
>>>>>>>>>>>>> +       __u32   doorbell_offset;
>>>>>>>>>>>> Since doorbells are 64 bit, maybe this offset should be in qwords.
>>>>>>>>>>> Can you please help to cross check this information ? All the
>>>>>>>>>>> existing
>>>>>>>>>>> kernel doorbell calculations are keeping doorbells size as
>>>>>>>>>>> sizeof(u32)
>>>>>>>>>> Doorbells on pre-vega hardware are 32 bits so that is where that comes
>>>>>>>>>> from, but from vega onward most doorbells are 64 bit.  I think some
>>>>>>>>>> versions of VCN may still use 32 bit doorbells.  Internally in the
>>>>>>>>>> kernel driver we just use two slots for newer hardware, but for the
>>>>>>>>>> UAPI, I think we can just stick with 64 bit slots to avoid confusion.
>>>>>>>>>> Even if an engine only uses a 32 bit one, I don't know that there is
>>>>>>>>>> much value to trying to support variable doorbell sizes.
>>>>>>>>> I think we can stick with using __u32 because this is *not* the size of
>>>>>>>>> the doorbell entries.
>>>>>>>>>
>>>>>>>>> Instead this is the offset into the BO where to find the doorbell for
>>>>>>>>> this queue (which then in turn is 64bits wide).
>>>>>>>>>
>>>>>>>>> Since we will probably never have more than 4GiB doorbells we should be
>>>>>>>>> pretty save to use 32bits here.
>>>>>>>> Yes, the offset would still be 32 bits, but the units would be
>>>>>>>> qwords.  E.g.,
>>>>>>>>
>>>>>>>> +       /** Doorbell offset in qwords */
>>>>>>>> +       __u32   doorbell_offset;
>>>>>>>>
>>>>>>>> That way you couldn't accidently specify an overlapping doorbell.
>>>>>>> Ah, so you only wanted to fix the comment. That was absolutely not
>>>>>>> clear from the discussion.
>>>>>> If I understand this correctly, the offset of the doorbell in the BO is
>>>>>> still is 32-bit, but its width (size in bytes) is 64 bits. Am I getting
>>>>>> that right ?
>>>>> Right.  Each doorbell is 64 bits (8 bytes) so this value would
>>>>> basically be an index into the doorbell bo.  Having it be a 64 bit
>>>>> index rather than a 32 bit index would avoid the possibility of users
>>>>> specifying overlapping doorbells.  E.g.,
>>>>> offset in bytes
>>>>> 0 - doorbell
>>>>> 4 - doorbell
>>>>> Would be incorrect, while
>>>>> offset in bytes
>>>>> 0 - doorbell
>>>>> 8 - doorbell
>>>>> Would be correct.
>>>>>
>>>>> I.e., u64 doorbell_page[512] vs u32 doorbell_page[1024]
>>>> Well I usually prefer just straight byte offsets, but I think the main
>>>> question is what does the underlying hw/fw use?
>>>>
>>>> If that's a dword index we should probably stick with that in the UAPI
>>>> as well. If it's in qword then stick to that, if it's in bytes than use
>>>> that.
>>> The MQD takes a dword offset from the start of the BAR, but the
>>> doorbell is 64 bits wide so we have to be careful that we check for
>>> overlapping doorbells.
>> Well then let's just add an "if (doorbell_idx & 0x1) return -EINVAL;" to
>> the kernel instead.
>>
>> That's far less confusing that having dword in the MQD and qword in the
>> UAPI.
> Yes, agreed.

Got it, Thanks.

- Shashank

>
> Alex
>
>> Christian.
>>
>>> Alex
>>>
>>>> Otherwise we will just confuse people when we convert between the
>>>> different API levels.
>>>>
>>>> Christian.
>>>>
>>>>> Alex
>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> Alex
>>>>>>>>>>
>>>>>>>>>>>>> +       /** GPU virtual address of the queue */
>>>>>>>>>>>>> +       __u64   queue_va;
>>>>>>>>>>>>> +       /** Size of the queue in bytes */
>>>>>>>>>>>>> +       __u64   queue_size;
>>>>>>>>>>>>> +       /** GPU virtual address of the rptr */
>>>>>>>>>>>>> +       __u64   rptr_va;
>>>>>>>>>>>>> +       /** GPU virtual address of the wptr */
>>>>>>>>>>>>> +       __u64   wptr_va;
>>>>>>>>>>>>> +};
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +struct drm_amdgpu_userq_in {
>>>>>>>>>>>>> +       /** AMDGPU_USERQ_OP_* */
>>>>>>>>>>>>> +       __u32   op;
>>>>>>>>>>>>> +       /** Flags */
>>>>>>>>>>>>> +       __u32   flags;
>>>>>>>>>>>>> +       /** Queue handle to associate the queue free call with,
>>>>>>>>>>>>> +        * unused for queue create calls */
>>>>>>>>>>>>> +       __u32   queue_id;
>>>>>>>>>>>>> +       __u32   pad;
>>>>>>>>>>>>> +       /** Queue descriptor */
>>>>>>>>>>>>> +       struct drm_amdgpu_userq_mqd mqd;
>>>>>>>>>>>>> +};
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +struct drm_amdgpu_userq_out {
>>>>>>>>>>>>> +       /** Queue handle */
>>>>>>>>>>>>> +       __u32   q_id;
>>>>>>>>>>>> Maybe this should be queue_id to match the input.
>>>>>>>>>>> Agree.
>>>>>>>>>>>
>>>>>>>>>>> - Shashank
>>>>>>>>>>>
>>>>>>>>>>>> Alex
>>>>>>>>>>>>
>>>>>>>>>>>>> +       /** Flags */
>>>>>>>>>>>>> +       __u32   flags;
>>>>>>>>>>>>> +};
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +union drm_amdgpu_userq {
>>>>>>>>>>>>> +       struct drm_amdgpu_userq_in in;
>>>>>>>>>>>>> +       struct drm_amdgpu_userq_out out;
>>>>>>>>>>>>> +};
>>>>>>>>>>>>> +
>>>>>>>>>>>>>        /* vm ioctl */
>>>>>>>>>>>>>        #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>>>>>>>>>>>        #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>>>>>>>>>>>> --
>>>>>>>>>>>>> 2.34.1
>>>>>>>>>>>>>
