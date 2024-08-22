Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC98DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 09:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB7B10E81F;
	Thu, 22 Aug 2024 09:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="epvRV3eu";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BE010E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 09:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgCPi0bmNMKV7roui2VJ0cM9pkQN1vCPG1IQKfq5gYLL+v8tTJyHnADJUN2vRAC7Jvc524ZbXSF7WuH7T/QFO14hliT7LEZ7qW5B+6Igco6tyHNa64oszR8qCuw1OUaamC+1HCbteFyrGfVQuYSIZCrmR888jlhwe5Wn1OgfFjfP+KxuhFe3oM6XGav8VXNVd6Br1M4991+mckEK/URU0G8heGiwwYxSQDk/dfL+tHDGc0/Uh1qH8Kx9TX1reRAQgDG080EDZZlJyLZwkjFV4qw/SAqE7y0zdpjGkpPWdQ30/x8Dd0INYwWAzxRzXbJtK+DxPjSqe/NFcp3HsEW0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em8w/8TYm14T1YKfGu5wzK56zTKgcPtmYQGW5LYtYQg=;
 b=Mxc/Brck+cpwzsn3vhKBCyfvfFJpfT15r9X2asyzy4yhaSd4L/Vgz5al22vrOflJEV7fhDWd5GEjHsVXmZC7Uu7JYWUm6LSi/jhpUHLCpwtsy6X1WDMlco+lyK5cHMxWqWycSabynSfGyQNqVsWc1nBssNrXlkr7bXv+ryYUJ/QjuZrmxBz68KUfI91u9ROGtDN3g/XqehJ5aX0xm9TEvjxaNXYboYZr52g6lyXWuUIpgbY4cDkKamX5esTX63TieI3FbMBtCxF5v5o1puwGj9r2jo8K9VC7kaH6N2rcQVdNz9aTZhSs9qP7bYjzQUvYLjN31YUL0fkjwn5SxAtVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em8w/8TYm14T1YKfGu5wzK56zTKgcPtmYQGW5LYtYQg=;
 b=epvRV3eu6uFPfDVaRp/oBu7cslKxohXWGADZ0Z8iUBOH+puRRM1HYFd3pgJHdFHeEzewcs4NZCfneaaHE1jJXPgAmlolKBuMAQ2MS/eUa3bnRRmEKHRMB76aPftUt5w7iM0Uzfaah7xAWgbmMObbwL1Yr7GOCAYHvWARy9OGFsg=
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 09:38:33 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::77) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 09:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 09:38:33 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 04:38:31 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Le.Ma@amd.com>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH v3] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Date: Thu, 22 Aug 2024 17:38:21 +0800
Message-ID: <20240822093821.2846207-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf13d2c-fc12-4c32-290d-08dcc28e30bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AFiOLxb/wGtEHfYDqBr5SotXHnCNM++6f9Emu8Z6tAVf0C7V1TtE8CxtY3Mq?=
 =?us-ascii?Q?oKBtMzPBCqpvx6QhoAZtA5TeZKsUw5Gw/Vk6WOvgSBuzwrI8sk4mxipyFQat?=
 =?us-ascii?Q?Yg+r7GVXElWp8QUOUkzkzU/Ho7rIHgYNWnEqt+doa8kjljbtC2nrvEzHG8OV?=
 =?us-ascii?Q?vaLVDvg4JbewFtwNw28TL9iu7z3+/cplOCM/yfQIHIq55AAhrkdEGamKdbMd?=
 =?us-ascii?Q?VArMUq0ymNK8moUz1DIu3ft+9dmd5C5Mz9djZE36S8iuqPNQjVh9vXw7xDNA?=
 =?us-ascii?Q?/HigJZmxSjPCNdbSR/loEhZtQjnbeNK042jiix47LaZca99zW/ph7Fg5JoCY?=
 =?us-ascii?Q?sYmqYmlCQsZd1BCqquDgcuyPVMOcJ3yjqK2PFfXf9/PVrcSCoNb4ntXtd8Aj?=
 =?us-ascii?Q?YUnhFAYEYlieWhExZlvIXJhWU5KNg3x5NDejG/GkMHI973y2jYdBRLjOZUj4?=
 =?us-ascii?Q?DhMOYzLzA53kesOO2Oo+CSssqw40DEVnOSYHOQiwyd3gKiR9NLEFvgVqShq3?=
 =?us-ascii?Q?Kj2j560+0EUy9iyjiUQ/Q2paWBp8j5hVo5iIfC6G/j9HDzPmsee7+oAdLAah?=
 =?us-ascii?Q?AkWii4c5+zL/V0wodIHatJf+8uREe6pkeO5auLAE7yCk5awc4cMs19yBm/Ln?=
 =?us-ascii?Q?sdwk9TcpwpIvBJ5MvsrTXGKG4EX1EgpkIbPPDIJ9h2c+eQaFogHJMGyRf191?=
 =?us-ascii?Q?8yhc6Rv63vMqsbGvmJVE8/xXkilF7JGOQue5F9ECiSmI+mJGmvdOPn84FfFr?=
 =?us-ascii?Q?D4yQGKJfnu+IuU36B3ZmZfzU42wIWv8oatMaLEK08RMNRGO+grziitAhIHQp?=
 =?us-ascii?Q?eolT65+R+9d+U9YOd+d500DEcLOVWbh0VRxvF0b/rdEcx+1zcxZwKJkMQIWZ?=
 =?us-ascii?Q?nmmx3AfxHGseZnQ3EUEHS5BchdCgkKOizk+5DuHLYF0P3+JEz6QU9WfQE/9F?=
 =?us-ascii?Q?LqubeVMSq7uu6f0srMsC35PQzRyJpdpq6dZuK82hDenkPXu9ikGn3QRsIKsZ?=
 =?us-ascii?Q?t0TA4Kw8tH0v0OmVWHSuzg0EGPpfs+jTPMajYrDb2jf3JQMGO9YBv7Z3m51U?=
 =?us-ascii?Q?5OntwlzT87sTbt7lwW3zjUL/ZbBU8FKZVj1mHG3Ll4aXsLxQPJdqvHAe762p?=
 =?us-ascii?Q?2qp6CMahotksxOmgc93wR7gkYSC61uk6TslKOGMZq44gTKZ5lLn5zy46WsOD?=
 =?us-ascii?Q?KxXt/z9ZZCtP5ZmX4jerpz++puGtLJW5WVhLXiYbu+yPXEOXXOAeKVXCaSzV?=
 =?us-ascii?Q?2zT+q6EHBrqXb0fWPfUidCtdK0+MVGglDJVfHTB1wWBN08Sd9py5x2yDg4CS?=
 =?us-ascii?Q?S3zoMrFrKt7TAMIikTI/DK18eSrO2RJGeZ6GcbUBGIM6xCbCUTcfiTcgGsUa?=
 =?us-ascii?Q?kmX1EaDerUNkoJfLkKBF/+cA+D2WiDhZ0DaYJDSB79bP2nPImGilzc3NQAf/?=
 =?us-ascii?Q?WaGGiR15EFrepoVLgYghK3s9D7wB09K9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:38:33.7859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf13d2c-fc12-4c32-290d-08dcc28e30bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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
v3: Use the dev log and filer out the gfx9.4.4 pipe reset support.
v2: Convert the GC logic instance to physical instance in the
    register accessing process and use the dev_* print to specify
    the failed device.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 154 +++++++++++++++++++++---
 2 files changed, 139 insertions(+), 20 deletions(-)

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
index 2067f26d3a9d..aa0c76eed452 100644
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
@@ -3466,6 +3471,116 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
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
+	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			adev->gfx.mec_fw_version >= 0x0000009b)
+		return true;
+	else
+		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
+
+	return false;
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
@@ -3473,7 +3588,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r, i;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -3495,26 +3610,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
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
+		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
+				ring->name);
+		goto pipe_reset;
+	}
+
+	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
+	if (r)
+		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
+
+pipe_reset:
+	if(r) {
+		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
+						ring->me, ring->pipe,
+						ring->queue, ring->xcc_id);
+		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
+				r ? "failed" : "successfully");
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

