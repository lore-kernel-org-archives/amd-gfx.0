Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D10C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C0010E1D3;
	Tue,  7 Feb 2023 07:09:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B83010E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTaSRRuC0tNslNjtI7itDCAT4NIQHmsL51bJadIjSVBYsxZbjWHAXHyBDSYJuKLhGcuKhJpZKKK5/aP77tQxMjJWUSPD4c4m++t5wHyp+S8c0e763HxLyH2GlvHtMXhmT8iRaOY91kiHgdU9R/cRx9kt0GcIkuRkIkp22N1YtQPjhq9NkZ9jZn9VB2liC78pZNFc0r1WiycHIDFdnr1lk0GmRMTJHHkariE8xPUaapQJBnhx8wFl6LY+QeXLnwfkyIxjjdkOfsiBBfd2rB4UYKnVL75B7ALCESkjTHGlnmuf5O4mwwX8EAq+ZyrO+jmUyJDbewM62KkKB0q9JmKpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U3UWwIqkhSmGsBfbCsYZtai7JZPo59qTbyk60mepBQ=;
 b=igY4G+kYDqVo1v7iso4qZh+bQVttc/r/eP7tig+1ct1VzSR3o95OmoWuWs7BBguIU5FrDYM+fku4cpKP4QjJVcqqkH0VVTqLFbWEAqf672l1wIfbJUe+PRU0tK6gXmspg4z+siVc72VU2czq+/DV9pDzY3cY5qYxLPud7+HTJajegcmWh2roOetDBsyEv0dgzFeGvcdWYdundQAt6+o3YmIh4z76esXDYKUDh2NjHc0M49mlashNQZ1DbN5chWza9/ThwwJMzuCNJbi8l05RqbGesQZlGmU0DOpA4efPXfRgZ3GYHu4ZpExxpzt0d8Oo40cAs77dHyB/u9P3A4WK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U3UWwIqkhSmGsBfbCsYZtai7JZPo59qTbyk60mepBQ=;
 b=p9sjuDqesdHxMQSZBRn/Nis+pOiiSPgz1oVst+1eyGNGrx7z6rn3fMrVriSmhGsZMaG3IcPKOpjEgBO+ivk/HSYzIdxS9omwL/HoJ3QNYHX1BYWNQZL3/C4Gx50E77h35+PezYLCoPL7eZ+8Yy4eomCM6Eicr2WEKU1v037Z9ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 07:08:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 07:08:58 +0000
Message-ID: <ecb47e10-43db-af4e-ae3b-c0321dcd8e2a@amd.com>
Date: Tue, 7 Feb 2023 08:08:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/8] drm/amdgpu: add usermode queues
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230203215409.2021-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: a62cb3f2-29a4-4d75-8cdd-08db08da2ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAf/rQLU5Z+Qcqxgq653ylOQHhXRtL1cdN+CF6DJ27gnTcX1OKED0VD5Ve648dS/5JzNC0GLtlVoMLW5Rdu4XfiQ3tCbbP68YE/qyTQVDuKiMjkFKkb3oxO3q5x3K2pwpNi7sc0GWXHoutMOSZDHJ5NRaDr4LoOxYCY66lYTTi2NSwcF8YFa4O3IbA+lH1yjv8NIwL2n0x47Ff1csBRqXnNZjvPrIXgxSaAJtniUHKu/SOzVP+xwChtQSFwHqkynp9DvGh7md7Jgji8rgZfCL2oYqFW96Luml3KloEpGX916guCirjBtPtJ1cwXyucCGYIErypcsLz4F3uya+1+8KPf3ZrRwLLtFDAjbSkbjvCm+jj8pyYGYk2uQpDYUYwjgjvzzqa/s28Lo+f2pVtXUhCeCh7ge/6jWfcz9o8evsTzHsSoU7PEBWPc2ulqFjB/Vao4syBV6l5QX/l0A3KHZaTwkIDgft9w7o/5jMiUvTdK5tUBS5dVnO7fYzPHKuRtvjpa/ewJFb2xwSL3xEZugA9tpH0aXdbUhkiXVUa30LD97EYBiCwt6194G0BLscw9S8fToHHshHt9EhpThLtP9mJ6nIQcnaHzQXrr+okaxW9pcGDmhGPpwDQwQde1sJeJtu5BuW4XByXwSLUDi5MJtbVARMJfgM5TSfS/YxLEwwYTjQ953N68y7iafgTxBF93O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199018)(66899018)(2906002)(83380400001)(38100700002)(41300700001)(66476007)(66556008)(8936002)(4326008)(8676002)(66946007)(30864003)(6506007)(6512007)(26005)(6666004)(186003)(316002)(478600001)(36756003)(6486002)(86362001)(2616005)(5660300002)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRqeklvT2lkc0Vid25NL0w3NjJLU3Awa2hOVld5aDZqSkY1a3BBU3JKMHZa?=
 =?utf-8?B?aVZybkowZGErU1JrUXdRUjNDL1ljOUJIV0JrRGUrdndlR2plemRMczNUYmVW?=
 =?utf-8?B?QnN1VEQ3OVFob3U1UHdaaVlxQkxUU1R1a052cUhaZ0U2R2daWEJHc1hDbEJT?=
 =?utf-8?B?dStoaDkxQUsyWm1zT3V1bmNvT20rWVFZN0hFUERtd2JXVnJkWVQ0MTh0Qm1l?=
 =?utf-8?B?czh1NmhkMFZISXJCMWU2Q1VDRjZSS0pHWVRZSWs2bUFWcThNQTZET0lVbHhi?=
 =?utf-8?B?NHFMbE9xdjFDMlRtNFJZdlo2bzhKa2dFbjJYK24wMEUrYzZkT3ltL01jZmFH?=
 =?utf-8?B?M3hKenY2SzVRdkE3NDZVK1VRQXNQaVhVbFN5WGFNU1RwaENrWXlYSGZXTkVH?=
 =?utf-8?B?ekdLZGp3TlBsbW9BaFM1aE53eXlnSkpnVktKWGFNdjZDWk9QODRvTXNZZXVC?=
 =?utf-8?B?dWdxZWdOOFovcndyRGFIS25qdlFCOG9jN1hsUmFUZW1OUEJPckVoOFhzZDFF?=
 =?utf-8?B?Ni9VSHRWajE1TFJvcHpLd04vSjY3WDUyZ3VpZWV2MHkvUVE1MFA4cnYvWk5R?=
 =?utf-8?B?OG9BOGVTRG0zTERSUHh3R25BVFR0V3dnVHE5UktJUDYzbWJsYjJuY3lLbDFF?=
 =?utf-8?B?SmNEN1pvb25KSGdndUVQSXEzRUdaRC9vL1dBUzhNM3NoQ1dJdmNVc0M4bEFS?=
 =?utf-8?B?YzBGYkNyMVR0MTBud0g1eXlQUXB2MFZNQ25CTEh2U0F2MHp6ZTAvaG5VSnJF?=
 =?utf-8?B?d0hlaTdZNlBKL3duNzZ1alRlbE5aNjZpSUF1N0J4NjQ2MmVINUNyVHFyUE1s?=
 =?utf-8?B?ajVCTWs5dytQY3RsZHRDYWZLMEZLMDJod0s0TFNGWStwQkhNSytOOHdEb1No?=
 =?utf-8?B?dk5CYUNhNHZaUFFBY0UvSkNQMzFXczlibjhNTVpyWnJpZW1yS1dTMm0yRTJL?=
 =?utf-8?B?YmhxRFRxUWZ6RGo1ckFubmJpV21PUUF5NUwvWG9tbm9pcWhQTktVUy9WT3ht?=
 =?utf-8?B?KytOUGNLUFJYNHp5c3lYcWtjOWk3cDBpMTZ5UlJIUk9PaWVJeW90bUNIRE5a?=
 =?utf-8?B?WUhBSG9CU0VxQjUyT0l2dWh5SEUrL3dFYTZqN1d4VFdsMmVDbnhsT1VHTWRZ?=
 =?utf-8?B?eVdlTG9zSTRmUllTN1FZRmlrVnZqUlY2QXh5R2Q0cDErZXRRY04xaXkwNVl2?=
 =?utf-8?B?ZW9CR1grTXNHSmNtSU9raFVpdmRrbGdrcWdPdDJhakVlaktyUkNuZDFXcTQx?=
 =?utf-8?B?cjdvRmlrSzNjVGM1WVZmdlVrZmlCRWhXdTYzOHhiTU5qcnlralVqQXlaYTM2?=
 =?utf-8?B?TVhsVFVhOHJVSkwyRGhPWHd1aUhUcFc5Z0UrYys1Yk85ZzNBWFh4ckYwQU5F?=
 =?utf-8?B?N2pidzZOZ0MrRjJ3Q2s1bUgzYU45ek1BWDdSS1ROT2phcG5lNmxlMzZRZW9r?=
 =?utf-8?B?UU04dXdWaTJZRG5QbDZJcUYxd2JsN1NreHcxUzFyeHBoV3pBMXlvSDJ4dTdK?=
 =?utf-8?B?d1BMenJUYmtsMk5rY0lScWpWdmhpOWF5N1FJRVR4K2o2VHliR1d4U0Nza0tu?=
 =?utf-8?B?UE0vemg0MUdVVXRvbnRwMzVrT2JVOWNkbVNQQVBvUmdRZVgvZUttcU1SRHVM?=
 =?utf-8?B?UjJzZ1NZS0NvamdwSkFSTy9Yc254cjEyR1VVSWJWeUVNUXNCemZ6Wk4xU0xI?=
 =?utf-8?B?d1ZzclNGYjFpSnlJeURCVmNLcFZjZ0hJQmxLc2hPNTc4ZTNxdnpXelBvNXFh?=
 =?utf-8?B?R3R0bmI3clFEQmlDNEcxSGJ0d29PMG9xVHJ4Mms5U3l5aW1BbnREeDdkUE5R?=
 =?utf-8?B?MUMzMFpsWlA0UG1LU0Z4bUFxUUY3ZEx4QWI3UWppRENXVkVHdkZmbHpjelVp?=
 =?utf-8?B?cXJvQzAyRFVNenhRdEttcElDVkVWM2Nxc3RZVTB3OEp4ZXRxYXIzQlNFM2pJ?=
 =?utf-8?B?am03dk5jSVNWZlVhM3lNdCszQ0pnVy9aY3EzOXQ2U0J1VUNFalBkN1M2bGIy?=
 =?utf-8?B?NFJqRkNHNDBsNE9SdHJsY1FudVZmcy9OY25mT3k4VGxWMDdxSE5IUzBGcFBK?=
 =?utf-8?B?cVduVnVEeXBrK2NPa09Wa3d5S1BCaDBZVHRQSm5yR1VIbVRQRzlHVGVhazFq?=
 =?utf-8?Q?PvmQsXyrfWB3GJMMNHOVod9Pp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62cb3f2-29a4-4d75-8cdd-08db08da2ea0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:08:58.3567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfzmYi2WUgMtVeOCaT9lENfhmsTYLPXy0zB/dpIuB5d9HX3IzZLjHbz+IvrsBq4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.02.23 um 22:54 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds skeleton code for usermode queue creation. It
> typically contains:
> - A new structure to keep all the user queue data in one place.
> - An IOCTL function to create/free a usermode queue.
> - A function to generate unique index for the queue.
> - A queue context manager in driver private data.
>
> V1: Worked on design review comments from RFC patch series:
> (https://patchwork.freedesktop.org/series/112214/)
>
> - Alex: Keep a list of queues, instead of single queue per process.
> - Christian: Use the queue manager instead of global ptrs,
>             Don't keep the queue structure in amdgpu_ctx
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 155 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  64 ++++++++
>   6 files changed, 230 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 798d0e9a60b7..764801cc8203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -210,6 +210,8 @@ amdgpu-y += \
>   # add amdkfd interfaces
>   amdgpu-y += amdgpu_amdkfd.o
>   
> +# add usermode queue
> +amdgpu-y += amdgpu_userqueue.o
>   
>   ifneq ($(CONFIG_HSA_AMD),)
>   AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6b74df446694..0625d6bdadf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -109,6 +109,7 @@
>   #include "amdgpu_fdinfo.h"
>   #include "amdgpu_mca.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>   
>   #define MAX_GPU_INSTANCE		16
>   
> @@ -482,6 +483,7 @@ struct amdgpu_fpriv {
>   	struct mutex		bo_list_lock;
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
> +	struct amdgpu_userq_mgr	userq_mgr;
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b4f2d61ea0d5..229976a2d0e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,6 +52,7 @@
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_userqueue.h"
>   
>   /*
>    * KMS wrapper.
> @@ -2748,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 7aa7e52ca784..52e61e339a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1187,6 +1187,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>   
> +	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +	if (r)
> +		DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
> +
>   	file_priv->driver_priv = fpriv;
>   	goto out_suspend;
>   
> @@ -1254,6 +1258,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
> +	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>   
>   	if (pasid)
>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..d5bc7fe81750
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +#include "amdgpu_vm.h"
> +
> +static inline int
> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
> +}
> +
> +static inline void
> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
> +{
> +    idr_remove(&uq_mgr->userq_idr, queue_id);
> +}
> +
> +static struct amdgpu_usermode_queue
> +*amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)

Please put the * on the previous line, it took me a moment to realize 
that you not return the queue by value here.

> +{
> +    return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +    int r, pasid;
> +    struct amdgpu_usermode_queue *queue;
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_vm *vm = &fpriv->vm;
> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;

We usually put variables like i and r last. The PCI maintainers even 
require that you sort the variables in reverse xmas tree.

> +
> +    pasid = vm->pasid;
> +    if (vm->pasid < 0) {
> +        DRM_WARN("No PASID info found\n");
> +        pasid = 0;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +
> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +    if (!queue) {
> +        DRM_ERROR("Failed to allocate memory for queue\n");
> +        mutex_unlock(&uq_mgr->userq_mutex);
> +        return -ENOMEM;
> +    }
> +
> +    queue->vm = vm;
> +    queue->pasid = pasid;
> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
> +    queue->queue_size = mqd_in->queue_size;
> +    queue->queue_type = mqd_in->ip_type;
> +    queue->queue_gpu_addr = mqd_in->queue_va;
> +    queue->flags = mqd_in->flags;
> +    queue->use_doorbell = true;
> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
> +    if (queue->queue_id < 0) {
> +        DRM_ERROR("Failed to allocate a queue id\n");
> +        r = queue->queue_id;
> +        goto free_queue;
> +    }
> +
> +    list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
> +    args->out.q_id = queue->queue_id;
> +    args->out.flags = 0;
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    return 0;
> +
> +free_queue:
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +    return r;
> +}
> +
> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +    struct amdgpu_usermode_queue *queue;
> +
> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
> +    if (!queue) {
> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +        return;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +    list_del(&queue->userq_node);
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +		       struct drm_file *filp)
> +{
> +    union drm_amdgpu_userq *args = data;
> +    int r = 0;
> +
> +    switch (args->in.op) {
> +    case AMDGPU_USERQ_OP_CREATE:
> +        r = amdgpu_userqueue_create(filp, args);
> +        if (r)
> +            DRM_ERROR("Failed to create usermode queue\n");
> +        break;
> +
> +    case AMDGPU_USERQ_OP_FREE:
> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +        break;
> +
> +    default:
> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
> +        return -EINVAL;
> +    }
> +
> +    return r;
> +}
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
> +{
> +    mutex_init(&userq_mgr->userq_mutex);
> +    idr_init_base(&userq_mgr->userq_idr, 1);
> +    INIT_LIST_HEAD(&userq_mgr->userq_list);

Why do you need an extra list when you already have the idr?

Apart from those nit picks looks good to me.

Christian.

> +    userq_mgr->adev = adev;
> +
> +    return 0;
> +}
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +    idr_destroy(&userq_mgr->userq_idr);
> +    mutex_destroy(&userq_mgr->userq_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> new file mode 100644
> index 000000000000..9557588fe34f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
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
> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_userq_mgr {
> +	struct idr userq_idr;
> +	struct mutex userq_mutex;
> +	struct list_head userq_list;
> +	struct amdgpu_device *adev;
> +};
> +
> +struct amdgpu_usermode_queue {
> +	int		queue_id;
> +	int		queue_type;
> +	int		queue_size;
> +	int		pasid;
> +	int		doorbell_index;
> +	int 		use_doorbell;
> +
> +	uint64_t	wptr_gpu_addr;
> +	uint64_t	rptr_gpu_addr;
> +	uint64_t	queue_gpu_addr;
> +	uint64_t	flags;
> +
> +	uint64_t	mqd_gpu_addr;
> +	void 		*mqd_cpu_ptr;
> +
> +	struct amdgpu_bo	*mqd_obj;
> +	struct amdgpu_vm    	*vm;
> +	struct amdgpu_userq_mgr *userq_mgr;
> +	struct list_head 	userq_node;
> +};
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif

