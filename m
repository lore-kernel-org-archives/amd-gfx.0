Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE37F103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E55A10E83B;
	Wed, 18 Mar 2026 14:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfbUmCbr";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A1610E839
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa+3SH4W9KYwyJlyHpsQaoPXCaoi56dHPrRvYTELxhdHVmkj+z1r/Ag49lul7fFt83ZWxvYwBUMqqDbAsIuhOFGw8/rIrCm2rHA/nlIluM3jg2qx9MrKteynuTcyJ5wOZep7hfa5+0CpX8DxQJfqykfgqNgQC2vSVjZLSDH8aiRNhimgkCc2WKOoIb0vcS7mgO6DqipVEGJl/UnpFUdvwbE6xRcakLaTuaU0HBHlnH7LYaTg69RaBIZu7xYzcMUPaO2dvjuCYX2wnEvxzPgq55ONyz7snU8Nlqj7t9+GuNtZrb9ABEgz92F31dCzZhTbtcRrb/ORFYEkU5dV9S007A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdD6ofIprG0ssQK72/8omy0ktWbHR5PEhvZgpJUtv5Q=;
 b=uRUtH/WdnyisYiYC5iswbxYaJk+KSzptiETlhFTY4pCoupCmE9hEjFBtL0ySY+a/MAxbVkGQURq6wMBBATCt/GiSQWsw82CSouyD6aj1FGANf8mQ7NOSb8imm2MZ5PI8OiZyWQy/nDDorN7LCKEMFZg46XpvgEXpS+vB/SIXQ7qiyTuOuV6mtix2D4O23WqSa5XlA70VpIvb7mlAQixdASS9+wIbhE+2I9rz7oTNk1EeUZJDL2LGH/it9iz3KAwtpnHPGStWOPnBlXp8VtqQM2Eeq5w36J54cnm8mrwwyKQzSEX9LsTUq80u0EDAEle+1AqtPnF2W6uiCtacJurdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdD6ofIprG0ssQK72/8omy0ktWbHR5PEhvZgpJUtv5Q=;
 b=bfbUmCbrHlMEUAz6X1JTc53BkMwgHwonvtoEbRSEa9o/jZAm2Eb/ZIQlW2klVgkoo9Jszm+mgy5D9q0BjH1AgujRbGeD4nfGYKq69+s4bCI+fsESd9Gl59srtqifws6mMgD9Qr40XTRSc0Zl7rc+D6vY6ly+inftabHyI2BHYJs=
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:10:26 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::f8) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:10:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:10:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/sdma7.1: program quantums
Date: Wed, 18 Mar 2026 10:10:12 -0400
Message-ID: <20260318141012.583021-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141012.583021-1-alexander.deucher@amd.com>
References: <20260318141012.583021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d98ff54-6d23-41a2-f53d-08de84f81a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N+7JszZIk8xRtlrXw4RSYEYYru5KVwrVyJh9l8EIu6Lwq5oHIpQyS9Wu6x0+H6miHD3Zy2zqlCUjUmKfxvrkquFNduiFh1D8UKGhHnPPXuHaBLrDAl12LzDMqQOQ0iIkDTXpDbK2ywEXgbLYgQH5yj7lNuKarO9qc01Q1+UalS//ZMBebFA3k7dvLZm+ebNBcmnDECvXPziAjY0LXLpeNHdnC/Yrd2KKMmm53IpfkIMqrDcsAxYZzxJlh/74ETnGBF79iE4zQPNSA/XgBEEgfi/ksusKGvScHoLp5fwSU4qTVSuXNKLGL5k0J5TWnLh9AOQSpKzkKefGtYoOICMUrox/ymM2o1ls1OuRbibfA63kddMuAWuMll3afeuejLCS5BmOa6yB31fSo0ISmu1eQe2UB7RbB7HcYXHAbtYkyCyfRS+SK/eZDh0yiunHtLIu1VavFAYKz6fnRPZMYmNX1Q/Ct1VctngztCfNkqJPJw2qlXG8LOBgswH2oTer3vGuh5Q6LCwwbekhWy4FDFsaDxp3GVKD+hbxLeXrxvQu/Mv+yyNH2z8WQvUwONPD6EVFIr0NX9qLVdbrhoFNtmPI50eCXhgIOFz9UPP5vnNr0BtA8gQSgoZOfeIRS9nUH+Gm/U/jo+tdVRirBKjsJkl7qpTp1v+xOLmgGolnU8qDSM4IlSpL0iJP5oqESmg0A8jJkYlmwvHXWzagiSyaCdhvGW54iOkChOLV78jVwzwy/1zwzvor2D4GMYupO8kJ3wIhC77Q5UfVRZpAlC4RuqKVMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Ww17TKUE5JADQxZ4dPCQnT0imI7PjCfAWKWkcpi30p79cQ3yYAMcBo+4OeGFQinyIAD7jveaqMEy+w8pAPODgqj4Lkregzfni/MLjONKnDdE1pleOR+M5AM2o0p6AyvddK7FxhYJOB3YBDNTRHqU6J9hc2MgFm/yvNKwfAdPhNl2wfIGO20B9tBnVfCFvfiDkoBaFZeqXrLxWU5Ke476+lsHCYALCZPZpuLTDPk1FsrHFyVVZOLY8+cKiS/PalYrOYc9LCZnJ7WhgtbBnU+/Etl6cjvBQ2y6QgODQoHAeOWDPDMcZiPutyboLLtwOrelv5ljpB/jwaIaLlHTtpDbdcMaex0DhWe6IwPEnK0vZK7yMGyiKezEBVuL52q7ACRLWDOHyOmrjefvTblFGXEU36nRrNyKHnR8vGte/9vf0k5YVMl1qkVRCdGnuZr26mr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:10:26.5882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d98ff54-6d23-41a2-f53d-08de84f81a9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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

Set the quantums for queue switching on the instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index f20e0fc3fc743..244f7df5ede19 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -478,6 +478,38 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_PRIV, 1);
 	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_CNTL), rb_cntl);
 
+	/* handle queue priority and quantums */
+	temp = REG_SET_FIELD(0, SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL, GLOBAL_ID, 2); /* 3-0, 3 is highest priority */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL, CONTEXT_QUANTUM,
+			     AMDGPU_SDMA_CONTEXT_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_SCHEDULE_CNTL), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_SDMA_GLOBAL_QUANTUM, GLOBAL_FOCUS_QUANTUM,
+			     AMDGPU_SDMA_FOCUS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_GLOBAL_QUANTUM, GLOBAL_NORMAL_QUANTUM,
+			     AMDGPU_SDMA_NORMAL_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_GLOBAL_QUANTUM), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_SDMA_PROCESS_QUANTUM0, PROCESS0_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_PROCESS_QUANTUM0, PROCESS1_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_PROCESS_QUANTUM0, PROCESS2_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_PROCESS_QUANTUM0, PROCESS3_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_PROCESS_QUANTUM0), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_SDMA_PROCESS_QUANTUM1, PROCESS4_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_PROCESS_QUANTUM1, PROCESS5_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_PROCESS_QUANTUM1, PROCESS6_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_PROCESS_QUANTUM1, PROCESS7_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_PROCESS_QUANTUM1), temp);
+
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
 		WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
-- 
2.53.0

