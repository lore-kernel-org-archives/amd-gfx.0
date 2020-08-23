Return-Path: <SRS0=Mvn9=CB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E464C433E3
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2020 10:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7430020774
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2020 10:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2F0663F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7430020774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E656E4B0;
	Sun, 23 Aug 2020 10:46:33 +0000 (UTC)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D10889E5A;
 Sun, 23 Aug 2020 10:46:21 +0000 (UTC)
Received: by mail-lj1-x241.google.com with SMTP id i10so6452743ljn.2;
 Sun, 23 Aug 2020 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M1jpgR9xxaGL5haqqgC1fWn700aNJTB9DMqO/Z8CzRg=;
 b=d2F0663FtRSFSFJrFtiTAwk0kIaD3HZax9hdeBfVOXv1CRJg95rfknrG4MJeTUYXR/
 BarACZPfn9tEaybE6/HiuSIu5CZVPOvMZcIBXUfwW1PfD4jToFFWPFx6fpUw0uMhNGEC
 fjiW0yc6Pitz0hcE7cIXGhvjmCXUqxaIRapba1Dvs8bx3G5MmDTubdDQ0QmPLrw3qJw4
 zLMGhZHiC6SWceUhHfzeNe0GvN2Y5BjtdTgB3ry8XSatqatrllHVO+z8OB9ilfcNPDYu
 E7TD9kcIj2Nj/px2MrX/gflUM0axkvQQe3IcEbpS2IwYPdQTCXsDhQuMCpAMmGIUlYCn
 V4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=M1jpgR9xxaGL5haqqgC1fWn700aNJTB9DMqO/Z8CzRg=;
 b=lYUBlXxBc2/N5bqwNTGxDtrSmQw4irIUx8IHy7c7fT9uuBEr5KNS/b0qIpuFwBx+ff
 8byu4yBS2dhmFUWGEgqDG96El5HBLTfYucpIUjxU3Yuy3nL0BXImaDGDyG6E52cNrUJs
 I/Sx14wH1cga2Q597BjVxLOcHD0bPnUUB4XSWURSNVCfuq5fYtRWMxcB/beh1zSjgN7a
 CBgiuyMTPerI7gxADFjN68Bl5nzorqc3GEqZLUYFJv8aoqYcCg7PMktigldZy5RgG9UQ
 Ul2IiUUyYJvrOj8lzaPh0/Bbde7C2eqknD35c3MMBkagpty/e0vWO9kGOqKbSVCQy5od
 Y5aQ==
X-Gm-Message-State: AOAM5322j1OWnDq4fyRC27DvFnKdGycbHBfZhkX3yzNJGQlTwnITZje4
 kTB2SCW8oisHexsvFnHFSjvEAByiUB6j3w==
X-Google-Smtp-Source: ABdhPJw9Qh7yif2/z1V//jy2V7tcoga9LYfRxGe7rvVD0rjEnra9yJGxYJRobXtYX2cjtHFf813lNA==
X-Received: by 2002:a2e:9f46:: with SMTP id v6mr431655ljk.66.1598179579622;
 Sun, 23 Aug 2020 03:46:19 -0700 (PDT)
Received: from saturn.localdomain ([2a00:fd00:805f:db00:2509:20d7:e461:9c16])
 by smtp.gmail.com with ESMTPSA id
 h13sm1516301lji.134.2020.08.23.03.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2020 03:46:19 -0700 (PDT)
From: Sam Ravnborg <sam@ravnborg.org>
To: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v2 21/24] drm/amdgpu/atom: Backlight update
Date: Sun, 23 Aug 2020 12:45:29 +0200
Message-Id: <20200823104532.1024798-22-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200823104532.1024798-1-sam@ravnborg.org>
References: <20200823104532.1024798-1-sam@ravnborg.org>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LSBVc2UgbWFjcm9zIGZvciBpbml0aWFsaXphdGlvbgotIFJlcGxhY2UgZGlyZWN0IGFjY2VzcyB0
byBiYWNrbGlnaHRfcHJvcGVydGllcyB3aXRoIGdldCBhbmQgc2V0CiAgb3BlcmF0aW9ucwoKU2ln
bmVkLW9mZi1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4KLS0tCiAuLi4vZ3B1L2RybS9hbWQv
YW1kZ3B1L2F0b21iaW9zX2VuY29kZXJzLmMgICAgfCAxOSArKysrKystLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19lbmNvZGVycy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZW5jb2RlcnMuYwppbmRleCAxZTk0YTli
NjUyZjcuLjg4MmUxYTNkYWQ4YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYXRvbWJpb3NfZW5jb2RlcnMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
dG9tYmlvc19lbmNvZGVycy5jCkBAIC0xMjIsMTUgKzEyMiwxNiBAQCBhbWRncHVfYXRvbWJpb3Nf
ZW5jb2Rlcl9zZXRfYmFja2xpZ2h0X2xldmVsKHN0cnVjdCBhbWRncHVfZW5jb2RlciAqYW1kZ3B1
X2VuY29kZQogCiBzdGF0aWMgdTggYW1kZ3B1X2F0b21iaW9zX2VuY29kZXJfYmFja2xpZ2h0X2xl
dmVsKHN0cnVjdCBiYWNrbGlnaHRfZGV2aWNlICpiZCkKIHsKKwlpbnQgYnJpZ2h0bmVzcyA9IGJh
Y2tsaWdodF9nZXRfYnJpZ2h0bmVzcyhiZCk7CiAJdTggbGV2ZWw7CiAKIAkvKiBDb252ZXJ0IGJy
aWdodG5lc3MgdG8gaGFyZHdhcmUgbGV2ZWwgKi8KLQlpZiAoYmQtPnByb3BzLmJyaWdodG5lc3Mg
PCAwKQorCWlmIChicmlnaHRuZXNzIDwgMCkKIAkJbGV2ZWwgPSAwOwotCWVsc2UgaWYgKGJkLT5w
cm9wcy5icmlnaHRuZXNzID4gQU1ER1BVX01BWF9CTF9MRVZFTCkKKwllbHNlIGlmIChicmlnaHRu
ZXNzID4gQU1ER1BVX01BWF9CTF9MRVZFTCkKIAkJbGV2ZWwgPSBBTURHUFVfTUFYX0JMX0xFVkVM
OwogCWVsc2UKLQkJbGV2ZWwgPSBiZC0+cHJvcHMuYnJpZ2h0bmVzczsKKwkJbGV2ZWwgPSBicmln
aHRuZXNzOwogCiAJcmV0dXJuIGxldmVsOwogfQpAQCAtMTY1LDEzICsxNjYsMTIgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBiYWNrbGlnaHRfb3BzIGFtZGdwdV9hdG9tYmlvc19lbmNvZGVyX2JhY2ts
aWdodF9vcHMgPSB7CiB2b2lkIGFtZGdwdV9hdG9tYmlvc19lbmNvZGVyX2luaXRfYmFja2xpZ2h0
KHN0cnVjdCBhbWRncHVfZW5jb2RlciAqYW1kZ3B1X2VuY29kZXIsCiAJCQkJICAgICBzdHJ1Y3Qg
ZHJtX2Nvbm5lY3RvciAqZHJtX2Nvbm5lY3RvcikKIHsKKwlERUNMQVJFX0JBQ0tMSUdIVF9JTklU
X1JBVyhwcm9wcywgMCwgQU1ER1BVX01BWF9CTF9MRVZFTCk7CiAJc3RydWN0IGRybV9kZXZpY2Ug
KmRldiA9IGFtZGdwdV9lbmNvZGVyLT5iYXNlLmRldjsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7CiAJc3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmJkOwot
CXN0cnVjdCBiYWNrbGlnaHRfcHJvcGVydGllcyBwcm9wczsKIAlzdHJ1Y3QgYW1kZ3B1X2JhY2ts
aWdodF9wcml2ZGF0YSAqcGRhdGE7CiAJc3RydWN0IGFtZGdwdV9lbmNvZGVyX2F0b21fZGlnICpk
aWc7Ci0JdTggYmFja2xpZ2h0X2xldmVsOwogCWNoYXIgYmxfbmFtZVsxNl07CiAKIAkvKiBNYWMg
bGFwdG9wcyB3aXRoIG11bHRpcGxlIEdQVXMgdXNlIHRoZSBnbXV4IGRyaXZlciBmb3IgYmFja2xp
Z2h0CkBAIC0xOTMsOSArMTkzLDYgQEAgdm9pZCBhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9pbml0
X2JhY2tsaWdodChzdHJ1Y3QgYW1kZ3B1X2VuY29kZXIgKmFtZGdwdV9lbmNvZGUKIAkJZ290byBl
cnJvcjsKIAl9CiAKLQltZW1zZXQoJnByb3BzLCAwLCBzaXplb2YocHJvcHMpKTsKLQlwcm9wcy5t
YXhfYnJpZ2h0bmVzcyA9IEFNREdQVV9NQVhfQkxfTEVWRUw7Ci0JcHJvcHMudHlwZSA9IEJBQ0tM
SUdIVF9SQVc7CiAJc25wcmludGYoYmxfbmFtZSwgc2l6ZW9mKGJsX25hbWUpLAogCQkgImFtZGdw
dV9ibCVkIiwgZGV2LT5wcmltYXJ5LT5pbmRleCk7CiAJYmQgPSBiYWNrbGlnaHRfZGV2aWNlX3Jl
Z2lzdGVyKGJsX25hbWUsIGRybV9jb25uZWN0b3ItPmtkZXYsCkBAIC0yMDcsMTQgKzIwNCwxMCBA
QCB2b2lkIGFtZGdwdV9hdG9tYmlvc19lbmNvZGVyX2luaXRfYmFja2xpZ2h0KHN0cnVjdCBhbWRn
cHVfZW5jb2RlciAqYW1kZ3B1X2VuY29kZQogCiAJcGRhdGEtPmVuY29kZXIgPSBhbWRncHVfZW5j
b2RlcjsKIAotCWJhY2tsaWdodF9sZXZlbCA9IGFtZGdwdV9hdG9tYmlvc19lbmNvZGVyX2dldF9i
YWNrbGlnaHRfbGV2ZWxfZnJvbV9yZWcoYWRldik7Ci0KIAlkaWcgPSBhbWRncHVfZW5jb2Rlci0+
ZW5jX3ByaXY7CiAJZGlnLT5ibF9kZXYgPSBiZDsKIAotCWJkLT5wcm9wcy5icmlnaHRuZXNzID0g
YW1kZ3B1X2F0b21iaW9zX2VuY29kZXJfZ2V0X2JhY2tsaWdodF9icmlnaHRuZXNzKGJkKTsKLQli
ZC0+cHJvcHMucG93ZXIgPSBGQl9CTEFOS19VTkJMQU5LOwotCWJhY2tsaWdodF91cGRhdGVfc3Rh
dHVzKGJkKTsKKwliYWNrbGlnaHRfZW5hYmxlX2JyaWdodG5lc3MoYmQsIGFtZGdwdV9hdG9tYmlv
c19lbmNvZGVyX2dldF9iYWNrbGlnaHRfYnJpZ2h0bmVzcyhiZCkpOwogCiAJRFJNX0lORk8oImFt
ZGdwdSBhdG9tIERJRyBiYWNrbGlnaHQgaW5pdGlhbGl6ZWRcbiIpOwogCi0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
