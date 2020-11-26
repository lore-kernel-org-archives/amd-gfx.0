Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A0C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BB4206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1rVMTz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BB4206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F26EBA5;
	Fri, 27 Nov 2020 10:14:48 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0496B6E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:42:47 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k14so2213292wrn.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dmY41ceyc6chYcpESZmZP3QGDnanFIcluGLqchr029A=;
 b=e1rVMTz6bLbCWASJmqUfDpitRKv9ISCBYaTNCD0SsSAd2EevlEBxrDdSKB+rQAYuFU
 8rr0oxy3WkZj1teuHpAo7OhQRMfaVPWERVifkADPWDCscLCwxlhpbpAl2LORsJ9Ui0rg
 OObbVbb/IohqBdFI9IFOxkjXusCH1fFfn4hLae9Cnj+rpHn0caLy1qwtkD2LImtKrn8v
 6tA0xY4l+ViFaqf7bT6YmrhuJQiz/rwJyTU8lb6/112ic37dwpE9bXfBwZeB9WBS9kIl
 hZIA2MDWZJQC0Hp2Lh0GAUnYFNRGY2M6211dL4sn+pPH9Jk9PvbofcF7LWhBFxx9C5BD
 /UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dmY41ceyc6chYcpESZmZP3QGDnanFIcluGLqchr029A=;
 b=PSsoGpNb2neDxofKxun1IQz+hDSAl+CFl/Ac+jcURPjycIWqoQs6AOuoqrZ/C0RI58
 eDs54dttVskCC3jnnIBDu9V/BQZP/7ON0oWaK2sNodONNQPn/Fa6L6eqLZVOCXr9Pqli
 5oorumKd+LVEhwII2xQsv8b+RlrgPlSElarzsK6IxygCFvC7izLNEFZ9mT+t5Om8JmFM
 BvdF5eyxzG9kyTAQvTHkujbF9xec5JZWuJTRBIyoOHxC3PRm9zqwkCNtZAn4L4gwM7TU
 JHLrmS9nWnmX3oRinm8DzTXdb7BJVoft/p6DuIwx6almt5wfoNn3Aw1mXpUbnveUtyeh
 URnw==
X-Gm-Message-State: AOAM530glttx9PSIQWSfeJtyJs7DeSAiMGKTQWKo67YMtuzdQG/R+kfh
 YDcepd0DPrmC4l7gNvGvrQEbEg==
X-Google-Smtp-Source: ABdhPJwQFSXC5wh+xxoo2UvAuPfEbz5ABc/LCULY9XBt+X2t0p9Y7pi4DpLwBb/4gHK4J8jJ1Nl8MQ==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr3870152wrp.142.1606398166640; 
 Thu, 26 Nov 2020 05:42:46 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:45 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/40] drm/amd/pm/powerplay/smumgr/polaris10_smumgr: Make
 function called by reference static
Date: Thu, 26 Nov 2020 13:42:02 +0000
Message-Id: <20201126134240.3214176-3-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211
bWdyLmM6MjE0NTo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHBvbGFy
aXMxMF90aGVybWFsX2F2ZnNfZW5hYmxl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBF
dmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211bWdyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJpczEwX3NtdW1nci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL3BvbGFyaXMxMF9zbXVtZ3IuYwppbmRl
eCAwNTJiYzg4Y2YzM2M5Li40NTIxNGEzNjRiYWE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJpczEwX3NtdW1nci5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211bWdyLmMKQEAg
LTIxNDIsNyArMjE0Miw3IEBAIHN0YXRpYyBpbnQgcG9sYXJpczEwX3Byb2dyYW1fbWVtX3RpbWlu
Z19wYXJhbWV0ZXJzKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiAJcmV0dXJuIDA7CiB9CiAKLWlu
dCBwb2xhcmlzMTBfdGhlcm1hbF9hdmZzX2VuYWJsZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQor
c3RhdGljIGludCBwb2xhcmlzMTBfdGhlcm1hbF9hdmZzX2VuYWJsZShzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyKQogewogCXN0cnVjdCBzbXU3X2h3bWdyICpkYXRhID0gKHN0cnVjdCBzbXU3X2h3bWdy
ICopKGh3bWdyLT5iYWNrZW5kKTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
