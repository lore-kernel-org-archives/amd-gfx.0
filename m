Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10756C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA0F10F363;
	Fri, 21 Aug 2026 16:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CUZQFvlJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0420710F361
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqgVt6ja1KfWrtXh+OhEeFOERC8/zDIOi+6umOlBNJ3HCRDpUGOvqHViVieujscr0l5wVAqf2I5ce1VCABkvmEwL0wBtmiYahA6rM0T7fokvXYeDH64RALLb0iBQc+F0AzXdZJWUR/hTKQj7RqxQ9B68QNaPup4saquL2nK8jyMrax0UsLQrV1ZIxu7lhaMYi+2zT/hH9V2Ar57eB68DbQPABwYYXARllvUoXMAFtJIKUpON/xCDWsa+VaR/JHPhIgnOU9eYOZBqDjUdrRypGTMRnKAZWdiAV38hj44UcPG08JUJF0iHJAuSLj/Ns4B1xa8Z04oNX3XxoPfd4OzV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSt5OiOQ0biyb6inD2vohIDL31HwpM/+snHiVJegyas=;
 b=O+4FbZ5FIbseyjS5oABlYl1cTs11dXYKY47Joix4lTx5bQ91HTeOGZU1zBVPb8YrRGNq36kfuD3n0sypvazXK7iWtn5F0sNPLz1mxufssL7Mtt2mgY69kJaaSMtJfRWYnX/nqCO8TL7qzn68Xwx3PNossq6SXaiQYGDN+csstp8CfKik1Dvn+IOwZMnBuisLuhblyyCxReVGorIlN/2BFZB2OPH/rYrFg80GVctLzwWUiR0w+67oCVnkEphvcmHXhTqy6q8b5/2L0E1pMVQriwnC38IYIa5alSnNZQJ6CeAElBwr18yFLKhojUXIn0NT6dL7zhiuYijmxen3Pa6yAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSt5OiOQ0biyb6inD2vohIDL31HwpM/+snHiVJegyas=;
 b=CUZQFvlJHCHYElG8OkSttV+cjr8hp0UKQKcnyWXvbZQlE2O1eAEeWdNWazFeSsv1LZSyR/sg99GAZZYBhkNjRkLZGyY+VF6jMVLqHhNSnPVwBk5dxnI7qLrx73PlSyc2ZdWTnCs+luQM+zDOhrtyhzaJti/Ksf2khFya/n7G5HQ=
Received: from SA9PR10CA0022.namprd10.prod.outlook.com (2603:10b6:806:a7::27)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:13 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::15) by SA9PR10CA0022.outlook.office365.com
 (2603:10b6:806:a7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/13] drm/amdgpu: Fix GMC v12.1.0 MID1 page fault vmhub
 selection
Date: Fri, 21 Aug 2026 12:09:47 -0400
Message-ID: <20260821160958.753063-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ebc9f6-6725-45b5-a17d-08deff9eadd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: PnuLSD9v5JoU3EUl/pnYlcMe/GZV1OiQbQgk3Ozole0gpr+V+QdAFhUwrZ27eQb+IDVoOJa6t/9zFtqMCxiC9vl1+JePwFlAIPO0SeG14P1NKPB/OzoXQ17BzJNGaz9kXlwGZndUo/e1TUeMoTy92TkvFALFC1s2qKdOTZWRu2obOUv6lHibaFTgR3ZF18Dq5HmTp+swJ7m5GQQf3ttk8mzYmWWOB/5PFW2+nYDDk+aBpqBmBfQJVC4OWFmYJCcz7bi4u3b6RjF0lVQ4c/SvVO/Jt5CFM03HtupQnvRhrVP9n96vTfrwG6DpO5Z9IlGu5H8S52FoGX3sVxSEBsynu+unTuB/xfLsCC6PNxELhkX9BGr3C0yyOpDrrAJWZ1QMQ975DPS3l9kUs2u53O3OoN4WMSs4YUduoEGnaTzxVihw9nmO2lY5cN1bvo1mCGw8Aj8MQpBr8X1QGyBh9Yai9ifrkniZwGUkYoHskY95yEFRTfMZNgO7euD5NZ4LbYoARddlCBh8gKZobW/iupAU7O9XmSdFEksXUHeJpG9gjaR8znoNN1uFIPM5KBJUn3x9JB6mGY5GJO8/hhtx+Ph6io245URfyojQNuXlT2rAlhwwb1aV3jrBs7hx4V5zV0XwJDvZXItNL66wytiKxEZfTQeXDuqngMC6znH+/QhUO+eIYkBzC4cilxdz/iZsAy3+xktp2Eoc+3qUO3bkc/lvqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9OVszsbVVqgjdGI6u/3SYfacKVe+UeeDQgS2hK0wke9V9adPhRAGAn8PI/gC6hTQK5hc/neYInRDyC6PnnVgkihKTW0vtlDkoRlLS7Wq0s6pdLctPVWIy9LdO1kLQw0BntdiksEqGZ6ygFUwAw+ecRBZky9Vuw9zXcPX1d2EOhuFxsXsxvXFriLqXSbSJKVQV2Z2q1S8OJFzaj7kccKxkz/aPbC1Nu3+YW4ozeGtIYfcihAItQGparX59SIpyHpzR/5m6iIUQbn1pLtOje+6sFvqURUJmVuxco+8CCt1JhNUhEyjF92woHFeiwFuofXdKhOIzHYn2H6MqNk6MDr4hsofTK9UEjf03Dbt9UJhzmVZXHgVsBh6EjB+cUPxCNEp2k1U3fYFvQ3CZikI+jqJjEblkA5SZneGN2qyrQjOMm9kANifxLF6o/nyldf8ydva
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:11.3898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ebc9f6-6725-45b5-a17d-08deff9eadd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553
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

From: Philip Yang <Philip.Yang@amd.com>

For GMC v12.1.0, the IH cookie NodeID spacing is 8 (MID0=0x0, MID1=0x8),
not 4. The wrong divisor caused NPA page faults (node_id=8) to select
mmhub2 instead of the correct mmhub1.

Fix the divisor from 4 to 8, and add a comment documenting the NodeID
to DIE mapping for reference.

Warn once if page fault from the vmhub but vmhub print fault status
function not initialized because not all hubs are initialized.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 5fe43f7eab29d..ecd17ee160194 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -100,6 +100,23 @@ static int gmc_v12_1_vm_fault_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * NodeID definition in interrupt cookie for gmc v12.1.0
+ *
+ * DIE		IH Cookie NodeID
+ * MID0		0x0
+ * AID0		0x1
+ * AID0.XCD0	0x2
+ * AID0.XCD1	0x3
+ * AID0.XCD2	0x4
+ * AID0.XCD3	0x5
+ * MID1		0x8
+ * AID1		0x9
+ * AID1.XCD0	0xA
+ * AID1.XCD1	0xB
+ * AID1.XCD2	0xC
+ * AID1.XCD3	0xD
+ */
 static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
@@ -128,7 +145,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 
 	if (entry->client_id == SOC_V1_0_IH_CLIENTID_VMC) {
 		hub_name = "mmhub0";
-		vmhub = AMDGPU_MMHUB0(node_id / 4);
+		vmhub = AMDGPU_MMHUB0(node_id / 8);
 	} else {
 		hub_name = "gfxhub0";
 		if (adev->gfx.funcs->ih_node_to_logical_xcc) {
@@ -237,6 +254,11 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
 
+	if (!hub->vmhub_funcs || !hub->vmhub_funcs->print_l2_protection_fault_status) {
+		dev_warn_once(adev->dev, "vmhub %d print fault status func not defined\n", vmhub);
+		return 0;
+	}
+
 	hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 
 	return 0;
-- 
2.55.0

