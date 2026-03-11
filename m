Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8359EFD88DF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6110E2F0;
	Wed, 11 Mar 2026 02:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3a5oRHW";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49BD10E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjIueTn6pUQ/fcY9nN/8wT899xpmBFOMpj6jl0IlfPpMUQdpWnCWlyNi/I28TKj9s42HDkOD6kYFhW5LUjcRqsUc07I8wMNRffT53J2R5s4UQSuZvlxJcXR/6WGB0u/wC8/d+rEN14npvSppoqoeAqzuCx3STKVhZoKKQf5tdeAr7ANgNp82/N/7V40hXa/EkDuaADR1YdsYh002GYAUq5zokd4y14ogghhCOqc6z0+Qy999ZryYpRceF5a5Byg+xFObRq3GZv8dxFtRyFUDlAexZlibY2DtV3MvM7lfNd4clNYVo1i9XabN1M8eDKCxfgJHcycyZL21hfQIiTGjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4pBmo+0/O8hARpOTPFj//fRqMQqltrWLjlfMrKNIOo=;
 b=CMhPYmdyvZZiuYuEeSvqsfGYOaXQp3DTlAihoWBgsJdRmgAgUttXUyHLK4SdxBH0wJhSaH8wrwlpNYGJBIr4gr1fqRwulFXTSoBDULnvdx4BQT67DrPTdzbLdQGqANs0AOb2pBc25jEdkubgj/Ez1WJetJ8I+xRkuRHGQUtfzfyKo4zRjbOKBMR8Uo5q40l5raAuWzKJiqW4UQZ2JaNueXOhMOw0QHq3BxVNu8C1xNiQlthyY7r/FzuKM+J0U4MseLNeTbqY8Z7c/3blRHIB3Ii/S0gz/XUHe6s5r6Li0/c5sNjGCg4jo5jd0XXPYSxhYp4T+F7/EBLfYPkqGTvpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4pBmo+0/O8hARpOTPFj//fRqMQqltrWLjlfMrKNIOo=;
 b=O3a5oRHW9P2p79KVsL1bfPKBfHNClGAG9pCsiJQvQXy/WvOQ+31M2XtgbQ7UVNW0ZtRqCkp6xiwtV4/EOGnJI1wyIWrZSkm+oFOVhlURGzSGnG+pIcwp93U5NixscF017NynnocUReHho/ALcu3vTFM4KwqosYn/WV9rD5YlhCA=
Received: from BY5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:180::48)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:45:50 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::7f) by BY5PR13CA0035.outlook.office365.com
 (2603:10b6:a03:180::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Wed,
 11 Mar 2026 02:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:45:48 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:44 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 4/9] drm/amd/display: Plumb MRQ programming out of DML for
 dml2_1
Date: Wed, 11 Mar 2026 10:40:36 +0800
Message-ID: <20260311024652.2668570-5-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd2f044-c85e-4ecb-34c2-08de7f184d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mCum+dAY/gVeIKVYL9+O8sY/ocI0QsIQBoSi3qAJvoqb5MXv5CoWaxCPBUyNW9rDCtIStZhJmYinS6GFPNs9FzhVC07ekjfyKUlhpk6jI+SkG8BGoBUs0w+2bYQQRgndmE6oDyncWzCaKms8PPQBLJrbAARsA+vgC2/+YNwHMe368hfut6CVZ0HcsrR7Ya+y90oTipXOlYCgX7NTBE5OQ8mIIsAZD/3QYtwj8tXmvTgVTT7Qo/EfTLif3a42Qt1o/gP5YlGWXwjGxd7x5WSvQV7kUuDbAqTM5TDQAcw6NWUhkTmmvPipsN7iTciS+5bLMANRe6q05Ual89562LNZ2rqc+/Bf/+FkuQYb6dk5Uq2wP0ZFlcxmGXoF3SKhdDB/Rova/aLGJZveDYCiqoeE7kgd85yu+UqUpJIABtZDjVccJ2tBOIsPW9HxOcbdo7bxjEuSHdULmHBcSsMlds3hoIbgB/qv+tjlRL96PPKiDs77eZzkLt/+kkbDq+jEkOLFHbkdVP25lJGFJGTfEcMdiGYCcrxFBujliv0vr8t/uU0ORu8Xk5QsseYj7SlBQ2c84C3G6xrwcSl6hXutU8Kt7ZGUvq7+Pr/F9kLdLvg7aMkYLN6egkzm5HPJX8plXVBf0y1NiTq6eBTDbfJl/rIHwpSZF5sDehX9lfDeaZ+7Fj3qA6DHjkNBiwHlHjuZOdWTxSar7MRNvtiNp52BZUmRst9JCJdetFUMKkSEv2fFIpm4AS5jKhHyL+AWzGCWdGqJIOJtGQu0j4LVd+zZnNSLzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zqFgUtt0y2eN5NVmed/N+H7WjqytxOR0MnBXTp+Tsu67eOi1OAjnjGHDk7b+7HLP2rjZ3uFokI2IsfYhM3JrXzqaXmQJCvsAlgvHB/QF+Ha3nhJV8se4qqBquYg8qvnuFM8CndtZIVK6oX6iu7r7qGyOyyaqPBpmUbTrcYD9Ugigv30FzDFkpZSKAqc0HeiS2fim8vW7sSazhM/X3RFRpdreNh54hW/vnNt3bIGiYnzHGLiQ6tHp0JvQFo7ng4BC0Wp+ACuFN+SMSYesEioXagoIDE7u7iyBStWy3uw4qUBXf/tRQPboJuLKB5nfdIqKF0ydreelBi9QOXLVMG8d9qeMHh1Gv6j6RnjcTt48AgdfQHOJbmnWCHx/NskWE+ppO1dpl/uyDmdgJg8VRHo2J52TtuTGIVoKLRvZ+sKT3QfOcZqJartbR1QJGNkb99Un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:45:48.3512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd2f044-c85e-4ecb-34c2-08de7f184d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If the MRQ is present then these fields are also required to be
plumbed out to the requestor for programming.

[How]
Pipe the fields out through rq_dlg_get_rq_reg.

The implementation follows the previous generation in dml2_0 for DCN35
but adjusted for the new helpers and coding style of dml2_1.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ca5ac3c0deb5..b30d16474ceb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12262,11 +12262,15 @@ static void rq_dlg_get_rq_reg(struct dml2_display_rq_regs *rq_regs,
 
 	unsigned int pixel_chunk_bytes = 0;
 	unsigned int min_pixel_chunk_bytes = 0;
+	unsigned int meta_chunk_bytes = 0;
+	unsigned int min_meta_chunk_bytes = 0;
 	unsigned int dpte_group_bytes = 0;
 	unsigned int mpte_group_bytes = 0;
 
 	unsigned int p1_pixel_chunk_bytes = 0;
 	unsigned int p1_min_pixel_chunk_bytes = 0;
+	unsigned int p1_meta_chunk_bytes = 0;
+	unsigned int p1_min_meta_chunk_bytes = 0;
 	unsigned int p1_dpte_group_bytes = 0;
 	unsigned int p1_mpte_group_bytes = 0;
 
@@ -12287,8 +12291,13 @@ static void rq_dlg_get_rq_reg(struct dml2_display_rq_regs *rq_regs,
 	dpte_group_bytes = (unsigned int)(dml_get_dpte_group_size_in_bytes(mode_lib, pipe_idx));
 	mpte_group_bytes = (unsigned int)(dml_get_vm_group_size_in_bytes(mode_lib, pipe_idx));
 
+	meta_chunk_bytes =  (unsigned int)(mode_lib->ip.meta_chunk_size_kbytes * 1024);
+	min_meta_chunk_bytes = (unsigned int)(mode_lib->ip.min_meta_chunk_size_bytes);
+
 	p1_pixel_chunk_bytes = pixel_chunk_bytes;
 	p1_min_pixel_chunk_bytes = min_pixel_chunk_bytes;
+	p1_meta_chunk_bytes =  meta_chunk_bytes;
+	p1_min_meta_chunk_bytes =  min_meta_chunk_bytes;
 	p1_dpte_group_bytes = dpte_group_bytes;
 	p1_mpte_group_bytes = mpte_group_bytes;
 
@@ -12309,6 +12318,19 @@ static void rq_dlg_get_rq_reg(struct dml2_display_rq_regs *rq_regs,
 	else
 		rq_regs->rq_regs_c.min_chunk_size = log_and_substract_if_non_zero(p1_min_pixel_chunk_bytes, 8 - 1);
 
+	rq_regs->rq_regs_l.meta_chunk_size = log_and_substract_if_non_zero(meta_chunk_bytes, 10);
+	rq_regs->rq_regs_c.meta_chunk_size = log_and_substract_if_non_zero(p1_meta_chunk_bytes, 10);
+
+	if (min_meta_chunk_bytes == 0)
+		rq_regs->rq_regs_l.min_meta_chunk_size = 0;
+	else
+		rq_regs->rq_regs_l.min_meta_chunk_size = log_and_substract_if_non_zero(min_meta_chunk_bytes, 6 - 1);
+
+	if (min_meta_chunk_bytes == 0)
+		rq_regs->rq_regs_c.min_meta_chunk_size = 0;
+	else
+		rq_regs->rq_regs_c.min_meta_chunk_size = log_and_substract_if_non_zero(p1_min_meta_chunk_bytes, 6 - 1);
+
 	rq_regs->rq_regs_l.dpte_group_size = log_and_substract_if_non_zero(dpte_group_bytes, 6);
 	rq_regs->rq_regs_l.mpte_group_size = log_and_substract_if_non_zero(mpte_group_bytes, 6);
 	rq_regs->rq_regs_c.dpte_group_size = log_and_substract_if_non_zero(p1_dpte_group_bytes, 6);
-- 
2.43.0

