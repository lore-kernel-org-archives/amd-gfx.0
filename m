Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB88C55178
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A601E22277
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CPB56QxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A601E22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82E36E32F;
	Tue,  3 Nov 2020 05:54:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF0B6E32F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEMrXtrzN/nQlSehDa0YGkHDXpnGwn3vBvD8SV/Rt/QPuGIgB8eKlkCR+5aUoDp/Vs/bnzFfh398Xwq6HuGF70w24qUr0ilKeNKgy+LpSCzph1/30+GQ5LlYQfKdY9ffZuSLOVd47Boi2+DvYP75VBVohdye3m8P9mu8s91bFQHR8j7eSF8d2ogZB/Jg7YxG4hJwz05x5nmxBc5Irl0Gtg536ymEf343OoVgnW0citWqYDSaQvDHjGkVCpMmeOLfcHGHlAJ3fuZdK7vsF76vLXNnZBslzP2lduGQOusct7kdUWdSZqpVDNAjWguf+A58I0vnKew40A7Qvub9nNpQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lQd4tmU+xCcrc1LeJQhg4Rnxd+y/nPOXo2wOz4QBHs=;
 b=b7ejNa8mc3ipOqxCE2atggJusQrClIKavl48aJYDyXmKe8gxJLV4fH4XJtSe12oZcArjz4HFfbPNp13MFbBmcF+PWT2azgTyded5C8xRoJAOBPcl/IInobOKNYtoRi+L+h9FlBeFEPFBrwrVVg9H6ZFBrT8mASgea/LCP/rSQPCxAYMTHDat18eQ6vf5WowjLpDLhn6Ju3VQcyss5dwJy+3JZFd5861mDmVNaLDW6XZEZi0fzkFGOHAoLOxs3/Jg+gs5r5ekNIXvMxnpNXa6eNHAwHxkPfWLqDBwjnwU1QrCrqt5pD/kRSxezKCq4cjHeZBau73HYMAKRS9BYnk8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lQd4tmU+xCcrc1LeJQhg4Rnxd+y/nPOXo2wOz4QBHs=;
 b=CPB56QxRRyD6lupdm95Bp0UeSO5oeb/7Rgpn2c69QYHaScGxKrsnh7wXi6piz0rTU0KmeY9dGLMu++uejGEhoUtHgHBfgI4iiM+8C08oyaLMYYAjyatiA2EQt7Dab7Mvcdv5SfvSpSu3lvY+x3mQfTwMJNODmCJqwaGty266J8A=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by BYAPR12MB3493.namprd12.prod.outlook.com (2603:10b6:a03:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 05:54:10 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204%4]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 05:54:10 +0000
From: "Li, Xin (Justin)" <Xin2.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf message
Thread-Topic: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf message
Thread-Index: AQHWsaWgMFlJM7UJBUC6di87upUQFQ==
Date: Tue, 3 Nov 2020 05:54:10 +0000
Message-ID: <BYAPR12MB475914ECA9C601CD3FDFB8A0BB110@BYAPR12MB4759.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-03T05:53:17.5912212Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bda7bd56-0fd2-434b-523a-08d87fbce2ce
x-ms-traffictypediagnostic: BYAPR12MB3493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34935AE4531812E83D3ABB8BBB110@BYAPR12MB3493.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGobDiK4sucTTPS112oqSvhhcJGq7TvaDNTWWTR9g+SF34s3qMY4yPA3qFZQFmJLweZi71jtsZtb3IwtAvbnSzDy0XYHhBOSccAabYOqVQMRWw6qJ+drvpeLuyPp4LKU7cfcrviLaXYijbINR87LRzfll9lKZoJEjHV1IKu1pnwdC7XBpN7nTaAFGF3BRWts/oaZJ/8u1C/+m3/c93yuB+AQK0gfJTaIIzLSNPhEc1rZYMqS3EjWhbFUc3/Qb8S/Ejg1J6SMAS8p3rPILq1YKKWnW5pjeDQgT7SG49wR8Pe7b/CMatDh9Kdiim6IqHyKOWMefjJzv1hV3OytBHefpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4759.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(8936002)(6916009)(54906003)(15650500001)(8676002)(478600001)(2906002)(86362001)(316002)(4326008)(186003)(91956017)(55016002)(76116006)(26005)(9686003)(83380400001)(66946007)(6506007)(5660300002)(52536014)(33656002)(64756008)(7696005)(66556008)(66446008)(71200400001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: a2ppC1l8shBYCEgstkfioeZMfmgZeENWxANkbBOtyHfbIigM/8lzWB2JpdYriEwo7u7Yh08jlUOOy74GwRwPtaZ8/BneLaOAV7Q+JCDUop0zXQNCRGMvlNwaCf7vyDtYdqgacHuMe2kI4C0fgZbFMFfXi4waKy/udTPcmJUEFh7c/lrMxGXTaFVnEX4Ms2moVxnZz3eQ6ux/iObQyR5OqqxBZk5FHSucG/K6fLzyCyb+SVLoDBbRjnucMvG+YyYYEq3DPYi2IyjYMbaXo4yPJAdx1bcebJxyZ7QKuW+FiFm0PEC1afflcf7Q1tr9IkezlO7SunDgDxkKAPNkips5GO05Ev/flE+0xOZ6bs1944POyDF5Y/K3qUxKdmR9ruW4Bl6JEaO/yrT8TQ5SGZDYFsbp25uuiLp7MpBQOrhT3x0coZeEHl7NYmYXJuuBOFyBk8tmrd60SlM0QybxKanBNuXQWQ6Oftu+A5F2KKbQjxgeaBtIes7Jh7pJ3zqf4ReW7me3M6Ec6oOGBW6inEiaMX5xdzFzKRYLIdVHNh0Inqgy6RE+3nqcyCxB/lwJsCfTnlomFwLkHU9BPFZn7tc+vH3vL3KiUg4wYFh3SdWit1XZpuEVOtOYhuBKr+s6/BG4gPPnpV+VtV+a+wF7PvuFTA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda7bd56-0fd2-434b-523a-08d87fbce2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 05:54:10.7837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iI88v/IANnT5xUVmrF+XwdRq08MyK4F4sT0VlbAS47BISGH1XNRrRJdHXaLmzV3m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3493
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
Cc: "Li, Xin \(Justin\)" <Xin2.Li@amd.com>, "Zhou,
 Tiecheng" <Tiecheng.Zhou@amd.com>, "Wang, Yin" <Yin.Wang@amd.com>, "Wang, 
 Daniel\(Xiaowei\)" <Daniel.Wang2@amd.com>
Content-Type: multipart/mixed; boundary="===============1998616837=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1998616837==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB475914ECA9C601CD3FDFB8A0BB110BYAPR12MB4759namp_"

--_000_BYAPR12MB475914ECA9C601CD3FDFB8A0BB110BYAPR12MB4759namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Add checksum checking for pf2vf message

Signed-off-by: Li, Xin (Justin) <Xin2.Li@amd.com<mailto:Xin2.Li@amd.com>>
Signed-off-by: Zhou, Tiecheng <Thecheng.Zhou@amd.com<mailto:Thecheng.Zhou@a=
md.com>>
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


--_000_BYAPR12MB475914ECA9C601CD3FDFB8A0BB110BYAPR12MB4759namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
@font-face
	{font-family:-webkit-standard;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;-webkit-standard&qu=
ot;,serif;color:black">Add checksum checking for pf2vf message<br>
<br>
Signed-off-by: Li, Xin (Justin) &lt;</span><a href=3D"mailto:Xin2.Li@amd.co=
m" title=3D"mailto:Xin2.Li@amd.com"><span style=3D"font-family:&quot;-webki=
t-standard&quot;,serif;color:#000064">Xin2.Li@amd.com</span></a><span style=
=3D"font-family:&quot;-webkit-standard&quot;,serif;color:black">&gt;<br>
Signed-off-by: Zhou, Tiecheng &lt;</span><a href=3D"mailto:Thecheng.Zhou@am=
d.com"><span style=3D"font-family:&quot;-webkit-standard&quot;,serif;color:=
#000064">Thecheng.Zhou@amd.com</span></a><span style=3D"font-family:&quot;-=
webkit-standard&quot;,serif;color:black">&gt;<br>
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
--<span class=3D"apple-converted-space">&nbsp;</span><br>
2.24.3 (Apple Git-128)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB475914ECA9C601CD3FDFB8A0BB110BYAPR12MB4759namp_--

--===============1998616837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1998616837==--
