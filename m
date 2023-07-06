Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38516EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AEF10E3E6;
	Thu,  6 Jul 2023 13:37:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC8410E3E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXLECDcVbtD1Gq6lW6w8WH0Mna17Un9i7ahtkhXMquXKBHlN2XFLpFpN6IdRxpq6WZurGqzejI4WyhUE6W977Ahak3+cHllA5t/SSsQ7zvCKYQSDnOY7/mp2sBOpMgaAPKChWxAmYRxsiiN/sqJScxZvG7Ka36AVfF1KkzgXXzJbw1+8rfIcbMxutzrnXYg8AJBKpkLG/JzTwIit9bDDTwe+/0kAlbMlsVPqVji+rhltk9Qr8PRgscqdPJ71sLztX5IwOBhtm6Sb6UFDG6XUm2mlrNZjR+xnXSe7VGTr1WUg5GBWLOS57eC+5lj1djXUddBlnWT0QZC+QJUDV+ApHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A2RQhyPJxLq3RT0Kp0NeMqJbfIHTgLrN/FajvnMECI=;
 b=g2Vyrz5D82aBRMlQbtsMWas7Ej9tydxjBnYNF1CedPMljrGCFV4pFLWQrW7qF/mgcHALMu6TpQ94vtCOabf0F88cdyZGjfQDOUSLozz5NjY9CNvtJujQsqinfiFT8pC7o1PprBe2S7iRGUgazs1aKzes59KPMPO0R6lbnE7E0TAmD2JFJ3h6atMg2QUh8ramdzcyiVm33ULKl2Uj7S/RyoqLe6JjxLbFewULV9mbZ0OCco/FjV6L7JPpVsj+T5qub3eB/GoxPjCkbgJRKOXI4CwnRNZtGinAHM/wda6PYk2WM7oBG+v4wJAxmqhQqJBOiZVjEmepGGOfa8s7GTT5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A2RQhyPJxLq3RT0Kp0NeMqJbfIHTgLrN/FajvnMECI=;
 b=aOTq4doFOOx4R0N1CDSGzZXXKcJj1mnM8Q0nQGwsgxwuv3WyQlabeCto1wrOCpOQ9dAg+VKDqPq/Vxu83l97a9AXrr6auJS8tNp99DgiXb8cfoWZZAlT8TEoB5rbhxlFZwyehv1RojuXToGc7w4YVjIhn2fEJFzt0YsMcXmbFgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 13:37:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:37:10 +0000
Message-ID: <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
Date: Thu, 6 Jul 2023 15:37:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: ac814893-64a8-4a08-4a2b-08db7e26194b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMY/IdY0C0izJbJxwgE3FAprMPurN19zrepTFsXnBcssRyZzj3ByTTSlWbrTCfcrbOLmwqEKbsuEYCTm/p5Bzukqy7mIrfhznmLZcoiwRJ82M/jgHsexsLz4BL3PPAnJFP0tjrUHnWTa+kCHVKjPElcNDz/4aiUWa+67MlyCVpfV3DTz//3gG8RRj1oaG/EtBBEeSDvFJ3UApvu9wnBqFUKTzFcmbe9wYKB28uvWm811Z1gkIYcUINssUVohbq2jMBYiF1Lwv3LDb3W2VCeYaOIqb62yVBZt1nJctqrI25ZQJtHjdBi/j4qz1Nc7iMJ5gJpgpA/Zq7dIa0nlx6ziuowiptWOyQRoiKu8suR0vmqwAcqb9IN7tI76uYjl7deU36gnfOE3b42PwSlae+tSe2DtSoDq8jxKJ7UxB0mwfZ4Q5Q9oIuBUi6ApUUgcqFOVcrDcWKAcG+MdhA8YgKGUDXIC6JyaeaoElTtMUt8c80+OgploEH7vhbHZoeOLmb2ZtmPluI5Adul8KE0K6ivncfM4PogS/9ZGTsom7vyZ0Z/icUGmumYS7QujKu9Y0lHOfdHEXDk9n8JgS7PBPBtNMoxtmYNEiZyvGqcM/O3HOAn2A66bBWMgbtQQT4gof7ccsvwO++sRgcszyCK51oG1bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(26005)(41300700001)(38100700002)(6486002)(83380400001)(2616005)(53546011)(6506007)(6512007)(6666004)(31696002)(316002)(36756003)(66476007)(2906002)(4326008)(66556008)(8936002)(8676002)(31686004)(86362001)(186003)(44832011)(66946007)(478600001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0pvWlNPYVdxOW80dnphSnFYaExuSmp0Z09Oc2V1bzZPbDluZFFSby9UYUF2?=
 =?utf-8?B?RStWTEtJcHhuaHM1Rm5KZkV1WXRIelA2aGxPejR2T0prb2Q2WDBuVFFOcW9G?=
 =?utf-8?B?NWlraDJELzFTOVJITkdQRXFkbUkxVkVTU1ArNk43RnIvSUZzSFdBNTc5U3Nn?=
 =?utf-8?B?NU4xcGhOUzdxODFZSFhCTVBVYjhzRWtTTjdYWUhhNXVGYkphS0w3a2JWeE5t?=
 =?utf-8?B?ODdFZFI1eUQvSkxMVThrVlpjL1JITUZhYkpvNWlDVndJOC9aQklETkVodHdo?=
 =?utf-8?B?SzA3SjVSa2ZxL3ArOGgrZDA1aU1ZbE1WTFZVRjFtVlBDSWVHWUE2UjhFZlRS?=
 =?utf-8?B?d0xHN3V3UFIzaVA4a3dQZEtOTUt3ZnFVanU2M09BNEtQVUhvalhKaEoxRWNx?=
 =?utf-8?B?cnFMMkx1eHdQVnZLTU9WeUVmd2VkaUpnSmw0SkJyVHh0NkhXSk10UnUzcFlP?=
 =?utf-8?B?TzRCM05KclJ5UGFLc2lPelRkUERzdlNPcTQ3NG8zNWQxazNvdmNCUjNETGk1?=
 =?utf-8?B?SjlhUEF2alRkc3N1YVVoNzdDaFlBNy9Ea1dzRnI1ZmM0Z0NFczYyc3FjdTVz?=
 =?utf-8?B?aEtXa1hHS0FxallLblRvMk1aeS9RUFlmY1VQVFR4NlEwSnk0dDBzcGwvaU5R?=
 =?utf-8?B?cmFVRi9JZ3IySFdiVjlNVVpnNGpLTWc0d0NyYyt5QWl5ZFNWQ2lIRkx0aFFZ?=
 =?utf-8?B?Z2dNaHMwN2VTSXZZdkJsWU1FdTJ2Qm1ncG9MZjNyUXd0dlhoYWRCNllGTWdr?=
 =?utf-8?B?c0E0WXMvNUNmUDJzejU0d2svaVR2ZU02ZkczN3lzbXE3cTlWRmphUjZUWTBV?=
 =?utf-8?B?UkM3eFhtL3ZrWmRFRWc5Z0pOY0JXVXd2M3BqVXhJVGlsK2gvcUVTZFNlZ2w1?=
 =?utf-8?B?YlRwaUtXTEY2Wm5iNXpPeHp5ZXIzdVZMVlVFNFhyVVg0c1IwWDNkODYyVFdn?=
 =?utf-8?B?SWNRK1J6emhYSC9ZMXAzZkIyVW0yVTNLdFJJa0dnTGpoNkZlTW5CQXluUnFv?=
 =?utf-8?B?MVR0amdFT0ZDTW9mQW5Vc2kvdlgrOTNMVUVhRzMvVEZRZ2ZxRmJhOGhoOTlt?=
 =?utf-8?B?akZEL1ErQ2xxMk9TNGM4OTlBZy8yNmljUGVYejZJMkNPVGJqeVVOS0tMZFEw?=
 =?utf-8?B?aCtNTGxrZWY4emhYU1RSeDlrN2hYZXY2N1liTUhnNXFuVitnb0k1YU14QWNW?=
 =?utf-8?B?OGx3M1RVUloycGEvNUFPb3d3NUpWcldKNEdCQjR5VlUwSnl5Nzd0YVdHbzFI?=
 =?utf-8?B?WGxaZXZYNE4weGtYcGdBOGwxd3g3clhUeThSY3E1WjU0ejBIZzk2azhGc0Nh?=
 =?utf-8?B?c0RMak1JSnpVS1ZUdmpCZHRqS2VhRHgybEhJREpQVkIyZVJxRU9PMFc5b1Nx?=
 =?utf-8?B?c3pLVDE5alY5L0ZkWkRVUGpiOVl3cTN0NG5wYTlZaWpVemxPT1E5Lzkzc29n?=
 =?utf-8?B?aS9JRlFxRjhDSE5OMGluakN2eUtrVWttelRtZ2FHUHhDcWFEcnpoSGlZQ2o5?=
 =?utf-8?B?WjYwQm0rM2lvRDZaWks5OFZOQ3N6eXE3OVRhMmtNSVFkZDczeUFiSjltc0gw?=
 =?utf-8?B?QU4zczV5aWdrY2Q3c1puVzQwOSt6NHUwcUZJZ2lyV3lIUm8xanVDUmZsSE85?=
 =?utf-8?B?YWxDUTM4bk9iQk5hVUJ1UCt6WWdSUGlvOVNvVU00RlFBUDRKcTVVVFZDdjh0?=
 =?utf-8?B?QWtRSkFEWFRzMWp4NjF0ekRNcWs1YS9LQzl4R2FiUng1Y0M3RS84NW92OFFR?=
 =?utf-8?B?Z2JRMG1QMktMcHIwNzVsOFpSS2lPV21yVCs1UGhJeUxLbmsrMlBVYmI1TlJ6?=
 =?utf-8?B?d3F1TUxDY2RvV3JYRXBpRzN5L1lyaWNpaWt6cGVmR3VXeGJ1ZHVCNzIvWVpt?=
 =?utf-8?B?WWdXL1N2azI4dERHMFZsVUZmQWxhRFhBb1JBMXN3L2dMSFgxdi95M0U1c0tW?=
 =?utf-8?B?Y2JyZEJ6bnZlYzBXOXAxMjJBU2RMS3hBOE9zZFlYQ3hFb09rS240MmorS2Fi?=
 =?utf-8?B?T2lxM1pSMU5xUlI3YURPNTIrRkJKRW00YVlhM0MzSkE1K0VtQ1FKN25DWGdK?=
 =?utf-8?B?blVJeUlncHRtZm5jMlRvRGxFejNkOERwc1BXSHkzSHZFR3pDZ3NuQTFIM0hC?=
 =?utf-8?Q?bdoHZ21TxZhrisi7r/Rlh+YZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac814893-64a8-4a08-4a2b-08db7e26194b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:37:10.2480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGD+pJj/6+LkYiWBX3tpFY20tE55xNVvg7OTVwM7+BATE5hQDHegFT9PbPR9gbbj+Q9xD1Jh0+TNVERj7FhO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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


On 06/07/2023 15:22, Christian König wrote:
> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    GFX-GEN-11 IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>> V5:
>>     - No need to reserve the bo for MQD (Christian).
>>     - Some more changes to support IP specific MQD creation.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>   3 files changed, 96 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index e37b5da5a0d0..bb774144c372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    /* We support usermode queue only for GFX V11 as of now */
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11)
>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
>> +
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>>       mutex_init(&userq_mgr->userq_mutex);
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index c4940b6ea1c4..e76e1b86b434 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -30,6 +30,7 @@
>>   #include "amdgpu_psp.h"
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>> +#include "amdgpu_userqueue.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .rev = 0,
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>> +
>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>> +                      struct drm_amdgpu_userq_in *args_in,
>> +                      struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>> +    struct amdgpu_mqd_prop userq_props;
>> +    int r;
>> +
>> +    /* Incoming MQD parameters from userspace to be saved here */
>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>> +
>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>> init function */
>> +    memset(&userq_props, 0, sizeof(userq_props));
>> +
>> +    if (args_in->mqd_size != sizeof(struct 
>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>> +        DRM_ERROR("MQD size mismatch\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>> args_in->mqd_size)) {
>> +        DRM_ERROR("Failed to get user MQD\n");
>> +        return -EFAULT;
>> +    }
>> +
>> +    /* Create BO for actual Userqueue MQD now */
>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>> PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &queue->mqd.obj,
>> +                    &queue->mqd.gpu_addr,
>> +                    &queue->mqd.cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +        return -ENOMEM;
>> +    }
>
> Using amdgpu_bo_create_kernel() for the MQD is most likely not a good 
> idea in the long term, but should work for now.
>
I was a bit curious about this, the scope of this MQD object is kernel 
internal and used for queue mapping only, userspace doesn't know much 
about it. Do you still think we should not create a kernel object for it ?

- Shashank

> Probably best to add a comment here that this needs to be improved.
>
> Apart from that looks good to me,
> Christian.
>
>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>> +
>> +    /* Initialize the MQD BO with user given values */
>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>> +    userq_props.queue_size = mqd_user.queue_size;
>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>> +    userq_props.use_doorbell = true;
>> +
>> +    r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, 
>> &userq_props);
>> +    if (r) {
>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>> &queue->mqd.cpu_ptr);
>> +    return r;
>> +}
>> +
>> +static void
>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>> +
>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 55ed6512a565..240f92796f00 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -29,6 +29,12 @@
>>     struct amdgpu_mqd_prop;
>>   +struct amdgpu_userq_obj {
>> +    void         *cpu_ptr;
>> +    uint64_t     gpu_addr;
>> +    struct amdgpu_bo *obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>       int            queue_type;
>>       uint64_t        doorbell_handle;
>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_mqd_prop    *userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_vm    *vm;
>> +    struct amdgpu_userq_obj mqd;
>>   };
>>     struct amdgpu_userq_funcs {
>
