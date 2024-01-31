Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E757EC47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A5710FCD0;
	Wed, 31 Jan 2024 20:15:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A6710FCD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLxhQ2BpdSlaJsDJRQhmV6QmrNyFLvFNdREjrr3Br2kXRDd0GTIQXjW0qC9iBvm5L3u24VvNSCbPdmkbYyLdOiX3klgmTKmLlW9fnFnvc+aGzqcloGmwjQAp1a/DhROSh4HhYvBcD67DjO0/PvMbk5a49xjP/fmUmY5eQ+zi5CV2RQUlMxLIQTCQFeeeUGHsMsEhP42XA9sL62+NIhXlKzSgQtiLZQyVE6vvU+lPXrc7Jw+nUah94wVFw5WLTdn+KWvlruE0uRm/wBqdxTJvuMs0AcrJEnsUz7iF5JNfTLyzOksNknD4x6LZBK5JWf2/rR9E5A8OctNiRer99vSQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9BS6qoMxp/bvBjpxQNfp+Rr24YdSfsKzJMSipbcizg=;
 b=SXNeNEwFjOIkWR28NzedLhUQ6QVjsccdOkxFtr5nGk12c3Jbl273MJhQLoBN2tjFI0c70iSeSrFrg21CnbCbRDUN15+DcqyoZRY5Ai91D9egqb8fH6/QZYVe9MtzQV66IUWLmuxeHfjjGnkaz/uIYpZMi6X8upl8LL4FTTnmnzeFRyBC9PzcTF8NfE5x//x3ESvn+dcXpGh7hPW0Ymjlf3QIYHKPgxD8x5wCBorewpvguaHMSTtJzXmaf36YuR6HaMv4Gtq86tDO7jKIoJbOB6qtnu13kLEodND7jJEsVih48EHfNCwabddC2fr5DXVXB3ssB2FqMzoDlF2QXAMeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9BS6qoMxp/bvBjpxQNfp+Rr24YdSfsKzJMSipbcizg=;
 b=XNkoBWyZNzGLpccdlGUJLSkngiowj/LlVAqMeV4xP7JG98I2C3RxeAZ7oAVHfhooB/vdjzgrCLwDXoWQXCo9ojF0fbZDtnGT/Wp0cMsiqRNPE8/X7bA4T4Lm/eAJhiI+r/caCXISgKGIHAx5DadKbf6b5bV5N2cz7lRIEP4MXI4=
Received: from SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34) by
 SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:15:47 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::f2) by SN6PR01CA0021.outlook.office365.com
 (2603:10b6:805:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 20:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:15:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:15:19 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Drop legacy code
Date: Wed, 31 Jan 2024 15:11:23 -0500
Message-ID: <20240131201220.19106-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 441a1493-4118-4951-a205-08dc22996947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYC1B0IBMhW8jcMAy3k1l6KbaOE+nr8fvnDrpjPxmqgddzgJbFzIgFOxaDZl/61MolcHk78Z5PxFr4Q9Co3jC7p+v2Y2lLjADAu/nQL4bXzC6a+fmvPNXDYJ0IU2Q4QVOieQLWRLIz1j0iDkdM/pzpuWexCWqTFjiRO32Isl5PhF92xGxzZL5lgy9J/AsxQKhx1ZS9Qs6viXnmSb9pkPjoHFxcDzPEleUjPuKgt2pkvmZFWITpHgvtd3OHxc4EoqGszo7cf3SFu9iyR9Fhvt/R+OINEWtqyxxK05Bq6GI4TSmhERb/sDd4En4Rhw/vYQphBp0m/vdyOCf1rlgh1fOwcB2W+rUXpDOxnSCFm5HEEkUEC3GA6/qqrk5Y3dSD6M+Xxqj0H3qQnifdDoA5cOsIETrZcGJOHe0Oz1Je0crJPOLqtXVXqq2q5roOACzMsS9Xsul7WX42Tppq62nvh34L3+SGiv6uy+2ksrhnLHkbPFaSKZ7q7SpsQXC4LtR58Y32VTb2Eb3r8ZZuhcsXrx8uz1h0CMZVjYI66zxg8/CE7KzCYLj5sItCFgo/IKwqd2eM0VbfU+/3ZSxi7iYGcsBOqrqlpbgLs99MJnXslOFonLU+P/JflZutiCAMaa4VI3znNwBJbQ5B3cosG2OzQbDegVRtfl71OLtR3NhSDNxCv15QdJH9Bz8K7ujmmGUJNUJwj0WgM6TjWW6ohetjKay00e8u1yZ27mhRSmoYvJo1ATuS3Xks+asKWe538iW5vuQfDC2ufxwwPvE2QP+ARaYYSipbIntYe/VSws+NFPh7/pkOJGcJSZsmctwrxVYTdL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(16526019)(83380400001)(426003)(1076003)(336012)(2616005)(26005)(81166007)(82740400003)(36860700001)(4326008)(8936002)(8676002)(44832011)(5660300002)(2906002)(54906003)(70206006)(316002)(6666004)(478600001)(70586007)(6916009)(41300700001)(47076005)(356005)(86362001)(36756003)(40480700001)(40460700003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:15:47.0629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441a1493-4118-4951-a205-08dc22996947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Display code keeps getting improvements, and because of that, some
legacy code is left behind. This commit drops some of those unused
codes.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c     |  4 ----
 .../amd/display/dc/clk_mgr/dcn301/dcn301_smu.c  |  4 ----
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c    |  4 ----
 .../amd/display/dc/clk_mgr/dcn314/dcn314_smu.c  |  6 ------
 .../amd/display/dc/clk_mgr/dcn315/dcn315_smu.c  |  4 ----
 .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c  |  4 ----
 .../gpu/drm/amd/display/dc/core/dc_resource.c   | 17 -----------------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  1 -
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 -----------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c   |  2 --
 10 files changed, 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 8c9d45e5b13b..d72acbb049b1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -185,10 +185,6 @@ int rn_vbios_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int reque
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
-#ifdef DBG
-	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
-#endif
-
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index e4f96b6fd79d..19e5b3be9275 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -180,10 +180,6 @@ int dcn301_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
-#ifdef DBG
-	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
-#endif
-
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 32279c5db724..6904e95113c1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -202,10 +202,6 @@ int dcn31_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requeste
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
-#ifdef DBG
-	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
-#endif
-
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index 07baa10a8647..c4af406146b7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -220,12 +220,6 @@ int dcn314_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
-#ifdef DBG
-	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n",
-			actual_dcfclk_set_mhz,
-			actual_dcfclk_set_mhz * 1000);
-#endif
-
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 1042cf1a3ab0..879f1494c4cd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -215,10 +215,6 @@ int dcn315_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
-#ifdef DBG
-	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
-#endif
-
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index 3ed19197a755..8b82092b91cd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -189,10 +189,6 @@ int dcn316_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
-#ifdef DBG
-	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
-#endif
-
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bb750c3d17f8..96ea283bd169 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1871,23 +1871,6 @@ int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 
 bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
 {
-#ifdef DBG
-	if (pipe_ctx->stream == NULL) {
-		/* a free pipe with dangling states */
-		ASSERT(!pipe_ctx->plane_state);
-		ASSERT(!pipe_ctx->prev_odm_pipe);
-		ASSERT(!pipe_ctx->next_odm_pipe);
-		ASSERT(!pipe_ctx->top_pipe);
-		ASSERT(!pipe_ctx->bottom_pipe);
-	} else if (pipe_ctx->top_pipe) {
-		/* a secondary DPP pipe must be signed to a plane */
-		ASSERT(pipe_ctx->plane_state)
-	}
-	/* Add more checks here to prevent corrupted pipe ctx. It is very hard
-	 * to debug this issue afterwards because we can't pinpoint the code
-	 * location causing inconsistent pipe context states.
-	 */
-#endif
 	switch (type) {
 	case OTG_MASTER:
 		return !pipe_ctx->prev_odm_pipe &&
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 0684a0b93637..ae30fe2b6d0d 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -450,7 +450,6 @@ struct dmub_srv_create_params {
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs *hw_funcs;
 	void *user_ctx;
-	struct dc_context *dc_ctx;
 	enum dmub_asic asic;
 	uint32_t fw_version;
 	bool is_virtual;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index aaa211c828ed..59b96136871e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -26,15 +26,6 @@
 #ifndef DMUB_CMD_H
 #define DMUB_CMD_H
 
-#if defined(_TEST_HARNESS) || defined(FPGA_USB4)
-#include "dmub_fw_types.h"
-#include "include_legacy/atomfirmware.h"
-
-#if defined(_TEST_HARNESS)
-#include <string.h>
-#endif
-#else
-
 #include <asm/byteorder.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -42,8 +33,6 @@
 
 #include "atomfirmware.h"
 
-#endif // defined(_TEST_HARNESS) || defined(FPGA_USB4)
-
 //<DMUB_TYPES>==================================================================
 /* Basic type definitions. */
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 2daa1e0c8061..305463b8f110 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -32,8 +32,6 @@
 #include "dcn/dcn_3_2_0_offset.h"
 #include "dcn/dcn_3_2_0_sh_mask.h"
 
-#define DCN_BASE__INST0_SEG2                       0x000034C0
-
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 #define CTX dmub
 #define REGS dmub->regs_dcn32
-- 
2.43.0

