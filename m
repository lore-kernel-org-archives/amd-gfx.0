Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ABEC4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D6010F0A1;
	Wed, 15 Jul 2026 13:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="43lHgsCD";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6902B10F0A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUsEGgp+lUSCixLXPFy/H9HWTuT4VmPqZh6U+MGKWKDY9po9y67f6NPLm/7U9QF9oeyQYQEfi3sqSyTZGlytDrGYoUlmLC3yAh5qqn6TCGv4Wdn+YfeCzRku9BcJXhgyl0dlzfUOVqRmvSHtZgLf4SfwAg2T0yNW4jpFVHlnwhNU/AlUP6NjhmGFBdojCKkaZg3qQXfLbFzK6gwqQRwuXTdWEMWVxhCpYYRbaX5xLniaj2Xw3bcQNZosxn+94d4NCizRvNS03XtG4RgEMHW1skJbwdCFD2GyJgHhU6UiUNvFThTGDYm9cUVUmRWqaa0YF4VQqTu9GBy7mv79L3s9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT7MS3fESft8P+trpSwy3G+9CF/eUnj2ckStci+lkCI=;
 b=mrIySW7drQ6o3rF0ymRGebSvxjTonFWWwRWQg10S0nHnxpMhc5kzeSwAjFkw3koqsnAXxyAmukvuHhZMViJtuK5cUbuRbDAMIdS1NaiyIC0voal0QECDEFbRHuJcquzk6Q7Hp7NzAcSMYdyiuF3qfR4u9bDl3xVH1ww8UNp2sqdVFi2u6qpUM9lG7oITANXbHVxE5Ag7hU9G7uugaUgNz64YEAHDX2mpU9NXGMNwXXGZ1anh9LK7Q1aXD7WXswwzf27P7XP0Yd4qOUHSXEuSanPG9SPLEUGyhr+1PzD/LL0gqsK3BUwZNMRfSEWq5cPSNO8Pm3DExxu48MDXsBbq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT7MS3fESft8P+trpSwy3G+9CF/eUnj2ckStci+lkCI=;
 b=43lHgsCDHxjPf4G6VgDL6u8hCCKMq/WocOnWrETlqEtRLA085Enc3i14q5FXzVHKFSCCe34JGAjyw+pIMY3TMbco/b3mdQYFBdSH1B2czeXZ+3ZuL2h7gXSxYtWHkTPP4DoDQo/r3Q1rHkiiPQrZHp0tKpoFHR/c7Cc3nSmgkSM=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 15 Jul
 2026 13:48:20 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a9) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:47:57 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:54 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 49/70] drm/amd/display: Adjust structure dml2_display_dlg_regs
Date: Wed, 15 Jul 2026 21:37:59 +0800
Message-ID: <20260715134432.1975118-50-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bf242d-600b-450d-fa30-08dee277baf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: w1GVQ9DmffaeCDTO/lyggpphLbMRq2FRwpwIEoV05i+E1ZJNDiBUq3DhccTH64sV3YM0ig5D4YYdWkYka07EVw3tzngXbioeJRmWQ9o+zx15sI0oEsKvhqC49gE8bT+sQQyntJ994rkzC5tq0OK7en9S5B3L6QhW3SbPtjlX8cRWjynBE0ynLhtPZF8tC40t2FWhKIIOkqAivOKZQxFm+Mcpu7C/1p2InyRLDilKO7x40Djr8mUT3suBv2nQkIrPDFnf+b37H5JebKHVZx7Gev30uhf4TJbRuLGUJaX6BlY693A1W0YhpLZhDiM8ujv2OI33RyhYK+fVjrSCKzusxJ9tyX4KEqhdfa9iFr16fbqwTcCE0P4gQwEU6z2lgnLxaX7l7FKdH331aDP3HMXPQLtu4JGMj3hvisdO9+f0/Zk267O1f8y9vAIixfgzm9dp/n2AlJWJKpxp7c3kMtfDxjtLJnwndhMZMfFI01UxK+9yatP9Z6h+yP9v8RW8IpQv6TRWg28hGOmj9nYLT6yKUmXGuWxAVNGBNkuDiCUzamcoIywSt+ta3B+IORXVFrZlB9hB1LWD8vF7u143ZJ+gkMVBvZ/qjX3+Qx+qWygHwQO/th5bF2ujIB9nGT/3GSqdbs0h94Qee/NgTdnR2ibSrFbTMvACil2nuZj72SdsedF2FVuIIOVBnRIN+kgqQrLN1TbWAqzjzZX26DprIE1tcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EFNQvONYabNJAjOwKUrPs5/xYmGfrfH9iiv6BjmWnTu014e2RiZLjJvStwWDaVb2jw69t9h1VX00ItmAmiKDS7eOAvQjjZh4kVuD7Ntc+1dxukBRypOwn60uCbEemet67hDNDuva7EF69WpRyXPulxqjVN+6yOhB02lZiUYlfCqHe6T7qXKCqDiHYhXR6YRWD1gVaBTrGAFWBg2KRwIjLnoQdQsuag3GvmIfi7wG81BLHkBPWEVxj6g5VP4qpCKkKzXqg/aFVGnerSdoCJVsz/qucyz71SoC0NXzuRb7z6GNMTPoEGsvduwBoVNSzs2Fv2l7TuJRypnixi+r7YwHdcTAZB0miVMOMrZZzgala/Gd7qReVsHi0dsaUo94lD8dqFQUNtWeJs4h7FswRQWwRx7k/Wr4RbRz3brpkpzS8ZqJQzeJ4jdI4HqNOIEF+ooS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:19.8034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bf242d-600b-450d-fa30-08dee277baf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Adjust structure dml2_display_dlg_regs for future use

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
index 799e72243418..5a5f7b92c324 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
@@ -46,6 +46,9 @@ struct dml2_display_dlg_regs {
 	uint32_t dst_y_delta_drq_limit;
 	uint32_t refcyc_per_vm_dmdata;
 	uint32_t dmdata_dl_delta;
+	uint32_t dst_y_svp_drq_limit;
+	uint32_t force_prefetch_to_vblank;
+	uint32_t force_cursor_to_disp_pref;
 
 	// MRQ
 	uint32_t refcyc_per_meta_chunk_vblank_l;
-- 
2.43.0

