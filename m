Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9553C63798
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 21:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D18120872
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 21:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L40pDieo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D18120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6CF6E89C;
	Thu, 26 Nov 2020 21:46:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31C66E89C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 21:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHp3DDtg88bByIYiAEtKM3owrwfDlQQVLHZ3UzevghMJ/YpDfBV+WenGOmeXNxu1eSI6mLvSs5HGkjJSyE77NzCzu7rsIo3tLqjMxitIq5oIwK++f7+vN8TNgwFQSUYLJPfaJkuo0NN3p3+KV/Q2p33W2iQ7gRr8b66YQSEsFpXgsuJSixEdLgFRQ3HKfPKtWeoBGCcg82+ZotowQRiAHr4TesNoOju4J/C7OMBe7JNlgxdN8+J1Bjcncj5nLjkDoF1iUlzUKpWZTK5cXtkyItd+pAunF8aBkvkjFqmhzn4WOOjfno6DLG+wWHQe8p1aZ00Lr6rRPWux2XecTkBx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuTkW2bEWF2vC1X3MGWv2fEMHlFs8jJyGy/xT1IK9/o=;
 b=XbTzL6GzUBtOScrXL6CMctlH7DP9kmG4dBefz5Wx7ainiZ3ZlzC1Md+lTav4JGiBBm53hxvxg+ltL6UKF92PKZG/VzMRA/YeGv01UMIPW87EipDn4Swhq4osS5U1WZO7sCsvenlBjXC6Q0FijuxDc9/7LxHa+HlbfN8WMmjzYeGkldw5MMX3WCdI/v18RgPkwJNYc4GeqRWsQRz1nbtx1oSigzsIgHfNnJMJFocEiOh5rOVTBlBJF6YL9z8k2SZIJ9b5S0di/XlBRzLAw6R7pPUAZ0eQszajwgOE0kBuGOUPlHwsY7Uq61it4+C/kz83LaSgTyNAkkx6xsPiSBhZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuTkW2bEWF2vC1X3MGWv2fEMHlFs8jJyGy/xT1IK9/o=;
 b=L40pDieo4NJlcAB6AyYRy3mxHTK5Sz1g+0xz867HaCGq0Q8x48w/6RNdi6Zr1YX+SpvHZ+c+sVssvW9pm+P1nGPoFax9k/Yg7eBkEvxE6Gf1xIxUj480dJ4Pj3/JP62UIq4WDzbM8iJrO/U2bZ1yQznoXiUsxU3pfUnJazL1JpM=
Received: from BN6PR14CA0034.namprd14.prod.outlook.com (2603:10b6:404:13f::20)
 by BN6PR1201MB0242.namprd12.prod.outlook.com (2603:10b6:405:57::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 21:46:06 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::a7) by BN6PR14CA0034.outlook.office365.com
 (2603:10b6:404:13f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Thu, 26 Nov 2020 21:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Thu, 26 Nov 2020 21:46:06 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 26 Nov
 2020 15:46:05 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 15:46:00 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: turn DPMS off on mst connector unplug
Date: Thu, 26 Nov 2020 16:45:59 -0500
Message-ID: <20201126214559.170553-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4746e4cb-0224-4839-e7c6-08d89254adaa
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0242:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB024273004152DE9379165EF08BF90@BN6PR1201MB0242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4mc3rGE2TtshSBJiLr4kbq+/CQP9hRjYccDeeyHthA7QjSFl/FjmD2UraQY+6Y1FW4TwlGjE769BoKjwGCqNN0WX//Pk2eKrrPaTeHhZF8osVqwhxfk0R7VJYQ8DdMbqW/kvk5mBChS5eS5IDqVlb1ICf7/p54zZeb/aj15RmeOO5/T7dJ4kYzDxWNylvn8MzX2cF5TQzSNGHcPH0HL5pbMnI6SMWJeoIv3+OsFqFmPxyjgM070av48trHfoQweO5gVR5KL3Ncv9WfAVrWIRN76FZJAl/+KJGw2Z8tBnMlsE75nJsA/HhQYsjHQ4pByjyiGGE36izm/RT/Fxgb7ybhhRNsaSMUJgfBkN9efcPCuCZpnxPb1luvOt3Nk/HFnBA9ATRkV6pGDq3Z5G0UZeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(5660300002)(7696005)(86362001)(4326008)(82310400003)(8936002)(54906003)(70586007)(186003)(82740400003)(70206006)(26005)(2616005)(2906002)(44832011)(8676002)(316002)(336012)(426003)(83380400001)(1076003)(6916009)(47076004)(81166007)(478600001)(36756003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 21:46:06.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4746e4cb-0224-4839-e7c6-08d89254adaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0242
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e213246e3f04..6203cbf3ee33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1984,6 +1984,34 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
+static void dm_set_dpms_off(struct dc_link *link)
+{
+	struct dc_stream_state *stream_state;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+	struct {
+		struct dc_surface_update surface_updates[MAX_SURFACES];
+		struct dc_stream_update stream_update;
+	} bundle = {0};
+	bool dpms_off = true;
+
+	bundle.stream_update.dpms_off = &dpms_off;
+
+	mutex_lock(&adev->dm.dc_lock);
+	stream_state = dc_stream_find_from_link(link);
+	mutex_unlock(&adev->dm.dc_lock);
+
+	if (stream_state == NULL) {
+		dm_error("Error finding stream state associated with link!\n");
+		return;
+	}
+
+	bundle.stream_update.stream = stream_state;
+	dc_commit_updates_for_stream(stream_state->ctx->dc, bundle.surface_updates, 0,
+				     stream_state, &bundle.stream_update,
+				     stream_state->ctx->dc->current_state);
+}
+
 static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -2434,8 +2462,11 @@ static void handle_hpd_irq(void *param)
 			drm_kms_helper_hotplug_event(dev);
 
 	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
-		amdgpu_dm_update_connector_after_detect(aconnector);
+		if (new_connection_type == dc_connection_none &&
+		    aconnector->dc_link->type == dc_connection_none)
+			dm_set_dpms_off(aconnector->dc_link);
 
+		amdgpu_dm_update_connector_after_detect(aconnector);
 
 		drm_modeset_lock_all(dev);
 		dm_restore_drm_connector_state(dev, connector);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 903353389edb..7a2b2802faa2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2798,6 +2798,23 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i)
 	return NULL;
 }
 
+struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link)
+{
+	uint8_t i;
+	struct dc_context *ctx = link->ctx;
+
+	for (i = 0; i< MAX_PIPES; i++) {
+		if (ctx->dc->current_state->streams[i] == NULL)
+			continue;
+
+		if (ctx->dc->current_state->streams[i]->link == link) {
+			return ctx->dc->current_state->streams[i];
+		}
+	}
+
+	return NULL;
+}
+
 enum dc_irq_source dc_interrupt_to_irq_source(
 		struct dc *dc,
 		uint32_t src_id,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index bf090afc2f70..b7910976b81a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -292,6 +292,7 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream);
 
 uint8_t dc_get_current_stream_count(struct dc *dc);
 struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
+struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link);
 
 /*
  * Return the current frame counter.
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
