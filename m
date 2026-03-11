Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A7FD88F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7546110E2F7;
	Wed, 11 Mar 2026 04:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XNuRdZsD";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E1410E2F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8yIqmraWSJh0g8xFg2guKmwc0FjAtjmb44RHEXAfwnrXmMT8OfqrJ4ZS/pr904RMFIk+nCWnghUhLTb4tIoHuQNk1q8lapLsWqzBIgngSUlDAn7SLuOSf+QyCKVvJodqKspYymF2oVybLKS2yPlziA5Lk6gP4acRbj3EN3n/F+3qYj/ERpq6EESaoGP4ZOSg6MPwn7fpicIuQHAlOULg3vqGaOjD2T1LFC9ZfqLxovfbQX3we2OZdJ9QyITQOUGE4G6TQZW7fJBqaNs/vwwVsuB1NC6aAqO13EHAfYnVQmnUpFrpgNE3utqgctlJasLPgsctPKVN+1+Bo6NfZ2f3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg/QPIwBpZwjIWY4fTSBGSQafe2svQ7uAV4W1kF/zLs=;
 b=OsBrXbxAu7yOvgmJzsBUm5B6OiWgRXMxWf8wFQRXDT+nh3nojtVQ7a9LKlmrOoGUgQoq7l+NIUwUHswxJGxDXyHTZhpGgeBI32C5hX1ejVDq0pl+9zMB5oZE7aTNVxIzbnKRni9tk7CcSIez765+SNF55q11pacNr1fSpZgSyzx9Q3W9r7mvihBaNzUzmqA8q0B6Lihc5e6N6rXDhurU3Tu9D77+9n1tnFi+n4m1mqiK0YULoaDsyQ1q5fuuPMIMd56D95pbu5En0U50ztaPofRCWR6HHcUo8Axl1oB5FRV2P/Np3PgZeNJC5O1gcT/JXQVCJWs3Ce4iJQVnVQL6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg/QPIwBpZwjIWY4fTSBGSQafe2svQ7uAV4W1kF/zLs=;
 b=XNuRdZsDuPXQIhceVsFBlZhf2BBMtfTXU6UElP/xixnRYT+NUkuPs7q1xzoqvGtMTV+P0UEuJvjpPh5iYm8Y1MliwjlGj/K0cDkaYqgbbH9TzVnpdzzwu00vmief+Jn85HjzVwb38jJmvifH8bc6qZXDNWOTVAj1T90fl/tVlxM=
Received: from SA1P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::24)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 04:03:40 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::8c) by SA1P222CA0029.outlook.office365.com
 (2603:10b6:806:22c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:39 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:36 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH v2 1/9] drm/amd/display: Add debugfs to disallow eDP Replay
 entry
Date: Wed, 11 Mar 2026 11:32:56 +0800
Message-ID: <20260311040501.2693643-2-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: eadf2ab4-8677-447e-33bd-08de7f232d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7lI5+qHB+VzUkkx45tWMgUs1JKpe5bSK2ObZrtdQHNBqYvYFN367pO2LFCxG7ez8J/irECRKcVrWvwvWOtzSNGeq/cvWL+sBdV2zHRcPgyMRaHkTtdbrjyZJiQ7A7XsWuozkrfIkrCXGTwVCgdPkKTc6SmacJz8i0eSizv7dLnAWVozO8nrapqgCXkZ9TjqflZpNtvmPT45GQ/oGe2Mi2rIjyiinG5OKvvjCz07Anc9kAjexzMn4HNvE/fXkyyXET0HWU5IVLjocuiaRNNAetoXG+HaPMqTZ4P+l5qQ677a9WiBHD1eM3Hqf/Yb2BNYCyTbh2AsYxI790ph+IyZetO7PZxACzpVPVZnDtGLNTpRRBoiPu4Ry87BNfGcUhiHUVM7Z3lyXPU6thuDF5r9x5ML+xGIIZkWdZ9wLjDmEHbEk1Zxadv/Eatl/gUQOJjSH4CLvoBQ8jK0kDIsKqXqKsEzBNd1VhUUpqeQykq82T2hTjk469mS9Boe6LJ/VPLpZZkhRoyEpTDgBkgk4A7DdvKHT8oVm0ZW7wNQ3G0GLJMj/Zew9xY13Qj27uD+RcTLcxMfPFa3xRGd2uJk+qvyykJnXbgBCIn5Lj6uIDGpc8WVcuWG/XPR7XxchL+NwaaU4Dzs4eg9/F6YkLcPmObHyYAYrdMHoRq+87YbwctblosmC5V068CS69RwLXyaWB5RXfSLRB9hxcRWiQCd09OFilALljdZbD6nI48GI1bZ/6xxVxxKafayr7xQWuMROftt4l2mvN2PiJMOjdVjybHmbOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e54TAMU8DBWrLeUuchwf5+tGCmAucJ2eUcSfCwWYbIoxPYhRDWmPuK2qlzDWiBh+cmcKIcU+VitkeUKJehCGdkZH07BhJQmA56xDQyn634AOj1q5hbK3xcZo9LwP0kCaqUdyjw+FW1URrIN95XPuBvCC7EgCAYzHzU9UiU4s9CD3IyJhjXX6oKZe5YX5U3FzRIqaew8W2qkQ6Vm9qEYm6nQmsCTyO1Gqc8wdGWpscqWzY0jpyyAozoE9pS9srgqq1FGqA5KhlUMoUjczes9IgkJrN/Jr9PWVhdxnVfEibwqfcI6kTkvGRBOOaqPTwz8695314e6dXXntqpK3yw+hRsfzqYGHlsjU3pLkyELRbkHxMRYAsakGH+ZpZ67YZr+2AhIv6+AchmLYquHb9TdjKj4BU/sWdbUvSi3aCf6275+ymR/MzYud4GWVKbR2Z90p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:39.7087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf2ab4-8677-447e-33bd-08de7f232d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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

