Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3241EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 22:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B27610E564;
	Thu, 15 Jun 2023 22:39:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F3910E562
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 22:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjtWhkj3SxfVXh4Dkq6EpyegBJFgVDUzRznMVuIoJiijzYz4fPGgfSjz5Yw+Rui1Bbn/yvfJ/tdV3El2kI/kl6V1x4x8WahfEmiGdix4M2a/RsoK0Jay7ohpGcrRwdYAInPzJYG7HGlv9LBbAGv6pECtaKuJ6Zt+puIgVHI/32FEekI9TwRUAhfWxqYeCYsywTmgmauQFWKHeQn+apsjtLs4XRTx6Z5Zc+7VS9jLPtsQCETC9XnpOkKoS1TKyx2V6IK/Tg0ehRVAZHF6/VJEk2Y6RUDONMcKq4GKgfJ1QBUt85WWhoA5j+Jmj1FxtI15eBiKuDivrfseiHFJdDtjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Fdh7CDvQZphlICW9HvQOBdBsQQ7g0F04s4aCpMTov0=;
 b=j28x3pYI85p+hOK412R5f1dzMOfjgjBEGbh/aaY7lC4snzldbxylHFOvc2zdFjmZovwgbb1nX+QWThBjoJsnm2yIH0vJcm7onYZnZECp0WVghwp9TKcbuB1NCqbu3zYnnIN+7vvkyCWpy5NgM5rfwDmRW01jbb3xUFpARRkJ9knAKPCC9pIZZq0D/eG/CwChRDUHLhK/HCIyPS14PvzL5lPBxi1jb5mZFqvnfkhuWE0syOyfl78ySJUZBr51cN0hCvX27FLLPvNF/srM77XCUcMW8LzZ0YIMkKtF/EFBgyAYWIUGH9dTqYgVdF3kmPPuTSDdibq9G3TqjhO4wUgO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fdh7CDvQZphlICW9HvQOBdBsQQ7g0F04s4aCpMTov0=;
 b=2ilkEdX8xfE9ssoqPp0Id9OQ5C553orW52WRkxprQ3LyiGBfGvkSzAz5rlV80eUgdgwbxpaQsbYaxQ5tKWNU5uyl4J3LxkocNy7D0M1RgyGT26LdsyHcPsnrnAgno0fPZy6H2bsjgyeZNNDbytoAPzFkZp26WV3JMOcOs0QbtC4=
Received: from BN8PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:94::14)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 15 Jun
 2023 22:39:28 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::4e) by BN8PR03CA0001.outlook.office365.com
 (2603:10b6:408:94::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 22:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Thu, 15 Jun 2023 22:39:28 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 17:39:27 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: set coherent host access capability flag
Date: Thu, 15 Jun 2023 17:39:04 -0500
Message-ID: <20230615223904.7460-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fc19d9-021f-4a06-84ac-08db6df160f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOT+Yg6k1uLQp4zqIZcmknc4UnvrM8NrIKQeHcU51jJFVsNgciYXDYewExJN0eFkBcFElWCcWoIzFu/o6AlQOTAV7eD79Zv7sGeCJaHZ7T5nEqpSCTylBJ8Au5XQfR/0jtLlcGNRPfjw/mfPfmSYCnb9pe/Fzeho+M0enR7KCrEx4Kj5BnHxfd3xpi88Llzvq5wzVpI0spha7Tl/qS/ZPJV98g0+Bgv36NDvEePcEpemPPFdt78pJxlvzGyX4kn6hAXJbunjFLW5MdFZBE0aisrBey9EwcqRO/zC92Om/Y6CRm2t0dHUqZ9C/dKTiNIRXOAPrUz9WImyv1+4XIua9L2RMWxQTmERr/QalucuHEakNF/F2hEvgDQcEmkDchtDjdsIbPov5j+oWOxp8u7PJ5NQ7boygVvyTznWOlb7RnGAc3Kr4Wx+PYkSH0TtTUikvzFtiOtPNO8S1r8PQ28WLnzqdwu9/SlK5DqaIFNBwnjfKBaPvbBpHSiiUpHwd/irxTDhFj6OtsZkj2+TiGrPVGMHBVHAj9ysfX9H9Dp5T1h7tmv/r0tSOyvr5zwbODm9eJhQLRPFn1xcy14t6hTqZ9Hr0SoBj4+DuB0Ce3ZSbQU2LZX++HDIddz6KDQZE7naIqo004pUMOp/bwGbaQoozwRkkTNDw8xGb8IyoFOBffEGXqCSurX8TfXHQpOx6r4YNdxgenzTgakf8cgGnt+8NwpxGOSQg89LIZULYK89q6kSiR/E7VgIX7pAZkfEFG71Bra5S+cdBWfWwa0p8/vOyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(82310400005)(82740400003)(8676002)(54906003)(110136005)(6666004)(478600001)(70206006)(70586007)(86362001)(36756003)(40480700001)(7696005)(36860700001)(40460700003)(186003)(26005)(16526019)(1076003)(316002)(4326008)(4744005)(6636002)(2906002)(5660300002)(44832011)(8936002)(2616005)(41300700001)(83380400001)(426003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:39:28.3771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fc19d9-021f-4a06-84ac-08db6df160f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This flag determines whether the host possesses coherent access to
the memory of the device.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 90b86a6ac7bd..296219be350d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2107,6 +2107,9 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev))
 		dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
 
+	if (dev->gpu->adev->gmc.xgmi.connected_to_cpu)
+		dev->node_props.capability |= HSA_CAP_FLAGS_COHERENTHOSTACCESS;
+
 	kfd_debug_print_topology();
 
 	kfd_notify_gpu_change(gpu_id, 1);
-- 
2.32.0

