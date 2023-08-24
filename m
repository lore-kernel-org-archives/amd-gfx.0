Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C114FC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 14:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593F210E574;
	Thu, 24 Aug 2023 14:56:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6EB410E574
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 14:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJFayYkbojTHa4M2SdI3HUWKRd19oBYHODjrTrVvPwT3FDI/RnaFsCv0IgoiqIAtw2cROje2Of3TabLO/m8of+n9LKDTgg7/cLpEOSZQa7zHdGP8fDE0kNVIibn7hGCR1Kw9ECWOTi6HhSdAHS965pisaqMxLI8fxYrAa0A9I9TXrtKrsuMgfrbLU2dmGkF8gHE5FD/LNJKoKa+8jRxaRSjlkNlrs8AYOjswIeUjZkEMJIlu7WtU/bfhiwoQWxt/7RwYVP5D4JnF1kXF5CZp2VvoON4BZ6qmFdHkHOZamzFqOzopDpscAJ62KeIOsN+XZy7/7bSw/r4qScloBxuGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipRbSeAs56Aw4/pAj8HGJ3keFiKURHG1s+NV0PIdVXI=;
 b=bKw+XCfPkxFzxiV1FkgLOrDu2iVVouK55rSRxWfBp3y0+m4O16rfbFibZZeGmdMRZtVQJ7HIt7aM9JDGu36KecGl89teeMBaUh8LtoNJuTpchYRLAe3c72d+EC+B5HeROepsAgptitPoItU1klfoT9/NXe0PIuLEXNzsEs2sZ/wMiUBsNJ/viNd3FwcffdcxOZM1NCgW9KcLMOiMZyzjJscSXRrMqLiSG3BGWXgVoc155K3oEq7KIM/FS/jLV9TDCRDM1wW+wFNb7ACGswLFHRf9PzTtARKqaYc021Am/af9ZmHATDnNVr8N6g/iZxB136rFjA+1cAG0IwE4CaV5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipRbSeAs56Aw4/pAj8HGJ3keFiKURHG1s+NV0PIdVXI=;
 b=BIVkiI84ESau9Vf8PrGiXjrG2GDDHDCM8zqUszb831lS4IIOtIvp1kTfZsSs/rkawRJ3PAfZtaS9gFYCI6eEE0nGdjgufoHE67ztFX7oWtHXzjxRO9UyRN/w8nLuvRr7422ORDzpydkbSMwSBP6tGUe2bU6YsoL7gRjJsQt/jmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 14:56:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 14:56:49 +0000
Message-ID: <747be85d-84ec-d51b-cd11-1a52332f1fb6@amd.com>
Date: Thu, 24 Aug 2023 16:56:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230824135337.3975006-1-yifan1.zhang@amd.com>
 <20230824135337.3975006-2-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230824135337.3975006-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c27ebb-e2c3-45ff-6524-08dba4b2583b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYiv1zBMig4jCCOavh0y799D0T0VjYg3Trffvmoug8+dl3uvD3w/0Lvb4TA8ZPBwmqkrkSNoDylrIW36PeQgWicY0l10fl7c77IGNzasGhksu0pYO8FnXiz7fRsWOhQjpiYMvNpf/u9ujLgrRcEC74NBMLEDvbywGCtmVwoyDX3pzUb9UwPfjXkgOQjjFAZRtE6gDEmnOHSJjHIFLUvLtzUo14MisFyYabhAMaTfz7MzWzCYJ624Z98TJwP5uUfq9uXXMTeSaGqJMhnIc/w3rvJ8Xb1tro/NzJ6HdQhpLgnm3eRY0gh/VRg7yvI1FuJ/dDMr1E4JK05bPzohZmPfElSRIO8TX3w9qaXNkUNTZ/5inZuWMNVzcVPwidl4oUy5unCDVls+W2XVsDWKUhF4ejeoG/g0H9o8q0PAlHZK85NUVJpEAT0Z8jSRsBnrget4ciIvfS4M06e6oK4PUdve7PFqH4FspewE5YhxLKOomZK5kPwhyquTr6jVcpHvf91qEneztZHiO1HMpmHAKU5sCphWwU3qGQLNJZMu6R6kRbRWjr6F1R0o//TdyQHUHa2CogZ+OacqFOBTKJ6nW0xuYMFXMnNnYtBV7uUVEi49unVVx+w7vr/vSNIsutNMPvQkz/0jop+OTCLnwnZ7mOWI9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(26005)(6666004)(38100700002)(66556008)(66476007)(66946007)(316002)(478600001)(31686004)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHYyZkR1UXQ0am9icWRvR1RXSGZrYWxCR3M4djR4L3VxWkdSaGFTMlBhVTA3?=
 =?utf-8?B?dUgwSTlFMUs4Q3NESmF1TkFyNkxQbDFpWFZISTdGZFBGWjhUTVFLdnpKdU9O?=
 =?utf-8?B?MFgvK1l1cnZWaENxNm4xdjViTWxrSFZXUVRXQUV6d0RjTm1mSTFUbUViNEZT?=
 =?utf-8?B?ckswOHBxVXdDY09ER3h1Vm5MT1lxcnJXZ21MMTlRTUg2MkcvekpZblBOT3JX?=
 =?utf-8?B?MlI4V0laUGVYUXZTL2duaUNJMXBxOU9WMXE3NlVSUEIwc2RPZGJma3V5Zlc2?=
 =?utf-8?B?K0dPbTdURkxDMlIyUU9ZenBHbmpIVVZYRzdjNTZYVWhieGloamtWZ0x5cTFN?=
 =?utf-8?B?Z29DYjBvMTUzREJoNmFtWGZkamFSbG1pWDhxdWlPR1YzVTNtS09DT280RzNQ?=
 =?utf-8?B?TnVlckFGUnZsS1FFMm00QXIzVzBxL21Pa2hPclRYaDdLTkltdFJJUHNzd2kr?=
 =?utf-8?B?Z0s1UlQzVFBJV0hjTkIwbGNnOWtUbUxBaTNDa05NeVVsUHBJS04xSlk0Tnhq?=
 =?utf-8?B?bGFXclRFbU5Tai9wYkhyaWhMdG5oRDQ3MnZ4S3hJT0VrZDFHbTZ0WFVjT29I?=
 =?utf-8?B?QzNIcm9JL0xTQWJLRExVSE9BL3g2MFpIRWozZnRnVXJqMFh3bjJCeldzdllm?=
 =?utf-8?B?TmtLNVlEY010WTFhQ3ZQcWlGWUlPcW5CMGFBTHZYM0VOZXdnTnRYd1o5NXZD?=
 =?utf-8?B?QzJqNm4vaW1UQjJubHFnZTJBa1JiYkZOSFE0NWFuK3FzQ3RFU2NVcEFTa3dC?=
 =?utf-8?B?UmxTMHI1alFrb0tFNVZpTWRqVUxnN1BKTi80YVh0RTBmQTd3Y3lBeDY5S05y?=
 =?utf-8?B?VnljT2FvdkwwT09haDBPcUZTUjJrVW53M3l0LzlKNW1kREVPQlVaanYvelpq?=
 =?utf-8?B?K3JEa01DOXdQbUlyTlFObmdBS2puUEhwUkRqQkM3a2d3ZUlOZFBVQ25RMVRX?=
 =?utf-8?B?U2lFQ214YmIxcTdwYkxGQ2RIMUpYNDg0UkJjelJpUWVNOHJNOEJkR3lDSjFY?=
 =?utf-8?B?N0pkaGZGL0o2dnFBOXgxNWlmclI4Vmw2aXJIYjdBUUpISGZFSzBHTDhBSEI1?=
 =?utf-8?B?RUVKZnZVTzRKaTQ5c05YN2hDdFd3blgrWTJHeTUyWmhWSkIwYm4zM1lmT2ZW?=
 =?utf-8?B?VGFvdEtzclp3L2YrRDA2Q1NNNFdvMU9YUkpnQThhSVdYWlZsaTlNZ2VablBk?=
 =?utf-8?B?T2x2SnFRV2tJYU9xb1RZWUp6Um9zY0pMR2gvcnhrUS9CZ2o4SkdBdmYvQStF?=
 =?utf-8?B?a25NY0tUSkdrNmU0UW5RdVJiNTQrZWt0cWJkazJUTVdZVVBHb3oxbEowYzdY?=
 =?utf-8?B?OEhiWktFQ0N4NXBFcDlBRjNuaFBteVVSczVIVnVuTzhuZU5oOXVEOG15aFJJ?=
 =?utf-8?B?T3pzZ01VWHJPQ1dXdzlvRUZQakJMQitVdTZCNitDZ2JlVUpiUnBKNHMzZTNF?=
 =?utf-8?B?aW93UDNrdmptcnprSEFpaDdaeExXOUM1TFdySmxLWWVjeG5WOVpRRTU4d0Y3?=
 =?utf-8?B?NFpFTDRsRC82amxod2MrcVM3Qy9yNWF3T3g1d1Q0dnAzQ3UzRW9NQ3d5b0k4?=
 =?utf-8?B?c1NmUGFMZ0ZtQXJuS0REQ3MzM2ZUTGxCdDBzbWU5RHdiMjE0RnJxOXRvNFFw?=
 =?utf-8?B?N1BkT0ZXRDZMcnZ4MFEyZEU3WnF5TkhQNTdtdFZ6c1hrcTVlVlppM0JLQU9m?=
 =?utf-8?B?cFkzS3ZWSjd2RUUveHZKdTh0TCt5dURIdFMrWTEvZlp2MjZFYlkwWnhBSzJC?=
 =?utf-8?B?b25nWitjdG5yM2pQdmtDWGJDWUYxZmJBVmJHQVlnekU5SEcwejh5cVFHNVdv?=
 =?utf-8?B?ME5hL2xDVDg0aHAxa1RRaWJsUmRDaTY1Q2dkVTN5NCthL2szUnZUU1UvRjBW?=
 =?utf-8?B?ckhCUnloWk9zTmt5QVMvNlVMOGtkWDJkZE9qYld0N0k4QTladlFnWW1vb2ZZ?=
 =?utf-8?B?SjBYQ216VVV1TkFkNE5iOFJiV2Z5YjBLU2tXbkgzY3dKZ1lHcmJPSEptaGw2?=
 =?utf-8?B?Q3BHK0FKcWhlUkdnL3BiVlhGZG5pMm5wR0ZEenNTNEZPQm5uYjIxQlJud1dl?=
 =?utf-8?B?aWNJa1ZtdjNMUnlJeWVhRGFtRkVlU2hxblZjRklUbXFNSEM2MHRjUEFKN0Zk?=
 =?utf-8?Q?Ff7AH/oG7LFn8JjMjYBguK43d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c27ebb-e2c3-45ff-6524-08dba4b2583b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 14:56:49.6721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNyEkfSdnMjb66YQOXcEWuEnPwc5P/krN+Xh4S/LQT3jlIPr7YdufjHXbMLneZfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.08.23 um 15:53 schrieb Yifan Zhang:
> To decrease VRAM pressure for APUs, put page tables to
> GTT domain for gfx10 and newer APUs.
>
> v2: only enable it for gfx10 and newer APUs (Alex, Christian)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..b108d92883d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bp.size = amdgpu_vm_pt_size(adev, level);
>   	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>   
> -	if (!adev->gmc.is_app_apu)
> -		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -	else
> +	if (adev->gmc.is_app_apu ||
> +			((adev->flags & AMD_IS_APU) &&
> +			 (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 3))))

Please double check the coding style this doesn't looks correctly 
indented to me.

Apart from that looks good to me,
Christian.

>   		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +	else
> +		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +
>   
>   	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
>   	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |

