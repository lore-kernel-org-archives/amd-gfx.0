Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A743C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 09:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F9410E289;
	Mon, 22 May 2023 09:06:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47BE10E288
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 09:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzpvePt2c9jv6nWMMjGSCavIHDwE+PIj7rGFYO5mTpRZK4LisKrvAdXMDl3PP34JDKOHvQQXLHebSI6eRPgg02N/3OEihvBz1JR1JCq8kd0n+w30SXGWgO8bpbaa3tVC6KGCePfT8hrhjbGUldlBj/aRmZWDr1RcXSQTIqevSSRkqcVRtPVQsXJjyvoZku7HH4E/eGLMNEffrfU3l3PkZX0VnI9ZcismL4bl6wc88ykfqk9ZstPhYeygNeZfRRsLKozdXdKJrjTy4Vt2q3wyYrVEB5WXtZJfshhXOHGucJZFWqwxKE/4kwWCOGXkXdKgt5dUfL/zUW4+nZQPNZjZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMUMo8GHI4bysBLsvGuKEU7rU0gdbw5Y8ep1sILjqJs=;
 b=ZoahokoLsSp1Y9BX0O9bq2Vp2LeZJb8LFdtArYjNbdGyM2zWl+nwb2tYPoxhWZfvrw5Gy6ceImFpWpXeC/8VjzPtpp736ZMLsCQoxdspMcV++RJeQmM4168xmzXkRoz+/ctuUMfJDiX2v088Wr8sLAndqzuMO7WkXEFbc6WulKnd0B0WkY1JwwRcNI0wQK4r81mSf94VxuKZ1dSU/maVPu7tVP/HcGDbrk5+ncsvL3Hh/7uWzUG4Z76urIhTjR5O8/Imiswd+VhOwGGbWWoYhLF2xgI6jAcNjMhT+COCrKq9gruMDUE2U8FnYtZa6DMETo9F4GR6V5bqhwm+IUJ7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMUMo8GHI4bysBLsvGuKEU7rU0gdbw5Y8ep1sILjqJs=;
 b=zXRE21JPlMoaG5J627rUoA49C0GhvgQTQq5j4uVj14lZfTbe13W985zrs49OwHaTm7JpmkscTeodpqAeuQ7kd+Zw80VHY2JWauQgNo4AQ2cSWtZDr2KKOD/srRz+LxTfwMSKkyIoTuZs55I3/Z5A5ejpmeSJUOyDYNXr5TGf1fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:06:06 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:06:06 +0000
Message-ID: <217fd010-5a17-a6aa-24c0-e08cbbe5a7de@amd.com>
Date: Mon, 22 May 2023 11:05:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 05/10] drm/amdgpu: create context space for usermode
 queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-6-shashank.sharma@amd.com>
 <CADnq5_Pza5G2w5ECAFNzS=fQDpgmZcgyrYaEpoOjCnWwUKwouA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Pza5G2w5ECAFNzS=fQDpgmZcgyrYaEpoOjCnWwUKwouA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: edd7907c-9c16-40f1-6692-08db5aa3c67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIF38E/+/3ej6wI5fJ+uF33Zgx5LK1eDvMD7qS6z+t7efiotOnUONszKswWyKTvNQvQgkkNBKTSW80cR2auibH3OJHLlXMimcbk+7la2rQQPQARS3kT10ZK6jSJiTm0MUPQxqPZwoRtLiswPO64tye4ejD2gig/+2HlG9FOrQlv05bU7WFI6K1WuFekLSLLJq8vnyN89P5do8SXHTo7miUWLeTGX+8HmvPuG5L3b1Vw25pSYXNTNHTCKXqctqaM3DGb/mDC9btLtVOQLakJeMZHctVEiuxckK0Dkb22vuCHf0WKp6yNsbdlWAnf76kq402nY1ECTOonxEbTJQOq2XBPKh/JpGK0W/J6iF0HfQdCEAGnrrIrc0QgFqcI5Rf/1QMY3RppDQGAXq6DvoGcym6++qXO5dWW1pMJI/qRC30b7V8J/RmWmevbrN18L7hYZ0/pK3RdVHu4KlqvjWVhf7P0oiucHOZzc+Kq4P4Q89h4Dj+QwzfovbpiSh7gjSFJfipQKVbjCilWLJmRgOlSc7JEi0bA0V38ir1iBlxiTKS1wthv+vMtUJfNrb0tUrb7HAJktAmtE7C1szu4A8D6LFIcHeuR5OVfuWt3HJD/tzqjfktxttQtimLpimf3u9tdBRmR0jYMiMOprQbraP34sSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(83380400001)(186003)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(6666004)(54906003)(478600001)(53546011)(5660300002)(44832011)(26005)(6506007)(6512007)(8676002)(8936002)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJJUmpTWWx2M2lqb0hCZXRiNFc0bGltRmRRbDJ5dXp2enl0RGEvL0h3TjRS?=
 =?utf-8?B?NHVYaU1LOUl4Ym9HclhMN3BmQ3ErSjlZWmdBM3ZXS0k1b3FORHNEbG5hQUVu?=
 =?utf-8?B?aUNtTVZBV2ZNc1hIUGRiaVFDeEFUL01rYURMS256ZDN0Y2ZIWnk5cHQ4S2Yz?=
 =?utf-8?B?c2hvSWRJNk9DeHpFc09LYkhOQ2ROZElROW9hcVRvTlNiVElzYlZvdkFFK0tI?=
 =?utf-8?B?TzJnOUJ2a1ZNdzgxMWx0d2hyQ3dpaGZvME1ickp3NHJEcUlEZDlhVERWaHEr?=
 =?utf-8?B?WnZCMHRRSkljQ0xUUXNSUjZkUm1LbS9vVE54RDVJdi8rNzdkNVlNMHpFZWpY?=
 =?utf-8?B?WVl4UW41UFNrS1dqZmtsK1RnRVlzWm9PYmUxaFZndXozSTUwck93a3lBRmdn?=
 =?utf-8?B?d0J3Z2VTR1cvdDZFd1VnK2VPMFNjenlRa1lwbUZjYllWWGlVcEUraCtMZTdR?=
 =?utf-8?B?bXBjUS9qTHRXOTVFaDBvM1J6U3VyZXJnUlpUQXhXMUhNT25SUEFEVUJTQXEr?=
 =?utf-8?B?dkNxNjJMS3Y2QWp4QU9CZlA0cUVTbzBJNWxPenVXdlFibnUySUFrM24vRis2?=
 =?utf-8?B?SE95MFdUTTQrRGNXVGZINXB3RmlkL1ppRTN1ZlE4UG1NOFdOcWhFa3JHZ01l?=
 =?utf-8?B?WjVFdGk1U0VaNG4vTXp0MENqVkZ6TjFZdU1GUjhnaTFXYndVeHp1bXB4UXZE?=
 =?utf-8?B?cThaeDhZc2w4S0llZ0Qvc1RuY3pjSjJQNmhyMm9qa2ptbGcvdHlmMXpKb010?=
 =?utf-8?B?S243K002YTRjV2I5S2toQWFGUUF4blBlVDZkTmF0MW1kV09FN0U1UzZadjZa?=
 =?utf-8?B?K1VOWVE4S3FUQUc0ZVY1enRuRVQzQ1R1T09adjBjSU9reXhZRTBZM2NrOGQz?=
 =?utf-8?B?ck1ma2RyVW9UVE5MZkcyMTBQU2dzR1dpaGk3UjhmY2dabDVXVnlwRkJMdDRy?=
 =?utf-8?B?UlBTN0dHMm1UNmZBOER1eEdFcUhlRHIyQ3lxKzJ5cmdic0M5ek1nS1A3cS8w?=
 =?utf-8?B?RXUvY1RVZW1LSU1vQlJocXlFK2M3c0NVMFpTWlQxMFdFd2QwanpwTjh4bDVE?=
 =?utf-8?B?OEk5Ukk4ZDZDclpSbGdYMm5Hcm9IdFd0QkdleTRXRVBJQU1uMzZSbHd3dmFX?=
 =?utf-8?B?dE1tSW5lOEVucFFqNUdnSElzQzRuSGNDOUpTZE1xZllnTWc5NDhwMzhBRU5C?=
 =?utf-8?B?UENLVU0yRC92RWdWQjA4Q0RpMExCNFU4VHFCU01yb3ZyWGFpNnBIN2FXcXIr?=
 =?utf-8?B?a2M2WnVkL1VOZUV3ZURiVElyRzZ6SEx4YjE0SGtrNXhxbXlpV0MrUHdWaFFh?=
 =?utf-8?B?VXUxcUNnR0g2T0RtdllCRkswaWVUQ3JjRHBXZE5GanNaZmEwQ3J5SDVqZVlL?=
 =?utf-8?B?L2ZlMGVORXJHY0t2R3MzcmVYcjEvNXV3NldWK0gvcmZGRUpWaUxxOG9qSGFF?=
 =?utf-8?B?SEwxZjd0RGpJZVRjSkZ1Rm9nVlBJTVp3aHd4dHVmSXZvS1ZKRndDZmtzeEVZ?=
 =?utf-8?B?d08zMlIrR3RrdWMyOXBFY2NQYnVKNzFoMm0rVUJEUGNIVmc2YTM1OFplUjQz?=
 =?utf-8?B?bjdtcFhvYnM5NHY5UUFoYWJ3RDV4WDdLRDZKaXdHVTBRMVpJS3REcUhNbGdR?=
 =?utf-8?B?QjJ3VmZkT2d5Q0VsL3dFMmhVbHJxamxiVEJCeUlNTjdITTRIOHA5YlJtL1J5?=
 =?utf-8?B?MWJBbFpvQis1UGE3TTBVTzRoZ2JQOFhZRHZBTU1XWi9KR2hwZkdDb2wycDNR?=
 =?utf-8?B?MGFRVWdwaXE5ZEJCc24xSit0YUpPU2ZBTUNGZ0VYNGJLa1k1Q0VtQVBMdUdR?=
 =?utf-8?B?NDQzV0tSSDJCdm1xZ1hORElwMFhaQkdXVzh3YUZlbUUwSitNRUt6UzM4SFBL?=
 =?utf-8?B?anlYOEppdUhPcmhOZVJ4alJtVENVL2NieHlTbmg4dmJiWVdmbk5sYzlGbXQv?=
 =?utf-8?B?UkxhRjBzMEQ0UVUvcno2THFSeGpvVGhKRFArN2s4TVBPMk1sclFvQUlkNlJ6?=
 =?utf-8?B?UHVOamhLK2c0QXo0YjZ3RFRlT1pkU1VRakhKelllTEZtelZPZ0o2b3RyY3FW?=
 =?utf-8?B?K0FEdEVRalpkTkw2djhsU1Rhb0hYajRUd1puQ0dKbjhEVURmQ3FvM2tVOHgr?=
 =?utf-8?Q?HzTZTWBNY5JhWZw9+43+bZsao?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7907c-9c16-40f1-6692-08db5aa3c67e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:06:06.2872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvvCGaGjTF7vfbNDQI71s3fXoSK+s+dBVb4SPm6uSzrn8y8rW3gyhoRDfxI1RNeIo00FiK/+0vXhiMaIR2vczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 19/05/2023 23:21, Alex Deucher wrote:
> On Mon, Apr 24, 2023 at 1:39 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> The FW expects us to allocate at least one page as context
>> space to process gang, process, GDS and FW  related work.
>> This patch creates a joint object for the same, and calculates
>> GPU space offsets for each of these spaces.
>>
>> V1: Addressed review comments on RFC patch:
>>      Alex: Make this function IP specific
>>
>> V2: Addressed review comments from Christian
>>      - Allocate only one object for total FW space, and calculate
>>        offsets for each of these objects.
>>
>> V3: Integration with doorbell manager
>> V4: Review comments:
>>      - Remove shadow from FW space list from cover letter (Alex)
>>      - Alignment of macro (Luben)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 ++++++++++++++++++-
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  6 ++
>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 9f7b14966ac8..f6b33faea86f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -53,6 +53,11 @@
>>   #define GFX11_NUM_GFX_RINGS            1
>>   #define GFX11_MEC_HPD_SIZE     2048
>>
>> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>> +#define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE
>> +
>>   #define RLCG_UCODE_LOADING_START_ADDRESS       0x00002000L
>>   #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1       0x1388
>>
>> @@ -6406,6 +6411,44 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>
>> +static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                         struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
>> +       int r, size;
>> +
>> +       /*
>> +        * The FW expects at least one page space allocated for
>> +        * process ctx, gang ctx, gds ctx, fw ctx each.
>> +        */
>> +       size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
>> +              AMDGPU_USERQ_GANG_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
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
>> +       queue->proc_ctx_gpu_addr = ctx->gpu_addr;
>> +       queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>> +       queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
>> +       queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
>> +       return 0;
>> +}
> Please use gfx_v11_0_ naming for consistency.

Noted,

- Shashank

>
> Alex
>
>> +
>> +static void gfx_v11_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                           struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
>> +
>> +       amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
>> +}
>> +
>>   static int
>>   gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6426,10 +6469,16 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>          }
>>
>>          memset(mqd->cpu_ptr, 0, size);
>> +       r = gfx_v11_userq_create_ctx_space(uq_mgr, queue);
>> +       if (r) {
>> +               DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
>> +               goto free_mqd;
>> +       }
>> +
>>          r = amdgpu_bo_reserve(mqd->obj, false);
>>          if (unlikely(r != 0)) {
>>                  DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> -               goto free_mqd;
>> +               goto free_ctx;
>>          }
>>
>>          queue->userq_prop.use_doorbell = true;
>> @@ -6438,12 +6487,15 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>          amdgpu_bo_unreserve(mqd->obj);
>>          if (r) {
>>                  DRM_ERROR("Failed to init MQD for queue\n");
>> -               goto free_mqd;
>> +               goto free_ctx;
>>          }
>>
>>          DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>          return 0;
>>
>> +free_ctx:
>> +       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>> +
>>   free_mqd:
>>          amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>          return r;
>> @@ -6454,6 +6506,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>>   {
>>          struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>
>> +       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>>          amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index e7da27918bd2..11e8ad649f6e 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -38,11 +38,17 @@ struct amdgpu_usermode_queue {
>>          int                     queue_id;
>>          int                     queue_type;
>>          uint64_t                doorbell_handle;
>> +       uint64_t                proc_ctx_gpu_addr;
>> +       uint64_t                gang_ctx_gpu_addr;
>> +       uint64_t                gds_ctx_gpu_addr;
>> +       uint64_t                fw_ctx_gpu_addr;
>> +       uint64_t                shadow_ctx_gpu_addr;
>>          uint64_t                flags;
>>          struct amdgpu_mqd_prop  userq_prop;
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_vm        *vm;
>>          struct amdgpu_userq_ctx_space mqd;
>> +       struct amdgpu_userq_ctx_space fw_space;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.40.0
>>
