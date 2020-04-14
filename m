Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FFCC2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 03:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04002072D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xs+5w+58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04002072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D66D89D00;
	Tue, 14 Apr 2020 03:02:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2755589D00
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 03:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDIUklcAXm24CCIY5OOZYL7rrNVxO3vOVxjH80XEVsdntO0fGlp56JyHZOKYrPyvdUt1orlKvaCNPbieGCQhYtl2NA3QnkaYHrlA5bNqf4GtUQ9WzBfg0ac292YFIxxMoDXmIghMcBajUBJ+XqxYGehfS+H+cstnGXaq4kaxktZCQ9VD6ccq5ZtkxW54wHrfuh8PmZDqmOtaj+kSPGpvtfaHKyaw4sxlsNlholpQecGT0y6vM+1Kg+CTjbPPK7neyNdwISyM118O859cUIhr3bUjjfYQwLrJt61a6DH/cc+h9uhdY8XfDSZxweO2jT1hANzdGCVjQJYxyhyoCD219w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmXa3NDSTgniGjy1BYLeJN43OpGhUA8kdTqZ6qxr7uo=;
 b=oVi6ZCglBQXD9D9wHK54ZDa+p6Hw15j7Am/ChcfMhNTVFB7vvT/oIo12cYWSpertfQg0vyndxaQT4YaRlTlxLY6wQbvFJwYNHd0Wwrnui6hm73wROs/+PpSnxiJ6mdyqoe7NOAAqxtIkmFAczEeuJlYr3/JnQbP5nl6NqVOsU/l/gTjS3/nOFmCb2cGgG66O/Kr/WjO4g0vTLqMY2NV3fK3SNaMRLDBERq5im1U253xEc3WApbw+ey3fCMihzmJq72mZossMH2D9iUMEImTmEvITG2FoxqnD3juHPbMnbps6DsY0w3r5AWbcUzzhygjqOc7FD7g3s3KNAvuNZ9SRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmXa3NDSTgniGjy1BYLeJN43OpGhUA8kdTqZ6qxr7uo=;
 b=Xs+5w+58DOL9Pvqacn/ZtXVSEMsqHyYJt+HUx3IKPyUnQn5U8VgYRvvdsajpUe69hnanVoZjVNxE/YVV+z3TtltunPDxbQ+cr2kIpMEjE0N9EkoQadfumAzGipLTMxfmGk2g0tvej7VoLkWWLu0zXKp3HKM8hffH6pcrNdFwLQ0=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB3280.namprd12.prod.outlook.com (2603:10b6:208:ad::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 03:02:13 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::5178:7eda:e982:2871%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 03:02:13 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update Arcturus smu-driver if header
Thread-Topic: [PATCH] drm/amd/powerplay: update Arcturus smu-driver if header
Thread-Index: AQHWEYJE29l9DPCXzkiaSum4UKQgm6h37wyA
Date: Tue, 14 Apr 2020 03:02:13 +0000
Message-ID: <MN2PR12MB35983DD20EC8DB252D0AC96F8EDA0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200413105641.15276-1-evan.quan@amd.com>
In-Reply-To: <20200413105641.15276-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T03:02:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ef4ed676-a35b-4a44-bb5d-00003d0f8bf4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T03:02:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c4a34f53-c962-4a87-b469-0000c344e498
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [240e:e0:8f58:a400:eca4:7196:e5b9:a351]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 415ba122-c024-4d14-1f4e-08d7e0203b67
x-ms-traffictypediagnostic: MN2PR12MB3280:|MN2PR12MB3280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3280DA284619DF06DD7091AF8EDA0@MN2PR12MB3280.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3598.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(8676002)(81156014)(71200400001)(316002)(9686003)(5660300002)(15650500001)(55016002)(8936002)(33656002)(186003)(2906002)(110136005)(66946007)(478600001)(53546011)(7696005)(66446008)(6506007)(76116006)(52536014)(86362001)(66476007)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jFsYUJQ1axJzZyFzTUnCepCgQ/b0i9jEM2Su/dKwT/2+Y4+qN9TBfZJ3O9tuFQmzYVDNKIcPoU88lopjsfT4bT5lnkqyzay6PpH7yQkTZKH9H45TZysf1IPCruYVhWSALri6Nj10RbDvr0p0whdEQHQ3FKpEai49PnQjJuHvsi2IMtsrmN92WBkJVK2WCIAX8cFRC8Bj7RZcnC8dtDn6dKWLvgxt8t+tW0HNcrCC4t21by7TyyIKlXp6Lw57NMlYqdBiXy+2Jjt259MfBII1mO6StyBV0Kl/QyobpbdyMcqfljWM1OSWKB3DXCw8Yv5d3q8QRdrJojWfAVkgXxf6BP3P2BOS/pjHog1emwkx4ZGQAbDaG8/v8LClB7FQCC/mnmTVlA7aucHzzIxrsaIlJoN1e3paU5siaNM+XsvDYjoZ41OX4/7F761cqhSIYqo
x-ms-exchange-antispam-messagedata: EImqeWJyp94cIeOO3bVjnTAKs5UaddcqiILcfEQbGUcjXONrKTUx2XawOpCrqMcZKhIjxxvCpqsP1IO9neQxtGqPRJ2Skalxn7RQZZWkiKmdxGvHaC+AVVth8jVN+4pNhK4Ss+ltWVT/sdaKEg2o5wzn4GiNjWT9xCwS7EpqV3zMZEhu4354hoLQiOucvcFBfFEiOj7fS8mULFx8vKiatA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415ba122-c024-4d14-1f4e-08d7e0203b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 03:02:13.4884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rr41ezuOrjIPbUkFcrLXU0ft3E8eId7+x+qhpMV9bubU7bD+kBUAW9pXDP8u8pn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, April 13, 2020 6:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: update Arcturus smu-driver if header

To fit the latest PMFW.

Change-Id: I1ebc5a4c3386e07a9fed73e4bec2c5d1ab8d4b23
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/powerplay/inc/smu11_driver_if_arcturus.h  | 15 +++++++++++++--
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h     |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index ce5b5011c122..8b82059d97e7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -82,8 +82,8 @@
 // Other
 #define FEATURE_OUT_OF_BAND_MONITOR_BIT 24  #define FEATURE_TEMP_DEPENDENT_VMIN_BIT 25
+#define FEATURE_PER_PART_VMIN_BIT       26
 
-#define FEATURE_SPARE_26_BIT            26
 #define FEATURE_SPARE_27_BIT            27
 #define FEATURE_SPARE_28_BIT            28
 #define FEATURE_SPARE_29_BIT            29
@@ -154,6 +154,7 @@
 
 #define FEATURE_OUT_OF_BAND_MONITOR_MASK  (1 << FEATURE_OUT_OF_BAND_MONITOR_BIT   )
 #define FEATURE_TEMP_DEPENDENT_VMIN_MASK  (1 << FEATURE_TEMP_DEPENDENT_VMIN_BIT )
+#define FEATURE_PER_PART_VMIN_MASK        (1 << FEATURE_PER_PART_VMIN_BIT        )
 
 
 //FIXME need updating
@@ -628,8 +629,14 @@ typedef struct {
   uint16_t BasePerformanceFrequencyCap;   //In Mhz
   uint16_t MaxPerformanceFrequencyCap;    //In Mhz
 
+  // Per-Part Vmin
+  uint16_t VDDGFX_VminLow;        // mv Q2
+  uint16_t VDDGFX_TVminLow;       //Celcius
+  uint16_t VDDGFX_VminLow_HiTemp; // mv Q2  uint16_t 
+ VDDGFX_VminLow_LoTemp; // mv Q2
+
   // SECTION: Reserved
-  uint32_t     Reserved[9];
+  uint32_t     Reserved[7];
 
   // SECTION: BOARD PARAMETERS
 
@@ -869,6 +876,10 @@ typedef struct {
   uint8_t   Mem_DownHystLimit;
   uint16_t  Mem_Fps;
 
+  uint32_t  BusyThreshold;                  // Q16
+  uint32_t  BusyHyst;
+  uint32_t  IdleHyst;
+
   uint32_t  MmHubPadding[8]; // SMU internal use  } DpmActivityMonitorCoeffInt_t;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index e786d63b1e79..464d40983de9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,7 +27,7 @@
 
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define SMU11_DRIVER_IF_VERSION_VG20 0x13 -#define SMU11_DRIVER_IF_VERSION_ARCT 0x12
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x14
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x36
--
2.26.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
