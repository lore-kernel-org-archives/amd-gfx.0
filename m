Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB68EC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B90C10E432;
	Wed, 17 Jul 2024 20:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y79KN9SV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5461810E432
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9E4mplmXsZKCWD15ebe1KgnkcsXfEBU79UfFYvHYkyUzQ9NreJ0WT2gVQzBxSMRZu8ZmKuPv8L3itlZPeGrzrCgJrivl2+rTii8vTo6vPaCWBbvkL7KRCbDif1o52ykdD8KKUg96QRA+9VteR100zk5aPqCyVGmhD9iX67elzynSBoN18surL6VZ49HzemrZus8EiwE87zv6tpDmF+UzFSxkoas6tMZIUJOzC5mG0dhnrUbLTofoJDvJIWbXLYbTubZgr47jfga0LnsU5BcD2Z3vBbtp2omAk+GEXKWzWQCX7/bGq7KaI9yiAsWPRd+bF2r+QWlCsPRR+cx/w+upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwFl6gUuqlY5dut0KRDqOK+UU4pwvuDrNS4N1zrOmXs=;
 b=aydri91YDXpaZUl4lTvG/sa881AtGug1Wk1EYMpeXl+Vm0tkfiA79PMztHipIiINEwEJuGrmlULIEvyfMF7wb8r0BzNBD2m39FK7iYiGCuCCIh4VO7hD77e9lMMIMBju34y15Yap2wldDEOD+g83TMfJ5gVZkMC2aVOK3rc2dupRQrPgmFPQBbY1wuyOXM6XhHAVfe1gfnMVfbFngd5N5NyuZhxL53BQ2lYpVX7RFVjC2rjhVEkFpoKnKmig0syimJUbVcOeIKW7YkMuFpvXqrCsDjS+kWsMK1+zNcwPQMh1CkDzaFjWwLCH8P6b9rSzslrW3L0KTFdus19XTCMU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwFl6gUuqlY5dut0KRDqOK+UU4pwvuDrNS4N1zrOmXs=;
 b=y79KN9SVqAqhQq4YcsQviCQ9tfQIDZAsugxU27XFHyQPiaATXbMxCDsJZ/JuMNmNLTyGRr/fYvZDufIElUdbmlwinDec2s5WAghtQJGwtoE+5Gom17juPnMO5HCaS+L6NW+Ay3oM5BsREoee9eBYj87XaOV5Pi6QQkGV30y4GLo=
Received: from BL0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:2d::36)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:40:35 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::90) by BL0PR03CA0023.outlook.office365.com
 (2603:10b6:208:2d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25 via Frontend
 Transport; Wed, 17 Jul 2024 20:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:40:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx9.4.3: Enable bad opcode interrupt
Date: Wed, 17 Jul 2024 16:40:11 -0400
Message-ID: <20240717204011.15342-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717204011.15342-1-alexander.deucher@amd.com>
References: <20240717204011.15342-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b975c1-14ec-43cd-897c-08dca6a0b5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/crUBk7w+IG+FO15j/YEzTQquNUii7rC3Ufc95oPOtQBk962Ze9Jlkv5tXT?=
 =?us-ascii?Q?pV0j+h2CT8V5T+wMDzyFAu3OkJI15k3t79grqPWTJvpByAnY+pDouvF/yFZ9?=
 =?us-ascii?Q?T+RXCCV3VkecEeGmx+d6z+2E3LWrWfHBd3rI57iAizREo6My2bdOoYgdhmwh?=
 =?us-ascii?Q?K3IJbXPtIZlwcV7OLeYIwr+dgBm6bUxJyaSvr8xJpxIf3Q+BBIoq6CpcRu3U?=
 =?us-ascii?Q?v4KeUOG2KgfRszw+tBSPOtJuLXwz0QhBb6jIYcM0BjVOzxow3NOH7Oqgvbul?=
 =?us-ascii?Q?GGR/fPTZPbRJackbWm4T+3FLMXKswY/PnyJgaN2w2Cr78WEGUTpfJ7Kwn+9H?=
 =?us-ascii?Q?IpjvGEWZU7mpNH7O95ZpULYjJXZDAqhfTPenI0aCO6hN5u7C9XoBqYHRlwkq?=
 =?us-ascii?Q?zQXYE67vkh2rp8wPUpsCmtwGE2wccZATHjtBio4k+Ma8ZI2TqSDmrqQ2Kj/M?=
 =?us-ascii?Q?J5fjymRW8CnA5xEHbvAMqkeHAKiknNW/GViMIuag2B1rsZ8LmTMY4pYo8B7I?=
 =?us-ascii?Q?VzfVa4XUfS8zfTfhcDkAKXfiK7qwcpAFGzb5SeT1MIpO2qxGq4srvxdmJgey?=
 =?us-ascii?Q?RMt/JUOYFUloKBaXR817F++pt35QMaSrVgmRL3pykbWor1FCUJ3jcUtztbJv?=
 =?us-ascii?Q?EmaOt4oHirqc6OfW6e0cmL4pjKUBUR8hvShJvjJqJ6aiymHBMA3qqIxaa2Zr?=
 =?us-ascii?Q?FQLeYN3V1nMwFfKJB7sHHri9OHNrcHAK4vk56G87gBzD+Zeo4CTy2wTUgx46?=
 =?us-ascii?Q?98kLmUP6+IV5g7kIzYMfjlWer4scqtkmoKkuyvhZuQc0uJFVwViLE8k49d36?=
 =?us-ascii?Q?mA6jatMpMIeuW8wXK9hSK9iJW6xjMaN26u0Z3QYFTpm8PaY9sdClM29//p8W?=
 =?us-ascii?Q?cRnzdczR0/KEdn23LZ26QJhZOz7dMWeRLBR5Cy3XNj/7tijrN73r0or/tjdJ?=
 =?us-ascii?Q?npcJa+l3YNaTdWuSdO5y80WlNIj2FLFuU9GW6AtvuGwTT26RAH4CQ3cCoG87?=
 =?us-ascii?Q?8YAs5D3XHOsqHYpZf08/cLsK+Z6dd9Q+BpiuxOugFUhzm2lvwtcglFV9DSA2?=
 =?us-ascii?Q?ptSdoLn7+MHnnANdWLwsAZFK9rqEJ/QMFYmeaO7G9px9E23JWzhESiX24rTp?=
 =?us-ascii?Q?25cD5TaVy9pg9qW0Xzz4bdChxlTZNuVnKH7yZGA4OiWnOY2FUjcZVMH0bZ4w?=
 =?us-ascii?Q?CkXgAlxvtHhgrMMuWoz6P1/eUf0Aawc4sQkc4mLB99eifyq2Ffu7mtoPlf7t?=
 =?us-ascii?Q?4OaMR0vc2IS02GXmK+EyNNiQpMfgKVUUm8h6fjKVv1lI32t9iRYY/582AVAz?=
 =?us-ascii?Q?MwW5IwzhyC3u8+MTupNsPvisXkRo37Iy99B0lRLqQ1+IBjdyDGA52/mDCxSf?=
 =?us-ascii?Q?Ww8LzbJYXKMCMAY4F9ZMkaDgz9J+t/+fzGMUQZW9AFrDA5qnJebcEsly3usc?=
 =?us-ascii?Q?+3ANOzZbVc6ucrbE1CIcajFukeKYoKeJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:40:35.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b975c1-14ec-43cd-897c-08dca6a0b5a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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

For the bad opcode case, it will cause CP/ME hang.
The firmware will prevent the ME side from hanging by raising a bad opcode interrupt.
And the driver needs to perform a vmid reset when receiving the interrupt.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 43a3ef276b5f..98fe6c40da64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -901,6 +901,13 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Bad opcode Event */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
+			      GFX_9_0__SRCID__CP_BAD_OPCODE_ERROR,
+			      &adev->gfx.bad_op_irq);
+	if (r)
+		return r;
+
 	/* Privileged reg */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_PRIV_REG_FAULT,
 			      &adev->gfx.priv_reg_irq);
@@ -2162,6 +2169,7 @@ static int gfx_v9_4_3_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
@@ -2327,6 +2335,10 @@ static int gfx_v9_4_3_late_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		return r;
+
 	if (adev->gfx.ras &&
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
@@ -2964,6 +2976,46 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v9_4_3_set_bad_op_fault_state(struct amdgpu_device *adev,
+					     struct amdgpu_irq_src *source,
+					     unsigned type,
+					     enum amdgpu_interrupt_state state)
+{
+	u32 mec_int_cntl_reg, mec_int_cntl;
+	int i, j, k, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+	case AMDGPU_IRQ_STATE_ENABLE:
+		for (i = 0; i < num_xcc; i++) {
+			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
+					      OPCODE_ERROR_INT_ENABLE,
+					      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+			for (j = 0; j < adev->gfx.mec.num_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					/* MECs start at 1 */
+					mec_int_cntl_reg = gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
+
+					if (mec_int_cntl_reg) {
+						mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, i);
+						mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+									     OPCODE_ERROR_INT_ENABLE,
+									     state == AMDGPU_IRQ_STATE_ENABLE ?
+									     1 : 0);
+						WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, i);
+					}
+				}
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
 static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      unsigned type,
@@ -3116,6 +3168,15 @@ static int gfx_v9_4_3_priv_reg_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v9_4_3_bad_op_irq(struct amdgpu_device *adev,
+				 struct amdgpu_irq_src *source,
+				 struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal opcode in command stream\n");
+	gfx_v9_4_3_fault(adev, entry);
+	return 0;
+}
+
 static int gfx_v9_4_3_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
@@ -4228,6 +4289,11 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_reg_irq_funcs = {
 	.process = gfx_v9_4_3_priv_reg_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_bad_op_irq_funcs = {
+	.set = gfx_v9_4_3_set_bad_op_fault_state,
+	.process = gfx_v9_4_3_bad_op_irq,
+};
+
 static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs = {
 	.set = gfx_v9_4_3_set_priv_inst_fault_state,
 	.process = gfx_v9_4_3_priv_inst_irq,
@@ -4241,6 +4307,9 @@ static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.priv_reg_irq.num_types = 1;
 	adev->gfx.priv_reg_irq.funcs = &gfx_v9_4_3_priv_reg_irq_funcs;
 
+	adev->gfx.bad_op_irq.num_types = 1;
+	adev->gfx.bad_op_irq.funcs = &gfx_v9_4_3_bad_op_irq_funcs;
+
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v9_4_3_priv_inst_irq_funcs;
 }
-- 
2.45.2

