Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18559C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CC123A3C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CC123A3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6101B6E06E;
	Tue,  8 Dec 2020 07:47:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC096E06E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 07:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ71MJQ+AQhIX5g/cos1SatxNEUvCp0WHjTJ5ktt6FuT+PCuJxnm0jsfjIsXrjXX/3qAWtJ5K4PRm3RdQR84I0YFQtLZwFlJPiRtofVHbjHfSBGF0LU37LmXSwK4LGJm7ksVAav+IJHrsj57ipWzuZEztoqtxGEy1jmHXLB5ZMAUCw7d5jXO+3vQM+GrIuL+qjfeo3TD3b3LdpNW9NJKRD+c3A0ggXaStoy7pHDsKGPt9CkSF1RdMx1XQA/j3dMtduDCjQlzOQVYxW2C7FyzO5SixjZTEga2Ax1Ag08EATh5IC/LCg8D1lgNQaV5EXgpqIiKXcUb3e3CnDIp80DI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMT9J3rtqX9B9nnwQ7u6TyElg/XT4lxyPeQIQZ9fjyQ=;
 b=PGnhprUB3DN/c+kadTbcKS1O+C4TnZ7j5wzx35J6g50227NUly/wkDumuPVxHWgn6q6CvNtURNhhRfYH+VvejpSHfMfyFE2spO/kDfJ4gF/pJ4De+vtXq31iP4BxtkHOLp0u2R/xTOA693/sR7YHBV9W4isIy5Njc5HoMxVKCWPkXOZfWxw0t+c9u29ti8ZHTVOkH1TYanPlvPala9kamqG7F6WkVx2hCaaC/38YuP3bE3i89fxZxBgKiYsB6jIYbUVbgosQPLWDwdRz1+TTzP1aiFjYtjCsCOToMjLahbARvELDEr8NKpk+EQzFwqirZOYrh3RpMU6ZXsYaAEwE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMT9J3rtqX9B9nnwQ7u6TyElg/XT4lxyPeQIQZ9fjyQ=;
 b=zsw9hOLhlcwN3TaleiXkwhgD5eldDz2eZ52y6qhNHBTGJDl122m+XORiwjbSNa9+jmDVw5umlofLuEXGIYvQpMbfHie/f3w6SeE730+WhwPSovBoE+2ClDSGjBRDttb42kSgprzzruxPCCVaoXrOrFJZzO6XrsJHJADFQy0u6F4=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3464.namprd12.prod.outlook.com (2603:10b6:a03:d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 07:47:17 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 07:47:17 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
Thread-Index: AQHWzF8uOZfk5S21hUaMRYSH3HRX3ans05Dg
Date: Tue, 8 Dec 2020 07:47:17 +0000
Message-ID: <BY5PR12MB4885E7CE81AE79C43A0C745EEACD0@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201207060553.27981-1-tao.zhou1@amd.com>
In-Reply-To: <20201207060553.27981-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f249aef3-88c0-4d0b-ba8b-7ea0a018d261;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-08T07:45:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 048e5368-0d66-44e8-4dfd-08d89b4d7c76
x-ms-traffictypediagnostic: BYAPR12MB3464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3464DF31173949C682D581CDEACD0@BYAPR12MB3464.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k58ooQH7AVp/deQEWlVnqG6wQK8fD/5+Y17SqKohSq8k2z54ulq5agnQXkLZYi+jtr1q5e6unHZhE+gtVvcIlrTshbSuMTjzvJSwTUsD53rFjQTN4iLuZFdG2Ly/DphbwcA6A0I+RijM2ePIcncXm/b+UE9HZnlPZ/vqI5gM3D3/VyhyOE7eIeghxLA/qPJvUbpNf2VWSW3jw9oa1thdgRbkb65r7eNCuIdcysgnaDxfSS17ISIjr8XOEfgkHIxxou/MqT8dSggEV0XONoCi6v2C5RIR7MJ2OKpBS85JwB0gwfUUtKJOw9YXgN7EPSTCqyd3p0s5M30kCCDR8hopMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(66446008)(66946007)(64756008)(83380400001)(71200400001)(52536014)(5660300002)(76116006)(66556008)(66476007)(33656002)(26005)(478600001)(9686003)(316002)(8936002)(2906002)(186003)(53546011)(55016002)(86362001)(6506007)(7696005)(8676002)(110136005)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4HcxNSmiiM0x61yZXLo61DjN5BZmSCXsJJRQhtzqCCaGOr0dvUH17E/vopJ5?=
 =?us-ascii?Q?SN2MTUVPFrCbxYUGKfrtdt1i84fT36XpNnUPeFwJS6W4FCDrFnoGzt13SR7E?=
 =?us-ascii?Q?uXxB4JTMSK20CMvTdkEvnN511ZtB51hSYbcPrPTFpHpQ3EMzSDiSIh3I4Cx0?=
 =?us-ascii?Q?HqpGfAEfT7LbKWjhsW/YP4SEXAtOkqwMIpOiMhoY97s4+QUb94QSOTEOJ4YL?=
 =?us-ascii?Q?AZC/RccNP9vntlbGsGUdje7zJ1YUCUdsXUk9x7LzaZaWgOT1ORCTvSzIAfnk?=
 =?us-ascii?Q?4Vbuj9fGT3CbVnZlnQg/9OdzuQdAkuCggMT5cRhJybrfMNmls/sWw4RgDGgZ?=
 =?us-ascii?Q?wM/0vuWjx4AKKr4S+q2UvdEHrlDnBCq4sSI0laEO0h67cgDMPJOFtBrfqyJt?=
 =?us-ascii?Q?0aHExiB5Vu6jwutEOs7dE2ZkdkBIIG6EpkoYFtPhlk+PBItjyQSod2jPrjIX?=
 =?us-ascii?Q?STgN3zLI3iLjKZxayVjc8WAOC8ASlBoDDXq0ew7LAQR3j38DAi1n7GwAJkBe?=
 =?us-ascii?Q?AelHtkLTjKdCppK5EfIBvZOZGv0KVYu99FWy+hWnl6bjh/09pNA3FYp6Dq39?=
 =?us-ascii?Q?MnE08/ukdBVdJIrk3BIf03YwaWgy7u5Y2wuJjSMzhWQ82pNE3Mm4kQwHqmqd?=
 =?us-ascii?Q?/9orw7nZTnq40gu9bjM1mAoboGLx6jBHV1WqJ4U6wf4awVgEwYOU7Kym1azn?=
 =?us-ascii?Q?7xoZgLoW4/211ztpzT5xeluzido5OYUZKRRfJ1gbIxhhantpDv9frO65pPhb?=
 =?us-ascii?Q?K2lbJM7Qj1reKwCUWNGAzrdWxGCuwMK0KLhMCQc8pzHDA2qdkZFBJhR+PExm?=
 =?us-ascii?Q?vAlPHTa4ShiPPkUenuyyuhosiVshKo44bhQueV2lPL6YNGtKpVA03nKF/3K3?=
 =?us-ascii?Q?2yaBp50e6ecnF3IGipoBKAo+RsYTi0jn2k5B6FxiXF4Kw0YhCB56ohKUWC++?=
 =?us-ascii?Q?NVLUTph+5+VGJS6o7r2+Hp0lyzsgcgSxxCwDMvICH58=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048e5368-0d66-44e8-4dfd-08d89b4d7c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 07:47:17.4874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEHAubzoSCGrUviexWHNKDe+m4lKVzqC6s4J5njFi8agUsg/X6L96PShSWxMvI/BGtkjHcUKjRhjuphCG3arzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3464
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, December 7, 2020 2:06 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish

Per PMFW 59.16.0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index c1cb472f8f0f..e5aa0725147c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02 -#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF

 /* MP Apertures */
 #define MP0_Public0x03800000
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
