Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17129CCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82A0112695;
	Fri, 16 Oct 2026 08:55:44 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133C810E2E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 03:16:41 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so47037925e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792120599; x=1792725399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JRXhFgZsIqkWNlRPBEo+vqto9YY5n1rr9e3kPIK1m+o=;
 b=MMOfry9PsAHrEsyuAYCaUdgZBWE09z68mI89YfpXEBwZ68B05n31FL4ZtgAT2yXgyj
 xxBqRFGfvknb/bp8o930mA4BEndhJCQi5bGSrJLO/BxqmHH2CPeu/SxJ0gJjR3XWZyEe
 FdVuBkEBAsbUbNZZwHTP4J9HcHJ9PNe5j3fO+pl4SRxV0B0ijOLPRYag+Q9ZbYxpfwzR
 bq3BCCqAiuJzpRqBrhg2o7D0zjfwGgs5V5t8H1XB4hj8iQaNubYg3C7kiFYOZenbg+Uh
 JUUEgReiWKjGseLOMwy/OF1Q/BEqX84C0XAjbeDgGZQ1yahTAeJB47jhKOzrWZkXfrBA
 zZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792120599; x=1792725399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JRXhFgZsIqkWNlRPBEo+vqto9YY5n1rr9e3kPIK1m+o=;
 b=vnigIoYAHoRRc+QvSMoDZk5d3f4ag1nIBoYIGJJanjXYwt4joZdwsCzNpDeCtOIvKI
 zgU/iWAtqEwQVMBlMmIlm/DT25dFOFjpH4Txg5ug86KmMj060lpnGc6pRECD7LAN0Cyk
 4LoXuo7DyjphDG9E/jgcL/7qpkqZvZUdatdV/PH/iUJVqvGyu/mDJIQYk0PqxxwoE1BC
 qxvFh2nBmS6ORH/8HzY2ICL4wH41fWbYMej5b+ksootwRXyHWNZV2AiU25LSAUb+r1OX
 BE0go6wuX8sSc19PpjuieXYq6zFK3+t4BVWM/f6QwXJYTO1vIVAs37ycO5P0EZVsiVxC
 pjOQ==
X-Gm-Message-State: AFq9FYIUc7LyQNNlom0jRH3N5IHEGjYo7YGakoxO3bHfxSL2HQPJIIXu
 XZSPbuZ/TBmp8Ymb/1qr6MOlAH4dGc6yglrV0i9aLpL+0N8pPjAL0tpo/pIjFzmrhoo=
X-Gm-Gg: AYBFou0IrXHFb1CaRuYUxDjyb/PfrMshd1qpJrJq5ngPhbSDNdWZ8d+xgvUXMlO0l72
 HSHr6bSyOEemjUX6/edFU63xnxAiaNtLde5vAec7slK3qz2T5xromu0PSAP20FAwy54gL6Rm6wG
 cB8REogs8b4O54zIQGS7hpNmHjWkId1qg3PfaZ85lA0MGP+4DPbNfzT4NZ9dV6txOnL9d2TRAgp
 zTkX4Lq49kIqGoTKcbx4OLY76WbVisClSWSThN5KGQZp3KkeMVlmP9TDke1z2ZSDRUp7iThAo6b
 7SPG0wfi+ctw4waz93Vd/lowRgUZ2qsz0ZaGptasX/VFkYZGicPqQLsql13Rtvh/2/xvCeVN+pF
 RKMrU+mamU8RB2FMXS7fEi/AdLfqGTLnU+4YbS7GkgKS4LQhSI5ByndbSRuhba6JgEPzrYutuw6
 Rg2xPepgUEhGgOf0FxsOBg4K7ejnPNabW+zQzrUe2gYYBPOYJfJE1z6c3MkWiRHcnKZRAI0aioR
 epDO2SBTCghxNQIuZpIE1y7W6ZJ8tl4kECAzBahuIQjaThE7I4v4Y3xZ5NwFkDhDfYMOrmyOwzv
 kP49GwboXXAHwFCb/x3hlfNBD9hi5KXwDoTLvQ==
X-Received: by 2002:a05:600c:c104:b0:4a1:96cd:2f73 with SMTP id
 5b1f17b1804b1-4a196cd32b0mr248934165e9.1.1792120599173; 
 Thu, 15 Oct 2026 20:16:39 -0700 (PDT)
Received: from localhost.localdomain (93-55-250-55.ip266.fastwebnet.it.
 [93.55.250.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8de8c58sm22527735e9.15.2026.10.15.20.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 20:16:38 -0700 (PDT)
From: Luigi Lauro <luigi.lauro@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Lyude Paul <lyude@redhat.com>
Subject: [PATCH] drm/amd/display: take a runtime PM reference only when a CRTC
 turns on
Date: Fri, 16 Oct 2026 05:16:36 +0200
Message-ID: <20261016031636.575385-1-luigi.lauro@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 08:55:44 +0000
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

amdgpu_dm_commit_streams() takes a runtime PM reference for every
active CRTC that needs a modeset and has a new stream, but
amdgpu_dm_atomic_commit_tail() drops one only for each CRTC that goes
from active to inactive. A modeset of a CRTC that is already active (a
mode change, or anything else that needs a full modeset) therefore
leaks one reference. Once that has happened, the usage count no longer
returns to zero with every CRTC off, and the device cannot runtime
suspend again until reboot. The two also disagree the other way when a
CRTC turns on without a stream ("Failed to create new stream"): no
reference is taken, but one is dropped when it turns off.

Take the reference in the loop that counts the disabled CRTCs, on the
mirror condition: when the CRTC goes from inactive to active, which is
what the commit that added it intended ("every time we enable a
previously disabled CRTC"). Each active CRTC then holds exactly one
reference.

Tested on an RX 9070 XT (Navi 48) over OCuLink, with the change
backported to 7.2.9: an unplugged connector forced on, then mode A on a
CRTC, mode B on the same active CRTC, and the CRTC off, three rounds in
a row. The usage count rose by 3 with the stock module, by 0 with this
patch, and by 3 again after reloading the stock module.

Fixes: 97028037a38a ("drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5951
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>
---
Alex asked for this on the issue. It differs from the change tested
there, which only skipped the get in amdgpu_dm_commit_streams() for a
CRTC that was already active: with that form, an off-to-on modeset with
no stream (the "Failed to create new stream" continue) takes no
reference, and a later modeset of the same CRTC with a stream and then
an off drops one more than was taken. Pairing the get with the put
closes both.

Who changes: any system where a CRTC that is already active gets a full
modeset (a mode change, an HDR or colorspace change). Today each such
modeset leaks one reference; with this patch it takes none. A CRTC
turned on without a stream now takes the reference its later turn-off
drops; I could not exercise that path.

Also tested at rest, on a boot with no leaked references: with nothing
using the card and its connectors never probed (a TV is attached), it
runtime suspends to D3hot with this patch after a forced wake, and the
usage count drops to 0, as it does with the narrower form loaded before
and after. That test runs no modeset; the rounds above do.

The change applies unchanged to 7.2.y.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c4fee73a0..605f289ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4707,8 +4707,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
 
-			pm_runtime_get_noresume(dev->dev);
-
 			acrtc->enabled = true;
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
@@ -5292,8 +5290,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 #ifdef CONFIG_DEBUG_FS
 		enum amdgpu_dm_pipe_crc_source cur_crc_src;
 #endif
-		/* Count number of newly disabled CRTCs for dropping PM refs later. */
-		if (old_crtc_state->active && !new_crtc_state->active)
+		/*
+		 * One runtime PM reference per active CRTC: take it when the
+		 * CRTC turns on, count it when it turns off for dropping later.
+		 */
+		if (!old_crtc_state->active && new_crtc_state->active)
+			pm_runtime_get_noresume(dev->dev);
+		else if (old_crtc_state->active && !new_crtc_state->active)
 			crtc_disable_count++;
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-- 
2.56.0

