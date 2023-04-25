Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E25C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFE610E2BB;
	Tue, 25 Apr 2023 13:34:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D40C10E2BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Uwa38AsT4/+8QK5+fFzA7z3kudWM9iRGAizeuhdx2UQfwojKu01YXmJtPvqJaYrho4P8V5THYw7GrTv1CHZvtnklmhtK/ywzk848QL3g7tE6GIB1Y+cbfEHi4qqjbIjcyGxK7uHgb9j43ON9axdlPEWla6EIUsshaN5gDZtC2s7TQIByjCrlROjQ8c8/pTQOpPSuoCWn+F7n7UO2cG34IQUMgZshyzqbPqIl8mYNwtsqthMh9xl42caOwpYBu46NZYtWNkgoMH4aNst0wJ9rmwp7cTFydKvDN1VM0L4w3+Lpb1tSHStVGzkht6m/uNPS38koKsesS9dI5nGI3KBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyOgtlSZNyY92E0jYTA2SnVPfdIe5ipWE87rCDHd6Us=;
 b=LtEe+91AeDj+Xn/+VZF7yzOsq2bxbH9vxREQstuTkfmk+etw/aNnE0s73o2GQ9SXaVXSNu2oOB/q3l98WqlKJ+5yAs2g8em5hrDuxeG2SAdt0AAxblQQA+9R4e5za1z2Nbrev5t3TvEOs0DoNp6/7W3MwaH3kITAVar3pGY2R0u99nUINaVpMQsyV8d/WeznNZDarb5SnRKTMUnAkfuolWbMzqmUxweOopxcZvusMVI4NsW02xn8hja4f4kPJ5rpfz9JFyS/9nYfHLTQWpueopVC/C/Wo8QaX9yqw7z/lkQH1KNIbXlhD9DFFiQpSFPk9kaph9oFQ61KM6it0utBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyOgtlSZNyY92E0jYTA2SnVPfdIe5ipWE87rCDHd6Us=;
 b=rnRu4GLs7+CDFIyKelNF/0XHLn6H4nxG6sF1irzilesqs9EA24K72OzhuoXjTJODy+GRnrxgDie/zkWDyxLVEbyrONMzBY0+PHqK1knAlQYa49MX/VpIk1KrLLIFHAACr3J3Dlxrtk7WbwCqeLz2yGnJQ7EoTI1EEQS1m1GfOyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 13:34:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:34:19 +0000
Message-ID: <2468fcbb-2f4c-56fc-585b-11d5d6f65c91@amd.com>
Date: Tue, 25 Apr 2023 15:34:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 09/10] drm/amdgpu: generate doorbell index for userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-10-shashank.sharma@amd.com>
 <44d081c1-8bd3-53ba-a60b-0fd6fe630aa0@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <44d081c1-8bd3-53ba-a60b-0fd6fe630aa0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6d6b7e-b2e1-475e-8ca9-08db4591c5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtUdfs3JaUg6bymUwoBwftUs4i0+IVpWehXf4o5fjWfCn16WAX/UzXkJ11wMbpcwN/xkbQNU0Z+8fSEgx7V8M4Yzgt+6sJGHg46ZwWyGsOhpvxFuKDzNM8YKqUmgYWaiD/ntdhSzg8IyWr6nCCNy+QEo4aww4xNF+hjVhfacFpcvmoJS9d3K+2SFxfXtaU82yISYzQQB0i8UOhDmy4/WfhsE1utH2cMSLOJ01u5DafmArmcAH8wt8ks+E21qj8oVWWLpFPak9+V2BsAvJ7PBgzeG4cCQ9SZRQYyezxYV/UcwLshmKdYbE9EKpp5CxXwdPcopvRFYDipZ4++QE4GYuZrjYd2tz15zeMkE0wlWAt8u/zumHT8QiIp9hWj97zVfzlYnwNg8XbDSlMCAUcPbx0tez8bd/YZceheMzYCCKSeNOfH9o7NUy49UfecrSAtE99+ucg/sdopIxTbn2yNZpvz+rq6o4vl7ki1jw4BQ0NX8dfGGDTR2yz37ic8V4hAMoj2MSd8CVkZALkPYVnQ9r4K+/WY6+xqszWrEa6b9gbWHoNnlR8c3Bvdg8zRtMl1tjOWPDno3YnYMxLVpyPpEBGk8QwIx6rElPLozDy4LlJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(966005)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(66574015)(186003)(38100700002)(66946007)(31696002)(86362001)(478600001)(66556008)(66476007)(31686004)(8676002)(8936002)(44832011)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5YSkRUZlNhZE0zVHNPL0ZjL3JrWHlmUk9UcVF6cW01QVZNcTBtUGhSaXZC?=
 =?utf-8?B?c0w1TWlxbGZKUlFjUkNFTzZQMFlpNWdmV2NMMmJJNHJ3d0FnYnROb2RENGlN?=
 =?utf-8?B?alV5TTYvNHlGUXNXaFJPcnNMUmpuQ0puM3hKM09UcUdLQTVZVUJxWGFRQWRV?=
 =?utf-8?B?YTlIa0MvNkhpMFZqUXRic3NvM28yVlRGenFhcms3T0hyMDdQUkI0d2V5Yk84?=
 =?utf-8?B?RUg0K0NEUzJ3c25iVmNYSXJMMHlDWkdoVXdJSnkyYnEzVnp2VU1oOU9hY1dS?=
 =?utf-8?B?WmxreWdnbUlBOUd3cTA0c3plSGY4MDhvTmNJcTJ5UWpaVG9FOEc4Wk4rMG84?=
 =?utf-8?B?ZXZiTnlCRENOd21xblZaRFhsYXFMdGc4aEs5eG1nVUcrL29QSTB0S2JkWVdV?=
 =?utf-8?B?T2RtYUdXcXlENHE2WHhTZEw3eE4ySHVBU25PV0xtNkd2WEQrVkxMbG45SlNR?=
 =?utf-8?B?dndKcmdydVlDcytRdmxlRCtZdEdvdFVQU0dYNy9GaE8xWndXZW4yZzF6Z2dG?=
 =?utf-8?B?NVlsbmRsc0pGeS9VTUhDSlFIQ2t0QlJIMTFRU0s3YjAyVUdhT0g5YXhkaUU5?=
 =?utf-8?B?TDd3ckVaalBPTU9veHhOcld0UENqc0pLbTYvWDd0YXNYSGxFRE05cXBnRU8y?=
 =?utf-8?B?TjBQVmtxQkVielpCc3FzZ0MwQ1ZLVFZleWVkeEhjdG53V2lmaGczUkRLVVNj?=
 =?utf-8?B?Q1hjTUQ0eXZYSlIyKzRsbHFpWWdQMFdaV0FDT2diUmNpN1Zhd2pGdis0UEJW?=
 =?utf-8?B?cEx3R3p6cFlzbVkxQ01CZGJ1bGJXejh4MlI3VXMyckpIZ3ZRWmd3UDd2N1Fv?=
 =?utf-8?B?UjNPZTNrVWh5WXdCZGV2NkdzdWpGTFMzSVZqQ3h3U3EzcnZWZVc1RkgzVkRp?=
 =?utf-8?B?NTRGK3VTc1JTdHpRaXA4WVc1TVB5dEJLYlgwcVo1MFAyQkI0ZzRPalZTN2lz?=
 =?utf-8?B?Z1ppUGhJUlFWZDNBQ2kvVDRyL2cvL0hEZ3lyOGdQQWZWQkd2UDdUQjF0UWZS?=
 =?utf-8?B?aEQxUXRlM3Q1d09UY00rSW43YldEYWNmVEc3ekNXNERwb0RyeGk0OXdnaWR6?=
 =?utf-8?B?NFU3Y3NmR2ZHcmhMN2M5d0FVSGtzY093ZUJ5eWw1VjVEUHluUjZrdnNKSkNM?=
 =?utf-8?B?U3NLazlWNEoyZnc2RmtwV1N6MzhvNk9xRThOUUJVUFJJd29FbHI3ZmRPbkxo?=
 =?utf-8?B?bXkwUHAzMEFqY2hYSFI5QUhLbDlzeVg0RHJvdkxtZEpSRVBXUWNGMDNHY0pt?=
 =?utf-8?B?TnA5RHpialhSUXhtejBUY3QvNzhXUTlvc3I3eDFRZXN2YXY4bkJVeVlmcUZP?=
 =?utf-8?B?USsyU0xDSlBCOWJpb1JrSCswTnpSUUJtaU55L245UmEyNEk4ZndLNEhkUGtZ?=
 =?utf-8?B?Q3lHTFVOcnIzQVMyZTYvbUNIZHhrcTNiSFJXS1FhOThqSmJMYUp6akFxS2Jx?=
 =?utf-8?B?MHNEblNPVjZzSWU5eWtnN2F6amROYTlzUmpuZWtzSTAzS0ptMGFiZzNjVU5E?=
 =?utf-8?B?aGEzY2JnTnVKYjMwOFpFdFo0QWczSjI5ZCtoNDRWT3FuTlpVYWhEUHZPMXFV?=
 =?utf-8?B?WElrdXZ6UnoxVHc4L0xnRlV2ZDFCY2xJVjRNTVFZMTFYajVqVjJWUTQ5SXdu?=
 =?utf-8?B?MURldzBWeE5wWjY5WnQ3RkczeTZCVjlPa1VrT0V4bUtIZVF4eStQNnNNeXRi?=
 =?utf-8?B?c0xRTXEzaXJNdnkxdkdtankyb1pFcUVUSkJ3eDg3azRnUUVFQnBQT1krU0FP?=
 =?utf-8?B?UFBscCtBUXYwZmtwcm1JRXRxTVdxRU9LYjRIblNSTWpaNzg0ZXRhYnVZNGpX?=
 =?utf-8?B?NW1NMjROY1BsNHhXdFpOa0hKY1RGR3FMVXZpcUNiMXlYWnF2bXA1RXEyT1g5?=
 =?utf-8?B?b0tmOVdPWHJKUVhOc08vdGh5M1lTQXAvK1FsQUsyR2FGczAya2FCRjBhOVFr?=
 =?utf-8?B?VUxJSTVNYm5YSWNPV0F0S3ZwcUpNTFFmNHlPS0QvOEtHanBsN0hOODFmYmVT?=
 =?utf-8?B?Vm9SNDY5eUFiZE53dCs3MlhhMG1rVEk3Nkw3MVFPZGlZRGJvTFEvQWoxblJI?=
 =?utf-8?B?MmNJZ21tMVM3eUtibERvbXdwMURZcTlBVkhUZFZJOGFxTXQ3WEF5bVBuVVA4?=
 =?utf-8?Q?cCnqq4lXMbNZAlpzSATq/6+fp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d6b7e-b2e1-475e-8ca9-08db4591c5b1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:34:19.6473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MyUDakO0KTTOUnROHOIxvIz7YOyMeRmlNYOXcAwQvMjGYz8D4lfmOyNpZvqkxZBT4Uex43/clRwGn5T4S3kcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
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


On 25/04/2023 14:38, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> The userspace sends us the doorbell object and the doobell index
>> to be used for the usermode queue, but the FW expects the absolute
>> doorbell index on the PCI BAR in the MQD. This patch adds a function
>> to convert this relative doorbell index to the absolute doorbell index.
>>
>> This patch is dependent on the doorbell manager series being reviewed
>> here: https://patchwork.freedesktop.org/series/115802/
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 33 +++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 385cd51b6c96..fbc9cb5c24ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -44,6 +44,30 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr 
>> *uq_mgr, int qid)
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>   +static uint64_t
>> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>> +                    struct amdgpu_usermode_queue *queue,
>> +                    struct drm_file *filp,
>> +                    uint32_t doorbell_index)
>> +{
>> +    struct drm_gem_object *gobj;
>> +    struct amdgpu_bo *db_bo;
>> +    uint64_t index;
>> +
>> +    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
>> +    if (gobj == NULL) {
>> +        DRM_ERROR("Can't find GEM object for doorbell\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>
> That looks like we are leaking the object reference here.
>
That's correct, I will fix it.

- Shashank

> Christian.
>
>> +    drm_gem_object_put(gobj);
>> +
>> +    index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, 
>> doorbell_index);
>> +    DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
>> +    return index;
>> +}
>> +
>>   static int
>>   amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>> struct amdgpu_bo *bo)
>>   {
>> @@ -133,6 +157,7 @@ static int amdgpu_userqueue_create_gfx(struct 
>> drm_file *filp, union drm_amdgpu_u
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>       struct drm_amdgpu_userq_mqd_gfx *mqd_in = &args->in.mqd.gfx;
>> +    uint64_t index;
>>       int r;
>>         /* Do we support usermode queues on this GFX IP ? */
>> @@ -154,6 +179,14 @@ static int amdgpu_userqueue_create_gfx(struct 
>> drm_file *filp, union drm_amdgpu_u
>>       queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
>>         queue->doorbell_handle = mqd_in->doorbell_handle;
>> +    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, 
>> mqd_in->doorbell_offset);
>> +    if (index == (uint64_t)-EINVAL) {
>> +        DRM_ERROR("Invalid doorbell object\n");
>> +        r = -EINVAL;
>> +        goto free_queue;
>> +    }
>> +
>> +    queue->userq_prop.doorbell_index = index;
>>       queue->queue_type = AMDGPU_HW_IP_GFX;
>>       queue->flags = mqd_in->flags;
>>       queue->vm = &fpriv->vm;
>
