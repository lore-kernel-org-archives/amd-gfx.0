Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F47606A327
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kCT0lc16
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6ED010F8BB;
	Wed, 11 Nov 2026 01:41:32 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F09B10F8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpEbeDKZuLKTT26ZZDqq+IKVshF3wx9x0BjgZalGlBPqc8CudJU6dCdcxhnOguyROpNHlDk8oq0S0Qyya5Cvzsgue46r+P3MSYcJNct5sHRgrTkqTt2UjSnHUq2Mj5UJ6TbmJAvkUq3OahSff/K+Ok0bARAhhWKf6h+j4V8bGI24wgBPiJVqhKaFO/hCBIt5MweN3BMcYzGMzIgFCGYItg5wQ86KaZnhpMrbArfB4F45fT+2GmzkNXCwMC3hLHf1zB3PV56TpBpluXpvuJSUuSZp+sYGu0/AWr6eaRL3QxTUoRlYHX6VyFBnkdklBvIbQk/sjYMFh3NeEC3KsiRc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2VXjNlBSfCjsL/FxW5ywojeS/VNyfTBmKGSsAwdxbA=;
 b=yZ8+eDSIXaCqY3tAgnGxqFixL4Gp+/rzxN2CR0HHKSWvlx1GVHUHXVXaPohVxBM9n5EOy5wAVoKaIPsqJ+TMXdpi9Ne7CuHQTKcYyWr1LY43YYLJJwM+/paMo/4PBy5GQB0H6ykSlEs+aWvHwWBMhVvNGSn28o04DlmNW3B0KFgJWtddtSi+VZQDYRECnrR9KSsYoHH09s5P21KdqSUmfZH3b9pL1kSHRHkS9Obry6mss5qzYTqwN1KZ2xX1ddUXyMJPeowisTcoqyfj1UmFugZeE3ASeK+JX6tAVCtDzWm6MnlG6JlCTn/KJs+oLJTO8Xg2rsZ3fESg24esdFXe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2VXjNlBSfCjsL/FxW5ywojeS/VNyfTBmKGSsAwdxbA=;
 b=kCT0lc16Ow+CxKc7XHtGuKni7vpDFMbUdX0r6nUXtOlTUTio+hTldL8VMCIP9PGVX8N0QVFz3PkE5ChQAHNN5l/cevJSqzP6Nl6MrmQq6KQuvAcdgVAeeou9XpRU/V/puhaYKQZy9cKQZp43IJfoisn0Chqo2Zy6zv0lqefuiCE=
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:21 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::35) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 11 Nov 2026 01:41:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:12 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:09 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 13/74] drm/amd/display: Initialize DMUB LSDMA ring buffer
Date: Wed, 11 Nov 2026 09:28:19 +0800
Message-ID: <20261111014100.3596072-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7c3969-076f-4acf-8c51-08df3f94e387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|30052699003|261009223027099003|3023799007|10067099003|261026121527099003|261026140227099003|261102123227099003|261021121427099003|261028144727099003|261022105027099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GNOrYYw4ttn3WC1HW/Ts1fGVXIRe7mKgbJs/3+/+xUxBK28fFkG71Wr7m9EkLbmLTOzs1s9IJ40Q8lAWJzCwKj+gY1Czp/TvqnEE7EYz27veOGBg6wFeritpERUcFYxn1ZBaB/Nvxpo4lWzNE5AY67ezFJeokdM+nxqRxl7Nw4J++ctPS++RdkGLEEfeMx5fDGXBgI1Ecpqd0i9Hxt+7qkUreN5EfYW97pBNr8EylTV+glJzrxbqpaRFQirN0kWDYbW0Ulj4jWHnQqbtD7/0C1/V65pM5fmcxfkHYM3I+fOpR1dmXYKnt1b0itiGIM7SoXC+Ra0LBynvmrDqtOLxuSrAq+jC/rshHPrh/FGLVKMzJi/VdtMT2Fl+/GX6DASE8JjtrqHgXGb9dWGNuiFh/cPo21o/ZD09Dn4gXY24vGunQoJubHiwbo18lOhmfJCt8dZ4d3VpxT1TTkki2fY7WlGKXPnlZ/C46CYFJm/ByWNOjAYljFEnTfKLm2RuYqddTna0V9OE2lUFGmiAaOe+uM/Rvh6hKK9Mqbm1Y92OND1k0/XdKOAS6e4eFqGOvxfV29ubz7CcCxfIhbBHSfR2gSh1Hc+Fg3Dnz8eckZaaUCPH+4hcBiYtJd5bnDDK7MbXrLOziOrz1PGdP2xrbgG8fEQxDxmXeL3EQQxSoTe/8YE3md5jOmy/TsQbQDwEy7T5lHFHHGFf78dSRE+uyOIHIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(30052699003)(261009223027099003)(3023799007)(10067099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021121427099003)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7jxWNhx23McMitMSEWFC8m90ZmPac0q+5f7c6QUvBiTG5wIZiRF5BmCzs1YzngYyHDY0s1NKdC5JTWQF344N+6iB5A6STniEEz92Sk2+wAOIxh9Zi5D78EvgTT4wiYMMcu4NeQSYhp1TtwXwGKGnEiNIqSNwQ9m9o/oUEdU6bH4PxjsD8QE8YAKdXXgakD56vSTh3U1Inpf8BfxuLtP9j4V6DnsUboVv+5j72xASnHlq5DH/M+W0Qir/E29tCOaV51YB0DtW/8FyiOlTskO4XNk9fvcJfecBkv0muWoly33sLFYh456qXMkoZyIqgHt7O9vvnWwbDMr0QVwr+DURHGZrcbVepMmK1AHV0Aywk52N95ig1sC+7O0LDmz/CiC7ayDDcvnbygbeNmgJfV+T6rxaV0vCV4U7HppRfGXINgALnYhmeMnJbAABNw3ozwzE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:21.3899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7c3969-076f-4acf-8c51-08df3f94e387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
DMUB uses LSDMA for alt-ch aperture copies.

In dm_dmub_hw_init(), query DMUB feature caps first, then set
lsdma_rb_fb from DMUB_WINDOW_LSDMA_BUFFER and call dmub_lsdma_init().

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  6 ++++
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 31 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 0ea8f9a582cc..d655ae8bbb52 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -382,11 +382,17 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
+	/* Load DMUB caps */
+	dc_dmub_srv_query_caps_cmd(adev->dm.dc->ctx->dmub_srv);
+
 	/* Cursor offload has to be enabled; prime it on every DMUB init,
 	 * including post-suspend and GPU-reset.
 	 */
 	dc_dmub_srv_cursor_offload_init(adev->dm.dc);
 
+	dmub_srv->lsdma_rb_fb = fb_info->fb[DMUB_WINDOW_LSDMA_BUFFER];
+	dmub_lsdma_init(adev->dm.dc->ctx->dmub_srv);
+
 	drm_info(adev_to_drm(adev), "DMUB hardware initialized: version=0x%08X\n",
 		 adev->dm.dmcub_fw_version);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 2e273dea17ef..b48c96ec4250 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -70,6 +70,16 @@ static void dm_test_dmub_init_reg_offsets(struct dmub_srv *dmub,
 {
 }
 
+static void dm_test_dmub_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset)
+{
+}
+
+/* The fake firmware consumes inbox1 commands instantly: rptr tracks wptr. */
+static uint32_t dm_test_dmub_get_inbox1_ptr(struct dmub_srv *dmub)
+{
+	return dmub->inbox1.rb.wrpt;
+}
+
 static bool dm_test_dmcu_init(struct dmcu *dmcu)
 {
 	return true;
@@ -99,6 +109,9 @@ static struct dmub_srv *dm_test_alloc_dmub_srv(struct kunit *test)
 	dmub_srv->hw_funcs.is_hw_init = dm_test_dmub_hw_initialized;
 	dmub_srv->hw_funcs.get_fw_status = dm_test_dmub_fw_ready;
 	dmub_srv->hw_funcs.init_reg_offsets = dm_test_dmub_init_reg_offsets;
+	dmub_srv->hw_funcs.set_inbox1_wptr = dm_test_dmub_set_inbox1_wptr;
+	dmub_srv->hw_funcs.get_inbox1_rptr = dm_test_dmub_get_inbox1_ptr;
+	dmub_srv->hw_funcs.get_inbox1_wptr = dm_test_dmub_get_inbox1_ptr;
 
 	return dmub_srv;
 }
@@ -650,6 +663,23 @@ static void dm_test_dmub_hw_init_success_fake_dmub(struct kunit *test)
 	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dc->ctx->dmub_srv);
 }
 
+/**
+ * dm_test_dmub_hw_init_lsdma_buffer - Test hw init assigns the LSDMA ring buffer
+ * @test: The KUnit test context
+ *
+ * dm_dmub_hw_init() should point the DMUB LSDMA ring buffer at the
+ * DMUB_WINDOW_LSDMA_BUFFER framebuffer window.
+ */
+static void dm_test_dmub_hw_init_lsdma_buffer(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+	struct dmub_fb *lsdma_fb = &adev->dm.dmub_fb_info->fb[DMUB_WINDOW_LSDMA_BUFFER];
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.dmub_srv->lsdma_rb_fb.cpu_addr, lsdma_fb->cpu_addr);
+	KUNIT_EXPECT_EQ(test, adev->dm.dmub_srv->lsdma_rb_fb.size, lsdma_fb->size);
+}
+
 /**
  * dm_test_dmub_hw_init_no_hw_support - Test hw init returns 0 when HW is unsupported
  * @test: The KUnit test context
@@ -1917,6 +1947,7 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_hw_init_no_fb_info),
 	KUNIT_CASE(dm_test_dmub_hw_init_no_firmware),
 	KUNIT_CASE(dm_test_dmub_hw_init_success_fake_dmub),
+	KUNIT_CASE(dm_test_dmub_hw_init_lsdma_buffer),
 	KUNIT_CASE(dm_test_dmub_hw_init_no_hw_support),
 	KUNIT_CASE(dm_test_dmub_hw_init_bss_data),
 	KUNIT_CASE(dm_test_dmub_hw_init_hw_init_fails),
-- 
2.43.0

