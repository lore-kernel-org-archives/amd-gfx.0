Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112FC4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22B02070A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fz4soTjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22B02070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 980156E14A;
	Fri, 20 Mar 2020 14:22:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9076D6E14A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FurmlRLRnYpmEdv5CzO1qsGC+J0WEBPCI+whXFb8VHa9J+5OVnDCRRM+KduwGkf6AQn4ySZLlYrPwYLaibbCBGdTnWps9t75w2AJ8uKD39od50eX7lra2UTLU6T5GXdt06WZJooaOCIJMMzwH3zuA+K2EI6govX+1Xp6zwDCOrso1G81vHEkAzza7JaRt0iEWNt9mK/9mV08trEkRQ511R28nZf6HBhXy8NBoMZz+2UGjqussXZ/nB5qYkG50wEjYJWr2lq90ZezsA+Q1DrWnnDmfG9gBcFCh+qpJ7cFU3cib62bj4u99Ouat/xLEezkoWcOljRczzVtlig2GShMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdTCsth8iF+ElMKnAGw/U7qQbNJ7tipKb2XPDwZwVC8=;
 b=HIVleVdazgJE39izG53xuWLOXo7fFw7twAayrWTlHSjq3KinHlMNUCPHsyvpylmUfjoU0VhIOPrJKEv9P9ia55Zz6GSeVaDjhjWtLGXKF2rT/REoPq3RDQR/jUG9TaL3gkCcwGsv6HbxSqDifhxjl+9RWSzy/rMBLcE64P7GdUTVzYmUCi2UQmtl9VHkcZM3P0wDlvuVi2IqrQiwNTySe9raSvZn1gjpP/F95IoYkpiQAwNeJj9dR7w6f+VrMhr3PeFrnJTVJKA/2FMgdhYkJcjt9CpI9fL4fe/kbM3y/O/qbMY44RBktUciAVhEQkLAsfarRMvxk3tdBUfKkMzfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdTCsth8iF+ElMKnAGw/U7qQbNJ7tipKb2XPDwZwVC8=;
 b=fz4soTjbRv3XR546h1Hhuufzp7ScO+5C4xVCPYoEX7ZbB6/uf0vG4jyD48Ktoka3FN0iy/Mk7Y6RkwgEu2Mklal976YuF7f6pDDsLyWDax7FjNwFew6R+yFTpcdNJSrzn+TQPEejL4X9nvyztox0dvDPkQbIWpTczk7hW1Ici4Q=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Fri, 20 Mar
 2020 14:22:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 14:22:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for unique_id
Thread-Topic: [PATCH 3/3] drm/amdgpu: Add documentation for unique_id
Thread-Index: AQHV/rsBLdvy6y7Q/EWm1YwQnUTZE6hRiE8+
Date: Fri, 20 Mar 2020 14:22:05 +0000
Message-ID: <MN2PR12MB448840CF2D268831135E1258F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200320132407.9902-1-kent.russell@amd.com>,
 <20200320132407.9902-3-kent.russell@amd.com>
In-Reply-To: <20200320132407.9902-3-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-20T14:22:04.453Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea25875c-79ea-4de6-0be0-08d7ccda10ce
x-ms-traffictypediagnostic: MN2PR12MB4437:|MN2PR12MB4437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB443759416386677F7EB45C5CF7F50@MN2PR12MB4437.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(186003)(76116006)(45080400002)(71200400001)(19627405001)(966005)(478600001)(86362001)(2906002)(110136005)(26005)(8936002)(33656002)(6506007)(316002)(7696005)(53546011)(52536014)(66556008)(8676002)(9686003)(81156014)(55016002)(66446008)(5660300002)(64756008)(66476007)(66946007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4437;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hq8Miq2B6+iucUHQLYUzJ/kq6UKPjUEWJhRK0Lx29S7ORI5FLYC5y3VQ4YPv7rVWDErLlmH/bc/tzJUDFex2PyQBHgaAarU6k9y4CdKCKJ0gmGzk9rWHHJwA5FJytOp9SEhM+sQ0fvXw24l6V0axlek3CRYx8wrBKf6io0WvareVIMfcEKbfCHJleOLXN3oo02t30lrnE54VsUE1HZafAtPKx1ITFZbg3qCwAuf1jCksKY9+qIBx/+kekOYI0au34j7JOnUsKByQnYyyhaz35qB86ZKRM6SuIsjCn75Q1QKKU8Lu2zbAuM7Kd2XRAKyhHn5j+juWr3LS+AOwhefTQOjGkCDaJ1u8ADbOiY7F+4abmytWX4nYU+XT0xYg1jYzVBK2SQJ1bcksp0dz7hjBk7R4cNnnjF+Lt5BQq0Zwn+oGaP0DeF3nhK8he4NtBfI0Bp1djaEa6RSzWsxhfmyigzQxpV3zjPhLa2ZgADRDmjs=
x-ms-exchange-antispam-messagedata: ux/ApKslM9qe67tQypufroM4eBK6stOFCUqmIZwqYNa+AW2mPmohBogA6vW1pDS8RykIDPivFbNnJf69MrcDItKrGKxCWZeAf1W7M25plAaZ6/EQfbiSaJNJgefmUCvr1LeFffkUHwKdPGohf8v3kA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea25875c-79ea-4de6-0be0-08d7ccda10ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 14:22:05.1427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yh3Ci/3gqHc60iRjz2dVuUlVr07uDMWNX6gEjABJI17GwUzo/JDLl2b+iukBc7yQD2Tw4oyt2hdn0ZCRY4QyVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Content-Type: multipart/mixed; boundary="===============0908908724=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0908908724==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448840CF2D268831135E1258F7F50MN2PR12MB4488namp_"

--_000_MN2PR12MB448840CF2D268831135E1258F7F50MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Friday, March 20, 2020 9:24 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Add documentation for unique_id

Add the amdgpu.rst tie-ins for the unique_id documentation

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 9afcc30e0f42..4cc74325bf91 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -227,6 +227,12 @@ serial_number
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: serial_number

+unique_id
+---------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+   :doc: unique_id
+
 GPU Memory Usage Information
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ce80cd6be2dc74bc51dc308d7ccd2061e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637203075216673697&amp;sdata=3Dw7F1uiIEJMvJAbb%2Fs=
T6bU6zZ%2FboFgzwLHu9RpCMYuhY%3D&amp;reserved=3D0

--_000_MN2PR12MB448840CF2D268831135E1258F7F50MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Friday, March 20, 2020 9:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: Add documentation for unique_id</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add the amdgpu.rst tie-ins for the unique_id docum=
entation<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;Documentation/gpu/amdgpu.rst | 6 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst<br=
>
index 9afcc30e0f42..4cc74325bf91 100644<br>
--- a/Documentation/gpu/amdgpu.rst<br>
&#43;&#43;&#43; b/Documentation/gpu/amdgpu.rst<br>
@@ -227,6 &#43;227,12 @@ serial_number<br>
&nbsp;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&nbsp;&nbsp;&nbsp; :doc: serial_number<br>
&nbsp;<br>
&#43;unique_id<br>
&#43;---------<br>
&#43;<br>
&#43;.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&nbsp;&nbsp; :doc: unique_id<br>
&#43;<br>
&nbsp;GPU Memory Usage Information<br>
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ce80cd6be2dc74bc51dc308d7ccd2061e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203075216673697&amp;amp;sdata=3D=
w7F1uiIEJMvJAbb%2FsT6bU6zZ%2FboFgzwLHu9RpCMYuhY%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ce80cd6be2dc74bc51dc308d7ccd2061e%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637203075216673697&amp;amp;sdata=3Dw7F1uiIEJMvJA=
bb%2FsT6bU6zZ%2FboFgzwLHu9RpCMYuhY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448840CF2D268831135E1258F7F50MN2PR12MB4488namp_--

--===============0908908724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0908908724==--
