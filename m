Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D88BEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 02:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B284310E482;
	Wed,  2 Aug 2023 02:20:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D09010E481
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 02:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwbTt9mYVRA+IH99uheZB/FFJB0KcSbx+jIg4sqQcRPIZEFNEy3qUfBAjcoV5SkPcafHVMDyFFgYeR2AQ9EdxVB/qw78Hkvw1OX6F3ashPArVk/q0VftUd1fnQvfvlOAhBWz/8zjOQjoVycBfwOn8z2rxvDvhwsvfAT8a9xJF+pw+MJwauBNcNwLoLZyf+Hmaa1Q3LG1xrJkabG1NWhFSjkgIQIe8cAa0ArYAekYEl/uzQp5Yr0Ow5WzWXW3qWMexp3i48ujvUxenMMj7rZVJl7AHQG5VLWljaB1rYwc98fk9JCW8fAIK6sLw5LCcdm0vzB3UA+CYxaB+oMJgqeyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdeRz3aDT7+vyatgl+HfNNgtnrWN4FzI2mPhZ51e0OA=;
 b=b3MXiptIKkF3gUr22xfHWL8FbJffCg383X4d/u3R7dDJse9+IjrwM6avg3ABmi2k12Y5ZT/+IgWXOwk6poCP9M13GVXlj/WY9B2gANUoHCipQiM0v9dX5wjdHdNHDYiohXtmqLIirUQFNlZkzWLgjirbcKnG6Np3cYBgjwnDsXyZOTDMM+0JeQVyow9Y6Miw2da4tUo+nEKMGa9UbH+Jz8dVA4X/Z0s0Ss/evWOjqFTdBR9FVX/HNPTm/FWzrYmG6jEa1J/bH3Qutkz/AWZ0cdfyIGA93ICUW3GWibh1oejnLlsR5GZOkypWK3aTWVbupi5mJF/x8jaTpjgr2jXwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdeRz3aDT7+vyatgl+HfNNgtnrWN4FzI2mPhZ51e0OA=;
 b=V9PjGLyICAhn+4PMHOHGzxt2BJ7TWl74mKAkHKWq9bU0bUfM26QJtHWiO4/2sPrrMOzy1QOcBNnyQRF/SkmAuF+a3hBITMUUiilxOHJwdiKBXrDJkSH1oxPgM8jcg0ayIQRroa94645lAGK33nfNHjQObHsCzk5laUbSggVX5cE=
Received: from SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::18)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 02:19:56 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::fa) by SA1P222CA0071.outlook.office365.com
 (2603:10b6:806:2c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 02:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Wed, 2 Aug 2023 02:19:55 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 21:19:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Refactor 'amdgpu_connector_dvi_detect' in
 amdgpu_connectors.c
Date: Wed, 2 Aug 2023 07:49:14 +0530
Message-ID: <20230802021914.3093033-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 2962f9ed-acc3-4923-5ee0-08db92fef671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPrOmGLYcS2v9J3VZSWxmKnU0f+Me8MdNYFnhukRBinncS7ec1uWq/AyBCIDMqXRyi6epo/UzSaYUOYcutgnt2EdPjaUaDCPguLRh/8rl2Wo9MFbOkVTvonp4OA0L0wEgSbsqu8avE0qR+ty81lFuENCS9ETzntCLA88oTDl3Gk8vg0vb9fYIRDz89yM2sWiJpDbxMiRVMU3v0miZuTaxmtUvyKCGoWTk2EhvxSksDzrWhqXnlPyTO7sI8rvW/CD4H762+ZDVY5ML1hxSDGNkkDXb+nMm4VRF+fIQ3oLTSsDijdBwfo/B2YOjqb72P2+4HJ4JpPPlVW2uwcy9FMkK7jajCG0frPIWXiwy3KlZr7PefdbSbX+V40jMINyY42n0WwU7UUjLRFclM2+SKG4C1MWfTZOkpWRVkNir2InW50sLv5ZyU+zkc+CLChP8hkqct8WBKvIw4Q6dQZ5MR9UEPuf7byBpWqzi05uwxRsLvcJS4lleJD3yV5fBhi19/KjLBtpmiyFyW0OWTesGsEsnRPiHOWTq7xDrfQakfykMCj1oV7D9LMaEtGqHndMdhgIGY/KW0RCX9qatUzmD8pQeIbJ5gsKTQl26aUNuGwxapnU2TFhoqKH3Wtgl4pq4MzTYygzTnV/YmfdvonQ/nyyT6jibCLRamrXWT4fMCtm2t/0wZNGkYwd7tXyl5KzavEUf/qbeNojJ1ESslQvtTCFa4bOPwradjyJ2+dQkGgvq7tEb/O4a3ZB3VS20hCa2eygyupwDKMtzrLERZ1IQCvBnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40480700001)(186003)(16526019)(40460700003)(2616005)(36756003)(316002)(86362001)(478600001)(81166007)(54906003)(110136005)(356005)(70586007)(70206006)(6666004)(7696005)(4326008)(6636002)(82740400003)(1076003)(41300700001)(26005)(336012)(8936002)(8676002)(66574015)(47076005)(5660300002)(426003)(83380400001)(2906002)(36860700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 02:19:55.6405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2962f9ed-acc3-4923-5ee0-08db92fef671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Missing a blank line after declarations
WARNING: Too many leading tabs - consider code refactoring
+                                               if (list_connector->connector_type != DRM_MODE_CONNECTOR_VGA) {
WARNING: Too many leading tabs - consider code refactoring
+                                                       if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 69 +++++++++++--------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index d34037b85cf8..173e836b00fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -103,7 +103,7 @@ int amdgpu_connector_get_monitor_bpc(struct drm_connector *connector)
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	struct amdgpu_connector_atom_dig *dig_connector;
 	int bpc = 8;
-	unsigned mode_clock, max_tmds_clock;
+	unsigned int mode_clock, max_tmds_clock;
 
 	switch (connector->connector_type) {
 	case DRM_MODE_CONNECTOR_DVII:
@@ -255,6 +255,7 @@ struct edid *amdgpu_connector_edid(struct drm_connector *connector)
 		return amdgpu_connector->edid;
 	} else if (edid_blob) {
 		struct edid *edid = kmemdup(edid_blob->data, edid_blob->length, GFP_KERNEL);
+
 		if (edid)
 			amdgpu_connector->edid = edid;
 	}
@@ -588,6 +589,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 			amdgpu_encoder = to_amdgpu_encoder(connector->encoder);
 		} else {
 			const struct drm_connector_helper_funcs *connector_funcs = connector->helper_private;
+
 			amdgpu_encoder = to_amdgpu_encoder(connector_funcs->best_encoder(connector));
 		}
 
@@ -804,6 +806,7 @@ static int amdgpu_connector_set_lcd_property(struct drm_connector *connector,
 		amdgpu_encoder = to_amdgpu_encoder(connector->encoder);
 	else {
 		const struct drm_connector_helper_funcs *connector_funcs = connector->helper_private;
+
 		amdgpu_encoder = to_amdgpu_encoder(connector_funcs->best_encoder(connector));
 	}
 
@@ -986,6 +989,41 @@ amdgpu_connector_check_hpd_status_unchanged(struct drm_connector *connector)
 	return false;
 }
 
+static void amdgpu_connector_shared_ddc(enum drm_connector_status *status,
+					struct drm_connector *connector,
+					struct amdgpu_connector *amdgpu_connector)
+{
+	struct drm_connector *list_connector;
+	struct drm_connector_list_iter iter;
+	struct amdgpu_connector *list_amdgpu_connector;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	if (amdgpu_connector->shared_ddc && *status == connector_status_connected) {
+		drm_connector_list_iter_begin(dev, &iter);
+		drm_for_each_connector_iter(list_connector,
+					    &iter) {
+			if (connector == list_connector)
+				continue;
+			list_amdgpu_connector = to_amdgpu_connector(list_connector);
+			if (list_amdgpu_connector->shared_ddc &&
+			    list_amdgpu_connector->ddc_bus->rec.i2c_id ==
+			     amdgpu_connector->ddc_bus->rec.i2c_id) {
+				/* cases where both connectors are digital */
+				if (list_connector->connector_type != DRM_MODE_CONNECTOR_VGA) {
+					/* hpd is our only option in this case */
+					if (!amdgpu_display_hpd_sense(adev,
+								      amdgpu_connector->hpd.hpd)) {
+						amdgpu_connector_free_edid(connector);
+						*status = connector_status_disconnected;
+					}
+				}
+			}
+		}
+		drm_connector_list_iter_end(&iter);
+	}
+}
+
 /*
  * DVI is complicated
  * Do a DDC probe, if DDC probe passes, get the full EDID so
@@ -1072,32 +1110,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 			 * DDC line.  The latter is more complex because with DVI<->HDMI adapters
 			 * you don't really know what's connected to which port as both are digital.
 			 */
-			if (amdgpu_connector->shared_ddc && (ret == connector_status_connected)) {
-				struct drm_connector *list_connector;
-				struct drm_connector_list_iter iter;
-				struct amdgpu_connector *list_amdgpu_connector;
-
-				drm_connector_list_iter_begin(dev, &iter);
-				drm_for_each_connector_iter(list_connector,
-							    &iter) {
-					if (connector == list_connector)
-						continue;
-					list_amdgpu_connector = to_amdgpu_connector(list_connector);
-					if (list_amdgpu_connector->shared_ddc &&
-					    (list_amdgpu_connector->ddc_bus->rec.i2c_id ==
-					     amdgpu_connector->ddc_bus->rec.i2c_id)) {
-						/* cases where both connectors are digital */
-						if (list_connector->connector_type != DRM_MODE_CONNECTOR_VGA) {
-							/* hpd is our only option in this case */
-							if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
-								amdgpu_connector_free_edid(connector);
-								ret = connector_status_disconnected;
-							}
-						}
-					}
-				}
-				drm_connector_list_iter_end(&iter);
-			}
+			 amdgpu_connector_shared_ddc(&ret, connector, amdgpu_connector);
 		}
 	}
 
@@ -1199,6 +1212,7 @@ amdgpu_connector_dvi_encoder(struct drm_connector *connector)
 static void amdgpu_connector_dvi_force(struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
+
 	if (connector->force == DRM_FORCE_ON)
 		amdgpu_connector->use_digital = false;
 	if (connector->force == DRM_FORCE_ON_DIGITAL)
@@ -1433,6 +1447,7 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 				ret = connector_status_connected;
 			else if (amdgpu_connector->dac_load_detect) { /* try load detection */
 				const struct drm_encoder_helper_funcs *encoder_funcs = encoder->helper_private;
+
 				ret = encoder_funcs->detect(encoder, connector);
 			}
 		}
-- 
2.25.1

