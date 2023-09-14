Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB55CEDE98A
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 07:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABBC10E50F;
	Thu, 14 Sep 2023 07:46:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEABB10E50F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 07:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcG52YBWTb+9czX5R0LCdICget6zW5JCO0B21PmVZCFyYXAeQ3TRFBBkh/5HDdHIi8hTDtvI011nRURU0yyjTTj488EYzWm86AJIVA7Eo4Eih+2mLtfGO6GFnnZSCexsUp1aZOOmQeHVrv8AwcrDZanLoWsdtDcXcBn/bEYeoU/fo/wtRrYtd2/o6Hv0+BumE5SGa7xHW/7KgNnC75szxi6m4ZLa8Qk+KtWOu7DdLUMiKwLX8S2pSjOZUR4Zb7CkGODDcywu7AaibkEPyG4QxwTSs9zeVYlvreeTYdqI3IT3WYqG8Wf+j6OrcKKrmBGy7oyGO5tqrxcFf9bGikU+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3hXkoWiWsk12Z7cp+9CHPZl8g1O7rmOnl64BVuT6/s=;
 b=gJZ462PnkoyTqrGmoDLpHkspHObQT3dqC7Fr/E4Te+Or9+hldphtvswtCjWhUck02HVrTKlLhQ7oEVsGa1evbJnhxm1SHdq0lE1IgPiFiLeN/+xcexPPigHA4PHuBE0/pfaQ+Nli5J3ohphfiXGsJoq4IhwOiIx5m8CQzlTDw5CeObxzeHxyYLglxt2bvb/dvQF+43k/xJImTDYNUyX5vVbeR7Nq6KuX7zBL3rjgcCJfSeRsyryYi3Ra2R2EAzj7gZUlSivKYDpkMr/Y40YpTnsZcH5RLpPXSbwIYOFe+A4ggLevNGHdq5DNZXl4pSKM/p96cii92ABpyQ1oY9va/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3hXkoWiWsk12Z7cp+9CHPZl8g1O7rmOnl64BVuT6/s=;
 b=GuS7eoiBJTuYtl7FmTW2cexruIiBRWOgGA5vUiK9egigRv5dVOjMsKo7OsW/zpI+3kM/jk10CghbVuhyos2fyf8e4DbGsOaOPqYqjBZxjbK/ty9SzERP5beBtEUutHF596Km7UIruD0odZ78D6YMGH77e/gXAWdJ5KVYuRdfwME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 07:46:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 07:46:04 +0000
Message-ID: <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
Date: Thu, 14 Sep 2023 09:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230908160446.2188-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: e91b92b0-0e17-4905-825f-08dbb4f6a58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDR304GyTdVk0W1aGv517zmiZo+gvtc2awCcxAyHk/NKfK8NkgAfH7hX7ghBKAweoRnQMdqA3jPMfM9UIq0lNGeWgy3Fnv0eKGABnLix74SqPo2Mv1Fa220Jufegr5I739ElMT6TQiAQTGiqjEJEKc1nI04rg+jJRdH6+o9N9IC1yXZ97pEqMtJjZDlGs+FTGoRSIS0qy3f6ZfE/K6q0MyFsSzCrS6kjo686E+BN97eiLQ/Y4UctpWttB2JtT92zW3sPg0Feh5gWJ8VLS3Kt6QYXrgBlA7OqBibw/pzzt4w/wjBx6vBkrmfgnEyaZoS7ININY1RWIWSQFwbBNT16HKPN2TB1yt2yYwIgM0oFwjpArJJypjJVAYsE7G5+5IUuoCtGPDMAmd20OnYJ4VHDdQ9XcIytsBZgEAvZtZz9fEXHa0xevN19sJbdxB+PTR4kyHtiezBL3T3zT9KmyjHDvEKWqSeESOxBAFJd1pooKPmOukDhJnYNCtMMWT5NqZTuLfBg/Kl+DmGjsQZFFhDPudnk5qUw3zYhnavxzLpEl2+9cv5HJ3nfa5KVqPoL+twc5HDFZnOAtsutS7eheNpRFJqmvI9j8jK9UMNRGGaxtFnybZV3y5hlW+fLQisfhTHnu8Ll19obatQrjUmpiuR5BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(6486002)(6506007)(6512007)(83380400001)(2616005)(26005)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(6666004)(8936002)(8676002)(2906002)(478600001)(5660300002)(31696002)(86362001)(38100700002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBtcGo1NDY3RjkxMlc4YXhhYThKSVhpVU9hWkpGZThVUnlLbjFRVVFkaFV0?=
 =?utf-8?B?eW45K3pXSUhsYjFSNWErbWViUHlhd0NuTEdvbDJyelVVeHB1RzluVzlVTVI0?=
 =?utf-8?B?dnRjQ3NYSHV3TG1hQTVCc1hRMGloRHVSU3JPUTR3ejFvaHJHV09la01iNmVn?=
 =?utf-8?B?K0pUcDhXNVd0WTNxdmlIQXA2MzhwK253LzlCZ2QwcVFySUYzOElaaENwc0x0?=
 =?utf-8?B?RWc4ZGIvblZiL3JIT1NHQ3U0dHdMRk5BVExqRWZ6K3UxVXkvWnZBbng2SjlO?=
 =?utf-8?B?cm8raTBQcUJXam5DWTZkNFlnYlpnRW9lbHF6TUVkU0tldUd2MjBERzMrNjRO?=
 =?utf-8?B?czR0TmxUblp4TTBZbUdnLzBiKzVyWWJTZlNFamh5TDAzVHYvSTA1NlZjZkIz?=
 =?utf-8?B?Y1UxaWpWUE00Y0NvOHNRa3JsWTF2SmR0bDRDdEQ2cjROMWlLMzlTRFVlS3Bw?=
 =?utf-8?B?ck9SZ1lDV0c3SzVkVDQvc01SMWtsL05ydXZielVRQTFsYVlEZUNmRngwVUU3?=
 =?utf-8?B?Qm52ME1BdzNNaklJZHQ0RHYzQ3Y3UTBJSjA0VXFLQ0tYWHo4dHYvL0hMSGY3?=
 =?utf-8?B?ay9acUNUMHRDbEMra2lBdWxKSXFEWklabnd2RzlDTmNSTThhRFJOZ3hXUDZI?=
 =?utf-8?B?NkRQVnlKNEtCWTlzMjRCTWxhdkxwWmZvZXNWSUNNNHBIcEI2TnRVbm91UW9m?=
 =?utf-8?B?akhyL0NNL245WjVramtTaEw2TmpBZzh0eTI5eWZyaitBb3JFalNvWXg1dFBh?=
 =?utf-8?B?U2puUG9mbUtIRXFvdkM0N0hOdkFWWExkMHAvUkxXWVpRK3VmWVFLbHpJeGZj?=
 =?utf-8?B?Z21Nd2VNVUtQY1hDWGxUK1JpTXR3OHVvbnFJeFRLV0lXUTRhNzRTNXhDSzhh?=
 =?utf-8?B?WWs2UGVlZU1VTy80QXk2cEhxRW1JRXBJQlZlSGl3Z1k5bk54Z2ZzYlhiTXFS?=
 =?utf-8?B?NkdHZU10TmdNdWlta2VjdThpdnFKOUIxeVhGbjNKaTlBN3BJc3VLT1U2cHNO?=
 =?utf-8?B?d0lRL2orVmEwNkdkMkdhSEsraXQvdks3aTRUQ2g5WlFGbHg2V0hlQVZnN2ZD?=
 =?utf-8?B?MTl0SWRKaFdqQ0gya21PSmZYWHBONTJqN0MvbFdpd2N6L055d1pmTmMwaUJM?=
 =?utf-8?B?N2FUbkRBVzlZM0tIMUJCL3hUUjNrS1JORTE2YzBNY3RteldtUFVOYUR2VjB0?=
 =?utf-8?B?aVBibEI5Yjd6aDdKcmxVQzcrOC9Sd1E4aWNBQ2s3cE4vMWpJbEZwekkyZUkw?=
 =?utf-8?B?NFZkSTMxNzZoUXlvZjh1djhINFlWakFnTmJsaUpnd0hva3N5Rk9wSjJnS202?=
 =?utf-8?B?ajBQOE5hYnhMRFVvc3ZZQVVzR1JlQ084YTR6ZDNoMytTVFFMY2wrSE83OVNx?=
 =?utf-8?B?YXlQQ3FmZzdQNG9wbTFFSUVBNnNTTVBjQjBOV1ZSZnNTLzJqZDRGNngzTmtr?=
 =?utf-8?B?cm85dW5ZemhYemptK3Z5d3hob3U2MDBtM1NqbGxabG5HUkNVUloxUkcxSzVL?=
 =?utf-8?B?ekZwUjdjbkZSeVU5UjlnWUdXOUEweVhFOUFYdmNKNUV4cmpTZTVJd1dzWTNw?=
 =?utf-8?B?a0JKbXl6NkkyMy9kNW81N0JlbnhLN09MdHJQcVdQNjJqL3owZ3JrSW5ySTk1?=
 =?utf-8?B?dGV2MkNiZjd4RFJSZkZ3T3pwenRxK3RmbGNXbmx2ZHRMc2I0dGR2N1lKb1FD?=
 =?utf-8?B?ZmZ6a2JVYys2UTByN08xSUpRcHExT0h2R2xlK2xwU3g4b2k5cytGRHNKSHY3?=
 =?utf-8?B?V2hJMWJTQ011QjhCZk1QUHdaK0s2d3Y0S09oaXJCT3ZPOXZWZUZ5WHNvZFpY?=
 =?utf-8?B?NGszaGgrMUYzZWNsQjFIRVhoRG0wSE9KbVR4ZXFkN24rN3NjSEoveUJGV2p2?=
 =?utf-8?B?WmV1WG9GVDRhK2UweFgvcmtCNmppNmRERll1L0k5NC9Ma2hoTndrU0M5U1NY?=
 =?utf-8?B?Wk1VbjBFTmExeWFxdTc5TzBHTDdBQ2RyVU0zZ1owdTJ0WXRqNVB1MkppbmE3?=
 =?utf-8?B?V1lNVStVQUdURTl6bjRWRmljQkVWSVBrM0ZuZk1vbWhQSzBiMzgvbXk0M1VL?=
 =?utf-8?B?cUVrV1N2RE81NnRjWFMxdHhUTTA1ckJIdFB6bWY1bjdmN1BHbTNvOUFoNGJH?=
 =?utf-8?Q?ASSNu44DXjfURpdDh4D8lH+Ls?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91b92b0-0e17-4905-825f-08dbb4f6a58d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:46:03.9760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24UK7D9u1POsKeclzVEw7mrd/3UMuCIUkUhSZYNMrEACw7ybH1l5ECcTfc8zeBE6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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

Am 08.09.23 um 18:04 schrieb Shashank Sharma:
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>    GFX-GEN-11 IP
>
> V1: Worked on review comments from Alex:
>      - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>      - Reuse the existing adev->mqd[ip] for MQD creation
>      - Formatting and arrangement of code
>
> V3:
>      - Integration with doorbell manager
>
> V4: Review comments addressed:
>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>      - Align name of structure members (Luben)
>      - Don't break up the Cc tag list and the Sob tag list in commit
>        message (Luben)
> V5:
>     - No need to reserve the bo for MQD (Christian).
>     - Some more changes to support IP specific MQD creation.
>
> V6:
>     - Add a comment reminding us to replace the amdgpu_bo_create_kernel()
>       calls while creating MQD object to amdgpu_bo_create() once eviction
>       fences are ready (Christian).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>   3 files changed, 100 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 44769423ba30..03fc8e89eafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	int maj;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	uint32_t version = adev->ip_versions[GC_HWIP][0];
> +
> +	/* We support usermode queue only for GFX V11 as of now */
> +	maj = IP_VERSION_MAJ(version);
> +	if (maj == 11)
> +		uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> +}

That belongs into gfx_v11.c and not here.

> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
>   	mutex_init(&userq_mgr->userq_mutex);
>   	idr_init_base(&userq_mgr->userq_idr, 1);
>   	userq_mgr->adev = adev;
>   
> +	amdgpu_userqueue_setup_gfx(userq_mgr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0451533ddde4..6760abda08df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu_psp.h"
>   #include "amdgpu_smu.h"
>   #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_userqueue.h"
>   #include "imu_v11_0.h"
>   #include "soc21.h"
>   #include "nvd.h"
> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.rev = 0,
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
> +
> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
> +				      struct drm_amdgpu_userq_in *args_in,
> +				      struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
> +	struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
> +	struct amdgpu_mqd_prop userq_props;
> +	int r;
> +
> +	/* Incoming MQD parameters from userspace to be saved here */
> +	memset(&mqd_user, 0, sizeof(mqd_user));
> +
> +	/* Structure to initialize MQD for userqueue using generic MQD init function */
> +	memset(&userq_props, 0, sizeof(userq_props));
> +
> +	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd_gfx_v11_0)) {
> +		DRM_ERROR("MQD size mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), args_in->mqd_size)) {
> +		DRM_ERROR("Failed to get user MQD\n");
> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * Create BO for actual Userqueue MQD now
> +	 * Todo: replace the calls to bo_create_kernel() with bo_create() and use
> +	 * implicit pinning for the MQD buffers.

Well not implicit pinning, but rather fencing of the BO.

Regards,
Christian.

> +	 */
> +	r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &queue->mqd.obj,
> +				    &queue->mqd.gpu_addr,
> +				    &queue->mqd.cpu_ptr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +		return -ENOMEM;
> +	}
> +	memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
> +
> +	/* Initialize the MQD BO with user given values */
> +	userq_props.wptr_gpu_addr = mqd_user.wptr_va;
> +	userq_props.rptr_gpu_addr = mqd_user.rptr_va;
> +	userq_props.queue_size = mqd_user.queue_size;
> +	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
> +	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
> +	userq_props.use_doorbell = true;
> +
> +	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize MQD for userqueue\n");
> +		goto free_mqd;
> +	}
> +
> +	return 0;
> +
> +free_mqd:
> +	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
> +	return r;
> +}
> +
> +static void
> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_userq_obj *mqd = &queue->mqd;
> +
> +	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> +	.mqd_create = gfx_v11_0_userq_mqd_create,
> +	.mqd_destroy = gfx_v11_0_userq_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 55ed6512a565..240f92796f00 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -29,6 +29,12 @@
>   
>   struct amdgpu_mqd_prop;
>   
> +struct amdgpu_userq_obj {
> +	void		 *cpu_ptr;
> +	uint64_t	 gpu_addr;
> +	struct amdgpu_bo *obj;
> +};
> +
>   struct amdgpu_usermode_queue {
>   	int			queue_type;
>   	uint64_t		doorbell_handle;
> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_mqd_prop	*userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
> +	struct amdgpu_userq_obj mqd;
>   };
>   
>   struct amdgpu_userq_funcs {

