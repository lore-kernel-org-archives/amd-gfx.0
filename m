Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E0C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 05:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1212080C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 05:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hj/T+vUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1212080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968F66E171;
	Mon, 20 Apr 2020 05:49:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3754F6E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 05:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYJ/QqWYANe3Z8Lza+cxgogidUH8SsCeov46EVmoGwF74TOJTfDE/JrTH5qQKU7D5EJ46N6m+0diW0uCk2ubBoKSNjEmm/BOKXquaNI70Z5mY/6oCXytq7lSEwh93zevTWnVUu0F8cQhOL7KWCTfOcR5o5fVztJO0i3oZ5KHnFs5HpBG5N+YBSpxuSW6YBkgYMfZ0UyrW8/nTPawp0h8yerCaHfshHf2pdL4o9iHuMUqmuc8jyHr+sgwMOz1Lki497965e/cO01A8kuOe1kcpVXi94zgYu0523tu0lQl4qYAkj4f5GNL23V7zMyTXCTfYKzYw4fF9BgP8+r5SJf2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cEWiCienptVP5YOPuHyenS5Ms1Lqm0b6pxZ7FSpgR0=;
 b=gRH/UVXDU7TwFPgB2vRvLkx+zPYIEdEif80bFa1MryyiBfPn6okmyhDjYF5l/U8c3YNDyUFjyku05zQYt1x41tv5mAzEMa8y0HQNX1uHoEEFxw64zMl/J3Hp7TH8blhUxq3dF55CwGeL3Rn/b6yPdk4tTLrozvdP/jgCo8SjHj7WFIUGRu+gkETwcyES/zV/hG6MO1WhCokYzZnrY59i561XEiZnFdU9EEhR/4sv+3hLwJqiycjFvrg/VvU9vk8qrWasiNh/lL967dNBRn/W6KrafRC6vNKzrjg8K6+L7YsCXSASFHYRFVCr9DZ8N6RIgRlyVBCbHsqxxuHZ449vNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cEWiCienptVP5YOPuHyenS5Ms1Lqm0b6pxZ7FSpgR0=;
 b=Hj/T+vUdeQW7Se3ibzuS7R1+aIPjuBSDsaiTjA1Ri4xjX5x6dzdSdN1JiBbCuZDdd0L/jGIJ4+ToIEbC0RcuJXc7njxTUK70Bz9H/u/mHrZ8BIrYDz2SEfbFcj2ax685BbLR4Swzq4Je8SMjeWFTnfVi+e1J0S2hk467Y+63Tjw=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 05:48:58 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 05:48:58 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update smu12_driver_if.h to align with
 pmfw
Thread-Topic: [PATCH] drm/amd/powerplay: update smu12_driver_if.h to align
 with pmfw
Thread-Index: AQHWFrkDWNjmo0WP+EWyjZaeoEpcmqiBgTfQ
Date: Mon, 20 Apr 2020 05:48:58 +0000
Message-ID: <MN2PR12MB33092A830D5B4E73533FEC6AECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1587348671-24181-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1587348671-24181-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-20T05:48:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=607daebf-7a7b-48b6-87dc-000032aa39c2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-20T05:48:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4c849bdf-803e-48e1-916b-0000089d6198
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94581075-f5e2-44d8-80e0-08d7e4ee8554
x-ms-traffictypediagnostic: MN2PR12MB3439:|MN2PR12MB3439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3439DD7280F71FA8987A3B23ECD40@MN2PR12MB3439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(316002)(81156014)(33656002)(4326008)(5660300002)(110136005)(52536014)(6506007)(478600001)(53546011)(26005)(2906002)(76116006)(71200400001)(55016002)(66446008)(8936002)(66946007)(9686003)(8676002)(186003)(64756008)(66556008)(66476007)(7696005)(15650500001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbGsK3a9hk5p2l4ck4QUrc4sQW6hwc/VN42LBGzouhjyhbgMOPCHh7aHJr43HZ7AEIW31XRWNJcvXOe22cn+4WzffVEIGpXAP/22uuh9AGtxzQt+G02HI8e1O33orhuF4xde/RTZqADQpmrN6zjg3gjb/PujKGi9GIyd6tobVO81sAWecjrGycxL3GPdKMscqUH9r0WuN/EZqlcD6UFexpUSvdB8t5x7Uamq6IuXJq8VdLgz0bLX4VOBQVixr1onPl0fu48/+0y1siqcZh03NElbjLNIiRggB+sF8Sprdmdirb1407nUrJskAvyXnOldc0Sxdt4eSEJ0QAguswRjipgWqPyNnd0fA4RN4JRPS/J3vOX+zWtxAJ1BYaICh63znnrkEtIsEA77yzAF6+MJNxH/efO+A8wZwXCuAR9m4LZuxC6qWge9Y/mIX3nwfXzO
x-ms-exchange-antispam-messagedata: 3dULMPOjB0x9nsb5yB7AP3q2QeiR8IvjOp0vzoXzxpuZ8ZsxAA7m8wDoY5BtECFuliE05cDY1o509i2d1vc8DnkjuZ7+5mCtGuEsQqJ1BsWylm9DixROkOFvPzZXOlY8rBW+JBPVRopj7IJztup/ug==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94581075-f5e2-44d8-80e0-08d7e4ee8554
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 05:48:58.5072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmstLZGlNaH77Cuvl2ldEfki5AkDFAKR3kI2fhDO8zGRD/XmX6abfzyd+p6sqbmN4rJh9vV7R8PsjQgkvpsFuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com> 
Sent: Monday, April 20, 2020 10:11 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/powerplay: update smu12_driver_if.h to align with pmfw

Update the smu12_driver_if.h header to follow the pmfw release.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/smu12_driver_if.h    | 40 ++++++++++++++--------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
index 2f85a34..e9315eb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU12_DRIVER_IF_VERSION 11
+#define SMU12_DRIVER_IF_VERSION 14
 
 typedef struct {
   int32_t value;
@@ -154,15 +154,19 @@ typedef enum {
 } CLOCK_IDs_e;
 
 // Throttler Status Bitmask
-#define THROTTLER_STATUS_BIT_SPL        0
-#define THROTTLER_STATUS_BIT_FPPT       1
-#define THROTTLER_STATUS_BIT_SPPT       2
-#define THROTTLER_STATUS_BIT_SPPT_APU   3
-#define THROTTLER_STATUS_BIT_THM_CORE   4
-#define THROTTLER_STATUS_BIT_THM_GFX    5
-#define THROTTLER_STATUS_BIT_THM_SOC    6
-#define THROTTLER_STATUS_BIT_TDC_VDD    7
-#define THROTTLER_STATUS_BIT_TDC_SOC    8
+#define THROTTLER_STATUS_BIT_SPL            0
+#define THROTTLER_STATUS_BIT_FPPT           1
+#define THROTTLER_STATUS_BIT_SPPT           2
+#define THROTTLER_STATUS_BIT_SPPT_APU       3
+#define THROTTLER_STATUS_BIT_THM_CORE       4
+#define THROTTLER_STATUS_BIT_THM_GFX        5
+#define THROTTLER_STATUS_BIT_THM_SOC        6
+#define THROTTLER_STATUS_BIT_TDC_VDD        7
+#define THROTTLER_STATUS_BIT_TDC_SOC        8
+#define THROTTLER_STATUS_BIT_PROCHOT_CPU    9
+#define THROTTLER_STATUS_BIT_PROCHOT_GFX   10
+#define THROTTLER_STATUS_BIT_EDC_CPU       11
+#define THROTTLER_STATUS_BIT_EDC_GFX       12
 
 typedef struct {
   uint16_t ClockFrequency[CLOCK_COUNT]; //[MHz] @@ -180,7 +184,7 @@ typedef struct {
   uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_SOC
 
   uint16_t FanPwm;                      //[milli]
-  uint16_t CurrentSocketPower;          //[mW]
+  uint16_t CurrentSocketPower;          //[W]
 
   uint16_t CoreFrequency[8];            //[MHz]
   uint16_t CorePower[8];                //[mW]
@@ -193,10 +197,16 @@ typedef struct {
   uint16_t ThrottlerStatus;
   uint16_t spare;
 
-  uint16_t StapmOriginalLimit;          //[mW]
-  uint16_t StapmCurrentLimit;           //[mW]
-  uint16_t ApuPower;              //[mW]
-  uint16_t dGpuPower;               //[mW]
+  uint16_t StapmOriginalLimit;          //[W]
+  uint16_t StapmCurrentLimit;           //[W]
+  uint16_t ApuPower;                    //[W]
+  uint16_t dGpuPower;                   //[W]
+
+  uint16_t VddTdcValue;                 //[mA]
+  uint16_t SocTdcValue;                 //[mA]
+  uint16_t VddEdcValue;                 //[mA]
+  uint16_t SocEdcValue;                 //[mA]
+  uint16_t reserve[2];
 } SmuMetrics_t;
 
 
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
