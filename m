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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E675FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBE0651C7
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBE0651C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA676E0CD;
	Mon,  8 Mar 2021 13:40:51 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1717889EBB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:40:49 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id lr13so20494650ejb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=84efQghew0ppWF/tH5Q+5SozQBeZjmOjXlR6pgvRahg=;
 b=q9TAgj7bi50gMHmyLwSWeGWJb48CTyDz6UAAolrb7Z29q39CsiFbjgAIokuekQKfqB
 nRWnGmGQryWcxxJO/Xf5jMFBzk2eQKjKHfoPmmaxh3MMybMI6yyYs0PKZPWM1fkA2DAF
 Odd3LwfHCdBsPufmVSyIsWy6zGdEWltw354HKMqrstYsRA/OWMK5Dtl4MiMQHiNIOoYo
 lda2txgiuYV0opmQeaC4WeuIQjDxJQ9AzxgViCIE7YY8vpzXosG9FmT4CVC/2gcvPyB7
 mZxtHAMPQYh9jLNShRlWMuZISCuX/NoaNhS2feGGWBl92yn45upYWIpPW1uS3LTq1xXC
 3QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=84efQghew0ppWF/tH5Q+5SozQBeZjmOjXlR6pgvRahg=;
 b=K7+A9KNM8igAotqY2kOBCGdmmqypO/JrWxYuSqpXfg3P7AURtv6D14NEfCBkpdL6oR
 ir+gmEb/5nCWLYH+uHc9I909pRv0ITf9pAPk7J8MxHJ0phyVf8qC/Jq1OlxDV25gpQqx
 7WP4aOTWjsEz6UhZQxph6wreqoYQIijqpETwBPMsUYya2Sl0jpa1b6rAG8PbY7j15JD5
 Y7KDqw1VYCAdHfGMMHMc9nAvGRXaawkXyr66FSvpZ8yBq+GgTXS9Onx8Kzr0bbaLvOpX
 VCh91rpaKHpSDou9drll/Br/MijYKF9GkFZa596drzE6ITX7Ea2zO9rsBjZNlhO9gKPl
 JKNA==
X-Gm-Message-State: AOAM531NqkjYOFeZP6JSXEYo6maAxNzIumISwkOj4cJatuKRp4zdVRFR
 k9B17uLmaTiBNubfPk39ieA=
X-Google-Smtp-Source: ABdhPJyYjYXAz0z4ruyqGRL58tw9G5R9RnIUqR9mNvneCPo+/wlxV5fH7+M3gpk5BYM/fevbF8dD+A==
X-Received: by 2002:a17:906:3105:: with SMTP id
 5mr15179150ejx.168.1615210847784; 
 Mon, 08 Mar 2021 05:40:47 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f480:31ac:e949:bf58])
 by smtp.gmail.com with ESMTPSA id s18sm6655701ejc.79.2021.03.08.05.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 05:40:47 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: use the new cursor in amdgpu_fill_buffer
Date: Mon,  8 Mar 2021 14:40:39 +0100
Message-Id: <20210308134044.133658-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308134044.133658-1-christian.koenig@amd.com>
References: <20210308134044.133658-1-christian.koenig@amd.com>
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

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpBY2tlZC1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+ClRlc3RlZC1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyB8IDY1ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggZjcxYTlmZjA2NzQ4Li4zNjVkNTY5M2Y1ZjAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE3OCwyOCArMTc4
LDYgQEAgc3RhdGljIGludCBhbWRncHVfdmVyaWZ5X2FjY2VzcyhzdHJ1Y3QgdHRtX2J1ZmZlcl9v
YmplY3QgKmJvLCBzdHJ1Y3QgZmlsZSAqZmlscCkKIAkJCQkJICBmaWxwLT5wcml2YXRlX2RhdGEp
OwogfQogCi0vKioKLSAqIGFtZGdwdV9tbV9ub2RlX2FkZHIgLSBDb21wdXRlIHRoZSBHUFUgcmVs
YXRpdmUgb2Zmc2V0IG9mIGEgR1RUIGJ1ZmZlci4KLSAqCi0gKiBAYm86IFRoZSBibyB0byBhc3Np
Z24gdGhlIG1lbW9yeSB0by4KLSAqIEBtbV9ub2RlOiBNZW1vcnkgbWFuYWdlciBub2RlIGZvciBk
cm0gYWxsb2NhdG9yLgotICogQG1lbTogVGhlIHJlZ2lvbiB3aGVyZSB0aGUgYm8gcmVzaWRlcy4K
LSAqCi0gKi8KLXN0YXRpYyB1aW50NjRfdCBhbWRncHVfbW1fbm9kZV9hZGRyKHN0cnVjdCB0dG1f
YnVmZmVyX29iamVjdCAqYm8sCi0JCQkJICAgIHN0cnVjdCBkcm1fbW1fbm9kZSAqbW1fbm9kZSwK
LQkJCQkgICAgc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtKQotewotCXVpbnQ2NF90IGFkZHIgPSAw
OwotCi0JaWYgKG1tX25vZGUtPnN0YXJ0ICE9IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCkgewot
CQlhZGRyID0gbW1fbm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVDsKLQkJYWRkciArPSBhbWRncHVf
dHRtX2RvbWFpbl9zdGFydChhbWRncHVfdHRtX2FkZXYoYm8tPmJkZXYpLAotCQkJCQkJbWVtLT5t
ZW1fdHlwZSk7Ci0JfQotCXJldHVybiBhZGRyOwotfQotCiAvKioKICAqIGFtZGdwdV9maW5kX21t
X25vZGUgLSBIZWxwZXIgZnVuY3Rpb24gZmluZHMgdGhlIGRybV9tbV9ub2RlIGNvcnJlc3BvbmRp
bmcgdG8KICAqIEBvZmZzZXQuIEl0IGFsc28gbW9kaWZpZXMgdGhlIG9mZnNldCB0byBiZSB3aXRo
aW4gdGhlIGRybV9tbV9ub2RlIHJldHVybmVkCkBAIC0yMDgxLDkgKzIwNTksOSBAQCBpbnQgYW1k
Z3B1X2ZpbGxfYnVmZmVyKHN0cnVjdCBhbWRncHVfYm8gKmJvLAogCXVpbnQzMl90IG1heF9ieXRl
cyA9IGFkZXYtPm1tYW4uYnVmZmVyX2Z1bmNzLT5maWxsX21heF9ieXRlczsKIAlzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5nOwogCi0Jc3RydWN0
IGRybV9tbV9ub2RlICptbV9ub2RlOwotCXVuc2lnbmVkIGxvbmcgbnVtX3BhZ2VzOworCXN0cnVj
dCBhbWRncHVfcmVzX2N1cnNvciBjdXJzb3I7CiAJdW5zaWduZWQgaW50IG51bV9sb29wcywgbnVt
X2R3OworCXVpbnQ2NF90IG51bV9ieXRlczsKIAogCXN0cnVjdCBhbWRncHVfam9iICpqb2I7CiAJ
aW50IHI7CkBAIC0yMDk5LDE1ICsyMDc3LDEzIEBAIGludCBhbWRncHVfZmlsbF9idWZmZXIoc3Ry
dWN0IGFtZGdwdV9ibyAqYm8sCiAJCQlyZXR1cm4gcjsKIAl9CiAKLQludW1fcGFnZXMgPSBiby0+
dGJvLm1lbS5udW1fcGFnZXM7Ci0JbW1fbm9kZSA9IGJvLT50Ym8ubWVtLm1tX25vZGU7CisJbnVt
X2J5dGVzID0gYm8tPnRiby5tZW0ubnVtX3BhZ2VzIDw8IFBBR0VfU0hJRlQ7CiAJbnVtX2xvb3Bz
ID0gMDsKLQl3aGlsZSAobnVtX3BhZ2VzKSB7Ci0JCXVpbnQ2NF90IGJ5dGVfY291bnQgPSBtbV9u
b2RlLT5zaXplIDw8IFBBR0VfU0hJRlQ7CiAKLQkJbnVtX2xvb3BzICs9IERJVl9ST1VORF9VUF9V
TEwoYnl0ZV9jb3VudCwgbWF4X2J5dGVzKTsKLQkJbnVtX3BhZ2VzIC09IG1tX25vZGUtPnNpemU7
Ci0JCSsrbW1fbm9kZTsKKwlhbWRncHVfcmVzX2ZpcnN0KCZiby0+dGJvLm1lbSwgMCwgbnVtX2J5
dGVzLCAmY3Vyc29yKTsKKwl3aGlsZSAoY3Vyc29yLnJlbWFpbmluZykgeworCQludW1fbG9vcHMg
Kz0gRElWX1JPVU5EX1VQX1VMTChjdXJzb3Iuc2l6ZSwgbWF4X2J5dGVzKTsKKwkJYW1kZ3B1X3Jl
c19uZXh0KCZjdXJzb3IsIGN1cnNvci5zaXplKTsKIAl9CiAJbnVtX2R3ID0gbnVtX2xvb3BzICog
YWRldi0+bW1hbi5idWZmZXJfZnVuY3MtPmZpbGxfbnVtX2R3OwogCkBAIC0yMTI5LDI3ICsyMTA1
LDE2IEBAIGludCBhbWRncHVfZmlsbF9idWZmZXIoc3RydWN0IGFtZGdwdV9ibyAqYm8sCiAJCX0K
IAl9CiAKLQludW1fcGFnZXMgPSBiby0+dGJvLm1lbS5udW1fcGFnZXM7Ci0JbW1fbm9kZSA9IGJv
LT50Ym8ubWVtLm1tX25vZGU7Ci0KLQl3aGlsZSAobnVtX3BhZ2VzKSB7Ci0JCXVpbnQ2NF90IGJ5
dGVfY291bnQgPSBtbV9ub2RlLT5zaXplIDw8IFBBR0VfU0hJRlQ7Ci0JCXVpbnQ2NF90IGRzdF9h
ZGRyOworCWFtZGdwdV9yZXNfZmlyc3QoJmJvLT50Ym8ubWVtLCAwLCBudW1fYnl0ZXMsICZjdXJz
b3IpOworCXdoaWxlIChjdXJzb3IucmVtYWluaW5nKSB7CisJCXVpbnQzMl90IGN1cl9zaXplID0g
bWluX3QodWludDY0X3QsIGN1cnNvci5zaXplLCBtYXhfYnl0ZXMpOworCQl1aW50NjRfdCBkc3Rf
YWRkciA9IGN1cnNvci5zdGFydDsKIAotCQlkc3RfYWRkciA9IGFtZGdwdV9tbV9ub2RlX2FkZHIo
JmJvLT50Ym8sIG1tX25vZGUsICZiby0+dGJvLm1lbSk7Ci0JCXdoaWxlIChieXRlX2NvdW50KSB7
Ci0JCQl1aW50MzJfdCBjdXJfc2l6ZV9pbl9ieXRlcyA9IG1pbl90KHVpbnQ2NF90LCBieXRlX2Nv
dW50LAotCQkJCQkJCSAgIG1heF9ieXRlcyk7CisJCWRzdF9hZGRyICs9IGFtZGdwdV90dG1fZG9t
YWluX3N0YXJ0KGFkZXYsIGJvLT50Ym8ubWVtLm1lbV90eXBlKTsKKwkJYW1kZ3B1X2VtaXRfZmls
bF9idWZmZXIoYWRldiwgJmpvYi0+aWJzWzBdLCBzcmNfZGF0YSwgZHN0X2FkZHIsCisJCQkJCWN1
cl9zaXplKTsKIAotCQkJYW1kZ3B1X2VtaXRfZmlsbF9idWZmZXIoYWRldiwgJmpvYi0+aWJzWzBd
LCBzcmNfZGF0YSwKLQkJCQkJCWRzdF9hZGRyLCBjdXJfc2l6ZV9pbl9ieXRlcyk7Ci0KLQkJCWRz
dF9hZGRyICs9IGN1cl9zaXplX2luX2J5dGVzOwotCQkJYnl0ZV9jb3VudCAtPSBjdXJfc2l6ZV9p
bl9ieXRlczsKLQkJfQotCi0JCW51bV9wYWdlcyAtPSBtbV9ub2RlLT5zaXplOwotCQkrK21tX25v
ZGU7CisJCWFtZGdwdV9yZXNfbmV4dCgmY3Vyc29yLCBjdXJfc2l6ZSk7CiAJfQogCiAJYW1kZ3B1
X3JpbmdfcGFkX2liKHJpbmcsICZqb2ItPmlic1swXSk7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
