Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7683D637B4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419B210E88F;
	Tue, 16 Dec 2025 21:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqhbAorq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA7710E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvrP3cfCK+bMsRV0N1oDN5jrvulG50eU1nurTx/aKD0jONOFn3wbj6lvund8z17ioVprQ2bYisqkp9uGTkkeKyGKdptX+oVaNiXiLiOPnp3izTRjB3epr2W4vjOZWdactguovcEvS+770Io5M6N3pSNrrWdzObFG5FG7qIPZJ9VRROgQBTQjo2X55NoYlkUCHpZrVr75QCAuNOcxxbeaVOUtQhkzS8YeGuTPPGiQIXKPPoKCy0/mxACg0EWgcGq32mrzBE2qHFGzEcW3WMJMLXy3K2g6n6nH6xDEi7RxXyb8Pn8p4SGpyQoDn/SqDDxWbFkm56xBGP5OcmaSJy3TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpxrIB0pWrdzerG02Z4S/uy6ddNxR1vBOqVbtPfd6Oo=;
 b=uQihbTtZJxfbhfigMJu7sQuyKSTKqtl0ia0a5RuPfTlNJ4UGbQ3GzlQtnJ6Ooy/gd7J2DMClkfbAsbNn2kJZ4TCmVVFk+qGbHc8GElJEvuIInXXk4PClQME6CZHBuaKtxbNHFe84niEHEMaxl5UzBFfH8qPdEtWtcVBlAEX6giuhlfMEuG1L04P8lx0Gcy+SIZZAz9i+MMIP/G0lx8/xIyPZGfCxQFFjt5MaT0htoP51uL00Gp76f8YNPxAjTldZy4mXc2XIQd63TgDtYPj3rD1BJAX5NafbNyRNkuV7w5w2B/At0ujhrgcI5ZRLC1itD1jjVrVjy6x2XDf2Ue3D+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpxrIB0pWrdzerG02Z4S/uy6ddNxR1vBOqVbtPfd6Oo=;
 b=hqhbAorqjlTgj1Mn9/V0SXwsx00AcPGiRkyusLB8dzn9PZhsjWVW7ISYuz8cTn9qN5RbDVb7XdOlReqB5rEdy30GUoJzUb+OoOMOr789BDC5Y8l4KnvZQqrJGCO9+kEP7h60P+yIPswdjJMmNM+OeBS1JndJu1fhyqMDfd2q2F0=
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:08 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d1) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:08 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Implement CU Masking for GFX 12.1
Date: Tue, 16 Dec 2025 16:03:33 -0500
Message-ID: <20251216210349.1963466-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a70095e-4f75-4b3d-2c0d-08de3ce6a763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fvy3Qx5ZDFZBLKJHXDVrfI+Z4N0jDOv7rx8MAA2Czn+/yViucuCtX7+Ojtil?=
 =?us-ascii?Q?dg+yUe6aFfm8izGwsrPvQufFzIV7Gcu18Zb/Emj59pgX71VRGO8jSmgvVl8s?=
 =?us-ascii?Q?x0r8K0LhTdgSeeDnED156X09NZWjrhLawbdnYtNaQrZyf4H1bVZD9/+zJcL+?=
 =?us-ascii?Q?F7qtScT1sBJfO7EKmrhVtnpI2QqNX19vKIW78/HlzS9Vmbtl/ndpzI1balBj?=
 =?us-ascii?Q?OyoZ7iMupKp4vKE+neSdwng+Kd/oHiMtnhjvFRBPgHAqwHAcQMp1O5FcTh1U?=
 =?us-ascii?Q?+yEG38rggz/Rk9sZhHzif2ZNhZTvshnLUWIa8oVgyApzuIn1ePVjBrJAQFdO?=
 =?us-ascii?Q?Xc5rgjRUR6dezkI6HzCPp5/o0FD7Ykgl+YExtX4oXhXad4XnZt8yXVQfd/6r?=
 =?us-ascii?Q?/CchQQczRd5Z8PNPyj24KHYyHJ5/3gzD7EyyNGgdtrqgoR5uS0y+g8HnjGmj?=
 =?us-ascii?Q?hnjXe5e+UD51/LquC+0aG/EKqweLz82cO7EmjSqsGJuhaqhC44KdB9bgmmCk?=
 =?us-ascii?Q?+iK6MFGtMMxNvg/tDIvopO3BTVK8AFj03FFW1ciZt0KbK6ST+VBhk8zXmIg2?=
 =?us-ascii?Q?4zvEzu5I2PW28CouwggsLsejUfoksX5rKtrfpT9fH1ZzPMTA6su85hm/0eEM?=
 =?us-ascii?Q?sHHjDkIPBmQJAKI9NWvel+drZaXXBWTyRAK/2KUDDrnkYO0tHQ45IQJz9XIC?=
 =?us-ascii?Q?GR4XT8XL6CuWABPvBKs4/Da4nDJ0/0mkiYRqS4ZiglJnYwFs+wfrP/MlnoZ+?=
 =?us-ascii?Q?mS0tFZ2XJ/hu8ts+c4NolDdxUgmffIWDKa7PjUOrfuto8mS0Xua7BNWPtX7Y?=
 =?us-ascii?Q?B+/PMAfjc7PMpyaasuLeTpxrjLmDYRB6uSs1fTkH+qf7fb+a94a0zXFUWHeC?=
 =?us-ascii?Q?V3NPKQs3kWR7Woa+d7PTgDJuGFERCTmpIonQzp9vEj4eoUcHPu1IfTC4YaM/?=
 =?us-ascii?Q?6q8WOYoP/jtgXZDYktLYBd1xtwHpzs7qCOREhBpnSN/qhJZ0BUQ0RjKIBqZT?=
 =?us-ascii?Q?NOIbSg50aoUjcEgdbqbZXhPRS+pRXiV3mOihCtLmevne2aZf18ENPHdCfA5c?=
 =?us-ascii?Q?4hWiXlC8f9WtSC6qov4oqi4nuXkIJBGoznLSH3u+MYhfkZT+63XAO69Tgtbe?=
 =?us-ascii?Q?g6IOLAj8e2qRlRAn5VDJsKqPtEiEqY43QUyY/hBmzXWuCOPJjbtRUZPo1XzA?=
 =?us-ascii?Q?r98jALS43vLpm3NmKZyFE2Syomhqwr1nGZwA5HDaKOdee5Y2SPUOecnD726p?=
 =?us-ascii?Q?5IsmMlCy/ZAwo+8W3fhGaYGyiXdJv13ngOhJ4fEqvlu+kNBAystGu4OI4r3o?=
 =?us-ascii?Q?D0pTgiMUYslyL1iusokFKWVE1mNY/ZyS7WB8iZvPAiMhlC7F893kT0ZNA3Cb?=
 =?us-ascii?Q?90osWW/UkjJw7paCvN4ImHRF7b6tEibsxNE7mf3l+hueSzQh/TbOBh6q8u62?=
 =?us-ascii?Q?KpS2IyDhYdzTqGkByfGnJ44PtHt+WpVCzfNgvtSz3+V4MQPO9Mawv1tpWZvI?=
 =?us-ascii?Q?3cKtBYJz+Nkst0Xomj00ozDPpD3BMLGF8Jrn8b5hzaSY8hKFPtDOt8TYc2cw?=
 =?us-ascii?Q?P88TWE/aqY9Tm1sB3iE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:08.1205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a70095e-4f75-4b3d-2c0d-08de3ce6a763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add CU masking implementation for GFX 12.1. Add a local
implementation for GFX 12.1 instead of using the generic
function defined in kfd_mqd_manager.c because of some
quirks in the way CU mask is handled on GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 87 +++++++++++++++----
 1 file changed, 70 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 1d8c2c5612c6c..f1c2c9e8cf6bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -53,37 +53,90 @@ static inline struct v12_sdma_mqd *get_sdma_mqd(void *mqd)
 	return (struct v12_sdma_mqd *)mqd;
 }
 
+static void mqd_symmetrically_map_cu_mask_v12_1(struct mqd_manager *mm,
+		const uint32_t *cu_mask, uint32_t cu_mask_count,
+		uint32_t *se_mask, uint32_t inst)
+{
+	struct amdgpu_cu_info *cu_info = &mm->dev->adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &mm->dev->adev->gfx.config;
+	uint32_t cu_per_sh[2][2] = {0};
+	uint32_t en_mask = 0x3;
+	int i, se, sh, cu, cu_inc = 0;
+	uint32_t cu_active_per_node;
+	int inc = NUM_XCC(mm->dev->xcc_mask);
+	int xcc_inst = inst + ffs(mm->dev->xcc_mask) - 1;
+
+	cu_active_per_node = cu_info->number / mm->dev->kfd->num_nodes;
+	if (cu_mask_count > cu_active_per_node)
+		cu_mask_count = cu_active_per_node;
+
+	/*
+	 * Count active CUs per SE/SH.
+	 */
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
+			cu_per_sh[se][sh] = hweight32(
+				cu_info->bitmap[xcc_inst][se][sh]);
+
+	/* Symmetrically map cu_mask to all SEs & SHs:
+	 * For GFX 12.1.0, the following code only looks at a
+	 * subset of the cu_mask corresponding to the inst parameter.
+	 * If we have n XCCs under one GPU node
+	 * cu_mask[0] bit0 -> XCC0 se_mask[0] bit0 (XCC0,SE0,SH0,CU0)
+	 * cu_mask[0] bit1 -> XCC1 se_mask[0] bit0 (XCC1,SE0,SH0,CU0)
+	 * ..
+	 * cu_mask[0] bitn -> XCCn se_mask[0] bit0 (XCCn,SE0,SH0,CU0)
+	 * cu_mask[0] bit n+1 -> XCC0 se_mask[1] bit0 (XCC0,SE1,SH0,CU0)
+	 *
+	 * For example, if there are 6 XCCs under 1 KFD node, this code
+	 * running for each inst, will look at the bits as:
+	 * inst, inst + 6, inst + 12...
+	 *
+	 * First ensure all CUs are disabled, then enable user specified CUs.
+	 */
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = inst;
+	for (cu = 0; cu < 16; cu++) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if (cu_mask[i / 32] & (1U << (i % 32))) {
+						if (cu == 8 && sh == 0)
+							se_mask[se] |= en_mask << 30;
+						else
+							se_mask[se] |= en_mask << (cu_inc + sh * 16);
+					}
+					i += inc;
+					if (i >= cu_mask_count)
+						return;
+				}
+			}
+		}
+		cu_inc += 2;
+	}
+}
+
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 			   struct mqd_update_info *minfo, uint32_t inst)
 {
 	struct v12_1_compute_mqd *m;
-	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
+	uint32_t se_mask[2] = {0};
 
 	if (!minfo || !minfo->cu_mask.ptr)
 		return;
 
-	mqd_symmetrically_map_cu_mask(mm,
+	mqd_symmetrically_map_cu_mask_v12_1(mm,
 		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, inst);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
 	m->compute_static_thread_mgmt_se1 = se_mask[1];
-	m->compute_static_thread_mgmt_se2 = se_mask[2];
-	m->compute_static_thread_mgmt_se3 = se_mask[3];
-	m->compute_static_thread_mgmt_se4 = se_mask[4];
-	m->compute_static_thread_mgmt_se5 = se_mask[5];
-	m->compute_static_thread_mgmt_se6 = se_mask[6];
-	m->compute_static_thread_mgmt_se7 = se_mask[7];
-
-	pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
+
+	pr_debug("update cu mask to %#x %#x\n",
 		m->compute_static_thread_mgmt_se0,
-		m->compute_static_thread_mgmt_se1,
-		m->compute_static_thread_mgmt_se2,
-		m->compute_static_thread_mgmt_se3,
-		m->compute_static_thread_mgmt_se4,
-		m->compute_static_thread_mgmt_se5,
-		m->compute_static_thread_mgmt_se6,
-		m->compute_static_thread_mgmt_se7);
+		m->compute_static_thread_mgmt_se1);
 }
 
 static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q)
-- 
2.52.0

