Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39284C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 08:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEECE10E463;
	Tue,  7 Feb 2023 08:13:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA8810E463
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 08:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQRe8T+nhLpSC2jIUmtoec59YOnw5qIiOzFJJUitvNtO2HxyOM9vHtIPsWuZr9Ag/sMgsP5J/SYZYS3uRK/dffhdzpN4X01gUxlDZoT8JDcsAq7wdkqRW2btCv8R/rXvyz6MKkzuECE8pjMXciH5ylkT/jM7lI8LBYxu64iE0C+coUvFGyIVi8JMdAEWU/EA0KYJmP+5mGPKuYXF0Mw0z4S+OIkaqnLkXSDnHR3kZYNkTGCd2LtSoggsDGe/Y6bfWwfeBuQJhu08QnMXlE6/Io8M0cI0hP9WrSjuRkTDfVIVlS8w8hHm/MzAajslztjc0zjNaJtDHKrxCQ3BUKYFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oanuZ262SV9znZ5vb8rljBmbYOfBG20LGzv7zhwoW7o=;
 b=PWQVUXmVPeywo1l8BsVeQVYFhYTPp1aDBNtpArm1Rg7IoO26HpnvpXO/5fIV1g7sGR2yacshscBtjUaZO6bBOXdSDCDcQnuFIdvqj9XKKoVngHx45FW4FN781hmall8hJ5DhcrPSHn7LeN7rrzySegDLMpaH+m7V+ATre/utRwcUOTtd2c3/DdQmYvqYrgjpFVueR2tP0ZH3gkrYdmBGA+QVND8Vbx7upBfQUE2pRnH0cOOoLie98IYv2xIyipUYrD7FNX7bffE2i4MP4Dic+vG05NBkvuWK/zzhLE/olLeuqK2jGe9JyVtx/Sol+BUJdlKLAS6fTaFgDOmUWfLGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oanuZ262SV9znZ5vb8rljBmbYOfBG20LGzv7zhwoW7o=;
 b=OR4Cx/OOixyYUxnNpbgtgZE1h7Xab4Er/qjXfD3sMXGzylFPMbZQ8NhpQp2sTMHU+7dQE6XiBVpCSZtHt7pSnSWAzuLHkrVXliU9uQcVa7VXrG/8ZNiKy04Fflg/Pllt9G5F8m0PRkGDUgnNKWFMqHUlUw/+u1+XOcfdpKFCGWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 08:13:40 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 08:13:40 +0000
Message-ID: <3e6516de-eebd-aa51-d2b3-087356da65d6@amd.com>
Date: Tue, 7 Feb 2023 09:13:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/8] drm/amdgpu: Create context for usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-6-shashank.sharma@amd.com>
 <240a5ab8-6743-4588-4a73-17f2ea894f1b@amd.com>
 <43c2b1eb-dd09-6a55-c252-b59176293b93@amd.com>
 <8186d839-3966-257b-d06d-160a2ab06c05@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <8186d839-3966-257b-d06d-160a2ab06c05@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 04643225-67e5-4bdb-a491-08db08e33867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFks+tCIYSC0Qt2wQa5n1XL+XDGxGOu4hlV1SuJeKqDbpO/HYy6jNJ2q0D1tslix+60MQmmCyuBFQWaB9nkLqDmDUc6PDyG0HA0He4qCGHZVUMYpOim1zPYYYxv7KFs4u3XjCGmtd8DH1Nn/S/Ikzqmk9bo1jBx4HIPw7r/ETW0oM7w/4AKzH0Sxu0NFy4LEynem8874StxvGnHv//qkujrJnrK96AHFYuBeDM/mag0bNUZsAUBhFrvG1Vrp60F9TKT4EI4T3fwu7Ceitm5DVL4ifYvBN6VqLbXsrkxgFKYjRVjWBKL94hKHLV2mW5KDs4pPRNhwxL0RKfHfvkDp4PKgElbtvck8MA8T3NwVH8l+cM2TIZmu3JI98j2YPNc4kUUeZU+35/lW8kdTGXVMKqmdghZGmIBxlpk2nUpAGC8Du1xXB7enr5ugWQCsYzJecGIFYwlpf8ZniRLVrNby+ndZHYxbkhrudunSY9O8VoifMtjlIA78JYKlAh6yfpxstUwnj9EJkNwpWwHneEZzbozmTKuiSW/JSlY8l3WEnHhkOsivrZ9ptJ+T8j9QNfOCru/nGwp9DwDxbFvZyoQEY0DVYf8pqF00JfThx5b0Ms8n/4VUMT0+80Yk0v/XA5w7MdBS5lA23DifYLSd869NOi9R3FlYOVk25Lmy1RX+VjYVZq5XTIyu7Py/gzx/Fi8vPGG05ELH+IdvuP0EZixoOWkVAdlJle6axzOdaxND7yI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(38100700002)(66946007)(83380400001)(316002)(8936002)(66476007)(4326008)(66556008)(8676002)(41300700001)(2906002)(44832011)(5660300002)(30864003)(2616005)(53546011)(6506007)(6486002)(478600001)(6666004)(6512007)(186003)(26005)(31696002)(86362001)(36756003)(66574015)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjA2OG5hWTU1YkkwbjZwTUg3UkhmTjRJOWhyQ3VMRjUxYjd1eW00TmZJNG1F?=
 =?utf-8?B?WDNnV2FTeG9HOWN2bTBCeXpIYnUycS9uSk1UQnJHcmoxRVNIbVlUWjhpckhh?=
 =?utf-8?B?cmpLT09BTTQ1Q09VRHo3VFBZY0o2ZUxCUm5MVnVZR0E1ajJLRkI4VFh0dlFG?=
 =?utf-8?B?QitDTmFoREhNK0RrQ2VWaHkvZzI4ZGlqamNrVEdoUnhFdXNNQUszUXJ5QkM5?=
 =?utf-8?B?emRVQWdUdTA1TGkxTFRqK0NkR2lFbC9mWm96dWJzSmExcUJCTzZkSWl2NnZ2?=
 =?utf-8?B?QW9DdmVaTVpDTVR3WHJPcU1HbzhIenhobnl0bHhCV2x4VTNGZ0pCWkZtdFMw?=
 =?utf-8?B?c3ZVWlU5aUdZc0NKNXZScXAweXByemY3aC9YTFo3ejZUOE1pRUhDWTJLVkxk?=
 =?utf-8?B?VG5xSkd5TU81eWp2RHl5bGFMQStZQ3JzTTRXK2JCU05wcndua2R5SWMxeVJW?=
 =?utf-8?B?NmFoRWJCZkhwclVzaEd4ei9wOUMxc3lTSm9NU1IvUHNaT29HNWowZ3Q4R3ZU?=
 =?utf-8?B?NTVpOG14OU43K1UvKzdOTkJHOGlBYi9KUENtWk9Pa1FkdmNqb2RvV2tUUnlE?=
 =?utf-8?B?MU9uLzFLd1loeWpqL2s5QXplTXBlNEJRakdnUlNsY1dHK2YrRGppaHNIMENm?=
 =?utf-8?B?ejhUU28yeWszWjF1RkRnOFlXSC80UjErK215R2VXQXIwZ0IwNW56T1NINGxn?=
 =?utf-8?B?anYxRTdmcE4wd2lXSCt4My8zd3BiYko4UjVRT05DRVNyYzZaUkNnMkpVUXVx?=
 =?utf-8?B?ZW1ndmtBVGdGQjRZYjh2K1NvQ1hsaXdqRnlHYWNMNVFLdFlMSmMyOGpIRTB3?=
 =?utf-8?B?emZxcE9sODUwMmh0RHpsRXZnZzA4N0p3SXNqb3BzckZES0NiYlBLWmU2RVJH?=
 =?utf-8?B?S0o3Z2VaMWw3NTg0MlZGZGV3Q3RiMGxzQVZTVk1KTmRmZmwrQ0FTTEp6dmVa?=
 =?utf-8?B?VDdSallyV29yVS9CcXFWVkYwdnpjMDV5Y1B5R2k1ZXRHSzZLVXNYTjJkZVpY?=
 =?utf-8?B?QTBQKytKNTlHSVNWUGNkTWcvRzZsb0YxNHFqTWJrSjBnMW1kR0JCbUxRV1R0?=
 =?utf-8?B?UUR6QTR4ODk1bFBSQ25lZ3VPUFFlUWs4ck9DTkttZzZaSzhzMnBLL3NlMHIy?=
 =?utf-8?B?Sms0UUxaNzFUd2ZtQktpeFE0a1hzdGdIL0J3bmY1Q21rbnNQaE1pWWo0NHlW?=
 =?utf-8?B?L1hCSnY0dzR2Yk5KaDNQRGk5c3p1Z2kzNlJYcld2aCtQQzRqZ1ZnQlhpOHZq?=
 =?utf-8?B?a25xVkd6UjNaS0tURVFESldlc1lRb2pVSGRPUGZPZHQ4cG54RWM2QXROT01S?=
 =?utf-8?B?a0htWFBQVkJwS3pSUStFYWtFNHdoaE9GSWExR2dFRG9Tb28yV0FnMy9rVmxV?=
 =?utf-8?B?THFkaE5DS3JidnU3ZXdDSi85MVpNelpzOExlek40Rzk5TVRsTlpRTnJXaUkv?=
 =?utf-8?B?WVY4aXY2NDlSYWI3Mzh2Unh4amdsa2RVYXhteHpnY0JkRlE4Um5qS0U0NVBl?=
 =?utf-8?B?Q2lZZkFZbUkrL2tXNlN4V1NyeDlxK1ZVYjZtbXA4WHFEZ1N4K012VFV5eGM1?=
 =?utf-8?B?cTFMa0Y4SE9yR3JoQjJHL2xXOFpuOWdwU1h6VFpYM3ZZb0E0ZDhqTFd2bWh1?=
 =?utf-8?B?SkhDallSTTdUN0NHd0s4bmFTTzZrL1NiVW41VGxFM3ExVUwyQ3V4VEZuYmZJ?=
 =?utf-8?B?V1pqcDZ4UVozRjhEV0N6cmQ0Vk9taGI0TmE2dWIzeitvL3oxaDNqVFBDRDZE?=
 =?utf-8?B?d2d3NWIyK1ltaXVpem5CNndqSnhwT3lLZUlucHBFUnYrOEVONW5DUDJrMEgr?=
 =?utf-8?B?SjI0c0J3eHVHeWl4UmFPblUveVdpM3BQZ0xEWWN6bkZhd1F0U21aZmZ5aWZz?=
 =?utf-8?B?VHk1Tk9IVWlraGs2YW50WWZtK0QyMnBHUDIvMnM1NXNiZnNyNGVxUGJ0KzRS?=
 =?utf-8?B?TkRxejdQVUFNQ1g5MjRXRGs0Z2JCSlpqakNHZnJNcEo3TFRYcitmMDFHQmIy?=
 =?utf-8?B?a25QZk5DWHQzTEVETUVzTlUzejMyZFl5enhqYitXa0tOOHZVZzZmR1JaWFcy?=
 =?utf-8?B?OGRYZ1BVeGJ4T0JVRlJUOFFDUDN1SlpFU2xkM0w1K2dldFVkS0FwejlCRktO?=
 =?utf-8?Q?f8hQDqGwS/Glb1ZOvwgvCpXjz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04643225-67e5-4bdb-a491-08db08e33867
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 08:13:40.2783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH1PR3oao2fIObAChdpHohJfFpiMoHrOztGiT7MiNB+fZ1HZiZBf22jhB1vop7kMgXmiqlhOGSBac+bG170w8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 08:55, Christian König wrote:
> Am 07.02.23 um 08:51 schrieb Shashank Sharma:
>>
>> On 07/02/2023 08:14, Christian König wrote:
>>> Am 03.02.23 um 22:54 schrieb Shashank Sharma:
>>>> The FW expects us to allocate atleast one page as context space to
>>>> process gang, process, shadow, GDS and FW_space related work. This
>>>> patch creates some object for the same, and adds an IP specific
>>>> functions to do this.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  32 +++++
>>>>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 121 
>>>> ++++++++++++++++++
>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  18 +++
>>>>   3 files changed, 171 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index 9f3490a91776..18281b3a51f1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -42,6 +42,28 @@ static struct amdgpu_usermode_queue
>>>>       return idr_find(&uq_mgr->userq_idr, qid);
>>>>   }
>>>>   +static void
>>>> +amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                                   struct amdgpu_usermode_queue 
>>>> *queue)
>>>> +{
>>>> +    uq_mgr->userq_mqd_funcs->ctx_destroy(uq_mgr, queue);
>>>> +}
>>>> +
>>>> +static int
>>>> +amdgpu_userqueue_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                                  struct amdgpu_usermode_queue 
>>>> *queue)
>>>> +{
>>>> +    int r;
>>>> +
>>>> +    r = uq_mgr->userq_mqd_funcs->ctx_create(uq_mgr, queue);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to create context space for queue\n");
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static int
>>>>   amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, 
>>>> struct amdgpu_usermode_queue *queue)
>>>>   {
>>>> @@ -142,12 +164,21 @@ static int amdgpu_userqueue_create(struct 
>>>> drm_file *filp, union drm_amdgpu_userq
>>>>           goto free_qid;
>>>>       }
>>>>   +    r = amdgpu_userqueue_create_ctx_space(uq_mgr, queue);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to create context space\n");
>>>> +        goto free_mqd;
>>>> +    }
>>>> +
>>>>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>>>>       args->out.q_id = queue->queue_id;
>>>>       args->out.flags = 0;
>>>>       mutex_unlock(&uq_mgr->userq_mutex);
>>>>       return 0;
>>>>   +free_mqd:
>>>> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>>> +
>>>>   free_qid:
>>>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>>>   @@ -170,6 +201,7 @@ static void amdgpu_userqueue_destroy(struct 
>>>> drm_file *filp, int queue_id)
>>>>       }
>>>>         mutex_lock(&uq_mgr->userq_mutex);
>>>> +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>>>>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>>>       list_del(&queue->userq_node);
>>>> diff --git 
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>> index 57889729d635..687f90a587e3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>>>> @@ -120,6 +120,125 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct 
>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>>     }
>>>>   +static int amdgpu_userq_gfx_v11_ctx_create(struct 
>>>> amdgpu_userq_mgr *uq_mgr,
>>>> +                                           struct 
>>>> amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
>>>> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
>>>> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
>>>> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
>>>> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
>>>> +
>>>> +    /*
>>>> +     * The FW expects atleast one page space allocated for
>>>> +     * process context related work, and one for gang context.
>>>> +     */
>>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_PROC_CTX_SZ, 
>>>> PAGE_SIZE,
>>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                &pctx->obj,
>>>> +                                &pctx->gpu_addr,
>>>> +                                &pctx->cpu_ptr);
>>>
>>> Again, don't use amdgpu_bo_create_kernel() for any of this.
>> Noted,
>>>
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", 
>>>> r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GANG_CTX_SZ, 
>>>> PAGE_SIZE,
>>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                &gctx->obj,
>>>> +                                &gctx->gpu_addr,
>>>> +                                &gctx->cpu_ptr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate gang bo for userqueue (%d)", 
>>>> r);
>>>> +        goto err_gangctx;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GDS_CTX_SZ, 
>>>> PAGE_SIZE,
>>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                &gdsctx->obj,
>>>> +                                &gdsctx->gpu_addr,
>>>> +                                &gdsctx->cpu_ptr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate GDS bo for userqueue (%d)", r);
>>>> +        goto err_gdsctx;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, 
>>>> PAGE_SIZE,
>>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                &fwctx->obj,
>>>> +                                &fwctx->gpu_addr,
>>>> +                                &fwctx->cpu_ptr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate FW bo for userqueue (%d)", r);
>>>> +        goto err_fwctx;
>>>> +    }
>>>> +
>>>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, 
>>>> PAGE_SIZE,
>>>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>>>> +                                &sctx->obj,
>>>> +                                &sctx->gpu_addr,
>>>> +                                &sctx->cpu_ptr);
>>>
>>> Why the heck should we allocate so many different BOs for that? 
>>> Can't we put all of this into one?
>> If you mean why don't we create one object of 5 * PAGE_SIZE and give 
>> 1-page spaced offsets for all of this, yes, that would further 
>> simplify things.
>>
>> The reason why we kept it separate is that these objects could be of 
>> different sizes on different IPs/platforms, so we thought defining a 
>> separate
>>
>> size macro and object for each of these will make it easier to 
>> understand how many FW page objects we are creating for this GEN IP. 
>> It can be
>>
>> either ways.
>
> But this is completely uninteresting for common code, isn't it?
>
> I strongly think we should just create a single BO for each queue and 
> put all the data (MQD, gang, GDS, FW, shadow) in it at different offsets.
>
> This handling here is just overkill and rather error prone (BTW you 
> used AMDGPU_USERQ_FW_CTX_SZ) twice.
>

Agree, we will fix this.

- Shashank

> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Christian.
>>>
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate shadow bo for userqueue 
>>>> (%d)", r);
>>>> +        goto err_sctx;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +
>>>> +err_sctx:
>>>> +    amdgpu_bo_free_kernel(&fwctx->obj,
>>>> +                          &fwctx->gpu_addr,
>>>> +                          &fwctx->cpu_ptr);
>>>> +
>>>> +err_fwctx:
>>>> +    amdgpu_bo_free_kernel(&gdsctx->obj,
>>>> +                          &gdsctx->gpu_addr,
>>>> +                          &gdsctx->cpu_ptr);
>>>> +
>>>> +err_gdsctx:
>>>> +    amdgpu_bo_free_kernel(&gctx->obj,
>>>> +                          &gctx->gpu_addr,
>>>> +                          &gctx->cpu_ptr);
>>>> +
>>>> +err_gangctx:
>>>> +    amdgpu_bo_free_kernel(&pctx->obj,
>>>> +                          &pctx->gpu_addr,
>>>> +                          &pctx->cpu_ptr);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +static void amdgpu_userq_gfx_v11_ctx_destroy(struct 
>>>> amdgpu_userq_mgr *uq_mgr,
>>>> +                                            struct 
>>>> amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
>>>> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
>>>> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
>>>> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
>>>> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
>>>> +
>>>> +    amdgpu_bo_free_kernel(&sctx->obj,
>>>> +                          &sctx->gpu_addr,
>>>> +                          &sctx->cpu_ptr);
>>>> +
>>>> +    amdgpu_bo_free_kernel(&fwctx->obj,
>>>> +                          &fwctx->gpu_addr,
>>>> +                          &fwctx->cpu_ptr);
>>>> +
>>>> +    amdgpu_bo_free_kernel(&gdsctx->obj,
>>>> +                          &gdsctx->gpu_addr,
>>>> +                          &gdsctx->cpu_ptr);
>>>> +
>>>> +    amdgpu_bo_free_kernel(&gctx->obj,
>>>> +                          &gctx->gpu_addr,
>>>> +                          &gctx->cpu_ptr);
>>>> +
>>>> +    amdgpu_bo_free_kernel(&pctx->obj,
>>>> +                          &pctx->gpu_addr,
>>>> +                          &pctx->cpu_ptr);
>>>> +}
>>>> +
>>>>   static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr 
>>>> *uq_mgr)
>>>>   {
>>>>       return sizeof(struct v11_gfx_mqd);
>>>> @@ -129,4 +248,6 @@ const struct amdgpu_userq_mqd_funcs 
>>>> userq_gfx_v11_mqd_funcs = {
>>>>       .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>>>>       .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>>>>       .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>>>> +    .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
>>>> +    .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
>>>>   };
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> index a6abdfd5cb74..3adcd31618f7 100644
>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>> @@ -25,9 +25,19 @@
>>>>   #define AMDGPU_USERQUEUE_H_
>>>>     #define AMDGPU_MAX_USERQ 512
>>>> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>>     struct amdgpu_userq_mqd_funcs;
>>>>   +struct amdgpu_userq_ctx {
>>>> +    struct amdgpu_bo *obj;
>>>> +    uint64_t gpu_addr;
>>>> +    void    *cpu_ptr;
>>>> +};
>>>> +
>>>>   struct amdgpu_userq_mgr {
>>>>       struct idr userq_idr;
>>>>       struct mutex userq_mutex;
>>>> @@ -52,6 +62,12 @@ struct amdgpu_usermode_queue {
>>>>       uint64_t    mqd_gpu_addr;
>>>>       void         *mqd_cpu_ptr;
>>>>   +    struct amdgpu_userq_ctx    proc_ctx;
>>>> +    struct amdgpu_userq_ctx    gang_ctx;
>>>> +    struct amdgpu_userq_ctx    gds_ctx;
>>>> +    struct amdgpu_userq_ctx    fw_ctx;
>>>> +    struct amdgpu_userq_ctx    shadow_ctx;
>>>> +
>>>>       struct amdgpu_bo    *mqd_obj;
>>>>       struct amdgpu_vm        *vm;
>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>> @@ -64,6 +80,8 @@ struct amdgpu_userq_mqd_funcs {
>>>>       int (*mqd_size)(struct amdgpu_userq_mgr *);
>>>>       int (*mqd_create)(struct amdgpu_userq_mgr *, struct 
>>>> amdgpu_usermode_queue *);
>>>>       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct 
>>>> amdgpu_usermode_queue *);
>>>> +    int (*ctx_create)(struct amdgpu_userq_mgr *, struct 
>>>> amdgpu_usermode_queue *);
>>>> +    void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct 
>>>> amdgpu_usermode_queue *);
>>>>   };
>>>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>> struct amdgpu_device *adev);
>>>
>
