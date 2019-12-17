Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED0C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797652146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LC4Sl5XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797652146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBC46E1AA;
	Tue, 17 Dec 2019 15:57:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FF96E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 15:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMY5L0rET32COBuIt2vmeirMR6VdrZpjraFFoa4bw2c8hlFFPfH+hEOlr5Imc11GzaPou/DB27OvAoDzO9eZao0jYwyYcvP08KoTOx5dEG4JFDc3onQbC0AXRmIlUa6iQ6bVRb0fWdB3SjwPJ7gkO8GmgapzvM0lj48us21DmT4kJs9PIPH+28auj+w7NvvFS3ZApdNggeWryimyQojVgoYrpDXYWMT1HQILzasF1wvcPZTQSucVHBS9xytwYZe3iVURTfi7qfziw93ISUjBQvRHCdVfotdhCjc04a+EkX2EkPnZEVU+gW0AZWEWZqx4GJapOCx0NGyeDC07mPABzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhR3H+17bHoT90sOPwUadbWPXaL+HxqNu7JYlLqiwro=;
 b=aKF7VAiCA8x6R/mxStowbMpAcCoDmOzRl4gcHCWsCn8+h3AuzN7w0lX7p6LZgoUL/phAtizmlhCF4pWgt3rR6qz3GTR7Z64+b4Lv0LC5xWkfBmKHsBC/VyaKfxaXyBZgA5cN5GNEWTRYqK8HSP7ru9R671G+6LzvjOs8maAfl6GFcz6+OLWqQGoSGHTB/6OcUMV49lGab6Ab+ToOlZz3p8WeItk4L74bmrHExYDClUsJpBn3juoBUZ1RgAAOr1CZ6g8Fy/cL3YEX3tUxcqRywgLhe8kWs1L+wouStYGxTwejajTYnlE36rh41KxU0XrlcaYGoi0GthCK9ItGhoR9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhR3H+17bHoT90sOPwUadbWPXaL+HxqNu7JYlLqiwro=;
 b=LC4Sl5XR8gYSUJVnwUTAwcBOSGwdofjWKDr0cMcWtHQnm0Px0j72IKfoOtSbmjQlm1QP3Tg6C23RkFfVqEahh2IYzVrUsq3kEJ/FPGLgSXZSlVCg6QNy5LB0uFbDcDBfaDcFY5/zrZBqCcn8pS+M7h9mN+1xX5OszqY48m+jAX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0264.namprd12.prod.outlook.com (10.172.79.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 15:57:14 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::301e:b0c8:7af:d77d%11]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 15:57:14 +0000
Subject: Re: [PATCH v3] drm/amd/display: Fix AppleDongle can't be detected
To: Louis Li <Ching-shih.Li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191211073338.25373-1-Ching-shih.Li@amd.com>
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
Message-ID: <30bd45bb-1351-413d-a8fe-a6a1737d3ad3@amd.com>
Date: Tue, 17 Dec 2019 10:57:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20191211073338.25373-1-Ching-shih.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c596a3f0-1abd-45e8-3390-08d78309c8d1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0264:|CY4PR1201MB0264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02644BC4630B18C59E1B17FA8C500@CY4PR1201MB0264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(8936002)(81166006)(81156014)(8676002)(2616005)(6512007)(26005)(66556008)(36756003)(5660300002)(316002)(6666004)(52116002)(4001150100001)(2906002)(66476007)(66946007)(186003)(31686004)(6506007)(6486002)(4326008)(31696002)(53546011)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0264;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6gFD5BmzjhqrW6psCrHvufHRgx4+QeoshprQwMTqlrN5PlEgqQ3Hv3BtnuAo/9AdXE4KPA+tEnVotYuzoJzZ5UXzUzIUp5gJ7ZKEqcy9rVMpA3CNP1F6m3n1ld0UcGY4XqLSfZWe8MhlKz4l1jmlneeP6jUuP4ntN3fAKSwh7EMiPMtyJ5MIGWay3Y7T4xsQACNogZ54f37wC7zIz5HY1CVm8Ra31fpPP5g2PvH0+bMIByS2L3Mjsj6TW0Scn57TakzeOmXXP/i18txi6gyORwRd3pTfWmfKZ27SwE2cWBdukULCJ5IA82f8P5lhTJC4iDITiQnPMZFEkaK11MkD5ffunfZkF7D9PU6juo6qaEP8CKvwFkFI50zZF9iS6bGwVd0256XEpq9bDGwm1zGPs61Q0YOdD2/fW4Mtm5diHLd3ZcU6yG8XImTxVNjSB4X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c596a3f0-1abd-45e8-3390-08d78309c8d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 15:57:14.6700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RW7BHjdLEraRjwMaNMF3mPvQsWK0zqw5RykeChgj/4izOCWSG73jI0Ww3daBjuZ1sD7kswVvlNMYN3rw9QeUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0264
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com, ching-li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-11 2:33 a.m., Louis Li wrote:
> [Why]
> External monitor cannot be displayed consistently, if connecting
> via this Apple dongle (A1621, USB Type-C to HDMI).
> Experiments prove that the dongle needs 200ms at least to be ready
> for communication, after it drives HPDsignal high, and DPCD cannot
> be read correctly during the period, even reading it repeatedly.
> In such a case, driver does not perform link training bcz of no DPCD.
> 
> [How]
> When driver is run to the modified point, EDID is read correctly
> and dpcd_sink_count of link is not zero. Therefore, link training
> should be successfully performed. Which implies parameters should
> be updated, e.g. lane count, link rate, etc. Checking parameters,
> if values of those parameters are zero, link training is not
> performed. So, do link-training to have detection completed.
> 
> With this patch applied, the problem cannot be reproduced.
> Testing other dongles, results are PASS.
> Patch(v3) is verified PASS by both AMD internal lab and customer.
> 
> 
> Signed-off-by: Louis Li <Ching-shih.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 7372dedd2f48..6188edc92d0f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -725,7 +725,9 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
>  
>  		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
>  			sink_caps.transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX &&
> -			reason != DETECT_REASON_HPDRX) {

Do we need to drop this line? This looks like it'll break the previous
fix here.

It looks like Abdoulaye added this here to fix the 400.1.1 DP compliance
test. If you can check with him that your solution is fine and make sure
to test that you can get a consistent pass of 400.1.1 over 30 runs I'm
okay to take the change.

Harry

> +			link->verified_link_cap.lane_count == 0 &&
> +			link->verified_link_cap.link_rate == 0 &&
> +			link->verified_link_cap.link_spread == 0) {
>  			/*
>  			 * TODO debug why Dell 2413 doesn't like
>  			 *  two link trainings
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
