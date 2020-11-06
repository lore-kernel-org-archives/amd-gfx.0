Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92348C56202
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E5A2087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXZxFJ0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E5A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3494E6EB3E;
	Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6646EB2A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:07 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d142so2837807wmd.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xaVwrMr6e/jbnTc5qGRYSEriQiljvoWqO6b2JcTWvj4=;
 b=eXZxFJ0DJnXnG4PTRnW4zbY40yCi26ZRguq8FgTlJbA5SNWLBT9jWR5zy1R2sUX1TM
 CMHOP+N7nrftop8HRYZB+EagLdSwgk3Z/SXWWqj/O97kqn1n+TDDyqo8b0KoNy3bReyb
 HPe4pHgcNYeo3m2J+aH4PH4Lc+6HNLQwlmWJ1Yqo5OXuPcc336PxwRnc7u3uPpoqoeQm
 EcbvtA9V1xc983pr9fJX2OQTH+ogpHZKb4opW6oKP9iDkH2ZS+wUuhPTYB4AH4SQRTiJ
 i7HVBe4elFUAD88VJK0DZAAZSjIQE0ehoP3LF/KWBD7ru9eGI0jGKdsWChjT9uWyOavh
 emoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xaVwrMr6e/jbnTc5qGRYSEriQiljvoWqO6b2JcTWvj4=;
 b=R2FCe2StgzWQ1Gf1Vt2dlAzmV00LNfK8HVUE1OrxPyE4LaUr1+BBo85Uk43xhYXZvv
 4uaeNIw5tgHQ0MVeL1m+cuQ6oo+Lts6mLeJZHRLI6Tqato3lGVYPm4sj0BdGre/eh2WV
 7jEviqpjeHUdq+u0lgoRkMaLAsQE/9qYCppjIF/L74J+K35l6xfYN39jWzol75Ok8SAP
 RIDIMtlTBn8uClyKyLgp0KgTCxIN4fqCaLSZIDRvINHzpNYccFY1JmhTEGkDEr1n5028
 yxs56jtIRG9koinQ812hmscKxFuzy+cd7z5GJjysj42jSuoFdpYtOI5fGMD153Y0DITI
 2ojQ==
X-Gm-Message-State: AOAM530xik2op5qesrwTNm5gINRKLvz9hfe457fVtiwd3ohHg6lyxQXS
 6g9Qr1VPdtMWHlzrIhS2LcAQmQ==
X-Google-Smtp-Source: ABdhPJxTmyerXkl8RR0eJrnwM1v2u23YYZVK3Ps71Ip7mBI6xQdbKTgb9Ow5+TUh5vKokN7ikvoPkg==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr1502624wmb.99.1604699406015;
 Fri, 06 Nov 2020 13:50:06 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:05 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/19] drm/radeon/radeon: Move prototype into shared header
Date: Fri,  6 Nov 2020 21:49:40 +0000
Message-Id: <20201106214949.2042120-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VW5mb3J0dW5hdGVseSwgYSBzdWl0YWJsZSBvbmUgZGlkbid0IGFscmVhZHkgZXhpc3QuCgpGaXhl
cyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYzo2Mzc6Njogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhyYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWzigJkgWy1XbWlzc2luZy1w
cm90b3R5cGVzXQogNjM3IHwgYm9vbCByYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWwodm9pZCkKIHwg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5h
cm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzog
bGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
ZGV2aWNlLmMgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuaCB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9kcnYuYyAgICB8ICAzICstLQogMyBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2RldmljZS5oCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYwpp
bmRleCA3ZjM4NGZmZTg0OGE3Li5hZDU3MmY5NjUxOTBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kZXZpY2UuYwpAQCAtNDIsNiArNDIsNyBAQAogI2luY2x1ZGUgPGRybS9kcm1fcHJv
YmVfaGVscGVyLmg+CiAjaW5jbHVkZSA8ZHJtL3JhZGVvbl9kcm0uaD4KIAorI2luY2x1ZGUgInJh
ZGVvbl9kZXZpY2UuaCIKICNpbmNsdWRlICJyYWRlb25fcmVnLmgiCiAjaW5jbHVkZSAicmFkZW9u
LmgiCiAjaW5jbHVkZSAiYXRvbS5oIgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fZGV2aWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2Uu
aApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAwLi5jOGU2ZGQyMDA1MjI0
Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNl
LmgKQEAgLTAsMCArMSwzMiBAQAorLyogcmFkZW9uX2Rydi5oIC0tIFByaXZhdGUgaGVhZGVyIGZv
ciByYWRlb24gZGV2aWNlIC0qLSBsaW51eC1jIC0qLQorICoKKyAqIENvcHlyaWdodCAxOTk5IFBy
ZWNpc2lvbiBJbnNpZ2h0LCBJbmMuLCBDZWRhciBQYXJrLCBUZXhhcy4KKyAqIENvcHlyaWdodCAy
MDAwIFZBIExpbnV4IFN5c3RlbXMsIEluYy4sIEZyZW1vbnQsIENhbGlmb3JuaWEuCisgKiBBbGwg
cmlnaHRzIHJlc2VydmVkLgorICoKKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZy
ZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhCisgKiBjb3B5IG9mIHRoaXMg
c29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2Fy
ZSIpLAorICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91dCByZXN0cmljdGlvbiwgaW5j
bHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgorICogdGhlIHJpZ2h0cyB0byB1c2UsIGNvcHksIG1v
ZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsCisgKiBhbmQvb3Ig
c2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hv
bSB0aGUKKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUg
Zm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgorICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2Ug
YW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2UgKGluY2x1ZGluZyB0aGUgbmV4dAorICogcGFyYWdy
YXBoKSBzaGFsbCBiZSBpbmNsdWRlZCBpbiBhbGwgY29waWVzIG9yIHN1YnN0YW50aWFsIHBvcnRp
b25zIG9mIHRoZQorICogU29mdHdhcmUuCisgKgorICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVE
ICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MgT1IKKyAqIElN
UExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVS
Q0hBTlRBQklMSVRZLAorICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5P
TklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UIFNIQUxMCisgKiBQUkVDSVNJT04gSU5TSUdIVCBB
TkQvT1IgSVRTIFNVUFBMSUVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUgor
ICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9S
VCBPUiBPVEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9O
IFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIKKyAqIERFQUxJTkdTIElOIFRI
RSBTT0ZUV0FSRS4KKyAqLworCisjaWZuZGVmIF9fUkFERU9OX0RFVl9IX18KKyNkZWZpbmUgX19S
QURFT05fREVWX0hfXworCitib29sIHJhZGVvbl9kZXZpY2VfaXNfdmlydHVhbCh2b2lkKTsKKwor
I2VuZGlmCQkJCS8qIF9fUkFERU9OX0RFVl9IX18gKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
ZHJ2LmMKaW5kZXggZjVmMWNiNzAwZDg3My4uNTYwMjY3Y2MyNTg5MiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fZHJ2LmMKQEAgLTUxLDYgKzUxLDcgQEAKICNpbmNsdWRlIDxkcm0vcmFkZW9u
X2RybS5oPgogCiAjaW5jbHVkZSAicmFkZW9uX2Rydi5oIgorI2luY2x1ZGUgInJhZGVvbl9kZXZp
Y2UuaCIKIAogLyoKICAqIEtNUyB3cmFwcGVyLgpAQCAtMzAwLDggKzMwMSw2IEBAIE1PRFVMRV9E
RVZJQ0VfVEFCTEUocGNpLCBwY2lpZGxpc3QpOwogCiBzdGF0aWMgc3RydWN0IGRybV9kcml2ZXIg
a21zX2RyaXZlcjsKIAotYm9vbCByYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWwodm9pZCk7Ci0KIHN0
YXRpYyBpbnQgcmFkZW9uX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwKIAkJCSAgICBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KQogewotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
