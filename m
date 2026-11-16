Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCB606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0GfOdQOw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8A310F827;
	Tue, 17 Nov 2026 17:14:12 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBB010F836
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgLoND4sVgO9dFbjDkDGt5WWHLEKW2FTIGjgnUfTzr0ELEKM5l7COKLhpijvf6CRovwQ39KrDy71xhT+bccFV5qo8WKTIlBZI9VCg4HWYki6mNhUqqb16cMjncphRMPDchWhQ+/GDzcuGqWWKo51qoeBHNHxzpkfMn6i/1Cc6woeBYvDb/qi92SNfKWgU0z+CdIPpoN1Yl07jai5NOP2DVqnLOPFjWro3P9IZQ3fRxt2EDDAEBLM+Ymr3ndvLmpKRZBoPkWB+81PPGAbbVSXleJTCS7baHABBBp1hg9bV2L+k3Xvz0UNpKJwhqHUksmKZpsGOSXo1rDKrD6ye9Rt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqvlg2GiqgkeSrqtlVI7kGIkExRJtbwVzoLA9IwXH5I=;
 b=mYTLuU+NEroWw25QpS6CxkmVY4MJVefV8dmrYpox1F+9aXilkMXkzoqwlVWsStkJjaYrZwxazyRNNsoHQeY7OPSAz4XX6WJQK2mVjw7ogzLu0SN70r8L4trT7kYzwXF4haeiZmXVlXkojeKQO+zLgWSpIEE1vkjPCn7B44ZPaWCjKAhBEmv2GS7ZFMU6kfWGia5mJzAKA2wFMY4P5Pm6hnV1a8AeLzYihBGuGDIVqPHlXijuM41I3FaCOf8TgC3KL+lBHpdOM/D341YYKg4KZfrsbVerQVgANGcKB5L6y8BAFjrf34OyOBYficU9xkE8tPsl3IcRFDQBw0WHbna6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqvlg2GiqgkeSrqtlVI7kGIkExRJtbwVzoLA9IwXH5I=;
 b=0GfOdQOwwD602fNYrwUbClZymF4UMLmuvZwKlMde9mzJzJuusZ8v9NWT2x0jrlqwW4o2B3kQ3949MnzamGebqJEvtJ/BS3alDiqGHozJNxMYzsbzsA0rWaZgQ0r3G2Ngep8OT1LP9eBcd8uvnGcBG+fnvejdBIV31fNBP7Jwb70=
Received: from CY5PR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:15::29)
 by DS8PR12MB712524.namprd12.prod.outlook.com (2603:10b6:8:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:13:59 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::1) by CY5PR19CA0006.outlook.office365.com
 (2603:10b6:930:15::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:13:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:13:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:57 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:13:43 -0600
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
Subject: [PATCH 10/33] drm/amd/display: Pass linear brightness percent to
 power module
Date: Tue, 17 Nov 2026 05:50:47 +0800
Message-ID: <20261116215641.2800595-11-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|DS8PR12MB712524:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f7255b-2867-4ce7-8354-08df44ce2af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|6133799003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261026135527099003|261102123227099003|261102130727099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261026130827099003|261022105027099003|261022113327099003|261021123027099003|261022115727099003|261021130227099003|261021133027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: w/ffyhhJhl+mFnGcZ3Tr5zJBlnr99XFeCCDqucUBJa/3/GoSCNXm65wEF5zb27xmvGlHf/t8W4Sf2vnwwvl51kv5ieIANBujGLvwOExEgYJpNmut7VxxDgR+cr0bYRsWfskFy0hwXQFcXmYWE5d6RCQUsiISLzX1UqLkttNoLX3RoNdtugrzeXGcwEd0bXR6p6uh26VFsvx+3FHJ6iznaDHt8uj/MxtYFuF5AnvEDtZenrAttMLaKuX0Pb28lK+f6WF0ZlDDIk3R66BTHLaz2m3zKlQh/tffTmpXW15210+6+KPO0GH+Xs7lnFtHhbxMd1+hd1IwagOJ0ivt0H6SF+Nsp6rvDCGbsQKEv0qZZfPIFYFog7kw9/Yj/s9n60fA2RJVggvUnlqKcivDNvm0gGIsSKxfb+PIA6xiDwQZaE7j9awnRNsTLEdILQG1b4/CxIeLNssQI0tL/knAJOqsu5g3HU25SWbHdw41e900/es4NppW5Q/tAlft8ofRA+32PhrwHetKhvJaDJArceHtVSOdpUSV7Wdhy3dX5zl6b9Fmm+fNrmi+Hyb1DocHbFbupMz+ZmyIkhPgnbsQiUZMVnIVuB2JRsNnhkJhIs5q2wBuMANrU2m5AdBFeaOIBWE/FgT1njTHUUcgL0tbMeO08L9bPDZxy0yDry67KqD/r8ryYoM49lJnwAvHGCmYbfL0pjvE9uYCkxQFMayCOnRVdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261026135527099003)(261102123227099003)(261102130727099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026130827099003)(261022105027099003)(261022113327099003)(261021123027099003)(261022115727099003)(261021130227099003)(261021133027099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CsFyJz7uz6XPGOoFUh+QRau0FxJvwOEPhJepAWcrPWZVzUrcxkWXlLoh4RBIKlgz4zWrbZZt8bbm6fzBRtawx9/SfoeYxfjmpmI8YZJ6MC6U7y536WcTU0Cd8Ix3Z7AAaTD31jz4LWu2tKJZyyOdxdovDv82V4qiOQy03zVnkHxky+t3LJ7qsxft11dxJUB1Ktvro4/7+O/4ZuefTBv+dFTFplroqkdyRxE5xDi5sjGqhbtqwf4sZ+Vu6w5uxraUs2Bqhlz81WnlAbTj8d80xsUeF92U8iNEZEmII4TbsqpUrH3kB5V7x4CZdbWrB1zxXkfAtZCxchulnMSgBqInBRt8M2lKWXrT2YkkcO/HvpNEA1cFVwGSuRa05iA10fxiFKs/6KYx/2P0j2lzzOZgurdeCZQPfG1QhXhvtShrm2yOfee9ePeBHcj8j0jGxcUP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:13:58.3030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f7255b-2867-4ce7-8354-08df44ce2af2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB712524
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
Pass the user level to mod_power_set_brightness() as a linear percentage
and let the power module choose nits or PWM. The ATIF curve now applies
only to PWM, through the power module's LUT. Read PWM back through the
same LUT.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 208 ++-----
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   9 +-
 .../tests/amdgpu_dm_backlight_test.c          | 552 ++++--------------
 3 files changed, 150 insertions(+), 619 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 27546febf90d..af0047c65cf2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -116,163 +116,35 @@ int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(get_brightness_range);
 
-/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
-static inline u32 scale_input_to_fw(int max, u64 input)
-{
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
-}
-
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
-static inline u32 scale_fw_to_input(int min, int max, u64 input)
-{
-	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
-}
-
-static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *caps,
-					 u32 signal)
-{
-	u32 lower_signal, upper_signal;
-	u32 lower_lum, upper_lum;
-	int i;
-
-	if (!caps->data_points)
-		return DIV_ROUND_CLOSEST(signal * 100, AMDGPU_MAX_BL_LEVEL);
-
-	if (signal < caps->luminance_data[0].input_signal) {
-		lower_signal = 0;
-		lower_lum = 0;
-		upper_signal = caps->luminance_data[0].input_signal;
-		upper_lum = caps->luminance_data[0].luminance;
-	} else if (signal >=
-		   caps->luminance_data[caps->data_points - 1].input_signal) {
-		lower_signal = caps->luminance_data[caps->data_points - 1].input_signal;
-		lower_lum = caps->luminance_data[caps->data_points - 1].luminance;
-		upper_signal = caps->max_input_signal;
-		upper_lum = 100;
-	} else {
-		for (i = 1;
-		     i < caps->data_points &&
-		     signal > caps->luminance_data[i].input_signal;
-		     i++)
-			;
-
-		lower_signal = caps->luminance_data[i - 1].input_signal;
-		upper_signal = caps->luminance_data[i].input_signal;
-		lower_lum = caps->luminance_data[i - 1].luminance;
-		upper_lum = caps->luminance_data[i].luminance;
-	}
-
-	if (upper_signal == lower_signal)
-		return upper_lum;
-
-	return lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
-					     (signal - lower_signal),
-					     upper_signal - lower_signal);
-}
-
-static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
-					      u32 user_brightness)
+/*
+ * The power module maps the percentage to nits or, through its LUT built from
+ * the ATIF curve, to PWM, so pass userspace's [0..max] through linearly.
+ */
+STATIC_IFN_KUNIT
+u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
+				       u32 user_brightness)
 {
 	unsigned int min, max;
-	u32 signal, luminance;
 
 	if (!get_brightness_range(caps, &min, &max))
-		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000,
-					     MAX_BACKLIGHT_LEVEL);
-
-	user_brightness = clamp(user_brightness, min, max);
-	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
-		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000, max);
+		max = MAX_BACKLIGHT_LEVEL;
 
-	signal = scale_input_to_fw(max, user_brightness);
-	luminance = backlight_signal_to_luminance(caps, signal);
-
-	return min_t(u32, luminance * 1000, 100000);
+	return DIV_ROUND_CLOSEST_ULL((u64)min(user_brightness, max) * 100000, max);
 }
+EXPORT_IF_KUNIT(convert_brightness_to_millipercent);
 
 STATIC_IFN_KUNIT
-void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int min, unsigned int max,
-			       uint32_t *user_brightness)
-{
-	u32 brightness = scale_input_to_fw(max, *user_brightness);
-	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
-	int left, right;
-
-	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
-		return;
-
-	if (!caps->data_points)
-		return;
-
-	/*
-	 * Handle the case where brightness is below the first data point
-	 * Interpolate between (0,0) and (first_signal, first_lum)
-	 */
-	if (brightness < caps->luminance_data[0].input_signal) {
-		lum = DIV_ROUND_CLOSEST(caps->luminance_data[0].luminance * brightness,
-					caps->luminance_data[0].input_signal);
-		goto scale;
-	}
-
-	left = 0;
-	right = caps->data_points - 1;
-	while (left <= right) {
-		int mid = left + (right - left) / 2;
-		u8 signal = caps->luminance_data[mid].input_signal;
-
-		/* Exact match found */
-		if (signal == brightness) {
-			lum = caps->luminance_data[mid].luminance;
-			goto scale;
-		}
-
-		if (signal < brightness)
-			left = mid + 1;
-		else
-			right = mid - 1;
-	}
-
-	/* verify bound */
-	if (left >= caps->data_points)
-		left = caps->data_points - 1;
-
-	/* At this point, left > right */
-	lower_signal = caps->luminance_data[right].input_signal;
-	upper_signal = caps->luminance_data[left].input_signal;
-	lower_lum = caps->luminance_data[right].luminance;
-	upper_lum = caps->luminance_data[left].luminance;
-
-	/* interpolate */
-	if (right == left || !lower_lum)
-		lum = upper_lum;
-	else
-		lum = lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
-						    (brightness - lower_signal),
-						    upper_signal - lower_signal);
-scale:
-	*user_brightness = scale_fw_to_input(min, max,
-					     DIV_ROUND_CLOSEST(lum * brightness, 101));
-}
-
-EXPORT_IF_KUNIT(convert_custom_brightness);
-
-STATIC_IFN_KUNIT
-u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
-				uint32_t brightness)
+u32 convert_millipercent_to_user(const struct amdgpu_dm_backlight_caps *caps,
+				 u32 millipercent)
 {
 	unsigned int min, max;
 
 	if (!get_brightness_range(caps, &min, &max))
-		return brightness;
-
-	convert_custom_brightness(caps, min, max, &brightness);
+		max = MAX_BACKLIGHT_LEVEL;
 
-	/* Rescale 0..max to min..max */
-	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
+	return DIV_ROUND_CLOSEST_ULL((u64)min(millipercent, 100000U) * max, 100000);
 }
-
-EXPORT_IF_KUNIT(convert_brightness_from_user);
+EXPORT_IF_KUNIT(convert_millipercent_to_user);
 
 STATIC_IFN_KUNIT
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
@@ -310,6 +182,19 @@ struct dc_stream_state *dm_find_stream_with_link(
 }
 EXPORT_IF_KUNIT(dm_find_stream_with_link);
 
+/* Must match the panels mod_power_set_brightness() sends nits to in SDR */
+static bool dm_backlight_takes_nits(const struct dc_link *link)
+{
+	switch (link->backlight_control_type) {
+	case BACKLIGHT_CONTROL_VESA_AUX:
+		return true;
+	case BACKLIGHT_CONTROL_AMD_AUX:
+		return link->dpcd_sink_ext_caps.bits.oled;
+	default:
+		return false;
+	}
+}
+
 STATIC_IFN_KUNIT
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
 					 struct backlight_device *bd)
@@ -331,8 +216,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 {
 	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link;
-	u32 brightness = 0;
-	u32 millipercent = 0;
+	u32 millipercent;
 	bool rc = false, reallow_idle = false;
 	struct drm_connector *connector;
 	struct dc_stream_state *stream;
@@ -364,20 +248,12 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	if (!stream)
 		return;
 
-	if (caps->aux_support) {
-		brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
-		/* Apply brightness quirk */
-		if (caps->brightness_mask)
-			brightness |= caps->brightness_mask;
-	} else {
-		millipercent = convert_brightness_to_millipercent(caps,
-								  user_brightness);
-	}
+	millipercent = convert_brightness_to_millipercent(caps, user_brightness);
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
 		trace_amdgpu_dm_brightness(__builtin_return_address(0),
 					   user_brightness,
-					   brightness,
+					   millipercent,
 					   caps->aux_support,
 					   power_supply_is_system_supplied() > 0);
 	}
@@ -388,14 +264,10 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		reallow_idle = true;
 	}
 
-	if (caps->aux_support) {
-		rc = mod_power_set_backlight_nits(dm->power_module, stream, brightness,
-			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
-	} else {
-		/* power module uses millipercent */
-		rc = mod_power_set_backlight_percent(dm->power_module, stream,
-						     millipercent, 0, false);
-	}
+	rc = mod_power_set_brightness(dm->power_module, stream, millipercent,
+				      dm_backlight_takes_nits(link) ?
+				      AUX_BL_DEFAULT_TRANSITION_TIME_MS : 0,
+				      caps->brightness_mask, false);
 
 	/*
 	 * Some kms clients create a ramped backlight transition effect
@@ -443,11 +315,12 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 	int ret;
 	struct amdgpu_dm_backlight_caps caps;
 	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
+	unsigned int panel_inst, millipercent;
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
 	caps = dm->backlight_caps[bl_idx];
 
-	if (caps.aux_support) {
+	if (dm_backlight_takes_nits(link)) {
 		u32 avg, peak;
 
 		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
@@ -460,7 +333,12 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 	if (ret == DC_ERROR_UNEXPECTED)
 		return dm->brightness[bl_idx];
 
-	return convert_brightness_to_user(&caps, ret);
+	if (!dc_get_edp_link_panel_inst(dm->dc, link, &panel_inst) ||
+	    !mod_power_get_hw_backlight_pwm_percent(dm->power_module, link,
+						    &millipercent, panel_inst))
+		return dm->brightness[bl_idx];
+
+	return convert_millipercent_to_user(&caps, millipercent);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_level);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 9ad888d3ae7b..1807209e90e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -67,13 +67,12 @@ ssize_t panel_power_savings_store(struct device *device,
 				 const char *buf, size_t count);
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max);
-void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-			       unsigned int min, unsigned int max,
-			       uint32_t *user_brightness);
-u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
-				 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 			       uint32_t brightness);
+u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
+				       u32 user_brightness);
+u32 convert_millipercent_to_user(const struct amdgpu_dm_backlight_caps *caps,
+				 u32 millipercent);
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
 					 struct backlight_device *bd);
 void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index a60c0fbf519d..e32e8c14e05e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -152,10 +152,9 @@ static void dm_test_backlight_set_level_no_stream(struct kunit *test)
  * @test: The KUnit test context
  *
  * With a matching stream present, set_level() walks into the DC programming
- * path. A NULL power_module makes mod_power_set_backlight_nits() a safe
+ * path. A NULL power_module makes mod_power_set_brightness() a safe
  * early-false, and ips_support disabled leaves idle optimizations untouched.
- * A non-matching connector exercises the connector-list skip, and a non-zero
- * brightness_mask exercises the quirk-OR path.
+ * A non-matching connector exercises the connector-list skip.
  */
 static void dm_test_backlight_set_level_aux_programs_power_module(struct kunit *test)
 {
@@ -195,26 +194,15 @@ static void dm_test_backlight_set_level_aux_programs_power_module(struct kunit *
  * dm_test_backlight_set_level_pwm_programs_power_module - Test PWM programming path
  * @test: The KUnit test context
  *
- * With aux_support cleared, set_level() takes the millipercent branch:
- * get_brightness_range() + mod_power_set_backlight_percent(). A NULL
- * power_module keeps the call a safe early-false. The cases walk each segment of
- * the custom luminance curve; DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE then bypasses it.
+ * With aux_support cleared, set_level() passes the PWM range to
+ * mod_power_set_brightness() as a percentage. A NULL power_module keeps the
+ * call a safe early-false.
  */
 static void dm_test_backlight_set_level_pwm_programs_power_module(struct kunit *test)
 {
-	static const struct amdgpu_dm_luminance_data curve[] = {
-		{ .input_signal = 50, .luminance = 10 },
-		{ .input_signal = 100, .luminance = 40 },
-		{ .input_signal = 200, .luminance = 80 },
-		{ .input_signal = 255, .luminance = 90 },
-	};
-	/* { data_points, brightness }: no curve, below/between/above points, zero-width end */
-	static const u32 cases[][2] = {
-		{ 0, 2000 }, { 3, 0 }, { 3, 38550 }, { 3, 65535 }, { 4, 65535 },
-	};
+	static const u32 cases[] = { 0, 2000, 38550, 65535 };
 	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
 	struct dc_link *link = dm_kunit_alloc_link(test);
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
 	int i;
 
 	setup_test_dm_ddev(test, dm);
@@ -225,22 +213,14 @@ static void dm_test_backlight_set_level_pwm_programs_power_module(struct kunit *
 	dm->backlight_caps[1].aux_support = false;
 	dm->backlight_caps[1].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	dm->backlight_caps[1].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	memcpy(dm->backlight_caps[1].luminance_data, curve, sizeof(curve));
 	dm->backlight_link[1] = link;
 	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, link);
 
-	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
-		dm->backlight_caps[1].data_points = cases[i][0];
-		amdgpu_dm_backlight_set_level(dm, 1, cases[i][1]);
-		KUNIT_EXPECT_EQ_MSG(test, dm->brightness[1], cases[i][1], "case %d", i);
+		amdgpu_dm_backlight_set_level(dm, 1, cases[i]);
+		KUNIT_EXPECT_EQ_MSG(test, dm->brightness[1], cases[i], "case %d", i);
 	}
 
-	amdgpu_dm_set_dc_debug_mask(saved_mask | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-	amdgpu_dm_backlight_set_level(dm, 1, 2000);
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-
-	KUNIT_EXPECT_EQ(test, dm->brightness[1], 2000U);
 	KUNIT_EXPECT_EQ(test, dm->actual_brightness[1], 0U);
 }
 
@@ -374,21 +354,24 @@ static bool dm_test_get_backlight_level_nits_fail(struct dc_link *link,
 /* Tests for amdgpu_dm_backlight_get_level()/get_brightness() */
 
 /**
- * dm_test_backlight_get_level_pwm_success - Test PWM brightness readback
+ * dm_test_backlight_get_level_pwm_no_power_module - Test PWM readback fallback
  * @test: The KUnit test context
+ *
+ * PWM readback goes through the power module's LUT. Without a power module
+ * for the link, get_level() must return the cached brightness.
  */
-static void dm_test_backlight_get_level_pwm_success(struct kunit *test)
+static void dm_test_backlight_get_level_pwm_no_power_module(struct kunit *test)
 {
 	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
 	struct dc_link *link = dm_kunit_alloc_link(test);
-	u32 hw_level = dm_test_get_backlight_level_mid(link);
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
+	dm->power_module = NULL;
+	dm->brightness[0] = 1234;
 	dm->backlight_link[0] = link;
 
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0),
-			 convert_brightness_to_user(&dm->backlight_caps[0], hw_level));
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 1234U);
 }
 
 /**
@@ -420,6 +403,8 @@ static void dm_test_backlight_get_level_aux_success(struct kunit *test)
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level_nits = dm_test_get_backlight_level_nits;
+	link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+	link->dpcd_sink_ext_caps.bits.oled = 1;
 	dm->backlight_link[0] = link;
 	caps->caps_valid = true;
 	caps->aux_support = true;
@@ -430,6 +415,35 @@ static void dm_test_backlight_get_level_aux_success(struct kunit *test)
 			 convert_brightness_to_user(caps, 250000));
 }
 
+/**
+ * dm_test_backlight_get_level_amd_aux_lcd_reads_pwm - Test forced AMD AUX LCD readback
+ * @test: The KUnit test context
+ *
+ * amdgpu.backlight=1 forces AMD AUX on an LCD, which the power module still
+ * drives through PWM in SDR. get_level() must read PWM back, not the AUX nits
+ * nobody wrote, so without a power module it returns the cached brightness.
+ */
+static void dm_test_backlight_get_level_amd_aux_lcd_reads_pwm(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	setup_test_link_service(test, link);
+	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
+	link->dc->link_srv->edp_get_backlight_level_nits = dm_test_get_backlight_level_nits;
+	link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+	dm->power_module = NULL;
+	dm->brightness[0] = 1234;
+	dm->backlight_link[0] = link;
+	caps->caps_valid = true;
+	caps->aux_support = true;
+	caps->aux_min_input_signal = 1;
+	caps->aux_max_input_signal = 512;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 1234U);
+}
+
 /**
  * dm_test_backlight_get_level_aux_error - Test AUX readback fallback
  * @test: The KUnit test context
@@ -442,6 +456,8 @@ static void dm_test_backlight_get_level_aux_error(struct kunit *test)
 
 	setup_test_link_service(test, link);
 	link->dc->link_srv->edp_get_backlight_level_nits = dm_test_get_backlight_level_nits_fail;
+	link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+	link->dpcd_sink_ext_caps.bits.oled = 1;
 	dm->brightness[0] = 6789;
 	dm->backlight_link[0] = link;
 	caps->caps_valid = true;
@@ -558,7 +574,9 @@ static void dm_test_register_backlight_device_custom_curve_readback(struct kunit
 
 	amdgpu_dm_set_dc_debug_mask(saved_mask & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
 	setup_test_link_service(test, link);
-	link->dc->link_srv->edp_get_backlight_level = dm_test_get_backlight_level_mid;
+	link->dc->link_srv->edp_get_backlight_level_nits = dm_test_get_backlight_level_nits;
+	link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+	link->dpcd_sink_ext_caps.bits.oled = 1;
 	primary = kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, primary);
 	adev->ddev.primary = primary;
@@ -568,6 +586,9 @@ static void dm_test_register_backlight_device_custom_curve_readback(struct kunit
 	aconnector->bl_idx = 0;
 	aconnector->base.kdev = adev->ddev.dev;
 	caps = &adev->dm.backlight_caps[0];
+	caps->aux_support = true;
+	caps->aux_min_input_signal = 1;
+	caps->aux_max_input_signal = 512;
 	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps->data_points = 1;
@@ -1034,379 +1055,83 @@ static void dm_test_brightness_to_user_midpoint_pwm(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, result, (u32)expected);
 }
 
-/* Tests for convert_brightness_from_user() — no custom curve */
-
-/**
- * dm_test_brightness_from_user_null_caps - Test Brightness from user null caps
- * @test: The KUnit test context
- */
-static void dm_test_brightness_from_user_null_caps(struct kunit *test)
-{
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(NULL, 100), 100U);
-}
-
-/**
- * dm_test_brightness_from_user_zero - Test Brightness from user zero
- * @test: The KUnit test context
- */
-static void dm_test_brightness_from_user_zero(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
-
-	caps.aux_support = false;
-	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	/* no custom curve */
-	caps.data_points = 0;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/* brightness=0 → min + 0 = min */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)min);
-}
-
 /**
- * dm_test_brightness_from_user_max - Test Brightness from user max
+ * dm_test_brightness_to_millipercent_pwm - Test PWM brightness to millipercent
  * @test: The KUnit test context
+ *
+ * The user level maps linearly from 0..max to 0..100%, with no curve and no
+ * clamp at min_input_signal, and a level above max is capped at 100%
  */
-static void dm_test_brightness_from_user_max(struct kunit *test)
+static void dm_test_brightness_to_millipercent_pwm(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
 
-	caps.aux_support = false;
 	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 0;
-
-	get_brightness_range(&caps, &min, &max);
+	caps.data_points = 1;
+	caps.luminance_data[0].input_signal = 128;
+	caps.luminance_data[0].luminance = 10;
 
-	/*
-	 * brightness=max → min + DIV_ROUND_CLOSEST((max-min)*max, max)
-	 *               = min + (max - min) = max
-	 */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)max);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 0), 0U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 1000), 1526U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 32768), 50001U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 65535), 100000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 70000), 100000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(NULL, 32768), 50001U);
 }
 
 /**
- * dm_test_brightness_from_user_aux - Test Brightness from user aux
+ * dm_test_brightness_to_millipercent_aux - Test AUX brightness to millipercent
  * @test: The KUnit test context
+ *
+ * Over AUX the user level runs over 0..1000 * aux_max_input_signal and maps
+ * linearly to 0..100%, with no curve even when ATIF gives one
  */
-static void dm_test_brightness_from_user_aux(struct kunit *test)
+static void dm_test_brightness_to_millipercent_aux(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
 
 	caps.aux_support = true;
 	caps.aux_min_input_signal = 1;
 	caps.aux_max_input_signal = 512;
-	caps.data_points = 0;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/* brightness=0 → min */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)min);
-	/* brightness=max → max */
-	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)max);
-}
-
-/* Tests for convert_custom_brightness() */
-
-/**
- * dm_test_custom_brightness_no_data_points - Test Custom brightness no data points
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_no_data_points(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness = 128;
-	uint32_t saved = brightness;
-
-	caps.data_points = 0;
-
-	convert_custom_brightness(&caps, 3084, 65535, &brightness);
-
-	/* No data points → no-op */
-	KUNIT_EXPECT_EQ(test, brightness, saved);
-}
-
-/**
- * dm_test_custom_brightness_debug_mask_disables - Test Custom brightness debug mask disables
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness = 128;
-	uint32_t saved = brightness;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	caps.data_points = 3;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 10;
-
-	/* Set the disable flag */
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	convert_custom_brightness(&caps, 3084, 65535, &brightness);
-
-	/* Should be no-op due to debug mask */
-	KUNIT_EXPECT_EQ(test, brightness, saved);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-}
-
-/**
- * dm_test_custom_brightness_exact_match - Test Custom brightness exact match
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_exact_match(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int min, max;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 3;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 128;
-	caps.luminance_data[1].luminance = 50;
-	caps.luminance_data[2].input_signal = 200;
-	caps.luminance_data[2].luminance = 90;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/*
-	 * Set brightness so that scale_input_to_fw yields exactly 128.
-	 * scale_input_to_fw(min, max, x) = DIV_ROUND_CLOSEST(x * 255, max - min)
-	 * With min=0, max=0x101*255=65535:
-	 * We need x such that DIV_ROUND_CLOSEST(x * 255, 65535) = 128
-	 * → x = 128 * 65535 / 255 = 32896
-	 */
-	brightness = 32896;
-
-	convert_custom_brightness(&caps, min, max, &brightness);
-
-	/*
-	 * Exact match: lum=50, brightness_scaled=128
-	 * result = scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(50*128, 101))
-	 *        = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(6400, 101))
-	 *        = scale_fw_to_input(0, 65535, 63)
-	 *        = 0 + DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
-	 */
-	KUNIT_EXPECT_TRUE(test, brightness != 32896);
-	KUNIT_EXPECT_TRUE(test, brightness < 32896);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-}
-
-/**
- * dm_test_custom_brightness_below_first - Test Custom brightness below first
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_below_first(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int min, max;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 100;
-	caps.luminance_data[0].luminance = 40;
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/*
-	 * Set brightness low enough that scaled value < 100.
-	 * scale_input_to_fw(0, 65535, x) = DIV_ROUND_CLOSEST(x*255, 65535)
-	 * For result=50: x = 50*65535/255 = 12850
-	 */
-	brightness = 12850;
-
-	convert_custom_brightness(&caps, min, max, &brightness);
-
-	/*
-	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
-	 * Then: scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(20 * 50, 101))
-	 *      = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(1000, 101))
-	 *      = scale_fw_to_input(0, 65535, 10)
-	 * The output should be significantly less than input.
-	 */
-	KUNIT_EXPECT_TRUE(test, brightness < 12850);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-}
-
-/**
- * dm_test_custom_brightness_interpolation - Test Custom brightness interpolation
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_interpolation(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int min, max;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/*
-	 * Choose a value between data points 50 and 200.
-	 * scale_input_to_fw(0, 65535, x) = 125 when x = 125*65535/255 = 32125
-	 */
-	brightness = 32125;
-
-	convert_custom_brightness(&caps, min, max, &brightness);
-
-	/*
-	 * The function should interpolate between data points and produce
-	 * a remapped value different from the input.
-	 */
-	KUNIT_EXPECT_TRUE(test, brightness != 32125);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-}
-
-/**
- * dm_test_custom_brightness_above_last - Test Custom brightness above last data point
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_above_last(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int min, max;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 150;
-	caps.luminance_data[1].luminance = 60;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/*
-	 * Choose brightness above the last data point (150).
-	 * scale_input_to_fw(0, 65535, x) = 220 when x = 220*65535/255 = 56533
-	 * After binary search, left >= data_points, clamped → right==left,
-	 * so lum = upper_lum = 60.
-	 */
-	brightness = 56533;
-
-	convert_custom_brightness(&caps, min, max, &brightness);
-
-	/* Output should differ from input (remapped via curve) */
-	KUNIT_EXPECT_TRUE(test, brightness != 56533);
-	KUNIT_EXPECT_TRUE(test, brightness < 56533);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-}
-
-/**
- * dm_test_custom_brightness_single_data_point - Test Custom brightness with single data point
- * @test: The KUnit test context
- */
-static void dm_test_custom_brightness_single_data_point(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int min, max;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	caps.data_points = 1;
 	caps.luminance_data[0].input_signal = 128;
-	caps.luminance_data[0].luminance = 50;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/*
-	 * Brightness below the single data point triggers the
-	 * "below first" path: lum = DIV_ROUND_CLOSEST(50 * scaled, 128).
-	 * scale_input_to_fw(0, 65535, x) = 64 when x = 64*65535/255 = 16448
-	 */
-	brightness = 16448;
-
-	convert_custom_brightness(&caps, min, max, &brightness);
-
-	KUNIT_EXPECT_TRUE(test, brightness < 16448);
+	caps.luminance_data[0].luminance = 10;
 
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 0), 0U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 256000), 50000U);
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(&caps, 512000), 100000U);
 }
 
 /**
- * dm_test_custom_brightness_lower_lum_zero - Test Custom brightness with zero lower luminance
+ * dm_test_millipercent_to_user_pwm - Test PWM millipercent back to brightness
  * @test: The KUnit test context
+ *
+ * Every user level must come back unchanged from its millipercent, and a
+ * millipercent above 100% is capped at max
  */
-static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
+static void dm_test_millipercent_to_user_pwm(struct kunit *test)
 {
 	struct amdgpu_dm_backlight_caps caps = {};
-	uint32_t brightness;
-	unsigned int min, max;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	u32 level;
 
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
+	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 0;	/* zero lower luminance */
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
 
-	get_brightness_range(&caps, &min, &max);
+	KUNIT_EXPECT_EQ(test, convert_millipercent_to_user(&caps, 0), 0U);
+	KUNIT_EXPECT_EQ(test, convert_millipercent_to_user(&caps, 50000), 32768U);
+	KUNIT_EXPECT_EQ(test, convert_millipercent_to_user(&caps, 100000), 65535U);
+	KUNIT_EXPECT_EQ(test, convert_millipercent_to_user(&caps, 150000), 65535U);
 
-	/*
-	 * Choose brightness between data points to trigger interpolation.
-	 * scale_input_to_fw(0, 65535, x) = 125 when x = 125*65535/255 = 32125
-	 * With lower_lum == 0, code takes shortcut: lum = upper_lum = 80.
-	 */
-	brightness = 32125;
+	for (level = 0; level <= 65535; level++) {
+		u32 millipercent = convert_brightness_to_millipercent(&caps, level);
 
-	convert_custom_brightness(&caps, min, max, &brightness);
-
-	/* Should remap; result should differ from input */
-	KUNIT_EXPECT_TRUE(test, brightness != 32125);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
+		if (convert_millipercent_to_user(&caps, millipercent) != level) {
+			KUNIT_FAIL(test, "level %u came back as %u", level,
+				   convert_millipercent_to_user(&caps, millipercent));
+			break;
+		}
+	}
 }
 
 /**
@@ -1430,66 +1155,6 @@ static void dm_test_brightness_to_user_above_max(struct kunit *test)
 	KUNIT_EXPECT_GT(test, result, max);
 }
 
-/**
- * dm_test_brightness_from_user_midrange - Test Brightness from user mid-range value
- * @test: The KUnit test context
- */
-static void dm_test_brightness_from_user_midrange(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
-	u32 result;
-
-	caps.aux_support = false;
-	caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 0;
-
-	get_brightness_range(&caps, &min, &max);
-
-	/* Mid-range brightness should map to between min and max */
-	result = convert_brightness_from_user(&caps, max / 2);
-
-	KUNIT_EXPECT_GE(test, result, min);
-	KUNIT_EXPECT_LE(test, result, max);
-}
-
-/**
- * dm_test_brightness_from_user_with_curve - Test Brightness from user with custom curve active
- * @test: The KUnit test context
- */
-static void dm_test_brightness_from_user_with_curve(struct kunit *test)
-{
-	struct amdgpu_dm_backlight_caps caps = {};
-	unsigned int min, max;
-	u32 with_curve, without_curve;
-	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
-
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-
-	caps.aux_support = false;
-	caps.min_input_signal = 0;
-	caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps.data_points = 2;
-	caps.luminance_data[0].input_signal = 50;
-	caps.luminance_data[0].luminance = 20;
-	caps.luminance_data[1].input_signal = 200;
-	caps.luminance_data[1].luminance = 80;
-
-	get_brightness_range(&caps, &min, &max);
-
-	with_curve = convert_brightness_from_user(&caps, max / 2);
-
-	/* Now disable the curve and compare */
-	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
-	without_curve = convert_brightness_from_user(&caps, max / 2);
-
-	/* Custom curve should produce a different mapping */
-	KUNIT_EXPECT_NE(test, with_curve, without_curve);
-
-	amdgpu_dm_set_dc_debug_mask(saved_mask);
-}
-
 /**
  * dm_test_brightness_range_zero_signals - Test Brightness range with zero min and max signals
  * @test: The KUnit test context
@@ -2002,9 +1667,10 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_set_level_reallows_idle),
 	KUNIT_CASE(dm_test_backlight_update_status_no_stream),
 	/* amdgpu_dm_backlight_get_level / get_brightness */
-	KUNIT_CASE(dm_test_backlight_get_level_pwm_success),
+	KUNIT_CASE(dm_test_backlight_get_level_pwm_no_power_module),
 	KUNIT_CASE(dm_test_backlight_get_level_pwm_error),
 	KUNIT_CASE(dm_test_backlight_get_level_aux_success),
+	KUNIT_CASE(dm_test_backlight_get_level_amd_aux_lcd_reads_pwm),
 	KUNIT_CASE(dm_test_backlight_get_level_aux_error),
 	KUNIT_CASE(dm_test_backlight_get_brightness_uses_device_index),
 	/* amdgpu_dm_register_backlight_device */
@@ -2036,23 +1702,11 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_brightness_to_user_at_max),
 	KUNIT_CASE(dm_test_brightness_to_user_at_min),
 	KUNIT_CASE(dm_test_brightness_to_user_midpoint_pwm),
-	/* convert_brightness_from_user */
-	KUNIT_CASE(dm_test_brightness_from_user_null_caps),
-	KUNIT_CASE(dm_test_brightness_from_user_zero),
-	KUNIT_CASE(dm_test_brightness_from_user_max),
-	KUNIT_CASE(dm_test_brightness_from_user_aux),
-	/* convert_custom_brightness */
-	KUNIT_CASE(dm_test_custom_brightness_no_data_points),
-	KUNIT_CASE(dm_test_custom_brightness_debug_mask_disables),
-	KUNIT_CASE(dm_test_custom_brightness_exact_match),
-	KUNIT_CASE(dm_test_custom_brightness_below_first),
-	KUNIT_CASE(dm_test_custom_brightness_interpolation),
-	KUNIT_CASE(dm_test_custom_brightness_above_last),
-	KUNIT_CASE(dm_test_custom_brightness_single_data_point),
-	KUNIT_CASE(dm_test_custom_brightness_lower_lum_zero),
+	/* convert_brightness_to_millipercent / convert_millipercent_to_user */
+	KUNIT_CASE(dm_test_brightness_to_millipercent_pwm),
+	KUNIT_CASE(dm_test_brightness_to_millipercent_aux),
+	KUNIT_CASE(dm_test_millipercent_to_user_pwm),
 	KUNIT_CASE(dm_test_brightness_to_user_above_max),
-	KUNIT_CASE(dm_test_brightness_from_user_midrange),
-	KUNIT_CASE(dm_test_brightness_from_user_with_curve),
 	KUNIT_CASE(dm_test_brightness_range_zero_signals),
 	/* amdgpu_dm_backlight_fill_props */
 	KUNIT_CASE(dm_test_backlight_fill_props_ac_linear),
-- 
2.43.0

