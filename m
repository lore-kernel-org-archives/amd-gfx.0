Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89470CDE000
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A3910F09D;
	Wed, 24 Jun 2026 18:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="suuK3q/c";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF29710F096
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMvFynowd8Lg/d2S+2VyHdPKfRsbRltgf2PEn8H+OZIzqQ3KNM9Wg5oz3Vhfe+ZEuo/TMQkoaiBPev8OKhEvuF+lLGE94lQdo24JpTS1rs8cwUnrzd5/zr3yTCnmConTBkjIJ4g8ThVJMXawG0KMlyNCg+pLOKnhypC4u0S9dFAD6UaQU+sXGaOKWIU7Gvw9AY2hr952mTRYQNirCOOGL8FkdHxUAS21aKG9tK1g9n03aEBVrpbi5LKuwD14lLDvV4ZYDXzgbfrHs6QLkU8zLhzoWlBo4ojuVofezCwX6Yye9QKDFXAL7xvasd8kPSbS9cxBV/8BRCAS7cmG8mK07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHm594ftWxKNU6aqB0dSLqPBUmRlHg5xUfNmHhSKzc4=;
 b=SnJK9w7BKkmSrT5oe955+PK/eR9nDYYuyveFzPV8UPmQqrXD4SlfId4YeWSBi6CWscNrrOB7M6QHZ/6za5Agas/mWOMEv9KhPF8YnDFVJKbwEosHYj2FERr57KBkqhLcxJtzQ9nH9lvAF3U/fzwW2dPQPBAYQq375WLZYZuk4VnDkItR6HZPmRudcFyvysMbKj8/HF00Rs3lZVD0SQ7Avx53o4MBYL9Mc0vL0TGhZmmKmsnvvuWXh4kZQIyB6kVaaIq+gbTGKmzJFicQl3M9I464R1pXUTB8vxr5o2CazoQJO6qRqwoEnLJrplaMDJ/fY52lgMP3xwoRlLzfPlCUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHm594ftWxKNU6aqB0dSLqPBUmRlHg5xUfNmHhSKzc4=;
 b=suuK3q/cSCzeM1gbFEbEJ0eV9bR0e0KrlPLCJKFvqSwbaQVoHUnJuL6C0uFUDfu7cb2Sice6ZaaoVwLRl9RwwAUnFu7FNf3ttFaFTWrF0bU/OuvfyVWRp5QuXtPfEL/rkJL66xRVZ01C45FByEA58WHVv9QcNV1eUF0gHwD4YKQ=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:41 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::a5) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:40 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:30 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 19/28] drm/amd/display: Add KUnit tests for amdgpu_dm_psr
Date: Wed, 24 Jun 2026 14:03:17 -0400
Message-ID: <20260624180829.4775-20-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: e22e8586-6284-4396-4800-08ded21bc2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: dGtEIALSdK+eXbSBlejv2hm8wPyWWiUD57U7ud7cHPrPcfFyEPjWHPWsWDbkySIN98nwt+/rjahAw11nZ+rtNvI7kXi8WVyitlCJcAvcosPK1WEu0Kd4UVfA1Jp4fB0EiI0xmMOvgTTii7Cs1O5PuRDYAeCBk7Op5OgpKmCH6+OrRixuCkn0PX/gOG9W5cYVvIfQAoLH37Ttyfz0/cX8E1T3iagzsSlRAiaifGWDii+Wv/1SX5q9D3PWbW43PKaIjxKHeNQBGx4IBTlnLPqjGochHRgocmzrM/OLe0I8pUhYAhH6DXyTNPgWH6u+MrGSfN/gzx0UNOviBvSsBw1F4v1Wwqy+scQcvwQRNDLs4pUXB48SgvwsnSMk4mWYNHSyvKhPG9ScrsdVpbEugXmZExbEeSaLsGXoodXauSq2zV7q98tr7VDUdJDZ0VeBFX/wlw4H16x07m5Iu1wH4SJgmllPhynNHVIKJDM1KDpG7qSNdQi37sugTICby5pyiLxLNfS9ssEZ/nN/zYad+aLLpuJR3YkaRyolien8vdZe2MfD5u+ZBpul9eikcgDFhG6QcITAaGtix9EUCekn/xcAyiJIr+K1Kw5KAVigscnusErUBTggNNHVnPuqzA/2SCRQ1UasnSHYclbwMLCpuayQ/4DCE9aA0q9OnkqHrzpeQKYlhuyh/4uaLH6pk6Iomi43JDpD/1CMYZkaF5QpP02s6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zXaY6CoG0LyPukgg65bbZeq5rg82SXp574xqTMPxGG97CAK1sk1qof4iq9Y2n1bLFju7XSggWe4sAuXRZVUoRF9PQVUMPBR3/Vd4WzIqUwTPUOLQyWH8YtrXIZ2oHT2QY6YAfKIpVdBcpZYa1E/KCy17FyoCl3jv8OEqIhqxh3FLlu0QVfA3DTXvsun78sVCCeuJex/xkdqFxcXyBAi0MiAcf7H2g4vUPC/Lw2+MdDEsYfBpzBS6tNMiGwOUzOjQmD4EqgH7nw10GFBVTdVQPax6rAtYwRXk6+YUJHsDHIp9Hp/iAREsRcqilyh7UIEVh+a6reyM2Ofae83VdxZe1QM48VeErU4xYmIU0Y9mLUABd5ndt4idOJnY886gmKsOvIw86x8CgvBU27BsJv1B+h9uF2i+Jlu/o5dsTo987s4/sgzEyMP25hgmyqL/4V4m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:40.5546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e8586-6284-4396-4800-08ded21bc2c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add Kunit tests for functions:
- link_supports_psrsu()
- amdgpu_dm_psr_fill_caps()
- amdgpu_dm_set_psr_caps()
- amdgpu_dm_psr_is_active_allowed()
- amdgpu_dm_psr_set_event()

Assisted-by: Copilot:GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  51 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   5 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 538 ++++++++++++++++++
 3 files changed, 592 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 0dadc0bb214f..f87de3d18ac0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -32,8 +32,8 @@
 #include "modules/power/power_helpers.h"
 #include "amdgpu_dm_kunit_helpers.h"
 
-
-static bool link_supports_psrsu(struct dc_link *link)
+STATIC_IFN_KUNIT
+bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
 
@@ -60,6 +60,7 @@ static bool link_supports_psrsu(struct dc_link *link)
 	/* Temporarily disable PSR-SU to avoid glitches */
 	return false;
 }
+EXPORT_IF_KUNIT(link_supports_psrsu);
 
 STATIC_IFN_KUNIT
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
@@ -134,6 +135,7 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
 	amdgpu_dm_psr_fill_caps(link, &aconnector->psr_caps);
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_psr_caps);
 
 /*
  * amdgpu_dm_psr_is_active_allowed() - check if psr is allowed on any stream
@@ -157,6 +159,7 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 	}
 	return false;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_psr_is_active_allowed);
 
 /*
  * amdgpu_dm_psr_set_event() - set or clear PSR event for stream
@@ -190,3 +193,47 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream
 				       set_event, event, wait_for_disable);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_psr_set_event);
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+/**
+ * amdgpu_dm_psr_get_dc_feature_mask() - Get DC feature mask for KUnit tests.
+ *
+ * Return: Current value of amdgpu_dc_feature_mask.
+ */
+unsigned int amdgpu_dm_psr_get_dc_feature_mask(void)
+{
+	return amdgpu_dc_feature_mask;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_psr_get_dc_feature_mask);
+
+/**
+ * amdgpu_dm_psr_set_dc_feature_mask() - Set DC feature mask for KUnit tests.
+ * @feature_mask: DC feature mask to set while testing amdgpu_dm_psr_fill_caps().
+ */
+void amdgpu_dm_psr_set_dc_feature_mask(unsigned int feature_mask)
+{
+	amdgpu_dc_feature_mask = feature_mask;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_psr_set_dc_feature_mask);
+
+/**
+ * amdgpu_dm_psr_get_dc_debug_mask() - Get DC debug mask for KUnit tests.
+ *
+ * Return: Current value of amdgpu_dc_debug_mask.
+ */
+unsigned int amdgpu_dm_psr_get_dc_debug_mask(void)
+{
+	return amdgpu_dc_debug_mask;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_psr_get_dc_debug_mask);
+
+/**
+ * amdgpu_dm_psr_set_dc_debug_mask() - Set DC debug mask for KUnit tests.
+ * @debug_mask: DC debug mask to set while testing link_supports_psrsu().
+ */
+void amdgpu_dm_psr_set_dc_debug_mask(unsigned int debug_mask)
+{
+	amdgpu_dc_debug_mask = debug_mask;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_psr_set_dc_debug_mask);
+#endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 40a09b5dc606..e442e7ed82ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -43,7 +43,12 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm,
 		bool wait_for_disable);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+bool link_supports_psrsu(struct dc_link *link);
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps);
+unsigned int amdgpu_dm_psr_get_dc_feature_mask(void);
+void amdgpu_dm_psr_set_dc_feature_mask(unsigned int feature_mask);
+unsigned int amdgpu_dm_psr_get_dc_debug_mask(void);
+void amdgpu_dm_psr_set_dc_debug_mask(unsigned int debug_mask);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 09084f70a405..2dd870f650db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -7,7 +7,12 @@
 
 #include <kunit/test.h>
 
+#include "dc.h"
+#include "core_types.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
 #include "amdgpu_dm_psr.h"
+#include "power_helpers.h"
 
 /*
  * Helper: allocate and zero-initialise a dc_link sufficient for
@@ -25,6 +30,365 @@ static struct dc_link *alloc_test_link(struct kunit *test)
 	return link;
 }
 
+/*
+ * Helper: allocate and wire the minimal DM/DC state needed for
+ * amdgpu_dm_psr_is_active_allowed() testing.
+ */
+static struct amdgpu_display_manager *alloc_test_dm(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct dc *dc;
+	struct dc_state *state;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	dm->dc = dc;
+	dc->current_state = state;
+
+	return dm;
+}
+
+static void add_test_stream(struct kunit *test, struct dc_state *state,
+		unsigned int index, struct dc_link *link)
+{
+	struct dc_stream_state *stream;
+
+	KUNIT_ASSERT_LT(test, index, (unsigned int)MAX_PIPES);
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	stream->link = link;
+	state->streams[index] = stream;
+	if (state->stream_count <= index)
+		state->stream_count = index + 1;
+}
+
+static struct dc_stream_state *alloc_test_psr_stream(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	link = alloc_test_link(test);
+	link->psr_settings.psr_feature_enabled = true;
+	stream->link = link;
+	kref_init(&stream->refcount);
+
+	return stream;
+}
+
+static struct core_power *create_test_power_module(struct kunit *test,
+		struct dc_stream_state *stream, struct psr_caps *caps)
+{
+	struct core_power *core_power;
+
+	core_power = kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, core_power);
+
+	core_power->map = kunit_kzalloc(test, sizeof(*core_power->map), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, core_power->map);
+
+	core_power->map[0].stream = stream;
+	core_power->map[0].caps = caps;
+	core_power->map[0].psr_events = psr_event_vsync;
+	core_power->num_entities = 1;
+
+	return core_power;
+}
+
+static struct dc_link *alloc_test_psrsu_link(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct dc_context *ctx;
+	struct dc *dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	link->ctx = ctx;
+	ctx->dc = dc;
+	dc->ctx = ctx;
+	dc->caps.dmcub_support = true;
+	ctx->dce_version = DCN_VERSION_3_1;
+	link->dpcd_caps.edp_rev = DP_EDP_14;
+	link->dpcd_caps.psr_info.psr_version = DP_PSR2_WITH_Y_COORD_ET_SUPPORTED;
+	link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP = 1;
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED = 1;
+
+	return link;
+}
+
+static struct dc_link *alloc_test_psr_caps_link(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->ctx->dc->caps.dmub_caps.psr = true;
+	link->connector_signal = SIGNAL_TYPE_EDP;
+	link->type = dc_connection_single;
+
+	return link;
+}
+
+static struct amdgpu_dm_connector *alloc_test_aconnector(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	return aconnector;
+}
+
+/* Tests for link_supports_psrsu() */
+
+/**
+ * dm_test_link_supports_psrsu_no_dmcub() - DMCUB support is required.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_no_dmcub(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->ctx->dc->caps.dmcub_support = false;
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+}
+
+/**
+ * dm_test_link_supports_psrsu_old_dcn() - DCN version 3.1 or newer is required.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_old_dcn(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->ctx->dce_version = DCN_VERSION_3_0;
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+}
+
+/**
+ * dm_test_link_supports_psrsu_panel_unsupported() - Panel PSR-SU caps are required.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_panel_unsupported(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->dpcd_caps.psr_info.psr_version = 0;
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+}
+
+/**
+ * dm_test_link_supports_psrsu_missing_alpm() - AUX wake ALPM is required.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_missing_alpm(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP = 0;
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+}
+
+/**
+ * dm_test_link_supports_psrsu_missing_y_coordinate() - Y coordinate support is required.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_missing_y_coordinate(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED = 0;
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+}
+
+/**
+ * dm_test_link_supports_psrsu_missing_granularity() - Required granularity must
+ * be reported by the panel.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_missing_granularity(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED = 1;
+	link->dpcd_caps.psr_info.psr2_su_y_granularity_cap = 0;
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+}
+
+/**
+ * dm_test_link_supports_psrsu_debug_mask_disabled() - Debug mask disables PSR-SU.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_debug_mask_disabled(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+	unsigned int old_debug_mask;
+
+	old_debug_mask = amdgpu_dm_psr_get_dc_debug_mask();
+	amdgpu_dm_psr_set_dc_debug_mask(old_debug_mask | DC_DISABLE_PSR_SU);
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+	amdgpu_dm_psr_set_dc_debug_mask(old_debug_mask);
+}
+
+/**
+ * dm_test_link_supports_psrsu_temporarily_disabled() - Supported panels still
+ * return false while PSR-SU is temporarily disabled.
+ * @test: KUnit test context.
+ */
+static void dm_test_link_supports_psrsu_temporarily_disabled(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psrsu_link(test);
+	unsigned int old_debug_mask;
+
+	old_debug_mask = amdgpu_dm_psr_get_dc_debug_mask();
+	amdgpu_dm_psr_set_dc_debug_mask(old_debug_mask & ~DC_DISABLE_PSR_SU);
+
+	KUNIT_EXPECT_FALSE(test, link_supports_psrsu(link));
+	amdgpu_dm_psr_set_dc_debug_mask(old_debug_mask);
+}
+
+/* End of tests for link_supports_psrsu() */
+
+/* Tests for amdgpu_dm_set_psr_caps() */
+
+/**
+ * dm_test_set_psr_caps_null_link() - NULL link is rejected.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_null_link(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(NULL, aconnector));
+}
+
+/**
+ * dm_test_set_psr_caps_null_connector() - NULL connector is rejected.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_null_connector(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, NULL));
+}
+
+/**
+ * dm_test_set_psr_caps_no_dmub_psr() - DMUB PSR capability is required.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_no_dmub_psr(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	link->psr_settings.psr_version = DC_PSR_VERSION_1;
+	link->ctx->dc->caps.dmub_caps.psr = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version,
+			DC_PSR_VERSION_UNSUPPORTED);
+}
+
+/**
+ * dm_test_set_psr_caps_non_edp() - Only eDP links can enable PSR.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_non_edp(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+}
+
+/**
+ * dm_test_set_psr_caps_disconnected() - Disconnected links cannot enable PSR.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_disconnected(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	link->type = dc_connection_none;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+}
+
+/**
+ * dm_test_set_psr_caps_no_dpcd_psr() - DPCD PSR version is required.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_no_dpcd_psr(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	link->dpcd_caps.psr_info.psr_version = 0;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+}
+
+/**
+ * dm_test_set_psr_caps_edp1_disabled() - eDP panel instance 1 is blocked.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_edp1_disabled(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct dc_link *edp0 = alloc_test_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+	struct dc *dc = link->ctx->dc;
+
+	edp0->connector_signal = SIGNAL_TYPE_EDP;
+	dc->links[0] = edp0;
+	dc->links[1] = link;
+	dc->link_count = 2;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+}
+
+/**
+ * dm_test_set_psr_caps_success_psr1() - Valid eDP link enables PSR1 caps.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_success_psr1(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version, DC_PSR_VERSION_1);
+	KUNIT_EXPECT_EQ(test, (int)aconnector->psr_caps.psr_version, 1);
+	KUNIT_EXPECT_EQ(test, (int)aconnector->psr_caps.support_ver,
+			DP_PSR2_WITH_Y_COORD_ET_SUPPORTED);
+}
+
+/* End of tests for amdgpu_dm_set_psr_caps() */
+
 /* Tests for amdgpu_dm_psr_fill_caps() — PSR version mapping */
 
 static void dm_test_psr_fill_caps_version_1(struct kunit *test)
@@ -221,6 +585,24 @@ static void dm_test_psr_fill_caps_power_opts_z10_always_set(struct kunit *test)
 			  (caps.psr_power_opt_flag &
 			   psr_power_opt_z10_static_screen) != 0);
 }
+
+static void dm_test_psr_fill_caps_power_opts_smu_opt_set(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+	unsigned int old_feature_mask;
+
+	memset(&caps, 0, sizeof(caps));
+	old_feature_mask = amdgpu_dm_psr_get_dc_feature_mask();
+	amdgpu_dm_psr_set_dc_feature_mask(old_feature_mask | DC_PSR_ALLOW_SMU_OPT);
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+	amdgpu_dm_psr_set_dc_feature_mask(old_feature_mask);
+
+	KUNIT_EXPECT_TRUE(test,
+			  (caps.psr_power_opt_flag &
+			   psr_power_opt_smu_opt_static_screen) != 0);
+}
 /* End of tests for amdgpu_dm_psr_fill_caps() */
 
 /* Tests for amdgpu_dm_psr_set_event() — early-exit validation guards */
@@ -258,9 +640,155 @@ static void dm_test_psr_set_event_psr_not_enabled(struct kunit *test)
 
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_set_event(NULL, stream, true, psr_event_vsync, false));
 }
+
+/**
+ * dm_test_psr_set_event_get_event_fails() - Failed power event read returns false.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_set_event_get_event_fails(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct dc_stream_state *stream = alloc_test_psr_stream(test);
+
+	dm->power_module = NULL;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_set_event(dm, stream, true, psr_event_vsync, false));
+}
+
+/**
+ * dm_test_psr_set_event_already_set() - Already set event returns true.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_set_event_already_set(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct dc_stream_state *stream = alloc_test_psr_stream(test);
+	struct psr_caps caps = {0};
+	struct core_power *core_power;
+
+	caps.psr_version = 1;
+	core_power = create_test_power_module(test, stream, &caps);
+	dm->power_module = &core_power->mod_public;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_psr_set_event(dm, stream, true, psr_event_vsync, false));
+	KUNIT_EXPECT_EQ(test, core_power->map[0].psr_events,
+			(unsigned int)psr_event_vsync);
+}
+
+/**
+ * dm_test_psr_set_event_updates_event() - Changed event delegates to mod_power.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_set_event_updates_event(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct dc_stream_state *stream = alloc_test_psr_stream(test);
+	struct psr_caps caps = {0};
+	struct core_power *core_power;
+
+	caps.psr_version = 1;
+	core_power = create_test_power_module(test, stream, &caps);
+	dm->power_module = &core_power->mod_public;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_psr_set_event(dm, stream, true, psr_event_full_screen, false));
+	KUNIT_EXPECT_EQ(test, core_power->map[0].psr_events,
+			(unsigned int)(psr_event_vsync | psr_event_full_screen));
+}
 /* End of tests for amdgpu_dm_psr_set_event() */
 
+/* Tests for amdgpu_dm_psr_is_active_allowed() */
+
+/**
+ * dm_test_psr_is_active_allowed_no_streams() - Empty DC state disallows PSR.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_is_active_allowed_no_streams(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_is_active_allowed(dm));
+}
+
+/**
+ * dm_test_psr_is_active_allowed_null_link() - Streams without links are skipped.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_is_active_allowed_null_link(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct dc_state *state = dm->dc->current_state;
+
+	add_test_stream(test, state, 0, NULL);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_is_active_allowed(dm));
+}
+
+/**
+ * dm_test_psr_is_active_allowed_requires_enabled_and_allowed() - Both link flags
+ * must be set before PSR active is allowed.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_is_active_allowed_requires_enabled_and_allowed(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct dc_state *state = dm->dc->current_state;
+	struct dc_link *link = alloc_test_link(test);
+
+	add_test_stream(test, state, 0, link);
+	link->psr_settings.psr_allow_active = true;
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_is_active_allowed(dm));
+
+	link->psr_settings.psr_allow_active = false;
+	link->psr_settings.psr_feature_enabled = true;
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_is_active_allowed(dm));
+}
+
+/**
+ * dm_test_psr_is_active_allowed_any_stream() - Any enabled and allowed stream
+ * permits active PSR.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_is_active_allowed_any_stream(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct dc_state *state = dm->dc->current_state;
+	struct dc_link *disabled_link = alloc_test_link(test);
+	struct dc_link *allowed_link = alloc_test_link(test);
+
+	disabled_link->psr_settings.psr_allow_active = true;
+	allowed_link->psr_settings.psr_feature_enabled = true;
+	allowed_link->psr_settings.psr_allow_active = true;
+
+	add_test_stream(test, state, 0, disabled_link);
+	add_test_stream(test, state, 1, allowed_link);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_psr_is_active_allowed(dm));
+}
+
+/* End of tests for amdgpu_dm_psr_is_active_allowed() */
+
 static struct kunit_case dm_psr_test_cases[] = {
+	/* link_supports_psrsu */
+	KUNIT_CASE(dm_test_link_supports_psrsu_no_dmcub),
+	KUNIT_CASE(dm_test_link_supports_psrsu_old_dcn),
+	KUNIT_CASE(dm_test_link_supports_psrsu_panel_unsupported),
+	KUNIT_CASE(dm_test_link_supports_psrsu_missing_alpm),
+	KUNIT_CASE(dm_test_link_supports_psrsu_missing_y_coordinate),
+	KUNIT_CASE(dm_test_link_supports_psrsu_missing_granularity),
+	KUNIT_CASE(dm_test_link_supports_psrsu_debug_mask_disabled),
+	KUNIT_CASE(dm_test_link_supports_psrsu_temporarily_disabled),
+	/* amdgpu_dm_set_psr_caps */
+	KUNIT_CASE(dm_test_set_psr_caps_null_link),
+	KUNIT_CASE(dm_test_set_psr_caps_null_connector),
+	KUNIT_CASE(dm_test_set_psr_caps_no_dmub_psr),
+	KUNIT_CASE(dm_test_set_psr_caps_non_edp),
+	KUNIT_CASE(dm_test_set_psr_caps_disconnected),
+	KUNIT_CASE(dm_test_set_psr_caps_no_dpcd_psr),
+	KUNIT_CASE(dm_test_set_psr_caps_edp1_disabled),
+	KUNIT_CASE(dm_test_set_psr_caps_success_psr1),
+	/* amdgpu_dm_psr_fill_caps */
 	KUNIT_CASE(dm_test_psr_fill_caps_version_1),
 	KUNIT_CASE(dm_test_psr_fill_caps_version_su1),
 	KUNIT_CASE(dm_test_psr_fill_caps_version_unsupported),
@@ -273,9 +801,19 @@ static struct kunit_case dm_psr_test_cases[] = {
 	KUNIT_CASE(dm_test_psr_fill_caps_dpcd_fields_unset),
 	KUNIT_CASE(dm_test_psr_fill_caps_rate_control_always_zero),
 	KUNIT_CASE(dm_test_psr_fill_caps_power_opts_z10_always_set),
+	KUNIT_CASE(dm_test_psr_fill_caps_power_opts_smu_opt_set),
+	/* amdgpu_dm_psr_set_event */
 	KUNIT_CASE(dm_test_psr_set_event_null_stream),
 	KUNIT_CASE(dm_test_psr_set_event_null_link),
 	KUNIT_CASE(dm_test_psr_set_event_psr_not_enabled),
+	KUNIT_CASE(dm_test_psr_set_event_get_event_fails),
+	KUNIT_CASE(dm_test_psr_set_event_already_set),
+	KUNIT_CASE(dm_test_psr_set_event_updates_event),
+	/* amdgpu_dm_psr_is_active_allowed */
+	KUNIT_CASE(dm_test_psr_is_active_allowed_no_streams),
+	KUNIT_CASE(dm_test_psr_is_active_allowed_null_link),
+	KUNIT_CASE(dm_test_psr_is_active_allowed_requires_enabled_and_allowed),
+	KUNIT_CASE(dm_test_psr_is_active_allowed_any_stream),
 	{}
 };
 
-- 
2.53.0

