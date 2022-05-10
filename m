Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6619C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4384210E1D5;
	Tue, 10 May 2022 15:36:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358E810E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fusbEaiE0YVUkAcC642M6PREMlMSrznWc06QBCKhm/5GW6BVlyD5quOjFQGDxWN/c276FmPUJ5D1M5St6gg75EKn0sQUzVqQFxdvymNJahVTvLZkrswPexmzFNjKJ5VnqGFd2Bw3bU1yIKXnu6LaCFgJBsIZuo5KSQEbLk1ZDrmgV7BR07MHoKuWARRmo873lzdTFBO5yQDkllexwXKIACtg3/j+BtUcPlQd5Om1gjcnhgnypsXn2kGTNuSL7Yr0UBvOhuE9paeQB6GAx7S4O4sUbBTEqPuu06PuJNv/S4AeFfgKM0KuJsz0ZP4kR7+cXrOHI8AgtVbcQLdF15yTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOz5cEDNVLB+hfAjszIC8U1gcqzOz93WazgWcL/iJlA=;
 b=leiKlpyprjKjbCpQrrfm4xe72zx08JHkPSvVxZRHo2U7RR0tkHbEtPxV3zouxVT1XJJ0b3XQsPyHzuhIlYXlOAoMLncpmCp5Z3CUc0twlK3DPN8TJhzlR5VD9+KWPVyfWOOj1xh/zNiP/kgSxk8osykL5Eu9XHlwriieBXMRZBrDweH+5IlHVktS+Ew6nF4Yde3awKb3ylFggsC4uxOTjuGk4ip0DJQsFa+NcuFpfyrleV8Yr/GPQer2g14Mj7xaXwhU/SsE6aiQxj1HL6VnTXNYmEmlo56e5ZWLeBOuijTgRJkwX5t61OZgqbIXc2uo7kxVBLpLWK40w8U93mlLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOz5cEDNVLB+hfAjszIC8U1gcqzOz93WazgWcL/iJlA=;
 b=W8A6e8pe5NKZO9KlR+R/q7CdA3kgGw2pjQZ5Q5VMObzbwiXLqoLvh/WBTD6toA+gUuuMvgcGJhVVMKQXlspQcPtbLHTeXtoDwl5zJqoa6s3AddgtnQOKTQlEAVsMhzGCdWo0nkXptxUFWiOBr5U45NWnOM5r0imLgme1IPnmB+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CH2PR12MB3879.namprd12.prod.outlook.com (2603:10b6:610:23::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 15:36:08 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:36:08 +0000
Message-ID: <25aa7ca8-fc87-92c5-900b-9dc792a8ae5a@amd.com>
Date: Tue, 10 May 2022 21:05:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] drm/amdgpu: move internal vram_mgr function into the
 C file
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220510113649.879821-1-christian.koenig@amd.com>
 <20220510113649.879821-2-christian.koenig@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20220510113649.879821-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::22) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5091db6-7b2a-480e-b340-08da329acd4b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3879:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38791CC94C39811792C9543DE4C99@CH2PR12MB3879.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIck2SCYVGjAHyPyU4OAj5jDUlcnqJ+bvVpJcrQzHfbONGYrwqmkUyFPzHgt8Yd0V357MZ93Gh01lzk4m/EK8Mu960CagKO5OOhGsjRE396AZKnvfxFTOXLaErmnxuULMM+iWtM/MVX9pjeX58TVPoqRN6nV7TZkQ2mz8CPeOUEMPf5hIEHND5ctDBl40pJ+QJgD51MUCt3dFkopxiTF0idQzpV8yYs5k0Sg2lfV7+LVHnyGFJHna5i0maPJzTKXX2GdhxDL1avB+7QY8UytnBf3R6wO2AcPGvnm8opnm0se3mb63mcvshz0CMqVnOFX1yzHMAJhcjOPi5odwpqBx4a8ATYtHXTkNo1O9gLxfZ0TvDF5ycpnLBA4PMJVhI2JbnzvjE/mba2oD6S5q/u4efoK0WfSQjOM8vv6VuLv91X1Mz7fIYio60h8+jW/kAegmpFUGpbc2TtVMnDgxNecMP9hK+mJuC7BOeRzhtdiemBMmxKOmAE9i9AC8CJiyLVQueubL/SRuL7jUc5Hfvz8X5T6SSnA/ygb+M2tMNTIxU4DoKnha2jQcS89kSrBmLXB3HXsnlVZQ98/KHBiNs35ul66loegea7v24mc570F9jwzGRfQRZ8Bx26Bt99xJwZzDgvamufrB95BUtklVWMHalzHGsnMp9VOQkeb5bAosP3KL2GMXPkcPyrC5LEc8BjUXuR+awv5si+GCriCys56jk550rJNJVGFL74i/KbCuIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(53546011)(86362001)(38100700002)(66574015)(6486002)(6666004)(6506007)(508600001)(8936002)(83380400001)(186003)(26005)(2616005)(6512007)(5660300002)(36756003)(316002)(2906002)(66556008)(66946007)(4326008)(8676002)(66476007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVNYM216bWwxZVZyMUxhaUpNTWxCUm5aUVRsM3lvb2hEZXVzcTQvbStqZ1JB?=
 =?utf-8?B?bkp4VThXSmdmenFLSnJoZm5qN3c1dkdxQnp5ajY5WTZ0anc5d0lRRDBrT0I0?=
 =?utf-8?B?bHlnZTd4MWc0NEhhWmVwR1FnMG1VdkNEa3VITHM3bUNqL2JLdEZ3NVMvVTQx?=
 =?utf-8?B?VURQa3RJdkswZXZlak5HNjdOSThMbUdGc05jV2c4ZmorcHhMTWtqZTZ3V2xj?=
 =?utf-8?B?VTVLais4UFlZUUYxQzhmSHpkVmpRZzNCOHN4NjlOY0NxRHl4U0JVaFZpcXVn?=
 =?utf-8?B?TGFyTWxNL2hmNnpGQmdSaHVqVFArWk42L0l4bnc1bXFESUQ5UjBwcmhVdmdM?=
 =?utf-8?B?NnJ1dVM4dG82UGRuSklLb3QzdnRZTVRVYkxyR1NxRmhrR21VU1VJbFBnVzhR?=
 =?utf-8?B?MllMbGFncDBiMGZJUm1OUzFmRFJ4K3EvcTROS3IyV2lhcVZkZFRWQVBvUzVI?=
 =?utf-8?B?c3VndUhCcUhTQy9UbHFoYWlQRGRJaU52cDBTNkdCN0x2bGErMDVRWFZRMHpR?=
 =?utf-8?B?SXdaZ0RHTlZCRERlS1RZL3pkTDV4cW1lci9udjJmVWk5MDl1L00vV2JNTHht?=
 =?utf-8?B?NWZPcVpsVzBTL3RxWENBWmM2UUl2cno5VmhKaFdlUUFJMlhrU2tNMjNkSlFz?=
 =?utf-8?B?ODNUT2tRbW9CeW1DWWxLaEQrRGhFMW1yWld0MUlZYnRGVU9vZS9UNDRKYW5v?=
 =?utf-8?B?Y3ExTDBPem5VMllQamh0aUU2ekl1NTRNQ3UvUjIvVUpEYVZGWmhvbzVZQmtN?=
 =?utf-8?B?RTJxNjdKRHltWENYUmNEZ1FlbDRzcjM3TVVoU05WR2VTNEhGbklRT01tVEN3?=
 =?utf-8?B?QUUrQW52aTJ3Q0FYRkprUXJpb21IZW9Wd2dNTzFEVVVTNldyL2JkNVR2dzEz?=
 =?utf-8?B?aFVyTjBSMkhvQThLN0FTRzRYTWJvSnRXVy91ZThVallYOUlUU3hxd1JuQjhv?=
 =?utf-8?B?MjRmSE9MdDgzRTE4QU5VQnNIMlFYUDNBak1iNzdDUzNCMyt6SHVCSzZWOWRk?=
 =?utf-8?B?cmNtQ0FlbzB0cDZZWG9GQitoOGhFK282ZzRBYXVFeG1EcTZNSSsyaGhheVRn?=
 =?utf-8?B?VUhKRTJqSHdUNXlSNXlPd2JLUVlSUlBLaXdGRitJL3NpREI4bVlGRFQxR2RO?=
 =?utf-8?B?Tk9HZHpaM2NjMGZQeG9abnZMV2gwNUFJU0FyL1F5UEYvcVhOeFpxM2s0ZE9i?=
 =?utf-8?B?NUkxTkVsdEVDRGZnL2QvbXYrZ2tQK2QrWHFaczA1bmhYaEMydXNEZkcyeHN1?=
 =?utf-8?B?NFZYWDVQZWgvNjk5MDdCakwwUzRLejZMcXN3UzY1U1U2Um54VkhZYVRybmZF?=
 =?utf-8?B?eW5wbnlTZGZxU2V4TUN3VHhXbk5ORWZCdWlrTk1jNjZuZktSN1FwSFJCNVc2?=
 =?utf-8?B?SVhyUkE5dkdLRkgxV280Z3VSSTIyTEZ2ZHByY2xjNlRLSEpXd0l0QzZaMzV3?=
 =?utf-8?B?V2tRV3JiVldta1NGdEo3MDVKbkxYS0FXY3kxcTdiZUFldFF6WlZ0aVFmQWxS?=
 =?utf-8?B?clNzVXZJWUswUEQ5VnB6RDQ3RkFQS3l4SlkzdTNEUWVsTHFhcWlldzRsT3c2?=
 =?utf-8?B?VkJaM2h2TXhodzJ5VGt3b1hRc25yczc2ZEE4YnN2bVNGTlFKWXRUNDJyUWFp?=
 =?utf-8?B?b0RYSWUzMlE0cWp2MTNYdHNPckJvckpRelZVSjlVeVBOQkhFdm1QakpPNWxY?=
 =?utf-8?B?SXlmUjdEV09Ob0xwbFpYVU1sRXRtNHhtVElhRUV2dEZwVHJ6RGdyYTRyRGEz?=
 =?utf-8?B?NUlUM3luWGNmL2U1R213ZXZzZmJDSy9hV2poVk5RMG12cC9ZVEF5enR0VTdl?=
 =?utf-8?B?Vysvd1lQbzFJTll5TWZOZVNCOVNqbHpXNStiVUtycXRUS1FuYUpocDRmOGNE?=
 =?utf-8?B?b0xKZEJzVGo4eFhOK2J6NGVlbHVTSFJvVU9VUFVXWGgySWt1Y21lODEvekRn?=
 =?utf-8?B?aHhSOTE5aURoejdjU2lXV25NMTVWKytwRktGYmE1dTlOOXpDZ3NtOWVST3oy?=
 =?utf-8?B?Rlh4OVBUS0NieldZNWZyNlM0YkwrYjB3QkJUaGpPK0oyeWtqN2lzb0FrSVRu?=
 =?utf-8?B?VWY3Yk82bUU5ak1CTjgxbGZZM2hGM2t6eUVNQzhGcURwMTZ2WFdkeVh0WS9Y?=
 =?utf-8?B?VEQwTFhtSnZKR0ZEc2ZKckZ5ZkErenN6UElEcG9PZEVHV1BOdTFUMlJNSXky?=
 =?utf-8?B?RFByb0wvYm9TTEtGK1FjVkRWcE1OaGlkZ05TV05YaTQ0aXNTQ01WRjNZME9R?=
 =?utf-8?B?eGxOTFQ3RjBSMFAxa0JvbkdxcVpHSWpUdUgzNWR6Z0NJemowRUlQS3NHVGE0?=
 =?utf-8?B?U3VGaHR2R1JwMXd0b05KMkxrejBLYU1XTDJGM3VIaFh3bEhDWE50QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5091db6-7b2a-480e-b340-08da329acd4b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:36:08.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2qCDO+0ARf7GsqgaAzI4K8bA8P02BhLjg0B1AJswmFENb0h1d5RQYD3HQw6kUXs5hMAdRZfj5JBZ8oOWCwFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3879
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/10/2022 5:06 PM, Christian König wrote:
> No need to have those in the header.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 27 ------------------
>   2 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 51d9d3a4456c..7a5e8a7b4a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -50,6 +50,35 @@ to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
>   	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
>   }
>   
> +static inline struct drm_buddy_block *
> +amdgpu_vram_mgr_first_block(struct list_head *list)
> +{
> +	return list_first_entry_or_null(list, struct drm_buddy_block, link);
> +}
> +
> +static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
> +{
> +	struct drm_buddy_block *block;
> +	u64 start, size;
> +
> +	block = amdgpu_vram_mgr_first_block(head);
> +	if (!block)
> +		return false;
> +
> +	while (head != block->link.next) {
> +		start = amdgpu_vram_mgr_block_start(block);
> +		size = amdgpu_vram_mgr_block_size(block);
> +
> +		block = list_entry(block->link.next, struct drm_buddy_block, link);
> +		if (start + size != amdgpu_vram_mgr_block_start(block))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +
> +
>   /**
>    * DOC: mem_info_vram_total
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index 9a2db87186c7..4b267bf1c5db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -53,33 +53,6 @@ static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *block)
>   	return PAGE_SIZE << drm_buddy_block_order(block);
>   }
>   
> -static inline struct drm_buddy_block *
> -amdgpu_vram_mgr_first_block(struct list_head *list)
> -{
> -	return list_first_entry_or_null(list, struct drm_buddy_block, link);
> -}
> -
> -static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
> -{
> -	struct drm_buddy_block *block;
> -	u64 start, size;
> -
> -	block = amdgpu_vram_mgr_first_block(head);
> -	if (!block)
> -		return false;
> -
> -	while (head != block->link.next) {
> -		start = amdgpu_vram_mgr_block_start(block);
> -		size = amdgpu_vram_mgr_block_size(block);
> -
> -		block = list_entry(block->link.next, struct drm_buddy_block, link);
> -		if (start + size != amdgpu_vram_mgr_block_start(block))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
>   static inline struct amdgpu_vram_mgr_resource *
>   to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
>   {

