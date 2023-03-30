Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72850C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1495810EDB5;
	Thu, 30 Mar 2023 11:14:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAF610EDB6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/GOxpOAXJg2J77wXPOl4o2PN7auwyARbeq141DExtdwkdu7JBCPMkTSZnPLvXRdc061XCj54tc+/5I3CQ3SVy6bgguDtCn63TVO6h/gzUFtsguzqmX/BVLmO8smXz6vEPHanTQsI08WG9JBwtfniSAi67jHHSK9hNZkFP3JyA6L040FR9pImY5nSaikWgq49LnCfuuuFrF5nDrZEbl+ccJPYjKPehdsYCrKXvu+djcXeyys431sZxXuUVFqKfnrEWvBT9k00/wUgIioW5/Z/ZveRVXuRpvbaTTjBVpieqzqiNmSBX+h5m0op8qQOGc2dOBztmZmahZgxYkjrA004w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxcbzCD2+re1wtZU4JGJuaO1uP2Uy5Okqhv0l7tLXw8=;
 b=WjxoP7s8T/KMOuQnQCQGTdqHpkcf+u3BUo9RMcIyKGAYiL024pdx0iSFWFurtLuOXmxmnFZ0u3D+j1YHwki8dOQczoGO3mZ71rH5xUV2DldVMWcpeKpWjlo2dPdIzDAPYc5h1iuGLo5qycDN1Kh3xUf6r2587u4WTbIlSI81j5NQdY3M85ZCOlfKCR7ZLs7j5M6R5taQrP41Yvnjh14wgc20ugNDn7np4PdCoEO7LcbVRSGKUEUHzEDWNADf4QoxX+BLMS4HttrZsVi0LtgFsidtoynSawJJF66O1ZlXmENwGo+yvQ9I+DaKxlO/nWKtOJutOKEUWrUCvTdx2HtKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxcbzCD2+re1wtZU4JGJuaO1uP2Uy5Okqhv0l7tLXw8=;
 b=2jsOGBPF9yB88S6Z7B2RVQ1JTqYWSwUG1TRVbiE47rJAmVLvqYNPHRmc93Xn/qIqGpomiei6Ug7N6rf3sKVSSaKpVYOwR+EPwdRmHEmhAzxd/Yj4giiiqLnigOfwKycpZl3SeWcBcLV/zfuFW6p/fYZH0GGtpVpL+JjtwZfCg0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 11:14:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 11:14:28 +0000
Message-ID: <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
Date: Thu, 30 Mar 2023 13:14:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329154753.1261-7-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6f88aa-10ed-4e08-eeec-08db310feda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thh7hgaJC+CDHDxEPeJH01sZZYMKHQCCxuN0dPw/puIguROocLkQlgPfHqQa4mXbOYx6NF5WVhgWrt880bZ0e451NNO+VTk3fUZl4cghip7pT4eGCIOkdmNRjEYWS35HeSqpVDs9Txk5cqSqEBfvq+ymOnL+QcONigUJF83QM3I0yz5Spc+1pAkwXoZKmpeAY8a6wPdlPDgSHee7xFvXlEf5Dda1djk17xFpjK9HzKsHIpioNkLpznZ1od4R5J3i3F5udVzx2vXA1XrVOWud4t2YYlkhSYLLYvJqnSN76Dd/+avjqahs6SWAiTmf/nmpbiiUNcqusT6p7J8VY7vF53Va2zHR0drLjlxeBpLwees5VdEYH0zUie7+9lrRPND63UK9wwjlYQ4Jzwjc+lUrrI3Osvj6QdCDXdWJVgawGT1uVe+e81QOLYorHBmA7HPWEnS2pw5ApfV+I1z/gZwvlKhfNdvOPGQEve8QwxubPah3wt1iP27Q5Y5ih6H1/AA+EfaR9/lOpMnbpXxDAUDjqbFxcQBHsakIryr0N4nsFxHGla6ZFbYyCDNzr9Qq74LW7N/DmZiVnPRQVi7TuCwmEzz4pCwqNdHjuWCVNsybnUuZKlSLh02a4mvA8XgKS/R+7MBpLHKMCd+DLlHKczWuWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(66574015)(2616005)(83380400001)(6486002)(54906003)(186003)(478600001)(316002)(26005)(6512007)(6666004)(6506007)(2906002)(5660300002)(36756003)(8936002)(38100700002)(66946007)(41300700001)(66556008)(31696002)(66476007)(8676002)(86362001)(4326008)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRUVUVLQm5RMjdsOThKb1BaOFF2S1R3MzM1MkRjNlRMVzE4OXV3QnVFUGJz?=
 =?utf-8?B?L21uNUZHSjJhNG1EQTd1b0dtNjZWYUI0VzY5RWlyVXc0Sy9FVmhycEUxVGRw?=
 =?utf-8?B?anBuNm9TUnhSNjRYTXBZaHNaT2RnT0lDcjFyckd1Qlpra3hxUVBXT0duNCt3?=
 =?utf-8?B?MGt0cmEwOFB1djRSMngxckJuYlk1OWIwQ3g3WVhVWVNLZkdyR0E1VzFySWRn?=
 =?utf-8?B?QzVVY0JqS1Y4bDB2RG9yQ0RVLzJQKzRQTHptMWNZNUZFWk13dHZxSFdQMzRX?=
 =?utf-8?B?OStiUlV4RjBpNlNvRVdxN3RZQmJtTG9LMFJScDZ6dDZ4bmwyWWdDQStvc0lK?=
 =?utf-8?B?dk1CQVlZNjdBNWxLdGRDV25VMnF0dmlWR29EaTN5dnZhb0FDQ0hVS2dTZFNL?=
 =?utf-8?B?WWFROHFmU2xrcEZYSTZ6aGs0alI1V29RdVVFWEttL1N5d0g0UFNteEVPLzdr?=
 =?utf-8?B?RGZxMkNHSU40eTk0ZlNNNVpHV3JqY1VCMTNIaEVxbitURURRVDR6UWladmdM?=
 =?utf-8?B?bnIyYlpyNTZST0NqUzY0ak13ekRaWFltZG81TFk4Zm1TZUJyUThlcWlGM2Vi?=
 =?utf-8?B?QU1oNE1UL3ZmbC9zc2VvT0hubEtmTm9rellUeW84TU90aDkyU21hdEIyc3Fy?=
 =?utf-8?B?OFc5ZFVNR2VyOE94UW5XUDhIWE93bU52UGsrQVU2WlBtbFByQnpPK1orTG5E?=
 =?utf-8?B?MDYvV29PbThEL2c0azhvUGdTWnpYbHRXSjdSNW4wNEVaN05uay9KNDJrTGZE?=
 =?utf-8?B?Q053Q2tqWlBSMFJST1FsZU5SMkVxNXJBNE52THFiOFMyWmV6d2ZJcEF5b1ZC?=
 =?utf-8?B?SGNKWGpucVpXc3c3QUc2Ym8yb3drRmJBdmpsZElQQkM2eTVSbjcvSEx4WElR?=
 =?utf-8?B?VVp4RHN2TVQ4ejIzNFpEcHV0eGNPamJ0Z0NiK1NhUWVXbnBTL1grSWlKeU9s?=
 =?utf-8?B?Qk5UR1BtU05RbjlYaUpGcGs5QkdUSXR3WXY2NjRsMDU0SmFMYVkycUgybTFu?=
 =?utf-8?B?a2I1bk1mQVgyM0NIVFlqdFNUWTJrdVBxVnNuZXhXS1Zqb3poZ0xyVCswZGM0?=
 =?utf-8?B?V2xlbDBHaFVSNVdJWWlqS2VSQzFjVXZNb29ZVVRUdzI3LzhLNWZVUW1LUlBi?=
 =?utf-8?B?QjRVZDgvNGZoV3prT3F3RXEzZTNxNDVwbHhDTnV5R0piTzlrUjdhTitaUXRt?=
 =?utf-8?B?S0J6dDNpaVdTQURrdElsc1grZUhsL2xadGd4TkhzRjJ5ZHBSOUtmL2FzUXha?=
 =?utf-8?B?YUkvVzZEOGJ4UExKbmoxU3Y4RHJJb1BQV3JZellrZ1U4bkM1SGlBc04xWHl2?=
 =?utf-8?B?SzdzRWJha1oyZ2pmYytDcXFrc0owTnFRUi9EUnJXeTNTSVQyYkRJUG9EWXht?=
 =?utf-8?B?TWZMWEJqMTJ1cXp4b0Y1cTVvVS9WRnAxOXRyMkJXTDA2UmNpUnVncFV2bUVH?=
 =?utf-8?B?OEJEVStBS296MlcvQ2hBR2hCc1YwM0dhL3FWQ2JCR245dGJSWndsOW8wRnlD?=
 =?utf-8?B?ZmVuSmVHdkR0WHBoUm50M1JvYlkrK3JIRklXRzZnZldubGV1TFlQTjFBd3o2?=
 =?utf-8?B?Wm1DUlBITnFjMURIcFZXMkFxc3hkTUM0bGxOc05jc2tmOGovUGJULy9PSHZl?=
 =?utf-8?B?bEw2MGd5TGQ2Tk5PdHUyaWswc29lUUFkeGYzQnkyZDJoR0lIbVJrR0l3WHQ1?=
 =?utf-8?B?S0tOUnlLUy9kclR4d0NLejJyV0NKUHc4dXVTNkxhOTlHYVBoTWJIR1Vwc0I3?=
 =?utf-8?B?aGFISm13SEN3UVRNY3RYOVBCYzkybFdwOHZLaW5BbHJFUnVMM3h0ekFMQVRw?=
 =?utf-8?B?QXcvd1pGOU1qanlEanZ1UDk2dkVUVGh5UzVqeW9ySjI4bWF0a2F4a25SUXVN?=
 =?utf-8?B?Ny9TYkFJcUFWeEFDT0ZuS3kzZkNNL1AwUkxnOWV5bThTdUUxRWxuandJTEEx?=
 =?utf-8?B?TjBPdFNNR0VDTlJ1Q2prcXVvOUh0c1FvS01ZSkZLM25RQjRsOWJGLzh6Sk5o?=
 =?utf-8?B?TXE4OHM5ellZNFFqZUhzVHEvUVY3VzZVeGIrQmFwZjUwQlRvZEpHWEJ0VjU3?=
 =?utf-8?B?ZFZIU2E3MytiaWtYRzZ1ZTlHQ09qb0hjS2JuVVpyRkMxbk1sUzU4L09CR1pk?=
 =?utf-8?Q?W5tk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6f88aa-10ed-4e08-eeec-08db310feda7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:14:28.6672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgYZYGh4eK0Bu6FY7QuN1hTW9FagydEMmTIJvqg/M3D1tYRsrHl8C5DY5twX0KvH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds changes:
> - to accommodate the new GEM domain DOORBELL
> - to accommodate the new TTM PL DOORBELL
>
> in order to manage doorbell pages as GEM object.
>
> V2: Addressed reviwe comments from Christian
>      - drop the doorbell changes for pinning/unpinning
>      - drop the doorbell changes for dma-buf map
>      - drop the doorbell changes for sgt
>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>      - add caching type for doorbell
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>   4 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e684c2afc70..0ec080e240ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		c++;
>   	}
>   
> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
> +		places[c].fpfn = 0;
> +		places[c].lpfn = 0;
> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
> +		places[c].flags = 0;
> +		c++;
> +	}
> +
>   	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>   		places[c].fpfn = 0;
>   		places[c].lpfn = 0;
> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   		goto fail;
>   	}
>   
> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>   	return true;
>   
>   fail:
> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>   		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
> +

Unrelated newline, probably just a leftover.

Apart from that the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

>   }
>   
>   static const char *amdgpu_vram_names[] = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> index 5c4f93ee0c57..3c988cc406e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>   		cur->node = block;
>   		break;
>   	case TTM_PL_TT:
> +	case AMDGPU_PL_DOORBELL:
>   		node = to_ttm_range_mgr_node(res)->mm_nodes;
>   		while (start >= node->size << PAGE_SHIFT)
>   			start -= node++->size << PAGE_SHIFT;
> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>   		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>   		break;
>   	case TTM_PL_TT:
> +	case AMDGPU_PL_DOORBELL:
>   		node = cur->node;
>   
>   		cur->node = ++node;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 55e0284b2bdd..6f61491ef3dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>   	case AMDGPU_PL_GDS:
>   	case AMDGPU_PL_GWS:
>   	case AMDGPU_PL_OA:
> +	case AMDGPU_PL_DOORBELL:
>   		placement->num_placement = 0;
>   		placement->num_busy_placement = 0;
>   		return;
> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>   	    old_mem->mem_type == AMDGPU_PL_GWS ||
>   	    old_mem->mem_type == AMDGPU_PL_OA ||
> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>   	    new_mem->mem_type == AMDGPU_PL_GDS ||
>   	    new_mem->mem_type == AMDGPU_PL_GWS ||
> -	    new_mem->mem_type == AMDGPU_PL_OA) {
> +	    new_mem->mem_type == AMDGPU_PL_OA ||
> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>   		/* Nothing to save here */
>   		ttm_bo_move_null(bo, new_mem);
>   		goto out;
> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   		mem->bus.offset += adev->gmc.aper_base;
>   		mem->bus.is_iomem = true;
>   		break;
> +	case AMDGPU_PL_DOORBELL:
> +		mem->bus.offset = mem->start << PAGE_SHIFT;
> +		mem->bus.offset += adev->doorbell.base;
> +		mem->bus.is_iomem = true;
> +		mem->bus.caching = ttm_uncached;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>   
>   	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>   			 &cursor);
> +
> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
> +
>   	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>   }
>   
> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>   		flags |= AMDGPU_PTE_VALID;
>   
>   	if (mem && (mem->mem_type == TTM_PL_TT ||
> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>   		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>   		flags |= AMDGPU_PTE_SYSTEM;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index e2cd5894afc9..761cd6b2b942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -33,6 +33,7 @@
>   #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>   #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>   #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>   
>   #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2

