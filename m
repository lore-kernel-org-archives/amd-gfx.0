Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF21C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 11:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282C3206D3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cHj1hFIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282C3206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D498A6E4CF;
	Mon, 16 Dec 2019 11:25:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE956E4CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 11:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYPGAD3LA3o5n8c9kTKF84uNbdlP5w1nNUTASnRL1ebjNK19B7vWASYaIZQ44c0W+k0RD52hq8HiBG/Rby07FHHnmWzFhNksUmfKCg1/y6QXP8ueBd7K0uBuUZBGksxDToQb/Soo1d/JHGqnE0ItJvQEBQyQXCKMOv1/SoqSLpjRnnrmLyFRMFGU/XpxSyZM+RUAUf+RJs3vc4+c4Q0eBSXbpp8li6XvLDdardKKybyHv4RsjBMWcAjf8TS3/bQUcrtx2XoZ2dK8+mG8MHEeE6e4JJ7TmcTBcnLacB48Dsee8h8uIoEu8ucrhWmjGhH14lA11BGtXfnfrD7uU43AUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHFd/iGhvP1dha5w77VrxFPz1JwUOINEjndfaaPmkas=;
 b=QJEj57Ur047wCt9uVLREVaO2EBU8Axa3PdfgfgzGQSRwaZC6xWkznS0nyaGfLzN4P546S4XGWfCwoJajDgvG8PSW17q8d8xdwpISmYqx5Cm4ViQ4mYchfnTAH2VvA6Q6KzCqNJKOA1rShrwkhJ5jK7DZT+phOBWbcBRNfqneSvy50YBArDFly5RJCg6BjPjjs+cLMnZInhuMdY+QMi3bQLAs6YYjEqtXWprP8YJeJAViXGctONjghlOH9+THhFRSrx0DQ24MS6igU7jECaeVUK1TjkqE5pLSun2ZNp5SM+71WsLr4h+cwHMiWqA/e5gos++/fLkHcHCPre861fw7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHFd/iGhvP1dha5w77VrxFPz1JwUOINEjndfaaPmkas=;
 b=cHj1hFIHQt5VhCfw+ZnIT6xLRjKBlUN3XZfjqiqaKcEX6tXj3FKSqSmDgQXLu7lKh2iJ/7KrpySyXqK9fyDX3ECwx2cUIeusUlCrtVyysAvpKftK0ewxemU5+ljYdIjQ4qaY9cYR3gz7432NUz6tkU/rqVTJbXMkomJk+JXVxII=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4110.namprd12.prod.outlook.com (52.135.51.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Mon, 16 Dec 2019 11:25:47 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 11:25:47 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Thread-Topic: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Thread-Index: AQHVsWTR8Xbx3tVBl0m5fk/5c+CzL6e9KkWA
Date: Mon, 16 Dec 2019 11:25:47 +0000
Message-ID: <MN2PR12MB3309F67AFC2833D3828CE361EC510@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20191213032400.12829-1-changfeng.zhu@amd.com>
In-Reply-To: <20191213032400.12829-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2538.017)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8aa8c0dd-7832-4d08-0b53-08d7821ab2b5
x-ms-traffictypediagnostic: MN2PR12MB4110:|MN2PR12MB4110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41102AD39AA66AEECBD152C0EC510@MN2PR12MB4110.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(6862004)(8936002)(52536014)(86362001)(81156014)(4326008)(81166006)(55016002)(9686003)(5660300002)(8676002)(71200400001)(2906002)(186003)(316002)(7696005)(6506007)(33656002)(478600001)(26005)(66946007)(76116006)(6636002)(54906003)(64756008)(66446008)(66476007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4110;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDy0qjzxgdMz0Do7dV7PpVUSn1XUCn3FkvO/V/vLlPb2KpJj9sLkDU2F+xcw0qnAORVzzudLjc2gyzGKdmPtsT4raiJJFGJEnnWfDpjuEb/Y4PZzZy74rrjuiC7zsIRvGo1/v6W8OYBdI48k06tOyOdi7p6YBjuWTjrF3JsJqBj1Ub+QFbqbPCnSWvZ85k/ANXqbKqqnXxCPitv6Rx/J42o1l9K+01VC1NgKMlx83s2xEWHcvtzzTpT8z4OlFAul/7SxxavlLKeX0gflfdHV8okZ0NsRX6sMQKiGrPzZ+z+8lfetSbvVZsy4STrXPrleH5ojrD6NQl6H2TFMkjL+tOPD1cM1rqejLICG4rqF6ART1r97LJZDax6i5gH4odgCjIcaawFLKSs6uuEyMukCYMqY0U6z21NYBTFyNDleXC3ZXc/4ZjOCmTGlXkNA6Rj0
Content-ID: <0D05F7993A4B014E9E7851093E4A6819@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8c0dd-7832-4d08-0b53-08d7821ab2b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 11:25:47.4354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvPFCdeNDk4s2mM2XW+RASeUBqP/1fckAAdBMPIsHAh9LzlTFAD9ZXeFmvb5FrRjHDkWwRgwJetPwyOQvaCn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 13, 2019 at 11:24:00AM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> When smu version is larger than 0x41e2b, it will load
> raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it
> needs to avoid adev->pm.pp_feature &= ~PP_GFXOFF_MASK when it loads
> raven_kicker_rlc.bin.
> 
> Change-Id: I4dffa1783c9ceb5d40df9756d821e2cd7feff84d
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ea58d0e5be4c..68409bb7c9e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1038,17 +1038,10 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  	case CHIP_VEGA20:
>  		break;
>  	case CHIP_RAVEN:
> -		/* Disable GFXOFF on original raven.  There are combinations
> -		 * of sbios and platforms that are not stable.
> -		 */
> -		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8))
> -			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -		else if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
> -			 &&((adev->gfx.rlc_fw_version != 106 &&
> -			     adev->gfx.rlc_fw_version < 531) ||
> -			    (adev->gfx.rlc_fw_version == 53815) ||
> -			    (adev->gfx.rlc_feature_version < 1) ||
> -			    !adev->gfx.rlc.is_rlc_v2_1))
> +		if (!(adev->rev_id >= 0x8 ||
> +		      adev->pdev->device == 0x15d8) &&
> +		    (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
> +		     !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  
>  		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
