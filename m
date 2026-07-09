Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672AEC4450C
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4B110F703;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lUVLEFUO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2D510F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAUnw8lElgCM2thoBLJi02dK9NhV5Jp8ztH4jRSzh34w+nHTCG0Hsspc2mBmd6fNCm/hIBqFG3pZDgWAPyZaAePLh4mn4DD1FHgY0oXVJ5t0ZkoUJj0LFsVAvhzlTWkuoS6nmqTxnV3NqTvPeeY3T01a+HijfqgsACVYpxGczTJmuEH9jUlomOrrmJBOT3E1em/0W1IOV9Dz3uoppxNcQVEfn8Rajrw+lfPx3ZfCu84bg6mnnmqTfA9+2VOOGrF2wuGsXTZKtFVhNwqwSRyHOpuXT5C6wHOkIoYwR49tUlUovk1uhbm3VqSLAzj+Ae0YDx2HScBiMt60iPMDjyVw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKSIV8uMT2OdIViv/DzwYSbjsF4AoGmC9lb9hojnTa4=;
 b=yl8UEQRNgt+IwMmaWm1vvb9agNcGyoD2iIe4fVPBkrtQjxD19M/rpp6LihtyiDFN6GWMNYms7Ze6Ufzcg7jTxSuV6FmUu1Sny1Gy3fhZW/K/ozama0kfHs9hgxg77YlV+EAe+JtmQcnNbsnkkkXfU8V0CLd7N0hx8Vnwz917Qh2hIKwBhFfLaESZ/5XTFEYbIriSJkqUo9TrPi7cPFXAN75rV90nyNsWTHf62lpfdSEvPLORj1Jddy3dElmjy7axhSHviiXOk47t6jlbpxDDGJuCUqugKJp74FDmvhOnyXAVi8PvdG7XPrGBn6LrCcUvMkY9mJE8ze3MYVEMimEkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKSIV8uMT2OdIViv/DzwYSbjsF4AoGmC9lb9hojnTa4=;
 b=lUVLEFUOBRipTZLfSSik2g2Eu93YgeSko+okv+GZHiGsdQ/kvsMjzoGkRpj9GhS5Fvc3QD0JOl9sTUdDeYeq3cgVIMuf2JHFV74kZEzy5DEwOoLY2kAMjEhBa2h4CYmzdbKfvKFeguBX3L8BlwKhKtNSnSqKS4ifr/ks0Iv1dQ8=
Received: from MN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:52d::26)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:35 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::88) by MN0PR04CA0015.outlook.office365.com
 (2603:10b6:208:52d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:35 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:24 -0500
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
Subject: [PATCH 63/80] drm/amd/display: Test backlight level readback path
Date: Thu, 9 Jul 2026 16:48:31 -0400
Message-ID: <20260709205936.5719-64-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a3a779-0557-4147-3354-08deddfd66f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jHqcLuhG1XKFfFqxIkrUQezprLPPCDCykYWczxbK/FXd5FIpANZFazwaMWGaxKdepikx0WcgmxOdkajnHkw/ZPK6nxHCPRRkOMKIf9gz2THQs4+DLmOPh2Uk2TaDftfJMdOYX8Gjij1IiCrOosJbUSnK22Tdw8XuXqIRgo3Wg8+0lWtPLSzIxJdl+Dhwkme0Mx/ua2kFumfY0j2pbO7139kK5CDJ+f6d0MESXfLrZQCGkI3vSMPB06cHLX3kjl57CgS/geHh5ieUDywTe1RB12E76thJtv6jCq9dMTwfd7gKNtGtvvSBZS/zRxgfouHfFwSiGhA9FMSZrDFUcnSMKwmho8XenAue5wcPfK1T0Gpl5ZngkEZNNFCLVW9vq3/De6poauZRdNtxIcoYp6vHOaBE9WAJEdBUPZzf7ZY4xgfyIPJKVgGRwzC+VXPVkspqlIsdJHYxbd9bk2PWLm/Hk1GYRsEWO55No8Iha8Ms51nXsRzhwg3on6mNQgRLi+I7fYwJrALaPFd1n84A1jiy5HLnZI3hs3nJ+Oy7QCMsDm6rxl+prxDxtf46V3pix7hwrmwCAIshfzERjhX+oR/u7+exIpN/bsv89PEs5R5cBEvHhe6pIcLQx2+qbdBATZPIKNJJtrCht/XwsGF/NZRbd3CGW7KZ+qjaMHv7c0dwLm12OD1iXCgnRctg4VfTchKslBEERBJSfgIcBLQzRzW5LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w42GpzOVJjzvSPuUMndr/bFGg61GspDlN+towUO3cso5RQLFwwu2Ly1R3sjlSo7yQ0diS72fcvu+sUTOpRkTIlGFjM9KVXwREtMSnKO0xpWOy9RZdO/lDxVtohwrBA+VrT5hL1RHt+nhT6XdfugOeSHPOfO2BQ8StRkfBytLX85PK5hBtHhh5lC87JH9TcrJLCchLNbKk8olQazGFxf3LBjudttd07Q3i3hMEKeaGV6f5/fyvTXTcXUkJ4bwbZ0wZt8WLku6c/Bvocc4jW/uUUM7uTG1ZDYXQEDtCdwcCiQ0EpxqyDQV5DD4PiO+kwlMkbpDbbupVZaOQh5nYi3wJFYvlTZgVeQ9z7fuNi2TCku0EDayu7PSNojcY2bC7xoenfRdDMEWz/5TRAqwL6nQfVkh5fsL8GsHNRRic3Ha+wSisdJpNEiiW34uqpIrMoo4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:35.6445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a3a779-0557-4147-3354-08deddfd66f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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
Add KUnit coverage for the backlight level read path.

A faked link_service vtable returns canned PWM and AUX brightness values,
letting the tests verify both the successful readback and the
DC_ERROR/AUX-failure fallbacks to the cached brightness, plus the
get_brightness() device-index wrapper.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   9 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   2 +
 .../tests/amdgpu_dm_backlight_test.c          | 156 ++++++++++++++++++
 3 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index d35b90912bd2..452e772ef136 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -362,8 +362,8 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
-					 int bl_idx)
+STATIC_IFN_KUNIT
+u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
 	struct amdgpu_dm_backlight_caps caps;
@@ -387,14 +387,17 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 
 	return convert_brightness_to_user(&caps, ret);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_level);
 
-static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
+STATIC_IFN_KUNIT
+int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	int i = amdgpu_dm_backlight_get_device_index(dm, bd);
 
 	return amdgpu_dm_backlight_get_level(dm, i);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_brightness);
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 5fbaf67369f1..7b417c79980f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -54,6 +54,8 @@ extern const struct attribute_group amdgpu_group;
 struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
 						 struct dc_link *link);
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
+u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
+int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd);
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 732ac8db742d..10965306e29d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -16,6 +16,7 @@
 #include "amdgpu_dm_backlight.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 #include "amd_shared.h"
+#include "link_service.h"
 #include "dc/inc/hw/panel_cntl.h"
 
 struct dm_backlight_connector_fixture {
@@ -290,6 +291,155 @@ static void dm_test_backlight_update_status_no_stream(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm->brightness[1], 3456U);
 }
 
+static void setup_test_link_service(struct kunit *test, struct dc_link *link)
+{
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	struct dc *dc;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
+
+	dc->ctx = ctx;
+	dc->link_srv = link_srv;
+	ctx->dc = dc;
+	link->dc = dc;
+	link->ctx = ctx;
+}
+
+static int dm_test_get_backlight_level_mid(const struct dc_link *link)
+{
+	return (0x101 * AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) + 1000;
+}
+
+static int dm_test_get_backlight_level_error(const struct dc_link *link)
+{
+	return DC_ERROR_UNEXPECTED;
+}
+
+static bool dm_test_get_backlight_level_nits(struct dc_link *link,
+					     uint32_t *avg,
+					     uint32_t *peak)
+{
+	*avg = 250000;
+	*peak = 300000;
+
+	return true;
+}
+
+static bool dm_test_get_backlight_level_nits_fail(struct dc_link *link,
+						  uint32_t *avg,
+						  uint32_t *peak)
+{
+	return false;
+}
+
+/* Tests for amdgpu_dm_backlight_get_level()/get_brightness() */
+
+/**
+ * dm_test_backlight_get_level_pwm_success - Test PWM brightness readback
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_get_level_pwm_success(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	u32 hw_level = dm_test_get_backlight_level_mid(link);
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
+	dm->backlight_link[0] = link;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0),
+			 convert_brightness_to_user(&dm->backlight_caps[0], hw_level));
+}
+
+/**
+ * dm_test_backlight_get_level_pwm_error - Test PWM readback fallback
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_get_level_pwm_error(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
+	dm->brightness[0] = 4321;
+	dm->backlight_link[0] = link;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 4321U);
+}
+
+/**
+ * dm_test_backlight_get_level_aux_success - Test AUX brightness readback
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_get_level_aux_success(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level_nits = dm_test_get_backlight_level_nits;
+	dm->backlight_link[0] = link;
+	caps->caps_valid = true;
+	caps->aux_support = true;
+	caps->aux_min_input_signal = 1;
+	caps->aux_max_input_signal = 512;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0),
+			 convert_brightness_to_user(caps, 250000));
+}
+
+/**
+ * dm_test_backlight_get_level_aux_error - Test AUX readback fallback
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_get_level_aux_error(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level_nits = dm_test_get_backlight_level_nits_fail;
+	dm->brightness[0] = 6789;
+	dm->backlight_link[0] = link;
+	caps->caps_valid = true;
+	caps->aux_support = true;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 6789U);
+}
+
+/**
+ * dm_test_backlight_get_brightness_uses_device_index - Test get_brightness wrapper
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_get_brightness_uses_device_index(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct backlight_device *bd;
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_error;
+	bd = kunit_kzalloc(test, sizeof(*bd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bd);
+	dev_set_drvdata(&bd->dev, dm);
+	dm->num_of_edps = 2;
+	dm->backlight_dev[1] = bd;
+	dm->brightness[1] = 2468;
+	dm->backlight_link[1] = link;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_brightness(bd), 2468);
+}
+
 /* Tests for amdgpu_dm_backlight_get_device_index() */
 
 /**
@@ -1460,6 +1610,12 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_set_level_pwm_programs_power_module),
 	KUNIT_CASE(dm_test_backlight_set_level_reallows_idle),
 	KUNIT_CASE(dm_test_backlight_update_status_no_stream),
+	/* amdgpu_dm_backlight_get_level / get_brightness */
+	KUNIT_CASE(dm_test_backlight_get_level_pwm_success),
+	KUNIT_CASE(dm_test_backlight_get_level_pwm_error),
+	KUNIT_CASE(dm_test_backlight_get_level_aux_success),
+	KUNIT_CASE(dm_test_backlight_get_level_aux_error),
+	KUNIT_CASE(dm_test_backlight_get_brightness_uses_device_index),
 	/* amdgpu_dm_backlight_get_device_index */
 	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
 	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),
-- 
2.55.0

