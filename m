Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45F3C4450A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E14110F6DC;
	Thu,  9 Jul 2026 21:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c14B209+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A99A10F6DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAXCMFjpEmAX8OgTG82QMxycBpMDvjSwkiWK29DlcnTxvMS7C/BiQlXqaozcROWCA5bZgDGTAuNgnXbUK6blaXJeylxyTaS0Q4Hrn7PfgxTKLPPl+owyKKSRMh78/d6jaExjkbF8D6XO9jvp6EGpBnAeBr7YXiEY6OUFiedJYyQskWf+XGAYYgEnhBJY2u0DkhNhs9YHRyuG1d3IcAhunCaLrS1PccEfDhHcQg4w1TWWaRljLcyuETpmZFd+SSqj1kcFIUwxKVGJYFR2hbjIHAouIL7LM7rNcxMDPgDONkyBb3DM9rPRvnvt8q52G9YUMkI/odpPJ2OxCvLZNd/NyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENmvSqSg7pMTJFGrYTxwe+kX9ArWaQWqlrSvQHnM9Eo=;
 b=RWekRvbPMnE4Q1q21GLrWImpi+cXl83eSYdbXE2C4MVuCsuKZZ2GY2oI/KhAGSvye4ko69vm7BBhiL1Q6bJ4scRW+gkJFxMiSZ3X813BbaTxmy8csPiZPUDG81w9NFIue5npV/LVShzO2yGFq3+cD7A57j1ynHVh3uOQPlQdocyc//LUXuj93iriKsMzjyqYFdI8mvbyDPofR2KVDCT1tTZgvV1FmgerlJRRizDfV69/dJryYEt6BB4MzDWmfiBEHL/dqSB4HTf7pM+A80oZwWX3Q47uv7LYID2xh5ES1mhD3P1eHoIDdiZva5S7XM2VUpV1A9rgAn92vUpHxVPzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENmvSqSg7pMTJFGrYTxwe+kX9ArWaQWqlrSvQHnM9Eo=;
 b=c14B209+LVHcFXqdvoaPQP5xwFs2rmEs4obwQpCdhRDc3iPzjI2C7MjtYxMCjBxZpTGK5+FxyAewANuKVi/9xZ/9tII3ZRPEoUd0zrxN4Bmh8u6xGEQ65chwiNs5ZOomYLsijM67nJkroqnUDlQDq63NtKK6loReaRvt45vmPuA=
Received: from BLAPR03CA0165.namprd03.prod.outlook.com (2603:10b6:208:32f::9)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:22 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32f:cafe::3b) by BLAPR03CA0165.outlook.office365.com
 (2603:10b6:208:32f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:22 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:02 -0500
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
Subject: [PATCH 35/80] drm/amd/display: Test high-IRQ and handler registration
Date: Thu, 9 Jul 2026 16:48:03 -0400
Message-ID: <20260709205936.5719-36-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff512fd-45bf-4885-d08e-08deddfd5f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: SIt4SzX7nHmVy9Uw2uAQRIPrw6QGbVY2vwxfFeHuXB5AQCs8jkEyKzqguUQ/Jkgq8dmNE/PMKsv8D2cqvxRpQ53yciGJ0VdPhOe5WfWp17Rb7oju1xhxNQpF7y9Vna/y7EWw3WRU+vIAvROIOABdn9kH5e53aq5/ZUrAndSqrGMN1HTmd6MvuKuNM8DKiGQMvWyMRuS08X1r6xC0jGFDUEGlcRVeSHpK9rMJS7fOLHllbRNJN0F7SeMsjoeSRUjvpk36wmjgnzfZk58sVVb55rvr0w61RDmvUMkApOXvvOmnMM1Lw0nwViw1Muz7BOJ4E/0sTEMmMkw0vbxr09qs8gdimuh52kMWD2WquguwBMYKw9vyUAu4/sFDosZGEp0rxQYf/1ETqDQxLs2vJ8lNJDMTnJBNzNzT7IyBYYN/NuJDdCuzUEkcc8Fj/wF3n/jYFME4ZNzWGMI40/AVY5xlxJKraf/aMz9QOMG7Gz2iqzewvj/SQcgPze1nFcYqfUOhCjwM0ZJoJHlcTJ9yPLb1GHM7+l7DanU2YZgLXhcXiS+fyh53TBHkBLWxKF/R9Wbs/2/M7yQ8Pz/t9Su+TUYVUnM37x2NhEkhDsqrTN+2J6uEv9+g1fy+b1PHv6zZVieRgOYoP6mabor1SZChgv7F0l/eNNjlaZ11kbvJ2xmkG/wOe4rjSeV6h2aqCRq28AFnRhuEJ6ARukTwhpz+EuD3Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MjHi0MBZ6T4mcPQTA0/aqHD+KPahM5QHBDCmqKg1E2wq+WHllq4pNN3JFWV5//aieC9dyfKpaN3fYstZEQyD+8IoLPYh2FrqU7ICFD7xq0l+xApdwrKUaPT6fMvs7SyuaVQ2m0ElBF0plUJWuOuT8dF7F1tls1FSz4lY9yQStNpmYrJ1KADfvLt3T2d/Tze2CbGFhWKxhOp7ugIUuXg4/sTyRhn0iTM2AHy4Xy53xPW1ZaDjAlrUMPXz4UdpxPWnRbOoHpC8cmgLOmYTJXSGDqX9BWCCKXdoNz7rUorV/uoHXVquZq6FJLa+KZqsImgy/+xwjpT8/1lMasSZus0LoS7tCVWOylzM2MKtb71J2qmz6NgKjTKm+A6PzUUF5IGwteQAPYVgllB+k4xFyT9cnZORg4La4i0JdvytjgHJTS6z9b3BAJ6xGs4jWqHdb4Yd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:22.4865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff512fd-45bf-4885-d08e-08deddfd5f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280
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
Add the final batch of amdgpu_dm_irq KUnit tests covering the high-IRQ
callbacks (dm_pflip_high_irq, dm_vupdate_high_irq, dm_crtc_high_irq),
dm_handle_hpd_work, the DMUB outbox1 low IRQ, and the per-ASIC IRQ
handler registration helpers (DCE110, DCN10 and outbox).

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  18 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   5 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 606 ++++++++++++++++++
 3 files changed, 624 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index e34bd3bbc2b8..dab970e064ff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1776,7 +1776,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_get_crtc_by_otg_inst);
  * Handles the pageflip interrupt by notifying all interested parties
  * that the pageflip has been completed.
  */
-static void dm_pflip_high_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
 	struct common_irq_params *irq_params = interrupt_params;
@@ -1872,6 +1872,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 		      "crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
 		      amdgpu_crtc->crtc_id, amdgpu_crtc, vrr_active, (int)!e);
 }
+EXPORT_IF_KUNIT(dm_pflip_high_irq);

 static void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
 {
@@ -1918,7 +1919,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	queue_work(system_percpu_wq, &offload_work->work);
 }

-static void dm_vupdate_high_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_vupdate_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -1981,6 +1982,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 		}
 	}
 }
+EXPORT_IF_KUNIT(dm_vupdate_high_irq);

 /**
  * dm_crtc_high_irq() - Handles CRTC interrupt
@@ -1989,7 +1991,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
  * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
  * event handler.
  */
-static void dm_crtc_high_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_crtc_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -2088,6 +2090,7 @@ static void dm_crtc_high_irq(void *interrupt_params)

 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
+EXPORT_IF_KUNIT(dm_crtc_high_irq);

 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 /**
@@ -2112,7 +2115,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 }
 #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */

-static void dm_handle_hpd_work(struct work_struct *work)
+STATIC_IFN_KUNIT void dm_handle_hpd_work(struct work_struct *work)
 {
 	struct dmub_hpd_work *dmub_hpd_wrk;

@@ -2132,6 +2135,7 @@ static void dm_handle_hpd_work(struct work_struct *work)
 	kfree(dmub_hpd_wrk);

 }
+EXPORT_IF_KUNIT(dm_handle_hpd_work);

 STATIC_IFN_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
@@ -2166,7 +2170,7 @@ EXPORT_IF_KUNIT(dmub_notification_type_str);
  * Handles the Outbox Interrupt
  * event handler.
  */
-static void dm_dmub_outbox1_low_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_dmub_outbox1_low_irq(void *interrupt_params)
 {
 	struct dmub_notification notify = {0};
 	struct common_irq_params *irq_params = interrupt_params;
@@ -2229,6 +2233,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 		} while (notify.pending_notification);
 	}
 }
+EXPORT_IF_KUNIT(dm_dmub_outbox1_low_irq);

 /* Register IRQ sources and initialize IRQ callbacks */
 int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev)
@@ -2367,6 +2372,7 @@ int amdgpu_dm_dce110_register_irq_handlers(struct amdgpu_device *adev)

 	return r;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_dce110_register_irq_handlers);

 /* Register IRQ sources and initialize IRQ callbacks */
 int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)
@@ -2548,6 +2554,7 @@ int amdgpu_dm_dcn10_register_irq_handlers(struct amdgpu_device *adev)

 	return r;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_dcn10_register_irq_handlers);

 /* Register Outbox IRQ sources and initialize IRQ callbacks */
 int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev)
@@ -2585,3 +2592,4 @@ int amdgpu_dm_register_outbox_irq_handlers(struct amdgpu_device *adev)

 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_register_outbox_irq_handlers);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 7200d3754905..da698f224d85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -173,6 +173,11 @@ void dmub_hpd_callback(struct amdgpu_device *adev,
 		       struct dmub_notification *notify);
 void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 			     struct dmub_notification *notify);
+void dm_pflip_high_irq(void *interrupt_params);
+void dm_vupdate_high_irq(void *interrupt_params);
+void dm_crtc_high_irq(void *interrupt_params);
+void dm_handle_hpd_work(struct work_struct *work);
+void dm_dmub_outbox1_low_irq(void *interrupt_params);
 #endif

 #endif /* __AMDGPU_DM_IRQ_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index eb74883cb6d9..c356c2c836b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -184,6 +184,24 @@ static bool dm_test_allow_hpd_rx_irq_true(const struct dc_link *link)
 }


+static uint32_t dm_test_dmub_get_outbox0_wptr(struct dmub_srv *dmub)
+{
+	return 0;
+}
+
+static uint32_t dm_test_dmub_get_outbox1_wptr(struct dmub_srv *dmub)
+{
+	return 0;
+}
+
+static int dm_test_dmub_notify_count;
+
+static void dm_test_dmub_notify_callback(struct amdgpu_device *adev,
+					 struct dmub_notification *notify)
+{
+	dm_test_dmub_notify_count++;
+}
+
 static struct dc *dm_test_alloc_dc_with_ctx(struct kunit *test)
 {
 	struct dc_context *ctx;
@@ -200,6 +218,37 @@ static struct dc *dm_test_alloc_dc_with_ctx(struct kunit *test)
 	return dc;
 }

+static enum dc_irq_source dm_test_to_dal_irq_source_dce110(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case VISLANDS30_IV_SRCID_D1_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP1;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP + 2:
+		return DC_IRQ_SOURCE_PFLIP2;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP + 4:
+		return DC_IRQ_SOURCE_PFLIP3;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP + 6:
+		return DC_IRQ_SOURCE_PFLIP4;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP + 8:
+		return DC_IRQ_SOURCE_PFLIP5;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP + 10:
+		return DC_IRQ_SOURCE_PFLIP6;
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
+static const struct irq_service_funcs dm_test_irq_service_funcs_dce110 = {
+	.to_dal_irq_source = dm_test_to_dal_irq_source_dce110
+};
+
 static enum dc_irq_source dm_test_to_dal_irq_source_dcn10(
 		struct irq_service *irq_service,
 		uint32_t src_id,
@@ -274,6 +323,32 @@ static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
 	return dc;
 }

+static void dm_test_free_irq_sources(void *data)
+{
+	struct amdgpu_device *adev = data;
+	int i;
+
+	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; i++) {
+		kfree(adev->irq.client[i].sources);
+		adev->irq.client[i].sources = NULL;
+	}
+
+	kfree(adev->crtc_irq.enabled_types);
+	adev->crtc_irq.enabled_types = NULL;
+	kfree(adev->vline0_irq.enabled_types);
+	adev->vline0_irq.enabled_types = NULL;
+	kfree(adev->vupdate_irq.enabled_types);
+	adev->vupdate_irq.enabled_types = NULL;
+	kfree(adev->pageflip_irq.enabled_types);
+	adev->pageflip_irq.enabled_types = NULL;
+	kfree(adev->dmub_outbox_irq.enabled_types);
+	adev->dmub_outbox_irq.enabled_types = NULL;
+	kfree(adev->dmub_trace_irq.enabled_types);
+	adev->dmub_trace_irq.enabled_types = NULL;
+	kfree(adev->hpd_irq.enabled_types);
+	adev->hpd_irq.enabled_types = NULL;
+}
+
 static void dm_test_crtc_list_del(void *data)
 {
 	struct amdgpu_crtc *acrtc = data;
@@ -3217,6 +3292,516 @@ static void dm_test_register_hpd_handlers_dmub_outbox(struct kunit *test)
 	amdgpu_dm_irq_fini(adev);
 }

+/* Tests for CRTC/pflip/vupdate high IRQ callbacks */
+
+/**
+ * dm_test_pflip_high_irq_no_crtc - Test pflip high IRQ with no matching CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_pflip_high_irq_no_crtc(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_PFLIP;
+
+	dm_pflip_high_irq(&params);
+}
+
+/**
+ * dm_test_pflip_high_irq_not_submitted - Test pflip high IRQ early status exit
+ * @test: The KUnit test context
+ */
+static void dm_test_pflip_high_irq_not_submitted(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	INIT_LIST_HEAD(&acrtc->base.head);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = 0;
+	acrtc->pflip_status = AMDGPU_FLIP_NONE;
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+				dm_test_crtc_list_del, acrtc), 0);
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_PFLIP;
+
+	dm_pflip_high_irq(&params);
+	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
+}
+
+/**
+ * dm_test_vupdate_high_irq_no_crtc - Test vupdate high IRQ with no CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_vupdate_high_irq_no_crtc(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VUPDATE;
+
+	dm_vupdate_high_irq(&params);
+}
+
+/**
+ * dm_test_crtc_high_irq_no_crtc - Test crtc high IRQ with no CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_high_irq_no_crtc(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VBLANK;
+
+	dm_crtc_high_irq(&params);
+}
+
+/**
+ * dm_test_crtc_high_irq_vrr_pre_ai - Test crtc high IRQ VRR path on pre-AI ASIC
+ * @test: The KUnit test context
+ *
+ * With a matching CRTC, no writeback, VRR active (so the !vrr_active vblank
+ * handler is skipped) and a pre-AI family, the handler runs through CRC
+ * handling and returns before the freesync section.
+ */
+static void dm_test_crtc_high_irq_vrr_pre_ai(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	INIT_LIST_HEAD(&acrtc->base.head);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = 0;
+	/* VRR active so the !vrr_active vblank handler is skipped. */
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+				dm_test_crtc_list_del, acrtc), 0);
+
+	/* Pre-AI family returns right after CRC handling. */
+	adev->family = AMDGPU_FAMILY_SI;
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VBLANK;
+
+	dm_crtc_high_irq(&params);
+}
+
+/**
+ * dm_test_crtc_high_irq_vrr_ai_no_stream - Test crtc high IRQ AI path, no stream
+ * @test: The KUnit test context
+ *
+ * On an AI+ family the handler runs the post-CRC freesync section. With no
+ * stream and no pending flip, both inner blocks are skipped and the handler
+ * completes through the event-lock critical section, leaving pflip_status
+ * untouched.
+ */
+static void dm_test_crtc_high_irq_vrr_ai_no_stream(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	INIT_LIST_HEAD(&acrtc->base.head);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = 0;
+	acrtc->pflip_status = AMDGPU_FLIP_NONE;
+	/* VRR active so the !vrr_active vblank handler is skipped. */
+	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+				dm_test_crtc_list_del, acrtc), 0);
+
+	/* AI+ family runs the freesync section; no stream skips it. */
+	adev->family = AMDGPU_FAMILY_AI;
+
+	params.adev = adev;
+	params.irq_src = (enum dc_irq_source)IRQ_TYPE_VBLANK;
+
+	dm_crtc_high_irq(&params);
+	KUNIT_EXPECT_EQ(test, acrtc->pflip_status, AMDGPU_FLIP_NONE);
+}
+
+/* Tests for dm_handle_hpd_work() */
+
+/**
+ * dm_test_handle_hpd_work_out_of_range - Test HPD work frees unknown notification
+ * @test: The KUnit test context
+ */
+static void dm_test_handle_hpd_work_out_of_range(struct kunit *test)
+{
+	struct dmub_hpd_work *hpd_work;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	hpd_work = kzalloc(sizeof(*hpd_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work);
+	hpd_work->dmub_notify = kzalloc(sizeof(*hpd_work->dmub_notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work->dmub_notify);
+	hpd_work->dmub_notify->type =
+		(enum dmub_notification_type)ARRAY_SIZE(adev->dm.dmub_callback);
+	hpd_work->adev = adev;
+	INIT_WORK(&hpd_work->handle_hpd_work, dm_handle_hpd_work);
+
+	dm_handle_hpd_work(&hpd_work->handle_hpd_work);
+}
+
+/* Tests for dm_dmub_outbox1_low_irq() */
+
+/**
+ * dm_test_dmub_outbox1_low_irq_empty - Test outbox low IRQ with empty trace queue
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_outbox1_low_irq_empty(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct amdgpu_device *adev;
+	struct dmub_srv *dmub;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = dm_test_alloc_dc_with_ctx(test);
+	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub);
+
+	dmub->hw_funcs.get_outbox0_wptr = dm_test_dmub_get_outbox0_wptr;
+	dc_dmub_srv->dmub = dmub;
+	dc->ctx->dmub_srv = dc_dmub_srv;
+	adev->dm.dc = dc;
+	params.adev = adev;
+	params.irq_src = DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	dm_dmub_outbox1_low_irq(&params);
+}
+
+/*
+ * dm_test_alloc_adev_outbox_notify - Build an adev wired for DMUB outbox
+ * notification handling.
+ *
+ * Configures dc/dc_dmub_srv/dmub so that the trace queue is empty and
+ * dc_enable_dmub_notifications() returns true, allowing the notification
+ * handling block of dm_dmub_outbox1_low_irq() to execute. The outbox1 ring
+ * buffer is left empty, so each notification read returns
+ * DMUB_NOTIFICATION_NO_DATA with no pending notification.
+ */
+static struct amdgpu_device *dm_test_alloc_adev_outbox_notify(struct kunit *test)
+{
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct amdgpu_device *adev;
+	struct dmub_srv *dmub;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = dm_test_alloc_dc_with_ctx(test);
+	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub);
+
+	dmub->hw_init = true;
+	dmub->hw_funcs.get_outbox0_wptr = dm_test_dmub_get_outbox0_wptr;
+	dmub->hw_funcs.get_outbox1_wptr = dm_test_dmub_get_outbox1_wptr;
+	dc_dmub_srv->dmub = dmub;
+	dc->ctx->dmub_srv = dc_dmub_srv;
+
+	/* Make dc_enable_dmub_notifications() return true. */
+	dc->caps.dmcub_support = true;
+	dc->ctx->asic_id.chip_family = AMDGPU_FAMILY_GC_11_0_1;
+
+	adev->dm.dc = dc;
+
+	return adev;
+}
+
+/**
+ * dm_test_dmub_outbox1_low_irq_no_handler - Test notification with no handler
+ * @test: The KUnit test context
+ *
+ * Notifications are enabled but no callback is registered for the returned
+ * notification type, exercising the skip-with-warning path.
+ */
+static void dm_test_dmub_outbox1_low_irq_no_handler(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+
+	adev = dm_test_alloc_adev_outbox_notify(test);
+	params.adev = adev;
+	params.irq_src = DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	dm_dmub_outbox1_low_irq(&params);
+}
+
+/**
+ * dm_test_dmub_outbox1_low_irq_direct_callback - Test direct callback dispatch
+ * @test: The KUnit test context
+ *
+ * Notifications are enabled with a registered callback and thread offload
+ * disabled, so the callback is invoked directly from the IRQ handler.
+ */
+static void dm_test_dmub_outbox1_low_irq_direct_callback(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+
+	adev = dm_test_alloc_adev_outbox_notify(test);
+	adev->dm.dmub_callback[DMUB_NOTIFICATION_NO_DATA] = dm_test_dmub_notify_callback;
+	adev->dm.dmub_thread_offload[DMUB_NOTIFICATION_NO_DATA] = false;
+	params.adev = adev;
+	params.irq_src = DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	dm_test_dmub_notify_count = 0;
+
+	dm_dmub_outbox1_low_irq(&params);
+
+	KUNIT_EXPECT_EQ(test, dm_test_dmub_notify_count, 1);
+}
+
+/**
+ * dm_test_dmub_outbox1_low_irq_offload - Test offloaded callback dispatch
+ * @test: The KUnit test context
+ *
+ * Notifications are enabled with a registered callback and thread offload
+ * enabled, so the callback is dispatched via the delayed HPD work queue.
+ */
+static void dm_test_dmub_outbox1_low_irq_offload(struct kunit *test)
+{
+	struct common_irq_params params = { 0 };
+	struct amdgpu_device *adev;
+
+	adev = dm_test_alloc_adev_outbox_notify(test);
+	adev->dm.dmub_callback[DMUB_NOTIFICATION_NO_DATA] = dm_test_dmub_notify_callback;
+	adev->dm.dmub_thread_offload[DMUB_NOTIFICATION_NO_DATA] = true;
+	adev->dm.delayed_hpd_wq = create_singlethread_workqueue("dm_irq_test_outbox");
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.delayed_hpd_wq);
+	params.adev = adev;
+	params.irq_src = DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	dm_test_dmub_notify_count = 0;
+
+	dm_dmub_outbox1_low_irq(&params);
+
+	flush_workqueue(adev->dm.delayed_hpd_wq);
+	destroy_workqueue(adev->dm.delayed_hpd_wq);
+
+	KUNIT_EXPECT_EQ(test, dm_test_dmub_notify_count, 1);
+}
+
+
+/**
+ * dm_test_dce110_register_irq_handlers_rejects_uninitialized_sources - Test DCE110 error
+ * @test: The KUnit test context
+ */
+static void dm_test_dce110_register_irq_handlers_rejects_uninitialized_sources(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = dm_test_alloc_dc_with_ctx(test);
+	adev->dm.dc = dc;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_one_crtc - Test DCE110 with 1 CRTC
+ * @test: The KUnit test context
+ *
+ * Exercises the VBLANK, VUPDATE, PFLIP and HPD for-loop bodies with a
+ * fake IRQ service that maps source IDs to DC IRQ sources.
+ */
+static void dm_test_dce110_register_irq_handlers_one_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
+							 adev), 0);
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dce110);
+	dc->ctx->dce_version = DCE_VERSION_11_0;
+	adev->dm.dc = dc;
+	adev->mode_info.num_crtc = 1;
+	adev->mode_info.num_hpd = 1;
+	amdgpu_dm_set_irq_funcs(adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), 0);
+
+	/* Verify VBLANK params were populated */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.vblank_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_VBLANK1);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.vblank_params[0].adev, adev);
+
+	/* Verify VUPDATE params were populated (VRR supported on DCE 11) */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.vupdate_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_VUPDATE1);
+
+	/* Verify PFLIP params were populated (6 fixed entries) */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.pflip_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_PFLIP1);
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.pflip_params[5].irq_src,
+			(int)DC_IRQ_SOURCE_PFLIP6);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dcn10_register_irq_handlers_zero_crtc - Test DCN10 zero-CRTC registration
+ * @test: The KUnit test context
+ */
+static void dm_test_dcn10_register_irq_handlers_zero_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
+							 adev), 0);
+	dc = dm_test_alloc_dc_with_ctx(test);
+	adev->dm.dc = dc;
+	adev->mode_info.num_hpd = 1;
+	amdgpu_dm_set_irq_funcs(adev);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dcn10_register_irq_handlers(adev), 0);
+	KUNIT_ASSERT_NOT_NULL(test, adev->irq.client[SOC15_IH_CLIENTID_DCE].sources);
+	KUNIT_EXPECT_PTR_EQ(test,
+		adev->irq.client[SOC15_IH_CLIENTID_DCE].sources[DCN_1_0__SRCID__DC_HPD1_INT],
+		&adev->hpd_irq);
+}
+
+/**
+ * dm_test_dcn10_register_irq_handlers_one_crtc - Test DCN10 with 1 CRTC
+ * @test: The KUnit test context
+ *
+ * Exercises the VSTARTUP, VUPDATE, and PFLIP for-loop bodies with a
+ * fake IRQ service.
+ */
+static void dm_test_dcn10_register_irq_handlers_one_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
+							 adev), 0);
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+	adev->dm.dc = dc;
+	adev->mode_info.num_crtc = 1;
+	adev->mode_info.num_hpd = 1;
+	dc->caps.max_otg_num = 1;
+	amdgpu_dm_set_irq_funcs(adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dcn10_register_irq_handlers(adev), 0);
+
+	/* Verify VBLANK params were populated */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.vblank_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_VBLANK1);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.vblank_params[0].adev, adev);
+
+	/* Verify VUPDATE params were populated */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.vupdate_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_VUPDATE1);
+
+	/* Verify PFLIP params were populated */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.pflip_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_PFLIP1);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_register_outbox_irq_handlers_without_dmub - Test outbox registration without DMUB
+ * @test: The KUnit test context
+ */
+static void dm_test_register_outbox_irq_handlers_without_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
+							 adev), 0);
+	dc = dm_test_alloc_dc_with_ctx(test);
+	adev->dm.dc = dc;
+	amdgpu_dm_set_irq_funcs(adev);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_outbox_irq_handlers(adev), 0);
+	KUNIT_ASSERT_NOT_NULL(test, adev->irq.client[SOC15_IH_CLIENTID_DCE].sources);
+	KUNIT_EXPECT_PTR_EQ(test,
+		adev->irq.client[SOC15_IH_CLIENTID_DCE].sources[
+			DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT],
+		&adev->dmub_outbox_irq);
+}
+
+/**
+ * dm_test_register_outbox_irq_handlers_with_dmub - Test outbox registration with DMUB
+ * @test: The KUnit test context
+ *
+ * Exercises the dc->ctx->dmub_srv branch which maps the outbox source and
+ * registers dm_dmub_outbox1_low_irq in the low IRQ context table.
+ */
+static void dm_test_register_outbox_irq_handlers_with_dmub(struct kunit *test)
+{
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct amdgpu_device *adev;
+	struct list_head *hnd_list;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
+							 adev), 0);
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
+	dc->ctx->dmub_srv = dc_dmub_srv;
+	adev->dm.dc = dc;
+	amdgpu_dm_set_irq_funcs(adev);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_register_outbox_irq_handlers(adev), 0);
+
+	/* Verify the outbox IRQ params were populated */
+	KUNIT_EXPECT_EQ(test, (int)adev->dm.dmub_outbox_params[0].irq_src,
+			(int)DC_IRQ_SOURCE_DMCUB_OUTBOX);
+	KUNIT_EXPECT_PTR_EQ(test, adev->dm.dmub_outbox_params[0].adev, adev);
+
+	/* Verify a low-context handler was registered for the outbox source */
+	hnd_list = &adev->dm.irq_handler_list_low_tab[DC_IRQ_SOURCE_DMCUB_OUTBOX];
+	KUNIT_EXPECT_FALSE(test, list_empty(hnd_list));
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* amdgpu_dm_hpd_to_dal_irq_source */
 	KUNIT_CASE(dm_test_hpd_to_dal_irq_source_hpd1),
@@ -3352,6 +3937,27 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	KUNIT_CASE(dm_test_register_hpd_handlers_invalid_hpd),
 	KUNIT_CASE(dm_test_register_hpd_handlers_invalid_hpd_rx),
 	KUNIT_CASE(dm_test_register_hpd_handlers_dmub_outbox),
+	/* pflip/vupdate/crtc high IRQ callbacks */
+	KUNIT_CASE(dm_test_pflip_high_irq_no_crtc),
+	KUNIT_CASE(dm_test_pflip_high_irq_not_submitted),
+	KUNIT_CASE(dm_test_vupdate_high_irq_no_crtc),
+	KUNIT_CASE(dm_test_crtc_high_irq_no_crtc),
+	KUNIT_CASE(dm_test_crtc_high_irq_vrr_pre_ai),
+	KUNIT_CASE(dm_test_crtc_high_irq_vrr_ai_no_stream),
+	/* dm_handle_hpd_work */
+	KUNIT_CASE(dm_test_handle_hpd_work_out_of_range),
+	/* dm_dmub_outbox1_low_irq */
+	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_empty),
+	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_no_handler),
+	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_direct_callback),
+	KUNIT_CASE(dm_test_dmub_outbox1_low_irq_offload),
+	/* IRQ handler registration helpers */
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_rejects_uninitialized_sources),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_one_crtc),
+	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_zero_crtc),
+	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_one_crtc),
+	KUNIT_CASE(dm_test_register_outbox_irq_handlers_without_dmub),
+	KUNIT_CASE(dm_test_register_outbox_irq_handlers_with_dmub),
 	{}
 };

--
2.55.0

