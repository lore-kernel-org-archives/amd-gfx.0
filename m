Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC33C54798
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 03:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF7610E08C;
	Thu, 29 Feb 2024 03:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnasIU5P";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1D410E08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 03:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaPZ2IHRXLayaOOdYqRJbDjj71T21OfL6s+FNwl6miRrPOct3hRb5qv0O2pXNZuv/Z1t8GgJaYn/DX1Ge0zUJowKPRc/Nqi3EkaKBsC409Mff+1+Eb37EmPxW3wJ5uYvsPRsNfSgnAeI8x6OmPmWBXEGRoRL8khSGwKi8l4e6wx9ItC2c+eYNLg6YtWaFcCqYtMj8aV1cCLvUR4Qgr5wGHFZMOQDKCeeFXesD0U7dnYD966bFtZELPM1tcfpecb4uOrC0hiYP1+JXRfT1PB5B1EhuJPOEke/ycXp2LPqYQgXPVJ7pJJbRh2QNOriWlFzFBMUSxUKeuQ4KWDxbL+W2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCL3hPuSS6nGNm4UTynvYo/O0/3aqvsW1GON8Y+kAn0=;
 b=WzmdAvNvPm5ikb9DEGAdo1j5IaeUhVdISSNABM1QQF7aeliMly5pj15WrPGSAfOJsTF+bdZ1QotWcEBjNVy0pVGRTKW94WxKKCqhtKWpHXox20QcAsiI9ykaBZnH9KQe4OClsN4gmZ0joUC3xrjrmy7UDZ/J6nJ/iQrZtheFElkEACZM8QZfG6NpJ7VBmaLVxREcp/29jJFG4mbpphoru6o8d4h8P8ZHz+PMMbzXcOKIJasTrxBuoVDT43S9nxmt1YsWedobAyTT4lPNTvflq0qhQzrXQSk/BUFSmmRTa9FaTVo7yIzXL2sIs9jMC56F2HfmBLJyaA9cyKUoL6wkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCL3hPuSS6nGNm4UTynvYo/O0/3aqvsW1GON8Y+kAn0=;
 b=xnasIU5PVkWItqR8+FYVhSl4FNy5OEVWpMKdgCiBGC9MtKY+yJmQ2rC8cBdgK1NWiBV5HKxU2/Zhn0hqnYrunSyPAFfoCRAmvibe7A3+MqyhOXQJKSFyzbKfmSHrzvxaONPwVYEcOaqrAJEoc9RNWcHHWBywVulOY511yh3FTfw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Thu, 29 Feb
 2024 03:58:49 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 03:58:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add deferred error check for UMC v12 address
 query
Thread-Topic: [PATCH] drm/amdgpu: add deferred error check for UMC v12 address
 query
Thread-Index: AQHaasHXpPhb6Yp0zEKZjgUpBtAhnbEgsXdZ
Date: Thu, 29 Feb 2024 03:58:49 +0000
Message-ID: <BN9PR12MB525749A265AD9026133CD186FC5F2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240229034547.328740-1-tao.zhou1@amd.com>
In-Reply-To: <20240229034547.328740-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-29T03:58:01.8826804Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8010:EE_
x-ms-office365-filtering-correlation-id: 981ded9b-d44f-4c2c-eb96-08dc38dabc49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNtQyOPPlz6nc1nxAJdOtMNgtA9ZBgOEZjmkg+V+UGiA8sF7QG6aIbMHHpHEvXRa0K5rYqUBruj6PMiauXlAFQQ2YrzLO974NUvfTC9pAhxZluCi5RNHkHhEyx2LXq0wVWB6I870g31F4nTgdvvkFQwoTAHb5rxXAksO/wWKSrq03dVAFwrUXZF/juIW9qTnWA37u2tmPk+bR7rvTaO8WpZHFZnfl72AVsKu18h5159nh5zqVAnAsthXCgEy9IQtulcytRujRioQdSwEm9+JzAc6uUAN5dF2Yz4HFvH7jMFYB0kF1tqrCFUHWTW1gNUmmcjjIcUAYEFoedN+mbhXZIpzfYHrZcTAIZG2lbe6i8oRIKA3ahjQ/yrCNy975q0fW5lAuAA5fBkAb6ldeA5oYMyPYMA2CJo5FtehOnxtfHr8h3g9MeEyn1uXQA3auF8/lJiid/k6vQcalP53xCp6OjwFoaZQMQHNZatR4YLN2vdVP0XclmtagAidfifhcVhzLxC6yxtX+M89USPEPBIG3SvR+FTeA3IWSNUTGMtke2LawAxWKBSLUmSF5WOA0VEGgm+D/MCG0iZUOp0tw9l9DzHAfd/LJzC5XeWQy9bLv8nqdTTu7LQ6ZHI1SnAnmdFnLFNSc7ApQ63nnS2zr15y4NoMvF7JRT4E+pRr8ddnFs+NCOaVbFAQqlMDiHYKeOSe3czIP3mB1eM2zBv5EfMPxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAbCF3veIFJIP0/AKFfrh5a52dFip5ukEtE6JRsdt2Mf8ULpHetQPaxeMEFE?=
 =?us-ascii?Q?yMWuZpsIhmRLHfiyqjZhOmHbJ/x1GbBCdk4K9GDkL2P8wEcLT7pB1XNq5f9v?=
 =?us-ascii?Q?hQoLu1kvC9WB5ctaVtpp2n7F5IODty8fgASmG9BlDnwc1knRLZo1148MMiKN?=
 =?us-ascii?Q?p4ys3M+mBll++U7U37edtAQQG0YW1kZfr0ZjacnijSJ1zeutsaw9Z9Xp42Rs?=
 =?us-ascii?Q?y3qX1w6Fi5JQ3mXqQZLc6gX7vJ278xiaP9FBqt/T92Broeuy+jxJUkzdVf+q?=
 =?us-ascii?Q?hE8r6tdwTFZgiBb6g/C8wp7+sXEU+hI+sxnSAPFnXqToTv2cG22etLJas/s5?=
 =?us-ascii?Q?Ra/r6jjytaYBeSNRV7ryj+ARzTxp8POYM69N/WRERSgEWHl8xj+p+saBF1ae?=
 =?us-ascii?Q?cf0eIEMQv0KAPtbtFzIg9+x45V635qS6plFU6HCEJylLU6nI9D8e/0w8tqgs?=
 =?us-ascii?Q?1uS7BciQPdOmXQ2RVuRbMjC61KJOednXYFMds1CQNEEY5jZYByRojmVD5KFL?=
 =?us-ascii?Q?RrUdR9kBR2p8xu//iLcssmxYa6EqiBS1omn/6cnQ4uZn+zGRxiMmf2NidRXQ?=
 =?us-ascii?Q?DL/nbTSn4j3Fdm4USnYuq1bZmGP9ok+YeMlAlqW/4PrmssE8iA2cBORVDtGG?=
 =?us-ascii?Q?xgvqPSyVu/Ycel/Qm7tpq7kjBvMvg5u315Iwn7Yf/eTuc1F6CzAVu+GJDV2B?=
 =?us-ascii?Q?/eg6oJ0RFNKWcrK7kWJ9Wd/kVXZLuX87tgIGJqO4N5/DUPwDJfJa1RN3zTfI?=
 =?us-ascii?Q?K1DLOu0e96RP8Bd+/DF/vgPI9XnwKbbUmxHO/yNDn1DR4+WyeaGTxf4kTLBW?=
 =?us-ascii?Q?gUw8I0CVe2OOm7Og6FcISUibRAv9NoY0mZ+OkkRfclzw5+ROezhUv1jdvlTi?=
 =?us-ascii?Q?TtXuy51Z1p/1Cjg/j4eRGQdgN8Oqxex4qoxa+NQGzLPm+gcpMzEUji3d80v8?=
 =?us-ascii?Q?tF/e5yZVvDl8z+DjHRvTwuGHFZSV+fc2f52ZBuLFyTd3FVVGUYwl92uPk7An?=
 =?us-ascii?Q?BKlkCs5S0ciWoVdhW4AmS/U8fAIf4zW4+1cxGV4QZlWrkuA+hm/y9W3bzBFW?=
 =?us-ascii?Q?xgIqJxvVWtFsaJ48uQJW0uS5sZAM2WyVjkye/FVe9IqTBSpXnJDZvsmIZF/+?=
 =?us-ascii?Q?1yjXDce/ZJXEYp8MX69DpkXP7Oz2BHee29qw/shMBm37N1hSvQVbGsPnP9s4?=
 =?us-ascii?Q?6h7YrJRSVa0XK2nIZAZOROiQkE0CXbp1wn6QRECuGywDyJ6h6JGyI2Wygg4L?=
 =?us-ascii?Q?fhPZ/3nWNsYTiK9G6Z3mSn4mbPPJoJ1WUfmPAUlBhexUrml5dwgcLDbJvkdQ?=
 =?us-ascii?Q?cC5xF8nXS/B6O6vVxnjWmM18A65x6f/MNM/h3dd2MbEdsKVvwk26xsg3yffV?=
 =?us-ascii?Q?b25seIVVAiwFzVttk7XwqBgdnp5KMoGf0lPsxq+pn6Sj1s4NtOkAkJVVS/hG?=
 =?us-ascii?Q?ED94W8qeGMj39B+PCWtEJDu4VS8CVBWQyBbxdtsGxYRXHOeXkJGByj2YZ0ic?=
 =?us-ascii?Q?HVwh2wM6WELz5fQPQpvN6YYbNfL606rlyU4B3ZWqToQaFrdZ+txj6u6htE/k?=
 =?us-ascii?Q?KjcDJFjY1MSWqsAqFK3YOLfTgXtitOdGP+hXRLZnYe8wVpYN1/7dlk4Lrr0/?=
 =?us-ascii?Q?TfaiKHRK2YM5REHz/eLWdY8p37Rloh5kxLVZHVGe074Y6pt/qxrzJ+5aFIJL?=
 =?us-ascii?Q?sQ8mzA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525749A265AD9026133CD186FC5F2BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981ded9b-d44f-4c2c-eb96-08dc38dabc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 03:58:49.2220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lpud/iH3UMKC5Ao57gnyiPCQBgZqG9UVSZSXlbcCv3gy+2N4Fqi1WRlnx0GKUAFxgpUz2fLqsM4e9dUs1EQf4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB525749A265AD9026133CD186FC5F2BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tao Zhou=
 <tao.zhou1@amd.com>
Sent: Thursday, February 29, 2024 11:45:47 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add deferred error check for UMC v12 address q=
uery

Both RAS UE and deferred errors need page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 14ef7a24be7b..77af4e25ff46 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -348,7 +348,8 @@ static int umc_v12_0_query_error_address(struct amdgpu_=
device *adev,
         }

         /* calculate error address if ue error is detected */
-       if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)) {
+       if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
+           umc_v12_0_is_deferred_error(adev, mc_umc_status)) {
                 mc_umc_addrt0 =3D
                         SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADD=
RT0);

--
2.34.1


--_000_BN9PR12MB525749A265AD9026133CD186FC5F2BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</=
div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Hawking</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tao Zhou &lt;tao.zhou1@amd.co=
m&gt;<br>
<b>Sent:</b> Thursday, February 29, 2024 11:45:47 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add deferred error check for UMC v12 ad=
dress query</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Both RAS UE and deferred errors need page retireme=
nt.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c<br>
index 14ef7a24be7b..77af4e25ff46 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
@@ -348,7 +348,8 @@ static int umc_v12_0_query_error_address(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* calculate error address=
 if ue error is detected */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (umc_v12_0_is_uncorrectable_error(=
adev, mc_umc_status)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (umc_v12_0_is_uncorrectable_error(=
adev, mc_umc_status) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v12_0_is_=
deferred_error(adev, mc_umc_status)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mc_umc_addrt0 =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB525749A265AD9026133CD186FC5F2BN9PR12MB5257namp_--
