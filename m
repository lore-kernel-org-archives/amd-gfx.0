Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09823C4332D
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A8322B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A8322B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE6989DED;
	Mon, 11 Jan 2021 19:55:02 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC6F89E0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:48 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id c124so233020wma.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bXFKZa9JjVse7+5giwTOAXSXYikkRKBfRN4TR1AbnV8=;
 b=Q9535ah1toYRZ7VlqwLDBDjQYfMfUYLA55rRtLkTMCTwmD5CzFWXNAVjehFjlap/TL
 MXSD01bPe7YrIvBgydU8YLuFUEqZ0AUoo9ikS76apFToPKRioQgaXnbjyXRMB6nmGgKc
 NPwBpeK8MR1KnLKTEwtKy+UfcL+uJZNqwVSZ4xfIVKlrLD7FPEYfSVjb4lVfdGbNE1wE
 1XmsAJ+oNGYUbrm0kZTvO54T9yVqRnP8byP30PPfSuDZAiBewofkUpEO3ALMw4QF5SJa
 IYHVmBt/aHbAefEsRw7Ge8rYYH+nSYIfdVy3gs+idI7Ae/0qvaiW45i+HoUqcEzaFlKb
 w+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bXFKZa9JjVse7+5giwTOAXSXYikkRKBfRN4TR1AbnV8=;
 b=D+2ekJ/dnfhbolKLmzywvJ4sHHZJA0hHfXzbALUjjshKZQu1YxQzHJ6lMMO/j2hLve
 0TjRJI0YsNdlNWv5N/SqfU+sT9mNqxWQU0qB2I2QaA0CRwf0ib2RydsZvurHJvkfepRx
 cwYRu1ehBSsdBkLFCXd8/r0W4JDAtrJvMYxQR4pR3qTSTNzhfoDSusGXvvoDztunEJP9
 RbDB3wScCEz3Ff7lO8s7td+VhtjhV65CKTY0yMqr5BMbrA0Dc/PEA9I7V/BmErSunjWY
 a/gcKhf4k3IjdPCaaAYPTDsYxFbpxp6nrBETguWL6WvAJk928Jb+vRO6qfGpOmeMsJIO
 FD9g==
X-Gm-Message-State: AOAM53082MbjBl+HddPd6yK4Mo3I4yZ/564xtmwJ5VlEmPnJDZkAmhot
 zyGp4pQA7kDIbGeZ/QgXj5F2SQ==
X-Google-Smtp-Source: ABdhPJztYQkuCVcTKJHKAb8YIg6UUqhAqQg50fyXnz/xR2qnfE6mLbt8/fD3cfvLlHesR1meF5lx5w==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr260298wme.101.1610392787408; 
 Mon, 11 Jan 2021 11:19:47 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/40] drm/amd/display/dc/calcs/dce_calcs: Move some large
 variables from the stack to the heap
Date: Mon, 11 Jan 2021 19:18:59 +0000
Message-Id: <20210111191926.3688443-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
 Colin Ian King <colin.king@canonical.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYzogSW4g
ZnVuY3Rpb24g4oCYY2FsY3VsYXRlX2JhbmR3aWR0aOKAmToKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmM6MjAxNjoxOiB3YXJuaW5nOiB0
aGUgZnJhbWUgc2l6ZSBvZiAxMjE2IGJ5dGVzIGlzIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgWy1X
ZnJhbWUtbGFyZ2VyLXRoYW49XQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBh
bWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4K
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IENvbGluIElhbiBLaW5nIDxj
b2xpbi5raW5nQGNhbm9uaWNhbC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NhbGNzL2RjZV9jYWxjcy5jICB8IDIxICsrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYwppbmRleCAxNThkOTI3YzAz
ZTU1Li5hMGM2OWZhZTQwY2VkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY2FsY3MvZGNlX2NhbGNzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NhbGNzL2RjZV9jYWxjcy5jCkBAIC05OCwxNiArOTgsMTYgQEAgc3RhdGljIHZvaWQgY2Fs
Y3VsYXRlX2JhbmR3aWR0aCgKIAlpbnQzMl90IG51bV9jdXJzb3JfbGluZXM7CiAKIAlpbnQzMl90
IGksIGosIGs7Ci0Jc3RydWN0IGJ3X2ZpeGVkIHljbGtbM107Ci0Jc3RydWN0IGJ3X2ZpeGVkIHNj
bGtbOF07CisJc3RydWN0IGJ3X2ZpeGVkICp5Y2xrOworCXN0cnVjdCBid19maXhlZCAqc2NsazsK
IAlib29sIGQwX3VuZGVybGF5X2VuYWJsZTsKIAlib29sIGQxX3VuZGVybGF5X2VuYWJsZTsKIAli
b29sIGZiY19lbmFibGVkOwogCWJvb2wgbHB0X2VuYWJsZWQ7CiAJZW51bSBid19kZWZpbmVzIHNj
bGtfbWVzc2FnZTsKIAllbnVtIGJ3X2RlZmluZXMgeWNsa19tZXNzYWdlOwotCWVudW0gYndfZGVm
aW5lcyB0aWxpbmdfbW9kZVttYXhpbXVtX251bWJlcl9vZl9zdXJmYWNlc107Ci0JZW51bSBid19k
ZWZpbmVzIHN1cmZhY2VfdHlwZVttYXhpbXVtX251bWJlcl9vZl9zdXJmYWNlc107CisJZW51bSBi
d19kZWZpbmVzICp0aWxpbmdfbW9kZTsKKwllbnVtIGJ3X2RlZmluZXMgKnN1cmZhY2VfdHlwZTsK
IAllbnVtIGJ3X2RlZmluZXMgdm9sdGFnZTsKIAllbnVtIGJ3X2RlZmluZXMgcGlwZV9jaGVjazsK
IAllbnVtIGJ3X2RlZmluZXMgaHNyX2NoZWNrOwpAQCAtMTIyLDYgKzEyMiwxNCBAQCBzdGF0aWMg
dm9pZCBjYWxjdWxhdGVfYmFuZHdpZHRoKAogCWludDMyX3QgbnVtYmVyX29mX2Rpc3BsYXlzX2Vu
YWJsZWRfd2l0aF9tYXJnaW4gPSAwOwogCWludDMyX3QgbnVtYmVyX29mX2FsaWduZWRfZGlzcGxh
eXNfd2l0aF9ub19tYXJnaW4gPSAwOwogCisJeWNsayA9IGt6YWxsb2Moc2l6ZW9mKCp5Y2xrKSAq
IDMsIEdGUF9LRVJORUwpOworCXNjbGsgPSBremFsbG9jKHNpemVvZigqc2NsaykgKiA4LCBHRlBf
S0VSTkVMKTsKKworCXRpbGluZ19tb2RlID0ga3phbGxvYyhzaXplb2YoKnRpbGluZ19tb2RlKSAq
CisJCQkgICAgICBtYXhpbXVtX251bWJlcl9vZl9zdXJmYWNlcywgR0ZQX0tFUk5FTCk7CisJc3Vy
ZmFjZV90eXBlID0ga3phbGxvYyhzaXplb2YoKnN1cmZhY2VfdHlwZSkgKgorCQkJICAgICAgIG1h
eGltdW1fbnVtYmVyX29mX3N1cmZhY2VzLCBHRlBfS0VSTkVMKTsKKwogCXljbGtbbG93XSA9IHZi
aW9zLT5sb3dfeWNsazsKIAl5Y2xrW21pZF0gPSB2Ymlvcy0+bWlkX3ljbGs7CiAJeWNsa1toaWdo
XSA9IHZiaW9zLT5oaWdoX3ljbGs7CkBAIC0yMDEzLDYgKzIwMjEsMTEgQEAgc3RhdGljIHZvaWQg
Y2FsY3VsYXRlX2JhbmR3aWR0aCgKIAkJCX0KIAkJfQogCX0KKworCWtmcmVlKHRpbGluZ19tb2Rl
KTsKKwlrZnJlZShzdXJmYWNlX3R5cGUpOworCWtmcmVlKHljbGspOworCWtmcmVlKHNjbGspOwog
fQogCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
