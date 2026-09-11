Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E5FC88E42
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 06:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C45110F4E7;
	Fri, 11 Sep 2026 06:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="icCkqZ3S";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A90110F4EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 06:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4Qm/rS3iqn1R+wZycrWwdP/G2pHwpqhl1zZ693X3tJ1kbWf+AFn+2q4NevnhmQkAWp6rsqQw08D6XYrUJexYHT5usHJGcOyKX63T94MkW1EEmioQQ2bInveLSZ8xq7KidF2XHPeviasXacgoVBIjrLmJRlO8pXJwcIwX4vxnZRsBBVYoCl5TajqlALKBy+eGv73mBJHSewKoq1OpYPe9dbqe6UtJpQorYZqOUPyi4Evb4328GgdmXQqdf3/AKR9A+dhogUYdzmM6NlbivnFGjW47HufTeM9WV+6MwNP78eFSlAfJmhET+S5aY394wVQaVxAHReP8vYjxVW0TECQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnk2Um4VJDso9SDu55JNBb47AR9G2Pdf7Bn4ixFDNwM=;
 b=JlckEQ3dNJhOE1CIHcGm/SC/Nbv7vYIpan2nAN/t4/uvI0xVMEsahLk70ivcK4VxlUaFdehr7HjJICoqzHr2PswN5Imfnwk58TSrQLQSrueICaKR8CrpUVzGR2mAD6r/TgOIR2xataqyWo2hVDJplgWCFs9AYJ5yFkfGUt54a9l5u4deYnUuZY2mRxL4ot4QtR0t8wdidc5W2G2+ZNyLuK0ST+3S5JjX5Z+1t6fCw0k16DNLikr5wMci38+1Blp+k79CL0I15/3/08gOsE4bIpCBamwa1ujQI1fi6Fdasg1uI3hpxe7LG69Bsa7sAZWABEqgeBZ76AltxTPjhd3Hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnk2Um4VJDso9SDu55JNBb47AR9G2Pdf7Bn4ixFDNwM=;
 b=icCkqZ3SWA1RuCfeGmi9yKfeL6XtULeCWwgnDMNAKfVayMyN4qMx3JDZ2wfB2f1wy59mEyNdC23DXhDaof9gh0cvMfqu+KTdBsvRHKXLJgiCFE2TbfZJEc4fki1yLwkH4tmuOS7kn0kQN3/KwEaBWmzFaa8g8kwUaiCt3oCZtkI=
Received: from CH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:610:32::28)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:46:04 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::45) by CH0PR07CA0023.outlook.office365.com
 (2603:10b6:610:32::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 06:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 06:46:03 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:46:00 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/6] drm/amd/ras: retrieve ras error info via common interface
 and message for mp1_v13_0
Date: Fri, 11 Sep 2026 14:44:05 +0800
Message-ID: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 19449aac-965e-4425-7829-08df0fd05978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|3023799007|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 8m/JnX8WKQvcmfrdfVeanO++H7VAheUtbLpVF8Y9QaXnWNzEKMe2iq0uiHOGachZd9kW9wqB8xvwvRKbV66k9tvgrQZYvuNdb0nUybDDQEuWfLFQwU/du1riHozg7lN31s6bjZgWg+9yLNgIei1DpBUvP192vbYb3vhheLMLGhrOsMU+L5NwHWUskfCv9ehEWVqONQFpYToDr/cPoWcFkBhEqV0dDGDX7y9pjESH0+wpY5qZtcQRRkytEQ/If06Gcyo+jIFtganzwTdXgIENNQYBjBV/dxOmXWkSieQktjNy1xHplXjt/7oMQGULCMAY8b3T5csgBsqstVBB1nA8Ut0UC/OvSEXN9RjhFVQbA/1ynWYX5g4uJS3QWV3shW/7Yg3vVoRF9Hrh/rHjNOntpueenUHPDqFH6PEzwnqLm5jzRq+0Ne9+fuFRRyTAIU73BZGz+yOpiv8FQyMskcfZufMEwTmByTllnYqXns2p+fxVP2AL/VnbF8k7RNCFPyQL1XSWh7T7BknEALl/ERwEHUXbMltUK8YFAPS/08xpkW/NcPCxdEGKU19EicNMKjItTtC5OtrSnNujiUwLNpeAyZXKGhd8QTT42Xy3OE6x+QAbfw2gUi68DPZpdDxW/X45vmi/jTBtfm0f6gELfd8tu4dbe7QKbrsZ/ETgk706IH3OrCi4Gf8DuB2hXdgtRQ7vH7Z6Iuua964DKS1tcYcEjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Nn1gMeAwHm5s5UoU2QnxWDp5E9DvnSyKCnLOhxZCbwmzgHeRwrZQUGsLSVqEx4pcjcmxjhlXEtIELjS1s3qJznN1oFhJJbBAYHG4QJRwqRYTiXq6/Lz/aPwKEg/QapJrSq3TTBuUuQWBGJ0MATcAfwjJCenvTSwIca3yJlo2dLV8bPucTZYJMExV7ugpxzUoVzI5MJ/tWOjs3P97J4B5nSQdDCYVj7/fFbARQNCt2Th+8B6/N0yJ7oAu4q8JPa2QbI0CHrlfwQuGNp34h3+V4nZ9hZ9/pU1/ilg0EO34rLjE2T9p197RJirimfjpqIgZsKgSPh4tXil+OI5huCcymHBmRX2hTezdDB9xR0LIKqAVr7vXII02PykXKldStl4ZPdaOVCkEUfkFjWYhA1PnWwmGEZbm4Pr3jCwUCcbjjLy3fvJgi6rtXMs+Us0i6di
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:46:03.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19449aac-965e-4425-7829-08df0fd05978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
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

Retrieve ras error info via common interface and message for mp1_v13_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1.h        |  8 +++
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c  | 61 +++++++++++++------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c  |  4 ++
 3 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index d70070645ced..81d5f1eed676 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -25,7 +25,15 @@
 #define __RAS_MP1_H__
 #include "ras.h"
 
+#define MAX_UE_BANKS_PER_QUERY  12
+#define MAX_CE_BANKS_PER_QUERY  12
+
 enum ras_mp1_msg_id {
+	RAS_MP1_MSG_QueryValidMcaCount,
+	RAS_MP1_MSG_McaBankDumpDW,
+	RAS_MP1_MSG_ClearMcaOnRead,
+	RAS_MP1_MSG_QueryValidMcaCeCount,
+	RAS_MP1_MSG_McaBankCeDumpDW,
 	RAS_MP1_MSG_GetRasTableVersion,
 	RAS_MP1_MSG_GetRmaStatus,
 	RAS_MP1_MSG_GetBadPageCount,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
index 6fd746fe64c4..bdedaadd85b3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
@@ -26,30 +26,52 @@
 #include "core_status.h"
 #include "ras_mp1_v13_0.h"
 
-#define RAS_MP1_MSG_QueryValidMcaCount                0x36
-#define RAS_MP1_MSG_McaBankDumpDW                     0x37
-#define RAS_MP1_MSG_ClearMcaOnRead                    0x39
-#define RAS_MP1_MSG_QueryValidMcaCeCount              0x3A
-#define RAS_MP1_MSG_McaBankCeDumpDW                   0x3B
+static int __send_mp1_msg32(struct ras_core_context *ras_core,
+		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
+{
+	if (!ras_core->ras_mp1.sys_func ||
+	    !ras_core->ras_mp1.sys_func->mp1_send_ras_msg)
+		return -EOPNOTSUPP;
+
+	return ras_core->ras_mp1.sys_func->mp1_send_ras_msg(ras_core,
+				msg_id, &input, 1, output, output ? 1 : 0);
+}
+
+static int __dump_mp1_bank_reg64(struct ras_core_context *ras_core,
+				     u32 msg, u32 idx, u32 reg_idx, u64 *val)
+{
+	u32 data[2] = {0, 0};
+	u32 param;
+	int ret;
+	u32 i, offset;
+
+	offset = reg_idx * 8;
+	for (i = 0; i < ARRAY_SIZE(data); i++) {
+		param = ((idx & 0xffff) << 16) | ((offset + (i << 2)) & 0xfffc);
+		ret = __send_mp1_msg32(ras_core, msg, param, &data[i]);
+		if (ret) {
+			RAS_DEV_ERR(ras_core->dev,
+				"ACA failed to read register[%u], offset:0x%x\n",
+				reg_idx, offset);
+			return ret;
+		}
+	}
 
-#define MAX_UE_BANKS_PER_QUERY  12
-#define MAX_CE_BANKS_PER_QUERY  12
+	*val = ((u64)data[1] << 32) | data[0];
+
+	return 0;
+}
 
 static int mp1_v13_0_get_bank_count(struct ras_core_context *ras_core,
 			    enum ras_err_type type, u32 *count)
 {
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
-	uint32_t bank_count = 0;
+	u32 bank_count = 0;
 	u32 msg;
 	int ret;
 
 	if (!count)
 		return -EINVAL;
 
-	if (!sys_func || !sys_func->mp1_get_valid_bank_count)
-		return -RAS_CORE_NOT_SUPPORTED;
-
 	switch (type) {
 	case RAS_ERR_TYPE__UE:
 		msg = RAS_MP1_MSG_QueryValidMcaCount;
@@ -62,10 +84,11 @@ static int mp1_v13_0_get_bank_count(struct ras_core_context *ras_core,
 		return -EINVAL;
 	}
 
-	ret = sys_func->mp1_get_valid_bank_count(ras_core, msg, &bank_count);
+	ret = __send_mp1_msg32(ras_core, msg, 0, &bank_count);
 	if (!ret) {
 		if (((type == RAS_ERR_TYPE__UE) && (bank_count >= MAX_UE_BANKS_PER_QUERY)) ||
-			((type == RAS_ERR_TYPE__CE) && (bank_count >= MAX_CE_BANKS_PER_QUERY)))
+			((type == RAS_ERR_TYPE__CE || type == RAS_ERR_TYPE__DE) &&
+			 (bank_count >= MAX_CE_BANKS_PER_QUERY)))
 			return -EINVAL;
 
 		*count = bank_count;
@@ -77,13 +100,11 @@ static int mp1_v13_0_get_bank_count(struct ras_core_context *ras_core,
 static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
 			enum ras_err_type type, u32 idx, u64 *regs, u32 regs_sz)
 {
-	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
-	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
 	int i, ret, reg_cnt;
 	u32 msg;
 
-	if (!sys_func || !sys_func->mp1_dump_valid_bank)
-		return -RAS_CORE_NOT_SUPPORTED;
+	if (!regs || !regs_sz || (idx > 0xffff))
+		return -EINVAL;
 
 	switch (type) {
 	case RAS_ERR_TYPE__UE:
@@ -99,7 +120,7 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
 
 	reg_cnt = min_t(int, 16, regs_sz);
 	for (i = 0; i < reg_cnt; i++) {
-		ret = sys_func->mp1_dump_valid_bank(ras_core, msg, idx, i, &regs[i]);
+		ret = __dump_mp1_bank_reg64(ras_core, msg, idx, i, &regs[i]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index baf5f156fc6f..8dd4b678e13a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -26,6 +26,10 @@
 #include "ras.h"
 
 static const enum smu_message_type ras_smu_msg_maps[RAS_MP1_MSG_MAX] = {
+	[RAS_MP1_MSG_QueryValidMcaCount] = SMU_MSG_QueryValidMcaCount,
+	[RAS_MP1_MSG_McaBankDumpDW] = SMU_MSG_McaBankDumpDW,
+	[RAS_MP1_MSG_QueryValidMcaCeCount] = SMU_MSG_QueryValidMcaCeCount,
+	[RAS_MP1_MSG_McaBankCeDumpDW] = SMU_MSG_McaBankCeDumpDW,
 	[RAS_MP1_MSG_GetRasTableVersion] = SMU_MSG_GetRASTableVersion,
 	[RAS_MP1_MSG_GetBadPageCount] = SMU_MSG_GetBadPageCount,
 	[RAS_MP1_MSG_GetBadPageMcaAddr] = SMU_MSG_GetBadPageMcaAddr,
-- 
2.43.0

