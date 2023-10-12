Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00627CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 09:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71ABC10E46A;
	Thu, 12 Oct 2023 09:01:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B53310E46A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 09:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyGNZHBFgEiDNO2TUA8tb8K4L2cey33FGO5XpJA9CigHeCQC+k5z0Lk5wZB7SQY2Vr1+fAsTQK9/hiaOUTEI/377LScA040+9CzU6lT3PwIelL/IrGLoMwUGQjAuAHOea3pzLKQ7cejLvqPjQr2QGqTqjAxJNs7RlOZ9v+RvpAXOPNCoZRcTIctf4rvtHl62LQKjOOKzEZeoLRpwoWI7vv0nORUv2j2Ay6w+pnUonLfhIsDi0xDXAdtLLfvoUH7l6rSyXsNww5FkOQlSxDoYnVs+IxM78RlCUDiI3nr0pfcf57hP/mMpEXA4I73W4iF8mbIeSQaLSUEegasTN/Csrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwVCKCVGaiQaxMbVlGVqwHZyzG6S0Mx2LiRsGLML97g=;
 b=Dr0M8kvq/EXa1jaTsMr1u2KTWlESCiIbCViKZ2PDBxIfmvHkzX+vM6qcfCeEkY1uk8rvXcS08ABsF77AuW/r3zx89IkaX72fk9F8z6Ap6CHO6fu9lDJk4HUWI82QuCDx/2risSpp1R8Ws/+TXeEFW4Padg08x7W50qeSaJve1Lm0eAWP8Ow3Ro28NcItDNj2eCtrfqQyqPKqUFLu8gwQj/gv9/LLnhfI30jGvqY4dT4Li7U+zyohPjU61AEHJbV+vcMpDsvRCfu8Yh1aicJmoJ9WmGPqFN/G3uSoiZdASagHq7Uqq93aW+sq7nHrpQd3qlOspBUI9LbowM5M4zJ/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwVCKCVGaiQaxMbVlGVqwHZyzG6S0Mx2LiRsGLML97g=;
 b=QpMIihSFip62ZprS0ae0A+ALAeLP8CD47DiOBObd5XxSSKw5s9gBL7YvSaeCFQsdbASkHUwNOrnuae0XyC1WcPL/Wwyn9qGmdrwOPOMsFvNYRosz0HY25Sf4whKiTvCiWtEzDMUOVs6/WMJegxmu8jlBgCGWtkzMLRdO5Ku9pkM=
Received: from CY5PR13CA0078.namprd13.prod.outlook.com (2603:10b6:930:a::40)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 09:01:07 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::7f) by CY5PR13CA0078.outlook.office365.com
 (2603:10b6:930:a::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 09:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 09:01:07 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 04:00:51 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stanley.yang@amd.com>,
 <hawking.zhang@amd.com>, <candice.li@amd.com>, <yipeng.chai@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: define ras_reset_error_count function
Date: Thu, 12 Oct 2023 17:00:30 +0800
Message-ID: <20231012090034.31055-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d00723-8bbd-428f-a0b9-08dbcb01c582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMbxIw2fczBIvL2OqcB1bcYfth1NHY5SGLtwvaK4FQe/6CIWqLP0sNG8IxeuidJztnVoZzpBzIb3OLGbScQsvqRdY3veURlKzs+twVhfgtOOetriR/bl0bsxhsGMDfeJa4O4LyzP2xFVwDHsJxmmFlEe5Lp23csU5HMIe7xYDSOOFCVMiR/1DCW32366Tm06Qq5U1Iv1HvcsegJwscnPzkvyYfMmxtjw3t8yTDC4hyYTp8V83Ef4eU34qbg6fueCZ1K8EBjD/qp2HyhLo02G9WWzgIa0Y0K+rIvjwoQYRr7UE6xo6KE0iAYZ8614z1/t2KT9vBuo+INTYobhH3MTTRcWopC7sX7G5ZIe5656Lzn5qWZoL2SRNoTwtH8eGbjpajvOYujykQJxyNGM3DuNQSw+D+4r1z9DVC0A3ZE0DXnZdyXQ9z5o27gaaITp7nKfg0NH12eh3Ng2JCFRy4bc6HvqBrmxUTFWFFSeOVwTTrZxq9YlSep/KQq6X6WrurKSzBR+WBaE8InReF1jF9rJimLisIPAAAxnAEZQlYCr+QCEaIU+c0eClrWSALy74NGUrr+3o06xoeger9xBwKXV8ef2foHPl8T2UB71ErlJnZbY4/6mlu2FPSbPGMrMxRJagyqWrBsnyq3is2YFzSAkVCxUHrro1bngJXb8StNRxo9UeFKgtruTkNYLUMt9gXvmUL+d2xzGkrkr6tVVPuVnELFYWVOXJ6Z3SUVmY+ed0g8G0ifL3i1sgmRqK6tpZV3k3GRvLQJcKY++MO7rmh373Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(4326008)(40460700003)(47076005)(36860700001)(2906002)(86362001)(356005)(82740400003)(81166007)(40480700001)(110136005)(70206006)(316002)(36756003)(6636002)(70586007)(7696005)(16526019)(1076003)(2616005)(478600001)(26005)(41300700001)(8936002)(6666004)(336012)(83380400001)(5660300002)(426003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:01:07.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d00723-8bbd-428f-a0b9-08dbcb01c582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code architecture more simple.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  4 ++--
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 31f8c3ead161..04cfd67a37a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3594,9 +3594,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 		if (adev->asic_reset_res)
 			goto fail;
 
-		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.hw_ops &&
-		    adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
-			adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__MMHUB);
 	} else {
 
 		task_barrier_full(&hive->tb);
@@ -5242,9 +5240,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 	if (!r && amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			if (tmp_adev->mmhub.ras && tmp_adev->mmhub.ras->ras_block.hw_ops &&
-			    tmp_adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count)
-				tmp_adev->mmhub.ras->ras_block.hw_ops->reset_ras_error_count(tmp_adev);
+			amdgpu_ras_reset_error_count(tmp_adev, AMDGPU_RAS_BLOCK__MMHUB);
 		}
 
 		amdgpu_ras_intr_cleared();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dacce5f2bfa3..82ee6f3d12da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1101,6 +1101,23 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block)
+{
+	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+
+	if (!block_obj || !block_obj->hw_ops)
+		return 0;
+
+	if (!amdgpu_ras_is_supported(adev, block))
+		return 0;
+
+	if (block_obj->hw_ops->reset_ras_error_count)
+		block_obj->hw_ops->reset_ras_error_count(adev);
+
+	return 0;
+}
+
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 728f98c6fc1c..deea10b6c184 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -694,6 +694,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		struct ras_query_if *info);
 
+int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
+		enum amdgpu_ras_block block);
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 70e38b013309..2b7dc490ba6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -914,7 +914,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
-	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
 	return amdgpu_ras_block_late_init(adev, ras_block);
 }
@@ -1081,7 +1081,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	}
 
-	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
+	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
 	err_data->ue_count += ue_cnt;
 	err_data->ce_count += ce_cnt;
-- 
2.35.1

