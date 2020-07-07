Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5BC43464
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 20:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC00206BE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 20:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NYza4RHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC00206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847D66E519;
	Tue,  7 Jul 2020 20:12:51 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D2F6E511
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 20:12:49 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l2so480965wmf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=McVPt9fJuC6YkxvBQy2jGA4bv0ebGunC4HyUvWhZjbk=;
 b=NYza4RHRT9Nbd5tiuaDvvt87+k7x8TzYBK9/QEGb9/Is2lgqJSOuJN6F8FSSMmLVNz
 AX9kEZIMyNmgI+JilF+jEH3k9RERK+pVA/s56lFytmeok7MwNFT8h3+RidSiuyF0GL3K
 QytzewPz12OhJLJsGQP0sEMa2ZvTYapQq+Oos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=McVPt9fJuC6YkxvBQy2jGA4bv0ebGunC4HyUvWhZjbk=;
 b=mYPrenna5nWgsm9TtYS882pmSoRJfFrr/ucTwFpTcO67zTbuIUiFnOFU8Fc5jdES0g
 fU6t13shCfWSw8UHM9GkXn/1+B3PW27iYDDN7krOCzXiU7+fIV/Ibmt/Vy76yvgRHWYb
 Sjvg6B++5AsQ4tM/7M82PHwLiufJ48Nz93JTp1cnjt6o0RslvTai72QDWqzV1ZOG0sXA
 wccWDy8/PcN/aQyxAkp18hrhhDr8nizLtXHCXIGDfzvC4dt8MaMmf4Z/e1tmj59BzTk8
 whBQc6Z3uJWC+Dnlruj8OTX6A/E38cIAVwwJorQjo6tvOybHnzavRc/SgqvppVfOOgi0
 a7jw==
X-Gm-Message-State: AOAM532TPZCp9avavBM9IlvEbH7MbEG84OffglQUGAiQAc1621baQeYY
 dL9XH00wSFCHPdMvudyM6LqDeg==
X-Google-Smtp-Source: ABdhPJxvv8IOS1X24OSEZRVe7u0HCChwY1utohnpU4U1V2xvfRe6hswS0LJw8ponIMP4FVWNOp1Snw==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr5788472wmi.87.1594152767816; 
 Tue, 07 Jul 2020 13:12:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 13:12:47 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 05/25] drm/vblank: Annotate with dma-fence signalling section
Date: Tue,  7 Jul 2020 22:12:09 +0200
Message-Id: <20200707201229.472834-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
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

VGhpcyBpcyByYXRoZXIgb3ZlcmtpbGwgc2luY2UgY3VycmVudGx5IGFsbCBkcml2ZXJzIGNhbGwg
dGhpcyBmcm9tCmhhcmRpcnEgKG9yIGF0IGxlYXN0IHRpbWVycykuIEJ1dCBtYXliZSBpbiB0aGUg
ZnV0dXJlIHdlJ3JlIGdvaW5nIHRvCmhhdmUgdGhyZWFkIGlycSBoYW5kbGVycyBhbmQgd2hhdCBu
b3QsIGRvZXNuJ3QgaHVydCB0byBiZSBwcmVwYXJlZC4KUGx1cyB0aGlzIGlzIGFuIGVhc3kgc3Rh
cnQgZm9yIHNwcmlua2xpbmcgdGhlc2UgZmVuY2UgYW5ub3RhdGlvbnMgaW50bwpzaGFyZWQgY29k
ZS4KCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlz
dHMubGluYXJvLm9yZwpDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBDaHJpcyBXaWxzb24gPGNocmlzQGNocmlzLXdpbHNvbi5jby51az4KQ2M6IE1hYXJ0ZW4g
TGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+CkNjOiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IERhbmll
bCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9k
cm1fdmJsYW5rLmMgfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV92Ymxhbmsu
YyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKaW5kZXggNDJhODRlYjRjYzhjLi5kNjgx
YWIwOTk2M2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYwpAQCAtMjQsNiArMjQsNyBAQAogICogT1RIRVIg
REVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgogICovCiAKKyNpbmNsdWRlIDxsaW51eC9kbWEtZmVu
Y2UuaD4KICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGVw
YXJhbS5oPgogCkBAIC0xOTA5LDcgKzE5MTAsNyBAQCBib29sIGRybV9oYW5kbGVfdmJsYW5rKHN0
cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlKQogewogCXN0cnVjdCBkcm1f
dmJsYW5rX2NydGMgKnZibGFuayA9ICZkZXYtPnZibGFua1twaXBlXTsKIAl1bnNpZ25lZCBsb25n
IGlycWZsYWdzOwotCWJvb2wgZGlzYWJsZV9pcnE7CisJYm9vbCBkaXNhYmxlX2lycSwgZmVuY2Vf
Y29va2llOwogCiAJaWYgKGRybV9XQVJOX09OX09OQ0UoZGV2LCAhZHJtX2Rldl9oYXNfdmJsYW5r
KGRldikpKQogCQlyZXR1cm4gZmFsc2U7CkBAIC0xOTE3LDYgKzE5MTgsOCBAQCBib29sIGRybV9o
YW5kbGVfdmJsYW5rKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlKQog
CWlmIChkcm1fV0FSTl9PTihkZXYsIHBpcGUgPj0gZGV2LT5udW1fY3J0Y3MpKQogCQlyZXR1cm4g
ZmFsc2U7CiAKKwlmZW5jZV9jb29raWUgPSBkbWFfZmVuY2VfYmVnaW5fc2lnbmFsbGluZygpOwor
CiAJc3Bpbl9sb2NrX2lycXNhdmUoJmRldi0+ZXZlbnRfbG9jaywgaXJxZmxhZ3MpOwogCiAJLyog
TmVlZCB0aW1lc3RhbXAgbG9jayB0byBwcmV2ZW50IGNvbmN1cnJlbnQgZXhlY3V0aW9uIHdpdGgK
QEAgLTE5MjksNiArMTkzMiw3IEBAIGJvb2wgZHJtX2hhbmRsZV92Ymxhbmsoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHBpcGUpCiAJaWYgKCF2YmxhbmstPmVuYWJsZWQpIHsK
IAkJc3Bpbl91bmxvY2soJmRldi0+dmJsYW5rX3RpbWVfbG9jayk7CiAJCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmRldi0+ZXZlbnRfbG9jaywgaXJxZmxhZ3MpOworCQlkbWFfZmVuY2VfZW5kX3Np
Z25hbGxpbmcoZmVuY2VfY29va2llKTsKIAkJcmV0dXJuIGZhbHNlOwogCX0KIApAQCAtMTk1NCw2
ICsxOTU4LDggQEAgYm9vbCBkcm1faGFuZGxlX3ZibGFuayhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
LCB1bnNpZ25lZCBpbnQgcGlwZSkKIAlpZiAoZGlzYWJsZV9pcnEpCiAJCXZibGFua19kaXNhYmxl
X2ZuKCZ2YmxhbmstPmRpc2FibGVfdGltZXIpOwogCisJZG1hX2ZlbmNlX2VuZF9zaWduYWxsaW5n
KGZlbmNlX2Nvb2tpZSk7CisKIAlyZXR1cm4gdHJ1ZTsKIH0KIEVYUE9SVF9TWU1CT0woZHJtX2hh
bmRsZV92YmxhbmspOwotLSAKMi4yNy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
