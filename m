Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA046C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 23:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCD720878
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 23:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V5b7j31m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCD720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36066F3E2;
	Fri, 16 Oct 2020 23:28:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E286F3E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 23:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH9UiTWyp5cFZ84hXqiK7eiiaOfm1F4Sc5dzlKXp8aBW1Y82Xh8JjRlnaqj11Qm5jBCo9xb/MpBYRuEv45/VLV/k70zlmD32rl8SMgVTpDgRDAgsRZWOQfauclEso2kG474I4n9VCh/rIH3VRtEC7I9Ro9RpX4zpl7zgOVxHKntxr/rby4AAI9IWvm3DiMVrW52jlcV3vehWfMwblZpNjZl+KnvLNqPPXGmSMWjtsbMlkK7uH4pgRGLLSlPw5niuBKuaIhDbTeFCrENux0Z5mWzz4kH04PMMI60m2G9oIoyyHYI3ZWeno9Dq9W5+pu5O1WhiqcFd362D4ExwI0aIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+zNni6Z/kdvhSr76wSi4T/LB7RJdOL+lY/MLOdC/r8=;
 b=kAH1jZMjOx6z0O6LJC3OT+fvMOUpUYa+sXvi0aE38DndeDvJ8Lya4x2X9JeZUvu/gEG4o/IgTUG8gvPhRTg3XqMpIxSqt9eY5IvOJbpU6kMC6k1I6i6cG7OVhVLQJw+Ci47IBMXmYM5de4rW8YvGQ+w73tgLDrpPBoDjo7etNy5w1nKhS1XuOQN4bPcImMzR91/yDg/15iykhwMpSqVI5QrffHHn2Dk11crWiyYablfasMlVNG8ViwUUFMF7MG+2RXlzJAqPiQiifz5CJXtD2laCjnJ6e4/qvTRoHJCaVzmRWRw0lVU7HMMTeEEz6lWGwYYnaqS4NRH//dJoilnXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+zNni6Z/kdvhSr76wSi4T/LB7RJdOL+lY/MLOdC/r8=;
 b=V5b7j31m94PGaji0gdSkNcy7Jjx5hX809OETE6j1KaVFxM1ApUvPy3vcDU4Pl8X6hZpVB+X65j3ysZ9mdk45ULaL0yljetzw5PP/dF9qPNxZr2r5hzK81sj11o9hIWMnUgfZiKccNKJKpLNehhQHUu/UksaGcH7VqEOtd+r/K6U=
Received: from DM6PR12MB3132.namprd12.prod.outlook.com (2603:10b6:5:3c::27) by
 DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Fri, 16 Oct 2020 23:28:22 +0000
Received: from DM6PR12MB3132.namprd12.prod.outlook.com
 ([fe80::7903:c323:27c8:5fcf]) by DM6PR12MB3132.namprd12.prod.outlook.com
 ([fe80::7903:c323:27c8:5fcf%3]) with mapi id 15.20.3477.024; Fri, 16 Oct 2020
 23:28:22 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable VCN PG and CG for vangogh
Thread-Topic: [PATCH] drm/amdgpu: enable VCN PG and CG for vangogh
Thread-Index: AQHWpBOsa3eLhjLSvEunvMmv7QS5tQ==
Date: Fri, 16 Oct 2020 23:28:21 +0000
Message-ID: <DM6PR12MB3132C2E22D2AB1A549FD1B5D87030@DM6PR12MB3132.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-16T23:28:21.747Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a4b6063-e157-4b01-7bdd-08d8722b2c0a
x-ms-traffictypediagnostic: DM6PR12MB3227:
x-microsoft-antispam-prvs: <DM6PR12MB32275FC39B866CFB7464532F87030@DM6PR12MB3227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZkflEY3xt19O1Srd7xn86opQnW9hb4p1sn2SsMLn8s0l0AWoPTYLXI5rF4co1yw/kGJKTjNDyjC1/zXfwGSFC7HJ0xqHQfZAdR8dYgZQi1T/8bHvoHIN4j+QJ0Ck/MlYmKb4k3miPpAHYGbjg7CNI4k0GCl+6rg5huLyt2IgG2Y1g556DMlueuICjkJ3Tbr5s6Fy7X3Wv2l/c5DE1ywPbZ6HLNNl1N0jR/xl/H6LOEpH4LQ8n83LyGsSRGSl5T7Y7XGdQ3NPwXckwviZKYeIVl2/kH3uujy3LAOOdsPTfCGH2Eff+XSWOCw2YLYO4G67kMhKj/Qdlnya2gci1mwWAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(7696005)(71200400001)(52536014)(6916009)(55016002)(9686003)(6506007)(64756008)(66446008)(66476007)(66946007)(19627405001)(186003)(66556008)(83380400001)(26005)(33656002)(8676002)(5660300002)(76116006)(8936002)(2906002)(4744005)(478600001)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gfNyqgi1PM+CXGDvYMoT04Nax7TOlfStS+jQ3pbnAN+1c9hpBVSjzjCFzfolC5T4kWQwZ4chyxy6Rx1z+B7roGdR+r1T4XqQe30BHkD3MwbrHzUHV5tkXQqBEm1NwA0L2NMwSdwkJZ/+bTuBKtkOP5boiy4i4h6CqaNhQTEsI/rZSIUW+XytRlUKsjS+bsh0O85KsHxFg2PlSLdBCrIaCuU4UAPQMlXSp6LqOQVHRk5cmc6gjM9ro09lS0UveAlxKlO0+SmgoR7YcuAUlVZhyiauqnLC6SeAkFQPWLDB6rJGUcCqSoT3MAjswqkNghGjerATcPpB6/O3yhx2pFNvujTelGv3LQgh9yjSv/Y9GD4XWn1W5pX5Gz2hec/JtcrqHVlxPRgJQ6L5vpudkuIrl8+I/ijASCEczCHN25YFDJ7g7tTAORnsd7YkEwv7koD6nqI26zDtqLAODjTwXNshdj7+2TB27r4BBitKY6SnWw5h/YjGXodAMZvO/y58mSiZWKRYE+/OsD0M4CK3le6gIiQfOp8ZnTCVv/Xvd/eA6k2N84LhNyIRqIFjnWVC93ckGq4NSQ7usJG5YO2GO/X6ECjCtTvP+lCgx6ZFWI1pmgJaCNzykMp10ftAvHngvFMbz6mZ8KsWB0DCG6RXyY0xcw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4b6063-e157-4b01-7bdd-08d8722b2c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 23:28:21.9830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erNdcrp4uTcaWwdnhqINtcYD1uLlvzdpG5AWdY5arIacHhrw5BNhFJPAufgAq5AS+Ylafb8Ha4eRJ6Zhvu/IYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
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
Content-Type: multipart/mixed; boundary="===============1850570895=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1850570895==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3132C2E22D2AB1A549FD1B5D87030DM6PR12MB3132namp_"

--_000_DM6PR12MB3132C2E22D2AB1A549FD1B5D87030DM6PR12MB3132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Enable VCN 3.0 PG and CG for Vangogh by setting up flags.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 4b1a4acb60d9..ce787489aaeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -938,8 +938,13 @@ static int nv_common_early_init(void *handle)
  adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
  AMD_CG_SUPPORT_GFX_CGLS |
  AMD_CG_SUPPORT_GFX_3D_CGCG |
- AMD_CG_SUPPORT_GFX_3D_CGLS;
- adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG;
+ AMD_CG_SUPPORT_GFX_3D_CGLS |
+ AMD_CG_SUPPORT_VCN_MGCG |
+ AMD_CG_SUPPORT_JPEG_MGCG;
+ adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG |
+ AMD_PG_SUPPORT_VCN |
+ AMD_PG_SUPPORT_VCN_DPG |
+ AMD_PG_SUPPORT_JPEG;
  adev->external_rev_id =3D adev->rev_id + 0x01;
  break;
--
2.25.1

--_000_DM6PR12MB3132C2E22D2AB1A549FD1B5D87030DM6PR12MB3132namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>Enable VCN 3.0 PG and CG for Vangogh by setting up flags.
<div><br>
</div>
<div>Signed-off-by: Boyuan Zhang &lt;boyuan.zhang@amd.com&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++--</div>
<div>&nbsp;1 file changed, 7 insertions(+), 2 deletions(-)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c</div>
<div>index 4b1a4acb60d9..ce787489aaeb 100644</div>
<div>--- a/drivers/gpu/drm/amd/amdgpu/nv.c</div>
<div>+++ b/drivers/gpu/drm/amd/amdgpu/nv.c</div>
<div>@@ -938,8 +938,13 @@ static int nv_common_early_init(void *handle)</di=
v>
<div>&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |</div>
<div>&nbsp; AMD_CG_SUPPORT_GFX_CGLS |</div>
<div>&nbsp; AMD_CG_SUPPORT_GFX_3D_CGCG |</div>
<div>- AMD_CG_SUPPORT_GFX_3D_CGLS;</div>
<div>- adev-&gt;pg_flags =3D AMD_PG_SUPPORT_GFX_PG;</div>
<div>+ AMD_CG_SUPPORT_GFX_3D_CGLS |</div>
<div>+ AMD_CG_SUPPORT_VCN_MGCG |</div>
<div>+ AMD_CG_SUPPORT_JPEG_MGCG;</div>
<div>+ adev-&gt;pg_flags =3D AMD_PG_SUPPORT_GFX_PG |</div>
<div>+ AMD_PG_SUPPORT_VCN |</div>
<div>+ AMD_PG_SUPPORT_VCN_DPG |</div>
<div>+ AMD_PG_SUPPORT_JPEG;</div>
<div>&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x01;</div>
<div>&nbsp; break;</div>
<div>-- </div>
2.25.1<br>
</div>
</body>
</html>

--_000_DM6PR12MB3132C2E22D2AB1A549FD1B5D87030DM6PR12MB3132namp_--

--===============1850570895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1850570895==--
