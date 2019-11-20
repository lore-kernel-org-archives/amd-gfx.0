Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E2C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 14:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2D120692
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 14:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2D120692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B736EA60;
	Wed, 20 Nov 2019 14:30:10 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790040.outbound.protection.outlook.com [40.107.79.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7556EA60
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 14:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9wMoaan2rRMvqKmwE0ByCDypionRHlWEeCUtnX6xoDjuiYmg/KZ5arQN3EHYjUTQYER1Ep7VK9NrRb1of7cppDfPrdJWesif/8vtq21zlyItn1xdhv/uWo5l0VmdJsw0VwTrTNhvkfuaaOqMFkdSt1BNBApXKiNgVDuT1dEOyFl2ghf922fFcBabE1wp/syNFzdiqQlIV3xHytAYiwfG5xFyYcaAfTOaZ7Z4p2e7N7HM2EOnmQP32bfehmCKKpUUUNqFH40NvuR5tj9rsDaJ2whbDEoWauhpgRxsLWkqQJk1gFR+Ct26P7qBk+mwQnIlNXiTm5ufYVH4Y5LBZv6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u+kMx/Gf2xCvFrrotfCHMkA0p8w1mb6OIX/MS0yFFo=;
 b=mjo+jFItYqpqlNPx29ntkI+UcGtWJwir/u4zBtP/OlwmVqPgYA58IITZ6dEO3oEtSzF8bXuTo6n0B2jkrSc7DZad/UQaC/DS3UOlse4OLw3LaoVKxRl4VYkEBUikRC4p57px6JF3CL2ERzw1pLUC7lqmdEINzabULiroCv0MFMutfhjsbSpv4ZshjsR+ucHPqiQ9Sy5FtUwNJpz7JR7c2zN+wPlq1txnpbbDA4DgCKSXdTjF6UNbOD+EG+EAbtBLK1v3uPVdl29EbOCmWYtKJSCgWCT6be2RKs3iKjR8IW+v3Y00XXnXwDBVf2PRDjVKHXTnSVYz+IedCeJ4AbhEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1237.namprd12.prod.outlook.com (10.168.167.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 14:30:08 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:30:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: Re: [PATCH] drm/amdgpu: apply gpr/gds workaround before enabling GFX
 EDC mode
Thread-Topic: [PATCH] drm/amdgpu: apply gpr/gds workaround before enabling GFX
 EDC mode
Thread-Index: AQHVn58upzYww5VCIUWCtLuewb+XJaeUHrSC
Date: Wed, 20 Nov 2019 14:30:07 +0000
Message-ID:
 <CY4PR12MB1813463023706FDC4962778EF74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191120123643.16416-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191120123643.16416-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e29eac76-36bf-4814-f623-08d76dc6248d
x-ms-traffictypediagnostic: CY4PR12MB1237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1237287E9076646149095650F74F0@CY4PR12MB1237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(33656002)(76116006)(3846002)(5660300002)(256004)(6116002)(2501003)(316002)(8676002)(66476007)(446003)(6246003)(11346002)(71190400001)(71200400001)(8936002)(66066001)(86362001)(7696005)(478600001)(76176011)(102836004)(476003)(81166006)(81156014)(7736002)(186003)(25786009)(6506007)(53546011)(66556008)(105004)(110136005)(486006)(66946007)(66446008)(64756008)(19627405001)(99286004)(229853002)(26005)(52536014)(6636002)(74316002)(9686003)(14454004)(54896002)(55016002)(6436002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1237;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwYGyS9Hu6qRGh36pNAumS0Ib4H7+3HjY+QL4qDH44NwKqI7DX02dhZrvTK6deTayp8hafrw3bSveoB9tr9taJ08Z6LBEKlbOxIIICQCPVbIGGkcwdPoL4FPKIj+tdzlEeSTQ2zuDz8PJX2y4CN1tgt5iUHsWS69eoMpybuYJ9YNXwNpPEu8cFOomJL1YltYH92vUX36PFCCxtZp4iZbCb8O8BGSpycmPHEDfrfOZy+xO43KVMF52I1btEkG8kYSi/GpMHWV7qUVE1FBJVeSARJSgWF5NDXH4CrhVnt6wmdMtHjrs53RFwAJ4HWUbMtJnFymG1rrny25ZXojffKDqZRn3U7j4PW/gCg0WnkTAJtaRkt7RsgivLL9MsskO/Zj/zw3yWuYGFvQhrVmYfcyC9GJDQfiSFhVbyuLlzcDu571971IgswxADpMpA5gzE9b
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29eac76-36bf-4814-f623-08d76dc6248d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:30:07.9170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhDnaC9JaoZc+EHAjkDRz2gQlV7Kt3uqHNjguKWDoaBXxWY8hCCVSbwsvDiJByY1vuCZjFw8sYPsE+rg8ZFKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u+kMx/Gf2xCvFrrotfCHMkA0p8w1mb6OIX/MS0yFFo=;
 b=KAklhQVzi4HHg0ZcnoRXaVea4v8gHBrdHHEMg2i2ZtNCV/wsA6l/5tCIBXdNyTEyMfXAwSSn1z1DdWliq3mvbtBQ+s0Bu4ZUN15fPl+2pm6BgZVJY5YfeMbb3nzawGNWItmWxDwYgMpHEQGDNasrP671VvVxRlKt45jpRPLpQOQ=
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
Content-Type: multipart/mixed; boundary="===============0041832341=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120143007.vpTZJtrOLwgEQYrvMqUfuRas7LFPI0MF8x9CM9CgjgM@z>

--===============0041832341==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813463023706FDC4962778EF74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB1813463023706FDC4962778EF74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Wednesday, November 20, 2019 7:36 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Chen, Gu=
chun <Guchun.Chen@amd.com>; Clements, John <John.Clements@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: apply gpr/gds workaround before enabling GFX E=
DC mode

gfx memory should be initialized before enabling
DED and FUE field in mmGB_EDC_MODE

Change-Id: I248a087364cbd9858cba32a70be456af3f07c90d
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 0d6965ba7a86..68359059e390 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4213,10 +4213,6 @@ static int gfx_v9_0_ecc_late_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int r;

-       r =3D amdgpu_gfx_ras_late_init(adev);
-       if (r)
-               return r;
-
         r =3D gfx_v9_0_do_edc_gds_workarounds(adev);
         if (r)
                 return r;
@@ -4226,6 +4222,10 @@ static int gfx_v9_0_ecc_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_gfx_ras_late_init(adev);
+       if (r)
+               return r;
+
         return 0;
 }

--
2.17.1


--_000_CY4PR12MB1813463023706FDC4962778EF74F0CY4PR12MB1813namp_
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
<b>Sent:</b> Wednesday, November 20, 2019 7:36 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Clements, John &lt;John.Clem=
ents@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: apply gpr/gds workaround before enablin=
g GFX EDC mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">gfx memory should be initialized before enabling<b=
r>
DED and FUE field in mmGB_EDC_MODE<br>
<br>
Change-Id: I248a087364cbd9858cba32a70be456af3f07c90d<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 &#43;&#43;&#43;&#43;----<br=
>
&nbsp;1 file changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 0d6965ba7a86..68359059e390 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -4213,10 &#43;4213,6 @@ static int gfx_v9_0_ecc_late_init(void *handle)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_ras_late_init(adev);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_do_edc_gds_=
workarounds(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -4226,6 &#43;4222,10 @@ static int gfx_v9_0_ecc_late_init(void *handle)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_ras_late_init(ad=
ev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813463023706FDC4962778EF74F0CY4PR12MB1813namp_--

--===============0041832341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0041832341==--
