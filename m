Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC0AEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 17:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090D510E02B;
	Thu,  6 Jul 2023 17:15:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DC310E02B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 17:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA3lnkWfGLmIdLuV7VCrV+2S54tqIMCqk4pY7EeE/DirWxwvs3OvRz0cr94KpsCcM1EHf3sRtS1tc+i94iSBqq1q/RiYduL5rjmIHREEpxT/IU0oQVtvN1QstXsFaWgB9sWrdIt00GYwpoo/lGMsSnsEyVkzHJ3A0BzNh17qmgD6VVzsHL/EBW1KdqsR81GBKnbDptgJU0hEHk7PE2mfMcOcUe+xuhZtahjUaNqT1eyx41RZOhu1350aGffcpSXUSt400zos5xqyMtAaEMISrxdEJTE4XqFFmchtI83F6gQnbLxEjP/vkZMY3ogOFKCfJzURHjWrbKSERgcOjUSpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1QUoZjMYQ5EmhnxuN8yzCMIsG5TlRkvrgmdRsqSzJI=;
 b=QSi7HDc7FvWPmNQcbDLmYOmAojbDygjHjXddTmxuOkCtCx2C7AX5vxZX3nl5Dz7zme2LaOtdhA6nGrlUp/Rf+vo9GuhyMcrfsHogTxGI+uYcGAr1lmzaFLY6Yx/KXEa7JB8irS96GprPoOstt1slmgGoHIctVsOr7xK9xwaeUZVYWcCcHfs/I30LNnVvftdpBXt/dzj5LM7mAdylYDr+L9NGN50T2ZkZ3vZ3NrDlIlZTu6E1Sz/TDOVAfxEgG1i7uMZh5beJq1RB6rV5ydVZDs90XpSY6c/FTFGU4z3m5tvAMKItauXOXvkDmEjXSrtItZUCyousT++IZliC3h2SJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1QUoZjMYQ5EmhnxuN8yzCMIsG5TlRkvrgmdRsqSzJI=;
 b=aNbUFUYOqEKjDm0DE1sd3lL9psyrFSsZVEZ6igoe3ZdpAgEfQc/ABjzee7WGy2fRAVi2406BNHfck+uxtkMpWssGJsO3mOzHuUX1AwrkhvCBm0F9nPEzVKfeg+VSfgik7MoWtzrZrReSUS58GauuE1GMMKjfGuadQ7v98LEKMN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 17:15:11 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 17:15:11 +0000
Message-ID: <59b6e3ff-3a5c-3beb-32bc-49720c530b5b@amd.com>
Date: Thu, 6 Jul 2023 19:15:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 06/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-7-shashank.sharma@amd.com>
 <CADnq5_PS6Q=OqBf1OzYXkKbO=3EiKoTCk++n7fRKv2BGEk7tYg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PS6Q=OqBf1OzYXkKbO=3EiKoTCk++n7fRKv2BGEk7tYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3cd39b-145c-4770-7126-08db7e448e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uxwz2f51Z73NUaB5+Hf399479qQb/toFHOv7FH72l2dNYhe4BXxboR0UrBnC6hrWwVNjBkkfqZ3fB+oM3y7lbj9fJejamJ3LGBQu8UB09JSa/ncF14gG4byUo//FjPgGDWW9pgFqpMlpIdw8c+iIKO7jvOO5/mWWpkuoSQ9EjaR8qmrcf9xlL39NYTNxfFY/edjGpZkPMUnVUEmTLi5VrP/1hy3Qbzsf68BXGqmGyCYG5s22bvnaVDrTOLuH3fcyjnCDqWgtR3yq0auifoad0BiII+BKwn/CpyieHF6XZTlMJDWMbXIyrqj6DZqsBDX8opavmpXSPqbMUEW3kTcPhAf4UNp/gStRQruBBS/GT30o23etMGHuTFwjYdg9F1Z2qZ/2hQ/ZrDH7FHnh6TxMFf2QMW4+244J8mZcHfYk2zqH78XioWcXmnhT7TVT4Pxy9v2XStsRWIvaUDoOEillDp8ca/XAilqoVdYP/CYtSN5FzHcRy/NwLneOx/shc/y5gOOV5fdaJZmvdhlozJeek3OeViUXEpyHJ3W1BiocZ74WxDiE6H6BKBmy55NpMnRAFTt8Yasx9LoXgte+6rsPzqhMi32mGKq7D0gyiylkR/arh1Q/U/cqbP00KqRmMzcnjhwfvLmbSxv3I70aoymcFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(41300700001)(478600001)(6512007)(54906003)(31696002)(86362001)(38100700002)(6666004)(6486002)(36756003)(316002)(66946007)(4326008)(83380400001)(66476007)(6916009)(66556008)(2616005)(8936002)(2906002)(8676002)(5660300002)(31686004)(186003)(44832011)(6506007)(26005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjdaZnlYVHB0K29EZzRTUEtUR0ZWc1g5TFhzY25rV0lTTUNmendWaGpsUmZN?=
 =?utf-8?B?TE94MktTUkQyUzJ3bWNHQmo1M3VLY2Rsa0tlNk82UTNaYjZKeGU1elRUNG1u?=
 =?utf-8?B?a1kwT3VOQkRkZ1F0b1kvRkJDaXNveFFZaHdpSGJtTUxoY28rdDZNMW9XQ29z?=
 =?utf-8?B?SW5vZm1HczhseldoOEVvOUt4aXMxdTRHNWs4cGNzdE9qNEVEWUkraUNFNTEz?=
 =?utf-8?B?VnBTZi9VbEk4a3g4NnExcUtJR0dlcTZlcGhGbW1BdTl6cHYrSjBxbWVNNE5X?=
 =?utf-8?B?eThYRmI1QWt1MXNUTXlOVEx4OUlVZ2lZVGFjVHREYzFUQWRzUnR3UUE3Z0hK?=
 =?utf-8?B?TzlCclhyeGJWN0NMUGNMU0VGQUxjTUVPdVFqOGpWazZHaEN5aFVsRE5LUzBn?=
 =?utf-8?B?ZnhRekFKSHMwNFF1a1dvQ29HSFVyV1BFNmdNMVZIL09PVGxQd0ExRTkxM24r?=
 =?utf-8?B?UHJ4TzFjSk5ZVDNQMDBPUmpZVk0wbWtZZzNNZU9OWGJQaDBQb1hhdG5qM0Zo?=
 =?utf-8?B?YzdGcytEcTMyOVF1b3FaRlpscHBWa0Y0alhCQlRrN3hUNjhpUW1VeTIrZm1y?=
 =?utf-8?B?NDZITEpKcFA5Uk9pbmJyVktKQUtLWXhKTTBoTnBtMllRVUZvRHdjL3dST2lZ?=
 =?utf-8?B?bm9iNUcwREF4Yng0WUdwQ1pjNWs3blB2blRkOTFHT3V3N2VqdFA3RTRkUzFV?=
 =?utf-8?B?NHFwS0ZValJvajk4STV4YnRZUlZQY09GeGx0Tkw2cVFEeXQ2OUk5OGp2L041?=
 =?utf-8?B?cHlxendCQlAzZG9wMDdYOFd0UUNkL21Xdm9DdXNwZ0w0cjZkZFJmTVVnTGZN?=
 =?utf-8?B?Z2hIVlVOKzNoS29rN0IrREd4ZVNpWWZEeFdRNXBpd1hKVEtwV2l1Ylg2S281?=
 =?utf-8?B?VHB3ZDU0VWZQWG1reGdmclpHMkh0OVJOVFc1b3ZndVhFMVh5NUlNNzF2bDV6?=
 =?utf-8?B?dDlPZFZLR21sMVNQYVRzWi9WdVE4bnk3Wkx2QUl4NzV4b3FiSDBTN2crc1Zq?=
 =?utf-8?B?aVN1cU9SRXdTRFQ4MzlLbnJ0czhLejBqSmlhb1ltOE8zNnd4SXl1UjQvZlc0?=
 =?utf-8?B?MFgxZVgxWDZFUWlXQmk2dDRIZzhnYW9qZkl5dzdWdGhsS0RuQlM4a21Tem5y?=
 =?utf-8?B?NXJTSHp1dko2b0E3QTFlMzFWOEpMS3RLVW9KOEpkeDlvclFSM3hCSndtMFc4?=
 =?utf-8?B?SWtOenduL2o0Kzh3MGNvd01tWC8xU3gyc0hHaE9uTWhNeHRlV2lQMTFhSjds?=
 =?utf-8?B?TEdLVFpYWEdJcHY0c2VYeUxIKy90QVppVWtycU5zbW52R0QwdCt3d0hXRWxi?=
 =?utf-8?B?Y0g2SmNxL2RYU0lxVDFpQTdkRlUxNmUvcDVyYjNXMks0N0RjbGVxZEZ1ZzZp?=
 =?utf-8?B?WkJ6NmhacGg4ODVubU03d0tRSHhscDdxR1YwcVl6T3QzNEE4WFo0b3Z2V2J6?=
 =?utf-8?B?OFE0akhhcGl6SmhzTVU1cUtjUUNkVTA3WDM0WDh2a3V2R2ZCSjdnM05BQkxx?=
 =?utf-8?B?L25SV2xRV21NM2JwdnJWb0dFVmEzdk1uNDJWRUZnS1hCcU5JZjNGbTAzVW9k?=
 =?utf-8?B?Rm5lVTE3ZXlmRE8vTDBZMGNwa3VxYmt3b1J3TXZxcFNxbG45VkF4TVVEWVB6?=
 =?utf-8?B?YkNWVFpaUXFoVkFzV3Y4MlVPZHBGdlVpTnpjV0xlUk5LdG1KcWFzUFZPbStp?=
 =?utf-8?B?Q29NQk5rU2tuWGt6cUNvRVdkNFNTZXFWTXZvSXQrbERTWXV2VG1PVVV2TlRM?=
 =?utf-8?B?NHF0M3cwcko0L1FublBhN05Bd0lXZzVsSlltdUhxWTBuYzQ0dTh1L3llMmVr?=
 =?utf-8?B?d3JCQzNvdHBibjRGdndIbDVPWUp5SDZickJmVE9ZbjJJSzJyR1I3RFNHWkZ0?=
 =?utf-8?B?UEhCTVdKYmxnT1puRUMvUGhCbkx3dVVEb29aTE9sVHhTZ1BiSFRSdy9mRGZt?=
 =?utf-8?B?WnpOeHE5b3hMV1pOZU1CMlpqUlRZNDFnNFdMM3luZ0Q1UTdabGltdFYwVS9l?=
 =?utf-8?B?clRqSjZvVjZuNE9acmVEV1RBTTJOSmJPSkZETFpZbVA3QU9jZ0NYaXR2K3Rl?=
 =?utf-8?B?RjNtVzJtNWxZRFZQblBBRnJHRTZUMDFnUlNVd1dEeWVTM2t2d29iekFIclF5?=
 =?utf-8?Q?fA2kiW1RnzfIbO5FZcLmDYIBE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3cd39b-145c-4770-7126-08db7e448e07
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 17:15:11.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+M94wZYdMC6vxB8YY7H4SqX6CCSC5nmmZiQgNgsFLcCgQZPloQQ+mbpBETOcHUBbrOoAhCnZIHCmj2DHB+5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/07/2023 18:52, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 8:36 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch adds new functions to map/unmap a usermode queue into
>> the FW, using the MES ring. As soon as this mapping is done, the
>> queue would  be considered ready to accept the workload.
>>
>> V1: Addressed review comments from Alex on the RFC patch series
>>      - Map/Unmap should be IP specific.
>> V2:
>>      Addressed review comments from Christian:
>>      - Fix the wptr_mc_addr calculation (moved into another patch)
>>      Addressed review comments from Alex:
>>      - Do not add fptrs for map/unmap
>>
>> V3: Integration with doorbell manager
>> V4: Rebase
>> V5: Use gfx_v11_0 for function names (Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 ++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7d3b19e08bbb..b4a0f26a0e8c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6491,6 +6491,65 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>
>> +static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>> +                                 struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct mes_remove_queue_input queue_input;
>> +       int r;
>> +
>> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>> +       queue_input.doorbell_offset = queue->doorbell_index;
>> +       queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +
>> +       amdgpu_mes_lock(&adev->mes);
>> +       r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> +       amdgpu_mes_unlock(&adev->mes);
>> +       if (r)
>> +               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>> +}
>> +
>> +static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>> +                              struct amdgpu_usermode_queue *queue,
>> +                              struct amdgpu_mqd_prop *userq_props)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct mes_add_queue_input queue_input;
>> +       int r;
>> +
>> +       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> +
>> +       queue_input.process_va_start = 0;
>> +       queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>> +       queue_input.process_quantum = 100000; /* 10ms */
>> +       queue_input.gang_quantum = 10000; /* 1ms */
>> +       queue_input.paging = false;
>> +
>> +       queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +       queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>> +       queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +       queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> Was there an option in the MQD to specify a priority?

I checked the gfx_v11_MQD structure and this MQD does have an option to 
specify the priority of a queue (offset 134), but as we are re-using the 
mqd_init function from gfx_v11_ip_funcs which sets this offset to 0 by 
default, its not being used.

We can add a parameter for queue priority and overwrite the init values.

The priority which we are setting here in this function, is for queue 
mapping using MES, and its the gang priority.

>   What about
> secure settings?  If not, we should validate those flags properly and
> return an error if they are not currently supported.
>> +
>> +       queue_input.process_id = queue->vm->pasid;
>> +       queue_input.queue_type = queue->queue_type;
>> +       queue_input.mqd_addr = queue->mqd.gpu_addr;
>> +       queue_input.wptr_addr = userq_props->wptr_gpu_addr;
>> +       queue_input.queue_size = userq_props->queue_size >> 2;
> Do we validate the size anywhere?

We are validating the whole structure/user_MQD size, but not 
specifically queue size. But based on your suggestion on libDRM UAPI, we 
are planing to add an USERQ_INFO_IOCTL in a separate patch series, which 
will then introduce the IP based dynamic size checking, and also the 
checks related to alignment and queue size.

- Shashank

>
>> +       queue_input.doorbell_offset = userq_props->doorbell_index;
>> +       queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +
>> +       amdgpu_mes_lock(&adev->mes);
>> +       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> +       amdgpu_mes_unlock(&adev->mes);
>> +       if (r) {
>> +               DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>> +               return r;
>> +       }
>> +
>> +       DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
>> +       return 0;
>> +}
>> +
>>   static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>                                                struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6601,8 +6660,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                  goto free_mqd;
>>          }
>>
>> +       /* Map userqueue into FW using MES */
>> +       r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
>> +       if (r) {
>> +               DRM_ERROR("Failed to init MQD\n");
>> +               goto free_ctx;
>> +       }
>> +
>>          return 0;
>>
>> +free_ctx:
>> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>> +
>>   free_mqd:
>>          amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
>>          return r;
>> @@ -6613,6 +6682,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>>   {
>>          struct amdgpu_userq_obj *mqd = &queue->mqd;
>>
>> +       gfx_v11_0_userq_unmap(uq_mgr, queue);
>>          gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>>          amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>> --
>> 2.40.1
>>
