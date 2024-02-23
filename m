Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F787C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 17:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA41E10EC76;
	Fri, 23 Feb 2024 17:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+i3Sy2n";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7D310EC82
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 17:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlyRMUFNCK68onECLr2rjiGUBjxwoWhr991BNq3wa32jKBYxKrEixvX+lOuLQTi/rd2R1a1yGTMK0EcBzjvrI8SwepwngiePCMtUtOIkhvKhy7PZldiJaJOZQ3dLmceUmibWteMaOLAJoRBo234i870Rw5MyETMO+OfqRR7xIeDNCP9HHIUbTw1jtwbL5n6A9//nCmHJP1tYk4nUQz/pKZ9E9UbOoQsOaXU5EUdfa8HFzz/oQsp39AX3oE3gk/AkCz365yV+j+CDSEg91jUD7ZOB3kBVk2wf8Q3+hvuGiRxJIN58ziUCrrbk2vL/JZHVvgIL5/Wz4jwi9r7K2suR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkVvdA2mqQAw46ArYxNBes5NxEIII1TlJzStnzX2C78=;
 b=d7+Rh6rrvHV+rkepYgnmL7HRkEYTHsmmgdjYOJu5YMwL2WE+rrbgTbaGMtRYEChuFj6HORWAt47me3GaekpWg2YaxuXhK2Fw+jnsC/z3q5MfwZ5EcwSY4IyP3QtRxSoQIUKYoLg8JG9v4AabvO3tgouzWCsdxoMzkM3OPx352POwMJXoqVONCra2JQOqY1LKPf/hzmXZdWwnFbPVK4SIZh3ReaDJv77EekxJrnGG9lmq9JmAyxKWODRQxTXYCQr/YzQfB2p28m3f+OsLwHU6fg7M1i7t6mWyVLTj30M7RG+BzqJpX9JcB9gztL3luHsFmJe3r+msYB1KNZmVdMZ26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkVvdA2mqQAw46ArYxNBes5NxEIII1TlJzStnzX2C78=;
 b=T+i3Sy2nTgldZnYE3JW8znpTGpzwe5feOBZ76ydEi0zDzmEALdYm3bumMOGR15ZDzdblAe9G//f5Ww6s6DL13Yvb7rkOxCuuSdtKTfgM2BUc2CUHJ9COiO4j+Dv5qzq06bMn8rO0djUiPMZ38oubCSW+JkRjhYBYgdColz1GyPQ=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 17:11:16 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::b4a6:ef0f:c28b:3d38]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::b4a6:ef0f:c28b:3d38%5]) with mapi id 15.20.7316.016; Fri, 23 Feb 2024
 17:11:16 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV
Thread-Topic: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV
Thread-Index: AQHaPaFkB5CRdgtSXUmW4OYyRvLQJbENlpi9gArkf5A=
Date: Fri, 23 Feb 2024 17:11:16 +0000
Message-ID: <DM4PR12MB5328F1454363BD8694C1E6A8F1552@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
 <20240102173013.5543-2-victorchengchi.lu@amd.com>
 <PH7PR12MB59745A45653A1B10F9C1653AFA4C2@PH7PR12MB5974.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59745A45653A1B10F9C1653AFA4C2@PH7PR12MB5974.namprd12.prod.outlook.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-16T18:49:57.671Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|SJ0PR12MB6712:EE_
x-ms-office365-filtering-correlation-id: 31e0ea61-38b3-4429-f4f8-08dc3492720f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++oTOZmxAQB/t9zjLzvDhyv/olbVA7eXP6q04pGYqKmzoFJBxgt5+goRsDKSG46AGLzhJuBKVZVnOh9Dkc+hJf7j6TASzld+fSbCdbJn8TuPs614j9Ez87vz2ZxPasUmsXDXY5lDtJfgb2AEXFE9Odnoxbn6077NkEIAKD7mq3ryQ51+zBGjgcCihZesdXO30MxiLRyWut01bWroMD+XQTRUSe1vN1rkf1vrBkliBPMBUPp/GJmqzKgsd8dk2RIeXQ8HPbus6xoVIfT3xeJGxoQk7ar43SOvMJ7YJQo5lDjWURUKBHWXZHg6uCgn245x9MukHzuTOs44CVUvlDFGL2Hp2bZs26N7BrUUfFA3g20xplSDznFjpcoXd75TBzrE/QyPI3VEJ04WN/v9krp/bCx50f7CIyTcjVmNQPTTy4xtliZ57vDPSMbK7YSwAKRswjNL36r29DsBJpOAWgXuSe0rV25ucLQUV/i8cVYWw760T5dKJtNGCyrQ5pIsJ3j+qPiauVHRrbEZ+wIeHbr5Wmh+mbhOSfLV/BaRgVrLwuu/+PwJ0U/TuXRTquAw1iR58zStb4f8daqwMg0jmvNZZa1xTvILGAVDg4VX7LH+/sby4QClfJNFVwpT3UZmEdIB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eal7ZPzXg7Tor+HGyKDhfU+Yb56blxtmZOg9Koze1I1vIyvffDeaylSHNrym?=
 =?us-ascii?Q?pxREENtBtR2FXb/DfloUGCu9ehKrrznSSl4M+Dsd7YA4Hppmp6NslgwKktNN?=
 =?us-ascii?Q?7hFaJw20kifAspAMB40MUJ9gsU1G+gTBsMWQ9GI9/MqjcyWByEPBdfnEZxII?=
 =?us-ascii?Q?1wXSwe2GKroEDoeCSESLCnk7Uqa3XqdeeHUH9vv/z3/Bym9sD+U6iKbRH33o?=
 =?us-ascii?Q?VfZYBndmRytoYIKLDXvrDGYmAxaQg2wu3YdG0o0C4gRXsxOYGCFjIEii7XJn?=
 =?us-ascii?Q?1q1Cgj7Kk+uwwxnhe3Npo9PnKP1lxyW8lbRZt+B3o/YssKd6onmIP5J7ZuG1?=
 =?us-ascii?Q?Xusn0Xwh5dBx1eRTiXdhhB4u5ED0ulc5E59xr2BcomiE+vUEJWOIitzSxEjM?=
 =?us-ascii?Q?LhmmvFi360pQXHivdd/5s+Q3PI0OLEzbvjzGbMqTMHxtr0Sold7xTxPYV8Ke?=
 =?us-ascii?Q?ZFb55Jfpbl74oxCGtaIW800j6LnUVAiPLKwRuiYGJlS4johYczFit/lEaj6R?=
 =?us-ascii?Q?ymkEhTW+AUJVj5zoJEtVACdmkiiY08SYLCYm3kI1UOTjNuO9N8G8f9VtGvCf?=
 =?us-ascii?Q?l/0rk7duz+PrzcZ6pee+x83xdzdDFaQfS1rPVRBu8FS1dWPpSSLyFmZHrd/J?=
 =?us-ascii?Q?nfTCiYcKcMTkxmnl6DpChJpm2g4lhbV4flbQA6Mw7TYOtS55o8nJr7HmMneq?=
 =?us-ascii?Q?GzAX4jXp6lpXlxcBmE+K8m0w8JypoyH7eGTmUoW4YXGD87tDF09bykOmiYvD?=
 =?us-ascii?Q?zbKUjXkYmPhaAusF6yEX5Lzkfp+xELyBpcWbGo37mqM1hPFTqi1coHrMGP2a?=
 =?us-ascii?Q?W37qNjZmDZESy04vXYBq45eu8PfKdh+BF1FM3Ysx1ptbUQP2LzURZwnNj3P8?=
 =?us-ascii?Q?L/PhxT9jLcTpPOlHNvCZ4Xtkk5ddib6P2o0z+biozr6L0MJfyn3XsWAYXPb/?=
 =?us-ascii?Q?tV0Wx8fBp7do1bQmFMXc6u6lP7A+eAcQoGUGaGINKRJvL+mbTa8BKRmf5z0E?=
 =?us-ascii?Q?vdU4BpjHcXhn8NbgyXJVavsAAutPLmAiaCQC54pQEVEMvk5PURLme6ZYcx6f?=
 =?us-ascii?Q?Q+sl19nJKK4HT5XL7PAto9TKjgRUwjBs96aEyJ92konFSQbfWIx7Om2N1JHS?=
 =?us-ascii?Q?AJTW+TtN1Ib4EiLFUTI3TS+EZUNIfIqlNCxArbjNtFXeHhaDTyDU0EeyOdpl?=
 =?us-ascii?Q?mtF3sSnQSXTTYJA5aQsyUzrlMWApqLuHZsv8DqRr1Evy3FndCbc3fjvvWUa/?=
 =?us-ascii?Q?UEfWAiHwB0r9PevmtExR/7isfps3ri9qLTXwZ/lp7YbODMW2yQiyXS/pI0hp?=
 =?us-ascii?Q?+dAcqkCnbTwpBzZjcSCnzn01MM/j6CHS6q4d3m8rYOf6kQ1zLoFtDRxbhVA1?=
 =?us-ascii?Q?YgL2Nk6ETHagcmvq1OKMArnTftx1RX/dQpBa/zKk1RhmIO+GQgzlWBFOM/OE?=
 =?us-ascii?Q?VCg1eQAzhNvftYjdXlIxEOaVQ+nvV/uNp9qs6WmLEp20wM8WKsIJwXydHHAL?=
 =?us-ascii?Q?WtlS7k0MpxkoIvJ9G/2g5W2uH7pic2Wpi/0Z+/1lv7l02ANU7RLeXKyOernG?=
 =?us-ascii?Q?1gl4HSfUFI4TFkDKyGg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5328F1454363BD8694C1E6A8F1552DM4PR12MB5328namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e0ea61-38b3-4429-f4f8-08dc3492720f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 17:11:16.3114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIoVmz/yBjriRRV/FHETw4Z7SyhEpFdejH3FM1EwlWMt03qBTiSmsSg87yA6DpIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

--_000_DM4PR12MB5328F1454363BD8694C1E6A8F1552DM4PR12MB5328namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed By Zhigang Luo <Zhigang.Luo@amd.com<mailto:Zhigang.Luo@amd.com>>


From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Friday, February 16, 2024 1:50 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: Fw: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SR=
IOV


[AMD Official Use Only - General]


________________________________
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com<mailto:Victo=
rChengChi.Lu@amd.com>>
Sent: Tuesday, January 2, 2024 12:30 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chander, Vignesh <Vignesh.Chander@amd.com<mailto:Vignesh.Chander@amd.co=
m>>; Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com<mailto:Victor=
ChengChi.Lu@amd.com>>
Subject: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in SRIOV

VF should not program this register.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com<mailto:victorchengchi.l=
u@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 00b21ece081f..30cc155f20d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3888,6 +3888,9 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(str=
uct amdgpu_device *adev,
         uint32_t i;
         uint32_t data;

+       if (amdgpu_sriov_vf(adev))
+               return;
+
         data =3D RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_TIMEOUT_CONFIG);
         data =3D REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISA=
BLE,
                              amdgpu_watchdog_timer.timeout_fatal_disable ?=
 1 : 0);
--
2.34.1

--_000_DM4PR12MB5328F1454363BD8694C1E6A8F1552DM4PR12MB5328namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F4E79;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F4E79">Reviewed By Zhigang Lu=
o &lt;<a href=3D"mailto:Zhigang.Luo@amd.com">Zhigang.Luo@amd.com</a>&gt;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F4E79"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F4E79"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lu, Victor Cheng Chi (Victor) &lt;Victo=
rChengChi.Lu@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 16, 2024 1:50 PM<br>
<b>To:</b> Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> Fw: [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFI=
G in SRIOV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lu, Victor Cheng Chi (Victor) &lt;<a href=3D"mailto=
:VictorChengChi.Lu@amd.com">VictorChengChi.Lu@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 2, 2024 12:30 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chander, Vignesh &lt;<a href=3D"mailto:Vignesh.Chander@amd.com">=
Vignesh.Chander@amd.com</a>&gt;; Lu, Victor Cheng Chi (Victor) &lt;<a href=
=3D"mailto:VictorChengChi.Lu@amd.com">VictorChengChi.Lu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/4] drm/amdgpu: Do not program SQ_TIMEOUT_CONFIG in=
 SRIOV</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">VF should not program=
 this register.<br>
<br>
Signed-off-by: Victor Lu &lt;<a href=3D"mailto:victorchengchi.lu@amd.com">v=
ictorchengchi.lu@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index 00b21ece081f..30cc155f20d4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -3888,6 +3888,9 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(str=
uct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, =
GET_INST(GC, 0), regSQ_TIMEOUT_CONFIG);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_watchdog_timer.timeout_fatal_disable ? 1 : =
0);<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5328F1454363BD8694C1E6A8F1552DM4PR12MB5328namp_--
