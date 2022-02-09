Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92863C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F6610E1DA;
	Wed,  9 Feb 2022 05:58:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9E110E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDKL62wICSB4uHAzU+tfN/7VHzAzPq9NOlU8gkMPM3skylTHezndHAsCSMspgRcvVr9vJzQLKEuYHn3dxJMy8RWH6h7EO1hphz7AUHZBZKHncVA2fNfeWSyXfA0Ypoh3qmVvKHaHGIN96vKYPKu0ivL7jspWG9qLt+E9zN9ts+F5zeJv9WkMJHG0hxihjhJIjkmkKxzVJbGjjjUiJzpbVI4lirqeHgf7qFsOgndEEO/y3xQKWnFvo10u5vnj8i9BkS13VABLFCyJVL7reC1pwVHmyCJutMlDsdvDLIgAO1OnEGVVyM5PPk932VoAj3yYRaa2bQK4gaRw9rG3HKvtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRVdUSnVo0rM/mXuidqmjRJZvvqUyZeSWOsHnq/1MYU=;
 b=ZMUBSpWlPS0p+D/Fv7BZjBxonWSM5vlzOuygBY5W8Gb6pOQE6GuOO9eqoIC4HgYvP6sPkrEhw1FC1ZnkTN3UMzQvA90ES+N4QfLRZTaY0cIXftX7BWxEifHOkBz6Vg+PwCZ5ehFT3I4Ee9FqgHJQ4u9X335F8AoZzL9z3BSBkWC3oyrypmkFjlnV7YHuv7YQU3iM7wtBZHC1ZN9SSbFfbmIJucEHJbIEGUbGwjDQORBXShU6+w7t4VNKD+xfmEm0DvdrSrIElNNQOPeshzxGqWnWRQ7nwU29GooywyeGstXNB5GCWOf4SFKimv6gHDVn6pneNGJ8BHY1bwVQwmomGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRVdUSnVo0rM/mXuidqmjRJZvvqUyZeSWOsHnq/1MYU=;
 b=pu4YxYMP5DvV9ixj6/a4mEK14OxY7TMB/GYpUkQlTg8AR7hOZ9Lv0fbHQdOioXGurVKbOmnheD86eKYFEmKERTDkwhxt4ddN6b7kQg+YueD3vZb8dmiLjmyGY3hzH4MnR3JaGK3E+8ykUi6/I2dqqYNAzdi2NJTdw/VyNuSHFKM=
Received: from BN6PR2001CA0030.namprd20.prod.outlook.com
 (2603:10b6:405:16::16) by MN2PR12MB3071.namprd12.prod.outlook.com
 (2603:10b6:208:cc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Wed, 9 Feb
 2022 05:58:20 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::27) by BN6PR2001CA0030.outlook.office365.com
 (2603:10b6:405:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:20 +0000
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
 2022 23:58:09 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amdgpu: Optimize
 amdgpu_sdma_ras_late_init/amdgpu_sdma_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:40 +0800
Message-ID: <20220209055644.1873011-7-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84a52259-8895-4ee1-6c58-08d9eb912c91
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB307124207EB92D502B3B4CDAFC2E9@MN2PR12MB3071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CDO2nWuATdBcnkrbnceazGswWjGVRQwi4dYc1zeY8TW3qtUrwqJc/fbNlsG3sawsKEeK2bQ0AWpg4V2C3uGWHSYmE3gYJcmurzdcULOs/Npw7cDc8Kk8VzwalEokudv55RygS3IERe7gMNMlovHWCQ7j5YZOLVzQzpFJXZaK59N5hzdIZOCZBWD4rCHt+z65rkcimQAmAJdhT6D0ODnlWj3RROfD20/49aIteFRVH3QGkpQJlmnz7+UMivRqVBiht4C1EI5y1Lw6aiXYGAuMKN/FThEVzphLO9bimitXg3QsUZ/jmeqdyqVTIkYppdOw1QX3r/d4zEPJKGNdMDLYDDzgLb2Se87Au4BFh6YfWqVfVGa4MPweGqd+8vglOPRJ+msgdb9oLzmXX0QGQhoyBtHOXeqbC+19QFL2rnMLk1q/oOJIRUI9NENe/czDo437S5c1q8kmG1tbV2q9LPoD0R3R2ekCJNDOp2a+QougzeGo7UjukHkZLGcDWWuE/5mub+4vwpsy9luEtV4TlEDO3/lYo2pSTKuAlKEWKYMNffNToYVPYjACkM3UZnqfOauJPmKZmj/pUBv/ARsAH7OFY6O76jr80NUgnJBNdTTnV5+z0Op4OyjuV9/prAMRaqNz+MoKKUwhThr56iOar9bFM6XaZaIKdvJ8kaDc4/4vLHktqAPk+OqCcmuLRW1N0fRbKqA3LOmI8JRe6pp8dUvNsc5PPSekH7XUI63unpTtQM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(82310400004)(54906003)(40460700003)(4326008)(6916009)(8676002)(8936002)(356005)(16526019)(1076003)(426003)(336012)(70206006)(70586007)(316002)(81166007)(7696005)(508600001)(26005)(6666004)(2616005)(83380400001)(36756003)(36860700001)(47076005)(2906002)(86362001)(5660300002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:19.9523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a52259-8895-4ee1-6c58-08d9eb912c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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

Optimize amdgpu_sdma_ras_late_init/amdgpu_sdma_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 46 +++---------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 12 ++++---
 2 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 65debb65a5df..242a7b4dcad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -90,28 +90,10 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      void *ras_ih_info)
 {
 	int r, i;
-	struct ras_ih_if *ih_info = (struct ras_ih_if *)ras_ih_info;
-	struct ras_fs_if fs_info = {
-		.sysfs_name = "sdma_err_count",
-	};
-
-	if (!ih_info)
-		return -EINVAL;
 
-	if (!adev->sdma.ras_if) {
-		adev->sdma.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!adev->sdma.ras_if)
-			return -ENOMEM;
-		adev->sdma.ras_if->block = AMDGPU_RAS_BLOCK__SDMA;
-		adev->sdma.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-		adev->sdma.ras_if->sub_block_index = 0;
-	}
-	fs_info.head = ih_info->head = *adev->sdma.ras_if;
-
-	r = amdgpu_ras_late_init(adev, adev->sdma.ras_if,
-				 &fs_info, ih_info);
+	r = amdgpu_ras_block_late_init(adev, adev->sdma.ras_if);
 	if (r)
-		goto free;
+		return r;
 
 	if (amdgpu_ras_is_supported(adev, adev->sdma.ras_if->block)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -120,38 +102,20 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			if (r)
 				goto late_fini;
 		}
-	} else {
-		r = 0;
-		goto free;
 	}
 
 	return 0;
 
 late_fini:
-	amdgpu_ras_late_fini(adev, adev->sdma.ras_if, ih_info);
-free:
-	kfree(adev->sdma.ras_if);
-	adev->sdma.ras_if = NULL;
+	amdgpu_ras_block_late_fini(adev, adev->sdma.ras_if);
 	return r;
 }
 
 void amdgpu_sdma_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA) &&
-			adev->sdma.ras_if) {
-		struct ras_common_if *ras_if = adev->sdma.ras_if;
-		struct ras_ih_if ih_info = {
-			.head = *ras_if,
-			/* the cb member will not be used by
-			 * amdgpu_ras_interrupt_remove_handler, init it only
-			 * to cheat the check in ras_late_fini
-			 */
-			.cb = amdgpu_sdma_process_ras_data_cb,
-		};
-
-		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
-		kfree(ras_if);
-	}
+			adev->sdma.ras_if)
+		amdgpu_ras_block_late_fini(adev, adev->sdma.ras_if);
 }
 
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8b0a8587dd36..82a31dfa8c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1885,9 +1885,6 @@ static int sdma_v4_0_process_ras_data_cb(struct amdgpu_device *adev,
 static int sdma_v4_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct ras_ih_if ih_info = {
-		.cb = sdma_v4_0_process_ras_data_cb,
-	};
 
 	sdma_v4_0_setup_ulv(adev);
 
@@ -1898,7 +1895,7 @@ static int sdma_v4_0_late_init(void *handle)
 	}
 
 	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
-		return adev->sdma.ras->ras_block.ras_late_init(adev, &ih_info);
+		return adev->sdma.ras->ras_block.ras_late_init(adev, NULL);
 	else
 		return 0;
 }
@@ -2794,6 +2791,7 @@ const struct amdgpu_ras_block_hw_ops sdma_v4_0_ras_hw_ops = {
 static struct amdgpu_sdma_ras sdma_v4_0_ras = {
 	.ras_block = {
 		.hw_ops = &sdma_v4_0_ras_hw_ops,
+		.ras_cb = sdma_v4_0_process_ras_data_cb,
 	},
 };
 
@@ -2816,6 +2814,8 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 
 		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
 		adev->sdma.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
+		adev->sdma.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->sdma.ras_if = &adev->sdma.ras->ras_block.ras_comm;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
 		if (!adev->sdma.ras->ras_block.ras_late_init)
@@ -2824,6 +2824,10 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->sdma.ras->ras_block.ras_fini)
 			adev->sdma.ras->ras_block.ras_fini = amdgpu_sdma_ras_fini;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->sdma.ras->ras_block.ras_cb)
+			adev->sdma.ras->ras_block.ras_cb = amdgpu_sdma_process_ras_data_cb;
 	}
 }
 
-- 
2.25.1

