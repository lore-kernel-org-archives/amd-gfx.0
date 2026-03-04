Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B87EDA697
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 13:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231BD10E9E2;
	Wed,  4 Mar 2026 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="IuBB5eLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/yy5hIm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IuBB5eLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/yy5hIm";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039D010E9DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 13:02:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A429D3E7F7;
 Wed,  4 Mar 2026 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772629374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8cWdL4KqJ3qiEDShj9iKehrervW9X40lnlcf0RQeBDE=;
 b=IuBB5eLpiT/YG+fXEvUwh+qi0WJgp2Geg8YK0iaZc3bdzyhtoFPpiNtnEN4t6V8BNczx+2
 Dxt/l+stfxIwtdczfv83RFxejPiZNwPNCF3jsb8xmOBlJaPd4QxyeNGZbue9eAsKgPIaQe
 a+op0DJ0VcCZSRNraUl0x9bwElRlzcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772629374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8cWdL4KqJ3qiEDShj9iKehrervW9X40lnlcf0RQeBDE=;
 b=e/yy5hIm64aOvHGoJ51Tk7m1tgBrY7PBGwFnorTawhSZ1bjq7uc8AwebDG7/IUEVdo7GBX
 3/rfzAfBfh8V3gAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IuBB5eLp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="e/yy5hIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772629374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8cWdL4KqJ3qiEDShj9iKehrervW9X40lnlcf0RQeBDE=;
 b=IuBB5eLpiT/YG+fXEvUwh+qi0WJgp2Geg8YK0iaZc3bdzyhtoFPpiNtnEN4t6V8BNczx+2
 Dxt/l+stfxIwtdczfv83RFxejPiZNwPNCF3jsb8xmOBlJaPd4QxyeNGZbue9eAsKgPIaQe
 a+op0DJ0VcCZSRNraUl0x9bwElRlzcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772629374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8cWdL4KqJ3qiEDShj9iKehrervW9X40lnlcf0RQeBDE=;
 b=e/yy5hIm64aOvHGoJ51Tk7m1tgBrY7PBGwFnorTawhSZ1bjq7uc8AwebDG7/IUEVdo7GBX
 3/rfzAfBfh8V3gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 607A83EA69;
 Wed,  4 Mar 2026 13:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V9UUFn4tqGmlNQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 04 Mar 2026 13:02:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] amdgpu,radeon: Test fbdev GEM object in helper
Date: Wed,  4 Mar 2026 13:58:37 +0100
Message-ID: <20260304130250.59008-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: A429D3E7F7
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

Amdgpu and radeon handle GEM objects that refer to fbdev framebuffers
separately from the other GEM objects. Share the test logic in a single
helper that works for all.

This series is purely for cleaning up the drivers. No functional changes
intended.

Thomas Zimmermann (2):
  drm/amdgpu: Move test for fbdev GEM object into generic helper
  drm/radeon: Test for fbdev GEM object with generic helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 21 +++------------
 drivers/gpu/drm/drm_fb_helper.c             | 29 +++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_device.c      |  7 ++---
 drivers/gpu/drm/radeon/radeon_fbdev.c       | 17 ------------
 drivers/gpu/drm/radeon/radeon_mode.h        |  5 ----
 include/drm/drm_fb_helper.h                 |  9 +++++++
 6 files changed, 45 insertions(+), 43 deletions(-)

-- 
2.53.0

