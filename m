Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4270AC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 886EE10E2EC;
	Tue,  7 Feb 2023 07:14:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B1B10E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZA3zk2m+4mBSJOQKPEVtLDqGAYaJyBLz2p9VsHYZ/DxOsDHzV0dNO7Kp9i0ZSPNt9rAnwbiFVUSyOjbw1D/W39Nu6XHWPY0dKioJebnbThbaXtJh+YNXby6NfykpnZS79bXNNnngP6oDDIkAk8o0akkvyvLMHP0Z5CaOg+M+YBiXc14BNRdWc/+dZH5PZSUeWj1w00jcV/C3wN3lrX8lTcMdl1spx/gPZ+2v4ID8RMNnt6u8rdz36jl39nUopr59ZiocSSImF8Wh7UyXHhTvrwVXI53cMashxesQ6MYfgbN9YHCRgADOsBM0NaI8EuYU1Azf+qJzN0cV9ejfPDi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slkipCRq4xYtR7hy3eqS0H8SJEVqTajNgXzfW1rp6AM=;
 b=hMZqsnt+JYaljF7wwHQau1En6U5wK/atbCmQFZWsFdteZIJ/DZtUD6CjOE12p1kvBn8uQPsCAh4/8CMyXVLi2p9ODr33qQgU5LD44LCVqOS5ghJuHnNVvyyAOkNcjS2woxpflUV9/q2g/pUH1qyG2EIRTRGZAgVV7+CpQDnSbkl/HOln2axEJ3JUPvQ0vIwNB71vg4N/kWXkksarWp1W7Fv+V9zND+PNm/e6F24MiXlbdtUitSTPIaFZvkNRRgEglkxyGdiq8WztUNn5ubO3d7vfHfmdbleLVAeDMQoBfr/1Q48nsrLzv8qzYhe2gmWJZHMiSLTjSJQlLHBAtWT6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slkipCRq4xYtR7hy3eqS0H8SJEVqTajNgXzfW1rp6AM=;
 b=jo7FbdbMGz5bw/cezcatc2CrhbsYW4048eILTINIpCk9AtQRk2KmojDnNMTmIAaYCTXrDouHaTpSN2S0St3Dn5WdLUs3+KNNEB62UTfIfSdsvGJ38QvBqDh5vV/uWvqAKld8tVlZwQq5OUSXYx7oRONfv307IfUYiCywsgjSjlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:14:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 07:14:29 +0000
Message-ID: <240a5ab8-6743-4588-4a73-17f2ea894f1b@amd.com>
Date: Tue, 7 Feb 2023 08:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/8] drm/amdgpu: Create context for usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-6-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203215409.2021-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: e96e410b-2cc0-43d9-78a2-08db08daf3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJ2DwJ32pRsJ9f0hYxDICUqQJgXRCrvtlyFi8H6hzY05DkWJpe+a/SZKsElgkAu71xO9hRX9twl1hUG44VpH3TGpkPJmD3D5VI/TbmQG1pbKt8L1puA7D4Ha0AdqvLAX6RkPxVptll831wKGHS2eLwVOTu+c6AmLAQKAoSqCi0OZSJ8npCsJqOp0QZXZrlXnXHOKBsOXaG8DzjjiXkt8wM3LoDGoqCJAKBeReKA2juxNYHEve/Zy292QclArUQ2NIeAPKYnlasrrEFzcaYb6zYA0aIe99kgHoa8gZslfFl8dsI7/P0R5v7fKmQ7YIFvztl/j2B4BTEXRhZ75R4HQbr6ALptrgPywz8c7RjkCJhInZBOn0JVuHFJG5XH4OdKjX+GMyB6WrKY4SbH0qAMh8WADSa8P5xbv5NWFKzZpnaYqLCziMdxfo+Ed7WvOcWIgQOMS4aGscY2ICQwksNlW0MBfk2WSMhRbNyD+0ZR4UdJr6pTsGXSgwc2GbumvRf2vLdP5EysuyaEenwNl+DDyElXZ2/umziQtlQ468KgDIgd0xKw4rCe1oUyJfPexODV8KfgkiYW5q99IOVmBnq42zLmYu4jUNNTI/AO0uWUEyMN9ASIpRdtxULo2lp0Utp+ZmF62Id8TlUrrGijv6ZiyAU+mtjAlilCCTm2bn4NlN3hWQ2N+o8uvYTZmoUURj8ZOQekj8WJXNu6LfN3zasVIqm8IR4KX3hc/ceFHMXCouOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(5660300002)(8936002)(41300700001)(83380400001)(31686004)(2906002)(66476007)(66946007)(66556008)(316002)(6512007)(8676002)(26005)(186003)(4326008)(36756003)(31696002)(38100700002)(86362001)(2616005)(478600001)(6486002)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0k4YkFMaWEzRFgxRXJTS2M3bVJvUm9FWUlQa3VIMEs0NThVNEdneDZLTDFk?=
 =?utf-8?B?RVpaNUNWdFJxOGt6ODM3OUNkVWl1L3loM2ZlV2RnNmNzZTBXY2EyWjNYM3hw?=
 =?utf-8?B?b0NYMGdFNVIyVlozVGlPYXZjUSt4aVVQQk5EekpadUtoYWo5MFFKUEpLZXNL?=
 =?utf-8?B?MWJWRG1QZSszenVMWWF1dG8zTmVLcDhTcWJJdWRoUHY4aFdrTXJIUHpNcjVx?=
 =?utf-8?B?aGZOTlZWOTdGcmRVUWY5M09FOTF1SDE0MTR3Y1pMYjJJS2VlcVlLWUVsOWxM?=
 =?utf-8?B?RTFsQ1gwS0RONlVlaUxEaldScGs0RWhCOVNTWTRla3p4ZUNnRGhSeGtSZ2FV?=
 =?utf-8?B?SDB4eGF6Y2JCSndYU2ZsZVRuelFpbzREdHZmd2wzMTMzbk4wMDhLUjRlNCtD?=
 =?utf-8?B?amhZZEZMbFJjcUxtVTFCaXgrQnYwd3l1WkFDcXc0VjZOTUtXM1RXMmVEQTli?=
 =?utf-8?B?L2k5enlIM0RGM3NZZ24xS0dVVTI3QUFIS2VLOFJnMldZQjdwZ0NxeXRhc21P?=
 =?utf-8?B?bFhGMjVDOXBDc0ZZWThxRmEra25HYkhianVMRHAxcXB2QWNwaFhaL0w2ZDFE?=
 =?utf-8?B?NnpQYjJNbmgxZU1sdGhRSEdYdGxqTzZyVFZ1aWE2b08yeGc0WEFDUFBla3l3?=
 =?utf-8?B?anFwWG5GdEdIZjNmeGszejE1OVR3eENveS9YcHpLTFB1VjZaMVlON1Btalpt?=
 =?utf-8?B?cFRUT3UyaVF1NUFHalE1NTNSR1R2T2JwVjVrYW9UNFF4ZGluWXhKU1pnTFdR?=
 =?utf-8?B?OVhZeW1zV0FjcHdGSUdOamthdk5GT1RXNlNHZEl4b0VFYzRSUDJtdlJjc2dV?=
 =?utf-8?B?cUVQbmRBamRLTE9Na0VVYS8rQlpNY1NtY3o1cldXTURVOXBENlRNQ2ZDaDgr?=
 =?utf-8?B?VExMWE1qTm8rVm85SkNTcFhxemRGY3U1bTdnY2V0WGMvNlJVQTdUNG1COGZl?=
 =?utf-8?B?OXA3b0xBV1duSHA5QzFEYzk5ZTVqR25pN24wVTJzOFd2Uld6M1Z1d0JPU1lJ?=
 =?utf-8?B?Q2tYMDRCL2hwVlFHN3NQeEM3N2lQNlM1OFNPTUtyMHFVSDNsOE5MbytheVFy?=
 =?utf-8?B?SldIeStGaFNSYm83M2MwajA3UWljcXlLeUdqam8zTVl4ckc1OG1Ka25UamEw?=
 =?utf-8?B?Z1dQT1JrcTBPTUZybXlWT0dMR25WTmtPYmphRHZSVDB5NXgwcWp3YkthWDFi?=
 =?utf-8?B?eUNOQ2kvRHRubkx3VGVQK24zNWx6N1ZsL1RFK0RpMVIzblRTMEVaYThOTlln?=
 =?utf-8?B?QVhLTzFqZnNza2pzb1pCdHJLbWh5K0tjZWYrWTZCdDVkMUEra0xYNFl5Wi81?=
 =?utf-8?B?WmZ1aUlhcjBDMVQ1UXhTOTZRSlhsd0tsWHJRNWJ6QjcvdHMxRzRJNldZRE9H?=
 =?utf-8?B?NmV3cE4yNVFtY3pUaFBDZlozYzU1M1k3ckVjZVAxWnl5Q2pYemdMRlJIc05E?=
 =?utf-8?B?UVRUempmQlFyRGJwaHJnNWxieEJRT3lMRU1PUjBTZEZwOXc2c2h3YXZtT2JL?=
 =?utf-8?B?MTM2RzlUenhndmpGdkZnTCsxaTVQWHNXazk3Vmt3clU0NWFSeEF1Z21rY0VR?=
 =?utf-8?B?YU80dFU1TWZ2YU1jYVBwUnBXN21JK0FkRVFLYWZlcytwTTg5STlPaEZPQk8w?=
 =?utf-8?B?NnZ2U3FqWGNBYlhqcmF3b1B1Wm0yU0pyN3p1TDlqK2dMeDgreCt4a3lHZ3dB?=
 =?utf-8?B?MHU3ZkNleStqRFQxclJ6TlUxUk5WdXVGbjRYZFJLSkFCWE1kZnpESk9NVGlO?=
 =?utf-8?B?bVhIVmlwTVo4cUh5OHRVR2JUSXY2Nk9maGdtcEtKZzdRN1NKUGZKYlVDVzh0?=
 =?utf-8?B?Yy84a05nNm1UNitwWEFWTSs3bFltQVJvaHBKWXMvcUpJTTNMREVLNVQ1bXV3?=
 =?utf-8?B?N2FvdDIxRzhqczFyZEVuSTRjRHlaU09SQ0lUNEpGQ1Jnb3k1WWkzVXlNOCtu?=
 =?utf-8?B?V0ovRlI1NU9PbURYQitGTGJuQ3hvSElRa1VWcDhxNkExMWpuRTUzWWJXZCsx?=
 =?utf-8?B?OVpyNkI3ck5LbVpOQ2k1M1A3clE5RTU2bThYdEF6cGpxVjdtTE13RFdJT3Ew?=
 =?utf-8?B?aEc3RERJQlNqMDhZU1gveWZSaTFMK1VBN2xrQ1AxejdqakI4d2hnYUNHT0hF?=
 =?utf-8?Q?t5a+j3iM7aS1OMSbtNpC9ZYOA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96e410b-2cc0-43d9-78a2-08db08daf3f3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:14:29.3956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv9YVGjmCm7oH49VQc983j8RcmDAjCh9e8w9syVl830SAEQ6K2UId4/h2W6APbQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 22:54 schrieb Shashank Sharma:
> The FW expects us to allocate atleast one page as context space to
> process gang, process, shadow, GDS and FW_space related work. This
> patch creates some object for the same, and adds an IP specific
> functions to do this.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  32 +++++
>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 121 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  18 +++
>   3 files changed, 171 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 9f3490a91776..18281b3a51f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -42,6 +42,28 @@ static struct amdgpu_usermode_queue
>       return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static void
> +amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +                                   struct amdgpu_usermode_queue *queue)
> +{
> +    uq_mgr->userq_mqd_funcs->ctx_destroy(uq_mgr, queue);
> +}
> +
> +static int
> +amdgpu_userqueue_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +                                  struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +
> +    r = uq_mgr->userq_mqd_funcs->ctx_create(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create context space for queue\n");
> +        return r;
> +    }
> +
> +    return 0;
> +}
> +
>   static int
>   amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>   {
> @@ -142,12 +164,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           goto free_qid;
>       }
>   
> +    r = amdgpu_userqueue_create_ctx_space(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create context space\n");
> +        goto free_mqd;
> +    }
> +
>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>       args->out.q_id = queue->queue_id;
>       args->out.flags = 0;
>       mutex_unlock(&uq_mgr->userq_mutex);
>       return 0;
>   
> +free_mqd:
> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
> +
>   free_qid:
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>   
> @@ -170,6 +201,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       }
>   
>       mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>       list_del(&queue->userq_node);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> index 57889729d635..687f90a587e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> @@ -120,6 +120,125 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>   
>   }
>   
> +static int amdgpu_userq_gfx_v11_ctx_create(struct amdgpu_userq_mgr *uq_mgr,
> +                                           struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
> +
> +    /*
> +     * The FW expects atleast one page space allocated for
> +     * process context related work, and one for gang context.
> +     */
> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_PROC_CTX_SZ, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &pctx->obj,
> +                                &pctx->gpu_addr,
> +                                &pctx->cpu_ptr);

Again, don't use amdgpu_bo_create_kernel() for any of this.

> +    if (r) {
> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GANG_CTX_SZ, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &gctx->obj,
> +                                &gctx->gpu_addr,
> +                                &gctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate gang bo for userqueue (%d)", r);
> +        goto err_gangctx;
> +    }
> +
> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GDS_CTX_SZ, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &gdsctx->obj,
> +                                &gdsctx->gpu_addr,
> +                                &gdsctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate GDS bo for userqueue (%d)", r);
> +        goto err_gdsctx;
> +    }
> +
> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &fwctx->obj,
> +                                &fwctx->gpu_addr,
> +                                &fwctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate FW bo for userqueue (%d)", r);
> +        goto err_fwctx;
> +    }
> +
> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &sctx->obj,
> +                                &sctx->gpu_addr,
> +                                &sctx->cpu_ptr);

Why the heck should we allocate so many different BOs for that? Can't we 
put all of this into one?

Christian.

> +    if (r) {
> +        DRM_ERROR("Failed to allocate shadow bo for userqueue (%d)", r);
> +        goto err_sctx;
> +    }
> +
> +    return 0;
> +
> +err_sctx:
> +    amdgpu_bo_free_kernel(&fwctx->obj,
> +                          &fwctx->gpu_addr,
> +                          &fwctx->cpu_ptr);
> +
> +err_fwctx:
> +    amdgpu_bo_free_kernel(&gdsctx->obj,
> +                          &gdsctx->gpu_addr,
> +                          &gdsctx->cpu_ptr);
> +
> +err_gdsctx:
> +    amdgpu_bo_free_kernel(&gctx->obj,
> +                          &gctx->gpu_addr,
> +                          &gctx->cpu_ptr);
> +
> +err_gangctx:
> +    amdgpu_bo_free_kernel(&pctx->obj,
> +                          &pctx->gpu_addr,
> +                          &pctx->cpu_ptr);
> +    return r;
> +}
> +
> +static void amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr *uq_mgr,
> +                                            struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
> +
> +    amdgpu_bo_free_kernel(&sctx->obj,
> +                          &sctx->gpu_addr,
> +                          &sctx->cpu_ptr);
> +
> +    amdgpu_bo_free_kernel(&fwctx->obj,
> +                          &fwctx->gpu_addr,
> +                          &fwctx->cpu_ptr);
> +
> +    amdgpu_bo_free_kernel(&gdsctx->obj,
> +                          &gdsctx->gpu_addr,
> +                          &gdsctx->cpu_ptr);
> +
> +    amdgpu_bo_free_kernel(&gctx->obj,
> +                          &gctx->gpu_addr,
> +                          &gctx->cpu_ptr);
> +
> +    amdgpu_bo_free_kernel(&pctx->obj,
> +                          &pctx->gpu_addr,
> +                          &pctx->cpu_ptr);
> +}
> +
>   static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
>   {
>       return sizeof(struct v11_gfx_mqd);
> @@ -129,4 +248,6 @@ const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
>       .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>       .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>       .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
> +    .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
> +    .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
>   };
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index a6abdfd5cb74..3adcd31618f7 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -25,9 +25,19 @@
>   #define AMDGPU_USERQUEUE_H_
>   
>   #define AMDGPU_MAX_USERQ 512
> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>   
>   struct amdgpu_userq_mqd_funcs;
>   
> +struct amdgpu_userq_ctx {
> +	struct amdgpu_bo *obj;
> +	uint64_t gpu_addr;
> +	void	*cpu_ptr;
> +};
> +
>   struct amdgpu_userq_mgr {
>   	struct idr userq_idr;
>   	struct mutex userq_mutex;
> @@ -52,6 +62,12 @@ struct amdgpu_usermode_queue {
>   	uint64_t	mqd_gpu_addr;
>   	void 		*mqd_cpu_ptr;
>   
> +	struct amdgpu_userq_ctx	proc_ctx;
> +	struct amdgpu_userq_ctx	gang_ctx;
> +	struct amdgpu_userq_ctx	gds_ctx;
> +	struct amdgpu_userq_ctx	fw_ctx;
> +	struct amdgpu_userq_ctx	shadow_ctx;
> +
>   	struct amdgpu_bo	*mqd_obj;
>   	struct amdgpu_vm    	*vm;
>   	struct amdgpu_userq_mgr *userq_mgr;
> @@ -64,6 +80,8 @@ struct amdgpu_userq_mqd_funcs {
>   	int (*mqd_size)(struct amdgpu_userq_mgr *);
>   	int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>   	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +	int (*ctx_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +	void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>   };
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);

