Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECDFC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611E710E33D;
	Fri, 21 Aug 2026 19:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKPHiGil";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D78310E33D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqFbBPQoQaWwRPQ3s5eX9TDTzZ4Z01UzyFhz/CjFxd46F+/RdmHvdjXHJL8aUpzwkWMId6DZa1a0ctAmR2qunKVXg5RFTd82FqE1F+szEhov/dNq2xCMNgQt5TgYnvyWVXc9lEQaDfYoFuSo8EW4nbl/pqwflaX32MtvsadF6NvyJKXTJJm/W+ec3ojqYLCqq/lC+Xx3VKBbKfse55DpSTb6rp8j2JTGO4H5wGD//6Xt2UkAGwHxpPWOuvxawSG5rJzHbiwE1R7KmoxCqx/C/SeuhmVP30VWLx/586RehZcvk+yIxQe7fPwDgW5vrKk2ilWym6f+YtfnCXRyXDiNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2/cKzNkeYvMDTlsYg6tPi3iXwd3nlkpOs2NUHhid2s=;
 b=wuasBh2V5KqIjQaOpubcgTQDzHPfzxdfca1kRc1bE3kklst8jftkyv3ssKy32HRlg9RezvhKn7pLvZzU3ZVReGnxIA2r1XfgdY15l2mGyYq7w8ygqZCGAIJh3wXZympV+8iwnDof3RRErglFJJPvyQkCzT13mW5wEskgYyYK1AvS5wgwHuYA4MA3KIW04ZaQoG+1VgPPiyfkzhR3M3ZXTinE+wtIrjWZgt3pReiCvAC+n2uspJUQ53U+6sWCQFQim14W5Mky0spkSd/LpkUnE9yG7mPiEA1kEqwKlP5QtKMN/jbWRHFFZ2ReJnXr/PG2YSNpEakm89NzH0g4inIq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2/cKzNkeYvMDTlsYg6tPi3iXwd3nlkpOs2NUHhid2s=;
 b=GKPHiGil/WVzyybp2mkVvnH06CDlwuzqNrqp3Li0bPtAR2O1bW8N9/W1biKlRdxpIPO1t69UawlXtWA6o2mtyoSjOeo8SBZGQcb78xXRJmV09BuoZfer6fqHJmjGFHWA6OUWxjnsnwKWqrVpdxRsRvzz7ZFA2hwwUm5AU6QGMII=
Received: from CH2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:610:57::37)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:00 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::aa) by CH2PR12CA0027.outlook.office365.com
 (2603:10b6:610:57::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 66/95] drm/amdgpu: Fix initialization flags for UALink XAs
Date: Fri, 21 Aug 2026 15:34:29 -0400
Message-ID: <20260821193458.808626-67-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b1de0a-87c8-48da-97bb-08deffbb6d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: XTkM7lJ89IW/UNUD17MIhNfHiT/rMWC8WpgtocwkhDTiwQQs/kFCVlwqQ0qEEr35qwcqF8N6EhtNdyO+dsAotJFml9oqH4EXEj0Q2pMhW22BWxls6w8ABiE0UwEhJiHstNiakw1lsMSlC+MSIG8Hm2DWnoTJ/oeuDhEYig8V3AnnuG3j31/GykeTDG1fJQ9iHgCI5gMb/Hq9h6U+Rcv9btBbo5CQzCmJxK647mnychXngQDswlGDH+Mgz4dR/cfU/sR2C+eBF+dyjd7ceKlFdD15bKSj7XJdeRZx92GjSkBVFe0jyDyEbzIc3M/uuH+GrlQPavKqVw18QxDwENk2lXhb87YxrATcNwCLD7rl2Xvb6GO5LlT0iM1vbHQ+11xITb3tpHA9vKP9VLQVVNU8dgxw5hisn0xStsVbPux39eYQQlB/FqwVnUBe7HDrLPOe4Kp1m9tYthOd0YDyB+S2ZLDvX4Za+wqkvpfPdbbIVqrzWtxDPEz4R5p84Id5RV3rk1JCb6IBWOk9XGY74QUHYlWFwTLumFUaZzP5DscN2ucP4Gp0yoeC9TqFO8H0U9JJh1LLK6lkv9kPs0g3+wTEKAKsjI4bt7aWWFkHTUzIx8U1T5dwBzHTFcC3YBrWV2fJcpTbXfM4FGVEp+fLKN3joaU5nwn502ZMu00XmRtu/PNS2KVMW0jFQ3gtEGpdvNGDLqfOvbTdLyHd1oPY24g04Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: THQg/sy65dWHuEojugBJJ+Rl0pY7xCG5lsRWG5uNQwo6ZrSItGLewBqkH3ITu2pExlAZD+5EYro6G+20qinZ8BdEMTUBvP3ZKbSjzMeDcYjNY8tbAGJ4VpPMHeMNQfpq28An53/Vqm9MxhPBOWEMeA7Dn4MYCNzT/lziCSvJAKzYiIZWui8i8s5wcAXn3io2Vp3KDGrPBQaQTKYZXKBjxMnLZpVG6PTBZPCgP2jHCOcwo06jRQ9yEkDyp93C1A9x8NMNTt2miVYj3x2GJQpfTMuFSKcKhk4aED9T0eHldPLB/0+OVEV5xWCZ6hFGuv5T8mQtCrShNv0tJSBY9jn9HRib5HcUvOdn5VsCRA654no2qNC5fLnst7MXWo90PMayzmjZiyU/WR1epMSvYG7ymHfo3fu3wGe1xI3/mb00LBDGP0meZZeJU93wIEBQH+yj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:58.6252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b1de0a-87c8-48da-97bb-08deffbb6d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
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

From: Mukul Joshi <mukul.joshi@amd.com>

The UALink exp_xa, imp_xa and handle_invalid_xa xarrays are only ever
accessed from process context: ioctls or workqueues. None of them run
in softirq or hardirq context, so initializing the Xarray with BH flag
is unnecessary.

Drop XA_FLAGS_LOCK_BH and use the default plain-spinlock locking
(xa_init() and the plain xa_* accessors).

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index b374cb6b05352..66ae6a0f1c53b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3400,9 +3400,9 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
 			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
 
-	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
-	xa_init_flags(&adev->ualink.imp_xa, XA_FLAGS_LOCK_BH);
-	xa_init_flags(&adev->ualink.handle_invalid_xa, XA_FLAGS_LOCK_BH);
+	xa_init(&adev->ualink.exp_xa);
+	xa_init(&adev->ualink.imp_xa);
+	xa_init(&adev->ualink.handle_invalid_xa);
 
 	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
 		init_completion(&adev->ualink.conn_state[i].hello_done);
-- 
2.55.0

