Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C7C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 12:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE83D20795
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 12:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fiTRFOwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE83D20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B4C6E50B;
	Fri, 23 Oct 2020 12:22:32 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A516E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 12:22:32 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b8so1598971wrn.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EDTVofbCMc0egYLRlqXIN6LpopRSTfzGEie/Zsh4fwY=;
 b=fiTRFOwoZwB1hxJNZHI2zlhvHk6752nqcuemPo2p7RB3dgJfMrL8zJG1C7b96wXT0o
 CIuclNq70jhEjpjWLbUyPf7ujefkEfl/ix1Rp2p+jmflfFn3BtP6l7y4oTaoorGxqss9
 F7MzjoJPPKYCHdVP2dcH2TfnEkXmMA3UKzRks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EDTVofbCMc0egYLRlqXIN6LpopRSTfzGEie/Zsh4fwY=;
 b=FZE4KpWcuiXj61MgtaOdI2C+O60xVYhum6MFGp9gNaOB+QespN106BOhBu5PAYXlaC
 EWZTyV2XV8wQOExHFxjAQKJP9qbZdT7697+Pokvi3wMQM1KJvkO/VBajCJlrtkDu3/Ch
 ea7teHL4K9p0NfNRBLTrvUJBKe/DHQVhAEWxBs06t6TD0f/ImKTg2hZh/x7GjoaKzKR6
 anXqWTs8JN8+zC32wfLxs2e4QXyubizhn7yHNOtdKYjYZBQ/Wauaa9blsN72t1R1ia1W
 LX8jgy5rtDiKT5j74hhnLSQ5OlsXhUYMm2lI292W4mqyhrnW+tQ0h6ELUOoDWr+xS9IM
 Owcg==
X-Gm-Message-State: AOAM533eVMEv8RkYpxTQ/MoZlueEhLlcEhclRdxfFEXUVmTX3l9fokh7
 nU093dX3Hyca2VBM9fcdzT1TrQ==
X-Google-Smtp-Source: ABdhPJy744SH+1F0vP1OFiZleMBBw7T3HuaGHdSIESqwHpxlqcTXhfEAzxhZQrMJs3qkcrYSV/lWWg==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr2300863wrq.282.1603455750031; 
 Fri, 23 Oct 2020 05:22:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:22:29 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 07/65] drm/vblank: Annotate with dma-fence signalling section
Date: Fri, 23 Oct 2020 14:21:18 +0200
Message-Id: <20201023122216.2373294-7-daniel.vetter@ffwll.ch>
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
YyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKaW5kZXggZjEzNWI3OTU5M2RkLi5iYTdl
NzQxNzY0YWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYwpAQCAtMjQsNiArMjQsNyBAQAogICogT1RIRVIg
REVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgogICovCiAKKyNpbmNsdWRlIDxsaW51eC9kbWEtZmVu
Y2UuaD4KICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4KICNpbmNsdWRlIDxsaW51eC9rdGhyZWFk
Lmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlcGFyYW0uaD4KQEAgLTE5MTMsNyArMTkxNCw3IEBA
IGJvb2wgZHJtX2hhbmRsZV92Ymxhbmsoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWduZWQg
aW50IHBpcGUpCiB7CiAJc3RydWN0IGRybV92YmxhbmtfY3J0YyAqdmJsYW5rID0gJmRldi0+dmJs
YW5rW3BpcGVdOwogCXVuc2lnbmVkIGxvbmcgaXJxZmxhZ3M7Ci0JYm9vbCBkaXNhYmxlX2lycTsK
Kwlib29sIGRpc2FibGVfaXJxLCBmZW5jZV9jb29raWU7CiAKIAlpZiAoZHJtX1dBUk5fT05fT05D
RShkZXYsICFkcm1fZGV2X2hhc192YmxhbmsoZGV2KSkpCiAJCXJldHVybiBmYWxzZTsKQEAgLTE5
MjEsNiArMTkyMiw4IEBAIGJvb2wgZHJtX2hhbmRsZV92Ymxhbmsoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgdW5zaWduZWQgaW50IHBpcGUpCiAJaWYgKGRybV9XQVJOX09OKGRldiwgcGlwZSA+PSBk
ZXYtPm51bV9jcnRjcykpCiAJCXJldHVybiBmYWxzZTsKIAorCWZlbmNlX2Nvb2tpZSA9IGRtYV9m
ZW5jZV9iZWdpbl9zaWduYWxsaW5nKCk7CisKIAlzcGluX2xvY2tfaXJxc2F2ZSgmZGV2LT5ldmVu
dF9sb2NrLCBpcnFmbGFncyk7CiAKIAkvKiBOZWVkIHRpbWVzdGFtcCBsb2NrIHRvIHByZXZlbnQg
Y29uY3VycmVudCBleGVjdXRpb24gd2l0aApAQCAtMTkzMyw2ICsxOTM2LDcgQEAgYm9vbCBkcm1f
aGFuZGxlX3ZibGFuayhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgcGlwZSkK
IAlpZiAoIXZibGFuay0+ZW5hYmxlZCkgewogCQlzcGluX3VubG9jaygmZGV2LT52YmxhbmtfdGlt
ZV9sb2NrKTsKIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5ldmVudF9sb2NrLCBpcnFm
bGFncyk7CisJCWRtYV9mZW5jZV9lbmRfc2lnbmFsbGluZyhmZW5jZV9jb29raWUpOwogCQlyZXR1
cm4gZmFsc2U7CiAJfQogCkBAIC0xOTU5LDYgKzE5NjMsOCBAQCBib29sIGRybV9oYW5kbGVfdmJs
YW5rKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlKQogCWlmIChkaXNh
YmxlX2lycSkKIAkJdmJsYW5rX2Rpc2FibGVfZm4oJnZibGFuay0+ZGlzYWJsZV90aW1lcik7CiAK
KwlkbWFfZmVuY2VfZW5kX3NpZ25hbGxpbmcoZmVuY2VfY29va2llKTsKKwogCXJldHVybiB0cnVl
OwogfQogRVhQT1JUX1NZTUJPTChkcm1faGFuZGxlX3ZibGFuayk7Ci0tIAoyLjI4LjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
