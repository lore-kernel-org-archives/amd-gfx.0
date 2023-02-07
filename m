Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC6C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE29810E440;
	Tue,  7 Feb 2023 07:20:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F09F10E440
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRjzfQcETY4X9xutISQTzDRuSkb5qUW0VXj6Hzp+YtWj48GgGw0du9Vn1DW3mH1/jVLRKGnzjb1i+e9i2nseWka0ueYofedNr1BP5MFuQlQmGMX5G9owxX5iuHfQoLINyIMHTYlQXb9Cj4OZob/VV1psD2/02UdCrKOKmJecyrY33vUzMVfDFLw4T64sq6ZWi77habebt0CbAxMBcGYN7jYi3Wt1wb1Oy7Fahi1bamqdpndkEFmik/yUjZJa+gYnMyypnySBYgPst+bbJ7eCjaeXpO0TgebPTMUz8AjDEENO2xwgA3ffhQ8KDpn5d4RPhGsyG7zYOO+E7pM2AegFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyTsLWPBLA0U9tuvEom/RjSN7y2YfEhQNnsaopLTgBg=;
 b=NKCSN7ngL5sIU3R+GKu//2lHcOYCEyfx2HUFO+YnKO5En3QnQFiBFChfKfyT4EGCc7YCU5dR7PXMMWUG9lk8NeWBQyOOTh8jQvdDM7p/ymmYz/qlN1izsV2tB1pei9M7w0UBrGIqpnM/d8iqFzzGzQ2xHOtj5wC5edFPSz44N0cmPEiwCcDZulmD56IFFjMeJZr3sz+Rc710HzzVfO08Fe6QTwlFEcOuRJmmFxrp7nIDStq5BB7DOtCZQj/BANE1iwSY4lmtbKPwZV4I67nTaFMP66grWmFzfYj++Tq0f2tklI9lzkTvo5OCvXAw9Z+gS8mI5MT8rhIHKVIR+H02ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyTsLWPBLA0U9tuvEom/RjSN7y2YfEhQNnsaopLTgBg=;
 b=qjToHpgdJy1gjvF4C7kSG/5rhGzbGDxopDI6olW7mwYtsEys8n9TsYDX6KBDjZMB8OyQwZM9iKLU9FpGtgrMM7Dvh6nkFUgEc84UNXc3EAhlv3x0HXU2tAe6hH4x4dO++ozJZ06/S/WNKQnnBCvaxfQDJIsH8s4ojZoi7ZBIGVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 07:20:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 07:20:12 +0000
Message-ID: <c7a30142-cd29-ada1-6173-df85748d589f@amd.com>
Date: Tue, 7 Feb 2023 08:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/8] drm/amdgpu: Map userqueue into HW
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-7-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203215409.2021-7-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2f5ee1-4506-45ad-5e4e-08db08dbc04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbjA1ikcNSQvYcLViphH+NOl8Gmksr/F5Tb2WImqJsBCprlf32EAhYTrocNrThnWenhdRebmxWx+jYhfdRkRYl5lQXG+ve+rCMNLkvH3CY9iWGRIk6sMAaYUjcyPLw+iVmCNJpKmIyGqsyRmkQIyTg55obPoeshynpiHdgsPAJjHyqw76cCf785PPKytdJjyy+X8r/yj753fYrPVxen6+pUg5YcINn9zZCiHxlCkP7pS2KWwSFgu3v43jH042OXKhe5z0ILNqeqpyQRoAIbOPjyP3nD+d9I9IbKiHI/Ot2Ow4q8d8MHoXDY69y3y8kGZCOPlGlh6vbvmtO2rHXiH77bm4iDTM3iSMnuOStWy2wGJ/UYIFWY1krjUqbhtjMAG1/fwK8DA9y3TKG92dglHUkKbjDtb78yYIIPDuDJnTf8amCW3jZ2+lTjj9QaaRZakhQXFjrcfrzTj2heWwEDwVhCWBcIjwX2vG4lmTGSSsFGwZpy3GqGd9RXyVFnP/ZLK2cMOAoWdgxOML+gN7iWFEjvgiFxK8X98cHB/35cw5VHD022o94NQDz8erxdHmfT5TP06xC7+SB5qDCqoUyzCLInnqM7/I5/N2LDPiEhd8/dP/xW62iVt3rO5IfD6uGV4vWfEPJychx79x/vv6dlB931nxBpjW26R08lifa9uWGP3t6KVUPuHSMMLBj4QpMWyX4yjBfAYj5vjj41+zNcIK4ip1bLGzyJXiIuKEOe1f8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199018)(83380400001)(478600001)(6666004)(31696002)(6486002)(2616005)(6512007)(26005)(6506007)(186003)(36756003)(86362001)(38100700002)(31686004)(8936002)(66946007)(5660300002)(66476007)(66556008)(41300700001)(2906002)(316002)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDlIVlpFem9hUk9WYm83UnRLS1lzNUhZRHByNkJJbFJtaktBNFhhKzR6RVNU?=
 =?utf-8?B?Tk12anZ4M2tLclprK2JraDVtdlVpUFV1OVdpbUpxcUZYWTZVcVZlTnNkdDBi?=
 =?utf-8?B?dXZUZThLTmNZNStBdnhWRUpHNXNPRnZCaU1JY1BmUmlQWDRVK0xJcG5wL2NG?=
 =?utf-8?B?QWdpT1pYMW51UDZVcU5GNGl1ejl5clFud05Oc2RsVEZuNFM3QStVOWlpbThP?=
 =?utf-8?B?Vm5rOXYvWEhwbnV6UE93RkRtUjBBSktpZ2U1aTNWWXE5RHBVV09Ed2dEd3RK?=
 =?utf-8?B?VlVtNTkySzh5UTlxN01KNjg1N2dsY1ljS08ySEpxbS9YUzJZVVFqLzI4S2k2?=
 =?utf-8?B?VEhmVXB6TTE0TFdhSythTmRHSGFPL1ZDcWNqTWxib0g3SFJBdTl0VW14cE14?=
 =?utf-8?B?dTBxZWRkNG56NTZDNFFLMjQ1NUMwV2dZOFlyNWQwUHFsaE5MOFVpcmpIUmxG?=
 =?utf-8?B?czQ4SjA4WVZrT2hiOXdDakE1WGRZTFpnWjdVcDhZRDB0V1duRjBMTnZ2cGxx?=
 =?utf-8?B?VEZQU2tNaCtWSTN4RnhSdSszbk4rQUEwQ0FXTkFCZVdOYmsvdXgvZHlxYXBV?=
 =?utf-8?B?NzJlUFcra2FOcmlVZXZ6bForSWhXODJLcnRkSVF3VGVTTFh5SVJFV1ArdkZF?=
 =?utf-8?B?c1F4QzVuQkpzeG90MEd1Qy9IeUtkUURVNmwzSGFkMWJsZUtLSk5ZNExJdVlL?=
 =?utf-8?B?WEo0ckM0SjJoNDZLK0hqRjVkK2lXcExOWllqcHdya3lvOGhhbG02dHM0amxk?=
 =?utf-8?B?aGR3aVRiYldBU1FEK0VJR2ViMEVoWnFQdkhyOXVva0dPZWRUMmg2T3N2OU8x?=
 =?utf-8?B?ZmsvSnBuajMxQTI3dlFDODI5TlpvZ01TTU1rTjdOa0s1VjNRUDB4M0ZxS0kw?=
 =?utf-8?B?RVhIVkNNbU9uWmRHUUxKRDlBUGlDZHVka2wrVnNpcG5lUkxldWdwZVFQSG12?=
 =?utf-8?B?ZldWRXAzRXNGVEpCYm05RDAveFVndGpsZVo1UCtDZjRXb3RIUk00b3RRRUJk?=
 =?utf-8?B?eFZHVUxFRk9KMklBTmc0clAxK1kvem1Ta3JacG9ieFRCTGVtdFFrdU5wdjdH?=
 =?utf-8?B?Q3d2R1BVcStjTkgvNVk3ampXWFRQU1BqdnBDY2dMK2ljVzNiWThTdkZGaDZC?=
 =?utf-8?B?T0c1dVdOeVp4c0dMRjM3Y000MFN0RWhsYVZFWm5YREJhZzFuSVN5SzZSclMw?=
 =?utf-8?B?K3JqclhqQjFDZDNndVNlZmpuSkdURXAxVTdNTkI4Z0dQd2NUWUUyVXp4Mm5j?=
 =?utf-8?B?dlF0S1hjRGpRNU9IelhyUkhJRUg5RWdlQUdVN2g3cVNJYkZ0bnhRSEp0MXlI?=
 =?utf-8?B?YnNLRU9kMXVuSFRzMnU2aGNvaVNXdUUvcHJlSWtGQUpnRFhEWGtacEs4di94?=
 =?utf-8?B?VUlVTjFYNDNVdmg1MmtOQjFLZ2tLZngvVXBEQXRqamg2aHBOQUowZWg2eldo?=
 =?utf-8?B?YTFVU2RrMUcxSCsxSzF5dHB3LytZQmJPT1J0alo4MDBCNGJISXhtM28vR1NP?=
 =?utf-8?B?Vm1IRXJwVWVTdnZ0UmUxZjJhQ3F3NDBPTkZzRWhMZEVEcHc4Z1A1aTk1SUJ2?=
 =?utf-8?B?dDhqN3AwZGt1L2hIK0srYUJrSW9yK2NDdmtpeldZSjQwT0grU2llcUdTQXp1?=
 =?utf-8?B?TXZ0RDFiQnNxeU5kb2FGblQxZDlabUxNcG9td3ZXOUtkK09DY2lIcVJYU2xD?=
 =?utf-8?B?aUlZMFFvY2RCZ2w0YUZ1aU1aVlFLbmkvSytxYm9kSlQyTkJuR0tNdXVXUGNI?=
 =?utf-8?B?eXVpMnRlVUtZN3hZVGlVeUI2RVUwODd5eFRJTXlTS3VzcU9rK1BGVVNSQjVn?=
 =?utf-8?B?QmRFdWVoZ1FuTEY2eCtPUG81R2VVQUtXcDZkdG9GaTJaU0pnZVpBd2dEMnFW?=
 =?utf-8?B?RDJWaTdORkVKTE9oWi8zSzlxOCt0bmVMODRPbjc1WXVRWWc0Sk12ai9xYk13?=
 =?utf-8?B?ZkRidElWUWJYL2l2VG16WGtxb0wzZjY4a0g4cVBjalJrZUlabGs2ck92N1ZM?=
 =?utf-8?B?MklZZ0tGU1hiQ0lQdXM0VWlHNmhQRldpZGxxUjhleHQrOUhLZWhGTWFDdmVx?=
 =?utf-8?B?Z2w1RlJtZ2VCcWtTTXRHMXJKL2krdUp4a04wOCtZYW5QeHBuYyt4ay9YZ2x4?=
 =?utf-8?Q?QcdilQy7/4G3DYuSBZSwj5PO4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2f5ee1-4506-45ad-5e4e-08db08dbc04e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:20:12.2309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LECBcmdoyAgPfQAZb7/6SCLQVHJ9vyVTGlLKio4zrEJKWmuJmteZXkE2reKe4WmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 03.02.23 um 22:54 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds new fptrs to prepare the usermode queue to be
> mapped or unmapped into the HW. After this mapping, the queue
> will be ready to accept the workload.
>
> V1: Addressed review comments from Alex on the RFC patch series
>      - Map/Unmap should be IP specific.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 57 +++++++++++++++++++
>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 47 +++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +
>   3 files changed, 106 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 18281b3a51f1..cbfe2608c040 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -42,6 +42,53 @@ static struct amdgpu_usermode_queue
>       return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static void
> +amdgpu_userqueue_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +                     struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct mes_remove_queue_input remove_request;
> +
> +    uq_mgr->userq_mqd_funcs->prepare_unmap(uq_mgr, queue, (void *)&remove_request);
> +
> +    amdgpu_mes_lock(&adev->mes);
> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &remove_request);
> +    amdgpu_mes_unlock(&adev->mes);
> +    if (r) {
> +        DRM_ERROR("Failed to unmap usermode queue %d\n", queue->queue_id);
> +        return;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Usermode queue %d unmapped\n", queue->queue_id);
> +}
> +
> +static int
> +amdgpu_userqueue_map(struct amdgpu_userq_mgr *uq_mgr,
> +                     struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct mes_add_queue_input add_request;
> +
> +    r = uq_mgr->userq_mqd_funcs->prepare_map(uq_mgr, queue, (void *)&add_request);
> +    if (r) {
> +        DRM_ERROR("Failed to map userqueue\n");
> +        return r;
> +    }
> +
> +    amdgpu_mes_lock(&adev->mes);
> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &add_request);
> +    amdgpu_mes_unlock(&adev->mes);
> +    if (r) {
> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +        return r;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
> +    return 0;
> +}
> +
>   static void
>   amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>                                      struct amdgpu_usermode_queue *queue)
> @@ -170,12 +217,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>           goto free_mqd;
>       }
>   
> +    r = amdgpu_userqueue_map(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to map userqueue\n");
> +        goto free_ctx;
> +    }
> +
>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>       args->out.q_id = queue->queue_id;
>       args->out.flags = 0;
>       mutex_unlock(&uq_mgr->userq_mutex);
>       return 0;
>   
> +free_ctx:
> +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
> +
>   free_mqd:
>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>   
> @@ -201,6 +257,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       }
>   
>       mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_unmap(uq_mgr, queue);
>       amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> index 687f90a587e3..d317bb600fd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> @@ -24,6 +24,7 @@
>   #include "amdgpu_userqueue.h"
>   #include "v11_structs.h"
>   #include "amdgpu_mes.h"
> +#include "mes_api_def.h"
>   #include "gc/gc_11_0_0_offset.h"
>   #include "gc/gc_11_0_0_sh_mask.h"
>   
> @@ -239,6 +240,50 @@ static void amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr *uq_mgr,
>                             &pctx->cpu_ptr);
>   }
>   
> +static int
> +amdgpu_userq_gfx_v11_prepare_map(struct amdgpu_userq_mgr *uq_mgr,
> +                                 struct amdgpu_usermode_queue *queue,
> +                                 void *q_input)
> +{
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct mes_add_queue_input *queue_input = q_input;
> +
> +    memset(queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +    queue_input->process_va_start = 0;
> +    queue_input->process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
> +    queue_input->process_quantum = 100000; /* 10ms */
> +    queue_input->gang_quantum = 10000; /* 1ms */
> +    queue_input->paging = false;
> +
> +    queue_input->gang_context_addr = queue->gang_ctx.gpu_addr;
> +    queue_input->process_context_addr = queue->proc_ctx.gpu_addr;
> +    queue_input->inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +    queue_input->gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +
> +    queue_input->process_id = queue->pasid;
> +    queue_input->queue_type = queue->queue_type;
> +    queue_input->mqd_addr = queue->mqd_gpu_addr;

> +    queue_input->wptr_addr = queue->wptr_gpu_addr;
> +    queue_input->wptr_mc_addr = queue->wptr_gpu_addr << AMDGPU_GPU_PAGE_SHIFT;

Well that here doesn't make sense at all.

Christian.

> +    queue_input->queue_size = queue->queue_size >> 2;
> +    queue_input->doorbell_offset = queue->doorbell_index;
> +    queue_input->page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +    return 0;
> +}
> +
> +static void
> +amdgpu_userq_gfx_v11_prepare_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +                                   struct amdgpu_usermode_queue *queue,
> +                                   void *q_input)
> +{
> +    struct mes_remove_queue_input *queue_input = q_input;
> +
> +    memset(queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +    queue_input->doorbell_offset = queue->doorbell_index;
> +    queue_input->gang_context_addr = queue->gang_ctx.gpu_addr;
> +}
> +
>   static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
>   {
>       return sizeof(struct v11_gfx_mqd);
> @@ -250,4 +295,6 @@ const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
>       .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>       .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
>       .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
> +    .prepare_map = amdgpu_userq_gfx_v11_prepare_map,
> +    .prepare_unmap = amdgpu_userq_gfx_v11_prepare_unmap,
>   };
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 3adcd31618f7..202fac237501 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -82,6 +82,8 @@ struct amdgpu_userq_mqd_funcs {
>   	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>   	int (*ctx_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
>   	void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +	int (*prepare_map)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *, void *);
> +	void (*prepare_unmap)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *, void *);
>   };
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);

