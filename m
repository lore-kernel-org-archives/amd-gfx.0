Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11840C56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 19:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7328621D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nTGrFfdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7328621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CF16E9C7;
	Thu, 26 Nov 2020 19:50:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBB56EABA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 19:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf1zhVnig9zdlnCXdTXhf779fSjcthyyvipheqvoYGOK+r1fabUKvobC+6BEIzIF8ZYGiX9m0OAnjuogiwv5S+sljUpOSJKtlWw019fMwLuiUmu4zsjaq4iblHoQoLA+MKGrlMPZMaPUKAXn5mzGa2OgbslYjas+yn6VhoMOHsN0ZVQKc3bK2Dt7jmu73dHOFgycZlWYoXqSLxVhwbw1bIQDn71Y2EX5yS6WdEFnIo92QZiVOru9Ahb5u6lFsbJ3XbNVcXttfX4xshjFDQl8adkPsPl7+4lkMcLWmcx5a7266La0eV63DFwhPmXgqAXt0pDPCW4T6ZKDpoOiX7rLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER7kyNTmLCDLXkihY4eHqMA5R4HAnVftE7LmYPzQVvI=;
 b=YMtogOe5pVVjoheZvEdT8xNuCqMKb8Cp3VLeT/tD30rId8cb3n1c/jC0NJKxcxGNx8fd0Mdok+Q9A/dQo10iuMccRugzFdL9G3jwLVhJCYAwS4ZLi4CguxitnBiT4nkd8uMsrbUXDdYUkanCCoZ8Y3xfGlTCuiv/YR8IYDNqtPih4izT5YaLiNYT3Oi7Z42vxY2okIUrvepTGiMVbRrNMJxyKfluwD5ZvQ0+Q8s8Vlt0fJWrE7vc+OstT7Lo0H3MqZrAsB0FksBC7ZeUzd/Ffu2weYUk9Gxww65wFcU4AV4BdlSPBWbY6TF3YWej1tbqucDNZ98YAVRvV+Nhx2wA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER7kyNTmLCDLXkihY4eHqMA5R4HAnVftE7LmYPzQVvI=;
 b=nTGrFfdjN8TD340AiSXpy0wcPLVrGrKHsW53nKOzIDbtWQfu6wi/rwoAFq2Whc413wuIrL8YphSFSVWAR+bhavpD+oiNPRq1VcA4NnFNtzWrzMGtl0xaVDT5SVnkGbXBdMRZt86vWFUa912JYDtECb+nY7drQCvzFAzE3VS140Q=
Received: from DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31)
 by DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 26 Nov
 2020 19:50:43 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::57) by DM5PR1101CA0021.outlook.office365.com
 (2603:10b6:4:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Thu, 26 Nov 2020 19:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Thu, 26 Nov 2020 19:50:43 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 26 Nov
 2020 13:50:42 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 13:50:36 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: turn DPMS off on mst connector unplug
Date: Thu, 26 Nov 2020 14:50:36 -0500
Message-ID: <20201126195036.310979-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cfd3223-d5d6-40ce-5357-08d892448f3c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2697:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26978DBB9138263FF219F9D28BF90@DM6PR12MB2697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DRxOFFc1i5ALRdwvoR++tDT+YyVg+aom39qvW5C/DvGOGqOwtXc6m9mYb8g8Q1ZGgO8nu/fCtukaeEEhc7iCD5mBaKFC/yqDldTHv81sFkny6rS7lG65mRbsa0kzVGOOu2t+Rkj1zqRKr0GykALEdPf+0nTnIsf5F3hZYLYIDjNp1VVCe2B9+nYtiILM5PBL0A8LJtXgjdGDvmf2GMv7fqHYa0228I/O15FoQuG4Uyl9ljr+H1z2W5JBbioHEQGpdI4ZmgizWqJhEyycv27AXOPhVBtPtmbEC9P28KJ4S57wy0NMzBYMBg0+8goXSEPZ1pa1aY5cPkzxOxYU2bi6z/fxZooQ8todj7AGw5FP2c6cUR40pHig6p94RyPIyDTRaQT0gQYjNaesqDuHjC0eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(4326008)(426003)(8676002)(2616005)(186003)(47076004)(336012)(83380400001)(356005)(86362001)(5660300002)(81166007)(1076003)(82740400003)(70206006)(70586007)(316002)(82310400003)(36756003)(44832011)(8936002)(478600001)(26005)(2906002)(54906003)(7696005)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 19:50:43.0432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfd3223-d5d6-40ce-5357-08d892448f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
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
Cc: Bhawanpreet.Lakha@amd.com, aurabindo.pillai@amd.com, Harry.Wentland@amd.com,
 nicholas.kazlauskas@amd.com, Eryk Brol <eryk.brol@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]

Set dpms off on the MST connector that was unplugged, for the side effect of
releasing some references held through deallocation of mst payload.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e213246e3f04..fc984cf6e316 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1984,6 +1984,64 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
+static void dm_set_dpms_off(struct dc_link *link)
+{
+	struct {
+		struct dc_surface_update surface_updates[MAX_SURFACES];
+		struct dc_stream_update stream_update;
+	} * bundle;
+	struct dc_stream_state *stream_state;
+	struct dc_context *dc_ctx = link->ctx;
+	int i;
+
+	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
+
+	if (!bundle) {
+		dm_error("Failed to allocate update bundle\n");
+		return;
+	}
+
+	bundle->stream_update.dpms_off = kzalloc(sizeof(bool), GFP_KERNEL);
+
+	if (!bundle->stream_update.dpms_off) {
+		dm_error("Failed to allocate update bundle\n");
+		goto cleanup;
+	}
+
+	*bundle->stream_update.dpms_off = true;
+
+	for (i = 0; i< MAX_PIPES; i++) {
+		if (dc_ctx->dc->current_state->streams[i] == NULL)
+			continue;
+
+		if (dc_ctx->dc->current_state->streams[i]->link == link) {
+			stream_state = dc_ctx->dc->current_state->streams[i];
+			goto link_found;
+		}
+	}
+
+	dm_error("Cannot find link associated with the stream to be disabled\n");
+	return;
+
+link_found:
+	if (stream_state == NULL) {
+		dm_error("Stream state associated with the link is NULL\n");
+		return;
+	}
+
+	bundle->stream_update.stream = stream_state;
+
+	dc_commit_updates_for_stream(stream_state->ctx->dc, bundle->surface_updates, 0,
+				     stream_state, &bundle->stream_update,
+				     stream_state->ctx->dc->current_state);
+
+	kfree(bundle->stream_update.dpms_off);
+cleanup:
+	kfree(bundle);
+
+	return;
+}
+
 static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -2434,8 +2492,11 @@ static void handle_hpd_irq(void *param)
 			drm_kms_helper_hotplug_event(dev);
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
-		amdgpu_dm_update_connector_after_detect(aconnector);
+		if (new_connection_type == dc_connection_none &&
+		    aconnector->dc_link->type == dc_connection_none)
+			dm_set_dpms_off(aconnector->dc_link);
 
+		amdgpu_dm_update_connector_after_detect(aconnector);
 
 		drm_modeset_lock_all(dev);
 		dm_restore_drm_connector_state(dev, connector);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
