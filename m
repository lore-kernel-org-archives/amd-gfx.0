Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7866EC004C0
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94FB10E5FE;
	Fri, 20 Oct 2023 22:06:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0454D10E5FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi8AEW7JcptuPi+4Hb+LhLUFme+w3n5GCJ2kzSbXQCYvVAUzEHkUGz1eH9j9lbB8PKrTPOF79wBRUA/DZ/Qh59O8zW20kWcFzV4ewDca+mpYCxZwTYhSo6ZBkBcE9xH0ie01ZvxCEb1uh+b/Sh9dhuNAFpmkN1xCjnMWf8jZ9j9zYiU12TbrEc7L+MX1E85MEIj1YfAwBIG4yZzlAS+wwqjxKFshOQ4CumZhXa64FnnsxCYuib7QqfJ0PsBBmYhtHSqAeeWTqbuWpdPi9I58KVewnWAza088kJhxb8Wz4ys8jPnF3KvFImREJfk2u2s69EDBn5SLzkF6KFNOJgz0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRVQ1xjPR8RG9G58ibgvUoWCs5IWy3iCFbgwxqfKwvU=;
 b=ggwo3SKoNlKhpDKNJOgyDSm9joFju8uKPk95XuGv+m7MB25qB3RNc8isVFv8DgYb0aknJMOOhpwccN+daiUjYWy20cdw1UcrdVrTao05jIOJTg8xI+AHmndUiB8xBp6csltRzIROsyoTwHPeIdydkE6L9Di0wsrZwMhrAZeCbnOfvCadVSz/nmUhf8u44BeDKBfrY4/aQ50dE+XRLtjfzMsvERaZfbCSJAZrV4/wA0qWi3cKWIR0o35/Tks7MOpIf+NqmQIfDrMC22ZagY4E287g35oM7b0K2mSOIXM7HKXKoMpA8/VJ6ARBZ6hTMFKbjS6cs+jqwTGLr/ZaRr4QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRVQ1xjPR8RG9G58ibgvUoWCs5IWy3iCFbgwxqfKwvU=;
 b=NivlSDDTTgzbZiqDMrgbqPLFnvX6o6HHS9xqSGh8E+lx8DGvgrHpSZkheaUWiNsXH7TEfPvTA5D1GthmHqjBYiCa6pFVrJlNs2xI+u5awzEc/1bwy5M5SI99ODB4RiMDgGvlwXkB3Udy+gdtP3XLoyOzLU+fL55thLBZ/fzkY1g=
Received: from BL0PR02CA0115.namprd02.prod.outlook.com (2603:10b6:208:35::20)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:06:31 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::db) by BL0PR02CA0115.outlook.office365.com
 (2603:10b6:208:35::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:30 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 4/8] Documentation/gpu: Add kernel doc entry for MPC
Date: Fri, 20 Oct 2023 16:05:17 -0600
Message-ID: <20231020220549.493808-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
References: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8e3ded-3036-42f7-e3c4-08dbd1b8d121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdYdiTZAh3Kw59NpuYkjZTSijCfHYRwe1PAcB1qNlfvIHJXPQGsP2TpsVwM4nhM4bNkDP56I07K4Bcy36SjY311HbWt+AN/q7i2vb1NMTUs9RYsHeLHsckuU30kieoD0evH32VXKvH6VQvv7hdjMfRmx1ZjwEpYC3M0AmH78BVvl9KHvqxzOsyn3L+uECSk9ZlYhXlL3vDwNnopiO/H/pw2/c3G9S1xreoe8EWr9SQ9uv8NypL4pdIMONVfyKQoMXb0ZgnFHBC+/AoNWAYy8ydDksJh+ucWCzTeWycLpardW90qvosAgr0FKHiTPPQdptpG/WLOMynVIQSiiFzasxMlOYn9KsXHTKHV3sdbRqeeWmFIxCjMtQZK6oh8yfNryPT3KzBAId/+Aanb4u8JJMMAM/aEXmmV0WIruWUPx5DRj7t/hxxOp1svqgjRi4nzRKMS8aOxuJaGyLWkDP3i+80qY6Yi5H52mHqx0RDorM8XJseGbQAN28bWWGTxdkrRHMqtwlrAD1WlCJnT+G6oYfjrwmOYgZtxKR7XiqLVcv9iWt3KhTw6xGOK4glYQWncacF3YkiSE9fxN4X8TH1OMVvyDtvMQ5gMt1/HGA4YzzW7vd7EMv6euDy8Q9jPOvZyK47zQ9lRE7uF1m72lPT/2wVTi4fSpBs5I/N28TcwAvni7KfVDHInurXpRW+8K+q1fwhP8LPN51VYZp0rT8JkXwRvmlBjN2AKSsWYyA86fzJrFgBd6haMYIEo9MtfMZk+gtBXd30B6Pk90alWSNNiS5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(30864003)(2906002)(40460700003)(478600001)(5660300002)(41300700001)(4326008)(8676002)(8936002)(110136005)(316002)(54906003)(70206006)(70586007)(36860700001)(47076005)(83380400001)(86362001)(36756003)(356005)(82740400003)(81166007)(2616005)(26005)(336012)(1076003)(426003)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:31.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8e3ded-3036-42f7-e3c4-08dbd1b8d121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit adds a kernel-doc entry for the MPC block. Since it enabled
the kernel-doc to parse some of the documentation in the mpc.h file,
fixing some of the comments was required.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-blocks.rst         |  12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 248 ++++++++++++------
 2 files changed, 184 insertions(+), 76 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 83fc4a03113e..1a223f33202e 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -40,3 +40,15 @@ DPP
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :internal:
+
+MPC
+---
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+   :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 61a2406dcc53..ae336c066f13 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -23,13 +23,28 @@
  */
 
 /**
- * DOC: mpc-overview
+ * DOC: overview
  *
  * Multiple Pipe/Plane Combined (MPC) is a component in the hardware pipeline
  * that performs blending of multiple planes, using global and per-pixel alpha.
  * It also performs post-blending color correction operations according to the
  * hardware capabilities, such as color transformation matrix and gamma 1D and
  * 3D LUT.
+ *
+ * MPC receives output from all DPP pipes and combines them to multiple outputs
+ * supporting "M MPC inputs -> N MPC outputs" flexible composition
+ * architecture. It features:
+ *
+ * - Programmable blending structure to allow software controlled blending and
+ *   cascading;
+ * - Programmable window location of each DPP in active region of display;
+ * - Combining multiple DPP pipes in one active region when a single DPP pipe
+ *   cannot process very large surface;
+ * - Combining multiple DPP from different SLS with blending;
+ * - Stereo formats from single DPP in top-bottom or side-by-side modes;
+ * - Stereo formats from 2 DPPs;
+ * - Alpha blending of multiple layers from different DPP pipes;
+ * - Programmable background color;
  */
 
 #ifndef __DC_MPCC_H__
@@ -83,34 +98,66 @@ enum mpcc_alpha_blend_mode {
 
 /**
  * struct mpcc_blnd_cfg - MPCC blending configuration
- *
- * @black_color: background color
- * @alpha_mode: alpha blend mode (MPCC_ALPHA_BLND_MODE)
- * @pre_multiplied_alpha: whether pixel color values were pre-multiplied by the
- * alpha channel (MPCC_ALPHA_MULTIPLIED_MODE)
- * @global_gain: used when blend mode considers both pixel alpha and plane
- * alpha value and assumes the global alpha value.
- * @global_alpha: plane alpha value
- * @overlap_only: whether overlapping of different planes is allowed
- * @bottom_gain_mode: blend mode for bottom gain setting
- * @background_color_bpc: background color for bpc
- * @top_gain: top gain setting
- * @bottom_inside_gain: blend mode for bottom inside
- * @bottom_outside_gain:  blend mode for bottom outside
  */
 struct mpcc_blnd_cfg {
-	struct tg_color black_color;	/* background color */
-	enum mpcc_alpha_blend_mode alpha_mode;	/* alpha blend mode */
-	bool pre_multiplied_alpha;	/* alpha pre-multiplied mode flag */
+	/**
+	 * @black_color: background color.
+	 */
+	struct tg_color black_color;
+
+	/**
+	 * @alpha_mode: alpha blend mode (MPCC_ALPHA_BLND_MODE).
+	 */
+	enum mpcc_alpha_blend_mode alpha_mode;
+
+	/***
+	 * @@pre_multiplied_alpha:
+	 *
+	 * Whether pixel color values were pre-multiplied by the alpha channel
+	 * (MPCC_ALPHA_MULTIPLIED_MODE).
+	 */
+	bool pre_multiplied_alpha;
+
+	/**
+	 * @global_gain: Used when blend mode considers both pixel alpha and plane.
+	 */
 	int global_gain;
+
+	/**
+	 * @global_alpha: Plane alpha value.
+	 */
 	int global_alpha;
+
+	/**
+	 * @@overlap_only: Whether overlapping of different planes is allowed.
+	 */
 	bool overlap_only;
 
 	/* MPCC top/bottom gain settings */
+
+	/**
+	 * @bottom_gain_mode: Blend mode for bottom gain setting.
+	 */
 	int bottom_gain_mode;
+
+	/**
+	 * @background_color_bpc: Background color for bpc.
+	 */
 	int background_color_bpc;
+
+	/**
+	 * @top_gain: Top gain setting.
+	 */
 	int top_gain;
+
+	/**
+	 * @bottom_inside_gain: Blend mode for bottom inside.
+	 */
 	int bottom_inside_gain;
+
+	/**
+	 * @bottom_outside_gain: Blend mode for bottom outside.
+	 */
 	int bottom_outside_gain;
 };
 
@@ -150,34 +197,58 @@ struct mpc_dwb_flow_control {
 
 /**
  * struct mpcc - MPCC connection and blending configuration for a single MPCC instance.
- * @mpcc_id: MPCC physical instance
- * @dpp_id: DPP input to this MPCC
- * @mpcc_bot: pointer to bottom layer MPCC. NULL when not connected.
- * @blnd_cfg: the blending configuration for this MPCC
- * @sm_cfg: stereo mix setting for this MPCC
- * @shared_bottom: if MPCC output to both OPP and DWB endpoints, true. Otherwise, false.
  *
  * This struct is used as a node in an MPC tree.
  */
 struct mpcc {
-	int mpcc_id;			/* MPCC physical instance */
-	int dpp_id;			/* DPP input to this MPCC */
-	struct mpcc *mpcc_bot;		/* pointer to bottom layer MPCC.  NULL when not connected */
-	struct mpcc_blnd_cfg blnd_cfg;	/* The blending configuration for this MPCC */
-	struct mpcc_sm_cfg sm_cfg;	/* stereo mix setting for this MPCC */
-	bool shared_bottom;		/* TRUE if MPCC output to both OPP and DWB endpoints, else FALSE */
+	/**
+	 * @mpcc_id: MPCC physical instance.
+	 */
+	int mpcc_id;
+
+	/**
+	 * @dpp_id: DPP input to this MPCC
+	 */
+	int dpp_id;
+
+	/**
+	 * @mpcc_bot: Pointer to bottom layer MPCC. NULL when not connected.
+	 */
+	struct mpcc *mpcc_bot;
+
+	/**
+	 * @blnd_cfg: The blending configuration for this MPCC.
+	 */
+	struct mpcc_blnd_cfg blnd_cfg;
+
+	/**
+	 * @sm_cfg: stereo mix setting for this MPCC
+	 */
+	struct mpcc_sm_cfg sm_cfg;
+
+	/**
+	 * @shared_bottom:
+	 *
+	 * If MPCC output to both OPP and DWB endpoints, true. Otherwise, false.
+	 */
+	bool shared_bottom;
 };
 
 /**
  * struct mpc_tree - MPC tree represents all MPCC connections for a pipe.
  *
- * @opp_id: the OPP instance that owns this MPC tree
- * @opp_list: the top MPCC layer of the MPC tree that outputs to OPP endpoint
  *
  */
 struct mpc_tree {
-	int opp_id;			/* The OPP instance that owns this MPC tree */
-	struct mpcc *opp_list;		/* The top MPCC layer of the MPC tree that outputs to OPP endpoint */
+	/**
+	 * @opp_id: The OPP instance that owns this MPC tree.
+	 */
+	int opp_id;
+
+	/**
+	 * @opp_list: the top MPCC layer of the MPC tree that outputs to OPP endpoint
+	 */
+	struct mpcc *opp_list;
 };
 
 struct mpc {
@@ -217,16 +288,20 @@ struct mpc_funcs {
 	 * Only used for planes that are part of blending chain for OPP output
 	 *
 	 * Parameters:
-	 * [in/out] mpc		- MPC context.
-	 * [in/out] tree	- MPC tree structure that plane will be added to.
-	 * [in]	blnd_cfg	- MPCC blending configuration for the new blending layer.
-	 * [in]	sm_cfg		- MPCC stereo mix configuration for the new blending layer.
-	 *			  stereo mix must disable for the very bottom layer of the tree config.
-	 * [in]	insert_above_mpcc - Insert new plane above this MPCC.  If NULL, insert as bottom plane.
-	 * [in]	dpp_id		 - DPP instance for the plane to be added.
-	 * [in]	mpcc_id		 - The MPCC physical instance to use for blending.
-	 *
-	 * Return:  struct mpcc* - MPCC that was added.
+	 *
+	 * - [in/out] mpc  - MPC context.
+	 * - [in/out] tree - MPC tree structure that plane will be added to.
+	 * - [in] blnd_cfg - MPCC blending configuration for the new blending layer.
+	 * - [in] sm_cfg   - MPCC stereo mix configuration for the new blending layer.
+	 *                   stereo mix must disable for the very bottom layer of the tree config.
+	 * - [in] insert_above_mpcc - Insert new plane above this MPCC.
+	 *                          If NULL, insert as bottom plane.
+	 * - [in] dpp_id  - DPP instance for the plane to be added.
+	 * - [in] mpcc_id - The MPCC physical instance to use for blending.
+	 *
+	 * Return:
+	 *
+	 * struct mpcc* - MPCC that was added.
 	 */
 	struct mpcc* (*insert_plane)(
 			struct mpc *mpc,
@@ -243,11 +318,14 @@ struct mpc_funcs {
 	 * Remove a specified MPCC from the MPC tree.
 	 *
 	 * Parameters:
-	 * [in/out] mpc		- MPC context.
-	 * [in/out] tree	- MPC tree structure that plane will be removed from.
-	 * [in/out] mpcc	- MPCC to be removed from tree.
 	 *
-	 * Return:  void
+	 * - [in/out] mpc   - MPC context.
+	 * - [in/out] tree  - MPC tree structure that plane will be removed from.
+	 * - [in/out] mpcc  - MPCC to be removed from tree.
+	 *
+	 * Return:
+	 *
+	 * void
 	 */
 	void (*remove_mpcc)(
 			struct mpc *mpc,
@@ -260,9 +338,12 @@ struct mpc_funcs {
 	 * Reset the MPCC HW status by disconnecting all muxes.
 	 *
 	 * Parameters:
-	 * [in/out] mpc		- MPC context.
 	 *
-	 * Return:  void
+	 * - [in/out] mpc - MPC context.
+	 *
+	 * Return:
+	 *
+	 * void
 	 */
 	void (*mpc_init)(struct mpc *mpc);
 	void (*mpc_init_single_inst)(
@@ -275,11 +356,14 @@ struct mpc_funcs {
 	 * Update the blending configuration for a specified MPCC.
 	 *
 	 * Parameters:
-	 * [in/out] mpc		- MPC context.
-	 * [in]     blnd_cfg	- MPCC blending configuration.
-	 * [in]     mpcc_id	- The MPCC physical instance.
 	 *
-	 * Return:  void
+	 * - [in/out] mpc - MPC context.
+	 * - [in] blnd_cfg - MPCC blending configuration.
+	 * - [in] mpcc_id  - The MPCC physical instance.
+	 *
+	 * Return:
+	 *
+	 * void
 	 */
 	void (*update_blending)(
 		struct mpc *mpc,
@@ -289,15 +373,18 @@ struct mpc_funcs {
 	/**
 	 * @cursor_lock:
 	 *
-	 * Lock cursor updates for the specified OPP.
-	 * OPP defines the set of MPCC that are locked together for cursor.
+	 * Lock cursor updates for the specified OPP. OPP defines the set of
+	 * MPCC that are locked together for cursor.
 	 *
 	 * Parameters:
-	 * [in] 	mpc		- MPC context.
-	 * [in]     opp_id	- The OPP to lock cursor updates on
-	 * [in]		lock	- lock/unlock the OPP
 	 *
-	 * Return:  void
+	 * - [in] mpc - MPC context.
+	 * - [in] opp_id  - The OPP to lock cursor updates on
+	 * - [in] lock - lock/unlock the OPP
+	 *
+	 * Return:
+	 *
+	 * void
 	 */
 	void (*cursor_lock)(
 			struct mpc *mpc,
@@ -307,20 +394,25 @@ struct mpc_funcs {
 	/**
 	 * @insert_plane_to_secondary:
 	 *
-	 * Add DPP into secondary MPC tree based on specified blending position.
-	 * Only used for planes that are part of blending chain for DWB output
+	 * Add DPP into secondary MPC tree based on specified blending
+	 * position.  Only used for planes that are part of blending chain for
+	 * DWB output
 	 *
 	 * Parameters:
-	 * [in/out] mpc		- MPC context.
-	 * [in/out] tree		- MPC tree structure that plane will be added to.
-	 * [in]	blnd_cfg	- MPCC blending configuration for the new blending layer.
-	 * [in]	sm_cfg		- MPCC stereo mix configuration for the new blending layer.
-	 *			  stereo mix must disable for the very bottom layer of the tree config.
-	 * [in]	insert_above_mpcc - Insert new plane above this MPCC.  If NULL, insert as bottom plane.
-	 * [in]	dpp_id		- DPP instance for the plane to be added.
-	 * [in]	mpcc_id		- The MPCC physical instance to use for blending.
-	 *
-	 * Return:  struct mpcc* - MPCC that was added.
+	 *
+	 * - [in/out] mpc  - MPC context.
+	 * - [in/out] tree - MPC tree structure that plane will be added to.
+	 * - [in] blnd_cfg - MPCC blending configuration for the new blending layer.
+	 * - [in] sm_cfg   - MPCC stereo mix configuration for the new blending layer.
+	 *	    stereo mix must disable for the very bottom layer of the tree config.
+	 * - [in] insert_above_mpcc - Insert new plane above this MPCC.  If
+	 *          NULL, insert as bottom plane.
+	 * - [in] dpp_id - DPP instance for the plane to be added.
+	 * - [in] mpcc_id - The MPCC physical instance to use for blending.
+	 *
+	 * Return:
+	 *
+	 * struct mpcc* - MPCC that was added.
 	 */
 	struct mpcc* (*insert_plane_to_secondary)(
 			struct mpc *mpc,
@@ -337,10 +429,14 @@ struct mpc_funcs {
 	 * Remove a specified DPP from the 'secondary' MPC tree.
 	 *
 	 * Parameters:
-	 * [in/out] mpc		- MPC context.
-	 * [in/out] tree	- MPC tree structure that plane will be removed from.
-	 * [in]     mpcc	- MPCC to be removed from tree.
-	 * Return:  void
+	 *
+	 * - [in/out] mpc  - MPC context.
+	 * - [in/out] tree - MPC tree structure that plane will be removed from.
+	 * - [in]     mpcc - MPCC to be removed from tree.
+	 *
+	 * Return:
+	 *
+	 * void
 	 */
 	void (*remove_mpcc_from_secondary)(
 			struct mpc *mpc,
-- 
2.42.0

