Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E005CC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3CC6145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3CC6145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8016ED72;
	Thu, 29 Apr 2021 07:54:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C41E6ED72
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXLxjJ7JubU4LgYFm7Ei7752XkKTTQ7qK7haLNXyOucPBCSz8YK9OFGBT0HSLlsodAVnGBQO3Fo1+A1g+uh7LEQK/IfI2UwGzl+aB5hFJGi0ALZXjVhbxujTlvLFyLfRZUhv4uK8RUH0DaZnC5behxU+WfV/62wbyusVtirTeidRymKmTrPOvuOCML8CpOpBeP9O99inv12wlx7fMlvZdVsENSreLMCJPmW/TH5inJ6IrLchOxOJ5vH3DvIdsPQy+sSzZw0eVgKXqadLfocWz3ALkTRO6xCIX2AWtABhr9k+3NezrpAu1rMafvxnNPA6xPWOGTIqE4IZ9JFYmETpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iwtBC0VarQPOwpJ3MF11u8CpD3gr3w/BvEudgP9HNs=;
 b=aATYxuPGJtuSrHgeZ68CEX7d1vb4iCOFWcdxUI7PQuaEttPfQp3ICR8w4T400HBBZGNOgmSpIAjJ5TH8FogZqI8nMuiWWe91Tdk45rYG+nRHfLKePOOYRaQsm3qhV7Rds+VbnW3bHeiamMxnTMuBhISmV5Iczz0Vl1spG9PwNLNiEAa1eWJluqFr2LXtW4jBIB1ZgHVQ46Y3Dweocjp/AN8p5oV4xKuo/4QCIMJrEXVrrgWsoWbPqhm9GxpIG61arnt9/2BgLEnwfd3288xBnE2p0O22vjSq3hW/eV+m7XDgOJG+38cKUxXp9hHb6nve0LLGDhOt6bEx5pLmj4xSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iwtBC0VarQPOwpJ3MF11u8CpD3gr3w/BvEudgP9HNs=;
 b=p4Tknui3OfKLirDn0DZDF5vbxYKuvKPsk9Zqbv1wb+xhaVmyh8jUtQTUmfSIQFFY/Z+8cJki0zoafJwb6MivThtO009BdHMpw3lQQhrbJS9rmc4CQbVzm+C+9hg8+f2pwrFgFUhbqrmZ6JseH3oh9NHYC4VG+cVF410jVSOlrfk=
Received: from BN8PR15CA0006.namprd15.prod.outlook.com (2603:10b6:408:c0::19)
 by DM6PR12MB4811.namprd12.prod.outlook.com (2603:10b6:5:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:54:11 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::9e) by BN8PR15CA0006.outlook.office365.com
 (2603:10b6:408:c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:09 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: multi-eDP backlight support
Date: Thu, 29 Apr 2021 15:51:53 +0800
Message-ID: <20210429075206.15974-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19590f13-6692-4084-0447-08d90ae3f96b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4811F55E264945A892E4818FFC5F9@DM6PR12MB4811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ung6c6houPsytLManZ0oAlWHFFMD05XsTn6rmmCp++qpM5TsU0QFd2tQ84vlE01ZGNKcjP/B7qJAVgGQJHMKNPJQhGMOEyk4pwdJVUAeh7f17TspSzAJmL6wNuoBO86xc2ucjR//CgSyCd8tXHqyeXFYHbGlqPUs/V1PRrPNROqykJi1Rt7Tr+nIdCiT3lti3e1uydURg03FiIGuJLAD4CHWBBtuS0XU2JkBlJ3qebokWM1+jY/CC7CvcKfGWzuByozvpZ91CU4AjO7OhLW4wDyW6zxBrwcH0KEv0Zxo9HMa6Cx/aaoFTUeXbTRxgWtSkLzRMbfsbjUuFYr4UhxQH0eWjrvo9k+0Z4DP1LMvuGyu82o5AuWpm2kKVO5d27F6DY1TxgHtp3JHndg+b1hjo3Z3sBSTg4BZVBOQ33ovaNTY5uG9Op+fpyf09vcIu4r05E0GVzcQS9FUFAHeS3loA5K4zyGIpPAFackjslF0JpXoIqRDK2FQN++ActyxDSpSc6n9elxy0U1+4NgyKN8FQMxwTgnQEXOWgVE+vlA4L+NU3enLhd3c07RiBd38z92YmaKl5uZfMiF86Hhy8hPdSDZiEkem6iB00i9yPm1WgkgAGhqr0hewuJzuRkmspJBLXnPCtDhMLEOzr8A3W+yv3qQtpJTNsSMKtVUGXv43z/37Q/9LZjsHvKgOEPzcEb3G
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(36860700001)(70586007)(2616005)(356005)(54906003)(26005)(47076005)(336012)(6666004)(478600001)(426003)(8936002)(316002)(8676002)(4326008)(5660300002)(6916009)(7696005)(86362001)(83380400001)(82310400003)(82740400003)(81166007)(2906002)(186003)(70206006)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:10.7610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19590f13-6692-4084-0447-08d90ae3f96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4811
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Currently the assumption is that we are using a single eDP
connector so there will only be one backlight object. Need changes
to allow brightness update and reading for multiple eDP connectors.

[how]
- register a single device
- turn backlight link from a pointer to an array of pointers
- update brightness of all eDP links at the same time when request
is registered
- read brightness level only of the primary eDP panel
- turn current_backlight_pwm and targer_backlight_pwm debugfs enteries
into per connector enteries.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 ++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 86 ++++++++++---------
 3 files changed, 82 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ab854bb131d1..f8f2fde74073 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3415,22 +3415,37 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	struct amdgpu_dm_backlight_caps caps;
-	struct dc_link *link = NULL;
+	struct dc_link *link[AMDGPU_DM_MAX_NUM_EDP];
 	u32 brightness;
 	bool rc;
+	int i;
 
 	amdgpu_dm_update_backlight_caps(dm);
 	caps = dm->backlight_caps;
 
-	link = (struct dc_link *)dm->backlight_link;
+	for (i = 0; i < dm->num_of_edps; i++)
+		link[i] = (struct dc_link *)dm->backlight_link[i];
 
 	brightness = convert_brightness_from_user(&caps, bd->props.brightness);
 	// Change brightness based on AUX property
-	if (caps.aux_support)
-		rc = dc_link_set_backlight_level_nits(link, true, brightness,
-						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-	else
-		rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
+	if (caps.aux_support) {
+		for (i = 0; i < dm->num_of_edps; i++) {
+			rc = dc_link_set_backlight_level_nits(link[i], true, brightness,
+				AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+			if (!rc) {
+				DRM_ERROR("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
+				break;
+			}
+		}
+	} else {
+		for (i = 0; i < dm->num_of_edps; i++) {
+			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness, 0);
+			if (!rc) {
+				DRM_ERROR("DM: Failed to update backlight on eDP[%d]\n", i);
+				break;
+			}
+		}
+	}
 
 	return rc ? 0 : 1;
 }
@@ -3444,7 +3459,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 	caps = dm->backlight_caps;
 
 	if (caps.aux_support) {
-		struct dc_link *link = (struct dc_link *)dm->backlight_link;
+		struct dc_link *link = (struct dc_link *)dm->backlight_link[0];
 		u32 avg, peak;
 		bool rc;
 
@@ -3453,7 +3468,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 			return bd->props.brightness;
 		return convert_brightness_to_user(&caps, avg);
 	} else {
-		int ret = dc_link_get_backlight_level(dm->backlight_link);
+		int ret = dc_link_get_backlight_level(dm->backlight_link[0]);
 
 		if (ret == DC_ERROR_UNEXPECTED)
 			return bd->props.brightness;
@@ -3550,10 +3565,13 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
 		 * DM initialization because not having a backlight control
 		 * is better then a black screen.
 		 */
-		amdgpu_dm_register_backlight_device(dm);
+		if (!dm->backlight_dev)
+			amdgpu_dm_register_backlight_device(dm);
 
-		if (dm->backlight_dev)
-			dm->backlight_link = link;
+		if (dm->backlight_dev) {
+			dm->backlight_link[dm->num_of_edps] = link;
+			dm->num_of_edps++;
+		}
 	}
 #endif
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 0e2496510153..a8966685b708 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -46,6 +46,7 @@
 
 #define AMDGPU_DM_MAX_CRTC 6
 
+#define AMDGPU_DM_MAX_NUM_EDP 2
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -354,7 +355,10 @@ struct amdgpu_display_manager {
 
 	struct backlight_device *backlight_dev;
 
-	const struct dc_link *backlight_link;
+	const struct dc_link *backlight_link[AMDGPU_DM_MAX_NUM_EDP];
+
+	uint8_t num_of_edps;
+
 	struct amdgpu_dm_backlight_caps backlight_caps;
 
 	struct mod_freesync *freesync_module;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8bf0b566612b..9fbbd0159119 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2377,6 +2377,44 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 	return size;
 }
 
+/*
+ * Backlight at this moment.  Read only.
+ * As written to display, taking ABM and backlight lut into account.
+ * Ranges from 0x0 to 0x10000 (= 100% PWM)
+ *
+ * Example usage: cat /sys/kernel/debug/dri/0/eDP-1/current_backlight
+ */
+static int current_backlight_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(m->private);
+	struct dc_link *link = aconnector->dc_link;
+	unsigned int backlight;
+
+	backlight = dc_link_get_backlight_level(link);
+	seq_printf(m, "0x%x\n", backlight);
+
+	return 0;
+}
+
+/*
+ * Backlight value that is being approached.  Read only.
+ * As written to display, taking ABM and backlight lut into account.
+ * Ranges from 0x0 to 0x10000 (= 100% PWM)
+ *
+ * Example usage: cat /sys/kernel/debug/dri/0/eDP-1/target_backlight
+ */
+static int target_backlight_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(m->private);
+	struct dc_link *link = aconnector->dc_link;
+	unsigned int backlight;
+
+	backlight = dc_link_get_target_backlight_pwm(link);
+	seq_printf(m, "0x%x\n", backlight);
+
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -2611,6 +2649,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
 
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
 
+DEFINE_SHOW_ATTRIBUTE(current_backlight);
+DEFINE_SHOW_ATTRIBUTE(target_backlight);
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -2634,8 +2675,13 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					    dp_debugfs_entries[i].fops);
 		}
 	}
-	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
+	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
+		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
+				    &current_backlight_fops);
+		debugfs_create_file("amdgpu_target_backlight_pwm", 0444, dir, connector,
+				    &target_backlight_fops);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
 		debugfs_create_file(connector_debugfs_entries[i].name,
@@ -2938,38 +2984,6 @@ static ssize_t dtn_log_write(
 	return size;
 }
 
-/*
- * Backlight at this moment.  Read only.
- * As written to display, taking ABM and backlight lut into account.
- * Ranges from 0x0 to 0x10000 (= 100% PWM)
- */
-static int current_backlight_show(struct seq_file *m, void *unused)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct amdgpu_display_manager *dm = &adev->dm;
-
-	unsigned int backlight = dc_link_get_backlight_level(dm->backlight_link);
-
-	seq_printf(m, "0x%x\n", backlight);
-	return 0;
-}
-
-/*
- * Backlight value that is being approached.  Read only.
- * As written to display, taking ABM and backlight lut into account.
- * Ranges from 0x0 to 0x10000 (= 100% PWM)
- */
-static int target_backlight_show(struct seq_file *m, void *unused)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct amdgpu_display_manager *dm = &adev->dm;
-
-	unsigned int backlight = dc_link_get_target_backlight_pwm(dm->backlight_link);
-
-	seq_printf(m, "0x%x\n", backlight);
-	return 0;
-}
-
 static int mst_topo_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
@@ -3152,8 +3166,6 @@ static int visual_confirm_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SHOW_ATTRIBUTE(current_backlight);
-DEFINE_SHOW_ATTRIBUTE(target_backlight);
 DEFINE_SHOW_ATTRIBUTE(mst_topo);
 DEFINE_DEBUGFS_ATTRIBUTE(visual_confirm_fops, visual_confirm_get,
 			 visual_confirm_set, "%llu\n");
@@ -3233,10 +3245,6 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
 
-	debugfs_create_file("amdgpu_current_backlight_pwm", 0444,
-			    root, adev, &current_backlight_fops);
-	debugfs_create_file("amdgpu_target_backlight_pwm", 0444,
-			    root, adev, &target_backlight_fops);
 	debugfs_create_file("amdgpu_mst_topology", 0444, root,
 			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
