Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21968C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA75610EFF9;
	Thu, 30 Mar 2023 19:46:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F64910EFD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXkrVv1QhTi0cECaSuwVs2Sw3/XmHXBDXuBJtkmtwwTPj+7N3dmW4Iuw+CcYTxRCeROyp642u+p+7T+QVPhT6045roEgTeCUZyoA0sksyMVPMizTrhkn73yM/5wzQenG7zXBOtkT+4QIeJ+gomHyUOjHuy2I9Mssdp92viKaQC6E1DCCKksEEmxWNnBhSsYhGMem6tORwX2XaJdDgyI7r1GJfqaEi/R1NaraIOPZJ5hwvlOQ5lh8bHsxY9j0qBzg6NZCNyOs7l6jPLkmGTJj/09HYK6j3EzMjCExxj+JO1pk7aZpvJVVbCXX6Nk4O3TGmeBFD305rKNNeNnPSZTa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+w5d9Xbqlc0QQDbMfNVkAC03N2NJMMVw07mF+cf3GQ=;
 b=jsalZdqnR6aifP5M4RnKeDO7YH5/PO8mHvvTtuIk3UQQ6DArtI04dKkvBUgJqzAG7ZVs/67MGdvY1M5pQ17hMZzTz1qfwqy9PXJFVCNmm/P7y5SDzue4GBUYq6yavm7vUKhRuKmotTugHSi/NGDaRgVQ6++8MUBlhnzNzhyzuisvpR8zMPNzzyusugBBGe8grDFDx2pXqIpBc01pWivG7iQtP/3aqtGMvqjpzVgHau95+YVbG4Nc1N+B665+P5g9o6pPtA4sqP63VVbROS7/jwGS5iae0fTZOyVpCQWv6ALxSgFIfV7zmoz/LOyrc3WBLPwMtbRX9b/JUyTpbDudsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+w5d9Xbqlc0QQDbMfNVkAC03N2NJMMVw07mF+cf3GQ=;
 b=bEHaNLhrm2F3qAnayyIT/oRr+vDMv8NDbDEX6x2hjwn4iA+qGWszRwd7ynlm3UV/JtEt+0GB+GI3KrTrwzDMMfpr01g4i5cckeHzia0Z1yRkhITviN5DZgKzNQJ7JlE/XV/gvqK95IAuKtJesJwdhN81/0uiTqLjR0z0ki0TP2o=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.32; Thu, 30 Mar 2023 19:46:02 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::b7) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Correct dGPU MTYPE settings for gfx943
Date: Thu, 30 Mar 2023 15:45:45 -0400
Message-ID: <20230330194547.1135862-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: f4744507-74fe-4825-2a93-08db315764fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIw+MMu3ex1FAEDdRpPGzw3eRS6arlQuOWKhxD4mP/Imfh5HDGdM6eIQv85x0lkf3L1vbspgDJJ3TqUvW7zJ69FsnhNBee7bTQYeTXURQ0LqGmezhWNziAQgSh0gJIuuJglyFdADGE1GMiNzwNJw1GrOFRsXVdxus36P4Xo+4sxJr0aB4HB5lDVU3u8AQ83F8jcYKfROh1+SdOsEMIU++W2LYwAU8MOPnqrKguTIcfcPRuLlKb1TJdXu6zKfuymWpDSLQ5xUSIj8mymKRYYcq43glvHLOtplOjc7zj61jTYDrU/PAbQzN8kphNm6JzKUfNBn3O0zOJA3wHbWOErWGwWtVH37Tt/n+CckS2PWefdBNizKe1gyqqF814t4kifRe+8ULuIQAxvcGAc6z6TONUTj8eErGT7i1Q+RDA/S2Sz46KXV6a27gGGQ7Hz6GZuADO4n0JziajNaEeDJSRXWpFv9HqeuPkJalBGtzkbhnjSI9QNws8ub0v5i+D+6kG7HWlY4D2f6h2L3anHvQlnPBMlfk84YEPcDQ9RTgoigUe6QERlkwzBdaOvN7/C6qIyQbhHL1FmjswEvfU9jyRL+O9ePuolAjtDo03wRTKPsJCjGSfO4wzOphsxn3YPBFML+ci/t7K2g4VIPdEM4fBHrm2uEoek3cwdTzZlMIOVD56MoW2RsKZyvoIJh3GILvQz8rQ8Y/mUYg00ddP0ZwWRZmdz36wMT9o9fHRQv0zwZJ/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(316002)(70586007)(8936002)(478600001)(6916009)(41300700001)(70206006)(8676002)(54906003)(4326008)(5660300002)(81166007)(356005)(426003)(7696005)(82310400005)(336012)(83380400001)(82740400003)(40460700003)(16526019)(186003)(26005)(2616005)(36756003)(1076003)(2906002)(40480700001)(36860700001)(86362001)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:02.8373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4744507-74fe-4825-2a93-08db315764fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

Revert temporary dGPU VRAM MTYPE setting and align with expected
coherency protocol.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 15 +++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  |  8 ++------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5c9a0f3d5581..7564c6b237eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1220,17 +1220,12 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 			mtype = MTYPE_RW;
 		} else {
 			/* dGPU */
-			/*
-			if ((mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) &&
-			    bo_adev == adev)
-				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+			if (is_vram && bo_adev == adev)
+				mtype = MTYPE_RW;
+			else if (is_vram)
+				mtype = MTYPE_NC;
 			else
-			*/
-			/* Temporarily comment out above lines and use MTYPE_NC
-			 * on both VRAM and system memory access until
-			 * MTYPE_RW can properly work on VRAM access
-			 */
-			mtype = MTYPE_NC;
+				mtype = MTYPE_UC;
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index efd2bffbb892..89c0f3b333d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1195,13 +1195,9 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			/* local HBM region close to partition with a workaround
-			 * for Endpoint systems.
-			 */
+			/* local HBM region close to partition */
 			if (bo_node == node)
-				mapping_flags |=
-					(node->adev->flags & AMD_IS_APU) ?
-					AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+				mapping_flags |= AMDGPU_VM_MTYPE_RW;
 			/* local HBM region far from partition or remote XGMI GPU */
 			else if (svm_nodes_in_same_hive(bo_node, node))
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-- 
2.39.2

