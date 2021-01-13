Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34FC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4988D23102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4988D23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652DD6E14D;
	Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944A16E07D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:24 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id h17so507416wmq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FpwY4GtbDJpEMrD8DXq2EUXYJZUv4cPwkIqKzqODNJA=;
 b=Bdvrn9SakRrtH0IarS95O03IgYmKiSBzTWBhd72Xl2oiD/WRlfu8A5bqe5l3YriNXF
 XPdsV1cYlQIaO3Wx2GAb3a9TuycM7uNa/YcQa+ftyADQMOesp+QtFSWrQi7A3FnUo+yk
 2BbUt3WNtBG4rKew2hsF3bC+CS1z+ySpMsLAEi/g9cjsqVvKUGZmfsA5nzaC2ujZZvD9
 hqs3+IdBQTTVH103vC8BgMirOrYD+IM0pQWapb+JF9X03WLYIEmyCphzJjJ5lBt6nn2X
 iQFmQee0qcQxQg/lLCZGHZjKQBBqb42J3W/TdT3LDF24z69aIWpFX2rBdwTZMAdYLAbn
 wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FpwY4GtbDJpEMrD8DXq2EUXYJZUv4cPwkIqKzqODNJA=;
 b=o0whbR8DfFvkgjfIbG8sAoX+MePB7ioDbdJUBPOg2xUeKlsZAzz+vYgRBSdBGX/LY7
 YP55e0qjEYrabybycTKBLU3yT6X/GGbEbc1CXFKa2HPOI2333ZdrCAOkx/4eJRCvwovJ
 QGI+v5qKRFGLiMzX8q5VJlMG9W9IRhI++olvWQ+XqnYKiWTsEHyJdW0z9xAQLcXBozwC
 itGoUUJTB3i47J++VVzpfJdyUe4QShOO2ktgVPYexHmTX8hcO+B2WLx2KvBgDYPkSAuJ
 VtpYmpgsNVHvI8g3oSY18+zGuVx9YYl6xrrGWo7hYSgudUKL96AEoQ19EfB+iu/7HAEX
 mIlA==
X-Gm-Message-State: AOAM533cUBBscGjm7966N9ieYN1oQJe5JPARYm9NHkWl1mT6rnEf8k0t
 gGMFkzl8e/D3+iAs7wlrcui93Q==
X-Google-Smtp-Source: ABdhPJyMSIIWiu2bN6N7ZNvS2zrhWvtrGATyhCuNtgDZVfGZXO735pYuZMZ8fdxPfs5n1O+GCbhlrQ==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr954180wmj.18.1610525303222;
 Wed, 13 Jan 2021 00:08:23 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:22 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 22/30] drm/amd/display/dc/core/dc_link: Fix a couple of
 function documentation issues
Date: Wed, 13 Jan 2021 08:07:44 +0000
Message-Id: <20210113080752.1003793-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Jan 2021 08:24:28 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzoyMTQ6IHdh
cm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2xpbmsnIG5vdCBkZXNjcmliZWQg
aW4gJ2RjX2xpbmtfZGV0ZWN0X3NpbmsnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2NvcmUvZGNfbGluay5jOjM1MDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
IG9yIG1lbWJlciAnbGluaycgbm90IGRlc2NyaWJlZCBpbiAnZGNfbGlua19pc19kcF9zaW5rX3By
ZXNlbnQnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNf
bGluay5jOjg0MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbGluaycg
bm90IGRlc2NyaWJlZCBpbiAnZGNfbGlua19kZXRlY3RfaGVscGVyJwogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzo4NDE6IHdhcm5pbmc6IEZ1
bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3JlYXNvbicgbm90IGRlc2NyaWJlZCBpbiAnZGNf
bGlua19kZXRlY3RfaGVscGVyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmsuYzozNDAzOiB3YXJuaW5nOiBDYW5ub3QgdW5kZXJzdGFuZCAgKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2Zm
LWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyB8IDE1ICsrKysrKy0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKaW5kZXggMzM2NmE0OWYxMWRj
Ny4uMjcxYzRmNjZlZGI1NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmsuYwpAQCAtMjA2LDYgKzIwNiw3IEBAIHN0YXRpYyBib29sIHByb2dyYW1faHBk
X2ZpbHRlcihjb25zdCBzdHJ1Y3QgZGNfbGluayAqbGluaykKIC8qKgogICogZGNfbGlua19kZXRl
Y3Rfc2luaygpIC0gRGV0ZXJtaW5lIGlmIHRoZXJlIGlzIGEgc2luayBjb25uZWN0ZWQKICAqCisg
KiBAbGluazogcG9pbnRlciB0byB0aGUgZGMgbGluawogICogQHR5cGU6IFJldHVybmVkIGNvbm5l
Y3Rpb24gdHlwZQogICogRG9lcyBub3QgZGV0ZWN0IGRvd25zdHJlYW0gZGV2aWNlcywgc3VjaCBh
cyBNU1Qgc2lua3MKICAqIG9yIGRpc3BsYXkgY29ubmVjdGVkIHRocm91Z2ggYWN0aXZlIGRvbmds
ZXMKQEAgLTM0Miw3ICszNDMsNyBAQCBzdGF0aWMgZW51bSBzaWduYWxfdHlwZSBnZXRfYmFzaWNf
c2lnbmFsX3R5cGUoc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBlbmNvZGVyLAogCXJldHVybiBT
SUdOQUxfVFlQRV9OT05FOwogfQogCi0vKioKKy8qCiAgKiBkY19saW5rX2lzX2RwX3NpbmtfcHJl
c2VudCgpIC0gQ2hlY2sgaWYgdGhlcmUgaXMgYSBuYXRpdmUgRFAKICAqIG9yIHBhc3NpdmUgRFAt
SERNSSBkb25nbGUgY29ubmVjdGVkCiAgKi8KQEAgLTgyOCw3ICs4MjksNyBAQCBzdGF0aWMgYm9v
bCB3YWl0X2Zvcl9lbnRlcmluZ19kcF9hbHRfbW9kZShzdHJ1Y3QgZGNfbGluayAqbGluaykKIAly
ZXR1cm4gZmFsc2U7CiB9CiAKLS8qKgorLyoKICAqIGRjX2xpbmtfZGV0ZWN0KCkgLSBEZXRlY3Qg
aWYgYSBzaW5rIGlzIGF0dGFjaGVkIHRvIGEgZ2l2ZW4gbGluawogICoKICAqIGxpbmstPmxvY2Fs
X3NpbmsgaXMgY3JlYXRlZCBvciBkZXN0cm95ZWQgYXMgbmVlZGVkLgpAQCAtMzQwMCwxMCArMzQw
MSw3IEBAIHZvaWQgY29yZV9saW5rX3NldF9hdm11dGUoc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0
eCwgYm9vbCBlbmFibGUpCiB9CiAKIC8qKgotICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCi0gKiAgRnVu
Y3Rpb246IGRjX2xpbmtfZW5hYmxlX2hwZF9maWx0ZXIKLSAqCi0gKiAgQGJyaWVmCisgKiAgZGNf
bGlua19lbmFibGVfaHBkX2ZpbHRlcjoKICAqICAgICBJZiBlbmFibGUgaXMgdHJ1ZSwgcHJvZ3Jh
bXMgSFBEIGZpbHRlciBvbiBhc3NvY2lhdGVkIEhQRCBsaW5lIHVzaW5nCiAgKiAgICAgZGVsYXlf
b25fZGlzY29ubmVjdC9kZWxheV9vbl9jb25uZWN0IHZhbHVlcyBkZXBlbmRlbnQgb24KICAqICAg
ICBsaW5rLT5jb25uZWN0b3Jfc2lnbmFsCkBAIC0zNDExLDkgKzM0MDksOCBAQCB2b2lkIGNvcmVf
bGlua19zZXRfYXZtdXRlKHN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgsIGJvb2wgZW5hYmxlKQog
ICogICAgIElmIGVuYWJsZSBpcyBmYWxzZSwgcHJvZ3JhbXMgSFBEIGZpbHRlciBvbiBhc3NvY2lh
dGVkIEhQRCBsaW5lIHdpdGggbm8KICAqICAgICBkZWxheXMgb24gY29ubmVjdCBvciBkaXNjb25u
ZWN0CiAgKgotICogIEBwYXJhbSBbaW5dIGxpbms6IHBvaW50ZXIgdG8gdGhlIGRjIGxpbmsKLSAq
ICBAcGFyYW0gW2luXSBlbmFibGU6IGJvb2xlYW4gc3BlY2lmeWluZyB3aGV0aGVyIHRvIGVuYWJs
ZSBoYmQKLSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICogIEBsaW5rOiAgIHBvaW50ZXIgdG8gdGhl
IGRjIGxpbmsKKyAqICBAZW5hYmxlOiBib29sZWFuIHNwZWNpZnlpbmcgd2hldGhlciB0byBlbmFi
bGUgaGJkCiAgKi8KIHZvaWQgZGNfbGlua19lbmFibGVfaHBkX2ZpbHRlcihzdHJ1Y3QgZGNfbGlu
ayAqbGluaywgYm9vbCBlbmFibGUpCiB7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
