Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A18C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A830613C6
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A830613C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07F76E233;
	Tue, 27 Apr 2021 10:54:18 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E0F6E073
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 10:54:14 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id q6so10114577edr.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=s2Efj5QTJrRy/JlGWhUDr4wcakm7hu4JEi7iouVGckE=;
 b=tr3/fF1zDvheOIbfXh5gglmpKpF0fvY8cK4l85dYv5cBvlu4nj7T7M5Nsqlgpid2r1
 X86IWi1B6rGlQh4p1ryqaj1pfr4zAUdkcXyXLD+od2ln52m26Z8SLD6uJG0KVPTqiAX0
 zLm8+xPWgqk3oKoRB2L85+xmjXwYzc3RWYJc3fspV7S+37eMkAMQQsjggz7ofM1ulW/O
 0YyN5R7Qy00xYw5kCiJLIBCozDpCrU4P5iFiUpX9TzzXRTDqryLKPXVkb0jT12J1KjqD
 tdJ/YMq5Tp/MSOYAh3sj92R0ybIBBxHGoqMcTbxnJnXiGIiJUKHg2Kfkn4Ev+XB8mlSz
 ZPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s2Efj5QTJrRy/JlGWhUDr4wcakm7hu4JEi7iouVGckE=;
 b=C33Y6Pbl08qobR7HQK2Sz/qDVR4PeUb5y34mG8GxA7NqIY4yi5348XOWxaSCsHBBv0
 W3p5dYZXOCoSTn3EqXnmsB7Lh/8yqA/Y9Baz2xJVma/ip+8CZcal3hJsb0FWRv8xVcg/
 1gIf+iPROYMtDZSjC+jdoXOd2caaGnY9ZqPffFTvrKObeUlRDtPs/OTZbduWcpsOngTD
 x4QNY0IvG9HzzPK7donlIhgMBNnAfq2i7IB2AUsHkPHZo8EWYKfZ5KTAfXd52Uvu/ySv
 8LRKV1BHyQGWUADwMm2H5vtYpieFb1IcKSYjssBVGg8HjsdLkzM/Wq3uKsiir8xFhQ6C
 0CGw==
X-Gm-Message-State: AOAM532Ix6CoNQgBe17AanXlT/AAgQxpQ/FbD2LQtl0XUupiT46Pab9Q
 SbCdimpUcHHDGbO5zE1A+TG7cW5Xn70=
X-Google-Smtp-Source: ABdhPJwe7aw0UySPNc5IPeH9bE5ueynqrn1ab7EttGiczrt+XHya0McmsfdJTr8XxnknS4KpGpasgA==
X-Received: by 2002:a05:6402:4a:: with SMTP id
 f10mr3488971edu.85.1619520853401; 
 Tue, 27 Apr 2021 03:54:13 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cc40:13c1:6c51:27cd])
 by smtp.gmail.com with ESMTPSA id o8sm12995411ejm.18.2021.04.27.03.54.12
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 03:54:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: check contiguous flags instead of mm_node
Date: Tue, 27 Apr 2021 12:54:09 +0200
Message-Id: <20210427105410.2700-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427105410.2700-1-christian.koenig@amd.com>
References: <20210427105410.2700-1-christian.koenig@amd.com>
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

RHJvcCB0aGUgbGFzdCB1c2VyIG9mIGRybV9tbV9ub2RlLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDExICsrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwppbmRleCA3ZTdkODMzMGQ2NGIuLmIwNjgyNTM1NzVlYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtNTc2LDEwICs1NzYsMTAgQEAg
c3RhdGljIGludCBhbWRncHVfYm9fbW92ZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBi
b29sIGV2aWN0LAogICoKICAqIENhbGxlZCBieSB0dG1fbWVtX2lvX3Jlc2VydmUoKSB1bHRpbWF0
ZWx5IHZpYSB0dG1fYm9fdm1fZmF1bHQoKQogICovCi1zdGF0aWMgaW50IGFtZGdwdV90dG1faW9f
bWVtX3Jlc2VydmUoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsIHN0cnVjdCB0dG1fcmVzb3VyY2Ug
Km1lbSkKK3N0YXRpYyBpbnQgYW1kZ3B1X3R0bV9pb19tZW1fcmVzZXJ2ZShzdHJ1Y3QgdHRtX2Rl
dmljZSAqYmRldiwKKwkJCQkgICAgIHN0cnVjdCB0dG1fcmVzb3VyY2UgKm1lbSkKIHsKIAlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiZGV2KTsKLQlzdHJ1Y3Qg
ZHJtX21tX25vZGUgKm1tX25vZGUgPSBtZW0tPm1tX25vZGU7CiAJc2l6ZV90IGJ1c19zaXplID0g
KHNpemVfdCltZW0tPm51bV9wYWdlcyA8PCBQQUdFX1NISUZUOwogCiAJc3dpdGNoIChtZW0tPm1l
bV90eXBlKSB7CkBAIC01OTMsMTIgKzU5Myw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9pb19t
ZW1fcmVzZXJ2ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwgc3RydWN0IHR0bV9yZXNvdXJjCiAJ
CS8qIGNoZWNrIGlmIGl0J3MgdmlzaWJsZSAqLwogCQlpZiAoKG1lbS0+YnVzLm9mZnNldCArIGJ1
c19zaXplKSA+IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSkKIAkJCXJldHVybiAtRUlOVkFM
OwotCQkvKiBPbmx5IHBoeXNpY2FsbHkgY29udGlndW91cyBidWZmZXJzIGFwcGx5LiBJbiBhIGNv
bnRpZ3VvdXMKLQkJICogYnVmZmVyLCBzaXplIG9mIHRoZSBmaXJzdCBtbV9ub2RlIHdvdWxkIG1h
dGNoIHRoZSBudW1iZXIgb2YKLQkJICogcGFnZXMgaW4gdHRtX3Jlc291cmNlLgotCQkgKi8KKwog
CQlpZiAoYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgJiYKLQkJICAgIChtbV9ub2RlLT5zaXpl
ID09IG1lbS0+bnVtX3BhZ2VzKSkKKwkJICAgIG1lbS0+cGxhY2VtZW50ICYgVFRNX1BMX0ZMQUdf
Q09OVElHVU9VUykKIAkJCW1lbS0+YnVzLmFkZHIgPSAodTggKilhZGV2LT5tbWFuLmFwZXJfYmFz
ZV9rYWRkciArCiAJCQkJCW1lbS0+YnVzLm9mZnNldDsKIAotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
