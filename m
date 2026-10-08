Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50D2CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 10:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B6210E78E;
	Thu,  8 Oct 2026 10:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CpgJTG2N";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F5010E77E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 10:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBdrBMdpm8kkewg91Kl6u3iTXz3eSfO5x3MX0vU1v8gu1I3fJApWzZJx8z6FYtuartL7wvs71161tLCgEfTj0QVoSnl1DV68d77aNHHRvkeFAwfFC+gQtrVWKNnXYe3hI4tpxb5WsHMXJYWARqs0DV1GzLPO0PhBdIwVA3Tt3E2WIOAzI/bN2BOyIQSyaKyMu8qXku1NeAYJ5u+nuRTENUKxuoV5/v17+sW/0G/UBkV2/mx0x7tm5SVw3uh1MTEWZmPyNnYfiECml+smeG2dPCNvtRYHVBdwdJHheG+Q+8XLn39uocGNA1A3DdQlsxyL+mJ2fgoebl9wYpCSNuOQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UpJRwYHZALALIFj7lb30jzby3W9dzjUvo2AYMX0l7I=;
 b=MnJBD2bmiPq1T7KUoQT4gI4UUDXHqBjwP2HSV/Auk7jzUL5pL8dP4+0LNfeS/HwLoVbIUajbsRnl3omLjrv98NgUCZrph0Ir3GFYZFYQs3ml/yf4qNH1pAUYmb+z77QUvb/DTD9ZZfuXRntRQTVMTjsKnFMrZiGxxSEKD9PTk0NwGqgcvx15L1w4uMFFvvYp460kQen5StejTnKuimV2R2xROeO9ZY51LkHcTbhA4fL6LSJY1hGZwTdl/cgVp8JwsDJp/RqZra72EjQrYng2v8DofFyfX8d/gs1LFdmlUSflWrWQvig+GyFsAJuw9L7yYsMqgCjiaRxm+6BQVRXBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UpJRwYHZALALIFj7lb30jzby3W9dzjUvo2AYMX0l7I=;
 b=CpgJTG2N1Ig5QOKkv3k+hGFcDXU0qUehhsYnNYgBpQkn1G/ce2T0zXXcrfYquLFMCEs8jpI0qWx7HP1mrMUvjOC39HG2xr0lnnEx4lSn3WpC2yr0Nym+NLdXboRKFnzprgDaRSi+0ZJ2XKTdzsAO79dULa/C1V1LNAGao4yJaAk=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 10:40:34 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::3a) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 10:40:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 10:40:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 05:40:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 05:40:27 -0500
Received: from rtg-Cloudripper.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Thu, 8 Oct 2026 05:40:26 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level after
 a reset
Date: Thu, 8 Oct 2026 16:10:26 +0530
Message-ID: <20261008104026.4102222-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008104026.4102222-1-Priya.Hosur@amd.com>
References: <20261008104026.4102222-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|CH1PR12MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0ef8a9-eb9a-4dea-f87d-08df252894f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gOvc1gkEkky0drOx/zp/SWs/o1227zAM/5/q4zyKyD4kXsO9cxspVOOIyk4jKvKlAUoD3DvWO73G/PRLoVIdymYUOPQ0wwjlY1nlhiHwccVF1Ds4m23LXSMPM9NWAwHyZpXIrEASOxpe6tSaOy/A/Tg4Pt/BlCi/vspA+TmPMw5PwkvMpGOLBdpmxAyPgU+y4iC5ma5I1L9fs7w6oGybK79+sw7rIUHIQd8gtiP/EIKp4UJmdKzsVYX0Z1rasM6frhAIU80fTA/CPM5aglqGqHGw1SuIBP+1uHIgg5k2oXvatRbSGhSQ6CHCLbv8bdjJa3m6S8zjz9fTUBSXhN5FMjNFw/5ji+gThHbw4p8I0myWxen4Bh7XqRi9FuMNgV104q/1/O7wLdgVwjnghMXuPpGLnYfAzTMGmThVmyCIoNOW4J6iBhs5EKaXfKvJQvHKvHXnrjGAFKZzI3zJUFjyTeOB3pGzE3o9pbmbsd4K4ZTTAx2TM/Y77gPCBQXQkW0XEszeIQ1kH6YssbRWFGJsKWliP+qRlP41zEhAnq/MQKksplFuaEc8db8tlBWLcsxeSVEap9UkyubFnNfVBaj2CeYcyjZvGAdqGq/mQwRYOXFbo6X+jZkOsDP0rwRKBgV0BUygsWZNaJDazGuCkSZMCK/g1HOMfihv5Tq6WEwKqdamjctwMO0Fc4fxhxsSXfqh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WNUqwadSbZDcGU+LdvMigJk/3KOpHfadY54wMcpFWN+lulV+kGgGE346g5QNo9CNsbXNKandqsc/FhBCLIAe8FFh+20GZ+WQ21dK2FuZNlKWTKRnjk6dy2N6C/9vcNr+SIXPYqBsXKCdhnBQWdYzCQ0xwk9+MCjdLK0sCZ5J5O/Wd7Fy69w9/ewQdg6wEcNZ5fzN08ZrPg8rdxr3fxX/lH5HoZTcohEPe8ZDpX42+LgZ4BXYLVjBAJYh0lzB8cE+QTmTIgJV0LwTvjm5UwNCeH9pMyJfORHFPnNIJSOsEgLG7kKz4f+vWDlEgQDN9zoeFf1+1/xVywnDUS5FEX4QLktw4QQ3z9j0JclIJdUReg+wBlSbwh4Bx29LhS+TybmC8Y3ukHbiNcSFNa1cKSVPYNY82tJP4neIQwLL8oIp78sbwH8y8zZlusTaEUdujMEI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:40:33.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0ef8a9-eb9a-4dea-f87d-08df252894f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695
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

smu_late_init() re-applies the DPM level after a reset with

  smu_handle_task(smu, smu->smu_dpm.dpm_level, AMD_PP_TASK_COMPLETE_INIT);

but smu_adjust_power_state_dynamic() only programs the hardware when

  if (smu_dpm_ctx->dpm_level != level)

and smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself.
The branch is never taken for this caller and
smu_asic_set_performance_level() is never called.

PMFW is reinitialised by the reset and comes back on its default curve,
while smu_dpm.dpm_level still holds the level the user forced. The device
therefore runs at the default level while sysfs keeps reporting the forced
one. On an SMU 14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs
still reports high. Writing the same level again does not help either, as
amdgpu_dpm_force_performance_level() returns early when the requested level
matches the cached one.

Sync the cached level with the state PMFW came back in before re-applying
the forced level, so that it is programmed again. Suspend/resume is not
covered, as PMFW retains its state across s2idle and the forced level still
applies on resume.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a65aa2129845..2d318726c521 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -998,9 +998,18 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 
 	smu_get_fan_parameters(smu);
 
-	smu_handle_task(smu,
-			smu->smu_dpm.dpm_level,
-			AMD_PP_TASK_COMPLETE_INIT);
+	if (amdgpu_reset_in_recovery(adev)) {
+		enum amd_dpm_forced_level level = smu->smu_dpm.dpm_level;
+
+		/* PMFW is reinitialised by the reset, so sync the cached level
+		 * before re-applying the forced one
+		 */
+		smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
+		smu_handle_task(smu, level, AMD_PP_TASK_COMPLETE_INIT);
+	} else {
+		smu_handle_task(smu, smu->smu_dpm.dpm_level,
+				AMD_PP_TASK_COMPLETE_INIT);
+	}
 
 	ret = smu_apply_default_config_table_settings(smu);
 	if (ret && (ret != -EOPNOTSUPP)) {
-- 
2.43.0

