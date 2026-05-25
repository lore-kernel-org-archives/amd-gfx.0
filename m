Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95F1CD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 19:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2977710E3C2;
	Mon, 25 May 2026 19:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVZaw36n";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C58210E3C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 19:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDekInnM3p33gsFEyDFOhJC1BsnV7OXs/Y1wrg7/Jr94xGPVfmJnjmq4L8LW4ZCxhv0DIJwS4zA0pKtBkxSHYGoEVud2libz8Tm0Qs2qhZIDX17ioxf6hajJJFv+GvS0k5f3bJa9qGLNuBte/bKrTv4aEuf50sQzybUkG+BfeVvMcKe2ybuLgIV4lFvoFqBv8fnRzBeS7+ToganWFY2xGtGU5Ew/AoKKihWSzIl3VWbJRPkTpVp34estbsn4D3PJbC7in7Ozf/bpJpnzOuHuNAx5jtGRm1xsHxjzuG0aAfnMlNWf4dHB9ZFOCikKpzW9dbor+SE6YgxVKfB8v8iqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li07gtg7u6HjUkWH/hVNpyoW4SNA4TWbfw1/13giBw8=;
 b=XFXwu6Iy6LAXfJaStPB2s0LehFSRtbPpJCWTWB1iCq82t9ZFpFs3ReMvJDQnR0M3e74ELK8fh2fwYnLz1f1ux1cKzfU6vz0McqjuLy8xB5DQowE3tRL1T9+AORdZb2CsiaCJcJJAXfdIvFRAev0dDytU/HjpDPTTsm8Viq5s7S9u2dDo09enGORwBDX3WqpidAgrsnViZJdsf/BmrM/VVZIebaqMtPkbd2D69wbkqJ2/o8r1MSjYpFvi7M5cHXBE05pH0ix5jnGuQAakn4ObBgESfYssQ7XK/MlywudgBSIiat8Od1XzTEy/vh58NJ/ptec2c9IgckwuNELhkJgl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li07gtg7u6HjUkWH/hVNpyoW4SNA4TWbfw1/13giBw8=;
 b=UVZaw36nBuAqVEyol4H89qUZaa8g2PsE+p5yq5kKo8suTEJcsmPf0RfO6ioKBm7fN8PmtGGyejfEWomPAIn5sINq345kP1+9/W9EPCWaqA2mMeRPUEWt+vaD0FoyNrc7ZP7SYGouYYoVDHr909sU2wzODcjvwOs5mrcn/LiFUzY=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 19:06:07 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::41) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 19:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 19:06:06 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 14:06:06 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>, <YiPeng.Chai@amd.com>,
 <Tony.Yi@amd.com>
Subject: [PATCH v5] drm/amdgpu: grow VF RAS bad page table with bounded
 dynamic alloc
Date: Mon, 25 May 2026 15:06:00 -0400
Message-ID: <20260525190600.2910538-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508180705.217683-1-Chenglei.Xie@amd.com>
References: <20260508180705.217683-1-Chenglei.Xie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e09a65-dbe5-42f1-114e-08deba90aca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uqz5I37lVgSvZjU1+OfmL64TTiS02pRTx404VJ3wvq62Iikvh4A61/U6Mb4p7MuEDLrS0Mj/lctzFpq6CAVTXqriNWkGJsWefPtKRu4S4/dWoHdqytjVnf4nAOKCK9rhlHmttvdw7OoL6JdsGb1bSskCsQIpU3lWBgPFqXQZ889vvNfC0AqjE8mlFtXlruS/PiF+d4kB9l4PO3He0sJfTCOnZUQC0SNgc8oabqP1lZujS545uG69vDNHCAR28rG25IeFnric9Ugfo4KeTmnkrXUQv0EB0bVKjhFslqhecQvjSj13JBoNDa3QGi19/ZauQQg6hc1KkCSdeUIAMqBESn4n7cIvyPgkGfzspYiryyPPdQyiISa1EDBTQgxdigAnwfj05HIjSaIXR5NgABkS8jj+tL1G/bn3EVkGDqomHSfMhQoGGlM12Es7VUGjTP8ik+aVeWb7YiczPqlDPY2MtJruaPDYdIcxku/vUVAbsGCJBTDNIGJk1QmYZqQoNaIe3xpzVLQxOg8Q62Ce9/tCxXEyxV4AUjPSlPSJy+zIrc9Efh6l9mJye0nsLPiPKRDQYcCTP8cy4Xl6VVraG/xXfxW8QO5WZq9liGZVoX5SP/rKaUHzcjyegfbdTDQj8ty/b8QzhTvjCMShM5WFvw1+7X/JS7VEreiU5OhE3fnuqp4xO+fSOfuJgeK4kyClzm72soXVh1rLStNa/SovRKb8UEElcaPHFmm9ZakiwB2th+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L3eHxKyHSh8PBI/omUM7b2WoJiMVhr4GEE8ud1qthvVAFOmjU3kqTneNMK/IkHB0gRy/vcdOx2PcF+x2eFcwzmZRIm7wzOyn7GyjPVQgIkdZj9NW1qkJY0wsUV7xzIN0j9oXWgms+mS5olIZkQbPjY0hCgXS4M5teeaHPy4eTg+sonRlPa4U356jTA/D41lj1P8fyJL0TcrhWoU/gBBSZhovmy9yVxi9FSM4lQSCh0sv3d5uEHNNNulb2ALVIhV56IK1obhguiIIxoTx34MWwNTpiGWzMrcB1IwnhyE693Dg7/OEW5SEqswLZ9a2Sq3RbA1XyYbKuOB17bwnbB4HmE+iK7SDaLfdL5Y1Gc/iFgBpAl3lL1xyR4SMJIR8QQcUrA2sMLCQOPpgXg/dtLzp7MPGj2BpSvvXSF1tvaSktqBZvwRiQyT82RVE3Q/wI4bF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 19:06:06.6884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e09a65-dbe5-42f1-114e-08deba90aca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VF RAS error handler used fixed-size bps[] / bps_bo[] arrays (512
slots). When the PF2VF bad-page block listed more entries than fit,
amdgpu_virt_ras_add_bps() could memcpy() past the end of those arrays.

Replace the fixed backing store with a dynamically grown table:
- Add capacity to track allocated slots separately from count.
- Start at 512 slots and realloc bps / bps_bo together when full.
- Refuse growth beyond maximum EEPROM record limit (AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY).
- Return failure from amdgpu_virt_ras_add_bps() and stop processing
  the PF2VF block if allocation fails or the cap is reached.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 111 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |   2 +
 2 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f8e58d12e39ae..7b0d425101611 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,66 @@ unsigned int amd_sriov_msg_checksum(void *obj,
 	return ret;
 }
 
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY	512
+/* Max bad page slots allowed for SRIOV*/
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY	10665U
+
+/**
+ * amdgpu_virt_ras_realloc_eh_data_space - alloc/realloc VF bad-page @data->bps and @data->bps_bo
+ * @adev: amdgpu device
+ * @data: VF RAS error-handler data
+ * @pages: minimum number of new slots to add beyond @data->capacity
+ *
+ * Return: 0 on success, %-ENOMEM on failure.
+ */
+static int amdgpu_virt_ras_realloc_eh_data_space(struct amdgpu_device *adev,
+		struct amdgpu_virt_ras_err_handler_data *data,
+		int pages)
+{
+	struct eeprom_table_record *new_bps;
+	struct amdgpu_bo **new_bo;
+	unsigned int old_space;
+	unsigned int new_space;
+	unsigned int align_space;
+
+	old_space = (unsigned int)data->capacity;
+	new_space = old_space + max_t(unsigned int, (unsigned int)pages,
+				      (unsigned int)AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY);
+	if (new_space < old_space || new_space > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY)
+		return -ENOMEM;
+
+	align_space = ALIGN(new_space, AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY);
+	if (align_space > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY)
+		return -ENOMEM;
+
+	new_bps = kmalloc_array(align_space, sizeof(*data->bps), GFP_KERNEL);
+	new_bo = kcalloc(align_space, sizeof(*data->bps_bo), GFP_KERNEL);
+	if (!new_bps || !new_bo) {
+		kfree(new_bps);
+		kfree(new_bo);
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: failed to grow bad page table to %u slots\n",
+				     align_space);
+		return -ENOMEM;
+	}
+
+	memcpy(new_bps, data->bps, data->count * sizeof(*data->bps));
+	memcpy(new_bo, data->bps_bo, data->count * sizeof(*data->bps_bo));
+
+	kfree(data->bps);
+	kfree(data->bps_bo);
+	data->bps = new_bps;
+	data->bps_bo = new_bo;
+	data->capacity = (int)align_space;
+
+	return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
-	/* GPU will be marked bad on host if bp count more then 10,
-	 * so alloc 512 is enough.
-	 */
-	unsigned int align_space = 512;
+	unsigned int align_space = AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
 	void *bps = NULL;
 	struct amdgpu_bo **bps_bo = NULL;
 
@@ -302,12 +354,13 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kcalloc(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 	if (!bps_bo)
 		goto bps_bo_failure;
 
 	(*data)->bps = bps;
 	(*data)->bps_bo = bps_bo;
+	(*data)->capacity = align_space;
 	(*data)->count = 0;
 	(*data)->last_reserved = 0;
 
@@ -361,17 +414,33 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	virt->virt_eh_data = NULL;
 }
 
-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		const struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	int need;
 
-	if (!data)
-		return;
+	if (!data || pages <= 0)
+		return false;
+
+	if (pages > AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY - data->count) {
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: bad page table at capacity (count=%d pages=%d max=%u)\n",
+				     data->count, pages,
+				     AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_MAX_CAPACITY);
+		return false;
+	}
+
+	need = data->count + pages;
+	if (need > data->capacity &&
+	    amdgpu_virt_ras_realloc_eh_data_space(adev, data, need - data->capacity))
+		return false;
 
 	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
 	data->count += pages;
+
+	return true;
 }
 
 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
@@ -443,20 +512,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 
 	memset(&bp, 0, sizeof(bp));
 
-	if (bp_block_size) {
-		bp_cnt = bp_block_size / sizeof(uint64_t);
-		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(vram_usage_va +
-					bp_block_offset + bp_idx * sizeof(uint64_t));
-			bp.retired_page = retired_page;
+	if (!bp_block_size)
+		return;
 
-			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
-				continue;
+	bp_cnt = bp_block_size / sizeof(uint64_t);
+	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+		retired_page = *(uint64_t *)(vram_usage_va +
+				bp_block_offset + bp_idx * sizeof(uint64_t));
+		bp.retired_page = retired_page;
 
-			amdgpu_virt_ras_add_bps(adev, &bp, 1);
+		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+			continue;
 
-			amdgpu_virt_ras_reserve_bps(adev);
-		}
+		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+			break;
+
+		amdgpu_virt_ras_reserve_bps(adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d563deec0916b..d8500c3e48a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -265,6 +265,8 @@ struct amdgpu_virt_ras_err_handler_data {
 	struct eeprom_table_record *bps;
 	/* point to reserved bo array */
 	struct amdgpu_bo **bps_bo;
+	/* number of slots in bps[] / bps_bo[] (always >= count) */
+	int capacity;
 	/* the count of entries */
 	int count;
 	/* last reserved entry's index + 1 */
-- 
2.34.1

