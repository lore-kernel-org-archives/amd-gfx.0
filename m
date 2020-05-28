Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C14AC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBC1207BC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hgEbtKvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBC1207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27A56E542;
	Thu, 28 May 2020 13:24:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A206E542
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3MVsj5VJ2CFXkYxuKPwAYYsG/hEdATqCAQ4vKmwGtk3oeJ9CbUcwmSgE3a3GFuGLUnW9ztlx0b2hHyHEfzf5oIdL1JFrWMq0HWVIPUyCOTDTzthu/wnd62Emmaq8PQD2BIrtGEhUIk0hnvH93747jmApHP7ile57PSki+lSQ0fp/8I7qrlvguIVzMIylbrz7tAdICqcG0evbgWfFGy5GPwVuhEaYhZr5yTUBYaP5la+5/vmIFF7BiAE+Tsr6FOdmTRITHRPLRN+PFUMsYMFrxEAJpYCnbxv0Xs5nw7gw6jesK6T2DkQnAck1sKoK7f06svR+jdMFWo4VHhUBttVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcfxWPvpMSdHzmSRj9EnCgNaZysZEGtYZUV0svyBhO8=;
 b=HN3DraiVVcziaSxRs1+gVIasCkfwsUg+lEj3Y8U9MG709Ay3/8vmXBQ+Eteh0XvtKycdHlYk8VA9fqAo+XcaSRiGB5ECHx3Pt4UnVEn3yf12jrENJSsldS/G1MzXB0evDqMx420AzvS6dnx4rdm2lh36pjjNzyZ96y4CfvxhObED+Rlpsz1zsYS5+pB0PonKyiSXk+mGv2X7xM36XwLYK9GS7PBSE73SEwU+b35Dx2GpZsmNOOfQZFkh6vKO4JvXeNbe4+/PBPlO/NISHMeDbWaIlAPjSqyEPC+T93NxAwpBaQmGebfQMWfzMvrsCPQ/GFsHlOqIi6hZq1pcFzjRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcfxWPvpMSdHzmSRj9EnCgNaZysZEGtYZUV0svyBhO8=;
 b=hgEbtKvlIskcTWc7zMSaO2k5RCrcOuZPWZ9aW0dF+A9UmJK8AR2F0p5DMUZa5gPuDEJwVwRpCYI6i948ThUAF8f2pWurtk/zl/i9g3L9SbSaObZPJjH7DRSM+PUPZOSpkreUoKRss0dEgIW/K9+3S+kCRbnefN/r1lubfN2qJNA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 13:24:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:24:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/amd/powerplay: stop thermal IRQs on suspend
Thread-Topic: [PATCH 1/3] drm/amd/powerplay: stop thermal IRQs on suspend
Thread-Index: AQHWNM7L7mXvRWUqckarJ+XT8+NJbqi9fOMp
Date: Thu, 28 May 2020 13:24:23 +0000
Message-ID: <MN2PR12MB4488B537D7870A08B331FC8FF78E0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200528090241.25291-1-evan.quan@amd.com>
In-Reply-To: <20200528090241.25291-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-28T13:24:22.759Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.51.180.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf9bca06-9ba6-40fa-c585-08d8030a6fdb
x-ms-traffictypediagnostic: MN2PR12MB4158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4158AFA9C8A54BB3468C67ABF78E0@MN2PR12MB4158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rpV74HjUqReuyx5rmTJJ/vD9Nx86nh54zFHqmkBVrIryaMjoV8a20/VB366krqgty9xFHOMJl0SPwbqWgzx3O+FBSS7AasyKNQmyzhTDEwNqvI9CcOM4oeQsznz6YdTAlA2FOMUSRk9EI09I97vBCwz7/8rYYVZeMXNinzVrgujzUJKGoE72ndUqQuqre9i+LKW0Fh+nB2S2Omku4rzb/ThcuhDeLey1TnIL0SOHMOjBvqr8tn0HJ8VBZEmK0HElQlJv/mVW/ddwj+S7szzPMA7vwRtjWGYefrnwXCBUfb87k4J+ekHYw8keNZSQENtHhK+Vg3e5hWKdP7Q3uKjvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(7696005)(71200400001)(52536014)(9686003)(186003)(478600001)(33656002)(76116006)(53546011)(64756008)(66446008)(6506007)(8936002)(26005)(83380400001)(66556008)(8676002)(66476007)(66946007)(19627405001)(55016002)(15650500001)(86362001)(5660300002)(110136005)(2906002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: brYv9rn8FuKe/TOiEQV5JHiUxyea6Pnhbaa2WOvDmBF3qtqmddS87Gn8qwmTx6bbGqCxbj5sGO+5p5vZa3B5BJWwCn7aMnvSiq9Q+ArqmlYgPLRZpdrXmFa3hDaFqwz6KDABUZCAdYOzW0gD7R3RFJq4TbfNv1fxvjCwj96hWme4LvNYs1q+jXW1qVbNd0M3UM/PEQbNvB0ZuDq9Lzc18q1hSRO160oDei4nEvtlSeRF41e32Zo+PYuQsHDFhIkz8V5NR48bLwJsQQzwPHQoG2t9hzOhgKH8jem8yTsh1buU7sAsHbGNtDiSDWruyF9N38R+EV//xwpel0tO/WEnCJrLZk1E0oy94mII2JvkCPzXVz/qxulYdfo1ki52lmZBhRcawRrYcrORq0zXZpNHnvATvSqs/1+TWPHKNZ+AsMJ3VxLadEJE9K9OtSPMCi4fIGQ3oBIFXZQ/HdfhS3d+aR5BZ+FApUIEMZ/SeqvRQl2RdVwD/z6NPsjayg155jKa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9bca06-9ba6-40fa-c585-08d8030a6fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 13:24:23.2905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4idrTfWi4i/eplu+i5DBvD/sFKedRY5w3JSQoWLjF3g4GRuJ0LEeUJTVoJtfR7fwPEp+5jYAvdcVhtj0O4rZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Content-Type: multipart/mixed; boundary="===============1980489661=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1980489661==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B537D7870A08B331FC8FF78E0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B537D7870A08B331FC8FF78E0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, May 28, 2020 5:02 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 1/3] drm/amd/powerplay: stop thermal IRQs on suspend

Added missing thermal IRQs disablement on suspend.

Change-Id: I959a1d56930de434cc8534334220d3faeadf79f8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 8ce907280dc9..12511407683d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1537,6 +1537,12 @@ static int smu_suspend(void *handle)

         smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);

+       ret =3D smu_stop_thermal_control(smu);
+       if (ret) {
+               pr_warn("Fail to stop thermal control!\n");
+               return ret;
+       }
+
         ret =3D smu_disable_dpm(smu);
         if (ret)
                 return ret;
--
2.26.2


--_000_MN2PR12MB4488B537D7870A08B331FC8FF78E0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 28, 2020 5:02 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/3] drm/amd/powerplay: stop thermal IRQs on suspend=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Added missing thermal IRQs disablement on suspend.=
<br>
<br>
Change-Id: I959a1d56930de434cc8534334220d3faeadf79f8<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 &#43;&#43;&#43;&#43;&#=
43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 8ce907280dc9..12511407683d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1537,6 &#43;1537,12 @@ static int smu_suspend(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_i2c_eeprom_fini(smu, &=
amp;adev-&gt;pm.smu_i2c);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_stop_thermal_control(=
smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_warn(&quot;Fail to stop thermal control!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_disable_dpm(sm=
u);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.26.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B537D7870A08B331FC8FF78E0MN2PR12MB4488namp_--

--===============1980489661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1980489661==--
