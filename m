Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB76CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192A510E582;
	Fri, 22 May 2026 00:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UslouQ1d";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF2310E57C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp2rJdY9cvYo1AJ+Ac2yjB2kxtE+Xf+DpplPbJ11zK1zCIvCtWGq6OYnMYD0/uRxqteCHzGvkFDvcw74DVWfMtXcvywWeG4PWZxn6CxfAkV9pGOIKBtPOoMz3NXhEIvPUf0RMUZSu31V1kQ675oI92cwsgFTr9snoZRDqOtl9Nt2qrHU06xYU4Z5hXzk3r7xhVcvmlf8ne52Os4ZpusLAuKMgh6Pgw0MGgR6NSXREl45Pn5MWACrsHrZYJrw5T7v6u12KaEVfIhXFMvySvVlRIaK95NWR3RLdo9UYz0CSHPEJBQxkL5fBflMppWWV0LIOxYETaP/u1AhZoj3YTjGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPTKXq2RFlEXBo25shdzfSeYxmz6n1biKxPpnuBuwbo=;
 b=SDOM72SCjK9LIvpDgyYFiET+aFtBGfUzBRePs3LwnXRk7j9XW1bRMG1vZF0+HZMsE5KfAwAbZkVT6l+SFdlDyaY9Ze59hFfJJuXtG4OTdo6dagH+4bEPYlhJowfx1Dx0bJQ3MF9wuEdhtyoSQ2ukmjk/h5qNnwjTGZKxw1QjLGcxYGNi9uIEapz04+1ux1+z0FWQ4iBPPcPyWf1IW2KxW0ztj3AYLApLpEDmTvOvJ15Lalsym35JGsu9nxFhbP8k7zZOuqqiMd7TNDNZ6+ZBfQDSHsP7fv/5sbV2RsCal+iGLkaSh42R+BRWP9vNeAdMgn3bT0SjA7khVuPxblLDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPTKXq2RFlEXBo25shdzfSeYxmz6n1biKxPpnuBuwbo=;
 b=UslouQ1diseCis+KyEisZ8evA0Mm7isVY9vcrzCekBw9uTcAHBgr6CL8x5xVQKsmFouv7BrhNfGclu9gkWQG3BQhWA+C/Aa6WBHqZOK0LPumZiXXjoTJJfl65RcTNB+pj5Huu7ee2Sx/uQeE9ZnIxxmL5HwwsiOruwEsLgVvIUM=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 00:21:33 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::d3) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:21:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:21:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Michael Chen <michael.chen@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 11/42] drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy
 queues on unified MES
Date: Thu, 21 May 2026 20:20:17 -0400
Message-ID: <20260522002048.98506-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cede0fe-58aa-478b-b723-08deb79813f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2ycHmot0bXd1/4bHk/U1Q44PXwg29RiiGvOZJxH7cJ4OEiBnHzrnjmWs6v88/XkRvSPoAhRAPruu5sDytA8jSA1NMsLEX3URV+b24vS7pBE0EZVmtA9mF9iJuiEacNQE7HRdtdyZOxo8IgInvq4AsnYs1xYDFCuPYbuwRPTQmEJ3Cj7UwTZmhCthTXlEXUKrSIMvWbMVBftUN7XFh405ya72/M7wze9wtwPfMS1csosxmWPdSB7g3tY9MP2KHk0ggeBfv6fZJO8OiF7rUuaAoVHLsdlaFDkVcVOLUjqu9ShQ8F9Ghdm6d0J12BX4DWoFF322k3LoQv02jnYDXQwBeLCT6XIrVQBKH9pc71nJaVeOIU5gRJxriXl/YZfCn0VjCd4aPalM0/LFBKwSACnocXSqZNBn8AqWt8I8biCl1sQstLTSgWKu/3qwCUIx/fr0p8icjA1uCICgFK28i4242umsrIrv4cpLfei7kvcDkdK88TjG5DifvhReNE8fYwGazNt/xDixTcWZoPJkWrsF4gXf5IcRYKxgrq4JvtWWSHAXi5lp7DkKwBUwqx8Ad4FDH/IzYvXsZe4k7MaoFx285EyJebfQpCFq7KIhOY8r3uorXupg1OsVr1TwjsbCTyad6ftUNxCO2xiHtF4bFuIlp9eETelK0v69HofBjWEo1gXnVIPXh0d2xiFnRuXKlo0CR1nPiDG2p9lL23R/7+1LTUNUXuuFYfT9JxBYP83P/zI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EM9LwOT1Bepd2U/XLOnpJeU93OHgY3P0Q8vrNHDPeNQsg3X2Qs37zzvf9J2tydrdrZJ7XAn2xrK/wm6bq7YcuucvYa6PUzaoDy5wIRUXmH+mbakDDPv+bbP+z1h4K4XtOBi6gPSDXpchJW2ZMphuDwRVp7wTX5BxK6wOqTs+w9juYK6wcDRhmPi9OqGbAhCxXH6kSFoMNxXBqbIezjefuLh729bqtuitQ6h5wZWirz+smWwlwbskaiHOH0hDBeygNPcqAG74Nq3G50BVnOGVMA/jheWwcMQT2umPR6op/EjTZCELRV0BLTjh3vSVWpR9Qx1JykSRm0RX9KfeqBMU7kBKHU5lNhIBnNQe5BYorKyCgf4WoUdwHgifmJQ5yD5yykoXdr2+/cpuP5rO1opFaUCBtN4OoKzW2JePjf7Qxai9mbE0Rf54kFxmD572OqZ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:33.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cede0fe-58aa-478b-b723-08deb79813f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

