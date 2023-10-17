Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C03ECDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013F310E2E9;
	Tue, 17 Oct 2023 12:46:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08AAB10E2E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brzMkFw7YdXoVABP3otsv+4Ao5yDzytag/LT5vFu34klXKj17jhEhZPDkfFWVd2s3Ws8PST5L4Sv5D1sk0gnyKSzT619OYMLzPk/QxvowRsWVB8e3ncOPqV/ONNq0qygzl36WyBtO4ZGE9xr1QnOO7Fo2zYeAnpXDL2RSsLaejvzCDqwusTbKuUwzeT9HiDrrRP3jMX49Kng4Vt0hfhPEnNBC6hwW3/kw4qa2QS62/6jw4X0H6gxqqzEjuoL4Np7gkDE5KHXemvkcIN5sNGNsc/oYJysA/YPwpEkGmpGCvdkCrp9pQMRf/EDZvgkRUxvW0mtT5CWTVoFK2qEYIgGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwMLEtVWZ9sPC3BsUucCo+7RTNZxP3wfp044cnGYAeI=;
 b=PSgME0W3iOz0B2ALJbNgdy9r8jzP8h4dTI/58LDrLEdIK3yUIs16+sou/Y0wFQZl4RIeqWSf+6XijzBqYD9I0t6Df4N72xtVsv5t5ReTAbCOVqW7/BzMe46mKhx58uMOyzDreoUwkCevVhc8wy9HM1IH34wKFDt4F2qox6giDUvDgihAtTEg2kxQcnVppusiY7q/w++zqv+LuxBGS6VGE9+TBhypCFVEkKNuYUSxXMwsFIm/qVZSxFc/qdcSwebQV7UcOcdf3MkInlCF441Umfwq/Xhx9FFgtt121BfCbwdqBIJ6xxxCPPEI797x56OeV21gpENWBoifAkD+vQH1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwMLEtVWZ9sPC3BsUucCo+7RTNZxP3wfp044cnGYAeI=;
 b=Y1N+W/OYxeeMcNVsKmpbbxhrziNNH/iU+okrCprNz6Vn/GhIhGu7TBH97sr83NLG5ZfqDKrbkbFLcZllHCKK94cc/lkvPaohmfiHx1fu/dk4/NL3W/w9HxDOsDach544pPsCDP6cbmsn7RC6nD8s4lz2HeFlNCvKk/ZfTPOoY6k=
Received: from CH2PR18CA0046.namprd18.prod.outlook.com (2603:10b6:610:55::26)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 12:46:17 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::20) by CH2PR18CA0046.outlook.office365.com
 (2603:10b6:610:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 12:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.5 via Frontend Transport; Tue, 17 Oct 2023 12:46:16 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 07:46:13 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: reuse amdgpu_ras_reset_error_count code
Date: Tue, 17 Oct 2023 20:45:51 +0800
Message-ID: <20231017124552.27509-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231017124552.27509-1-tao.zhou1@amd.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca403ef-42f4-4480-5fb7-08dbcf0f0e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eUqm9++DLbN8nGcFvDCZ7z/lIFQ13Pr+9V0TRvmipbw0YmsnAPAwRHSjEZGsdPjDC4qmwaNK5axXojZqyBS78A/WsLU9l9+nAIV7fCiS1d/CkkaXWBKnk5tFG85F31bbO4JspPMyDaFe5bmVqG9XoA/s60J9JpKZX+z54rlvgtOhA3ayGXclS0ay0AzjuwzTw65A79OF0/ZTBp04RLvlFK8sxCTAI7JpvWI8a77scwTBLSjykeSiEOnU3pyLxiTXFVWG0ZtHNFzzWo1jslwBuyZKPTDrLNkME/0B73RUZB7URpq3c7OUiVh4Q/FhHDjKVkYR/3ukyNqsZquG6bT5RMsNET9tDvzqwFMd2Po1jqwzEAUjMULTSUsOT1VbN7qOwMEZbksbWuHIpuRaUPbKKDQx4fIYk4XchDU5sB1jjGf7NuxUlxdt0RLSdxp8aU5nw49kYqPs+Ej3AoYVNQRV7W5L2ZGNyEO9I97KStOwL8ehI1TJepcavddoih/+flKRDd8d1V3UID7d80a7G5BhElMGvvU5/kQksQeDwP7LE7LpMXJa4hZkExKDcbJYlQe7GucRq8qRdHjCEdXN5bN0/0jtxdiqVTdiZ2QgFVhES3zO6pg++aZAP6OQ8P/iyita+bRhi6myG9+GInvgUjr5n/RbM1OErOiRiR+DFH8cI5DO9L0qsNyFRg0KP5mWQGnTAnRzKHkdG1TtgBBtgyzDgeMDyWjyfW2bVQ4RnUf67Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(7696005)(2906002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(70206006)(70586007)(110136005)(6636002)(316002)(40460700003)(478600001)(336012)(426003)(1076003)(2616005)(26005)(16526019)(83380400001)(40480700001)(47076005)(36756003)(36860700001)(82740400003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:46:16.8842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca403ef-42f4-4480-5fb7-08dbcf0f0e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423
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

To simplify the code of amdgpu_ras_reset_error_status without logical
change.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 30 +++++++------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 806c6d4deb63..b4e8d0c629cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1181,17 +1181,20 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
-	if (!block_obj || !block_obj->hw_ops)
-		return 0;
+	if (!block_obj || !block_obj->hw_ops) {
+		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+				ras_block_str(block));
+		return -EOPNOTSUPP;
+	}
 
 	/* skip ras error reset in gpu reset */
 	if (amdgpu_in_reset(adev) && atomic_read(&ras->in_recovery) &&
 	    mca_funcs && mca_funcs->mca_set_debug_mode)
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (!amdgpu_ras_is_supported(adev, block) ||
 	    !amdgpu_ras_get_mca_debug_mode(adev))
-		return 0;
+		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
 		block_obj->hw_ops->reset_ras_error_count(adev);
@@ -1203,27 +1206,10 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!block_obj || !block_obj->hw_ops) {
-		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
-			     ras_block_str(block));
-		return 0;
-	}
 
-	/* skip ras error reset in gpu reset */
-	if (amdgpu_in_reset(adev) && atomic_read(&ras->in_recovery) &&
-	    mca_funcs && mca_funcs->mca_set_debug_mode)
+	if (amdgpu_ras_reset_error_count(adev, block) == -EOPNOTSUPP)
 		return 0;
 
-	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_mca_debug_mode(adev))
-		return 0;
-
-	if (block_obj->hw_ops->reset_ras_error_count)
-		block_obj->hw_ops->reset_ras_error_count(adev);
-
 	if ((block == AMDGPU_RAS_BLOCK__GFX) ||
 	    (block == AMDGPU_RAS_BLOCK__MMHUB)) {
 		if (block_obj->hw_ops->reset_ras_error_status)
-- 
2.35.1

