Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBA6103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C4310E825;
	Wed, 18 Mar 2026 14:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3YXAitUK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EF710E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlgjL93lDwcLmkLFfDppZ/S82fvg7cKpNYEEkTIAGXgwglJyNg8CC2Kv1491Gl1VavLBrKCBqUMk4r9lZB3P7dXXZmgDy3m1EJEgnhyLkKLezFrTuDOXPpc10Kh/9ln4z+g7hlDcp4ZThzXOsnoxMlak6dF9AVUsZffRbp9LHvjWW59yZkF9kanH09LinYUVrH4kZyu4PF5v7ipU/Vye5EcvbXB4WgQ5E1wKEHfmxxfANs7ZStpzBpBaCV0UVo1WQArAJxknbW/NTnh5dT3vOer4jZ3z0BFTorTeJjxtP1nwA37n3DBwvYaIe0+Ouz39j9WjDcXbI+wCOBovUNFwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URxzpxM4SNGl2P/d99OcSkZHWs9WIvu/hdx/F4SKDIY=;
 b=LWzIaCHfdR5+9xohYZg/3YD9HQdlTT4T5fa5cBxyvSyPfUD8LqY/7jOQ4U5S00F1D1ZwInR4L1QLQVDMJfyLzJ3C2jD5eWDTPAts+J/qwBrkDwnNCgO9skJKf15HBcUghPLyN18OvOht9cHxzZWURBPp5vHrxsAKbDc1pajSCliFWxe+iH3SRhFnp7OOdaWTnJMcBk3o/vCWrmzswCx7+62pIfT8FPrBYy3PcNEWTysN849gxytLU7+rGYeCS2dDNaCm1JpCDXQq2Ez10ZoAYR11Hu0XXruQ/m4bVjiQnZ9v0vpUU1IlyJnum2qMQDHWY4rwn2WbbxwCMYmWbCIFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URxzpxM4SNGl2P/d99OcSkZHWs9WIvu/hdx/F4SKDIY=;
 b=3YXAitUK07BNq/O7yVGfZykFXlPk8NktlmBxHna1O6WD6k9ReNuNXTem3obbDQVxrU41OlAjUSpihoWa7/6rRHmGgiLNBAG1LrNkHDGItwcAas+qe8dNVXJ/uz3eHqlN000Xfh20tc5FAgifilqbQ1H54MoshS+nPGu9YJymRRM=
Received: from MN2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:208:23e::25)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:10:26 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::81) by MN2PR14CA0020.outlook.office365.com
 (2603:10b6:208:23e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:10:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:10:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/sdma6: program quantums
Date: Wed, 18 Mar 2026 10:10:10 -0400
Message-ID: <20260318141012.583021-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141012.583021-1-alexander.deucher@amd.com>
References: <20260318141012.583021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 7367d469-2cd9-4f24-2eed-08de84f819f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /9bfK6dvWmlXy+5ACW+mOjjqYbTeQVnqXOKkwna63GjoFL3D4mSFg/xbAK/jr24vnEjX1crIq3MoX+L3q+w31EJGv3Ri3ouP+xXJ7aoGd7mkRu+ycM4//weVySH/EeGyEOAB8lV9kExqoVpGumhR1Ubea88U6yDDFK+8zETrztvlnHmgse6WV44cQiFHHA/yux9yvaPEoRveGrDOdJuFIAFoZ3vZ0E8NiPPA16iwXHQXiYIL2rQ7tP3jVlFYFf0HbG7c0ZifUDy322giOlCP57qOZWGOWUMa7QZyCSGw9P/N8mxR2z4QugGYWrSGQ1K5ZBAOZfKfLLFE+c0+vWNEeo/X5KVj3ovENll80lmSN8HQjWr7iVImW6eiPH6l3DCl4GUnEIP+VWZmGO4kNL43jiJ4u8Eo0gQzMsQ1VLR9wINNtXb6RB4JPrnL4su3//J9Bswh0Jywl4tNUDu3bJs5A4Sf9V2oPpo0Xhmt6cKPo44s2OMcLxjjFWN3/8wKQuNQ92CcBdWXXaa04Xvn6YmThweut0Hbh5KScY0yBagyR4nLy19Lg6MJwAHMjEuD0RkML+HW6IYPXKEf8VIjIlFI7FvHQCfv/wkRJB2BYYCmKJ7Jao0f+/awmddy7nf2B3J81TdXBtX7snzlQBz5xTfrWAtWrNX/0j2/9Pt4S8nFemFLcmrQXbWu+KacaJ3JuArjwrAFOY1oHJzNIrKIztkoXro+PmqwO/BFeZh3ty2ndAF2sSImziIopqVh+X5QISQgG0QYsyIUdBv15ei2RttDrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vfGgpIcPv3EiGZeyUaimvSACZePMrLZewK+mjGFVt4E0WyP+3Qu2y5BCXIzrQ5z09anrK5suhCnLX0yoVXOUAiNbTMCioIt+594fO3Zk1trLWyRPJfBZeIXtey7R5HBDyBsUqrQBOa8AA1WrZW2don8nkRd7F748dfB5z3ht2YbKWA+au+GQJmB0XJMzQPfhvq74ChZ8MHPp7mFOkVtjZgc0YLKtbWFVIMUkD7ubgqLE1+z/gyuSnwEzAtforftJDRP8C18d81/kTwtjZ+zjm5vnL/EtxTke87Ph7zfWm2YGVNBeVQYZ4cpgW4j0STkXhTgmAAv9VO6lyv799y29SPDGidKQ0Wd/bCBMnVf80tg5YH4Vfph7IUkCczY/uRb5yNvzAUO1k8SgSO00qlinSjwZYk2xWgh3vRAX4eO93+xzeU90E1WnHhMfGB3bl58w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:10:25.5138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7367d469-2cd9-4f24-2eed-08de84f819f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b005672f2f96b..3af5bf0f18426 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -505,6 +505,38 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
 	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
 
+	/* handle queue priority and quantums */
+	temp = REG_SET_FIELD(0, SDMA0_QUEUE0_SCHEDULE_CNTL, GLOBAL_ID, 2); /* 3-0, 3 is highest priority */
+	temp = REG_SET_FIELD(temp, SDMA0_QUEUE0_SCHEDULE_CNTL, CONTEXT_QUANTUM,
+			     AMDGPU_SDMA_CONTEXT_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_SCHEDULE_CNTL), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_GLOBAL_QUANTUM, GLOBAL_FOCUS_QUANTUM,
+			     AMDGPU_SDMA_FOCUS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_GLOBAL_QUANTUM, GLOBAL_NORMAL_QUANTUM,
+			     AMDGPU_SDMA_NORMAL_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_GLOBAL_QUANTUM), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_PROCESS_QUANTUM0, PROCESS0_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM0, PROCESS1_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM0, PROCESS2_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM0, PROCESS3_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_PROCESS_QUANTUM0), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_PROCESS_QUANTUM1, PROCESS4_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM1, PROCESS5_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM1, PROCESS6_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM1, PROCESS7_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_PROCESS_QUANTUM1), temp);
+
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
-- 
2.53.0

