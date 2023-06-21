Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BCBEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 13:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D8010E489;
	Wed, 21 Jun 2023 13:02:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D9C10E46A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 13:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWF1OFSYHQg5q9yDs0cv4/vTDdzVlTOi0Cfb/fkJr44cI5mlK8w7Hmj39z/rrdQOkf0mbnFZxgfvT5piI+DU+5ptip6YDyxJZbGsCN+XW+RZP5p2fljGJdpwMstV+v+BPpJIVXOP11u9rkRZqtyS+amk3UTzdZ+EjXeflxIZqevBx888jDdtApkT0xAfXMPlhaUEWs9C8NhymFBAknGuxJzmfapT9oWxLRKO57flaykUQB7Chr/9QA/yYUrT2Tmqi/KyuWhjMn6bWRQboZU/qxz8N2A36bw+fCWIp0/0yPlX39b3pUO/7fkBnrryAU5R2eLYRGgp3wjjONuqjGu1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JUYZuFZ7evqRjtLUhK4uCklDfQsJp/0wSfB8cPREjE=;
 b=n2Fn5JSeDdYCtyzQ3w3xVLz0I/ADuT84sZ44Xh6FvEebrPCgzke/z28k++jTmy5OzR2sv16jqIXE8LqXen+S19vw9oxxZMvq2r0GL+AEHVJrFrvGMAThmwhmcNejHNBqkh5z3hs2XYIIvPi0DuecxgHeWuWWK+vDvhinVQbvHOR5cwiqo9hJ6CWC4Adz2wRUqWsTKNfMgDqrutc2263v6TSEkAzr9ahg1acdSYbo75F9WYWn/PsWo9AEPbGEwNVF5xO8VwRsb29oPBtmK19CYU6p6E/FKD8wQvkJidiElZ5yLrVTLQEBX/WTjZl3gv1QD5Ds1usi0DLnjOJ/K4CBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JUYZuFZ7evqRjtLUhK4uCklDfQsJp/0wSfB8cPREjE=;
 b=gwsMhHaF4SW6B9Qwt9dezOHJH0yE9qcjn9fV4CR7T6aXl5rnMBfVxUSYl+UhTHQJL0yLjRnqsLefSvixvp2buLelmxQ7WqMzHuQpEvLVVkYpsLVJn/MXErREhSNzafMR7KPBnkEUlId+AUWg3DpuJQvzB9BcfwbSu0iGE+fzzpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:02:47 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:02:46 +0000
Message-ID: <41a02391-8ee5-4c42-645a-36faf066bfa1@amd.com>
Date: Wed, 21 Jun 2023 15:02:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 11/12] drm/amdgpu: use doorbell mgr for MES kernel
 doorbells
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-12-shashank.sharma@amd.com>
 <3ee2a79e-7b25-3b23-4b71-9c197d4d464d@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <3ee2a79e-7b25-3b23-4b71-9c197d4d464d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebc33c0-7bf8-48b0-d88a-08db7257cf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QOTj0dc/UhW99FdFQCX8PR2iWrxLNK/v1Lc/6PRwlZPq4DHFna8Vy8j/tjoy+r3nLgWgbWAL/uJSHHtMitwEoZP7ImJnIAvo8XCBQrhHmGggIOm07put6pHir0VbUTelKcmTVEO9t7MbQlS/ltmHhSeEg7OxaI86YzYbAUvg9RnXMZuNUmuAIC3W+wkwI5OeDfLeXKNHUEYpH3zv4Kgv3FKvPteYUeakEOKFTi/Zk0HswHwj+pvBzMgQXrMUivljr7NYPV4lrGCdK+4gwzlVR5dKx3LDZwKHITQb0fE0szvQ7oVsZWNOyR2ZuF+bfDw6ECypnLTkLmSQpW9QLIKjkowbXjK/TFc2fujOOvWwBTIRa86EKAAmRYMUFy9piMpYrX1NQkIitnV1jfgW8pHaTEAtth6baU2XnT7ZU5uTpZ5xI7Jrj/1wzO649SvAm7uY8oE92/plhrDPuScDFICYVPTG6A1z09o1UXfe+4A7XX6fzCXvzKLaugFBx4rfPW7Nc9fukb9SLCWmU1rTamCI4+k4ugkEiZFQebs7+sX+C442PGRMzZ7iGjh39w7bQPMLfylRKtgrS4f2xNAWnrv68YLXqPkUj4doJy1B/HCB1wMHQKm6A2Q3Il2eguFlcToSuRXK7y//1pGgaAUhoFZ2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(44832011)(2906002)(6666004)(8676002)(8936002)(316002)(41300700001)(31686004)(5660300002)(66476007)(66556008)(66946007)(478600001)(36756003)(6486002)(86362001)(31696002)(38100700002)(53546011)(6512007)(186003)(2616005)(66574015)(4326008)(83380400001)(6506007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZ4K21HTTZ2aFhUT2JUMGxOT3NNWlNNNUI4ZnU3bEhvYisvbjU1QjB3REVP?=
 =?utf-8?B?QUhrTDA2anJFY3ZhWGw3N3J4bmxtRjJYRlhSUVhnbUZuamNVUStPd2U4YWc1?=
 =?utf-8?B?OE5uWFowejZBcUg1UzRQNGN3bVNXcnJmdGdoelZ2NDVQSEJxOFNJL0c5bjl1?=
 =?utf-8?B?aWQvbkFHUXpzL1ZaeC9LK25jUDhRZk5iTGIyWTN3K3NCWkZ1eklUWkRkaHI4?=
 =?utf-8?B?U0Myblk1S05Dc081enNxN0cxMWRNczFVNnFMd2t6c0c0WUt2OXhUYm1EWWE0?=
 =?utf-8?B?YmZKNG5FcE5DU3RDWXBUWUpKS0cxOURNT0xyRnNWRytvUE9DVjd2THp4Wld2?=
 =?utf-8?B?S24rSlB2aDhmL3VGOE5XSm9Pbm85cEVBMWpzemNGRnp4OWJlVlQyem1PRlRL?=
 =?utf-8?B?YUo5eUtGWnI1YXVBaTBqWnE5MG92WlBEQUtHR2w2QysxR25pcUFkZnhLeDVM?=
 =?utf-8?B?b3gwdXV2TkFBcXQ3NHNSS3lISnZuY0dmbDVENjBzY3dHZFBSb1JtWi9uY3ly?=
 =?utf-8?B?dUxiaHRxZUgxM2tyaWp3UDAvTmRrTVI1L2FDOG95R2VtYTFReXlPRHd6SnVm?=
 =?utf-8?B?bSsxa1JYd2Nab2hnc01OS21uNjZObFZ3YnBRMVhzK1dCa3hnV1VEYzM3MnNt?=
 =?utf-8?B?TDg2TXQ2YTdtZHlCUkp3Y2syVFRHUkx1VWdhOFE0b0NWQ3I0NWNYZzY1MUov?=
 =?utf-8?B?czFkTGt0ZWozY2JQVXJDRTZERUxqY0NCNkcxL090RGprVkFMYmpVSmFYTklY?=
 =?utf-8?B?SVBpWTNCNE5nMkpIUC91WUduVXNSSW5LZ1RwQnorYmhMRnRQSFBOMzdvc0Vl?=
 =?utf-8?B?RU10VDRWMnZNcDV0ZUd6am9KUnpMUDJUZHB6SnR5SFY1dmtlQ2VVRU1qSlZn?=
 =?utf-8?B?dUhQU0ZwdVd3RFdDU1JXV2FraXkzbHg3QzhmWmNEcE43WkVtY2VmNmh0N2g5?=
 =?utf-8?B?UGhZRDByYnNEY0NUQWw5cHNzTHJTQkVyVE9GRnRRblh6VWZJeGp1NnBrd1pw?=
 =?utf-8?B?dGZ6dFQ4cE5ybHRTendLR3k5ZTErcndxMDVydWJjcDA4RkVDZExGZE9OSHoz?=
 =?utf-8?B?dHdtY0xSZEhHRXo1T3hGdk1KZE1DZDZWeUE5YjFCZVNvcDY0ejcvTzlvOHVl?=
 =?utf-8?B?eis5RFNSM1loVkYxaXlZaitjN2NCRldDcml1Qkp2NTBVWXZJVDhFbTVubE5o?=
 =?utf-8?B?R1F2QVQ5MHkvS3g2L2lFTFFQNzhtUzYyOVM5UkYzZndRdS96SG56VURYa3dj?=
 =?utf-8?B?SjVFcUlWb1dVbUtTVXJyd1NZaFBFL3liRU4vVStqYzdUcjZLZU5iTjAxOXZq?=
 =?utf-8?B?WU03dllKV2RtOGhkRTFJWldGMGdZdElLOWdFWnFTZFBXdVljYTdHZ21MMXZU?=
 =?utf-8?B?WSt0Y3NlUEtrUERMbEMySUdHMXpCV0p4dVRyQm90aHZNaENqWTBUSlJXL3Bw?=
 =?utf-8?B?dWYyNUZJSDU5WGVhajR4NUVJeHN1blk4djZxekdnQjVLc1RFcC8rZFpSWlhm?=
 =?utf-8?B?MVIzUis1SFBNSzhvYU5hakw4ajBwVXRXOWZaalhtSWw0amdyVnRNNFBka3JE?=
 =?utf-8?B?dEJsVG9qQ1F2N3JBL2VmS016ZTBiRFh0Y1dvZDNidjFHWDBNU2FoWkZ5TTJH?=
 =?utf-8?B?WmJJQjRTM1NHMXJ0MmNOM3Z6cloyd1ZLc1czNllHbHhpNFJ4VDJ6b1BZOEkv?=
 =?utf-8?B?a29lV20wM01TRlB2dXRJVFcxUjRBcXpieVhyZ0FiT2hJM1pQTHBmL3FDMFpk?=
 =?utf-8?B?WW9pNjFKcmM5M3dzSGpOYzB4ZE16ajc5MFY0WFFWN0t5RXUvdnJjcjdBbGFR?=
 =?utf-8?B?Z05wdFVCanplRm04RmVZYzk0WVFER3A2aUJwMHdSV2JURnJVREhsRlZzMFg3?=
 =?utf-8?B?a3NvM2VhdUFkY2hCNCtWUjJUd1dEMUpVVmcxY09mVlJhazVwdXd3ZTArUjVM?=
 =?utf-8?B?N0FDbjFLVlFFaFh3U1FvWkhCay94UTlDU29EVEFXSDBTQXFqdUV5R0lUMU1D?=
 =?utf-8?B?eGZjTXFrNGZ5eWc2UFhwcUxYK1hxUlludStkcGI5ZzdWcDBSMTREd3B6MGY3?=
 =?utf-8?B?VC81R2RVN1RQZEN6WkxmUkZCQTVmd204SktEM2d2dUNWK0VRaWp1YWJZMnNM?=
 =?utf-8?Q?KNddhrR621LKLTTrXa8cRpIXH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebc33c0-7bf8-48b0-d88a-08db7257cf16
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:02:46.8748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anFc5XHKxrxNqUBzhg2PjQAzT+7LQOSQl0kK4v8OvCdhvevorv5/mpyZf9d4GNDskBL6puwRuspDaEyVtRFJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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


On 21/06/2023 14:08, Christian König wrote:
> Am 20.06.23 um 19:16 schrieb Shashank Sharma:
>> This patch:
>> - Removes the existing doorbell management code, and its variables
>>    from the doorbell_init function, it will be done in doorbell
>>    manager now.
>> - uses the doorbell page created for MES kernel level needs (doorbells
>>    for MES self tests)
>> - current MES code was allocating MES doorbells in MES process context,
>>    but those were getting written using kernel doorbell calls. This 
>> patch
>>    instead allocates a MES kernel doorbell for this (in add_hw_queue).
>>
>> V2: Create an extra page of doorbells for MES during kernel doorbell
>>      creation (Alex)
>
> As discussed on the other patch, this should probably be merged with 
> patch #6 or otherwise we break the MES test in between.
>
I have instead moved the MES init part here in this patch, so that all 
MES code changes are in this same patch, whereas patch 6 contains only 
the base kernel doorbell object creation code.

- Shashank


> Apart from that this patch set looks good to me now and is most likely 
> ready to land.
>
> Christian.
>
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 94 ++++++++++---------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
>>   2 files changed, 40 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index f0f00466b59f..01c3d27512d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -67,91 +67,70 @@ unsigned int 
>> amdgpu_mes_get_doorbell_dw_offset_in_bar(
>>           doorbell_id * 2);
>>   }
>>   -static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
>> +static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
>>                        struct amdgpu_mes_process *process,
>>                        int ip_type, uint64_t *doorbell_index)
>>   {
>>       unsigned int offset, found;
>> +    struct amdgpu_mes *mes = &adev->mes;
>>   -    if (ip_type == AMDGPU_RING_TYPE_SDMA) {
>> +    if (ip_type == AMDGPU_RING_TYPE_SDMA)
>>           offset = adev->doorbell_index.sdma_engine[0];
>> -        found = find_next_zero_bit(process->doorbell_bitmap,
>> - AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> -                       offset);
>> -    } else {
>> -        found = find_first_zero_bit(process->doorbell_bitmap,
>> - AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS);
>> -    }
>> +    else
>> +        offset = 0;
>>   -    if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>> +    found = find_next_zero_bit(mes->doorbell_bitmap, 
>> mes->num_mes_dbs, offset);
>> +    if (found >= mes->num_mes_dbs) {
>>           DRM_WARN("No doorbell available\n");
>>           return -ENOSPC;
>>       }
>>   -    set_bit(found, process->doorbell_bitmap);
>> -
>> -    *doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
>> -                process->doorbell_index, found);
>> +    set_bit(found, mes->doorbell_bitmap);
>>   +    /* Get the absolute doorbell index on BAR */
>> +    *doorbell_index = mes->db_start_dw_offset + found * 2;
>>       return 0;
>>   }
>>   -static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device 
>> *adev,
>> +static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
>>                          struct amdgpu_mes_process *process,
>>                          uint32_t doorbell_index)
>>   {
>> -    unsigned int old, doorbell_id;
>> -
>> -    doorbell_id = doorbell_index -
>> -        (process->doorbell_index *
>> -         amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
>> -    doorbell_id /= 2;
>> +    unsigned int old, rel_index;
>> +    struct amdgpu_mes *mes = &adev->mes;
>>   -    old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
>> +    /* Find the relative index of the doorbell in this object */
>> +    rel_index = (doorbell_index - mes->db_start_dw_offset) / 2;
>> +    old = test_and_clear_bit(rel_index, mes->doorbell_bitmap);
>>       WARN_ON(!old);
>>   }
>>     static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>>   {
>> -    size_t doorbell_start_offset;
>> -    size_t doorbell_aperture_size;
>> -    size_t doorbell_process_limit;
>> -    size_t aggregated_doorbell_start;
>>       int i;
>> +    struct amdgpu_mes *mes = &adev->mes;
>>   -    aggregated_doorbell_start = 
>> (adev->doorbell_index.max_assignment + 1) * sizeof(u32);
>> -    aggregated_doorbell_start =
>> -        roundup(aggregated_doorbell_start, PAGE_SIZE);
>> -
>> -    doorbell_start_offset = aggregated_doorbell_start + PAGE_SIZE;
>> -    doorbell_start_offset =
>> -        roundup(doorbell_start_offset,
>> -            amdgpu_mes_doorbell_process_slice(adev));
>> -
>> -    doorbell_aperture_size = adev->doorbell.size;
>> -    doorbell_aperture_size =
>> -            rounddown(doorbell_aperture_size,
>> -                  amdgpu_mes_doorbell_process_slice(adev));
>> -
>> -    if (doorbell_aperture_size > doorbell_start_offset)
>> -        doorbell_process_limit =
>> -            (doorbell_aperture_size - doorbell_start_offset) /
>> -            amdgpu_mes_doorbell_process_slice(adev);
>> -    else
>> -        return -ENOSPC;
>> -
>> -    adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
>> -    adev->mes.max_doorbell_slices = doorbell_process_limit;
>> +    /* Bitmap for dynamic allocation of kernel doorbells */
>> +    mes->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE / sizeof(u32), 
>> GFP_KERNEL);
>> +    if (!mes->doorbell_bitmap) {
>> +        DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
>> +        return -ENOMEM;
>> +    }
>>   -    /* allocate Qword range for aggregated doorbell */
>> -    for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
>> -        adev->mes.aggregated_doorbells[i] =
>> -            aggregated_doorbell_start / sizeof(u32) + i * 2;
>> +    mes->num_mes_dbs = PAGE_SIZE / AMDGPU_ONE_DOORBELL_SIZE;
>> +    for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
>> +        adev->mes.aggregated_doorbells[i] = mes->db_start_dw_offset 
>> + i * 2;
>> +        set_bit(i, mes->doorbell_bitmap);
>> +    }
>>   -    DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
>>       return 0;
>>   }
>>   +static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
>> +{
>> +    bitmap_free(adev->mes.doorbell_bitmap);
>> +}
>> +
>>   int amdgpu_mes_init(struct amdgpu_device *adev)
>>   {
>>       int i, r;
>> @@ -250,6 +229,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>       amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>>       amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>>       amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>> +    amdgpu_mes_doorbell_free(adev);
>>         idr_destroy(&adev->mes.pasid_idr);
>>       idr_destroy(&adev->mes.gang_id_idr);
>> @@ -679,7 +659,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device 
>> *adev, int gang_id,
>>       *queue_id = queue->queue_id = r;
>>         /* allocate a doorbell index for the queue */
>> -    r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
>> +    r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
>>                         qprops->queue_type,
>>                         &qprops->doorbell_off);
>>       if (r)
>> @@ -737,7 +717,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device 
>> *adev, int gang_id,
>>       return 0;
>>     clean_up_doorbell:
>> -    amdgpu_mes_queue_doorbell_free(adev, gang->process,
>> +    amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>>                          qprops->doorbell_off);
>>   clean_up_queue_id:
>>       spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
>> @@ -792,7 +772,7 @@ int amdgpu_mes_remove_hw_queue(struct 
>> amdgpu_device *adev, int queue_id)
>>                 queue_id);
>>         list_del(&queue->list);
>> -    amdgpu_mes_queue_doorbell_free(adev, gang->process,
>> +    amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>>                          queue->doorbell_off);
>>       amdgpu_mes_unlock(&adev->mes);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index a403418d5eac..2c604e04fd5c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -27,6 +27,7 @@
>>   #include "amdgpu_irq.h"
>>   #include "kgd_kfd_interface.h"
>>   #include "amdgpu_gfx.h"
>> +#include "amdgpu_doorbell.h"
>>   #include <linux/sched/mm.h>
>>     #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
>> @@ -130,6 +131,8 @@ struct amdgpu_mes {
>>         /* MES doorbells */
>>       uint32_t            db_start_dw_offset;
>> +    uint32_t            num_mes_dbs;
>> +    unsigned long            *doorbell_bitmap;
>>         /* ip specific functions */
>>       const struct amdgpu_mes_funcs   *funcs;
>
