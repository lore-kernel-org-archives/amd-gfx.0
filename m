Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E3C4708A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADE661090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADE661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF2D6ECE3;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6456EC32
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:32 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id j14so206767wrq.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6noTtcFdzAM4mRtKAmNKqowB17kNzJ46dcIfcnLdMB8=;
 b=RZRDWvzHNmKISbyL/y7tncGD6OlregtD8vbp5d/rmc0PNGq6sghfzAZpXIe2PuELFw
 Bl1gg68glEy2naNn9LnTRH2OEEqMjSt2RTKm/7jbmXscdFxuK8CWcUGb/vXCoQfWtJTk
 /aQCyRZ9whXV/5z0rECrM+Xhv7rb8OCYw5pWY7z9cnUp9F4RSx6QshjN30+bDnJ7f5/U
 FM45gqEUoo98DgxJer6yTzB/Razb2X3ch0zQNmp85X4rpnSrCDr8+ICEhSO3EPBjU5of
 GQMhOB5m59Zl9sLle9jZmHDPMyzPnptje0Xt7a9qjMhnYHHKm1eSSNeIPMNm2d2PrSMH
 boSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6noTtcFdzAM4mRtKAmNKqowB17kNzJ46dcIfcnLdMB8=;
 b=bj8ZIznexjnxFv1dfKQKW2VtfEtu0+r5foKsSKNEBUIxpRnQ9FsRE6bh7wkkTAQCjr
 QZWcGTWHQPkIpF3h9SKJNGohjiyPNzVHa95KAzHBCGvsZNtuYKp16UnQliZ9Nkw760fH
 z1A1f6222y0YD/eB337IjM1fzKjnZbgxf2hE8gxOZUdZEE0lU3oOFEaeFmPRwIj4kOga
 wHObEmIpOHbZTWGzxMkIH7YU7GlpVfJ4jDvGcFqyloLN13msSSQzICvV/1W7jEhCpzco
 ly+ulWkPOyYpC+8A2lGJfXhXDuspQi0WZqgbb2BIwvXQFk9NOiuLbxWQRhSgB8dpnttX
 KOcA==
X-Gm-Message-State: AOAM533Ti6lggwNQ4E5ca8fMXb/a+w7fpTKGhTJXFjbW31XXuUGshElz
 uIhuWg5wdqrm18lPonWemJN2tA==
X-Google-Smtp-Source: ABdhPJwiod43TqTsfuNXme67KiMrAR6fRFT9Vr9f58QWqFwUO+ulOBWEvlceFKoeCsGC21ORHtaxVw==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr31088295wrn.219.1622018851572; 
 Wed, 26 May 2021 01:47:31 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:31 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/34] drm/amd/pm/inc/smu_v13_0: Move table into the only
 source file that uses it
Date: Wed, 26 May 2021 09:46:53 +0100
Message-Id: <20210526084726.552052-2-lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, Kevin Wang <kevin1.wang@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vaW5jL3NtdV92MTNfMC5oOjU0OjQzOiB3YXJuaW5n
OiDigJhzbXUxM190aGVybWFsX3BvbGljeeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtY29uc3QtdmFyaWFibGU9XQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgpDYzogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3YxM18wLmggICAgICAgICAgICAg
fCA2IC0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5f
cHB0LmMgfCA2ICsrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3Yx
M18wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEzXzAuaAppbmRleCAxNjg3
NzA5NTA3YjNkLi42MTE5YTM2YjJjYmEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2luYy9zbXVfdjEzXzAuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVf
djEzXzAuaApAQCAtNTEsMTIgKzUxLDYgQEAKICNkZWZpbmUgQ1RGX09GRlNFVF9IT1RTUE9UCQk1
CiAjZGVmaW5lIENURl9PRkZTRVRfTUVNCQkJNQogCi1zdGF0aWMgY29uc3Qgc3RydWN0IHNtdV90
ZW1wZXJhdHVyZV9yYW5nZSBzbXUxM190aGVybWFsX3BvbGljeVtdID0KLXsKLQl7LTI3MzE1MCwg
IDk5MDAwLCA5OTAwMCwgLTI3MzE1MCwgOTkwMDAsIDk5MDAwLCAtMjczMTUwLCA5OTAwMCwgOTkw
MDB9LAotCXsgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwg
MTIwMDAwLCAxMjAwMDAsIDEyMDAwMH0sCi19OwotCiBzdHJ1Y3Qgc211XzEzXzBfbWF4X3N1c3Rh
aW5hYmxlX2Nsb2NrcyB7CiAJdWludDMyX3QgZGlzcGxheV9jbG9jazsKIAl1aW50MzJfdCBwaHlf
Y2xvY2s7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2Fs
ZGViYXJhbl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJh
cmFuX3BwdC5jCmluZGV4IGQ2MmNjNmJiMWEzMDUuLmQ2Y2U2NjViYWFmM2IgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jCkBAIC03
OCw2ICs3OCwxMiBAQAogCiAjZGVmaW5lIHNtblBDSUVfRVNNX0NUUkwJCQkweDExMTAwM0QwCiAK
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc211X3RlbXBlcmF0dXJlX3JhbmdlIHNtdTEzX3RoZXJtYWxf
cG9saWN5W10gPQoreworCXstMjczMTUwLCAgOTkwMDAsIDk5MDAwLCAtMjczMTUwLCA5OTAwMCwg
OTkwMDAsIC0yNzMxNTAsIDk5MDAwLCA5OTAwMH0sCisJeyAxMjAwMDAsIDEyMDAwMCwgMTIwMDAw
LCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwfSwKK307CisK
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgY21uMmFzaWNfbXNnX21hcHBpbmcgYWxkZWJhcmFuX21lc3Nh
Z2VfbWFwW1NNVV9NU0dfTUFYX0NPVU5UXSA9IHsKIAlNU0dfTUFQKFRlc3RNZXNzYWdlLAkJCSAg
ICAgUFBTTUNfTVNHX1Rlc3RNZXNzYWdlLAkJCTApLAogCU1TR19NQVAoR2V0U211VmVyc2lvbiwJ
CQkgICAgIFBQU01DX01TR19HZXRTbXVWZXJzaW9uLAkJCTEpLAotLSAKMi4zMS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
