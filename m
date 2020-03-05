Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C974FC3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE2721556
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ih+Ci5/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE2721556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E71A6E0A1;
	Thu,  5 Mar 2020 11:39:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C96E0A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 11:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXdNWWwSx0m/XU9h3KxdEVB6vVWRrEwTAhSy3Wu/VZBmn56I4zholredGDCtzy1YpVMJR/4H9rhTxJ+BMODlELJPSqfyqNdYbb2pO0SL1EvqQKBh/BWBo7+qc9W3VJ85RfOsxl2yeoTVsKnXwZ9+yWEUtCmwuOmqQMlTPLqD7uIPxq97iW1daBR3/GcKF2q0BMMB8PAL0s+vLfK4eXosWFW5Fr8eQiKwlb2+g+1bdycUrWv6sy/2pOztq5EyTq6CrqARR1D/f7ZptlyJ5QB5sIiiSFumR/5KI0KrWhSXPbPXBZHH0O9XyV8McEvpwRIRH2JP8S1jDEzudKE7U6KumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR+tWW4LXaku/IKwKZ5/p4a0mW8K5t+pqeBlcc+aD5M=;
 b=GSsrA/wf6W/xVe1Pj9kZ7nJCvpX7oi1jG/IaZVDlUbmMVO534MUweClrCHTw/U9TALXIdDr0Ngln7KaUX/maWI8kG/2HS3UQpNnKYru7iVVMSJeUstvu/sB5DeLNDd62GDzv/YLyNMxUrZDZeimwHD2JSHuPFdMuifefH9voORsuqHp3uFOGnDTTihNOZ82uNgm5p79ImusMgG4c2NSJUTIV9rqCLB/USJF8Pn2BxjX/ZXeJ1SMXpOIYF4o5vr4iKfSrn0wub8cK4nrgrbRwmcSY9Gu4Um/8vi7wdjJ1K5+gyxbNZABu4aaXNs/CQx3a5cXBytesCrF3m6MAUie88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR+tWW4LXaku/IKwKZ5/p4a0mW8K5t+pqeBlcc+aD5M=;
 b=Ih+Ci5/v414+z3bYZTAdHmx/7jFLHl+SDExPImCPXfZDIajxfISoq49XKFjvCTWjOaUDiPPtuxiurU4qdTSUXwMhpfwhK8+z4AgMqO/EZsw/Lbjuo/M20YXqiseBLNPl12uzRhxweCmjx3pHam0P2omutTvvCDmRg54tv+et3SA=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 11:39:39 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 11:39:39 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Li, Dennis" <Dennis.Li@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Topic: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Index: AdXy0f9EIn2WkBwySKekkStORNst4QAEKWOg
Date: Thu, 5 Mar 2020 11:39:38 +0000
Message-ID: <MN2PR12MB3054EB5CC86F64877D39F4D4B0E20@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:39:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ddcdfbbc-89af-4d2f-8549-0000f5c83eff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T11:39:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c54eea34-093d-493e-8692-00000ac17805
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [153.99.181.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b7699ff-53e4-410f-5504-08d7c0f9e36c
x-ms-traffictypediagnostic: MN2PR12MB2912:|MN2PR12MB2912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2912FB678170AEC57D07DA9AB0E20@MN2PR12MB2912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(7696005)(33656002)(6506007)(53546011)(8936002)(86362001)(8676002)(81166006)(81156014)(4744005)(66476007)(66446008)(64756008)(110136005)(76116006)(5660300002)(6636002)(52536014)(478600001)(66946007)(15650500001)(26005)(66556008)(71200400001)(316002)(186003)(2906002)(55016002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2912;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /OIJJrtoGgI1wEE/7nK7Se6XqGRDnsLJ1tRlQ6gZHIL2ruCc0aNOC9upZ1ILIeIKSiZ2FzL20ijtPx3ejk/lnXktFX2FpicEQDfgS3yDBwgAZObbrt5N52Qgv5R6/0YKp5xU9Z6LEiaay+DkrZbhJ4Fs9ZmG3Wqz90l5rlJ4rYCvnKmcGvcZSan9tAxzenaEDBbkgcC/F4FJYNqpLy0c5rC57SPUgAfwidCTv/mEwAML4OhBL7oNK7sdjt4n4FZ/77iWp2PBV428ac9VOh1QCINfTYgNTFAWVnLCasM/ZPkKUkGFZ7HSER/RJaP3DJutK7XIJCauO1ylvE31pmax9HV/L8DyIr7tI9ZPEK5zithqjMiKhchaT8G1OElgZjf0tyWTFhDKFIG5Wdouh7rOduL+TLp0QTRLRSlXafq3n1F3fqzgFfJGUi6uGMLKKsJb
x-ms-exchange-antispam-messagedata: M5BhXBZz0DmAwOfD9RxQ7Vwy6nVaXdAhU2wpxdnTBJtOqUGWispwFbHPa+VDwt65kYhOLf4nomHHezuxNm1fSt5oRMmfzzfW7kPLBqBaLyATDA/4aqVLUOwRevdC20SfO4a1AQJKZv0M6CpaGMzVbA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7699ff-53e4-410f-5504-08d7c0f9e36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 11:39:38.9682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMxQ8iHCsRgD8wRvL8WP7NnJ2nRx4I5jNpbPoj0vpfIIL/ymLeH5BlYI1T2AJUgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
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
Content-Type: multipart/mixed; boundary="===============1898868898=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1898868898==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3054EB5CC86F64877D39F4D4B0E20MN2PR12MB3054namp_"

--_000_MN2PR12MB3054EB5CC86F64877D39F4D4B0E20MN2PR12MB3054namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPG1haWx0bzp0YW8uemhvdTFA
YW1kLmNvbT4+DQoNCkZyb206IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+
DQpTZW50OiAyMDIwxOoz1MI1yNUgMTc6NDANClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpLCBEZW5uaXMg
PERlbm5pcy5MaUBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBDaGVu
LCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IHVwZGF0ZSBwYWdlIHJldGlyZW1lbnQgc2VxdWVuY2UNCg0KDQpbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCmNoZWNrIFVNQyBzdGF0dXMg
YW5kIGV4aXQgcHJpb3IgdG8gbWFraW5nIGFuZCBlcnJvbmV1cyByZWdpc3RlciBhY2Nlc3MNCg==

--_000_MN2PR12MB3054EB5CC86F64877D39F4D4B0E20MN2PR12MB3054namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:=CB=CE=
=CC=E5"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou=
1@amd.com">tao.zhou1@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> 2020<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=
=C4=EA</span>3<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=D4=
=C2</span>5<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=C8=D5</=
span> 17:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update page retirement sequence<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">check UMC status and exit prior to making and errone=
us register access<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3054EB5CC86F64877D39F4D4B0E20MN2PR12MB3054namp_--

--===============1898868898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1898868898==--
