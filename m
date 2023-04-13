Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A23C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 01:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAE910E9F1;
	Thu, 13 Apr 2023 01:01:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F33010E9EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 01:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emk+jQRlOKuKwR8scA6eoGzwXtwFtcF45Gn0ovuxI3h+IKA2yGVHVDYDmMxR7X7YNnfPQ9fxYs0T0Shetb8vjAaMrhgM/Bf+8+0PJMGMgG0CVqk1OumWCCEF/bfO/YwsLjVVl2X6BBjIXQtmKK8+tuS1isY7QnKUh55CK8G+D+xTe8TtiZXTXzepC/g9ebftBrLuvwtKxQcCs9sbRnDOZLaAahzoEc59H/xKvARSXVS8NbEYvVBihSB04xXlePDtkrx4HQwAWj9xBbFBCjAFNmXwpPfWj8ksfvZVZFaTtrOCaHb1/lZrRfeZCYxB2ln+USeD/hdFJxqcBKVwSPMqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij4YV8WHJEOowxJn0Zh2PAW0pA/h4zP6SXDmwtvqkGY=;
 b=hMT79E1Dno6dgKDdBqE5aeHFl2epRIJLGaLuL5UNeQUy0yg3KxlXvM2j+eJi7AoJ8zvuqHyCIS8b3woRDNpzB18cWA+6Ov/RVP+YVIaIYP7ZafXCuyUvnr3vpVArkB3viE235D95d4t5ExfYSO4WiEXni0g1vuajC5J9xBNEG02LwuLf7ZaJGgptjJgh5Bqr/Bhcjho8WaTzMb6P/aAKVXQtVkh8PU/ph/jIO5b/+wFGuP/vvL6DmBGDzDEmvoJ6BggBEt+E9aWoyAaJJBauFN3UxNK19S6oc/jImrdfBQ0OpSANvZX6OyRHfJfmJva6nR+npu+SNn+83fie1o5CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij4YV8WHJEOowxJn0Zh2PAW0pA/h4zP6SXDmwtvqkGY=;
 b=sHdhIJdMtY8UkwOsB9DkyRrlc8DNHGLuqtr/fsnTpt2e7bxRrH3r+K/K8s0AuGQepsGwM961PgrouW18HPrOh6Q3Q8F2z6LRvOLEyW6yZ7zZfrpf4CoFh5iU9OvOoOypgK2u/vczX4D+iE6ll9yqVF1W6bKRVFlaA9iiQiMp1tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 01:01:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 01:01:52 +0000
Message-ID: <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
Date: Wed, 12 Apr 2023 21:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230412222511.236384-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::49) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c55127-dd56-4225-5381-08db3bbaab49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nEiLJFT/vgp3MD2ni5FaZ85CdVJVt88xotq+UQhAHWdL7BFYN4fOEVr2LNAQfhPKkvEbmsmPN4/0UZJIk979OKvoMI8dBC/cs0M0OdECB9indaGzP+4pxdbw3VH1TmyxJ9JkMGyVDGd4LU8GzCl0MDF/G+tDAhl8LXD5T3Fl0/Lg5Vk287FAZvehrcmOTlLo/xn0Cvb/16x9a6onWZG7PpI+rQ4XoCdz4B98cWm4HS98+GHcEUywPxAlbvNHxfB/78EEgShqqQ4qhbm5nfhWRsVOrkqZy134qYvWryJlTDduY5W6lL/mRKrTHMyxXBM5/1pfmg2rzEiXuxrhPUaSuP7GtwACy/M6p15A400uCJz6nunr74yyLycSantwlc4kxsMkKSbpR7VXk+1BAUcCbVyJ6AF65tCBVol6sD/uqW4EY5QcMnLJeKpQdbpmQReJnFifv0i32jGq6euMPfQRZYarX6PRHsTfLCdklcSoDrgadmeVu6Y5sm5gFnPsuVb55tOcApTMlxJZ5tKdCVg7CSm+Fq4kDZDILJ0PN3z43MVuBsfyK7ATz12R7OHju183G3IWgm7bIMnUXjhevzJtNAMkhCsQ7ohO47mMoGYjq0t1mgM5LLLmwNRYUvICgEAHvDD8jwiKfd61SIjpWmNJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(2616005)(2906002)(36756003)(86362001)(31696002)(38100700002)(83380400001)(41300700001)(66946007)(66556008)(6486002)(66476007)(316002)(44832011)(8676002)(8936002)(5660300002)(110136005)(478600001)(31686004)(6636002)(26005)(6512007)(186003)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldaZElNRGRaSWhHTjdjaVozbkwxUW9vekVTWEVQMEc0WGQxVXdxMS91UGJh?=
 =?utf-8?B?aUtjY3NmZFNUbzJmMXNTNHpiWjhvSTVoWkVUazdBTmhmTkQ3c1N4dXJKNlZu?=
 =?utf-8?B?VStOYjBYcUFJMElLelFpbTU2SkRtWjRVVkxGV05nZjNWU0Y3c2NTelZrUVhq?=
 =?utf-8?B?ME1wQVNMVHdtUzI5c1AxaCtGNmtNT05BK1FCS0hjaTgwVm9vOEE2OWwvMTk1?=
 =?utf-8?B?R0ZqdFhYVDdLc3FIZDE2K2lhNWhackRYMGtzblpualAwVmRBODgyMUpvaUtR?=
 =?utf-8?B?cm5wTkhNalZZMmJ1N0NWZnI2VXZiWUthSkxaM2tiOHRRanRhUjRpNlVTWUtO?=
 =?utf-8?B?ZDRTRkVRWHZlSTQ3Z2VER1JWTitjd2RjQXlRVG9ONGtnWkI3YmRnYXBMVlVi?=
 =?utf-8?B?WFBMOFBma1JITm1JRm9sdWpCdWpYaHgvcGc1bXJySTduY2owdVVzajdDMDE2?=
 =?utf-8?B?ZHJMQjUrSDEycTdrSjVUcnJlQnZrTXorOWdrMlNQOUtBWTdqVENYNGJLODk0?=
 =?utf-8?B?cXNibjZVNmkyMmJhV0FzSUxVTkgzU1dtOTR0amNFQjhPRys0Y2F6dVRWSnZV?=
 =?utf-8?B?cVB2YjYranN1WTRremtGZmdPOXlnM3ZpQUxvd0N6M0lPcE05bTh4eG9pcXFy?=
 =?utf-8?B?S0RFZFpsODFGb0NuaW9SOEszSkJrMXRhVVdrSk1WQVovcGdsZStsZTM3OXdT?=
 =?utf-8?B?U3RVVi92aWV2UkFKaGxJMG9NOXVtTFBvdnp1ZlVxWE1jWVBGS29uUzJxWG4y?=
 =?utf-8?B?Q3RkbXNZdVpDK2J2aUl3Z2M2T3ljMDdkQWpMQkYxTFlERGFXYk1VY3JyUUlG?=
 =?utf-8?B?T1NITzBXUTZHN3cxTGZNRXZxOUNFYTlSNVRLSGZrMUhZN0Rpb1NtWkI3eXVL?=
 =?utf-8?B?aU0vbVN2T3lja2c2Ty9oNEFYZFNSQjlCZE4vRGFWNHpyYnNxWVc3UFJWNlFD?=
 =?utf-8?B?d2V4TE90MWl6Y3ZEV25oODB3NjhtNWZNdW5EUWpsVHk3ODl5L29LS05odGN0?=
 =?utf-8?B?ck42T242L0VBblgvaituV2JWRXV0elA4TVJFaEpxWWlkc0NlVmdJUFNIeG5K?=
 =?utf-8?B?Zm5FaC94V0tsU3NUcm54S2J0T1BHTFRxUkhvTlpqQ0s3NmJML0VyQXRpSWVo?=
 =?utf-8?B?T0E1OE1lSXBua21STTNkbExjQXViSEdaV0N5YkxHZWtNR3FUTk5sb05PcEs4?=
 =?utf-8?B?Q3Y5WUc3KzYza0poZndkZ0oyVVJ2OWpKMWFUU216akgyaU1QRGpVQVFGTTJj?=
 =?utf-8?B?MjV5WFUxaE5aTHhFUEsyL2ZqeE5FMkJhcUFKNXF5UG05aDZLN2pLM3hHanFE?=
 =?utf-8?B?V3VZRnJvMHVqa2ZHR0wzSVJoVnY4QkZQQlJaWnFPTDVaRm5Za01Oazk3eHdh?=
 =?utf-8?B?Y3BkREVsQXBkMFF0TE9qTCs0a1ZRUkEySlZVMmNZQ3ZZRFE3aEIyWVBDNCtt?=
 =?utf-8?B?c21SaGZFU3JHb3dnUm02UncwK1dXSkhycHRqTGk1ZDE2a3o0WnFFT09LMVpl?=
 =?utf-8?B?QTJyaXU5eE1XTmx6bi8vQk9mK0tSaVJVYS8zM1FXT1VXMU5uK3JwcjZ4Q1Nk?=
 =?utf-8?B?ZXVOR2M1QXppd2k1czFyMGFrRWtLeDlrRmVLMUo0SFpaWk9jMHlWRUoyTmRM?=
 =?utf-8?B?U0hqRUhDM290UHQ2VlVOckZEUzA2ZjR6K1Uza0lYVXBiK0VvVHJXTTkxRits?=
 =?utf-8?B?SXlLTnh1RkN2d0hkZ3lLQjRMSE9HcjJTMGgzOWZ0SzdZV3ZIRSt6cmJCY0Z3?=
 =?utf-8?B?Z0hiTXhEZDFORTEraGRoL0dGVjhvYkxwQjEwZFhGclVnS05MRnNKYzlleVVD?=
 =?utf-8?B?Y2F3eXVLN3gwdnFHNkVjZGwwNngwK2Q1NlhjK213Z1YwSkhEZ0R3dW0vUmRN?=
 =?utf-8?B?L1lDUFNnL0JYVmdVZUxsK3NkZmVMa3loUU9ER0N0WFhoWHBCQ1RFbUlhZFNG?=
 =?utf-8?B?OCtWVGZUS0RhdzNGZTluZW9CSXloRko1bmVGUUtnUUpDdzBXQ0loNHE3eHZh?=
 =?utf-8?B?OGtmVkcrSzJ5NEJmeWpCWXJxRitFSm01VlBFdXpWU1pEbDlTZTJBaU5LL0di?=
 =?utf-8?B?M0xYcGpXa3dUQXFlVEE3Vm50dUhyODRVWHErQ01Vb0prMEgyOHA0NHB3MVow?=
 =?utf-8?Q?urged9N6uxw2kPx7VS/9v+52e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c55127-dd56-4225-5381-08db3bbaab49
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 01:01:52.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y+pC478SylgJHm6vXcO1X8H6wIuhwXDSsbyUdqr+G8FZ7GFdttop1eqyzvTlVv9+G3TcKJk/bQ23x4ETEN0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
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

Am 2023-04-12 um 18:25 schrieb Eric Huang:
> It is to avoid redundant eviction for KFD's DMAbuf import
> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I'd like to get an Acked-by from Christian as well before submitting this.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2430f3e9f3a7..64795fe9eecb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	if ((old_mem->mem_type == TTM_PL_TT ||
>   	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>   	    new_mem->mem_type == TTM_PL_SYSTEM) {
> -		r = ttm_bo_wait_ctx(bo, ctx);
> +		if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
> +			r = amdgpu_bo_sync_wait(abo,
> +						AMDGPU_FENCE_OWNER_KFD,
> +						ctx->interruptible);
> +		else
> +			r = ttm_bo_wait_ctx(bo, ctx);
>   		if (r)
>   			return r;
>   
