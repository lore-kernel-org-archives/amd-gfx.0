Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1BCC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 22:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD56810E119;
	Thu, 10 Nov 2022 22:01:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292BD10E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 22:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvGLZ7oAiCA5j4yCtqqdRq6W9yQKd+r26GoPJyvWGMvV4xkFLLgRPgIEZtCmfiVjrXXtLXEyVKLVJJxXjmzSbsHeRLn87xrsM8KaBLSv49g4+xhO3wPSbEPCCuGa5tyYjnqWunRgcysnbRFGZ5CxNsZDEp0rF7zgoU7tdjUqDnImHBh+4qv2PsOkSoURuMCJLjv12BGT+iqZAZxsm5DXJ/TNfGYBng/SPmmvSlSDPCy5EJrhm9iI3qbsJFKF2vC/I6VMeWRZUv/zuU4vEX7C3qAs3yTm78+gh0z47Uq5LrG90S3LbRf7l90mn5WwkiUChK6cOuanf1MWvtS74vc3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya6Fo7Yn0E9CYGspESCxw3rdiU4wc/pTmOfUDT9PeHY=;
 b=h0Z8oiNBnasmZMiWYtdbeqsNrbQV2IRMXKEY1cBIxTKUuYW1IiGDaZ2x0bMnuv/1xvhjbFcgr3SqocrRUQlJ27NstGOGrx/KCAjj1JVgqXbpigWL6j/AFhcp8LBEkYGmjMbMLzMGLNUzsc+f1vdJZxy6CSRQcTeLQRFuZkrdqgDqQvMrLKzklvsNfDOJebMJGIL9lG7dJ5twF8dOu2yKzOd4qpiYmifHWG02JIlntNh7qFIOJL9K+iixILGozOUt7EZKoiK6xfxYeFck+gGnLdzHzeuA6ZnFSr3JkUvKLACWA+6q4xsDIVlYOCuQ/2jdvxvJjIfBude7tY9ghvsK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya6Fo7Yn0E9CYGspESCxw3rdiU4wc/pTmOfUDT9PeHY=;
 b=0hbQNTMFFxaAZcC6gpn5UNq9+1dHEqxYHC3H3Tt/KL2H21nAZX0HxgBu4vyJekSZ/aKvzCMViQ2v/NVlTAIaop2iOwx/N/jjMcuvEY+yE9pOA7SeX0M8lhbpZ36vq+IyX5aD0LLBY1ssi5h4XdrBrcgzrmqvX94kxilB8sGn4r8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 10 Nov
 2022 22:01:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 22:01:27 +0000
Message-ID: <4816a8c8-cce2-2516-7fa6-8fc35fd4afb9@amd.com>
Date: Thu, 10 Nov 2022 17:01:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/4] drm/amdgpu: rename the files for HMM handling
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20221110130009.1835-1-christian.koenig@amd.com>
 <20221110130009.1835-3-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221110130009.1835-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBP288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fe764b-e174-4cbc-f998-08dac3671da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZnCeaMooiEUsJ+mseaIX0KLZEms6yOQ97miGjoCZSRDkHKTtEqKdps+FbctVa0k0+eFp3CcBzmX1EBsWbT86EZgAceGtj+XvhULt5otATfWKc69yV1oaXVMVs4tga7l+RUAGjryFpPmUyXzTwIsOO4wfTS/v8582rIqLMmysi+knwLMF+AgLsqHiTbxhzTWqWty+u/o4vRbfkPS1RIntY8YTw7XjbjBsPCceZChyWtyty8Nznt8NYTyaEyFCUd+Qn007XFRzlwYv0Dpm1Ehg7rOiSC5pE2qpz085gyd2haR8EBg6NOM0RNB/1PxYol9saPHh+Ar2rkeoHQfYq2CokI5vUHMN2U85o1YLhpuiABlqaQ5cjqCwLmg7ikKc6tJh7FZjMXihSYzQHPV331Ft9Lb9vErydae8VNdmtec9/sid6XIv3gvrrP7aen1BARYhMc17MVuaVb9Cie7nbzCTxnKjw+K43oWaeyDWG/e/TobUB04Hp7jX8hkZ7hr6eEUkwizGm7+WAumr4Y84HQsIwlzWOgHZMhUypnr1MTRbM69x9l4G4fuejHA50imVJsjsoIkZMMIFNyxrAB5dcCEm7rsTJUotOaC8LnGR7PGLz7g8L7DJnMdzpFB9j+G3eAgQC3qcaCA35fHmtlhJGHFg/TbzbHqoGzbX8Kizr1yLG8G3JcHNR8lV1mcEKP9IfEmE61obVKJFR1gBiDHLW2iUgITRrLOVNovNzK/6DSeB1u0w1QuUxjPJW2xbjJY3dzy3a3sZOONKpGK9IMZnzluyTBX6yISXuJosp6RvVHR6JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(66574015)(83380400001)(4001150100001)(2906002)(31686004)(36756003)(66476007)(41300700001)(66556008)(31696002)(86362001)(38100700002)(316002)(6506007)(66946007)(8936002)(26005)(2616005)(186003)(6486002)(8676002)(30864003)(44832011)(6512007)(4326008)(5660300002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RMZFpiRDZnV1F0U2ZXVDNEYk9KT1NFVWQ2cHM1UDh5U2ZvQ3JValRWNmpD?=
 =?utf-8?B?ZFY2VWl0N0tUVlRqQXltZjFSMncwYzlTUDBKM1BleFkybUp5Q2RPbE9rMmZn?=
 =?utf-8?B?ckdOenE4TldPZ3lqazVOSFQxODNtRVNxN1pjR0I3YkdmdHFnT0RLVEhyekQz?=
 =?utf-8?B?S2x3ckt1d0p1bHBycHFLWDNjT29RbXY1ZDJzTklpR1l5eHBlaDBjUnlycnpP?=
 =?utf-8?B?Ti9VZ0FTdUdzL3l5UGM4YUhWN2IwV3ZkNDVkeWNXVGhzVFpIanBCWGwwdE9X?=
 =?utf-8?B?Q3dxcDgzZXZIek5YSWZYMVVZYXV0WGZ2S3doMzE4OTRKNTVWMnRqV2p4ZkxD?=
 =?utf-8?B?d0o5N3VKV05JcWFsamVRS1dCZnNteEI1UDVwUUl2QkttN2prNUlTN1pTcFhW?=
 =?utf-8?B?bjRlcjlkSWY3WUdQNHBvVndIOTBEdEpXT3NZYXFrUlFMbFVNUDY4R244OUxq?=
 =?utf-8?B?NDY5SEpoRXduT0o1RmtXVFgrOXNBcTJpeXluMDI5dHpIbjlXODhudmhKM0t5?=
 =?utf-8?B?akdNSG9RVUhld1ZLQitsNTd3Y3lZODhjeDFmamVLV2dId1NKWVZ2UzE1MUJV?=
 =?utf-8?B?cTVpTmU0L0VrV28zL080WXk1UGZsYVoyZWJjRXc4dkowdDJLcTZXdWRnU0RO?=
 =?utf-8?B?NlF1R1VXVVBLMkhLL3EybFlSdmlYSlI2cGZ2MU9ENnJjWExnV1dzWmdMWUJw?=
 =?utf-8?B?ckRXUVIyMndKVkdlUXJuNGVIZmNvTTFKU3I5UDVHNGZYZWJWcFUveXl6U1dH?=
 =?utf-8?B?dnNWZ1F3S3FDQ1hrUmhIV2NlQ3l5UjFTR3FDQmV2U0phVzMzTnlJMlFackhP?=
 =?utf-8?B?cGtzZzNXT2VrOHo3Y3V4ZlNSbFF5QVIvRHVPS2haRXdvaEJCU0lsNStWYUxO?=
 =?utf-8?B?RmZnemlQWnN3SDNTSXJhV0k1ZnlGcy9CVDlLd2MxUThVdDBCMEo4cjNSSGln?=
 =?utf-8?B?QjJhbzdjZFpvTGF6Nm80Q1c2bnFVdjhvQkpvWFJ5T2kwNjFQbUorUXNpMWpC?=
 =?utf-8?B?K1IyQWJrQXJtU3k0RGo5Q0drRzNKQ1pjZnFCMTVRVUdtWTRsYXU1VnB5MSsr?=
 =?utf-8?B?YlhzR2xWcTNGN2dJNkRrR1A1VzUyRE9NRjFYT3B4VlJ6dUNsL0E3TnF2d3Vz?=
 =?utf-8?B?cHhocjJsdlRYbHloZS96TEd6Mkl4c2UzQ2lWUGdKWFdRR0RpeUVpakdkaUVV?=
 =?utf-8?B?SUl6ZVk1cFNlZk5OQVZsNnRIVnA4alZvVVdOcUZ2RVN5ZnJTUmEwa0YvRGJY?=
 =?utf-8?B?MnRpTzVnbkFia2N4R1VCZkJZQ1p2U0JSKzB1bjVXTnIxSGRDSHQ5ZHVXbnk1?=
 =?utf-8?B?eFlQRXp4Qit5VDdVZUtzVUE3cUtmM29iUktLNk1hL2VZa3dCQWtGMCtBWFBG?=
 =?utf-8?B?MWtpWlh3MGZYeERJSEQyVDN3dDJ6RW96TUVQUkl2UG5uSTdZckVhZ3VydTBN?=
 =?utf-8?B?R0hZb3R5Y1FnWjNSbUVjNW9jTTE5SzQ3RVVRMmx1VnBNMTNtVDVndEtERExh?=
 =?utf-8?B?MHBPTTU3THJjM2tTY1czUmdmQkdJUGxlQnVLUmpGM0dNMC93dVFIbGJPaTVV?=
 =?utf-8?B?TDhGbVVoUUdrcE02cFVsdFZKdG90SkpSL1lPdy9GWERUY0Voc1RKQWhSU3Iy?=
 =?utf-8?B?YnNJd01HbnlsVFJhSElzckxDMHhhVHAxQlZCdnc4eEpUTSs0cUpzbC9jaWJr?=
 =?utf-8?B?RzRCNGtuSmN1L01sRnVLTVFrYUFqTkJ5dEdua0hKeUV5SEhFODVHYkpkTVlh?=
 =?utf-8?B?WFNURFYwWWJOUEFkbHhmZFpaSVoxUVd3a05VajdWc21LRDM2ekFYVmxjMHNn?=
 =?utf-8?B?UFk4a0d2RDVIRmd4ajRiV2t3bTJQbkNGNTdIajNLOTdwaWFqVWZGTk4wd0pW?=
 =?utf-8?B?ZjNUVm53aGthL29WSklLdlBWaFl5b0swTk1oTm9kV3JkMHE3N1RmUEZqY1Mx?=
 =?utf-8?B?OTZDTFo5dlYvSjZZbURvYVROUUl2ZGViL0kxZ21JY052bHhqWDVsWStTcWtL?=
 =?utf-8?B?QlhORWR4Q3ZVczJyOFdmeEU5QjhhdFJoRWJWaWk0SEkrZ2pCOEd6VWhCZjc5?=
 =?utf-8?B?SWFJZFNJdFdnNVZISGFMY3hJK24zenIweDZUS3hSK2gyR3UrL3ROS2lHZVJ6?=
 =?utf-8?Q?XLn/l5ZTcCHKSQGK0qiT0rM+8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fe764b-e174-4cbc-f998-08dac3671da8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 22:01:27.5046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g6eWXbjJ97gTsO2bkImt+lql9bhvF9g9lFyfCU2mW/bSCbRAIxzqyg+dUriOy4U4L5nQuzS/PqFgUnT99fuwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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

Am 2022-11-10 um 08:00 schrieb Christian König:
> Clean that up a bit, no functional change.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 -
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  7 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++-
>   .../amd/amdgpu/{amdgpu_mn.c => amdgpu_hmm.c}  | 37 ++++++++++---------
>   .../amd/amdgpu/{amdgpu_mn.h => amdgpu_hmm.h}  |  8 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
>   9 files changed, 33 insertions(+), 31 deletions(-)
>   rename drivers/gpu/drm/amd/amdgpu/{amdgpu_mn.c => amdgpu_hmm.c} (86%)
>   rename drivers/gpu/drm/amd/amdgpu/{amdgpu_mn.h => amdgpu_hmm.h} (87%)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6ad39cf71bdd..712075a491f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -250,7 +250,7 @@ endif
>   amdgpu-$(CONFIG_COMPAT) += amdgpu_ioc32.o
>   amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
>   amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
> -amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_mn.o
> +amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
>   
>   include $(FULL_AMD_PATH)/pm/Makefile
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9999c18e7d8e..06234cf13d14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -82,7 +82,6 @@
>   #include "amdgpu_vce.h"
>   #include "amdgpu_vcn.h"
>   #include "amdgpu_jpeg.h"
> -#include "amdgpu_mn.h"
>   #include "amdgpu_gmc.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_sdma.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 83659e6419a8..48250a961582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_object.h"
>   #include "amdgpu_gem.h"
>   #include "amdgpu_vm.h"
> +#include "amdgpu_hmm.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_dma_buf.h"
>   #include <uapi/linux/kfd_ioctl.h>
> @@ -951,7 +952,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   		goto out;
>   	}
>   
> -	ret = amdgpu_mn_register(bo, user_addr);
> +	ret = amdgpu_hmm_register(bo, user_addr);
>   	if (ret) {
>   		pr_err("%s: Failed to register MMU notifier: %d\n",
>   		       __func__, ret);
> @@ -991,7 +992,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   unregister_out:
>   	if (ret)
> -		amdgpu_mn_unregister(bo);
> +		amdgpu_hmm_unregister(bo);
>   out:
>   	mutex_unlock(&process_info->lock);
>   	return ret;
> @@ -1775,7 +1776,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	mutex_unlock(&process_info->lock);
>   
>   	/* No more MMU notifiers */
> -	amdgpu_mn_unregister(mem->bo);
> +	amdgpu_hmm_unregister(mem->bo);
>   
>   	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
>   	if (unlikely(ret))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 91571b1324f2..a0780a4e3e61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -38,6 +38,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_display.h"
>   #include "amdgpu_dma_buf.h"
> +#include "amdgpu_hmm.h"
>   #include "amdgpu_xgmi.h"
>   
>   static const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
> @@ -87,7 +88,7 @@ static void amdgpu_gem_object_free(struct drm_gem_object *gobj)
>   	struct amdgpu_bo *robj = gem_to_amdgpu_bo(gobj);
>   
>   	if (robj) {
> -		amdgpu_mn_unregister(robj);
> +		amdgpu_hmm_unregister(robj);
>   		amdgpu_bo_unref(&robj);
>   	}
>   }
> @@ -414,7 +415,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   	if (r)
>   		goto release_object;
>   
> -	r = amdgpu_mn_register(bo, args->addr);
> +	r = amdgpu_hmm_register(bo, args->addr);
>   	if (r)
>   		goto release_object;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> similarity index 86%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index b86c0b8252a5..a68072f766c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -49,9 +49,10 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_hmm.h"
>   
>   /**
> - * amdgpu_mn_invalidate_gfx - callback to notify about mm change
> + * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
>    *
>    * @mni: the range (mm) is about to update
>    * @range: details on the invalidation
> @@ -60,9 +61,9 @@
>    * Block for operations on BOs to finish and mark pages as accessed and
>    * potentially dirty.
>    */
> -static bool amdgpu_mn_invalidate_gfx(struct mmu_interval_notifier *mni,
> -				     const struct mmu_notifier_range *range,
> -				     unsigned long cur_seq)
> +static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
> +				      const struct mmu_notifier_range *range,
> +				      unsigned long cur_seq)
>   {
>   	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -83,12 +84,12 @@ static bool amdgpu_mn_invalidate_gfx(struct mmu_interval_notifier *mni,
>   	return true;
>   }
>   
> -static const struct mmu_interval_notifier_ops amdgpu_mn_gfx_ops = {
> -	.invalidate = amdgpu_mn_invalidate_gfx,
> +static const struct mmu_interval_notifier_ops amdgpu_hmm_gfx_ops = {
> +	.invalidate = amdgpu_hmm_invalidate_gfx,
>   };
>   
>   /**
> - * amdgpu_mn_invalidate_hsa - callback to notify about mm change
> + * amdgpu_hmm_invalidate_hsa - callback to notify about mm change
>    *
>    * @mni: the range (mm) is about to update
>    * @range: details on the invalidation
> @@ -97,9 +98,9 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_gfx_ops = {
>    * We temporarily evict the BO attached to this range. This necessitates
>    * evicting all user-mode queues of the process.
>    */
> -static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
> -				     const struct mmu_notifier_range *range,
> -				     unsigned long cur_seq)
> +static bool amdgpu_hmm_invalidate_hsa(struct mmu_interval_notifier *mni,
> +				      const struct mmu_notifier_range *range,
> +				      unsigned long cur_seq)
>   {
>   	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -117,12 +118,12 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
>   	return true;
>   }
>   
> -static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
> -	.invalidate = amdgpu_mn_invalidate_hsa,
> +static const struct mmu_interval_notifier_ops amdgpu_hmm_hsa_ops = {
> +	.invalidate = amdgpu_hmm_invalidate_hsa,
>   };
>   
>   /**
> - * amdgpu_mn_register - register a BO for notifier updates
> + * amdgpu_hmm_register - register a BO for notifier updates
>    *
>    * @bo: amdgpu buffer object
>    * @addr: userptr addr we should monitor
> @@ -130,25 +131,25 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
>    * Registers a mmu_notifier for the given BO at the specified address.
>    * Returns 0 on success, -ERRNO if anything goes wrong.
>    */
> -int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
> +int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>   {
>   	if (bo->kfd_bo)
>   		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
>   						    addr, amdgpu_bo_size(bo),
> -						    &amdgpu_mn_hsa_ops);
> +						    &amdgpu_hmm_hsa_ops);
>   	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
>   					    amdgpu_bo_size(bo),
> -					    &amdgpu_mn_gfx_ops);
> +					    &amdgpu_hmm_gfx_ops);
>   }
>   
>   /**
> - * amdgpu_mn_unregister - unregister a BO for notifier updates
> + * amdgpu_hmm_unregister - unregister a BO for notifier updates
>    *
>    * @bo: amdgpu buffer object
>    *
>    * Remove any registration of mmu notifier updates from the buffer object.
>    */
> -void amdgpu_mn_unregister(struct amdgpu_bo *bo)
> +void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>   {
>   	if (!bo->notifier.mm)
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> similarity index 87%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index 14a3c1864085..4e596a16d288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -38,16 +38,16 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>   
>   #if defined(CONFIG_HMM_MIRROR)
> -int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
> -void amdgpu_mn_unregister(struct amdgpu_bo *bo);
> +int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
> +void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
>   #else
> -static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
> +static inline int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>   {
>   	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
>   		      "add CONFIG_ZONE_DEVICE=y in config file to fix this\n");
>   	return -ENODEV;
>   }
> -static inline void amdgpu_mn_unregister(struct amdgpu_bo *bo) {}
> +static inline void amdgpu_hmm_unregister(struct amdgpu_bo *bo) {}
>   #endif
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a56d28bd23be..0668b09d7394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -58,6 +58,7 @@
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_sdma.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_hmm.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "amdgpu_res_cursor.h"
>   #include "bif/bif_4_1_d.h"
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index a5095b3a0235..018fa4c61b85 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -28,7 +28,6 @@
>   #include "amdgpu_sync.h"
>   #include "amdgpu_object.h"
>   #include "amdgpu_vm.h"
> -#include "amdgpu_mn.h"
>   #include "amdgpu_res_cursor.h"
>   #include "kfd_priv.h"
>   #include "kfd_svm.h"
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 39fbe19b978a..d069e6c096b6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -26,7 +26,7 @@
>   #include "amdgpu_sync.h"
>   #include "amdgpu_object.h"
>   #include "amdgpu_vm.h"
> -#include "amdgpu_mn.h"
> +#include "amdgpu_hmm.h"
>   #include "amdgpu.h"
>   #include "amdgpu_xgmi.h"
>   #include "kfd_priv.h"
