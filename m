Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53176EFCBBB
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 07:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D7810E314;
	Mon, 16 Mar 2026 07:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQXtfwB3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE1810E308
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 07:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDYSOx8xRc11tQr8IkGMq5NjuWJukanuxmCzSQFm9dFWngra725ckolm51jmVqgpXdSx0+1nPwNCsaXw7Gr3YkVix9xrDQtYyk4Fu68ixQNmYBbs5casxc4+/jI70FXZuH7tQieRupEUr+bz16yRHhutnBoQxZcc4VlRR4sblLtB5Xcs5Dy2wGI0t7VT3k62y4RKg2EGEwE7w35D7YalN1FRL110d9pQ0MKd2vKS1zIa/Ndhy6UZTKwOEH5QsYMDg+bvC72KyJm8Iw9ofE0EACsUc/1ecdQWyybGEt0fytN5jB16Ks4QGoK35k4aWMaaVg7CNW3K3p433p6cFPbImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njI/OFLPBs8mrmYrmXWvKdZnvpHaTUsx4pioxPmdcEI=;
 b=fx1h3v969GeL83YmkGmjGoHtjYwPdgQULP9mDK+mtGCokyX9XdQBgCsSIbxVcpHNS7X4qHllz2kExpyHTS1Zae/tWafe/WtUZ8UxzcarUp1mNKxRcwPmQQcOL468Ao5eYcJyXgfnYQ6BYA9sTV8kB6qicJzc4m3urEhsxGPAXpQhnGtsYH7JL1T6RnX6zeidVNsFAzc8JjkLfvaVm2f8oVmlsJpB3qQe+7xCniELi5peDBoBbF/reNQmOq4Qk6UzNZcDOTpF//n3LI6+Z+GcziDiiUfSe5HVGVfQJZ4cqckhWF2TSRKVq2Cz8pQWu7Ad9HiFf/oECJceO/Uv3/Of4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njI/OFLPBs8mrmYrmXWvKdZnvpHaTUsx4pioxPmdcEI=;
 b=WQXtfwB3+n2n1RMcmpkDQRRtoA5YmrlYx5FkQEM5S2PPb35n1S/HvhPj8Nl0vldo/QUVPtnHgePhovUvSutnBpuOSTEK6O/czWdhZWda56S/rxC/P5vCAmDEtUJpHprk12Kk6ozRHdenuWqPxJ5+9tSzCKTUKzx43sa+wXKIINA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:08:26 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 07:08:26 +0000
Message-ID: <43b8ce2d-ebbb-40dd-bd68-c997fb54af1f@amd.com>
Date: Mon, 16 Mar 2026 12:38:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Drop redundant queue NULL check in hang
 detect worker
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <Jesse.Zhang@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260315071324.1933271-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260315071324.1933271-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0170.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 826f4fd6-5812-45ef-5441-08de832ad133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: /1UuRd/OiLLa6iMOqbEmlsfcDnI7bptwC77+Sm93x/6+jjRAOhF0ivj/GiMk8H2hLOJb7vWhRErVMM0W7h4DZv31I0vLYBwk0RAZ+SSv0fLbTwgFBjqlg0gaB36vtnmg57zZlu/xC72Lt6vo0KaVw9oXzTNH0baz7QAHwFRRsjLhrUwISLwzrzmXMemfXTpHFD8nZnP1rk+UN5ZKKzMmHdjeZ8BOIQZuUXTPTB4V+fC3Osfam0BhVNLGB/QoZw5XZnZbqLL+8vq4Pr9xi0YAoVdY4kI+68Jy4bGSD1nO6Yq4s1woeDw4pspvGklxefBPnZB4J2RUgZ7lsd2L0mz6CD2mgNIpmxWnTFU0a+HWwXypkIUIrY8GJGqiTfsKZ3jCffbbar7plDqku+UvaJYgN0fsGmzXt7pDKNQ4/eqRs0XtwttbJfUO6QUAYHyPjdB6FJBHvvBJpGkRE4zM7L2WdfxW3EkKyDF4C+48SVb8025X3wWw+ycygLHS1QxqccfcDFqTshW6gEG+onjwayyD1cRzuTAtEYhQKbkxyF8jaqrJFLtOgnFWl/ZLaycuRzm0iqd/UdgiDbcxvs6pawDS94bP/jfIoyDy2aZWv6Av7KrzZfZKqStypQ9RyU6b/S5L14PkMFBxXX/+wbDCBIvFoT2aGs7+N3H3ckWfc6pstvyX17rqav/93xoWICtw9S6ryt3acyc7aSA5ANcl6TuM5cbDS8w0a7jDqAVuNwbGSJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBJZUY5cStsZ1FZUWU4NjArT1NwZWVyYVM3RUpseUo0TUp6d293ZzhwVkc5?=
 =?utf-8?B?WmlnOWo4ek1jMGlXenl3TzdJaWVBV0YrQ1lZNndLcDlKRnkrRVpYUXlKNWhZ?=
 =?utf-8?B?OUJFRTNnZHBLQy8zR1hPdC9KSzdDUEwyekJ0TStHMUxoV2NJWHBnQjc3cmtF?=
 =?utf-8?B?bXFPTlI4RE1GOFFlQXFaSThtdVV0NG5RdWVyRkdndVJ1ak41ZGovbmk0L2dX?=
 =?utf-8?B?OFhrQlI1eDFhZC9BNmpxcDBXNVpSNXFvbndZV0h1Y3lUNlMvZEVZSHZQS2tU?=
 =?utf-8?B?TWUzbm81eE0zRklYdXlYdWtwR2JvVENwNjdYZVU3NkwweHBLOWxvQ2JnL2xx?=
 =?utf-8?B?R0pOTnlnNm1mNncxeFdkQkxiVzdobFpGZ2dnT3oxNlJvWDY5eHZrY0xLb2wz?=
 =?utf-8?B?d2NSUmZMMmpSNkFMSXp2SDNQcDIzdUdBNGxrcVFCTFliamMrS3VJb1B2MUh2?=
 =?utf-8?B?RWl6QVYwd295NklkaThURkQ2Vm1semhWR1JSak5KSWYyT1ZBN3BwQ013TUtv?=
 =?utf-8?B?SFJiMUZmWnBVMXhtb0tFczVrZUczdGpsSlgrb0VpRnF5Z2NYd2swRWVmTllW?=
 =?utf-8?B?d0JRbE9jVHpDRmoyOHJqcnJzK1VuUG9qMkRPKzVWZWx5bUNPNmU1UjdGZFQz?=
 =?utf-8?B?ck56aUNIWEVLTlhEczZVOXR6OHZacDlXdXdvSUp1Zk5UTUxERmxYeG9xMUR4?=
 =?utf-8?B?VWJJRTVTRTJiTndRa3RHdE5adUFZU0pEaElFZHFiSlBweHpGQVRlT3QvcVN1?=
 =?utf-8?B?aHAwbUpxVXlFTlVBY1gzanZzakN4Yy9tNUM0WTZERmN3UUNTc2h0MHBQVE52?=
 =?utf-8?B?VzY1Z1REZWJDVzR1a0trbWlNdm1uRFY3eUZRblJzZy9sRUh5UDA4eHRLUUJQ?=
 =?utf-8?B?eDFWYVJ2OUxhYzgyYjY1VGt5aTJxR0JiVk83bzRoZ3BDOTc1ZjNabFJVNnQ5?=
 =?utf-8?B?a3krenpPcHNxN1JvZFpyZGxFUEsxVXBNdDk1bTkrdUM5NG5Ed2tVVTdubnRU?=
 =?utf-8?B?U3hIOXUwd0ZIVUdqMWNqNWZ1elNKRzJzVUZHVTh2VG1oampRMnJ5b2crM2pu?=
 =?utf-8?B?cHFUQmdSY1I2K1NzVG9iaTMyVXFGQk8rTDliNVRGeUtzQWNZZzg3enhQQ1ZN?=
 =?utf-8?B?R3JIMmR1N2d2d0Q5czkrVnRrZ0p0VjRXdUljS3E1RytHQjFkcTg5SWo2dW4x?=
 =?utf-8?B?Zmp5NklPQloxZDJqZUlzZ2JwY1lpZ0Y0M0FXWlZzMDJpVk5BTTRMTWpoM0FP?=
 =?utf-8?B?cmltbC80OFg4VlVISEEwSCsyTm5XVzJvWFYxNVNTVndpaGQ1OUxkZlErN2E2?=
 =?utf-8?B?ZlpyVmdUSGNsQlFTbElPNXZtYkFmM1VGTStkcEVibnNOaXVzK3hqSnAyOFEx?=
 =?utf-8?B?cStVc0R0VkVzWG12ci8xblpWTUNua0QwYXFSY0hLKy8yZW9aTXpRVlhWYXpP?=
 =?utf-8?B?SGhXN2k3SGZ5VWdmYTJCc3RsMk4ycExNRFBvUldETWFSako3N0p6V3IvUVZH?=
 =?utf-8?B?MitabFJQclBrVm55RjlhK2o1b09lWUhNWGZ5NkJlcmp1Tmo2UHIyRnhWSlBp?=
 =?utf-8?B?dEF5Z3BraVFodTVaNUswNlNwOFdBMDBjQkIvZmVvbW9Uc2REQXZBNlRXTjZo?=
 =?utf-8?B?YUYwQWUvU2taY0lmQkcxM0Z2cmtra1dpdUpOM2NPcStUak5tVnR3bHc1S2tO?=
 =?utf-8?B?MHdSc29iN0FuWUtlbUtHZGhWNWRHMUNybW5NOGJSbkZtMWdWcm1CRzRVMml2?=
 =?utf-8?B?MXBTM0ZJcTY0TVA1cVJFbVNEelg0dC9Qc0JaYjNxQ2hmNXJPNkMxME1VN1ds?=
 =?utf-8?B?TnkxL1pzNVdaamdVM1lHbUl6K1Bjb2VvNkE0Y1BtYm9JREFLaDRyeEQwd2lz?=
 =?utf-8?B?ejk4V1IwODdpZUZwSloyUENZVmY0c1I4MFRmcTA2M2ZUeUM5MFZqOTJrSHkx?=
 =?utf-8?B?RGFINXZGZVNSZWJJUmpKVUdZaHFsc3RJdi9ha0V0RnZDdHd1b3ZZbWhMZnRO?=
 =?utf-8?B?SXJ2RE9ub29BVzhMd091QWtqRHYvczZ0REpqMUNZVGpYWEFhK1cwWjRqZ2kv?=
 =?utf-8?B?MHhmVW5JQzZIN2dJeHlpRUpTcVF5dEY4R0oraUR2dmlxOTVjaGkyZjdVUmFP?=
 =?utf-8?B?NmErd0dyK3J0Qi9WdGZLQ2xHUGxaMVFIeHRXdFJXdEx3S2ZRMHJCczNFbDNk?=
 =?utf-8?B?a05NTWphUCsyZ01tUVNTUjgxU2hYUVFRS2VxSVFKb3JLT2N3ZW53cWJaSFpC?=
 =?utf-8?B?d3VjWldQM1oxKzFpaVJJUjlxNG9RMmU0bEdJellCSmIvcEg2MXEvOXRCQVdk?=
 =?utf-8?B?cnlIdE5uc1lNYjlYUVdabEZiRzdoRkF3bUJwVktRT1N4TEl1b3FKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826f4fd6-5812-45ef-5441-08de832ad133
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 07:08:26.2803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFAFW9JTvFSTPTaMbDc5yevLFMz2rb4Sixmuzm/HHnjF1poBR1B+crN6OmZD7WqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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



On 15-Mar-26 12:43 PM, Srinivasan Shanmugam wrote:
> amdgpu_userq_hang_detect_work() retrieves the queue pointer using
> container_of() from the embedded work item.
> 
> Since the work structure is part of struct amdgpu_usermode_queue,
> the returned queue pointer cannot be NULL in normal execution.
> 
> Remove the redundant !queue check and keep the validation for
> queue->userq_mgr.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:159 amdgpu_userq_hang_detect_work() warn: can 'queue' even be NULL?
> 
> Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cd599b4a9d75..6e0c366f3f00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -156,7 +156,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   	struct dma_fence *fence;
>   	struct amdgpu_userq_mgr *uq_mgr;
>   
> -	if (!queue || !queue->userq_mgr)
> +	if (!queue->userq_mgr)
>   		return;
>   
>   	uq_mgr = queue->userq_mgr;

