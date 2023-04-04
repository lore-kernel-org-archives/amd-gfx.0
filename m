Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734FEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FEE10E00C;
	Tue,  4 Apr 2023 16:36:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A0810E00C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kul3dC75kQWri1HtNk0dy6KBKB4JchTo40yM42lrpbuvywd27D/2cq5uwiMmFzx0Wuql0GPSQdPn0AUHpKazV9vsuaWLUi6fXx2LYDwLMwbcdJd2YewHRCQHLsNrriMwxsXTTi36dufMLZj0t2Rev45PShhVD1jozx+P/gEkCpq749KYFvFydoAjvaCL41rBerTYd7DnJNhqC8jWYtSsBRUyhOkkb69ouAkTG6xF8ks2lh00vpV1bXoV6yN3esLVPp7J9Y0qjO+a74eHpZ1KJRu5Jp4qfyu/DUYG0fc0e+uAGIuwEc/dk/gLBsk0ieKEOACZTN90xUGptvFce8BD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjRzdBpZvGriqUKY7iripO9POUujwlGyz2L4P++e+Gs=;
 b=LmjMak+QTBV7F8CPQTT6L5Ccta6SUNIIn4CgQCZn6nBhLG/dKyib/91IDO7ZVCWzZ0VRXdXEnf6tcUUW/D5bSiBrKhOG7h61E9MPMhO+CO9NUwld2FrUdo/wcSZZvaBr3x+7EMLO2YsKgGA3bttV66m4ccqjztcCOYf408a1jXrjn3WjgfoxajHU6uxfZg5P5Ku2fHwt2nRMnFCS71qcRlhxCFzqYWokciRLpq/GCf9dllEKal2NTua9zCTQsFRD+DDyLOdI6zzVpyIJDZW2AsFmSzMaR/0QBBpTydJCQuwq0rj85wJc+LTJ59GHkOIFd4fiNZAELV292tDnBMPXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjRzdBpZvGriqUKY7iripO9POUujwlGyz2L4P++e+Gs=;
 b=OctKMMHVrZpEKrFvve4B91j5Ft/tSxhgZVAwcbYi0XszORx2odyeV/p5mUtIDyWpeeDkXbycERFZZYgVfyaZGW6K3YY5dhnR6NfmXpiIfShdTPfvUbsLGz864BA/dBFiFrBEUsoXIKAmJ1PL6ZbBi8XEwz6N0SXbnPmu536eTdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 16:36:12 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:36:12 +0000
Message-ID: <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
Date: Tue, 4 Apr 2023 18:36:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f1e790-64d4-4729-2300-08db352ab3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIzRHx5fnFh3Gm4ZWpCA8bF6gegTF7s+ashDAjbVE9DfsXnYUK+T60agHBaLnga8yjPCu+e9sa3RnJsTjg+/dE+f+WRfxlqjODt5fo+ihCGql8+UTfdIU8sPbwsX9pi1w1+QG5ZjOIzuoDY8auqNMrtDEjkrzDa+bnZTu0xDgW9PdLf99ajnBdbhsMvYQTO18VU8e9ufUFx1jmuJTbpyceZ5HZRuxxu6P8ytDMxUnupSJMT2HHtaCkR3iwEpQsmEiiaKwpxemIiVcydyfR2NyM2X9aDZHMmthHjcf87AEvB0bboEnk6y/D90uMVMTt3pPYlEMVrR/NjnMGraGgsNfM5Hknr3NMYEXVUyTBc4aALJjqDcYcWHVkEKemUWUSLeABcUcqD0YzBfB5/oHG1NDvDAD9z5fGdMJezNIlkr9Qy/G/eOF1nsnfgwscPljb5AgnGaP6EPS2eaMDoks+O0sIY/4YYGpitzbJN1opCq69ftPchjYg3YJy2hOD5TwEkC43mXROIVSVmiohJVu3odM7cCZINGrfBopaJEEYGRtiV3U++Jb03A4Qbw1vxYfvPZ9cALE7YliR5MJeSX2HxgHT0Xdxy21urojroksG2yjwgLzJ92H+ZoEVvSsr04QrIAgP24A+xosupKaJ5tzd5EeFiSetggMbhkcUXlqbf9Xq1VqKdxVO5GTn+BPMPxApV3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(41300700001)(6506007)(26005)(53546011)(54906003)(478600001)(316002)(6512007)(4326008)(66476007)(66556008)(66946007)(8676002)(6666004)(44832011)(83380400001)(2616005)(8936002)(31686004)(186003)(36756003)(6486002)(5660300002)(38100700002)(2906002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1c1SjFUQ0lad0p3alJEUll1QlVQSitDU2JIZ2dKMGF1UG5iUGlpckdJVjZs?=
 =?utf-8?B?STA5MFZSQkVrVEpSWDV5MWJFZ0tobnNGbWRzMGtTaUJrSnVUTnpJYXdiK0hh?=
 =?utf-8?B?RkdOYmx4OUVnZ2pWcnBCQVpkZExjelovbEcyNFhyR2VQRkUvcFhyU1VVMzEw?=
 =?utf-8?B?SCs3akcybm01aFd3MVdrandKU1NvL1R4aW5rdVVsWUlGTjN1YjBaU2xOOW16?=
 =?utf-8?B?SlZaMDk1dG9mWS9PZEdjeDZKTWJCNFpiWVh3UG9vVllYcmxneWN4V0xjVmhl?=
 =?utf-8?B?SDNObTZpc253MWpGdm5ackE0S1kvbXp3UDRIN3VvZTVqclkwaGJmbnNKSVJ1?=
 =?utf-8?B?MGhkQ1dlZGJWYjU5QjFKOEdQQlRxbFRiZE9CQnhaVVhId1JDT0kvRHNNUiti?=
 =?utf-8?B?OGNYZjVmem5udjI1eEQyaVQ3YXNqMFZQMDFTenZlakdnTXdPaVRmQXVIbklT?=
 =?utf-8?B?S0x1KzlyYzNrOEt0ZEpGQysyVU9aOUJNYURXMVgrNEl6QWx4dVcrU2gxWlRn?=
 =?utf-8?B?K3lKTGpYakFVUVV0eW1SaWg0WTdDNXRiS3RndVhIcVFOTjhCY3ZyZEo2SEw2?=
 =?utf-8?B?UFN0eUFUcTBpeWdNR3pZaWVydGRwZkhHL2l5bnVVVHZRU2FPL0taa2dLb2pN?=
 =?utf-8?B?OUJzS1ZFb1RSSGRTQWpXN3RWblRadURXVWpYZklmZDVtMW5XTXk5dGRaR0dN?=
 =?utf-8?B?NkdoSlE1dzcvclAyZUxGaGt0RkNlRXhENUwxRWxmcUx6RHVBZytQWFR0aDdY?=
 =?utf-8?B?Rmh0RUxGT04vdzc5bmNVcmtOV0RjNURiSXJZbXhlRFFFa1BDZkFQQXIwQkZr?=
 =?utf-8?B?blF4anhaQStRYkwvLzExR2FzREwwOFdGNXRhZkNoZXRzMU5nekpOZFRQMENR?=
 =?utf-8?B?ZUVtM1I4bW5kMHc0ZVhMZG9qTnZWSmZUM0ZXM3FlRXdLaGRvSlpLMGFMbVB3?=
 =?utf-8?B?UGx3ME9NaUlLVmQvUVh0T1paZE1vZ29ZbW95QzRWU3A0WlVEbjk1VFRMTFh0?=
 =?utf-8?B?ZmQ5c3FxQitvNGxPTVVZMWJ1ZWxuSWxPOGROSjZTVm9lOUFCS3pzRVhSQlNN?=
 =?utf-8?B?eFIzK2ZVZHplZWdLZnh6bFBobTZSN083U0tsN1hhMGl1MmNoem0zTjVicHZD?=
 =?utf-8?B?eHRzUWUxa2FhZUF2TzRYK1JCNjNmSWs4YUZjWDZuN0V5NktYaGtZOS9VWlkv?=
 =?utf-8?B?ekY4N3FKOGs3ZmtWS1l2cG9aTUlEWUFTaktMSitYeVpUaXhyY0drTnd6MEZX?=
 =?utf-8?B?ekNDWkFRUlV1R0o1Zm5STXlxQjV1VVNQeFBhUmhtQjBINVdmZWpQeklyOUE2?=
 =?utf-8?B?WlIvQlZYaXkrNitWNFZmUXJUTS9DL1g0TkRGTmt2c1NUQWkvcmE1NFRuQXRm?=
 =?utf-8?B?WEhvcTBCMnVlMHpXTHltdDZCd3FxQzZMWVEyWGZTOEtYY2lzWTdHN1ZCb1N2?=
 =?utf-8?B?NTZmN1JmRGRPMFRhbmVrVE5UMG92VjlYemJTTzdpNWkrcG5OTmhvc0svVjVH?=
 =?utf-8?B?ZThzNnkyRVpoZDNkc0cxTTkxQ0wrWG92bENNVmxnOGJqTFZtYmxCMnRCd25q?=
 =?utf-8?B?NDFqclRkREJCeDZ2bFBMM0gvS0ZJa0ZYaUFvTlhnTXRjMFhweDVGNTZZelNR?=
 =?utf-8?B?cE9SdVBxUytOSVlNSDJ2bnQxTW9LRDg4bys3aWUvbXVpVmRLMzZCTTMwMG0y?=
 =?utf-8?B?N2l6ZkxiTWY1V1FrVmorc1N0MzZnRlNJOWR3SDZIcURHcmZCMFJyWmZiZm5L?=
 =?utf-8?B?YVFid3huaUxaaTBlc3lIYmxXTXVhbmtwT0dZSGRnV3o0alhST2NUMTE3OHVq?=
 =?utf-8?B?dkkwNkZmRGRuN2xSZGlYUHVjMDVyUEpkS0dOVzhiRk1ZNnE0RlhHSmdvZXRP?=
 =?utf-8?B?ZDJpYVd1YktsUXVaMlA0aldDeTJsT3pIYVp2VVBjUDJ5bnFkdnFpbUpQVldX?=
 =?utf-8?B?ZDZ6Q1A1cGdWSngzY3JZeXBac3JQazI5cGNhN25DSHlmbW9mQmR1WC92ZGNo?=
 =?utf-8?B?NGpRYWJ6N1Q4a1FEeXVtTTl2MVY2U3ZrQzFtRE04MU5Nc09tQ2xLTUltZEl2?=
 =?utf-8?B?V0lkZGxxMGMyOTRFS1BnTVBLSTd1aGJDR1MwWWtmaytTek92Tm1naHNJMmlI?=
 =?utf-8?Q?R2c5tGN9gwPXdDH0tcESaz6u5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f1e790-64d4-4729-2300-08db352ab3af
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:36:12.6129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0DmBEwzmE8jwnhs2EciJJr2nhN59PKAs0yq0dTXTykX7F03ElXw2nX2fHL1KtIrGDR2VVuOcrPPGYkJItXlpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 04/04/2023 18:30, Luben Tuikov wrote:
> On 2023-03-29 12:04, Shashank Sharma wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
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
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
> Just add all your Cc right here, and let git-send-email figure it out.
> Between the Cc tags and the SMTP CC list, Felix is the only one missing.

No, that's not how it is.

You keep people cc'ed in the cover letter so that they get informed 
every time this patch is pushed/used on any opensource branch.

People who are added manually in cc are required for this code review 
session.

- Shashank

> Regards,
> Luben
>
>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> index 39e90ea32fcb..1627641a4a4e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> @@ -23,12 +23,73 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_userqueue.h"
>>   #include "v11_structs.h"
>> +#include "amdgpu_mes.h"
>>   
>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>   
>> +static int
>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>> +                         struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_add_queue_input queue_input;
>> +    int r;
>> +
>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> +
>> +    queue_input.process_va_start = 0;
>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>> +    queue_input.process_quantum = 100000; /* 10ms */
>> +    queue_input.gang_quantum = 10000; /* 1ms */
>> +    queue_input.paging = false;
>> +
>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +
>> +    queue_input.process_id = queue->vm->pasid;
>> +    queue_input.queue_type = queue->queue_type;
>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>> +    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>> +        return r;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>> +    return 0;
>> +}
>> +
>> +static void
>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>> +                           struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_remove_queue_input queue_input;
>> +    int r;
>> +
>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r)
>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>> +}
>> +
>>   static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>                                                    struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>   
>>       amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_unreserve(mqd->obj);
>> +
>> +    /* Map the queue in HW using MES ring */
>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>> +        goto free_ctx;
>> +    }
>> +
>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>       return 0;
>>   
>> @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>   {
>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>   
>> +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>       amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_free_kernel(&mqd->obj,
>>   			   &mqd->gpu_addr,
