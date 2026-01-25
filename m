Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFC0C88E6B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAFD10E3CC;
	Mon, 26 Jan 2026 08:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="chiJJnCS";
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3ACB10E207
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:22 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b8862767cf2so34948166b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366361; x=1769971161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okuaC9cSCyDBA7bzGCWZ+ETvX0Mn/dMS3C4bf64Lnn4=;
 b=chiJJnCSEd640CeDstxWKfX5B3rEn7GfaM5VmzOYGXrqrPbbQFk2532KrR0AbBMDbs
 Eqg7tzHD+dvWW+TcJBk0jVY+eGmmRwZdCSuVfODnGOvpqnkJjxIr/0wRxXuIN9MtMRmv
 U4XhQirfHz+g8+1SSoe/NupC5X2jVEMrxR7kflLrbUCRj47yK4HyxIoERDbL7znOepmB
 IOyhkx9js0iq9quHP33xs07mi2ISSlaG11LQx6D4v1dYQY1ZZjk5AlGjpho643PymMaC
 PQrrIgUz9VQqXdJfLuLeBeuIC2EusOLyBOOrFvpDFUB/xKiH5iC/CmXEa3g0dWkvipev
 0dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366361; x=1769971161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=okuaC9cSCyDBA7bzGCWZ+ETvX0Mn/dMS3C4bf64Lnn4=;
 b=O4GG8ShyjBZ73xmNATVU5hKhlG/PpKY8SqLp0fHsWHMDMpVEEJT75Er6jmiGbaQtI5
 J4oibZHNW7v9TXDBuH4U/Sed3iwLEA9JKgdVlGuP1Z3Sjp2T1BZZV/RN3ZUjrgXgPzAX
 iDdIJsXNZXTzTqIqCfmEmefHft6a0dpBGuRkkmCet/KWHJlfgWBjH8uyj5f2pbbbXpK7
 kPHdSMhKYUFKQ1PybLvX/vEEQTwwo2vylGde0zwbvHusrznXJKx+zl2A5zRkg2qL6LdS
 TQFx3z0HhdpcwRDwbClm4lcVX0Vo4SUXi6DTC2dw/7sPfcQRIh3JOV+VxAxwRkTXzsbm
 iNzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV975mW9QAoC2h1Ke8694O68O0otck3KG9KMS4uLADxwSn++rsuKVoXm1bndfAMT3ppfld0thKQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOlaYLTlF+oA8B1In7wrhd1z/6nL8J6g5Lw8RMrg7gXcXTdt3v
 VCXFx9k0rlqK73HL3nkfZPhlo3J/gqpMRE+AjMDE+OfipbsHv+3ynX4I
X-Gm-Gg: AZuq6aI5mbIhZoeIXTHBuS5APsMid4mrTQYk4qhzMPFeufw0UVNr8XAWFLee0OxU9on
 R+U9tnya4R/fSJyJnzqwfYDoNNnqR3cl7pgXkCoi2GH7HUYXTEaKNd5uNPI2CnE7Bcj1z3Z8GUO
 bUX8W66mJZbN3ZhjDGN5b/eA08Ox0F5LZk6YzF5bWpgczgxEuLcHpZpxqcw2kHQ0yPovyIdt60/
 g9BrzFBc3zpjHJgKpKaAxWzE/RSgsPDblSzKHszmDinCN7v0akQ6+J1S/wLQqIHkN+oKuNno0Pj
 jczwzXlnao92RPJ88jVzIMWltZWWcbw59IH/vh7Vv2b8qShowrYuGh3vlOwqnZxw2dp5l4zQz4m
 IbKjn7BZb8umFdpeWrfiGJOUIJNaKUqih9wY8OAkWu6q6ufF/c5bRJjIMModmzsDaKM9zcDKwzr
 frTJbE+ugxoh0ASJyxztQGal3kPyX/N/gp6nbWPInVusSoZrAFN+go1vzGAj4EASL7bcgXZFhSm
 T8=
X-Received: by 2002:a17:907:96a5:b0:b86:feb2:543 with SMTP id
 a640c23a62f3a-b8d4f709bd2mr71640866b.8.1769366361087; 
 Sun, 25 Jan 2026 10:39:21 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:20 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 03/19] drm/amd/display: Check for VRR range in CEA AMD vsdb
Date: Sun, 25 Jan 2026 19:38:58 +0100
Message-ID: <20260125183914.459228-4-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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

[Why]
Some monitors only expose GTF ranges (or others, without Range Limits
Only flag). This breaks VRR even though they have explicit FreeSync
support.

Currently, if monitor ranges were missing, amdgpu only searched for AMD
vsdb in DisplayID but many monitors have it in CEA, just like HDMI.

[How]
For DP and eDP connections, check for VRR ranges provided in AMD vendor-
specific data block if VRR range wasn't detected.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3894
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4457
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4747
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4856
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 77a903880543..e4f4d6ba09c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13287,6 +13287,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+		/*
+		 * Many monitors expose AMD vsdb in CAE even for DP and their
+		 * monitor ranges do not contain Range Limits Only flag
+		 */
+		if (valid_vsdb_cea && is_monitor_range_invalid(connector))
+			monitor_range_from_vsdb(connector, &vsdb_info);
 
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
-- 
2.52.0

