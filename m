Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0054E68143
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A190510E478;
	Tue, 17 Feb 2026 08:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYhaPGOi";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8410E10E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:22 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8f947ea8easo25676666b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260321; x=1771865121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7wlOYuiBDSWiVWpYqNMTtfR05pQbGrwxiWFvefDzRE=;
 b=AYhaPGOisM/Eg7iu2henil1lOXQHDFYovU5GRv4sccQ93AOLa7Zx9Raj88aqMR2i2q
 LRM47EmvN2EI1YDHFVawp/eIT2i28iVMDtsDBWWM4/TLCJDR7YsWi2wTcauXtiFQCmei
 fnNDmOoim6EQLKH40E7PeaM4XYY2mRhz1PBP14GVTXkRwSjNo1zxBfeVh3C86Y3ylXqk
 ZGP2GVtBCJRY3NgXwVSMZ9n6k1IB2J+dBJOuo+T65Uq3OtQH/tF3AsaJmpBG5+D41AAW
 5wb1KdCdk/5W45ZEc1DgnJx51Dam0TlK/PghcqJn1xSZagpXfXsYlzurvNDWj8CVkDsE
 tprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260321; x=1771865121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7wlOYuiBDSWiVWpYqNMTtfR05pQbGrwxiWFvefDzRE=;
 b=UZGqvGBUeENdhSY8z1mkSDma71V0IgjT6Jusq+eJ8QFtNSJRIFgVpo//Rmu5OVqVlC
 X3j/oziEIjiwc5UpQUfVd05ViTSPPYbOIfSW6hXElIdhvPZp3/htJVTrS5PPEiDueona
 UCDc8WxJLMwoseR9cfMuqoOz33bo/stV4qRpojqIpRqJplZRRVYaWaaKEcc5vvdrN1MQ
 ebWXxMrpfuDqURf1zr7EjtK4Nxhd1UGE4nTXcyJGdF+bv8xkw2/9UqV8L2uy+0dpgpYV
 nyn8xoFdew76u9cgmc58G3ttm5V4vSJ3Pp5XizT9ky+ifuXz9NEKJJWIg7c7O90XBgn0
 zqeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkRC5hiw5vmQynblELzE8zrzHypTGYhfCDZ8GFl+YdCnPKxugoKIL3gba8gop8BVbw3BKI3zpf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMd7lDl5GhjMPb5DT73IaYcIQa3o4qMOjjHk+gr2DAQy6YUfiP
 EDxRWuVBlQ6f5s0T6s3JCgUD4EumXrkQFIzOorn4Rkhgb5uO2Gj8IbJJ
X-Gm-Gg: AZuq6aIAKl/e6KBpJvJsvMVsc3oyo463hMLJdh4O+kK6LZI/8XeuAq3XDDneO2LCgo2
 koDYrlNOAR+1GmWFE6mPpB31WBm7/lMCmEEoqfjJMfX3DguqW8/NOtNxikI0EC9Uvlv/sP2zaxQ
 Jxes6nJhnCSmwnATr5F/PPVIfsl0BHt5GcXRGeNnp5yM7lh2u27mu8+2tH22ABglqPrVOIXYWot
 bTI1XWIuC+mn1Av9ynYYAf825f076CfWZO+88Birl2jdy7xKXuov+zD7lWqz1K8aLVuf5GS+/U1
 IlN9iR/EBqWsrnu9tzROLNvf88zSpFnM8q0jZZVxb+ro+TkE6SaP8vZVu1MolwD1kCrIJPjs2Mu
 tP+bABL0YhKKX+r1Q5vgecN2whI58RWMwAkYD9VTK7IzzU6L6sgHxLzZ7reF/tGLSyDZeTVbsp7
 D5LJK4fYnRtUXrZKVsViSzQrQDjG6DABw1gRw98dxMcjxrbiHOdBzJcw4zpokgeK9PPMrSUjaoH
 nqBscQIz/qWTbI=
X-Received: by 2002:a17:906:6a24:b0:b87:3c3a:cb7e with SMTP id
 a640c23a62f3a-b8face00ea5mr368539266b.6.1771260320644; 
 Mon, 16 Feb 2026 08:45:20 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:20 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 01/27] drm/amd/display: Return if DisplayID not found in
 parse_amd_vsdb()
Date: Mon, 16 Feb 2026 17:44:50 +0100
Message-ID: <20260216164516.36803-2-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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
The function would continue to try to parse EDID even if DisplayID
extension block wasn't found. Sometimes it got lucky and found AMD vsdb
in CEA extension block which made debugging harder.

[How]
Add a return if DisplayID extension block wasn't found

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12bebdfd7fdc..2d770ed98871 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13162,6 +13162,9 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			break;
 	}
 
+	if (i == edid->extensions)
+		return false;
+
 	total_ext_block_len = EDID_LENGTH * edid->extensions;
 	while (j < total_ext_block_len - sizeof(struct amd_vsdb_block)) {
 		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
-- 
2.53.0

