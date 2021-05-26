Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB97C4708A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC0961090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC0961090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF226ECEB;
	Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CBB6EC2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:41 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 l18-20020a1c79120000b0290181c444b2d0so23997wme.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hSDS0B4fQp47KmNI4VulVH8wz4wQl27Y7BX42nP21sg=;
 b=dcN/WRihIO90bHiQ9m0MJt0eKZLdYaTMCHRtA5oqLwEwYpsQgez2GUQcn71i3ih0jW
 plNUmFHspKhJO2iQGHv17+YcEIRq4fiTrfQWA4ghswtFulk+FsfsAv831pv8xyB2c6cG
 owohKi5lh4ZipKQPkVyvihqIPKWE8AoypYbSepOd+/l8UozrVuWyHTfYYmlUD7EQHqgh
 GwstL/JKm2DpxzzEzwW+FqvbzAxso9w8qJcpSNqPW1TEJ1oRqhaGLvsQWsR+yqoCTV9C
 1/iEm0F+7DwR2FNLxuVifk5iaWQWisncmcnNFZCooBlssHa10v7lifobDNHrux6bNLiq
 3Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSDS0B4fQp47KmNI4VulVH8wz4wQl27Y7BX42nP21sg=;
 b=stHvVkRrmE3wvTQmWry8UZXmXQBFYsbOvFzrBU2XdnTBffNOsTPDVEcttBsVO7BRiV
 9f1vZSg+jeV/EwhP9WVygwTUpJ9N49IDSdO2fTPa26GPU453H4b4BXTZp0IqCsVDxx7h
 qgOuB7iqmb0fxQ1tKQYVT9GOwgib/S2a3V/v8C5n+guE7chgX3N7xUuj2U3I8B7rkV5d
 EJSrHXO6OkJkl+uwn1lY0cGrndgCANfMjFZjnmcbhXm3ALAdIEsHQStm4wbm5PNfV1pK
 G9XBSC3QKOhj4entW7gZoKgnTIS8XA9yDyLJicjUQsV9ziqhkjwIce6bgbmiyKjw+Afg
 HYNQ==
X-Gm-Message-State: AOAM533bEx5mXgYS+PKPgl0xUabfRc2tGXxXBEZpDdWk9t2xauhzLgnD
 qYN4LLiO1uaJ5LfMwB1UNy0gsg==
X-Google-Smtp-Source: ABdhPJzqDrnjoRziv6JoSt76RUtBnwKhDOJNyexrZdLJodTCazVGqrbE34zIibURPetmptwFMYs0jA==
X-Received: by 2002:a05:600c:2289:: with SMTP id
 9mr2320654wmf.29.1622018859683; 
 Wed, 26 May 2021 01:47:39 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:39 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 09/34] drm/amd/display/dc/bios/command_table_helper2: Fix
 function name 'dal_cmd_table_helper_transmitter_bp_to_atom2()'
Date: Wed, 26 May 2021 09:47:01 +0100
Message-Id: <20210526084726.552052-10-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVs
cGVyMi5jOjE0MTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgdHJhbnNsYXRlX3Ry
YW5zbWl0dGVyX2JwX3RvX2F0b20yKCkuIFByb3RvdHlwZSB3YXMgZm9yIGRhbF9jbWRfdGFibGVf
aGVscGVyX3RyYW5zbWl0dGVyX2JwX3RvX2F0b20yKCkgaW5zdGVhZAoKQ2M6IEhhcnJ5IFdlbnRs
YW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5j
b20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hy
aXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJs
ZV9oZWxwZXIyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlv
cy9jb21tYW5kX3RhYmxlX2hlbHBlcjIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5jCmluZGV4IDAwNzA2YjA3MmI1ZjguLjZkMmZi
MTEyYWQ5ZjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9z
L2NvbW1hbmRfdGFibGVfaGVscGVyMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5jCkBAIC0xMjksNyArMTI5LDcgQEAgYm9v
bCBkYWxfY21kX3RhYmxlX2hlbHBlcl9jb250cm9sbGVyX2lkX3RvX2F0b20yKAogfQogCiAvKioK
LSAqIHRyYW5zbGF0ZV90cmFuc21pdHRlcl9icF90b19hdG9tMiAtIFRyYW5zbGF0ZSB0aGUgVHJh
bnNtaXR0ZXIgdG8gdGhlCisgKiBkYWxfY21kX3RhYmxlX2hlbHBlcl90cmFuc21pdHRlcl9icF90
b19hdG9tMiAtIFRyYW5zbGF0ZSB0aGUgVHJhbnNtaXR0ZXIgdG8gdGhlCiAgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb3JyZXNwb25kaW5nIEFUT00gQklPUyB2YWx1ZQog
ICogIEB0OiB0cmFuc21pdHRlcgogICogIHJldHVybnM6IGRpZ2l0YWxUcmFuc21pdHRlcgotLSAK
Mi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
