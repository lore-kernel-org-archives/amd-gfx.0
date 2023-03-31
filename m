Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03663C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810A210F12B;
	Fri, 31 Mar 2023 08:30:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D57210F12B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD70Ms24HfkzGmTBjnUiQIEjjwze7/nLoh+hDOix6ySdtHJvRe0dNwx+2kDhD+RuqWcIaFz28ZNrBpyGoccx/Q+DzzvjM6EgvBuk/U0BEN9SwFAtCNItRomzvJ//nRUjUZbgguIF9Pb2N236YT0vza0QT0e7QAEEy1PD0Pfkm8B75VSJmpQXYrRiDbubMWxKp3xPAUxqDzmySe1z8JTvLCBGf0+mklavxKFvCXzGWEz1jOAL18mXyCFKcJ35O3Hb8ertT/XkV44LNnVrsxT5TaX++MD0Vc+SAStdCRjiCu9i525u5bJriNfyDJde1R6Z8c+d182zJTJpNeHfKkj4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41MEUV77s8XLjGG41VkRjXuEli4jlyuPUnhSqsKTpzg=;
 b=WprSv7L/Hag4iH2TEOIdKF166Wjk21nPlPuj3bdMuMWPsMd98ddYn+XiXxb+GgiFz6oMExF0JnJGR/YRS4nSHcWl0xE/Lr/8fHNYdsNH3li8lqjnuec1ZLAAN0Mn5kXqcIXEADEI4J2dGDQo7wQuTlwwxhy4bmZeYXYUVWX2H5NhCXZprhmwOnVavd231qjixyWAuT3Sv0yskgzZk8kZYorRVBbR+BxUDozCWT/n2tTrc9d7AG3MYACBK8oYO1+EIA8tHZ6GkITlT2PcPseoqdhnZWbjhZ0tbUW1RrI/C3QtW8lHcZcMNQe9u6TwyUBgA57Ac/fF0mTE+R0NVMsIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41MEUV77s8XLjGG41VkRjXuEli4jlyuPUnhSqsKTpzg=;
 b=R19rhgZdH6DhOuIB6K/pbikuyTVNlROUt/5Rrzd23MVBmb3NieRKa902UdPI7TjkjhPUiIfR/KryA/WpFwWlfljjtcPzAL5DRyanNxM+STlra83bpx88j9DE5XePqliFT8mP1Mop2ymPps5ozPtxiBJ18+idFKw/uz4f5dOwXls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 08:30:55 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:30:55 +0000
Message-ID: <e2fad27f-ae43-e617-d3c8-c6679b9374cb@amd.com>
Date: Fri, 31 Mar 2023 10:30:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/9] drm/amdgpu: add new parameters in v11_struct
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-7-shashank.sharma@amd.com>
 <CADnq5_ONXNsjsAbXYB=aWEw0mm4MRw2UVPmCoS6xAEAw3Dqwhw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_ONXNsjsAbXYB=aWEw0mm4MRw2UVPmCoS6xAEAw3Dqwhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: b37476be-01de-4083-fea7-08db31c23e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6TvgjaxuDKBs9D47DDqvkc4mPjE9xh1WV4cdwU83GPey5NqEFzGiOhaJ+HJPWHIzuLJJJVg+/EnSR2QSFbc+vo2eQucrYzvnArN2SAbgRYca1JNMvwEEk21eiix4ADWM618shP5okM89pZgsU80OO2UavalOYv5gwCfxkAyJTGLAMRO16BTB9Qit1zO2PeYPJkx8WX8DNg8Hlh5iY1pwNaYlKfavynbKFXBg0t+eulnCm5WfYqDU+jOEHRnWWahXgzHsffVo7GyonD38A5LPa61cyNOTxLID0lrlp+nh/LL5LBG/nuFZq6o2zeSzlwFhALLYCn5uxfTtKKpAnkSO2VjpywOCIK3vyQ5QlWSgfC8Nb88OpPvaRhNq8XYUwq8uHvd2VifCeD5Mtz4FQwQ/YYCbh2s+1RAyCuhOAJmg+lTLuO3yigjRNfjBNtrgteGEuyFPOsi8asFFob9M0KFVn4fGkJnm4UULPw6qXJD+jWMJvK0kaDAEWU7Uen9Zva39jfYB27YSfQgS+dsYYLUK+Ti1O0yOJyGFApB4duba7Z9w9iMJcGKCpAapKHwEQ2eETo5gim516kWB6CTPVh7Fw6xLoICYUjqRqDSKtbVXb4Kyz9g5o79SeD26B6m8vwPny+RAi6+q3VJH/giB1jekw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(36756003)(83380400001)(53546011)(6486002)(186003)(26005)(6506007)(6512007)(6666004)(8936002)(2616005)(38100700002)(86362001)(8676002)(66946007)(66556008)(66476007)(6916009)(4326008)(31696002)(31686004)(2906002)(44832011)(41300700001)(5660300002)(316002)(478600001)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9DR09JMWxLaEJaVGw4Q3pFdmVHOHJ1K3pPUzEvc2RhN3ZEV3hIL21CWk9h?=
 =?utf-8?B?MndCNkRNME1SOWRQYmpHZVVBUDRYalVBcEt5bDZBam1adU9DaVI3aWh1bW14?=
 =?utf-8?B?bmFZMWNOSEVKRHgvR1Jma25jNU01ckJrRlN0azFrMXA5aWExcXM0ZEVNbExE?=
 =?utf-8?B?K1lWeHpFNFR6NkJOWnBVc3JEMFV1ZHFaVVhnUy9Wd2NUWmtYWWR2UWhZZUNp?=
 =?utf-8?B?K3FjcUZUM1lsVEVtTnJ6L2JjREpIeDhvWWxBT1l2c0cwUXBZNWZEM2l2TExL?=
 =?utf-8?B?K2FtdjBvSWxHV2pvMWhlcGYrVTEwS2lUbHZIOHlHVWw0SFZ0MGs0VHlTQmVI?=
 =?utf-8?B?Mk5kMnN0RWdCUVVmc1doYUEwT1Y4ZSszMVZGUGIyaU5HS1pUa3g4aDhjanZj?=
 =?utf-8?B?SzJXNmw5UXRQUGJ6NmtYN2pYZTZaeFVvb0F4VWpHdWFlb29OVkJTVEl5RHF2?=
 =?utf-8?B?VXJHSktlSnUzVDY4RUpJOGJQMnBWU2Fpb0tkOFpxbENDTDZhdkJTVEZDbFNh?=
 =?utf-8?B?eUlOZDFDTG9PUzRuRWF6Z0tadTBPMkZ4YmNsV3RRMEJadWdYVTlUZWdRYjhM?=
 =?utf-8?B?NU5SSllNTUszdnBNS2JYQWk3RUcrajhvYlg4OXdoanFid2hZRkZhYTlnM2xn?=
 =?utf-8?B?UFJVVjRXZUdmSEYzNHFCaVhCV1YvS29lV1dJeVI3VVhHWEtPb3dhSlY3Ulhz?=
 =?utf-8?B?TDlJMklWbFZxUXFrZHgzeHBMMEpEMEhrMUljbTU1TG5KUFgxTjVmaTJJWXJD?=
 =?utf-8?B?V0VPb3ZaMmlPY1lmYVNFNFRyMGFIWVAyQWNqbXVoaTc4dTlwUEFZb3h4Rms4?=
 =?utf-8?B?WStFQlEzRkFUQSsvYTNhQ2Z4UmIrQjZLYjdraVE1bk9QV2ZZVzhsUXZNS291?=
 =?utf-8?B?KzRqdWdoZFFTRTlXZTl5NlBJT2FyN2U0enA1bjZZOG93MktiR2VzMk9Yc0J6?=
 =?utf-8?B?d0d0a3oxQ2lhQmtjMUxOZ2oyWTlvL1FZSTR2UVBjTU5hSEZIYmNYSU5DS0xX?=
 =?utf-8?B?Wml0V0cxU0MxdjZ2YUs2TkJhMFE2L1ZxSUN4M01qVkFrd3R3Y2xqeGZXQWZR?=
 =?utf-8?B?WnhEcnhpNWFNRUNvMGxVMVNURTd2bCs3QlRkRkR5OU5XMno0bkV0TnljQlQv?=
 =?utf-8?B?bWpmM2NEUTBFMDlyQmJBNnpZOHQrQ3Y4cWU1b3hZL295RkxaM1cydCtodS9I?=
 =?utf-8?B?eVB5blZYelpZbDdCcWdxclU5SUVWUlhkeWdiMFFMdHkzYTVkU3RmUFVhVGk2?=
 =?utf-8?B?c3FZdXB6NE5LN1dwUXB5Z2Z0ZFVMUnFlL0trbmNvU0JKbTRSSUZYeThXemJP?=
 =?utf-8?B?ckJvcUh0MW1Va2pCVkVBZVFWRFlyZEt1NjdkWDIwY2h5Z3V2VERHNWQ4NnRW?=
 =?utf-8?B?VmNaNlhSWWZNeTFJMlovd2ZBTXB0MjF0RDREVVVra29xNGZYZi9yYWdVcFNY?=
 =?utf-8?B?Tlg3TnBYc01BOXAzZVhFUGlyN0t0c2tDc3VvQWY0dDZkWkFMUjY0ZDE1WHZr?=
 =?utf-8?B?UzlBSnZXdnVRVUI3NCtFRUVDclMwVHJrYm1BSnhGTFNnVUtoU3pGcisvbHlI?=
 =?utf-8?B?c2R0S2VDM1lxWVc0NVFkSVVxOE9mbW51UWxsdWVUc01TYzNIb2hBdmFIeXNs?=
 =?utf-8?B?K29raGN1T05UQ2ZoYzVmRmJxbVB0Rkt3UzR1MUdPOHRpa2pjRmdxUk9QVlNy?=
 =?utf-8?B?V3IrM1Zyc0ZxRWJRaDlleElNYm1sY3VpbjFDUnBadDY3dXlzQVFuY0kyY2hH?=
 =?utf-8?B?Q3pTOVJIVGxySm45ZSttTzFtQzYwUFNKWWYraHhGSDdhWWVwdjhHb0Iyd2di?=
 =?utf-8?B?M3phV2NlZEdvS3p6cU1wc1plQllUbVBNcDBSNG9MdXEyS1dqblF4OFRDVEhp?=
 =?utf-8?B?WmhtZ211bEpEbGJ4T0hQdDZCVFoxcFFOZmtaZm1wVnE4UFh4YjhvNTFWNWR0?=
 =?utf-8?B?cUNPV0lXN1hZK2NaRHJrUWt1UExQNjBPSXYrRzRxUHNNSmcwcVVQRDhhYUlC?=
 =?utf-8?B?MXdKTTRWVmRTQk0yQlJkUFdvMENwZEJ0Q2lvUVh5bHdQN29DMTBzd282Rll3?=
 =?utf-8?B?dkZBMzhUKzhrOGt6VTJoVW1yNjRPM0NKRENEakhhMHVTcWNGOVZxMHorQWpJ?=
 =?utf-8?Q?f1YgSKJ0FDEvG07TsG0aHJftH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37476be-01de-4083-fea7-08db31c23e9e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:30:54.9772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vVFo90h28lsjKm6VDrbSRQxIiIOT+diuLG+znkSrD8CCErwIpNgodFUEEd21Qq4wPFj9gVUecsQTVJbi+wRGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 23:25, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 12:05 PM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Arvind Yadav <arvind.yadav@amd.com>
>>
>> This patch:
>> - adds some new parameters defined for the gfx usermode queues
>>    use cases in the v11_mqd_struct.
>> - sets those parametes with the respective allocated gpu context
>>    space addresses.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 21 ++++++++++++++++++-
>>   drivers/gpu/drm/amd/include/v11_structs.h     | 16 +++++++-------
>>   2 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> index 52de96727f98..39e90ea32fcb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> @@ -22,6 +22,7 @@
>>    */
>>   #include "amdgpu.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "v11_structs.h"
>>
>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>> @@ -68,6 +69,22 @@ static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_m
>>                             &ctx->cpu_ptr);
>>   }
>>
>> +static void
>> +amdgpu_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                           struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>> +
>> +    mqd->shadow_base_lo = queue->shadow_ctx_gpu_addr & 0xfffffffc;
>> +    mqd->shadow_base_hi = upper_32_bits(queue->shadow_ctx_gpu_addr);
>> +
>> +    mqd->gds_bkup_base_lo = queue->gds_ctx_gpu_addr & 0xfffffffc;
>> +    mqd->gds_bkup_base_hi = upper_32_bits(queue->gds_ctx_gpu_addr);
>> +
>> +    mqd->fw_work_area_base_lo = queue->fw_ctx_gpu_addr & 0xfffffffc;
>> +    mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
>> +}
>> +
>>   static int
>>   amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -104,12 +121,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>       queue->userq_prop.use_doorbell = true;
>>       queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>>       r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
>> -    amdgpu_bo_unreserve(mqd->obj);
>>       if (r) {
>> +        amdgpu_bo_unreserve(mqd->obj);
>>           DRM_ERROR("Failed to init MQD for queue\n");
>>           goto free_ctx;
>>       }
>>
>> +    amdgpu_userq_set_ctx_space(uq_mgr, queue);
>> +    amdgpu_bo_unreserve(mqd->obj);
>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>       return 0;
>>
>> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
>> index b8ff7456ae0b..f8008270f813 100644
>> --- a/drivers/gpu/drm/amd/include/v11_structs.h
>> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
>> @@ -25,14 +25,14 @@
>>   #define V11_STRUCTS_H_
>>
>>   struct v11_gfx_mqd {
>> -       uint32_t reserved_0; // offset: 0  (0x0)
>> -       uint32_t reserved_1; // offset: 1  (0x1)
>> -       uint32_t reserved_2; // offset: 2  (0x2)
>> -       uint32_t reserved_3; // offset: 3  (0x3)
>> -       uint32_t reserved_4; // offset: 4  (0x4)
>> -       uint32_t reserved_5; // offset: 5  (0x5)
>> -       uint32_t reserved_6; // offset: 6  (0x6)
>> -       uint32_t reserved_7; // offset: 7  (0x7)
>> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
>> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
>> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
>> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
>> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>> +       uint32_t shadow_initialized; // offset: 6  (0x6)
>> +       uint32_t ib_vmid; // offset: 7  (0x7)
>>          uint32_t reserved_8; // offset: 8  (0x8)
>>          uint32_t reserved_9; // offset: 9  (0x9)
>>          uint32_t reserved_10; // offset: 10  (0xA)
> We should split this hunk out as a separate patch and upstream it now.

Got it,

- Shashank

>
> Alex
>
>> --
>> 2.40.0
>>
