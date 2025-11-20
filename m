Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76093CF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B92410E7AD;
	Thu, 20 Nov 2025 18:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mc2Ynjv9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A6B10E7AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0HMI0y7kDWqX36n7xUWfAKDq6Eb9kLtM4J5rFN4duwiIP/OXLAAlNDbAvQ7DEaXocek40FuS4EzQcaY6+UzR9Vkh40mN2PXyZqPouBcg+Yz4jds6I4AQfArN8j/5PdbROgROgrRfsXcVAcj9dcKTqU98MKRGC18g/uVbCjBCM9wBi24jKu7Sg3I9WzLkmP0wrdixQ1fflhxkBomMPsKb4nVXZfZtN10czOLNvtnOoJuaPOz7QNNrVOMJk7bSp0iu0gHUI2qtPrEWXOfzy7fBRPO3jF2+cx7VdvO+l+ILQCTl4MSEMAGgtYuoZhPyTvoUgQ8dHvjybxL2Yn/X/c8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tguzdtsb5EOPmpW1Lp63PuSqmtpGBMTaG0sMdXfOyxI=;
 b=e7Ta7WZwj6hqKLv0uaCaZwHN7QNZIduCeSizb3nbKnd6U2R3xtpKJBuPHVwqYUzgixqBCj4BHx0Ts0kfeq7fnEdM//M05zy10D68WY7aTJ0+dig+NApQ65oqg429gotNiaULR4V5BwmSwBbOvyxko4JG/gjdpHQ7w617caqX45ZY31UnS0FXRyIDOZk7mAo2QH0SXBWMw6dqfoeO3vM2OD37KxKYtFW5THB+PuNbje+TZATrro5lHlWiYBkWm+AYt9oOEQgwnT4wEJsKPyqr4O3OMF/VcJlVsfNqz905JzrYEOwL8sMkwbbUvQ06tysJTchMlY8kKLuALnBPMt9cJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tguzdtsb5EOPmpW1Lp63PuSqmtpGBMTaG0sMdXfOyxI=;
 b=mc2Ynjv9SNLfAcOfdepr3Ee86qCOKEsp1VqI5G69wcbNgea1CWqBoSOVbDVyppxD42rR1e4o620zMCJ/+k130oTMIjwzVFh1PT36EsWbqj2l+unB6nz1GbKr42kuttefqs1/tytklj1SQZjWRI1Zt4DxO+KGY8m1qQpMSHVF+q8=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:17:50 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::e1) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Thu,
 20 Nov 2025 18:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:17:49 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:17:47 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 04/26] drm/amd/display: Add AS-SDP v2 support for eDP feature
Date: Thu, 20 Nov 2025 11:03:00 -0700
Message-ID: <20251120181527.317107-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e42655-3073-4206-dd52-08de28611cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ELDHd3n2OI9KKQ5+FR0S8dT63/G6Znu0w0dFG4qH55UlcMKXhGgLCxNkV1Jj?=
 =?us-ascii?Q?NKBJh/J5Sp6BSBy/mkOgG4/sXTxgzPYdFrQi3wUfFmDKoBfvLc9KA8FhyWHY?=
 =?us-ascii?Q?gUMpRA8jIi/0pddmBu9A3EXx8L4cdo0iCJd195s0+qis+jUkNaiK5j9672El?=
 =?us-ascii?Q?rAFI6EhYmju79B7McW6PQ7XVDUATyvoehX0MiRXnXiDGEf7u82ilDXbwPj5T?=
 =?us-ascii?Q?3sPnrmPOpxzFg/l2w3k+pIrERQSa8eoW8Juo7YH1wxRlcnvd88a5R93fC/wE?=
 =?us-ascii?Q?hrvOy/pXHMAYJc9Y3WdUYsPzvGDw+p29XnZFwc3ti6X8UA4Qsdp4dkDDHqx4?=
 =?us-ascii?Q?AObifmIpNfFu9EDsAjxV6jK9b3HVLa+AUwYSeGPJ/zF6DOvGXMAECGL27YyX?=
 =?us-ascii?Q?JhGDahzZl5Fin+OBEaRPZt52B8AqLc3LQ1ZpFpdk+k4dIpWLMBjRq74Z4dQW?=
 =?us-ascii?Q?/JWz+FKZeHRp/ZxA6p1ymnkr4DuGPIfGYl2oKhWAp0wUfxj96dZEz1z2fPSI?=
 =?us-ascii?Q?U0x/5NA2zlEGmhvYka6ENibdUN+BkSWSa2S+uAgYZoFeHs9VQaH7rfaHCjjR?=
 =?us-ascii?Q?TaBkAmHg5xMa2khs8kpp0lY5F1TwpAaoJSkJL88XKEIyaokD3hL05/1fINIm?=
 =?us-ascii?Q?75GckSEfaHV6EN0MBcbnby+jank9ORoy1Gpuktj5gdaRQGQMNfsv+SriSwS6?=
 =?us-ascii?Q?2etxum+PI2T75hQJbhvDQOxDF9PtJRgZm7W0V0PJI9hb8FsXS8TFc29MU5vK?=
 =?us-ascii?Q?jzBKje7Bx09+YXAF82j2lD8F1uxqNZ2N2lpcZ4GnMw4w3kHnUSaCZxRkzP52?=
 =?us-ascii?Q?SNxHyXiSk5AbHPjaLSHNEumQVWdKy+Lh92UEe8LSIWgQbVroSp802snP2jm5?=
 =?us-ascii?Q?MaseBCVxyytMHwFn3OaxtvKP+hWziR127mtOtbzjUr3vR068JkQNQN4JCqO/?=
 =?us-ascii?Q?1DLxoSi9y5gpGrZSTI39lgHQyAAPJ0HB9asOeeKIbjnxv0g5VA6GTyWomRcm?=
 =?us-ascii?Q?MynkSa23yjcPJ12hPURJ8ml/1TTOZ2ryBZonJw6/Ej9+5eMSPuFAuLMGibLg?=
 =?us-ascii?Q?i75pTqigXlAgUQXAIrgJlMA/3Jy3k33k21AHGg+ondoNJAt5sgDq14NeIvPH?=
 =?us-ascii?Q?vCUZwIPBEAkQd277Tk/DjdgXGsgMqwEIiqOUFiWqjtqYkcBfzUHN6nVw81VO?=
 =?us-ascii?Q?wgmY8DHqetnAry9NHYQXalPcyPz7PYSPKX0+na1HegsXwSh2E/hHH5dWdoZu?=
 =?us-ascii?Q?ZjPuLtMCYzr7WOqUHWud5FAnacZQsg3Bj4TLtsMDTZsrer2FnngKvd7+WL6n?=
 =?us-ascii?Q?uU42FcXbd8h301lIKzNme4UpcLGVxI8EIE9hqcqPqhRejzAimYtIotP5uuCn?=
 =?us-ascii?Q?lHowhgntKC+GX75XMjEmbH0LN780yaBCIr0inZfGqD5buYuPVRJTEnRU2Si+?=
 =?us-ascii?Q?f0TeyE0uGmZlvkYWUhHtlb5SYefRjcI3DielGHCNd7btzvnI/AH5v8VmqRJI?=
 =?us-ascii?Q?fgZAGGENE9XLAPwW+qsufBYIqEnlH826+NfFrzFMrBgURSoi/UMeHIxW/bt8?=
 =?us-ascii?Q?hmmONlM8YsuYMnQaBzk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:17:49.5723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e42655-3073-4206-dd52-08de28611cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

From: Jack Chang <jack.chang@amd.com>

[WHY & HOW]
VESA Panel Replay requires AS-SDP v2 support.
Need to add checking flow to enable AS-SDP v2 in this case.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/modules/info_packet/info_packet.c | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index b3d55cac3569..251b7b6f45af 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -537,7 +537,11 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		break;
 	case FREESYNC_TYPE_PCON_IN_WHITELIST:
 	case ADAPTIVE_SYNC_TYPE_EDP:
-		mod_build_adaptive_sync_infopacket_v1(info_packet);
+		if (stream && stream->link->replay_settings.config.replay_supported &&
+			stream->link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
+			mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
+		else
+			mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
 	case FREESYNC_TYPE_PCON_NOT_IN_WHITELIST:
@@ -567,13 +571,15 @@ void mod_build_adaptive_sync_infopacket_v2(const struct dc_stream_state *stream,
 	info_packet->hb2 = AS_SDP_VER_2;
 	info_packet->hb3 = AS_DP_SDP_LENGTH;
 
-	//Payload
-	info_packet->sb[0] = param->supportMode; //1: AVT; 0: FAVT
-	info_packet->sb[1] = (stream->timing.v_total & 0x00FF);
-	info_packet->sb[2] = (stream->timing.v_total & 0xFF00) >> 8;
-	//info_packet->sb[3] = 0x00; Target RR, not use fot AVT
-	info_packet->sb[4] = (param->increase.support << 6 | param->decrease.support << 7);
-	info_packet->sb[5] = param->increase.frame_duration_hex;
-	info_packet->sb[6] = param->decrease.frame_duration_hex;
+	if (param) {
+		//Payload
+		info_packet->sb[0] = param->supportMode; //1: AVT; 0: FAVT
+		info_packet->sb[1] = (stream->timing.v_total & 0x00FF);
+		info_packet->sb[2] = (stream->timing.v_total & 0xFF00) >> 8;
+		//info_packet->sb[3] = 0x00; Target RR, not use fot AVT
+		info_packet->sb[4] = (param->increase.support << 6 | param->decrease.support << 7);
+		info_packet->sb[5] = param->increase.frame_duration_hex;
+		info_packet->sb[6] = param->decrease.frame_duration_hex;
+	}
 }
 
-- 
2.43.0

