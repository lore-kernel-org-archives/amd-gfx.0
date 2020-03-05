Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF3C3F2D8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0329120848
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3sq30PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0329120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966D789DE6;
	Thu,  5 Mar 2020 13:26:00 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A467789DED;
 Thu,  5 Mar 2020 13:25:59 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a132so6303559wme.1;
 Thu, 05 Mar 2020 05:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jHh2XovPyX/BvR8zXQnoEBn2BLqmrZNJbq5eph3/YOs=;
 b=W3sq30PSsv72CW4h5CN6mZgFrfMo0JgQ9WRPqwLnZ01JfhWFOClkqg5hGoo2xZHSAb
 pW2mZruv9MdMllZfmXgdn0P3c/KrNiW5pJANSAJORnYyuvN85R920biRUxxiC813ga11
 //yZBLzxrz3GvQ7j5MxTJPhb408CMFDG/+rRA1ZnQhDYBWsIC67bF+McyOlTzHJEDX1K
 5rleM8uUE1QUK2CK2Tgi4LQADAkAN2fO2rWRTKomPnKAES9gnB0RsgY4hS6yKtP89IQI
 m5lBjn4M/AeewxpqbBrOB9MJZBmv+GX3ZQQdbacqXga7wSafOFZqjRMQPu1n8tggaugc
 5MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jHh2XovPyX/BvR8zXQnoEBn2BLqmrZNJbq5eph3/YOs=;
 b=NY64JE3AnmiYe1m8YcQhMP8hcsDgeh+DkFUwCpdEaoJD1UeeBZA0WC0LT3fR1MnqYp
 V2nWHPvlp7q9lJb+trIujgxksneSQ17XtozZ0+Gw07JcCfnZZ8AMh5V8SPPlGmlaeOaa
 yfVEiCNk5+7KopnwBAXEH++i19papU/TMn9+VyNo4NACTBrffPYmrPzXzswtL3hupTez
 D6fQalX5WMHZsYTv7hebwBPfEPD8iajHT5eGeAzHiOlgPMN3QdHGmupbfSv+/AuM6rO6
 Xj2ieLz+9V7uWy7iv1ovDkp1j05ztmueyEcfb9E0p/49N+aeuGnRezfUOi4F9FQZ0t9S
 QaAQ==
X-Gm-Message-State: ANhLgQ0Q4SbuafYp9KrKu2RYV2kkjAWl316h+R57CCws6Ekpp0eKc7cl
 AWHf3Bvw+rwqAWIOPIQ53e4lwVwfK1CSOA==
X-Google-Smtp-Source: ADFU+vsOPx4rIGpdmcABIFmnpsBorWzdV/O59dvsArq2BWHNb8sR290Bfhi9uqGso1fryx+KAuCaMA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr5454551wmm.91.1583414757944; 
 Thu, 05 Mar 2020 05:25:57 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2EA5001F22CF19908511A1.dip0.t-ipconnect.de.
 [2003:c5:8f2e:a500:1f22:cf19:9085:11a1])
 by smtp.gmail.com with ESMTPSA id g14sm45424819wrv.58.2020.03.05.05.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 05:25:57 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 7/8] drm/bochs: use drm_gem_vram_offset to get bo offset v2
Date: Thu,  5 Mar 2020 14:29:09 +0100
Message-Id: <20200305132910.17515-8-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200305132910.17515-1-nirmoy.das@amd.com>
References: <20200305132910.17515-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 Daniel Vetter <daniel.vetter@ffwll.ch>, alexander.deucher@amd.com,
 sean@poorly.run, christian.koenig@amd.com, kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch over to GEM VRAM's implementation to retrieve bo->offset.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 8066d7d370d5..18d2ec34534d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -29,16 +29,21 @@ static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
 	struct drm_gem_vram_object *gbo;
+	s64 gpu_addr;

 	if (!state->fb || !bochs->stride)
 		return;

 	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
+	gpu_addr = drm_gem_vram_offset(gbo);
+	if (WARN_ON_ONCE(gpu_addr < 0))
+		return; /* Bug: we didn't pin the BO to VRAM in prepare_fb. */
+
 	bochs_hw_setbase(bochs,
 			 state->crtc_x,
 			 state->crtc_y,
 			 state->fb->pitches[0],
-			 state->fb->offsets[0] + gbo->bo.offset);
+			 state->fb->offsets[0] + gpu_addr);
 	bochs_hw_setformat(bochs, state->fb->format);
 }

--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
