Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A939FC38BE0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 19:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AF620838
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j8PQFmu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AF620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183886E92F;
	Mon, 24 Feb 2020 19:56:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F536E92F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 19:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQn3wB/6vZTf+pJgsn3kiT1GOJl1buI9gmWd13lA6E2siQKGUG4upwD28lIaki9TyvABlpUrUh4w3DpnyZg5ygd0+lm+n+JyiZvXOXk1ZyQiWiViIeorFHa7JOzjeLCoWhaD+a3RMP5dP3bvUELZiqlAYRjZ218ayM42XnidOJLpWdoeJLERekRH7G0/8JxMWz0VJgVErtPN+qjatKKOlmFPS9LC9Bs8pqUqXzdZsWuLUrJgGNN5/enHRiIhRPLiTxIAwPtJ/EGODAmRo7P8pQQyFy6cEkLuE2A42ouHmEudqIWlRsNMvO9rtWmejNetbybID0oTHFZhViv+AVtPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YcdRFFNpM+ppPwnzAcVTkiR5upVfuZAd4viWgWXXs0=;
 b=ltHtaFqOb1mdORCgC7xVEOytD8qsI0Xe63uoQeNkCGuhxpkZW89qDFnWVU1jBiluIwPbo8A5gz1qHXcTFyOiDaM7Nu3N2KOCxLvFULaQI4+CEUTUSXpc3oaeuUn/VXGWdhc4tXI561DYZ8YTHeq/U+k1BHgz/DOJfTTYvaJYUh0/5BZnUmCGuPGZJUpzQ+fP9Mnfevzem4HtLcBnytDDn74jektiNA9sDBEJGuQ7VRprsWIxbVoOUt1AYqQkqXWKhof7OtCNlXROCnCnBEJLdSw6PYXp4cToti2G09uXSWvE5c0AO8CB8yCYyhU4ShTJbE3dYHOFNqCT9uhz8WASCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YcdRFFNpM+ppPwnzAcVTkiR5upVfuZAd4viWgWXXs0=;
 b=j8PQFmu+6AcSZQHCY48WVmwCyVurzf32WlIoarNUN8y9v0J0SH5Xqu7WsW7BEx29A/a+3UlfhvGO4ojppyHrLvGtARjVguSBgxsV6c3GgcF+iQoxVLitBCXWNEh1t0c04ZxTET9dBT0TSwqxX3fbECtACry1glNwvnRwnYy86T8=
Received: from DM5PR15CA0072.namprd15.prod.outlook.com (2603:10b6:3:ae::34) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 24 Feb 2020 19:56:09 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::a3) by DM5PR15CA0072.outlook.office365.com
 (2603:10b6:3:ae::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Mon, 24 Feb 2020 19:56:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 19:56:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 13:56:07 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 13:56:07 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 24 Feb 2020 13:56:07 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add HDCP caps debugfs
Date: Mon, 24 Feb 2020 14:55:53 -0500
Message-ID: <20200224195553.28137-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(428003)(199004)(189003)(2616005)(186003)(7696005)(36756003)(336012)(478600001)(316002)(26005)(426003)(356004)(81166006)(5660300002)(110136005)(6666004)(8676002)(70586007)(70206006)(2906002)(1076003)(54906003)(4326008)(86362001)(81156014)(8936002)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4287014-a6cc-496c-87b8-08d7b963978f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41550D8855522A13B1B091E9F9EC0@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTpL/PfILC2wEUQI+ibYA7XslxGzMpEkmtMwhnerj161nS1O4VlAa5JQJwHv+RVKdI05hzYAUWcFZeSI105KOstRXPSp0XadrxzA5ZO82rMBcUjlVhynVTXbyGjcHYYLcedvl4/QdAPaGPXV9aWWdeBx1JKKbiqcyTnA7dF0IQTnSnRV1zV4Fpc6dT06X6AAP0KNDOPZaIvMpAKXxeId1ljhEt5euScICLCgQHls38AW4yloa0xMwQAqO94H4V3UFBnkmE5Dg+WSH1Bua6DltzK/RXO5//EspwXpe7s8mcMLnQEfjI/QQx+9gswJVZKuprCODq3S568USgp8fVELD3jglt7YIi2CJ2O43LYFN4XUm/i6uxd+gy+HNBRmfdBWM7rlynhrdNzeEEDbeNI/ppi9SXUymnLvR+pg3UDXLt+Sg2HgRMRSXdQuVJsis1vuetCLD6CZGOmfw3QCPZrma6zoggDlzRsUtUkxJO67nJ4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 19:56:09.0981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4287014-a6cc-496c-87b8-08d7b963978f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index ead5c05eec92..52982c8c871f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -815,6 +815,44 @@ static int vrr_range_show(struct seq_file *m, void *data)
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
@@ -940,6 +978,9 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
 DEFINE_SHOW_ATTRIBUTE(vrr_range);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
+#endif
 
 static const struct file_operations dp_link_settings_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -995,12 +1036,23 @@ static const struct {
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
@@ -1066,6 +1118,15 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	debugfs_create_file_unsafe("force_yuv420_output", 0644, dir, connector,
 				   &force_yuv420_output_fops);
 
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
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
