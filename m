Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0CDC982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5073310ECE0;
	Wed, 16 Sep 2026 17:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmIP3qw5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DF310ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUaoYKjAXIFmlO+aQoDl9ikZ+Qq8jQP2BTZeV0N4N7tylKNvzpN/p5yoZYEaw5L2gd8SaV5NiRexzo5ABkAVuvh2vy8oGe9BlG9TiPNwwjVYwZ/ioWtDXFdGtBnXmQmsRyO2La8FiMCFQSW8PotTet5seVYmBwyd2cXTzIzRamP/SgNZrieNyXgybe0SUAxa41fLbF0da6YYPdIlGxELzYCYMgSxLMeJEwUpkKgFI/tLvQfOzv7dv86qrJm1QvVLpVh1T5Q2i01VOWVSVVDYgBO8PkUBo8+q42VlhJTGMrMBJdkvUqphP+RgDVAT4BQ3rCNpQzCf80HcTjprrCmPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/Q8QT74Y6+RXppxB5YgA1lTmnXs71AUSjihZAj9nZM=;
 b=qtp4d48y47mhyT3cEi3LH7JZjQM/SRa55h6kQfP/x01mUawSpAM6DHLZ4SfBld80V57aoFto+e7RAV7OI6Wq5ld7ZG1brhj51Mi5LMT7KwP0Z4ZgBlksZWxSbPP9u73KcQmirTGLbsZ1dtSxwhrbP8u4mi5l1tb28soX/Bf3eHgmKqRvl/VE19/3v0/5WQFzYos5eHXThYsHtrm7sQa4Aia6IM6SxhpaLJY1Vy37Cq97pdxZRjo2hSTTJQID8F/E3m8frJrj+p5sEvwBamg+OOzBPsoMgKB2y5CiBPoleOlD8peVQN3vLT+GWSPNFxhJkWn+UinKVcX+uZb+le/jNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/Q8QT74Y6+RXppxB5YgA1lTmnXs71AUSjihZAj9nZM=;
 b=EmIP3qw5pnMuR7DJJguuA79wOpP5DflKhsAlmDMRLVJ99tXBykh5Pu1/2CkgM2xx3YUkbdyS0zrX/UYGO3ZKeYakedTUM2pyOAhDRR0uk6O/Fq6j4Qms1IGhW+RcHwotPq4btRduc5Gzy0gOmOx4FJFbyWMyyP3B/Z9Bv0cV80w=
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 16 Sep
 2026 17:53:02 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::75) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:02 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:47 -0500
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
Subject: [PATCH 44/64] drm/amd/display: Fix KUnit CRTC warnings
Date: Wed, 16 Sep 2026 13:51:59 -0400
Message-ID: <20260916175301.368306-45-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 48281ee4-85f0-40dd-61ce-08df141b5a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: SL5ETq1IVtIqPNOvHJP2m0OBZL2z6T5DKhNOyhNKydoa4kOPO6UkKEp8cvOiMfb/fdf07xoLqdUUBn6Cz4Pl+u9GmUT7fQUSRcKIQCu8PzIfGk+0VJFcVNSSVS8PCuPkkTbNh3nw6rz/x4W5jeoAxFj/si2NyAFIcdDAF+Vn8F9PpsWWS0NDitBLs1OgHPSeNxKgeqh0+/sURrnq/N0yUJOLtXa72YDtoJ32dQfiepOdX+aaTq5qifAc3HozipqtcntXIHW7NPOX1mASxEWDJJktIbHCGGH3seZTcAy9Ef0NXm3cu9ePigKkF/C5UJXLScOb0a/cEys7NxdxmLcc0TPNfn4KsXQ9MMGGZKyn0K+d1k3CbhoKH71KyOXacYM9lE5jBAMcgyZ+A+ITNZGrczhbYgim/dc/U+hKlXBK0e2wBFj1yl4cdIoCA9G15OY8BG0JA/ERxyaM+hpQ6El3i1ZTzH1Yv3AxfwSuaGv1juYcoxe3CjRku2kHECvDyb9VJRqzQRmz1vnpfNjiDN0uH8FArLbNVfcxdGDh2FRevJscR7lA35Qi8s7RW/Vpxxmx/QCZmCgGXdYPQjTANTI3lvPgomiIx51MX4N2M3eniqpgHv+Gocn6N4/RE8eyle/tH43bkOmzfgsByCrtPDTUd1v0OawA6mJws+yKPoGXaGMJhvAaZrspF7LwRDXICjb4Agoo5Sh36y1/r1XxbXtDrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EvYF2wQlOAy6Kt0yWvDD+mFxumDJCY9VNfzhU8dvbM+efKuxQHSsK/4nqmY945cPMxN67RQGYCHG2I52boRTFaCo+2Y6d+18bCvF6AdY5V2WMesIW/f75FeEDkmm1n2yCF+Zns15PrhBieuhA9hMpbQZXVAROdBKShLsdHWPVseWba0WoB0MFi2dOzJkL090YGA6+UEunanJai6cUiUOibRn3kM+2ztU8P6oJtx6KfK7grqtqBB13Tqy7S5hNUWQdekylyDzjha3M9E8Ev15SShm8UGIpr49lKwBzfaXLyxgxOUvMgVhMEBEBHmM79T9WaJUdPp4JPYpJOS9Rm1M13xUwAhnegA+6vr3OPcNGF9bk1cE/H+OO6j9UqMClCMevxkXKjrK+CUj5JaeGQiN+2EdjodaOfLs9WB/c2eCZ55tvmn0NuruAV4Z9omPdMF0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:02.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48281ee4-85f0-40dd-61ce-08df141b5a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

[WHY]
Incomplete CRTC callbacks and vblank teardown cause DRM warnings in
CRTC tests.

[HOW]
Provide the required CRTC callbacks, link fake CRTCs for vblank lookup,
and register cleanup actions to disable vblank before unlinking them.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index f9457fc9e31b..4c379adfec85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -877,10 +877,39 @@ static bool dm_test_crtc_get_vblank_timestamp(struct drm_crtc *crtc,
 	return false;
 }
 
+static int dm_test_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	return 0;
+}
+
+static void dm_test_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+}
+
+static u32 dm_test_crtc_get_vblank_counter(struct drm_crtc *crtc)
+{
+	return 0;
+}
+
 static const struct drm_crtc_funcs dm_test_crtc_funcs = {
+	.destroy = amdgpu_dm_crtc_destroy,
+	.atomic_duplicate_state = amdgpu_dm_crtc_duplicate_state,
+	.atomic_destroy_state = amdgpu_dm_crtc_destroy_state,
+	.enable_vblank = dm_test_crtc_enable_vblank,
+	.disable_vblank = dm_test_crtc_disable_vblank,
+	.get_vblank_counter = dm_test_crtc_get_vblank_counter,
 	.get_vblank_timestamp = dm_test_crtc_get_vblank_timestamp,
 };
 
+static void dm_test_crtc_cleanup(void *data)
+{
+	struct amdgpu_crtc *acrtc = data;
+
+	if (acrtc->base.dev && drm_dev_has_vblank(acrtc->base.dev))
+		drm_crtc_vblank_off(&acrtc->base);
+	list_del_init(&acrtc->base.head);
+}
+
 /*
  * dm_test_crtc_arm_irq_src - Prime an IRQ source so get()/put() short-circuit.
  * @test: The KUnit test context
@@ -947,8 +976,13 @@ dm_test_crtc_setup_enable(struct kunit *test, struct amdgpu_device **adev_out,
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
+	acrtc->base.funcs = &dm_test_crtc_funcs;
 	acrtc->base.enabled = true;
 	acrtc->crtc_id = 0;
+	INIT_LIST_HEAD(&acrtc->base.head);
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_crtc_cleanup, acrtc), 0);
 
 	link = dm_kunit_alloc_link(test);
 	stream = dm_kunit_alloc_stream(test, link);
@@ -1783,6 +1817,11 @@ static void dm_test_crtc_handle_vblank_skips_when_flip_submitted(struct kunit *t
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
 
 	acrtc->base.dev = &adev->ddev;
+	acrtc->base.funcs = &dm_test_crtc_funcs;
+	INIT_LIST_HEAD(&acrtc->base.head);
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_crtc_cleanup, acrtc), 0);
 	acrtc->event = event;
 	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
 
@@ -1819,6 +1858,11 @@ static void dm_test_crtc_handle_vblank_completes_cursor_only(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
 
 	acrtc->base.dev = &adev->ddev;
+	acrtc->base.funcs = &dm_test_crtc_funcs;
+	INIT_LIST_HEAD(&acrtc->base.head);
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_crtc_cleanup, acrtc), 0);
 	acrtc->event = event;
 	acrtc->pflip_status = AMDGPU_FLIP_NONE;
 
-- 
2.55.0

