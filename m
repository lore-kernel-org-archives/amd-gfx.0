Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28773C982D1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C64C10ECA6;
	Wed, 16 Sep 2026 17:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHhXISup";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDE910E973
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILaIuSyQ6LH7GL+ohMZyLpUQtF/+qmlggbtV+Mt+ih48YDptZLfAeJjuuNtJQIdTIAmjmsAflIYXZ52SNwc5bhoBTpVWNGY1fNaoFOpcSumZEoMxOgZsVjLSUvXPivZIYedpE0ECC9oj61p387szi96OrqELkPLwFCA2G4zYglrzGcwRL9ZCVMtWZM1E/IIR09t8ogIL5Jsf6sDmcZOZrcV9Ag9Z1F9NBD8f+WT66PhKPYM2RaJ4dNmJynrJ6KEx+46SN7uqu8cZ2Ci61v3aXROb4XyEmGwYvvUcC0LfOtVeQpBoGDnoXVtOT5jK2CeSlNjuOcbPOe1ZkBwRYhJKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPpuak8Vf/Bvug3TzqmzTJZEGH/ODIhiTrvjiwj5oP8=;
 b=UuZX/rhu8b/X38GQ7MuaDbureigYYqdQ9M5cRy5+MIm4QDegL9IayrcU8aHHZNCh8W0kh1IXp7/keI5WZC+VHAckI8a8wmGPyjPWub7Mt6NXFOGQAi2faVNWmxYOrH0fD8qKhxKq46FKb692kZ1Gg0DTyPO1TmouUwXx21djeuO+lVY1T9EfVQAeyTpxfn/5eASCVYsoY8+2hrHxYLaPlIdHhMkxbxtwPXWAAJwhc6EQNwYLD+lRQ0kI/770iC8JiZpdkyjacYXMVvz0CRDTZ3hRYR+UakpbfD3eUV4MbUhON6XaOGtAVm5MBjSUvXE07kDiP62MD5dH6/5uz/1mdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPpuak8Vf/Bvug3TzqmzTJZEGH/ODIhiTrvjiwj5oP8=;
 b=CHhXISupBf0KgS8lNL40TlSEQaWwF4r3+syRgteny35DESbiNbJgtpY8MDBpkFnKh8nlLklCJE1tr/GteAePCmz+2kGH4JZ0YvNoSPqojyJFz4/j2O7pwoqj197Cm8RHbsw8jX2mFiOevDVPlK1KGrl9l4Rx5aHYWhSleSVx/yo=
Received: from CH2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:610:4c::14)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:43 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::9e) by CH2PR10CA0004.outlook.office365.com
 (2603:10b6:610:4c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:42 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:32 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 24/64] drm/amd/display: Add inst field to struct pg_cntl
Date: Wed, 16 Sep 2026 13:51:39 -0400
Message-ID: <20260916175301.368306-25-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8237ac9d-085a-4b87-9fcf-08df141b4e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /pqV4aP9m+GXksNeSSY6ZGvmBu+w/cDFKifKBS3F+hxADBVMMQCXj8EcgzHxO84ZNjLU76MivnmMbV6ApG4JePBI1wjl7L36TlwrdkJzTf7zwul3PXnw8aZ/EaasdvTt4THJSQk7HfOnZTy+cy+5elYuwNiMfMAiyp8wKh1GZfahrlnJLn36sXwHsoOkNN9jkKc2Ys60fjfJy0kaEkHodeIEs33oJ6zTZK+KysBIMJe+gWZNaf1u1f1ulyviAVT9iG2X+KDEfzgJf4/c7yPcn2jxlQvSj2uKZ3ZeVJJNMj4QcLLeb17NjM0Kc1VMvylGlRYK6P7BHCEW5iHPM6siRleOUqZ2RIe1rFweKrK7+37oT+ctrKyG+XqF4nC48yTSX/VApOsM/m8GiGXpbrwox6ISXSeu8vAD2GqD/dorgWnJshC08dXSiQUVcA5rKMej91yyDnc4ahthLUlt/n8xyHvcuyqkYFvWUiJkL6B4lQwLh+7GwM+RAfS5AFho6s6n61dQx8NWaMcZ93RAxWhTfY/wLItO46OX/Laor4HB4/57DYN+a2tTKMcB0r6gic6/exsb/K7UVM/4o88VtPq7Pynr6Liv0SiDuSZkQhNGqnT6IQI4SlkKBpnMuAOdDkWLDJhOMffPYsLZYnUePeuyvLyqYvPfQCBk3LyH01ZBjKnVFnDQ4KSgCm1YXBAkmS0e8CB692bbuatl1OXbyM+0xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cM2Qas0heu+Q7YmQ78dVm0E9vPyZDrEJUq8rGC/vuUNdG0MJ5MbTch8AJIjlt4gs2zRT5qzPQ6yGakZE4yIPCfP4p7TW9eXeTjAfOGxFvrsfXTqhDBWAxQqVSV0hKI/l0ROkBg/ftEIJdmDlmgLIlqvsuNn2fiGniFDSPmS5hFm7/MZtLO7fWxt7ChaXOb6atEhvFyvouvVEM/IqRg0yEhQAJ/tx+xk0PSF1QDHGd9ptiqX36YT5RP9jnXAtA9pklnJQhCD7z9x1rvZib+h4a+gscLbguknpbVOIg6aJXxse7t7th1rOBRTuZwDmQUPDnQe40Da1+wC+4aubn12hqqjwMbh2M2g+JU7kmtOv/PdWpISTNGynHAVZd40M/GZQuLGJ5o0TDCEWBTLfusmE/IPed4Y2evIQON+23XT3LTYhxl7qR/EUHI2oI7inIf5X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:42.0842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8237ac9d-085a-4b87-9fcf-08df141b4e5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct pg_cntl and set it to 0 in
pg_cntl35_create() and pg_cntl42_create(), since PG cntl is a singleton.

No functional change; the field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h         | 1 +
 drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c | 1 +
 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
index 227e3f8d7e5f..3e5140993935 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
@@ -34,6 +34,7 @@ struct pg_cntl {
 	const struct pg_cntl_funcs *funcs;
 	bool pg_pipe_res_enable[PG_HW_PIPE_RESOURCES_NUM_ELEMENT][MAX_PIPES];
 	bool pg_res_enable[PG_HW_RESOURCES_NUM_ELEMENT];
+	unsigned int inst;
 };
 
 struct pg_cntl_funcs {
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
index 1d0181534a67..6e5ea1bbca02 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
@@ -553,6 +553,7 @@ struct pg_cntl *pg_cntl35_create(
 	base = &pg_cntl_dcn->base;
 	base->ctx = ctx;
 	base->funcs = &pg_cntl35_funcs;
+	base->inst = 0;
 
 	pg_cntl_dcn->regs = regs;
 	pg_cntl_dcn->pg_cntl_shift = pg_cntl_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 3a0e09ab0d9f..ef389687af03 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -630,6 +630,7 @@ struct pg_cntl *pg_cntl42_create(
 	base = &pg_cntl_dcn->base;
 	base->ctx = ctx;
 	base->funcs = &pg_cntl42_funcs;
+	base->inst = 0;
 
 	pg_cntl_dcn->regs = regs;
 	pg_cntl_dcn->pg_cntl_shift = pg_cntl_shift;
-- 
2.55.0

