Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE8AC88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CFB10FA34;
	Tue, 15 Sep 2026 07:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+zM2fdX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A6A10FA39
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAj/450K05yy4dh80UdsON7qwJEaS6A3slrbYh3/rAGI1MjRVt2BQj32MAD2lCh9fpUcnoyl+RRw7m2T86OwQ8NfZ3tVT7jHJPSERwEiAADtQmuuKzLYW/zuwZBQ/HS1czIx6sV/OLhrRagkT1D3f0mVLV6hyHSwtDccHleXunIhTxOJ2BvmgHiUF5p9Pu6GP1ELCQOUSS3fGAm5IQwsldiSSDThq4ia59ECxbtQHqi2FyXbgk/f8SIfij3Js0UZRFN65SRlK4p6DS2ijDIYlpFJui5qkkatLItgOJG9KUUbETNGeg35c/5MNJm98y4RsbDcHwsraow9UCMCruMDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEz/ywiDAbQg7L84bFWh0bCg/3fzpDGeI1QY9SD4494=;
 b=w0GnBBD2hU3KYwJzCoQUnUDu+5fTC+ESM5Y+yotLfb4vWcteJcAK+EokH3LFiFYqi2RVzsGdiRWUeptuO4aV2MPzcRub+fGfKcqEjkk8aPXaUP4tjn8grqYqD/LiKX+waNpE0SC0mImyNO4qex1PtdtwEFtjyxprOZoCkjIO5738PlpgOWpbB1UuHK7UEmXCgh6BpMKbIUWI/0dx+i7aejxtfmfdz8GxpGGk6jL1M8eVQBukOV7vctpwW8isxtaENhH+BsJv7ruHOYDNu52qWkXERynhIib0NWBlOLz5K+6TNRrx35Tq3JVdZH8ybT6RcqsisOnu52htH/eJ/D8LVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEz/ywiDAbQg7L84bFWh0bCg/3fzpDGeI1QY9SD4494=;
 b=p+zM2fdXNytEo/DX6wpcGJVL5icMQXHhYL/gG1xgbsvj8TydwedlBeM+6AM8GtSdiT2OqIZtsX5RuzwgZ6jR7ZGIEqqQNmvUusZ+lYUOcZlsxitQ1dPyCF5/sCF/qCht1o+MgR69HPo6ahPoglImjEp88Llct09nBJ/Z53mCrw4=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:29:57 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::51) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 07:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:29:57 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:29:54 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: record CPU RAS errors on GPU with lowest
 unique_id
Date: Tue, 15 Sep 2026 15:29:18 +0800
Message-ID: <20260915072919.1751338-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: f21095ac-28a0-4ec5-6183-08df12fb24b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6xJpHfD84DTuN7Nxr5iyjaJ0tG0oqKfZGxGmRCz/Z+i1u2GVRGMH92D2vZOTzNXXq1WyzbjPL+XegS28nmfjBFqRDM81fK5FEy0LnRMAhmmgV68HrtviHldLZTbcvJ8ufGSpIRufwXJNKvJcmO1gaiWshx3WArp2eIN+d1qdsmqhD7so0c3QbcjDx+f2TYLKJKmZKhsbMz77hFC41FnjFdDZdBvx74H/CPFMWPZEFBDRylcm5ns0Vgi2zHyXYvmzL1xzYp4tuwJXZPIEYuma8ZS7+1CKsKiFvcMSY4lqjNkolvSB8el3oQgt4CE6EpD/VQZXkJrTeDHIt5paim/VTr9EHEZGQ5z2kWjfdDEAlQHb/kdTQThrRH8Xx4BvPYMImz9EOtU+Jukzl9RcLQbbgk1tGR2qiuE1DXP1tKEhYi3196KPpNKBjkE+E2UUdEBG+Qm9wmbzH/RO0NM+vatGEeHM5whMkP5p9ztMOcVqxeIXich6gboyAaycyZ91Nqqlw8KeWk0mU8KYI1Qo7qmJVrD1WZ28EJxGxgtUKnOIljVMUVIkXdhxTHO4Z6MyWgHdy+g1l6FRpP7QdSzz6VsY0fyzblrKgJfKc9ttMEjA3fOS4E5eQi62GFBs/niC3WQnwP3b8U38zpdTNDQp8w4FXz6FZH1Qq5mPGYbOmXAe518sUia+MV/JDkWBhnAZ974DG1he3BYx80Nl/KBJEUw75w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHmtBNCxGN8M/nHPU3SDTlTSs91Fo4x1jpdGftvewD13TBZFkqIWaqx1xPOBm0C0pn4e0eJfOrhwoSCJIY7fcWaE1zUaONFc1YDCSMh2jBk4jVo/qBvFW5go+RjLuXfQISOP4OMtTtvVgXMtx1IliRX4mOXOHHcwyxQLKi4v+xSAG+c9ehVsaEV5duapzslUE7havQxavbVdxu65lFPGtiFo+mf0kqf5KjYHM+7GfB5ek2LPVypATO5lG8fLDpi8tGN3LWkopOgWGo8tRQyglbVTZau7bys3bk2Ptic303+IOPfKitFq7xS9833/f3Is+O6ZemunVtJ28MQQ0E0W7zMQx7fjIGyvAcMuBrZS2zrmxqHWhcBauDpGB6OpWR2OjSy7y7xMbXHzsLg/nZLqPzN4ZVEYNWA4+T081AS3HQiWWueXBdzfRzHetZLRzmlM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:29:57.0517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21095ac-28a0-4ec5-6183-08df12fb24b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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

CPU RAS CPER records are now written exclusively to the GPU device
with the lowest unique_id across all present amdgpu instances.

This provides a stable, hardware-anchored anchor point that remains
consistent across driver reloads and system reboots, allowing users
to locate CPU RAS error records by looking up the corresponding RAS
CPER file on the GPU with the lowest unique_id.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c  | 54 +++++++++++++++----
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  1 +
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 73e3960c7c8e..5f133f3a8277 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -249,6 +249,7 @@ struct device_system_info {
 	uint32_t device_id;
 	uint32_t vendor_id;
 	uint32_t socket_id;
+	uint64_t unique_id;
 };
 
 enum gpu_mem_type {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index 6bb8bc1b52a9..dc0ce9ca9a85 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -31,7 +31,7 @@
 
 static int amdgpu_sys_mce_notifier(struct notifier_block *nb, unsigned long val, void *data);
 typedef int (*mce_notifier)(struct amdgpu_device *dev,
-			unsigned int id, unsigned long val, void *data);
+			bool is_primary_dev, unsigned long val, void *data);
 struct ras_mce_dev {
 	void *dev;
 	mce_notifier dev_notifier;
@@ -43,6 +43,7 @@ struct ras_mce_mgr {
 	atomic_t ref_count;
 	struct notifier_block nb;
 	mce_notifier notifier;
+	void *primary_dev;
 };
 
 struct ras_mce_mgr  g_ras_mce_mgr = {
@@ -52,6 +53,24 @@ struct ras_mce_mgr  g_ras_mce_mgr = {
 	},
 };
 
+static void *ras_mce_select_primary(struct ras_mce_mgr *mce_mgr)
+{
+	struct amdgpu_device *primary = NULL;
+	struct amdgpu_device *adev;
+	int i;
+
+	for (i = 0; i < atomic_read(&mce_mgr->dev_count); i++) {
+		adev = mce_mgr->devs[i].dev;
+		if (!adev || !adev->pdev)
+			continue;
+
+		if (!primary || (adev->unique_id < primary->unique_id))
+			primary = adev;
+	}
+
+	return primary;
+}
+
 static int amdgpu_sys_mce_notifier(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct ras_mce_mgr *mce_mgr = container_of(nb, struct ras_mce_mgr, nb);
@@ -61,10 +80,17 @@ static int amdgpu_sys_mce_notifier(struct notifier_block *nb, unsigned long val,
 	if (!data)
 		return NOTIFY_DONE;
 
+	if (!atomic_read(&mce_mgr->dev_count))
+		return NOTIFY_DONE;
+
+	if (!mce_mgr->primary_dev)
+		mce_mgr->primary_dev = ras_mce_select_primary(mce_mgr);
+
 	for (i = 0; i < atomic_read(&mce_mgr->dev_count); i++) {
 		mce_dev = &mce_mgr->devs[i];
 		if (mce_dev->dev && mce_dev->dev_notifier)
-			mce_dev->dev_notifier(mce_dev->dev, i, val, data);
+			mce_dev->dev_notifier(mce_dev->dev,
+				(mce_dev->dev == mce_mgr->primary_dev), val, data);
 	}
 
 	return NOTIFY_DONE;
@@ -110,7 +136,11 @@ static int amdgpu_ras_unregister_mce_notifier(struct amdgpu_device *adev)
 
 	for (i = 0; i < atomic_read(&mce_mgr->dev_count); i++) {
 		mce_dev = &mce_mgr->devs[i];
+
 		if (mce_dev->dev == adev) {
+			if (mce_dev->dev == mce_mgr->primary_dev)
+				mce_mgr->primary_dev = NULL;
+
 			mce_dev->dev = NULL;
 			mce_dev->dev_notifier = NULL;
 			atomic_dec(&mce_mgr->ref_count);
@@ -141,7 +171,8 @@ static void __fill_mce_to_aca_bank(struct amdgpu_device *adev,
 	aca_bank->regs[ACA_REG_IDX__SYND] = m->synd;
 }
 
-static int amdgpu_ras_mce_notifier_v1(struct amdgpu_device *adev, unsigned int id, struct mce *m)
+static int amdgpu_ras_mce_notifier_v1(struct amdgpu_device *adev,
+		bool is_primary_dev, struct mce *m)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	struct aca_bank_reg aca_bank = {0};
@@ -178,7 +209,8 @@ static int amdgpu_ras_mce_notifier_v1(struct amdgpu_device *adev, unsigned int i
 	return ras_mce_add_aca_bank(ras_mgr->ras_core, &aca_bank);
 }
 
-static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev, unsigned int id, struct mce *m)
+static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev,
+		bool is_primary_dev, struct mce *m)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	struct aca_bank_reg aca_bank = {0};
@@ -193,16 +225,16 @@ static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev, unsigned int i
 	if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_GPU, m->bank)) {
 		bank_type = MCE_BANK_TYPE_GPU;
 	} else if (ras_mce_check_bank(ras_mgr->ras_core, MCE_BANK_TYPE_CPU, m->bank)) {
-		/* For CPU bank, only the first registered gpu device needs to record bank */
-		if (id)
-			return 0;
-
 		bank_type = MCE_BANK_TYPE_CPU;
 	} else {
 		RAS_DEV_WARN(adev, "Unsupported mce bank: %u\n",  m->bank);
 		return 0;
 	}
 
+	/* Only primary gpu device can log cpu ras error */
+	if (bank_type == MCE_BANK_TYPE_CPU && !is_primary_dev)
+		return 0;
+
 	__fill_mce_to_aca_bank(adev, bank_type, m, &aca_bank);
 
 	if (bank_type == MCE_BANK_TYPE_GPU) {
@@ -223,7 +255,7 @@ static int amdgpu_ras_mce_notifier_v5(struct amdgpu_device *adev, unsigned int i
 }
 
 static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
-			unsigned int id, unsigned long val, void *data)
+			bool is_primary_dev, unsigned long val, void *data)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	u32 aca_ip_version = 0;
@@ -237,9 +269,9 @@ static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
 
 	switch (aca_ip_version) {
 	case IP_VERSION(1, 0, 0):
-		return amdgpu_ras_mce_notifier_v1(adev, id, data);
+		return amdgpu_ras_mce_notifier_v1(adev, is_primary_dev, data);
 	case IP_VERSION(5, 0, 0):
-		return amdgpu_ras_mce_notifier_v5(adev, id, data);
+		return amdgpu_ras_mce_notifier_v5(adev, is_primary_dev, data);
 	default:
 		RAS_DEV_WARN(adev, "Invalid aca ip version:0x%x\n", aca_ip_version);
 		break;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 291b2a96cbb5..dd8cdc2811f8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -226,6 +226,7 @@ static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context *ras_co
 	dev_info->device_id = adev->pdev->device;
 	dev_info->vendor_id = adev->pdev->vendor;
 	dev_info->socket_id = adev->smuio.funcs->get_socket_id(adev);
+	dev_info->unique_id = adev->unique_id;
 
 	return 0;
 }
-- 
2.43.0

