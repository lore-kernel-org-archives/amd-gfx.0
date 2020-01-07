Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8854AC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 06:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5947E2072A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 06:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oRduduFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5947E2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063A36E50B;
	Tue,  7 Jan 2020 06:26:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33126E50B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 06:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdgQG+pjRMkzQj4NG7XQd0RcGDvLV5nTUHAgnlSuKu1SBLLhfbgaCSnds5hOj2CU4WQ7RLKuzgKQfny2g+vzJ4BKoWQqitvbBIOg3tmir74zFSJbjTrsAYJuu/YoAJQtul2hLcazuKsgMgMZjFUB8RM37KpLpqliTZci8Na4xVxAlEB/5Dko7fFN0JIU3q/vUauMgrST/ZHYBk3p6XET1Os7gTmFNhioVJ4t91N8qAeKMsW1LxjvjQm3yfu4+zX0qGwxpNl+IS1QaFlDnYjm6hblHVr4PL0Akdy3FkXh/u1kyTBbSXg4uGhB2h8H1BroEf5HFuaZZEZZb9wn/Hr1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+/ZMlxKRKPAyMveblAqkReRhFkv1//z8zQDdroiGUI=;
 b=ICar7ZM54DZuvT0OBJ9EisjA9X6iPcW73u8QdCbrtz0i7c35P7lKZovn98DjOEzyJciSrkpxDDqvlE1eSS6PH1ryN25iHwupz1V1bKBvOULmXbKSjjcbbpv2p9KpYJAC3hnqQVuCgsPmpePzCYxTcr2wOTha/jxfMBCGs9mme2+m85Wl3A+J9mpwa9BDGdMW/LAngjlkfPZarc8U09Vsb474pPy7YMiDHa5elBXGBS6Ie3ewQ9UTy+CQRau5EpXr7obrFObRm17djBo2W5mHnVezCoSurH6wEzfzeqXx8TnDmSj6tb4CcwEMVGU2llcF5IsQ7hHc18UZy6HTxqVu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+/ZMlxKRKPAyMveblAqkReRhFkv1//z8zQDdroiGUI=;
 b=oRduduFjg3iEpuNZnc0R4jwu5tfq8xiZwAdqgN8q1gM0kBMBQYVSlEI/o8Eb2MqffgpU3+aaA7YexjCHrPR+x804Ej38p1i8L50lBuDFC87JUEmVk/csalXopXmoDQ/OvVaFvLspaVt5M7X1PHseYjWN7GP16REZsBEwrJKb73g=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Tue, 7 Jan 2020 06:25:56 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 06:25:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Index: AdXFDfX6UjCjdKdbSWODjaMeQHS5aAAFTzaQ
Date: Tue, 7 Jan 2020 06:25:55 +0000
Message-ID: <BYAPR12MB280684507449660B1EFC77A1F13F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB36636EC5042C85407DB96379FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36636EC5042C85407DB96379FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-07T06:25:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4b19b320-b82c-421a-ba7e-00008574b280;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-07T06:25:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f316c518-f144-4d99-a6bb-0000e0e72b6f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d5e90e7-e796-4c92-577c-08d7933a7419
x-ms-traffictypediagnostic: BYAPR12MB3398:|BYAPR12MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3398076AB1B0723CC35F11ACF13F0@BYAPR12MB3398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(55016002)(9686003)(86362001)(8936002)(5660300002)(52536014)(2906002)(6636002)(81156014)(81166006)(8676002)(4744005)(66946007)(186003)(7696005)(110136005)(66476007)(66556008)(66446008)(64756008)(53546011)(6506007)(76116006)(498600001)(71200400001)(33656002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3398;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UT0de1XFLy9UxjEfo+NgLRuTTalBKyM4ob9G2u5utGpCfSjlZR1NmVYZ9F1PxPo2BpTULvlfR6KqOlaNrFn7A5Vl0qlXNVfjE1O0odHJTdKsy6igjhipGrONbx0IN5gDnwEdsTNT5qvJSLKIZoJ9hnXbd6nz4IyRYcyzxaDnVWcAQ/vy++vE2IdD7sUIzBMlZU3e1cbrRaFR1VUAkpXyVFTptUeM4ug2D208E1UOtEok4icINEkUW1yy/WNKErbwXeKk7724MCmK9FkGx7jIiaGb+a7GVQW06METt6lKe3cuuKb0qjGAn9TNZFUixNXZ3YuKo9pyb2gmuD0xcUORGGp2X/UY1K9qLV9mnQhAYKkAGZRj9jLeOfj3AHjlWxDjyvZvFRc8kOBXj4t22K3Lvgj0T8THpe3vFHI8D317ZFlYoZX4zvdkqjXb6Gl+2G27
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5e90e7-e796-4c92-577c-08d7933a7419
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 06:25:55.9799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWFcrFV8blgmHQmIMksHl/7eYOnaWlbPxK3RDbrTrPLxeAxDPSt3V2n+xL7Hms0ElnxDVcpdVotA0gIJ2LEKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
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
Content-Type: multipart/mixed; boundary="===============1595893347=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1595893347==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB280684507449660B1EFC77A1F13F0BYAPR12MB2806namp_"

--_000_BYAPR12MB280684507449660B1EFC77A1F13F0BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-and-tested-by: Guchun Chen <guchun.chen@amd.com>


From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, January 7, 2020 11:54 AM
To: amd-gfx@lists.freedesktop.org; dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com=
>
Subject: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to access CE registers via SMN and disable UMC indexing mo=
de.

Thank you,
John Clements

--_000_BYAPR12MB280684507449660B1EFC77A1F13F0BYAPR12MB2806namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
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
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-and-tested-by: Guchun Chen &lt;guchun.chen@=
amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, January 7, 2020 11:54 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; dl.srdc_lnx_ras &lt;dl.srdc_lnx_r=
as@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to access CE registers via SMN and =
disable UMC indexing mode.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BYAPR12MB280684507449660B1EFC77A1F13F0BYAPR12MB2806namp_--

--===============1595893347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1595893347==--
