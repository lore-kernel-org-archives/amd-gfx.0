Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF3FEC8758
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B02B10E094;
	Thu,  7 Sep 2023 20:31:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666D010E094
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9iyUhU6rNtNJFXy3Set8NVavHj0L7E/KcR3wACDurEgTYH4glj1aTM6h2imYrqgiOD7rfrBQJP9KnsTzVZKk6H9Wp97YzBdqYPrnwaObz9YLAuZb7qwYXHdHdjd8g7BWb1dLcTr1H42Pg+Sb4NWAcsLy+ZNRwT+g5wpvenqOfSsJhwvF7qSn316WBRpb/imp/e4h9We9HtnCcbUtacjMSk8pYshWDK+xRpe2XnmtqW9MRHLTwDLpI753ur80y8h4hicHuM+ohdXu929W8JBzZzL0F8n0fc9B3iGpdNc5duZcYIjg0fWNSPN2bgUgZHGLftOLUuZowPPg3i3m3+Uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG2UQ80WzA9wlXNgQ90CT+q9cUx/GTzAREH2QU2DqfQ=;
 b=Pn4A5GsQIUkNIrFZ07pNm+rKBZH2R9sb7CEu/oNbj90SZJOKdljowSQ7v5rZJECFcWJ0YcKb/WeqTYeZPwlQpe1eVWVdzgUpSbQIX+kxIqg+vT1a3qi29WFSY0ENHW40omEz7Z0RO+pNjEpDShiLx6/sX3d7DWA/Jzj3LIMym+wnsaos3vNT3chTcUOgnvGSrA9yP8EtGlE9ruVVjKovsFIyrs7nvqOJUCT056Cieoyepr1vRyz2euv+CFyMxrVxbhMqkNBz3/VPyqt+16dnhz/bAZgcivs5hSPodkPt67f8s7tZqtnW6ECWvA9w/IrF1fCGvrRcGJk9Sg7l/P3Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG2UQ80WzA9wlXNgQ90CT+q9cUx/GTzAREH2QU2DqfQ=;
 b=JeJEF8fdOEe2ojyRXTsaYlrVWg89ocUFEeQBm1XYgdNMISnQ6Gn2VkkRTECArEuysC8iuOau/tWOarU0tMHfBIiJuPOzcLb+j+nKJI8N3aCeqqt/TByGoAxO7iwOOHginrUiEj3YrxYrZAcJxE4F5NBXmJdu+kYhuppQjjw94sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 20:31:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:31:20 +0000
Message-ID: <3010803b-edae-1878-e1d8-59523cad5e21@amd.com>
Date: Thu, 7 Sep 2023 16:31:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv2 1/4] drm/amdgpu: Store CU info from all XCCs for GFX
 v9.4.3
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906154429.216489-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230906154429.216489-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 55469f1c-a246-43b9-2fe9-08dbafe16527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 420+yPuGJBf6PMwyz2VjMCHuAHw9m1mL3MkwnRULRIZWEf8RxWriG3mG/SLInexKEnX8Rm0mHwm8orUINJwt+rPJgeMTH4lcgC5T9uYkXWtvfQIROXYck+1oAAlXQz9wQolD9RSRLfalx7racA2RqbtCQanyAi2p7k3+5GCaD/OO6hM5kh1ic7H3bfjOur9ciCbNpBkogqx1dl2CybctNBs/ZPtiwPwiIRq/gY4BTuReuhKlH59sP9IxjAvCJiMOQl7cZj2a7ZrdDIXXW2maUREuVo5SniSygmHzDKb5PZudJvlIO4qYnUH1/npc6oaEaB+WV/oinihpCEn14FC0hS5YGfFEtY53l9VqeraFju+vqrjtU6QLll8KEgNIR6X2GFcK2s5WBNFSykCUikJnn1uhAytxQ+r/CZLIGV1V83HwlktGMWSMEnA0g90K8nrt83hJFJU+Ae7nugnjMnRNrnZpfWZ+ForDK+Nwdzt+qcKX3cdKxVqo6MnQCkkEBAb39cel4BLDa6GN45hfYFioClXY5mwQCnKnrpCHk2Axizo0XpKbbMuda/YMhvwKrWaApDAHWfIq1AgBFQksoVbTmjxNyOMLJdL2Q4z1CqnT13rLl9gIdgRBhxeKCapRWESDUL2wni5gGazrtR4JvU1HOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(1800799009)(451199024)(186009)(478600001)(6512007)(6506007)(6486002)(316002)(31686004)(2616005)(8676002)(41300700001)(26005)(44832011)(5660300002)(83380400001)(8936002)(2906002)(38100700002)(36756003)(31696002)(66556008)(53546011)(66946007)(36916002)(86362001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdIcjVhT3ZTT2NiWGFlV1RIMGNJNVBMT09qYUYxZ0Zid0lueFY3d24wcU82?=
 =?utf-8?B?dDdRZXRveHRpODZjVGw1d3VuakNLVjExWXlTdVphWEpldVI0c3RtT3ZsejhB?=
 =?utf-8?B?R1lDMkJjUzFWRGlMUkJ0a0NIWStKK3dsK2ZNMENudGZTb3V6WnRzUkV5cmV2?=
 =?utf-8?B?T20rN0d4WlZ5ZncvTXR2Ky8xYkdpcGZWcUtJNEc3UytNVDM0aE9mTXhyWlJL?=
 =?utf-8?B?N1ZWMUFLTnZaaTVvcnZ6ME1WWkk3SVR0YWlrS2JMUjZsYlpxQ1ZGRjFkTGNw?=
 =?utf-8?B?MzMrcDlFQUJZZzN6NXNVdnlFb2crc2RWbnhVcW1nMmFiN1lHdjYzcWd2TGph?=
 =?utf-8?B?K3o4RnRUM3Nvci9UTkQ2cTg4YnZQb081TzYwZVJLQi9NcE1UczVoOFZzQzIy?=
 =?utf-8?B?UERtUWdGUU5NSnp0NlNTMkJtK1pmMmkvVjNyQWN6ZXlsaXZYeXN0R1l0dG5H?=
 =?utf-8?B?QVd2aStGTGRPek5zbHFCQ2REMm94M091ZDBEOThRZmJ6YjN1UGxMVHB0NFFz?=
 =?utf-8?B?K3dYQW5jdU1Hdnc5MXhUKzhBVU9PenRMSjhHN1VESk4zRXFEbGpzbGRRRDFt?=
 =?utf-8?B?WFY3R01tbE1NcXRadzFrTGNwL085RjRtanU1cE5mT3UyR2lBc0FGMytwZm5R?=
 =?utf-8?B?ZTFTVnQ4TGNMRldTR3hvOGN4YkR1YytwZmpOZENRRTVtNWh3Mm9hNGJwN3FF?=
 =?utf-8?B?N0VtQ0QvcGZycUdVbGYrckdFTUtNSjNKeDF4UTN4MUJuK1ZBYUxIWUVYRysx?=
 =?utf-8?B?S0VaUlFjMVJHVVB2UEJrR2FBMGNBeDFuVFZ2akV3YitDTmJCOUgzZEhqMnd2?=
 =?utf-8?B?OElZR1hlQUQzWGdFdDJtQ1hEUWEzRWZPck9ybXdlcmNpSitSUzZTL00zMDZs?=
 =?utf-8?B?dHhoRWxsV1VIQjNZSVNQN0JGKzRxZHVpRGV0b2lvNy9zT0JzczF4czBldG4w?=
 =?utf-8?B?MUc1TmdmRTJkbzlZM2REeGpDUVZGaFJ1ZXpjeG9jY3AyYkswUVVOeWR3MEND?=
 =?utf-8?B?NXpaMHllNk93SmRWTU1SanltL2NzcGhCSkdhL1liRzIzeHA2NDEzN3FRQ1kv?=
 =?utf-8?B?Ymc0dzNtV2N4R2R3WGw1S0Q0cFNMTThud1NZbThJMFZ5d29DVmp1aGtNN3pL?=
 =?utf-8?B?ekNlbm00YlVGaW5RU2NhYXM1TkVHa09ndEp2SUNhSE1HdFdGRmozMW9kVEpM?=
 =?utf-8?B?anVqbDVOVVZwdlM1UEJ4NEJocWZubXRJNmdGZjhmOEhSZUVmUTE4M2dFUnU0?=
 =?utf-8?B?Nms1WGpaanZkQ3RVWHgraGxNbGFIZ2s2bnNVdHFNUk1XQ1AzWHN6T3B3UE9h?=
 =?utf-8?B?dDVTS1VWZ3pvMjdIdFJzditGcVZMMkQzZVJuNnMrRHNrUExkYWNGeTFSZlBu?=
 =?utf-8?B?WmJoRlFTVXEwV29kL1ZWUXN0ek5jUE9GZlo4QzR2Y01zQ2Q5ZS9lZE02eHBs?=
 =?utf-8?B?SVYwNVhCZmtCbmpWRFBwUy9BSGxiWUZ0ZGU1d0tHWkh4azExaGM0ZmRJSmtt?=
 =?utf-8?B?UVptbUlTb3U4ZVJoRzJJUm8rVVlVZ0lZVk5FTEdHcTJKblpQcTBGbEpVekpJ?=
 =?utf-8?B?M1RZbTRmdFhGUXdGTHZ2eDRGYzhEUTZnR3U1cE1Tdnd4VjYzU2RKc25kczUw?=
 =?utf-8?B?aEZqekoydVZxUjRZS3N1SlMvcjhveFN0dkkyOGVxZkhsZVRDa1FBWHVSUFZI?=
 =?utf-8?B?WU5pY3pFbGhlYklQekZVVFpGRnFHNmUvVTBTcHZFNVh0bEYzZFRSTThhSjh4?=
 =?utf-8?B?dWFsdWozMERpbWRHSllGcXc3ZjJmZ1JMTGtRODlIeGFES0V1bUtZbit6ZjV0?=
 =?utf-8?B?M1QrT2tZSHB2Nm50QVlsMDdYZmNwc0NJY3FucFI3VzlJeVRtV3Z2NmNuMEkv?=
 =?utf-8?B?eU9YUFFxZm5zZy9JZjJ5eWtGR0lKN0ZrWG05T05mRE1wdU8yaURaTDFFUHJx?=
 =?utf-8?B?OHNOeEN3azg3L21FY2EveEF5bkN1UEtVYUUwNWZqSGtoT3UvYzFqdHFkUi9X?=
 =?utf-8?B?d0xpeHUxdkpoVE1Hb2UrK2ZaWjJwaGNRc1V6TkhEY0VmWGdBV2QrSGQ3eURq?=
 =?utf-8?B?bjFvaDQydXdNYmt3U1FVWlNyODl0ZzlKcUtQU1A4RGhRWGZGSmlkeDkxYXRO?=
 =?utf-8?Q?YCy1/UWLCcA9v3zfmt+55tafX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55469f1c-a246-43b9-2fe9-08dbafe16527
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:31:20.4610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O3sMjbhOVcwTwXVBsa7IPgHuAaM1lvv/Rrqrzr1A5Ba6PFCvWfPJWogkvEKU7rUXYByWsDNLwtfGnV5lTDyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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


On 2023-09-06 11:44, Mukul Joshi wrote:
> Currently, we store CU info only for a single XCC assuming
> that it is the same for all XCCs. However, that may not be
> true. As a result, store CU info for all XCCs. This info is
> later used for CU masking.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

One last nit-pick inline. With that fixed (or explained), the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Incorporate Felix's review comments.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 76 +++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  8 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 11 ++-
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  6 +-
>   14 files changed, 60 insertions(+), 65 deletions(-)

[snip]


> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index f3f40dbb8ff7..3b5a56585c4b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -31,12 +31,12 @@
>   #include <linux/types.h>
>   #include <linux/bitmap.h>
>   #include <linux/dma-fence.h>
> +#include "amdgpu_irq.h"
> +#include "amdgpu_gfx.h"

Why do we need to include amdgpu_irq.h here?

Regards,
   Felix


>   
>   struct pci_dev;
>   struct amdgpu_device;
>   
> -#define KGD_MAX_QUEUES 128
> -
>   struct kfd_dev;
>   struct kgd_mem;
>   
> @@ -68,7 +68,7 @@ struct kfd_cu_info {
>   	uint32_t wave_front_size;
>   	uint32_t max_scratch_slots_per_cu;
>   	uint32_t lds_size;
> -	uint32_t cu_bitmap[4][4];
> +	uint32_t cu_bitmap[AMDGPU_MAX_GC_INSTANCES][4][4];
>   };
>   
>   /* For getting GPU local memory information from KGD */
