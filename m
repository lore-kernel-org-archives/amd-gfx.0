Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4DC2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 13:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2923620719
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 13:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uupHOfpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2923620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2666E871;
	Tue,  7 Apr 2020 13:21:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA276E871
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 13:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUSpqYOVeBJQFJK8mJJH4BmLX8B4JUw6MIjgULCR1etWrOWPs4syiVQbmFVbTLF3+ZXW6jbcKCgSqc4PeEXKxrNzjN7CzeWQ72phJ3Ysf1OGCrZK0FrpWlGOWtxRQTBqMtHOmZOQztQFyZu/7E2sUrfaxQsPElVDpjcgBrc4eMrZc+NaLVOoUlWfFWKYg6nJUPTriKRoDRHFvexZd9UXG0h9U1EPOOiicIUhh19QaD6ZvhJknuVPq+BVRVR8XUZmpfA95mFY+YA2QaCc64I8nAgJZT8Hp4n4ZKv97jSzo89q9tJOQhbfbQgtv1w6CP96ZPIPywSgeJAr6XqD8xsgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrieYmsLSGxzeyJX5Bpd0iRig9uXiW1ICo2YY3teBms=;
 b=ISR3nJ+SJhsoTvjz40/7m2a4xAx8uAaD2ztpTIaC9HsRYsL5avI+MPOMWlhtUHM6buUWGkXelUprNNT+JUCoKqWPQy4SCDurPptnLvZ3A1Hsa1/VdakMsRQNByyHIlTQp6X52uxfNX0Zwhr5yui38NE/AG/vsTVVPLYmM4oaNMjSKWH0F49tLfo8nDrCek6izJTW8sQdKQw2u8E1end5kPZNKdm8ppRbP6/ZLah30qpbeYw+EdreluihfDjXDLiEoPaXLyzW/8NS/WgwwkLZaCBYk5xjE+2e0Y00N+1Ro+Cm77uVZQescixDk9WdEvSdyw3GKPlCr2I+s0Tsf228vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrieYmsLSGxzeyJX5Bpd0iRig9uXiW1ICo2YY3teBms=;
 b=uupHOfpFiRxxP9Do+ec0pKPf1bEcpe5nA7656tJvxnFSTpHQQ1ZHQfE0W3Tp3v5sjV3k554omCyWYT/UCdhzODxwdiUppuOXwyyFsgvMEcYIDE/YlZMc2zYME5ACUvicAehgjQ3aAp/MbIDuMWcPMVRxMnm9BuQjldZn0ri7QUU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 13:21:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 13:21:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Thread-Index: AQHWDCt37Ba1W0AQN0q9dUvVPy2ivqhtpmJT
Date: Tue, 7 Apr 2020 13:21:47 +0000
Message-ID: <MN2PR12MB448851189B033D3B472C3287F7C30@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200406155249.16576-1-kent.russell@amd.com>
In-Reply-To: <20200406155249.16576-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T13:21:46.702Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ace1dc80-eca1-4165-5298-08d7daf69fdf
x-ms-traffictypediagnostic: MN2PR12MB2878:|MN2PR12MB2878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2878524CA8436E848BA80A6CF7C30@MN2PR12MB2878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(316002)(52536014)(966005)(478600001)(55016002)(110136005)(19627405001)(9686003)(5660300002)(2906002)(6506007)(45080400002)(53546011)(186003)(86362001)(81166006)(8676002)(33656002)(26005)(81156014)(71200400001)(64756008)(76116006)(66446008)(66556008)(66946007)(8936002)(66476007)(7696005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JMoOQJNlB1994mqt7Lll/m/i22Qn+I63NyUvAKJ3op5NNdpU+ArWNdkwX2sTiM9cpjkDfkYVqrbRcp3DKvCiVzXxrjhafZh0XHoA5h9HMyr9tWD20MebluV8x+tu62DUWtxxTzKlK5mXM5KixMnzt5u4cggmZ0St+Vjvy198BoLEreYqwLsgi+FTtOhXvxzJqv+RX2MFw+D1YV+uX/lhJEd3j5acuKgLfd8eupL0mn6YDD2WVeqA5hxtooXr7Sa22xR39JzTFJK8mHDne06E2e6Xd0fLjpkxLePXdId42Xa/q7jzMGG2BSHHnkXAJCZpZw7gnw16tIwOCHYNLL3duRv4h61sxMkaGE2HMiSczRbw0wMW2vUOVP3zokA7Y7AAdjW7OHHKaJsnr6rP49/3OspC6nH0Y61tJtkImK3KKHGWb+8sgrjhIVIwItJlJj/2trw2FWeebbyGZKhyIa9NWIq1rXmpH0GKbPoenfSkEE=
x-ms-exchange-antispam-messagedata: xCXx1zU+T6dALmlqFn7tPlVORZSyX6+ms+ZleQDESdkO7reJ00kRaeOsLAmg6eMKRygxbptmBS0hf+tEvxJONb/Bltbe+gwMsdo7UfYU4x7iTDjetFOPaGq/W0fbIBOCnOQ2cD+r2FHToMQZHAisyg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace1dc80-eca1-4165-5298-08d7daf69fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 13:21:47.3694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KHmcR/lLKNXj22MZRRdcWvlEExXWvblbx+9y9ZHr6lKwWz1bMwdQytTQvWfz+LxLEliOliaW8OqUEJWKCg7mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
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
Content-Type: multipart/mixed; boundary="===============0345911678=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0345911678==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448851189B033D3B472C3287F7C30MN2PR12MB4488namp_"

--_000_MN2PR12MB448851189B033D3B472C3287F7C30MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Monday, April 6, 2020 11:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4

There is at least 1 VG20 DID that does not have an FRU, and trying to read
that will cause a hang. For now, explicitly support reading the FRU for
Arcturus and for the WKS VG20 DIDs, and skip for everything else.
This re-enables serial number reporting for server cards

v2: Add ASIC check
v3: Don't default to true for pre-VG20
v4: Use DID instead of parsing the VBIOS

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..9d17761721de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -20,6 +20,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/pci.h>
+
 #include "amdgpu.h"
 #include "amdgpu_i2c.h"
 #include "smu_v11_0_i2c.h"
@@ -31,8 +33,16 @@

 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-       /* TODO: Resolve supported ASIC type */
-
+       /* TODO: Gaming SKUs don't have the FRU EEPROM.
+        * Use this hack to address hangs on modprobe on gaming SKUs
+        * until a proper solution can be implemented by only supporting
+        * it on Arcturus, and the explicit chip IDs for VG20 Server cards
+        */
+       if ((adev->asic_type =3D=3D CHIP_ARCTURUS) ||
+           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a0) ||
+           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a1) ||
+           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a4))
+               return true;
         return false;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cb16b12f4b49f4daadbf108d7da4296b5%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637217851859649973&amp;sdata=3DRRTElSye1BxML4zCiSA=
1u%2Be6z4NvcgZrI8hPvVXhJTk%3D&amp;reserved=3D0

--_000_MN2PR12MB448851189B033D3B472C3287F7C30MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Monday, April 6, 2020 11:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Re-enable FRU check for most models v4<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">There is at least 1 VG20 DID that does not have an=
 FRU, and trying to read<br>
that will cause a hang. For now, explicitly support reading the FRU for<br>
Arcturus and for the WKS VG20 DIDs, and skip for everything else.<br>
This re-enables serial number reporting for server cards<br>
<br>
v2: Add ASIC check<br>
v3: Don't default to true for pre-VG20<br>
v4: Use DID instead of parsing the VBIOS<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 14 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 12 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index bfe4259f9508..9d17761721de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -20,6 &#43;20,8 @@<br>
&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&nbsp; *<br>
&nbsp; */<br>
&#43;#include &lt;linux/pci.h&gt;<br>
&#43;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_i2c.h&quot;<br>
&nbsp;#include &quot;smu_v11_0_i2c.h&quot;<br>
@@ -31,8 &#43;33,16 @@<br>
&nbsp;<br>
&nbsp;bool is_fru_eeprom_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Resolve supported ASIC type =
*/<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Gaming SKUs don't have t=
he FRU EEPROM.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use this hack to address =
hangs on modprobe on gaming SKUs<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * until a proper solution c=
an be implemented by only supporting<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it on Arcturus, and the e=
xplicit chip IDs for VG20 Server cards<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CH=
IP_ARCTURUS) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =3D=3D 0x=
66a0) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =3D=3D 0x=
66a1) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_VEGA20 &amp;&amp; adev-&gt;pdev-&gt;device =3D=3D 0x=
66a4))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Cb16b12f4b49f4daadbf108d7da4296b5%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637217851859649973&amp;amp;sdata=3D=
RRTElSye1BxML4zCiSA1u%2Be6z4NvcgZrI8hPvVXhJTk%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Cb16b12f4b49f4daadbf108d7da4296b5%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637217851859649973&amp;amp;sdata=3DRRTElSye1BxML4z=
CiSA1u%2Be6z4NvcgZrI8hPvVXhJTk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448851189B033D3B472C3287F7C30MN2PR12MB4488namp_--

--===============0345911678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0345911678==--
