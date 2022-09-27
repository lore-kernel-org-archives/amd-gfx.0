Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC2EC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 06:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAB910E8C4;
	Tue, 27 Sep 2022 06:10:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D680A10E576
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 06:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfWhRUmQYjYylKiWoOfoWVeck7UGSoqd3i/jeQ0dYEmK1HCqm5vrNI7apkePNlNxCf8eB/UyHnKDuoJ4lZbmmapoKvqniekP/bOQhSKCLP+r+b+I8ySc5ZKDibTMMHQm4x5Fjx6RBUTjRYK6sRgmg+50jhbGh3kH7RCv6h1SMua1X9+ZAzWrHyKuMHg1ym7YuRsry9sbi/HjbQ7/6vFSB/7b+UYsUzDhVTCyEx2E2cTd9KtiQbrAYuotV5SOD73RbrfnPXejToPF19tmUgAB+1XwTReOwI9CFIetLrKaRbwa1g6U6FptNvtHRQSKYJ01DQL7Tzeti5h+jcFLyYccWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNImtHDcP0XI4WUnzVBAyOhV7i5t2mGwUmfMN4gzQrs=;
 b=Lv23KjWw7yo4Oes+CJ0gi23Cv392fA4mbx2wV8i3cD4uD/QIfceJ0y8y+yZeN+2DY48zhZn4VjnS95itcU1JRSPhauGYBwD9IY6Wx71ZxUufBFMAaWHO0Q3rcrqEWUPh/kqaqSY8i3jJwg0SZY+wYQichaPnW7hhdNSRL9T9RqUWl1gZWcfzzrvUkIKYeonh7fHndbS34fWpvpeY88rVbaso9A6ASFAeJ/WtHks9eHQSqQJG2RmZqDSNZe4Yld975X1IvOMNgqTqRGwHuAh2e68lelgkltKAXA98PRqkHxig5UkqCMcl2irv4aweTB9yI3tGiFLbnzDf3WOaYE31eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNImtHDcP0XI4WUnzVBAyOhV7i5t2mGwUmfMN4gzQrs=;
 b=bnrHRLo96pVPLShFBaHjkZFq8FsjLyYIunQAr7Dq/a2AlP7qrfXtp98BqSYryNwfQvX/4uEOfhiojONHEZzM6fNHEPd71bziSoR/9mg4iPlgDPrkYMlD9fxNj2OaoSoSkS5XgPiktFDrVgixaixz2a6WrWbCV+c3hwZe6oMDD6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:10:02 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:10:02 +0000
Message-ID: <b7ad5684-1d73-e4da-7019-18db5ad16a62@amd.com>
Date: Tue, 27 Sep 2022 08:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/5] drm/amdgpu: set GPU workload via ctx IOCTL
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926214014.5450-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::7) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: d85a4142-4ed1-47db-d60b-08daa04eea46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OUScDS3ejH20a7EpCSL+f2XfkyJV523wd8mvGLxUyPEA+FdBXBEwIhEdvpAoVKV/0nEBktf3mt9sFHARuy4KhWxWn63PYyVrR/yw/kk7Q7YpQMimhIZDKrWowfVG/q/eBq/lsrkWLA+rpBHmKZ2mzQpKy/X/2PLwvu4uVupvwdmZAfzm30za3/JUTbFgLom6sX3NPzTUqG/egm724oFqN/eLPFDJ9JGhMilds/IyPMKcSsn9cPsQWL0i9uFcBsBk7Pa1wIwzMVSPUGer/ukowRD/Z6GQBe2YQs6HsrrEHCDXdxNosrux/dsZ2Yu2eabXk3w9gL8GKR+DdlP0M7GRZf8VVnWvFTmE6DOWRJ0mIg8vMPGQ2JYgB2SL2YI2setllIRDnRIRe3KiLivHePl0emK6G7AgK55IHtBCDrUSOGlQyPek//8NCStLfne2qStHG3DvBYnalAqemS8/TKSMx8H+TexdYoKLpbTj/kBJYaYrhvjzCNaN4DAwaLWu1YIkmsTCzL7jsQh373XxGrHaIAX++7wQiHtjWm0FB5zJwbamH3yYKv7L6JlaS2Uaxv2Lb3LFJWMiynKY0/Y73h+OvR1lWpYuK/TPMpgAneJiNGGSAKH0V//82yYWBYaqc8zyTE9u0Apnvyya1us09qVGXsF/Rw1QnZJr8aGnCnwRxC6pe7ISRD8vgbDh/O4OL5IbyTjDJR9VZ6iN6zYjmAEUIUKrMDF/w81LSgTKCEeQWVWKUj0Gu1uAFb524emoB+QgFynSj0RawPP6adAzAyJF4BPDzVQA+wjrA5SibitMyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(6506007)(4326008)(6666004)(478600001)(41300700001)(6486002)(66946007)(8676002)(66556008)(66476007)(316002)(36756003)(38100700002)(186003)(26005)(2616005)(6512007)(86362001)(31696002)(66574015)(83380400001)(31686004)(5660300002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENiS2pwaXcwSk4xSHAwWndyMmxQOUFhcThSTmUwOVd0WXEzbFo4QVF2R1gz?=
 =?utf-8?B?dGxsbjM5UVFkTEFacG1uRUhubTYwQ2lwMDQ3Q3RlL08rRHR6d2wzMUVMK2tB?=
 =?utf-8?B?TTNueGE3cXZmZ3VuTkpOQmIyeHdhTkJ5YkwwRmRCb2F3VjBzTlZzWWUzNDNO?=
 =?utf-8?B?QlRrNkhtNUxlUnlWeTcvVVlsTnIxNVl1SU5xQUtxOEhWYXhCejExcndSVnJm?=
 =?utf-8?B?eVpScW85WHFGSm5TVW0vL0xyMjJmOEdPZVd5bGNmb290dG5pMUR6WEdQblV2?=
 =?utf-8?B?ZndzelY5VDVKQUY4eWhDajZBVU1INUM1UFVNT3VETUxsTHh4WjJITi9Ga0Fw?=
 =?utf-8?B?Q1pKUzdIMFd1STBXTnB5NHV0OWVDNWMrL2plckd3aTFXWFhyc0JOb3RtTGdY?=
 =?utf-8?B?SG02YllSNE4yYVZqVXNjZUtEN3FXQ2h4UFF4UTliR3hJaFFGbnZZNDB2T1VS?=
 =?utf-8?B?akExTUhrYXRjcWFPUmI0MnhLSTQzbEZ5SnA0Yk9xcWVESlI2d1dLK3plSUYv?=
 =?utf-8?B?RW9qU2k5ZldLZktOT1laOHdJTmY4S0Q2WkcxTDBlNTZZNHRyYXVITDFGck5o?=
 =?utf-8?B?ck1Yc0ZZOGFUNXhoMVFZQVZOT1p6TC9JdXBGL2RzN2ppOCtESTBadU41RzBM?=
 =?utf-8?B?OFNhSGhmNTMzWUJxUXRaS1Z6a0dobWpVSnIwV0xyRnRxaVY3b3ZQSjBEQmc0?=
 =?utf-8?B?R0VQVUNiOHlwKzF4cy9HQWlUNkhRbGxEdm5kcUVTalFjeW9xcXh3djFSRWdy?=
 =?utf-8?B?ZFNyYm1yUmFxZWRFK1A2bmpmdTNVUmJEdjE4TXNCVjc2dEw0S1BHa1B4WCtO?=
 =?utf-8?B?R2ErbW5LWC9GMFRlRWtMdllNWHVxM2FrdFdscG9ieXllK2dRQVRJcmk5SVQr?=
 =?utf-8?B?dWNwc0xIRmtWYUk5MWdkbzdwd3Z3eGp1TFNRVnE4OU93c1hmWUZRUTF4UUF6?=
 =?utf-8?B?VExPcU1CdlM5M1RhQUhVdUxVMjdRajF1TkIxMm9FZnlrdzllYm9MWjNNNFBx?=
 =?utf-8?B?bGtlbUV0WklESHBYSzhkNTJLYm80STZRTWtYR29YUjNvSzRQaU1tK28veGZo?=
 =?utf-8?B?TkEyY2E5c3Z1c3NTLzV4TWdTcDB1alM1ZjZud3cwM2ZFM2VmcE5yMkZuVmUr?=
 =?utf-8?B?MXlVU21uZW9oaGRFWmo1T2poUTVFaFdoYkVmTnRxeFNXZC85U1l6ZzZQYm90?=
 =?utf-8?B?Rmd2c2w1czVjSlptODc0Q3g4SVNid2xvL1lEcHFPclQ5US9hK3BacTZQZ2Nz?=
 =?utf-8?B?SmU4VldoZldPbEZSUG12a2FoYjNqTjJpM0FKeFNaaDBkZFYzZCtyUXREZkxw?=
 =?utf-8?B?QWFjeDdUM1lER1NQMHN6SHozLzhGbUIrWDArdDNCMkVveWNwUXVTZ0NqMUZv?=
 =?utf-8?B?dHVtb05QVjVmdjlRaUNxRUN6dWsweWp6RWVzaWt5dXVDM3diQTdJZmNtQk5U?=
 =?utf-8?B?MkR6SXQ5UlAwTk56ZFhGY0UxR0pVdlRWTHBYUktPTTJYdUNkamxXMXgyaGFv?=
 =?utf-8?B?OUxkQnBZSVpGVXg2WjkwWmk3R1hVNXcvTGxQWThCZ0dXcXZ2WTZxcGh5K3kw?=
 =?utf-8?B?aDIzYkZvVE5XVVJ0VDlpL2NUSllKcHpxdFJPMGVJWC9NSWt2SDZveWZ6d1hD?=
 =?utf-8?B?aWxRWERodlV2YU12YUV5ZW9mOHdLRFEwZHVuN0FFZE1CRXN2ZzhybzF3Mk1u?=
 =?utf-8?B?VkMraHNHWjJzYzVHMFNkSE03dmdKMDR2anVSM3NvSldtakJ0bkN2aGllOTFO?=
 =?utf-8?B?MlpRUXhQVlFHenZsdjhJYnN2Y3FIdlVXajQzWDh6Ylo5RHZ1bHJVN1Z3U0Rv?=
 =?utf-8?B?akhzOXgrMjFYODIwd2hrTTJHWnNST1lVWGltcXE5OHNDbElIWFFMaTFnQXUx?=
 =?utf-8?B?SkljS1luWUFxNzVENGxDanBQUXBnMUxwUzEwalUxUGp6ZTFmdnJBZkpXVGM2?=
 =?utf-8?B?Wk9qdlpzd0dlTHFTeVBodmM3SXdYU2pvYTdBVGtSejFYK2w4QjVPdWNGMWxN?=
 =?utf-8?B?Umx0d2VwODZzQlcwSVB1eFJsckRIOE1NVGdZWE5pbHBFS01WWnRwbjZlNWR0?=
 =?utf-8?B?YkowSVJIeC9uaW1pcExrOEcxc3hGT1lYWHl3YnRQdTRlcjlqTjFHU2JseEQ0?=
 =?utf-8?Q?DWHB/+4HeALyxr1duuMZ6HJwP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85a4142-4ed1-47db-d60b-08daa04eea46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:10:02.7406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QEkeCT64DXT2flVMvS6guoZBw+cBQCafs1XFsOlX35ypTFVd3nVCb4Y5MFbAEqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> This patch adds new IOCTL flags in amdgpu_context_IOCTL to set
> GPU workload profile. These calls will allow a user to switch
> to a GPU power profile which might be better suitable to its
> workload type. The currently supported workload types are:
>      "None": Default workload profile
>      "3D": Workload profile for 3D rendering work
>      "Video": Workload profile for Media/Encode/Decode work
>      "VR": Workload profile for VR rendering work
>      "Compute": Workload profile for Compute work
>
> The workload hint flag is saved in GPU context, and then its
> applied when we actually run the job.
>
> V3: Create only set_workload interface, there is no need for
>      get_workload (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 42 +++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 8ee4e8491f39..937c294f8d84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_sched.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ctx_workload.h"
>   #include <linux/nospec.h>
>   
>   #define to_amdgpu_ctx_entity(e)	\
> @@ -328,7 +329,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>   		return r;
>   
>   	ctx->stable_pstate = current_stable_pstate;
> -
> +	ctx->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>   	return 0;
>   }
>   
> @@ -633,11 +634,34 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +static int amdgpu_ctx_set_workload_profile(struct amdgpu_device *adev,
> +				       struct amdgpu_fpriv *fpriv, uint32_t id,
> +				       u32 workload_hint)
> +{
> +	struct amdgpu_ctx *ctx;
> +	struct amdgpu_ctx_mgr *mgr;
> +
> +	if (!fpriv)
> +		return -EINVAL;
> +
> +	mgr = &fpriv->ctx_mgr;
> +	mutex_lock(&mgr->lock);
> +	ctx = idr_find(&mgr->ctx_handles, id);
> +	if (!ctx) {
> +		mutex_unlock(&mgr->lock);
> +		return -EINVAL;
> +	}
> +
> +	ctx->workload_mode = workload_hint;
> +	mutex_unlock(&mgr->lock);
> +	return 0;
> +}
> +
>   int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   		     struct drm_file *filp)
>   {
>   	int r;
> -	uint32_t id, stable_pstate;
> +	uint32_t id, stable_pstate, wl_hint;
>   	int32_t priority;
>   
>   	union drm_amdgpu_ctx *args = data;
> @@ -681,6 +705,20 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   			return -EINVAL;
>   		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &stable_pstate);
>   		break;
> +	case AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE:
> +		if (args->in.flags & ~AMDGPU_CTX_WORKLOAD_HINT_MASK)
> +			return -EINVAL;
> +		wl_hint = args->in.flags & AMDGPU_CTX_WORKLOAD_HINT_MASK;
> +		if (wl_hint > AMDGPU_CTX_WORKLOAD_HINT_MAX)
> +			return -EINVAL;
> +		r = amdgpu_ctx_set_workload_profile(adev, fpriv, id, wl_hint);
> +		if (r)
> +			DRM_ERROR("Failed to set workload profile to %s\n",
> +				amdgpu_workload_profile_name(wl_hint));
> +		else
> +			DRM_DEBUG_DRIVER("Workload profile set to %s\n",
> +				amdgpu_workload_profile_name(wl_hint));
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index cc7c8afff414..6c8032c3291a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -58,6 +58,7 @@ struct amdgpu_ctx {
>   	unsigned long			ras_counter_ce;
>   	unsigned long			ras_counter_ue;
>   	uint32_t			stable_pstate;
> +	uint32_t			workload_mode;
>   };
>   
>   struct amdgpu_ctx_mgr {

