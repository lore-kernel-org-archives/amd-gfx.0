Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D902AC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 22:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2143723A51
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 22:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cFjJtvqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2143723A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A743389EFF;
	Mon, 28 Sep 2020 22:48:21 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700072.outbound.protection.outlook.com [40.107.70.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0E989EFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 22:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFvQx3wj+znKMr0L2M466LmhtzAkOUWpYL/r9eopGhOMz5esYdLXUvsOzPOSw2rpch7UQ4LUs4I0bpYZW6d+mxGMADmwWJaTqOy+6o2G7gi/1YroesAd8Khdwc21XoeZRQLNCAu2Ocu41tuuttHyMMUmv6wgjaYyaYKswya3Eq/VpUjS846gnnj9WWR+qk6SXiUEx2MJa5ARbqXVXmt1GHhB1j4N+Fo3rHTKYbsoUST85oMFtQIRQvwpw9WXLyFzojMEwXioN6cKDmDyCxWch7Gzp6s5MovnWSbzcmxIfnp5yVbFqhXzJeK93LMFQ2ITadVT9Xa1vcis7TAqdDy2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xc2VgzAsTxpB1f5lHWpPEJFZra3a1K7/Cpci3ypnq8=;
 b=MJcYVajLDfvLrV4CLJFbaWmOHjLM8gyFUqy/uFV3nZpjlXuZXgpNasSBcGk3kOPNQuAB5M4rFJvYhtfDxxHSDF0f5XxVQmxsnfZn1/qqOXiTrHH8sQV84lb8c9oABetzHfgxgdqjAQ47tUL+Hh2i9WyGfii4WafPsvXytdj7lwBoSw8/iFdzMkKc10vgtzV5sJijUltMoCbeEdzhlWIe0PWTPJLRhxo4fgBFGQSRNGunTw0zzM2UceC3urW7O8W5559dzn4NNqB2hlYOQlzwl4Tj31Dpt4QTRGfxRIG3BLpR/oNi6EZRvMhWBnq+JNAwOLyQ7nQvAEc+ymrfK+VQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xc2VgzAsTxpB1f5lHWpPEJFZra3a1K7/Cpci3ypnq8=;
 b=cFjJtvqGgTKnBQ5Xxsov0ecACMZTk5Jkt7p7+H7VxtDcKjWrrkxMJdoN749g8MCSrUqhGRl8i8rv0v4c5rlf03QINVtT7mMeXQe5DxMDLUsnABvOe+Rl/jb1UICbqNe4Rb7i8Rk9KrjM/EFd4plMSRFqErmbaGVE0E0dcDYtJgE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 22:48:18 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 22:48:18 +0000
Subject: Re: [PATCH 41/45] drm/amdgpu: add gfx power gating for gfx10
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-41-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <9ecb966a-4b3e-2ffa-b72c-c88bd31b87a0@amd.com>
Date: Mon, 28 Sep 2020 18:48:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-41-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 22:48:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6763fae8-19cf-451e-97c2-08d8640097bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB318091F90BC17FC60316EECA99350@DM6PR12MB3180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLkMoYtSJJo1Tw11Eu1y2V2AHHbMhh0BA7P68U41QYm1LuuaSVebFLXYvD383FhygmBns+aPIQ+DWtcGiBjevjlVBU6Ca7kJV0wVO3ognMviqFHucy7iD+mEFHLO1Uof/HJm+3Y31/kEr/laFMwvd0Na3yTVcve9G1F4y5SGYJD1MOnPVIkdIyBmjF5NQ0D67Wx8pGv6GDFJEKKyza7yYiKUwq58jsFJfwJsGD2/WzvQiVQs+zlNrMBgCLZ4fg14CMus8b4S+Hg5orE6Mtf1ZlT8+n8iZDjzxR4Sqd5LvsmJWIyRXiwkAoRBNNE9YFf1Y9cv8VumnuZWwQXIWIvolqI+zp0l5jFM4pM6TV8JQeh4aZwnCMlYzTnMu0xz/cF+KWCCTx/47NP8LG9T8TBNGLET9DPiLGan10ulBY74eat/SMmCUcoX2bPN/2+fLqu9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(2616005)(4326008)(31686004)(6506007)(83380400001)(8676002)(52116002)(6486002)(26005)(36756003)(6512007)(16526019)(186003)(53546011)(478600001)(316002)(54906003)(44832011)(956004)(66946007)(66476007)(66556008)(86362001)(5660300002)(2906002)(31696002)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Wd/HqcXvXiHt7KTnRywc57q/Xc2nRnMcLWGmc4Y46udQFz8pL373Na5gt6+meTMQdWRg7M/namkvo6A6hSC9eN6VMqovKnFm8uz4M1FpEjEXCE7fflcG+I9kAvv8lqMUKRGCo0NfDpRqjVcVFZbgzSD1+t9/F9hG+b0boy2UgcQpdSgjEZzeymjSHtMlJe+mum+MvBFslLb8P3p9LgmygTo8xVlFOzODNk8ZYRDmzKt7V75dsBABiADW+O2KV6j2mWkvBSjpnTKLw+9YDOuaJHqjTnjiPY7bHIFXxPxnPqMyT70qAr+iPCKHJlf+7pO9vY4t9UdwyeujMOyejSgSuzO5I5NCLnWUu28sTRUt2tWIbaUl3GzRPLBedXisu1AVpfaNWxh1L54nU/y95xrafKLzMh13Q4M2q67Rh2uipuI6WNdfL8+CnhvdSLGFuWftNoCHxa83xPcr+9zJ81LA7tSkS7/s8XA/x1kNkY8LYRMr48M/zYp69CFiWYOQ6zGGe6uukN041fTybT1kx1GN3yeaJlOnutmLcgmsvHrmwNxZizEwZP0qMJUEGSISMUg6CeIBRLfyEt7e4ur1ROi1PprG1IN1RCcaAPV01CidpYzwOps0Y9Tnet+QTNLp/dvoJLU/lZoNDjxJTXoaxGsgRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6763fae8-19cf-451e-97c2-08d8640097bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 22:48:18.4204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6fmw+Jj5bE0Kq77c3eVrGy/8UgN9NUUb2F7kYC+2eN802WWarWnb2FdoBM1IFcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:10 p.m., Alex Deucher wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> This patch is to add power gating handle for gfx10.

Ray, you can just say:

"This patch adds power gating handler for gfx10."

You can drop "is to" and just use "adds".
And similarly for all other patches where you use that.

> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index fd29a6d7285b..f2849f180c91 100755
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7583,6 +7583,30 @@ static bool gfx_v10_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offse
>  	return gfx_v10_0_check_rlcg_range(adev, offset, NULL, 0);
>  }
>  
> +static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
> +{
> +	int data;
> +
> +	if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> +		data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
> +		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> +		WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> +	} else {
> +		data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
> +		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> +		WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> +	}
> +}

So here, you can just do:

static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
{
	data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
	if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG))
		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
	else
		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
	WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
}

Regards,
Luben

> +
> +static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
> +{
> +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> +
> +	gfx_v10_cntl_power_gating(adev, enable);
> +
> +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> +}
> +
>  static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>  	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
>  	.set_safe_mode = gfx_v10_0_set_safe_mode,
> @@ -7630,6 +7654,9 @@ static int gfx_v10_0_set_powergating_state(void *handle,
>  	case CHIP_NAVY_FLOUNDER:
>  		amdgpu_gfx_off_ctrl(adev, enable);
>  		break;
> +	case CHIP_VANGOGH:
> +		gfx_v10_cntl_pg(adev, enable);
> +		break;
>  	default:
>  		break;
>  	}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
