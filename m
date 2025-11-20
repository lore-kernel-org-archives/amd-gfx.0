Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505E8CF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED0710E7AB;
	Thu, 20 Nov 2025 18:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FRdPBTOK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F0610E7AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5dXkl+NzMcbUl6IQ+/+agNe50BZocqIA6PWIOb/SEJmXraM4Y65xP7Cj5FUwRlNlfRMrdLXIhgP2gDN6mHvMyetxI7k4ZJJO+uPVMyKQfpk47z+8dbriX+RhyCYh6hT2tg6XVGYMElgDiYkENNdwTeK9d6MYsOZmLSb59mxWrWRISgUF6jJ1ry08mhqijLnB5/egDYy983p0acViz3MXfl/XMrwVidHP/0+PDsB2LEZKEfwBMKNisP2vpypnBBWOunkrM3zmLURxfkaZa81EOeYMrIrTAyKApCJU8/ciW0McEYjsFt8+n4g8x6lYv8ROX8i2ozSgJ5GnSPrWJM+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkUSReTV6Np+HYBBnTfDVnf0iEJGY0Z+enXu3BuDvtk=;
 b=OfGmjGt5+3eA/rgXtMKUiXqSrmq5tYx8eZdUFXb2o4N6I+P5GJHZ3BOyIxl3njWbnkEosbVsO1ddwS0EVoujyDgV3Zwc7riJ4yrIaoQcedacAGcmwS7zjYz3diuzZ+B6VT6ysvrE6/kNJFsrh8CX1mLfHt/8DcfvvNWGm1FalKB6A9g6pC1UcJ/+3wiIdxrMEGVxDm77LqCLxfgke4C9t1iRoU+oRN/LTCHThEl9jOMeRvlhK/76I1ngyR7Jg9N2gZVOYM7KNKI4lhKhf0nr9+J1rSL1z1oicj4csQyset5eM5GVMcOjoxTKcogULLiwWqm1ngKBJcQeK3iScCNafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkUSReTV6Np+HYBBnTfDVnf0iEJGY0Z+enXu3BuDvtk=;
 b=FRdPBTOK3Taz6TPxgk1n+QnN4BjLIxJsDrC3UOjubAfNNgNkDS75puwUYqmjJ2UgsIV6PD+Aa5ZmSX80WJsTucRd6olA88enQ4HFw6AX5GT2eQR+dHmctgqvlC/RTeea0IqFq5FA2en5rm3JpCDeSri92hJEj8LNxqHDG/xx+v0=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by DS2PR12MB9686.namprd12.prod.outlook.com (2603:10b6:8:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:17:18 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::43) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:17:18 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:17:16 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 02/26] drm/amd/display: Improve HDMI info retrieval
Date: Thu, 20 Nov 2025 11:02:58 -0700
Message-ID: <20251120181527.317107-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS2PR12MB9686:EE_
X-MS-Office365-Filtering-Correlation-Id: dd745542-0bde-4c36-bf7e-08de28610a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J3eTqphYKrhHV2O2RzWkX4KN2MHyPFed3ZBA0Ng4Mk1NxsY/3zzwCrIg8Up0?=
 =?us-ascii?Q?i+1PyjNRHpV9gLhq2iGniF+6AD2F+79UabZUr+QNf0tsGHH0OIWbDeOXlZ7q?=
 =?us-ascii?Q?oz7LVotAJ7vh84PdPpQ3TSGCF5XkWakpuiBp/9Mj4/4vS/BIA/PH9e5mNavI?=
 =?us-ascii?Q?OQ1EffVxk+h0PhalqppQmU2lf3Z1dB3fo/Zcs06txqXsnv7H2wpM3byewkqy?=
 =?us-ascii?Q?Wbd/mrJ2u3j1PMiZ1H0d+RWBIfM95Ic8vABfmyUCd/fWTmEsPkevksKQUNKB?=
 =?us-ascii?Q?9+gLkfNaMVRCAFmaSS3W9QS2KMmE5ejYZQZC9PxuUu4YiD/kIxM+/nDTWkVI?=
 =?us-ascii?Q?zGoH66Z/pEFWVOHzgWv7wfPUAf4h7HYdsMOlm1N7N+hCj7lpaAvAO3XfEw2B?=
 =?us-ascii?Q?QDyO6I2FbpfaN5QW722bLeycfkWzEk8K7qo9bd8Ef4UN+QuHXGWEpLUt2wqX?=
 =?us-ascii?Q?KEjwE1cVgqSPTFk93TyLmG0WL604tsTqVH9glJMLrnqEFtNKGJ+NYLAVt+WT?=
 =?us-ascii?Q?jHWG2G6Bs0imnCyATd2OA0Pgxy5NTh0F40BVXiJC9n61vKOQyKhQUb9UKbHv?=
 =?us-ascii?Q?jxhnpI4JBAFGqve2r0fqiWZdpmXBiUHRU6jlDZJ8tjdCyGrT4Q8VnAgX6FdE?=
 =?us-ascii?Q?PmyvykOfh81B4iV7OQo0o2gbzfUMCF1l3S2KzLDXUohnIMEaNU3Zm+f//Ih6?=
 =?us-ascii?Q?8enQwHT+mdi/AljBWqHrAhJx9fGUivBUQnNNUrtCi0gENzd4OYY8bQ9fQDo7?=
 =?us-ascii?Q?jtAWg33VqJRVfnh37YoNDO0Dd3/EQdI5OwKfk0hzzsl/FqZ1oj0QWL8gPhzX?=
 =?us-ascii?Q?JdaZfKssMXMn/fp5/k14QymtS+Pbf8ee3KUQp7B2Vf6hiY1emna+gu8YL/Hp?=
 =?us-ascii?Q?/s/rWwuLCeq8i5knDriXe4j7A0HZpGoZBAzCdlJwXC5a/Mw5+xLtFtDCiz5Z?=
 =?us-ascii?Q?lFpK29bO6KlmhvvHX7it+9p8dGYwE+91eepIeAd+9aqUAEcMZgdNdiz/wdA5?=
 =?us-ascii?Q?gieR0KCVFlx5OFTCErgkgCvQYC/JFvwETYiqUzMqhZ5pHW8HJ8t2U+8BiStV?=
 =?us-ascii?Q?N0o+CPnS16rqzu8k/UFcB7Q1+0VZtnRtVjsvMiQM3mSYCCwiETdhc+VSsZoe?=
 =?us-ascii?Q?WTxcimqef6uQ8eYBGVdDPgcJL4W4I48CVfr4VPBn/Y+UU/aeH4NSpapvS7Cn?=
 =?us-ascii?Q?h7rhI5aAtAtVcfXlnz/DIy3Y+zxxLkRz+iS3xROaek+QX+zZ17py4LYiOnks?=
 =?us-ascii?Q?zEy5OnNk3F8CIp7hr+phMHARqQRm39+6juIGEkYg4jSn3zDarx+f6dVqVpMf?=
 =?us-ascii?Q?1CILo7zYMDVnAoQbKhMgkQGak9HdrOQlLYkAxvFkkyIiBOH9/G8eTmABk/11?=
 =?us-ascii?Q?HphjUE1qeAbz3Gt6lYVcuGT41OfuXAYZEZFnBT51cCjrtLZB5Rk2TYZAExyn?=
 =?us-ascii?Q?CMY+pkDdUAApDhW7ZyRlm3JqDC+Zyqu9KBlSz89e+hm6aVMgx44KMFI7cB4e?=
 =?us-ascii?Q?2rLI/CHVRHOGMDGSw9PIfSW5K8aSdV5kL/ouPaiIIRIWKcJLqrqy6RXleRYM?=
 =?us-ascii?Q?ErRkzBHCI/dLTyffSnU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:17:18.0539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd745542-0bde-4c36-bf7e-08de28610a34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9686
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

[WHY & HOW]
Make a dedicated function to read HDMI-related monitor info, including
monitor's SCDC support.

Suggested-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h         | 3 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 20ac784f0ee9..d683b710181b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1058,6 +1058,9 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 void amdgpu_dm_update_connector_after_detect(
 		struct amdgpu_dm_connector *aconnector);
 
+void populate_hdmi_info_from_connector(struct drm_hdmi_info *info,
+				      struct dc_edid_caps *edid_caps);
+
 extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 
 int amdgpu_dm_process_dmub_aux_transfer_sync(struct dc_context *ctx, unsigned int link_index,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index eb2c587b0b9b..582a1c04f035 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -139,6 +139,9 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	if (edid_caps->edid_hdmi)
+		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
+
 	apply_edid_quirks(dev, edid_buf, edid_caps);
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
@@ -990,6 +993,11 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 	return drm_edid_read_custom(connector, dm_helpers_probe_acpi_edid, connector);
 }
 
+void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
+{
+	edid_caps->scdc_present = hdmi->scdc.supported;
+}
+
 enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_context *ctx,
 		struct dc_link *link,
-- 
2.43.0

