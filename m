Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045E1EFD21F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 09:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C62B10E72A;
	Wed, 25 Feb 2026 09:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D7MwfXaX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EB410E72A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 09:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZZ5nknGyhvtjLkYtgilNuk2MC/Ahc7n6Z2Wav8XL4UR/1e0OGk7ZTh15KJYvSa6ABR5vUQXwzLoyq/XqtP0YD9sbEOSgjpAV0vh20klT3jI0PxltEpZVFxTzUc8wGStlwEYqJTmkdPbHiHvR+CNEc3vHgOVV8zM4n+7LodpUkU3dyGzJpZRACGh3sL2mm0vAMp6uORHCv3kE8SKv+s14vzGRPNt1iE4CmxYK7SuxDJFa837WovAAV0A41of8mBG19oaXQ9OS4eA1dI2obQvNAQRe5mmGyLMssNNmVZjRShjZ5spySfPakaWN+W8n/W9LmTFjLHK6W5I4RAT4cvdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cStJJlBIVHpUQOHAcIajBPLh/In3BnNw91uPyw6oKDw=;
 b=uBKPetTQ7w6dH1WvmaPBmXuRym9ouVgCj1emzjee7LSD4TzuRl6KVtP0TAtF04cRoOpffCnpzpX/00HIGDxwfIzLfi9W29x8IAWMMD4Shbzk4ikVv91HjzoNdLcEnYgZjy6Xu3LhKHnJSPqzJKQ86oZcZpUgj5PoFdeMs5VPeHHhk2pskVlmpW9XFEUZlDIBfF0s9JOzOBewcgkWY4d7AxjhFw1d07WkRV0jzIeo+LkInm6ftnk30DWuzwZG8pAe141ZD5M1K+asnLWY2X6mLMJtFFeWiMKpZjqJ4sfNbsbDLz3XGXAX4uCx0rSLW5UI02TswFA8+vLVH+v/OR0ZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cStJJlBIVHpUQOHAcIajBPLh/In3BnNw91uPyw6oKDw=;
 b=D7MwfXaXhuNMKWSNqlaXSRBudYw4yT2Au6CF68mEXCJX24ete69qfSuSJU41FyTOR26wWxFJ56BrV/GJzvMKIXKqwvoZPm7tWe0+7DKqWU6bOxBQv2u3Mhdpdwtz84ScJygKrwdXjPjNak+xE8u/gYlO3ePc9MacdXDo2cPR938=
Received: from PH7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::32)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 09:38:00 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::bb) by PH7P220CA0021.outlook.office365.com
 (2603:10b6:510:326::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 09:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 09:37:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 03:37:55 -0600
Received: from suresh-X570-AORUS-ELITE-WIFI.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Feb 2026 01:37:49 -0800
From: sguttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: sguttula <suresh.guttula@amd.com>
Subject: [PATCH] drm/amdgpu/psp: Use AXI address for GFX to PSP mailbox
Date: Wed, 25 Feb 2026 15:07:34 +0530
Message-ID: <20260225093734.481140-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: f2893d17-6ad0-4149-cbf6-08de74519053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: fn60XDIwrMYvu9JEUAVX43/vrk9qCkoKbRQpp5e159Uko+W0eatWCFs8l4z+OnykfObAfj2yXX+SYLWQx0IUPVCezIBX2scE0lzG+nsTI56HlIdSWqPug/0gKOHWwS69QUfAQjbeZoI3o7koXzpDEE5ZoKudPrBpghDzLFgyBqEvsbpRRe3y/lWbdMwVhSpEMJTnyxFo4qiwYyvbOULefWOrZpzcBFqNAI5ln0H+JGkcITjegKXmT7IwDxT+dWSuq0MEGxxuZupmamU3MVXk4qEfRasVIPFuu37lEJW2pPt2eiivqIiN45nFAaZab4XwGn/Qd/Q1evWeEfhtfrmbhC2mUYksX445YqmGpz5eUE13v8qZ8dye1RmI3gHXVAs6DnDpiv0aBMYzIeGyJSkxz7RYYiInmYS+uvhYVYFnlB+1vhIbZDQQaNpcGMWWMLhZkXr7jkPDI7lpQlVa0XzoHD59klD8TuXQa6QPNbFyWVhxFHXF9useijwn4tbbnQhC7augZ/FZ1yfp9s7rJ4oRu7fcAnwDYFomR2qX0TRLKLuT2s/JsUQ3FgFvmLHD0qArAC4FF3fYC8Sd7ORS9m0wA5y3CXnYjrWxAh5RhtO8+qD8tV/tExvwhecrioet35/+hBKVcb0+bhjYUGZaxQjdU6at2teTGlxwsPeitBcNa8rWGwrU9jCPWX93ejuwpgFnJmNMStXbIvQwjjvuRUQ++sXkQ/hcdIUCAiW5NvAGY8cldIefrrO1B1Ysbnwjc1xKoEQHE56wwj1ddMs52eaMBs9iI6n9Tc7osn2lHRib1u4bLvoFO3y9/+4wXzJqEoXQvbDzoiJMvU4mmGBoo98ZVGazHVx2Pskjq5ATZ3IaP/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EicEkzlC9dMCimsQTU/d74oYobg1m8nKUsP/tHkvWo1U3ak6LXrApK+obNnzbN2wggXPSIbfgPNMOBAp39PbnTAdI4a0hRvscVSBuxWXcjnuCCTVT4Jww4RcQM2csgI1T3loJ27N91H2pMAR2XGYeAMH1zfwVm5nPO05CTtBHz37kn2OZubveVmSHhowuirwxu43hZURmTfE0GmXmlKuZFaHqdR7eKDIgI4owjj4L0ssW7c0ASQCug3axLM97zaWh+GID8D1uXnq08RUgQEtOKBtuFGf3CIk01TlLP2fFBuwapD6VruMUVS4CedC5P8ma4Ukb7nrz1OXXjE7NCLFJQX2HwX0w7Mgbjf8v/juzIG0kqcH6yprl7GGI58TBZKea83zRr4ox031lHJYDPHkkziUUGQfNkBrwhNl5vXzI79yTciir9e/GSszBCwT+Qt1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:37:59.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2893d17-6ad0-4149-cbf6-08de74519053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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

This change will update GFX to ASP mailbox registers to AXI
address space macros instead of SMN address space.

This will help to fix PSP TOC load failure during secureboot.
PSP allowed RSMU security policy for R/W on AXI address space not
for SMN address space, GFX Driver Need to use AXI address reg.

Signed-off-by: sguttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 723ddae17644..73a709773e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -69,12 +69,12 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
 				   0x80000000, 0x80000000, false);
 	} else {
 		/* Write the ring destroy command*/
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
 			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 	}
 
@@ -116,7 +116,7 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
@@ -125,23 +125,23 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
 
 		/* Write low address of the ring to C2PMSG_69 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_69, psp_ring_reg);
 		/* Write high address of the ring to C2PMSG_70 */
 		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_70, psp_ring_reg);
 		/* Write size of ring to C2PMSG_71 */
 		psp_ring_reg = ring->ring_size;
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_71, psp_ring_reg);
 		/* Write the ring initialization command to C2PMSG_64 */
 		psp_ring_reg = ring_type;
 		psp_ring_reg = psp_ring_reg << 16;
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64, psp_ring_reg);
 
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
 				   0x80000000, 0x8000FFFF, false);
 	}
 
@@ -174,7 +174,7 @@ static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
 	else
-		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
+		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
 
 	return data;
 }
@@ -188,7 +188,7 @@ static void psp_v15_0_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
 			     GFX_CTRL_CMD_ID_CONSUME_CMD);
 	} else
-		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
+		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
 }
 
 static const struct psp_funcs psp_v15_0_0_funcs = {
-- 
2.43.0

