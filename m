Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CD0C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E5110E28A;
	Tue, 25 Apr 2023 13:13:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A1810E291
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFY9Sr51qRELjElpoadKAe6o5azR5EcRP+DP7bwlEkQv+1A3P1zboi6gnCk04SJtKa9XydtGl/WH9jmCpSfYXTowIem6leb2q0hq/QW8Gm7qapAqFiJgi3ShQerLrw0B2ozudk95xOsJ49xvgydp1ltnsB7EOX1cpTdpJqvqSp/+RmfhTxQnoc8Y+5LNHLES3Yfrc9bVC4G8CXU66lQk6U2zcYBJ6VEAwgOr2DEbzremn8N8I32Jf1S1SunzeRLzI3gYYpmqJxcZ2mywRhOdqhvwLi8TRl+0OV95cIojmzGZ13Z97x2AQ6g8/ocJLXPlPN/C612LzYrnommKfoMIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5m2Znf/tjt5yeeDlVqLeNdl6+mqbMnIHh9oeSOunBw=;
 b=bgJ8fWnBo22TpwK2j2GjoLVj8AAaR+3s0k4LRaJvq0HAnmOJJp1N1k6WwIj/c+n4VtZbbmpb0W3VwD40Jl6rN+QaA7mdGwq1HWSil1oXP3qvZCEAcj7xSvYneqJKMH5kSmdPGnMQMZVGT5ZhDpf7+f0J9CqPFPlY/0yGLWwY2PofodZsgnyE3IJvXDE4JbH/d+o/ePXmEf8JhmLIfVlMDQsw+0JUHYv4B57KlovEDuOY9wjZ1reV5r2IdVy6OPTWTLAiRe5etDr7xdK4V5PVggKPkvON4AL+oosgck72O6vQ0Dc4U5Da3+Lb2L26/7reFIr7Hfizk4oqEHoxNCJ0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5m2Znf/tjt5yeeDlVqLeNdl6+mqbMnIHh9oeSOunBw=;
 b=d7YmNqXkfPK3nHGTeJS5ResBbRCKlVRWte8fVuaat6sFhqWDAB7oJaLCJGICFUpc9Z7540ov0jgSaLfq5UE1xwnZqjLH0Da1ORVXwMLaV7Mz93EnTfje70q1AbKxH379bv7xiS2ubVYdEaSl+JxeQoIXCfENOqqVNvPCrjDfcqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 13:13:23 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:13:23 +0000
Message-ID: <fd787de4-7faf-0cac-6910-f12adb2e3ed4@amd.com>
Date: Tue, 25 Apr 2023 15:13:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 05/10] drm/amdgpu: create context space for usermode
 queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-6-shashank.sharma@amd.com>
 <28c8fae1-0cd7-2b7c-35ae-520633ce874e@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <28c8fae1-0cd7-2b7c-35ae-520633ce874e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CO6PR12MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 691e51ea-271a-4ba4-83bb-08db458ed8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMarScc8r7+8lNeDpjKLt0e2pLMDLNpdz8oE1IA3OHFrH4hXBPAVTQ0zxlDikem+43X+d+ktdkRz2HW4Ph4wu60JkoOxsVBCq2SFjkY5l+xJ/br+uF3DKc6nRqFFgoyJtG+iQ+WD1/qttO1av7avcRYUwcjUn/Ec838sXFkjLNe14pDpE9pWHVevDS1UakLaS19eSgmzqpO1pY9Z9U/1JrTpP+om5YiZByCdYYohiZGAG8MDCWxvx25OFkviTyb6hejyvbRz6FP7NnalDuK2mfO5Uc14UYDX6g1OtCejEDoHQgQHT66e3pA9D91suI+O1lNEPBm4PSYheVlQb/fA/0Mlgd4utlT/v9WcMqLIsrpLj0PBWYYzsOH9NFoSgNCG6oKSiUf8IXUzKhGJD02C5AbFo6/08gZPoWmRNvSUZskYEiEPdad7EFTTFi9QmIUOs1RVPZOP7St6frK784/2Lh32+YzDsHHkt+bxxExzFdvotCrbHAP3vz2lgCqh2z3IDI7AXTRSWErB+nESt63oRbvvBTx1SyccKIpexZeCBHlGK03Pi7AvQtwYujOo3aK8wa25hh+CdcR1n3lwPMy9Hz+rE1EYJ1PetxOf74/meEppW8EihqGQ0uC8oAgYDm2R/PgAYPnNoc9Mzm1UtWcvRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(6666004)(478600001)(83380400001)(2616005)(36756003)(26005)(6506007)(6512007)(186003)(53546011)(38100700002)(31696002)(6486002)(41300700001)(316002)(66556008)(66946007)(66476007)(4326008)(31686004)(2906002)(44832011)(8676002)(8936002)(5660300002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpZMm0zVStjNW5CSDFzakE2SVE5aUpzWEJrK3R5MFNuNkFzMlNEM091eTN1?=
 =?utf-8?B?V1pUSzZoMEp1WGFnQytkbEVMQ2hJU2VUZ0xHL1BvNmYzRzM0djZ5U3ppdmdF?=
 =?utf-8?B?U0IrQnFPRHhoanBvRnQxSXA1cFRTM2FzVkpDcGJaY01DYUxDc3hCVnNESi91?=
 =?utf-8?B?VVU3c2pmTlF1eDVvdTJ3UjBGb3FKeCt5SGxhTXc1Q3E0cVpEdmo5SThvRDBL?=
 =?utf-8?B?YXcvWWFmVHFlQmJheFdhd0dWdXFOZDVlVktweTVleWdmaXQyZXlXWS9ZWisv?=
 =?utf-8?B?UDVIbVFrZXVCTVBXL0QrZWVVNDZwNGtlSmJ4MDhXWngvWTJ1VmNpWUVIaEpk?=
 =?utf-8?B?dU9NKzdvTUp3NDZpNW5Rc3V4dzd4MCt2R1dBVzYrYUR6THBTVDArcFR0Y2tV?=
 =?utf-8?B?cmoxbzF6SjMxS25RSVUvT2FocFF2T2tpN09oN3ZDbG4yTVU2VkZaRFhYbXMx?=
 =?utf-8?B?TkxqR1Q3Q3VHQjRGalU3VXExaU4xWW9QR2R3bXN1T1duOTh5L1NiOTZLQURo?=
 =?utf-8?B?NVBNalk5YWM0RDcyOWFFVWUzMHh2bmVrN1hEVmtOTmhCR1R3WDVMUVVwTDRm?=
 =?utf-8?B?Zml4VXpRRzc4bHlPZEZubTlKbkNCR2FBdm5MeUkwWG9PRlBMMjFEcFRZTTBl?=
 =?utf-8?B?RUN0bU5ZWFg0NEIycllYV2hSYk11d1N5Wm9IdjdySFI2aFBpUU84QkNDVC9w?=
 =?utf-8?B?WCtoMVNMSnlTRDNBQlpibFZHTVVIcmFKYW0rSjZLNXN5a2FIejliSE1MdmNI?=
 =?utf-8?B?TXM4d1h5cG10N3oxRGZ0U0hWSzU3ZTM4UWxIbDBlQXlOY1J5ckFVdEdWdExG?=
 =?utf-8?B?UWUrZmxWOTVyODJCUDYrdGxIUlVpRFNIN1VYRmw0M2NxQW1tZndRQkc3OVZI?=
 =?utf-8?B?Z1doSkYxSmc0QlpxTmN5Q0RYMy9WWFVDNDVHcjg3TnROcDkwYTY1QjMwMXI2?=
 =?utf-8?B?Mm81cjZQc1NPb01BWG9wK1BUaDRybWU1VEd4VWVVOGtRcWN3TVFNazJRdDY0?=
 =?utf-8?B?OUd6ZHdCODcyZlNRTEluSTZ6RHZ2Y0NDTHVRL1BtRDRXbkVmUHU5SnpNL2Jx?=
 =?utf-8?B?VUtQeHYreHFUYUJGR3VSdTJ2T1JLbERWMUVmSUJlMERJZGZ2S1Y1OHJrYUkr?=
 =?utf-8?B?SkRnRzA2Snk2ZmlVVWJwTUtxV0RHZU5sUE1pMzUxbTdCL2xaVmpyTDkrcmp4?=
 =?utf-8?B?MngzTTZLUTZQT3dsdjNYaTE1aEdrbkJnY1cyY0NUUi9rVGcrbXFqQW5VOEpD?=
 =?utf-8?B?c0dhWGIzdHplak9lYkpua0dER3Z5a2lLOGtvbXg5TzNBUWlDTnRiR0E2K1A2?=
 =?utf-8?B?QVZ6aWlRVUFLbkg2YW1SSjJwV0EwMFZJOUJCN1VSSWJWb3RjSEhhdGxOcmE0?=
 =?utf-8?B?dDNSN2JuT1dlZEVNNXBSUjZCaFgxaDdKMUszMWtOeVdZbWltWUxCQmlraTRt?=
 =?utf-8?B?UnY3VldzMTkrOFRKbmlnV3BRY01nOUp3ekVxWGpLakd1SVJ4OWZBS09kaVl1?=
 =?utf-8?B?Q2ZJUmtsZkh1aXJXWE9ObzZDY3ZYYjRnd0NrTmxjOVVLWXRZcGo3RDlBMGMz?=
 =?utf-8?B?STNndCtwMm8wVlJlY05FTmtYUDVrV0wzN0o4VHcwdks0enVlblFrWWFaamRX?=
 =?utf-8?B?QWhjNEJ6WUtOYXhUdHp6TTlKc21RMkZHZWRRSGRaSVIzMVNmSklDMXgycmRN?=
 =?utf-8?B?NGZtSVlYVXhyaTdzbFp5N0Z4ekhhWXIyek9KR0RRMnlvdFI3eGc5Q3hhV21r?=
 =?utf-8?B?THdvTFVSTXd5VmJ4OU12MEhxdk1lUE5Vb1h0Z0kwajY5QWZVa3pyenFIU2o3?=
 =?utf-8?B?Q2xCVGNwUHZpbkVYa0J3UFk3SHNsNWNsZndLMVlGMllkYUxNYURROHRDcnVh?=
 =?utf-8?B?Q2VMVmFGWThrY29rZlQvRXJxcGlWZERDakgxZEtjQ3JJeUdua21LOHkweHhx?=
 =?utf-8?B?enFRcWsrWDcxVmFZcTN4NzRSOHNSektUVUx6M1Nidi9PQzIwTVh1M2lSMDZT?=
 =?utf-8?B?OGF5Q05sbkF0blBjS2JUcldCUHQ0R0J4M2RlOTRKb2hOb0pyd1ozTnV3T3hG?=
 =?utf-8?B?MG5EMks1SitERzRKQitDUUs0TnpWcktOdllxa3RFZnBIVG9tVzZ5YTNIT01w?=
 =?utf-8?Q?8X09zxNHqmj5URqd2VMqCJpLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691e51ea-271a-4ba4-83bb-08db458ed8c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:13:23.0095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7Loda8GzcHsPxLPCSCAc3ZJkFL1uEHuCoTNOw1I+VyKPYDMib1Ap371lHLzukpIGrnNrIAudrSM1gXcYpo0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412
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


On 25/04/2023 14:30, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> The FW expects us to allocate at least one page as context
>> space to process gang, process, GDS and FW  related work.
>> This patch creates a joint object for the same, and calculates
>> GPU space offsets for each of these spaces.
>>
>> V1: Addressed review comments on RFC patch:
>>      Alex: Make this function IP specific
>>
>> V2: Addressed review comments from Christian
>>      - Allocate only one object for total FW space, and calculate
>>        offsets for each of these objects.
>>
>> V3: Integration with doorbell manager
>> V4: Review comments:
>>      - Remove shadow from FW space list from cover letter (Alex)
>>      - Alignment of macro (Luben)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 ++++++++++++++++++-
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  6 ++
>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 9f7b14966ac8..f6b33faea86f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -53,6 +53,11 @@
>>   #define GFX11_NUM_GFX_RINGS        1
>>   #define GFX11_MEC_HPD_SIZE    2048
>>   +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>> +#define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE
>> +
>>   #define RLCG_UCODE_LOADING_START_ADDRESS    0x00002000L
>>   #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1    0x1388
>>   @@ -6406,6 +6411,44 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>   +static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                      struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
>> +    int r, size;
>> +
>> +    /*
>> +     * The FW expects at least one page space allocated for
>> +     * process ctx, gang ctx, gds ctx, fw ctx each.
>> +     */
>> +    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
>> +           AMDGPU_USERQ_GANG_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &ctx->obj,
>> +                    &ctx->gpu_addr,
>> +                    &ctx->cpu_ptr);
>
> Wasn't this stuff provided by userspace now?
>
The last I checked, only the shadow buffer was coming from userspace, 
and we were thinking about other stuff. I might not be well updated if 
there any recent development here with the short term solution.

- Shashank

> Christian.
>
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate ctx space bo for userqueue, 
>> err:%d\n", r);
>> +        return r;
>> +    }
>> +
>> +    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
>> +    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + 
>> AMDGPU_USERQ_PROC_CTX_SZ;
>> +    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + 
>> AMDGPU_USERQ_GANG_CTX_SZ;
>> +    queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + 
>> AMDGPU_USERQ_FW_CTX_SZ;
>> +    return 0;
>> +}
>> +
>> +static void gfx_v11_userq_destroy_ctx_space(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                        struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
>> +
>> +    amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
>> +}
>> +
>>   static int
>>   gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>>   {
>> @@ -6426,10 +6469,16 @@ gfx_v11_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>       }
>>         memset(mqd->cpu_ptr, 0, size);
>> +    r = gfx_v11_userq_create_ctx_space(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", 
>> r);
>> +        goto free_mqd;
>> +    }
>> +
>>       r = amdgpu_bo_reserve(mqd->obj, false);
>>       if (unlikely(r != 0)) {
>>           DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> -        goto free_mqd;
>> +        goto free_ctx;
>>       }
>>         queue->userq_prop.use_doorbell = true;
>> @@ -6438,12 +6487,15 @@ gfx_v11_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>       amdgpu_bo_unreserve(mqd->obj);
>>       if (r) {
>>           DRM_ERROR("Failed to init MQD for queue\n");
>> -        goto free_mqd;
>> +        goto free_ctx;
>>       }
>>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>       return 0;
>>   +free_ctx:
>> +    gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>> +
>>   free_mqd:
>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>       return r;
>> @@ -6454,6 +6506,7 @@ gfx_v11_userq_mqd_destroy(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>>   {
>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>   +    gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index e7da27918bd2..11e8ad649f6e 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -38,11 +38,17 @@ struct amdgpu_usermode_queue {
>>       int            queue_id;
>>       int            queue_type;
>>       uint64_t        doorbell_handle;
>> +    uint64_t        proc_ctx_gpu_addr;
>> +    uint64_t        gang_ctx_gpu_addr;
>> +    uint64_t        gds_ctx_gpu_addr;
>> +    uint64_t        fw_ctx_gpu_addr;
>> +    uint64_t        shadow_ctx_gpu_addr;
>>       uint64_t        flags;
>>       struct amdgpu_mqd_prop    userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_vm    *vm;
>>       struct amdgpu_userq_ctx_space mqd;
>> +    struct amdgpu_userq_ctx_space fw_space;
>>   };
>>     struct amdgpu_userq_funcs {
>
