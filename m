Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDBAE8FDB3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9A410E0EE;
	Tue,  3 Oct 2023 20:51:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D3610E0EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/y1S3/C+Q9X6/3bCeReWO1kPNgGewqzuKAZcRmFsZCYWoT47r3pR4NktilC0kGsG4RTeu8v6f5YlSDMiEar2zuwJ46SDnKeHi4ecU2JFaujPxQbPJU54HfToX8T4ZFO7gfT+25Pz3WP+XiMXT7ok8lnKPmwYGsqh9UBVkrAudiQWPJubzQbOT/Lx1G11VDZ1fZtVJh1X1IRDEvZzeVg9l4hRczh0V/7M3Aa7OX54pzWxgl6o4eVsxcLLDk+cvwOZgCd9Z/mIYqQMPy8Zvb3KCAgshK04LL4+hBhxJ6QzsgKUBBa4epcOfh+YbBfeXvdQyWNrk44q9RjJ/4yQf6ZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5/g2tv5JIHu0er9p4XLCR9cBDlQ1rQaklxNRNgvkwI=;
 b=fPu1evbxlqUkkzpHsK1KYdi3Q/LpaV803Kk+ig16XDH5HZOGLGloyniLGhX89QGOW01/yiD4jWE1AOyFozb0YEOP2AC4tqBVdOXtorzVFkdetRKPP1L3pYV4KVu2a4FZAxBj7Z/n2SkRPycvBIMZGbbnf5/Vf0Nfy09cweYVCaxXa96IKbni8XUUiA1FCfXeXWAO6O4dYA+m65o+oaprknN39ca7KkXlUHBrxRjLulLUlpdGtT5pQNva2zb8FeuHBeKZaQRtKy7f40Sd/PzPYL1YtjQPNwt8K453oHealJrJAVR1YnVEFBUUSYEY2PNnz9Q+6fnGiVs07X5oj2wOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5/g2tv5JIHu0er9p4XLCR9cBDlQ1rQaklxNRNgvkwI=;
 b=j9aZ8LILoaGCKUolRPRrLbG2/QZMrN/9QPFtWhYz6XqvDptqwbR7V9eXgo6wwO9O9ki/08JtU/5o6ZBU5iVM9BZkhxYQNqEqqC+EDBmfVipcYotLF6p9n9t20Ex2cpblgUZwGpER+Aixd/wgZau8KLCXPGHs1Pa/Y9+2Pr8Xxkc=
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 20:50:59 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::dc) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 20:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 20:50:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 15:50:57 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Date: Tue, 3 Oct 2023 16:50:29 -0400
Message-ID: <20231003205029.4764-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c78237-b848-4ee9-b347-08dbc4527299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VWR1Y96oRx1XXMekG7Qhmp1/McKHmeom5FMPzDEw7aLhNIDTuT9OqL7WVtS2b6+T9J6Rz4U+SkUSZjMqiQ8FWL/GtHxeBYd7QdUyVccJKcFjaFhlW4lumWO8s8Mbi+DpPiZObY2jrssItNb/DFh+/GfnsTfYP3OIGdyNu1SS9Vf/purjzXwOeDNYqIagD5MXd8NQjOAjliaAAtv7E8V6hQpLRb9boH0nVfZ2/QMI6EgT3iC7XDBuLw1YdGuZw7jB3U5TFPml7R25HzbgoeRlOL98kmeeO8maVFCMwWO2hv5XxvlfLjwcyv/gkc6bcpPewgsPMrLETP+wXeQn20uVVLyWT4KyFCEZIrIcZbeA5lnH+EhpBsh6470JxI6bPf/iqqpOU4SCjG7tNWkRcTz72YPa5DH83ZOii7q2X7osEuZsBwOByi5YIeWSeMGf4QVTP0YjIXknpZsT68xZohobJw/MTMs9bfztiyMOzP5SecqmJDHY+ObdiHWdIbKYv3OkIBLWTSpPhn101n1qkD3UGSvOFKZCxThr7QsIKAA4MesNS75Q6gpEcMq6WOCN7SuNgIusGVgCZ48IMIcPN+smPQ6GG3uQ5yXn6TOF5qYCyz01fwGNZwVCrNtUczTEVDbJv0GAFOZZzIMnrbJjLf6JflzeiM06PabZc9KFrHyaUoAj/o4LcutBc/vtCRPn2VzoUDSICa4OceLzGMMzLaS5Gb+oeW1AO9tsRN5F4LNUwICjjOntugGEEqtqp64xU84Ga7huvHWA24cCLNsi6Jr8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(16526019)(26005)(336012)(1076003)(2616005)(426003)(478600001)(6666004)(7696005)(47076005)(83380400001)(36860700001)(2906002)(8936002)(8676002)(70206006)(70586007)(54906003)(6916009)(5660300002)(41300700001)(316002)(4326008)(40460700003)(356005)(81166007)(40480700001)(36756003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:50:59.1001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c78237-b848-4ee9-b347-08dbc4527299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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

If there is no VRAM domain, bo_node is NULL and this causes crash.
Refactor the change, and use the module parameter as higher privilege.

Need another patch to support override PTE flag on APU.

Fixes: 55d7e2001c7e ("drm/amdgpu: Add EXT_COHERENT memory allocation flags")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0d88698ae33f..305b2c54edfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1248,26 +1248,22 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		break;
 	case IP_VERSION(9, 4, 3):
 		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-			     (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
+			      (amdgpu_mtype_local == 2 || ext_coherent ?
+					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
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
 				mapping_flags |= mtype_local;
-			/* local HBM region far from partition or remote XGMI GPU */
-			else if (svm_nodes_in_same_hive(bo_node, node))
+			/* local HBM region far from partition or remote XGMI GPU
+			 * with regular system scope coherence
+			 */
+			else if (svm_nodes_in_same_hive(bo_node, node) && !ext_coherent)
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			/* PCIe P2P */
+			/* PCIe P2P or extended system scope coherence */
 			else
 				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		/* system memory accessed by the APU */
-- 
2.35.1

