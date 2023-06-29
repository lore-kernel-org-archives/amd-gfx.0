Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562ACEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0588D10E3B6;
	Thu, 29 Jun 2023 04:47:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E5B10E3B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqlT7dAQkB8AG+bwbSiIDZUuQ9ragQl2evIB4ct614FQ5WMkGhKxNLmnwDJ3I0+AhQFPXXVz4QQOXr5mfN5kRcpAs+7tFMnqXHAPYhXkbFRKprZT963IaVmjOgXWe43wA8zreRf8O1McbgKzBTIZpaejc1cWe+RMRJK5Ysx2Zy49QiKfzCpTOh1tL6P7AKZGNiCkPd2QIHEbBT7FBynoGT2KoiSxex/ArRW7Xt4btDhZ/+JSKeCNAuE92NEPSW6fvVX1S0QaPry5wY8OYnzwQaOGNAAAaJHfvCVckBTj5wVlagZ6LJT6lMSrtAUESeQxUwzA8QVAipaGFS3m6LNyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O84CYa3gpK20bwsuMb/O1xq2YplIa7nTSl6UD7lOv+c=;
 b=b9SoslFpHMZ/uK2y9fH3h0W/lQ2wz8q2ZNLLja9bOT9lmZTWkwUfT0dqwd6ddtChOsvKD8x6k+r2PNSvcZ3SmEnBh0z5A3sm+zqEHMh84997oopybEVqLa2mlK1CQCPAG1BN5lhUQwdOyE+OaT62orox4BCrSa9ohiW3sh+Caev3qFjdfx54LGlylCQrBiC8Xr52WJwBwvesX8919iEa7oHnLw8Jd9pR4maQSDBsE5LFllC9KOk1lyCqS3q/F4WF+75goAgQWoo/CKdy1FCuckPe7k/jjLBrV9clWM6XVBHyLK4/mqurQ1rs/amJBdyXujtUZ+02GI8dht7udSARFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O84CYa3gpK20bwsuMb/O1xq2YplIa7nTSl6UD7lOv+c=;
 b=E/bl4sfufYLNiDdDLmc5PwwVOsOJ27NIbORw7bvIn3dSXnZXM0GkYen3GHRI6ucRgr/6jcbQp1/+EDzbHSB1RxnmhIEOAN0Th2ZFjfjD6szOMV+6drgi2UxXbJ5aTmqEPOeluRov7X76D9celUcVR4Ti6elppLAIB5Vpfq9udTo=
Received: from BN0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:141::21)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 04:47:31 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::c1) by BN0PR07CA0016.outlook.office365.com
 (2603:10b6:408:141::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 04:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 04:47:12 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:47:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 6/6] drm/amd/display: Eliminate warnings in amdgpu_dm_helpers.c
Date: Thu, 29 Jun 2023 10:16:35 +0530
Message-ID: <20230629044635.2266729-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e92842e-8eab-49a1-3b4f-08db785bf2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyYqTR5228ra2ROKwNmMSkWIiCGKRcZd3MAG+ZYGadCBQG9qCZ3xXbO9lAdWpwguFoq9NbrIm9fqbxuMCXuiRrPnTss/RrWeqtmlCt/hEs3KzDQpUfp+L0WT3mLnDEwKWUaTtpN8d1PMehdSuXQ5boBKnn5oxkqw7Vx9Kk/jpbUMRSxRc6StnAKAriRNMlpoLtmqaBpKm+abMWcoYFzHnqxdzwDFsALsGRaoq/KJVVKwvFF+WlL7sI7Fr/NVBkXRHexXSIfRAGbNxfLj1E+oVsFRGYocT6hHwXjXjlY4G3QACCqD6jwJicKzm5Mu7djYOBtEVZe7rTqu0GFhwXGlqfiA6lMnWyTzGvhHPWo87XxMyK2c/igMjmbo8OdeIUv2rlliRyWNSJ057i/UzzVS1LrXdMeWtJs+ChycKaSvqR2T2mKdZW5cvEMxU3dErgdqzjeC/8+IBcWAZ4V/jWny3KSNfMKEW+aikBfTJZaDJmVS4i2G9BRUUE3ZsrxbQgXWs1Q1389l/2oHXiPH/+/iw1QXipbFLvPoYaM0+wtEVpHqIqwBvj8DPBOD2jr8TdArovVEZ61u2biChD2PSQ5i0QulqGsVp9eHr0NAMjJY4TPai02HfQ+0ZC2WY3UnB3CGM+43QALq47H0FlzTlC21T1UQh8TbCLmVoNN1EjhFuHmOmgru1oMVFoDAFMPAr9KU/KA7vXo2759ySMl7C1vtrtWskok1+goqnHRSRajRm2Hr++asorRY7I+kTzaRCx6Vw6/qs0B1sb/GG51MFk2yWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(2906002)(478600001)(36860700001)(86362001)(54906003)(110136005)(82310400005)(7696005)(6666004)(356005)(81166007)(82740400003)(6636002)(70586007)(336012)(426003)(2616005)(47076005)(316002)(36756003)(4326008)(83380400001)(70206006)(40480700001)(8676002)(16526019)(5660300002)(8936002)(186003)(1076003)(26005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:47:12.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e92842e-8eab-49a1-3b4f-08db785bf2b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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

