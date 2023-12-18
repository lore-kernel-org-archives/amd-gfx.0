Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB467C35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A36110E289;
	Mon, 18 Dec 2023 18:25:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E3E10E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt/4GeMb0C8YDTLJz5RadWjPb8E3SHAfroG2HD6Tzsm79UmVWfrOIEFfpi+/1TZ82UzR4Cty3TpYW6Gj5zGzzyjoUFMUf1O0GdfcnNg3xrAL+wj/d9I4CXrok7d73LtTNAWj7YX5Kel1FOksED8WSN4HnrCx2G6GYxQh++BQlIJSLvHSbsfUYz7aU75KQD2YFhseHnU8j8Vw2CZCn+EolZ+U6B13VTztGObEIws5fV42bZNXcgybG6vGC+yYMAwxCkCbxgP1dQ6lhsXTo6SV2rFCGJCiyCITbJuDXzqx4ETR/ftxL1rEbcrhsTbinNlBgeCCmirlxSbaLWKy85NXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zrf787oBVghcYjH0QIf3tnQwE2MIYGHIeCFyfMEzXow=;
 b=SXuOhI+hLLdIqh81QcBzJ9kNt4agAjMsFvbqRXaU76nMxGSKy8wtX+m6hc1BJuA7wZ17ro9Z1GZ1JPLiP4x6npRNonDE5EHtiw5JjxaM785jMMnM03m5ySZ0xit0yo+09P5dePB4IHSMtE5MiPGN8UhE/ytW5izsBTcGOP9DniqDiMhIJAy15f5WVR4NWmB2h3s6rIK3VsuZC6pz91xpICrXhch8HTWppA8DnxYZZUaOq1Ho9u4XvXutW1FPuGrqzpkkpxxLefODK8SX261eX9dfIPlWPt9CFE8IBhjMrd+zw+tqVxdhqT3+QGxITDYOMsHQM4gmzUs3kvQI5j0wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zrf787oBVghcYjH0QIf3tnQwE2MIYGHIeCFyfMEzXow=;
 b=K2jeDFXe78aYDPCwgRHP4x3015aeVhXR7XPeZEuyBHnx3AD8PSVIipySsEPIfN/3fk+pcz6Tk0N4Ci0p4YnZgbIgWmS+EPWJclMpatXygKIW1nBLylCLQ0xDujSs7TJos7eivRgIROkprYe5xcSBPx3x5ZCY4HMoR2VZIcsB/U0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 07:30:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 07:30:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amd/pm: smu v13_0_6 supports ecc info by default
Thread-Topic: [PATCH 4/4] drm/amd/pm: smu v13_0_6 supports ecc info by default
Thread-Index: AQHaMYFYdoCIQ15CBkmcMVSbziIzXrCupRbg
Date: Mon, 18 Dec 2023 07:30:39 +0000
Message-ID: <BN9PR12MB5257BD7844E3CEC6ADD481F8FC90A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
 <20231218070932.2307244-4-YiPeng.Chai@amd.com>
In-Reply-To: <20231218070932.2307244-4-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=232bced1-b016-4741-9f70-4d915e8f5940;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-18T07:30:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH2PR12MB4294:EE_
x-ms-office365-filtering-correlation-id: 9342e3b9-bade-4b32-ee87-08dbff9b3bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N+8TCHfvNREPo2SGbIvl4abnMSSupbZYZtsQPp3cBrLXRoz4yEGZ8gAbC6KjYN3VtRRXGBUTDCMDWauuc38jzKTbYQ9K1qqjGsU/kahpwYvmit32s9CiG/w6+kC3VQJFJCJlknITiyPNgydszRVVeWqiL3NYl4J2sQ++8nGqwr1+GbuI+SmQ48B+ukpuyEhRaV5rtI9W78Cu4KRzguKoH9Lmzd5xxtvtId44L0uYQKSccVAhlolIwAzpeVX7Zs2m+WzwSse5aMT6MtPAjccyNshaeIHs/CANxb6S8LtaiCggT2JPPfimUgdtxFvmcNvtB10yG/mfLBXm+/6OT/tUmvQS5gCEOh07A4PzUG/evmJuDosgZfKALa+2HTJlf+T7bGqXbYX4bfzYmZ6PNXBLFzMYLc/P7Kli+Fohas5qyZ5YXe7+p5lg7EX+Pm4WQBp3+mLYW7lgJAoXfTSAn8hJfzR5oxrSFgUXmRdBqQhEmMZOnwQRTDMDyb7+HHYnvV3haH91kC3aBjRErORrnY9b6lfRrpozqYpibODebuswniZeipXUPHDJ2n1qgdaN7z2S4o/oEy1FvHb3xNHRliae5e/X47KHaZed6GYdxsfV0AYW2i6gcH7BG3i8k7q7SkIw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(8676002)(4326008)(38100700002)(5660300002)(122000001)(2906002)(52536014)(53546011)(9686003)(7696005)(71200400001)(83380400001)(316002)(66946007)(66476007)(110136005)(66446008)(64756008)(54906003)(66556008)(76116006)(55016003)(41300700001)(33656002)(478600001)(6506007)(26005)(86362001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lI5ptWN3vliIO8KixeJJ4No5ROl9xHk4s/k7cCctohcSQDLpRwzSZjHY7SWH?=
 =?us-ascii?Q?CB9Gk51aMYfCTtaDN7gibKZ1E24OLTAIljd34SMjZ1TPCD4fhEmw5Bnw2f9m?=
 =?us-ascii?Q?DbeUbHhpcm7aYOfA5PH20NE0rlrWOzGn0azaJG8sHZ3YiJPsUt0f1CnLNoAb?=
 =?us-ascii?Q?UDU/ujcV98UpNb+cfO7BdWW4jYTirUKbPZQ/Fnn+dnhZLxtALhquKw7zkbZB?=
 =?us-ascii?Q?bKdVP13ahW3++aS4iy5uAccr3pj6DWdt6W9bN4AGsZsqgW5rYMYGe52d18lc?=
 =?us-ascii?Q?d9pJDMC038/MflcGXI6t4//M1pDGcSzIiVTeJAU2BnWpnmN+LR4V75HLPu6D?=
 =?us-ascii?Q?mpHxRP0uddNW7EDc+PgTuPgI79KtkFK+G2toBvWjxxbDgg7sB4fTbQ3jiNNO?=
 =?us-ascii?Q?+A1ynpMOd4z1crSbWu7G+YcZVpWYlIwqPnwnA+UYLC1762pwbuffdRF7pYih?=
 =?us-ascii?Q?dewxrVmqAfniBIHBhIxwP0KtLOIepag/CoqyYOCBFoa/i2WuYVm812ZFMeOP?=
 =?us-ascii?Q?+kPmP6PegYPWFECpvph392uldvT3WpS49xHRWjfzlf6zfwdILHeu/ZFD0qLW?=
 =?us-ascii?Q?EoYeSWL8n9eGVv06+lZQ979PzGXZLf515Xpxx+bPnTqR9G8PYYc+OXF1fYHj?=
 =?us-ascii?Q?zOL9yOSgbNmyCTJGcdUvnjiSrfcIqHFoHI0rdj/TcddV+rFxAoiHRngWI7Vc?=
 =?us-ascii?Q?hevAq02hL1W14FU0Zbd6kql3vxBSFXWv5E0Yy/tGcl+aHrqhuX1bWQ5yejNw?=
 =?us-ascii?Q?HWPrx03uUN3Z7NtjnH4/f3hS6FzvPEHGgRU6mOtuXhufPTv/CorH4Fnouetk?=
 =?us-ascii?Q?SSbKgdlpEQN+6FIol6DRehXdYi2hz2OMnDjtn13WOyEHRTAox32aWmS7NZfR?=
 =?us-ascii?Q?/wCfJZ+5ZcwV1yTml1Yvz8PyQ/BJkCWFkMS+oMIPAbkox/dexNuciC0LzGLI?=
 =?us-ascii?Q?vTCdp5fmeh5d8ObcoaVKG8PO02EBFHqr/f55kntJKPg3CIFoa6tx+W2UGr32?=
 =?us-ascii?Q?ztKfnuGsydOROMl87SP7GNEonKD+HsKZMZtT+42KgI0Z8CbZwZ+QZ5uigWvz?=
 =?us-ascii?Q?FJZ0NyOqw29r9fDwGzY9n5LWokhD5TXLKmIabmG+evS5gDCHTL3W2J1CQ046?=
 =?us-ascii?Q?N+agJRImWqOAUT53j9ryIKcLig9wvlGp1JUmDAXdEkodrSNHACvKEgULrU6Y?=
 =?us-ascii?Q?VlxNLzVqCuiqaDxA2mARoei1cgYnJOSjFwMEBO/ij7/0LlTB8dY3nDdUKUpv?=
 =?us-ascii?Q?9VJUcMyA7tUnrF1O45JYIUGZhMB+nMOy8REvZOug2K7iqQGa97sGit1w1d1U?=
 =?us-ascii?Q?bR0WkOXFSNiTGBLW7GrVI4QV7tEnJIIrfmOczAm1YBRsAS7d1NTbhUH0OuiS?=
 =?us-ascii?Q?5QcG0I29O20QmezDCbJtGFx4sbyJH1FFdUsSCgzjyQ0hJRR03cOv3vTpvyHN?=
 =?us-ascii?Q?B0lKu8KGr8k6s+DQha1PMOzelp7Dibv0WFcos/p9x2IKbBb2dda9fMqZ8sFy?=
 =?us-ascii?Q?FeH0Xd0n40faPBRCbCS7s1W/SB2nTusxHAuIznnWfdI8hYUk5zVD/ylQnvdL?=
 =?us-ascii?Q?D02OcQIMk6sfylye75o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9342e3b9-bade-4b32-ee87-08dbff9b3bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 07:30:39.0827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WWOpjfMVlnzDwv4R2m18/R0hfu7VN8qiIBK3uAY76IPSNIpQ2cs+Tk+w7uv77c0ubjTC154Aiz1D61y4F1/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Monday, December 18, 2023 15:10
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: smu v13_0_6 supports ecc info by default

smu v13_0_6 supports ecc info by default.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bb3e953bfed5..7d0cbe840182 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2862,6 +2862,13 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struc=
t smu_context *smu,
        return ret;
 }

+static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
+                       void *table)
+{
+       /* Support ecc info by default */
+       return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        /* init dpm */
        .get_allowed_feature_mask =3D smu_v13_0_6_get_allowed_feature_mask,
@@ -2916,6 +2923,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_fun=
cs =3D {
        .i2c_init =3D smu_v13_0_6_i2c_control_init,
        .i2c_fini =3D smu_v13_0_6_i2c_control_fini,
        .send_hbm_bad_pages_num =3D smu_v13_0_6_smu_send_hbm_bad_page_num,
+       .get_ecc_info =3D smu_v13_0_6_get_ecc_info,
 };

 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
--
2.34.1

