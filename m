Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DC606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=s0jh/3HA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1178F10EEA7;
	Mon,  2 Nov 2026 14:15:58 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544FF10EC8F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 10:18:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jJ7225CdTzMkrw;
 Mon, 02 Nov 2026 11:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793614682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrT6N3M6R+QLNzlhc/4Q2kGa3Co/mkpc+sZ0fsitGnA=;
 b=s0jh/3HAEsU9i0qL4uRZvZPfpUKB3faykzmdGqMrMllAtish619i6hvEABguFIuOcbNgAr
 uomF23pZpbgYocHVHJB23mAX0VyH2eI+wowuOUZROq9VEQT8iGd+UNZU7GDuNoKJ6o9nXb
 nOsgRYJrE9Ya6veAEAwSDTraAY3c4vZI5W8CB0r8EQhCxfrFrFaW+rDLaeJ5zSPyFRaJiN
 KJ7duF2+k3rcVAsv4UeVgn/9Ik1r4E8XAcm73jqw1UGzionoyR67mBUTFRvP1uYIqTXXrj
 UF3vo+DzHYGsY7ND0vCux7cfV7/hZ1DB2zZiehXzNZZeY8Xomq3vjcYZwkzuhA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, harry.wentland@amd.com
Subject: [PATCH 2/5] drm/amd/display: Don't force a modeset when the ABM level
 changes
Date: Mon,  2 Nov 2026 10:17:55 +0000
Message-ID: <20261102-abm-sysfs-commit-v1-2-e5addfd9539a@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
References: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=hugo@hsal.es;
 h=from:subject:message-id; bh=Wwinkxn78FM9OoICfBjaIhV+CO/pTwUFVip3G7C8i1s=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4khx34uzr56oS3raxe/GW1Ko6aGzfIHOlQs+9VM
 88tdzPaKtRRysIgxsUgK6bIonvDk4Fl4uSZOUXPl8DMYWUCGcLAxSkAE5nFxshw9dMzx5VKSxi8
 vs6qqI5O2uRT5h7y5HaVfPn7yeoXrR2sGP4ZBeS1XHj9v85kQUn8KdXKm8my4p2r7D4uL74eZ59
 X94kfAHhiSSA=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJ7225CdTzMkrw
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

An upcoming patch commits panel_power_savings writes from the kernel
without a modeset. amdgpu_dm_atomic_check() sets connectors_changed on the
CRTC when the connector's ABM level changes, so that commit would fail
with -EINVAL

The flag came in with commit c5892a102182 ("drm/amd/display: Fix dmesg
warning from setting abm level"), because setting the level did not add
the CRTC to the commit and no stream update reached DC. With other changes
since then, that fix is no longer needed. On the non-modeset path,
dm_update_crtc_state() copies the level from the connector to the CRTC
state and the commit tail sends a changed level as stream_update.abm_level

Keep the flag for scaling changes, which move the stream's source and
destination rectangles

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Upstream, a level already reaches DC this way when a compositor commits
the connector after a panel_power_savings write. The store has already
written the level into the current connector state, so the old and new
connector states match and atomic check doesn't ask for a modeset. Only
the CRTC state, which still holds the old level, sees the change. With
this series, the hardware tests in the cover letter apply every level this
way

If a level change through the KMS property should still force a modeset,
the store could flag its own commits instead. It would set a flag in
dm_connector_state that atomic check reads to skip connectors_changed.
duplicate_state wouldn't copy the flag, so it only lasts for that one
commit. I think it's simpler to treat the change the same way whoever made
it, but I can send that version

Scaling has been in the same check since commit 3c6d1aeb4342.
From my reading the non-modeset path handles it too, as a src/dst stream
update, but it changes the scaler ratio and I can't tell whether DC needs
the full validation for that. Could it go as well?
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfbc384fbbdb4..256699cdd0b5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6304,8 +6304,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		if (dm_old_con_state->abm_level != dm_new_con_state->abm_level ||
-		    dm_old_con_state->scaling != dm_new_con_state->scaling)
+		if (dm_old_con_state->scaling != dm_new_con_state->scaling)
 			new_crtc_state->connectors_changed = true;
 	}
 

-- 
2.56.0

