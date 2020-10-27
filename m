Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DED1C63798
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357FE21D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NtKkohxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357FE21D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1856EC65;
	Tue, 27 Oct 2020 20:53:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D636EC5D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDxQWNdN1xTbarFsBXYOpmB4Sd4rDPWPoPHZP4o9L7aI8RovLlVOPkthMR37P95BO/BlP29wuJjLUa7NG5UpfumKi1kD2zRiVN0ihsjFZEsUTzZO9uRrKkB+/XrJppYNce6bC8P6nuq33GOBNgZuY8WDwpu1PKBtFEscHALZ5x4ZMa4CZT00XeebKozKwRun4MNHssB1962YG5DLeZ4SfIiBCIQ5awrAt/5eAdk/fXZ++bPYMJIdstfCWJ1N4m94jMPcW89vd+TMSA1Cw+6Iu8BIFPEfOEGUF1whVkYprhppNjPhaD3ypjYgCzW7GWYmN5BMzYKIf1JTZL4p/TCtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TTO3DLo+7uzeOzC/uzrDibVZ2BKNWlvp5dHViGCGxc=;
 b=UCRWL48zjdrrb207ePzC87HZBviNCjcQKWh15e52Hf8RVq9SeQoLo8kbm1XBijwZZPe8EohbxT2lpT62ExOtDmb5B4cGmh0g+E5FiLt2FRvd+ip1eWGMcCpQ7CN1uvMNUtSvTszzEstKt1TFT5iQ0mfam0xkY2Ji/TTK/gUILqJA5xswxAf9gPqIanUk/U6mRwqcbUyaYH5xrU3FRrHke0c4IzZXkZUQcOVbGSKq8EEg45K7oJhFkJxesKS2jPE2ZVVLFXe7fWabzSSCB67nFtzVbIzXEoWqP++v57OEHaLVnZsMBW6FMew54p1CMSgP37xWrWECUsg2YimbioqJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TTO3DLo+7uzeOzC/uzrDibVZ2BKNWlvp5dHViGCGxc=;
 b=NtKkohxzuEAXF8tzXRbiv6dSyHFTJ6M4v0b8uWSDFzi/lE8Xv0y/LtNZDXohb23+fg3COvcIpc0DD7lyahcwcZMj+SSX2Gb8xihs7Mkn0d1kzEH2ZvZRVtnYQZWatOxPffR/cqDMyA8lcIYnIx78lvBGN+ddVLYzBkY6kTAwU6E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:01 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:01 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/25] drm/amd/display: Update connector on DSC property change
Date: Tue, 27 Oct 2020 16:52:23 -0400
Message-Id: <20201027205234.8239-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75c120db-da7b-4241-c6e3-08d87aba4699
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595D21DE879018720ACAC65FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyjOQA9k6RiRwk6GAwtK+duJGfMh/E5BfZLKA3pmFxOvEqJ8cEvRvVIIk4zfJ2N6O5oW7Ghm6XZna1bFDjUamhS0kdleLUMY4bvYNXTIa5c1VixHMjPHkXAjHrWUyMg6uvUNPTEcrxfcRzxCXLm2TF2+KAztXOPHiGXpPwLLjmphkUoHjTN1LGHL4SVF447NzYwwvA5yL045TyYNE1COEUqNI6Lhqlto1VGonK7YXCiyq+PBe/I7++I1PpKAow9fDcPJRzWS67kiVezeN+PgEp9XvbDh2TIgfwdl3GZmX57pc9QlWBvc2aWNbTynwhzLBuSOPSOS4jqXQsXmS9LJnDlXsQC+hAau0QHqlwjl3zZQCob6I2ioqNnPWtbIDwrM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(15650500001)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IibPPE1uDPwrID3WOzjAhBGr62Ng2xs5aeKgoWZaJP70v7YYxTQrHSBSkTTa6tzGZnbtIDZjXdVd6iaSBTFcebiHrCJuqicBJonJy2B3EYaMSddWCnkbtdvfqM9bs3ZkmO0v4ivb+91zvPb54HEl5jb2IhSmAg1r0Bh3/dBskzXL8iRi9btsC7IBY/TXEJHan7emmeMOAx3Gy879obg+jSXwtvNA/BGLFGthiu5h+LoJmKvueA+UDh6ns558WQeJ/KOfoJ/e0mSk77GdIj3UFAoIWOiisbs77h/cGSrM3gYAhAr+dstbqnAOChO0PAi9wfec6cXkqm/rVB+gpms1/pcp8Qv3vW9nJbATQlXSJffttylS3pzHDujSpaB8tnyIaFBjX+ihluO4cOdyH0foSo0fdM3lLbrBWGOkwRfRRjvjbxOKDhvMDtlhgDBsbgDOsSmmyBzS18FtZvI97oQbBIN5CIeFGVoNrTxRDgcBlmpBny9ngJxhhu8c8VnhBkfVNqLOKY7vZ4Yl5uEVwXyewmFAtq0zgVXRfhpABgxsh7XMTpLCSkBTAw8s/f0EAwKfHtAcOrp6T3vqujVedQ8N4Z1taXt9X2ep3lybY+jX2A4Y0SU5zaWbD9NJ2yjLAWXxBG1Sgv4g/uuQ0iq0qUDgow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c120db-da7b-4241-c6e3-08d87aba4699
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:54.1723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEbOEXD2FtglcwP+5F2o654HDzRelROuG73qa3VsKYFjeVSrgBR1R+3y/fCjYO9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[Why]
We want to trigger atomic check on connector when
DSC debugfs properties are changed. The previous
method was reverted because it accessed connector
properties unsafely and would also heavily
impact performance.

[How]
Add a flag for forcing DSC update in CRTC state
and add connector to the state if the flag is set.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 124 ++++++++++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fdb1fa72061a..345eb2130869 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8773,6 +8773,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	enum dc_status status;
 	int ret, i;
 	bool lock_and_validation_needed = false;
+	struct dm_crtc_state *dm_old_crtc_state;
 
 	trace_amdgpu_dm_atomic_check_begin(state);
 
@@ -8815,9 +8816,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 #endif
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state) &&
 		    !new_crtc_state->color_mgmt_changed &&
-		    old_crtc_state->vrr_enabled == new_crtc_state->vrr_enabled)
+		    old_crtc_state->vrr_enabled == new_crtc_state->vrr_enabled &&
+			dm_old_crtc_state->dsc_force_changed == false)
 			continue;
 
 		if (!new_crtc_state->enable)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6057eb6bc362..9bf141aa660c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -440,6 +440,7 @@ struct dm_crtc_state {
 	bool freesync_timing_changed;
 	bool freesync_vrr_info_changed;
 
+	bool dsc_force_changed;
 	bool vrr_supported;
 	struct mod_freesync_config freesync_config;
 	struct dc_info_packet vrr_infopacket;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8cd646eef096..5c72ebd5998f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1253,6 +1253,10 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 				     size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct drm_crtc *crtc = NULL;
+	struct dm_crtc_state *dm_crtc_state = NULL;
 	struct pipe_ctx *pipe_ctx;
 	int i;
 	char *wr_buf = NULL;
@@ -1295,6 +1299,25 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
+	// Get CRTC state
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (connector->state == NULL)
+		goto unlock;
+
+	crtc = connector->state->crtc;
+	if (crtc == NULL)
+		goto unlock;
+
+	drm_modeset_lock(&crtc->mutex, NULL);
+	if (crtc->state == NULL)
+		goto unlock;
+
+	dm_crtc_state = to_dm_crtc_state(crtc->state);
+	if (dm_crtc_state->stream == NULL)
+		goto unlock;
+
 	if (param[0] == 1)
 		aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_ENABLE;
 	else if (param[0] == 2)
@@ -1302,6 +1325,14 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	else
 		aconnector->dsc_settings.dsc_force_enable = DSC_CLK_FORCE_DEFAULT;
 
+	dm_crtc_state->dsc_force_changed = true;
+
+unlock:
+	if (crtc)
+		drm_modeset_unlock(&crtc->mutex);
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+
 done:
 	kfree(wr_buf);
 	return size;
@@ -1408,6 +1439,10 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct pipe_ctx *pipe_ctx;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct drm_crtc *crtc = NULL;
+	struct dm_crtc_state *dm_crtc_state = NULL;
 	int i;
 	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
@@ -1449,6 +1484,25 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
+	// Safely get CRTC state
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (connector->state == NULL)
+		goto unlock;
+
+	crtc = connector->state->crtc;
+	if (crtc == NULL)
+		goto unlock;
+
+	drm_modeset_lock(&crtc->mutex, NULL);
+	if (crtc->state == NULL)
+		goto unlock;
+
+	dm_crtc_state = to_dm_crtc_state(crtc->state);
+	if (dm_crtc_state->stream == NULL)
+		goto unlock;
+
 	if (param[0] > 0)
 		aconnector->dsc_settings.dsc_num_slices_h = DIV_ROUND_UP(
 					pipe_ctx->stream->timing.h_addressable,
@@ -1456,6 +1510,14 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	else
 		aconnector->dsc_settings.dsc_num_slices_h = 0;
 
+	dm_crtc_state->dsc_force_changed = true;
+
+unlock:
+	if (crtc)
+		drm_modeset_unlock(&crtc->mutex);
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+
 done:
 	kfree(wr_buf);
 	return size;
@@ -1561,6 +1623,10 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 				     size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct drm_crtc *crtc = NULL;
+	struct dm_crtc_state *dm_crtc_state = NULL;
 	struct pipe_ctx *pipe_ctx;
 	int i;
 	char *wr_buf = NULL;
@@ -1603,6 +1669,25 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
+	// Get CRTC state
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (connector->state == NULL)
+		goto unlock;
+
+	crtc = connector->state->crtc;
+	if (crtc == NULL)
+		goto unlock;
+
+	drm_modeset_lock(&crtc->mutex, NULL);
+	if (crtc->state == NULL)
+		goto unlock;
+
+	dm_crtc_state = to_dm_crtc_state(crtc->state);
+	if (dm_crtc_state->stream == NULL)
+		goto unlock;
+
 	if (param[0] > 0)
 		aconnector->dsc_settings.dsc_num_slices_v = DIV_ROUND_UP(
 					pipe_ctx->stream->timing.v_addressable,
@@ -1610,6 +1695,14 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	else
 		aconnector->dsc_settings.dsc_num_slices_v = 0;
 
+	dm_crtc_state->dsc_force_changed = true;
+
+unlock:
+	if (crtc)
+		drm_modeset_unlock(&crtc->mutex);
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+
 done:
 	kfree(wr_buf);
 	return size;
@@ -1708,6 +1801,10 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 				     size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct drm_crtc *crtc = NULL;
+	struct dm_crtc_state *dm_crtc_state = NULL;
 	struct pipe_ctx *pipe_ctx;
 	int i;
 	char *wr_buf = NULL;
@@ -1750,8 +1847,35 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	if (!pipe_ctx || !pipe_ctx->stream)
 		goto done;
 
+	// Get CRTC state
+	mutex_lock(&dev->mode_config.mutex);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (connector->state == NULL)
+		goto unlock;
+
+	crtc = connector->state->crtc;
+	if (crtc == NULL)
+		goto unlock;
+
+	drm_modeset_lock(&crtc->mutex, NULL);
+	if (crtc->state == NULL)
+		goto unlock;
+
+	dm_crtc_state = to_dm_crtc_state(crtc->state);
+	if (dm_crtc_state->stream == NULL)
+		goto unlock;
+
 	aconnector->dsc_settings.dsc_bits_per_pixel = param[0];
 
+	dm_crtc_state->dsc_force_changed = true;
+
+unlock:
+	if (crtc)
+		drm_modeset_unlock(&crtc->mutex);
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	mutex_unlock(&dev->mode_config.mutex);
+
 done:
 	kfree(wr_buf);
 	return size;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
