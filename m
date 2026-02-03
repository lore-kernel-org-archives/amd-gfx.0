Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C77BE83EFF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8153E10E559;
	Wed,  4 Feb 2026 08:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMNrqY+H";
	dkim-atps=neutral
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C67E510E750
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:40 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-64b686e7d04so655051a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144999; x=1770749799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUEpNBWo+nSLTU4UotiQVijk+9VhpRak/nFSgqx/fMg=;
 b=cMNrqY+HAdW2QznRXBwnAoRK5Q7oxvCa/arGKX7xKzbFgi8PpHdSW1bfmSuWUViMxv
 HCiZuJs4RJv3bhdqaT+27yd9rc0aeDfT6XrWjv2lvIH7CbddeqwtOrsJnFHCIOt/Cipo
 6BjvY9n4UWdgXurBZV1SnGu2KTi+vsaP+BVMLG5R/9bltWmcJGdVZCqSteqxe/O7Yc1y
 FCY6uqY+NmXgYsPL4W5d8kHJ+sB3E/nUfoCrGKfCctcPxTxiJwq/wHxoth0JnVTP16P4
 Y55S2LPCZ5c9k9E9haTEO2Edk1I586WjTF+zeWCBoKCpN6ut0L9J0AmAN2s4iJjJLIOY
 U1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144999; x=1770749799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WUEpNBWo+nSLTU4UotiQVijk+9VhpRak/nFSgqx/fMg=;
 b=tlkd6RBmoRgQJfTLRjKTtd7ic9A0uMkOzTM8lufpq5IJ+2Vjf9C4e/a2HDz/MuNVoW
 N7etgwiAC4gHINZ2TKW6EbYe3CzBUeOuSBL93+wJmZR7eZ714Z9K89rVDNiZHgQhL+DT
 e/Ddg+E8A72E87HHH23BANfq9oOjjMeVMC6/Ey0g1pweEmMUaQU1n+W5S9PUld6pklrX
 xfZxz2hn9qn27V6PXitUzSe7k/nBUNy3K2mkABFRa4mqfoAjK8AEcPR2c+qk9Ji44Lgx
 3NhYYcwpmmJ/uvBqh+J8VVMDAY913ufA0fTfsQM09DCImQPJ+eZ0vgEmgKBJRuccDG3o
 1ojA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvZvrf9+uXgFFObMphd9PwtqReDSiC9wH+vf9YL4R6UEU6ede1hqgDFCaNRbirlEPbbc6oLJSS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjByPdGPz9gkdnX0tIaDrnv/KBVZIRu1DY+BMkXLP+05ENYOzH
 FXMnowe4qp4f535hc5qQFaUyNivyHels9TyBFsSRzK0m0bpmHek2Nd/G
X-Gm-Gg: AZuq6aKPzjaIkDYOWpv63+ZZy7Y9fFr91/jiaE6/HrDCGci5l5TWO1pKhP6gxomMCtW
 //wYnA9lU8nrUrNJtScqq8VA/Tk0tXtrACKKTLhdnNji9Y6Jq3S5vLxJnplFJImpyn4RUN3MW30
 pcgdSJidvjlMRP2v5IsRXrPJiHDvLrO6FAqxuna8VYbj0aFiqTXRG5CrvuK+g7WMj+HnrHGjmAj
 bPvJ2mZ5rKK7kpSmPGdhsqV0sQKcn0ttQ5s270HVf1iqxa4i7szUXHGcPk9xXfHhKz+633dN3QQ
 Ux0ETVebeewCIN5kyT5eh2ioFcT2KyRjYv+AtX7sNnf8cdq4u6aJKr3Hq0w8IOaLiuIXreGP96t
 P+bYumL5o0ufE0y907WTrJKjZJ51GVHAc4XzI1QUrzssZq/lvvSf/OYbdBBAWBgIyZLX5Bo+Ylk
 ITOgC4TqBOyXgaUqaEsCpoFDLnCZ/APHVoPjPQxUFBaRRFbyuzs5a2NoXYh28HkVKy
X-Received: by 2002:a17:907:960d:b0:b87:3087:54f0 with SMTP id
 a640c23a62f3a-b8e9f2f310fmr21821166b.3.1770144999082; 
 Tue, 03 Feb 2026 10:56:39 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:38 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 07/19] drm/amd/display: Add CH7218 PCON ID
Date: Tue,  3 Feb 2026 19:56:14 +0100
Message-ID: <20260203185626.55428-8-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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
Chrontel CH7218 found in Ugreen DP -> HDMI 2.1 adapter (model 85564)
works perfectly with VRR after testing. VRR and FreeSync compatibility
is explicitly advertised as a feature so it's addition is a formality.

Support FreeSync info packet passthrough and "generic" HDMI VRR.

[How]
Add CH7218's ID to dm_helpers_is_vrr_pcon_allowed()

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4773

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cb8a2855ac10..690558584a0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1396,6 +1396,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm
 	case DP_BRANCH_DEVICE_ID_0060AD:
 	case DP_BRANCH_DEVICE_ID_00E04C:
 	case DP_BRANCH_DEVICE_ID_90CC24:
+	case DP_BRANCH_DEVICE_ID_2B02F0:
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 1c603b12957f..e838f7c1269c 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -36,6 +36,7 @@
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
 #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
+#define DP_BRANCH_DEVICE_ID_2B02F0 0x2B02F0 /* Chrontel CH7218 */
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 
-- 
2.52.0

