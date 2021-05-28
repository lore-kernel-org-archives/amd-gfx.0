Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2CC2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653F4613D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653F4613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E677E6F5DD;
	Fri, 28 May 2021 15:59:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C127A6F5DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 15:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLC/VqygvFAYe0n2If/Fp+jzvSIQH8B+bZjVlAF1qrnCJshvfvrWZQOMAn0mKmsv8W+0zkrT6Ss92sj2Mr+KaFDBilOR6hdT3g1rmrNy//YBi2hri+LYiJWmQvFvKHc2Y6UN3U6FaRYsyQx44P36Ov+f33W/gtjaTTAhjZPzKaZ4XQwy8PBgqKokOCJrb3H3WbCwTcc19qfkUPtJWwUtMYS1is5yuqpvxg3SYWINkH3/Q6N3M7RBX0QhVL20/YFK+EGIYGYLWqHK/WJfb1cn6UZ7r4micYkblv66R76Grbzq3+u47whcmMWlomW9/SluejbcABp9vy1bXTW8qmQEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avy7OM/o3MCLURY2HJgxqcIB0o7iP+QkehAp/D1lSFk=;
 b=OJ2ZP1eWVR/kgTJPGhCHe0obrST15OLB5d31YONgfwbRC3zNy+7Nds9/9iQbW6cKWu1ouTHD5o201lZa6Js9OpCpIFB8xEH7vPWNFWclyUx4zu8kCyaW0ejX3gaBpy2z/Q65SDR5qixvlszs3CM3YYCWX5/VEQ0OI8ycgx/cakR76Un+9dQuUpE5hrQr7yzYPLco2hm6DnX3GCIgiTfuQqy0xJ6pCGq0YhMVRInY4notq6uS4FckeSIzD8KSvL2eNyDRNPUPuFJVM6BTjDxdhyeWG3saVuvyv6rIt1w5hWaSTBkHA64yVeyuSIuv1v7g7hORY+uLLxuyKFGhwckLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avy7OM/o3MCLURY2HJgxqcIB0o7iP+QkehAp/D1lSFk=;
 b=mRe//NYE1cnr/Ndjrc8cscFfyN7la2s5ZO7KCqulVTOnqfhZNwXAsxK43khCh4cSVRIYGQWnSjTzvB7ddalznfxdLqdN3oI5YPLDtA65VcNQFM56QGm79xe+wLSUFZyMJERO5gjJVtnp3iKcEqN5b6Su/VmhHviFX/EpkKSi/nY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4847.namprd12.prod.outlook.com (2603:10b6:208:1ba::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 15:59:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 15:59:28 +0000
Subject: Re: [PATCH v3 1/1] drm/amdgpu: flush gart changes after all BO
 recovery
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210528155428.75487-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7397fd5e-df68-fcad-0fed-34e9026ee776@amd.com>
Date: Fri, 28 May 2021 17:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210528155428.75487-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:a878:922a:f147:ebc]
X-ClientProxiedBy: AM3PR05CA0125.eurprd05.prod.outlook.com
 (2603:10a6:207:2::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:a878:922a:f147:ebc]
 (2a02:908:1252:fb60:a878:922a:f147:ebc) by
 AM3PR05CA0125.eurprd05.prod.outlook.com (2603:10a6:207:2::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 15:59:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adeb0c77-adeb-413a-8899-08d921f19278
X-MS-TrafficTypeDiagnostic: MN2PR12MB4847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4847D9EA32CE6E5DE64CCF0D83229@MN2PR12MB4847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U2ILo7mPoITY7TYGq8vDvl8U9LYSAJKo6BSt6SjoZ92GkEdIEAs6wStM53sN1LDvvGNZLggV0RS5cNH1WT8A0EkXFDFfH0wK/Fge1sDdTu8uucvpttK54AfEQ3QnzDIWUF5h1856RhPvIsT2c5SgAqzxruCNnpHIeaWRGodfuU4kFvydHytSv4mxIj6eRjh7uhUO49OSWB3QjM421QdtWi9W1can/KdNrry1G04LAaCwB2OoY5QrjadPSxpEDbZqm/YCe5xDDGQn7TXJGZ2picunkk48oEOI29g/ds07ZoruI1nnBxOyhfvPIrMtUYIs1+A/gvvFXa1ZOeQvgYjCyDKHd5JrbSV4C5BURKRaVGo4fNrziog432YU0wK1lfmoHziTTe9EHei71viN/A9v5c3kGolDT6PRBz3CwPEiYkCQz+qhTYvt5vqm2q1MhM1c6LrQ5Hq3AIcTK6ygvlOYeRk88UbtGTMSIIo8ce0wZZAcsMpDeM4US98TyGiVPvPR2ZaczaHHoFMCwhfFyTGtFYu408iZPp21rVxUrzwfFONbnVplkgrzvg4n5LxB3430Ypg+wrHb4Ngq+JwkErOOgHzhbk1/cA6OSC02WBSuhFoyYvvXteYDs8LPVCyAoztdGIY/Ao8VAvTrmRwQi8qjqI1SWzW6o4L2sgmYOgIojvxll0m9bhC2HS0fSciXc4U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(36756003)(5660300002)(86362001)(38100700002)(478600001)(6486002)(316002)(2906002)(31686004)(186003)(16526019)(8936002)(8676002)(2616005)(31696002)(6666004)(83380400001)(66946007)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ckdLRDc0WGhhL0pBdUxYbURvYjBTQVlzYnMxd2RaZ0Y1SHVOM1RYWlI5ekpM?=
 =?utf-8?B?cWJZZng4ZGYyNFFrZVFnQzBIcEdwL1pkZHA3T1o0dXZXQ2I1aVA3VUowL0d1?=
 =?utf-8?B?RTZ1R1o0QUJuZHM5aUQxTVVvVEZ2QW9yOTFvQ2o0N0VJWURDNFNRRHZzaHFi?=
 =?utf-8?B?eFEra3ZFK0FyVjgwWk53Y3hDM21oYjhZaG4wTWduT3R4Y09OQnhzaktOZVpZ?=
 =?utf-8?B?Yjc4OHduNTZQK0k3NkR4cVptTWI2UzgzM1FpbWRHQ245YTR1TXFIZTlSaEYw?=
 =?utf-8?B?Nk1sS0N4SjB5NnVzaUNUYkJwcTV5eit3c3c0dCtEL21NSUswUnFDVHdldEtQ?=
 =?utf-8?B?NmtaYlF6ZVdhYnBNeHJXNDdvRlNoMmRnK0xiUW91ZUZNWEhQQzJyM3M0ZEx0?=
 =?utf-8?B?L2FtT1lkUEpxL0I0SVptZ2NHeDAyY09KaEViSVlHTGlZWFpYWkppMnNXbkFX?=
 =?utf-8?B?MGdhYjBSK09ldnQ5T2MyVUZRT3NDRGJRdUlBZlppNDhsR0gyYnRxaDJYYjNw?=
 =?utf-8?B?L2pRS3g1UURLSFQ5QXozbDBjbmR3dXZ3QXhEVjNyZWdhZExMVlhHYWFFUU5Z?=
 =?utf-8?B?SHlDWWNjNUlhTFJXZFJUc2NucExCSlVWUUR2WVczQTgzYmZvUU43cmVuUloy?=
 =?utf-8?B?T3B5MjZGWGJlZTI4eEJiTTRNRURoSzEwL1R0RXVrMVZQa25lMnEzYVdqekZn?=
 =?utf-8?B?WEJaYXZOWlZ2bi9KTTJ5MWpOWFdnOXdWelpxRFFhQXoxTjFXSUxjNDMycmxW?=
 =?utf-8?B?bGRucUNicEliOGtjNmNjRTdQcFpkVlRtalRCTUV1UmxsV3EwTmgrbElyby9J?=
 =?utf-8?B?WVBlMGkxQk9jLytUN3piT3N5UGNYU2x4RUpZQ2hWK0xNQjFVV0dyTEZEU2xH?=
 =?utf-8?B?Z04wY2FyS3NmVmhEaENHaGxrVVB1R0xLWXJKK3RrT1FTT2YwR1h5SkdzOTlU?=
 =?utf-8?B?UStxam93ckJBNVY4QjU2eXFXZ1lhZHFUZ0VwdVFzUzdpeUp4QXdCVDIzMFRi?=
 =?utf-8?B?c1dQWUw0UitXWmNVK3M4TEtES0UzTXl6UmtUODFFRm85d01aYlBuVEgybGZz?=
 =?utf-8?B?SG1IWmI1enNGVmxoQ1lYR3U4TnMvWFlhcW1paG05U1hNbmZxV3AzaUkrY2JF?=
 =?utf-8?B?eXRQMmtOVGMyT0JJZndtNUZ0Ukc3N0ZRYndSUHFaUFVKbGloTFVQNTdvSmFP?=
 =?utf-8?B?YTgzMkxtczIrdVV1MkF5Z2VpV1ZuTEI1QjBjMGtQTkttMTd2N0Q3WkI1RHNE?=
 =?utf-8?B?TjFIOGVOR0xWaGlJMmRKcXZqa2NPZmtUNVNJakc1aXlOSXdHMXg3UTROVzZu?=
 =?utf-8?B?VWV1Mmd3VWtHSXBYK0tUTDliWTFhVXp6aDMzWm0yTFFkZzZSeXVZWFZIY1Fw?=
 =?utf-8?B?U2d4dzFpNWViNzNTZkJKOXNJbzd3Zmc3V25iTWFpQlJtQXJHTFZtL2FFSExo?=
 =?utf-8?B?emxqd0xrbzlRMHdFVVl3Wk1rVVdCbXpGSWhhdSt5YkJxRmxON0hiL0w4OFU1?=
 =?utf-8?B?NEcxdll0RUt2SnBHU05wS0NZbFZDU1FEQnlOL3BtVmVVNjhydHkxbUNIRCs1?=
 =?utf-8?B?MytEcm0zUXgwV1BTRDdMUmp4NFNjMTd4djBKZFFyUDdHd3VuRmlKd3FNSE5l?=
 =?utf-8?B?S3VrMEF3ZDF5akcwellsbGswdzhwMmx6Q1lkUEY0Z0I1QVZMUUdac0p6bkh5?=
 =?utf-8?B?RDhaUmNNblhYTkczZU1Zc1lGSys4WUZPcG90Zlk0NDFtdkFMemVoWjNJajQ4?=
 =?utf-8?B?U3dEL1RmbHBKaWsvNTg4MjNPZC84cEY3MkQ2U1E0ci9SSDRyb0xuZ2hFcW5Q?=
 =?utf-8?B?b0l0dGdyZHQ3REpDd3o2cHQyRXZLR1hYQkhIbEZBYTdBV1ZGMTY5OUNKT0E5?=
 =?utf-8?Q?MeyuAMe/RgS+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adeb0c77-adeb-413a-8899-08d921f19278
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 15:59:27.9022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBu0arTjff2nWMl1278uSHlYSzLV5gVcPLIFhN/nlsNjCWl2szK64ePS07JAnNPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4847
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 28.05.21 um 17:54 schrieb Nirmoy Das:
> Don't flush gart changes after recovering each BO instead
> do it after recovering all the BOs. Flishing gart also needed
> for amdgpu_ttm_alloc_gart().
>
> v3: rename amdgpu_gart_tlb_flush() -> amdgpu_gart_invalidate_tlb()
> v2: abstract out gart tlb flushing logic to amdgpu_gart.c
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 20 +++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
>   4 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 5562b5c90c03..992b59c29dd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -322,16 +322,26 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   	if (!adev->gart.ptr)
>   		return 0;
>
> -	r = amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
> -		    adev->gart.ptr);
> -	if (r)
> -		return r;
> +	return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
> +			       adev->gart.ptr);
> +}
> +
> +/**
> + * amdgpu_gart_invalidate_tlb - invalidate gart TLB
> + *
> + * @adev: amdgpu device driver pointer
> + *
> + * Invalidate gart TLB which can be use as a way to flush gart changes
> + *
> + */
> +void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
> +{
> +	int i;
>
>   	mb();
>   	amdgpu_asic_flush_hdp(adev, NULL);
>   	for (i = 0; i < adev->num_vmhubs; i++)
>   		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> -	return 0;
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index a25fe97b0196..e104022197ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -66,5 +66,5 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   		     int pages, struct page **pagelist,
>   		     dma_addr_t *dma_addr, uint64_t flags);
> -
> +void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 8860545344c7..b01bc2346082 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -205,6 +205,7 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>    */
>   int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>   {
> +	struct amdgpu_device *adev = NULL;
>   	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
> @@ -216,9 +217,14 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>   		r = amdgpu_ttm_recover_gart(node->tbo);
>   		if (r)
>   			break;
> +		if (!adev)
> +			adev = amdgpu_ttm_adev(node->tbo->bdev);

container_of(mgr, typeof(*adev), mman.gtt_mgr) is probably a bit cleaner 
than this.

Christian.

>   	}
>   	spin_unlock(&mgr->lock);
>
> +	if (adev)
> +		amdgpu_gart_invalidate_tlb(adev);
> +
>   	return r;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c0aef327292a..786650a4a493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1014,6 +1014,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   			return r;
>   		}
>
> +		amdgpu_gart_invalidate_tlb(adev);
>   		ttm_resource_free(bo, &bo->mem);
>   		bo->mem = tmp;
>   	}
> --
> 2.31.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
