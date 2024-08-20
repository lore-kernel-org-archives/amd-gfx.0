Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CADC531DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 10:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A815010E6F3;
	Tue, 20 Aug 2024 10:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlUxRB0j";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B1210E6F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 10:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3gnq6uaASnFPbmsG77W6uFuQbDYr0Aac8fvu0iqAGuWm1Cfy83ednUMJnO2aUxtYrUBm37x6rKn0v6GSM87aZT6pZD3dWDrEwA1THjrIEttnLxrYymB7o7O5Hf0EVR0dtb43v9v/0mtNfLrMJ0hzhoHfhIvAhp3Tsxs6V/8iF/gVjdE7/9S+ujjCVhbxyu/3L8BvC9NWSLN0rtTBUOOVUJV5B3pZMuHbaCXKRlTNjC5JaYveEFQFaWYNLBvm8U6USBkvgZD0vgYQ3QExV2nMgl2g0YE7uz7wlPDCFWeiZu9n29B6zcSsRwAY5oLgSK4lgX8f8UW1k3YyDiMvaETag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP/Kc8gJkmWnDV0Fsa+98hIRJUCyErmbympdNTRvCfM=;
 b=iEKIPNXe+ff+SYCkr5GDbxkZ66n2zvc2spFNFsMBr4N5Kf7uKkuw9Hsj8WCu9g6rbwYW1Ienzt81iYdt+0hDEkbhrpTV6jeKilMq/o44KYUm9w39d2z810R66CDlGbmp9Cj3Egmki+M5L41WbQHB/l1NCcXoV3lTNwKxfFI4N8yK1C6I2A//YMeKtOyoeRQrxtB5/OKin20HdMXv3ak/5WbsrhBslwoOpxUE+S6mu5PZku1xdjZbAUyKNG3/yARO/OZmFbtbKBtCTGV/skXEA0g8xNEF4XzVcPLaZLgLmrsJfhDR+GojnQY3EHKmY5Kp1FAoEhZFX/Nm49STOslFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP/Kc8gJkmWnDV0Fsa+98hIRJUCyErmbympdNTRvCfM=;
 b=OlUxRB0jTAtLYeCizt4bIKAftTcRAjxzwTCjZ4h0noP0GYzRSwRC+swqXXkqJPBHmccAE1+w2/Tc920XzTe+tFoSAuaSm9eSmUv/MLT6MQbNv3hZJyE5H0TqkmWXV7zQmLVOZplKAcVqaK3oqh8mdX3fqYEkXeDHrUh0cYLHgC0=
Received: from BY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:180::28)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 10:31:56 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::25) by BY5PR13CA0015.outlook.office365.com
 (2603:10b6:a03:180::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Tue, 20 Aug 2024 10:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 10:31:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 05:31:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Le.Ma@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Date: Tue, 20 Aug 2024 18:31:44 +0800
Message-ID: <20240820103144.2831848-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: c931c679-dd99-47fd-347d-08dcc10350a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2zixkPBuw05hv273gZFscOMGm3m7A+ahR/yyTfo/SnitgrzmRvE1y9Abcq8y?=
 =?us-ascii?Q?ezJ3cTbYmKvamrvPLosKh6XRlOtvPK/TSybnGnJr4i1RKRqMKgpYa02c+ESJ?=
 =?us-ascii?Q?e0jMgle41aov5jHLGAxuYoq+zIw2zOGb6dr0X+mtWoZ7dJhJFW1qxcVruVpE?=
 =?us-ascii?Q?sQWscpJ77Zyv9lb3+wiuRtjh8tpPtLtNUE8UFqKeEkJ47JL9kbyHfuO8jyT5?=
 =?us-ascii?Q?nNNf339kXtKL4IMZmUd0d1C8zSoZnWWGybmFAeZB6qhZdz4KcAzavydVvJ/G?=
 =?us-ascii?Q?NNABR66s1dpHF7VmwseS8X4xP0SSF5Y00OJdyHo//ESyLbxKd2Ul6cjltsen?=
 =?us-ascii?Q?+KZKudAU3opZJxSXQTJPCr0HTE2sw18MvnCkc/3pdl/LlRK76BLNZNEfc/D9?=
 =?us-ascii?Q?dNeyF02flitINZXGgtj0ZfQYOnd+hbGN3LjcAg/Jss/RAun0s1YIkXe0B96y?=
 =?us-ascii?Q?XcgLaIuojYEaYssJanHRc4TjS0my41m8/sEE9CPC8MMcMlt4hgNZEYRZKvOj?=
 =?us-ascii?Q?FOpX0L/MLUSicomx6szbd6XO/G0xTDKbDRFhbX9GZ/ZJzHZcRMzdXzbzlFLk?=
 =?us-ascii?Q?382roDeELa5aPjktkljwLuw15uGEumheN/UfH4Dl9oe7NsvLuKeb5jLCuKVb?=
 =?us-ascii?Q?TMOnZIFpJ3ZhRAPOMAq4ixYnuxFm92heSQm/bz2QDmZIGHRAD6+MgHQBBF3J?=
 =?us-ascii?Q?MZHLL+9Dvt4om5VtHqA1nQyYmQ4aY6/hRB8zLrwg6J6t+VKV0cXLf+oiwdS4?=
 =?us-ascii?Q?ITUb9otR1CxyvSsDNktbcKzkH2KYds9pqgD62o5wDaBPe4NsY80cMPbPuHC5?=
 =?us-ascii?Q?r/UaZP19Eekfu0zDN9QFxEA7KPthxVeFdsA9Y5lWgXWm1riNo7w0n/Ipzguk?=
 =?us-ascii?Q?cG2MfwjIgjGpTAtHXk6dbdprFCGTxTmIFKPNKExAmx/wIPgoLgHJma+oCpJW?=
 =?us-ascii?Q?HSbCzbXCC494GI8yWb9ovAmGjQKvYPPWwVsKYbEAVe6F+c9cP+XC0DCDNhdv?=
 =?us-ascii?Q?WJ+p2dCfMUiSiCaZu6oXznogC3fWId6TRq4L5Cb6nAc72Azf6qUglcNIAhwn?=
 =?us-ascii?Q?P0ck3TkhhYrfGlwvNwcoc4p8JeTVUvxphAtnLKqrtDe4owiNSfMMhueALLzf?=
 =?us-ascii?Q?FaPooEGKfn45Dv+zzVR63J2kfS99qXkDC8B9DGrCrBnJWGlxpZrO13aRRNRd?=
 =?us-ascii?Q?VplTcu/auOgnWWrTK2HKYbol2k092pebqcnlgz5jak8Bc5xRGzOhCogBL3kd?=
 =?us-ascii?Q?PR+dZRyMMMy0LvDwo0soGsuHAt0+h7BZgTUJmPUqZ9lv4+3PkO8tqyfBag9f?=
 =?us-ascii?Q?3iInmWkdANjvA0C16v9dpaR6sEWYnPp9tZIz2twXf8jEsmK9XJDF5LxcSk/x?=
 =?us-ascii?Q?tcpUpIkdwA92m4DveLGavN+hrCywEVDuj5FDUuGw4bix9CzJXU6NWSZSUy8N?=
 =?us-ascii?Q?i3HdY6L3tlEv5rrFQTZs2lfb7cPw1rHP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:31:56.0296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c931c679-dd99-47fd-347d-08dcc10350a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
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

Implement the compute pipe reset and driver will
fallback to pipe reset when queue reset failed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
v2: Convert the GC logic instance to physical instance in the
    register accessing process and use the dev_* print to specify
    the failed device.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 153 ++++++++++++++++++++----
 2 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e28c1ebfa98f..d4d74ba2bc27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
 				   uint32_t queue_type, uint32_t me_id,
 				   uint32_t pipe_id, uint32_t queue_id,
 				   uint32_t xcc_id, uint32_t vmid);
+	int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
+				   uint32_t queue_type, uint32_t me,
+				   uint32_t pipe, uint32_t queue,
+				   uint32_t xcc_id);
+
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2067f26d3a9d..ab9d5adbbfe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
+					uint32_t queue_type, uint32_t me,
+					uint32_t pipe, uint32_t queue,
+					uint32_t xcc_id);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
 	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
 	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
+	.kiq_reset_hw_pipe = gfx_v9_4_3_kiq_reset_hw_pipe,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
@@ -3466,6 +3471,115 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
+				uint32_t pipe, uint32_t queue,
+				uint32_t xcc_id)
+{
+	int i, r;
+	/* make sure dequeue is complete*/
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	else
+		r = 0;
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	return r;
+
+}
+
+static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
+{
+
+	if (unlikely(adev->gfx.mec_fw_version < 0x0000009b)) {
+		DRM_WARN_ONCE("MEC firmware version too old, please use FW no older than 155!\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
+					uint32_t queue_type, uint32_t me,
+					uint32_t pipe, uint32_t queue,
+					uint32_t xcc_id)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	uint32_t reset_pipe, clean_pipe;
+	int r;
+
+	if (!gfx_v9_4_3_pipe_reset_support(adev))
+		return -EINVAL;
+
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
+
+	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (me == 1) {
+		switch (pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE2_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE3_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+	} else {
+		if (pipe) {
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE1_RESET, 0);
+		} else {
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE0_RESET, 0);
+		}
+	}
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	r = gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
+	return r;
+}
+
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 				unsigned int vmid)
 {
@@ -3473,7 +3587,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r, i;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -3495,26 +3609,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	/* make sure dequeue is complete*/
-	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
-	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
-	}
-	if (i >= adev->usec_timeout)
-		r = -ETIMEDOUT;
-	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
 	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactive\n");
-		return r;
+		DRM_ERROR("kiq ring test failed after ring: %s queue reset\n",
+				ring->name);
+		goto pipe_reset;
+	}
+
+	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
+	if (r)
+		dev_err(adev->dev,"fail to wait on hqd deactive and will try pipe reset\n");
+
+pipe_reset:
+	if(r) {
+		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
+						ring->me, ring->pipe,
+						ring->queue, ring->xcc_id);
+		DRM_INFO("ring: %s pipe reset :%s\n", ring->name,
+				r ? "failed" : "successfully");
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

