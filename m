Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC16EC43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646132064B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AEpUppO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646132064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44046E1E0;
	Tue, 15 Sep 2020 22:03:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC116E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 22:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QodeM5GbaqqKQGH4S5CrzfPm64ryZPp4gkexlWCMcUegsPuSxC1Mga2CBRpaPCaApVOMgTMpGsq18SbJBrlLIi2b8PoV4rpeqjQEg4TpXMpy524j6D3hTIlnmCAjoAjr6R2ww9MeDgqS+Ds38GPZSBF8T6rAGSahKrgPTYt2tXMvvx4Th89yDKSsbMwkdczmVhGJXpDpQ7gerviQbjhXBA0IXiKYZSf7s1sAGs67MicT27n4maHlUruXsU1Fm7R0PI0RSSUopZt4BBJjU0PimnMCGoiRONdcfVQV5QXnLlNAcLWXAUoEKYv+h4M4hkbRWMC5SzsiEY3SRblHFhnfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCLbskuhHeQ0rs/LBfdWYqze8qCo+uYybv1nxIzAKLM=;
 b=Rlyt+d4DEvwKUB6z7dhRAJciQAV7VJ3ObcmnTH6GoODuanuQcqUOt9n1llDQ0oyLjk6EKQWA9VOJmT/aqZZXMj8t+R41GnQX3plI7YjwcEqNuVEcF4bKuFvtSaFrWEEfx6JQsRrxl8f2EsmhM1spqAK6tLyLSYyIo4haKX2IgKe1cUOqnsp6fIQU8HnxHloGzb90e6GAiRyIy4vWM9ymfnvI0ye6pOfqZeS4m47CoQZvyKMav+siVbg9H54gxYnmRecyeGwm1ahbf9k42dPg4Qydvd59hBNd/x5ZjEZrbvH13G08tEZAG/VPOqqp/hPc4pL7WoLoW7voR9UI4DHjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCLbskuhHeQ0rs/LBfdWYqze8qCo+uYybv1nxIzAKLM=;
 b=AEpUppO4sxjR2pRiBSyO8t4GUVF/akMMsnlHKOVbhxwvWNe+8OUtwZLkOJK293hm2bNI6fZAQ2B18E5vPxf+758FlD8rXwHWs+VzXKJRrGbU+EOQShkeqeeJwTWwLi7GSEaBIyI7roXlHI2UZj/4rs7auH0I8uTj7SPEBucCsbI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 22:03:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 22:03:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: Don't log hdcp module warnings in dmesg
Thread-Topic: [PATCH] drm/amd/display: Don't log hdcp module warnings in dmesg
Thread-Index: AQHWi6ieB4/j+Lsj+EeQgTchKLUuV6lqQKi5
Date: Tue, 15 Sep 2020 22:03:18 +0000
Message-ID: <MN2PR12MB4488FD47A0F141BDF1940E8EF7200@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200915213852.3383231-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200915213852.3383231-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-15T22:03:18.410Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de14e10e-e892-4b22-3750-08d859c32790
x-ms-traffictypediagnostic: BL0PR12MB2401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2401AC3EB4024EBB9F3B6516F7200@BL0PR12MB2401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GU1KMwPqkm7pXlFEWDxGA8r9qKqMnlsiTlHl4Nx71H2NtcGgXUnUw59C8TJX9vZC5GaStZj2l8u9SreLXTGu+lGvHWDE9gQqZymL2BDURCg+kH8j8VaEMOdZstuRWAMl0uXpzcUL1CFwh5ZDynMqDhjK8gvbSNITd/EAbMGrcXf0TxengkpbA4tudWf1suGJdhyc2oSvwOmMFMWC4kCYrRbjdGeoRd26WsrDlbjUO8WAaqyjDJiNEmHdU47yHLPVXSLfcx10npU4JwEJmtBtprA6Am7XwDQmldf6nWWHWqw7azRTvfFnUXm1jpVnF2XLYwkiit2q5V5an+cWwID04V5PQZJB6hFzMvJ8PZaKsZ9sTAM3CKggowzPPLabXl7o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(4326008)(55016002)(6636002)(54906003)(8936002)(19627405001)(8676002)(83380400001)(6862004)(6506007)(53546011)(316002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(71200400001)(86362001)(7696005)(52536014)(33656002)(478600001)(186003)(5660300002)(2906002)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uO8mr7RchWlNJ6UxNOzGwEDIJkA/EtLX7qdM5dc1khR4YEudX8R+T1AWAYnnFiplUB7V6nOy34LS97TymdJUXqpY+50RaiS2AurZGbntEJ8L6Y8z3kZkmKNW5zUuypBg/INA2x2f9e88ePmNNl7arCZb/A1aoFobvA19IVEE4LQhQDpohfQ+CukzoOcVsxEQJu0sJcTC05vpdVuUCkQehEUCWclpjc3zmuX/YD9uOXrVHwNHrIBIOrIskpzqcq03Wsvh7HHhImHw5nsblVtpQ5EScM2oJlcoNMDd/6PzuBOfQQGb81AOmRTubmjk2tOnoskQrofmWyAPqC2KOFYFsssLbH5TXeFMVePXmf/B2+eQPjLDUA7yGv58GVzoWRa+MpleY9YGGfaqzyXcMvdtUBQt9Eyi526Iyzx7MJ9qDBY4Up7VTgOYMeR/NasMyIymKnpw85MfOux3bW59Wm7rbCmCibRLr7C/0tp2vCnU1TJjiy9QGlc+DVThicOWrB/0axJGqtdDX9RgcGOT5h4tvl0Bpqh8evvaoskBj6OJ9ocp0OFbgYIenaPUvtGsRknXUYz0VBUZYi430NYdZdhM5ke2orcmwMHXdwBVAuN7010+iEep9rR5MSs+fbXaYDEf5+0apXlSJpxNECHpJ6CBIA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de14e10e-e892-4b22-3750-08d859c32790
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 22:03:18.9027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IZmCHppMZz6CM5nRFy2Bgh2HWBDmF62xnk0zXeVTEfjeZbCvmdcePcEcBaEBANtmvEP6Xhe06mf3DVFJyNRew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2401
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1472241133=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1472241133==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FD47A0F141BDF1940E8EF7200MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FD47A0F141BDF1940E8EF7200MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Tuesday, September 15, 2020 5:38 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Kazlauskas, Nicholas <Nic=
holas.Kazlauskas@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.fre=
edesktop.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Don't log hdcp module warnings in dmesg

[Why]
DTM topology updates happens by default now. This results in DTM
warnings when hdcp is not even being enabled. This spams the dmesg
and doesn't effect normal display functionality so it is better to log it
using DRM_DEBUG_KMS()

[How]
Change the DRM_WARN() to DRM_DEBUG_KMS()

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/=
gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index d3192b9d0c3d..47f8ee2832ff 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -27,7 +27,7 @@
 #define MOD_HDCP_LOG_H_

 #ifdef CONFIG_DRM_AMD_DC_HDCP
-#define HDCP_LOG_ERR(hdcp, ...) DRM_WARN(__VA_ARGS__)
+#define HDCP_LOG_ERR(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_VER(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_FSM(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define HDCP_LOG_TOP(hdcp, ...) pr_debug("[HDCP_TOP]:"__VA_ARGS__)
--
2.25.1


--_000_MN2PR12MB4488FD47A0F141BDF1940E8EF7200MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 15, 2020 5:38 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Kazlauskas, =
Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; amd-gfx@lists.freedesktop.org=
 &lt;amd-gfx@lists.freedesktop.org&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.=
Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Don't log hdcp module warnings in =
dmesg</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
DTM topology updates happens by default now. This results in DTM<br>
warnings when hdcp is not even being enabled. This spams the dmesg<br>
and doesn't effect normal display functionality so it is better to log it<b=
r>
using DRM_DEBUG_KMS()<br>
<br>
[How]<br>
Change the DRM_WARN() to DRM_DEBUG_KMS()<br>
<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/=
gpu/drm/amd/display/modules/hdcp/hdcp_log.h<br>
index d3192b9d0c3d..47f8ee2832ff 100644<br>
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h<br>
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h<br>
@@ -27,7 +27,7 @@<br>
&nbsp;#define MOD_HDCP_LOG_H_<br>
&nbsp;<br>
&nbsp;#ifdef CONFIG_DRM_AMD_DC_HDCP<br>
-#define HDCP_LOG_ERR(hdcp, ...) DRM_WARN(__VA_ARGS__)<br>
+#define HDCP_LOG_ERR(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)<br>
&nbsp;#define HDCP_LOG_VER(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)<br>
&nbsp;#define HDCP_LOG_FSM(hdcp, ...) DRM_DEBUG_KMS(__VA_ARGS__)<br>
&nbsp;#define HDCP_LOG_TOP(hdcp, ...) pr_debug(&quot;[HDCP_TOP]:&quot;__VA_=
ARGS__)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FD47A0F141BDF1940E8EF7200MN2PR12MB4488namp_--

--===============1472241133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1472241133==--
