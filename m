Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE36C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD2510F6D3;
	Thu,  9 Jul 2026 21:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8YTPhx/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2606410F6CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUVQN3FAYlyo/0Ug4IZ7Lnqtkth0f6bO2+v7rCARTMQH8ke8c+4p4qWsamEz/+1tXCWYws4eL1GveS4dyaUtayrBNuGn/swhiyPFKUifITiE2eOK2WdXb1lO5GQhMBoiQ3JbTvaGmrvswMSzJL2x5LuDcFGCCG1TauAqzmpMkrqavlK73AMV0nvjGya5H1TRAPWjftsi2isXNLmUQrPF9g4mI/SlogfcurzWxV9x/tj9lsn7T6p56s+gsjMGLaAOMQVBlMtob66/XtT7YnL/XFqrvzDF9hQMgIwvSxZBYA0zBR2LpCrO4FO9fgO62iHsKLdleGCU2Dd6qYtqdTz2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ5dwHSyIb5Vajw7hh/P5DfFIwGflxlrjRsCDLRkFCU=;
 b=Ir3KhkKEuZ2WQOqX8vkjcQvwsgxzzC6LQl4+488k4DghRznI0WcA+VQhooODjWKO50j27wO2Nd5mW9SWCkiKPBYAQvNtcGUv3gh1BJaPEnEZJYfDGfXeKGAbVY+ZrsO0ibMBtWha6zdRVXdY1SsvPDYcyf2ibOhLGd+2/pbTS3jZ+TTmBrm9a39thBVBFBgw/Jadyi0LlAs+VY8dcIHqb167oDKRh9923uytFquKN9w5dYTykZQZlZ52KbHLBFGQ49iy5BvnHnstw4AskI649a1uQHHRXYs07/OduA/7OF2ePFov2iTQSz/M3ukQkHn7qrUIkl/QgWAVxshv1vhYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ5dwHSyIb5Vajw7hh/P5DfFIwGflxlrjRsCDLRkFCU=;
 b=i8YTPhx/KkF1uhk4lkO0Zlcc3dQ7nVenYrjHuXUNlN1wB1Gnp+i48Bt1rFHLi/7AE+7suMagpInazbvGngs0aBvUZq07S3E9oT/QEa6QSsroPUnutkIpfDyKO6zm3kElAQnQpbnPLe/EiLzdOOHgRC80QiFavh3Ijid0f0A8oC8=
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 9 Jul 2026 21:02:13 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::a2) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:13 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:51 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 20/80] drm/amd/display: Add MALL status readback support for
 DCN 4.0.1
Date: Thu, 9 Jul 2026 16:47:48 -0400
Message-ID: <20260709205936.5719-21-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a59b1e-e0a5-437d-0801-08deddfd59aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|30052699003|23010399003|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cu4HtDWmxzPuDtlHrTj5LUsfoSi3O0z+zsf39am8GKnsXc88oOmnoKycqVm9n0dxLDafArfWj8U4kGvfFshFaIVTU+KIQsD+XyIFTQ06oOcufdhW45CDihAZZlQDdc+KQSNE0mf7lxQ9pSGc34eMNb4UOMU8dVxgm5mgJJgEEmd1sRQra33Swd7RDJKIBHAP+kjLkp/c0QvCplO4atgqyyN4x0P76Pf5Eeat6kTmQlw2l9Ck2ACqDxkaT63GfNaqVeR41fzGcwS9zEb47Ri7qYfLPy/lV23dEH22iPLs1onjHmmGcSL+uy5yVk2NHac7aCRur2efKPcw1KWzpnjqIuxdv//BCLi4ADqcBWrKI4qxRE/psNOFq4j3aQS0H+nrdgbG+OSVF1ph4/1qqFZ4FvN7ld8JMcQaRwwBrTuHPKGp38wnh4xiAT+IPQeDCSIZXKjvUuGHircWi7Ijb+dfhfZTj6pXm8xrT5wKr7+njTLDmcBnYuBbic+MXh1M75CsxIzKR1BZWaU6AEeoxsrGqfLlByNp2eHVaRuElVzifBojfSBOPooh3f7RjOo7oEthxIiq8HpDB8pNMRu4au4tQPXrGrmd2a5/On3ObOA91kXK/VYMALtMPRUz8XhyPjSVWP+Ist0NcOqxWg6qtzuHjgM2vfHwRB24tIHavc7VsubtJzYPVBxOLhDFNvDIUPuznFSK1QkweRnCux0pssArYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(30052699003)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kC5HA7ivtpPH/EOJk1dLL4Rod2kupd4jrP8Qri+AZ/jcisbz7WGbgQS67LcKGdgyqLc/qHK13oCmz7cKNENaEQ0GPNV9YaM54q0FBcTjdTzGx+PZZv3+wRCxNJoaD8q2tQ9eqPNmSlCm4f0Xre1/mG2RH6LFlzea7Noq4l+jEKwlA/3MCB34diAO7BRd+gSMI5teJDSCo8MjXSeeP1KCuc2s0s/FLKy7f7IgvPrvTq8ZNPecdfcjHBz5GaTKJS2WZj3YN0Ykw3FA9kgykp1fIQ1USP8BLrREl+zof8I68Phb2qgbxwOfo55197XPzv3mI3AzDfiMSBTIksrliLqljhtHBdO7YK3lPFMNqcscjNPf6UZZzZGwlRp/hfkzLWxyfHmaB08Ah5Avr2rrvdklLern0FCE3k0SRmbJ5hSyJmBxxdvKa4jlF6UHas/o7GZZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:13.3512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a59b1e-e0a5-437d-0801-08deddfd59aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

From: James Lin <PingLei.Lin@amd.com>

[why]
The IGT test igt@amdgpu/amd_mall@static-screen always fails on DCN 4.0.1
 because debugfs reports "mall enabled: no" even when MALL is
actually active. This is because the DCN 4.0.1 hubbub function table is
missing the .get_mall_en callback, so capabilities_show() always sees
mall_in_use as false.

[how]
Reuse hubbub32_get_mall_en() for DCN 4.0.1 since the DCHUBBUB_ARB_MALL_CNTL
register layout is identical to DCN 3.2:
- Register the DCHUBBUB_ARB_MALL_CNTL register offset in dcn401_resource.h
- Add MALL_PREFETCH_COMPLETE and MALL_IN_USE mask/shift definitions in
  dcn401_hubbub.h
- Wire up .get_mall_en = hubbub32_get_mall_en in hubbub4_01_funcs

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c  | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h  | 4 +++-
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h  | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index bf30a1bb61b7..e9ff20c02b1e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1250,7 +1250,8 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
 	.program_arbiter = dcn401_program_arbiter,
-	.hubbub_read_reg_state = hubbub3_read_reg_state
+	.hubbub_read_reg_state = hubbub3_read_reg_state,
+	.get_mall_en = hubbub32_get_mall_en
 };

 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
index f48715544429..346bead81504 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
@@ -133,7 +133,9 @@
 	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_OVERFLOW_STATUS, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, ROB_OVERFLOW_CLEAR, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, mask_sh),\
-	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, CSTATE_SWATH_CHK_GOOD_MODE, mask_sh)
+	HUBBUB_SF(DCHUBBUB_CTRL_STATUS, CSTATE_SWATH_CHK_GOOD_MODE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_MALL_CNTL, MALL_PREFETCH_COMPLETE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_MALL_CNTL, MALL_IN_USE, mask_sh)

 bool hubbub401_program_urgent_watermarks(
 		struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 47f82b818262..ce96fe1ddb7c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -622,7 +622,8 @@ int dcn401_get_power_profile(const struct dc_state *context);
 	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),                                          \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),                                    \
 	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2),									 \
-	SR(DCHUBBUB_CTRL_STATUS)
+	SR(DCHUBBUB_CTRL_STATUS),                                                \
+	SR(DCHUBBUB_ARB_MALL_CNTL)

 /* DCCG */

--
2.55.0

