Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E2AC2BB1D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 08:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5549720692
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 08:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bVYjhZKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5549720692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14BB6E073;
	Thu,  9 Apr 2020 08:13:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9486EB9A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 08:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSd7SP4GktymcZn1mgh5dWSmFfevAohneOgtvb8WM1ALo4mMBEwFwZ02LNnB4B8opwsvxgUD5i0dVVj+CyyfSAM653OjSf/YVa1bnmmI2BimV/tsQgckG9fLYAxG88ImpTZp5xkxs/F6NSycQtI0Cuy0BKVFmHyECTCpdPOKn1WA56jC9brEdk3pIWz5U+0JHQO7eYELScLsYTd6wzg4LsXkff5+aMfFmYaiHCGq3owbYSuiFK7KbqKJoSD8ow/6kPnbs7ZZ3FZIh/2Y/N7Wqndq+W4QiKWkMpz4GTa6jTUlc+9MsYQ9yVffWa5bxliSU2KS8rYbeaQhcs7GF3cosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuZoIfaai6arn82lJUjEfNqsRofb5vEx86DGEnucHKc=;
 b=BSQ2KIoBrJKBxRW2C6ozLOReYwB1X9Pqbguwux3MHI9KOyyQWIHna8yer4eGQyX+C4aekJvNSsJ9KnuFK3Yo5/IqZjujXTww9Czl8AHpfAWDc0puSJ1zxYLKgDpBd8DiVIeei9ldoSF0nsHaFOBY8BsMChe6u3TWEPHosy7vgJfpw3ExqPlFxooNKgtX7NWTNecIrfhqLr6dRvaKobLpVxZeq35bCskWypx1oz/0bhF0CRjX8Tojf+1go2F/gETL44Yo/O9J3S6fACKSTy4gOwHpEuyz7RhAcvoshybzT6RVIVPTuNSOYmfYkYPUC1yzHHhfypEfOZECxyVOfB8BKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuZoIfaai6arn82lJUjEfNqsRofb5vEx86DGEnucHKc=;
 b=bVYjhZKIL/be2vJxUiKnXu7erNapxRqBfUTtst+H1lUNTgoB5f/BVq6F/Auer/3TpOCVOascHwX1yF7G+buHk6F3rPD5zdOBQGUZGJyY/5pDYNxWs7omKJD1CpV7AyZugBX9X0sxxGVLb9MRLkQl2ZY9et971NAzr3xsRh9oy3s=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Thu, 9 Apr 2020 08:13:52 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.021; Thu, 9 Apr 2020
 08:13:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Topic: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Index: AdYOQUS7RlEBuEB3RsWb6izfGut1iwAAC3IAAAFUN/A=
Date: Thu, 9 Apr 2020 08:13:52 +0000
Message-ID: <DM6PR12MB4075245CEB871D69A4D12A34FCC10@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB403254AA3427896F5E99F3DBFBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
 <MN2PR12MB40321A470DEC718A2B8571A9FBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB40321A470DEC718A2B8571A9FBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-09T07:34:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22851874-540e-4d28-9204-0000dd2bf020;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-09T08:13:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9bbbfa55-1c11-4be9-9486-0000b650b933
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae3e94b7-9068-45e0-bce1-08d7dc5df094
x-ms-traffictypediagnostic: DM6PR12MB4417:|DM6PR12MB4417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4417C711D34CEBDE11DE0B20FCC10@DM6PR12MB4417.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(9686003)(66446008)(26005)(110136005)(8676002)(81156014)(86362001)(8936002)(186003)(316002)(81166007)(478600001)(4744005)(55016002)(64756008)(33656002)(66556008)(5660300002)(66946007)(76116006)(52536014)(2906002)(53546011)(6506007)(7696005)(71200400001)(66476007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOJuVHsOi8lbvcPcxae3Pv8fWwIbKaVi1OVTsSmcCiFWdvZzy6wlE0XUhwc28zBmF132x/Or9gGDRKkSqWS/HoITpDUOnGzlN2pMONk0KUTgo1q+rMjWMGoGK03gKr4GImBlV/lGYNr/W8A9oFbFT4aiYtEDxK8ISORxJJyYPn0UZUsTnH9yjLBgewci3FYKBG6B48FerD9AkIQZNRpdzsZ5PayjKfCAr7cn/apiwYJBnSmvdN5z+EOXv9rC+/yY/+fUGjQ7Ue5NvRVnSl1Bb/h1vGURft/i76zJhHuehKHDRRkPJfsAb6yhGwMv9XFI/T9YgBydWiU4k3zaFuAaHzX+c7EMflZ5SWr4rHCMzNG9dyE8VoFQfUWheuOsRK1Ipu/kNXig++HIQFrTbACwFbZwGaSjEFNJak4JIXtg4LgkLbmwG7pBY4xRKPTARzwo
x-ms-exchange-antispam-messagedata: n3y7FY7sOI4Qg9Amz5gdOHmfOkmi+cjqxtclkUNiYq3Ma+9spjoZXA9/a7s0CFWkGCrVSPXwilXxqSA1mSZiMKrtloLC9vVPKc8nmeiYEeJoBEQqADbOp1Y4mAdZocwKpIyMCsUXxZpteCGC9khQKg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3e94b7-9068-45e0-bce1-08d7dc5df094
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 08:13:52.1229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z2T1N8/j3ioXKKIH13RavnDwgaI+l1Ds7Spmq5tmGFLW+aqmOpyy6Gn3WStVnWkH8Yz6i6fgnKSN7TbV862Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
Content-Type: multipart/mixed; boundary="===============0877444120=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0877444120==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075245CEB871D69A4D12A34FCC10DM6PR12MB4075namp_"

--_000_DM6PR12MB4075245CEB871D69A4D12A34FCC10DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, April 9, 2020 15:36
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increased atom cmd timeout


[AMD Official Use Only - Internal Distribution Only]

+attachment

From: Clements, John
Sent: Thursday, April 9, 2020 3:35 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: increased atom cmd timeout


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to increase atom cmd timeout from 10s to 20s

Thank you,
John Clements

--_000_DM6PR12MB4075245CEB871D69A4D12A34FCC10DM6PR12MB4075namp_
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
<b>Sent:</b> Thursday, April 9, 2020 15:36<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: increased atom cmd timeout<o:p></o:=
p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;attachment<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John <br>
<b>Sent:</b> Thursday, April 9, 2020 3:35 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: increased atom cmd timeout<o:p></o:p></=
p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to increase atom cmd timeout from 1=
0s to 20s<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075245CEB871D69A4D12A34FCC10DM6PR12MB4075namp_--

--===============0877444120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0877444120==--
