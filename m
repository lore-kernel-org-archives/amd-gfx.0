Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5108CC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A5010ECAB;
	Tue, 11 Aug 2026 15:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HvF2/4Hb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59FD10ECAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPTz61BNKfNn94aJEmtmzgZnp1sHChqwIPWpIlF0NxAG3WxWTGbS1RJU+l8jzeisKzYlSX+M8bJH5rJFPFNaNee1EYSTTukr6Gh1k8gALY3h8FdPL+xiHchi95sjf4iWpwEM1nn6pcDcvalGPyBPki0JcnhVrdgDe5Rez2lM8FaUuIsqIfcDCtJJYVMLO9fr1acgSLvfuUezzAA8xX2lvK1EiN/6bGZ8I/bop/4mjo8vTudyqqToGiXHhGDoanTm7M/m5QUvKKeqlIAjACAQ3czLFPbNpQWdX270ltan5hAE6sk22h/A9Yn8z+dKDAjTHUZL4uZzoOtTuLj8/z6UcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brAXYnqCzEg7OeSN8IBcBQWzMKZZx8dlYIJN3DrNwwg=;
 b=oVb7a7p1ihmwjiBC3OChKiOC1VwnGNbcmYw4vKvPrdhu5aYJXGmUScb7OxL3kgTL7dN4H5UpstGfoJVPKeNakk31GVZWURrkAMAz9FIG2wQRfvk7nWbfIJsB3KvHm5vbmglpb+Px12fFKV6EHOyD7Mt8nXdo+4zKL4vpA0MkjGrbJJLUNja6IR5VL//g7fMOzQuhrVPFBZZJc2+NqQmyzsI4WFVYdxID0r6oVIkUbHZILXUIYhEZPM2DiPBB60fhWuIDqz6k2MOPukjnkYA/rCBrO2rQatPhawS8P91pRuX+cdgDjJSwbcvsSooQXwJwHIlgtbNwMKT04TQ3on2UWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brAXYnqCzEg7OeSN8IBcBQWzMKZZx8dlYIJN3DrNwwg=;
 b=HvF2/4Hbzsf9Jh/K/HeJBPWNdE5L7KF3bqvyy1SI0IvoxQfJRkPdZ2xf+090p8FTNELQm2QcEScvNQgCw0pLV2a+ZrJGJ4RmA+qwpnQHZ213hdUUu9tujKeFOVCE1iFxAuudR9J4uI/mxAE52TmH2uTNKsxh9A89BgV2fmBh4zI=
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:51:14 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::aa) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 15:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:12 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:51:04 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <dillon.varone@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Relax frame size limit for dcn5/6 DML
 core funcs files
Date: Tue, 11 Aug 2026 05:28:54 +0800
Message-ID: <20260810213010.1703162-21-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a9f2df-8512-4cf5-26dd-08def7c05f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: d7bHp93wLswPUHPSfMsQATdSgazWEjw/8ewdWc0xOmJ7gGOnOs/Dx4ThrE5tnnP43PgcdZYdE7tvai+DSWicldbCalfOEaKyJGFJhX6h/ecbuusHOMrgG0NsMWU0p5k78dGThzteeS6aMIY1I+5uV16GkgSaDjaEsAifitgByNaWdDtjb870Vl5H93PZdVzAq+CBs58OeDxR8Q8oQJ+5SCJ/2NLESOellW++kmKbhY2U4yCIhOjxqNjDhy42wsolNjtMhsHPO7Zefb0vr2k8oVHD6q1zr+ZBI+KS1kQU9vuBF7TdtYcvDZBzzFlLkeU/UGl08clKhhfWOnoB826rlHZGIST9mmbgpb2ipfKFPmmG8S+2FGqgmBVeOJO+0BT/qNq2pa8ge96OwiAqt7kkBi9bnmENZiiQFpPI9EO+D2yvYaUU8ZiIQjxrKdXS6YXhshKPqRDNZIrBORw0GW4FvKTgQ26vKll3F7ohlHPNCETzjRCO2zN4ACESrm/1sURj/4YsUMwDaJETCKDc6w+HOCKyGZ2gksYIsgijOJbI/e4rLs4iFHbY3BMvGQsuQbpTIWcftuzyugIXruqJtkVZpE3gWCFIRdU88bPbis2TCuQJD9Fr4sxMb0QdblhBp8kIrWuZo7vbJGLuaQp2+crU6tM/u5uKgt2cS2tOgdVBnvCSWJOP+mn+1Rk401me/pq66ENDC05Hv83v1SJN7hV2jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JBJTj1uewZ7WylXEshp15TgELNVdy83oCIXUW2py/hZSQPFEQRJzGYT377IQzUdOtg6RdmWrt0C7nozY+tqJtUF5VPWLREh8T5ETmKsZGxw/Wbrj729w/5I2pTJGMpSmXfzPteAqO5WLhckk9J9sFyh7zYYOaAthRkV1SoCNjLyZ8tHNHEy4JvUQCuzpdDxSunqZkovvWNNBdtpPtVtCg/ai5YHIDhHQ3j2C98HlYwgYYfsKncnTEMMoRoqpkIJjOsmubOOsDMv2lpoZo17ElQHv2o9U+3h85GpUj2U0nSxfPQolqTy9aZotmJOcBgOB+pOU3t0hbc63y4yht3h+W9WeZs+jEHxsy37I9Jjud+4Ud8hfwuKoZT4d/egmkpMQMPknwBYw3X+xj2wZKPBkicdePpqeKFIemkFWkc1cuAyvNYIg3EgJiVz5vhdqlR60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:13.6710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a9f2df-8512-4cf5-26dd-08def7c05f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
During compilation with  allmodconfig with KASAN, there appears a Werror:

  dml2_core_dcn5_funcs_mode_programming.c:11:13: error: stack frame size
  (2400) exceeds limit (2048) in 'dcn5_mode_programming'
  [-Werror,-Wframe-larger-than]

The dcn5/dcn6 dml2_core_*_funcs_mode_{programming,support} files were
split out of dml2_core_dcn4_calcs.o, which carries a relaxed
-Wframe-larger-than limit via $(frame_warn_flag) (2056 normally, or
4096 for clang + KASAN/KCSAN + COMPILE_TEST). The split-out files were
never added to the per-file CFLAGS override list, so they inherited the
strict global default of 2048. This is why these files trip the frame
size warning under KASAN while the larger dml2_core_dcn4_calcs.o does
not.

[How]
Apply the same $(frame_warn_flag) and CFLAGS_REMOVE handling used for
dml2_core_dcn4_calcs.o to the split-out files:
 - dml2_core_dcn5_funcs_mode_programming.o
 - dml2_core_dcn5_funcs_mode_support.o
 - dml2_core_dcn6_funcs_mode_programming.o
 - dml2_core_dcn6_funcs_mode_support.o

Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 35d697872a9a..5388bf094fbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -75,11 +75,19 @@ $(foreach obj,$(DML2_RELATIVE_O_FILES),$(eval CFLAGS_REMOVE_$(AMDDALPATH)/$(obj)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_rcflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/display_mode_core.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o := $(dml2_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
 
-- 
2.43.0

