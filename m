Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D1C00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 08:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0450E206DB
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yYhDj0kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0450E206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FE16E191;
	Fri,  3 Jan 2020 08:23:27 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F046E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 08:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0ku9+k6gjEvl3QuNOW9MPL6ZGI3AaEZIp98yu0AAirTS15D4BwtWb8MPA3JTvucs+JzMkPOkuAl+Kqy+HEgnaUBaqKPOOeUGxnWQsbIbid0rsHmnJPZlQKHJSjjX8qdqe8q7kQJACqkdDb9OvImH5JPZLXpOEm+LKzNi96yC44HlZaMpyV/BOL8pNtoQf7t3kCnHlPL6uUDCJGiDXfrCpKYGEjViFMEExslrAzVr1fzMHL9xtKaz8qf7voVaHUeETWDCsgWZ2j/L1uat5DEN17KxpfffvODQWTW4q24iQJpQj1/I0aiIxqC92SLtF2dlwu0VCGYg2EeeUeyec0g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSw/5YE2GyErYZoAVIqR+YKxIM8XslDK+LKVSlSjrdg=;
 b=B0ddcyXaRrrD/vV/qz9DPVB2E/8MqCt0l+HyWH1ZXEcLBXoC792Mh8Y8K8ryQs/MU51HVd+PZEPZgK1FnNSuDH+koB7jpDZp3OM/BvWqFwZZtOpM4kOrvw3KO/Z/M72pyyEJBtixIRddGmY6j770z/AdP4N0q6luVEkLJ8g+H0tYrLd15IPgy9r00UZzTlDNV5EYyUxx7Ao98x8etGOlIBBls7HjKGVVf+unA2PF94EzNFtIfwKhNpts2y0ao7V2rvjBJLstH4Mf7+R2kh3MbjG2UDE/vtWtOgCkpHxVhot3UjjikOyYaj5OXkzFojwjTR1tdod3c6F2oiVGs1uepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSw/5YE2GyErYZoAVIqR+YKxIM8XslDK+LKVSlSjrdg=;
 b=yYhDj0kvxhnhm6ct5l624clwea99DJiWnYnPJXlJivqhlDQubjimITMqMc+5oMNxkoaP+sJZy8K6y/pmNiipiMoVji1VufT9P00arytfFO8FDJj7PcnZkTyDTGUDjHIhsJYjPMR2RXb/H8uaEF9zbt1+JBc4r4l2GPp33GsPnR4=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1914.namprd12.prod.outlook.com (10.175.86.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Fri, 3 Jan 2020 08:23:23 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::4dfd:ef1a:1fde:9634]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::4dfd:ef1a:1fde:9634%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 08:23:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: removed GFX RAS support check in UMC ECC
 callback
Thread-Topic: [PATCH] drm/amdgpu: removed GFX RAS support check in UMC ECC
 callback
Thread-Index: AdXCB57L5MXRq23tS0GyMooPNbGDMQAB2Pyg
Date: Fri, 3 Jan 2020 08:23:23 +0000
Message-ID: <DM5PR12MB14181DD19B9A0F8B638BECE9FC230@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB36633DCCAAE396B3195CE594FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36633DCCAAE396B3195CE594FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T07:30:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d05c90f-0d64-4ffe-afd2-00001b50f17f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T08:23:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8a842063-3b2c-4d86-9b53-000023ff74f0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e0bfd77-f884-48f9-49a1-08d7902632f8
x-ms-traffictypediagnostic: DM5PR12MB1914:|DM5PR12MB1914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1914447E5E9C8BBDF8D9CA94FC230@DM5PR12MB1914.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(81156014)(66556008)(66476007)(316002)(186003)(110136005)(55016002)(9686003)(76116006)(53546011)(66946007)(4744005)(71200400001)(8676002)(66446008)(8936002)(64756008)(81166006)(26005)(6506007)(478600001)(2906002)(33656002)(7696005)(86362001)(5660300002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1914;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvltJmXrR/WDPGLVYsTKr8j2+i5Ka6TMYozyDxcd54ovb5tROvyNBRhr/g3y0Pd+CDwejZkLN7Tqo1dwHc4AaOAEAMG75vB2bNMDES7Tijb8bsDxVWKTGLjoTZdWJ8Wb6tYb3j61Z3Vh4KxN7/zUX8G5f4tEfI9nx1jV6haYd9q6cqo0EO7zvlerME1CRhAXzyoVANT9z3mnARH9il9rZvUqIilpjc+LD8D+9xchPgcxhTfDnOTxVNCi/WO2K3ha//g5TehekAWWKklwXJiFHOOCPZi/e1FeRgI0+/mM2wW+AfYyZnOjojeJ8JPZLUgx42v+LhZHKv+pmz3f71q05eDGj7XJ5Yhi4O7MQHJZV7C6jTSGpGAW/gy0DxkiUXf6XDucO1OfzkzxgDBVUyHRdBe63yQ9iSVCAnakN7wVzLfv7RS/D9zYp8b8xNc0hlnT
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0bfd77-f884-48f9-49a1-08d7902632f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 08:23:23.3454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUKsCQwEPL9Gkc6ashBhvPjccS224L3xEyo7e9/d5rshHio450CGqLgYOhpolWl5oJy+HNhLZIMwGu/6sQRz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
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
Content-Type: multipart/mixed; boundary="===============0070748556=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0070748556==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB14181DD19B9A0F8B638BECE9FC230DM5PR12MB1418namp_"

--_000_DM5PR12MB14181DD19B9A0F8B638BECE9FC230DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, January 3, 2020 15:31
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: removed GFX RAS support check in UMC ECC callb=
ack


[AMD Official Use Only - Internal Distribution Only]

Enable path for GPU recovery in event of UMC uncorrectable error.

Thank you,
John Clements

--_000_DM5PR12MB14181DD19B9A0F8B638BECE9FC230DM5PR12MB1418namp_
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
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Friday, January 3, 2020 15:31<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: removed GFX RAS support check in UMC EC=
C callback<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Enable path for GPU recovery in event of UMC uncorre=
ctable error.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB14181DD19B9A0F8B638BECE9FC230DM5PR12MB1418namp_--

--===============0070748556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0070748556==--
