Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12878C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B4520872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rx9agVcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B4520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08D36E860;
	Wed, 25 Nov 2020 08:22:58 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE686E542
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:18 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id m6so23530115wrg.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FuE5YjSJzJI/M1RwfuDXt/n7B1wD8+1e0nH8PA2AEy4=;
 b=Rx9agVcbDlYfV56teggpfSalWJve64s1Kw/hncpiAqgMm+aBS0xzV7FVdksDeDAxMS
 w4qNTgYOtKMbhHzSZf0GbZUvDGQvQDp7kD6qQ4rEemO/k6ZAeeqDYqcnwFXuBwf9PRr5
 cUIn/3NZs26RM98dauvvAMtXZUrwXq0gSo3HwoZgola+LlDzmPIMm7EiDgjUJnn+J27Z
 +GI/Dj19rZ2ok377NBLKf7l1ChRWRIXgaUF3pxHFnpYBAkqqgxxnjPXrwRvW5Nz8nQLN
 YB0Ulv7R5eN07q87F5Bq/AFjwOJGcspCsh6I8HM01549N+/oNeF4yHumttUL5Tzr2YqZ
 N7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FuE5YjSJzJI/M1RwfuDXt/n7B1wD8+1e0nH8PA2AEy4=;
 b=I5LXmi242ARf9J/V+1zvRkExuRRNuK6WdTkzoM6912+0HOcrQNuRJJ+jY53i/Hgixd
 e7BD8yBPtY8jIl5/SFRJBXNDvKsLP03sdcA0qStFvV+nMFiMVRUF3PUqQhNLqgNt+o+6
 VvZAoEFKMGiUqconruKl6K+S37XEor13bd4RJyIZfp5Jh4JrkClsXUN4z2NqWoP/trRk
 W2YGo8Q0rASvTxLOrZIDe0MczwhcxEhT5xo1TxWQwibpK0M6Zqb57SCD+nRLLgvckzAd
 6RpdBc2uYKkTW/ERcYx/vzDIz6vvULC3NIrsv7F2QwkrMT3lVw2YlfXT3tUSWeNEc/Mi
 CFyw==
X-Gm-Message-State: AOAM530GC6mWjQesn2nVwzeqtgcNiNEV2EI+n+Q+fAKGKGjHaFLXxqv3
 uXX8qiywq8/mro6tVaxdUv0DgQ==
X-Google-Smtp-Source: ABdhPJwDCyWQlpk/Iszt8GAowASRp1u6blUya1UNc8Kau6+NzQpXYMjrYXwTnerj7k4huU/Yw4IQUA==
X-Received: by 2002:adf:bd86:: with SMTP id l6mr65170wrh.205.1606247057491;
 Tue, 24 Nov 2020 11:44:17 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:16 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/40] drm/amd/amdgpu/gfx_v8_0: Functions must follow directly
 after their headers
Date: Tue, 24 Nov 2020 19:37:59 +0000
Message-Id: <20201124193824.1118741-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYzozNjk4OiB3YXJuaW5nOiBFeGNlc3MgZnVu
Y3Rpb24gcGFyYW1ldGVyICdhZGV2JyBkZXNjcmlwdGlvbiBpbiAnREVGQVVMVF9TSF9NRU1fQkFT
RVMnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5s
aW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjhfMC5jCmluZGV4IDVlNmQxNWY0NDU2MGEuLjlhOTA1NTMxZjgzNzcgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtMzY4Nyw2ICszNjg3LDcgQEAg
c3RhdGljIHZvaWQgZ2Z4X3Y4XzBfc2V0dXBfcmIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5ncmJtX2lkeF9tdXRleCk7CiB9CiAKKyNkZWZpbmUgREVG
QVVMVF9TSF9NRU1fQkFTRVMJKDB4NjAwMCkKIC8qKgogICogZ2Z4X3Y4XzBfaW5pdF9jb21wdXRl
X3ZtaWQgLSBnYXJ0IGVuYWJsZQogICoKQEAgLTM2OTUsNyArMzY5Niw2IEBAIHN0YXRpYyB2b2lk
IGdmeF92OF8wX3NldHVwX3JiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICogSW5pdGlh
bGl6ZSBjb21wdXRlIHZtaWQgc2hfbWVtIHJlZ2lzdGVycwogICoKICAqLwotI2RlZmluZSBERUZB
VUxUX1NIX01FTV9CQVNFUwkoMHg2MDAwKQogc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfaW5pdF9jb21w
dXRlX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJaW50IGk7Ci0tIAoyLjI1
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
