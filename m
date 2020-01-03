Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCE7C00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 08:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB0A21835
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 08:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AgFwWacn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB0A21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B781F6E191;
	Fri,  3 Jan 2020 08:13:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D086E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 08:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APdIDutY0OXIMTudG6TRH9yKtNGBmWI8XgKA/D0XEfYFnpVVhIEp/b5Sm0p6M73tu+lPa53VoZn/qZMS6nei1csAMJDqkqMHHOCiM5y3FckKAwuZI9/mOIlkIUNN4l7Q4KrihJjA48jYVDul8PR4yA2jOKL4XpUymrckPaq2+EzF+Xhdpr22D9UwbCff39CCuW6k5gAgca3M8BK9LAFOLwvXfYZylsp2PWufCVkBEzlm6InCdnE8Y00Pso9orvc6wHle/HM6bX1VUCaoe5FqLhcTWcsjigfIc54jLz4LMfTWeGN2X6yyY9/i12rQSflifa8MP6p/mkuwAGL9T9VKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGr7vAaEuBxCEkdtsD/681Es2FYkiNDPTTZV0Bj3Ahw=;
 b=XkV/VKpGD+8QP8OEReUUElfym1Z9TDCsj10vuwVPBXsTeJazUnPwZZAuzQYBZ7gmLQYx17Vu0EiKtlFpEffwX8Dq/q6ST0TwZREfbrjdRVaPjJoitn9Vh/+8DFAPJsAKwNB+TspsUB52CuhT18BbPVc4fQrXOa6uF2DpleGaUlRTi8FqqF6/oOjkjiviDBW9A6EWvL1hfWqtC1oaa0ciNnfZETv3fjrvaO9IlDY0mWNVbt6/1bL1mZJhal99E+xcVUf0pEIEEiUWGsPxlObYrVTdTv5lsxhYRBfSsE3QGlNcWfLiXlG3yCBBw76ww+sqOQoEstH2wAIVloHd2owZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGr7vAaEuBxCEkdtsD/681Es2FYkiNDPTTZV0Bj3Ahw=;
 b=AgFwWacnEcTzueqUrjR/w0ZjAAyq22vkYPXnr6LBYbWkHyskEGBCRVPFwxvHkgdxZcshvxnYdQbT4j7PzjNb6PZ3Z+A1VVLWckbHllit4Ll0Y7eNsSw7RhaSSDIEeSTo8l7GdOBQ53YDjzbljiEaDMkPwd3M0YQNol4qkblulPY=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3662.namprd12.prod.outlook.com (10.255.236.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Fri, 3 Jan 2020 08:13:04 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 08:13:04 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availability
Thread-Topic: [PATCH] drm/amdgpu: added function to wait for PSP BL
 availability
Thread-Index: AdXCB2B4i8QiXMejQxS+NxSqo7TfwgAAgVmAAAEErAA=
Date: Fri, 3 Jan 2020 08:13:04 +0000
Message-ID: <MN2PR12MB36632C11B62C60C12B5342F9FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
 <SN6PR12MB281373E1EB9C577F0649C81FF1230@SN6PR12MB2813.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB281373E1EB9C577F0649C81FF1230@SN6PR12MB2813.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T07:29:18Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1e5af268-6c04-40c9-b21c-0000763fc5e8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T08:12:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a0a29d9a-7d8c-4c41-8045-0000f7187397
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af4354c0-7f17-42ec-bfec-08d79024c231
x-ms-traffictypediagnostic: MN2PR12MB3662:|MN2PR12MB3662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB366241CC5F9850B367C95E75FB230@MN2PR12MB3662.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(189003)(199004)(55016002)(2906002)(86362001)(9686003)(478600001)(7696005)(5660300002)(52536014)(81166006)(81156014)(8936002)(8676002)(33656002)(110136005)(66476007)(26005)(66556008)(64756008)(66446008)(66616009)(66946007)(316002)(186003)(76116006)(71200400001)(6506007)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3662;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJYr45UHO36RYmJsol8C54R8bpOmbAQYiEjJUpsyc1aabcyFEBaIn9GHn8iuI/KFKPHlzpT/jwmGBGSa7bd2ejNRoDmdPp/ekKSKHJ52B/pLglBS8KUdtuEp1j3HjL3ScwNzTgEXOKTLSLovwOErH17N2SrA8w16U/ioMlv1scEQ3jYA2XPd7z1W7uFI/y2IW2Pu1ZC7utMJvupHbK0xjXpnLlUcEgH0iwauFsOzAmzjyfU3BVrOO5BPwc4b97XLnNqiXb7Cdc0Fxd/kgzLFZqXXI+7Vo8GXpYjK89ZExjO7VWKbQa1S3oc40BbX42saA2tobl8WYkYskSStPNlZq6kzUYvzaINx9K9etTn4Pw/GIBV6ZSXfm8+dqynlhRljpX18iClRvuwgzn1xYGylQRUQpdWgoM1FNiZj0LISJ82jROg5zzA1Rc/vYrjM5kvA
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4354c0-7f17-42ec-bfec-08d79024c231
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 08:13:04.5588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYKHzwfLj1Ry2mHAemxNLmFyolMRWU2r/0RKeUy+YEO830JTOiv1Mwvbhc39bTE24ckdEdkhJEAz1rsBXPw6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_"

--_000_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hello GuChun,

I have updated the patch with your suggestion, and added back in the delay.

I can potentially investigate its removal in another patch

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, January 3, 2020 3:44 PM
To: Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availabi=
lity


[AMD Official Use Only - Internal Distribution Only]

-             /* there might be handshake issue with hardware which needs d=
elay */
-             mdelay(20);

To be safety, I don't think we should remove this delay. And this actually =
do nothing with the code refine in this patch.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Friday, January 3, 2020 3:29 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: added function to wait for PSP BL availability


[AMD Official Use Only - Internal Distribution Only]

Added dedicated function to wait for PSP BL availability.

Increased driver wait time for PSP BL availability.

Thank you,
John Clements

--_000_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_
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
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello GuChun,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have updated the patch with your suggestion, and a=
dded back in the delay.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I can potentially investigate its removal in another=
 patch<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Friday, January 3, 2020 3:44 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; Zhang, Hawking &lt=
;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added function to wait for PSP BL a=
vailability<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* there might be handshake issue with hardware which=
 needs delay */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mdelay(20);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To be safety, I don&#8217;t think we should remove t=
his delay. And this actually do nothing with the code refine in this patch.=
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Friday, January 3, 2020 3:29 PM<br>
<b>To:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: added function to wait for PSP BL avail=
ability<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added dedicated function to wait for PSP BL availabi=
lity.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Increased driver wait time for PSP BL availability.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_--

--_004_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-added-function-to-wait-for-PSP-BL-availab.patch"
Content-Description:  0001-drm-amdgpu-added-function-to-wait-for-PSP-BL-availab.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-added-function-to-wait-for-PSP-BL-availab.patch";
	size=3409; creation-date="Fri, 03 Jan 2020 08:12:00 GMT";
	modification-date="Fri, 03 Jan 2020 08:12:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5MTg2MDY3OWE4NTNhMWQ2NmRkNDQ1MDBkNjBjYzAzNzM0NDU4NWNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMyBKYW4gMjAyMCAxNjoxMDo1NiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGFkZGVkIGZ1bmN0aW9uIHRvIHdhaXQgZm9yIFBTUCBCTCBhdmFpbGFiaWxpdHkK
CnJlZHVjZWQgZHVwbGljYXRlIGNvZGUKCmluY3JlYXNlZCB3YWl0IHRpbWUgZm9yIFBTUCBCTCBy
ZWFkaW5lc3MKCkNoYW5nZS1JZDogSTIzZWMyNjEzMzAwMmFiYTA2NWE5NzEzZDY5YjYxN2Y0NmIw
ODY2OTQKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jIHwgNDMgKysrKysr
KysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAx
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9w
c3BfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCmluZGV4
IGM2NmNhOGNjMmViZC4uYTdmYjYxMTNkNzVjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9w
c3BfdjExXzAuYwpAQCAtMjMzLDYgKzIzMywzMCBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9pbml0
X21pY3JvY29kZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAlyZXR1cm4gZXJyOwogfQogCitp
bnQgcHNwX3YxMV8wX3dhaXRfZm9yX2Jvb3Rsb2FkZXIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
Cit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7CisKKwlpbnQgcmV0
OworCWludCByZXRyeV9sb29wOworCisJZm9yIChyZXRyeV9sb29wID0gMDsgcmV0cnlfbG9vcCA8
IDEwOyByZXRyeV9sb29wKyspCisJeworCQkvKiBXYWl0IGZvciBib290bG9hZGVyIHRvIHNpZ25p
ZnkgdGhhdCBpcworCQkgICAgcmVhZHkgaGF2aW5nIGJpdCAzMSBvZiBDMlBNU0dfMzUgc2V0IHRv
IDEgKi8KKwkJcmV0ID0gcHNwX3dhaXRfZm9yKHBzcCwKKwkJCQkgICBTT0MxNV9SRUdfT0ZGU0VU
KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR18zNSksCisJCQkJICAgMHg4MDAwMDAwMCwKKwkJCQkg
ICAweDgwMDAwMDAwLAorCQkJCSAgIGZhbHNlKTsKKworCQlpZiAocmV0ID09IDApCisJCQlyZXR1
cm4gMDsKKwl9CisKKwlyZXR1cm4gcmV0OworfQorCiBzdGF0aWMgYm9vbCBwc3BfdjExXzBfaXNf
c29zX2FsaXZlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gcHNwLT5hZGV2OwpAQCAtMjU4LDkgKzI4Miw3IEBAIHN0YXRpYyBpbnQgcHNw
X3YxMV8wX2Jvb3Rsb2FkZXJfbG9hZF9rZGIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJCXJl
dHVybiAwOwogCX0KIAotCS8qIFdhaXQgZm9yIGJvb3Rsb2FkZXIgdG8gc2lnbmlmeSB0aGF0IGlz
IHJlYWR5IGhhdmluZyBiaXQgMzEgb2YgQzJQTVNHXzM1IHNldCB0byAxICovCi0JcmV0ID0gcHNw
X3dhaXRfZm9yKHBzcCwgU09DMTVfUkVHX09GRlNFVChNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0df
MzUpLAotCQkJICAgMHg4MDAwMDAwMCwgMHg4MDAwMDAwMCwgZmFsc2UpOworCXJldCA9IHBzcF92
MTFfMF93YWl0X2Zvcl9ib290bG9hZGVyKHBzcCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsK
IApAQCAtMjc2LDkgKzI5OCw3IEBAIHN0YXRpYyBpbnQgcHNwX3YxMV8wX2Jvb3Rsb2FkZXJfbG9h
ZF9rZGIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJV1JFRzMyX1NPQzE1KE1QMCwgMCwgbW1N
UDBfU01OX0MyUE1TR18zNSwKIAkgICAgICAgcHNwX2dmeGRydl9jb21tYW5kX3JlZyk7CiAKLQkv
KiBXYWl0IGZvciBib290bG9hZGVyIHRvIHNpZ25pZnkgdGhhdCBpcyByZWFkeSBoYXZpbmcgIGJp
dCAzMSBvZiBDMlBNU0dfMzUgc2V0IHRvIDEqLwotCXJldCA9IHBzcF93YWl0X2Zvcihwc3AsIFNP
QzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzM1KSwKLQkJCSAgIDB4ODAw
MDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsKKwlyZXQgPSBwc3BfdjExXzBfd2FpdF9mb3JfYm9v
dGxvYWRlcihwc3ApOwogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTI5OCw5ICszMTgsNyBAQCBzdGF0
aWMgaW50IHBzcF92MTFfMF9ib290bG9hZGVyX2xvYWRfc3lzZHJ2KHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogCQlyZXR1cm4gMDsKIAl9CiAKLQkvKiBXYWl0IGZvciBib290bG9hZGVyIHRvIHNp
Z25pZnkgdGhhdCBpcyByZWFkeSBoYXZpbmcgYml0IDMxIG9mIEMyUE1TR18zNSBzZXQgdG8gMSAq
LwotCXJldCA9IHBzcF93YWl0X2Zvcihwc3AsIFNPQzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1Q
MF9TTU5fQzJQTVNHXzM1KSwKLQkJCSAgIDB4ODAwMDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsK
KwlyZXQgPSBwc3BfdjExXzBfd2FpdF9mb3JfYm9vdGxvYWRlcihwc3ApOwogCWlmIChyZXQpCiAJ
CXJldHVybiByZXQ7CiAKQEAgLTMxOSw4ICszMzcsNyBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9i
b290bG9hZGVyX2xvYWRfc3lzZHJ2KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCS8qIHRoZXJl
IG1pZ2h0IGJlIGhhbmRzaGFrZSBpc3N1ZSB3aXRoIGhhcmR3YXJlIHdoaWNoIG5lZWRzIGRlbGF5
ICovCiAJbWRlbGF5KDIwKTsKIAotCXJldCA9IHBzcF93YWl0X2Zvcihwc3AsIFNPQzE1X1JFR19P
RkZTRVQoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzM1KSwKLQkJCSAgIDB4ODAwMDAwMDAsIDB4
ODAwMDAwMDAsIGZhbHNlKTsKKwlyZXQgPSBwc3BfdjExXzBfd2FpdF9mb3JfYm9vdGxvYWRlcihw
c3ApOwogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTMzNyw5ICszNTQsNyBAQCBzdGF0aWMgaW50IHBz
cF92MTFfMF9ib290bG9hZGVyX2xvYWRfc29zKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCWlm
IChwc3BfdjExXzBfaXNfc29zX2FsaXZlKHBzcCkpCiAJCXJldHVybiAwOwogCi0JLyogV2FpdCBm
b3IgYm9vdGxvYWRlciB0byBzaWduaWZ5IHRoYXQgaXMgcmVhZHkgaGF2aW5nIGJpdCAzMSBvZiBD
MlBNU0dfMzUgc2V0IHRvIDEgKi8KLQlyZXQgPSBwc3Bfd2FpdF9mb3IocHNwLCBTT0MxNV9SRUdf
T0ZGU0VUKE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR18zNSksCi0JCQkgICAweDgwMDAwMDAwLCAw
eDgwMDAwMDAwLCBmYWxzZSk7CisJcmV0ID0gcHNwX3YxMV8wX3dhaXRfZm9yX2Jvb3Rsb2FkZXIo
cHNwKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCi0tIAoyLjE3LjEKCg==

--_004_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB36632C11B62C60C12B5342F9FB230MN2PR12MB3663namp_--
