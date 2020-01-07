Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A46AC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 05:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4912073D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 05:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yq9jsx/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4912073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B3B6E245;
	Tue,  7 Jan 2020 05:58:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510C66E245
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 05:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt00/Lnbnc0a6ruui1vXpxHSnLdHjBfZM8F4VGqmHM3lOk+hGHvDSVMIzEMrPPSNmiVWoA3J5Z+TWt0AniOVeHTPadpHfCczz7hJTnw1CgBpA9mD/7Tbv79eXRm4vhTozkNuo9ZcGKqGGFqdVozA4F+NHEtrc64V3x9JSLuR0o9dUFDxT3lAhQOSH3NnRqoOVCBPdVuC+Wbc5OgA2y9UXokIzYus+qKwz2SUlkMIzu03Gk5qHySebql0Qp2ne9LtqiREd/9j1TBzx1Q3lDnF5OG5Z3oRBxPAi6pPp+qJMeAE31SEMruEx5E1tK7wozKLiOwDFsbU78GSvZdgMGOACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWJIEFfJXd/Zho2DNL1vOaI0Lz7lrVr8Y7vZdQEB6Gw=;
 b=WmD1yZEjS7MsnU6mTiFioqfdsIhpwro3LjC/dTNFswyd/qpcqnWJNDxq2z5MWhMTB12hYaIgFPtuCc8PPZiTT2vOXbJs86wHsoVGLKqJhCOMjCvDxdmLJ/803at96rqM/zHdpGpCAxKdxI5dqPSXUkg/mkUnHba5UZEz7gGfYmgkaW6eIf+IJByvfDeBA3ZaysOVzRMeYy5c8rBH/7ABqqObj/PQ1pCAc1ltqj2ewKnHIeqYT2I7AGjF9svdJUllwEiFNkr6LUxPiMAgbL2d0EpvQshG5fswCRHU8m7K6jRI4XGl3NqghwT4sziGxMwEDeODVFBjrVorhCTxMXelvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWJIEFfJXd/Zho2DNL1vOaI0Lz7lrVr8Y7vZdQEB6Gw=;
 b=yq9jsx/yCdke6AAA3hUbdpZ0+dCxV+N0lEoPpx1uDroD08QcPoeANMmI1PnH+yhC082IXcniw+/jnKBx1PP9OLITPomTbehxVmyS3FbYBAE/RSJ6avYuu6FkUtrUr9HFDhRD/b4VXXQH3NE6jbgYJlJhJkGE2u61LGM8jRoehwU=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB3888.namprd12.prod.outlook.com (10.255.236.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 7 Jan 2020 05:58:47 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::fd1e:ce54:2a7d:b849%5]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 05:58:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Index: AdXFDfX6UjCjdKdbSWODjaMeQHS5aAAEQPTg
Date: Tue, 7 Jan 2020 05:58:46 +0000
Message-ID: <MN2PR12MB30543EF3A53F4F76F4F5F673B03F0@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <MN2PR12MB36636EC5042C85407DB96379FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB36636EC5042C85407DB96379FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-07T03:53:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22664f26-4177-45a5-a8d6-0000728869ae;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-07T05:58:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 912050b8-8df0-4ddb-a119-0000d35172db
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53a5e455-601c-42e3-5c54-08d79336a904
x-ms-traffictypediagnostic: MN2PR12MB3888:|MN2PR12MB3888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3888A5F22182C94142330DBEB03F0@MN2PR12MB3888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(2906002)(55016002)(26005)(8676002)(81156014)(8936002)(7696005)(81166006)(9686003)(33656002)(53546011)(6506007)(86362001)(110136005)(6636002)(66476007)(66556008)(64756008)(66446008)(76116006)(52536014)(4744005)(316002)(186003)(71200400001)(478600001)(66946007)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3888;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ekOEe6koq97+AFsWbcB5sddkj+tkZaQAdjI2Txn66J0V8rZxQrmJebUKxc0A13/AXvxDP/ZqHdxS2Ad1N9ctchgwGcsx87VtEA9xOXJ7F+QgrdjSPwoD2vBFA72RYAHYnNARZbspfhVdWqGWNlkqFGHoHO1oR6qmXUXOm4zo2HquXm2U3fqV5CexkB/hwvXhvRr7OflBRzywHrCK3FKRI2EutrSkJ76Fhy2vdGbR1PxWVlYDy9lJxLvKgxexJy1Jsd8Kn611n91hxM3Tqxr1bvBs4di6COxaBLHUYefzWX8NSRgSa1RDjqz2pc2XZykxCjAYGr6aklSk+ySqVzsLfZwasIwzU44B6GZxbjTIfT4Avs9/UAIiipmrIyUukQnDdONQl7g7fdqbcdzlYuLLVrdnir2dwTipeTsbJslyhR3XA3BpYAuqyBFzSlTIUX8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a5e455-601c-42e3-5c54-08d79336a904
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 05:58:46.7487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzwGw7F1JEB4jCsuE6iC5uMOwZoXSUZ1YWrIgj4j8SbF+RSWdsbDI+JsKa+kpOlV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3888
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
Content-Type: multipart/mixed; boundary="===============1534807618=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1534807618==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30543EF3A53F4F76F4F5F673B03F0MN2PR12MB3054namp_"

--_000_MN2PR12MB30543EF3A53F4F76F4F5F673B03F0MN2PR12MB3054namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPG1haWx0bzp0YW8uemhvdTFA
YW1kLmNvbT4+DQoNCkJUVywgYXJlIHlvdSBzdXJlIHJlcGxhY2luZyBSUkVHMzIvV1JFRzMyIHdp
dGggUlJFRzMyL1dSRUczMl9QQ0lFIGlzIGFsc28gbmVjZXNzYXJ5IHRvIGZpeCB0aGUgYnVnPw0K
DQpSZWdhcmRzLA0KVGFvDQoNCkZyb206IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFt
ZC5jb20+DQpTZW50OiAyMDIwxOox1MI3yNUgMTE6NTQNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgZGwuc3JkY19sbnhfcmFzIDxkbC5zcmRjX2xueF9yYXNAYW1kLmNvbT4NClN1
YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVzb2x2ZWQgYnVnIGluIFVNQyBSQVMgQ0UgcXVl
cnkNCg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQoNClN1Ym1pdHRpbmcgcGF0Y2ggdG8gYWNjZXNzIENFIHJlZ2lzdGVycyB2aWEgU01OIGFu
ZCBkaXNhYmxlIFVNQyBpbmRleGluZyBtb2RlLg0KDQpUaGFuayB5b3UsDQpKb2huIENsZW1lbnRz
DQo=

--_000_MN2PR12MB30543EF3A53F4F76F4F5F673B03F0MN2PR12MB3054namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:=CB=CE=
=CC=E5"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou=
1@amd.com">tao.zhou1@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BTW, are you sure replacing RREG32/WREG32 with RREG3=
2/WREG32_PCIE is also necessary to fix the bug?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Tao<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> 2020<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=
=C4=EA</span>1<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=D4=
=C2</span>7<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=C8=D5</=
span> 11:54<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; dl.srdc_lnx_ras &lt;dl.srdc_lnx_r=
as@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query<o:p></=
o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to access CE registers via SMN and =
disable UMC indexing mode.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30543EF3A53F4F76F4F5F673B03F0MN2PR12MB3054namp_--

--===============1534807618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1534807618==--
