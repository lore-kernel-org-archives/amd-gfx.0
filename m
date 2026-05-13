Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D3CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F4B10EEFB;
	Wed, 13 May 2026 14:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHdH7heW";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A367A10EEF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou8Lxn3XZG6q6t2sfog6Pn50kZfsX4T2ih5mXpXf2/XmRX88sdkY7+ETTyiYiFzocxnkQ0vpht0dlWLx4GBKElPbnt7JiVSZwQG84XmHabHpAgANR/bp+RTEvCtgOZsWXET2jv5znWlR8xb0Y2anL1y95Y/jxL4wgrRUMmvveZuZtCysgbZlUVr5l7oTyNwZfzV+CkE4rPFZF0pQ4Ktv2+0GD+gNE2wzKYXtgKlbDmoCEeyCy+zoS59VoawejlVwRfh30tArseUz5oMpVO8zzwgwyp22VHDsTswZ8d/lYa4qBga9RUebut8AWOlvUzFdDmch3c22Epex9H6B5dwbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTHkFWFmQMZeaRcpy1DrauRaOy3yfn5dRaAGnfqjwEg=;
 b=P2F6vlzYFwxnR8jF933Z6vPFZyLw8cceuojValIeB2Xm9s3+jReXPlnJ/qjbRxiubMkC162IGKild/I9uRXznj3bvJ/U97t/nPlk3Lfs04Nq6CGDKfOnz/IM9OTgOCyTE2j56WCbv5y3037DpHt0qJkC4trVm8PyRdXl4KZbs+zm+mptVmSDs4oK9Pq2G2CO/ri7eEYoc1cE85TymaaJgE1RLQXRchFzVs8R9vXxmxi0iBo4tr9TjfBpGBJnUnaCt9XDbFZUJ1Vtbwe/lDSeTn+8deiqnHVXnzXurGSYW/0E8Bo3cTui7V2ysZKPjH2Nk/VJXZIo8UCam/wBwDdccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTHkFWFmQMZeaRcpy1DrauRaOy3yfn5dRaAGnfqjwEg=;
 b=tHdH7heWd9rGGcEtY3phtFDy8m9XusMTo/BpV8faFBK1pItjI0qeYRx761RpaphzY6NhfU+zhtowREB6yjiRvP2scMFIlQYF4RzqqGZBMWKf9af3RX5lq70u6HVl/jT5BASYFJsbnHncr7Ll4fUauc/8MFfPuqYCzQxNfa1rUOo=
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:34 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::31) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 14:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:23 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:23 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 14/28] drm/amd/display: Fix assertion due to disable/enable CM
 blocks
Date: Wed, 13 May 2026 10:29:36 -0400
Message-ID: <20260513143213.1852892-16-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd51764-bab1-441a-1650-08deb0fc9be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: grlGVmGUxxWKHgqYTbiykwVYBEwoO7SA80J8exiwfVcOccJ9B3YjHisQEYjNvTcj9YatMqA+kWBUJb58ss72qAk0ZxVncJYQMp1Ic2FmqR57+xYVI7W15Xe5hQLltTN9/HQc8qOZ7Iszco4whSojlMR4j5FduYAZIr/OtLanreoPloCfz31ZaoCPMfW+EP+Eyag6e6zwD7CJTtISdns0Z+PcubdCk6rn1TLXHVG/hmH4lV3vIc+a6vHdfFCkAUS95/WXKMNSUybyTWG/mo2DrrUa5o3z1xHwVFg1WpjiC17TTi0cx1MEbc1/dq3m3NgjAKICaPpYQ26IgbkLA6J5zzoAPs57d/v4DoqR1gQFK57FMz4ls8LWI8n7tN4j1Yg6gOfQuUVua3Nvx7tsieA7dGbUIj9Xz3AHrSfPwLQzgH40Y9C3FWcTZ1abeiUA5l10CdHIJtCDye97ijTQZbVCueUaQSP7qBVdG6nQfKa/R3SNf6oFGCGnC9P4MDruJbrQI9TPtO0e5pOEteFsneYNwSL3u+QtYQL43XXiHuW6jM0QSQ/2opeK1SxBujGcDzZmKVrfEJTNkzZj+UDqrUAM/P2ZJAJBZPuvNALu9nr0gYBX7HF98jJrvIUzjHgGaSRw1TNbIZWm3UPk1d+G3qsvPDPZ+BRWyxusY11vdSVhoTplVTUfsk8WowfyMv/nOrh/oyE3qXqmdc6qf6Y7Fhy5hKVBGH4bbsYiD/UWN1N+hr0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UqCQLPA9YoOiYNJDPmv3d4T7Z8Tytfl0XnnWjLHa9P+qTeD3BAhbH4gjl+RYG2OCm2Di/mli5PUn9kRzD8WupA3xmSSJa96Ugf/dp+82LyqsLR8EM/5/pwG9Z+Jr1wEzpCVOaIm7871DsejfgcKMcpS9UHuK5fjprN/5ObEDAe7+DCJph1zRu7M2noD9S1YgnzWYKnE/i3baclNePB9aiGzdV1xHeGg84L4gt77FRxSSpb27gz+MRZmZ5999s5T+UpwSU3Cz88+kENxNUrcowc8zZxeI1KJQrFixWyWSTlfsHkqQ8J2WHA0b7TtHPUsaOxhlDCx4DQPHug5K9BB306PW4TDXtuZvwgQ2A+RU/FtYeh8fT5d9AyK1f5Pnd0L0k3znjDSu+bxlVt25EH/KkpZEKOEY/dJnojFA6u2EKZ0skwYl3kMy/ob/oqpWZIa4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:32.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd51764-bab1-441a-1650-08deb0fc9be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
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

From: Aric Cyr <Aric.Cyr@amd.com>

[why]
Some dc state transitions can result in CM blocks being disabled, then
re-enabled.  The disable will set a defer bit, but re-enable will not
clear it.  When optimizing later, an assert will be hit due to incorrect
expected HW state.

[how]
Clear defer bits if the block is re-enabled before optimization is
executed.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c        | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c     | 1 +
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 8faffc2993b4..2ebc738c37f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -603,6 +603,7 @@ static void dpp3_power_on_blnd_lut(
 		if (power_on) {
 			REG_UPDATE(CM_MEM_PWR_CTRL, BLNDGAM_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS, BLNDGAM_MEM_PWR_STATE, 0, 1, 5);
+			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = false;
 		} else {
 			dpp_base->ctx->dc->optimized_required = true;
 			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
@@ -620,6 +621,7 @@ static void dpp3_power_on_hdr3dlut(
 		if (power_on) {
 			REG_UPDATE(CM_MEM_PWR_CTRL2, HDR3DLUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS2, HDR3DLUT_MEM_PWR_STATE, 0, 1, 5);
+			dpp_base->deferred_reg_writes.bits.disable_3dlut = false;
 		} else {
 			dpp_base->ctx->dc->optimized_required = true;
 			dpp_base->deferred_reg_writes.bits.disable_3dlut = true;
@@ -637,6 +639,7 @@ static void dpp3_power_on_shaper(
 		if (power_on) {
 			REG_UPDATE(CM_MEM_PWR_CTRL2, SHAPER_MEM_PWR_FORCE, 0);
 			REG_WAIT(CM_MEM_PWR_STATUS2, SHAPER_MEM_PWR_STATE, 0, 1, 5);
+			dpp_base->deferred_reg_writes.bits.disable_shaper = false;
 		} else {
 			dpp_base->ctx->dc->optimized_required = true;
 			dpp_base->deferred_reg_writes.bits.disable_shaper = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 99581f35e54b..e01d8e9672fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -136,6 +136,7 @@ static void dpp3_power_on_gamcor_lut(
 			if (dpp_base->ctx->dc->caps.ips_v2_support)
 				REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_DIS, 1);
 			REG_WAIT(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, 0, 1, 5);
+			dpp_base->deferred_reg_writes.bits.disable_gamcor = false;
 		} else {
 			dpp_base->ctx->dc->optimized_required = true;
 			dpp_base->deferred_reg_writes.bits.disable_gamcor = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index df3c21ef57a1..62994aecf499 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -161,6 +161,7 @@ static void dpp401_power_on_dscl(
 				REG_WAIT(DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, 0, 1, 100);
 			} else
 				REG_WAIT(DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, 0, 1, 5);
+			dpp->base.deferred_reg_writes.bits.disable_dscl = false;
 		} else {
 			if (dpp->base.ctx->dc->debug.enable_mem_low_power.bits.dscl) {
 				dpp->base.ctx->dc->optimized_required = true;
-- 
2.43.0

