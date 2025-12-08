Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514ED3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DAF10E481;
	Mon,  8 Dec 2025 17:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KQqAKlMd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9046F10E43C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNydzD1IY2mWgDhE3/UsHRhvuYohEF6JAGyy5Q7z87gNMaFAURPSYn1e+eCzrSboqzO5E+fAQHPjjGnZfmG8fIlhqdKFv3ss4KgFm/UjOK2CVDtqTTBZ47e2S21u1hU/48YkcUgbAy1Sps/JQCtmuMT1Q9K5bL4i4zx/erRt9EqC9guSZTEFbTxJ02wIJChrRc9eBMXo4VsBy3JmCn1YdtcreL/DP95o6MEOZz+8rpCGqTeeef567mq9sUu5gHpNVKPvODUUqTVxGtzMsN/M8HfiBI6NV50C5ChCq7Kqal1SsxfjstT85nlW2YAE9+JvENXxYe/uSKt9kfuiNrf5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKor5S8cgPE+sWtVvbW9H2WEwQ0Y7jNIm7W7C8e+Scg=;
 b=KciYRRZKBipP3ia4DMFanEQq5ON59Zvhivbvn8HbYJNWUomIF91L3yKXK1d41t3sdtU4210prj7+iX1CRYenSILX2tW38Pe45dfgUmplBKjhxvPAM3tOjGvXdUtq9MOWilptU41M2+xb/hO2OcKhVK6VmUn9WLrJS4KKzdwY3XCe+eh4VAsPvxU+/DbRhT72O0/BKQPIBERr+41iBdXn5itZgXw76geBcSVy5XKhgMuNVx+Xe0g9hw905v4ikLewXhjIgafatf3sZGj/QLDlJo4ASk2tqOvpzeotD0F8yautmwmgz0onmFnF62mGmZo19g7mq+x/3sWK3NcUONhHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKor5S8cgPE+sWtVvbW9H2WEwQ0Y7jNIm7W7C8e+Scg=;
 b=KQqAKlMd1uh7fumeYopEmsvLyvzd8u7jLYUyTC/1Pls7tyC2+QoUO1h8iM3U/CyGvzXlP72MVSBcGVkY+zuFMmGCBoIqYwoKp+extM7LMVaMtMQ2c8LSU4Jo1DhodyAXCiMJ/zy0AQ/3fd2E/i4YZ5eR28yww+60Ds8BUj0+qgk=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:42 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::58) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Mon, 8
 Dec 2025 17:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:42 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add interrupt handler for GFX 12.1.0
Date: Mon, 8 Dec 2025 12:17:02 -0500
Message-ID: <20251208171720.153355-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a2fd2a-2b03-49ed-ee98-08de367db276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hMOSr4hH0XvgLxWiFmn3h9/0z8XSbIOuxp/FKgZ1Q3P7wLAM9yMIXebbptLM?=
 =?us-ascii?Q?+EzYGWk7ZZEixg5R2QBJQDjq6gXK3EOmqEKQwT4+yfggHIZxfVQUaQ0ZyaMr?=
 =?us-ascii?Q?XNwOLbF4rQU3E+2cOxXFsvHdVQLk8ywB39X5TwnQbdWs8aE8EhfOCnyyMzyL?=
 =?us-ascii?Q?eqxePz1tu2Onr+zszvGKXx0dRUqyfj1l4N8QoNYmLigrCKTdlnbP+YlpMRVl?=
 =?us-ascii?Q?dC4/mgVFffiVYT+y6f2KKQc119a01ZiHZaU7vB4CYjbHCZJEmrr/197XfwZh?=
 =?us-ascii?Q?ro5f3tCEN9JNWmsS2NOCcyVR+FWhRJFKk1ZY5byY2GPjsZfkkeQWxRp1tFYN?=
 =?us-ascii?Q?CiTEwDwbAwKICOm9nHxWb/uC/mo+CKikOgpiGK9TY00Ttr3vtb/YPv3eKlon?=
 =?us-ascii?Q?OpWJONpn49KIlVcU5q0Zg0jMU0TTHEHjtedHAzUVn8cJm/dMRzlSGNwPvHn8?=
 =?us-ascii?Q?KV+AuUXHcNw8KxhSIXkZnDmyZBHixJgDJx6BeyATkNc9FpnYuTQqS1HKnOAI?=
 =?us-ascii?Q?Oeo60g6T1f05GDDwEeSV8mMN2JXr+jqu8ICn3SrqCHQQBvJ46okLHiOn1EsV?=
 =?us-ascii?Q?sffaw7QRtLEiSWaL78YQb98QCqXKdvUxDjwgZqA1Hc2oAb+thQFPF7LlUnrP?=
 =?us-ascii?Q?67VrWTqR/u6euptAWb9VSJl5t7GQykgyhl6nfWoVlCwzrLafbxKMxiNM51EP?=
 =?us-ascii?Q?RyNY1U0PxV7zwfr/6WvWtzqkmoGS2H0Mkw8l2y8gYDWDZOpGZrZXGbEm+VWy?=
 =?us-ascii?Q?m4wMAxX5A9hilS1YkUWGpnUBYJo0aj+89Nin2rePYMswYymtvy4bQN5EKaj2?=
 =?us-ascii?Q?iQpLZMW0G36me7vfoPpiBQptFbb/Sb4dzLTND88Kj1RmeEtuuKTjLCpIBdr8?=
 =?us-ascii?Q?sy0DAg6H7ZvsKqu4YlMV/SmJE0uJWwCu5OIles3/lwxiXZDgVGqKaIGnpJx0?=
 =?us-ascii?Q?pR7i6sEEJbKiBKetGnQhfh/esLkgyMCYC61kTK/Ewq521ix1EQEnnd1HZH5b?=
 =?us-ascii?Q?4HDfb3AR9epc8kijFvowwMrzjJz6XtDEfcLGsw6AA4c0SvKIZZqndgH4NASO?=
 =?us-ascii?Q?Sr/pHn2JvXWZEDrCThodoc7Kc6v78ExrzCCCvNQDWZiiwmbk/N6rblmbHWN6?=
 =?us-ascii?Q?Qel3N0M8QEzX0nGjEN9Pk7oYdOaF2+IavGWVmD980xjAZf96MZaOU1s/5yrq?=
 =?us-ascii?Q?+bEDvb+aIs4br7dM9mpTNqzWf9UA6X1/k4FlDROmZbUOpduBuanmXJ8EwnmT?=
 =?us-ascii?Q?Ork9RXFqFu0MPmuQ4fBTqZ1vgbkKaP/ytJczDI+aLY3qWp+Snz7pmUiQ/XLa?=
 =?us-ascii?Q?UFQHU3UPOTO6dLRmD88XcGYopfjJEu1k7EKTIxuJHJNbnGydDuU/cBrOgxxs?=
 =?us-ascii?Q?GGd9FP0+KIJ4Z9O6Wp/NIkbeWVR6O2xGkCMpIQ7i0P7BQBCSrI56BcC1FSCw?=
 =?us-ascii?Q?mO5L7n2WIBfV36u1/Csl6p4toZ6CO50RjRYMV2f5Abv/SVR3aFCRKW4TQWD+?=
 =?us-ascii?Q?eGQAKGnXd+AOlni8sX747/rlZBSU4DGEc7A+wQZAUpjemkI7Ez+P7qhzQ7et?=
 =?us-ascii?Q?/P84Nm+ml2tA+L0JgxM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:42.4800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a2fd2a-2b03-49ed-ee98-08de367db276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a separate interrupt handler for handling interrupts,
both retry and no-retry, for GFX 12.1.0.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 213 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h  |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |   7 +-
 4 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 1b1e2ddbc600a..dfa5181851161 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -639,15 +639,16 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
+		gmc_v12_1_set_irq_funcs(adev);
 		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		gmc_v12_0_set_gmc_funcs(adev);
+		gmc_v12_0_set_irq_funcs(adev);
 		break;
 	}
 	gmc_v12_0_set_gfxhub_funcs(adev);
 	gmc_v12_0_set_mmhub_funcs(adev);
-	gmc_v12_0_set_irq_funcs(adev);
 	gmc_v12_0_set_umc_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
@@ -848,7 +849,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(12, 1, 0)) &&
+	    !amdgpu_sriov_vf(adev)) {
 		/* interrupt sent to DF. */
 		r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_DF, 0,
 				      &adev->gmc.ecc_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index b9ae8469d5538..55f77520df2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -26,6 +26,208 @@
 #include "soc_v1_0_enum.h"
 #include "oss/osssys_7_1_0_offset.h"
 #include "oss/osssys_7_1_0_sh_mask.h"
+#include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
+
+static int gmc_v12_1_vm_fault_interrupt_state(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *src,
+					      unsigned int type,
+					      enum amdgpu_interrupt_state state)
+{
+	struct amdgpu_vmhub *hub;
+	u32 tmp, reg, i, j;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		for_each_set_bit(j, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+			hub = &adev->vmhub[j];
+			for (i = 0; i < 16; i++) {
+				reg = hub->vm_context0_cntl + i;
+
+				/* This works because this interrupt is only
+				 * enabled at init/resume and disabled in
+				 * fini/suspend, so the overall state doesn't
+				 * change over the course of suspend/resume.
+				 */
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB(0)))
+					continue;
+
+				if (j >= AMDGPU_MMHUB0(0))
+					tmp = RREG32_SOC15_IP(MMHUB, reg);
+				else
+					tmp = RREG32_XCC(reg, j);
+
+				tmp &= ~hub->vm_cntx_cntl_vm_fault;
+
+				if (j >= AMDGPU_MMHUB0(0))
+					WREG32_SOC15_IP(MMHUB, reg, tmp);
+				else
+					WREG32_XCC(reg, tmp, j);
+			}
+		}
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		for_each_set_bit(j, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+			hub = &adev->vmhub[j];
+			for (i = 0; i < 16; i++) {
+				reg = hub->vm_context0_cntl + i;
+
+				/* This works because this interrupt is only
+				 * enabled at init/resume and disabled in
+				 * fini/suspend, so the overall state doesn't
+				 * change over the course of suspend/resume.
+				 */
+				if (adev->in_s0ix && (j == AMDGPU_GFXHUB(0)))
+					continue;
+
+				if (j >= AMDGPU_MMHUB0(0))
+					tmp = RREG32_SOC15_IP(MMHUB, reg);
+				else
+					tmp = RREG32_XCC(reg, j);
+
+				tmp |= hub->vm_cntx_cntl_vm_fault;
+
+				if (j >= AMDGPU_MMHUB0(0))
+					WREG32_SOC15_IP(MMHUB, reg, tmp);
+				else
+					WREG32_XCC(reg, tmp, j);
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
+				       struct amdgpu_irq_src *source,
+				       struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_task_info *task_info;
+	bool retry_fault = false, write_fault = false;
+	unsigned int vmhub, node_id;
+	struct amdgpu_vmhub *hub;
+	uint32_t cam_index = 0;
+	const char *hub_name;
+	int ret, xcc_id = 0;
+	uint32_t status = 0;
+	u64 addr;
+
+	node_id = entry->node_id;
+
+	addr = (u64)entry->src_data[0] << 12;
+	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
+
+	if (entry->src_id == UTCL2_1_0__SRCID__RETRY) {
+		retry_fault = true;
+		write_fault = !!(entry->src_data[1] & 0x200000);
+	}
+
+	if (entry->client_id == SOC21_IH_CLIENTID_VMC) {
+		hub_name = "mmhub0";
+		vmhub = AMDGPU_MMHUB0(node_id / 4);
+	} else {
+		hub_name = "gfxhub0";
+		if (adev->gfx.funcs->ih_node_to_logical_xcc) {
+			xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev,
+								node_id);
+			if (xcc_id < 0)
+				xcc_id = 0;
+		}
+		vmhub = xcc_id;
+	}
+
+	hub = &adev->vmhub[vmhub];
+
+	if (retry_fault) {
+		if (adev->irq.retry_cam_enabled) {
+			/* Delegate it to a different ring if the hardware hasn't
+			 * already done it.
+			 */
+			if (entry->ih == &adev->irq.ih) {
+				amdgpu_irq_delegate(adev, entry, 8);
+				return 1;
+			}
+
+			cam_index = entry->src_data[3] & 0x3ff;
+
+			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
+							addr, entry->timestamp, write_fault);
+			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
+			if (ret)
+				return 1;
+		} else {
+			/* Process it onyl if it's the first fault for this address */
+			if (entry->ih != &adev->irq.ih_soft &&
+				amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
+							 entry->timestamp))
+				return 1;
+
+			/* Delegate it to a different ring if the hardware hasn't
+			 * already done it.
+			 */
+			if (entry->ih == &adev->irq.ih) {
+				amdgpu_irq_delegate(adev, entry, 8);
+				return 1;
+			}
+
+			/* Try to handle the recoverable page faults by filling page
+			 * tables
+			 */
+			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
+						   addr, entry->timestamp, write_fault))
+				return 1;
+		}
+	}
+
+	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))
+		return 1;
+
+	if (!printk_ratelimit())
+		return 0;
+
+	dev_err(adev->dev,
+		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n", hub_name,
+		retry_fault ? "retry" : "no-retry",
+		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		amdgpu_vm_print_task_info(adev, task_info);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
+	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client %d\n",
+		addr, entry->client_id);
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	/*
+	 * Issue a dummy read to wait for the status register to
+	 * be updated to avoid reading an incorrect value due to
+	 * the new fast GRBM interface.
+	 */
+	if (entry->vmid_src == AMDGPU_GFXHUB(0))
+		RREG32(hub->vm_l2_pro_fault_status);
+
+	status = RREG32(hub->vm_l2_pro_fault_status);
+
+	/* Only print L2 fault status if the status register could be read and
+	 * contains useful information
+	 */
+	if (!status)
+		return 0;
+
+	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+
+	hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
+
+	return 0;
+}
 
 static bool gmc_v12_1_get_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 						  uint8_t vmid, uint16_t *p_pasid)
@@ -382,3 +584,14 @@ void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev)
 {
 	adev->gmc.gmc_funcs = &gmc_v12_1_gmc_funcs;
 }
+
+static const struct amdgpu_irq_src_funcs gmc_v12_1_irq_funcs = {
+	.set = gmc_v12_1_vm_fault_interrupt_state,
+	.process = gmc_v12_1_process_interrupt,
+};
+
+void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->gmc.vm_fault.num_types = 1;
+	adev->gmc.vm_fault.funcs = &gmc_v12_1_irq_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
index cc52db3a9908d..67ee5f7fd9b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h
@@ -25,5 +25,6 @@
 #define __GMC_V12_1_H__
 
 void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev);
+void gmc_v12_1_set_irq_funcs(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index cf640c9d19bf6..b91843b2af6a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1685,6 +1685,10 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 {
 	struct kfd_process *p;
 	u32 cam_index;
+	u32 src_data_idx;
+
+	src_data_idx = (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) ?
+			3 : 2;
 
 	if (entry->ih == &adev->irq.ih_soft || entry->ih == &adev->irq.ih1) {
 		p = kfd_lookup_process_by_pasid(entry->pasid, NULL);
@@ -1693,7 +1697,8 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 
 		if (p->gpu_page_fault && !p->debug_trap_enabled) {
 			if (retry_fault && adev->irq.retry_cam_enabled) {
-				cam_index = entry->src_data[2] & 0x3ff;
+				cam_index = entry->src_data[src_data_idx] & 0x3ff;
+
 				WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
 			}
 
-- 
2.51.1

