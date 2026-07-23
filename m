Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7344C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFEB10F1E0;
	Thu, 23 Jul 2026 20:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x18raDK/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648F610F1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuYiy0qWq1CmWEva4l7j4d7CTsoB138CDk+PVmZtBmQviKYezsx52nlwQAMQioSFlAor7sXJcHSct0rlLhQXKhnkrRMn5i2kSTPlORJEYLMQAIKCph5AjY1EmkBgkMBmmaMHtz5Pyib8S1+26104f4YF5nP/L8tBOP53le+yP0hcH02lAZJNCihE+ehZ1DBUPfWtRAkyNq+Xtn7Z80p0Y+NXKILnGnqoHy3c9QlPcbBkJTIPVG+Ih7ZKqDhrYfK1oDz20/fmxtubGr8dllPCW6p+Bc0FRzFghUNyMoZTyz8vKWvPoPw4VS4y8ffW3mdDsd1JCaOtxmkDLl0WnLThUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5lCWyTvaygCIZmNN8TeRFbmgwFDcWk9mIwDnxoNpMw=;
 b=cunZRxjhmKeupEcBfCRQmbBawydXyJvDYbBtNPRg/tYbXVL5OfaznFOWVbGP1G+H5Oy0MVcAszD90baRb3hiufBxsINIArtEPsaEKwHMgQ+SLizlTCPyEt4VGmhBvjJGQ1n0FY66hcfMSWDiIJNQL4NWEm8lwN0tJvhaqMad6JzjZNn+86E6bDMnLTjHTFQ0fMMhhll52vumdpD1Zf6T4JFnB4aE1+HCBpBnV4vSz9/dPbPQOERyuVhkgFtpGlArOf6MoOSr6NNr0TI8qMxjxdVuLW6fzsPY+KMfAVN4LvZfBSOIhtUmLYrpOQl9ocxMueOBu5dE8DDxFLfFUAjV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5lCWyTvaygCIZmNN8TeRFbmgwFDcWk9mIwDnxoNpMw=;
 b=x18raDK/Ypj4BTy3jrOla4rL7kSGyHhyJCCKzC4qneOQX6HvHvRZlXIAWDvoNGXFPIFPSdXo5BCVeV2B021/Lg4yVgtWBkBVmYo5Kqin8cMkpo0qEVyIU40S6PfpLrKG+ducwVgylsWbebFTczFPl+BkcRl5VvQZui0mya0GxQY=
Received: from BN1PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:e1::15)
 by PHXPR12MB999257.namprd12.prod.outlook.com (2603:10b6:510:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:24 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::22) by BN1PR12CA0010.outlook.office365.com
 (2603:10b6:408:e1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:24 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:10 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 29/49] drm/amd/display: Add KUnit tests for enable_assr
Date: Thu, 23 Jul 2026 16:13:37 -0400
Message-ID: <20260723201908.373300-30-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PHXPR12MB999257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1152c18c-fa0f-4b10-073d-08dee8f7b023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fc/n7J7lPhweL8HFCXVuPF2yieTry2cslgYPRp7nM97xZh2YQ/C7Q7UW5cu6gHCmssCsV5QNAbUJkc0DkQdAnmk3i4qL0wG+OWfwBb9gfB3SDMzsjYGwH0okXHHbrKwaR8DSMzVdtEf7c48FWFQf0Z7uV+M5PSUsWaYz1eg+8RrlFXdd7TwXUlY/R1tSs7MvmldrZ5X7X5UngkTY8/bF6fpujXEfHiP4zu+z57PkLxcDWHusFEPpv7AJpmexnJc2ufRRM98fVMLTctfkECEmKgTnqg7315Oi2ooO6gEPtj4nbDcWLyKZfVzEuFvwkWUgEmi8KCi+POIqBlKWjWgYVANZOf0DkiGWctCe9Y2LGmheyLWDBJCvcfmKnax1ILNW95W8s3F+iBgiCMOvRpgI/lZVCsUq1J0MfvK9o3Bv2gFDoH4ZDPBklGDC0qv81S3gUgJ5ujbml17s3iXw9qxhFts3gmaGaxA+4L2VwkMKuvJBNRjBoHc9Hjlc22ZMmgMOTOxRFarYcY6Pa5kJdpcoqYZrtttNqPxwVq6PxgX5ibUSQcDZnzeM/8qaxzZekVIk+CyRQ8cSq28dOaZ+7qSdHsPs+2+5S3qKzGg0TcUi14jGeBZpMt6UKFfuw1Za5YmpsepdlofIjewjzE64h6f2voK4lG+p2OVG7+OK0iuDrt1u2vGodiO5DUZWXQ//ZI0VS4cMDwN7BEPVqvqTc5BHiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cx8hKuKDHQzFUFU1EjI8ft5a5WeNZ4gaNG3ySflwPgyxwQ1Av3LfbZCuz1ASfDK58mQ1UeD3m7cQG3a/3zuSaK4K7D4bgOBFmxt84QRjTOuxZfW40VO9eyaiC5LRQgk6FKFkZP8R1Bga9DRXXkmYnH7BWUQEKvzSoFMeVMABkq2DNapG8hPruHdLs0pWtCZATkXCFpuno+dRjaQThtF6ctHHrT0vYuckWLtP9MfYrCnm7Sn5xutQbl35bZW5eq3klleV+F45ulF4REQWluq6L5jwm67uBEIXF1yWzCQqgloJEc9lZC2s1BWXh5rADXwBbtk3MRdV4SzO4g2FGqUAoIDXEyv0IH6I2zBmNbQ2RVd90korbOV0WIXYfA+U1cs9PPvsDIiFebuULy6w6wQeVDTczMVgX8bX/nAbIecG0xqrMiGDrYyH35Y6TFKrC0zU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:24.2407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1152c18c-fa0f-4b10-073d-08dee8f7b023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999257
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Expose enable_assr() for KUnit and cover the "DTM TA not initialized"
path and the full command-build path, using the SR-IOV VF early-return
to bypass psp_dtm_invoke()'s firmware submit.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 138 ++++++++++++++++++
 3 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index e704b6b7fc0b..7115cc0c7746 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -570,7 +570,8 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 }
 EXPORT_IF_KUNIT(hdcp_destroy);
 
-static bool enable_assr(void *handle, struct dc_link *link)
+STATIC_IFN_KUNIT
+bool enable_assr(void *handle, struct dc_link *link)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
 	struct mod_hdcp hdcp = hdcp_work->hdcp;
@@ -603,6 +604,7 @@ static bool enable_assr(void *handle, struct dc_link *link)
 
 	return true;
 }
+EXPORT_IF_KUNIT(enable_assr);
 
 static void update_config(void *handle, struct cp_psp_stream_config *config)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index a2b08bec58b5..b8ba2888a2ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -123,6 +123,7 @@ void hdcp_remove_display(struct hdcp_workqueue *hdcp_work, unsigned int link_ind
 			 struct amdgpu_dm_connector *aconnector);
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size);
 int psp_set_srm(struct psp_context *psp, u8 *srm, uint32_t srm_size, uint32_t *srm_version);
+bool enable_assr(void *handle, struct dc_link *link);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_HDCP_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 5eace7fa4100..1580562727cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -14,6 +14,8 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_hdcp.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
+#include "hdcp_psp.h"
 
 static void dummy_work_fn(struct work_struct *work) {}
 
@@ -1446,6 +1448,138 @@ static void dm_test_hdcp_reset_display_clears_all_state(struct kunit *test)
  * hdcp_reset_display().
  */
 
+/* Tests for enable_assr() */
+
+/**
+ * alloc_test_workqueue_for_assr - workqueue wired to a psp for enable_assr()
+ * @test: KUnit test context for managed allocation
+ * @adev: amdgpu device whose drm_device backs psp->adev (for drm_info())
+ *
+ * Allocates a minimal hdcp_workqueue and a psp_context connected through
+ * hdcp.config.psp.handle, matching the dereference chain enable_assr()
+ * performs. The psp is left with dtm_context.context.initialized == false
+ * (from kzalloc) so enable_assr() takes the "DTM TA not initialized" path.
+ */
+static struct hdcp_workqueue *alloc_test_workqueue_for_assr(struct kunit *test,
+							    struct amdgpu_device *adev)
+{
+	struct hdcp_workqueue *work;
+	struct psp_context *psp;
+
+	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, work);
+
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+
+	psp->adev = adev;
+	work->hdcp.config.psp.handle = psp;
+
+	return work;
+}
+
+/**
+ * dm_test_enable_assr_uninitialized_dtm_returns_false - DTM TA not initialized
+ * @test: KUnit test context
+ *
+ * When the DTM TA context is not initialized, enable_assr() must take the
+ * early-return path, emit the informational message and return false
+ * without invoking the (real) firmware path.
+ */
+static void dm_test_enable_assr_uninitialized_dtm_returns_false(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_assr(test, adev);
+	struct dc_link *link;
+	bool ret;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* kzalloc leaves dtm_context.context.initialized == false */
+	ret = enable_assr(work, link);
+
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_enable_assr_uninitialized_dtm_ignores_link - link untouched on failure
+ * @test: KUnit test context
+ *
+ * On the "DTM TA not initialized" path enable_assr() returns before reading
+ * any field of @link, so a NULL link must be tolerated and the call must
+ * still return false.
+ */
+static void dm_test_enable_assr_uninitialized_dtm_ignores_link(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_assr(test, adev);
+	bool ret;
+
+	/* link is not dereferenced before the initialized check. */
+	ret = enable_assr(work, NULL);
+
+	KUNIT_EXPECT_FALSE(test, ret);
+}
+
+/**
+ * dm_test_enable_assr_initialized_builds_command_and_fails - full body, invoke bypassed
+ * @test: KUnit test context
+ *
+ * With the DTM TA marked initialized and a valid shared buffer, enable_assr()
+ * runs its full body: it acquires the DTM mutex, clears the shared command,
+ * fills in the ASSR-enable command from @link and pre-sets the status to
+ * GENERIC_FAILURE before invoking the TA.
+ *
+ * psp_dtm_invoke() is prevented from touching real firmware by marking the
+ * device as an SR-IOV virtual function, which makes it return early without
+ * modifying the shared status. The status therefore stays GENERIC_FAILURE, so
+ * enable_assr() must return false. Inspecting the shared command afterwards
+ * proves the body executed and consumed @link.
+ */
+static void dm_test_enable_assr_initialized_builds_command_and_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_assr(test, adev);
+	struct psp_context *psp = work->hdcp.config.psp.handle;
+	struct ta_dtm_shared_memory *dtm_cmd;
+	struct dc_link *link;
+	bool ret;
+
+	dtm_cmd = kunit_kzalloc(test, sizeof(*dtm_cmd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dtm_cmd);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	link->link_enc_hw_inst = 3;
+
+	/* Wire up an "initialized" DTM TA with a real shared buffer. */
+	psp->dtm_context.context.initialized = true;
+	psp->dtm_context.context.mem_context.shared_buf = (uint8_t *)dtm_cmd;
+	mutex_init(&psp->dtm_context.mutex);
+
+	/*
+	 * Force the SR-IOV VF early-return in psp_dtm_invoke() so no GPU
+	 * command is submitted; the shared status is left untouched.
+	 */
+	adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
+
+	ret = enable_assr(work, link);
+
+	/* Status was never advanced to SUCCESS, so the call must fail. */
+	KUNIT_EXPECT_FALSE(test, ret);
+	/* The command body must have populated the shared buffer. */
+	KUNIT_EXPECT_EQ(test, dtm_cmd->cmd_id, TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE);
+	KUNIT_EXPECT_EQ(test,
+			dtm_cmd->dtm_in_message.topology_assr_enable.display_topology_dig_be_index,
+			link->link_enc_hw_inst);
+	KUNIT_EXPECT_EQ(test, dtm_cmd->dtm_status, TA_DTM_STATUS__GENERIC_FAILURE);
+	/* The DTM mutex must be released after the guard scope exits. */
+	KUNIT_EXPECT_FALSE(test, mutex_is_locked(&psp->dtm_context.mutex));
+}
+
+/* End of tests for enable_assr() */
+
 static struct kunit_case dm_hdcp_test_cases[] = {
 	/* hdcp_get_content_protection_from_status() */
 	KUNIT_CASE(dm_test_hdcp_get_cp_disabled_returns_desired),
@@ -1507,6 +1641,10 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_hdcp_remove_display_enabled_resets_cp),
 	KUNIT_CASE(dm_test_hdcp_remove_display_null_state_clears_connector),
 	KUNIT_CASE(dm_test_hdcp_reset_display_clears_all_state),
+	/* enable_assr() */
+	KUNIT_CASE(dm_test_enable_assr_uninitialized_dtm_returns_false),
+	KUNIT_CASE(dm_test_enable_assr_uninitialized_dtm_ignores_link),
+	KUNIT_CASE(dm_test_enable_assr_initialized_builds_command_and_fails),
 	{}
 };
 
-- 
2.53.0

