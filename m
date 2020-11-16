Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E6C8300A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DC42225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u31O7pj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DC42225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDD56EA1C;
	Mon, 16 Nov 2020 19:18:20 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632746E060
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:31 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d12so19597008wrr.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uPrx+xhJSBB8cqNRTfRxpV861JL0F49FY7TxVtUc7KQ=;
 b=u31O7pj1zGDcrio/FSlsCBviO7IM8g6lQEnTygECI/nuOgTKY4r0NhHol9iTNLGAn+
 zdLph8fd3Yuh5ALkDKEgxnNG18QYa0bsD7qhmJeuL69Mb72Gr7aBgJip239aK5NAxjs8
 bwmKEWSGIl80oReFzD5dPK4o61T22DBvKtr/Ld97VBLSmDf/T7Qe49a2nsurDTjVNSSP
 d45/vKLH6geRF9spJ2Zzz9ibSFfV7qMS1hWPotwBvP0TCMhLJL+wYrqQCZ9jAz3ZAxka
 tQniI5JB4SFW/5S3t/97fz3dr+LiWmC/rvEilaMRA/NEEYJvS1K5XYJQ4LeiDkKq7xyr
 uBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uPrx+xhJSBB8cqNRTfRxpV861JL0F49FY7TxVtUc7KQ=;
 b=c90F+1rL0NRBw2zMbIIMQqTnIT5ajclBd+61uaG9nFbKCZErHxWC2O+7gWpLbINxZK
 /mU7eRti1mtahYj/XsKRLOXQgl6FLo9LZmHUpmlGVI1hTpavO7vuHPuB7aGn1H/zNGCD
 kbrAda+7Rqoflvlqu3r4ToXPTpJKd71p4oPhulPl/mgRMys7hSKUt9COZNuCI5TWyymh
 1ArPicvvp46R00aBZsqBd+ZdNWSA1APaaqGMJuKFHllCtxcevjS5wyp0cE5ifJO+pYX3
 5L8T/MEJXsSlng5mUYM+cL0/eQe5FxzfbuHMnhR+NPrTsox2lcu+Ge8Vy6fc4ia3RRpg
 Bhmg==
X-Gm-Message-State: AOAM5312mHtP7hiW4GR7v63QXzMkjl7SeoAWjpSBQ+a9/3Zg3N6yebYG
 BJUuL+6zMWupTdthfOJVKJ3HdHLr7dARScKY
X-Google-Smtp-Source: ABdhPJzCHDkei2JEkX1GB2GW8T/eLFBIz2InwIuHUVRCrc6XXSR/icg3z1DWHJMy3glbmKvXNjAaew==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr20117035wrq.236.1605548249538; 
 Mon, 16 Nov 2020 09:37:29 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:28 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/43] drm/radeon/ni_dpm: Move 'ni_get_{pi,
 ps}()'s into shared header
Date: Mon, 16 Nov 2020 17:36:36 +0000
Message-Id: <20201116173700.1830487-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9uaV9kcG0uYzo3Mjc6MjM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3Ig4oCYbmlfZ2V0X3Bp4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDcyNyB8
IHN0cnVjdCBuaV9wb3dlcl9pbmZvICpuaV9nZXRfcGkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYpCiB8IF5+fn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9uaV9kcG0uYzo3MzQ6MTU6
IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYbmlfZ2V0X3Bz4oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KIDczNCB8IHN0cnVjdCBuaV9wcyAqbmlfZ2V0X3BzKHN0cnVjdCBy
YWRlb25fcHMgKnJwcykKIHwgXn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
bmlfZHBtLmggfCAzICsrKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyB8IDMgKy0t
CiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5oIGIvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9uaV9kcG0uaAppbmRleCA2YmJlZTkxODA5MDllLi43NGUzMDE5MzY5MDYzIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RwbS5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vbmlfZHBtLmgKQEAgLTI0Nyw0ICsyNDcsNyBAQCB2b2lkIG5pX3NldF91dmRf
Y2xvY2tfYWZ0ZXJfc2V0X2VuZ19jbG9jayhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKIAog
Ym9vbCBuaV9kcG1fdmJsYW5rX3Rvb19zaG9ydChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
CiAKK3N0cnVjdCBuaV9wb3dlcl9pbmZvICpuaV9nZXRfcGkoc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYpOworc3RydWN0IG5pX3BzICpuaV9nZXRfcHMoc3RydWN0IHJhZGVvbl9wcyAqcnBzKTsK
KwogI2VuZGlmCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwppbmRleCBhODBhMjE0NDdhNzZkLi5jNjhh
YjJmYjFhYzIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMKQEAgLTMwLDYgKzMwLDcgQEAKICNp
bmNsdWRlICJydjc3MC5oIgogI2luY2x1ZGUgInJhZGVvbi5oIgogI2luY2x1ZGUgInJhZGVvbl9h
c2ljLmgiCisjaW5jbHVkZSAibmlfZHBtLmgiCiAjaW5jbHVkZSAic2lfZHBtLmgiCiAjaW5jbHVk
ZSAic2lkLmgiCiAKQEAgLTE3MTksOCArMTcyMCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2lf
cG93ZXJ0dW5lX2RhdGEgcG93ZXJ0dW5lX2RhdGFfaGFpbmFuID0KIH07CiAKIHN0cnVjdCBldmVy
Z3JlZW5fcG93ZXJfaW5mbyAqZXZlcmdyZWVuX2dldF9waShzdHJ1Y3QgcmFkZW9uX2RldmljZSAq
cmRldik7Ci1zdHJ1Y3QgbmlfcG93ZXJfaW5mbyAqbmlfZ2V0X3BpKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KTsKLXN0cnVjdCBuaV9wcyAqbmlfZ2V0X3BzKHN0cnVjdCByYWRlb25fcHMgKnJw
cyk7CiAKIGV4dGVybiBpbnQgc2lfbWNfbG9hZF9taWNyb2NvZGUoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpOwogZXh0ZXJuIHZvaWQgdmNlX3YxXzBfZW5hYmxlX21nY2coc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYsIGJvb2wgZW5hYmxlKTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
