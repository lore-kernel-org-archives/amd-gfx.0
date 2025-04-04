Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B4AC36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 20:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E5810E330;
	Fri,  4 Apr 2025 20:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XI3HLixO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9CC10E330
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 20:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcNc3a4Rtn5kAu1FaU4ToS8oPCYvTYECazYQP9hhFD3AlnGJzJcnCvOFSHbnUe/iGlgebV/cWOEqYb0Xkh5Sa78yEtbXvS4GUPxFN4HGcGMIAalz78pfF6xM4kB8RcV+9AcCLRUfl2e81sAn4N+TySwueAS1dQt1FEKFrNou6o3MSssqvELCS/WMnp9fjW3Bg1k+Z65Q6dDW8jXgkR3+xgL2w5D9WCQmlVV0pYdGWUmLty7DhvT0Fkx2O41+JJGTaB3ueimzHEAyfo7dHKSZxlnrrPvR3JeLfajD3tCB8L0RVA3fO1F6TJPqjZcDnc2XfJnzW5/Gbi4afwOecm9CLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5I/sgOmZPEpctJKP+E0+gJKsmoIwMak/OZEkGlJZPI=;
 b=TAAP6OjAP6cHNNj2kil0oRczBN1hn26EBpQl/bvD7oGvXkkcjCsT6kvN8lRocc8E+xWwauu5bzUoou2P399PldTGEPUaE42iYx/0KXyH6jls7t6u2DB8IaiN3uDdAJfxIAQNHCzbonhe4GU5EiBd9/XoVRwGcBH24ipf2uc2U7tDJfsp/Ud+o7kalCsgM0C+CcmWsicqW7ZsDbeyzXBo32LyXXjkw1H8Wg2eGbPkZt4G2HEB3VoPo01+AuE3vNJ/kAy4Eka38d86T9FCMWQYN3LbIiOGQBwK3gNUSBV8U2Q447PUzmevXaioOYuje57wNJnvLmq3Ug6D5UOd1uuAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5I/sgOmZPEpctJKP+E0+gJKsmoIwMak/OZEkGlJZPI=;
 b=XI3HLixOWWmCeDpvkpllFgXGVmFHVmShBflA+VSYAV6y6jOYaX7fquFr5tZc5H/f9qTktX9oPcrV7gmUgvQbZtARm83b4GmIuAkBT2WFripmoJdmZmIYU3//Dlo5nd5lilwtZtf1JKjqG9gUwphkIbJaTZH+uFqdU6yLqFfcUAY=
Received: from CH0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:610:119::6)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 20:58:58 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::62) by CH0PR03CA0379.outlook.office365.com
 (2603:10b6:610:119::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Fri,
 4 Apr 2025 20:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 20:58:56 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 15:58:56 -0500
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH v2] drm/amdgpu: Modify register write via PSP
Date: Fri, 4 Apr 2025 16:58:41 -0400
Message-ID: <20250404205841.535098-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc32859-3891-49a4-a610-08dd73bb842f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOIjWdtPMbu+J31kHEtssK9uxpQCb9e46JhqBwaivZMpqXN1ysHFNvS/9aMO?=
 =?us-ascii?Q?n/iBzjthmAwDiFpKVrlrTU3VduYxr4as00hZKtw1a+9pCNryKVbS1ykWXrtl?=
 =?us-ascii?Q?jnqhvTUBtqxHJKAIr7+kPE+dppHJcpWhDwWiT0bcC/y/6fU0Z9pfZvDtkd4s?=
 =?us-ascii?Q?TZNlqp8c5sLgaKixPwYzsPPPPizSPeIfEM8C64nFfE29Ooajwf/yIB/81rBJ?=
 =?us-ascii?Q?ZzZmjBlySdnjtbZ4kyCzh8MES0HjehAamSV8EQ9MijXkHd4dwaXsEoFPXupD?=
 =?us-ascii?Q?rNEZZROJfgis4EJg11wPNXrSeACEhRMRCetH6bj873aXrCs9SaXFXty88YX7?=
 =?us-ascii?Q?dNVek+28bgQdBJoBRtomvZOtMKnMrBdvZtjKx4kwFzFiq3MC4XKXti9WcgOm?=
 =?us-ascii?Q?sG96PqrklupFJVM2puVp15t5LEAFYv10ghUZx7vOzRTjOSsc3f0tB/Hh97C2?=
 =?us-ascii?Q?7zDxnZmbK25Skb0tWr1gXP104iPm5jP/FF8KlA4o0FWWGDxSZqC/ZyW4Thf+?=
 =?us-ascii?Q?84INu4YytnBDpqKSxDbOuILfmcmcsA6ZCSsF/ctTg5o/Sa6AQ8rYJBcGw/eM?=
 =?us-ascii?Q?7VLxNmSl8OOwWl7WArLGMwWwxBhUy/ea+NeyqBPxXl/oNBPUKhLa4m7ix+bi?=
 =?us-ascii?Q?pasSbWVQ4ZUVoj12pfw/ZQiXVc+gMUZv7DjWuRDi9vINOHq4o/vihrtq98+R?=
 =?us-ascii?Q?s/2CjjCQjGenzE1sqV0F0y2KoaQ5SsAjlHLI7IsgofwvlOLRZLh4XrZzMozy?=
 =?us-ascii?Q?1Da+UYUUn07pYD2Z8Cn+ZiR0gb8VnCm8LN4062wfWfLVqaYkjVN+EzVI8aIm?=
 =?us-ascii?Q?4iA6Jboc2zYv89NRj6ztidqi5fti3oUAi9uc9TT7fSk6U6X7ykFNq3Fj9aRB?=
 =?us-ascii?Q?BQkSWLoNqul/ykEiHodSNNcwtpvT8q8IoX2MQ0AMnbwDWur3UD82xzaAPENc?=
 =?us-ascii?Q?drBMYlEbJT4LgXzQvfpz54XNxqgiTXQF48E3xyMfI3W0SbkQ48M2fx/ThFrA?=
 =?us-ascii?Q?b3Xi7mPF3PewwfJ0F7UOZdFIlLFuf6sgzeZiRP3KZ9RBd3PfGA4q0jpobFZ3?=
 =?us-ascii?Q?h440rPUA8Ou+h4AbRZX/qwS/TKJOFalaAxd3RqnanNFU/HJpHOWhuct7xJTL?=
 =?us-ascii?Q?Ax6KFS+89+SjBsE3KNT5sunmLwkKRajfDJ9A+waAKX/o6Fp3PU13Fr6HNgf0?=
 =?us-ascii?Q?Y/TBzBfm3fgoAxxD/L+2qLif0OwyDXSTuJvP+mulAwhMGmwYaFGWKYvT3q/w?=
 =?us-ascii?Q?8Rm/X6qtL2JtUsqBGSHO6z+DjVo+2QLsRNTFEycz/kvYp2ccGo8qpOGu6Dl5?=
 =?us-ascii?Q?eQFFX/vgftkzudJE7AiN6ZdPBvF4E2xzNthY0OR7hJob9DBNhWdBjc+fNgak?=
 =?us-ascii?Q?/cs+fO6lm9bIAcnJeWJmqcwjO1Dii0f9k2CQy5+7zWAy6lSiKDm09w39Domu?=
 =?us-ascii?Q?MJFUp6Ia0wJB6cE47PQ9pqGBRATAn5qVkwV3Ll4GAKyReujs61pt7e/1xBQz?=
 =?us-ascii?Q?73fxTLEaUBbbY9A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 20:58:56.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc32859-3891-49a4-a610-08dd73bb842f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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

This patch enables the logic where if PSP ring has
initialized then submit the register write command
via ring.

If the ring is initialized then PSP retunrs error
for prograaming register via non-ring method.
This fixes the case for FLR, where PSP ring is already
initialized and the driver was tryin to program L1_TLB_CNTL
reg vis no ring method.

v2: Add more details for the patch

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dbc3313fc141..8f34a277c821 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1189,15 +1189,22 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 	if (reg >= PSP_REG_LAST)
 		return -EINVAL;
 
-	cmd = acquire_psp_cmd_buf(psp);
+	/* Check if psp ring has initialized */
+	if (psp->km_ring.ring_mem && psp->km_ring.ring_size) {
+		cmd = acquire_psp_cmd_buf(psp);
+
+		psp_prep_reg_prog_cmd_buf(cmd, reg, value);
+		ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+		release_psp_cmd_buf(psp);
+	} else {
+		/* Program reg without ring via registers */
+		ret = psp_reg_program_no_ring(psp, value, reg);
+	}
 
-	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
-	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
 		dev_err(psp->adev->dev, "PSP failed to program reg id %d\n", reg);
 
-	release_psp_cmd_buf(psp);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 4a43c9ab95a2..05935b2c99b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -208,7 +208,7 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 				    MTYPE, MTYPE_UC);/* XXX for emulation. */
 		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
 
-		psp_reg_program_no_ring(&adev->psp, tmp, PSP_REG_MMHUB_L1_TLB_CNTL);
+		psp_reg_program(&adev->psp, PSP_REG_MMHUB_L1_TLB_CNTL, tmp);
 	} else {
 		inst_mask = adev->aid_mask;
 		for_each_inst(i, inst_mask) {
-- 
2.34.1

