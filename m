Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE84DC44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA6010EC6B;
	Tue, 14 Jul 2026 08:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZqiOdsOj";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11ED10E664
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 19:33:54 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1913220f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971233; x=1784576033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=55hAsrp5cSCWxuD/wsCuwgomM/DV8c8oAdTivk9jE54=;
 b=ZqiOdsOj4Fsmh3XDI32EYUezovAb+usxLQjN5T1TM51Elc9XQxg7QHsx+eSPcvwYCX
 m+RM4M/uLmpItv+M5zr7P/6O1qQc6/13uSLNiANTVI92B5xIjhwV9Qu9EQ/S2UMaRCF7
 jkNIaNttF1UzvhR89kmkVHEMrBenC2ao7VH9ZHDCZzJc3U0JtUK8cybnIOAAqHE6H8ku
 pwoMyhvdIEdAiSSnCzzmfC9dWrpFiSq+PL2aXdNBgTVAwD3CP6dQOy8Mw9Tyzy/y2QTB
 EzQ9QKEQNsnRKfj+Awtwn0ERFfLQgRxvFsWSw+JJo9qZUfgRJI967io7bahfgG/Vfoiy
 Pzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971233; x=1784576033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=55hAsrp5cSCWxuD/wsCuwgomM/DV8c8oAdTivk9jE54=;
 b=KQ1z5TL2MDs+vWJ2fuWjAw3KD24QNnmg26Mrq/nUv2fzEevEfEoOxMc4C7kKkrLg2z
 adRQ8zjOV5K7+lBSIE4DnkuehA/AAhEc4kELP8y7WBtlVzRbOl09P5tryaCyuPMrPYGj
 wRM2boNSc56BJj5p2/XdCzBpDlLV3PtDKZsTSU1jica7KZAB0CfIzdWoHaHFPFXSR9D9
 XeAhaKe/CQqE2tTLa1dcBL/CR4CKbA03vz+73wZzOfisJoHlZtZjTGFmDrUqwC0d5jgT
 RA9dRpDWEuImFS34qfiDKDDdyF3CQul/hxLzG9RMUqYxx1wMldkWsjRyISLNB7iHayfc
 1aRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrz5kUSfLq5kIzAKq/dTODcX0RyxC1OFmn+rI3jRQfxW3d/FyaXmcjr7F4PV9QIT+2HMA6uJFWa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBZKhM/g1+GvPwDnmiMF5Cn2GZAtagTcyGtk153NIJj6et3UMU
 xqIAN6G/yHeM7l6k0i/k1qbuHPLeN3bIA7EYnw2rt2pUdSeYwZQbQJ9n
X-Gm-Gg: AfdE7cmd/NsKazeRyFKaGXzZEhdhCagiNrrr6uCef81MNdcR9Iu1d/hhX8I9gc4IIH+
 gwxhnzSe0Rvn3rNZYEaHGNe6vFUI4TE2y7UwE1XAtB0iFezF2qi+b/+i5DWFnV3EHOU/vh9ai76
 VYG5dNzJ1+0wTHJ9FQK48oe6wv/j2qMrn+BRQEuTO+TAWogh9RmFKWvUCU4uhMzd2O1Wc+BJVY8
 LkuEqzophcrJI8Ql6IWH/oOO/1Ddmj8JVG+58ucZG10CUzwoeeYSbfw6ysdltoNmrzKIPjQF1hi
 /itZhcpvIy8p7mbgRa/APoXvW+/keyJx+8P3XIZcwOzaxkwWYGf/WgCnxAql0VQB2+Q+awLpchZ
 NW8XQjITNTVPxPHm6G4CbmPZYS0sbBipdI5BINIgF13f2x7A/G2Ou0osnEExOGOoQEUyk8Byojg
 JFUOta7CqfygVzgKnQT6FXoviNu2dj
X-Received: by 2002:a05:6000:2505:b0:47f:25b1:e7b0 with SMTP id
 ffacd0b85a97d-47f2dcd5553mr11731996f8f.44.1783971232956; 
 Mon, 13 Jul 2026 12:33:52 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0d9sm1912993f8f.2.2026.07.13.12.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 12:33:52 -0700 (PDT)
From: =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Timoyoungster <timo.proemer04@gmail.com>
Subject: [PATCH v2 1/2] drm/edid: Export drm_edid_block_count()
Date: Mon, 13 Jul 2026 21:32:36 +0200
Message-ID: <20260713193237.2639-2-timo.proemer04@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713193237.2639-1-timo.proemer04@gmail.com>
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jul 2026 08:29:45 +0000
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

From: Timoyoungster <timo.proemer04@gmail.com>

Drivers currently calculating EDID size by reading the `extensions`
field of the raw EDID structure (e.g., `edid->extensions + 1`) will
calculate the wrong size if the EDID contains an HF-EEODB (HDMI Forum
EDID Extension Override Data Block). The base extension flag does not
account for these override blocks, leading to truncated EDIDs.

Remove the static declaration and export drm_edid_block_count() so
drivers can safely query the true block count. This allows drivers to
leverage the core DRM's proper handling of HF-EEODB and other edge
cases without having to parse the raw EDID fields themselves.

Signed-off-by: Timo Prömer <timo.proemer04@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 include/drm/drm_edid.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac..34560b33a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1698,12 +1698,13 @@ static int __drm_edid_block_count(const struct drm_edid *drm_edid)
 }
 
 /* EDID block count, limited by allocated size */
-static int drm_edid_block_count(const struct drm_edid *drm_edid)
+int drm_edid_block_count(const struct drm_edid *drm_edid)
 {
 	/* Limit by allocated size */
 	return min(__drm_edid_block_count(drm_edid),
 		   (int)drm_edid->size / EDID_LENGTH);
 }
+EXPORT_SYMBOL(drm_edid_block_count);
 
 /* EDID extension block count, limited by allocated size */
 static int drm_edid_extension_block_count(const struct drm_edid *drm_edid)
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 04f7a7f1f..4a990bf87 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -481,6 +481,7 @@ const struct drm_edid *drm_edid_read_switcheroo(struct drm_connector *connector,
 int drm_edid_connector_update(struct drm_connector *connector,
 			      const struct drm_edid *edid);
 int drm_edid_connector_add_modes(struct drm_connector *connector);
+int drm_edid_block_count(const struct drm_edid *drm_edid);
 bool drm_edid_is_digital(const struct drm_edid *drm_edid);
 void drm_edid_get_product_id(const struct drm_edid *drm_edid,
 			     struct drm_edid_product_id *id);
-- 
2.55.0

