Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51714C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB8610F0F5;
	Fri, 31 Mar 2023 06:33:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0DA10F0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHfR8jSEjxQc/2RjmY5vDz1wbgprhZm0fl84XLOv0LCx42QuNehMfEn+60ibLKyyMDWNHifhh2PiF/tp4/NSAZbv+pJ1ojYBUuwFxWAICZSZrIcIx52e6MPbdy5fcRnO+c+27Jw4f81nxUckYfuZzKUIg+01MrOm69QK/a1MrYyQVW2qGxg4kAcoJpPJ+yBDoIBnN7axIA29/DwcJP8gCOkPmOumn6325jP6IzGCeAAQi5fgAOZ2GjNP9jFs5vXQz8xiH+lJDbitr5qfI6U1YUsJEqpoo5VsLyoUJfsM4MdsyJh+Syb+7j+Jits7uGaGXQ14W2bnrxbVjyQcp2Sdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjysEhJDYBFl0fOag9lhMwSYeOMW0/o1pGD00HK9uTA=;
 b=XL2rSNHN+M39EDW5189Dr7f1NvYLpPjg0J3bdQIJg7sGdalZjcCwNjLPYo7T3JR0wbbS3J7ISXI/BTk+jhIm6s1ip6OTrH4I3N9duADhLf6q9LV89eBgQ2kyMLtKkiEGpWyf2fNcXeF8imFpWMovYIFXU94da/juEYwQVMkOWiOuN9bvc36LRTzZMO2PMoAFRbuPju5B1WlNVzMf42XJ9DITGOo7Ew+/E2U0QVteygZHZXOdyrsXcNXvTb7om6CJXGRH/ZZZjJnvPJ1BfpGV0DTiEFfdeiNkxfYY08M28f75ESlEI8lBXzqqhlF4vu+yYJypdGoix1VTQXsVpGCKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjysEhJDYBFl0fOag9lhMwSYeOMW0/o1pGD00HK9uTA=;
 b=4k49jAYk4K4FiZvPYmFTb8DhpZV+ySRvop/W+fkMERf9XFhR/wNUoKqOxIdaneT6cqBiXbcFy5xsNtSlmg4XURv+pmbrNLqNsZC85QAMYlWIy/B3YzIfFJZROCGG35KhzlT7axN8IxTJ4PKlwxSYseEcAxDqyGBEljTNHG6WiRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 06:33:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 06:33:32 +0000
Message-ID: <952111a4-06e6-de29-6977-0d7e1f3a9bf1@amd.com>
Date: Fri, 31 Mar 2023 08:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/13] drm/amdgpu: add gfx shadow CS IOCTL support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-5-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230330191750.1134210-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: e79ffe02-b513-4b10-7413-08db31b1d8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KoKHIPxr5zk8rcXi8tNo3UYp9uVdnvnMfZU5/ffyRpurACX5gxXuQGybWGGLjwNcacSnCIjZy6oOzH1UW1RxqKDZyAia0MfaICuSJkBS+t0Fi2F1QUcVx2h9quwlgOpJkRLViYTbuSa7B8Q2GJkv6VUwfLUhuucIFtXpoyCTJRAZgICUpoSo79/GS86rZM7VVT0eOc2vEb6rLjTMi1xR0U9bIzZa/BGEgTIvllptfrb+VXcDjmlGK/Ygd2sPmX2Z1iQ1ITVVJIzlJkxxjnasRLLUyiWESB9PeB09uAZ+/CAkUVzxoApmxl3eTpimCWtCd8XJCnrlZLRJVRZKAWO2CvuOKk2sOg73rrjA4FvIvA530aGCA71wNLW3h4RxDDczrKCv7qM7YIpsnq9GaDwG7j7C/rBn7M1Lm+BrjrodhSye1g3qRIDgY0r5Z/gtc2TxEwWJHnI8kTZIwtXuPAkVIdnoTOWU+uiYbGatU/NLAqrVQtd+z0/LclQqoNPqz+Mrhms2ufDBtRY69N1f/fM+No1OFzLmW26N1F0KQotNVT+d2w5zeTqqjR1RoKs9uFUjn2/n2tkL8O/Rhtc/e71DUvwMPxnBGNDBODLH5AwLkl47LxXMyfeblQp3Ix2Jtl/WU3ro/UeAkkqvR+StIw55g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(186003)(6666004)(6512007)(6506007)(83380400001)(26005)(66574015)(41300700001)(2616005)(66476007)(66556008)(478600001)(66946007)(316002)(38100700002)(8676002)(2906002)(36756003)(6486002)(86362001)(31696002)(5660300002)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNUSDNxc2NjWHZkcC9RWVRwanYza1ZpR2hTN2RITFFSZDBZQ1dkdi9vU2I4?=
 =?utf-8?B?UDJwL2Q3cUVjYkkvVmIrbzU0RVRoRTI2R1N2ZGc0TDJZRkNWN0JwSHl2OTVE?=
 =?utf-8?B?RHljZmY3cTJ6bHJ0TVJLd1k3Qkh2bzVrTGhVbm5ucTZrUG1wc0phdGl1ZEZP?=
 =?utf-8?B?eE9QRkxaRFV6eXZOWFVnd2d3Z1lDTW9zYmcyaFFtQlVLVDZuSW1XOWhPRTZs?=
 =?utf-8?B?OElzZkExbFdkNFU4TWtZdDF6SFZ1MFFKV0ZwWEROOWNuenNZb1pQdS9FL0l1?=
 =?utf-8?B?bXp4WG0yOXRlY3Y4MTdqcGxrYVRrUFhycnl2SVNEWGRTdkN3OVB5M0J4QlNH?=
 =?utf-8?B?alFGMzVwbjl1WUdBWXVlU3VlNnVHQ29SL1BCWmJCMXp0bDNIdzlCdGh0NllN?=
 =?utf-8?B?SFRtMUpFN25yYzdKeFZ4c3p0aE90eGJVc1NuamM5blBHT3IvZ0pWRkQ5S2hX?=
 =?utf-8?B?bU54UVQxOWZBZXdsZFlSS1hJWkNuZ3F1YzNLWkpwRUN5bGFOSEs4UnhWL0pK?=
 =?utf-8?B?enlaN1ZKL1FYSWw4b09iWm92MlBRZmhYRkZ6S1dLbG52Z3hnaE01OEdRM3lD?=
 =?utf-8?B?Sy9NaHNnT2VWekJkNTd1MXo4bDFkUFJtUVM4bWc1VFExclN2UExUWDYyaU9H?=
 =?utf-8?B?dG1nb2dRVUVDYjlBNmhFaU9CSm5NUDdKRC9kZVhhTGFwc2FtT0kxZmFOK3li?=
 =?utf-8?B?bFZvUnNwY3lJSnJEWFRnYXNlVXZudkdCdEpDNDRwTXQ1cVBxYkh6MjN3SlNl?=
 =?utf-8?B?TXBIcUNhZy83cXVhMnJqY3ErRDhzZUxGcDZDSHY3VVozVE5CRFZXYnZnYkNK?=
 =?utf-8?B?ekNLUElaZjVzYVJrOW9BVEdIUGNmRk9lbEpDckNmTEJIcFRZUmNneEJIMWl2?=
 =?utf-8?B?di9GNm5mRE9kc1FPK0VxbHJRN1dqRXl5S05QUTRPRDNRdTJkUnJpZmFvY1Bo?=
 =?utf-8?B?ajZGNTUvdk50RDlXVHNHY0tIRENmV0pZc3FUK3NLOTBaaGU3NW0wN0lZdXAr?=
 =?utf-8?B?T0xwdUVjbW4wL2I1MFA5WVBiNEdBdU93cS9BMEh3SjNCS1pqTEhmZ2Zic1Bm?=
 =?utf-8?B?TDRiOGdrK2dQYzJtNXp1T1BEdWZrNjA5OFZPUFJKK3QwVjRXN2R2a2hoMlUr?=
 =?utf-8?B?ZVdBMDFzVHBHdDB1UTJyWkNtRVhmSGFHYlR1Rmd0bFdQOGE2ZlJVVEZyRzVn?=
 =?utf-8?B?OVlhc2xzTmFiVUdWZ1crS1VhRmtQTUs2bWtjRXNGdXFBWlREbktOb0dXSG1i?=
 =?utf-8?B?YTBmUXJPWmVCL2phWS92bWU1NTdzajloR3B0Z2Foc3FtWmhMcktaQ1JsSWIv?=
 =?utf-8?B?b1o0QmxRR2VFMUczWFlWWEc5UGZCVGxReWUxVmRwMzhRUkkxK1A3OVJSNFF1?=
 =?utf-8?B?blRiMzloWmc0M2FuWXdpRGJZN0QvZXk3M3BYRG5aM3Y4ZEdCUU10VzdGZ25E?=
 =?utf-8?B?Ym1qODZNemY0QjN6ZURiZXpGU3JiLyt1N1hoM3d5d05yOWJHR0RLUlEzeXdE?=
 =?utf-8?B?QTFWTjRuQmRUbmhaQitydDdETzVvT2J2bGZjU0xCbmlFb1dkRnBMdGdqbERs?=
 =?utf-8?B?SFZUNHdGMmJUeWptRTU4SndkbHdIYTlyaUNWaGtzRG1tdmVTc2VSL2lGN2lT?=
 =?utf-8?B?R0M4Wlk4Zlh6K0hjTjR6YmxHaU1HNG9Xdno5K2wrVi8wWi9iTTk5K1diWmJV?=
 =?utf-8?B?VlM3VzhhZ2drMmdmaXQvYnRoOEg4RjRyRUVlMkxGUncrbDFjWlFJZ0FPK1Bu?=
 =?utf-8?B?YU1GUnN6WHRDUmFrUVlielp4T1JnT3JucnFaRVR1Z3gyT2RkQnBhNDV4SG5p?=
 =?utf-8?B?Z3k4bG1QQTJCeWtBRWlVRzJCS3llSXFzUERVQ21VZ0cxUHFRSmpOVDBnajgz?=
 =?utf-8?B?OU1qc2p6VHJpZTFrNFkyaXZiaWM4VnZySFhuK3pyR0twWlNRUUVodW1LbW1E?=
 =?utf-8?B?NTZZOWlXM3Z1V1I2VW5FUHRCT0VTL3hCVzA5azlOeVVicmR6cjVMZ0FJY0JQ?=
 =?utf-8?B?dU0zeXNDaWp4ZmZxQWJVMUlzSU05K3c2aTJ4Q3dBVjZicGx4bmV2cWZGamg4?=
 =?utf-8?B?bU0vUVFSdWlRYWkwTkJDTFROZUcyZTQ0U21mV0FKVzdUdHA4WCtPNEJQK29C?=
 =?utf-8?Q?2TJdAFYyIkJrxX7NBRJH7zWON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79ffe02-b513-4b10-7413-08db31b1d8cd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:33:32.1821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsYwT0r1PzU19fXIKxeDim03nzgmHpQQBZMA/+kIztO+1DC+01XfnVKKFi2doKrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

Am 30.03.23 um 21:17 schrieb Alex Deucher:
> From: Christian König <christian.koenig@amd.com>
>
> Add support for submitting the shadow update packet
> when submitting an IB.  Needed for MCBP on GFX11.
>
> v2: update API for CSA (Alex)
> v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
>      Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
>      amdgpu_cs_pass1()
>      Only initialize shadow on first use
>      (Alex)
> v4: Pass parameters rather than job to new ring callback (Alex)
> v5: squash in change to call SET_Q_PREEMPTION_MODE/COND_EXEC
>      before RELEASE_MEM to complete the UMDs use of the shadow (Alex)
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +++
>   4 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 47763ac0d14a..41bd3a1a1989 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -281,6 +281,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
> +		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>   			break;
>   
>   		default:
> @@ -583,6 +584,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   	return 0;
>   }
>   
> +static int amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
> +			       struct amdgpu_cs_chunk *chunk)
> +{
> +	struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
> +	int i;
> +
> +	if (shadow->flags & ~AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW)
> +		return -EINVAL;
> +
> +	for (i = 0; i < p->gang_size; ++i) {
> +		p->jobs[i]->shadow_va = shadow->shadow_va;
> +		p->jobs[i]->csa_va = shadow->csa_va;
> +		p->jobs[i]->gds_va = shadow->gds_va;
> +		p->jobs[i]->init_shadow =
> +			shadow->flags & AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW;
> +	}
> +
> +	return 0;
> +}
> +
>   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   {
>   	unsigned int ce_preempt = 0, de_preempt = 0;
> @@ -625,6 +646,11 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   			if (r)
>   				return r;
>   			break;
> +		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> +			r = amdgpu_cs_p2_shadow(p, chunk);
> +			if (r)
> +				return r;
> +			break;
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bcccc348dbe2..9bee630eb0c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -136,7 +136,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	uint64_t fence_ctx;
>   	uint32_t status = 0, alloc_size;
>   	unsigned fence_flags = 0;
> -	bool secure;
> +	bool secure, init_shadow;
> +	u64 shadow_va, csa_va, gds_va;
> +	int vmid = AMDGPU_JOB_GET_VMID(job);
>   
>   	unsigned i;
>   	int r = 0;
> @@ -150,9 +152,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		vm = job->vm;
>   		fence_ctx = job->base.s_fence ?
>   			job->base.s_fence->scheduled.context : 0;
> +		shadow_va = job->shadow_va;
> +		csa_va = job->csa_va;
> +		gds_va = job->gds_va;
> +		init_shadow = job->init_shadow;
>   	} else {
>   		vm = NULL;
>   		fence_ctx = 0;
> +		shadow_va = 0;
> +		csa_va = 0;
> +		gds_va = 0;
> +		init_shadow = false;
>   	}
>   
>   	if (!ring->sched.ready && !ring->is_mes_queue) {
> @@ -212,6 +222,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	}
>   
>   	amdgpu_ring_ib_begin(ring);
> +
> +	if (job && ring->funcs->emit_gfx_shadow)
> +		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
> +					    init_shadow, vmid);
> +
>   	if (job && ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> @@ -263,6 +278,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
>   	}
>   
> +	if (ring->funcs->emit_gfx_shadow) {
> +		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
> +
> +		if (ring->funcs->init_cond_exec) {
> +			unsigned ce_offset = ~0;
> +
> +			ce_offset = amdgpu_ring_init_cond_exec(ring);
> +			if (ce_offset != ~0 && ring->funcs->patch_cond_exec)
> +				amdgpu_ring_patch_cond_exec(ring, ce_offset);
> +		}
> +	}
> +
>   	r = amdgpu_fence_emit(ring, f, job, fence_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 52f2e313ea17..3f9804f956c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -67,6 +67,12 @@ struct amdgpu_job {
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
>   
> +	/* virtual addresses for shadow/GDS/CSA */
> +	uint64_t		shadow_va;
> +	uint64_t		csa_va;
> +	uint64_t		gds_va;
> +	bool			init_shadow;
> +
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..7942cb62e52c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -212,6 +212,8 @@ struct amdgpu_ring_funcs {
>   	void (*end_use)(struct amdgpu_ring *ring);
>   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>   	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> +	void (*emit_gfx_shadow)(struct amdgpu_ring *ring, u64 shadow_va, u64 csa_va,
> +				u64 gds_va, bool init_shadow, int vmid);
>   	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
>   			  uint32_t reg_val_offs);
>   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
> @@ -307,6 +309,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
> +#define amdgpu_ring_emit_gfx_shadow(r, s, c, g, i, v) (r)->funcs->emit_gfx_shadow((r), (s), (c), (g), (i), (v))
>   #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))

