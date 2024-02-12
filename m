Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597E6C48297
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 16:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6654C10E21E;
	Mon, 12 Feb 2024 16:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QREQMKYP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E38B10E21E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 16:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkCYVvxKYoeDcbWfVnP55lXwtvJFCQ+dY14hBc2zloIbxQQeIbEamWB4ykPqDA9OwCUnJcCh8lmCukmp4szoDGBSwR911X37qktQDlm73JRKE6YoHB2ljPmP/UArJU7UI0m0v7R3f0wB1dCBPUh73u4E0L5ZNl12DatQZuK3Y6mHz91grxaEwDVE/8eNAuAaX5dFFpTV/9W/rtZ5PCplksZKMb/w0PchXJnJMfijcVLFP5smdhas9F0/VzJDclVdiqym1SvsMVoAd+k6MB5r1pkw/JIHfF5DqBz+Y/+NwACEEYlfp323Szw9B94g6E8ylHmT9fAJ4RkGepQ+x5DPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuRKT6Ifn2k5PYgSoOrJ6jSMiiRK4Q+3HPPBP9u/UUw=;
 b=esVOJLkSq5YLD94drexAQBrpbKFGla/rIuc1oU09eUAnP+XdcMbqUQpPXr/y9h5UJTEwiMWDZLAljAWVeXPS/iiZFxe6XhalqSASELZqT6P0Q8v/G2eSkCKtfkzpiI5dh3HfEcEEQr68zMcunc9sCmSWfVu7FGO24IjzKAU6oX2NS3LG8OVkxJuDwmI+ANqVYsa9PYf8w6nsfFNKaop4jDsoXav+fGzA+MHSuldrWDWyey6ZW7P6WvnFbz01ybtfspzLYWrrVJiOyPyY6OwfTZBR/Ik0hIwcAkkkS/nieHyTe2MCxIf+W4EhHAOtR/2BjzE4cqKR+8RWygwtWshqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuRKT6Ifn2k5PYgSoOrJ6jSMiiRK4Q+3HPPBP9u/UUw=;
 b=QREQMKYPV0IudEkdTkjupfcMoEY9DkELutCG94+XS65s3aZngYT0acx/tYedAnmzaiYb+KGbsC4AgXlUDB7+L91l7yW4MGhz1/a0nRQE3g70POPhGDu8uRQBxVs8jnlRqsa23Wol/RhUOZ6oSC8L6MmfwvqyWx/7JEEn0nGMNns=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 16:06:48 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::2cf:b226:30be:d982]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::2cf:b226:30be:d982%4]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 16:06:48 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu/display: Initialize gamma correction mode
 variable in dcn30_get_gamcor_current()
Thread-Topic: [PATCH v2] drm/amdgpu/display: Initialize gamma correction mode
 variable in dcn30_get_gamcor_current()
Thread-Index: AQHaXcj2spDnuA9PiUeYFeorkSWUe7EG31F1
Date: Mon, 12 Feb 2024 16:06:48 +0000
Message-ID: <CH0PR12MB5284D2A6B36DB61492907A088B482@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240212153347.1175416-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240212153347.1175416-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-12T16:06:43.798Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|LV8PR12MB9183:EE_
x-ms-office365-filtering-correlation-id: 4c07c880-a5a2-4a74-18ff-08dc2be49e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHQCgVAfjChCVpUxQuveahj3Bm2b47czG2gR3lLy2GIl6SNmqC3zd8GW8vSeQNg/ZdflyaaGw8hD9/NCu6dgdKgwB9LusI1RRkZlCGIblLshkIl38V5z76cRGJtg/DF36Kg1zhnCqwK9XLJU8LVty1Jh8m0FzZgBLJncOut4WolvlLA23xvyMKwyDGIznc38z3OhPCvBLkV8ARnQcdfp8v7NHwDaPwc67nauNtrbk8PHiUdNBvl6tezbZY6uzymkdwdQFunmwYNXJGmEFqleRHvY+7E5Fduqfq2y8oVT9jlJqIYmo1GdPkn4FZg6NKyvBquOEU53qJTW1FrclWgQIMyZ80Xnlmy3JzmUNLUoype0GJj3WxLKvff5JQCc4y0sG++YRwJByZiWjFSFDTynhdsXckGB1bgy1s11irq/No0hXxpsi6XpIypo50oJoDKE1gW6B8cqJIsgO2LgVvXyKjhNfIv4zo48XYzOYV04tiJO1d8I97z0Ac4Cq9mhbIUrxBTCvkrMqXAWuOXRnDbG5bTqtjXVKDOGS4C3LP8uXMMTyB3M9utFeuTOOzyh1FoaTpXaqzTKq3dOSwDdzip1dBxNU1LIkLn59K8kVRvoVxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(19627405001)(54906003)(6636002)(316002)(41300700001)(55016003)(2906002)(66446008)(8676002)(8936002)(66476007)(5660300002)(52536014)(86362001)(83380400001)(66556008)(76116006)(91956017)(66946007)(64756008)(110136005)(4326008)(71200400001)(33656002)(478600001)(26005)(7696005)(38070700009)(9686003)(53546011)(6506007)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FGRfVE+45PoLTd/HFsrrysVNG78cWJwEWPLTHdiEI0JYETApOIDT1hhunlU3?=
 =?us-ascii?Q?lhE4Cc6SbzljBzjAXsxkoJPzbSZhNhGOqw1bheKroSB0RY93ypXNFATw2Mw+?=
 =?us-ascii?Q?IzoYkal9Gsm1ld2GSFpTNRNtn3vxeyUKBmISBQfcyE71qEhOPSmrodO0IyuS?=
 =?us-ascii?Q?NjLtjaOw+YR9XNs3zddLjQByiQj9qLDqk1EtQZ1RpmAjfOV4C9Wz4GEmAFeS?=
 =?us-ascii?Q?4ZkXO4gkZBWdIYNffKl+JFBmT57Tk/H8DQ/BIrK7MZ+r+zC/B1pdMtC8FMXv?=
 =?us-ascii?Q?F0e9faErx+so22kvKgZ5HOTEQOL/m1khrw6sf5AoRcHrG6KfoN/0VCz5Pnp4?=
 =?us-ascii?Q?FvndI68hk+wrdVi+/CnJNZb/JAdXMYvuNoErELQ3RgNh64AMN4vzAb/UKGu6?=
 =?us-ascii?Q?PuXrp2hBe29PosixeTEM8aXEixFiFqYTFS6Q5FUgp+Qr1tS4DlxKZn86pqlI?=
 =?us-ascii?Q?MEQdPEI3C6adbC3MCAcG6FvANynPRC3rhZNsVAvPDC2/+XVPy96FksPNMcu/?=
 =?us-ascii?Q?rxqN7TWXhMlfhu/FiIyzgM1KaT4RIY7osThsumHF9ykI5aYRi2gXss/eYquw?=
 =?us-ascii?Q?rhqdDk4dAbIqC+ntw/wEVr7TsQIHxvXtfgWoLnaxtozcH1yMF5u9uUYsPZxO?=
 =?us-ascii?Q?2oU1AxQm5X7Wo7XYMKIVUww6c1k0TSgoKrqfTy4Sv4j4SvXdjLSryobQJE67?=
 =?us-ascii?Q?yEdinNw8F5ejv2/VMcr+zAnRrEFoROIvPavqsn14455TqNGYV+KO2UVWksL3?=
 =?us-ascii?Q?1Oon7GrM07tZhZpbHmU3H5LEYJyC/00EVJlbiWq6nFOsRs5Ze9vMqE4rf+U3?=
 =?us-ascii?Q?CYxgxXsb7i/4Qq6HyYdZb+91j0Rn84QOPwQv54pTYpeRm5LjQJLs4yXXU9tr?=
 =?us-ascii?Q?B2rErEBO6RQlYPNr1qkpYR0Bjah1QW+mtx+vJpopEdYj5HAzT8nhgqNa4XwO?=
 =?us-ascii?Q?Ub4A6zDTQFtrdCk1EnHenSrD19NiWbQW+ty0iTB40TyKfN8eX8UvAYeVlIvg?=
 =?us-ascii?Q?OxHyd9V9mTnbHMsgWvL252DcuBeSobg+xIcYlJQWdMgyxfXY3vx3VRAojGYM?=
 =?us-ascii?Q?suxXs0e1VVVMRB58w/2gkcuzBt/PWxvicUlVKzIaUSvg6wU4KXtlomWeXEEA?=
 =?us-ascii?Q?fYZzLthtxWJKdoxYcfxZhTRrsycAmMCVl2zSewzs0aPhzOYGduOEFu/E8HgX?=
 =?us-ascii?Q?P4OBlUmdARlm4G1NJNruv4iFZzP3nFpcIy2D3IM8ctANrDdAd3HMqpZL87da?=
 =?us-ascii?Q?MU2H8YXBeRhdA7lPd0X+FE7R1SrMq0pmPgPtC3IWWDai3zVGNRWppSfZM4PW?=
 =?us-ascii?Q?J5dWw3Q5nrpTAbKDr+pEfy4FEd8Hmb4t7UfhPbIzTFAeMiz01FcI5HP7Hqu+?=
 =?us-ascii?Q?JdQDNno3fgRdiO88LcxNnTS7ucpXE48rOINK81392BkhyTvH46Y6HfbEgkRW?=
 =?us-ascii?Q?47bJY/HopVnnqiw0tdygRbaqoVp59vMppd4sLJtu+NmLiwWL8nCBnZaXyJGh?=
 =?us-ascii?Q?ZHKCkOfrLofYH+9Bae4eh9RjFfk9Ct6so2qjZuqUYpcTgbJgepcHJC+8x0nx?=
 =?us-ascii?Q?07U9txIYzioWut/PK/w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284D2A6B36DB61492907A088B482CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c07c880-a5a2-4a74-18ff-08dc2be49e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 16:06:48.6509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slShGrRDYLX3PSWr2d9B1z6EbMWFBvPOYOp3Wnbmh77HagPNIxdz3odqGwgGzmn/mKJ8iugxDacjHwHR+FqsvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
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

--_000_CH0PR12MB5284D2A6B36DB61492907A088B482CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Monday, February 12, 2024 10:33 AM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Lakha, Bhawanpreet <Bhawanpre=
et.Lakha@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Li, Ro=
man <Roman.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu/display: Initialize gamma correction mode va=
riable in dcn30_get_gamcor_current()

The dcn30_get_gamcor_current() function is responsible for determining
the current gamma correction mode used by the display controller.
However, the 'mode' variable, which stores the gamma correction mode,
was not initialized before its first usage, leading to an uninitialized
symbol error.

Thus initializes the 'mode' variable with a default value of LUT_BYPASS
before the conditional statements in the function, improves code clarity
and stability, ensuring correct behavior of the
dcn30_get_gamcor_current() function in determining the gamma correction
mode.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp_cm.c:77 dpp30_get_=
gamcor_current() error: uninitialized symbol 'mode'.

Fixes: 03f54d7d3448 ("drm/amd/display: Add DCN3 DPP")
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Roman Li <roman.li@amd.com>
---
v2:
 - removed the below redundant code (Roman)
         if (state_mode =3D=3D 0)
                mode =3D LUT_BYPASS;

 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 54ec144f7b81..2f5b3fbd3507 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -56,16 +56,13 @@ static void dpp3_enable_cm_block(

 static enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base)
 {
-       enum dc_lut_mode mode;
+       enum dc_lut_mode mode =3D LUT_BYPASS;
         uint32_t state_mode;
         uint32_t lut_mode;
         struct dcn3_dpp *dpp =3D TO_DCN30_DPP(dpp_base);

         REG_GET(CM_GAMCOR_CONTROL, CM_GAMCOR_MODE_CURRENT, &state_mode);

-       if (state_mode =3D=3D 0)
-               mode =3D LUT_BYPASS;
-
         if (state_mode =3D=3D 2) {//Programmable RAM LUT
                 REG_GET(CM_GAMCOR_CONTROL, CM_GAMCOR_SELECT_CURRENT, &lut_=
mode);
                 if (lut_mode =3D=3D 0)
--
2.34.1


--_000_CH0PR12MB5284D2A6B36DB61492907A088B482CH0PR12MB5284namp_
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
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Reviewed-by: Aurabindo Pillai &lt;aurabindo.pill=
ai@amd.com&gt;</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Monday, February 12, 2024 10:33 AM<br>
<b>To:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aura=
bindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Lakha, Bha=
wanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt;Chia=
Hsuan.Chung@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu/display: Initialize gamma correction =
mode variable in dcn30_get_gamcor_current()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The dcn30_get_gamcor_current() function is respons=
ible for determining<br>
the current gamma correction mode used by the display controller.<br>
However, the 'mode' variable, which stores the gamma correction mode,<br>
was not initialized before its first usage, leading to an uninitialized<br>
symbol error.<br>
<br>
Thus initializes the 'mode' variable with a default value of LUT_BYPASS<br>
before the conditional statements in the function, improves code clarity<br=
>
and stability, ensuring correct behavior of the<br>
dcn30_get_gamcor_current() function in determining the gamma correction<br>
mode.<br>
<br>
Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp_cm.c:77 dpp30_get_=
gamcor_current() error: uninitialized symbol 'mode'.<br>
<br>
Fixes: 03f54d7d3448 (&quot;drm/amd/display: Add DCN3 DPP&quot;)<br>
Cc: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Cc: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
Suggested-by: Roman Li &lt;roman.li@amd.com&gt;<br>
---<br>
v2:<br>
&nbsp;- removed the below redundant code (Roman)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_mode =3D=3D 0)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mode =3D LUT_BYPASS; <br>
<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 5 +----<br>
&nbsp;1 file changed, 1 insertion(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c<br>
index 54ec144f7b81..2f5b3fbd3507 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c<br>
@@ -56,16 +56,13 @@ static void dpp3_enable_cm_block(<br>
&nbsp;<br>
&nbsp;static enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_lut_mode mode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_lut_mode mode =3D LUT_BYPASS;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t state_mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t lut_mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn3_dpp *dpp =3D T=
O_DCN30_DPP(dpp_base);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(CM_GAMCOR_CONTROL,=
 CM_GAMCOR_MODE_CURRENT, &amp;state_mode);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_mode =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mode =3D LUT_BYPASS;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state_mode =3D=3D 2) {=
//Programmable RAM LUT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; REG_GET(CM_GAMCOR_CONTROL, CM_GAMCOR_SELECT_CURRENT, =
&amp;lut_mode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (lut_mode =3D=3D 0)<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284D2A6B36DB61492907A088B482CH0PR12MB5284namp_--
