Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFB1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279CC10E476;
	Wed, 14 Dec 2022 20:22:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2511610E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXoPI8GQiSXZox3/nF+ff3JYtmTanFLi69QK4s3proIHk95TREq1reMcYZjxx1Mx84gCWizxoDJtIGy0mltZIQ6dFF5/sqj1ryBvJ+tpLHgZVj8xP7KgY36xOlngpyiM43tMO6xN0l2lJNHQc4XZXuHy8Cx2GeWs+WfUymmLeLvowmDc8MjXz9nRebvCRpIqjxQnCiBMDLW+cGi0/ppIoWT3rwLNe7m/Dz1tvOiueO6yrTH9cGRILn0J5jPZUnR6vAMI8hfFsVH4fo01VX2OqpOljJimSsprulSkkN5wG9XJtXabUnZVR1pZ/4TlN7CBAvpyNB2qKEhZNN+jYB2Zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag63EvmEXOfQX5XmWWqwFxS41B0KYUjq3isMz7A4v+U=;
 b=kCCBRCA2vZ2cYU/8iqxgKu/8nQBvmJ6JD9xA8yoetJ8ujeqQah+9CHDUZhWSLmkg1ZaJXXPBoEczNLtIdUgeDaO/3TBIs+pRKrL8p43OFJBhxAcQCNSO/1gAXHn+77Jgj0A4+eN3xiyrEYehT4k9gC63Q5IWjshAGY5P3bBtBWoVN82jnG22Meb2FZAYbQOWBHYRy8fFFHQbtStvBHg0C2/lA45wTaOiRXUkMo3vUr4Pp0pXvtbKC2YydR6nnFzR+X2Dj3s3gC+HsBISxZ2pJGeiH+WlaGT55jS/KPY0zj2wklsXutxVu9dgq5oqbJ/ZU2mqMcmmcip38vKNHOwvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag63EvmEXOfQX5XmWWqwFxS41B0KYUjq3isMz7A4v+U=;
 b=aHv9+sVQ2IW3RY3FvZoDK3noH+sWBhQBMFQAJgirQaj6XLLI1XwXpEHOliVtQD2XVMof9iqS+49gHjKdbXjCX0HRWo1OM4uG46EDqK9gnMwJI5ApwIX95Mb9F4oB1dBfupBuYuRBx5GSnZIJhRP/VWQb1+oMnDEHoL95BfoFSBw=
Received: from MWH0EPF00056D06.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:10) by PH7PR12MB6786.namprd12.prod.outlook.com
 (2603:10b6:510:1ac::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:21:50 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWH0EPF00056D06.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.4 via Frontend
 Transport; Wed, 14 Dec 2022 20:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:21:45 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:44 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/18] drm/amd/display: phase3 mst hdcp for multiple displays
Date: Wed, 14 Dec 2022 15:21:25 -0500
Message-ID: <20221214202141.1721178-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1a05ef-b8bb-44dd-ed33-08dade10d498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEeTlXU8XOjDyoUZ8gpTYTPq9dCnxlBK5Tw0EX6iK/yXDO7h3KWx9eTg82Zsq9JxEmTzn4rTR+HFc1/gWkYZ418xEdX/QmFiDkXT/04p4r5GDe6xAyQ80WADXXltRUb3vOFF6FiTOcRvH0jw6s63aDGDk3OhZ7hUrBPLeQUd7nfzNs9dOAFbX4beJXMGWjMei4EaDyWaIb0ZnOWbY2LvSlcJJdoz33jWczs0EiR/36vLsqqJJACYH6gkRlvj7DPhFrVKLQLlN7lsWKRaVC9g+G9PoGwBl/KK/gUKzx+/6lzGaWE4cOZkbXP/WyHOqbTGnEtHeMfCtzZMJyW2/BcLEdC91QY/d+09eS8X12HctVKyypbqHp8JMBwp2jADKxZuqIaNHzNWTdKiSJvEmeQyotfXC5bOPPiqGuqUdXzyHt5POozIsnS/M+i911lrB2c1XMY0WpWQiR4iqu9iOhTFKMEY8/+qUYnKvRBJiERDjycJLodU2iy/if0B8+zt0VsujeDW+1WHBGl7zOE3BxZDIN4jhseoDYXjQVE908AYJZTNflAgFhaPMBM9eehcng3MgPiqzZjqUKNqx8tnv6Y/YIWdQKygJGaFYQ4DzL4r6h8thuVr53//HrxfzDitrsS/EhUIJ03maCoSgArOLhUNXmnMroR4Ocvv0EaUUX77utwDlHS830cezYSWZxuRc/Oodk5rlObNNpLF9keO/fWq0jWjsnaau98VNBP+OfN9tTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(26005)(41300700001)(83380400001)(36860700001)(186003)(478600001)(6666004)(54906003)(6916009)(316002)(5660300002)(8936002)(86362001)(82310400005)(70586007)(8676002)(70206006)(4326008)(426003)(47076005)(7696005)(44832011)(356005)(81166007)(336012)(40480700001)(30864003)(82740400003)(1076003)(2906002)(40460700003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:49.2419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1a05ef-b8bb-44dd-ed33-08dade10d498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
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

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 183 ++++++++++++++----
 1 file changed, 142 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index acd78fde6121..24443547bd02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7379,27 +7379,55 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
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
 
@@ -7407,9 +7435,9 @@ static bool is_content_protection_different(struct drm_connector_state *state,
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
@@ -7419,10 +7447,12 @@ static bool is_content_protection_different(struct drm_connector_state *state,
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
 
@@ -7434,35 +7464,42 @@ static bool is_content_protection_different(struct drm_connector_state *state,
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
@@ -8297,15 +8334,66 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
+
+		if (!connector)
+			continue;
+
+		pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+			connector->index, connector->status, connector->dpms);
+		pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+			old_con_state->content_protection, new_con_state->content_protection);
+
+		if (aconnector->dc_sink) {
+			if (aconnector->dc_sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+				aconnector->dc_sink->sink_signal != SIGNAL_TYPE_NONE) {
+				pr_debug("[HDCP_DM] pipe_ctx dispname=%s\n",
+				aconnector->dc_sink->edid_caps.display_name);
+			}
+		}
+
+		new_crtc_state = NULL;
+		old_crtc_state = NULL;
+
+		if (acrtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
+
+		if (old_crtc_state)
+			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			old_crtc_state->enable,
+			old_crtc_state->active,
+			old_crtc_state->mode_changed,
+			old_crtc_state->active_changed,
+			old_crtc_state->connectors_changed);
+
+		if (new_crtc_state)
+			pr_debug("NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			new_crtc_state->enable,
+			new_crtc_state->active,
+			new_crtc_state->mode_changed,
+			new_crtc_state->active_changed,
+			new_crtc_state->connectors_changed);
+	}
+
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 		new_crtc_state = NULL;
+		old_crtc_state = NULL;
 
-		if (acrtc)
+		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -8317,7 +8405,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 
-		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue)) {
+		if (is_content_protection_different(new_crtc_state, old_crtc_state, new_con_state,
+          old_con_state, connector, adev->dm.hdcp_workqueue)) {
 			/* when display is unplugged from mst hub, connctor will
 			 * be destroyed within dm_dp_mst_connector_destroy. connector
 			 * hdcp perperties, like type, undesired, desired, enabled,
@@ -8327,6 +8416,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
 			 */
 
+			bool enable_encryption = false;
+
+			if (new_con_state->content_protection ==
+				DRM_MODE_CONTENT_PROTECTION_DESIRED)
+				enable_encryption = true;
+
 			if (aconnector->dc_link && aconnector->dc_sink &&
 				aconnector->dc_link->type == dc_connection_mst_branch) {
 				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
@@ -8339,10 +8434,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					new_con_state->content_protection;
 			}
 
+			if (new_crtc_state && new_crtc_state->mode_changed && new_con_state->content_protection >=
+          DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+        enable_encryption = true;
+			}
+
+			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
+
 			hdcp_update_display(
 				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type,
-				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
+				new_con_state->hdcp_content_type, enable_encryption);
     }
 	}
 #endif
-- 
2.39.0

