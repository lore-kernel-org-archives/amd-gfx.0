Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ABFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 19:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B40710E415;
	Tue,  1 Nov 2022 19:38:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7FF10E415
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 19:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3RvCnvtRQjbQ5oihy/JgMOOfmiQx3Uzpt8sbinO37gS7IDkVx62joQge/ao6Xc2FOJwfwTOwz/CTcZ6DbaJ/vUfTNa5Dtj/6S/oG79Djdikr+B0Po9kimGmi9yXlSZB3md3Ju/x1pgOQ0BmtNrba2la0WDVXAqCuTEgl/ESUnQ8nvi5x3r2IcIVKnzla1AveikwGiaBXrrQeeN2X+bCwj0rzLtWafs5A6ZyIeinZovY+/GbjFmrc4zqrKxidNvh69vO0SkzEr+RSxndM+dy4zy/Vwqp7VrN56GjcnwBPn1v3r29jzmaJjOYTVlfWMlpUB9M5mRZbicnBNDaqs8RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvaPDwnxK3zLN+wlAMarxPT9CjlQFQBH6Mmdu/9qPiE=;
 b=fihsLeFr0IbXUor8qTT023ciw5dFWDRhnHyQtHViiAcUGdKox4d2Z8Tl1c2kjqWgE5PQnWq5iwGV+G6zS3g3H/5CKvaIQLCy4G31TNk3StkK7Hn20/ZeajZY5Wy6D6gEezjBOgiJK/3eJ4Vad3MP9aZ3JmBeZ/2fsprH7uMmos9X6o1OTyeKxPx2w9Khz4J+h38+uHC0T9/At29bTDIO8tk2a6H8yUT+ck7IWIg2Qif/+AhUKscVh3ku90+xSPrCalwMFGP76c8YxrxivN6gspGa/jlLYeWYk17yiTi+xKnurqWjAxWiLZoZ/8U3qwSAwAnT1Zy5YGYA9QvwtX/tFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvaPDwnxK3zLN+wlAMarxPT9CjlQFQBH6Mmdu/9qPiE=;
 b=urbEnJEsBHeB4XvzmWDVzuLTpih0DlQH91o26rnIznIMQjucesNKO5SFwsjEcl2rTgsLkQM1aMefhGW0pAnHtr82wyleChDUPstuaEQNzqjtoXSjlXYwIec2IwvqFyzwq2OrYtpQunDIpBGaE6G9vadjETFxgiPZQ0Fvns5L4zE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 19:38:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 19:38:50 +0000
Message-ID: <99d64803-565a-e85a-c4a2-5b6ce0f197ed@amd.com>
Date: Tue, 1 Nov 2022 15:38:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] drm/amdkfd: Fix the warning of
 array-index-out-of-bounds
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20221101085211.305946-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221101085211.305946-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: daa1f1ae-bba7-4662-1713-08dabc40b348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkF7fmL1At+gYckVKlVfygerLj4RGt2/6mzlP0MileD6AKzVyrxNZuJdmpLGEm6ZhGjDC1jHfjgNTG0pN/LjIMeF4N0ydNWscQg3WICoOsIMVRJtVTBKUf6+OBv1rAooLAXRLNxwegmybA/G67Tm4JNoxXBMD1Qi6VWPvbV0cnj9d2IBci70e84M2k8uITiSB9DTQ5gjq+3Etbul82BKkhMVFmmdZkkS+Kwu9zNTSZjt3zm7Cv3UfJ2Q4Sck2goQza2fA5cv25M07VipLA1voGkemOJrmvSSDw7B9KaUMese3ZHx54oBoaZlJffqmUcRzO6NlSK3V1/J7F+st4AOcUTjV6uyVuQOr3N/C2Nn0vACAZXtyK3ljrhrr/Tb45mKnDFFvvJ8yzk0o+I9tWBAhaaBPOk98LNIRT5tm5ZhWO0cuzX/tQ9YI0cWKImdwHTIJdkAAVlFaLfTla86nDP1smEw2QUMSBqZWAkTWcv7iOCc8tHQOIeib8m1bomDGJBErv6/2FsfbBjGu0VPXPlHUQOKJZaA6skc9P4qxeKodn0bHvTyq8+jddz6d0jPbVVuxQK6W8fKZ1pLI9um9LRygdf2lBeHUocNsCbARvhLWDFYzHfAI0W1wKabkEocRnaCh/xtl536CvBEx/A/K99wFyLn7hL5tAFnJypxh+Ysbd7zvV/HKsR1gKnnkCKSJE+UOyKavNKUy1ydkBj9DyXxFJg1y6jC1DUuFO2OkWyYHWupR+9fVStyqUqGurM5dnHS3+hjTK7L73gIbfqc3h3v/Bd2zeXOPIQzt94AIy6nCg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(83380400001)(86362001)(38100700002)(31696002)(2616005)(5660300002)(44832011)(2906002)(41300700001)(66556008)(66946007)(4326008)(66476007)(8936002)(53546011)(6512007)(6506007)(316002)(186003)(6636002)(478600001)(36916002)(6486002)(26005)(8676002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dlZzhrOGEySTJPcGxFY3RWNWluaFlEL2pweU9VVnAyZEk3TTZzSHhNbmZL?=
 =?utf-8?B?WTR5aHBpWlE4OWJnOTlVZ2RBbTM1d3VnRnZFZ0JnOXkyNDM1Y3ZvNHJiRENx?=
 =?utf-8?B?ekliTzlCQW0rRDk4OWdSKy9lMjcrbXlJaEI4Z3ZDdllZdFgrQkhVREZlT3Fv?=
 =?utf-8?B?UzkwVzRJb3pnRXdXYWtBNVpCN3ZmWXVUdWptQU52SGF1cE9EUlBWYzBNWHBL?=
 =?utf-8?B?K0cwcUh6YTNuWmVzTFkzc29KUm82L2c2NVNUUm5teEpiS3IzeGZqRzBEMm1o?=
 =?utf-8?B?T2RRTjZLd0xGWVFUMW53bGIwYzlPVGNjUmpVSjJpSElsVDN6a0JtRmdoLzl1?=
 =?utf-8?B?Z2NLQTZLUHhIcGwzZXh1azZkMkl0WmhlZUdDeUhkM1JaZ2xJbllYR2U5SFdh?=
 =?utf-8?B?RWtYSEF5YmVIZWZIcHNpV21LZjNUTlZaZzdKYUkzVWJzU0pYZ0RZWlZnSXo1?=
 =?utf-8?B?RXB1L1lobm9aR0x3MnovSTQzbmM5Wld3bUtmUE05QTRXTXhneFhPS3J0aHZX?=
 =?utf-8?B?c1FsNGd2Yk1UaW9yNUNsak93Mitmd01zYUVJWXRVU1RSTE05OGdScU1FclJI?=
 =?utf-8?B?TFkyaGxGekZVa1dwaFpiYnNmWWNMVG1ObjhYSGlFQy9vMXZIaW1iR0ZKT1hN?=
 =?utf-8?B?UWxxMHh2am1XTzY0bU4vOGwyT2FHTFdSK2JVa245aFl6eHdoeTBzYVhVamI1?=
 =?utf-8?B?alUyejg3T2NpWjd3U0F6T25EYlJpc1VudEdEMnUzM3hjSlpvL29UbUZielJr?=
 =?utf-8?B?d1RCM0UzZFZyK3d6NFhPSFhjOTNIVnhJT0xrcmxid1V0eWMxSWExdGo2bGV2?=
 =?utf-8?B?N0Qrb1NVZDBpSHpCajRTRXJaSFBaNmdibUpXSVpobGpuakZDQnJlbFlOZXNp?=
 =?utf-8?B?dXd6dW94OEFxTTlyUmxnVjdaK3NiN2h3YTBlcGl5V3crdyt2NFA0WmZiUHVP?=
 =?utf-8?B?UzBZVDRDS2g2MFpYalIxUW9iK0x6RENBQzZ3d2hURU9ZbkJ3dmZIUEF1d2Jp?=
 =?utf-8?B?WDBjcXR5QXdTSUtLS3FyQkVVQjY2blQ4YUdrTG0ybStGWG5VUXBEdHpkdTZJ?=
 =?utf-8?B?eU5zUkVmdi8rb2NtODN2azB4RXE1K1VEendtMkNFOUE0bi90TlMyejA0bnQv?=
 =?utf-8?B?UmJjM29SSGRTeWdqcUw5NU11bitFTFdPcjhZNG5hYW44YllBZURlSVFBbFNk?=
 =?utf-8?B?dVdnc1dZMTJIblNvcVJBQUZhbk9USG02WlNCeHR6RnJkcEZzWTBIK2ZIdTla?=
 =?utf-8?B?aHpwSVFYTnVVWVBlNUJ2YzkzUGlNWEx5VGJaaFBIVXNXb2RHMkl0bjNJOVcx?=
 =?utf-8?B?ZHVjUlFIbTZ4clNNNDN1N1pLdkJ0Z3Bhc0ZpT2hjMElxZGZwVWNVNGRVWE9K?=
 =?utf-8?B?dWtkdWxpZ3ZFd1FjVnJsWG5Fc05NK3UwM29YRmJWYWRRNnd5em9NS1VGWElC?=
 =?utf-8?B?UkVPelVQS2kzbjRJQkZDZVZuL2JWc3RicEo1QUNNRDQ1RTdEY0dDc0gxTDFw?=
 =?utf-8?B?cmxnendjclVNSEwzRSt6L1pONHNGOUVKMkdKQ044NS96cEFpdWh2TkduUkpX?=
 =?utf-8?B?d3dXbDhnZ2NzZnRGNEU5OXBJS2NvRHdrNGdzZmZDdXVKaWFTeHVubzJ5RGd4?=
 =?utf-8?B?T08xSC9qZ29xVjU0aEFzc1dJdFZjZnpqYzRNdXZWYmhHWnZmZWtxOFR1SWlM?=
 =?utf-8?B?bUQzbWxDUzg4czlqWGpXY3dEVjZ3ZnFmamVFNmxsb3cvMnArOTJTZXFNSWJ5?=
 =?utf-8?B?Ykc2SmRxTjNoK3lVN3ZvcmdITzF4RVFIemJFR3lselVJV1RoQWZLMVh2dUFr?=
 =?utf-8?B?Q3dobHc2OVEwaVpFVWcraGR0YUxzajhQOFVpZjlpNCtiZ1BabmkxOTREc0R6?=
 =?utf-8?B?Sk14R3p5ejVFdWFVRER2czhPQTNqcEdxNkNYU1p0SGFMTTlaZThCUnpkb1di?=
 =?utf-8?B?UEFOWDJwNXBMaG9RWjF2clBqRk1zSWpyRTBMZUZHYnhlalZhSzNTKzR2TXJx?=
 =?utf-8?B?UXowWE5IWTdncUl4b2REajRiTFNyeXYvWXJ1UTZvc2hKeS9MdmVTMHlvUmYv?=
 =?utf-8?B?V1VuVThtbWxBYjRWNlBmRHhYWlBIbkxoWTFoUkpEYzMza3V2SnJrWGlkdXJ6?=
 =?utf-8?Q?M8M/kyO/yGj5++PshWEt0eBYr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa1f1ae-bba7-4662-1713-08dabc40b348
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:38:49.9527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8bTBspc9jXSV/g8rLgbxBwPS6mPAfVUmuzdPfz1neB5PTViL4BEdaEJCvLUffQOl6HW1WH2JJpsMiY9dn6ieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-11-01 04:52, Ma Jun wrote:
> For some GPUs with more CUs, the original sibling_map[32]
>
> in struct crat_subtype_cache is not enough
>
> to save the cache information when create the VCRAT table,
>
> so skip filling the struct crat_subtype_cache info instead
>
> fill struct kfd_cache_properties directly to fix this problem.
>
> v4:
> - Fix the bug when get cache info
> v3:
> - Drop processor id calc function
> v2:
> - Remove unnecessary sys interface "cache_ext"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

One more small comment inline. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 312 +++-------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  12 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 245 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   5 +-
>   4 files changed, 282 insertions(+), 292 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 3c7f0d49da59..f4a9d0e49072 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
[snip]
>   
> -/* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
> - * tables
> - *
> - *	@kdev - [IN] GPU device
> - *	@gpu_processor_id - [IN] GPU processor ID to which these caches
> - *			    associate
> - *	@available_size - [IN] Amount of memory available in pcache
> - *	@cu_info - [IN] Compute Unit info obtained from KGD
> - *	@pcache - [OUT] memory into which cache data is to be filled in.
> - *	@size_filled - [OUT] amount of data used up in pcache.
> - *	@num_of_entries - [OUT] number of caches added
> - */
> -static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
> -			int gpu_processor_id,
> -			int available_size,
> -			struct kfd_cu_info *cu_info,
> -			struct crat_subtype_cache *pcache,
> -			int *size_filled,
> -			int *num_of_entries)
> +int get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pcache_info)

This function name should have a kfd_ prefix.

Regards,
   Felix


