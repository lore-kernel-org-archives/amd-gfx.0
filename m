Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85246CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B9C10ECE9;
	Wed,  6 May 2026 07:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="js9VGYUE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0852210ECE9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ6jmh1n8BruOb7wd/yieDC2/M54VX/PgkJKUvrcD71vXqoxgXth2HCZIXKnJTeNUY4hEGeIJy/b7UC7HpiGebH9Ch1LdVPFjltzi1lUUn1XRcDQsyS5Y4rCOgcVkfHp6D6Uo80fzA/7o1ZHX9WiUBZW9hYrNz2whgc+Y1c6wT2YF1aEbV0uY6ZviZwid+1RLN16yL/uWPt4MP9mRvNZnpDZypdha+dJqAGmPOaVKsnEy/GX3xNxMdxRLFX08cQ63P0AFeD7hUFV3fhVftbxoYKhnNniWjONXGsk0RHocE+HRwacz53FRjGA0ISB0vut8Y/apYjjLFN3koeiZLGyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eEAVdR+yqyiFT0yjedf8uluSTHhh+fV2Kz0Pu+tTHA=;
 b=JnpWZapFDvdehjggFTX8D/88NztNxLsrHPxlr6lZbdJbVoHvDho7/MjqCaIBM0A/DzfsKxVSuuL5jlivs6eg1MSowL6xINypkON6LV5ykjubb4Mx/IomCzzSBR+Ai//YStjlO6DBlVTHgTD3CUSa5dV53voK6VpJXd9AuCA+PNRWhucwQmNv8RGOi+QquaN9Ux9wv5Zsh/GrqrW0vhGL1fvAb/NxXC00qQg48DZIhOEoaV2cqK+nwtPKFrtdu5G+fr8F2qdoXZUSgZ2CQX3auIc4YeJh6YF5xuQkIjkwk9mL8p5FbgsnPEUdPlUazYnTJ/48v5PPfBjfzQSrpFo22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eEAVdR+yqyiFT0yjedf8uluSTHhh+fV2Kz0Pu+tTHA=;
 b=js9VGYUEjRI9cXFfW88QLjVeY7NP6K9AcLPTzapHe9ndmTD1K3mnIRCMbkRNYC9uIVj7dxLO027MELTuyNf5yMGWWbW95UOQKW9NuNwmT1yoA//8UMUsYVMlSAwaYEAkH+Vid+tCxUkfyPV7JAQ3Ar7nvUDvYGUggOr67gRbwl8=
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:06:12 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::89) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:06:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:06:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:06:08 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:59 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 19/20] drm/amd/display: [FW Promotion] Release 0.1.59.0
Date: Wed, 6 May 2026 12:31:17 +0800
Message-ID: <20260506043342.2164710-20-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4c02c9-8486-49dd-00d2-08deab3df4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RWB42/QyKFW9xXhDHNFOOwhep4iIkkYE0rLTHfryRfbmYVQ8ZJKKbGFL8X9boqsVzTZnWBO4pdwLrpeV9ZfBoDYrKkxgYGeppX+XzWoLF3jvHZhyPcWEf/hEQalE1vq0ERs9WOwjf7ejvmFXNOGwd/sO7q9/MzgWiY4zDJO1oPFLRG2cEZfvrYbAfNBtujxR9tSQ5gsDPVtC2Wsgl9b73XeO0DXuwy8c2GB3o4qV7L5Qa51iYhVTp8vrpxuUjrcJEHx0bfgNUZD7D8p8TEPohLmQrcXKU/tyWxWJvgYvTh9JraN4M/KUD0ivxd1LORpPbB97i9En006O4yFiucvQv5wFhKxFEIlhcjDT4jCXDeSDIgMqkRdw55gf+NmfITX7EmvcoC/pBcyekXhMl8HqRRkRvs0NV90ypb5dB8j2RxDsYJvFslJwMjvS3aY/tIPy1W04moeAmLvk/ZsLiNYGT72EWi+u3xvYj3ZFDmwlA8UV+U5XdgInNcVMiNGN4JKh7PKa4N4Ju28hToLSPss53F5Q0F05neQDf9Lgfr8BkT8pr13BBzzZ5Qc1umHaEa6qzO7mu3BbtBjv/sfqP8/9nSyUL5KwMSPZkzM3tiE8K5dZz2TswxRgriZiWOxSd9IAb7UzbJ4RBek/tdzfGSUtcyEpVlC2eUK7pgAVlc/OBCJgAKrVm+/NtNhzxzyf7y+KrSKX6M3RNWQYFBdyYAayVSPy4/DgZCJwxBRKVlmJC4E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XY8OSCl+WllJpD2IUB8LQMqwTHIVJquRGTu/Dk9Z7oo/G2+6RZiXbYBg/Dd4fIrdwNWuPFWnOO3bRPhgHD2rFp/3zIyB494yGuwFJOEOetFegeIhAm8FoXwsFSI0q5UjdUlPpcaVstmluOk30E0kxWMdhAT4KtvZhXYvnmzlGnbhgyLU+RCfFiiBc1vdCZ7Sg4xf4DemFJJGhC5vy6tmXqwUJhYtjqyACC8cYI7pUWuahaLoOgR1LJXccMmmDva4fmF4ePoGNEaZEsYT0RW7J4On1kOaTbtrik41Dqkbqp20u5DVkrKjK0bcsWe8OcR2qQPiUKuP/HHE7vM0tXbOppUQsXxcvuxKWknH1Bc4BKhqe1tX7qC4f45eleRdP0/gmtqgfCXZncNiWAx8ATF1fUisF3RGQYrLU6XJ9qzH0Jt2u+FIirfi/pEXkxUVC9Sr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:06:12.4550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4c02c9-8486-49dd-00d2-08deab3df4ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Update DMUB related command structure.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 32 +++++++++++--------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 300bbfe3c98d..c1becd664cb9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2378,24 +2378,24 @@ struct dmub_cmd_lsdma_data {
 			uint32_t dst_mip_max      : 5;
 			uint32_t dst_swizzle_mode : 5;
 			uint32_t dst_mip_id       : 5;
-			uint32_t tmz              : 1;
 			uint32_t dcc              : 1;
+			uint32_t padding1         : 1;
 
 			uint32_t data_format      : 6;
-			uint32_t padding1         : 4;
+			uint32_t tmz              : 4;
 			uint32_t dst_element_size : 3;
 			uint32_t num_type         : 3;
 			uint32_t src_element_size : 3;
 			uint32_t write_compress   : 2;
-			uint32_t cache_policy_dst : 2;
-			uint32_t cache_policy_src : 2;
+			uint32_t cache_policy_dst : 3;
+			uint32_t cache_policy_src : 3;
 			uint32_t read_compress    : 2;
-			uint32_t src_dim          : 2;
-			uint32_t dst_dim          : 2;
+			uint32_t max_com          : 2;
 			uint32_t max_uncom        : 1;
 
-			uint32_t max_com          : 2;
-			uint32_t padding          : 30;
+			uint32_t dst_dim          : 2;
+			uint32_t src_dim          : 2;
+			uint32_t padding          : 28;
 		} tiled_copy_data;
 		struct lsdma_linear_copy_data {
 			uint32_t src_lo;
@@ -2405,11 +2405,13 @@ struct dmub_cmd_lsdma_data {
 			uint32_t dst_hi;
 
 			uint32_t count            : 30;
-			uint32_t cache_policy_dst : 2;
+			uint32_t pad0             : 2;
 
-			uint32_t tmz              : 1;
-			uint32_t cache_policy_src : 2;
-			uint32_t padding          : 29;
+			uint32_t tmz              : 4;
+			uint32_t cache_policy_src : 3;
+			uint32_t cache_policy_dst : 3;
+			uint32_t pad1             : 22;
+			// DCC fields not included because linear mode on display does not support DCC
 		} linear_copy_data;
 		struct lsdma_linear_sub_window_copy_data {
 			uint32_t src_lo;
@@ -2433,11 +2435,13 @@ struct dmub_cmd_lsdma_data {
 			uint32_t src_slice_pitch;
 			uint32_t dst_slice_pitch;
 
-			uint32_t tmz              : 1;
+			uint32_t tmz              : 4;
 			uint32_t element_size     : 3;
 			uint32_t src_cache_policy : 3;
 			uint32_t dst_cache_policy : 3;
-			uint32_t reserved0        : 22;
+			uint32_t reserved0        : 19;
+			// Linear mode on display does not support compression so DCC related fields are not included.
+			// The DCC fields in the command packet will be zero'd at the time of constructing the packet.
 		} linear_sub_window_copy_data;
 		struct lsdma_reg_write_data {
 			uint32_t reg_addr;
-- 
2.43.0

