Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA792C98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDBC10F728;
	Thu, 24 Sep 2026 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dqnagJdh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C829F10F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhwj/cqg7tWwi8WR5LHkJS55HEFVW+wuCB2HViBBDtBzSJQ4a55HTSaZ/hfwVf8C6tS1Dk53odTQXR5dIs5n7lcTwBtrdy+nloCAuRCNaYf0eBFrwsX4OzHlLhotwsclGar+Boj2m4nfnh6Lm/NLCJhbLJ69FWtfH/ndYchTKO33ifAMHrIA2GcVQ6sF81exydgTVdf386gSR1TwZNB9KtsUZhZN1p8DFvP49TE5SpuYwmoQMTYeSO31m1R7eny45CDvuylHMAm+WhYzQZlHWs9ztAVxEv4Cbrz8HP3Ks/ozVh+oxrHrnXxJtexs/MLGkLMUaC9zqIW6WG0gK/+U3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDmAIpRwHwnj7jw3dA1rOq1KZE/d26WoDMhXt/7e90k=;
 b=hUM78IzbuiR514liL2rK2qFlV0jsmkbVguRKEc0yRjQHhvWUS3ysDC0HUwYMZohZGBf5ZxToUc3V/od/7rye26FIM4/Fxm1kFkxJoQkVeVkWuClmjorf1luO48HY039urIk8pGewbPqJGd5JfFQkYWvz1WziFjg3j+l79gvkX+9MEK/jBByu5659OZKYB5bp1b1nY+YlFk6z/z8hndELmU/qKPnaKMF9NHSGD6Nuieje5x1rMXxzP056Z7rrQmFxNuS7H09xjM2d2tJVDw6FWc8oJ3SYC7d2+MDhAasvoWqL/z7itb8RrqdH9M04Y+xIbhonvNA32jbMByH7hnZPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDmAIpRwHwnj7jw3dA1rOq1KZE/d26WoDMhXt/7e90k=;
 b=dqnagJdh1cv/DAFQXurerBzChsX1Fes0PmuBHRV+QnsA1qwbDS5sh9Cm/7i7nq3/EAbsWnepgMvnd7uaTmgL7qcDven7bw0FiCvu9LsDi4Zbtfe8AVR9+1R4LXtrHEl8wReH3XLXQbH9S6OH7Y2/j/aeUvM8fZ1FNPRYdmrwHsg=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Thu, 24 Sep
 2026 18:46:20 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8e) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:19 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:09 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 11/34] drm/amd/display: Skip HDMI FRL status polling while
 link is down
Date: Thu, 24 Sep 2026 14:45:24 -0400
Message-ID: <20260924184824.596894-12-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: d396a370-bf8f-4e87-8be7-08df1a6c1fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iAn7SHsFbppIrynDD/PfV1BXzbGdyIgrsTZJ7k3RdhYqqERmtO3/LEMAFL/7YDuHnMVVmbhg0tb/nqTDk3ALyHFexSjtZtDL8brwEixnwOmfYdmzKK+0VMV5WieCsHLLXIVaRdeA96gctJgZeap26SoOmdv0kP+TZoiRB0wsnbnhsZiBLiOoe1fYtje4/WOyyVxVx14IZlMAbM3wRjDH+Hy+AuXAYB5xoSHmQ45OQ91Oyz5xmQIb/o2Idjw1yDbxkngABeiG3iM8rXJGcR7NezwDInPBPQ1MZOEKqMFUMV42u1jT+jHUepLd2wTskPrQ1ruA5rBylM9Y5xPRiGMR5iQb4AxGxp8s5zrIfJ8vB3yeVVwXiJzu0CMHFwkZIheDXB66d7PZXi2Toe5NEfwyqmHnULEkZLLgZi1To9zzm6tNqKSPopnVmaz0sRkmO/RX5l3EhN41NT7r2MQqsJNjpQyKvlira9byWgvu+L4o1UF7XSgdqLA5+TRA8iMe/g48F2m7qvPdacRe1qLdSVVPSC0ddqarg6ICqHGKQ4Dg1wG4hkndC9HzycUj0qOA0zDp274p2VC3PBZNZ23xojym6LM9DDeFrfnJF+9ky9xdV4ztVTlmSa7JvKFzl419RlS+09t8yDXQo9o/j/f1dna2v2Jmyn13/Vky8504Gqks311pJVYGi+Z9WjPfYXhIx32g+C0lNPgV0pyc9Ava0fqprQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3pR0Ly4AX0yZEx3wL64JgXEX6OKzd9o7FwbsYfEnpUil+H+YrpK56ooJsgrPD6CjYHzPypVT2SkylMnK8qisEtS4eecjahvnLsrqc61ifUrh2AAk+F33KYkNzy8Mw8IYYKkkJvDUJoAtdCbRP8DHVZN9z3ahMH6cW44izDCLH6v4zgp3mgIqMqNWfFPijwhRgWj5y9s4SLEHpClmxYcUhxS8yAG0SYGtrSiOfDExZVkDLrVS6Wx4HVCXOzPPusaSGV4KI+ctbecRKH88y4vxuMSZtbwvBzwsgld7davdsztV/T4ykX5KuOwWKu/p9Sn4AHCXhg9YvQuEZKQs8BZYpweXjYi/kds+3cl+HROg+R3ARrRNcaQRiZwvsQX4FPTk5zI8psiQc3JUh0kOnUJCJbgBAT0gH0RekAu0HoogvN55wLbs3sads7oTf5mXPhSv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:19.8032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d396a370-bf8f-4e87-8be7-08df1a6c1fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

[WHY]
Hotplugging an HDMI FRL sink can wedge DMCUB when a poll-driven retrain
lands on a link whose PHY has just been torn down. The status polling
path can program PHY EQ on the disabled PHY, after which the sink SCDC
reads back version 0 and the display fails to light up.

[HOW]
Skip FRL status polling unless the link is actively driving a stream.
The check runs under dc_lock, so it is serialized with link detection
and modesets while the PHY is being torn down.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 6 ++++--
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c  | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 3255f5b2dde6..5c43bffd36ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3125,8 +3125,10 @@ void hdmi_frl_status_polling_work(struct work_struct *work)
 			if (dc_link->frl_link_settings.frl_link_rate == 0)
 				continue;
 
-		link_update =
-			dc_link_frl_poll_status_flag(dc_link);
+			if (!dc_link->link_status.link_active)
+				continue;
+
+			link_update = dc_link_frl_poll_status_flag(dc_link);
 			if (link_update) {
 				link_detected =
 					dc_link_detect(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index bd55d943e4e5..94eec1da3a4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9026,6 +9026,7 @@ static struct dc_link *dm_test_frl_add_hdmi_link(struct kunit *test, struct dm_t
 	KUNIT_ASSERT_NOT_NULL(test, link->local_sink);
 	link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 	link->frl_link_settings.frl_link_rate = HDMI_FRL_LINK_RATE_3GBPS;
+	link->link_status.link_active = true;
 
 	return link;
 }
-- 
2.53.0

