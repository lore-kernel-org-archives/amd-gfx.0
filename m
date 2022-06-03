Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0E7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 12:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA3511226A;
	Fri,  3 Jun 2022 12:08:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F3E113640
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 12:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyPSNzYkyMVeE80PbownSyv3B6nXVJP4ps+1C5+49mfv2r0cNt18IIgB5HZlTCqXm6IgafJjg2DfPwOhSlELX5PZ7Lb5SMiGU3hvQ8D5eYK7sc5x7GN54DhBtTY8TcV1SPSLj/HwrJ/MHeOJu27CGNbOAD+ufpdLwxFTXRhir2j/c4lcjfcScihcyUxqBvdw9aa4mUs95ClhsGMUWEomWffRpNOsAJB/4L9184DraIqvaiwaVwyXCBxC3g3U7WWvwssNSjIjia/GEC/Pd70GlaRhDy6aQuU20ntc07P9zbrqhPONJ49rrM/A8vVeD3g7OUAAPt5nPkeOCpjQ8TjT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPlUJmSMFm1IzA9fAsnqfs7FNcG7LC0Yg1dYeqLxV5I=;
 b=EO6k8LVCeq6IGgP3stYolBTrdeli6LFNcY1hWlMHRW2gQJG+eBjbonx/WOpmZ4B+Ap4DMY+W0rOfEpjghOoYLigK7O0QbL+37Z8L27xHBiTNvMe+jmZgtMUSiPpiREfs+0J8nnlVf0Zc6SSZAG8f1n9Eh3HxNHA5G+TC6m4KU3ORfVFTGLCSmGex8jTxkPZT51ZWvhQXILapS3t5bVNdXnSmIi9FJ2fVvq+tb215tA3f4vXvI3LL3LMTDmHrPDEFf7J6A/l0uM5az5qHUeuE1r5mC2SBqOJ7NXL7rZtZyL46KVGksPc0zFAJbWCK18aiXt2d/ndVym2mGs+eVl6noA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPlUJmSMFm1IzA9fAsnqfs7FNcG7LC0Yg1dYeqLxV5I=;
 b=XuhBJCYEVsjCXp4aOmgW/Kbk1eS3paNyCbZr1UFE3us8CnNLTfKzrCJ+tpVMUS4WJoH39l/cWLtab8vGpQMsG9vK7++6lih2S62JMzLAClr0bhP7qkLfTAJ+gPnG+QLxfJeQZqqxO1P5nLL6pomEk8OvpxOG+rjgfjXjcudTSxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) by
 MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 12:08:08 +0000
Received: from DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::5cb8:16ce:7d18:5705]) by DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::5cb8:16ce:7d18:5705%7]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 12:08:08 +0000
Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Pierre-eric.Pelloux-prayer@amd.com, amd-gfx@lists.freedesktop.org
References: <20220603102106.149508-1-christian.koenig@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
Date: Fri, 3 Jun 2022 14:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220603102106.149508-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0162.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::22) To DM8PR12MB5431.namprd12.prod.outlook.com
 (2603:10b6:8:34::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37939ebf-6192-4db3-2bea-08da4559b90a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3981:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB39815830879396E01E40A7828DA19@MN2PR12MB3981.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wuqSbDVOB8xnC8VflzERytv5m+VM0fKTN91z+p4OOBnjEVAAuW86yykMGIkgr27vOQdOiLAwm1q64dSc7QsW4ZvnhGxxgMivDfTzUJ0gbjeuTQn3lJeeEnXVw5cC/2ArDlGQbiTYcaWTNSGuHvbE7lQQvmyQN9DBkPGdJUKj1Ci5lhuGpzuL5fW+YtwjF553PZD37/ynf8RzlCi0eY3gpbK69GFOJeqToDZQPIkuGjPrX1IAq6a9RllqGKC/+htyDYU9Anz2Ld6ShbBwR8Qz3V8ZNlwcZ23E1LKWdL157AJrifDIr+WKuLgM+4mDI80gZImxvfa/HZH30N53FCgK+TiFGfdZrMtqPXB36AAbu+AMT9ve5yu2lN7t6qhU09QRDXRIgXLqMHpOH3l3XqvZMoMQmvmm7cvB+lFiOj4RGAzGnyyCDOic6ONQo0BnntgwDIkRkG/pjAGq5al0i9IxmP3YXjrXt8PC9Hnwn4hCvLTg8c4jqw+vIwDOZC+bT9CKFVUwDUV7gkx5cma1WRqLFZg1ZDzMoF334NoKPAntn3/Euetqtm4k+HCyiJ0Jj2DRCrXYLJsxOQXWc3nY/tZg9IoECDCsSG4Pga2GedAumkHI3vU14rCenKWhfkHwMB4Efe37avbQwqH75njrztP4S6+Ac/AHPKFGfYAJca0cLZA00g3E5MJdoPvEM70x/7Y7cqLriqVt3pLvW4Qm9eXzRQc6JrUMGt6kt/nJsW41+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(316002)(26005)(2906002)(508600001)(83380400001)(5660300002)(38100700002)(966005)(6486002)(8936002)(186003)(66574015)(2616005)(36756003)(86362001)(8676002)(53546011)(6666004)(31696002)(31686004)(66556008)(66946007)(66476007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUllT04vTWgwc3g0NkZHb1QwaVd0N0phRG9JQkowcEhDazJqQ0RoUEd6NzFr?=
 =?utf-8?B?bytxcE55aHlmbGFEUkkrQlNsaW0xdVBuanVEaU1JdkJvNzR0UjgySlJkb3h6?=
 =?utf-8?B?c3JRandpRWYwRlNZV0FHdnRaTlh4L3d4NVV5c3l5cWVFc2RkMjJ4N2lHbWV1?=
 =?utf-8?B?blhZT3dzMDRxZjc3MWhxQ3Vhc29xMm5rQjFlc3FiOGJodG9kdlJZZzBoWm9i?=
 =?utf-8?B?ZXcxM3FNUDFpRkNNZEx1OWVRazM2NnR4VWRqeEl3VG9aVVd6TlRxRFhHQjkz?=
 =?utf-8?B?UFd6dXVFZjhSZWIrSGtRd0EzZk11dThKZ25kaWRHQ055M2YxYUhSd2oxQm4r?=
 =?utf-8?B?dGlJK1A2YTdIbDJtdXBXd3RrZTJ5SVJ4R0RzbElRQTB6c3FaNlZYRkNwUHB3?=
 =?utf-8?B?OG5WOHFjWVFWWlBnbUtLQWlQM1A5eGFrMUhCUkNsaWFhT204L3hMR0crNFlH?=
 =?utf-8?B?RFJwb1d6UytKMFRCOGlWUjB5b2Q2dDAzWm93ajhZelAzWUM2c2hHRXNlUWQx?=
 =?utf-8?B?emVvNXpWQklXc2NIOTA3bkU2ZTRGRDAvYllDbFhuN3VGeVZHaVRWMVJsUFZy?=
 =?utf-8?B?azVUS3BsSzNHR0RTUHI3QXpjK3dRMEVTSUtwVjhRRXNEZXd0bWNSMUlZOUFF?=
 =?utf-8?B?S0VBYk5IUlBJRHNYQktodktaOWZlUnhSNU14YVVCL0FCQWhzWmRlU2JwMGRD?=
 =?utf-8?B?aHorT1ozWmhVRDBlSkkrNkxTbnZhUU93NG9jK2Z4T3RnZ2RVVU9aQUdQR3BQ?=
 =?utf-8?B?M0JLbGJTK3FtTENlWDM3bmxrU1NMU3J1bHJzZ2xBV1lISkZ6QzRIalBYSFZU?=
 =?utf-8?B?dVByNkpiSUpadkw0VDRFbGwyKzRGbE11RDdnV0FpWnc2UTdSRDRRc0VoeTAw?=
 =?utf-8?B?MTRpQTAvTlFxdXM1amNqdkFHcmpBTmZ6YmhkZ205bDFLOHRSV213enVaQmll?=
 =?utf-8?B?dURTdFhhRXNuQkFmaGY4dHJVYlk1ZmM4WUNjcUlNTkU3djN4SC96ZnB2R2l2?=
 =?utf-8?B?UXVnV0V1MEpscHAyVTZlRURIODArYzBuWlhNOVY0b2lZU3p2WE5heks3dGxW?=
 =?utf-8?B?b1NpK3pVcHdrbWQ2Z3NwdGQ2a1IxcUtENGZnWVZOWWg4YndpY2E1LzVLbzFj?=
 =?utf-8?B?Qlh0dFE4ajZqQUJodmZsdkludnA4M1R0QXIzaHJnRno4YkNkRkErSm55c3FB?=
 =?utf-8?B?RkVJSlZhRzNSZGFRcUZEVXB5RU9sMnMxUDlPcTZVMjBVVkdja0JEZ29tbWRL?=
 =?utf-8?B?WEM1Ty91VXpaRFNVb2pqL0hHYmVsRmgwNE0zMFZGU0U0VjU4d1hLcWZDREc5?=
 =?utf-8?B?QVR3Qm4vNG1DL3FKaXRHUnY4TmhkbDg1L0pRaFJ1K2N5cXJtWUtJQXZCeEM1?=
 =?utf-8?B?WGxhY1ZhVWtYRVYxVUdCeHFaZnliRmxXN1F3VDNMWFN1elp0RVhZWFprUGZa?=
 =?utf-8?B?MkwxamdqejBYN0JiSlIyZWRTc0JmVUZBVlZUcFJyYmFEWFJXaVQ5RENtUzhw?=
 =?utf-8?B?Nm5RZUI4ZCt5Q2kzcExmaGQ5YkpsbXg2MGlnNFNtdFFEYWJyWWxFSms2czRQ?=
 =?utf-8?B?bU9pVDNaSFBSQnc4STVEczhHSm9ncDNMZEhqRU40NytveW9naXNrNmpWRXRh?=
 =?utf-8?B?QnZGVzFOVVRHcUtyRlNsV2lEaWhJZXVoNmJWamtTdm1rZU5IV3lBNjFmUDZl?=
 =?utf-8?B?WGFramloaTByVWJMbFRzaGpOZDFLRmRkOXVUT2srbENYdmx6aW1rekNmWTNH?=
 =?utf-8?B?bjBRQ1duSVZ3WStxVHFZOWJDenJpb0duNkNuQ21USy9UTk5LbHg1NTU4STJq?=
 =?utf-8?B?VzRjWGlZQ1orN3d1OFZpamhCb2R4Mmt6c3N0VVJZNk55TE9jN2g1ZEdPTU9p?=
 =?utf-8?B?dEU5UHQ5YXY5dUtWczR4dXBBZFhUVWFicy9DUVFNaVR1dUFPd1NsRy94Mi92?=
 =?utf-8?B?dnpoRFdsTFZUbWpJdzB4andGTjhPbDNRQkRUbGN2YjN1b2s5amI5RkUxYUNp?=
 =?utf-8?B?OUZRb1pWT0o5SUJ4Ni8yQVRHdHlXNDhBZnUreEFzU04yWjR6RGVMd2tRazNu?=
 =?utf-8?B?Ukl3ZUdTUDRBb1kzb01zVjY3NDE0cVRGU2J1TVdmdmowd05CSGw2K0pXaHhw?=
 =?utf-8?B?YWpWckdjMU9wZTA4Sk9vNTdnOEtpMDhqNlRPV0ZZc0tabmVTZXgxNkR4c3FI?=
 =?utf-8?B?SE1QQndYckQ2SVNTVDdpTFc4WnhWM2k1Q3JseDJzS3VsclFjL3B3VHF2ZFZU?=
 =?utf-8?B?NlpBZGs2cEp6K1pjempMZjhta3g0SGk3Z05QdDBKNEc3TXRGYVRidHZQeVU2?=
 =?utf-8?B?MU5HU2ZCc3FoeTNDQ3l0WjArN1lpRmVJWjF3NjFIMDZSZkFjTGU5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37939ebf-6192-4db3-2bea-08da4559b90a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 12:08:08.6610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oo3CSPMeXM7wgQW1IkEAArM4hU+tehlv9r02tOsiTDTBZCTS4zpzhCuWTWa/leVfX8b06My9y5Q6vQVAsf/r4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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

Hi Christian,

The patch is: Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Could you add a reference to https://gitlab.freedesktop.org/drm/amd/-/issues/2037 in the commit message?

Thanks,
Pierre-Eric

On 03/06/2022 12:21, Christian König wrote:
> The job is not yet initialized here.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures directly in CS parsers")
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 3cabceee5f57..39405f0db824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  };
>  
> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> -				struct amdgpu_job *job)
> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
>  {
>  	struct drm_gpu_scheduler **scheds;
>  
>  	/* The create msg must be in the first IB submitted */
> -	if (atomic_read(&job->base.entity->fence_seq))
> +	if (atomic_read(&p->entity->fence_seq))
>  		return -EINVAL;
>  
>  	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
>  		[AMDGPU_RING_PRIO_DEFAULT].sched;
> -	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> +	drm_sched_entity_modify_sched(p->entity, scheds, 1);
>  	return 0;
>  }
>  
> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> -			    uint64_t addr)
> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
>  {
>  	struct ttm_operation_ctx ctx = { false, false };
>  	struct amdgpu_bo_va_mapping *map;
> @@ -1848,7 +1846,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
>  			continue;
>  
> -		r = vcn_v3_0_limit_sched(p, job);
> +		r = vcn_v3_0_limit_sched(p);
>  		if (r)
>  			goto out;
>  	}
> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  					   struct amdgpu_job *job,
>  					   struct amdgpu_ib *ib)
>  {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
>  	uint32_t msg_lo = 0, msg_hi = 0;
>  	unsigned i;
>  	int r;
> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  			msg_hi = val;
>  		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
>  			   val == 0) {
> -			r = vcn_v3_0_dec_msg(p, job,
> -					     ((u64)msg_hi) << 32 | msg_lo);
> +			r = vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 | msg_lo);
>  			if (r)
>  				return r;
>  		}
> 
