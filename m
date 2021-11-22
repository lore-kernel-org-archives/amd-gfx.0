Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53ACC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 16:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F5A89CD9;
	Mon, 22 Nov 2021 16:53:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E95589A1A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 16:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR7Qz0YyuA4BRblBk1A0yy2QJADcMPsX7FXAr9bwlOsTf68TXDGRCYPJZBWgkjGK+UHVIjUN2dmyJQS7+6v/fRJ4nYC90ZE0aDLrJ/oL3s8mPmYmzhN6OX1GdTMdn8sgNmj2l+oVvfM1IBI+Ch0WhCr8mn0ZVY7SR6Dx5STvxwCgUocZCKLQ8RV1ANd9ydJ8zINhMlpOwApfMsxCDzZYEn1rEH238K+OziAGf5+/4oNkal0CQAI5fkXCjwnwcrfOCaWQm9ZNPFIJAdpJh32pp1PLyxDg02N8LGDC5x4dCGjBXS5T46ZJJ2HFTJyzmL5K9EPYherXiwIIhMsieJWC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keHcCe5EOKiWwPKQ5eaGZ5rcHJ4FbD7xUOblreiJwr8=;
 b=Acxj3MatL/Xx5JCXnGbczOLUDM/+7rE0fx5SkqBs1UXNP/KUU8+vRxyXDw2lg1deqhDbk6n1+h/0YdXi71AKHLlLEkyDY6I4JEw44BNSbBK1Pdh96zvzH9i3RgSyTGloAYlivVFscFF33EzsBE20/IK7+7ZTXn68FsTnPoA6GRTpDZIjyFYWKjz3nQBKyho9/uJdtHIzQ4KgnfSbDEKQHHl0cjO1dJEC7pe7NpsB5orudCs2hsC5Q3yxZ0vBUbNxADfdC8YsfDsXBMnPfzpnw69xMcO9mPVJl6eDU78Yr6xmIqCHg6oRetwJGevzM4mJOYG3wzCRkCzPKxTNyMsw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keHcCe5EOKiWwPKQ5eaGZ5rcHJ4FbD7xUOblreiJwr8=;
 b=KgzwSFJGHxNX2LrotIyG5rL2JofkfXWtcOV7cNoY5CrjF7fKZa/Gd0qTI3vZ+s4k+gEAiU0aSiQeZpiKr56BZt7m1JgDyJM2eFcTwqk/B/5EXJZ86Bbv2PamHG6TJF6jWEiFSuvpAJOwQvNsI06lpjH2Hv5mYwpA5Jrn+CjXAlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 16:52:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 16:52:57 +0000
Subject: Re: [PATCH] drm/amdgpu: partially revert "svm bo enable_signal call
 condition"
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alex.sierra@amd.com, philip.yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20211122123926.385017-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <27ca2dba-2ff5-9bd2-b513-95b54581b5ce@amd.com>
Date: Mon, 22 Nov 2021 11:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211122123926.385017-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 16:52:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367b5216-8f40-482d-8a3d-08d9add8891d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5292673D024F30D648718B6E929F9@BN9PR12MB5292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LnhEKzpKuAlmHFQxgNDUpsfE9qwWQ2PhbupZcIF+XOn5l5s4khfdbvLUYc5T47rPj7c2A3+zzhf3xO6UtE5D1fFZlOzFYWIrfO5oeNzaiKIi4KGYChWeCG/lUam62IeuyoIkhGCDpqojGkyLnQe0kTkK4m3XTR75lYYX5WytuZn6qXm1SsAE7d2Pe89wn6rqGbN4mKYI7hlJlcQJwuRVHUtVdvyvwQ+CyCaD5UfDYBb8jaxEdU6Fg8mm/rtX+m7JJaNvx/Hcj/Eniw3g3dfwbcrQmZJM4RGds5hzIuVwQGUotPYPXqCGBlJzbTx1vlQYGtlQaH/Ydi1K0KaFuqrt+cqSSCrCSp9QWkNBk/7KS21V2pODc+sxhbF1WSemIH+LntasWcLf73dJo86VFl8AFEZnFFAv2RQWyaC85HMYN1/Dj1FfvHg+7LBGOOrs0VCsRQ+tB4PseN2nRuFf4F5bUYU9aGW1UaU3Bp4TiQ3qwkSyrOk15BeeNetpZHbLldA2EC7xApgmHQ5KbbNmhM4DXYjbrCsYhXUpVuk/MtXkVOcJmvylTkR9d7OUpujgQmY1RPyLU5T0px91EpzEWU0SfsTvDsbkaGktsyhG+vxw7V7VBJD0AOmL+nOFfP6vVj7vp0udcgzTrQ1A7175034v/sRy17/rpqTGgTreI4zzyUPssb1QAcZcGi6hZRqwaDmmzzxDzVFL9fmVLDJxR5HRC937TPi+N/e6WlqHbsQxqWGtyyur3UVMZjQGPsX7SXR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(956004)(2616005)(5660300002)(66574015)(86362001)(83380400001)(26005)(31696002)(4001150100001)(186003)(8676002)(38100700002)(8936002)(508600001)(316002)(36756003)(66476007)(66946007)(31686004)(2906002)(66556008)(16576012)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJ0MjhNSG14Nk9VQ05kS0drZHB5OWU1MUMvcmcrNWJYd3lCaS93b1dhT3JT?=
 =?utf-8?B?eVVHQjhreXNkVzgxS29FNzVpODRmY0ZlemlMbGdXZmRDTk9rSEpNUUVFekVL?=
 =?utf-8?B?L0EvblJpelZTSWhhcHliNFNqM1EvcnBBRTYzWW5Fa1dhcXU1RnhhcDZvaURw?=
 =?utf-8?B?c3pHRjVEeGFBZ2VNeDFBNE03c1laNk9aSW5YbVFSL0FzTmpoT3FwVWlQMU1k?=
 =?utf-8?B?Y1pOUjhZdDVDVEEzdGhFakkyRllSN3VjSjJLSU5YVk9KL2JXQS94ZytVcDlH?=
 =?utf-8?B?NHFXN0YyRFF1aGFqS0lWazdBQngxUXFZeWF2eXA2Vm5ZcTd1MzRscllYYjdu?=
 =?utf-8?B?SWJBaGd6UDEvcmV6c29uaWczTTgxd1N2czhyeVI5VzRlejR0UUlyQlNsUXdq?=
 =?utf-8?B?TGtyYm1Qdkx0YURiYVVBL2NydVlzK1Nia2h5M2xjSjJZK0RFSU50V0hDSHNC?=
 =?utf-8?B?OVd5R0JpbHlubEZGN3NEaTR4V3B0bnRvZkNRbmNWWWdEc1BUcEZBajMvK0dO?=
 =?utf-8?B?VVdSaTlhMHFNd2V3bzRxTFJybjhmZldkLzg0K0NxbmIrMnpiU2RKM0lDS0tX?=
 =?utf-8?B?MndPUktPV3d1YTFMOC9zTnJSZyswc0g5cXR3eWwxZDArdk0vLyswRlo4TFlQ?=
 =?utf-8?B?L2EyVlBEa2theGVNdzE5M2MyUHNWQXQ1OU5wTVpXMFVBV0tBVU1KNnN5Skt4?=
 =?utf-8?B?NzB6TFFoZWtNUXRWNytjZ1lIRENDc1AyN3RxM252MytBZm9CbGRKVUcyWGdX?=
 =?utf-8?B?SEozSDYxN2VRSU80SXdnY21xLzZyVUlmd3V4YnpkUmhiYmROTWJYbXFHeXNP?=
 =?utf-8?B?YkxQYzBOQm1iRHlUczhETG9vUmYxQk94TWk0M1JCTlJGVUwxYUtHaUxaUXgy?=
 =?utf-8?B?MjRsSUVmS3N2cTM5cWRsREQyb2YyTU9jeEhZY3cvdkgxbVhmTmdTeHM1Titr?=
 =?utf-8?B?a1VkTEptOFhCQWxNNWNxYktKVTUrUk9ERlRlR0V5cUtWcDNXSDk5L0dlOFpj?=
 =?utf-8?B?bEhOSnVpdW1vQnppUEhwK1JzQTRtWXRuUyt0cEl0TEVJMUJYSjFyVzIwdUdu?=
 =?utf-8?B?WDFpTkNGOTlBbVhxdFhQSU5LVHBoOWpEL2dOSzVwS2VMK0NvdmphUlJIaGhG?=
 =?utf-8?B?NFB2QW1TeG94cExTN015dmJXUDhQQ25YUE1DTjMwSTg0cUMwa2Y0b3J3YS9M?=
 =?utf-8?B?a1hzQXBMZFJYdnk4ckwzaG9YSDcwandyNkNhc0lkUi9veWVMejZlTFVIL2Fl?=
 =?utf-8?B?cm5yaGZqd3lveUcxT043RnNSTklRQlNQWisrZVFYNmozZ0dqOEhyT1R0Wmoy?=
 =?utf-8?B?elpRN2NxK09xdHgrUTMyWFRQVzJpNUlnYWZ2d2g2TXB4NE04ZlIvTnNrdjdB?=
 =?utf-8?B?ZFBQUlBVK0E1YS9RMGw4SVVuUDVBdGxKNm53MWRUSytWNEF5aHR1cWhKSkdU?=
 =?utf-8?B?dnQwQWJTMGhKU0c5cGN0N2lzRzJ4Vk4yNXlIMlRWeWNIT00yZjNUTzNnTExO?=
 =?utf-8?B?Kzd2K2NTRms2VzlHclN3Zk9qQ3NVYTFabjJsSHgyVm9FT3p5enJqenZlVUJu?=
 =?utf-8?B?ZkJ1NGJPbjkvVi9KSXdqUnROL2RGbHFyT3dWNjNBTWdCU3ptL3p3NkUwRWZW?=
 =?utf-8?B?NGVQbC9EdVRkNURCQlMrZ1Y5bVMvcWZZQ0JJWHBrQXNNODR3WThOQ2Q5ZXkv?=
 =?utf-8?B?ZEg4by93aThBbmxremExTk1OdDM3Y0NYVnlXdVZKZTFJVFYxMFRqdkpISzRs?=
 =?utf-8?B?Mnd0RVo0bXJwNGdwMHhtMkthazIyU2RaeFc1NEpsT1FDZURzZkhTSW5FdEk5?=
 =?utf-8?B?SmdKSTZuU2t5cGNURFlpaFh0LzE3Mm9CY2NnTEJDYmY2SEJJdWZLSVkrRW9o?=
 =?utf-8?B?NjFJdm02K0JUMDNYMjNrNHlNVkhGZ3lyRVVuU0x3ckV2eDZOQlhFWDBZRXd2?=
 =?utf-8?B?Vnd1OEVkaUszK0FmeXN2UXJubDNnYVdxMnorV1dIV29MWjlxajVLNGVxSGNv?=
 =?utf-8?B?S0xHVFBMazBPUzlEekVqeTNGajdUc1BxSTdjZlp5UHozclNZblZmY2d2UDdk?=
 =?utf-8?B?Wk11aWQ0eVdPaVVGMzhIKzdRK1R2ZE5Kb2FTNDJKdDU5VVBBOVJvZHhZd0FQ?=
 =?utf-8?B?eHB0L3ZTVisyLzc4d3VqMGRSZEZUdWZrU1VpcEVIdHU2YkpqWUlucnYrWmkx?=
 =?utf-8?Q?NBzg+MpBq4W7P7bNbMUkTxM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b5216-8f40-482d-8a3d-08d9add8891d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 16:52:57.8260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+zViQyJNXY+wAko55ZI2gf9pLMIMNqFqSp3fBOJWcR+oIa6Cl5meuZZkqv3SgDdYnCzl10ytPtN59X4SETvew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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

Am 2021-11-22 um 7:39 a.m. schrieb Christian König:
> Partially revert commit 5f319c5c21b5909abb43d8aadc92a8aa549ee443.
>
> First of all this is illegal use of RCU to call dma_fence_enable_sw_signaling()
> since we don't hold a reference to the fence in question and can crash badly.
>
> Then the code doesn't seem to have the intended effect since only the
> exclusive fence is handled, but the KFD fences are always added as shared fence.
>
> Only keep the handling to throw away the content of SVM BOs.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 30b7dde496fc..b9cd32d25bc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -113,17 +113,8 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>  
>  	abo = ttm_to_amdgpu_bo(bo);
>  	if (abo->flags & AMDGPU_AMDKFD_CREATE_SVM_BO) {
> -		struct dma_fence *fence;
> -		struct dma_resv *resv = &bo->base._resv;
> -
> -		rcu_read_lock();
> -		fence = rcu_dereference(resv->fence_excl);
> -		if (fence && !fence->ops->signaled)
> -			dma_fence_enable_sw_signaling(fence);
> -
>  		placement->num_placement = 0;
>  		placement->num_busy_placement = 0;
> -		rcu_read_unlock();
>  		return;
>  	}
>  
