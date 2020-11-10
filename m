Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A1C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4A620665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLlPJRNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4A620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894A389C61;
	Tue, 10 Nov 2020 19:35:45 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546BB89BE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:25 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id h62so4311523wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xcbh8O+/omHL2VrpacAkpBtVFmAXD+djrz0urDPaJVQ=;
 b=kLlPJRNgN1F9oKbujE00llAPCqrZ6ps66Ok/S6/KvHh1EKNq12UMi2auweIku5QZ+d
 kHgomKu/9dundePmvfQOGcT3iLzJpwwonRbLSzxLYarevW+J9jAwUduNxg5s+KKMBtIs
 zcB01rcJI9EQSfNlkP7Kz+lx5eGQyi7U35uMuSzgK4juZGPgYBVkN083Z3gQ4bksEj83
 MgScucPUFTtvTp6/SqtM/6ITyUMzS7vQsX78dK9WlKYUcs3TF+DG0c8eZ7hrua/sAJo9
 VGaE8FoAHbQc0tOPZbBtQxjA+q4Z91crPXwSM7Sol4f4JqTBUOx6t7l+5es/l4561Q/S
 pWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xcbh8O+/omHL2VrpacAkpBtVFmAXD+djrz0urDPaJVQ=;
 b=cnULe7zuOxHINL35IJRmdxwOpamgrc4hys2SUAiBEWOU1KCXeZZPGQUONe/SvEyWYy
 Q0768KB61vKBaKmzmdgDCaoAik3R7i8ln087ajwg4F9mbhR2N+Vn5B1gnHkJAKEDo32P
 9ze6sz9h9Qxwf6Kchc7z9u1ElUsIGR+E+7AxuvPRvZgDkm0ZJ25ZG4NMzbz8X5ii5Xkp
 uhG4TUB/2+GKR0oaGsUeNrPEJ0n8aKsV+xJHMqu+yfxu241dL+J3+RLFMhDqDnsrOFUR
 jnpMtQq4DEjkXusbiyQhHJYRlp+7hzopSdQrxhSFDQViqRVGTwcCRzKRYIi3TEBUgaRy
 SHug==
X-Gm-Message-State: AOAM530m+liJdI6EU0TmsMM9nkAkqdnZxjZtXt0EfTsAiWHJkYjOCiyu
 7DVL7DOmkOd6ZBaXA8ZjrRtJKg==
X-Google-Smtp-Source: ABdhPJySXqkInVonwaPMkRY18+5DoFvbk2WPycPngEhk3/UG/GnAcOrJjZVRxfz5s/HZF8WgP6SU7A==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr669038wmd.129.1605036683897; 
 Tue, 10 Nov 2020 11:31:23 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:23 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/30] drm/radeon/trinity_dpm: Remove some defined but never
 used arrays
Date: Tue, 10 Nov 2020 19:30:48 +0000
Message-Id: <20201110193112.988999-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi90cmluaXR5X2RwbS5jOjE0NjoxODogd2FybmluZzog4oCYdHJpbml0
eV9zeXNsc19kZWZhdWx04oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12
YXJpYWJsZT1dCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3RyaW5pdHlfZHBtLmM6MTMxOjE4OiB3
YXJuaW5nOiDigJh0cmluaXR5X21nY2dfc2hsc19kaXNhYmxl4oCZIGRlZmluZWQgYnV0IG5vdCB1
c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Ry
aW5pdHlfZHBtLmM6MTIwOjE4OiB3YXJuaW5nOiDigJh0cmluaXR5X21nY2dfc2hsc19lbmFibGXi
gJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KCkNjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvD
tm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi90cmluaXR5X2RwbS5jIHwgNDQgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQ0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdHJpbml0eV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vdHJpbml0eV9kcG0uYwppbmRleCA0ZDkzYjg0YWE3Mzk3Li5lMDA1YzE4YWFjMDBl
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3RyaW5pdHlfZHBtLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi90cmluaXR5X2RwbS5jCkBAIC0xMTYsNTUgKzExNiwxMSBA
QCBzdGF0aWMgY29uc3QgdTMyIHRyaW5pdHlfbWdjZ19zaGxzX2RlZmF1bHRbXSA9CiAJMHgwMDAw
OTIyMCwgMHgwMDA5MDAwOCwgMHhmZmZmZmZmZiwKIAkweDAwMDA5Mjk0LCAweDAwMDAwMDAwLCAw
eGZmZmZmZmZmCiB9OwotCi1zdGF0aWMgY29uc3QgdTMyIHRyaW5pdHlfbWdjZ19zaGxzX2VuYWJs
ZVtdID0KLXsKLQkvKiBSZWdpc3RlciwgVmFsdWUsIE1hc2sgKi8KLQkweDAwMDA4MDJjLCAweGMw
MDAwMDAwLCAweGZmZmZmZmZmLAotCTB4MDAwMDA4ZjgsIDB4MDAwMDAwMDAsIDB4ZmZmZmZmZmYs
Ci0JMHgwMDAwMDhmYywgMHgwMDAwMDAwMCwgMHgwMDAxMzNGRiwKLQkweDAwMDAwOGY4LCAweDAw
MDAwMDAxLCAweGZmZmZmZmZmLAotCTB4MDAwMDA4ZmMsIDB4MDAwMDAwMDAsIDB4RTAwQjAzRkMs
Ci0JMHgwMDAwOTE1MCwgMHg5Njk0NDIwMCwgMHhmZmZmZmZmZgotfTsKLQotc3RhdGljIGNvbnN0
IHUzMiB0cmluaXR5X21nY2dfc2hsc19kaXNhYmxlW10gPQotewotCS8qIFJlZ2lzdGVyLCBWYWx1
ZSwgTWFzayAqLwotCTB4MDAwMDgwMmMsIDB4YzAwMDAwMDAsIDB4ZmZmZmZmZmYsCi0JMHgwMDAw
OTE1MCwgMHgwMDYwMDAwMCwgMHhmZmZmZmZmZiwKLQkweDAwMDAwOGY4LCAweDAwMDAwMDAwLCAw
eGZmZmZmZmZmLAotCTB4MDAwMDA4ZmMsIDB4ZmZmZmZmZmYsIDB4MDAwMTMzRkYsCi0JMHgwMDAw
MDhmOCwgMHgwMDAwMDAwMSwgMHhmZmZmZmZmZiwKLQkweDAwMDAwOGZjLCAweGZmZmZmZmZmLCAw
eEUwMEIwM0ZDCi19OwogI2VuZGlmCiAKICNpZm5kZWYgVFJJTklUWV9TWVNMU19TRVFVRU5DRQog
I2RlZmluZSBUUklOSVRZX1NZU0xTX1NFUVVFTkNFICAxMDAKIAotc3RhdGljIGNvbnN0IHUzMiB0
cmluaXR5X3N5c2xzX2RlZmF1bHRbXSA9Ci17Ci0JLyogUmVnaXN0ZXIsIFZhbHVlLCBNYXNrICov
Ci0JMHgwMDAwNTVlOCwgMHgwMDAwMDAwMCwgMHhmZmZmZmZmZiwKLQkweDAwMDBkMGJjLCAweDAw
MDAwMDAwLCAweGZmZmZmZmZmLAotCTB4MDAwMGQ4YmMsIDB4MDAwMDAwMDAsIDB4ZmZmZmZmZmYs
Ci0JMHgwMDAwMTVjMCwgMHgwMDBjMTQwMSwgMHhmZmZmZmZmZiwKLQkweDAwMDAyNjRjLCAweDAw
MGMwNDAwLCAweGZmZmZmZmZmLAotCTB4MDAwMDI2NDgsIDB4MDAwYzA0MDAsIDB4ZmZmZmZmZmYs
Ci0JMHgwMDAwMjY1MCwgMHgwMDBjMDQwMCwgMHhmZmZmZmZmZiwKLQkweDAwMDAyMGI4LCAweDAw
MGMwNDAwLCAweGZmZmZmZmZmLAotCTB4MDAwMDIwYmMsIDB4MDAwYzA0MDAsIDB4ZmZmZmZmZmYs
Ci0JMHgwMDAwMjBjMCwgMHgwMDBjMGM4MCwgMHhmZmZmZmZmZiwKLQkweDAwMDBmNGEwLCAweDAw
MDAwMGMwLCAweGZmZmZmZmZmLAotCTB4MDAwMGY0YTQsIDB4MDA2ODBmZmYsIDB4ZmZmZmZmZmYs
Ci0JMHgwMDAwMmY1MCwgMHgwMDAwMDQwNCwgMHhmZmZmZmZmZiwKLQkweDAwMDAwNGM4LCAweDAw
MDAwMDAxLCAweGZmZmZmZmZmLAotCTB4MDAwMDY0MWMsIDB4MDAwMDAwMDAsIDB4ZmZmZmZmZmYs
Ci0JMHgwMDAwMGM3YywgMHgwMDAwMDAwMCwgMHhmZmZmZmZmZiwKLQkweDAwMDA2ZGZjLCAweDAw
MDAwMDAwLCAweGZmZmZmZmZmCi19OwotCiBzdGF0aWMgY29uc3QgdTMyIHRyaW5pdHlfc3lzbHNf
ZGlzYWJsZVtdID0KIHsKIAkvKiBSZWdpc3RlciwgVmFsdWUsIE1hc2sgKi8KLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
