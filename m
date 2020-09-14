Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99930C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 17:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0881720759
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PrGeFfFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0881720759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9743C89FBC;
	Mon, 14 Sep 2020 17:46:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7F489FBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 17:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foa6MCgvkRxXyLAMPTevl5tdpmvwwlM7fNANhm+E2bGYz1FvQLARRL1fcRMmb3hAxtt1S0t0qz/zPBbFA29Oizg2x8L3xiKGEnpPgtCf7k5Eycdov+nJxMheXJjHzLOtaM9L490HaJ7edqRnmNsSgsypZSVv2SagI2A0Jy+dksk3zMPwf8quYkZ3C4T8PfX4d9BRAWNrEX54xRkTdYATPXj+/7SIxmbro8rbKRLJG2kWexZOYkZ0H8yQB+LiQhPXUoAnOXMsCxDXdN+2nkFkNxUwAQsTiPaKccpKuCUK9r/WHirtCS6QyjDKYkrHnvcJRKwJnUKXoEbc93MB2cd+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUCXRtQ4rpNyZghFsimz4qidc97KP/Y0i3Le/LKumw=;
 b=ZA/nOQFCwuHr5CO0/ornfh8aSrNyexVNmh2+OwlsxnQwQvOpFqdDqCgAk7xhknPb/hOr+ruz1zssbaiG2/R4M+mYjlscwPOaYrtc/hthiTmYv85sFv/8VRmqF1dLp1vpEtQ0AEVHvoWM1CtZMzBw86k65kPhUVUD734Xf0xHx9x/5xDLEQy8MglLdhP68U1b0hfmIrjild0UagsQp6GWRqguBay+3v1W5gcoQOnr5n7hBr/s7skF++LYXiVoeqCulo87b5DMcmHTsknCW0b3jUxoSP0EP0VVNy01Px0R0IxnjqK5APo8Z24hoqsnrdHCYv9jhaDi0YPyOAXrtVO2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUCXRtQ4rpNyZghFsimz4qidc97KP/Y0i3Le/LKumw=;
 b=PrGeFfFYHoyDetucRLUk1pm3e36Ng3Bu356QuLGB9c5ElB0aanSlhn/H/2hFtO3RyjjgwUduCu/SflZfd5TAo/i3x3tRY1vDwbB9+zIQG+m9YHouZPsUPc4lxIZ2JBrFTW1NYN60ae1+vqrz0I6tB5fSICou+07E9M5RfWUDpHQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 17:46:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 17:46:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix a typo
Thread-Topic: [PATCH 1/1] drm/amdgpu: fix a typo
Thread-Index: AQHWhfgqtHfoZ0eYE0++81IeiI87C6locdVI
Date: Mon, 14 Sep 2020 17:46:20 +0000
Message-ID: <MN2PR12MB4488D0EE04468DFDE1E18D49F7230@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200908155702.17314-1-nirmoy.das@amd.com>
In-Reply-To: <20200908155702.17314-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T17:46:19.808Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8100faa-ccdf-45da-0f97-08d858d61717
x-ms-traffictypediagnostic: MN2PR12MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4454660FFD806BCFD4169968F7230@MN2PR12MB4454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNFj2sjylQ7/LD3Z9UhGfWVsO94Z9S961BLXDrjgFtofcK/Hvdhku4r6NsnOKWyTMfyuBIA8aLuxuMw7X7HE+WfogVaudzZ1/jnD258FqTvKsTOk2KMt7AF5gnlfOnf/H3p5ps3ZsUaGCgBQxWqpAOJzE4X7g9cszTr8zTmGxbrf+y7uP+dmH1l6D9a22T09nPNVYs2/dXb2G5LAHuk/4P4lBp9r3/LDVBBLZ+ymZCh0XeKTk1e6K+qjSUDMZW3Yhjkd3fkE1By647WA21N0LuQPb/nsRI+8RQdcfCM7EkCdn7uiljB5rFvvSjN45crSJSGbLLbXUe/n9g7zC+EzarLmX9UFYGS9ruL0o0jLWnc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(966005)(8936002)(9686003)(66946007)(33656002)(55016002)(316002)(8676002)(4326008)(26005)(45080400002)(186003)(83380400001)(6506007)(76116006)(53546011)(478600001)(19627405001)(86362001)(2906002)(52536014)(5660300002)(66476007)(66556008)(64756008)(66446008)(7696005)(71200400001)(110136005)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aFkjK82K95jKq9bouicXFAWmyeDD891BwUSTTVFE5slS5yVvX6zG+VPthAWUIF4o0dhDmqhU+/CkG7N+zM7OfGigA6wV96eyxODx7xCcfCSMvdLz16uSow068MIT6Ldm7sjZ4Bc+gUeTWfOaCHLsRRgN2aTb70si9hu7RijgDCwQdzsby3bTr+6e57PIr7INgeqKqiBfufuWkfYMDfi1MxNlsuaAcAg8fTk/ZBN378Ku4aS/2qTkSDpMFjDp93QzixNLQBeUJ2CxhQByIoSXu/mUwqvWG6GCYaz04dhO+fPPg6HFw2QNXaOhCnS0Z13d6e+HfUyTqiuejbfpEgJLihTNLYs4JWgMrxLfu345mAINpk8S3oGRxTHPqnZAn8L0GWBn2BlETYxB9h722n9izN5J8EeQ0S02udD/N0fQTPpAJe0mIq8nQEUuF8PFGLFzOOg29ptNJYNhnoSnzSGNhO7PRwqTzAGL1ZqaatuM/5NqTTsxJIJSDONYgE7Lz7ti+q20cw+pqqMRQNxqAWVv1JFl8Tzn7OZHzZzDo1dLQpgztTen2AVsIye4o+U1h6weulhemyhqgejKNIEevGoN1XKDL/jPLB6LWk4aDf1jL+IKf0Nf46XPXl6GfA28zU2VZ1u73nJ7Tc8mgWnbc23dow==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8100faa-ccdf-45da-0f97-08d858d61717
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 17:46:20.5184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rz+y0kxB1lK5CsVE0s4iefl8iI/NuF7ulwMcj9Fl0HVXMhfJs3EKg5Sav05dXSjamsTipYkMYHJcB60Ptbz+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1228166888=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1228166888==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D0EE04468DFDE1E18D49F7230MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D0EE04468DFDE1E18D49F7230MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

This is not upstream, but
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy D=
as <nirmoy.das@amd.com>
Sent: Tuesday, September 8, 2020 11:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlau=
skas@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: fix a typo

Fixes: 9a0154630e958a2f (drm/amdgpu: Bring back support for non-upstream Fr=
eeSync)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b826f2d6efe1..d3dadf10b13d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1096,7 +1096,7 @@ struct drm_amdgpu_info_vce_clock_table {

 struct drm_amdgpu_freesync {
         __u32 op;                       /* AMDGPU_FREESYNC_FULLSCREEN_ENTE=
R or */
-                                       /* AMDGPU_FREESYNC_FULLSCREEN_ENTER=
 */
+                                       /* AMDGPU_FREESYNC_FULLSCREEN_EXIT =
*/
         __u32 spare[7];
 };

--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C7f09b7d46fde47c781cf08d8540f3bb0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637351771962233619&amp;sdata=3Dt9hpqDYdTNU2bKoOTiG=
Oi3bJvRhYZqCdzVdQ3Xv8dUk%3D&amp;reserved=3D0

--_000_MN2PR12MB4488D0EE04468DFDE1E18D49F7230MN2PR12MB4488namp_
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
This is not upstream, but</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy Das &lt;nirmoy.das@amd=
.com&gt;<br>
<b>Sent:</b> Tuesday, September 8, 2020 11:57 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; Kazlauskas, Nicholas &lt=
;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: fix a typo</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes: 9a0154630e958a2f (drm/amdgpu: Bring back su=
pport for non-upstream FreeSync)<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;include/uapi/drm/amdgpu_drm.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index b826f2d6efe1..d3dadf10b13d 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -1096,7 +1096,7 @@ struct drm_amdgpu_info_vce_clock_table {<br>
&nbsp;<br>
&nbsp;struct drm_amdgpu_freesync {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 op;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMDGPU_FREESYNC_FULLSCREEN_ENTE=
R or */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* AMDGPU_FREESYNC_FULLSCREEN_ENTER */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* AMDGPU_FREESYNC_FULLSCREEN_EXIT */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 spare[7];<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.28.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C7f09b7d46fde47c781cf08d8540f3bb0%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637351771962233619&amp;amp;sdata=3D=
t9hpqDYdTNU2bKoOTiGOi3bJvRhYZqCdzVdQ3Xv8dUk%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C7f09b7d46fde47c781cf08d8540f3bb0%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637351771962233619&amp;amp;sdata=3Dt9hpqDYdTNU2bKoOT=
iGOi3bJvRhYZqCdzVdQ3Xv8dUk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D0EE04468DFDE1E18D49F7230MN2PR12MB4488namp_--

--===============1228166888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1228166888==--
