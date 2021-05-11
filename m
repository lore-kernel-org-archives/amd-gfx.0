Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B0AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 12:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270A261919
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 12:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270A261919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568EA6EA2A;
	Tue, 11 May 2021 12:30:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20886EA2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 12:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZejIwhwl1sCd1l7lax5NI3QPw2o7HZDPrXZOv2lB25kUEk4OP4jDu3oFF272Wf8Xh/hol8kSbpzXDbFVPCs251UXYek5yGf+VUHrP2+OQ7G2TfjkGrk1GywgqLvZ+4/O6vLEoIPbWEscUhv9olZ2J+yJbx+35fNas12px7pRMDwr517nQMqscYb0vFkzxa/AgsQsTs1o5DI/YzU1vTagoiblu3VpXE8/mhqo+fv+H0cp2tps2LBY/y+OrWTuXdEQ+ZRSKynyIs1kOGWSsjiRjnh9PSpWvu28BrOrsWAEZcSxW24+UffLskjRcMr1xgZV8dwR30kzG8zdI+n9F0QSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ekYhjbpgol6ex04C15bRsmVEbnioFOI9jfjsyccQc=;
 b=oJzTrl5yL8RqAPpwI1w7zXBRjh628c88V9Ip8G9i71s+AMDpAdV3bdElcjqgON1y8thsNnqKH0aLaHoRBIHcynq+QckXOmiHVSttASsOsqjxIxWQbtp4B1xJZ5m71z8YcXoKxL7fGfNbEJeskI6O17/MaMpPvFeGus+nAPPe+NMG2KMST1I/6KJQlWpKvxFNDXjVGvMuWhgHN1DsRLNlbvHYSVkwbTHgjiscn6+5jevlvYTYeYJgPfeRDgwODpc9LAFWo9pXE6kfOtRhMBuYtszbe9h8iYGV3QEWRz6b7MKMzDcpDN8p/Nw/Uq5SJqBys4Cub0LtMA0gxdQKPHxDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ekYhjbpgol6ex04C15bRsmVEbnioFOI9jfjsyccQc=;
 b=DLeQ3X8WwH3MU7HpXzaZWHmMvs8V4molFcU0gZY5H/ue2iCDQqxWLg0f+jHC+LHFHcWVTC+zhaI/jjy8mMM0tj1hIzWhpYEFj7FKAGvQFYdbZt4QCjv9YGpxe/Ko1mgpiaDO/54pS5IeIQm6RLkDn6J25gD/4beh15LaKC4VVUY=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 12:30:17 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.025; Tue, 11 May 2021
 12:30:17 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Topic: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Index: AddGYJ5S/wzXMvjSSCitzLk6l3FpUA==
Date: Tue, 11 May 2021 12:30:17 +0000
Message-ID: <CH0PR12MB5348A8191A3A18A5ABB8419097539@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T12:30:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bfb49ac0-a0b3-4453-bf90-879d6f080913;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.206.36.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ade66ca-69c8-4b7d-3169-08d91478890a
x-ms-traffictypediagnostic: CH0PR12MB5316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB531683958A52B0BD6BA1BC0897539@CH0PR12MB5316.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kTveakmMn/0E6bLmopI9cwzOUIfVPkTxBU6ZdE604cQhOqKt3eRcjO+PUC/hY69PNjOyKR0tJVZUCMtYw8TI1K5KCcp/GJPHHNx9QdjmqobgCD9iyn4zdtkNZ28dk1Ee44sVTTAvJmrhHAjv2KUcp0Lv7axKjGBP+MUl/PjjR2fIbumtOLjIZr57ud/meAqhmubIq3E98xJjkpuYx5GryeF2cVqgsgUiAm04tacjsVaM68q2WXKvox/FfBST0MvCdzTyp8lRhmO/h1SlzODfSvL/AUts3MSnJ4u4q9tpLT7KtEGoI9J0UqgQpNPRJhCEU7uYGkmFyMMihhCglsKPUNcDW6bPlWO8M3Yjx9E46haUgte/DHbBNJwDbLjBXc1oeIVU8ifJi+spF4TTDN0anXaUzm2bpvm+dkfy/kyLeF55OopFD8/KCLkGedF/bt1iMx+20D0Pe/z+4qy5ad2Z0F7tMLkJNBEJsr4PZr1XM1nGQKDQ1auPNxE/v8QLHI+Ntv07Vsm/kMPxFolDjN/gwB8eUX+i6Q04AXidhyJRh+Sh5eyWG/zqXSMdnWrBiGvMBMZP3G92PBu1ts62x/afAkDJj6+0lpqijziiRX8Q2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39850400004)(396003)(366004)(136003)(8936002)(8676002)(26005)(66556008)(71200400001)(478600001)(64756008)(83380400001)(33656002)(966005)(186003)(54906003)(2906002)(66476007)(66446008)(38100700002)(4326008)(7696005)(316002)(15650500001)(6506007)(30864003)(6916009)(5660300002)(52536014)(66946007)(122000001)(76116006)(86362001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dj8eA3iwj4ZlMLpslieKvHb+T2tDzrXREswbJwHhSqNDOamRUK5N9Z/7swBK?=
 =?us-ascii?Q?QjT0PhV6ylDT3xD+m9U+5dYHLdg89b3WuDd6YJYx6Mfc6edoAHFCIb83jVzz?=
 =?us-ascii?Q?sDNu1WAOXQcwO47zk2vtU/TVAPN2D+Fgl6FKAQ82yMqSWGoZooUxUeYZysdJ?=
 =?us-ascii?Q?H389/ebwoyeUvRKR2ByplCS8V30RbxyDgVuwt33RqA6fwHJgz5or7HNPN4Fx?=
 =?us-ascii?Q?91cYsDyh3NKqhDroCq3RMz3m/OZK4TQzZOH1pFWajvFtRqgOwyC74/hSi7nT?=
 =?us-ascii?Q?JqFjbnZpzqM+ecBjWt7mOIlYKzA5trtnbw/JqDiweK4tTHrnmvsENKDz/KX3?=
 =?us-ascii?Q?RIG4G41QuJdEGhTboFIf95tqxMkinQFEh4Dg0VUXVLXr6qlK12NlgAZBdxVd?=
 =?us-ascii?Q?1tkbtWJj+LUdf2NAczAy582LsqxIwJhdoL2ZcvJln1RHrq3phaQQiUOkL2n8?=
 =?us-ascii?Q?ntx6Mkf58V582ALGw6LmAuVOmKJDM2yE/YFYS9himzQ1pNEvvSEYd5Fmlj0x?=
 =?us-ascii?Q?IJa6N/u+jxaP4aGbTOP2zvKXAQvFx+/BX7jH5TC/Z0eid2SjpG9LoHTZJfCC?=
 =?us-ascii?Q?NjUpxKuALHA7gCgxdCK5Fsbvyjxyw3OmkzxMXn85qpQCmU54ZxriwWGVm4Wh?=
 =?us-ascii?Q?Kf2E/VTL/LjcUiu6ZtxpT2HZRG/BbDLf+8dfNlFvf0R6AgvBXkLPPziMYvQh?=
 =?us-ascii?Q?4TYz3D5bBozcYnjpZYNoEB7vx3C2Mesxq5EqwAq8B8scdK3F7LUeDHM36hBq?=
 =?us-ascii?Q?FlzLEbg8G0cPhKxncPUCCX1E4NiybE22yfNE0AabYXBizZ8Rzq+AEPxWNGfG?=
 =?us-ascii?Q?NnmUkrsvMOUEMRBvZ/K4uNCPkv0c2TQC/sZ62JQmflcEgLxLgytfVxo94ZSJ?=
 =?us-ascii?Q?5p5EIz7HeVbNx9MfTnq4PTJWnDQA4XC7iUkXKMY2JgsBUgByBs8e4eokjnWv?=
 =?us-ascii?Q?m96nY2Krl1mgmsndZJetF8e8u03zC/wUnS8rjA7e+RU0qC/eTzYaP4Z9D1D8?=
 =?us-ascii?Q?JOVmRdhtl6SxUbsJyuY3XOz8VbRmM9Pu6Qy9P8HOcpFG+mDHw//fuQG64u4q?=
 =?us-ascii?Q?6O2VCa7nVDgCX/k9L34B1w/h3GCzM/J3YDFclCjlXg+l1EjCkYKUBscXIRJK?=
 =?us-ascii?Q?00coErnZj/S/V/lSAS1zOB8dck1ut0hAhIiJQQqaXeXumvI9kA93aUCaRlgF?=
 =?us-ascii?Q?QFcit3qs3N4Oc0Mv3DGot+BlMmdbwZdmaDiwOGgW0cPiODMrYDj+3YKBeSUv?=
 =?us-ascii?Q?P3NTtWFoin3xh2Yj8ZF0uHqHGUM6m5KHfLn7YiSg0M/yMQRVwHtztK3NBenA?=
 =?us-ascii?Q?uwW6TQS9F/sM3/wjw1y1n7t9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ade66ca-69c8-4b7d-3169-08d91478890a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 12:30:17.6427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5OSnXoGKKZKF5USLwkB9S/J1y6uPeBV3MYK2h7u8gQLwZAnPMQWeZNldKNl/BAq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0267650807=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0267650807==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5348A8191A3A18A5ABB8419097539CH0PR12MB5348namp_"

--_000_CH0PR12MB5348A8191A3A18A5ABB8419097539CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Update aldebaran driver-PMFW interface to version 0x07

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h | 7 +++++--
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h                 | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drive=
rs/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
index d23533bda002..a017983ff1fa 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
@@ -64,7 +64,7 @@
 #define FEATURE_SMUIO_CG_BIT            28
 #define FEATURE_THM_CG_BIT              29
 #define FEATURE_CLK_CG_BIT              30
-#define FEATURE_SPARE_31_BIT            31
+#define FEATURE_EDC_BIT                 31
 #define FEATURE_SPARE_32_BIT            32
 #define FEATURE_SPARE_33_BIT            33
 #define FEATURE_SPARE_34_BIT            34
@@ -439,8 +439,11 @@ typedef struct {
   int8_t   XgmiOffset;     // in Amps
   uint8_t  Padding_TelemetryXgmi;

+  uint16_t  EdcPowerLimit;
+  uint16_t  spare6;
+
   //reserved
-  uint32_t reserved[15];
+  uint32_t reserved[14];

 } PPTable_t;

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h
index 8145e1cbf181..1687709507b3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,7 +26,7 @@
 #include "amdgpu_smu.h"

 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x6
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x07

 /* MP Apertures */
 #define MP0_Public                     0x03800000
--
2.17.1



--_000_CH0PR12MB5348A8191A3A18A5ABB8419097539CH0PR12MB5348namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12pt;"><=
a name=3D"_msipheader251902e5"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"#317100"><span style=3D"font-=
size:10pt;">[AMD Public Use]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Upda=
te aldebaran driver-PMFW interface to version 0x07</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Lijo Lazar <a href=3D"mailto:lijo.lazar@amd.com"><font color=3D"=
#0563C1"><u>lijo.lazar@amd.com</u></font></a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h | 7 +++++--</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 2 f=
iles changed, 6 insertions(+), 3 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/g=
pu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x d23533bda002..a017983ff1fa 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
64,7 +64,7 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine FEATURE_SMUIO_CG_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 28</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine FEATURE_THM_CG_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 29</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine FEATURE_CLK_CG_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 30</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine FEATURE_SPARE_31_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 31</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine FEATURE_EDC_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine FEATURE_SPARE_32_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 32</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine FEATURE_SPARE_33_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 33</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine FEATURE_SPARE_34_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 34</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
439,8 +439,11 @@ typedef struct {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp; int8_t&nbsp;&nbsp; XgmiOffset;&nbsp;&nbsp;&nbsp;&nbsp; // in Amps<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp; uint8_t&nbsp; Padding_TelemetryXgmi;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp; uint16_t&nbsp; EdcPowerLimit;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp; uint16_t&nbsp; spare6;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp; //reserved</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp; uint32_t reserved[15];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp; uint32_t reserved[14];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> } P=
PTable_t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/in=
c/smu_v13_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 8145e1cbf181..1687709507b3 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
26,7 +26,7 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;amdgpu_smu.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine SMU13_DRIVER_IF_VERSION_ALDE 0x6</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine SMU13_DRIVER_IF_VERSION_ALDE 0x07</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> /* =
MP Apertures */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine MP0_Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03800000</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-- <=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.17=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_CH0PR12MB5348A8191A3A18A5ABB8419097539CH0PR12MB5348namp_--

--===============0267650807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0267650807==--
