Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503A2C55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C1710F402;
	Fri, 31 Jul 2026 21:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WUSSEJII";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E2410F3FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyuf8u6MoubMdQMxxwbDp63UYHjvZct2GoRAChIhEKjlfVknKqzsIph2LSGCNPSccbLfzIKbDjc5AcnisdpVXHr5qvWLH6C283ZGws5zGNVfToAzmLSyq0XP9HUvsEw2i/0rxyLy/yYXA235Du0woSkjNpPbDVAZjZvKKy1a4g9gmMliVhqbt43xb4A63kCMTOi05GBHhndXH00DQXDMx4TQ4oPhwKvE6dhBvWPNfdbCZnw4LwBc9wAumAeesEY7OAYOiBP+hdFqQqp4N0aTcluxRm78n84BGeuUCtGbreDnekRZ+ZCX9HJQobDoksyYPV9YGYu6mpXw9zD5Vgg66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+AD3Q0HKS01S2PX4JzS2kM51bmkV3a2zA2H77kxH0o=;
 b=m3PLBf2HeEeCluC3KrKjgWyZPaJW+C2z77aOaja9FuBTjt2vdeox8C0SkVwygUjQ8s2JzVp4CPkBH4/glGsQIwugvNPsSxKl8zbegKb4CyyCCFHqy5bHOSl9J4h39bNV790fr7tNo+TUitq3UrW22r0AaFxnKUg7LFjbSLQ/vvKVlZda8hh8XgTPtqcGoDx0R1qqMz0xw3b0EmUI5AImS2Tzp8WkWJDnXX7SvCZzg8KO9A2M5OwbIh/Pyn6qNmaL04aEkf//K3uhnDDWzXUJ0g/HYqDDrocuK0zBNwudPulAq3Pqlpfl0+x0UbLpex/I1K3Veb7LOiwCo/kbiYbYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+AD3Q0HKS01S2PX4JzS2kM51bmkV3a2zA2H77kxH0o=;
 b=WUSSEJIIH7HOqq9WG1f4TrvM75siLY6WnABVx1FRccuCdu+0T+a4Tstw0+6BimW1UJC6YC46StnBQuKHAiOBNk3iSC1xSF8MPrx0cn+5m4X1rjsQDhjcDFZyXuEGsq2BiVVL8QW2Ht8el1B/cjFsxeuPxoCIqELsCuZqb9gphcY=
Received: from CH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:32::27)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:58 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::70) by CH0PR07CA0022.outlook.office365.com
 (2603:10b6:610:32::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:58 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:57 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Iswara Nagulendran <Iswara.Nagulendran@amd.com>,
 Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 30/41] drm/amd/display: Fix ABM over VABC
Date: Fri, 31 Jul 2026 17:12:51 -0400
Message-ID: <20260731211302.3040343-31-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: d5039d2d-07d7-4144-d801-08deef48ea92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|11063799006|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 9pMv95Nkfo7xxJBL8TVp2WnA4Mo+THrm6PdngrGJCjtnA96KUnlQC+4fcrFfdSRbry+pASqyHnxodvsN9K2TVDWedS6qtdPol6EY9B4BVe+kd0eCv0JLqkwzjnlHMqDHff25uF4TuM84kcNP7SYG0P19FSPTbCeAAISOnIQDyC091MY+VKgOrPCuNmxPxXu+1/kGLmx/zb5W1x40XN0mMqA3nlhqlUts7dh3KDtehaxnAX4MB9jOT60vSdPT5lE9BUn06FLx3LTP5/0OSh8GOmiiuvnKn/rgqd5uf2Mdpklb8lWaoTBmRmEpfkG7xXWINxoQVcW0wvfLP0lUzQfO6jG3uuEpdwLquC4KD9/WJUdWXr9S8y87fdC9cGSd7ODO80JP92R4DqGbfQRCCgUuMPhRWo9Is48Zttw7LswTb5108Hk61rO5T2QfW9c+QRqhmubx+Z0etgtshZ089VlRz+yPctSqieXVxIvwu+Z1Ynd7iM2LujdAlIFNtNQcioUMRWWQfpzm1Pr+jhGsa/O+7rsXuX4SOrXm/cWoreAB4IAV73jguji/dG8O1RfwwyUzJ5XrBVNFq03QC20Ndf73RaV4Tl8EsvSaILQ0P8fcG6kCKJLjTrhJr774I+KZznzlkqtkcPSxbv6JxGUim7sUEp41Hu6d4Qwm2+BSZK1DO62kILbKAOsrRKLAIKgDClta73Zp+/kT2jaG8wLT6e7k4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RobO0A2YsA/lH83v23mhw352SB06L/RkdNmk4y6rp75a+KsF6RJBPnlz/ElB9UPF2kigOuGFfUfIUppvfa7v3Wfd9jr/syDT2wGOnFDnd3aUzk2nXUkLz/LFcKvs77zFSQYejcpRXpTLOURbmduNlgIUv4lgHoDABR7geONMtVzXLyoPT1iLp3iiyfawLo2n9rBFHjBg3rKpKBw7T25k7jt8UVa5Lm0Zan42Y0e2EANo8nKNa147edhqDwdYRO+GNIpbpVk5q7y/aCy+trANx5GDiqmzF1wCOyth2+PEQf1ep8aPyI+lg0GrzCVK3qmCLIfip2tqBbs1T6bIMrnRgkW9UEn0yLXOPVzBxwKy2ZdrKcUWev+0G5DJN+KDlyCPKh5ziaojw2s1mjzOLePU/6UD7aiA877iz/VOtFiiLPewWcKxxGHkdAqoTyBxkgWz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:58.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5039d2d-07d7-4144-d801-08deef48ea92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

From: Iswara Nagulendran <Iswara.Nagulendran@amd.com>

[Why]
ABM does not take effect when brightness
is below twenty percent on VABC LCD panels.

[How]
Create new VESA aux path for brightness
translation functions. When VESA aux enabled
use zero-anchored linear interpolation to
translate instead of the legacy min max
backlight mapping.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/modules/power/power_abm.c | 215 ++++++++++++++++--
 .../amd/display/modules/power/power_helpers.h |   9 +
 2 files changed, 210 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index b26ceaba940d..5e86889eaa84 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -245,29 +245,80 @@ struct iram_table_v_2_2 {
 #define MOD_POWER_TO_CORE(mod_power)\
 		container_of(mod_power, struct core_power, mod_public)
 
+/* Maximum brightness expressed in millipercent (100% * 1000). */
+#define BACKLIGHT_MILLIPERCENT_MAX (100 * 1000)
+
 static uint16_t backlight_8_to_16(unsigned int backlight_8bit)
 {
 	return (uint16_t)(backlight_8bit * 0x101);
 }
 
+/* Caches the link's backlight control type on the panel's backlight
+ * properties so the brightness translation helpers can pick the correct
+ * mapping.
+ */
+void mod_power_set_backlight_control_type(struct core_power *core_power,
+		unsigned int inst, enum backlight_control_type backlight_control_type)
+{
+	if (core_power == NULL)
+		return;
+
+	core_power->bl_prop[inst].backlight_control_type = backlight_control_type;
+}
+
+/* Returns true when the panel uses the VESA AUX backlight control path, which
+ * requires zero-anchored linear brightness interpolation.
+ */
+static bool is_vesa_abc(struct core_power *core_power, unsigned int inst)
+{
+	if (core_power == NULL)
+		return false;
+
+	return core_power->bl_prop[inst].backlight_control_type ==
+			BACKLIGHT_CONTROL_VESA_AUX;
+}
+
+/* Legacy millipercent→millinit conversion: scales linearly between
+ * [0%, 100%] → [min_brightness_millinits, max_brightness_millinits].
+ */
+static unsigned int backlight_millipercent_to_millinit_legacy(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
+{
+	if (core_power == NULL)
+		return 0;
+
+	return (unsigned int)div_u64((unsigned long long)millipercent *
+			core_power->bl_prop[inst].nits_range,
+			100000) +
+			core_power->bl_prop[inst].min_brightness_millinits;
+}
+
+/* Converts millipercent to millinit.
+ * For VESA AUX brightness control, uses simple linear interpolation with
+ * 0% = 0 nits and 100% = max_brightness_millinits.
+ * Otherwise, falls back to the legacy min→max nits range mapping.
+ */
 unsigned int backlight_millipercent_to_millinit(
 		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
 {
-	unsigned int millinit = 0;
-	unsigned long long numerator = 0;
+	if (!is_vesa_abc(core_power, inst))
+		return backlight_millipercent_to_millinit_legacy(core_power, millipercent, inst);
 
 	if (core_power == NULL)
 		return 0;
 
-	numerator = ((unsigned long long)millipercent) *
-				core_power->bl_prop[inst].nits_range;
-	millinit = ((unsigned int)div_u64(numerator, 100000)) +
-			core_power->bl_prop[inst].min_brightness_millinits;
+	if (millipercent >= BACKLIGHT_MILLIPERCENT_MAX)
+		return core_power->bl_prop[inst].max_brightness_millinits;
 
-	return millinit;
+	return (unsigned int)div_u64((unsigned long long)millipercent *
+			core_power->bl_prop[inst].max_brightness_millinits,
+			BACKLIGHT_MILLIPERCENT_MAX);
 }
 
-static unsigned int backlight_millinit_to_millipercent(
+/* Legacy millinit→millipercent conversion: scales linearly between
+ * [min_brightness_millinits, max_brightness_millinits] → [0%, 100%].
+ */
+static unsigned int backlight_millinit_to_millipercent_legacy(
 		struct core_power *core_power, unsigned int millinit, unsigned int inst)
 {
 	unsigned int millipercent = 0;
@@ -280,7 +331,7 @@ static unsigned int backlight_millinit_to_millipercent(
 		return 0;
 
 	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
-		return (100 * 1000);
+		return BACKLIGHT_MILLIPERCENT_MAX;
 
 	numerator = (((unsigned long long)millinit) -
 			core_power->bl_prop[inst].min_brightness_millinits) * 100000;
@@ -290,7 +341,31 @@ static unsigned int backlight_millinit_to_millipercent(
 	return millipercent;
 }
 
-static unsigned int backlight_pwm_to_millipercent(
+/* Converts millinit to millipercent.
+ * For VESA AUX brightness control, uses simple linear interpolation with
+ * 0 nits = 0% and max_brightness_millinits = 100%.
+ * Otherwise, falls back to the legacy min→max nits range mapping.
+ */
+static unsigned int backlight_millinit_to_millipercent(
+		struct core_power *core_power, unsigned int millinit, unsigned int inst)
+{
+	if (!is_vesa_abc(core_power, inst))
+		return backlight_millinit_to_millipercent_legacy(core_power, millinit, inst);
+
+	if (core_power == NULL)
+		return 0;
+
+	if (core_power->bl_prop[inst].max_brightness_millinits == 0)
+		return 0;
+
+	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
+		return BACKLIGHT_MILLIPERCENT_MAX;
+
+	return (unsigned int)div_u64((unsigned long long)millinit * 100000,
+			core_power->bl_prop[inst].max_brightness_millinits);
+}
+
+static unsigned int backlight_pwm_to_millipercent_legacy(
 		struct core_power *core_power, unsigned int pwm, unsigned int inst)
 {
 	unsigned int millipercent = 0;
@@ -362,12 +437,37 @@ static unsigned int backlight_pwm_to_millipercent(
 	}
 
 	/* No interpolation, just take closest index */
-	millipercent = 1000 * 100 * mid / max_index;
+	millipercent = BACKLIGHT_MILLIPERCENT_MAX * mid / max_index;
 
 	return millipercent;
 }
 
-static unsigned int backlight_pwm_to_millinit(
+/* Converts PWM to millipercent.
+ * For VESA AUX brightness control, uses simple linear interpolation with
+ * 0 PWM = 0% and max_backlight_pwm = 100%.
+ * Otherwise, falls back to the legacy LUT based mapping.
+ */
+static unsigned int backlight_pwm_to_millipercent(
+		struct core_power *core_power, unsigned int pwm, unsigned int inst)
+{
+	if (!is_vesa_abc(core_power, inst))
+		return backlight_pwm_to_millipercent_legacy(core_power, pwm, inst);
+
+	if (core_power == NULL)
+		return 0;
+
+	if (core_power->bl_prop[inst].max_backlight_pwm == 0)
+		return 0;
+
+	if (pwm >= core_power->bl_prop[inst].max_backlight_pwm)
+		return BACKLIGHT_MILLIPERCENT_MAX;
+
+	return (unsigned int)div_u64((unsigned long long)pwm *
+			BACKLIGHT_MILLIPERCENT_MAX,
+			core_power->bl_prop[inst].max_backlight_pwm);
+}
+
+static unsigned int backlight_pwm_to_millinit_legacy(
 		struct core_power *core_power, unsigned int pwm, unsigned int inst)
 {
 	unsigned int millinit = 0;
@@ -394,7 +494,32 @@ static unsigned int backlight_pwm_to_millinit(
 	return millinit;
 }
 
-unsigned int backlight_millipercent_to_pwm(
+/* Converts PWM to millinit.
+ * For VESA AUX brightness control, uses simple linear interpolation with
+ * 0 PWM = 0 nits and max_backlight_pwm = max_brightness_millinits.
+ * Otherwise, falls back to the legacy min→max nits range mapping.
+ */
+static unsigned int backlight_pwm_to_millinit(
+		struct core_power *core_power, unsigned int pwm, unsigned int inst)
+{
+	if (!is_vesa_abc(core_power, inst))
+		return backlight_pwm_to_millinit_legacy(core_power, pwm, inst);
+
+	if (core_power == NULL)
+		return 0;
+
+	if (core_power->bl_prop[inst].max_backlight_pwm == 0)
+		return 0;
+
+	if (pwm >= core_power->bl_prop[inst].max_backlight_pwm)
+		return core_power->bl_prop[inst].max_brightness_millinits;
+
+	return (unsigned int)div_u64((unsigned long long)pwm *
+			core_power->bl_prop[inst].max_brightness_millinits,
+			core_power->bl_prop[inst].max_backlight_pwm);
+}
+
+static unsigned int backlight_millipercent_to_pwm_legacy(
 		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
 {
 	unsigned int pwm = (unsigned int)-1;
@@ -431,7 +556,32 @@ unsigned int backlight_millipercent_to_pwm(
 	return pwm;
 }
 
-static unsigned int backlight_millinit_to_pwm(
+/* Converts millipercent to PWM.
+ * For VESA AUX brightness control, uses simple linear interpolation with
+ * 0% = 0 PWM and 100% = max_backlight_pwm.
+ * Otherwise, falls back to the legacy LUT based mapping.
+ */
+unsigned int backlight_millipercent_to_pwm(
+		struct core_power *core_power, unsigned int millipercent, unsigned int inst)
+{
+	if (!is_vesa_abc(core_power, inst))
+		return backlight_millipercent_to_pwm_legacy(core_power, millipercent, inst);
+
+	if (core_power == NULL)
+		return 0;
+
+	if (millipercent >= BACKLIGHT_MILLIPERCENT_MAX)
+		return core_power->bl_prop[inst].max_backlight_pwm;
+
+	return (unsigned int)div_u64((unsigned long long)millipercent *
+			core_power->bl_prop[inst].max_backlight_pwm,
+			BACKLIGHT_MILLIPERCENT_MAX);
+}
+
+/* Legacy millinit→PWM conversion: scales linearly between
+ * [min_brightness_millinits, max_brightness_millinits] → [min_backlight_pwm, max_backlight_pwm].
+ */
+static unsigned int backlight_millinit_to_pwm_legacy(
 		struct core_power *core_power, unsigned int millinit, unsigned int inst)
 {
 	unsigned int pwm = 0;
@@ -460,6 +610,35 @@ static unsigned int backlight_millinit_to_pwm(
 	return pwm;
 }
 
+/* Converts millinit to PWM.
+ * For VESA AUX brightness control, uses simple linear interpolation with
+ * 0 nits = 0 PWM and max_brightness_millinits = max_backlight_pwm.
+ * Otherwise, falls back to the legacy min→max nits range mapping.
+ */
+static unsigned int backlight_millinit_to_pwm(
+		struct core_power *core_power, unsigned int millinit, unsigned int inst)
+{
+	if (!is_vesa_abc(core_power, inst))
+		return backlight_millinit_to_pwm_legacy(core_power, millinit, inst);
+
+	if (core_power == NULL)
+		return 0;
+
+	if (core_power->bl_prop[inst].max_brightness_millinits == 0)
+		return 0;
+
+	if (millinit >= core_power->bl_prop[inst].max_brightness_millinits)
+		return core_power->bl_prop[inst].max_backlight_pwm;
+
+	/* millinit is bounded by max_brightness_millinits (up to ~10^7 for ~10000 nits).
+	 * max_backlight_pwm is a 32-bit value.
+	 * Worst-case product (~10^7 × UINT_MAX ≈ 4×10^16) fits within unsigned long long.
+	 */
+	return (unsigned int)div_u64((unsigned long long)millinit *
+			core_power->bl_prop[inst].max_backlight_pwm,
+			core_power->bl_prop[inst].max_brightness_millinits);
+}
+
 static bool validate_ext_backlight_caps(
 		struct dm_acpi_atif_backlight_caps *ext_backlight_caps)
 {
@@ -716,6 +895,14 @@ void mod_power_update_backlight_on_mode_change(
 {
     struct set_backlight_level_params backlight_level_params = { 0 };
 
+		/* Cache the panel's backlight control type once at mode-change/init
+		 * time. It is a stable per-panel property (decided in the OS shim
+		 * from panel type + DPCD caps), so the brightness translation
+		 * helpers can read it without it being passed on every call.
+		 */
+		mod_power_set_backlight_control_type(core_power, panel_inst,
+				link->backlight_control_type);
+
 		if ((link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
 			link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1) &&
 			link->backlight_control_type == BACKLIGHT_CONTROL_AMD_AUX)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 548c8ff6ddb4..68679fa10946 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -102,6 +102,13 @@ struct pwr_backlight_properties {
 	unsigned int max_brightness_millinits;
 	unsigned int nits_range;
 
+	/* Backlight control type of the associated link. Cached here so the
+	 * brightness translation helpers can select the correct mapping
+	 * (legacy vs. VESA AUX zero-anchored) without threading the type
+	 * through every call.
+	 */
+	enum backlight_control_type backlight_control_type;
+
 	bool backlight_caps_valid;
 	bool use_custom_backlight_caps;
 	unsigned int custom_backlight_caps_config_no;
@@ -190,6 +197,8 @@ void reset_replay_dsync_error_count(struct dc_link *link);
 void change_replay_to_psr(struct dc_link *link);
 void change_psr_to_replay(struct dc_link *link);
 void initialize_backlight_caps(struct core_power *core_power, unsigned int inst);
+void mod_power_set_backlight_control_type(struct core_power *core_power,
+		unsigned int inst, enum backlight_control_type backlight_control_type);
 unsigned int backlight_millipercent_to_pwm(
 		struct core_power *core_power, unsigned int millipercent, unsigned int inst);
 unsigned int backlight_millipercent_to_millinit(
-- 
2.34.1

