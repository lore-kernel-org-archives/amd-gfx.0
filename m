Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC0606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TqqHn2S0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E43210F747;
	Wed, 25 Nov 2026 06:58:33 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3802010F747
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3ELiW5cFUM8NibUBOY4f9163HKS7iccA9YI1QdEVj2J9a++savOR7slUGlIgATghBY4pdd0jwU2/ci4LhQKNSIHPbD9T/fNJhXykAMR2kBT8FifkhjPjOsDh+D0V1UaGH2xI9pcZCF19XULDbWgLCpgmJOrOLC4MqROJNbheCB7bGacmvKrJjcYVveGpWCmhnywD00eKQ1UA9YRmRiPXhfHLP0+/qmUM/YccQ87XICQHYy1rcVcjxbfjcVNMsqJID2JM3agcF0Z2w/D6wr6Ouz5g5xnQiC2ZN744YXnNRPgWPyF/QdWXFtOSBcTghi1ThXxK96PpFnaQfEktvX71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AotqKe6CdFphKPo0Ou0hP1ibRR17LAxh92EKnqrWCj4=;
 b=cTiLDUGPjFeH2bfu99/SYqB5vr+KT9UmpCgscKjWAwkYYek5+IG4oDml1E8fmF8RjcwSyHJBPLNsliNzF4CvhTlHJ6SjW2VERrn9A7wCKe00rnIG94e/VNGJok3Bhp9P3niQYC0VlI/GrJ1TZZ9x5Xf0bvNYvQUXfkFi7By6j8yxxf/dcz0Rbw1n3PUGN+yT3nPQKPcAw4FMc29Xqlg9PtmIJ0WbEUOrI+JXNiJZf/rCD0PpQ+37sqjCJ4yaC1k8CDZeUzWaCm12ahL6ma7oInw6KiNlYzzQ/BbOVRNuShGMxVMmf2zrNj6ad0qg3/3Iz/GVcXOWrTaB5i2pgNj6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AotqKe6CdFphKPo0Ou0hP1ibRR17LAxh92EKnqrWCj4=;
 b=TqqHn2S0ZfAEAdbEX5fvI/qtBNgBjFdvzqDCgmAv86+t7/4JYNbS6GNmMDLhlCwN8IqCINGlkp3IYJNldc6Zsosivi6rEIj2jHTPtDgX2VSHDwWTC2CW3wq15lZlYHFAXLnHdHuIY4EFRBju7dPfyEsS7uhzI+a3yUShBCWWEyw=
Received: from PH0PR07CA0088.namprd07.prod.outlook.com (2603:10b6:510:f::33)
 by PH7PR12MB9149.namprd12.prod.outlook.com (2603:10b6:510:2ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 06:58:22 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::9b) by PH0PR07CA0088.outlook.office365.com
 (2603:10b6:510:f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:58:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:58:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:16 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:58:08 -0600
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
Subject: [PATCH 20/27] drm/amd/display: Test amdgpu_dm_dmub SET_CONFIG sync
 wait
Date: Wed, 25 Nov 2026 14:55:09 +0800
Message-ID: <20261125065631.3889665-21-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH7PR12MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c88ea6-474a-4c57-c22f-08df4ac17e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|30052699003|376014|23010399003|18002099003|22082099003|3023799007|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261026121527099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: XOcKTPqFEHERajjqbLRX/jTAz8hxepan1gAk7+4C2rQfHJFJ8m9GyiVgrsowhXVvV9DdsIzZqDn/gz4v4g4fK0JFuoyjuAgZdx4XUH+kQMVXA/FYIsDqrAVep+IA+X4ssq7y519+bPingFEBhRsypVD7VnblVi/cpe4pd7dMlJUKjUwMpnczpUGWT07/oxkaA3S5+zr/eomNHkbz99X1wr82CXZXIT0z6QpRXJ2KJSaxHgxmu3mycGuDu4h1zzQbl7SbatjlWBTNMtBVrWM0tnopG8aRO4ndq3Lmjs/In53kSYRfEbm22HwDfP1WzEY1vbBNGUxkQximERv3ruyjPi14jT0itb81kHZKKdU3DHzWOtGWEr7TE6qjVY2eDxE1b++jyiBFCWmCVTAY4xS8It50PY+YaDDz9zrM+LVoHTUbLE46c2hjoWgQieERvAnZErrIY43l+wNsRspzcZ9KOXoKjGPzIVZ/pw/e8MUiGzA+av77ZuxzxBD9Jk4b3tZfPmbvWp73aUESpdhK1YAc0yH1z24d4+IsayiOd556d/WtmLL98Hf0sVAgX32ZBMKNe/AiBSrdRpiXW2bIpTRh/7PtuvnTC/Y3YBuTGLzk2twTBYQr9rx11gOCpd5+P2OEWB883ooHcDYWEo9NdKENwDH6OVocciz5hfzlMxKGYx5gdDPf7YRJdpDub6U6lRswXyBXRHbwOxZ8PyhG1o3ceQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(30052699003)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RePkzxYWMoDaea5D8VxgB8nTo3AzktBVaDxj2xhc7WTFCs+sCITz0Jr9bLuSrGDwVbmtz3gWKRiwtJHnk87pVbBkaXbMFTBVjJ7bjay4pEbCwohZck1EM1OuYsSqs10B9jXLyJdkXGEryT3i+Cgi2rM1QmDszmkQ4e8195jsDW++xS4i70umDxkD8til+9r6di4Rm153u2laf6xm4f5fjsk6c5veD/U7eB2M3f1Gxy99G/uVJcb5tYNeIZ5MZWVFPzypj2NdUHksdoAgcD6f1M7KbYYbWpOqoU8sQeQDthPLq8i7lvoPj7uqwRS1E4aFW2a75Pj1B2TTNbJ7ataBVEfOVmWr/hT5JrUZJw4cn1m96L9Z5D2NJ21GTwpsq4jnrd4kB0przKpcryO4zdN1nyAvSt8CW3FKXCeru5Lyk24vFbs98scf4zbOpLUXdBwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:58:22.2291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c88ea6-474a-4c57-c22f-08df4ac17e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9149
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for amdgpu_dm_process_dmub_set_config_sync() covering
a pending command completed by a DMUB notification, and the reply
timeout.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 1a4fa8c7e00c..164071f39731 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -925,6 +925,33 @@ static void dm_test_dmub_hw_init_alt_channel_rejected(struct kunit *test)
 	}
 }
 
+static void dm_test_free_dc_dmub_srv(void *data)
+{
+	struct dc_context *ctx = data;
+
+	kfree(ctx->dmub_srv);
+	ctx->dmub_srv = NULL;
+}
+
+/*
+ * Build an amdgpu_device whose DC DMUB service runs on the fake DMUB, so
+ * commands complete instantly and replies echo the submitted command.
+ */
+static struct amdgpu_device *dm_test_alloc_adev_with_dc_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+	struct dc_context *ctx = adev->dm.dc->ctx;
+
+	spin_lock_init(&adev->dm.dmub_lock);
+	mutex_init(&adev->dm.dpia_aux_lock);
+
+	KUNIT_ASSERT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dmub_srv);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_dc_dmub_srv, ctx), 0);
+
+	return adev;
+}
+
 /* Tests for dm_dmub_hw_resume() */
 
 /**
@@ -1441,6 +1468,74 @@ static void dm_test_process_dmub_set_config_sync_unknown_error(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, result, SET_CONFIG_UNKNOWN_ERROR);
 }
 
+static struct amdgpu_device *dm_test_alloc_adev_with_link(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc_dmub(test);
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	link->ddc = kunit_kzalloc(test, sizeof(*link->ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link->ddc);
+
+	link->ctx = adev->dm.dc->ctx;
+	adev->dm.dc->links[0] = link;
+	adev->dm.dc->link_count = 1;
+
+	adev->dm.dmub_notify = kunit_kzalloc(test, sizeof(struct dmub_notification), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dmub_notify);
+
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+
+	return adev;
+}
+
+/**
+ * dm_test_process_dmub_set_config_sync_pending_notified - Test a pending SET_CONFIG completes
+ * @test: The KUnit test context
+ *
+ * When DMUB accepts the command without an immediate status, the sync helper
+ * waits for the outbox notification, reports its status and rearms the
+ * completion for the next request.
+ */
+static void dm_test_process_dmub_set_config_sync_pending_notified(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_link(test);
+	struct set_config_cmd_payload payload = { 0 };
+	enum set_config_status result = SET_CONFIG_PENDING;
+	int ret;
+
+	adev->dm.dmub_notify->sc_status = SET_CONFIG_ACK_RECEIVED;
+	complete(&adev->dm.dmub_aux_transfer_done);
+
+	ret = amdgpu_dm_process_dmub_set_config_sync(adev->dm.dc->ctx, 0, &payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, result, SET_CONFIG_ACK_RECEIVED);
+	KUNIT_EXPECT_FALSE(test, completion_done(&adev->dm.dmub_aux_transfer_done));
+}
+
+/**
+ * dm_test_process_dmub_set_config_sync_timeout - Test a pending SET_CONFIG times out
+ * @test: The KUnit test context
+ *
+ * When DMUB accepts the command but no notification arrives within the 10
+ * second wait, the sync helper returns -1 with SET_CONFIG_UNKNOWN_ERROR.
+ */
+static void dm_test_process_dmub_set_config_sync_timeout(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_link(test);
+	struct set_config_cmd_payload payload = { 0 };
+	enum set_config_status result = SET_CONFIG_PENDING;
+	int ret;
+
+	ret = amdgpu_dm_process_dmub_set_config_sync(adev->dm.dc->ctx, 0, &payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, -1);
+	KUNIT_EXPECT_EQ(test, result, SET_CONFIG_UNKNOWN_ERROR);
+}
+
 /* Tests for abort_fused_io() */
 
 /**
@@ -2071,6 +2166,8 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_zero_length),
 	/* amdgpu_dm_process_dmub_set_config_sync() */
 	KUNIT_CASE(dm_test_process_dmub_set_config_sync_unknown_error),
+	KUNIT_CASE(dm_test_process_dmub_set_config_sync_pending_notified),
+	KUNIT_CASE_SLOW(dm_test_process_dmub_set_config_sync_timeout),
 	/* abort_fused_io() */
 	KUNIT_CASE(dm_test_abort_fused_io_no_dmub_srv),
 	{}
-- 
2.43.0

