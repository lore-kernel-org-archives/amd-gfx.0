Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1876E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F6410E5B1;
	Tue, 10 Dec 2024 07:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fQViz3F";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CA910E5B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4yzNdH5ED7boSZONld7HZ5TkvDlVW7u4zgO22F4O4uYdRIl62NGoLQRKpI0fWjA+BkB9lgKuJdEBkOX/9DFaCnaLcBUdDcyTlQCj/BHAHBDGYrbA7gG+sxkS9P1ZQEQD6SE4v9wLa/IsntVFV3npi+Pv6auUFVAhHfDfDgxPQmsOWUSRZ8DYSjRazlyL1crBcVZa6M9Q/NHjhfZc6P/kRAWChXbkUfNzb2Pl5T0sBarxIicsRObmkp7ko/JnmHN+3cB1lD78rjXGMttFBtGv5ZZnK9ziX1AEHxnyFSsmLcb7fCJSk1lnSr8vaWskR+xqDGmkfn2MEmHk5U6HWZqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkIavlwKuLoHbgIYavC0MEWDGza+eB1O1rje6epX1gk=;
 b=L/WNWNM7vlU6rNKhOm2v2Jt9HbUz5lSYTcrLoC6K7B+KbDciKgLlxwUTLjQ3dFcVW37qb9mOKKwalzO9LGg3rhSk4J1k+uvHjJvhmbS1x5oIZ7evq89iiY0SbwP8Wy2sI/j/O2RFIXYH9QiI5iDg2z0QWsu5fYhiSZLmVErC+NXKqtCFpY2uLME5OQk8dkwNFHZihnd3qhgttUU9pw9MYTgcdxIGnsxPlvrx3Zf4xnjZdEb3MzZXH6Z+ES4lfwTtAu0ymm+a1FG93Hu2WlQ9kaJ1ZzlomQVhlhwy8I11zTZWEQGNftQJUcprfBnQJbaS1XSILnvLbGw4KtOQNjnsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkIavlwKuLoHbgIYavC0MEWDGza+eB1O1rje6epX1gk=;
 b=5fQViz3FdxsViBcmDCSBR75qpBYK4IFQ+Lhh0BkZFKlH0+M46Nte0WP8PgN723qhT4gF2TQQJGlndVJeD+E7rp1PAEHlI0lryfJOk8XOSgUAbZd4zh0W2qxIx2hJo+qiTMwudj08cyM7WFByRUxqoG3dRtBS0UIzmNof02gZjGI=
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 07:54:06 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::75) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 07:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:54:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:54:05 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:54:03 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 4/7 v2] drm/amdgpu/mes12: Implement reset gfx/compute queue
 function by mmio
Date: Tue, 10 Dec 2024 15:54:02 +0800
Message-ID: <20241210075402.2183295-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d9c058-1c36-48ed-330c-08dd18efd22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7QQ4Q2uVHZvr1G0tJNI6Z4mCPNIBaEb/0L0t2o1bJyjpUNdoNLUNC7Es3kHu?=
 =?us-ascii?Q?2W3BcHoqodmjgpEMZ5+YfiMW42Qnol9XFQXGZ+pizG4yP50xmTLsa9K8I2GX?=
 =?us-ascii?Q?fkDNRjA1cs/2hYFlw9TWvkNRsRLH6/QfCVYvdepi1jaLQtOYZJHTZ2Ctj92c?=
 =?us-ascii?Q?PILYn3nyYLdiza/ktckUshesb2UZY5OupWM5/D8vjO0gW/SBVSjEU8+OHRdu?=
 =?us-ascii?Q?MvbsSCdTBO7eeljujhM3mr4YhtGnttNwEc2wPrOK919D9OFqSk9aES21AZOp?=
 =?us-ascii?Q?ipz5V/aBkiv+jNhdbxFCrm+gd0EzxWoVPFaC9DMj87bl1tla71X5WuzI9gtB?=
 =?us-ascii?Q?qTfEZe6bism6wIJyXtA89xfHzwUDWrL22TyUbwAC+h0/he9uZ4pqDsy/tpfD?=
 =?us-ascii?Q?Ed5pek1gc8AsDVWWP0JZWHJ8ovULiQnPlteflyV7YMi9RY0g6h0d3U3eNULa?=
 =?us-ascii?Q?erMby6HuVX+juuVKz4b1S/BLowzWtxLlj4Bb01HyFHnNleqGrbBZ77m66fzQ?=
 =?us-ascii?Q?kk8PqRdH/cPqw04DgQvNy81UyMrntG2M3djOAcqumnvQGLyLKvLz6v34LPSV?=
 =?us-ascii?Q?j6g0T9bWo7TU9WE9KLfLraiKF1pgeLg3wdv73JPoLKxZraa5RN8n6cMEuRfO?=
 =?us-ascii?Q?u6CtPdpq4fNxpC1ltZEUQ2EFnykflupOpPsmJuQoXGDXTWKCgRA4rQ4mJAk6?=
 =?us-ascii?Q?4SeRRVuQUs7qHEtqEOdJM4mK8yJkhOElTHIJ4QccFD6Grh7Uc9lS5mEfkw1a?=
 =?us-ascii?Q?c6pmY4Da9e7BJTMoqgGE4RNuLt5F0zb/ViZxt4kuomcjO0xe+vo60zeZuX74?=
 =?us-ascii?Q?EJ1dayMIIw5cmlzbQwdCoQJk2FqwOB04Q32tZVocnpvLUXKI8r7IGAh+EI9I?=
 =?us-ascii?Q?X4FUaJlYxUh62ZNM8VqqUTDLRjNA3WqKHVjTTXuH//o7xGW3is2gyBohF+EE?=
 =?us-ascii?Q?I666TVqwTX/pHFfuIi1W2AuGeg4DwDNJSGH41gvLQKJSSdwrf6jhS/L2NfOG?=
 =?us-ascii?Q?NXXnpFvGwqbLWpeGHMnPX+lWLvLCDRWEaB3v4b1TgyaPugJ/H1OZFW4JXusd?=
 =?us-ascii?Q?JeOO1uc54kuizdvRRsLyZ14vHHmbHPNpyBxzo9iwIjXcTlz7FRY8/lBp7pLj?=
 =?us-ascii?Q?wLSgPHHAEmDzRp7yYn0vEqjjPRn4t/A4hTGou5d+JHtL3AIkyqyvyNuvKnl3?=
 =?us-ascii?Q?ZDVh0FWZWASeuAqUBcm+k9raN55PRxFANSLOjI5I72+MiDQOTYr3ct7iAY8k?=
 =?us-ascii?Q?6bXXZ3ytcyMsn3ntQw1sluvOA9+CjpwKVSermRxvYXzclq6QxwsZksLHGtPS?=
 =?us-ascii?Q?ijA4D3cwQDMo78gfYprAsy3j9l+oA7x/Vu2fBPdgwS8lARFix4tZquX8Ef8a?=
 =?us-ascii?Q?CMiogSmLityc2xQWNt//TjB/Hg6dckEoQRXD2jBcditkEHcF/2ci3S4PWghS?=
 =?us-ascii?Q?6+vaIjwiG3d4Fc+rYK61DGo0fCLmXbNc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:54:05.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d9c058-1c36-48ed-330c-08dd18efd22b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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

Reset gfx/compute queue through mmio based on me_id and queue_id.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 88 +++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h
index bcc9c72ccbde..f7184b2dc4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.h
@@ -26,4 +26,6 @@
 
 extern const struct amdgpu_ip_block_version gfx_v12_0_ip_block;
 
+int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0f6635ee84a5..d24a0e7fff15 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include "amdgpu.h"
+#include "gfx_v12_0.h"
 #include "soc15_common.h"
 #include "soc21.h"
 #include "gc/gc_12_0_0_offset.h"
@@ -350,6 +351,38 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req)
+{
+	u32 i, tmp, val;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* Request with MeId=2, PipeId=0 */
+		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
+		WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
+		val = RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
+		if (req) {
+			if (val == tmp)
+				break;
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
+					    REQUEST, 1);
+
+			/* unlocked or locked by firmware */
+			if (val != tmp)
+				break;
+		}
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
 				      uint32_t queue_id, uint32_t vmid)
@@ -360,7 +393,60 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
-	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+			 me_id, pipe_id, queue_id, vmid);
+
+		mutex_lock(&adev->gfx.reset_sem_mutex);
+		gfx_v12_0_request_gfx_index_mutex(adev, true);
+		/* all se allow writes */
+		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
+			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+		value = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+		if (pipe_id == 0)
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE0_QUEUES, 1 << queue_id);
+		else
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
+		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		gfx_v12_0_request_gfx_index_mutex(adev, false);
+		mutex_unlock(&adev->gfx.reset_sem_mutex);
+
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+			r = -ETIMEDOUT;
+		}
+
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on hqd deactivate\n");
+			r = -ETIMEDOUT;
+		}
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
 		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		switch (me_id) {
-- 
2.25.1

