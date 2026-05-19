Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2625ECD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4F410EE14;
	Tue, 19 May 2026 18:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upiT8+Sg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0517E10EE11
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7bEihrAPJGW1R7wPq618StJDqMT97XiLaPtRWhVT4JChAI5GUBmGLsP7uKXysLxgnXSmHRCb+9P2PJU6CWRwbBczJiryL5Ym6ikJHrGIVk/M+B5m1oKiGcn5Ro0HIvmMQnD4/nxOvoWqbofS48nzllk8i4BZk5tnGXE9LjT9NBQDGekjGIX7unzHtAWVSZAbK/3eFqAKffVcEvQ9TKxRvtkwNc1Z+6YK4XiNiHt6zNX79swm6pNb83GP/+iqRreuKLON89UfzIjY5+4QEZFTot3CEcMR2ho4JlAyIe1jR/eVM26MXl/bo9jsiTIyOJgeNi9OZ5WC2kOVYM0c2xAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPTKXq2RFlEXBo25shdzfSeYxmz6n1biKxPpnuBuwbo=;
 b=NPvNOYfHikjMVaGx3j4CZAydRaMFrP7a4TmNiTqBBJ2p0jzDWiZ3RuBTLcevdqSAunNUg8x1FKFUYm/3YPgXEUs1so6OGFnCQBykj7s+9tOivD2M34qsxx7zaQQ6Kf3CRghVgUArv8lKHnMjANk55cq5OvNlvuob/f8zE5vG7SjcRXp1v3Xxvy6wUCEZZq3JxYK/pu9IbpH/Lgdmm+mIBo/sGtS+xhGlH52iAGV+ynM15BZxraSjHP0BGumV+mN7cCl7uzLi/g6VzE5CBoPLLQ/KowXBq/Mym5zNziyqteMhIoEN+NkJlnZR4vLprBZH4RCcIK0b/yDj0HF6xNpVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPTKXq2RFlEXBo25shdzfSeYxmz6n1biKxPpnuBuwbo=;
 b=upiT8+SgNTpgo/uWtOXFxLrS9Bbw68eRAnVAoAAKpMaYYrH9jKeofi/7hgjJEy5FcNosb8IS3JxirJvZGy0Bb9WpwQpjRC/y5oROHdkJIcNVlLugiKU87f7/XmuovDBgfLRlbNI/dwbM655RiX2J8UbPMWcIeYgzzxx7M67GDzY=
Received: from SN7PR04CA0102.namprd04.prod.outlook.com (2603:10b6:806:122::17)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 18:32:05 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::99) by SN7PR04CA0102.outlook.office365.com
 (2603:10b6:806:122::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:32:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 19 May
 2026 13:31:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 May
 2026 13:31:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:31:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jesse Zhang <Jesse.Zhang@amd.com>, Michael Chen <michael.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy
 queues on unified MES
Date: Tue, 19 May 2026 14:30:50 -0400
Message-ID: <20260519183055.22275-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519183055.22275-1-alexander.deucher@amd.com>
References: <20260519183055.22275-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2946b13f-b895-4f0e-b9c2-08deb5d4ec10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7dtQCUIZyXYIS5kgRgfI2WMcGz2u4ebYBCgQs1KeZovx2SgzaYD2OhRVUmJ229aBUDkoAIQTVgHC+MHGsUxPClF1ActXbJSTCkogOq/eIO/PQMex2U/czZro+fOV24ZM8krt6l5yEbTMojJC4Q1dpOQ5SeOdRbqI2XNvuHB8JUBPw1Rjjc+QuqFh7ANN1dh0vKjxdotZkTPGpat+niD6E2E5vS0K1WjHou0zkiE3wtbfkhXckMMiCpyqlLuwToUoQB+1RXOV71iN5W19jxdBxS4X8U7f5U63oJhXNlgS/XQTeQ/JRbpBhNfRIcRP3GGNKYveLaYVLJlxSNNBAY+krWUYCIby20YaA6QMWJzozJByuQqnCwt6uGgv7Q6dTs/LEK08K80R5iwHl7lPZhcnRQ1+1A/9arOsPYCQ+s3lPWPNkyMuZwvrJhLBfqYtW30mZ3kEcuX1a+oSL4ncmwRL/XHTjTINXwHjd+qYfkxt2KdSQao9mNeiZam12h2ddsYU0J6FtTk9TXb2mWGU4P1e6hcDcOrSZDa8U6V3giyUmFolA42wqFp3pTz4umofkPSFHOM0KBdsqeLvhQqIQRqjMr1YQ1Om2DnQVOqRoQbdz+fZwg6q/6bRMJ9GUOnILBxm4R7O/XTTF29Qxh6Dfh5BfgHqEu04vEx1rw+22Tl3KzM5AZbrDMcxs2L5w6osdtu/R4VeZC1EzbIC/mLyEWk6OfTljBxiWMW3NrAd/mGlIIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s90KXJqb0ibdbLzpCrj7su4OkUxmDsHVCC+RL5zsjgVQkahUs//toD9cCfJEZkGSHgMEvWy5CvshWKowvchCdJkObWd7EOaxuUdzFj9aBubAcoSkpH121rIs67IjPEIg+Bupf/z3Oc2/k/AiasuRFptTLq6as0Xmm9caIoioPbMP/5apkZ1PJ7V4jnY64hHyW1ZCiBEDX+tz+aGoNq6zm0Qg3Lu8B6ou4wxy67fwjgZdk+YLyajdxr8KD0eYjO7vj+tehxw6DQZeqylr3CPIfV8xHWOSex0uxk2U+WcIxKnjrOKv5wOsqNJzPHgHpVv3bx/zccjBMHEpu5F4pSu8b8e1H6VtW6CoW8ENEU078t2OgZ7MsCbBjVPDmVzKOhIu0xyHCN1ZkLVimybgKDkySXvMQhyMX1RUA7eDbKQn5yoRn0aG8bx672Wt0mhP09jo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:32:03.0742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2946b13f-b895-4f0e-b9c2-08deb5d4ec10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

when suspend_all_gangs is issued to pipe0 MES during system suspend or runtime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, leaving them in an inconsistent state after resume.

v3: fix the schedule pipe issue
v4: use schedule pipe for KQ resets

Reviewed-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8d618df192856..36886c2d5c5ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 		convert_to_mes_queue_type(input->queue_type);
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; map all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
@@ -567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
+	if (mes->adev->enable_uni_mes) {
+		/* Keep scheduler queue on KIQ pipe; unmap all other kernel queues on sched pipe. */
+		if (input->queue_type == AMDGPU_RING_TYPE_MES)
+			pipe = AMDGPU_MES_KIQ_PIPE;
+		else
+			pipe = AMDGPU_MES_SCHED_PIPE;
+	} else {
 		pipe = AMDGPU_MES_SCHED_PIPE;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
@@ -913,10 +923,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	}
 
-	if (input->is_kq)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
+	pipe = AMDGPU_MES_SCHED_PIPE;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-- 
2.54.0

