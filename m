Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0132C71156
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81002206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhUckZuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81002206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912856EC13;
	Fri, 27 Nov 2020 10:15:08 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6208B6E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:17 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t4so2168269wrr.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AsUlZcyK9oDSYfP7aoF4k5mpqGBHBlqjcNJ6DNrVjtQ=;
 b=lhUckZuAchBUkEww102CZlmtg7ZDdRdMNObIae7NG11Fh5nIJxysDWj0BqvK17jNrv
 DYy9m2oKxLW1Fq9PTcR5kfARz1z3tXycyJMK46eHeePCtKMEJdUbSKlzu3XJKBjMoamf
 bUapKZWnMGvaSmW4aL1UA1kIJ8L4S5q7Fm7VncMBM9HnlN1Gmav9EOfrSNVvvzuHvQ2C
 DPvybRAuRRbvvUpsEE3Tamu47wGUBrepeNVKTlG5HmVSEq2RQjcpMlHgWTyVCaO12V6z
 9nOgkzjVza7g9eOwLNv+D5f8ynNDWyWQG+zybg+6hM10t67YMnenfQDPa9zA3swElhzT
 kBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AsUlZcyK9oDSYfP7aoF4k5mpqGBHBlqjcNJ6DNrVjtQ=;
 b=M6hmzuGOuZi8APmlhguonHRBoKASeOB56wIFrY+ztqmi3PPl9JT6LE4tuJNg3GG3Kh
 bE9yIFVqqYeEBKPYhBw9IbSnAX5t9Fdge3vCX/dNSkkbbw/C1wWbj37K4oTwg3lVPUXx
 +mC4Mcr89CLECoGt0kqAiDnFGk7BhDrivrKXGPhgkSJapkbeiamK3sKjCp/P8V+vGLlV
 ip7Gxfxu0mYUCJLswJuj6rle1LsWXAeOT9ldsliqIWBJPtsH0YyTNYdJdx1Hpa3t9loe
 Sdp5ejIaYTSdNtnKxUXXrCvDqJLFAaeC/4KkjpDYlAJ7R7cE5EW6h0UFKgYZWQ3pVR/b
 In6g==
X-Gm-Message-State: AOAM530B1M/Gli7eTixqIKJazjhDvca+nWRkoO2gJjssDJWfuH16jRxp
 01rsOuXnEfO9rGXmEF1Gle/ieA==
X-Google-Smtp-Source: ABdhPJxTtnTSysGbUMGfkOYBe/RMMJUsCFSYyVyn2rfvnPvE5fMIiiMGfiD68z7l/6axdmcLLerg1w==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4113531wrq.204.1606398196124; 
 Thu, 26 Nov 2020 05:43:16 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 20/40] drm/amd/pm/powerplay/hwmgr/vega10_processpptables: Make
 function invoked by reference static
Date: Thu, 26 Nov 2020 13:42:20 +0000
Message-Id: <20201126134240.3214176-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 amd-gfx@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wcm9jZXNz
cHB0YWJsZXMuYzoxMTQ4OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
dmVnYTEwX3BwX3RhYmxlc19pbml0aWFsaXpl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNj
OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiAiR3VzdGF2byBBLiBSLiBTaWx2YSIgPGd1
c3Rhdm9hcnNAa2VybmVsLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dl
cnBsYXkvaHdtZ3IvdmVnYTEwX3Byb2Nlc3NwcHRhYmxlcy5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Byb2Nlc3NwcHRhYmxlcy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX3Byb2Nlc3NwcHRh
Ymxlcy5jCmluZGV4IDUzNTQwNGRlNzhhMjAuLjk1Yjk4ODgyM2Y1MGYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wcm9jZXNzcHB0YWJs
ZXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBf
cHJvY2Vzc3BwdGFibGVzLmMKQEAgLTExNDUsNyArMTE0NSw3IEBAIHN0YXRpYyBpbnQgaW5pdF9k
cG1fMl9wYXJhbWV0ZXJzKAogCXJldHVybiByZXN1bHQ7CiB9CiAKLWludCB2ZWdhMTBfcHBfdGFi
bGVzX2luaXRpYWxpemUoc3RydWN0IHBwX2h3bWdyICpod21ncikKK3N0YXRpYyBpbnQgdmVnYTEw
X3BwX3RhYmxlc19pbml0aWFsaXplKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB7CiAJaW50IHJl
c3VsdCA9IDA7CiAJY29uc3QgQVRPTV9WZWdhMTBfUE9XRVJQTEFZVEFCTEUgKnBvd2VycGxheV90
YWJsZTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
