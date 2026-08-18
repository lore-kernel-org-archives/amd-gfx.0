Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F007FC5DF85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8707210EC92;
	Tue, 18 Aug 2026 20:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6Ipiyda";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C42C10EC8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqmHEQOeMjBT33O22evzLPRw9agT1u07cqnlRbsg3R+trgRAbE6nUXN6PblYDIuhVMti7tMOxqZBDnaBIPc5q8j2fMMHH7X+uPNyVRRaT6E6sIxMBjOLHeCj5vehcVlIwzcA5S2qmdqCW2ZzDwPwxmnuOPHshgcdSI5Z+uc/OfwzlwZTv1AkeYdTl3P0Ei8TdTILuPdOdwx32w14S7MvS1XJu6LhGmTbGM15BbvpGBGEH6FpgqaVz1epIPK/C7dHYQa+7tmKEwTZdliLfsGpa9PVjMU3BqB6O/Pe9NBMP5GEpD/bcpYGwSUZx1tXGELgd20dkQKwL3Vb9EDdt2Y94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erZOncqsm2q2JPzEUQO/h9NRFY4ij+YZ3WzZFc033KI=;
 b=WXjzV5NUI8y/KbRYcYKKin4R1pnNWrCZeuPja8VGrjQlZ85zToWPgkfLKMBkNjYYJcKHb3bZOV5l5wk90RiAhS5c9m5yD6y12nmloTL1y/uUTGWIJI1wsHliAfXgcHM+bi8c8QX5BIdEtK5YRb+h5WN7iuTQsrqSiew0DvZpANsszajqxYHFC1L0m/PYSPnwCBijnDmcIGO9Ri0c6dH9StTutkgGvoFcF40HXZMvqmaNgy8bY46+B8RqhWJObd6SzGAyeGAbzUEbzX6eZoYzKhXXD0g5oFXkIhF6l020HiuWu4PjEB1G24tscFzRKGioEFuxgs76t0WaTndeQzENsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erZOncqsm2q2JPzEUQO/h9NRFY4ij+YZ3WzZFc033KI=;
 b=J6IpiydammXnLFPggMW8MSivSysXulehSFKMks6VRLv+sZup4oXfbE1B5bq+H7UpgV3euK81uOfr+fHutDep49+XnJ+qVEVFD5PlSj3ybNRfXYW6A8AQFwxrIo68CO/2awH5zycjhyRoTW4eM2aX5weozMrBB2wMUZy5v0RiiW0=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:12 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::35) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:03 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:03 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Dillon Varone
 <Dillon.Varone@amd.com>
Subject: [PATCH 14/82] drm/amd/display: Clear HUBPREQ_DEBUG_DB on DCN6
Date: Tue, 18 Aug 2026 16:15:06 -0400
Message-ID: <20260818202139.4172592-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 773a460f-8388-44f9-d908-08defd6662f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10086099003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ErG4a/gHAAub2hyKg/dgYGQh9SIJhanFDVBO3bENY82UmKIzAZWlIdVo/QeCaQ9ZC1jDCG6S1F53/toojhDCx0DdzrJOZF55zGLbb5E6nFeCjKkpk9VsV5Sl2erb5nPB92s7Mk03QVBHRS3VReB+hZcTKVaitDVAMcLEy+9ouIV/5E/zWzXOFdO1IKjM0tuDg9oEkcgW3bGe7zE3VtmUfgRvn7BUcsK4dGoGjDxjaFAuy28AJdt07PDMJFvfWmmq1UQeiiDwDLTmc3SBe8Ei9ePNa7f320wKXDgw51uaRpqCZsn2VyJBLokksrG/Ioyel1WAXDplfqDgobUFZxWZeIbGfwM8o3U1/JfYRHmrV8zcyjRQjGhI/4reTWiEJuf8lrXJw+12KvgIcji9K91oTQjiLubLvCMygqZKHiCcJdCbWUpPUBctTlj2ywlCaLSDnCz9LVfjyQBj9ccf6TOsISEsdZSAZV6siEUwru4NqsGHmmkwBr34k8/MbzxMfrKavLCZygHWrOvBTtlq58AiBkmWipYy6U2wscrgZLWTyfeY2DKwjwu6K6SuPimJ09UpVpeUW/Ltq7O6hM/ANcexqO6jmH8A37Oo1yaeX1qYZYDRzpN4h8YmsmuSwE9qATzBLJDOTkXpv1d051H9NsutPagjtbWbMNRGqXLWWfrsnm3IgijMkNFwEX4A5t1j0hRFjD5NnFXyXgB/Y9HG1TaY4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10086099003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DPU/C8xfUEMyEmtZ8PAS7YX4QvQT6XaWjsxgDfIkpcLwiPSbSNqkm+P/2AttfHclKyFi216Uk7oXFqFhiT/V3Ytlx1h9W3wjsNmeFvuo544nmiXC4QZ7MqiZVH+DH1mEOntws2XY6ibzSqnN8xulaDXl52Sv7WSNc7SBfImeI8LHjYk/ITeREfbKB6M22smGDt9M2fmq3Y9bdcn99Tu+Hewniov3IsWqIP/KEFF1+2zNvBkRdWqrYhVWQSYN4VdPXI6RwkOcYR/mwA9Jfu/VI5TJSZ0lRxbO2PQTl+03leKM67LKRmPm3uf04LY2pdmPCpX5a5B/KMHUDlCzxkzger6yezl7lqI5A7sl3I0jGzikiOt8VZQV/M1eC9C3XuCd5PuCIMUu9dbtAmUhtMUVrMposlpN6jiuy9GPVQqVPu+dMTTfO4gO/dpJNWgDKY/g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:12.1464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773a460f-8388-44f9-d908-08defd6662f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Make sure the HUBPREQ_DEBUG_DB register is cleared to prevent underflow
in some instances.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
index d22fe26aae623..01b6b3ed5a998 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
@@ -25,6 +25,9 @@ static void hubp60_program_deadline(
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	/* Make sure DLG test mode is disabled */
+	REG_WRITE(HUBPREQ_DEBUG_DB, 0);
+
 	/* DLG - Per hubp */
 	REG_SET_2(BLANK_OFFSET_0, 0,
 		REFCYC_H_BLANK_END, dlg_attr->refcyc_h_blank_end,
-- 
2.43.0

