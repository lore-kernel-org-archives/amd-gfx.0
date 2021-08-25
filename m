Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE0C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 03:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3225261371
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 03:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3225261371
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4FE6E103;
	Wed, 25 Aug 2021 03:10:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098FA6E103
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 03:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFOFdErBigTp4dxCuWcXcfLOn8o/T5IMjbI0Vmm9UC9yv2UXssOmAPjz7IMXOOlwHM/01pF2aeei4R1UIOiYrB1gc7FgQHfWCk9HKVtCuaHVP1rCQIWNd7+6p3mwVyX6QSuig110/nYulKGebEVg99wZy2b2cZf/sgKQasthCd3o1iDnamEqjvGJzsCml0GJxFds6pNlAiwoYCMqb+OtJs7/x23gHCbxjHf9O6wOQ3XnXI2Mv9ZbfKFyw23bhWg+UGiBGtFjg+SZytVs7jpf+mGc/1x40gxSO7+GFYxxj8z8FSDD+X3iDNvBTuP2qS/TuE1Cl3C0ar1PdSbupGcI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2u4dQ9ulCNFS53O7+DBNWfcpEX9XXtKzj7InDUVOGk=;
 b=CLwKqcdJfWaBV9t1Rl3axKiTWCix6jUKTGT9FfqSVMXsqAx1Q1ptRbT2i1gZazLPe3MBy8mvhywnqr/IfCXWYqy42kJS1rjXAewjnSqC24N0VJSXY+cJ9MRSPgUnVaXRuP/nEIZgY6TihiU/muZ4z9NF02MQkPYUZOVQCiMY9PeHSu6XmaS1Y++hK1Z0WwL9WwkpQecRjUsFqVr0MM1eQ5x/gqGxicroBDEUQdCTwP7gWJYfUXmWsR9CYAX/qtjnyy3oJzqLW4ckIYPNCoRAQBkshyN5h1Ab+fy0LVRvwmkLxIdkjfZDXQXVLzO+QbrDOlgVQF0i8nQWMkoDiB0Log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2u4dQ9ulCNFS53O7+DBNWfcpEX9XXtKzj7InDUVOGk=;
 b=ZWBHiEn4ykt50u+JEZ+NllRys4L2QIgFeCZr7T+UhJZPw/pHWJBTE5Uayosfumf2DVu/Nuy6WkyMyEsrbjUs/5Y8nBa3W6CKcTlyo7fiedlka8c/JJW8IeUED73yEVfqd2aDE6MKiK+7UFzhubsl/mip9ougRn9Aeqhwot+qYl0=
Received: from MW4PR04CA0187.namprd04.prod.outlook.com (2603:10b6:303:86::12)
 by BL0PR12MB2818.namprd12.prod.outlook.com (2603:10b6:208:37::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 03:10:31 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::d7) by MW4PR04CA0187.outlook.office365.com
 (2603:10b6:303:86::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 03:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 03:10:30 +0000
Received: from w6l.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 22:10:29 -0500
From: Sean Keely <Sean.Keely@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sean Keely <Sean.Keely@amd.com>
Subject: [PATCH v3] drm/amdkfd: Account for SH/SE count when setting up cu
 masks.
Date: Tue, 24 Aug 2021 22:10:15 -0500
Message-ID: <20210825031015.96536-1-Sean.Keely@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbf9785-bc85-44bf-1229-08d96775e571
X-MS-TrafficTypeDiagnostic: BL0PR12MB2818:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2818B0BE5A74A66DCFC8711994C69@BL0PR12MB2818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NX8cYYSAyhYp+nczobS1oNbGfSjHHEWkDj1sMJZ6BmfAaRc46hY4yRWQjLLTo6x2EKQXvkuwpRjT/B8LZIEKhIMlRrtQy3qoJ109QGtjUMakU1KelmrjU6Vm5VZwSVgwuPDAHcESLFEqSS+UFJZED6iq9+N23YMg7KOXONxd7/9C5+8PF6EV0eBYIY35g2uAq6g/d/w1lrkq2Y4DsWap8FxyXPsfbrLvS2S006J1OvTSY2LsCSbIHX6hmKqeN3kB3t02ywp5mKVbVeDlR325NVrquqG5Wng6FbQ/+bP5dbXvLqeg3Y+zERk1pLVS3QU/wPBY/iADQNmSARM307j0VZIbCR+FqGZWJF52XdbgPrgYTNLgqzthv3AChT8wKNaUBh1arEVxJBwVSQgBubRQH4B7H6KpRDrDL9rn4uY6loQkI7UzNiqwaZtE8lMUQQkVreZIahpzuAGsLW/tMrMHx5ZOhUL2FP1IIl5+LKl9iXLGa3gdg0IxolipZiIrhmO2cKQRlzjXR58RUwgRC3FffG5FPT9s1OVJTojp5h+Fs+CVktRSKQZgUrXWQyfofnpJpJFziEwt0z9ZYJEdL+bs32Xly4MNKh4oAGHXE0sDGiux6twjLTRo1ASeBIQdLhVMMkaOC5w3wpJ5z2WRxnMFr6a17gidPvDaxoqzT7fhVKw2bdz+3aTt07pLZbI3Piln8PneNip9kCSRmpSBlqIUal4uvK5HyU+6JHdnZI4Nlpc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(36860700001)(86362001)(478600001)(186003)(1076003)(16526019)(81166007)(2906002)(316002)(82740400003)(83380400001)(36756003)(5660300002)(356005)(8936002)(26005)(8676002)(7696005)(6666004)(82310400003)(70586007)(70206006)(426003)(4326008)(336012)(2616005)(47076005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 03:10:30.6254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf9785-bc85-44bf-1229-08d96775e571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2818
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

On systems with multiple SH per SE compute_static_thread_mgmt_se#
is split into independent masks, one for each SH, in the upper and
lower 16 bits.  We need to detect this and apply cu masking to each
SH.  The cu mask bits are assigned first to each SE, then to
alternate SHs, then finally to higher CU id.  This ensures that
the maximum number of SPIs are engaged as early as possible while
balancing CU assignment to each SH.

v2: Use max SH/SE rather than max SH in cu_per_sh.

v3: Fix comment blocks, ensure se_mask is initially zero filled,
    and correctly assign se.sh.cu positions to unset bits in cu_mask.

Signed-off-by: Sean Keely <Sean.Keely@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 84 +++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h |  1 +
 2 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 88813dad731f..c021519af810 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -98,36 +98,78 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		uint32_t *se_mask)
 {
 	struct kfd_cu_info cu_info;
-	uint32_t cu_per_se[KFD_MAX_NUM_SE] = {0};
-	int i, se, sh, cu = 0;
-
+	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
+	int i, se, sh, cu;
 	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
 
 	if (cu_mask_count > cu_info.cu_active_number)
 		cu_mask_count = cu_info.cu_active_number;
 
+	/* Exceeding these bounds corrupts the stack and indicates a coding error.
+	 * Returning with no CU's enabled will hang the queue, which should be
+	 * attention grabbing.
+	 */
+	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
+		return;
+	}
+	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
+			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
+		return;
+	}
+	/* Count active CUs per SH.
+	 *
+	 * Some CUs in an SH may be disabled.	HW expects disabled CUs to be
+	 * represented in the high bits of each SH's enable mask (the upper and lower
+	 * 16 bits of se_mask) and will take care of the actual distribution of
+	 * disabled CUs within each SH automatically.
+	 * Each half of se_mask must be filled only on bits 0-cu_per_sh[se][sh]-1.
+	 *
+	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
+	 */
 	for (se = 0; se < cu_info.num_shader_engines; se++)
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
-			cu_per_se[se] += hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
-
-	/* Symmetrically map cu_mask to all SEs:
-	 * cu_mask[0] bit0 -> se_mask[0] bit0;
-	 * cu_mask[0] bit1 -> se_mask[1] bit0;
-	 * ... (if # SE is 4)
-	 * cu_mask[0] bit4 -> se_mask[0] bit1;
+			cu_per_sh[se][sh] = hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
+
+	/* Symmetrically map cu_mask to all SEs & SHs:
+	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
+	 *
+	 * Examples
+	 * Assuming 1 SH/SE, 4 SEs:
+	 * cu_mask[0] bit0 -> se_mask[0] bit0
+	 * cu_mask[0] bit1 -> se_mask[1] bit0
+	 * ...
+	 * cu_mask[0] bit4 -> se_mask[0] bit1
+	 * ...
+	 *
+	 * Assuming 2 SH/SE, 4 SEs
+	 * cu_mask[0] bit0 -> se_mask[0] bit0 (SE0,SH0,CU0)
+	 * cu_mask[0] bit1 -> se_mask[1] bit0 (SE1,SH0,CU0)
+	 * ...
+	 * cu_mask[0] bit4 -> se_mask[0] bit16 (SE0,SH1,CU0)
+	 * cu_mask[0] bit5 -> se_mask[1] bit16 (SE1,SH1,CU0)
+	 * ...
+	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
 	 * ...
+	 *
+	 * First ensure all CUs are disabled, then enable user specified CUs.
 	 */
-	se = 0;
-	for (i = 0; i < cu_mask_count; i++) {
-		if (cu_mask[i / 32] & (1 << (i % 32)))
-			se_mask[se] |= 1 << cu;
-
-		do {
-			se++;
-			if (se == cu_info.num_shader_engines) {
-				se = 0;
-				cu++;
+	for (i = 0; i < cu_info.num_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = 0;
+	for (cu = 0; cu < 16; cu++) {
+		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
+			for (se = 0; se < cu_info.num_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if (cu_mask[i / 32] & (1 << (i % 32)))
+						se_mask[se] |= 1 << (cu + sh * 16);
+					i++;
+					if (i == cu_mask_count)
+						return;
+				}
 			}
-		} while (cu >= cu_per_se[se] && cu < 32);
+		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index b5e2ea7550d4..6e6918ccedfd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -27,6 +27,7 @@
 #include "kfd_priv.h"
 
 #define KFD_MAX_NUM_SE 8
+#define KFD_MAX_NUM_SH_PER_SE 2
 
 /**
  * struct mqd_manager
-- 
2.25.1

