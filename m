Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30D8C00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 22:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7383C22245
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 22:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JiXei4bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7383C22245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67946EE93;
	Fri, 30 Oct 2020 22:38:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271C96EE93
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 22:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk60hPnn8kkFSZid+VuXdHBYswZVnZlbhKxTCAe8HpX50g6CITXCBCVrqO6KLwn/pCDVuGYSJCzDrMmBQvOAgObItS/XQXyTg9CYqTQbdvY0d7hVhrVzzWoYjD5onCLImoYnlR0E5SF/Rr11LgrRfa5yToYp8zjk0uR4bTzO4dW6dZmDlPjnuEOnT0pt23Ubu0nuYyvap734p6KXwQCPZl5H4xgTp9fQQO5ixs3751FLrmZ2MW2ct+yrYID0pYsL+EOcWIBfOHlIL7BsDu9nZF4ejw+f0vTTjZnWfIy/jK/9XeKZMmmIP1P1op3dY/SzwPKF+EWth9cOkfd1w2joDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hqa1Blf0Qwz9U6fVqL23XrEkH1s/JVRIIya1xOnJ5M=;
 b=HEbcn+xivI0XXaSBIOvKVky4SDAurGXweu7juZVNCCXB10x8cHyA46IdCelu1v5BnB5CoIYGpJP4WrKifY0sMrGF7Cmpky/AL4q5NDLB6grWI8cvFJLIdpsp+haonzGVeH5qiO7MDkbLPfM0Rqr/4gEaDWX1kD4d1MKdxPYNBOJ7ceaZKoJbi51Cngabn7TwR4sXzmBlrX7Sb0rYbDlY522fdwXtWke4FmOUMwK5AduW5sFECVIA/vAH+wnORg66jejMu/t5RCZyvD7BIC9L2K35+I5uZHEIeQxsOq9Jh2Op86lKgexLhhgv1osa1/vNa0WOBSoPHEWrsv/A79EueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hqa1Blf0Qwz9U6fVqL23XrEkH1s/JVRIIya1xOnJ5M=;
 b=JiXei4bfw9e8gYr7h5Xy7Z+BiJ0vmuuXHAsGRJ9Q43uZ4IdwrU1P/Hh6vILbP6vfREgsAiWeA7AGFoChTIGfncex0tUfzF+AFEktj/rQoT/NCQtL1C+5+KPSPICZQaJb/3lea2JtkLi9+T2todwiKQTFZZUCMjFD8ezpko2eXzY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 22:38:12 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.035; Fri, 30 Oct 2020
 22:38:11 +0000
Subject: Re: [PATCH v2] drm/amd/display: Tune min clk values for MPO for RV
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201030065505.4033189-1-Pratik.Vishwakarma@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <69dafb64-0524-520c-0f2c-62387a059dbf@amd.com>
Date: Fri, 30 Oct 2020 18:38:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201030065505.4033189-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 22:38:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 817be4a9-e8fa-4cd4-7a7e-08d87d247b6c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4130F11D9B3ECA1FF93E340EEC150@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4iG5RoSnkSbTSlVA6yxBkaVXRfTmJMa6snLIdt4U9/TgXdXHDpf/6/g0VifnfdHGHfyNwA0uxGYyjfgS773/6uf5tnAyFmHS0x2b1EnqqlM31DtEh8XzQFA0cr+nRBCqBtbLJ6CDDb3FiqUXXBzPOoNrvIrpK35m1oOoE6hdEjx4hBiS9/D5jv86lIW1fpYK+xRvt1Ia0mrMUZ6A3V0F2fSygbu2fIFvrWrAIjKyBSRXegWwFiIPwt8iY3XSTDbGe/MprbFvupwswF9gbuEIfW9V6BKgCdVwQdxJvDWwNQfVAfjPNrKkbnem3pJqyUNv56rwdSYliYNWApZdqSz6NeoGMThRw8yLs8QZ++dsKiHl9dZkwBYApjoEqa/366u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(31696002)(36756003)(956004)(2616005)(83380400001)(26005)(8936002)(8676002)(2906002)(4001150100001)(186003)(16526019)(478600001)(53546011)(52116002)(16576012)(6666004)(316002)(6486002)(31686004)(5660300002)(86362001)(66946007)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UtR/g7e8uxLa+G9HMSauzDIvvUuhsE2+ONB9YduxuK6YOx6XipbB6zWUZpPwFriJrQRamIsD58XDfXVOcqBUnEg0q7ToH1FMQ2QEr7bhhNxUZvLKkhYgBdgTIU6n1IhJFSnjgEa1iTG8zMYEOQV/z1Og7T0nDGTgSAWzgV6vtHwkfetJk/Q/Zb7aBgJ9DMkmyuBLwJnQtbxgdrVyX1T2n/It/fQEbIcA6X4UIA4+MM+Pxm1JQrw7WdBJNg5x5w+h6OT5vzyknivpps3Cc6DGj3aCSycixuL1ttGfGT7H6241wwgwe/bC71nAL2yf9av3T3m1G165rVNlRXxCRCRiDFfKCgs7ZHlTuu/4G20K/mItrVP8cPfmTUd/WgiO14LoDF2fMtz1mTHDHUEXv5/3P5b/Dx0edQvoR07xniZf4DWndvdE3i8eOCzrDvgeteuZGC+G4pgqPPT1Npwa2BMP37dRIawTtOmKdLRlEU4BBVHZ99Vc1g1jw7vmmgXgifhOXCxn2rzXLzGpDwF2piO3T+W0rkTK9X5Eg91MEP9kFe6NE0uRMW6H2ztJzP81iFVoRO7lC2xwti5h5eVoxoSnyyL7PCAkhpFaRfORnYemHeCmZ4o0LEfO8CPwEhsLFor9XqlN9iqhkCdHyECBQ4TJdg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817be4a9-e8fa-4cd4-7a7e-08d87d247b6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 22:38:11.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMe8dilTAePhkpwnuMK+iF/pM5OOLv4/YOXbSFp9wsRixSP9lWSDFsmh1JJy0h5Hgrhwq3kg7JSKesmWvWdmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-30 2:55 a.m., Pratik Vishwakarma wrote:
> [Why]
> Incorrect values were resulting in flash lines
> when MPO was enabled and system was left idle.
> 
> [How]
> Increase min clk values only when MPO is enabled
> and display is active to not affect S3 power.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Feel free to merge the patch. V2 still looks OK to me.

Regards,
Nicholas Kazlauskas

> ---
>   .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 30 +++++++++++++++++--
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> index e133edc587d3..75b8240ed059 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> @@ -187,6 +187,17 @@ static void ramp_up_dispclk_with_dpp(
>   	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
>   }
>   
> +static bool is_mpo_enabled(struct dc_state *context)
> +{
> +	int i;
> +
> +	for (i = 0; i < context->stream_count; i++) {
> +		if (context->stream_status[i].plane_count > 1)
> +			return true;
> +	}
> +	return false;
> +}
> +
>   static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   			struct dc_state *context,
>   			bool safe_to_lower)
> @@ -284,9 +295,22 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   		if (pp_smu->set_hard_min_fclk_by_freq &&
>   				pp_smu->set_hard_min_dcfclk_by_freq &&
>   				pp_smu->set_min_deep_sleep_dcfclk) {
> -			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
> -			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
> -			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			// Only increase clocks when display is active and MPO is enabled
> +			if (display_count && is_mpo_enabled(context)) {
> +				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
> +						((new_clocks->fclk_khz / 1000) *  101) / 100);
> +				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
> +						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
> +				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
> +						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			} else {
> +				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
> +						new_clocks->fclk_khz / 1000);
> +				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
> +						new_clocks->dcfclk_khz / 1000);
> +				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
> +						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			}
>   		}
>   	}
>   }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
