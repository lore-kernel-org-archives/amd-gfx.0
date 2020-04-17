Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FAFC2D0EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 17:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765332078E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YxjLMs0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765332078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA756E0F8;
	Fri, 17 Apr 2020 17:17:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01A46E0F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 17:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6lmD20yHmAgSEHCuvv9COI7biWTLjJdCzhcmZW1hk9XLSa8IWxQ0FQ6MVRrIShVqwT1teNe1TApKf53MslImoGr0jnCWEIeRKeHDyOHLMX05ABXsCtw9MTeQVpqjXpgiBBBcIAQTt3W31QpvhPToG9Xb1FvLBeIlpDWwQAxXUtv7na2/n7FSffgSQvvCcyulZ9KLRpStL7m7fkAPcrYL+6SjPK/L5Vu3S7zVpuijlPhKvN7YPHMf8dSHJKRZVe0bm4cUcnba+SMsTmC0JRRSOALfe+nE4+BAmena/Nb55Ej+3AgH2zhOGt1fIyyurlsqPvWxPiDtHvFLqzrN+10fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzoHn3ONHh+L6qnRRLyJrhgZ+ubFEApPvDLXRi2eO1k=;
 b=nvxo/pIxQPEiOdrUeXaOaPo0a2ZuZcI5SeXSUVMmwTG8TwbMgHNBmyrjIFUeRuHa5nFGzmt3njw9y2lINGeEauXOiuB6DrlPWNq1G0O2YPznuemad6VGuTP6xO4g19BSg4GJ4rwN4dHaHzWnPzSiBrOocsLoO1VWiddPUkD+d5YXPVj2Wqka6MFrcjxCMwCCbUCnwTCblByXudpWqlzw+n2UQr9aKg1DxHrP6vpkxPruH9P8iJqg0SyEZUqaImnHjxx0Al64RXWwyGiTsrPLHF79qx8CHZzZZtaS4CRKhgQ1rIFW81x70d8+mmkT+AlbbGDzTnzyyuwxLRHhrYcMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzoHn3ONHh+L6qnRRLyJrhgZ+ubFEApPvDLXRi2eO1k=;
 b=YxjLMs0sKIodPBrs8wf9VDyVl2BIy8vM6uR7V+amA7hBdTtHBwm45zk/1Kvbsql4Cb8nNRJqfFafN9cBtjhytPSh8Re8obpQBUqj6hRK8A3VLi0ebnW20ApB8NrrQuCQfNj+nlapS8OSd25dTQDgUqIybM1gR0hO1J0mqE3aHQU=
Received: from BN8PR12MB2962.namprd12.prod.outlook.com (2603:10b6:408:47::24)
 by BN8PR12MB2963.namprd12.prod.outlook.com (2603:10b6:408:61::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 17:17:25 +0000
Received: from BN8PR12MB2962.namprd12.prod.outlook.com
 ([fe80::9ca8:3e3d:2ef9:c35b]) by BN8PR12MB2962.namprd12.prod.outlook.com
 ([fe80::9ca8:3e3d:2ef9:c35b%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 17:17:25 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gravenor, Joseph" <Joseph.Gravenor@amd.com>
Subject: RE: [PATCH] drm/amd/display: Remove aconnector condition check for
 dpcd read
Thread-Topic: [PATCH] drm/amd/display: Remove aconnector condition check for
 dpcd read
Thread-Index: AQHWFCSL8GlDJeaieEGa/sucEz3Iiqh9j1sQ
Date: Fri, 17 Apr 2020 17:17:24 +0000
Message-ID: <BN8PR12MB29626235B1D6251BE680BFF69ED90@BN8PR12MB2962.namprd12.prod.outlook.com>
References: <20200416192330.22317-1-zhan.liu@amd.com>
In-Reply-To: <20200416192330.22317-1-zhan.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f81bdb5-a0be-4c15-185c-08d7e2f332ad
x-ms-traffictypediagnostic: BN8PR12MB2963:|BN8PR12MB2963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB296337E2DACC3FC3A20135A79ED90@BN8PR12MB2963.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB2962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(66446008)(6506007)(66946007)(53546011)(8936002)(81156014)(71200400001)(26005)(2906002)(186003)(7696005)(86362001)(6636002)(66476007)(64756008)(52536014)(66556008)(33656002)(9686003)(5660300002)(8676002)(110136005)(76116006)(498600001)(55016002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyQJWbzq9spukiAtXftlYVUCfd03AxKqC88HlT3t2p1EJPxoYaWdsQ8l9oV/rZlmA/YyTNqngQvXV+KWZv12herA0nFsUkA9OWLjhUnmEGdRL5OwqO0DxgRPPuM8FX8AC2wv5j012iIaMJEJmgUtcdjStYO1sLWZrO+2m53ktzcXf3uwoqdR/hvz3J62hKL1bW5L/r6lbJtqQrn2snSrJ6Rbiwvg4hboW2xXqWcVgikP6FPg6gitb//Dl0TCWenxxGNfo49TGDqwqcqyXaiBjTAQQO1glFTx/tTW8ZP/3q6o9m1qmJu6PJiHVwcU3VAefvQUaGyjRVWdxp14wlNnHChxgrZi1qrTdvKF/NnPbho3fPsmTYaZ0HtySI2yQJXPOeKPGEaj3o08tkVsVJ0Q+UWDfIotDeWxvz7XPSVKC6i7luYKXjp7FZY9LO26K12E
x-ms-exchange-antispam-messagedata: znzRMiPGXQ7TT0fQkgVgwM/TZfYq2wxrt40Kg+V0ste01OQigOscdsG7SfJ9G4D1rcVaVcNa5CyLT4+Wfx92S04VOvAyzQFISevBCbzq9G49MzidSAFrdKl7u7K3eAxPJpmlj1jQ5e74Z8m/W4gngQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f81bdb5-a0be-4c15-185c-08d7e2f332ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 17:17:24.9830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mu1ZGdElVWOseaE9jZHvoz7zND+fWAkcDezIc301gybbPaRB0eKNHW/8lKhWN5wG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2963
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Joseph



Hi Joseph,

Would you like to help me review this change? This was a follow-up on the discussion we had earlier this year.

Thanks,
Zhan


> -----Original Message-----
> From: Liu, Zhan <zhan.liu@amd.com>
> Sent: 2020/April/16, Thursday 3:24 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Zhan <Zhan.Liu@amd.com>
> Subject: [PATCH] drm/amd/display: Remove aconnector condition check for
> dpcd read
> 
> [Why]
> Aconnector is not necessary to be NULL in order to read dpcd successfully.
> 
> Actually if we rely on checking aconnector here, we won't be able to turn off
> all displays before doing display detection. That will cause some MST hubs
> not able to light up.
> 
> [How]
> Remove aconnector check when turning off all displays at hardware
> initialization stage.
> 
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 ++++++++-----------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 9f41efddc9bc..6f33f3f0d023 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1332,31 +1332,23 @@ void dcn10_init_hw(struct dc *dc)
>  			if (dc->links[i]->connector_signal !=
> SIGNAL_TYPE_DISPLAY_PORT)
>  				continue;
> 
> -			/*
> -			 * core_link_read_dpcd() will invoke
> dm_helpers_dp_read_dpcd(),
> -			 * which needs to read dpcd info with the help of
> aconnector.
> -			 * If aconnector (dc->links[i]->prev) is NULL, then
> dpcd status
> -			 * cannot be read.
> -			 */
> -			if (dc->links[i]->priv) {
> -				/* if any of the displays are lit up turn them
> off */
> -				status = core_link_read_dpcd(dc->links[i],
> DP_SET_POWER,
> -
> 	&dpcd_power_state, sizeof(dpcd_power_state));
> -				if (status == DC_OK && dpcd_power_state ==
> DP_POWER_STATE_D0) {
> -					/* blank dp stream before power off
> receiver*/
> -					if (dc->links[i]->link_enc->funcs-
> >get_dig_frontend) {
> -						unsigned int fe = dc->links[i]-
> >link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
> -
> -						for (j = 0; j < dc->res_pool-
> >stream_enc_count; j++) {
> -							if (fe == dc-
> >res_pool->stream_enc[j]->id) {
> -								dc-
> >res_pool->stream_enc[j]->funcs->dp_blank(
> -
> 		dc->res_pool->stream_enc[j]);
> -								break;
> -							}
> +			/* if any of the displays are lit up turn them off */
> +			status = core_link_read_dpcd(dc->links[i],
> DP_SET_POWER,
> +							&dpcd_power_state,
> sizeof(dpcd_power_state));
> +			if (status == DC_OK && dpcd_power_state ==
> DP_POWER_STATE_D0) {
> +				/* blank dp stream before power off
> receiver*/
> +				if (dc->links[i]->link_enc->funcs-
> >get_dig_frontend) {
> +					unsigned int fe =
> +dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc)
> +;
> +
> +					for (j = 0; j < dc->res_pool-
> >stream_enc_count; j++) {
> +						if (fe == dc->res_pool-
> >stream_enc[j]->id) {
> +							dc->res_pool-
> >stream_enc[j]->funcs->dp_blank(
> +
> 	dc->res_pool->stream_enc[j]);
> +							break;
>  						}
>  					}
> -					dp_receiver_power_ctrl(dc->links[i],
> false);
>  				}
> +				dp_receiver_power_ctrl(dc->links[i], false);
>  			}
>  		}
>  	}
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
