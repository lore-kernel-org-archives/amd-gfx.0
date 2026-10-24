Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A2606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aH+cu90y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E2E10EC9A;
	Mon, 26 Oct 2026 08:43:36 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4E410E16B
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 19:43:50 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso19344355e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792871029; x=1793475829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zcRMNk6Km2+f/eIsw3TvKgPJtaos1DKBxa94XnGJZaE=;
 b=aH+cu90y8Dg0DZZnB0wSLrgqx9AsTcxt5Q/LlnsvtmGKhe72IKZISumvYEsSF9Z1Ww
 WB+jCPbbnSXou2YsfNfksUWSahA1poIf0mwPQGUHJokzOm/ZL6W83gxU6+pWYtam+cro
 pwjs1QN6Ab0vefIPW3gAKYWmV2pHhVi/hJe3BKq5NcR3bLsMV1UkuyXLWiT+K4unD8rg
 dPkaiYuJrFUZ0tVlor+tGwQTHupqMRyQfjfT9JzkSsQEHr0wEuEpej1Si7Pd49DHHdDu
 pRZ9N40KI7CczF49rqPXMjpRu9qOohI3psQSpqbnvV3VsUDIasZ46LyMDsX3auK6S+ax
 4LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792871029; x=1793475829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcRMNk6Km2+f/eIsw3TvKgPJtaos1DKBxa94XnGJZaE=;
 b=v08zx5TtYHZWuL58e9kIyuSAJ9rBxdRlHMw/5aDjp4rHh5XFxsjQhEBeuscunwb3fG
 Xxopz9ppZPNlTmZHXJiYiSzmDGwoBofW64owrN2fMWuHH8lcWGIcmu4Mjx3uxZ0yu4uQ
 atAP35lJZZFWzUWI2dFCTDqWHlHDcLRuF/HlYIUskIrTN4xAtdtm9YqRxzkV6mqh0IYs
 8k8ZCLIcSglamGY8hrl02BN44N1/wcM7ggyAivLcJ25/rdrFpQULFIlk6CQNA7RPgtyc
 eKMGWq8WbOWRjVhBQg5iFrQqgbmSIJVHtRz2DflMvfiLCEkubeoSO6f5nxUT3v1j9iR0
 qwiA==
X-Gm-Message-State: AFq9FYKzaND8BRB6PjDFacncxPManJ/WOz5YKU+tPQh+/HYh/qoWMzBK
 K3wKsMKzVd2ZM/rVEmcDa4MV5wxbOPC4kxH9rJp7PsEE4/dNY0rQodD354ESsQ==
X-Gm-Gg: AYBFou2NA/928FPWriStebZcKh7NH3LMtyBzseMlkaCHQUzOj5viVK3eGIGlDGF+UUE
 Y6nS7oCYlYjBXSuwSUVpv+SL00xBWs34Nur1tnZfA9UDoq0Ouy+3XEGqRFT02TDWmI1iiIgUGIj
 NPQ95sACBGbsHqpnBrQJb/eED+NWB/iuSBaiJvVE1OfLA3LhQRoqhpURYVlp1tIdij1VHmA+aZw
 9Hm9CxCoos9W5xQWP8ypeQcA6D8zPrGrqs8CBlXdGGGGhAChOw4iwfBaY4fb8eTSK+NP0cyJHNV
 FqhWqYTqCGVCNPE6KIxrRo0XC6K+vFQQiOc4zevkcWSbJRXMNcbtaBrew9L2wKwhq1IqnwdHBpQ
 WdDGEf0RqX0i2iffPQasWnI7Eo36MUmShT70IiF7NkxF+UZ7kSni6kQO5XbZ+D2P9WBDTT9Gq6o
 Wu8CNfMayw9GjM/d9Snne1VaTxIYfT9uTbYwpcjPmrixiWdww/JNL+YTC2U8Tcs2iPvUUce1T8z
 uuJt8FYx75gPaJUd3UQ9ebhDAox7bGSAkZjBwwuj9JfQfg5HHUXxwHSDk/+qHKWb80UViQkLB2D
 EkElgN3Sq4DKoRI0+ijaQmQd20r2TfJP98CdOhZWUPva8ajmLrqRxUJRg6RohKrOYKy9vrOh4i+
 V4DmgK3YUvZJDhr8+mNxERwZDXfcF8LDkahv1mxIAP7Yeo2AknwmpXtGfTyu8Q86pYk90GN2T7Z
 fDCh/oHsaPXV/YWEqT5LpzXRSmTp8tWVk68uW/IZvONq8bTH79o1fvEoZuFBd6+WW2JQ7vHKrZ2
 frwpdPcDaRFzdkzhqqxJrGzwxy87GlfUas5iUBBpSxapUXnna1HSWcB8l8eF3MKlD3z5S/GM9gR
 1G4IW2KNCJKz4GdSq0yJ6Qn9eyMCp6Uv
X-Received: by 2002:a05:600c:4745:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4a35acbe714mr45419155e9.31.1792871028617; 
 Sat, 24 Oct 2026 12:43:48 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm6036995f8f.17.2026.10.24.12.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 12:43:48 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>
Subject: [PATCH] drm/amdgpu: Report MES ring wait timeouts.
Date: Sat, 24 Oct 2026 21:43:34 +0200
Message-ID: <20261024194334.305636-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Return -ETIMEDOUT when the fence wait before submission expires instead
of reporting success without submitting the packet.

Fixes: 34e087e8920e ("drm/amdgpu/mes: fix mes ring buffer overflow")

Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b2e4da70d208..674ef3260001 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -218,8 +218,11 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring,
 				      seq - ring->fence_drv.num_fences_mask,
 				      timeout);
-	if (r < 1)
+	if (r < 1) {
+		if (!r)
+			r = -ETIMEDOUT;
 		goto error_undo;
+	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ce577f49b630..e25d6018fd56 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -195,8 +195,11 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring,
 				      seq - ring->fence_drv.num_fences_mask,
 				      timeout);
-	if (r < 1)
+	if (r < 1) {
+		if (!r)
+			r = -ETIMEDOUT;
 		goto error_undo;
+	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
-- 
2.56.0

