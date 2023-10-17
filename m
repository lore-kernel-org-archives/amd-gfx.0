Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E881CDB483
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D2F10E2DD;
	Tue, 17 Oct 2023 12:46:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720BC10E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXaBRAGJC+leh/bA/LiuNmdrmRkQY1Ah7Yzqji2WXB1hVWYZGs/lI2T+tsE3vlHQ8UMlMvTYjrBASMU/ryYx+osjlOe6IrnUm0IxIULbV6M+0HI4wZJwEe/IYqqTcSD0E1QEQ45m9XveVDU8wSFV4jpBzcmDC/G1kpLldC+BcB7bmCEzftA/b6CQlx1IxkEfrY73yITPgb5ertMm1rqaslOIU/TFz3ZiMAqXigAa9svaKwjthr7nysnkU+dOb26Nc8pL7kkndPUkQXS/a9RR8YeaSprwnkcuO++SCC/T3huhh7KPZ3q3SjEKwVoqSjZhfIpGr0ApEb2vC+CBT2UZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFXyDBpakJ2bt1TrCNyxEqea46zcQ/VokAWvGKD94BM=;
 b=iNjpEbdAnp1NZLuHJeLRPqXHSBUre65kOFwtVt3CKakwAx+wunVNVsR7Yd8NMcby08HraSddToceQbEeH2HKq5DftIASwKlxdnHhuxMKcLCu4wOXTpNfjX0qxdv0sTeK96KH84wWNhNPBv8iCeJrXsb/kdUbVq1Pl4xQ2JJXaGCVYpCNQUlcyYe36/zykkLL6zXY/TwBk+DzaPDtedoJ2AKB0JFOq0CjgGwwdW7UmT88GK+cUeP32lGEtlRd7tFr9PedzBgWz5Qb8ujdtWD/70QIuvcYHUiLr0IQzQamTrQqbyLRNy2v3QcDTXAtUJmHQZUG66J1i5A0vlMs6ny+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFXyDBpakJ2bt1TrCNyxEqea46zcQ/VokAWvGKD94BM=;
 b=x26zAnoU2yd7AC4GcFaS84IhtZ+QkeoxGAbp/cwGcwsR+QLlzB1qrB4DEtfr+eqKoDv8OPDkcJqDMJ08SLzqNo35VJ/TB3F7dP3tTldYFSKFWHKjRIm4/yRA9cgYpSWJg60Vim5gpfRUfAeVI6sGXbmBUOQc0LEejsytsCKfF7g=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 12:46:07 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::36) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 12:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.6 via Frontend Transport; Tue, 17 Oct 2023 12:46:07 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 07:46:04 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: define ras_reset_error_count function
Date: Tue, 17 Oct 2023 20:45:47 +0800
Message-ID: <20231017124552.27509-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: aab8ed9c-3799-4b80-f05d-08dbcf0f0884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VteE8eYtzpbVieHFaeryADzQWB6N7peWFun8D2BYSev8A9+79eIe3JUIoHRlAkK6xqgsZIyE1IsLgjgcqVl+VTrKbIv8bwYYj5XkauwZF9/0ZYn/z4HNUaHSy0Y/o/6F8qWeR25c9BzPuX1PAa3Ai0ZwqfQX0aCv639G9Kstkt84ccjDyc58oze9wUSU7cnOmppjaAxs7fAji8mFTglaU8ThETVgzjEuzpuXyPAMaXlg/iXGAtVREZNtUxvGO9KYKXZLu5h/izgTiswoIVdz0chiciHIwKN3Y9Px59acI9kKLX3IVa9BWxOOOM0I8JF5fJep1K8fOu1iw2N2CVw+lyltr314xoJyTv/wntuQD89pxvezBlRBSRJfPdKHQ0h2tEDAOp2jPKKJMhR+Yi/Eyt3q7FDMb1fLMJOm2NmLRRJO7VZ5e49e1TBPOhtQYZ/wrcHIVaowRehNuMTWefkT+aNw/EAqtjLxwPeQtWOwJwptlqmqK7UuTH8gyMVY3eow1Itwc3Thn/1esNRVCbEBQBdDoY2WnGZtw1dnCPVgsZyASX81bkoja0kUodk5Q18aI7bXr+Bg4dpaQ7lmpR5Cjna1/bbJZPEDL9FZ8qH3ODK3pezmcu9ysQcv+nPL74/jZ9XjFqckktr4fA2vW8+zbPSO/SmAtvFAGgQ/aEDx96yXHDmIjVLZNVHlSE7mU88tkgn+x3QAffs5SyoHJ9z6B6zAk/IC07TcFTfdV8ox7Cc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40480700001)(26005)(40460700003)(478600001)(2906002)(7696005)(5660300002)(81166007)(41300700001)(82740400003)(356005)(6666004)(2616005)(1076003)(36860700001)(16526019)(336012)(426003)(316002)(70206006)(8936002)(110136005)(8676002)(70586007)(6636002)(4326008)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:46:07.5727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab8ed9c-3799-4b80-f05d-08dbcf0f0884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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
index 1b23651cacf4..344ebcf1a6e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1174,6 +1174,23 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	return ret;
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
index 0a5c8a107fb2..3f9ac0ab67e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -714,6 +714,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
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

