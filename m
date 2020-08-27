Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB06AC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 07:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8BD22B49
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 07:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v+1/L1xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8BD22B49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3136E22C;
	Thu, 27 Aug 2020 07:02:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F726E22C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 07:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgLLf2KwC1WX+6xs6Jd5pl/sWcZY1HSwpIgLBuy+psbi15cN9EEm4L6lkldAFPsn8sE9s/6dvyxqT+Kuh4XCEDXWXiWadDh1AJ0z8v2AQRaTa6eEfySQUcIi7bOXgsLPndk60AKxIVqkcGZhzpjqELsAffRt04rPfft+V+3B7m6y2IJRI9IYRDePKJDxj2C+lheatreaiMmdRR30aJrt06wRoVzlVCzCcAAMHkEalgL4ZZwwvd2HqXu6wgro2wBhzyiKCGbeblK1AvevmWhNKjAyT/fCBiIXd61ss3gBZWVIbb+J7PVLHLxEjPXit9cMtHk1QZt93Iudk/0GADFK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BJjp0Z6Wmu3+0Rbu3sHEyKxD8OmPaWybDFhptist3Q=;
 b=Sk76OBiIKVun24ouWOkZCeA3uTScmqIgizbBNS5h71I0FeNvbIe5eyweFewZ7hCAs9bS07Q3pjGX5xVg/9aCA22IFg9R2EyXXAW6TGZQwjgTLPhNxHClihG1k7JbB43qp4hZlNZfvd12e0fR6YeJ6Gunr5jGKBGyhm2TIMNh11RAK3x2ZFutIa91ina5FFf3cz8M5tJxCqaPz436BnR6UTsM7MAM1HkVUpZr9oj9QMhxaxaDhOWjSm3vWz/2BL0BWUpP+E8x3xEWWvzvyP9/XtGRqpjHCBbXk7eD91D5qht9EpsWSponHVG4QvjK7+Li9/FHVlfBdFkMYm+0sMcwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BJjp0Z6Wmu3+0Rbu3sHEyKxD8OmPaWybDFhptist3Q=;
 b=v+1/L1xm2OWsBXRTIyW/xN/yb8CT9hciuSr+MVgIRrAu/twdKP9NKyzZ3ts6Gco6j/K1ThM2KiMm0jqqiP5eQWMFv8vP1rLwSmyK3BGeP8jiCLZar8nxD6CSiFTjQC4tFXa94xuNS9aSIaEPTZCuISyNPHp/z5guUfjQ4IKdgkE=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3174.namprd12.prod.outlook.com (2603:10b6:a03:133::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 07:02:50 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3305.031; Thu, 27 Aug 2020
 07:02:50 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable MP0 DPM for sienna_cichlid
Thread-Topic: [PATCH] drm/amd/pm: enable MP0 DPM for sienna_cichlid
Thread-Index: AQHWfD3urjIiiYz6EkW4RYdqhXBvx6lLh29g
Date: Thu, 27 Aug 2020 07:02:49 +0000
Message-ID: <BYAPR12MB288804E80CC97255F2545648B0550@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200827064713.4227-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200827064713.4227-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-27T07:02:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d17bf9d4-ceab-47e7-a40d-000051e29a60;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-27T07:02:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f6022887-e19d-43b4-a3ab-00004bcf8b00
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-27T07:02:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8f3ff0c1-bf89-42ae-8aad-00006845573d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70bfab91-b02d-4a85-1052-08d84a573608
x-ms-traffictypediagnostic: BYAPR12MB3174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3174E5644FDDE9A20DA5B4DBB0550@BYAPR12MB3174.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLyGvWGck31qM40dn1lLQDcMm2jLwCiwemhvo6742c3v8ugU9PrhIrH/Je+vPKJk9EwD574iMrUTdNkjGzxDoKZiJLz6Yzyr1YFMpSDDzIBiYlHTP81aWUgm8G7OyR2uj/D9zp79UU2ms4o6+HNpW92WwYzVpE5WA3sTLFiR2weYlz/UMZczoOV+CflpI2v7MlnMSA5aZHssaDYrqLdxeQavKmBLej2AaokifWBTzZy2EwbhgXxTar9prQfg+14GM+YQtTisxgoGs4mJDmrMpQ7KzJhwWSwUggpo7MHH/e/0quScQdsLls7iAGdf3dtnNMn1cj88l7SpCo/sr01N5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(478600001)(6506007)(33656002)(53546011)(8676002)(4326008)(8936002)(316002)(110136005)(52536014)(9686003)(5660300002)(186003)(7696005)(83380400001)(76116006)(64756008)(66556008)(2906002)(66446008)(71200400001)(26005)(66946007)(86362001)(66476007)(55016002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Y18kaTK8McTLPtqyZdv4lKliP41bFLsveYmtC8Dwj2k0IJvx2sGGSm+d5VPn1PnYP5vyqNn9JTSNQsZWkRWjQHieOrTuh9GkVcZ8a9IToxlObjONoYBom6sREdubfJTniS+yg4op6z/FRzq9qHU4uWo10ZVOl/nJr/kXiv2KdmLCFrSO2QKT3odKJF/LU6Cxo0oWeER8klVbRVPmoO2E2Hz6b3S81LbojTfRDtoeW05bw2aL3ZUxMbKHyjUwqx9hS5zCSr0y+mGnR7uWpxodY4p/UsPENSJ4MMnShMGyK855nUDEOtz1eBZukZ9CcYSMDrD9VWjuYo4sdo38jvw6dESyrvdvFj2MMIa0f6eRX9f4ZL1sGdgwstNU6f3eBD7BnCsGqx0yeyOPpcVrgjGaHPXOmmc+MiRFVBFxIbFCK0IDSDyPFibshqosvsQRLPP+UcqkpYGmFNa8q/4iwYMTYGzR7ga5H7xntYsGidSEVIGFk4KmlbZ6up81wb9gp0J4+8uD2clLzZ0Pg3Icd+pkyjsENWCm86GgA/9movXiKnphw3jq5Z0yJCWRFSzrFeJRrTaYAd3oJ3sktndkswTTra1ba1Ta8U28kYMW5lbP9NsUFpSTKH71LA6DAbOp6y9v5wtPXUrA4iqHVJM0pDIjWg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bfab91-b02d-4a85-1052-08d84a573608
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 07:02:49.9794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9NTVlEI9XZilGkVfFfGcrWhCzpIl5N0u2eFWsO15pOa5hfiwuNDjylkIhzMbb8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3174
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Thursday, August 27, 2020 2:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: enable MP0 DPM for sienna_cichlid
> 
> Enable MP0 clock DPM for sienna_cichlid.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Iee6a05a634c200f9bbb895b963365bb001a451bc
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b48ac591db8b..b67931fd64b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -68,7 +68,8 @@
>  	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
>  	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
>  	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
> -	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
> +	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT)	 | \
> +	FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT))
> 
>  #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
> 
> @@ -230,6 +231,7 @@ sienna_cichlid_get_allowed_feature_mask(struct
> smu_context *smu,
> 
>  	*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
>  				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
> +				| FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT)
>  				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
>  				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
>  				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
