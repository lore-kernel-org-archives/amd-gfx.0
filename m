Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A7FC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E2A10F06F;
	Wed, 15 Jul 2026 13:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JEGTZVd9";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4720E10F06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSd4cYdBRGNxxMpNP6YFoc+Zlwq+uKE8elZEI3OwKOFQykx35xts1Q/gJBNLew3uP9iJCxNNQq4hylSNCP+GKlCzsp3fDqia1j73V/NS0NTV2eTXSx23KdOlW4nJfOjIR0FkbRBFF37jYsuYnSjy7Lf0gktJy+WTMOQPusR+uptZ9l7SucrT4o99dUOwKEXI5QusWajRig7QFlaqbk4Jv2My7pqljFUHqZQGVx43MLYSS8ivQpxLWTbN/KqJ/gcliZZXN8igFvw5yrRoX9Mv9Z0jQhHiq34jlYKkmMPWuLe3h9oo3b81FlUp2nq3fv/Z12SOfZ2fs5MAnEIoL6cGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYjEO/kWkr9Rk8SKBfk42ffEBASavxvpSpxbhiI/EGs=;
 b=QFfTuBJ0nSTGwGoEbP2WeEoZoJjy0dlgKX0saMVxQyNclk4UV4/h3EMLCc8aslSC9jP+mEO5VUwyDdvlHdKd7vL4AVLxTFn0/ARYQj+Z2BctV55G+9ouQP2r2K05jcXlRONXpaQDY0rx6BY/34Ma2PykSRGUbev9EosBUY8h6Bp/Uo6dpcPvoLtNYsbtzwliE3+z1aMadkYzO0mtyIxaqF51OcaKQiV582ea449L+Kf9oV5w08Rllnmte8xNV+JV2Kmty/nqOB93tDp8iJMEEFj9ZPvXhafLQMzLB7EZCWX87B0GdV+JQa7jjChXzjLhBFcdgztxhBcy2TSyKwQ0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYjEO/kWkr9Rk8SKBfk42ffEBASavxvpSpxbhiI/EGs=;
 b=JEGTZVd9CSRdK9u3h+RRtCX6q39I5tEzfCEm4MWOpzlkWzytKs1PvRHVM8N8LaJOUpwTtffUoVouQYj9xTxXuZSih+G1e7+W0wj/U9aM75uJu5q6XjwIyWx2LGvOSUAUAnva+TRueas6zb9gxMgfp48e3G2/fgqbMRQomk4U5iA=
Received: from SJ0PR13CA0094.namprd13.prod.outlook.com (2603:10b6:a03:2c5::9)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:45:23 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::30) by SJ0PR13CA0094.outlook.office365.com
 (2603:10b6:a03:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:45:08 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:44:59 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 04/70] drm/amd/display: Increase HDMI AV mute wait from 2 to 3
 frames
Date: Wed, 15 Jul 2026 21:37:14 +0800
Message-ID: <20260715134432.1975118-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bde8ee-d81d-48da-000d-08dee277514d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|3023799007|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4v69cv/okuxHKjN8igBw3xOOUPB9mjDw75iWUGEj1ltHxYZwtFaYv7AaeR2g0SaXudRbZvcoLStQh+sbcL/KE/kj0yq6Z385tb9/pPgHWKfJ1wogBlL/mNLbFFZKBaO41UpHFJa8gGAkqocwY0/jkCyIv0GZSOuvtmm1EI7ZPMIunXySiez407RJwAB6DLr3e17qxb0pFg+iVhuuUcsRVzO40FSXAIf432YkSG9RFR5C6G1mjL+9NgGsddbg2SOuhbngROJwpd1jvIBlROFOASKKRCcm+F/ytp3kttPgEiW+zl2TI2FcT+VbxyWpq2ps3QiAezSnAPkiEg1cwfrUB1vNCTZaMJXCBc+eZslmjIUYONXGtjIOtV1FbJ2FGl0hGeP84blsdNqoB7dFd6FcHspVpa3KUPiKzqUJrc3DGM5GmIqMLXvWgMD1wrTcYDdxXNDwkhW81KDI5OrGzYaJDIRPRvTQHaN9PXjUWr+bIWL+dC7sBXZKv2EzDs4lcrbmOSDMrg8wVoRZ8mltOEEvFXueDKLRi4JByFSbhmHUF5wRmhWJuFtYQiFPzYdV/SYnedF6G/3A0BnpBAKM8CTrGHqJwiAhmNapXWuq3vnSSaMzug5lzdat1ivLaNDEqCf2trptm7F3gVgKsfwoGgCK7LjnAhk/4DRcuYAQ/VUYPOl4vmKb/JmQUTyc1E3pfAxvG4pTNwIAR2+DB9AlL38AGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(3023799007)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oVr22qsa1xZmiUxyW7ZMmgjPe+XHDzkDmm/RWAGEgXdLWFdm7F/NSRVhpXF5WG6LkZQ+uFfEbju1G9+RmywCfSB8moWuCIOx0phXhv3by2HQV6INgY7WAhrb6jDnB1W7bgfiQFwsVaoWj1D09SY+tjI/izPSvh6AGoBwngqvp1gKEkFxQydKWWFVJCGZUPcg0jQhsgWqeV6u2X7yvx71I0f/sMUJ7wKd30s8mhk/dzxfQeiqcsH8YTmay3+QBflVZr4IgWhYV0XO7+K0XQoLpvucw76+oQSpsyPRUb05VaVX5iMr7ovEenjvQKY0uBN2hE1DgGY6ktA4DmgxhkT/mG9AzSy4k6Jh1RpiwydcyXuQQMFbydgZqw6XPgzD9zY2jKiibBoCu1ubolFgmfFOmzSxBy0g1N2kYQu4O9xY6T4LJC2USzg1WSl3dRHXvbu0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:22.4917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bde8ee-d81d-48da-000d-08dee277514d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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

From: Ray Wu <ray.wu@amd.com>

Some HDMI sinks need additional GCP packets to properly process the
mute state before the timing generator is disabled, especially after
link re-establishment with HDMI 2.0 scrambling enabled. Waiting for
only 2 frames is insufficient for certain monitor firmware, resulting
in garbled display output on resume from suspend.

Increase the AV mute wait in dcn30_set_avmute() from 2 to 3 frames
to ensure the sink receives enough GCP packets.

Assisted-by: Cursor:Claude-Opus-4.6
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index aed9d06ec538..aa7707b2b25b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -849,13 +849,19 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 				pipe_ctx->stream_res.stream_enc,
 				enable);
 
-		/* Wait for two frame to make sure AV mute is sent out */
+		/* Wait for three frames to make sure AV mute is sent out.
+		 * Some HDMI sinks need additional GCP packets to properly
+		 * process the mute state, especially after link re-establishment
+		 * with HDMI 2.0 scrambling enabled.
+		 */
 		if (enable && pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg)) {
+			int i;
+
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			for (i = 0; i < 3; i++) {
+				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			}
 		}
 	}
 }
-- 
2.43.0

