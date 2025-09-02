Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25701CA100C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B620E10E709;
	Tue,  2 Sep 2025 13:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rj9BGXVe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D10C10E710
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytoLomSq9jkzk4qX1z+m3gIc/e2AL/QQoqANnaop3iKxbDFRfy392v8fDdbvEsYhbAo8dVzPuwjCdqWqOBV1EhmP/VHCBbevDIFjmzwzuLZdHvpFbwrrXNWFbx0kEqX1uNRpvD89GUP6Ob2CzkJR0nP/er9ZuFVfRL3walCMnHtdV5CpIFrAmG15IRZv/rNNOG3zWNAhU54bWdEzP/6vJSTZsZUS+S0KiYJ3eq4bLLaNdPnQSK2miRwAJPm27LPq0UIfpshipfWxnIqg3OYj0a5HdM842zlKmb1It+Zui/+j9ZWfxWpSFy2NwE7tkRBPPbtEZ5jAhGuWRhbnmLmYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg5NKfqHubtQTsEYX5PlVElaMjC8SHi6wW/qv1NSsvc=;
 b=N2aPAxJYLXw4HzvDIa+r3FL6eCWVfE70u8/Ha/BVCrlITOCZLqeKVPTik2cvPshUXGqf+oHNIYv5citJ8wLcdOOOJm3qbx1/tm/vcRUwhVa0cihQdMYfA+91Q+9cUal85wLj/18qFv/HwJFnRUfrQRT1jP20Mofo8vgP6dUBsU4QkUWeBpQix0gG7P/qUsNB5eZoD8PtJkZJAzGvcJcASbO1Is4zmLqxtGQiZehEwRtxrudsXDUC64Wep9t3BZakVi3LzBc9QclrM6hk3zH8rFEjO4pW+hswCEypSp2BBlF/9DcyxDHGu/3W/4iYeH1PNomNgr9seXQdNU8icU+ykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg5NKfqHubtQTsEYX5PlVElaMjC8SHi6wW/qv1NSsvc=;
 b=Rj9BGXVe9R2UTWpyS2fD4p1d76SJDeBLMgmyhVigPxQCCiQ2XdiK7eYy7bZxIg7VfIxTytBVqlFDK3/ON1My2EnaRjSa92mLt9hj5bw3ynmljsemm0wjzjbrdWHoa4IooJSk9QjJbVTNQKSw4lqMUJqdLM/hUNiE9YYzgTn6sXU=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 13:36:01 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::b8) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 13:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:36:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:36:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:36:00 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:54 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 6/8] drm/amd/display: Skip Check Runtime Link Setting for
 Specific Branch Device
Date: Tue, 2 Sep 2025 09:33:35 -0400
Message-ID: <20250902133529.4144-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: b280d171-7db9-4078-3c04-08ddea25a80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QIkjNTjgNRci4ufXMRjoYMs/WlS/0i8eColUcn4pTeoWPC3w2stWt2Leq1dI?=
 =?us-ascii?Q?LlkyXd934XUgPmf/hZfs2mZShAstCJGxnmofFFsWcpabccl6plbsRpRi9BMY?=
 =?us-ascii?Q?/yz0JhUgkFoMtIz6y2IDAiG/c0hgzm/BAmmjqxv41BGY9ZidAj2BYnPrs4LL?=
 =?us-ascii?Q?+PXilZg/pqjgntKWvuPCN+EFYLDqnv9YxX8z7Lg+sl4LQHF4/GwCkeGetkmL?=
 =?us-ascii?Q?ND496hUsg/hKJey1qU5HLRP3cfrNBiTZxO4wOy25M8L0OEOhnv5Gx8yk1Flg?=
 =?us-ascii?Q?CqqI1RmOVksOQT3qKZl0DsC5rQsK4VxzZdIey9LQKrrWCweEYWH6RhnnfDhn?=
 =?us-ascii?Q?9gVJ7F6N9gW7aoyF7fcPLpPz/d4fsz5TAA8mXJF31jP+dU9xtISQEvMwhTar?=
 =?us-ascii?Q?ZkVenAf0ytfLOk6eOv5FLFzE8dQvIxqt9CQ9rJiDzwjaago7TYHxbF9LkQdg?=
 =?us-ascii?Q?hj3S0xpI6yhBrTnByR4I6ISK3uaCpUNBvOfU/47DwGt6haLizzjD+MlftToh?=
 =?us-ascii?Q?v9uSyLY+NPumzR6p6xYr6JPkk2jXQoYpQqVtdbXy68CPX7JcDba0retRYIKB?=
 =?us-ascii?Q?X50prvWvBW31r+hXM5OYC7aOa2ohT09ogkiZuFhsllh4vqp7mi1IKWag5GBz?=
 =?us-ascii?Q?sK63z2gld6mn4jLztpZ7GHOcihGdhRu7OPvALOelS2lrP7jAMlm0KFynHF3Y?=
 =?us-ascii?Q?F1yZGHV/Eai/tACmiCTATQXmaVojQMW2/SzrVdssYyOAbHwmsZ2ltr5Eu1Z9?=
 =?us-ascii?Q?poxbnAn4YGvMRLa1GsGP5oe/oI+ZitnYCFzYzdocV4iOljdlTSCiQ5AayW8C?=
 =?us-ascii?Q?HxFOAb9KyKIfZTMx9mGEfZedmU+Z2qu6e/EAGyd7KQdAQ/Vjc+YR8FXFJbGp?=
 =?us-ascii?Q?ZMYNsMLkfqanYiAW9b/wp0AVRWbKr54j4rzL3mOvnx6GUGDMU3uyp5ZXgB09?=
 =?us-ascii?Q?VuGkzdBfgdMNuK4SIu0ZWsaW7N+x7slx3wzmY8444lttQ2T8N8FFUtzHW+Yw?=
 =?us-ascii?Q?XeUSG2Y7oGLyGhp6l54tQt5lwJwLIpVZjJVU3iex0kX4v5jbEIB/ZZzULSZz?=
 =?us-ascii?Q?ZVh88N2T4L+DEm3MKYVQPl9ci5sD6vQggq4appwVpUqlWPdLsLr4rE0SsLNb?=
 =?us-ascii?Q?Kx6pXNcGgNw6tIeg2Zn2B/i97XapL2I0EK07/Ivi4Il3O5eFiXH/PfKoDY2l?=
 =?us-ascii?Q?g1h+Rp2ZRfHdQZ8bjgHiW+uegkZ+vSRVtlrxAh7U9SgyJDekTZb5xfNz1Pjz?=
 =?us-ascii?Q?eldIGxhD+Wtq7kjJaXK62neaMebRsvUo6HBgISb8eCkvRRK9eW/lQDEOcQk0?=
 =?us-ascii?Q?vQ4KHDPEJw8eFOsH5ThOzzp+esHYi7YS75YlhhpbitrqZUoX4vRvt5+wp53J?=
 =?us-ascii?Q?zF+loEhlIPkWscoBW+pORy5vtPXvBnfargcqt7AOBD2rKnU3/0dSjixRKhec?=
 =?us-ascii?Q?611OuLy5+LuFiWizYsISp1/TBUVrYV24AH5OeiD8xCZ2rLWUQBJAEhbr9kDI?=
 =?us-ascii?Q?8dc2AUOVD3jvUx09xe5tR9OSmoSaxbHF228O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:36:00.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b280d171-7db9-4078-3c04-08ddea25a80c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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

[why]
Read link setting inside mode validation is not always the final downlink setting.
It is found true in Synaptics branch device.

At bootup, the preferred mode being set right after 1080p is set. It occurred
before graphic load. That modeset switch in a short period of time makes
the branch device switch back and forth from lower and higher link rate,
observed at Synaptics branch device.
DP2 RTK hub on the other hand, sticks to highest available downlink rate after bootup.

Existing check of runtime downlink setting in mode validation shows asynchronous at
branch device link switch, i.e., downlink switch to higher link rate not yet complete
when the mode validation tries to probe the downlink setting. That makes mode validation
checking downlink setting making wrong decision by pruning modes that should pass the
validation after the downlink setting switch is complete.

[how]
If Synaptics is found at the last branch, skip checking downlink setting
at mode validation.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 ++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 40 ++++++++++++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index cbd107493f8a..ce74125c713e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -768,6 +768,9 @@ struct amdgpu_dm_connector {
 	uint16_t vc_full_pbn;
 	struct mutex handle_mst_msg_ready;
 
+	/* branch device specific data */
+	uint32_t branch_ieee_oui;
+
 	/* TODO see if we can merge with ddc_bus or make a dm_connector */
 	struct amdgpu_i2c_adapter *i2c;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 32281bf62f70..6a817508c826 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -330,6 +330,34 @@ static bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnect
 	return true;
 }
 
+static bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_dp_mst_port *port = aconnector->mst_output_port;
+	struct drm_dp_mst_port *port_parent;
+	struct drm_dp_aux *immediate_upstream_aux;
+	struct drm_dp_desc branch_desc;
+
+	if (!port->parent)
+		return false;
+
+	port_parent = port->parent->port_parent;
+
+	immediate_upstream_aux = port_parent ? &port_parent->aux : port->mgr->aux;
+
+	if (drm_dp_read_desc(immediate_upstream_aux, &branch_desc, true))
+		return false;
+
+	aconnector->branch_ieee_oui = (branch_desc.ident.oui[0] << 16) +
+				      (branch_desc.ident.oui[1] << 8) +
+				      (branch_desc.ident.oui[2]);
+
+	drm_dbg_dp(port->aux.drm_dev, "MST branch oui 0x%x detected at %s\n",
+		   aconnector->branch_ieee_oui, connector->name);
+
+	return true;
+}
+
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -669,6 +697,9 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 
 	drm_connector_set_path_property(connector, pathprop);
 
+	if (!retrieve_branch_specific_data(aconnector))
+		aconnector->branch_ieee_oui = 0;
+
 	/*
 	 * Initialize connector state before adding the connectror to drm and
 	 * framebuffer lists
@@ -1774,6 +1805,9 @@ static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_lin
 	link_bw_set = data[DP_LINK_BW_SET - DP_LINK_BW_SET];
 	lane_count.raw = data[DP_LANE_COUNT_SET - DP_LINK_BW_SET];
 
+	drm_dbg_dp(aux->drm_dev, "MST_DSC downlink setting: %d, 0x%x x %d\n",
+		   dp_link_encoding, link_bw_set, lane_count.bits.LANE_COUNT_SET);
+
 	switch (dp_link_encoding) {
 	case DP_8b_10b_ENCODING:
 		link_rate = link_bw_set;
@@ -1870,8 +1904,10 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 					end_link_bw = aconnector->mst_local_bw;
 				}
 
-				if (end_link_bw > 0 && stream_kbps > end_link_bw) {
-					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
+				if (end_link_bw > 0 &&
+				    stream_kbps > end_link_bw &&
+				    aconnector->branch_ieee_oui != DP_BRANCH_DEVICE_ID_90CC24) {
+					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link. "
 							 "Mode required bw can't fit into last link\n");
 					return DC_FAIL_BANDWIDTH_VALIDATE;
 				}
-- 
2.43.0

