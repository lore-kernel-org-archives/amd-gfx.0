Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB32DC54EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 09:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DBB210E8B0;
	Thu, 12 Jan 2023 09:19:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB76F10E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 09:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHyckqeXEduphVbl61FLarBrASs2I0dT75F/VxzFpqr77HKlbOHy/cbVh11XIoO127apqFny1WAnwQ4MdGevAsfDswOYbPB9zUn7WnSpPlmwqsVEItuyFKKn02dvM8da886cyhgsrIO3f4XmyBkuB6c6J8RH1RZ9kQPe+RDxzRflSMNHqhhAX62IICANknE3aP4UMn4Ml29o8414yKsgr3DbYaJs6FbLfmS3v+esdrUMgBUmqpn+K4wne/tOPLS5QVo1X7LHvAQdBQSbZUCwAFtRgBN3ia6dMjxwYThW0o4lf/nC5wbbxoE9xgHVWEd1CPfmg+TzkUjGWZb4LPRCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfJRnbZUQcKE3ulhXgtARtvSWmfjfKQHmaDsZlQlKi4=;
 b=Zpq/A9gDbj6CPXFXtY0zipng+++LRqLLll+3Cxb6TGfObr9h0lKI88PbPMElBEbDob5QuT1cMSmtVaSfuXxetbP/f/kHL9clvrJFOKdlKADI7HG/sTMRxgH6LPqBTT9SIRF3nz6o3hJcRjQ9Yy8cz1x2a/oi0DHyqoT18xT6AqtgqqyeN22ohPDd/bB1tMAnM7V9vsVGPveySDslDkJx1KNLpbJhPgGey2kBRiqLKI/lrNdtpEGYyfAUREIj/aPiygvJkPcNeKpz8Wg4YW3Bb/AP0tSENLzdx5RBRfMJDgSv8UdiPU0OkGQSnVQgkFuvnSJFJNAEd7bBboI6OC5oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfJRnbZUQcKE3ulhXgtARtvSWmfjfKQHmaDsZlQlKi4=;
 b=wVJrMfyAI3N7ChCA0ApxOmEYRBo8vVyjwiZRRZxOeofLtNLp5V6u5IOYXerYAOHlk/pftnkmMlQ2a1luJM1iikRavizUdRYg0eBr7Bw8dttfZ/GVzoUKzvsW/HRcCSf81rQP3WJbru7aHkidTvAyfYIngXGomsaYxPN2DeH2JYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Thu, 12 Jan 2023 09:19:12 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 09:19:12 +0000
Message-ID: <0985804a-d465-a1ca-f4f7-aed8b7188ac4@amd.com>
Date: Thu, 12 Jan 2023 04:19:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230109130120.73389-1-christian.koenig@amd.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix pipeline sync v2
In-Reply-To: <20230109130120.73389-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a887e0-8061-4dc5-4331-08daf47e1189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUxutbslE3FFgCXDbnHFOy9se+bDk2HJkBS2IO4XfInDsNxGwnB9K3yMWUy6czTij2PImoJWhJPWiO4wMwUUBHooxwo4NCynCapUpYkJQl2Oj3tfJs/MZRU3T2cTAJctz5RnkQN6UOiuAbc6UrZR4w1vevFGx5ZTe2huKk6KkJxje9ttz5XXBzPvJBRTaeuQKnf+b8YaxmTYECHgcjnoW3R7k6REfvF23eWtH3W+nXvQP6q52A/e/9ToyzGa52voHwj6OsARruo2FAcZnexBPmaumIJXop3cZeRywmsRUXIkexIjsLGAuVSMbmt/9beh9KraISz6TOnVHhWRqA3vu0cTUY3P+E4NW8u4y0koTeh+FWKmRcLvScpYNdkZrrYljMyZiasB6trfVLrAsrOiu3ViNt27vxcf2kVhrtTtQQedtw5L8vzRof/DsdfbKa8n9z8adkifcYi/onwrzy5AOoNVEJRlexY+SKCVhZ5Ibi4U1f2RaIkt3jkCfr71lo/tMtTrC0yRKOO2XHZqBQJ3tmm8RyKTQbbI0ChUMaAzL1P+BUF6w6NeI40+P5e2cIqkIMRkP4ieQizSNj0xV4QaS4bzECvmX6F2InYWQv9VBnyLoNzBqT56vh/pYhju+eRZ/+jZFoc8U0qv6R6unZEFrEzW1DR99wJ3fT0dDsk8Z08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(31686004)(66556008)(44832011)(2906002)(5660300002)(36756003)(8936002)(66946007)(41300700001)(66476007)(8676002)(2616005)(316002)(53546011)(6486002)(66574015)(478600001)(6506007)(26005)(45080400002)(6512007)(186003)(966005)(31696002)(86362001)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWp6MGtvRHd0bkZSQUNEeVhyalA2S2FWWXZja1NvWkI1NnNYNkNkT3k3N01z?=
 =?utf-8?B?MUNQVEcxNW5UUkczSmhhaE5aTmluOUNROXJvRW9udWJQemhXNGdTUmxWQW1T?=
 =?utf-8?B?R1QyUElWdXZ1UnJaZ2s0dGNLY0ZWbllvc29CNC85MHQ4alVyOGRIWlkyS1M2?=
 =?utf-8?B?b0tZSGFBaDBXNnVGM3NxSUtaWVU2N2NQRzA4YU9rRy9JVjVlVnF0cVhsM3lh?=
 =?utf-8?B?cHljVHBTWFBCSHdvbkxmTGp3UVF0aHFTK2IxcmkyVVNmWS9PcnQvMXdWYTZX?=
 =?utf-8?B?T3dRVnFxcjhhaXVPeFMzc2lpR1JlNjl3eXdCcHREKy80enl2SS9WbkMyOE1u?=
 =?utf-8?B?bzBPZEJiU2NvNlY4d3NtMU5qdTh0cEl5c3dkT2lxMW5oOXNob0dpenE2VzFw?=
 =?utf-8?B?K3ZYY1FtRnNpRG4rQUxQRkN1OEh3ai9GZHpIS3VNdFFhZWI0LyszT0h1Rm1B?=
 =?utf-8?B?S2dNV0RJTVBGcS93Q3RibjFxc3c1QTZhUWZITkxHUXEvZDhxY21XdHQydEY5?=
 =?utf-8?B?OU5YaVJFRTExZ1JiZlRGRC9ST2NEaU1YTDVqc2ZuMG15WXlwbHo5aU5ZbjRx?=
 =?utf-8?B?amgva1pTa3NBRnRzTEtsUG1DRCtIQXlIZFJBdjRLRWpjQzhya2J4WEN3Nm5j?=
 =?utf-8?B?MEg4a2tOdlREbjdLVURCalgwWmZ4OWY2eFI5T0tDd080WmluSFlkcEVVRCtw?=
 =?utf-8?B?d0h1R05QcG1pUlI5RThsOUVLdWFuaGJrZlZES2pxUFlDdHY5QWhJWEZ1em93?=
 =?utf-8?B?cTF6am14YXExNVI0cGxzbUt0dGEwdUxtaXJVdVZHNm9rcGlqT0thZlhmeFdh?=
 =?utf-8?B?WXZUSitnVGpkLzlUZUE3a2xveVJWZWx5L2xvam1Va2ovRllpaDEwNFpvNk5C?=
 =?utf-8?B?QjlpWVphZG9QaVduRDVpWGpTUTRaS2J2SlJZcTRGelI3a3pwNGxBTDhuT3gx?=
 =?utf-8?B?R1hERC9oYXdxYWNOUStic04rYURZa2dMNEN2UUk0MGszK2dQeE43TUVFMkJn?=
 =?utf-8?B?cmlaN2U1ZnFoUlJxMjloWUl2T2o0Y1VJTlFIeGdOVFpzOHgyUjZrNWsxZTFW?=
 =?utf-8?B?Z2o4R2tJV0t6WVVYWGdUQjVMSVN6Znowa2crRk9aU1lJelJmSWNhNkhPS0w2?=
 =?utf-8?B?SEF0OG52Y0x2T0pWSW94VXRZd1Z5SlJscXhGUitmQ3FFZmhiaGZLZ0VoQnFw?=
 =?utf-8?B?QnoyOUcxT3c5QnZDOURUNVdHL25SRW13dFFqM0hRd3psQm4yMDc5V3Zobmp0?=
 =?utf-8?B?U2xUT2Uxc1ZpWlpYWVVEZ1dVWVdKMS9BVkE4TU4yaDIzbEJZejVTRTVnU2hE?=
 =?utf-8?B?eHRXRkhWTzczbVlVM1ZORCtHRDlLUkFRcHZYZTEzMHhlNlQxTThPVGlGZ3FO?=
 =?utf-8?B?bzE1NnJ2anMrMFozMVNraDdXd3lOWXNNT0ZMNEQwSE00QmpQOHVhaVNJMEEx?=
 =?utf-8?B?QzJQU3JlSC9LVFpESUU0b253NlJRMEJEdkVIY1RRRndSdDB4T080cUlLU0kr?=
 =?utf-8?B?dHNIamlpR0o1NkVSL3QyZWd3b25zQ005ZkNoeEpSVHp6N3pGSDZYV0lFMnM4?=
 =?utf-8?B?UnJIS0x6MUhpSStLanVKMk5mY2o2WEl5amNkVVcrVTJyTlQvK2FYR3p4d0Vj?=
 =?utf-8?B?NHl2R0VZSzYrbVlndFh6cE9icjZqMnhBSHVsN0xLZUMvK3Y3YWljbjZWNFZs?=
 =?utf-8?B?Y2hYZ0RKOHBZdktpS0NrQStFdG1KZlplbVBMMFFIeEpwdDlYOEpadngrM2pT?=
 =?utf-8?B?eEYzVHZJbmRYa2pkeTlCaThrcFJUVDNKTmRtL0FLVHpkU2lmVjRoelhJQTVJ?=
 =?utf-8?B?a052UHFLbUlyaEZZWTdNY0ZFVEVYMDRXMUc1TWszUU5BbFg4QWpHMldod3dy?=
 =?utf-8?B?cjVSdC9sTXVmY1cxQ1Nlcm1qWGYrVmpsRm8wMDZWcFYvZmpzQ1dYN0g3T2oy?=
 =?utf-8?B?VllHNFl6aDU1NWtaTVBDdzFLd2dzQXlpdmd6ajhQczVLeEljZjlIWHc3TFhm?=
 =?utf-8?B?TlFySTNndFoxUmhpc0YyTTk4WkRTZ05iaDEzYjFCL3B6eXMvMFBRTG1TNElv?=
 =?utf-8?B?VjRRSVFrWHp3K0preDNib0dZRURlbHFjRThrZ29RSWFSS2JvbEFMQzhkaFA1?=
 =?utf-8?Q?O2eii2L82OdvdD8Frwmp+4bEG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a887e0-8061-4dc5-4331-08daf47e1189
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:19:12.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4ISPHsjX5Johyirbsx60Bmdi63bUnMjbISxnaRHdeuHKt3q1FP8oRpr0JEWrSub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-01-09 08:01, Christian König wrote:
> This fixes a potential memory leak of dma_fence objects in the CS code
> as well as glitches in firefox because of missing pipeline sync.
> 
> v2: use the scheduler instead of the fence context for the test
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2323&data=05%7C01%7Cluben.tuikov%40amd.com%7C78ed156f30284f9b6dfd08daf2419c17%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638088660850593361%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=R3ZsrQUOHoz4pYWRSFYQTRjsWT0wok4otsi7I%2FxJ9AA%3D&reserved=0
> Fixes: 1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
> Tested-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 46 +++++++++++++++++---------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 47763ac0d14a..7b5ce00f0602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -61,6 +61,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>  		amdgpu_ctx_put(p->ctx);
>  		return -ECANCELED;
>  	}
> +
> +	amdgpu_sync_create(&p->sync);
>  	return 0;
>  }
>  
> @@ -452,18 +454,6 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>  	}
>  
>  	r = amdgpu_sync_fence(&p->sync, fence);
> -	if (r)
> -		goto error;
> -
> -	/*
> -	 * When we have an explicit dependency it might be necessary to insert a
> -	 * pipeline sync to make sure that all caches etc are flushed and the
> -	 * next job actually sees the results from the previous one.
> -	 */
> -	if (fence->context == p->gang_leader->base.entity->fence_context)
> -		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync, fence);
> -
> -error:
>  	dma_fence_put(fence);
>  	return r;
>  }
> @@ -1188,10 +1178,19 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  {
>  	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	struct drm_gpu_scheduler *sched;
>  	struct amdgpu_bo_list_entry *e;
> +	struct dma_fence *fence;
>  	unsigned int i;
>  	int r;
>  
> +	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
> +	if (r) {
> +		if (r != -ERESTARTSYS)
> +			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +		return r;
> +	}
> +
>  	list_for_each_entry(e, &p->validated, tv.head) {
>  		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>  		struct dma_resv *resv = bo->tbo.base.resv;
> @@ -1211,10 +1210,24 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  			return r;
>  	}
>  
> -	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
> -	if (r && r != -ERESTARTSYS)
> -		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -	return r;
> +	sched = p->gang_leader->base.entity->rq->sched;
> +	while ((fence = amdgpu_sync_get_fence(&p->sync))) {
> +		struct drm_sched_fence *s_fence = to_drm_sched_fence(fence);
> +
> +		/*
> +		 * When we have an dependency it might be necessary to insert a
> +		 * pipeline sync to make sure that all caches etc are flushed and the
> +		 * next job actually sees the results from the previous one
> +		 * before we start executing on the same scheduler ring.
> +		 */
> +		if (!s_fence || s_fence->sched != sched)
> +			continue;
> +
> +		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync, fence);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
>  }
>  
>  static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
> @@ -1347,6 +1360,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>  {
>  	unsigned i;
>  
> +	amdgpu_sync_free(&parser->sync);
>  	for (i = 0; i < parser->num_post_deps; i++) {
>  		drm_syncobj_put(parser->post_deps[i].syncobj);
>  		kfree(parser->post_deps[i].chain);

