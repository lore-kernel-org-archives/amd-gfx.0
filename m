Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95FC3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8D2208CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4GYcy4T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8D2208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCA689EA6;
	Thu,  5 Mar 2020 09:56:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C223589EA6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyOydM/Uyr1e1i+rGoXDFelSeRbUBFysSMKmxCWX5CFJ7JbV+C74TwLHZsEp+SAN8se59D+DlL1UnQJYQOrdzvX5HPtJQ8nG0RU+2ZBfsMqabOZwoAHHB2SCjTOkKUJgyyB0bMuuvAfBTXL3/4dw5LQ3M0QsZDj2/aBKoa+fIP/Tis5HEttTJjwrYYNfeBLEPqrrSXXyX9zyVna9B2PvLVo5oR3zkDwmKcthZLgxQyDzTBudjJ9ZXb6+9K3R7Qwg8HwuxRKhTUvZJASEMpI9ph9r3ZTTJ3Riikx276Pxvpz869H5bMG5f19nGSgpUBSkoxemp0X22FE7YxFA0Sy6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG8wzeDtZwEoPSQ1uO2myevhnMI4gdD6E3a33i0X8lg=;
 b=L/rtW3xVAhn0P+m83++mYjTu2xm8ZMlwGH1YYHswp3iWpkp2XQseDnqbPx0FXpO45JXw7Trp/eLjzmyjjIV00NoICFqDn/64c1ZMuA8ZjljfhWRabLfKOSOBnKwgDuq9zVOsJJY1VZHVRR8204cy+zZRKHsDGxMjLQ/HiM3AWChBrebYEnUI8q8HsyNXyj+N8xusNUuvGL9otmr2Sn6W1qE8dtz9MnB03QIziiawcPxoBT8gUsIvnsfjvGKYfOkVxRoJ4ae/Szquki3hr3Xkdt2hAnIwli3yntcDpwGAv52KLJUA4M0UIb+xuAFtECb/7ZH3J8emc+0GL4JBpgEUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG8wzeDtZwEoPSQ1uO2myevhnMI4gdD6E3a33i0X8lg=;
 b=4GYcy4T3HObN+7Ud/RSn0iUS6IO9AQbGhHF0cBUgbn7bttaJfoG+7Adfywxzvb0mzTgvjoQ61OeQRerTRfsvTuVo/8D2jBaEAlKtMyS1Bh7RKbqEHOagj7SXGhCdIZJaVeNX0aKTxSy3/WQjnGm9vRnALAOZt2p0mq8ebTVaubk=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1739.namprd12.prod.outlook.com (2603:10b6:3:111::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Thu, 5 Mar 2020 09:56:03 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 09:56:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Topic: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Index: AdXy0f9EIn2WkBwySKekkStORNst4QAAeMzg
Date: Thu, 5 Mar 2020 09:56:03 +0000
Message-ID: <DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:39:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ddcdfbbc-89af-4d2f-8549-0000f5c83eff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T09:56:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 05ecdd9a-a898-4f1b-b8b3-000043294b77
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 667ea103-bea5-4901-e20d-08d7c0eb6ab3
x-ms-traffictypediagnostic: DM5PR12MB1739:|DM5PR12MB1739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17394AE0EB6D8D4F2A91F36DFCE20@DM5PR12MB1739.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(86362001)(316002)(6636002)(26005)(186003)(478600001)(4744005)(33656002)(64756008)(8936002)(81166006)(81156014)(6506007)(5660300002)(7696005)(8676002)(53546011)(2906002)(55016002)(9686003)(52536014)(71200400001)(110136005)(76116006)(66946007)(66476007)(66446008)(66556008)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1739;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMTJEiEOMKXfkzkOYtnjYfqImyYOdpUkt+38tmzVUX4zQoSDqxtIA42MJYdZSB1O9DY3cq9K/5aEtwJwp8fSO0TqffwhLjYGOMzJbQEUCUX1McOUdCEF3fg5gJcy2eZbuHuTp4N1OFnDWyobBD7PH+r6w0xZuHVdTRUjf0Bbd4fnHFpHRCOi+aq49W07Fr8Kgf8S7OAvM6f0DqJLPlPJiZBzdddLyWlwLPBlOlVSd5B59UMqILD7nTL3hFqxbq01IKvCjKIgXyrKVAODgurmw888JgmH04goLBgpJD2c+nee3S3rHfwdtn35iVnoXTw2FOhFN5wBmYWp1K6107UwCkp+3cJYbrXnLpK/ELoPeQQqbiMxraJO3PLEn9JTPSygSGRz4EiQ1z5AHNt3YZGQP7H6a+G4rE6A9M3k3gOnoI5AFe9Qk+y8nQIkbw3JBPRp
x-ms-exchange-antispam-messagedata: u+ZRB3HNt6kQ4aXK4oRDfJqj4AVgbdHfvVqTDHNfHFisLjBHJCfEJZ7kR1Q8tJwcbnlLZXLOLFDNiaLkqZo3Itzx8zL7u680aIH+Usy/TbTSxrSmBnKrbztQLMoTeoAJNQdef6GmCwNU1rtJyW/zqA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667ea103-bea5-4901-e20d-08d7c0eb6ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 09:56:03.5716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAbBOTl106tyCnr9AUTVn8UHekT9aRMZcyMBoL90/BrIu8056Lew0FhWvIbhM9ywtBDTNZyQ2yoTIHLf32U5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
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
Content-Type: multipart/mixed; boundary="===============1013470514=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1013470514==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20DM5PR12MB1418namp_"

--_000_DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi John,

Can you please explain more on the differences between (a). exit immediatel=
y when mca_status is 0 and (b). exit when some of critical field in mca_sta=
tus is 0?

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, March 5, 2020 17:40
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Guchu=
n <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: update page retirement sequence


[AMD Official Use Only - Internal Distribution Only]

check UMC status and exit prior to making and erroneus register access

--_000_DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20DM5PR12MB1418namp_
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
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you please explain more on the differences betwe=
en (a). exit immediately when mca_status is 0 and (b). exit when some of cr=
itical field in mca_status is 0?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, March 5, 2020 17:40<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update page retirement sequence<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">check UMC status and exit prior to making and errone=
us register access<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM5PR12MB14180E64D6C5E62E05DA8D0AFCE20DM5PR12MB1418namp_--

--===============1013470514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1013470514==--
