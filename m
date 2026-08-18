Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D5C5DF8A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFAC10EC9F;
	Tue, 18 Aug 2026 20:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkjbGD1P";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 266D010EC97
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVWATsiaVAFfcm2jLxhPgC5fcNTn/uuLMbeGBsKMGFb1urMs1O2yLh2TDsNmSHbfrAekj13Tt/EfWo/G7z1Gv3Cb+NUffypjL1OpEY5Qprc4cuSHaADVZo85TVZVf7d9XFtTkaFWBoKjPTmYaHkH2ALc7arxdrCiUxgIGqD8sbnhqrZIKYiej3mIMiK7fde9FmPI8L8lVgJr086yblG4GJbzoGab/ARVZy2yHs09ZyXfqjG/VoOILbYj8tfC++RXt5a74OUxogm84IpCKMUCxneY6xQoZEA6z4mr3G2rc4ZwB3mNVaT9LsBxR/l0bF8SZ+Wta0+NCLytzhv+bem/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCmpodJ+lg1MZY/X20G1+UY+M+8GDuPplSjWRf8CdvU=;
 b=sWQj1G1IXHRUduzfBK5/0jotlQADw/zttgdSGJp52g/i97bWdhswJdsqCcb9NHGHStOfuDO7ezvCmm1XKBfnARixagGEgCmzNwHYgox04BV2Q6rMQWm0Exn6jGff+9Swoe2EIsnkdEY2b0YEIr/rGQ5u1rqwpIBaZzfeSjhYZ4r5ZvTHZuqRUv2MRYyQ8KNmaj1ZpId4Afav5HMEa/4ubz2VGedu9vQSTaKIeFnDo1wMzBk2dHxgAg8ZskLww6+ZqqLtaGnQpMvb/jevOOn/IMoqoVf88DDhV4l4XBxdLOD92a5hf4SVOr1GUZwj7TNHNRxCIc+rTy9128hXfiHcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCmpodJ+lg1MZY/X20G1+UY+M+8GDuPplSjWRf8CdvU=;
 b=xkjbGD1P2UXxnuDt4dGkgX/ZPQhdpT3NWZlrRKppAuo4BqSxAgKwulZpki8un+Dkc8Qq2wzyl7uxB7l7xUZq8LA0cVRFjWckdNDrkF50wVUoMftvJBXE5BFRZDMvNGcdaDwvAkjhpejgBgiuuccHCPv7XsfBdpIVOK/s6SR/vuk=
Received: from BN9PR03CA0896.namprd03.prod.outlook.com (2603:10b6:408:13c::31)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 18 Aug
 2026 20:22:24 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::25) by BN9PR03CA0896.outlook.office365.com
 (2603:10b6:408:13c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:12 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:11 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 26/82] drm/amd/display: Test DMUB reg callbacks
Date: Tue, 18 Aug 2026 16:15:18 -0400
Message-ID: <20260818202139.4172592-27-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc66c32-f528-4d6f-3fe5-08defd6669b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|22082099003|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7bPp7o0Ggu6UT8R0GetvhZAxRrk8sA7bQa4wmwINzxG2UyrdA60UWkipXuGElVOerblbhf+ot1ON9QfiR6YwT+bw/Uowy+PZxIZ52mUXxlfM5S84UBunmQ18eRtUks9nSFAW4R0xGOYtqSC2tCMxh+l/MePOMCvagarR1EdEn7N2PQsAxcVL1vqnXHoxwuQl8YTGDgiLsLis/TbA5VADpjh2SGWnGDpq2+u6IxYCza2JkRKz/zvqK5rljCETil2KbflyNum5GanW6h23IP6jZubh+JiJbCxfS1knfZlP32CbzNnoM162yvSstaGgIbgIYTCdtGqgbJ25DsntC4UQ0DfhXZO2UgvrTpYwlbzFKkIUjC8YAv+b4ZSH0cQN1sAl8MFA/9aLimnIvRgF444m5ARerBW8Nh3L96u58/Zk3GS8ToNCwLN3g9fcDO9PuOVIXVsnkVqQLEoSjfNfP1MszniYJfcHXAUw89X8yb0bfmAph0x+JWLWszogojObiElwTeXSoDswsRdXcBJ5x3RkASfyrTw08QS8Qm4gi6QXD2i4+jZR34pZzmFB12TUHcCUDPGdT6WY1LNq0ot6QwNvnirT+CzPSPscgKkjimhJ9bupfYnk2aFvNb1JZhD3xfLMHOZ8zlBtNZBb7pAXXz8ACatnFlSqaXU1WKiw+Xb0rtcRwDzMGbV0NibE5OTUfxx9HDmUelSWPVhQI/iRqyBr3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(22082099003)(10067099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QDi07k+4a8MTvDkNuHU9HOs6alxvEQhhJQKOo9h7gPG03pt/6bWC77FFTjjtpCfLkJTenUP4XvacH1KPsKis0V4ROXc8pDa47zOL8S2VpfbPe7B8CR88KREsvYSaQKM42IteDQtJ59N/zyACtwknx1VLkkVyUIpdd9s6rcmc03F4rbg2EWG1TVY6MKULlk//hfyl3PSgwVmryIBIcET+k7O6oiObNg8A8zXibf1/CRfgO4/pVe2a2dcUzY2qFI3LCDnTaoL8ADdeCei16JeC4GyjgjnQrP4zxlC+3/iSEjU5uYWVOrIAL3t1A/v/w8dBQbSirKMJwee8Q+WrAyy8eNEDUYVsmEZcsWxgIQqIUBIQr5ut0HVBbU3JWJsPJtTJnRCniTyM+dRjMxOxElPhX+SkJpFcmYpDujxpme6icth7CrzYfeI9FmL2OO0R1qPN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:23.4870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc66c32-f528-4d6f-3fe5-08defd6669b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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
Add KUnit tests for amdgpu_dm_dmub_reg_read() and
amdgpu_dm_dmub_reg_write(), the register accessors the DMUB service is
created with.

[HOW]
Both accessors reach the hardware through cgs_read_register() and
cgs_write_register(), which dispatch through the ops table at the start
of struct cgs_device. Add a fake CGS device that records the offset and
value of each access, so the callbacks can be driven without real MMIO.

The test writes a value through the write callback and reads it back
through the read callback, confirming both forward to the DC context of
the device passed as their opaque user context.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 95 ++++++++++++++++++-
 3 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9ff25bc8ee5ae..29990cfe4265e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -468,20 +468,22 @@ enum dmub_ips_disable_type dm_get_default_ips_mode(
 }
 EXPORT_IF_KUNIT(dm_get_default_ips_mode);
 
-static uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
+STATIC_IFN_KUNIT uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
 {
 	struct amdgpu_device *adev = ctx;
 
 	return dm_read_reg(adev->dm.dc->ctx, address);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_dmub_reg_read);
 
-static void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
-				     uint32_t value)
+STATIC_IFN_KUNIT void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
+					       uint32_t value)
 {
 	struct amdgpu_device *adev = ctx;
 
 	return dm_write_reg(adev->dm.dc->ctx, address, value);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_dmub_reg_write);
 
 int dm_dmub_sw_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index 31d5f8c265c0d..735e2b4299521 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -73,6 +73,8 @@ struct dmub_cmd_fused_request;
 void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev);
 void abort_fused_io(struct dc_context *ctx,
 		    const struct dmub_cmd_fused_request *request);
+uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address);
+void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address, uint32_t value);
 #endif
 
 #endif /* AMDGPU_DM_AMDGPU_DM_DMUB_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index ead43eeb38c77..4bba282abd69d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -1347,6 +1347,86 @@ static void dm_test_abort_fused_io_no_dmub_srv(struct kunit *test)
 	abort_fused_io(ctx, req);
 }
 
+/*
+ * Fake CGS device: the DMUB register callbacks reach the hardware through
+ * cgs_read_register()/cgs_write_register(), which dispatch via the ops table
+ * at the start of struct cgs_device.
+ */
+
+#define DM_TEST_GPINT_STATUS_MASK	0xF0000000U
+
+struct dm_test_cgs_ctx {
+	struct cgs_device dev;
+	u32 last_write;
+	unsigned int write_calls;
+	unsigned int read_calls;
+	unsigned int last_write_offset;
+	unsigned int last_read_offset;
+};
+
+static struct dm_test_cgs_ctx dm_test_cgs;
+
+static uint32_t dm_test_cgs_read_register(struct cgs_device *cgs_device,
+					  unsigned int offset)
+{
+	dm_test_cgs.read_calls++;
+	dm_test_cgs.last_read_offset = offset;
+
+	/* The firmware acks a GPINT by clearing the status nibble. */
+	return dm_test_cgs.last_write & ~DM_TEST_GPINT_STATUS_MASK;
+}
+
+static void dm_test_cgs_write_register(struct cgs_device *cgs_device,
+				       unsigned int offset, uint32_t value)
+{
+	dm_test_cgs.write_calls++;
+	dm_test_cgs.last_write_offset = offset;
+	dm_test_cgs.last_write = value;
+}
+
+static const struct cgs_ops dm_test_cgs_ops = {
+	.read_register = dm_test_cgs_read_register,
+	.write_register = dm_test_cgs_write_register,
+};
+
+static int dm_test_dmub_hw_access_init(struct kunit *test)
+{
+	dm_test_cgs = (struct dm_test_cgs_ctx) { .dev.ops = &dm_test_cgs_ops };
+
+	return 0;
+}
+
+/* Tests for amdgpu_dm_dmub_reg_read() and amdgpu_dm_dmub_reg_write() */
+
+/**
+ * dm_test_dmub_reg_write_then_read - Test the DMUB register access callbacks
+ * @test: The KUnit test context
+ *
+ * The callbacks the DMUB service is created with must forward to the DC
+ * context of the device passed as their opaque user context.
+ */
+static void dm_test_dmub_reg_write_then_read(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+	struct dc_perf_trace *perf_trace;
+
+	perf_trace = kunit_kzalloc(test, sizeof(*perf_trace), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, perf_trace);
+
+	adev->dm.dc->ctx->cgs_device = &dm_test_cgs.dev;
+	adev->dm.dc->ctx->perf_trace = perf_trace;
+
+	amdgpu_dm_dmub_reg_write(adev, 0x1234, 0x0BADF00D);
+
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.write_calls, 1U);
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.last_write_offset, 0x1234U);
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.last_write, 0x0BADF00DU);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dmub_reg_read(adev, 0x1234), 0x0BADF00DU);
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.read_calls, 1U);
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.last_read_offset, 0x1234U);
+}
+
 static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	/* dm_register_dmub_notify_callback() */
 	KUNIT_CASE(dm_test_register_dmub_notify_callback_null_callback),
@@ -1412,7 +1492,20 @@ static struct kunit_suite amdgpu_dm_dmub_test_suite = {
 	.test_cases = amdgpu_dm_dmub_tests,
 };
 
-kunit_test_suite(amdgpu_dm_dmub_test_suite);
+static struct kunit_case amdgpu_dm_dmub_hw_access_tests[] = {
+	/* amdgpu_dm_dmub_reg_read() and amdgpu_dm_dmub_reg_write() */
+	KUNIT_CASE(dm_test_dmub_reg_write_then_read),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_dmub_hw_access_test_suite = {
+	.name = "amdgpu_dm_dmub_hw_access",
+	.init = dm_test_dmub_hw_access_init,
+	.test_cases = amdgpu_dm_dmub_hw_access_tests,
+};
+
+kunit_test_suites(&amdgpu_dm_dmub_test_suite,
+		  &amdgpu_dm_dmub_hw_access_test_suite);
 
 MODULE_AUTHOR("AMD");
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_dmub");
-- 
2.43.0

