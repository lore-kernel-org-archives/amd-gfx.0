Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD6ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C98B10E812;
	Wed, 14 Sep 2022 03:55:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA81810E812
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwiVq6HYSLfn/qch0CT0/Q22cW7iYfpf5oHyQ4spv0VxWVeYvbg6lQS8h1PQHkm/h/J12bWozB4/D5S4RbwoqaTL6GVKJp6+O9KG/ZqgqiujJo04N4mWpZeKPAoon1EXZORhDFOSWK8Q0QE6UVehlPIh/nmYfvEjRZki75jilNTonnBzNmo0eFEZ4rRES5JqSBiJ5HaVaM1ZscK194XAgql6a/8r/Ahy6OlUJqUWgBAebWlc+YQMrt76eOACig2u0p2LgD47gZJGdhweXLeht1mx19dYBlPzM0u0JpbdLTyrdG1KGbIl9N7cfsZkhy2WVVQyXqIAqsG5PH9XQXJ3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5D/kWN32UWc0bccXRYLkW4B9d71JkKKfDfnFIqrDsg=;
 b=Murcawm91xIPMA/qVq70PgAtXltF7+CurEdq+77y800Csb7e2f5lcHQ6PaATa4Jvo40EATSsf9zfwf2N+EpFZnHkUM5S0Fp70YYiXlw2URX/B9go/W3yzJnJ55gE22B4qCpnmwGxk3Ih/FLZNwn0Qdo4zelKzuSYvkhMv9KSBNxFS6kTE0DrRwt//oDy7JCj+PzLQXh+W0rlu0qfanOCkRAoUpB2YJyGkNvFxnvkftCVUY2A5t746aOgRqHXWDwlGGcOVBxO4Rm5mDaA0gFGQMAV4KQeLLzi6rk24m2BdWlJXgffz1oBGexoJbF0zUd/g4QJMxsDq4zEI5+0nriplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5D/kWN32UWc0bccXRYLkW4B9d71JkKKfDfnFIqrDsg=;
 b=wOTq96qbBsTYzzBSRP1HGyX/cN9mKI5nHGhUfGgKP5Omn2Eb72YHgF71VZb8sDXVMJvDB4vPw0sGLqoWudE8XXxMA4RGdYg+AsBmSp5NmFsEjAS2Or7YkqMa9im3zZkBKyJhjO1VaMw0qqXYKBbOKMx1cjuLOQWOQYixD+UZtME=
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:54:55 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::f6) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:54:54 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:54:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:54:53 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:54:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 27/47] drm/amd/display: Expose few dchubbub functions
Date: Wed, 14 Sep 2022 11:47:48 +0800
Message-ID: <20220914034808.1093521-28-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 00577fca-e30a-490b-f897-08da9604e26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlCeUI2yS7YZzo81tneTCj9RoGQIs1uORuaAUM17H0RkFNKQl52wgk7ayJPZZtX7zKR7A4/hUcDytDyEGmvx/CJHvfU7Wx2alIqtCUqg3EY35MTQLRQqmpmXwTHOxed5pzPpG16S1ggVXicZp6aEo5j6JBlwJpy6QyMTFnGXFONXCRq+skU7mEAA6vvLAMQXdDf/+pezzJ7B8gvthxSN6FwVIge6wUMZ27XEX3FOUyQhqTXZ6kjHrCOFKsrGpq2uyuvElyKhATt6OoSuOy0VDA2f0IDNWwVqY6aR6SFxtcj7zRI+iuZRNgBiMT9Ycj0YjRpZ5Sa7xzGczhmyXn6bNgjsKMayc4UdOXUtGq1rjOMI8L5yunI+H816+SB9IiV5PM3Mga+BVstpD3rcaN1nGWz8LKsMC4h0Xz9DYYPmibXqzWmL6L7cU8ATuEHvEGsXCJ3hz54keb/c0EnPfhjOHm8t3vPE5f270lAlkzlMZMBBc8oqFQuc3Te1kTQfQhsp8IiOnp56WopWzXvWzS60JOaVMLM2drDL9lJOPYfeDnAyWuEwQQHr6UkZtIJ8npw01ASIgVWy/A7DA9gAy7ChDGbKcuhgbtRXJbopMhC47P/zcSS2JL5RbHHd9QoldYippCW6UHHv3yHBOPTzZ5rxzn4EOoZeY+vsffynYOhPOjXe8sTQ/uiPzzet9OgxNly5JJcFd+0VgYucbPaAwMM48iQYVvS4UyHziDd0TPdNTxlSy5vc3QrSE/WPOkjbeePHZmN3MnjrjTrHY6h62IPxB+n/teiVy/PGVq3gFGis12p7pHJSLpzpvEJ/QkyP7Qza
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(70206006)(1076003)(7696005)(8676002)(70586007)(186003)(4326008)(86362001)(40460700003)(426003)(6916009)(26005)(2906002)(36756003)(356005)(41300700001)(316002)(336012)(5660300002)(40480700001)(81166007)(82310400005)(54906003)(47076005)(2616005)(478600001)(8936002)(82740400003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:54:54.8418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00577fca-e30a-490b-f897-08da9604e26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Expose few dchubbun functions in dcn31 and dcn32 to leverage.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |  2 ++
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   | 10 +++----
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   | 29 +++++++++++++++++++
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 51c5f3685470..6360dc9502e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -876,7 +876,7 @@ static bool hubbub31_get_dcc_compression_cap(struct hubbub *hubbub,
 	return true;
 }
 
-static int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
+int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
 		struct dcn_hubbub_phys_addr_config *pa_config)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
index e3a654bf04e8..70c60de448ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
@@ -122,6 +122,8 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
+int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config);
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub3,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 99eb239bbc7b..3d3226aca2ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -68,7 +68,7 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
-static void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte)
+void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -140,7 +140,7 @@ static uint32_t convert_and_clamp(
 	return ret_val;
 }
 
-static bool hubbub32_program_urgent_watermarks(
+bool hubbub32_program_urgent_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -330,7 +330,7 @@ static bool hubbub32_program_urgent_watermarks(
 	return wm_pending;
 }
 
-static bool hubbub32_program_stutter_watermarks(
+bool hubbub32_program_stutter_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -476,7 +476,7 @@ static bool hubbub32_program_stutter_watermarks(
 }
 
 
-static bool hubbub32_program_pstate_watermarks(
+bool hubbub32_program_pstate_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
@@ -629,7 +629,7 @@ static bool hubbub32_program_pstate_watermarks(
 }
 
 
-static bool hubbub32_program_usr_watermarks(
+bool hubbub32_program_usr_watermarks(
 		struct hubbub *hubbub,
 		struct dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index 3bae6e558971..cda94e0e31bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -161,6 +161,35 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
+bool hubbub32_program_urgent_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+bool hubbub32_program_stutter_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+bool hubbub32_program_pstate_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+bool hubbub32_program_usr_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower);
+
+void hubbub32_force_usr_retraining_allow(struct hubbub *hubbub, bool allow);
+
+void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub);
+
+void dcn32_program_det_size(struct hubbub *hubbub, int hubp_inst, unsigned int det_buffer_size_in_kbyte);
 
 void hubbub32_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
-- 
2.37.3

