Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51229C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81A410E91B;
	Wed, 16 Sep 2026 17:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LN7vXxmr";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFFF10E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEq7mtaj2TTt9yiwF1zzVOVLvuslyT2+qEkFgcIqjsaZBik2x6pVj//SdSwqxxblYDjeRDvHLceWUHQ0BQjBoZZlVHsOV0ruNlK4Y8ZPnBDIrch7hpbi4I8jK3+YFF0IHrITlg2ZXwVxJMisXdMQ6G7x7fZ7QTaNFkgmlA0ORxBfaLkKiWSZk+hZrXrsH/lth/YIgnUx5oihkIW8H1HL4HZJ+VxrUK/xz+UYlwC0vS5wEGMSc8+P5H/1OxlDt5gyQN1vQ2Ok96nNBWKegbNnCct9WRyhQvW2FCrz5ykZLbLa3lLtBZXG2gmfJy+dJS9knVdQPDnuitCyhg0uZ7dAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Epp8HR1fm7AM1usX7UDnQZrY+RrocsKDxY2d929QREk=;
 b=gC2yUnC+7Szr5etlTDaeCXlU0vFwjsUPCnL6rNxFm6Q59gcbrZiyzb20kie6nd9FdcMgyQhmwmleddRz3mpVifAqrWZy6NSVOGDzFuy8RMXfS0TorcHTIPND17Oh83itvveb52AU0u1CBNW1XRiUdDPFrem/VJZSfC6OMrLpJntOqQCIGu9zG6vqEymZVJr/a0JDMMD/OMKbh93hELVhFM36BWxD2A2fzQO6VoV0XQez5CaZLbAzFrmoZT01E7hlQrZrm8OlyrksRR42QZ8i00YABuejRqKiojPr6C0A91hv//CgpH097qyVroettPdG8phYlshGKSyliLaB0nqPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epp8HR1fm7AM1usX7UDnQZrY+RrocsKDxY2d929QREk=;
 b=LN7vXxmrsuZ7vFPFEBKKA/C2M9WnY15VcMPLtDH3THakXsGDWbtO1P/QbbO72z6Ja0kqeUCcSqSml4MJrlpYsmHGz46P68fOLGflCG9nXtFdKCt0CEWrT8HKMn7py+oL0BeR+cDTg3XwXopzUZLdc+mdwKHbFESokefLxHyTdt8=
Received: from CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:32 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::72) by CH2PR10CA0028.outlook.office365.com
 (2603:10b6:610:4c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:32 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:19 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 10/64] drm/amd/display: Add inst field to struct dmub_replay
Date: Wed, 16 Sep 2026 13:51:25 -0400
Message-ID: <20260916175301.368306-11-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 586df237-f156-4150-6654-08df141b489c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6hJf38O9cTX2IVpYvE8VsA6budRW1FW8hdkDT7aMqdeqE/pIX3YWdYkCemhwWQzYyNLehvtezdubWKqSPsfmtp7Di8nVFLdYJJSvdvvEtcWISz7glHAziOXRDwAwbhULay1n2AuE+0sWyGHgb/ICTpUBj0izoCiRdjlx8glgL8gdq+Pkey9/kgH3ZUBiPIBFawPw8s6K0eGUZfiquZ5J+ofDDHPgMRJVgbp8KiVPH/OkkIYDSK1Hp63N6W8rZnQhfQA/eFJjJ/XpdHcZu8IEElurYFfhzkHQZtZnb9z4rqoUkWdONPMD/gMod3H+yNCs/xqCmuR47MHEbkEbo9Tb4gsX/X6855G171O8NMBKcLPlnqjDQBT9L2HR2SU2NZdBc11uh45G4PPFdCWOuGb73J9kXWvxyHB+wp1oBpPtPj2fVRL5HYmsCvrFNpAmYp/f8x1r5OuV9PD+DRfP4gTBA9SYMSywTN/w5VNA6kYFEiiEC+AiybxY87xlPjOKCWhvCplOfH1EKGvIc25FTy+BwwT7DsryudFJQn9iQag/2vHthDrY5XqZp9S0KWpaRK4q/JARhdCLtlEKCg4uY6PkhtvPPyNsdfeDj/N28i6o6079RwREeks0urALoT0783jZl44+YJ+vL1ezcpJA1AEDUy2BTRn9jtxi6Wmz34vbjQLwexWrrEjx7wE81aDMnq/t8NZDA8Z4E3mjLMPedUJgSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S9YJ2CJyQ5t4zAz2m905+2JRntqe7TKbXMbHF7yHrK148E03+r3EFn9ldGojoDAKyCE0rwQUtHeGfnyI+cip7PY0eDXP6McK/PsRf7E2h0ZdibA22KMhRuTvHEt58JHWTf2ABJqBvi4C+uX0IzFUv4TsIP4WQDa/ItRCEP/hOf1Sab6WI8sQSVIeV/G9qWDBv0HVE5FckIVCVAkIlPvYa+3+U2a44vmiXM030J4kxV+NGJ9X/mMd2aFi4lnDnGmAhfdtPfPwqOdDu7842tEHBrS8KznBy/3+nkRXx9VQ0+cMnOAALTohr01+jSA3nNYBp2IAc+k4e+thThDnYzbVMiZGGnFX/+Phc4AddF3falIeTPxiOoLCMbzDraLw4ktWCEH1buIFygZPcU2GjDr3fvDXHtXU5cbLZA06VYJ0Jnhz8xwphIrHmP1iVHUliCjG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:32.4227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586df237-f156-4150-6654-08df141b489c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct dmub_replay and set it to 0 in
dmub_replay_construct(), since the replay object is a pool singleton.

Also move the (void)panel_inst cast in dmub_replay_set_coasting_vtotal()
below the local declarations, where it belongs.

No functional change; the inst field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 0785a30eb643..e6adca240ccf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -217,13 +217,13 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 		uint8_t panel_inst,
 		uint16_t frame_skip_number)
 {
-	(void)panel_inst;
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 	struct dmub_rb_cmd_replay_set_coasting_vtotal *pCmd = NULL;
 
 	pCmd = &(cmd.replay_set_coasting_vtotal);
 
+	(void)panel_inst;
 	memset(&cmd, 0, sizeof(cmd));
 	pCmd->header.type = DMUB_CMD__REPLAY;
 	pCmd->header.sub_type = DMUB_CMD__REPLAY_SET_COASTING_VTOTAL;
@@ -458,6 +458,7 @@ static void dmub_replay_construct(struct dmub_replay *replay, struct dc_context
 {
 	replay->ctx = ctx;
 	replay->funcs = &replay_funcs;
+	replay->inst = 0;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index 271a42a226e9..fa17cd395e5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -13,6 +13,7 @@ struct dmub_replay_funcs;
 struct dmub_replay {
 	struct dc_context *ctx;
 	const struct dmub_replay_funcs *funcs;
+	uint32_t inst;
 };
 
 struct dmub_replay_funcs {
-- 
2.55.0

