Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5FCC001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 19:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BCB10E0FB;
	Fri, 20 Oct 2023 19:27:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EE310E0FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 19:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6AMBoomix1eby5u6umHa15J/0nTuAGsgsAKoUOhYR/TwGPrBez4y/TusxI4Zktn7Zg4NafVITmP9PMMnhbZadgPagMkCnBKsh+V7HNMnHB+XQXexnKRHD/X9GM7wkXByP94FgMBqyowvvdQ964weFvp2PoNg0U0LzPdVCeMs15vplKdzZkHg9sD5Z2ANqTcLthVS/rNIt9ae68o0a5hb2NXwHXYxes2XNJELmAyhGt05tMKXa3OLYVvL6XWDvf/rLacMsypJ3ObHq6eoJdSKuQtvpbdWkt6lrJzMhbn8CLsKY3nbFs3GlJnkfC5lV6eoXJDPYrbqAIPZTvDi1aeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaekKk5wLTrdDqZysrv8RCFMCvbfqTlho/bFQGNCM44=;
 b=Re/tiuG03aFpaHwk2g1Mn6HF3aZJobN4mrPbj67PztSWo18TTMDxpqECBbSi9rbiXblFwYBZMHeHkJKhtTW4uh/NXojY680vz61oTijZ/l0mI/g5zS5/uV/onyUE7aXAYoKff+DzadSDbfpgxY9O2vdQym8rhZvjAVnYBVz9iGhatCUXHRERzFiFi4z4KWUBhxTtKa1kMgfAZ5tMw7zZhG71IeppNvKD4dBOM0zp50N4D/6NwwNQ8uXs2cvsByBBXFp9X44F6sLvp5t2f09zU9u0YRE+scXVbcKeDYWHrVuaCi2hfR9q1Vsf7KRVDL0+NwAKT3HeOMhlIT70xIl42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaekKk5wLTrdDqZysrv8RCFMCvbfqTlho/bFQGNCM44=;
 b=o2g9KpLAwHW7ncgKsnJ9QkWKjj3ddPQr5neAaceu/1dFfY5iPkbkcusPg4C/a9IUcG7yTObeEMgxBXb4eNL7k0rZSbIcpUlPiVo4/2gLXTA/5v2/4OLa7gI+qmuUx46Og493FjBeOc6hQAnpwhj1ls1YoXbsl/cxABipKkX7gT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 19:27:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 19:27:21 +0000
Message-ID: <2952c000-5dd5-46b7-8aad-4535c1af97da@amd.com>
Date: Fri, 20 Oct 2023 15:27:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: reserve a fence slot while locking the BO
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Yuliang.Shi@amd.com, amd-gfx@lists.freedesktop.org
References: <20231020123306.43978-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231020123306.43978-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0231.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b25fea-9017-4faa-bff9-08dbd1a29484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf8wI2ZyWIFwx1X1c/EdMT1dbrzcfAiqf1i6q5MJHTKmar01KKOa/ALvm7l3xaPV/iFQwD2Nw/mAW4o3w7QJ85NcPGBOIC+FNMShjogi/zGCBQxo2A69dzzLiKbcg01rtdvF5J5fRwvV7gKBM3Ycs9faQJJc2RxmnCH1XCdRt8Ah7Bi3dMc0LxaDFdl3XxHHRpPwoEUIzmp8nFVxkbDTr77aLoMHXafF9lZ1NC0YqksxpGq3SWSZjOQLRDPDJ8rfIAcvzWNvqdyq24Qn+tn+ZhL4ALQNYzuyaZn4t0Zrn+zkMiUlDqqbP9Tx2BJcDDhwnb8t1js9oF2gFh49tDvymJxDkgyJKdg2bollHUh4iLVCnduLCkJ3H5dZoljAtViHejliGdVctIa1RAHE2cPb+YUTaTFHwFxgnEByAecoowrfutjOAG82PzRvXJgQ2AKfCHhR3k1Gd+Uq8J46ZRAIXfKMqqnDOy0vHg1Pwwd1bWzIpJa7aWBwT9Wrc7UBTKnNqAMK6NxF5lMFXGqM4QHKlOa4E8nj2ruYfThrBJbBK2aISCZlrcltUTug9S7/I49hbJHCdS0O0qNR1WB+MzhGgPi4DUAzr+Be5RKwa4yQI6KxAFaNnPtrMjecEOcXC7R6xWocTECMuFcWrNJGSdqkPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(316002)(66556008)(41300700001)(478600001)(6486002)(8676002)(8936002)(66946007)(4326008)(31686004)(66476007)(5660300002)(44832011)(6506007)(36916002)(53546011)(31696002)(38100700002)(86362001)(6512007)(83380400001)(26005)(36756003)(4001150100001)(2616005)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JVK1E5c3RZMjJVUU5SZExxS1RQUW5ScmNob3hha0duM3YzdzBwRE9uUWpF?=
 =?utf-8?B?RGpGd1JqTWNWL1dEbGg4MDk4cFdKbFBVdSs4b1lhZXJLZTRQU21rMStZcHhm?=
 =?utf-8?B?RzZtdUJYZHNFRUs0WXRZcFE5WGxDUGlVbWdqWXp1em51azV2OGFKZVdhM2k4?=
 =?utf-8?B?ZTdJd0tKWlBFVE9JRkdGMWhHd0RoeVEzYklxT2w5VVRaTVVYT2ZDUkZBZExD?=
 =?utf-8?B?Z2JvTm51NWtQMk5heFJPRnBPbmZlVmMycmZPMzUvNXJudFdsS1VnWE1aRXdM?=
 =?utf-8?B?bHYrUmR2aWR3Q2JkcjNNOGdiNlQ3MXZGZjNCTnhVMURIZFA0b0x2NnA1RVNQ?=
 =?utf-8?B?MHNPZ25hVXAxL0RLbzFnQyt0MmIyZ25HaWJpRitlcThoTTk1WldSYWNQYUt0?=
 =?utf-8?B?cmdValBEU1J5S2cwa20vL1IyRGRjR0M5QnExM1JCYmJYODl5UVJtR29qU3o4?=
 =?utf-8?B?RDQrTWM2cEZSdy9CaG9XOVhjcHh3c1pybXdvKzRpOTdMckQ2RHZIaWhNT0ZB?=
 =?utf-8?B?Yi9JQ1ZJSzYzVHBTcHFjNnF4OGxoamtOamdDd2tKNVhZM29JOTdZbUVsUlBE?=
 =?utf-8?B?WDZ4L0RiQzJNUVZuVTdUcjVSTWxRKzQ2bUlwZWdDY05QbythQ0ZkU1hLZ0pt?=
 =?utf-8?B?SzZwZDBuWmFJNUJYMm1RVnV5MWk2cmhsclErYndlNEJmckcxSVo5cUlYOHFm?=
 =?utf-8?B?QWtiMmFqM1EwY3FSVE95R1BtMnFmTmxWTG44THNEbFBRQXNSNXlCTVZ1SHh2?=
 =?utf-8?B?R2JoWkdnMTR0cUVsOVczbGJHZTVFQnlwRHA4RVF1bDZ0MVVYc2s0dEpSUk1w?=
 =?utf-8?B?UTB2NEVIQmhqRkFKVG9LdGhKekNUcThobXhQMDAvMXp0UGdQWDVOcSszMnV5?=
 =?utf-8?B?KzJUZkJoeHlJNVpLek9pU2RwNHFTelpVbkYyK1c0Q1Viay9BWURTNGkxdVhJ?=
 =?utf-8?B?d1NFdHlNdEJySmVCb2dQTDkyL0JLd2NsUXVaQktudVZ4cnRqdWZrRzJvM3pp?=
 =?utf-8?B?eDQ3cXE5dFI3U2pTSjVZSEhLajdCZkhmbzc4NVdYdVhxM2k2TEsyTU5EcTJH?=
 =?utf-8?B?UE42ck1VMnhjTHU1QjRFZzlPdGZNTDMrU1I4YThkOEkwdUV6TVlWVjExVC9B?=
 =?utf-8?B?amRXSlJZamhYVHdpRmtWejlHK0ZoQjJ4T0o2blpmN3VVbkh4eC9qOUo0NlZj?=
 =?utf-8?B?MzNSWEYxTVQ1UlRPbkVnd2xOVmxlODh5d29zaHNFRmZlQVB3VXlFOHNrWWpw?=
 =?utf-8?B?VUl6eldQVXZoMnBiRGR0RzExb3J2bk54WktNYVFINGNrQzVIQnpXczcrcko1?=
 =?utf-8?B?NERhUSthVHIvRVYxZHZOZFB2WDB1WTdnRXU3SWNIWXBSS1FIMWdOdmNVKzM4?=
 =?utf-8?B?dC9HWW9vVnJUVS9OWTVDNUdscDd3NzNFbm5zbUZyc3plYzRXWWtWdGJBR2Mx?=
 =?utf-8?B?bjBkYS9vbmZrdWk3SGxNSGZQbkJtb1NZVUNqWkVBME9qeXpaZzZQWFV5cE1m?=
 =?utf-8?B?eUdOT2xHK2tCVnpza0NBNmhXeFcyY0hmeFNWVU1KSFBjc1V6aGVycnVoamNo?=
 =?utf-8?B?Z0FISXFuZGdUZGt5UGx2RENiTGNoVStWcVpPNm1hcWYyTDhRaFBSbE9Na3h2?=
 =?utf-8?B?bzMyNytlQVQrUmxZbHdUOElFSEFKS2E5bWNGY0ZtZHQxcTRpOG42ci8zL0Zy?=
 =?utf-8?B?c1BTaXJ4cmRLQXk5RGdmYUNvc2JSc2Y2N203UXZzcVJXWDJmcDdhc0NqT3Fz?=
 =?utf-8?B?eFNUaitwWEZtamFnQzQyL3pESDUvSnA1bXhKMkFMcFlmSjhycGpkcVNTdURw?=
 =?utf-8?B?Rk9UY1l6N2VXUWVHZjJzdjIwQm4yT2ZtQTRGTTdWekd0NWNWaGJIV2NhVEdM?=
 =?utf-8?B?VVFXVkxEcHd2dFlCQVZFNE9PaWw3V091MW9vcHFSblY3RGozdVlOVFFHOTJB?=
 =?utf-8?B?WVpNWDlpN2hLbTQvc2w4UUNFL1J6MERISnRQaGJtbFVhN0JKcWRqVThlRUx2?=
 =?utf-8?B?MjRmbHFFVVdCdGFFcXpGS2NNbmZqdWUwNjFoYXlVcTVsc0JsV2djMGlWYzkr?=
 =?utf-8?B?NFRUYzNrSUxyMDlmU2RoQkRzOXI0MVZKZFFmZUI3WUUwVjZYSm5xbWc3STBq?=
 =?utf-8?Q?nxVUNsPD703muXUMqmCHbKcRH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b25fea-9017-4faa-bff9-08dbd1a29484
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 19:27:21.1787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTiqX8VxNW5VA1njkiczdNT0BwUvDnrgomwx1Od7lvOcfXVRkAzLxL+fDzsjQ67XjniNtS3tAeO/wRRvMLSIXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-20 08:33, Christian König wrote:
> Looks like the KFD still needs this.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: 8abc1eb2987a ("drm/amdkfd: switch over to using drm_exec v3")

To fix the immediate problem, this patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

As I understand it, this reserves a fence slot for adding an eviction 
fence. I'm not convinced that this is the right place to do this. Not 
all callers of reserve_bo_and_vm add eviction fences. In another patch 
series I added the fence slot reservation in a new helper function 
amdgpu_amdkfd_bo_validate_and_fence.

Taking another step back, as I understand it, the pre-reservation of 
fence slots is there to avoid late failures after submitting commands to 
the HW. This isn't really a problem for KFD because eviction fences 
aren't directly linked to commands submitted to the HW. It's more like a 
place holder for future user mode submissions. So I think it's OK to 
reserve the fence slot just before attaching the fence to a BO resv. We 
don't have to do the pre-reservation here.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7d6daf8d2bfa..e036011137aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1103,7 +1103,7 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
>   		if (unlikely(ret))
>   			goto error;
>   
> -		ret = drm_exec_lock_obj(&ctx->exec, &bo->tbo.base);
> +		ret = drm_exec_prepare_obj(&ctx->exec, &bo->tbo.base, 1);
>   		drm_exec_retry_on_contention(&ctx->exec);
>   		if (unlikely(ret))
>   			goto error;
