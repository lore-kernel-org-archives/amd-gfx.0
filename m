Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3E8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7883061391
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7883061391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3FA6EA17;
	Mon,  4 Oct 2021 14:46:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B976EA17
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGe1qZKJEOuQgk8YKIVUqzbCxBozXitR+B91d/lkjRqR7Lr5VMVffKRIaRxf44nx81PjaORZdUZdoNgyS4JwYCc3w6M6k21Pc8Gff3wMduw7CBBDtoQL8C+GtvEhLN61QSSQJuhUsvCoGfCBIgY91eISHSIUIZP2lePu+JvwABoOkeKf1gDc7t7niw1ie7eVgijdXbeBcw56u2F857QOoLsoBtOgJbmRzc3zK5v8Q9M+2BMhWp0UmglpxY+qEfpj64Zo4U/7/gTFiY3iYWDWvXThzCEpDAnmppyg/w7p+dSaRvqUeTBVk2LipWgjU+YDEQb4cQnndyot96spuSTXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbo8/8Xpu4532brjbAi7duU2LeqRU4VomFRH8Ak2M+s=;
 b=Jld9hWQdh6YX4JOKKNIVMXLW6ekDca5VGvW30UKl1PiCpyeOPu42KXqSinRP95YKU4oEfPKOI+D6QMebIhf/Rt13Iui4E0Ke7UR7YCZc8dh+1AyfJJjtTiWoko95SYq170mXiPgN0hFjLKzl6UgzpeITZMX9IKvUxhpWAYzbq0Ytohj2m19wq9YoMADrt1FUZdkzaHvy4uTvVl+pJlZ3eHlW7RwCtXl9RXmROwBEChvbzMu27di2vTj59L1CY8JqIqOwaeuGdMDNYnNsacwb3xrCmpU7991qBtQk01TZGzG9eWCPuSufWVPnhMKUeOWQ/1gTfo6LFMrgQPuMezGO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbo8/8Xpu4532brjbAi7duU2LeqRU4VomFRH8Ak2M+s=;
 b=kZy/vD3w7PHof9E8w7UFAtIh6VOFDP6mSqx2jdWpoWLPtO1LKRsdxj8NJp0wgnh3IDcISbAURSGys7h436l0Y6fLYd+BtL7pjzaiQVVROVOaraWZ7emyxwvkWxyOwShHq3UJ6pGrmgAVfivbiD+XBHBUjdZr/YqkWPdS9EEXaZw=
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 14:45:59 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::93) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Mon, 4 Oct 2021 14:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:45:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:45:57 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:45:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 21/23] drm/amd/display: Deadlock/HPD Status/Crash Bug Fix
Date: Mon, 4 Oct 2021 22:40:48 +0800
Message-ID: <20211004144050.3425351-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f8271c4-edf9-46c2-6374-08d98745aded
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486502ECFDE711D914B7054FCAE9@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+IFxxTlu1cbXykyn3zgANir/xLTY5W5wk8kAtgCRPjNDmVIcKmSzx/HYyaNipSEB/wk5RwpvjP+9aggcAzvfJcoczLMGwNg/MywxSTdDZEjgzfM3pmDNNCQCv7I3n3ciIKLsfxFb2HQ8IK35ubwlyhd5dIMKSIGxfk1vW3emgsHxgrsrsgyDvLDOqs5EKf/AV7/oMhYt8+daxG6+XGFi1tE29Wsg2fnFFP7I6c9PIKePNCRxJPn0LeWHjY4o3lUZq/ldjKqLu49a3ULNw3+tT9SizUWsY6Yc0Pn4D4CMW1+rmj+Do2sIcs2VSJ0zl63RxtIPF7EDFoXeYsWAe/s4Wd7CjyG9Can+CWuGT6nj4zoWDCyv3EiJHGUA9k8tHUPYLQWVLglDCv/ToZELD+rL7x/qLoZ66nyQiCNoeUvAKx7oXVk9158LC0XcZEVx6mUcjutiPEMnFgMgmXBbTf7t3ikxThFI0uvX9V1LloLUJPtsssCzmPrKOe6Sl25am2MD1p7Jq+SNnP7AHwNK3l8mjskwTGtV/bLQpU56QJBvzta0jVUIEkyxt/o2VHBjSuTEAvEyjqQB9sFzU6G0t7+fveXRpUrNMGfEywmfkwOB5eQ5qHfR06XdgYuB+zizDR9SmcfT5HDqmA62XYginwFUpvmWgiTWy+v39KJMeIrnjbPoWI90eCLW5kone0S3RWeJmrS91XRuUbBCbHj2jq8GxxXWZiotfsMuf8phbYGzPg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(82310400003)(2906002)(316002)(70586007)(6916009)(83380400001)(47076005)(70206006)(36860700001)(86362001)(54906003)(2616005)(356005)(5660300002)(26005)(1076003)(7696005)(336012)(426003)(8676002)(508600001)(4326008)(186003)(81166007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:45:58.8677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8271c4-edf9-46c2-6374-08d98745aded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
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

From: Jude Shih <shenshih@amd.com>

[why]
1. HPD callback function has deadlock problem
2. HPD status is not assigned
3. There is crash due to null pointer
4. link_enc is NULL in DPIA case

[How]
1. Fix deadlock problem by moving it out of the
   drm_modeset_lock
2. Assign HPD status from the notify of outbox
   from dmub FW
3. Fix the crash by checking if pin or enc exists
4. Use link_enc_cfg_get_link_enc_used_by_link to
   dynamically assign

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 41692ae30822..cbf83a6e56b9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -29,6 +29,7 @@
 #include "dm_services_types.h"
 #include "dc.h"
 #include "dc_link_dp.h"
+#include "link_enc_cfg.h"
 #include "dc/inc/core_types.h"
 #include "dal_asic_id.h"
 #include "dmub/dmub_srv.h"
@@ -648,6 +649,7 @@ void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notific
 void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
 {
 	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *hpd_aconnector = NULL;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct dc_link *link;
@@ -678,13 +680,15 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
 			DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
-			handle_hpd_irq_helper(aconnector);
+			hpd_aconnector = aconnector;
 			break;
 		}
 	}
 	drm_connector_list_iter_end(&iter);
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 
+	if (hpd_aconnector)
+		handle_hpd_irq_helper(hpd_aconnector);
 }
 
 /**
@@ -747,7 +751,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct dmcub_trace_buf_entry entry = { 0 };
 	uint32_t count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
-
+	struct dc_link *plink = NULL;
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
 		dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
 		if (!dmub_hpd_wrk) {
@@ -767,6 +771,11 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 				if (dm->dmub_thread_offload[notify.type] == true) {
 					dmub_hpd_wrk->dmub_notify = &notify;
 					dmub_hpd_wrk->adev = adev;
+					if (notify.type == DMUB_NOTIFICATION_HPD) {
+						plink = adev->dm.dc->links[notify.link_index];
+						if (plink)
+							plink->hpd_status = notify.hpd_status == DP_HPD_PLUG ? true : false;
+					}
 					queue_work(adev->dm.delayed_hpd_wq, &dmub_hpd_wrk->handle_hpd_work);
 				} else {
 					dm->dmub_callback[notify.type](adev, &notify);
@@ -794,7 +803,8 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 
 	} while (count <= DMUB_TRACE_MAX_READ);
 
-	ASSERT(count <= DMUB_TRACE_MAX_READ);
+	if (count > DMUB_TRACE_MAX_READ)
+		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
 }
 #endif
 
@@ -2913,7 +2923,6 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	if (aconnector->base.force && new_connection_type == dc_connection_none) {
 		emulated_link_detect(aconnector->dc_link);
 
-
 		drm_modeset_lock_all(dev);
 		dm_restore_drm_connector_state(dev, connector);
 		drm_modeset_unlock_all(dev);
@@ -8101,7 +8110,15 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		break;
 	case DRM_MODE_CONNECTOR_DisplayPort:
 		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
-		aconnector->base.ycbcr_420_allowed =
+		if (link->is_dig_mapping_flexible &&
+		    link->dc->res_pool->funcs->link_encs_assign) {
+			link->link_enc = link_enc_cfg_get_link_enc_used_by_link(link->ctx->dc, link);
+			if (!link->link_enc)
+				link->link_enc = link_enc_cfg_get_next_avail_link_enc(link->ctx->dc);
+		}
+
+		if (link->link_enc)
+			aconnector->base.ycbcr_420_allowed =
 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
 		break;
 	case DRM_MODE_CONNECTOR_DVID:
@@ -8216,7 +8233,8 @@ create_i2c(struct ddc_service *ddc_service,
 	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d", link_index);
 	i2c_set_adapdata(&i2c->base, i2c);
 	i2c->ddc_service = ddc_service;
-	i2c->ddc_service->ddc_pin->hw_info.ddc_channel = link_index;
+	if (i2c->ddc_service->ddc_pin)
+		i2c->ddc_service->ddc_pin->hw_info.ddc_channel = link_index;
 
 	return i2c;
 }
-- 
2.25.1

