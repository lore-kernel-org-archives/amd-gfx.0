Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5404C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582A322404
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zbL13GQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582A322404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E268B6E056;
	Mon, 26 Oct 2020 16:05:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8516E056
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 16:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeyV/hybZbQkqpVwP8bi5PjmTYDE+MgBHz46kJPJXBX6TyTEli8XnrnrWjbmqswB6imJiQxgohUWlrytEtzNIAD6qrH1XnIeX8Mc3n5Wp4keM4EMqDxc+f/Oz0vmlE+7emEjvIqsrCbonIxqWhhhO+x5j23jfvBLHsCcp7+i131UpLwGokGQZkqWrLrZ9v6ND1ZkUqr//qUJgh37bYPdTWHme9rFpxjBQXGl/Tvj2pnmGen5UGF1KUFVr2rbo0W1p8xsL0yd1JvXCxAfe9AMPSEbBuTiij9dWZrLMZMAGeBAfHJOiBoe6kiDHXgO7yuu5Ysu2jFhgel4eOdTcVhqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENNV44RDm99OzqqqbbWkIUf3oHM+XuciH2EJhQWLlrc=;
 b=oEgOCICONdp2axPZqb7gKfvJ3u0ab8CDImorJJTsIC1g7b7DqjC2ltCIqpMBcgWsPtCzniIyRdprR7tEdZtVv+UXCcGO/g/rLIRdPmfzQH+gFLHPPQWlaLzQgxzWLzMWuN8bmVKJt49SPjhU/dVgClf6PSr1z9YTwEJxDf/v68Q1xNygDJCaOvSKEjLPHUbqIDaITPNlMOG6+aPzwhXfUbxOC4X2MlE1Yma9wLAhmgvJuPe+jvhnVID4uJ1NtF2s166Fkyu/14oWS0ARVX2kygezphgGATp5f9tMKoO+e9bif0FTsQiXNxqzbpE8rXQ0y7YiHBKb/FjlZ1m0ubofYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENNV44RDm99OzqqqbbWkIUf3oHM+XuciH2EJhQWLlrc=;
 b=zbL13GQuAldlT9P0dxpPA4FchEujYtXq0B9ujvknTl7j2UhHW7FTWiod7lCTHd+cZaNzwGDB1opziajXwBCfIjArCpeB4Aajkrw5MSrrPUkQqea6TDCbXEEQptlU9GuRifA3X06LeU6O38tI8pKz2g5UM7OZlCANDoZLBV6OdBU=
Received: from MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23)
 by MWHPR12MB1805.namprd12.prod.outlook.com (2603:10b6:300:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 16:05:07 +0000
Received: from MWHPR12MB1629.namprd12.prod.outlook.com
 ([fe80::6160:11b1:2c80:b56e]) by MWHPR12MB1629.namprd12.prod.outlook.com
 ([fe80::6160:11b1:2c80:b56e%11]) with mapi id 15.20.3499.018; Mon, 26 Oct
 2020 16:05:07 +0000
From: "Abramov, Slava" <Slava.Abramov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix abm shift and mask lists for
 DCN3.01/3.02
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: fix abm shift and mask lists for
 DCN3.01/3.02
Thread-Index: AQHWq7DIpKOwC/6zrkWZqtx3YxRmmKmqDAvl
Date: Mon, 26 Oct 2020 16:05:07 +0000
Message-ID: <MWHPR12MB162941559EB0C58B52627D54FE190@MWHPR12MB1629.namprd12.prod.outlook.com>
References: <20201026155738.964136-1-alexander.deucher@amd.com>
In-Reply-To: <20201026155738.964136-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-26T16:05:06.996Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:2f27:ffe4:adcc:36fc:ad8c:747f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 107e4f65-a0d1-4c6e-9ca6-08d879c8e894
x-ms-traffictypediagnostic: MWHPR12MB1805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB180520DC87F64FE76E7BE07CFE190@MWHPR12MB1805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1W3KOOnGPigxX1fNcijh5Fmtibj019W9lVvE30SvzEnYmNQoGOKYL3NsTqOhl4Hd4bd1mRFEAuVPVh41VwtPNMiovQqaTay2p5w60FmkDTdc6wsx5CZN92Kf/GPdfW199xVZwW7YK5xOapd2ixHv4wYp4x15TSet9TYNhISbfbA4BDCZZIRl1EkdituRW6+pfqetdc40CB5Pf6GcOZ8F3AZX0eHccnmwVYqgx9kvNnKkQAXHt79HRg35oMPu3lsxigh3vBBf9cvsxG1W7XZMxQ1gYa5YTMj9POUOJSe1HgGAmW5Fi4eb1jUZ+f9KHtnWgoV45ybM6i5trEwNzOf4FXMnrf06dJ5v2TTxtNCHTC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(66556008)(4326008)(478600001)(52536014)(19627405001)(186003)(64756008)(8936002)(76116006)(5660300002)(66946007)(66446008)(83380400001)(33656002)(91956017)(45080400002)(66476007)(966005)(71200400001)(55016002)(166002)(2906002)(316002)(86362001)(9686003)(6506007)(8676002)(53546011)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QXPP29+G7+RGh3VAde8hOyG2IsKjW5Eoxw7rCEk88ah6SVpBfdqpiFdVL40oNOriEkZijAwEL4fBb0x+syxFEcexM5elBFl6gQhQLJJna73bGJ3/mDXt0xbQXwOm/7S+yjFDdwl++XLntx09djxxrSEDG/2g3ouplZnEw+yIqTyG4zU109GmyNUK5eN9V7yj++CiQud+kdwjk6DhMhlaSj6Jout3Me2wgNzGDVABmMqdeGU17N2p3eLnKDA0CHBJ+4y9tO0ODmbdTttnjbi+RoSwDqvvrsRMYt6g7k48wLmyBrvQ9Lp/991isSarcSFiKN34sYBW6iQuGqA1tWr9m8xneDs2YPvspujA5W5YntqoXGE48i64+o2k1hEz2so7cgOA4xV8WoggD7JPwGr2c9N20nf2QgcxYkutsyTEOe9oRaacwD+ibovDNwSreS7eqqXfwrEJslkO0Tmt3pqpgWnS8Rr9BNPHjpiaIuWUNAnWOW9lKAp3MhjCSIwLgvGThzfxz2PIrAKz86QZEyUGRE8hQfjIracFR9ZPIMsmY7QN3TXn0NYPn5jTVZlAva19q3/Nvtv8OXmBqmA/WzCNsc5SwygtzBCoWLFuYBhh1N8ZUcntpzFo47XPB1geO8umfUi0VxgGjRWM7EaVxAtze9dIjEMheyNEvwFjVH0kYRUIirw+2UE9J1UWPr2C0VBKnC/fYSY3Zy1iqORyA6Mg/w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107e4f65-a0d1-4c6e-9ca6-08d879c8e894
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 16:05:07.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxCfglGW1e8pkO54ELUiPuKjkNoYcq6U36qrafhwL7lV82hYmx6LQSfxJBBARKhiZv1fHs+Wchjds5Lx05hFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1805
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1032278590=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1032278590==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB162941559EB0C58B52627D54FE190MWHPR12MB1629namp_"

--_000_MWHPR12MB162941559EB0C58B52627D54FE190MWHPR12MB1629namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Slava Abramov <slava.abramov@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Monday, October 26, 2020 11:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/display: fix abm shift and mask lists for D=
CN3.01/3.02

Updating these were missed.

Fixes: 2c8193fc72b1c5 ("drm/amd/display: Refactor ABM_MASK_SH_LIST_DCN301 n=
aming")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index fe46a0b911fc..5a47b4106b7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -363,11 +363,11 @@ static const struct dce_abm_registers abm_regs[] =3D =
{
 };

 static const struct dce_abm_shift abm_shift =3D {
-               ABM_MASK_SH_LIST_DCN301(__SHIFT)
+               ABM_MASK_SH_LIST_DCN30(__SHIFT)
 };

 static const struct dce_abm_mask abm_mask =3D {
-               ABM_MASK_SH_LIST_DCN301(_MASK)
+               ABM_MASK_SH_LIST_DCN30(_MASK)
 };

 #define audio_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 38e807f22060..c4ffed95d35e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1276,11 +1276,11 @@ static const struct dce_abm_registers abm_regs[] =
=3D {
 };

 static const struct dce_abm_shift abm_shift =3D {
-               ABM_MASK_SH_LIST_DCN301(__SHIFT)
+               ABM_MASK_SH_LIST_DCN30(__SHIFT)
 };

 static const struct dce_abm_mask abm_mask =3D {
-               ABM_MASK_SH_LIST_DCN301(_MASK)
+               ABM_MASK_SH_LIST_DCN30(_MASK)
 };

 static bool dcn302_resource_construct(
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cslava.ab=
ramov%40amd.com%7C12c425e35e00433fc62808d879c7e660%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637393246821297231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
jZx1%2ByKkYSfL3IO%2B7Eo0GQrX%2FQRsADRb1u33y6VxayY%3D&amp;reserved=3D0

--_000_MWHPR12MB162941559EB0C58B52627D54FE190MWHPR12MB1629namp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Reviewed-by: Slava Abramov &lt;slava.abramov@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Monday, October 26, 2020 11:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu/display: fix abm shift and mask list=
s for DCN3.01/3.02</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Updating these were missed.<br>
<br>
Fixes: 2c8193fc72b1c5 (&quot;drm/amd/display: Refactor ABM_MASK_SH_LIST_DCN=
301 naming&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 ++--<br>
&nbsp;2 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
index fe46a0b911fc..5a47b4106b7b 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
@@ -363,11 +363,11 @@ static const struct dce_abm_registers abm_regs[] =3D =
{<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dce_abm_shift abm_shift =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN301(__SHIFT)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN30(__SHIFT)<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dce_abm_mask abm_mask =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN301(_MASK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN30(_MASK)<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define audio_regs(id)\<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
index 38e807f22060..c4ffed95d35e 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
@@ -1276,11 +1276,11 @@ static const struct dce_abm_registers abm_regs[] =
=3D {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dce_abm_shift abm_shift =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN301(__SHIFT)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN30(__SHIFT)<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dce_abm_mask abm_mask =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN301(_MASK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ABM_MASK_SH_LIST_DCN30(_MASK)<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static bool dcn302_resource_construct(<br>
-- <br>
2.25.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cslava.abramov%40amd.com%7C12c425e35e00433fc62808d879c7e660%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637393246821297231%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DjZx1%2ByKkYSfL3IO%2B7Eo0GQrX%2FQRsADRb1u33y6VxayY%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Cslava.abramov%40amd.com%7C12c425e35e00433fc62808d879c7e660%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393246821297231%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;amp;sdata=3DjZx1%2ByKkYSfL3IO%2B7Eo0GQrX%2FQRsADRb1u33y6Vxay=
Y%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB162941559EB0C58B52627D54FE190MWHPR12MB1629namp_--

--===============1032278590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1032278590==--
