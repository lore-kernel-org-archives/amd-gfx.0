Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF10C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C4710E282;
	Fri, 28 Aug 2026 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vW2tg69u";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A1A10E282
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRSJ3S6NDE/fou+e9AHTw4aLJvI8TsKPukAvfLsbetZUV/7DH3sWvUEd0PcM3JkbU/EOKH8bSgJ/RIHFlK2sxIMW+2XQJVmKKSrXX7Bd/bBhyLImsliPF+eiXKRqLPkSGQmd9rQe/SebBkOJmbGtOGNe1VYswAbgMsPF0lwdxCCkCKFDLXG6efu7NCIkuLjF8+9mOUIhk9QQbYXdhd8f9fW2noJChhCUTHkSaQHoO4Hq0m5zLpN0cgQ5hACdOjM1GKXq0pvegzslMQ1m/ByU+0rD2f2l8y6r6XhFWuEhYuFghb23Fwlijs3+u+eGlBGoVCe5utgbfRBybPvNIH876A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zvcDXh9qAvhXXeoSgIWgZysfoQ4n1usNKyFZWFUlfc=;
 b=UGxJ646zOIRIf10BE/cDyd0eA6vk30Mxk8TxoQLKTeEPH+/fXLPJo7jfxKNCTNCzyJ57b0bjkgRwLOjHd4IKO1PJIOj1ZgWfFSYqciBdBg20Gqp+AlcSRqzuH2j07o34E9dPpMm+ZMg5s5/Il4ytVYwbu852voGTYqJjlrVR12aw4sv8ttkRfvHz5U+jMBo30/A9k8t24qMQu5sC5WGaIFhHBF1kzEiqIiCp/ktYfzPX2KJynthdWAsU9FOPnVrTQuErLpNje1zJnrSrlgZDvGThl/6YHXtC73es8JzDHjHKa0eKoguN07QcjS6m9urIpyRjU4ycjFYYcSPYT/9PYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zvcDXh9qAvhXXeoSgIWgZysfoQ4n1usNKyFZWFUlfc=;
 b=vW2tg69uMxOULOE/uIw4ZdO0+oap9pE7JPUpx7FuY79j6GVj9dJM6tflFZ0tUukBqsChhV48yS0hjEWqOYs/6X1XwG2NZ3aA8a5Z7ngPKFVzGL6GjdbKkOJ/AiSB3DqmgOdtIhQ1o91LX0gcBrjzHiy/ElfBcrYBAh4dvTU4rdQ=
Received: from DS1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::15) by
 IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 09:53:47 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::6e) by DS1P221CA0028.outlook.office365.com
 (2603:10b6:8:242::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:46 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:43 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 03/10] drm/amdgpu/gfx11: hold userq refs in private fault
 worker
Date: Fri, 28 Aug 2026 17:53:42 +0800
Message-ID: <20260828095349.9797-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e2e4c9-d93e-4084-927d-08df04ea4097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xh0FnZ7UHpN5I2xZ8OLAx3ovS2Xb/JcyMHjLSqCTjUmcKEeZtIVRBl8eFBEl8scclwkWn10lz4d8Q0vTj74769DSLNxD7t0hBIp05ypB5uN1o1mRnCZNYXX/pL9TILDylGKgFd7JSnGWjdW7ORFO7O3ftlnvIeaG92ZuXkAdRM52rEXgiyTX5RhVOonkVYGVOVWrIFSnuEvDfh5k6LHPMnWeGQHauOrZat1EB+xI1w00Ev0EmcNlwiWoLcEwxAMsXxVWZxu11MG5Kfxyis+2HODvQ1wi8rQOElx4Bswmfzm4qgjFKlB73K5074QIiwNTDVEsAlZJdznDK4jlq0cYgPQJ/SYfutkSZHdovkazUy74GxoKa3WDx4ZU42k/ujnAOuH/SgahQQcSxj3+J+qKUEIFBGkF0UIan9laiIdL+gBGcfqaTCph4HkynrUsBIYvYw/wN/fw3e4XIZoDQB6L0rYQ/rOtjpIPLCezx5H57JVzGC8bdPmGlAmWCX0y0+S1cNUR6LipDwZDMclThkSIjezeWT4yV3/xIJ4g0hswx1cEmP1f64048WTRI2OFVod+zWeqIKiDsXsOIbqQMHkzb0DKDyqU1TCJ6bGUzHL4mpnvosatCRziFVC/wFvI4RBCmJOaJbf4mRHURZJHHpOXoDbeI9MrtHoFIm+3mggkr8IpTFV9PNilyGT8mDpX3uhQxNTvuxDWX8h/vAyjK3iABA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oMrioLuzVOpfTWbqTWpkrNwTPFq+wcXvk+Ij4nin4wqg9Z4vr+iGoI0jznyHE6t7cgJScNDsLxKLy74Bqht3Sstt5FmPMkS9nDrdFTukv7yPqEKbV/84Dl4tcby7OE394o3HTIegk6Y1jmuzch/j+8x7Si4U3MxGkbXNlF6yZGeWtXyC7Fnr0sDmdeOpRM6aBWEhcBI8YR61YyjlTCTH97rdZp2Ds1f/Xc5oIli56u+zih5Q23uCJc04+QalPejJL5dEDwG/dklciaQLOTMOUrxsnmNiNe4pDRKTVSIxwPHX+0b+Fq0e8smWkTi0mv4BsCQlNDQbavrs5wvOKrWnGWesMoZSWptU9C/0C2i9ULKbcivt2fQFeE/c+bOMzYiFlKR87ciZ1ZW7bKiz0RFhfum+Pv0czsJysC1K7z6z5CtwcMstwhGNSZWI8ZiIxd5+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:46.1693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e2e4c9-d93e-4084-927d-08df04ea4097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
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

The GFX11 user queue private fault woker loads
the relevnt user queue from the userq doorbell xarray.
However it does not hold the spin_lock of the xarray
when walking the xarray, and does not increase the
kref of the user queue, so it races with queue
destruction path and may run into an use-after-free
userq problem.

This commit fixes this UAF problem by utilizing
amdgpu_lookup_queue_by_doorbell helper, which
properly hoding the xarray spin lock and the kref
of the user queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..a063f86a8847 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6733,9 +6733,12 @@ static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
 
 		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
 			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
-		q = xa_load(&adev->userq_doorbell_xa, doorbell);
-		if (q)
+		q = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa,
+						    doorbell);
+		if (q) {
 			amdgpu_userq_start_hang_detect_work(q);
+			amdgpu_userq_put(q);
+		}
 	}
 }
 
-- 
2.53.0

