Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69477C25B0C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 12:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B72D4C2D;
	Tue,  9 Aug 2022 12:58:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E409ED4C05
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 12:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq3JP0leNj4VPX7Mo1xRoynjj+5MdPuii3MHXlWhUna7Pw2dsDd99cZO1zcfXl18noAk7hHSSJVD4chcuCJqSSDR+CPcbjAOZDIIfzLejGBCpKuYggtyoEfXq7vOX6WbCTB1OhEQvfgsjO87vGh6yKgPJam/wowaP1hiRjZexWMju545jqccOPQMlW8BSiUC8bLNfECDvm3PMqA6rcpb8rfBEofDE6LFcVahIIEihgbyHTU8iYHhnKtcvUA4SDhouPnLGlO9o5dqF/D/fKNIzk7Xy98Cp/+RAU63tPZznIsQqZngBx3IHdU7HSBiUjLjQdNO57BOgtGTwzm/0SPWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBUuOIQNyJeImpIW9NWxi63XqIT0c/4QzHz6nodA9Ow=;
 b=g3ovhDVW2sDgkQi0jbACTNW70M4pCff+pDlYC28vjZFjUOMPArLmAfP+WlYXThgUEc0sYWRRSYrW7ME+WmIZzyOAgUqDb9UuKDQOpPxVutXgMnf8Tm7O9w/Xny0Dy+o1UWW0sVibrNb2t5uSK6Hcse2R6YlfF+D2+8HM+UKIkr/mxTzJAcgZHtYb0aOyB9JUfNSvosxKe+TLCuHJa2BQOOBLSrKW7FeE55BUdEF9lry1brrWSs1UDJeAxBb7N0viPubZpRI9SXRPopuw8+GLXlS1A4EW+6Hj5XbQ/UEMrkyO+K6jCPfqb/zKxZKXKAyhA279u4+hEPrC6pOWyWQHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBUuOIQNyJeImpIW9NWxi63XqIT0c/4QzHz6nodA9Ow=;
 b=lId2LUjfUQCe7IkqQQoNAecttvbQRqm8cbQED+gZwXjOeDWMxE6nWKbr4Ig1BdmlsFYjD7z30BVNU+g/HNn2j1wSSI/DkEubieyP3cKfp/awNCjGfgb1Ti429fJB4Ao3iQw+Jnl3O58JIlQh7yt6Nb1UgyIQv3rGcDrtpwkxAAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN6PR12MB5696.namprd12.prod.outlook.com (2603:10b6:805:e9::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 9 Aug
 2022 12:58:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 12:58:33 +0000
Message-ID: <43efcc28-3c8f-d197-7f0b-8641d29714b8@amd.com>
Date: Tue, 9 Aug 2022 14:58:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Patch v2] drm/amdgpu: Avoid direct cast to amdgpu_ttm_tt
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220727195149.21235-1-rajneesh.bhardwaj@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220727195149.21235-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc89d19-b97f-4844-98e0-08da7a06dd6a
X-MS-TrafficTypeDiagnostic: SN6PR12MB5696:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzjNtwLLLHWG1kM/M5NM98pRKf9rMy3/TvuYt2ChEfMZogsaJWO1FOuynvEx4rlMXA9RPC3Apj5ttU7MMkKLkF7tFiOrF7IwArW56ZaCwHri9djTcz1Hk1ptmnr5phZMwk9yh21lYtxvhiGdbrvJHnlCJVC74IS/lpHezDXE1XEDUMgvGVuh1IRw+SvLRrhsVZK6t8CcqbDaSdNFAVCUDV9w4JViJJYg/ibvDkpeHrDGiO8ihnRjduKzMzW2Y34sjzgS+BHcqOj7Zvj1xzE2wjxNEMg7NbFQlbrLrVjXrvDS0/E4PoBHVepYVGgBpTMRniYTZIYhnG8vRiqs0tDHYr2byOMtjSZD8bIFz4uu4AmRb8lyT7NEBtXqW/By6gdb/DooRB22kyk0O4P1KTcrFn4DEF7DAKp3vVRjvttLMms2pn0XqlUVUv01tqPY8S99daxg7srzCtvic0cY5eVqb/JrUZaiD2SOrkyA/NdfwUuJBt35CjlBOnbkjCwOQZ2o3RT/BR874V0lj2RNSdg5WT5w83EYHFeiGzWxd++agn9opJJNWgGIBybj2ZXTz1avyqxsbG0LSS7sz8AqxFus5YW8pYrLsTHTmErxGm4b9CWt1HnjjsRN6hbILfn0cPU9cYvCxNB+nprUb3cXtZ4SIDcKZKbwEtSb3FYfjaWV6vGVX52ZgHARaJbwFeuVGNIn7RnUCPkhtfVIPLN+LHFeQF+7Zo8rQWcIjIeeom4n9ik53q3ilyj29PW4eNtjtRKksDeDnZVbYJ5iYlf6i83kx2RLyGdrua5c4JWMgpN5Ywy6xCO2x8ZQC23GLYTdlBfRKcCbn5HQ/+cqD50fmefC4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(186003)(36756003)(41300700001)(8936002)(31686004)(83380400001)(5660300002)(2616005)(2906002)(66476007)(66556008)(86362001)(66946007)(31696002)(38100700002)(26005)(478600001)(6486002)(316002)(4326008)(8676002)(6506007)(6666004)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFlETHhrV3V0TkxCSWtqZzRFaWl1OHNsbDhpNEhDTnJ2OHFNa2dUZnZZdWVI?=
 =?utf-8?B?Vm1jUlFqanFITG1XTzMvVnlOOVc1WkpMRFIvNDhHRnUwZmZrbzVXblRnQm5L?=
 =?utf-8?B?UEd4d2JqZzg4S2hUQnVXNWsxcXNoM09EeVFnRUhlRzEveENMZFNyUHpYcnll?=
 =?utf-8?B?M01sYzJzV1hLbXlCZW0yWUpYa2ZUd1FINkNCSmR3UzJzZWlHcjFJY2Ntd0p1?=
 =?utf-8?B?SXpoU3I5cVB1L3pmNUpnOVY2UnRwQmUvdWFGay9CVitxb1VLRFpSWlJqWjdC?=
 =?utf-8?B?ZzNjL1gyU2gvckZwWFplRVNPWHlHTFpxb2F3dGhoQ3AyOHFyVW13WEo3UkZX?=
 =?utf-8?B?ZjRqbEVTSlFBd0lkR2FhZGhBRWU1dlgxcHgrUXNrY1hUYTJ2bTdZT29HQ3h5?=
 =?utf-8?B?ZzFvUmpVbmV1VGZBRVBxM2x1QzJiTG5pRE5NVVUzRjlaYzQyY2ZaaTB2ejJX?=
 =?utf-8?B?ZEdjWU4wV25XZE1qK0ZQa2dsV1dYSUZuQkV4aWZuc2RFQWZKcEUwd1hRcVlm?=
 =?utf-8?B?MEl1UVRhZ0NVdjVRK04zdjBTN0F0VExOZ204UWlGaVJZU2dualh5ZnN0QjJm?=
 =?utf-8?B?anNwc014dUxxZmh0UERybDZqZURUUVFvNmxVa1hkNnVOZXNmOEFhbDlSTlR1?=
 =?utf-8?B?Qi9seUErbG1VS1plN0l0ZzhPVnMyOWsrUkJ3bzdhYVpza3J1Q0JkUGlCREti?=
 =?utf-8?B?emg1Wmd1Sm9LajJOTEI5dm85bFNpV2lEZUVyb1E1MW9vaTNDVjd2MzM3ajVu?=
 =?utf-8?B?UU10Nm5LUDU0SVVER3RXY3VaTmhva3RDaVlVd2pOMmZ2Y0dTb3MrNUc0UVBt?=
 =?utf-8?B?OUVSVEttRkJ5N0JERGtMRjI0OS9oVG81WFJtMWpiTVJ1VnBQNVlpMXR1bFdo?=
 =?utf-8?B?OUlyZXM2cnpzK3hnS2JXSnJKL1RmY1BHMzE1TzNqMDk0VnVONEtVRC84M0ZV?=
 =?utf-8?B?QUJZMWFQNmdCR0Y1cmZiRzFjcHZCVzM5ekk1eGJhdVp3VGpWMVIxTXgwTUs1?=
 =?utf-8?B?anJxQTNva0xBRWJHZEFmbGhLUTkvWXE5NTB3S0NBN0NDWVZsTkJZcVVYOXdq?=
 =?utf-8?B?dVkydW1sYnpQYjZBRmpHR0dQUTRDZk0rTUpTOUNlR1dQc3B2VWVXU0kycEdQ?=
 =?utf-8?B?Q2xOZExrMDJPRkl4M0FYZlJZVmhRS29LdC9QUHpZOUxHN1pUWTl2MndIOTZS?=
 =?utf-8?B?WUEvNmVUbnNIM0lkcjdSeXJuRFY4clJSL2dFc1l6enBBL0ppcXcyeVlkZ1FE?=
 =?utf-8?B?NU1YSHF5K01XUnRYVzJtNWhNMVN6bWhMU2tGLzhaa1VTRXRocEdTR0c0cC9E?=
 =?utf-8?B?V0l5U3NwSVpvZHVldWFPbVE1Um1JTFBtdGp1enFhV2k1VnJGNkRsbzVlYnFr?=
 =?utf-8?B?dk1OS1NFOTRKdnJVNlk1WnZmcEZ2Y1d2ekFVNDB0OW5sS1hyNXRWS1JmZXFW?=
 =?utf-8?B?WHQ0Umd1UW1UMkQzSEpHOTZUQ1JPZkVNdHh5eHlld0FCTVpCYkhSOHE5dkVL?=
 =?utf-8?B?T2w1T2hWMUlDdldGVEl3K2dWcHRYTkc0WW5sWVAxYWxRZ0Qzc0RIQVZwWDU3?=
 =?utf-8?B?UzQwYXAzRHBwK1IwTmRSOEYwcUxRTkZyaXpuc2VkQTh6YVdKVURGMTVvbDdm?=
 =?utf-8?B?dno3Zi94N3ZkOE9LZmNGZU1zTTNUMWhLSllOUnFpSTYyQzhkZUhhWEJRUDBm?=
 =?utf-8?B?S0hzalYrbERTWkdnMHN1VzhpMWVqVE41b2s0NEowSVR2bUs0NWNYSWhCc0pq?=
 =?utf-8?B?ZG9IRU5pR3psQlFXaHZua2kyT21JdnNhbXBYRDNYV0JkZ0k1T1Z6R1p5dUI0?=
 =?utf-8?B?K3paaG9Zc0I0SyttL09qS0hMc2kvb1c2U3BIN1ExQ1A5b0RMeEp6czJCOUNN?=
 =?utf-8?B?cHRxamtDVC9TWEFWOUtZSW1PYW5Hb1NkSURrQm9CN3dlVWI5dVV3aHJJMFVl?=
 =?utf-8?B?TjcrRWlpSTM4L0tVcVVLb2JXeHBhNU1TRUlKQldLODRMeFdIQW53djJLaHZ6?=
 =?utf-8?B?WTA4Zzc1SHFHZHhjTTRtUC8xQ1VJT3UwTW9Nak55aG1pVWhJL2FIeXRFVDZL?=
 =?utf-8?B?d3QwdlY4UTY3Q2tSTjh1TjF2WkpYbFZYUDF6RTlPQkNZa3Qyc3ZYQXlEN0Jt?=
 =?utf-8?Q?894uRnz7uIsBrh099BbVu1fRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc89d19-b97f-4844-98e0-08da7a06dd6a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 12:58:33.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzdUV0WWYtsuB2pz7RtemJMMguCmwjURhkX48ukuWyrBQxAAI67Yqv/+qRBFgfF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5696
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.07.22 um 21:51 schrieb Rajneesh Bhardwaj:
> For typesafety, use container_of() instead of implicit cast from struct
> ttm_tt to struct amdgpu_ttm_tt.
>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Changes in v2:
>   * Fixed a bug that Felix pointed out in V1 by updating the macro
>     definition
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 34 +++++++++++++------------
>   1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index be0efaae79a9..8a6c8db31c00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -637,6 +637,8 @@ struct amdgpu_ttm_tt {
>   #endif
>   };
>   
> +#define ttm_to_amdgpu_ttm_tt(ptr)	container_of(ptr, struct amdgpu_ttm_tt, ttm)
> +
>   #ifdef CONFIG_DRM_AMDGPU_USERPTR
>   /*
>    * amdgpu_ttm_tt_get_user_pages - get device accessible pages that back user
> @@ -648,7 +650,7 @@ struct amdgpu_ttm_tt {
>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   {
>   	struct ttm_tt *ttm = bo->tbo.ttm;
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	unsigned long start = gtt->userptr;
>   	struct vm_area_struct *vma;
>   	struct mm_struct *mm;
> @@ -702,7 +704,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>    */
>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	bool r = false;
>   
>   	if (!gtt || !gtt->userptr)
> @@ -751,7 +753,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
>   				     struct ttm_tt *ttm)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> @@ -788,7 +790,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>   					struct ttm_tt *ttm)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> @@ -822,7 +824,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>   	struct ttm_tt *ttm = tbo->ttm;
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (amdgpu_bo_encrypted(abo))
>   		flags |= AMDGPU_PTE_TMZ;
> @@ -860,7 +862,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   				   struct ttm_resource *bo_mem)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void*)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	uint64_t flags;
>   	int r;
>   
> @@ -927,7 +929,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct ttm_operation_ctx ctx = { false, false };
> -	struct amdgpu_ttm_tt *gtt = (void *)bo->ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
>   	struct ttm_placement placement;
>   	struct ttm_place placements;
>   	struct ttm_resource *tmp;
> @@ -998,7 +1000,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>   				      struct ttm_tt *ttm)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	/* if the pages have userptr pinning then clear that first */
>   	if (gtt->userptr) {
> @@ -1025,7 +1027,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>   static void amdgpu_ttm_backend_destroy(struct ttm_device *bdev,
>   				       struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt->usertask)
>   		put_task_struct(gtt->usertask);
> @@ -1079,7 +1081,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>   				  struct ttm_operation_ctx *ctx)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	pgoff_t i;
>   	int ret;
>   
> @@ -1113,7 +1115,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>   static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
>   				     struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	struct amdgpu_device *adev;
>   	pgoff_t i;
>   
> @@ -1182,7 +1184,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>   	/* Set TTM_TT_FLAG_EXTERNAL before populate but after create. */
>   	bo->ttm->page_flags |= TTM_TT_FLAG_EXTERNAL;
>   
> -	gtt = (void *)bo->ttm;
> +	gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
>   	gtt->userptr = addr;
>   	gtt->userflags = flags;
>   
> @@ -1199,7 +1201,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>    */
>   struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt == NULL)
>   		return NULL;
> @@ -1218,7 +1220,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
>   bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>   				  unsigned long end, unsigned long *userptr)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	unsigned long size;
>   
>   	if (gtt == NULL || !gtt->userptr)
> @@ -1241,7 +1243,7 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>    */
>   bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt == NULL || !gtt->userptr)
>   		return false;
> @@ -1254,7 +1256,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>    */
>   bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt == NULL)
>   		return false;

