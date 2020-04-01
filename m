Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB36C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F286C2054F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="csfzUIXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F286C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA586E99F;
	Wed,  1 Apr 2020 21:00:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5EF6E99E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 21:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqYk5aBq0HCSSdWWIvvDWcUXFGKuvRt0kIHJoAgAN3ds4xwnhGlbx4AvbvIopLseO/7jLKB9RgOzT4ko82hfdaANXwBQ77VR0gvZ9l6ghDDB7va9uHhd6B0TGq1Z2ZQr+bv/Oa5gbuyy+yCyTDamHiJRJ6LaSoQeDNyvo0ZZuaZD32PbIXRYhFJnOHOcY0dhUlQZtdI+ITxX5YcZTkr02eNDrjGpdXrNS7wACihmbf+ez2qAs4pR7vq5hmlpa+32qccRan6NUkG2DhNH1exOE45AEC8c6rGYoqlg4WtusZLoDwsI5dJyHkXKUasjdSAioZxi/Y9xjeScsypSylXAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiYHiLX1tDM+KluF7cKdk4Bea/9X2RAy0y8omjVYJuM=;
 b=kg8SNNhHaoJr9KSYXHhEH3hkwfRho8B0z3sHRlIBWnivzCuW6xRiTs4mKabh7+S9B/u/BJGhFD+s+gE1skhfle+Gjvi6sW7J0W8naSl5f/7pI6X9thgQ/AmHXbGfurQ+rW0BYuXs8Jt3mm77oRMyrWqSkBX5+4UCyplys1GC1+GM1nFkVjjjlsSqUc3IxvkFYwKSD3qr7FWF6A3Yi0ampAnEJX8cOd89eKamLqJHPzPm8hHzDlQfAxsce6PFr10G4oPXG5cizKMe3bRkVR1Ifm9fB8UnLUXsm69JNvKBTVjjWAlotwE8FYU7AhfmV5E9nQNoHxDd4ae2L/A2R/mQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiYHiLX1tDM+KluF7cKdk4Bea/9X2RAy0y8omjVYJuM=;
 b=csfzUIXiLyN+bgEbc9npii9/ZaXpapN+QdO9Y+3dXb0YsShEHjmGJf32JosgY/mgQ5ZqJAAm2RsMmOvnPxiC9t5CXXUH0tCBc0VW+KG3Qpyj1RWH9YPaJctGkslBPNXygcwnKW0WwgTSZruLmSDSb2ujBVmid720HnGo3BLBfmo=
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 21:00:45 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::cb) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 21:00:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 21:00:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 16:00:44 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 16:00:44 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 16:00:43 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: add HDCP caps debugfs
Date: Wed, 1 Apr 2020 17:00:31 -0400
Message-ID: <20200401210031.23220-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
References: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(428003)(46966005)(1076003)(5660300002)(8936002)(2616005)(81156014)(336012)(186003)(26005)(36756003)(426003)(47076004)(316002)(70206006)(8676002)(86362001)(81166006)(4326008)(82740400003)(70586007)(6916009)(6666004)(54906003)(478600001)(356004)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b4ee0b-49eb-40a3-e45c-08d7d67fbef9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3831179937351E851BFE9164F9C90@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHYpABD81Q/4ROrhTW3aWgTXClWMmaC2toSeK1ns9wA+fg86ImUUlxFuZGxnyVtqsEkin3JE5+lFQS39qzbPGllzKSQGfrkwifMkfg0INU/x8Bm5Gld7znJYRFlXSwmXCM1IGY6MR2scI7JXaGVLAvHxkNhTi+952WtHpVrKAbgN787B/L19PBUoyoYs0vfoFQs8EbK8aWluyPZ64RHnQxMCO0Pj1YUqTJFMtLX/aANwnXHICmCL/YZbM8nkjV078BkoxJMmx4gLJFwbJ9CknDV3ZQjHTLtgQ3BALZz2Ubrzu+jeZN7/LVwIsU2LI7HBSKhWNhiA3Y8srYTJXouc+/YISa56Tj1jsawbMVDbNX0EM4qadzw6fXQb0F0Kw9MvRc9SJLnjoNwbKVKiHDD870VaPGNQ252miYdYEjB/zkylX8/X30nY9W14uwziTN3FU38iSS2jxlaqPrmqmhePOr/zk97142hMKVBa2THfbfSaerxA5edKBc4zhZwM82Au0S+OKjxaOBcGREfSIJ9a5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 21:00:44.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b4ee0b-49eb-40a3-e45c-08d7d67fbef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add debugfs to get HDCP capability. This is also useful for
kms_content_protection igt test.

Use:
	cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
	cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 61 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 47 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  4 ++
 3 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0461fecd68db..4b695f6a80c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -838,6 +838,44 @@ static int vrr_range_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+/*
+ * Returns the HDCP capability of the Display (1.4 for now).
+ *
+ * NOTE* Not all HDMI displays report their HDCP caps even when they are capable.
+ * Since its rare for a display to not be HDCP 1.4 capable, we set HDMI as always capable.
+ *
+ * Example usage: cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
+ *		or cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
+ */
+static int hdcp_sink_capability_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	bool hdcp_cap, hdcp2_cap;
+
+	if (connector->status != connector_status_connected)
+		return -ENODEV;
+
+	seq_printf(m, "%s:%d HDCP version: ", connector->name, connector->base.id);
+
+	hdcp_cap = dc_link_is_hdcp14(aconnector->dc_link);
+	hdcp2_cap = dc_link_is_hdcp22(aconnector->dc_link);
+
+
+	if (hdcp_cap)
+		seq_printf(m, "%s ", "HDCP1.4");
+	if (hdcp2_cap)
+		seq_printf(m, "%s ", "HDCP2.2");
+
+	if (!hdcp_cap && !hdcp2_cap)
+		seq_printf(m, "%s ", "None");
+
+	seq_puts(m, "\n");
+
+	return 0;
+}
+#endif
 /* function description
  *
  * generic SDP message access for testing
@@ -964,6 +1002,9 @@ DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
 DEFINE_SHOW_ATTRIBUTE(vrr_range);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
+#endif
 
 static const struct file_operations dp_link_settings_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -1019,12 +1060,23 @@ static const struct {
 		{"test_pattern", &dp_phy_test_pattern_fops},
 		{"output_bpc", &output_bpc_fops},
 		{"vrr_range", &vrr_range_fops},
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
+#endif
 		{"sdp_message", &sdp_message_fops},
 		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
 		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
 		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops}
 };
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+static const struct {
+	char *name;
+	const struct file_operations *fops;
+} hdmi_debugfs_entries[] = {
+		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
+};
+#endif
 /*
  * Force YUV420 output if available from the given mode
  */
@@ -1093,6 +1145,15 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	connector->debugfs_dpcd_address = 0;
 	connector->debugfs_dpcd_size = 0;
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {
+		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
+			debugfs_create_file(hdmi_debugfs_entries[i].name,
+					    0644, dir, connector,
+					    hdmi_debugfs_entries[i].fops);
+		}
+	}
+#endif
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 49c63e27dfe9..e8b5d7a22ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -515,6 +515,53 @@ static void link_disconnect_remap(struct dc_sink *prev_sink, struct dc_link *lin
 }
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
+bool dc_link_is_hdcp14(struct dc_link *link)
+{
+	bool ret = false;
+
+	switch (link->connector_signal)	{
+	case SIGNAL_TYPE_DISPLAY_PORT:
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		ret = link->hdcp_caps.bcaps.bits.HDCP_CAPABLE;
+		break;
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+	/* HDMI doesn't tell us its HDCP(1.4) capability, so assume to always be capable,
+	 * we can poll for bksv but some displays have an issue with this. Since its so rare
+	 * for a display to not be 1.4 capable, this assumtion is ok
+	 */
+		ret = true;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+bool dc_link_is_hdcp22(struct dc_link *link)
+{
+	bool ret = false;
+
+	switch (link->connector_signal)	{
+	case SIGNAL_TYPE_DISPLAY_PORT:
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		ret = (link->hdcp_caps.bcaps.bits.HDCP_CAPABLE &&
+				link->hdcp_caps.rx_caps.fields.byte0.hdcp_capable &&
+				(link->hdcp_caps.rx_caps.fields.version == 0x2)) ? 1 : 0;
+		break;
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		ret = (link->hdcp_caps.rx_caps.fields.version == 0x4) ? 1:0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 {
 	struct hdcp_protection_message msg22;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 0077f9dcd07c..e131dc99f283 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -293,6 +293,10 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type);
  * DPCD access interfaces
  */
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+bool dc_link_is_hdcp14(struct dc_link *link);
+bool dc_link_is_hdcp22(struct dc_link *link);
+#endif
 void dc_link_set_drive_settings(struct dc *dc,
 				struct link_training_settings *lt_settings,
 				const struct dc_link *link);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
