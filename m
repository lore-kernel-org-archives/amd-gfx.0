Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11243C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 18:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9FD20CC7
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 18:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H2vOtz/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9FD20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916AB6EB78;
	Tue, 25 Feb 2020 18:15:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AC96EB78
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 18:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7tmWVQTvB05tMVoLoFmFy0r8xy77vVrBpZ7uuNj9WZIskS0Ha3+60zVIMr/ZUxtBLFkKg2MklRh00pxcUyL8mHunBD82dnlP6A2u3HjHaFmmroTHytXKu3x7mXChumH7v2UGFAzgC6sMfAJyE8d+gQVhM9ilhk/7MLGAaSsRGThemebbiX8Rk8PdxRY+qlOMogTEha0AGMegnJhmcHdZVXH4h9at0ljt53Qz6qgqs07UpheCLhMDhhuf99Ydn5bDxDjwe3U8G8Rh9yx0ePEWgYBmZgPVpukChLaxi7Ji9lRaCXaqUI0v+y83oa8vAX8F91g8O6HEZsWFLS5ptz5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfWBL1kO7vTbRXKMsGf716vu0GzubAYxpQnPpqXcMwE=;
 b=HKiQ66I4/nBC/1le/8mEmrFL+8fiwSpdMnGMlXHpzmkKoRD0kO94wOXiHvKQkOwbES+vkWN7E8ry77qXV5+nIEnobsR1UzepFp3jxQkn3suJIJu0si9FmuFSktZlzatzUfzR3yyny40sh/+NY3F8j2TeQJtyUvgvNEakAnJ9UOAQM4jPMjYOIkITz5gc2U/qL9qnJ3XTr+C6kDIkQBOnW86rjQ1x+ZAJ94pKEQ6c06oXuMkW2K5BhjsTtaStIINR50WkBc41Y7wGXkei9Gy1UjQ7/MQkLCQYuqFkpggkVr8j/i2k4PQrpBF0uj29nCaEL4R15zpNbISbHFKMlRaTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfWBL1kO7vTbRXKMsGf716vu0GzubAYxpQnPpqXcMwE=;
 b=H2vOtz/+Js0m0f/0PZBP9nJkhLiq+ZsdNurn7o2p56t1wj5+mr8pNGzEXD4aPRTAx2nBY1IvCjX7FMMqKyNHSYsX+Ej8VwcrFjsEB4bW10cXnKrWBJL6BFp3bX/Kp+1UMT0WALRrtmskFegORniqklItjNUG+XkhhjaZI7OU7I4=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 25 Feb
 2020 18:15:44 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 18:15:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1
Thread-Topic: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1
Thread-Index: AQHV6PUC7owyk4FEwEiZQd1EpZORUqgsPMJj
Date: Tue, 25 Feb 2020 18:15:43 +0000
Message-ID: <CH2PR12MB3912DC1B987DBE18C583E96FF7ED0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200221202410.3876-1-Rohit.Khaire@amd.com>
In-Reply-To: <20200221202410.3876-1-Rohit.Khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-25T18:15:43.400Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d1534b4-488d-4710-eff6-08d7ba1ebaa9
x-ms-traffictypediagnostic: CH2PR12MB4120:|CH2PR12MB4120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB412018708800054035FC927CF7ED0@CH2PR12MB4120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(189003)(199004)(966005)(55016002)(2906002)(186003)(26005)(53546011)(6506007)(76116006)(64756008)(66946007)(45080400002)(66556008)(86362001)(8676002)(66446008)(478600001)(66476007)(110136005)(7696005)(81166006)(81156014)(71200400001)(8936002)(5660300002)(9686003)(52536014)(33656002)(19627405001)(316002)(17413003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4120;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2n0ZuyJoofCPKD+b36J3UxZs46ZX2G3kbyAfqHZdhjfREMfWyNaU3Qf8vg3WqxDG2Yd8+Ax21/Qcf5E2kHYVP80o2K4Aa0GhubLPxoHa03WyFqfAo95Ry5+YmU0HPZGAt0x4deQBvAfXtcmcBzspw+J5gMlWv4a1DLm+jHZKu+vjam5i9UdX4Q9YiUE4izjWx6QqRCTn4BYZ/Eg30fWZrh1kYok4HBDTy0+oEFossabUtI185HwG1OFvqk2SPLKc+JvD6mFI8m1mV1Zsi1gueXdV9JySz90TASi4pr3aKOU4Nu5Mp2giL/tpV8o+PNDl+HU6ECUlUQlcCDxkYW5u+3qS6ykZ0noo056102C2ISw6B/7L9LxMmFCTRuS+usQInROpKhZg3EpANfYvVrqYEhO5znnpi/XRNPhyOi6NcndAZ9XVcGPpQk9FIXqhT7V4SrSM11KJS+/5z83LTiidcHLjTRmx1jWcNaX/vWFPR39CFPaNI1Qomu2+fxOab2ERFswDGHdfxeY1KZ0n9phIzzLndujUxWrM8GU7LEoBcnl4BNzTOctiq3mkoZVx3sw
x-ms-exchange-antispam-messagedata: 2TrPoxXOLBtodswLMs0PJsq8GNbjVTbOTIepY/zeG/MdYZ1zgJmnPpOlONVbfwwlxQIj+BiGtUeXv0f6Lxid8T6CtQZXUiZ+uUZn7RfHiPAuSz+B+/mqmQ75SHiIvdxXhCgK5pbhNkqzpiG4XFKNbg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1534b4-488d-4710-eff6-08d7ba1ebaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 18:15:43.8789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuNLw1HgyXLx82FZbMY9eFmS63jND/ixrqmQ1vDM3o6cXExikhymg9+l7JRiJfYrNqnYVOjHM2u4vZCBkkFpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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
Content-Type: multipart/mixed; boundary="===============1756393299=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1756393299==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912DC1B987DBE18C583E96FF7ED0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912DC1B987DBE18C583E96FF7ED0CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Please fix up the patch title.  E.g.,
drm/amdgpu: Don't write GCVM_L2_CNTL* regs on navi12 VF

With that fixed, patch is:
Reviewed-by: Alex Deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Rohit Kh=
aire <Rohit.Khaire@amd.com>
Sent: Friday, February 21, 2020 3:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Khaire, Rohit <Rohit.Khaire@amd.com>
Subject: [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1

This change disables programming of GCVM_L2_CNTL* regs on VF.

Signed-off-by: Rohit Khaire <Rohit.Khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c
index b70c7b483c24..e0654a216ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -135,6 +135,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_=
device *adev)
 {
         uint32_t tmp;

+       /* These regs are not accessible for VF, PF will program these in S=
RIOV */
+       if (amdgpu_sriov_vf(adev))
+               return;
+
         /* Setup L2 cache */
         tmp =3D RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
         tmp =3D REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -298,9 +302,11 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device *ad=
ev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 0);
         WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);

-       /* Setup L2 cache */
-       WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-       WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+       if (!amdgpu_sriov_vf(adev)) {
+               /* Setup L2 cache */
+               WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+               WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+       }
 }

 /**
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C52705cf7b1bc4750932a08d7b70c0e38%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637179135079462923&amp;sdata=3D6YT8MUoBGMujktD%2Bo=
YjEcxCAq2TE4gt7CO7GO4mGpoc%3D&amp;reserved=3D0

--_000_CH2PR12MB3912DC1B987DBE18C583E96FF7ED0CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please fix up the patch title.&nbsp; E.g.,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
drm/amdgpu: <font face=3D"Calibri, sans-serif">Don't write <font size=3D"2"=
><span style=3D"font-size:11pt">GCVM_L2_CNTL* regs on navi12 VF</span></fon=
t></font><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
With that fixed, patch is:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Alex Deucher@amd.com&gt;<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Rohit Khaire &lt;Rohit.Khai=
re@amd.com&gt;<br>
<b>Sent:</b> Friday, February 21, 2020 3:24 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Khaire, Rohit &lt;Rohit.Khaire@amd.com&gt;<br>
<b>Subject:</b> [PATCH] SWDEV-220585 - Navi12 L1 policy GC regs WAR #1</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This change disables programming of GCVM_L2_CNTL* =
regs on VF.<br>
<br>
Signed-off-by: Rohit Khaire &lt;Rohit.Khaire@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 12 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;---<br>
&nbsp;1 file changed, 9 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_0.c<br>
index b70c7b483c24..e0654a216ab5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
@@ -135,6 &#43;135,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amd=
gpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* These regs are not accessible =
for VF, PF will program these in SRIOV */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup L2 cache */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, mmGCVM_L2_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);<br>
@@ -298,9 &#43;302,11 @@ void gfxhub_v2_0_gart_disable(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC=
_VM_MX_L1_TLB_CNTL, tmp);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup L2 cache */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, E=
NABLE_L2_CACHE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, =
0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Setup L2 cache */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C52705cf7b1bc4750932a08d7b70c0e38%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637179135079462923&amp;amp;sdata=3D=
6YT8MUoBGMujktD%2BoYjEcxCAq2TE4gt7CO7GO4mGpoc%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C52705cf7b1bc4750932a08d7b70c0e38%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637179135079462923&amp;amp;sdata=3D6YT8MUoBGMujktD=
%2BoYjEcxCAq2TE4gt7CO7GO4mGpoc%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912DC1B987DBE18C583E96FF7ED0CH2PR12MB3912namp_--

--===============1756393299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1756393299==--
