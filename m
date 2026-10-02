Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7289CA5FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4066610E6AA;
	Fri,  2 Oct 2026 19:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qQDwTxiv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC5F10E6AA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBkxwmiMXz0mTp/6Rq475xVyTCnDiSUae+4+1WTBpDTLR6i1MnvwrrbIUpkW6TzRGG0ksAnzSwn5qiH5U+hcQPKig4gdEnrrwzrAcC7h/FeNJ+2T/04Qqh8QWBFxQ9w4AQjOUv7zpVxnSq2A/gn65MdYpDFiAOAQ8TWNkHEKV+yd9Lk7q+dILyAbdBBAbDunGlhOT+/l2wnSE4oksgvWed5yUQUJW46iX+87oh+XaAzdoPMPjhhSyPCTstxORlkHsym5Hg9TFKLpJK4gDaAD8M2DTDsFAR14pfMRudp/NAQXOhoyfqtYiR+ZnKbW4TcKj9w3P2bQqCyTNEfg+qqJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl1I5y3UAgI2ciLtLAV0mIgvObofGooqwZCF5vAXm1U=;
 b=hGhlxrjuawuGGtQswtquGi57HMh/yzN6w6w1fzBQsKalkJxS5M7Jfr6JGfmkqUjYoXV4oae7cbGm6myuem1Y29SJIaqp8KOaV8LYnRg9pM8M15xRHKyiF906zejnGxhFNaZ7XSNPuL5NO/QJQRlzNOvyXK8ajZ+BZTkwZdggPijFTvqulrFUP88VUhHlOHuqC1RqHf+Sr+Y3uXSf6W8gE91Kh15WYqwywMP+lWLHRkjRvptyBU4yQGodRzoCOhGptocClH6lZS4kwtLWVl2qxVkCCphAt89H4SpVee95Ogghldo2DH5LL2ThJKozidHFia7S/OZgJZj59lkeylBozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl1I5y3UAgI2ciLtLAV0mIgvObofGooqwZCF5vAXm1U=;
 b=qQDwTxivi4z5AbiZftAg30YSXVdC0oBZsxVhNjIFSJNkDnEHjxrXZ1oqpti/s3WEHtpobODnuXJEwXhKRNpSRw41NFtV6f4dSoYNE0ExwhwjP7kTRSKCptsji0TqKahpIr1dPOKHxdr9lY3TNsv9Ku9IkW7d99aIFOMUEaFJbxc=
Received: from CH2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:52::25)
 by IA5PR12MB999278.namprd12.prod.outlook.com (2603:10b6:208:603::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:33:15 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::86) by CH2PR04CA0015.outlook.office365.com
 (2603:10b6:610:52::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 19:33:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:10 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Allen Li
 <Allen.Li@amd.com>, ChunTao Tso <chuntao.tso@amd.com>
Subject: [PATCH 07/17] drm/amd/display: Skip link off frame count for general
 UI
Date: Fri, 2 Oct 2026 15:32:30 -0400
Message-ID: <20261002193240.3441018-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|IA5PR12MB999278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a665609-8fc7-4c54-01b7-08df20bc00f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zPmXfim7l3PYubPcwq9oUgjJJcTtx/R8cwcynLZVwcbGDEy6qyZFXXYlKMJ9eFo/4olN0fvU5g1QlmRQiVE9i7aW0fb4iZxyevICnRhH0TR824+KIO3ZgndT44TUfWnKAFvRkmAoX9j//PpnrPAaM+JEEq4bMN6QJNYeguagFUSgA68lXOberTz6+cHK25GZ/2siuOna3e8VocaaIJGBBipQPoL23v0TgZzFsCCKs/nsllMp6rN+tKSmSiz2WlWsPFAiBKKs5dRLxilP7LYx1TQe8hNtq6rtyyvpD8sVEvWAFmBIjkU3rjPV8J7RnO8DCogQpGX6V78H0a7FR5BBWAVo4y9GKXGhDwI+r51BXsIjaILeNa5E4cDFQKhz86raBh7oWeD2fbk5aTnW2VNKVn0POx6YFAdzp/VECaAaVTBWj7NffqmmltAzzT4bu53SS4spOI9CA2ryKqZ7na9PKct1yEwqxO0ftO+mkjNYfSo9jPka7Y0Ec/zT2XpK+NUAFy26kIKzS5+pzeCSuAPK2Y4OA20kEs15AQwmmBI7bKgAkq/LynL3foP86fAB4NKp4dxr+5abw3Rjh94Gx3GJL61mfDcsvTMbDjQ6s7lHnB4wxMRlXVRyO8KVgAAKwCmZU7eTIA0/uGHLmeHZ8ac0lP5dbGPkCFR2QjcdD7+KbWrJ6Wl8oTXUTKwOseUo3MY3Pk1a9AUw22WhWF3QCJKtJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xFRlS6sQkcqokOTKMiWr6t68gLHTm5RJAQM21pcv24bJDadzue8GGcP+KiBBC5oZER1Y3yUgWleS/4TSDm7eKpp6UTuuUc5u0ohyV2Vt0Z++DuU1s2LkfmFQnv48jMxyW0AH9bZVrpDTyCrNhstxX0K16renwe1v1+jiees7msj6It6c6qFCFOoXn11P58rg0TtiW0Kqe15Fkpl6aHWxyPApKuuLhY5rYHIxXOQId3bRznr0f+qW2P52XLymMrCAr0O9q493TtZLmxjTHlEqLSdLUECtnTgbq/Ri4z7ROBMwSthpx4+pWghnU1hH2ELSGffIFaUwIRa6AYg0V+2iYhLojuHU5NrrG32jhfmm9Jq55Xq1IXCvdxT5PJrQGrW9RQk/Em5wSYYF9HdE6Yu90eY2LVF0aZbKmxawYYmRxvFKw8lu5J6jSr7goVGVHodp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:15.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a665609-8fc7-4c54-01b7-08df20bc00f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999278
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

From: Allen Li <Allen.Li@amd.com>

[Why&How]
To improve power saving of Replay,
skip the link off frame count check for general UI in DC mode.
Also disable timing sync in the same condition.

Reviewed-by: ChunTao (Chun-Tao) Tso <chuntao.tso@amd.com>
Signed-off-by: Allen Li <Allen.Li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                | 2 ++
 drivers/gpu/drm/amd/display/modules/power/power_replay.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 7ff2152ff233..af241b2bd29a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1311,6 +1311,8 @@ struct replay_settings {
 	uint32_t replay_events;
 	/* Last ABM periodic keep-alive FFU allowed bit sent to DMUB (VESA PR) */
 	bool last_abm_periodic_ffu_allowed;
+	/* System is in DC mode */
+	bool system_in_dc;
 };
 
 /* To split out "global" and "per-panel" config settings.
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index 7861e46c612d..666585b7e00c 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -338,9 +338,11 @@ static bool mod_power_update_replay_active_status(unsigned int active_replay_eve
 
 	/* General UI scenario */
 	if (active_replay_events & replay_event_general_ui) {
-		if (replay_enable_option & pr_enable_option_general_ui)
+		if (replay_enable_option & pr_enable_option_general_ui) {
+			if (link->replay_settings.system_in_dc)
+				link->replay_settings.config.replay_timing_sync_supported = false;
 			return true;
-		else
+		} else
 			return false;
 	}
 
-- 
2.34.1

