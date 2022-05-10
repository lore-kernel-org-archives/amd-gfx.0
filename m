Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DADC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 09:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C797E10F57D;
	Tue, 10 May 2022 09:58:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB22010F578
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 09:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsiB0gJIl6Joy9Xm/h6plnf1Gq+c2J/dZdgY9Bg4MlSnkwOan3aA+Q07O2bswCBDZwSzs28pPlb+IefHM3ZiqNBqvdsXsFw+JfLWvoZrBILebc4pgYSGK4zYg9pjjDMsReriM01bS8vFw5zSKuS7Cv9W687IYOgON1LMSbZF1EgzhoT65lF+Y363QLxdK040hQu2O1Y2QUIt/ss9jSPJDWdUtYsBWOxOkSNlaFg+zP+WN/iep9XxQxuiaUK05wJVYBW3mHMHA9ZF/apphMGQeeHObs6BPLiVTgNR50to7CPok5/mF8jTW9w48uXxxnsX9VcuAAweyA+RhriDFF8+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x6bLtzQwOCePJvdwDBoYc3W2STGnpYFn1eikIUUk2E=;
 b=PuzcrHMrNqYskDrARA9GPvoXjHuRpl/rt/sKqRMX9nd3vY0+anWqMXrBvyBnFtqXuYi8BHxpiQK3d4zf8CvWrZ920MucHA+B2w5NWNWOVPWD4zsUcIXA3JGpr3o8ypjT/Q8CeshB/pKmOO4cL4fBPICCKKS3bohDticjc2eMTIrGbdnzvnFzEJyzU7W3K8E7lF5l8YLE/QrPSPu6L2sAVq9g2IgzU9r6A3JfWyBoCjMxRj3mdvsSFrzjQUtFKSJYsUIAswvZJzgQXllnp6kljcmST0fejd4XozclQF05OGFgA3thydyZavy/upi379mioKNyf78vmd5AaOe/uuqJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x6bLtzQwOCePJvdwDBoYc3W2STGnpYFn1eikIUUk2E=;
 b=ClvsbBZILCvKwb1Pmbg1D76q0w34Tr36j9bMTL2+5gZK6NFAe2PWl991CPE9gUMBkot5GIaqoDQlxCNO+ojOj2YLLMAQyN5fAQQ4x1wV1T7V7+/GbNsEpdytCggJQLQC60hGmUaaiWT/dqH0VNEGJUo0B24C6Ma3LL67tc+4Pgc=
Received: from BN0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:e8::27)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 09:58:00 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::bb) by BN0PR04CA0052.outlook.office365.com
 (2603:10b6:408:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 09:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 09:57:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 04:57:59 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 10 May 2022 04:57:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] Revert "drm/amd/display: turn DPMS off on connector
 unplug"
Date: Tue, 10 May 2022 17:57:00 +0800
Message-ID: <20220510095701.57375-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510095701.57375-1-Wayne.Lin@amd.com>
References: <20220510095701.57375-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d76bd0-76dd-48f1-b345-08da326b90d8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317BA59D2E584F1F1E33040FCC99@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZCNMwQOUoeLfEPHA3ptSGO0dQGpj8iLAsVuwcy2G3aXFgM8qXQkP2QOYesKsAJQCbTL7NIKRTxSG5jDO9D3ppcRWzBj9eQNy6Bn5IJuAh0SBIUoqpt1GzGJIrBM47q7EvG3I0y3hwFYUdS+06EqldrBqUREFhgGO7Mqo0slFhrCYnXEkqnm3dWzX8gmq08JQsRVIEZmjhH7Sl0OUCpw3osk2nH+IYhXs+s2wO9xTjgJyF5iWF2KoTJfQfMwp6T4qquJvaJTuwSEYHqgzC1eAvHU2i4ycSmfrVfRgsgsmpK3ttHte/o9Z4I1CpJBX8s58czRQUb3hlq5dgJgFJrCULfPmPxQ1TSfe6RvQUm193Sg6v9p+nsXokayHKzFZwqt/e5MLV/ICZZsl4gKqQe0lwXAEEB9Ilmg+VByUInW7xSvnEiFdIO8WKy+KOk1s1E3Co+ETW9vUdg1ozn366nl4M3KTdJb+M5lA6WwuG9qAjiOSr4ccv2aIRtUsH4FtqZqSu4LN5ZpNGcS3GwMUKtQnWRANQpnhO1f8wfIaCXn/MbrcBrx7MyTSqFdBsvHp9pBvu8IQfDPcneBzSzvMAf6MzerwctotIDWaYgTGKVTme/a1VQsgb07Z/H2/6DGZR8UVrJWvfXZLi2ke365Di5g+D11YPN9QbyJI7Fh872ukz9Hab9YMhsonKEfWCjw3mM4ZTegoFbSS0NDikzxbcUbyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(40460700003)(36860700001)(4326008)(2616005)(8676002)(86362001)(2906002)(7696005)(6666004)(81166007)(356005)(83380400001)(316002)(5660300002)(47076005)(508600001)(8936002)(1076003)(36756003)(186003)(6916009)(70206006)(70586007)(82310400005)(336012)(426003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:57:59.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d76bd0-76dd-48f1-b345-08da326b90d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3c4d55c9b9becedd8d31a7c96783a364533713ab.

[Why and How]
Revert the commit because:
- It's incomplete of the function dm_set_dpms_off() for mst case.
  For stream sinks whithin the same mst topology, they share the
  same dc_link. dm_set_dpms_off() tries to update one mst stream
  only which is incomplete.
- Setting dpms off should be triggered by usermode. Besdies, it seems
  usermode does release relevant resource for mst & non-mst case
  when unplug connecotr now.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 -------------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 --------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
 3 files changed, 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 01a36c550778..d81b9ef11dba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2575,33 +2575,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
-static void dm_set_dpms_off(struct dc_link *link)
-{
-	struct dc_stream_state *stream_state;
-	struct amdgpu_dm_connector *aconnector = link->priv;
-	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
-	struct dc_stream_update stream_update;
-	bool dpms_off = true;
-
-	memset(&stream_update, 0, sizeof(stream_update));
-	stream_update.dpms_off = &dpms_off;
-
-	mutex_lock(&adev->dm.dc_lock);
-	stream_state = dc_stream_find_from_link(link);
-
-	if (stream_state == NULL) {
-		DRM_DEBUG_DRIVER("Error finding stream state associated with link!\n");
-		mutex_unlock(&adev->dm.dc_lock);
-		return;
-	}
-
-	stream_update.stream = stream_state;
-	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
-				     stream_state, &stream_update,
-				     stream_state->ctx->dc->current_state);
-	mutex_unlock(&adev->dm.dc_lock);
-}
-
 static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -3088,10 +3061,6 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			drm_kms_helper_connector_hotplug_event(connector);
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
-		if (new_connection_type == dc_connection_none &&
-		    aconnector->dc_link->type == dc_connection_none)
-			dm_set_dpms_off(aconnector->dc_link);
-
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
 		drm_modeset_lock_all(dev);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c2fcd67bcc4d..cc2910d251d2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3260,19 +3260,6 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i)
 	return NULL;
 }
 
-struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link)
-{
-	uint8_t i;
-	struct dc_context *ctx = link->ctx;
-
-	for (i = 0; i < ctx->dc->current_state->stream_count; i++) {
-		if (ctx->dc->current_state->streams[i]->link == link)
-			return ctx->dc->current_state->streams[i];
-	}
-
-	return NULL;
-}
-
 enum dc_irq_source dc_interrupt_to_irq_source(
 		struct dc *dc,
 		uint32_t src_id,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 58941f4defb3..fecdbc75b47b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -323,7 +323,6 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream);
 
 uint8_t dc_get_current_stream_count(struct dc *dc);
 struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
-struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link);
 
 /*
  * Return the current frame counter.
-- 
2.36.1

