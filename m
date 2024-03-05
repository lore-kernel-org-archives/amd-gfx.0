Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B32C54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590BA112B48;
	Tue,  5 Mar 2024 14:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WBvULiGN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C140112B48
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPMdnb/xJ4yg8PCcGMWfOrXGeh2dFO1c5Ztrp2dEXnHJcvnfI5ntKBrHoXMHWSycfS+ZSLO/bpY2R+CXjev3YAC9VJlbv9WT6QEbnzCZLFfF0fXyndzyHWIp1HFTubtUfaXK7TZdfe0Sq1X5XItgGAVmf7OONKaOZKimLBRawhiYRiNxZ7WZJpQTsfb9t1lVScTlDMNazOqNWLBmlPLGl2wVMgs7i+Za5XVM2QQddvXQHj5adyHXCkVCvpkMdOpn5/TdsIyNXNbdeJPF/nERsTjO1pIUNtHggdQWzDU5LqERi7037PUCHiYDsQk5J3ZsmG10TUuw1mixyh4nYkjisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faHkEXHztxP+JHFT6SO5wPbXolxgaf6qILcCechDWTw=;
 b=fHTgaAv+hGQqqhvvf3hF5hfErYgRN8Jge8vS/Ad9aNFvsM6QKEXiosNgDoWzH8IFC7U4QoD0tXMXgDiJAtGu+E67OaDJlQrZrWRHSyMPY+FnnYSI4HFw6FmA47hlhwyoTTXxWYUlY1mAOOWGG4a3WX3WZa4binjruuNWnuGlVPQ6NWAru1VNK8aLk1euZNAUvcUxrnMOOll4K6JuUH1UAjkGxi83f/FaCjCIi7qbv3yYnBE0XZQM0qaWQZGYoAbMb42OX0RDVTve2Zqw+4o+LgphxiH1/TvYmHIP347j1tnKXZ7nzjVQSc3Im/1yunY8Rzgr5NaJX+YrK25A07GZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faHkEXHztxP+JHFT6SO5wPbXolxgaf6qILcCechDWTw=;
 b=WBvULiGNueRhfDGp+WsYDSPFIdnUNE5gWxOycRH+FdlJMmJ8P4xCHfojUJUjrCfkNVHsqhGzW1LKOu4URcHAHxi7HX9+5w9SbfQ0YzBtfsN8VVzf3Nrf957pt7dQ0Xiwrw7FeVAmVgEg5kYiMgnKQAuYFPF2J8aFq7a3k3+8wQM=
Received: from BYAPR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:74::14)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 14:31:14 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::cf) by BYAPR05CA0037.outlook.office365.com
 (2603:10b6:a03:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Tue, 5 Mar 2024 14:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 14:31:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 08:31:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/vpe: add multi instance VPE support
Date: Tue, 5 Mar 2024 09:30:48 -0500
Message-ID: <20240305143053.1262593-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8413ee-c09a-4983-0afe-08dc3d20e958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ45LZXqm86QyPkbqmEXhczMxcLMEbjcqbukTvNQec+bTxaKFTBQW4e87FwmZkAuHSobqk/U7Oavk4Zfvfj+YyxPdUracJJ7VXEKfN0gUBGNfsrw8816PvqzcvmlL4xUd6mt9e+4AU8mH9C57TAF2HaMQ31KjVOb9qZ5dZiOkTnpagJMTQfVwv3sc2vpqIqFoGvjIqVPHe1ZztSN6QtS9yC8h2+GCHjzhDSTUlzBlq/OA52ylId2Ie8W7Ub2nrz+HTN0M+NjsmhiWrrwkoQmc+yrUqncTldtQTtjpv5c6mUgiu9MTOFhnn0PNILpr0ORzL/XnSXuaULApLlFYdOAi/zFtM/xa3uXU1hyUdyEvEERP/ZbOwxBhDAdMJ9wlXnQCEADLKqCaiVoS4wwAUz1Jy+CWO49LbJq1YNfYOB6NWln+puw1ThJ6TgUNnO7POiDGM8bbnS7R0O/MIXk0YueF4VuteQP+Ll4v/9AgNQhGykazlHUIBDE0PyOoryHb1PISXGVoXLJojRTfnTo0bxQhvaGPTTfvLBMapSmLOQdd1P5//uz6hcgU2WpH1NWBTeBVaZ7Oj3RptovvqUsYQEAivXn53Y6bySH38wvs2TKFCHyhlFTfkNQV7N61EJ4pwpnlztV/SSUqXccpX1KZa4GA74fdr1l0lQlsa/VwnFXDay1SW8gQzZUuzAfdM8TPfMfQCtHm/UYRq/CHqV+7JD51ggtJyuhK97X39dtHVbMOwgCDEX3KagzyRtmZhzIet4d
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:31:14.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8413ee-c09a-4983-0afe-08dc3d20e958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

From: Lang Yu <Lang.Yu@amd.com>

Add support for multi instance VPE processing.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h       | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 641e540355399..b6bed77b454de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1319,6 +1319,15 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				}
 			}
 
+			if (le16_to_cpu(ip->hw_id) == VPE_HWID) {
+				if (adev->vpe.num_instances < AMDGPU_MAX_VPE_INSTANCES)
+					adev->vpe.num_instances++;
+				else
+					dev_err(adev->dev, "Too many VPE instances: %d vs %d\n",
+						adev->vpe.num_instances + 1,
+						AMDGPU_MAX_VPE_INSTANCES);
+			}
+
 			if (le16_to_cpu(ip->hw_id) == UMC_HWID) {
 				adev->gmc.num_umc++;
 				adev->umc.node_inst_num++;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 1153ddaea64d6..ee6db04cf27be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -27,6 +27,8 @@
 #include "amdgpu_irq.h"
 #include "vpe_6_1_fw_if.h"
 
+#define AMDGPU_MAX_VPE_INSTANCES 2
+
 struct amdgpu_vpe;
 
 struct vpe_funcs {
@@ -74,6 +76,8 @@ struct amdgpu_vpe {
 	uint32_t			*cmdbuf_cpu_addr;
 	struct delayed_work		idle_work;
 	bool				context_started;
+
+	uint32_t			num_instances;
 };
 
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);
-- 
2.44.0

