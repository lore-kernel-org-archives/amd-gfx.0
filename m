Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB4C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2696110E2DA;
	Tue, 25 Apr 2023 13:45:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AC610E2C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbkEYHNNIRzh7dhsu7pB4wY6pcKa+h2Vwgwirj3iIlhM7UwX5IqCKbRtHVafTzzacTMOxktOCGR24wdJybcQATDvHf88ylKBrorGRs8BZWT9fBrcflwjtkzPHBF4kt+XvPOJJzam/KgMkHkXejdGrNLWkQnZXkXV21Fmj7wiBv/pAWhWgGcycAN4Sp8mrM/rFbnY9lJ+tHzWPFrFr9LNeqpPsNJl9chDOfbImH7KazYHpZ1S3TSCDW3qCF5Ua5xQAC7k0gDS/K1CfKomdoVzUW2RtLw1VCdSZCpUQzl742KlbVhWBwzYeL3BVucQKdVfl17sM6Ur/oWkccz+eYm1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRQ691Lii3i0FM7G5W8NA5hhPnko6g29kDIxVgdfV0E=;
 b=al9oq55eiewq050MnqlJ4y+V8UrTFNgKSHGjz3lwX1reWnMgTN+NI9Mw0gv6FUn8qkio4Z70NPDOo4qyJf1lhsUXXNxlPHJgw3JlYlhNnV3d2ad25IdZTkzysc4m8i7dAPgzDVYZeXjAxpN7459riMw0ekDGO2wLEuPjCckzxRSJWG8wJhyB6NE3mIfD9tBIssUFWTq8HX80OpmovgPsLo+FuJGM5VlK8xxP9rA+4pu212c26PEvfZL35HkqfUIwCqwASxZ96mdFZYcBaDrTU+jGV4RSAGRKJCNE/d+vvrhuTmc7L4RZpXD0m1eyN4KILSjgslzaLJFswcs0kEMsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRQ691Lii3i0FM7G5W8NA5hhPnko6g29kDIxVgdfV0E=;
 b=uBkTx/NVG4SG1srq5I+TaWfUB2ZBKgEroxALlNHXO0Q6OSd856f9VdmixNlOlebmvwpO6VCfANdYP/jYOdhP8u8+oJFSqRwGg9YWJRlCO9dRvDnAYjqHYjpVH934WbByF6BZox6g6Zq0qDdYDbfZIfdPowWyBDXkgCdNY8o5GW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 13:45:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 13:45:25 +0000
Message-ID: <8e194e8a-4b71-f16c-e8bf-cfd0b34f7c22@amd.com>
Date: Tue, 25 Apr 2023 15:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-5-shashank.sharma@amd.com>
 <8670d699-dcf9-f8e9-a11d-e87bb40643d4@amd.com>
 <eed1b460-27f2-00a7-8016-fb866628db49@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <eed1b460-27f2-00a7-8016-fb866628db49@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f4e912-7430-453a-1d4f-08db4593528c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wznMO9nLxiWfUnalozxxGG0A95juKTZLTVy7o4w9XpDwTHFHlg/Q8PBmml29yVMyBvIRvBYXa/lJ0Krt0BySJ9B4ABynvA/3SdqZR4DtRdE3gCikJuuTDGuQ22HmSLs+DlDvh08CcKdDyJwjzQEI8nQjnnwX8zahrY9Bjd1/ZYxM6ln/JWb9uFItyu2D5yM9rGqVFfqKOZpqgul3f8wPvwHrm9v0TOD9M40UeozoaKxQRcd0Li7C6Y3HMzFETKu0CzhKM+gTopFfeXR3GmVqzVOCZ7UzhJlUtj47cHJXVgpbBMmL6LVI8/HnZUMXk5rAqfkyGjigdnKX5sNb7pVh9hGvy4H770MGRBTm4AF8LSfrz/60gLBF2ZPZOwJoqXd6nZRBqljGq6LWxC+aXPNELy8NaLM/w0sjpu9R6qH4wHKBvSM38WVDjpnnN03Q9Ah3teRIhb3g3dkSKkI14CMSSdXUjVxrH0w/0UbGPs5/K3/4em9E9oLfzsfg3aKnMkquw/6wL9bJefT56L08iGecMohqK4db09XCs/siqcRUzDpauJhy3kAah+Qp48a768MeDsGoHlQPmXVeZ+6gAqsAf5erYZBHz4rtxLRpcrr2IdHx9jxRysSLB/f4jNYkq5C4vKYERkRpX5R0ymTcshznDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(53546011)(6506007)(6512007)(2616005)(36756003)(83380400001)(66574015)(186003)(38100700002)(66946007)(31696002)(86362001)(478600001)(66556008)(66476007)(31686004)(8676002)(8936002)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJHK3cweVk5OVRyTkZtc01vWkNRYm9WL29nQWxWUXBKQ2NsUDk3UUtTcEdW?=
 =?utf-8?B?MmhGUytYSjBhSmJJNUEvb2YwcXg3cGRHb3VURTNUMEpOdEk5TXV4ZVB3QVlw?=
 =?utf-8?B?K3QxdUY0aW1XbXF1cmtvbFVTUjI2UTVWdThBemxuL2F1Q1NhcDlQQkR0ZjZY?=
 =?utf-8?B?Si9BWWZOTzVlZzl4MUhiQi9HTFFFWFlTUHkzeEMwRjlETmpmV3ZoYlY1VjRT?=
 =?utf-8?B?RHRyN3hpTmdNNjQ4SmhCTHloUlFKS2hxVzlZcERaUnZqanMxREljNmNTVmxy?=
 =?utf-8?B?Q21JdkoyVEF5UmR0RVRiZm5BTnoySWt0TlVQN2RNM2dXSTkyY0ZkYm9ydTJm?=
 =?utf-8?B?Z21PWjljM09iTXBRbW03UVc3RDJVUkpPRTNkU0hOa1pVbjQzQjRCd3RKOGx0?=
 =?utf-8?B?dWlzc1p2VVhWZVMvZ2VJSFB3enZTTGhFK1RIS08rYXdENUV5MzdhUEh3UHhI?=
 =?utf-8?B?ZXArZVBNcXBMZ2ZMWXI3cTBoai93amZBall0ME1vU3QxNjZWYnNFUkQzWVVv?=
 =?utf-8?B?YkplRFVrUVdMaFZ1eUkrNEMyNU1IZnVyVFo5RFBSQ09KSTdtRzZxcWJDQzF1?=
 =?utf-8?B?Z0RucTd0NklET2krQkRBUmJIR0w5TlhKM0NVZjU3VVVEZW4zTHppTWlvdDgr?=
 =?utf-8?B?Ri85MmQyeDhwbytYdncvRVVQcFQyVjQ1OTFlMS9CejNWaFV4QnpOTTd6RUJh?=
 =?utf-8?B?QUFReVVTZnBKejJ2K0IyVXpiay9qNGNQYTFvdHRVU2RNNzZhR2w0bE5NN2dP?=
 =?utf-8?B?d2JoRzU0UW1lZm9rZVZ3dXZwbWRmK0grQ0FSOFNoSWRiQ3FMUERRMVRJSmFK?=
 =?utf-8?B?SkpGTG1wNmNyMFkvNzErMjZWTkZIVnVQRzYydUVQdUtkUU1IVlJCYmdsaVZU?=
 =?utf-8?B?Zzd1VWtYbXBsbzN5Y2ZzOTlzdjRtbkR5VFp2Zlc3ZnF5QWppYWVSQ1ROY0tv?=
 =?utf-8?B?dnlNM1Q4TTdGNHUrOVE0Z1FxaTVUZ0E5bHBrazZuamN2M1k5OXNseXdjR21r?=
 =?utf-8?B?QXhSbmp6YnRYM050RE1FK0xlLy8zTVNYd05FQVBLbXRJVDgybkhsK2tXcVJH?=
 =?utf-8?B?MXE4eWFNY1R1aXJMbGhXbVdjRFFqTllaRTEyV3BDc2l5MVZWNFVmWlJiOFVV?=
 =?utf-8?B?alJDd2FoN3B0bncrcE4wcGRlQ1d1VjI0K3huTnlDU1hOZXBXOVhKTUhVcWx0?=
 =?utf-8?B?Qk1YaE83RWc0K25Ecmd2eXh1dmRaL0RyeDYzeE0zK0dwYnhLaHh3NXdVY1pX?=
 =?utf-8?B?OVBPaGZBQXVJQXFhSjArN0Q1OFFSeURPMXUycEw5Nk9lbnZVcnE5OFIydXZ2?=
 =?utf-8?B?dVE5dW5URUhCVWRqRkVsakFJZGZySXR1aTZUMzY5ejF6U1VpdWlyWi9UMkp0?=
 =?utf-8?B?Qjg4a05iR0UvRzJFTXhodk5MWk5kV3kvNHhFM2dBcThybnVHM0lhdm5icEND?=
 =?utf-8?B?UlVrSGtNRVMwb3g5R3RkK3VJVDExaGlHY2FCNHMwYkdaYVNjZ21qQ2Njbmlq?=
 =?utf-8?B?SFY2VE95Y09MTFVIWWY3Z2pKck9YcEF5Q1VzbTJ3U0lHSzVaN0E3Z2FMRCt6?=
 =?utf-8?B?QTdHVW1zYW1Ib3dHdUFQNmxiUFJCSXU3U01KaCtDRFBaNjhEWk9GMGNiK3I3?=
 =?utf-8?B?ZXdTSCtJbG5GZUU1OW9DTGRMejNFbHhVL01ZUk4vWldPRnkrOXB6TXo0N1Vw?=
 =?utf-8?B?OURVdzRIVkdYTDFDK3JkOEtSNWRHY0ptK1U1YzZSRFZocDhhYlV0SzZab1FD?=
 =?utf-8?B?ckpZdjYzd2ErS0xkeHRNaWZWOXd5UmJqZ1R6OE9LeEovRkxiODJvYjJVODBW?=
 =?utf-8?B?U0taS1M3UlkvaVNBc3N0Q2Rud0FSS1ZGTGI3V0JWRzZtUEZQR0dDNDBOZXp0?=
 =?utf-8?B?ZmtIdGlqeFduOEp2UGluVG9HMkJUZXgwaUhxOHpKWmVEME0xUTZ4Szl6WWF5?=
 =?utf-8?B?VGFoWEt3dkVVK2JGSDVSck9jc1l4TkQ2MTl2a0c5NkVOVUhER09PL2ZkcGFz?=
 =?utf-8?B?Q3dxemtnSzV4SXlOZUNrL3NySFZyWjhZSFppRGNzWURkUzZZc2phNlh1bk93?=
 =?utf-8?B?K3pyRVl3UHExL2J1WVd1VWFkNU5YdW1PbE5LYlBOS0hQemdZVFpJdTRTYVRP?=
 =?utf-8?B?Tk5RcDVIdGFpL3RkMDRhYlBUY1FpZC95SG1JTHVLeGI5SXdIRm4wSmVHNHlh?=
 =?utf-8?Q?oykbFhhCOdc/XXlvG3lUtYT5PuGuPzQg6t+Ro94iBFIg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f4e912-7430-453a-1d4f-08db4593528c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:45:25.2700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wzPxfKKf4e/YnGjR+iauDd5MG1dQ6k2+6x5VNSrgvSFN1GhucAGCiImx+COeBJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

Am 25.04.23 um 15:10 schrieb Shashank Sharma:
>
> On 25/04/2023 14:27, Christian König wrote:
>> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
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
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 
>>> +++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>>>   3 files changed, 89 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index 333f31efbe7b..e95fb35b0cb5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct 
>>> drm_file *filp, union drm_amdgpu_u
>>>           goto free_queue;
>>>       }
>>>   +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
>>> +        r = 
>>> uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>>> +        if (r) {
>>> +            DRM_ERROR("Failed to create/map userqueue MQD\n");
>>> +            goto free_queue;
>>> +        }
>>> +    }
>>> +
>>>       args->out.queue_id = queue->queue_id;
>>>       args->out.flags = 0;
>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>> @@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct 
>>> drm_file *filp, int queue_id)
>>>       }
>>>         mutex_lock(&uq_mgr->userq_mutex);
>>> +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
>>> + uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>>       kfree(queue);
>>> @@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>>> void *data,
>>>       return r;
>>>   }
>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>> +
>>> +static void
>>> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +    int maj;
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>> +
>>> +    /* We support usermode queue only for GFX IP as of now */
>>> +    maj = IP_VERSION_MAJ(version);
>>> +    if (maj == 11)
>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>>> +}
>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>> struct amdgpu_device *adev)
>>>   {
>>> @@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct 
>>> amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>       userq_mgr->adev = adev;
>>>   +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index a56c6e106d00..9f7b14966ac8 100644
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
>>> @@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version 
>>> gfx_v11_0_ip_block =
>>>       .rev = 0,
>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>   };
>>> +
>>> +static int
>>> +gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
>>> +    int size = gfx_v11_mqd->mqd_size;
>>> +    int r;
>>> +
>>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>> +                    &mqd->obj,
>>> +                    &mqd->gpu_addr,
>>> +                    &mqd->cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    memset(mqd->cpu_ptr, 0, size);
>>> +    r = amdgpu_bo_reserve(mqd->obj, false);
>>> +    if (unlikely(r != 0)) {
>>> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>>> +        goto free_mqd;
>>> +    }
>>
>> This reserve/unreserve dance here doesn't seem to make much sense. 
>> Why do you do that?
> We wanted to make sure that the MQD buffer is reserved until we fill 
> it. Does it sound incorrect ?

Yeah, that sounds strongly like we have some misunderstanding.

Reserving a buffer is needed for two thing:
1. Prevent that it moves around.
2. Change some parameters of the BO.

Since the BO is a pinned kernel BO neither of those two use cases seems 
to be the case here.

So why do you reserve the BO here?

>>
>> Christian.
>>
>>> +
>>> +    queue->userq_prop.use_doorbell = true;
>>> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>>
>> Are those the only two parameters needed? If yes we should probably 
>> drop the userq_prop structure and give them directly.
> In patch set 1 and 2, everything was getting stored directly in the 
> queue, but then we decided to re-use the existing init_mqd() functions 
> from each of the IP engines.
>
> If you see the prototype of mqd->init_mqd(), it expects userq_prop 
> structure as input parameters, so we encapsulated a subset of queue to 
> this structure.

Yeah, the question is if the init_mqd() interface is a good idea or if 
we should re-work that as well?

Christian.

>
> - Shashank
>
>>
>> Christian.
>>
>>> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, 
>>> &queue->userq_prop);
>>> +    amdgpu_bo_unreserve(mqd->obj);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to init MQD for queue\n");
>>> +        goto free_mqd;
>>> +    }
>>> +
>>> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>> +    return 0;
>>> +
>>> +free_mqd:
>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>> +    return r;
>>> +}
>>> +
>>> +static void
>>> +gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>>> amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>> +
>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>> +}
>>> +
>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>> +    .mqd_create = gfx_v11_userq_mqd_create,
>>> +    .mqd_destroy = gfx_v11_userq_mqd_destroy,
>>> +};
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 8d8f6b3bcda5..e7da27918bd2 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -28,6 +28,12 @@
>>>   #include "amdgpu.h"
>>>   #define AMDGPU_MAX_USERQ 512
>>>   +struct amdgpu_userq_ctx_space {
>>> +    uint64_t     gpu_addr;
>>> +    void         *cpu_ptr;
>>> +    struct amdgpu_bo *obj;
>>> +};
>>> +
>>>   struct amdgpu_usermode_queue {
>>>       int            queue_id;
>>>       int            queue_type;
>>> @@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
>>>       struct amdgpu_mqd_prop    userq_prop;
>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>       struct amdgpu_vm    *vm;
>>> +    struct amdgpu_userq_ctx_space mqd;
>>>   };
>>>     struct amdgpu_userq_funcs {
>>

