Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442DEC83016
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBF920B80
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cybaq8YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBF920B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BEA6E914;
	Wed, 25 Nov 2020 08:23:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EF26E529
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:09 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 1so91800wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zomKjMWIzPWrEYw6ovqJZadIuaIS2jNkIlpZKRH8vHs=;
 b=Cybaq8YBYtuTaFR9pBITA1eQRnSBpzhBLkn4zNF+2G3HKC8ZoZ6IIv1b5/uH9fiyVm
 34zogKau3MdUz9JhxsXYpQdi3G7agieql+9jT4s0GActMXzOvScBl0L6AxuVTQHjXCwd
 8XbMr1LcfHVtvjKBTRkxNgaBWMC2klAWVbsp2zM7N3lf+v1GB61U9DU2YYCWdoM9nUtF
 TUzZ+vpHwelItISKNaByhSP4b0gb+/zFCFhXKorLw2zAsz3s148A3UfUpuqf5D/mKslA
 uu66sHvtiZtIKh/qjMtlnJMmd75EIOucoeNL7XXgS8oINJiY9f1yxbNsWiStD/hjpNUi
 YMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zomKjMWIzPWrEYw6ovqJZadIuaIS2jNkIlpZKRH8vHs=;
 b=kdwSXn9FjVV2Dfh3Geiq5dDRl3Y6CGIcVSRMvwFCU8feT9zE5vnHLSIP/Yg+ytpNUm
 Vcdh5/CDYw/m8rh90r3wnyV6IjVDw3QnngWJ0QeM1mDX6Wh2rA/knS8w7z6EZaGbhuxo
 PktFQ2eDjRsiNf2l49azOCfWWS8ACZORBBm9O9D9gvUR+KTXzOnA0YgvhZEzAPW7UOJH
 EGdoX8s89TMUN76mE8F6B5dvz5muxMUOINgjzUJmToyQCvAEUALfSNs65LXBQuLmoY8i
 abul1XvfGYLwBlx/mr91CnTx6tj15/LaPnKmfmwJsJm5OeLVhEgna8xW5LVv3N6FZWDx
 zr2w==
X-Gm-Message-State: AOAM531SSgP1edUc+UyVSll9Pw4MTFKl803+yKK8XeIXHecavA4v3kjA
 c2Xho0XQkMT0ee/TVu9f1iBrCa8W7Wk1V/Qg
X-Google-Smtp-Source: ABdhPJyp6RogQVTezKIu79LTXpjXEtp0sMVK4trAa640b+djxzfz62EpQey4z/X3AvcXXAyXJhkViw==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr173565wmu.31.1606247047808; 
 Tue, 24 Nov 2020 11:44:07 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:07 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/40] drm/amd/amdgpu/amdgpu_psp: Make local function
 'parse_ta_bin_descriptor' static
Date: Tue, 24 Nov 2020 19:37:51 +0000
Message-Id: <20201124193824.1118741-8-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jOjI1NzY6NTogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhwYXJzZV90YV9iaW5fZGVzY3JpcHRvcuKAmSBbLVdtaXNz
aW5nLXByb3RvdHlwZXNdCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCA3NGNi
YWYyMTI2OTgyLi45MTBlODlkYzMyNGI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCkBAIC0yNTczLDkgKzI1NzMsOSBAQCBpbnQgcHNwX2luaXRfc29zX21pY3JvY29k
ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAlyZXR1cm4gZXJyOwogfQogCi1pbnQgcGFyc2Vf
dGFfYmluX2Rlc2NyaXB0b3Ioc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCi0JCQkgICAgY29uc3Qg
c3RydWN0IHRhX2Z3X2Jpbl9kZXNjICpkZXNjLAotCQkJICAgIGNvbnN0IHN0cnVjdCB0YV9maXJt
d2FyZV9oZWFkZXJfdjJfMCAqdGFfaGRyKQorc3RhdGljIGludCBwYXJzZV90YV9iaW5fZGVzY3Jp
cHRvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKKwkJCQkgICBjb25zdCBzdHJ1Y3QgdGFfZndf
YmluX2Rlc2MgKmRlc2MsCisJCQkJICAgY29uc3Qgc3RydWN0IHRhX2Zpcm13YXJlX2hlYWRlcl92
Ml8wICp0YV9oZHIpCiB7CiAJdWludDhfdCAqdWNvZGVfc3RhcnRfYWRkciAgPSBOVUxMOwogCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
