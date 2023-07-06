Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD34BEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C6610E3E3;
	Thu,  6 Jul 2023 13:33:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270F210E3E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRu9t4g+ddcB310Q3eV4qbmJkDWIjXOrakWt5COMMaoP9QJKd1Jlnt0C9qX/IrtoiCn49qnoGfxhStB6G4crhWsLJ1PoEk0N5vjtrS1IA1D+jsBr/3QckeWsBVgK/n0kYq4j8gkSFrJcUExhqF9b2Ni6AUN9j14Is4RsCFj4eFCNnA4zf7DJ5+pBANmsNoINPmkJY9OH3QMkSVZRimjg90JijEVsTZmzDFEs3mU/ESzgr9jUuBTQjKRD7nUWtppUSQiUM+zMlYUU+/vnJJ9VeXZGs+w9Q/auXaqE5I7saTkEWqXUTQugUsG9fowEAWW3HalyzU8msk+qLBRRHgOMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92IVbqC8/7VIOQgGD6cUorhMF3Pv7UdSWnOLvcpzH7Q=;
 b=gg4Rqn6JpMHqZa62bXrJVBlpXf/akvcxbBvu4rh1/EValzAww75IwpmRywdi1SXqr9xF/fgxgRGcznaIx6mG4D9EucD/YohMi/yKUx/kSx8BajO8EfA68o5JYqKoJDXZnzzB8CVCbh0GOB0bPiLiR3rT4lZYHJg89keLkyGiN35XWlsRRuTSHPHtgeYisCi8MNLN1Jon1O0cSb0JZQsE88TrNPeT1brUkbEF/PXdHgJ0xyXYhpqiicirOkb4PmQPFUFjCLST25shS0r7Uko5v6Rt03AQSALbivvBR8sqqxb6Hpgiv/FRjVjBfzCaLG7nK3M4TpAxiQggnm4022T8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92IVbqC8/7VIOQgGD6cUorhMF3Pv7UdSWnOLvcpzH7Q=;
 b=sIDtaR7db3saEwSoXR7kE6zezzo7bpxuCRNHLJUXgIJpd1ImFxMEucKKcw1NkOIC0DFJl8XclgVO6rS3Gnh29ezx/+cxodum2AEoulw/1nWqmztMyeTRK0V+zbju297p3+zYh5NH5I/LANC467kdGUjnoRUK5GpD4YqhmgDXscQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18; Thu, 6 Jul
 2023 13:33:46 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:33:46 +0000
Message-ID: <80818bc4-f813-906f-1a43-0ccb29b1ca85@amd.com>
Date: Thu, 6 Jul 2023 15:33:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 05/10] drm/amdgpu: create context space for usermode
 queue
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-6-shashank.sharma@amd.com>
 <5d947a69-d77e-0a5d-5581-1ed4aedec6ec@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <5d947a69-d77e-0a5d-5581-1ed4aedec6ec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c9194c-a387-42c2-09c2-08db7e259fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhKVctGlQoSxX9gEjsqje2GVZL2Y/B0fKs+kxyxNROcDxiUO2gU2D4uB6NPA9j8or88m6klSW5pSyR7Fc3KdG6Mn4HlXm9o6hDGAAklmwVheBNoTDtq/oFtGtsuaT+1O5RsaKCyXVKnFMVvZ5uiCOi9DSz6yEyWULKzZq6nYRam4DNOUCXyectCy34RaEZ0BFx0p1S5+6v4aRNKDUFpWdzHI6Uda2GjcC8Xq9KAQ4ujhHJtcsp6L8IlqUjDfPtRulHjtnHu3TkvwjaePLa2aEnGtVE86YWCuyscB7jgylNUSfSmN5HB93tyRUx0CmQkhD6603Wda9veZZIiANy0S8NrkNixfknw2zt1RhHtcAiQrFfYKBF8fBc+8ErveFZwT4/zB5lys8Z4vmK55Y/e5oCTTtRwzZO6Cce2V8pKXEsx97tani9jAFXaVZ6H+pdnaYlqAec9xeKH77IPiO00GTsOs8w9/QsNlLQ9uwiolWIDfdNAyt82D/eeQkYM6k9jAMa/UuJVSCUhFAvjJCYkJLAlWQrCwlaA5pj65OdvufZxm8clfw/ct+lcsV+9B7cHx3oMxZE3dfpUTVexQaXIGS2NXgL41YKhMPsB1TU1K4x4yJb0eIu1f+A1mwlVInvzIA/EzB6gxUuaeCGsA5gYa7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(2616005)(53546011)(26005)(186003)(6506007)(316002)(66476007)(4326008)(83380400001)(8936002)(66946007)(8676002)(44832011)(19627235002)(41300700001)(5660300002)(66556008)(6512007)(478600001)(2906002)(6666004)(38100700002)(6486002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkx0c0lGdFpvVWxVVWpkbGQ5QzdSdVZKY21UZnowL3BHSDF2MDZLcWJMVHBJ?=
 =?utf-8?B?V2FUa2Z2bmIycEVTUS9vNldmYWtqRzh1bStEZkpLQVQwa3FxNks2ZHJZdTha?=
 =?utf-8?B?aVk1N3BNcXlsMDNpU1JYRVorRlN6M0RRN0tNaEQ5UFg4RDNzOUp0ai8zbXRM?=
 =?utf-8?B?RzlwVHNHcFdlZk0xZzRlVG1yUWdnMUtoZWMvbTl3aTl2ZFZqVEpsc1diNXhw?=
 =?utf-8?B?Wmx0S2UxempybmhXdVcwYW8wQ0s1K2FSSlNQb0xpMERMaStpT1pYcXIyeDNC?=
 =?utf-8?B?d29kQ2E4VzB2MVZJUUFFd0d0bThEWHBEOGt4YUR1ZnFaN0k0MjUwOENBY3dq?=
 =?utf-8?B?eFByc2xjOFQ2Ujczb0p4YXJReW9mN1BDUWluMTlSRE1kcS9NR0l4Q0tMSCtY?=
 =?utf-8?B?TzF6VWpOQzIwMndpSzRpNEFPUjZISHJNczNhVUZYalBlZnFqT0lDWEZmKzdl?=
 =?utf-8?B?N2JlS0k0QmJ5MTdWemRsQmNJRlpjaE9RbTJzODk2aTJBa0NWK3QzWnJ0c0Jj?=
 =?utf-8?B?OVVuNFQvcE9FSitrOWZmdGxXVE5ud2UrWjl2Qk8wR1FnU0lIWThXNlJwN1ll?=
 =?utf-8?B?aUphY0JyUWpFWUNRb2tlaE02aXV0ZFVFMGgwRG1xS0x6cERpNkRjNkdYc2lS?=
 =?utf-8?B?NTBjNGNUTHU2V2QwN1FVanl5VWcrUmNRazRWK3pObEdHQTJpMWZLS2xXMEp3?=
 =?utf-8?B?MWNPcXU1c2FqR1hwam9LMElnb3oyNE1VVlBReXJNTUV6UHBuMlBrc1l0dmxy?=
 =?utf-8?B?eHEyeitKQ1ZiOXlkYU5qOUN2T2pCZ1BYTnphY2NrVnVMRVdLUXFOTEdxTEhK?=
 =?utf-8?B?QkRKMmNkVXFRUnRoOXFVdkF3RDRIZzM0emZPWEQvMWdFSU8xbEdSL2MzN3Av?=
 =?utf-8?B?NzU0KzBYdEI2UHgxUnlQOGo1dVVENjFabUlDNTdhSHVxSlhhWHNVc2hMdXVq?=
 =?utf-8?B?TG1yc2JlLzBRQk9uMGxFZHg3TkhGR09qbXMwMG91TFJmL2txRFVQR0FnYmRN?=
 =?utf-8?B?bmZYUU5ibHlOaDE2R0J5SFdyTnVYdTB1UHVpczYzSEp1SmJtL2F3d2o1b1hW?=
 =?utf-8?B?dnBnendWT2hacEJHOWpJYUNUd25DTUdSMEhIeVhvMUs3WVBiV1lPd1dlck1D?=
 =?utf-8?B?dTFtRmVsRlc5VjMzL2RTU2RBdUdhLy9SbVIzbWlmTWNhdWdZQXVTdGV5M3hi?=
 =?utf-8?B?MXFqdHkyYW9rR0JxZDkwTWxvTzVpcFpJL1BrVFNaT0d0OU1KU1B3QkJiV2Nw?=
 =?utf-8?B?S3dCNHI3Z0c0bytIWFJ3b016SG1JNDBuWEFXdkJESkRDZ2o5aFZhSVdVcmJZ?=
 =?utf-8?B?OGI5U2toWWovYkhmcEdnUDVsR0RMaklQSnk2WVVwSGZ6QjFhWTNEZEM1ZW00?=
 =?utf-8?B?MndpVFYvUm1tTnhadTY2NndPaUFBRml4U1liMzV6SGZMekZEU2IrNk0yWjYz?=
 =?utf-8?B?WStKQjlXcVR5K3UyY3VZc3VENFZwREZncU9Qam12andjUmJLK1A1ZTZRNXJF?=
 =?utf-8?B?bGdNcyt5Nlk5UUVkS1EvK1BtekcwTEpNeFNYaTc3NkJTVmVRYzd5cWp6Uml5?=
 =?utf-8?B?VmtSd2dPbXNSQkhubmx6QWZRbGVSZ2FpMzh3SHFOZ1hQT08rTXExdDRDZm4z?=
 =?utf-8?B?VzI3Z3VQNjFydkY0Znc0Y05YZFBWTXNKNWhUK2JxdGt3bWlmejJHcUpENTVY?=
 =?utf-8?B?NlZyWjVCbmVqdGxiV3d6SURodUcrWHR6ejA5aUNQUG13VUJDd3dobmpqOVI3?=
 =?utf-8?B?d2szOGZXa3cweFFnMitoZUZqajN1M2JaUW5JTEU5ZWxtSlJ6WFBmUU5DZWNw?=
 =?utf-8?B?cjViamVVc0txMGFFWDdmRUNFN0ozb2lkaCs3QzQva3Zua09HdGZ2NEttc0dF?=
 =?utf-8?B?ZFJvQy9zOUowbm1ISVZsSGFDbWxReElpdmt5cW5pRmRtN3k2TlpLWDlsdmR0?=
 =?utf-8?B?VGJtdkJSczdmSlVWN2FtYTF0djQ3a2Q3Q2VNbXNpa3pybEF2K0hmVTNuSkdL?=
 =?utf-8?B?dG93SERnZHZXMnBQMGMrK3JYQ05udkNEYnBVUUdsNlNycmYyNjFmeEU0elc4?=
 =?utf-8?B?ZWtnSkhGYWpqRVVNY0QzQk5FclZ3MVBleDd5QmJVczFIMElEVmpIOTVDVW11?=
 =?utf-8?Q?wmhBj00jA+CGq0IyPLR0GEaFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c9194c-a387-42c2-09c2-08db7e259fbe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:33:46.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRicXefN9q5qP5VQfJL1+Ac3qafOohDFUdKn3UnDRx537Jtap2xsynGYsfmINQ2+8t7kv9OY/TWAa7wzaKud7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
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

Hey Christian,

On 06/07/2023 15:28, Christian König wrote:
> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
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
>>
>> V4: Review comments:
>>      - Remove shadow from FW space list from cover letter (Alex)
>>      - Alignment of macro (Luben)
>>
>> V5: Merged patches 5 and 6 into this single patch
>>      Addressed review comments:
>>      - Use lower_32_bits instead of mask (Christian)
>>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>>      - Shadow and GDS objects are now coming from userspace (Christian,
>>        Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 62 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  4 ++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index e76e1b86b434..7d3b19e08bbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -61,6 +61,9 @@
>>   #define regCGTT_WD_CLK_CTRL_BASE_IDX    1
>>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1    0x4e7e
>>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX    1
>> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
>> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>>     MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
>> @@ -6488,6 +6491,57 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>   +static void gfx_v11_0_userq_destroy_ctx_space(struct 
>> amdgpu_userq_mgr *uq_mgr,
>> +                          struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>> +
>> +    amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
>> +}
>> +
>> +static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                        struct amdgpu_usermode_queue *queue,
>> +                        struct drm_amdgpu_userq_mqd_gfx_v11_0 
>> *mqd_user)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>> +    struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>> +    int r, size;
>> +
>> +    /*
>> +     * The FW expects at least one page space allocated for
>> +     * process ctx, gang ctx and fw ctx each. Create an object
>> +     * for the same.
>> +     */
>> +    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
>> +           AMDGPU_USERQ_GANG_CTX_SZ;
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &ctx->obj,
>> +                    &ctx->gpu_addr,
>> +                    &ctx->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate ctx space bo for userqueue, 
>> err:%d\n", r);
>> +        return r;
>> +    }
>
> I think I asked that before, but shouldn't this stuff be allocated by 
> userspace now?

Following your comments, we have already moved the Shadow and the GDS 
object space to user, but the Proc and Gang context is required for MES 
mapping (which is kernel internal process and usermode doesn't know 
anything about that), so it needs to be created by Kernel only.

- Shashank

>
> Regards,
> Christian.
>
>> +
>> +    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
>> +    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + 
>> AMDGPU_USERQ_PROC_CTX_SZ;
>> +    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + 
>> AMDGPU_USERQ_GANG_CTX_SZ;
>> +
>> +    mqd->fw_work_area_base_lo = lower_32_bits(queue->fw_ctx_gpu_addr);
>> +    mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
>> +
>> +    /* Shadow and GDS objects come directly from userspace */
>> +    mqd->shadow_base_lo = lower_32_bits(mqd_user->shadow_va);
>> +    mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
>> +
>> +    mqd->gds_bkup_base_lo = lower_32_bits(mqd_user->gds_va);
>> +    mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
>> +
>> +    return 0;
>> +}
>> +
>>   static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                         struct drm_amdgpu_userq_in *args_in,
>>                         struct amdgpu_usermode_queue *queue)
>> @@ -6540,6 +6594,13 @@ static int gfx_v11_0_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>           goto free_mqd;
>>       }
>>   +    /* Create BO for FW operations */
>> +    r = gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_user);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>> +        goto free_mqd;
>> +    }
>> +
>>       return 0;
>>     free_mqd:
>> @@ -6552,6 +6613,7 @@ gfx_v11_0_userq_mqd_destroy(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>>   {
>>       struct amdgpu_userq_obj *mqd = &queue->mqd;
>>   +    gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 240f92796f00..a5cdb319193d 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -40,10 +40,14 @@ struct amdgpu_usermode_queue {
>>       uint64_t        doorbell_handle;
>>       uint64_t        doorbell_index;
>>       uint64_t        flags;
>> +    uint64_t        proc_ctx_gpu_addr;
>> +    uint64_t        gang_ctx_gpu_addr;
>> +    uint64_t        fw_ctx_gpu_addr;
>>       struct amdgpu_mqd_prop    *userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_vm    *vm;
>>       struct amdgpu_userq_obj mqd;
>> +    struct amdgpu_userq_obj fw_obj;
>>   };
>>     struct amdgpu_userq_funcs {
>
