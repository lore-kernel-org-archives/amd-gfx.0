Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF17AC64EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 12:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47DA2168B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 12:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QL0X80IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47DA2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB616E525;
	Fri, 23 Oct 2020 12:22:36 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C7B6E50D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 12:22:32 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id s9so1564826wro.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9/R15F1LsgpmrfF3NNCzaFiRsuDDTsIACKqWmG0SISo=;
 b=QL0X80IRynXXMUZCjYkwF4TVxPMv6OvJXEja8o1OkGXOMBO4FW8qKjIlQHiTaMX6lC
 Vted5qkM0/57rDsZq+bhda1RMP0UNp2QiZQKvEGxG3qdHN+b54wJSOKQ91pPGKKIz2Ar
 +nKGcH1SKaXqQODHi7K9iRIwpw1YNdCyzAKLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9/R15F1LsgpmrfF3NNCzaFiRsuDDTsIACKqWmG0SISo=;
 b=A/EefMQFoY7wHkBfcZGARitMdoCwYWZT2Q9dknvWtWNG9eOOQx1wQ35BXq2eoCLXez
 iHBPRkYP6X4+oWQfCtsCZWd0wmSmTzwTJvHNgeN5Cn0jPvwOs/OvLCPXshpUz77WrX+m
 JRxd/ff+5Hps4Lz55A3yEe5Np51NOycQSYb2XmXYMjIhj+VyZEz+ipOlN4gs5r4QgnI+
 /AWnePrfwMzwodj0xtB7ceaHt/3p5dpuniC2s/FDD/PjGQW5vRVQmURH4I5W/lGZCms9
 Ie7nMoq/pod77ZiLwPq6u0Prd2rRJfq72Kzcrv1d0sFeQTWbiZeqQwzXFYC0oL0DMxUO
 a8qA==
X-Gm-Message-State: AOAM532GGccFFpbBrw8HGv2m6LnV7FxlldMjeGgOigIgZ/pUUv9EcwOX
 otQGQWRi8Zqcakyer6YfsHJ+sA==
X-Google-Smtp-Source: ABdhPJzjwHFFX0eYKKTO5kCI7ZhG3p97yKYVzt0PU/hjOwBpbNrm4zEFSBi8+JEVc4oqTj3X2egovA==
X-Received: by 2002:adf:a1cb:: with SMTP id v11mr2261703wrv.86.1603455751311; 
 Fri, 23 Oct 2020 05:22:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:22:30 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 08/65] drm/amdgpu: add dma-fence annotations to atomic commit
 path
Date: Fri, 23 Oct 2020 14:21:19 +0200
Message-Id: <20201023122216.2373294-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
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
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBuZWVkIGEgY2FuYXJ5IGluIGEgdHRtLWJhc2VkIGF0b21pYyBkcml2ZXIgdG8gbWFrZSBzdXJl
IHRoZQpkbWFfZmVuY2VfYmVnaW4vZW5kX3NpZ25hbGxpbmcgYW5ub3RhdGlvbnMgYWN0dWFsbHkg
d29yay4KCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdA
bGlzdHMubGluYXJvLm9yZwpDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlzLXdpbHNvbi5jby51az4KQ2M6IE1hYXJ0
ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+CkNjOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IERh
bmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA2ICsrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGJiMWJjN2Y1ZDE0OS4uYjA1ZmVjZjA2ZjI1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKQEAgLTU3LDYgKzU3LDcgQEAKIAogI2luY2x1ZGUgIml2c3JjaWQvaXZzcmNpZF92aXNs
YW5kczMwLmgiCiAKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPgogI2luY2x1ZGUgPGxpbnV4
L3ZlcnNpb24uaD4KQEAgLTc0OTIsNiArNzQ5Myw5IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kbV9h
dG9taWNfY29tbWl0X3RhaWwoc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlKQogCXN0cnVj
dCBkbV9jcnRjX3N0YXRlICpkbV9vbGRfY3J0Y19zdGF0ZSwgKmRtX25ld19jcnRjX3N0YXRlOwog
CWludCBjcnRjX2Rpc2FibGVfY291bnQgPSAwOwogCWJvb2wgbW9kZV9zZXRfcmVzZXRfcmVxdWly
ZWQgPSBmYWxzZTsKKwlib29sIGZlbmNlX2Nvb2tpZTsKKworCWZlbmNlX2Nvb2tpZSA9IGRtYV9m
ZW5jZV9iZWdpbl9zaWduYWxsaW5nKCk7CiAKIAlkcm1fYXRvbWljX2hlbHBlcl91cGRhdGVfbGVn
YWN5X21vZGVzZXRfc3RhdGUoZGV2LCBzdGF0ZSk7CiAJZHJtX2F0b21pY19oZWxwZXJfY2FsY190
aW1lc3RhbXBpbmdfY29uc3RhbnRzKHN0YXRlKTsKQEAgLTc4MTYsNiArNzgyMCw4IEBAIHN0YXRp
YyB2b2lkIGFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3RhaWwoc3RydWN0IGRybV9hdG9taWNfc3Rh
dGUgKnN0YXRlKQogCS8qIFNpZ25hbCBIVyBwcm9ncmFtbWluZyBjb21wbGV0aW9uICovCiAJZHJt
X2F0b21pY19oZWxwZXJfY29tbWl0X2h3X2RvbmUoc3RhdGUpOwogCisJZG1hX2ZlbmNlX2VuZF9z
aWduYWxsaW5nKGZlbmNlX2Nvb2tpZSk7CisKIAlpZiAod2FpdF9mb3JfdmJsYW5rKQogCQlkcm1f
YXRvbWljX2hlbHBlcl93YWl0X2Zvcl9mbGlwX2RvbmUoZGV2LCBzdGF0ZSk7CiAKLS0gCjIuMjgu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
