Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2398606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qSOnfVZp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EDA10F823;
	Wed, 25 Nov 2026 06:57:29 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9574410F636
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNHEgNnswZAO8K9EDN1xnU6RtolhC/FhcsNtZwjUSM62PKFYf+WNXqykZzmqnOqDX3sv1xZlI18YG79ds6ozlr8nGbvwIEGvxERjZheWHqGqMx7XyYqWpvMJINHLwDhG8+Dz1J6fNpuZZhNFcTFXBUApnbXei7uRwlXsfnOHl/BFbBPP6bTdWW0wRin22QzT80/3PkqLm4NT9beMh46IWFCveKK/eFi2W6WIgokxo4+xiru20oszQ/Uy1wuz5A/rCOoSD6/9mfclah151YCTODKchzKfhZXubKhjpBxGq+TJU0pGvi/Yat2lnDNdGm4H3Nd+1oxzo1ziqJaqddGKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1nx/Ab83U1axZYhc6ElfJ1+wQvM0R0Lx9hIi4uckAM=;
 b=miWV4ufWLst4o7JoNBtQ9t3gNE4qVG8+P3Aor0777vLqf2vTqMv3m11H+5rMpM/s2h5E4tMvXkXFFDsOI+9P0LF5R08mLu8plrBA99EWQmaWZn2zvbbUra3tN1d5rIJevuVIN9guHxgrZ/W+ZE05H590Tndoz0zhRBTggLL2UNNxQf9aYpcr2M6k8q2Xvhvh7UmL2Z9f5gz5YEE9ViCr7geZ3pyBdEP8NVr+Nh99M6YrcLfDlfAuNkWNN/Xyn56Lgml9I+xbX7MDVGNOB1iKxc7jiw54MXhahoXdJkHbc0pg+ZFP1qud8lpZPy3Ui33peCnpFYfZ+8g5SY+U7hh8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1nx/Ab83U1axZYhc6ElfJ1+wQvM0R0Lx9hIi4uckAM=;
 b=qSOnfVZpFM4ym4HFMWUA0KONCpF0R+8qJshI40vELhm1DlZ00kv+WJqJASpXyHmz37iuRXV+oBMa3WWwi3wmLMXQ7YADicTVaxvSPuK8QgdlLwKTwA30iyShTOHtco92xCLfDDofhNqN/K2UR+NPGlCCPGkNAbTiTglohPvZUFo=
Received: from PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::11)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:57:18 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:510:34b:cafe::a9) by PH5P222CA0010.outlook.office365.com
 (2603:10b6:510:34b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:57:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:17 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:57:09 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 14/27] drm/amd/display: Add DMUB timer reference clock to
 ref_clocks
Date: Wed, 25 Nov 2026 14:55:03 +0800
Message-ID: <20261125065631.3889665-15-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f0783a-199e-407c-a437-08df4ac158a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261021135927099003|261102123227099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k0OusrEsdwVdvYS7PCJtPsSWngIv8zS0sH+UC5O1Ej4Vl5f3B8+Fvrh6DcCmmSGZHVDbezxWjyBiO6OYdBOkS5RJlo0gYxSiyhc49XpJH2IPJu03eCXpqsD8QrJ96Aaas+EyITBc646rgNUy6lRVYGfxOnnFBYZ5LcvuoVUy4r9urbKhmlJI8OlSkmI+dfVN6cNEL/c8lOGrI7BIFSdHWLg0JTUZFzjZzA7GzxzA+AMtJuxpCK3D8OK/hKDBbzI8sQgwzPIJLCt6/5vIrSTui6uvmQbgNggq0Id3OASw6sib0Jt37q3utPO1fCPJrQvulB4nzAoG9fNrhAx9C7h8p0l2gKYNWIKu1Q8r6WUomymTxXhzFRMTMLWSQzNByjzrAncTlkK+WH8PZ55yV+SlqW9wiZQRMndhPk90M2sQ12+gYoPpMxHFCyIytOJPSd13aLGH+V3kdQYErFJdtA+gLJ5+U3qSqSRtvoEK9L1ovy74KE+nSHVAgVaTiALnW4Z0jbNJbu1drUjvJwTjXf87MfLQ98xWZpSQjtJb5NdWhjhad9yveYHT8nYn9XejIFUYMZQ4TWLELHqvY8vUKmxR47uJ+6jCF0tg6DcxCGXaPx4Oz23hCuYyoj3E/hk4Kg0596zdu4vsSkLDeftEYNl5XoweQmDCFALjFhwtr0+vmRaDYnV5LETmxI/mmCJlMtCws+6jvWd3PSCUuyPbS7KabA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021135927099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jAlf717WeyW+QeJmzMeAOPJvzqvySmpma2j2uDS1LvaBhqtORCqmhq6AnJAfK9nwsM3o7wZa8hRKtnHcM9zxDFbZSAcZeB9xf/v8+YrZLzTgXAw8P2rGCjKl4cnTMNZDPkOkDeUgWbCbAM9dnEqUeDwaSDEOffclraFB9ToJHaK1CTCCkN9hvC44AXUhCHtLvNgLBlbvQ7SsGTwDj+qgtEUKpIFdQzOHSxcsYYXLxgxgMEY3LP19UzvTVVM2dShvWhC0s+483tRycmjhLCm0Df4oQx5vPSqLENAmIrhpP8CpZ3UAVUI/K6jWZFdpJYqFjEl7DNcpkAEobDfoD9ZZCIMH9eywQRGwvOCCW2I1ZQ4uiKfmhdSN2D7izU9Bgnb4XCsiUZiKO5JJujk6iLkODskIgXUW+7KCkRc8nCiv9crbcyWEQiQqPEXF85IiXwLP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:18.4685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f0783a-199e-407c-a437-08df4ac158a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why]
The DMUB timer reference clock can differ from the crystal frequency,
so it should be tracked separately from the other reference clocks.

[How]
Add dmub_timer_refclk_khz to resource_pool ref_clocks. DCN3.0, 3.1,
3.2, 3.5, 4.01, 4.2 and 5.0 set it in init_hw from the crystal
frequency, next to xtalin_clock_inKhz, so their behavior does not
change. DCN6.0 sets it to a fixed 100 MHz (DCN60_DMUB_TIMER_REFCLK_KHZ)
in dcn60_resource_construct instead of using the crystal frequency.
Other init paths, such as DCN1.0, DCN2.01, DCN6.0 init_hw and the core
and bls_builder init, are not changed by this patch and leave the field
unset.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c       | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h               | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c    | 4 ++++
 9 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 35d5cce0a791..c4500617dc85 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -686,6 +686,8 @@ void dcn30_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 7acf6af7e472..e90afdd6f1c9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -138,6 +138,8 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b78041ba94e9..945052b1808f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -848,6 +848,8 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 564ffd61f391..d24569870a2d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -171,6 +171,8 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c39189deb244..7b1eca0e2b57 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -178,6 +178,8 @@ void dcn401_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index b1cc09df5e63..62876d489b8e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -103,6 +103,8 @@ void dcn42_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index 151ec838f613..2986eaa73eae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -582,6 +582,8 @@ void dcn50_init_hw(struct dc *dc)
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+		res_pool->ref_clocks.dmub_timer_refclk_khz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
 		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f1b6053fa5c6..09395f5d4e13 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -317,6 +317,7 @@ struct resource_pool {
 		unsigned int xtalin_clock_inKhz;
 		unsigned int dccg_ref_clock_inKhz;
 		unsigned int dchub_ref_clock_inKhz;
+		unsigned int dmub_timer_refclk_khz;
 	} ref_clocks;
 	unsigned int timing_generator_count;
 	unsigned int mpcc_count;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 1d7074451ac1..7fa1bcbd00ef 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -107,6 +107,8 @@ enum dcn60_clk_src_array_id {
 static const uint32_t MCACHE_ID_UNASSIGNED = 0xF;
 static const uint32_t SPLIT_LOCATION_UNDEFINED = 0xFFFF;
 
+#define DCN60_DMUB_TIMER_REFCLK_KHZ 100000
+
 /* DCN */
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
@@ -2010,6 +2012,8 @@ static bool dcn60_resource_construct(
 
 	pool->base.res_cap = &res_cap_dcn6_0;
 
+	pool->base.ref_clocks.dmub_timer_refclk_khz = DCN60_DMUB_TIMER_REFCLK_KHZ;
+
 	/* max number of pipes for ASIC before checking for pipe fuses */
 	num_pipes  = pool->base.res_cap->num_timing_generator;
 	pipe_fuses = read_pipe_fuses(ctx);
-- 
2.43.0

