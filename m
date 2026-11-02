Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7059606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=CA29fuWX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92AA410EEE5;
	Mon,  2 Nov 2026 14:15:58 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC5F10ECAC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 10:18:06 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jJ7242pGBzKnQw;
 Mon, 02 Nov 2026 11:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793614684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bumyUW7IJoU4fJDVcWkPL3ZXgIKGGirCaKj7cS/33IQ=;
 b=CA29fuWXfTUBqkXgkHdHK2B72P+4nPpruWcWma2NEO06wzm5W2ra5jrqtohdvJ/OMCnZv3
 fwru/TsduEJ6y3RlCQ9A1nIhfVEDtr/LoosBtz9nB28N97DVGRVk9zU8IgGm8czAYwi52y
 CPWcYpri3C7FFS1/qxR679bjrCgeBsh1UVNoIC6YOjRJUCGhTuyy4QC2oDa/jnBaiFEqFM
 3UXFUMWv360j319ArJSS925fb9rhy75ZBOMDwZc9/BMtwaTZ4XD7+rgdzbAR6qQyyQYfsa
 Q3LCE2Xys+iI0/XTvuWiAp2xKX7uxIzsmqZahHbyOXor3Bk/0ELj1gUeddbu8A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, harry.wentland@amd.com
Subject: [PATCH 4/5] drm/amd/display: Commit panel_power_savings writes from
 the kernel
Date: Mon,  2 Nov 2026 10:17:57 +0000
Message-ID: <20261102-abm-sysfs-commit-v1-4-e5addfd9539a@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
References: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6501; i=hugo@hsal.es;
 h=from:subject:message-id; bh=PuUQdLgULyzFmOsDS7N5X1W/NxZhVldQrFRTvPkWfds=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4kh11af+7B5ph1wiZLI1VU7A817vEuMVFSOsNk8
 nyDabfb38KOUhYGMS4GWTFFFt0bngwsEyfPzCl6vgRmDisTyBAGLk4BmEiVHcN/F/END2elLbrx
 QlKEr/133tpIqd0Bjw95iQS+OhW8KPBMHMN/T8V0v6l7oi88Kji0NPFv+jORWG4Wlouzf6YfSHI
 w9AzgBAA+m0ob
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJ7242pGBzKnQw
X-Mailman-Approved-At: Mon, 02 Nov 2026 14:15:56 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

panel_power_savings_store() currently writes the level into
connector->state and sends a hotplug uevent, and the hardware only gets it
on a later atomic commit that includes the connector. Hyprland adds the
connector to a commit only on a modeset or when a connector property it
sets changes, so it never applies the level

Programs that write the sysfs file, such as power-profiles-daemon, aren't
the DRM master and can't commit themselves, so they depend on the master
taking the uevent as a cue to commit the connector, but nothing documents
they should. A master that wants to control ABM sets the 'adaptive
backlight modulation' property, and from then on writes return -EBUSY. The
file has to work without the master's help, like the backlight device,
whose writes reach DC without a commit

Commit the level from the store instead, with a duplicated connector state
and no modeset. The write returns once the level is applied, or with the
commit's error, so no uevent is needed. A connector that is off gets the
level when it is next enabled

Document the new behaviour in the kernel-doc

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
This needs "drm/amd/display: Don't force a modeset when the ABM level
changes". Without it, atomic check sees the changed level, asks for a
modeset and the commit fails with -EINVAL

A failed write used to leave the level stored and send the uevent anyway.
Now the level only changes through the commit, so the store reports the
error. power-profiles-daemon logs a failed write and tries again on the
next profile, AC or battery change, because it compares against the value
it reads back. It ignores the hotplug uevent. Compositors used it only as
a cue to commit the connector, which the store now does itself

The commit is blocking, so a write can hold the CRTC locks for up to a
frame while a compositor commit waits. The other way round, while the
store's commit is pending, a nonblocking commit from the compositor on the
same CRTC fails with -EBUSY, as it would behind any pending commit

The store takes a runtime PM reference around the commit, like the
atomic ioctl path, and its locks are interruptible
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 90 +++++++++++++++++++---
 1 file changed, 79 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 27546febf90d3..a661fd558686f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -40,7 +40,10 @@
 
 #include <linux/backlight.h>
 #include <linux/minmax.h>
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
 
@@ -691,6 +694,18 @@ EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
  *
  * Modifying this value can have implications on color accuracy, so tread
  * carefully.
+ *
+ * A write commits the new level before it returns, without a modeset. The
+ * commit waits for any commit already pending on the connector's CRTC, and
+ * while it is pending, a nonblocking commit from the DRM master on that CRTC
+ * fails with -EBUSY. If the connector or its CRTC is off, the driver stores
+ * the level and applies it when the connector is next enabled
+ *
+ * If the commit fails, the write returns its error and the level stays as it
+ * was. While the CRTC needs a modeset, as after a DSC override in debugfs,
+ * writes fail with -EINVAL until a commit that allows a modeset clears that
+ * state. Writes fail with -EBUSY once the DRM master has set the connector's
+ * 'adaptive backlight modulation' property to a value other than 'sysfs'
  */
 
 STATIC_IFN_KUNIT
@@ -712,13 +727,75 @@ ssize_t panel_power_savings_show(struct device *device,
 }
 EXPORT_IF_KUNIT(panel_power_savings_show);
 
+static int panel_power_savings_apply(struct drm_connector *connector,
+				     unsigned int level)
+{
+	struct drm_connector_state *conn_state;
+	struct dm_connector_state *dm_state;
+	struct drm_device *dev = connector->dev;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	int ret, idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
+
+	ret = pm_runtime_resume_and_get(dev->dev);
+	if (ret < 0)
+		goto dev_exit;
+
+	state = drm_atomic_commit_alloc(dev);
+	if (!state) {
+		ret = -ENOMEM;
+		goto pm_put;
+	}
+
+	/* Kernel commits allow a modeset by default, which a level never needs */
+	state->allow_modeset = false;
+
+	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
+	state->acquire_ctx = &ctx;
+retry:
+	conn_state = drm_atomic_get_connector_state(state, connector);
+	if (IS_ERR(conn_state)) {
+		ret = PTR_ERR(conn_state);
+		goto out;
+	}
+
+	dm_state = to_dm_connector_state(conn_state);
+	if (dm_state->abm_sysfs_forbidden) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	dm_state->abm_level = level ?: ABM_LEVEL_IMMEDIATE_DISABLE;
+
+	ret = drm_atomic_commit(state);
+out:
+	if (ret == -EDEADLK) {
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+		if (!ret)
+			goto retry;
+	}
+
+	drm_atomic_commit_put(state);
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+pm_put:
+	pm_runtime_put_autosuspend(dev->dev);
+dev_exit:
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
 STATIC_IFN_KUNIT
 ssize_t panel_power_savings_store(struct device *device,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
 	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
 	long val;
 	int ret;
 
@@ -730,19 +807,10 @@ ssize_t panel_power_savings_store(struct device *device,
 	if (val < 0 || val > 4)
 		return -EINVAL;
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
-		ret = -EBUSY;
-	else
-		to_dm_connector_state(connector->state)->abm_level = val ?:
-			ABM_LEVEL_IMMEDIATE_DISABLE;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
+	ret = panel_power_savings_apply(connector, val);
 	if (ret)
 		return ret;
 
-	drm_kms_helper_hotplug_event(dev);
-
 	return count;
 }
 EXPORT_IF_KUNIT(panel_power_savings_store);

-- 
2.56.0

