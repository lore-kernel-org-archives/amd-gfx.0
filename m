Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63D6C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D1A10E91F;
	Thu, 18 Jul 2024 14:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ajho0GyN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011A210E91A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di/8Fr8EQJ1VY/ZPgYqGIP7pyGvtOmNKXsY4kLEB2bPbF/DRaUGCGlLzSF/5ilpZrQj+j2dalRiszaeuGO8NnZ1EOLAS1oGlu1C/2w2nkPhuf8ivOEX/gjFcswzRjIr+kEm6Eyh93JTYwx/pQvFlert5f/DRQ+RxJbaRPkD5im4asOd4pzgUnd70cX8LWelXKVeCDVZV9XgYOYY2GPvaVsSyI2UfDLuhFcx16QNS/G+8Lf+u8dGJVn6Csp0c9bAU26ji23HG+5NmhQ13IwtD4j4eLx7gWj68+bXtWWc24kM4VUD8kKtxAc9Mt+h3rh2a8hM3oG20XY8mHeV3+g/85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDpKcD56CBc7WVQP8y4IPHa/I05D+zic0dg9RkMz0lE=;
 b=gvg7nI20UWZ4FnLBUZc7f0ymth3WN2Xlvfh6fcAV/4mZazWCJq5vqiGFWZcr8xOFO3cXkZgg7E9qWfx1v1lKUnCSz3rs3erexuQYONBetPhODyrC106jwV0QPdxxfRAXQnM/ELGT4SdJVrJdg4Fd8IoEfQG/fV6kEzRo542Rwlx0S8ydmHbEZSxLbOkKYWhpm5XZvA8YCKFiqY4RUf/p0gWUVu1dTMZM8DAJPVmu69dQpsZ94zaJo1V11qnAuepezFpgtKvAiVEdFWu914ynaWGEs1cplLnB7nmq9kuY8+YsQFbwkRZtguYQ5Mi+HiHyFgRMJcmdEuDf6rErG7AtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDpKcD56CBc7WVQP8y4IPHa/I05D+zic0dg9RkMz0lE=;
 b=Ajho0GyNdjeu1465MI07nYxCl+C2oDnu4mE2HkDSPxjLx/1S/tO3htKu/crnhtfiz+NVZFknJkL5b+OjoRg8e3jvfkRNzeUBj5vnLRuzLfJulSVYGeJH1JlMaWIbPp6CkTJ9E1a0EHybksYybVD5qKOMirwF3WsKBrvBQiCIs7k=
Received: from BL1PR13CA0066.namprd13.prod.outlook.com (2603:10b6:208:2b8::11)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:08:11 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e) by BL1PR13CA0066.outlook.office365.com
 (2603:10b6:208:2b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/34] drm/amdgpu/mes11: implement mmio queue reset for gfx11
Date: Thu, 18 Jul 2024 10:07:33 -0400
Message-ID: <20240718140733.1731004-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9ed9db-8399-46c7-0675-08dca7330ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2w8YcQrswAzA1c+ig8E1oOp5bx43VhsAh9gOw/TUF9HiVv48UNAE7cwHGZv?=
 =?us-ascii?Q?mO2MkR1srEQB/lmEak8M/+CjkjxaLJLxo1rNsBoS5xWtJS3QMb4wYC3E27h9?=
 =?us-ascii?Q?gWvgPouVMzmr8QnCn/rhrPfP9lHqGei1sxfhnhyQjBTnZPQeSvqtCztsKdcY?=
 =?us-ascii?Q?aaVVZsMEAkYp3kD/+1GImNxXbmel1H1ie5gm6Si2b55WjroOCep5UHF1c27i?=
 =?us-ascii?Q?jq1ENj4M8YWWNOlPBIjZi4xVxxdbZrXyHSBI+m6Vc9cIjZr+mn0Ag6n1SCft?=
 =?us-ascii?Q?ej89TGykkPPJ2EM5RRPT9fD83CT+A+2jzBNzHSV9eW0IRI9pYXXY4mKZhmtz?=
 =?us-ascii?Q?lTBqAJxR8elGuedWQo2/yZz/so1tj99ByHB2VKbeK9MqERwI0PPaqcRC4JgG?=
 =?us-ascii?Q?Xj0am+m2XaSJ8x2s5Wd2Q9jkMYf/3Jge1M2TVWVYKrTZiaYFkrjzbXQINDUP?=
 =?us-ascii?Q?J0m4NNJQTeulHADE0Obh9uXPknuHqACKF8gQs30SBRRsZpLYuUyxwcGkQefC?=
 =?us-ascii?Q?Tb6zCfH0nXr35cnBj1mQhVyv/OIYCsMgz0OV+Ha/qqE8cylMkrc2dj5xvIcz?=
 =?us-ascii?Q?ssNsBzKB2mq3sDmBQqjNmwdV+ZDmtrU7ZvFrD97m6GFAchTioDVtKYc5MBwD?=
 =?us-ascii?Q?/ZFlgxWnehZFmgZOlQrjKWlamyXT1+fKTIYCJ48Y5fiFahJZnFa869d1CIL7?=
 =?us-ascii?Q?ur/uepYeWds6EUFGu9cWIDyadTqSXp328+BpkDOh1qalXPtz1LsAm5xjVVdY?=
 =?us-ascii?Q?YPGwVKiSqDKbEYbmlDHU9fb6ZjI5HZNsn3zROhFbsocYLCUnOY2fh4t3rXKs?=
 =?us-ascii?Q?p4ChjQLeAD5sVo2NTsKpHPxNy7ckswrUuCec20n9jqlk7oliyiqQJ74GT0ok?=
 =?us-ascii?Q?Ik/1WiV63bFWOMgLIyuleSKVzoW5iukisD2Nedr3LTfsmcxz001roSOTWZqr?=
 =?us-ascii?Q?XBbFZZ1UtzRyZpVIKB1FzNmgRh5v+/xmvbRhCD6sb+xqHJjTyvrHpAoy3qde?=
 =?us-ascii?Q?XHvPyO87DeSTygExwZq+Xh81rdJV5hHqXPrnhWlQbQEkskJhPgQPFIAz+FAy?=
 =?us-ascii?Q?wk+7bUs183Q205gL5tw5ctMCraY6dzRs17m2RmvsDynmNTRGK1daJecEuZwA?=
 =?us-ascii?Q?UF/v0WWPKOaPOSsBhyal646gliBjZAA5XGJdwCSx2CPdMkCecROFw+QKvkO2?=
 =?us-ascii?Q?hYTrjWT41MIJmAdgNNBN3q5xQpYnAIsylTWoSlfEzTosXo2FlVYWOqni+hmQ?=
 =?us-ascii?Q?GuP/ApAJwB1hbqqDI7gMtuB/5tSfzki48CbrVyHPByktwLWkyYO6M0gI34N/?=
 =?us-ascii?Q?lhbH8X7YTF84xkXWati3m0ShDp1T+q9PcKzAR62gv0G8Ms8f8s3wUcL3ubu9?=
 =?us-ascii?Q?Q6sIYp9RzwEdlN5YkiNG2CP6WO7tKfeVCFZT8l0qbpOV5me3i1Y0LptrObxc?=
 =?us-ascii?Q?enVh+AjVZd7z66UHUJ7uJ5JVjASrXUvd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:11.5317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9ed9db-8399-46c7-0675-08dca7330ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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

Implement queue reset for graphic and compute queue.

v2: use amdgpu_gfx_rlc funcs to enter/exit safe mode.
v3: use gfx_v11_0_request_gfx_index_mutex()

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bf8fb6a1becb..fb617f6cef13 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "soc15_common.h"
 #include "soc21.h"
+#include "gfx_v11_0.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 #include "gc/gc_11_0_0_default.h"
@@ -350,9 +351,81 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				      uint32_t me_id, uint32_t pipe_id,
+				      uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t value;
+	int i, r = 0;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+			 me_id, pipe_id, queue_id, vmid);
+
+		gfx_v11_0_request_gfx_index_mutex(adev, true);
+		/* all se allow writes */
+		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
+			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+		value = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+		if (pipe_id == 0)
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE0_QUEUES, 1 << queue_id);
+		else
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
+		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		gfx_v11_0_request_gfx_index_mutex(adev, false);
+
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout){
+			dev_err(adev->dev, "failed to wait on gfx hqd deactive\n");
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
+			break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout){
+			dev_err(adev->dev, "failed to wait on hqd deactive\n");
+			r = -ETIMEDOUT;
+		}
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
 static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
+	if (input->use_mmio)
+		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
 	union MESAPI__RESET mes_reset_queue_pkt;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
@@ -612,6 +685,11 @@ static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
 
+	if (input->use_mmio)
+		return mes_v11_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
 	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
-- 
2.45.2

