Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9DC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 09:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F9E20674
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 09:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R+znt8GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F9E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949266E500;
	Fri, 24 Jul 2020 09:49:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5BC6E500
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 09:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg0/UMu75SJycfr1sqAMfmKHAmrXG3g0EWX0hSjV8P8179iOHcYlokJtq8lQfvqeC+fSEsssV6/7rxRO/ahniNUF3v+belPBEW9OSkOohuqFi3vOEelwt9NOJODSBjdROIU+v1lrww9Rs5TkaKxkeMP4XY35fwIyh9ov73rA3CebqogtMTsrZEdvpFl+lzNWnr6gjDfRMGYbzkx15JX//PeJabfcz4z35z+JK+cfmgpOPOCy0W/todKiAgEcOYy/Ni0zbIwMPWLMg4gpL3cAH0lO+xBaprRt+ZaInTHkDLXZir8HJkNMDHTWW9SGvyx8bEA0IazjZ2Y576mUWB99Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKjRixvlpe0pEMC/zYZoqm0WZRwzEBIb330JYy5ela4=;
 b=VCxbD5BlidXUBRMY3WEhI8Gm2GRGSQyvY4mvoKIPOp1S4xgQmrpUAQEbJ+xmePElVb3hHJbLNN2fx2xp2aNEhGC+yTSynQ2qRhdsoXeKv/oLG+BRKKBp0sUeWYLMFyfJgHqEyONObB77Pkey7bu/Zk4VO7gaaDM5JkXMogjCBh1MpaaiToRZsgsUsMSi7+hL9WOJHdCBuBSNlpVqDsoKcfgSjDQNPFswklrjEjgUaHIv9JhGUrkIbF8v0Z9rLvmVKSMPzn3u04pPt++SN7RHv9xazSj7n9wAHG7MAlw9wkNzQPZ5UCW4vWGZEOnjo4gxXnGQRsf0IofjG0qeAmuQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKjRixvlpe0pEMC/zYZoqm0WZRwzEBIb330JYy5ela4=;
 b=R+znt8GWUaxnhzrVeI4Hpqz5zPdeUOhlO75s/61tYp7eM1MMIAe4zVNVkc4dCFcyHbxAfa1FGbMObf8iflKekT96uUpxJ8BnSoR+gFLWXBoOkYqr2hPARw1sLNsOVaR1GjXMYILLUQ7GrziKNfVJ9pCMiz1nCz0utGIpABcmLhc=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB3910.namprd12.prod.outlook.com (2603:10b6:610:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 09:49:37 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::91e3:eca2:81a1:936d]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::91e3:eca2:81a1:936d%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 09:49:37 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Index: AQHWYZ5d0k7TAEoFEE261kgbQ1XJjakWex1w
Date: Fri, 24 Jul 2020 09:49:36 +0000
Message-ID: <CH2PR12MB432664C191B164F106624D47EA770@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200724093921.409691-1-likun.gao@amd.com>
In-Reply-To: <20200724093921.409691-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a54ea744-baff-45ab-adfe-1608535ca2ed;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-24T09:45:34Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f2a2b2-036e-4052-037d-08d82fb6e08c
x-ms-traffictypediagnostic: CH2PR12MB3910:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB39103AEAF2DD14B5D83DA6B0EA770@CH2PR12MB3910.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCFzXCDyGocprXoO7opwvCkauHSo/TF2V3FTIVhHDLATHBHjSwpifDeXiIxB3BZ28WLacagP35qUqT98XDDniSJkE2pntGHdtqH7MW9px1YyqxzMGS/d3zy7L0QcmatiuNGABCdOG0ke8VAW9nK5QsSksJgRKpw8Tn2J2uyom3DYx3kkm7v1UEBXuiuJuh2zV8KmF9ysT9XR70G69eULIwUVjUNILh5OSuAjieaC+bqsKso+XeMo+GUfnQELT0hmcGht1RZGo1uEn+odLDo11Q83TZttz42uFiDvRZoWDPSt3linea5xeedZmG/lWfHd1afRhOyChq0gJKMclwrKWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(54906003)(4326008)(52536014)(9686003)(8936002)(110136005)(71200400001)(6506007)(53546011)(316002)(7696005)(8676002)(2906002)(19627235002)(5660300002)(55016002)(15650500001)(86362001)(83380400001)(478600001)(66476007)(66946007)(66556008)(64756008)(66446008)(26005)(76116006)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UjtBda7dCQ91KEESxpBrtmU7dXbD2Oa7uKGCE3LSHivfeSwCTJKKDjHEF7cVVbIa+CxR2AGaJ2hD3HE0RhAGWitWNrtI09ER7ARhp22GOpzSy5sBg3zxrDZ5QBCMETLR+RMoi/uFiE1I4frGgfFRv29jlWMA3CLFZxGVRDfcJ/gDCzcz1R6dC+itukNBqlTRR2OWQlO0m0JlyoHDS3QQRlISasMuhrVSGwlYTEn+TzxFERUocQFzU0u5wa6ch5K8J3viBwqL17Gt41ofD1bTAbLw0Pm0A/LjB2fSI8Nu9h96aeos0MBohi93vJGvDrCVVr69cFQAQ0agCAaramlCqlI7Qa46lT4N0TWPaD6G4clq7wl1R1Um+uVFNcPU3y9uXX/RFV2JyEQI3I4PGtZSosuGA/5KgsQphdnkNezKdh8O4Vkebs2d5NOFDuxXIp8Zv+kpJTBciWhGsn7aRT3atLYgD6ehIzhrBPkNzry+gXzU1PInN5VNGkqroNdECis+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f2a2b2-036e-4052-037d-08d82fb6e08c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 09:49:36.9187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMjfZa8OhJPxHsvaITFgRMbMD4MYZIGLYhd0vudxZ8EeOtxx0tc4fIdyyJrIBdAb6+nq6pd4vRLUco+OJCi2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3910
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

See my comments below.

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Friday, July 24, 2020 5:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update sienna_cichlid driver if header and related files.
Support new smu metrics for pre & postDS frequency.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I5446256fd7082a1d51df4ade3828bf5fa1ea3e7f
---
 .../inc/smu11_driver_if_sienna_cichlid.h      | 21 +++++++++++++------
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 11 +++++++---
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index b2232e24d82f..aa2708fccb6d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x33
+#define SMU11_DRIVER_IF_VERSION 0x34

 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 5

@@ -968,9 +968,15 @@ typedef struct {

 typedef struct {
   uint32_t CurrClock[PPCLK_COUNT];
-  uint16_t AverageGfxclkFrequency;
-  uint16_t AverageFclkFrequency;
-  uint16_t AverageUclkFrequency  ;
+
+  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
+ AverageGfxclkFrequencyPostDs;  uint16_t AverageFclkFrequencyPreDs;
+ uint16_t AverageFclkFrequencyPostDs;  uint16_t
+ AverageUclkFrequencyPreDs  ;  uint16_t AverageUclkFrequencyPostDs  ;
+
+
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
   uint8_t  CurrSocVoltageOffset  ;
@@ -988,6 +994,7 @@ typedef struct {
   uint16_t TemperatureLiquid0    ;
   uint16_t TemperatureLiquid1    ;
   uint16_t TemperaturePlx        ;
+  uint16_t Padding16             ;
   uint32_t ThrottlerStatus       ;

   uint8_t  LinkDpmLevel;
@@ -1006,8 +1013,10 @@ typedef struct {
   uint16_t AverageDclk0Frequency  ;
   uint16_t AverageVclk1Frequency  ;
   uint16_t AverageDclk1Frequency  ;
-  uint16_t VcnActivityPercentage ; //place holder, David N. to provide full sequence
-  uint16_t padding16_2;
+  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
+  uint8_t  PcieRate               ;
+  uint8_t  PcieWidth              ;
+
 } SmuMetrics_t;

 typedef struct {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 429f5aa8924a..9504f9954fd3 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x33
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x34
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2

 /* MP Apertures */
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dcc5d25a7894..f64a1be94cb8 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -70,6 +70,8 @@
 FEATURE_MASK(FEATURE_DPM_FCLK_BIT) | \
 FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))

+#define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
+
 static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
 MSG_MAP(TestMessage,PPSMC_MSG_TestMessage,                 1),
 MSG_MAP(GetSmuVersion,PPSMC_MSG_GetSmuVersion,               1),
@@ -443,13 +445,16 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 *value = metrics->CurrClock[PPCLK_DCEFCLK];
 break;
 case METRICS_AVERAGE_GFXCLK:
-*value = metrics->AverageGfxclkFrequency;
+if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+*value = metrics->AverageGfxclkFrequencyPostDs;
+else
+*value = metrics->AverageGfxclkFrequencyPreDs;

break;
[Jiansong] why fclk and uclk don't follow similar change as gfxclk, since all will enter DS when in idle state.
 case METRICS_AVERAGE_FCLK:
-*value = metrics->AverageFclkFrequency;
+*value = metrics->AverageFclkFrequencyPostDs;
 break;
 case METRICS_AVERAGE_UCLK:
-*value = metrics->AverageUclkFrequency;
+*value = metrics->AverageUclkFrequencyPostDs;
 break;
 case METRICS_AVERAGE_GFXACTIVITY:
 *value = metrics->AverageGfxActivity;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
