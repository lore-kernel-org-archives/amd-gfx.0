Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F250BC1975A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 03:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACE4206F9
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 03:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lA+jw93p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACE4206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B863D89F45;
	Mon, 23 Mar 2020 03:11:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9487889F45
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 03:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc3oLNLYPdjlmjYTIlsnz5asfqAuzJCcStDMzwb7BJA1zXmt74u1mfONh2dcvlo3EXGRX1SiCzHkhPBYViIFXc1NlMh04AKFShZpc+S3zxo9DSclbCtQTlWhJyyFRCl2DLJvukOpPGd/W1fJ48oqenDKkgVjPkjPf66TPwZRVn64vCds237Qv03Ms0fuM50YFQ4IQEQdPc0KSKQp+ttcF1Kh7ftY+ePIb9Q0dmf6shb+mlhkiAZryTLCtOhcbO1xx/251vCHxBCWAF2zgtPyGvVU8WEEdvSy4UlOfcblOF4BOsyF9lW/obSmabPr5D/OYbaTrm0oh5AMck2G0IwHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ1EPM3UPIKDk6vJBy7X11Gg0jh9c7Iw3wODqWX+XuI=;
 b=MiYxQVH/viUfuF98MAaWgpYxmOw80UDwTNWd2jKlWcHaosBq0UljCJVFzwFqGFyNGWpt2UYRow3TBLN5fnrRdlua3ceoHywo21KyWerAWDuRT05cXFiIY55VAkV7RiaB0CAftW9WJLV3kiArDym2bZkyIo3OxMGRrZgJ2kFHyC6u0Tf6VX+mKX3CCT69MxVApAJnDi8tgscKheiF7w95W6jdF1vjaQJQkEdwvC7Ff4C8b5Kb7Z7Jl0Xt//aXJDCTudYJUmfWxLDJC+iET449fwlbW2MToFotqzI4RUWbhNr+cODNoGfj5MjSNCe1GKru0jvLdyHXs0YbrB1NpmFPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ1EPM3UPIKDk6vJBy7X11Gg0jh9c7Iw3wODqWX+XuI=;
 b=lA+jw93pBL1BjvYm291gQAME73+Ma0fA7SgYwtKkk8/u79Q7T7V2CkXvXvtwOKKxLHfCafJrBMkuUtQ/MS1njuQWBhwPfwUU2ho7rPR89ILTbif8aN5bxliNrIy5kg779+EydVqL6Y6GiZ9PZQ0QvsjXTEAznU9fdhPsocDllQk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 03:10:57 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 03:10:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: record correct sram correctable error count
 on arcturus
Thread-Topic: [PATCH] drm/amdgpu: record correct sram correctable error count
 on arcturus
Thread-Index: AQHWACSG9ZRNeD/BnEaLqIs/5ELhq6hVgJWg
Date: Mon, 23 Mar 2020 03:10:57 +0000
Message-ID: <DM6PR12MB4075CEAE65BA9184AE6187B9FCF00@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200322083249.25573-1-guchun.chen@amd.com>
In-Reply-To: <20200322083249.25573-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-23T03:10:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cad2144c-a126-4267-b100-000073826ed4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-23T03:10:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f8ef0d42-c68a-4980-b08f-00003e82357d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3ea56c4-28ca-4e31-4023-08d7ced7ceb5
x-ms-traffictypediagnostic: DM6PR12MB3770:|DM6PR12MB3770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB377098D770796C7E5CDE4BC0FCF00@DM6PR12MB3770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(186003)(33656002)(478600001)(6636002)(26005)(86362001)(64756008)(66446008)(71200400001)(66476007)(66556008)(9686003)(66946007)(76116006)(52536014)(55016002)(81156014)(81166006)(6506007)(53546011)(316002)(8936002)(5660300002)(2906002)(110136005)(7696005)(4326008)(8676002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3770;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6GlgMJ5EQoJfpnceDDz8++B7gLGsRga2XtgBKg7AMitYcOAuFTokYGybnhMbhTehxKweM2tA03JWGuiZyM3aC0ZRouCxYsm4i4lToJ9qa4FxdnzBOnd1xb1mkQPod/6jHjWbMUyjzIcKa4wmuSexVFdowSR7ARNmH2CxXYn2nQ6L6A27fQLcaKRZ17RL390q/q59PkXbhaUGoXUECaCpF6z0EKGTFOfgkJ8IFR0QpZp7z3fQAnaD25ehQtBG+dp/O70FPMjOY31BI+aiAhG/E03eh1vI6DnI8F2ZrVCLbHx51FHxOMZKpvsB0Ef7/ZEQurB4RXgaMX5YtAU7Mpnhf+UrOaawxNJj5h0p4hor9Wzcvp0wl4gdzMJaoZ/Pf9bltPy3GtYFHNpVkDclTCiG5f2B5WxDgKM58CL9+Bz0SnLnk/bwzI+9zNws1gJrI3bjAYZC4ri3ZcUaYiVkE5Nr+GTuZ38545BEb7CxQ6+F0ToyijGRQ/2uQBL4U8ii2Qj
x-ms-exchange-antispam-messagedata: C8Bq7la4APtl8dg4Qg61n4Atpg+OPQuFdjz7gRb5Bdl4LewKmX2sCB5KZJgypjFHabudH3uaWEz+1tYbD2Z57TCt2qtfEWW9udNq48qux/7TvaefmtY6m8oNno2gehpcd07ZcCnETCFS1lVpVru4+g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ea56c4-28ca-4e31-4023-08d7ced7ceb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 03:10:57.6862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0Tg9WMaoJ82x3+7WfYu0VrIYYdAeEUh9QXlk3f6FWRtTLlxc2wwcdu0V3LB2OlRgmJF/fxQEKdutCTTvP6ayw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

It should be safe to remove ErrorCodeExt check even for VG20. So please validate the fix on vg20 as well.

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Sunday, March 22, 2020 16:33
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Li, Candice <Candice.Li@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: record correct sram correctable error count on arcturus

On arcturus, only sram correctable error is stable after correctable error injection, so reduce check conditions to record hardware status.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 77122a7282e7..57e8f72cc96d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -138,10 +138,21 @@ static void umc_v6_1_query_correctable_error_count(struct amdgpu_device *adev,
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 6 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
-		*error_count += 1;
+	if (REG_GET_FIELD(mc_umc_status,
+		MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+		REG_GET_FIELD(mc_umc_status,
+		MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
+		/*
+		 * On arcturus, only sram correctable error is stable after
+		 * error injection, so bypass the check of ErrorCodeExt bit
+		 * field in MCUMC_STATUS register to record correct status.
+		 */
+		if (adev->asic_type == CHIP_ARCTURUS)
+			*error_count += 1;
+		else if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,
+				ErrorCodeExt) == 6)
+			*error_count += 1;
+	}
 }
 
 static void umc_v6_1_querry_uncorrectable_error_count(struct amdgpu_device *adev,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
