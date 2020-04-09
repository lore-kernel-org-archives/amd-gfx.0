Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE30AC2D0EA
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 07:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C3A206F7
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 07:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ypyJ7nx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C3A206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211306EB74;
	Thu,  9 Apr 2020 07:34:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4486EB74
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 07:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGozLVr3/g0FF+Oac9J1n3qPGVreLv84F1bUaNISBOC0TR6ryP2Cep4lewEz8mUB06MDPxq1P1N1PT4pH612PTHeyjqx1pBVnOSpMjwwxr2cXOgPQt5g9/y9Qipcg/TFAsxYZDDknp7zKsAcBu9SDpP06zfrLwHZ9rQny94sitdlRd+FR/MWcdE6S7TMr+E9+FtwzvhxKzobLXX0Op87f7bPpELa+EP5QhAIL+wGoIJVlXBX1Mh6lT+ZtCsx0wdSB3Go0U/Gr74qbbBiSSa+Uw62bqB2hvZHPgmeA/gH0Dt65qcFI80nep8PKebUFyGcy9Vyx50IfoA0ApZFP+bS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqpDrf0Y57NrtyuAGIt7exBySW0JymuIynG2hRKzHfc=;
 b=gQv6aaWBWEoJbLl7vaQBwebkmLuGSnNJWBEYeZC+LtlqWITLbEmmKrcxCYSJEsNTGXo2p4nU7e95w/O2ilGH9MAks4XPpX1BZFNSN17H6rNX9BnXk4vahFH6kiEF6EztgglymTRxWHvuAnT6XF03pvS8tPwQwLk+kI5QO3JJ2NigKFAW0D7JGS7Mya2fMlv/Yt0j6G1jdizdLTk8h9WMlFEJUScS3j/hZn9CXUAy2QELpyuYzWRxt+LuUCbetyJ0L5JiekYQrCC+Bxa7o73KL6hgr00PhQvPXbVVae57r+WUePl1M8y8WlLg0hdxwpAtCBL+GIIkJzH4w+SHUoej6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqpDrf0Y57NrtyuAGIt7exBySW0JymuIynG2hRKzHfc=;
 b=ypyJ7nx4keA4vg0OyTsbkNJeAuKdkR9imvtlT6YTULHmgitkzOcAavKkYIIm5GfQyPQ2mukm5PI4xE5zOrRmnkg1qOUzk+huQwllzSCfhfjDBeaoE2iR4KYr4DI1uEDqux8aumgSIjVMKfF98AHs9apyrIuXHWT5Nl87BL033Ac=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 07:34:49 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 07:34:48 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Topic: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Index: AdYOQUS7RlEBuEB3RsWb6izfGut1iw==
Date: Thu, 9 Apr 2020 07:34:48 +0000
Message-ID: <MN2PR12MB403254AA3427896F5E99F3DBFBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-09T07:34:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: edf2bce5-2864-44fe-8457-0000a0192b58
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c65af5cb-f580-471d-48b5-08d7dc587be1
x-ms-traffictypediagnostic: MN2PR12MB4454:|MN2PR12MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB445472B983BD40BD5AA8DB8EFBC10@MN2PR12MB4454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(2906002)(110136005)(7696005)(81156014)(316002)(86362001)(8936002)(76116006)(64756008)(26005)(6506007)(66946007)(186003)(66446008)(71200400001)(66476007)(478600001)(55016002)(9686003)(81166007)(66556008)(558084003)(52536014)(6636002)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UA3h08mp2PIuHniKXGuG3sqlmOodFvqA5/J8cPzrzlkn4/gQqx7x5k/CFhXiX2k1h3bDN+kzDYy/c83gdQSkEtKB2E2jdilByUATmE2/kJDs1+0sXQRlIie9s3t3qKLiQlGPQEz3mJVEg12Q7qOHbtCxIKPI7ZbDJgeR8am6PW0gL5ISgIuOBkZ105TrWessA4DctKvLpbqXsTsDmrOSItxarlRXoClfVWk3mfLeY0PIrRs/ALF5ASVoW8Fc/it61pVyg2aacoy+/zatHo+UkBlk8c4yHpg0PYwpAUSHxsDnIOoXK3QvHqloZkQOvnJxJio131CNFqs8RT9CW9/8hO2OOYQmNq1iBeWLhzRkVlseQQWHoJdkYput2PweZcMvaUXWC6Mq0VM2M/B/jh5qpMuj3qpwncFyv8JT/4VL4Fkc1oYbzDrQOWzBGSv0v79V
x-ms-exchange-antispam-messagedata: PZzEOEx1tNS4ip/UT2cBuN/Fxc+EreZcdXWkVq8K4lpcWb6EMSbGjvbXhjtpCtjCTzBHZLW4m8GYLXBYqrghu5YA5RDbXOCfC32hbWVMLVgWVr1qICCK/CtTWsJXDHbAlW6XLmKVYEWHUx/fUXeaUA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65af5cb-f580-471d-48b5-08d7dc587be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 07:34:48.8309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8gmc7PM1v0fhnI3zAY/UU7AAy4V9HCp2PF3mDuMJAdTQShLQ1tYIfV/cmFSfC6j5l4frNZVaTxugAgUONiPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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
Content-Type: multipart/mixed; boundary="===============1871081974=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1871081974==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403254AA3427896F5E99F3DBFBC10MN2PR12MB4032namp_"

--_000_MN2PR12MB403254AA3427896F5E99F3DBFBC10MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to increase atom cmd timeout from 10s to 20s

Thank you,
John Clements

--_000_MN2PR12MB403254AA3427896F5E99F3DBFBC10MN2PR12MB4032namp_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to increase atom cmd timeout from 1=
0s to 20s<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403254AA3427896F5E99F3DBFBC10MN2PR12MB4032namp_--

--===============1871081974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1871081974==--
