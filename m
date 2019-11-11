Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A0C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 16:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9895021783
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 16:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9895021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C39E6E22F;
	Mon, 11 Nov 2019 16:20:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680079.outbound.protection.outlook.com [40.107.68.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9496E947
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 16:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOlI/IDlttplv1Zngkru53/94Ch7McvmftzD++tIVXaV3mP8F24g0nF//7A1z1ZrTkHY4r0t1Ru0+eR6HhzxM5JMx52NJWX4xg5V/r9Izv3qRphT1qAso0bhkLnvhoPLzs+s4tK3K6nT7Oga5CU8DkKLarn4Be0bvnIBr5iXpyv6DS4XWYyslmCJ6jRs4wqXHQ4j2GovvwRV6km9+v6qVfRTzOcssmKU9dii/hhL8OA2etHtkYzOOUflDvrlfJrUBrzkoFlHfblEyyPOQEiAYhCWmYbKoM5DsP70WiimZrbvmH0P+IOrKygMxsVVpWWdi4XamBFI0Zsxp1RtL6ZteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsQFrfHYqYGJrUko2yXDJiQLUazuHi279r15BQ1tIOI=;
 b=nnfUGuQa2w9DJutxskwnzOYnrxvX1HKY92XNhtETeo2gl8xj95iv6Y1g6kX713vedq9jYsvmvaRCnA3JvCs+Tzlfqx1NNaubacGj5pN2Y13PwZ+jZ8mu5JAoxY02pv6qUQ2VyvaiqhLQGt4rCa9DJoBpa33rdRcu4+52Y2/YDoiXxRRCePjR0mzO662v23X6ix9u3Smn4g+jZpC27aJZDlOBJr6Rll3x+olccDr9CR1kPf+DHRGsqxUiyNy3giTkEszhnY1rytdIwhorfqIj+sbJvKs4dqNX5yP8cQY7hD3HEeBktM5BbJdtw+Ux+9RbzA4N1NbzrYPg8/rnvLuN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1477.namprd12.prod.outlook.com (10.172.71.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 16:20:46 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 16:20:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Clements John <clements.john@amd.com>, "Ma,
 Le" <Le.Ma@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Thread-Topic: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Thread-Index: AQHVmEpd0rV74nMJsU+cXpn+B09tvKeGJ05Y
Date: Mon, 11 Nov 2019 16:20:46 +0000
Message-ID:
 <CY4PR12MB1813EC85B44194B5F9390421F7740@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191111044157.11356-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191111044157.11356-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d099457-c1b3-4ea4-9205-08d766c31bbd
x-ms-traffictypediagnostic: CY4PR12MB1477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1477722A1E9001EDC23C3CE3F7740@CY4PR12MB1477.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(66066001)(99286004)(74316002)(446003)(229853002)(19627405001)(7736002)(55016002)(476003)(11346002)(54896002)(9686003)(6436002)(6636002)(2906002)(33656002)(14444005)(110136005)(316002)(14454004)(6116002)(256004)(2501003)(3846002)(486006)(86362001)(71200400001)(71190400001)(66476007)(6506007)(53546011)(105004)(81166006)(66946007)(76176011)(66446008)(26005)(76116006)(64756008)(66556008)(7696005)(81156014)(186003)(6246003)(102836004)(8936002)(8676002)(478600001)(52536014)(25786009)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1477;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ZvMmbsu+UA+wD+cU1TsCoBRbQQ+vRmb0rGozD8HFeocLkyUeBtOd16SrAPmz+LG01MOzVamvphe0E5z44DgJAytjoI19Dvh8xLwnTuA2XIK2K/E0op8flNg1bJVPny7xbsL++WNXJ+NtsBzBnXvdUfv0/JqNq5yrXRiHVQGCx5s4Q5313IOcTi3Ly/WRII7ohgcyXWIF5+38HIlRArMe1lFV1NOpUru3gp9MrTAxK31fnszXnO+y1A5nl9aOtKSTr6Gi21+9ydk2k85vl4TcE1bk2UkWweyDS3vIKePxOgJHYJoGBoBMNokOW7SD5a+RZxdRFJ/DXtX2rLY5K6VWTMb7gPYNUsSNjrz5kXzehum0xoTyE1hgRrwb8vyTBccptj661VAERGjPQ3Ef5/AMrC8Q6akd89K23yMUhgtndwZGwxEHwFHEO0thQgWTni7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d099457-c1b3-4ea4-9205-08d766c31bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 16:20:46.5019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpL8CRcrhDY+mJQxAWt69t3yqz/cplsHRP8JwA/Gy528rUv+f4VSdy33lkIDVp69Wfo68UmpeLlvMPHlskGTHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1477
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsQFrfHYqYGJrUko2yXDJiQLUazuHi279r15BQ1tIOI=;
 b=CDjvwoEUG+ZBmsoGhBbDQmE+FgElvawXRgEfIi1+ekJEGuAUHqZ7o4qewNPoU3k1vo9Kzurk2SHO2Zbr4AkYVFhbmXChtxb30vpJkgdVnbj43LxYKwuliXyaWlkXnrNPQxz15RXjFB9XCiJVaezJV9t7o5zPeZvfwWQcITD0hnA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0842196043=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111162046.1hrtm2skLNwemtS1GtEQW08pBo2QhcCbJmJKJtYowKQ@z>

--===============0842196043==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_"

--_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Sunday, November 10, 2019 11:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Clements John <clements.john@amd.co=
m>; Ma, Le <Le.Ma@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp

xgmi, ras, hdcp and dtm ta are actually separated ucode and
need to handled case by case to upload to psp.

We support the case that ta binary have one or multiple of
them built-in. As a result, the driver should check each ta
binariy's availablity before decide to upload them to psp.

In the terminate (unload) case, the driver will check the
context readiness before perform unload activity. It's fine
to keep it as is.

Change-Id: I493116970ffb557f33c06de10f786684fdcef85b
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 456ac04b246c..9621e207a9ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -558,7 +558,9 @@ static int psp_xgmi_initialize(struct psp_context *psp)
         struct ta_xgmi_shared_memory *xgmi_cmd;
         int ret;

-       if (!psp->adev->psp.ta_fw)
+       if (!psp->adev->psp.ta_fw ||
+           !psp->adev->psp.ta_xgmi_ucode_size ||
+           !psp->adev->psp.ta_xgmi_start_addr)
                 return -ENOENT;

         if (!psp->xgmi_context.initialized) {
@@ -768,6 +770,12 @@ static int psp_ras_initialize(struct psp_context *psp)
 {
         int ret;

+       if (!psp->adev->psp.ta_ras_ucode_size ||
+           !psp->adev->psp.ta_ras_start_addr) {
+               dev_warn(psp->adev->dev, "RAS: ras ta ucode is not availabl=
e\n");
+               return 0;
+       }
+
         if (!psp->ras.ras_initialized) {
                 ret =3D psp_ras_init_shared_buf(psp);
                 if (ret)
@@ -857,6 +865,12 @@ static int psp_hdcp_initialize(struct psp_context *psp=
)
 {
         int ret;

+       if (!psp->adev->psp.ta_hdcp_ucode_size ||
+           !psp->adev->psp.ta_hdcp_start_addr) {
+               dev_warn(psp->adev->dev, "HDCP: hdcp ta ucode is not availa=
ble\n");
+               return 0;
+       }
+
         if (!psp->hdcp_context.hdcp_initialized) {
                 ret =3D psp_hdcp_init_shared_buf(psp);
                 if (ret)
@@ -1030,6 +1044,12 @@ static int psp_dtm_initialize(struct psp_context *ps=
p)
 {
         int ret;

+       if (!psp->adev->psp.ta_dtm_ucode_size ||
+           !psp->adev->psp.ta_dtm_start_addr) {
+               dev_warn(psp->adev->dev, "DTM: dtm ta ucode is not availabl=
e\n");
+               return 0;
+       }
+
         if (!psp->dtm_context.dtm_initialized) {
                 ret =3D psp_dtm_init_shared_buf(psp);
                 if (ret)
--
2.17.1


--_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hawking Zhang &lt;Haw=
king.Zhang@amd.com&gt;<br>
<b>Sent:</b> Sunday, November 10, 2019 11:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Clements John &l=
t;clements.john@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">xgmi, ras, hdcp and dtm ta are actually separated =
ucode and<br>
need to handled case by case to upload to psp.<br>
<br>
We support the case that ta binary have one or multiple of<br>
them built-in. As a result, the driver should check each ta<br>
binariy's availablity before decide to upload them to psp.<br>
<br>
In the terminate (unload) case, the driver will check the<br>
context readiness before perform unload activity. It's fine<br>
to keep it as is.<br>
<br>
Change-Id: I493116970ffb557f33c06de10f786684fdcef85b<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 22 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;-<br>
&nbsp;1 file changed, 21 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 456ac04b246c..9621e207a9ca 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -558,7 &#43;558,9 @@ static int psp_xgmi_initialize(struct psp_context *=
psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_xgmi_shared_memo=
ry *xgmi_cmd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_fw)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_fw |=
|<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_xgmi_ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_xgmi_start_addr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;xgmi_context.=
initialized) {<br>
@@ -768,6 &#43;770,12 @@ static int psp_ras_initialize(struct psp_context *=
psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_ras_=
ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_ras_start_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;RAS: ras ta ucode is no=
t available\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;ras.ras_initi=
alized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -857,6 &#43;865,12 @@ static int psp_hdcp_initialize(struct psp_context =
*psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_hdcp=
_ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_hdcp_start_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;HDCP: hdcp ta ucode is =
not available\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.=
hdcp_initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_hdcp_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1030,6 &#43;1044,12 @@ static int psp_dtm_initialize(struct psp_context=
 *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_dtm_=
ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_dtm_start_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;DTM: dtm ta ucode is no=
t available\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.d=
tm_initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_dtm_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_--

--===============0842196043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0842196043==--
