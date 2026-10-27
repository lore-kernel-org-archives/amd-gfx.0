Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DD606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5iyHavHL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241F310F89F;
	Tue, 27 Oct 2026 23:23:14 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537D410F89A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl1GOc4ivjZ/BYlLafTiTxZMVs7FsZI9LxhsyNPjKRAwL/LUBVaA3jf1pCNaEI9wG8WvcfTNg4+0b9oAJoyaVjTCc7bWATGAcmjckajKE5VF/mH8y8UVDsyqVZUVhtUfmJ1zFW6YUJrLlEV3bXjMCzF7OJJ9CYW9ri3GoQ1HMQW2Ypq0OfdsRyA8Zfbp1KS/wkZ5ei8koYxws8v7IiLU7E1oIRvHN1Y/YMSrbfcndwlhQ/1aLQ7kaP6q+PCtYioN0g3DqjOZkPhE8TPQ1ph5wFIbMNbpkyLYW0JL8eAWALCQA0oHOoeIh1Oy09AeJ5a84fjw8EffGjuju4gVpv6qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJxBcL+rQl9C946YefZn7JaTNVzslvMg3jy6vZJUci4=;
 b=Ka4tcC8lBOCr0W0UB47cVBNQ2dUOOTIeMbiXQZqjstBhIPcqRTuiNfY7b77FEv18rhO2lsGdSQGSq4O2hSQbcerxDrxw7m4KCeOCmBy/9jbXMlWyh1eGN7dGsVg9GSKzkpstOC6hFmc2vrEeEfqIHirTLEaOMHN7/QVlPtNn7eJW0+5uNmEpnBFyXMUFtldtB7K0Se7numxwazy3gHR/tn0Heabzx+YtBAA2iGWPpx2iaPNV0zmhwhQt3SeRqzkHsqFkR5NmCC91ZoNYag5i5hSLbfaZJtRwB9b04Mq1d0zYXE4Kpy/yocz/jD7jUhiN9IA1mxn6dUNnoVFkkI/j9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJxBcL+rQl9C946YefZn7JaTNVzslvMg3jy6vZJUci4=;
 b=5iyHavHLkAZgY+hfwcpae9YeE5Jj8roxZ+juIdEdp55QVoy5mU75pqk4q9rW1XudI4HkikN6QPPyLDJhi5fJz1oy/FkJqBu2l7W8F0arC7EqJ5E+qVZs4Zg3lvZGuJvGaNbunt7hot5IyV1wAQ9rXf8GLlGU3Gp02j0XA6JNiq8=
Received: from CH0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:610:e7::11)
 by LV1PR12MB509357.namprd12.prod.outlook.com (2603:10b6:408:516::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:23:05 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::64) by CH0PR03CA0216.outlook.office365.com
 (2603:10b6:610:e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:23:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:23:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:23:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 12/28] drm/amd/display: Fix unadvertised mode detection
Date: Tue, 27 Oct 2026 17:17:08 -0600
Message-ID: <20261027232005.2879750-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|LV1PR12MB509357:EE_
X-MS-Office365-Filtering-Correlation-Id: 275575e8-a330-4b63-0d2b-08df348140c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: fgkOnCOL2PT4gBB4DpO5wQqhoHq725MqUlv+3FMaz8dUktjulh97inyVhX1W8FjMKebHDaezRyRmtwDnysZrHPpXl/eOL3HpQXycY6iWW+OXgAJ5Q9bNiPnkbLFToY6+U62s9x87pbrsI5Gs0t5ou+kDDDZtfoPujgAPdSqgcALYmStuNVPhDDLSO6UK3am39gYNdOojV+PJaaVMDH7be7TeGvKWfQtnA+WsH8zWm/pBPPK5Gt62Y57v0bRPOBsIHzu25lmHnobP9m7JNqLvgNzRt/NQ5Xm+UHeN3nfU79h0p5j4dkKSwJvW+S/vIIW+2FfBYNEdLUYcBWJ7l/zrCyWaTBVRMp3d2IimHmiB6fCdjBIJuo8Ck61vfWdDGZVZg+TkTeOUz9dr64ahZqxsnImdSxDOOObhqDRPLAQlYsT4Jn3+wIcvmEtkAUnqUc4xfBi/AeLK+Dc9myBbE+y2Ub6lEc8gtLZD12lZ1oy2Lksscdra+Ij/tfR1RfjbxGtHyUJm05X7Gyt+WC4St9YlEwEiUPaAaKkvKUquGhjqJzO1We7nC3DjkA6BG5cTx47A33rNw5GTnKrLoI6+RMlBG2U1wDSlINk+F4GaC+SvH8zMcmrIVRz4UKWXQo7zzE24joKA2yMV12OJRvWePe42IzP6WDOYQLfMBbh1SGXh+8gf+LOomI0HxAh+2MiqFD2EDN34WkOzmsiENbUsNQc7XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7SARoVLLZvViriOuws0jkDZcRZ4V14jezXfijq84E1r+SLZX3ZWnxrrJlFUBeuplinKdZpakKsoOsD8YfNxAy0NthYnWlZvhzX97Uso2IfE6UpSP7cWuxfF46Sm8gLhaedyBvE5zVFKMEDJlZ9gvNlGLNznwbwO+avmK1YLVPpx5cWelRHucKD0SeQ5A0g1uEQ5gpL5bX9iKeMxPHbxkJQJyJAVpZeZIYBrGht+M5tGWt3nbZStxQ7WN5Og06hJDpdsmI+rM6jIgFXdbKf5ArDwpL+3n50j5vLiaWN9gTlrqtyC4aXztkSDTy/LmSjo1sFKBPxOaT6y/ZttTk3NqxQfjTTed6XgPXX3wqcyYazcJiiQZ+seNjccObeveiMtct1VoMqQSoaT2o7oRsNPpP75qm+sUemAQokUbkgBSWXrFfAnbmZDuB5oTxm1VvOS5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:23:05.1160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275575e8-a330-4b63-0d2b-08df348140c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB509357
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangzhi Zuo <jerry.zuo@amd.com>

[WHY]
The advertised mode list moves between probed_modes and modes during
mode validation. Checking only one list can misclassify valid modes or
allow generated FreeSync modes to be added more than once.

[HOW]
Make is_duplicate_mode() search both connector->modes and
connector->probed_modes so it works before and after DRM transfers
probed modes. Update the KUnit fixtures to use the advertised modes
list.

Fixes: ed82b939ccd1 ("drm/amd/display: warn on unadvertised modes without scaling")
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  5 +++
 .../tests/amdgpu_dm_connector_test.c          | 38 +++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index bc5745a5ba37..37b41c887ede 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1407,6 +1407,11 @@ STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 			return true;
 	}
 
+	list_for_each_entry(m, &aconnector->base.modes, head) {
+		if (drm_mode_equal(m, mode))
+			return true;
+	}
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index acde20241f43..7965a221e0e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1135,6 +1135,7 @@ static void dm_test_is_duplicate_mode_empty_list(struct kunit *test)
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
+	INIT_LIST_HEAD(&aconnector->base.modes);
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	mode.hdisplay = 1920;
 	mode.vdisplay = 1080;
@@ -1155,6 +1156,34 @@ static void dm_test_is_duplicate_mode_match(struct kunit *test)
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
+	INIT_LIST_HEAD(&aconnector->base.modes);
+	INIT_LIST_HEAD(&aconnector->base.probed_modes);
+	existing.hdisplay = 1920;
+	existing.vdisplay = 1080;
+	existing.clock = 148500;
+	list_add_tail(&existing.head, &aconnector->base.modes);
+
+	candidate.hdisplay = 1920;
+	candidate.vdisplay = 1080;
+	candidate.clock = 148500;
+
+	KUNIT_EXPECT_TRUE(test, is_duplicate_mode(aconnector, &candidate));
+}
+
+/**
+ * dm_test_is_duplicate_mode_probed_match - Test probed mode duplicate match
+ * @test: The KUnit test context
+ */
+static void dm_test_is_duplicate_mode_probed_match(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode existing = {};
+	struct drm_display_mode candidate = {};
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	INIT_LIST_HEAD(&aconnector->base.modes);
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
@@ -1182,10 +1211,11 @@ static void dm_test_is_duplicate_mode_no_match(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
+	INIT_LIST_HEAD(&aconnector->base.modes);
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
 	existing.clock = 148500;
-	list_add_tail(&existing.head, &aconnector->base.probed_modes);
+	list_add_tail(&existing.head, &aconnector->base.modes);
 
 	candidate.hdisplay = 2560;
 	candidate.vdisplay = 1440;
@@ -1207,12 +1237,13 @@ static void dm_test_is_duplicate_mode_same_size_different_clock(struct kunit *te
 
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-
 	INIT_LIST_HEAD(&aconnector->base.probed_modes);
+
+	INIT_LIST_HEAD(&aconnector->base.modes);
 	existing.hdisplay = 1920;
 	existing.vdisplay = 1080;
 	existing.clock = 148500;
-	list_add_tail(&existing.head, &aconnector->base.probed_modes);
+	list_add_tail(&existing.head, &aconnector->base.modes);
 
 	candidate.hdisplay = 1920;
 	candidate.vdisplay = 1080;
@@ -10096,6 +10127,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* is_duplicate_mode */
 	KUNIT_CASE(dm_test_is_duplicate_mode_empty_list),
 	KUNIT_CASE(dm_test_is_duplicate_mode_match),
+	KUNIT_CASE(dm_test_is_duplicate_mode_probed_match),
 	KUNIT_CASE(dm_test_is_duplicate_mode_no_match),
 	KUNIT_CASE(dm_test_is_duplicate_mode_same_size_different_clock),
 	/* amdgpu_dm_get_encoder_crtc_mask */
-- 
2.53.0

