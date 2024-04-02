Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA0CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882D110E9F9;
	Tue,  2 Apr 2024 10:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDMu+V8F";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1991310E9F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbl7Araq9RJmbZ16QChL+/XMxn7JKGHFOUYALWmOqP+kpLcEoLDpO2QUPteiT8K4/4jAAmW79X5l1SsNeGGBjYXVpcn7roHq2UHcUyLLCEsARpGBvZRenP9Am+NzmCwU9ge5198oH5eVlAYwyojeFVo96VO1mM8ztk4wQpYKV9PVKsz3rALkiXnd9wabZKUbpQsDnM9iNvnNVuVdbe9kG5Xa4a+bbGNptbV5WaqRpaUb4qtSbZf/w204FTtrdoXVZHdXFHYP6fU6AbVT2R9gm787F04PfaVSFBXYVgTgyk83koTNoWjev8bnB0LRfXHoeGvriy7NX82QC1JHFFEdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Md7TaD8waX7ZZWy9YgukRSByNqOTMbxPm7d924ZYTw=;
 b=eRuidS+Mx5ckGHmgONDGRA3lXrUo4L0YBSD5/pzuJFVqHDX9Iyn0IWTKuVCobh558r7sW4uEl7OUO0rO76mRjvtobsMCzzVGa2SsSlOutsEBt/NXk5r12c96cMkEaDB4ww0dHjumNX3scTyx916EomgY+3IszV62PeTfI4vZ9sGburksSBqqrLC2l3gFZRmpGaZUjqr9IrxRVfxq5I4A7ZZPi5JPNhwS+7ANvTza6/uFt0GiPiH95pTNYcr7M0jRlZPLenLOYTjryO1IfXOpa5G5szDj+pO1t/j5Jk4UBTE0r9Ux/NhwwSwV1YT9FyQtDOBbvahZCvgMJnRX8cbIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Md7TaD8waX7ZZWy9YgukRSByNqOTMbxPm7d924ZYTw=;
 b=ZDMu+V8F204FZFEJ3mZ4sDzDF/S9qtpPahuQX1PpTpWZwjp0QM0zFE1sEaHI8rp+ZdJ8Dw+5SN+ahH2k2VYueJKxhDGJJe3O7DEtc9amxjiPOEtlCi4GpDIR52E8b5gZ7ZcOCif/K0sA8L4S5iQcGu/WpIbAVoRtpEB1RFX47TI=
Received: from MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:22:59 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::e1) by MN2PR05CA0020.outlook.office365.com
 (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Tue, 2 Apr 2024 10:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 10:22:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 05:22:56 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Report uclk and sclk limit
Date: Tue, 2 Apr 2024 18:22:43 +0800
Message-ID: <20240402102244.3374108-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b8c70b-8c27-4b19-d3ef-08dc52fedf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DloKmjv7Wnm/5eplA1dL9HltyDaFvkx52/wMn/JwZeyw66iibfKcRkeoZXfb63UKNYMYMX5R0RBwNw5vcP+7rQD4n0aDU0Vg3o8nOP0IRmYY9qXBUD3gtVF4fbKp62z3uiS7eNwBTaVLh65g+jzYIh62AuX+Pz8XKvZ8hUNdhtm5vrKPm/N0aWCDYeNVMNYsnGtN10j+uPZ4jw4wsMBdRb+GgOkYed//4cJwLZ5zr0fP45XvtDQ7rx5mdWc9dG6hhryoGiT1yuHNi7mUIYIUeFu1d2UdZpS4xC2PdkY26wO+I9OLquQ5rXE7esHeYlN5ZNSLTsBiRU460US6xYR2X5gOP+ORpdkJv7b1w0mtDffHnFWZNpNfKAjMmSqqgJp1K14n2sj2nFJQBVLJXfvSy0aY0/k1OfvfLSjIy1Yv3Ljh05Bzhfr0Sz3+Jt5hgdMBDJaer8FvQRt91C3zJWBvAigGqVhaz8KxWrxCggwFx9QLQ2KYXSVgirzZ+azz0ahZKro5aZX12rTZRZNC3GfIvOW/ZOLJ4rgNslPEcffBHeXsrSj9zl57lc2WCFfwGsgytW+WbcxzCcyPsE1flW34mdzPUjGmLqx/JqVK5KekPYQHNrkBs6z5sbrqNbFwTBfGALaEIyqKQWr7MUy9/7pM4ghrLZ1Hp23JBso6PVc7792BcKqoMtFn0QuxSHATe8G7fk9NK4rl9RNs13dd28lIEO1vZFXeyYqxsNWUnytyUYpr4LefXpglXJj3zLof1T3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:22:59.6841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b8c70b-8c27-4b19-d3ef-08dc52fedf14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

Report max set uclk and sclk for smu_v_13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 575292314f57..f81096bfbf2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1010,8 +1010,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
-		fallthrough;
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->gfxclk_pstate.curr.min,
+				      pstate_table->gfxclk_pstate.curr.max);
+		break;
 	case SMU_SCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_GFXCLK,
 								&now);
@@ -1052,8 +1055,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_OD_MCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
-		fallthrough;
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->uclk_pstate.curr.min,
+				      pstate_table->uclk_pstate.curr.max);
+		break;
 	case SMU_MCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_UCLK,
 								&now);
-- 
2.42.0

