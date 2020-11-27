Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A5C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 00:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C35020853
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 00:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v+pSVr5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C35020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5636EB11;
	Fri, 27 Nov 2020 00:18:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF296EB11
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 00:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsrLdEWgpjKfMuocyIN/bT57znWsAkT/HOKvY8TL9OW8KyBKFHQ6+JAoNZDn157ccwI1Ri1HPwrxNCvVQrfYyKxSXJxFx25/qQkq+F+ShPy5og8ID+7LiV41a2bOYupVy/WpV6uAojvmW0H1J/sm5z85f6VstrY2Eh8IBNUkFSrgmRobcBMN7suRe3Cn2W4pUFrICjDFkiqBV0AJ8uoltXr5tyvZndUk2ZKmvjc6E/7zSGn+B9UGFuzpUIxLnYf3jLvTErDJd/CTDl8oVpTWrrkn2DtWlj6PVqK59o5czSbBsk5FEcQ9tFqfK3s6xH6ZTYMIHHVYLtvCey4oaP5RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOKJeTyVXoPTw8/lbBZ3PgRY3enkuuf0ziCWcEB9XfA=;
 b=ew2UVVdm9mRYTGIIiElve/rp0QEHqUoWvWgMM7KXBad155mpHMc9eCnlFMss+MEqGX3wMIOn/g/5eAkUj6JKsBLpqkCXCWuG0wmN2K03F+lxxvCLw/OOFbIycHVGXURpvo6iq5wxmCv8ndlf0kQ6X0p/Xy7MlHQTQxHdZlGk+5zdHBO/m+oNv5C8j47LmVEVsqul/cdhY2TD5G7AHPYdOO4T7m66Va3fhpbkPrCoupmoKXvEeW/wtiIkmj2iJIX4moTGb2Og6sle17T6FiSCFzZDXr7wJj5Eejd41Qk3ssNMgZWz47Yyu23DZa8W10SMC+5wunnL7mLdj4wgqplhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOKJeTyVXoPTw8/lbBZ3PgRY3enkuuf0ziCWcEB9XfA=;
 b=v+pSVr5P0CSfhbt9c3NMwJo4Qb04ShiSemnDg72SGNBCnsWfcA4KaTDPbucrVPXmoH5n092ZP1fFPJFn0eV04oNA6YKAtWrz02p3GzR2Kv9zDhBSh6my3XJ0WavqIUxIQQloFpCagGcDkAqH8ZFdkRDiLo2nWUz1/IIzU/0yTqU=
Received: from BN3PR03CA0103.namprd03.prod.outlook.com (2603:10b6:400:4::21)
 by BN8PR12MB4771.namprd12.prod.outlook.com (2603:10b6:408:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 27 Nov
 2020 00:18:51 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::e5) by BN3PR03CA0103.outlook.office365.com
 (2603:10b6:400:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 00:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 00:18:51 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 26 Nov
 2020 18:18:50 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 18:18:45 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/display: turn DPMS off on mst connector unplug
Date: Thu, 26 Nov 2020 19:18:44 -0500
Message-ID: <20201127001844.367041-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89233acc-b10d-411e-db48-08d8926a0495
X-MS-TrafficTypeDiagnostic: BN8PR12MB4771:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4771CD10D31FB7ECC0554EA28BF80@BN8PR12MB4771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lucxGoFPOyMFcYc8v/jR2dOsetg3ff5t8Dac84bik/TAMgODyNCSqSnZSFsl4hiIwSgtKGx71DVGZhKsAbWeZbBZbCT3DCAhEUsxv2DOcOesk3bRJ0kSbLoFOtzkDl313Ge/sGr7BJedh4uhlDxOc7RmQHzbW5TYRNQlX0prK56lYSs+rk17jr4S9oNtNr8pDTL93/iGoNSxS/p4x4rEmVQy8EkqWXTjXP8Jt9IVWL0VJdLk5EMpiHtv96pHfadmReIFTrbA97XGe+XkUOuufCBq2cETw46F3aMmJxLRBSjuCGv8EqPyAwNxtkou6/bZUyvD/Ql7rv+x25v+Jrt15P1tFelqfwQ2r5sS3xV/rfSR8AmLQpFNKrzdL/WrJNZQ9mqww9pyHSMoeb7ZRYTSvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(54906003)(336012)(82310400003)(4326008)(6916009)(5660300002)(8676002)(2906002)(426003)(26005)(1076003)(8936002)(83380400001)(81166007)(47076004)(186003)(2616005)(44832011)(356005)(7696005)(478600001)(82740400003)(70586007)(36756003)(316002)(86362001)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 00:18:51.3603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89233acc-b10d-411e-db48-08d8926a0495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4771
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e213246e3f04..9966679d29e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1984,6 +1984,32 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	return;
 }
 
+static void dm_set_dpms_off(struct dc_link *link)
+{
+	struct dc_stream_state *stream_state;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+	struct dc_stream_update stream_update = {0};
+	bool dpms_off = true;
+
+	stream_update.dpms_off = &dpms_off;
+
+	mutex_lock(&adev->dm.dc_lock);
+	stream_state = dc_stream_find_from_link(link);
+
+	if (stream_state == NULL) {
+		dm_error("Error finding stream state associated with link!\n");
+		mutex_unlock(&adev->dm.dc_lock);
+		return;
+	}
+
+	stream_update.stream = stream_state;
+	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
+				     stream_state, &stream_update,
+				     stream_state->ctx->dc->current_state);
+	mutex_unlock(&adev->dm.dc_lock);
+}
+
 static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -2434,8 +2460,11 @@ static void handle_hpd_irq(void *param)
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
index 903353389edb..58eb0d69873a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2798,6 +2798,19 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i)
 	return NULL;
 }
 
+struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link)
+{
+	uint8_t i;
+	struct dc_context *ctx = link->ctx;
+
+	for (i = 0; i < ctx->dc->current_state->stream_count; i++) {
+		if (ctx->dc->current_state->streams[i]->link == link)
+			return ctx->dc->current_state->streams[i];
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
