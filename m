Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6ECC2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 12:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0028820863
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 12:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t/wp9Rbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0028820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D608997A;
	Thu,  2 Jan 2020 12:38:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9988997A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 12:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCg8DljssdYfL4Tj1nydT8d8h9QFEXpsFWcK3PUwI/BYNRUKqqh7gaowT1lrk/6sVXaszWivL5cbiuM8PfOwC/5AkH5mMmujgsGS78c5Jx+/P36rwVH8J3IU+lOlC3XBmnJfhpWEHpSY1nJiwExR/NcuW7i5rPqopdDqIP2l2aS6JZxZnseEmRhOE1rByi+TgsXFkPN7sPZy1eJ0JR5hA3vSHBnMKEL8W/FOQwIKZ/5vVWgmcjF878ozMtbsRakYDRVyXjhe4YEQzj4X9ck88ceZ5UidZBv5T7nwbEelXs+RPMZijpZMDJg69DB+88lhD2tUMYL98rlcJIkFTzrUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL27w591LYwu2Vn8oH9p0y+5vMs2DL+TvmQcFe9kTjM=;
 b=aYtit6E7x8RCM4nv8hCG02X8A6RMkvPYVOXs1EklEW9wYQNbs1I7dcuZjwILfV6JzbBmH1P9lgo3iCH35joecPXsg3MAaaqCp8QpTlac/ErOzJJWEOGEhW58TPQ5HRHykDDr3qx/rOlGUpc3sC8yuAoQ2BZczuN/QJwIyx7rBtrMF0PR1EuHvlcOlahTzrcdjkLSP6eFKfsaGD11X0YbULfsyLD1nSjJKs95uH3w9UInqaV7p7qv0o84P2dPiU7VpqarwxMQh/BOPaIW1e70jRzfGNdjKd4opvq1A3pwuPctV1gDUW8/JMqhQKB9ypDWFg9CFHhIqmq+XzCorjBwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL27w591LYwu2Vn8oH9p0y+5vMs2DL+TvmQcFe9kTjM=;
 b=t/wp9RbfBVaF0VevlUThDxskju/XIHPXQGa37XGeH2zSIFnr1OEE2UnEYOMfmXPHTdPydI3IyUjQXKMQrHiJ+T+jVVlm5vRznTmaSGGYDdff/92BPkvKudbL5bfOE0iJZRuc0ShAJHL2Mh4q4V0Shux5AdS8QlBcvx2ZF8lP5D0=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1867.namprd12.prod.outlook.com (10.175.88.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 2 Jan 2020 12:38:13 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::4dfd:ef1a:1fde:9634]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::4dfd:ef1a:1fde:9634%3]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 12:38:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Index: AdXBV3Yg76uTyzhkQhyxmQ2h5s6tpQAEeliQ
Date: Thu, 2 Jan 2020 12:38:13 +0000
Message-ID: <DM5PR12MB141870C643D7A615B4BE392AFC200@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T10:31:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=13d65165-6b96-40ed-aba4-0000484588ee;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-02T12:38:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 55e1cd40-500c-4012-9cd9-000054ce570b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 876deea4-7c22-4f9d-3ff5-08d78f80a22a
x-ms-traffictypediagnostic: DM5PR12MB1867:|DM5PR12MB1867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1867FAEE5A028470CFC14B5DFC200@DM5PR12MB1867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(66446008)(66556008)(316002)(81166006)(81156014)(8936002)(110136005)(64756008)(2906002)(71200400001)(8676002)(66476007)(66946007)(478600001)(33656002)(76116006)(7696005)(52536014)(186003)(55016002)(86362001)(53546011)(6636002)(26005)(6506007)(5660300002)(9686003)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1867;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJYlI0GjTW/NuwdtvvwVZDAf+0fqyoIC4HAf41NAmD1P8DIPbRNArNvK6pXDRlt0GSDCrSFDOtyoi9JjOOeu0FeDq97608ew86mUfXT6mfCgpEZX7AIAL2A9CLafI43wAhd5q1Jv8OGy7t7DLbYg96LN3xK8Pf4b/QhwYqSpgP/7QBMW35ENLajn5zky3dWZILUf8Bdn2HsU7sZi51YUj1x62tYAz9qtF/yocTMxG5iIegn0t/E0447nXU51gv/S8GEzH2X2PxRD+KKQfjJ3XngaDMBQ/DwLAEua4HEg4qAYtT17RtjcKj6FY88rWLaN08sSil4e1UZxobiUS+5UwWQUmwJAbsxmFzeD+UlSlku/hh9ctPz0CBWDIvd6nzPQRboCSTeukX6GTi1aL1G/zRfHrN2M96RlzPJL4Ye/PC49w/dHLGBTyuFHWIA4pgE+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876deea4-7c22-4f9d-3ff5-08d78f80a22a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 12:38:13.4248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GYxpJxkJa4/1S5wR1bn/Od3n4kPG/IEEeGoAJpbxN3DvJ9VSFAmyjRinbaWQqEtlzWYxMu9wkSm2lvfjzo3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Content-Type: multipart/mixed; boundary="===============2125567565=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2125567565==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB141870C643D7A615B4BE392AFC200DM5PR12MB1418namp_"

--_000_DM5PR12MB141870C643D7A615B4BE392AFC200DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

UMC_REG_OFFSET(adev, ch_inst, umc_inst) and the function get_umc_reg_offset=
 actually do the same thing? I guess you just want to keep either of them, =
right?

Regards,
Hawking

From: Clements, John <John.Clements@amd.com>
Sent: Thursday, January 2, 2020 18:31
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query


[AMD Official Use Only - Internal Distribution Only]

Added patch to resolve following issue where error counter detection was no=
t iterating over all UMC instances/channels.
Removed support for accessing UMC error counters via MMIO.

Thank you,
John Clements

--_000_DM5PR12MB141870C643D7A615B4BE392AFC200DM5PR12MB1418namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">UMC_REG_OFFSET(adev, ch_inst, umc_inst) and the func=
tion get_umc_reg_offset actually do the same thing? I guess you just want t=
o keep either of them, right?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, January 2, 2020 18:31<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter que=
ry<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added patch to resolve following issue where error c=
ounter detection was not iterating over all UMC instances/channels.<o:p></o=
:p></p>
<p class=3D"MsoNormal">Removed support for accessing UMC error counters via=
 MMIO.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB141870C643D7A615B4BE392AFC200DM5PR12MB1418namp_--

--===============2125567565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2125567565==--
