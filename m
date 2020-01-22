Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E79DC33CB6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 14:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53492465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+fUY49V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53492465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44D56F52F;
	Wed, 22 Jan 2020 14:03:10 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E9C6F52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 14:03:07 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id j42so7340890wrj.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 06:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VzLKuSHFBfmvVzlTQr7G7VZp83q1I7UaDtJOMwtwY/4=;
 b=B+fUY49VCw7UupOX4zQcBPUkzPx3zhRA6o9/gHtHVpdFCC/hpXMUox3BzNQxkaLOF+
 6A8WpKpshkEg60AfjX7VFr8EWkNzkbuW6HFK2ORntoV3ar4T/fYV4IEvDtNu7IzDDoyY
 xIiQX5i85S6GAIxHFAzuU8x4VDhNqbQMZsEx1VhXrQhk1WOZO7mA+uFaV97MIWBWuG6K
 DXMHEkF+EcTRcQvsTfZyHkjFKunXcIaJ71nLWG9tXBoN7F+mlxd8utmD9k5QWLWs3nLJ
 5vna2hsJCw5alUHO9i+cFdHfgxhRiE3YvDFyqrKuDuX2iQf6RiUr8vCs7ve7en3CuR4p
 CaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VzLKuSHFBfmvVzlTQr7G7VZp83q1I7UaDtJOMwtwY/4=;
 b=mFTsDwQhRQjeZG94HY2Y59O/2cKTYp3xaOEFxVASlP1kV1gFSwujzmDhw4zNKmTUsy
 55TMSCmEdJJTN+HGpcf6xTrwaEz/2aPtaniMrvNNG1LYwe+mC6xqQUCFtBqa+XZyw58Q
 REtLjl7fY74M1bXDgPRxhDIlLbWlF00lCcpipyEkMzFuJKorOxYSomMfuILwabCmmdiA
 UwqH+O1guwbYP9z97/CBfeEfXg+54W5/WbQEDroQCovPS5rH80rQvhbwuRgP9o3aNkrN
 pKNaYkRuPqv2EWQ8ba8Q92Vq/6a1I8rVLF7bobHkhiOq2gYh1NtepI4fUoppvbMVH8N/
 I09Q==
X-Gm-Message-State: APjAAAX+WBP9livWeOqufQp0ykNR+W55v2uE9ZngjSheNqVp8KbT1Bf/
 wNAASvh9Mm7Cio35Og+8r8nKnGPc
X-Google-Smtp-Source: APXvYqyVnBAKg+54g4eInDLG/Xx8iHWqs1Vjvv0sLqt+MJj83eNXcXV0EGh9GPqObdfvBeFr2Cs1MQ==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr12128956wro.56.1579701785732; 
 Wed, 22 Jan 2020 06:03:05 -0800 (PST)
Received: from baker.fritz.box ([2a02:908:1252:fb60:5cf5:1960:5408:ec4f])
 by smtp.gmail.com with ESMTPSA id c195sm4701806wmd.45.2020.01.22.06.03.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Jan 2020 06:03:05 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tom.stdenis@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: allow higher level PD invalidations
Date: Wed, 22 Jan 2020 15:03:03 +0100
Message-Id: <20200122140303.14411-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200122140303.14411-1-christian.koenig@amd.com>
References: <20200122140303.14411-1-christian.koenig@amd.com>
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
