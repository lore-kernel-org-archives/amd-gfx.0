Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D37C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26CF24655
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XsjK3+j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26CF24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA7C884D4;
	Tue, 14 Jan 2020 19:00:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DFD66E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 19:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbD569wE1ES1dFD6MNLIBn4X2YCOhpSrsuB7MIbsZ0TNzvjEWvm8+6zxx5sjNGIcN8/NneVnccGDPKPwu0ej583z8AqJSrSP4OS2StWUJrTTzp8BuxsnFgFZTm8QSknBhR9fOR3hX/q/lyJAJmfND/xszpp+WV34XAsXKdu0FbO66Xj520KEJGlVsTRF8O7ONuKBbfx4CdEWf6tQkIcC2q9xzj8MWXVefV/1Oukmkp1/pcwPFC/Lr5ysLv44aFkP2rX1HZ/kZcQRgvoa2csM4EJQP2z146SZoX4Oc+Ze7qVWEv9yyckl7DEd+CbV0J5C+0Qs+WFLh1MpaUgYIytCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXHccO4bLsIHSddPlJ5B1OvFxDTkIth4GXCLsH+PmVc=;
 b=dX9o4KrSEgghqp31JzI1fyilK3rauxHXUNBt+dy1aIa8atBQePGWKsFO9Q9EzYrOwykpxcX6I53vNPXnZRbBRPBP9Sqzunvbxp3ClXkheutUHz8vMAFK5e4QGkSfj1jMYZe9YqNWEoyCzegfq/cbSPvrBl360iqBUDxrKwY/psigJOtHL5TU9p+TIJchUybFJSjqGsWOlk4laUzcEtGqKKhzPCtFRlWmrpycJTiVMqDScGhm705sa6t+qxb96tAvBCQi02ClEDTJX3uV90yN1D6jU2IJSHZIwu/FVJoW91TTXj3/CgOWoajx+KUt+vf4IU8t11L9Ax05SDKqaNPlFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXHccO4bLsIHSddPlJ5B1OvFxDTkIth4GXCLsH+PmVc=;
 b=XsjK3+j+Z6svyYfhJ5Onn5u5LNyHDngvaG+knNrkjmWhnyai6ihGR+T9B1xVd1ELTEswTYnTeIuvGRTIkjtUSmh2V75/L+y3iMVW5bS/kl6EQWRyJD86ukBKwtnJN147rTEGHFzpxkG3Eo8WOPeMJgKaacjVk+ZgVL5Rz2gpywo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3628.namprd12.prod.outlook.com (20.178.199.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 19:00:04 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 19:00:04 +0000
Subject: Re: [PATCH 1/6] drm/amdgpu/vcn: support multiple-instance dpg pause
 mode
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
 <1579024702-27996-2-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <838ed7fa-ac94-d6bc-10fd-3633a2b1cf8d@amd.com>
Date: Tue, 14 Jan 2020 14:00:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1579024702-27996-2-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::34) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 14 Jan 2020 19:00:04 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd8dd33e-ca3f-4697-a4b3-08d79923f70f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3628:|DM6PR12MB3628:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36280EF23B21F761048EAE54E5340@DM6PR12MB3628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(81166006)(66556008)(8936002)(2616005)(956004)(316002)(2906002)(66476007)(16576012)(66946007)(31686004)(5660300002)(53546011)(44832011)(36756003)(6486002)(26005)(31696002)(16526019)(4326008)(8676002)(36916002)(52116002)(81156014)(186003)(86362001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3628;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WjOoLIn1+CQTDhK3SN9weGQVKhI9iqaJTE96oQdLP1mRwFn3FLcr9gNmwxu6QDrjDqq1Cl7RY1ZUCNrjIhNelrp4XcODKzLou92zxF3oi/JecGqMfjAvdG14XMYYrzRh+iYVgWdAWmDnqTN6IQ1rzvuS6IVe9pgeDbqD1P+C1lw60/wudffDlzWc2JeowtVzNz6vXb8Q2/RVJNTa1706/wLB5t2OLlSh8fGK9jP+eDWU24mAtB3d3+RzoSXsiEGIQtTwP4+EYIkHd0b8YbmSt+1+pf/RVkEA4G/2BWD1OyYf4+hJIGlUSDdCOp5SiPiPO6shBolhUSX6wHaqBNZ5UjyIp8OwHjHEbwpQNDt8zSyIxCrNfer53bWzfKwGZ+E+KaGp7LHuahEvbGUjzVcDF4UN3VuQy4WGY2go4xNQtivox/QRaGW3rSvohKVfnYz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8dd33e-ca3f-4697-a4b3-08d79923f70f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 19:00:04.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt1U9aiBBgntw4u8zj++ssq699U0OKe1p8zikjhZ0ebPsmvHBszvNo/fUCn5Nbet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3628
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-01-14 12:58 p.m., James Zhu wrote:
> Add multiple-instance dpg pause mode support for VCN2.5
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index ed106d9..99df693 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -298,7 +298,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   			else
>   				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -			adev->vcn.pause_dpg_mode(adev, &new_state);
> +			adev->vcn.pause_dpg_mode(adev, j, &new_state);
>   		}
>   
>   		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
> @@ -341,7 +341,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
>   			new_state.fw_based = VCN_DPG_STATE__PAUSE;
>   
> -		adev->vcn.pause_dpg_mode(adev, &new_state);
> +		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e6dee82..26c6623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -199,7 +199,7 @@ struct amdgpu_vcn {
>   
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> -		struct dpg_pause_state *new_state);
> +		int inst_idx, struct dpg_pause_state *new_state);
>   };
>   
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 3b025a3..a70351f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -50,7 +50,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				struct dpg_pause_state *new_state);
> +				int inst_idx, struct dpg_pause_state *new_state);
>   
>   static void vcn_v1_0_idle_work_handler(struct work_struct *work);
>   
> @@ -1199,7 +1199,7 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev)
>   }
>   
>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				struct dpg_pause_state *new_state)
> +				int inst_idx, struct dpg_pause_state *new_state)
>   {
>   	int ret_code;
>   	uint32_t reg_data = 0;
> @@ -1786,7 +1786,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.pause_dpg_mode(adev, &new_state);
> +		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
>   	}
>   
>   	fences += amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec);
> @@ -1840,7 +1840,7 @@ void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
>   			new_state.jpeg = VCN_DPG_STATE__PAUSE;
>   
> -		adev->vcn.pause_dpg_mode(adev, &new_state);
> +		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index d76ece3..dcdc7ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -58,7 +58,7 @@ static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v2_0_set_powergating_state(void *handle,
>   				enum amd_powergating_state state);
>   static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				struct dpg_pause_state *new_state);
> +				int inst_idx, struct dpg_pause_state *new_state);
>   
>   /**
>    * vcn_v2_0_early_init - set function pointers
> @@ -1135,7 +1135,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
>   }
>   
>   static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				struct dpg_pause_state *new_state)
> +				int inst_idx, struct dpg_pause_state *new_state)
>   {
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
