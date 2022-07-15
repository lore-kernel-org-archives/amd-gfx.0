Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF86CCA482
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE44210EAD8;
	Sat, 16 Jul 2022 14:36:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB3810E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk2s8jvZFF2kP0jSXNimz7f0TD6LTGeFdOXuEXx5ToEyJ9Vb+kBABx5xOc30BluH1dXQgYEIoQvWnp4ZD1o0ppf3BMjk2TrYHNUDkpEVjzlpvU7+djj9QEBnlcXIpUGWzLxXprjpkh/+pGyVWwPw0jXhvid+mpIOu5Op+iK/ojiGcj2IcvlZ/jRxJvlYe5Ih0ZlFerQM7OPd02M5tQcKBHPpKRVTAhgovMqyk1n7oFlMH2MObGWNqFW71mahUkRJ4w2pRMwwXhTzdtxGLBK1HG9eHrzzuy6EJEbvd8DmHmWzYRJGzm7GKPQ2J7WptQwlMmcMlaf0bPwEAXf11vsWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOjljiJiBO0FrtlP7QJGgr7cpeGCRBndGG9uCboU4UE=;
 b=c/WhSv/e1JxhgXb9K2NYz1M0wZpQCHJui9V50xXPFSKXj0LxFXJBa3wE0WoacdYYQp1Tvs9TGGnKDw6WhmTQgsiDTOOoYWgGKjdxNW3dVqA+Ddr4gb0nfD6enIyex1MXaKDs5CveUW6ug8ZDV9wFheibHNxXxhtm7uJuHhSNuxKg+vlJyJBJ7IWN0W0LeDg4RlLzYfa2r5UHCov0l1QztUX9kEE0O8WdVj8zTntrJDr4DiJ9tKAEa5Tx25eFVJKlXCY+X48YVaRkrNSeHWQ05V6/rKtZdAccZIYbTOqL3gMxrG0sxroNw19ThLZYNMDCsa2AGAEe1coNRAslqfhIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOjljiJiBO0FrtlP7QJGgr7cpeGCRBndGG9uCboU4UE=;
 b=zmnF9APkdZE6zqRlRNw6O/K+GRVU8h5/KdJndWxOFKEZVBiVQXllVEgm2LiHjiwJpndTFHgFfhIlUbHslU3CuxHxufU2tg5r9vh5RGQwMghKKtPVQmEDKLt1CQfKXiHT9cmTp9kaHG+/w4/JN5DURXd3tUewqhN95thSl9LxFcg=
Received: from MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19)
 by DM6PR12MB4604.namprd12.prod.outlook.com (2603:10b6:5:169::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Fri, 15 Jul
 2022 18:17:30 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::c6) by MW4P221CA0014.outlook.office365.com
 (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:28 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:23 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/31] drm/amd/display: Add is_mst_connector debugfs entry
Date: Fri, 15 Jul 2022 14:16:40 -0400
Message-ID: <20220715181705.1030401-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249f3af4-6a27-4550-0aad-08da668e47d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4604:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Rm1y0kLcYjIVaN8tilO1RHb83vITReZ/pArTnWfubHGi09EdmXeN1zC+tbJT6OU5KlgSb+GG5rl6m8mzGYtRNYFjl8rtbf60RhVEqmXAcTX8PXGiLZ85eq7PBT/fwJc+N5AZZbh5VuONsWfg2dgZYAYe8kWx5w12Du9O12fdjWdWIUN3sHMcdSyKzy+YKUz/mZ6ihcYUXnoKbgjFveTAiPL/TVLLXAv8IC/UOPA3F1MbNXcXlBWgFZUPrFjmJhcK2rUEOrv5XUBFN32mn/JrmSlXkv+EX4fRiupymg7Iofa6SqTLcOyvx+hbKfIEvu/h4FfLHSj+9DQxDdz708qiWq7ekOFgfH82f4Dx5NZXMr+5vf7YkwXvrBlRUdInwc66AxPuw/bXjY0oC6VzQpjNEo6ctHLELdsrv4HpUJPf0H1qtHMHfTSHEq79r3CE+cMgx+1z+ComcMbBepGiLvSoBhbanWFOsqbvhak5XKvjjle03JbH7mF4ZMbVEElWbIaqPWML1LsKPBx6m0Yv2OlaC3a3zar8e3PxAC5CXOaxhO/jesvzjaXUC2xcIsWdFOxilq/GRWqlyg92thqBDLwsmcGGtJ3agpvcqB/hakJHJpV08xI5JEpf+aqJCKmUU3jxitdVF8Kl4gFXIhLigrsvROAwxV+l8gYjrPCHPxOtLsjCj2d50gXoLj9OEgJiqh9hXw7VyrYBwNhmo8RpLz1AOKDlHzXvgfj45kB64OQW8uAO9kNMv+F3BWJF3Hrk9Phz+p2fPVEBus3IKYHHwJHRy59SIIer29k+TyYGY3f8rmdumQ7t8JiZDwF0Z4b8f9ZQX4fq1WIJKG3gpm0Y9av3H/8f2fN93SQPN4X9DtwrOA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(40470700004)(54906003)(478600001)(45080400002)(6916009)(81166007)(36756003)(4326008)(316002)(186003)(82740400003)(2616005)(6666004)(41300700001)(26005)(426003)(70586007)(1076003)(8676002)(86362001)(70206006)(5660300002)(336012)(40480700001)(2906002)(8936002)(82310400005)(36860700001)(356005)(83380400001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:30.1070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249f3af4-6a27-4550-0aad-08da668e47d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4604
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Add "is_mst_connector" debugfs entry to help distinguish whether
a connector is in a mst topology or not.

Access it with the following command:
    cat /sys/kernel/debug/dri/0/DP-X/is_mst_connector

Result:
- "root" stands for the root connector of the topology
- "branch" stands for branch device of the topology
- "end" stands for leaf node connector of the topology
- "no" stands for the connector is not a device of a mst topology

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b764198eca5c..991e58a3a78c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2557,6 +2557,57 @@ static int target_backlight_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/*
+ * function description: Determine if the connector is mst connector
+ *
+ * This function helps to determine whether a connector is a mst connector.
+ * - "root" stands for the root connector of the topology
+ * - "branch" stands for branch device of the topology
+ * - "end" stands for leaf node connector of the topology
+ * - "no" stands for the connector is not a device of a mst topology
+ * Access it with the following command:
+ *
+ *	cat /sys/kernel/debug/dri/0/DP-X/is_mst_connector
+ *
+ */
+static int dp_is_mst_connector_show(struct seq_file *m, void *unused)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct drm_dp_mst_topology_mgr *mgr = NULL;
+	struct drm_dp_mst_port *port = NULL;
+	char *role = NULL;
+
+	mutex_lock(&aconnector->hpd_lock);
+
+	if (aconnector->mst_mgr.mst_state) {
+		role = "root";
+	} else if (aconnector->mst_port &&
+		aconnector->mst_port->mst_mgr.mst_state) {
+
+		role = "end";
+
+		mgr = &aconnector->mst_port->mst_mgr;
+		port = aconnector->port;
+
+		drm_modeset_lock(&mgr->base.lock, NULL);
+		if (port->pdt == DP_PEER_DEVICE_MST_BRANCHING &&
+			port->mcs)
+			role = "branch";
+		drm_modeset_unlock(&mgr->base.lock);
+
+	} else {
+		role = "no";
+	}
+
+	seq_printf(m, "%s\n", role);
+
+	mutex_unlock(&aconnector->hpd_lock);
+
+	return 0;
+}
+
+
 DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
 DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
@@ -2567,6 +2618,7 @@ DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 #endif
 DEFINE_SHOW_ATTRIBUTE(internal_display);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
+DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
@@ -2710,6 +2762,7 @@ static const struct {
 		{"dp_dsc_fec_support", &dp_dsc_fec_support_fops},
 		{"max_bpc", &dp_max_bpc_debugfs_fops},
 		{"dsc_disable_passthrough", &dp_dsc_disable_passthrough_debugfs_fops},
+		{"is_mst_connector", &dp_is_mst_connector_fops}
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.37.0

