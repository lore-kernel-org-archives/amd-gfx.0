Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B9CC25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C00110F23B;
	Mon,  6 May 2024 18:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sVGPCipP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9028810F255
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKv37HWrgE28fDETy+ECU6jD/23qja7OvSqsaT8OlKI1odRWs+81jPhouEIyRjcsZhDIdtAcAAsZUV98vvGUVNAqHpP1EecQCeDrQOhIo3emzCuYq+2RYqHqP3AO93qUb59IRVlaoeKRMrEmyUNCTEC6tEkmoj5Q3E5aXFljf3VbHjiWg2S46mh3VVWlc3CuH+8AD+MbbsDhEsInIybcLz3HRY0ufxCvG8petthwIhMkV9opxI24MhMmEtkv7OjXy3rkkezslufTq3D5ikTBDqMXLQgLjn2KPF7Uik1a80quTkwkCLk/MeuVwNcS/WT0r8o/hxzBOIjDLXH29YeDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG593F40LuW2n0Z+VtvqPdBaSNRBtQuqT2Mx89nttd8=;
 b=DaiG0+4+SC4kCvqmr5VJy5oZe74YjRKECZiu7E3AV9tKpopw5kVKC5nRj5XQ5PJsli6z23dyrn9XVQShcFzt9n/MQmHGWy2K5RBHK0EGxyG8vNSyIZirxMaDUE1+snnsT/w0EBx26RHCtRftiTpDxxOg49glpM4B6HiItVpv2rqCK3VAmt0CfJSikG/96cMOM5OY/0uoQ5Fopz6JIiEkzRii6eiHssc3fN6gtJYKP2m//ZZ8JxaS/FYxbhj0IVh4bXlxDLl+Aj+XqUFRqJo2+3cmK/Gx2QUIuozSP+BDaA08D2FznuykkM4ScOxhNmygkare3LMlVYk5EKLPdIHhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG593F40LuW2n0Z+VtvqPdBaSNRBtQuqT2Mx89nttd8=;
 b=sVGPCipP3SbeoOJLTCKfElz4kP193En8fvF6fNS1aYclcMCjr3BIm3Tvn1ib+WP1fW7yzZy5pO8wVy3vWPq0doZOxDyoPdzWZ2Ix8qp0dpFVHkTaVCZCe1ckDOmncpfoOPeolCFbSsPDn10q0PAEydy/1yRIpjhOENBXmtRGu+A=
Received: from PH0PR07CA0088.namprd07.prod.outlook.com (2603:10b6:510:f::33)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:45:56 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::58) by PH0PR07CA0088.outlook.office365.com
 (2603:10b6:510:f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:45:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 02/14] drm/amdgpu: add set_reg_remap callback for NBIO 6.1
Date: Mon, 6 May 2024 14:45:27 -0400
Message-ID: <20240506184539.1669157-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8b61f4-e93b-4d67-5553-08dc6dfcc366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJd5Y1Td5j3ydSP6R47Ez3lmrbyNu+VGraOstSUuBrAooHTf7C78LOh16QYZ?=
 =?us-ascii?Q?vEJTeEhUVoOXiPsMZI4N6BtcfhooG+cE1c/BZJgRmrztNqGUyYioWQ/VoEPM?=
 =?us-ascii?Q?4JXIZELePQm8tN1R4XS4xGa5AKqm3IAENQVJ2onRc/4Y40lqBgcRMxyy3PLI?=
 =?us-ascii?Q?TSM2d2Kc5fe2bnDSrrPPWGTHCe5V/ULKSQ4LIYT/w7DOj8fqc4sqBgeQuNbl?=
 =?us-ascii?Q?+sv3EMcO42dibWsT7FDHpch4CPjryYOP8H5E3Vr65tSLPyZLY0Qgd9DjN305?=
 =?us-ascii?Q?9T1Ykn5XoyGox7UA7Zwuw2wd1o/LCEMD/L2zasE87E/7SdIWvt0gEJNkJ1v0?=
 =?us-ascii?Q?aczAMaEZNcsJC3Ae1PzxwIeKdeKCiNHToGTQlZhAXYBuifx1DSPyhD4ximtL?=
 =?us-ascii?Q?Rpfw4cqo6ozlvl/XcurPdkksb64AAcSWbLaugnnDpTtqxHjgmySTnlffvAv/?=
 =?us-ascii?Q?iI/MCbRJANIBh0vG9yPTy5FQcuqihMCR8+L9mq8pcV0oGg3d3rixChjjCR3G?=
 =?us-ascii?Q?0F35/YKgchr1csD387LlzFBUBU6eNB3zEMTVtk1WdvtmU/ODL7p1CMecR6sA?=
 =?us-ascii?Q?ytnE2KhY9MN77HVZf79Bj5npe1/gYDUp/LWnLrKNStIINZiTixU557YtZkJV?=
 =?us-ascii?Q?8bBndHQKTMVKCc6Ip+ohJWJYWz+5s3PsK21jKhlYRdGgcXDYQqVL7vcyKOfN?=
 =?us-ascii?Q?zgzohWNKYoRmrA8818Rb/Ckp7KoMISl7XqsxMfx+XMTzs5hi9mcxXqvLDMXp?=
 =?us-ascii?Q?WBiy0H/3uL5/3KMwuJsySPxCrHQxOw55cQdccds/ntvQXCKM1KAJ8/9LLQ89?=
 =?us-ascii?Q?bcM0Mi/HLtA4dzvHxGCNeMhXQdtmtD6uNGs7BhuP336iHmJSaDEjlxF4Uwe8?=
 =?us-ascii?Q?0xFrPip8EeatLG/y6bVEJwYJe/9TZFeAHrTm2+D6puHvUX+IeuBKnmfTaqjD?=
 =?us-ascii?Q?U62knZLlhIKccZdPn/WUheqYa7Rz2gqndxlEbSL3yf30CyjinIBvVXx26bzP?=
 =?us-ascii?Q?OHdA0QJNqA1Sv/wIgcuSPIKlx2nPlmhXvns1WfJ3GG6cDzBkXTVJSZ9D1Bi/?=
 =?us-ascii?Q?KtVpOAEhPEftY3C0Ilayx0xElkdpyS4xfT6C13C3vUhsEmrDCFg3i8AnT2C6?=
 =?us-ascii?Q?vlzHSaUYNpST3f+nuXeE5ZPNAdA4j0oMMjJ/xLe/uz054WRfBCtE7cVycvVp?=
 =?us-ascii?Q?0VgkdMeKqgJNdFimOU3S6KY4kc9gACQtU7+PIZ0q0ov+Yg6AF+vR+s9S46Q+?=
 =?us-ascii?Q?lp/qoetsm5nKmUL9/36LmLRHTHt7Tf6FDoXcKXO7iA7DeAvMyzcHz/Lz7JCb?=
 =?us-ascii?Q?BOI9n/hE6oVuaYL3Ne/RVGRa/O5aswdM/7KqCMyOrjPD6jcmEY9R6SLqDqZ4?=
 =?us-ascii?Q?lSy+sylPFzVe+8Df5RoQiL/Eh+vh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:45:55.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8b61f4-e93b-4d67-5553-08dc6dfcc366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 37615a77287bc..5dc8663a29e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -394,6 +394,21 @@ static void nbio_v6_1_program_aspm(struct amdgpu_device *adev)
 #endif
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v6_1_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0,
+					 mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.get_hdp_flush_req_offset = nbio_v6_1_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v6_1_get_hdp_flush_done_offset,
@@ -412,5 +427,6 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.ih_control = nbio_v6_1_ih_control,
 	.init_registers = nbio_v6_1_init_registers,
 	.remap_hdp_registers = nbio_v6_1_remap_hdp_registers,
-	.program_aspm =  nbio_v6_1_program_aspm,
+	.program_aspm = nbio_v6_1_program_aspm,
+	.set_reg_remap = nbio_v6_1_set_reg_remap,
 };
-- 
2.44.0

