Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ADCC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 14:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6CD20872
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 14:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="seNRzAs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6CD20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F32F6E231;
	Thu, 12 Nov 2020 14:53:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942256E231
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 14:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6IMbBn8BojN1dsG2MvLmHGzZfFxGehz2NtSlNi2wsIEn3zCs1/JeGZw+mEMz8tIl9Z41CVGE4/oX7xLNtNDSYNIMwCU2cHE/sH9/uvAI5q0KtM7xMCxUTm63AtQJTjUSQJjXL9g81TCq6yZ8EGcRSpSCaon190ykb5lXftT7vuOtcig1hAh6QGq3nbI732aPbfspjNpYnCV0Na8PJWzW8xClJVjMntA5aTr6DkuqvE6KFMfyOO9AoSSng+5s7thRg7zE4B/PezmCwxPYmx3NCfHmw121UqE2bWXlSMCLWD/7wvrE6fcGVT2hoSlfdl2Cj3WhLA5ugm1eQ7QBb7FPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az/F+X7v/UKOJd1w/vBdLxzPATzkJIq9VO0V5UjqDTY=;
 b=b0sifSD0iQZR43CeGUeffaYWfbDlDIRKpCxS4ZQdMGrXokNw1b/7W+ULw/FG1Y4Km9rgl9Oac2l6kSrb/Y43adjxyRksdXyceHBcROzjtGXY1a/bVvIJI2c+SBlwVJsHj2BXVPfvi9Z2pXWXCJVH1VFksujNVcayBOe+PSMlPdwU9ouSmPQ3Ae0KBXokecExvH++zp21HBlMW7RYHv9sucyL7XrhDr1+dxaF5o9pq2aw0Yqf8wl/gm7sQ/80SHFG84G3rvlqG/rUsZlYgyESfh/geo1CT9ZWoqCuTE+2gYkF3joFstqwlFKbpoeVAnY9yFtZ8JkN/sUIRaO1jnLeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az/F+X7v/UKOJd1w/vBdLxzPATzkJIq9VO0V5UjqDTY=;
 b=seNRzAs/T3iG7f9srD/R7k61IU3BvMEEKQYZflMJrOMvXY7hCB0s3mnhOIhwI4RqZpyv715Z3ahR8Khq0Wt8OZDo6ntKTnIpRhAEUgAUSwj6xf/6APkZ+nq4i9SAk/bWxKR/KkFFaliKRtvfGSEK523e7YjabjG/wcxx6ANbUI8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Thu, 12 Nov
 2020 14:53:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 14:53:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Clements, John"
 <John.Clements@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Enable TA firmware loading for
 dimgrey_cavefish
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable TA firmware loading for
 dimgrey_cavefish
Thread-Index: AQHWuH8k/W0H0x7WlE2OBfHTAfrSSKnElYKi
Date: Thu, 12 Nov 2020 14:53:07 +0000
Message-ID: <MN2PR12MB44882DCECF38DE74B6716078F7E70@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201111230444.180991-1-Bhawanpreet.Lakha@amd.com>,
 <20201111230444.180991-2-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20201111230444.180991-2-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-12T14:53:07.080Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31c84a2b-36e6-493a-788e-08d8871aaabc
x-ms-traffictypediagnostic: BL0PR12MB2433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB243390FBDA8B8E853387C8A5F7E70@BL0PR12MB2433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3Oy16zgj90OLHgIRVG9Q6ROXErrBQ1892AfaO7MZaTwJ2bwp2fah7kyqUdhBZE6Z0KgvsO+Mj3g6WE2We0LBv4Y0KbEMuNz34efCFmKZgNhNf1BvtQBOiU1u4wZbQ76j/Ith8W0VADVjIY76MnA0Qwb5Bk+Ste9QiRyBV98bSgrkkNKPBM3u68DgMVgjS7O0qVJfIynnvJyYAHKDpkqhhoep3wbC38x5DEPyUoH+uh7RaiisisFNdaqYh8Og9FYENRrIQFniX5EcX9zBmYYN9LfzJ8olthRRsHph9nrUZExHh3Kd8mGIgRvMYxdKLxTdcEFhbvEzYj1n+BNmHV38A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(6636002)(2906002)(55016002)(26005)(52536014)(110136005)(19627405001)(7696005)(6506007)(478600001)(66556008)(76116006)(53546011)(66946007)(64756008)(66476007)(83380400001)(8676002)(9686003)(4326008)(86362001)(8936002)(316002)(5660300002)(186003)(71200400001)(33656002)(54906003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4BKx0TYVtPRjBAa55+F+c5Y7+zsi6y7f3eqyT88+dFuIV+aeeAAGnZ2P+3N19LQwmSdR4vxPjwWh3HARDgR4fkbpe25izbD9f+5WOniUhL+8R9ljaULf03tMrxges8fMy1xxX38jf5bzlEJAWtv0+JinQKnOY7d+lCIV4Maso6G2aEndYf55tIWByv9SVP0wudNuSIRGLGFwcGOnB4jegbFOoJXRvg2Dj+59gZ4DRJtSmFi8jeVI+95hQ0rCTMMOJMYLnTZzoryqPPOj1NpRQao/PItEzXVeLSyuYibSnIgDKbdOMxWfB2nHz5ZROG250CMdswdnyxJGnzHYfWl2+1C6h3J7tcbSwHhoccKsMwd5nDgAGx1kEEzjkF+mTzTLNZKge33IjV1R0MQeIFpKAoR3MOOtPukW5ZJ/34pLJ8c+iy9ijAYP8GeGZ7Y5tLxgPwiiQ3uPjnBiAfTogPYIXoWmjrdMJoL8Gg9NlywuRhuQqITdcOW0uc/PROT1wKgoxRCjnP7AXZEz4nyaNIXg8QxoLrIkUlSjHpZ4hsHV2W2oEPK4QKmyeDTUKmOvZspprl02WY+/ut6KzatXzAE+XH5+hxdznV8OvA64SgXlnpXJOzS4QXR6knDcRDqRvMWNXPK4qDHg3omTIIkhvdq7gqprl1RNJrbvkEnquoXcyNQjau1EGW5k08SSzvz9+EdlQyGrG06wc5+z4leHSehaXIXYvux7KcSBJoktz2UBrzF5j42fwVgB5f8EP61VLf0zOWfPPLn4KFTPpe+HQJyRZCimmaZdpZu6ipGojFLnG84BaoDV8yQjj7nJHhYWrJA7ZHA6mTc+0Prr03/h0JRcVfKbVuzyDy/JNuG669ypJB6KG9Dtot48optOpxDMZ3mAh9uNFWjHn4lYi/0sKQ7aXA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c84a2b-36e6-493a-788e-08d8871aaabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 14:53:07.5516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2aYsmZe42g/mddyvOvz8iZw4JCYQpGJtyJU/wfcUJuZFz18m7oa3JjSEZsFE8Z6A8Xx6b4L0SCUnHYoGI37jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2433
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1545410147=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1545410147==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44882DCECF38DE74B6716078F7E70MN2PR12MB4488namp_"

--_000_MN2PR12MB44882DCECF38DE74B6716078F7E70MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Wednesday, November 11, 2020 6:04 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Cl=
ements@amd.com>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; amd-gfx@lists.freed=
esktop.org <amd-gfx@lists.freedesktop.org>; Lakha, Bhawanpreet <Bhawanpreet=
.Lakha@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable TA firmware loading for dimgrey_cav=
efish

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 03e88dbf92be..edd2d6bd1d86 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -62,7 +62,7 @@ MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_asd.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_toc.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sos.bin");
-MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_asd.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_ta.bin");

 /* address block */
 #define smnMP1_FIRMWARE_FLAGS           0x3010024
@@ -192,15 +192,11 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)
                 break;
         case CHIP_SIENNA_CICHLID:
         case CHIP_NAVY_FLOUNDER:
+       case CHIP_DIMGREY_CAVEFISH:
                 err =3D psp_init_sos_microcode(psp, chip_name);
                 if (err)
                         return err;
-               err =3D psp_init_ta_microcode(&adev->psp, chip_name);
-               if (err)
-                       return err;
-               break;
-       case CHIP_DIMGREY_CAVEFISH:
-               err =3D psp_init_sos_microcode(psp, chip_name);
+               err =3D psp_init_ta_microcode(psp, chip_name);
                 if (err)
                         return err;
                 break;
--
2.25.1


--_000_MN2PR12MB44882DCECF38DE74B6716078F7E70MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 11, 2020 6:04 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Clements, =
John &lt;John.Clements@amd.com&gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; amd-gf=
x@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Lakha, Bhawa=
npreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Enable TA firmware loading for dimg=
rey_cavefish</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.L=
akha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 10 +++-------<br>
&nbsp;1 file changed, 3 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index 03e88dbf92be..edd2d6bd1d86 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -62,7 +62,7 @@ MODULE_FIRMWARE(&quot;amdgpu/navy_flounder_ta.bin&quot;);=
<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vangogh_asd.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vangogh_toc.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/dimgrey_cavefish_sos.bin&quot;);<br>
-MODULE_FIRMWARE(&quot;amdgpu/dimgrey_cavefish_asd.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/dimgrey_cavefish_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;/* address block */<br>
&nbsp;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x3010024<br>
@@ -192,15 +192,11 @@ static int psp_v11_0_init_microcode(struct psp_contex=
t *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D psp_init_sos_microcode(psp, chip_name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n err;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D psp_init_ta_microcode(&amp;adev-&gt;psp, chip_name);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D psp_init_sos_microcode(psp, chip_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D psp_init_ta_microcode(psp, chip_name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44882DCECF38DE74B6716078F7E70MN2PR12MB4488namp_--

--===============1545410147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1545410147==--
