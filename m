Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2968AC79FAD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54BE10EB4B;
	Tue,  8 Sep 2026 11:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxKrJYwu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BC410EB5C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1B1qiEeXrhUct3lMyWbz/Nk18bUItTMnGLa76c0YbTQ4MNMxPb9+KRYLTwAXSQjGpdo9ZVCn9T+BpfNwqffsDfKW3XSeiZqmhusVd6yMNgMbTWWssGDvU6CrZXaOiV6pKHAx3a6BuUjhUcs996al0HAS/1aGi/uF8PsOVL/bcPbSOnOWerL5Ji8eWyicXvdR6SNoIZ7gDUCjbGVckv/H3PVH8IJ1S//NDu5LmRbJA5+H1/0Ymqf7AqRAEWTwTSy43O+m9BxYUKru/Zrgi/P6GcKKcq0UU0orebh+TcEGMJGEAgBBJf+9pExw595Fi3BIW9upVnzh8WQxiGvSGK9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+BVILtJedZyv63V+xHntPfE0nfj94r8SGYMIN0IXOc=;
 b=kO5mwJ3VGxxmDp/UxtFJg3UuSmY6fqOfyXFKgQNFLTPB1eYLpjCHtKP1KAdwyu+3X7lXC11OZrRsxJPk2zbhx3+8NdEYVlV6c44sSCZ2pu/UT+ei3Ra0ud4+Ff+2PlaDtCOMz3QDbgb0sMne65moh4D2Q8CZN9UzIUrii8cQlBZXmJNai2E5+IUUfxATg6TlzrQseeY9poqYNFjDT5pBemnHggO/SWFszWzvfOIjy+WZuFJAKJGfW/3AuZV6s1qbMVSXItFLVtyIzg6V2iGRsWoNCEkuduBYj+5am9OE+zXrz3XslcazMpgUKHemVguegH6YWlCvZdp4QMshZjP8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+BVILtJedZyv63V+xHntPfE0nfj94r8SGYMIN0IXOc=;
 b=mxKrJYwuRWNLQ7ZpFH1jX44MzXLOIVqbG287naImqCLeKk385BGPLpSJLkuPOqvcNkltls8t5o16xG+jlEXhu6rrNE9rGJpOGQwgmG1+yqQ0pxOcyYpZfciRIb0lv5PVNrA75y2q8Qu2DHPfOG1CZRyixhDDYQ0AZxZTkvXr+90=
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:37:10 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::a) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Tue, 8
 Sep 2026 11:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:02 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:53 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 22/66] drm/amd/display: Test link bandwidth readback
Date: Tue, 8 Sep 2026 19:31:15 +0800
Message-ID: <20260908113338.2433445-23-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: aa30ddb4-d950-4db2-201d-08df0d9d847d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: CLwAkmlSZLhfUA5PxDl2CMWJf8rw/n27+VWYbZ20EsTH4ZrXrGx0+O80/cg/xRTb8inkLwNQ8F1WVKeLfu1SV0ZLLhHgnBdnGrQMd+TBUWRtVxd278MHdwzOm/7iIblEP/r8K8Rg/VlErJAsLJN7Z66JOfTZervAE4rTl5p5eumFeplQKNCh3eN6wp4QuK0KmdMm6I9y1yxx3+ok9TfdLtA/WIkANRJpy6qXwnPUyPTXOOS414e2MdPX7kE5El9uDedPw8BOkj7OhefYD2cwjEJnvnpbYUFrYMcebY3Oxylv47ZTm616LDTYx7iXOOb8aUf1GikcUjnvxpyz21goUXGehf8Nv36hdftluJm+oQ1PSqOCTgflYxE6zhTmBK61gym7iqfKf6Tl2Yaxk0sSjrDHaOG4feIy6BXVK//ilrOObXfQlBC/Y2TsHlG/AiaE1v8j6uhqf4695LBkwyGE0QmXASo9eOXdy7idynvZr+imzRi8h0d/fEq3BArduzMdcSNXZWW7C3JLSLlvFQjTOp58O1xogVIPcKcqsxOcVTio4HN6D2vyOrteBJ5hvv2OBTPWH2Oj0T3IBriaBNldF/bZmUBUSsNAr+hH9yGzYPYwj/Ui51gwUPn67Y0qe4F45G3aL3hARppJAwAULF1rD8iwJ1wbQoGG0Q+p1CKwF6391Rqp+er9iPfiaS63orEDDpfe1Xx1kA4GTcTuxBuYVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ecBLelyULK5+M041P+d/fYFJXyzHnSv2uiod8vpUAPSLahwmFpXeusRJOvyeOlgXNzLTcMDNjiAvbLE3YULKC2tOYlIjPvnRrHYSGJqvrC229MR5+0IZhbmmHBtsdMVTqhfCLcSa3wIdDMoaXXOxkjXh61up3Pjd1TVAGKuy+RG2sECkaV3edqEbVAQk88Gysu5UA8LANE9FmuqH3/glr1EO14oioDVI6Z3UqlWocEKEzT7Oj/c/8jAphlJWLEbr+hv34+pgcsl3zssyHlqTWDoZBtA4PAKykFGKiJDQl0qptWQpEFVR+08huSC3brttk/YVxYLuQM88GR0wjgDNyQgiokWN2BjYegxJ0PP+w6ShzUwKLtVhdHCaeQ8BrYasR+mFC4IyiYebEiQIJ/SThdH0SPemVFp83AHVsK3DYWpi9cV3OEPt1iIk+JAI7mNM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:09.3025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa30ddb4-d950-4db2-201d-08df0d9d847d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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
Add KUnit tests for dp_get_link_current_set_bw() covering every link
rate the helper knows about, the unknown rate fallback and the DPCD
read error path.

[HOW]
Add a DPCD backing store for the DSC helpers that is addressed
absolutely, because they read offsets spread across the whole map. A
table driven test then programs the link rate and lane count into the
fake DPCD and checks the returned bandwidth, with one entry arming the
AUX transfer to fail.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   2 +
 .../tests/amdgpu_dm_mst_types_test.c          | 120 ++++++++++++++++++
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index f857303fe386..e8f4ca7e1f2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1930,7 +1930,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 #endif
 
 #if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
+STATIC_IFN_KUNIT bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
 {
 	uint32_t total_data_bw_efficiency_x10000 = 0;
 	uint32_t link_rate_per_lane_kbps = 0;
@@ -1985,6 +1985,7 @@ static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_lin
 	*cur_link_bw = link_rate_per_lane_kbps * lane_count.bits.LANE_COUNT_SET / 10000 * total_data_bw_efficiency_x10000;
 	return true;
 }
+EXPORT_IF_KUNIT(dp_get_link_current_set_bw);
 #endif
 
 enum dc_status dm_dp_mst_is_port_support_mode(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 0e6189219eb2..4af3aac31223 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -65,6 +65,7 @@ struct dc_state;
 struct dc_stream_state;
 struct dm_atomic_state;
 struct drm_atomic_commit;
+struct drm_dp_aux;
 struct drm_dp_mst_port;
 struct drm_dp_mst_topology_mgr;
 
@@ -104,6 +105,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector);
+bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw);
 bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
 bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
 ssize_t dm_dp_aux_transfer_result(ssize_t result,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index f2bae3a50941..58a4bbb31e79 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -2276,6 +2276,124 @@ static void dm_mst_test_sideband_msg_ready_ack_write_fails(struct kunit *test)
 	dm_mst_test_free_armed_sideband_connector(aconnector);
 }
 
+/*
+ * Fake DPCD backing store for the DSC helpers. Unlike the sideband fake above
+ * it is addressed absolutely, because these helpers read offsets spread across
+ * the whole map (0x60 DSC caps, 0x100 link settings, 0x500 branch descriptor).
+ */
+#define DM_MST_TEST_DSC_DPCD_SIZE 0x600
+
+static u8 dm_mst_test_dsc_dpcd[DM_MST_TEST_DSC_DPCD_SIZE];
+static struct drm_dp_aux *dm_mst_test_dsc_aux_fail;
+
+static ssize_t dm_mst_test_dsc_aux_transfer(struct drm_dp_aux *aux,
+					    struct drm_dp_aux_msg *msg)
+{
+	size_t i;
+
+	if (aux == dm_mst_test_dsc_aux_fail)
+		return -EIO;
+
+	if (msg->address + msg->size > DM_MST_TEST_DSC_DPCD_SIZE)
+		return -EINVAL;
+
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+
+	if ((msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_WRITE)
+		return msg->size;
+
+	for (i = 0; i < msg->size; i++)
+		((u8 *)msg->buffer)[i] = dm_mst_test_dsc_dpcd[msg->address + i];
+
+	return msg->size;
+}
+
+/* Clears the shared store; call once per test before initialising any AUX. */
+static void dm_mst_test_reset_dsc_dpcd(void)
+{
+	memset(dm_mst_test_dsc_dpcd, 0, sizeof(dm_mst_test_dsc_dpcd));
+	dm_mst_test_dsc_aux_fail = NULL;
+}
+
+static void dm_mst_test_init_dsc_aux(struct drm_dp_aux *aux, const char *name)
+{
+	aux->name = name;
+	aux->transfer = dm_mst_test_dsc_aux_transfer;
+	drm_dp_aux_init(aux);
+	drm_dp_dpcd_set_probe(aux, false);
+}
+
+static struct drm_dp_aux *dm_mst_test_alloc_dsc_aux(struct kunit *test, const char *name)
+{
+	struct drm_dp_aux *aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+	dm_mst_test_init_dsc_aux(aux, name);
+
+	return aux;
+}
+
+/* Tests for dp_get_link_current_set_bw */
+
+/*
+ * Program DPCD 0x100..0x10f, the 16-byte window the helper reads in one go.
+ * @coding is the raw DP_MAIN_LINK_CHANNEL_CODING_SET byte at 0x108.
+ */
+static void dm_mst_test_set_link_settings(u8 link_bw_set, u8 lane_count, u8 coding)
+{
+	dm_mst_test_dsc_dpcd[DP_LINK_BW_SET] = link_bw_set;
+	dm_mst_test_dsc_dpcd[DP_LANE_COUNT_SET] = lane_count;
+	dm_mst_test_dsc_dpcd[DP_MAIN_LINK_CHANNEL_CODING_SET] = coding;
+}
+
+struct dm_mst_link_bw_param {
+	const char *name;
+	u8 link_bw_set;
+	u8 lane_count;
+	u8 coding;
+	bool aux_fails;
+	bool supported;
+	uint32_t cur_link_bw;
+};
+
+static const struct dm_mst_link_bw_param dm_mst_link_bw_params[] = {
+	{ "hbr2_8b_10b", DP_LINK_BW_5_4, 4, DP_8b_10b_ENCODING, false, true, 16761600 },
+	{ "uhbr10", DP_LINK_BW_10, 4, DP_128b_132b_ENCODING, false, true, 38564000 },
+	{ "uhbr13_5", DP_LINK_BW_13_5, 4, DP_128b_132b_ENCODING, false, true, 52061400 },
+	{ "uhbr20", DP_LINK_BW_20, 4, DP_128b_132b_ENCODING, false, true, 77128000 },
+	{ "unlisted_uhbr_rate", 0x1e, 4, DP_128b_132b_ENCODING, false, false, 0 },
+	{ "unknown_encoding", DP_LINK_BW_5_4, 4, DP_UNKNOWN_ENCODING, false, false, 0 },
+	{ "dpcd_read_error", DP_LINK_BW_5_4, 4, DP_8b_10b_ENCODING, true, false, 0 },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_mst_link_bw, dm_mst_link_bw_params, name);
+
+/**
+ * dm_mst_test_link_current_set_bw - the current link settings are priced
+ * @test: KUnit test context
+ *
+ * For 8b/10b the raw DP_LINK_BW_SET byte is the link rate in 27MHz units, so
+ * HBR2 (0x14) yields 20 * 27000 * 10 kbps per lane scaled by the 80% data
+ * efficiency and the 97% FEC efficiency. For 128b/132b the byte instead
+ * selects a UHBR rate scaled by its own efficiency. An unlisted UHBR rate, an
+ * unknown channel coding and a short DPCD read all report no bandwidth.
+ */
+static void dm_mst_test_link_current_set_bw(struct kunit *test)
+{
+	const struct dm_mst_link_bw_param *param = test->param_value;
+	uint32_t cur_link_bw = 0xdeadbeef;
+	struct drm_dp_aux *aux;
+
+	dm_mst_test_reset_dsc_dpcd();
+	aux = dm_mst_test_alloc_dsc_aux(test, "dm_mst_test_link_bw_aux");
+	dm_mst_test_set_link_settings(param->link_bw_set, param->lane_count, param->coding);
+	if (param->aux_fails)
+		dm_mst_test_dsc_aux_fail = aux;
+
+	KUNIT_EXPECT_EQ(test, dp_get_link_current_set_bw(aux, &cur_link_bw), param->supported);
+	KUNIT_EXPECT_EQ(test, cur_link_bw, param->cur_link_bw);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -2360,6 +2478,8 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	/* dm_dp_mst_connector_destroy tests */
 	KUNIT_CASE(dm_mst_test_connector_destroy_no_sink),
 	KUNIT_CASE(dm_mst_test_connector_destroy_releases_sink),
+	/* dp_get_link_current_set_bw tests */
+	KUNIT_CASE_PARAM(dm_mst_test_link_current_set_bw, dm_mst_link_bw_gen_params),
 	{}
 };
 
-- 
2.43.0

