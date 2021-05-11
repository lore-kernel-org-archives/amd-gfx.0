Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE124C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 12:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7AB61919
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 12:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7AB61919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5736EA2E;
	Tue, 11 May 2021 12:33:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA406EA2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 12:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc5+xY92HPfCPqzbkECSoy49672upZv0l2m6KCc4Pk/bYS/jYgmRZGc683fqAxzigfHMFZYo/qwt5DByxYZjO1fco/HYIlhh/7Hx3tzVHkK2/LpUMksl3KoeOd4cfLHErKf+JmqYZy0SwY9EPHhBgXZFzglH0T3KySX/i3SVRoVSuhxbY8KDFoIgrnmj2tygvZP4Dj4emGqbj9/Qt0ryznuhRi2PxoLJTD8eJSvplbgkwggeBLfkcox744Tn1GaTCVCxaF23+njuZq4BeHAxf/O7DZ46X+aaVNas86r49yPCPwbY/+PKeiTvJhfRhgNc/ZXjFB8O5A09WLB28zzaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItlK2WVdODQb4f8TKXSBjhtHxVPN0zbU1JVbemTuGkc=;
 b=A4m0H8anDGqNpGe9XP7EdgYLElBfqF7XOTHPTo0eHGRH864IpO6bPop7hEFKw8ckVfvFwa71tfFmz/VB6aQKS69B664TL5u30sOn2DJPi2jxz3Ub4SuAMB6Ob5rn9LihIPg+hMVRLRoVeSHINEL5C0MDexhHBnsgiP80wfkIkTW9a8pfgPBMcD9W6upiXSYk9gdgeTSLly57gq6YTGj41I427jh64rDj/78NoHq0bkGebaC2L76/04NzKC+ALhyAhlFsBcw2CHf4MwGZpVDCXzSvr1lNJTmpP2JwgwHBYBFTPHk16Qg2ZOOi/RE4IpDx15N2aVyZW9qdMFmoDZec9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItlK2WVdODQb4f8TKXSBjhtHxVPN0zbU1JVbemTuGkc=;
 b=mOFndStarQ87FouTxt8waSa0L2SOvvfsPsI6aae2mXA55tgxehGf7YY1AWRkzfV3c1vVfMMoQprWhvzDMTe67xYGqbaac11DC9fZniiiZ60bjxNOph7j6zIS9BWH6RQ5pecETYpabxb8MZFDXqDJWIdHaw/k9aUT2bWFyyVWFD0=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 12:33:48 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4129.025; Tue, 11 May 2021
 12:33:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Topic: [PATCH] drm/amd/pm: Update aldebaran pmfw interface
Thread-Index: AddGYJ5S/wzXMvjSSCitzLk6l3FpUAAATrkA
Date: Tue, 11 May 2021 12:33:48 +0000
Message-ID: <BN9PR12MB5368796EC1E43A67BE19F190FC539@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <CH0PR12MB5348A8191A3A18A5ABB8419097539@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348A8191A3A18A5ABB8419097539@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T12:33:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bfb49ac0-a0b3-4453-bf90-879d6f080913;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa60e591-d551-47db-88a5-08d91479069c
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5161A7AED652DD67C76C4297FC539@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpKeLFcEHUEbwjdQoRz+Vv13CFspN0gasXXRuizFShKtU6gPth5OxX/0WZFNc4s839vyRXrqp4JdkPCd5Sh+3TAW8lNU3l/ljXmACuaikWOLqvTDMh0LNHUbluantn3yQ83x8UtseHfyanpwb1ywzRA9ttkzDaCUKwcHMwvgT+kYkFA6rfUhMs+rqx1j3ubns4BDcKfZmsR+sU0P7XwMvyV/0qOrJnHO0QyqIM3w887te+A6m08GEjMgJ6o/4WsslxoLZ0PWkNc5TOyTCPvSNxGJURYKq6h8idRVMGJ0YHebNlbDT6EF8tRFyQCDCsB0h8TraUvvHfSD4Ln4xEL1SCqyPXybvSzlxcM8u22AC7L72KzpsDOKhYiT09vINpWEBVeN/1Yikj8JIfRDhgeQVVFYaeMv/BcFENKqxeRMeEE3ecST0heJByK/DKmf4mzHpM0WgpqVGRnIAETVjd1AXiRNXslbxOwcFwao4hMGbHCODDX5Yso+5miiz1/jRtlww0/6IwEbJAit62AspVtMy5rxLKPaPhyS55t5jfHf2p/WOgIlQKUcXLzAPblghbUT2QHO134kUgB6uxyVHkFPIbyA0Egz+rNOevhG/2GYHJk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(366004)(316002)(76116006)(26005)(186003)(33656002)(86362001)(66476007)(8676002)(71200400001)(83380400001)(2906002)(110136005)(66946007)(64756008)(66556008)(8936002)(66446008)(54906003)(4326008)(52536014)(5660300002)(6506007)(9686003)(55016002)(30864003)(38100700002)(122000001)(478600001)(7696005)(15650500001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LvfN5mf7XXYZ44U6wgtIvBL+9uImqMPfdCqG3rOcNiFvfO6fJ3ByhBCSaNOq?=
 =?us-ascii?Q?c4CdfUL/vupVCGSrz9QXmNmvRgWwmho/JErRWbyDTctlQyyqBqTqa6z6vFX1?=
 =?us-ascii?Q?4P1ni1MBDeoiiBRy9ldWJGT/SzTN01IAX/Ymnx3FdBXnP7Q71gtw2dvCfpGu?=
 =?us-ascii?Q?u2o1AC4KWMXKlz5qhFyygrKnovHk0FRIa1js4sM/GI5cW7/eX05l21RXI7qr?=
 =?us-ascii?Q?BNi2FGGUDyVCUSDvM+uFaLRe7jsTFTG/JCdSuoNnK75ftU7np2xN0e/AQHQB?=
 =?us-ascii?Q?EGDnhA5LmhBaZCOlxtjSQF3hpH8sJu69zLhUV8oH9cfNbPZN2GVgX1xtk8Fu?=
 =?us-ascii?Q?GNGLyRppPAOeF8VesjV+BtHXvzOpecb8BH4g2MFiuqvgq44Jl9ABZ5qgJHSd?=
 =?us-ascii?Q?YktDEwQA/cj1EkkiAUa1u09qTMuRXYikLLsSYFapVPDfnNUazHQ8LFF5K9gF?=
 =?us-ascii?Q?J0Ykt9b5DdvgzjE2i+f2pj9G16HXFVqDYR4Ss6yCEmuLXwwvNPK+LehQkrFV?=
 =?us-ascii?Q?00adB0IEipydCrD7leVr25GGiusySbPt+4AJrIfXkkfE9iHeHWF0CJ5I0LnD?=
 =?us-ascii?Q?rJn9vsqgXqGcraa2vCMYV5M87dq/VI7L0S9b86TXlnoNWN4DC7BL1nRP2LlZ?=
 =?us-ascii?Q?laub/0NX6j0CI+SYsbm+/VZXfa/kN0jZ29jzel/STc1/w2Iu9MqQrMELOpTu?=
 =?us-ascii?Q?BL2JnKrxdc0TTTTC4pxiilbVbTt3lIIsgoQLcUPJYR04O53oqVk+At2bsVHH?=
 =?us-ascii?Q?79MSpQG2K8L1F0GE6jUp8etY60zEosp9DyK1ANm6BtaaKHeQHgrWpuzUPuKD?=
 =?us-ascii?Q?ZfQNTIdaH8Fvv50ao2YVVbWqKhCd4Ejl/fQbG2FeBKInfhSSVdCAA1hK6B6u?=
 =?us-ascii?Q?sZJsQnuWCuDoY1ARbd6XSB3Sxw12eB/EJncfEtovZycjIkKcvqcyEBrjQtGH?=
 =?us-ascii?Q?hdrDUqaG5pepWoAWAjTPmktZQ5vjYawv6ei1bdrMUVblkBk065O22iOlqeZz?=
 =?us-ascii?Q?yW9oLwIs32jE4WRqgq+RQsVtOs6fXo6YbNVRjwdQh0KD79jSZ4v6sK9DGbju?=
 =?us-ascii?Q?r+tT0La5dU7faOqRfkA4GWsUX0FM8xrGAPcnZaPg/Vkm4+6QcWOTHJxFarR0?=
 =?us-ascii?Q?UfXsVmCYd2umYsUHsTcAi/ZqERi5wFFWRxOc6UDcdYZx5iEs02vH2mt+1dxq?=
 =?us-ascii?Q?eDlLwXt7NR58Cbf/d5TQQMuLfp2MyRqhG3/aCMrwTpF4n8L2mNZDF+OjxBWA?=
 =?us-ascii?Q?k6P3Y2NN3Iiy9gBDFVlVsrzK8QPUBRZ+LlCmNt4IYxvwwCnlCk0ocPliBxjC?=
 =?us-ascii?Q?NmLJQFxrLHeYAz95sjlYEWKt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60e591-d551-47db-88a5-08d91479069c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 12:33:48.1816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N31PmZM6FslGqthDpA+C12X3Z8pKtgaq/9mVMScHA4kJE+5uUEKt7Hk7VMz+2VaGVw7NZpc4Coa7MwLjgDaz4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: multipart/mixed; boundary="===============1841510353=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1841510353==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5368796EC1E43A67BE19F190FC539BN9PR12MB5368namp_"

--_000_BN9PR12MB5368796EC1E43A67BE19F190FC539BN9PR12MB5368namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
_____________________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 11, 2021 20:30
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Update aldebaran pmfw interface


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



--_000_BN9PR12MB5368796EC1E43A67BE19F190FC539BN9PR12MB5368namp_
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
a name=3D"_msipheader251902e5"></a><a name=3D"_msipheader25000000"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"#317100"><span style=3D"font-=
size:10pt;">[AMD Public Use]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>

<b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; <br>

<b>Sent:</b> Tuesday, May 11, 2021 20:30<br>

<b>To:</b> amd-gfx@lists.freedesktop.org<br>

<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>

<b>Subject:</b> [PATCH] drm/amd/pm: Update aldebaran pmfw interface</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<a name=3D"_msipheader00000000"></a>
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

--_000_BN9PR12MB5368796EC1E43A67BE19F190FC539BN9PR12MB5368namp_--

--===============1841510353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1841510353==--
