Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666CC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB17910E888;
	Fri,  1 Dec 2023 13:29:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04D410E8A6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuMzruHXuqe0b4X4TiMoFMz5e21QmfMYg7W4weB86liitzsluhRwiJqsmvoA5XfhpZzsOfUEhvDNVRVTUGauxYdkUGDLLv/gV5mu+UzgYj4hjp7uhcdD0XywFFWvwfl7PdS8Boxoi39Wb8P4gGM0QE/fu68PiR9m0SZS1++ulM8+wh7UTxnwaCBphfzkRUmqAZJeEoop+MezlCNikO0kSp5v5JQTcXUcDtCD8tLk9B3JfNd8QpH8ViJDksMnJy+tgsPSCwRwdI6owOcpUASWKxgrjEG3tXLBy/CNWLal2KQo94r9xrKUOkJX243Ehuysn76RSO+3mRinXjTtKOmo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO8kvYjctkjVpSAhWoJKZI8pWASLGZL43ZvKgwka/GU=;
 b=cB6qcUV3kS3CuOiqhAKJ5n9dy3YwQEwYduw/2cvoWHa5ilwm1poynTCXiTO3cb8VE9mJJSFx9oukn0Z3PWz1dMTXRcPuJngte5ktMrF0oMTQoBnTe0RvP4dbGekvN8zOfOuAZe+xnCDsdBQbzT8nrEFO3//37ire5M/loVXjgfoTFsuoMwT9NztSUMZuC/LHR+tiCmwf8rgOmRbAsfLnW0ZD0DlUhZvyIqmT1WkTrX3vbQFSBMPY9Z6XSwkIagraKg66KQjj6DRbyzUD1H8AmWHnhQqwh3L/jnYOTieKA2my8o9f3fofZkD4smrGxoVAZ0CPB3YBCbnM4DuGIcRrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO8kvYjctkjVpSAhWoJKZI8pWASLGZL43ZvKgwka/GU=;
 b=jsn5EE+3Z7YfmIjMeNvojOzjFJFx6clp4XaoH15Rrs9gnebLAis/YNG8DE0O0TSUmqimkx6jlZuuHfKNOL530e9dzR7a1w7LWlBGJQQ7RgtNpkduXZ7sG+LMGuxadRuiMQSKcZ41N5eEW4Vuco1tQiC/lEZuHffo2LDMR2+KYaU=
Received: from CH2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:610:50::39)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:42 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::e4) by CH2PR16CA0029.outlook.office365.com
 (2603:10b6:610:50::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:39 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/47] drm/amd/display: Add dml2 copy functions
Date: Fri, 1 Dec 2023 06:25:18 -0700
Message-ID: <20231201132731.2354141-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: badd6a90-0fe0-4948-2433-08dbf2716f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5eXZPuBVdQuxs6GsGItYGASwLDtB2S+rYqfKANajz2GFkf3/KVb1M+MJ70W7biWPVmxFYugW8OaXJOfw8EUw8YQO4AK1yzBezA59jKmJJnIWKdDmJmt6cnw+jDqayCK42K7bve/9DD4OpE5m4WrR/Xtl/HoqDvQ5TLnITWb2QkW2ZgBur8PZtdl0hfol6cOxVVmkTJtMYSlCEj8jLo8xPe2rje2PycF151ZQKvy2EJ0nl1wIIedakWePQbaePPLkrigh94c7TACBIPMUAFSrGZuFbLng8ra+utLKuSFF0kTnHibblDSfBZJwc5d6LOe1MntOjS2xti/I5VUbHsgz8NR5rQ7+32seQwwXzrNbvaez9aQ3gtKVovA8vwDml2rhxkS/nJOePsIJHFrgdJB6bx/BTZj/Iioj40EK/9lxkXWv/2jA45bu3qIQF11Qf7LKl5JQ/7CitNe1PAbmQ8gbBR2rTJ0WL5H7IDLl8uYl5qqaF9IM4EqeGAyKJB0XiOTmuuXya3AJj9aQC6glbDxfXNgfHx9BaPgmByE8CjJ/MB+KIINg/Yv9xZPXvPunBaSx/ENMfjdLQR7p+aHTw/rGGUrFf3NbCIpNiDLsHxBh+xM9DIpjbcZ0YPqdQndQfc25OA6G54JfRbSc6//qoXf2p0u3jG8vpkUVQSFGZwjH6ReZVxEmaooBVT/0ML0cR/EhX/F2GGw1e9z1/JSoYsyoHpJO/tGMjltkjwRiGZ3eZ5/qM/OjEI6iuUs+1QsSToKEsPkPWkdx0gAmdo+a1sXFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(4326008)(8676002)(8936002)(336012)(26005)(16526019)(316002)(41300700001)(54906003)(6916009)(70206006)(70586007)(1076003)(5660300002)(426003)(2616005)(83380400001)(40480700001)(47076005)(36860700001)(356005)(81166007)(82740400003)(40460700003)(86362001)(6666004)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:41.9310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badd6a90-0fe0-4948-2433-08dbf2716f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 jerry.zuo@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

Add function to handle deep copying dml2 context.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 15 +++-------
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 29 ++++++++++++++++++-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  4 +++
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eab713c0da0d..102d00a9a24f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2258,23 +2258,16 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx)
 {
 	int i, j;
 	struct dc_state *new_ctx = kvmalloc(sizeof(struct dc_state), GFP_KERNEL);
-#ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_context *dml2 =  NULL;
-#endif
 
 	if (!new_ctx)
 		return NULL;
 	memcpy(new_ctx, src_ctx, sizeof(struct dc_state));
 
 #ifdef CONFIG_DRM_AMD_DC_FP
-	if (new_ctx->bw_ctx.dml2) {
-		dml2 = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
-		if (!dml2)
-			return NULL;
-
-		memcpy(dml2, src_ctx->bw_ctx.dml2, sizeof(struct dml2_context));
-		new_ctx->bw_ctx.dml2 = dml2;
-	}
+	if (new_ctx->bw_ctx.dml2 && !dml2_create_copy(&new_ctx->bw_ctx.dml2, src_ctx->bw_ctx.dml2)) {
+		dc_release_state(new_ctx);
+		return NULL;
+ 	}
 #endif
 
 	for (i = 0; i < MAX_PIPES; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 8f231418870f..9d354fde6908 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -691,10 +691,15 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, bool fast_v
 	return out;
 }
 
+static inline struct dml2_context *dml2_allocate_memory(void)
+{
+	return (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+}
+
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
 	// Allocate Mode Lib Ctx
-	*dml2 = (struct dml2_context *) kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	*dml2 = dml2_allocate_memory();
 
 	if (!(*dml2))
 		return false;
@@ -745,3 +750,25 @@ void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
 	*fclk_change_support = (unsigned int) dml2->v20.dml_core_ctx.ms.support.FCLKChangeSupport[0];
 	*dram_clk_change_support = (unsigned int) dml2->v20.dml_core_ctx.ms.support.DRAMClockChangeSupport[0];
 }
+
+void dml2_copy(struct dml2_context *dst_dml2,
+	struct dml2_context *src_dml2)
+{
+	/* copy Mode Lib Ctx */
+	memcpy(dst_dml2, src_dml2, sizeof(struct dml2_context));
+}
+
+bool dml2_create_copy(struct dml2_context **dst_dml2,
+	struct dml2_context *src_dml2)
+{
+	/* Allocate Mode Lib Ctx */
+	*dst_dml2 = dml2_allocate_memory();
+
+	if (!(*dst_dml2))
+		return false;
+
+	/* copy Mode Lib Ctx */
+	dml2_copy(*dst_dml2, src_dml2);
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index fe15baa4bf09..0de6886969c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -191,6 +191,10 @@ bool dml2_create(const struct dc *in_dc,
 				 struct dml2_context **dml2);
 
 void dml2_destroy(struct dml2_context *dml2);
+void dml2_copy(struct dml2_context *dst_dml2,
+	struct dml2_context *src_dml2);
+bool dml2_create_copy(struct dml2_context **dst_dml2,
+	struct dml2_context *src_dml2);
 
 /*
  * dml2_validate - Determines if a display configuration is supported or not.
-- 
2.42.0

