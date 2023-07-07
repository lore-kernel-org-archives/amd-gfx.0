Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78385EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 08:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B241010E539;
	Fri,  7 Jul 2023 08:37:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E3910E532
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 08:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhXymTb0d7L72W3XPxOK9kkJfuUMPOFeUeb2F8p7OSHBtbUYQvUj2Qu03DLqvIzSu0cOwHHxJ4Ejp9p4Ou7csqF+6ia870xmRdCGHtt+m2H7nhGwvGgApKfNqIwvSfHKFxtWLvk8cXtwhNolGSwnKS/wEp/EpDFu0Z+fvGKeoXfbd6PI6l/pZagusjUEmEgheBPfV7RYEn5CKkAQ/7vLNcqKJ4vmZsROT5GqxAlf+snnz9axVmdQtbvp+MnO+M73YMNBfaiIDCkY6BJYh2YPcHrljcMNTzpEKJEIBndWvFNcssPTNhtNWC19F3z3Tsy4I8dabz7be8ztmXxGhjgZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J001O6JdJItO0GfthpfHQGlnKe5JUtYM1R7SH0bV5Og=;
 b=BolvBS8W1APIJb96eAiEIAiAL+4eYg7utjZ+20QESIsLc0CEayMFh2UHIguOfZk1HIYAK+O6EDX+RJXm3Sch2JnytoJK/ra+s2hhhVAQYvVx0wGFXmhbtCwDCRPJRvjVr3utufcGGmIVOIDAAn7NYWGGkWMG0URTP4Fx+cft+YLZ0BSHVk5fkT+fvXzPyCM06dEUjGUwe9kbxgzwOdERhDcgPM+xB8QutOKYrrZ5Z0gIOqQFSUDwlSEYTm5Jy7gHDoY3duQn2IQU43jxm07Vq1Y4ew7f/xiQat/tU4z4FZol86UhwDbHli8JI563T2Kl18GTv7TTcQCFPbq3zEqByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J001O6JdJItO0GfthpfHQGlnKe5JUtYM1R7SH0bV5Og=;
 b=5sfbIxLVn4o5qNXfoXV+8MMZBkA454iv8IHh8sSuvezpxEIvT+fyDIeob5OSEfVuY+UrCLsJ/aZo5E2xpFhLWMr4b8souD+sp4YYUYb0VRptBsUJfLBa7V/mmhGzIUmcNJdfiOzKF3D0E3zBvxO9W2x5XsPp1/cPHVug9b3EEaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 08:37:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 08:37:46 +0000
Message-ID: <06459f04-3030-cf2d-3b77-62bf3dd1f71d@amd.com>
Date: Fri, 7 Jul 2023 10:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <dfd92e84-c51a-82cb-5449-b3bb9c1dd3db@amd.com>
 <21d63938-fb00-35fc-6356-1176c04ccd89@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <21d63938-fb00-35fc-6356-1176c04ccd89@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: cc873390-7e01-4aa6-b5e0-08db7ec57076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVeFmiIgmKVQ6imA3rpxojk/OQkusLisgOxqLOKfA5UbsY272DDcoVSYT4xNH7SZg47RL9PxylaPzfRRr6pnRK1rGLGSUGXBaTB/LXD//Iecu88kQTlx+s4rYtQpRfnwezZPF2cCYcr0rjY6RbUT9wSJ4qRiZIKC+cFtFljdhwpbXUfmm5sLt4r8a8z4H6yo9+WRMpHZcNTBgSsFt4oY9BY0f0kGJDiIPLAHBVYiWgjaDxHQRJnmrQTU09HiJeYM+jX7DoURLXLvU99oo0XIFP5Bea3zk9q+j/BNU9UdCxKueRPP4azWTRdQDmqLTLkTNpUuyjztSqsGgF2IKHC+9HIF7mfux1q5LPUALHd4vdh5KAS8w2Ov9fAyJy6uNz6DW+XjCLmrMRUIrP/6JgPXnjiHTSrBDwsodSsisY82bhq5IgnmlC2OYHwPzZ9YpjR5qBcSVmSjDb3yg8AkHizUYFGW5NGzbnHyOrnD69RGNbomQ/cEtDolkpkJuV01Os0zX7BfA0t1j6s84ZVYo//9BK2J+oFeFDoLhMIhgRXlAXC2XzFyp1YhTic20MfaabPOPYHYPgpmsstcxJiZJGEYXtEUKDQ9emj6I84AEi/0VsGsnSfPPoKN0iIYlbhJb/P5ZVUbyoTyeR89rABjt2s1JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(38100700002)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(66946007)(2906002)(41300700001)(4326008)(66476007)(66556008)(5660300002)(8676002)(8936002)(316002)(86362001)(36756003)(31696002)(66574015)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCsybVBsbHNMRVZzbHVEa3RzeDJtRU1oYTQyVTdlQTQyRVNHYzVZUUVvYzFs?=
 =?utf-8?B?YkQyZXZzajhJanRTZm1YNGNrUHduSkZvQ1BDOXg4R0xCZkZ6TDRNQ1RNdHFx?=
 =?utf-8?B?SUROUkJUNzdBcktFZEZHdm9Ec240d2JpSkFjRjFXcE9oMWp1OFNHeDBLbHZh?=
 =?utf-8?B?YjFnMlQzM05yRFBtMGl5cWVVSmd4QVlYUlEwQ00vQVN0TnlyaUYwVHkyMFM3?=
 =?utf-8?B?b0o5OElPNU1iZUJROWNIYUNTVXBkbkFFN1pxNkQzTmdGZGdvUkZmb1Ewajdt?=
 =?utf-8?B?Sm90RWFmbnBHUEMwanRURGFuaXQ3N0pQb3pTVXg1dTl2RzUzdHJ0S1NnSlJx?=
 =?utf-8?B?NHpDZWJFaFkxbCtBWUhURFhNZ2xhdUx2Rzc4NVBMT2ZidHFtaC9RTGFyaG4x?=
 =?utf-8?B?Ty84MHdOenNkZDIyTzkvS1pmdUdjc1lMby9Gc3VuTldxZE5SOVN6ZHNpZGxW?=
 =?utf-8?B?TVRHNVV6UytVR245MFY1aXVzb0txZDdoaUNyZEdacCs3M0FPMzdZckgzcFRH?=
 =?utf-8?B?dmhTU3pkQldTUmYxWk80MzMvS0dKNHoxUnQ0MnFkYXhZMnlpYnZYUVFyVmV0?=
 =?utf-8?B?Wm5aN2E1TndERnJRaGo5eXJxa0dSdHdkRlhKUGcwQlJzUmV0MDdvcVpHbDhv?=
 =?utf-8?B?d1FWdUJRSnJsTGJFekxjMG1GWUlSWG1FV0ZRaUhoWFJPZUxJT2JSc2FMR3FE?=
 =?utf-8?B?TEJiVVNnaGxiU0JiQnVYUFBBVzhyL052TFRJSk81VEU2VGRqY0FaN0RpdGxB?=
 =?utf-8?B?MnVWcDhqYVg5SElOOWcvMGl2b3liSXBWWStCUFhXRW5pOTlFQlZiZmcrR0xQ?=
 =?utf-8?B?cVVabmFaV3hMR1E1ZHcyV2h1NnMvVnlNUWlQSVJBRmRQN1FMZXJ3T3c5OWsz?=
 =?utf-8?B?MlUvRkcyOXVDWXpRTmZpWnluRVlDTkVndEo3VGovNzNsK1o5WEo4Z2ZxSGZK?=
 =?utf-8?B?UG1US0V0eVZiZnhsOGk0NUc4RmkwVWUyR0dhaDJCdW5rc2EyQ2d5ZTVhSTB1?=
 =?utf-8?B?aG5uMytuNW5HSTNORWlQVW1yMzQ3WW5TNGlWNUVNNEs0K3RCaldIaHN6Qml2?=
 =?utf-8?B?ZXRhUVZrUHdjTUhzMmljYzVnOGJEQzhueXVZSU9TR2lIT0JoUGtBOGRFT0JS?=
 =?utf-8?B?eTVaUUhuU1U4cmlvRllJRzdaZXFjdy9PSUtYTnVHQkV6dGRSaDZuZU95Y2hG?=
 =?utf-8?B?Q1ovcmduYjJWTDJPUzJkNUVINmM4aU5KdjF6dUFlakZhdnI2aXQ5aFk0UTFO?=
 =?utf-8?B?dG9QVjVKZHZxRGhCRWZTb05jcE5aT1VPcTJ1MnBKZ3l1SVVyV1JDc1R4S3RM?=
 =?utf-8?B?c0x1UWVzMXVPLzZQQUt6SGlYanNqWTMxYzNNT25ib01rb1ZTRkVvOFJ3dDRY?=
 =?utf-8?B?K290Z0xFaWlxSUxWOGxXcHZuS3VPWEs2cWsyc0JXOGhOM2QxRUxLeXp5S1dy?=
 =?utf-8?B?b04zQXI1VDgxQXlFTUlEWXRwaGhEc1hVODI4eXdDaGpJT0lSNVhwQzBRZ0VT?=
 =?utf-8?B?Z3NKTzhrbGxFdDFueVJYR1BLNXpxUnVvZVNzWXphVzBBY1N0LzViU1JWcDJi?=
 =?utf-8?B?MWFjTjBNSDFlZG5IQitDREZ0TG9ybmdmVXh6WTlIdHNvcXlxaFVpREFmOC9C?=
 =?utf-8?B?NmdDSzlEMm1tNG9FTDM1RlZKSEQ2bVkvQm9tZTlRbVBTWWVpRlhxdGtKQ012?=
 =?utf-8?B?MWFHYTZjd1RESzR1YitBVVh1MVJWaWdLVmx2cEx2MTNTVy9pd24xYTBYSk5E?=
 =?utf-8?B?dWNoZGYzZDBzdHU3NjdVU0MybDBhcWRRb21kZC8rRjVWMUdXOUh1VHdqNy9k?=
 =?utf-8?B?clZvRlczNW5UMDV1YkRFa1B0Q3pQdUY0eDNHcW8rSFZSUDFYL0dDd2RkbVNC?=
 =?utf-8?B?cEgzYW5CbHF1cnlxMlRKVml2c3lUNDE4YWc3WmI0RG9BeEpic3dqcnhzV3R0?=
 =?utf-8?B?OVVtZW16YmpOamZCT2I0NlhUSnlCbnEyWkVBQlJOWDVsSXkrYmxrdGhIMitq?=
 =?utf-8?B?R0VzNlhlSmo5NWJSazVXZVNSQkVHZ1E4TVhyVGlnVXpaTm9FL1pUUTkxVTJp?=
 =?utf-8?B?SmRoUkl1L1M5aFA4WkZVMCtiWHhwb3lxQ2ZtQW9Zd2txMkpEWFptdHdhMjQw?=
 =?utf-8?B?TFhyUzhCSEtsbWtYbFZaSUI0RnhjeExsSFdUZDBBeUY2N1Uzc01mUlJpSEtR?=
 =?utf-8?Q?KWYH2nn6q+ayjOA7nEoCCH1uX7Si69djmdUq//I+axag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc873390-7e01-4aa6-b5e0-08db7ec57076
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 08:37:46.6147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqb2dQbmT6OOPFbulwnhzXg+xLeb5IceE5ifyZ6diMO9WSYkK1OMy0D7/DzoIvM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.07.23 um 09:46 schrieb Shashank Sharma:
>
> On 07/07/2023 09:24, Christian König wrote:
>>
>>
>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>> the hw's context. As MQD format can vary between different
>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>
>>> This patch:
>>> - Introduces MQD handler functions for the usermode queues.
>>> - Adds new functions to create and destroy userqueue MQD for
>>>    GFX-GEN-11 IP
>>>
>>> V1: Worked on review comments from Alex:
>>>      - Make MQD functions GEN and IP specific
>>>
>>> V2: Worked on review comments from Alex:
>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>      - Formatting and arrangement of code
>>>
>>> V3:
>>>      - Integration with doorbell manager
>>>
>>> V4: Review comments addressed:
>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>      - Align name of structure members (Luben)
>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>        message (Luben)
>>> V5:
>>>     - No need to reserve the bo for MQD (Christian).
>>>     - Some more changes to support IP specific MQD creation.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>> +++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>   3 files changed, 96 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index e37b5da5a0d0..bb774144c372 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>>> void *data,
>>>       return r;
>>>   }
>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>> +
>>> +static void
>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +    int maj;
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>> +
>>> +    /* We support usermode queue only for GFX V11 as of now */
>>> +    maj = IP_VERSION_MAJ(version);
>>> +    if (maj == 11)
>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>> +}
>>> +
>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>> struct amdgpu_device *adev)
>>>   {
>>>       mutex_init(&userq_mgr->userq_mutex);
>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>       userq_mgr->adev = adev;
>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index c4940b6ea1c4..e76e1b86b434 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -30,6 +30,7 @@
>>>   #include "amdgpu_psp.h"
>>>   #include "amdgpu_smu.h"
>>>   #include "amdgpu_atomfirmware.h"
>>> +#include "amdgpu_userqueue.h"
>>>   #include "imu_v11_0.h"
>>>   #include "soc21.h"
>>>   #include "nvd.h"
>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>> gfx_v11_0_ip_block =
>>>       .rev = 0,
>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>   };
>>> +
>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>> +                      struct drm_amdgpu_userq_in *args_in,
>>> +                      struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>> +    struct amdgpu_mqd_prop userq_props;
>>> +    int r;
>>> +
>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>> +
>>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>>> init function */
>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>> +
>>> +    if (args_in->mqd_size != sizeof(struct 
>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>> +        DRM_ERROR("MQD size mismatch\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>> args_in->mqd_size)) {
>>> +        DRM_ERROR("Failed to get user MQD\n");
>>> +        return -EFAULT;
>>> +    }
>>
>> Sorry, I've just seen that now. Please don't have a copy_from_user() 
>> in the backend!
>>
>> This is pure front end stuff which we shouldn't do in hw generation 
>> specific code.
>>
> This is a bit difficult to achieve, as you know:
>
> - the whole reason we moved to ptr/size based approach from 
> fix-mqd-structure approach is so that we can support multiple MQD 
> structures using the same UAPI.
>
> - which means that in file amdgpu_userqueue.c layer (say front-end) I 
> do not know what is the right size of MQD, its independent of IP.
>
> - the correct size of MQD can only be known in IP specific functions 
> which are in gfx_v11.c (back end).
>
> - I may be able to achieve it by adding a new fptr get_mqd_size() 
> which can return the right MQD size for me from backend IP function, 
> and then I can move this copy from user to front-end. Does it sound 
> like a good idea to you ?

Just use memdup_user() in the frontend. Allocating structures which are 
copied from userspace on the stack is usually a bad idea as well.

Then pass in the kernel ptr and size as argument here and validate if 
what userspace gave us is correct.

Regards,
Christian.

>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>> +
>>> +    /* Create BO for actual Userqueue MQD now */
>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>> PAGE_SIZE,
>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>> +                    &queue->mqd.obj,
>>> +                    &queue->mqd.gpu_addr,
>>> +                    &queue->mqd.cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>> +        return -ENOMEM;
>>> +    }
>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>> +
>>> +    /* Initialize the MQD BO with user given values */
>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>> +    userq_props.queue_size = mqd_user.queue_size;
>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>> +    userq_props.use_doorbell = true;
>>> +
>>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, 
>>> &userq_props);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>> +        goto free_mqd;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +free_mqd:
>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>> &queue->mqd.cpu_ptr);
>>> +    return r;
>>> +}
>>> +
>>> +static void
>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>> +
>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>> +}
>>> +
>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>> +};
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 55ed6512a565..240f92796f00 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -29,6 +29,12 @@
>>>     struct amdgpu_mqd_prop;
>>>   +struct amdgpu_userq_obj {
>>> +    void         *cpu_ptr;
>>> +    uint64_t     gpu_addr;
>>> +    struct amdgpu_bo *obj;
>>> +};
>>> +
>>>   struct amdgpu_usermode_queue {
>>>       int            queue_type;
>>>       uint64_t        doorbell_handle;
>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>       struct amdgpu_vm    *vm;
>>> +    struct amdgpu_userq_obj mqd;
>>>   };
>>>     struct amdgpu_userq_funcs {
>>

