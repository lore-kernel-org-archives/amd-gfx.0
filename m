Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4085C5DF8E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD46C10ECBA;
	Tue, 18 Aug 2026 20:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TYwVQH5s";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE4010ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiO9wJYKYWDfMwAiotlN3PKP6rc65kluVHC6vO/FCHKaUrHI5dU4/IOD/gNUSwEQ4Mggm1FSlfwepwHIhrgWQx7uCNdrLmioxZC8kCyaID5wE2J/VYmphxg1YZOfY3Ax5qCcqyV0PoKI4CeC78heEAGJVzkFZMfeQGDHwqYMipVFXt01ijJiTUJGXCE3JgNdzd9GDm676bjDUS9ZF53+OzcsCYBvfdbP1HublcE4aKCH+N8QLgcqCbM6tJgVO5P1UQ2qHLMroPVF4YJMk0Uyd8dCLAL8oyDn72cIke/NVCaJWljnl8ukDd2rLvXGn48f44WxzPkRj/qmoQA0OaeV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpRcqOhKOfBKlItnF7/5cfKxeCQh2WjKR4PF7lioIBw=;
 b=bPBYFELwc93pvGPOpJrEJicoBnk4U75q6lo3LA9exLOUNR2Ndv5Awf/93t0c+dVaeJX9InK6/SC8kEIwTzSaNW3l1EiWOLn7DMsHiCftgapxt+Shapl8Cai5KK9CYvtnys4/SsoVMBGZYgeqCpiObInX9bwpggEnxJi1gIWioK5lpkUOzr1lf3viwENCj+YIOlDIKChH3tma1lGDtZGXTOY+Z3y1dFobJtTPukJPtG2Eo72Dk94VgO1Dad3WWa5vZs18ILQSEwZEsBw47Yg7EgmSgd8Bwi/EoO88mOrDOjBXKJVenzcFm8juDiatLil0fHiAr8l3EETREjf9OGFCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpRcqOhKOfBKlItnF7/5cfKxeCQh2WjKR4PF7lioIBw=;
 b=TYwVQH5sCrXveCZaLhJNRQSZaflQYoLdkQYqKYVqz7w/gtgt6bF5XI+2Bf8qEOx6Rwc+RD7rVcBsPLKAl3WblG7GJnJsCA2Xe89ZWRaIyfseWlAgLPMR7PJjRZaIxZ6HOfUyxYSKFiYab1CIEsHXGOpZhw3f3I1K8SIo+1dX5Pk=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:38 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::10) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:15 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:14 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 30/82] drm/amd/display: Add hook to disable alt-ch in PMO
Date: Tue, 18 Aug 2026 16:15:22 -0400
Message-ID: <20260818202139.4172592-31-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 063d3012-0feb-4fc8-5762-08defd667272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BCEdRqrpN3d9Cu5gqp54aUFFK2WfO9XGhrUxSLa4z/cnPienoMBvAj4SbaQGuPqhfaoawE6vwNyfA5R7z6m6em+/s0fmS8DPvC6INZ5H2wCcq9ic+yXFDj2QhkiFhCph4LgbeiRG+44dUPeej/GFFK+TJJmqmFFQwxWbneKnJSLZrhPDWV8FX5kBbkBctcgSD+qZruVDB/NXm6LNi7WqLseUX3foxt5qQciHXOdQ/aIF4Ix/W89JELv9rkNzAvfOx1h1JqGp9kl4XQWKWt8r4zqzysEEPwsOvx92emQBj5Tm0malhmb08DdaAfrg427pYuN6/yiNX3B9ICgKcMOPByHzxXwx5otWgfJMPod18rr8DLxnVAXV+B6W4hEETD7oslRXKCJkOSjWzbVomKrzbKEApPfPvV38zh6xDl64IO7dy4Ks0ZYszdBXPmtkgCSbQGWD6Hwr1Svc3oMc1QxeBOyFcCOdmo0d0y++3c9Xj0K9Cm0St9J8HnOGqtAMoSLNSNe2SU1BFKZqikSCWRH2YCBv5AJBX09cC1vcXQaSKU9cAS8a6KdvXVVLpO7Vdzq0fyW8IH1codAJDNVcT8A3zfSAWyFA8KmpkuTMEFANYfll+1/pV97hvjpxEzyuBvq9WRz/GBQ1TIPUwhBa+vQEZJkXSJ1ETE2Kdgo22dcfNTAIQicGgF/eQFk4+nlRIz7JErQsmoViNf5bdnao6rhwPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aKdyxcU3+eGbEyCk2pq2jn3el4k9t/ccgcw00WqnhPtamuko8m9pK2yECtDBQyR9z8UuoZmzTvIVuLBuuUozY7JKAymIfrn2AqGN4D/twDRjOrCxXbQNuCWQpr/hZHujzarSGsiI9tn0dlV7/ceW1AsiwiG+i0O2K/8+iB5uJQ1ZoYrsp/27ZWQ5GlDinrTdbPw1BIoixdWwbY4rsLIU/Q6jju0P4ri1DofqFfgHjGFvOHfDWBA0sf/19cbBmWbbiRYHf9BJce3H4qfPbgGnQdSLixhbd0JVw2OddvJFkHfG2czlzOzVSuL+Su7BTkL4m7hzUzXk4m62niEclSBgKy/5tm/kVVKwK+FZkoFv8GlDzAbERO/gp0Q5m91QZugeVtfwzMkptUxjMAwOYPkcAmzwdUhUSBJX3YeOJ7Jl9VLc2mpv9eHPjbRQFjbMJ0cj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:38.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063d3012-0feb-4fc8-5762-08defd667272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why&How]
DML should have a method of disabling alt-ch pstate method.
Add a debug mask bit to disable the alt-ch pstate method in PMO.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index f4f848d738208..d456fb3d616d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -31,6 +31,7 @@ static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 			disable_fams2;
 	pmo_options->disable_drr_var = ((in_dc->debug.dml21_disable_pstate_method_mask >> 4) & 1) ||
 			disable_fams2;
+	pmo_options->disable_alternate_memory_training = ((in_dc->debug.dml21_disable_pstate_method_mask >> 5) & 1);
 	pmo_options->disable_fams2 = disable_fams2;
 
 	pmo_options->disable_drr_var_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE ||
-- 
2.43.0

