Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52623C531DD
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 08:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A253410E15B;
	Mon, 12 Aug 2024 08:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="IXRm4Vj5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zzrn2jI6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IXRm4Vj5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zzrn2jI6";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CDF10E0BA;
 Mon, 12 Aug 2024 08:30:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91201224D4;
 Mon, 12 Aug 2024 08:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723451407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pvgv/frxVeqQyL6GfQNuOB213eqzdqzjXbbNq8mgTw=;
 b=IXRm4Vj5IwtJbl3eNBevo6E3c/D6/XsIiCV3k31yPtdVhYinp2EErlQDcNAr9CBW+AZC3S
 PM8psQYCY0ax9aypzG++V//ZTKdCaDKEQR6Bv2ej0YxFkJAOyT5QlAT5kSWyZQSUCNU1rS
 JqoFR8KN6O0ZyDpicozgGGktqteTVcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723451407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pvgv/frxVeqQyL6GfQNuOB213eqzdqzjXbbNq8mgTw=;
 b=zzrn2jI6TWlAcyi4MMZ1cG3sBCl0YpzaNMMgN34uQyEHh3sg6DY/fAiYlb6Y4UDeT4UuKl
 ycTRJRh8MC8rXSDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723451407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pvgv/frxVeqQyL6GfQNuOB213eqzdqzjXbbNq8mgTw=;
 b=IXRm4Vj5IwtJbl3eNBevo6E3c/D6/XsIiCV3k31yPtdVhYinp2EErlQDcNAr9CBW+AZC3S
 PM8psQYCY0ax9aypzG++V//ZTKdCaDKEQR6Bv2ej0YxFkJAOyT5QlAT5kSWyZQSUCNU1rS
 JqoFR8KN6O0ZyDpicozgGGktqteTVcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723451407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pvgv/frxVeqQyL6GfQNuOB213eqzdqzjXbbNq8mgTw=;
 b=zzrn2jI6TWlAcyi4MMZ1cG3sBCl0YpzaNMMgN34uQyEHh3sg6DY/fAiYlb6Y4UDeT4UuKl
 ycTRJRh8MC8rXSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3482F13A3D;
 Mon, 12 Aug 2024 08:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEd4Cw/IuWZpHwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 12 Aug 2024 08:30:07 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 5/9] drm/nouveau: Implement switcheroo reprobe with
 drm_client_dev_hotplug()
Date: Mon, 12 Aug 2024 10:28:26 +0200
Message-ID: <20240812083000.337744-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812083000.337744-1-tzimmermann@suse.de>
References: <20240812083000.337744-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.20 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[15];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,redhat.com];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

Replace the call to drm_fb_helper_output_poll_changed() with a call
to drm_client_dev_hotplug(). It is equivalent in functionality, but
uses the DRM client infrastructure.

v2:
- fix commit description

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/nouveau/nouveau_vga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
index ee637f1fe03d..ab4e11dc0b8a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vga.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
@@ -58,8 +58,9 @@ static void
 nouveau_switcheroo_reprobe(struct pci_dev *pdev)
 {
 	struct nouveau_drm *drm = pci_get_drvdata(pdev);
+	struct drm_device *dev = drm->dev;
 
-	drm_fb_helper_output_poll_changed(drm->dev);
+	drm_client_dev_hotplug(dev);
 }
 
 static bool
-- 
2.46.0

