Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E66CA5FAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2815010EC96;
	Tue, 29 Sep 2026 03:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FqjvIyz0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E4210EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm3MIMKh7moZa4Py4RQ6yq4XCwGweDoIiOTn0sRapIW0jYjx5tsVwqbpb4ndanjgEKbQ5829FNzvLxTRFUz0hu1kVuH45gL75vhAvHR8rQXksWgEQsuZLhzz+mg2Wc6TbiskJsniF6QKAvlzwWcWQqU5NDAM+boa8Y61sdWvsHXGKMDzhljcaUEx8soUk0XC3/vaNOJ3tLb/09mEkAnpyGAgDUvVnT+2KqAy9FrgzRIJwXheQtgMvbOGGPylBR35V/HlXzefY4MfsAGCE9U3F3gOmMOK7H9qKQayARcje6DlPY+c/dbnFTmWvAoRDILM1cRYp8v8BZy5C1QIDMmvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en8FDE0NGvp55FJYj9h0bxFE+rpvg5wgKwlfC98nDUo=;
 b=mC4iKxWCgwqP79TwkYsuf6OyuOlTzG4WEU4zG5Mhs0hdbDViPEnh0RRhcWT3ITNmE9vlM9ArNztEb837T/jhEYyAdjzwLgpXAVKeWDg4zJZWYP/ag6uMv7M6UepE3f/zXG1DOhoB72tiY7C4ivZLC4CaRgjsuac7oH25PCTXJ7qLdNqbOkP8pmDx/qLwNz7p2WzRVwYyFIgWGcsduABzyNUsCOEwcTiPKCnUPyVIxT79eKrGZGoxzfomNq+uCmHEKQi15pDo4ps0BTTGlBq3iWnAqLyZ9bxzyjESB4etfV2hD398i0M6GMXbY2ppt2zwdmnqLTioBoiykZA7z0gncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en8FDE0NGvp55FJYj9h0bxFE+rpvg5wgKwlfC98nDUo=;
 b=FqjvIyz0c7+ndRDpJLlQknDXPSN0aHrkGj/n8mgG3kE++zKuYG7/bIdUCa3scPJcGvCzJiMVRkpZag228ejqsVJFARmccdC3LBMcSyFKSafiG/C+uvsSN7F7Nn8rOyhtCU91xbnYJduBC2ay65r5wyzLC+d1EMmyCSVLSDdRGLU=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:14 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::51) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Tue,
 29 Sep 2026 03:47:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:07 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 06/14] drm/amdgpu/mes: move RS64 query buffer setup to
 software init
Date: Tue, 29 Sep 2026 11:46:42 +0800
Message-ID: <20260929034650.2393125-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db293b1-572d-449f-5311-08df1ddc598e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zr90GCRebZLssIyGWB5U14ke7eT9T7HKbnyf84z75N3jEPt/ByPsS4iMXyMGD7yZMOu9Ys1N5OY+GvIGbIoIWeTPnxDCcDYH9aJfUYCcKXPSQaYr/62xVuidNabHXnJc8TxX7Bua6aCZTz0YY/nT7snokdld86+vfuF6aD7RXDD4veoQEjIOj6GYzq1dI9yzbiLBNk1Xd7r2PTAFo+YHFCGj3WVE85rCPT3ObyWAtNYc2JxGTCn9wNcRcvwHzpZK7k/I82mX4lPzIP/57DIrSc4vzG+FDA82uBSNcuZW0230DmEZrFoZIc4d7t74ii1USlPGpyIhNm/JGW/2Qqb7ZUrgMLGWKiDwWnQfNlMU/AvQdhhmpD4YvUdaL2f9yc2IlL2BoxRA/q7lcNqADKX7oxXn/CRLCXiM/H9dlF7zHhK5HfT0I/JhvRdwx5t/Wb+vSrDdowkfnqzdCdJ3sPWUg8D8v8j3i0No5hjM+0ANiXFyBRoWxfkKVqc9T+UimlTsBAPv60Zevc6P+xND425b8wijXnLSyXotvzGMsV9QcL3l78LBPZbPuhYzTjDmVDS1yz2onGv9rfkJ2UHtE0bFOZz6hfxBPeQLcFS4Rr4KAjp5eI5UAtY2tfK2tKFZOjCOht7p76lie6nkre86ruZ5dC02ykAYLEyow9vdXtUIi6HBR2JCjYy+pVGBog8mBmmxFr4JLBzyDXXUAf8WEzs3mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJB+HUHinm/K2rrOOhrss5yml66w4CAF7IGO7CU5z+oZPlA9OzmYX5ZUNU0sIAV8ZKIKpONLAVq9Ky+lw+KHZWtCtOKCMqZWVsKDUUJag7NJSCDTVAv8N2yPTsYy5tenL7BTMKTWatJuOFaJ1kmJFqcJyGArLQynPrZWCqcdcQUzmRWPbXsTmRaRRxqYECpYDH/ZOz/a05kIFl+k2KzCdC+uNAiuVGx9VzBtksvptqDesN9+AB+b2hkmytGn4DSH+eo52kT6w7VRieDyfTVo8CE/QEeJHpKGS/qtcWVoY/Vb/AYsfDDM/0abUANL6Ms9l1CPCi0rVmOQdePSqiC80Doko7nt+H3mSHVr19yufW1jyK4zIUtWwz0JSjO+z4iGY/5MElnJPs6mmBgYwA09PvZHhhCR0c3E4kRss4Yi9RkXyuBxiP238koG+8nzX8hC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:14.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db293b1-572d-449f-5311-08df1ddc598e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
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

Place the RS64 context-size query buffer's allocation with software
initialization, outside reset-time hardware initialization and its
firmware locks. Hardware initialization only consumes the buffer.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 51bfb672bed7..2f62214ab24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1746,6 +1746,7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r, bo_size;
 
+	adev->mes.use_rs64mem = false;
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
@@ -1796,6 +1797,14 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
+	/* Allocate GPU buffer for array size query results */
+	r = amdgpu_mes_rs64mem_init(&adev->mes);
+	if (r) {
+		dev_warn(adev->dev,
+			 "RS64 memory init failed (%d), using system memory\n", r);
+		adev->mes.use_rs64mem = false;
+	}
+
 	return 0;
 }
 
@@ -1973,8 +1982,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->mes.ring[0].sched.ready)
 		goto out;
 
-	adev->mes.use_rs64mem = false;
-
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v11_0_load_microcode(adev,
@@ -1992,14 +1999,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	/* Allocate GPU buffer for array size query results */
-	r = amdgpu_mes_rs64mem_init(&adev->mes);
-	if (r) {
-		dev_warn(adev->dev,
-			 "RS64 local memory init failed (%d),"
-			 "falling back to system memory path\n", r);
-		adev->mes.use_rs64mem = false;
-	}
 	r = mes_v11_0_set_hw_resources(&adev->mes);
 
 	if (r)
-- 
2.34.1

