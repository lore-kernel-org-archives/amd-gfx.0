Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96727F3380B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FA010E51A;
	Tue, 17 Mar 2026 07:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZiGScsz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7153110E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5RHRHVegOx67fPll2gP87dsI6q+KcDDiBev6L+TXPlM5U07FGyZQTf5DsLrrXsSCCRYtqdbqhJ5H9c8Ccj7x3FzAZRcvgxnMGxcj67ZTveXCuEDBOewIHUuQvwh3MibytpdPTsVJQzhgCK4bqChcY60p4sdKHyjqiCH6LPKF8y8FAYm0CWq4VUStv8IrjzH7DMeS43jDLeGFKLqDhrvOqyqrL7fjnf4RNCwvtVFMhrNB6m+c9zyntpz+dZEFUWkhWZeA4GMLflhhAwZVL2BQ6PbvFakfdHFbu/jpVhZd0ezuWndJUuUIdr+PN2tZ1uEcCO4WJpzQk6oaiH/ulfjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvR70M44Y06MGDEw6lLGTmFlRvtGXTAbImTNGgFEP98=;
 b=PMha73MP+BhBS0q1RjzlXawCAMnhikiAwc84H2flpDlnzS6GQhKehLyONYtCBKXRzfHaDitgDkHIOqzMpN0Q9HFAF5rJSEAIiVoai4XNB+5efDIR7FoYs2XP5QVqFNXBdjACA/UDZI+gh8CacbFMDDyBhTXFyTkhbRCe94z3eWfQ4sHwIFK1XS7vnVYgulddwrCA8tMtFEje/E3dgy32ex2gX6GgTxEtyEUOz6Ea2Ej3X8X5EHieUJoHkdNO4m6GuADhzUv0N+hyl6dk8pPvaVt/CB2G3ljsSSovPE17xPrsK9ndyQADJnzLEkO3L6oL4z+F/rt+ti/ADfAHBK5zLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvR70M44Y06MGDEw6lLGTmFlRvtGXTAbImTNGgFEP98=;
 b=OZiGScszMVZ2TEfEqHNYeeD0TTTFwJUxvyVWgLL/0IJOL8IGIxTcIVseldjlAlw0ln3QYhkFJk6MpxuGtSFmmB8mxo4XjNOvG1HuM2XgEMnSuyFhSelL1Edd94lTTqKXeo53oa6iXI/owxjobuSQLbQSQ5v84p4L6ODOWo3yafo=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 07:48:20 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::14) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 07:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:48:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 02:48:19 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 17 Mar 2026 02:48:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 "Vitaly Prosyak" <vitaly.prosyak@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: replace WARN with DRM_ERROR for invalid
 sched priority
Date: Tue, 17 Mar 2026 15:47:27 +0800
Message-ID: <20260317074804.2363458-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
References: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a57e11-3fc4-4b64-992f-08de83f98eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: bJbCt1Zzt94cvahatjYRPm2wWpv+Zxo66URkYkFvd4PzTdNl1z79ZyweiP4zLgZq2DW50qWnOpORFN1h6232tO/9mDnVGyJ2QCBMgZv9YwKuoKk0gtPYlBe+NR29hQ0OJRx1PUrySuerdqYWIV2DlOCjtZ9UEFRaU78LbiLD8VOXW93BaGauyJZ3+Zg1WORhGjvgZRMoBLNsSWHnvFJ52F8F0jDPCpdt7V/xM/zI5rcgCK2W5KZDvzyAwWBXPda0ioKz+9FeEchmZKNnSFU53d53adtrgIktxO2xf30fSccXdDHKlbdHsTKhK0J+JlfpZWJGLb6x8wDHUJOIYlqlbtmRnWcmkF4lyrDpiYle5CzV0wRprePvoEIVOhZXkFHbb4+P4x5CuXMiWJCaILBmcnsU/p2Wd9PzKx1DClgoGOircA/n6QLK1FNkp5334VcPFSLsE5L1waZfiMsB2Btb2Ao1IjJD3o2/PAdaM/5fNhRR0/oUcIyfc0uEDys45c3QK/QO91fou563QKq1qP/y2TKu8RDxCSIqSb+14jgigBNnqN3iFnDyBr9cI6BozZ9MUmKanwPoGODgZGpkWkwMdoNCDy0pNfws4QDLtq1UUDPdkpwlH+vo0nfBZGYlf2z0ACMOqWBPbyIqMkaScRmaayWnAl98q+yTYw3+DyuYXRhfbwMnAtkiYubSspfSO6ElnajUvOno1BRfElX7B6sjDryUWZ/gNnqumb8BKZK92SC6S+WKnpFhQW0s/3Q3t54ZsgX+QkD2rTxz2tZH3JWunw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+rGQdS7eI6f2euRtLXQogrcxRfcitmgq/XuU+Y05DJZq5o+rVaff9PfDnX+SqIZRLEhdQKUtvcrctq2aUK85D71GK241SMl2ZFpC3JdS05aooJW9z4CR2NpKz+Vddvis/o+QDhFFR6WoslKWzZnDkwMAtb4Bubpa3KBQcfxtmXSe2ZutGFl/kBConVmquQAnFTMwoARY5utg9chOGZYfHD59aC3VDCPVGPymFhBNfv82P1cb2pH6oWlWYDMuOQ1gaXekNBe7hd8V+6fTh5/hhwmJwf5MVOa8Hlw9Evau1Sk1nDCtbKdnKOOqQGyWld+3EZV+DMY8+8nA9an0NdX4IQP9bl6J9MxKFzHvncUxWxmNSW4owtPyBo27OhwfK//VaNgavXGomg3ZE7j2s4LJuSWcSwO2+G+nqDGXVQkalQKNLoYQ5RmAnlcMJ3kJQim
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:48:19.7461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a57e11-3fc4-4b64-992f-08de83f98eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

amdgpu_sched_ioctl() currently uses WARN(1, ...) when userspace passes
an out-of-range context priority value. WARN(1, ...) is unconditional
and produces a full stack trace, which is disproportionate for a simple
input validation failure -- the invalid value is already rejected with
-EINVAL on the next line.

Replace WARN(1, ...) with DRM_ERROR() to log the invalid value at an
appropriate level without generating a stack dump. The -EINVAL return
to userspace is unchanged.

No functional change for well-formed userspace callers.

v2:
- Reworked commit message to focus on appropriate log level for
  parameter validation
- Clarified that -EINVAL behavior is preserved (Vitaly)

v3: completely drop that warning.
   Invalid parameters should never clutter the system log. (Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 341beec59537..0eecfaa3a94c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -103,10 +103,8 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
-		WARN(1, "Invalid context priority %d\n", args->in.priority);
+	if (!amdgpu_ctx_priority_is_valid(args->in.priority))
 		return -EINVAL;
-	}
 
 	switch (args->in.op) {
 	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
-- 
2.49.0

