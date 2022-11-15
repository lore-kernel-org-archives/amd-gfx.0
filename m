Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 09:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B55710E390;
	Tue, 15 Nov 2022 09:44:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D64B10E390
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 09:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnzJK8tvSoMSG5NbWM6U2rO+Rc5QYQY0aWxtKyofgXv9+tQXhlh0teUdVMmigiDcz+TGqoPuiXYvEPvd1S5tqY0DJMkrlMnpMkbxAD/aN8fn0oj0F62w2cfRRzmNsTbUqq4SOcuQQGOWtC/LzY2N3Ch0lsl3SfuN+4jNAgfcd8ziTvxNQMvAcImiT8Oh1VHA5y+R9o2vca0tTFyBS6KOmvFCpKr7iRaBkRyOFPwckEXoxEO1gwP03NQfbT/VH5XRyuqFUfYUO2KOaTGqjMYo81dwHyDAhqmLm+0MMz/GL0sayKEf4uXyUt7j5MwlOA5Nyq9QfhoLCqrgj6GCc/BtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdAiZRspTPY2/N7voPPI4HfLlF4uYQ60bbjDtk1Vebk=;
 b=DcVo+PTAT3GwFFjDYgdPufoheIDerfFHK0u8jCSL9gGTo7Y5MgRw+iMh99HEQasVit1HCAaXYwPNdmp6Pngnur0SuwkNOHslJlKLX4ABwaTZuE1bvwpVsrgiWzZig85H9e7Pj2RW4KjVVp/9hi6Ik1aDHCLm7zX0GeTR08x4PNo0OxanvTP2w0n+g3wgO6mj1zLyU2slwIJ69c9j6eYKw/IPOK+e2qVAu0QHC0aXm21Y/hpdg6rtgHgk+1XnFjn+xmTuTBOin4YeZzuqySVxIyxja/OuhXEfAIZQ9LwnSEBUwdZF7c8Lfg0DaE2Xn5EXqKBSgWuXRkbJAn4AMX/JPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdAiZRspTPY2/N7voPPI4HfLlF4uYQ60bbjDtk1Vebk=;
 b=t6l1P+0eAmwHedm097S70cRjyrU80uDwntZENzZ5yCrmdfPCI2LY/oXjH5HELHJPf1KE7CDhtfZcx3z5drWdAEpovRRgj5vJUmTO21VJ9TvyQjn2XzS/jPVKFsErHKnveD2YuVcOS1xD5DQZGzIisBFzjm4LT2eZVyy6A8pivyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 09:44:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 09:44:06 +0000
Message-ID: <fc7e683f-4983-8adb-b8ed-3c756e179ef8@amd.com>
Date: Tue, 15 Nov 2022 10:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: use the last IB as gang leader v2
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20221115094206.6181-1-christian.koenig@amd.com>
In-Reply-To: <20221115094206.6181-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0187.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ed592a-1bdc-422a-1321-08dac6edf02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRUpyaL0kh7KCaz02yiBxFhcbAZ6jKP+U0YRAy2lxuUK2czoD5Mt2dm6/lBfXXlXgHyFIkoL7frKGXtvJ9kMgRqm/jQM1mfBYGAIBdpksG4Lvr+B/C7ANCMTm4B8g1wUNKzfKGY8N9fBna5kB+xI6iE5744QLkp492jujqAR6qBXfc26CeQfULQLJ/1uQLH+du2TEGPBn9npRhmOnBVp+QTsmJmk3O9QsmzUyKSaJVgpA2XrAdCbyGAMF5aqQZIgWR4whuGJadpETwgTXDijcUc3RZOWkt32WGNy2vxrG2zDfbzTImM8DkLZCUYQI8dA8eIWRxn2DoUhrXXKfl98gvXYLbFtk/mxnpWmOadEDAvX6U/gbvk5lm6FbjhZT+dS9+oLS5BTI5FQ3ZgOU6cF7RDzUahn117GWzZt0kMA20p1PyuyBHzTXzWkyIbQEAN0B2q3gfliP1pbaPh2Qz7QPLToduSMUSwlxyP8XFG6Ko6lq5cWM/n6yvCZScfSFRICpt7X11fXWoKhrtuqeJYEHgJ5sJb/wIkT/EyMqjqXvvcBvsqiJ/mSt0SxWytL0VkN3z+WBXOZbK4RyiE9G6u+1f/mxxLMe2fmBEg0qOXO5azaeaZHsQUxAcciW6XBGo6UV6m6pZDjHSyZZRioCYy7lzLH+o3DKFJHGsUjenVkrzqJhd1/U3gBYHf4vyWJgmQz4TBme3lTZAvw/WyoLMUfCQB3F0/SaHby3Pxg0p/3Flby0CKGXlOhD8bnm/ynvhJTaFqRArdGoGrQ9i2MmVmPfbW3NQLGbDAMlpjxbMMbctc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(6486002)(478600001)(31696002)(38100700002)(6666004)(86362001)(2616005)(2906002)(83380400001)(41300700001)(316002)(37006003)(6636002)(6506007)(31686004)(8676002)(66476007)(4326008)(66556008)(66946007)(6512007)(66574015)(8936002)(6862004)(5660300002)(36756003)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JCY1hwUzg4cmMxbENvMUtYSjBGVGxvUWRwSG9VSkxmdHErelpyWWZBcVJ4?=
 =?utf-8?B?VS9peW5SQkI2MkdrWlhvckNXbmpWUGQ0OUZrWVBKd2dZNkRRWVRJZGp3cUwz?=
 =?utf-8?B?NW1xMFYzb3Zzd1lLRkV1RDNKZlFkR0x2U3IyZ2VWL01SVXdaUDFJenMyR3ky?=
 =?utf-8?B?NjE1K0o3SC81WlRKRll3NjFKNGU0K0tFQlJqeklhL3lJMFRyRk9waDhPdCtO?=
 =?utf-8?B?QURKOU9UVkgxM044YU9sWkwrSmNlc1VOVEpKZFNBemNyaE5LcUk3a0k2aS80?=
 =?utf-8?B?Ukg1MDlBUGVDNDdSQ0thdWNrK0loOURrS1BXMmdCbTVtTmtLR0JrSkthVk5y?=
 =?utf-8?B?S3Jlcis5TnZNMDJlZVVtcmM3dFp6enlEUGxSbXp5ZXArUTdSbVdRanZmNFRo?=
 =?utf-8?B?NGc4Vk55RXBkVHd5bmltR1BNTVRnRldLN1RXMmxGWm94QkhlWUZmMXM5UEdv?=
 =?utf-8?B?LzFncjJ5Y2xKdGUvZmZnYllOZWx5RVp0OHFHdUZ3QTl5Z2xKZTcxbDBQbkFn?=
 =?utf-8?B?c1FUMFBPNnBHaStWbWdnRm9UaThVNXhWSStMTXRXUGlZQmt3Y2N0RWx3Smhr?=
 =?utf-8?B?RUFEcE84d25FanZWa2VJVFk2cExmeXB1djlNY0hkS05ReHIwekcxOFduRFZW?=
 =?utf-8?B?dS9NSHI3SU13Z0FOd1dSUWJBNjVQRVlIK1FTY1BhODVuYkd5ZkR2WmtpZ2Zz?=
 =?utf-8?B?Zk5VZTIwNW50clI5bkd6VG8xbWx0QW9xNmNPeU5tanVhS1hjTDBhL3pPVFV1?=
 =?utf-8?B?N3dTdlFGN3FROFdLUmtXZWxwaW83aE5pZ1Y5V2FDZEZ2NmVEYmM3QUZJVmJM?=
 =?utf-8?B?aTk0bjJxSFN1ODNxYm1GY1NKQ1VYR3hzR0JWbGtuOFluRjd1RG1wRG96aUx4?=
 =?utf-8?B?dFZIdkEzOG1XbWRBL1VtVVI4TnkyUlhjOWRrVGJwdFc0K3kwbkdiMy8wbXdq?=
 =?utf-8?B?NWdZVnl0WDV5QjJLK040U1VBRWE4ajEzcHF3VndFWWp0TjMwYXBjNVp2UTBq?=
 =?utf-8?B?YXhTa2x4QjFNeU1KVHZUMzdCOC90R01mZWptdlNZeU5Ba0JLZS92SzM2WW9x?=
 =?utf-8?B?MnlGK2JyYi9nNndpaXFpRVJxQitNUE40L2wzR0FSbFVPbkIxRStuVjlwd2Rr?=
 =?utf-8?B?TVRtVy93UTRwZnkxRTF1ZUVMaHhDRGNvd3lkQ2w0TXRYUkxCSVdyRy9wekZ1?=
 =?utf-8?B?TlpPR3d3OWtFT2RQU245QWk5MVRYUmFMOU1oMFNTb04vYnRMTUdoRThSd050?=
 =?utf-8?B?R28zbldNaEU5RGMrQlRvWFVBc1pSOG1mMmE2NjRJbk5jMjVvR3NQMkRPUVpW?=
 =?utf-8?B?U2ZjOXFwK1d1WXFZamxKQ2hNK3Erekk5MzlIYlZBVFZjTXNLTHVJdk5aVnY2?=
 =?utf-8?B?MnRwejlSWm03VEthUnBBSnREWVZpcWJhYjd5R0VseHhjRVpNRmdwTm9Lb2NB?=
 =?utf-8?B?TlNpeXp3MjRnT0dPMDh2eWlGc1c5VTlpL0JUMW9SOHlqendCQlE2NUllalVJ?=
 =?utf-8?B?VlU5c2VWUHlDRFFDZWtwRVU3cnNIL0FsZFdzUTZzL2pPMTFWNlB4Q3MvbWVY?=
 =?utf-8?B?cGY0QllPcE5HdXZDYVBvaVRZSGtVTFBJTlgrSlp0MjVxZnNuY2N6UEVZZjJL?=
 =?utf-8?B?NEo1RVBrUW9lckxTOFh1cVVBQy82SXFqS2I0c1JjREtJRFlFVlRuMXZ2MzJ6?=
 =?utf-8?B?ZjZZR0xoMmVjNUVIbnAxTVlaTURGZFB3MktvQkxGUzJHYll3bU9ibU9qTmEz?=
 =?utf-8?B?T3NWUlQzWlpQMStPV3RlYk1mWjhOVFJEbzg0VXcvdXBBMmZWWDFJOXdtZ1Y0?=
 =?utf-8?B?T0tYSHBSc2NtVGtVK1F3OFFsSm5HVkZFcUFwb3hTeHdIY1l6eXV3akE4SW0r?=
 =?utf-8?B?MEZKTDhDTG02Smtrc0lqc3hMU1FrZDh5a0RuVkZVNlNUU29QendsWUNUQyt6?=
 =?utf-8?B?SnViRkxoMVNyQW1uV0JlNnVqVjJNbEVzUVFCYzJlRk1Pa2VqZ2c1dTk0a3U5?=
 =?utf-8?B?Uk1uT0k4dEJNRDZRSXF1STRHY1BGYXdYSkRwazVTSllQd2JHSnZodVZIajBu?=
 =?utf-8?B?RFg4dDQvbzhZcWNTOXJEaXJVNnNIWjcrTkFtNHVmdXVlejRyWWt2QlIwUFlH?=
 =?utf-8?B?bk9wWlZCVU8vRmZmTHQ4aTVZVi9uZG1kY2Jia0xtVG11dnNwRklyV1ZqVmtT?=
 =?utf-8?Q?Ll7QiuyhTLRg82MPfKTZqTxBKzZOR7+16LY7xh+/5Cpa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ed592a-1bdc-422a-1321-08dac6edf02c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:44:06.8284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UiwHFNFvZsedj7GFbYrvEbg2FBp5LhIPhH1s1ot0KRQTG5T9ChqELTDtSO7T6J4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.11.22 um 10:42 schrieb Christian König:
> It turned out that not the last IB specified is the gang leader,
> but instead the last job allocated.
>
> This is a bit unfortunate and not very intuitive for the CS
> interface, so try to fix this.

Alex could you take a look at this? I would really like to get this into 
the next -rc.

Thanks,
Christian.

>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
>   2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1bbd39b3b0fc..fbdf139cf497 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -109,6 +109,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   		return r;
>   
>   	++(num_ibs[r]);
> +	p->gang_leader_idx = r;
>   	return 0;
>   }
>   
> @@ -300,7 +301,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   		if (ret)
>   			goto free_all_kdata;
>   	}
> -	p->gang_leader = p->jobs[p->gang_size - 1];
> +	p->gang_leader = p->jobs[p->gang_leader_idx];
>   
>   	if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
>   		ret = -ECANCELED;
> @@ -1194,16 +1195,18 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   			return r;
>   	}
>   
> -	for (i = 0; i < p->gang_size - 1; ++i) {
> +	for (i = 0; i < p->gang_size; ++i) {
> +		if (p->jobs[i] == leader)
> +			continue;
> +
>   		r = amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
>   		if (r)
>   			return r;
>   	}
>   
> -	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
> +	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
>   	if (r && r != -ERESTARTSYS)
>   		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -
>   	return r;
>   }
>   
> @@ -1237,9 +1240,12 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	for (i = 0; i < p->gang_size; ++i)
>   		drm_sched_job_arm(&p->jobs[i]->base);
>   
> -	for (i = 0; i < (p->gang_size - 1); ++i) {
> +	for (i = 0; i < p->gang_size; ++i) {
>   		struct dma_fence *fence;
>   
> +		if (p->jobs[i] == leader)
> +			continue;
> +
>   		fence = &p->jobs[i]->base.s_fence->scheduled;
>   		r = amdgpu_sync_fence(&leader->sync, fence);
>   		if (r)
> @@ -1275,7 +1281,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	list_for_each_entry(e, &p->validated, tv.head) {
>   
>   		/* Everybody except for the gang leader uses READ */
> -		for (i = 0; i < (p->gang_size - 1); ++i) {
> +		for (i = 0; i < p->gang_size; ++i) {
> +			if (p->jobs[i] == leader)
> +				continue;
> +
>   			dma_resv_add_fence(e->tv.bo->base.resv,
>   					   &p->jobs[i]->base.s_fence->finished,
>   					   DMA_RESV_USAGE_READ);
> @@ -1285,7 +1294,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   		e->tv.num_shared = 0;
>   	}
>   
> -	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1],
> +	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
>   				   p->fence);
>   	amdgpu_cs_post_dependencies(p);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> index cbaa19b2b8a3..f80adf9069ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -54,6 +54,7 @@ struct amdgpu_cs_parser {
>   
>   	/* scheduler job objects */
>   	unsigned int		gang_size;
> +	unsigned int		gang_leader_idx;
>   	struct drm_sched_entity	*entities[AMDGPU_CS_GANG_SIZE];
>   	struct amdgpu_job	*jobs[AMDGPU_CS_GANG_SIZE];
>   	struct amdgpu_job	*gang_leader;

