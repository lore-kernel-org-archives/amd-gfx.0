Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA5C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6057E10E45D;
	Tue,  7 Feb 2023 07:41:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7677F10E454
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA1ORoxjHwyYxCcUS4pXpBEDxyi7C0vZdUarOLSUfEZVbqfe4XQ6oJ021bw+GdS26wW0XtwIvs9Pl1HI3dAOyZjEZ1Offn7KmAd+VBYetSFsTqiaJ6lG6nRp7tTOouvYUdOfXbuKLKeKGNtJhg+12dWjYZtOhhc1hScwlUAFwlizVanXe0QnyhF1LmUJKN1VC6YKlY3e2t4qVlu6k41AjPaKtdbISKRkVVqMopmA1jpaIOJ1uRrDwD/+ktsKvIR0Ql6t9xM9NlcmZsTT9aFC0FBkY4KUbKjPEP1yADsB5jvTl+ZpRQEwa2RcANgAKpeIke1NoziXIHN5NAs9dqIs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csOAVuIIiO32CO2WQ63iMnZtHGQIyj7F5s4s1CytZV0=;
 b=hnwwHahieNxmgWfBYmv+H6ZtRhEYUKcFxcjR2W1QYQJM320CR5D5o/4D9bTZKzbYC33iQ9OGKuteCaI6zIFqtuptIBDU9sQ7Yqhw6j7LTR59mPUliCshhncomoqw7w0aFZT0pRVRgwxTYF3AaYsxPYYph+dwubuEc3quuRzFGxTYx99qnZMTLyByjx42mostYorjiqkRKxrwTJrRnlK8xxE8mE6b/YLn7qUShCuC+lbOzEsh4AGA51vKoHVqE0Ne8vfC/qIXEuULgi7oO3G75fHX0Una2hSeiCLZIZUdH4lYFih2fxC4D5oFcV5tltHjXGCO5qblMvfXvWUGgvpmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csOAVuIIiO32CO2WQ63iMnZtHGQIyj7F5s4s1CytZV0=;
 b=nFukiMKDCC5+C1Ha6MYDNVZwkw0IYGoFcI/32BOAZgrWg4Gx5E1Eu3xluf+edTIy+9RNliCE1Fui6vhI+B8d9rFa8nCm+FdP53XOpIYisIuHI6LLkRVgWSkHwI+dviRlRwr4bEkA8vXT4Ir9GZIKF3DKzXuGlyEuq5gbIL7Ar0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 07:41:28 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 07:41:28 +0000
Message-ID: <1ce06c26-4748-8808-a2c6-7f48eb9b677b@amd.com>
Date: Tue, 7 Feb 2023 08:41:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/8] drm/amdgpu: introduce userqueue MQD handlers
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-4-shashank.sharma@amd.com>
 <9faed914-9292-c594-1b2d-06d98864d36b@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <9faed914-9292-c594-1b2d-06d98864d36b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BN9PR12MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3a15fe-602e-46e5-f8a7-08db08deb8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpLEsBSugx/IT2srYdy2F2IjwydhmGJWVsSzvST8lI82PovngiXffWwcIOZGgNqM7a2PbHbECIvWoVr8yd1bBcpApidrhIwvmeBop5egzTW2I86FFY8Nu6BkFc6bVs3TZBZvYOjJGEmbAdkesGfOPSn5Ddi4fxq939VyNGr792WVCo2hjmgBn7qNZO8AUw8n3B7zcTl0GydSCMjq7cgjBU68+kk04wFULobOq+OGzEeVXW878Re3Q5a0TcHuFSHHno+qdmIIQaTSkOJUJRhuCu1gB1at4gQ5BrI+r66Ox4aZyPEP2jFKPP3nI6P+tLz1EEep2FU2Uu/JNBavIalPJurRAiUaZ3Qgth8BPEl0h/CUmuLf4r4drkULu03B2UPqMNNgxtCVxTJ7Sez2wZbjs8A/1oS9GJEey2iSuecfZfM99egqu5FWF1Ok9pmT7jluD4Nsgb5C/1jTHrxmXnczFR/9OrliQcLqS5KpDXkYgG8XFbP9JI3NBa7e3quYH+kznXn8/UzG08fg7RqBu+lARDohSGDZKxMokcZ+V42Vv9K0MDI8TN0vytSWCIJEFuRoYNLCm3YIULLuymaNCWoQTLz566DEfW+tSWg3ki6/+GzpbidLkYcyAi6itpWhb0kEYC2c7oCNOv07OEI0nx6biEsw5c+rKTvdE5lbin2j25ZdecAz6/82hjVX7GJu2lhvJm0NZu8yPC/lbRB7bOif4eW5QA7YPlRsQcOSoPHOiKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(6666004)(186003)(6506007)(31686004)(26005)(53546011)(6512007)(38100700002)(2616005)(66574015)(83380400001)(6486002)(478600001)(4326008)(8676002)(316002)(66476007)(66556008)(86362001)(41300700001)(8936002)(5660300002)(44832011)(36756003)(31696002)(2906002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pQdUdsT2oxMFZ2d0NISTd2bHB6T2t2S2VlZEtYdWpGbkpETllaUDZFUGxP?=
 =?utf-8?B?bjRoREpkWGRORGRuczRBdGhwZG9ldWpFQTVLcTBrd2FidHRHWlVQWmFPVU1H?=
 =?utf-8?B?cFpCenhNZ01EcVVyZWpjM3ZmTG5NQWVMY3E2YnAxU3JPdHQ0VHYrK3VtdWV2?=
 =?utf-8?B?djdlTis2R3oxRjBRRzJCcHNVSU5iZDRLNkZDSG1PcVNTNmJyODVrSVRRdGh6?=
 =?utf-8?B?Q3krT1d4T0gzR0d4V0V2N0xyMjJnL2FKbGJiVjBaYmgvRDBhL2ZzaENkVTZF?=
 =?utf-8?B?ejBRa2RURmE1REQ2Z3B4VWt5Yk9rU09SNUpkRnNWL3hQUUZGRkRsUWprQmdo?=
 =?utf-8?B?SSs4QWlaR0hGSFFRRHc3UEZqOEFMeHRjbjd3ZUxaNVVUYVR5ZWthZjN4OVBS?=
 =?utf-8?B?WEs5U0k3SkRYVENoNTNFSUlmRVU3dEhpSXIzNXJFQmIvRFY4czV4eDVhVWtk?=
 =?utf-8?B?c2Z0VEZ6YTZ5NFhWbCtPdGplek1QRVpkUndQeURlb0FSYzZwNFdGek1MbnAy?=
 =?utf-8?B?cmJ0UXVlV2VFbFBrM3BlaFdTanZ3VVR0dDdVTWNBaTdQM0dRQktjRk95MTRq?=
 =?utf-8?B?eTlRWnVxUjVDY1BQWS8zb3UyWGJFbzhuOVpESGlpdmwwTW1WWXNuZnUzelJO?=
 =?utf-8?B?RzhCR1MzamRCU0d2b0FMN3pKUHlGeDkvV3NFQnVDRTJlb3hxdFRobjBsMjEz?=
 =?utf-8?B?MHpQUm02bDZZYVloWDh3Ynd6cS90b2F6S29NNHA2K1A0WGZWUHBHcGlNRGJj?=
 =?utf-8?B?K0VObUpVd3QxSGhVakVjV2xXRHVsbk1MQVptS01NdUZ6WWlwcjh5TlBnTFZL?=
 =?utf-8?B?TThpY0FnM25GbUMvMnlOYnhMMDQvOURuenE3M0I4MFpTUUtGWUhJNGVjRjlY?=
 =?utf-8?B?SExwTmZ3eUpBa0NiTTdyeWowWmJJMllTc3VLalZvU2c4YUhlWWdIcTltSFV0?=
 =?utf-8?B?T2JvMU5rSTdZVjRIdnUvMmw2QmczZlhUY3FzZG1TVDVzRGhhZUNUbSs1TTdX?=
 =?utf-8?B?ZjB3VnlhdllMU0RCY25kM3h2eHdFVnZ1YnJhYjFLQWpDRWRPS0xvSEZ1Z0xZ?=
 =?utf-8?B?ME1rVit6R2xOdWN6K2t3SllHaC9VMFJ6YVgvSHc1SE44dktTdCs0VS8rYTNa?=
 =?utf-8?B?SWh1cDQvd3dxdDhDeU0vTTRCMUlFNk83Wi9PVmxpeFJoU0dSMW91VVFHRVVz?=
 =?utf-8?B?ZFYwTzJiN3daTk5XZHVSbHdDVnBBTWpmSzc0ZHdBOERoQi8zdW0rT3dWT2ZC?=
 =?utf-8?B?QXg4c2pOZUUwSWhidklrSDdLeVZ2L3A5Rjlxb3gxQU4yZWtQOTl5SkIxTHda?=
 =?utf-8?B?aHVMV1JNWHVOWGhDZS95UWRmY2h0bCtIek4rNUx6aWg4ZHU4c1VXR3Bic1Jj?=
 =?utf-8?B?ZEY4cFQveHcxZTJMdVQ5N3lqL0FQQnZQUUFwQUMzTzRobldpa2lxMkRLaUht?=
 =?utf-8?B?b0xvT2tqRVVlekJOVUdMdFBJVEVuMlRHQWliRzBLR1Fod2NMYnFpZ2E0cldq?=
 =?utf-8?B?YXQvOWdiYVhrWmpNUGUxNlNrUzkxakZGQWtHanNUN0l3eWRCQmg5dnRhMW80?=
 =?utf-8?B?d0dXU2dNeU95UDdyQkVpWmpOYjc2Y1l1WldiRTFOYjM5S040aTR1ZGY3WHJX?=
 =?utf-8?B?S2hEeVBEVHpsL01VaE4zRk9hSVlBcUlvUGNMMlJZTjh0cHl1NFFaa0dDR1FH?=
 =?utf-8?B?QS9RQTEzbDU5K056dWswVlVlVTJpQXVzOFI2SVZxZUFjeCticFc2SXE4NEFi?=
 =?utf-8?B?OVRNWWttRlZZdGoxMXVZOWNESnFmWFJNZjB4Rm9BcFVjV01PK0k5NGtFUEUv?=
 =?utf-8?B?cyt2TFUveXg5QmdXZS9paFl2MnpRTU40WnlMS2NWREt5aGUvRzAxOENVeE1H?=
 =?utf-8?B?d3BuckNLMGtpMHFvSmt6YlNRZnBIV0gzMVhHWHpKWE5hYis1ZWJIeXZyV0Uv?=
 =?utf-8?B?WDd1RDhzYm5CRzQrS2RmYnN1bG5vQ2Z5R3ZnamQ3UmtGMlo5eHlKSmxSWi9Q?=
 =?utf-8?B?R2JUL1FxMmtyenh2aGFobmxmbTFwcUdrMlVwVWVoNHIxdm43TndqMFFtaFI0?=
 =?utf-8?B?RDJmVzN6QXE5K2svL2ZXL0lJclRpZExtVTJlNUVNUGg4Q1BZbkdiRmJFWjhQ?=
 =?utf-8?Q?H9f7wZGzjpdwYsM9XUbD0wDXK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3a15fe-602e-46e5-f8a7-08db08deb8d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:41:28.2530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpzM42SgHPl9xTXsSnofgxeUVTUkuOaO60PHtTisjlgXBMAvyJstW5oJ4BEX2ep0HOsRHUzCtwJ80u4dGX+0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 08:11, Christian König wrote:
> Am 03.02.23 um 22:54 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> A Memory queue descriptor (MQD) of a userqueue defines it in the 
>> harware's
>> context. As the method of formation of a MQD, and its format can vary 
>> between
>> different graphics IPs, we need gfx GEN specific handlers to create 
>> MQDs.
>>
>> This patch:
>> - Introduces MQD hander functions for the usermode queues
>> - A general function to create and destroy MQD for a userqueue.
>>
>> V1: Worked on review comments from Alex on RFC patches:
>>      MQD creation should be gen and IP specific.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 64 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  9 +++
>>   2 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index d5bc7fe81750..625c2fe1e84a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -42,6 +42,60 @@ static struct amdgpu_usermode_queue
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>   +static int
>> +amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    int size;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +
>> +    if (!uq_mgr->userq_mqd_funcs) {
>> +        DRM_ERROR("Userqueue not initialized\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    size = uq_mgr->userq_mqd_funcs->mqd_size(uq_mgr);
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>> +                                &queue->mqd_obj,
>> +                                &queue->mqd_gpu_addr,
>> +                                &queue->mqd_cpu_ptr);
>
> We can't use amdgpu_bo_create_kernel() here, this pins the BO.
>
> Instead all BOs of the process must be fenced with some eviction fence.


Noted,

- Shashank

>
> Christian.
>
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>> +        return r;
>> +    }
>> +
>> +    memset(queue->mqd_cpu_ptr, 0, size);
>> +    r = amdgpu_bo_reserve(queue->mqd_obj, false);
>> +    if (unlikely(r != 0)) {
>> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> +        goto free_mqd;
>> +    }
>> +
>> +    r = uq_mgr->userq_mqd_funcs->mqd_create(uq_mgr, queue);
>> +    amdgpu_bo_unreserve(queue->mqd_obj);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create MQD for queue\n");
>> +        goto free_mqd;
>> +    }
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&queue->mqd_obj,
>> +               &queue->mqd_gpu_addr,
>> +               &queue->mqd_cpu_ptr);
>> +   return r;
>> +}
>> +
>> +static void
>> +amdgpu_userqueue_destroy_mqd(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    uq_mgr->userq_mqd_funcs->mqd_destroy(uq_mgr, queue);
>> +    amdgpu_bo_free_kernel(&queue->mqd_obj,
>> +               &queue->mqd_gpu_addr,
>> +               &queue->mqd_cpu_ptr);
>> +}
>> +
>>   static int amdgpu_userqueue_create(struct drm_file *filp, union 
>> drm_amdgpu_userq *args)
>>   {
>>       int r, pasid;
>> @@ -82,12 +136,21 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>           goto free_queue;
>>       }
>>   +    r = amdgpu_userqueue_create_mqd(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create MQD\n");
>> +        goto free_qid;
>> +    }
>> +
>>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>>       args->out.q_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       return 0;
>>   +free_qid:
>> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +
>>   free_queue:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>> @@ -107,6 +170,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       }
>>         mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>       list_del(&queue->userq_node);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 9557588fe34f..a6abdfd5cb74 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -26,10 +26,13 @@
>>     #define AMDGPU_MAX_USERQ 512
>>   +struct amdgpu_userq_mqd_funcs;
>> +
>>   struct amdgpu_userq_mgr {
>>       struct idr userq_idr;
>>       struct mutex userq_mutex;
>>       struct list_head userq_list;
>> +    const struct amdgpu_userq_mqd_funcs *userq_mqd_funcs;
>>       struct amdgpu_device *adev;
>>   };
>>   @@ -57,6 +60,12 @@ struct amdgpu_usermode_queue {
>>     int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>>   +struct amdgpu_userq_mqd_funcs {
>> +    int (*mqd_size)(struct amdgpu_userq_mgr *);
>> +    int (*mqd_create)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>> +    void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>> +};
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev);
>>     void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>
