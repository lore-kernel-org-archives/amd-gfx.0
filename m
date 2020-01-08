Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC5C00523
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 06:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF6E2075D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 06:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sFkWxaEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF6E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3896E179;
	Wed,  8 Jan 2020 06:43:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0D66E179
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 06:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOdVuAb/n9uv3o9IzjZpA7vt/BhE6JNLQE5dTmqYuzDF73Lj8CsqwW2jHdY2Q4vYjxNZoczAuOKWoubiy12mvtNxDWwda9a0jXF+oGMhVL0aur1VCJMET1p3OPF2O5S06FETeLa+mUQWZRITVqQmjEyDjnhGsgWaKMCqJL3DLp7YTAgyEGp/nwVtac/KCx8MfJInJoTyoHDAmfVu2JXxonCVTp42+dBBSXwKQ5hwHrRYpDguUjIjuLN9jc6cVmMlYCMDXlJ4hRbZ3Pt4fGpAhlC2gA0gm3CBsuimaF0hgqxpmXgezCfnKBv8c6t8dkfxkAuKXUDkMerkilJZLpdX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxSWNd5aGKJBQKZ0oKQ5LYPhcDbmc3FXz8QO8zT6gFw=;
 b=NlpwTOoBPE0BGZxVIbTB9AvtlKmNjnWTb2Rv4Q02fdiuOu7lkh2c0mm8Ov1ADBRGg+QrTMFP3VZer5+bKB4OLUsEIrw6ircS2+qLEdRqqzzMHD6IoqYdOaPrwqJj22XGnbtct4rGkqAufeOWJRYVZKgS/ePfunhBCPz8Ye9ZB5dvd46dLj1Ks8ywIpCoyXY2jdt/nODN2K6bLdV/pZkLBAr8E7ZhM+o0J+LkcYZmbfUG6wOs1k4BEgOPzczlv26+JLlFGqzBVdFXU7lHLi+K+cnLAa0WxLV8nhR9e32DpnmMH/jSjx2zzS5xDwv8gMR0CqenblM1zcXOsFmVGFDyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxSWNd5aGKJBQKZ0oKQ5LYPhcDbmc3FXz8QO8zT6gFw=;
 b=sFkWxaEbQvCAk/idbf9u7qfbFNMzEpGYJQQD6Z08UABAI2oPczspaez13J/3VFItK9ItdzUFQpUVvhWBpxdQXTsenQrF2zKZhYdwx+WfQoGhjZdGW0iTT8XLVMeie6d6A/U+23FInTsLUEPQQtpYD5KYDAnmcNVy9JPr6gRQdBw=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3295.namprd12.prod.outlook.com (20.179.81.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Wed, 8 Jan 2020 06:43:12 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 06:43:12 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+SgABWBSwAADS56AAAUGscgAtVQGg
Date: Wed, 8 Jan 2020 06:43:12 +0000
Message-ID: <MN2PR12MB366352CB4EED6A5601A89FAAFB3E0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <BYAPR12MB280600880BC934A9404B7A0EF13F0@BYAPR12MB2806.namprd12.prod.outlook.com>,
 <MN2PR12MB3663DB0BC9273A8F918876CEFB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
 <MN2PR12MB305412F23D9F0CA1E1D18202B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB305412F23D9F0CA1E1D18202B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Tao.Zhou1@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-07T09:08:46.148Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-08T06:43:07Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Standard
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9d690e2c-da18-4f7e-8ef0-00005814a4f1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 889a6967-d6e0-4bbf-dd60-08d794060809
x-ms-traffictypediagnostic: MN2PR12MB3295:|MN2PR12MB3295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB329524CD13AD7D59DA977E11FB3E0@MN2PR12MB3295.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(8936002)(66946007)(66556008)(81166006)(86362001)(81156014)(52536014)(33656002)(64756008)(55016002)(66476007)(66446008)(478600001)(9686003)(186003)(15650500001)(6506007)(71200400001)(26005)(76116006)(53546011)(7696005)(110136005)(316002)(5660300002)(8676002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3295;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cu56/QiNJtzncgIhhBsOKm/EreWI0k8relSOdMT7H3pk08s15xV48W0MO2M+EvsbRhAnVUCdSr9jMt8jE4CV1Y91eLfZQnmPyinG5yQVfp85nBOB4H/wDB+McRd8ufPSlpzunOQySdoQtABF1clvgjeXzmJAgAU0jyGktpT+R1noEbSRX6D/5QT2SDPLCvoaP3cFfpUyrCeIBSFAyGc+GLnOMCFCh3tD0SeCuoBNWCTVXUsDBYgkPXvzLH8Ty3qd2X57a/ouAQ9FH7jNUJxqu7fPsxJkjO2yINHilIp8lN1t2bzqdwHq3om9JDxPSuWDSHtScbz0VC+QFoe1OxkktdbMjnpSGZ1fIMlq4VPzu7hdPpXpKaB/kV0PTNla8ZuzQhauQTlDQKoVDE9LnAe+4LacJkO4cjgmb8U1JK4wHSsXGouVmBfr703vs9mwUuUm
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889a6967-d6e0-4bbf-dd60-08d794060809
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 06:43:12.0224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByXXVkerIT1oY2XLeQO+aAnyf5ZjoO6B553c3ykSERaSRY3pd9P8ATZpGVGvOFeqEK2dIffMsocl1QOne12r9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3295
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
Content-Type: multipart/mixed; boundary="===============0129940884=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0129940884==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366352CB4EED6A5601A89FAAFB3E0MN2PR12MB3663namp_"

--_000_MN2PR12MB366352CB4EED6A5601A89FAAFB3E0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

You are right @Zhou1, Tao<mailto:Tao.Zhou1@amd.com>,

I am preparing a separate patch to have a dedicated function to get umc cha=
nnel idx

Thank you,
John Clements

From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 7, 2020 5:09 PM
To: Clements, John <John.Clements@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: updated UMC error address record with corr=
ect channel index

uint32_t channel_index =3D adev->umc.channel_idx_tbl[umc_inst * adev->umc.c=
hannel_inst_num + ch_inst];

The code is too long, it can be separated into two lines.

With that fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Clements, John <John.Clements@amd.com=
<mailto:John.Clements@amd.com>>
Sent: Tuesday, January 7, 2020 4:31 PM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
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

--_000_MN2PR12MB366352CB4EED6A5601A89FAAFB3E0MN2PR12MB3663namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal0, li.xmsonormal0, div.xmsonormal0
	{mso-style-name:x_msonormal0;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheader4d0fcdd7, li.xmsipheader4d0fcdd7, div.xmsipheader4d0fcdd7
	{mso-style-name:x_msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheader87abd423, li.xmsipheader87abd423, div.xmsipheader87abd423
	{mso-style-name:x_msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.xmsohyperlink
	{mso-style-name:x_msohyperlink;
	color:#0563C1;
	text-decoration:underline;}
span.xmsohyperlinkfollowed
	{mso-style-name:x_msohyperlinkfollowed;
	color:#954F72;
	text-decoration:underline;}
span.xemailstyle20
	{mso-style-name:x_emailstyle20;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.xemailstyle21
	{mso-style-name:x_emailstyle21;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.xemailstyle22
	{mso-style-name:x_emailstyle22;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle28
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
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
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">You are right <a id=3D"OWAAM31A1B8D444BE433F83A8B638=
32443644" href=3D"mailto:Tao.Zhou1@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Zhou1, Tao</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am preparing a separate patch to have a dedicated =
function to get umc channel idx<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <b=
r>
<b>Sent:</b> Tuesday, January 7, 2020 5:09 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; Chen, Guchun &lt;G=
uchun.Chen@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">uint32_=
t channel_index =3D adev-&gt;umc.channel_idx_tbl[umc_inst * adev-&gt;umc.ch=
annel_inst_num &#43; ch_inst];<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The cod=
e is too long, it can be separated into two lines.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">With th=
at fixed, the patch is:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1@amd.com">tao.zhou1@amd.com</=
a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John.Clements=
@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 7, 2020 4:31 PM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: updated UMC error address record wi=
th correct channel index</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt"=
><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;c=
olor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Hello GuChun/Tao,<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Thank you for your feedback, I have implemented bot=
h of your changes.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Thank you,<o:p></o:p></p>
<p class=3D"xmsonormal">John Clements<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Chen, Guchun &lt;<a href=3D"mailto:Guc=
hun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;
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
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt"=
><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;c=
olor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">If we have to improve the macro definition for repe=
titive loops, I assume we can merge the two defines into one, like:<o:p></o=
:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">#define LOOP_UMC_CH_INST(umc_inst) for ((umc_inst) =
=3D 0; (umc_inst) &lt; adev-&gt;umc.umc_inst##_num; (umc_inst)&#43;&#43;)<o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Then when we call the double loop, it can be done l=
ike:<o:p></o:p></p>
<p class=3D"xmsonormal">LOOP_UMC_CH_INST(umc_inst)<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_CH_INST(channel_inst) {&#8230;<o:p></o=
:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Next we should name the macro more friendly.<o:p></=
o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:J=
ohn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, January 7, 2020 3:28 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; dl.srdc_lnx_ras &lt;<a href=3D"mailto:dl.srdc_lnx_ras@a=
md.com">dl.srdc_lnx_ras@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: updated UMC error address record with c=
orrect channel index<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt"=
><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;c=
olor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Resolved issue with inputting an incorrect UMC chan=
nel index into the UMC error address record.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Defined macros for repetitive for loops<o:p></o:p><=
/p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Thank you,<o:p></o:p></p>
<p class=3D"xmsonormal">John Clements<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB366352CB4EED6A5601A89FAAFB3E0MN2PR12MB3663namp_--

--===============0129940884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0129940884==--
