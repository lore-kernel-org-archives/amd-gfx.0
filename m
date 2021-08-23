Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D4DC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 21:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E8A611CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 21:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1E8A611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7BD89BF8;
	Mon, 23 Aug 2021 21:53:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A9A89BF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 21:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diXhesn8SiVoVlybG5VLCLd+TEm/afVlZq9bAnbcFgmmyofLxdbGF8EQotenagGsP7bvz0Eo7mMeVSE2khwHGP5vGbExIB3okvBz0ttxD67umZdcG9WIabBdLKex/0tzwvP3PKBjiynysxWaMkFPfHGdQRtSXczrzIeu2b71dMJXNC6Wf9mJv2LgHU1tcTR0PeHAzj/cS6EOGEt+9grd2j+9xofCDH+ggbX/TwG6Xzr0XZ5yvFGTZ3BueGp0BD5UabC3Mf5XsdSoIy+8NWgvU4D6oVl1rFmzmvvI9vdk2q8mr8xSaK9vu34IWYbY6mFdqrcMXJY6iSNsbpm2dcIlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hxEOKDI6Oj4wxg9QBmokfGtklvFc/i+YYb/0XiX3VQ=;
 b=F3THDzyq40L4TESOYD2llfeSg27MXrTsmGH4xcIj0iLYfZbpCXySoswVhgoCljg7tUquSCGqA0O6TdWeVoIEWo/kY3bjp0Zbs9sMaf5X1NfNW+mTzHt3Nz9lG5B4r1b2/v9p/1uMm7A9nELJAV9Ci7vd9lEAcPA6FY3ZA7cdQXUsZ8ZQ3rwn3rsBxqrVOMLVqbc2pD+qFIUDIcMIu+L/PaPRTtaDga2B5617RgB0LVvbTcei3uWYEX/3oBIfIGuTb0hLOXS6HQ85zjaqn1Etle1+kc4XEpvADp1myeUopYuUtRz26I4YftieNmVO5fgvn7GiPkeMqcWtTJH1uZn7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hxEOKDI6Oj4wxg9QBmokfGtklvFc/i+YYb/0XiX3VQ=;
 b=ZFFzwo9/fU2ai4CvPDvFTHaDIJiUYYIheAujIfFXtLvG3rfvCj9hswtd9JYSIJKwdFTwi/XnIeP5hf5mQWHnJ2fkNfIEVUHDs/H6OqAuemdHh5Bk0CIvM11zp972ez6hrqfHnPb2JgNbaHZIZYR/Ao9/PocVzQtOC/LYbHR5iKE=
Received: from BN8PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:60::21)
 by MN2PR12MB3904.namprd12.prod.outlook.com (2603:10b6:208:165::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 21:53:13 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::ed) by BN8PR12CA0008.outlook.office365.com
 (2603:10b6:408:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 21:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 21:53:13 +0000
Received: from w6l.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 16:53:13 -0500
From: Sean Keely <Sean.Keely@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sean Keely <Sean.Keely@amd.com>
Subject: [PATCH] drm/amdkfd: Account for SH/SE count when setting up cu masks.
Date: Mon, 23 Aug 2021 16:52:46 -0500
Message-ID: <20210823215246.82989-1-Sean.Keely@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 430f74ed-3eef-4b6c-aa82-08d966806820
X-MS-TrafficTypeDiagnostic: MN2PR12MB3904:
X-Microsoft-Antispam-PRVS: <MN2PR12MB390490875DCA40B073AAF3C994C49@MN2PR12MB3904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoDlbxNPFBnzxar/a0Lknjw17Etn0FrdQb6n0EpJvDhQhUAOg/CejmCg/hYztMzpUcx2wXZckW4I8pwb4kXVNM7y2DI7Y+i/+bcjMy67KmGRAgO/bgmaj1z8UzsNAB0rwLHWxDNmSOEQ5hB2cqQIBtCjRo9vFp35JM/8QTiePusYkpD2qWbq7cQ30hX1qrx8cADT1/7KjoLollC3E3KCT8tXQO7mqntPJnUMlX7W+LDXvQlGc6x9rR4CT46Cvj/VPrwNX1kEXXRLdnnXezE+zIGgLRDaU4oSsCLoAFNHX+MFEuWLZuefxszi0CXKLbPWJKGJZuwPwmU3GuxR7z3gAp03mEmhapl8kOoVQjGpHbXYejNdcpJkOo2kU1RLvVhnLgNbcZ3xOUJCoFa94zJF/rjxAYfXEh2htddkA78PJiATUSc3eVvT6k94XPrd9GZkxbeif6VSMHn8fyp3rhz54rFGyzgAAb8F2cdOt/3EN4/YwsBfH7rK794W/cMvgg7x7GrZcR06BDYu1Fh8nsgsmlcfaIz35sEXsU8v4ZQ8zNrmjj9K71nbZQ6x3ECdr7h5M6cSFwnALVZMejeyZunAIVoK0C4LJd4Kjn7bzYx4b0Czr1sfXsbf4bE0+4UA7mHcaSMW4wnXFbYLb1RVszEbYAZUJq7EHkqlqWwz2WQpXC/E0lSg4LHtsbl9J03M7ErxOZ1GvnBbgQ4LfPvRbj4LAS/5/Vk9fYUEFi3186zt54IdiIrCg9RIRZ3xXAKki1KwW8reJvp/D3YmRV4usLi9gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(2616005)(6916009)(186003)(36860700001)(70586007)(508600001)(36756003)(81166007)(47076005)(34020700004)(82310400003)(86362001)(316002)(6666004)(70206006)(8676002)(4326008)(5660300002)(1076003)(16526019)(2906002)(7696005)(426003)(83380400001)(8936002)(336012)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 21:53:13.8014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430f74ed-3eef-4b6c-aa82-08d966806820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3904
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

Signed-off-by: Sean Keely <Sean.Keely@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 79 ++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h |  1 +
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 88813dad731f..39d018c10146 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -98,36 +98,73 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		uint32_t *se_mask)
 {
 	struct kfd_cu_info cu_info;
-	uint32_t cu_per_se[KFD_MAX_NUM_SE] = {0};
-	int i, se, sh, cu = 0;
-
+	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH] = {0};
+	int i, se, sh, cu;
 	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
 
 	if (cu_mask_count > cu_info.cu_active_number)
 		cu_mask_count = cu_info.cu_active_number;
 
+	// Exceeding these bounds corrupts the stack and indicates a coding error.
+	// Returning with no CU's enabled will hang the queue, which should be
+	// attention grabbing.
+	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
+		return;
+	}
+	if (cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines > KFD_MAX_NUM_SH) {
+		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
+			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
+		return;
+	}
+
+	/* Count active CUs per SH.
+	 *
+	 * Some CUs in an SH may be disabled.	HW expects disabled CUs to be
+	 * represented in the high bits of each SH's enable mask (the upper and lower
+	 * 16 bits of se_mask) and will take care of the actual distribution of
+	 * disabled CUs within each SH automatically.
+	 * Each half of se_mask must be filled compactly, LSB first.
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
+	i = 0;
+	for (cu = 0; cu < 16; cu++) {
+		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
+			for (se = 0; se < cu_info.num_shader_engines; se++) {
+				if ((cu_mask[i / 32] & (1 << (i % 32))) &&
+					(cu_per_sh[se][sh] > cu)) {
+					se_mask[se] |= 1 << (cu + sh * 16);
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
index b5e2ea7550d4..427745fa4278 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -27,6 +27,7 @@
 #include "kfd_priv.h"
 
 #define KFD_MAX_NUM_SE 8
+#define KFD_MAX_NUM_SH 8
 
 /**
  * struct mqd_manager
-- 
2.25.1

