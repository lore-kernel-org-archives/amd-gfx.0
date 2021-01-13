Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3CBC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3570623102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3570623102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC856E135;
	Wed, 13 Jan 2021 08:24:29 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9E989F33
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:06 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id 91so1060829wrj.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8xdwLDrcWYKJZSMYMYuV8riE8ORgcBnhB0CHa1Q/JBs=;
 b=FrwgrjKbVxt3s7pvTRS7s+XO01JRsO9XZYJHRIrzN6pluG3wMDB1Q/zF5eAgINfD5m
 RFBF7is2Nd1xdqHRGNGA/83nam7awxbCz5WzRe6K2JPtLxALiOUcqafRk5ffZ+N+EPLS
 ekCBhJvOuHkTndHv+9B7EE0zHCswpCoLDO8kZrc51wWWeWTYwmynloBfUQKEYJpQgCnp
 UEIPrnCJ0CxXXncxIGQSZPDTyg3azKpfqjcySttB1j7+C9klBZTczEAqTmBmmCsO7LN6
 pEC7tTfH8PbvCsAjD7q/AOyR6vA5aWyeIPdEiaCDsflyT1/Ry2lYfJdFst6an0ArQqYJ
 Yzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8xdwLDrcWYKJZSMYMYuV8riE8ORgcBnhB0CHa1Q/JBs=;
 b=JyRIYQxfUgCPxC6NCj2TH7dQtBJhgZGZ85wtjgkElzEKbR5hx9EFksEoutSYyrWcSk
 xzB3/+Uyjcy0S5u3kCjsVJ3b1gOmlYZ0+45NWZkCE6gdBhhTe/a0hfsVoyhaL0HYk+4h
 ZX+z35j+w97Wd37YE1o3YekTW0AYYhVvtOE0+o9U+pe3vGqNso/92fYmqgXSe007VMk3
 1C1RgwsOrCEZAQT8DZLBJvVsAgZRUa0XykT23CyUKnVibACoiRS5BXQOSDdnol5Uxo+2
 a7UZC8pX87CSM2hHvSP2M1isZZtCKd1c5f/U9fKfGPaSensidrhD7SXs2vtl7/u9ABdt
 MWgg==
X-Gm-Message-State: AOAM530znlG+c8p2AX4yv6LJAfxF0KTaMx3np67TNgAYdLkmvCa1G66j
 +cppg168qdJYYir90sy412Xbew==
X-Google-Smtp-Source: ABdhPJwkjOkvuLucehpAKBBj0JktW+lR9glrfph7izxG8rzbGe0A5bRWnqXrrWYnYK4ilSl5EQhwdA==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr1217792wrn.12.1610525285003;
 Wed, 13 Jan 2021 00:08:05 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:04 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/30] drm/amd/display/dc/core/dc_link: Remove unused variable
 'status'
Date: Wed, 13 Jan 2021 08:07:29 +0000
Message-Id: <20210113080752.1003793-8-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzogSW4gZnVu
Y3Rpb24g4oCYcXVlcnlfaGRjcF9jYXBhYmlsaXR54oCZOgogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYzo1OTk6Mjg6IHdhcm5pbmc6IHZhcmlh
YmxlIOKAmHN0YXR1c+KAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlh
YmxlXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVv
IExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jIHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfbGluay5jCmluZGV4IGY0YTIwODhhYjE3OTIuLjhjY2RhOGI5YWMyZWIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKQEAgLTU5Niw4ICs1
OTYsNiBAQCBzdGF0aWMgdm9pZCBxdWVyeV9oZGNwX2NhcGFiaWxpdHkoZW51bSBzaWduYWxfdHlw
ZSBzaWduYWwsIHN0cnVjdCBkY19saW5rICpsaW5rKQogCWRjX3Byb2Nlc3NfaGRjcF9tc2coc2ln
bmFsLCBsaW5rLCAmbXNnMjIpOwogCiAJaWYgKHNpZ25hbCA9PSBTSUdOQUxfVFlQRV9ESVNQTEFZ
X1BPUlQgfHwgc2lnbmFsID09IFNJR05BTF9UWVBFX0RJU1BMQVlfUE9SVF9NU1QpIHsKLQkJZW51
bSBoZGNwX21lc3NhZ2Vfc3RhdHVzIHN0YXR1cyA9IEhEQ1BfTUVTU0FHRV9VTlNVUFBPUlRFRDsK
LQogCQltc2cxNC5kYXRhID0gJmxpbmstPmhkY3BfY2Fwcy5iY2Fwcy5yYXc7CiAJCW1zZzE0Lmxl
bmd0aCA9IHNpemVvZihsaW5rLT5oZGNwX2NhcHMuYmNhcHMucmF3KTsKIAkJbXNnMTQubXNnX2lk
ID0gSERDUF9NRVNTQUdFX0lEX1JFQURfQkNBUFM7CkBAIC02MDUsNyArNjAzLDcgQEAgc3RhdGlj
IHZvaWQgcXVlcnlfaGRjcF9jYXBhYmlsaXR5KGVudW0gc2lnbmFsX3R5cGUgc2lnbmFsLCBzdHJ1
Y3QgZGNfbGluayAqbGluaykKIAkJbXNnMTQubGluayA9IEhEQ1BfTElOS19QUklNQVJZOwogCQlt
c2cxNC5tYXhfcmV0cmllcyA9IDU7CiAKLQkJc3RhdHVzID0gZGNfcHJvY2Vzc19oZGNwX21zZyhz
aWduYWwsIGxpbmssICZtc2cxNCk7CisJCWRjX3Byb2Nlc3NfaGRjcF9tc2coc2lnbmFsLCBsaW5r
LCAmbXNnMTQpOwogCX0KIAogfQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
