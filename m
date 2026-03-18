Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2142FFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD4D10E65E;
	Wed, 18 Mar 2026 01:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d66ZLVV4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E60110E65E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv2E79TkcNovdUFlPmfqDr00CHesJMhl3mZb/omBZkdJyS2U1lEBo1u6ldxjeD0NOU2BQMKYQGoYGF4mjHIBqZ6J9MYTyOfbUBTGJyMSIHH7t5ICeNkjfWkmyjJPVaborNEBuoNGg0lCeI3CNtcFfUSIce+nOYHgw3xIqaq0hmTZfRLtzpc6tIB9fogfKMhOLpRSOSiiBU2SlaYKKrDoksJx+3MiEd8zrw9ULVaaiit4ehvGkRzxHNvtd+3WaHiwpo3VGMIXgH7r5hvx5d29oSXNRHBIZXwmdsu9487PFKibHFUXviclNBnpTZYynq31jBOyHEM3YyuFUfaC3MZABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1vP/CK11lFgtiDA+IT5q8Lqvq1upBfbeHp0R1BYt6s=;
 b=veNFFsVx2yWBb0g+0MP6PQ4L+cEp0/Racjd7rOaUmp64B8LXSGzthnpeE+pEKC9On7kD0eSm4APCixzlhWgmIsvgiCy/8KsqdaNuJaIumYVXYgdhSldoWBoGwADLD4x+xC2JvPPd12mksyDIkn+UMQhv6konqdEPRZw9pgFLkOJugNWp5Xmc3rrBz0QAYkdFyTiwo/auN62AW0UTzk3InMwgkFA+yBT98U9xQNs2durJ0W34MK4/EYch43Q+Ymi3bIXT9/zkkL0RJHk2KFf3XtN/Ed8yYZzFOO4e/wL1z6v3vU2nnPoX0oyLBfKiQ8tKjFg69Plc6TOTvkLXF9MDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1vP/CK11lFgtiDA+IT5q8Lqvq1upBfbeHp0R1BYt6s=;
 b=d66ZLVV4Vytqjw0blKz5yNd4rtbA7NVUfnUYR78/5ptjAgWC+42spRVHJnENSdT9AMi9rkAzH0xkRFOb4U6zX4sfIyIjHxdYcfoBH8dveqz+vcdPfwqdUosOzYvMx9a/ZxDgg/2Pw31E1YXD8OXQwt4rPyFN0GBpjmzp6ri1NPk=
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by DM4PR12MB5914.namprd12.prod.outlook.com
 (2603:10b6:8:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:50 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::7b) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.8 via Frontend Transport; Wed,
 18 Mar 2026 01:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:50 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:46 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 29/31] drm/amd/display: Restore full update for tiling change
 to linear
Date: Wed, 18 Mar 2026 08:59:38 +0800
Message-ID: <20260318010224.513094-30-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: a565c9da-c45a-496d-2662-08de848a139f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AZCiuEqLfM/rtcn8yzmJHu05M2DkvWCQ9zM1v/40LaG1h5MYW+45P1CqNkyp1So6AtU0TIZUXKzZgWcESMkWDjMkHtfm8WE0LB2Y+bzs9dWNAE2QojG+CxXq9FWWmQtU+vNwkbggr5UfTNUkCOZI8pajyC1KboKsQikBS8YHgovx3mKMGMK97Jx9299phxJGB+g7bxkfh5f5WxR3OyavxRyNLlBFpAO1CBgu0fCqamIZ5HC0/i/xhxWYoSHBUw4DHLebzH1c98qjeMMOCF6IN7ogYxxXptDwxwEyzsWxzoPtlN57IzxGNyvXfu1sInCLG9YjhQ+mqjtONwQO9g3JoCjk7a0EKAsLdTFDKvZ4pZofUSLPt8TH9bgkuNMRqwkDn1dTMobXOj+valI4t418YJazrBsCfX7tpIidvq0LW/9hsnzhcAMk12WZBLwLaZLekziJZJkAdyd8NKK6GEgO7tCApIZJEZPuPdvJZaF/xIPE1kDRy4SgrpwYOUyaBJwBuvE/TbQtNPzDYiN+0pRYyHXDJGz24uUn3vfZ+R9NekfLhC3xLOfrQedM12fgZqlt5oRo+VTs77vXpJFnI0cWF7XPMfiMvppBmEGsYRlV/SNrpDXlJ3pS1JQR3CBXsGZYxhAaygXnh94ekOk9DyFwGZ0C67dyRIEZDyek8jAMALEabB/CAOw9Fo5nhAzhNVXZwabHzOvdoEf2qPc7bfakSyD3aaOgxbfnfQo/w6xyrfKxB2dMeDFZmfPrpJMnoAOfMAyjCBhfyZzFwVy+pJcIwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xT4nJXXxker+g1lxUfPbLlWIjxp2s2NAcqogs0vJzN7BQshd2tqUAMtiy5RUHGLRagpM0w/Wjv8pjE9an0gk5eL7LTAigPpnRacJtwUCuLhsUDfCL/NAbggZl0+W3J99u4Iox5FrKs9M0ieQujv+QDBzrdXLzmzZGsGUjszizkHuPxfIMTkoRz/asYNC/kIWsG6G8ie/NldT+k6pLXSsSVL4xq5+qiUnEtDh75Vu+xNPsotQdXDecZ4DGip7hHPRmkh8O+7BXBAfZVof1dOH1WOW1mCn55ojltG70XG5QA1Aks8S4WAaFAqaLlbuv5ariu5BTzkNEWrFMvZAFZQPOI9GKzUSbTqAkf5YU+Df/OOH65+kK8EJ6W6swlNKrgHIMZkIy/lbxmHyr/eIx5Hkf/K20ZnCsqtC3Zb+OHqLI0p4N0dN6fUI4vXILzUDasxA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:50.2426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a565c9da-c45a-496d-2662-08de848a139f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
There was previously a dc debug flag to indicate that tiling
changes should only be a medium update instead of full. The
function get_plane_info_type was refactored to not rely on dc
state, but in the process the logic was unintentionally changed,
which leads to screen corruption in some cases.

[How]
 - add flag to tiling struct to avoid full update when necessary

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c     | 26 ++++----------------
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h |  4 +++
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index db74f088705a..8b21816cf7c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2770,28 +2770,12 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 
 	if (memcmp(tiling, &u->surface->tiling_info, sizeof(*tiling)) != 0) {
 		update_flags->bits.swizzle_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 
-		switch (tiling->gfxversion) {
-		case DcGfxVersion9:
-		case DcGfxVersion10:
-		case DcGfxVersion11:
-			if (tiling->gfx9.swizzle != DC_SW_LINEAR) {
-				update_flags->bits.bandwidth_change = 1;
-				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-			}
-			break;
-		case DcGfxAddr3:
-			if (tiling->gfx_addr3.swizzle != DC_ADDR3_SW_LINEAR) {
-				update_flags->bits.bandwidth_change = 1;
-				elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-			}
-			break;
-		case DcGfxVersion7:
-		case DcGfxVersion8:
-		case DcGfxVersionUnknown:
-		default:
-			break;
+		if (tiling->flags.avoid_full_update_on_tiling_change) {
+			elevate_update_type(&update_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
+		} else {
+			update_flags->bits.bandwidth_change = 1;
+			elevate_update_type(&update_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 9bf853edc46f..595e082db281 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -445,6 +445,10 @@ enum dc_gfxversion {
 			enum swizzle_mode_addr3_values swizzle;
 		} gfx_addr3;/*gfx with addr3 and above*/
 	};
+
+	struct {
+		bool avoid_full_update_on_tiling_change;
+	} flags;
 };
 
 /* Rotation angle */
-- 
2.43.0

