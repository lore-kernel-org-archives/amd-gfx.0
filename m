Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE438C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E8A10E736;
	Tue, 22 Jul 2025 22:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6piEuWU";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD9110E737
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpU88rc8gREIoc5aC2mq2ldUjQ/3qmaBcPfLGKTTVOq0PH4mjGsUrPjKO7xNPhA244XOSQF7QH5WEIFpoecdoepCj5Mk9P6yOYoIc83PZlnMRLbD5b/FuBH7KdJpHgmA5HRGsx07Vn8XmB34fa+N9FEsJTS+YDRJmnv3ez684F+qMUJxbW8KYM6/CkhXZRkULJLYxo9/rebmc4WXj6QJ+DcxENhpwtRQvfpBoYXdHwsCOHwFNn/Is6LFnumH/w21NGb3Es+jValGXiC4FmeqyRGoolQKuOp5hQ7OYEDgPJwxoLCD+W0Hn6xodaeXw7+dCEwkOHD48AOcIFPONwXSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AYztXn6Wa5kifv1l794Ah5WuW69dFbDpGMZqW8Jbis=;
 b=KCm03KDTZQhmG3KxysMT9Biz77F8zrCx+DOxwYgFwGtCfeensRCjoJtPCZWp67LZndZynfOF+hNa/YFHHAGZfKArgEH4K4uB8ZEU0eEaTgMevknqilExzh+FEYN84JYkWKPA15qAaS7Bx6eDf/w3jJPrwrfKN6P2ytjjt8FNH8Fymxad7yKhmA525/GblTUnuQ+DFIHzhTMuctNf3IOhknuyKf+mAgjz3NuuF8Oj3kl1PJreBcLLHGNZ/MrBPD6R95U689cSFoMhULJk6qfLl5sxjJGe7y3+/AJlniuSxbUPbXeF9+eUMZspdPLvoLGdHJfTA1+BjKhkURiKrQRFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AYztXn6Wa5kifv1l794Ah5WuW69dFbDpGMZqW8Jbis=;
 b=e6piEuWUTAxtrYXaD2tfF+bLAF+dQTyV2a5IftbbRNeUT7D2d1Hc/yy8povR6LmKd7wzoCBoPW8X/FBm98L6aKEociZ1Vf8/aq9hF8sXTTunV//bAs25QkONQyFZa3cEwwkCLaUnvnaL+xLc2XU1XRqgRGAUto7luFE+bQqUkT4=
Received: from BYAPR06CA0001.namprd06.prod.outlook.com (2603:10b6:a03:d4::14)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 22:46:09 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::39) by BYAPR06CA0001.outlook.office365.com
 (2603:10b6:a03:d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 22:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:46:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:05 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:45:59 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 20/25] drm/amd/display: Add Replay residency in debugfs
Date: Tue, 22 Jul 2025 18:44:29 -0400
Message-ID: <20250722224514.2655899-20-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f8b79d-8e46-4a02-caea-08ddc9718cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AY4kHmGYnelyHYBwJtI8gu7j/wq/mE+tQ44gTVN764arvNHx0NctNTxNj322?=
 =?us-ascii?Q?kLiTj8B/MtyDlssmp1OwuTVMgBnSKcNW7qx5PVSHWl1g09WwH8e8A8MKxQ0L?=
 =?us-ascii?Q?xSl7+SCIbuBhxJdEBWOJ1mley4J6INlf6Vw/pViNHRld3EP+SbUAw77wja/e?=
 =?us-ascii?Q?+YqPzCJESqCHm5FFq9koMp9fYdUTnhjpNjcDr3Uu5KmW8Y11CBqiTloekiFR?=
 =?us-ascii?Q?K+/bakC49Ilg2iVIxQuK9wQoP85JktI/QBh8NTuxXoe5rgG567hKJRtM9SZ2?=
 =?us-ascii?Q?lUyP7rxgOpsBcdFDOkdUNvJ6Vd70urt1n/2grAr9knA3m/ORyY7kUj9BhC/p?=
 =?us-ascii?Q?ueYnTKR2qM5QBUzDJYeVp/xWWpeYbsclYGS4oCGxYkxzpnak20cCgyzxqpo4?=
 =?us-ascii?Q?ho8znfEMXDvX+riX0SmRd/5QhPaRNKjHRgLG6Blnd4Fdm1jH4Hv0sKxunmsQ?=
 =?us-ascii?Q?cfZC+mzGAa9NsRf3hqwPrpEZ9cmpZWTaHBhKqUBfKmsX6nCla+caOvk+7t7J?=
 =?us-ascii?Q?SSPRhSCb1eRarK+FSqUrYedIj98mUF4HBPiIZFvktfihhzdwIeg7+L8wuPwe?=
 =?us-ascii?Q?JbudOsxT0s0+FspjZPtJX2bTN8mDUpnqxXP7n/cz9LooR94IRA1lArtfepkK?=
 =?us-ascii?Q?SeNNGROSfvZTPc+En6g7U3bx3n8LOJp1DmwkgLaeBCCIFLScY+YzDaf61zEM?=
 =?us-ascii?Q?RTHyy39jsytyGNCNs2OGQFlCd2Q8qDObsHn2VVm8SoL+JbqLqSUewseu2v5S?=
 =?us-ascii?Q?mrZLmKOvFJfx69ETy1QI5uN0UmxoVT4jiFbj7tv8dxcY1LRgHAc3F9UewXDk?=
 =?us-ascii?Q?PgtR1L1CQuD+I++fY4lmi7psac2ngbRZp9M66yxWmkNMxboKOgJBJQXF5PXf?=
 =?us-ascii?Q?NO3FY2T0DWUZQAeRBcfG1l2bp8ae/cghx/83lMVJahHCCgDPlyAPcR+pvFe1?=
 =?us-ascii?Q?Sq++lcwIYUNXlTYIoAiw3Mea6hpfr+J6+2HuGiWoJAmAL90V/oDyEhCg6zRL?=
 =?us-ascii?Q?72WSFRH1ktWi2/v/Oj4eNzeHJzs3S9V8xqh/9XuvFZ8OLr7aoEAblzmSum+f?=
 =?us-ascii?Q?8DdS5N6SpFQnv4QY0EqS9RyTpWheo2oiEw60a0MuiAQUzZXUTVucGtuVbSSX?=
 =?us-ascii?Q?99vJLM6UuZXtEw18n9ir6fzeTKCPQ57SeCiS7fn10lGqV9bVcCh9OXhJjPI5?=
 =?us-ascii?Q?u0L/eTDrvzb129Q48bXx62jeqxlSS9isxx3C+d33lYJYKjf7aMnHyPqsNlg2?=
 =?us-ascii?Q?D0Qi+lkn035Bq3Ieu3jAMeyhWphscTW/dEgXg7n5JIdGimxeVdKixS8oeHoJ?=
 =?us-ascii?Q?p1lX7bNvkerWHOkpbIEhVJSPrgzAi/fO4KpjqM9FaWjwpB6/hK42y+Byz2Qp?=
 =?us-ascii?Q?Qk+bdXz/eLAIJ4f0OKkCJv1HnL7X/b0UdFenF7DQM929WKkjBKEH7RCoE1Go?=
 =?us-ascii?Q?IiCqmj1wM9KpKP231MdjHXaHfPN8QoH18VHATKa2nUB+BKFMYeeuNUMoqCkv?=
 =?us-ascii?Q?NuMZ8xczPdpUonNzxISoafm3dmuM+ODi6e5b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:46:08.5584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8b79d-8e46-4a02-caea-08ddc9718cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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

[Why]
Users can access the replay residency to get PHY off percentage

[How]
Start capture residency:
sudo echo 1 /sys/kernel/debug/dri/0/eDP-1/replay_residency

Stop and Get replay residency:
sudo cat /sys/kernel/debug/dri/0/eDP-1/replay_residency

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 484691335fd6..f263e1a4537e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3106,6 +3106,35 @@ static int replay_get_state(void *data, u64 *val)
 	return 0;
 }
 
+/*
+ *  Start / Stop capture Replay residency
+ */
+static int replay_set_residency(void *data, u64 val)
+{
+	struct amdgpu_dm_connector *connector = data;
+	struct dc_link *link = connector->dc_link;
+	bool is_start = (val != 0);
+	u32 residency = 0;
+
+	link->dc->link_srv->edp_replay_residency(link, &residency, is_start, PR_RESIDENCY_MODE_PHY);
+	return 0;
+}
+
+/*
+ *  Read Replay residency
+ */
+static int replay_get_residency(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *connector = data;
+	struct dc_link *link = connector->dc_link;
+	u32 residency = 0;
+
+	link->dc->link_srv->edp_replay_residency(link, &residency, false, PR_RESIDENCY_MODE_PHY);
+	*val = (u64)residency;
+
+	return 0;
+}
+
 /*
  *  Read PSR state
  */
@@ -3325,7 +3354,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_g
 			 dmcub_trace_event_state_set, "%llu\n");
 
 DEFINE_DEBUGFS_ATTRIBUTE(replay_state_fops, replay_get_state, NULL, "%llu\n");
-
+DEFINE_DEBUGFS_ATTRIBUTE(replay_residency_fops, replay_get_residency, replay_set_residency,
+			 "%llu\n");
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
 DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL,
 			 "%llu\n");
@@ -3503,6 +3533,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 		debugfs_create_file("replay_capability", 0444, dir, connector,
 					&replay_capability_fops);
 		debugfs_create_file("replay_state", 0444, dir, connector, &replay_state_fops);
+		debugfs_create_file_unsafe("replay_residency", 0444, dir,
+					   connector, &replay_residency_fops);
 		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
 		debugfs_create_file_unsafe("psr_residency", 0444, dir,
-- 
2.43.0

