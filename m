Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12283C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 19:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18DF113631;
	Thu, 14 Jul 2022 19:10:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62C7113624
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 19:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5Uvaz1icljfUogb76JNucr1BElbVGW6tYlv6UM7ZWa36Z6u2cNzqe/YwnhlkPz8p4+1bg5geB6JBHXVL0usRR8CPqPzQw+fiY6R/gUlITSHZIW+qsLNXH3CnCQEzjuos0FwL9K9UJ1YHZRp0OwkTOfJ5MgRqM0Q7S5Rgi+C4boMWFSiPJyLkZu3JhGLK+3+FthPUSsQFNeMcuZFuZItNbDBG700IAcgjh811nKe6XT2ynZGcjRfVUHOB/inhcTra4C6A7g/37LyTwBVVVtwBTPiHOH1rYNya34uE2o/EptOkuFyE/b6+djSzSljcH9/bUh5krgkXqWhOcWEpe3u9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Krp9InF2DOnuvi6MfvK96yjG3/gKNXJIVA62cw4LE=;
 b=O1Pb4G8Q6pl87fc29SypQOnEyzCvTTV3YBC/VXQoIx1uSImS5u4apEFjuuMi8yH8K7O28YZw1iEyva4Fd/BAeKRbrz3dZgRZk5vt/F2Ry1iJtNeeBSshQBUh6AjrgPNCjbyZL9dtrCed5bD0wYVRc9NRxqd3j27IAIeSRgk7tzzKNWRyNjgEpY0GpouP0dJ+pH8aYsSbXSB2s1yn6w9We80VhFa7SHnOK+C4EwbD49AIY2LDs7VkQntxma40mf2ok2nXshpPTHbNGZ2oO+eMKmBjI//9+EreltQZaI6OLr6HBrCEnL+wdt8aprqAfwb18NgwtusuYR3F1FUNGEtapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47Krp9InF2DOnuvi6MfvK96yjG3/gKNXJIVA62cw4LE=;
 b=lNxj68u1bW0TPb7zdokut/HTB+Y2hRsJYozVTCgqMM4OtIgwqI162CwJV8kNPp/vpnqJbhefNvMS4vIA6WZ2l2PX3LkWviLbmMpFGHoi/Ywz6DvHlnEPuu9xaF5rhxviVu31jlXLVgVnL/nrG/GX5jt6aZlSK5ZE58Hem6CjBFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 19:10:30 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 19:10:29 +0000
Message-ID: <fb252275-53b8-c135-a726-390bac1121b6@amd.com>
Date: Thu, 14 Jul 2022 15:10:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] drm/amdgpu: add gang submit frontend v2
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com, timur.kristof@gmail.com,
 Yogesh.Mohanmarimuthu@amd.com
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-11-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220714103902.7084-11-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d94fd84-f6d8-4020-04e1-08da65cc8475
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eeERFDnBr2kVnYBduZ/k0x8jV9Fz8uf/Y9plNZbMncCky1u+Mcuh+9mZlzwyM6T1oM7d6WpPEc1hfAc1CBUihRL8tgTkyOFM9tVGyzo56TccmDTa8ObZM9Hrp7njvrdmFDchDUxzM9VQl7ocFVk2vYBwSBKa02MUGzZIU9sVH3g0BCm3tZx+nTvisNOS6jOu815xAdZeJwZCy3UmYGJSLSNl6yuEFV6CRd8znmtfK+x+rp2j+6hOn/5Qm34ab6eGhVtmr8IKTVTpz10kQD++wHFT0PFUyLal2aJnj6x5zJuIedkY0wPZT9sVnGKsm6dSKtnAAK8bXhzKmrgWDI6yNCJ3yL9nS1iNLa2KLRSgckAId7ktxnEItKyUVJZX+f8imFQDM5k8wfnAi0ndjlPzh7AuJSpUEMyHZ6NYWopMT4t6q1FBWbUnfjKvlXbrasG8ysYIdrJRG6QsEFeiQTTZ6vCal/5lKHC2pv34Ilrf4NrfeUSv9cLKauNcI8egIVYtq7Xyr4EDGUsC06qreSDJa3BOWYwnwb9QbwX6/Z69y//RZqLN+PjBQ6jAvB6WW235r2gNPkMObrn3FZGvPbCMTS43u+w3YT6PDagA3MgezT2AUmRUzxqUxFckkk1FTFttiFpL+xcID6XBO/XOGLxIxVf9jTA2iGqGfmGitgNNJG8IKMvyX4URvq6R5WvGx5RX2yq2HNYbFk3j/jTTCNKQYMnfrTgokhHj/fyM4cOJc42kVyuyftFLmGRfVPorbxdOHTrPmqv/KO8Vooadxj1GfQJ7i8segvCdulMe0vM3OnYYB9bFHCp2cawWG/9bNwC+HXs3GcrZJ4zSycH1ayBwX/TG9jX/mvT0EApRhuv4xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(4326008)(66946007)(2616005)(186003)(6636002)(66556008)(316002)(6512007)(66476007)(8676002)(86362001)(31696002)(6486002)(53546011)(6506007)(478600001)(41300700001)(2906002)(36756003)(38100700002)(31686004)(44832011)(30864003)(66574015)(8936002)(5660300002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3kyUUVaNml4MDhLeGdJR3Z4YVJ0M0FiZGFTazVaSVNqZDM5TzlOQ05PMGkw?=
 =?utf-8?B?K3FxYk1jc2Y1S1RtdnhJeCt4U3VjbXdOYVJUOHN1aFMyWkhiN01uTTYwRlR6?=
 =?utf-8?B?QkJ0ZG1wRFRSdmhsck5SblFUa2pXZTROSzNTWk0rM3ZBeVdsSUpqSVFkVnd4?=
 =?utf-8?B?ZTRoN2xoc2VpUzZac09DQ0k5aUhWeG1tREJ4b0hTM0tLWGp3MGxzQXhXY0tR?=
 =?utf-8?B?U3ZyNVZzKzdkTTBkdkxDNmpleEtLQSs0RG5QQXBhT1B6Y0JnVlZaL3kzU1E3?=
 =?utf-8?B?WmphdzZSTUN3TllTckl3K3kvMlcrQ0tXaXQvT3psa2JvQXh1OUJSWUdZY0Ix?=
 =?utf-8?B?UUZEc3U2M3B6UWFra0VVUG5SQTdWajc0R0RhaGVSMXV2anRtdTE2bGh0aWI0?=
 =?utf-8?B?U2dIMC9GeXY3ckRjZ3VBTzhqRjBIM3YyVVFxVWtQekF3YnNGQlVQS3hoNUJQ?=
 =?utf-8?B?S0dvZURWNzg5R1JBK3lTWlRkZ3diM09TSTQ0VU1YQkVPWVJZZ3F2SUNqUnc5?=
 =?utf-8?B?MjBBWUVRS3NKNWhlanBUbjhxcTYxVDlCQU1LTnNUWnpFa2t2MG8vWXFqdk5U?=
 =?utf-8?B?N0NXYWRTdUE5VGZDTWJjWGlNOTJieGZ0cGQyN1RwK3BwUWhDTlVqU09sYTZl?=
 =?utf-8?B?dEIrZjZiTmhlVU1zb2NaTFQ4NWpDbDhEL1VKcTB3ZDhZYWpqYURSRDg3L0hK?=
 =?utf-8?B?V3M0YS90Qlpjc2g3dkdDcFYrVmg2dlEvUXF4TVBNQ0l1aExUN0Mya1ZGeXZY?=
 =?utf-8?B?R3FQVG9yR0VINjZLNkowbkFFUERlZnJhNVc3aDBrTWdScnpvWmZ2dXkxU1k4?=
 =?utf-8?B?U01PdHlIN05TTExSTVhaSVVkMm9LMlRycGcvbExzbW9qTVA1QWpoYm43Rlpt?=
 =?utf-8?B?WExTSWRkcUlxSlJwblJMUTNwcnhCUi8zUzI3UnBVSEJXM1RBNXdxSEhZL1BI?=
 =?utf-8?B?NDVMUkN3Vk5xOW5EL0ZTbVZtUGlWNVRueWJ3RlZHSytuSEhNdW9aMU5hazVq?=
 =?utf-8?B?SnZHdlFEaHRZUW52WDl0Tm5Ga2JNcTFkL1RWcXY5NDRwMlNsNzRTRjAwSjNN?=
 =?utf-8?B?ZXBNdUc5TUM3UTJWN3pEQnVmcmVOZExreCtQT01aQ3hPZmlRRVhGZk5BUXJD?=
 =?utf-8?B?d0ZnTEhTSTNoY3RCbWxBMkd5Q0hMQ1p4Ym5WaitzUnh0MVN6NG9rQVAyeVFY?=
 =?utf-8?B?cVdlM0t1bng0WERMZnRiTEtiL20rWTZEN3IrWDZxdTVINnlkYm9PQ2ZoTXhI?=
 =?utf-8?B?Qy91dUJRajRTRHZialVXSERmZjlZWU9WS1ZjTFZUMUdmK3RUTklZTjBuUGpk?=
 =?utf-8?B?b2lTdC9zY1lVYmVKRmxlVnZGNFVLZmdXMFN6cmwzZWpmVTk0aWxNeTB1MS9a?=
 =?utf-8?B?VVNqVXlWRDcxdWJ4ZFRsTWRncHMzTkhyL1I2TDE4NWxXUnFmTnFYUzZkdFpl?=
 =?utf-8?B?RUJwZ0d1VGdaNDlKY2l3UWFiOGZBdk1Qd1VEcUVGdWZoOEs1RDRFZ0tyYnlr?=
 =?utf-8?B?Kyt1M2t0RkpTdkY1TCttK0tpeEtIUkxxNGNqc1k2OTIyY1ZrRXJHWWVvZ2Jn?=
 =?utf-8?B?dW9LUU5JUHdCYnplT0E4ZXRpZmFKUUhmS2QvNEVWVXpoSmFKZFUrTmlrY1Iz?=
 =?utf-8?B?Zno1SW8xaEpvZU9CQUdKS3Awb1UwdGhxaGlPM0syUlhsdUlMc0F4aE9Wd1lW?=
 =?utf-8?B?cjR1NnhiekNJZnV6SnJwNk1OcEI2b3pjRWFFNVgzejZMV0d1SFBYbC9Wczg1?=
 =?utf-8?B?RWwraXNUNjJHYytSQndheXR4UkhNNVlpUThQUEpVbXlwa2NEck5JNWt2eEU1?=
 =?utf-8?B?V1FjcjJrMUdjSDFReWVrd1g4Mzd6RVVqVjRrOVhubGY4b2crdVVNSGI1S2Zu?=
 =?utf-8?B?NFdQdnhDTkkvelhZeDdqT2Q1a3JPQU9LVXpLVnJTMTcwNStyVTlrbzBQYnpT?=
 =?utf-8?B?UWVNQzRpOGpWejU3TlRjZ0pOamtKRWdrNDd3bU16TExSOWhlVFkxaGZYUGpM?=
 =?utf-8?B?OTVTL1A4YTd6K24xQnJNZzBFWEJmejNYMmNWYldLVmFJRUNCeHdOVFZkNmt2?=
 =?utf-8?B?bGJTSURhMkI3Nk9yU1hnVHBadTlTUXZsT3lZOENqbCtEY1ZHcFVSVEJ5bGdJ?=
 =?utf-8?B?Snh5Zno4NVhMcmYxMXE4MFpiUmJPeGE5K2h3OUxGdU1TWk1sMU1MdUlkVlAv?=
 =?utf-8?Q?5/6LRYaowydu6Zns1jj04SnU5D23yCbQCxrQltnLndiW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d94fd84-f6d8-4020-04e1-08da65cc8475
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 19:10:29.8997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voU7tBVuIxueaInBD3h3brw7l+I44z0fSPnXXTjx9dMN0Q71JpRmgfyuizi6LItTvTqyC+NiAF6VVQNoNjO9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-07-14 06:39, Christian König wrote:
> Allows submitting jobs as gang which needs to run on multiple engines at the
> same time.
>
> All members of the gang get the same implicit, explicit and VM dependencies. So
> no gang member will start running until everything else is ready.
>
> The last job is considered the gang leader (usually a submission to the GFX
> ring) and used for signaling output dependencies.
>
> Each job is remembered individually as user of a buffer object, so there is no
> joining of work at the end.
>
> v2: rebase and fix review comments from Andrey and Yogesh
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 256 ++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h    |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  12 +-
>   3 files changed, 183 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 88f491dc7ca2..e1c41db20efb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -69,6 +69,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   			   unsigned int *num_ibs)
>   {
>   	struct drm_sched_entity *entity;
> +	unsigned int i;
>   	int r;
>   
>   	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
> @@ -77,17 +78,28 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   	if (r)
>   		return r;
>   
> -	/* Abort if there is no run queue associated with this entity.
> -	 * Possibly because of disabled HW IP*/
> +	/*
> +	 * Abort if there is no run queue associated with this entity.
> +	 * Possibly because of disabled HW IP.
> +	 */
>   	if (entity->rq == NULL)
>   		return -EINVAL;
>   
> -	/* Currently we don't support submitting to multiple entities */
> -	if (p->entity && p->entity != entity)
> +	/* Check if we can add this IB to some existing job */
> +	for (i = 0; i < p->gang_size; ++i) {
> +		if (p->entities[i] == entity)
> +			goto found;
> +	}
> +
> +	/* If not increase the gang size if possible */
> +	if (i == AMDGPU_CS_GANG_SIZE)
>   		return -EINVAL;
>   
> -	p->entity = entity;
> -	++(*num_ibs);
> +	p->entities[i] = entity;
> +	p->gang_size = i + 1;
> +
> +found:
> +	++(num_ibs[i]);
>   	return 0;
>   }
>   
> @@ -161,11 +173,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   			   union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] = { };
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	uint64_t *chunk_array_user;
>   	uint64_t *chunk_array;
> -	unsigned size, num_ibs = 0;
>   	uint32_t uf_offset = 0;
> +	unsigned int size;
>   	int ret;
>   	int i;
>   
> @@ -231,7 +244,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   			if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
>   				goto free_partial_kdata;
>   
> -			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
> +			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, num_ibs);
>   			if (ret)
>   				goto free_partial_kdata;
>   			break;
> @@ -268,21 +281,28 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   		}
>   	}
>   
> -	ret = amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm);
> -	if (ret)
> -		goto free_all_kdata;
> +	if (!p->gang_size)
> +		return -EINVAL;
>   
> -	ret = drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
> -	if (ret)
> -		goto free_all_kdata;
> +	for (i = 0; i < p->gang_size; ++i) {
> +		ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
> +		if (ret)
> +			goto free_all_kdata;
> +
> +		ret = drm_sched_job_init(&p->jobs[i]->base, p->entities[i],
> +					 &fpriv->vm);
> +		if (ret)
> +			goto free_all_kdata;
> +	}
> +	p->gang_leader = p->jobs[p->gang_size - 1];
>   
> -	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
> +	if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
>   		ret = -ECANCELED;
>   		goto free_all_kdata;
>   	}
>   
>   	if (p->uf_entry.tv.bo)
> -		p->job->uf_addr = uf_offset;
> +		p->gang_leader->uf_addr = uf_offset;
>   	kvfree(chunk_array);
>   
>   	/* Use this opportunity to fill in task info for the vm */
> @@ -304,22 +324,18 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   	return ret;
>   }
>   
> -static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
> -			   struct amdgpu_cs_chunk *chunk,
> -			   unsigned int *num_ibs,
> -			   unsigned int *ce_preempt,
> -			   unsigned int *de_preempt)
> +static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> +			   struct amdgpu_ib *ib, struct amdgpu_cs_chunk *chunk,
> +			   unsigned int *ce_preempt, unsigned int *de_preempt)
>   {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(p->job->base.sched);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	int r;
>   
> -
>   	/* MM engine doesn't support user fences */
> -	if (p->job->uf_addr && ring->funcs->no_user_fence)
> +	if (job->uf_addr && ring->funcs->no_user_fence)
>   		return -EINVAL;
>   
>   	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
> @@ -336,7 +352,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   	}
>   
>   	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
> -		p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
> +		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
>   
>   	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
>   			   chunk_ib->ib_bytes : 0,
> @@ -349,8 +365,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   	ib->gpu_addr = chunk_ib->va_start;
>   	ib->length_dw = chunk_ib->ib_bytes / 4;
>   	ib->flags = chunk_ib->flags;
> -
> -	(*num_ibs)++;
>   	return 0;
>   }
>   
> @@ -399,7 +413,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
>   			dma_fence_put(old);
>   		}
>   
> -		r = amdgpu_sync_fence(&p->job->sync, fence);
> +		r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
>   		dma_fence_put(fence);
>   		if (r)
>   			return r;
> @@ -421,7 +435,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>   		return r;
>   	}
>   
> -	r = amdgpu_sync_fence(&p->job->sync, fence);
> +	r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
>   	dma_fence_put(fence);
>   
>   	return r;
> @@ -544,20 +558,30 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   
>   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   {
> -	unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
> +	unsigned int ce_preempt = 0, de_preempt = 0;
> +	unsigned int job_idx = 0, ib_idx = 0;
>   	int i, r;
>   
>   	for (i = 0; i < p->nchunks; ++i) {
>   		struct amdgpu_cs_chunk *chunk;
> +		struct amdgpu_job *job;
>   
>   		chunk = &p->chunks[i];
>   
>   		switch (chunk->chunk_id) {
>   		case AMDGPU_CHUNK_ID_IB:
> -			r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
> +			job = p->jobs[job_idx];
> +			r = amdgpu_cs_p2_ib(p, job, &job->ibs[ib_idx], chunk,
>   					    &ce_preempt, &de_preempt);
>   			if (r)
>   				return r;
> +
> +			if (++ib_idx == job->num_ibs) {
> +				++job_idx;
> +				ib_idx = 0;
> +				ce_preempt = 0;
> +				de_preempt = 0;
> +			}
>   			break;
>   		case AMDGPU_CHUNK_ID_DEPENDENCIES:
>   		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
> @@ -828,6 +852,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_list_entry *e;
>   	struct list_head duplicates;
> +	unsigned int i;
>   	int r;
>   
>   	INIT_LIST_HEAD(&p->validated);
> @@ -911,16 +936,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		e->bo_va = amdgpu_vm_bo_find(vm, bo);
>   	}
>   
> -	/* Move fence waiting after getting reservation lock of
> -	 * PD root. Then there is no need on a ctx mutex lock.
> -	 */
> -	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> -	if (unlikely(r != 0)) {
> -		if (r != -ERESTARTSYS)
> -			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -		goto error_validate;
> -	}
> -
>   	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
>   					  &p->bytes_moved_vis_threshold);
>   	p->bytes_moved = 0;
> @@ -944,8 +959,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>   				     p->bytes_moved_vis);
>   
> -	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
> -				 p->bo_list->gws_obj, p->bo_list->oa_obj);
> +	for (i = 0; i < p->gang_size; ++i)
> +		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> +					 p->bo_list->gws_obj,
> +					 p->bo_list->oa_obj);
>   
>   	if (p->uf_entry.tv.bo) {
>   		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
> @@ -954,7 +971,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		if (r)
>   			goto error_validate;
>   
> -		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
> +		p->gang_leader->uf_addr += amdgpu_bo_gpu_offset(uf);
>   	}
>   	return 0;
>   
> @@ -975,20 +992,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	return r;
>   }
>   
> -static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
> +static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
>   {
> -	int i;
> +	int i, j;
>   
>   	if (!trace_amdgpu_cs_enabled())
>   		return;
>   
> -	for (i = 0; i < parser->job->num_ibs; i++)
> -		trace_amdgpu_cs(parser, i);
> +	for (i = 0; i < p->gang_size; ++i) {
> +		struct amdgpu_job *job = p->jobs[i];
> +
> +		for (j = 0; j < job->num_ibs; ++j)
> +			trace_amdgpu_cs(p, job, &job->ibs[j]);
> +	}
>   }
>   
> -static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
> +static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
> +			       struct amdgpu_job *job)
>   {
> -	struct amdgpu_job *job = p->job;
>   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	unsigned int i;
>   	int r;
> @@ -1029,12 +1050,12 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
>   			memcpy(ib->ptr, kptr, ib->length_dw * 4);
>   			amdgpu_bo_kunmap(aobj);
>   
> -			r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
> +			r = amdgpu_ring_parse_cs(ring, p, job, ib);
>   			if (r)
>   				return r;
>   		} else {
>   			ib->ptr = (uint32_t *)kptr;
> -			r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
> +			r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
>   			amdgpu_bo_kunmap(aobj);
>   			if (r)
>   				return r;
> @@ -1044,14 +1065,29 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
>   	return 0;
>   }
>   
> +static int amdgpu_cs_patch_jobs(struct amdgpu_cs_parser *p)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	for (i = 0; i < p->gang_size; ++i) {
> +		r = amdgpu_cs_patch_ibs(p, p->jobs[i]);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +}
> +
>   static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	struct amdgpu_job *job = p->gang_leader;
>   	struct amdgpu_device *adev = p->adev;
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_list_entry *e;
>   	struct amdgpu_bo_va *bo_va;
>   	struct amdgpu_bo *bo;
> +	unsigned int i;
>   	int r;
>   
>   	r = amdgpu_vm_clear_freed(adev, vm, NULL);
> @@ -1062,7 +1098,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
> +	r = amdgpu_sync_fence(&job->sync, fpriv->prt_va->last_pt_update);
>   	if (r)
>   		return r;
>   
> @@ -1072,7 +1108,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   		if (r)
>   			return r;
>   
> -		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
> +		r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
>   		if (r)
>   			return r;
>   	}
> @@ -1091,7 +1127,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   		if (r)
>   			return r;
>   
> -		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
> +		r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
>   		if (r)
>   			return r;
>   	}
> @@ -1104,11 +1140,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_sync_fence(&p->job->sync, vm->last_update);
> +	r = amdgpu_sync_fence(&job->sync, vm->last_update);
>   	if (r)
>   		return r;
>   
> -	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	for (i = 0; i < p->gang_size; ++i) {
> +		job = p->jobs[i];
> +
> +		if (!job->vm)
> +			continue;
> +
> +		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	}
>   
>   	if (amdgpu_vm_debug) {
>   		/* Invalidate all BOs to test for userspace bugs */
> @@ -1129,7 +1172,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	struct amdgpu_job *leader = p->gang_leader;
>   	struct amdgpu_bo_list_entry *e;
> +	unsigned int i;
>   	int r;
>   
>   	list_for_each_entry(e, &p->validated, tv.head) {
> @@ -1139,12 +1184,23 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   
>   		sync_mode = amdgpu_bo_explicit_sync(bo) ?
>   			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> -		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
> +		r = amdgpu_sync_resv(p->adev, &leader->sync, resv, sync_mode,
>   				     &fpriv->vm);
>   		if (r)
>   			return r;
>   	}
> -	return 0;
> +
> +	for (i = 0; i < p->gang_size - 1; ++i) {
> +		r = amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
> +		if (r)
> +			return r;
> +	}
> +
> +	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
> +	if (r && r != -ERESTARTSYS)
> +		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +
> +	return r;
>   }
>   
>   static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
> @@ -1168,16 +1224,26 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   			    union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	struct drm_sched_entity *entity = p->entity;
> +	struct amdgpu_job *leader = p->gang_leader;
>   	struct amdgpu_bo_list_entry *e;
> -	struct amdgpu_job *job;
> +	unsigned int i;
>   	uint64_t seq;
>   	int r;
>   
> -	job = p->job;
> -	p->job = NULL;
> +	for (i = 0; i < p->gang_size; ++i)
> +		drm_sched_job_arm(&p->jobs[i]->base);
>   
> -	drm_sched_job_arm(&job->base);
> +	for (i = 0; i < (p->gang_size - 1); ++i) {
> +		struct dma_fence *fence;
> +
> +		fence = &p->jobs[i]->base.s_fence->scheduled;
> +		r = amdgpu_sync_fence(&leader->sync, fence);
> +		if (r)
> +			goto error_cleanup;
> +	}
> +
> +	for (i = 0; i < p->gang_size; ++i)
> +		amdgpu_job_set_gang_leader(p->jobs[i], leader);
>   
>   	/* No memory allocation is allowed while holding the notifier lock.
>   	 * The lock is held until amdgpu_cs_submit is finished and fence is
> @@ -1195,45 +1261,60 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	}
>   	if (r) {
>   		r = -EAGAIN;
> -		goto error_abort;
> +		goto error_unlock;
>   	}
>   
> -	p->fence = dma_fence_get(&job->base.s_fence->finished);
> +	p->fence = dma_fence_get(&leader->base.s_fence->finished);
>   
> -	seq = amdgpu_ctx_add_fence(p->ctx, entity, p->fence);
> +	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1],
> +				   p->fence);
>   	amdgpu_cs_post_dependencies(p);
>   
> -	if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
> +	if ((leader->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
>   	    !p->ctx->preamble_presented) {
> -		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
> +		leader->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
>   		p->ctx->preamble_presented = true;
>   	}
>   
>   	cs->out.handle = seq;
> -	job->uf_sequence = seq;
> -
> -	amdgpu_job_free_resources(job);
> +	leader->uf_sequence = seq;
>   
> -	trace_amdgpu_cs_ioctl(job);
>   	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
> -	drm_sched_entity_push_job(&job->base);
> +	for (i = 0; i < p->gang_size; ++i) {
> +		amdgpu_job_free_resources(p->jobs[i]);
> +		trace_amdgpu_cs_ioctl(p->jobs[i]);
> +		drm_sched_entity_push_job(&p->jobs[i]->base);
> +	}
>   
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
> -	/* Make sure all BOs are remembered as writers */
> -	amdgpu_bo_list_for_each_entry(e, p->bo_list)
> -		e->tv.num_shared = 0;
> +	list_for_each_entry(e, &p->validated, tv.head) {
> +
> +		/* Everybody except for the gang leader uses BOOKKEEP */
> +		for (i = 0; i < (p->gang_size - 1); ++i) {
> +			dma_resv_add_fence(e->tv.bo->base.resv,
> +					   &p->jobs[i]->base.s_fence->finished,
> +					   DMA_RESV_USAGE_BOOKKEEP);
> +		}
>   
> +		/* The gang leader as remembered as writer */
> +		e->tv.num_shared = 0;
> +	}
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> +
> +	for (i = 0; i < p->gang_size; ++i)
> +		p->jobs[i] = NULL;
> +
>   	mutex_unlock(&p->adev->notifier_lock);
>   	mutex_unlock(&p->bo_list->bo_list_mutex);
> -
>   	return 0;
>   
> -error_abort:
> -	drm_sched_job_cleanup(&job->base);
> +error_unlock:
>   	mutex_unlock(&p->adev->notifier_lock);
> -	amdgpu_job_free(job);
> +
> +error_cleanup:
> +	for (i = 0; i < p->gang_size; ++i)
> +		drm_sched_job_cleanup(&p->jobs[i]->base);
>   	return r;
>   }
>   
> @@ -1250,17 +1331,18 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>   
>   	dma_fence_put(parser->fence);
>   
> -	if (parser->ctx) {
> +	if (parser->ctx)
>   		amdgpu_ctx_put(parser->ctx);
> -	}
>   	if (parser->bo_list)
>   		amdgpu_bo_list_put(parser->bo_list);
>   
>   	for (i = 0; i < parser->nchunks; i++)
>   		kvfree(parser->chunks[i].kdata);
>   	kvfree(parser->chunks);
> -	if (parser->job)
> -		amdgpu_job_free(parser->job);
> +	for (i = 0; i < parser->gang_size; ++i) {
> +		if (parser->jobs[i])
> +			amdgpu_job_free(parser->jobs[i]);
> +	}
>   	if (parser->uf_entry.tv.bo) {
>   		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
>   
> @@ -1304,7 +1386,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		goto error_fini;
>   	}
>   
> -	r = amdgpu_cs_patch_ibs(&parser);
> +	r = amdgpu_cs_patch_jobs(&parser);
>   	if (r)
>   		goto error_backoff;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> index 652b5593499f..cbaa19b2b8a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -27,6 +27,8 @@
>   #include "amdgpu_bo_list.h"
>   #include "amdgpu_ring.h"
>   
> +#define AMDGPU_CS_GANG_SIZE	4
> +
>   struct amdgpu_bo_va_mapping;
>   
>   struct amdgpu_cs_chunk {
> @@ -50,9 +52,11 @@ struct amdgpu_cs_parser {
>   	unsigned		nchunks;
>   	struct amdgpu_cs_chunk	*chunks;
>   
> -	/* scheduler job object */
> -	struct drm_sched_entity	*entity;
> -	struct amdgpu_job	*job;
> +	/* scheduler job objects */
> +	unsigned int		gang_size;
> +	struct drm_sched_entity	*entities[AMDGPU_CS_GANG_SIZE];
> +	struct amdgpu_job	*jobs[AMDGPU_CS_GANG_SIZE];
> +	struct amdgpu_job	*gang_leader;
>   
>   	/* buffer objects */
>   	struct ww_acquire_ctx		ticket;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 06dfcf297a8d..5e6ddc7e101c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -140,8 +140,10 @@ TRACE_EVENT(amdgpu_bo_create,
>   );
>   
>   TRACE_EVENT(amdgpu_cs,
> -	    TP_PROTO(struct amdgpu_cs_parser *p, int i),
> -	    TP_ARGS(p, i),
> +	    TP_PROTO(struct amdgpu_cs_parser *p,
> +		     struct amdgpu_job *job,
> +		     struct amdgpu_ib *ib),
> +	    TP_ARGS(p, job, ib),
>   	    TP_STRUCT__entry(
>   			     __field(struct amdgpu_bo_list *, bo_list)
>   			     __field(u32, ring)
> @@ -151,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
>   
>   	    TP_fast_assign(
>   			   __entry->bo_list = p->bo_list;
> -			   __entry->ring = to_amdgpu_ring(p->entity->rq->sched)->idx;
> -			   __entry->dw = p->job->ibs[i].length_dw;
> +			   __entry->ring = to_amdgpu_ring(job->base.sched)->idx;
> +			   __entry->dw = ib->length_dw;
>   			   __entry->fences = amdgpu_fence_count_emitted(
> -				to_amdgpu_ring(p->entity->rq->sched));
> +				to_amdgpu_ring(job->base.sched));
>   			   ),
>   	    TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
>   		      __entry->bo_list, __entry->ring, __entry->dw,
