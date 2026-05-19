Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A335CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EC610E3FD;
	Tue, 19 May 2026 22:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t8u8yEQi";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CA510E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2xqchNZxckG4YRawrDLylbUQrgDvqtrUxjIwjs2Qe1h7GnjAE1B0J80i2QX9ABn6cv5JT4IpgiMihcNj6fZG9G4RmIsx+JSuTBgAWarEFt2pRhLiIDRB7FLy/DVnLLE1h+1ru6sBH9aq+NIRWEx0LK2aKEhx3ACxhRS6GYtchhVQMNIIj4JHwVpmLrkYoasga8gX2TmuqeajvCmBylP51aKWDKW5jajRgseit5PSLE8RmOv/jE1ucuMq4Pg1W5m86v10tRZLyTWBth/NNy2bf3cv9rF5JIaarKS+NaVj/dSXdgzjH9sKJgn5kW0pyChtc+wPoLLEoqxrh4M80PfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sue3uZcyKQUXYcNRBSJt5pNi83k8R8s3q6EDGq3KKV4=;
 b=RL26k5c7at/Cc52DT3fgDDn5wKi/DpNSg7DLsol3t1RKXRKPJFdqVUyVRoHmwH0U6JFxrHfMznZJ4Y5w63O+lowgdYq7TEfEBnaLAIMoMfINr0N7tpIt2FA92p/lddCTvzdUSN2o0wHcSv2GOqZyLm80lEQ075ydwM5ddWh1PXzxHIWjDjBpQsqs9CXllCsCfmN9HZAUVUlesCdvNDJDxGyWWuvVjhxlZZCVRBr7O0B5jmOFFOwYg7Zx26oB5GHyz6RArJH4ijiKfl6oTIJAdjc8iXo+7K+/Cxd1EEmPBc0nh0t8lucdAkRNqPM+pQI+jpOf+XQxmB0s8MbeUvkWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sue3uZcyKQUXYcNRBSJt5pNi83k8R8s3q6EDGq3KKV4=;
 b=t8u8yEQigrXFd18q398vGTWzHXgd+rn5uYgxopbYJOnvmDrpybi+dtWqKB9w9cOrL02DbVHA5Milh12zxl0Oh4gCaRTTKUl45SHYGQo9N27hGIJcWNw9sJnOpOEz9OpHUY1m2V9+4SXwEP6iYsZ1OpLXazYfLwJQ+7AYjJ3EkCE=
Received: from BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34)
 by DS3PR12MB999217.namprd12.prod.outlook.com (2603:10b6:8:390::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 19 May
 2026 22:06:15 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::c5) by BL0PR02CA0021.outlook.office365.com
 (2603:10b6:207:3c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 22:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 22:06:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 17:06:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 17:06:13 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 19 May 2026 17:06:13 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Li <sunpeng.li@amd.com>, <Harry.Wentland@amd.com>,
 <Aurabindo.Pillai@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <michel.daenzer@mailbox.org>, <alexander.deucher@amd.com>
Subject: [PATCH v2 2/3] drm/amd/display: Use vline2 interrupt on DCN instead
 of vstartup
Date: Tue, 19 May 2026 18:04:43 -0400
Message-ID: <20260519220529.202096-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519220529.202096-1-sunpeng.li@amd.com>
References: <20260519220529.202096-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS3PR12MB999217:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a9f7ac-40d3-4ec7-7e02-08deb5f2d80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|32650700020|3023799007|13003099007|22082099003|11063799006|56012099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: zpjy22MEVpQcnUuWr7FrtwOmxMdMI38Kkd3Pwu0VUDuE9CMnttoi7b6sK5Ht+KnhWHB8juc0n5bDQx+dPsHmRAiXLne3NoxlGr7MXA4HOp/1sGomgDqRcjCa8w9XWxJUMI7k9NXAinKixj4mDadtMFUgq5Npvd4R8XmnfimJS4Fw3odZ0jmEbTCIIWHSscq34CxbPhISGKCf4/ynUZSIrtVQHI6izg8ay1ZhLd6OFJ8FdvwLwX8rm5uWypJQTCH2HknV1x9vnrlPKY9QBf/7ZN4BE6uxB6AcpokDwPjlhDdqx4CjZDpncpBG+7SVk+z3aBw7TucZy/YVObHmDuLRuS7u1flKeZhriRCWPb4b0Gw9hphggL8l7rfXvbKbJBqGWbvH1Q4dPJ4TYdPNju5PjmJ/PhPcyTQm7kWZWsWYW1eyqEmv2rS56dFmB6vqaIrwcRF/cu+h44d8/dbhyzam3R7M1LErrWoFA7+/UHqMJQ8kfQZt9rIHEy6vkGe9SjI1KYogQumldyQxskJO6vcpdfKI6iRX0PcWGfH+9NjCPx7Y7+NWpLySdYt/3d8eG0O6pLv+ElZTXp5rtzwOFgINYIo4+zKokUXiuIh3FA4Eqg69ibMQaScq3oRJCr3mLVL8ZSoPiYgeDSadrdmLlA++WP+2mx+Ni5uwEFtWbgbZ6orkJXJ1kgfDe2pLrQHxMTWb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(32650700020)(3023799007)(13003099007)(22082099003)(11063799006)(56012099003)(18002099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xc/4UJr4taXAT/dxZ5udU4LAN+xbNb2YwLaYowdVXsbUkU812h293Kv8r0ovCdWzkp2kwWbvus88IOGApUkASWSAMKPQqSlnAgv9Azksp0BuMnVSgdr5xTu19/j4aUdLfIk4qEeD/tW0p6lABeWBS7Avz3Y1O0hqC5m07XQuY8MReovmpBhbS9DOCMTCTLQYAYsdp+tvWrtJhw4rcQYjdqmN79+2pLqtYlaqOedjU4EIEjTESRahobjEfyF2i21mrpG2i0fCAXEr2sfVVX8Dgj/weYK/TwTq5sL1ZRwy5JoYl0n+HAxn0MagyUrna6K3Cc3c4KauL1sF8KXi4bhQY5dlK/qzoYygExnuf5ajvm+cGJ8Cc1l3BHwO683gIFtCBZFP8CCmD5w/QaaV4t4ZVvkQoo2V2iA/yoSoZat3vDpAMnKxqupfIHydD24Zh01S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:06:14.4280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a9f7ac-40d3-4ec7-7e02-08deb5f2d80e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999217
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

VStartup is an OTG event that fires when the pixel pipeline prepares for
pixel scanout of the next frame. It was previously used to deliver
vblank events for commits that do not trigger a fb address update, and
hence a pflip interrupt (hw cursor updates, for example).

The issue with vstartup is that HW can mask the interrupt in some cases:

* DPG - DCN can Dynamically Power Gate parts of the display pipe when a
  self-refresh capable eDP is connected. DPG is engaged when there's
  enough static frames (detected thru drm_vblank_off) Once gated, even
  though the OTG (output timing generator) is still enabled, vstartup is
  masked. vline is unaffected.

* GSL - Driver can use the Global Sync Lock to block HW from latching
  onto double-buffered registers during programming, to prevent HW from
  latching onto a partially programmed state. This will mask vstartup,
  but vline is unaffected. See dcn20_pipe_control_lock()

* MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can
  store fb data to allow for longer DRAM sleep. When scanning out from
  MALL, vstartup is masked, vline is unaffected.

This could the explain the range of flip_done timeouts frequently seen
in the wild.

DCN hardware provides 3 generic OTG interrupts that can be programmed to
fire on a specific line. Vline 0 and 1 are currently reserved, with
vline2 available to use for event delivery. These interrupts cannot be
masked, as long as the OTG is active.

[How]

Switch to vline2 for vblank handling. Today, DC will program the vline2
position to at vupdate -- the point at which HW latches to
double-buffered registers.

Since all the vline interrupt types share the same interrupt src_id,
refactor the existing vline0 infrastructure to allow for all the vline0,
1, and 2 types.

Since this is intended to replace vstartup for DCN, use the same handler
logic, but be careful to leave DCE on vstartup.

v2:
* Use acrtc->otg_inst when mapping the HW irq_source instead of the SW
  DRM CRTC id -- they can be different.
* Convert DCN_VINT_TO_DC_IRQSRC to a ternary chain to avoid control flow
  statements in macro; return at caller.
* Fix other checkpatch.pl issues.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 167 ++++++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  20 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 103 +++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   7 +
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |  44 +++--
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |  43 +++--
 .../dc/irq/dcn201/irq_service_dcn201.c        |  24 ++-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  44 +++--
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |  44 +++--
 .../dc/irq/dcn302/irq_service_dcn302.c        |  43 +++--
 .../dc/irq/dcn303/irq_service_dcn303.c        |  24 ++-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |  44 +++--
 .../dc/irq/dcn314/irq_service_dcn314.c        |  44 +++--
 .../dc/irq/dcn315/irq_service_dcn315.c        |  44 +++--
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |  26 +--
 .../display/dc/irq/dcn35/irq_service_dcn35.c  |  41 +++--
 .../dc/irq/dcn351/irq_service_dcn351.c        |  43 +++--
 .../display/dc/irq/dcn36/irq_service_dcn36.c  |  41 +++--
 .../dc/irq/dcn401/irq_service_dcn401.c        |  25 +--
 .../display/dc/irq/dcn42/irq_service_dcn42.c  |  26 +--
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |  18 ++
 23 files changed, 674 insertions(+), 252 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 80b18bbd7f3a8..9916b9be7584c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -909,7 +909,7 @@ struct amdgpu_device {
 	/* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->dm" */
 	struct delayed_work         hotplug_work;
 	struct amdgpu_irq_src		crtc_irq;
-	struct amdgpu_irq_src		vline0_irq;
+	struct amdgpu_irq_src		vline_irq;
 	struct amdgpu_irq_src		vupdate_irq;
 	struct amdgpu_irq_src		pageflip_irq;
 	struct amdgpu_irq_src		hpd_irq;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index be9c4e094d8ec..1daea5644d535 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -646,7 +646,8 @@ static void dm_vupdate_high_irq(void *interrupt_params)
  * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
  * event handler.
  */
-static void dm_crtc_high_irq(void *interrupt_params)
+static void __dm_crtc_high_irq(void *interrupt_params,
+			     int otg_inst)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -655,7 +656,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	unsigned long flags;
 	int vrr_active;
 
-	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
+	acrtc = get_crtc_by_otg_inst(adev, otg_inst);
 	if (!acrtc)
 		return;
 
@@ -755,6 +756,14 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
+static void dm_crtc_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+
+	__dm_crtc_high_irq(interrupt_params,
+			   irq_params->irq_src - DC_IRQ_SOURCE_VBLANK1);
+}
+
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 /**
  * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
@@ -778,6 +787,18 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 }
 #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
 
+
+/**
+ * Same as dm_crtc_high_irq, but driven by the vline2 interrupt instead.
+ */
+static void dm_dcn_vertical_interrupt2_high_irq(void *interrupt_params)
+{
+	struct common_irq_params *irq_params = interrupt_params;
+
+	__dm_crtc_high_irq(interrupt_params,
+			   irq_params->irq_src - DC_IRQ_SOURCE_DC1_VLINE2);
+}
+
 /**
  * dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
  * @adev: amdgpu_device pointer
@@ -4759,15 +4780,13 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	return r;
 }
 
-/* Register IRQ sources and initialize IRQ callbacks */
-static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
+
+static int dcn10_register_vline_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
 	struct dc_interrupt_params int_params = {0};
-	int r;
-	int i;
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	int r, i;
 	static const unsigned int vrtl_int_srcid[] = {
 		DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
 		DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
@@ -4776,89 +4795,127 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
 		DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL
 	};
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	static const unsigned int vrtl0_int_ctxid[] = {
+		DCN_1_0__CTXID__OTG1_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__CTXID__OTG2_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__CTXID__OTG3_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__CTXID__OTG4_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__CTXID__OTG5_VERTICAL_INTERRUPT0_CONTROL,
+		DCN_1_0__CTXID__OTG6_VERTICAL_INTERRUPT0_CONTROL
+	};
 #endif
+	static const unsigned int vrtl2_int_ctxid[] = {
+		DCN_1_0__CTXID__OTG1_VERTICAL_INTERRUPT2_CONTROL,
+		DCN_1_0__CTXID__OTG2_VERTICAL_INTERRUPT2_CONTROL,
+		DCN_1_0__CTXID__OTG3_VERTICAL_INTERRUPT2_CONTROL,
+		DCN_1_0__CTXID__OTG4_VERTICAL_INTERRUPT2_CONTROL,
+		DCN_1_0__CTXID__OTG5_VERTICAL_INTERRUPT2_CONTROL,
+		DCN_1_0__CTXID__OTG6_VERTICAL_INTERRUPT2_CONTROL
+	};
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
 
-	/*
-	 * Actions of amdgpu_irq_add_id():
-	 * 1. Register a set() function with base driver.
-	 *    Base driver will call set() function to enable/disable an
-	 *    interrupt in DC hardware.
-	 * 2. Register amdgpu_dm_irq_handler().
-	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
-	 *    coming from DC hardware.
-	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling.
-	 */
-
-	/* Use VSTARTUP interrupt */
-	for (i = DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP;
-			i <= DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP + adev->mode_info.num_crtc - 1;
-			i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->crtc_irq);
+	for (i = 0; i <= adev->mode_info.num_crtc - 1; i++) {
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
+				vrtl_int_srcid[i], &adev->vline_irq);
 
 		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
+			drm_err(adev_to_drm(adev),
+				"Failed to add vline0/1/2 irq id!\n");
 			return r;
 		}
 
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+		/* Register vline0 */
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
+			dc_interrupt_to_irq_source(dc,
+						   vrtl_int_srcid[i],
+						   vrtl0_int_ctxid[i]);
 
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
+			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
+			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
+			drm_err(adev_to_drm(adev),
+				"Failed to register vline0 irq!\n");
 			return -EINVAL;
 		}
 
-		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
+		c_irq_params = &adev->dm.vline0_params[int_params.irq_source
+					- DC_IRQ_SOURCE_DC1_VLINE0];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_crtc_high_irq, c_irq_params))
+			dm_dcn_vertical_interrupt0_high_irq,
+			c_irq_params))
 			return -ENOMEM;
-	}
-
-	/* Use otg vertical line interrupt */
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	for (i = 0; i <= adev->mode_info.num_crtc - 1; i++) {
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
-				vrtl_int_srcid[i], &adev->vline0_irq);
-
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add vline0 irq id!\n");
-			return r;
-		}
-
+#endif
+		/*
+		 * vline2 shares the same srcids as vline0, but different ctxid.
+		 */
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, vrtl_int_srcid[i], 0);
+			dc_interrupt_to_irq_source(dc,
+						   vrtl_int_srcid[i],
+						   vrtl2_int_ctxid[i]);
 
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
-			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
-			drm_err(adev_to_drm(adev), "Failed to register vline0 irq!\n");
+			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE2 ||
+			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE2) {
+			drm_err(adev_to_drm(adev),
+				"Failed to register vline2 irq!\n");
 			return -EINVAL;
 		}
 
-		c_irq_params = &adev->dm.vline0_params[int_params.irq_source
-					- DC_IRQ_SOURCE_DC1_VLINE0];
+		c_irq_params = &adev->dm.vline2_params[int_params.irq_source
+					- DC_IRQ_SOURCE_DC1_VLINE2];
 
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
 		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_dcn_vertical_interrupt0_high_irq,
+			dm_dcn_vertical_interrupt2_high_irq,
 			c_irq_params))
 			return -ENOMEM;
 	}
-#endif
+
+	return 0;
+}
+
+/* Register IRQ sources and initialize IRQ callbacks */
+static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct common_irq_params *c_irq_params;
+	struct dc_interrupt_params int_params = {0};
+	int r;
+	int i;
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	/*
+	 * Actions of amdgpu_irq_add_id():
+	 * 1. Register a set() function with base driver.
+	 *    Base driver will call set() function to enable/disable an
+	 *    interrupt in DC hardware.
+	 * 2. Register amdgpu_dm_irq_handler().
+	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
+	 *    coming from DC hardware.
+	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
+	 *    for acknowledging and handling.
+	 */
+
+	r = dcn10_register_vline_irq_handlers(adev);
+	if (r) {
+		drm_err(adev_to_drm(adev),
+			"Failed to register vline interrupts\n");
+		return r;
+	}
 
 	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
 	 * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
@@ -9548,7 +9605,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 			if (amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type))
 				drm_err(dev, "DM_IRQ: Cannot get pageflip irq!\n");
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-			if (amdgpu_irq_get(adev, &adev->vline0_irq, irq_type))
+			if (amdgpu_irq_get(adev, &adev->vline_irq,
+					   DM_VLINE_IRQ(adev, 0, irq_type)))
 				drm_err(dev, "DM_IRQ: Cannot get vline0 irq!\n");
 #endif
 		}
@@ -9561,7 +9619,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		case IP_VERSION(3, 0, 3):
 		case IP_VERSION(3, 2, 0):
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-			if (amdgpu_irq_put(adev, &adev->vline0_irq, irq_type))
+			if (amdgpu_irq_put(adev, &adev->vline_irq,
+					   DM_VLINE_IRQ(adev, 0, irq_type)))
 				drm_err(dev, "DM_IRQ: Cannot put vline0 irq!\n");
 #endif
 			if (amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4b7dc583c1104..f575f4702598f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -543,6 +543,15 @@ struct amdgpu_display_manager {
 	struct common_irq_params
 	vline0_params[DC_IRQ_SOURCE_DC6_VLINE0 - DC_IRQ_SOURCE_DC1_VLINE0 + 1];
 
+	/**
+	 * @vline2_params:
+	 *
+	 * OTG vertical interrupt0 IRQ parameters, passed to registered
+	 * handlers when triggered.
+	 */
+	struct common_irq_params
+	vline2_params[DC_IRQ_SOURCE_DC6_VLINE2 - DC_IRQ_SOURCE_DC1_VLINE2 + 1];
+
 	/**
 	 * @vupdate_params:
 	 *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index efb19f675b0c2..aeec922abdbae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -28,6 +28,7 @@
 
 #include "dc.h"
 #include "amdgpu.h"
+#include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
@@ -290,10 +291,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	/* crtc vblank or vstartup interrupt */
 	if (enable) {
-		rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
+		/* vline only available on DCN+ */
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0)
+			rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
+		else
+			rc = amdgpu_irq_get(adev, &adev->vline_irq,
+					    DM_VLINE_IRQ(adev, 2, acrtc->crtc_id));
 		drm_dbg_vbl(crtc->dev, "Get crtc_irq ret=%d\n", rc);
 	} else {
-		rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0)
+			rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
+		else
+			rc = amdgpu_irq_put(adev, &adev->vline_irq,
+					    DM_VLINE_IRQ(adev, 2, acrtc->crtc_id));
 		drm_dbg_vbl(crtc->dev, "Put crtc_irq ret=%d\n", rc);
 	}
 
@@ -323,10 +333,12 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	/* crtc vline0 interrupt, only available on DCN+ */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
 		if (enable) {
-			rc = amdgpu_irq_get(adev, &adev->vline0_irq, irq_type);
+			rc = amdgpu_irq_get(adev, &adev->vline_irq,
+					    DM_VLINE_IRQ(adev, 0, acrtc->crtc_id));
 			drm_dbg_vbl(crtc->dev, "Get vline0_irq ret=%d\n", rc);
 		} else {
-			rc = amdgpu_irq_put(adev, &adev->vline0_irq, irq_type);
+			rc = amdgpu_irq_put(adev, &adev->vline_irq,
+					    DM_VLINE_IRQ(adev, 0, acrtc->crtc_id));
 			drm_dbg_vbl(crtc->dev, "Put vline0_irq ret=%d\n", rc);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5948e2a6219e3..349475dad02c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -769,18 +769,90 @@ static int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 		__func__);
 }
 
-static int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
-					struct amdgpu_irq_src *source,
-					unsigned int crtc_id,
-					enum amdgpu_interrupt_state state)
+/**
+ * amdgpu_dm_set_vline_irq_state: Set interrupt state for vline
+ *
+ * Map base driver amdgpu_irq_update() -- called per interrupt src ID -- to
+ * their corresponding dc_irq_source, then set then to the requested state.
+ *
+ * Since all the vline0/1/2 interrupts have the same src_id, the standard
+ * amdgpu_irq_src.num_types mapping to the number of OTGs won't work. For vline,
+ * num_types will have to cover (number of different vline interrupt types) *
+ * (number of OTGs) types. For example, if there are 6 OTGS, then num_types =
+ * 3*6 = 18.
+ *
+ * This is only needed for the amdgpu_irq_src_funcs.set_irq implementation; the
+ * .process implementation is provided the interrupt vector, which contains both
+ * the src_id and ctx_id to uniquely map to the dc_irq_source.
+ *
+ * The vline_otg_id mapping is first by vline num, then by crtc id:
+ *
+ * | vline_crtc_id | vline num | CRTC id |
+ * |---------------|-----------|---------|
+ * | 0             | 0         | 0       |
+ * | 1             | 0         | 1       |
+ * | ...           | ...       | ...     |
+ * | 5             | 0         | 5       |
+ * | 6             | 1         | 0       |
+ * | ...           | ...       | ...     |
+ * | 11            | 1         | 5       |
+ * | 12            | 2         | 0       |
+ * | ...           | ...       | ...     |
+ * | 17            | 2         | 5       |
+ */
+static int amdgpu_dm_set_vline_irq_state(struct amdgpu_device *adev,
+					 struct amdgpu_irq_src *source,
+					 unsigned int vline_crtc_id,
+					 enum amdgpu_interrupt_state state)
 {
-	return dm_irq_state(
-		adev,
-		source,
-		crtc_id,
-		state,
-		IRQ_TYPE_VLINE0,
-		__func__);
+	bool st;
+	unsigned int vline_num, crtc_id;
+	enum dc_irq_source irq_source;
+	struct dc *dc = adev->dm.dc;
+	struct amdgpu_crtc *acrtc;
+
+	if (vline_crtc_id >= 3 * adev->mode_info.num_crtc) {
+		drm_err(adev_to_drm(adev),
+			"Invalid vline map_id :%d\n", vline_crtc_id);
+		return -EINVAL;
+	}
+
+	vline_num = vline_crtc_id / adev->mode_info.num_crtc;
+	crtc_id = vline_crtc_id % adev->mode_info.num_crtc;
+	acrtc = adev->mode_info.crtcs[crtc_id];
+
+	if (!acrtc) {
+		drm_err(adev_to_drm(adev),
+			"crtc is NULL at id : %d\n", crtc_id);
+		return 0;
+	}
+
+	/*
+	 * DRM CRTC index and DCN OTG instance may not equal. Use otg_inst since
+	 * irq_source is defined by OTG instance.
+	 */
+	if (acrtc->otg_inst == -1)
+		return 0;
+
+	if (vline_num == 0)
+		irq_source = IRQ_TYPE_VLINE0 + acrtc->otg_inst;
+	else if (vline_num == 1)
+		irq_source = IRQ_TYPE_VLINE1 + acrtc->otg_inst;
+	else if (vline_num == 2)
+		irq_source = IRQ_TYPE_VLINE2 + acrtc->otg_inst;
+	else {
+		drm_err(adev_to_drm(adev),
+			"Invalid vline num :%d\n", vline_num);
+		return -EINVAL;
+	}
+
+	st = (state == AMDGPU_IRQ_STATE_ENABLE);
+
+	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
+		dc_allow_idle_optimizations(dc, false);
+
+	dc_interrupt_set(adev->dm.dc, irq_source, st);
+	return 0;
 }
 
 static int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
@@ -826,8 +898,8 @@ static const struct amdgpu_irq_src_funcs dm_crtc_irq_funcs = {
 	.process = amdgpu_dm_irq_handler,
 };
 
-static const struct amdgpu_irq_src_funcs dm_vline0_irq_funcs = {
-	.set = amdgpu_dm_set_vline0_irq_state,
+static const struct amdgpu_irq_src_funcs dm_vline_irq_funcs = {
+	.set = amdgpu_dm_set_vline_irq_state,
 	.process = amdgpu_dm_irq_handler,
 };
 
@@ -861,8 +933,9 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
 	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dm_crtc_irq_funcs;
 
-	adev->vline0_irq.num_types = adev->mode_info.num_crtc;
-	adev->vline0_irq.funcs = &dm_vline0_irq_funcs;
+	/* Number of vline types * num OTGs */
+	adev->vline_irq.num_types = 3 * adev->mode_info.num_crtc;
+	adev->vline_irq.funcs = &dm_vline_irq_funcs;
 
 	adev->dmub_outbox_irq.num_types = 1;
 	adev->dmub_outbox_irq.funcs = &dm_dmub_outbox_irq_funcs;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 4f6b58f4f90d7..f25989dcc2701 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -27,6 +27,13 @@
 
 #include "irq_types.h" /* DAL irq definitions */
 
+/*
+ * Get OTG vline irq id from vline num and otg num. See also
+ * amdgpu_dm_set_vline_irq_state()
+ */
+#define DM_VLINE_IRQ(adev, vline_num, otg_num) \
+	(adev->mode_info.num_crtc * vline_num + otg_num)
+
 /*
  * Display Manager IRQ-related interfaces (for use by DAL).
  */
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index 7dff8731f414e..a0ceeb672c4ad 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -58,18 +58,6 @@ static enum dc_irq_source to_dal_irq_source_dcn10(struct irq_service *irq_servic
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE1;
 	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
@@ -95,6 +83,19 @@ static enum dc_irq_source to_dal_irq_source_dcn10(struct irq_service *irq_servic
 	case DCN_1_0__SRCID__HUBP5_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP6;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -157,6 +158,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
@@ -239,6 +245,14 @@ static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -353,6 +367,12 @@ irq_source_info_dcn10[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
+	vline2_int_entry(4),
+	vline2_int_entry(5),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn10 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 34f9e8a9f488f..2b0d6d2eae23b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -59,18 +59,6 @@ static enum dc_irq_source to_dal_irq_source_dcn20(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -96,6 +84,19 @@ static enum dc_irq_source to_dal_irq_source_dcn20(
 	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE6;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -163,6 +164,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -244,6 +250,13 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -358,6 +371,12 @@ irq_source_info_dcn20[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
+	vline2_int_entry(4),
+	vline2_int_entry(5),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn20 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index 6417011d22463..922de0e643755 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -47,10 +47,6 @@ static enum dc_irq_source to_dal_irq_source_dcn201(
 		return DC_IRQ_SOURCE_VBLANK1;
 	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK2;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -59,6 +55,12 @@ static enum dc_irq_source to_dal_irq_source_dcn201(
 		return DC_IRQ_SOURCE_VUPDATE1;
 	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE2;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -104,6 +106,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
 };
+
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
 static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
@@ -195,6 +202,13 @@ static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -309,6 +323,8 @@ irq_source_info_dcn201[DAL_IRQ_SOURCES_NUMBER] = {
 	dummy_irq_entry(),
 	dummy_irq_entry(),
 	dummy_irq_entry(),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn201 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 05f7877d2d6c8..a451fabda1bcc 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -60,18 +60,6 @@ static enum dc_irq_source to_dal_irq_source_dcn21(struct irq_service *irq_servic
 		return DC_IRQ_SOURCE_VBLANK6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -97,6 +85,19 @@ static enum dc_irq_source to_dal_irq_source_dcn21(struct irq_service *irq_servic
 	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE6;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -170,6 +171,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
@@ -266,6 +272,14 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dmub_outbox_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
 		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
@@ -385,6 +399,12 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
+	vline2_int_entry(4),
+	vline2_int_entry(5),
 	dmub_outbox_int_entry(),
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 3a7f76364000e..c95ebcb9cd925 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -68,18 +68,6 @@ static enum dc_irq_source to_dal_irq_source_dcn30(
 		return DC_IRQ_SOURCE_VBLANK6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -105,6 +93,19 @@ static enum dc_irq_source to_dal_irq_source_dcn30(
 	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE6;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -177,6 +178,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -280,6 +286,14 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
@@ -394,6 +408,12 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
+	vline2_int_entry(4),
+	vline2_int_entry(5),
 	dmub_trace_int_entry(),
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
index f4dfc96310c73..f32348df3bf53 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
@@ -55,18 +55,6 @@ static enum dc_irq_source to_dal_irq_source_dcn302(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VBLANK6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -92,6 +80,19 @@ static enum dc_irq_source to_dal_irq_source_dcn302(struct irq_service *irq_servi
 	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE6;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -164,6 +165,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -262,6 +268,14 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() { .funcs = &dummy_irq_info_funcs }
 
 #define i2c_int_entry(reg_num) \
@@ -363,6 +377,11 @@ static const struct irq_source_info irq_source_info_dcn302[DAL_IRQ_SOURCES_NUMBE
 		vline0_int_entry(2),
 		vline0_int_entry(3),
 		vline0_int_entry(4),
+		vline2_int_entry(0),
+		vline2_int_entry(1),
+		vline2_int_entry(2),
+		vline2_int_entry(3),
+		vline2_int_entry(4),
 		dmub_trace_int_entry(),
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index fdc7624461ac2..8c528c547781d 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -46,10 +46,6 @@ static enum dc_irq_source to_dal_irq_source_dcn303(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VBLANK1;
 	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK2;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -59,6 +55,11 @@ static enum dc_irq_source to_dal_irq_source_dcn303(struct irq_service *irq_servi
 	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
 		return DC_IRQ_SOURCE_VUPDATE2;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -110,6 +111,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -186,6 +192,14 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() { .funcs = &dummy_irq_info_funcs }
 
 #define i2c_int_entry(reg_num) \
@@ -260,6 +274,8 @@ static const struct irq_source_info irq_source_info_dcn303[DAL_IRQ_SOURCES_NUMBE
 		vblank_int_entry(1),
 		vline0_int_entry(0),
 		vline0_int_entry(1),
+		vline2_int_entry(0),
+		vline2_int_entry(1),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn303 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
index 5fecd03f94999..2cb804bd4d873 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
@@ -56,18 +56,6 @@ static enum dc_irq_source to_dal_irq_source_dcn31(struct irq_service *irq_servic
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -94,6 +82,20 @@ static enum dc_irq_source to_dal_irq_source_dcn31(struct irq_service *irq_servic
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -166,6 +168,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -260,6 +267,15 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		.funcs = &vline0_irq_info_funcs\
 	}
+
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dmub_outbox_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
 		IRQ_REG_ENTRY_DMUB(\
@@ -376,6 +392,10 @@ irq_source_info_dcn31[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
 	dmub_outbox_int_entry(),
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
index a214f13c5a978..f3fe77a205689 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -58,18 +58,6 @@ static enum dc_irq_source to_dal_irq_source_dcn314(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -96,6 +84,20 @@ static enum dc_irq_source to_dal_irq_source_dcn314(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -168,6 +170,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -262,6 +269,15 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		.funcs = &vline0_irq_info_funcs\
 	}
+
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dmub_outbox_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
 		IRQ_REG_ENTRY_DMUB(\
@@ -378,6 +394,10 @@ irq_source_info_dcn314[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
 	dmub_outbox_int_entry(),
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
index dc2dced7db85d..5dfba8d0b1082 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
@@ -63,18 +63,6 @@ static enum dc_irq_source to_dal_irq_source_dcn315(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -101,6 +89,20 @@ static enum dc_irq_source to_dal_irq_source_dcn315(
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -173,6 +175,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -267,6 +274,15 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		.funcs = &vline0_irq_info_funcs\
 	}
+
+#define vline2_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		.funcs = &vline2_irq_info_funcs\
+	}
+
 #define dmub_outbox_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
 		IRQ_REG_ENTRY_DMUB(\
@@ -383,6 +399,10 @@ irq_source_info_dcn315[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	vline2_int_entry(0),
+	vline2_int_entry(1),
+	vline2_int_entry(2),
+	vline2_int_entry(3),
 	dmub_outbox_int_entry(),
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index 3090ceb664332..950419b9cffae 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -57,18 +57,6 @@ static enum dc_irq_source to_dal_irq_source_dcn32(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -95,6 +83,20 @@ static enum dc_irq_source to_dal_irq_source_dcn32(
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
index 27289279b21ca..3881c700a882d 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
@@ -55,18 +55,6 @@ static enum dc_irq_source to_dal_irq_source_dcn35(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -93,6 +81,20 @@ static enum dc_irq_source to_dal_irq_source_dcn35(
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -165,6 +167,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
@@ -249,6 +256,12 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num].funcs = &vline0_irq_info_funcs\
 
+#define vline2_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE2, OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num].funcs = &vline2_irq_info_funcs\
+
 #define dmub_outbox_int_entry()\
 		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
 			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
@@ -362,6 +375,10 @@ static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	vline0_int_entry(3); \
 	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
 	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
+	vline2_int_entry(0); \
+	vline2_int_entry(1); \
+	vline2_int_entry(2); \
+	vline2_int_entry(3); \
 	dmub_outbox_int_entry()
 
 #define dcn35_irq_init() \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
index 7404b572a4e96..5a296145a8530 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
@@ -4,8 +4,6 @@
 #include "dm_services.h"
 #include "include/logger_interface.h"
 #include "../dce110/irq_service_dce110.h"
-
-
 #include "dcn/dcn_3_5_1_offset.h"
 #include "dcn/dcn_3_5_1_sh_mask.h"
 
@@ -34,18 +32,6 @@ static enum dc_irq_source to_dal_irq_source_dcn351(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -72,6 +58,20 @@ static enum dc_irq_source to_dal_irq_source_dcn351(
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -144,6 +144,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
@@ -228,6 +233,12 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num].funcs = &vline0_irq_info_funcs\
 
+#define vline2_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE2, OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num].funcs = &vline2_irq_info_funcs\
+
 #define dmub_outbox_int_entry()\
 		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
 			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
@@ -342,6 +353,10 @@ static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	vline0_int_entry(3); \
 	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
 	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
+	vline2_int_entry(0); \
+	vline2_int_entry(1); \
+	vline2_int_entry(2); \
+	vline2_int_entry(3); \
 	dmub_outbox_int_entry(); \
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
index 3dd47a99f568d..27409f146f72f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
@@ -33,18 +33,6 @@ static enum dc_irq_source to_dal_irq_source_dcn36(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -71,6 +59,20 @@ static enum dc_irq_source to_dal_irq_source_dcn36(
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
@@ -143,6 +145,11 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.ack = NULL
 };
 
+static struct irq_source_info_funcs vline2_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 
@@ -227,6 +234,12 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
 		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num].funcs = &vline0_irq_info_funcs\
 
+#define vline2_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE2, OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE2 + reg_num].funcs = &vline2_irq_info_funcs\
+
 #define dmub_outbox_int_entry()\
 		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
 			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
@@ -339,6 +352,10 @@ static struct irq_source_info_funcs dummy_irq_info_funcs = {
 	vline0_int_entry(1); \
 	vline0_int_entry(2); \
 	vline0_int_entry(3); \
+	vline2_int_entry(0); \
+	vline2_int_entry(1); \
+	vline2_int_entry(2); \
+	vline2_int_entry(3); \
 	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
 	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
 	dmub_outbox_int_entry(); \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
index 42d9d42ba0b99..fc624cf1adc81 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
@@ -36,18 +36,6 @@ static enum dc_irq_source to_dal_irq_source_dcn401(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -75,6 +63,19 @@ static enum dc_irq_source to_dal_irq_source_dcn401(
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
 
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
index f4d1ce9079ded..9f9d6851c87dd 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
@@ -35,18 +35,6 @@ static enum dc_irq_source to_dal_irq_source_dcn42(
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
-	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC1_VLINE0;
-	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC2_VLINE0;
-	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC3_VLINE0;
-	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC4_VLINE0;
-	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC5_VLINE0;
-	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
-		return DC_IRQ_SOURCE_DC6_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -73,6 +61,20 @@ static enum dc_irq_source to_dal_irq_source_dcn42(
 		return DC_IRQ_SOURCE_VUPDATE6;
 	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
 		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
+
+	case DCN_VINT_SRCID(1, 0):
+		return DCN_VINT_TO_DC_IRQSRC(1, ext_id);
+	case DCN_VINT_SRCID(2, 0):
+		return DCN_VINT_TO_DC_IRQSRC(2, ext_id);
+	case DCN_VINT_SRCID(3, 0):
+		return DCN_VINT_TO_DC_IRQSRC(3, ext_id);
+	case DCN_VINT_SRCID(4, 0):
+		return DCN_VINT_TO_DC_IRQSRC(4, ext_id);
+	case DCN_VINT_SRCID(5, 0):
+		return DCN_VINT_TO_DC_IRQSRC(5, ext_id);
+	case DCN_VINT_SRCID(6, 0):
+		return DCN_VINT_TO_DC_IRQSRC(6, ext_id);
+
 	case DCN_1_0__SRCID__DC_HPD1_INT:
 		/* generic src_id for all HPD and HPDRX interrupts */
 		switch (ext_id) {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
index bbcef3d2fe334..4b0dfd299bd93 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
@@ -30,6 +30,24 @@
 
 #include "irq_types.h"
 
+/*
+ * Helper to get vertical interrupt src/ctx id by OTG instance and vint number
+ */
+#define DCN_VINT_SRCID(otg_inst, vint_num) \
+	DCN_1_0__SRCID__OTG ## otg_inst ## _VERTICAL_INTERRUPT ## vint_num ## _CONTROL
+#define DCN_VINT_CTXID(otg_inst, vint_num) \
+	DCN_1_0__CTXID__OTG ## otg_inst ## _VERTICAL_INTERRUPT ## vint_num ## _CONTROL
+#define DC_VINT_IRQSRC(otg_inst, vint_num) \
+	DC_IRQ_SOURCE_DC ## otg_inst ## _VLINE ## vint_num
+
+/* Helper to map vertical interrupt src/ctx id to DC irq source enum */
+#define DCN_VINT_TO_DC_IRQSRC(otg_inst, ext_id) ( \
+	(ext_id) == DCN_VINT_CTXID(otg_inst, 0) ? DC_VINT_IRQSRC(otg_inst, 0) : \
+	(ext_id) == DCN_VINT_CTXID(otg_inst, 1) ? DC_VINT_IRQSRC(otg_inst, 1) : \
+	(ext_id) == DCN_VINT_CTXID(otg_inst, 2) ? DC_VINT_IRQSRC(otg_inst, 2) : \
+	DC_IRQ_SOURCE_INVALID \
+)
+
 struct irq_service;
 struct irq_source_info;
 
-- 
2.53.0

