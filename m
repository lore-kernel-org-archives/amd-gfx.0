Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84E8C88E6A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 07:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B767E10EBBC;
	Mon, 14 Sep 2026 07:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLZto3IQ";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADC910EB7C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 05:47:27 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2704591f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2026 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789364846; x=1789969646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjb+OYWz+/bKaY6AiNvmi3TeWvwlpKbGSDH/yB8xs0k=;
 b=LLZto3IQ0QFExUHxE6dboM1CfajU5828xlFT2KMrMA1iucaBQTqBAk2KxVy6vpuP1V
 FavuUyIO/uaVJ0/54xYPwi/Pl/zUHuFo5h3lS/CWYfaBTr3FTXHwqrDvewCTY+PczxSg
 uew8P+8acy04E8C6dwehx2S4NH9x22IUMifusDdiZBC59hWkNLgoziQVWOFwdMP5DulV
 YSvs+zmYFyaElIOg7S407YGD8MGwfqD3KoSdVzj/roJo7BTdLuFoihNNVEv/5hK1o8jR
 z6AKdh+ynkf+s8DJn1vKvA9lS1Y9DtzDjeza9hJoDLuOBgm3emHN5rHX2gTamamNkart
 9v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364846; x=1789969646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjb+OYWz+/bKaY6AiNvmi3TeWvwlpKbGSDH/yB8xs0k=;
 b=Vyh88zpKA4l3+scz3Xl7xKz7PsCvFPVgF9Bv5wGzGFhHGIIyiUbsrWhQV3GRmcrf9n
 F38wwLWlAlN2epI6HDVTJK6t+Yr4nMrfs3Ug0e65HhgNWIl8nKk8vrqJplC9stndoADF
 2R3OhEhvoZR1pk/MnNMX9vaJxBGKziFBnoLQqFq4BnzeoPeOVeTLxJfU/do28we+ngHS
 zgcMmLOQeIBV1S8n9r3RMfj3QPO+JtfHep9jc4OepErtsWLmCXnlldQsXRY0nkELDAEx
 IbiVil4pmYnk1lGAScBKdsKCjiX5KZd7UmbDYBpsHsEDAbmC5m8/Hgf0NCWwl1IsHQUv
 9ZtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeSgjlafPvWZPXK7HNRWBRAR4gWzu0Vv71NxNwAU/x2Y5W6qH38l/LcR7nDNssp4hXEhTa63WS@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbZdXmjyVaZLkHadlMPs1DF16PhwYikbOZnqaknj3NAro8grVG
 3+f7mNCM17//NCLvgOyFGrSP//x/WSC1XjZH25Tf6v47kfJ7kSDv73t8
X-Gm-Gg: AYBFou3WWAxlEsWTk6GUlLRkXeiNEr55oFoDr0oDU6TY/AMzkbe6qqHKNTXerMrGl6F
 uO6Z5BGJATdTUlWfjd++x8sTS0En9HGyCad3oqHvyO2jq+8Y8XWGItmMObRsVU1xvVExf9rJY6C
 j60lphiHhgKJ7hpZx4+p9ftDLxPjXkCIZZVSQc6zmHViYypxZyd0iGriIGA+t9GYLwvuaaiWLzm
 +M+0NljWs20H7Qod3iAfjEtuASPthMfTRjns4N3JR0oTYaZiJKmRJvJ9xCF8wpgEBVMGXMKb2Lc
 dDkeYrC6MK+rpEGxqGHVlLGX8NPh+MFG7vchRpMbaEEOxOQ+1BKNc7WPHYO16hT6W1gRCMKxGGk
 uSyC9Tba3k/f0T4wa0K/6+TUXIE+emtenAx+ggOylfX050s8k0SWZUYquUHhzqRKPtCrIbjsmPa
 yh2rr4sF3MZoE3O6H/ewOaHx+xI7YVAaGgE0075zPoLsYuz+IwD7RESZMfx4IvIfTWRRp4hz6he
 uLqdS8k6cyBsq3J1RNn5AOaA4sBd3E7dlHR20ZRAfK1AVBBMpe9e49WzT3mZ+E8UgVE31g4UQY6
 NC9tDCo6/VVjmG/2+iikO83JFXthic8=
X-Received: by 2002:a05:6000:288e:b0:485:8c16:5efc with SMTP id
 ffacd0b85a97d-48702b31ab6mr934116f8f.54.1789364845667; 
 Sun, 13 Sep 2026 22:47:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm22609515f8f.10.2026.09.13.22.47.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 13 Sep 2026 22:47:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Initialize UALink handle uniqueness state
Date: Mon, 14 Sep 2026 07:46:04 +0200
Message-Id: <20260914054604.12850-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 07:29:45 +0000
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

amdgpu_generate_ualink_handle() continues when handle_lo is zero. For
accelerator ID 0, the random value can become zero after the low 10 bits
are cleared. This path reaches while (!unique) without assigning unique.

Clang's -Wconditional-uninitialized reports the read. A reduced
MemorySanitizer test reports use-of-uninitialized-value at the loop
condition.

If the uninitialized value ends the loop, handle 0 is inserted into
exp_xa while robj->ualink_handle_lo still says that the BO has no handle.
A later export can create another entry for the same BO.

Initialize unique to false so the zero-handle path repeats the loop.

Fixes: c67cb19811ec ("drm/amdgpu: Implement UALink handle export")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ab56420..c6b7122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1819,7 +1819,7 @@ static void amdgpu_ualink_npa_mm_fini(struct amdgpu_device *adev)
 static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
 				   struct amdgpu_ualink_handle *handle)
 {
-	bool unique;
+	bool unique = false;
 
 	do {
 		handle->handle_lo = get_random_u64();
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
-- 
2.53.0

