Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA46C636D3
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 02:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1360610E177;
	Tue,  7 Feb 2023 02:49:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8933210E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 02:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUGtOofla21YUm/MLXoOpgUXGZV/T/SxFy3yMge4Q4NZyJ4TqtpX8T8Yi+6HUfHwqkU/01/JiV54V1J9iUrCEMMQtFnu9zA5cbsTsPHmPOZMsegnmFmVrFjLF32gAGdP9eNA7p6gOXScUeSPYHosmGReK+CnvM+tHQSHPF0SS/G90nCmE4InB7/SDCK3ExxdJjd8rFo8fwOqaZUvl0e57/flOIM49F3XGi8RFLbTzJh/iv3en3N8DKZ3hNoog2F41oZq4wmlXaDD5BQ5iZMcwu2+nMsNGyq0J8GsNwT4q2GZYlx+5S4wSdwelTW4Q23SlUs4XoSO1rXg95rje4AeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8+7k/BWXcJT6N7yv/3y87KhiA5yqF1G1cnv0/vt/1I=;
 b=g3aPTtMEWX/THsaUhVUfQ/botnR0N3CwG/bW2Q0j38/vza8JkF1C1/fSaXWlaSvwXs8YKPuIMHLAt8juyOfgjYjB1ZujQiXWYPfDkvqIwVXRoJx/Gmafkqhh73GQt+Mzo2Yg4XZdDzRUIVldScnMlPvbd4T1AvEiSZ0nYCLPEgJx/3Wg1ux2JtbtUlTljL77xBq9jy+OysER5mdQZbCqglmeyHWHkb5LlwhrJ94wFh6kS9nIMWiQdsyGHtquWpbyilOcDDny0GyglwfgUHzixxYnFw1M4fU8oROSB7xjpTZKmUhUyRa404YWTxBZiY+oagEVYxPrJNf/KIUsSQ1/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8+7k/BWXcJT6N7yv/3y87KhiA5yqF1G1cnv0/vt/1I=;
 b=WoMfqu2CXjp1B6BxeDckYjdarOaq+HIMnQ2diWs8kJ2h0y8NcojphAVBQRzlKGIoRTBo/UmRYIIIAA7ZUrRNPIyjRMyASnzN3WkAcqEClNn0WbZShel7ltauo9c+SHXAgDMudWP25V2v+Cgn/Q7WkLerxmkV+1Uwbsu5mzsgIxo=
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Tue, 7 Feb
 2023 02:49:17 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::43) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Tue, 7 Feb 2023 02:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 02:49:16 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 20:49:14 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: bump SMU 13.0.0 driver_if header version
Date: Tue, 7 Feb 2023 10:48:54 +0800
Message-ID: <20230207024855.1589467-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8df4a1-b088-4af3-d8d9-08db08b5e745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Io/Im12Hq8uvQhOwtBq0mlipZ1o0VI+t1vHZEkLE8+cY3HXvmKaEHzOvrYeRzCcPgTYS8UD9e3cF35gos6v/J94o5vuTHLXLNzSRUOVbMoeZFduopMPmiEICfVgbYg6CN65W2+3hzyNN3X7Hthb1sj202J1vT/lsQ7TqK/5t2iaT/9PT9zpx8+esdeNZJ/EsMWSfl/vOW1SMF7xdRy7nyDg1NIUyotRckbF56nPf+HkDNAuv3DoTfhyMxTA19yBJdCByEk3MyDqHEnq7FI5lpCN7PHs7BWjwiGszZFHD3QKrmpdtrdQRlp2x7L1U34HKsN3NVDdWy8W/FgzvN0svHnYqISNZ68R+GY7GCsA6SgUVyh5aJYf5hrzg/Kqqh0fUcuQABiawkXvt4D9e/53alcROUhPrfVOYSK6RW2+kNRJ0Ys7sGF9bMH83mAlyR58IKvrFuYatk2CxXDdkCm952cwlyclKeRNdkb11J4DlB1d239cWCC4F6PkT45bd7uv4SDCHPZt5trLx5UvnfOlAzVz4ceed2RXuhRM5MjyTeBgdEaxfGhxmHheVyMvIwylm+cqUVZhC79QjW2KV2iRlNLkRgkhYfFcY45uig8/A7gxYHOtFLSIC5fbbuaKJ8JJZ9crsvlUCauG+DrHGu1AVpNkv/1Z1PEiDHEuXNSnBh/zKhJkwJwMTL63TaAqmc3AZYjIP/D4Ku8yENdsw1wtvZqHx0X69sCQoo18nF2E5eY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(316002)(7696005)(82310400005)(81166007)(54906003)(478600001)(356005)(8676002)(82740400003)(4326008)(70586007)(41300700001)(70206006)(16526019)(44832011)(186003)(26005)(6916009)(6666004)(36860700001)(5660300002)(86362001)(1076003)(40460700003)(2616005)(8936002)(36756003)(83380400001)(2906002)(40480700001)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 02:49:16.3868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8df4a1-b088-4af3-d8d9-08db08b5e745
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can suppress the warning caused by version mismatch.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I5e62de359015ac93b2dfd6a257584a5e6d38e1f8
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h   | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                 | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index d6b964cf73bd..4bc7aee4d44f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -123,7 +123,8 @@
 									(1 << FEATURE_DS_FCLK_BIT) | \
 									(1 << FEATURE_DS_LCLK_BIT) | \
 									(1 << FEATURE_DS_DCFCLK_BIT) | \
-									(1 << FEATURE_DS_UCLK_BIT))
+									(1 << FEATURE_DS_UCLK_BIT) | \
+									(1ULL << FEATURE_DS_VCN_BIT))
 
 //For use with feature control messages
 typedef enum {
@@ -522,9 +523,9 @@ typedef enum  {
   TEMP_HOTSPOT_M,
   TEMP_MEM,
   TEMP_VR_GFX,
-  TEMP_VR_SOC,
   TEMP_VR_MEM0,
   TEMP_VR_MEM1,
+  TEMP_VR_SOC,
   TEMP_VR_U,
   TEMP_LIQUID0,
   TEMP_LIQUID1,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 913d3a8d7e2f..40adc4fa808a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -28,7 +28,7 @@
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x34
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x37
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
-- 
2.34.1

