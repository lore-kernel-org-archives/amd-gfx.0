Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EFBC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 03:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877AC61132
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 03:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877AC61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4266E062;
	Fri, 16 Apr 2021 03:57:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494C36E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 03:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mefyvKyjOQMYRJqsPIksdLvh9ecDebga1p2M7Hwg44zXysrzZ6b8cTUZdQX/7aga0zCmKcsETyGB3GeMg23S14qLnh7VPyojLkOh2ADIo0KKarFK84TB79vbrVHwp/5ZLFrv9WojGwOjtkpx6IElqj0kAi7+VHzJDA/xnMpzCUvt8h2qJkOHF8WzfBl9dLcbpOJbJVvmFc9cUggaHRIHrQN+fl6/CldyQmTX4AaaI1mLKxp5Qx57bxp99Gc2WKUbyBePtReGoQ6A8uzzbwi4ootLojzg2wK7CAmUKOQ4ib5RKGAkPrIacEmZTROxyoz7IJr7YBQrglBMrlQShX/VgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e2CkzZJKe30C/4zhTpV/s0opW64KpXskbIeaCQWJWM=;
 b=m3jOeFAqiGLy8n1NcS6xiWWJSmgb3LdtYtmtEz+DJT+Ze0JQz5+Bd7THqYafm8Dkxz/HeqPGOUJ7JBtHWHEhGNLRfuTOky88tj4yCfnF8/rV8HxGOPvc6zsSp1OaRQIOpw2Ybjfib81DiORiShE4Dmsn7XqMf99Odnt2lezHznNRQcOCM8c6ZOFyGr9aShJE7HxQ5qHYlVq7GD2Tx+43Qp9Dg6uf2UFNoc3heMqvJBJ0d7O8LRSnVVpLVuC2FxTZ1RzzO3SA/PApY+7bLWvriCVt1rmPQ/Nf8TCAmcSnVZxzgBqChzwH4zpgQEuAjlj/xHMIHGG3nddKy9RbV8AetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e2CkzZJKe30C/4zhTpV/s0opW64KpXskbIeaCQWJWM=;
 b=VSNCd4CP/XzJwsjgJxyhR5B5KJ75k5A/3MfMrN2XP2CS6+TuHdPF2OGVzS4A4TRCgVvwka9fyecN3q9NQ6iRZY4osMpis+O5mV78DyOqlO2o4YOk7aghOPgYTc4QJiCAxsikohNB0R/TNe3aJYbmr/LIOuge/xu9DpmTK12ZSks=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 03:56:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 03:56:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable tmz on renoir asics
Thread-Topic: [PATCH] drm/amdgpu: enable tmz on renoir asics
Thread-Index: AQHXMm/o3O+/xpcmqUmIq9j8zC/r5Kq2hCcy
Date: Fri, 16 Apr 2021 03:56:58 +0000
Message-ID: <MN2PR12MB4488AE87DE25A7319644EDABF74C9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210416032230.2681740-1-ray.huang@amd.com>
In-Reply-To: <20210416032230.2681740-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-16T03:56:57.853Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bb843a2-f87b-43b8-9b17-08d9008baed7
x-ms-traffictypediagnostic: MN2PR12MB4519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45193A6D47EB98F6DF5953DAF74C9@MN2PR12MB4519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32FZQ9wba5IFB/NndedR1OwAcxft7UwtvoLeruON106jSRMgIJtL/E8cFLgXTPiekJq9WMaIfls5MixvtdoxW1Yo7CkW2VDvfdHx9CDGZYMnQ2b21Sj5fWMegTv2hDAJdLP1iO/oMrIjo+vWyggmnVc1UTxZVhIZtiWR56YzUsK0WMt1ljCA2LV2hHPMBmtfiRJOxU+NlAatnJR5kwrj1uMH2egSbMcnHXFacmNDcsySxHKHfJ+5YxVDpZvq+ap0YfztGkb1FqRy1vZP6OoU4ej72uw1BaAzewEqWCbjQll1Cgt1uwPDEDAlLuhK6ch2eeSgilvmRNpGy2fCuVuZ/cK+41ui9yQOS1Ch1YvMYAlWdqQVGBgC+EWlgtlwS/yuM4u0oewvrXz27VjLOIkuz55jl4FXaT0IfFxIX+z58Uv0mwJQ55XW51pUDd8dUqmQECXwGkk5djicrvQe5RhI9vFZjIATVrxODhuaukpXtWxzwYFnhwflLo5XBY0sMmZhCG/rVYsBOvd15RArbkfQbsRfvujLF/demy+uh2yIWugeyc5TigZPCGrzSpW/YKxtACmZnD7Nwsxlrslw3/9N+Hg7Dhh03vLPdb7WWMy2kFM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(2906002)(83380400001)(186003)(9686003)(26005)(8676002)(55016002)(71200400001)(8936002)(122000001)(5660300002)(66556008)(66446008)(66476007)(66946007)(52536014)(478600001)(19627405001)(4326008)(53546011)(6506007)(110136005)(38100700002)(7696005)(86362001)(33656002)(64756008)(76116006)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M5vueRGxy9Bj46oaHmtiypYR6MtAsPOBqkduBL3Ccsf6O2MbpYGdzFBjfWA1?=
 =?us-ascii?Q?bXcPE4KGPEgEIeSWMdP4g5fqXBh4OmVEH4NaqrX8Op1MxH6SE2C8S6GyRVnq?=
 =?us-ascii?Q?WkMjjxbjMtiwzORsE0RQ1dJS9HuA1QwsaFE7oM5rPsQjfdJpGv+Acx1H055B?=
 =?us-ascii?Q?tcCcYmdVEWwu8Fb1fB2Rbk7riEMQd7ARMY8xI2aZeobV9rlA1fefd2XMUGbT?=
 =?us-ascii?Q?/dsgjV1JSklOk7aUyDc6LeEDDs+0vWzwY1orWE5AChBo/vAS0wwbkaGijWMq?=
 =?us-ascii?Q?40jlpuO5G7szS2zf3kZ+C0Oayqc8BsuUokmAUdyVJrDLDQ5KRuBKyWB2BCAL?=
 =?us-ascii?Q?dPgNMxMVBLHEO6SD13VUdolkYenYqEAu7I/SlrgUJTEe/Vzfud+CQkOQm1sS?=
 =?us-ascii?Q?aXShVBXDUeM1TnK6YFme38r0oXp7cvSDd9d3TQrOpf/B3+yGylDSnMxVW6WC?=
 =?us-ascii?Q?2ephVyI2h1M7JgR7wWNdD+1urf85Rj8cs7ENCbH/44iMdy9eI1Gbm5OUmLKU?=
 =?us-ascii?Q?fzyulKKAT6i91D9Tmzz9GSgw4lJ1y22nc2YwRq0vZKAgcc9loZOjcrVHLwRG?=
 =?us-ascii?Q?I8pjSVhAVqDYwMtXIFDucHoAAeUNnBMyaXO/sVzlx5YDZHe8dr7rJFWcNGbC?=
 =?us-ascii?Q?ybaVvQBCd1Z1c5ZJ8UFhCXsrn35sIUagsEAw83m3YSslJFz0p8ugO8KTl0Vg?=
 =?us-ascii?Q?Yc8VvQK0GHJGpMhThctCaMx5DV3g8wmGiSdzRQ8pBY26KU9IHy3/iA4JyWOU?=
 =?us-ascii?Q?/eoHZg+bG7SVlEJEe9JAcM8mgg3olvSeIFydIM4fTvCY+sUAHXKK+wgrJZeN?=
 =?us-ascii?Q?SHJeQndrUAJKsWAFB6V2J10qfWSUNYZNjoclHPmPd/x8rHqTkZ5dZO/Ik6Tc?=
 =?us-ascii?Q?Ps554bCLAo+Qsc+Oe8ED9JU1IdfOVMLgfXVo8pvRjm+IRuYMqGtIAP++9jMR?=
 =?us-ascii?Q?iMBAj1UyAYPQihAw1naDqGryOSNYHZwB2mG+azvuD2nwYMeX7BEkgrBkX0dd?=
 =?us-ascii?Q?w6M6DSRNwFLi8cFuUELdYHvuN/7Kp9mW/Dnubd3jg+JxOImfvH4PPXQfXYd5?=
 =?us-ascii?Q?mLvHitxwDxvzw+N1ytE9XBLj1R0FREGsUSSHSo7vvS+9U5bG2GnogKZUbaSE?=
 =?us-ascii?Q?ElOZV7dc4Jj7hjiDM/FfT5pM1hD2yeMpoqRzfSImEk9+09i3TKF7SMIdE4Nb?=
 =?us-ascii?Q?RTT8owXEE021yOYKwAsd5w/nsec7dHK69wc5dC1Cmr4R5rhzTTJxSXfe4f0O?=
 =?us-ascii?Q?JhrYdyMrdS8hi04NV0LN+Vx+TRJLlsMITdPOb94n5tGfLaXSJEBiAE3EvgCJ?=
 =?us-ascii?Q?mXQZv4vBE+wm4MY9zihHObSd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb843a2-f87b-43b8-9b17-08d9008baed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 03:56:58.2997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hq9pfzXMY5w85mBE0ZLFP35ORQN+7OLsyey2wEVGags04LExhBAfRLXWC1jU0ddS8BDdLez0F+qmmAQiZLSaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
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
Cc: "Yu, Lang" <Lang.Yu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0354024755=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0354024755==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488AE87DE25A7319644EDABF74C9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488AE87DE25A7319644EDABF74C9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Thursday, April 15, 2021 11:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Huang, Ray <Ray.Huang@am=
d.com>
Subject: [PATCH] drm/amdgpu: enable tmz on renoir asics

The tmz function are verified on renoir chips as well. So enable it by
default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 1197f49eda18..c39ed9eb0987 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -487,6 +487,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 {
         switch (adev->asic_type) {
         case CHIP_RAVEN:
+       case CHIP_RENOIR:
                 if (amdgpu_tmz =3D=3D 0) {
                         adev->gmc.tmz_enabled =3D false;
                         dev_info(adev->dev,
@@ -497,7 +498,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
                                  "Trusted Memory Zone (TMZ) feature enable=
d\n");
                 }
                 break;
-       case CHIP_RENOIR:
         case CHIP_NAVI10:
         case CHIP_NAVI14:
         case CHIP_NAVI12:
--
2.25.1


--_000_MN2PR12MB4488AE87DE25A7319644EDABF74C9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 15, 2021 11:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;;=
 Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable tmz on renoir asics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The tmz function are verified on renoir chips as w=
ell. So enable it by<br>
default.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
Tested-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 1197f49eda18..c39ed9eb0987 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -487,6 +487,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_tmz =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gmc.tmz_enabled =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo(adev-&gt;dev,<br>
@@ -497,7 +498,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Trusted Memory Zone =
(TMZ) feature enabled\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488AE87DE25A7319644EDABF74C9MN2PR12MB4488namp_--

--===============0354024755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0354024755==--
