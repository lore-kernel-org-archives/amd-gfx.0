Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003AC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6B020EDD
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vx9WpjAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6B020EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AD689F63;
	Mon, 14 Sep 2020 08:19:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6FB89F63
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9B0VKyipsB2UutyqJsRQlwOqJZF1w9l//6d600maegGYv4r2mhyn3qM/IMJkQF0Owo5Drilvv6szCQo1KcziZa+x5k/SPvU1Qkk/lZGb1OF8yY32wH1vthxoTN9LUraByJT8swo2cfvQT8fLPJ0UOY1VunXyLU+Q/j3ocXSb8OL2ItO8nKeuzsLwG8bPpmBCyqbcBJ8Ha1AUUp1tqfahHKGX3JRi/8YcMbW/tLjafQFFdeZntSY4xDbllF6cJApu7VrY2BR4FyPhPpFR3BIzVypmTEs4QoxCMYuGCIscqaSnfqmXNst9rNqt5dh2VoZHzod4mxDd/mVf8zpbPfEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHoRQLeyEzs+Rykeg7pMeV3TyNPtbmHePxZf4eh/fBg=;
 b=CrrfaCGwojkfVnarKLYQ/fZslTaHrRMr3TLYeDM90jt5bULVmqXE5LamGqUzISLQTgTVh3SY9lTDnweD0y6aOQHSXhZEUu1EmP927sKYGz/cVJeJtxsJJwj8LCGOWA6+X0VCgVhH3f2XAbsDjlx6J8SkUMrKIXf2fk0BNz7OduRuKgET2bQcgWhmxTKJUC6B3WAB66PoxcmR1vJkcMV9m1SnM4SuHdFjNkafob1N0xMUPER1uwd0KcTWu8cqDydg/fh7+lQDw4r3tVytnUSH9UVhwVynZnw95vMNvWKcK9tuUFDCRRN5REjLOQ2vTIgmwHu7iKiViTqcBGoM4SWEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHoRQLeyEzs+Rykeg7pMeV3TyNPtbmHePxZf4eh/fBg=;
 b=vx9WpjArletBFDlwyesMXDkB1ptrEWzvxyesKyLnwvhbobdrsnOxISYB5LoBMg1iYGLTdrAaCYTOJz3geFz2GWGYLYjX38IwGqCTpAGavLjwAergQudt6oRgY2bni88HqQlkCdYsC2CepCTGpkr5Z/a9/z8xifakzw/qW3x3fn4=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 08:19:21 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 08:19:21 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Topic: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Index: AQHWim55zDWsQ5CTkUGGzvNGJqZb66lnyUOAgAAAqHA=
Date: Mon, 14 Sep 2020 08:19:20 +0000
Message-ID: <CH2PR12MB4326DBA5D82C18221283D172EA230@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200914081001.3932-1-Jiansong.Chen@amd.com>
 <CY4PR12MB128709986C0308A88D466D15F1230@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB128709986C0308A88D466D15F1230@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T08:12:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1cebe0ba-846f-4a19-96d5-0000c143c1bf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9357455f-0a3a-44e2-345d-08d85886e1e8
x-ms-traffictypediagnostic: CH2PR12MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3781655AE8E69EA53D7C2676EA230@CH2PR12MB3781.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jA9wbYltetwwUGiJmF140Y9kDGry0vrN4YZ/YAm1R/6lOfiZNDNuv7yBqjWN2bujenOIXjWUq//mrQYYOpQ2GqpvdN7Hv3AtyUVeYme9ODgcBPqvZnVYXkfS093O6wXmnagMwzuXqt3K/Ccj/DTpU3QSEhlxFcVmf4I8dxPjD2vtFE2qWaNBjS9Pm7ix3eVtxLSbDZBAdrYg09i1arasdbl1e2PjcK4wjgingxfLpylTp/FOKLZa035Ulgsvqfic0sBkABEQQH8OI92Y14/0xnK2h6xth79PmEWSYmFwWplUffvT6Ik9ni46+rBIJY001REhJmhxQ6yMocE+tnXef5RMq+yAX86lntXGhByax6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(71200400001)(66446008)(64756008)(66556008)(66476007)(7696005)(53546011)(66946007)(76116006)(52536014)(316002)(6506007)(45080400002)(2906002)(26005)(33656002)(478600001)(186003)(5660300002)(9686003)(15650500001)(55016002)(54906003)(8936002)(4326008)(86362001)(110136005)(8676002)(966005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ai8qvdFt9Zvjfsv0DDCT/LD5lVOA0S9bG9BJEg9v0g0W0T+ekKbrdqsFf5x5B3fxHSnHyniqVrx7KFllsCr0DSVJp5Z64ok+0KRwBSwUXxlV7kxYk8UsterOQM27QrUqczy4DabJH/CPqnbCxLADQudt4s2CcoPuGFI36GGFFY7qhYS/XKUlPMBqfQ7DTXZDDWNao4nGhWZAydy7sNqHfWJQpbGB4dUuRCcbjF/ZHYG5Q04+pGwPz3hyxL31yp/6XTA+gmB/xbLdwV7ju8LdMbdbgydOjlenQGYqTkBryp/0yeSEPr+svFrEbptWrfwvp7IrA4tq8mr7EtgiEhqZgZ7t+9cODd6d2LgY0gPoRV3cGmRlFRN22qrefR8zdcXMhWZBqAGtvONek++zEbQeVx39NcxA0YDvkTTe1gjXz7xmI53bFwFAhQVSBW5AB6L3eJ4W0R3RylNOhuvBJDhPw4Rde83hJhVPsgIv7k51srVOMNf32B3SiILXuzSjK2cDQ2/aDG1lvNrrkP+OGdoJIxZBKgay2KEyOlHNy62lSy96W3quOVhIMyObC03ZkslJy7zFBY0rgbnDYrIVJT83QYZoZEBk25J9XkPIOVDpF4VwS4EQW/5H67+A5Z2rG+wwEJjS1aprWSCznvRUGIOzNg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9357455f-0a3a-44e2-345d-08d85886e1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 08:19:20.7945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaPLufXt2hk9oSRvI74ITCZmXjlUS6iL8htTnCcjXqJ2M/hcMgKJk87lCXYO8Nx0dXa4cmnlrthJEwfnyDuljQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3781
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It makes nonsense to call gfxoff  when smu failure has happened.

Regards,
Jiansong
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, September 14, 2020 4:14 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: RE: [PATCH] drm/amd/pm: support runtime pptable update for sienna_cichlid etc.

[AMD Public Use]

ret = smu_late_init(adev);
+	if (ret)
+		return ret;

One counter leak happens? It needs to call amdgpu_gfx_off_ctrl(smu->adev, true) before returning?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiansong Chen
Sent: Monday, September 14, 2020 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: support runtime pptable update for sienna_cichlid etc.

This avoids smu issue when enabling runtime pptable update for sienna_cichlid and so on. Runtime pptable udpate is needed for test and debug purpose.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I70b704ab4d6efd169f579c392e5dbc2737dc1fb2
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7a55ece1f124..7618f9972b8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1129,7 +1129,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_NAVI12))
+	    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
 		return 0;
 
 	/*
@@ -1214,7 +1214,9 @@ static int smu_hw_fini(void *handle)  int smu_reset(struct smu_context *smu)  {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int ret;
+
+	amdgpu_gfx_off_ctrl(smu->adev, false);
 
 	ret = smu_hw_fini(adev);
 	if (ret)
@@ -1225,8 +1227,12 @@ int smu_reset(struct smu_context *smu)
 		return ret;
 
 	ret = smu_late_init(adev);
+	if (ret)
+		return ret;
 
-	return ret;
+	amdgpu_gfx_off_ctrl(smu->adev, true);
+
+	return 0;
 }
 
 static int smu_suspend(void *handle)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Cd73dd73ccf3c444c710508d858859f53%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637356678262125090&amp;sdata=p0sqrDLhD4vaNesLHIq6Jfd57sAeu8wHDH69bDwTAvA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
