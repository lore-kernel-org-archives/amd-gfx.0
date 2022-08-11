Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BAAC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3952DB4835;
	Thu, 11 Aug 2022 15:48:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C62B47E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 15:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt5guVn/i8NxBTs2DUreHZtWB2XljNmUpWA4zvplBJXmGdPfYkXqCYIaKLlj6Ifa8Gps536EwNRItr/UrWnx2pEEXC4yHVMx3M6aUDSfoD5v5rPjn6nQO0p7lOW1dXUKkrC9J+YIynQaTBQjUU0tjyLCEw+Af6/eYuZbv4fpSDhwd0+ipICREejcAevoFwkcm7X3RIjHVO+RxzB63q+7NtpXiG/oDt4pjnfIihzOhR5khTuNGPGntVKQTP+ZVsvM1oTJgL7doxRmvmMgi9ONs0kjEMLnOplQYIDhMYZbKItddj37+Y++z2CQAPSoqCFibPgDP6vcKzPSFl8jW5g4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLJAEE2xwFrkjMR3lRPLghDlRaUhrXhfBdT10PMhFQI=;
 b=b/0JN5rcSP67dcBiqrZi2pfLSxP8GPNku5I9aPDODhA5tqEsSXRPuN0xbJ+9JoxI7sJY/mBIiQXiAp68aVgWQRHYHsoMiE/wYRGHyJ6SCsh7liTrZlNfTVlq6RoJUXrjwpWs5Tv6tDRFb3LBPRStAHLhQbhI3Okskn3204gXSi+H2mroX6SfB01HA8WtYNUcurcSBUTq8wq0YYv/dVABhGHoFyRv6vRWhSWdu48PYyO176t/VED3JNnTa/LXhPx1IU/tGX0A5ksAKiysbHNJeE0LvM8n3aMaYrskWlzm2XU/44D48Br57ZDiRSHMjS9w0ucIE0SzXzuGizIfZZO9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLJAEE2xwFrkjMR3lRPLghDlRaUhrXhfBdT10PMhFQI=;
 b=IOWVIjDJGIuQQSqdkgCtGOryoBJ8rRPClozsJtD6UHOAvcLP1Q7q5Lu1AaGI2/UzXJGQyf2EGGpESW6ckBnu634KFootzNrnciOkTJMhl6BwH1L6/AwJAqGouyi9b2WmH1eBTvpl7n+HkQ4aG9GjK68ctqwOafunkINzWSuNX04=
Received: from BN9PR03CA0387.namprd03.prod.outlook.com (2603:10b6:408:f7::32)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 15:48:41 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::71) by BN9PR03CA0387.outlook.office365.com
 (2603:10b6:408:f7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 11 Aug 2022 15:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 15:48:41 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 10:48:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] Documentation/gpu: Add info table for ASICs
Date: Thu, 11 Aug 2022 11:48:17 -0400
Message-ID: <20220811154819.3566210-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
References: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5e4e26-f967-478d-8ca6-08da7bb0f6d0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tx460ow+HWD6OpRuv/bCcHKks0BMJu9foG7yDmzCsrx1z6mPGYj6ZSDQdI2HEpL77R2Szx8Yq1BtMEXSW0IHBgtsGnsRyE9R+QR7HvhVDbo9anEoMXCQmhxLBQcMNvAK8lzLweA9TVBcDSdKrs7a/GNIvozM9GCJAiPDiTcscau07mcQctm7HEjSuFOMWe37DrffEtsBIBj3cNU5/vslj8APRQ1LCjq8h9mI7sBCTNRkikcSeGWZ/puPcdwXlTU1M0W6gsa/v/2fZvWdj9yx952PZaWalfeTbgtPwuir4DLv+nx/gxb7yidOBNul4/bnXkSUD23NsAYT3dlXalNyU3RuxskLB2dSRARsvdIvKm5AtYYTDQCxNsqL+kBdCKa2MeCgBrUavbUY9/GQA6LW4EnKT8/66l1hSVPe0hiPYPQKSNi0pkhwcAkmxbe7THzeGo2Y375dbFL80ZatCxXpGdV9YF1eWfvnvCH8Y2KOT6UeSolLpwV4VY+xNsYKA0tWIsziJQGBqCP4geqQDzMJtYM03sJSGjF8h6gG3zq6tWEjSXyLu5ARftOVN4wNNj/ZkSZS/FMUZEEg+5EOq144cNoUHij+EyTw6HTg+FmkLmPOPq4Edrndii4XSZuGiJF4bwEpCEq/3vxpG6IpYhjEgBdrWGPkizZItxxvOtBCYp4ApAK2dFAqm86xycEZEVl7tDNwWmuUKiwyp76fWiy2UdWXCVH4yKgoptUgycKIeX8Wd2AYZ1H/bdMrf7Zy8r5AI8LuiIMisj2IWRTUzN/kuvLDrtXHERrYyr4wMnI7faWLr0qFzS6xSj1okDrfYPIFZoD9DiMKzwprLYSoyFyd4+O3zprnQA+g7Q2PoTGLj7GXAMrVeIwb4HuKqcM59epkMqm9RXLCMaxdAz1Arcoj2cO6fRSgXLkHMczCMFkxFKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(40470700004)(46966006)(5660300002)(8676002)(7696005)(6666004)(16526019)(26005)(2616005)(36756003)(336012)(8936002)(1076003)(478600001)(41300700001)(82310400005)(186003)(356005)(40460700003)(47076005)(36860700001)(426003)(86362001)(83380400001)(40480700001)(6916009)(70206006)(316002)(2906002)(82740400003)(81166007)(4326008)(70586007)(54906003)(545624005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:48:41.0888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5e4e26-f967-478d-8ca6-08da7bb0f6d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Mark
 Yacoub <markyacoub@chromium.org>, Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Kent Russell <Kent.Russell@amd.com>, Simon Ser <contact@emersion.fr>,
 Sean Paul <seanpaul@chromium.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Amdgpu driver is used in an extensive range of devices, and each ASIC
has some specific configuration. As a result of this variety, sometimes
it is hard to identify the correct block that might cause the issue.
This commit expands the amdgpu kernel-doc to alleviate this issue by
introducing one ASIC table that describes dGPU and another one that
shares the APU info.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Mark Yacoub <markyacoub@chromium.org>
Cc: Pierre-Loup <pgriffais@valvesoftware.com>
Cc: Michel Dänzer <michel.daenzer@mailbox.org>
Cc: Kent Russell <Kent.Russell@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/apu-asic-info-table.csv        |  8 +++++++
 .../gpu/amdgpu/dgpu-asic-info-table.csv       | 24 +++++++++++++++++++
 Documentation/gpu/amdgpu/driver-misc.rst      | 17 +++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/apu-asic-info-table.csv
 create mode 100644 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
new file mode 100644
index 000000000000..98c6988e424e
--- /dev/null
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -0,0 +1,8 @@
+Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version
+Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
+Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
+SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1
+Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1
+Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3
diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
new file mode 100644
index 000000000000..84617aa35dab
--- /dev/null
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -0,0 +1,24 @@
+Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version
+AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --
+AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
+AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1
+AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE 2 / UVD 4.2, 1
+AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2
+AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA, DCE 10, 8, VCE 3 / UVD 5, 3
+AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3
+Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100 /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
+Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
+Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
+Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
+AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0
+MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
+MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
+AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
+AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
+AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0
+AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2
+AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
+AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index e3d6b2fa2493..1800543d45f7 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -32,6 +32,23 @@ unique_id
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: unique_id
 
+Accelerated Processing Units (APU) Info
+---------------------------------------
+
+.. csv-table::
+   :header-rows: 1
+   :widths: 3, 2, 2, 1, 1, 1
+   :file: ./apu-asic-info-table.csv
+
+Discrete GPU Info
+-----------------
+
+.. csv-table::
+   :header-rows: 1
+   :widths: 3, 2, 2, 1, 1, 1
+   :file: ./dgpu-asic-info-table.csv
+
+
 GPU Memory Usage Information
 ============================
 
-- 
2.35.1

