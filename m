Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F47CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DCE10F06F;
	Tue, 26 Apr 2022 18:27:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E6810EF97
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU8NjFS+LMnmZs8MyAy+Zze9kk8hlggVoAHiy4LzHZE+Ah2qtUFRFzuYSf8EmAGzOVP93AcY+KdP+Y2yuzpLBqxtHJygIyV3W2I479qGpc/kNtac7aNTq1UJno7+hM5eHtXI2ZoGgd93p/h2wY4dc5NQtGSGUDPQrwS/FEA7s/o9qZpX5GIaLFGdOqtmQcbKcM7PCTvV/uDwLuJvzU0LstLQALSNNy6UOHspFEg52TShZEmvmc/AzwxwK7QeGdqeir0cCprmrWVJzZceaYR1lwwoacHotQlODLpnj8yD+k1JXK1wb34cYzT0DvLE2YmwRC/Z7qsVZdTe0tdjF1R/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDJ3Obseuqu1Phkq10azUjZyL/eJefAtw3aE8q3kTM=;
 b=gKfaN0iM7VLHrtVBSTA9nqKLRrE4K52VnNyQ6CBshBBp6vpkzVNaGhZa4NkfaobnMJBDkhthyA4kyvqII5mRKf0gkWf6IdR9pNLoyFHfL4h7qydkp5MVYWMawnRR9cFAb4ZH0jLON27/yKbM6HaUq8DrUcrxna2jim8ARLj/s6OkHhXr7UEZ+P6SBJrt+bgJSI/AthTpWe2b0Sxb/R4F6KZubDHauUcDRMs+CUt+nNhiv1SgoBObRpvlt36lh/75MVhXuSap48KU0WKIeytNzdLsXxpsuKH7lCjOd0ZEpcS3/Amu73EaxWZka8pqOR9Y6KlCbYPUwCM1W3TJN9zmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDJ3Obseuqu1Phkq10azUjZyL/eJefAtw3aE8q3kTM=;
 b=Vsph0F1TU+cat+Yfw4gi5J4yWdIiIJj5EQ80A7O4Ya4OudKFswm582G3aiQZ4cROa2JX24TW/j4+/l6Lx7UIzR3nHVgOsf4kt3NPUHclIgwXvfKa8vrK+t7tgAziQDmlRHR6T/2U8v4FVoaLASWpbYse4BJAmpo9InmXtAiB7Fg=
Received: from BN9PR03CA0731.namprd03.prod.outlook.com (2603:10b6:408:110::16)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:27:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::3e) by BN9PR03CA0731.outlook.office365.com
 (2603:10b6:408:110::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu/discovery: populate additional GC info
Date: Tue, 26 Apr 2022 14:27:19 -0400
Message-ID: <20220426182728.3006737-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15b9d0a5-cede-463f-248f-08da27b27361
X-MS-TrafficTypeDiagnostic: DM4PR12MB6064:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB606406BAAF644578CD7F4DF6F7FB9@DM4PR12MB6064.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMIBWrd+8S2H54gbHhIDbEiTP1Q9s0l1eq3B1SbX7/D+DsYk64kKyNZjBIDv4hbPRilExA340qAdXenWUyBcyWMhzLGUI2/CpOHkEWQJkAZ8pTaOB2O7w9BECPkORituQP+pwFCVgUqjANnRf5O5OxIPXcUEC4j6bGLUzMPw2XLthzVrFclE9fCHFYtze1cgP27onMjNUh0YVEpMMOn1KazegeSfqQO2EXO2XpDdM5eMWMQTXVpDy7IqING0vGRvR/ejHid/Awj8GN481e/i4g04MxvmNcaTwFzlJUC9+aZhV98SW18JctjFllqW/uDNy3MW1HwBOzFuKagpvt+RtMkO9roWEBh9W/ZhFGDytPSX6K4tjwR2yi0goK/PKKSLmlfiR6oIfQWFGb3BwNNIw3wWEleOUnGkcuPedWXJps2jqwwm96ekc89g8CqIMmTT7s/nDM0kmYvubAGUUgcpUF6JXO5wdH5uxF/+4HlgWXUKfU1kN5m6rgRfhwY3Ks2o7hvOPCTe3crY5RAkLnDDCvuHBiMUlHL2iQdsnqqiIG+KiAehHwqVSl+xUxgGHLL9M4VG29+Sq/CdPlohXdKCWqyOwuIL/AVtbmtheUEnEvyJPWDP2Pmddh2m93S97jExEx102bhI2wCkSpkZxJUMtV5LrDiiBvyuLbHIC9LfVK0RLZjH0d3iUvczUp3MM5ivSvlX7ynrVLcYGG1MMcTAUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(316002)(508600001)(8676002)(86362001)(40460700003)(47076005)(81166007)(70586007)(356005)(70206006)(6916009)(36860700001)(6666004)(426003)(5660300002)(336012)(7696005)(2906002)(36756003)(26005)(82310400005)(83380400001)(186003)(16526019)(2616005)(8936002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:41.8973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b9d0a5-cede-463f-248f-08da27b27361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From the GC info table to the gfx config structure in the
driver.  The driver will use this data to configure the
card correctly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index aaf2fc6b1a82..4871bd84438e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1154,6 +1154,8 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 
 union gc_info {
 	struct gc_info_v1_0 v1;
+	struct gc_info_v1_1 v1_1;
+	struct gc_info_v1_2 v1_2;
 	struct gc_info_v2_0 v2;
 };
 
@@ -1190,6 +1192,21 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v1.gc_num_sc_per_se) /
 			le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
 		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v1.gc_num_packer_per_sc);
+		if (gc_info->v1.header.version_minor >= 1) {
+			adev->gfx.config.gc_num_tcp_per_sa = le32_to_cpu(gc_info->v1_1.gc_num_tcp_per_sa);
+			adev->gfx.config.gc_num_sdp_interface = le32_to_cpu(gc_info->v1_1.gc_num_sdp_interface);
+			adev->gfx.config.gc_num_tcps = le32_to_cpu(gc_info->v1_1.gc_num_tcps);
+		}
+		if (gc_info->v1.header.version_minor >= 2) {
+			adev->gfx.config.gc_num_tcp_per_wpg = le32_to_cpu(gc_info->v1_2.gc_num_tcp_per_wpg);
+			adev->gfx.config.gc_tcp_l1_size = le32_to_cpu(gc_info->v1_2.gc_tcp_l1_size);
+			adev->gfx.config.gc_num_sqc_per_wgp = le32_to_cpu(gc_info->v1_2.gc_num_sqc_per_wgp);
+			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc = le32_to_cpu(gc_info->v1_2.gc_l1_instruction_cache_size_per_sqc);
+			adev->gfx.config.gc_l1_data_cache_size_per_sqc = le32_to_cpu(gc_info->v1_2.gc_l1_data_cache_size_per_sqc);
+			adev->gfx.config.gc_gl1c_per_sa = le32_to_cpu(gc_info->v1_2.gc_gl1c_per_sa);
+			adev->gfx.config.gc_gl1c_size_per_instance = le32_to_cpu(gc_info->v1_2.gc_gl1c_size_per_instance);
+			adev->gfx.config.gc_gl2c_per_gpu = le32_to_cpu(gc_info->v1_2.gc_gl2c_per_gpu);
+		}
 		break;
 	case 2:
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v2.gc_num_se);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5ed9b8a4c571..ad8e7d486a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -183,6 +183,17 @@ struct amdgpu_gfx_config {
 	uint32_t num_packer_per_sc;
 	uint32_t pa_sc_tile_steering_override;
 	uint64_t tcc_disabled_mask;
+	uint32_t gc_num_tcp_per_sa;
+	uint32_t gc_num_sdp_interface;
+	uint32_t gc_num_tcps;
+	uint32_t gc_num_tcp_per_wpg;
+	uint32_t gc_tcp_l1_size;
+	uint32_t gc_num_sqc_per_wgp;
+	uint32_t gc_l1_instruction_cache_size_per_sqc;
+	uint32_t gc_l1_data_cache_size_per_sqc;
+	uint32_t gc_gl1c_per_sa;
+	uint32_t gc_gl1c_size_per_instance;
+	uint32_t gc_gl2c_per_gpu;
 };
 
 struct amdgpu_cu_info {
-- 
2.35.1

