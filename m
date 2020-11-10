Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051FDC63699
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F37F20678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXWEbmSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F37F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCF389CCB;
	Tue, 10 Nov 2020 19:35:53 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120FD89BE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:24 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 33so14003138wrl.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wRyVj7QwW9m8+QJhWlLMpTOCKbqNO9FAw2XMc+XmqfM=;
 b=VXWEbmSQdarwlsBZu0sGfm2zUAEFee1etW65JRLgltUoi+G+TEfeOZuvcOFOtETnCl
 BR5u0aCXUDMEWbkQM8dypexH5UgRgI4h6cG10ovPBfrlnJlxBhDfQdojqGQiEzWjkbv2
 IP4UAKUedp43K+i37H+yZhL1bcqhNEp8De6a/VguzFgKA4iokYZ+bFOl3qn9hbp8enbe
 wxHwYjyBP15UyrKgnwQGKu5uSOZB5y9CI009lwCVp0s83UX9oHeQM4fjPomRExZibnxt
 pPN7DIs/GidNsVTpHOIdaS1azDjBDcohEpKiQ8LdZDfycd5MpkEQCRUpk8za67UsVFxp
 D19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wRyVj7QwW9m8+QJhWlLMpTOCKbqNO9FAw2XMc+XmqfM=;
 b=m8Mv1nMt2otlKz9ctLzJ9xzZTB7FEmr7MPEIZE72t/If18lkzIxY0elpPu0ALfu690
 i9OAURUDskd6qiq+8NXzzPxB6SqKpoTfB57py/J40mwzUDQclWp6Oh3f06X0Ebd2HTZE
 d8W1kE1IwDOz34uzO6intGEy68njsGkrVjXpI6539maPDVe6cwFguUaGunYV4YRdCgMi
 nyF2nNgKlvZydVuF+Dxghjclc8+pHBwI71tgjKsvhlFQZR6ZUyZ50yO8jNfItTaEsqRf
 YwMXvozMZYeWAJa/RjwDdAGqMyCqoDXpAWau5faeQ7ztg23CxFsUe+HfKTPK4JKLL0Hg
 L3TA==
X-Gm-Message-State: AOAM531OPIKHHMu2QAzeUFBvaUJnLJRR56SJEBfQ8C9qCgC0FtGJiOXN
 cocyCRfW9ShmNd1je/h7Ti3LAg==
X-Google-Smtp-Source: ABdhPJwWshC2o53BvNhQdk0R+5cyozx2c9WuwgLipcJsRxBlRZ8RuYlhCvVs65g9PrFdKEC6fxWuCg==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr10100178wrw.130.1605036682691; 
 Tue, 10 Nov 2020 11:31:22 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:22 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/30] drm/radeon/cik: Remove set but unused variable
 'mc_shared_chmap'
Date: Tue, 10 Nov 2020 19:30:47 +0000
Message-Id: <20201110193112.988999-6-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9jaWsuYzogSW4gZnVuY3Rpb24g4oCYY2lrX2dwdV9pbml04oCZOgog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYzozMTgwOjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKA
mG1jX3NoYXJlZF9jaG1hcOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZh
cmlhYmxlXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6
ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQg
QWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlz
dHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8u
b3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMK
aW5kZXggNDQ5NGY5MTIyZmQ5MS4uYjk0ZTJlNjc4ZjI1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaWsuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jCkBA
IC0zMTc3LDcgKzMxNzcsNyBAQCBzdGF0aWMgdm9pZCBjaWtfc2V0dXBfcmIoc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYsCiBzdGF0aWMgdm9pZCBjaWtfZ3B1X2luaXQoc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYpCiB7CiAJdTMyIGdiX2FkZHJfY29uZmlnID0gUlJFRzMyKEdCX0FERFJfQ09O
RklHKTsKLQl1MzIgbWNfc2hhcmVkX2NobWFwLCBtY19hcmJfcmFtY2ZnOworCXUzMiBtY19hcmJf
cmFtY2ZnOwogCXUzMiBoZHBfaG9zdF9wYXRoX2NudGw7CiAJdTMyIHRtcDsKIAlpbnQgaSwgajsK
QEAgLTMyNzAsNyArMzI3MCw3IEBAIHN0YXRpYyB2b2lkIGNpa19ncHVfaW5pdChzdHJ1Y3QgcmFk
ZW9uX2RldmljZSAqcmRldikKIAogCVdSRUczMihCSUZfRkJfRU4sIEZCX1JFQURfRU4gfCBGQl9X
UklURV9FTik7CiAKLQltY19zaGFyZWRfY2htYXAgPSBSUkVHMzIoTUNfU0hBUkVEX0NITUFQKTsK
KwlSUkVHMzIoTUNfU0hBUkVEX0NITUFQKTsKIAltY19hcmJfcmFtY2ZnID0gUlJFRzMyKE1DX0FS
Ql9SQU1DRkcpOwogCiAJcmRldi0+Y29uZmlnLmNpay5udW1fdGlsZV9waXBlcyA9IHJkZXYtPmNv
bmZpZy5jaWsubWF4X3RpbGVfcGlwZXM7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
