Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7C606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jdpmM1JF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2853010F357;
	Tue, 27 Oct 2026 09:34:18 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E5710F148
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 20:36:53 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso27219595e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793047012; x=1793651812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NCTPq4rCLjOU9tU56KP+2bzUZdmxKJi8dy8plluOj+8=;
 b=jdpmM1JFRdfghpcGvMfAZ9itIy6xa1a2ikrukq9P3iQbG7bShEm/15swU0zAMznMhL
 TEDPv/TB02fkX26wwEnfmtmV5YdY60cmrSoBi2LucgKT1pL9xTnbtjQEvm190k0vFqpK
 VarPcq9ZfktGoIQst7FNFWxzLs0DGc1kvCGCsaYmMRJf7597mIjPbChEKqajq7WnHuLT
 3fmXm1vdSVjc+TWOXDRqgX+EK1/3FWEirKsxV9ExD2ElIZR0YHfZGfwCEwzrDkLw64dx
 aoyR73zTDDocJ6cwP2U6HoRwo7qlUvKOdbEEq7T8TE1qZAzsooBs03DDpNZibWWG/+gK
 SDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793047012; x=1793651812;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NCTPq4rCLjOU9tU56KP+2bzUZdmxKJi8dy8plluOj+8=;
 b=lkTPEeqrW2C++rG9US8DKvywO5Qz0QmwUF8mRfRg9EGZJtAb97LS4WZwrfv2rtxNwT
 QCO3RCyK4fZm7LrFMf8DfdobLjaWy1mA8fOHZb+SuaKBXi3SaMZ8RM6U2oO5i0o9G0Js
 G/B8LLJWc/ricieHoe0b8CV6pV93XKFLaIMiiqw9tBtfIf3tZ1Uza1CS3lsJx+hvPS9U
 4F/YoBdJE4LKj3nBF2aMJ+H1mQDCRBDSfmijS2QmQIl2SAuvs0vIiEu7Win/8IsUVpag
 F37nefV4VnWNFwZABCCWHnooHyJGRn7Zo8BBw7w0lRTD3x0jwqHsrjLXKsYAPr19T1lT
 Jv9Q==
X-Gm-Message-State: AFq9FYKzRuXTz3eLGqeLRsQqh/yd8yTu1UVMVA74zPArbCaRRpmAnVwy
 uVeWv8k3iHwQvgkW2YWPVXmEEYKpUvJglXvxOk4M5Y+GXR4CqAq4L+rRviWkwHbB5oI=
X-Gm-Gg: AYBFou12hrc9coeyUG8slSncuAEmNzvD2a9TwCjbxlEZQ1qPaaFzfvBTWrNWr4BtD7z
 jzl3FyJ8bHInY7iXr3w/HJZlp42edDP5t/EXB5Mrxy16UYZuZQE51VwXFAgkehg5D2M8nDXvLuj
 kiKCPweCjCJoemkn9Ck2aIcYoq9mFJ+9DhKnlSgifcSnwXiRs3j6JpyHThqpvXlCo2KmqG5p2a1
 aoN2daofkPph/EOrvGEL8LY7ek+DRgy3eAblumWHoH7lPs39c1SgsfZkBMj0+zw+/9juqdye/xs
 F6squRJi8g+HTsUQtrNh3gK1RTisvhJAXyeciqnS7ItD8TwpoVVp+ClgbSB8xPHUrqe+il8a+pM
 dZ26wTBVn/0hOEln0Ic7bxQNFX2mvM62jd7R0OI1O2yH/mpcd9Lg8KLK0NuLZgadMZQvTFmRDDD
 tFsfw0NKxQql6m2VbtYx6CU34Rv9dU+s8yuxPA2xE930aQuyxbceSaWu/i5P7wpGFwCurV7yNaY
 ORelzgxIMQRKSLVh3Csl0OSeDYDkqGTN5oK38qiPfUxxcW2OZNvEGGHryCHq+2UynbOJwXax+c5
 QNLeDakGqthhBQAiX7XKmB//WCRk88lQJvAaTq8aFIR4Vzub3p7sLCL0N+axs8dwVKv7i5isB7L
 nEafZvPvEP+UzdRMjl1ZF0Pk9kbg5I8llcOTSeOhWJuDDZkRDWQnMPsjH1Zr4iQBmIzocpuXz+D
 6xmV8vEAnknA677f59L6pQc8IrWHAUulYCqTsLDb7Wy+gDOQo87+PglWhx3fIdW32nUboic7XxA
 hqxJRifRHeS2VMuq2EvKEtYNcbO6UTpyw/3ec6r7aW3WYlran+jKzjxOIH38ajEQO1JwdDeJxZi
 IKmtb1tDSeA=
X-Received: by 2002:a05:600c:1909:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4a35ac95fa0mr139540185e9.16.1793047012059; 
 Mon, 26 Oct 2026 13:36:52 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm380680195e9.0.2026.10.26.13.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:36:51 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Fix DC scanout position handling
Date: Mon, 26 Oct 2026 21:36:19 +0100
Message-ID: <20261026203619.41601-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025084506.62881-1-erhan.bilgili@gmail.com>
References: <20261025084506.62881-1-erhan.bilgili@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:34:11 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The scanout position and vblank boundaries were decoded with a 13 bit
mask, but the hardware reports wider values. With VRR, the vertical
blank can be extended beyond 8191 lines, so the position gets
truncated. This results in wrong vblank timestamps.

Decode both values as 16 bit fields. No hardware generation uses the
upper bits for anything else.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Suggested-by: Michel Dänzer <michel.daenzer@mailbox.org>
Cc: stable@vger.kernel.org
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
v2: Decode both values as 16 bit fields (Michel).
    Point Fixes at the commit which introduced the 13 bit mask (Michel).

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0a8dd7241750..9ceb2921ccec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1784,15 +1784,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
 
 	/* Decode into vertical and horizontal scanout position. */
-	*vpos = position & 0x1fff;
-	*hpos = (position >> 16) & 0x1fff;
+	*vpos = lower_16_bits(position);
+	*hpos = upper_16_bits(position);
 
 	/* Valid vblank area boundaries from gpu retrieved? */
 	if (vbl > 0) {
 		/* Yes: Decode. */
 		ret |= DRM_SCANOUTPOS_ACCURATE;
-		vbl_start = vbl & 0x1fff;
-		vbl_end = (vbl >> 16) & 0x1fff;
+		vbl_start = lower_16_bits(vbl);
+		vbl_end = upper_16_bits(vbl);
 	} else {
 		/* No: Fake something reasonable which gives at least ok results. */
 		vbl_start = mode->crtc_vdisplay;
-- 
2.56.0

