Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F856EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F52910E0EA;
	Thu, 29 Jun 2023 04:42:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEAA10E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhW+m0z4H5zOIgpPJdzcrian008w0TApGFz0kFgrGT6KCNTY8qhtn03inl8+YQjzJR3dhTEROo3GgxWeHGxi5hj0UZ4P6+/XJGlH0YiKdiZMyuxA8hmCzVi3LyCviYtUHPtzn9W6oG7nbKVPaW+URI0sv3thxuqfFs+lw0A0iniBDCO8LEJN/FDyX5IHoX4R9GP68Mj9zWO1H0WouA/qNJizUpynkJb15t40kvwdFLR0Aago6CPd/Uh3LI3Vmkk8mFjrxOpkTfOyx6v+aod0Vt0Ftu0faI8goQS27lg0BRV2kMyBIsmIYJf1jOVtejBSNXy/OGT7TWQ3RSWWoaubPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O84CYa3gpK20bwsuMb/O1xq2YplIa7nTSl6UD7lOv+c=;
 b=oUq8VE+aBoBvlWRcyqhFdrgg3hMh2FKPQ9fdJjAlDWOaydbYgHlzoNwsgf/mu+TEtaE+avaRp6mEMo1lj4bQj3XANNdfLLSKY2S2QEme7SnoYuGHy5vpLeXdAhOP59yECCl/J324KRXnLzOtc99dokALmckL+C8+EiXhDY1xCkOIxGX6zMiSiO2g6FebTlxZtdaOOCWsazUqLDdFz/TupqFOgEH+7WYkv/eACtdAmbhUN1CQoh8SUbcInptTmCUb6rvAaWN9KYoF/fFi+MfI4Htx1TK5VNTFTCJIq+s8JWNwXW9W/vT2aKOxGFQ30D5poHDOuUyKlSTCTwzugRsxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O84CYa3gpK20bwsuMb/O1xq2YplIa7nTSl6UD7lOv+c=;
 b=cTzRlujO+LT22OoRQjpYmtZ7JOOLLpxUB3rAUlsQIu0bwiRaAaa24QN074OSQdCFW3AIx1iEvtncaVa0dF2MtnWo+9e1OR0GwzQGQ6nfRaS5r5fB9lW08NVhnjAmRp6mcdZJ1TReyc5D1ZJYWHK0vpkgb6RRQ4RTwCNWzwzg4AQ=
Received: from BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::24)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 04:42:43 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::d9) by BN9P222CA0019.outlook.office365.com
 (2603:10b6:408:10c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 04:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 04:42:43 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:42:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 6/6] drm/amd/display: Eliminate warnings in amdgpu_dm_helpers.c
Date: Thu, 29 Jun 2023 10:12:08 +0530
Message-ID: <20230629044208.2266584-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
References: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: b747ef00-340d-4e01-d720-08db785b4706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dhWBLXkzkvT1lTf2yeHI0PUl9qiiJJ+Y0F2QAZNTwfVgcgb6o56WcuhyIEKjK4ezoTej6JUJTjf2E1PP2NLoi5YIk4zPVqRE0Jt/AD1J1HgV5A3Oar5ZEXd55Bv+cP7Sby14SjaiT2UUR3y/hlw0TviGp4TpLiU2B7cF42GJXjenyo4gq7TybZyb+wieo5jL+UWUW9FrK9GO03u03BYnRW16i1RGRZR47VjP3Z6ZQLv1ASaLj06ZGZc50VN0+BS/JOpuCXSTMn4YbePnoe3DEULUgETVnzHgOi1U9LJIHXdM0czu8XU6HTO+IB3Z+vKR/LkG3YfO41BDv/N/uicAjet3fRvGGVqXGcXRNFSiaQVZdOH/NagwNU/R/80Xlcu62OJwNsenVXAfnWcwPWx71SmHlTarICbia83YPMIhR/zTEt7lJU4iBfp+54GahCzHXh52p4LUIoO499nJolwL3cwiMhOe2KbBfHbyUoY+YWdDDrXRp4lSiwx+F5Qtd7M1HE7h66DmT5rygQTHN6q3HzlFow//LW+/zWbHVSp8MixfsUSEMIrsLWo/1qnXBFTgtM0Ep9EwcKDu7tOpTibvLlyqrVpgA/G65Z7CjjUBwIegQj6ZLR4f67HPu1xBH5d/2OVCvS1dDiFJRm1RollovmOGPDU/AhpmlqFh0g80ucx2pTnTs6WzaKCsiVDeT+mT+pQUpWBi8o+81dmNjG4s+rezm2yI7IvhJW4cQ29TFwuVUITefM6zWTG4/qgndLV1tk7d6lFeRLVl30wLLKeHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(4326008)(70206006)(478600001)(36756003)(316002)(6636002)(70586007)(8936002)(8676002)(2906002)(16526019)(40460700003)(110136005)(36860700001)(54906003)(41300700001)(82310400005)(7696005)(40480700001)(186003)(86362001)(47076005)(6666004)(426003)(26005)(336012)(356005)(1076003)(81166007)(2616005)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:42:43.1419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b747ef00-340d-4e01-d720-08db785b4706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a6be04ad387f..66909bb5e5b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -68,15 +68,13 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 	}
 }
 
-/* dm_helpers_parse_edid_caps
+/**
+ * dm_helpers_parse_edid_caps() - Parse edid caps
  *
- * Parse edid caps
+ * @edid_caps:	[in] pointer to edid caps
  *
- * @edid:	[in] pointer to edid
- *  edid_caps:	[in] pointer to edid caps
- * @return
- *	void
- * */
+ * Return: void
+ */
 enum dc_edid_status dm_helpers_parse_edid_caps(
 		struct dc_link *link,
 		const struct dc_edid *edid,
@@ -255,7 +253,8 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	/* Accessing the connector state is required for vcpi_slots allocation
 	 * and directly relies on behaviour in commit check
 	 * that blocks before commit guaranteeing that the state
-	 * is not gonna be swapped while still in use in commit tail */
+	 * is not gonna be swapped while still in use in commit tail
+	 */
 
 	if (!aconnector || !aconnector->mst_root)
 		return false;
@@ -282,7 +281,8 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	/* mst_mgr->->payloads are VC payload notify MST branch using DPCD or
 	 * AUX message. The sequence is slot 1-63 allocated sequence for each
 	 * stream. AMD ASIC stream slot allocation should follow the same
-	 * sequence. copy DRM MST allocation to dc */
+	 * sequence. copy DRM MST allocation to dc
+	 */
 	fill_dc_mst_payload_table_from_drm(stream->link, enable, target_payload, proposed_table);
 
 	return true;
@@ -633,7 +633,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	ret = drm_dp_dpcd_write(aux, SYNAPTICS_RC_COMMAND, &rc_cmd, sizeof(rc_cmd));
 
 	if (ret < 0) {
-		DRM_ERROR("	execute_synaptics_rc_command - write cmd ..., err = %d\n", ret);
+		DRM_ERROR("%s: write cmd ..., err = %d\n",  __func__, ret);
 		return false;
 	}
 
@@ -655,7 +655,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		drm_dp_dpcd_read(aux, SYNAPTICS_RC_DATA, data, length);
 	}
 
-	DC_LOG_DC("	execute_synaptics_rc_command - success = %d\n", success);
+	DC_LOG_DC("%s: success = %d\n", __func__, success);
 
 	return success;
 }
@@ -664,7 +664,7 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 {
 	unsigned char data[16] = {0};
 
-	DC_LOG_DC("Start apply_synaptics_fifo_reset_wa\n");
+	DC_LOG_DC("Start %s\n", __func__);
 
 	// Step 2
 	data[0] = 'P';
@@ -722,7 +722,7 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 	if (!execute_synaptics_rc_command(aux, true, 0x02, 0, 0, NULL))
 		return;
 
-	DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
+	DC_LOG_DC("Done %s\n", __func__);
 }
 
 /* MST Dock */
@@ -995,9 +995,8 @@ void dm_helpers_override_panel_settings(
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

