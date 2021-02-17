Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7274C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8220E6186A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 19:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8220E6186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CA66E1E9;
	Wed, 17 Feb 2021 19:00:36 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174B36E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 19:00:33 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id q10so17869682edt.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BVJEeH7TLcZMZqHzXotgY25Yoew2lcqsqUbL5VN+7DM=;
 b=t51Fur0rbFMq9s/qt9ya8E1+9Ciiwivq0yH6ETDeKc763HH8duDczH5Yf8gxuxZyWH
 tLbAWzeMoRc+IArc6xD7ALEOl4pkp+VMs9qiDNj8EAJ3K6tq/Xe4mkOR0GiBvBwdNYwv
 80NaRBrDVU78sCCUGpgBkq2behALcqh9Pcjrp1mSwTjUM+D0DqR8BZ0JTetaTIwhw3vW
 2gPpCRwW8DTnHj+ZUf6eOX1nY6mc8r+U1O02iQFk482J4RFAQ2Ybb/6fBpS2s9lx+nVo
 5BEJPgEmioX67jlJ9QYJsv/jNok5qz43pmnEd/TDBx4c0ZqHBWEEuSAjpapF0EpTIusC
 7VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BVJEeH7TLcZMZqHzXotgY25Yoew2lcqsqUbL5VN+7DM=;
 b=S5WJihxEfog4VAPRNds2AkSHrmdnK49OTDIaz3QlwOBcvXRISCDdjDQG+MB+P1Lqah
 Ql3kDsDR7+aYxNmRdt9n+UIqBtb9nE4UlI3TBGPvB81oHClret1PNq6ahKYTcvFXSG1h
 oVdb7sbv59LZK9TUXOTe5cejU0c2XfFRO1ZE+FYNlUYrhiWBizWtfHy3uLMJHVutd4sb
 Mod9e2HJHuv5U0eV0DajlfPjVGXBS0/GeUTiI0b1wgkWaCjo6i5uRhm+42WuQWkaJ7QH
 FBPIyELrrdEBuKmdl6ZMyuICp3Q5AiCG7E3IcCouDX8BgO1K8H4lWRsclaVpmUak3vJV
 XDpw==
X-Gm-Message-State: AOAM532elHg28/I8H84tb7MGftOV14KjaErov2pt4V7IlrH7HixX5LO7
 F9YLcM2BjCRMnuVApTG22UWR8jaRIOkzxQ==
X-Google-Smtp-Source: ABdhPJx/zR5Rp9t5AOPw+4RYya9X7BQjfydSplFzak9s8LvuYxqtggvci93bjXeRNHYCTd6jhPEmTQ==
X-Received: by 2002:a05:6402:617:: with SMTP id
 n23mr242768edv.257.1613588431787; 
 Wed, 17 Feb 2021 11:00:31 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:b7c6:d2d7:631c:11b7])
 by smtp.gmail.com with ESMTPSA id r4sm1562710edv.27.2021.02.17.11.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 11:00:31 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ramesh.Errabolu@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: use the new cursor in amdgpu_fill_buffer
Date: Wed, 17 Feb 2021 20:00:23 +0100
Message-Id: <20210217190028.16409-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
References: <20210217190028.16409-1-christian.koenig@amd.com>
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDY1ICsr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCA1MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
aW5kZXggOWYxYWU2MGI3YmE4Li41OWI0OTE5OTgwNDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE5MiwyOCArMTkyLDYgQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X21vdmVfbnVsbChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCW5ld19tZW0tPm1tX25v
ZGUgPSBOVUxMOwogfQogCi0vKioKLSAqIGFtZGdwdV9tbV9ub2RlX2FkZHIgLSBDb21wdXRlIHRo
ZSBHUFUgcmVsYXRpdmUgb2Zmc2V0IG9mIGEgR1RUIGJ1ZmZlci4KLSAqCi0gKiBAYm86IFRoZSBi
byB0byBhc3NpZ24gdGhlIG1lbW9yeSB0by4KLSAqIEBtbV9ub2RlOiBNZW1vcnkgbWFuYWdlciBu
b2RlIGZvciBkcm0gYWxsb2NhdG9yLgotICogQG1lbTogVGhlIHJlZ2lvbiB3aGVyZSB0aGUgYm8g
cmVzaWRlcy4KLSAqCi0gKi8KLXN0YXRpYyB1aW50NjRfdCBhbWRncHVfbW1fbm9kZV9hZGRyKHN0
cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCi0JCQkJICAgIHN0cnVjdCBkcm1fbW1fbm9kZSAq
bW1fbm9kZSwKLQkJCQkgICAgc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtKQotewotCXVpbnQ2NF90
IGFkZHIgPSAwOwotCi0JaWYgKG1tX25vZGUtPnN0YXJ0ICE9IEFNREdQVV9CT19JTlZBTElEX09G
RlNFVCkgewotCQlhZGRyID0gbW1fbm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVDsKLQkJYWRkciAr
PSBhbWRncHVfdHRtX2RvbWFpbl9zdGFydChhbWRncHVfdHRtX2FkZXYoYm8tPmJkZXYpLAotCQkJ
CQkJbWVtLT5tZW1fdHlwZSk7Ci0JfQotCXJldHVybiBhZGRyOwotfQotCiAvKioKICAqIGFtZGdw
dV9maW5kX21tX25vZGUgLSBIZWxwZXIgZnVuY3Rpb24gZmluZHMgdGhlIGRybV9tbV9ub2RlIGNv
cnJlc3BvbmRpbmcgdG8KICAqIEBvZmZzZXQuIEl0IGFsc28gbW9kaWZpZXMgdGhlIG9mZnNldCB0
byBiZSB3aXRoaW4gdGhlIGRybV9tbV9ub2RlIHJldHVybmVkCkBAIC0yMTMwLDkgKzIxMDgsOSBA
QCBpbnQgYW1kZ3B1X2ZpbGxfYnVmZmVyKHN0cnVjdCBhbWRncHVfYm8gKmJvLAogCXVpbnQzMl90
IG1heF9ieXRlcyA9IGFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzLT5maWxsX21heF9ieXRlczsKIAlz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5nOwog
Ci0Jc3RydWN0IGRybV9tbV9ub2RlICptbV9ub2RlOwotCXVuc2lnbmVkIGxvbmcgbnVtX3BhZ2Vz
OworCXN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciBjdXJzb3I7CiAJdW5zaWduZWQgaW50IG51bV9s
b29wcywgbnVtX2R3OworCXVpbnQ2NF90IG51bV9ieXRlczsKIAogCXN0cnVjdCBhbWRncHVfam9i
ICpqb2I7CiAJaW50IHI7CkBAIC0yMTQ4LDE1ICsyMTI2LDEzIEBAIGludCBhbWRncHVfZmlsbF9i
dWZmZXIoc3RydWN0IGFtZGdwdV9ibyAqYm8sCiAJCQlyZXR1cm4gcjsKIAl9CiAKLQludW1fcGFn
ZXMgPSBiby0+dGJvLm51bV9wYWdlczsKLQltbV9ub2RlID0gYm8tPnRiby5tZW0ubW1fbm9kZTsK
KwludW1fYnl0ZXMgPSBiby0+dGJvLm51bV9wYWdlcyA8PCBQQUdFX1NISUZUOwogCW51bV9sb29w
cyA9IDA7Ci0Jd2hpbGUgKG51bV9wYWdlcykgewotCQl1aW50NjRfdCBieXRlX2NvdW50ID0gbW1f
bm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUOwogCi0JCW51bV9sb29wcyArPSBESVZfUk9VTkRfVVBf
VUxMKGJ5dGVfY291bnQsIG1heF9ieXRlcyk7Ci0JCW51bV9wYWdlcyAtPSBtbV9ub2RlLT5zaXpl
OwotCQkrK21tX25vZGU7CisJYW1kZ3B1X3Jlc19maXJzdCgmYm8tPnRiby5tZW0sIDAsIG51bV9i
eXRlcywgJmN1cnNvcik7CisJd2hpbGUgKGN1cnNvci5yZW1haW5pbmcpIHsKKwkJbnVtX2xvb3Bz
ICs9IERJVl9ST1VORF9VUF9VTEwoY3Vyc29yLnNpemUsIG1heF9ieXRlcyk7CisJCWFtZGdwdV9y
ZXNfbmV4dCgmY3Vyc29yLCBjdXJzb3Iuc2l6ZSk7CiAJfQogCW51bV9kdyA9IG51bV9sb29wcyAq
IGFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzLT5maWxsX251bV9kdzsKIApAQCAtMjE3OCwyNyArMjE1
NCwxNiBAQCBpbnQgYW1kZ3B1X2ZpbGxfYnVmZmVyKHN0cnVjdCBhbWRncHVfYm8gKmJvLAogCQl9
CiAJfQogCi0JbnVtX3BhZ2VzID0gYm8tPnRiby5udW1fcGFnZXM7Ci0JbW1fbm9kZSA9IGJvLT50
Ym8ubWVtLm1tX25vZGU7Ci0KLQl3aGlsZSAobnVtX3BhZ2VzKSB7Ci0JCXVpbnQ2NF90IGJ5dGVf
Y291bnQgPSBtbV9ub2RlLT5zaXplIDw8IFBBR0VfU0hJRlQ7Ci0JCXVpbnQ2NF90IGRzdF9hZGRy
OworCWFtZGdwdV9yZXNfZmlyc3QoJmJvLT50Ym8ubWVtLCAwLCBudW1fYnl0ZXMsICZjdXJzb3Ip
OworCXdoaWxlIChjdXJzb3IucmVtYWluaW5nKSB7CisJCXVpbnQzMl90IGN1cl9zaXplID0gbWlu
X3QodWludDY0X3QsIGN1cnNvci5zaXplLCBtYXhfYnl0ZXMpOworCQl1aW50NjRfdCBkc3RfYWRk
ciA9IGN1cnNvci5zdGFydDsKIAotCQlkc3RfYWRkciA9IGFtZGdwdV9tbV9ub2RlX2FkZHIoJmJv
LT50Ym8sIG1tX25vZGUsICZiby0+dGJvLm1lbSk7Ci0JCXdoaWxlIChieXRlX2NvdW50KSB7Ci0J
CQl1aW50MzJfdCBjdXJfc2l6ZV9pbl9ieXRlcyA9IG1pbl90KHVpbnQ2NF90LCBieXRlX2NvdW50
LAotCQkJCQkJCSAgIG1heF9ieXRlcyk7CisJCWRzdF9hZGRyICs9IGFtZGdwdV90dG1fZG9tYWlu
X3N0YXJ0KGFkZXYsIGJvLT50Ym8ubWVtLm1lbV90eXBlKTsKKwkJYW1kZ3B1X2VtaXRfZmlsbF9i
dWZmZXIoYWRldiwgJmpvYi0+aWJzWzBdLCBzcmNfZGF0YSwgZHN0X2FkZHIsCisJCQkJCWN1cl9z
aXplKTsKIAotCQkJYW1kZ3B1X2VtaXRfZmlsbF9idWZmZXIoYWRldiwgJmpvYi0+aWJzWzBdLCBz
cmNfZGF0YSwKLQkJCQkJCWRzdF9hZGRyLCBjdXJfc2l6ZV9pbl9ieXRlcyk7Ci0KLQkJCWRzdF9h
ZGRyICs9IGN1cl9zaXplX2luX2J5dGVzOwotCQkJYnl0ZV9jb3VudCAtPSBjdXJfc2l6ZV9pbl9i
eXRlczsKLQkJfQotCi0JCW51bV9wYWdlcyAtPSBtbV9ub2RlLT5zaXplOwotCQkrK21tX25vZGU7
CisJCWFtZGdwdV9yZXNfbmV4dCgmY3Vyc29yLCBjdXJfc2l6ZSk7CiAJfQogCiAJYW1kZ3B1X3Jp
bmdfcGFkX2liKHJpbmcsICZqb2ItPmlic1swXSk7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
