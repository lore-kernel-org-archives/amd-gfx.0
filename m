Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47FC4332E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBFB22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBFB22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1B989D2F;
	Mon, 11 Jan 2021 19:55:03 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BA389F73
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:19 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id q18so967607wrn.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9UrmoG5/yGRXhSIKvPcNh16SC/CzS4H2K0X6mSg1W1w=;
 b=Nal3r9JOaqMh0YA8G9TInOQggMygNJ3sCv+Mv5Btn0E+aMP/FMsVKU5X52FZK8X9zw
 xfg5FvqOqx3aFYwpU7Dq6Pyi6N6i21Otxa3Oankvg6nV/A1XfHC0z1/X3o/E2ld7J70c
 tHXr+o2nc9ff+Wrf87mK38Td4aNUpr8s0l0eUCN+i7T/PxDOLAeaqqjKsHNLzngGtT5L
 Xon0gNOaxfwL4XmZlJH0YMm91QdJ8qZNu6PRZQ1R8Z7hzZtrX+JqmRixPO1IWQ+hSwZz
 /vhQFa6AfcvpS6ojwugz7eg6M4hKaw+Qm9+Og9bKqJP60jYpvNlrxkl2Ee2/UlapI94J
 Q8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9UrmoG5/yGRXhSIKvPcNh16SC/CzS4H2K0X6mSg1W1w=;
 b=OFgvjh1cnU1chLKdYVVHPqNWPVKmEv9uHoPqupzRh0m8vNdg8DF4xPDZN6tfn9iQ+c
 jYDgc0evbjFl0uzQASj8MkhKqILLhdx2lVZeu5TMtF60P173XBrzI3/hw9hPRDvRWsst
 +SjGvP8NdasBDH0YjM2Bynet6qvbnCb5ujS3SpDPmDGU+cwriOSpHyUURU+/mviq4sIe
 2X3j9+u90+E67bJZSIs+4sx8qx6jz820iy3ijBQLhnJfg7kSUEZHJgfo22phNuL/qkR6
 5G7DfGK3W6UcsCOBaTHGB27mzuNz3Jdvq7iDTReslmeKvYVr5ihtF5scUvFMl7jereCV
 kdAQ==
X-Gm-Message-State: AOAM530LODuL8vWIIDTNgNsje4DNR5MvCG+PETu5151zCwEUqsMWDXkF
 UlA/2VXswpEhSkCs/b/MBSlTPQ==
X-Google-Smtp-Source: ABdhPJze/zXJ6tWB8NZECjT9anqSE+wothNGeknI4s8oLr4bpr8L8IAOth8N55Byo5fIJzUqZzLuEA==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr545360wrc.411.1610392818550;
 Mon, 11 Jan 2021 11:20:18 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 37/40] drm/amd/display/dc/dce60/dce60_resource: Make local
 functions static
Date: Mon, 11 Jan 2021 19:19:23 +0000
Message-Id: <20210111191926.3688443-38-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5j
OjUyMjoxNzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U2MF9hdXhf
ZW5naW5lX2NyZWF0ZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmM6NTYwOjIwOiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTYwX2kyY19od19jcmVhdGXi
gJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjU3NjoyMDogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U2MF9pMmNfc3dfY3JlYXRl4oCZIFstV21pc3Npbmct
cHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNl
NjAvZGNlNjBfcmVzb3VyY2UuYzo3MTA6MjI6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlw
ZSBmb3Ig4oCYZGNlNjBfbGlua19lbmNvZGVyX2NyZWF0ZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlw
ZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTYwL2RjZTYw
X3Jlc291cmNlLmM6NzQ5OjIyOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKA
mGRjZTYwX2Nsb2NrX3NvdXJjZV9jcmVhdGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJj
ZS5jOjc3Mzo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTYwX2Ns
b2NrX3NvdXJjZV9kZXN0cm954oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYzo4NjM6
Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U2MF92YWxpZGF0ZV9i
YW5kd2lkdGjigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9yZXNvdXJjZS5jOjkwODoxNjogd2Fybmlu
Zzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U2MF92YWxpZGF0ZV9nbG9iYWzigJkg
Wy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFu
ZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IE1hdXJvIFJvc3NpIDxp
c3Nvci5vcnVhbUBnbWFpbC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
NjAvZGNlNjBfcmVzb3VyY2UuYyAgICB8IDE2ICsrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYwppbmRleCBlOWRk
NzhjNDg0ZDZlLi42NGY0YTBkYTE0NmJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYwpAQCAtNTE5LDcgKzUxOSw3IEBA
IHN0YXRpYyBzdHJ1Y3Qgb3V0cHV0X3BpeGVsX3Byb2Nlc3NvciAqZGNlNjBfb3BwX2NyZWF0ZSgK
IAlyZXR1cm4gJm9wcC0+YmFzZTsKIH0KIAotc3RydWN0IGRjZV9hdXggKmRjZTYwX2F1eF9lbmdp
bmVfY3JlYXRlKAorc3RhdGljIHN0cnVjdCBkY2VfYXV4ICpkY2U2MF9hdXhfZW5naW5lX2NyZWF0
ZSgKIAlzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAogCXVpbnQzMl90IGluc3QpCiB7CkBAIC01NTcs
NyArNTU3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkY2VfaTJjX21hc2sgaTJjX21hc2tzID0g
ewogCQlJMkNfQ09NTU9OX01BU0tfU0hfTElTVF9EQ0VfQ09NTU9OX0JBU0UoX01BU0spCiB9Owog
Ci1zdHJ1Y3QgZGNlX2kyY19odyAqZGNlNjBfaTJjX2h3X2NyZWF0ZSgKK3N0YXRpYyBzdHJ1Y3Qg
ZGNlX2kyY19odyAqZGNlNjBfaTJjX2h3X2NyZWF0ZSgKIAlzdHJ1Y3QgZGNfY29udGV4dCAqY3R4
LAogCXVpbnQzMl90IGluc3QpCiB7CkBAIC01NzMsNyArNTczLDcgQEAgc3RydWN0IGRjZV9pMmNf
aHcgKmRjZTYwX2kyY19od19jcmVhdGUoCiAJcmV0dXJuIGRjZV9pMmNfaHc7CiB9CiAKLXN0cnVj
dCBkY2VfaTJjX3N3ICpkY2U2MF9pMmNfc3dfY3JlYXRlKAorc3RhdGljIHN0cnVjdCBkY2VfaTJj
X3N3ICpkY2U2MF9pMmNfc3dfY3JlYXRlKAogCXN0cnVjdCBkY19jb250ZXh0ICpjdHgpCiB7CiAJ
c3RydWN0IGRjZV9pMmNfc3cgKmRjZV9pMmNfc3cgPQpAQCAtNzA3LDcgKzcwNyw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZW5jb2Rlcl9mZWF0dXJlX3N1cHBvcnQgbGlua19lbmNfZmVhdHVyZSA9
IHsKIAkJLmZsYWdzLmJpdHMuSVNfVFBTM19DQVBBQkxFID0gdHJ1ZQogfTsKIAotc3RydWN0IGxp
bmtfZW5jb2RlciAqZGNlNjBfbGlua19lbmNvZGVyX2NyZWF0ZSgKK3N0YXRpYyBzdHJ1Y3QgbGlu
a19lbmNvZGVyICpkY2U2MF9saW5rX2VuY29kZXJfY3JlYXRlKAogCWNvbnN0IHN0cnVjdCBlbmNv
ZGVyX2luaXRfZGF0YSAqZW5jX2luaXRfZGF0YSkKIHsKIAlzdHJ1Y3QgZGNlMTEwX2xpbmtfZW5j
b2RlciAqZW5jMTEwID0KQEAgLTc0Niw3ICs3NDYsNyBAQCBzdGF0aWMgc3RydWN0IHBhbmVsX2Nu
dGwgKmRjZTYwX3BhbmVsX2NudGxfY3JlYXRlKGNvbnN0IHN0cnVjdCBwYW5lbF9jbnRsX2luaXRf
ZAogCXJldHVybiAmcGFuZWxfY250bC0+YmFzZTsKIH0KIAotc3RydWN0IGNsb2NrX3NvdXJjZSAq
ZGNlNjBfY2xvY2tfc291cmNlX2NyZWF0ZSgKK3N0YXRpYyBzdHJ1Y3QgY2xvY2tfc291cmNlICpk
Y2U2MF9jbG9ja19zb3VyY2VfY3JlYXRlKAogCXN0cnVjdCBkY19jb250ZXh0ICpjdHgsCiAJc3Ry
dWN0IGRjX2Jpb3MgKmJpb3MsCiAJZW51bSBjbG9ja19zb3VyY2VfaWQgaWQsCkBAIC03NzAsNyAr
NzcwLDcgQEAgc3RydWN0IGNsb2NrX3NvdXJjZSAqZGNlNjBfY2xvY2tfc291cmNlX2NyZWF0ZSgK
IAlyZXR1cm4gTlVMTDsKIH0KIAotdm9pZCBkY2U2MF9jbG9ja19zb3VyY2VfZGVzdHJveShzdHJ1
Y3QgY2xvY2tfc291cmNlICoqY2xrX3NyYykKK3N0YXRpYyB2b2lkIGRjZTYwX2Nsb2NrX3NvdXJj
ZV9kZXN0cm95KHN0cnVjdCBjbG9ja19zb3VyY2UgKipjbGtfc3JjKQogewogCWtmcmVlKFRPX0RD
RTExMF9DTEtfU1JDKCpjbGtfc3JjKSk7CiAJKmNsa19zcmMgPSBOVUxMOwpAQCAtODYwLDcgKzg2
MCw3IEBAIHN0YXRpYyB2b2lkIGRjZTYwX3Jlc291cmNlX2Rlc3RydWN0KHN0cnVjdCBkY2UxMTBf
cmVzb3VyY2VfcG9vbCAqcG9vbCkKIAl9CiB9CiAKLWJvb2wgZGNlNjBfdmFsaWRhdGVfYmFuZHdp
ZHRoKAorc3RhdGljIGJvb2wgZGNlNjBfdmFsaWRhdGVfYmFuZHdpZHRoKAogCXN0cnVjdCBkYyAq
ZGMsCiAJc3RydWN0IGRjX3N0YXRlICpjb250ZXh0LAogCWJvb2wgZmFzdF92YWxpZGF0ZSkKQEAg
LTkwNSw3ICs5MDUsNyBAQCBzdGF0aWMgYm9vbCBkY2U2MF92YWxpZGF0ZV9zdXJmYWNlX3NldHMo
CiAJcmV0dXJuIHRydWU7CiB9CiAKLWVudW0gZGNfc3RhdHVzIGRjZTYwX3ZhbGlkYXRlX2dsb2Jh
bCgKK3N0YXRpYyBlbnVtIGRjX3N0YXR1cyBkY2U2MF92YWxpZGF0ZV9nbG9iYWwoCiAJCXN0cnVj
dCBkYyAqZGMsCiAJCXN0cnVjdCBkY19zdGF0ZSAqY29udGV4dCkKIHsKLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
