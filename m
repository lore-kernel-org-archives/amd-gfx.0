Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277ACC88E6F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A04F10E3D3;
	Mon, 26 Jan 2026 08:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YI7uEQCf";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53ABF10E1DC
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:20 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-658323d1c91so558868a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366359; x=1769971159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixilW5V8SChUNZnxz9Z374ZlFvo9s1J4AZCTC1xKE1c=;
 b=YI7uEQCfc/X2NSqCkr7tI9HlHpFGG6GXBIbfqW/NBXQndhibiSprp+YuGELygzvLsb
 JM/Q08bKcs9Cje83Kbw8c85oaJRo0fEMpCiGJqJ187SYanRfdAE0Zgw0Yul6FxPZXRZH
 hCdSxV4yNEI0VJWWiT6Viflh9RwoPvxx1M24G06S+JxSXLr7MbmnhHGL3I/r83gb/fsq
 eg38gA1+rCtHvLN/ahYFG01Z40REj8lSWhMzyiH2uCg0hSJJADhwLzOqwULTtSbMVwaf
 D4oZ4bxNBYZypK9GyFOOQjsfiYvGlgafTZvaMDpoatW1zG91jXgX4DdYJ80tOg6su45R
 xHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366359; x=1769971159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixilW5V8SChUNZnxz9Z374ZlFvo9s1J4AZCTC1xKE1c=;
 b=SXQ+cGxbc2o9xNGcCvBVKf0ueGhMTpESTMJH6a4VpBPi8Q+ulNk0iidpco/0Ha6Xmw
 GyRZIqBKhMyk0gFFPK6YYl+r8d3jFMGwB4ihT4M7ZM2GLQl9FLgOwR6IZOteUmKFncFF
 EVW+oll71vg8eHfMaAtrHUvcbXEErYWMReWUQHy6eXANjbf5sFtogi67vb1QqPe1zvp/
 8cML3CUvd2Hb+Xb1+SeX1ie+6bzFcWJhQrAN1lfjlXpkuF1TUIuG5cRxtg8EXb2f3OFG
 yv26lftiF0gITsaLw3i6XGO8p+cMRHfgo4PDIxzgwPSmwFR6B6xTqCz6LwnAP0kX/QPC
 n7lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQkyzGv7J3BsD4UDkWBz7CD3YK8d7zcJvTVrYji8Ygq+X6lcqiy1QIMgLsVRoJTVkrXA52H7at@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwWVakrXkHR501AxdKi6HMjRecqcpUCqiNl13vAgsWKqb2vbU4
 JortCHfnHO04mlEAFTw16b45LMMgYeCnay50xqtvk2qcNxjoVysgcGtN
X-Gm-Gg: AZuq6aIFjpeRAM3auLH9GgSFL5iOGDGxJg3OqY/KxV+dATh4hlkGMeEgJi3KltsBFv/
 RewTYJ+aMdwHKXFuTyUDcoNwnULBJB8UutoEUEfyRXoAbhK0bvcQM/FgWeoTBU3kcI41et7euNG
 mCwM7Jmpw3czZlywKw1j9/lw+ZNfcBeXSq6TOQwhLbSt51k6/Fnjy4fAcjRqeKFGYMhXlQu4w6H
 Oq9RrVd9sU/k5HzCOHnP9EB79zN90HcO7UMzkDBCoL7BcADzxZmTLM1Pmx8QIn1p+KsEoI8kzSd
 is7JC2w2n3QpDTTuf3DgGyiORW3gNknBptQbSFiVgF9hFJtSMVyl+KAp6zWCB7M6lr/CrOb9oqn
 eb5ry9/PD2SD+/IpRTjVqDdKgWCH53ze1Y4digemsuYfCk403kucDmDCCzcgpRsl8Vfswag4QiG
 Q7HSazOrNfs+IEfiBnbMdGgSYGuTjmABqAuUQk6NkdG9GsfFIqlzQV5fJbDXlj+Vot
X-Received: by 2002:a17:907:2d8f:b0:b83:95ca:22e1 with SMTP id
 a640c23a62f3a-b8d2e89ad06mr95678466b.1.1769366358426; 
 Sun, 25 Jan 2026 10:39:18 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:18 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 01/19] drm/amd/display: Return if DisplayID not found in
 parse_amd_vsdb()
Date: Sun, 25 Jan 2026 19:38:56 +0100
Message-ID: <20260125183914.459228-2-tomasz.pakula.oficjalny@gmail.com>
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
The function would continue to try to parse EDID even if DisplayID
extension block wasn't found. Sometimes it got lucky and found AMD vsdb
in CEA extension block which made debugging harder.

[How]
Add a return if DisplayID extension block wasn't found

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b4c45ac3c05..f01ddde1a50c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13115,6 +13115,9 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			break;
 	}
 
+	if (i == edid->extensions)
+		return false;
+
 	while (j < EDID_LENGTH - sizeof(struct amd_vsdb_block)) {
 		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
 		unsigned int ieeeId = (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_id[1] << 8) | (amd_vsdb->ieee_id[0]);
-- 
2.52.0

