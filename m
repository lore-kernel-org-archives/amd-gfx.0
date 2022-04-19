Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373E0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E6510EF28;
	Tue, 19 Apr 2022 14:38:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70F110EF28
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/tFXHpVreC/fkgEXBi3JHdACYO+uMi9x0w6CzCSgtniw6NpvMBK7w0YN1DRsFD+j6mqjQ9bVrJhNSkpTbBTZFKkcZCYN6zDFNcuaFYEFpGBFYSppkFrvP+74pJ7r7G7f8nIjFQXBHKg2tBwxNSeOROfmi98NE/L0o1M0MCnnxDSQqVfojihfVGnHqMvxTsHgeBDJPN01dRfqq56CGEEKj5hD0Kn9jw4tYPihjaSvuueHckVw/O1B3TFlqjx91R9nmqG6zn4uMrtiMxSuWlqi2CmFlAhwbuOwVy8DkKuIMGVWV9WKQPBWlDSHjaAa8bllSSN0iB9BgzeTL2q9peyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aEb8NhK9vN0ZBr25rCZnZ3+90vhA7L5llMH/8uKFLQ=;
 b=DO3bnF16EuLB6LxahIkbH8OfocKFNBqFn6+UBXlkdaVJgdEllEDqNBaAcyiFco5xzcjw3LQiIdshFozFav4Hyy8JUP027W4BnIK8ylqAsJYSIARyI6M4BizuqhNHQFZmwf/3XRUwjY5T7NxvtoMTbasuaxps20XDsMQHxdzVB/TUGCs8X2XDunpzWD6Fk/ZRUOmg4tM/51Le9MGa3VDO+dkG5LCNe25oHV9rB/Hy6OzGKS2N0O3DmTRMHOa6dhJqpys0D9PyhFvPgniYw/01DLLA5LXqV/Q+Nivj8wpbbt/bygXqF3VGpvDydNpKMB9eAoJOufimvf9ZsSPkBFdvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aEb8NhK9vN0ZBr25rCZnZ3+90vhA7L5llMH/8uKFLQ=;
 b=0bmWgqs9hSGByNnkw2eAox/SnbeeK+1B6peSUPh981kHWcKf2iwoVd5DtLaMAQ3Wp7FYJsdsSOkgeFNAGMP5Fs1KGZVALU9FteTyRkEzRHadOWTtZtPBWtRZNjBF/8VEDJxMKgxiyq9DhUM0XEVFqUg+FnXF8iH/wL4kGZP/crg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN6PR12MB1329.namprd12.prod.outlook.com (2603:10b6:404:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 14:38:06 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620%9]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 14:38:06 +0000
Message-ID: <a9ec25f0-0404-3b4b-64fd-8acf697ca3b9@amd.com>
Date: Tue, 19 Apr 2022 10:37:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] drm/amdgpu: remove pointless ttm_eu usage from DM
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ryan.Taylor@amd.com, amd-gfx@lists.freedesktop.org
References: <20220419141915.122157-1-christian.koenig@amd.com>
 <20220419141915.122157-2-christian.koenig@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220419141915.122157-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::32) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c324c219-8132-4d69-c828-08da22123727
X-MS-TrafficTypeDiagnostic: BN6PR12MB1329:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1329834DB045D17555A45A7F8CF29@BN6PR12MB1329.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aA8hxHVSW4AwWaVraNbMNtTo6mE2qbnDCgvgLeOMh7NOohSI/UXtBu8Aod2YE5WD6crKQfZnzaJvpDb3tPQRfP0pMbJt/PwpLYs7QzZHyIy2ydd3ZvRjv6HKSqVuMF5vzWxzNVU6a20bzM5sUfWK1WtO+beIJ+HfWXCS5NLpM4IBlDj9wEJAsB1RDGbYIRObW+SjiVc2SdO8C12yNM66JDUokTJAcWZIenh9rr2kReLeYhmxVhVChcQUkv7lHVfqTcOSsn5s2zHVRPI94c2PRn9PWbpenPZEiDM4qD1ZNHQxIhPzUqF4dtvGiCO5zOaDxK/0HBDC2Tsh06B5rnTWdqLVdwV1gfPOeAxVz7ogd5HhNZb+qy6ix/zAWPPdy174opBZDNIJ1jVfIBqu5ji96kE5YGQLmk0nWadEKylt0JlaMwRHYKbc9s14WYvRXkolAxHkeC2red1CM3OFK1+wGdyyA87UD1mpoAJfw+uGn4Rhhpw5mFJS0uQ08PHJsb1OHnF82csznEhBd4jgPmQSW+uKRKoxyWZ3L1Epf67sYjlEMk3iYnZgeBPF63cQO5bLH7NI4hLj7cnPaL6b1lCmuPC7OucJuo1XOBHfSrbBpnAkbddj2frKITuScTILg6BGo8aKXiiQE4MEMa9AQcPivVk9mKASJtf3Jtsq8A5oNi8Dj/eG/uY6PcBtKiFFiObEExuZcSLPMSAAWs0A+jQIrKz0ySevOu2Z1qRvRukyoRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(66574015)(6666004)(31686004)(66476007)(83380400001)(8676002)(2616005)(36756003)(4326008)(66946007)(66556008)(316002)(6506007)(5660300002)(6486002)(508600001)(6512007)(8936002)(38100700002)(53546011)(86362001)(44832011)(31696002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3JFMktmT09DTk1YQTNhUEQzWEE5dmlybjhWbXFCdTNYY1U3a2tNeFE4Nk5X?=
 =?utf-8?B?UVViY1NZZVcwT0F0QXNnT2JOYUFOOWdHUGZWd0o4YmVSOFhGeGNlY25wc2V4?=
 =?utf-8?B?MkhSOVhSYko1dEcySEw2YU9zSFlYc0srRHViWnBHaTZtY2cwTXlUbCtoK3p4?=
 =?utf-8?B?Z1hjNjRqWE5LNytSOHU0QVdFam13bTFrOWpvYWcvNG5xSmRUS0o1RTRVTTIr?=
 =?utf-8?B?OXdUUEo2Wi9KZ3AxSm9kbkpFK2N1WUJRc2REWFNEL0lRT2ZkL3lkM2tScDJt?=
 =?utf-8?B?amZ3MFpUWU5sQ0gwZG8xdktTeU8vV3QxcGNWUVMxay9nT01pbHZGTVZBZkQ4?=
 =?utf-8?B?TjFac25ScFRySmh0T2E4RXZDcE5wZ2dFS0RYNEIrTUg4SXpZMmsvNkdEOThn?=
 =?utf-8?B?MFd3QlVTaUYzaERnNzlnbFVkVGVVUUhnSFNHb1RyZ2JvUHdPYkZXZUcxNWFi?=
 =?utf-8?B?M3ZXK1FJZEZzZnRLc0NBbGJhdGVBYUVHRzMvd0RaOXJRQUYxZDRKKy9nY1di?=
 =?utf-8?B?MHpmQVM5UDFCNFhRWE9Pblc2WjRTdVBzYlp1dUtxL013UWYzNXdZbWxuUmZP?=
 =?utf-8?B?b1RwdlhDbS8zS3ZuSW1jLzg0aDFkeC9JTSs4d1dBRExmLzhvUGJDQ3QrNFQw?=
 =?utf-8?B?YnBiR0Y2eXBWTE51YnZKRDJ1UTh3ZThEOXB0dXZRVkpWQTdvZGN4OE9keUxx?=
 =?utf-8?B?OGRTcGpqY2tSSml2V3JCYWxITSttYVYrWitOZng1c3VoOUJZY2xRYnRWd0xD?=
 =?utf-8?B?R2t2VXBFTFJpb3FvS1JYaUhhMlRBN1ZUd2ZCSFYrSXdqZXZSeEhVc1RDOHJI?=
 =?utf-8?B?b0hLZHJpMWtRajNhdkpsdXJwRkNMNXhUQk82bTB3UWd6bG9PRm8rM21qK1Z1?=
 =?utf-8?B?Rm1pdkp4Q2grVG4zZEpHWlQ2Si9xcm5WQmtZUW91Wm1jMXZEb3VNTDdvb1h0?=
 =?utf-8?B?YVNQd2tsWjRoWVk2dmttWHVFNWhVdFRnc2NyWjByS3pBVzJHYVJLajBRaGx0?=
 =?utf-8?B?THVlME51S0JyY0JMcTBaS1F3b3Zzc2dxc1FFWkQxZTB1Ty9maHZ1Yk1oeWd5?=
 =?utf-8?B?WFUyQ3N5R1BQdUlRL0NGR0lmN0w1RTN5aFRkdWp6b0VXSW1YeHBTalRIemFZ?=
 =?utf-8?B?NWRjWkUrUzZDRk9RTWVNWlBtc3ZTdklpTm5XbGg1ZTZMaVFaNno4V2podGlJ?=
 =?utf-8?B?cVJMdVVuWCtjUTJHeklET3RFd2c4R1htZFZtNTJnd2hTSjk3VFlrcFNKNklU?=
 =?utf-8?B?ZUFHVVdVNHRUT0VSVVZ4RUd3Uy9kMVBzNUFPZGFjTkxYL05QTDdoVHI1a1dx?=
 =?utf-8?B?aTQzOWozZUUvOVkyYUUwYTBVWHBtK244azh1bzBhaUsrcTJ0YlAzZmZKY1U4?=
 =?utf-8?B?SEloZ1dCb0hGQlhYQlBmeXF2QTVuT2xGL3IrK2crUXVNN2JuOGlocGxLZERN?=
 =?utf-8?B?UHRuSG9UbTNRMkd1Q1hMM3l0ZWFlZkFLaGwvM2NIL1hFcnI4aEdSeTNNWEp1?=
 =?utf-8?B?UGlseCtsVWVBS1NraFZrS05DUFZRSkRQaVd5TDdnUXBiWjNiVHdtbmR4TjFx?=
 =?utf-8?B?RUFDakNxdWRRb3RXSkZMbUVNWWtjaHdPYXQ2elNkWGUzdUxFY0ZMREJIK29y?=
 =?utf-8?B?ZlUvejRiUnIxWS9oS1pwREJpWk1lV3lxb2EwdUhKNG9LZkxnRGc4aTl4SThq?=
 =?utf-8?B?MVpWMkp4M2d0TGFJVWFQZC90ZWl6ejZSOG9oMy92WU1JRk93bkU1ek1NQkN5?=
 =?utf-8?B?WnVPMCtlQ0U2K2UxYjFWbTdTVUNTVWRzWEhsK3JPS3dnNnpTb3ZjMGQ0NGwv?=
 =?utf-8?B?L25EbS9zb3ZmL3pDbmU1dlpVUnY2N1daSmZMaDRJb3Y2RERYd1F2TEEzNFVB?=
 =?utf-8?B?L0NnaVN0L2x5Zko3a0lUUHdRZ0Fyak1UVHZhandybWVyS2tiYnY5VW00Kzlq?=
 =?utf-8?B?WGpUYlpaVzZpbXpLcG9ISEYrMUJ6Tk1aa2tEUUVrbjI0S3JEeUttWUVYZG45?=
 =?utf-8?B?UHN4MXJmT1JhMEQ1VktXTlpkRUQxZDMwVlc2cnMvSkZPSDlhQmFCY1dLZXpn?=
 =?utf-8?B?SXBkV0NBdkpsRzFXZVRaOEtyWUJHcTRyOE43Yk1uczNkdmpCWVBVcDBTcmpm?=
 =?utf-8?B?dklKYWQzRDZOaTJiN09iNElmVWRRalIzVmJvNDFmQ1hqUFc1WEdSQmZ2V0lu?=
 =?utf-8?B?MXJPcFk3VW5YT1J4c0p6UzlFaGovMjBaVitkNGljbE5Iamlvb1Ayb3drdjJR?=
 =?utf-8?B?WVBjeVlSNmpPeVZibDBzMXhSNjA3bUtMUjN0RWxwUDA5REkvYmxaR1JjRjdL?=
 =?utf-8?B?YXkwMU0wbmpZYTJxMlh2REEwQkZaVnZyS2JtTkNjNTl2RmNxeUZjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c324c219-8132-4d69-c828-08da22123727
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 14:38:05.9112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaJT+i4VE6/FaVTaInfhH8ZCTpENvrGZYhhppVQKuf0CzJqsU6fJzefHR7MwsdcXFLtlJj0oDNH3TB52W4YLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1329
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



On 2022-04-19 10:19, Christian König wrote:
> We just need to reserve the BO here, no need for using ttm_eu.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++---------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73423b805b54..91e9922b95b3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7583,9 +7583,6 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	struct amdgpu_device *adev;
>   	struct amdgpu_bo *rbo;
>   	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
> -	struct list_head list;
> -	struct ttm_validate_buffer tv;
> -	struct ww_acquire_ctx ticket;
>   	uint32_t domain;
>   	int r;
>   
> @@ -7598,18 +7595,19 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	obj = new_state->fb->obj[0];
>   	rbo = gem_to_amdgpu_bo(obj);
>   	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
> -	INIT_LIST_HEAD(&list);
>   
> -	tv.bo = &rbo->tbo;
> -	tv.num_shared = 1;
> -	list_add(&tv.head, &list);
> -
> -	r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
> +	r = amdgpu_bo_reserve(rbo, true);
>   	if (r) {
>   		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
>   		return r;
>   	}
>   
> +	r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
> +	if (r) {
> +		dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
> +		goto error_unlock;
> +	}
> +
>   	if (plane->type != DRM_PLANE_TYPE_CURSOR)
>   		domain = amdgpu_display_supported_domains(adev, rbo->flags);
>   	else
> @@ -7619,19 +7617,16 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
>   			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
> -		ttm_eu_backoff_reservation(&ticket, &list);
> -		return r;
> +		goto error_unlock;
>   	}
>   
>   	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
>   	if (unlikely(r != 0)) {
> -		amdgpu_bo_unpin(rbo);
> -		ttm_eu_backoff_reservation(&ticket, &list);
>   		DRM_ERROR("%p bind failed\n", rbo);
> -		return r;
> +		goto error_unpin;
>   	}
>   
> -	ttm_eu_backoff_reservation(&ticket, &list);
> +	amdgpu_bo_unreserve(rbo);
>   
>   	afb->address = amdgpu_bo_gpu_offset(rbo);
>   
> @@ -7663,6 +7658,13 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	}
>   
>   	return 0;
> +
> +error_unpin:
> +	amdgpu_bo_unpin(rbo);
> +
> +error_unlock:
> +	amdgpu_bo_unreserve(rbo);
> +	return r;
>   }
>   
>   static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
