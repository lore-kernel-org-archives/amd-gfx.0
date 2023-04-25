Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E2EC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093AD10E2B8;
	Tue, 25 Apr 2023 13:31:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5032510E2B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/Ajt9lYgw7BGgIw3x4BX/x87bkrWeDNpaHDDxrKoTVcN9PJwVzYjbDCV5HEzPssy/4wQN5TaqKBQgYTwIh6RFxdtreYCIag4lZw/XIVla/yYPff73QhMrxIbR2gm6QQ/q6zvgwQ8aXs+AWxDxBPeX6xExxJG//e2fiMD1ImNQepVimhqK/LSJt09POVqwxDj9jaluqY5OrLInaGC1OZNrktwvpBo3wjsRnVaJX5BCC/rLWSouB0rwQFcTu1MIxxAm+w7HOId3Xj7SkQ6i2J6Q2xlBjz3N4N9QipMyeTb+FbgwFL3tG02MG4y1qx5TrttQwp069TU7Nz70eZQ7W+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/5cGyhludQsUL++yEVkzU8IW7noFO2s1amq/DKfqcM=;
 b=nUZUVv4I7hpodL3vQMPBwxP376WYbIzsnAUVhSn3dDB+P4OKRfh6bxaWZ9r7kvfMHKo+i2bXj6Ez2qAuKiUYmwalUmIl0jwtjIBPA7btbsJRxzp2HmeR7/w6vmeMZSvJajRxsRf7fblKfFsKcd7FeHsl20XQR1kE4VvqfqGe8lKOrX9IdV1ErA2GR5BZpPQaT9JOmYOYUphOZimgC71aGZb7DOBFm2kgn1opBHkMy5Q2cmdMWGOCPH+nRc7D7Q+jaCWat5Clc0SXUIYEv6PlRA5FjavPeQ8XTdduxjbrN+6veaJ0zOUS+YwJG0WUqhZW6Ha01LIU7/T6xX3bZswuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/5cGyhludQsUL++yEVkzU8IW7noFO2s1amq/DKfqcM=;
 b=TbgOSiBNduS8H306ncA5+rAjKRF6Mw3N+tjgzZbWq5Rgaov1torusOcvFMHQLl++lc4Vd964AYr5aSIFupm7iC6QhdDrcY3+lICzb7dpAjzTMbqUn+EnUBfjU+wJKeDhuVs9dlb9MCPDz/c2xGa5KGfNNMxeogozJf8UzWdHbYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 13:31:49 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:31:49 +0000
Message-ID: <63fb9f84-04c2-64cf-764b-b30cd9b81558@amd.com>
Date: Tue, 25 Apr 2023 15:31:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-8-shashank.sharma@amd.com>
 <bd98e48e-652a-8649-d2e9-f3c90d710f0c@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <bd98e48e-652a-8649-d2e9-f3c90d710f0c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fba6179-55ab-4c98-b0be-08db45916c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYnt2GvaVsG2adxEXQqRp+pmC2QOTpcRvJ9fJJpXtEQAlZopy5pMn6qkhD8ILoIsRvInL0jMl6JmYuumz2oL95u7xbVhDLV2HaXjHi7mJQTfoSYBY3LbSKuZDxLENTXLMpmzKlxhV+XsvdAC4gFgKx6U12NeULWsDXt16PoDtdHnT3adJr7MO7+iwSmcc6OzDsIB4uVgVrCCxDuGCZN0zjStgGgo48ITeTiOYJN4111Sebt37WIsHWVoifEjkfqlzyWH5qQNgnN92iazjzOBXDw8isIzV5uLm1ddU7cGoU9y1IzUnkvoYPZ9lLD6bjO1u5fVSIeXWfQqgzqCIOZxcvSoqR2d7DMthlg9h+8TLa41rPzBxDdYRmu+OHIAeigWuQAnYs/l7sNDVdjm7/FVLvZTIFe/q7OonXrmB3LfK1V8ljpf/NcXjanPHavHkg7BjEIbSmK01ewCi44lGkERYCZcE7aP+w4Zc3/LxPjR3aPHlqxe5jQXmDlj8kKWWHUpxx2MWhnNddS204tgnYeiSW2aHRjXf6QXl8zTcttrprhVSZTAnB+BiM7gWt6UmDLhP+UEQy0gfulbQmYM3Jnog3Zv4H5wnrT/aiQH11+h9XH7mC+M4Olb9WF15SvXCL9p+PxFcp+t3pBmIZcpzCYFfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(478600001)(2616005)(83380400001)(53546011)(6512007)(26005)(6506007)(66556008)(6666004)(6486002)(66946007)(186003)(66574015)(31686004)(41300700001)(38100700002)(5660300002)(44832011)(316002)(4326008)(86362001)(31696002)(66476007)(2906002)(8676002)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZMMkxvY1ZvbXQyQjFlcVRnRnBnVXhlSm0wRTlqelREMUZxaXZNM3E4K21D?=
 =?utf-8?B?T0dSM1dPOHB5blJ4VDVuWlNyYXRUQ1lOSWlIWlFKRFQ4V1NjamdaS0t5UDBI?=
 =?utf-8?B?c3JDRUZ3MEtZenNiaDQxcFJWMzFleDFYeUlaV2tIeTJkZml1WnlXOTRNcDBv?=
 =?utf-8?B?UHQrcVYxZHFOM2U4UTRiNGx6NDM1K0xJWUZRZGhGMUd3NmxPZDhDRUxEMnln?=
 =?utf-8?B?aUpSU1kzYURDdWFXVHMzVDBYREFIa0NmcGlKcndxcWdVNmNsRURxVllhZGU5?=
 =?utf-8?B?TzMzNnVqRzk4Vk5udW5QSTl4Y0FVL3VDOENHcm5MdUp0bTREOW1nK1ZKcEtR?=
 =?utf-8?B?MUJHMVpxYTlSYk9abjY0VE5DbVNySEFKRmRIT3U3dFdIMGs0cy80ZTBsK0Na?=
 =?utf-8?B?YW9mZi9DODR6MTBvMmFiUW5SOWtDZ09pOXQ4L0RYYTBvSG5hTHdVNHlyVkpL?=
 =?utf-8?B?UFh0R0EyTTZOK2RLcHY2QXZ2RlN4KzQ3WFk5YWl2aEFGM0pmbndSUUUrekd2?=
 =?utf-8?B?czgvakV5N2hWdGJNeHlaVHZLU0xRSWJSVUVibUFnejRjSnVMaHRQdTVJZzRT?=
 =?utf-8?B?Z21ZeEt2a0lnT0laSTc3UnpsRWlIT0FSaVZaQWRYUkVUMjBQbXRDUk1aUFpZ?=
 =?utf-8?B?S0grcnlqblk4TTR6dVN6Y0lodGhzZ2VydW9Mck83KzVMbjRGb3RVUG1wMkl4?=
 =?utf-8?B?NVVzM2F3azV6aGRQVW5sQnVTUzM5WUZLZWczbGZMeEJ6K0xtdTJGQU9zd0JZ?=
 =?utf-8?B?N09RYUs3bzI5dXdMTDVvUnBpTWMvb0QvQ1ZLVjFmd0R3ZzUrc3I2czlKbk9V?=
 =?utf-8?B?bUhjMm45Z2J0MFRxQUVvdk53NFRlTXF1c0p2enpuRWl3dXlIL1BkWE5hZHFp?=
 =?utf-8?B?eXkrMklzd0MvalBzdW1nczNwTGltb0U5MGgxMTd2SWFiaitxenl1dm5BL1JL?=
 =?utf-8?B?aURtNldmZWpmSUM4ZmNJM1hWdHJqdElXZU5zYXJKdStTS0NZZWdGaHZnaENi?=
 =?utf-8?B?VDdvOTBkbS9NMjg5cHZsZzlRcXdQMWJKckxhTWVuUGVBWkNDSmt1Nk0wckJF?=
 =?utf-8?B?cUszdjlWalNkTkt0b0l5cjFHbUhITThuOTVxV2g1K2ZJWHMvQ2N5dUYxczk3?=
 =?utf-8?B?VkQ1aUIvWFdHU0drVVZsNXd3Z2VQSi9DSGJiM3I3YXlvTUNHNkhaNFVLc0Zo?=
 =?utf-8?B?SFVsSjRKODNRcmJ5c1lnY2U3OGZMbHJiRDM2Vll6UVhZVW5zc09YN0oxam10?=
 =?utf-8?B?UEtoRDdrcXI5QVF5R1BuNHFHK1h6Z1hBQlJ5ZXNQTnYyL1VnMTNrOFNxaEZG?=
 =?utf-8?B?TFFvcm5FczUrOHgwUkt1MFJyRkpWbG0rLzV2UkJpeHordUk2WkczNnFEc1Ri?=
 =?utf-8?B?YXBBbjF4b2lFMTZiZ1dvWU9mL0RpYWh3dC9VRk9TWUZMeGZlZ2dzVCtHaHhJ?=
 =?utf-8?B?bWNvRmtaK211TUY4cVBSMGdtRDY0V0JLOU9OenB6ZVdVYU85eFpXL25EM3Zx?=
 =?utf-8?B?Z3lyS2txRXNaaEVjcU9mZS85RTRGOEJwbEN2eXh1MjBZU1cyRGo1Q3JXdEhG?=
 =?utf-8?B?M3Vka0xBMmgxYlcwUHBma0tUc0Yza1V1OCtPbThlY2RJalFGWGg4eVRMTUVB?=
 =?utf-8?B?L1Z0TzRhN0U0SE5tWnRWQkNORHpwbDNySVFnOGhzNWZORGlEaEs5TFZLdXh5?=
 =?utf-8?B?SS9jdVl0RTM5d3c4ckI0dk9QamdGZkQ5TEdPakVSMnF5ZC9NRjhYaU0rVElh?=
 =?utf-8?B?dDNxQyszT0RvQ29DZHR2R3N0WG1JUGZoY21mdDYvM0IrU3NZTk5HaVNqWXkv?=
 =?utf-8?B?VUpuemFWNUZ2OUhCZytTZndpU2NZMmx5bnNkR0YwcHF2K3BpSTdkajliYitM?=
 =?utf-8?B?aVorWkpXYnlMck1mSFRFSWhMbW1vaFJYN0dNS0JSay9CckRXSTdzdzRJb09U?=
 =?utf-8?B?dlJMdU8wVGViOGh2bFhOSm1qYXQ4VThEanhHeko0UC8wdVVKU3c4aXhkYUx3?=
 =?utf-8?B?THBpVjZ6NFlpdzNERkV6TE11a1BqdGtna0ZGQ1NsNWdHNTFqRS9oTFF3N3Vo?=
 =?utf-8?B?Uit3ZnhwWVNHYzllSkw0cFFRYkZDTWdhcFlqNWpBa09oRGdqb1pBd1h5cjl2?=
 =?utf-8?Q?4eplPUAAOMSPEV3XoEYhInOig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fba6179-55ab-4c98-b0be-08db45916c27
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:31:49.3211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtmlXil0Ey07QJwP6NRWaDltBooewCgrvmLB3OUXPRe1XHjSmJwNx4HWqDwsFS4NhYLB3R7uaKnwqmiW2tSUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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


On 25/04/2023 14:34, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> This patch adds new functions to map/unmap a usermode queue into
>> the FW, using the MES ring. As soon as this mapping is done, the
>> queue would  be considered ready to accept the workload.
>>
>> V1: Addressed review comments from Alex on the RFC patch series
>>      - Map/Unmap should be IP specific.
>> V2:
>>      Addressed review comments from Christian:
>>      - Fix the wptr_mc_addr calculation (moved into another patch)
>>      Addressed review comments from Alex:
>>      - Do not add fptrs for map/unmap
>>
>> V3: Integration with doorbell manager
>> V4: Rebase
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 ++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 86de35292f69..7a45d68091ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -31,6 +31,7 @@
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "amdgpu_mes.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>   +static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>> +                 struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_add_queue_input queue_input;
>> +    int r;
>> +
>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> +
>> +    queue_input.process_va_start = 0;
>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << 
>> AMDGPU_GPU_PAGE_SHIFT;
>
> Could be that this is wrong. What is that value used for?
>
Both start and end are required by MES FW for mapping the MQD. The value 
here is generated same as in KFD userqueue.
>> +    queue_input.process_quantum = 100000; /* 10ms */
>> +    queue_input.gang_quantum = 10000; /* 1ms */
>> +    queue_input.paging = false;
>> +
>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>> +    queue_input.inprocess_gang_priority = 
>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +    queue_input.gang_global_priority_level = 
>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +
>> +    queue_input.process_id = queue->vm->pasid;
>> +    queue_input.queue_type = queue->queue_type;
>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>> +    queue_input.page_table_base_addr = 
>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>
> You need to implement some mechanism to keep those page tables and all 
> resources in place.

I don't get it, would you mind elaborating this please ?

- Shashank

>
> Christian.
>
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>> +        return r;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", 
>> queue->queue_id);
>> +    return 0;
>> +}
>> +
>> +static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>> +                struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_remove_queue_input queue_input;
>> +    int r;
>> +
>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r)
>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>> +}
>> +
>>   static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr 
>> *uq_mgr,
>>                       struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>         gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_unreserve(mqd->obj);
>> +
>> +    /* Map the queue in HW using MES ring */
>> +    r = gfx_v11_userq_map(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>> +        goto free_ctx;
>> +    }
>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>       return 0;
>>   @@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>>   {
>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>   +    gfx_v11_userq_unmap(uq_mgr, queue);
>>       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>
