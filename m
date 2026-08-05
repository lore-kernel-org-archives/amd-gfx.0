Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF691C55838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D2E10F0E7;
	Thu,  6 Aug 2026 06:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBk+lrER";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E004410EE06
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 11:53:33 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381b831d535so1025037a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930813; x=1786535613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=79NsO+PsfGOopFsKIDPTTb7BwTAhpxYJChhNrjYNklA=;
 b=aBk+lrERlltj7ZMLTO8mw083JbtbY50RwSWmaaI0NMECKwMn6MIlmigea7nFhaCbQe
 HK06qon6/1/Ca//PzRnEjykaQiChrx+bbzIxczaoEr0jJFiF39cCyHQUKLpTMzv2HA03
 4FSlOkhstoxXVsYPlIja0EpKo3+knr+tbkbXNJtffEyW6S+q7VNJekTyED6CeAcs6ifk
 AiRRH9mGEvL8BGEQQ4mF+Y8bX3t5Nax6Oyy5spwgjp3OE6qQhQI9PBCsJSosT/yJKc74
 917LazQv/E/eqOXfq0NVHvNEgITFqOEaAWMpLj2eKqfNY0iKbaXS9zt8QRiK88b1CNnn
 oghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930813; x=1786535613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=79NsO+PsfGOopFsKIDPTTb7BwTAhpxYJChhNrjYNklA=;
 b=l5vfLEiTgg9S2eaS2nZf4JL5VtwDPuamISTHRas6pulIsulJwDgo22vVUdpGnG4cZv
 033qruMWmui2x0ivnEIPPYVJNs5Uztv4z9tN0r638bRkkGTffJnGzpjcM/ZlFH+xeJy8
 B2C7cRoh+m3iMgZchOAK3dFQyjW/H8KzNs4lKTaT6FGrUYh0oyNnbYPA/78FIc0GttaN
 7Qi+fXxvw+eRFdmP4p3MOPXseeqak/4hfSVa5Yi+No38eJ3VtyNgVOAdRqyqU3l1jf7O
 ijTrxO0NBbo+ehDdXQfu69udLNyqpktMwW7W1VS8+PfkVB3F7BqbZ24Segqoxk2czGwF
 4zYA==
X-Gm-Message-State: AOJu0YycBE7ShUVwV+5GIAT5d19m17L7YYfgaLwWGvF3eFOsb+WJjoaI
 LqkrkwjSRGBjNoymjIvKIUWmG19mr7iBKqbUC22Fc0bcrlKF8kDmX8o+fJy6hYHo/yA=
X-Gm-Gg: AR+sD10r9swFcFs85wlsXWJuamVw97rFCWGLL6OPHm+wq7ZtEp9NfBz6qDihEfDsQLZ
 KJTroVm0O6yD3l/rXIfnI/5Q44X1wVvR8djJwz8fwkdDoLBsxTvwjCoqhNztvRaP9OF1erlWomq
 f5me6W570M1UQU3hJa+SvSzGdNvIkJIL/lirWISuubQUwbt/FvQLfVxmzLam63rsKUAI5wD5Lh4
 oNatLTrAIxmOotZoRpIs3BlaibotZ1qBlkzQOq0oWS0enVM3zKIJWFxLA4RpKy86bl0PLcued5I
 0GRGt1fKpP2vQYfSZIB8X6+PXxgxb/e/gBWrCjLReUO86f5dsvP7PWtxPDl+eiCPU8QyYy4fAdR
 VJvseRAgf5uiGt+hQPRCimeA+PjfdwA5uk+BW+SUPPACDUkyLTLyYZPhG8MaG6tyGCY4Vfvqro/
 ljOkvOxGeV8Gt/J6IPgtvx1gQ+PJJGSDfjAxADrie1sEKQ3odWQ2Dj9nJALrrBkFH7MkYmZG2fg
 ChJcZJvD+Tho+DjDP2se567
X-Received: by 2002:a17:90a:ec86:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-3903c537a12mr6778142a91.7.1785930813335; 
 Wed, 05 Aug 2026 04:53:33 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae56sm4667245a91.2.2026.08.05.04.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:53:32 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 someguy@effective-light.com, David Weber <weber.aulendorf@gmail.com>
Subject: [RFC PATCH 5/5] drm/amd/display: add PSR recovery fault injection
Date: Wed,  5 Aug 2026 13:52:48 +0200
Message-ID: <f1da6bf58b5464f1b6e5b550f7e4627aed39ae64.1785929873.git.weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785929873.git.weber.aulendorf@gmail.com>
References: <cover.1785929873.git.weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:55:47 +0000
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

Introduce two write-only debugfs controls for testing PSR recovery.

amdgpu_dm_trigger_psr_recovery directly queues the PSR recovery worker
without first creating a display or firmware failure.  Trigger it with:

  echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_trigger_psr_recovery

amdgpu_dm_halt_dmub_for_psr_recovery selects an active PSR-enabled eDP
stream, enters PSR, halts DMUB firmware, and requests a synchronous PSR
exit.  The failed exit should schedule the normal PSR recovery path.
Trigger it with:

  echo 0xDEADDEAD > \
    /sys/kernel/debug/dri/0/amdgpu_dm_halt_dmub_for_psr_recovery

Halting DMUB is destructive until reset.  The second control therefore
requires the existing STOP_FW response value 0xDEADDEAD as a safety
cookie.  Both controls refuse to run when GPU recovery is disabled, no
reset domain is available, teardown has started, or another PSR recovery
is pending.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7db38ad3f848..a80e13b98ad7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -29,6 +29,7 @@
 #include <media/cec-notifier.h>
 
 #include "dc.h"
+#include "core_types.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_debugfs.h"
@@ -4483,6 +4484,176 @@ DEFINE_DEBUGFS_ATTRIBUTE(skip_detection_link_training_fops,
 			 skip_detection_link_training_get,
 			 skip_detection_link_training_set, "%llu\n");
 
+static int psr_recovery_test_available(struct amdgpu_device *adev)
+{
+	unsigned long flags;
+	bool pending;
+	bool stopping;
+
+	if (!amdgpu_device_should_recover_gpu(adev) || !adev->reset_domain)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&adev->dm.psr_recovery_lock, flags);
+	pending = adev->dm.psr_recovery_pending;
+	stopping = adev->dm.psr_recovery_stopping;
+	spin_unlock_irqrestore(&adev->dm.psr_recovery_lock, flags);
+
+	if (stopping)
+		return -ESHUTDOWN;
+
+	return pending ? -EBUSY : 0;
+}
+
+static int trigger_psr_recovery_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+	int ret;
+
+	if (val != 1)
+		return -EINVAL;
+	if (!adev->dm.dc || !adev->dm.dc->ctx)
+		return -ENODEV;
+	ret = psr_recovery_test_available(adev);
+	if (ret)
+		return ret;
+
+	drm_warn(adev_to_drm(adev),
+		 "injecting a fatal PSR failure to test display recovery\n");
+	if (!amdgpu_dm_schedule_psr_recovery(&adev->dm, NULL, NULL))
+		return -EIO;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(trigger_psr_recovery_fops, NULL,
+			 trigger_psr_recovery_set, "%llu\n");
+
+static int halt_dmub_for_psr_recovery_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+	struct dc *dc = adev->dm.dc;
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct dmub_srv *dmub;
+	struct dc_link *link = NULL;
+	enum dmub_status status;
+	u32 response = 0;
+	bool allow_active;
+	bool pending;
+	bool programmed;
+	unsigned long flags;
+	int ret = 0;
+	int i;
+
+	/*
+	 * Halting DMUB is destructive until reset. Require the STOP_FW ABI
+	 * response cookie to make an accidental write less likely.
+	 */
+	if (val != DMUB_GPINT__STOP_FW_RESPONSE)
+		return -EINVAL;
+	ret = psr_recovery_test_available(adev);
+	if (ret)
+		return ret;
+	if (!dc || !dc->ctx || !dc->ctx->dmub_srv ||
+	    !dc->res_pool || !dc->res_pool->psr)
+		return -ENODEV;
+
+	dc_dmub_srv = dc->ctx->dmub_srv;
+	dmub = dc_dmub_srv->dmub;
+	if (!dmub)
+		return -ENODEV;
+
+	mutex_lock(&adev->dm.dc_lock);
+	if (dc->current_state) {
+		for (i = 0; i < dc->current_state->stream_count; i++) {
+			struct dc_stream_state *stream =
+				dc->current_state->streams[i];
+
+			if (stream && stream->link &&
+			    stream->link->connector_signal == SIGNAL_TYPE_EDP &&
+			    stream->link->psr_settings.psr_feature_enabled) {
+				link = stream->link;
+				break;
+			}
+		}
+	}
+
+	if (!link) {
+		mutex_unlock(&adev->dm.dc_lock);
+		return -ENODEV;
+	}
+	ret = psr_recovery_test_available(adev);
+	if (ret)
+		goto unlock;
+
+	if (dc_dmub_srv->idle_allowed)
+		dc_dmub_srv_apply_idle_power_optimizations(dc, false);
+
+	/* Enter PSR before halting firmware so the test exercises failed exit. */
+	link->psr_settings.psr_allow_active_valid = false;
+	allow_active = true;
+	programmed = dc_link_set_psr_allow_active(link, &allow_active, true,
+						  false, NULL);
+	if (!programmed) {
+		drm_err(adev_to_drm(adev),
+			"failed to enter PSR before halting DMUB\n");
+		ret = -EIO;
+		goto unlock;
+	}
+
+	drm_warn(adev_to_drm(adev),
+		 "halting DMUB firmware to test PSR exit recovery\n");
+	status = dmub_srv_send_gpint_command(dmub, DMUB_GPINT__STOP_FW, 0,
+					     100000);
+	if (status != DMUB_STATUS_OK) {
+		drm_err(adev_to_drm(adev),
+			"failed to halt DMUB firmware: %d; recovering\n", status);
+		if (!amdgpu_dm_schedule_psr_recovery(&adev->dm, NULL, NULL))
+			drm_err(adev_to_drm(adev),
+				"failed to schedule recovery after DMUB halt error\n");
+		ret = -EIO;
+		goto unlock;
+	}
+
+	for (i = 0; i < 100000; i++) {
+		status = dmub_srv_get_gpint_response(dmub, &response);
+		if (status == DMUB_STATUS_OK &&
+		    response == DMUB_GPINT__STOP_FW_RESPONSE)
+			break;
+		udelay(1);
+	}
+
+	if (response != DMUB_GPINT__STOP_FW_RESPONSE)
+		drm_warn(adev_to_drm(adev),
+			 "DMUB halt response timed out; testing PSR exit anyway\n");
+
+	allow_active = false;
+	programmed = dc_link_set_psr_allow_active(link, &allow_active, true,
+						  false, NULL);
+	spin_lock_irqsave(&adev->dm.psr_recovery_lock, flags);
+	pending = adev->dm.psr_recovery_pending;
+	spin_unlock_irqrestore(&adev->dm.psr_recovery_lock, flags);
+	if (programmed) {
+		drm_err(adev_to_drm(adev),
+			"PSR exit unexpectedly succeeded after DMUB halt\n");
+		ret = -EIO;
+	} else if (!pending) {
+		drm_err(adev_to_drm(adev),
+			"PSR exit timeout did not schedule recovery\n");
+		ret = -EIO;
+	} else {
+		drm_info(adev_to_drm(adev),
+			 "PSR exit timeout scheduled recovery\n");
+	}
+
+unlock:
+	mutex_unlock(&adev->dm.dc_lock);
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(halt_dmub_for_psr_recovery_fops, NULL,
+			 halt_dmub_for_psr_recovery_set, "%llu\n");
+
 /*
  * Dumps the DCC_EN bit for each pipe.
  * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dcc_en
@@ -4579,6 +4750,12 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_skip_detection_link_training", 0644, root, adev,
 				   &skip_detection_link_training_fops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_trigger_psr_recovery", 0200,
+				   root, adev, &trigger_psr_recovery_fops);
+	debugfs_create_file_unsafe("amdgpu_dm_halt_dmub_for_psr_recovery", 0200,
+				   root, adev,
+				   &halt_dmub_for_psr_recovery_fops);
+
 	debugfs_create_file_unsafe("amdgpu_dm_dmub_tracebuffer", 0644, root,
 				   adev, &dmub_tracebuffer_fops);
 
-- 
2.54.0

