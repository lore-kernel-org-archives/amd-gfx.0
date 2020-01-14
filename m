Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E4CC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF57222C4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rDXZ61JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF57222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D76389970;
	Tue, 14 Jan 2020 19:10:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB56C89970
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 19:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdvS07PnmoXOhGJTmwNJRUX7jee63nIjnrtwhpVmqXCVsLimDf02fd+IV1bnOkZyENA1BwVTo9gsajrhmwnnXaFWNgXG9lyb+1zupSq17FzxTqcpy4PV4yvW7tanyTab9ahg0XYr2thk1iHW8hpCQPP84cuOyUhGCWK6CUmJGThK7IGDFQXT0D6vbRR7Fbj0qhCl2UsGsTxtN2vzEfyWFpZqiVUp+iWKWQS3atZWACVavGlTiTTl1acNLxRAq+3JfyXnxIQCh5wvA++7s+VGl0vsFWiKINFXIidqSZt8PA2pQh9iZnehj8HUH9Yw54ucDnxeJnhVUghGOaVP+it4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNV4nLbKPU3othQSiEsc+SNA9kS4UO1unPGJXSm3InE=;
 b=W89mCquNljnhaUOIEa41iT621DAXh7wq4pG0MjKpAIYuxABdU86YEHozQGIHolnUYdIls1Vfno9MX7WMOUoG2y1oZSxm3Ycg+QYc9hnvCsQsq9+4XIAxNdWM8T3cyQ8FVTaoMC0JZ5M4kt0W/4lGQgji8iEE0g+bIG+y97NIzlacri0vXkuWVBqHmBx3ghu8Sy8bYvsI1gtGdmIqvozGcrp3mPeUdYn7bSIlEk5t3PebGVoNtMcn10OHTGTRQZXtlC2n0w6Qg7oMEv8E7CFn8aUsK0Eqj274WFB6mmgVoXEcx+WPedkHJKqULWyqE4xNJSdrCAGGplhJvZ3HRI09Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNV4nLbKPU3othQSiEsc+SNA9kS4UO1unPGJXSm3InE=;
 b=rDXZ61JXDDD6VQJdplMzaZqKs70XffIilPhKF8jtsrGnDm1yVXJMOlENfzeom0ZkPiT6vO2C6RUXyczT/Cd08beFpf9oX0kcQRSAQmJC+CoIqWd4Oz+YlRQaMoAUsCkQeevM2L9rxUIpo+4M8j05hkDdsT/SBixq5kVtQ43BpOI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3642.namprd12.prod.outlook.com (20.178.31.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 19:10:25 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 19:10:25 +0000
Subject: Re: [PATCH 4/6] drm/amdgpu/vcn2.5: add dpg pause mode
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
 <1579024702-27996-5-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <d810d136-a253-a2d3-eba5-a9bb82c9bde1@amd.com>
Date: Tue, 14 Jan 2020 14:10:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1579024702-27996-5-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::36) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Tue, 14 Jan 2020 19:10:24 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd0d93f2-c13d-42b2-da06-08d7992568d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3642:|DM6PR12MB3642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36429B58EB5B78C95CA0434DE5340@DM6PR12MB3642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(186003)(16526019)(52116002)(2616005)(16576012)(478600001)(31696002)(316002)(8936002)(26005)(86362001)(36916002)(956004)(36756003)(31686004)(53546011)(81156014)(5660300002)(81166006)(44832011)(6486002)(8676002)(66476007)(66556008)(66946007)(2906002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3642;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaIk/EgOhecOYRQP4DNZoI/1owEmcnpwE2x4mX3wkZp/S+/VpjB5F2bhr+grVsRLarvm/7BJAyXc1Dnnow+/5lxljwLFD7CBSetqllvzzMKsPIe/0r8ITnCQL+B1meSJiuEQMMJTmMz/zFEJHTdYpG6MRGEswpKmtiTTbi7mY8tVJorA63nfcKZfNESBG6swIYb8fcCq9r/eJsu/q+sVnCPgTnlpzVufMwO3Y9c22BmbQeAOnzK7QvxFHJDz3DZCTTzolmLP5Ev0dzuwGZ2YpYdLPLrwCOxo/ao8BA5iP28re0X2zOe46vsL0fYja5Ck+bnlzzZnuqrMecOk9PBlK9bK/DVr1JtjpcPmfBLN9KqtV+NZ9iamftuS6SGuZ/FgQrHA1FFgRZTHJHstCvxVVpytwcjjFmlcUvHVS5urZZ52eLM01y5yWUqXfQRwB37A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0d93f2-c13d-42b2-da06-08d7992568d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 19:10:25.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCUZu+ihwwdlpZ04DDv5Bj7cN1yLiqYs5o6EtgiSEdABQZn1I/z5Vb3Uz/L7DhbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3642
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


On 2020-01-14 12:58 p.m., James Zhu wrote:
> Add dpg pause mode support for vcn2.5
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 70 +++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index ea70aa8..8de51c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -60,6 +60,8 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v2_5_set_powergating_state(void *handle,
>   				enum amd_powergating_state state);
> +static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> +				int inst_idx, struct dpg_pause_state *new_state);
>   static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
>   
>   static int amdgpu_ih_clientid_vcns[] = {
> @@ -217,6 +219,9 @@ static int vcn_v2_5_sw_init(void *handle)
>   			return r;
>   	}
>   
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
> +
>   	return 0;
>   }
>   
> @@ -1327,6 +1332,67 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> +				int inst_idx, struct dpg_pause_state *new_state)

I think here is the same thing, add instance to v2_0, and avoid the 
duplication.


Regards,

Leo


> +{
> +	struct amdgpu_ring *ring;
> +	uint32_t reg_data = 0;
> +	int ret_code;
> +
> +	/* pause/unpause if state is changed */
> +	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
> +		DRM_DEBUG("dpg pause state changed %d -> %d",
> +			adev->vcn.pause_state.fw_based,	new_state->fw_based);
> +		reg_data = RREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE) &
> +			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
> +
> +		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
> +			ret_code = 0;
> +			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
> +
> +			if (!ret_code) {
> +				/* pause DPG */
> +				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
> +
> +				/* wait for ACK */
> +				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_DPG_PAUSE,
> +					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
> +					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
> +
> +				/* Restore */
> +				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +
> +				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +
> +				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
> +					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
> +
> +				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
> +					   0x0, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
> +			}
> +		} else {
> +			/* unpause dpg, no need to wait */
> +			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
> +			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
> +		}
> +		adev->vcn.pause_state.fw_based = new_state->fw_based;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * vcn_v2_5_dec_ring_get_rptr - get read pointer
>    *
> @@ -1369,6 +1435,10 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		WREG32_SOC15(UVD, ring->me, mmUVD_SCRATCH2,
> +			lower_32_bits(ring->wptr) | 0x80000000);
> +
>   	if (ring->use_doorbell) {
>   		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
>   		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
