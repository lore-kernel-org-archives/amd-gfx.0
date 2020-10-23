Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18880C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 02:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A662075B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 02:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="myYU67yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A662075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0046E03D;
	Fri, 23 Oct 2020 02:19:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D804D6E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 02:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2MTIoVUKdONbsQeTw3zU9/MSvtaEiDibU2JAa3GDKrbEyLWi23fiOi/N5jNjiQwtjIw74ZmlfSC1I4lt4f7Az+lGB+nrRNujMP0PHVWXyDkAYzNuznYV5Xv5XZS35xt3fWxywQ6lug5A90PZb2m9i1J16pbfvcDBAizcDQ865ZUfBPVuy0l/3M4bmNY2YmAqXdTf6nBoXW80AG2lDTCjDudOZocbrmFOr+vMBjKitHsjqMOtZBSaPrbAYPDR+ZX5HtJeJp2FYSi27xDfoOryMF3EkkJsbQHifGR4d8ADLBI6VhEVMNIx70+C19xnmza/FiXHgWcaSxKAr60Y+IBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG0Pfpv+itf/Aed/fIAmFtxdkZhEt+gZD6aHJD6Uu4o=;
 b=gqk3OPTQyL10V6bclBFPvMDS4SqwVH3mKmlXyi+DiNUxUbcGRBbnxCyY8KNMDz1pAALM9N4KxsQjwwJ83SHOyKv7QMaME/dxJIDMoWswZFde8e8+YdZzlKcyCKHonP19W7KTCr3hTVHid+OGRmFXOixcvN1iFV69MLqYhqQWcH7TW64TMuKpxDfKV/bzhceyEK8gVpnNBicIaPX/2OsNAOYIFynxz3TAboRYDuLk9uJP108lrr3qdp0JVWuZgUhDdNzKludsN2yocWhRUWySDOhF5h1elU4+f56Me2j0cwfCMQEMzJJPZOYBbKrFnJ6VzqBH4DbQNaSnwDQtauMHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG0Pfpv+itf/Aed/fIAmFtxdkZhEt+gZD6aHJD6Uu4o=;
 b=myYU67yX5SRttFGUskzPiKM6fR0tUsDwc3mj3h0Bf2HCrXElLleHdCbk6KswBVbgqvrm/qDX75rslQDV6dJfZFpNXu6ULIuXQo7LcP8XnQ0pExO+hu+aidqjam2a+N8oPYxbHkCjzZ3s/NTe/huJOHhRHCx2+WsPMEKQLg1O+IY=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 02:18:56 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204%4]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 02:18:55 +0000
From: "Li, Xin (Justin)" <Xin2.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: DROP: Re: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf message
Thread-Topic: DROP: Re: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf
 message
Thread-Index: AQHWqOKrIB2Ytw97HUmEOdk0htcmR6mkc8Cf
Date: Fri, 23 Oct 2020 02:18:55 +0000
Message-ID: <BYAPR12MB475942AB4A785C3F2EEEA016BB1A0@BYAPR12MB4759.namprd12.prod.outlook.com>
References: <20201023021724.20433-1-Xin2.Li@amd.com>
In-Reply-To: <20201023021724.20433-1-Xin2.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-23T02:18:14.1869079Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5b397b4-df7d-47da-5189-08d876f9fe5f
x-ms-traffictypediagnostic: BY5PR12MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4194D6A909AFB2D927980206BB1A0@BY5PR12MB4194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWJmWQoZBIZfzBcu99bc9fsilppessB7/YZxndlki4akYEqZZd1459jBrMprNClo2TKhgXaxCmd9FIMCqsg0y1sIHAjqbAMt2pqDHMpNwvQ+Z/gP39Dukt33+zZBIsQbR+k3WEb8OBxFjoLgfwtGTtO4XKNDhydrgNUMieFDrXhX+avMNZMIeAH0XmoqAMZnz5k6bqjutl5EqPdj0dDEtAAIeclqiAFbZc2uFJmUnSiHdVbRgZ/s4x/nHFG0acYSkhaZ+a7ePkJ4LVcESe8Fyg40iL7OPxpDR5Pu0vmkiuD30WCZf18p4fNJd2oQtOiKH+i95RNrHRzzcd0Q+MJwKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4759.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(478600001)(83380400001)(8676002)(8936002)(6916009)(33656002)(4326008)(86362001)(71200400001)(9686003)(2906002)(7696005)(26005)(15650500001)(66556008)(54906003)(316002)(66446008)(52536014)(66476007)(186003)(53546011)(64756008)(76116006)(66946007)(55016002)(5660300002)(6506007)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iwpXccbUxnc9zhRO+5ADSVateNtprQCfJW1eWE8oxFybAN7fiJaZfNtg7mckrhDIFTG3YnMD5VvtPGXRP+z9fi3GvrShLo54rsc2nI+oi4d1tpEu30iPmMR8bSWDIy/uWkuTe9NoPsFCZj1fxjiONQcDFWyCyoRNoE262pgGFiQALqmJEq6givBDptYtAMwiXbSHEExw3zKGE28nSfPcTxXKGUyLij5skvemnWwu39rNdEVsftQ1H08Dtm7EnXB7UeOsPWWxauYWaS84kDTDmNKmDc8uTZUDxsPNKjRjkeH1mul9HZ13d2Z6s0pipw+Bhom70NzvQDqjQfks8aqUkXfFUG73s2Rj9SNjNTNu+aSG14I1qzCl7PQ1MFuczJhHK85uQa9N7Kcf/123m3VTdzdc3A7NuqQtDjdduvIhXC6V4lsEB8BvPUsF3MlMdicHaBO0Fn1oqNSVbdLvQfRNE0F6FOAui91GJBbkzEs7RWYEesvIaEtuVop7EgqkM3p+goHYJ8AQwQxiolayl28fLfEOF/okg9jWbG7V4IR0n2Nx/3YYZ9TrNbUM0VIcidFXRbW+hktt9CqxcwolcxcqNIcVMmW+UvCslJkrdm9NPCYoip1ETnp36Pd0IZfaye4Sg4qJhhAtUf10njMcHXcnbw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b397b4-df7d-47da-5189-08d876f9fe5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 02:18:55.8089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyLXyFCe2Tk4FVdBNMKwtC+oDZnSpXPeghYVjyAWmNciqvHPGQUCG+/1TPxOL8JU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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
Cc: "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>, Tiecheng <Thecheng.Zhou@amd.com>,
 "Li@justins-mbp.amd.com" <Li@justins-mbp.amd.com>,
 "Zhou@justins-mbp.amd.com" <Zhou@justins-mbp.amd.com>
Content-Type: multipart/mixed; boundary="===============1200583740=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1200583740==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB475942AB4A785C3F2EEEA016BB1A0BYAPR12MB4759namp_"

--_000_BYAPR12MB475942AB4A785C3F2EEEA016BB1A0BYAPR12MB4759namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please drop this patch, there=92s some typo in the commit message

Best Regards,
Li, Xin (Justin)

From: Li, Xin (Justin) <Xin2.Li@amd.com>
Date: Friday, October 23, 2020 at 10:17
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Xin (Justin) <Xin2.Li@amd.com>, Zhou, Tiecheng <Tiecheng.Zhou@amd.c=
om>, Li, Xin (Justin) <Xin2.Li@amd.com>, Li@justins-mbp.amd.com <Li@justins=
-mbp.amd.com>, Zhou@justins-mbp.amd.com <Zhou@justins-mbp.amd.com>, Tiechen=
g <Thecheng.Zhou@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf message
Add checksum checking for pf2vf message

Signed-off-by: Li, Xin (Justin) <Xin2.Li@amd.com>
Signed-off-by: Zhou, Tiecheng <Thecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 836d784456e5..bfc74533b5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -450,12 +450,11 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)
                         ((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->featu=
re_flags;
                 break;
         case 2:
-               /* TODO: missing key, need to add it later */
                 checksum =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_inf=
o)->checksum;
                 checkval =3D amd_sriov_msg_checksum(
                         adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
-                       0, checksum);
-               if (checksum !=3D checkval) {
+                       adev->virt.fw_reserve.checksum_key, checksum);
+               if (checksum !=3D 0 && checksum !=3D checkval) {
                         DRM_ERROR("invalid pf2vf message\n");
                         return -EINVAL;
                 }
--
2.24.3 (Apple Git-128)

--_000_BYAPR12MB475942AB4A785C3F2EEEA016BB1A0BYAPR12MB4759namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Please drop this patch, there=92s some typo in the c=
ommit message<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Li, Xin (Justin)<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Li, Xin (Justin) &l=
t;Xin2.Li@amd.com&gt;<br>
<b>Date: </b>Friday, October 23, 2020 at 10:17<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Li, Xin (Justin) &lt;Xin2.Li@amd.com&gt;, Zhou, Tiecheng &lt;Tie=
cheng.Zhou@amd.com&gt;, Li, Xin (Justin) &lt;Xin2.Li@amd.com&gt;, Li@justin=
s-mbp.amd.com &lt;Li@justins-mbp.amd.com&gt;, Zhou@justins-mbp.amd.com &lt;=
Zhou@justins-mbp.amd.com&gt;, Tiecheng &lt;Thecheng.Zhou@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amd/amdgpu: Add checksun check for pf2vf messag=
e<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Add checksum checking=
 for pf2vf message<br>
<br>
Signed-off-by: Li, Xin (Justin) &lt;Xin2.Li@amd.com&gt;<br>
Signed-off-by: Zhou, Tiecheng &lt;Thecheng.Zhou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 ++---<br>
&nbsp;1 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 836d784456e5..bfc74533b5ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -450,12 +450,11 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((str=
uct amdgim_pf2vf_info_v1 *)pf2vf_info)-&gt;feature_flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* TODO: missing key, need to add it later */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; checksum =3D ((struct amd_sriov_msg_pf2vf_info *)pf2v=
f_info)-&gt;checksum;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; checkval =3D amd_sriov_msg_checksum(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;virt.fw_reserve.p_pf2vf, pf2vf_info-&gt;size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, checksum);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (checksum !=3D checkval) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.fw=
_reserve.checksum_key, checksum);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (checksum !=3D 0 &amp;&amp; checksum !=3D checkval) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;invalid pf2vf message\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.24.3 (Apple Git-128)<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB475942AB4A785C3F2EEEA016BB1A0BYAPR12MB4759namp_--

--===============1200583740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1200583740==--
