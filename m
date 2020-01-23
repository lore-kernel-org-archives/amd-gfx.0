Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C96C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E09F2087E
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV1henwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E09F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F786FD1A;
	Thu, 23 Jan 2020 14:21:29 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA696FD09
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 14:21:26 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id m24so2757046wmc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VzLKuSHFBfmvVzlTQr7G7VZp83q1I7UaDtJOMwtwY/4=;
 b=DV1henwKPKNKih1batf+6+lazRE/2Pm9ey+ubBvI31fSkY0ij05AbL3wZvWDOnfeoF
 dLFaUSTX4f339rQlaEHsATprIXYfI7GjtBH1e3U8ExJbyPKGuiRNxLncrjR2+vD6GzI2
 XyxSpLXrbAgW+lzjVIMgL8kqEwfMhb4xgMbS3uONwl3yxrp6D5XA0PRCN5cobl57YDaN
 DOqr3ulpG6gYXYOWHfaXR8qGf30W2NzsufdPax5PwgvoqvPb3eIRySYetDnejahoXml7
 aNRqhFDpCcuqd2+spSsNOagWzMloLVpwXPf/nwKvdYGA33MvA1NyugQzkU+SYima2yRj
 OZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VzLKuSHFBfmvVzlTQr7G7VZp83q1I7UaDtJOMwtwY/4=;
 b=FbN6KLYR7JENWjkupyO2p4sf8SPgRnVzNYU0A4TMgpskOv5kgHRkd3xgvuj+OwFcJa
 cRmNkHOLM9epzuFxtEez/1HSdzRt2AMQKrTOeDOhVqVGUUlJpfS9URhbpgJUkQlamAOG
 IDmPWvNglUGXzA91KnGxnQyOhjhoWF5xmQh02EB/cb/mNDSDRsJ/RPx9bHuwUZu3vm8R
 yh31Ma3Blg/qaTRRcNFad87WTA2+VDl8SCNg2fK3Z8z8aunlyNprOMMcGUTxJmvHNSoz
 /bFFd5+20S6MuKIUnHJaScL0OPint0dZM2nJMw41L4+wAOlbXqmT01sZCxdM4QnoCD4A
 ftGw==
X-Gm-Message-State: APjAAAWeIXshEEh/EHoOXgEYCWiV4jITZ4bnl7Gv2aVZK/Vlvn9O56JD
 ziurMQG+n7BrNa4JzbWUoCEr4Dsc
X-Google-Smtp-Source: APXvYqxWSGglkNW9NsbLXjfpu8KMRQs6G2qUN4NphOzsFXLwTqH7eML2AZs2WuFY1YN/jsvd6wFwKA==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr4467132wmg.146.1579789285508; 
 Thu, 23 Jan 2020 06:21:25 -0800 (PST)
Received: from baker.fritz.box ([2a02:908:1252:fb60:4c9d:da69:4490:b03e])
 by smtp.gmail.com with ESMTPSA id w19sm2713286wmc.22.2020.01.23.06.21.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 06:21:25 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
Subject: [PATCH 2/4] drm/amdgpu: allow higher level PD invalidations
Date: Thu, 23 Jan 2020 15:21:20 +0100
Message-Id: <20200123142122.4084-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200123142122.4084-1-christian.koenig@amd.com>
References: <20200123142122.4084-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWxsb3cgcGFydGlhbCBpbnZhbGlkYXRpb24gb24gdW5hbGxvY2F0ZWQgUERzLiBUaGlzIGlzIHVz
ZWZ1bCB3aGVuIHdlCm5lZWQgdG8gc2lsZW5jZSBmYXVsdHMgdG8gc3RvcCBpbnRlcnJ1cHQgZmxv
b2RzIG9uIFZlZ2EuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCAyMyArKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwppbmRleCA4MTE5ZjMyY2E5NGQuLjBmNzljMTcxMThiZiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTE0NjcsOSArMTQ2Nyw4IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1z
LAogCQkJICogc21hbGxlciB0aGFuIHRoZSBhZGRyZXNzIHNoaWZ0LiBHbyB0byB0aGUgbmV4dAog
CQkJICogY2hpbGQgZW50cnkgYW5kIHRyeSBhZ2Fpbi4KIAkJCSAqLwotCQkJaWYgKCFhbWRncHVf
dm1fcHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkKLQkJCQlyZXR1cm4gLUVOT0VOVDsKLQkJ
CWNvbnRpbnVlOworCQkJaWYgKGFtZGdwdV92bV9wdF9kZXNjZW5kYW50KGFkZXYsICZjdXJzb3Ip
KQorCQkJCWNvbnRpbnVlOwogCQl9IGVsc2UgaWYgKGZyYWcgPj0gcGFyZW50X3NoaWZ0KSB7CiAJ
CQkvKiBJZiB0aGUgZnJhZ21lbnQgc2l6ZSBpcyBldmVuIGxhcmdlciB0aGFuIHRoZSBwYXJlbnQK
IAkJCSAqIHNoaWZ0IHdlIHNob3VsZCBnbyB1cCBvbmUgbGV2ZWwgYW5kIGNoZWNrIGl0IGFnYWlu
LgpAQCAtMTQ4MCw4ICsxNDc5LDE5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVz
KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAogCQl9CiAKIAkJcHQgPSBj
dXJzb3IuZW50cnktPmJhc2UuYm87Ci0JCWlmICghcHQpCi0JCQlyZXR1cm4gLUVOT0VOVDsKKwkJ
aWYgKCFwdCkgeworCQkJLyogV2UgbmVlZCBhbGwgUERzIGFuZCBQVHMgZm9yIG1hcHBpbmcgc29t
ZXRoaW5nLCAqLworCQkJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkKKwkJCQlyZXR1cm4g
LUVOT0VOVDsKKworCQkJLyogYnV0IHVubWFwcGluZyBzb21ldGhpbmcgY2FuIGhhcHBlbiBhdCBh
IGhpZ2hlcgorCQkJICogbGV2ZWwuICovCisJCQlpZiAoIWFtZGdwdV92bV9wdF9hbmNlc3Rvcigm
Y3Vyc29yKSkKKwkJCQlyZXR1cm4gLUVJTlZBTDsKKworCQkJcHQgPSBjdXJzb3IuZW50cnktPmJh
c2UuYm87CisJCQlzaGlmdCA9IHBhcmVudF9zaGlmdDsKKwkJfQogCiAJCS8qIExvb2tzIGdvb2Qg
c28gZmFyLCBjYWxjdWxhdGUgcGFyYW1ldGVycyBmb3IgdGhlIHVwZGF0ZSAqLwogCQlpbmNyID0g
KHVpbnQ2NF90KUFNREdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0OwpAQCAtMTQ5NSw2ICsxNTA1
LDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91
cGRhdGVfcGFyYW1zICpwYXJhbXMsCiAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2Vu
ZCwgZnJhZ19lbmQpOwogCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQp
ID4+IHNoaWZ0OwogCisJCQkvKiBUaGlzIGNhbiBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVyIGxl
dmVsIFBEcyB0bworCQkJICogc2lsZW50IHRvIHN0b3AgZmF1bHQgZmxvb2RzLiAqLworCQkJbnB0
ZXMgPSBtYXgobnB0ZXMsIDF1KTsKIAkJCWFtZGdwdV92bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBw
dCwgY3Vyc29yLmxldmVsLAogCQkJCQkgICAgICAgcGVfc3RhcnQsIGRzdCwgbnB0ZXMsIGluY3Is
CiAJCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKSk7Ci0tIAoyLjE0LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
