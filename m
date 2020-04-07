Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B292DC2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DC820748
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jdth2fBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DC820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4036889F3B;
	Tue,  7 Apr 2020 08:53:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA15289F3B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIyxPFz7tFA5hNpCt+B+sWVT3cHFgplNwBIx/4C0pSoK6NylYX5n391izBoC+bKqBvHXJFYLX1eH6z0Hf/KqHLQJZd6G02k7lmQZ6JB/E9g8EN8abfA8jdTqFJO/IMB+nnE2J/DKdcA/ixJSs3ZIWgIXWirxN5NLwDxbELdE2ZA7Vms1UONnpvg4gcVuwd3YuVy54UwhQ83ng2Ij+wbsC3Hiyp6FvWmicTtjWRA+itotJm5hizOeWeJ7/d/hMfd4dF1MJ7jVcMaL2xE21O0l61AgWpsk6wCsgRh8txJpV0VJ3K4193+IdqyYLJEK1Iu48LFXFwj1o8updmoanQo25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhgJNWirA9cxK5CCIhxt7yJ5mPWuMKbEzXbdIIjgmcU=;
 b=hTTDjz/t1Z46MeUKewpTp3t4TuIhOpBOE5YTze3WgwwsQeC2RTSJesbPzatNFIuPSBW3YcVZZ731ivGYn9ePhCWiv7tVjOLbzWENQ29UejnmV7Ux+d9JPW8w5NnFfjHzGsUYrL60WiB57f48xb7wjzDNdaIz7W37UKsz1shzq6FFAnsemQ+0lo20ykYvGkeErJhRUrJgPKcseY8/+2Pn7Ye8GtAzv9aIsfq+1Q9kgi+ZHHehquX2rHUje7ZHZJiDkmeV3EC40hwPHrBW3wKSs2bxYYEJYI4QL4l+Yk8Pjho5Z7WlFz1kKq5WT81H7Y+Vjdif/rxi5KfNkNbEOJ8l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhgJNWirA9cxK5CCIhxt7yJ5mPWuMKbEzXbdIIjgmcU=;
 b=Jdth2fBILWBO/3KoVY7BI5xNzG+391AVNMULNaKaF9UdDf7i62wn3bQ6p7ulckgCzKspWDvcNikkcl6lnAl/oS22+sR8gS9y4taGgrWxqRhBl9aQnfLcl2Xa+uNQIXPVLpjhJFElavNnulrgDeKFYAOOL6djObbO+rXM4Kk2MYU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 08:53:56 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 08:53:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update RAS related dmesg print
Thread-Topic: [PATCH] drm/amdgpu: update RAS related dmesg print
Thread-Index: AdYMuafLUHtddyJrR5mE/6mAO3dliAAAGC7Q
Date: Tue, 7 Apr 2020 08:53:56 +0000
Message-ID: <DM6PR12MB4075D874E3D69D2A385C3371FCC30@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB403219C47CEC909255949B54FBC30@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403219C47CEC909255949B54FBC30@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T08:51:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=72aa146f-2cf1-460b-a043-0000e76b65a9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-07T08:53:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: cc556bf6-73e1-4145-ba31-0000ad01741d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc5a4556-d34a-4adb-9024-08d7dad134f4
x-ms-traffictypediagnostic: DM6PR12MB3098:|DM6PR12MB3098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3098431A889F88B0BD0874D5FCC30@DM6PR12MB3098.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(81156014)(81166006)(7696005)(8676002)(86362001)(8936002)(110136005)(6506007)(316002)(9686003)(5660300002)(66946007)(186003)(66446008)(26005)(64756008)(2906002)(76116006)(4744005)(55016002)(53546011)(66476007)(66556008)(33656002)(52536014)(71200400001)(15650500001)(478600001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mNE/x+Gvsry1SmOElzcXlB+uPjNvq7Tdbi7V7cVWG2XPjhlJFolTq5ymOIlsicfip0m1AaZDBjM/7ohikkvBuSdzAesj2qHlSkcW/1uOFlFYblu64Lu20RBc3wDNVtaeHkxak+Noq23+Bx1NdfcVxYXGmH76/+5aScKnPdhc94uQ+7YJ0NXKrBsl8UUGAPVNzSKHZOpMnIyvdhq3RTr7yALVqgVpurQQmA1YjSA2SLbl+car9GAzCXrDx5T0mxsTBqNMHHFtMqg85yC97oJZvsDxY71KCXXK10pGVqvXVJjJJRrqBYl94QOQsvy/xRvYYwWEL1xhq4ZucQrTPifSj1tJPaz/DawL/gFgQlkbDStfF9YSIV1x9IBu+lO2czb/5h6pBm2ag/sUm1bVvtx6YjsQqrJYdgHA4kPZo0KucTOgfi9C1EdOFDaiHeN59Dx
x-ms-exchange-antispam-messagedata: GI75KVnZWZJDDFbx2rzOVzEAGnTHAjzoX60zEnvPC4c9gavHlFULHcEYEQMQnhJTBoN4SW+XKcAEY5dod5G+0i1CKtb2eHFXasjYF+uRObGMRbgeJhUsh93ABJjHc521B24iY6sgow+SZmQsScGzxg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a4556-d34a-4adb-9024-08d7dad134f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 08:53:56.6980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kl9HOwtnPUP5kfBAN7pViQ9pqo0pfnTLAO8aNgkTKX5J0WRO7DbU6XL7Xme0XBc/aDmTNVja8jwuyNtUdFzCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
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
Content-Type: multipart/mixed; boundary="===============0090455433=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0090455433==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075D874E3D69D2A385C3371FCC30DM6PR12MB4075namp_"

--_000_DM6PR12MB4075D874E3D69D2A385C3371FCC30DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, April 7, 2020 16:52
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update RAS related dmesg print


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to prefix RAS error related dmesg print with pci device in=
fo

--_000_DM6PR12MB4075D874E3D69D2A385C3371FCC30DM6PR12MB4075namp_
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
<b>Sent:</b> Tuesday, April 7, 2020 16:52<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update RAS related dmesg print<o:p></o:=
p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to prefix RAS error related dmesg p=
rint with pci device info<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075D874E3D69D2A385C3371FCC30DM6PR12MB4075namp_--

--===============0090455433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0090455433==--
