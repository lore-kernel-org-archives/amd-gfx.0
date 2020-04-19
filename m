Return-Path: <SRS0=s+k6=6D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391BC38A30
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 16:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B590E214D8
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 16:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IBkmWkwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B590E214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE796E0C1;
	Sun, 19 Apr 2020 16:56:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1F16E0C1
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 16:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj3edBksLG7W8RiJD024dEHgcW3N+SpHbnIygDgCu5Yc1MwJ24DG31GWs7S6Xat7g+18y4boHSOlD2pw/AJfjXeZYr0AGZ3XWXq0t+GV1DhHt5tSCMkYFb2yV5agCWMzfqipUIi+9ppiKP34qUUELw9oYI6yQMTvlrsu0LDiaOzVNcEEWBhVdpHuPTMOR6mrPrwlD9PcodUNextivpKsnJOme44TsX5VxdBQDi4+VJh73RSZIQ6iAHckwTNEly4qEScBOck11SdK6Xk1e/SHZ5YwYXTpB0RkMC4bAdMdLDFJ+uPOoQt1J8lr8MQ6bbD3o+TPCtMSBAeEgMd2Z1bVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8So20m6lbvxT9Kr/RL0YnccB34QQ2JQhFpNev8r3pc=;
 b=YMAe6IHRyPhAeR31r7HZ9wyioSDcaWesiqs4JsbEhgTXtpHW7WYy7tj8zSnm8V00nc6vozbKttqChkyd388lUQ/rrZ0Lzfz40T8HW/9qfUWf/ivzdivmoBcX+t70stDEtDsYsk/RhRqTmrAYaIOpn1cyxF+a/7lQMfLW8uSih+j+CqxSajUdQzUOXD0pb4Z9kxATGOvX9yspWQwMHQTdxB3hkpLrgCKQgRHGfwMVg/tQn2EnxLGu4IptZzI2QZcfr4rRZhJl6h7zLF9OyIpYev5yiinUQSKhYouGazqVvy4QIplUN/W4z3vrvHLD/wUCZ3B7e3VL5d2eBy57ta3iRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8So20m6lbvxT9Kr/RL0YnccB34QQ2JQhFpNev8r3pc=;
 b=IBkmWkwQCwngfbdAlL0h/0C0BR61vx115LpcLjdVWc8EqY+BbvzMyaS4VEeD62TifV3TAVuXb2so9alC2v6gnDvylOjh3OrpjJo4WLq+/QwApuxXAN/gEkAmxOr5KHVOeIye6BP+NGQ6EyKLHpUtGkJm+MWc1xxcqW9JXyJkXNc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3388.namprd12.prod.outlook.com (2603:10b6:5:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sun, 19 Apr
 2020 16:56:06 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 16:56:06 +0000
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
 <20200417214308.347n7xk2d46zx3nd@outlook.office365.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <25091e0c-c465-d455-f991-581aeae744c3@amd.com>
Date: Sun, 19 Apr 2020 18:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200417214308.347n7xk2d46zx3nd@outlook.office365.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0061.eurprd05.prod.outlook.com
 (2603:10a6:200:68::29) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0501CA0061.eurprd05.prod.outlook.com (2603:10a6:200:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Sun, 19 Apr 2020 16:56:04 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e85f16d-abdb-4773-7ed6-08d7e4828cc5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3388:|DM6PR12MB3388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3388C1556B516EFB1116A29883D70@DM6PR12MB3388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0378F1E47A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(4326008)(8676002)(6486002)(16526019)(37006003)(2906002)(8936002)(186003)(6862004)(54906003)(66476007)(6636002)(5660300002)(66556008)(66946007)(6666004)(2616005)(81156014)(31686004)(478600001)(36756003)(31696002)(86362001)(316002)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7zdwVTqZJSPacI14bZ7UZZwFTYeg6hCCXcUfGEQjOr1sWT807cwEfJHg2sb/eTqlthoZtTRF5diWV/clIockfYdwIXiWP1/9wiLBZLvQfXJkJAcYYD9FFtHANPWUPkTo4+muVW8A4RMD8Lh8SM+9lR+LLmIbUgA8OhlOP0qtQU9tnO3N2IgJv1DCgVOtYmudmyaB6kYtZ7zdyGPoflBOG/jV2s+0TUdDmF0Ak8mqaU0r6QjDSmw1/cKmbIyDGzSEd7HookZ1Ic8w+0r8cRpP7a86Wci4IIr8ZBrmw/2xG4ZIHCCNVR7Tw6+3du0jwP7ENJBOWbT2Kz8U8DxZ4YW9+5aZ2tmxPu2YD9uQtYJUgssLF/hX1s1rKxL8lsuIWcd1fylzfhjCE0GwFAZi7qNE9g60QGy4e6TwlgOcr32DTKxRkrnsxKX+1sbOaEq4SfN
X-MS-Exchange-AntiSpam-MessageData: j6LiAbCGeC2XkYm5OCNw+DfVgecJeofKNQpbDWwCOicXYp/XsRiiLypahpwy20vRkjYFHH9DApIYby2g47PhFboyyw8zbjEReRrH/qWu5Zvy9+y3R9qoTQ6FSiDd8zyJBXO01eQoV06sIjTte1/p9iBfy5VdQH39JHqNDXvL2GqjSnvM9Y8rexQdwLSxV7PVmQeupG+nxXasZOLN6IWpo0NEuT7Usj+SIEqNQ+PdgAI5AB8MP+Lil4GT9ppGQZZGyp4mJRcOpSDSfEU4RnySx7eCF5HxsKHVx++pc85Q51QKMgsn3f/yIZcC3OzYfO3MGTrImkGXPObYRr9thDORn93mWOiaYAVw2Da4UIJcKx8c5TALbR/JngCvNXpykm0VyQeIARMaaye7hbFx4COXmZYWhT9HHAs4aDCngXryIAOOep84gg+utcUivA1xKOx1ow4irvg72LBviSrgGCkbhUiPohR/V61aPLWfQJz0pPd67QAbmdDLr4yNdtK5j+TxM1KEFVs8ms6ooXKCxu3FjSbqX/AUuPNGpG8AQCFNP2/Oe9/sQEzzbq8knCBL0CyI8tTQxzSpkw92jkbMNFdf8gLY4Xtn3iOfYMln8yj8JJ5rNEhTswt0+EbAHPZOa36NYKdBoD+/CYGOj26TrO9Jv/XNb6yvUkQzeXMGzq/EWxcsTSp+Wc7K0L77NhqIfTPmIXVdmjOHvr/a1s9NUHYEkA95dRvKg2jB1hBib5zNBSe0dahzXxbrWw7/1dlnKjoCBkX6PhzUq/xxYm1rMoM/OBgj0YAQAZF/IYDtAyeWUiLIWzvRN2XJalmN3wTusG4eH359YwFW23wGgGhnRp4Ms7TekakBKGRhHyqR78t93y8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e85f16d-abdb-4773-7ed6-08d7e4828cc5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 16:56:05.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HgM55yJWmciw3A47ALsqN3Y839/dHdhzbnxJcjBFZIeurM1cJwxJALGNxZWZ+8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3388
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wood, Wyatt" <Wyatt.Wood@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.04.20 um 23:43 schrieb Rodrigo Siqueira:
> Hi,
>
> Wyatt made the below patch for fixing this issue. I can apply it on top
> of this patchset if you all agree.
>
> [Why]
> Current code does not guarantee the correct endianness of memory being
> copied to fw, specifically in the case where cpu isn't little endian.
>
> [How]
> Windows and Diags are always little endian, so we define a macro that
> does nothing.  Linux already defines this macro and will do the correct
> endianness conversion.
>
> Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
> Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
> Acked-by: Anthony Koo <Anthony.Koo@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../amd/display/modules/power/power_helpers.c | 58 ++++++++++---------
>   1 file changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index edb446455f6b..8c37bcc27132 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -265,9 +265,11 @@ static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
>   		ASSERT(lut_index < params.backlight_lut_array_size);
>   
>   		table->backlight_thresholds[i] = (big_endian) ?
> -			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) : DIV_ROUNDUP((i * 65536), num_entries);
> +			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) :
> +			cpu_to_le16(DIV_ROUNDUP((i * 65536), num_entries));
>   		table->backlight_offsets[i] = (big_endian) ?
> -			cpu_to_be16(params.backlight_lut_array[lut_index]) : params.backlight_lut_array[lut_index];
> +			cpu_to_be16(params.backlight_lut_array[lut_index]) :
> +			cpu_to_le16(params.backlight_lut_array[lut_index]);
>   	}
>   }
>   
> @@ -596,7 +598,9 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
>   	unsigned int set = params.set;
>   
>   	ram_table->flags = 0x0;
> -	ram_table->min_abm_backlight = (big_endian) ? cpu_to_be16(params.min_abm_backlight) : params.min_abm_backlight;
> +	ram_table->min_abm_backlight = (big_endian) ?
> +		cpu_to_be16(params.min_abm_backlight) :
> +		cpu_to_le16(params.min_abm_backlight);
>   
>   	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
>   		ram_table->hybrid_factor[i] = abm_settings[set][i].brightness_gain;
> @@ -620,30 +624,30 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
>   	ram_table->iir_curve[4] = 0x65;
>   
>   	//Gamma 2.2
> -	ram_table->crgb_thresh[0] = (big_endian) ? cpu_to_be16(0x127c) : 0x127c;
> -	ram_table->crgb_thresh[1] = (big_endian) ? cpu_to_be16(0x151b) : 0x151b;
> -	ram_table->crgb_thresh[2] = (big_endian) ? cpu_to_be16(0x17d5) : 0x17d5;
> -	ram_table->crgb_thresh[3] = (big_endian) ? cpu_to_be16(0x1a56) : 0x1a56;
> -	ram_table->crgb_thresh[4] = (big_endian) ? cpu_to_be16(0x1c83) : 0x1c83;
> -	ram_table->crgb_thresh[5] = (big_endian) ? cpu_to_be16(0x1e72) : 0x1e72;
> -	ram_table->crgb_thresh[6] = (big_endian) ? cpu_to_be16(0x20f0) : 0x20f0;
> -	ram_table->crgb_thresh[7] = (big_endian) ? cpu_to_be16(0x232b) : 0x232b;
> -	ram_table->crgb_offset[0] = (big_endian) ? cpu_to_be16(0x2999) : 0x2999;
> -	ram_table->crgb_offset[1] = (big_endian) ? cpu_to_be16(0x3999) : 0x3999;
> -	ram_table->crgb_offset[2] = (big_endian) ? cpu_to_be16(0x4666) : 0x4666;
> -	ram_table->crgb_offset[3] = (big_endian) ? cpu_to_be16(0x5999) : 0x5999;
> -	ram_table->crgb_offset[4] = (big_endian) ? cpu_to_be16(0x6333) : 0x6333;
> -	ram_table->crgb_offset[5] = (big_endian) ? cpu_to_be16(0x7800) : 0x7800;
> -	ram_table->crgb_offset[6] = (big_endian) ? cpu_to_be16(0x8c00) : 0x8c00;
> -	ram_table->crgb_offset[7] = (big_endian) ? cpu_to_be16(0xa000) : 0xa000;
> -	ram_table->crgb_slope[0]  = (big_endian) ? cpu_to_be16(0x3609) : 0x3609;
> -	ram_table->crgb_slope[1]  = (big_endian) ? cpu_to_be16(0x2dfa) : 0x2dfa;
> -	ram_table->crgb_slope[2]  = (big_endian) ? cpu_to_be16(0x27ea) : 0x27ea;
> -	ram_table->crgb_slope[3]  = (big_endian) ? cpu_to_be16(0x235d) : 0x235d;
> -	ram_table->crgb_slope[4]  = (big_endian) ? cpu_to_be16(0x2042) : 0x2042;
> -	ram_table->crgb_slope[5]  = (big_endian) ? cpu_to_be16(0x1dc3) : 0x1dc3;
> -	ram_table->crgb_slope[6]  = (big_endian) ? cpu_to_be16(0x1b1a) : 0x1b1a;
> -	ram_table->crgb_slope[7]  = (big_endian) ? cpu_to_be16(0x1910) : 0x1910;
> +	ram_table->crgb_thresh[0] = (big_endian) ? cpu_to_be16(0x127c) : cpu_to_le16(0x127c);
> +	ram_table->crgb_thresh[1] = (big_endian) ? cpu_to_be16(0x151b) : cpu_to_le16(0x151b);
> +	ram_table->crgb_thresh[2] = (big_endian) ? cpu_to_be16(0x17d5) : cpu_to_le16(0x17d5);
> +	ram_table->crgb_thresh[3] = (big_endian) ? cpu_to_be16(0x1a56) : cpu_to_le16(0x1a56);
> +	ram_table->crgb_thresh[4] = (big_endian) ? cpu_to_be16(0x1c83) : cpu_to_le16(0x1c83);
> +	ram_table->crgb_thresh[5] = (big_endian) ? cpu_to_be16(0x1e72) : cpu_to_le16(0x1e72);
> +	ram_table->crgb_thresh[6] = (big_endian) ? cpu_to_be16(0x20f0) : cpu_to_le16(0x20f0);
> +	ram_table->crgb_thresh[7] = (big_endian) ? cpu_to_be16(0x232b) : cpu_to_le16(0x232b);
> +	ram_table->crgb_offset[0] = (big_endian) ? cpu_to_be16(0x2999) : cpu_to_le16(0x2999);
> +	ram_table->crgb_offset[1] = (big_endian) ? cpu_to_be16(0x3999) : cpu_to_le16(0x3999);
> +	ram_table->crgb_offset[2] = (big_endian) ? cpu_to_be16(0x4666) : cpu_to_le16(0x4666);
> +	ram_table->crgb_offset[3] = (big_endian) ? cpu_to_be16(0x5999) : cpu_to_le16(0x5999);
> +	ram_table->crgb_offset[4] = (big_endian) ? cpu_to_be16(0x6333) : cpu_to_le16(0x6333);
> +	ram_table->crgb_offset[5] = (big_endian) ? cpu_to_be16(0x7800) : cpu_to_le16(0x7800);
> +	ram_table->crgb_offset[6] = (big_endian) ? cpu_to_be16(0x8c00) : cpu_to_le16(0x8c00);
> +	ram_table->crgb_offset[7] = (big_endian) ? cpu_to_be16(0xa000) : cpu_to_le16(0xa000);
> +	ram_table->crgb_slope[0]  = (big_endian) ? cpu_to_be16(0x3609) : cpu_to_le16(0x3609);
> +	ram_table->crgb_slope[1]  = (big_endian) ? cpu_to_be16(0x2dfa) : cpu_to_le16(0x2dfa);
> +	ram_table->crgb_slope[2]  = (big_endian) ? cpu_to_be16(0x27ea) : cpu_to_le16(0x27ea);
> +	ram_table->crgb_slope[3]  = (big_endian) ? cpu_to_be16(0x235d) : cpu_to_le16(0x235d);
> +	ram_table->crgb_slope[4]  = (big_endian) ? cpu_to_be16(0x2042) : cpu_to_le16(0x2042);
> +	ram_table->crgb_slope[5]  = (big_endian) ? cpu_to_be16(0x1dc3) : cpu_to_le16(0x1dc3);
> +	ram_table->crgb_slope[6]  = (big_endian) ? cpu_to_be16(0x1b1a) : cpu_to_le16(0x1b1a);
> +	ram_table->crgb_slope[7]  = (big_endian) ? cpu_to_be16(0x1910) : cpu_to_le16(0x1910);

That you have to duplicate the values is rather ugly here.

Since this is all in one file maybe come up with a helper for this? E.g. 
conditional_bswap16(big_endian, value)

Regards,
Christian.

>   
>   	fill_backlight_transform_table_v_2_2(
>   			params, ram_table, big_endian);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
