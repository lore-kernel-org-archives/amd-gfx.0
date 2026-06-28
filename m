Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E4C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2026 05:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D2C10E57B;
	Sun, 28 Jun 2026 05:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OS7/BtwI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B4710E57B
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2026 05:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBbYPHRUtlcYAd+ymrBC6XPItKvGDOhtEcmq1a2GFh1IGaz+kGE8pF60V1XcUHtzeqx721Qrk8Z/xirRuXSgKJ9EqR4qgoGnHsGgOH+ZHWrj8i4Zv+xwRAXjLG3fpJbst4dpQbCQwbSBqgyPGHY0rUmbdz6a3tquZ8ta48klvt7XuKPas6PpWGV/U2t42lwegJsOw0n4c9YnQvPxxnGMX+Autmi6LcwmBrjwgF22S/NLdq3M9xDmwdKGG0Jbk5m4W+FoHP3ShUfLsTe3eBpuwt/pZ5VT/xtPB8tkNooxWkanUaFMbwA0osuRuDWQcO76REu/FQEuwHn0OWuaLn6UhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3iOwMONI3Dtk6jhygUl+zRNs8NVQcaWoiRmmHlyGag=;
 b=OeLmHUfDoXk8Ajj/tU3xe9Fk8C7J8Wtf/rEcttXlB+VL5hap+XA14eufvYd1qo1LRMwaWusk+dC/pRVsysDlW7D85iT9KkuVPFNhzY2Vivg3TBee3NidcDpRo8H7zHPqvAXmK/jwQm5xF29ClTcU9rw1dyNwQMv0eWM2UXHxmRDCjFPFueTqh2THQO8YEk7vztljw6gApYs/KV37mNoJxsH4hZAmgjDQW0hbdCzMadUtKfsAyavrsf2tuu4kTBZpiGCGdZFSl1pwacf4XWh9W2BhCGqH10sQu0yRVhC2BqEfadV183+8FVO1YWmZnUT3qoyW0fMmHE3wa5QbR10stA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3iOwMONI3Dtk6jhygUl+zRNs8NVQcaWoiRmmHlyGag=;
 b=OS7/BtwIkKoVL+UcoI9m1wQnqKokk2s1r2WlKSg5s+2w0tLO8RX3GvWZkWQlfSkSLaBpRnMD5H/4bpwOHn3EN4gGFHd8zWhgmRpYBUGfMmBI1QK3FDAv1u/uB6mbc7m/AHKlhSU8GB+RWVE++EOalJJ6HNTzLyj45wyawTKHyeg=
Received: from SA0PR11CA0187.namprd11.prod.outlook.com (2603:10b6:806:1bc::12)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 05:57:17 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::94) by SA0PR11CA0187.outlook.office365.com
 (2603:10b6:806:1bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sun,
 28 Jun 2026 05:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 05:57:16 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 00:57:13 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <Amber.Lin@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Geoffrey McRae <geoffrey.mcrae@amd.com>
Subject: [PATCH] drm/amdgpu/mes: Fix hung_queue_db_array loop limit for
 multi-XCC
Date: Sun, 28 Jun 2026 15:57:01 +1000
Message-ID: <20260628055701.1561570-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5e014d-3a09-4b61-d428-08ded4da1bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +nsd19aRBg8LMu7VOd8CrA1FdxN+Cbl+XYLSf4UHcvLsu5XbxQ2Bii+KeLBrcLLsDz1OYqXTvqyhqX+URpqPBeAECe4CLfbiDUutxtPZbHnlUj5yg84DKyA4LIh7d6aSFNXM9wcP4UQfV7jVU8pxv5j3+HTPQwUdSVwF11z8oPIac5kbi4N1XlqBUBTVVyPtyAuxR9UkXM2xYADA4sxH8yB+cdK9C8u6mE/3gax8/NJJAL1DRmi5KWnRqaGXG1Poh3IpIZ3OVQGuVAHiAzY/oXy+FWRZR5ukhRlCtqZ4TxjedVVuKEmXYOnrdqB/0HEhoOWBdIF+TVtf8Kl16UAqAP6Wez+i1QS7H6OjKSZykoE7Ru1MgQnL0JE6AO3iZGeY02+F3TMCq4G+aE2vZcNjkUVfVbmoW6OdLT8Tr/ztXK5+S0pQbHUH7ZwpMBEqEVFvXZucIrO52ModdRlI8DcLobsvdm+uJdQDTk8BoYaCztrXupvCM8k9Nm3/dfEfLYKo4J79tMf4I8XS9lVrGLoUUuyyBu5vK9tMTK+AWeYK11R6FvkKTEFnOGD2rRcjgQTQV/n8k2f4JqX3YPTxQGGYaAKE3JUFXWLA2S6JBvdUokyBGNIEMU4sV0QsY/IIIydYB//2gRG/gaY3LgasxO6jV9YG/VdBp9uh/GkLcXxPkViEh5Jw7WfkzaOkvruZSz7jBdhPWf1NQcLKOFQj24MAqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EJ8GxazlE42kswFKVlL+OeDFQD509p8N0ouM2oXZ+Wf+4lzzfJL8E1Fl50zDSUfgExnMssiPOE2gL8Xwjp15QxzApKRIUy++FHkCjlNnpUrBGIje5gMFFUXV4R3BkvMu7x+I1zwhEXIBo6U++YjDa/fgO7HlupefskZXukQkm8trl0XNv0lLaOaCHqCgTGDEqSdzdQylWKFyS+sMc1XrdBMtmMoSRoTKzRvfD2zemWyq0jbnal7kvsoJtc1v/jhNth1hlZhNEjLdYP8RLvtkX6fLqAvYgMnIIKEbvpOuelpGKtXmsAhcuhtZNUXgV0PAYQHVU5q8ksW1yBX0H8adVwL2nDI3/7qYY/21bt/ucQ9Q6XHGkNn0HCN1pKZ94g0sfibR0nIkBcVVBaWybwV5VIGtbzKcPHZDaQmtTKfZ2+WsBvLl161s6YjE120xJzXW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 05:57:16.7029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5e014d-3a09-4b61-d428-08ded4da1bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
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

The loop iterated only AMDGPU_MAX_MES_PIPES times, leaving entries
uninitialized for multi-XCC GPUs. This causes null pointer dereferences
when accessing arrays indexed by XCC ID >= 2. Extend the loop to cover
all XCCs (AMDGPU_MAX_MES_PIPES * num_xcc), matching other per-XCC
arrays.

Fixes: 723b3bc87afb ("drm/amdgpu: Fixup boost mes detect hang array size")
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6c0dde3786e3..6ec4f1d537d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -237,7 +237,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mes.hung_queue_db_array_size) {
-		for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+		for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
 			r = amdgpu_bo_create_kernel(adev,
 						    adev->mes.hung_queue_db_array_size * sizeof(u32),
 						    PAGE_SIZE,
-- 
2.43.0

