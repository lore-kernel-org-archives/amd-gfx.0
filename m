Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD476C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 17:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F15D10EF42;
	Thu, 30 Mar 2023 17:26:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F4C10EF42
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 17:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z706cujRHxiFCyHR/WjI9s6nXL/jN4R7qQbchnSXNQRm1xIepYNyoirhBRBXXpzmD/4Cn/sHg4KXtqPVt6vs6LRE4O4es11op4SX0utBDEjbazJiMzSPqoSY5rzbnvpMshqpc7ums9zEdA65KXHKxkeO6smyO12wAp/bPzwq3R9+HRMBUb07XsJQYPz/fPAxRO9M1m/RfSTMo36jvm+yTt1egcuh7y8i5ZQl05pRi97bxQT5VwWYF+sIdkHLW/O5iWeMgqCJNddmVftPwqSF3RWkjUE2Ql2PEuvTfvymracHIqKyTSBwc0tzFBkd2dGDxcoxyiz/1k6Gcr+y7Qt/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pruxCFe8wsMczW6o8oLJOOTVQbbH6m4uPQ59218kRk=;
 b=DOlGxIRsyiw1mocvl8M4TGfZ+JN1Xrpfm5dxV0bpoIEd2x/vQc2ofd5XeBqpPHhglMYspXKI4pEp23fbLFF3yRGv0KyK4qgU95QTi03/5SpmgngosfmIWtIt1egIDhWOu+E5SM1LuwUM1uTZ4UqCe7TZb7u6cdgeajAQLkndnXYDAZrXFNJujDmUN3IKdQun+WGdA4M1n+YT7RrnNQYI4bCQ4wFTX16zcN/Aug9NzFTegwoeCXF1IyEdzxRPJBFZXktUZFu1gOyDtvqGLWZrLZXMU3RMsolJbwg1CwIox65XDgExpJlB9zfum7j3gq0VJZbOw7yhF+xuYHouwvwIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pruxCFe8wsMczW6o8oLJOOTVQbbH6m4uPQ59218kRk=;
 b=OLP7oJBf8jzcsV0AYH7+JNi9/8658PvWnw4ZCCYqX6Ea+bqHL1ZpNZoTrF3hIHXVxWSte7OFdu8ReLPerj4GKRPfGqE8dleytSnJflx3JVucgrecf33amYsGm1A4PMROujKcrzgotDlfL/DQAyxVJjYPoJSFp+XUz2iIC1yVbkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 17:25:57 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 17:25:57 +0000
Message-ID: <af8e84a3-d49d-7006-432c-8679086f21bb@amd.com>
Date: Thu, 30 Mar 2023 19:25:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 11/16] drm/amdgpu: get absolute offset from doorbell index
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-12-shashank.sharma@amd.com>
 <0362df49-3887-37a7-111c-430c2c75e951@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <0362df49-3887-37a7-111c-430c2c75e951@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fca8b4a-ef70-4590-a2f0-08db3143d2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOb8ayJMgD5esbqkRyIV8rsxljg0MrAl6WhFLmPnJUTUOVJLILbOqeiXHE1eka1/5YHJYze1rV2eGk1V6NJj8itSbhc7tmqdgjtaHblPrJWyMr1Nm1cw4xp6nzPrzzT/NWXvY68RfT+amov+75iyon5oylQh+6q/0uYhtuZNRvhNVNShkigbcZ/FElztbFcRGEJei8Itj/OKJZUG/h4MzdPi0p2etFGFScewjTrZMsF5VCeG0rTHwm//ZL4oHELW2PAjSvRC7e0G+cAewc5rSCFNuEBkiUMpcBSSwvhXs7ybe0DXqaYeBgZSGbJW9VwvACrMoXMfBTjhzDlCSH5mXPu6KYeyuhKpXWIXBt6bQYTCM4mKnyN6Auzji78i5fm4bzi+E5P9LrdDVaTipkJ4sH50zq+oQjP7JMgm+ICdZWJWzW01utrERA9nqLg89Tcbk182ZUzP9fMrhSkfFZwzCzz2o5qKj194uWw41RHPilHloQImodFMJ0AMio8VH5TQFSo5Ly3C9hwvzpSwdIZmrWIK1TtGYk5ipNIdWo4BEjasnRkHU8fr8qZsQNnw/eGGH8JxV3kwNWj37WI3FMdx/WktGWJAO4OctFVq4LST9Jg4bh4D2MKfMLjKp4bjm8cc8Iq0WC6rAOC295XjKOo0Tlr9w2tiDz2lyyEpeV7ng04hFESj8PFcBIUZp1fZuaw3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(186003)(86362001)(6512007)(6506007)(26005)(6666004)(53546011)(316002)(66476007)(66946007)(66556008)(5660300002)(8676002)(478600001)(966005)(36756003)(41300700001)(6486002)(4326008)(54906003)(44832011)(8936002)(31686004)(38100700002)(31696002)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1Bja25uRUVjSk9vYnY3UWhQUU9QcElYbEZXVXlqYnBMRnpxc3BZcXlUeHNR?=
 =?utf-8?B?eXRkMUFXTTNESkZPVUswbTVGWE91emx1bVA4SkhubDV0aUlTaWJzZCtJK1Bi?=
 =?utf-8?B?Ly9OZjdnQVJUam1NR3ZxcjZYNTlGY1QwSzRSalRTdWt3d2MzNUxBdVFaMXpj?=
 =?utf-8?B?bzJMWWxIams3NmtoNVFQN2ozc3pYUjVRT21IZUVYV1hwVmVsYktJZ0hPQitO?=
 =?utf-8?B?MUI0V1dLT2JQYlFjYVVyVnRWWFg2TlFBMEZHT1krV1FXa3d5eGFDSFlSV3kw?=
 =?utf-8?B?YzhkdGQ5NE5OOGFtajl6R1pxUlJrSUZNVFB0KzN4VjFCaWM2YnozVE1CZUR2?=
 =?utf-8?B?cVBwdG1BZGFzQjZQaTlYdjBNWTB6UFE5NDBwS01OdE1ueGsvOVJYdTk3Wlc3?=
 =?utf-8?B?dWM2OVhtcXEvRVhFZkhyTE1nR2pZRncvbFZqRW5JTTdnWHA3UEcyYmdqN2E5?=
 =?utf-8?B?eWxlVGcxK3V2K3FiRUUyazgxMUl0T0d1UE0yWDl6NU8xWWN0QnExSUh5NStv?=
 =?utf-8?B?bXVKNmRYYjlZei9oblk5RnVVcnR5UEo0cklyNGhPRzhuRnVtMjBwNHkyeVlO?=
 =?utf-8?B?cy93OHJKWkdxcDd1L20xQUp2SUVRU0pZdXd2clV0Wk5sRHZtWEFpVmxYT29i?=
 =?utf-8?B?MmlqMjhiQlV3emJObE0vVTZvVVk1djA5V2M1MEs5d21Kc3cyQ0NmNCtSQW1s?=
 =?utf-8?B?NW9qcVk4bDZISklmanJMYU1iRCtJQXAxSnpVVFY5bS8rNlFndHpwNEQzTEJp?=
 =?utf-8?B?Wm9DQlpvM3BGcWZhNk1xRFJRV2Q3QTdGd3ZPMzRwN1JsaGFPYjg5OEd5T3Fy?=
 =?utf-8?B?V21UWUZ0QmEwRVk3MTJiSXMwRzhqMmhLRGhXUThxZDFCUzA1cVY2Ni9nd1ZG?=
 =?utf-8?B?TUFpdTdkRWFFZ1pManNMbTFQS1p5ZjJ0QVhPdmllNVhTVXF6U1pDZWJnOXov?=
 =?utf-8?B?MUF2QUsvbEZxOE84SkxPR3BEbmtETEVQQitNS1E4ajB0SmpzTHFUQUNMYldG?=
 =?utf-8?B?NUFWZHphakdiZDVVT3BUVVV2OEY0aDc4eFFDTGtEUjhVNk5Icjl1T3Z4dVBi?=
 =?utf-8?B?amxmUnpNMitjOGdReFhmdUZJZmczSTAxY2J4UTF3OXQwZjZxN2xKdVZwZG5N?=
 =?utf-8?B?Z1hiWlpyU2pDWSs2K3VrZWQ0UU1Jc2pTcllaNHVFTDFVWktQWlN2eUJJOVBa?=
 =?utf-8?B?NEY0U3dLd2xNSjJKeDRZRFF1MTAzaEwvOW5HWVhWNW5TbEZzRmhabStiTzlE?=
 =?utf-8?B?RFAzb082b2JmQWYxM1drOHlYMjRCakVKT2VCcWlMTEpuUHVRVkdjZ0NONktX?=
 =?utf-8?B?UGhCOTZHWVVxbjFBTFdheTdKT1BNeS9KVmlCSXAzd0Y4WW9VVSthWlRGU0ZQ?=
 =?utf-8?B?cGI1TGNoTGt2akhYd2k4TnFuMk5XR1hxc0krd3MweHpLblcwd0lMaHIrSHVZ?=
 =?utf-8?B?NnF6ZDlLQmpEMDhicElYa2NmV2NkRW5rV1NUZFJKcmw5eE9jWHVsSGN4eVdt?=
 =?utf-8?B?d2dQVHJmZlJCL05yQUVnc0pyY1EyTUVGYUhiMFRlcWZjNHdXc2tNMk51TFNT?=
 =?utf-8?B?b3VEbHNXR0s2SGdoaWtPTUpLNlZJQWozRzFxaVRoRFRucXJiTWF6TzRGTGpm?=
 =?utf-8?B?b1ZPOVJ2NVAybGZnaEFLS1l0azg1c2dTeTZ5RGYvb3hCZWlHOW5sakFmbWpo?=
 =?utf-8?B?TUwvNk1tbmtXVDVMcjBtdjA0aWdmamlmMHRSNS9ZSUFIZ3VRRE9SVURJN0tw?=
 =?utf-8?B?T3ZQRkFoanBUa2VFNWE1aWlXMW0veWJYWWtxbTh6RENyWldWSElvcDhmM0c5?=
 =?utf-8?B?S240QTE3SG0yMzh5VndDQ1dHMjRIazJMb0ZGRHhOd085bEUrbFNkWGVJSjJS?=
 =?utf-8?B?b1BpUnNEUEpjRmdDMHBOOFJKRTRkN1p1T3ZhdVlkT1hobE0zdG5mbENPT3Yy?=
 =?utf-8?B?NENJa2FTSExRakRLNWdZTEd2eU9qUnM3a1FzQmtYUXN2Ylkxd3lSOG9QdXMv?=
 =?utf-8?B?bHRaaElQN0tNTEhsa1BUd1p6VTB4K25nQTRiRHFKY25oVWN2eTdiMlpuMk82?=
 =?utf-8?B?cmE5c2NnS1FBU1JoUGE5MWl0bjQwc0RpUlhkSFdiUmhBMXFGUEhvM0QrazEr?=
 =?utf-8?Q?sqBm+yUeGDvKIUu+M58CVO/SR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fca8b4a-ef70-4590-a2f0-08db3143d2a2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:25:57.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDq5kEURGvGDiGDWjiyAJEqp2FgBvz2elaSrzlWK0PIO5T6vMCPGxYAyt98McZiN8Btd00hxZqC+DgpZE7Uclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 19:18, Luben Tuikov wrote:
> On 2023-03-29 11:47, Shashank Sharma wrote:
>> This patch adds a helper function which converts a doorbell's
>> relative index in a BO to an absolute doorbell offset in the
>> doorbell BAR.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 15 +++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 26 +++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 10a9bb10e974..3481e9d83879 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -383,6 +383,21 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>    */
>>   int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
>>   
>> +/**
>> + * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_bo: doorbell object's bo
>> + *
>> + * @db_index: doorbell relative index in this doorbell object
>> + *
>> + * returns doorbell's absolute index in BAR
>> + */
>> +uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
>> +				       struct amdgpu_bo *db_bo,
>> +				       uint32_t doorbell_index);
>> +
> Two things:
> 1. No kernel doc for function declarations--this should go to where
> the function is defined. (This also removes redundancy.)
>
> 2. No empty lines around function arguments in kernel doc. See this about
> the format of function documentation:
> https://www.kernel.org/doc/html/v4.12/doc-guide/kernel-doc.html#function-documentation

Noted, agreed.

>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 81713b2c28e1..c263bae6b0c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -130,6 +130,32 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_bo: doorbell object's bo
>> + *
>> + * @db_index: doorbell relative index in this doorbell object
>> + *
>> + * returns doorbell's absolute index in BAR
>> + */
>> +uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
>> +				       struct amdgpu_bo *db_bo,
>> +				       uint32_t doorbell_index)
>> +{
>> +	int db_bo_offset;
>> +
>> +	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
> amdgpu_bo_gpu_offset_no_check() returns u64. Perhaps use u64,
> or u32 (which is what this function returns) and cast it down.

Yeah, makes sense, will do it.

- Shashank

>> +
>> +	/*
>> +	 * doorbell index granularity is maintained at 32 bit
>> +	 * but doorbell's size is 64-bit, so index * 2
>> +	 */
>> +	return db_bo_offset / sizeof(u32) + doorbell_index * 2;
> Perhaps add this inside the comment:
> * (db_bo_offset + doorbell_index * 8) / sizeof(u32),
> which seems clearer to me. But leave the return as is.
> Regards,
> Luben
>
>> +}
>> +
>>   /**
>>    * amdgpu_doorbell_free_page - Free a doorbell page
>>    *
