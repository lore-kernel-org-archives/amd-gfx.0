Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E360C001DE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 06:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D2810E05C;
	Sun, 23 Jul 2023 06:51:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41A410E062
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 06:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e29nO8GEs+viu8XEBujOtHg8icntdjiCII33PxGiVUn+HPZ0wrYfkk7CjJ0WXQqGs4ZaLBsZxeDkJAXTaZGj2Xcq4m2WX2i2tWlb5ik7qdHoZ1lUeXl2u+x+EVLZleHvyVurloHpUaINJ1SOxD0sUHIVV86/XMK8KuUyQlCWFiyizULlib9muzSRDKM7b+L956MoMvBrSYBkDnlLZSg2nwj56kvKRbU93XLRgeqKNEsvWJ6nps24/81slfY4z+RljnmIWWsvNaY/K1RHp6LbSZY6klWGcxHCAESNBsb5r1vbRsPcvaBcFnH+YN7Tu/wOHyekiAsNwUXex/0LBFSO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wwsL68j5ehgdtz18+GQQuREF/ZD7tEsBsPXvgoWCBE=;
 b=fX6tqXbvRRUDpZ6KmRr7xY5MhEvv/r6FuIXO4c96czt02GSpHpC4oAqtzc/6hHfjILv6moyJpzpb/qbVKXS33mmlS3hWE5sfySsSy/T+mNR8MAM7zQSQ8A6pq/3sA62QncrTjLdn3PlRzSZ8k72d0S/vrRAFGl0ibaX7uIHxonFNkM5hgxhGU6V81a1Mem3i8DvjszWHX+v1K/7WUYGSPer1DdSaFl3iZIvK5xncpZhQkRGd7shxMJRq5xavxxq4Ce05MuwMzDS1oB0QNcQsBSjg/BXZErdb3aoGdVA5mn/VAcqSZ5clBGkrU+WcrUJbs0zUN4cV7C/LKscg5Y/sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wwsL68j5ehgdtz18+GQQuREF/ZD7tEsBsPXvgoWCBE=;
 b=KrgQTTk+D3RBu7hPH97jj1IZOIxlzkOCx3vLFWg1vUlDvKJToGa/ewjQskQXBbznXXk7bsxTQXERP4EOfmiZy68bCmyQnfKpgZbTLz4NePAVzy4J2scPEZ+rx0jslUdt9oulU3tzU9afWgWxYKBTIUS6wHamG9VdPsA3DDbW77s=
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Sun, 23 Jul 2023 06:50:57 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::8c) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Sun, 23 Jul 2023 06:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 06:50:56 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 01:50:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use seq_puts() instead of seq_printf()
Date: Sun, 23 Jul 2023 12:20:07 +0530
Message-ID: <20230723065007.2022758-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2d3101-3536-4771-8946-08db8b492a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QtTb3LOElLd1ApqDJaoqy7LXm+sorXUEYk8GpHPR5Y5TBIUhk3Nip8ZFWVseAnkaKoyaLu2VEddCXK3ONfWZmx+kiCwtu3u7zHOYYEKfJXWpZyFtj49gLpEFPFPAaz6qkOTMuXjxjZJ7eXI0EILcZzWIM7inuIBou60yBWBurxH7hg9Z6HWwl4z+JT9IERMMJ8rmeSjEDUa/kBvke29isYUIZvVMbaXzs+foqrnFbrHUtlRT0E+2Pa52JMfgt6FYvYmUWWeBzBJ8IBOWaK9klx5Z6jXZYKAC1NqGQeR/IGcnmQnkPs3T19BtiN28U/FxEn+Y9jFAnqmPYDyDGvpBw4zxaXPCJ2XygPGeL9hLkIY6qewALR9pCXqcXqPmHOgE5j85WtMHkAcG3ESnA4ueFe1U0g7uZ2lhELNcqam/5h1t9L9oMnpLKHSucwXVF6lwhhaqbsgCRtw1i3iInzxbZu3M/pyqvaYHzmOO+Wjh73eWrNhEtKShILRQ0AulemHTcnk63XH3IgItK4skMhzLv32Zng9M7B6M90BHxr3rEZJ02n6bAptE1DVMvshXKhn1KsMYIQsKm67bkWRFA5J/WzD5lIATT+Hg7TLloY7ImLoA32zlMpplHxU02DvqOFzxCHCNd6dX4slxP5mh25PTN8mZEFStJs0piZkUrTnzRUFGtDzA71l5madGmg8lS3VKiOfROWvgEaWk8m1fX1Z/BWKmDIGRkeU8rV7o7Haul+aQgSzdDG9CgIKUoE1JSDDbjJqNgY/OunczGYuxGLwtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(110136005)(54906003)(478600001)(6666004)(36860700001)(47076005)(83380400001)(426003)(66574015)(36756003)(86362001)(40460700003)(40480700001)(44832011)(2906002)(16526019)(336012)(186003)(2616005)(26005)(1076003)(356005)(81166007)(82740400003)(6636002)(4326008)(70586007)(316002)(41300700001)(70206006)(8676002)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 06:50:56.3868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2d3101-3536-4771-8946-08db8b492a89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For a constant format without additional arguments, use seq_puts()
instead of seq_printf(). Also, it fixes the following warning.

WARNING: Prefer seq_puts to seq_printf

And other style fixes:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Block comments should align the * on each line

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index e0d3e3aa2e31..0cbaf78e8828 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -62,7 +62,7 @@
  * Returns 0 on success, error on failure.
  */
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		  unsigned size, enum amdgpu_ib_pool_type pool_type,
+		  unsigned int size, enum amdgpu_ib_pool_type pool_type,
 		  struct amdgpu_ib *ib)
 {
 	int r;
@@ -123,7 +123,7 @@ void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
  * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
  * to SI there was just a DE IB.
  */
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
@@ -131,16 +131,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
 	bool need_ctx_switch;
-	unsigned patch_offset = ~0;
+	unsigned int patch_offset = ~0;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
-	unsigned fence_flags = 0;
+	unsigned int fence_flags = 0;
 	bool secure, init_shadow;
 	u64 shadow_va, csa_va, gds_va;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 
-	unsigned i;
+	unsigned int i;
 	int r = 0;
 	bool need_pipe_sync = false;
 
@@ -282,7 +282,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
 
 		if (ring->funcs->init_cond_exec) {
-			unsigned ce_offset = ~0;
+			unsigned int ce_offset = ~0;
 
 			ce_offset = amdgpu_ring_init_cond_exec(ring);
 			if (ce_offset != ~0 && ring->funcs->patch_cond_exec)
@@ -386,7 +386,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 {
 	long tmo_gfx, tmo_mm;
 	int r, ret = 0;
-	unsigned i;
+	unsigned int i;
 
 	tmo_mm = tmo_gfx = AMDGPU_IB_TEST_TIMEOUT;
 	if (amdgpu_sriov_vf(adev)) {
@@ -403,7 +403,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		/* for CP & SDMA engines since they are scheduled together so
 		 * need to make the timeout width enough to cover the time
 		 * cost waiting for it coming back under RUNTIME only
-		*/
+		 */
 		tmo_gfx = 8 * AMDGPU_IB_TEST_TIMEOUT;
 	} else if (adev->gmc.xgmi.hive_id) {
 		tmo_gfx = AMDGPU_IB_TEST_GFX_XGMI_TIMEOUT;
@@ -466,13 +466,13 @@ static int amdgpu_debugfs_sa_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = m->private;
 
-	seq_printf(m, "--------------------- DELAYED --------------------- \n");
+	seq_puts(m, "--------------------- DELAYED ---------------------\n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
 				     m);
-	seq_printf(m, "-------------------- IMMEDIATE -------------------- \n");
+	seq_puts(m, "-------------------- IMMEDIATE --------------------\n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_IMMEDIATE],
 				     m);
-	seq_printf(m, "--------------------- DIRECT ---------------------- \n");
+	seq_puts(m, "--------------------- DIRECT ----------------------\n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT], m);
 
 	return 0;
-- 
2.25.1

