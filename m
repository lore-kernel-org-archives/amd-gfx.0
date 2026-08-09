Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DDFC5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0014E10E6C8;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GW753bvW";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C67410E11F
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:54 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso852651a91.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286814; x=1786891614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbPrDMI/UNfpgAnDfLZbZKEr3Nfo6jVgSwQlTScmMqI=;
 b=GW753bvWm0c5Jl5CIkCusAWMTsNVKBUSgwzyw0oIByp1EXQrHEN/75C5XdhkDv4yJB
 woex/IiCjKBB0vfow6h7aFJ6/oAMZDP7EPRPblLgcm99qB8fe3+Z4P2wUgqpDHMsZ6Lb
 xsG3TcPmj5C8QaGl94zLsOJTPAtPonOWEPK4lO9KkPAWK6dANq1a1luMTq5wbJkOjyJB
 FdzMgNGTFSG7IZuIcLVEaywV7jfBqDxaIHDsRxi1kkqrsnvvtqNIvr6mZ5ofzNHJ6z0Z
 /T/lDJElxk4Y6iEKwj2VuLjQ2Las96DjjaFKWUqRidYxwjy9guncmzJz02a0oldX0T+c
 Fa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286814; x=1786891614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbPrDMI/UNfpgAnDfLZbZKEr3Nfo6jVgSwQlTScmMqI=;
 b=i9WwlKDDPwYzeJouFYHhQpXsiMX9CLVsmHoGzS0h4g9B2edQ0nFVWz/CeJnoVS4tK5
 kTnLT9i/zzTYXcHKUGLalabQDQWdXKG8r34w3NIDd1pinzVGVfGZvn70AxeZGrXCjw+t
 fsvuQilBhGi259E3fkI8kh8hQXgroOjvllALT6hb4Bcb7IA2FPaqI1m5p5ltxyOlVbEB
 gXC7gA5wuBbdcAgGMkLLh4qjFdrWhn83qs5CIXvt4lGvFs/4cgFJ22hQ8DkT/OEBuTCS
 j+Y/al6PHkeQMk6dojEna5Fwjn8pTyXrZa67Eu8NXtjiCKK+ledzICV13c+gdIJ0JxJ8
 7R6A==
X-Gm-Message-State: AOJu0Ywr1pL9tLob9SNBJ0zKqGPqpR2JDVJht4A6M+AzpRqaM5q44yIG
 AGOdLcR4dC2y9zBFPlQrfkbBITgNqSdIsQNJHqHfSl8FgE3gdxsHukNk
X-Gm-Gg: AR+sD12Btcek+ekp/fehTQxF/m7/YHNKf/gNwxT8DVuV575tJvmIB9Axm1FJS8vu914
 UJhqrSEm4KW6TYwSeQDBZ6z4uYlNapa2hBtz0ZwllZ4lagYZY7BztEvWLdKDH0XcVQimRv7m3ym
 phYdAl3/Q9442qFri5lu/qYiAoHDrmkbxnm0ycM3rHtfN64m+kdnUsQky92S/hh0zJVF8I1KkCi
 gmeJmy5+ATBiZMbvNAef3Egj2CNBQ4LJqsVM7pWObfVJEkxOgD2uYnwB0ZVrT4T1DzpEjMNRvFI
 tpDnqPWPM/a4Az0eJowFO30OpoA+9GidUPj4urxx2SP4Irr5Xfe5s5A9RMDANS9O65GPMqddmgy
 /XazBH//I8+sdSnm/KBp4yt4f7vo867GzhUn8Bw5/5jCwy6l5Xymieb1vEPGfNXVnwfS0YvuNgY
 uahqiCsPBv5mlF90vA0KZIWKNu6fK21h9Ity1txPIQg/VtEoZKAli8qXBPQHlI1PRwgFffxOMTu
 LSVPfpwtoc=
X-Received: by 2002:a17:90b:4e8d:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3903c58ed40mr36373724a91.10.1786286813705; 
 Sun, 09 Aug 2026 07:46:53 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:53 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 3/4] drm/amdgpu/aca: Fix inverted validation logic and list
 cleanup
Date: Sun,  9 Aug 2026 14:44:50 +0000
Message-ID: <20260809144451.35431-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

"aca_handle_is_valid()" used inverted list-membership logic. It
returned false when "!list_empty(&handle->node)" was true, even though
a non-empty node indicates that the handle is currently registered. As
a result, registered handles were incorrectly considered invalid.

Fix "aca_handle_is_valid()" to verify that the handle is non-NULL, has a
valid mask, and is currently registered in the handle list.

Update "amdgpu_aca_get_error_data()" to reject invalid handles and
return 0 rather than "-EOPNOTSUPP". This allows global RAS queries to
safely skip non-ACA blocks without treating an unsupported block as an
error.

Additionally, use "list_del_init()" in "remove_aca_handle()" before
"aca_fini_error_cache()". Unlike "list_del()", which poisons the
removed node's pointers, "list_del_init()" reinitializes the node as an
empty list. This ensures that "aca_handle_is_valid()" recognizes the
handle as unregistered before its error cache is destroyed.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..d48f2c4d6c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 
 static bool aca_handle_is_valid(struct aca_handle *handle)
 {
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
+	return handle && handle->mask && !list_empty(&handle->node);
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
@@ -599,8 +596,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!handle || !err_data)
 		return -EINVAL;
 
-	if (aca_handle_is_valid(handle))
-		return -EOPNOTSUPP;
+	if (!aca_handle_is_valid(handle))
+		return 0;
 
 	if ((type < 0) || (!(BIT(type) & handle->mask)))
 		return  0;
@@ -716,9 +713,10 @@ static void remove_aca_handle(struct aca_handle *handle)
 {
 	struct aca_handle_manager *mgr = handle->mgr;
 
-	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
+	aca_fini_error_cache(handle);
+
 }
 
 static void remove_aca_sysfs(struct aca_handle *handle)
-- 
2.54.0

