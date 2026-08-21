Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22253C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A60E10F348;
	Fri, 21 Aug 2026 16:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZpKM9vE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBB610F36E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfOyazRtxBfJ6f9Zkgr7GyaJbhncJ4SqKQHKBJJRNj9QjSr5WdajxMzqDKPQMTQ714WWtxuujRlw6FjhaG4CS7iCwTtaN4mLEO6lbtVOAPjZZ291cj/3N1tD4nOGoY6vu3CMP/x8QwasfNDACyCma1BJS3RNNhP1bZV4sOg90o0M4Eal42pgVDAR5x2yIo2fuB8EjiDgpixdBp91/dob1oOHKNRn8QPz5wQbj6hn95TmU9zeAaGfik1QPHPL0qz9s7mEmb0D8myS4T4t5ab1q4unz5VapV8V6EcYydhfsNJ8UI7OTuTICp8NhtZeANuKUiJ2aTc6nwtIxAbNl0shBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSiCM8m/l0JAb6ybotfm86VADXHri0UGsmiHs+bgNKg=;
 b=cT5whKd24FUG1pywbUJG+e0TbduYb8J/nsUlc8UTaz2MAd7LzbrOfmXbohOiEIwOWV8lB3ge172fOB8A1fvIoZ3Md3uVBVCnUKNx4y4rYUrYKfV3jb0gl70aej54yQvHUJds3oHAmOB30xYWPmC6lOEdPhbXW2fHjxRPDoX3dwZG2I5QU5FXJuvUKviHj0KDq7vhx9YRhXBut6giXFNf2lRMcvfaERbBvJ/aq/3G556WHiGgi9Da5tmVxHp1l6sjNGaQFhSiDADHUSUw74B2vNLgNT36feqOP4A9T0g24fS7dJ1+JIg70Pj/20/5KHXMeoV7DBcaEoDLMiBVtEszrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSiCM8m/l0JAb6ybotfm86VADXHri0UGsmiHs+bgNKg=;
 b=VZpKM9vE1usJGBKQEusto3vU2pX7HUBC5/i2hpUKgbe5xjcgIrUMF19lnZJpftR8pQpav0ZlY1YiKHVA5Wp+Q+fwWya0bA/4dCsbTTpAD0We3t47WvwWv1Z5xKrZkmXNnnggvepx+gS55mbvO5ErnKCok5UCqp0We2XARGlvBvo=
Received: from CY5PR22CA0096.namprd22.prod.outlook.com (2603:10b6:930:65::18)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:11:59 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::3a) by CY5PR22CA0096.outlook.office365.com
 (2603:10b6:930:65::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:11:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:11:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:11:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/amdgpu: Add soc_v1_0 reset handler
Date: Fri, 21 Aug 2026 12:11:46 -0400
Message-ID: <20260821161147.753435-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161147.753435-1-alexander.deucher@amd.com>
References: <20260821161147.753435-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b2faa0-8d44-4aa4-40b3-08deff9eed36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oDgMB+2sQAQgR+Eu5g1W5H5A0OyaGFUi9+Si73xd4RlbXelcCX0lbqxjp8x3HvPeEAiDcqXw/sLCWfTuYPLJbtDi90q4x4XrFqzI15H+JE3XUB1sM5ri/5RyPBM8YwC8N1/zbRDqnIAH8dxVMahqlqh8+zOb+VYj4XzPGAHtlmGH25f7REl7VCdShjupm0Juziq5t9pHiw+bBBIehckd14QDK3BVB6j2eNU5tZrMPjEmey0m42tK8mU43mKfJDUOT1kNSkswpZPfd6neMnxlkXCN2kfJ39OB3Uk3xecvqUfzOOVkEyG3UNNQhIDoYMgaHyfviEsSYSfoaViOmlRaFRFyeIiq3RTcHr7PbEhTPCeLxNhJwsYJhMFKaUmtcYFCNEpJX7Ws7OqSAeJ//giYN784YIy7GIK5rx2Yi+uBFKnNzcPNlBRbhHhHqm8FNmHH2z2o/M8NlDPZ39i0O0iIgfUmdUFfNBR9rA2T2Fi7Z98W8B3uUr0WZH+Qi4+9xUrxBgcLuNfpaf4TED3ed/ekSiWBug8ru43s4Zh+1NmeCxcyfkkfSn92HIEEXhpshGyPKbDK/+IfQJbZQmxvk39GxmamQ5VvROBRJaMGgGYeiv4lheK/SFGnVeb2pz1K5wHHSu7h+NeD1n5hLwQBhh+J8xQ6sFJELBCq/3sRoRGRq3c6EYmi1aFrCT58mVJR5EIcGBezPZgGIMxXoha3dt+hrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OH23A/X3qHIZUpCKQX9cDpoxmxqyJ+3y9Vhil56RiibECDVyjev6UyFJyCwJm7SR62rUlAHLQLx7CQ5VS6E5L2JTfLPh5qzOecmFHFeySCPitY9vegLSEC6ZMIW/XFjU0t2jntjkxKa2gk7yFdzeM+wGwiWxdr+fcgUXc0/V1bRMn+cp5Ynt1u+TytLNcrE/ezAaUpPNcVr1OhOUiMYxflsPjLXnoC4LYScNwvIVVNDrqOYebc1TYx1wCg4yycgac+daYPGXrstbBYFpI4o69WNLXV6HI/8hOFJ6PwRj2BsMU8PXTcL64/tneRw/T5XIIkmGtH876i8wddd4Af1uETxGcJVTIDtMV7b3YdC1qv6OKK/SCxu89IhI39PuemDy4FzwTiSMwJt1zPaevsHorGgVj9nHGhJpCbvMsQmb4FtGsls+i1immViRyc53DM/V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:11:57.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b2faa0-8d44-4aa4-40b3-08deff9eed36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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

From: Asad Kamal <asad.kamal@amd.com>

Add soc_v1_0 reset handler for mode2 reset

v2: Remove XGMI parallel reset dispatch and xgmi_update_topology()
call, reset on soc_v1_0 is per-device only. (Lijo)

v3: Remove ras as will be plugged later as separate ip. Remove vcn from
ip mask as vcn not part of reset sequence yet (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 283 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h |   2 +
 2 files changed, 285 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 5e40fb0cdaf2a..5b18a5c8114ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -30,6 +30,7 @@
 #include "sdma_v7_1.h"
 #include "gfx_v12_1.h"
 #include "amdgpu_video_codecs.h"
+#include "amdgpu_reset.h"
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
@@ -398,6 +399,288 @@ const struct amdgpu_ip_block_version soc_v1_0_common_ip_block = {
 	.funcs = &soc_v1_0_common_ip_funcs,
 };
 
+static struct amdgpu_reset_handler *
+soc_v1_0_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
+			   struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	struct amdgpu_reset_handler *handler;
+	enum amd_reset_method method;
+	int i;
+
+	method = (reset_context->method == AMD_RESET_METHOD_NONE) ?
+		amdgpu_asic_reset_method(adev) :  reset_context->method;
+	for_each_handler(i, handler, reset_ctl) {
+		if (handler->reset_method == method)
+			return handler;
+	}
+
+	return NULL;
+}
+
+static inline u32 soc_v1_0_get_ip_block_mask(struct amdgpu_device *adev)
+{
+	u32 ip_block_mask = BIT(AMD_IP_BLOCK_TYPE_GFX) |
+				 BIT(AMD_IP_BLOCK_TYPE_MES) |
+				 BIT(AMD_IP_BLOCK_TYPE_SDMA) |
+				 BIT(AMD_IP_BLOCK_TYPE_IH);
+
+	return ip_block_mask;
+}
+
+static int soc_v1_0_mode2_suspend_ip(struct amdgpu_device *adev)
+{
+	u32 ip_block_mask = soc_v1_0_get_ip_block_mask(adev);
+	u32 ip_block;
+	int r, i;
+
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
+	/* SDMA suspend not required */
+	ip_block_mask &= ~BIT(AMD_IP_BLOCK_TYPE_SDMA);
+	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		ip_block = BIT(adev->ip_blocks[i].version->type);
+		if (!(ip_block_mask & ip_block))
+			continue;
+
+		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static int
+soc_v1_0_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
+				 struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	return soc_v1_0_mode2_suspend_ip(adev);
+}
+
+static int soc_v1_0_mode2_reset(struct amdgpu_device *adev)
+{
+	adev->asic_reset_res = amdgpu_dpm_mode2_reset(adev);
+	return adev->asic_reset_res;
+}
+
+static void soc_v1_0_async_reset(struct work_struct *work)
+{
+	struct amdgpu_reset_handler *handler;
+	struct amdgpu_reset_control *reset_ctl =
+		container_of(work, struct amdgpu_reset_control, reset_work);
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int i;
+
+	for_each_handler(i, handler, reset_ctl) {
+		if (handler->reset_method == reset_ctl->active_reset) {
+			dev_dbg(adev->dev, "Resetting device\n");
+			handler->do_reset(adev);
+			break;
+		}
+	}
+}
+
+static int
+soc_v1_0_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
+			     struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *tmp_adev = NULL;
+	int r = 0;
+
+	dev_dbg(adev->dev, "soc_v1_0 perform hw reset\n");
+
+	if (!reset_device_list)
+		return -EINVAL;
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
+		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_MODE2;
+	}
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		r = soc_v1_0_mode2_reset(tmp_adev);
+		if (r) {
+			dev_err(tmp_adev->dev,
+				"ASIC reset failed with error, %d for drm dev, %s",
+				r, adev_to_drm(tmp_adev)->unique);
+			break;
+		}
+	}
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
+		tmp_adev->reset_cntl->active_reset = AMD_RESET_METHOD_NONE;
+	}
+
+	return r;
+}
+
+static int soc_v1_0_mode2_restore_ip(struct amdgpu_device *adev)
+{
+	u32 ip_block_mask = soc_v1_0_get_ip_block_mask(adev);
+	struct amdgpu_ip_block *ih_block;
+	u32 ip_block;
+	int i, r;
+
+	if (ip_block_mask & BIT(AMD_IP_BLOCK_TYPE_IH)) {
+		ih_block = amdgpu_device_ip_get_ip_block(adev,
+							 AMD_IP_BLOCK_TYPE_IH);
+		if (unlikely(!ih_block)) {
+			dev_err(adev->dev, "Failed to get IH handle\n");
+			return -EINVAL;
+		}
+		r = amdgpu_ip_block_resume(ih_block);
+		if (r)
+			return r;
+	}
+
+	/* IH Block resume completed can be removed from ip_block_mask */
+	ip_block_mask &= ~BIT(AMD_IP_BLOCK_TYPE_IH);
+
+	/* Reinit GFXHUB */
+	adev->gfxhub.funcs->init(adev);
+	r = adev->gfxhub.funcs->gart_enable(adev);
+	if (r) {
+		dev_err(adev->dev, "GFXHUB gart reenable failed after reset\n");
+		return r;
+	}
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		ip_block = BIT(adev->ip_blocks[i].version->type);
+		if (!(ip_block_mask & ip_block))
+			continue;
+		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		if (r)
+			return r;
+	}
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		ip_block = BIT(adev->ip_blocks[i].version->type);
+		if (!(ip_block_mask & ip_block))
+			continue;
+
+		if (adev->ip_blocks[i].version->funcs->late_init) {
+			r = adev->ip_blocks[i].version->funcs->late_init(&adev->ip_blocks[i]);
+			if (r) {
+				dev_err(adev->dev,
+					"late_init of IP block <%s> failed %d after reset\n",
+					adev->ip_blocks[i].version->funcs->name,
+					r);
+				return r;
+			}
+		}
+		adev->ip_blocks[i].status.late_initialized = true;
+	}
+
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
+
+	return r;
+}
+
+static int
+soc_v1_0_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
+				 struct amdgpu_reset_context *reset_context)
+{
+	struct list_head *reset_device_list = reset_context->reset_device_list;
+	struct amdgpu_device *tmp_adev = NULL;
+	int r;
+
+	if (!reset_device_list)
+		return -EINVAL;
+
+	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		amdgpu_set_init_level(tmp_adev,
+				      AMDGPU_INIT_LEVEL_RESET_RECOVERY);
+		dev_info(tmp_adev->dev,
+			 "GPU reset succeeded, trying to resume\n");
+		amdgpu_ras_clear_err_state(tmp_adev);
+		r = soc_v1_0_mode2_restore_ip(tmp_adev);
+		if (r)
+			goto end;
+
+		/*
+		 * Add this ASIC as tracked as reset was already
+		 * complete successfully.
+		 */
+		amdgpu_register_gpu_instance(tmp_adev);
+
+		amdgpu_ras_resume(tmp_adev);
+
+		if (!r) {
+			amdgpu_set_init_level(tmp_adev,
+					      AMDGPU_INIT_LEVEL_DEFAULT);
+			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
+
+			r = amdgpu_ib_ring_tests(tmp_adev);
+			if (r) {
+				dev_err(tmp_adev->dev,
+					"ib ring test failed (%d).\n", r);
+				r = -EAGAIN;
+				tmp_adev->asic_reset_res = r;
+				goto end;
+			}
+		}
+	}
+
+end:
+	return r;
+}
+
+static struct amdgpu_reset_handler soc_v1_0_mode2_handler = {
+	.reset_method		= AMD_RESET_METHOD_MODE2,
+	.prepare_env		= NULL,
+	.prepare_hwcontext	= soc_v1_0_mode2_prepare_hwcontext,
+	.perform_reset		= soc_v1_0_mode2_perform_reset,
+	.restore_hwcontext	= soc_v1_0_mode2_restore_hwcontext,
+	.restore_env		= NULL,
+	.do_reset		= soc_v1_0_mode2_reset,
+};
+
+static struct amdgpu_reset_handler
+	*soc_v1_0_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
+		&soc_v1_0_mode2_handler,
+	};
+
+int soc_v1_0_reset_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_reset_control *reset_ctl;
+
+	reset_ctl = kzalloc_obj(*reset_ctl, GFP_KERNEL);
+	if (!reset_ctl)
+		return -ENOMEM;
+
+	reset_ctl->handle = adev;
+	reset_ctl->async_reset = soc_v1_0_async_reset;
+	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
+	reset_ctl->get_reset_handler = soc_v1_0_get_reset_handler;
+
+	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
+	/* Only mode2 is handled through reset control now */
+	reset_ctl->reset_handlers = &soc_v1_0_rst_handlers;
+
+	adev->reset_cntl = reset_ctl;
+
+	return 0;
+}
+
+int soc_v1_0_reset_fini(struct amdgpu_device *adev)
+{
+	kfree(adev->reset_cntl);
+	adev->reset_cntl = NULL;
+	return 0;
+}
+
 static enum amdgpu_gfx_partition __soc_v1_0_calc_xcp_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index 3cbc20eb16155..82752964d2c1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -36,5 +36,7 @@ bool soc_v1_0_mid1_reg_range(uint32_t reg);
 uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg);
 uint32_t soc_v1_0_normalize_reg_offset(uint32_t reg);
 u64 soc_v1_0_encode_ext_smn_addressing(int ext_id);
+int soc_v1_0_reset_init(struct amdgpu_device *adev);
+int soc_v1_0_reset_fini(struct amdgpu_device *adev);
 
 #endif
-- 
2.55.0

