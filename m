Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85CCC54E9A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF722184D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GdZJjNq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF722184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391776E8BA;
	Tue, 12 May 2020 09:00:10 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB146E8BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 09:00:08 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k12so20803389wmj.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r5PRcG/JtprEwCOUf2/ZPMLqKS9RbW1APrGVc2im3Nw=;
 b=GdZJjNq28F9KcRJyjlTagS8E3fkL1j9MVdiS32+c3J3oz4My0gpMGd7IrjrVwziyZj
 3INpjpPYeyhbD4+NwUOkIx7M0B6lMTqDeQsZGgAtFaTLfzA0CcV9W86y8Gzd1CxGRleL
 BXUlHw6StLiPmKsmxJLvaFWoCXKd6BPsYXKG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r5PRcG/JtprEwCOUf2/ZPMLqKS9RbW1APrGVc2im3Nw=;
 b=i6oTszQ57ksZ1bE5AyKzkGuaWvZA7yetNO7cUASBz4wZGmHZMER2BR9SsJC7xRXYE8
 x7KxS5TW753yxMZ8kr7AsaxNLfMq6n8HaFb6JwTvTnJ2l0N3qPnQYRQKfWqlpKsuanFX
 CTjoxAf5JffYoV+SoNIT9XTJZwwiVCCB5JJ6l2d1REQAuQqLyrX8GiI4PQcDyxnq2HMm
 FPXwDhtb/PprbAt3x0K3PjkiTcTqj9Iu+S5hl5+d6hXOSK0EJanftc4l4XikOoX5ZQ1i
 IdzBeLJL0xuwn+aaWGxX9VNsLJMNsnO/u7G4WKOm5r3WDzwG03X95jeozFxxYjO4Aflu
 KGOA==
X-Gm-Message-State: AGi0PuabKygBwRo995SH8TpIB5IVlz69kXlZrH0pmUudpQdgvX9GBMA0
 d7otzQfQUH5AbodjWf/zizG4og==
X-Google-Smtp-Source: APiQypLn0gzMJwxb1G5NuhzTlxFQ4Fcx0V6C0P/n0rDCyjAZoEVClTf3ENM81ku64jmXd4+qf9UzyQ==
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr13224168wmg.127.1589274007383; 
 Tue, 12 May 2020 02:00:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 02:00:06 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [RFC 10/17] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
Date: Tue, 12 May 2020 10:59:37 +0200
Message-Id: <20200512085944.222637-11-daniel.vetter@ffwll.ch>
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

TXkgZG1hLWZlbmNlIGxvY2tkZXAgYW5ub3RhdGlvbnMgY2F1Z2h0IGFuIGludmVyc2lvbiBiZWNh
dXNlIHdlCmFsbG9jYXRlIG1lbW9yeSB3aGVyZSB3ZSByZWFsbHkgc2hvdWxkbid0OgoKCWttZW1f
Y2FjaGVfYWxsb2MrMHgyYi8weDZkMAoJYW1kZ3B1X2ZlbmNlX2VtaXQrMHgzMC8weDMzMCBbYW1k
Z3B1XQoJYW1kZ3B1X2liX3NjaGVkdWxlKzB4MzA2LzB4NTUwIFthbWRncHVdCglhbWRncHVfam9i
X3J1bisweDEwZi8weDI2MCBbYW1kZ3B1XQoJZHJtX3NjaGVkX21haW4rMHgxYjkvMHg0OTAgW2dw
dV9zY2hlZF0KCWt0aHJlYWQrMHgxMmUvMHgxNTAKClRyb3VibGUgcmlnaHQgbm93IGlzIHRoYXQg
bG9ja2RlcCBvbmx5IHZhbGlkYXRlcyBhZ2FpbnN0IEdGUF9GUywgd2hpY2gKd291bGQgYmUgZ29v
ZCBlbm91Z2ggZm9yIHNocmlua2Vycy4gQnV0IGZvciBtbXVfbm90aWZpZXJzIHdlIGFjdHVhbGx5
Cm5lZWQgIUdGUF9BVE9NSUMsIHNpbmNlIHRoZXkgY2FuIGJlIGNhbGxlZCBmcm9tIGFueSBwYWdl
IGxhdW5kZXJpbmcsCmV2ZW4gaWYgR0ZQX05PRlMgb3IgR0ZQX05PSU8gYXJlIHNldC4KCkkgZ3Vl
c3Mgd2Ugc2hvdWxkIGltcHJvdmUgdGhlIGxvY2tkZXAgYW5ub3RhdGlvbnMgZm9yCmZzX3JlY2xh
aW1fYWNxdWlyZS9yZWxlYXNlLgoKT2ZjIHJlYWwgZml4IGlzIHRvIHByb3Blcmx5IHByZWFsbG9j
YXRlIHRoaXMgZmVuY2UgYW5kIHN0dWZmIGl0IGludG8KdGhlIGFtZGdwdSBqb2Igc3RydWN0dXJl
LiBCdXQgR0ZQX0FUT01JQyBnZXRzIHRoZSBsb2NrZGVwIHNwbGF0IG91dCBvZgp0aGUgd2F5LgoK
djI6IFR3byBtb3JlIGFsbG9jYXRpb25zIGluIHNjaGVkdWxlciBwYXRocy4KCkZyaXN0IG9uZToK
CglfX2ttYWxsb2MrMHg1OC8weDcyMAoJYW1kZ3B1X3ZtaWRfZ3JhYisweDEwMC8weGNhMCBbYW1k
Z3B1XQoJYW1kZ3B1X2pvYl9kZXBlbmRlbmN5KzB4ZjkvMHgxMjAgW2FtZGdwdV0KCWRybV9zY2hl
ZF9lbnRpdHlfcG9wX2pvYisweDNmLzB4NDQwIFtncHVfc2NoZWRdCglkcm1fc2NoZWRfbWFpbisw
eGY5LzB4NDkwIFtncHVfc2NoZWRdCgpTZWNvbmQgb25lOgoKCWttZW1fY2FjaGVfYWxsb2MrMHgy
Yi8weDZkMAoJYW1kZ3B1X3N5bmNfZmVuY2UrMHg3ZS8weDExMCBbYW1kZ3B1XQoJYW1kZ3B1X3Zt
aWRfZ3JhYisweDg2Yi8weGNhMCBbYW1kZ3B1XQoJYW1kZ3B1X2pvYl9kZXBlbmRlbmN5KzB4Zjkv
MHgxMjAgW2FtZGdwdV0KCWRybV9zY2hlZF9lbnRpdHlfcG9wX2pvYisweDNmLzB4NDQwIFtncHVf
c2NoZWRdCglkcm1fc2NoZWRfbWFpbisweGY5LzB4NDkwIFtncHVfc2NoZWRdCgpDYzogbGludXgt
bWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcK
Q2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogQ2hyaXMgV2ls
c29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+CkNjOiBNYWFydGVuIExhbmtob3JzdCA8bWFh
cnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWwudmV0dGVyQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZmVuY2UuYyB8IDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMu
YyAgIHwgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyAgfCAy
ICstCiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCmluZGV4IGQ4NzhmZTdmZWU1
MS4uMDU1YjQ3MjQxYmIxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZmVuY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVu
Y2UuYwpAQCAtMTQzLDcgKzE0Myw3IEBAIGludCBhbWRncHVfZmVuY2VfZW1pdChzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsIHN0cnVjdCBkbWFfZmVuY2UgKipmLAogCXVpbnQzMl90IHNlcTsKIAlp
bnQgcjsKIAotCWZlbmNlID0ga21lbV9jYWNoZV9hbGxvYyhhbWRncHVfZmVuY2Vfc2xhYiwgR0ZQ
X0tFUk5FTCk7CisJZmVuY2UgPSBrbWVtX2NhY2hlX2FsbG9jKGFtZGdwdV9mZW5jZV9zbGFiLCBH
RlBfQVRPTUlDKTsKIAlpZiAoZmVuY2UgPT0gTlVMTCkKIAkJcmV0dXJuIC1FTk9NRU07CiAKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwppbmRleCBmZTkyZGNkOTRkNGEuLmZk
Y2Q2NjU5ZjVhZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lkcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwpAQCAt
MjA4LDcgKzIwOCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtaWRfZ3JhYl9pZGxlKHN0cnVjdCBh
bWRncHVfdm0gKnZtLAogCWlmIChyaW5nLT52bWlkX3dhaXQgJiYgIWRtYV9mZW5jZV9pc19zaWdu
YWxlZChyaW5nLT52bWlkX3dhaXQpKQogCQlyZXR1cm4gYW1kZ3B1X3N5bmNfZmVuY2Uoc3luYywg
cmluZy0+dm1pZF93YWl0LCBmYWxzZSk7CiAKLQlmZW5jZXMgPSBrbWFsbG9jX2FycmF5KHNpemVv
Zih2b2lkICopLCBpZF9tZ3ItPm51bV9pZHMsIEdGUF9LRVJORUwpOworCWZlbmNlcyA9IGttYWxs
b2NfYXJyYXkoc2l6ZW9mKHZvaWQgKiksIGlkX21nci0+bnVtX2lkcywgR0ZQX0FUT01JQyk7CiAJ
aWYgKCFmZW5jZXMpCiAJCXJldHVybiAtRU5PTUVNOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3N5bmMuYwppbmRleCBiODdjYTE3MTk4NmEuLjMzMDQ3NmNjMGM4NiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCkBAIC0xNjgsNyArMTY4LDcgQEAg
aW50IGFtZGdwdV9zeW5jX2ZlbmNlKHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywgc3RydWN0IGRt
YV9mZW5jZSAqZiwKIAlpZiAoYW1kZ3B1X3N5bmNfYWRkX2xhdGVyKHN5bmMsIGYsIGV4cGxpY2l0
KSkKIAkJcmV0dXJuIDA7CiAKLQllID0ga21lbV9jYWNoZV9hbGxvYyhhbWRncHVfc3luY19zbGFi
LCBHRlBfS0VSTkVMKTsKKwllID0ga21lbV9jYWNoZV9hbGxvYyhhbWRncHVfc3luY19zbGFiLCBH
RlBfQVRPTUlDKTsKIAlpZiAoIWUpCiAJCXJldHVybiAtRU5PTUVNOwogCi0tIAoyLjI2LjIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
