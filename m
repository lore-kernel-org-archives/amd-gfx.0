Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D55C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 12:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258722068E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 12:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258722068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C840D89C05;
	Wed, 27 Nov 2019 12:14:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680050.outbound.protection.outlook.com [40.107.68.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494AC89C05
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 12:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCz7eDR5C/merjr7z6dY+4ja7qNuarqkKiSvp5xnp/Hb0Ga+ZQMeMP5zkDsoXrNCxQJW2IjrDvLNR8P7B1Ixdr54DntwbTHXTkCdRlOkTSBR/pLYX4sM/0uFHb4oI5lB8vfYsp3gioZh6j8gZNpDpuDAP7PMEe4RjJwHpEx/ESZeNpEOOw8WO631DKUe4gYm9splGWAVdiRMjCMm6oCrkPz/wvtpppRCmSyCfPyD/T5Rf5RRhdy+semsnwI+SFv0H9fECtr5mhabPeyTc6NS41j9TgUBS99KC9V8EnUTrnNBmsbQGZNiGTp45RERxAHydp93q+UIO0DvzejFFl/5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss+MR9JoRgNreYXG6vQiTX8f97dO0Z1EeaGj4W31HkY=;
 b=XCEoxY/jEtta2yxYyBaQnYN5dsoLrgxWoDBPgNZKjAQ7LO3Dt/NyNEOWJSAT3G1zeclAYf1X9MZj0BbSNUr61KPkpSv8TUL+jw+fcwJwsbcVL61mKQzsViOy5fVYliLq6pRM/1Edx8cwgaIx5+F//kvd8LDsBnEcNCUJlnSDzQgPbMEPWjgcgA6lMtQfmTdFettz2IEYSuNDtji2CDmR31x/lni12KQmBRiKRk+Q210W4i9E/58dUllx1DB3alzTJiTDZb+um4nCMADDmL8ZEFiUY49gm+Zh7uJm5FJETUSpt2MsCZsha/CUWL0MCP7v1iOGeYD3wNHLDfVtBO/J6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3936.namprd12.prod.outlook.com (10.255.238.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.24; Wed, 27 Nov 2019 12:14:04 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 12:14:02 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Thread-Topic: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Thread-Index: AQHVpQNEhgaUyPJRWUGLrnUUz2V006ee64OAgAACDrA=
Date: Wed, 27 Nov 2019 12:14:02 +0000
Message-ID:
 <MN2PR12MB4285A41D146EDAAE4918FB78F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-4-git-send-email-le.ma@amd.com>
 <DM5PR12MB14184CF08E965BAF369F4249FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB14184CF08E965BAF369F4249FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T12:04:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bba7b64e-a35b-4685-8bb6-00007dff43d1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b4d42bf-5953-4954-1fd0-08d773334a53
x-ms-traffictypediagnostic: MN2PR12MB3936:|MN2PR12MB3936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3936A48F4D32E68D1F108102F6440@MN2PR12MB3936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(13464003)(189003)(199004)(33656002)(4326008)(81156014)(66556008)(2501003)(8936002)(81166006)(6246003)(236005)(14454004)(64756008)(446003)(6436002)(8676002)(66476007)(66446008)(478600001)(2906002)(66946007)(76116006)(5660300002)(52536014)(99286004)(7736002)(86362001)(74316002)(110136005)(54896002)(9686003)(316002)(54906003)(256004)(66066001)(186003)(229853002)(11346002)(6306002)(26005)(53546011)(6506007)(102836004)(55016002)(71190400001)(71200400001)(7696005)(3846002)(25786009)(76176011)(6116002)(790700001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3936;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rb09/p+oyDI6iiubDTMBpfnTKaM6Q1uILNZ6Ci21njLkoaFLU+lj9YXln9uKqLRGhvwqoCggrb4FhYb4keRz1T79U81GS52lu6+EkJ7crEqz21SzomZgwPl2N2y0MEh35DDi+9YbCSqiLbE9rYaEqsD1+8cZ4P5rQ4CU/hAq64L2rZ82MD5bKjWxuosssoroh5txwqgmUyfmyBN9i3qQvo74hapE/SA2A/senXOH+a1apqLM7RvyshONOdJ9qYV6VckqRiextUKNPLQpLt0tM09TkiFLWgrbAWq/5ZpP7RKSGbM/fuKINdRLKk/6X0MS6O2CeOFod39cQghXavKtJ/zSqfrX5qmabLVaW6oH0QpzdiePIMnc49s56febJfBfRWRTZlLPnKNqaBYXI5LrxSZvXZ2ppicnSsIUo2tcCEHz5GvQtfHG6ZG/FDdOT0BW
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4d42bf-5953-4954-1fd0-08d773334a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 12:14:02.2358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+S1N1S+1dUoUZDTsMw64IZon4MfrOJAVoRo1qnLtkTpSHtUNp7R/sOmZh4xjCZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss+MR9JoRgNreYXG6vQiTX8f97dO0Z1EeaGj4W31HkY=;
 b=r/N90dbsxF8kgdDbwpO2K3b4XCN5G4bCLv2aGeq0DH681xEy0MptnABM1E2I7yn5bKVYOFzOYLB/WJHamyLSSzrGw9DoS013WvUIj2E4pKN4QOfCZXC19fviW0SifReQMZly3IYlguXqmD0bT23E/3VLV5nyaxKCE6aTlgd4eIA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============0521228470=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127121402.J7WlLEg6CvlVEy6f9VLMhPeG70fQ7RkIWCJvr9e7DyQ@z>

--===============0521228470==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_"

--_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable



From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, November 27, 2019 8:04 PM
To: Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Dennis <Dennis.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>=
; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in=
 baco entry/exit helper


Please check my comments inline



Regards,
Hawking



-----Original Message-----
From: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>
Sent: 2019=1B$BG/=1B(B11=1B$B7n=1B(B27=1B$BF|=1B(B 17:15
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Dennis <Dennis.Li@amd.com=
<mailto:Dennis.Li@amd.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<=
mailto:Alexander.Deucher@amd.com>>; Ma, Le <Le.Ma@amd.com<mailto:Le.Ma@amd.=
com>>
Subject: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in bac=
o entry/exit helper



This operation is needed when baco entry/exit for ras recovery



Change-Id: I535c7231693f3138a8e3d5acd55672e2ac68232f

Signed-off-by: Le Ma <le.ma@amd.com<mailto:le.ma@amd.com>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++-------

1 file changed, 12 insertions(+), 7 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c

index b1408c5..bd387bb 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

@@ -4308,10 +4308,14 @@ static void amdgpu_device_get_pcie_info(struct amdg=
pu_device *adev)  int amdgpu_device_baco_enter(struct drm_device *dev)  {

               struct amdgpu_device *adev =3D dev->dev_private;

+             struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);



                if (!amdgpu_device_supports_baco(adev->ddev))

                               return -ENOTSUPP;



+             if (ras && ras->supported)

+                             adev->nbio.funcs->enable_doorbell_interrupt(a=
dev, false);

+

               if (is_support_sw_smu(adev)) {

                               struct smu_context *smu =3D &adev->smu;

                               int ret;

@@ -4319,8 +4323,6 @@ int amdgpu_device_baco_enter(struct drm_device *dev)

                               ret =3D smu_baco_enter(smu);

                               if (ret)

                                               return ret;

-

-                              return 0;

               } else {

                               void *pp_handle =3D adev->powerplay.pp_handl=
e;

                               const struct amd_pm_funcs *pp_funcs =3D adev=
->powerplay.pp_funcs; @@ -4331,14 +4333,15 @@ int amdgpu_device_baco_enter(=
struct drm_device *dev)

                               /* enter BACO state */

                               if (pp_funcs->set_asic_baco_state(pp_handle,=
 1))

                                               return -EIO;

-

-                              return 0;

               }

+

+             return 0;

}



 int amdgpu_device_baco_exit(struct drm_device *dev)  {

               struct amdgpu_device *adev =3D dev->dev_private;

+             struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);



                if (!amdgpu_device_supports_baco(adev->ddev))

                               return -ENOTSUPP;

@@ -4351,7 +4354,6 @@ int amdgpu_device_baco_exit(struct drm_device *dev)

                               if (ret)

                                               return ret;



-                              return 0;

               } else {

                               void *pp_handle =3D adev->powerplay.pp_handl=
e;

                               const struct amd_pm_funcs *pp_funcs =3D adev=
->powerplay.pp_funcs; @@ -4362,7 +4364,10 @@ int amdgpu_device_baco_exit(st=
ruct drm_device *dev)

                               /* exit BACO state */

                               if (pp_funcs->set_asic_baco_state(pp_handle,=
 0))

                                               return -EIO;

-

-                              return 0;

               }

+

+             if (ras && ras->supported)

+                             adev->nbio.funcs->enable_doorbell_interrupt(a=
dev, false);

+





[Hawking] Shouldn't be enabled doorbell interrupt after exit baco? Or do I =
miss something?



[Le]: Yes, the argument should be true. I made a typo here.



+             return 0;

}

--

2.7.4



--_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
@font-face
	{font-family:"\@SimSun";
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.co=
m&gt; <br>
<b>Sent:</b> Wednesday, November 27, 2019 8:04 PM<br>
<b>To:</b> Ma, Le &lt;Le.Ma@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell inter=
rupt in baco entry/exit helper<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:SimSun">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText">Please check my comments inline<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Le Ma &lt;<a href=3D"mailto:le.ma@amd.com">le.ma@amd.com</a>&gt; <br>
Sent: 2019<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=1B$BG/=1B(B<=
/span>11<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=1B$B7n=1B(B</s=
pan>27<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=1B$BF|=1B(B</spa=
n> 17:15<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com"=
>Guchun.Chen@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@am=
d.com">Tao.Zhou1@amd.com</a>&gt;; Li, Dennis &lt;<a href=3D"mailto:Dennis.L=
i@amd.com">Dennis.Li@amd.com</a>&gt;;
 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexan=
der.Deucher@amd.com</a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com">Le=
.Ma@amd.com</a>&gt;<br>
Subject: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in bac=
o entry/exit helper<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">This operation is needed when baco entry/exit for=
 ras recovery<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: I535c7231693f3138a8e3d5acd55672e2ac682=
32f<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma@amd.co=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<o:p></o:=
p></p>
<p class=3D"MsoPlainText">1 file changed, 12 insertions(&#43;), 7 deletions=
(-)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index b1408c5..bd387bb 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4308,10 &#43;4308,14 @@ static void amdgpu_de=
vice_get_pcie_info(struct amdgpu_device *adev)&nbsp; int amdgpu_device_baco=
_enter(struct drm_device *dev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;=
dev_private;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_cont=
ext(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(=
adev-&gt;ddev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<=
o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; ras-&gt;supported)<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;e=
nable_doorbell_interrupt(adev, false);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context=
 *smu =3D &amp;adev-&gt;smu;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p=
></p>
<p class=3D"MsoPlainText">@@ -4319,8 &#43;4323,6 @@ int amdgpu_device_baco_=
enter(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_baco_e=
nter(smu);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =
=3D adev-&gt;powerplay.pp_handle;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_p=
m_funcs *pp_funcs =3D adev-&gt;powerplay.pp_funcs; @@ -4331,14 &#43;4333,15=
 @@ int amdgpu_device_baco_enter(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enter BACO stat=
e */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;s=
et_asic_baco_state(pp_handle, 1))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EIO;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;int amdgpu_device_baco_exit(struct drm_devi=
ce *dev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;=
dev_private;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_cont=
ext(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(=
adev-&gt;ddev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4351,7 &#43;4354,6 @@ int amdgpu_device_baco_=
exit(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =
=3D adev-&gt;powerplay.pp_handle;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_p=
m_funcs *pp_funcs =3D adev-&gt;powerplay.pp_funcs; @@ -4362,7 &#43;4364,10 =
@@ int amdgpu_device_baco_exit(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* exit BACO state=
 */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;s=
et_asic_baco_state(pp_handle, 0))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EIO;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; ras-&gt;supported)<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;e=
nable_doorbell_interrupt(adev, false);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:#2F5597">[Hawking] Shouldn't=
 be enabled doorbell interrupt after exit baco? Or do I miss something?<o:p=
></o:p></span></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[Le]: Yes, the argument should be true. I made a =
typo here.
<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_--

--===============0521228470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0521228470==--
