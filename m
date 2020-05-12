Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1361C54E8F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872C72137B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XMONIu5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C72137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6DB6E897;
	Tue, 12 May 2020 08:59:59 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D1F6E89D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 08:59:58 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e26so20838196wmk.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kLx974NIZMqcTtktEjSZjvXzGFT/sN3zaOFqis6ynJ4=;
 b=XMONIu5DP+HMrApNuuxLBjrSt037rXZt2ZOk8MGJnrPXZwZxjQNgepQNY5FaUlHKzp
 NnpLCK27EuKk1i4zc5dJBZgXUUO+sBRUwyP2QJzh8l+TxbAyY+2UG2eYiOM+AqnUuE2h
 cBEWsoEqk///Vn/WtO2wLLNhQxn15H9TRBZ1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kLx974NIZMqcTtktEjSZjvXzGFT/sN3zaOFqis6ynJ4=;
 b=VwfWDpI8uSGTpOSAxVgdpvHNy7OK5jzvzD/XDEOqIYcqPrMdvuVF2Z+sACAUqopBBu
 s89bgv63ag6F6mHUkhruuqaC9Ru2y2mZ1nDkMl4Ms2Wm437oj1dl+asLoCOWmYHHqJOJ
 e2uoGVm421WU+6FgIDVvmNDPk9eZtdBiDoOka3flI89mj11ssCdAkFhq7LbPk12r3QzY
 2xAKtbqxeE5rd1m/vRN29em8D7PGltSyrqgLyB5zLcfz8HRm1sPdljWT8wdO7TgcixNv
 5eLQpgVHoMq7kfuO4GvKHGM/WNXh5Fj3sYUiobsBuUt7bQVVRHSKhjyXJXyPSELqiL+l
 mJFw==
X-Gm-Message-State: AGi0PubsSnLwJVCXdC6UTAzF0lFYQnFTYlRu0OR+L+w2NODh92xXAQZj
 UEeXjj2F7ELO65aNbw96NFnGig==
X-Google-Smtp-Source: APiQypLaGju2WZXVsNW4k3kb0cNDedDZi8kpgkf+bDmSvA+Y9bm9G0CROCbMCdeWzLKRHchbjRrBkQ==
X-Received: by 2002:a05:600c:2dda:: with SMTP id
 e26mr27240272wmh.42.1589273997304; 
 Tue, 12 May 2020 01:59:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.01.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 01:59:56 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [RFC 01/17] dma-fence: add might_sleep annotation to _wait()
Date: Tue, 12 May 2020 10:59:28 +0200
Message-Id: <20200512085944.222637-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linaro-mm-sig@lists.linaro.org,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QnV0IG9ubHkgZm9yIG5vbi16ZXJvIHRpbWVvdXQsIHRvIGF2b2lkIGZhbHNlIHBvc2l0aXZlcy4K
Ck9uZSBxdWVzdGlvbiBoZXJlIGlzIHdoZXRoZXIgdGhlIG1pZ2h0X3NsZWVwIHNob3VsZCBiZSB1
bmNvbmRpdGlvbmFsLApvciBvbmx5IGZvciByZWFsIHRpbWVvdXRzLiBJJ20gbm90IHN1cmUsIHNv
IHdlbnQgd2l0aCB0aGUgbW9yZQpkZWZlbnNpdmUgb3B0aW9uLiBCdXQgaW4gdGhlIGludGVyZXN0
IG9mIGxvY2tpbmcgZG93biB0aGUgY3Jvc3MtZHJpdmVyCmRtYV9mZW5jZSBydWxlcyB3ZSBtaWdo
dCB3YW50IHRvIGJlIG1vcmUgYWdncmVzc2l2ZS4KCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5l
bC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpDYzogbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmcKQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBpbnRl
bC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlz
LXdpbHNvbi5jby51az4KQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBs
aW51eC5pbnRlbC5jb20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwu
Y29tPgotLS0KIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UuYyB8IDMgKysrCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1m
ZW5jZS5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCmluZGV4IDA1MmE0MWUyNDUxYy4u
NjgwMjEyNTM0OWZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLmMKKysr
IGIvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCkBAIC0yMDgsNiArMjA4LDkgQEAgZG1hX2Zl
bmNlX3dhaXRfdGltZW91dChzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSwgYm9vbCBpbnRyLCBzaWdu
ZWQgbG9uZyB0aW1lb3V0KQogCWlmIChXQVJOX09OKHRpbWVvdXQgPCAwKSkKIAkJcmV0dXJuIC1F
SU5WQUw7CiAKKwlpZiAodGltZW91dCA+IDApCisJCW1pZ2h0X3NsZWVwKCk7CisKIAl0cmFjZV9k
bWFfZmVuY2Vfd2FpdF9zdGFydChmZW5jZSk7CiAJaWYgKGZlbmNlLT5vcHMtPndhaXQpCiAJCXJl
dCA9IGZlbmNlLT5vcHMtPndhaXQoZmVuY2UsIGludHIsIHRpbWVvdXQpOwotLSAKMi4yNi4yCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
