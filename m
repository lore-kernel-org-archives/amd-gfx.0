Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD6EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5086518A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5086518A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A5B6E81A;
	Mon,  8 Mar 2021 18:36:46 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8F36E81A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 18:36:45 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id m9so16210473edd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NJnJyWUaxJTQu9pA6DKXa0e99y/6ZJpwKtlZfcJ2p8w=;
 b=dVws8MMi2kQHOLx3XEYmwiB++xI/sbLQ7VTTpgYA8yOLImCs+6M/w7+9ec+l4RTs1z
 Pzv0i9EhEAgAVYbiJzTWX9jcLpBln+HruYuqZs3s2uWHT4/Uk2mtv5IHOGhSro8TFowJ
 R0B37shG0k8d+pihvyoUfQVGBLS2HzIxV62tG/VGjVYiqpb4nyN4U9LEzN8GOhCEVJT1
 oTa0awfwCL/opm+C2jQzvLlkpj6YgqwQbv3hev+j7ocyvP11yC2dc6smYtNx3xRYk3a7
 u3BOXTnLeTJ9nvYmLoiKIWRn+16To387PzyeeTXlA12OyProQ4BcyQpvYI5Z9S1GQ35/
 q8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NJnJyWUaxJTQu9pA6DKXa0e99y/6ZJpwKtlZfcJ2p8w=;
 b=FVB17Kk0Jn0intDFdZDGB5jijoCKNgXt7TBbRw/bSW5tUvTvIU1IaeIAVZKpqOM99R
 w8+QZuDl1m0BUFOvHUXOgzmuQ9uJDDexnpksvPl9IfNR4z72wfV2n7IocOPYY98hAiiU
 6Vr2gEMrHiGEAhPp602RIUk69Bw/vaEJGMfVJsWP/umelziTRVewN8KnwBJtnK5EGNij
 L0xfHjGLM8aR12kksFD0+lb57IE8KrisFjHEPoueXP3Z+QVVmCQBP8yLbJQI7Twtk+qa
 bAHrkZczJvjyRXfwNCM085NaUhbyrWPtqGEugrDBRoSfhXVAqpunUXQu2kMJv4eE33gm
 RV8Q==
X-Gm-Message-State: AOAM530jXnWOaaBSc4xxTxRNg4U1xz5o7cE+zyF04qQd+4k215wMGfgj
 V99P74VP718mtkZGIwHSvvYp6926PNhrRg==
X-Google-Smtp-Source: ABdhPJwOL+MsBoDPxHyHeyIjBer+7/PnZsnhzPeoTnrNd+HVV9bHshPj/rwr2p0TJ0RWVmhTuXWCGQ==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id
 ds1mr19675531edb.135.1615228604639; 
 Mon, 08 Mar 2021 10:36:44 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5f05:a903:d4af:1240])
 by smtp.gmail.com with ESMTPSA id n16sm6972029ejy.35.2021.03.08.10.36.43
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 10:36:44 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/radeon: also init GEM funcs in
 radeon_gem_prime_import_sg_table
Date: Mon,  8 Mar 2021 19:36:41 +0100
Message-Id: <20210308183643.36710-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

T3RoZXJ3aXNlIHdlIHdpbGwgcnVuIGludG8gYSBOVUxMIHB0ciBkZXJlZi4KClNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQnVnOiBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxMjEzNwotLS0KIGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmggICAgICAgfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9nZW0uYyAgIHwgNCArKy0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9wcmltZS5jIHwgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24u
aCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKaW5kZXggMmRjZGQ4NDQ4MzMxLi40
MjI4MWZjZTU1MmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaApAQCAtNTY3LDYgKzU2Nyw4IEBA
IHN0cnVjdCByYWRlb25fZ2VtIHsKIAlzdHJ1Y3QgbGlzdF9oZWFkCW9iamVjdHM7CiB9OwogCitl
eHRlcm4gY29uc3Qgc3RydWN0IGRybV9nZW1fb2JqZWN0X2Z1bmNzIHJhZGVvbl9nZW1fb2JqZWN0
X2Z1bmNzOworCiBpbnQgcmFkZW9uX2dlbV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
KTsKIHZvaWQgcmFkZW9uX2dlbV9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIGlu
dCByYWRlb25fZ2VtX29iamVjdF9jcmVhdGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHVu
c2lnbmVkIGxvbmcgc2l6ZSwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2VtLmMKaW5kZXggNDEy
YWIzMTgxZjg0Li4wNWVhMmYzOWY2MjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2dlbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5j
CkBAIC00Miw3ICs0Miw3IEBAIHN0cnVjdCBzZ190YWJsZSAqcmFkZW9uX2dlbV9wcmltZV9nZXRf
c2dfdGFibGUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmopOwogaW50IHJhZGVvbl9nZW1fcHJp
bWVfcGluKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqKTsKIHZvaWQgcmFkZW9uX2dlbV9wcmlt
ZV91bnBpbihzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaik7CiAKLXN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHJtX2dlbV9vYmplY3RfZnVuY3MgcmFkZW9uX2dlbV9vYmplY3RfZnVuY3M7Citjb25zdCBz
dHJ1Y3QgZHJtX2dlbV9vYmplY3RfZnVuY3MgcmFkZW9uX2dlbV9vYmplY3RfZnVuY3M7CiAKIHN0
YXRpYyB2b2lkIHJhZGVvbl9nZW1fb2JqZWN0X2ZyZWUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpn
b2JqKQogewpAQCAtMjI2LDcgKzIyNiw3IEBAIHN0YXRpYyBpbnQgcmFkZW9uX2dlbV9oYW5kbGVf
bG9ja3VwKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgcikKIAlyZXR1cm4gcjsKIH0K
IAotc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fZ2VtX29iamVjdF9mdW5jcyByYWRlb25fZ2VtX29i
amVjdF9mdW5jcyA9IHsKK2NvbnN0IHN0cnVjdCBkcm1fZ2VtX29iamVjdF9mdW5jcyByYWRlb25f
Z2VtX29iamVjdF9mdW5jcyA9IHsKIAkuZnJlZSA9IHJhZGVvbl9nZW1fb2JqZWN0X2ZyZWUsCiAJ
Lm9wZW4gPSByYWRlb25fZ2VtX29iamVjdF9vcGVuLAogCS5jbG9zZSA9IHJhZGVvbl9nZW1fb2Jq
ZWN0X2Nsb3NlLApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fcHJp
bWUuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ByaW1lLmMKaW5kZXggYWIyOWVi
OWU4NjY3Li40MmE4Nzk0OGUyOGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3ByaW1lLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fcHJpbWUu
YwpAQCAtNTYsNiArNTYsOCBAQCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKnJhZGVvbl9nZW1fcHJp
bWVfaW1wb3J0X3NnX3RhYmxlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCiAJaWYgKHJldCkKIAkJ
cmV0dXJuIEVSUl9QVFIocmV0KTsKIAorCWJvLT50Ym8uYmFzZS5mdW5jcyA9ICZyYWRlb25fZ2Vt
X29iamVjdF9mdW5jczsKKwogCW11dGV4X2xvY2soJnJkZXYtPmdlbS5tdXRleCk7CiAJbGlzdF9h
ZGRfdGFpbCgmYm8tPmxpc3QsICZyZGV2LT5nZW0ub2JqZWN0cyk7CiAJbXV0ZXhfdW5sb2NrKCZy
ZGV2LT5nZW0ubXV0ZXgpOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
