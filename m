Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5CBC00144
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 23:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939DB11AE22;
	Tue, 26 Jul 2022 23:55:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD1314BCF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 23:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/vio/aryxoMWwzCIET5O8Vz18gpbA0TLaSevyx1vu4YF0HEGErAOZVEZtEgsyW0slV4z1vBjvLGFyY9H1l9jpfrdCJy4BohbEW8yp/hEltN8BSWXm9qsfHBm4HPyGd1UyFiHHv4OlOIHuuz/MCq1ofMO2PHGSOYrfhxvVhMlYw97zRlPxT3w0uerTsQlGVMiA1gyC8ZOSqun+wHR9uLwo8kjpuccDOzLhGHeEgR/dZeEFIEouFTFgOpvHEB8eoIshdKiKliOiPRvwEE12SXOmgL/ZhDcUsftoRycPjRc93TEwbe/QZbCfyi2dCN6n+LUK0gom7B2Dt/nJfD9xHTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9PKCjo2LjgyNTGFIcvRGWb1lkzvKcG7nUxztttpXK8=;
 b=WarWpVLYL3Kq7ecpj1qrDv5OESkGZQg/eLrkBgmYPWRcrpodkEmO3eH+WvYct3YVt179tU7RchqpXq9G1fwQDAuQJE22bArC3hrhGk8Pbq8+AsBHqH57MUSgeJMMv15va1fREf5yMoz81QjaKKTR/PiaylWeH+uV8GhG1d+fxB6BGDHxEEMRdGybqJv+HbI6LVLgYVZ/ayJO0uOHs/ieiItubA7KmpgHPJm5rmB9EzsPsbJKJMRfNEK/U+Pfvo1iGZYcAHdkRdu0AsLW7SeNKoAgwe56tbp4N1ToqZSVKdyFvkUkU77WGePyCOXuecjz0W9hz0NaFDjEhUchYukHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9PKCjo2LjgyNTGFIcvRGWb1lkzvKcG7nUxztttpXK8=;
 b=2dyLOSIirkBLB8/IFeTv03sPDsEi2XfalCQfaL0+bTbZ+F7CMqKYvp2/JP8VpY5DpGgqJ4rkv68NkbfjsnJVjN5+Qy/i6aOvmME3fAszx7dqZvgMlBP+uhLtcY0/zjxFm8BfQMJfAFvMVX8YJxD5pTKi10uczEllnGKLWJs6R0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 26 Jul
 2022 23:55:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 23:55:52 +0000
Message-ID: <e6ff2625-3998-69f7-7fc8-f4ec3be21713@amd.com>
Date: Tue, 26 Jul 2022 19:55:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Avoid direct cast to amdgpu_ttm_tt
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220726234349.21189-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220726234349.21189-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 702e7472-91a5-4d8e-55fd-08da6f625f81
X-MS-TrafficTypeDiagnostic: DS7PR12MB5765:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZuRvnTh+BdtkfbpwOTiNHMB5LD+eoRIogqmGVY8uxRf8cw0Xp5yYd6y8mOxOKF+rF0JdVMg2kB06PVdv5IUzhoe0kXxLy1LAX8bnFAwdBTxDW1EuRB63xOSpRJvo40v7P3PdFmjCgmImiQQSiu45Yk0qJ16kV+C1kZXi2mlIYIKqw7ISW9/Xys3ORphWuRz9/A1qI4esV0F2TLW5uJsL6qNwo2gFJYFtSn4UehrQjrqc+k2i7Vew/ZCwJsnH+SJGG2bCInx9jAYqwV23C3s9d1letNLZRHYJe6jSEqvN2d+HQLMTK0s24LR71F2837tozOXFE29e0noYOmVTBi/2Nfq1sPf6GxTwhoM8ZRk+jio6IMp3bdl7+E4VPntBkh8JlRVs1Ak5DUHbbG8Px0O4oO7OGrS5aHh5Y67UtcSmSDS6I84oPsYaFXbufdmctXP71hIH4jxp0zRuTDFhaFK+bxFrYdGrJauRt3HV4Mb2NkVDdafF+WixX7LHVfQsaM04qKNJoijpkusWUQEPWuhyiNMjh7gY8l7Ke/Bd7e0g7Lwbfd6fuoxGjGcOU8I3e42p+O578NPQEWQINGycXFQl1dUTWY9U9YoCKZb/YjgA4TaWuEwX60gEBcJlp3j1A/X/BL+mSydjuqiPedLlzpsu8jwWm7AYBLj9XNMTdJXbH1pq8bWglHYSGwU1Ga4jPUqEPeLbn5TkF8CQeg7IMGUkkI1aYGg98vondGNwNpVcNOG5doEUqSprpzSt2yppJbZK8rgBwJzxu9vTOrz0UD58o9r1xNr6Wdv+WlFzhTXn/q6PHNKXLJEQkb0EUOsGepaNKSvipK3KDXTgE5o6Kj6sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(2616005)(6506007)(6512007)(66556008)(6486002)(86362001)(83380400001)(4326008)(478600001)(8936002)(41300700001)(31696002)(26005)(44832011)(316002)(66946007)(36756003)(38100700002)(2906002)(66476007)(31686004)(5660300002)(8676002)(6666004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjQrcjRSL0NsSkNNK3h1cUN0VWU1dTRHRzhhRUphZFZ3THpiR1dST2w2bkV0?=
 =?utf-8?B?Q0VCVG1rQmxsNENLcjRGK1F1dUxIeUF1Z1RuRk5vdHNhTUdWVWxSeE1SMy9G?=
 =?utf-8?B?VDA4c3U3OGZ0VWVVVkhKMlJFVFdxOTFFZkxnVWJBWHJDeEIyQzZ6UnZnbm5N?=
 =?utf-8?B?S1A1d1BkT255bHZ1U1ZDcDFyeXlzUXpkc1VPWXBkTXR4NFdITjd0ck5KWjhi?=
 =?utf-8?B?UC90R1dVRWdSU3hiYndoYUhWNkx3VHBEeW5zVER0V3hITFpVaExBSHI0NXN1?=
 =?utf-8?B?TnRqeFFUMCt6NThEVHB0NEYwc1VuQm1yV3BKWkhyU3B3dTRGRHZPRXowdzBh?=
 =?utf-8?B?dnB6RnJDOVpHa2MxSkJQZytRVlRBRXFRWXNxN0UwNE00ejhlVmkzZUZYcW8z?=
 =?utf-8?B?ZzJkQlNiZGxhOFZENHNoYmpQWitoejRFQ0xjVzJXNEJPM0hlUnJ1SXd2ODMv?=
 =?utf-8?B?eG44VnRhZUg0dnpTV1I5YkVJWGVTMjNTWjE0eE9hdXJzcjQxbnNpWEV4b1Vr?=
 =?utf-8?B?SlpOSjVIaFJoOHB2V3VRR3lDVkxGaDFnYTFKY1BFQnV4U1NQaUwxRExqQVd2?=
 =?utf-8?B?L093L2FtUkRBT05qUlMxVkRqQXRBc3k3VllnbUppcWZSZnZxNjF0VzFCQUty?=
 =?utf-8?B?bWhYZGJWaVFJUXV2bWZoNnVPdjArZlducjJuMVkzVnZLQXhMZlRsc1UzSnd1?=
 =?utf-8?B?MEFKVjVoaWZwcE1ybGlhNStEZDFhRHB2WWZtdXY2YWluNmc2MHRiRHRDWk1Y?=
 =?utf-8?B?L1l6UDhEYS84SUpoQUt1WStTUk11Q1d4MW02ditVclJPd3N2cDNXR1BnU2Fa?=
 =?utf-8?B?a01RVmw5RGh2bzdMbkVHdmxIYVhYaDFWMHdhRURBTW9QYUNTYWVCKytDQUpN?=
 =?utf-8?B?NmhQZnJwbVZmVlFxZ1hBZFErK0lRZDlaRUdDeTY4YzFIcTRGWjNiVFZnemVv?=
 =?utf-8?B?OTNDbEc5K2c4djdEL2NMblFpYTRIa1luRml4NmxUSGFmTDlyN3p2bkpVRytI?=
 =?utf-8?B?eitLK3dGK1JOakJiajVmYjZYRDRBZ0FCM05YN01sSnFVY3RXamxJb1BQVVdI?=
 =?utf-8?B?RTRNVEh1YzFZYVVIWk0zUnUzTTRBWTJXMXo0RC9RampaeU9IcWM0d3dnMnAx?=
 =?utf-8?B?NnRVQ1dPVW5IREJzRkxTZ0YxMGJNdVRXdU1KaTdkazdlMklDMW1wQjdYTTNv?=
 =?utf-8?B?cm81aWJqOEdXUkhOZWJBTEl1eFZuamI4YkFxdWU1R0tnZmg1WlNhNTRBcU5Q?=
 =?utf-8?B?Y1RDN09reWVFU3pPY2pHMkhUN0tuN1ZnUGRmbkRkSE9pdFRGbStrVmN4bjFG?=
 =?utf-8?B?dzQrZWlpWDRoN0RlWCt4ZHlQbGN0U29wT0dKYmJ2b3lESDJwOVNqd3BNZE5S?=
 =?utf-8?B?MlAwRmQxQmh5RHg1QkdTa2xHOSs2RFJmVUpraytzVWVTeWM5ZUdUMFBuK0Fw?=
 =?utf-8?B?QkxrcXpRajU4aEdyVHRzZTBrMTRlZ3FHR3B4WUwyZHVsSjdOWVBYTDlXVmUw?=
 =?utf-8?B?U21FUE1pNVlRcTg4clUxWC8xMXNXYnhlNy9XTUNXQzNZM2pRbm0rbTVicWVD?=
 =?utf-8?B?UXJISzZNTWNheHU4NXJhdzJrK0IrWFNaTzZqZ0Zra3hpRkMzRmxJNUNwS3Jq?=
 =?utf-8?B?elQ4c0xXQk95dnZvYTBFbjJ4RzVPR2ZkY1RhQnpPQThYRDZQODVUUEtXWHl1?=
 =?utf-8?B?NmtKM2l3T1Jxd0g0bE9GLy9BM3hWdXlLaWlDR1NSbUhYM2ZjUjAvWWlsTVFE?=
 =?utf-8?B?WUxTZ3lWYnlGVVZ2enVFUnl2NFBDV0ZKNlphQjVwM2xteHBvQUROdVFsZjJl?=
 =?utf-8?B?MUpqK3J0V3hRWXhtaUtxNlNkdUExQUZGRnlSMjlCaVY3VDBzTDZINXBaK3gr?=
 =?utf-8?B?UlE3ZGJEYmtpWks5bi9TS2R3NXRCa1lGSXRiOGdvSWd5MkphUkRDMlZRWm9F?=
 =?utf-8?B?aGZnRy9NaEJINGN4SndoUnhGVTJJZS9CUnNmQjQzdEVEYWluVktLK2ZBYzVD?=
 =?utf-8?B?NERzK0pZaW4zWkExQjJXWmNvdks5THZtd0IvWEhQbE0yQ3kzRGt2dTh6eTB4?=
 =?utf-8?B?OXNvWG93WUNSMnpDY3FrNTBpMG85Q3VqSTRLK2ZwcFlVbUtRcUxBdVBqMHl4?=
 =?utf-8?Q?wCpOi4vRuZQ1c/rzgg4qr0aGQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702e7472-91a5-4d8e-55fd-08da6f625f81
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 23:55:52.7229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfLlJdrHgHQFD0eyStxMH9Tmhiw0X3VyLpYGW6u7OFG/cS6TofHwVjwVBQNC+85NNtHqTywuvNtIyrK7BSktGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-07-26 um 19:43 schrieb Rajneesh Bhardwaj:
> For typesafety, use container_of() instead of implicit cast from struct
> ttm_tt to struct amdgpu_ttm_tt.
>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 44 ++++++++++++++-----------
>   1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index be0efaae79a9..cd6aa206a59e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -637,6 +637,8 @@ struct amdgpu_ttm_tt {
>   #endif
>   };
>   
> +#define ttm_to_amdgpu_ttm_tt(ttm)	container_of(ttm, struct amdgpu_ttm_tt, ttm)
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
> @@ -927,7 +929,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct ttm_operation_ctx ctx = { false, false };
> -	struct amdgpu_ttm_tt *gtt = (void *)bo->ttm;
> +	struct ttm_tt *ttm = bo->ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);

Is the extra ttm local variable really needed? It's only used once in 
this function, right here.


>   	struct ttm_placement placement;
>   	struct ttm_place placements;
>   	struct ttm_resource *tmp;
> @@ -998,7 +1001,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>   				      struct ttm_tt *ttm)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	/* if the pages have userptr pinning then clear that first */
>   	if (gtt->userptr) {
> @@ -1025,7 +1028,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>   static void amdgpu_ttm_backend_destroy(struct ttm_device *bdev,
>   				       struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt->usertask)
>   		put_task_struct(gtt->usertask);
> @@ -1079,7 +1082,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>   				  struct ttm_operation_ctx *ctx)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	pgoff_t i;
>   	int ret;
>   
> @@ -1113,7 +1116,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>   static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
>   				     struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	struct amdgpu_device *adev;
>   	pgoff_t i;
>   
> @@ -1171,18 +1174,19 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>   			      uint64_t addr, uint32_t flags)
>   {
>   	struct amdgpu_ttm_tt *gtt;
> +	struct ttm_tt *ttm = bo->ttm;
>   
> -	if (!bo->ttm) {
> +	if (!ttm) {
>   		/* TODO: We want a separate TTM object type for userptrs */
> -		bo->ttm = amdgpu_ttm_tt_create(bo, 0);

You're removing the assignment to bo->ttm here. I don't see where you're 
adding it back. Basically you're storing the new ttm in a local 
variable, and it will be forgotten when the function returns.

Regards,
   Felix


> -		if (bo->ttm == NULL)
> +		ttm = amdgpu_ttm_tt_create(bo, 0);
> +		if (ttm == NULL)
>   			return -ENOMEM;
>   	}
>   
>   	/* Set TTM_TT_FLAG_EXTERNAL before populate but after create. */
> -	bo->ttm->page_flags |= TTM_TT_FLAG_EXTERNAL;
> +	ttm->page_flags |= TTM_TT_FLAG_EXTERNAL;
>   
> -	gtt = (void *)bo->ttm;
> +	gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	gtt->userptr = addr;
>   	gtt->userflags = flags;
>   
> @@ -1199,7 +1203,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>    */
>   struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt == NULL)
>   		return NULL;
> @@ -1218,7 +1222,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
>   bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>   				  unsigned long end, unsigned long *userptr)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   	unsigned long size;
>   
>   	if (gtt == NULL || !gtt->userptr)
> @@ -1241,7 +1245,7 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>    */
>   bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt == NULL || !gtt->userptr)
>   		return false;
> @@ -1254,7 +1258,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>    */
>   bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm)
>   {
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>   
>   	if (gtt == NULL)
>   		return false;
