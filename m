Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E81C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 19:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB5E6E0AB;
	Mon, 29 Nov 2021 19:24:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2586EC16
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 19:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8uZm2Zwu8wzM9KhNpxqI9wgt29LU8/N1WQRYe/x4Kw2xt0RIJgzjjomkFXkmgSpYcvY/g9CPYSUqtulAMJQfbupdUsdOoJ5uJHNpgHSjuR1iN9g3NHIpl32BBDlqsad+wP1HftTkr0u+/fv4uJGcOcX0SpWVPNx8LBoWH2aaJQBq3UiworGvejQqhkTGE70Q0XY1BcIrLcFz8XYQYgYt6nb/CKswXDxSdlbjYc+AU9Mdo0wTelNhSqN6F/3vwCg8czFP+tCT2vNYwpC0rj9XIGbLKsoBx8i21GHKviDDZnk9TFbf+yNlnNtvbeyuryVTr+uG4AAgT0jDQ5ZxW+b5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKQNYMdsXSE1HR+X1TUZM2+wLSsR3ENPYL7LAys3UNA=;
 b=nNx4nZjyRAIj6je5ukcfjFTAr/QKWFINB6AVaRcTcDN2PEe2YGoTTnKC+OiGk2bE2TDjjPlL+u0C9SzhxrrUsQFZZtM1DwjX4Ru8aYPnqCbgSZA9HOPvAyewuoP4u7OP7Cgu7c1AHlJ9dgzQmQbFmlZjKfxNAH2/RVuds+7YcnXlASPeVvOKmpgUG/dpVUZgVhW+tqo+2q6p7umRGRImPk6VlPf5TJHBBFtJ7CamwGoShoM/vpkovVI/VtCwz5nlwocJgD+je8MaNaqKYHg39V/P+XtEVA+ft6TMK1txhqfGql2EHBxAHtLRXyGhsQRXfXWas+my5lQCrrDjA+vgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKQNYMdsXSE1HR+X1TUZM2+wLSsR3ENPYL7LAys3UNA=;
 b=qVKxP2OT4saFIIUgAu5LGOGaJnxaQWk+JKIuA+ds2pudQYQoh31eU/fGdjLkS7CtZKslAplOQTph+suaPZ8eAHnrOLxb+SDZVGIaz6kZDzenAvE2OmS7zGWSAxCmKz2xaxer7H0au2CRKYhtziPDvOxvD/+x1Rh3pZ1gCuI/Br8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 19:24:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 19:24:19 +0000
Subject: Re: [PATCH v2] drm/amdkfd: fix double free mem structure
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211126235837.11229-1-Philip.Yang@amd.com>
 <20211129191445.16688-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d7e7951c-ebb3-0e75-9d31-6626c542024c@amd.com>
Date: Mon, 29 Nov 2021 14:24:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211129191445.16688-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 19:24:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70146dd8-bbda-40d2-405a-08d9b36dd724
X-MS-TrafficTypeDiagnostic: BN9PR12MB5209:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5209AE55EA06E592C0A2ED5492669@BN9PR12MB5209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5IPmSmDbOHLmmysC51H5Y/fQIAE6xMqFNsK3dl8eC37wV/B4N9n/Sl6ynaJlFA23RCDKmMNGd4nKNkrh2zVbtQmB/3H2g3uayEPAhW+b1nFWWGAyQri1+pTLoGyCgJknPUkowuVkz+cKZ3bf7glhvDhlLtEyG1dc49GSDgTsJb4bNu5wpvq6BzWCf4YgIVpoI/kx81lNLfW8/V89QJZtb3QwdCAxo2uItG9rSYsZtCHvfF99z434cza90IaUFusvavn/5DRryQDMjk+WWMHWZ6OXSw/cbc1i82A7KJ8QSKhvkJJKJG2rkIZR42Jd7w4f09Jtmx5DOhS7T2N4f9OQPxCBMyit8kud524TY9dJuyZvUMlDh3yHowKN4Hm7tdeLEUtm1dmxqMDSdHtX/4oAlGVLhVaNbaeukGqJIQWTZS3nuPdsybkHttVIbPyd2pqXhY8vRGQ4Ato+b7z9zmGyMOJ0W65KVqRK+ybP4EglhqOYrZL4VcAjzqTU/ELT8Gj7NKMpaNcAgeIamEgI8juFHt7GRV2sF73ap3FT4iu3crLTszSe2nq7jx8LoNgIZMykAxHSwUWxZ8RPZ+A0L8VcX2285LkSfD0lWWU9KDXgz69LlHgC9mGttoqoPCQ134apyY8uckozjnSQtVEjKnmY1UjCCqko1Ivqoth8qL+c5qdeOk94CvhHl8eWwxU+9CT6icnFncdySARwsRkaBFzpXMq1upoASJlzpth4R9oJIEFqMa1KmzPpyhUUX4muuGd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(2906002)(36756003)(83380400001)(38100700002)(16576012)(2616005)(6486002)(4001150100001)(31696002)(5660300002)(508600001)(956004)(8936002)(66556008)(66476007)(186003)(31686004)(316002)(44832011)(86362001)(26005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC9yNUkyWmtqeFpCY1BBeHZqTWpEQnBNY3E2M1dlb0dEcjlIUEMvYk9ReENy?=
 =?utf-8?B?NFFCVVZLSTh1eWYwUWYvTCt6aVA3TTYrRi9aMnNKVlF2cVRhVXkyTlNpTFlP?=
 =?utf-8?B?b3VZUHNRYXBUMExYQmpFbmwrRHR3eVdYbzNuR2w5ZExGQVlvcHlKYm10UVFW?=
 =?utf-8?B?WG4rSk42SUZraUJyMnFueEF5dmxESTZ4eTRFVTRvZTBqdWtVaitGSHFBdXhh?=
 =?utf-8?B?UGtBRUtpOU9ZYlpzN1FSNkgvTEhkc2Nzb1JGUGpEVEgzTmtRamx3d0xTQXFn?=
 =?utf-8?B?MHlaK1pGZ3lqdVYyZW16NU92Sy9NWmxJaEpxMDRpYWEwZ3hKN2JsdGJSSUpo?=
 =?utf-8?B?OUtCUlBQMGllZkd6UmMzU24wZ0ZoeEI3bjZsbjF5VHlGZ2NsNmxhSWFWTTVO?=
 =?utf-8?B?endva1pQRzFlYm1XdVB4RHRNVVNwTTBscW1IMWppM3RweTloNzlTTnpCb0V6?=
 =?utf-8?B?MTdKUzJlbzdyNUxUcjVSOXBSMk1Xd3V5VnpGWWs0NlpnN1UwTUgvRXpiM3l3?=
 =?utf-8?B?Y3VGSTdiOHE3YTgyTkJRbVh2N3FHbERwV3RhRExZMDlKREJJbDZieFM0YXRI?=
 =?utf-8?B?V1FXby9LNFBlcWxzNG44aVhjYTBSNzRMS1pNV1o2dS90UCthcjd2RktQL2FT?=
 =?utf-8?B?aHg2ZTNEa0dwWTF5SkN3T0oxR1JpazZvS0YrNi9CSmR2YjZ3Tk1nQU5OU1RU?=
 =?utf-8?B?NkZUYzJaeURGRlNNYTVScUUrdFZCZVEwQkFidU5SRGRPSlgyTUFSY1B4KytJ?=
 =?utf-8?B?eVF2S3M0SUY3TDcrUkt6TVFRNWN3NGRWVkgvV29WRWFzd09SeUhBYTJyRmxm?=
 =?utf-8?B?ZG82TFMyS3F3ZWM2RzA0bDNHK1ZPWkQ2a21zcEJwWVB2NXBUMXJpSHVmRTFx?=
 =?utf-8?B?eXVBUWt5ZlV2cmRPSktwdUhIQ3hPQ2NrS21XQytiK1FxNmNjRld2UGh2Sklv?=
 =?utf-8?B?eU9EeGdyRWlxQVBLMUJ1R0R6L3ljR3BocHhWbEs3cng5WWpTbXBXeTFZMmQ3?=
 =?utf-8?B?MEY5clFJbjJrSXhCWW42dWVRai9OZTVnalM2RGJYZ3ZPYUVNYjBJc3BqQVQ0?=
 =?utf-8?B?cHoxMnlBOUhGbWRxSUphZWJncnhPVmp2RTVqZVBtSkpWV1hqM3hTdnR6Umkv?=
 =?utf-8?B?dWQ5WXJjQTd3NklTdWg3T1VuNkNtZXNuc1NETnlITDZBZ1VMdFlEM20vekwr?=
 =?utf-8?B?S2QxNkZVenlyWk5aMy9pTTExNVJnN0xqenMyZ0hUZWJjUHFkUzJONFUwUmM3?=
 =?utf-8?B?UGR3V2xRN0dlTE1OQnBIeGtOeUwxU08vVW5zOVNXVHpNdnJ5U2QvYTNwdncw?=
 =?utf-8?B?S1g5VUR1SStOZjBiQ1lReTAwY0d6akR5MVRxRFRzM2cvRGdObDlpakEyN0FW?=
 =?utf-8?B?d0dRTmtaenRxb0hxN2Q2cGJWZG10VXZXUWllM0ZPbjBCUHNHMkZBUjhYcDVL?=
 =?utf-8?B?VFR1T0JzMXh2V2VUTmNZd1lKTmRCdlE4cm51K2NiR1Y3T1RtbkZOYVAzeGhs?=
 =?utf-8?B?c3FMSW84clFYam13MnN0ZittRWM3dDU4QVdpekNzT2NrTjB2UE5jaXZNZHJT?=
 =?utf-8?B?cHgxclIrbDZQQWJpTHpUYkdld1BWTmdlQ3k1d3NwSk5TbEFTSzE5MWdFZWJq?=
 =?utf-8?B?MDdUejdkZjdNY2tBeURjaDNpdm1jR0ZyTndCd25meFViTnIrWXJRTlFubmFM?=
 =?utf-8?B?MmdKWlduZzZJSkJIdXlmYk4zQUNjYzlMbWVLSGc4V3RJc1V4aFR0VEdnb3ZO?=
 =?utf-8?B?M3hVMUY3clVzZytIQTZTcnlpbHZMYVl3MnM3TUV4ZnloK0F4cm9hcGtYd2RM?=
 =?utf-8?B?LzhMVFNZa013S0NobDNIejBOeXVGVFRqR2FwamxPYUxBanRoVjhnT3BVb3pV?=
 =?utf-8?B?MVRRMWdJU21SRTFpTnI1Ymw0cms0LzR2NC9sYkQxVHhESHI3RGlENGZJVUlN?=
 =?utf-8?B?TWlMUjBQTkpwMVFEMDVRSi9NUmV1M29LSnV3a294MTRZZmtPTE5lTWpSRVFn?=
 =?utf-8?B?Z0VmVnlxaXZrbFQwSG1zZ0RlaFZaNk84RWNEeW5NRTZHRVVZZEh3RUZKdjNh?=
 =?utf-8?B?ZEhmcGZqNzNCTU9FODNLTHRzUXlXcE5ndVF6TkI3Qy9Bb084RkRwNXpQUE02?=
 =?utf-8?B?R3B1VW5HeFV2RGNPd0wxOFo0ZWN3bDJvVVhrYmtjcTBZRjFhV1k4THI4U0Mz?=
 =?utf-8?Q?xwdGXQ5XmZbJM43n88yoDB4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70146dd8-bbda-40d2-405a-08d9b36dd724
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:24:19.3124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cs5T7DGMtos4eFVShrUxnT7W6tCFpmcx3/7b9xgkSpVAz0YIYydJNZI7w6DahXnpzzpndmnuq5CqRNvGiH3cog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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

Am 2021-11-29 um 2:14 p.m. schrieb Philip Yang:
> drm_gem_object_put calls release_notify callback to free the mem
> structure and unreserve_mem_limit, move it down after the last access
> of mem and make it conditional call.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c5362c23e687..5df89a295177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1460,7 +1460,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  	struct sg_table *sg = NULL;
>  	uint64_t user_addr = 0;
>  	struct amdgpu_bo *bo;
> -	struct drm_gem_object *gobj;
> +	struct drm_gem_object *gobj = NULL;
>  	u32 domain, alloc_domain;
>  	u64 alloc_flags;
>  	int ret;
> @@ -1582,14 +1582,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  err_pin_bo:
>  	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>  err_node_allow:
> -	drm_gem_object_put(gobj);
>  	/* Don't unreserve system mem limit twice */
>  	goto err_reserve_limit;
>  err_bo_create:
>  	unreserve_mem_limit(adev, size, flags);
>  err_reserve_limit:
>  	mutex_destroy(&(*mem)->lock);
> -	kfree(*mem);
> +	if (gobj)
> +		drm_gem_object_put(gobj);
> +	else
> +		kfree(*mem);
>  err:
>  	if (sg) {
>  		sg_free_table(sg);
