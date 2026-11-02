Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5FB606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=ogCjbn09
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29EB410EEE2;
	Mon,  2 Nov 2026 14:15:58 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBE310E5E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 10:18:03 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jJ7220NZDzKn99;
 Mon, 02 Nov 2026 11:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793614682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtARmKugIQb+7L25cEk3dwin99E1zGAgqgjVr3BvYFM=;
 b=ogCjbn09JTZgL0QcUwFZcT/AlUiX7hvS5ZiPi06imQmochqxXgiBO+igyy7Oa0KB90af/5
 j/huYHjvkedHhJ+zwz/Rluh6JRvoNLqe6+OVlxq+5XvBtS0vigLeqxZAmPnwG7f9l8n3qi
 bU8nVOig905QqVFB6Xi408e4zIggpwXwqOuFnUlqEQjD+TG47VyBPefW3AzQyoJHjZ6z+d
 4yAuSZYvzns9BfyLRMNW2RQIk/nLcjG63OSNInWms9PgTSYK55dePnp+i1QApDjzd/WIEH
 JGXFCRRCJIJ4zb0BhQVWukFKhUMSXf1BcvF97558MpDBGpZNQS7osQJ0In03pg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, harry.wentland@amd.com
Subject: [PATCH 1/5] drm/amd/display: Render the panel power savings kernel-doc
Date: Mon,  2 Nov 2026 10:17:54 +0000
Message-ID: <20261102-abm-sysfs-commit-v1-1-e5addfd9539a@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
References: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=hugo@hsal.es;
 h=from:subject:message-id; bh=FVHKsTcB+kzVbQ+9zevb2MG6df7WbrsHz6OXzX6yqvM=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4khzmcze1q+fFU/NzGfeUNNfpz+FN3XLZZqGntd
 SzumTHja/eOUhYGMS4GWTFFFt0bngwsEyfPzCl6vgRmDisTyBAGLk4BmEgrC8Nfke2Lk5cm7JHx
 E+yr9dl/IM5repLL++adFgtDI7gzxRnPMzKsMvgsrqe59dmMT5Orf8o2Bm9yT7i7Y9ey5ZNrd79
 MXH6ZCwBNfEr8
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJ7220NZDzKn99
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

The DOC section for the panel_power_savings sysfs file is not included
in any rst file, so it never shows up in the built documentation. Add it
to the Display Properties section next to the 'adaptive backlight
modulation' property it interacts with

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 Documentation/gpu/amdgpu/display/display-manager.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
index f6de9e7779e29..ca4a956d2aa17 100644
--- a/Documentation/gpu/amdgpu/display/display-manager.rst
+++ b/Documentation/gpu/amdgpu/display/display-manager.rst
@@ -187,3 +187,6 @@ Display Properties
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
    :doc: property for adaptive backlight modulation
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+   :doc: panel power savings

-- 
2.56.0

