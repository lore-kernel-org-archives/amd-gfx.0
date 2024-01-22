Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E98DC47DDC
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB04210EB34;
	Mon, 22 Jan 2024 21:28:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A6710EB34
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK748R6OL9Wq17+fmrH9YASHfJs60rKwsi4F7VtprLzp++9n8NJshG2HjFD2+8Ysr3Opu6cvMNkRPLsO+S2KwUDIfUNTjMpPgO699MoZ0pxIr9O4VQ3E/pHm+dWFMby8mUt0hhLh1/7azhkT9bPYnFRNSJV5I74NiHF+B9KwkpZYKpcJtYs+T7bdmhIFms2w1BJV6l3wJj8PmPTeCdp8orihFwPDh6U4W3IMZLwiwAJsCMPNZHdgjO1dM//eu0AvoS6+h9p+9ZNRcsbzrVGQk91XG2ZxPsOB6JmvT/llPSohLPcJv7TjsRQDilX6mWnqfEuU1JSVmtZmA8sT3huf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jacBy9dtwn/zsS7C81QiMFv2P/QjktJroYQDSuisBCk=;
 b=Qnr1bnNBi9zpXGto0fmWiARiCTUSNSCa0hzCsUJDCx+zkmRlEFiWSHWDY2OiLdXBz7MDTX8heAxCxU2V6MZdF9Di2ZC2dimGFx/39ofOWJiT+MakpDRFWQoSGfFT9dNGeNbvDEJHgJoc2RR4r5ODfC86v9XQHNRZfY6lses6aefqTtE/82uDZP2oeE8+ij+2oKKzQXoJ+p1Cem44h9vkPqLiYhNMaZKewpGDm2UzKBsJCrHKLl9wCutRuBsr4Z82ZE9E4tcBaTfjjALQl2z0NC+ZJl7FZePs/A3rOQPBQMjDaubNrPNkI98ZdISFY30rhRo4P8V8DvxoaSPhF6CRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jacBy9dtwn/zsS7C81QiMFv2P/QjktJroYQDSuisBCk=;
 b=K+XxBl/gZEa3iRYlIWMkf4EZelspOfCnbadC0NCG/fZVHn89H7wZggZR7z80DtviHvDCKZ0x2lueHfDKZxZt4pzwyEq52j9E8t8eMWag/do8spKUsCFOpJmBgk4kyLG5nyiyqzdlUkaY7YTiHI+f50n+jVjnMDx+6TWU/+L2d2g=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 21:28:14 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::6) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:12 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 4/8] Documentation/gpu: Add kernel doc entry for MPC
Date: Mon, 22 Jan 2024 14:24:57 -0700
Message-ID: <20240122212719.647008-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 12251a5f-1640-4c62-6870-08dc1b910ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In+Y7xNFrj1158TRFESpDNB83DTWoJYzpc/p9oc2LchuW7tPK0ABTtHNnUbqWt/u5uzexSqpFrlw6vY4kzBPAjDlrZG1KFu/HCRJ3yfyjg5THwQ3fqFn9HD3KPtuYqhJeS6mEreZ0rC+ifwGD07sqAg4eLYi57AMNxvpA8sU9Xbe+78yaVcQGy6Nqa9MwD34umJdft4DDnJqlVSFXNDBQPX1XRhNWUFm3AhkkQMeiRK7BdhjQdyGsDYzwLnNmf0V6TzerZ8lmDX/kl6CNwUaS8DO4bMSQKz8XheIRC5K1ct5VH8rNFT5NOekrrWmozEXklQLjXChAmYFVZtaxFvFwjdd4Gpmy+beR2Mg+WQzKx1wm7S/hiiNRrStLgFwTeMzzEfgyFXQeWw12JrjMIeeqp0Z2dcM85r54kdNqkQ/ZQ59xOEr9Nso8NuiqdB4MWCBfNde0YWv3C0YTnFJYznyOPbtgqEnPsWEVzq4m8pd3I4uh6cZWlKtpLGSdpLOOYlEQjaMdu57c2x4hS+qp58kq+AJDNno5pvib5nRaqNo/t5nvZPnWuAemjF0f7GF5HOPblOwZ/QKiL09AimtHlUsN/TBFiDMjUlACdBpGJsY+hr2mvHJQ9Wf2u58By1FtJMA2FtvCr42iHqsjJ5JgIAUY08m/c6avliipeXLhVdv+qoxM1nTPQ8SsSzPlQ4+lHnHAsSPJxw/2++yVoOMAHJLbUQp0N7Z4nUx422KVz31wWsmyIHq/M25fhCDGj/7n1kRIIbgeahTg1LgPFupl6O+mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(26005)(16526019)(30864003)(70586007)(70206006)(426003)(110136005)(66574015)(2906002)(6666004)(478600001)(8676002)(4326008)(316002)(5660300002)(336012)(54906003)(1076003)(2616005)(8936002)(36860700001)(36756003)(82740400003)(47076005)(81166007)(356005)(83380400001)(86362001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:14.2366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12251a5f-1640-4c62-6870-08dc1b910ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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
Cc: Harry Wentland <Harry.Wentland@amd.com>, Rodrigo
 Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit adds a kernel-doc entry for the MPC block. Since it enabled
the kernel-doc to parse some of the documentation in the mpc.h file,
fixing some of the comments was required.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-blocks.rst         |  12 +
 .../gpu/amdgpu/display/display-manager.rst    |   3 -
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 250 ++++++++++++------
 3 files changed, 185 insertions(+), 80 deletions(-)

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
diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
index be2651ecdd7f..67a811e6891f 100644
--- a/Documentation/gpu/amdgpu/display/display-manager.rst
+++ b/Documentation/gpu/amdgpu/display/display-manager.rst
@@ -131,9 +131,6 @@ The DRM blend mode and its elements are then mapped by AMDGPU display manager
 (DM) to program the blending configuration of the Multiple Pipe/Plane Combined
 (MPC), as follows:
 
-.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
-   :doc: mpc-overview
-
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
    :functions: mpcc_blnd_cfg
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index a11e40fddc44..ba9b942ce09f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -23,13 +23,28 @@
  */
 
 /**
- * DOC: mpc-overview
+ * DOC: overview
  *
- * Multiple Pipe/Plane Combined (MPC) is a component in the hardware pipeline
+ * Multiple Pipe/Plane Combiner (MPC) is a component in the hardware pipeline
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
@@ -224,16 +295,20 @@ struct mpc_funcs {
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
@@ -250,11 +325,14 @@ struct mpc_funcs {
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
@@ -267,9 +345,12 @@ struct mpc_funcs {
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
@@ -282,11 +363,14 @@ struct mpc_funcs {
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
@@ -296,15 +380,18 @@ struct mpc_funcs {
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
@@ -314,20 +401,25 @@ struct mpc_funcs {
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
@@ -344,10 +436,14 @@ struct mpc_funcs {
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
2.43.0

