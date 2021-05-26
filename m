Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B3C4708A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC2060FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC2060FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFDB6ECFD;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED716EC3A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:47 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id t206so262092wmf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lH0QiIv9GplFfw8+sE0Oz9qNWUTXoSa9cJ3TV4liCwY=;
 b=RB/7ogGfRKR/H7xbMg6lQNSx4WrXK0TQZTmShXZ6vEsfWcdJt9mpwfOSaOSL1ocabF
 /L+NmojU7HiAsSEG+onzR8iw/jSwxAwiZvxxqQyIh2jDsOsHAv+ydEDMELlHuh+aoT/g
 wpOlNrw7F5oyIq8Weqcxg396wPPR2XTefQA029ZoYa2V3AFlbiST21TRICtIVUMwcLLD
 Uo5g2JUO6sWhLAmjiX8yx4YZrpjAmi5mrFL+Ue9nh/8iBuYPdLZEerF1WKq0TdqvD82T
 V0R0QuLlc77v1p3bR65MevvgCbC0PfDSSyJ2Qsd6JNxadfxJ6XpGRtK6u1DqxeuhxICk
 HxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lH0QiIv9GplFfw8+sE0Oz9qNWUTXoSa9cJ3TV4liCwY=;
 b=Bv22hui8iTjVMKJAy/RMJksvCQVQActmaxQVKF+Q5GrJGWhTQBaya024AWDb5cyfig
 oPArEEOygFWyqjgyq4Wd59VuPHY5VMj3+vWRdCJ/RggotVqAidYt5gzIVva5Mk+SkGgn
 6zZrEO+ILWYI9A/wXcQz1/MfeECkMzm4xtK8dQwF+HhW6Z/D9i+V1WO/h3eeJEaKe5VT
 swldGaaMh7QTMwOrjnDwV7/8oCwcbVr29OJvH5GBHodcPYxuYpRaY46d0HF9zDr3TjZN
 fnrS7Ww/0LzrGsXtjWrczloWKGzBW7nM4ZuDpH3Pmd3HPc0Grd18AgY48WWn9BF+fiVz
 GTsA==
X-Gm-Message-State: AOAM530/cIfWWWhK7ojIjkXMkbbSgLZ8qILA7gq3scEV4wW4EGab0qEF
 /5Bhdq9scYJEmlCPzawq1BqGHA==
X-Google-Smtp-Source: ABdhPJxtgNzpcQUJUz+PEveawDKv5XlwuQ3p/fcDcouhayhnN7/EaDgJ8QeVnCBVRTFNMYQbAi+g0Q==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr2263933wmi.160.1622018865874; 
 Wed, 26 May 2021 01:47:45 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:45 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/34] drm/amd/display/dc/dce110/dce110_hw_sequencer: Include
 our own header
Date: Wed, 26 May 2021 09:47:07 +0100
Message-Id: <20210526084726.552052-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVl
bmNlci5jOjkyNzo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEx
MF9lZHBfd2FpdF9mb3JfVDEy4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBX
ZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBh
bWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEw
X2h3X3NlcXVlbmNlci5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEw
X2h3X3NlcXVlbmNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9k
Y2UxMTBfaHdfc2VxdWVuY2VyLmMKaW5kZXggNWRkZWVlOTZiZjIzNS4uOTIxOWRiNzlmMzJiNiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBf
aHdfc2VxdWVuY2VyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEx
MC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMKQEAgLTYzLDYgKzYzLDggQEAKIAogI2luY2x1ZGUgImF0
b21maXJtd2FyZS5oIgogCisjaW5jbHVkZSAiZGNlMTEwX2h3X3NlcXVlbmNlci5oIgorCiAjZGVm
aW5lIEdBTU1BX0hXX1BPSU5UU19OVU0gMjU2CiAKIC8qCi0tIAoyLjMxLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
