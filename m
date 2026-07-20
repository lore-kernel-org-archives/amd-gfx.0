Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2942EC44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 16:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B683510E9F6;
	Mon, 20 Jul 2026 16:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iYXIif06";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B174D10E9E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 16:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQMO+/XQ0UVrakaLHxxmgQJ4ENQkdmWfMDxcOvvxARaRZmkOjRldNSZEWNl8QBThc0l1HVZwctPs367Ic/C1a/1bFe72y3agVCTwP97tyQL3IuoG9PkTllgyUQKBNS8pzijOF891IgzFj7uo6Kbl6SKflHUE7Zkeds2GtqIopW1vYPK+vDl7TVdS4gV6EZ8dw37M7faxSsgUNOmekxP6yyoH5wK7EJMIV6Z/r+ZnOLB2N0SmFO97Etqv++NTFXtwIultXbUVTz4KoJoTQ//L46XHjA1WxbNnabWTatWh2w4OBU/jkMwKcIGbDt3/YQlgab2bgQDgAlJqdMn8Xe8onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDe/t37fHrdK1zb2HBKzKrYTtjnYSSodr9MH0gfnK3o=;
 b=duNDVft3B+VKq3QjhviRhN9CLxriD/xOsitNQxFEOP+x+JXGwDEJNXWl7lch10s1zhfpk0XPgHJKzf5pyEazoK3uTw79dFctf1IrYhKO6irinZcf3PNeF7dD/Nv+8p+RCC6sIwUu0oBD05ekZNKDGXC2JY/STmasXFCHADGwiITe40KIgNleRp4qeX5lH1nQZCx9tX8AgsweTdNeFeZ4E+l2/Nm5JWOnRL0t+98vISTQR6YNqJawa8Hgcntzo9mPb0stPguLk/OqQGSzsGOSwfKLbnLU4s5LgMICY1r3rP22oeaSlzk8LMFRG1K7eK3dEDd3JHTNKnqnHaN6cW6CSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDe/t37fHrdK1zb2HBKzKrYTtjnYSSodr9MH0gfnK3o=;
 b=iYXIif06yOKHOhKhA2g1AeWS7ZvtxMrzwgKi7jINMjz9j1uEtVmPK+tYw9nXCKCKFTrYT06L3EzcljMV5aofcewiHgXqlYev7HafSaaQgER/0tTh0I1YhYwqU1VM/H3yL3GefsGpUJLPho8MzFk5k8a1rsMwL8/21ds5A7AfjcU=
Received: from CY5PR18CA0006.namprd18.prod.outlook.com (2603:10b6:930:5::15)
 by PH0PR12MB999089.namprd12.prod.outlook.com (2603:10b6:510:38e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:16:58 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::17) by CY5PR18CA0006.outlook.office365.com
 (2603:10b6:930:5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 16:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 16:16:56 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 11:16:55 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kent.Russell@amd.com>, <Alysa.Liu@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: allow CWSR grace period of 0 on supported firmware
Date: Mon, 20 Jul 2026 12:15:52 -0400
Message-ID: <20260720161552.744674-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH0PR12MB999089:EE_
X-MS-Office365-Filtering-Correlation-Id: 290d8f6d-fafe-4dba-c709-08dee67a51c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: t14VjGigLFBQO95UA4s1WGanzyeCNkeHmYX3w5XcTy+0q3zaEG8mk6ma0eHRHk3RWt8nVMDJbpMIAxUNxWhbVI7Q/ECxzoY+NM22UTwL2AmoBcjaAxSnvsbsXbnZ9KxwUtJF0GHjIsMt59yU5h6lr+o95NbSGic2nZ3lgV0c4Z00eH+gDkBkpdqMAd+97SzZeZHDnIvCazjKdkH26e3vP3rlprrjG83ZwnSw2f9kP68hZUdLeqQNNJ/+AmjZvmwMhsdldj0zpEnmHa8jkjsL3b6E/tQM4YpOWdpmPvIMM25OWADJA7r/c+3qR/jz+az89PR+iPP6AnTFhQME4RYJp12L4bzupaZc71TbSTVY9XwVeghVHEXx1/A8N4DrZoYtEWjobvVtsfm17Stba0+bcYZTbkNYVB0HYMv5BYUJWTaU/RJ1na3jYChjIFK5clUuzc6XYgNUYS1xB0Ce8h5bDzBv1P9if5yu2wMQh8PC5MXjzUc5bLww7g1rx8aLEhFq31QEvNdHBc42TOl6ftEz4HFEFdGnM+xhGeYhSRFHUZPaWdRcVikL33Ex628LStzVu4zdC0NmoyfFmcYRy8YxWscjx7v/8BkldX0tUoyniFlofWD/KjBi3TdJs/Pes524x8UaFQhBz22rgnGw24YHNEVwyHzU7S8izYDVi6ophDYHqqibPy8OQKVQHmkB+Nci8uaXxMmmb/D+TmF8q3XTkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2X3fjNgE/HSVngKZF3rYYpWMB4eFORkBPHR2/ZQUh7PdyozbEUYRbv7FAp5Oqh/qwHIovAyN8Ama0CHqmVFgQmr2qJ//+lejVyefmAGsdWspVxkY5LlYTkbDL9QeU3WfoBlacdwr3HX5S4XmKvT/jltCgkfj+oKRoUmmNwSkuKo7c7vDVMuklPeXrqaSn3risH0aR12OeVjcaQGCft6B4ur5DXYuJ/LEleUmkjTe5I75t7xcXam4I6i1tYDOHd+MSaWuLh/rcxj139eMa7Fk2Jda/YOtfqlSOTYsdu01Rk8IL9xrfupfCVHBrSBBzgJ0L2w7h+O3nZe8nzYoFPiJkvSkRiYZ2Kc+YWZqsot17OeKMXohtwHTlbiEgzD3r2LDae21UkO1WkjZc9/qaRkZorFjt3ykOZnBDnXmEE7upyINXGJsfFNErfjc8E1X331A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:16:56.4407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290d8f6d-fafe-4dba-c709-08dee67a51c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999089
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

The debugger sets the CWSR grace period via AMDKFD_IOC_DBG_TRAP and may
request a value of 0. An earlier change clamped 0 to 1 unconditionally
because most firmware revisions locked up when given an infinite (0)
grace period.

Firmware has since been fixed on most ASICs, so gate the clamp on ASIC
type and MEC firmware version and allow 0 where the running firmware is
known to handle it. Navi3x always supports 0. MI100 never received the
firmware fix and is kept clamped. gfx9.5.0 and any unlisted or future
ASIC default to the safe (clamped) behaviour.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 66 +++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 3d2375817c3e..e4092ba81fe5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -309,6 +309,63 @@ static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manage
 		reg_data);
 }
 
+/* pm_grace_period_0_supported - whether firmware tolerates a CWSR grace
+ * period of 0 on this ASIC.
+ *
+ * The debugger may request a grace period of 0 via AMDKFD_IOC_DBG_TRAP.
+ * Most firmware revisions locked up on an infinite (0) grace period, so
+ * an earlier change clamped 0 to 1 for all ASICs. Firmware has since been
+ * fixed on most ASICs; return true only where the running MEC firmware is
+ * known to handle 0. The +32768 offset on IP_VERSION(9, 0, 1) accounts for
+ * the SR-IOV firmware version encoding.
+ *
+ * Navi3x (gfx11) always supports a grace period of 0. MI100
+ * (IP_VERSION(9, 4, 1)) never received the fix and is intentionally kept
+ * clamped. gfx9.5.0 and any unlisted or future ASIC default to the safe
+ * behaviour (clamp).
+ */
+static bool pm_grace_period_0_supported(struct packet_manager *pm)
+{
+	struct kfd_node *dev = pm->dqm->dev;
+	uint32_t mec_fw_version = dev->kfd->mec_fw_version;
+
+	/* Navi3x (gfx11) always supports a grace period of 0. */
+	if (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0))
+		return true;
+
+	switch (KFD_GC_VERSION(dev)) {
+	case IP_VERSION(9, 0, 1):
+		return mec_fw_version >= 461 + 32768;
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+		return mec_fw_version >= 461;
+	/* MI100/Arcturus never received the firmware fix; keep clamped. */
+	case IP_VERSION(9, 4, 1):
+		return false;
+	case IP_VERSION(9, 4, 2):
+		return mec_fw_version >= 63;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		return mec_fw_version >= 96;
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 1):
+		return mec_fw_version >= 146;
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		return mec_fw_version >= 93;
+	default:
+		return false;
+	}
+}
+
 /* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
  *    register/value for configuring dequeue wait counts
  *
@@ -357,11 +414,12 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 		break;
 
 	case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
-		/* The CP cannot handle value 0 and it will result in
-		 * an infinite grace period being set so set to 1 to prevent this. Also
-		 * avoid debugger API breakage as it sets 0 and expects a low value.
+		/* A grace period of 0 requests an infinite CWSR grace period.
+		 * Older firmware locks up on this, so clamp to 1 unless the ASIC
+		 * firmware is known to handle 0. Also avoid debugger API breakage
+		 * as it sets 0 and expects a low value.
 		 */
-		if (!value)
+		if (!value && !pm_grace_period_0_supported(pm))
 			value = 1;
 		pm_build_dequeue_wait_counts_packet_info(pm, value, 0, &reg_offset, &reg_data);
 		break;
-- 
2.34.1

