Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C890C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000CB611BF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 09:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 000CB611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9584A6E8FE;
	Thu, 18 Nov 2021 09:33:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156676E8FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 09:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo8qjAdV49d5rFj6da4psqmrQxorMmOSICNl1tGRssjiTTTf+CL605FtoYVh8ka5Noj/JB0vbmpT8JCUUUJGeynZ3eHAZsmSKCa0YPcfbP5FKOgQrqhdGlFra9Hevm+4hOrIbE/79GrQgMIAAKnKWeisw+Wdp2fV/U5JGXc0HaOBCx7ZFhDPEfDuCa1tTOTmytFkoXgFD7KedpD/iKmIHHBpGqpnloe74bS5HA4MpWWjshnnQ+tFee5X62l+HXXgaeYkD6/G+LBpxjHRG+TBXS/TjBGLkd9YDbhqrOfEG6AWfDBsCq7Yfk8BhkpGnQk57QyuX/oa0wKreUicoZGEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJtL6ucfI9HvEHvzvA04mrZDedjNvvhE5pjGlinelWE=;
 b=USvtBoL29qVsHSExIs+tmBKUzN4OKD2+m0BT90EGxLbKOwEpzLJljdnKgwlGhDvAqlhVFSo/6vmCe/Pb1Sm1KOoJ3gR5S+n+KMCdC7l1Of8eiAasCwrEVEOD9iSa6zqxbIf8CGqJIIQAFheDgkyql8NgQDX9SI//iL8g6LOlJYSx8TcKWkSqjNlKZ2GoYzwUf9MjfKFlneL6uIGGIdlC2u/2n/hvURQzNJWYDfS98uJ7oiMXnztS8oTGvOWwFbzylWImlzAiAVwXBKEZXCfiV+Y3XDUgVyBwJFtRJoCh3xj0fxIiHpT7CYvoKSUMuZFquzInTngRsW6NXP6PYE8PYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJtL6ucfI9HvEHvzvA04mrZDedjNvvhE5pjGlinelWE=;
 b=jcDkVD5xMdHOPV4XDa6wxeClTCxLMD8+FURnNfWp8hVGSP4MTyZ4vJ2vMtMGwSu/XewDRzF1P6nJMEJoX6TUoitiVEVCPCfmzYC30ArjcOSxBD0zZI+HfeYj4+Q6BQZxT2/GtOO81C/9M+GUZBPsLAZiEz4z/O96NPVEpOyAlxA=
Received: from BN6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:404:8e::17)
 by BN8PR12MB3204.namprd12.prod.outlook.com (2603:10b6:408:9d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 09:33:49 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::19) by BN6PR21CA0007.outlook.office365.com
 (2603:10b6:404:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.5 via Frontend
 Transport; Thu, 18 Nov 2021 09:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 09:33:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 03:33:47 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 18 Nov 2021 03:33:45 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH Review 1/4] drm/amdgpu: Update smu driver interface for
 aldebaran
Date: Thu, 18 Nov 2021 17:33:41 +0800
Message-ID: <20211118093344.4361-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02d3cf5b-22ac-43e3-35c7-08d9aa76865e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3204:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3204C204ED9C05E2033259DC9A9B9@BN8PR12MB3204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/6b2dojAZJ3lwc8mw3Xur2tyV+nSeM0am825ePTAdihkwILd295cu3qDDIqMi2TFvNYWsjDUYA/unQFbhfwhsfoOqAeepPWIfApBnGa8EwjFP+D4s5dsml61lfFZpmWEoLFQePs5OqmVrBmRtX7yKCIhT1aaKBbQNOJvSgyUL5bTY/FhTJ7u8fHvEEVbY1rYQBpyE8YmXg3XJ/Oe4XdyoNhsw891yj2URcdT/oRpNLOe9C6V6wfifGjUKdKkZRkz7kjlWWtWJjZ4i2tvWTQSRVbo390X6THc88lVacxwBZS7qRHhHtU5nTbCz4xMpZhWC1g4jyDShUL2Fei3N5HN27wGWZRIgaqs/nJBOEK3HRWgCtw4flhNwSS+ozteLv9PXxoZL06pGvxAE19pNxRHdD67WN+fpMsufPrcTYJ+ESPHT8zzvvZKf2meeq5m2sR1ouTAneqsii8urpubZwpoWFw2E61rHNbpQlpQ18M75BIPIq50Yla9IdX7XojZtKxhbkbL96kOSU6bOXSzJ1+oc1F8nAwhb3a8bbUwUKEkad7UkDzrl7mBeVupRFUwr47ebZD3Jml77Ia2hXgKzqdzLt2vIitxmekYGlaKY6wNuXVSsAVtjvaMzm+hUycpoTU9mO969UtMzKrm9MqxQli2W3JRK+NJcYhsVVXLYtCwSmLUHeKbWpbM9486cxbiv90ylKPzpWpa0gX85XvGye7c+vnv1mMJKTCpUGWZU+DqMU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(6636002)(508600001)(8936002)(26005)(36756003)(19627235002)(186003)(356005)(2906002)(7696005)(1076003)(15650500001)(83380400001)(4326008)(426003)(2616005)(316002)(36860700001)(6666004)(86362001)(82310400003)(5660300002)(110136005)(8676002)(336012)(70206006)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 09:33:48.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d3cf5b-22ac-43e3-35c7-08d9aa76865e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3204
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

