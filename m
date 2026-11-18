Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE21606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aPjmoR59
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4F610FCEC;
	Wed, 18 Nov 2026 13:51:04 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3CE10FB9C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:37 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so9374705e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003716; x=1795608516;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SjNyonqAa0eE7Fx/cbQ4HwCRl3zwHsHy92B2Dcu4U+k=;
 b=aPjmoR597ZpGIS+0Hrn1NQ0KWozAsrCvleXqw1WEh5x74ENyX3zdQE8qrUNiySnKQT
 xohM81wmf0hwgVgboDCDrrEuhDZsJcD8y77lyD/GDfrmMMkvtkSiabzJQSXuhOnQnPqo
 k/Mf/8TuvNy9gPUnhZis6xEAM3u3L4oeT/uZFjT3WfZ1ZhOp7baWdhtePJ+t5xFOS+tm
 t+SDgvfHIBqUm5OjaFXePfzzShxiqBGIY/ffGLwsHyuxUiV+27UbJVFEjPCyqTGyPffM
 aXknWEYmVm67xNDmurLLnyc3G+d05eSDcNKC/ahObJcqtOseOMw/lukbewLn0lYoqkTu
 /nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003716; x=1795608516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SjNyonqAa0eE7Fx/cbQ4HwCRl3zwHsHy92B2Dcu4U+k=;
 b=fp2BynhheOUE+C2varQZF5tHNr8kywQvK3yBFKC3hPQSFdGwajL/ufBHcJMxco2x8F
 cYBCllFNl0FhJ5oh1+ugWzUjLVBXYCUpUztcPTs4N6taujvE+sVyMWUJaUkY1kbz+np/
 aa24tpPjuUvnS4WpsMtuT6TQBxsfkWrwynvDSBjdpyQE7B2gzb1PaVY4owpULXVU/kmo
 RnsrDAoSfKE34LygB2dAwFHVMs28sp6xRSFHkD0rirmkfUOU4m8o1sK4UWvlrAcpW7nS
 nc371+RjqvNOjj2rHWJ8//MYlZH/iGsUbqLsN0WGLM3ZOlAcLL8EWBkWtT/dBI5yUvQq
 wCaA==
X-Forwarded-Encrypted: i=1;
 AL+hErExcaA2FtG5l9cgs4A0r9m47zShvIcqgiazyaswGPyEcLa8Ny/lBRxIblXZYBxNM1j0yDmbUsg4@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9e72UXdta5Jl77ntDVNOWjMYpma7y8jhSk5qYc94Dm1mS+BUey
 EutP6NU+Y7phLorJmoQOyG9Xsv7/awTO2qS4cKhHOc7tdoCw0u0arqVPs6rE7LiFd8s=
X-Gm-Gg: AYBFou0fBzSz46bjVXPMil/Dkd+T7qV1+n3Cjzzm8HyEV1tFE9ZkLOv4o3dnTvTCAaJ
 eOCsaT3JBcKUnhVooEG6bfUwESv2HzT3uyMOVe6ovw4pF8lLPhTy4Dm9cj7LPGPpObj+EJ1XGbs
 uIYSPNv98gt5LNo/ZXgdRw7SfPZ07BOfDX6kDTKEBCdgft6sTRvy6qQVJyYb73kPY5N265XQppV
 PJkoG1s6JMMtDeSnrO/7QYgRNF7LDxqtrAEQa2XYHO8AV9TVe2V1cHXUTkog8OmEh90Jy7oOj6X
 Vn7YfZVT6zI40G1HIX9HUtlMZjL/n4FMhEc/4Is8p0SU9yFEQ0Ym3N5LsbnqkbPB9DKOF5Cmxdo
 phiQzr597E6mmti8S1uq/O/wuCaEs4cZ4JkCH0PY/+1XqbE2chvLmHHwHsBgsrxn4ui3DL10nb1
 C08YVA0uhB9xHiCnKQIZfREtGB9jH6iB0RbQ4dYK2SBphK+yOwnf1vPmSiz+tEm2KEjMgBEbH1N
 bea5fDQei5HbNG5nl18+sVnPuZDeQJGA1Pj8czTKBrYs76cfti2AEFveCZFPNCz+/NIy+ylvC1e
 b78h0/SKUduFj8apPTrloR1tZWbzZCXA0BD6AWd/C8H+wmOM+S8gxpv087Pa/jMvMtxfaq3Oag6
 6NpJUr84IiIHNVJjGEmTD8wAXJ3ti3NcMdvTo
X-Received: by 2002:a05:600c:1d0f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb7da349e2mr45108555e9.23.1795003716150; 
 Wed, 18 Nov 2026 04:08:36 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb783f8154sm152043755e9.4.2026.11.18.04.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:35 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>, Hugo Sales <hugo@hsal.es>,
 Wentao Liang <vulab@iscas.ac.cn>, Zhigang Luo <Zhigang.Luo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 1/9] drm/amdgpu: Use named initializer for acpi_device_id
 array
Date: Wed, 18 Nov 2026 13:08:08 +0100
Message-ID: <cfcf58f6b8db7fb0c16af561d88392ded6b90eed.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=ft4/rQdu1reKvgKzxrhOmRdN8khYNFEACBZQSNlOECo=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZUqx7zRoE1U/CjdK6gW/uFoej0jZtQ514rvH
 Y4soQkxgHKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VKgAKCRCPgPtYfRL+
 TvqKB/97EpSLsgyWyjP60niPUZXPhxY+yNQ0hauypRH8ipaVtk//TURgf1RIWnZMvCharRF6kwd
 Pzdc/HLFchkMd9Gu6EQ3z0CLlHC8hKqJNMIYCXiDVXB/6Qdu71zACkVF0v5C9xFjWXIEkkeiW+d
 Fn6c/Jj9M3D73qb1ycxy5HbLvlhzAfJCJ0XfYBEa5ULg48NPCIgGnwRWe7KwYYJ/livSbuqmuxo
 sju/HBd6ocNUpkA5v0AHhEkXVnB3gJDpdF8wBDqWoJhC7Lc8HsoMUbVi4fC0HDEzR/aw2bes1Wm
 ZpW+htrkPaKtNzD3PlfW3L5s2gk/G1v03kc1PB5Ou8ibj/0J
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:51:03 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Named initializers are better readable and more robust to changes of the
struct definition. This change isn't needed for the planned change to
struct acpi_device_id replacing .driver_data by an anonymous union but
aligns this driver to the common style to define such arrays.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4874ee864b80..9175680b6a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1729,7 +1729,7 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 
 #if IS_ENABLED(CONFIG_DRM_AMD_ISP)
 static const struct acpi_device_id isp_sensor_ids[] = {
-	{ "OMNI5C10" },
+	{ .id = "OMNI5C10" },
 	{ }
 };
 
-- 
2.56.0.rc1

