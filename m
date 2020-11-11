Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B843CC4742C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5E220659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gv9rARHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49216E0E5;
	Wed, 11 Nov 2020 18:45:24 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7E36E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:36:17 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b6so3519951wrt.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1BMpKgrGRaaFsrowXlZeUlkXnTCJQ5S+7+zF8aRI5RM=;
 b=gv9rARHr4D0R1XbUNjjQpIHG+8Ukz+VROemjmN9deTxOLLwa57CGwe7Yw2nPVD5LkI
 x7sBA5S4Izl8Y+DLOybIvelf93pnTPj30GwSDjNqThbgY52WPq9pGugtalPjo4Me6wOi
 v3Wf9SH9nuttFyN/EE8mWWiXT3JxVUq06ieJknk5W231WtKu0+8a6uSy7vdh1HVUK8ea
 2AC/M3H/iD7QdDK/feCxSxKB0ScDF6vwy8oQrAZTdgXy/8X1ALdG+Vxo9y/csOsWa8Qz
 txo6oqrG/NN9rdWgI6GsC3//RR1aBRg7CpXQRIiN8lqFXulSkUJ5ArqmT2m75r2FCIsu
 /yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1BMpKgrGRaaFsrowXlZeUlkXnTCJQ5S+7+zF8aRI5RM=;
 b=ZkVe9JBaOKeFmyZViLc7nX5w5CIju6PhGap4kswUqA09GfmtdHl8SzqXv913k9j3eV
 +WF9ZiqFP5eBZq3YH3gnHxj+f3zLQJggAmTkiqkZQu/X88A90Bo7DwAiVPVfI+aVLzs+
 09mfYdiajcW0CYTyuoFtBsdP8CM6aB28uPp3Kj1ScEAs2JTWmE29ja4FAFk2hWQxM+4B
 TEufFeNjmuE9lIuCpOv9z/rivXcd83jjKL9S7EA2amysELp9xmixylZiS2IzOCISh56u
 cWNcdPgugjwJpjGYkiuYdCxhv9ALgrLi2rf3LKeBxYSiv7l/oeXHiu2fGqVhhqmkZ/Fq
 aAZg==
X-Gm-Message-State: AOAM5306iJ5Yg7LzUMBMP7OihpX0NctMX96jpUvEYhh2BAvf7qzb4nrO
 Day0WjPIWHoaSgrwAFys45OmTg==
X-Google-Smtp-Source: ABdhPJyUfP02CiM21bckjb6v/8zvCckUDUA51nDOma7tQN+Oa6OdUY9rQNKYPeBoyCSxr/LkFz5tnQ==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr33192388wrs.178.1605119775741; 
 Wed, 11 Nov 2020 10:36:15 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:36:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/19] drm/radeon/evergreen_cs: Move
 'r600_dma_cs_next_reloc()'s prototype to shared header
Date: Wed, 11 Nov 2020 18:35:45 +0000
Message-Id: <20201111183545.1756994-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2020 18:45:15 +0000
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmM6MjM0Mzo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBw
cm90b3R5cGUgZm9yIOKAmHI2MDBfZG1hX2NzX25leHRfcmVsb2PigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQogMjM0MyB8IGludCByNjAwX2RtYV9jc19uZXh0X3JlbG9jKHN0cnVjdCByYWRlb25f
Y3NfcGFyc2VyICpwLAogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQt
b2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vZXZlcmdyZWVuX2NzLmMgfCAzICstLQogZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yNjAwLmggICAgICAgICB8IDQgKysrKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2Nz
LmMgICAgICB8IDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW5fY3Mu
YyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2NzLmMKaW5kZXggNTNiNzVjZjIw
MTk1OC4uMGRlNzlmM2E3ZTNmZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9l
dmVyZ3JlZW5fY3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9jcy5j
CkBAIC0yOCw2ICsyOCw3IEBACiAKICNpbmNsdWRlICJyYWRlb24uaCIKICNpbmNsdWRlICJyYWRl
b25fYXNpYy5oIgorI2luY2x1ZGUgInI2MDAuaCIKICNpbmNsdWRlICJldmVyZ3JlZW5kLmgiCiAj
aW5jbHVkZSAiZXZlcmdyZWVuX3JlZ19zYWZlLmgiCiAjaW5jbHVkZSAiY2F5bWFuX3JlZ19zYWZl
LmgiCkBAIC0zNyw4ICszOCw2IEBACiAKICNkZWZpbmUgUkVHX1NBRkVfQk1fU0laRSBBUlJBWV9T
SVpFKGV2ZXJncmVlbl9yZWdfc2FmZV9ibSkKIAotaW50IHI2MDBfZG1hX2NzX25leHRfcmVsb2Mo
c3RydWN0IHJhZGVvbl9jc19wYXJzZXIgKnAsCi0JCQkgICBzdHJ1Y3QgcmFkZW9uX2JvX2xpc3Qg
Kipjc19yZWxvYyk7CiBzdHJ1Y3QgZXZlcmdyZWVuX2NzX3RyYWNrIHsKIAl1MzIJCQlncm91cF9z
aXplOwogCXUzMgkJCW5iYW5rczsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cjYwMC5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmgKaW5kZXggYTI1OTk3NmE5NTkx
My4uMjFmZTQ0MTk4YTk2NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAw
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmgKQEAgLTI5LDcgKzI5LDkgQEAK
ICNkZWZpbmUgX19SNjAwX0hfXwogCiBzdHJ1Y3QgcjYwMF9hdWRpb19waW47CitzdHJ1Y3QgcmFk
ZW9uX2JvX2xpc3Q7CiBzdHJ1Y3QgcmFkZW9uX2NydGM7CitzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNl
cjsKIHN0cnVjdCByYWRlb25fZGV2aWNlOwogc3RydWN0IHJhZGVvbl9oZG1pX2FjcjsKIApAQCAt
NTAsNCArNTIsNiBAQCB2b2lkIHI2MDBfaGRtaV91cGRhdGVfYWNyKHN0cnVjdCBkcm1fZW5jb2Rl
ciAqZW5jb2RlciwgbG9uZyBvZmZzZXQsCiB2b2lkIHI2MDBfc2V0X3ZiaV9wYWNrZXQoc3RydWN0
IGRybV9lbmNvZGVyICplbmNvZGVyLCB1MzIgb2Zmc2V0KTsKIHZvaWQgcjYwMF9oZG1pX2VuYWJs
ZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsIGJvb2wgZW5hYmxlKTsKIAoraW50IHI2MDBf
ZG1hX2NzX25leHRfcmVsb2Moc3RydWN0IHJhZGVvbl9jc19wYXJzZXIgKnAsCisJCQkgICBzdHJ1
Y3QgcmFkZW9uX2JvX2xpc3QgKipjc19yZWxvYyk7CiAjZW5kaWYJCQkJLyogX19SNjAwX0hfXyAq
LwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2NzLmMgYi9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYwppbmRleCBmMjBiNjE5NDY2ODE2Li5kYzY4ZTUzOGQ1
YTk3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfY3MuYwpAQCAtMjksNiArMjksNyBAQAogCiAjaW5j
bHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFkZW9uX2FzaWMuaCIKKyNpbmNsdWRlICJyNjAw
LmgiCiAjaW5jbHVkZSAicjYwMGQuaCIKICNpbmNsdWRlICJyNjAwX3JlZ19zYWZlLmgiCiAKLS0g
CjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
