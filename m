Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A8C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 02:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC56223B0
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 02:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NP9m3RXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC56223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AA06EC7A;
	Wed, 28 Oct 2020 02:53:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD746EC7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 02:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBM5KB+49vM4EVFzjEXr4IhzzdgEphiDhCYV356adjOoV0nnj6qrAZ7z7n5HZGUNbRlSJI6Y7TXReK3YahSVXyDuCGMaoA8vz+Yr8zoEEMRDjhHF4E1V4dhFh+YG/yjk+tNvxxfIpxEvjkfEq06pQefm9Nkyz6bxcFW0KsFJRbretof3inUKr4ETXiMvmVMTImawkwI54dxj1mSv0+19mOjC2jMlUM3Xzimf8cgMwQr/0lFhM9vtqZgSl7F49S0IVfRyaxXFl0FwwgE0TJcCcyIAiKdioixwr+QV283lYoInZ23n8KV4xAUOTDs567Aoep6lOnIGZlljgj2qUvXdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCwztZMYm43TdGfzhzXKttB8/xj6xFTNtrNxP7mqWkI=;
 b=PlkQ5aCtZCgcEHcfV5WpENFXQ9I+R/ZrpUy1OibCdrJz/yf/bV04udljlCQ9myDEOGwRSBuKrzbEwiKUWTdfxonqpsdC/J3hLsb1BXlOiiDFpEUp7usuD2y/1cou0HJgh7cR2iGUq+y7UU3fU6Zn+E8IphGqky6Uabe3mXeaa7HqiSvfnzJ+K5RtkmODw16eAjNuHCyCd5GcM5X9+BJyo8Ptjz2XJAsaq8TkR/FtsuiemHT0iN+YV6euur5xpnov/lWZz6dVa1bLhu69gcSvIbFAL5/IzPK3DDdmPioqlIc0IazA+E1yjLdv7QCVFOUi8Jc7c/zV1Jgs1WI7ZKeqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCwztZMYm43TdGfzhzXKttB8/xj6xFTNtrNxP7mqWkI=;
 b=NP9m3RXYySyIV0YyGcitoldOANL7MaHsziQh8/ltEsnOjySY2baILrjR1LLwPOntpUPEKAmb3YYzOr/0X6T8Mbc5In396AVC9LAdXJo30Sl7ocjybp0F4ISxei6H8OacA/jQEvla3tV05OpKvbD3qoRauCWFGXoYwWXOE7zlfAo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 02:53:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 02:53:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: fix compile warnings about variable used
 uninitialized
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix compile warnings about variable used
 uninitialized
Thread-Index: AQHWrNR/ic814Y/HHkaFciHhhKxzq6msUTcg
Date: Wed, 28 Oct 2020 02:53:15 +0000
Message-ID: <MN2PR12MB4488473C9A950F21A0ADA5E2F7170@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201028024541.1164776-1-evan.quan@amd.com>,
 <20201028024541.1164776-2-evan.quan@amd.com>
In-Reply-To: <20201028024541.1164776-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-28T02:53:14.910Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e5a7740-464f-4329-d16a-08d87aec9df8
x-ms-traffictypediagnostic: BL0PR12MB2402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB240272F4950D31987E49F4BDF7170@BL0PR12MB2402.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDq7mWk8VMKAWRRu4rz9L4mRejbFGK9TDnHLn0Lr1xsIxZUZmaRGhwXJaO2ZiAsDrt+5V9EC0W2p6wvMgHcNiWuQrH8XZbpwTlgDV2nUgNusPWuQAPyevkTWhBr3IfClTn0rxVFZaMqmnGyz3KI5Fl9S5s3oc/G6z4cLyaQ+qv/7gRRnFgfHd1gtkgHXlfLKZWNZhJkf6S8DQ6nK8illm8O26uDHtxjsSqfJxVXs5ouesNS1xv/Rk7qqys/aGB3rRaql/rOg+GMWApMAdfMM+f4oArHqeesZ9fH128bLXhv7HKg48xmZRQEJ9EVZQMdA0nfzqpck/xRA7qUSNLYNoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(64756008)(66446008)(66556008)(55016002)(7696005)(4326008)(316002)(26005)(8936002)(9686003)(478600001)(186003)(19627405001)(76116006)(86362001)(110136005)(66476007)(6506007)(66946007)(83380400001)(2906002)(53546011)(52536014)(5660300002)(71200400001)(33656002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 18TbtL2FilS76DUePk9VIm2x1KuGWGKRcyFo18TR4XYgpvQpL7kyoRbcmvH95rvx1bw1zOHFYFGyIyGDJqmLMjwnBrK+sWTNCGDBU6wdHl6NntoJUPK58DumPdgnhz+VR0tQ3mndv/w0IilsMEmNONVEWlP4oi3Fc/DOJk7zcPUB92tSyQxT6JSyHR3cZFHW1T4j8lEd/xfnISAY5bAiaHrcdNrJ4p0CrLUtuy9dSWkcYvgeOTgCXShS5/6liUkJABDCWdxUE6vEdHVhvX5DXEf531+1Q3j1ZSyta2gfdJYTOM7cNmYshy1j+RLEL9KMiIxN2aMzQOcTGbjQ977o8w/fGTMc+MnVNcoc4pY1+LaGbtWm3T48kDCxfdFCvoLXaWCOekWyacnRARXoLntXhV8SgI94bB2/C6XjuxaJpn6l4rRLfOm1JUx2c/gMuDlEoQk052ImIKMVixY9soXxejs6+Iz1XDzIn3DBpXb3NUvRzQqtabhxooVffPK7KLsVSeQUK7ZZeklPNApD+/sLQ2OQE6WJLVzeScw2v36OdLGD0vbunMlT0e23yhvHW5oSh06A4tYLkhI8bSVLADtFLQXYnvffsgXQG/k5kupDwnbCHkhwN5zd6Fhy57CAc3hDqjcbx2aJ2w+uiGyphwpZgg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5a7740-464f-4329-d16a-08d87aec9df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 02:53:15.3527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZKp3aohoF8aSlh197wL+DD7b1Uuf3SfrTIWvx5Fby0FIs2S1ZBtEQnjlHqwPlWtY4mwdhKJSKbHKm+IlDaXRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
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
Cc: kernel test robot <lkp@intel.com>
Content-Type: multipart/mixed; boundary="===============1655810983=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1655810983==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488473C9A950F21A0ADA5E2F7170MN2PR12MB4488namp_"

--_000_MN2PR12MB4488473C9A950F21A0ADA5E2F7170MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, October 27, 2020 10:45 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] drm/amd/pm: fix compile warnings about variable used u=
ninitialized

Fix the compile warnings below:
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1743:13: w=
arning: variable 'min' is used uninitialized whenever 'if' condition is fal=
se [-Wsometimes-uninitialized]
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1743:13: w=
arning: variable 'max' is used uninitialized whenever 'if' condition is fal=
se [-Wsometimes-uninitialized]

Change-Id: Id2dece80162cd10f004abbf3b62cba0c84e988f2
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 49db61a89505..5937150e6b37 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1856,7 +1856,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr *h=
wmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
         struct amdgpu_device *adev =3D hwmgr->adev;
-       uint32_t asicrev1, evv_revision, max, min;
+       uint32_t asicrev1, evv_revision, max =3D 0, min =3D 0;

         atomctrl_read_efuse(hwmgr, STRAP_EVV_REVISION_LSB, STRAP_EVV_REVIS=
ION_MSB,
                         &evv_revision);
@@ -1893,8 +1893,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr *h=
wmgr)
                                 max =3D 2500;
                         }
                 }
-       } else if ((hwmgr->chip_id =3D=3D CHIP_POLARIS11) ||
-                  (hwmgr->chip_id =3D=3D CHIP_POLARIS12)) {
+       } else {
                 min =3D 1100;
                 max =3D 2100;
         }
--
2.29.0


--_000_MN2PR12MB4488473C9A950F21A0ADA5E2F7170MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 27, 2020 10:45 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; kernel test robot &lt;lkp@intel.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: fix compile warnings about variable=
 used uninitialized</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix the compile warnings below:<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1743=
:13: warning: variable 'min' is used uninitialized whenever 'if' condition =
is false [-Wsometimes-uninitialized]<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1743=
:13: warning: variable 'max' is used uninitialized whenever 'if' condition =
is false [-Wsometimes-uninitialized]<br>
<br>
Change-Id: Id2dece80162cd10f004abbf3b62cba0c84e988f2<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 5 ++---<br>
&nbsp;1 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
index 49db61a89505..5937150e6b37 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -1856,7 +1856,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asicrev1, evv_revision, max,=
 min;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asicrev1, evv_revision, max =
=3D 0, min =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomctrl_read_efuse(hwmgr,=
 STRAP_EVV_REVISION_LSB, STRAP_EVV_REVISION_MSB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
evv_revision);<br>
@@ -1893,8 +1893,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max =3D 2500;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if ((hwmgr-&gt;chip_id =3D=3D =
CHIP_POLARIS11) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (hwmgr-&gt;chip_id =3D=3D CHIP_POLARIS12)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; min =3D 1100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; max =3D 2100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488473C9A950F21A0ADA5E2F7170MN2PR12MB4488namp_--

--===============1655810983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1655810983==--
