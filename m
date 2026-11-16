Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C7606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=im52k73W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC1910F826;
	Tue, 17 Nov 2026 17:13:56 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE07910F81F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU/kiG9p7F9qmkmKANhkM+gXiHdidPHNtAgvQwKsex9hCHefLwFIWM2VV03kphQtPXsX2cHctoGPVbM1Ecv0035EZE84HLnCD+a44rTsmJSnpDx7vCx4l90N1gpCu4enMaNK+ISMGTrDcj+P7oRuVVzV0UF8HQQwWKNwsYLBJx/dk4XC+JV9vjgtregfiIpXVOjtPOYps6fxsaROsRxSu5BE/nXoHcm6sAC0v2y6dU3q6YoVmewwnMPhIwoKbXOeOR9iKlZWUZEnMwMfCSHEpYkuFJnwWYLwYpv07MRNYJB6ipymS7PB0iIaBqPpiAwWiG5EY3rfzlahQSnVSyFb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzjoLR8iBGJaqZp6qBSNCifV7d1JNCfFKA4O8+cZlJY=;
 b=lyOnuYnRsbl/f40eEWyBSxoOHtTz7IvB0NBemVppbgJqV3X+aOL05T/cOiRqsZnI36GI6QtVco5LbjWhoPJkKJWS6fY/lKCAwBR+D/Ek/+4kq+ixMyj9dEWjCqRm/jsxmEHKTuE+PdeFvdoyz8Pj6B2Y65PIoXb+ZeKAHz4BVfddAvzgqaH3TEOYDesWUXZNaHYdymSX+kisKmDvx9qCeXif9TN97gLeT/mbjKymEIBtATIw2vy9kPi3UYN64htSKo3iNRu5q2PLl3PJDea0WONTY1aQwe6cHgOl5Z1LlHNmTSoGRZuXjuF1rv++vnrzJvxFekI+hxVsg1JX7M5yOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzjoLR8iBGJaqZp6qBSNCifV7d1JNCfFKA4O8+cZlJY=;
 b=im52k73WUvustQjloIV3YKOyJ+NITD6sk24E88Bf63mkZZMBZHYH8JPfsamJBnuqmXK2guNs+11QJjeIbcytf/NKHUdPTWo49Nz4dOvtv3v5UFmQUcj9b1qLVT65uilM1LTl70FEA0tQY/ZVziAEZ/LpheHTvbh65UhOtj+CNQM=
Received: from CY5PR19CA0032.namprd19.prod.outlook.com (2603:10b6:930:1a::12)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:13:45 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::52) by CY5PR19CA0032.outlook.office365.com
 (2603:10b6:930:1a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:13:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:13:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:43 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:13:29 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 09/33] drm/amd/display: Add API to set brightness percent
Date: Tue, 17 Nov 2026 05:50:46 +0800
Message-ID: <20261116215641.2800595-10-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8e1987-00f1-415e-4898-08df44ce224f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|261009223027099003|18002099003|22082099003|261022075727099003|261021121427099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: L0cYzCkNz3WxbtJSDpVSgdbedAOvKjJnAvW8C09Uf8d4hfAbSzMF5/vhj3wKn75fW0Bu/TE0xlLaaBScJhON3p/0n3L8v8jLDIWeA+kmLb/MdS0gbvpCbaYwArBUo0/2lD4UThmUxfMbWdZHQ5Fd5/4mgFwnOfDfqRzIJASTcBecbLfeDNm3QIqn8LAQ+ac9SutYpFyhhUZDJC9L93/zmFhjHqT8VdL8HEWwpvSIRhM0gxfdCsXcrvpXOjNPbmz/pEOtmlt9LMak3uMKTnB6fWzlEOADCKNZs7kwifhcwBk/F31QKzMBUPRFqwMnKL3INND4bwonXqTztryk2rKI6y4tFI6shZPlL5N2VtbAZAdGx/HPhF0eeq7l4Wd9wAb6JtUfdMJ9PyONcDz94vN/5z4Gk3bPAU1iXnFpDeTIiIof4bVgs7anZzCSPDbzZMO0GLPPXJyioM0m1zowPRbvhKq3vUivSUOv0hKhErHrbg07nEjuTmrT+3ac31dKbDdG4if/gJUECyjmDy2bbXW6pkBnxyAwA/L3rwi8j21bXWGmwZdzTqCJ5/o0mSfp0IkahLXI0NxjqCjq7Xgq8B1ovEZjn9IlYtT+o7+kiolJSgLQp4Duya3o7Kr067eHHWsgZaaOykjaX6NV32ulY0wO7KT4RgzjtH98Moeb5+iGm4AZeZ/eyJrdkZQI2Uf2+m9tgSVkrPqH+Hm8eOhatixEHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(261021121427099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Lk50YRy+uzrTZMqUJ8OeyanOzc4S+GBYWey1XDzCIl4l9AqMbdcpR+iR42e+Jg1Za5/7tBbVl3BUD/k3jDZNYt8zV8sVHwKCroAJXQ9ARI2QohwlEi2A/mZOJj03v4yu18jMFVkVhlikkZevq5aAZhnqcl0NhBIt4ETBUbT0npOXcHakbkRnkRDCx6FvRsTeBh7eE+rYRcmFpKbqiCehCYP4/906ZK6++kd9oOgwtazuz44jZR+5k62Vxbiik5wzRC6Z8mPcA4T4W/k9Ma4SAcLeZAAbsA1tta3qAR1HGLG33ngr33SniLQeFibdlTzoSdNRUMJamGGDWBmfWLG/GqXa0xInotq/etKw4AP7cp9Bx4pU0ju72hUnohCTaLx5yIWWNFn4hP6Ke5u9gMyrlCOgH9fr17YuBPxKUuogIb0xamh3bJBcqfeZcpCsbos
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:13:43.8544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e1987-00f1-415e-4898-08df44ce224f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Add mod_power_set_brightness() so DM can pass a percentage for every
panel type and let the power module pick the unit:

- VESA AUX takes nits, mapped linearly over the panel range.
- AMD AUX takes nits on OLED and in HDR, and follows PWM otherwise.
- PWM goes through the backlight LUT built from ATIF.

The AUX brightness mask is ORed into the nits.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/modules/inc/mod_power.h   |  7 ++
 .../drm/amd/display/modules/power/power_abm.c | 65 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index 25a0c96ac754..3b6eb2116636 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -221,6 +221,13 @@ bool mod_power_set_backlight_percent(struct mod_power *mod_power,
 		unsigned int transition_time_millisec,
 		bool is_hdr);
 
+bool mod_power_set_brightness(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millipercent,
+		unsigned int transition_time_millisec,
+		unsigned int aux_brightness_mask,
+		bool is_hdr);
+
 void mod_power_update_backlight(struct mod_power *mod_power,
 		struct dc_stream_state *stream,
 		unsigned int backlight_millipercent);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index 60930d969b9b..a5077b43837f 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -1166,6 +1166,71 @@ bool mod_power_set_backlight_percent(struct mod_power *mod_power,
 			&backlight_level_params, panel_inst);
 }
 
+/* AMD AUX takes nits only when the panel's AUX backlight control is on,
+ * which DC turns on for OLED and for HDR. Otherwise the panel follows PWM.
+ */
+static bool backlight_takes_nits(const struct dc_link *link, bool is_hdr)
+{
+	switch (link->backlight_control_type) {
+	case BACKLIGHT_CONTROL_VESA_AUX:
+		return true;
+	case BACKLIGHT_CONTROL_AMD_AUX:
+		return link->dpcd_sink_ext_caps.bits.oled || is_hdr;
+	default:
+		return false;
+	}
+}
+
+/* Sets the brightness as a percentage, whatever the backlight control type.
+ * When the panel takes nits, the percentage maps linearly to
+ * [min_brightness_millinits, max_brightness_millinits] with
+ * aux_brightness_mask ORed in. Otherwise it maps to PWM through the
+ * backlight LUT.
+ */
+bool mod_power_set_brightness(struct mod_power *mod_power,
+		struct dc_stream_state *stream,
+		unsigned int backlight_millipercent,
+		unsigned int transition_time_millisec,
+		unsigned int aux_brightness_mask,
+		bool is_hdr)
+{
+	struct core_power *core_power = NULL;
+	const struct dc_link *link = NULL;
+	unsigned int backlight_millinit;
+	unsigned int panel_inst = 0;
+
+	if (mod_power == NULL || stream == NULL)
+		return false;
+
+	core_power = MOD_POWER_TO_CORE(mod_power);
+	link = dc_stream_get_link(stream);
+
+	if (!dc_get_edp_link_panel_inst(core_power->dc, link, &panel_inst))
+		return false;
+
+	if (backlight_millipercent > BACKLIGHT_MILLIPERCENT_MAX)
+		backlight_millipercent = BACKLIGHT_MILLIPERCENT_MAX;
+
+	core_power->bl_state[panel_inst].isHDR = is_hdr;
+
+	if (!backlight_takes_nits(link, is_hdr))
+		return mod_power_set_backlight_percent(mod_power, stream,
+				backlight_millipercent, transition_time_millisec, is_hdr);
+
+	backlight_millinit = backlight_millipercent_to_millinit_legacy(
+			core_power, backlight_millipercent, panel_inst) |
+			aux_brightness_mask;
+
+	if (!mod_power_set_backlight_nits(mod_power, stream, backlight_millinit,
+			transition_time_millisec, false, is_hdr))
+		return false;
+
+	/* mod_power_set_backlight_nits() caches the percent read back from nits */
+	core_power->bl_state[panel_inst].backlight_millipercent = backlight_millipercent;
+
+	return true;
+}
+
 void mod_power_update_backlight(struct mod_power *mod_power,
 		struct dc_stream_state *stream,
 		unsigned int backlight_millipercent)
-- 
2.43.0

