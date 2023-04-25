Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E64C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF90210E0B6;
	Tue, 25 Apr 2023 12:03:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0587510E0B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQfI9HaIcYRAxzYQlPcpbIRCPlBcKIK+aQlFmT9zm2kXMZdG6apsbXP/8ifYXwnQmWySwZPhVkEJ2Kbst70w6BNCOYUw8qS37MYg2z3+3f0H67VDr1XIbTTX/PGjgAMnuWzsziO22Pm0HhbfRGkR+UFQr4BraaOXe53SxJfdE/Q4nelOfhmGreKzo9rbFcct97YJd8RxN33Xfoijza0/sbOXJdJuoyeMS+rrAuOaS0nFKT4gGxPg7o3yD2raQnqp9M+d8o6QJj+H5d4808Z/J5k87oKi15ZDhoch1xAeVltsgijghLNkC1hrMB62WePXQCBu1/Zd40M3rZVrNBxJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuuZ1Wa83W8MFKxuGKL++6uHwgxidqs3AZwHNLbs2jQ=;
 b=F2rN8ccXrdmgTgpA2BFIv4ljKgZ7nkUAYPxKJZ9FGmIxU+OhuXxe9DCtF82T9Nwoi88SAPXRdcaGI7wxWkcdEYOUydp6PV3FCTjUDObjw3EJZPYencqj+e19Ipube1fYi6nSI/lTBD9OyBLS7xdZ65HsKc0FqabHG6EISQoAy/95E8OzGzal3Vj9uzfEFwG/DXEk51hxGqy5YHFSK/8Z6DwJ8BIeI8HieE1ih8AAB9Uim2InyAO9yebScqNPFR27cIa8SpkBtb56zjOvWM2B26v4bs4uxaex/DhKjnnTQOmFgLtZieeUHVzQ2oo6lQBabzC+HTeUNFLqEOoubTFnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuuZ1Wa83W8MFKxuGKL++6uHwgxidqs3AZwHNLbs2jQ=;
 b=vNiS4uY7CQ6iy/mAlVk/i+y4nEUKdPHCxTgz8ko9zq851OE4tS0hyxcRklIOIb5ycz9/ljpoMGgFjvQegXE8DT1BJ3VuZCpoJsBSF2TBWCPNQ4xniSsSEdtw0Td6jzYx9dw0RVZ0IMB897KqJrBwIEsMaNgoQTWbxh0dPmaMM34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 12:03:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:03:31 +0000
Message-ID: <ca24f91d-9de9-7434-a6e2-e764f2f9ab34@amd.com>
Date: Tue, 25 Apr 2023 14:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/10] drm/amdgpu: add usermode queue base code
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: dc220cfc-2fa6-4071-30ff-08db4585165b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQif3PGcOqizfpDCxJrjbKiVRLLMSj4Ah6o/J21C6to79DufbMERuk8cZ51I34JanIyv61anq5ar9OhzxPBnkThm6HgpLjQNLZ7pkglusKKkLEG/TAoXWMSPHwB5e18OuJlI4PztsWB6gvdTIuvUFlqa0ickUHWCMoYEnGMf+Fi3AqgM+wAYX3B2KHbVJTEuQV+9Mv4LbiQ11gk68x2x0Fo3ks1edoWNQziQaXgmWoMWZF+Mir3z1E/wKVzigB+iS7FDmTnd+2+u10yoR6uUZOzRpWbnyZbDEkDHGmP4/h00csj85RUVgIolBVImFvM6WZIehGSHv7nfnpdO9+tsGjfioBTguDLeVFKNvftDhtIFYU8Bf2jSzJ9vlTrdGcA+2Zf79Gu4z4mhUQw60nr6/6NyMkY7J+6/C/YemNxjRExlLrbDeyouIHd8QRP7uEsQLv8WavY8vm1cv+r56fdNtn8sPTIlxO6fYM4s+pHw03pbBVizONaAsnadxmVp/FRCHOOlMpjs78vo4qSTqP+TLrEIRxgzjkBrQPBtqAHEldLVUdbw3ZaJN+m1HlSD+w+ln3nMhRwaAed3pvSDxievvFMiS4Nvik4l/cBDYJ2CrzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(478600001)(2616005)(83380400001)(6512007)(6506007)(66556008)(6666004)(6486002)(66946007)(186003)(31686004)(41300700001)(38100700002)(5660300002)(316002)(66899021)(4326008)(86362001)(31696002)(66476007)(2906002)(8676002)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0MwWE9KTGdVWXJQanB6UGNLT1lhRmg0NXpDM01lekhVa1JaN2JEWldtbWN5?=
 =?utf-8?B?dDhyVFZyRnFKaUNiay9rbjJEb0QwSzVRalV3SThreEtZcS9YRWZPWi9Pb0dJ?=
 =?utf-8?B?L1RYUVZXSHRxYmhKYTkvNCtjaDh2UEdSUGt3QVhsaEZieVZnOHBuVFlMdkRZ?=
 =?utf-8?B?aHZ2ai8wL1EweUY4Vnh0cStScHdYKyt5ZVFFUDZUdGNsUEFSOTkvRXVDNnY4?=
 =?utf-8?B?dWZwbHJkWm5JL1ZFMC8xZXRsUjZSQ1hBaXMzekZxVWI4dExGeTFLeS9XNGdh?=
 =?utf-8?B?RnpyQU5BK05ZUFJCOTQzdGplMFhlRHBPdHRZQnlwTVBDR3F1T1FDSmc2RHBs?=
 =?utf-8?B?bEV1SHlxNWhVMm01b2sxVkJ0K1pEZ1VRWmI2YmZqV1V2UzQ1ZlgwWEZkd3h5?=
 =?utf-8?B?MWRZK1JxMTRyS3Y5OWpMZjdlTXF4d2NvcGsvbDA5U2l4QnBkS0J3NFNRL3ZE?=
 =?utf-8?B?b3dJaEV3NjRVR1luQlN6MDlBZ3NoYnV6K3lrNC8wT21rdlBnQmNjRm1vb3g2?=
 =?utf-8?B?WWp1NzVGdHM2TlM3bnEvaGlqUjRFT1JHYUVWS2RNTTZ3d2lTQzFGdWllVU03?=
 =?utf-8?B?ZXVGRHZDNWt0aGw4VVNCbHdxdExvS2FFb0FkSWF3SHh2dWdWVm1OU3JRVHlT?=
 =?utf-8?B?NFkvdDNxMlRkUXl1c05PcjRKQWsrNUtZYXlCK0k0Z1VrSEpMSjZLeGxYTHBU?=
 =?utf-8?B?MVJ6VnAyN1F0NGZCdE1aRHlIU1FVbGVzYTdpZDNHRVpxUDU4azFKNmJpREQx?=
 =?utf-8?B?WWN4cnB4Mlh0UVovOWFYVWxKdFU4Y3Q0bThTVE9oU3pIUnJWMU5MNzV2Q2Z1?=
 =?utf-8?B?SG92OS84aElCN2pvYmJvaG10QjZJcGFnZGJERFROdG1JZ3Z5MTRWZVhEK21E?=
 =?utf-8?B?ZGxLUERXMW4wdVRKWG1vMXlWNXhmR1FKbG9ubDRGUGFPdEhyMXo2dE16L3pj?=
 =?utf-8?B?VTUvdmtBWjloeWFJeG82MmpqUlN3c2NzS2t3Z3Q5WVhteWw4NkY1YUlKZWlE?=
 =?utf-8?B?SndCR084Tmo2RUJyWW5kV1ZTalRNNDgxaVNOaUlKZ0ZYREhFa0kyb05vNGFK?=
 =?utf-8?B?NElhdkFHWWJnaWV1cS95ZzREVkQvOTZvd2lRNmtPcVFWQmdOOSt5aEkyaHV3?=
 =?utf-8?B?bDlzQ0oxZ3hPWnZiUnRPWHdzNDRuUEJYeTFyNis2STVrUURMQXRyVDZsT3I5?=
 =?utf-8?B?ZWM0QUhSNmtLS2xDYmRwZXFSWmFQZHVKcVd2ZmdCVzRZdlRiRnJjWW92eld6?=
 =?utf-8?B?TE50MC83by9FTzRxb3ZsSkNzQXhNTHJxL2VqcnRFcDBjZkdXa3BTbVU1a29K?=
 =?utf-8?B?R2xJMnlEV2lCaGVCYkVZMlN3ZFpJQUpPdktlR2xqM1AxWHk0QXpHVDNGVUNJ?=
 =?utf-8?B?clFxcllFdUtpdmsrY2d3c1dsYjlDWTJQUVk1Yk5PYWpob0g1REZOVm5IWXl1?=
 =?utf-8?B?ZjIzTG8yRW9iRWJJSm5vNDFIY2FCTFlnSUFyY3FYUVFXNENHZGpKdys1RVJD?=
 =?utf-8?B?T0RXcmxicTJTZXFHaUsxM0FyaXFQQmdFbGMyeThVUFd1aXJpenVtNHp6UVFv?=
 =?utf-8?B?OThoOW8wQzN4NXJZNEZ2N2p5T1F4akdhLzlTbTJZVHJaQXB2WXVRSitjMXM2?=
 =?utf-8?B?eWx3b29HQ2EvamxNMlozR0hYMEQrZkdndDc0ZmRPUGt0OUZ1Ri9NNFBsc2to?=
 =?utf-8?B?V3ltajhBVkhUMUNzRUVTSFJtcXVQZTdVZFpEN1ArQUZqT2lJSnRNYzViL2Z0?=
 =?utf-8?B?WlJrQU1qM3Jra0l1YVpubUJxWWFJT2JPSytWSkNQdktRUGxoQlJOUjMwVEMy?=
 =?utf-8?B?eVZieElHd3QzR2YyOElCN2tJRDVPc1lDVTZaZ2FWZ3d6TFdVMkZHd2dyNEtE?=
 =?utf-8?B?V3NjeC9XS2JoanRaektRdDFEK0lVTWpZVGU4UWhzZlB4S3hPb25iSDF0VXU2?=
 =?utf-8?B?a0QvckFJbGt0bEJXSE9OVWtySmk4aVdRMzZBdU1NTHFhTklZY3Y2b0RtaUhC?=
 =?utf-8?B?bWRZRURqNityRS8rQ1hramt6M3dwNGtJd3VtTW5hb1huazlLWm54SW1ZNFRp?=
 =?utf-8?B?bDRDNmE0QjR5SW9HbU1Ya0FvNW9UYXhKSEtZUWxKK0hTVWdFcDdoYjlOTW5Z?=
 =?utf-8?B?RktlSUlSS2hkVWl0WEc4S0FiR0w3d3I1L1c0NWc2cEphQ3VJekVta21ZVWZK?=
 =?utf-8?Q?M/2bDBPHiZXTV4gk9cDqun4asW1hCer0pqNvvC8uNNdU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc220cfc-2fa6-4071-30ff-08db4585165b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:03:31.3420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrioRmbQ8+776vhWZLzijFzRZuB7Fe0QIdR1Y3OE3pw7PDwnDzcHlDgv4u9KOi9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds skeleton code for amdgpu usermode queue. It contains:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 +++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 50 +++++++++++++++++++
>   6 files changed, 108 insertions(+), 1 deletion(-)
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
> index 6b74df446694..c5f9af0e74ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -438,6 +438,14 @@ struct amdgpu_sa_manager {
>   	uint32_t		align;
>   };
>   
> +/* Gfx usermode queues */
> +struct amdgpu_userq_mgr {
> +	struct idr userq_idr;
> +	struct mutex userq_mutex;
> +	struct amdgpu_device *adev;
> +	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> +};
> +

Please but that into amdgpu_userqueue.h as well. We want to decommission 
amdgpu.h over time.

>   /* sub-allocation buffer */
>   struct amdgpu_sa_bo {
>   	struct list_head		olist;
> @@ -470,7 +478,6 @@ struct amdgpu_flip_work {
>   	bool				async;
>   };
>   
> -
>   /*
>    * file private structure
>    */
> @@ -482,6 +489,7 @@ struct amdgpu_fpriv {
>   	struct mutex		bo_list_lock;
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
> +	struct amdgpu_userq_mgr	userq_mgr;
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b4f2d61ea0d5..2d6bcfd727c8 100644
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 7aa7e52ca784..e1b6e658d51d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -43,6 +43,7 @@
>   #include "amdgpu_gem.h"
>   #include "amdgpu_display.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>   
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>   {
> @@ -1187,6 +1188,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
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
> @@ -1254,6 +1259,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
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
> index 000000000000..6fe5d8d73f37
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,50 @@
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
> +#include "amdgpu.h"

Please don't include amdgpu.h here.

Most structures can be forward defined, only amdgpu_mqd_prop is really 
needed and that should be included separately.

Christian.

> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_usermode_queue {
> +	int			queue_id;
> +	int			queue_type;
> +	uint64_t		doorbell_handle;
> +	uint64_t		flags;
> +	struct amdgpu_mqd_prop	userq_prop;
> +	struct amdgpu_userq_mgr *userq_mgr;
> +	struct amdgpu_vm	*vm;
> +};
> +
> +struct amdgpu_userq_funcs {
> +	int  (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *uq);
> +	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *uq);
> +};
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif

