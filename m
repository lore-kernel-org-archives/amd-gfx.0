Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9981EC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 02:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94261122B9;
	Thu, 28 Mar 2024 02:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBVFEEoG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E051122B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 02:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND9+MINaGy+rPqckd08ptw4wFU+e/ETh3oTXsZQ8ycqfupWGjQTttLWlG/xg/4r6aWXNeQ+AKN7J8GkNt4Qc3fw+UUPr3oRpvblkSwOnI9OvKOVJS9EgifJzq6ybcvewI1wVqiaYap3D5q9336zh95pHTAcBt5cqlptxtVHR/sj9kxyAfmIhhkV/9tPg2/I2YRmpymHZqbqBvxYpe0Oy9QClloAH44wsQksM4Pqyy7hW8XvxxB8lw+L0aqJ4p93K7lp3sIECaIerOmCmGFgda88QQxh1d3le3sH4Pbtg9pBqOIiZfPYa6hApVu5x2E9M0bkgl5GvAI0CJkmoN1VCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tZMQoe5iB2/Lmb03UObcnvsO92YA2S3QsdckFsddGA=;
 b=CVYx4tlg50lLjJeaYtL1n8DJ6/pkVwIv75cTcgu+TpwMG6AVsFwYhGjP8eWK5mh21iBxEb5y5fKx5RqNiVpiVlB+7ehiPR/8jp9eq5X5yoGoKmxQdarGq17cQHW7zWR0ov4X/1QPOPk73g0tp1Gr2/s5K47pYlJ0mRUnSeE76iav+58dq5DtyYzvEq/9UalEx+noVmU7tgLz1ipQB1xP5ncZAFOkLaf2r/Nuqs5dzGxZx0zRKD+aOerRLtZWYetNwIfeauJwUEfriItbglbtyZhotGRegbOlCQ/0Y/xf26u9P8gkacW6M0Koa/gh2LisIdrOyOnwbj6JlZSCqUbS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tZMQoe5iB2/Lmb03UObcnvsO92YA2S3QsdckFsddGA=;
 b=JBVFEEoGzyT1ZAe6MFsCgkAbjYfWNw+cabGz039z4sQ7rP6rM7Wb49Yr+U7Jz/sHw6zxLY3Sin2//pc8Qml+k+ioQp4d3u0YVSwaS5qybnWQpiWJAkFGovwMr5AqWvpBVeADjEF5cCJS0l7AeCGGPcYeckoQhM5LVVi99DU4cZA=
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:36:10 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::9b) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 02:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 02:36:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 21:36:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
Date: Thu, 28 Mar 2024 08:05:42 +0530
Message-ID: <20240328023544.820248-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328023544.820248-1-lijo.lazar@amd.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eebd230-5ca7-499e-c8e6-08dc4ecfd42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrpC0Z49ml4AWA9+h7L1oYS0lXbqFlRyrSj0wqWs7ojh2PC+jwSRuuZZiqnY9eJKX1R906MLStG7dmMkN48OlDqK/Rkmhq+DaQfKxYupYkZOqZGccT/DJuqRtjK44VLIeKyfrx0yJkm0r2/XFo6KpCNvUs/R4LAVmQT1R8mp4wmFL1FzK2LCc745ViI2KMoPjBV27R45I3UEkbXcCKufQ+jtABl0YroakjP85t0CSgvWNLUXynn/eAlYFqnAXzi9saLoJPn96/uQFk5+AYPAWCbVRqUFYfUr1PE5niK0zz59CViVTNMSuA4MOZIrMlgDbitkXS82jmAqEze1GvprzJb3MtX8hJZcxfc7EGAXcssnuvDEZP5/aObClx1gQwSSlW+sLbI6mM2Wm+H6RtXsVm1oL8WXRBkth9fOGaP3z3x+31ONgX7JlejURP7h/PO3UZ4m9Q1WHVXX/EDf0VWPsJE9aNpQcNlzsJZ1Zyw2sjJTHswGxO0teRSiwLYkCmVXETRqhcnocyn6Y6ss6JddXbOFY/s2Fm3zlJvCQDoDZO0ScPeQWVgC3xBfwDY7Xy/p83YcEUD6kHZG+Eo6G5+bqSudS4fV7VU/cIf21wnJXmpgAeyMFa1IWt27FwPlcYus3kJJut+LEvT0ZuqShZIF6q68ugSqVLAz/msOYtfAt0zBm5mcGhc1QStVXKwReh9qz+QVRbjkzOA0r9aHfRNGGlwPoVgRkUdEY6nSxybgSkLLi/hptAABAgn/X27cTkr2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:36:10.4422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eebd230-5ca7-499e-c8e6-08dc4ecfd42d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add flags to categorize messages and PMFW capabilities.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..aa835df7ba1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -458,7 +458,7 @@ struct smu_umd_pstate_table {
 struct cmn2asic_msg_mapping {
 	int	valid_mapping;
 	int	map_to;
-	int	valid_in_vf;
+	uint32_t flags;
 };
 
 struct cmn2asic_mapping {
@@ -538,6 +538,7 @@ struct smu_context {
 	uint32_t smc_driver_if_version;
 	uint32_t smc_fw_if_version;
 	uint32_t smc_fw_version;
+	uint32_t smc_fw_caps;
 
 	bool uploading_custom_pp_table;
 	bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index af427cc7dbb8..c48214e3dc8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -445,4 +445,11 @@ enum smu_feature_mask {
 	SMU_FEATURE_COUNT,
 };
 
+/* Message category flags */
+#define SMU_MSG_VF_FLAG			(1U << 0)
+#define SMU_MSG_RAS_PRI			(1U << 1)
+
+/* Firmware capability flags */
+#define SMU_FW_CAP_RAS_PRI		(1U << 0)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b8dbd4e25348..3227e514e8ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -437,7 +437,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 			return -EINVAL;
 
 		if (amdgpu_sriov_vf(smu->adev) &&
-		    !msg_mapping.valid_in_vf)
+		    !(msg_mapping.flags & SMU_MSG_VF_FLAG))
 			return -EACCES;
 
 		return msg_mapping.map_to;
-- 
2.25.1

