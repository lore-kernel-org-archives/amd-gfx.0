Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ABDEB64DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 08:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D981F10E1AF;
	Mon, 19 Jun 2023 08:23:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B525310E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 08:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0eHB6rdDHsH0ZyBPyOEOqdAAj6RjzzzvtJTBcon8wISnnq5ITDHIGRIxWe4JrQvj4Pw27Ij8jt0KHUhmhTflIYTt6iLEB7FqOl1W3woiku+gmgvtCW6vQ/FHMiRyGzQ7HcXirXKm40JPA96kHLCIM3Rfsv5YlzMCdkqHOyoqj59KI2Hksdk1uwIdcH7lnIBtvUl9cGsbAGS+yKLjPzcu4jjBPiTgenkyjP/zt/G4C0aeH8Wfv9gbAzdAq5Ifpc9XajsoBa11MAdZlXYjDgyj60IBjDR/51iD4p8yKWnhWo9+SEGlrS57Ekf32XIBLFq2JwkrUOMC19UeNEZJyWwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KEE0X03yoBu94uSUIJJ3b6y28rRwgF2NLeCmRv59lY=;
 b=bGZfdbQIMnd/89IMZFlgHNk1YsqdxhH0Zu7Jl1QdLsv05S7jO5z8XTzpk/GSiLsiJimq8RPQqCVanvq2imt7nl44ZnA3WvcGGliHf0E7qm1dQaiVaWa+UaWx123Lj60w4Dyo3N3tFvlhtG11k3/wAFrm0U9+r85o3hqsRMwBUHy4JgcnmcZVxYEgmevC4F8OC0XOAyJIHibfaB+koSNGwtW+PvtzsHp2kiJ0f/tgce/VQPob+/hd6friumEDBHBM4RJopBwFC3fRIofd482YpvD7CRHglFzEVixB0Wq2WUSqxa/J0DCK5QDv+tjs7jIXswVeIx+p3KxnGbNJGoJA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KEE0X03yoBu94uSUIJJ3b6y28rRwgF2NLeCmRv59lY=;
 b=b2TdCxy0LA1k/owrVYDQvdBOq9iZdRHt1LJYmccOigGs7Wk9jpHS2848JBnr5L3RlURiMSeSPghF62frPH88dhODO5WmZ0ymc9IOQJkfCsdjWKiUaVPxgXZu528C0VBm2jFGT/ZvGhxz7MQOR8i84Ug/ChnwZEmEHWmkcpaVuQ0=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 08:23:41 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::aa) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 08:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 08:23:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 03:23:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 03:23:39 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 19 Jun 2023 03:23:38 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Remove redundant poison consumption
 handler function
Date: Mon, 19 Jun 2023 16:23:36 +0800
Message-ID: <20230619082336.171658-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dac0af-66e3-4e23-921e-08db709e7d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqg3AsD24OBLZepa1jOn969T2BFnQiuVzVbX56gACH2tGE6zbtFrz+MnyCYF0B0Du2hnWLyFuRMo6kUXdsvxQbDO6g0L5Apr16MWq+74IzIxrudLagmhCPSvUBlq4qQld6am5uuDB+QcVe5GJYMGzA2tJFy4CPIHmUI5uEEQASE+yicwyy9cfA6cJbKJzEW9yR5PZihvRHZR62/zIqdt78f0gOmMg89p971y+BOF0tgjL0UYuUM4o5wUH4XEob3U6CYynE6QCWGTrlyFpNXSaXQEkdQ9G6mhUy79Ve9xhn6ztSUc+gGk2bqScGwmEqWSUvrjYaLTlIyJSxXY/hjWArYNToeBW7mLKTqvtmcuhmtQCTv4FY2wVitRc4HV1NqyakpvmxDnkn9PgIp0Plrp+v9cOjbPuu1OD1OTjyPoXy5hMTwPKz9vnUgjsWWMaPKFKbYWDKJ75ppvqXaA/1V6pp3kBSLG2NBsmT9TrzOF55rX5pkju02v5DL0HGoY1Tve2R8f7wdMcY0OlxWTA73Aac2fPw1bVwK8tJq/DniXYtrTVcr1YXgDc9WDFys4bCxdhLVDce6VmmLNifRN9RleuoKwbEaffuQjSaezXjND89z9OXMsSte0PQ8bSPk3OFYfeVVq1HvzFjUQfJCYx7zFY8gx5VlSTKrYQiKiLZUO1dEAhH8gUVb7LD+sLdd8BB6srnX1kCbEbxfWmJ+v0qn7hr+QKcU13mhayE1SlIiyAI2UCK8DSTCV5iaBqEiuTe74ShrBFo3TUaHfORVy/cyQSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(336012)(426003)(83380400001)(47076005)(86362001)(8936002)(41300700001)(8676002)(5660300002)(70206006)(70586007)(316002)(2616005)(36860700001)(82740400003)(81166007)(356005)(26005)(1076003)(40460700003)(40480700001)(186003)(6636002)(478600001)(7696005)(110136005)(4326008)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:23:40.9341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dac0af-66e3-4e23-921e-08db709e7d38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function callback handle_poison_consumption and callback
function poison_consumption_handler are almost same to handle
poison consumption, remove poison_consumption_handler.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 12 +++++++++---
 5 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a33d4bc34cee..c15dbdb2e0f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -840,15 +840,6 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
-						struct amdgpu_iv_entry *entry)
-{
-	if (adev->gfx.ras && adev->gfx.ras->poison_consumption_handler)
-		return adev->gfx.ras->poison_consumption_handler(adev, entry);
-
-	return 0;
-}
-
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d0c3f2955821..95b80bc8cdb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -273,8 +273,6 @@ struct amdgpu_gfx_ras {
 	int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
-	int (*poison_consumption_handler)(struct amdgpu_device *adev,
-						struct amdgpu_iv_entry *entry);
 };
 
 struct amdgpu_gfx_shadow_info {
@@ -538,8 +536,6 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
 int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev);
-int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
-						struct amdgpu_iv_entry *entry);
 
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b6525d8dace..7be289473034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1694,15 +1694,13 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	amdgpu_umc_poison_handler(adev, false);
 
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
-		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
+		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev, entry);
 
 	/* gpu reset is fallback for failed and default cases */
-	if (poison_stat) {
+	if (poison_stat != true) {
 		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
 				block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
-	} else {
-		amdgpu_gfx_poison_consumption_handler(adev, entry);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 46bf1889a9d7..03f3b3774b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -564,7 +564,8 @@ struct amdgpu_ras_block_hw_ops {
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*reset_ras_error_status)(struct amdgpu_device *adev);
 	bool (*query_poison_status)(struct amdgpu_device *adev);
-	bool (*handle_poison_consumption)(struct amdgpu_device *adev);
+	bool (*handle_poison_consumption)(struct amdgpu_device *adev,
+			struct amdgpu_iv_entry *entry);
 };
 
 /* work flow
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 26d6286d86c9..5b7eac547a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -78,7 +78,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
+static bool gfx_v11_0_3_handle_poison_consumption(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	/* Workaround: when vmid and pasid are both zero, trigger gpu reset in KGD. */
@@ -99,10 +99,16 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 		amdgpu_ras_reset_gpu(adev);
 	}
 
-	return 0;
+	return true;
 }
 
+struct amdgpu_ras_block_hw_ops gfx_v11_0_3_ras_ops = {
+	.handle_poison_consumption = gfx_v11_0_3_handle_poison_consumption,
+};
+
 struct amdgpu_gfx_ras gfx_v11_0_3_ras = {
+	.ras_block = {
+		.hw_ops = &gfx_v11_0_3_ras_ops,
+	},
 	.rlc_gc_fed_irq = gfx_v11_0_3_rlc_gc_fed_irq,
-	.poison_consumption_handler = gfx_v11_0_3_poison_consumption_handler,
 };
-- 
2.25.1

