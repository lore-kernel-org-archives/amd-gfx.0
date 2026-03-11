Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F21062889
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 12:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF77110E8B2;
	Wed, 11 Mar 2026 12:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2VQBazv1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44ED410E8B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 12:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMRBK6TgSF6+hZzv9g1Pm7PqgGcFyoPnVgjPq6NsDmT8lRpIQOQGE4ZG3cY9q9+yK9hclTYZf+9dNxB26ihaStQLcC0W+Ps/XG9MNf3l8DUmY2NOKQP3nD0ccJTAF74eLuyDpuJvm1cljMkKtQqJsyIYYFsDYnNpCfupJgoA9o2c4ADmTi88S616FCzGfc5PfAXBWvPrmS1tKVqyr9HmdFZbR54SOJnqMj96ZRAbshaeC/PTYkPZQwAK/rGuG4m7FI08tv/wGrirdz/yV5F7kCD2TpwnS3MqkNJMfJBPksQAMFcpbKN1koSau3FHhf0JADOF4GQJgaosvbK7YKgbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PKxhIKP66SX46dWti7HJp6Mb71e68kIqXtoGwmkzCY=;
 b=oy/+2IkEqqGA58KnUOfsf/nxg843jzWV3tjwe8moqtGWrJ9yLQUxusV5YrWR5n+DVw8Dix1xJuwpwkERf9361mdX8KYWgpQewXrKkr1dA4UPFIT0MRlz740gIkZPpgpHSU0PXeqa5AMGb9pd1EhuaG9mAxV8rJXqQjUL3Q/ThElRRvsusp/cRgUnp0O2zfIC+VRv4dwhUlbWHtIFWHnyImjv58dEgQky25yeh/VLiyE+aNGqKtCfgkCdGXeusixJswSk+XK+o5usc2+7FFw/H+cxAH/jUixtNqPw5IMYDfc+s+8z9nv/5LmW0FvOvU/iKjOVLMs2Qd4I7PYb1Hcq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PKxhIKP66SX46dWti7HJp6Mb71e68kIqXtoGwmkzCY=;
 b=2VQBazv1rvtuQpLGotsrsl1MOj5sj+pnHPQ1dCkqygVFcK9aU4htVlTO3tcEt8by/RyC0ppAWiuEmgLDLQNhOrz5lmZ7QMVpSRPFGUI4+KDgoxLo2TiJxLiX3uFJRm01tFxslp1XjGj/+OxbIo9a8CXWPeHNJDxj26aONBgejUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:27:07 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 12:27:07 +0000
Message-ID: <8cae20bf-4ff5-4a03-8137-36096197364f@amd.com>
Date: Wed, 11 Mar 2026 17:57:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: e181a557-b7f8-4363-7fd7-08de7f6982d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zRvVwlS4rB8AeogodYHcSXtkcvQRMSH2V/sS5tCdWfOL3W9/WnokCUz8x9jqUZX/msyaFVpcbCv1izmAa3LIPZ0DIW3HaUZjVMAleBaeD3IH0pwNX/fPflwrrXsDc537nmeheis8P6Gz2fVxXU5TmQocXGHXCF2kQD6A9J7eDwsmf6yFeZ0N1CJILNIZ+EAUwY53gQaqa8ZNh2dXtWdH+vu4FwzK9Ase6ndyDgaS9Yg1oF9V6uYJ1wh6Q8SIbvLlgEPqZ8Sw0fJIEGc/GiSwOdppXErb2Iq3QP2AM2BucSejeA296/0sSqgp5XD9/7+RZ8Qt6pAq0Vp6pBAtjFUu3BJJvGMwAcbKdA+Ya0SOawxf3N6bffGg7PHUSQoEsGraUDc1IUkTstl/naCfIbrPIX8STuZHj4hq/rvx/csD9UmiA10QfNbCBVcw04veT1kA4IYA88Gqfw2ELCPk7qjyM9A9aj4hkkmoUIjGKvLYB/q8se/jNAQzYEWcX6ErUXK7BDxAoiPm/1FtHEQQ13wxQdKXVMc3K+cSs9xA9Lvj4fdSgNal0IngULd/AQrjueOpXKhJ5XVhRy+pk3/fpr6vnTuk5jdN1Te5UHZnom0+fuxK68ufei3hzlRqyH+2RfvvTEAmuUgh8c33cAjcz4s88y1N1L44FB1ZAynzV5+mxR6mK0H4/rD9sM68U3ciovF7zlqX3bgw+p8+HwOQQ4jum1R6uz8eZcqlW3o/imWrcPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnN1Mm5wNXVFTjJHTThKQXQ5d3hFOS8wRlV0QXFKU29paXE3RUdaQ2d6Y0ZY?=
 =?utf-8?B?aEdESzRnV25ieS83V0huanBOdmluc2xxWDg1MFJnK1pwRDFjaHM4dXVxQUIz?=
 =?utf-8?B?dkZZZ2RVQU9ZTkhZd0NGZmphZnFjUm1vdmVnM3dKdUNyY0cva0JNNTd0MnVT?=
 =?utf-8?B?cUxQU0NvaFh6L0lwT1FhS294VXBoQXhJK0svMmY5K1ljMENiUklDN25HbEZ2?=
 =?utf-8?B?Tmw4bng4QllZZkFUaUp2RmNpMTEyMG5EbG15a1hRUExVS2d4NWxHT2NSUkJ1?=
 =?utf-8?B?cVhCT0xQN0N5NEx0ZXozRUFIYW44SEVFYmMva254bVdTVUMrRXN5Z25JT0Zt?=
 =?utf-8?B?a3JrdVg5NS9GTjhoQVRwV0FQNm5Wb1ZzUkZvdUJQVWtoc0tpcWtrVXpFSVhC?=
 =?utf-8?B?YktZT3ZtZ0c5bTBOaThDUk1uUjZDU1MxeUZacFNnaEtGWGZ4YXBJa3NBYlpk?=
 =?utf-8?B?Skg1cWZzMEVjTUlTSHVNRFlOV1VDZ0VPRFRZSld4ZDJnbGgycGtETk5NZnZR?=
 =?utf-8?B?ejdLS2xmZkFrdS9ZTDlOanVDZTI0bXB2MExKVjhGSXpmMDNnWFZZOVpoS0NE?=
 =?utf-8?B?eW5vaEc0eE9vVmtla0hqdjFOYWhvZzBZVS9IZnl6T1V1aHRlVkhkblA4NzN5?=
 =?utf-8?B?L0dwRE9IRGlQS2Z0UVdGUkFlUURZdHBEYU0wMCtYdnhYS3VES1d5a1E5Qnpn?=
 =?utf-8?B?dExxRjd6RDJwY1FiTThYZkpYNkxzUThYdmlIVDZrN0RtaHo3a1RndExBcHRC?=
 =?utf-8?B?dmI2U0tsMHRyaVpPRk96UUJ6OHNQeW9PWDBtSXUrSHAxNkovai9wWS9BWHcw?=
 =?utf-8?B?MVViMi96NjRWSFI0WGo0eDRCajdUZEk0VVc4NVgwUG9GeEpFck5rY1poc1JO?=
 =?utf-8?B?QUNXWGUzeEdpeW01b3kzZWNZVkdNMDBudjhNQnZUNGRRSXVtOTFieFNCNjAw?=
 =?utf-8?B?VzZzdzU0U2luWTQ5ZExtd1NOcWg4cmFlUHFXOWNBeTBXK1d2amxjZHFyOHhs?=
 =?utf-8?B?NHJlSCtJSUhBcGFvcm84aFpWNmVsVGJoRHRJZDI0RHh0YnRNa3Y0REpYQWdt?=
 =?utf-8?B?dlFybGVDNFEvU25HUkdCWDEwaTZCOGc1ekh5Y3h4aEo3UFBsaGduWHpqZEtx?=
 =?utf-8?B?MElYdExvckxDWnJBS2F1cDFUNStpSHc0QjN5VFVObzNrUXZlVjNHc0NERDJu?=
 =?utf-8?B?VVdYRngzRTB3Q1lnMWtwRURWRjJvVGF4eWh3anBJZk5DOXJrVmFlcG5xd1BX?=
 =?utf-8?B?V2o1bFZ4bVMzdEs0M01BM0lycTVWbzR5ckI3RmhRZU9CQ09oR01sK3NkM1Vu?=
 =?utf-8?B?NDZQWWJtakFMRWxrSnJSeGlLSnlRcXFhTWxybXFwSVI1bDgxTkxUTHBFWUJp?=
 =?utf-8?B?cWpWeDI3MTVCL0Y2UjFkbnlUOUJqWFhaVCtpZU43ZmJBY0w3bmtMaVdmVjVs?=
 =?utf-8?B?YlhxVVp2Z1FQbU1PZ1hJa3NNeVVrbUgzcmovd0Z5UWZlbjdsbGNoLzBhbE41?=
 =?utf-8?B?eForYzdwblRYbHJ6QjlTczgwQm5GWEN1SDhJblF0Znh1UDhOMXNaQ0U0aS9i?=
 =?utf-8?B?TGpaVVZVRXhIaU5JSWdnQ2xFUEVrTUlxWWRydkE5Z29SWjhyRmY3UkhoK0VE?=
 =?utf-8?B?bU1GREtHbGsyc3JNb1p1L2lBRFptK0RoOW5HODhRNU5oNXpWRjY5ZmZrSkpZ?=
 =?utf-8?B?c212RXBzZ1d0cnF5UkZTTTk5ZUpsdU9XUzI3VFo0KzM3ZEV0V0pqN3hyVVF5?=
 =?utf-8?B?K1cySE1nMVVOZEtqYWdsdEFZK2dhUTdHelE3N3Y1cmN1UWpIenpWNDhVR05p?=
 =?utf-8?B?ODBKQ0pYaUJzNC9YOXFXeEk4ZjdVTDYzQ3dObS8xbU5RTnRFL2FhOEwxTCtn?=
 =?utf-8?B?TUdGVE51bXk0dkZlNi9sendWUU9KeGREUGgxQUdNQ0tQQ1pPOE5xb1krYkNk?=
 =?utf-8?B?aitzVWdnQlZXbVVqZkpIM1FvRXJuRldoVDFoSkRDMDNVZXNuQXcweGptMDFQ?=
 =?utf-8?B?WVVwRVNvR3M3cFFEL2FIYStFdXVVVnNMZUg4ZEh2TSthNzB5NEdwdUk1dDM3?=
 =?utf-8?B?ZHdnOWIxc1NiODR6OVFZV0VuZDlqV2Nnc2lyVjVMdHdtK0VqdE1rSjRlOW9O?=
 =?utf-8?B?clhtdHV0aE5GNVoxUU9SMDNEQzZZblV1WXZsMzR2aXBueEJBT1FIa3JUNlFD?=
 =?utf-8?B?UFM1OXF6ZzJwcmRYREwyQVFjTnE2WXVnNmhESzY2S1ZsMzhQU1hKTzlUUDd4?=
 =?utf-8?B?QmU2RnozUEx5TlZBVk5mRFZhVWlKblp6elRvbEVWYW9Cd0Fpc2Jrd2RxY01C?=
 =?utf-8?B?dHQzKzRZZkgrOHc2TEVYY1VzWjBDdE8xRXV4R3lTemw1TVBkMlYyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e181a557-b7f8-4363-7fd7-08de7f6982d0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:27:07.7467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1mOT5hVDl9040U1Ef0c2bgFJyZxUzLZbgoG5j+v94NnUWL0svtNG5g7qSA1XmBB1EpnI9P7KmG0dvSlwDL8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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


On 11-03-2026 12:43 am, Christian König wrote:
> Well that was broken on multiple levels.
>
> First of all a lot of checks where placed at incorrect locations, especially if
where -> were
> the resume worker should run or not.
>
> Then a bunch of code was just mid-layering because of incorrect assignment who
> should do what.
>
> And finally comments explaining what happens instead of why.
>
> Just re-write it from scratch, that should at least fix some of the hangs we
> are seeing.
>
> Use RCU for the eviction fence pointer in the manager, the spinlock usage was
> mostly incorrect as well. Then finally remove all the nonsense checks and
> actually add them in the correct locations.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 213 ++++++------------
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  54 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  29 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
>   7 files changed, 112 insertions(+), 205 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 03814a23eb54..67b8c33d5ee3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2952,9 +2952,9 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>   	int idx;
>   
>   	if (fpriv && drm_dev_enter(dev, &idx)) {
> -		fpriv->evf_mgr.fd_closing = true;
> -		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>   		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>   		drm_dev_exit(idx);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 23d7d0b0d625..8fe9f91f9551 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -25,9 +25,6 @@
>   #include <drm/drm_exec.h>
>   #include "amdgpu.h"
>   
> -#define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_fence_mgr, name)
> -#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr)
> -
>   static const char *
>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>   {
> @@ -43,102 +40,14 @@ amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
>   	return ef->timeline_name;
>   }
>   
> -int
> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				    struct drm_exec *exec)
> -{
> -	struct amdgpu_eviction_fence *old_ef, *new_ef;
> -	struct drm_gem_object *obj;
> -	unsigned long index;
> -	int ret;
> -
> -	if (evf_mgr->ev_fence &&
> -	    !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
> -		return 0;
> -	/*
> -	 * Steps to replace eviction fence:
> -	 * * lock all objects in exec (caller)
> -	 * * create a new eviction fence
> -	 * * update new eviction fence in evf_mgr
> -	 * * attach the new eviction fence to BOs
> -	 * * release the old fence
> -	 * * unlock the objects (caller)
> -	 */
> -	new_ef = amdgpu_eviction_fence_create(evf_mgr);
> -	if (!new_ef) {
> -		DRM_ERROR("Failed to create new eviction fence\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* Update the eviction fence now */
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	old_ef = evf_mgr->ev_fence;
> -	evf_mgr->ev_fence = new_ef;
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> -
> -	/* Attach the new fence */
> -	drm_exec_for_each_locked_object(exec, index, obj) {
> -		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> -
> -		if (!bo)
> -			continue;
> -		ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
> -		if (ret) {
> -			DRM_ERROR("Failed to attch new eviction fence\n");
> -			goto free_err;
> -		}
> -	}
> -
> -	/* Free old fence */
> -	if (old_ef)
> -		dma_fence_put(&old_ef->base);
> -	return 0;
> -
> -free_err:
> -	kfree(new_ef);
> -	return ret;
> -}
> -
> -static void
> -amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
> -{
> -	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
> -	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
> -	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> -	struct amdgpu_eviction_fence *ev_fence;
> -
> -	mutex_lock(&uq_mgr->userq_mutex);
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	ev_fence = evf_mgr->ev_fence;
> -	if (ev_fence)
> -		dma_fence_get(&ev_fence->base);
> -	else
> -		goto unlock;
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> -
> -	amdgpu_userq_evict(uq_mgr, ev_fence);
> -
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -	dma_fence_put(&ev_fence->base);
> -	return;
> -
> -unlock:
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -}
> -
>   static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>   {
>   	struct amdgpu_eviction_fence_mgr *evf_mgr;
>   	struct amdgpu_eviction_fence *ev_fence;
>   
> -	if (!f)
> -		return true;
Isn't there a possibility of the fence being signaled or f to be NULL?
> -
>   	ev_fence = to_ev_fence(f);
>   	evf_mgr = ev_fence->evf_mgr;
> -
> -	schedule_delayed_work(&evf_mgr->suspend_work, 0);
> +	schedule_work(&evf_mgr->suspend_work);

We can avoid to use evf_mgr instead directly use ev_fence->evf_mgr as it 
is only one time usage.

Regards
Sunil Khatri

>   	return true;
>   }
>   
> @@ -148,22 +57,52 @@ static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>   	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
>   };
>   
> -void amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				  struct amdgpu_eviction_fence *ev_fence)
> +static void
> +amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>   {
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	dma_fence_signal(&ev_fence->base);
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> +	struct amdgpu_eviction_fence_mgr *evf_mgr =
> +		container_of(work, struct amdgpu_eviction_fence_mgr,
> +			     suspend_work);
> +	struct amdgpu_fpriv *fpriv =
> +		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct dma_fence *ev_fence;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> +	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
> +
> +	/*
> +	 * Signaling the eviction fence must be done while holding the
> +	 * userq_mutex. Otherwise we won't resume the queues before issuing the
> +	 * next fence.
> +	 */
> +	dma_fence_signal(ev_fence);
> +	dma_fence_put(ev_fence);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +}
> +
> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				 struct amdgpu_bo *bo)
> +{
> +	struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> +	struct dma_resv *resv = bo->tbo.base.resv;
> +
> +	dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
> +	dma_fence_put(ev_fence);
>   }
>   
> -struct amdgpu_eviction_fence *
> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +			 struct drm_exec *exec)
>   {
>   	struct amdgpu_eviction_fence *ev_fence;
> +	struct drm_gem_object *obj;
> +	unsigned long index;
>   
> +	/* Create and initialize a new eviction fence */
>   	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>   	if (!ev_fence)
> -		return NULL;
> +		return -ENOMEM;
>   
>   	ev_fence->evf_mgr = evf_mgr;
>   	get_task_comm(ev_fence->timeline_name, current);
> @@ -171,56 +110,22 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
>   			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
>   			 atomic_inc_return(&evf_mgr->ev_fence_seq));
> -	return ev_fence;
> -}
> -
> -void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
> -{
> -	struct amdgpu_eviction_fence *ev_fence;
> -
> -	/* Wait for any pending work to execute */
> -	flush_delayed_work(&evf_mgr->suspend_work);
> -
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	ev_fence = evf_mgr->ev_fence;
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> -
> -	if (!ev_fence)
> -		return;
> -
> -	dma_fence_wait(&ev_fence->base, false);
>   
> -	/* Last unref of ev_fence */
> -	dma_fence_put(&ev_fence->base);
> -}
> -
> -int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				 struct amdgpu_bo *bo)
> -{
> -	struct amdgpu_eviction_fence *ev_fence;
> -	struct dma_resv *resv = bo->tbo.base.resv;
> -	int ret;
> +	/* Remember it for newly added BOs */
> +	dma_fence_put(evf_mgr->ev_fence);
> +	evf_mgr->ev_fence = &ev_fence->base;
>   
> -	if (!resv)
> -		return 0;
> +	/* And add it to all existing BOs */
> +	drm_exec_for_each_locked_object(exec, index, obj) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>   
> -	ret = dma_resv_reserve_fences(resv, 1);
> -	if (ret) {
> -		DRM_DEBUG_DRIVER("Failed to resv fence space\n");
> -		return ret;
> +		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>   	}
> -
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	ev_fence = evf_mgr->ev_fence;
> -	if (ev_fence)
> -		dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_BOOKKEEP);
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> -
>   	return 0;
>   }
>   
> -void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				  struct amdgpu_bo *bo)
> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				 struct amdgpu_bo *bo)
>   {
>   	struct dma_fence *stub = dma_fence_get_stub();
>   
> @@ -229,13 +134,25 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>   	dma_fence_put(stub);
>   }
>   
> -int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   {
> -	/* This needs to be done one time per open */
>   	atomic_set(&evf_mgr->ev_fence_seq, 0);
>   	evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
> -	spin_lock_init(&evf_mgr->ev_fence_lock);
> +	evf_mgr->ev_fence = dma_fence_get_stub();
>   
> -	INIT_DELAYED_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
> -	return 0;
> +	INIT_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
> +}
> +
> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +	evf_mgr->shutdown = true;
> +	flush_work(&evf_mgr->suspend_work);
> +}
> +
> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +	dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
> +		       false);
> +	flush_work(&evf_mgr->suspend_work);
> +	dma_fence_put(evf_mgr->ev_fence);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index fcd867b7147d..527de3a23583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -25,6 +25,8 @@
>   #ifndef AMDGPU_EV_FENCE_H_
>   #define AMDGPU_EV_FENCE_H_
>   
> +#include <linux/dma-fence.h>
> +
>   struct amdgpu_eviction_fence {
>   	struct dma_fence base;
>   	spinlock_t	 lock;
> @@ -35,35 +37,35 @@ struct amdgpu_eviction_fence {
>   struct amdgpu_eviction_fence_mgr {
>   	u64			ev_fence_ctx;
>   	atomic_t		ev_fence_seq;
> -	spinlock_t		ev_fence_lock;
> -	struct amdgpu_eviction_fence *ev_fence;
> -	struct delayed_work	suspend_work;
> -	uint8_t fd_closing;
> -};
> -
> -/* Eviction fence helper functions */
> -struct amdgpu_eviction_fence *
> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
>   
> -void
> -amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr);
> -
> -int
> -amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -			     struct amdgpu_bo *bo);
> +	/*
> +	 * Only updated while holding the VM resv lock.
> +	 * Only signaled while holding the userq mutex.
> +	 */
> +	struct dma_fence __rcu	*ev_fence;
> +	struct work_struct	suspend_work;
> +	bool			shutdown;
> +};
>   
> -void
> -amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -			     struct amdgpu_bo *bo);
> +static inline struct dma_fence *
> +amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +	struct dma_fence *ev_fence;
>   
> -int
> -amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +	rcu_read_lock();
> +	ev_fence = dma_fence_get_rcu_safe(&evf_mgr->ev_fence);
> +	rcu_read_unlock();
> +	return ev_fence;
> +}
>   
> -void
> -amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -			     struct amdgpu_eviction_fence *ev_fence);
> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				 struct amdgpu_bo *bo);
> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +			 struct drm_exec *exec);
> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				 struct amdgpu_bo *bo);
> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>   
> -int
> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				    struct drm_exec *exec);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5c90de58cc28..e28abfd04867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -263,13 +263,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	else
>   		++bo_va->ref_count;
>   
> -	/* attach gfx eviction fence */
> -	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> -	if (r) {
> -		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> -		amdgpu_bo_unreserve(abo);
> -		return r;
> -	}
> +	amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>   	drm_exec_fini(&exec);
>   
>   	/* Validate and add eviction fence to DMABuf imports with dynamic
> @@ -337,7 +331,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>   	}
>   
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> -		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
> +		amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
>   
>   	bo_va = amdgpu_vm_bo_find(vm, bo);
>   	if (!bo_va || --bo_va->ref_count)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f69332eed051..f512b6ec6c53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1522,10 +1522,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   			 "Failed to init usermode queue manager (%d), use legacy workload submission only\n",
>   			 r);
>   
> -	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
> -	if (r)
> -		goto error_vm;
> -
> +	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>   
>   	file_priv->driver_priv = fpriv;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 85adc53eb523..67ba46851c2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -472,17 +472,16 @@ void
>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>   			     struct amdgpu_eviction_fence_mgr *evf_mgr)
>   {
> -	struct amdgpu_eviction_fence *ev_fence;
> +	struct dma_fence *ev_fence;
>   
>   retry:
>   	/* Flush any pending resume work to create ev_fence */
>   	flush_delayed_work(&uq_mgr->resume_work);
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
> -	spin_lock(&evf_mgr->ev_fence_lock);
> -	ev_fence = evf_mgr->ev_fence;
> -	spin_unlock(&evf_mgr->ev_fence_lock);
> -	if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
> +	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> +	if (dma_fence_is_signaled(ev_fence)) {
> +		dma_fence_put(ev_fence);
>   		mutex_unlock(&uq_mgr->userq_mutex);
>   		/*
>   		 * Looks like there was no pending resume work,
> @@ -491,6 +490,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>   		schedule_delayed_work(&uq_mgr->resume_work, 0);
>   		goto retry;
>   	}
> +	dma_fence_put(ev_fence);
>   }
>   
>   int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> @@ -1196,7 +1196,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   		dma_fence_wait(bo_va->last_pt_update, false);
>   	dma_fence_wait(vm->last_update, false);
>   
> -	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
> +	ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
>   	if (ret)
>   		drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
>   
> @@ -1216,11 +1216,13 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>   {
>   	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct dma_fence *ev_fence;
>   	int ret;
>   
> -	flush_delayed_work(&fpriv->evf_mgr.suspend_work);
> -
>   	mutex_lock(&uq_mgr->userq_mutex);
> +	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
> +	if (!dma_fence_is_signaled(ev_fence))
> +		goto unlock;
>   
>   	ret = amdgpu_userq_vm_validate(uq_mgr);
>   	if (ret) {
> @@ -1236,6 +1238,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>   
>   unlock:
>   	mutex_unlock(&uq_mgr->userq_mutex);
> +	dma_fence_put(ev_fence);
>   }
>   
>   static int
> @@ -1311,11 +1314,8 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>   }
>   
>   void
> -amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> -		   struct amdgpu_eviction_fence *ev_fence)
> +amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
>   {
> -	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> -	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	int ret;
>   
> @@ -1328,10 +1328,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>   	if (ret)
>   		dev_err(adev->dev, "Failed to evict userqueue\n");
>   
> -	/* Signal current eviction fence */
> -	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
> -
> -	if (!evf_mgr->fd_closing)
> +	if (schedule_resume)
>   		schedule_delayed_work(&uq_mgr->resume_work, 0);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 54e1997b3cc0..82306d489064 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -133,7 +133,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   				 struct amdgpu_userq_obj *userq_obj);
>   
>   void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> -			struct amdgpu_eviction_fence *ev_fence);
> +			bool schedule_resume);
>   
>   void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>   				  struct amdgpu_eviction_fence_mgr *evf_mgr);
