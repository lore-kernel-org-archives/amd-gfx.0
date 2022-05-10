Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B648C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 06:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6298D10F1C6;
	Tue, 10 May 2022 06:30:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451B410F1E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 06:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3wGI+vF+5jmHg9u0HsDrLvI+yu+Xyrdt9fyzEyMkad1DAvR+HGGj+CH8Qo7rE9aKTpvaxcXU1giwPiIgRGmYSB3VMi7Dses6hfSaxc17/OSKo6ti+0kxszsoeoSzIZ2KOGW8VG/Gk0tMhGn2od1sJtclMD27aVyHlGIBVgvvgcYp2CRdiJXNF5WNs5JVT21/3NeQCI2vsXiotvFWKFgWFvWzSuu90l+qLRalCrEptLSgJz026+cjUAX2NaqInhNooCF4ieq97D30TWU0gZL0N3QP1Aus0b86K9EsEkAcfpuCuHHEHq0RpTY9syVCtO44liNkumfyh/4JaVpYV6SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuEJfuxhf+uvtP0SM/OryR0y8qWin81quPoGjg2Alro=;
 b=A/U6t3BcwzVVly3SFRlAz12iRb01hPFrYQAOetX10Mtx6OZ/spuKQz1bhb2kGVJtJ9ARV2yACNxF0mzaA/41HVCJr7s/AzgdpzFsdPurZpaPwJ8YNiaqF75YOv/2CSAiXYZ4V6N3LzLGDVqvj1FDrpxJy16YqsRlxIrVBpT2ErWmkddwpYv6euY7xCNK32zpFBMWo8KCw7BrwvHy3Jcet/fl/iCvDWmqfbamNG59prj+7Zv/lGuYgII5XlTh/CnpPq13oslxyynTHM0jdlm6h1NEjJ04qHLKDIBjblIqBa3OPWVTqNeYCNPkPYJpoZ92m2XMQchUZ3VFYydLOky1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuEJfuxhf+uvtP0SM/OryR0y8qWin81quPoGjg2Alro=;
 b=jzS6deLsmN+hYOfO754Ru3rrz0tHzoDAP/lRrrkUZO/OjEF4HvamcRyyhNse8sLSfSPXdqmtlO4lz8S2alhhOYc6mGjJbkomzDMsyzV03p2oZia6kmKSZQ2jWDpgNq/L1m3yUcgg1PfbbBbMhSflJCDFzAwHqfQxAfI3qXFbClw=
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 06:30:06 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::6) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Tue, 10 May 2022 06:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 06:30:06 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 01:30:03 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Mohammadzafar.Ziya@amd.com>,
 <Lijo.Lazar@amd.com>, <hawking.zhang@amd.com>, <stanley.yang@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine RAS poison consumption handler
Date: Tue, 10 May 2022 14:29:50 +0800
Message-ID: <20220510062950.11792-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510062950.11792-1-tao.zhou1@amd.com>
References: <20220510062950.11792-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc4681f-aaf0-4f61-de7e-08da324e85e3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50548563DF9F3355034EFB9DB0C99@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/qya0tMXtJjnd42Lj1Ne9p1ZLSkwv2BuoXTa0+3EOh1bZwftvzGyphJhJ/FTkDLfXUdnUZI9xlpn83FXQ3HKaLLhZDkoKcriw1scM/I+LBclBR3RRaykXGafyqw2J6SbxM3AmkP3TOxinXf8Bk8NIn5rAy0rwXy+zJYY5FJWZR6LtvnSvEEiZYJ+Z/DgeFLNEwRZLiYXZxVTUR6964f/zrNCEtWZLTBx7KFKqDQ1DBvCHxVyu7/SlwRvfTIEjyubpxIxYOCT4UdlC8uT32cxyn1SfYVfHobi2Bu2a/2B6O/e9Tx3I+sBiP5EmbadworusWZSkSWsi98RNRxsI7csbSB6QH7FdJsCcT8BHCh+0khKM3kPfEn902nXOmqhzvuy2FKpP+87SmiPxbZbAfaTEzov4WbC6lHvqI8Z+uH5s/ubBac7d2wtRgQ0F4LoByaCxZf58tPHTWBq4yB9Vjpto2AsHdnmTkq0ClknjTSXRtyMG1H7S0paL6mQFIGTP/PFIQZbstAM5RgT3Bpd37EaPOQcgbYnUBYcG5IT+XeSHNFxhVc/hAvZE45LixWhEK/0B0qRtMfQKB7s9+emnK2TQc4Ch+N9jSMtXS0/S8iVpk94kLMlds/9tB1fMzcV1JbORp+fp1FegNNDlEuaNoITLSXUna9xa1au5/yPJthOE8bwGdAceWg7AMmWF6ilrUgBWC8+yPpOcLujChbS59Xhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(8936002)(36756003)(2906002)(16526019)(40460700003)(36860700001)(356005)(5660300002)(83380400001)(70206006)(70586007)(508600001)(1076003)(4326008)(186003)(8676002)(47076005)(2616005)(426003)(336012)(82310400005)(316002)(110136005)(7696005)(6636002)(6666004)(86362001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 06:30:06.0394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc4681f-aaf0-4f61-de7e-08da324e85e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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

Qeury ras status before ras poison consumption handling, add more
comment and log.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 +++++++++++++++----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 91d9e9969b4e..a653cf3b3d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1538,33 +1538,42 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
-	bool poison_stat = true, need_reset = true;
+	bool poison_stat = false;
 	struct amdgpu_device *adev = obj->adev;
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
 
-	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, &err_data, false);
-
-	/* both query_poison_status and handle_poison_consumption are optional */
-	if (block_obj && block_obj->hw_ops) {
-		if (block_obj->hw_ops->query_poison_status) {
-			poison_stat = block_obj->hw_ops->query_poison_status(adev);
-			if (!poison_stat)
-				dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
-						block_obj->ras_comm.name);
-		}
+	if (!block_obj || !block_obj->hw_ops)
+		return;
 
-		if (poison_stat && block_obj->hw_ops->handle_poison_consumption) {
-			poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
-			need_reset = poison_stat;
+	/* both query_poison_status and handle_poison_consumption are optional,
+	 * but at least one of them should be implemented if we need poison
+	 * consumption handler
+	 */
+	if (block_obj->hw_ops->query_poison_status) {
+		poison_stat = block_obj->hw_ops->query_poison_status(adev);
+		if (!poison_stat) {
+			/* Not poison consumption interrupt, no need to handle it */
+			dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
+					block_obj->ras_comm.name);
+
+			return;
 		}
 	}
 
-	/* gpu reset is fallback for all failed cases */
-	if (need_reset)
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		amdgpu_umc_poison_handler(adev, &err_data, false);
+
+	if (block_obj->hw_ops->handle_poison_consumption)
+		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
+
+	/* gpu reset is fallback for failed and default cases */
+	if (poison_stat) {
+		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
+				block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
+	}
 }
 
 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
-- 
2.35.1

