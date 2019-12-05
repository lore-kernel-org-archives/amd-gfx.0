Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0675C2D0C1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9B322525
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B322525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5CE6F898;
	Thu,  5 Dec 2019 13:39:48 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609D06E84C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 13:39:46 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id t2so3676121wrr.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 05:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Io4r29HK6UzUowmsmRio0nIZ4kihkHPeNbr/JjYlPbo=;
 b=ZeZYzD1mLzaMost5P2XaYqjCSRsNEoybypWmuJlInI56BkSnLIG1PeqggDZCMvD6Rf
 j/UoyssdSUN9ZWWj9bNVeZxZp/X+Pv7KaZNAVcR4RulWI/28PtE85GxLt3qmFqWojR9p
 qyZE3OW/WHxQiHal58E5ZLcDe/eDg8ypomiPWPreLOkQTPVL279Ep8CrMlPJZ+6E0QRb
 yA6w8x3aAWrmouu6ATX+CN8FyOjbrQ+n+t3XPWkd1KML7cUxADo3JSFzlPIw0agLwyPI
 4xDkINTSvtBA/s48RmTwc/4VJUkvOIHkjn1aCgZ7blJVA6uI8/7ZoJJ4TPCbuDijbDZE
 8QgQ==
X-Gm-Message-State: APjAAAUJAMPefIS+/pezxxsOLYdiBWH47Ygr+Q3z6pXTCtxCv2qiw/BC
 a8NuoZL/TC+CKi/XLsDRyKIkDtrh
X-Google-Smtp-Source: APXvYqz7ium08g/LnF3VVgKbcKqSuKxSjG2OuMA0FnbudFs4/pyHQT5T8bUrkkNb+7MXZLX5aL3UbA==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr3640863wrx.109.1575553184867; 
 Thu, 05 Dec 2019 05:39:44 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cd79:9e7:bab3:4698])
 by smtp.gmail.com with ESMTPSA id z189sm11219565wmc.2.2019.12.05.05.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 05:39:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, philip.yang@amd.com, Alex.Sierra@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 4/5] drm/amdgpu: add VM eviction lock v2
Date: Thu,  5 Dec 2019 14:39:39 +0100
Message-Id: <20191205133940.3865-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205133940.3865-1-christian.koenig@amd.com>
References: <20191205133940.3865-1-christian.koenig@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Io4r29HK6UzUowmsmRio0nIZ4kihkHPeNbr/JjYlPbo=;
 b=JHya/6ogoHKEUq652Hyx65oZtmO7mPFpL8d4xmbCu81GdCsI4HFwNr4UJavOTDQZ64
 ERIAL7EqdR2H28xHtdaP9nSsNVpql8RR0h29kF2Nglx05R13YbZYFZriyNYAsAL65ycT
 H0SnYp63+B4iHCco9y+MPLnFLSFmHLUJGfLOf0/hf9nt+V3lxPPTirKLJnPoiEVfS5MW
 +v2rND35v4UB77LuX53pDPQ0wyvCE5cMv4MvOT78pIkdZyutvR4ZIxb9L5nEe6TFGnWz
 1sIp3Ydg7hqayP8rkL8aXTeGef5fQyFZa3SwmvMwtz26M5wMgO23UFmVjfbCHVcuR6Ei
 QuSA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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

VGhpcyBhbGxvd3MgdG8gaW52YWxpZGF0ZSBWTSBlbnRyaWVzIHdpdGhvdXQgdGFraW5nIHRoZSBy
ZXNlcnZhdGlvbiBsb2NrLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgIDQgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwppbmRleCAwZDcwMGU4MTU0YzQuLjgzOWQ2ZGYzOTRmYyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTY1Niw3ICs2NTYsNyBAQCBpbnQgYW1kZ3B1X3ZtX3Zh
bGlkYXRlX3B0X2JvcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92
bSAqdm0sCiAJCQkgICAgICB2b2lkICpwYXJhbSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jh
c2UgKmJvX2Jhc2UsICp0bXA7Ci0JaW50IHIgPSAwOworCWludCByOwogCiAJdm0tPmJ1bGtfbW92
ZWFibGUgJj0gbGlzdF9lbXB0eSgmdm0tPmV2aWN0ZWQpOwogCkBAIC02NjUsNyArNjY1LDcgQEAg
aW50IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCiAJCXIgPSB2YWxpZGF0ZShwYXJhbSwgYm8pOwogCQlp
ZiAocikKLQkJCWJyZWFrOworCQkJcmV0dXJuIHI7CiAKIAkJaWYgKGJvLT50Ym8udHlwZSAhPSB0
dG1fYm9fdHlwZV9rZXJuZWwpIHsKIAkJCWFtZGdwdV92bV9ib19tb3ZlZChib19iYXNlKTsKQEAg
LTY3OCw3ICs2NzgsMTEgQEAgaW50IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCQl9CiAJfQogCi0JcmV0
dXJuIHI7CisJbXV0ZXhfbG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOworCXZtLT5ldmljdGluZyA9
IGZhbHNlOworCW11dGV4X3VubG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOworCisJcmV0dXJuIDA7
CiB9CiAKIC8qKgpAQCAtMTU1NSwxNSArMTU1OSwyNSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9i
b191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlpZiAoIShmbGFn
cyAmIEFNREdQVV9QVEVfVkFMSUQpKQogCQlvd25lciA9IEFNREdQVV9GRU5DRV9PV05FUl9LRkQ7
CiAKKwltdXRleF9sb2NrKCZ2bS0+ZXZpY3Rpb25fbG9jayk7CisJaWYgKHZtLT5ldmljdGluZykg
eworCQlyID0gRUlOUFJPR1JFU1M7CisJCWdvdG8gZXJyb3JfdW5sb2NrOworCX0KKwogCXIgPSB2
bS0+dXBkYXRlX2Z1bmNzLT5wcmVwYXJlKCZwYXJhbXMsIG93bmVyLCBleGNsdXNpdmUpOwogCWlm
IChyKQotCQlyZXR1cm4gcjsKKwkJZ290byBlcnJvcl91bmxvY2s7CiAKIAlyID0gYW1kZ3B1X3Zt
X3VwZGF0ZV9wdGVzKCZwYXJhbXMsIHN0YXJ0LCBsYXN0ICsgMSwgYWRkciwgZmxhZ3MpOwogCWlm
IChyKQotCQlyZXR1cm4gcjsKKwkJZ290byBlcnJvcl91bmxvY2s7CiAKLQlyZXR1cm4gdm0tPnVw
ZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKKwlyID0gdm0tPnVwZGF0ZV9mdW5j
cy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKKworZXJyb3JfdW5sb2NrOgorCW11dGV4X3VubG9j
aygmdm0tPmV2aWN0aW9uX2xvY2spOworCXJldHVybiByOwogfQogCiAvKioKQEAgLTI1MjIsMTEg
KzI1MzYsMTkgQEAgYm9vbCBhbWRncHVfdm1fZXZpY3RhYmxlKHN0cnVjdCBhbWRncHVfYm8gKmJv
KQogCWlmICghZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIHRy
dWUpKQogCQlyZXR1cm4gZmFsc2U7CiAKKwkvKiBUcnkgdG8gYmxvY2sgb25nb2luZyB1cGRhdGVz
ICovCisJaWYgKCFtdXRleF90cnlsb2NrKCZib19iYXNlLT52bS0+ZXZpY3Rpb25fbG9jaykpCisJ
CXJldHVybiBmYWxzZTsKKwogCS8qIERvbid0IGV2aWN0IFZNIHBhZ2UgdGFibGVzIHdoaWxlIHRo
ZXkgYXJlIHVwZGF0ZWQgKi8KIAlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZChib19iYXNlLT52
bS0+bGFzdF9kaXJlY3QpIHx8Ci0JICAgICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoYm9fYmFzZS0+
dm0tPmxhc3RfZGVsYXllZCkpCisJICAgICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoYm9fYmFzZS0+
dm0tPmxhc3RfZGVsYXllZCkpIHsKKwkJbXV0ZXhfdW5sb2NrKCZib19iYXNlLT52bS0+ZXZpY3Rp
b25fbG9jayk7CiAJCXJldHVybiBmYWxzZTsKKwl9CiAKKwlib19iYXNlLT52bS0+ZXZpY3Rpbmcg
PSB0cnVlOworCW11dGV4X3VubG9jaygmYm9fYmFzZS0+dm0tPmV2aWN0aW9uX2xvY2spOwogCXJl
dHVybiB0cnVlOwogfQogCkBAIC0yNzczLDYgKzI3OTUsOSBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCXZtLT5s
YXN0X2RpcmVjdCA9IGRtYV9mZW5jZV9nZXRfc3R1YigpOwogCXZtLT5sYXN0X2RlbGF5ZWQgPSBk
bWFfZmVuY2VfZ2V0X3N0dWIoKTsKIAorCW11dGV4X2luaXQoJnZtLT5ldmljdGlvbl9sb2NrKTsK
Kwl2bS0+ZXZpY3RpbmcgPSBmYWxzZTsKKwogCWFtZGdwdV92bV9ib19wYXJhbShhZGV2LCB2bSwg
YWRldi0+dm1fbWFuYWdlci5yb290X2xldmVsLCBmYWxzZSwgJmJwKTsKIAlpZiAodm1fY29udGV4
dCA9PSBBTURHUFVfVk1fQ09OVEVYVF9DT01QVVRFKQogCQlicC5mbGFncyAmPSB+QU1ER1BVX0dF
TV9DUkVBVEVfU0hBRE9XOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAppbmRl
eCBkOTNlYTlhZDg3OWUuLmQ1NjEzZDE4NGU5OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmgKQEAgLTI0Miw2ICsyNDIsMTAgQEAgc3RydWN0IGFtZGdwdV92bSB7CiAJLyog
dHJlZSBvZiB2aXJ0dWFsIGFkZHJlc3NlcyBtYXBwZWQgKi8KIAlzdHJ1Y3QgcmJfcm9vdF9jYWNo
ZWQJdmE7CiAKKwkvKiBMb2NrIHRvIHByZXZlbnQgZXZpY3Rpb24gd2hpbGUgd2UgYXJlIHVwZGF0
aW5nIHBhZ2UgdGFibGVzICovCisJc3RydWN0IG11dGV4CQlldmljdGlvbl9sb2NrOworCWJvb2wJ
CQlldmljdGluZzsKKwogCS8qIEJPcyB3aG8gbmVlZHMgYSB2YWxpZGF0aW9uICovCiAJc3RydWN0
IGxpc3RfaGVhZAlldmljdGVkOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
