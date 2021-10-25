Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAEEC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0680A60FBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0680A60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8D789A61;
	Mon, 25 Oct 2021 15:18:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A7589A61
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 15:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL3M3zQgR9VKJllHGzmlkvfLvEpnyw7ol2AadXqRsQjpUrynoK62wJzIlb5Qd1Ibu2cnLtpPiQ8XyZk9oVXuuXRSKCX40lkVvyDjOXHMElQVTQsEBxEjiav6XySJS1Bd5CXBynaBSdjzYwwuFVR3xfiyOOf4HWEkIEFWJAlPmN171qA2uEg1OtvxtxTbbXVqGCi2ix66EGqvRzmCQ7ZMUFfjefYawy4OtV/+a+5V/49S65HbOY9JB4oy21oN+RUx4ITOFgFPbZHp1lbvAh6HFJfC3uj2eygnwT5eOmJHaoQyrvTbECLWxVZslEeR1GpqUOubba5juJEhKZ+PSVNyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zN+rLRfbK0H0SD9ueMwHWdQIZQyJaN8YiNNXWisZI8=;
 b=PQKZAJqgtK7FRhG+KaJ7EVFw1/MgAesylJEE8knewBI4FT0PObWNydn5N3vlLxqJYmGkgT+zdRGvjPOcYKfbF0PsWb9CwTPRIPh/zcDzAGj2Et/pQV8mGN47Aau3GDksPIqxEJ0umZbQG0XJiYLbCfVKatZtIQTcndCxcSGlWThaSMtOMnOjo7gMDBdLzcb2QXWw5cZLifI8KgsXIS66QKggLgxJtU9Hr0dF0r5kgVuhPH3j8auxmEGMa2a2fJ+5zBbfbeWQCFkZDZ+jf7dUKyUusKu9QPwYhf9lfBvPKWVo5/n7zWgQR0L/XCuITRwYjYX0soWDi8hUL05ClLhYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zN+rLRfbK0H0SD9ueMwHWdQIZQyJaN8YiNNXWisZI8=;
 b=iVDJZ+q3yQ/LKGIYRtIcOTctkFiXPGqny4RIC//m5N1FXoZ1T2voHrcSc7z+alaa4SIWZ7oJtNhHAWMkxOHhIZyKakZSUJFQhvGkEUVAIihKnhWBF08QKiWL/KWeL/wZXsQmJ5OqtOlR0Osrft0X+WfF9dpwwu4TUdDTNPwqhwU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 15:18:24 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4628.018; Mon, 25 Oct
 2021 15:18:24 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: jingwen.chen2@amd.com, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
 <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
 <a96a2691-4e8b-8eb3-1566-f15301043adb@amd.com>
 <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <fe55f902-1473-dc8d-3011-808fc93c7e5c@amd.com>
Date: Mon, 25 Oct 2021 11:18:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f2b72ae4-93ca-61c5-68cb-19b7fca4c063@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:32ba:a748:360f:6dc8]
 (2607:fea8:3edf:49b0:32ba:a748:360f:6dc8) by
 YT3PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 15:18:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15cf1317-72cd-453a-93ca-08d997caafe0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3099D9BA5118D62C194C94E4EA839@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0W4AnhAqzipJ9Ifko07jY/e/0hOiRa4F9nJGYhLrWSTiK4DVu8drHglfeXTS8lXSUfE9/AX/oFp2VLwYHVPh0ydFlDmxJa6PyeIwT0ZNHYOPLWFlZeHywsVmoUeF506mVltbjt+AFK5T/j1XfT2FEvi+SIwh9MrB4bgmLio0MuK4YOHYSd/m1TGeNXEZfS0aXdRkt8TnX7O1iFE8b/DYFMKYaJ9ZbpUEFv5jEIe71WJA4jGrgvMP6IEze2TMEBVBVigVZg5EThmA10pEpYH8DlexSsX0wBgkZt63mi3C8VYaaH39KXAdN3wT85leffhHNkklxmDIMyVNv+A1LEqkCCAfoCYS2iQyP8wNW/heKCb5i/8KN9hIyerFP6G41mdcnjAy4xASeEnhvZRAWIyj5zf4LqqAlP2R1m3zr0uJB0+Xl1z8py5s/UVJUBfOwQ6+vNFxqETWoRS/HwdU7OPEmn1lINLVVnaq99mhRzKvhOAPkDU8lJGU2nMoWKaJy9ljhk6opit+UYPc/PzChZFt9tv2I7OAahI4eUgKLtfnR1yuOHgXehiHeMdRdtdQ2YjJZdAl5a21L7BYAHhTzpV0XlXvV02GjnS3V6sb2II25pTwdcK6jT/kTeb56ZvhDBJvKZ2K6Ww3lgZv9eq4cmsLI/jPv97SxEBBvp37tVBUPxTODIKwbgTdLiWQeBzVFV9pDe15fKDgmvf7CJu8ZldW8Bsf0f2Oe4bCyt5uVn4KGVPDkAPs4jMZp8fxsIB/gi8qSTG33mPU4QOn+UvaRyCbV3Vjo+x7lYs/qDzy0Kp5Hfyv8WvH6CfiBThPKOJpNA9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31696002)(508600001)(2616005)(44832011)(316002)(31686004)(4001150100001)(2906002)(86362001)(66556008)(53546011)(38100700002)(4326008)(6486002)(186003)(36756003)(8936002)(966005)(8676002)(83380400001)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZjMHJ0cDVGbzl3OU16T09KWmg5anhkelVYZkRvUWliVDh2YzFPa3R4KzMw?=
 =?utf-8?B?TGNsOEsvcnBRSnlmbU9PMDhndzNoR1pCSzA2OEtTRHRGMUFTR202a3FaTldq?=
 =?utf-8?B?aW9kWFdTTGtQeVhFNWprRGxkKzJsMWx6QXJOSzJZRTRjVFFTdzJjSVg1dEsw?=
 =?utf-8?B?RUpPeGUwYmNPL3ZaRXFzOHZqbmpwZGZGclh2Tzh3ZEhoMVZ0RU5YS2YzSHA1?=
 =?utf-8?B?R0luY2lPOEZsc0pMWTlPWVNUOEJWR3d0SHJtS2ZGOEdKcDU1czh0UGlZUzZW?=
 =?utf-8?B?ZjYvVVl6RFYwYUE4MmlGR0hnZ2h6MnJiTkx0OWxhUkZucXl6a3pxdmp2WDNx?=
 =?utf-8?B?WjdxSFR4cENzOUZPRUNGZ091RlNyZExkOUt3c2lSOHR0MjV5bkMwTVBsbW5C?=
 =?utf-8?B?Si9PM2dYOXJiTFBIaTArVktoQ3JEOU9UVDlKSXpVOU5BUit2Ui92QzZ5MXNo?=
 =?utf-8?B?VVBndGg1SzZIN0dVMDBMRUttY2ZjMG0rdzhsU0lXZUpsZnpFMUxSRGNMeTNm?=
 =?utf-8?B?MEhXN1RwYlZTd2pXNnVYcTNWNkdrZnZjaWhzVm5nWDR2bU5JNXJTTVpVWEhl?=
 =?utf-8?B?TzMxbm81dEgwZUQ2WjkxQWcxeEtZeVBkTHArTStJTzlwd0dDd2ZLMkczY2R2?=
 =?utf-8?B?MlVENE1QK3RTaEVGTGlzby9NZTlVRGVSclYxZm9ScUNHUVFjSzMydzh0V0pK?=
 =?utf-8?B?dHJESkM5N201bTk4Q25LYk9pSjUvWUViQ1BmSGd4MVhHVHVBbithMXJJcnZv?=
 =?utf-8?B?dy9FYTRVOFlsdUhHWjdTKzNXaVZEMG00bitYcG5QelJabUV1UFRxWVNFVUx6?=
 =?utf-8?B?ZmtTQnIrZUNPV2NEVEErMHdYR1VyK0lhQkhjdjNMYUZ4L0FMTHZGS2FEZGZM?=
 =?utf-8?B?NnBWdnNCY2xOck00TDlBSU8wZ3MyU2VLSkpmZGFKZmFKMERzTzdUY2Z5d0Zy?=
 =?utf-8?B?T2J6UUtiN3kxS2E2SlN2SEViYU8yTlpSQS9aQ2M4Nk9KM2dvK05nbVk1Rlky?=
 =?utf-8?B?RUpNQ2VFY2xKUkp6VVJSOWRLV1lseDhmSFFwbDlyMEFLQzUwd253ekwwbEJB?=
 =?utf-8?B?VU1aR1czZ0JaVHN2VHpDbFNzUUYxTTJLZUhsNjM3YzluNW53VnpodE5OOFdU?=
 =?utf-8?B?M2dvNFlzM1p4OXBUMUxTK3RJcE56NmtrQ0djb1BiNGM2YlN3bExZa3Z1aENU?=
 =?utf-8?B?OU13YWh3bytucVRibGM4c0ZRblJXSVBBM2g2RmFJUmpIa0tpVXFEdGt5MU5K?=
 =?utf-8?B?SC9vaGpvVEp5OExHOWZuZXB6Nm8wYkFZU3FMRjV3NDY2VmNTdE1INGUvNUQw?=
 =?utf-8?B?R0YxK3g0VEJPVHNwdFB5Q3VQbE5qRWJxRXVPU3E2OFZoTHJrNk1SRWgzK0I5?=
 =?utf-8?B?WVBtTUdNNGR3bHFkSkFVYk8rUGRuTEFKZTZDRXR1RkNUeE5VT2RrYUhtVGFh?=
 =?utf-8?B?Vk1rRXMxWmNJWEFtcWFwVUpCSGJUZ25VYXJZQ1lqdmxMcVpFdU1WbVZydjQy?=
 =?utf-8?B?VHNBQ0xxTXpUbnhBVFRJcm1mOGp4a1JDaFBtT2tjbjIzL2UybnJEUUhmUldo?=
 =?utf-8?B?eEN1VnQ0cWtBUDVuYlJJL2ZQVjBLVlltQmFJYzk0Nis5Z1l3ODh1ZkZuNEZO?=
 =?utf-8?B?YUk4VmQxaTI2WkQxdjFkMUtVUUVkTWh6NlA5WmxKMGV4RjBmNnZBSWMybktY?=
 =?utf-8?B?THViMmRBd29yTFZDZFNhT05YQlFBUzZhTHdzQzFoU2JxeTl3TWtKSStDWGNn?=
 =?utf-8?B?MnowK1B1Q2dhQ29JQzhKakZaT3dkTC9kYWZSMXRtbERzR21zMlptaGpOY2lX?=
 =?utf-8?B?TXlJdm9xaCt5TGl6RlVvOFVPQlFGbGJrbm01Mjg0bDNGZTNhUmJVS2dyMEMw?=
 =?utf-8?B?N3F1TEQvZWdKdCtac1l3SGlXeUZGWGYvNGZyZ0d2MXppWkZMTHV6NG1MM0tx?=
 =?utf-8?B?Sm0rRzl5eE02TDEyQWVFRzgwaU8xVFJaSWR3enluazlrcGxDMHRUWEROUjVO?=
 =?utf-8?B?bHJDSHJDNUlTMm1wZ0FWY1FvNE11bTJKeU10VUpEUk4xQzhHS3VRYjk4N01H?=
 =?utf-8?B?YUdGRm5YMmdmWVNrZ3NNS3ZXcitCaGRKenNpLzlWUUk4Q0Z5dWtvNTlLRWJO?=
 =?utf-8?B?U3dBekRja204by9VQUhGejJIOS9yZnNYMUxvU1NZbGc1ZnZIT3BQZGpHa2Ix?=
 =?utf-8?B?bXhyUmNQUjQyNnZNVXU2aWI5VUJOMWl6NmxqYmNIa0UvYUZBbkl4UVRsQnEr?=
 =?utf-8?Q?XnY+TeYkpIHZg2IrsvhtRzEz5doWJOQk/lUsa0ptXA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cf1317-72cd-453a-93ca-08d997caafe0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 15:18:24.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxQiGbURJ/KHauBvPZC3PlEHuihrx5Ez/qYFO6j9hG3D0T0LyGkYhDHi4rNJqpVOg5f8mU/iqJhdWx5QOuIs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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


On 2021-10-24 10:56 p.m., JingWen Chen wrote:
> On 2021/10/23 上午4:41, Andrey Grodzovsky wrote:
>> What do you mean by underflow in this case ? You mean use after free because of extra dma_fence_put() ?
> yes


Then maybe update the description  because 'underflow' is very confusing


>> On 2021-10-22 4:14 a.m., JingWen Chen wrote:
>>> ping
>>>
>>> On 2021/10/22 AM11:33, Jingwen Chen wrote:
>>>> [Why]
>>>> In advance tdr mode, the real bad job will be resubmitted twice, while
>>>> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
>>>> is put one more time than other jobs.
>>>>
>>>> [How]
>>>> Adding dma_fence_get before resbumit job in
>>>> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>>>>
>>>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 41ce86244144..975f069f6fe8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>              /* clear job's guilty and depend the folowing step to decide the real one */
>>>>            drm_sched_reset_karma(s_job);
>>>> +        /* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>>>> +         * to make sure fence is balanced */
>>
>> But that put in drm_sched_resubmit_jobs_ext is for the previous parent fence.
>> fence = sched->ops->run_job(s_job); returns a new HW fence and the put drops the refcount on the old one.
>>
>> Andrey
>>
>>
> Hi Andrey,
>
> If I remember correctly, after we embedded the hw_fence into amdgpu_job, there will be not fence replacement in amdgpu_job_run.


Right, I forgot that... What about removing line 
https://elixir.bootlin.com/linux/v5.15-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c#L265 
?
What if you make dma_get_fence unconditional instead ?

Andrey


>
>>>> +        dma_fence_get(s_job->s_fence->parent);
>>>>            drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>>>>              ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
>>>> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>>>              /* got the hw fence, signal finished fence */
>>>>            atomic_dec(ring->sched.score);
>>>> +        dma_fence_put(s_job->s_fence->parent);
>>>>            dma_fence_get(&s_job->s_fence->finished);
>>>>            dma_fence_signal(&s_job->s_fence->finished);
>>>>            dma_fence_put(&s_job->s_fence->finished);
