Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 18:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D7B611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 18:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18D7B611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D73D6E48F;
	Fri, 22 Oct 2021 18:09:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A75E6E48F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 18:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKmBD5F2sl7j6fhx08HHIfN5yBQ3+oKfMKkYaVhguoyd9xORt+jAAiGe8/fQ8nMUiYhYUEORMpZtOm7Ae6CzikbOfwI4r9rYl9hM4fpV7sfCLfyXdwu62iAS7/OU+ZyD3TN+zWn00h0nRgCZUmCWHgBjlviuBUa3yAGtEr7FBmRN9Gre6TtRBf5cd/nw72vjmxi9+NeSAUZNYxbBEXc66lBlaND6J4N/qcFJGlUIogLlGVdonLYea/4DW0EdMYqMq4DWJqJow5ApZR7hcHskFmaQKJs5Cb7PP1t2w2pGrvUNT32k06nxutcMBX6ZglmEXY/TYr0DUeSJOa1szIN4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR+B+KuBXwwiYsASmoiXN9Xf+R+alAjH9jy1m2n1Ea0=;
 b=Gq4TGjadfzmpAZgOCGydhGku82QIu8NZeR+FYsxFad6YHQR1/FenjQoLcRCVGsAG84HC7O8kvf7+jAcMU5WeCPpiXIcvWtrpnyi9jSM3NF2x8HyL3InHu1raDSHd9HswqgFRvHeUKY/CoGu442qYomBuCXXJjZV1vRjrtL/gCP9W7P/6syWGKvHqAz7b2LYqVs8rgeJOr73Nhr0CnQneYotNVlXsDY+sND+kbCNz+J7yKyuY0jmTu0yhRi3+uiH8d3DKnaTwZMi7px135uiMmtDAao21Y2n6apB7Xrc0dlSrHb5LCA+icgkpaqdjQtlJDIkolFL9IRYgXc6nCrJ/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR+B+KuBXwwiYsASmoiXN9Xf+R+alAjH9jy1m2n1Ea0=;
 b=JlmX3uxjVeimXx8hsCEZIFHXtFlo9NFq385PIzu+LDeKXHqTXmpq3Kp1GUx+/s94TlZUXAjWHOqTKQJO+vyuaUrgQ83drCYBevYpIBNmQwnf4Ashold5h9XBmwHR/YFEUtXaybztdpS1vli7owC7NbgCcDhT4bUJNeAcdepeywo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 18:09:03 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Fri, 22 Oct 2021
 18:09:03 +0000
Subject: Re: [PATCH] drm/amdkfd: restore userptr ignore bad address error
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211022170604.5556-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <24016aef-32dd-dd49-d7dc-2f185f1fb3b8@amd.com>
Date: Fri, 22 Oct 2021 14:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022170604.5556-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 18:09:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 219a4c21-ab2a-4362-c740-08d99587074a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488B57AC216A6C0F16ED7EB92809@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgYgWpUKNZzpQgN5+wfR8wqr21QJAeSL8wOZdPPJ754bX3m0eogcTMwU5PN50Q2rlG8JCo097KAtJ5SjYXD6ZFwiuEGMCXGollEdb744YHeun3tl2OjZkzbGy2IYzJ3U86mXjBucUHzEXqn1nTMLZEraGdOk6aTjqQGLvwVDlCfkmPNPOuLccgDTQ3Q/iuzNyHjWF+YM7Av68+NyKDJwTvvWfbftDO+2VQjxlINdjCmvBe5k2tcaeIK9JJhtgCUITBb4RVj2PFChY8g2SRfJECHhuwMoH9unYj7d8/yqKW7Hj3u7UFM7QMuamUOFKFWd5i8gt5atkzziB6a7TqFOylSVvXrgMGVhE8upgu25+1CSHiz622Arskfm/3Zn+at1Xi2x+oy3HmjlzzjH7gcnEsa8c9wS3cvNJwLwTgJMK7LJDrOfINOFWP9cx31cWqg+exJxW79Bx7pfF5YexUItzkzfO5DyS6QzF9lsCuUvY3Px4UedlT2VeMpENntohuTsJmWLMWRM6cJ/Psav/gBkuHOzfY9UF6SG9+ODZD18lNzAr0tnvOeq+uISjooNl2dmhYOWGRRWBr9vVm8lEB/RJJ+cyQcq6qnSUrA+VmYSoIoYdVH4jCj5pA+XGoOotuFkEaSvMMVs0nKTaSRFg0osAkzOl8c4SB4dkbmz9/RztjHU4YOE//zz6rlZ8vs3LxVlZ90962zc5vQ6wolwKiZqK0lfnfk7RsVevKYCJGFkaEdDbSyOXuD0lAZzwf0gzpSm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(16576012)(26005)(86362001)(31696002)(956004)(2906002)(83380400001)(5660300002)(38100700002)(2616005)(316002)(36756003)(4001150100001)(8936002)(8676002)(186003)(66476007)(31686004)(6486002)(44832011)(66556008)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZMNUZlZzVFbEhDTGJWYUpoVnFzM1NhUHEzKzFWVjJneG8yMk5Talo0M2JC?=
 =?utf-8?B?UXlIZ3N5VGpYTndiaWR1SVNwQTZQTktOM2FuVkJOeVZuMEJnY0hvWDZXUDNH?=
 =?utf-8?B?QlFLQys3dFdEWjYrUWRVOXdMRGxzVzZ6NUFOdXo2azdBdEE1VUhTT0hHc3Vn?=
 =?utf-8?B?TEpLRjVvSFRwaC9PdEV1YWlBWVBRQi84aTNFTjlvTVZvWHFTQ2tlSXZvSkVT?=
 =?utf-8?B?b3pTY2IvOS9HbkNMeXVoMENuQ2w1ZFh0SXR3TjQvUnVmVnJ0TnBLQTQ3N1F6?=
 =?utf-8?B?R2tnS0VBbkZ5N0JzeGNGL0tYV1ZEaGJvQ0FMeGxrK0hJK2J2K3lFSFlGNHhv?=
 =?utf-8?B?YWlCWVp3LzB6QWVkZDUyeVQ2cGJvN2hGOEtBYUJSSStZdk5pLzRpa3o5OCsy?=
 =?utf-8?B?VnpadGZaRmhwUURKSFNaVEJKcDNCOXVHNEExRWsxVnNkUGVmUW5ZZnBmRlhu?=
 =?utf-8?B?ZURhWmI0Z0FQR05tMjVhdEpSM2pIV1d6dm5wZE83a0Yxa1lZdVpqUG1UWkJ3?=
 =?utf-8?B?eUVvZysxVzJULzN0M1cvMlo1Y2VrVnluVkZja2NlUE5acHRrQ2xqTGhQTjls?=
 =?utf-8?B?MFFtUm9HL1FBbmtpK01vVHgvQmNpWUJJbi9IVjJSVksxUGdWMkZWN2pNL3ho?=
 =?utf-8?B?NzRBOHhTUFVNcG02TUZIbEhDcjl6QTc5Q0V1UjNBNktRY2xjY084MkxpcUc4?=
 =?utf-8?B?dUJzNXVwVHNYVlVUR0tSS3VYTzJjOVUwYXhiUzFIZG56MEVJWlEyd3hRTDh1?=
 =?utf-8?B?WlZwdVJRUXFDbVh1QkFGdlQ4dmduMGdMYzU0UnZaMlJRSkY2UjZNVTEvMVZi?=
 =?utf-8?B?dmlhNElxOEw0bjg1ckVUdlVWbDFkZ0FuZ2o1UGxLdEVpTVdVbG9QdnVub3Za?=
 =?utf-8?B?SE9CcTNVSDBvNXJNQzZ2V3B2cmtuQURuNzlvWjYrVmNINHBTT3BvbEZlUlJx?=
 =?utf-8?B?d1NDN0hXOENzbFF6ejVmRkNJMnkvTUhVVnAzYTdCVmVHYzVhMVZkRVFKdGdj?=
 =?utf-8?B?Y205WEY3QnhtS1BySFNLbEo4QjF1VVBCRmRqaGlBamNqYytTZExJNUN5RWRY?=
 =?utf-8?B?WHRIQlJPVW9FSDduSzVmOWl5WFJFM2t2dS9OYkNKOHBnMExMeXVrWTZkVlZz?=
 =?utf-8?B?SFRqMGM4UWhKQm44UHpJdHg3QURqenZmNUFVemdTSXVUMkdZN2ZueEJjY1p5?=
 =?utf-8?B?Q1JWdzJwQzNEcUcxaUtCcXpVRUZTUUhHQ1ZhZjJoalpPODcxeEJRSkNmdGxz?=
 =?utf-8?B?N0dJVzN1VENqRFQ2aDVTK1l6THR6ZHJ4WmgrTHV5OTZhWHpPS2V2d0M2WFJS?=
 =?utf-8?B?bk1qeGdNUkFQckFOUmM3RjFGaDQ2REd5T2o0MFB2cnpsMzV0R2pzZ3ZMTmRM?=
 =?utf-8?B?M0g0c0lDOG9HVGU4WGRwRnRGZ29IK0ZVcklvSm5ISFZ5dFowYUh2M3FVeHNw?=
 =?utf-8?B?aHZINHE3VSsyaHJWZ0JlMnpRZHVJdk9oWVQ2RXFvYUQwcllwUUxYQTBrTzFu?=
 =?utf-8?B?b09hWXVORThURGh1eENESkszSWFxTVFqcVp1MGZQbnZrWVNHYW8rUWYxVEtN?=
 =?utf-8?B?d1cxZ3M0dGhmUlNYWkp6a1R4UThYNXdCRGN1c0dwMlZJS29hcjA5aVo1SWd0?=
 =?utf-8?B?K1RvV0gybThxVTVXcW9ySUsydXdtajVpYjR4ZjFaMERkZFAvMmdNMitLSk0r?=
 =?utf-8?B?bnNiMEZ6U0tsNjdMVzdJL3B4d0d3akljRTFmVmh5Z0hUby9OWmxvZzE3U1hW?=
 =?utf-8?Q?L0k5th/S1BrDnPuIjvcQ4Z3d/oumm/jzH/OJtBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219a4c21-ab2a-4362-c740-08d99587074a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 18:09:02.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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

Am 2021-10-22 um 1:06 p.m. schrieb Philip Yang:
> The userptr can be unmapped by application and still registered to
> driver, restore userptr work return user pages will get -EFAULT bad
> address error. Pretend this error as succeed. GPU access this userptr
> will have VM fault later, it is better than application soft hangs with
> stalled user mode queues.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 27 ++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +++
>  2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cdf46bd0d8d5..6f01c6145a87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2041,19 +2041,26 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  		/* Get updated user pages */
>  		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
>  		if (ret) {
> -			pr_debug("%s: Failed to get user pages: %d\n",
> -				__func__, ret);
> +			pr_debug("Failed %d to get user pages\n", ret);
> +
> +			/* Return -EFAULT bad address error as success. It will
> +			 * fail later with a VM fault if the GPU tries to access
> +			 * it. Better than hanging indefinitely with stalled
> +			 * user mode queues.
> +			 *
> +			 * Return other error -EBUSY or -ENOMEM to retry restore
> +			 */
> +			if (ret != -EFAULT)
> +				return ret;
> +		} else {
>  
> -			/* Return error -EBUSY or -ENOMEM, retry restore */
> -			return ret;
> +			/*
> +			 * FIXME: Cannot ignore the return code, must hold
> +			 * notifier_lock
> +			 */
> +			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
>  		}
>  
> -		/*
> -		 * FIXME: Cannot ignore the return code, must hold
> -		 * notifier_lock
> -		 */
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> -
>  		/* Mark the BO as valid unless it was invalidated
>  		 * again concurrently.
>  		 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d784f8d3a834..ae6694f2c73d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -693,6 +693,9 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
>  				       ttm->num_pages, &gtt->range, readonly,
>  				       false, NULL);
> +	if (r)
> +		pr_debug("failed %d to get user pages 0x%llx\n", r, start);
> +
>  out_putmm:
>  	mmput(mm);
>  
