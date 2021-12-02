Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D0CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 08:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BBA36EA4E;
	Thu,  2 Dec 2021 08:10:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744D86EA51
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 08:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4Z+dBYSwlSLRC4qVOwlT6cn/Imc+pV+3XDV2wXKKbDAUAt2nCYraF6At+L7mZqEyS61+fkSUL9hNPpJf2akLgvzc6p5wBUD4PcDsqCwlEF2cSLCBs6EgaSWlbt+EpVKJeaVY7a+d62WgnPfo5bxkzuNsJwvTlYexo4FUfM8KdaJy+89W/uPGnuWVC34np7AgrN3Tzc0E5v+ACn5MBq7XSdFaeVoJhDlhxYMEUN/bnfF2yj/kjyjM96PyqN3/CZI9S3tVPsvTWQH8zkH7OqTYykgf2zYkoYhi84aBW8EIpheFzXAoPc++VnMbd6A1OD9wCaBqzY+wX4iQpOLUfDgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzGMEBtq/IDJCLUWRnNjJxuVN++gFrPVQkO9lyY3xAg=;
 b=EpbykgLn3XdnUg9PWxz920Qny/vms0PDwIHCv5jVUmCcNGYs30kHO9bM5rz9XCxLizO7scaZ1xvS/nIPLS8h73LS+s8g3wEyPBFpuuYBa3I0onIBedWvRQq0WIPe99t34ntcOpm8JxIB4oLxofe/lkUVp0ECnUyiWgeyHVPfBn7cL9kLGsSbYKhRlAuzuLfroAV6gjkLvWGweQY5+aOGyASpJk26HnY9FPdKOfP6RlKO5f351UTgCnvFAw8Dpg/jx7Fk6eHCN1rLorIpF/qi3Iy/Ag1W71av1GZrpu+EK5miJh3+ivfk4tKZ2/8uH3CdJKHfmtCpNKSpnJn3WtVosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzGMEBtq/IDJCLUWRnNjJxuVN++gFrPVQkO9lyY3xAg=;
 b=sl36rky/cn5DYsovT2MdoEZg61mwoJv/bp0qfRGC/7ZRzstCL45NsKI+bjnNITcMrJW9JGSrGHMwQnCzuZb+gvvqmb0N8efpVOe7XA+fyj4AW6b+BHj7cU4SFnxP1OKx9Wadz6AhRaES5xsJlttf99FZY0u/SvMRO8MxP3iJMQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2362.namprd12.prod.outlook.com
 (2603:10b6:907:e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 08:10:57 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.027; Thu, 2 Dec 2021
 08:10:56 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix null pointer access of BO
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202045512.5066-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c97ad6e0-45f1-c336-715a-c3b1c9887530@amd.com>
Date: Thu, 2 Dec 2021 09:10:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211202045512.5066-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR05CA0028.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::26) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (87.176.183.123) by
 AS9PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:20b:488::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Thu, 2 Dec 2021 08:10:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a943edb2-0070-4e46-3cc9-08d9b56b4490
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2362259FACECCEE0A084B5FF83699@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4v9hUI/Ac6zwpxdX2b90GHdX3IRzqK5Y4mtKfnpR6FQptLlGL66oamd/MZ3kN8aETnYb9DhWF5zbdroV0CL36EMg8xqkUGAN2MilsaTbQ9b9NnE+4LDyRpaUDefRUh0ackIzxfE7+tj9K6731V9w4gp7eQdMY9FZVy1l1JwBmING8sEAXrqGROjx4w1Vkq8nKGFIecCEPeza93mThj/6OW+U91ZPicCdQLQRtW+Ptc3ulQlCu3fHFUd/aJ8Q9uc+SCsXwpBnRpwYmNltGbfA/63ZoG4+m2h37kQ9z9auqPYMbOQ5Sjm42b7FuII27Dgh0sBXzDmtXyJlzkbuZTggC8uneC2IPuci2v1SK0ct6LntqqmUEbgIsS2slevINjSIFrmxjz0BE812Oja4NZnbJGs5P40VdhKpUirVFt89ALj9h/ZO2mp2Zj+axYrsZVY7hbWZmiSwpyLhcMATgdZAeEARDlGperCpeBquajZxZzG6fIv/cUv8PxWuJi4kkSIatb5frFnS9nDCON65DUwDgMiznQwRMAP0/uH2SxCR1+Q0o875qgFs4qOQVRrKssZb/aN5BktG2gQJGD+DiZ6q8KfwHYIAFH3Th17f/MU/NFjeA9GFI4ISf6kK3kf3H0CYKHzBwtgvCFVg+HZ/nwMy2Fczeo5eD7Fi02iY0RLI8JzuhpLbOgVxijSqGqbcqdMPauOBqvN/aesu/xtehrSdxYKHf01qEVJytmi//tgC5TQrE41zuB4N5CwUo9CxwjE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(8676002)(66946007)(316002)(66476007)(66556008)(956004)(38100700002)(6666004)(31696002)(8936002)(5660300002)(86362001)(508600001)(6486002)(4326008)(26005)(31686004)(186003)(83380400001)(36756003)(2906002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTQ2U2hCOTdOVExYTTdKTDE0RmJJRm54cnZSWGhsZHZrQXRQV1BlTFRkbXUx?=
 =?utf-8?B?TUs1R3ZZMTBkT3FzTzJCR3MrZjVmRWRCM3FUUHFjdVE2a1o3MjYyOFpWVmY5?=
 =?utf-8?B?Z1AwV0VwV1gwTFUydnllL25WMGMzZ3padlRIV0FGSzJZbGFNVU1KS1Z2eUs2?=
 =?utf-8?B?Q0VtSXAvaTVuVXlFWVNjRFNmeXcvbW5FRmFJd3pxUDlNWGk1SS9rODZKU0Vu?=
 =?utf-8?B?MmFvK3JYZDV3azVLdVNHSWlwMUU2bWgrWWQyL1pCVWd4YmtsRDJnK0pJdUsy?=
 =?utf-8?B?T2JDVUY2SU5YUnNGOXB1KzBsVEVUODFWMWU2UnZQMFdsT2VJZ2RBdnJLS0o5?=
 =?utf-8?B?aCthaDJwOEk0aEFubFlDRGw2SnYwcHlSM3J6RGlvOGRwU1AzajRXNHFxN2F4?=
 =?utf-8?B?dHNwR3A4cmZSaUw1c05OMVRKRjVQUmRkeiszK3FrSkI3b1c5ZWVrRFhEWXBH?=
 =?utf-8?B?dU9nbE90ajYwdU9GM0VYQXdpc0ZRZkpTQUY5OFNyRnJTRHR2YzNmeE9ib1Fm?=
 =?utf-8?B?d0VWaW1kRWdsMG0yOEpYSzkwSVdSb0t1TFM5UnUxS0ZMKzFUNFFTZUt2MjN4?=
 =?utf-8?B?VU51UlBHL1BBMWhaaURFcmR3NGRud21PMGVrSmhKQ2pod1BjSU9FcTNaa0No?=
 =?utf-8?B?dlhoa3kvZ2tSdGorS1ZqYUc2bjdzSkdhQllPNWxFYm9wU2pEYjJub2hKSVph?=
 =?utf-8?B?ZVBKcHp6ZzNaQUpES1NTYVNWNDZHM0NKdllyV3RVdnNWWnNBK0dzWkYyZDdi?=
 =?utf-8?B?NHFnWG1UQVhHMUlXU3dOSWlRc3B0MVFVZW81YnByUGJid0Nuc3htRU04Vkxh?=
 =?utf-8?B?dU9wZHNyR3VNcmdxVVRKd0RhZ2p5bmNSQSs3U0txYVA5SmcwNDRuS3VxNk1H?=
 =?utf-8?B?UWRyUHBWc2w2WnRoVDVUMHNvTjk4VXBJZ2EvclNxamNsdGl3ci9OREVDaVNq?=
 =?utf-8?B?MEdxWjBDbHBCOUFITUlENEpldHcxTXc5cVJBYmE4dnJDVDJ1TVBYRmw2MDQw?=
 =?utf-8?B?NzlWSkRYdzZVeXJnZlN4L1lKUzBSQnZQN25RWlJmbXlYclEvc2VnWVZGYVZ2?=
 =?utf-8?B?b3dtbzNHUjcrZ0xqU1FWOGltSTF6NXpvWFdDNk94VVpZbU9jNGdTdkRIRUFt?=
 =?utf-8?B?V3EzV1ZTcm1TcGlXYzlVbkxjNkNYSUxCbHgzaWtKMWlRdXRNNTZHeWhGYi9z?=
 =?utf-8?B?azlSSnVsY04zc1kzeVM4bU9IRGlxV1FnVENWM3RqcWlZd0g4cFBaMkU0Q0tm?=
 =?utf-8?B?ZXdmZTQ2d1VKdE5TUHZ4enZJQnlIdjhCZ3lmSmRYTHNSaGdGb055Yjd0Tjc3?=
 =?utf-8?B?Z2pIUE1PcVhlTTRLaFBpbis1dWVvT3EyZ2s3dkE4OGo3a3ByamZUWWlNSTE2?=
 =?utf-8?B?MzByUVRCbUdMQUUxbGkyMnZDUHBMOWF5NmFFbUVFOU5PNW1SYnBOSE9OZW5F?=
 =?utf-8?B?VUNvcmRiR0N6K0NxUEhkRzZ0aUxmeWdsZUV0RmUvaG5sYmloNFBmVzVrSnhr?=
 =?utf-8?B?UTBGQW5DZmxrNGN3YnBEYWNoK1RNL05PT1QvUGw4M05kaXpEdS8zTUxRYkxI?=
 =?utf-8?B?WWNwTEhUUExiYkVKRXY1TnBQVllBRFE3UTdqM0p5bE9HVHdrT2pmYkxHanZs?=
 =?utf-8?B?amp1QVpQV2JERTdxUjdmWGJIYVZaY3RvbjJYVXF2U3BPR1JGNzZqUk9BVFRw?=
 =?utf-8?B?WUR6Z1ZjOUFzVENKRnZGMGR3MmpleUtLWHRvTytvOWdZRlNjTlZlVHJFOUxv?=
 =?utf-8?B?Y2loWmc4YXpwQmJrUHpIWlZId3hkaUtaQ0tMYTg1K05Zb3VadFZ6QWY1bFBH?=
 =?utf-8?B?YXR4ZVNieWtXdTcwQURaN1J2R3BCTm1selRMSGNYZzBuUm1BM2h0L05iNnBL?=
 =?utf-8?B?QkpEY0czamxnRWpLY3FkTXRnOCtmeWs5Y0xXQTN4NjZCcEhLWlpSaHBocGVi?=
 =?utf-8?B?NTBJTTdwbTRFRmlWZVZVQUM3a0oySlNwMDAzRjY0QVlDZ1p3NE5CZEh2MWxZ?=
 =?utf-8?B?R3JvbUFISnUveUhJKzZKT21kbEJXTkhxUkFMdlNqMENVRWVvTDljSmNMZE9L?=
 =?utf-8?B?UmhEZkY5ZkQ2enNWS2lqcmZFcFVNZ3ZmQUZENll5WXNEVGlOaHZCa1RzYlQ4?=
 =?utf-8?Q?71+k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a943edb2-0070-4e46-3cc9-08d9b56b4490
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 08:10:56.7786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMLDKsruyKl3BAdUvMjhtEgGbYf46W9dr/GiUvgOd5TSkGQ+CGEK6iLidpqo2Ebc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
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
Cc: alexander.deucher@amd.com, tao.zhou1@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.12.21 um 05:55 schrieb xinhui pan:
> TTM want bo->resource to be valid during BO's life.
> But ttm_bo_mem_space might fail and bo->resource point to NULL. Many code
> touch bo->resource and hit panic then.
>
> As old and new mem might overlap, move ttm_resource_free after
> ttm_bo_mem_space is not an option.
> We could assign one sysmem node to BO to make bo->resource valid.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index c4317343967f..697fac0b82a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -359,6 +359,7 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
> +	struct ttm_resource *tmp_res;
>   	unsigned int i;
>   	int r;
>   
> @@ -380,17 +381,26 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>   	if (cpu_addr)
>   		amdgpu_bo_kunmap(*bo_ptr);
>   
> -	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
> +	/* Assign one sysmem node to BO as we want bo->resource to be valid. */
> +	amdgpu_bo_placement_from_domain(*bo_ptr, AMDGPU_GEM_DOMAIN_CPU);
> +	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> +			     &tmp_res, &ctx);
> +	if (r)
> +		goto error;
> +
> +	ttm_bo_move_null(&(*bo_ptr)->tbo, tmp_res);

That's much easier fixable if you just create the BO in the CPU domain 
in the first place.

E.g. modify the call to amdgpu_bo_create_reserved() above to use 
AMDGPU_GEM_DOMAIN_CPU instead of the provided one.

This way you can indeed move the ttm_resource_free() after the assignment.

Regards,
Christian.

>   
>   	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
>   		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
>   		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
>   	}
>   	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> -			     &(*bo_ptr)->tbo.resource, &ctx);
> +			     &tmp_res, &ctx);
>   	if (r)
>   		goto error;
>   
> +	ttm_bo_move_null(&(*bo_ptr)->tbo, tmp_res);
> +
>   	if (cpu_addr) {
>   		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
>   		if (r)

