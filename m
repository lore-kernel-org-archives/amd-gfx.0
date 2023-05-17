Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E8FC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 15:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B683510E14B;
	Wed, 17 May 2023 15:16:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B2910E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 15:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlMX5QRUI6ejSseTEzAzKDeL3TBxMAxgt4Pe+0v14ZYF/yLFWtlIhk/iPs8JpWYL1iM5OfVRJp3VHkvLA15E5bzW+nFbvcoX9g5KzhKcpjO30GWvVW8S22ATcE7Fb56wqSi45+vofgsmFyRXKQ6ao7QxcFNcezN1039xNc1M1VmNduA210vzAVMTZS7Ka9eNgLHLkAI9CsT6i+X5vrNtvIWnphQzYbGmjTfiR7vEwlqZVM8izMejQG/oOfZjo5Hnmsfgk2tbNzYryrjXXFECxR9sAR8VqcGHx/xDVZadBY9dSxKWpaJxixnrOAEfQw2aA0XZfsm+8nlRq5cTFPk1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rZq9dt0NgJ6BFBxbukHEO8/60J0toN+d6SPCB6Wmgs=;
 b=LIz3p1XMnG5Z3Z5ul6FjdQqSYLtTzkLGy07Bg5mc9zEhKWK3H3EpyRBxPq5+xeQlhoFOSFhmFs8sBfrgeQrNKkxGzgVK/TVC/OR0WTbzDVv9rAVHEv820yjAn4iNdd2r1jOxT6cUkSgKaXaLvbPnF+3P2XdRRdTtb7SxOqnzyym+VUBhkdmlYiVbg+ZWSxLZAbaX9MZDSjcCPlb+9+R9uSiqeDTnTCgCxkr0Jg4v1MONp4edDzc/QW9rMlvfbvFDIz0hSlRVxoP4CVPgL/gkN1/NrpkWKPxZPvusm1KkrDCnbmXOkfBRi/csWUUut6NXs7Aes7PBbnea+S2QVWcB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rZq9dt0NgJ6BFBxbukHEO8/60J0toN+d6SPCB6Wmgs=;
 b=sFrlnfcrasuwz654a9PwCZYl961D9NaMgex2Z8HL5hAtMbFIoTE3ShEKXm38ekvRQFqCIAz1jYldXm7h3yQg/N/WgP6BmGvmYS60TF/D5ukiYAFPFmhzSn3mFMDfqad9lGG0+18UhtKwG7Xi4MurgkSYUUrja16mAmcrjJsuGuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:16:08 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 15:16:07 +0000
Message-ID: <72b1cd65-c580-0b9e-4690-09c29430d927@amd.com>
Date: Wed, 17 May 2023 11:16:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix error & warnings in amdgpu_ttm.c
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230517144544.2326651-1-srinivasan.shanmugam@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230517144544.2326651-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b88df8e-012f-4154-661c-08db56e9a38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPWioasitLkkrOmgV+ACNugjl6kt9vpvzfaZMMK/EVNf4eDPXUN+asLMkXLhPuiKbgBx3VmzAYIiobUL+6bcAeNeCkNfrXaBSR2ojzf4rHOsa4/sRxONTxjBjSXTKDCrsBfmqvHdduyhVs7OeooWsIZuA0oAwngl7DKY0rQLucTHwebGvjetNqXObR37PKgD9YgRkSXrfOk30+tcTJv5p2odMpnWYyLKFXFUtdzOrx7qBgY3jCLHxT6JKwJTXH5vbMTtRU2B+lBSeg9oqO5a9c8JjINarGV+7n3k9DjCjy9NhQO+n29D57GM6RZWkj11ZgZzE5Y9GxNvoXD1GQHUklJNkx4uS25Rsr1gZr4EmsEk6RlSEa7h9fzkGkh3QMprGmS2oFCFPCabBcFN4SAi4GOBnBzaorHZExuEz3hwyXiw7gPux+cmbfKIi0rgPx7Jl39Apr4+XTkTRu0xHrNbr4owv6yjZ0w2wwtVnV+8QgPZxxiuRiGJsDlgw96mjgUAyElv4LhkDtZqHB18d/OeaCIhwUFfFsrmFlULcT38a7qCA45Om9Ygw8WPC0BIZ1iBZunpR90QPYgbNa5u0Dg2zolsC/OjJL/lmefW+VQIxES3Rj3AvPpFQ65ltURSQReEKldF75if2tFt6G5mev5prw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(31696002)(316002)(110136005)(6636002)(4326008)(66946007)(66476007)(478600001)(66556008)(8676002)(5660300002)(41300700001)(2906002)(44832011)(8936002)(38100700002)(2616005)(6506007)(6512007)(53546011)(66574015)(83380400001)(26005)(6486002)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1qSjNpa0JXUHQ5VGFUZWFNU2E2dDllYXZOZXl1RWdIRFB0RUJOVnl2ZEVD?=
 =?utf-8?B?YjJ1a1BlRXFaMk04U0VxTG45L0lBNkZObUZwb1g3VzhVTkQwL0V4UnR0ODZv?=
 =?utf-8?B?bno4TEVUZmhlcDFzQXJBdnovVE50N0ZpU2FsU2pKeDNleDlTaUplcHcwVUVL?=
 =?utf-8?B?SzUrOW5EYWlrUjU0MUZxL3g1UHpiUjlMTlBLMzQrVTRyWEY0dW5RblVGYmw2?=
 =?utf-8?B?M0swZjh5SGY0cjlpWkV6ckZySnhDUjRvcUhwemtQSFJIQmhZdHBHNHFjbDhj?=
 =?utf-8?B?czM2aFBsRllNdlpkejZ4KzdVYU10SXBEOHoyL0puNFB3a2h3U0VQbDFiNHJQ?=
 =?utf-8?B?bVoxaXF1TE1nR0pJbHl2dFRZRlJPQnJLMkVtSVQ1bkRJN1FjMFlFcjMwZlJH?=
 =?utf-8?B?ekYzTXhvQ0U4ekFMNWlNcERwdFdLSXRHYlhmNG9HT1B4MWdYbkkzMEJpRGVZ?=
 =?utf-8?B?K2hJczZGaitwaEM2SFkxL2VNcmh3NUtQUGU5Vlo4Z0gwZTc1elM2M0FSeVFC?=
 =?utf-8?B?L1d1VDU5b2FmUHpiaWtnSHdoM0tUM1ExM0hmaWJuV0R6YTEzeHB0MG5LclFX?=
 =?utf-8?B?d2xOWlVXeDhOS0djOWNuWHNURTdEaURvM0FYdjlWcGRhSDQvaUg1NlhXZGdB?=
 =?utf-8?B?bk41cC82U2U5ckplaXNmQlNIVG1UUjRJaG12MWpZZzFldytCRGlVSFF3YUFR?=
 =?utf-8?B?UnFQRFdrNWtuZzFDaW8vbUlGUUJBWjBvVnRZSkpVNXlmZVF6ZHVEc3hQRWFp?=
 =?utf-8?B?ajduUGJyZStJeFdQeGNJV2lJelhBaTlrREZZc1M5blQ4VU8rVkNqbWRkVUpx?=
 =?utf-8?B?dFlmdnh6WVR5cjJVaElqUlFiU1JVd0hhVXBRMjhTYmtkekFoZ0k4TW5TZnU5?=
 =?utf-8?B?STBoM0haREhJTjhjTXdFY21ncEVMdmZHM0RnbGc0RDIzblFQYXBKaEw3ck16?=
 =?utf-8?B?OFAyZEVJckhWMUNzRCtuZkw4aVZ2WDhDamcwS2drdUZWcUtsMUxnNURhcENj?=
 =?utf-8?B?TEJRckZwaDJEcHc2dzRMbG14UjRxOTZtUWF3dk9VKzZ1VUZRRnB5NzA2Z3RK?=
 =?utf-8?B?dlZhVnE2SFBFYnZPZEZKTVhCV0JzUk1yRlVkTVdTbW5WVnY5cy9UVFd4NXNZ?=
 =?utf-8?B?MVZDajlheTI2Smx2Q0hCbHEza2U4ZGtzYmpiUkNTL1BnZWs0L29nQnNQOU53?=
 =?utf-8?B?UGY2R2k3QTNpWU1sZzZwVmdtQW5jL2d6RENCVGwvV0VkR1ZmbHMraHNRZUpn?=
 =?utf-8?B?RU1Tc0Ntb1VWMUtjTUVEb2l4U3Z6VEFiaThuSUxiaWdIV2gvTjlKdkNvS294?=
 =?utf-8?B?ZGxhaFBaSVpmbEhrVkV3dDdhY3dPeEVQM2dTZUVTZG5xSnNnMVYybEljNWJQ?=
 =?utf-8?B?YmgxcFZBYjY5V1JLaTNnRGkzMklFcjZHK0VDM2grMXZVU29qOVBlSnR6UERl?=
 =?utf-8?B?eG1QdDlzZ3NsZDhkZUd0dnlpRTVqaWJObjdSUFV3Rnhhd0ZNZnY1U1FFNDlH?=
 =?utf-8?B?QVZDT2FvdlZUeW5BVFBHMkZZS3lacm0zdUpsTnBLTDZjbVRMR25vRE90Rmd0?=
 =?utf-8?B?aWNJeHZyTi9YRWpQV29oaUVxTnJEdlpCR0oyQ3E2NEFsSVVRU2lOTW5XbGtl?=
 =?utf-8?B?V05HaEpaaTB2UXptdUJ5dlh1cnd6QktGWHRJNG9oSmZ0Mm8xYmNYQUYrMUpp?=
 =?utf-8?B?MjRUYW4zTHRqMC9tWkNEdVJlaHh5UTlUeVkvenYzeHVvbEZ4dHUxUDdmUHg4?=
 =?utf-8?B?U0cxRjh2ZUpUVmNkdFQxQjV4OTB0R1FSK0NjeGNoNGNXbm81NFZQRlR4TEx3?=
 =?utf-8?B?alhFU3o4c2Z4cmpWcDQ3YkgyQmsvQUt3aGR2TCtQUWNnbTJnK0U3UXVTMm1r?=
 =?utf-8?B?OXB2clpOZktSTWlDUEpWbUFuQ0x3MHBkUk9pNWNOMzJiaW80ekcyQ3VkVVFC?=
 =?utf-8?B?d09wMzhZWnJuY0JON0lFWlRYYytwYmRVZGhKbWRwZTluTU9KVlJiTEpsTktG?=
 =?utf-8?B?WjdrQWN6UFRhdHVTSWFlNzZralN6ODcxODE2MFBLanJYMEhOdHBVTzdVMzJG?=
 =?utf-8?B?eHlqajdKdHVrZ0t4L3ZyYlFneWk4RHRPazBUU3JZMXRzQzV5cUtHNjFzUCtu?=
 =?utf-8?Q?P6nE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88df8e-012f-4154-661c-08db56e9a38b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:16:07.6821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW+3kv2Cp/ayZ1Ny7SPmLxVT0mEZr2Wu0uTwtLvfvBLAm4cy2J012uOpwocDE9R/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-05-17 10:45, Srinivasan Shanmugam wrote:
> Fix below checkpatch insisted error & warnings:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: Missing a blank line after declarations
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ad664ef640ff..f6d9f904b20b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -65,7 +65,7 @@
>  
>  MODULE_IMPORT_NS(DMA_BUF);
>  
> -#define AMDGPU_TTM_VRAM_MAX_DW_READ	(size_t)128
> +#define AMDGPU_TTM_VRAM_MAX_DW_READ	((size_t)128)
>  
>  static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>  				   struct ttm_tt *ttm,
> @@ -184,11 +184,11 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>  static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>  				 struct ttm_resource *mem,
>  				 struct amdgpu_res_cursor *mm_cur,
> -				 unsigned window, struct amdgpu_ring *ring,
> +				 unsigned int window, struct amdgpu_ring *ring,
>  				 bool tmz, uint64_t *size, uint64_t *addr)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	unsigned offset, num_pages, num_dw, num_bytes;
> +	unsigned int offset, num_pages, num_dw, num_bytes;
>  	uint64_t src_addr, dst_addr;
>  	struct amdgpu_job *job;
>  	void *cpu_addr;
> @@ -1061,9 +1061,9 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>  	enum ttm_caching caching;
>  
>  	gtt = kzalloc(sizeof(struct amdgpu_ttm_tt), GFP_KERNEL);
> -	if (gtt == NULL) {
> +	if (!gtt)
>  		return NULL;
> -	}
> +
>  	gtt->gobj = &bo->base;
>  	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
>  		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
> @@ -1848,9 +1848,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  	 *place on the VRAM, so reserve it early.
>  	 */
>  	r = amdgpu_ttm_fw_reserve_vram_init(adev);
> -	if (r) {
> +	if (r)
>  		return r;
> -	}
>  
>  	/*
>  	 *The reserved vram for driver must be pinned to the specified
> @@ -1874,7 +1873,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  	/* allocate memory as required for VGA
>  	 * This is used for VGA emulation and pre-OS scanout buffers to
>  	 * avoid display artifacts while transitioning between pre-OS
> -	 * and driver.  */
> +	 * and driver.
> +	 */
>  	if (!adev->gmc.is_app_apu) {
>  		r = amdgpu_bo_create_kernel_at(adev, 0,
>  					       adev->mman.stolen_vga_size,
> @@ -1903,7 +1903,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  	}
>  
>  	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
> -		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
> +		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
>  
>  	/* Compute GTT size, either based on TTM limit
>  	 * or whatever the user passed on module init.
> @@ -1920,7 +1920,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
> -		 (unsigned)(gtt_size / (1024 * 1024)));
> +		 (unsigned int)(gtt_size / (1024 * 1024)));
>  
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
> @@ -1962,6 +1962,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  {
>  	int idx;
> +
>  	if (!adev->mman.initialized)
>  		return;
>  
> @@ -2090,10 +2091,10 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>  		       bool vm_needs_flush, bool tmz)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	unsigned num_loops, num_dw;
> +	unsigned int num_loops, num_dw;
>  	struct amdgpu_job *job;
>  	uint32_t max_bytes;
> -	unsigned i;
> +	unsigned int i;
>  	int r;
>  
>  	if (!direct_submit && !ring->sched.ready) {

