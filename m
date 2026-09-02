Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7E7C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2E710EFE5;
	Wed,  2 Sep 2026 05:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JL2loiyQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C991710EFE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNDNM6ow656+0ikrd/Q+5IPihFbgxnaloFgzj0R+NNyZifcTCUY8Y/awVlsTueqfMFOfgjHZhOv5yok+mt+EB372SmIPLxQXc1TtlXrhaMuDebTr5uVfqtrnfRFzkA+iflebXDvGk53Smc3R5oFgmf5dXk5j6KIy59qVj1djKiNMZeZq0pa8vqdrh2o+UqogbZqw7o4qZExGOASrr+yglo0YCqucHsGEWvbawwcWSbkBvtoNYCC0ad16CYcsgAJxFNen87tOGxqxl/BPFtdI4Tl/vHTj9GXw1vcglm84p0cCUZ+DC8TzmpnxZaWzBMA/5AHAAa8O0dBiJkwCcotqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ird3BGsZwZpyBdZVqBXAuC8kSBQIGe6SR5FgZBEywkY=;
 b=GKXKxJQbH++1KNPm5g6hW4CREIxhr5EUl+RxxX5CD/o63NrEbzTaaE3v7KVTvObEn9XJSlkg3J7nEn7QR73+2BxD23WhjEcBuGaUNt0flBlB6IreMgNo1uvqZ5itv9JkEkKoxC0kGSIXNeBK2/acnTChVMCtbSAZnNDV2RGbMiG7dg4oYACp2aDMGt20xuFJvodEnubotO/kSFp54fxHk81eZU1OSrnA5ZleRYK6mn7SZ1dWlidakHkxTCUVYkoR6oT84eDNWrvMgbUU9VsZE/sGzd+i2s2N71FtrMA1gN0r0MH3sBZxdsjrq+y8ldovJLFaX6vClJv0aPKp46+62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ird3BGsZwZpyBdZVqBXAuC8kSBQIGe6SR5FgZBEywkY=;
 b=JL2loiyQTyq+XMe/COQ45NCYc+BRSgq4drI7YfUxWkhUFbBrHiU57yQaYqzUgl1j7GR0R3zUhjVuHN+TChRosUXhtzIZuSEo1Don1iGq2hI6AmK+TirjruvcaYBsoLZPsDbXN54ty7/vM4akCGyM8aDHvYZN2heVFZiSyQ7ZMio=
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:10:28 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::3f) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:10:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:10:27 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:10:18 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 40/40] drm/amd/display: Promote DC to 3.2.397
Date: Wed, 2 Sep 2026 12:59:02 +0800
Message-ID: <20260902050411.3473916-41-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d54793c-221a-451e-b48d-08df08b08131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|30052699003|23010399003|376014|6133799003|22082099003|18002099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: RPwNC6k4ngPJs/uh5vt6hq1UVJlakHITMa6iwNqK45ESkn3oD2xQIDwI+Tv94ccibHkL6/Yvy0M/yk31NDXvdogxa/BfDYDccDM51WSNx/QL1qCd85y184ZrCDu0EH+/J3o4mghavjj0kiuXx84no4mDH/ZcKSWme0cVj46Y2ikjlJj9VNGsbWHmdV2Xr6sGfhAvFCVkxv3xrNodNAf5Zp/Bdiol3JQiUakpfms5e82R03Z4YDx0/w60Z8LgN/da33oXj0JBTJFf9gBwi6ax/w0IqYxb5qebZlfU+57VdEs7YzL5DlhQdm0sO1FuaEg7J4MIK7vm/naAfPurMAxYtDeyVCqeMLuF8Olm1qfuerXV+Xr3f0S4E/nb+38ebjZmR+dSl0MtvxUQxXYg25OBVuNSkDz3Tr8IebnEZDgJ4133sx/TRMltiZ7hNb59+X1b2qPLPOEdCS3yioe9wyqVwWysH01375furEy0SyiyZtkvnMdgoD/ruxBEpKhwmBCSFGeP8kfacH2qzXHj/aNSdbO1i5P0vSn1qUa6IUgK7t1V0C6OCYliW89u0MFAyhH0DOaVO9NgB8G4FkbtRO4TzD9pmGGrLjCDWgr/m633k6Cq5UIbwr522rHGV3MK1F/WtwBXT5WrX6M1IbuUeBOA4ulN1WqVwtlmVLk+Y1DY4/tEHg727cFpRuuiiPVxEYLLFQ0NBfBftCRXsS63tJ0XmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(30052699003)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ifIaLqn1TsTxru5IHahU7w6FdTM2LuRrqqnWR3PWdHvu4abBL3IUvMV0r1PUFiMy+TnD7+CZDe8E0NeK/2VAmrgzHvhXebGwlW7tf+lL26qtVTjFvJvTeVsGPTtoeELKC74IhZ04pHzDSt8Qf/lMB0uzS4a7fbqiCMC1KlbROhqQlWVBmfYmt+bolZX9p6dKosNag1xb8g6rc9uw0/tebRPVRo975w4Wb30sr8vG6JB7+9CDjCdISxoyCu/LEyatfkAV8vxNhs6jdkzTxBkPjFguDuVBs/LgTvS8v9baEK4e4MkV9AUIDqm1TyOjxDMfTIswHL6oUC1/uZvtjQpcT5QN/+gauidlwjYPumdfR7nyUOHvvdzj6N/PLJKyi2biERJl6gatKAvVmz0jNwmYfoHVWyuG/badtmOLm3/3l9+ozB7od1w3elyCnQBLy8/4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:10:28.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d54793c-221a-451e-b48d-08df08b08131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Ensure requested LSDMA bandwidth stays within the SOP bound.
 - Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop the pipe_ctx param.
 - Add an override for LSDMA bandwidth in the QoS table.
 - Expand amdgpu_dm KUnit coverage across vblank IRQ, self-refresh, GPU
   reset, plane update, MST resume, cached suspend state, writeback
   transitions, atomic validation, connector-state restore, EDID CEA
   parsing and DM IRQ source handling.
 - Keep streamclk gating off when enabling streamclk.
 - Remove unnecessary includes.
 - Set mpc_tree_params->opp_id during OPP resource construct.
 - Add override capability for UTM table params.
 - Add immediate restore to FAMS2 for DRR.
 - Fix missing APG registers for DCN60 HDMI.
 - Exit IPS before connector detection on resume.
 - Fix HF-VSDB DSC bpc detection to be cumulative.
 - Fix unused params in flip schedule.
 - Enable the FW locality check in DCN6.
 - Fix DC Hub reference frequency assert range.
 - Dump clock registers in HW init instead of SW init.
 - Validate the IRQ source in the DM IRQ handler.
 - Revert "Fix CalculateFlipSchedule Calculation".
 - Assorted DML updates.
 - Update urgent burst calculation to account for unbounded requests.
 - Add a stressed peak-bandwidth probe with DMA contention.
 - Revert "Unify CalculateFlipSchedule Logic".

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f7511580e36f..4ecd5699ac5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.396"
+#define DC_VER "3.2.397"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

