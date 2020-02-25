Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717AEC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 10:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B177218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 10:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zCo7o698"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B177218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61D56E1F4;
	Tue, 25 Feb 2020 10:42:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD8788E2B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 10:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfLy27VILjgUa+7DmqhuavLgKRBwQDZIgvrqq9qPMJ0xfI57kXcr75phEz4p66aUANO+7diRcMNR6aQP+7W15NG99oKd9zTanCDVi6oB/lKj7B00uP4vOdvvEW96qEK8WQL3Zsilww2BUeLMNlYTrc9iluSA2DoCZq3N5TwbuCwe9jtjZTldxeSq4xjhcl5RyW8APGFa00QgfW6YodcIy07Se72GZsCuL/Ozv9pxRHABxLDbiC+g96qm34bOmL+NfnJ4wwcq9+BXsq21KNqPAJgNnAkBWHj6Z/wWtu6nbDtweFREQr3QCKyWJvGH6Gol+Qa04J3x9vBCg+fBaojEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9APDm/1JFboJxJ3OQiMsHDIBOR6k+GCF+TCTidj7Naw=;
 b=azmSZE5mtuDXrQS//RdSs4qekJmHrMpvWEpsfJ4n4v9pKICFgYFMhsr71i4C3kxP75BDszLjiSWgCq3RY+tOM27MkZ2a1kg9YH+joiDvRrKZzx6n9mmBnDBhvzzLkIn9zbmHxrhgh34Aw5hG+y0S6CebFcYNOuzg7LC5z1hlboBQPaIHlXfajlX0ZgGU0wI11Bma/ET+xbBLov7pCVJbobAJrddWgXzZ4Y4JUP356Cjh4qtjW/BJ88s9IPUfArvuiuOkeTiBLoevcM//8AKSXviyX17K1eVHfXZoJZueaAAgxGUMBBoQjF6DwnxBKh3MiuFJrYZ6LWDovqw4hdV4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9APDm/1JFboJxJ3OQiMsHDIBOR6k+GCF+TCTidj7Naw=;
 b=zCo7o698h/L01fDKL17gG0c46jNjyRM183d5bz+14yNnTdf6ctMhdvXCGMaeoAu5acizI8alQS1oGoj9DSPW0AfNXfhNtXhJFBE/5f4HuNbH1jiDYi951vclJIMRFL8PEspPnmRnhjLOZvZvMohIZ2K0gPH6IY6DX+wqVZ7C0w4=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1788.namprd12.prod.outlook.com (2603:10b6:3:109::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 10:42:17 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 10:42:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support
Thread-Topic: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support
Thread-Index: AdXrwfXc71Ex/YysSc+kD4OiPsAZuQABg8TA
Date: Tue, 25 Feb 2020 10:42:17 +0000
Message-ID: <DM5PR12MB141825D44F7FCC06C1AD77A4FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB36636BDD1DC83862F3F975D6FBED0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36636BDD1DC83862F3F975D6FBED0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-25T10:42:15Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=90f3e2fc-1216-44f5-b81e-0000263db9f0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-25T10:42:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fac13609-ac45-4566-acad-00006b62abb4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e88d49c5-1871-4839-c44e-08d7b9df6259
x-ms-traffictypediagnostic: DM5PR12MB1788:|DM5PR12MB1788:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17888B77F6DE0F9F36071C07FCED0@DM5PR12MB1788.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(478600001)(81156014)(81166006)(33656002)(8676002)(8936002)(26005)(186003)(7696005)(71200400001)(53546011)(6506007)(76116006)(52536014)(4744005)(2906002)(64756008)(66556008)(66446008)(66946007)(55016002)(9686003)(5660300002)(66476007)(86362001)(316002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1788;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbIsKKN0Eo6KCedoRI4eQ6zU2bN4w4EotDSv/TTENfaU6bVq/oyklxkX4xBVluaoTFZ5C5OP1yODQsT8KI7M47oLFSd5X9bjrJ3TJirsBOhBWHzxcaBgRsxh3jF6H+Y4dVpLAkJdTxLggIQ+GC4iCf9DxQOKwJvSe0qoihphPov+F9WvzPPSv7zR3PNkK52NGobmAeVx0fn8hx9dgfG4f/mYZ7mX1Aa7OQE80D4Mp3/WVD3VthgERfLl7DRosE4fCRkhVATSkMNhB6yeuPkQ8okmoW0cyKgIx6r3tHaNpa/yheAlPxJX1OUqmyGtw7wh8noTEWyvIVbrVh4ZmZQSnkcg5k1LHGW7g1JkItNLDMGbgl/epn+JuwV5G2sDjmsWSoQLx3wOPgRqClhL3mLef8/o3gv1JTbO5wdQ3JEtSnt5bw+QJc/DlnVWnfCkr8+w
x-ms-exchange-antispam-messagedata: XRkab55AzkHv5i7j15ORGqe2kF/xG4AkVubBZAEofC5XUqsLnivapefBZ6LdyuHF7KI37fQJ2Vcz2sDlA8PUYIVj2m0JKWPpPM5HK4iqC/4ZWIWJaWSfzcgdvfFLuUawInXWi22bh1drTk8h4m4iXw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88d49c5-1871-4839-c44e-08d7b9df6259
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 10:42:17.3321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YdA2wcY34/wm3oGy6yUTw3GDgSrXBLWUSgqUZ2sqHhgfPVk0BO1Oi74clqlHSixfebMLCAGp8HenoO3i6jgRYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
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
Content-Type: multipart/mixed; boundary="===============0734020371=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0734020371==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB141825D44F7FCC06C1AD77A4FCED0DM5PR12MB1418namp_"

--_000_DM5PR12MB141825D44F7FCC06C1AD77A4FCED0DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please fix your coding style in the follow if/else code segment by removing=
 the unnecessary {}. Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

+             if (strnstr(atom_ctx->vbios_version,
+                         "D342",
+                                 sizeof(atom_ctx->vbios_version)))
+             {
+                             *i2c_addr =3D EEPROM_I2C_TARGET_ADDR_ARCTURUS=
_D342;
+             }
+             else
+             {
+                             *i2c_addr =3D EEPROM_I2C_TARGET_ADDR_ARCTURUS=
;
+             }

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, February 25, 2020 17:58
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support

Add support for detecting Arcturus SKU to resolve the correct bad page reti=
rement EEPROM I2C address.

Thank you,
John Clements

--_000_DM5PR12MB141825D44F7FCC06C1AD77A4FCED0DM5PR12MB1418namp_
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
<p class=3D"MsoNormal">Please fix your coding style in the follow if/else c=
ode segment by removing the unnecessary {}. Other than that, the patch is<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (strnstr(atom_ctx-&gt;vbios_version,<o:p></o:p=
></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &quot;D342&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; sizeof(at=
om_ctx-&gt;vbios_version)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *i2c_addr =3D EEPROM_I2C_TAR=
GET_ADDR_ARCTURUS_D342;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *i2c_addr =3D EEPROM_I2C_TAR=
GET_ADDR_ARCTURUS;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, February 25, 2020 17:58<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add Arcturus D342 page retire support<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add support for detecting Arcturus SKU to resolve th=
e correct bad page retirement EEPROM I2C address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB141825D44F7FCC06C1AD77A4FCED0DM5PR12MB1418namp_--

--===============0734020371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0734020371==--
