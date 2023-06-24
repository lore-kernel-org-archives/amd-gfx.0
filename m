Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CDBEB64DA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 04:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DAC10E104;
	Sat, 24 Jun 2023 04:39:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E33010E104
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 04:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtMvHAkx/gc7TceDJmf9JVHzenM13vFAT8LM+Nw+e8gFv1k09PYOu267CVux/T+peBFMM6dTKnQiiZ+6CwSQ6ln69ivIoHpSeu58iZQUhTcv7rH4jo0anCfM9stbzngitowIiR+JSWp5haK9RJh7YBsLYrwHZXlciZOxT6SgckbSbaqxn1BlnnlQ4MvZtNgc4TuWhTUvzHINt6y8rJEiN45rrwtzbwTjV//cTRNAEDU6kRMMT34ocbLRQpjMIWs5tf/ApFegT08pAw/6bmpEGBe4GKGLdUhRzbc1EyWxSRL1pV+50uRnvrgOQdXM2SsEZy1GXe2OrMUX/sslsuQc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT2Pq4YyL66tROQ/Use70s5W9ydCJVMz90FROFzU/Ow=;
 b=mEcVC8S3Yu8Ylc2OJBRtPf/sEIeGLC+oTM2JCD+j/FUZcNOyNyrvQsFpHwiMm3+KyMvgJFWMBX7IReh836GdnAEZgpBowUEnXW5l3Ck5AGjgRpy8QhCxL2SZMKO1Gf/fTVO7iQUsHDpBTH6BEhS+Oorqc3Ef4UK7XfUnvIvy1MqB9j2t+Dle3a8GEPMMn2/chUnbZIvE3zlr3ZJnLzYjr3zhEPMn/yI+DIvMDsmTm411UBizVEm91adwVoI+QCyUquCRq2dn5OAKFtHPRzIRyC5QCVLKhACD7oofI89iqNC5l4yTPnbRXH/FEnIF/PQ5HRHBYZ1i3YLU5ZpAIktxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT2Pq4YyL66tROQ/Use70s5W9ydCJVMz90FROFzU/Ow=;
 b=cKftu6Qlo1nmNWA+4S5BKa279qGMUB3VupbXBO3uJ6m9lIeC3q4OFi0d37g+NqtqpASvhxTOnCzoeJ5ua6b3nkdxTFkhCxO6uoFWuhS4fm9c/26MIpv6eIt4gvbXG7r3Dd4RKUQ/VMBjU+yNnoiFHJzf4kpI+wRXcYR4CCcc760=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 04:39:00 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::6b) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Sat, 24 Jun 2023 04:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.44 via Frontend Transport; Sat, 24 Jun 2023 04:38:59 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 23:38:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Eliminate warnings in amdgpu_dm_helpers.c
Date: Sat, 24 Jun 2023 10:08:43 +0530
Message-ID: <20230624043843.1232924-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 060ffe0b-77e8-4af2-4c18-08db746cedc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO2LQME3FmO+TBYX2RJ4ruaVpKklNWPHV+oAexb/rtDA/wAfSvGjQybjg+NTCB5HwAQi6j/iZSRvWhFcvzJz76bA3nK4oLHky15TlLwLsIThJ6LDqMtLycUMgXImL+qRdOgO4N37s8fmj/ZIvVwMNwy3SYfJ8Py/4BT7SMJmQuvV3A0qNyUNlHAhHGbpJbNf+OOdNaP+84G6pvlST/vNw6oOoWqbn5JyCpH1WibUue0ZAS11jb5VCWOI5pJhrjt81qs7OsH4t1Wj4uAb/hnmrdEpVu7BnXZ8UQbxGhLVtI4RwKPF9b2DkEqiY0PW6EMFROqjWXp4rHuI5cYOspBRhQEbZaBh2BZCi6eCqaaw7pSSwhDE7u5YscaLc11jDAjOchaUjcm/B4nLsQvvYodUzmNPRqgbrodzNn8ZUxPWkccxojfAUE8hCeol+NO+23Q6QtfCSGfh6YOMPQ0GGfA/IXy1oO1QZ8iOqFlZ2HRi25WQepRXe254h3l9gVZ8Es5BSJESi3hZ3SWhm9SCCd0BW8tg0xuaTLdhQIEV8VkzemlNN1w5dpk2U4JKrChldPHocExwHXR7bpeLZi/PLcobVx2sgjiK7icXk2M9RHJkXLAmq5BSdxshMjxO2tVsJTWx5YHHFzAZD0EJBqfpm0F8rHEwJy2a8bAVOjXct4529EgKf8wZ/mIi7SMRlWQ1isIsZDfnNY0IQJjxC8hagz3HkejllYXVwYzXJ7/UmTCyLHLmfKqpitJEtTCcZocaJdoGEqYAuowQMPNmI0ueTNEqqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(82310400005)(81166007)(86362001)(40480700001)(40460700003)(316002)(2616005)(41300700001)(44832011)(8936002)(70586007)(4326008)(70206006)(6636002)(8676002)(336012)(5660300002)(7696005)(426003)(1076003)(478600001)(6666004)(54906003)(83380400001)(110136005)(186003)(16526019)(26005)(36756003)(36860700001)(2906002)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 04:38:59.6499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060ffe0b-77e8-4af2-4c18-08db746cedc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

Fix the following warnings reported by checkpatch:

WARNING: Block comments use a trailing */ on a separate line
WARNING: Prefer using '"%s...", __func__' to using 'execute_synaptics_rc_command', this function's name, in a string
WARNING: Prefer using '"%s...", __func__' to using 'apply_synaptics_fifo_reset_wa', this function's name, in a string
WARNING: braces {} are not necessary for single statement blocks

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cd20cfc04996..6efb812189f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -44,15 +44,14 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 
-/* dm_helpers_parse_edid_caps
- *
- * Parse edid caps
+/**
+ * dm_helpers_parse_edid_caps() - Parse edid caps
  *
  * @edid:	[in] pointer to edid
- *  edid_caps:	[in] pointer to edid caps
- * @return
- *	void
- * */
+ * @edid_caps:	[in] pointer to edid caps
+ *
+ * Return: void
+ */
 enum dc_edid_status dm_helpers_parse_edid_caps(
 		struct dc_link *link,
 		const struct dc_edid *edid,
@@ -229,7 +228,8 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	/* Accessing the connector state is required for vcpi_slots allocation
 	 * and directly relies on behaviour in commit check
 	 * that blocks before commit guaranteeing that the state
-	 * is not gonna be swapped while still in use in commit tail */
+	 * is not gonna be swapped while still in use in commit tail
+	 */
 
 	if (!aconnector || !aconnector->mst_root)
 		return false;
@@ -256,7 +256,8 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	/* mst_mgr->->payloads are VC payload notify MST branch using DPCD or
 	 * AUX message. The sequence is slot 1-63 allocated sequence for each
 	 * stream. AMD ASIC stream slot allocation should follow the same
-	 * sequence. copy DRM MST allocation to dc */
+	 * sequence. copy DRM MST allocation to dc
+	 */
 	fill_dc_mst_payload_table_from_drm(stream->link, enable, target_payload, proposed_table);
 
 	return true;
@@ -607,7 +608,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
 
 	if (ret < 0) {
-		DRM_ERROR("	execute_synaptics_rc_command - write cmd ..., err = %d\n", ret);
+		DRM_ERROR("%s: write cmd ..., err = %d\n", __func__, ret);
 		return false;
 	}
 
@@ -629,7 +630,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		drm_dp_dpcd_read(aux, SYNAPTICS_RC_DATA, data, length);
 	}
 
-	DC_LOG_DC("	execute_synaptics_rc_command - success = %d\n", success);
+	DC_LOG_DC("%s: success = %d\n", __func__, success);
 
 	return success;
 }
@@ -638,7 +639,7 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 {
 	unsigned char data[16] = {0};
 
-	DC_LOG_DC("Start apply_synaptics_fifo_reset_wa\n");
+	DC_LOG_DC("Start %s\n", __func__);
 
 	// Step 2
 	data[0] = 'P';
@@ -696,7 +697,7 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 	if (!execute_synaptics_rc_command(aux, true, 0x02, 0, 0, NULL))
 		return;
 
-	DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
+	DC_LOG_DC("Done %s\n", __func__);
 }
 
 /* MST Dock */
@@ -969,9 +970,8 @@ void dm_helpers_override_panel_settings(
 	struct dc_panel_config *panel_config)
 {
 	// Feature DSC
-	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
 		panel_config->dsc.disable_dsc_edp = true;
-	}
 }
 
 void *dm_helpers_allocate_gpu_mem(
-- 
2.25.1

