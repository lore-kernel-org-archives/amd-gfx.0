Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EAFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DCD61B62
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48DCD61B62
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B326F6EE30;
	Tue, 16 Nov 2021 08:02:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8275B6EE3A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex14waP1ImH6dQnuW1Iyd6JY2qzUFE3Ba88T2/rBffYVckBM3cg8R/+0NirvkaehBITvB/6J0P0DPrZtSLm3uTWBqWFdrLvvWvC65ZU7Zb3KH7oCuNWS7mfOGW/YIzTekW2W8rdgQxZswpOD2Ae/DVOfAwdcpqnYB26Evg6OVyvlKeNZpKpzm21LKdqnM07J6T53ljCxlBdsWFtqWB8ibNhgt9ryV/xBhfEAzrp3pjNjn0ZZOYKlzTy0fGuttPkpwQ/qIn+u3YpexE8o6+7TXPkpFWf5PMHxRW5/jqF/f6/czQ0TU6JvqWKmfjwt7/sXKEUISW0Chdlz5G33goQ0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O1wwVEvf08FWgs8KT/jhj6jodDJBILo7OHxSmiL0S4=;
 b=AKkgJTpE+FAPyYcudOc0cOzOB7Q6vvwFDYS9KevNuxmGk7PBKnVWBLwEpqPouuBublWWJb+7kzunXRXci9h21fCltTjyCO5OV1rvrEiRZLkHRG4AmsdxgsHlFtuTf5JANVmXLBEZqBwEPYXg03JX84lvwM1jIQSWGIgaYtFhV7+0m7OCRhTmlLEM/8QXoAQLdRzvnc19UYpeu3IT6Jc5BB47DnmejfN+Ev23YEQLnWy1E5zU86CNzvOimsWLRBg2T/xJFea8yukiO0vJlpQeejdBhL8znwYnUv8wBFk9m53yRGunUcEw5AJv/8n6sf3r2dVq0WWVOny44JC6EA6LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O1wwVEvf08FWgs8KT/jhj6jodDJBILo7OHxSmiL0S4=;
 b=qlCuqXwrqzApB4lUWtr+Te/2l97pJE0HW7hMC2gWWzBEL2rwVXy9L6IMqdXJtGciZOWC6gkMii3art0OQVuTGeyDws7xd/jev/9JnSahNebJFrn1gF9PleZe9DfG4YyfM3p+U2mq/9QsumL5nCR2x1YlqZ+v8sXwhVjRuooAGt4=
Received: from CO2PR04CA0174.namprd04.prod.outlook.com (2603:10b6:104:4::28)
 by BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 08:02:52 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::bb) by CO2PR04CA0174.outlook.office365.com
 (2603:10b6:104:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend
 Transport; Tue, 16 Nov 2021 08:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 08:02:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 02:02:50 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 02:02:49 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Tao.Zhou1@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix smu not match warning
Date: Tue, 16 Nov 2021 16:02:47 +0800
Message-ID: <20211116080247.32143-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 962b4349-07d9-4b00-0992-08d9a8d77d1d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3124:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3124DBB62577973EF615082E9A999@BN8PR12MB3124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CH+kA1fOmOcYgeuBA4UUr4o2FBNdV8Pv4Ax1jFhYzmKIk83AazG21TB2zebsQwOoPua+uKQXr+O/ZH1U/wxS2CjSel3v49GSRZCU2rjWanyYG0s/MbhSjfbDV/4/OXMSeqtc2Dx1NI4n0wzCegOyOFRN1nd1iIX4cAL0DNleMSNHEX9srdeATzpX4JA3PVyIcsyj5BfLqwVRXE1sZhVgikb2I7xChTAJJSYAdysLpggBSoz+H+sKVzzoZlDdqTH9D8RSWt4sjMvZuE7J/58XmuXRAMF1w8sKutarCjQmYlwioFmPNblX3blsg4vknqEYYUKJqk+rHgMznIh3HxS683EDRUSBZYQODVr11UzRbQGIduGlZXs0pwa4Njcklnry9qOnPAxTpJkQ32wWkE5GIPp9DSYWgu7A/zwoBsAqw0POAYH4UvQolgvTAg7xjDuMlonJ7Fx9Q3t/jUPhvqhw/Hlmp8YfWUL1M6QwoflW1Y0sTITEQDBafUdI2MWP3coWTwm9tDk45qXt9tdZCypf6QnR0qiQ6Ej+UOFOqJbVycZjtfXLWF/AYkq80pG5lWPhWdp2cE1RJxESQ2CeGNHu4Oxkby7r8D/fiRBBWG95Nzf74NkTvb7mhelzgGYNEXFadHk70aq8haAmAqlvrQXC7emNsG4+huXUZ6hOJeCLVyb3bYhB9ov7sWKXuh4jKeFJQGIEk+efV53mYPE/AN2rO3RBuw/RMPuvYIj4wncCPw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(4326008)(336012)(19627235002)(2616005)(6636002)(356005)(47076005)(81166007)(1076003)(86362001)(26005)(70586007)(36860700001)(426003)(82310400003)(110136005)(36756003)(5660300002)(316002)(2906002)(508600001)(8676002)(8936002)(7696005)(70206006)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 08:02:51.8386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962b4349-07d9-4b00-0992-08d9a8d77d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3124
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

update smu driver if and version to avoid mismatch log

v2:
    update smu driver interface

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
index e5d3b0d1a032..2e35885c7287 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -27,7 +27,7 @@
 
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
-#define SMU13_DRIVER_IF_VERSION_ALDE 0x07
+#define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

