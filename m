Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4947C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F10010F0F9;
	Fri, 31 Mar 2023 06:39:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EBB10F0F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8pMe1+i2S5GYGyo4z5/TYTS5TYCljoQ4z/dTgKP2s8BZ0k+jCnsPP0L0RmQaZlYxsgBo5yeVOIbyrYLW55zgyXoXzQWYl1sgeTjRZOZjeaz4xsx2RMf9kuvL0wp5dxywA7TUEJw99KETSrsqZCSjRGVlRmmAOYRgSxOo+f2l3QFBAH1ezeb5FeNrkShf2hL4FwOGGPXmYGKM0Prt6RUWUIhG3+pxYb9am/wA4pLJ7VUvagb3kBQdivu/OVmvxr05FRvfZB6Rsk+COIyekPZpQ8u55cAvjc16eeRMFl2+HEfkZAEmR/eLtjJgSoYhe7raQLUtR38xIYwLR6BsBjDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjchObLb1qdSQOByA0K4ZoYnNDCbS/Z0d+DiR1p61cU=;
 b=a25kJsHNX9DimRS0eufj3UciFJ+Hwyb3Asg7A/i6cZ29EAxBKNmKN5AEC+zyixMy/ISReQCaCXPVbCObGMCOBE0Mw0CO6BpHPeL42PJfGmLaZ+QKdW4mJEyxgNnEbxpRYfWCvO0jpiTMW1wVyi3CqSAglesI2Aer37Ib9w1pCPLhhfEso1Td9WzPz9jqT+IDOGeuSr/SU/BJw+4yQpLL+Q9BMXM10vlVlkTeSljWC7Dp6H1WL+Rjtt64DWaVQcjJphFTHfN+d1y7i8+syzw45pj38qSNQvTWTEQmdOr78KkijjEILyurXWfxfjCpy7V486n5VW6dwPiLmlhlj0C4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjchObLb1qdSQOByA0K4ZoYnNDCbS/Z0d+DiR1p61cU=;
 b=ztKCr7RY6fRNCGyHMTZt3gIjVlx40i4JK6gMUqDqAm6UV1G1fR/3UfkVYi/0gh3vBAOcm+04rOD3db3zGqopKn6vIcqBCn2jco/ywcXedW2QKqI6pJvZx5F//jtZiWIn+XH+Rf8VjLwtt3QZ9qgEIuZ0Sweo1w0GcZBd7QaFScE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 06:39:25 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::e602:3233:e852:dfb2]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::e602:3233:e852:dfb2%4]) with mapi id 15.20.6222.033; Fri, 31 Mar 2023
 06:39:24 +0000
Message-ID: <84fe6e17-8bc0-b3dc-280a-011b6575eba3@amd.com>
Date: Fri, 31 Mar 2023 12:09:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/9] drm/amdgpu: add new parameters in v11_struct
To: Alex Deucher <alexdeucher@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-7-shashank.sharma@amd.com>
 <CADnq5_ONXNsjsAbXYB=aWEw0mm4MRw2UVPmCoS6xAEAw3Dqwhw@mail.gmail.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvyadav@amd.com>
In-Reply-To: <CADnq5_ONXNsjsAbXYB=aWEw0mm4MRw2UVPmCoS6xAEAw3Dqwhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To PH7PR12MB6000.namprd12.prod.outlook.com
 (2603:10b6:510:1dc::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6000:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e38618-6a0e-4859-fd6e-08db31b2aac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TDUwEwCKVdK8v1u4Dff7n1WlLnhAwpC8rXPI29HCWLu0Xv2mILSuj1CKjF96mb7L7CsDekWS7U55XVp77n/xOhyLICtGiiDMnOJHwMALAPTJVhC0ZZXJKPii/R7M6geQHxtwkhrACEkHyKcxCl3gEMq2ZeaB+Md5XHinuG2N1TqPXGFgtjfMU3L0tXRW8sh4BcUndUkr6AAQK9oYD5SdZXTwOOlGvHMKDnxGBtAkcgy99OzW675CL/uIC5OlBlBppbMo3/xiwbloBkE1cOHcrkFHv2QN3HBXqrnusKnb20zM+gb5lr1BBpBiOPVR4uAwalMn1H+XbS+Xutoj7/KlCoHNdoI13b4S6KHV/B+ZnLafZVRUWUsN/xv9lkfhOl5eHAhf6292YsihjHPaxvfVGHla754wYZnscB2Tdfu1q2mGxUJn8NlxUaiX28Grpm11t+sX4ZWsii9qV6juNcIoBa1Od3k0Cveq7OqL6FS21HRwEbIxluJaXCRhr2gooPyWdN62/6DwZb3Vt2S//gi8YrKHEAriZVKUy7F/+iCg6vFVVc7btkBUMXeVOIrPQEAoghtlGbUAG4Ju2B3/TxKLnRRAFroxe5pLyE7iSNvjod1H/G3H7ElZYvP8hSUQXowABsmjssUiNNdFvsSy6tYlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(41300700001)(2906002)(5660300002)(38100700002)(8936002)(36756003)(31696002)(110136005)(316002)(31686004)(6636002)(26005)(54906003)(6486002)(6506007)(6512007)(6666004)(2616005)(478600001)(4326008)(66476007)(66556008)(66946007)(8676002)(53546011)(186003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zlc4RHQxMjNZZjArcjFpS0VaMUxhZ3V5RGlNQnl6SmxJZ2czazNzT0FoRVJ0?=
 =?utf-8?B?R3R1RXBFSzcvd2x2ejczd3dMYmdROGVXTnVJUEZrVVhiU3k1RnBvdHBOS2lY?=
 =?utf-8?B?Q2ZHRSsrVXVjSWErWU8zSUJLdzF0UGl3VjZrRER5QktEUjdiU3hjWG5SR0Zq?=
 =?utf-8?B?NUpmSXYwQWEwR0E1eUdVUUJDV200VTNpMHIxNDI5REY2TzJGaWFDOGw0YUZn?=
 =?utf-8?B?MHZQaFM1MjNLa1FpTFAvSFZXbVFVd3A5RzVNbTN3cXZ5WnRyNC9UOVh2N2Rj?=
 =?utf-8?B?bXhzbktHM3dDU1BEcVJLU2VmV1lOaFFJOEpGVXpUZXVPUnJOd0lnTzM0TlRG?=
 =?utf-8?B?Ym9NZ3FRTktBYUdUS2MrTkVrQTVSV3Y3MDBqVUNLTUtZM2VtdlB6bzFvM0ZG?=
 =?utf-8?B?VmFHREt3QWhxQzZPeStYaVFIb0tZMjBqV1NMZDNPMVJSRXJrOVR6MzA1T2xm?=
 =?utf-8?B?Q3JQRjFpajdsdnM3N3U3NlpmUWFlVVp0RGcyaFF5Wi9qYTJQVDdEVVphSnIz?=
 =?utf-8?B?TlJVSGIyNG85anM3RVBvaWNkdVM3Ky8xVEdGcEJ2WUJDQzZBU0dWWEpsWVQ1?=
 =?utf-8?B?dHJ3aEZvVjdYcUhkM2dQc1RwRzhlVE5DT2JPZ2RTUy9BWC9xQ1QzRk9tQ0sr?=
 =?utf-8?B?eDExYmZSZlZFVUVYOGkzUENFbXhJb0lyK0xVU2ovTGl4elVmbmcwSjJYRGdY?=
 =?utf-8?B?aWJSV0V5eitUWER0bXh4R1d0V2pJNW5xSFhVb0liaG9nUzR1blJOdW5jUHNz?=
 =?utf-8?B?b2RHM2dhODhKMWd0dW9rOWdtWHJaWTNxU1VIZnQ1Ui92OUpVM3ZucFM3Ym5m?=
 =?utf-8?B?LzExSWVsVkl5Zy9XTHlXOUhsa3UxZVJ0NzJFb1F0SjFSUUlSNmdxZGZxODBN?=
 =?utf-8?B?QmFTM1NWeHo4WGdwVTNROGlMVVVDWE9uSHNzeVJsQ1h1RzR0SW1HWHFQamIw?=
 =?utf-8?B?dlVSWHNRVVNMUGprQjlBT2J2ZjBXdnhwZVNlYnJJNUVGd2p5ZEhUeWJoc3E2?=
 =?utf-8?B?N0lndGVmTjAyV2hobzlSSGtOZFQzbFoySVBuM205UjFGM1JPTEhtdVkvSDlC?=
 =?utf-8?B?Vk5oK3Mwb2dOQTRKMW8xWXNQc3NpQ1dnUXFrZXVkaVBMRElDenNvakZtU1dz?=
 =?utf-8?B?NUFrMGt1NllGVXp3K05NbWx3RCtQdERkNlJBdkYwakZQYlFxZmd4NDBFN1du?=
 =?utf-8?B?UmNwZS80V3c5TXpVOCtGTVpjV21SVEZ1a0tYSHgwUEpqbHZRVTJPay9uYVZh?=
 =?utf-8?B?cDNLQURGRVYwRFNpM1h0MEdoNTJEWFcwYlB1dWVDeDRWRnRQZUFONzhQbVJj?=
 =?utf-8?B?YTkrT2hBYXRpbWM3TFg4MGtvUTBvZk1pekR1dlYvOCsvcFZjNCtGelVrVXJ6?=
 =?utf-8?B?aG94R3FKak1Qb0t1aTBwRThzREVtWUU2bFZraE1sdVdRVGFsRk5zRmdZWHZC?=
 =?utf-8?B?VXNBOWs0MGFQcFFGc1cxVDViN005LzdZbjdVMDFVendpaEd3SDJRa3JjRCs5?=
 =?utf-8?B?aWNMcDRab3FqUmpMZ3h2anAyQkp5TUM5c0RJNUo0UDF3cTJOSnRNTGlRZXJU?=
 =?utf-8?B?WDBUSXRQajlJNTJ6aUp6WXk3b2dVUjE5MjlnTDV4eCtNQm43clRRS01IbjdI?=
 =?utf-8?B?ZS9saEo2OGVoRnQwb0FScE9tWndPRFJWSm9mMHBndi9iMGNHTlhsdFJYb2NH?=
 =?utf-8?B?d1FHWFU4OHVzUlVhZ3Izazd0dDR5a1NQaWs0L3A4Z0dhZ3BDN0c0dTFhN09y?=
 =?utf-8?B?LzlxcUJvSi9NMzdXYWlxcWNnSmp0SXNtaVBiamk0MWI5cmoyYlhoWUVrUyt2?=
 =?utf-8?B?ZWRzS0E2dzFFZHpJYmUvQUpHekZ4dHRXU2tET24zMkhhMkxXUEZ0L05YcTh2?=
 =?utf-8?B?aFdCY1BUY0NrOHJVQzRuSW5nT1ExdVpERHFiMFpycE9TQk82RTFvcnNuQzdp?=
 =?utf-8?B?WVMrdVZjZjFJZmpsRHVvZmZoQ0YvSDkxNVpzYnBKZXQ2SlFLWC9ZTHRLQ1Yw?=
 =?utf-8?B?cHdacnphb3dERXdhbzNseGJqa0gvTGVRUVl5bmdxZnF3d0k4UkJOWnpkVWs3?=
 =?utf-8?B?bjYwNHZveDRuYnhCbkZ0S2xiTGJtdTROdEtwN1R4Y3IrSUVpQzJNblBXWjVB?=
 =?utf-8?Q?hhvysDgQ29erkOpn5Y3zRp6F8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e38618-6a0e-4859-fd6e-08db31b2aac0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:39:24.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbQOpTxzPEqYXaYY198TGDu3NiAXYPQb28Xne9bdpuZvd0owhYIw5RM7pAI8bGJHTR5dxGXoKs/u6fTS5ctMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
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


On 3/31/2023 2:55 AM, Alex Deucher wrote:
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

Sure, we will send this as a separate patch.

~arvind

> Alex
>
>> --
>> 2.40.0
>>
