Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD44C36014
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 03:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F6610E8F1;
	Thu,  3 Apr 2025 03:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TL1NYfKO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AADD10E8F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 03:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbFzylo3JtNxhYI1KMb7VbY5k55vHzhG56AnzU5oi9vSjhmNDr+lCNS/rLNGOpELzHcd1Zbr/+62heqPyQeedDfYwOJkuOqglxxif55Z/nzwZ7WCIurBEE5c965XsoNwNuZwrdEEemx2eRFWzub/1/WZhAJ5BDeIhJrwkafFiuOxfBePMjIqRQBc3SNUQQYfAu9htVzoooX5cuPkTy5ct+HbTmTFWL7+5xh1e2e9Yow2d+0nnXV+A09FXQWqzmFS5StbuLEnRA+ODJFJhpQM8/srntjZms1FOPIQYxnoRwxmS9o/ozrplPOMPBiSWMZdA7OpSMGtjuUkMX+dwhJwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5450UQoKPIrgl/MMMYPegS6vQ49qSHaHv+dG9kCJK4=;
 b=GXEPyV0l1slIZSfgfcqWs7foltNingwV29Wa55ltYpCo7FfuXdvutWmUUlW0tgz4BKgVf2pjoMYzNPPVCiEtbgLnafs+U/H/bDaaaLR4DlWl782SWEaTqL5AnSuxbhYw5BXkBYLuowULje6JDqKRO5W4uhodxK/1uySwzQgirlEM7lhB7G9O9JchX7LB8NfvapCwjKjfUJPe7HlIjw+7QL+39WmqA0PrQqoobO05HvzGLCSfyW1ltYU45Ay4q2fQlxMSB3RjBg7vssNMU4uPYdnLK/nRolHA9K/X6Wkc1Oistc5/2tzCtmpxWj03efGuELB0ryTRJjuMwjBdTukzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5450UQoKPIrgl/MMMYPegS6vQ49qSHaHv+dG9kCJK4=;
 b=TL1NYfKOH5dvWXqGm77jQh6/Wgc3cQ5zRn/1lOxE2kwskyLnP2vc2pxlM3BG08kpBKNc44ilad8wlaz5CUtlgf2QwanfwtcpETMflXjzREwEWbhZE6GjRhFOzS1pMZ06873t5RUhy+asH/VXI+W5Guk4/Q6MhDNSadmBFRMelQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 03:15:59 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 03:15:59 +0000
Message-ID: <9cb453c9-0ece-44d8-8bc7-6221aed0c059@amd.com>
Date: Thu, 3 Apr 2025 08:45:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250402140213.13455-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250402140213.13455-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c184aff-aa95-43ed-dd5a-08dd725ddb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bms3MUpDYXA3eUhHVkZEWUgzVUhYbVpJT2l3UW84eVdteSt5M2ZTNmRLSlBV?=
 =?utf-8?B?Ni81cFZralNvWnA4VGxNRk1GVEp4aldaNnUyajNlRnllcC9YN05aL2VGZlhp?=
 =?utf-8?B?TGswaS91WUQ5bFpmMk4xM2E2VW0vbEIzR1hXa0xJR0VreVcydjI4Qjh1dlRj?=
 =?utf-8?B?Tm4zTWFGWHk3RmlTaXdqNHd2UkFKWnQ4eVI0QTNSRFU1T25YbzhjVkx3SS93?=
 =?utf-8?B?ZGhzS2hNV2RlcCt6anh4OVMrRVFzanNjYTByQitJcThYcFhxQzJZSXVvSkds?=
 =?utf-8?B?RGNnazg5aTVuM3BFNTY4UXd5UDEySGU0d3dkSTVGcFgxeWIyYWJEUTc2a3RZ?=
 =?utf-8?B?RDdCWUVxL0FnUHAxOGFpeEhqbkNtUUsrQmNGMzhoVDBOQ2FBZ1Nvbk9FWEFH?=
 =?utf-8?B?YndtQ1pwY1BiSFF6Z2hUTGdUWkFIQjBLbWV4dXpFempkUGgvNU9udHRBRVpj?=
 =?utf-8?B?N1NXRVd5b1cwSlpoQzBnWVI0S2lqMTlSbGVLYTNoM0dheU1EWExJbEpsUHl5?=
 =?utf-8?B?NGIvc2RGSVJEK0syZ0tkMDlUcDJKRXFIc3ZmZFNKb0ZqdGtGRFF2c2NQQ3Vy?=
 =?utf-8?B?NlNuR2Q2dFRST3JNS1dBSG1ZY29FVWpxSUdVQ0lGTlBGdlptWlBtSEdIbmV1?=
 =?utf-8?B?LzJtY3VnMkVjTTR1WmRGT0F4NlN5MWdvb0tuSHcyNW40ZnBFdWlRSzN3SmI4?=
 =?utf-8?B?cWE5RnVBc0UzUW8wd1ZUT0lzSXoxKzZKK1hJTmdqREVWTzU2KzNPQXRxemM5?=
 =?utf-8?B?aC9Mek9lWEVETkIvZCtSNXNJSnlaT1JhZ1VCcHZxNFNscjE1UUM1d0ErWmh2?=
 =?utf-8?B?RzdiMTRGcU53Z1B5ZkdQZ3JCdFZ5ZnFQcjRJOWdKT1dPSGlvWjRmMXFmcHFw?=
 =?utf-8?B?cGVnczJRUDZPL0N3MkNrTVFubkl3V2JwWk4xejVIUE1jdng0Z3l2VjN2Z3Zz?=
 =?utf-8?B?cDZya2pVTXR4U3RsTXJDa0FpYjI4Wnd1Zlh6enluaUtVMXJxVmFlUFcvQUxh?=
 =?utf-8?B?c2tvVFVSeFFXQ0NkeHEvaTFNVWcyb092MVZZek5wam9LemJsMm9KMG1BQ2Vv?=
 =?utf-8?B?NjNEQTVOSU51UGNKOXZpejJmR2lWOHltYkFBRi81TjE2cENDNnBJMmJmWmZr?=
 =?utf-8?B?MU4xdysranA3WDVGVUpzM2FuNnVtTXNKVmFQUHQ3S1JkMFlFVEVKSHR1R0Yv?=
 =?utf-8?B?SVNDUXoyeTQyQ0IxN0MxcGdXOVRmMVpzWUNGWGJQQ0pWUHFwM29OSys2eVZD?=
 =?utf-8?B?K2FjSVlWZU1PZTlnMEZyRXVqVmk2dWd6Tk5GNHJxWVVzRUJPc3Y4bUdJQkZK?=
 =?utf-8?B?YWdqN0dDb2FuMkJLQnJGdFAwcCtUeS9rTFJlMDhVenNlTFIxMGNnNDV1TFZm?=
 =?utf-8?B?RlphaWk3UkFoejlONWVJWlMxcU8ySEt1VEJMdDZ0c2hEcXN3ZFRENzRwUDZ3?=
 =?utf-8?B?RkwrQlBoeTFFdkw2MDNkWFduVVZxbTV4VEp0SlhJdXp3eDdXVXdNYWNqencw?=
 =?utf-8?B?MVBPQzNieDdHUHhRakQ3Nmhpek5uSFQyUVluNmVuOWVoU0hDSHVIU0NYS2F4?=
 =?utf-8?B?b0VQM201MkExQ0tNQVY0OUJKYWsycDJ3NExqaDV1djdxMWdjeGgxMmwxZWs1?=
 =?utf-8?B?R0Q5T3JNU3NQZW4ySndKdFNYUjBBZXN0WkFpZXVoUWgvbmkwK0IvcE1RaGI2?=
 =?utf-8?B?ci93TE9UV2tOaC95NFcxbGRKSlMveUs4VzdxclFSMWtWQmU1d0JqNlM2V2l5?=
 =?utf-8?B?SW9SRSt2bHlNUGxNL3dqWWRpc3hoT2FkOHZiM2ZOZlZzK2pEUXQyMUxzUnkv?=
 =?utf-8?B?TFlsdEwra1NFek4zbm1LVllUOTVjMUE1eFJlUmJ0bWRBaWVrZmlYNlhEYXMy?=
 =?utf-8?Q?GHmCGvuPsovzc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWl3KzE4Q3FnWmw5SjBJMzZ3d3dFbS9vM0xXMWJPSzgvK3dkUnBwSGtPVDJT?=
 =?utf-8?B?ZDk0K21PUEZFQW5yRlVGb2RiN3hEQUFWTnVJMk1PRWdBTWdjRFpPUjRpQWYw?=
 =?utf-8?B?RGZFQ250SW9jT3RGaDJ0NS9XQVJ1alBHVmhHbHA3ZnhzTzg0KzlFMCt2Mzh2?=
 =?utf-8?B?cUNrOHU4cUVFeVNKTG8zSFNBRmFxT2JCTDlrZUJJTU5ZMWJoUHN0aFV1MkFS?=
 =?utf-8?B?Q3Z4N0VseVF3Yis3K25wYTFMRmdJcnZrSmFhN2NQc2lteTh2d2VIeFpRRlBW?=
 =?utf-8?B?SWJkWEs3bG1oWmpza2tqVEczUFZyaFduSFdhNzdmU0J2QkNRdXlqeE1pK0Yw?=
 =?utf-8?B?SldrczdXek1FUEgzcWhBQ2FsR1dRQkw5RHordnU2VjBxSHBGd1JpdGJsVjZW?=
 =?utf-8?B?ajFzQVd6ZW90TlJQb3N3Qm5uSEpDSEg0emR5Uk52Q2dtM0hzdDB6NmI4OTk4?=
 =?utf-8?B?S3RBMkE2SEZ4azFFQmE0eFhlaVNjUklQMW11Tmc2UVJMbmtlSGMxYUhSbVBY?=
 =?utf-8?B?MmtzM29Ib3NSbncyeGlObGtQYzJ2VDZvNHNOa0V5aDRXQUJ6Z3RGcTFtVlo5?=
 =?utf-8?B?MDhNSHdQY0c0ei9CV3QxYUx6d3crakNWdFVMeVE5MEdRb0JocDdRQUdTZ2Ru?=
 =?utf-8?B?c1FNZWFjayt5aUNWM1FzRmpqUVI5WFhGbko5U3poMkRMbThOM0ZoQXVBSnJJ?=
 =?utf-8?B?NGpkMlFpTUlwSTBhY1ZORTl4aUNWYTBreFNIbWtEMmg0amJibjREd0dHMFlo?=
 =?utf-8?B?dHBieXovVFlFK0FlMHhiSXRDOG5qWDhOUi94d1FETFhKdjQ4N2dWQWJULzYv?=
 =?utf-8?B?eXJEWE9ZMFlzcDJobkhuVm4vU2tDSTl0RllhYmNDYzgwaG5xdWpUUU56QlhE?=
 =?utf-8?B?MWVDN2FSZzNwYXltT2JZQ1h3cTVMYmU5ZE9BdGtaNURHSG1RV2c3Zm5yTm9u?=
 =?utf-8?B?eEJ0V0VvZG1HazF0L29OdE5mMDlmZ2o4eGpxOFVqNENuYzVKOU0wM1QrNXhN?=
 =?utf-8?B?ak5GRS95YmowRjdFb0xTWkgxdXFTc0lrRWgxWUZRR0ZJdjVmZ2JNRnlDTjcw?=
 =?utf-8?B?dlJWTU9tdmUzRHpWaDF2UjZiWjlQeEdza1c0U0dLWnRIR05rWFpETW4xNWZO?=
 =?utf-8?B?MGM2OE51ak1aVTNGTXljaEt6WHJHNEhyMEdEaDA0Z2FsUlBPNXJPRzFTdGlO?=
 =?utf-8?B?WjFPVHExbUhtWDcxR2pOUWZodjF6TklpSFQwcWFlamVHdjJhV2hWMElZOVp5?=
 =?utf-8?B?TUxCZnVyczR0VzZFSXIzVWtrVHJJV1lOcld6ei9PS2lqUk9ySnFDQUU4aTFa?=
 =?utf-8?B?OVpORjdqMXl5Ukl2YVZGSjNSRHArdFJIUHBxMjNlcGVFY1RmdjYxSjIvZnZH?=
 =?utf-8?B?bjVjU0dPc1phV1JnWjlRZnB5ZGpYMTk2NzZacDIvRytkakxZd0VNamlqV1Yr?=
 =?utf-8?B?bzJHUUg3WEszQmFMdkQ5Y1cwcWpQanFrMk5PckQ2eFg5VFUzSUk4L0RZR2w0?=
 =?utf-8?B?YVVtbEhITWdFbFAwSjZoVGozMGNHcnJGb25IYjBFUE9tZ0tHdG9aVmtmTW1W?=
 =?utf-8?B?N0hnWTZocW0wQjQ2dGFsOUhTc0xlRW5sYk15UzZac1J5WnNDU3JaWXFadnhF?=
 =?utf-8?B?Q1R2SC9RWnptUWFXT2hIZ3VodW10WjFIM0c1Y3dIcURyZlFZUnZrT1ZicHFm?=
 =?utf-8?B?ZUdmaURJTVgySjg2ZjZVTVU3ZE1VUVdGa3gxME5wS1dVT2tjSHZWUEkvNXhW?=
 =?utf-8?B?Q2ZRblJ0OEFwMHFrWHVOQnFBMWYzOVNhTDYrc2hVcTExbjk5VE5sbnFBTExk?=
 =?utf-8?B?WkFhMEN3RERpZllTWUdocDBpNXlJQ1orbUpkMUFFdWlaWlR2S3NEV0pqdFpv?=
 =?utf-8?B?RnVZcVRaeitaenZtNmg4NDhRb2V3L1ZUYVB1OW1sM0VnM091TEtzSVdCU0hP?=
 =?utf-8?B?RFY4QVRYN1hHSi81T1FDRExSSUJOWU0vcHlldW92YmZFamtVYlk4SmdSeC9k?=
 =?utf-8?B?akYrRjloNk1CVTFnNHBnZG9wNTkzV1c5WVRQRVZqdXlvN3BsQ1ROSmk4MWk1?=
 =?utf-8?B?eGdocTg5OTBuTmRxdk1vbVBMVE9zeTFJdzIyeWFrcnVMT21EOHhOM0t6VFh1?=
 =?utf-8?Q?k2uhHJ23V4Ryrm26EXszMeywS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c184aff-aa95-43ed-dd5a-08dd725ddb21
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 03:15:59.4248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp6zqbEgX5ChbiD0Zal5+bAs6tXWUI+7wOzapXtd7hLhKg6Fai6M8xlnuDPwIqjB2esXHTLuUhvX3Sve+ZfLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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


On 4/2/2025 7:32 PM, Christian König wrote:
> Otherwise triggering sysfs multiple times without other submissions in
> between only runs the shader once.
>
> v2: add some comment
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f64675b2ab75..9a24be43e035 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1439,9 +1439,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   	struct drm_gpu_scheduler *sched = &ring->sched;
>   	struct drm_sched_entity entity;
> +	static atomic_t counter;
>   	struct dma_fence *f;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> +	void * owner;
>   	int i, r;
>   
>   	/* Initialize the scheduler entity */
> @@ -1452,9 +1454,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   		goto err;
>   	}
>   
> -	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
> -				     64, 0,
> -				     &job);
> +	/*
> +	 * Use some unique dummy value as the owner to make sure we execute
> +	 * the cleaner shader on each submission. The value just need to change
> +	 * for each submission and is otherwise meaningless.
> +	 */
> +	owner = (unsigned long)atomic_inc_return(&counter),

Should this "atomic_inc_return()" needs to be casted to (void*), as it 
is return type is int?

Regards,
Srini

> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> +				     64, 0, &job);
>   	if (r)
>   		goto err;
>   
