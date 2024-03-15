Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D10C54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 19:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB36A1124A6;
	Fri, 15 Mar 2024 19:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFPf9vtn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2861124AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 19:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6pvuOWq+zKH9fqa5cf9h+wiEODf3djcSbGEdiq9GL1URhEThahXGW/M0sFlJLoNSi7WOlbjmS/eLpaOWduT8NkIc/9PEsILWfaZPMGp9ndwZtIF9nP5bjV0e0RHYcSnU2UrOfR5+R1es5L0uRI7M8iKRFJiu5WzPb1OUaTvYLGhpigY0LGcWtLkROsTP5hDXiReYndVv2zLW21cmWxATXOmhelKAEPQKf4Msv05jws3y89s+J5XaX/sRC03hukfKfJ7QyFpsYg/eNAwU05qXM8M/+gvJf1TSxoObcaEzCJWaV/JSkng8Y7smcKHY3GeIEsFAOAlfFmqnP1dMdmF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79MpokvqkFJV+1mC1ZtKDagfJkAju0rwreC/EOKjyHQ=;
 b=ONH2gTX1E7mqn9a5FUQFT+TjFUFnEJ+8bD7aHc1GZUOEZi5zdUI/K8V9Y4VSQOxCNXmVfDTQPS/xQ/GMAmt2wrrRVNgw5z7FawUSqh5ZsAawgp69pSHodVlHgyzMYRfjzK6TPDAG0rAoFtTBNUSeHhcmNXrAw5uszl4cEQjPgzFZwPpKToJqRgTobxQmy34HlQRqC/EMW9Ms/Z67n2qXzFqlQG9V4cw+/1WaOevoPXnM05Jbfad/hHtWG+a4m88L2WqlCAWvu6iDhPUl6DOq1WlVGtPCEcNBrzzq51gGxkEwtrqcMFJ5mdpIa+TEhso6mrMOAtdX1OsDqCPwAd7k2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79MpokvqkFJV+1mC1ZtKDagfJkAju0rwreC/EOKjyHQ=;
 b=wFPf9vtnJlhiWPH2tYr4/vbywZdtowBGldUjSVzfO8XgK4F83up9w6ysoSataRWfoWtwAqqaNbgmtSyw6PdDgQmVn62765g+wKTyAOeMAkuYdqeGfrqcewY5x62MVkJQBkvKMX0GbgXf16gqMtLHLE+ZoPHNaohKu+EoXoYfXNs=
Received: from BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 19:51:36 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::d2) by BY5PR13CA0014.outlook.office365.com
 (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Fri, 15 Mar 2024 19:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 19:51:36 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 14:51:30 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: sdma support for sriov cpx mode
Date: Fri, 15 Mar 2024 15:50:58 -0400
Message-ID: <20240315195059.862846-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315195059.862846-1-samir.dhume@amd.com>
References: <20240315195059.862846-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: b400f594-36ef-43c7-29db-08dc452952bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7i2r/Q+Qh4/DYbSHb/W05ZDecQNy/IloW/9/Z6CrAAFBPmQDMxlPyxNMUlJN3g2drHnfLwWdBP6KilGYFnE4eR/UzOvwpP8Wl5VV5TP9oVJZsaSfG91GqIUjPwuQof2bubfNMll+KV5wLKtCSvOw3ydOBhRkhMrTM7ggZNZXAgAmPnmnrYlTQcsPRJie/ZBPgY4MR1RynoH6RShJKn1rUb27LCuEkIxH9hkCXXsdLdA7QJoHjD1LamIQMzLbHzvX01AGkEx17onmELWFzzajHTFKfcMhou+1BGue0wlCgBHa0gTPDZEp8vVRRWayjmqezTaWfFo0pzunQ+Jrj02rUHUT+P60AWYvLBCWwt53dv8pnvZhvjv/qyIuAja22fkIVzUb6pI9S9TawxlWmfEEsv85E0r/ooE6/X8xgPbrN1NWI3KoO+bHYYUuxav6i6V5sndlbNvZVbehhQMbPdDDMcAQmDJTX411FAA2KHOyFekK48TNpgOBBjPpzrwFqm5ruf5+hIFfrxJaFv3nyhpzzEiNAMLOTQK7xmYHlmS2ATg8tXu0nM57c8rzeLCfduvWV9IaphR1OVBVPIWnbH5W1LbBJZXpVlyiKBlT7xyQgIa5EeNWKZKuxEDUC59tleUCBBnKMWgv/dxAP7XUdpVPfVvGuF+FldgSLqpQq6SY0WkGLAHH5SeelMYgFaXsvy0NiabF7sJGSE3k9yX7UvmAAZFGmZ9JtU05VWSf6WfiHPwI+FxU44moKDOO8qhrtAe6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 19:51:36.2491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b400f594-36ef-43c7-29db-08dc452952bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3.
Changes involve
1. identifying odd/even numbered VF
2. registering correct number of instances with irq handler
3. mapping instance number with IH client-id depending upon
whether vf is odd/even numbered.

v2:
1. fix for correct number of instances registered with irq
2. remove mmio access from interrupt handler. Use xcc_mask to
detect cpx mode.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 63 ++++++++++++++++--------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index eaa4f5f49949..117a7c692c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -66,13 +66,28 @@ static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 	return (adev->reg_offset[SDMA0_HWIP][dev_inst][0] + offset);
 }
 
-static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
+static unsigned sdma_v4_4_2_seq_to_irq_id(struct amdgpu_device *adev, int seq_num)
 {
+	bool sriov_cpx_odd = false;
+
+	/* check for sriov cpx mode odd/even vf */
+	if (amdgpu_sriov_vf(adev)) {
+		if (adev->gfx.xcc_mask == 0x1)
+			if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+				sriov_cpx_odd = true;
+	}
+
 	switch (seq_num) {
 	case 0:
-		return SOC15_IH_CLIENTID_SDMA0;
+		if (sriov_cpx_odd)
+			return SOC15_IH_CLIENTID_SDMA2;
+		else
+			return SOC15_IH_CLIENTID_SDMA0;
 	case 1:
-		return SOC15_IH_CLIENTID_SDMA1;
+		if (sriov_cpx_odd)
+			return SOC15_IH_CLIENTID_SDMA3;
+		else
+			return SOC15_IH_CLIENTID_SDMA1;
 	case 2:
 		return SOC15_IH_CLIENTID_SDMA2;
 	case 3:
@@ -82,7 +97,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
 	}
 }
 
-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client_id)
 {
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +105,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
 	case SOC15_IH_CLIENTID_SDMA1:
 		return 1;
 	case SOC15_IH_CLIENTID_SDMA2:
-		return 2;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 0;
+		else
+			return 2;
 	case SOC15_IH_CLIENTID_SDMA3:
-		return 3;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 1;
+		else
+			return 3;
 	default:
 		return -EINVAL;
 	}
@@ -1300,13 +1321,15 @@ static int sdma_v4_4_2_late_init(void *handle)
 static int sdma_v4_4_2_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
-	int r, i;
+	int r, i, num_irq_inst;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 aid_id;
 
+	num_irq_inst = min(adev->sdma.num_instances, adev->sdma.num_inst_per_aid);
+
 	/* SDMA trap event */
-	for (i = 0; i < adev->sdma.num_inst_per_aid; i++) {
-		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+	for (i = 0; i < num_irq_inst; i++) {
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(adev, i),
 				      SDMA0_4_0__SRCID__SDMA_TRAP,
 				      &adev->sdma.trap_irq);
 		if (r)
@@ -1314,8 +1337,8 @@ static int sdma_v4_4_2_sw_init(void *handle)
 	}
 
 	/* SDMA SRAM ECC event */
-	for (i = 0; i < adev->sdma.num_inst_per_aid; i++) {
-		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+	for (i = 0; i < num_irq_inst; i++) {
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(adev, i),
 				      SDMA0_4_0__SRCID__SDMA_SRAM_ECC,
 				      &adev->sdma.ecc_irq);
 		if (r)
@@ -1323,26 +1346,26 @@ static int sdma_v4_4_2_sw_init(void *handle)
 	}
 
 	/* SDMA VM_HOLE/DOORBELL_INV/POLL_TIMEOUT/SRBM_WRITE_PROTECTION event*/
-	for (i = 0; i < adev->sdma.num_inst_per_aid; i++) {
-		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+	for (i = 0; i < num_irq_inst; i++) {
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(adev, i),
 				      SDMA0_4_0__SRCID__SDMA_VM_HOLE,
 				      &adev->sdma.vm_hole_irq);
 		if (r)
 			return r;
 
-		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(adev, i),
 				      SDMA0_4_0__SRCID__SDMA_DOORBELL_INVALID,
 				      &adev->sdma.doorbell_invalid_irq);
 		if (r)
 			return r;
 
-		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(adev, i),
 				      SDMA0_4_0__SRCID__SDMA_POLL_TIMEOUT,
 				      &adev->sdma.pool_timeout_irq);
 		if (r)
 			return r;
 
-		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(adev, i),
 				      SDMA0_4_0__SRCID__SDMA_SRBMWRITE,
 				      &adev->sdma.srbm_write_irq);
 		if (r)
@@ -1541,7 +1564,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 	uint32_t instance, i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 
 	/* Client id gives the SDMA instance in AID. To know the exact SDMA
 	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
@@ -1584,7 +1607,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
 		goto out;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		goto out;
 
@@ -1603,7 +1626,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 
 	DRM_ERROR("Illegal instruction in SDMA command stream\n");
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		return 0;
 
@@ -1647,7 +1670,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	struct amdgpu_task_info *task_info;
 	u64 addr;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
-- 
2.34.1

