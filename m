Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D004DC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0D510ECD9;
	Tue, 22 Sep 2026 13:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zndBrKkU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299A410ECD9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGN4ZADVLWDY4hUd6jX6WG8whri0/0aXCPxLrO42sOoRrK4FbOOJ9k7OC1MARGJ87YldOp8ZkwZso6NhjjZGVoZM0HPYrbCavoOW2IT7qU6Sia58kOLK1LiRxxsPi7llkr3/GJR+5qwWK50tRKLl74qIN5RZ8g+3z8KrFAmdmcVKzfyOQ/rKmdKY3obyp5WAOw9uHFFzyhUjgYIN3vaD4wLaRH5H+Y8OlkJ54vtmLQg8M+fJ56MwQP58khqXIqC5zZl04+DFNR6TZlG0HM5vMXh/vwoI/vrXKRMAABcwfyoSfzWJrW+Q7GUT0vklhZGDY9YhxDHwzrJY9K6vpyqF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAH6vbSKPBV7fbzEkI+vdElO8v+yd9DN3W7cox7iEnw=;
 b=cpUaUI2VsrlaTWy18Be3hXE4e1vVnlZ6kvdffcyx4BwLXGBC918+bB5zPJZpqvNFHTB9l6cn5qKoeSqO99iX8suinAgJvfs/9JIvU98S/KTVY2XCeI2D7xI8nGnMh+ZsEMp3xQsakX/MPIekbrrIgxReqvFdmiIC/AD+VEJhgyYLQ7msQWnE2NQkZvhjBYkobhOyK0ERV+xDYOf1ay5lwxFulVKG0ZlyIkkMOoDHVNskJmf2xhb9909DctPeoSJdsnik1c4KBuLHIMRTtVfUL+L9SlF0Ostefb0bfeg1x9YtJXbwGaNFoju56BPL27IJG+zkS3skEUMFVdUg8XxY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAH6vbSKPBV7fbzEkI+vdElO8v+yd9DN3W7cox7iEnw=;
 b=zndBrKkUZ10jT8DDRWHxg4kFCyTRHgECxqWVHZA3AstWCs7GI2bl/tKxojNHhcu3d8gJnDoR+3LzogGgGgKo2alLb0kWuXZ9kjJNcIiHeSitSJUanoUNndcm2+Fi7zcUOA8p9CUJtjMz7woI8ntEHFqjk5O4/agLq2sQHj/bEKc=
Received: from BN0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:141::30)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 13:44:22 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::70) by BN0PR07CA0015.outlook.office365.com
 (2603:10b6:408:141::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 13:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:44:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:44:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:44:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add smuio v15_0_3 ip headers v4
Date: Tue, 22 Sep 2026 09:43:59 -0400
Message-ID: <20260922134400.2145341-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922134400.2145341-1-alexander.deucher@amd.com>
References: <20260922134400.2145341-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f763ef-a3b6-4cbf-f176-08df18af9a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3jpjnqSM6E5KyM99pxJBikZm8b76Q+9qKTjKyN5INqJ+PXYTMNYNpINKMc96fMj/9fBqjICwQe5KchsfW6kcq9iyexeG0mfPPWeZ/0KY6Wbj9qGKqkiwRNJeKs5KoBRCZq3yPCvHigq4FSLg/ywgJfiQeVmL04SMljT0EL2VHYPFdguS9KpWyfT+jCZoJRWWpKUCHd0X72HAUeLLv6trgzqipNHGf9Za8T6wbaZzHjxdOGXsKZ8Q0iq0OUOPXy91vDLEB46p9lPVJRmX99jygwqi9LOPnxHtjykPNSod4M/mMc0xXYzECoVlJMOq7VTZ8G8ZBiC2Cm7z4/VXv+kRrAHbkdr6Yi9uIcezwsJZcseUH9hMXgswqWe4ouiQm58hmyfTPZkwD4t+l1HmABkFmOwqJXnXUiBVJy5uk6uXBSzBB1uxuW3ylIY+29dxGE/bXMsjFHFnBfIJuZOhp3X5LqRth9dqO1masRo3pODxsoZWMWV+SOn9x6DpJtZj+Njz5hByDxQOOZ6KgFxsRQRKzuWGfAMUjJAvKrCBZa/UBCGfMT8vbabfV+6LP4l7y+U6HYBB+ZbpwyvUTis/3/n40zZbMeK3YATD8PpQeZJbQvxb21HuyZFMyqKoIbJ+A/ZUXWZQfB38QFZDMmDfwN4TpJtGj5jDh8SDY35PKWtlz9mSZ2o8GRGxQY5MgA8qPwFYscEeFqvmXMIdo66aD8SHLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7kP/+0u/KI3tsBtWNrSmhVI60Dvg8R6GaDK2tK++d0i8TQOi00yqRP/ln00KLL+kyUbaBxHzpaVmy4aYLeyxKpKaCIagMsG6uBnLtaZDiQafaaG1BWHz/Xa/kgHkhGnDWqXLfTJbtb0f8ZUHvZ11QXjHm7BDKOwwKKLuHnJxc16cVrtg8IWHa5pmeJSefkWhtmJqblApFRyFPXShxeUN0JdyMSdwmLWf/Av+5oWiO3Df3ELd3kQTE0l0O/c5ljRjQ42AXm0WqUDR1RN9esEVrRRhAAQGAV9860iE4pE+J80i2jMvYTUvgtTAfB0fEqaCdvG5IJv3NPu5LkTnpokh0uQODY42zgjHIOWAvyPgyvSsbVV3EIRFfO/CD9E2S1bBJQ5z7xctf5PUMhQ1I/v+RTm4TZbiVuVoUN5ktlED63zYDKErgBH99V5l5ALdufFr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:44:19.6422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f763ef-a3b6-4cbf-f176-08df18af9a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add header files for smuio v15_0_3 register offsets
and shift masks

v2: Update smuio ip headers to LSC version
v3: Update smuio ip headers to BTO version
v4: Update registers (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../asic_reg/smuio/smuio_15_0_3_offset.h      |  79 +++++++++
 .../asic_reg/smuio/smuio_15_0_3_sh_mask.h     | 164 ++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h
new file mode 100644
index 0000000000000..e4fcfc05ddbe0
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef _smuio_15_0_3_OFFSET_HEADER
+#define _smuio_15_0_3_OFFSET_HEADER
+
+
+// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
+// base address: 0x5aca8
+#define regPWR_VIRT_RESET_REQ                                                                           0x012a
+#define regPWR_VIRT_RESET_REQ_BASE_IDX                                                                  1
+#define regPWR_DISP_TIMER_CONTROL                                                                       0x012b
+#define regPWR_DISP_TIMER_CONTROL_BASE_IDX                                                              1
+#define regPWR_DISP_TIMER_DEBUG                                                                         0x012c
+#define regPWR_DISP_TIMER_DEBUG_BASE_IDX                                                                1
+#define regPWR_DISP_TIMER2_CONTROL                                                                      0x012d
+#define regPWR_DISP_TIMER2_CONTROL_BASE_IDX                                                             1
+#define regPWR_DISP_TIMER2_DEBUG                                                                        0x012e
+#define regPWR_DISP_TIMER2_DEBUG_BASE_IDX                                                               1
+#define regPWR_DISP_TIMER_GLOBAL_CONTROL                                                                0x012f
+#define regPWR_DISP_TIMER_GLOBAL_CONTROL_BASE_IDX                                                       1
+#define regPWR_IH_CONTROL                                                                               0x0130
+#define regPWR_IH_CONTROL_BASE_IDX                                                                      1
+
+
+// addressBlock: smuio_smuio_misc_SmuSmuioDec
+// base address: 0x5a000
+#define regSMUIO_MCM_CONFIG                                                                             0x0023
+#define regSMUIO_MCM_CONFIG_BASE_IDX                                                                    0
+#define regIP_DISCOVERY_VERSION                                                                         0x0000
+#define regIP_DISCOVERY_VERSION_BASE_IDX                                                                1
+#define regSMUIO_PCC_CONTROL                                                                            0x01bd
+#define regSMUIO_PCC_CONTROL_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER0                                                                            0x01c3
+#define regSCRATCH_REGISTER0_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER1                                                                            0x01c4
+#define regSCRATCH_REGISTER1_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER2                                                                            0x01c5
+#define regSCRATCH_REGISTER2_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER3                                                                            0x01c6
+#define regSCRATCH_REGISTER3_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER4                                                                            0x01c7
+#define regSCRATCH_REGISTER4_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER5                                                                            0x01c8
+#define regSCRATCH_REGISTER5_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER6                                                                            0x01c9
+#define regSCRATCH_REGISTER6_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER7                                                                            0x01ca
+#define regSCRATCH_REGISTER7_BASE_IDX                                                                   1
+#define regIO_SMUIO_PINSTRAP                                                                            0x01cb
+#define regIO_SMUIO_PINSTRAP_BASE_IDX                                                                   1
+
+
+#define regCCD_GOLDEN_TSC_COUNT_UPPER                                                                   0x9C1F411
+#define regCCD_GOLDEN_TSC_COUNT_UPPER_BASE_IDX                                                          2
+#define regCCD_GOLDEN_TSC_COUNT_LOWER                                                                   0x9C1F412
+#define regCCD_GOLDEN_TSC_COUNT_LOWER_BASE_IDX                                                          2
+
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h
new file mode 100644
index 0000000000000..39a46750aaeb9
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h
@@ -0,0 +1,164 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef _smuio_15_0_3_SH_MASK_HEADER
+#define _smuio_15_0_3_SH_MASK_HEADER
+
+
+// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
+//PWR_VIRT_RESET_REQ
+#define PWR_VIRT_RESET_REQ__VF_FLR__SHIFT                                                                     0x0
+#define PWR_VIRT_RESET_REQ__PF_FLR__SHIFT                                                                     0x1f
+#define PWR_VIRT_RESET_REQ__VF_FLR_MASK                                                                       0x7FFFFFFFL
+#define PWR_VIRT_RESET_REQ__PF_FLR_MASK                                                                       0x80000000L
+//PWR_DISP_TIMER_CONTROL
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_COUNT__SHIFT                                                   0x0
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_ENABLE__SHIFT                                                  0x19
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_DISABLE__SHIFT                                                 0x1a
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MASK__SHIFT                                                    0x1b
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_STAT_AK__SHIFT                                                 0x1c
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_TYPE__SHIFT                                                    0x1d
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MODE__SHIFT                                                    0x1e
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_COUNT_MASK                                                     0x01FFFFFFL
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_ENABLE_MASK                                                    0x02000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_DISABLE_MASK                                                   0x04000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MASK_MASK                                                      0x08000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_STAT_AK_MASK                                                   0x10000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_TYPE_MASK                                                      0x20000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MODE_MASK                                                      0x40000000L
+//PWR_DISP_TIMER_DEBUG
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_RUNNING__SHIFT                                                   0x0
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_STAT__SHIFT                                                      0x1
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT__SHIFT                                                           0x2
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_RUN_VAL__SHIFT                                                       0x7
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_RUNNING_MASK                                                     0x00000001L
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_STAT_MASK                                                        0x00000002L
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_MASK                                                             0x00000004L
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_RUN_VAL_MASK                                                         0xFFFFFF80L
+//PWR_DISP_TIMER2_CONTROL
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_COUNT__SHIFT                                                  0x0
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_ENABLE__SHIFT                                                 0x19
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_DISABLE__SHIFT                                                0x1a
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MASK__SHIFT                                                   0x1b
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_STAT_AK__SHIFT                                                0x1c
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_TYPE__SHIFT                                                   0x1d
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MODE__SHIFT                                                   0x1e
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_COUNT_MASK                                                    0x01FFFFFFL
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_ENABLE_MASK                                                   0x02000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_DISABLE_MASK                                                  0x04000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MASK_MASK                                                     0x08000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_STAT_AK_MASK                                                  0x10000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_TYPE_MASK                                                     0x20000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MODE_MASK                                                     0x40000000L
+//PWR_DISP_TIMER2_DEBUG
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_RUNNING__SHIFT                                                  0x0
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_STAT__SHIFT                                                     0x1
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT__SHIFT                                                          0x2
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_RUN_VAL__SHIFT                                                      0x7
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_RUNNING_MASK                                                    0x00000001L
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_STAT_MASK                                                       0x00000002L
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_MASK                                                            0x00000004L
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_RUN_VAL_MASK                                                        0xFFFFFF80L
+//PWR_DISP_TIMER_GLOBAL_CONTROL
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_WIDTH__SHIFT                                          0x0
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_EN__SHIFT                                             0xa
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_WIDTH_MASK                                            0x000003FFL
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_EN_MASK                                               0x00000400L
+//PWR_IH_CONTROL
+#define PWR_IH_CONTROL__MAX_CREDIT__SHIFT                                                                     0x0
+#define PWR_IH_CONTROL__DISP_TIMER_TRIGGER_MASK__SHIFT                                                        0x5
+#define PWR_IH_CONTROL__DISP_TIMER2_TRIGGER_MASK__SHIFT                                                       0x6
+#define PWR_IH_CONTROL__PWR_IH_CLK_GATE_EN__SHIFT                                                             0x1f
+#define PWR_IH_CONTROL__MAX_CREDIT_MASK                                                                       0x0000001FL
+#define PWR_IH_CONTROL__DISP_TIMER_TRIGGER_MASK_MASK                                                          0x00000020L
+#define PWR_IH_CONTROL__DISP_TIMER2_TRIGGER_MASK_MASK                                                         0x00000040L
+#define PWR_IH_CONTROL__PWR_IH_CLK_GATE_EN_MASK                                                               0x80000000L
+
+
+// addressBlock: smuio_smuio_misc_SmuSmuioDec
+//SMUIO_MCM_CONFIG
+#define SMUIO_MCM_CONFIG__DIE_ID__SHIFT                                                                       0x0
+#define SMUIO_MCM_CONFIG__PKG_TYPE__SHIFT                                                                     0x2
+#define SMUIO_MCM_CONFIG__SOCKET_ID__SHIFT                                                                    0x8
+#define SMUIO_MCM_CONFIG__DIE_CONFIG__SHIFT                                                                   0xd
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE__SHIFT                                                                  0x12
+#define SMUIO_MCM_CONFIG__DIE_ID_MASK                                                                         0x00000003L
+#define SMUIO_MCM_CONFIG__PKG_TYPE_MASK                                                                       0x0000003CL
+#define SMUIO_MCM_CONFIG__SOCKET_ID_MASK                                                                      0x00000100L
+#define SMUIO_MCM_CONFIG__DIE_CONFIG_MASK                                                                     0x0000E000L
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE_MASK                                                                    0x00040000L
+//IP_DISCOVERY_VERSION
+#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION__SHIFT                                                     0x0
+#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION_MASK                                                       0xFFFFFFFFL
+//SMUIO_PCC_CONTROL
+#define SMUIO_PCC_CONTROL__PCC_ENABLE__SHIFT                                                                  0x0
+#define SMUIO_PCC_CONTROL__PCC_POLARITY__SHIFT                                                                0x1
+#define SMUIO_PCC_CONTROL__PCC_A__SHIFT                                                                       0x2
+#define SMUIO_PCC_CONTROL__PCC_OE__SHIFT                                                                      0x3
+#define SMUIO_PCC_CONTROL__PCC_PU__SHIFT                                                                      0x4
+#define SMUIO_PCC_CONTROL__PCC_PD__SHIFT                                                                      0x5
+#define SMUIO_PCC_CONTROL__PCC_S0__SHIFT                                                                      0x6
+#define SMUIO_PCC_CONTROL__PCC_S1__SHIFT                                                                      0x7
+#define SMUIO_PCC_CONTROL__PCC_SCHMEN__SHIFT                                                                  0x8
+#define SMUIO_PCC_CONTROL__PCC_DFTRXEN__SHIFT                                                                 0x9
+#define SMUIO_PCC_CONTROL__PCC_ENABLE_MASK                                                                    0x00000001L
+#define SMUIO_PCC_CONTROL__PCC_POLARITY_MASK                                                                  0x00000002L
+#define SMUIO_PCC_CONTROL__PCC_A_MASK                                                                         0x00000004L
+#define SMUIO_PCC_CONTROL__PCC_OE_MASK                                                                        0x00000008L
+#define SMUIO_PCC_CONTROL__PCC_PU_MASK                                                                        0x00000010L
+#define SMUIO_PCC_CONTROL__PCC_PD_MASK                                                                        0x00000020L
+#define SMUIO_PCC_CONTROL__PCC_S0_MASK                                                                        0x00000040L
+#define SMUIO_PCC_CONTROL__PCC_S1_MASK                                                                        0x00000080L
+#define SMUIO_PCC_CONTROL__PCC_SCHMEN_MASK                                                                    0x00000100L
+#define SMUIO_PCC_CONTROL__PCC_DFTRXEN_MASK                                                                   0x00000200L
+//SCRATCH_REGISTER0
+#define SCRATCH_REGISTER0__ScratchPad0__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER0__ScratchPad0_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER1
+#define SCRATCH_REGISTER1__ScratchPad1__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER1__ScratchPad1_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER2
+#define SCRATCH_REGISTER2__ScratchPad2__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER2__ScratchPad2_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER3
+#define SCRATCH_REGISTER3__ScratchPad3__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER3__ScratchPad3_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER4
+#define SCRATCH_REGISTER4__ScratchPad4__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER4__ScratchPad4_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER5
+#define SCRATCH_REGISTER5__ScratchPad5__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER5__ScratchPad5_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER6
+#define SCRATCH_REGISTER6__ScratchPad6__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER6__ScratchPad6_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER7
+#define SCRATCH_REGISTER7__ScratchPad7__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER7__ScratchPad7_MASK                                                                   0xFFFFFFFFL
+//IO_SMUIO_PINSTRAP
+#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN__SHIFT                                                               0x0
+#define IO_SMUIO_PINSTRAP__AUD__SHIFT                                                                         0x3
+#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN_MASK                                                                 0x00000007L
+#define IO_SMUIO_PINSTRAP__AUD_MASK                                                                           0x00000018L
+
+
+#endif
-- 
2.55.0

