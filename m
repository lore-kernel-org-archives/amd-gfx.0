Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88443FD88E1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271BC10E2E6;
	Wed, 11 Mar 2026 02:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sf8tBjql";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1454110E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nd69cJzjUtFwhPV7zDqR3urGm3Gc08shHqAvKXLDA4R1eKOJct8Rws/zMEpuj8doV4hS8FPx19wz8DHSNh4pyCus5nrWxBPEzTfcAr4ZmF0ZGUS2C5zwX3z0428dly9FxOcwxy+bN2wZ4e98sYZf/QsDfHQ2fBjVRKgS41rAE7Nne25Kr2PXKzuLimv5iAKaDU410rvoQrzMFx8hSk4qCDTNXsil9oemZSGijfuQlNu6zhtKvrmLaf+tfHv2tM7L4AKVya/w04vTsyh1A08wwDQQB2CSxN0G+60L7O4vQj1o4NA2f4upnZ8kcNGd/UD/eGqg822HO3pxa4kTrIboRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg/QPIwBpZwjIWY4fTSBGSQafe2svQ7uAV4W1kF/zLs=;
 b=BR3TkbiWOKzgbS9U21X3adLUEB+z5gQZiOzrWWReb+0t53CBoPRoB+0wohKhZK8fj/k9OdwBgeMjOSFJYy3OcS2mbjAALA0+LIOluwobLN7Ry6dp5nAjcvpoBXIr/seWBPOIimPy2jcTPNZR7r7lq252kOAtt1gCtm/3V1fB029fXgRAkDbcxQP7mUuhC3Z42geWh8KW0WXaO1cZPOpLi0xZ7cA4PgzXGLrd7+15ZQnJPIuhQmifj0u7vmkMqVQhUv9zb0kEogVQfEZbS2Sxc8KIa4pOvCrYt9kM898Q/OkozNQalUnpHpRCl++RYnzqJ0fUel4Ux4V5V+jNy64xFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg/QPIwBpZwjIWY4fTSBGSQafe2svQ7uAV4W1kF/zLs=;
 b=Sf8tBjqlkUhE0yHHLnEMWjId1YYbrZtV2O+BSJxPy/0FT0gYbb5C5GSJhwc9jHFd3quC4A5y81DzuFBupcdjPwILC77C5xh4th/5ik06cneoQ3yRG2Db+VfBoThfiyAGkFlKmgcJ9x/4zRgKmn5jJfrSIwOhRpXUkVMS2krmZS8=
Received: from SJ0PR13CA0203.namprd13.prod.outlook.com (2603:10b6:a03:2c3::28)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:45:36 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::31) by SJ0PR13CA0203.outlook.office365.com
 (2603:10b6:a03:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Wed,
 11 Mar 2026 02:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:45:35 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:31 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 1/9] drm/amd/display: Add debugfs to disallow eDP Replay entry
Date: Wed, 11 Mar 2026 10:40:33 +0800
Message-ID: <20260311024652.2668570-2-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 46aacc87-6a35-44a7-6019-08de7f184586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h/EyMRGYbGI0kMkLS7cD01nrJd/9ohognn37D3gIk1P/izLB3o8/JvW7K7Z2HZnoBdIVwBqTmfWV72oWjCwZX0QfxA4LgjT4R8ba4PJ5rxj832TC+EenO3UVuJE2FuSlBx0yiMrNpniwE2iir13AxpdO2B4hBsBCDMxFvzZ70lJ8daauFXhyUD34Cbg5U8cXaY3DM2ptcG0wz8a9dfcAq2vajRIiXaZY+6DGGBooxX6I6qClwSfnF5C5/E6P6w0iXW8fPRMT75OvtRhtfkRc0g5tt8Xp3H4JxYsIBalqqetdn6jjR+FPZLerzK0QFKqzkQbD8aML6x4exYjUvwqnyRxcVcQyBfPnwoohN4NywtKHP5Wn90Ub3PAmOUfe/KPUPxQusuvzQucyLTp1xKRNN+BNvykfE6IbS+saTkqUCpSOI4Ws4wDLcCq9MqNQ3udt1kIQZisklSC6aJDztIIsXQoWNOwDfX3Wes0/CAOkHEAobUnMDm6Sr8x4zQhdgW/CEqDU7Aiu5c7r0ZxhmXyFFPyB02dEoJby7AabVblFES9uFvGKKl7LxXs1W0th1yu3/gE3GgwYFvbqTDBvRLn2qviI0oILgPG4BHyWTcRwfZ8Fp55MRuhvHWr/A0qZHVxvEuhzbQZYWAwCGSkCTVr1qUObCtZS6i1HV3Z6+SEUk20rMgVZrV8QYk4xVXs56p4QrAlyk9pe5SBEvlGoIxvXNTpksBKcRZCjp1jCR7e+TQCaKPq0bmGDClCts+cYctODEFRrd22k6hFhAIuqtXh17A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNF9wLFZ7aswM29/ocWVSNB9u3zR4u5ZDyF1//8oBa0Ne5itawF1KkgTHXxYcjuM9ePi5lTCAH8InaP5I2bZaJgnYHGFb/s6KBwxxf5qyxycKzuQ0cIyTmlJkG/6Mk/oAA24qrOVhcu8jWK1Xn+/qNBsf478GxZVZs346G2pYuIW7YG5VGVByS1i1kj6Jc5Jc3LIr9f7un35Xl8jL7nTLurPyKfidU/mVsoKR2lhFGCx/zxjpFiUibw8+3odSMcl3VgY0YtvpOTgA/p42zq05Lqz44C+2Gl3NSNWMG6j84hQ9yztUI3BX9VI7YMtNUxxw7EgeKdbZjGBr442XtKPzDbwhFz/HhdTN8KTPoJIQ4KjzlL1PgO9+86w6d2KpGoaVKNf8aEb9t+lI0uOojxuB/76EHaX4DPVcMU/zRHmjJScQMiHt3Ax0MY/BYsXUaqb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:45:35.4751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aacc87-6a35-44a7-6019-08de7f184586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Test applications need to read CRC from eDP sink side, but sink
replay feature prevents proper CRC reading and causing timeout.

Add disallow_edp_enter_replay debugfs interface to allow test apps
to temporarily disable Replay for CRC operations.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d6d43f1bf6d2..7c6deb2764aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3305,6 +3305,52 @@ static int disallow_edp_enter_psr_set(void *data, u64 val)
 	return 0;
 }
 
+/* check if kernel disallow eDP enter replay state
+ * cat /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_replay
+ * 0: allow edp enter replay; 1: disallow
+ */
+static int disallow_edp_enter_replay_get(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *aconnector = data;
+
+	*val = (u64) aconnector->disallow_edp_enter_replay;
+	return 0;
+}
+
+/* set kernel disallow eDP enter replay state
+ * echo 0x0 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_replay
+ * 0: allow edp enter replay; 1: disallow
+ *
+ * usage: test app read crc from PSR eDP rx.
+ *
+ * during kernel boot up, kernel write dpcd 0x37b to
+ * notify eDP rx replay enable.
+ * rx fw will start checking crc for rx internal logic.
+ * crc read count within dpcd 0x246 is not updated and
+ * value is 0. when eDP tx driver wants to read rx crc
+ * from dpcd 0x246, 0x270, read count 0 lead tx driver
+ * timeout.
+ *
+ * to avoid this, we add this debugfs to let test app to disbable
+ * rx replay. then test app can read non-zero crc read count.
+ *
+ * expected app sequence is as below:
+ * 1. disable eDP PHY and notify eDP rx with dpcd 0x600 = 2.
+ * 2. echo 0x1 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_replay
+ * 3. enable eDP PHY and notify eDP rx with dpcd 0x600 = 1 but
+ *    without programming dpcd 0x37b.
+ * 4. read crc from rx dpcd 0x270, 0x246, etc.
+ * 5. echo 0x0 /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_replay.
+ *    this will let eDP back to normal with replay setup dpcd 0x37b.
+ */
+static int disallow_edp_enter_replay_set(void *data, u64 val)
+{
+	struct amdgpu_dm_connector *aconnector = data;
+
+	aconnector->disallow_edp_enter_replay = val ? true : false;
+	return 0;
+}
+
 static int dmub_trace_mask_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
@@ -3433,6 +3479,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(disallow_edp_enter_psr_fops,
 			disallow_edp_enter_psr_get,
 			disallow_edp_enter_psr_set, "%llu\n");
 
+DEFINE_DEBUGFS_ATTRIBUTE(disallow_edp_enter_replay_fops,
+			disallow_edp_enter_replay_get,
+			disallow_edp_enter_replay_set, "%llu\n");
+
 DEFINE_DEBUGFS_ATTRIBUTE(ips_residency_cntl_fops, ips_residency_cntl_get,
 			   ips_residency_cntl_set, "%llu\n");
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
@@ -3635,6 +3685,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					&allow_edp_hotplug_detection_fops);
 		debugfs_create_file("disallow_edp_enter_psr", 0644, dir, connector,
 					&disallow_edp_enter_psr_fops);
+		debugfs_create_file("disallow_edp_enter_replay", 0644, dir, connector,
+					&disallow_edp_enter_replay_fops);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
-- 
2.43.0

