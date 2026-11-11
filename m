Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C53606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ebVLRgJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B1C10F8DE;
	Wed, 11 Nov 2026 01:43:43 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF41710F8DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL/HldeWDm3c1J1wuiSdSUheSUG32RzXtOf9FC1FdsStZtbLr6cCZP+TP3C2A2WLfdzqYqZgrJvVY4+OflZR6rgbZEjqTUF8e3xBGYnldERefGDYcpfw8/dHakhy+w0bUWawRHn4NVxpModkFRy5gX67zvfH2RdByxR6XoEDq2YoUiCZyp1yo5cOA8GWHUUOJWyVurkvXbo9w95yWX94Vnoyt5SuC54+eLU/zislwPX1cjCVJgvGpGCN+FXzBPKLsZ4eJH9sW2uyzVGXgtozbgY8QYjtvd7LBNd3o0XgzUQENqRqOX+VHXnsHZ4zSYHQvxk7MfHZVTA2ZjvpRmKEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceLKLKUw9WonbFxG1nbIdZawhIs5b/H8ybLvLt/GlL0=;
 b=DFDlv54ruqKShyUXvbA8oYxpytWpsddoc7mKgbOcOnBs7xwsW6CYV6p9AArwKQuA3pZsqv+CBZB5DzH74+DaYMaEyITA+gGka7tlgFldgelQczlNtJVsigmkOeKJ/WvOUBSnUGh1uuSnmGaHHkr49EJES3onY/XRnka7NTrgUjklYJat3ZrS7PqTPhv7e7qpyk0M9bnMBhMtjOW60LnaOIJostw9lpyJQTyjYYfj+s/8UgktuHvfMJR+bxdXeMZpcb1PWItyuEU9QvnfaLpm1lpxP1pCXzruHf+s6GwGuMPs94QbPCqLUcDD9dSZ0t+dP3F/PFrevOzr9TKBiD7duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceLKLKUw9WonbFxG1nbIdZawhIs5b/H8ybLvLt/GlL0=;
 b=ebVLRgJONsNQvumwD4pJAsSIEkBVg/CIbydFC9S6cmgbf6EqVxIH9YoRq5+6zLa7QE6QSg2ee4uTeB5lknV/cQnqDGqJ8D4BIOYCN59wJps0caEPodKtHz6kVzlrHsrIBJy1cmPmLhqO/V+t7C9aZ5B6tBNz8f6wVWhGLcVYShc=
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:31 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::86) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:30 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:27 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 48/74] drm/amd/display: Keep patched HDMI panels on FRL across
 detect
Date: Wed, 11 Nov 2026 09:28:54 +0800
Message-ID: <20261111014100.3596072-49-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2c348a-eb3a-4825-c776-08df3f95312b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|10067099003|261028144727099003|3023799007|261102123227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nTC1nh/8Hh8ShrvzJyqQQe/tAjO7YMdsVoAUUO1p/758zuQVmr2HoICqQGNzHNbfcdpaZ/CEb+ijcg44RH4MP6/BgYgKRks5p9kyxL+iqb9oRduR9A12HsduZEFPHFD65h45zmGVz+g9DN9U7TPTi1Y4s1t1O3eeffgDCBwlkFQGzffhoJCkRXqrihf6zC3C6NSqvFQintLtlPNvMAgPJ7XfIJ7VH5zmpVdOZ+J8+0Wuz8ieYE0EnzFSOoNGokSIj6tuzmqhLplDfqA0rVFhyhmFMwhsw4Pfe50BBCTYFPCUZ4REmMZ2D1xmTxkihNq/3p4b1FBMAcC1RB/8oXMj2rpxG9rslSbqcFqf2PGIY0xxNYVZb0+HGe/6yd+wssZREde9c8WMUCLhfqOSq/3CvZp0dtPjEgBa5DATX45cGmHktihOnlOo1NjUojq3GAZudy4RKaxhZP+i8CUnPExlqTBeSbMloCt7xaSnf1cQOpvhiTWkRTvi2NFOZtI5u4/n80+8KeUfPGALSzmUqVtq6QSJu9SEqAbcWVB01axTFd5a5IfhobJgiFuycatoFg48rmR4SnSYOUMkobSxg5LRQIMCu1/s06OXUBM/QSU/Ox7Kmd5LDgFAZzKs4AFR3FANQRrzwot7OS6A4krEulqNGj1Rxd40nbZuPxW3+mn4jrdGV23N9nfudFC/qhXWSVeZl9c+JjRO94ojEc6j931deg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(10067099003)(261028144727099003)(3023799007)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sgyqRc9oyMCrTYF5nB0O2iGbYexVYzfhk35OrvY6pw2fnGb3vYTzJLiKZmuVEl+a34DtCMpEgcMcCBykor6qeWcVghHB0BA2DZlGlkPS3TXQW9gdZyIz74b32rLw/7lhQiJG+Jj78bA9yVo5eS/NyqAdYVLKCY5h98iX4ThKpE8QIOapDUeTUb6lf8wFd2vuauDtBowz14A+/nsCa36+2G7S26wArpq+KvmxeBy4zaEruBnU9FVwdfidLwlQ0r5vUYo1U7QYBC2B+VqpJtDMF7TQRA5F7NmvUdtziy5LOj4DfqCm2vLcE200YqLvo0oi0FVay3xafLJyFL9VbHsi0v93TvGdiYRva3sIzr60iriguuozcK1OZa7VQruFchy/WlEGsXc+QaYsbCSwFXgxk3SCDzuCo4F556k606ZMybiWGj96zMtZ6eWl7HUrE4bX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:31.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2c348a-eb3a-4825-c776-08df3f95312b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
A patched panel sets force_frl so update_stream_signal() keeps an
FRL stream instead of dropping it to TMDS. The flags stay on the
link, so a later sink with no FRL rate can keep the previous
panel's force_frl_always. Setting the flag on an encoder that
cannot drive FRL also picks a signal the ASIC cannot output.

[How]
verify_link_capability() sets force_frl_always, force_frl_max and
force_frl_dsc from the current panel patch when the encoder is FRL
capable and max_frl_rate is non-zero. It does not clear a flag the
patch leaves unset. Otherwise it clears those three flags.
hdmi_frl_verify_link_cap() applies force_frl only when the encoder
is FRL capable.

Cc: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  | 26 +++++++++++++++++++
 .../display/dc/link/protocols/link_hdmi_frl.c |  7 ++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index b4546f93af0c..5b257f003f13 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1006,6 +1006,32 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 static void verify_link_capability(struct dc_link *link,
 		enum dc_detect_reason reason)
 {
+	/* The FRL force flags are only fully recomputed on the destructive path
+	 * (hdmi_frl_verify_link_cap), so re-derive the sink driven part on every
+	 * detect. Without this a sink can either inherit flags from a previously
+	 * connected monitor, or stay cleared when a patched monitor is detected
+	 * through one of the non destructive paths (FRL already in use,
+	 * skip_frl_pre_training on an active link, or skip_detection_link_training).
+	 * Setting them is additive so SCDC test request results survive, and the
+	 * destructive path overwrites all of them anyway.
+	 */
+	if (link->link_enc &&
+			link->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE &&
+			link->local_sink &&
+			link->local_sink->edid_caps.max_frl_rate != 0) {
+		if (link->local_sink->edid_caps.panel_patch.force_frl)
+			link->frl_flags.force_frl_always = true;
+
+		if (link->local_sink->edid_caps.panel_patch.hdmi_comp_auto) {
+			link->frl_flags.force_frl_max = true;
+			link->frl_flags.force_frl_dsc = true;
+		}
+	} else {
+		link->frl_flags.force_frl_always = false;
+		link->frl_flags.force_frl_max = false;
+		link->frl_flags.force_frl_dsc = false;
+	}
+
 	if (should_verify_link_capability_destructively(link, reason))
 		verify_link_capability_destructive(link, reason);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index c31be4900e8d..3f687603a70c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -902,8 +902,13 @@ void hdmi_frl_verify_link_cap(struct dc_link *link,
 	if (link->frl_flags.force_frl_rate == 0xF)
 		return;
 
+	/* Only honour the force FRL monitor patch when VBIOS reports the encoder
+	 * as FRL capable, otherwise the stream would be forced to a signal type
+	 * the ASIC cannot drive.
+	 */
 	if (link->local_sink &&
-		link->local_sink->edid_caps.panel_patch.force_frl)
+		link->local_sink->edid_caps.panel_patch.force_frl &&
+		link->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE)
 			link->frl_flags.force_frl_always = true;
 
 	if (!link->frl_flags.force_frl_max &&
-- 
2.43.0

