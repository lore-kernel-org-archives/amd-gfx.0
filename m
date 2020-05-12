Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBAC54E96
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8180214DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tba/CBQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8180214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B17B6E8AC;
	Tue, 12 May 2020 09:00:05 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94306E8AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 09:00:03 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h17so5458849wrc.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k3OodW5bIt6jtahEoyPvdqvd8L7bfSaZtDSgdgQ0KSE=;
 b=Tba/CBQcoFuTPwNcOK0uHe+q5z5Fq6i1EP5lEPO6yQnGb0xZi3OTwd+ZAJUMrRox80
 JQxMbr1Hy5zgQtio1imHYMaQf8uOuY/D0v6qpXbtodzS2aPiBGDFHO2m+fo/NUnJQtIa
 9QatpvOy7g08efja4D6G7OF9WYNAibebHkhiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k3OodW5bIt6jtahEoyPvdqvd8L7bfSaZtDSgdgQ0KSE=;
 b=E+/vXa9DDsRs29xKZgBoKMMCLTL++ZN6/o8mM5NDRpx6Wb6C2Xf4mtzsNCjwQp/Yg1
 ZVka1s8XnUKZ61uXNwYxBhp35iq4RsS7ozXoM4VCH1PQXWUcStO20o5fTdSYt16RHGAS
 2APH+Lb51ozAiZdxB4hQi8fIIbQn5dkWcRl1WN3fO/3azTMZhSn51EBZQiK0C9gbEN4g
 LxIcNjQmpnae9F7eoRmnuyXBv00FdUPiRfMMksCE7T9R/Xx6wnD8FU5SQv/mtg8iWFKb
 ZasEk1MREsj+wRcK7ykZqervQKtq3ZBDLOKZNl1t6I+ETCIJpjIfOB60JOHx3cbkB8qR
 xNnQ==
X-Gm-Message-State: AGi0PuYvcQmVqgK1c3mdo0LD+gRHiRo2Ypru8WN7q3C6eFf6EOvNwI4z
 R4qy+xHjcPlzl6M4ekxI3i3q0g==
X-Google-Smtp-Source: APiQypLIE0/1kWTahFNGDnQcsBGsaNy02ojJZXXlJ0KfLdzMgemSxmLWkBaf5jP2NOQfTl/RTuSVRw==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr25265512wrh.254.1589274001957; 
 Tue, 12 May 2020 02:00:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 02:00:01 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [RFC 05/17] drm/vblank: Annotate with dma-fence signalling section
Date: Tue, 12 May 2020 10:59:32 +0200
Message-Id: <20200512085944.222637-6-daniel.vetter@ffwll.ch>
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
YyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKaW5kZXggNzU4YmY3NGUxY2FiLi4xMjVl
ZjBjMGY5YTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYwpAQCAtMjQsNiArMjQsNyBAQAogICogT1RIRVIg
REVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgogICovCiAKKyNpbmNsdWRlIDxsaW51eC9kbWEtZmVu
Y2UuaD4KICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGVw
YXJhbS5oPgogCkBAIC0xODk1LDcgKzE4OTYsNyBAQCBib29sIGRybV9oYW5kbGVfdmJsYW5rKHN0
cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlKQogewogCXN0cnVjdCBkcm1f
dmJsYW5rX2NydGMgKnZibGFuayA9ICZkZXYtPnZibGFua1twaXBlXTsKIAl1bnNpZ25lZCBsb25n
IGlycWZsYWdzOwotCWJvb2wgZGlzYWJsZV9pcnE7CisJYm9vbCBkaXNhYmxlX2lycSwgZmVuY2Vf
Y29va2llOwogCiAJaWYgKFdBUk5fT05fT05DRSghZGV2LT5udW1fY3J0Y3MpKQogCQlyZXR1cm4g
ZmFsc2U7CkBAIC0xOTAzLDYgKzE5MDQsOCBAQCBib29sIGRybV9oYW5kbGVfdmJsYW5rKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlKQogCWlmIChXQVJOX09OKHBpcGUg
Pj0gZGV2LT5udW1fY3J0Y3MpKQogCQlyZXR1cm4gZmFsc2U7CiAKKwlmZW5jZV9jb29raWUgPSBk
bWFfZmVuY2VfYmVnaW5fc2lnbmFsbGluZygpOworCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmRldi0+
ZXZlbnRfbG9jaywgaXJxZmxhZ3MpOwogCiAJLyogTmVlZCB0aW1lc3RhbXAgbG9jayB0byBwcmV2
ZW50IGNvbmN1cnJlbnQgZXhlY3V0aW9uIHdpdGgKQEAgLTE5MTUsNiArMTkxOCw3IEBAIGJvb2wg
ZHJtX2hhbmRsZV92Ymxhbmsoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHBp
cGUpCiAJaWYgKCF2YmxhbmstPmVuYWJsZWQpIHsKIAkJc3Bpbl91bmxvY2soJmRldi0+dmJsYW5r
X3RpbWVfbG9jayk7CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+ZXZlbnRfbG9jaywg
aXJxZmxhZ3MpOworCQlkbWFfZmVuY2VfZW5kX3NpZ25hbGxpbmcoZmVuY2VfY29va2llKTsKIAkJ
cmV0dXJuIGZhbHNlOwogCX0KIApAQCAtMTk0MCw2ICsxOTQ0LDggQEAgYm9vbCBkcm1faGFuZGxl
X3ZibGFuayhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgcGlwZSkKIAlpZiAo
ZGlzYWJsZV9pcnEpCiAJCXZibGFua19kaXNhYmxlX2ZuKCZ2YmxhbmstPmRpc2FibGVfdGltZXIp
OwogCisJZG1hX2ZlbmNlX2VuZF9zaWduYWxsaW5nKGZlbmNlX2Nvb2tpZSk7CisKIAlyZXR1cm4g
dHJ1ZTsKIH0KIEVYUE9SVF9TWU1CT0woZHJtX2hhbmRsZV92YmxhbmspOwotLSAKMi4yNi4yCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
