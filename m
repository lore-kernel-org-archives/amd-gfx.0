Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00037C47409
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB34206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EW6ST0K4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB34206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACAC6E909;
	Fri, 13 Dec 2019 15:41:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E81C6E909
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 15:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQCw0Zk/oh/Dz0d5zY2bkNpWd0A4GYjY4mZlW3D31DPDgNyWcpRZRN2jn8IIfU1URazbByK/hh+pNUMZ3LxB6gSVBQvn0m/G0tAohAe4eJRRU4Bin8w0HxW4AZuZr0hFne8cpqoiupgV0L8nHno3fOOzEP0PPoIQZNRew3cY3AZentJxo9Xve7rcIQS/d6O7RnzrMS7wbJaLJnABiuSu9WVakBiROZVCMRMHYFWNul4rDB7XgtMPS96w5yKb8cKaDe7KGEY7hTz2dM2Y4RGYhqcIAU2HJV4B3Y8oIYFri6p1rIkWiNDNECK1ZEgw9j4InqjXeD/xRR+Ntt7uNBo/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwO1GdPVViJ+FUFpMqIFH0kPbwTcwq+iantIkk7dSqM=;
 b=P9gclc1O0yv7rjCB6hZxM1OCaHink7tbJJo4A4yY8YWnwG/s/1pLyHQg1+f5y6e1qhpPrGoX6RnLxlZ9jBTcbNBSd7ORDQTlWXmTH+pXFcHQBrTWuTeYY1Vm21oXZibw2kvZyWT5u2l+Vmd1v68pP5l2nBGxyJRf7n/dXb64CE+rfWOrTvJj9G9d+vzZ5otUwRxXyCrkZvzzf9+rK0yyid5AlWsDpP8ag2hksuEROxUszVwtfsKfJAaUMf0FfMaaUHoibPpRrsIG/wjJ3cdcbAz2XU5R6tOU25PnEuRhotmwd1YfqnkLWwIrOJUW9HHmPn/NflE+/Un5sx8C8+VXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwO1GdPVViJ+FUFpMqIFH0kPbwTcwq+iantIkk7dSqM=;
 b=EW6ST0K4Dn9QRwWnfFJwTgkzBq9qGKVbofkd5oNPC7XL4kR+p6XvJx/gVCCiQ4JD45Zdm5CU6PnnBk4fgL/7N93zuGgkCobpI49jPs93S8jlvazz/5GXfHjTGftc7qpoho1sgF8ZXSlTKi8Xahl0T7SZ6sxEGFrAcfAU7t6sczA=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1407.namprd12.prod.outlook.com (10.169.207.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 15:41:56 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 15:41:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liang, Prike" <Prike.Liang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Thread-Topic: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Thread-Index: AQHVsWTRRSig7pvBU0uXfZob4Ixlo6e4NNrg
Date: Fri, 13 Dec 2019 15:41:55 +0000
Message-ID: <MWHPR12MB1358CFFEAA48B086BB582D21F7540@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191213032400.12829-1-changfeng.zhu@amd.com>
In-Reply-To: <20191213032400.12829-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-13T15:41:55.218Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24edc074-08f5-48da-f2a9-08d77fe2fbdd
x-ms-traffictypediagnostic: MWHPR12MB1407:|MWHPR12MB1407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB14071C11EA549FB249AD5933F7540@MWHPR12MB1407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39850400004)(136003)(199004)(189003)(316002)(66446008)(26005)(9686003)(66556008)(81166006)(81156014)(8936002)(8676002)(33656002)(66476007)(55016002)(64756008)(110136005)(66946007)(76116006)(7696005)(6636002)(6506007)(86362001)(53546011)(186003)(2906002)(52536014)(478600001)(5660300002)(71200400001)(19627405001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1407;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IefjECZAMg0amzlvJoQJ/DO2bTepb/PjA64tK7UhuW+EEsBN6d5kRQO4PW5GGmK/Bg056ENk+xon7bti1qxaICu3mRF4Pj9jKQZkAS6V90cWCtKTqbVhVeuCh+ugJv2e2fBQqnJanc3xQcjgsDlcGPje9dHEgU+tkyVIzULUUfoptqwJUKDBEyNBdt/EpzZqkdxotrqOFWAdcvLmaKDcQ5hy2IYzaNg7dObWHABYOWgirml0bKK0jU3KELGb+6KuFlWRbdK7VqwjUyt8wutAE7vvC8FGCM2ulrekMkZcIeI2jUx+0jCXxIhaPlA2FVI0U9DDkvzQJZUhZRT3EawpxFyHwG614pz8HukBx26S8B1kq6uvQeR8NB9zYZABL1VFn5KjIvzY9MtWkacHFXUV7FEYDJft1QI2EjauFQ37pTxhzAFyBq6hv3WXbxhr6GeHpt4x10WJldOpp3DcPxTfINwSixbfRTHB1AgeFhJityuDhiq9EGmfFm6KF3TuTBrv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24edc074-08f5-48da-f2a9-08d77fe2fbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 15:41:55.9208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJuuaLof5qOu7FDc2X2hYjKwPDpRi4YeF6p73Gd92KvPd0YCFzcxi46G3NLaN1tJ0YJYEGkuttuDENQFcERnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1407
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
Content-Type: multipart/mixed; boundary="===============1024906795=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1024906795==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1358CFFEAA48B086BB582D21F7540MWHPR12MB1358namp_"

--_000_MWHPR12MB1358CFFEAA48B086BB582D21F7540MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Sent: Thursday, December 12, 2019 10:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Liang, P=
rike <Prike.Liang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Huang, Ray <Ray=
.Huang@amd.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh

From: changzhu <Changfeng.Zhu@amd.com>

When smu version is larger than 0x41e2b, it will load
raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it
needs to avoid adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK when it loads
raven_kicker_rlc.bin.

Change-Id: I4dffa1783c9ceb5d40df9756d821e2cd7feff84d
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index ea58d0e5be4c..68409bb7c9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1038,17 +1038,10 @@ static void gfx_v9_0_check_if_need_gfxoff(struct am=
dgpu_device *adev)
         case CHIP_VEGA20:
                 break;
         case CHIP_RAVEN:
-               /* Disable GFXOFF on original raven.  There are combination=
s
-                * of sbios and platforms that are not stable.
-                */
-               if (!(adev->rev_id >=3D 0x8 || adev->pdev->device =3D=3D 0x=
15d8))
-                       adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
-               else if (!(adev->rev_id >=3D 0x8 || adev->pdev->device =3D=
=3D 0x15d8)
-                        &&((adev->gfx.rlc_fw_version !=3D 106 &&
-                            adev->gfx.rlc_fw_version < 531) ||
-                           (adev->gfx.rlc_fw_version =3D=3D 53815) ||
-                           (adev->gfx.rlc_feature_version < 1) ||
-                           !adev->gfx.rlc.is_rlc_v2_1))
+               if (!(adev->rev_id >=3D 0x8 ||
+                     adev->pdev->device =3D=3D 0x15d8) &&
+                   (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh *=
/
+                    !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save resto=
re ucodes */
                         adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;

                 if (adev->pm.pp_feature & PP_GFXOFF_MASK)
--
2.17.1


--_000_MWHPR12MB1358CFFEAA48B086BB582D21F7540MWHPR12MB1358namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Changfeng &lt;Ch=
angfeng.Zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 12, 2019 10:24 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd=
.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;; Huang, Shimmer &lt;Xinmei.H=
uang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
When smu version is larger than 0x41e2b, it will load<br>
raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it<br>
needs to avoid adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK when it load=
s<br>
raven_kicker_rlc.bin.<br>
<br>
Change-Id: I4dffa1783c9ceb5d40df9756d821e2cd7feff84d<br>
Signed-off-by: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 15 &#43;&#43;&#43;&#43;------=
-----<br>
&nbsp;1 file changed, 4 insertions(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index ea58d0e5be4c..68409bb7c9e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1038,17 &#43;1038,10 @@ static void gfx_v9_0_check_if_need_gfxoff(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Disable GFXOFF on original raven.&nbsp; There are combination=
s<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * of sbios and platforms that are not stable.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;rev_id &gt;=3D 0x8 || adev-&gt;pdev-&gt;device =
=3D=3D 0x15d8))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_f=
eature &amp;=3D ~PP_GFXOFF_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (!(adev-&gt;rev_id &gt;=3D 0x8 || adev-&gt;pdev-&gt;devi=
ce =3D=3D 0x15d8)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp;=
((adev-&gt;gfx.rlc_fw_version !=3D 106 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gfx.rlc_fw_version &lt; 531) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;gfx.rlc_fw_version =3D=3D 53815) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (adev-&gt;gfx.rlc_feature_version &lt; 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; !adev-&gt;gfx.rlc.is_rlc_v2_1))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!(adev-&gt;rev_id &gt;=3D 0x8 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pdev-&gt;device=
 =3D=3D 0x15d8) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pm.fw_version &lt; 0x41e2b=
 || /* not raven1 fresh */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.rlc.is_rlc_v2_1)=
) /* without rlc save restore ucodes */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB1358CFFEAA48B086BB582D21F7540MWHPR12MB1358namp_--

--===============1024906795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1024906795==--
