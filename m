Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6595EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7403D10E3F1;
	Thu,  6 Jul 2023 12:47:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3938210E3F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZw9v4uxmJc3j1S6MZ07l3cYVNlc+gRGCxEZzPsXUSXKn9SMuJAJIuALAqWbhs6TtDsXl9Se/F21OgQCCcws09U4mAPLeyt/FxhdjkDM4BTMFsUwq08F/3l/8PFrYf7IffnAwCElyJJ2fizWk4xNc6W6p7B+X6RVukKOE8CkDeiPlKTKfrc1LzqaeWvpzv6lh5l/kUK4tarN2RJd6t9SYUvcATOUG/66i9QQ1b91OoXy/taFOxAR5sudIDO6Fk1OFdM2ZfXBv9XOsAFLxiDsUrwvieM0qzNiH5a7N97z+snQl4ri3u8Q4HLRTOpOUH3rdZVzv55v7KPCnqHIdxvaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1fIzbR2zgEBMz6utDnocuFyGmuS0CVuHr7vZ7x5zHo=;
 b=KRjCYWAmAUcStLHcd69o0wJBiWOwpUSR6KXBqllZYlHjip0txz3qrW70uEMsGtOZdZUD/X0rvpirVwGNH017EaCn1D1kT2UvGqtjQ6ii8BC+jTxTjekBK3I+vhJjMn0AMuPAFo1pnemlFI/sf/ExEIgtcmFbvMlhlx82MT90PcBRlN8F0zaoDAg+pAoy2u/kHBu8dMvosnBrnhmlVn7oSXaRls0JYsUNsFkolw+dZy/0XPKnJbuDz1A14BVlMEad+O4zP3R/YlKhT782J5UJ6Fvg63F37e8S8qQobm3ftJsChgCbVTv+4kYISOxyqRvsybS+i4mcCM8FCvpbNEcofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1fIzbR2zgEBMz6utDnocuFyGmuS0CVuHr7vZ7x5zHo=;
 b=bu9TuUV3ufOT0t1f+ZyeXh8pqF0X1+liJktYOdTyxM8Mub4DKIrbewHiQNXBdVORIYKJolvks5ry1tn/h7NTb1x763vPrEi9sV1jxfpsxSEGQvD1Lx5eDaeq2J9dbQEIsaUV5+LEurCI27k3Jzoj+kyBHKp2M46jyfe6dh0iqUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:46:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:46:57 +0000
Message-ID: <f058a6b5-0f46-9fa5-ed87-82e33336a550@amd.com>
Date: Thu, 6 Jul 2023 14:46:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 02/10] drm/amdgpu: add usermode queue base code
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: d56065f5-0fb4-41e7-5840-08db7e1f1530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIINYtz7zCyM3EHsz6bjDPhXEojL1+siBsPqE9f8O1rzMetFkb1WvM/f3eaFg0bkPmBo+ZZw4CVJrp+7By6dkN6jXzLI2HLp8ptpXJrkuBY8f2RbfcwEozo/dljm8k/u59OQeiUEzteiOuzrG4b/fhFwQt+gfLm6xXcGuZxiRH8duEPc35x67AN8GouYrBiE8F2nEkxyxnfvz/MPFkzvACOPYf6CZI0ZrGcPHd9qKpOgd9Vy3ZKY16j1lDbumyWRZ2JmyDV6Wy1a+c31Z33m7CB0UkeY/O5l0tLhhLbIbKR+YKOd9XZ3iLWOKgYYJSqjfevs6XAuA+qkRv4Dvxq8g2nRu+bwkDzmdDAj1796oniSoWSEOfXceUQ9fS4/GAQNqr9rQJJeKi/sLpMW8dzfhfZFpS1SJRQUkpb5bfCrGbhhmnHysCbNOHIU+PQnyleeHorhS05FeNfwxsxOKIz419VHG9rHUaBrRNZFToNuP2rvecxeF7XyubhwSDchmvGQaugschjyN5qFECT967sLVDAJVQ4G/jOS/K6ePHtC0YI7t0hoDghJrek8hnF0Z+wJYV+DyU3rEb3VFn48lMI9VN6EAn6FQd2OxR8CACdzSoYNA9OEPN2gP3p9O9rslYHY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(478600001)(5660300002)(8936002)(8676002)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008)(2906002)(6486002)(6666004)(6512007)(2616005)(66899021)(6506007)(186003)(31686004)(83380400001)(66574015)(36756003)(31696002)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxMN2ZhSjN1TkRaSTA1M3VhcGhtMjJuc3lhcWt0RGR1WkM5NnIzVjlhOHBi?=
 =?utf-8?B?bFJGbERUMENSWTJpa2JjVFBEM2Q3Y2VvNDN4LzdqMVpYSDhBMDBvaEQvbEJi?=
 =?utf-8?B?T3B1YURjcUdGTE5sNlpiYjVNU01aRHRIK2lWVVZDckhiTVA3dW9BOE1lRjIv?=
 =?utf-8?B?RHBMR0NBVVFpSzZmNnJ6a2FNWTRuWG9CWjZBWTU4bWhTT2hhN3RDUTFuNG05?=
 =?utf-8?B?R2FyYkNVNGJ5MXpVS1FvTmtURzVWWW9yME9YN0J6N214NXVWbHBmTTE3Nnh4?=
 =?utf-8?B?aWZzMzVFWm5vUmxNcjRYZEk2M1d1dEhkaE16eVNIUElXZlRiSnlseUJBY2Y5?=
 =?utf-8?B?S2FMZ1MzVFZmd0FTL2RxblhrN3pDR0FUTzM1OXJLeU1VWVI2UWxrNUVGU1hR?=
 =?utf-8?B?V0V2Z2E4UjQ1a2V6V0t2NWtUMkttaWdVWDhTWUVkNENUNzBCSTNDWDVXSXlW?=
 =?utf-8?B?WkVUMjhjdTNXNmVWa1hxRVFVVTBSN29pL1Q0T3BXWXd2ZE00WDNoUy9OaGdM?=
 =?utf-8?B?YXF0UTJHZnZiQytYMm0reHlmOTV2bkJrWkJtd2pzYVc4Y2xPQlBydDl5aVp0?=
 =?utf-8?B?aXFtM0pMbkUxM1RLZGtmTlFoQUc1S0x3QjhMNjlvQkR6TnY4MDFCZ3pTMDA3?=
 =?utf-8?B?OFhpMUtacVNCVGJzZDJIWTRKWWVZS3BROGhvM3JTQzFJWEwzNURTZHVQczg3?=
 =?utf-8?B?RHZydTZ4Sk8wZTVQVGFyR2VYdysvcUJ3ZUtYVXoyVkxFbGlxSFlDS1pZU0VP?=
 =?utf-8?B?aStNWGJmTy9jV05QcCtiS05WcENIbjkyUGwzdG03NU9td2g5aXp5OFJ0bWxW?=
 =?utf-8?B?b2F0cmEwbmNJelJKY3hrTW16MXpTaHNnWFk2UzRRem9BdjR0N0lwak13ZFA1?=
 =?utf-8?B?SnRXMCswYzZ6Q3dLQ3RDbUpyOHdiRWNxTDlZV1Bwc2ExZzVieXZYcUllWjZ6?=
 =?utf-8?B?b1pQdlE2Z0tGWE9WeUNlMUNFcm9VRUlrMTlVVEVScVhXdlJlS0VsQ29OTEc1?=
 =?utf-8?B?NEtLYVFvOE5OclFkZW8rbEpLV1MrTHlSL3Jzc3N6cWJrVmFhWDhScHVJc3ln?=
 =?utf-8?B?eGsyampzUWxyc1NQQmZpaUtkWTZaZVhESVc5cmhyUWIyK3BLMGQwTnRreVJq?=
 =?utf-8?B?ZmU1WXhoRzlqUHRRaVcyRWdoTXFIcnZldTNXZit3U0Z4ZEE1dWE4Y2ZOb3B3?=
 =?utf-8?B?Q3hjd2VvZWJHWC8xM3Z5Mm1ubmZTenR1bmFKMWtWWnFYajlsQ0VRb2JSMXNQ?=
 =?utf-8?B?dGJrd3IvdnZDU01rOStqdjVya0U0U0Q4a1dkcHpOMllmNlJ4eFpXRmNjck1X?=
 =?utf-8?B?enk2WTdaeCtIQkpBQVNLV3JEcUpmbUVJOXowOUdtNU1uT0Znd1I0emljbCtz?=
 =?utf-8?B?NzRUVk1icTM0KzhVV0NPSVFxT0dpb21kQlMxaHZHZ1l2cXdoNGNvSHdyNHc5?=
 =?utf-8?B?eW5rZHk2dXM4V2NpRHg1d3FFd2FlQXFxWmNOQUR4eittTzRsenV0d2JKRlVk?=
 =?utf-8?B?WHRJM0xzTjFYQ2lKamhHeGJVYllBNFBZRkZkVkNkalhxQ3U1ODVkekdKQnQ2?=
 =?utf-8?B?RDJBRkpIZzVTUzV2dzJOSDBHQm96M2JneFRQU2ZrODF6UkswRmQwdHE1Smtv?=
 =?utf-8?B?QnZXTjM2UDdrZjJLYVAvK253VXJmcTRDWFgxdW5XbXBlMkJEc1pCTVhLWVd6?=
 =?utf-8?B?TEpEMVRSbXloUnZWSklKdzJOaCtQWkNlZEQzNjhxdzRXYmNPTGV2RndtWjM1?=
 =?utf-8?B?Q0YzK2l2Tm5taldhL0N3STYyNGp3dGtuNnhVRWhBNWpic2xkUDJpT3dYK29k?=
 =?utf-8?B?N1ZvcGNSYXVBT2JNb2xPZXhpMUhpVVpMWWdKcWQ5bmdiRkNUcStBTXdYblpq?=
 =?utf-8?B?eUJJZnlvUTdkT3RCQXRBVm04TGZQbmQzRk5WVU02NVRzVGhRanpUZTFxckhM?=
 =?utf-8?B?eGE1RUVwZjIxNGdiWUplbGJLVWpOekcwMVh4U3R5am5HaWxOczhTREJScXFm?=
 =?utf-8?B?T0Fwb0gxUnJ2c3Jud0psZStvVzJNczl4bjl1aTE2TGVGdEJmWFQwNEh5Z1dj?=
 =?utf-8?B?Sm1DcEE5NnNIajIyNUppWXdHZUNONEhvdDh5SjFpY0wzUHZJK0lvZU1KM2ZJ?=
 =?utf-8?B?NXhxajNHa29qbUFFWEx2YlNKZnpJK3JGMFY3NkZQUXRJOTBRbFUreEpIU1hY?=
 =?utf-8?Q?cECeTsA32BlZ9mxJ3Vzgp+4MlzTZczikRkAAK5cbmyO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56065f5-0fb4-41e7-5840-08db7e1f1530
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:46:56.9507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IX58GBr8DzMDiqBUeOC9DQfkcdnJe63hXq0ktcQohSyVsEYTNc69KWUq+MOCsmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.23 um 14:35 schrieb Shashank Sharma:
> This patch adds skeleton code for amdgpu usermode queue.
> It contains:
> - A new files with init functions of usermode queues.
> - A queue context manager in driver private data.
>
> V1: Worked on design review comments from RFC patch series:
> (https://patchwork.freedesktop.org/series/112214/)
> - Alex: Keep a list of queues, instead of single queue per process.
> - Christian: Use the queue manager instead of global ptrs,
>             Don't keep the queue structure in amdgpu_ctx
>
> V2:
>   - Reformatted code, split the big patch into two
>
> V3:
> - Integration with doorbell manager
>
> V4:
> - Align the structure member names to the largest member's column
>    (Luben)
> - Added SPDX license (Luben)
>
> V5:
> - Do not add amdgpu.h in amdgpu_userqueue.h (Christian).
> - Move struct amdgpu_userq_mgr into amdgpu_userqueue.h (Christian).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 ++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 62 +++++++++++++++++++
>   6 files changed, 113 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 415a7fa395c4..4b9bae995094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -216,6 +216,8 @@ amdgpu-y += \
>   # add amdkfd interfaces
>   amdgpu-y += amdgpu_amdkfd.o
>   
> +# add usermode queue
> +amdgpu-y += amdgpu_userqueue.o
>   
>   ifneq ($(CONFIG_HSA_AMD),)
>   AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 02b827785e39..fab842138cd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -107,6 +107,7 @@
>   #include "amdgpu_fdinfo.h"
>   #include "amdgpu_mca.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>   
>   #define MAX_GPU_INSTANCE		16
>   
> @@ -463,6 +464,7 @@ struct amdgpu_fpriv {
>   	struct mutex		bo_list_lock;
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
> +	struct amdgpu_userq_mgr	userq_mgr;
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b1ca1ab6d6ad..4c5e44d41652 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -50,6 +50,7 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_userqueue.h"
>   
>   /*
>    * KMS wrapper.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0efb38539d70..68e5375b648b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -44,6 +44,7 @@
>   #include "amdgpu_display.h"
>   #include "amdgpu_ras.h"
>   #include "amd_pcie.h"
> +#include "amdgpu_userqueue.h"
>   
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>   {
> @@ -1234,6 +1235,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>   
> +	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +	if (r)
> +		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
> +
>   	file_priv->driver_priv = fpriv;
>   	goto out_suspend;
>   
> @@ -1301,6 +1306,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
> +	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>   
>   	if (pasid)
>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..effc0c7c02cf
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
> +{
> +	mutex_init(&userq_mgr->userq_mutex);
> +	idr_init_base(&userq_mgr->userq_idr, 1);
> +	userq_mgr->adev = adev;
> +
> +	return 0;
> +}
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +	idr_destroy(&userq_mgr->userq_idr);
> +	mutex_destroy(&userq_mgr->userq_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> new file mode 100644
> index 000000000000..79ffa131a514
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_USERQUEUE_H_
> +#define AMDGPU_USERQUEUE_H_
> +
> +#define AMDGPU_MAX_USERQ_COUNT 512
> +
> +struct amdgpu_mqd_prop;
> +
> +struct amdgpu_usermode_queue {
> +	int			queue_type;
> +	uint64_t		doorbell_handle;
> +	uint64_t		doorbell_index;
> +	uint64_t		flags;
> +	struct amdgpu_mqd_prop	*userq_prop;
> +	struct amdgpu_userq_mgr *userq_mgr;
> +	struct amdgpu_vm	*vm;
> +};
> +
> +struct amdgpu_userq_funcs {
> +	int (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr,
> +			  struct drm_amdgpu_userq_in *args,
> +			  struct amdgpu_usermode_queue *queue);
> +	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
> +			    struct amdgpu_usermode_queue *uq);
> +};
> +
> +/* Usermode queues for gfx */
> +struct amdgpu_userq_mgr {
> +	struct idr			userq_idr;
> +	struct mutex			userq_mutex;
> +	struct amdgpu_device		*adev;
> +	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> +};
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif

