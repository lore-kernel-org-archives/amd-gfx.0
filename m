Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01754C7EE31
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 08:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8041E10E6AB;
	Wed, 25 Jun 2025 08:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dX3cxh4P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HzKSDPCV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dX3cxh4P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HzKSDPCV";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AFFC10E6AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 08:43:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 22DCA1F457;
 Wed, 25 Jun 2025 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750841000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IfA+YoYacAORpLcpdzBSaeEMwAfxLfTeKheK6z0UwjM=;
 b=dX3cxh4PLc988vY4JOB/Jhbuo8/+z9sqTpnIQBPfAo/eRWcTukj0t8x8R9wWd3Xn8s9voy
 gjhtEogCrnlg0vWBNWDjBx+snqnWpOL9qa98XT0F/RXDoArv/dICwDlCVT07NWdeAcWiP9
 QRXoNuwjDZCGzC6hvFMUDAlH2AqIW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750841000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IfA+YoYacAORpLcpdzBSaeEMwAfxLfTeKheK6z0UwjM=;
 b=HzKSDPCVzP5jXRBxDDILbvwCPCPPWOz2UyJEDAzwppC2dpr55RtEggoho3vPAAdTBzsryd
 JiVCYfGDUMdFc1AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750841000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IfA+YoYacAORpLcpdzBSaeEMwAfxLfTeKheK6z0UwjM=;
 b=dX3cxh4PLc988vY4JOB/Jhbuo8/+z9sqTpnIQBPfAo/eRWcTukj0t8x8R9wWd3Xn8s9voy
 gjhtEogCrnlg0vWBNWDjBx+snqnWpOL9qa98XT0F/RXDoArv/dICwDlCVT07NWdeAcWiP9
 QRXoNuwjDZCGzC6hvFMUDAlH2AqIW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750841000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IfA+YoYacAORpLcpdzBSaeEMwAfxLfTeKheK6z0UwjM=;
 b=HzKSDPCVzP5jXRBxDDILbvwCPCPPWOz2UyJEDAzwppC2dpr55RtEggoho3vPAAdTBzsryd
 JiVCYfGDUMdFc1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDFDF13485;
 Wed, 25 Jun 2025 08:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k7rhMKe2W2h5IwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 25 Jun 2025 08:43:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sumit.semwal@linaro.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/2] drm/amd: Avoid using import_attach directly
Date: Wed, 25 Jun 2025 10:42:16 +0200
Message-ID: <20250625084314.414044-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch,linaro.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The field import_attach of struct drm_gem_object is often only
required by PRIME code. In other places, replace its use with
clearer alternatives.

v2:
- keep amdgpu_bo_print_info() as-is (Christian)

Thomas Zimmermann (2):
  drm/amdgpu: Test for imported buffers with drm_gem_is_imported()
  drm/amdgpu: Use dma_buf from GEM object instance

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  6 +++---
 6 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.50.0

