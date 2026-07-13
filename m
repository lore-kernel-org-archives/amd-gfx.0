Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2D4C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C6A10EC6F;
	Tue, 14 Jul 2026 08:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUWNmxVw";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD7010E642
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 19:33:57 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47d70879764so2271925f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971235; x=1784576035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fva3fNs5KHsr7s0cnZc7nNvHW+HXrMU/GnXk6nCiZ1U=;
 b=BUWNmxVwpfyjxuDF94N4B10Uwxibf/TOcJ7BgKdekIROQHPfCDMgCk8aA/anjEtQWs
 cUbY9mRFl4YcF5xMf8V69STW6gzRyBBgpkIgfNsG0Vy/D4fC6M1SeXryqDeY3e85o9I0
 lGcZTABjx0CldpUe0VlKYgJBgqg+obpYcPe9278G1hjt6FkGfOyMgQdlpX+FRNZfyDie
 fgqnn/3Biq09ezt2sjfOzrv0ccKsroZNcRnNwvg1Xg6zmjZTlurnlV7GPGtJeX2nqMyH
 XzW3Pz1abUbwEz1YcblqZhgBbPyi7SXlx4c7aQepLA1dcEWW2VbVUafCMzBcwxac7lW4
 rm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971235; x=1784576035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fva3fNs5KHsr7s0cnZc7nNvHW+HXrMU/GnXk6nCiZ1U=;
 b=EgIlozsKM1AGBtwrrXAhKg8KFSUGnNiQa1MqDXK/PeFCsd3QbiUwtcJ+RjLka+JcQa
 W+Xb0s0AOGGOkA9Tyev4LLvkyu4w8/Qfx2biQrpmBD0G2SK+WY/YCE/o8GsxpdTwpBB1
 AUu3jSLk82VZcJIuU79G4hKesiPiFqtEpXC3yDFPUEidGTej8YWqkr43SWYFql8a1u8o
 lIwrT7IJGqNaakaHTXwouoxpJFBuoBGVOGbSVINOOEnafLMBEYnkklbdDHr+fPCcsUWt
 t8UYg+Tqu0temL0JvC3/k+sZGrRB+RNWE7LQyUsXukZr/w8spM4sOOZfrKR4WH7pbIcm
 SaCg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+LgU2+WVYDXW4ik+13L94WF6nPSfvzc6TSnMPPcwUI9FW2zQQLrLkStZsVcaKnqtL6o0NVe6M@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKTjLOMUE4NG3kXeQF7DZvv1tpixFQe08k32+71m0oW3NtMCpK
 /NHFegup5ldOOExLre/Aw8SgWoNQ9uknZDxcKe90Vf67/4A9RYibHVB6
X-Gm-Gg: AfdE7cntGcR36ZMZX9q/g9ifHnYENPjFtkUVlo//JVr74MdaWo9plW3cHXVRsX4O6Gj
 4v/wrm+AhHIQJUhyOBqHMtoZKbxlu3uIqJePxYn3hnDu3uMsVx9zjC6jngFfDk/uSWz4veCMUcB
 BfxgfVt6ecffwGIvmcFilLYBUBcgcSEs6yBd6bmX3uOeFvgWCnTuyQuEqsYAuYXyKtbK+3vLYtW
 OcTMKrvvTWJWPHLVol+BLCCiGZiXTWcUwQVddRY2Gf0Tj1ewCt6A1ldnOSUeUFNRxGNH+0iwVmq
 2mEXkcPBUN+fCgxd7nx4gxpuwpUyVMmsRPavZaj1bq33d2W5P600xOU1WfXjJ6kwtbOlEJjPaoP
 /AAKSkYqJmMmR02gvj0c06qRaPn29GFmafdVY+ZiwulCzoCd4y0KOL/dcf4Sxb818/jwCj/g+bc
 2BWI4Kr1UZTWALse7gR7YCSYS1oHWb
X-Received: by 2002:a05:6000:24c9:b0:47a:1f6b:ddb8 with SMTP id
 ffacd0b85a97d-47f2dcf4294mr12197284f8f.39.1783971235502; 
 Mon, 13 Jul 2026 12:33:55 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0d9sm1912993f8f.2.2026.07.13.12.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 12:33:55 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count() instead of
 raw extensions
Date: Mon, 13 Jul 2026 21:32:37 +0200
Message-ID: <20260713193237.2639-3-timo.proemer04@gmail.com>
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

Instead of manually calculating the EDID block count by reading the
extensions field from the raw edid structure (`edid->extensions + 1`),
utilize the core DRM helper `drm_edid_block_count()`.

This now includes possible HF-EEODB extension blocks, which are not
included in `edid->extensions` and were previously truncated with the
`memmove`.

Signed-off-by: Timo Prömer <timo.proemer04@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c6f94eb71..d6d6ea719 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1160,6 +1160,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	struct drm_connector *connector = &aconnector->base;
 	struct i2c_adapter *ddc;
 	int retry = 25;
+	int block_count;
 	enum dc_edid_status edid_status = EDID_NO_RESPONSE;
 	const struct drm_edid *drm_edid;
 	const struct edid *edid;
@@ -1201,11 +1202,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
 			continue;
 
 		edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
-		if (!edid ||
-		    edid->extensions >= sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
+		if (!edid)
 			return EDID_BAD_INPUT;
 
-		sink->dc_edid.length = EDID_LENGTH * (edid->extensions + 1);
+		block_count = drm_edid_block_count(drm_edid);
+
+		if (block_count > sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
+			return EDID_BAD_INPUT;
+
+		sink->dc_edid.length = EDID_LENGTH * block_count;
 		memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_edid.length);
 
 		/* We don't need the original edid anymore */
-- 
2.55.0

