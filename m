Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F55ECE57B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 09:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A654210E360;
	Mon,  9 Sep 2024 09:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0gsAfYy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A19510E360
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 09:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2neaRBtRyXAznc4JpcaTw0Y1aEB0i8I4ZWCQdrltVCmeLsFUGKH+RWL7iL0iFuavk1A8V6b5y7lThNk8KsOhr03pN7uDQqT8J9InmP1g1VyDMl/m5B8rGMNHteFWlqNN+chv66v+/L39Dz8CsKQQ0ZmeD739Vg/rgRdttfgzDSjYqaHe2WZAng+w/q3TY8hXcQbpxhN31ntQ91Olopu+iyPwSLfDXEMFNKzBlegI53B2aCY2Xkugip30jwIxeEO5H//rqybuAXRz2LTWVBVthvRiRwhu96UrcyAbL89RedrH8UKIz4Hg+qx0CGl2by9+Z4F/mRCuLTXX3MaGOVQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wg4lunMpn9/QpQutH5Ru9LPzw0cN8F2rUx3yIrovsg=;
 b=ktGzWAbpDerKop7RxRlBc7rlXVgSoYZG4WAdf52f0DGbsBo0xHzL2GKEV3bSmtYn46Lpc/rqA7FKF05Nb0M5/vxRgkpnwYR/EsjECaUuv3pOl0TxgtkwVDBD3gMDoKoUIZGCfVL+EccPbPoTzJwZSkQJNOIBIHwy7gcQWjw646Pej35YxRSv+/Mu9RvXcYq59bIdNEU95kprGHMYoRZ0hT2vtHyEiqNt+/ACcUb+QCUJ/mJZjXm/sIHr0AhphG+VlbPmCzWuq9WLkgjm8lFR5NUkkzmj3xOw8p8a3ZXtm5hCdHIl9F1cmfkCL76ZXNzy8bH7dDK609nE0DSffRETHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wg4lunMpn9/QpQutH5Ru9LPzw0cN8F2rUx3yIrovsg=;
 b=U0gsAfYyNdfCgv3YhOybAt4XyQxlOh1RHGWKReoYyRCgx76n+llOA6TUV/+8V6i5S2jftg9WBq5rVdPYadSLEb8UaG8EZVME+ge0pux8m/wFsMiX0giesHZ1Qbd2snoCzxuSgv8idI6vXhZvPUG856IlVbY8lh27UQSfpuAO8Eg=
Received: from DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.32; Mon, 9 Sep
 2024 09:54:27 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::e7) by DM6PR03CA0071.outlook.office365.com
 (2603:10b6:5:100::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 09:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 09:54:26 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 04:54:25 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: update mes_reset_queue function to
 support sdma queue
Date: Mon, 9 Sep 2024 17:54:07 +0800
Message-ID: <20240909095408.1683-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: acaa1d92-df9c-44d1-1bc7-08dcd0b56455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+4zzAwo877xCozsiAg2OqoL4gUFGrtjD65fp6CcyVsqTgYtjMPN++ngqsiA?=
 =?us-ascii?Q?Jwi6hSzh90D3NvJNAprheUVwg2TRClw7ynvB9Iq+fmRGAdYdF6ceI6uzLW4J?=
 =?us-ascii?Q?USEmvJEiD10YI3yE81FcGNm1Hny6hekwK4xnvMHV65pKPCNptUYRflRrPl/u?=
 =?us-ascii?Q?MrhbYqZ35q/ZQD7Y3Ka6cXZ78iequYZ8ZWN4MCKVkqakPJhloNo0RyqOgnGb?=
 =?us-ascii?Q?fOwnLvLtm09IvWg1Du9I2uVe5V7tn+kMxpDvuz9irqL0dAu4GGa0kir2T4FN?=
 =?us-ascii?Q?RUzpotWYGeNBq1ub2vIPyXD2GRivUKTDNHQXax8SkozOnQsBEX3EBUA3LjsM?=
 =?us-ascii?Q?sSdDnKiZGBxakiKvl2uDZg1iJTgdcL/7S+OgXXuGELvIvtzz/ngCWOREbp1R?=
 =?us-ascii?Q?2EOrNZftFXt1WWfOWVbkWbwlxQnaVIG6ALoQWsRhjG5Mnf9Dl6/wMZ+FvHMz?=
 =?us-ascii?Q?APbPVqxV6D14yPO4qxcn7j2XfzpS0o6d9LZ8k+z2rfpuXDcEXoIwlmt8ftes?=
 =?us-ascii?Q?mLM8Fuage+w9GaevibHPJlShiQsNnCs21YqTBb9bqcGiwrJ33G2yBVgquOak?=
 =?us-ascii?Q?1lz1frK7/3c3QQzy+0cu7bGL4REQRv7elnw7ijS4C8uo0bI8z5c3TbMmfOgu?=
 =?us-ascii?Q?CfeDDwBIn8QQmJTjf8ycZv40h14zWGjW8kS4q2svnx6brScWnZraN4o5QYrc?=
 =?us-ascii?Q?nMnzJEF3lPNUKQuOY7cJmwF7TMjoCF2LwIMS0sSZUulgOlEkknde9AdOT2nm?=
 =?us-ascii?Q?rP7jndxF0/rhsFADbeXLWu/jV02IthCPv66rGzC+WGG9O0RarnKuVv+j7GmZ?=
 =?us-ascii?Q?uxVgUPV0O0lly93HnvpulDmztGf8IDwsaLKvMHF6WgVyevBtBM9+heLwLrvf?=
 =?us-ascii?Q?J21tUvytScc9b92dFzpQPpx/iVKZ/HRnFBvkVKDugfs8Ci38HA4OPCDRyJaP?=
 =?us-ascii?Q?orVs/3LH/qmf98nfoX5bJpshMX9hYY8JGskaxHV+3iADyXcSk24Tkq3w1XXo?=
 =?us-ascii?Q?A2LtH5NoAu8oPTY1qEhiqDlvn4hpSok2DSxI0lTjYThpsWH41H3XfC3YHCIC?=
 =?us-ascii?Q?jAVcr78j/N0gnRfosRjHTfhJfZfkZDXxQyirPJTzHybNZ8cUPqiUMhtHfZfc?=
 =?us-ascii?Q?/OP5fMzvuFSSQdJsT5W5vXIV7WThibm1iSwGmhCYAujNON5JsSIQr4xus3QI?=
 =?us-ascii?Q?D+tEQbVbh5oLPcK3q2Wh4Y5bCuVbFXoA9nf8kSCybq/kcIHCck4VnVy1g1+h?=
 =?us-ascii?Q?s5E0wktTH/JllSNIYMbT0JWQT9uj1wcsMibrV8M25fOfbg1YiIXogptXCvOA?=
 =?us-ascii?Q?COXYGBz3J+SOB1bOHe3jfJoy5XHVo3ptdKeTSTzFoHITjOvAxHwtgnnHIpH/?=
 =?us-ascii?Q?HWHnTigIqonwI903OO4eIBDEJO6QV04B6ImwNCA/12nKGYxRzFN86qF5kCyY?=
 =?us-ascii?Q?n1hff35uke2D4fP35WfKRsnry9hCU5Pq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:54:26.9475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acaa1d92-df9c-44d1-1bc7-08dcd0b56455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Reset sdma queue through mmio based on me_id and queue_id.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 53 ++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5174ed31ae5c..285ea4cdd5b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -914,7 +914,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	queue_input.me_id = ring->me;
 	queue_input.pipe_id = ring->pipe;
 	queue_input.queue_id = ring->queue;
-	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	queue_input.mqd_addr = ring->mqd_obj ? amdgpu_bo_gpu_offset(ring->mqd_obj) : 0;
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 	queue_input.vmid = vmid;
 	queue_input.use_mmio = use_mmio;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c4212b6fbc56..2b94a8e7f509 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -366,7 +366,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 				      uint32_t queue_id, uint32_t vmid)
 {
 	struct amdgpu_device *adev = mes->adev;
-	uint32_t value;
+	uint32_t value, reg;
 	int i, r = 0;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
@@ -422,6 +422,57 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		}
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		switch (me_id) {
+		case 0:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RESET_REQ);
+			break;
+		case 1:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA1_QUEUE_RESET_REQ);
+			break;
+		default:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RESET_REQ);
+		}
+
+		switch (queue_id) {
+		case 0:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE0_RESET__SHIFT;
+			break;
+		case 1:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE1_RESET__SHIFT;
+			break;
+		case 2:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE2_RESET__SHIFT;
+			break;
+		case 3:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE3_RESET__SHIFT;
+			break;
+		case 4:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE4_RESET__SHIFT;
+			break;
+		case 5:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE5_RESET__SHIFT;
+			break;
+		case 6:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE6_RESET__SHIFT;
+			break;
+		case 7:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE7_RESET__SHIFT;
+			break;
+		default:
+			value = 1 << SDMA0_QUEUE_RESET_REQ__QUEUE0_RESET__SHIFT;
+		}
+		WREG32(reg, value);
+		/* wait for queue reset done */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32(reg) & value))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			r = -ETIMEDOUT;
+		}
 	}
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-- 
2.25.1

