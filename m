Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52939C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 09:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E726E206E9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 09:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wA6bR1Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E726E206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE6189CA2;
	Tue, 14 Apr 2020 09:22:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5FE89CA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 09:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhAhAzordH+5d/9dmTi0wL8c1aEelxMuhoH58Q+3KykY6xCg2CChppTG1RR6clWUe/1bmPNO6t5MByrKRPQp/biBkW0VObEOpH79Wlu6EjK12LJbvswziaFzH+QHOQHW+0gtZgAvlufa/KFsOjh3t6GaLiSFva7+OGWWiPA8wSsJTwQ9DxZQBZLEH9H1bInzKQje+hnT7UqVGKOsve7t29WK2CYSn0nki7QlBsKyHwJ9iLLt5A2ODEIpbJ3Vmx5dVVs0aQwFJG8SK3E8PNMTb8e+iOmTPmALt4LOdrr3/JSxI3ZFqd8sqc08CvjOglAGT02+uJbB2NmeF61q6Fzh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+6jZsTZa75lvHMHWM9JPHA2okUFVpPKk8Wol+0WN3E=;
 b=ajhOsPUUTvIq/dETBIbjc9vmlKrfUzDluZWfCG2ooK6iNHw21Q57cRFeH7depWngb8vaXjboatBrrW/3kcYc7Hy/QWZ1TGd0/TnJH9vO7h2dmQS4+YcYcuAGGmyop2ZMqp7FulruCNZbnDP6arrzlk1dfJtXqoia/aA/kj5GQiDs6ExkTNJNcKFVYPKmCf5tkc28dp8DPp5d9KXfPJiVYrrhwSdMPLs1Kf8UlWbF7z7e77h9ugjRWFd6MqrYDZCP9pvneI+pmNszG5SnE4ExIa6Qz8IxBodpmxvXpvA2o6h3Ozy8aI0tmXKQaj+JAlKBIK7DvLQ7sxb9hv5Zfws/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+6jZsTZa75lvHMHWM9JPHA2okUFVpPKk8Wol+0WN3E=;
 b=wA6bR1PvJingcbbj76RVG53ud2QibBCf6LTPdNiUB7wk+P1mzVW8nTeut2zM61MIVA3sVG3nshVbnZVAfon/T+v5+XtOBQNtHW5ZWjCMBJCBOslLJQW+lLNJZ7EsE8LYIADInPr6lNmgFcn47wTDmnl79wylxMVWxpbivAA8iF8=
Received: from CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 by CH2PR12MB3669.namprd12.prod.outlook.com (2603:10b6:610:27::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 09:22:45 +0000
Received: from CH2PR12MB4070.namprd12.prod.outlook.com
 ([fe80::5dd0:6759:2911:2991]) by CH2PR12MB4070.namprd12.prod.outlook.com
 ([fe80::5dd0:6759:2911:2991%6]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 09:22:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: cache smu fw version info
Thread-Topic: [PATCH] drm/amdgpu: cache smu fw version info
Thread-Index: AdYSMcqAXw33BUFrS0SxAhKaAVYnawADGtdQ
Date: Tue, 14 Apr 2020 09:22:45 +0000
Message-ID: <CH2PR12MB4070E2EF4E1792A41A8B8D6DFCDA0@CH2PR12MB4070.namprd12.prod.outlook.com>
References: <MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T07:54:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7fa29d7b-11e3-4e1c-b36a-0000e2a49d4e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T09:22:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 96786168-677c-4670-aab2-0000279dd9af
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9443d5e6-aa2f-40a7-8fff-08d7e0556473
x-ms-traffictypediagnostic: CH2PR12MB3669:|CH2PR12MB3669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB36693E079BB5FC0E3944D182FCDA0@CH2PR12MB3669.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(478600001)(26005)(76116006)(9686003)(186003)(66946007)(66556008)(64756008)(110136005)(316002)(66446008)(66476007)(7696005)(52536014)(33656002)(2906002)(6506007)(53546011)(55016002)(8676002)(8936002)(71200400001)(81156014)(4744005)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EwqBtWX3IKZxfaG7ww+i/jeM/iiuSPFxN0utCTtqTjVt3kLeBIQ+1dwdgio881zYWqVrcn1LyAx/9LKdlgii/xAuoMZC8en0e8V9rWVgK+aJqAzlo/js2CLK0eQvAygqUom8xKuRDiseduEjp/pVIhy7s9AhWUgmk0pCz1UkrLp7Ufa9dQt/EANKuZFN0auNFLVWphEbCt9WHH1+lDi1OIRssevF5Y79c8taTXCy1hHt+VyKOhP7ltUZg4mMbGvkhH+32lwM8QCZHvU/2PFXBg0UtgyhjY9xOXMvjPe9pR+HCc46WMqviqAvvOwWgl2LDjWgcf0tmfDjaLK2zgDMI8IllfRYVUAcRupgw0J4ClGleGiyPNGm9K/zqb/sVlFGMQQ/2MvYm8le4y3kRQfQSLJm6v2Ha//13RYF6XxFdCpIe0Z+eSrolHMeQWQ12FvQ
x-ms-exchange-antispam-messagedata: 7W0l6HzEJx17uEvOjRoTPHVpw7E/dyUQd/qU075vJBzRXQxv1uOhx05FFNVlj00XyC3vbpOdsePOYegkd/zqbsQUS4rTay8K6xUm4Fqh7pnV00tBUqnGP12+M6hj/NLN35VQNqzwyDckFbNJp3xADQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9443d5e6-aa2f-40a7-8fff-08d7e0556473
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 09:22:45.7126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XS4FWO4f3qXQqN8JBB5HIlfoZNT/auefsQmItp/eRBCcivK0wl1FA+zc/8kAtsgiO+vpnct53BxzMghec99OEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3669
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
Content-Type: multipart/mixed; boundary="===============1084061261=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1084061261==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB4070E2EF4E1792A41A8B8D6DFCDA0CH2PR12MB4070namp_"

--_000_CH2PR12MB4070E2EF4E1792A41A8B8D6DFCDA0CH2PR12MB4070namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, April 14, 2020 15:54
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: cache smu fw version info


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to save smu fw version in local smu context to avoid multi=
ple erroneous submissions to smu when requesting smu version info

Thank you,
John Clements

--_000_CH2PR12MB4070E2EF4E1792A41A8B8D6DFCDA0CH2PR12MB4070namp_
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
<b>Sent:</b> Tuesday, April 14, 2020 15:54<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: cache smu fw version info<o:p></o:p></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to save smu fw version in local smu=
 context to avoid multiple erroneous submissions to smu when requesting smu=
 version info<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH2PR12MB4070E2EF4E1792A41A8B8D6DFCDA0CH2PR12MB4070namp_--

--===============1084061261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1084061261==--
