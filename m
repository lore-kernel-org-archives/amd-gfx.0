Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B5C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE5B10F2B8;
	Fri, 17 Jun 2022 19:35:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D02510F2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqxhcNzU03ehvANqCeYKDymX3w9XiH5lhX2FI1LKJyiM/g/mBLMAKq4Aji9USG27QmXQAcfcgJ34hryl5feCKWn+60XMpo7mFldsA759TwJ7MG7+9UwG/RRyz6Ls/9MFKNIPz5HiB3rI55HTlb4rAi4/bqe2ofRV5etirJ4ME0wL8v3Qt25RH+olvjU7/kS06Xkz72n42thU5pTADxNvAV12as1G05+2FlZ6UnxquqP735w6yu1BDW3Imp+e7oK0CzQ17zRv0NIiXI/Ir1L8Lk+fWjBAiEdMY5dagzet4ll3AfkkPE12t6U3zO8N4RtGPeT3qktTy7waKT5pflnUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxGyUDMW0Zj4hDE41l/mf0OYePEswv426j4TaGPDEK8=;
 b=XxmdKm/NrJyO8yv1YLIzDlG9cMty7JmETcW65dbMwmxANs/lSt7ENYpFEYdfV7BfU90qaTZDbVWkDHT+51djzUoMhf6MdkSSbIKNPVtoZiML6Jac0UyGviYehM273vA1rRJXrM2ljqXzdedse0+ndbQMjwADGSusAcbvnhd+P6sAlMH8GWswoIe042Us44y4dlCSow1IoymwCvirImVVZSz4oioNMcxS2yY+gy2Xo/lO4wTz4JZKzoqbOAXoPtNJZpE86wax8maUyc9BkY6z2BWUNqpVZXqnzvSjIHm2ipvZm0ycMHyCGR+giMEOo1RjWP8JC7F552RJJrAcaM2O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxGyUDMW0Zj4hDE41l/mf0OYePEswv426j4TaGPDEK8=;
 b=1th1vo7V4uXRaglwJ7pkFPaohKvXf1tQ5MDfR4i0/H3m3yKO3yogeybIsJIsBn+czO0tTj3NnyycIpFlD0dJGlSQ2cj9LqZ36hBFvD4Af0fL1liMmuQSjTO6+9sHQzEVtdyoDrJyxz3rbmCYfguHUtF68fDVxlYvscMrbmf470E=
Received: from BN6PR14CA0036.namprd14.prod.outlook.com (2603:10b6:404:13f::22)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 17 Jun
 2022 19:35:39 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::c0) by BN6PR14CA0036.outlook.office365.com
 (2603:10b6:404:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:39 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/31] drm/amd/display: Revert "drm/amd/display: turn DPMS off
 on connector unplug"
Date: Fri, 17 Jun 2022 15:34:44 -0400
Message-ID: <20220617193512.3471076-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e141f096-6980-48a5-fcd2-08da50988f56
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578A786545259017C8DE8C198AF9@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPK3PWP7zdERkpXb0SIw2R6WDYT5nws1SEhCkCwWZThT55Av32DzNYWW3ITHqKIkntkoNY/NdvJ8bfhav7FjE/IJ9DN44oeOQJ4Flnc2UtM4+aDxpgMmcjzT5zY3DO+pFvQAYQPcgw2kbQBfDEyZoOawltdwZm7IstmMlFf6FBBEps8hqtXOVT14QDa2wM7zHiHhzt1rPRpTeFuNJnMJSb11EZ9Xyo5wksphA3VJ9LJRL+sEVn5orEcnDKd0jekbYclALD1W4rJMYuzyUjsu0CtD41Hpm/IyfyMK27C2qkjrdupVvMMHGyDY67w/SKtRh6XGrUr1stY8AFz78cXaOL2Efxtxbhvyzac+CKtmve4DheqRO2QZU1Xmou45kg4tSCfnkOPR8YSEWHjnyIu41FiYxU+JuihqWvuDV2dNXBzqOphbHpBv05/j6akmt/gqkND3Mz/qIWH/Lce+RL5nv3UyUv5zIhch/b1KAwbRNcIDL2L/ONik+reLLmGet/0m7MGrUeaV+QuMU0q7dRyi0p2IUwZ15HGbE0fQ1SjPe3mysjxVcOnfqiqjUnybrIGvXftJyPkGIt6VkR1abPdLtp4nTkLkz0+3Z2DF+R/jZSIZJnyyfCXFxd1HQMAt3Axrn6yhr2vfG0tOITLaxcaEwvUGuXnEaTdFRDznxNSziyNgs4eWs8+FV7oevZDUJMp3jPGEfGptagqrqwWhw14vzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(336012)(54906003)(36756003)(1076003)(426003)(8676002)(83380400001)(186003)(36860700001)(81166007)(70206006)(4326008)(316002)(47076005)(86362001)(16526019)(6916009)(70586007)(5660300002)(40460700003)(498600001)(6666004)(356005)(2906002)(2616005)(26005)(8936002)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:39.5815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e141f096-6980-48a5-fcd2-08da50988f56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

This reverts commit 3c4d55c9b9becedd8d31a7c96783a364533713ab.

Revert the commit because:
- It's incomplete of the function dm_set_dpms_off() for mst case.  For
  stream sinks whithin the same mst topology, they share the same dc_link.
  dm_set_dpms_off() tries to update one mst stream only which is
  incomplete.
- Setting dpms off should be triggered by usermode. Besdies, it seems
  usermode does release relevant resource for mst & non-mst case when
  unplug connecotr now.

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 -------------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 --------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
 3 files changed, 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index beba783dd6ef..0c90667f682a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2582,33 +2582,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
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
@@ -3095,10 +3068,6 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			drm_kms_helper_connector_hotplug_event(connector);
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
-		if (new_connection_type == dc_connection_none &&
-		    aconnector->dc_link->type == dc_connection_none)
-			dm_set_dpms_off(aconnector->dc_link);
-
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
 		drm_modeset_lock_all(dev);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 48a14a5bda56..146fd4b864b2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3325,19 +3325,6 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i)
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
index 5a894c19b0ea..6f79327e0035 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -351,7 +351,6 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream);
 
 uint8_t dc_get_current_stream_count(struct dc *dc);
 struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
-struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link);
 
 /*
  * Return the current frame counter.
-- 
2.25.1

