Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD6C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 08:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6013C20873
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XwqlPuK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6013C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023046E853;
	Tue, 10 Mar 2020 08:56:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8966E853
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 08:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw3oKbuGYLrX8o9AEn0dhqZ6DERRyLoT7HbvT5xvdVtHucrnSKojcyhwJV/U8vRCQNqNJoZbo5UHwlQ9seiBNsbE98yufRdb3SitK+ntCLEgiOZkYUdyt5fhdsWsB+zrWudqsO6c0sh2cz+dVarhNy/zZadEqqPOUjbeZW9HDEYmE2u3DHuFeG1pZ6Ml+QaDO0veqxQxH/odHW/7oAGPow6V6eYnO737xiCCCsvrcPHVTUF+iMrHzwBEhNlFjV6Ayv29ESjL4S7vzFZG7VDxHkSHkAxZtLXKhcFZSvMGYvctYkuLlKIoUIkN1WjV8nAFV/jjv8PeUvXZ1TdIXO5LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcMUlao29rJ4q2gvwOzSNPL07LJ4lGA7o5nNDfwJ7Js=;
 b=cjft3W4trWsxPfDDwbg7vyzZWxYuxIExkiAcw1h2fFR4LzoUWJgnz1VVKBBrEC1A9dBQSaHlGeca6YsnnzLvEJURSZ54szYHxEPpFRL6mIUiebqewWUwBETnifLF09Vl8c0mVvhdcUCfUUgd+UkC1yqBmEzZ5ziDFeajyqm3ipWVYQrVVfb9MDLSdTULPQUyZZS4V8RCKdc/TJWFBsubyOWJlZ17pLwVbZcWijEupwwHNLWtXlRYlurxS5Sig8bF/bJvzfERXlHlrNlXaGjGCnIsqZW6GSKXJka7v3d2APVtTSNKr7kGhCjLaep53nrdKKkqmQt3irWbPAGeDrYlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcMUlao29rJ4q2gvwOzSNPL07LJ4lGA7o5nNDfwJ7Js=;
 b=XwqlPuK18SmXbKPFDgM19SEN3TCfPtggs5GzkZpe0/C/6zqT0Kpvsp3qI7nwHl+pw7v3dMhbEx+jQmCVC37ZiW+xb9n9UlGwsbyI/vl+oqNqsz8pqKxzHp35GWDASuLkfxRpzkzYy8BtuqqAs+XKMc8TsoUayyqslRBTocuxJ1A=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3033.namprd12.prod.outlook.com (2603:10b6:5:11e::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 10 Mar 2020 08:56:24 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 08:56:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolve failed error inject msg
Thread-Topic: [PATCH] drm/amdgpu: resolve failed error inject msg
Thread-Index: AdX2t3DemT+t8diMQKysDPFlyWTrvAAAkwBg
Date: Tue, 10 Mar 2020 08:56:24 +0000
Message-ID: <DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB3663BFD340186E29FCDEC728FBFF0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663BFD340186E29FCDEC728FBFF0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T08:41:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=45fcbebf-95c0-46b9-b672-00001401a6ee;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-10T08:56:22Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 86b9347b-3b00-4fc9-8354-00004b25cfd4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e1a5341-a782-431d-5340-08d7c4d0e997
x-ms-traffictypediagnostic: DM6PR12MB3033:|DM6PR12MB3033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3033905242245A693FA5F487FCFF0@DM6PR12MB3033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(189003)(199004)(2906002)(9686003)(52536014)(55016002)(478600001)(26005)(186003)(76116006)(53546011)(110136005)(86362001)(6506007)(4744005)(81156014)(7696005)(33656002)(66946007)(5660300002)(316002)(81166006)(8936002)(8676002)(71200400001)(66446008)(64756008)(66476007)(66556008)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3033;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VnuyXlb9jxtsnloc8BaEVo8Fh9lPZe6Mcwzz8HKTT7vhnjgBjt3LcHmctddaf5z6cdV0TOKxGoqB9k0fMykn68Ms5LZeoylcCaQPqq0I+1DjIgA19Bk7pM16lizTBRbWY+TEQ/oja6TfSCR+sBZ6ES7EcWtP7vKMUvzQ74PQR3F3Y+IhCc8LshiZUO3M2nGsWbcH5cONiCit8dQ2cemMKlQTYR0tP/UcUzwl/SQsAuy+WmIFBrIVZ/FQGAmjcfmbTkTtwWZMwQFV78hYup85Ao4fq9HqlhF1OuyZ7QZRucci3GlZn80dJDWhHcd63qmcLhUpIFFqP6r8tJkvl5n3uI/2IZLYMEzd10tgU55b3d6OcuVqjyAiyDS21/FYn1JkrpgGrXBBE9uKYhBCA8JCp2hSUVYG579te/7O9LRkcQzab++RmgR77quu6l7EBG3
x-ms-exchange-antispam-messagedata: H9wzHzc+Ti0Xb0Juh2AIWF62uRllxzKBgGn+nnDTzBfa12hxFrFO3rNMtDBIpwJxuZwMAlcR0gHVLbYuhZH3YJXst36+mNcNf8RWX/JdwkxoK4o0iwytipgDQ7LkQTHPLLkph7Uk1Z0x01dgOgliDw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a5341-a782-431d-5340-08d7c4d0e997
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 08:56:24.5622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnmZv8yS+zMNt3o5cCKlUBLVTHEMPiWP7cwZeXB/zUp05lRaLmxS3NliL669uqM1x5vEKu4KWnT0kv15OIH6LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3033
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
Content-Type: multipart/mixed; boundary="===============1987148570=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1987148570==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0DM6PR12MB4075namp_"

--_000_DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, March 10, 2020 16:42
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Li, Can=
dice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: resolve failed error inject msg


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve issue where during a successful error inject in=
voke the associated at_event interrupt causes a false negative and outputs =
an error in the kernel message.

Thank you,
John Clements

--_000_DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0DM6PR12MB4075namp_
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
<b>Sent:</b> Tuesday, March 10, 2020 16:42<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Li, Dennis &lt;Denni=
s.Li@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve failed error inject msg<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve issue where during a suc=
cessful error inject invoke the associated at_event interrupt causes a fals=
e negative and outputs an error in the kernel message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075BBF8C68B97067BDB2AB3FCFF0DM6PR12MB4075namp_--

--===============1987148570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1987148570==--
