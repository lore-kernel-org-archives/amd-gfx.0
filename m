Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB24C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4808310EFCF;
	Wed,  2 Sep 2026 05:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2r542GEW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE0710EFCF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaF9jrxrfXYQbOKVZWvY+EFnOesl5BWhmPcO3upa5XIxZ5vR/uV8BsMOQGIrvRRgIFbgUi8X4fhPmsDwXqkwQA5CU+hkmF9FJ5FeuBxQO4LZZ94Df2isiVzymk4XQ/KBBPk7XNnU3T5boSJCKkGlthQgx36lBlWBhOcj/pyLt8xeLhP2nNLue99fj8LSvgP0v5ol/jUT7NEKwpYH+CHih7JzM6n3TFjpgpq1IJd2xVj0x2pqkKysA4CWg+kRH6SvgHGVhtOI34hioT/iYwgTmc6o/Ui8jWQ1atCO1iwgdo6CarTksoyUzaynGqB6BeeA5fHFizIXD6Io8qp/VvpJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8+Z+vs+zqfRDZ3LDJTFPTc7jOz0IWNsLE0cPoKXcIE=;
 b=ruYMGE6urAhtSbgaTaIqQU3yg8gLhssW7rXdLzSWs+1UtmahB4ArKxbS+9mGumLxKq6mtPR+sYNnXN1Ky/9KE0SI/qyYAGT6RQOpPx2Hs0GCVxi2Dz7fjpDYXzjsw/i8e2Hbi72X4bPqtnyzaVM5XlNz3hwgIw8R0m0IXtUexxQj7anPU7vwJhqviyb6Sf9M+wSKJlqYbmFUegJH65WDGv2Rt46uGkjPCllIQTkWsXJQrs489zy/Ha9xOUQAgqQX8t6nKCW9SRN0tfpbUiONtCfLWI/Z1J+pPY0KeldSTBGkSUworFc4rd6zqHqvyKfc8qOP1mhbnGMAVXJ6ArbsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8+Z+vs+zqfRDZ3LDJTFPTc7jOz0IWNsLE0cPoKXcIE=;
 b=2r542GEWtZG7UrE7UadF0l74nkEX4H0Tzw/2GNOmy0cmSO2Jwd6qudQx8p7dqL/x2Ft3Xur8I2ZQfrU9vz3Spf0ueTkgehn555rmOCMx6iGIhxINA0aiZMIebRFLxV75iT8NhijdB4IHUatiMyBGDmFrT/4zHC99jz+ofM+AkH0=
Received: from LV3P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::23)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:07:32 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::6c) by LV3P220CA0022.outlook.office365.com
 (2603:10b6:408:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:31 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:22 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 21/40] drm/amd/display: Fix HF-VSDB DSC bpc detection to be
 cumulative
Date: Wed, 2 Sep 2026 12:58:43 +0800
Message-ID: <20260902050411.3473916-22-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 2915414b-74be-4897-fe2d-08df08b017e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: MDzfvdnQLm8lXdsGYrtql0KDw/dVB3/VWBoFAG4yUmzg8VO0mmZD0Snr7WqK30kijv3cvfCC/7MQyyNY/9ne3JmHJeQh/EaMZASSRvq/GD4/X5S5p8hwhX9rNoLtwKHuDcJc3YOJFN0mxYFT5uDjcJhanOHMFLdkP3HV6UkXH0msqqgncKsBsi7Ih1FZG00hWqV8p0TxijxwWeohvufpiJSPgHomssFObJP+VxfJ6cP4d/NEeaiP1Dx7u4BNblTamYh8ibDwQ+u9qxI0LjzNk7W/+Kk0SOsiV6oVjHycMP4AmTQosPCl0hu6lh6Y619R3MOC9axEciZnWiP/wryEC9HVRsQTgl81dPEkHEACrEwnLMJEmc1mCD8fG/L+Z2QNKuVbfbLwYPxx9zhqbXWWOcXsdlKj+erEC4GpzpiQf9BykCcwv58C2vkz3+4JQ+2wDwFErsq5Th0Akq7f/dg6dRcuaf2+4FiNMGW9Ih5McMNncscOqJLCsLKVjGWvxsaBlJyTvbr50vbD5trHYYTHgC4PXCklhu6U20cCsCKdQ/jFoNn8q56ZjE7lUnax4NqMpvQz7yVGEEpOaEL7CJ6z+5lYJahKPzHUh0JPFHVMKRG3qnRtOlr5RRjQFaagFDJySeol0jdBqs5UkY3D89eU1PY6C7OitxLO5sWK6ZQagY9/5Hm1lLtxd36L3jqAYqmAouCfFQ8KRkn3XyFfJqeQxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XiYGbxls3KMlp6smbW76FUgZ9+RLzBGj2TSbFfDfemld09hLFMEEVtixFXK0Y6VLKYeU/8HP9h404jXPXaAMe3wt0V09Wimb7PQ19amzzyXUmfiruVJYBZ8l0Bvdij6dQM/VZVaD548Kp3Jzu5LowsTR05ZOKb9/VHWLlkei/DW8j2KeFiDN/qMasnHADgO9s0Ikl0nNp8uhd2QCFrdr2wgmLPguVsrXgHX304PBI/gY/GmWzNyodt2CKABUVsc+jFN+fTjEU6lOigqiF8SbnbNYROKiyce1ZENJpmaLvulaDbL6UpoKGqzRJKFRd/loGGPssVutDpXjIpd/UXESFIyhMiY1gVf+PTAozmqW1ORE0Pw8F5jc8BqoQwsoPquOHERxr5sbeXt97CLhcNwP92eXvS04xrailBxGZceJkyK3On6J/vPi8qK0tsdY2vVo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:31.7662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2915414b-74be-4897-fe2d-08df08b017e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why & How]
The HDMI Forum VSDB reports the maximum DSC color depth a sink supports.
This maximum is cumulative: a sink that reports 12 bpc also supports 10
and 8 bpc.

The previous code used exact "== 10" and "== 12" comparisons chained with
else-if, so a 12 bpc sink only set frl_dsc_12bpc and never set
frl_dsc_10bpc, incorrectly narrowing the DSC bpc range usable with that
sink.

Use ">= 10" and a separate ">= 12" check so a sink advertising a higher
maximum also enables the lower DSC bit depths it supports.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 5 +++--
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 93fd5f251a6c..836c06772a68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1228,9 +1228,10 @@ void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hd
 		edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
 		edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
 		if (edid_caps->frl_dsc_support) {
-			if (hdmi->dsc_cap.bpc_supported == 10)
+			/* HF-VSDB DSC max bpc is cumulative: >=12 implies 10 and 8. */
+			if (hdmi->dsc_cap.bpc_supported >= 10)
 				edid_caps->frl_dsc_10bpc = true;
-			else if (hdmi->dsc_cap.bpc_supported == 12)
+			if (hdmi->dsc_cap.bpc_supported >= 12)
 				edid_caps->frl_dsc_12bpc = true;
 			edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
 			edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index d4232648d8e6..ceedb8745267 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -982,7 +982,7 @@ static void dm_test_populate_hdmi_frl_dsc_12bpc(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, caps->max_frl_rate, 2);
 	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_support);
-	KUNIT_EXPECT_FALSE(test, caps->frl_dsc_10bpc);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_10bpc);
 	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_12bpc);
 	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_slices, 7);
 	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_frl_rate, 1);
-- 
2.43.0

