Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 15:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF56206F1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 15:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m1iyIOhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF56206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CA76E866;
	Wed, 20 May 2020 15:29:56 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D7B6E866
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 15:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7SfAuqBSKjbgZD5TOJr7kPBhN9HdYFqpMrpTkJe5eBIOG4a8RWk4ZDAsvrMcLiLzY1Ff87ovNafVAkQ1qMNVxhnpQdS1Tka9QR5SBvt9KMspfGBp1W/HvHHbsdftxOmTdOaRM/4NPQQyvAlasqcW/FyFl7mBSvMW4SoETsY1LG8DfvfAL/2AJZg78WWxEC31JmHV50Gxt1bcuA7ahqMkHAnMZUpHcBu5S2pZ964ld8TFiXUQ73fFWnDXD+k8Yoy/U0/izCAhQNObLHoo9ixkTwb7geT18+5y57eVfmajdcy6OElXnztsvuCm0rPIh5Iiw+RUU8O+NavijH7RPtmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+quY30Ulheh6+ywdvcoyvsatcxGdQB5KCE15yyfneE=;
 b=G/6cKVQpae+EUrOjTmb+ncUDJc31EKpWUEjtKHCefdcI3gGM4Hp1pm+E3NEVNxra7iKQ7MlHq5hdiqP3IskRovhfq6XjaDN9n792rFLk/wBNcUEPWDPGrgHhIPtMm3L/Kz6THFpZUMIHTEBCaVHS/qLqPVlVADc6lkwa6lFFU7fKcOcuZlTIlX66xV/Jhoz+bely/Kw43G6LW0wFr+C2hLRlIIBVrCdk3KfHbnHnBFu+Opqr5g8QcxBCEp06j6yvVlnpiLe0TZXCqgix9fk2Ukc5GQKBAJaSft9SqLkW46Q7SFaegInCP67u+oRTYrr6p4v0DP2cr5h26uz5n9iiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+quY30Ulheh6+ywdvcoyvsatcxGdQB5KCE15yyfneE=;
 b=m1iyIOhEISY3lzTyltU1ZAqUkiK95Y0pzJp562MRk/qf2mnSNdiBHBU5SSFvqHxNxQMCWtEuFPo0qlmh9EBtxaCy/DTaWliiH2MX/yvpcpERPRkt+DiWPVad6l+tRrvm8vInjtUjEN++LpuiYa/Ac7C6/KlPfsyM1JQyGfbk5Rc=
Received: from BN6PR10CA0021.namprd10.prod.outlook.com (2603:10b6:405:1::31)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 15:29:53 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:1:cafe::43) by BN6PR10CA0021.outlook.office365.com
 (2603:10b6:405:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Wed, 20 May 2020 15:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 15:29:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 May
 2020 10:29:52 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 May
 2020 10:29:52 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 20 May 2020 10:29:52 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Handle GPU reset for DC block
Date: Wed, 20 May 2020 11:29:49 -0400
Message-ID: <20200520152949.15795-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966005)(8936002)(6666004)(82740400003)(478600001)(1076003)(8676002)(356005)(36756003)(82310400002)(81166007)(426003)(70586007)(70206006)(4326008)(47076004)(2616005)(6636002)(336012)(5660300002)(7696005)(2906002)(26005)(316002)(186003)(110136005)(86362001)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc8ab7ae-d7cc-430d-6a26-08d7fcd2a496
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41633C58DB38DEE8548C722CF9B60@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxzTN9Ns26VptltQDwOU5GkYoA8maSNcA41bBrI4I7nOrFsImdvhWStn1Sb6EJJUtJgMiJ5GuwsfTZlsJlGCkzi0jHntJEDEikBKJoiivPyCJfNR3ehk6f51Atktt5lAHCrUQnPhQOpg2+fh8vZmIcCUMZzR8flZ/RSWXgHU4mKROUT/qiXTAp3kbMF/SfYiME5ShhvLxBwm7dIA4H2XOiCpXoV6ltBkpqYW7cnVt3IhDPJo9SQR0EYPSQJthqagg4/bREKWsjBb77g1CaBpCW1urGofeaYrHLW0DPgUUFSBiR1zm4uRrYpLUckXUaBsZYiN7Xwl4xqX1fRQw6JU57bX+h99S0ej2hvaKbBZpB2dQaMUlC1g/UcjwwKzuqvbWy27w/KkcZpryLzrekuph7pH5DyapTgT9YVd7t+Gg50=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:29:53.0417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8ab7ae-d7cc-430d-6a26-08d7fcd2a496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Previously we used the s3 codepath for gpu reset. This can lead to issues in
certain case where we end of waiting for fences which will never come (because
parts of the hw are off due to gpu reset) and we end up waiting forever causing
a deadlock.

[How]
Handle GPU reset separately from normal s3 case. We essentially need to redo
everything we do in s3, but avoid any drm calls.

For GPU reset case

suspend:
	-Acquire DC lock
	-Cache current dc_state
	-Commit 0 stream/planes to dc (this puts dc into a state where it can be
	 powered off)
	-Disable interrupts
resume
	-Edit cached state to force full update
	-Commit cached state from suspend
	-Build stream and plane updates from the cached state
	-Commit stream/plane updates
	-Enable interrupts
	-Release DC lock

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 175 +++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60fe64aef11b..46bb6e156f81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1521,10 +1521,109 @@ static int dm_hw_fini(void *handle)
 	return 0;
 }
 
+
+static int dm_enable_vblank(struct drm_crtc *crtc);
+static void dm_disable_vblank(struct drm_crtc *crtc);
+
+static void dm_gpureset_interrupt(struct amdgpu_device *adev,
+				 struct dc_state *state, bool enable)
+{
+	enum dc_irq_source irq_source;
+	struct amdgpu_crtc *acrtc;
+	int rc = -EBUSY;
+	int i = 0;
+
+	for (i = 0; i < state->stream_count; i++) {
+		acrtc = get_crtc_by_otg_inst(
+				adev, state->stream_status[i].primary_otg_inst);
+
+		if (acrtc && state->stream_status[i].plane_count != 0) {
+			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
+			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+			DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
+				  acrtc->crtc_id, enable ? "en" : "dis", rc);
+			if (rc)
+				DRM_WARN("Failed to %s pflip interrupts\n",
+					 enable ? "enable" : "disable");
+
+			if (enable){
+				rc = dm_enable_vblank(&acrtc->base);
+				if (rc)
+					DRM_WARN("Failed to enable vblank interrupts\n");
+			} else
+				dm_disable_vblank(&acrtc->base);
+
+		}
+	}
+
+}
+
+enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
+{
+	struct dc_state *context = NULL;
+	enum dc_status res = DC_ERROR_UNEXPECTED;
+	int i;
+	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
+	int del_streams_count = 0;
+
+	context = dc_create_state(dc);
+	if (context == NULL)
+		goto context_alloc_fail;
+
+	dc_resource_state_copy_construct_current(dc, context);
+
+	/* First remove from context all streams */
+	for (i = 0; i < context->stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+		del_streams[del_streams_count++] = stream;
+	}
+
+	/* Remove all planes for removed streams and then remove the streams */
+	for (i = 0; i < del_streams_count; i++) {
+		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
+			res = DC_FAIL_DETACH_SURFACES;
+			goto fail;
+		}
+
+		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
+		if (res != DC_OK)
+			goto fail;
+	}
+
+
+	res = dc_validate_global_state(dc, context, false);
+
+	if (res != DC_OK) {
+		DRM_ERROR("%s:resource validation failed, dc_status:%d\n", __func__, res);
+		goto fail;
+	}
+
+	res = dc_commit_state(dc, context);
+
+fail:
+	dc_release_state(context);
+
+context_alloc_fail:
+	return res;
+}
+
 static int dm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = handle;
 	struct amdgpu_display_manager *dm = &adev->dm;
+	int ret = 0;
+
+	if (adev->in_gpu_reset) {
+		mutex_lock(&dm->dc_lock);
+		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
+
+		dm_gpureset_interrupt(adev, dm->cached_dc_state, false);
+		
+		amdgpu_dm_commit_zero_streams(dm->dc);
+
+		amdgpu_dm_irq_suspend(adev);
+		return ret;
+	}
 
 	WARN_ON(adev->dm.cached_state);
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
@@ -1640,6 +1739,46 @@ static void emulated_link_detect(struct dc_link *link)
 
 }
 
+static void dm_gpureset_commit_state(struct dc_state *dc_state,
+				     struct amdgpu_display_manager *dm)
+{
+	struct {
+		struct dc_surface_update surface_updates[MAX_SURFACES];
+		struct dc_plane_info plane_infos[MAX_SURFACES];
+		struct dc_scaling_info scaling_infos[MAX_SURFACES];
+		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
+		struct dc_stream_update stream_update;
+	} * bundle;
+	int k, m;
+
+	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
+
+	if (!bundle) {
+		dm_error("Failed to allocate update bundle\n");
+		goto cleanup;
+	}
+
+	for (k = 0; k < dc_state->stream_count; k++) {
+		bundle->stream_update.stream = dc_state->streams[k];
+
+		for (m = 0; m < dc_state->stream_status->plane_count; m++) {
+			bundle->surface_updates[m].surface =
+				dc_state->stream_status->plane_states[m];
+			bundle->surface_updates[m].surface->force_full_update =
+				true;
+		}
+		dc_commit_updates_for_stream(
+			dm->dc, bundle->surface_updates,
+			dc_state->stream_status->plane_count,
+			dc_state->streams[k], &bundle->stream_update, dc_state);
+	}
+
+cleanup:
+	kfree(bundle);
+
+	return;
+}
+
 static int dm_resume(void *handle)
 {
 	struct amdgpu_device *adev = handle;
@@ -1656,8 +1795,42 @@ static int dm_resume(void *handle)
 	struct dm_plane_state *dm_new_plane_state;
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	int i, r;
+	struct dc_state *dc_state;
+	int i, r, j;
+
+	if (adev->in_gpu_reset) {
+		dc_state = dm->cached_dc_state;
 
+		r = dm_dmub_hw_init(adev);
+		if (r)
+			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+
+		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
+		dc_resume(dm->dc);
+
+		amdgpu_dm_irq_resume_early(adev);
+
+		for (i = 0; i < dc_state->stream_count; i++) {
+			dc_state->streams[i]->mode_changed = true;
+			for (j = 0; j < dc_state->stream_status->plane_count; j++) {
+				dc_state->stream_status->plane_states[j]->update_flags.raw
+					= 0xffffffff;
+			}
+		}
+
+		WARN_ON(!dc_commit_state(dm->dc, dc_state));
+
+		dm_gpureset_commit_state(dm->cached_dc_state, dm);
+
+		dm_gpureset_interrupt(adev, dm->cached_dc_state, true);
+
+		dm->cached_dc_state = NULL;
+		amdgpu_dm_irq_resume_late(adev);
+
+		mutex_unlock(&dm->dc_lock);
+
+		return 0;
+	}
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_release_state(dm_state->context);
 	dm_state->context = dc_create_state(dm->dc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3f0c6298b588..40c912e0bf0c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -315,6 +315,7 @@ struct amdgpu_display_manager {
 #endif
 
 	struct drm_atomic_state *cached_state;
+	struct dc_state *cached_dc_state;
 
 	struct dm_comressor_info compressor;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
