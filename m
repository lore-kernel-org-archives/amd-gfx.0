Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491BC32767
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 03:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6552520848
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 03:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e1pd8KQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6552520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FB489B4D;
	Thu,  2 Jan 2020 03:28:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9368489B4D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3BxgY9lTzyyYmzXVniSzhaF2zau3RfGUR5qlZm1ri+/Av7VtNLNbzEoVY2CTWfJj04ThHb2eoIH42FwfbTd4ghXkwYCRthDTR5XMles1a2CVsr40El13HX5h3UeCrj0qXo/8eLa63pEzbPUHUDc2nVw6vHTledAupaPMRhiYT7OTyW7ZpecgwtRWtqtivyFSbyivF4Ai5eKv7mu09XG8Q1KgcHAbLEzJdek0emm/oOPrDho8jt0rW7pw+2GG3b6kehN0MrO8vlUW5TxBsxTSP2NB/uD4BIzIH/DejfFq+NxzxvzoO1GBt7s91qXCNYCrpokSViD59xxLbwoQ+3l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fCzGlOk5BTaeFKwovNjBAxmPzusS4Z3/DmmRKJmRRY=;
 b=mkW3wvbU5AZgddzlUSmmtQMKYlBzBZI+K0PV4JafiuaQN3Rg4gk7oX7vbbt2GiMRIv5/SkiiT8z78LJjYmynJMLEoucinwETrTjRwC5XK78QLk0ea7jZLQZbl9SUW+Yh/niHX8a1MnVKNowz7dojLksuwZ9uVc8JXdF9QuJzanTQxWXTNCd8Efmb2j4AFrCCXXpLgHq4EZ6aEJyMYQx+JERF5dZYpQRIL9wXRNdLzifvKNrQYMXYC/Ya+jpUI8eXcj+iSe4KwD9cE205L/kn0MKyjcdxIl1XTCkHUCOr3YLtRBkH+RGnfPoDYLpFA1q2pyr1LlZTRAKindUUW30K9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fCzGlOk5BTaeFKwovNjBAxmPzusS4Z3/DmmRKJmRRY=;
 b=e1pd8KQbLP7+m12Qf9ZXfC89zzBRFpzftSahYaEbpJhglHVCKJL00v10UDSpkhXvI7R58K6D7zEMNpcz/d9UJHdZuwdgIbBUCJ0oTL4U4HRzDpRzXaVG7QGQSV8kbMatNkIGqV4RKtMJQec6DbIFsaBJSGSuz2rH0uIYvqlHwBY=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 03:28:03 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::69d9:af7c:d092:7acf]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::69d9:af7c:d092:7acf%7]) with mapi id 15.20.2581.007; Thu, 2 Jan 2020
 03:28:03 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update UMC 6.1 RAS error counter register
 access path
Thread-Topic: [PATCH] drm/amdgpu: update UMC 6.1 RAS error counter register
 access path
Thread-Index: AdW/gem7rSUM8jyCQXKCbRy8Im44xQBmkVUQ
Date: Thu, 2 Jan 2020 03:28:03 +0000
Message-ID: <MN2PR12MB305426FF65A15F94AAD3AE32B0200@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <MN2PR12MB3663C8CD54259C55C8DA4EC2FB260@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663C8CD54259C55C8DA4EC2FB260@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-31T02:29:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=84b90405-2e92-4ab6-87b9-00001b54c423;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-02T03:27:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f1612e97-ef75-4f15-94a2-00002c1561ae
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df02c91f-909b-4fdb-adcf-08d78f33c695
x-ms-traffictypediagnostic: MN2PR12MB3087:|MN2PR12MB3087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3087E016BF9D6C0296E2B2E8B0200@MN2PR12MB3087.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(189003)(199004)(66476007)(66946007)(66556008)(64756008)(71200400001)(478600001)(66446008)(6506007)(7696005)(6636002)(15650500001)(86362001)(76116006)(33656002)(53546011)(4744005)(26005)(8936002)(81166006)(81156014)(55016002)(52536014)(2906002)(316002)(9686003)(186003)(8676002)(110136005)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3087;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VnViCItBrLcqqDP6IV6gXw92rPxevV8zNkZvysX4WH4C3hb1vggNj2nfzqTXaPamqmvoytbOL4gDpwp4cVXsjgtfrU0oyCMymSnxB8t7XE3ItVBlJOgaL0JNGMu+uQho1a1OmXDgX9Mf7WekPxMxlr+PuGd1V9ydGROMSmWXtEKpzZIomyDmw//wdXvQd1Hx5USeUZrgwuR0cQGLpwlUh3dplYO9o+8FYQVBfC3+eIbsp2Nblfy/nirFs3UMDi0TVEEA7bFbAgIKyzZh7hMo/KChaiyc4qlaFA/qIXaP/BYPADIaJQBGb59uwBXzm24QkiOnLNuSQnnMtDbsOciHoo9xopQV2fRO/BsrHPoLqXiR4FPudFyPtmh8GFjXVDNYmt6WqJVZZPpl8k2q9QK3KhlG/6dZ71f09stJgrzP4GamZnbp8RqawJ4fkXyl4If
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df02c91f-909b-4fdb-adcf-08d78f33c695
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 03:28:03.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcAexm9aihBGobBC0ad+jyxH9JeNy/BaPefVA4H/XNpKp/fJMiX19XhWh7x0oJF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3087
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
Content-Type: multipart/mixed; boundary="===============1726239227=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1726239227==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB305426FF65A15F94AAD3AE32B0200MN2PR12MB3054namp_"

--_000_MN2PR12MB305426FF65A15F94AAD3AE32B0200MN2PR12MB3054namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KDQpGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQ2xl
bWVudHMsIEpvaG4NClNlbnQ6IDIwMTnE6jEy1MIzMcjVIDEwOjMwDQpUbzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IHVwZGF0ZSBVTUMgNi4xIFJBUyBlcnJvciBj
b3VudGVyIHJlZ2lzdGVyIGFjY2VzcyBwYXRoDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAt
IEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoNClN1Ym1pdHRpbmcgcGF0Y2ggdG8gYWNj
ZXNzIFVNQyBTdGF0dXMgcmVnaXN0ZXIgb24gQXJjdHVydXMvVmVnYTIwIHZpYSBTTU4NCg0KDQoN
ClRoYW5rIHlvdSwNCg0KSm9obiBDbGVtZW50cw0K

--_000_MN2PR12MB305426FF65A15F94AAD3AE32B0200MN2PR12MB3054namp_
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
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
<p class=3D"MsoNormal">Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=
=C4=EA</span>12<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=D4=
=C2</span>31<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=C8=D5<=
/span> 10:30<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update UMC 6.1 RAS error counter regist=
er access path<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"xmsonormal">Submitting patch to access UMC Status register on A=
rcturus/Vega20 via SMN<o:p></o:p></p>
<p class=3D"xmsonormal"><o:p>&nbsp;</o:p></p>
<p class=3D"xmsonormal">Thank you,<o:p></o:p></p>
<p class=3D"xmsonormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB305426FF65A15F94AAD3AE32B0200MN2PR12MB3054namp_--

--===============1726239227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1726239227==--
