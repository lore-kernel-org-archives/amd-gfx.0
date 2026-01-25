Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EB2C88E77
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C4510E3CE;
	Mon, 26 Jan 2026 08:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kz+Q1U+n";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF92610E1DC
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:23 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64ce9d80429so603960a12.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366362; x=1769971162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYketr3ZUeHaXFKK2N5/f0hDOcHB6O4IFG/ShrYM/tw=;
 b=kz+Q1U+nVyRotARaGQLCubv02JWg6kCsG1Mp1xfcJglMBjvqpMMQwOh8uaJlbPOLxp
 /wkwxvRx++LYMvVvktSKhRdRQ5XC9ezNgtXxHp4VpmacJhGrsOEulLszPF9cZeGDT8NC
 0jeLqrPVt1nPVYpajEw1s4oEisR/qk6g3rsKnug1EnFFPlrucKaS46O1QHxg9u4KdSyD
 tBzWem55lZZi/5NpNA9hiiGt/ZuEb0gzswDPIN+lx1hJXMBEt8hsbiveuLYy3yCDBkRc
 h7vD7UCJJZDs1+DURF5PtEXJGhSTCvjX9hpbA/xR94QpWpgStglPoVN97m7LOObYZLjx
 TmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366362; x=1769971162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BYketr3ZUeHaXFKK2N5/f0hDOcHB6O4IFG/ShrYM/tw=;
 b=pDGoPj6QFykUbBCceruFa9RSoxPVI3rA6YhqqnsVBmCMyPqp5f0eZa5f4EDyaaSj4M
 YHwErHaGe62Y8mRYZLc9drcyLz3gXRsza6OQ66EYzx7mZNaQI+zB7xTAmHs3iOHT+E9y
 2jrgaGF79I9fpu9m0NxxqCXghkhPofQi+mXHw5S2TCqKJmSeAO7PZd+kbAkYlZx9+Z7c
 r6Sui2Cn+VuliodbYxLN32qMIxfBrV9zrpxC766nsMwIKAr/rtn6SL/iHUQNE051B7c8
 z5/ySGJ7dcnAQvWrzNhomLk9PZS28XW4FfcoeBAEc5vtRCgHHQzdUCNb1pyHgJ3XQppp
 ubbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEmLcPT7hKLV3rpws4R96ctthLHbGEVpWXPKeAJvqoprT3ByE8riwzz/HqjMQ7BZxisAO7K9bJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFxdp05gwhCg7jVcQiVAbrdNoY8RZfsKNwxmXvD2PHXDodwj6L
 uTV5hL0/znJHJVgC0mSKbUqs0i6odCV9bbgvQ5wZ0NkZHzcNtiIwmBze
X-Gm-Gg: AZuq6aIKsAk7Y5JQLad3k79ZvsdWda01la6LsKmU7hW4gqpsXeC3r0lc9ouwCP6v3i9
 zMQ1ial6a5oWAqSPKT6/o1a8qi8LueJLCHvyRLpAM308PYyc4y88y8VBqHffBtVe6w0k97eFJVb
 dkZP2C/CEyQQHsq547xmQ+CZiq00U0HIg9mSfTIl5ffrXf+k5sV9GaCIPAxpssEAOK8y2IGANe7
 V44+YD+vvj01fnAA6RrOCDuIrV/5qM2VDQQXfleVqlHKW8mKEhJ7vl/bWkHLsf9JlFJP1wj5one
 U/ta83VhKXWnJc3+c7tZdGj/9wAswMtVAmJAB/j++C4TcBgS2D61bCKE4dHtPNtT5/ui5zPvFr7
 e8NnzqpYvjxyAX2n3B1qEjITYRjpJSovb4+fpbiDpEMLphy4U+HU78qCpN0Oqgt8L/U2BB533Gs
 ymlxFIBBW6Dbt401X2fi33+iTNqRYYolCrTGcG59nmpJmoictAWZOqjoEeBW1vkQDTIm+AlE7NZ
 dw=
X-Received: by 2002:a05:6402:4408:b0:64d:4149:4923 with SMTP id
 4fb4d7f45d1cf-658706b2726mr914635a12.1.1769366362315; 
 Sun, 25 Jan 2026 10:39:22 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:22 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 04/19] drm/amd/display: Use bigger VRR range if found in
 AMD vsdb
Date: Sun, 25 Jan 2026 19:38:59 +0100
Message-ID: <20260125183914.459228-5-tomasz.pakula.oficjalny@gmail.com>
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
Some monitors only expose their full VRR range in AMD vsdb for some
reason.

[How]
Compare exposed ranges and use the bigger one.

This check could be merged with the previous one but it's better to keep
them separate to easily convey their meaning.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4177
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4f4d6ba09c3..68a59275dead 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13221,6 +13221,18 @@ static bool copy_range_to_amdgpu_connector(struct drm_connector *conn)
 	return is_freesync_capable(range);
 }
 
+/*
+ * Returns true if range from AMD vsdb is bigger
+ */
+static bool compare_ranges(struct drm_connector *conn,
+			   struct amdgpu_hdmi_vsdb_info *vsdb)
+{
+	struct drm_monitor_range_info *range = &conn->display_info.monitor_range;
+
+	return (vsdb->max_refresh_rate_hz - vsdb->min_refresh_rate_hz) >
+	       (range->max_vfreq - range->min_vfreq);
+}
+
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
@@ -13294,6 +13306,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		if (valid_vsdb_cea && is_monitor_range_invalid(connector))
 			monitor_range_from_vsdb(connector, &vsdb_info);
 
+		/* Use bigger range if found in AMD vsdb */
+		if (valid_vsdb_cea && compare_ranges(connector, &vsdb_info))
+			monitor_range_from_vsdb(connector, &vsdb_info);
+
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
 
-- 
2.52.0

