Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 08:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EB06109F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 08:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45EB06109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26B86E8DF;
	Wed, 20 Oct 2021 08:50:47 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441BA6E8DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 08:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX+gMzEjan6Z30cjiyQbNwkyTxBnOyTGWBxVhyEsCnh1HxD2H3bvFZ+qAGb2j0yKtkgxnmZGSRdFaL9zxXwDsfWAoyly6mKEpV2CRpH122sBzvnG8orbPB6NpocJR4crzBllVi0k5EPmo6eOa5iEAWnFxUMn9S73rDC4YtP9iPps8MbXKA78PMaWv20gO3HzFQ+MD8hna/HCZLVBF4WqqZ2b6F3xUUD0nK8gWKcCoJ5Rrcnsjwu3CLRuEBOZDwGVxBuz+mF1VNy1MGk92Hmhmfph4QGzr+NnMXNH97RrcHDlncALMJztCno4Bx3JarfIctEm0JSzg+dViX3uzFbmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5HTPg13nBMQ8pE1Hg2dVk8DmCIPtYF4RpyTRe0ymy8=;
 b=db+t2EDI8E/l1N8rIlQLLGKCedA5bC6R7fi1E96qUoeOHK/MYhPK6OZ8BCEHWSIatzw8Xpyt14G9+yFcENs19Z2x0T/gP6UavuTn8ftNrmrof6MR+n9zRFes9x1qvWjLzcW2mFAJJk/SrupKhM1v1vm+8KNE9nH+Ps7ez2lop6eN9tFLa+YNgmR86gfIx7PeWMjSVJlX3Y+cniE5eFRkSe2+q96s89QLyCLGbE3qL1ST1cByo87qIYw/mnVKldx6Oswt/96EzDKB5RY/QzXOnzyzN8nEytGBM+yPQ4aYACjR1jmNpFkElXoaLH0/6kINsnLXQzwZW0SPqsw5IGnpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5HTPg13nBMQ8pE1Hg2dVk8DmCIPtYF4RpyTRe0ymy8=;
 b=SJfdPD9bmmh9l4WxjVtvSww6Ey02tmI2+faIUUC0+kzhq6pMYTKK9bF6J8s0TjQ/qJ6l6I+m8lN2wSPank5b9qLoSBldmFugOdaH8S/vwaWVThb3Mdwh5xC+aeaGgtvmHLEXHWdi8kz/dTWNKUL7O1sKNAsWma/q5zz8++66J30=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 08:50:44 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 08:50:44 +0000
Message-ID: <9904886f-e177-80fb-4477-54819f5b0f53@amd.com>
Date: Wed, 20 Oct 2021 10:50:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <20211013150902.6646-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0161.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::16) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AS8PR04CA0161.eurprd04.prod.outlook.com (2603:10a6:20b:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 08:50:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2202edaa-05a5-42a1-edcf-08d993a6b3cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5118C3B7382DE39ECCE36B858BBE9@DM4PR12MB5118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HN8rvm07tJShuhwJF3MfXYbKt1vmwBbTjSUcG5uHdIzMzhU/XFJGhlPet6kd1pVzltLiyE4/ntxTFWvbLc5t//+pugeidp2ReudU3UXvFjCmJ1h35g2sZNLMypH8buHDLCvvcg2l/YtYn2VhLM+2Hs2VEV/ud5nBEctmCPjm4yJX/LjTu5NKMMTTTN0vmvzzHOncRwwB7qaHvfKDjS0VHprqRFF/+1Qh4YcQpBj9i+ni2ltbQY9dcyhINFfsFZnpBMQKziK1aWK0h4uShMNZD8Pgl5B0t+M197OOehKaW5u2+FNvop8YIT3RampShLPcr6aVQQ/4KSkeJWSuWTYV1iGBd1eaJekhtUa1IT2/rN5nthqdhmQVqPx1Gcdgaqp+49yTwhoM5OcJWTBGBx8ImF1J0eFxFbkKK0Ri5baEbMQqAFSFMgJE1LPlfHQohPhEppSETceOPqNwk2rtZPdPtrX97t3nW+WPO3reTiKJNmnLyKDc32vlhI8Fb+SM72nOBLZQ8kj/MB0Btk6LKF0aQa33M6V5Vg6kyra+iGQf88/JpmHgapCsH1pJxmsv4zIZo+8g+Sbz2oPgObaxxPcg8QEmHfIWBVzps0P/Lg59SsZGA2dUEgp6QDzpLBSqTUp3d7FLrdJIve21hxnv/yj0xJ4fBePZd3F2Fi4kl9CuXG9O8ofup3aK3kbTQGaJMNmXz44zSsXC8hyGy3ey9950tXJoNLO4u8yT1wIjIhO5R7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(6666004)(956004)(316002)(508600001)(8676002)(16576012)(83380400001)(66946007)(31696002)(36756003)(66476007)(66556008)(31686004)(186003)(6916009)(86362001)(5660300002)(53546011)(38100700002)(2906002)(8936002)(4326008)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUg5YWkwVlRXd2YyT3lXdEMzZDJxSHJZZFZZa3phVk1weGRERVpYN3ZwRlJi?=
 =?utf-8?B?RlMrMjJPSnFNd09mZzU4Y2JCU1FrS2VhdHp2SUdnOE5Hb0JsOHJLUXNjb3Fh?=
 =?utf-8?B?cXF5WlREK09SR2kzYXh3WERvOHpNb214NzBwQWlJL3VuMWpaU0YzV3RYVlVF?=
 =?utf-8?B?eFo1NFhCT3RQTEVFZ0tWdURsNkR5Y3hNTGZCUUZwQVpEVWhVOEsyRE9HYUJF?=
 =?utf-8?B?bkt2U0pxVk5yNUxqdDcyVGUvdG1Wa2RvTy9ncjgxQ3NQeEZ1SHZBR2VkZ0tV?=
 =?utf-8?B?aU1nckVuYk9KWGVIM2RubVpsYzNRZGZJV0V3NEJReFY4TG1kbUUxWFU2b2hm?=
 =?utf-8?B?M1drSHdTRjd2UmliQkRPTVcyRnBQbi93aHVFQzJ0Z0JDWTE0b3MyOUJGSHdC?=
 =?utf-8?B?a0lGUUxaM0ZVeVhuc1VnWE93THNxb1hZNUZiR0hlb2dIbnlhRCs5SVY2NURP?=
 =?utf-8?B?UmlRRHYza0JIRHNLaHJnUHR5UDhWTjdNcHJHWUF0RHJHK2xzVU5KckpWUUxP?=
 =?utf-8?B?NXBtV1dQQWJ5NU1QN24wR284ZXZFSVZpNXVyb1BPa250b1dMWXhzMlp1RDZq?=
 =?utf-8?B?ZUg0UmdPQ0xrdGtPK0pvd3dXZjJNWFI2OGQyeDBGOTY2TjB4ZXRScnF1VDZr?=
 =?utf-8?B?KzQwTktYamFjSGIvRlRyNmFXdWdQc2EvS3czQjFSTzZJR2FxSW9yNkZ4ZzQv?=
 =?utf-8?B?R1lUZXQ4ZU0zd1V4aEZ5YnBkNXgzNWp6RTZXQUhQUlZIa0F1TngwOElGaWFO?=
 =?utf-8?B?TktMa1J2V3JFbWlRb2d2eFJUU3N3SzRJc3dYNHNWNVZzRHJLWDZ2cDAxR21s?=
 =?utf-8?B?dklmMGtOODdERzZDUHIyOXV1T2k5ejV6eUVUTW14TW04OW94TGFnUDBGOTRh?=
 =?utf-8?B?SE16QUt3ckN4Ni8wVkNiMGhnak1NNHZqaGRlVnErRVVIMUFTczErbkt1bkFW?=
 =?utf-8?B?MXpCWU45czREQmJQc3NlWXJROFFpeVdYUWc0aUltbTRhR05YV3kwZ1o1bTJE?=
 =?utf-8?B?UXVvM2I2dWpJb0JCQXJrb01DcXpTTHFnWURqaWlnWHZ3bWIrTXk2MDlHM2Nk?=
 =?utf-8?B?cTVhbkZFUURXVUFOTWFEeXo4N3lWVVBWNlhSczVJSHZDS0FIU3QvNVFsbCsy?=
 =?utf-8?B?am1SS1VEZlpZdkhNREdPell1UUNuZXYzMnVuVWhYQVNUMUJYTEtXbld3aFFu?=
 =?utf-8?B?VmdVLzBNZWE0bi9IWm5BdThjdnFIbTRkNW5HM2UrZC91Y2pyY1E3U2RHTnhB?=
 =?utf-8?B?OEZjaDZlS1BSZ1o1dWR1V0twb3hscldCNEQyQjV5UGtFSG01YnROaDRDaHp5?=
 =?utf-8?B?c1hLM1dDQ3NvQ1UvVVgwWkR3bUl3bkFhT1FlNDlhaGkxUkVuU2NaeHNTTFlV?=
 =?utf-8?B?TmRDYk5VZ3lXVWMwUW1pWFlYNXZqbDAydUwvc2dIVXFHRXpvZXFKQ2JJR05B?=
 =?utf-8?B?Mk83V3Z3ZGlSaCt1aUp4TzFWNXRnWXVzdnovUXRtTXBsc3Y0RzNXMkkvQjNU?=
 =?utf-8?B?ZUlad2txeG1YM00wTmdQaFg3TjJHVU12Q3Z4cnd2c29rZGVtNXV4OTlNczRi?=
 =?utf-8?B?aFRwSXV6Ukk4WGwwNllYQ2JNVDU5VllXMVo0cGpzZjNTVUp2WHVucThWQlFp?=
 =?utf-8?B?YzdUSTBxQjh1N0IwZ1hpV1RQUFpoSUl6MTIyZ1NVRHFhTXZNRGNxcXZOQm4y?=
 =?utf-8?B?aFE5bXpOUytNTWsxZXBZOVAzTGJjbUZVN25rNnl0L1Z0SHlQTjBEYVAwQkh5?=
 =?utf-8?Q?uJxcoYrlj8MkwIF//J9VOoA8es7iMztZJmwr+Uj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2202edaa-05a5-42a1-edcf-08d993a6b3cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 08:50:44.2458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxVfSqniIrM1t6dcCPIxmvvH5qFnEWZzVE1fHOYSDgs5rPzFjQNKpp4o8GuqI2fFJF/xEHyooK9dEQoKhXsLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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

ping.

On 10/13/2021 5:09 PM, Nirmoy Das wrote:
> GTT BO cleanup code is with in the test for loop and
> we would skip cleaning up GTT BO on success.
>
> Reported-by: zhang <botton_zhang@163.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 ++++++++++++------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> index 909d830b513e..5fe7ff680c29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   	struct amdgpu_bo *vram_obj = NULL;
>   	struct amdgpu_bo **gtt_obj = NULL;
>   	struct amdgpu_bo_param bp;
> +	struct dma_fence *fence = NULL;
>   	uint64_t gart_addr, vram_addr;
>   	unsigned n, size;
>   	int i, r;
> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   		void *gtt_map, *vram_map;
>   		void **gart_start, **gart_end;
>   		void **vram_start, **vram_end;
> -		struct dma_fence *fence = NULL;
>   
>   		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>   		r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   
>   		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
>   			 gart_addr - adev->gmc.gart_start);
> -		continue;
> +	}
>   
> +	--i;
>   out_lclean_unpin:
> -		amdgpu_bo_unpin(gtt_obj[i]);
> +	amdgpu_bo_unpin(gtt_obj[i]);
>   out_lclean_unres:
> -		amdgpu_bo_unreserve(gtt_obj[i]);
> +	amdgpu_bo_unreserve(gtt_obj[i]);
>   out_lclean_unref:
> -		amdgpu_bo_unref(&gtt_obj[i]);
> +	amdgpu_bo_unref(&gtt_obj[i]);
>   out_lclean:
> -		for (--i; i >= 0; --i) {
> -			amdgpu_bo_unpin(gtt_obj[i]);
> -			amdgpu_bo_unreserve(gtt_obj[i]);
> -			amdgpu_bo_unref(&gtt_obj[i]);
> -		}
> -		if (fence)
> -			dma_fence_put(fence);
> -		break;
> +	for (--i; i >= 0; --i) {
> +		amdgpu_bo_unpin(gtt_obj[i]);
> +		amdgpu_bo_unreserve(gtt_obj[i]);
> +		amdgpu_bo_unref(&gtt_obj[i]);
>   	}
> +	if (fence)
> +		dma_fence_put(fence);
>   
>   	amdgpu_bo_unpin(vram_obj);
>   out_unres:
