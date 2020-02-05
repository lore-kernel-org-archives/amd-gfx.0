Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0FC352A2
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44E020730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4a/P5Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44E020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B8B89E35;
	Wed,  5 Feb 2020 15:40:16 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FEB789C88;
 Wed,  5 Feb 2020 15:40:14 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id t141so2671571ywc.11;
 Wed, 05 Feb 2020 07:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vuO2RgQIhRHrPoIOS6P9hpIDp5H+sQisyjrPWS+rotU=;
 b=U4a/P5Pa+vBXftLpzlpSMwczedmOpU2J/TfhGqQ1o18IplsEQp8TumrzOqL0BJ/Q6k
 PROfFdEiYBiWWGHJV21kYp+fZYNnYZTvyxis9lZnxvoXX+7nz1a8/JEfDzj2n7H9bIGl
 DC9eYYA2Jq6mNx6K6z1JmPVl25OqYPa/xUyVDOacM82XGfJwhS310Mg8drttx+PnR0tN
 4lhCETTxkLolgf7yIKRZyXrxenVQrigWgWrvtFxNZhGh8kKRJx5wGJqSQLaspnApyLIc
 9eXJ9bm173oJTfErF1lmqFoxciCQ5VznTJW040pGNB5EOu4B/j5hSHV5vKIVDzZ603y3
 2/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vuO2RgQIhRHrPoIOS6P9hpIDp5H+sQisyjrPWS+rotU=;
 b=aOguDcU44L4KfppA4TDyakyNhBN1R2a+TA4eUpzB9GBCx/bp1fNTTc42uWBwupLv54
 4zm7qQXHnnCDbGOaC3La8QpiGnB8TlR4WkcnYlNEbN/jJYtr2KGvlUQEpWjQA6y3OF3B
 XLo8HGYvWvJ5oX3nwpPXIGyBynpakhwI/6Zrp4ehi2sXPjX2y1lID6OyfwT3n5CPoiQQ
 u/uDZxXWD3hOfaS9tfFnFgNaGQpqvgFGWmtHaEafd21BJZY/QjgsZxUswHtfkeUUSPvR
 Umei2nIXcZCUefsd8yqz4sLxz/oLrRpMM98x6NOiTBOtiwUf8/SpRDbH+APiWJawRDNV
 lJ/w==
X-Gm-Message-State: APjAAAUtsMtWSKNST2kL4ay9LxBqeSZMWEed3xN+X3WSyU2rjanQ1W3i
 7riR9c6mU5GxBy2mEjpHAu2FVRRJ
X-Google-Smtp-Source: APXvYqxQ6fDoTlN4Q2Re3os87V+GSEV6xqD2QUXsfB2wD3xB2t65GKjWMEIHyR0Cog7cXpoZvMvzBw==
X-Received: by 2002:a5b:144:: with SMTP id c4mr31744112ybp.371.1580917213687; 
 Wed, 05 Feb 2020 07:40:13 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:13 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 05/15] drm/amdgpu/fence: move debugfs init into core amdgpu
 debugfs
Date: Wed,  5 Feb 2020 10:39:50 -0500
Message-Id: <20200205154000.536145-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205154000.536145-1-alexander.deucher@amd.com>
References: <20200205154000.536145-1-alexander.deucher@amd.com>
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgZmVuY2UgaGFuZGxpbmcuCgpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDMgKysrCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyAgIHwgMyAtLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IDg0YzVlOWYyM2M3Ni4uYmNkMTBkYWE2ZTM5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKQEAgLTEy
NDUsNiArMTI0NSw5IEBAIGludCBhbWRncHVfZGVidWdmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCQlkZXZfZXJyKGFkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciBkZWJ1
Z2ZzIGZpbGUgZm9yIFNBXG4iKTsKIAl9CiAKKwlpZiAoYW1kZ3B1X2RlYnVnZnNfZmVuY2VfaW5p
dChhZGV2KSkKKwkJZGV2X2VycihhZGV2LT5kZXYsICJmZW5jZSBkZWJ1Z2ZzIGZpbGUgY3JlYXRp
b24gZmFpbGVkXG4iKTsKKwogCXJldHVybiBhbWRncHVfZGVidWdmc19hZGRfZmlsZXMoYWRldiwg
YW1kZ3B1X2RlYnVnZnNfbGlzdCwKIAkJCQkJQVJSQVlfU0laRShhbWRncHVfZGVidWdmc19saXN0
KSk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVu
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCmluZGV4IDNj
MDEyNTJiMWUwZS4uNzUzMTUyNzA2N2RmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZmVuY2UuYwpAQCAtNTAzLDkgKzUwMyw2IEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVy
X2luaXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCiAgKi8KIGludCBhbWRncHVfZmVu
Y2VfZHJpdmVyX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0JaWYgKGFtZGdw
dV9kZWJ1Z2ZzX2ZlbmNlX2luaXQoYWRldikpCi0JCWRldl9lcnIoYWRldi0+ZGV2LCAiZmVuY2Ug
ZGVidWdmcyBmaWxlIGNyZWF0aW9uIGZhaWxlZFxuIik7Ci0KIAlyZXR1cm4gMDsKIH0KIAotLSAK
Mi4yNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
