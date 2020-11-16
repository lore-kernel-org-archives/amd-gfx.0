Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA160C63798
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645E32225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBnRjH5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645E32225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0ACF6EA1F;
	Mon, 16 Nov 2020 19:18:43 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1083389FC5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:30:21 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id u12so12391966wrt.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
 b=ZBnRjH5bHdD/fr6ODOIv3yB6B8MvWEu+w+dRaMNIJ4yj/v3SIIw+od+35JUs/9KuDj
 6EvYZOlRHK6d8G5VJC6PLs36kwAf6UNWM/yp0+plhP0iT2JasQSq7sbtCZBmG7RW6I/y
 CPHErLD7H3mfTjWmpJe+4+Iw8jAixy/VmX9ZGE0ATZOsIOYh0HotctE6qn7L3M6MGr1Z
 +35D5kBsbJuc9PJh3i5k8I2oVKNMPpvyShGgTjIfeimqPDkzv8iOUMk03rUMgfHR0aU4
 1EvaXPkzLiEBYvnXqyRSYdGLmg4zeP1xgEzByo1a2XjImHxIyIMaft1/2IqoHjk+6l9D
 oZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
 b=f3Ch5NbvPzl824bjGNVPu25K1+ZkOZ2uw0Whvl/kT4l7ubQNf1sp7pLg3BUScA1Pe6
 AzrrZRIYn1YfK0UKV+CJBfb3VgvenTPNW8q4K+wAoQOi1LtcJcZcuoj/w9C/6a/i1Yrv
 Fh4jpepS2AtngCuMh4vGAZ0KVUZTrOJlFnB4+gPbJOA/YE9CEmFPRa+4XJHqvWY1N+T+
 /p1Duq3h9X/vOCWKrrt75S/vTqgL7/tqhFR8CJWDEhP+Z2mibp2knVPJCEhbd1wy4xRV
 7GI2wEY308W7mLekDmFG1oYzQmzuOLusxtRwCVioVvArA2eDYePwvK1ngkwo1o7I+3id
 ydag==
X-Gm-Message-State: AOAM533ffFjABFHhO5r+cnf3ZV9etN2drxGWXxhfqot7pxXzAYeReYLo
 28d6vWWxwVrxgKO4lbS/nS0e8w==
X-Google-Smtp-Source: ABdhPJw8KV+7wDQGTEX7r+P3jFUndKbF178C178OZT+4NFAaB6TbWQSLwP68uPGl6BK/lRpgQ3Mreg==
X-Received: by 2002:adf:e287:: with SMTP id v7mr21598502wri.252.1605547819721; 
 Mon, 16 Nov 2020 09:30:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:30:19 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/43] drm/radeon/radeon_irq_kms: Demote non-conformant
 kernel-doc fix another
Date: Mon, 16 Nov 2020 17:29:30 +0000
Message-Id: <20201116173005.1825880-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:12 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjU2OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdpcnEnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9kcml2ZXJf
aXJxX2hhbmRsZXJfa21zJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5j
OjU2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhcmcnIG5vdCBkZXNj
cmliZWQgaW4gJ3JhZGVvbl9kcml2ZXJfaXJxX2hhbmRsZXJfa21zJwogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjU3MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
IG9yIG1lbWJlciAnbicgbm90IGRlc2NyaWJlZCBpbiAncmFkZW9uX2lycV9rbXNfc2V0X2lycV9u
X2VuYWJsZWQnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9pcnFfa21zLmM6NTcxOiB3
YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdudW0nIGRlc2NyaXB0aW9uIGluICdy
YWRlb25faXJxX2ttc19zZXRfaXJxX25fZW5hYmxlZCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25faXJxX2ttcy5jIHwgOCArKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9pcnFfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9p
cnFfa21zLmMKaW5kZXggYjg2YmM4OGFkNDMwOC4uYTI0MmI2MDUzZDQ3ZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2lycV9rbXMuYwpAQCAtNDMsMTEgKzQzLDkgQEAKIAogI2RlZmlu
ZSBSQURFT05fV0FJVF9JRExFX1RJTUVPVVQgMjAwCiAKLS8qKgorLyoKICAqIHJhZGVvbl9kcml2
ZXJfaXJxX2hhbmRsZXJfa21zIC0gaXJxIGhhbmRsZXIgZm9yIEtNUwogICoKLSAqIEBpbnQgaXJx
LCB2b2lkICphcmc6IGFyZ3MKLSAqCiAgKiBUaGlzIGlzIHRoZSBpcnEgaGFuZGxlciBmb3IgdGhl
IHJhZGVvbiBLTVMgZHJpdmVyIChhbGwgYXNpY3MpLgogICogcmFkZW9uX2lycV9wcm9jZXNzIGlz
IGEgbWFjcm8gdGhhdCBwb2ludHMgdG8gdGhlIHBlci1hc2ljCiAgKiBpcnEgaGFuZGxlciBjYWxs
YmFjay4KQEAgLTU0OSwxNCArNTQ3LDE0IEBAIHZvaWQgcmFkZW9uX2lycV9rbXNfZGlzYWJsZV9o
cGQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHVuc2lnbmVkIGhwZF9tYXNrKQogfQogCiAv
KioKLSAqIHJhZGVvbl9pcnFfa21zX3VwZGF0ZV9pbnRfbiAtIGhlbHBlciBmb3IgdXBkYXRpbmcg
aW50ZXJydXB0IGVuYWJsZSByZWdpc3RlcnMKKyAqIHJhZGVvbl9pcnFfa21zX3NldF9pcnFfbl9l
bmFibGVkIC0gaGVscGVyIGZvciB1cGRhdGluZyBpbnRlcnJ1cHQgZW5hYmxlIHJlZ2lzdGVycwog
ICoKICAqIEByZGV2OiByYWRlb24gZGV2aWNlIHBvaW50ZXIKICAqIEByZWc6IHRoZSByZWdpc3Rl
ciB0byB3cml0ZSB0byBlbmFibGUvZGlzYWJsZSBpbnRlcnJ1cHRzCiAgKiBAbWFzazogdGhlIG1h
c2sgdGhhdCBlbmFibGVzIHRoZSBpbnRlcnJ1cHRzCiAgKiBAZW5hYmxlOiB3aGV0aGVyIHRvIGVu
YWJsZSBvciBkaXNhYmxlIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIKICAqIEBuYW1lOiB0aGUgbmFt
ZSBvZiB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIHRvIHByaW50IHRvIHRoZSBrZXJuZWwgbG9nCi0g
KiBAbnVtOiB0aGUgbnVtYmVyIG9mIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIgdG8gcHJpbnQgdG8g
dGhlIGtlcm5lbCBsb2cKKyAqIEBuOiB0aGUgbnVtYmVyIG9mIHRoZSBpbnRlcnJ1cHQgcmVnaXN0
ZXIgdG8gcHJpbnQgdG8gdGhlIGtlcm5lbCBsb2cKICAqCiAgKiBIZWxwZXIgZm9yIHVwZGF0aW5n
IHRoZSBlbmFibGUgc3RhdGUgb2YgaW50ZXJydXB0IHJlZ2lzdGVycy4gQ2hlY2tzIHdoZXRoZXIK
ICAqIG9yIG5vdCB0aGUgaW50ZXJydXB0IG1hdGNoZXMgdGhlIGVuYWJsZSBzdGF0ZSB3ZSB3YW50
LiBJZiBpdCBkb2Vzbid0LCB0aGVuCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
