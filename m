Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D93C33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 15:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7802083E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NrGVW6Su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7802083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF956F5BD;
	Fri, 17 Jan 2020 15:02:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533026F5BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 15:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3ppZsXLki1DNcnz1g8sIOr84M+3djMuIi3zUdKFrMfqaqFStkfs6tgGGmjDP4Pla/iO6xd/VV9twfMoUg77ySmqxBaydo2PoNAUq2XEruI9ROJdwbT0ENehYeur4bc6f7o6rXDg4qmX1FzkadvqWcLDXzvu2+kenXBxD0ZBl07sXdDFapx58yU+rfCYP7gL9kq/ROG6kbvlEK7Rhc4+Xj1/+Guih6dIjUHsM2fcXGr0w8O/eC+F9q124w9jUXL4cYEbNHpwry+iLKAv38mBTeRtTY8fS8UW0sUwwDpy2VgLeCqDqCavh1mGipzQHb3tOE6vIZwSd3egQYKtXJLLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6yPkQ09yET/1oU3klV1ihn+zdB6L47/ohZxvFX3Qs4=;
 b=YKY1nrXSv95eLYNH3C5rF+IXTOHmfTxswfy96jwDtjXqSuDG/L9tCm/3TVvLzX9MJnoXdA5UyxZtKHJo2acN3oBXbGytuckq2MJVvrjLRGzAGPZOqlmVBTEuOdkGcmPs+EFrXWNXI6gPbYOvWFkIW76glbeiouvAd4HwsEuv0adfQY98TmSx7w0VCNYlyRnuky9al4LTM/oIn7cAUv5ZHflDQ3LRmaFlYdmPzBF6nfMD4B0ZqZk4N6W4AwgZW34t+5O+938a5Seh95ipJqCZXQLcJgYm9ApmpDow4KAiBN1Ds4YN5hsiRtB5DrAw/jn37zFjqmNECSdXuivF+QlEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6yPkQ09yET/1oU3klV1ihn+zdB6L47/ohZxvFX3Qs4=;
 b=NrGVW6Su11zopicu1qLB/HkWKjgFILv/Qr1m2ZlBShPmTLxRghu8cjpwzDNI4PKM4uqDmWLVake0cFTiNRG0J864qTz3owpEyyvTxBkFxezJ0sDSb5a9AfYIZNl/vAkWAEQMX4qrcA0BHTrd5u2HqFeSXJQwZ6XOak0AZn3ZQ1E=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1466.namprd12.prod.outlook.com (10.172.38.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 15:02:30 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 15:02:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Added check for RAS EEPROM support
Thread-Topic: [PATCH] drm/amdgpu: Added check for RAS EEPROM support
Thread-Index: AdXNGmYX/stLAjpBRjij9x4yAb51oAALGUOQ
Date: Fri, 17 Jan 2020 15:02:30 +0000
Message-ID: <DM5PR12MB1418BF085C66B79E1CFD60B6FC310@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB366303B43AA493B2893B8922FB310@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB366303B43AA493B2893B8922FB310@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-17T09:43:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9a309eb5-4d24-4287-9df8-0000fce02d88;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-17T15:02:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c335e7ee-33e2-4f64-a289-0000692cf180
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f8343b8-a5ad-456a-043e-08d79b5e4686
x-ms-traffictypediagnostic: DM5PR12MB1466:|DM5PR12MB1466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1466970F5FC92EC676246B38FC310@DM5PR12MB1466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(64756008)(66476007)(66556008)(76116006)(66446008)(7696005)(316002)(66946007)(6506007)(110136005)(53546011)(4744005)(186003)(33656002)(52536014)(5660300002)(26005)(2906002)(86362001)(9686003)(55016002)(478600001)(8676002)(81156014)(81166006)(71200400001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1466;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miJgnB+d+pzjaOuMDzViUPlDD3kpYjiF+xiRPdpSHVb8SJnzpJlU62T4TksC/QtEgrbwkUcXGo+mERLIGOWNGXos+gnR0RYB1bauf0QuFH8NDzXhh8CHFOSEE09bPYbI/mHdyKSvT0fU5yGIv2LcoDCL3FZ+wJ+KMVEehDpCvbpCzsjh6mIsiFXuJJg6LrDYrQpP4Cuq+k0umUvpGCcSwRqh7rEUHryvZwGsoAi3AeLNkJwuAs9KPZXZ34bIPPYyFcmTPGn/mSPhos4XOg6GSEART2HCS97kpMRfKSEgTga/+Ya2cKRwIByv/NioEUIwD4QVd6gOf38C+eBajIUK6Shfn338DMuCqpvIoafheXCBX6m1mjOnAiuGQynGp3gh5mM0wPClJodqMxjYolp0s6IlulcuI3jpnfxgue4Fp16orZECxSTBnFiYgZy92M9t
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8343b8-a5ad-456a-043e-08d79b5e4686
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:02:30.7224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Vrpwi6y9QyQZ3ti9S7I+RjrDDrn7PWU3iJDD5cg0DY+gr54hbjFO93EXdIC4FOVy/61kUR3OYVX3TKhMx9tmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
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
Content-Type: multipart/mixed; boundary="===============2034222449=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2034222449==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1418BF085C66B79E1CFD60B6FC310DM5PR12MB1418namp_"

--_000_DM5PR12MB1418BF085C66B79E1CFD60B6FC310DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hello John,

The patch is good enough to deal with the modified IP_MASK parameter which =
masked out SMU IP block, but I don't think it is able to deal with module p=
arameter dpm=3D0. Please check with Kenneth to have a better solution for b=
oth cases.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Friday, January 17, 2020 17:43
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Added check for RAS EEPROM support


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable access of RAS EEPROM in event SMU is disabled d=
uring modprobe phase.

Thank you,
John Clements

--_000_DM5PR12MB1418BF085C66B79E1CFD60B6FC310DM5PR12MB1418namp_
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
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
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
<p class=3D"MsoNormal">Hello John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The patch is good enough to deal with the modified I=
P_MASK parameter which masked out SMU IP block, but I don&#8217;t think it =
is able to deal with module parameter dpm=3D0. Please check with Kenneth to=
 have a better solution for both cases.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Friday, January 17, 2020 17:43<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Added check for RAS EEPROM support<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to disable access of RAS EEPROM in =
event SMU is disabled during modprobe phase.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB1418BF085C66B79E1CFD60B6FC310DM5PR12MB1418namp_--

--===============2034222449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2034222449==--
