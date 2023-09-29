Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F840E728CF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 17:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E2A10E198;
	Fri, 29 Sep 2023 17:50:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3CF10E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 17:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5LcVopjafKgTcWyzDOovHaU+J0aE1cKzg2oMsUOucF60wmnxb8jphSMLy6REVh/FfOQuzl7aVnzjoOQX6foECenJjn9sYTxN3plkIo2fKVhCBXgPtDqYVh1J3u4qb8Hqhs17WN4tiWX4eVjidHp8ihKXzQK13as5VeW2E1RXhxhW2S9v8fuCW0juLB6g2xxIFPxvrq9r55X47iOdtMFMRUMU2Uy/3yNjTihznl6B0SeJRqkyrWzu17eJ82x2GCKemcP0kRsyC5CySTU1Vw0DRmDxzLfBakAD3b/rbO8VQpdtUnjJd5lGkCM21XyqPoky3IOTeF5scs9RCD6lOP7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZzRu1NWC6czCfr7/ZXAmXWlpx5/Wgg+Q0DKwbPJ7fg=;
 b=ABTaZS6Ju6h8j8JKWHf4e2XhOYedVmcqDhmVt0KNHE3WBh+JtLkmAaxf7KFEytN9MV+bhIgS+uP6Kiiyok1r6LhL3OoGnenKEdVYokh5h3LaKYbD2t4WabVid9iNUhu0UUpCNJKR1BVY3vrFjaGdqkAlhHNTuhcZ7Brzq9BFeQROD+/mD7NoCggIue2gWtSHtI+k7TF8EfiaUSzYwBAUlwDID5S6nBZodgqYTsSngNE2LKmbcL9muVV17p+hBCTV+LoIxooHuizpdOKnsIKC1cQLXI/kgI1X8z4/35aYcjGr5Zr5N5AmrV9HZRotIOwiHkqY+Ty/qi83SKvTllhHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZzRu1NWC6czCfr7/ZXAmXWlpx5/Wgg+Q0DKwbPJ7fg=;
 b=HktIA8ar4SpiJpnItBB35gEVPiD/mlmc8qc1vnjySwLwWwaQaV8m5nM+qdQ3TLzSUOHIDb6Slb7+a/mZOIbym/vvKy7plIFtdV7orA7VDDnHfSDwDcurG5NRK7TKfejVSEj9AzfS8HFz5aDaCIdes9F++mEgE15W+dclF0k3gZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 17:50:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::76fc:3d1c:27c6:61da]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::76fc:3d1c:27c6:61da%4]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:50:09 +0000
Message-ID: <deb6a51c-3a4b-fcb5-7b5f-ff0eade3d72b@amd.com>
Date: Fri, 29 Sep 2023 19:50:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 5/9] drm/amdgpu: create context space for usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-6-shashank.sharma@amd.com>
 <CADnq5_MiNtSswTycxUQu0MfbD80LNg1M0=NCJ_1Br2Ek=ir-ig@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MiNtSswTycxUQu0MfbD80LNg1M0=NCJ_1Br2Ek=ir-ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BEXP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::27)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: d04dffff-ead8-4b09-0796-08dbc1148610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU6QgjAMPEPY8CeGo3b2ahilPyO+8EXeVx06js0Q+QIHDs6BLVJKZzHZojmYWWZnCvX6ZEvSWrKPOCmpyPkl2szF9DAVam53xJXhb5d+83rZdXGp0ggrBzzAUtBtkonDwzRwkCk0oBEzM65tCg+Wcaei5CT0Vi67Q9X6I/cDADylhPIRVlc1nnbk7V1u+K0RpGm7pkNumYauGSYnkWUFja6ZpYjxKuXczsjY/XNbKBoxpKxGhsNyKbgaYIYkbQrdVWgAOVVo4a9k/lhCuBNStjbLVOG52lgemjJmzKFuKT2n/6CVvR/xQqDZFmN5kMGj3p3VUDIdRs3YbX98wbFMfJX52+GxuonE5ffM2sgFrXWRPpeaofe89mqAOnKv/UXcFuEUxWzxih4+YQsZ5f6V4Vl1TkXyQBZEug/WrA8pf5lmdMDAQ1uivUhnbWogxyxALHqMuu23Nz8oP1sSX7rGfuoXqyh8J7940tw8nqkmkTo/9mSC0DsBcYPjbDaKGaiavXAQv08JCfLs/E7GWCf5m72DR3OSjrIEp20O2iOOXlmJYFfC0bzBd5yM2neB+Eobqfvd07T/ndmlM+2lsQV/ZqLX6UzwswfqfPChA3YuZPT5zqEvILSgVhuJ8pOpNT7TcoBVpREVbRyKUvsyXaGeGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(8676002)(86362001)(4326008)(44832011)(8936002)(5660300002)(66556008)(31696002)(66476007)(41300700001)(54906003)(6916009)(36756003)(2906002)(66946007)(19627235002)(38100700002)(83380400001)(478600001)(6512007)(316002)(6506007)(2616005)(6486002)(53546011)(26005)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHFrNXMxVmR0RUpnMldwMkkzTTIva1pPMmV4K0NaTzZHNXA2ZWVRMjdKSjk0?=
 =?utf-8?B?SWJhQzdpKzVLbjQ4ajVtQWY4Rms2UVZJc2pDN3ZpbkNWMmlGVVFURHMvZmQr?=
 =?utf-8?B?cDVtRDNPbnBzU3VFVlkwRWZYOEZOR013TnNDV2U2WE56cWFHQ3FZa3F5TnR1?=
 =?utf-8?B?ZThZaGhsUGk5TytOY041UTZpUHRTdC92Z3l1NGhzbGM3RGZMQ2s3UWNYcXh0?=
 =?utf-8?B?WngwS3lOMm5FaSswU3RYRnJ4QUU5MDlrTFFGVWdYdjAwTjFJbzJCVmJMN0xr?=
 =?utf-8?B?TFdpZzZJSnFDZmtYaXlqTXplSDdTd3ZFSjJhVEN3RTk1alltaDR1MU5PTDVT?=
 =?utf-8?B?ME9XUWtad3NBUmJkT1lqNTNrVkpBcVBqT1dWVTJibllzK3ZyZ3RpU0VHcEt4?=
 =?utf-8?B?czlVTXFkQStscGk1a0E2RDVvLzNkQWdQeDl0RHdrU0VDaGNrMVhxQUo4VFlh?=
 =?utf-8?B?RDB0Ukg5Zk9wVW9YMlZ2QlRJMzl6T3F0QXlNdWV1QUxjbDRsUWRBMktsWTBa?=
 =?utf-8?B?VEd1NElFYWM3YmxRS0JBZUg5SFVPREY2UEd6VXd1N1FrSXFKaVlMQS9EbFZZ?=
 =?utf-8?B?cXNMOUVNZnBSdEFxbU4vUmtRTThkT2hLREs0S0lyVndJUXI3VjMyMEl0aU82?=
 =?utf-8?B?TTlZbUxuNEhXOWc2alF1U2tKVDVLQmxxSFpYQmxDMHJrMk5hdFJDaVV4Z2Jx?=
 =?utf-8?B?enJHTzBsTW8rTmdvbUM1VDN0dHRhQzdDZ1R6RDhQZEN4R0NYaTNCVHUzMEZk?=
 =?utf-8?B?SFpOQnZXYUluWVlvaUdRY3JJY1o1UWNSMVdVdkhZbmdoVktmT2ZXSUI2WXRj?=
 =?utf-8?B?ZThVUjFMU0FTZTNodjdWUU44VldxVGNUWEdWUkRJbkVvZ1hwK0NhY2lLemJX?=
 =?utf-8?B?YnJaM3ZtVDVCd1VVMGQ4SlNoWS9IbGJua0lkSnhhZkFKRGNrVHo3a1BULy9Z?=
 =?utf-8?B?Q3ZOSm1GTE1ucHYyM0pJbUxwaXhNUnNaT1VRZ2FndGVmS3lQT1E2QUo5b3ll?=
 =?utf-8?B?ZWY4cWFSUTltdFVaS29tNDNQV0NTZ0FDVmlWVTBFeUFBWlJpZ25XL2Q5bmNx?=
 =?utf-8?B?eDZiT1REckVJdWZWK2w3WjF2WmREdXpHUStsQ2dVODRSUkFXSmVFZWhMR2lU?=
 =?utf-8?B?UlZmWG5icnJIQkxNK01YWlRUVEdZMWRod0NKbnljNzRBckhTK0JLenJkZkR3?=
 =?utf-8?B?anZXekJ4aEJ3a20xVTI3d00zZXpGSmhVYUg0VUIwY2FBdGljaTN2cEFib0lK?=
 =?utf-8?B?MkE0YVBaN3lhUnplVU80QkQyRUtYUlYybURnWCtpbXhKcndhUW9LalhiWnFC?=
 =?utf-8?B?N1c4ZzNxSzE1QlBRbU84MVh2TFM4TmVzRTNUeWV5cG8rWnlrVyt3eERTbElC?=
 =?utf-8?B?MnVEM0NMWW5aWVg2dk5KTFZhK05NM2R0MHFkYzJWZW0rbEJmek1lbmthOWhy?=
 =?utf-8?B?Rm5RSkdXcXc0dFBpYjI5VEZKM0dzQkJoUEczWXVmaWZtUFV6Zm1id1NLL1Nm?=
 =?utf-8?B?TnUyS0pPenQvYkx4R2tEU1JhQ2FDWVNBbllPLzhKbDFsSE5HbDZEN2NoWG5i?=
 =?utf-8?B?WU1aWFBNdFBGRW5UK2Z2ekl5U2dIaDJ5ajhaVDZQNVNkNFJDLzdOdDdoRmxM?=
 =?utf-8?B?Ry9oWmdjc1VUcUQrQWx0V0FRcUFGOEUycFJ2V3FEVE1KYk8xZ0JmVGlIcitD?=
 =?utf-8?B?VGQ2dDBWdDdXS2RMS2pnUEMwWUd0MU5lbmRGQm44OGtGOHBFaHFVbG1DRHNj?=
 =?utf-8?B?c0w5dVdOdkJpMnhPaUlKTnA2VDM2eVlldjNETTltd2RYeUpkcnN5WGV1ZlVy?=
 =?utf-8?B?NXFTejRCK1JUa2t1alZjOFJiMDFTeUQwQWFQMTZWOUR2a21WRGozd2QydGJE?=
 =?utf-8?B?b3czcFk0OUUyUFBSaGQrVDB4Rlp2bGhSbksxbVQwUmR3VGo2SnhqYllKaGtw?=
 =?utf-8?B?elZET2xzdHdhUGFzU2RxbDcvemdIUTNXOUdvMWpkRUN5czRWdjNTL3JPb2lF?=
 =?utf-8?B?Wjc4ZmpLcEJJTXV2NEg0NlY0YW1haDBySVo3ajNwMGxBQzREZTdMV3dHdDBx?=
 =?utf-8?B?YTdlQ3ZrTGFWKzhsT1NIcjVyT3hLNmJRZ2VrVVBNbk1NMUUzWStmUTNXa0Zz?=
 =?utf-8?Q?D9P+S97IKxUuxHYQIJiP6B0Ju?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04dffff-ead8-4b09-0796-08dbc1148610
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:50:09.9080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sprecEYwDvdNpglxHFuENewpuarD0mcuL9Jw+EesERZDmXHaDAj5bM7D5kPWdt+m6xJH1m0qBjhbM5bpBbARVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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


On 20/09/2023 17:21, Alex Deucher wrote:
> On Fri, Sep 8, 2023 at 12:45 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> The FW expects us to allocate at least one page as context
>> space to process gang, process, GDS and FW  related work.
>> This patch creates a joint object for the same, and calculates
>> GPU space offsets of these spaces.
>>
>> V1: Addressed review comments on RFC patch:
>>      Alex: Make this function IP specific
>>
>> V2: Addressed review comments from Christian
>>      - Allocate only one object for total FW space, and calculate
>>        offsets for each of these objects.
>>
>> V3: Integration with doorbell manager
>>
>> V4: Review comments:
>>      - Remove shadow from FW space list from cover letter (Alex)
>>      - Alignment of macro (Luben)
>>
>> V5: Merged patches 5 and 6 into this single patch
>>      Addressed review comments:
>>      - Use lower_32_bits instead of mask (Christian)
>>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>>      - Shadow and GDS objects are now coming from userspace (Christian,
>>        Alex)
>>
>> V6:
>>      - Add a comment to replace amdgpu_bo_create_kernel() with
>>        amdgpu_bo_create() during fw_ctx object creation (Christian).
>>      - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
>>        of generic queue structure and make it gen11 specific (Alex).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 61 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 6760abda08df..8ffb5dee72a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -61,6 +61,9 @@
>>   #define regCGTT_WD_CLK_CTRL_BASE_IDX   1
>>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1  0x4e7e
>>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX 1
>> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>>
>>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
>> @@ -6424,6 +6427,56 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>
>> +static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                             struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>> +
>> +       amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
>> +}
>> +
>> +static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                           struct amdgpu_usermode_queue *queue,
>> +                                           struct drm_amdgpu_userq_mqd_gfx_v11_0 *mqd_user)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>> +       struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>> +       uint64_t fw_ctx_gpu_addr;
>> +       int r, size;
>> +
>> +       /*
>> +        * The FW expects at least one page space allocated for
>> +        * process ctx, gang ctx and fw ctx each. Create an object
>> +        * for the same.
>> +        */
>> +       size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
>> +              AMDGPU_USERQ_GANG_CTX_SZ;
>> +       r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_GTT,
>> +                                   &ctx->obj,
>> +                                   &ctx->gpu_addr,
>> +                                   &ctx->cpu_ptr);
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
>> +               return r;
>> +       }
>> +
>> +       fw_ctx_gpu_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ +
>> +                         AMDGPU_USERQ_GANG_CTX_SZ;
>> +       mqd->fw_work_area_base_lo = lower_32_bits(fw_ctx_gpu_addr);
>> +       mqd->fw_work_area_base_lo = upper_32_bits(fw_ctx_gpu_addr);
>> +
>> +       /* Shadow and GDS objects come directly from userspace */
>> +       mqd->shadow_base_lo = lower_32_bits(mqd_user->shadow_va);
>> +       mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
>> +
>> +       mqd->gds_bkup_base_lo = lower_32_bits(mqd_user->gds_va);
>> +       mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
>> +
>> +       return 0;
>> +}
>> +
>>   static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                                        struct drm_amdgpu_userq_in *args_in,
>>                                        struct amdgpu_usermode_queue *queue)
>> @@ -6480,6 +6533,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                  goto free_mqd;
>>          }
>>
>> +       /* Create BO for FW operations */
>> +       r = gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_user);
>> +       if (r) {
>> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +               goto free_mqd;
>> +       }
>> +
>>          return 0;
>>
>>   free_mqd:
>> @@ -6492,6 +6552,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>>   {
>>          struct amdgpu_userq_obj *mqd = &queue->mqd;
>>
>> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>>          amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 240f92796f00..34e20daa06c8 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_vm        *vm;
>>          struct amdgpu_userq_obj mqd;
>> +       struct amdgpu_userq_obj fw_obj;
> Since this is gfx 11 specific, I feel like this would be better stored
> in some gfx 11 structure rather than the generic user queue structure.
> Maybe a driver private pointer here would make more sense, then each
> IP can hang whatever structure they want here for IP specific
> metadata.


I was thinking more on this, and to me it seems like it's the size of 
this FW space which is going to be specific to a IP, but some object 
space probably will always be required, as MES will always need some 
space to save its process and gang ctx. So if this is not a big concern 
for you, I would like to keep it here and see how this space requirement 
evolves over the time.

- Shashank

>
> Alex
>
>
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.42.0
>>
