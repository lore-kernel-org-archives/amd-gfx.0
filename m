Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC9EF31E26
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2616F10E814;
	Thu,  9 Apr 2026 15:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R3NjJ/+1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3010E813
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJT+N1h3oPbN4OST0rl2qIlhBT9erbKyIDoiKFzJknu69ws26ALXld9zitynbz7gMEZsthjBPJac9swEHZ2GdBpryBq4d9I0TtS4Jj/0EO0P8Q+lSO6MCIfMGeQYasY027+MD6wUSu3OcxFQ2ympOPHt3LeO7rUQZ10SDCzmnsqEsdGYE8FSrq+jlqLcWI91/t9B5ugF449GziCHjv8hxxPkjIjSoYELyL2D3eGbTP/PDH9B27SNzL7MkZ3jyoeZwZg+ZVVmncXWQV4+O5OC5LB5ONyObwTKgJBgL4X6LJzf7Ija3Fhl6e80O5t06QwvaAeehUaCPpK1KSJLrvyd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8zImkhKg05+X3IYgi8f9y+PWGVnR6rK1ZMsPyxzKkI=;
 b=iKSgjMHAgXNoki52uZ5dQVVIN8D0BEsZGJstVS5koV9iep65Bys5VzFj6t6/DM0Gtr/6Rh44PpNL0Ts29lRTP7jOpV2nr5xlOMsjUZqVK1xPv6aCbPB8hcD2kxmmbAmPE3pbylRtqU0ZtJksch0AkCbNyyr5U5rkwEadJL7eY9AZfKr44v0HN39sZpypm2R7YJqoYPUqWuLvrEQtF60Ht2t2t0sSOIYehb/K8L9vsTf8SHDfoZwOo2aLjzhzny6VnD0qSmhKPG0Ux9QZtQ4ytFR/31FHc6PGs8MGeNIQgdbmZelRIxZXEOmTf6KX8Z2DVGOQgPHu0Ape9yGrkUifAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8zImkhKg05+X3IYgi8f9y+PWGVnR6rK1ZMsPyxzKkI=;
 b=R3NjJ/+19KWYYUZ+CshVrP3ypfXgUZpS/Qm2thLKWaZU+1Di2/O9WxkpdzyeD3eXy1OEw+sTR9FPxR3sWETUEmuoEkYfuo+MLAgRFIt11XICuRjhk/pfeSGunYByGfEJqjQvgalxit/rKpcng2t11SJJTkuHAKgFS+HkfP6olNA=
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 15:04:20 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::63) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 15:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:04:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 10:04:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 10:04:14 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 9 Apr 2026 10:04:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Gaghik
 Khachatrian" <gaghik.khachatrian@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 1/6] drm/amd/display: Fix compiler warnings
Date: Thu, 9 Apr 2026 11:03:09 -0400
Message-ID: <20260409150413.34779-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 12089279-36d2-4c1f-dce7-08de96494727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: EWS6b+4CGvnuFF3wO1uLoVk/yHsPzYTgQ/bihg/ybBp9vAyJSRlbALwGRfAg3HxXxMIGRpw4PEurw8xqnEkNbI+F5tQnh8yIn2WVNWKs9Kxyo7u8SILdhe4Uqa0eBcJUj1Ueoo/4TZ1BCXPrrf2W1eWJ455kQq+/bg9fpI77XICJiooOMNMEM/IpokYQAy1r4MgQ+K0wtCWoKUWuZ/C1OCPt+94cQUgJ6SBmnxGY7H+hSXU7m35QOFhRDZFacGSAF8YBSc5gvOahCTrQg4GJa2WT25hOmEGOjpQX/IbWVSwrH0cGv8aAseiaD6QMAGzkcwgUGQS3roHSL/RDRQ2PagjAjRbEN+5GyMpugi3g4NoJXzA+Wd6byUybi+0VMccE7K4WdBlRQ7IwDR+sAMdFMVJ7b5T7Np5ZBD6ejYbLnyfJHN4SvpFFtB53ccXceBwHDZ6hZqtkh26QroRYIK0GqL6NrvB8JWQNfRO4q52Jt6Eu4Q69AwF3NSe7z6EYu4p8JdNqTh2UFnLsuK/hQtJIANV4uQtxup5dU1qLk7IHaWA6NvNAYFE8l+jwVJBEd+gfsUm5N/HQTzKcQHYwUMoQB/NdrSXfGjt+hpBKqQgJW33bls8zPwDbgfq1jmP8xf1CJKaGTG7UrjymEKAWlD4pCyfCv11l/Ye6hSWu+uStp0605gPtnPNR2YWEJQmY5/F4I4+LKP1qnbsRNKTpc6vpj1UYzzlVPQN1CPentZxKaQN+CrttMD/LLJr52K1DNdZ+CvbJZUgrX5au5FyMUiFFnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: toFucgSBAObHDvqiqkE2d/woUS4QrGuz4OWFQAEqZmloCVmjb71ZvcnRX5b0yGoueMN/hR2AQ/eEGDBWCU88hQ4R4TgkDxB88Gphhr+5QpJjYYD8uKr7VKthsOzWH3zi9ZNeldBd1oGRkehQtMdgM5G1O++j/egjoFQQur/sZVlCLkq3SMQsBG+15uyc5Us8R9Hwv0uela4yeAx5VWxEJ8c5SrsHwzwgPDDWWm/8KgC+smD+bXGALx5weUMpJ604rp/svfwi9H/17wmvsudJPPvNjfjCW+xifxpThA2gWMpqIyt1FxAhpcB+vIgGwvrIkfJV5ChskSdkzSzRJRh7gXqNUGgmZhW7K+D2Fn1KOxWdopg4g0Su9KRNNaWgRtqdYzk+8sflIDL6LbtkYjuSIY8n1gaM/a2cvz0x1etEIJw0qMI62gJqNovzd+0ebXmx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:04:20.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12089279-36d2-4c1f-dce7-08de96494727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why] Implicit conversions from wider integer types to byte-sized fields
were generating compiler warnings. These warnings hide intentional protocol
/storage boundaries and reduce signal quality during builds. Making
conversion intent explicit improves readability and warning hygiene
without changing behavior.

[How] Added explicit, type-safe  casts at intentional narrow-storage
boundaries. Kept data models & runtime logic unchanged, only clarifying
conversion intent.

Functionality and behavior is unchanged; only type intent is explicit.
Aligned warning cleanup with existing coding standards for explicit
boundary conversions.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h        | 8 +++++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_types.h  | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5267f1a9473b..c94e532ac4a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1061,9 +1061,11 @@ struct dc_debug_options {
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
 	uint32_t edid_read_retry_times;
-	unsigned int force_odm_combine; //bit vector based on otg inst
-	unsigned int seamless_boot_odm_combine;
-	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
+
+	uint8_t force_odm_combine; //bit vector based on otg inst
+	uint8_t seamless_boot_odm_combine;
+	uint8_t force_odm_combine_4to1; //bit vector based on otg inst
+
 	int minimum_z8_residency_time;
 	int minimum_z10_residency_time;
 	bool disable_z9_mpc;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 86394203cee7..7c38fa6f8cb1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -162,13 +162,13 @@ struct test_pattern {
 #define SUBVP_DRR_MARGIN_US 100 // 100us for DRR margin (SubVP + DRR)
 
 struct dc_stream_debug_options {
-	char force_odm_combine_segments;
+	uint8_t force_odm_combine_segments;
 	/*
 	 * When force_odm_combine_segments is non zero, allow dc to
 	 * temporarily transition to ODM bypass when minimal transition state
 	 * is required to prevent visual glitches showing on the screen
 	 */
-	char allow_transition_for_forced_odm;
+	uint8_t allow_transition_for_forced_odm;
 };
 
 #define LUMINANCE_DATA_TABLE_SIZE 10
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 7672ee88be82..c08d5c005df6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -205,7 +205,7 @@ struct dc_edid_caps {
 	uint32_t audio_latency;
 	uint32_t video_latency;
 
-	unsigned int freesync_vcp_code;
+	unsigned char freesync_vcp_code;
 
 	uint8_t qs_bit;
 	uint8_t qy_bit;
-- 
2.53.0

