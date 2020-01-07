Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7CBC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB59C20715
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wv7LMsYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB59C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6611A6E7E6;
	Tue,  7 Jan 2020 08:56:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770080.outbound.protection.outlook.com [40.107.77.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E53E6E7E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 08:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whecmk/L1vNjpfbujR6aJN+ujrJMU+cuJ3KmjcQhMLV27zG1p357RWrst1XEjP/loPlrnbNuG5wKvqD16AXbpO8QrU+EREsFCcOIC9ll8g78clEtkW+ziAweXPWFp0dpbaJjpiQ26ZIo82JgDs1E6TQIO5RAOWahLRM8KFJSSWXyAONi9bHNh7OLn64vKFMD6M8rkmG22nAPWhUh1s3r2aNXEEkMhH8A5H6nAtLU2xMXUHnmY7xFCUCnhfZu49v3geejW4Zc8vBB3wp4oQYdmW5estdFpKTmyXdyCk6CAFN3kojwJXyhlZz/aTKUhjOCdUpLozkgzxKmt7NBJqbHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSALuTIehybJa/0H6suVN9CEYigU/DCwIN250SdrLXc=;
 b=Z6FQfCAkihoQgPUjRIJHSqjLQdkiWrJzk3bP/p8I77GHMPTKtoo4Lza4aTI3+WWKQTJurdVFKFwUCN2smQ94EW7ph7/9cuqPSfGqG62MenIr8wkmQtJwI/KYZmlMJplMZD9uNOSV0suRU3b+V9LUfvzorVqr8al+0NHGMmzDqNPA5seLSoHB9fzSHkO418GxhifbRFcWEOpbqJc4Oa4HeXMRO1FzV/ML74HOR/MQPIzcem5LfkPI8Feb42b2V4ju8HEDauzJQ45jIHZchCC6RCazAv5YtmPl6iK1PjDyfCP7NlNT5OtluJssAsa/YtUayjDIVknRflWBjfm/dFhPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSALuTIehybJa/0H6suVN9CEYigU/DCwIN250SdrLXc=;
 b=Wv7LMsYuod1/5NFDsLgYbRJzquJCN6wccyiRIfB7kHzVqq3cLPF5RDRvorO+HHg82lglmZmwBV1A14gPowg/wAV/bUDvVmd8VOonYpUHs21I5qLWbrbxDg/otaGxd+4GGhHjMAs2OQRsWKvzC3yMrjW+JcnqEEenuz3pxF8sSkQ=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3191.namprd12.prod.outlook.com (20.179.92.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 08:56:37 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 08:56:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABWBSwAADS56AAAPvkEA==
Date: Tue, 7 Jan 2020 08:56:37 +0000
Message-ID: <BYAPR12MB280673EAF00ACFE541F4AD9DF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <BYAPR12MB280600880BC934A9404B7A0EF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>
 <MN2PR12MB3663DB0BC9273A8F918876CEFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663DB0BC9273A8F918876CEFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-07T08:09:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e4679bea-e3a9-456b-b7d1-0000d1b5ce22;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-07T08:56:35Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5176f59a-2e6c-47e2-a412-00005a48f65c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48e93b77-38f2-44a1-708b-08d7934f811b
x-ms-traffictypediagnostic: BYAPR12MB3191:|BYAPR12MB3191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3191B32A0ADC3A8F0E699349F13F0@BYAPR12MB3191.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(316002)(66446008)(26005)(8936002)(53546011)(6506007)(8676002)(9686003)(110136005)(81156014)(81166006)(15650500001)(55016002)(52536014)(66476007)(33656002)(186003)(478600001)(86362001)(71200400001)(5660300002)(2906002)(76116006)(66556008)(66946007)(7696005)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3191;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDkO8RZNcZmZP2PKTaLPR1095XgFP2pu8KmwENfKiYWtOHgnErTOOi9yAZnuVjGNC2GEzWoJjX1oPUTtMGZ/yA2gjDWkKcV9NMiz6aAf3AbbYa3a5VGBryBS0/iqU4GyZnZkqDjlOrukoSLsZ7omSfWlgS6B2ymndbkFjyzvajwLC0mMZNyFLREDyjh4iB4FwFfkz/CIy75y2KELKjz/5I2KvjErz7eliSZCzxq+1MwIkHCFco/5soTzCFG/SQlu6EYpOiKTi61BCWiPk7S8N/mzboEy+2mZfxgBJlTorWpliVeKnK/qs9ij6UzXD95wkh70w+6l3ZGoSsLb2RGywgY9L7ShoHfe2KN7KWHnjCL+JPSlXJdiJDYc5VpTNfoP8qma5OTmxi2rHQfEr+g3k28tHD0DhoXFpTDMTnvDpZRjUQh5nNxCFcoN6CYx6i2h
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e93b77-38f2-44a1-708b-08d7934f811b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 08:56:37.2443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfyWYu7VL3Umh6SxNeNlOhyUCRDfcDxWzwgozUpqT+DNwdN7VmQ2CnSFqJ6/qO9J+XmOPmDR8FGHbsThRz5aNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
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
Content-Type: multipart/mixed; boundary="===============0025207775=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0025207775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB280673EAF00ACFE541F4AD9DF13F0BYAPR12MB2806namp_"

--_000_BYAPR12MB280673EAF00ACFE541F4AD9DF13F0BYAPR12MB2806namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>


From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, January 7, 2020 4:32 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with corr=
ect channel index


[AMD Public Use]

Hello GuChun/Tao,

Thank you for your feedback, I have implemented both of your changes.

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, January 7, 2020 4:10 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with corr=
ect channel index


[AMD Public Use]

If we have to improve the macro definition for repetitive loops, I assume w=
e can merge the two defines into one, like:

#define LOOP_UMC_CH_INST(umc_inst) for ((umc_inst) =3D 0; (umc_inst) < adev=
->umc.umc_inst##_num; (umc_inst)++)

Then when we call the double loop, it can be done like:
LOOP_UMC_CH_INST(umc_inst)
              LOOP_UMC_CH_INST(channel_inst) {...

Next we should name the macro more friendly.

Regards,
Guchun

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, January 7, 2020 3:28 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; dl=
.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com<mailto:dl.srdc_lnx_ras@amd.com>>
Subject: [PATCH] drm/amdgpu: updated UMC error address record with correct =
channel index


[AMD Official Use Only - Internal Distribution Only]

Resolved issue with inputting an incorrect UMC channel index into the UMC e=
rror address record.

Defined macros for repetitive for loops

Thank you,
John Clements

--_000_BYAPR12MB280673EAF00ACFE541F4AD9DF13F0BYAPR12MB2806namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
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
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, January 7, 2020 4:32 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello GuChun/Tao,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for your feedback, I have implemented both=
 of your changes.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;<a href=3D"mailto:Guch=
un.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, January 7, 2020 4:10 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If we have to improve the macro definition for repet=
itive loops, I assume we can merge the two defines into one, like:<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#define LOOP_UMC_CH_INST(umc_inst) for ((umc_inst) =
=3D 0; (umc_inst) &lt; adev-&gt;umc.umc_inst##_num; (umc_inst)&#43;&#43;)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Then when we call the double loop, it can be done li=
ke:<o:p></o:p></p>
<p class=3D"MsoNormal">LOOP_UMC_CH_INST(umc_inst)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_CH_INST(channel_inst) {&#8230;<o:p></o:=
p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Next we should name the macro more friendly.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; dl.srdc_lnx_ras &lt;<a href=3D"mailto:dl.srdc_lnx_ras@a=
md.com">dl.srdc_lnx_ras@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: updated UMC error address record with c=
orrect channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Resolved issue with inputting an incorrect UMC chann=
el index into the UMC error address record.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Defined macros for repetitive for loops<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BYAPR12MB280673EAF00ACFE541F4AD9DF13F0BYAPR12MB2806namp_--

--===============0025207775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0025207775==--
