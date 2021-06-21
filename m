Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4483C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 13:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF27361156
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 13:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF27361156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D24589E19;
	Mon, 21 Jun 2021 13:03:31 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD2D89E19;
 Mon, 21 Jun 2021 13:03:31 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id gt18so28630322ejc.11;
 Mon, 21 Jun 2021 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RDB5CnfFEe47+mMXBp9Dz9bs9wkTyMiKMUMfQmnPkdA=;
 b=WR353TOhVbhUbwxifGbxF46swF8OjFP9AncMpa3BdLeaOaKmCC2JUPhfNq5ftHnCRA
 wJSciJAf74yi9I+tpRRf69CFh6veUmtotXAtQ8UU23pD44PDQpoIkkT0xqs7GCJgiWS0
 Cs8+p3f4TveJtviHTeX/x1i2lqWtVY7+5um78oLjUZxPU31vRst2MtoHcmAUEfUcWSed
 zsSsir/TTo5nihKfOV8svkZrcPwAyuKRYZLu59yi31wRB3sJ89TBW8g8g0ua1oaAb+I/
 FhvFvFD5A1/Dvhu3zvG45Wn4DpHpZNc7dmNEW1D74SJsKE909VJhGJDqYljTyohu6cER
 T8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RDB5CnfFEe47+mMXBp9Dz9bs9wkTyMiKMUMfQmnPkdA=;
 b=a5G2JS3YtAgZ2/Ig6ClM2ognQ/buV5L/82yfMyU7vHhC8ZGZXm4d47BTTxuzJS9SZp
 TtfB/j5QAPtD1EE8oqeQn2yRvuSxkQYYzVDDZjugHGxirty4qd+vQdPvlt0DjzI2b85v
 gpIDg5oKeaMJXY8M7jRuB48I1JWBpeKViD+MmEN8MxwQxg0BukiS1tR3EMrI2HWkyjry
 JRqG0wZe8KR2FgF35WpKrnLRuvLFgZjL1DmxibxJmlH06qEdE7my7qrpnqeg+PLHC8yl
 ts2rdUUz1/vPEH4OcK1OVb3Zex+mcGDczZqg89yunApFZWCV2i4YD1Kk0ZKsyEwVxiuS
 eigw==
X-Gm-Message-State: AOAM532DOhwCiGw3xdgifXn8u/AEbfppC5y6f/eO3ygn69xcxnKDr30A
 z2tnAPPUF8VGZkf0TU/Z385w/SEXDBc=
X-Google-Smtp-Source: ABdhPJx8rX2dsSHDFdrnDvkrCbn9ozA0vl2/NcMUSoVpCD4/a/DBP8O2n1xUvpst062j7W2k2UJ2hQ==
X-Received: by 2002:a17:906:6c92:: with SMTP id
 s18mr24282658ejr.246.1624280609659; 
 Mon, 21 Jun 2021 06:03:29 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:bd92:da7:4d23:8910])
 by smtp.gmail.com with ESMTPSA id w10sm5322375edv.34.2021.06.21.06.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 06:03:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/nouveau: wait for moving fence after pinning
Date: Mon, 21 Jun 2021 15:03:26 +0200
Message-Id: <20210621130328.11070-1-christian.koenig@amd.com>
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

V2UgYWN0dWFsbHkgbmVlZCB0byB3YWl0IGZvciB0aGUgbW92aW5nIGZlbmNlIGFmdGVyIHBpbm5p
bmcKdGhlIEJPIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBwaW4gaXMgY29tcGxldGVkLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDQzog
c3RhYmxlQGtlcm5lbC5vcmcKLS0tCiBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X3By
aW1lLmMgfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9w
cmltZS5jIGIvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9wcmltZS5jCmluZGV4IDM0
NzQ4ODY4NWY3NC4uNTkxNzM4NTQ1ZWJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbm91
dmVhdS9ub3V2ZWF1X3ByaW1lLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVh
dV9wcmltZS5jCkBAIC05Myw3ICs5MywxMyBAQCBpbnQgbm91dmVhdV9nZW1fcHJpbWVfcGluKHN0
cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqKQogCWlmIChyZXQpCiAJCXJldHVybiAtRUlOVkFMOwog
Ci0JcmV0dXJuIDA7CisJaWYgKG52Ym8tPmJvLm1vdmluZykgeworCQlyZXQgPSBkbWFfZmVuY2Vf
d2FpdChudmJvLT5iby5tb3ZpbmcsIHRydWUpOworCQlpZiAocmV0KQorCQkJbm91dmVhdV9ib191
bnBpbihudmJvKTsKKwl9CisKKwlyZXR1cm4gcmV0OwogfQogCiB2b2lkIG5vdXZlYXVfZ2VtX3By
aW1lX3VucGluKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqKQotLSAKMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
