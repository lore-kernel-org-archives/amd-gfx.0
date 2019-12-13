Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5AC4D2E6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E26D246A9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gY4h8sYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E26D246A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A286EDC2;
	Fri, 13 Dec 2019 20:57:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B136EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 20:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+Imf3DzWWZYDHtjzGJWFB0pEF9SXxXKOgC7G+RjmwfRTlLrnuPYnbeKG0qmIJLawsQ3Y1W+yvRvtXJ5iFbfzN9FAQ4MPb6ZsLw/Lwhh42aUhhZoOQwL4UzCqh7uMYKZuVrvNEyPzlDhjt44YeJr7oSYZFU0MX9kLxZsNe/T6YgpcxTHrpknDKoz7ZaB/yvWRGODmBvNfK/nMIMQnlQ/DjrjjmHglQEItXNeJFsK3uGrWPyI9+VLcM51qlzy3ceD63HYZhCaF22kWt/ikiA7eTAMeP9mmiZSz7oYIH3QK2VAavozldAcQhLaIdVx6KzTC4rF9IZL/ihiJUvHGm5kkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz35r/qh4wwOEO0UET221GGSZ8RJut/y+VE8FULSs3o=;
 b=V/2HLWf2UcSWxZ6+mYoOT7Oif6dN40RPQTpQpQ9oSgFYE0glXu9h8TPgFWbBnvQSuTIoSmHevRSuuF0PjVhX8cuyegD2OPsPFOFhBxFLibtmrpXqZwBmiXgBs4QBsriwHoMIP9BV2O1ahMKPGRSVVMjAEvrhoLBxtRQlGaihwTjT3U25VcOy2H49YDSnMcUAUIStndeRzAfScpjJyRfFGoOamP47IMGx1c9yP7UHMtWqDPqM7uO7MHK6cZuIcEaVF9THuVqhOPHZ+gAErhPnkzC3brH1b5I8TsrvTy99t45ytQjDWfog3hvjBCsq5BkmlMpOgBzc6cyIzyowqGEcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz35r/qh4wwOEO0UET221GGSZ8RJut/y+VE8FULSs3o=;
 b=gY4h8sYUsmt8y5NJ5eq+YDNeYI8nkxb8EosiFm3ZonT3zrzL6XD5RfhBa69P+y6Lf1jzi8Pw+dn1sTHIMLBPV+FX/MlLhPupOH7Am1p/LLipDuLYoF7DeU4IXBE2AyA3GhjtEKaidKJG7XufzjMEuIxCvuBUgF4fa930G7fvdk8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2471.namprd12.prod.outlook.com (10.172.116.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 13 Dec 2019 20:57:15 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d%11]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 20:57:15 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: add missing dcn link encoder regs
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Tony.Cheng@amd.com, harry.wentland@amd.com
References: <1576079143-5675-1-git-send-email-Roman.Li@amd.com>
 <1576079143-5675-3-git-send-email-Roman.Li@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <b73f00d6-e40e-f295-25bf-8d31b782f548@amd.com>
Date: Fri, 13 Dec 2019 15:57:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <1576079143-5675-3-git-send-email-Roman.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f99e7e09-be38-4987-e3ab-08d7800f0853
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2471:|CY4PR1201MB2471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2471CABEBD072705F1C192CE8C540@CY4PR1201MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(6512007)(2906002)(2616005)(26005)(4001150100001)(316002)(36756003)(31696002)(66946007)(66476007)(66556008)(5660300002)(186003)(4326008)(8936002)(6486002)(81156014)(81166006)(6506007)(53546011)(478600001)(52116002)(31686004)(30864003)(6636002)(6666004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2471;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MNpIPEdj3NLa8ZSlLiHnkmjVG24n0qpSWC5sHB7f8YlsCaPp6DFuJEkR2us5TdwsJyDLpszLlreOBZqIuL1XDbPJ7jEs5i/Of95o06awB4zaafjT169v/tc2b5LexGeawb/o9iAlI/ynlA6bTBH4FBLVDrWpcvGKufhvGwc8T8pzLoUtF3x5vcJlr0XgOniP+e2JwWlVvZkjIYW8OyAbUdKcN18H6sdnkvBd5abfGOqben1b0qRcnXEcDgQon47AV462lDebtlIf14cv8rGAGO8vRvTFI0nJLl4QiTx9t0+B8/FFYPBj1cr9TziiFBwDzo7wlIr1he3G278ZajfrC249cydsfCqnmE873a+5eDWuP3hOFfp4L529K4TBm4fgh14dr80xXTC/PBq6BdsZQ0i3R2fEPPiWvMotJJ5p3A9GXyGCcuhwH7R4kjhVPak
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99e7e09-be38-4987-e3ab-08d7800f0853
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 20:57:15.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiCb04yAUqfciDReh32NJs8+16fAHyMEZZmglN154buQVHS1qr6Y88ZlGrcsFwVUHiAc4E2YZK71eaKnajmagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2471
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
Cc: sunpeng.li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2019-12-11 10:45 a.m., Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> The earlier change: "check phy dpalt lane count config"
> uses link encoder registers not defined properly.
> That caused regression with mst-enabled display not
> lighting up.
> 
> [How]
> Add missing reg definitions.
> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>  .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |  20 +++
>  .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  | 180 ++++++++++++++++++++-
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   9 +-
>  .../drm/amd/display/dc/dcn21/dcn21_link_encoder.h  |  39 +++++
>  .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  11 +-
>  5 files changed, 253 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
> index 7493a63..eb13589 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
> @@ -124,6 +124,26 @@ struct dcn10_link_enc_registers {
>  	uint32_t RDPCSTX_PHY_CNTL13;
>  	uint32_t RDPCSTX_PHY_CNTL14;
>  	uint32_t RDPCSTX_PHY_CNTL15;
> +	uint32_t RDPCSTX_CNTL;
> +	uint32_t RDPCSTX_CLOCK_CNTL;
> +	uint32_t RDPCSTX_PHY_CNTL0;
> +	uint32_t RDPCSTX_PHY_CNTL2;
> +	uint32_t RDPCSTX_PLL_UPDATE_DATA;
> +	uint32_t RDPCS_TX_CR_ADDR;
> +	uint32_t RDPCS_TX_CR_DATA;
> +	uint32_t DPCSTX_TX_CLOCK_CNTL;
> +	uint32_t DPCSTX_TX_CNTL;
> +	uint32_t RDPCSTX_INTERRUPT_CONTROL;
> +	uint32_t RDPCSTX_PHY_FUSE0;
> +	uint32_t RDPCSTX_PHY_FUSE1;
> +	uint32_t RDPCSTX_PHY_FUSE2;
> +	uint32_t RDPCSTX_PHY_FUSE3;
> +	uint32_t RDPCSTX_PHY_RX_LD_VAL;
> +	uint32_t DPCSTX_DEBUG_CONFIG;
> +	uint32_t RDPCSTX_DEBUG_CONFIG;
> +	uint32_t RDPCSTX0_RDPCSTX_SCRATCH;
> +	uint32_t RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG;
> +	uint32_t DCIO_SOFT_RESET;
>  	/* indirect registers */
>  	uint32_t RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_2;
>  	uint32_t RAWLANE0_DIG_PCS_XF_RX_OVRD_IN_3;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
> index 62dfd34..8cab810 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
> @@ -33,7 +33,142 @@
>  	SRI(AUX_DPHY_TX_CONTROL, DP_AUX, id)
>  
>  #define UNIPHY_MASK_SH_LIST(mask_sh)\
> -	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_LINK_ENABLE, mask_sh)
> +	LE_SF(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, mask_sh),\
> +	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_LINK_ENABLE, mask_sh),\
> +	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL0_XBAR_SOURCE, mask_sh),\
> +	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL1_XBAR_SOURCE, mask_sh),\
> +	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL2_XBAR_SOURCE, mask_sh),\
> +	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL3_XBAR_SOURCE, mask_sh)
> +
> +#define DPCS_MASK_SH_LIST(mask_sh)\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_CLK_RDY, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DATA_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_CLK_RDY, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DATA_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_CLK_RDY, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DATA_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_CLK_RDY, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DATA_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX0_TERM_CTRL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX1_TERM_CTRL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX2_TERM_CTRL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL4, RDPCS_PHY_DP_TX3_TERM_CTRL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_MPLLB_MULTIPLIER, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_WIDTH, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX0_RATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_WIDTH, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX1_RATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_PSTATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_PSTATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX2_MPLL_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX3_MPLL_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_QUOT, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL7, RDPCS_PHY_DP_MPLLB_FRACN_DEN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL8, RDPCS_PHY_DP_MPLLB_SSC_PEAK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL9, RDPCS_PHY_DP_MPLLB_SSC_UP_SPREAD, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL9, RDPCS_PHY_DP_MPLLB_SSC_STEPSIZE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL10, RDPCS_PHY_DP_MPLLB_FRACN_REM, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_DP_REF_CLK_MPLLB_DIV, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL11, RDPCS_PHY_HDMI_MPLLB_HDMI_DIV, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_SSC_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_DIV5_CLK_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_TX_CLK_DIV, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_WORD_DIV2_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL12, RDPCS_PHY_DP_MPLLB_STATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL13, RDPCS_PHY_DP_MPLLB_DIV_CLK_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL13, RDPCS_PHY_DP_MPLLB_DIV_MULTIPLIER, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL14, RDPCS_PHY_DP_MPLLB_FRACN_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL14, RDPCS_PHY_DP_MPLLB_PMIX_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE0_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE1_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE2_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_LANE3_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CNTL, RDPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_EXT_REFCLK_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_BYPASS, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SRAMCLK_CLOCK_ON, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_CLOCK_ON, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_GATE_DIS, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_CLOCK_CNTL, RDPCS_SYMCLK_DIV2_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_DISABLE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_DISABLE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_DISABLE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_DISABLE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_REQ, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_REQ, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_REQ, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_REQ, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_ACK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_ACK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_ACK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_ACK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX0_RESET, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX1_RESET, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX2_RESET, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL3, RDPCS_PHY_DP_TX3_RESET, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_RESET, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_CR_MUX_SEL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_REF_RANGE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_BYPASS, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_EXT_LD_DONE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_PHY_HDMIMODE_ENABLE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL0, RDPCS_SRAM_INIT_DONE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL2, RDPCS_PHY_DP4_POR, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PLL_UPDATE_DATA, RDPCS_PLL_UPDATE_DATA, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_REG_FIFO_ERROR_MASK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_TX_FIFO_ERROR_MASK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_DPALT_DISABLE_TOGGLE_MASK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_INTERRUPT_CONTROL, RDPCS_DPALT_4LANE_TOGGLE_MASK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCS_TX_CR_ADDR, RDPCS_TX_CR_ADDR, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCS_TX_CR_DATA, RDPCS_TX_CR_DATA, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_V2I, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_POST, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_FREQ_VCO, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_MPLLB_CP_INT, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_MPLLB_CP_PROP, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_POST, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_POST, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_FINETUNE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_RANGE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_POST, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CLOCK_CNTL, DPCS_SYMCLK_CLOCK_ON, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CLOCK_CNTL, DPCS_SYMCLK_GATE_DIS, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CLOCK_CNTL, DPCS_SYMCLK_EN, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_SWAP, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_ORDER_INVERT, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_EN, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
> +	LE_SF(DPCSTX0_DPCSTX_DEBUG_CONFIG, DPCS_DBG_CBUS_DIS, mask_sh)
> +
> +#define DPCS_DCN2_MASK_SH_LIST(mask_sh)\
> +	DPCS_MASK_SH_LIST(mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_RX_LD_VAL, RDPCS_PHY_RX_REF_LD_VAL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_RX_LD_VAL, RDPCS_PHY_RX_VCO_LD_VAL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE_ACK, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX0_PSTATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX1_PSTATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX0_MPLL_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_TX1_MPLL_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DP_REF_CLK_EN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX2_WIDTH, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX2_RATE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX3_WIDTH, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL5, RDPCS_PHY_DP_TX3_RATE, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYA_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYB_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYC_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYD_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYE_SOFT_RESET, mask_sh)
>  
>  #define LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)\
>  	LINK_ENCODER_MASK_SH_LIST_DCN10(mask_sh),\
> @@ -63,6 +198,49 @@
>  	SRI(CLOCK_ENABLE, SYMCLK, id), \
>  	SRI(CHANNEL_XBAR_CNTL, UNIPHY, id)
>  
> +#define DPCS_DCN2_CMN_REG_LIST(id) \
> +	SRI(DIG_LANE_ENABLE, DIG, id), \
> +	SRI(TMDS_CTL_BITS, DIG, id), \
> +	SRI(RDPCSTX_PHY_CNTL3, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL4, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL5, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL6, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL7, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL8, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL9, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL10, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL11, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL12, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL13, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL14, RDPCSTX, id), \
> +	SRI(RDPCSTX_CNTL, RDPCSTX, id), \
> +	SRI(RDPCSTX_CLOCK_CNTL, RDPCSTX, id), \
> +	SRI(RDPCSTX_INTERRUPT_CONTROL, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL0, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_CNTL2, RDPCSTX, id), \
> +	SRI(RDPCSTX_PLL_UPDATE_DATA, RDPCSTX, id), \
> +	SRI(RDPCS_TX_CR_ADDR, RDPCSTX, id), \
> +	SRI(RDPCS_TX_CR_DATA, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_FUSE0, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_FUSE1, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_FUSE2, RDPCSTX, id), \
> +	SRI(RDPCSTX_PHY_FUSE3, RDPCSTX, id), \
> +	SRI(DPCSTX_TX_CLOCK_CNTL, DPCSTX, id), \
> +	SRI(DPCSTX_TX_CNTL, DPCSTX, id), \
> +	SRI(DPCSTX_DEBUG_CONFIG, DPCSTX, id), \
> +	SRI(RDPCSTX_DEBUG_CONFIG, RDPCSTX, id), \
> +	SR(RDPCSTX0_RDPCSTX_SCRATCH)
> +
> +
> +#define DPCS_DCN2_REG_LIST(id) \
> +	DPCS_DCN2_CMN_REG_LIST(id), \
> +	SRI(RDPCSTX_PHY_RX_LD_VAL, RDPCSTX, id),\
> +	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
> +
> +#define LE_DCN2_REG_LIST(id) \
> +		LE_DCN10_REG_LIST(id), \
> +		SR(DCIO_SOFT_RESET)
> +
>  struct mpll_cfg {
>  	uint32_t mpllb_ana_v2i;
>  	uint32_t mpllb_ana_freq_vco;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index cfc6991..186277d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -65,6 +65,8 @@
>  
>  #include "dcn/dcn_2_0_0_offset.h"
>  #include "dcn/dcn_2_0_0_sh_mask.h"
> +#include "dpcs/dpcs_2_0_0_offset.h"
> +#include "dpcs/dpcs_2_0_0_sh_mask.h"
>  
>  #include "nbio/nbio_2_3_offset.h"
>  
> @@ -548,6 +550,7 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
>  [id] = {\
>  	LE_DCN10_REG_LIST(id), \
>  	UNIPHY_DCN2_REG_LIST(phyid), \
> +	DPCS_DCN2_REG_LIST(id), \
>  	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
>  }
>  
> @@ -561,11 +564,13 @@ static const struct dcn10_link_enc_registers link_enc_regs[] = {
>  };
>  
>  static const struct dcn10_link_enc_shift le_shift = {
> -	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT)
> +	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT),\
> +	DPCS_DCN2_MASK_SH_LIST(__SHIFT)
>  };
>  
>  static const struct dcn10_link_enc_mask le_mask = {
> -	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK)
> +	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK),\
> +	DPCS_DCN2_MASK_SH_LIST(_MASK)
>  };
>  
>  #define ipp_regs(id)\
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h
> index 1d7a1a5..033d5d7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.h
> @@ -33,6 +33,45 @@ struct dcn21_link_encoder {
>  	struct dpcssys_phy_seq_cfg phy_seq_cfg;
>  };
>  
> +#define DPCS_DCN21_MASK_SH_LIST(mask_sh)\
> +	DPCS_DCN2_MASK_SH_LIST(mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_TX_VBOOST_LVL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_MPLLB_CP_PROP_GS, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_RX_VREF_CTRL, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_MPLLB_CP_INT_GS, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCS_DMCU_DPALT_DIS_BLOCK_REG, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_SUP_PRE_HP, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX0_VREGDRV_BYP, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX1_VREGDRV_BYP, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX2_VREGDRV_BYP, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL15, RDPCS_PHY_DP_TX3_VREGDRV_BYP, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE0, RDPCS_PHY_DP_TX0_EQ_POST, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE1, RDPCS_PHY_DP_TX1_EQ_POST, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE2, RDPCS_PHY_DP_TX2_EQ_POST, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_MAIN, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_FINETUNE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DCO_RANGE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_PRE, mask_sh),\
> +	LE_SF(RDPCSTX0_RDPCSTX_PHY_FUSE3, RDPCS_PHY_DP_TX3_EQ_POST, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYA_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYB_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYC_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYD_SOFT_RESET, mask_sh),\
> +	LE_SF(DCIO_SOFT_RESET, UNIPHYE_SOFT_RESET, mask_sh)
> +
> +#define DPCS_DCN21_REG_LIST(id) \
> +	DPCS_DCN2_REG_LIST(id),\
> +	SRI(RDPCSTX_PHY_CNTL15, RDPCSTX, id),\
> +	SRI(RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG, RDPCSTX, id)
> +
>  #define LINK_ENCODER_MASK_SH_LIST_DCN21(mask_sh)\
>  	LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh),\
>  	LE_SF(UNIPHYA_CHANNEL_XBAR_CNTL, UNIPHY_CHANNEL0_XBAR_SOURCE, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 8fa6392..caafdc9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -60,6 +60,8 @@
>  
>  #include "dcn20/dcn20_dwb.h"
>  #include "dcn20/dcn20_mmhubbub.h"
> +#include "dpcs/dpcs_2_1_0_offset.h"
> +#include "dpcs/dpcs_2_1_0_sh_mask.h"
>  
>  #include "renoir_ip_offset.h"
>  #include "dcn/dcn_2_1_0_offset.h"
> @@ -1495,8 +1497,9 @@ static const struct encoder_feature_support link_enc_feature = {
>  
>  #define link_regs(id, phyid)\
>  [id] = {\
> -	LE_DCN10_REG_LIST(id), \
> +	LE_DCN2_REG_LIST(id), \
>  	UNIPHY_DCN2_REG_LIST(phyid), \
> +	DPCS_DCN21_REG_LIST(id), \
>  	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
>  }
>  
> @@ -1535,11 +1538,13 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
>  };
>  
>  static const struct dcn10_link_enc_shift le_shift = {
> -	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT)
> +	LINK_ENCODER_MASK_SH_LIST_DCN20(__SHIFT),\
> +	DPCS_DCN21_MASK_SH_LIST(__SHIFT)
>  };
>  
>  static const struct dcn10_link_enc_mask le_mask = {
> -	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK)
> +	LINK_ENCODER_MASK_SH_LIST_DCN20(_MASK),\
> +	DPCS_DCN21_MASK_SH_LIST(_MASK)
>  };
>  
>  static int map_transmitter_id_to_phy_instance(
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
