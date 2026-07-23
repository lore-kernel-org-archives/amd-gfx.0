Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81796C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2650B10F1EF;
	Thu, 23 Jul 2026 20:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHALiz+O";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2266D10F1EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erL0mtcjS+gR/LtEt/fm107jFcBLj1HAcjOhHGGcvYmS0ombMyd+1QUDJeuBaCCd0qHqwU6fqawenPIBwGwy96b+slvJaEIoHysyhnkIqwgSoMI323Ko5qYCuK4FQ+Y2NhDc3AsNyJ0CzJUQAZ0zhEAK/BvaIL8hCrsuxsiKgfwcpF7maeH1Ati530T/8mQHJX9jYJsik0FLtTwWMVjaTq2MI2n8i3hsjGoa1k9U3wvU1Lml2BWV0HV4rg73vAXXcd5vYtXOJYRKnoZzEkX+ThCLvrlc6YgfAUxDIQOetgafNeUX3wXPy+Hw2cNvmJZ09Mw/gEKSc6EwOKboJy+YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAnwEZ89b64S80Ay1wJxU/DUuKqpYb7wWix5fjrEXSA=;
 b=BWFo3FXThQ3g75/LEernWjzQeuFSIBJ1IAOeu82TCQj+f5YgX7yf02JflENvOawKVmKQ7ibn5vuqmWa8gn4C9Mf5jUMxIXbeJtXBfs6pwh8g6Y9lTjmupwb+4H7mOfPQn+VDr5u7lhw7Pp4xQpEmIKZC61UWkxXesv176v4vnbA8qlFZBtTsl3tJx6L3pg63umoBczSQQnrCN0ZZ+KHFoFiv88pvFJT20zSMQD0k0eO/A+xMeBfEThEKe8Irvw2wAQMOdTwFOn+B+nirRukYsafaEa7vHSMiwApl5dqL97SDX1VvUgnwFLcT3Qb3fg+YZtKIM1a6YuBhjzCFfnuWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAnwEZ89b64S80Ay1wJxU/DUuKqpYb7wWix5fjrEXSA=;
 b=GHALiz+O+jbivyhyMR97XfJ+tthYAQDEhLQnrq4wvJ9ewiCvR1omntZo/UNpXO10M3ZUUfHMiW1oUuiX2IarxoLmV5Ne5BPNY0S8bWwO0av1KxlpbrubGHo3CPX3rA8ol1zX8jvmLtPCHAUiAxTPscFlGD4WTfJ6JzzFRQX8Weo=
Received: from MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::18)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 20:20:04 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::15) by MN0P223CA0029.outlook.office365.com
 (2603:10b6:208:52b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:20:04 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:22 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 45/49] drm/amd/display: Fixes for dcn42b_soc_bb.h
Date: Thu, 23 Jul 2026 16:13:53 -0400
Message-ID: <20260723201908.373300-46-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 484e5aa3-9275-4a70-8b2c-08dee8f7c7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DUp01dhm8t6eYUKpMdHkx+bpDZQdV0ADHpHJO95VCs40Ipp7TjLbnne+vAq4sh8tTkqf+NPFV3kSjqF/thRiDulZgSz2Gmo/vsbBXKwbhh4KSyW8l5Y3bCoAY63xtHG+LJT7qBiv3OdKUTCH7r+Slacm0OSNxvrUpFIliNhcaHGhT7lOS7bcrNN/jSvW36O4L3eVUMR988Xq6iDnb/4ns5hrfxfgnBc/nZxVQv80guAQLDzZPrglmZH66xhSjd1w9MbqrXaR+3FhIwl9UycK8GJl6xbN52gyHkVhFLOJFcwaxPxsHNg0z4RXjDj/idm3UsSGoD0bDl3EHwjJKPWjZmc4uHd5GQjMRm9MwFI1gHuX0ncT0EOam9R6hqlmVWsvRWSw5Ojb28tzLkq6QOqSp8tSVtF9/QqM+bNgo4Ezn5OpEgBXCdJQno8GmgQt9B2Famy9q2/OkFCkfyk8RKglQZQ9Do3+6aJraLEbAORZy/0V8sZ66tMgnrY0J2yMjx2ZXFugXMax7PE19WL0zgnoc1h227twwsGDV7TDP3SAqRtT1ux7SLiaT3nrUGSLlwkj04BS1zOx0LOnUC1UzekeuiChXuWHFulniBbf/nAQe+BFvBMPInDYRigms0wNld4RSjf9+fPdYaKbgRJnZRAjLkFYg1FQ2UU9jZ58NHLBkBNkcFuqwE1gawQPwCFgGDp31iDyX4awGH+sKJqZVbXUKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2WOZJv+U1uKsbb4+vkLyKaMIX9CzOJNEbOJIkb2tb4yKnf2hIPyHNjG3SaMyDv34qb6VeDpUpbwA5R7xOrlfE0Luzf9TSDj1/g+oivgbnFmbDvaOtx4JG/gls+QF4LNiW26+XEdi8IELv0HHhNbAZ60k06UmebNBeQKGhCA1lzjza43ZzGmmTesuSThpDTOeMIqN5tqk8IEd4GEXbQ6JPSrFT5+T4fmS5NnlN6dn9zSxfHPCuejm+hIfmKzLbeBAouor1lLGdagXj4cYRL6jMUVpANpCnmdLW41o9CPj+6VpN5qANRxe/qEjQlnQDHmZtTS/S8yxoixsFe5iSz0bUK1IcTVY2DbtE4WSYwqQrzL9SZoM8kSMPFaTCzFiQIMHdQUzSJMGtd1RWjHI952cDvvutM/6pxwjKpwF9P/QasyzXF3Uj0G8x8lB//VD5nsf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:20:04.0561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484e5aa3-9275-4a70-8b2c-08dee8f7c7de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

Some values were found to be incorrect.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
index 60ef56419846..5d844ff4b671 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -210,7 +210,7 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.return_bus_width_bytes = 64,
 	.hostvm_min_page_size_kbytes = 4,
-	.gpuvm_min_page_size_kbytes = 256,
+	.gpuvm_min_page_size_kbytes = 4,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_max_non_cached_page_table_levels = 2,
 	.phy_downspread_percent = 0.38,
@@ -236,7 +236,7 @@ static const struct dml2_ip_capabilities dml2_dcn42b_max_ip_caps = {
 	.config_return_buffer_segment_size_in_kbytes = 64,
 	.meta_fifo_size_in_kentries = 32,
 	.compressed_buffer_segment_size_in_kbytes = 64,
-	.cursor_buffer_size = 24,
+	.cursor_buffer_size = 42,
 	.max_flip_time_us = 110,
 	.max_flip_time_lines = 50,
 	.hostvm_mode = 0,
-- 
2.53.0

