Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F0E7AD78
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA58010E2FB;
	Tue,  3 Oct 2023 16:57:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE78010E2FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4rARGQ2TyTw8NGbx7QhPCN6uULFICE7v56Yd3ujUi4NYx4QqzMD+jr3Lvkm3Btu++3vBtqJLYSewpL7RhxsP7njyFoFGGIGtez8Y0r+YPjtnc+39+SRZiMD2JkjQZT22oo62B8iwaU5rB3byv1pyK2XOV86bE164tjmh3kaiks48NObvzNfzp4Gsfw83RurZY0P2Ol1+Ix2AdXoG36lDxmvBSqJVAdSSJ42EFnsf9XcSgpbDwljVtpFvhzSb8hqg6O2qMtJuhROK2CqTsjxEmQB4WG+pr7vhOgzQKeqcQZczaWkjMbRr2nLlBa0pnR3Z6jOFPUpt3yTcimGUvm4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XDZhdZYtYkaDCG5nEdenQ5OhZn/e3dKKqEBlTXK5qc=;
 b=kk0RJg1ibXMfTUfirx54HS6gY6mgpS8HT7b/rZrjI0+PNZvcegPVWO7G4ou1sYCZjsyxLUWRyBh7HW/VkdiWNsajIETnb2C+Rc+LtW6nd2fgxAYguvEEsBMyPFVt8g4oh5OJ783HM0gRgrvjx6qAdEylGYTgj/fNSwF7wgevWwXM2Kw2ut/8Pj+0/NXIz4nmuSh5LTdaP3EjX6jIsXEM1NvBfSum5zzFvv8rPp/q+2i8g7fbyBrWqNJR7S7WcnYxBjD7fVQM11/Zc6cCEbYT2iznE3dQyh43Zmll58nAr2/e1x53+aOucvHYWRGNGtfVCf1xdzbHwQBcCutrUgRSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XDZhdZYtYkaDCG5nEdenQ5OhZn/e3dKKqEBlTXK5qc=;
 b=QohhgiDBOwN0rSDviRmS8EfHPrGGNFOWjTI/EkqJfgI35mSVfN+fJ7D0ebKL8iSTY2EzBPBM8HixW2vcFmESi6MNKiw6IgCiz8Mn2Fro1NthKt5dfKGiknts+vOJ4FXxpYc5pmb+6whHrFiykk9XZyN5x2dtOuz2dC4Vvd6k9eo=
Received: from CH0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:610:e6::14)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 16:57:47 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:610:e6:cafe::50) by CH0PR03CA0279.outlook.office365.com
 (2603:10b6:610:e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 16:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 16:57:46 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 11:57:45 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Date: Tue, 3 Oct 2023 12:57:27 -0400
Message-ID: <20231003165727.10854-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c12dd85-391f-4952-e052-08dbc431de60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jvlx+MoH0xKruDIwz/RNPDz73zEcDZOkOjwwTldzLXMml0lh5um/+QdQXKMyl3DttpQZ2k2tj3UePRBRfSEDgtI/cGbteGlNA46Ik5PkPaW+RySdAuurspWChyMULxrseL48ay96Pgy7Vv+TKkLjL9EuF9dF0sjI6L9OlVo3LSOWScyL51lsloHBQU0tHaJzYYX0J2NqtDWnLE3M1+BApyJIrfENFahVrz9Yla0EgAJWhCgwKY0jjesmbKM1Uk/fO+QjAhmG1mbeqTYvvMT/iqqX6yGJcRJRJCQmkT66QgfvD963N+rcnQJdGug69HGUocOjTYII4HVtUa+sAu1809vKUvsxw0hoLYuKAAXOPYm+5wnWu6iUsXXtl2RYYYADJuDpZOByDuZLbwUwgrmjiIW/vwc5Fl11Z4umuEgzuNAFyjwMHHnFxwVXQBcmUIZQg5IYkCgRigMoMCUieSkY2hB0vSronWyw75GmrBRREY1IXsIImT3CXCetCMYMexUNvTW5ykLPfRQxU7O63rAam0QFRVElbuNgZTLzFkQL50qJoP5l+Y2PiECqNd38lY8YXwlMHTZCibNrttQLBzpckMs52N1PpXHbFjb1zhos/DmpPMaaBaz1DmtWEAslV9xHPE2SyQuOBtXyFdB1KO8afFc5PAZPdnjoyexPdHX47uSnkUR/2IYqcSTMCtdaSM/5vJsvfAV4Tx3w9CwFIJa5qCdDFRJQOrWynTggk0NM+o7QtgyMsOOjvKLiJNNJQERHiMIFGkTV4aFxuKTX5ry9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(1076003)(4326008)(8676002)(8936002)(70586007)(70206006)(5660300002)(54906003)(41300700001)(356005)(6916009)(316002)(336012)(82740400003)(6666004)(2906002)(426003)(16526019)(2616005)(26005)(7696005)(81166007)(36860700001)(83380400001)(47076005)(478600001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:57:46.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c12dd85-391f-4952-e052-08dbc431de60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there is no VRAM domain, bo_node is NULL and this causes crash. Move
the EXT_COHERENT support change to VRAM domain path.

Need another patch to support override PTE flag on APU.

Fixes: 55d7e2001c7e ("drm/amdgpu: Add EXT_COHERENT memory allocation flags")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0d88698ae33f..150a3e88691d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1252,19 +1252,17 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-		} else if (ext_coherent) {
-			/* local HBM region close to partition */
-			if (bo_node->adev == node->adev &&
-			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
-				mapping_flags |= AMDGPU_VM_MTYPE_CC;
-			else
-				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			/* local HBM region close to partition */
 			if (bo_node->adev == node->adev &&
 			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
-				mapping_flags |= mtype_local;
+				if (ext_coherent)
+					mapping_flags |= AMDGPU_VM_MTYPE_CC;
+				else
+					mapping_flags |= mtype_local;
 			/* local HBM region far from partition or remote XGMI GPU */
+			else if (ext_coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 			else if (svm_nodes_in_same_hive(bo_node, node))
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
 			/* PCIe P2P */
-- 
2.35.1

