Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E34C761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12FAF10E6FC;
	Tue,  4 Apr 2023 16:24:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991AF10E700
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNlgN6J4VV4e6URYss8Jd4BfTeVmyFpwB5Qs3wY8zUEf/oacDy2EWErxxoEkyBpXHBWiSRBu0iSmYg8R5Xce9kffU0Gx5HmjlWX7ZdotA72YSarPcxciQavr0bBwlzAv+/lOv2OgTDkR7JKNyCqJsdO+B/ajHcbjZ4R1lYiIqLGirhep75QrmP7vzQ3vIDfSDWQgGL3pvaorS8SS0U0RVt7TOknKO6FNqppgiTTm5mX0zvyB/DXy4A6sfh2yTKoB0Q5i733AOaZstMD8ViuN9VYO+FaZLlO/dbB3+suKdSkbdmcVq6gkBaFzYeSbo8ysHl6/FeQwmVhPJm8E4mmsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sU+Rnn+SZxLwcmVpK3iu58tPd/i0IehBLLmuUn1tg=;
 b=U2zlw5BJ6iUpv8aJPzDJWmRq4eJj+QDLnjoO0gIgn81E8dIuqFUU6pMsBaGjzIc354RV9huU0GkRO6nOInGXrg0K/PfZMNC5wP6xBcJ6VrXid4AdM6hulKsGb4AAGFqHMsRjhzZb7qqStKn0z6jDOeLNWfq4jA3rmIRZ4esSksaIzLMZSO2OeBVkadmRoCu3QlzpN85NKoKCRb/k/Kr/rh2xgOmf0rBEKdymuA+liCoevBxgbRgi0UTehY3q2eerUiApjj4DwhmUjICqxOss3Be3pUz+o4dGs+4bmjjBxgw8aTBuwjEvp4m1+x9/S+qiGUJe7DOtnS0ML64AHcP6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6sU+Rnn+SZxLwcmVpK3iu58tPd/i0IehBLLmuUn1tg=;
 b=yufAap0qAO0Vgk6/bctf0OUELIzFI3pChyBd0TF/US1MbglUaBo4TlloPKGaGgFQqhrt8XUMAZskclXRDHTCIHcrxp+NkxyPsB5Avo8Qr50r4w93e92GyE/3OMddrpUd7Z3nMhXVFPbs+On1YuYLyyAFFKFiQ/ZcuBQqpPNL7dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 16:24:36 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:24:36 +0000
Message-ID: <dcb79977-41ff-ab97-8194-1bb8ba22a315@amd.com>
Date: Tue, 4 Apr 2023 12:24:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-6-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v3 5/9] drm/amdgpu: create context space for usermode queue
In-Reply-To: <20230329160445.1300-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1P288CA0011.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 417f0eac-ca75-4e09-f628-08db352914a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zR93vGYlkJ+U9dJMcAI9+JRo7o573dVClMIyUzx/XcnERCCZkfhrgmDN2+PPz0RqEnRke6KqyzWZiCcU+292BZEVLz120ru7pCTz1rK/Te4MRhgf+kNa//jkdQAHtGdQjnZI49N76VNWbF3Sgq+dqb8f2S8+1gjTKGNT9oBWS7y2s/s8x37FQUoTLM/Dzgja7I9/KH2BsKoCuNJWcHQ7DC7mcaGdvYhgUigQTTFhXG8MmelPPjbIKAgRwC/7BTVtfOwDbIJG07eqATFRfT7OGObzv1GDVoMTF72J3VrPfDEK1ihSp1VJHz1hJRZMFN+ab7LbFgFj8Wg0+uAoN/PxKhw3IFtvqFlYBod55jwTaBJO0C0BKz0+Hov2Do60aWs5eSPTzNIvSj3WvLC79Vp0Ec6xFOnotRoin89Z3EcnFqAHxZXaYKN+YXG5hY9LU8w2WclRvxKV2ohh3X9z+iwB8YTONShGCsf9u3Eqm6aVoVyOu4i0Af8Hm8PRzFkOvLjg3PhuY9I7KuVHQVQWR2lzrLSPFDJ+EUHZGXoz1BdBJPcSJ3HmQSxCcFsxiLXVqOEMNPd83iEd6Pc2Erie/cQ6B6mKnrwIKX/Or6FjHwO8glll5+LVCqjlMjA464Tn4I5aR2qYrK6qgu0WS8k6ha4EWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(54906003)(316002)(478600001)(66946007)(8676002)(66476007)(66556008)(6666004)(4326008)(6486002)(2906002)(5660300002)(8936002)(44832011)(38100700002)(41300700001)(31696002)(86362001)(36756003)(2616005)(6506007)(55236004)(53546011)(6512007)(26005)(186003)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1MrbzE3R1RFNCtNNzBrdkd5SmowcjBHR0JPRVAzYTdBRFc2b3dDejZ3bE5O?=
 =?utf-8?B?UXN4Rk5TY290Q3cxaU5IcVFMOXhSditZMWpMT05GMXhTQjNyNnB1am5tZ1Ix?=
 =?utf-8?B?UjlxU2czL1ZqSEMvdnVYT0w1eUlDZW5ZR3hVWjhsMXg0dnZLV2lLTnVTRHls?=
 =?utf-8?B?SXZZVDhOZGFXZURScXpQYlVObzIwdlY4Y3Vla21TV21UVzRSRjBYR29lTWF2?=
 =?utf-8?B?bWwwNkdnY1RFb3lEaFd3U29ZTjJDS2h3bUtLN0dsalZ3ajU4a0VIOEZ3QkdY?=
 =?utf-8?B?dnV6M2VWejVSMXN1WVpXakh3N3RBWWlvblNRUGJBaThPeGtlSFlNUlQ5TXlh?=
 =?utf-8?B?S0RVc0hjSE80UzZkU0c4bEtyeldHUEV6UzQ3YU1LQnFCc0YvZ2c1NVpvbEFq?=
 =?utf-8?B?ZVhLTTc3eFRpS1d4dnFYVk9PdG9CT1BhMG0wRTV5U0Vta0pYbzB1bXZPNkUx?=
 =?utf-8?B?UGp5Wm9HRlVvYWNsQm90STY0ZStTeW5uZG9pNXlvdFlLb1pvY3Q4SmtPN0RI?=
 =?utf-8?B?TXMrOElJcUpsd05VMW9oaHRPeVhxNWdqMWNHcE5tZ2UyaU5FQjdMZ3BsTXBj?=
 =?utf-8?B?WVU1TXA5cGJyR1hDcXhya3Z4d0xHSTR6cW9Nam9JM3lhbDlkWjBVR2t5RG4v?=
 =?utf-8?B?SjZ1M21tcUZEZTFHSXo2WXIrUTFGYmpONmZLQm1KVXNETFJacXJyeEdybHBW?=
 =?utf-8?B?ZjNsZFJQWG9seDVnbTRKaVhiRGh1b0VKK0Z4Z2xITUduRGk3Y2dxZ2sxa1Fs?=
 =?utf-8?B?UUVOWHZBMWlKUHRnbzQvQkdoMFkyTGFMYU1GTVQ3MWNreVZzWU5pQlF1MXdt?=
 =?utf-8?B?a1JMRy9SYUN4Z1RBQWpxWTgxVGNic0xLdkRYN1lidi90M3JvUStnbGo4ZDk0?=
 =?utf-8?B?RTJKZ3N4WUw1b3ArelBndStNKzdaaEEzWUpMWlNmeWNBV3F4M3ZBWUdaQm92?=
 =?utf-8?B?VFhGTExReFhTVy9iNVlBc3FYM2ZsUmNwaFd0K3J4NlVta1MzUXVxeUlrUnlI?=
 =?utf-8?B?d2NXOTVHb3AwNjk0Q005UVNWcjVMdVYyZWV2cGdiS2h0UDk1MDROY3c4cjBL?=
 =?utf-8?B?VVNEL2pUeHRxQmJsdkl5OXB5TmM5L2NVLytVdHN5b0p4aXRUSGEyZHRtd2NW?=
 =?utf-8?B?Y3ZIeXZYQ0tJRjRhTGZIbDUyNGo2cWFJTmJCaWt0eVdSTjg2RUJhNVIyYzd2?=
 =?utf-8?B?eVV0TytqbnBIQVZvMnh2T2xKS1FEa3pNTTFYekhKZlRFNDVFRDRHUkcrL20z?=
 =?utf-8?B?djQ4OWw2T1dweThmZ0N6SzloY0dNL25HN3VFRUFLMHVFY29nWVFlaU5ubGwx?=
 =?utf-8?B?VmlvUGJUM3cyRkdkOUw4dlRIeWRGNE1PQVRwL0t4Vk5aRUtNc3BhaWtVZlRT?=
 =?utf-8?B?bWorM0d5SjNFOCtYRlI4aEJmYzJ6bmx3TjY4WVpnUTkvWDhxdUIvTk1tOE5y?=
 =?utf-8?B?bGV4MXp2TDJ1RlJPbkZKMEV3OVZMUndoaDJSVkJkRSt6Z3N6WDNhZFIydDVM?=
 =?utf-8?B?enpuTU5zRzhSbVpiY2djK2FaNERJZFVlWStFMWVlMTlzaktRK0JiT2lVM25M?=
 =?utf-8?B?YldjYVJkVTZMWElHVms2dW5nVjJmSUE0d200L1pNbkpyRlhqbnhqSU5WNFgy?=
 =?utf-8?B?a1Z6elFmY2dSR2JKZkRpWU02dDJFR2VIdnlGTkhodmVVVWV2U1NSLzJNODg4?=
 =?utf-8?B?bFJFSFh4TUxZN0QrRGFlNDZOeFFOL09ydjVHWkpBNUFCYklYcll1NkhtdnlE?=
 =?utf-8?B?OW8vZDBwMzZwZnI2ZTcxenJpMGtBTmVGdHdDdkZ0bmU4ZVRUY2FvK0JXejQx?=
 =?utf-8?B?NEFqWExHMkI1RFFwQ0pIVHhjWjM3QW85Y0lWVDdUSGpaeHY3cUFSWmNPSHdM?=
 =?utf-8?B?eVBQYyszWG9KVkRGWWZnNEoyN05XUVNNL3A3NjEwZGJqM0NkaU5mTEFOV1JW?=
 =?utf-8?B?bzdhclVJUmhScCtUODBITXlMLzB1OGx3WjQyOXRUbXFONFNDL1Nla1VNTDY2?=
 =?utf-8?B?Q1JwbXVRTE84aUljTVZ2dGRlcWdZUDNOWUFCQTVZRi8xL1pMSEkyME1Cajg4?=
 =?utf-8?B?WjI2RUtGd3ZjelFIRllsUVVuTmJOTyt6TWtBNUNod3pkdGd2M3BybnlCVGNH?=
 =?utf-8?Q?Vl9rjjit//AwGFmMcrhPILCxz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417f0eac-ca75-4e09-f628-08db352914a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:24:36.0647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxRzt64EsLEfB7puxyvQ+EdOMX+lwD1uVMayg+/dWyeeZJvhV8obIOYyauO4KeoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

On 2023-03-29 12:04, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> The FW expects us to allocate atleast one page as context space to
> process gang, process, shadow, GDS and FW  related work. This patch
> creates a joint object for the same, and calculates GPU space offsets
> for each of these spaces.
> 
> V1: Addressed review comments on RFC patch:
>     Alex: Make this function IP specific
> 
> V2: Addressed review comments from Christian
>     - Allocate only one object for total FW space, and calculate
>       offsets for each of these objects.
> 
> V3: Integration with doorbell manager
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 +
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 60 ++++++++++++++++++-
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 052c2c1e8aed..5672efcbcffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -71,6 +71,7 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>      queue->userq_prop.queue_size = mqd_in->queue_size;
>  
>      queue->doorbell_handle = mqd_in->doorbell_handle;
> +    queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
>      queue->queue_type = mqd_in->ip_type;
>      queue->flags = mqd_in->flags;
>      queue->vm = &fpriv->vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> index 12e1a785b65a..52de96727f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -23,6 +23,51 @@
>  #include "amdgpu.h"
>  #include "amdgpu_userqueue.h"
>  
> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
> +

Leaving a single space after the macro name and its value
makes it hard to read. Please align the value columns
and leave at least 3 spaces--this would make it readable.
For instance,

#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
#define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE

Regards,
Luben

> +static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +                                                 struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
> +    int r, size;
> +
> +    /*
> +     * The FW expects atleast one page space allocated for
> +     * process ctx, gang ctx, gds ctx, fw ctx and shadow ctx each.
> +     */
> +    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ +
> +           AMDGPU_USERQ_FW_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_GTT,
> +                                &ctx->obj,
> +                                &ctx->gpu_addr,
> +                                &ctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
> +        return r;
> +    }
> +
> +    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
> +    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
> +    queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
> +    return 0;
> +}
> +
> +static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +                                                   struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
> +
> +    amdgpu_bo_free_kernel(&ctx->obj,
> +                          &ctx->gpu_addr,
> +                          &ctx->cpu_ptr);
> +}
> +
>  static int
>  amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
> @@ -43,10 +88,17 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>      }
>  
>      memset(mqd->cpu_ptr, 0, size);
> +
> +    r = amdgpu_userq_gfx_v11_create_ctx_space(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
> +        goto free_mqd;
> +    }
> +
>      r = amdgpu_bo_reserve(mqd->obj, false);
>      if (unlikely(r != 0)) {
>          DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> -        goto free_mqd;
> +        goto free_ctx;
>      }
>  
>      queue->userq_prop.use_doorbell = true;
> @@ -55,12 +107,15 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>      amdgpu_bo_unreserve(mqd->obj);
>      if (r) {
>          DRM_ERROR("Failed to init MQD for queue\n");
> -        goto free_mqd;
> +        goto free_ctx;
>      }
>  
>      DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>      return 0;
>  
> +free_ctx:
> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
> +
>  free_mqd:
>      amdgpu_bo_free_kernel(&mqd->obj,
>  			   &mqd->gpu_addr,
> @@ -73,6 +128,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>  {
>      struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>  
> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>      amdgpu_bo_free_kernel(&mqd->obj,
>  			   &mqd->gpu_addr,
>  			   &mqd->cpu_ptr);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 2911c88d0fed..8b62ef77cd26 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -38,10 +38,17 @@ struct amdgpu_usermode_queue {
>  	int queue_type;
>  	uint64_t flags;
>  	uint64_t doorbell_handle;
> +	uint64_t proc_ctx_gpu_addr;
> +	uint64_t gang_ctx_gpu_addr;
> +	uint64_t gds_ctx_gpu_addr;
> +	uint64_t fw_ctx_gpu_addr;
> +	uint64_t shadow_ctx_gpu_addr;
> +
>  	struct amdgpu_vm *vm;
>  	struct amdgpu_userq_mgr *userq_mgr;
>  	struct amdgpu_mqd_prop userq_prop;
>  	struct amdgpu_userq_ctx_space mqd;
> +	struct amdgpu_userq_ctx_space fw_space;
>  };
>  
>  struct amdgpu_userq_funcs {

