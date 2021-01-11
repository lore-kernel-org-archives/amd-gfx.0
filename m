Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D67C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEA422A83
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEA422A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0966E07D;
	Mon, 11 Jan 2021 19:54:43 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3DD89E0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:51 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d13so879675wrc.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EFjJaIHLraEHMpMPczN8JeHzaX7KeAA32v4O8bA3nIs=;
 b=B81lzbUzyymnyb48hbSnQQI2PtxDs6gsJmfEjcDaH7g9cHki4LflvmO41nwnsg/fUl
 0V0WtXyIZSCNKqRtbDvgDUBpdU679lL6Yw2pgaygMHcluXrxnM65ZzviW6ezl6TMVB+A
 bo8991Bf4Mff2Rfro+9fVbBC7fjvCYPVaJkvd6EcuTkOePXBWVDzotexB50kciYdSelY
 RlgBYLtIqrHaTxZEo65SXoEQy+FzPAMkFvAk2pADCpn8+At8WnnnmqAUf1RZPaBfMuuF
 YkK8RdkeZGvQ1e8DYBlvp2jSl9ckzY9zdNgMKfgIlYg+Tp8Kppz+tgX9tsb5wuAMdleo
 3z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EFjJaIHLraEHMpMPczN8JeHzaX7KeAA32v4O8bA3nIs=;
 b=nCTuXK8U5cbaG5xMIdQp/jvs9PxUHgn4GZoCLj8HoBgFBm1Qt3bj7VeuFZ73stwsSP
 de60Sp4I83ogwt/vmW9KPR5Hl7l+RttwnrwlQ73/Rc+BmVNIUanPcBZINjo2edlTtxxL
 Q8o+u6HHl3a7b5eR5cg87u+sh0Gq5yIPOF2NUn57dDaNU85H3RGS3GFcgTwZz5WPOB9q
 WCvhJOyC2hpQjuXacFEqTUUhuXqnMb1JXVnjIXyp4pezxk2+QfhNGrHob7/UElj6yMyK
 OkhDYnV2xaR9/HVColO8iBwLTQ1nZTro14L9dolK7hmrwntu85qorJnjaZCV42kl/NUz
 VEuQ==
X-Gm-Message-State: AOAM533ZaCmmjDJdSUxK4My0oaaLp52ftkTsdJaaYKqr2LnLlmlnB0/2
 8TgkFV6YdRpBR1xSHgWTEAK8/Q==
X-Google-Smtp-Source: ABdhPJx2y/C1Gm7lZtAhN+h6CLxajvnAHhLrj7A8KWiS3YKr9+4FIAbPlnE/ud+bnMAVlg7CPOQZ1A==
X-Received: by 2002:adf:d085:: with SMTP id y5mr605031wrh.41.1610392790177;
 Mon, 11 Jan 2021 11:19:50 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:49 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/40] drm/amd/display/dc/dce120/dce120_resource: Staticify
 local functions
Date: Mon, 11 Jan 2021 19:19:01 +0000
Message-Id: <20210111191926.3688443-16-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNl
LmM6NDI2OjMyOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEyMF9v
cHBfY3JlYXRl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jOjQ0MDoxNzogd2Fy
bmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2UxMjBfYXV4X2VuZ2luZV9jcmVh
dGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNlLmM6NDc4OjIwOiB3YXJuaW5nOiBu
byBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEyMF9pMmNfaHdfY3JlYXRl4oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBBbnRob255IEtvbyA8QW50aG9u
eS5Lb29AYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZTEyMC9kY2UxMjBfcmVzb3VyY2UuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jCmluZGV4IGYxZTNkMjg4OGVh
Y2MuLmM2NWU0ZDEyNWM4ZTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfcmVzb3VyY2UuYwpAQCAtNDIzLDcgKzQyMyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZGNlMTEwX2Nsa19zcmNfbWFzayBjc19tYXNrID0gewogCQlDU19D
T01NT05fTUFTS19TSF9MSVNUX0RDRV8xMTIoX01BU0spCiB9OwogCi1zdHJ1Y3Qgb3V0cHV0X3Bp
eGVsX3Byb2Nlc3NvciAqZGNlMTIwX29wcF9jcmVhdGUoCitzdGF0aWMgc3RydWN0IG91dHB1dF9w
aXhlbF9wcm9jZXNzb3IgKmRjZTEyMF9vcHBfY3JlYXRlKAogCXN0cnVjdCBkY19jb250ZXh0ICpj
dHgsCiAJdWludDMyX3QgaW5zdCkKIHsKQEAgLTQzNyw3ICs0MzcsNyBAQCBzdHJ1Y3Qgb3V0cHV0
X3BpeGVsX3Byb2Nlc3NvciAqZGNlMTIwX29wcF9jcmVhdGUoCiAJCQkgICAgIGN0eCwgaW5zdCwg
Jm9wcF9yZWdzW2luc3RdLCAmb3BwX3NoaWZ0LCAmb3BwX21hc2spOwogCXJldHVybiAmb3BwLT5i
YXNlOwogfQotc3RydWN0IGRjZV9hdXggKmRjZTEyMF9hdXhfZW5naW5lX2NyZWF0ZSgKK3N0YXRp
YyBzdHJ1Y3QgZGNlX2F1eCAqZGNlMTIwX2F1eF9lbmdpbmVfY3JlYXRlKAogCXN0cnVjdCBkY19j
b250ZXh0ICpjdHgsCiAJdWludDMyX3QgaW5zdCkKIHsKQEAgLTQ3NSw3ICs0NzUsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGRjZV9pMmNfbWFzayBpMmNfbWFza3MgPSB7CiAJCUkyQ19DT01NT05f
TUFTS19TSF9MSVNUX0RDRTExMChfTUFTSykKIH07CiAKLXN0cnVjdCBkY2VfaTJjX2h3ICpkY2Ux
MjBfaTJjX2h3X2NyZWF0ZSgKK3N0YXRpYyBzdHJ1Y3QgZGNlX2kyY19odyAqZGNlMTIwX2kyY19o
d19jcmVhdGUoCiAJc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKIAl1aW50MzJfdCBpbnN0KQogewot
LSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
