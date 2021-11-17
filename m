Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE411C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 10:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A98361002
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 10:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A98361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1473E6E413;
	Wed, 17 Nov 2021 10:11:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98BB16E413
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 10:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQitiZkcM+xnHV9RanNwkeluX18iIhqii631r1hLI5LFVwEZez6tNZ0B4H+zPq/JU7RImfcxoth4j7orrVqvHZfFt83PS4Wg5bRdgvqRyJRdv80AzRz3uZmfOmbKdl05Cm/7F0XOo1fg7+giNOQubfQ9E+uDxzT/WjAATIHfH1LwN/c2zPLt6Y9rWjMjSfeGNIe3sgEXVX201txyY3yFlQVvnDPL9ZqCAQZP4q2nx7qYYTXRwNr/gIh6voEwaQWugn454VRwb8VsfdUpMjwAFbMPY4YukCm3RRX7eYC916u28DrPZhllJaUONOmRVsaWw1/5EZc/KEX3nSgaCJZxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJtL6ucfI9HvEHvzvA04mrZDedjNvvhE5pjGlinelWE=;
 b=i2+4fBNJkQMVdbZv6k3qody0la/E11/FHwBcq6OTiL46JStbs6uzHCCbDBKcWP4d5YiKdFjuckr/E7jakhDs6trrbTJVOMnoVTWY7wvWNMLEIsedNA50mpwr7L3i7AaCfZVaW+z2MkzQMWXmOO4tYTqCF4MrH/BrdNLE0HQkWdhC19mgZ/rRw4C/lkzWiI8iwoAWHb4Jf+unTma26ONYPIKWlO3khifY7kWNGvByvO3fiGYqKTFbMr7AXXPQWjfMc6zaiT5DgFjrHE2PfyE8dfp5s2dfnXU352HD4NVSjKVR0LoI5M30KXElYKfJSpZ52BYl2t8UJfbetbMN146Mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJtL6ucfI9HvEHvzvA04mrZDedjNvvhE5pjGlinelWE=;
 b=H4GYF/+SSKUaOkuQr3Sq99lQSuqSwfCVyphp1kWiijIWD7mPlUIWZYSEOnaf09uEJBW0fFX6L+s/xfB6QHla5xz3kbF29xeqzlvxgNTzImZp4Bhwj1AhRHI6aoI8UbSf+aQSva9vL7F3Cl3movAYNzRDzLY8fbshYSHzH/+GmcM=
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by BYAPR12MB2741.namprd12.prod.outlook.com
 (2603:10b6:a03:62::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 10:11:39 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::26) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 10:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 10:11:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 04:11:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 02:11:35 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 17 Nov 2021 04:11:33 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 1/4] drm/amdgpu: Update smu driver interface for
 aldebaran
Date: Wed, 17 Nov 2021 18:11:29 +0800
Message-ID: <20211117101132.6568-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a27b931-11b6-4722-15e9-08d9a9b2a4f1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2741:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27416F2D5217994CB0F9E5809A9A9@BYAPR12MB2741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNHKQntkxDvxnMLVLmr1yWf1GN7FJfVF8TQhAnnripCFfK3+9BRNzEo8M5UhVS668iXbQe8y6vPTz0hTi5/GTDQvzyNPxh0vNEVC/9KSAwybQaibNxqfqMG3YBe9yyw8F39KeKXAf5kihXTBm2UFc4fcKJk2HeSYGbzFYF9KZlmJkBBHd/CgRCnySgd5qOS4vu+23py9MpgydQ9BaDcBgNxVMD1TP0EsEUocFMWKBwp6OhiysZk2yAGaffdzX62VHpKy/XJ6CnOIBgl5+jpUHYhHyjljT9cXJuqdFWa80RyY1/zN+7XmS0FbPkSfpuBUGy2JLWwUGqutaJj19PfmlXlaw+fvWtXYo5z7dMsNOx6sNfiTixiPFuP0OaN12I1kHKxeqR3J29T7o60USH5by//KEmCo7xJq3HEHq6pWDgOVu51sltcdcraj6qvpmUQBjIow6vJgIx8zY6Y10u7SVrOs04MjxxZF6nmcw5D3aMZndlJO8Xt+MfSb4+ewNcysdFX8E1JxB8aoBin7BPDb30Rkiu0XVayuUCCieXHvF3iZ6xMC6+x9pQo/jS8XQto4cliGEkee7CbHkDVbSxLjsjxJTA9mHW8hBs/e1A+ca6py/vapd44JNTJXqcM4MdH1aJ01furtbhOKfjABcUDSX13mnbKMstr49sIYfTQEv7ES0hhkUtKfCxvsyZ2R8DImhLcm5J5vFYMrbjLeTRu8WLXmaCECI9qV441mwkYH7m8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(6636002)(19627235002)(186003)(26005)(47076005)(8936002)(83380400001)(1076003)(70586007)(316002)(2906002)(2616005)(356005)(70206006)(81166007)(7696005)(508600001)(8676002)(4326008)(5660300002)(6666004)(336012)(15650500001)(426003)(36756003)(86362001)(110136005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 10:11:38.5732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a27b931-11b6-4722-15e9-08d9a9b2a4f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2741
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update smu driver if version to 0x08 to avoid mismatch log
A version mismatch can still happen with an older FW

Change-Id: I97f2bc4ed9a9cba313b744e2ff6812c90b244935
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../drm/amd/pm/inc/smu13_driver_if_aldebaran.h | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h         |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
index a017983ff1fa..0f67c56c2863 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
@@ -140,6 +140,8 @@
 
 #define MAX_SW_I2C_COMMANDS                24
 
+#define ALDEBARAN_UMC_CHANNEL_NUM    32
+
 typedef enum {
   I2C_CONTROLLER_PORT_0, //CKSVII2C0
   I2C_CONTROLLER_PORT_1, //CKSVII2C1
@@ -507,6 +509,19 @@ typedef struct {
   uint32_t MmHubPadding[8]; // SMU internal use
 } AvfsDebugTable_t;
 
+typedef struct {
+	uint64_t mca_umc_status;
+	uint64_t mca_umc_addr;
+	uint16_t ce_count_lo_chip;
+	uint16_t ce_count_hi_chip;
+
+	uint32_t eccPadding;
+} EccInfo_t;
+
+typedef struct {
+	EccInfo_t  EccInfo[ALDEBARAN_UMC_CHANNEL_NUM];
+} EccInfoTable_t;
+
 // These defines are used with the following messages:
 // SMC_MSG_TransferTableDram2Smu
 // SMC_MSG_TransferTableSmu2Dram
@@ -517,6 +532,7 @@ typedef struct {
 #define TABLE_SMU_METRICS             4
 #define TABLE_DRIVER_SMU_CONFIG       5
 #define TABLE_I2C_COMMANDS            6
-#define TABLE_COUNT                   7
+#define TABLE_ECCINFO                 7
+#define TABLE_COUNT                   8
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index bbc608c990b0..44af23ae059e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -27,7 +27,7 @@
 
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
-- 
2.17.1

