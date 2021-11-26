Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158BBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975206EA4F;
	Fri, 26 Nov 2021 19:49:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588506E3EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhmMp61wrLkekWD86iiOwgsh+lUMNQ50GNXxFmwV8TkdIccwVYbBgJPhvmP3FkXhVburthud1whiXhv3tVMpQ4f1ssYV42wgp1QkSLAj2eOyRQ1wPIFBCmhQCzFHnmP0+QwFaHa52Fb5fjZxuMNzALtu3kKGCvtJC9qcqnLZ0rF/qzRKXWTjX09AXI2AdcHQ6Gft8d7ea6gf3ielmMxNy83gAk3zbkpAYz4ZdwuMoPx1SRPdS9+Y4IaZlFXL7vZP/9KMMat/msFPCdkVApv6vpQrPXnEJgNXYfZa8+Qs4a9gjF8GJKzdBtGLMxiY2viyVheXNVw9jmIQKy5GK0adbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAWy2hA9uo5Td/Puwc4J7iPnq7UdJaPqxCtCB7cTK7s=;
 b=crp8iojlrpKisHyrBqszWNB7gERRLoPkdptvD+8seIZNHr5aWX7ve/Tt3nCYjblrcaGFJgFF8hEMCCP+2iUKMiJuLmLQCq7f7B1WkZRv0mnvX97NwnfpkoAECfho0fpDs+3u3zZcrf24J7Vx1nZyAcjST2cRDQwsLJH9G4ot6c/38paeo1jvkqyq8nj+9tPNi+bGUICQSbZ0Gb8lGZys61Fwer3ndIesy44HbtbLue6ztQ51Emut5BRcNHZ2gaI58RiKGQF14YTJ8WlruvBNP6rlGyk2EFu0s/hFE5prDVUPQ7ZiML/koqYiUmL0bkKQVS0s+4BpEIVFi9ovElEdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAWy2hA9uo5Td/Puwc4J7iPnq7UdJaPqxCtCB7cTK7s=;
 b=Lyb1uJq1Sm9qYI/jiVYEiN79XM5KcdQmdi3FHAkk7QtW0jk3npitXsIctKB19pqk1mdsXiA+Dz9b2ECqL2RSJescp62mK+qMFbFSEDxHgpLeeHlczfVkuykIa2aPSHifRIT7kxIULCZiEJxeDy9F7nUHPn/vF3XP1C+ovsGXjWA=
Received: from BN6PR19CA0119.namprd19.prod.outlook.com (2603:10b6:404:a0::33)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 19:49:41 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::80) by BN6PR19CA0119.outlook.office365.com
 (2603:10b6:404:a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:36 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:36 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: PSR panel capability debugfs
Date: Fri, 26 Nov 2021 14:49:16 -0500
Message-ID: <20211126194922.816835-11-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26ddc66-3102-43c5-8d0e-08d9b115e367
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40938EF5E9A89B58DB8CC6BAF9639@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsKWPcz4O5308itKUMFCvYPQSGREg1SQrEZQTWDaF/qG6ctF+uNvA1fhppZFOPMv1F7UKj57mf7QtP6Dwqxy8bO9KfmEOAelDEzGi2aVIlzv2NtdMv8hEmyq4Jq31mDuPD/J0r4ly3KR3TAT/yP16m/xGD1zpdsnONG8qVUI1SwCMD4XwN+V1W7kJ80uYB1easRym/6RFuEjq0X8j/qWWBEEDe2kLZ7tnhgwUk1QGXGzvQ6iifrnykyhzKAWNIwlhoQyGib4A02I8YzdFNPdvkTDgXyvXwKQ/m4dmVd1SBbPMkmUpfPADcoGTfvyXYMcikQjN2A0KjWVn8gCSF7+bZKI4VFA/OMDUPZobVquyuSJnEILF3INi8N7myKNFAbqamiLTqXrhnXOYF7P0qC6LAVGT79RUipiE+slEkhkVp1pglBRSxgorSfo1Owma3sh2V3c/a1CVHSQhYz1yeFhr5Rqdl1NFtuJ/tF7pdYjVpXSNftGF6GqJHUHWkr4sG/FOcR3H60PSx6ckkBFXm/2Gb+eRHOnPRf2zJHpHuB/NinsCxGXN0tBeWz2Yrd3RYrp2Lgw5HZXumaQE9KcIXxD5CmEA3VrYw3EZU7WZmbv3vtZnoFnBAgBvrbKWoy/bYQMGpxknK0kBWSo7fF/k8R1VyHMtiv9C/hkemvD/vE0AJ7F4Lqh2Ftb8YXLMJBEeJrd5cpvAjAN49nXD9f5a6LYLH8CP+b9ks2vNwcKPNwn8mw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(316002)(86362001)(26005)(186003)(47076005)(82310400004)(70206006)(6916009)(54906003)(356005)(336012)(426003)(2616005)(70586007)(8936002)(2906002)(4326008)(81166007)(5660300002)(8676002)(36756003)(83380400001)(36860700001)(1076003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:41.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26ddc66-3102-43c5-8d0e-08d9b115e367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Adding a debugfs to show PSR capability of the panel and the driver.
To use:
  cat /sys/kernel/debug/dri/0/eDP-X/psr_capability
Expected output:
 Sink support: no/yes
 Driver support: no/yes

[how]
Adding psr_capability to eDP connectors.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9d43ecb1f692..d7f8883cd4ff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -824,6 +824,48 @@ static int dmub_fw_state_show(struct seq_file *m, void *data)
 	return seq_write(m, state_base, state_size);
 }
 
+/* psr_capability_show() - show eDP panel PSR capability
+ *
+ * The read function: sink_psr_capability_show
+ * Shows if sink has PSR capability or not.
+ * If yes - the PSR version is appended
+ *
+ *	cat /sys/kernel/debug/dri/0/eDP-X/psr_capability
+ *
+ * Expected output:
+ * "Sink support: no\n" - if panel doesn't support PSR
+ * "Sink support: yes [0x01]\n" - if panel supports PSR1
+ * "Driver support: no\n" - if driver doesn't support PSR
+ * "Driver support: yes [0x01]\n" - if driver supports PSR1
+ */
+static int psr_capability_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dc_link *link = aconnector->dc_link;
+
+	if (!link)
+		return -ENODEV;
+
+	if (link->type == dc_connection_none)
+		return -ENODEV;
+
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+		return -ENODEV;
+
+	seq_printf(m, "Sink support: %s", yesno(link->dpcd_caps.psr_caps.psr_version != 0));
+	if (link->dpcd_caps.psr_caps.psr_version)
+		seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_caps.psr_version);
+	seq_puts(m, "\n");
+
+	seq_printf(m, "Driver support: %s", yesno(link->psr_settings.psr_feature_enabled));
+	if (link->psr_settings.psr_version)
+		seq_printf(m, " [0x%02x]", link->psr_settings.psr_version);
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
 /*
  * Returns the current and maximum output bpc for the connector.
  * Example usage: cat /sys/kernel/debug/dri/0/DP-1/output_bpc
@@ -2467,6 +2509,7 @@ DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 #endif
 DEFINE_SHOW_ATTRIBUTE(internal_display);
+DEFINE_SHOW_ATTRIBUTE(psr_capability);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2726,6 +2769,7 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 		}
 	}
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
+		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
 		debugfs_create_file("amdgpu_current_backlight_pwm", 0444, dir, connector,
 				    &current_backlight_fops);
-- 
2.25.1

