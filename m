Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A51CEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 22:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE4510E692;
	Fri, 16 Jun 2023 22:04:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E290D10E692
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 22:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2Zhw+23CbfQdx6tBZqHfeU68NRhhc93KDts6A/bgzOHyD1UP2aFayzVNbhoBq3Hx0utDyY6xMfEECsdru9qfeXsqTHjeqwy7AzWcMGC47rC5eO0KJq3DbxBUPisoRsVVf9Ds5vX3usMgB4OHat9UaxaVi3QKVCQ1N+cNuE1ewOXoDvy3IcpzkyeneuG015xUq3pe2OIHiJjVdBAZQJeByRZjh1huOo3PnnImO3XfFd/NUwHaxbguRh7zWHRTLkYDX61zga+gcI29ISLAxqMSq7Qqr3WSkLxafpgnIthq48LAhThL8EFLP4xxwjTFJ3AmbkPuCBARwbGcrXO60wpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcvBrUw9cMwlXN2ieQYr2MO6KWEP1vvYLH58TB662Y0=;
 b=L4Yi/8sHu6emdidbq5i1botN2v8t/j+AGir6kRRCKYnKmd8W9OGpqQMsNr804eN3B9Lauy+ZO3DPYsB8WjdKXkdvVP9FUyS6ApyMooTYI0uaX3M/YkbwC5ArtPILhg+VYrT9Vd94RA2OEJGVeZvYJKNK7ViB9VN175ENOmjV/Q8FPKuO5i7f+978NgsAs5ZwLKFmYNO3Hl8HvZKfcZlaf4ZV6wk0oVfpLVVzRNXTroA1rl5lvT7bN9KkkJkJojT+/9STJ3J3dLXPzZahJ7v7dqhOBRe6I2mD7BKII4STJnw8wKtsJyZH//06HadTkqWu3pbfg5XGqLP7MB4yvowlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcvBrUw9cMwlXN2ieQYr2MO6KWEP1vvYLH58TB662Y0=;
 b=ncP+o6JaVMrmdshHmf3d4uDj7uhqgWIQxKFYdmnBv4ymmb7etSPcWvtBiBJCzvI5DxQVvxPkNkadfv0AfPRqzdWzIFIQmCE7H9M0q1pHwk8RgNvotnYMfW/itgtocc2+AcdaJzQ56tjTlsuUgZsLPGO7a5C76IzInNah97kvnTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 22:04:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 22:04:01 +0000
Message-ID: <12233ce1-f757-fa2a-a98e-918d18a1569d@amd.com>
Date: Fri, 16 Jun 2023 18:03:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2] drm/amdkfd: Enable GWS on GFX9.4.3
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230616184406.1272146-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230616184406.1272146-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: b88039bd-cb90-4df3-11c3-08db6eb597b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vep0bvzf87x/x6mg7nvu/cAKSVo3EqsPvDxRoWElkrjGXIExNhri5CCVgr8zoQY0FC1trprJFkCFS/xNoC9bbrOe6V1ljVjOi6cGQ05WarraRhjU9Hau4XbTt2qtU1Gd0u/Ky8mxx+Dw3IJ4CyybJa3X6WkY2gx5b4UtYSmjGHqS07Nuv/aqxhPk1cd/UNukrEc7eQVNNvMJ42P+l+HRJGPDC85RZj7eWoUDgqXE3EmyTTi+AZat+tnXf7CBlfbYtl5s3iBbbUFeieP+ycPmGsJ5mmcrqlzzvG2CGPvyMYxSY+i+cf5UI90C+zqpeiZu8AtOJawJSAILjuiW+zTnb3lGDcn0pAP1nTHlAzL3D68OAIikRP0i9orzJK6k6HqJqLnZgI5vUQeTsixSPfXAlpKw4SNUzsGsxeghG+CSfYHhKVyonSGRsBJil0u2thm+UyeYOWW6rwRW2rCeQkKcLw8MCwGOABvs0fZ6q0nspAuxGqKyflKZwcv/T6AsqH4M5v7DspBDwyZaqv/Kg35jDOVtYMhQGGkYegUWflS/a24rXFBYrR/RaAu3ys/XyHcNNYBNk9Y1SdC8yzvs1NHTdvChXo6YqtAKUx12SWCGd9gKAMxSJL/fYMjikvpuwXpV32JepEI6iBr7SOzEM3WPlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(31686004)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(44832011)(41300700001)(8676002)(66476007)(66946007)(83380400001)(2616005)(66556008)(53546011)(186003)(6512007)(6506007)(478600001)(36756003)(26005)(36916002)(2906002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Mvb3JEQzl0c2orY0s5RkNFcHpYbnRkeEpvcGE2MG92d0JEVXhMNzd1S21J?=
 =?utf-8?B?aHdrcUpaMDlyVzFRUUdRWkFkdnVCU2xUQmx0SmVKdm0zcXFXbWM0VmgwekRO?=
 =?utf-8?B?eG5RMXZDWU9RbjRxYjhacUFscmhVS3FVK3FQY1RvZW9ZQUIxcUltNGt4K2xC?=
 =?utf-8?B?VDZxeC9VTEdMeWhjSDJZS09mcEhJNEF2UFRYVWo3N1FhcVQxVzVFeDFKeHBS?=
 =?utf-8?B?cDFmMFRIOUpvTWhQR0ROT3lnZ2lacTZQYlVIOUFvdkhLR1dVRno0bUdaaHlC?=
 =?utf-8?B?NEtDM291dWN1a0ZRV0ErNktzc0xkdEx6QlFnaVpzMUxZazEvSW5ESkVjN05G?=
 =?utf-8?B?bWdEVTYveFdQNUt0MzQ5UFRpU1J5em95K3J2WitJZDAxQ2U3VW5vK2NsTWZ6?=
 =?utf-8?B?bkhxb2RoaTBjaE9STTRXTndxWHdKNE9pemx1MGRHUXJJRktIL01WQXorUmhR?=
 =?utf-8?B?dUxlS0YzYmg4WjFFL3hyUHJwWE50YTJraGE4NjVwYkVPUmtFaFdFbU9oTVph?=
 =?utf-8?B?U1pOUnFObThYdXB2LzVsVWd1c3gvNW8waXVyT3NiU0tXanl6WFJzMWFvVkZB?=
 =?utf-8?B?ZWNaOURuMzB1NGIrR0kwdkRjRXpTZkljR2xYbUs4MkRBV25qbEp3UVIwN1Qy?=
 =?utf-8?B?S3pUQ3lUU21ORmYrYzlGcUFybTdPVHMrOVorS3FCZWhmb2lJQVc4dWZXTTYz?=
 =?utf-8?B?M2ErWTJuYWVPTkNMNVYzYUp4cjdCQUpYelMxRVM1ZExFYVBLc3ZuQ2pjT3k1?=
 =?utf-8?B?NjF6UnArUUcyTFA3RDAwWVJna1IwU3JiLzlPWlFzS2dPcnN2VjBVanMvMEFT?=
 =?utf-8?B?S2dIWU5XajVTd20yQ2FMY0VjbmE3SGxuemRFYlhWY2ZLaUd3b1FpUHdpdGk4?=
 =?utf-8?B?ZEhZTnFLd2o0aWc0TmRURVRGQmYwZS9XQzErQ2MvWFBwekRUVndSWDIxYWpH?=
 =?utf-8?B?SW96K2JiTXhPOVhTVkplMW43VVRYczEvWHdtRXd6ZWtMalp0aktId1NvVDIy?=
 =?utf-8?B?YlA5UVEvcVFKeFc0cnJXL0JlVGN6UzFMdFNPRWhUSUVyUGdQWE4xc3NUbzRX?=
 =?utf-8?B?NVFLQ3VwNDZKazZVU3R3VC9NV1pEeDBiT3BZcTNYd1pKWTlMOWNGdEUyUXhS?=
 =?utf-8?B?d1U3OHlZV2d2a2ZQK3RXQkxwTXpqb1FqQ3ZBYVJpUDg4THZ6ZmJBWXV6dUJh?=
 =?utf-8?B?UlhSWkJDbWxnVkcrWWd4UTFoK0VPcHY0bDlyRFhWaHY4a3BSVHQyUDRqRzZy?=
 =?utf-8?B?YjIyVjRlaUNlelFkSHRDNUNOV01NaitPNlhKWHBieklvbXI1dUZMMGc5ZDVY?=
 =?utf-8?B?QTJJWkRzYVlQdmQxZEFYZ2hSR3Y2eEYzc3V5NlVDbHdqZUlodlE1TWg4SzR5?=
 =?utf-8?B?Vmw5UXpIdjJmSDhiODRDQjhMNjg4Mzh1L3NCbVdYYnFmb0tBYjFUVU1mRjJG?=
 =?utf-8?B?NmFmd2U0b0t3aThwNE1zK2d5SGlSWmF6SnF3blpXcTcxeXZOUHdkVW4wWkxG?=
 =?utf-8?B?ZmxrMVpJOWVJdkhvME15MmttSFBGQkpvdWlCYjlhR0U2MTloQjdrMWREazZL?=
 =?utf-8?B?OEFyUFJwbVBGWmRIb3NkT2xkMkRiN3RNbm5kVjNzN2d0MjNtQmUrSEE3T3NL?=
 =?utf-8?B?SGFGUVVBZ2taZ1dyeG5MMDhXSkNlU0U1MjVzckF6ditMeS9pejY0Q3RtbUI3?=
 =?utf-8?B?ZEExSjZ2TnlmMGs5QXNWN2FvR2Z5V2VqQk1jN0RmOHdmbEp3ejY2Q1JrR09L?=
 =?utf-8?B?L2ExR08wWmc4ZU10eVUrbVpjS2kzUjBnY3lGSkoxVkhnSUk2MDF3V2syMXE1?=
 =?utf-8?B?aVhxSElicEN1aU9pR1QyUGR3RmlOQUJ3MVA4QUEwSmxCdDhwTFZ0MHRNZWlZ?=
 =?utf-8?B?cjJWb0hVc2ZkV2tyckw3NnJZLzlEQ1I2MmZqQTdjM1hqaGZ3RGZRYkZRWHRp?=
 =?utf-8?B?Wk9ia0hCd0M5MEZnaUltRG1YeGRZclU3MkRLOEllLzBmTGVmaVplV3F1T2Vr?=
 =?utf-8?B?dHdadzlJcUp1K0hXUmVwOHk2bHV2bG9Oa2c4NHhyN2pIazVoK0cwNEtpM2Uv?=
 =?utf-8?B?UzFoZGhJeEI1cWwxR1pwMUlJRVh3WUYwWm1yL0w3ZUFsTWtJeUYvZVRZRHlX?=
 =?utf-8?Q?/V+tRI1Epdm6zMAQrxzlMUGVh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88039bd-cb90-4df3-11c3-08db6eb597b7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 22:04:01.7888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFTdgN+cr9LdIX/NX1x7csqCNPunKhU+4FsZderN4clYENa59EZpv1QAXiYR7JZlu6uDs+fhnVw7Hd2rwPqYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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


On 2023-06-16 14:44, Mukul Joshi wrote:
> Enable GWS capable queue creation for forward
> progress gaurantee on GFX 9.4.3.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Update the condition for setting pqn->q->gws
>    for GFX 9.4.3.
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 35 ++++++++++++-------
>   2 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9d4abfd8b55e..226d2dd7fa49 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -518,6 +518,7 @@ static int kfd_gws_init(struct kfd_node *node)
>   			&& kfd->mec2_fw_version >= 0x30)   ||
>   		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 2)
>   			&& kfd->mec2_fw_version >= 0x28) ||
> +		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
>   		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
>   			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
>   			&& kfd->mec2_fw_version >= 0x6b))))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9ad1a2186a24..ba9d69054119 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -123,16 +123,24 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	if (!gws && pdd->qpd.num_gws == 0)
>   		return -EINVAL;
>   
> -	if (gws)
> -		ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
> -			gws, &mem);
> -	else
> -		ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
> -			pqn->q->gws);
> -	if (unlikely(ret))
> -		return ret;
> +	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
> +		if (gws)
> +			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
> +				gws, &mem);
> +		else
> +			ret = amdgpu_amdkfd_remove_gws_from_process(pdd->process->kgd_process_info,
> +				pqn->q->gws);
> +		if (unlikely(ret))
> +			return ret;
> +		pqn->q->gws = mem;
> +	} else {
> +		/*
> +		 * Intentionally set GWS to a non-NULL value
> +		 * for GFX 9.4.3.
> +		 */
> +		pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;
> +	}
>   
> -	pqn->q->gws = mem;
>   	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
>   
>   	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> @@ -164,7 +172,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   	struct process_queue_node *pqn, *next;
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
> -		if (pqn->q && pqn->q->gws)
> +		if (pqn->q && pqn->q->gws &&
> +		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
>   			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
>   				pqn->q->gws);
>   		kfd_procfs_del_queue(pqn->q);
> @@ -446,8 +455,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		}
>   
>   		if (pqn->q->gws) {
> -			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
> -				pqn->q->gws);
> +			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
> +				amdgpu_amdkfd_remove_gws_from_process(
> +						pqm->process->kgd_process_info,
> +						pqn->q->gws);
>   			pdd->qpd.num_gws = 0;
>   		}
>   
