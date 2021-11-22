Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 09:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA05B6E0E5;
	Mon, 22 Nov 2021 09:06:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3387C6E0FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 09:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw6D0xkrgP2rpD4L2lEjZwUWCLQ4STpPIcSGDTXp55PrbpmTymJZ72PEZqllqqdFBxLsuJ4A41PTbgEkOEkaiFqjrN/j+maBCCH1gKvKaGwVOmQ0TWfhjjfMnIGBDI5gmbg6pjUpCCB3274ZlZI6kfMXwGVBKt/oTdWywPU7gBMdWrLv+utnh1fbh3nJTKeH53D5o+FLi5qam/kphlZUMV2d5NWOZKyBwiypForC6Ddu1Kiamsk3HNIVTEEDjXoDd/9C7AQCOMof7zoK8efmROa0Xyq/8ubUzIO2m43nQBQ8sOZkuY4i5HA21xezjKqDLvT6b7Ik2PXdPxbYauM1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR1N1QvdTLXV8klxoaoD1KvNUNipHZ5HJ3mM9Jy6VYY=;
 b=CVXXpJRIXeHOxrg1+R4PEQkPlPmV47hYbKvNX7/CprBhIyisPWldz833zdGC7mSeBinqjCTA/C7ikpdTR1kA5TdmXUpnUHI1OL6nkPKIE+Nvg+9fdqycV2IV7WTlklEguM6n+ESwNnyuskRx2ezk7iJxX1swzaLiFCQZlmWframy9nE7fTyv/Ycej+zX91XK+bVee6luTqxmggQCBc2He/qEugqk8OvJydkcqsc///0f62Ydt4o+cOjocXod0EBcdFcyUhbRErfIu0apWEps2rgLUh6IdAYgyIOoulsuBbbGlxRU5zKf6dtcMg6zqVJTUZ+JGuk5Fw0kJkJoMViKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR1N1QvdTLXV8klxoaoD1KvNUNipHZ5HJ3mM9Jy6VYY=;
 b=qEPDa9jZ4LcBaiRWpTNlnlv1OI+NHrVSTHDCwLeSNBfxeEmzM1VJnXR1aFm3P3ptMzA3Ipc++cZ0YtP8tjDttXZLv5W1JhipEJIr820emNBRTnjJKqgUHNQFZtuBQXk5X/1TZzPZT7Jdp5XTYAq/ky796fO7cXcbck53+dm4KVA=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 09:06:25 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::29) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Mon, 22 Nov 2021 09:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 09:06:25 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 22 Nov
 2021 03:06:20 -0600
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <guchun.chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Date: Mon, 22 Nov 2021 17:03:52 +0800
Message-ID: <20211122090353.1399178-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8513ef3b-bb59-4f44-4bf5-08d9ad975ca6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3739F6225241FE74DC21896EFA9F9@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaESn7iL5Dx4ncQIe5xpFDOO4fsPhMS3acnGpysrl0MUMaVW94J0lvdr+aHOXgVeuDwY+kvOfMCxiGV7uxvhMvuQZyAshbvgnNonCUTzmWYjk+mmwaB8xau1o/RtVwspP8i3COTJqiQYIwVIl3GQwwsWR3BOaY+v8Wzvento+MSktOPhwCnYf8/iIr+0C/4EaR+W9z6khTEgDNuWWv+UfxM13tBUMYcQ5/7JLHhee/4howzse5NSlUmKmJDgBy83SY6PUOW+IsQ+Lgr4JvO6HXqYJQ5JSjI1IhqGvPsFLmz18wdEQcrunUIyjRN8MoRu5ON/xtwZdiIBI7y3IFA7dOF28TlFzsVEafGMu405WKAB4A/MwpODlQdvWS+it8zYq9XKS3MAwb3DpMud5VbGw9zxXwvl826yPaJZ6GYjvDWWqEqPKduZREheHWZ1FJ1HSgfeQ5BCeZ747ZKWDs8ZaI5mK7CfMUip6UIwJGOzVCm3AjBqA0P45FgOjvcdeGXY2psPNEp0d3BZ5uwDXlaNvHVEX1LHmZ/h1+mJwJPJW+CuQ9pz6TefShsYtpj4yraPls5Gzs7igzCOyC8Ok60rBFDg9Binge7jIlpuaDtj8/LGMnSYShjap4fKbHrIFYv7G3/oB4Wz7S12+fks4JrGRGUBzZB00Uj7qRp7jxvzZzu9vzNif00QD5rFuMS4dYXz5jCMPM8VZRH5AyyN93P+cuBGY86Gx7KeKPWXUq3hj6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(44832011)(36860700001)(82310400003)(7696005)(186003)(47076005)(2906002)(6666004)(16526019)(81166007)(316002)(6636002)(2616005)(426003)(356005)(1076003)(336012)(110136005)(8676002)(5660300002)(70206006)(83380400001)(26005)(86362001)(8936002)(4326008)(36756003)(70586007)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 09:06:25.3976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8513ef3b-bb59-4f44-4bf5-08d9ad975ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise adev->mode_info.crtcs[] is NULL

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 38 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |  5 ++--
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index ce982afeff91..6c62c45e3e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -16,6 +16,8 @@
 #include "ivsrcid/ivsrcid_vislands30.h"
 #include "amdgpu_vkms.h"
 #include "amdgpu_display.h"
+#include "atom.h"
+#include "amdgpu_irq.h"
 
 /**
  * DOC: amdgpu_vkms
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] = {
 
 static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 {
-	struct amdgpu_vkms_output *output = container_of(timer,
-							 struct amdgpu_vkms_output,
-							 vblank_hrtimer);
-	struct drm_crtc *crtc = &output->crtc;
+	struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct amdgpu_crtc, vblank_timer);
+	struct drm_crtc *crtc = &amdgpu_crtc->base;
+	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	u64 ret_overrun;
 	bool ret;
 
-	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
+	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
 	WARN_ON(ret_overrun != 1);
 
@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *crtc)
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function = &amdgpu_vkms_vblank_simulate;
 	out->period_ns = ktime_set(0, vblank->framedur_ns);
-	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
+	hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns, HRTIMER_MODE_REL);
 
 	return 0;
 }
 
 static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)
 {
-	struct amdgpu_vkms_output *out = drm_crtc_to_amdgpu_vkms_output(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	hrtimer_cancel(&out->vblank_hrtimer);
+	hrtimer_cancel(&amdgpu_crtc->vblank_timer);
 }
 
 static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
@@ -92,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 	unsigned int pipe = crtc->index;
 	struct amdgpu_vkms_output *output = drm_crtc_to_amdgpu_vkms_output(crtc);
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	if (!READ_ONCE(vblank->enabled)) {
 		*vblank_time = ktime_get();
 		return true;
 	}
 
-	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
+	*vblank_time = READ_ONCE(amdgpu_crtc->vblank_timer.node.expires);
 
 	if (WARN_ON(*vblank_time == vblank->time))
 		return true;
@@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_crtc_helper_funcs = {
 static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 			  struct drm_plane *primary, struct drm_plane *cursor)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int ret;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
@@ -176,6 +179,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);
 
+	amdgpu_crtc->crtc_id = drm_crtc_index(crtc);
+	adev->mode_info.crtcs[drm_crtc_index(crtc)] = amdgpu_crtc;
+
+	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
+	amdgpu_crtc->encoder = NULL;
+	amdgpu_crtc->connector = NULL;
+	amdgpu_crtc->vsync_timer_enabled = AMDGPU_IRQ_STATE_DISABLE;
+
+	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	amdgpu_crtc->vblank_timer.function = &amdgpu_vkms_vblank_simulate;
+
 	return ret;
 }
 
@@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,
 {
 	struct drm_connector *connector = &output->connector;
 	struct drm_encoder *encoder = &output->encoder;
-	struct drm_crtc *crtc = &output->crtc;
+	struct drm_crtc *crtc = &output->crtc.base;
 	struct drm_plane *primary, *cursor = NULL;
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
index 97f1b79c0724..4f8722ff37c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
@@ -10,15 +10,14 @@
 #define YRES_MAX  16384
 
 #define drm_crtc_to_amdgpu_vkms_output(target) \
-	container_of(target, struct amdgpu_vkms_output, crtc)
+	container_of(target, struct amdgpu_vkms_output, crtc.base)
 
 extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;
 
 struct amdgpu_vkms_output {
-	struct drm_crtc crtc;
+	struct amdgpu_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
 	struct drm_pending_vblank_event *event;
 };
-- 
2.25.1

