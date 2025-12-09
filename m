Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDFDD3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA1D10E263;
	Wed, 10 Dec 2025 09:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXRzkvk2";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3E510E5FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:11:14 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64312565c8dso1049620a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Dec 2025 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765321873; x=1765926673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5bvlkQgBf0Klbd4bST8v6SvgBS5PIAV+ovqu2FOMRl4=;
 b=cXRzkvk2U4VnuGzFnQSbZga66sJdvLA9cmHihG3k44Fjt5ZpDG9Cm1a2hv3UD1KBmF
 xlkUZ+Ds9r7jlftZE4z3ZFDBoous3FTt032OhPfOFv2R8tQ9eM5ZXIbC3flx4aTGP9Td
 GJV7ttGCK1BVtjZk71Skx/jdL54L9mC19AGAsYyef+udJ3672nqwQE/+zy9bdH6dLd3e
 Q7l0q8Nja3W6kIBNtK5IB6mlM1+h3occ3Ucf2/qjO8dAp5ZSTX+zGsInwyEP+7Ixzwkq
 4pUpZBq59MhArHYMvwI8mnvccCA+RDkPh3P6n7Nmd8zoTEQ1tMz+mJiDqh0ham2X5AR9
 M8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765321873; x=1765926673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bvlkQgBf0Klbd4bST8v6SvgBS5PIAV+ovqu2FOMRl4=;
 b=UJHV9Y/HsAVvs1wRh25MlxWytHWKz+ysTrEkt+Kc/YB/t2SzVcr3H7K/kKzmFhBtL8
 HbZCODKUTLCWNI711zNQ0nnNn6oDfCU9nGSzcj8KyJEeuiA24rtGH/Mpnh5S44aSs1qz
 m2yX8BABJXYLSSb2kSKYbqsGNsHVIHUjgKEZ8IGiprVYar2s3zro6FLyQOn8hcjRJiio
 xqkrEg7lPgNN95y1fWMTeb4O+PdKY6jaWUY6gGY5F2M1647bjjugw6NQQnWz9lPeENp+
 tu/9BSXCQzgucuL5A6xoSnbH4R4p05FqJX+Qnc171iB1dLLZKlNS6OoTINUcEukR8VQ+
 uLXg==
X-Gm-Message-State: AOJu0YwJQWzEvyJHqQAajuCeCDk6irkG0GFPJFygYitNY2amFTHwlm7e
 de7WIUscDxFLT/syX41GyIBPwT9f1VBTdK9VeAS4FmwrPsyjuVEpHe/9XVJOPA==
X-Gm-Gg: AY/fxX7NQ1mAaZUMGeB9WM005W0A3N7Mo89lwrKCMfZMMNNJtu5+SOzI2lLrPkHkKf9
 NJRuHzkFKMYBO83zgltMEM7KjIpRYjB7ZA/vYvoQd0mte5b/No9D17ZEMcX34TOejX626eNWmqq
 radkZaXZa6gr0/dKtEsnyIrmGxCe3PN9cNcb/O9wGgsc0ocC4XMCQ0HW7EN8SzeZjRoNFQvCEqL
 +8ltP6vfImy75KD28hKGrRLaZF917wfSJw6OmQhlkOZwLkwiNAMeXUE8B/tNYzJoZwCVrNgglTF
 vEswRmctGG0/kWPXZVg9X2W7UQm1yZSlcTdW8FjWqsryvGnBkWSnAt5lcCPXHxvjWbYe2aNKzUb
 mgKhlDKoHl3LKTjsFFdeU4pdq944HEmKCIDs66UbPkehha/9y6YhZGLASNlNUbd+0p3meezBEDF
 fm3Zos9X2LerpCyjggSeFKsxc7SDZVI5Bg0fBshrgvz+8vlYi6jkyJeDOTSEd5tr+P
X-Google-Smtp-Source: AGHT+IF4MMpo6aoluEsvGMB3B++HZt9igudP6UkJlZi+dSp0HGnBWBvh8O3QbX3yG2bRSRZg/ek+OQ==
X-Received: by 2002:a05:6402:5215:b0:640:abd5:864f with SMTP id
 4fb4d7f45d1cf-6496d1d67eemr312417a12.4.1765321872782; 
 Tue, 09 Dec 2025 15:11:12 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b368dc2asm14498496a12.20.2025.12.09.15.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 15:11:12 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: Add CH7218 PCON to the VRR whitelist
Date: Wed, 10 Dec 2025 00:11:07 +0100
Message-ID: <20251209231107.1968472-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Dec 2025 09:16:53 +0000
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

From: Tomasz Pakuła <forest10pl@gmail.com>

Chrontel CH7218 found in Ugreen DP -> HDMI 2.1 adapter (model 85564)
works perfectly with VRR after testing. VRR and FreeSync compatibility
is explicitly advertised as a feature so it's addition is a formality.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d0f770dd0a95..f01f30a245ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1374,6 +1374,7 @@ static bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
 	case DP_BRANCH_DEVICE_ID_0060AD:
 	case DP_BRANCH_DEVICE_ID_00E04C:
 	case DP_BRANCH_DEVICE_ID_90CC24:
+	case DP_BRANCH_DEVICE_ID_2B02F0:
 		ret_val = true;
 		break;
 	default:
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

