Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3722DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A477810E568;
	Fri,  9 Dec 2022 16:37:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA62710E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn8z6ImKN7i9XcUwxloYT0AOnEdpAu666kHQfWniWCB73dfhEC2TsFXLK/faIlBtukFjdF9dyH4c70e67vQBoRC0Bu4p2CBWXWOePNmg7QyD2LiwjyvXjRDz59OT8y997wVnbMX6PfKFDaH9MdybBHjNvHl9gbwe15boQTLRZwHTAsCRFfo0wjwy1wk1tSKuFPfs8Mz2d0UtvQ5EBk/cuep4heUJCKcYrYUaBQxthNFH1CwPiqDScELcB7lIGxkBAToS4W+vr/jeG2IAHlOepKhDbdVvKusgC6jnDDly6nRBTqB26H5zSc9DqsDUnU+AlBtPwODtevBxzHIE5TlvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bUkYXgzRHrzvQgPhyc6lEUOqljvvFfr+lKcfaBcejY=;
 b=nktp6BFvytwYDTCxKz3/p+R1QZJWh9TDZA55b+vM2moUIrPzrCUH5vESCjW+kd651sw1ri2fnQFZLDjSiPQoQOqxuiQdI1GlHnwDnHWiAY+pjb55AEHxi37c2tsM+gwOnsw3v3a6PzUkfEUv4ZT9k0BuC/W17GN9TEclI+OB0ySYdnVTnIhvQOrBZgrkzAVaFzq+nTKZD/yCUL9Pvjbo8oVKUBJkx52MTy81fFgveIZu2F39rGoLAJLv/YTi2soGZr+3TufgZE7/9HPi3lkOZlKWtMliUcPcyc0WreSR26kK/xjmrMq4LPjqmPy6mK3GekgpRa//OJEoOyUbB8KYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bUkYXgzRHrzvQgPhyc6lEUOqljvvFfr+lKcfaBcejY=;
 b=EEQ3MLzOlJlx9rUTXyQCX2dt9Ualj/XJRK7Cmx1KAyB47pop9ICY7yX1MNJLrp5y4G1SO/EkSe4Wq/MoLfI3jbiBdF33nM4sz9NT3YnexENtILGmkvgKvmKezvQz6RkSHJdiX8PFx9I0SVEZlgAhUxHVE6Ax0umlILegAXqgYDA=
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:28 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::d4) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:28 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:25 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/23] drm/amd/display: phase3 mst hdcp for multiple displays
Date: Fri, 9 Dec 2022 11:36:34 -0500
Message-ID: <20221209163647.25704-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cff0fa-2fa8-4663-e17f-08dada03a95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKlQtBsyW3E2iOkK8m4r6pv4+ZtZOpA7KMzLOaXMB79cJVdQNYVF0NairchmepxUJqaj8A55GryDl356QluzEoh/IKI6posgA7N8JnaarDJ+1ljTzajEApFWboNmOE1FkJ3rzJImM6KDA6mSVvRAvSsDdPSRZlZgFJ75RVqHanFIprNzBNeE9JF/LdtKLhCUPv9vXQ1CH4/VRLoXSqPxXk5j1ERd23tR3YIbwrzy0hSs+IcOGocMYhHKekVrguPsJgxysxldJa3H6hNKaYb7o/8sZbztNHBfv0k1y5BUZlQp6Lxpx4mLU2t+k8mPz6nBatkfLGJ9q0mY/ZyxoDCOhUU18nOXh2L34u/+6dffWGixAOjPelwgmA9hhds7y5bBDHkV0ISzxy80sYMBYsRslzXoElmcHegluwR3EZynLXRq2eYPySTe35fJcwdoaJ6tDfhRHVEP6R3nAXvL97rR0ndYMAQq9udBtOLhZDJPqmQNpBovt8I3+CjIn4Xka1FLekIpSCvBwA4kSDTeZe4WGHtQU2VBPhotpjPTMKLofMB2EsvDfquKNKeufsdPjEdVi0z2rQdn1hu4XKRFEeFIeGcZjwvHW2WoBCBVxY9XsQ5755DdeBQDc1vOnZyQZ66RY/6U+J4zyEuuzfo+Xa51FDtE9abZzFI3qHaumvkBF+Gu8rpHtE7GXQL2BP4NQAqGXWA8OU3QxxvTRDvU7kPDSb/oH46wELYm8Zqwt6NLk9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(70586007)(356005)(8936002)(40460700003)(4326008)(2906002)(82740400003)(6916009)(5660300002)(83380400001)(70206006)(36860700001)(81166007)(8676002)(316002)(54906003)(1076003)(2616005)(478600001)(41300700001)(82310400005)(40480700001)(426003)(336012)(47076005)(26005)(6666004)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:28.6043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cff0fa-2fa8-4663-e17f-08dada03a95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
multiple display hdcp are enabled within event_property_validate,
event_property_update by looping all displays on mst hub. when
one of display on mst hub in unplugged or disabled, hdcp are
disabled for all displays on mst hub within hdcp_reset_display
by looping all displays of mst link. for displays still active,
their encryption status are off. kernel driver will not run hdcp
authentication again. therefore, hdcp are not enabled automatically.

[How]
within is_content_protection_different, check drm_crtc_state changes
of all displays on mst hub, if need, triger hdcp_update_display to
re-run hdcp authentication.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 118 ++++++++++++------
 1 file changed, 81 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7affe0899418..dc23801de071 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7374,27 +7374,55 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 }
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-static bool is_content_protection_different(struct drm_connector_state *state,
-					    const struct drm_connector_state *old_state,
-					    const struct drm_connector *connector, struct hdcp_workqueue *hdcp_w)
+static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
+					    struct drm_crtc_state *old_crtc_state,
+					    struct drm_connector_state *new_conn_state,
+					    struct drm_connector_state *old_conn_state,
+					    const struct drm_connector *connector,
+					    struct hdcp_workqueue *hdcp_w)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 
-	/* Handle: Type0/1 change */
-	if (old_state->hdcp_content_type != state->hdcp_content_type &&
-	    state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+		connector->index, connector->status, connector->dpms);
+	pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+		old_conn_state->content_protection, new_conn_state->content_protection);
+
+	if (old_crtc_state)
+		pr_debug("[HDCP_DM] old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+		old_crtc_state->enable,
+		old_crtc_state->active,
+		old_crtc_state->mode_changed,
+		old_crtc_state->active_changed,
+		old_crtc_state->connectors_changed);
+
+	if (new_crtc_state)
+		pr_debug("[HDCP_DM] NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+		new_crtc_state->enable,
+		new_crtc_state->active,
+		new_crtc_state->mode_changed,
+		new_crtc_state->active_changed,
+		new_crtc_state->connectors_changed);
+
+	/* hdcp content type change */
+	if (old_conn_state->hdcp_content_type != new_conn_state->hdcp_content_type &&
+	    new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		pr_debug("[HDCP_DM] Type0/1 change %s :true\n", __func__);
 		return true;
 	}
 
-	/* CP is being re enabled, ignore this
-	 *
-	 * Handles:	ENABLED -> DESIRED
-	 */
-	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
-	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	/* CP is being re enabled, ignore this */
+	if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
+	    new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+		if (new_crtc_state && new_crtc_state->mode_changed) {
+			new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+			pr_debug("[HDCP_DM] ENABLED->DESIRED & mode_changed %s :true\n", __func__);
+			return true;
+		};
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		pr_debug("[HDCP_DM] ENABLED -> DESIRED %s :false\n", __func__);
 		return false;
 	}
 
@@ -7402,9 +7430,9 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	UNDESIRED -> ENABLED
 	 */
-	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
-	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
+	    new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 
 	/* Stream removed and re-enabled
 	 *
@@ -7414,10 +7442,12 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-	if (!(old_state->crtc && old_state->crtc->enabled) &&
-		state->crtc && state->crtc->enabled &&
+	if (!(old_conn_state->crtc && old_conn_state->crtc->enabled) &&
+		new_conn_state->crtc && new_conn_state->crtc->enabled &&
 		connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
 		dm_con_state->update_hdcp = false;
+		pr_debug("[HDCP_DM] DESIRED->DESIRED (Stream removed and re-enabled) %s :true\n",
+			__func__);
 		return true;
 	}
 
@@ -7429,35 +7459,42 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-	if (dm_con_state->update_hdcp && state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
-	    connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
+	if (dm_con_state->update_hdcp &&
+	new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
 		dm_con_state->update_hdcp = false;
+		pr_debug("[HDCP_DM] DESIRED->DESIRED (Hot-plug, headless s3, dpms) %s :true\n",
+			__func__);
 		return true;
 	}
 
-	/*
-	 * Handles:	UNDESIRED -> UNDESIRED
-	 *		DESIRED -> DESIRED
-	 *		ENABLED -> ENABLED
-	 */
-	if (old_state->content_protection == state->content_protection)
+	if (old_conn_state->content_protection == new_conn_state->content_protection) {
+		if (new_conn_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+			if (new_crtc_state && new_crtc_state->mode_changed) {
+				pr_debug("[HDCP_DM] DESIRED->DESIRED or ENABLE->ENABLE mode_change %s :true\n",
+					__func__);
+				return true;
+			};
+			pr_debug("[HDCP_DM] DESIRED->DESIRED & ENABLE->ENABLE %s :false\n",
+				__func__);
+			return false;
+		};
+
+		pr_debug("[HDCP_DM] UNDESIRED->UNDESIRED %s :false\n", __func__);
 		return false;
+	}
 
-	/*
-	 * Handles:	UNDESIRED -> DESIRED
-	 *		DESIRED -> UNDESIRED
-	 *		ENABLED -> UNDESIRED
-	 */
-	if (state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED)
+	if (new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
+		pr_debug("[HDCP_DM] UNDESIRED->DESIRED or DESIRED->UNDESIRED or ENABLED->UNDESIRED %s :true\n",
+			__func__);
 		return true;
+	}
 
-	/*
-	 * Handles:	DESIRED -> ENABLED
-	 */
+	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
 	return false;
 }
-
 #endif
+
 static void remove_stream(struct amdgpu_device *adev,
 			  struct amdgpu_crtc *acrtc,
 			  struct dc_stream_state *stream)
@@ -8322,6 +8359,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 		}
+<<<<<<< HEAD
+=======
+
+>>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)
 		if (old_crtc_state)
 			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
 			old_crtc_state->enable,
@@ -8384,7 +8425,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				DRM_MODE_CONTENT_PROTECTION_DESIRED)
 				enable_encryption = true;
 
+<<<<<<< HEAD
 
+=======
+>>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)
 			if (aconnector->dc_link && aconnector->dc_sink &&
 				aconnector->dc_link->type == dc_connection_mst_branch) {
 				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
-- 
2.34.1

