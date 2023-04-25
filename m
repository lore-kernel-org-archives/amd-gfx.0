Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A06C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 17:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0636510E085;
	Tue, 25 Apr 2023 17:02:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CAD10E085
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 17:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQFV8gLEZFdrzAjiNwnSP0hKspYIHkB7WWyKrF8fzD4YascuADzLOBDQSU22Fpuu+cTNnTngpRv1OeCv+/shdU87PaQ/oFdGpOZmCETn9c5C2tw5Qe+6MYlVIleclCurNAQ6aMU/BpB5Yu/QxRANbE1bUZXAxgdXN7zzRTIbvDtwGOJ9nYMHcDfdPZljKcoqA33CWaNwp9ONkiN7YLOnwTWVHHHLTvS+KYTUEi1lLPf0T6hWSxf2eZk6ir+jGqEGU2SyVcxJVdQp3kOCWQNqsFZnAxSCrycCMF6TK36Q3HTf4+WpfQZ+kD3bEnzOD/h+prf0pE+p9qIuZ1y4v1duRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bupuT8AUCYAe+ABroYRJP78hHJpiEP/Lre42eQ4inkQ=;
 b=UGm0g9+G4kC76tloPGfhAlsyXt/9R2bCyrHqB8dCaRorQR7FMG+40vb2qxKruMDD722CZ9MEHjKDxK2engcCZJhcT4BF0W4WAKTFmN+eNF/8IwLWbjZziuLKKVb6ljhWnxeVT6IEv47E6wY03mjyhRo7y2w/auXiSeabMmTthdDDUU7c1XqMgFr1OE+aSsKvkZZ0F8wr/Uz8nA0/fvk8QDEVBFBa3JCPlr/L1L5djvRKVIw1stpjFmuWIQumXrW/QR4B4axGUvz9se16rGjgzJYrxHu4Sa0m3YKX98BEipnmT/LdwcmXkLSXBO7x3aux8TNDsN9vh6vEtYno3g8g0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bupuT8AUCYAe+ABroYRJP78hHJpiEP/Lre42eQ4inkQ=;
 b=u2GW5CM90TsHBwqkIZpN8bNBXGP807P5mzPTR5KpJjAA6Zfy/OsRj1NWoermGO1UoWQDo7E1Uz2Kvyton6dQbWM+o21kNxzvuroP4i45mJmd3fS1HABB8pcm6hZF1aQ3IcV+utQfczCV+PTDZw8IXh3OEOPErqYOJWj9hH4Irfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 17:02:35 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 17:02:35 +0000
Message-ID: <514f467c-e0c2-73a1-9623-6c046f80c859@amd.com>
Date: Tue, 25 Apr 2023 19:02:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-5-shashank.sharma@amd.com>
 <8670d699-dcf9-f8e9-a11d-e87bb40643d4@amd.com>
 <eed1b460-27f2-00a7-8016-fb866628db49@amd.com>
 <8e194e8a-4b71-f16c-e8bf-cfd0b34f7c22@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <8e194e8a-4b71-f16c-e8bf-cfd0b34f7c22@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e24f754-467f-4f06-45fe-08db45aeddac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/pz9rpLl35aSr03ssz5C7TsKoZ+l8jILACHNYgQ9PfpbnFZMAgyAgbh5Cw71KRLMFjrHuxcM4WcKrNW6h+o+kBRTB6+zO3izkS0rziXUulUYUn3lJIhVLcDaOWjFR/OCCar5wTHefT2HQIzF0OPw5ePjNyX5ZOOORnIHhtAN1Qp/q40O1x+G7a0kZKJWFz8qX05xJBiWyzqbqvlJ6vWF6R7tbhft5mFvjzH9S0dvXvtHTUTZql57NlR5OzawyydDF4mm6h9Dxw78GuQ3MMT3AmUSkweQwDdcfpbZP0qGNE47/Xo46hNwReS1P8+3fXNnxhF62w+7874yGseeMIp7kyWwlw/L7mBJlxliIKa122krUGqjaz1fEUYXWtTM7CjvYEG5wWOXQ5OsdMHJogrIWcDAXow9nRxlm2cDLtCma0pdGJQ1ZJfZWkDR9Tg+jK6U5dFYJGENRgWHLUz4xSpwf7PVPUNpcO0XlYC+i6I/ocYev6OlM5Y/NtFf5h29RrGuu7mkzx1Z9TaM3eYjd+9BoccPh2UjhP77ARNxfazj2aaq+1gaSXxEzuAXmI2/W5SuNfBE4cKKxkvZfOZLh6A6z5xpu7ND/qwpnNrgyjZE38uNy4xWyRkCPr1tNIHiDhd1LrMbwGs5BlvJ4BHIW3pvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(2616005)(66574015)(83380400001)(36756003)(31686004)(186003)(6486002)(478600001)(6666004)(66556008)(66476007)(66946007)(41300700001)(8676002)(38100700002)(86362001)(4326008)(316002)(8936002)(2906002)(5660300002)(26005)(6506007)(53546011)(6512007)(44832011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtzMGtqZzdiWUNtdWVIUnhEdTlORVFSUUpoZDFNM1JKL2JLVVFsSFdkb2hX?=
 =?utf-8?B?c3UwN05wOHdFMU12Yk9yRmZCaUtKWEJNUkFvbUIxRzFTT3R3WnFvUVQ2c1pF?=
 =?utf-8?B?S1gzc1ZLc2lQQlNteFliY09TUm5xZHJLYkwyM0xPZmptcUkwUThzdWtvYUx6?=
 =?utf-8?B?WERVbitXQVNwZXhRQ1hrUHp5WjhzSVQ4VFY5NlNwd2dMZHRubHozNmdHL2Rv?=
 =?utf-8?B?RjIvUnJEc1B5QUVpZFc3bUlBUkJkSzhFRVJnZEpUelUxSGVPZ2Y3WHVzQkhQ?=
 =?utf-8?B?OEFaUVp5aE1iM0xRSDA5V0tYazlpUHF3a1ZtRGM5SmZBdUZwYUtpa1krbTFy?=
 =?utf-8?B?WWV0L0ZoWUpDV1dRVTRwaU51WnUwd3JuaWlOOHdZZFFJb0l0dTNBb1JHbGdE?=
 =?utf-8?B?bmU5UVFlcWxxSHVKbDhNSkJzYm15NnA3dFoyZXZQVGR1WlF6RTMrUGR5MTQx?=
 =?utf-8?B?VXVJTnFGR1pvVFdyL2RjbnNEU1pZVUZhcTdaTG5ER3drZG9rK3ltd2ErRXhR?=
 =?utf-8?B?OVkwcjFPZEo0UWFYVkZtU2kyeGdXdmFUbXp2Vy8xR2dNY053V3RNU1hpVlFW?=
 =?utf-8?B?cVFYTjJLWlJXUHdtc25nRFpqeUxxRCtwNFpGODZKbFJzeTVzaGhaMFY1LzM4?=
 =?utf-8?B?SmRIblY3eEZGY2phRmZGaVUrWnlFd0ovUjZWSXVuclVtcS9pRzA5NTRkSVV4?=
 =?utf-8?B?MnRuNFZxNmhvem52eHpGYjdpZHlMemtpQmdORUJaYlFxVlBjZVd2dnQ4bGph?=
 =?utf-8?B?cWhBUVlhbld1b0NHUUNKNTlobHQ3Z2liL2tqaEY3SkZDNlpTQksyV3o1Uy90?=
 =?utf-8?B?YUpCbHpObzJ1cXMrVDhJQVBlbFZKWTFWUUFKekgzZTcycmhHeWZsdWUwWVdh?=
 =?utf-8?B?Zi9PS3VjWWlMNFhFU2ZNWXhXS1hSM0cxcEM1OFY1MXNlMzFUTXcvWjduckJF?=
 =?utf-8?B?YTkvVytqdGsrd2hvUDYzeHBpY0JHRlRHZk5ub3FDQjJYYUhsMjJKRXVEeEhs?=
 =?utf-8?B?WFpKQWVCSmxBSjhneCsyVE5NTDVCK3R5bFkxVmxZbVJqb25vc1A0TWFpQVEz?=
 =?utf-8?B?aTlMSC90OVVzd2VqL0pVNmRZbzFCSGdvRXFjRVRFR3k5NCtzaEJ5UXJ2Q1Jm?=
 =?utf-8?B?dDZ0aGt5RkI0V2FiMEM4RUpGem5GQ2JhSUlhcnNGcG84dTJIWWxUcHNNK0h1?=
 =?utf-8?B?Q3krUVVHSTJEUXRjeEtlTUpvU1ZodUlzbWFTS2Vxem14RzBhbGlKNUdabXJ3?=
 =?utf-8?B?T1phZGNtVG93blk3dWFJLzZSNHZiTm9HcysvVHpaaUo5TU41R3V0TWNoWkJq?=
 =?utf-8?B?RXlFMWx0SzYxZUswUUIxZER6anhEci9KRnFPL2h1VTkvWm9qcTdsVk9SQWgx?=
 =?utf-8?B?TER1L2pidXBJUzNLQlhoK2UrYmpQUlM5Y0NqZXVEMCtQTTdWWko3QWYySWJj?=
 =?utf-8?B?MVA5WmdEcVMzWU5KamwvOXRIWVRQeWExTURHd0lXMGpuOENxbTc5V3Y4N1FD?=
 =?utf-8?B?a1hIMkxHYjNKdkFZVy8zSC9VRFZkN1k2YURPRTg1M05jUjVITE11ZHcvVklQ?=
 =?utf-8?B?bTlyU21MbjhUYWpORHdiQnZmUnRYMTRoWHFZakZ1VXI1cFpqMXhHekRzblNG?=
 =?utf-8?B?dUhTQU9nT0FkVVQ1WVdiY1pRbHE0aUdMQ1Zld1lydk5MM25ISzFYak5tRFZL?=
 =?utf-8?B?NTR2aEVzbDN3TE56clltUjdmbmVrZjluRzRGMmJ3ZmlHNHZuclNwQXV0UEpp?=
 =?utf-8?B?c1BqbVVWMkpyMUFrbXRrZ3VqbDNrcTduNTNrS2tGV2tCNVFySDRtZGdTRFRM?=
 =?utf-8?B?blBoUUNWKzBmUUQ0M0diTHBtZ3NYS1lyWWdKOVAvdldjYkhtYVhqYm9DS0Y5?=
 =?utf-8?B?VGxxY0ZqUmJGemlSNnF0OThCdkJzVDZVODVVbEhMWElkZGNoQlV5UWFWQmxt?=
 =?utf-8?B?WVNwTmpmL2ZLcXVNTkpaUzlkWGFKajZ5cUlXM3NlaFlNS0d4dDVIb291Rytm?=
 =?utf-8?B?by96VjBTVDhHTVhPMndkZ0x0SlN1bFZyRXp4a3hSa0w5Yy9qeWkvZHlNZ3Z5?=
 =?utf-8?B?QWxRTnFmNzRFR3RjRW4xeU1tNVZGOUozSW9HUThTMGZrZjlPR0FmVXQ0dW5a?=
 =?utf-8?Q?RqUIsi76rnzGgaKbyvaU9NZti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e24f754-467f-4f06-45fe-08db45aeddac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 17:02:35.5792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHKDjpAl+x/SZsAckqqetynvuiRzr0xH2dsfFiknVONio9eNt6UomIb777w0qitVgp3QM/b6p/UsY/jyMzBaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 25/04/2023 15:45, Christian König wrote:
> Am 25.04.23 um 15:10 schrieb Shashank Sharma:
>>
>> On 25/04/2023 14:27, Christian König wrote:
>>> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>> the hw's context. As MQD format can vary between different
>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>
>>>> This patch:
>>>> - Introduces MQD handler functions for the usermode queues.
>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>    GFX-GEN-11 IP
>>>>
>>>> V1: Worked on review comments from Alex:
>>>>      - Make MQD functions GEN and IP specific
>>>>
>>>> V2: Worked on review comments from Alex:
>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>      - Formatting and arrangement of code
>>>>
>>>> V3:
>>>>      - Integration with doorbell manager
>>>>
>>>> V4: Review comments addressed:
>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>      - Align name of structure members (Luben)
>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>        message (Luben)
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 
>>>> +++++++++++++++++++
>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>>>>   3 files changed, 89 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index 333f31efbe7b..e95fb35b0cb5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct 
>>>> drm_file *filp, union drm_amdgpu_u
>>>>           goto free_queue;
>>>>       }
>>>>   +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
>>>> +        r = 
>>>> uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>>>> +        if (r) {
>>>> +            DRM_ERROR("Failed to create/map userqueue MQD\n");
>>>> +            goto free_queue;
>>>> +        }
>>>> +    }
>>>> +
>>>>       args->out.queue_id = queue->queue_id;
>>>>       args->out.flags = 0;
>>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>>> @@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct 
>>>> drm_file *filp, int queue_id)
>>>>       }
>>>>         mutex_lock(&uq_mgr->userq_mutex);
>>>> +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
>>>> + uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>>>       kfree(queue);
>>>> @@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>>>> void *data,
>>>>       return r;
>>>>   }
>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>> +
>>>> +static void
>>>> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
>>>> +{
>>>> +    int maj;
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>> +
>>>> +    /* We support usermode queue only for GFX IP as of now */
>>>> +    maj = IP_VERSION_MAJ(version);
>>>> +    if (maj == 11)
>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>>> +}
>>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>> struct amdgpu_device *adev)
>>>>   {
>>>> @@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct 
>>>> amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>       userq_mgr->adev = adev;
>>>>   +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index a56c6e106d00..9f7b14966ac8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -30,6 +30,7 @@
>>>>   #include "amdgpu_psp.h"
>>>>   #include "amdgpu_smu.h"
>>>>   #include "amdgpu_atomfirmware.h"
>>>> +#include "amdgpu_userqueue.h"
>>>>   #include "imu_v11_0.h"
>>>>   #include "soc21.h"
>>>>   #include "nvd.h"
>>>> @@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version 
>>>> gfx_v11_0_ip_block =
>>>>       .rev = 0,
>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>   };
>>>> +
>>>> +static int
>>>> +gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct 
>>>> amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
>>>> +    int size = gfx_v11_mqd->mqd_size;
>>>> +    int r;
>>>> +
>>>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>> +                    &mqd->obj,
>>>> +                    &mqd->gpu_addr,
>>>> +                    &mqd->cpu_ptr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    memset(mqd->cpu_ptr, 0, size);
>>>> +    r = amdgpu_bo_reserve(mqd->obj, false);
>>>> +    if (unlikely(r != 0)) {
>>>> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>>>> +        goto free_mqd;
>>>> +    }
>>>
>>> This reserve/unreserve dance here doesn't seem to make much sense. 
>>> Why do you do that?
>> We wanted to make sure that the MQD buffer is reserved until we fill 
>> it. Does it sound incorrect ?
>
> Yeah, that sounds strongly like we have some misunderstanding.
>
> Reserving a buffer is needed for two thing:
> 1. Prevent that it moves around.
> 2. Change some parameters of the BO.
>
> Since the BO is a pinned kernel BO neither of those two use cases 
> seems to be the case here.
>
> So why do you reserve the BO here?
>
I guess I missed the fact that Kernel BOs are already pinned, so we 
don't need this. I will remove this.

>>>
>>> Christian.
>>>
>>>> +
>>>> +    queue->userq_prop.use_doorbell = true;
>>>> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>>>
>>> Are those the only two parameters needed? If yes we should probably 
>>> drop the userq_prop structure and give them directly.
>> In patch set 1 and 2, everything was getting stored directly in the 
>> queue, but then we decided to re-use the existing init_mqd() 
>> functions from each of the IP engines.
>>
>> If you see the prototype of mqd->init_mqd(), it expects userq_prop 
>> structure as input parameters, so we encapsulated a subset of queue 
>> to this structure.
>
> Yeah, the question is if the init_mqd() interface is a good idea or if 
> we should re-work that as well?

I think is a good idea and we should keep it. This makes sure that the 
same code gets executed with both usermode_queue MQD initialization and 
kernel level/KIQ queue init.

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Christian.
>>>
>>>> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, 
>>>> &queue->userq_prop);
>>>> +    amdgpu_bo_unreserve(mqd->obj);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to init MQD for queue\n");
>>>> +        goto free_mqd;
>>>> +    }
>>>> +
>>>> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>> +    return 0;
>>>> +
>>>> +free_mqd:
>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +static void
>>>> +gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>>>> amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>> +
>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>> +}
>>>> +
>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>> +    .mqd_create = gfx_v11_userq_mqd_create,
>>>> +    .mqd_destroy = gfx_v11_userq_mqd_destroy,
>>>> +};
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> index 8d8f6b3bcda5..e7da27918bd2 100644
>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> @@ -28,6 +28,12 @@
>>>>   #include "amdgpu.h"
>>>>   #define AMDGPU_MAX_USERQ 512
>>>>   +struct amdgpu_userq_ctx_space {
>>>> +    uint64_t     gpu_addr;
>>>> +    void         *cpu_ptr;
>>>> +    struct amdgpu_bo *obj;
>>>> +};
>>>> +
>>>>   struct amdgpu_usermode_queue {
>>>>       int            queue_id;
>>>>       int            queue_type;
>>>> @@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
>>>>       struct amdgpu_mqd_prop    userq_prop;
>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>       struct amdgpu_vm    *vm;
>>>> +    struct amdgpu_userq_ctx_space mqd;
>>>>   };
>>>>     struct amdgpu_userq_funcs {
>>>
>
