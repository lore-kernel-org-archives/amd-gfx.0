Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8713C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D8A950AB;
	Tue, 12 Jul 2022 15:40:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD9595099
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNS+maE4+q0P6Z9e1Cn+LgLCWLU4uyccz+VocB/n0p1QAHmWVTQInUiLUdL37r02jI37ZObbcH0B35BxN4WTGJIxmgfOnvdszCGCnI1r3cBFXq2SAttts/+40oAkcUfX6q+YLAUH3Y5+E/1FlFNc9eEQC+dmK2AaQjp6Bp081ENTphhLXffLpDQFALbwoBwnmi2CRLa81Hphdg/V7+1CxRKgfMe7Q5UfmVzLisgqni8x3d167MGwhZ63KT+6QdBsydkMrabt12zEABL+/SC/6eovpgAqT/6sUsELIvZWKt87WyZa/o8vnDDFUVS8ivg5JOt32KV3DselepJNYlTLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NMg8cGELJ58A3v5yqOnE6xxxJHNYtJLJttshd7rFy0=;
 b=ItuJcHzyqzu2QE3z49fLix+x2rD4W0bmrnPINPdUSMftV56MikYm0SJGsbI5lMuT/0mhRT456jOVHI2P6z7F24Pd/EqWnaAVca9OZk09TsCaS5Nwb/SL7/scPPKuljFboyhhaIxzteCW1RjVsrlqGNX7CaQY4rWvpDzgdpMeYhEQeIJfDm2yFpgLoS8KY85Q3HrTHi6B4k/WYblC0tucPI7Qywc+3cTSvN4c+z59QO+CRRsrvgmzkelX7FtwsnBrb0K6SYGpulHC8iFebUSsmW12bjyfMSs4UWjJCrRA4RAZ40eTpBTijZV7E5kUZxQnlpjxQR5x7KD7NYOc6E3X3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NMg8cGELJ58A3v5yqOnE6xxxJHNYtJLJttshd7rFy0=;
 b=IapOe4nqLqlebbQSUS7i6IleAJi+2PxrQzaz1z2xALKcVDdIc5GWvHqLfuiTo/xiZvNbPjyipo3YEMH34WaxOzTZMmL02+WUtTnEfCx+bs21iDOvDP8kBjfRnIVKQpOoa8ivJOA2927VuxY8PQczUxLZSWcDJuy8zww75c4ihFk=
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:40:32 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::e3) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:40:31 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:40:26 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amd/display: Add DCN reg offsets to DC
Date: Tue, 12 Jul 2022 23:40:12 +0800
Message-ID: <20220712154012.501452-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5075100-94bc-42db-8c1f-08da641cdac4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tMSFG1src0HLT2jnO5RbN1+qk0mVRiIIqpD283qyPd9c6EZni1b00mYZf1spqCmh3im0Ci2vMg1G4qIS7A81IXL3wOGmpbq5ACy98IrCbvRg5E8wcT+kDA84yyTvQ22Ghyz0e5lMakK83bSAmJHH55Fs0ZGIsNZ4EHVnOj9Ro/i4LGeERTHYBh5i2M57sJjNhzFPSHUtJ5/WWoLDFZYMzVSq7GanZYYKiWVuwqjSuB5CRWl8H/Of3JPryHwEQpQDHizisSAmjxKZS/dVVmswzpiUrNawk7A9wKFBlp0VgI1gyoojuYLzRp3h2jkmM4Ac2BLtacF+OPDyeaQuBBQ0uqg49+WTX99ATevigK/e8d3TmFfuk7+RPafX5T3rFjyi2mdq8eOiTmwyrC+PCRct+Gjzs87+TjG0Lu2xEGQBo34dZDsxoRBO20wb8JbQRkcLWQX5XDLFL+deQAtCKrljYDZu3QQF/f4rIpB2p3ZjjhwWkFzy9q6znRykk9AORC2NVfz/Lor0Vrt5RLVNV6DHSkkd6HP2zqNAiyfC8VS3/E/w2a73Qv6PpJjolsrhrrrblLXyC8yTNJkh25XDJVqFsM1c5cKXNTFzw4sbvKsxPf7aHSb8m5c3pgHaNxjTBUeOO2KrOJvi2YNFcOTflWXkHtOJy9iQq2nf8zCXzneVLd38DdUQhm8T2o8TnIflC20FjrSAeiArDPKivoDW0etKQncZY8ckRvZjg94bUuXZPgheLq6IdP1Xtm3VB9iRJlllZ8g4OSWJem14aXm9aNJIyn20TNUDW9vVLeaD9sJidehgwX+xyoq/3/DObkvKh6M8QZh6pvRbwh0uChKWH+idgrT+Xv0UD+T8fnqF1q79pY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(46966006)(36840700001)(478600001)(7696005)(26005)(81166007)(86362001)(336012)(82740400003)(70586007)(36860700001)(47076005)(16526019)(426003)(36756003)(6916009)(54906003)(70206006)(8676002)(1076003)(316002)(186003)(2616005)(4326008)(8936002)(41300700001)(2906002)(40460700003)(6666004)(44832011)(5660300002)(83380400001)(356005)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:40:31.7897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5075100-94bc-42db-8c1f-08da641cdac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
Add a field to store the DCN IP offset for use with runtime offset
calculation

This offset is indexed using reg*_BASE_IDX for the corresponding
group of registers. For example, address of DIG_BE_CNTL instance 0 is
calculated like: dcn_reg_offsets[regDIG0_DIG_BE_CNTL_BASE_IDX] +
regDIG0_DIG_BE_CNTL.

{dcn,nbio}_reg_offsets are used only for the ASICs for which runtime
initializaion of offsets are enabled through the modified SR* macros
that contain an additional REG_STRUCT element in the macro definition.

DCN3.5+ will fail dc_create() if {dcn,nbio}_reg_offsets are null. They
are applicable starting with DCN32/321 and are not used for ASICs
upstreamed before them. ASICs before DCN32/321 will not contain any
computation that involves {dcn,nbio}_reg_offsets. For them, the
address/offset computation is done during compile time.

This is evident from the BASE_INNER definition for compile time vs run
time initialization:

Compile time init: #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
Run time init:     #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]

BASE_INNER macro is local to each dcnxx_resource.c and hence different
ASICs can have either runtime or compile time initialization of offsets.

The computation of offset is done for registers all at once during
driver load and hence it does not introduce any performance overhead
during normal operation.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  3 +++
 drivers/gpu/drm/amd/display/dc/dc.h               | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h         |  2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 000d34a7b6b4..78ba2762fe9d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1527,6 +1527,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.enable_mipi_converter_optimization = true;
 
+	init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
+
 	INIT_LIST_HEAD(&adev->dm.da_list);
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 03bf4be81ea3..6039b3487d4f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -862,6 +862,7 @@ static bool dc_construct_ctx(struct dc *dc,
 	dc_ctx->dc_sink_id_count = 0;
 	dc_ctx->dc_stream_id_count = 0;
 	dc_ctx->dce_environment = init_params->dce_environment;
+	dc_ctx->dcn_reg_offsets = init_params->dcn_reg_offsets;
 
 	/* Create logger */
 
@@ -1241,6 +1242,8 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 			dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
 	}
 
+	dc->dcn_reg_offsets = init_params->dcn_reg_offsets;
+
 	/* Populate versioning information */
 	dc->versions.dc_ver = DC_VER;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1dca016b5782..faa22580852b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -808,6 +808,8 @@ struct dc {
 
 	const char *build_id;
 	struct vm_helper *vm_helper;
+
+	uint32_t *dcn_reg_offsets;
 };
 
 enum frame_buffer_mode {
@@ -847,6 +849,14 @@ struct dc_init_data {
 
 	struct dpcd_vendor_signature vendor_signature;
 	bool force_smu_not_present;
+	/*
+	 * IP offset for run time initializaion of register addresses
+	 *
+	 * DCN3.5+ will fail dc_create() if these fields are null for them. They are
+	 * applicable starting with DCN32/321 and are not used for ASICs upstreamed
+	 * before them.
+	 */
+	uint32_t *dcn_reg_offsets;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 7e595310a4b8..077a93e81561 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -876,7 +876,7 @@ struct dc_context {
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct cp_psp cp_psp;
 #endif
-
+	uint32_t *dcn_reg_offsets;
 };
 
 /* DSC DPCD capabilities */
-- 
2.25.1

