Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E1CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC4810E6FE;
	Wed, 22 Oct 2025 07:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZyvMmtFK";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D71110E6FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQhBBa+eBVgtStkAs/hFd5MNh/TOVcHy2GLBDTSJZRGf6eaV7J9y32Kww7m93CmW/knES72D3Fh8UcQ+6CXztfhnVAoE6d6YMMpQVNFXU2qLbUsexFBEYajDsdi8LssDONoeuWKlFSlK2wDHzosVcXxg3ygcGciLoJFubQB39i4ujAB9THRitBfFO4N0hezBIn/qHQgK6Kvm8bdm3aRhqoTUaTsjUarIu8+frySu4DXm5PXJ1rJ0J5xJ1Wsa6HqnvC+AOisDbEY/m1CLTVC3VRnkhqgylRsoCWFKcWCRmfM0PEzUTZn5bLA+BJcFD4eMVXZm0Zzo18NTe92M3sWPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFWKcDktOU0cKAK2NrtpzMIBk/dg761gora//V1zQvQ=;
 b=X6yQSp1a3qzdH6cSaDrQo6Fr21F+5AktCKzVfl8TIjJxFOwZHlZ9AZn+n89X8BLi1bNLMIO2yoBMAwF2e1966uxJPEP/nLWyXVz78PNMc8+UWkDgISy5GiiCEV4j6xHmjP+iH7ijAGuUGrEuaYsio9ZIguaUquFQAQMqUTyt3Wp1VpFIO6OnqPxPIVOWNaz2jRU2SMFUn23kidQn6D2QiCye0zWLZhMPNtTW5wG3o9hBnbmfyzZf3ul5MAegq7SnvEytpaMRLnrgAuoTcxjBoKJIhOhahUgJLdq9PfxeF9W8Qe9eQS+wpa73FqvYQXulJtdOU6wniyjaEdMAdBpoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFWKcDktOU0cKAK2NrtpzMIBk/dg761gora//V1zQvQ=;
 b=ZyvMmtFKxl3woaW7WEhdK8t6GdRWr90gyr3P2GR7FQYVzYWXGCE6OCX1qQWAuGXfQ7WDkI+Etf2yKt8VWTxonhzx4jvnQ2sIyMupz6VMGAZuK1BBkfjQjvRogfxUc+2zaNOmi0iUgasJg5IvAtbdgWWpg/trKoNjB0Dq9gYzgf4=
Received: from DM6PR02CA0133.namprd02.prod.outlook.com (2603:10b6:5:1b4::35)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:35:18 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ac) by DM6PR02CA0133.outlook.office365.com
 (2603:10b6:5:1b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:01 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:00 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:57 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 14/20] drm/amd/display: Update cursor offload assignments
Date: Wed, 22 Oct 2025 15:30:26 +0800
Message-ID: <20251022073332.666119-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 9796a0d8-0fd0-4b4c-1185-08de113d8ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RczEuaOty6BHEPbmN0bpIbAYykL6bSZV8OmSa4tl9GPO3mmZ5vQEewUVpMlx?=
 =?us-ascii?Q?SoTtxRUaCebVP1Xsw64KFlwyco/IsezkUs59xKfktWlDtyywjGOLt6eF025l?=
 =?us-ascii?Q?ZjA1ch0msE0YL/sb+YmPh28t/TdGIGpPz+na6FWHQZpf6JYxvwoO5mPKUtu7?=
 =?us-ascii?Q?pzhUfprXpoEIFriwGIsvIHG4vdvAwqlAJXFzVJpl1ifIpUyJV8dgCRfc18Sf?=
 =?us-ascii?Q?IntvI3AJHyW1ckW2jjxsG9RG8pwMBwqd85CmEsqqbWfFQ6eXFiK2InpMUuHw?=
 =?us-ascii?Q?f+BZrOIW9XFJ04P5oQoBhwU8/+iUCBOeY0p3Y9OsDIMBar7oDIDv8PTucJ/5?=
 =?us-ascii?Q?gZv/oASwTNCjTv+Z7c2nT8rBHnsPVl0o+NyDECrIJM8WhzU+PRVGa7OTqBor?=
 =?us-ascii?Q?yyol+4iN2cX3zpVc1qvxO0yFqy00GPO0kcUGKyR4VTpEQ4lBIhXq6nfrNS02?=
 =?us-ascii?Q?KrPdu7MKRVakol2DkA6klARJSiXKwPvuW+vVLJBxcAtENm5/E3IL9hr60eoN?=
 =?us-ascii?Q?ovby6lpgJ+nTpWDeKOMjzYxkk+8pX6BcViPh6rsZJutUouasj6uMsFpWDR6+?=
 =?us-ascii?Q?e6t3MaOkMfCgc66lQb+1N6j/ogFUa3qSkfJYyESf82ZXzKH4sh9cT3sGBlmz?=
 =?us-ascii?Q?yY3df1CAAHdCYEqn3nFnOMyVEqW568P4WV1pBRdB3OAtfVfUezVC5eDgkODj?=
 =?us-ascii?Q?gjBWtMb0gBqm0cXhvEkJyqRBWEN6AzZWSqbNPIeFgrU5S9qallBKvZ3JZWiL?=
 =?us-ascii?Q?R98V3XlupXrTfXVM5xzoLAnuoAG6roofAJSjPKhH3hKFCfHSfN7E2ms31sLS?=
 =?us-ascii?Q?rOIRQcA1NJgouQ5FBrWxgVyg0S/qPCIA4wrpt947MJ6OHDitQ8ye9vBVAyCP?=
 =?us-ascii?Q?jRIo2I8808kYFNS+Hertq0o5Qr74Ma7Bki7Qlt4Fxl+o9N2SCbmP8PSgLEn0?=
 =?us-ascii?Q?XcwbEzqwK8COuKl5/wK8w55vfTNva+mO7bSeReL/ynMbhJnRJ94qYFcvlg3s?=
 =?us-ascii?Q?swlrClylunlwMiloNUwntP+amT1LXB+fzeu+xIGD2wIWfuIavX6FlxNVdUJe?=
 =?us-ascii?Q?Vk38G0ASNw7ymYJL8JTlEOlWB7CtjE7rDMy4wW56Ggcxv625xxi/NOxYr3Bz?=
 =?us-ascii?Q?QMmEHFpeGFey4HNimeYd9HkViWno6IrdSqk3ETi9LZIt1/7ClFMC44kvNDJP?=
 =?us-ascii?Q?xKiLojgMgSGoQPxtLsdLM+xwtFhV1tw7YFma6aLRVOfj46Un8xlhUM7nuMEI?=
 =?us-ascii?Q?4bxZLO8X2JOpKDw3JAE5C72Pts0LMPsM50OB5d6gEig6Hf/b4gMoKeB16Kor?=
 =?us-ascii?Q?jl4YLft2fjRSMzFThnyE44IDJhcTXvr+DOvs0Epel4LSYPrlm7eg5033Av0k?=
 =?us-ascii?Q?2v+sB+wSHYp8aUHguowbmxefkxx80dnIOKBFlgiKz9Dp3++VCTGlRKFsucvU?=
 =?us-ascii?Q?FhZocht4frYv1yjwPemTAtUipPhL2zWDgzvYp+s8deDHqyPeBtKWFEznPRnw?=
 =?us-ascii?Q?wSEdihm305rkaVPj0LQq0fRT95hy2p9FSwuMqzCRSabCiMoPmBIKFKcqm/ml?=
 =?us-ascii?Q?LnwfHuNYvW69rL8qaEb/1yGMc5dXNcn+qDh0+JI5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:18.6761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9796a0d8-0fd0-4b4c-1185-08de113d8ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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

[Why & How]
- Cursor lines per chunk must be assigned from hubp->att and not
  hubp->pos (the one in hubp->pos is unassigned)
- In DCN401 DPP, cur0_enable in attribute struct must be assigned
  as this is the field passed to DMU
- DCN401 should not program position in driver if offload is enabled

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 24 ++++++++++---------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  2 +-
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 3adc17f2fc35..62bf7cea21d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -141,6 +141,7 @@ void dpp401_set_cursor_position(
 	}
 
 	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+	dpp_base->att.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp401_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 3a2e0848173e..f01eae50d02f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -783,21 +783,23 @@ void hubp401_cursor_set_position(
 		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
 			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-		REG_UPDATE(CURSOR_CONTROL,
-			CURSOR_ENABLE, cur_en);
+		if (!hubp->cursor_offload)
+			REG_UPDATE(CURSOR_CONTROL,
+				CURSOR_ENABLE, cur_en);
 	}
 
-	REG_SET_2(CURSOR_POSITION, 0,
-		CURSOR_X_POSITION, x_pos,
-		CURSOR_Y_POSITION, y_pos);
+	if (!hubp->cursor_offload) {
+		REG_SET_2(CURSOR_POSITION, 0,
+			CURSOR_X_POSITION, x_pos,
+			CURSOR_Y_POSITION, y_pos);
 
-	REG_SET_2(CURSOR_HOT_SPOT, 0,
-		CURSOR_HOT_SPOT_X, pos->x_hotspot,
-		CURSOR_HOT_SPOT_Y, pos->y_hotspot);
-
-	REG_SET(CURSOR_DST_OFFSET, 0,
-		CURSOR_DST_X_OFFSET, dst_x_offset);
+		REG_SET_2(CURSOR_HOT_SPOT, 0,
+			CURSOR_HOT_SPOT_X, pos->x_hotspot,
+			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
+		REG_SET(CURSOR_DST_OFFSET, 0,
+			CURSOR_DST_X_OFFSET, dst_x_offset);
+	}
 	/* Cursor Position Register Config */
 	hubp->pos.cur_ctl.bits.cur_enable = cur_en;
 	hubp->pos.position.bits.x_pos = pos->x;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 9333b7fde3bc..7aa0f452e8f7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1699,7 +1699,7 @@ void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe
 	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_MODE = hubp->att.cur_ctl.bits.mode;
 	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY = hubp->pos.cur_ctl.bits.cur_2x_magnify;
 	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_PITCH = hubp->att.cur_ctl.bits.pitch;
-	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK = hubp->pos.cur_ctl.bits.line_per_chunk;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK = hubp->att.cur_ctl.bits.line_per_chunk;
 
 	p->CNVC_CUR0_CURSOR0_CONTROL__CUR0_ENABLE = dpp->att.cur0_ctl.bits.cur0_enable;
 	p->CNVC_CUR0_CURSOR0_CONTROL__CUR0_MODE = dpp->att.cur0_ctl.bits.mode;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b9c357a40707..f02edc9371b0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2996,7 +2996,7 @@ void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pip
 	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_MODE = hubp->att.cur_ctl.bits.mode;
 	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY = hubp->pos.cur_ctl.bits.cur_2x_magnify;
 	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_PITCH = hubp->att.cur_ctl.bits.pitch;
-	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK = hubp->pos.cur_ctl.bits.line_per_chunk;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK = hubp->att.cur_ctl.bits.line_per_chunk;
 
 	p->CM_CUR0_CURSOR0_CONTROL__CUR0_ENABLE = dpp->att.cur0_ctl.bits.cur0_enable;
 	p->CM_CUR0_CURSOR0_CONTROL__CUR0_MODE = dpp->att.cur0_ctl.bits.mode;
-- 
2.43.0

