Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D5C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 06:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BC610E22B;
	Tue,  6 Jun 2023 06:53:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C3B10E22B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 06:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq+2i+emLbtsNsQpQhxMDP/sQV1RPTAfQs+2c8zuONl0PeYBNIVLMpbUKhV/YWB+6kp/NgT1ndfV9Oc+XLIQ9f/P1gFnRfSWrBmH9Xj72FLBnxlFVWJNnLER5qA+GjqFLp/fxo0d77wNg3yZ7Y9ijPKsJpnvmnNgFhbVvgNDrzUo3J4Bxk02eBHwuLCPUfqUD37OiqN3Ya5XFIjRbQGJT4F4tS87pCSRDPvrGuDaQOHFcaDtEC9SBm0HvQPI2dEEkN9DaAta9jBzUBUoYvE0eAihIiQSLJZNpeLRBIqgRD8D9zvSnDwsG+mOYhz/Q/MKCmZqNSZKzcpOSNr09KuKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN2hjXcfhTquJN0rDxlClT7Y16ujBmcsWCcK04w+5GE=;
 b=Kne0pi1oOeStEAd4dYFsXLjYIYeOYA9K25slwYMANP78vyhSq/XbhipKE7U+yDYkSR6/5drZq5MAyuwvAXeoXUHiM9sWBBvZLi1V9/5+0P90wBdU5mvsWGyWd07yVUskXPhD6BpwuIE4YOhcdCYiehq3nil2lOfxTdUajvp4MsGFvYQDismEH9LE0Th3VtytFwIA8pQJ0SMoVWcSzOs4xovnV+s4c49ohN2JsOXsahJjFCwgPMpJr1GPUljTHWZ1ReVyX8DNv+HTT+hmYcAObTSmlMCfVvkPD91mDtQH8SG8mCpfp+eJEr0K7TPVa6WhhxRPknYKFPAijrrV8IsUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN2hjXcfhTquJN0rDxlClT7Y16ujBmcsWCcK04w+5GE=;
 b=pBCYR5ztrLHlJzKxMdMDssUmkHhC3SCHIYbDL3xtvPzIalJDqZGDaCLGhOsHUySmdhrN4dbHAn1OW8wuESC3sDKKpUsLibGvnKuzH66p5y/OmSmR+B7w6wOzANg3B6AkxDrRzfxCHprtRA2XHrJZpT89JyM2ChJ4FWY8ONWsQFA=
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:53:00 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::18) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Tue, 6 Jun 2023 06:52:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:52:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:52:24 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:52:23 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init header
Date: Tue, 6 Jun 2023 14:52:10 +0800
Message-ID: <20230606065210.3103195-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbeb331-b06e-4074-0e2f-08db665aaaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLZ7Zssvw1ZrSsBmO0sFKQ85WPGi+VS7F86fsgABPcU7ECGp/Cb4LyAHPs9gWYLmiiQKi0xLb9L59dIL5vIYV+S7om51gFtbRVC0oeZBYABpW4R1SfG0mhmRC0B9Ot7JxRZinczmEkMPuMHP6U9hR/c4PbA9NCo+Q1oe3D9y6gWQMKE/EvHDFRCAnDASb8ii+4XuI6BAcBeNmzfMeo6wKmR830uz/XcpHkHxiXL2FONaB+UWYs1j4NgVqS4iOAJkbzeM0gOHirNnN/IaNCsioqGw+7yOWeWPMBrjXObeTGHw/+Wcr79qVGYXU7P/CgK4z0Un5JFZJP3LI+40GrXfSkxHktfMHEUiYYTDpF2c2UGg099KDkCfvUjrV7Jdf2yaugJbQTT5JLV/A8xdruY9+/t1tL/PwaeCcZ4gT+bqHzyE3h9HUS13qyNZ1Rtag1KhE3XumSSi5DZfnarew1HiBpFGqTLPGrj4vzF7Vlkh4Qi4zutoOvAhwj7IqHTrTJGxezmDk0OJ+KGdhayE5Ob4gj5WSb3Fa9/UqCXXSyBnG1R7oSmVfS8aM6qmPPqrbhNTFJZycXgCID4RUOREawMQFjlK9hCHlMAQIdK41qXQEa7R++Z0RZJNwsCZbNE963TNvraL/3ptK2DBhtgBacZnaekSKgaa00EQiqouCsmZt2E7ijGaWmx+QTWm2N+KLFnfskX6EsVOp9VjINxKxSrPDqLhx1+AbU62SpuxwtKkp4HwzYMB0xkSKfdpS5Cv9yKtvtHV4Arx5CAhf1CP6WZ3IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(1076003)(186003)(26005)(2616005)(426003)(336012)(83380400001)(47076005)(36756003)(6666004)(36860700001)(82310400005)(7696005)(2906002)(8676002)(8936002)(82740400003)(40480700001)(478600001)(40460700003)(6916009)(5660300002)(86362001)(4326008)(41300700001)(316002)(70586007)(356005)(81166007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:52:59.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbeb331-b06e-4074-0e2f-08db665aaaba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the header, it is version related, shouldn't use MAX_VCN_INSTANCES.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
index 3e4e858a6965..a773ef61b78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
@@ -30,6 +30,8 @@
 #define MMSCH_VERSION_MINOR	0
 #define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
 
+#define MMSCH_V3_0_VCN_INSTANCES 0x2
+
 enum mmsch_v3_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
 	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
@@ -47,7 +49,7 @@ struct mmsch_v3_0_table_info {
 struct mmsch_v3_0_init_header {
 	uint32_t version;
 	uint32_t total_size;
-	struct mmsch_v3_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
+	struct mmsch_v3_0_table_info inst[MMSCH_V3_0_VCN_INSTANCES];
 };
 
 struct mmsch_v3_0_cmd_direct_reg_header {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
index 83653a50a1a2..796d4f8791e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
@@ -43,6 +43,8 @@
 #define MMSCH_VF_MAILBOX_RESP__OK 0x1
 #define MMSCH_VF_MAILBOX_RESP__INCOMPLETE 0x2
 
+#define MMSCH_V4_0_VCN_INSTANCES 0x2
+
 enum mmsch_v4_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
 	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
@@ -60,7 +62,7 @@ struct mmsch_v4_0_table_info {
 struct mmsch_v4_0_init_header {
 	uint32_t version;
 	uint32_t total_size;
-	struct mmsch_v4_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
+	struct mmsch_v4_0_table_info inst[MMSCH_V4_0_VCN_INSTANCES];
 	struct mmsch_v4_0_table_info jpegdec;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 70fefbf26c48..c8f63b3c6f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1313,7 +1313,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 
 	header.version = MMSCH_VERSION;
 	header.total_size = sizeof(struct mmsch_v3_0_init_header) >> 2;
-	for (i = 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
+	for (i = 0; i < MMSCH_V3_0_VCN_INSTANCES; i++) {
 		header.inst[i].init_status = 0;
 		header.inst[i].table_offset = 0;
 		header.inst[i].table_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 60c3fd20e8ce..8d371faaa2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1239,7 +1239,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 
 	header.version = MMSCH_VERSION;
 	header.total_size = sizeof(struct mmsch_v4_0_init_header) >> 2;
-	for (i = 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
+	for (i = 0; i < MMSCH_V4_0_VCN_INSTANCES; i++) {
 		header.inst[i].init_status = 0;
 		header.inst[i].table_offset = 0;
 		header.inst[i].table_size = 0;
-- 
2.36.1

