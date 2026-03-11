Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F28FD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A863C10E301;
	Wed, 11 Mar 2026 04:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iyPCV3h+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4306310E2FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHeE0k6VcNpq4upGikK9GQZzERKSdOlnEr7B5q3qReOnfV50s4WYeSyBbV+Mvr9TM6nDbLXsG+hZr9WxtwERtFQcCFrs3yLugHvBr16boJLZyenjTvHKICNScKLuzMT0c/KACe7zPygGsM6/p6pYhb7c5g0pV2Qol2WF5w9ZMIZyYpaldXSZEzpi6Koy5B+i2gO30s7LA71jSJLtkE210KF6VYpIRbV2sMKqIbVKZfXXylcxFGI68FF/v26WmWl14D4iuREwRmMwsfy1f/F2JkP2jpm5P72uckeYME0SHfUQ1G+iged4MftZgceCewKIhSKnJSE9kHsnNF5lxmDXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4pBmo+0/O8hARpOTPFj//fRqMQqltrWLjlfMrKNIOo=;
 b=YirevHSYEVaycZRBvmIVC7rYH+1IzkNkMvPpQcCfpYVp1DrJn4RVO1sZZpwyofXPROo0XzfIuAaZDeeZyTzA1LT2lI6bH62YAVeXRGm1xwLkRj//X6r+E8sIgfv1tc8XPCoVAjhF5v2hmP0kaeHe8MnYUHyEoeG4mjLH4SznWT2BjvsmYWna+WZYD3jVgCFvu0f6vNGZ/4Mu4tznR2rcfAst7dF2laActN11IFY+QhVps1D/NlalUfg/Hxid6/VIzuq5T+YXr+ydyNCalmNaKE7mWT0eNDEqP++olyM1/3BTmd21tJIztmV3CK8vk0+z1V37Bq14nX/CaAod/K81vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4pBmo+0/O8hARpOTPFj//fRqMQqltrWLjlfMrKNIOo=;
 b=iyPCV3h+qnkthUkvettdSI+k3DFJQPIUdOI9FoWctqyaaxokJWCQwIszVIRra5owOfyAwtQLtsbbfWeLyVaajP6FXqEt6lS4PNTMtudSktCLFhfb5RkNReStexROftiI6Xf6CXeYe4+FmUa/LLD0cjrHvYCzHTBSi14cSB0aYTc=
Received: from PH0PR07CA0107.namprd07.prod.outlook.com (2603:10b6:510:4::22)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:03:51 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::ca) by PH0PR07CA0107.outlook.office365.com
 (2603:10b6:510:4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:50 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:47 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 4/9] drm/amd/display: Plumb MRQ programming out of DML for
 dml2_1
Date: Wed, 11 Mar 2026 11:32:59 +0800
Message-ID: <20260311040501.2693643-5-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4020a8f5-1f3f-4174-22e5-08de7f233439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ELm6eTjs5RNZNx1VUin1P7L0x2iriZUI9TzxT5GpiJJjNYFm2D6/gt9JtD6AusV8kVyG/dJmY6VAZjJlNeOYunECq8hFZhzEmOX5eSZJnCgUbj+Lc3fhqDwJ4mhIPMOMreBab7FYBATIbQGAQ0ZTzhT3+7YLUsvKFX2jB74LAyghZPAPuMIqoJW9v19j16Huv5v+7eUnUSmivkB79/1AMR26QP6wWbVuvbPA22Wh5WD1bmXBi4IZgrRXkvF0ZGSX42AzFWYjU2vSp+MkzFAti86chhuHLHQs/KNX2/92th7XaWutBKKR/UOXML3d3G5MyvwzBUQnJCsPpcpmIeXJR1ib9aI1GZbr8Aq6MHS769OZ0YKeUS9Bm6qxoC9v7n9ma4VAYCRD+JpsMkdbLMI14thrLT0F1wYnJzUZ9UKSZVEVeZTcu1mQzvFiEudighCfAbRFom0T1HJNChojkrTQdLqjWEgLcxZ2lYeigCBJx/9i1ffA1AOU7BHYkJAXOt3eeTfeSZ1/rQWjMsW3gPmmnLj+el7DN1PoapPWuh0opD7emDEfgfBC9LRS6qcJ0PK1wjQmBbJZVYD2WAEpEIHIFb8uOTri8/ZYdF2mQhGOUng2dd8Ueb6ryNqFe8qjZOGxDuVbBcLwX+9kx4MQuFHWtlmJESih2v0gVO1+JldaCqyT+jrXB3unpkqfB9m+feRc7T3XcbgRPAcj9gW+gjZx3iCJNbqi2K4ipP7pOo+Pre001iYzqpAvHz7+l77XTMTkZgV/Cgrb5hvTjPKGc88f7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dr0c/0Bs0VmOsR90NOVxEuHifI+n2qHYlKib+Bmh3vtYbgvoJjClBp2dr+Xp4+eWOQylr9+mMR7XgTC8ITK/ZDypsTXCpEUOeGzbE4eBLDnC8RmmO6MfvToBwFewMKhJ0sgxbgnf4ZGM+OclvQRUls30vf/DRzJWo5vKppzdbh5+MnyDFpMKCwjnX8f9qVawVd93mLpDbLH2JJmm1wqxDjMKp3fxmjzwfuFZN1G2aAyuwEXmCKoKKnerd9L5YuLHtDKHkSo/l404RFbx2tlNF3JhRgieX2E7ibh6I+o6lB05xDSH91yu7gNYk9akGAri8jHi2T4jXaqHhT89E5lJ5dhq2AoDH/I3IL/ZbjVqEkcAAQY/ubRl9jkdh76UYS1d9GSkhncEJsxhPYs/NXmnYJEjDPRmP/+6xTKFUU0D+FmByIOStU6uvo1YxXx2CbdG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:50.9333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4020a8f5-1f3f-4174-22e5-08de7f233439
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165
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

