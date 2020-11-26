Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37433C64E75
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C409B20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xos3Z235"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3906EBFB;
	Fri, 27 Nov 2020 10:15:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496846E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:42:51 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g14so2160587wrm.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vyYJASeUbOt9Oc/Vofw1C6Y2+olsU2h1O7WPPXgsjDg=;
 b=xos3Z235V+VsqrBuBxOR03HMkZts5GlDVhKuNYxI9eBaJOP4w0ktVn+uMzH1tBWjfk
 byRyaOCDL1JFpJGS8bPQ3Gi6wNGWUzMFVyKehbMjLq4XZbqs0e6Vm283fuy449VUhHzq
 uabcAfhlVvxLBGKuT0/noqU+UrE4hDCD5pYzsf2zGRAsSLuMznc4lmRy/MobItxFEMZ+
 c1yY6TvwQIkDcdCBuzNLnwbBm8Jafkhc2/BZcHMSVM+q8ReotyLF/vK9d2kPxvHNr41B
 N1ShZuoFxfdbMqOlyNx1t5DBsHrpLTTri54fYcWjr8GYnNnmxXQKBiip9id1VtEJySel
 XTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vyYJASeUbOt9Oc/Vofw1C6Y2+olsU2h1O7WPPXgsjDg=;
 b=SfiBYlJjF/KjE/nsfKZV3MCD/SoqrJJEI89cmmimjGXFI5SKNWJAxQ2rCsDT5hqeuC
 tffKFXCXK41e9MZhbwa05TFYIRpuISq05+/wXN6/uF98DgP44WiJGBcSunKnXG/NCrC1
 CfsfZMFN2KYs+kH8l7+hRG7MSieX8aIv+33HerkE500clnp4rRc1re/Zi5FxSXzChtLU
 lKqCjrVy8x/x/Wi1ngbqP+4jAmpCRawrbMwxbf9Zd1Aw7KJJmEba7PMQz4dLogsv+jGS
 Ypwi6hh8p+LfyjUUL0yBKtY/i0G4hqFrDXs+hi5slXvNPdFv6gFhEP+5KI0ILZkh6rE/
 i2gg==
X-Gm-Message-State: AOAM531Qejvjk56Z4uNOYv4PA0Sj22osRRsGGLkjlxf9+8N+VjN6AiF9
 mxjtT7EAT+WQWwRdvWAirX0ZUw==
X-Google-Smtp-Source: ABdhPJwy6UGg9LWLcuVO0V63+GZDcQf59k1mdkCRNCVnWDHjZvtq7Sh+KlwnjDdTmVs25uuCwWBEUA==
X-Received: by 2002:adf:902d:: with SMTP id h42mr3878260wrh.175.1606398169992; 
 Thu, 26 Nov 2020 05:42:49 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:48 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/40] drm/amd/pm/powerplay/smumgr/iceland_smumgr: Make
 function called by reference static
Date: Thu, 26 Nov 2020 13:42:04 +0000
Message-Id: <20201126134240.3214176-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9pY2VsYW5kX3NtdW1n
ci5jOjIwODU6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhpY2VsYW5k
X3RoZXJtYWxfc2V0dXBfZmFuX3RhYmxl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxheS9zbXVtZ3IvaWNlbGFuZF9zbXVt
Z3IuYzogSW4gZnVuY3Rpb24g4oCYaWNlbGFuZF90aGVybWFsX3NldHVwX2Zhbl90YWJsZeKAmToK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxheS9zbXVtZ3IvaWNlbGFu
ZF9zbXVtZ3IuYzoyMDkzOjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJlc+KAmSBzZXQgYnV0IG5v
dCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpT
aWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9pY2VsYW5kX3NtdW1nci5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL2ljZWxhbmRfc211
bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvaWNlbGFuZF9z
bXVtZ3IuYwppbmRleCA0MzFhZDJmZDM4ZGYxLi42YTBmNTgxZGU5OTliIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvaWNlbGFuZF9zbXVtZ3IuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvaWNlbGFuZF9zbXVt
Z3IuYwpAQCAtMjA4Miw3ICsyMDgyLDcgQEAgc3RhdGljIGludCBpY2VsYW5kX2luaXRfc21jX3Rh
YmxlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiAJcmV0dXJuIDA7CiB9CiAKLWludCBpY2VsYW5k
X3RoZXJtYWxfc2V0dXBfZmFuX3RhYmxlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCitzdGF0aWMg
aW50IGljZWxhbmRfdGhlcm1hbF9zZXR1cF9mYW5fdGFibGUoc3RydWN0IHBwX2h3bWdyICpod21n
cikKIHsKIAlzdHJ1Y3Qgc211N19zbXVtZ3IgKnNtdTdfZGF0YSA9IChzdHJ1Y3Qgc211N19zbXVt
Z3IgKikoaHdtZ3ItPnNtdV9iYWNrZW5kKTsKIAlTTVU3MV9EaXNjcmV0ZV9GYW5UYWJsZSBmYW5f
dGFibGUgPSB7IEZET19NT0RFX0hBUkRXQVJFIH07Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
