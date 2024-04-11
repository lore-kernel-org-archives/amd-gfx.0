Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084ACC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 21:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738AF10E921;
	Thu, 11 Apr 2024 21:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fFKOQvne";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF8810E921
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 21:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h01dTYECG7IF4Qrx7sQMNraXR2s2jc/XvJZhTbaQCAUQe57XpmOxdT+eLLXhD7dcGnf+z/XFRsmsoilTzDrQnQqa7An2m1eUzwJmaDD1Ycsev2BX94KMZ39nAqCEPoEPvgzhM9MCpyeiwrfEmTJQoi/1KtvkpLB+uDjGDdIw+6z9tZVS/UjvRiXvwLg2kb4t6goJvdxMrrC8Tv6Xs5qKFBFkVJbOo1DtqpKFs72qi+7+vWhsxI11sqeZI9atJKnbUL787s2ybC2wtSTHH4s340hE1RU+m49qIMu/KEZ+TGj37XUiPmOjymx8zYPD61XzF5dicEESxGpNDNvQW7h/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpX6OVgMm7yTaN9BEBPobjMn64WEvI6LbtO3Ub412g0=;
 b=auB0msht2Q5KwHA1Y0vuI2zOpyoTcYBZZdVTFIkq5vWtjGO7g81HWD6BOGsUuINuKuOn3FS+cbXfsZRwbkHc2kXstXjdcZQoWwUYX+VPjdGQRYf2Orllunz6Vtisc/hWMQaHWMFlUZuoBbh0JYIdcS64Wru/GLTZzIADAChZmkA8UtzUXjvZ1jzkarnEHCSh+PP4ZHqejEZip8kdwGYeiY6NcsGHy1RqOmBzIxbzEKBEpo3hYCMUxo7nIoMNNMyqEtihfAEE2Ucep10Lsk98U6+BiToYKZHfU10irJ+cvk228P40q/FPwz5V+7+tyt0Krz9sjCYKc++9Q4PBFQ9L5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpX6OVgMm7yTaN9BEBPobjMn64WEvI6LbtO3Ub412g0=;
 b=fFKOQvneJR4dagSzrqvCpM2H5Q9ui2YL9A5/xiIhQnp+FgwTSzV6zH1BMaFAOanIU9ejkRSrVH5Tx2/MMJPutpP9FPG/rQLISUdswZOcthoUfGRkwfBWDrBwA7HXL5JOieQBaFTgUq4uJBim1vGMt0ARglWuIsoWY70JUGhOpn0=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 21:49:04 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b7dd:b7c4:6179:18a6]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b7dd:b7c4:6179:18a6%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 21:49:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: increase mes submission timeout
Thread-Topic: [PATCH] drm/amdgpu: increase mes submission timeout
Thread-Index: AQHajEMFJb+6SkiIZ0q9gydXbrwrh7Fjm4n7
Date: Thu, 11 Apr 2024 21:49:04 +0000
Message-ID: <BN9PR12MB514671676E697926A1F216C5F7052@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20240411190344.1148610-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240411190344.1148610-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-11T21:49:03.761Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|IA0PR12MB8206:EE_
x-ms-office365-filtering-correlation-id: bc3a9641-9318-44b4-da42-08dc5a7134ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgPwVE/sx8jWGR8GQ/pDoBCdpNvNSzHNyOcJDV69Fo8/109bUYFvie6NsVEZAJI7rtxGZX2JU6wynPdRnAftHTFqLS50ra7w9NliMnSdFauYTdIXLhGEIFGPszGWp587QzaIA0NDFS3SBp3KGd21kE+UH6G3ujlx/09grJ5BTx5PscdMo7uHUlnfdgbyAnSTS7kWmnkmsD93guJ3xajGVXskopmS5UcedqbIcnUoOt6S0/CHwrt3bn3yRXlIOOO0LSzuwjCfRdxq4lAuInIMJQxWva75f3Ktx3ERfw8lED9V5NVf+gtSzBrNzqgYxb48s2M+rirCRl9ikthkXIuEmPRoVb2ZKtJI69G39j+uhs29BJQ6I8OnQeEjCXFI9YtcHcsID4KK26nYgezsKCp4S9H7pEfg4mEv4dJyMKTI0CtDHmDBFO6pe2bR68FTb6+UqZWYY5qQo8dIqKeaBzOr3ljhNVQhQ04dPwhcrWGSRX2MydX/i5EOl5LtVjaowfAr+SAaWnyEVNznjNaiOCxYFehMKBcOHhTFSNcew5S5gLnBFIl8M3zaghJYJ7dyTD4b+Fs6ChkGFHTTR2tiUbvz7PTy/9O6ogDi8aAd1WfwvEu5Y1RnB2mTi7u8CHUGAQy5OY6ljn9XupGmJWW1FN9jDNQs8P02urGT33zWTHKehM0g1uA16HHo2PAop4pTYCdFrRqmzXR9VpAcdrlMYXPSxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6KXMiHAyvySUDg+8TfFFNOyu76g/Cyiu7e4J8wyADjI9IhyYX7BWQd4g2kL2?=
 =?us-ascii?Q?5DYzKulpTZWOcuDrBzT52BDr14Dv2IX/PQZrkJR5LHuc4e9ftIxdubkGSqgA?=
 =?us-ascii?Q?bwBTuNyDCAT1BgHmCaAX6O3VoGZRDtOObeY4VG2yrmo4WAdTg7uyhEqHOdlr?=
 =?us-ascii?Q?5KizdhvpqoCQyNmqeTf7ovUw+DqmHkv1D2p/i7s3NDQNhZgOkwVO7zsgXDG/?=
 =?us-ascii?Q?yasisBusuT45i12t1rvZNWa5eZT8GiKqyKaSi8R1WNgA4guE/iXBe2x9A8Q7?=
 =?us-ascii?Q?Jimn1Ei4YlXl+VhLflrAbjWcuTkCioPyBPbSHD4vFP6w67nI2kyn8nptqvXM?=
 =?us-ascii?Q?wRTxJ+g/wmg+eOhaGf2W4KTE/mB4MMhuWyazMgie1xNb3mBMixhcduXlTA63?=
 =?us-ascii?Q?/4ZMb+YeCW3vaiMrmrSVRXnf3aahjUs1we20rQC/XBjXHFzJyfxHNIGECeAr?=
 =?us-ascii?Q?t96+RvXBnbgFgqw7yafo6CfPWM/lNGZDw51M7gTO6XonJFdvG0RPlwNZc7K7?=
 =?us-ascii?Q?8vljpxjQ6R7M+TWHIF87JHjN50IdEArYjJMJ3zkV2HJUoZT1EKmh7oonp7fq?=
 =?us-ascii?Q?QWZo+AptLvPbU89eQ+RtwQxNipCRRQOy8FD15lNW6ad/wqoEjT2TKVN6z/TG?=
 =?us-ascii?Q?YYBVSwhgRvgcfukJT+cCtIiHiDJt5VaPL9NRzM6tx4bqVn+/c5o3q8XBSERJ?=
 =?us-ascii?Q?PVY+nzrJfOjOe9LC2+G7YKVNiqlE2lt7sFni0ho4zDMFt6ULPM70u47L5Cly?=
 =?us-ascii?Q?qNyt0Xn8Czi43gdzsuC4oOYz+SRj+u0lHQz9e+M2Elcjq5xWI29GtNRlg74+?=
 =?us-ascii?Q?m7dwDkEGJ8YAXydo6hZ6lvlTm0ypOm7Y+EIq4MpdeaVNXLCXiEzNXXO8OX0h?=
 =?us-ascii?Q?z02PXorxOtZh7qDNt6DuBr5Lp0R33ryqjG0SsjBwTzrgRA0RRztyq+rPUXbN?=
 =?us-ascii?Q?ahLrANOUe/Y3GYEU0CGcDNFnM5vSvhTxWyLPXo3Z3H+9Okx8eh2NgJupAn+Z?=
 =?us-ascii?Q?IPHBJWpQXjIkxZEDlzKOTi3jtliaRjVoBkrgi+BX3f7Ee/DwYsM56R9D2b20?=
 =?us-ascii?Q?zEjaXvrVvzFZiwC50Z7PP2ukWvxx/o/A0RVHGWpKujKaQZEqBjqlH/GMscFM?=
 =?us-ascii?Q?AmoCD/S1WcUnC+3eBxtPqGvfTqdSRrtX+wFHiMxD1Hx7dhHeGBxBx7mVV4eu?=
 =?us-ascii?Q?cbruzbd3l3fN9N2zPna+qUGLi9Hi7u2BzbBwRsVrJa6vok5eLqh4qcVvWSSb?=
 =?us-ascii?Q?PK6BaAmNu/RHtX/8t3Fg5wZ7U9GT8A7ZGMHZ2NPRkAs19qYZZLKpZWaAtT50?=
 =?us-ascii?Q?MF7tkCZXSG/c2KKeDRlMzbisNSFmuarVZQhrBmqdVIZkEQRciNCRJsfOMPSy?=
 =?us-ascii?Q?HfoP/grgE0CmEW+qZK1oq9w7Zpfuaz7zH4wBudztesiynbeYbYahPcRm4hr7?=
 =?us-ascii?Q?cDtT13uRGUtr5Pmg2FvlC/4Ga+5h9SQJzyO3nvHgKDA0nk3xZdwzKvvv2JL8?=
 =?us-ascii?Q?WJ504RDcWtnGv+xB1txH2ECqEFRfPYsq+zk7AUJDfbNdDzzISr/IYjxKYNvu?=
 =?us-ascii?Q?y+YnukjjcqAIHZHfabc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB514671676E697926A1F216C5F7052BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a9641-9318-44b4-da42-08dc5a7134ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 21:49:04.2006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oZ3bL/KltlO4VxDLD5c+F9J4pPU2qaXTBjaKICdHKR77b5YGsnXagn19B1If5hzKtvn4ddQSvfunXi2pELfqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

--_000_BN9PR12MB514671676E697926A1F216C5F7052BN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Thursday, April 11, 2024 3:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Jos=
hi@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.=
Kim@amd.com>
Subject: [PATCH] drm/amdgpu: increase mes submission timeout

MES internally has a timeout allowance of 2 seconds.
Increase driver timeout to 3 seconds to be safe.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index e5230078a4cd..81833395324a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -111,7 +111,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(str=
uct amdgpu_mes *mes,
         struct amdgpu_device *adev =3D mes->adev;
         struct amdgpu_ring *ring =3D &mes->ring;
         unsigned long flags;
-       signed long timeout =3D adev->usec_timeout;
+       signed long timeout =3D 3000000; /* 3000 ms */

         if (amdgpu_emu_mode) {
                 timeout *=3D 100;
--
2.34.1


--_000_BN9PR12MB514671676E697926A1F216C5F7052BN9PR12MB5146namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kim, Jonathan &lt;Jon=
athan.Kim@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 11, 2024 3:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Joshi, Muk=
ul &lt;Mukul.Joshi@amd.com&gt;; Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;;=
 Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: increase mes submission timeout</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MES internally has a timeout allowance of 2 second=
s.<br>
Increase driver timeout to 3 seconds to be safe.<br>
<br>
Signed-off-by: Jonathan Kim &lt;jonathan.kim@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index e5230078a4cd..81833395324a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -111,7 +111,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(str=
uct amdgpu_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D mes-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
=3D &amp;mes-&gt;ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed long timeout =3D adev-&gt;usec=
_timeout;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed long timeout =3D 3000000; /* 3=
000 ms */<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; timeout *=3D 100;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB514671676E697926A1F216C5F7052BN9PR12MB5146namp_--
