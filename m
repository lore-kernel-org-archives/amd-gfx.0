Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49322C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9AF613C9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9AF613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953EF6E428;
	Fri, 28 May 2021 14:48:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6696E6E428
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 14:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUFojmruIqWKxVp8CtUBG5tKpXsuKMaYqabH6tk44WB4uzu/tdlLgYk5i6ZmSMSwvbEFywI9LMwIiYbp2GE34FEoNigJ5vL2o1s5ejZDsLPNmdh76zp74BbKxrjv/XeRrK3zfA+zr6QmKr/nZT+D1d9TCIBLD3I1PbBfTuelZCff9l61ArNb+zZuk9glEDKxhoRZzjrwxx35W4vzDWGL3XtG/mpAiRKlRMrdgQzt9EiH7KzwmmrInQCXCR3JOO5Yhz72cOpple3JQ9Kcwa+fhw1cLgXrc5dplwBtzOPdtPQ5GMHOjduOCD9Qpti5yxpP9Dp35y5usFoXMlGYEBJmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI66W1SDBDaELeEZVXg+wcFRCEaRmjNouGw8P2+qBUM=;
 b=mdzlabriNJgdOi2SIuF7uC7YubJossrPE5a+cXqJ/kTc3ZKOH1IvzvsxodcnFukK7DWpAKmSiFp5NYa5ryNp+5FhR5pKKxe4LL3wTmWQk6Num0tnk40ZUhS/REjvHZC4zKVc0cWJSOOPCtdsuZTUjjeMfLi0Mmr7riEISeXeCUzAPp//xLRYb0YhQl0BpbVSLfquqmGcrAd2KPtdKOo6Uj7ZljKj9EriqOc0wSkU36G20HGrymgd3sXBvgke7Bn7oBFbu6J+KhY5vmc1nWROUD0t+k56e5TN8Io2QRQPMQbwsVCbd+uhZOzRcdrJScp/ZoBTklu4lOeZtGf7slv0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI66W1SDBDaELeEZVXg+wcFRCEaRmjNouGw8P2+qBUM=;
 b=45Qoaq0qS/j0Fdk22gT/duiIFVBGQh+GkUVoHr/JGKSM36RpwZkJPeEvL4udOFnn5w8lHa/9OU58tKaA9/JzwELfB6CZWh/e7/l/eCJAY45c3CtObWi358jRbcaBkic4Hd/amMW8TROlcebFC4Tp0LGhZTCJVsyJXA/I3JmwWtE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 14:48:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 14:48:18 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: cleanup gart tlb flush logic
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210528144401.14046-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <aa586b3d-b192-23e4-7cfb-bfadf65a2b53@amd.com>
Date: Fri, 28 May 2021 16:48:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210528144401.14046-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:a878:922a:f147:ebc]
X-ClientProxiedBy: PR3P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:a878:922a:f147:ebc]
 (2a02:908:1252:fb60:a878:922a:f147:ebc) by
 PR3P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 14:48:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fddd54fa-4189-40f6-419d-08d921e7a1bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470CD3C8EED80AE3758849D83229@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBh83c7DM6y7RdX4SweLu2nayjFpRHpgdgvUVuha/oCTlA3jg+pGmxK8Qye0HhVmgR/MxoKlYth9fq33Ne+vzYwD/95Yk8mKvxO3L9dR4pqFitgarEaBLiA1FWf8/4W56WqYxdSt5C6yy8y8Am1yis4nLVbHw6uOHnd2lC1nS8nnRJdypha6Tm9lnUDATUNOk+1UsuppqO3Hb6009p5fPPz/PbKzSyedh7JY+x9RUTchPTwDSGRaJRK3GpJPngrdzpa24VV1dRdjGMxjdQ6bXFmKgZZtdGyyrBAbvDdNTsPEXVgyKhiSu5Ua1i7jgJCYfpJRvvDDm5zxeN8KrlVlXN4SebcNZW//FjTrwtzR6/4TWhm/ijmcUAe9FDRP7aGNLUG4/HMlMA03lv9sNaTcuvcftIdhpBRCKIWFPCNDI5D6R1tdIl0e2Q1vgiI3qLJZV8M4XbJg4Sb6UzlbEb64Q+TY+PMoPCRRV6iSojtRmya5kwbCnsy9JSMur3W7u5P4Cl5KVQYpdDnl/xYSzZDBMDgmTk0yZV4EfgFHJ4EcNTI1RdhtJvjbCqzLEaolYMv0YoZEUDU7FMk7tA8VxPlQCIFolbCDmXUOIHeOH9gtmH6nrvXHxPoy7mREfeN9BMHsqHCWmywgJ1vXC6YGCu+gCk8i0aDeOnTTvH5eUflIJxzQCfe257W6OjOiwaIZJgbQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(83380400001)(2906002)(31696002)(6486002)(38100700002)(36756003)(5660300002)(66476007)(66556008)(66946007)(186003)(316002)(16526019)(6666004)(8936002)(2616005)(31686004)(86362001)(8676002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d01WUWVKbEFtek9DWDBIMkxhS1lEUmMrTXI0OXZ3b2NnU1dDekZBTGR1TU1h?=
 =?utf-8?B?UkZWbWVHOTh1YzZqOHprbGF3dXhTbEVuanZmLysvRmpqR0JFRHVkWXBiWFBl?=
 =?utf-8?B?R3Uyd0ROSGliMlA0ZWRRTDZKMG1NcUFkY1RDeE1hVDNUNnFoREZ4MlRLOEwv?=
 =?utf-8?B?YnBKTUNLZmsxYmVKT3FJc3NoblZ4ZnRTNEVkdGFqS1dYSjV2S2pyYTYzb2Mw?=
 =?utf-8?B?amNlbXc1OHZqS1RLM01XeXJLZWdOdE5tc0NmUFNxUzl1VDhjV3VMdllqRXJF?=
 =?utf-8?B?TVR0V2dPckI0SldyN3JGZG1CQ2pmOVNoWmVYRUZweVVOYnYrYnNmcW1wZ21o?=
 =?utf-8?B?RzhhaWZXS3UzdDdwOVZDT002TU53ZWkvZjlrejJuRW8xQ2ZtNURKd3gvVU5r?=
 =?utf-8?B?Q0EvTjVqWWJkZENhRWNoUmhlR2Zya1JEZ0xVNnBjdFVSMWdlMlZnaDd1TXBY?=
 =?utf-8?B?MVBheGdkNTNQL2xadkg3YnRkVU9vdThUUk9MVHkxUTBoVTlyMjl6R29jd043?=
 =?utf-8?B?YTAxS2pRaHhOZjhEK2J0YVZNalBaRlBvYWhYUVRVRnhuUW1oaEwyaDMyelM2?=
 =?utf-8?B?d0dQcHdBY256aEt2MFVqR29maForRkU5WkNncEVCL0FNQ0laaUJXdnBDczVE?=
 =?utf-8?B?UHZHOVJScGJmYmFPeUF0NWRRU1FYVzFMSEE3b21TUkhFUTVsSkJwV3NJZCtI?=
 =?utf-8?B?a0hmZzM5WStkVUpFdjhteXJyWHlpRDVIaFBUV05kVjAvR3NsSHRieVV1cUhF?=
 =?utf-8?B?bG83enZVYk1oOEFxVGJGSEw3SG1oaEh6dVpUOEdXdGZ0YnFCVlJJT1JzQkpv?=
 =?utf-8?B?Z01TZ2ZRVi96Z0hxaVpWS1NUNHBJOHA4cDRWQ0JCUitGMExhQkpjcGtpODVR?=
 =?utf-8?B?MEszOVlvam1zTlNEZGFKb0JwcnV6VXVlcVAvaWE1bFZ1SExDMVFGTVFFdTVi?=
 =?utf-8?B?cElnZXFLNTZzUVdaVGM4a1I1QVFWd3RoTUtDODEyM3MyREZjUm1PcU9aOGpF?=
 =?utf-8?B?YVBOeXR2bzVUUDhOejVDM0xXZFFLaEtPbG9TWHJXYmRPaVV1bWVpbkN3TUdQ?=
 =?utf-8?B?Ymo5VGc2UU02cWI4dHFNaTNlOEpzOVVSY25tVngwWEo5QWVZSWk4OEpieVIz?=
 =?utf-8?B?RUh6d2RUejkvQnVqZHRLaDhtbTR2RGxzSmJRa2lqZ1UwTHFYOFk5bXNDS1JT?=
 =?utf-8?B?QU5IU2tJdVVmVm9TZWxEVm9pcFppazVNMm1MdWRqMngvUUU4NnBBNm91QURn?=
 =?utf-8?B?cGlacFByalJmQUdtL3hmV3V5OTJQVGxqYUthS3o0VW5rT1lPcmRKVm1pbCtq?=
 =?utf-8?B?L3ByUENrbU8wT1lsY05SLy80UlZLdXE4VlVJR05LZGVZYnU1MEtqNWMxb1p4?=
 =?utf-8?B?bi9OZktGRTMzVFJvcHprMEF4empweEVYZEpyaXZ5alFjZmRqOGJjVys4MzVC?=
 =?utf-8?B?SUpxVDdSVDZ1NHlFcGpmMXVXRHIyZ0tBZmF4K0MrUkJZakVUQUNDQ2FzY3Zj?=
 =?utf-8?B?cHh1N1UyUFZ3S2V5S2dET2ZDUmhMS1pDTkRTbDdzWURobnZFbTZDZE5yb29h?=
 =?utf-8?B?MmRINS9zYWJDdHQ3cUdadWo3NFluakk3ZDhBMk4rMGNFcjVraUpjY04rMGtu?=
 =?utf-8?B?K3I2QXlRcEloQlNtbEd2NzFvdHROaXMySTJFMm5vMjUwZzlFWEFrc2RYbGhu?=
 =?utf-8?B?c25ycGxaY2NqZFRvV2c5MGp1WDNRdER4YmxHUDFKRzlNblc3Z3J6RkVtVFR5?=
 =?utf-8?B?T3d6dzVVTFpCelVxK2h0RXp3TlpwaVUxeWZMM1RLano4SlFaQ3BKMUNNVXMr?=
 =?utf-8?B?Qno5dDFVYi9tN3g1RE9NY21aMWpJd1F3SFFQcS83WkhLSnJQV3pRQ2NFYnpT?=
 =?utf-8?Q?Ir79hBzODQmwy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddd54fa-4189-40f6-419d-08d921e7a1bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 14:48:18.5536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T7/A3x7cipINkG0yP/dKKlrE4UM2WzUZAkQERizmtdBRj3k8ofuxqs4ZhFkXlX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Am 28.05.21 um 16:44 schrieb Nirmoy Das:
> Don't flush gpu tlb after recovering each BO instead
> do it after receovering all the BOs.
>
> v2: abstract out gart tlb flushing logic to amdgpu_gart.c
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
> Is there a better way to get adev in amdgpu_gtt_mgr_recover()?
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 20 +++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
>   4 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 5562b5c90c03..e2059f7ed639 100644
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
> + * amdgpu_gart_tlb_flush - flush gart TLB

Either change the description like "flush GART changes" and drop the 
_tlb_ part of the name orr rename the function to 
amdgpu_gart_invalidate_tlb.

Since we flush gart changes by invalidating the TLB. Otherwise we have a 
mixup in the name.

Sorry didn't though about that before, apart from that the patch looks 
good to me.

Christian.


> + *
> + * @adev: amdgpu device driver pointer
> + *
> + * Flush TLB of gart page table.
> + *
> + */
> +void amdgpu_gart_tlb_flush(struct amdgpu_device *adev)
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
> index a25fe97b0196..c853b70a24cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -66,5 +66,5 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   		     int pages, struct page **pagelist,
>   		     dma_addr_t *dma_addr, uint64_t flags);
> -
> +void amdgpu_gart_tlb_flush(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 8860545344c7..b61a54f6d95d 100644
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
>   	}
>   	spin_unlock(&mgr->lock);
>
> +	if (adev)
> +		amdgpu_gart_tlb_flush(adev);
> +
>   	return r;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c0aef327292a..5e514759d319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1014,6 +1014,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   			return r;
>   		}
>
> +		amdgpu_gart_tlb_flush(adev);
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
