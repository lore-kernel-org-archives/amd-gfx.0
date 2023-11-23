Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6BEC61DF7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 22:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD30410E363;
	Thu, 23 Nov 2023 22:34:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4055810E363
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 22:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibkOAIgL1TZrjuagq1Emev7XXah3Xr11Iozn+3fX23CRA8sIMNxmSKuHfDVrV+OOp0Di63pYouF+c5V5LwpIRNrTft532JRDF6jrVVKrvc9t/kvJYSzcgvm6Dip4mpr70XEZawZdZ5l2VQVTbMHF4SK4yWvhRf9SJNk2Lk1cMax0ysar7pQjpDXeWoB5t6f4zDtaufyzl3DoMNTgCuCaVlJwNoP7XnxrgwcK+CKMlaQQvnt8p6g8beZNWpdtEehXrpWu1FuQalRdlXq1n6KXcwOa1nGNabmKjB3fHdQN/Im/qLpSKuYUmvmJSMgTih7gqECk4CboEiw/3IYmLZ4HeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il8uYrwvuwBKZJxxQeGoRRa8KnCu93+mu2BRCDp4F+E=;
 b=ZFa3paTtHdi041AuoDO61UrBFy1K3pjYXDQt9ecozasehGcAhER6YyXLexSp0AxCETpKia9Xn/7WigTDrsBuMIjFoGgQIgQwsoRbH/dUrMMXNYDjacK0YQxbsztdxVjTdRnzbJ6tRO9XbuiNl/+BD0bpC1JogwZ8bw34EZKVINju6x1HSzbJgTHSTAFd7qOLcxp1/X1zdMMwg9vAfdrziclLq9H5MhOSy6sOvkfiHXxSAwsTyATZqUTIqn77xVU8B7ydi3javtRpri1cgNY1l7I3yAu6yJm0gNAjXnTtdg2C+N35LJKT+GS95XAsdXmmS56l6hrK+Plws04nYsLEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il8uYrwvuwBKZJxxQeGoRRa8KnCu93+mu2BRCDp4F+E=;
 b=kvUYGqJwlosd8sAUpXci2UMmA/PHnbOxC7x+vnsuXw7+KyY5SaKArLGN3OO+Oxo8Ibx7arRvEamuWE535pVq9aSfvmtayTlDIuBKbkl7YdclM+41UqOoXUk6QP8yOSxY4h5gnPJ6UZsvCAxRrARbMMVzKn+fsVA51np1hjAqndc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 22:34:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 22:34:04 +0000
Message-ID: <fea43b12-ce54-430f-ae38-4d8c21cb7a6e@amd.com>
Date: Thu, 23 Nov 2023 17:34:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Content-Language: en-US
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231123062001.231761-1-zhenguo.yin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231123062001.231761-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 768c3006-aa6a-48c2-4d62-08dbec744c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6skjmwqUaAzvTucA0GMhDweYx9vR9qCgK3Nd1jsIwsf7d/C0v9awOxAxJRHupCx2/u3AXK7TIWIWRp/jQlAIh4VN8rDJNoaOUIsDERerqbPeo+tIsi7A40iB6720HeNfG/AGjSXE35/YuKSIIPxI9+Xtk0w9gJvygpY1IVDyaKnuT8NpM6R7JxPyBP2P37RVXDOgetX5K+/ENEBz+jujLStQNpR758dC0vFor9Db3eSSycQjTxFPMck5Wid0yk/C1EfD6GSvG0gH8hxpwNAHNzS3ACRHv2FJ4XnpP/APg/Sqsj7NXhAsP0U9nlkozZ10eFIiO4BBZdObzT526ziwit7c6EmJcOKdmGYKZZ8xqb76zxCdLCVMMjWw/hrrneUMgCPZoLuvN9ZFz8Wt3v+fsR44RtaGH80jtrdixQjNTYEhkxheUsvsctx3d/5W04XGNzqAbROtbx4759MQHMk3JUvZbKjVJHflGP7CthOil+y8tpHa/7kJ6LKqtxEpo7Twi2QdMoHlrlSOtpR1B8OqBdMXr8lODi8+sAHgA7HAaNCBBl65y96BtA4cLuBSBKl+hMRTrtQnIbe9Zl0qqARoqRPf4vaFc06GLZCPCVAmzDBx8lT2B9xv1eRv03eW6uP9GaVNVQwqmhn1F0CeJckHhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4001150100001)(5660300002)(44832011)(2906002)(8936002)(8676002)(66556008)(66476007)(41300700001)(66946007)(316002)(478600001)(36916002)(6486002)(6506007)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(83380400001)(86362001)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGdiSk1OdXFCVit4c1R4RHN1blhEN3hxczI0ZnZrMDJncnVNdVhhbENwb2Ji?=
 =?utf-8?B?eHFFRmFDQ1ZZS0hZUEgxdWt2eC80QlU2Ulc1bTZBL3dDUmwxSTZpUUM4SmlP?=
 =?utf-8?B?VFUveEFCNmhlVC9vYnpuMFdMSGVKcFB5RnpmRllLSEU5VTJsYzZZb1BLWXVh?=
 =?utf-8?B?UnpDMFJlZ2kxZHp0Mk9PcGtJY2dFL1hyT1pVRmpzeHBMR1crR3dSMDBwc080?=
 =?utf-8?B?ZjdEdzhpS0hseC8zdklOZlM1ZTltcklBM0E2b0tMeW9HWjBVN3dSU2pvT2t4?=
 =?utf-8?B?ZGJFMXFZUjlrZC80MGF1VFpkQkd1TzBScGNIZEpOazZvQXdlRzhvdWhqRE83?=
 =?utf-8?B?ZzFhbkNyWWp4QnlleDc0bzhNSkxXQU1XYVFlZzF3bE5oaXlldWJrZ3ExbVho?=
 =?utf-8?B?Q0hiLzdGN0ZGcDFydzd4MTJ2dm93cmtYQ0pnY05lMTVPZVpCU0xjbEdIT2VY?=
 =?utf-8?B?UjZPQW5vMmdpZUlIS095TlRBbGEvT0FZSXFndWxoNXBGQ3QxTWdGYmdLOGhB?=
 =?utf-8?B?aDQ1QnExVjRYbDk3QkhoUldrUjZ6UnlDcUFpK1F1NXB0Q090d0Rib0tQQWJu?=
 =?utf-8?B?Z24rdmdEYnNtK1pZUU9PcHFQTHNVeU1YdlpXUktRczBwanhMMmxkZFFRM0Q4?=
 =?utf-8?B?MU82ajRoa0VsUHRJODhoWkwwRDVtREg2U3MvWndObVRFMkF5aXB1UmJaYlZM?=
 =?utf-8?B?TWJHV3pSdE5NY0czQ0ZHSlFXTVJObXpMcWZTNDJPNkd2ay9lZ0dKTlFEVDgw?=
 =?utf-8?B?NERyWldoOHRlSnJkZXBmNURlNkNsWG1IYXhMWjRYTVlHVFpZeU5ZeTBFOU84?=
 =?utf-8?B?UGtlUWJKWGtEMXlpWnlTTEZuNi90cWdNSTJWa25OQmkxK3BpWUZFclZlR0pI?=
 =?utf-8?B?UW94a1EvNExJMWN3K1RrZWsrYjVpZEtDV2FOWi8vbzBQc1dlN1hqVEJRZ0ZZ?=
 =?utf-8?B?YjYzU3ZNVDk2ZXdDM1RXK2ZKbjlEd01FRDlsbG9pR04rOFF2NWppSlcwWXdX?=
 =?utf-8?B?Ym5wTmREbzV2T0hSbW52K3JhNkpjcFhscWp2bVV3aEpNZUM0MHlSbHFEYkFn?=
 =?utf-8?B?UVFOdUd0NzZoRXdnMVNzc3hEMW1MNGx0ekdoRXc4V2c5TWxaaS9DcVRPclFy?=
 =?utf-8?B?UG1idFRBMG91Y05vSk1ZU1RGYnRLR0NWamtMbHBkK21EdkxLSlB1bHg5SjUy?=
 =?utf-8?B?VEswODk1cjdYeEpyVy9qMFFGS05pR2VXTkx5Rk9xUk4wNXNKVVRFVTgzV1Vy?=
 =?utf-8?B?NTVlazBkWEhDclRBOWg0ejdnUWJlbEpnL2hHZ2NDREVxYjJHZFVxWEFiKzJV?=
 =?utf-8?B?aUJ6ek1LNDBKZEU2WGwxKzZEQ09rL01FSWN0MDdXWklCVGptUWZtYkpLMHR3?=
 =?utf-8?B?bUMvV0JXYmFOaXFsOWJOcFloaS81WlhWTVkvVGUwaVNNaStXWi9wR0t3UGtr?=
 =?utf-8?B?Wk1ZTTQvTXRlZ1pwd1Y5eldEdjJSdE1paXpZRlNGRGV6czl2eng5d0ZIMlRS?=
 =?utf-8?B?Qjhja3NFLzhZdFRFNkJnczRTcEx5ekYzR0x5Tk5ZVHlvN3lRUEl4bW1HdWhK?=
 =?utf-8?B?dEh3K0NiSE04eXRYYy9UbVptdU1JQjkrVmFoQVk2Tm1lL2JhK0NvUFRuTXpX?=
 =?utf-8?B?cis2VzBJNmxNWWp4dmF2c0dxSkZmY1p3VkpHcnlSTzZZdFEvUjA4UkdvWlk0?=
 =?utf-8?B?NGpwL2t4V251SldoTWVjMm5MSld4b0RVU0p1Zm52S0Z4elpHZU1nY0dOSVJu?=
 =?utf-8?B?SE04TE16Uk5VclMrYytraUhCdldnZ0VycE45U0puanhWZy9UcmhtR25nU1hu?=
 =?utf-8?B?Y3JVSFdXS041NEZ5TVFXbTB2UUtLYnIxTi90QnlQMG9MNmdDUUgxdDlzSitR?=
 =?utf-8?B?SXhJZDV4a0NmMFF1L1hFdldVZE9Td1NFK0RTZEpSWTlXRkw3N0tzNWY0cXk4?=
 =?utf-8?B?YllYRGJUUmdIWVExalQybzVhZ1l1WGtwUk9iTHlyRld1ZGRGWUx6Wi96WXRr?=
 =?utf-8?B?ODZWZDh0dXY3cXJzMlIzYldnZjAwYllHckt6bkJKSUNRMnpFZ0hxNmFncjl6?=
 =?utf-8?B?QW5FZHRiRWtzSW9DVEVJeE9UbkVkeHNNTkpaNHFhL0NIa1NFVURUblV1d24v?=
 =?utf-8?Q?mYbx0UFjTPktsx84aMvabSom+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768c3006-aa6a-48c2-4d62-08dbec744c8a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 22:34:04.9351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoIX1h1NZ01LaVoHzUTH7pXCl6RfdKAho7WcSmczZDh3VCy8p6w1u7thV0WQRJE801LjiN836NYeU8Lk0QykSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-23 01:20, ZhenGuo Yin wrote:
> [Why]
> Memory leaks of gang_ctx_bo and wptr_bo.
>
> [How]
> Free gang_ctx_bo and wptr_bo in pqm_uninit.
>
> v2: add a common function pqm_clean_queue_resource to
> free queue's resources.
> v3: reset pdd->pqd.num_gws when destorying GWS queue.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 54 +++++++++++--------
>   1 file changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index ebaec476f49a..fb5840a5df06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -169,16 +169,43 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
>   	return 0;
>   }
>   
> +static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
> +				     struct process_queue_node *pqn)
> +{
> +	struct kfd_node *dev;
> +	struct kfd_process_device *pdd;
> +
> +	dev = pqn->q->device;
> +
> +	pdd = kfd_get_process_device_data(dev, pqm->process);
> +	if (!pdd) {
> +		pr_err("Process device data doesn't exist\n");
> +		return;
> +	}
> +
> +	if (pqn->q->gws) {
> +		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> +		    !dev->kfd->shared_resources.enable_mes)
> +			amdgpu_amdkfd_remove_gws_from_process(
> +				pqm->process->kgd_process_info, pqn->q->gws);
> +				pdd->qpd.num_gws = 0;

Wrong indentation. I almost didn't see this at all. It should be 
indented at the same level as the if-statement.

+		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    !dev->kfd->shared_resources.enable_mes)
+			amdgpu_amdkfd_remove_gws_from_process(
+				pqm->process->kgd_process_info, pqn->q->gws);
+		pdd->qpd.num_gws = 0;

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	}
> +
> +	if (dev->kfd->shared_resources.enable_mes) {
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
> +		if (pqn->q->wptr_bo)
> +			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +	}
> +}
> +
>   void pqm_uninit(struct process_queue_manager *pqm)
>   {
>   	struct process_queue_node *pqn, *next;
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
> -		if (pqn->q && pqn->q->gws &&
> -		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> -		    !pqn->q->device->kfd->shared_resources.enable_mes)
> -			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
> -				pqn->q->gws);
> +		if (pqn->q)
> +			pqm_clean_queue_resource(pqm, pqn);
> +
>   		kfd_procfs_del_queue(pqn->q);
>   		uninit_queue(pqn->q);
>   		list_del(&pqn->process_queue_list);
> @@ -465,22 +492,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   				goto err_destroy_queue;
>   		}
>   
> -		if (pqn->q->gws) {
> -			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> -			    !dev->kfd->shared_resources.enable_mes)
> -				amdgpu_amdkfd_remove_gws_from_process(
> -						pqm->process->kgd_process_info,
> -						pqn->q->gws);
> -			pdd->qpd.num_gws = 0;
> -		}
> -
> -		if (dev->kfd->shared_resources.enable_mes) {
> -			amdgpu_amdkfd_free_gtt_mem(dev->adev,
> -						   pqn->q->gang_ctx_bo);
> -			if (pqn->q->wptr_bo)
> -				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> -
> -		}
> +		pqm_clean_queue_resource(pqm, pqn);
>   		uninit_queue(pqn->q);
>   	}
>   
