Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C75C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 17:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914CA10E1E7;
	Wed, 23 Feb 2022 17:48:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D521F10E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 17:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+t+LfCHRJ2wL5qcBc4filCESCuXcpFbbpUqbjWjFa/W5D3tY2olZE60uWkXDrCamyebYOCQssXzUNcg/OI7VUEfj7HuPOXV5wfrlRdryxtDBVnJLFLpi8Bo6h+cGBnIDGqSk5+c8cEKKHYYkYIFYfSQCf6Qb8mEeny4kKu/8b5gNe4v2LOs2tVLEafAb+EM+sHd1sGVZs1FFV3OJ5aoMZfioMIB4obVtDzKTkvPZVd0umBAd6tP9s3KIj6d/mqy8npeZ555rH4SAaE30RiUepp5nrf1M/WBTDa7dCmmCL1HPV2uk8Y9p1xiK+dWYhyN0jcXVWwM5tqyAsVwPMIDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOLGpDmkWRHtTcCOer/5HXV34cumDYEBEn+gemwgI1A=;
 b=f8xFvfhwBHseWcH1IATRBwuCei8Gs4zd1wkm3moYlIt2en33r1qn8e9ic64GsFtgPAdXs8X/kFoHhB+V1hSSEfw6lpSoGNEezCUaMvUOtN1GCAHqyuuaO7xbX1ADyr315gxujxs3yH8cMkoyn6gYbInXHqpMqr4WOB1Q1WxEGXiesud5fIvnbedidvLNgpRLEoIKyDtEqw8AzrYTlVfxRFczWiGFQlCYdj8BhjC/nQDFk1gGYg8OhQc5V8KU2eVc5nuqHwTm7SNcyzwp7FK5SDGHHkVNt6iL1IJ9t0CbQjvXRJYUlxCm9kgirrkljGzMsO7z9vfhA/z09/fmNJ2tXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOLGpDmkWRHtTcCOer/5HXV34cumDYEBEn+gemwgI1A=;
 b=KQVL88FWJa3PvydlS/PBPAxyhNb3lvqzk1twit7HNbD8eOpEgbxzdXlw9YO4bv/AsqAh+zhCEP6WmSl6kmxqL3tnR00Ja4OpuHb0obocqdTJeXQw2kUWtXUoS3MHbi3tfHPar4Orm0DTh510ijGW8PA+VBznjY5F+8OYpMLSg4o=
Received: from DM5PR08CA0053.namprd08.prod.outlook.com (2603:10b6:4:60::42) by
 BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Wed, 23 Feb 2022 17:48:11 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::58) by DM5PR08CA0053.outlook.office365.com
 (2603:10b6:4:60::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 17:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 17:48:10 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 11:48:09 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
Date: Wed, 23 Feb 2022 11:47:56 -0600
Message-ID: <20220223174756.759-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218165349.7489-1-alex.sierra@amd.com>
References: <20220218165349.7489-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ee811b-eee1-4dee-ca07-08d9f6f4a858
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2790D202F29C61CB4F1AA48DFD3C9@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFgpkQffpVgrxTOzFjBTLoxUt84XAItHfaP5fUSAeOFhzqaFiBU+7E0HjInmezJnxkX/75PwhS78ogQeMPp1NaNUGrwJzIXaYVlRpexPJPSbhHNqLBxnoLCphqza5sjJXANoU1AeMc1BCagyt3r/jM0/EasrfOhJoHaNTvTeWGSyOVgAHuO5QhWncdC7ZWw+PL32SXZVsy3hnFZrGJrHMMXUO3wsfCN4HRVPFe46gFpmmQJwhSbZGWKp8p7I2RDkBrSF1Qb7hq3QnScpW2EjCqM+A+dDCyRt3UhcLL/OpiU/VMXn49eJDpJuvRdkyzW5OgKI5KrQ7Q8TuA45q5EUETNf3MSJIcUsTv0aHjiLgY4Hmm+2A78LTQN9m2mjEzntkF2vzRX5Sfg2npdiafY39LECWHsuYvZI/vvJCQWjLOfKiq0j+UDPF1T/qjBUHlDTnM35kF9QRRvAWZ7/bGwNtw3JpqCdDus8Ci4hgYj3dsOjjW7ocxOge04UwPCwSJHkIQftkmz0Kr3iijvLpDWbySeOPGee5n8tyytDzj/iN1LjKNG/GFt421Ews712p80+NmA2bdPfk+aXQcuQeWDubJOIvTdYTIE+R3EjitrVkvzsHGQ9f8XdH8OV9LBY5cIPxnXOVNjlSBYpfkB8Pl9fdZKe+/dtoo9SkyrZkRpDkV0jNn/2nhb8ARU4SsbwvooH6DRET4Pkqyxc2VqiXJCrUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(7696005)(82310400004)(16526019)(8676002)(70206006)(4326008)(70586007)(36756003)(40460700003)(81166007)(356005)(83380400001)(44832011)(2906002)(426003)(336012)(5660300002)(47076005)(6666004)(508600001)(54906003)(316002)(1076003)(26005)(8936002)(6916009)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 17:48:10.5386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ee811b-eee1-4dee-ca07-08d9f6f4a858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
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
Cc: Alex Sierra <alex.sierra@amd.com>, jonathan.kim@amd.com,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, luben.tuikov@amd.com,
 aurabindo.pillai@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This parameter controls xGMI p2p communication, which is enabled by
default. However, it can be disabled by setting it to 0. In case xGMI
p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
This parameter is ignored in GPUs that do not support xGMI
p2p configuration.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f97848a0ed14..7e95d8bd2338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -217,6 +217,7 @@ extern int amdgpu_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
+extern int amdgpu_use_xgmi_p2p;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2f8eafb6cf22..6156265f3178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
+int amdgpu_use_xgmi_p2p = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
 	"A non negative value used to specify the asic type for all supported GPUs");
 module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
 
+/**
+ * DOC: use_xgmi_p2p (int)
+ * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is -1 (enabled).
+ */
+MODULE_PARM_DESC(use_xgmi_p2p,
+	"Disable XGMI P2P interface (0 = disable; 1 = enable; -1 default, enabled)");
+module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
 
 
 #ifdef CONFIG_HSA_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 0afca51c3c0c..095921851fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -66,7 +66,8 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		struct amdgpu_device *bo_adev)
 {
-	return (adev != bo_adev &&
+	return (amdgpu_use_xgmi_p2p &&
+		adev != bo_adev &&
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
-- 
2.32.0

