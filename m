Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2C9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A46810E1C7;
	Wed,  9 Feb 2022 05:58:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8D610E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMNEkgVAW6SjENztDHMgGZapdNkttOZf/9KCY3rp5ymzyPHY+nUwAQuuzuLgYzJ1G8iJjzPNpL2w4f3TxAeEGs2icxnloTjvKWefBsoMc429DsbwlkU6aoLaORPGU026lHkP21TiCIsHLI8pIYAvAorzYSWJBEO264r5iOG0iWkctgUOeaKJLVGWUHOrYzMJOVYLb60U8H/gIFs6JxdCJc54Hw68RvjSv51cuRLkM1tykUJdq0AL6Bp7Jihkavo3L1Hz6Bt2IVddsnNaj79GG7Mish1Q4FIW+jPPmsub8SH45sHTOgGUjDAnZy/KPbcurBbL0Muznf2snGXJ74eU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rtnW0DznIBgXEc+vCm9ANwXhO7r77Zj2oeo3oT47LU=;
 b=dZs4+7wzl534mME3DNiGXfc54JLCfA49laboYDJ4UWSZTE3fOygP/NiPA5JUTrjvhxeU2vNCXcKORScUTCdURW7FS83jre00eugXYPavlAP3az3mp05bqLgba5VkUj0T+dmaQGZD4wMYvddrHgU57JgD4iilIpeHKiiIRgHVOv8fPu1VOaUraLEHQztaFULonrwUo7N4yhXzk2q9J3Pn5AjYlcqUZ+Sm5KwsF4f0tIIZ7nQeB6UgcVVhc4W8q8NoFKzwsQqeJsbmzaHmYr3jhQ7sq9npJuF7IVjNrsz4Qo9J612cSilMqMidmCtpj/E1UpvnlxlwHipcZOQoEVG8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rtnW0DznIBgXEc+vCm9ANwXhO7r77Zj2oeo3oT47LU=;
 b=KqnqbvqHMNqPj+ReiGvrIkRdtq7nl8VDU1SgiXjEToVQukUwD5yW5he5N/7bh8Vl4ps5XL95cESBu9m7LjoCVO74GCXuW+uHk2UGmbLIH/tl4HgCOgqtniuAOXYr/G5dLv92mb23Q0pxv6IrSG4MItHipotMJhmTgBjmcQt5b5s=
Received: from BN9PR03CA0106.namprd03.prod.outlook.com (2603:10b6:408:fd::21)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 05:58:03 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::a1) by BN9PR03CA0106.outlook.office365.com
 (2603:10b6:408:fd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:03 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:00 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:36 +0800
Message-ID: <20220209055644.1873011-3-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41879845-cb0d-40dc-f9be-08d9eb91228f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4449:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4449F44DD6E29809751AFAFCFC2E9@DM6PR12MB4449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiKNeGfCSm3aX4sOy841gCWro0LFS3hYHxCOAeTjTmU9THl7vR+kBNSBUXUZUrO9svgiU9faU+DQtKw93aDcVlDZ5iJSfD0iS0juj2sPCd75ATrb3NNMHA1Rbo8AhvwCjno5CXPWAjTJq+63S4kJDwudNXvlSeS5YNjcBG2Mtdu3Bk8QXRpK8EGJNPZVG/0ILrs0xJ0fIQunnlyawn7RwpZ8vUrrCfRBeaxMHWHi7pCLMDdSStEwgsCIWoNVWseKyf4+gfyXkgBHUhkFeSHRUToFBglal1l4WUtGUDxIforJI8bx0su7SXU64PxDLkwtITWzipF/De6KNScNI6Zmq/aQfrdxpKZaWvvpOpFxq1bCU09AehaaQN+GmhafCWXktypfIH7aIgNPms+nVUpyNxwQrDd2UwP9hCKMCq/VMQG12sJvqj4Nr6hmPZ+VYHCCyWmY7Glg7DoQxbgMDeJkIng2HZ3a+GNPpSOwR6UcO2uuNB0WaTchPFsiq5RfmVVvU0vmbJds41xaHO+djqpm4D5H7egHrRUHwMXAyWcG0IW6MCkDZVWHQv5ac+H3v9JpcjSlttc1CF9Uwmpcmujl9ldwJFpmJOd6CU8UUdNe+T/nbcdmKgwcoOWSR662vOfaiePaT3HCZHJZcZeD7C3DG2pNQXkl4BHEXx7M2AXbbROBzSi94KXA452pBhibBKIrW3XE4Y7n9B/JawZIaHkdtiLlgwC7/e1v02pHNLBb2Hs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(40460700003)(86362001)(2906002)(6916009)(6666004)(54906003)(7696005)(83380400001)(508600001)(5660300002)(26005)(47076005)(36860700001)(70586007)(82310400004)(186003)(2616005)(16526019)(81166007)(36756003)(8676002)(70206006)(1076003)(316002)(356005)(8936002)(336012)(426003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:03.1501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41879845-cb0d-40dc-f9be-08d9eb91228f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

Optimize amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 37 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  1 +
 3 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 518966a26130..21a5f884dd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -26,43 +26,12 @@
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
-	int r;
-	struct ras_ih_if ih_info = {
-		.cb = NULL,
-	};
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "hdp_err_count",
-	};
-
-	if (!adev->hdp.ras_if) {
-		adev->hdp.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->hdp.ras_if)
-			return -ENOMEM;
-		adev->hdp.ras_if->block = AMDGPU_RAS_BLOCK__HDP;
-		adev->hdp.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->hdp.ras_if->sub_block_index = 0;
-	}
-	ih_info.head = fs_info.head = *adev->hdp.ras_if;
-	r = amdgpu_ras_late_init(adev, adev->hdp.ras_if,
-				 &fs_info, &ih_info);
-	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
-		kfree(adev->hdp.ras_if);
-		adev->hdp.ras_if = NULL;
-	}
-
-	return r;
+	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
 }
 
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
-	    adev->hdp.ras_if) {
-		struct ras_common_if *ras_if = adev->hdp.ras_if;
-		struct ras_ih_if ih_info = {
-			.cb = NULL,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+	    adev->hdp.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->hdp.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index af873c99d5e4..b12fe6703f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1302,6 +1302,7 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->hdp.ras = &hdp_v4_0_ras;
 	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
+	adev->hdp.ras_if = &adev->hdp.ras->ras_block.ras_comm;
 }
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 503c292b321e..a9ed4232cdeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -160,6 +160,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 		.ras_comm = {
 			.name = "hdp",
 			.block = AMDGPU_RAS_BLOCK__HDP,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
 		.ras_late_init = amdgpu_hdp_ras_late_init,
-- 
2.25.1

