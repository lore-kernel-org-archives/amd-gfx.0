Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A61606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5WN6UC/l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3752A10F83F;
	Wed, 25 Nov 2026 06:59:55 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D94810F974
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrhE05gsQQp1jraVdCo/dYTaJd7vScTzh/lekC5IS12Jj7VZJTTfQLHwFwbvXztRHASpLP+G8jvQPTacueT40a/pEbvZwiBlnGCglW6SFdTelrOZ9qYL2r2cqSA56xHFu33DCGz8OFIXJGOdxM4TYpJ4uw+js4mD1MsQQJ6AZUpe3coAMlTjPgSNjFjVvyt5yDEvDKoyqFu8mt4+GYfV7AL5hARk7cbuQJ68FB/khlv0L0kgz3V7NyWcda1SZZ3WVh+IKeKoac5DAY85vc4z3clndiepaItpd+gV/4jhh9XoYjMwMCpw10a49K6x3EzoZn2t7ujONJIH/CrlHKqIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk65Q3zem55/ggH+qPVFVrv5q3xDrF0ltiHfKsRcQow=;
 b=xwW/UotA6gdIRzHBOCgTjUgfWplhuBe/SKC/AaH4Kw+DFEYLniOVQ7On4xVspq3Ag//z8uhdKriVY4Avg6Q5GJz/VgkpkWi4zNdWY0iczV3FOTb+5gPm2EOHIryyWUwNqJiOd1ZbLj/i4LjrYEfRSxpy/chlHUyWnbILwaFM1In0xWBJc9nkZbyGbquwd0H/UPXGgCmTS8aDWN4SERSYiJbHTIgaet2wS5YKY2UywIgYnGDQDNv+qy/k3xAdFH1feuxLGBRW9zWwb+VKys5zLrDDM7GgDXXBUMnZKWhkR6uOd0w3m2FwxHM7bMQew54S0fIhL4k1TF08XasH+WbhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk65Q3zem55/ggH+qPVFVrv5q3xDrF0ltiHfKsRcQow=;
 b=5WN6UC/ljpEsQPqCJ0jkcCIJSbyhD5M+0eSgh0k6yi05+MLnHL7Trnk4hcClNoTv77FNsfItR1BGFWz8emY9x2Pekl3EEQ+W1AdECTgM6s4mKIgSHoaQJ/vKGe8NwbDHoFtis+XUjkZXxdpYVLX6ilqaLtVkyWmxyU4YEUF7XWc=
Received: from SJ0PR13CA0113.namprd13.prod.outlook.com (2603:10b6:a03:2c5::28)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 25 Nov
 2026 06:59:20 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::53) by SJ0PR13CA0113.outlook.office365.com
 (2603:10b6:a03:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Wed, 25
 Nov 2026 06:59:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:59:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:59:19 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:59:19 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:59:11 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 27/27] drm/amd/display: Promote DC to 3.2.409
Date: Wed, 25 Nov 2026 14:55:16 +0800
Message-ID: <20261125065631.3889665-28-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f32dc2-f870-42a4-9078-08df4ac1a11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|3023799007|261022105027099003|56012099006|261021123027099003|261028144727099003|11063799006|261102123227099003|10067099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 893XP+nhYBeXr637haIpzj3BX4N8ZXhx/Ldb0A4fHKHAA08bkKf5UvaLvFlSaWAEGWSZJ379TwmkQ/Dj0xc2jQGPAtRA0tdHf7b10nfsIK+Z+F/LWFrm9AnJ1C2SubcV3o+lMYq35rGf55kRXE6wHCNRLPbqL43sFiB6KZnrCorS1yVXm7DujXH76Q4kgW72zSjQs5zAH9D3MHY016VVSvPxBnDVgPJWg3TL3zGDRLQyhyh/50BKg3b7YlfCzOn8jSza6K5GF+3pGO3SvNlJbXODNmGEaopFRpx5d3amD12r7I96p487sEU4rcttfJzkIrtbky3new1o3/DaB20HYj1H0FM0qctZaLUtHriJ7WKKsuYERiuQc7WKVb9ra+ljkQTThC/3/eZQ4wBKinJNPzpNyNYf3qJedPqWzJTIwTMDvVv3OpEbpkjiWytn2ad/CRHBvvrWIYYKxP47hr0D6hABiMiV7XZP9d+ENDYPJpT4tnOgS8MHntykwvH404tqusEeCLuPjhBc9WMXirZ6tBIllGb+o5ZSG20GQPlVLnh8CfnbQqEYHFHk0jresyzfr/d0CFI8nkmsN87PUC1g0mNI592UBgt9gqZelArV7EskMskMNfskxSi/ZeUR6HtC0mTInbtCZdEKl36ZRkPebS+t5iF8AMAGUHeDmoFXFxqxK9ERqX+UcZ3XKwQt0gsGfQsemrnvOrG0nkdPzFy1zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(261022105027099003)(56012099006)(261021123027099003)(261028144727099003)(11063799006)(261102123227099003)(10067099003)(261009223027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z8j1WRHI6MasX6pux7Hva7clXQL8ZPdtF8iydDXTvKl9oebYTkVMkqAIIfZ1x01ynRsh1b3RnvuOmlKZu98xRY8MuRR4TKr4f7oR5QBfDuj8WsvCj7j5vIu7T5HqQHxV6ooMbnOMvbjaatmb/Rms6ymOOMw3YQVuUyekJxeBiQ1GJFkERSdDzPLreY3XiyxFXIiGeH0p58uvjP2IG8EevD7JkDCznmc0CjiO3vipip0p2K2xUw2CBRp3U+dfUldUWdUWtTGQzdhW4F6z/8jWhWfzYavXrqOHpe1ikDlaXML3Co1AQmSaTqetHkOF4NtnAWkjjQBOcIbI/0YgHQlGVsKFb+DZ+RvOdizyn4nXIPD7+0QX9QNR87na1SwdVM9JtKJ8DO+s72mNpe5MeZvuSqWzmtnrCB4/j5n0RvcryGzSuqzV6O263xaBjFJBLKwr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:59:20.1016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f32dc2-f870-42a4-9078-08df4ac1a11c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
- Avoid per-entry long division in __drm_lut32_to_dc_gamma
- Add more diagnostic logging, a debug option to force the DP link rate
  and per-CRTC pstate method in connector debugfs
- Reject Replay activation on an inactive link
- Decouple PROGRAM_CURSOR_UPDATE_NOW from dc and pipe_ctx
- Add DPMS-v2 init and tx init, and implement link_set_dpms_off_v2
- Derive DCN6 DSCCLK range from DISPCLK
- Carry stream and plane update bits in update_flags and add vsync and
  immediate flips to the DC2 seamless update
- Preserve bandwidth floors in overrides
- Set HDMI bypass earlier
- Add DMUB timer reference clock to ref_clocks
- Guard connector I2C transfer without DDC pin
- Refactor ABM_SET_PIPE and ABM_SET_IMMEDIATE_DISABLE
- Add amdgpu_dm_dmub tests for alt-ch apertures, SET_CONFIG sync wait,
  AUX transfer timeout and fused IO replies
- Use Z8 enter plus exit for vblank reserve
- Fix two streams sharing one OTG
- Count planes, not pipes, in the surface check
- Promote DMUB firmware to release 0.1.86.0

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 69d6eed1df41..14703c0e0224 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -69,7 +69,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.408"
+#define DC_VER "3.2.409"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

