Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC0C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C45110E54E;
	Mon, 21 Sep 2026 07:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVHmKvZb";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B169810E54E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTRd/2Ho604aob4+GSutbr8D3x/OXUJghOHhb3tlScULNIeQ2lgKEOhticT5Jw6WBVtYD+2TsHmuWg9+kTJONRh9ZEAaKaoWlqPxq2M+W9LdngGzjQllny5XAN75+a9Qbot/W9Gk6QyEF/FrJdABj3Fqk9VNwa0oNQ+99kJ6c2Em/X51aCcBWWvfRBk67QppiS8BWwVxiteoLi+18VmDxfVrhgId3ZVRcLjGmt7PpQCwsxvlwuUNyNaJuy7BKn/IKUBxPXzXBlMtmUr9xt/U6eHOP/LE3hq8Hwg1t/tSKr5U+j4WM0DLn6ROSwkm/XeZPVnD2Q6dDWs8HqgB8b1rPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa6QoH2dmjOFctvnVWREYImTQUUew6KLi+Vy6/gzJDQ=;
 b=sMbSYCsIxgGKAl0ob51NbZuzdaHyhrcW2L8Vp+bipsgegzPMhxpfJ7O1VxP+Xjty0TdZ0cMIGEOiQ1S5VQ5/kmTdRxOrgPl9ejPJs+ycmoz5w+GdS9GdP6aHZ+Qq9EGdEOQnqwZbe/4VpsueyCNN7J4B8lFqjYEZeDgdRU3I0g54ofuocnWob21RhE7PHKlVXSAKNXa+FLzfknEMPHbmazO9bbUUSQJWk+Tm8lOyFZqzlAXHaX3qVIrc9qsd/pICuVQxjtHxiKxOXLO4iE1gAoraslAsT/G6lNoWZmUr9vPjh3Tsu8cdQurM8lwGktHdnGyjBXTaHmSvhhE5uZynHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa6QoH2dmjOFctvnVWREYImTQUUew6KLi+Vy6/gzJDQ=;
 b=dVHmKvZbfRqSIquweQ+ODO9p7c7JKs1TQxByl/gjVjXUR0HYFqYQB4mzAuyQd9MlM/YwQcXqfMPmpWfSQaFnD8s10kcSCILysyzpNF7cAMgqHc56O03xol4SUhFCs97ffskCIPodZx2H2obht55al74MRMSbTKEIfzxFtQ5ZKCE=
Received: from BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:43 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::93) by BLAPR03CA0131.outlook.office365.com
 (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 07/21] drm/amdgpu/mes11: read the gfx user queue VMID for MMIO
 reset
Date: Mon, 21 Sep 2026 15:51:14 +0800
Message-ID: <20260921075326.2409021-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf1959e-fbd5-459a-84e3-08df17b57531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RAXGd+OM1OfKpO8Xr5UNYS94aQplLo63C4wyV/JSUlWN/bdNq2JqTZhAG6qPoYQiM9TybM1RK9DdQZgqkB3kva7mgvtxscMGscuY+RpIgSI1KlMVdC5rZ/rKL4uV9Y5hwIRExgGbBZM1Bu4aPBmFc28iA+ayKCFmK16zEa5VlNorCbhCsg6aycbcp41Z0t1/zQcQHN6j3X+X5G4iCehpbN1BKOW6jteg0XG2P8mpB4biVbPOqJvOlpFU+KxGneQA+Zjx9xGQ4uhktg/EeDA31XdxH7dzyu8IK3enW/P9W9uxO24pRZYCIkcBPf+c6d77BwAAqFPZTBHEY8ZmROMH9xQA9C4fg4KJFC5cF4lDFTWYKCQQk+FMi3FyH2ahpqDn+LvEwHv3jhytm6FTQ7wGV2CvZO56z4/3ueCDMXy7b0Ee3ljinzQfg5gobXn3zQyML6IeoUBxLGPmoVXWor0/R0B/yKyS5FViE6bDWEeeozu3/5kx2ZFa8cp2n7zhsSsFXYEeaZG5aOTlg/N5onv7QgQmOaxZhJJgbj6OnSavLvvESPeFFOr6PVzhFBfobR9qNWr5I4VEc/xfUxvWNtvI4FXdxuO1t/mJzii655zaWuRvKwzADIhN9ZcBUA1V2HO0tE+swy54oFo3qrQeRMh8yu1Yy7ZBkQhawZCz9k9xIQ13SXBaCJnRYHz+XL0/4Sn30m9w17Vwj+4vVI+ORhj47A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YiDlBTYbvvnmAOX49Hn72vm5z/qpRRfi2eNiiJtskd9bl5o8gz2s4+Bb0Lo8IweLV1GFt/p9yO1NDqpGgdg335n9tu8FgOeg0L4tcQX5T2ous3b86lRTJLAxTo5i5DOiORLl/G0mJ27BdD7qFrpEJMX71lPmAY5aN8uo0LAofsO445nz6Ncsc4MDMyyDfZoSoGLBKtGmFxjN/AePSxyRruZkNmwqaWZwKI8CzYBdsHFFmMZpmz+osrZ87Vo8rOTZoTOC+JNScKFY1Ilq++aLCowCFye4LashwLL8BAZ+FCEiPqG6DMFL/tBqKu5rcp20SApoRGuCVNa+UXEL1Uqs1sp1CwhLsnSOZy+Mtn6t722/oKfo1KsAPoGWJ2AZUXJ0aq2Q//D0atQYxnpM2xtKNfbif1EQjr03QeDzC8j237CvON12mcR9cykXp2+1TWU3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:43.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf1959e-fbd5-459a-84e3-08df17b57531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

Read the MES-assigned VMID from CP_GFX_HQD_VMID under srbm_mutex when
resetting a GFX user queue over MMIO. Kernel queues keep the IB VMID
supplied by the caller.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index be3941ae337a..a019b1926305 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -696,7 +696,8 @@ static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 
 static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
 				      uint32_t me_id, uint32_t pipe_id,
-				      uint32_t queue_id, uint32_t vmid)
+				      uint32_t queue_id, uint32_t vmid,
+				      bool is_kq)
 {
 	struct amdgpu_device *adev = mes->adev;
 	uint32_t value, reg;
@@ -705,11 +706,15 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX) {
-		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
-			 me_id, pipe_id, queue_id, vmid);
-
 		mutex_lock(&adev->gfx.reset_sem_mutex);
 		gfx_v11_0_request_gfx_index_mutex(adev, true);
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* Userq VMIDs are assigned by MES; KGQ uses the supplied IB VMID. */
+		if (!is_kq) {
+			value = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+			vmid = REG_GET_FIELD(value, CP_GFX_HQD_VMID, VMID);
+		}
 		/* all se allow writes */
 		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
 			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
@@ -719,6 +724,8 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 		else
 			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
 		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
 		gfx_v11_0_request_gfx_index_mutex(adev, false);
 		mutex_unlock(&adev->gfx.reset_sem_mutex);
 
@@ -1162,7 +1169,8 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 	if (input->use_mmio) {
 		int r = mes_v11_0_reset_queue_mmio(mes, input->queue_type,
 						   input->me_id, input->pipe_id,
-						   input->queue_id, input->vmid);
+						   input->queue_id, input->vmid,
+						   input->is_kq);
 		if (r)
 			return mes_v11_0_reset_pipe_mmio(mes, input->queue_type,
 							 input->me_id, input->pipe_id,
-- 
2.49.0

