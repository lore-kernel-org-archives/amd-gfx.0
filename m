Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AEEC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 10:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6F121D7B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 10:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1rn/qiSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6F121D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9B26EE0F;
	Wed,  9 Sep 2020 10:34:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD5D6EE0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 10:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y22+Xe1J3IxHYZrHrbBVSFtYGmqOYH7cCkFP2FMQhxGU0k2BDWJqeB2FPt+OdAu5Qm7BKbYymKH3CTcvKkg7c5bEB+Vxyg71tchf/uBExn7LExV3er0EoIaZme9F7F/0YXMuVH0N2Eopgj+kzQRDEqawgOZjCoosEpRmCu9+0AYOomU2ToffYm7ugNUy3R32pTx11kEwddH3eXZAQtT1gchkmGHF1ytmTqnG/A834rq5e/zcoo5sL2db8CPEwqusO3E++JX5iuFzqY1LCT3E1ZRxwv1IdAZsSmK+70JGH89UpwfWhVGJxxvyN1TFezDepdhwlpdCou2bRP8xgUFsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q3WiLXd0/bBv6Dfupn9wCBMmtHTv5kjujeOcXWDKnk=;
 b=OYhRebcnOdXrYDfOkRvhCqHtOn2dE1MCN8gw74WAtRt9d9znS/u6pXIt/bC/Hfp353iwkyhjtewBF0+YZsP7TPU/zPlYKWiufSc4RoaMc/3kNHF1ghRQllww8YAKs6wMo/IREaj4lXfQEj+OdRJpGj4b9te7/E4s6N0x9/iGYT+8PnTPvqau4ZXlYRO/7/2KfjjNJg04FHgMQI6Cbo/LDCsgXaGVDWibyJRPk+/qsO1jk7kjUygaKwlm9+FKajKLVXmNzdZTJcXOoVvDy4HqyqSU/QkvjwLowPeHZo5me28KwHcF1BHLXi5Lk4wEQ8p/iDskTB/3ogmh3cd8Hl210A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q3WiLXd0/bBv6Dfupn9wCBMmtHTv5kjujeOcXWDKnk=;
 b=1rn/qiSg5yGgi4/aodL5eOOf7XBJtBAlFOAUg9LaLSxZhHjl3pgAJKnHsvESdmI5r3EbFZqBbcZYzC64WABnq/sxXXYsA4wma9p6QE7U8Hct3TqRO2PUIkY+fCPfDb7szAH85L/NOyWlxcLt5Qmvyw2016bTUxsLTidJZxXgB7M=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 9 Sep 2020 10:34:53 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 10:34:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Topic: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Index: AdaGiu0LetZWdMcuTBOCRWM5fSEKUgACbR2g
Date: Wed, 9 Sep 2020 10:34:53 +0000
Message-ID: <DM6PR12MB4075E800C3E298FF09327D0EFC260@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-09T10:34:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f307118b-5d1a-4a2d-a9bf-000023e07059;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-09T10:34:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 423ba130-5331-4d51-80ce-0000c747e8e9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-09T10:34:50Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 53152b4c-41b6-4be3-a65d-00002d60497b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d3baa77-c554-4fd1-c148-08d854abfd0a
x-ms-traffictypediagnostic: DM5PR1201MB0220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0220BC9565CCA624968411C2FC260@DM5PR1201MB0220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRs00L74MVMr5vkMa85o7C9Rptp2fgVDyDHf6/qbWaUlkUqZxiZAZOr6W1u+O9GTrml2cuz9zKzp8uY9qmd8meAcgy6hFIHuA8I137YO4AraAcPT+fNSLAdkq2RYQmHR5pGoKXSc0VJgaA8IHWmUo1z77DjIXtwjvfzkXflXkC7TRE1jK5NqlaxrvuWsZPVcn/YAk6w8XhrnaNQJ9aSlvIwBlQcH6BwYFXUwkLSC+m58bxdlL3q+9V/LcYTffwLv4HkK+kSzupmuJKtKeJGPPrAtz/G+JxItlQoJZzwdFWlyIjgZz3vPUh/CY1VrN0qW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39850400004)(346002)(5660300002)(9686003)(53546011)(86362001)(186003)(6506007)(7696005)(33656002)(55016002)(316002)(66476007)(66556008)(64756008)(15650500001)(66946007)(71200400001)(4744005)(66446008)(76116006)(478600001)(26005)(2906002)(8936002)(83380400001)(52536014)(8676002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VSQSRnRTN+3FIeim3dOS+66DdxWdbprTbdt4wtnKJY24qqxIDnIHOy3sXO8gLC+JpP2tZRWB/uk432uPYhaMuTgWdSvKDkgiiYYLf1vGX+2DkBY6Xdnp43fgrtTPudOYlPiNbxf6PDte+ndl00SbXcjTnBF5oUUvRei4yE1MKsdexUK6HVC7KWYleKC5beHHw2yuiEUCfm6GfatRZ+PbxNONasLuOSacoWyhndgNCsbeYyhpCvNVejR+sCmKNrhECkha1qQ4e4uQv1uxoO5uONLRKTZHxNdhrs4A6aqmDcvKg+AK7ufN0Ww4ctUSBJTSWsQCq58fSfIGFfGIVlYoqzOIPpM8nOkN0Gvl6sNpYzqnLroRE1h+8P8vuFRSDpEw9nES86r2CHVhQzeruDgQDnx28GGMZTuh9K/JZxDLzguYGGvAtb7XMaP3sd0geE5CVDcKX6zArg48vjYPHu3zkKbqkV0LHcWZRtY/WotOR0gNwo9IHwFLueidDmlRSOHLa+TjMw/U3mycc2MBYJBJf9q6SCSSjO9Pba0I88tjwIVwskOvVqTO6beOxKI+KlodlPrwCzeWnqUA3I3DPghlPCo4FLq+aui4we7O4QOiq6zmhoKQRmY1nao2Va7W/0k3UtgS48AGSfzAgAtq0YvnqQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3baa77-c554-4fd1-c148-08d854abfd0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 10:34:53.2853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzR1UtatAZ+sA0bC7oLwmIfuFPKsj6wQB6VB0qTL25VRY07ZmgNHtEkhTo1tZfJJ0azjgL7shrdlPWsIMWXISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Content-Type: multipart/mixed; boundary="===============1746469195=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1746469195==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075E800C3E298FF09327D0EFC260DM6PR12MB4075namp_"

--_000_DM6PR12MB4075E800C3E298FF09327D0EFC260DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

BTW, please use the git-send mail for code review going forward, instead of=
 attached the patch.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, September 9, 2020 17:24
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS init handling


[AMD Official Use Only - Internal Distribution Only]



--_000_DM6PR12MB4075E800C3E298FF09327D0EFC260DM6PR12MB4075namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The patch is<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BTW, please use the git-send mail for code review go=
ing forward, instead of attached the patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, September 9, 2020 17:24<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update RAS init handling<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offi=
cial Use Only - Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075E800C3E298FF09327D0EFC260DM6PR12MB4075namp_--

--===============1746469195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1746469195==--
