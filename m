Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD811C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 09:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F245110F4A8;
	Thu,  3 Sep 2026 09:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fr1N0/ma";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447EF10F4A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 09:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AneNwTMrX9TympVX8Zzb/QisE/IeId1fw5/Z7eUdnht4fGx2FIzOzUyAR2ZkBTyoOiWfBRvFK/zVN6MHzrsA7T+tDektd7C2hUvOeuh0e4owBtUcEro2pyLOXv40QPZY6VGtFfIHPzRyqXRmS1rC85PFjmxXK9In6D70l/7d5hwadXmZvhCz3QlhELXJdNpT/AHtHO854f84UokH6/vlMyuOps0oph3CZwaJnf1p7GVZkuTKQYFmeacLRB38J4P4PsCTZjvAD1//udHGB7VQpBTnN8xF0l6Ex9bRI1qPu6/umjPNrH6u0n8eqgyoQgNac0NL+tUwTxmm+U0usSGKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYgphvDEDERSM47pRRtHHelpQ/lZDlNeoktyv9FaUHs=;
 b=DBKMwwM4Y37SoMG+R1CevouDlUlX4HNkY1nu5YmrUFo9EhM+qeHQtoQduqWesWe/jtEGuEmWZtKCyZu6qpb7cEzL0it7V0h3smLP4F4Oixua7kBs5JRDnG8wu4JLT9PzZfxqDNK1FQyIIe00j5iLQ6eVa1qFc0L//ya3NJGRR2mvkSwM2BzdkEurIsGLZ3YofwvYT/pshET9GpVNUzOgPRZ2Lh9D+flp8vIdAPZhWQAo6rpswF1N6daIKpV+C7ozF13B8j5V5GNQxl9KjN0uevSIH4WWjT+A5LnOtX6lZzV3mmvbWPVYVFYL0KHFsmofcWRKVsFJq8GqygaIsFJgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYgphvDEDERSM47pRRtHHelpQ/lZDlNeoktyv9FaUHs=;
 b=Fr1N0/maRmxp4+bfZ1teHN+/faqfYEJE8kYWsx2ec66eKbho2qFpwKFJ5RRI5Bi+BngMJyARWrIs03OmgJdioldS341FLDmnQ53l7PzBg65JMVXmS/WM4D8OruEQn2T8WYP1zZa+lvkTqTtYzmEf23pemGe3VfWu/KPF8DyzqY4=
Received: from BN9PR03CA0934.namprd03.prod.outlook.com (2603:10b6:408:108::9)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:44:43 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::a6) by BN9PR03CA0934.outlook.office365.com
 (2603:10b6:408:108::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 09:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 09:44:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 04:44:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 04:44:41 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/sdma6: implement detect_hung_queue
Date: Thu, 3 Sep 2026 17:42:04 +0800
Message-ID: <20260903094438.3880682-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
References: <20260903094438.3880682-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: f180687a-3f68-4a3c-054c-08df099ffb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z3bfF1YeiTxCjE8vtsj8Sp+HrkRYouLkHs8M99buC2EPsIqTw7QEJqpuUSC2GCup6uXpb4FojwDBTWXVlZWuP37sOQKLVkScpw7Ldw++v6k4zdq8NsWhgc/ETEB2G7QHCtXwocv1/bdiQDrQXW3mdFj2sFSyAPjZ4BNiTf64aUDRNNbZ14YApORd7h8TpaN8hPjD5cR903nWZRGyHHGzfuG7wKtm1c29wiELy917cTm7UxlAfbsn5rnFZaKii/uIciMHw/A66VeQxm6GA8lp+3YnhvwgfcwcApx+F8Cz4W7aU3egHnBValEo6ROZcHyktrjklOLdNjTWFPjxYjhZbX5e1WwitIFDHD87/xKwgopCGrsuZF8fBAxGmxk+XVxNdhTEuxpeWIDGlrMDujh/uRd6CIHJ11zApX10mWOITZWqgc13VBLZ1RqvYlxhkDEH50d0lMtM3618GIFvsUiGo6fZYgVpDlJVxLQ0eH0hXjFo7X5UrFLhUff69TRH3i5NYQZBgZmKtGvEIMkK0p8x3UzCdze4WjyI8uCC50c3p9/6ZNUhphiGYEjRtqiXF93u87/VGGbzN6Ba5yqu0iAazdfcqju0reowbdrAfpwia6yAl+Z0P5B4S2DBPHyCfMOpFICx1I+oPJjPdgxyckrtE2clpEYcVG2xoxZJKKbFIF8YtvLtC51Z/tDvhwouZAx0reAaaday4ggmqHS3lVWNbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4KiZOiysNEM3t9U6rFsp6DBhienKY4iYxLrDCvcdcNYSwOV5Z7NssvM3FrZNmiJMwKcygg5N9bVDvqmL3gz2iS0LI7H+3V6l1wXdFaXcd+t8Zwuo+BpKtX1sFyyDlPzU8SysjkK95Rz1AfABFnnKzTM+942beqjoOYvWe3QLqEqERDG3VhcgLhDSdab0ZMVFcQl6+pax/9FyzBRoMLM4JyhoYvgO09OWnXiS2iZwdl3rA4Xyp16IakrhQ9qr45/YhMgDwPt5+ALQfaDyoJQnkYyuUtGvPrqbNT680vcgCW+ZO5k/AeSMylOKRyP18u2rpm1QNEKHHfeq40WrwKYo224NoQeujeexnfaCk8McZkV70L/hf7xr6peEeHGlvx3qlnqhGKW8ZXThg8nQuNUNXKaG0TcCRhldOBMsshT9uFAZFW1izcepZCn9oPFz5qUK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:44:42.6377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f180687a-3f68-4a3c-054c-08df099ffb15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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

Match each SDMA queue's DOORBELL_OFFSET register against the given
doorbell to recover its (instance, queue_id) HW slot. The per-queue
register stride is derived from the named QUEUE0/QUEUE1 registers.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 303fd7d1b7c8..0b64eb5b32e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1556,6 +1556,34 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
+/* dword stride between adjacent per-queue register banks */
+#define SDMA_V6_0_QUEUE_REG_STRIDE \
+	(regSDMA0_QUEUE1_RB_CNTL - regSDMA0_QUEUE0_RB_CNTL)
+
+/* find the HW slot (instance, queue_id) whose doorbell matches doorbell_index */
+static bool sdma_v6_0_detect_hung_queue(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					u32 *instance_id, u32 *queue_id)
+{
+	u32 i, q, reg, dboff;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		for (q = 0; q < 8; q++) {
+			reg = sdma_v6_0_get_reg_offset(adev, i,
+				regSDMA0_QUEUE0_DOORBELL_OFFSET +
+				q * SDMA_V6_0_QUEUE_REG_STRIDE);
+			dboff = (RREG32(reg) &
+				 SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET_MASK) >> 2;
+			if (dboff == doorbell_index) {
+				*instance_id = i;
+				*queue_id = q;
+				return true;
+			}
+		}
+	}
+	return false;
+}
+
 static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
@@ -1762,6 +1790,10 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.reset = sdma_v6_0_reset_queue,
 };
 
+static const struct amdgpu_sdma_funcs sdma_v6_0_sdma_funcs = {
+	.detect_hung_queue = sdma_v6_0_detect_hung_queue,
+};
+
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1769,6 +1801,7 @@ static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		adev->sdma.instance[i].ring.funcs = &sdma_v6_0_ring_funcs;
 		adev->sdma.instance[i].ring.me = i;
+		adev->sdma.instance[i].funcs = &sdma_v6_0_sdma_funcs;
 	}
 }
 
-- 
2.49.0

