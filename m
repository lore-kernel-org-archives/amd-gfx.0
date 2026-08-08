Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAF2C5B56E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FDB10E1DA;
	Mon, 10 Aug 2026 06:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Il77kG1p";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AA810E050
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 17:11:24 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4956869750eso3316525e9.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786209083; x=1786813883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KCTcaBKr7T391ZbO7i/xjaiRuYVUXIrWDcah/FgQTt8=;
 b=Il77kG1pL/FF0MK45sGL1+iA1+mxNLZpZa2aTEz7dJmurlVapa8mVmFjUWoshYR1rc
 +vpuVSZhUfl1olw6db1SW6faqfQErsUCJRVOngU4dH6LtRek05FKRHvNdN5yk1t26Pvg
 Ut4C+RKoiYf9VHgPiRdcpfs3P0oLHkf2cnePukTSJN7Su429JMuGl0Ow3PdA4P06KI1c
 1in0Qirs8lRqxhxraVDBfo3LYULdAZvvxXX06gYu9SQkVZsDt5GyhMTvnFUNUOPiK/Og
 WsK7IldjpRxX57GBaisBOevQPNAqZWFRMYfVgb5NLLJfURaDtxG3SGQBviEyy56gZId4
 44EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209083; x=1786813883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KCTcaBKr7T391ZbO7i/xjaiRuYVUXIrWDcah/FgQTt8=;
 b=UgoUi+uPIhcRrJ3Zhevj2SRvlu4qcGdxoUDe8QIgYCj629y+QUv84Y8qxgMmdJnNXt
 gUr2SkoSR3Z+1Lkty94FGzyYshzGlMHZQWbFvKVT582dLSVC5wY9xGRWFIhgyvpQrAjs
 b1AtAwT9Gdm+hXxwgHY815otD58hs/n4HG/0k10nXXon1hRCCsllYPuDAlgXjln7tggE
 I7henSJ0/zYo691VtOV+/LkKafZiJqD8YxZscBbw/TT0x6mzmCnrCpwpSpcHp2ehonE8
 vh7m05FuHwZMa6TEiqukpnKEMzH2ZBZY2scD1FjBKBHA9E2X7t+cIT5XLSMnzG+Z/1SX
 C4ig==
X-Gm-Message-State: AOJu0YxhGgzg/3VcBIvR/GKpV2Fs+nUHXEjzN4OkAveO0U/KzI4gm5/o
 eif8UbsPi9ut7CLb13Igr1aqsc5L1FAE95+WBv8DspcBlMEo5em7XP4AUxvRFZRcV8A=
X-Gm-Gg: AR+sD10AtFt2gOgFj066GZYo4cY2pPOsSzzEzHc6tsIYRBKXZm9KhygXOA+Zf7twGSG
 7q8TnUdv0ttCQI9gu1g5FuJatWycWXiPobsm9E/Av851JDHQuAKGTdT1DMXIW1eK5FFJNpXUL01
 Vo8S2JY1MNvhNedzgkadVyROa1DB0uhX6sINwMQ1rKiD6mgwNEcmnuQO01GF6trh4BdxcKj2/q8
 6kNW8pfsi//yv2p6O5wDi/v8vT7jV1FIL3rO+G2qBul1vDAzTNz5H/JXOojOh+DPR2jtnRVPBbz
 mysQgpORVy4Oz470tls3GyByLgF51NANwTudFGxOXPgLQ6gJXGRFA2QP1in9cv1AYvq8bWGxt5B
 vpOv6WWkE74zzt9IAm2oQIVLeEuQZu8yyByjHVbq2gdqVKxBsmwmGSr1NHylQ8hnUrgR6hftDcu
 PwOQyUkSi1GtPKjVAaF9ih8ZK/a5DueiFoSgP9nnzplM2ASyotTjllIPhNqss3hbg2hXDCv6tVa
 2WSkFaQa4e8aeZfGb/Gg2hA2oE=
X-Received: by 2002:a7b:ca4d:0:b0:495:6134:6d61 with SMTP id
 5b1f17b1804b1-4994e7eb2d2mr316937665e9.19.1786209083099; 
 Sat, 08 Aug 2026 10:11:23 -0700 (PDT)
Received: from lars-laptop.lan ([195.63.71.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995427a244sm243161115e9.10.2026.08.08.10.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 10:11:22 -0700 (PDT)
From: Lars Nieradzik <l.nieradzik@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Lars Nieradzik <l.nieradzik@gmail.com>
Subject: [PATCH] drm/amd/display: fix EPERM reading amdgpu_dm_dmub_fw_state
Date: Sat,  8 Aug 2026 19:09:26 +0200
Message-ID: <20260808171030.93661-1-l.nieradzik@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

dmub_fw_state_show() returns seq_write()'s value directly. On overflow
seq_write() returns a literal -1 rather than a meaningful error code, and
seq_read_iter() treats any negative return from ->show() as fatal, so it
breaks out before reaching the grow-and-retry further down the same loop:

		err = m->op->show(m, p);
		if (err < 0)		// hard error
			break;
		if (unlikely(err))	// ->show() says "skip it"
			m->count = 0;
		if (unlikely(!m->count)) { // empty record
			p = m->op->next(m, p, &m->index);
			continue;
		}
		if (!seq_has_overflowed(m)) // got it
			goto Fill;
		// need a bigger buffer
		m->op->stop(m, p);
		kvfree(m->buf);
		m->count = 0;
		m->buf = seq_buf_alloc(m->size <<= 1);

The DMUB_WINDOW_6_FW_STATE region is much larger than the initial one-page
seq_file buffer, so seq_write() always overflows on the first pass. The -1
breaks the loop before seq_has_overflowed() is ever tested, and since -1 is
-EPERM userspace sees:

  # cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_fw_state
  cat: ...: Operation not permitted

That reads as a permissions problem even though the file is 0644 and
the read is performed as root, so the file has been unusable since it
was added.

The adjacent dmub_tracebuffer_show() shows the correct pattern: it
emits via seq_printf() and returns 0, letting seq_has_overflowed()
drive the retry. On a Ryzen 9 8945HS (Phoenix, DCN 3.1.4) that sibling
returns 224332 bytes from the same debugfs directory, so the growth
loop handles output of this magnitude without difficulty.

Return 0 and let the seq_file core detect the overflow.

Fixes: 2364076772b1 ("drm/amd/display: Add DMUB firmware state debugfs")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lars Nieradzik <l.nieradzik@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index c4b2fc690fd7..ea4cae7d140f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -989,7 +989,9 @@ static int dmub_fw_state_show(struct seq_file *m, void *data)
 
 	state_size = fb_info->fb[DMUB_WINDOW_6_FW_STATE].size;
 
-	return seq_write(m, state_base, state_size);
+	seq_write(m, state_base, state_size);
+
+	return 0;
 }
 
 /* replay_capability_show() - show eDP panel replay capability

base-commit: c4f76bf5e107bcda6e496f1c4060c55af091fa79
-- 
2.55.0

