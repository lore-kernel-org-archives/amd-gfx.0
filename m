Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADEC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 13:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192D3619B8
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 13:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192D3619B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BA86E8EA;
	Tue, 23 Mar 2021 13:07:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021E26E8EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 13:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvh+Dz/t9HiGBWbFPv/bWX4lfjppSaVXzw+con0dHJbLgxYmuvbjOp4VhK0VEzjNdgbx9h5PxrQfUodLWFLmCrGXwMf397H4j/spyCBzDFDSNI64oZ8GzV6TG5sbesQwv3gagtN+HmjVktKzSm3ojLCUNv7tk2ZYrZCVwVw3/6RzbcevNABOgo+2igB7FskmKE4U/astLzbpmBrlECTtVpFdqXdiA+VNr8L2JJSEh4qpGG+lsR3OURC+oH8lOWWL146lDjMSMF3YfmOYIEPRDio6cepE7R9BOF8PtWjDI+RvuiJH8vp75yvmRA4TZKtGh5dovp0AH+fuwsNZBTArPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnsr+3PGOkgHuuZKnBOAkewAx1BvdN0ovpV2LLy9yOk=;
 b=VH8HphPMmQdnQ1LsG8U1Hn7VvLH8Denmudo1qIabIWn+ZPkUiUJIGNelQMSasnvqYm9JMUhTni1VD7WfneUdG0Dmb3rHdE2qGU6KV2tB5+pWGVxrLX752RWd9bJb+rEkM+ghnNsf2BzE+mtJ9EnZ679BvVnCXDAvv89x1ryrdBmt3NqNaAM3bCasCpvk1mC7s1fNxFhh7d3QCEzPmHO8JOW0H4c7IwtKtWKKFO9JbVib2bYyjAEM/HCW1GTML4fIzoNESzxYd1cg6LQbRNUfzPdlTIvglEvymystQV9ZkEjxSAk/NAFBMX/q+QZOQz1db/PgdoR8uXpFpASfkju9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnsr+3PGOkgHuuZKnBOAkewAx1BvdN0ovpV2LLy9yOk=;
 b=1cZE5O3ilT8GqfarQCF+YUx73gtnqPvFNUrp7djtA0/NS9v4o27FqZuJFQtfU5ztrOy07pFwe3BoJUauuQ0c89OZfQiIav4HpDhwre2W4lkHbeX7nZIAg+VhS67QJrsXV7aitQN4rRqcIZAbX+odyga6EzW6GhfEf8QlHycxPW4=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 13:07:06 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 13:07:06 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Topic: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Index: Adcf5Uxzzx+eUVs0TECp524n5TX5VQ==
Date: Tue, 23 Mar 2021 13:07:06 +0000
Message-ID: <MN2PR12MB4549C3C4388974DA56E79AB197649@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T13:07:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=45389dfd-499c-467b-bdbe-cf8162388cd3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c7c03a1-216f-4cd7-feb3-08d8edfc8f78
x-ms-traffictypediagnostic: MN2PR12MB3999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB399978B5C0C5A1185F1006F197649@MN2PR12MB3999.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0vcHFJPCiA495SG0T4Tyo0Xy8NfNyFLYxTi0lDqRv1iLmaXqPsiDwqLPZ4MmvGVRjbyX383dnEPUuFvuY1WKPa17yHGeuGkuLqhEkrLIbUXc3vpyAEDdbnYrIBUJI6JJF+NBNCslEZhre18vIzMuUfD8ox0XKOevoTA1sy/sU8F1WZmI1b97Z40/IxHY61nU91cFx3YlexPYqwqPBKKHEyM9bLOH2Xbbe9Kk7Jbq63+q7zcTsqQt+1Qp/V472QeWFig8fL1aZ6fveHhmRtmTNT+9E+hvg0wrTq8QzP8omq6RMNC+Xlhq29Iz58revP7k748at6DreEKeOqpw+dfXd1VIvAEpM9kAR9vrS1TqA4I4eZgjw0i+U8JgNIXyLk8At+BpDngEXJg0jVGgJiAPfNrOmtBwZoqC2cWAShZ1h1p2bJUuQZ6tRQ5E8Ul0gAhtXxudZu0FjuKiA35IWlAQPyHTYKb4JkNrbBJH0EoCXlZHYuWk2zfZguHQ7EEJRDMeI3yAMmc11fHHeF+zlhDJJFFWr5pO/oH73Rzxu8LP6vGwbtDJu0xFIPy/G2fOzDJU9BIbtD94BI7NTwnAov4N9kPgn03c+2hPkKoQKJu+fbD8aDM7awk6GmIW4HXKG9xDt0ZC6kufLusv/7kun4NI08kD8PkmqYV3AJgzl552NA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(33656002)(8936002)(9686003)(66946007)(6916009)(15650500001)(478600001)(64756008)(66476007)(66556008)(76116006)(7696005)(6506007)(66446008)(71200400001)(4326008)(26005)(86362001)(5660300002)(38100700001)(83380400001)(52536014)(186003)(2906002)(54906003)(316002)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MdpYcEnzcDuW1fqg+fwM+FGbyIIusw49OzRSEpov0DuUyiaAUUfnM8CyV6iW?=
 =?us-ascii?Q?tzHb3pKfYHkC64TEHzYDYPsaOjyqwAEda5T2AtgS5bZYyhn968m6ulBTxHX1?=
 =?us-ascii?Q?T4FlCRFE9YXP2wvsIF3qt125cdDXuxx/BAe4mudiMgispwsm7pxnn/z+/CQm?=
 =?us-ascii?Q?n13wQjIUn0htUzcYuS8wO0My3VXm4e+toN08D2OX35FELv/2YdiC9dL5qnnD?=
 =?us-ascii?Q?901YsC+eGy89VSC9OiBtqwv5LnFgqbZdFl5zvqF52jBHBcq7TcAFQhV1olX5?=
 =?us-ascii?Q?bbWY7jjvFi8wSstw+Hu1yQ0Zra6o850a6RDXABZnUTCRZgfcokxhB7ge+8qh?=
 =?us-ascii?Q?p6+EIIZyp+1c/X9qNJ5DpSdjPZ5FCMinFgGtm4iKGxlzGhwPlLNnHN7tU8ue?=
 =?us-ascii?Q?1RJQx6CutIco7h5V/ViDWq3GIzrFVII82h6Vl53FqolWd+winntiQfv2EBzr?=
 =?us-ascii?Q?h1ydJxxqRRrBDD/bEwjCNwEvjK4MgMbau0n1fxB4Q0itqsZOXROS3wLd4Sht?=
 =?us-ascii?Q?8DFvbRGkwNMyTGJrnwsvLRQv7VnjjxvMRRD+W+fQiOr8W/JMl/ETLzxE2C3c?=
 =?us-ascii?Q?MKJciR8XLRyO4wZOWMqJowmjXECd0vA7HhylUzr/WdyCp1ytgntlVoUH3yiV?=
 =?us-ascii?Q?oviXY8yb3EG5al4aIdO09mrNhrWf6CO2n2hPnjES5NvpRTCAv0o1qjLtXpHM?=
 =?us-ascii?Q?FkQ88zrDkZau3Gobljb0EJyLlCLwxjqSXt+8bQTzJWC764QQhR/zPDpIFkz4?=
 =?us-ascii?Q?fJNdEUGOVgMrVE/esJRtpJHdnkhBYbVGeMqWwr9xGR6LGLD6sZTq1rA6sRVi?=
 =?us-ascii?Q?KPK3Jo57nybcxBW1aqB0G887LuhU0fMq99xrov25WFJiCUCXseXmF8tVsrxu?=
 =?us-ascii?Q?hGNXlr8eBHjMt4waQlsJN3ZyK84r0G3Wc4HCT3DIwHfuf0VpR+VV1dgWbNjA?=
 =?us-ascii?Q?ibOGBp0g34SLelSQOKlKkA6GsorlvJOHsPUl8F020hyOaxYzfB8CKlKx6Fvm?=
 =?us-ascii?Q?ZxoJiKqTA9bF3fNe1w761TmbjSeICllS7otNDczW5SMgNUWLUeG+qvXK07Vb?=
 =?us-ascii?Q?2bf3jsyP7S1LPsFqNLlnAIMFpt55jCjnVoHQ9aUrTCkLYYwcb6KTWU57pYUa?=
 =?us-ascii?Q?u7Yj3vHHPnnNkKH6NIsVB35EJw11AhUuA5NFMAfOfFsvGd/OMx1d7Zv/Vxy4?=
 =?us-ascii?Q?pi4zs5k5J3opR7P8gJTVrURmVJRTS4LEeRUMYON2dV8k9Ga/KZkKxbEHwRcI?=
 =?us-ascii?Q?gKyXJtyteyn0WeeENHXBqqDPb8usH91bzkcX9zQ3WrvNCLXY1Dk1k6kFRS/i?=
 =?us-ascii?Q?494u9Cn3kuXi+O2bmlmuYPLA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7c03a1-216f-4cd7-feb3-08d8edfc8f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 13:07:06.4591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zv3mNK5zRe3hrNlBWMjDm6qhb8PtyBflOvRN9zCTb9ayb/nmycZxRu7cfkhLaVxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1387890844=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1387890844==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4549C3C4388974DA56E79AB197649MN2PR12MB4549namp_"

--_000_MN2PR12MB4549C3C4388974DA56E79AB197649MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Update aldebaran PMFW interfaces to version 0x6

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
.../gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h    | 11 +++++++++--
drivers/gpu/drm/amd/pm/inc/smu_v13_0.h                |  2 +-
2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drive=
rs/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
index df2ead254f37..d23533bda002 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
@@ -435,8 +435,12 @@ typedef struct {
   uint8_t  GpioI2cSda; // Serial Data
   uint16_t spare5;
+  uint16_t XgmiMaxCurrent; // in Amps
+  int8_t   XgmiOffset;     // in Amps
+  uint8_t  Padding_TelemetryXgmi;
+
   //reserved
-  uint32_t reserved[16];
+  uint32_t reserved[15];
 } PPTable_t;
@@ -481,7 +485,10 @@ typedef struct {
   uint16_t TemperatureAllHBM[4]  ;
   uint32_t GfxBusyAcc            ;
   uint32_t DramBusyAcc           ;
-  uint32_t Spare[4];
+  uint32_t EnergyAcc64bitLow     ; //15.259uJ resolution
+  uint32_t EnergyAcc64bitHigh    ;
+  uint32_t TimeStampLow          ; //10ns resolution
+  uint32_t TimeStampHigh         ;
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h
index 6db3464c09d6..8145e1cbf181 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,7 +26,7 @@
#include "amdgpu_smu.h"
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x5
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x6
 /* MP Apertures */
#define MP0_Public                                      0x03800000
--
2.17.1


--_000_MN2PR12MB4549C3C4388974DA56E79AB197649MN2PR12MB4549namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Update aldebaran PMFW interfaces to version 0x6<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h&n=
bsp;&nbsp;&nbsp; | 11 +++++++++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 10 insertions(+), 3 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver=
_if_aldebaran.h b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h<o:=
p></o:p></p>
<p class=3D"MsoNormal">index df2ead254f37..d23533bda002 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_ald=
ebaran.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_ald=
ebaran.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -435,8 +435,12 @@ typedef struct {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint8_t&nbsp; GpioI2cSda; // Serial Dat=
a<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint16_t spare5;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint16_t XgmiMaxCurrent; // in Amps<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp; int8_t&nbsp;&nbsp; XgmiOffset;&nbsp;&nbsp;&n=
bsp;&nbsp; // in Amps<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint8_t&nbsp; Padding_TelemetryXgmi;<o:p></o=
:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; //reserved<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; uint32_t reserved[16];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t reserved[15];<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;} PPTable_t;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -481,7 +485,10 @@ typedef struct {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint16_t TemperatureAllHBM[4]&nbsp; ;<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint32_t GfxBusyAcc&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint32_t DramBusyAcc&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp; uint32_t Spare[4];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t EnergyAcc64bitLow&nbsp;&nbsp;&nbsp;=
&nbsp; ; //15.259uJ resolution<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t EnergyAcc64bitHigh&nbsp;&nbsp;&nbsp=
; ;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t TimeStampLow&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ; //10ns resolution<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp; uint32_t TimeStampHigh&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;// Padding - ignore<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubP=
adding[8]; // SMU internal use<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h =
b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 6db3464c09d6..8145e1cbf181 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -26,7 +26,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;amdgpu_smu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF=
<o:p></o:p></p>
<p class=3D"MsoNormal">-#define SMU13_DRIVER_IF_VERSION_ALDE 0x5<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#define SMU13_DRIVER_IF_VERSION_ALDE 0x6<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;/* MP Apertures */<o:p></o:p></p>
<p class=3D"MsoNormal">#define MP0_Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03800000<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4549C3C4388974DA56E79AB197649MN2PR12MB4549namp_--

--===============1387890844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1387890844==--
