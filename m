Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED2AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EBE10E17E;
	Wed,  9 Feb 2022 05:58:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253B810E1DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATE2xne6M6HYLmpJbdNGb3A2MN5X1iHK3g/H+yK6Kb3TUHWeBLVG3uMB37EIJcsJTKvrnw6eNwtmvtpKAedLovEXNn6DkMcJtIGUb0ycRlXcwzbXcsCjx7bBubqDTwpzMRk4YPA8dOTB6mfokbnEJ9Y8eQDf/Z8Qbo990oif0zgVd3W9ZNmCvdJwPPfQknKZ77gp8rwudlfvxKy9DscKYzAJItubvLdCqATanvOM0ccSkVJOpdDUbXWVLIvhtbh2BiDOm/sMhNg1jgapwaSy4X+VKZNwxy1c5efPhfjx876du3PCdVn6mpl+pa+n+Pw8sFep+nNxEFrlSstsrCotEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5k7oi5RgouvBQK8RSkOJ36mR71rzSotjJ8rcbir8Xk=;
 b=F2vpLGvNyfUK/+3Ak6E0wKOVIvA7W0aIVfxWfAwYznNO2/dkchRDoL/myqg+tUGHLTLwTN5m4uTMvRhScLXL32okBJbBsVcQNMxKx/MyBSLAguFYa4qfLD8J4KeoB9tzGM8sSFM0gyAFhvtlKzqCQaS/PnkZ9dK+txOq51hMOd+G6r+0FR6WzemUjYOi/nM8oSvF8jSZ0s0ltaTOjrHFJYJIpbfKUzegiVr+dDPvr5r7MiN6ewX7GVV/gd1mtBqCIdZ7vqOtTowMDDJ8WwfKTrOFaAhzdXLSlvjqQ8UIm7wTyjGi1b9mRC5sY8NA0bqIQKbUbvmpTsFR/KVYVjMVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5k7oi5RgouvBQK8RSkOJ36mR71rzSotjJ8rcbir8Xk=;
 b=vaZsrf7x6eI90dpoITi4tGqiJ2XQDAAvGRIl9ipyhPfb86nCDWLIxGi9payz99nyfmkYGc6XtcBWgkq9qKf9IjEzkA/DdyZBjIwt+WlkpN5snI+PrtwjAsAcM6xI8Tj01y7NOIEUR6Zgu2GKppIFsVFJktoHOnWICMHw6unLJMM=
Received: from BN6PR2001CA0041.namprd20.prod.outlook.com
 (2603:10b6:405:16::27) by DM6PR12MB3162.namprd12.prod.outlook.com
 (2603:10b6:5:15c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 05:58:19 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ec) by BN6PR2001CA0041.outlook.office365.com
 (2603:10b6:405:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:19 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:07 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amdgpu: Optimize
 amdgpu_nbio_ras_late_init/amdgpu_nbio_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:39 +0800
Message-ID: <20220209055644.1873011-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 421f733c-44d0-457d-fc1e-08d9eb912c1e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3162:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB316295B9E24703361FA3274FFC2E9@DM6PR12MB3162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:193;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FL1W7pqRbVwAmP/f5GDENf1LY0G0TwLY/iDHNJRWUveaRGsadRF5b3VoP/pwmbYq/msoU7dgFdk8zIIGsJ7q+O1A8qwaQymuklHSuxOmxW5ufG1xzaCV/bxU97iY3soS6ttH8Z3/nK8JsLCFYgId7/QBSgh+M1Fz8Az5y8o5CTmWm/+g/ApX+RouB0KauJk6rNzlbeKt26QyyLnxNx+KdrJicVNJbPzSJO1TVn/8fUqYCKlHlppQPZqeZeauNgBNXMQr02y4+NiYpZzredgu9lzOqH4pCTQMgSf+Hdhe9Z3p2mu5orl58ArgdaaHDjxrECs2oF9e8mXYAd9oeKQ7uTBlkx14zBx1ySS6lmEAqRSVgSlYg9gODB9AXtdTM1vypHE0/PmEWI0959VG2ZZCQ4OLWCrYSDqyg/CV2L/kEmS7el72nVCtZWd36ZtfQp4oRe3N91BLhATAmIKBdR9g8AlrcNs16Bqo4d/ZadJ1TyYqboNOTlA9OhkNm1765+eVo/JJyGPOkXxVGAk6DjyAZ/sdwArD3VmOqbArWK+recolZULfe5jaHHleRtz9VXV7bMANqZOGO4uKH1wCp8eIFiuD/HP8NwZmRaRJhjRAFF2s80mUILb+95dwkJ0wJL4Kub+soTaD/mpw/pckTT44blbMd0uBWzexr46Zvde15B1TAMqk9zBA0PmUYTaFB5+08L+5s6ZozfpbyL4BpGXjPKPf9n7kCQkYRnMb+n/+XBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(2906002)(26005)(16526019)(81166007)(186003)(1076003)(5660300002)(316002)(82310400004)(6666004)(356005)(336012)(40460700003)(36860700001)(426003)(6916009)(7696005)(47076005)(70586007)(54906003)(4326008)(8676002)(70206006)(8936002)(508600001)(36756003)(83380400001)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:19.2024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421f733c-44d0-457d-fc1e-08d9eb912c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize amdgpu_nbio_ras_late_init/amdgpu_nbio_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 40 +++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  1 +
 3 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 6ace2e390e77..89e61fdd3580 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -25,26 +25,9 @@
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
-	struct ras_ih_if ih_info = {
-		.cb = NULL,
-	};
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "pcie_bif_err_count",
-	};
-
-	if (!adev->nbio.ras_if) {
-		adev->nbio.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->nbio.ras_if)
-			return -ENOMEM;
-		adev->nbio.ras_if->block = AMDGPU_RAS_BLOCK__PCIE_BIF;
-		adev->nbio.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->nbio.ras_if->sub_block_index = 0;
-	}
-	ih_info.head = fs_info.head = *adev->nbio.ras_if;
-	r = amdgpu_ras_late_init(adev, adev->nbio.ras_if,
-				 &fs_info, &ih_info);
+	r = amdgpu_ras_block_late_init(adev, adev->nbio.ras_if);
 	if (r)
-		goto free;
+		return r;
 
 	if (amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
 		r = amdgpu_irq_get(adev, &adev->nbio.ras_controller_irq, 0);
@@ -53,30 +36,17 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 		r = amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 		if (r)
 			goto late_fini;
-	} else {
-		r = 0;
-		goto free;
 	}
 
 	return 0;
 late_fini:
-	amdgpu_ras_late_fini(adev, adev->nbio.ras_if, &ih_info);
-free:
-	kfree(adev->nbio.ras_if);
-	adev->nbio.ras_if = NULL;
+	amdgpu_ras_block_late_fini(adev, adev->nbio.ras_if);
 	return r;
 }
 
 void amdgpu_nbio_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF) &&
-			adev->nbio.ras_if) {
-		struct ras_common_if *ras_if = adev->nbio.ras_if;
-		struct ras_ih_if ih_info = {
-			.cb = NULL,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+			adev->nbio.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->nbio.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b7aed19db7e9..8a76a4e07659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2301,6 +2301,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		if (!adev->gmc.xgmi.connected_to_cpu) {
 			adev->nbio.ras = &nbio_v7_4_ras;
 			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
+			adev->nbio.ras_if = &adev->nbio.ras->ras_block.ras_comm;
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index c7cca87f1647..14768570c298 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -667,6 +667,7 @@ struct amdgpu_nbio_ras nbio_v7_4_ras = {
 		.ras_comm = {
 			.name = "pcie_bif",
 			.block = AMDGPU_RAS_BLOCK__PCIE_BIF,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &nbio_v7_4_ras_hw_ops,
 		.ras_late_init = amdgpu_nbio_ras_late_init,
-- 
2.25.1

