Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F614C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B3510E9B6;
	Wed, 28 Sep 2022 19:41:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8ED10E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHzoy4KhQeLSd8cs6WLLTzONBRg6+BNvOETQ/BLG++o8gpfo1EEh3rDDFsCa1FrJA4/wH/P8EBxcypkM6qk/3c1gDBjzJph20r23o8M6pfWGp7RkO/3OW7bc+sbBrlQ0CQH3WLwIwPa1ciRa3WCo79M/rnIQ3Q75vMi+MirrCkG+LZ4EBniN6ZI4hwT54P4XjLL39+j6sWJQXaFgeZYDXoizEi2CshNkqk9+/46sohQZ5FsHbXnhMHY4ry9cnNxBKOWJYxy3CQaZ2OwzbNBH9KuzgnCu51G0bBuV6X0BVsWcJSKbRqx5JFQininOF3jgrYqUCRDl9xUELKCF+1pefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dPbeG3q0lpevkqN1W+iH/E9F5M0d9pUVTBeId4vS70=;
 b=DosNDISA7p4bFVOwNwThYGUlTw45nconsPLw7fagN2xbHBevrBbyMZIO+uEU+4odVXQAC9PLPlnPOOY1fR+e9hRlXWIEe6R+tktWKVFridnqJhWCGACDaK343i8R+7eDFKYuQCUrz44id/umwjUvw7eQCDwISG1eXBmC4Wty22xM5c5FTr30oB1YnMrGEKGW8qK1pvQshIM0CO+KmvfCazpewIheD9OlOozfqmv01EiU1GC9KR76f8yqyYgXvqI9Y0SEbWVdTWtB61h3Qht4KY40h3ByyZ/5e77GCPhxzm8KGxMz3g3ivpnekNu2GMpngk7IF624EgfXNrPvmMwMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dPbeG3q0lpevkqN1W+iH/E9F5M0d9pUVTBeId4vS70=;
 b=e/PY27VtK0UGgWWlO2wznHeN1pDdaO+kqJ9k1CY0ydrx28uFcVraW656i/dvUuO2sZd5vlk6L3wwArNjfcmjpKfigoPUcFNxHai6T/imqGkyL98xzAYuMqHhXkpzM7YGN+99JG6P0lsyZBzr8xYefggs0ZiUCi7w1AdSItHLsvM=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:40:52 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::60) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:52 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:50 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/36] drm/amd/display: Block SubVP if rotation being used
Date: Wed, 28 Sep 2022 15:39:57 -0400
Message-ID: <20220928194028.144879-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|BN9PR12MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3bc755-31f1-4ce4-2cfd-08daa1895a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMszOojbTQpvwhQ/mhtvZrxxinzLQZmn8Rc5B1oCFwhAGZILqMb2uAa44ep8uRWPKrzz/oFAnDZqvQgZ54UbwZnFWUm/YC1NwlgCOxcdu7aY6TMDTppNNvXV73bF00M0BhMcShfXEoxltKwnckWilwseIt9y6yxY9jK2xLQ8Tbc2ue2GtHtXNJ4CkE4FsTlupBveTz3uNNRiJ/s2UQUeJ1vCI74XcNJY226UxsMzV/yYE/R/8Eaa5cK+4BnWiEukr8bqvP3hNd05YINK4nmqcCoUaWcZ7g+YoouOG0PtwuFvFYUlUO9sDF3Ohwzx/aSUDAmBWoc8NOV3kXkkFpeek40k3rfFJkEhaB7glfuqSA/SfxerwiI3Z8yC6anIWi7tn3JuphEDpf2TkDEnHeHrP6CkwkyB44xHgmOncNS0jT0NkXun3jCj/6FZmvDxPwyoGjl4Jff3DRpPGssRsNqnBQZmIHeAk9vbutACZnWe0Ce62td522GYF8a0C8tbOdtpgzJq1Z19K+V61SZUarsuEtGnlr8rC9SDzsNtUdO+2LJnGQgyi6JzbeLwgpkSjka1VRXwa/4gXBTwWEwLSNIr4SUY/wVvDgssJIbBDrJ1+ftnnFajarMIn96uk4lP5GnoMhW8Vb7dNxRePQcLPpwqjhx/2MA7xMUiBa6NfR3ndqGXDnpQTlH9fK9WQWq2CvmqADDiiHaEl4rQxGx/HGglqFBLqRhZxkIcbItWYmC5cbFx6xFBznIvaqRWKph+N5QggYQGvkeCZ0cqbebZENTRyuv1Big3WVpwY6ll2YmT3rzO5KFJAdi78pnWE+uNeaAfnz+PL9k+fjSUroheJUAmWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(316002)(336012)(7696005)(54906003)(82740400003)(16526019)(6916009)(1076003)(186003)(2616005)(36860700001)(8936002)(86362001)(26005)(70586007)(41300700001)(8676002)(70206006)(40480700001)(426003)(83380400001)(47076005)(81166007)(2906002)(4326008)(40460700003)(82310400005)(356005)(5660300002)(478600001)(44832011)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:52.6571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3bc755-31f1-4ce4-2cfd-08daa1895a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- SubVP rotation support is not explicitly implemented,
  so block SubVP in rotation cases to avoid unexpected
  behaviors

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h   |  2 ++
 .../display/dc/dcn32/dcn32_resource_helpers.c   | 17 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c    |  3 ++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 55945cca2260..a24f538bdc4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -108,6 +108,8 @@ bool dcn32_subvp_in_use(struct dc *dc,
 
 bool dcn32_mpo_in_use(struct dc_state *context);
 
+bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
+
 struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 		struct dc_state *state,
 		const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a2a70a1572b7..7f318ced5dee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -233,6 +233,23 @@ bool dcn32_mpo_in_use(struct dc_state *context)
 	return false;
 }
 
+
+bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->plane_state && pipe->plane_state->rotation != ROTATION_ANGLE_0)
+			return true;
+	}
+	return false;
+}
+
 /**
  * *******************************************************************************************
  * dcn32_determine_det_override: Determine DET allocation for each pipe
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0571700f53f9..a56ee04f7df9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1115,7 +1115,8 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	 * 5. (Config doesn't support MCLK in VACTIVE/VBLANK || dc->debug.force_subvp_mclk_switch)
 	 */
 	if (!dc->debug.force_disable_subvp && dcn32_all_pipes_have_stream_and_plane(dc, context) &&
-	    !dcn32_mpo_in_use(context) && (*vlevel == context->bw_ctx.dml.soc.num_states ||
+	    !dcn32_mpo_in_use(context) && !dcn32_any_surfaces_rotated(dc, context) &&
+		(*vlevel == context->bw_ctx.dml.soc.num_states ||
 	    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported ||
 	    dc->debug.force_subvp_mclk_switch)) {
 
-- 
2.37.2

