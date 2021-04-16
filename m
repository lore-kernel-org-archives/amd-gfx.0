Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A31C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF7961008
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF7961008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB81D6EC82;
	Fri, 16 Apr 2021 16:57:29 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CBE6EC03
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:38:04 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id bx20so31419362edb.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eZSAadoVwWWKS/0qwmdM9B0hG2udBsRl+ZNcX49QlvU=;
 b=nw2nOI9l6bUUJmtRby49O2JfdE9k1M4kUJc1s4RPv33ufbBEVEtxgscvAnToufcmDo
 RbVeTBFbe3K1OylmmnszhZ1sts9nOAjyQ6gQAQZWgdBZLy5/fAADEWhPmjg8Kb9pBDrt
 v4ajsDabD+SR+GdhKqXy8O+PVM9vzbs6COwHPxfWao+2YZNVqSBNb8KAKtMl8i3Yp9Fj
 utQpfV5J7eXNzA9EyqhqZ49g+0VzXGyRprORETslu3gZEaJCebXLpeii7FClbzLtrHfa
 bWETg/DXaJIFFqy6ADORLEp/MJfg71OENRKxzlW5QUtqlEKemuH3f0mjzQUqbicdf1vy
 wDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eZSAadoVwWWKS/0qwmdM9B0hG2udBsRl+ZNcX49QlvU=;
 b=Kx1KmGNpAT5kd+3k1iu3PbHgNBEYYcDRdCLQWGSHcYjAKSYxf1fKf4sywxF1nnv7nZ
 YNlH4c3ZWZcVKjwWfKWeWJYj+ZVf3evWiT5rfOHhaTnm3x2/VGy2QZVvz97SRp2EGzmN
 xl8rDt75H+jbcSjnJ+MzeLW+h8vLXU2s23G3bYYDSTXJwBRY9bpJm1e3akAGr8qJvMy0
 PavkiKvf6yeuRw9g9kEpjhXQVkGTxXBct+feYgX3ofJhSE/a8ih9qdXvraBB555lFNEW
 hMlwQrriwEfEiIU1K6sOY4FgIuztcj5TNwlSLy3yh948IIGFR9VP7FtF8EDN0uybyU+X
 +N3Q==
X-Gm-Message-State: AOAM530VpXVterTXd0fNakVzgDOiyLIq0uFY0Alq/piO/6ESLEWFuX37
 rKN7OcOefw4268Cwm4fZf1dDsw==
X-Google-Smtp-Source: ABdhPJyaWCWNnk1gyPCzfGXwhwfCB5WDHs+D8lShvvSaWygeMRqZlvqxZLDhhzs5ZiOecIFpI4V1ww==
X-Received: by 2002:a50:85cd:: with SMTP id q13mr10416204edh.114.1618583882788; 
 Fri, 16 Apr 2021 07:38:02 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 07:38:02 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/40] drm/amd/amdgpu/amdgpu_gart: Correct a couple of
 function names in the docs
Date: Fri, 16 Apr 2021 15:37:16 +0100
Message-Id: <20210416143725.2769053-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 16 Apr 2021 16:57:23 +0000
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
 amd-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYzo3Mzogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3IgYW1kZ3B1X2R1bW15X3BhZ2VfaW5pdCgpLiBQcm90b3R5cGUgd2FzIGZv
ciBhbWRncHVfZ2FydF9kdW1teV9wYWdlX2luaXQoKSBpbnN0ZWFkCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jOjk2OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBl
IGZvciBhbWRncHVfZHVtbXlfcGFnZV9maW5pKCkuIFByb3RvdHlwZSB3YXMgZm9yIGFtZGdwdV9n
YXJ0X2R1bW15X3BhZ2VfZmluaSgpIGluc3RlYWQKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmll
bCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1k
LmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYyB8
IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwppbmRleCBjNWE5YTRmYjEw
ZDJiLi41NTYyYjVjOTBjMDMyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2FydC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
YXJ0LmMKQEAgLTYwLDcgKzYwLDcgQEAKICAqLwogCiAvKioKLSAqIGFtZGdwdV9kdW1teV9wYWdl
X2luaXQgLSBpbml0IGR1bW15IHBhZ2UgdXNlZCBieSB0aGUgZHJpdmVyCisgKiBhbWRncHVfZ2Fy
dF9kdW1teV9wYWdlX2luaXQgLSBpbml0IGR1bW15IHBhZ2UgdXNlZCBieSB0aGUgZHJpdmVyCiAg
KgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICoKQEAgLTg2LDcgKzg2LDcgQEAg
c3RhdGljIGludCBhbWRncHVfZ2FydF9kdW1teV9wYWdlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiB9CiAKIC8qKgotICogYW1kZ3B1X2R1bW15X3BhZ2VfZmluaSAtIGZyZWUgZHVt
bXkgcGFnZSB1c2VkIGJ5IHRoZSBkcml2ZXIKKyAqIGFtZGdwdV9nYXJ0X2R1bW15X3BhZ2VfZmlu
aSAtIGZyZWUgZHVtbXkgcGFnZSB1c2VkIGJ5IHRoZSBkcml2ZXIKICAqCiAgKiBAYWRldjogYW1k
Z3B1X2RldmljZSBwb2ludGVyCiAgKgotLSAKMi4yNy4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
