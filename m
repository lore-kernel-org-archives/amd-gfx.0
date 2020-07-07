Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63418C433F7
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 20:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A17520720
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 20:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="I+82JJmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A17520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6AA6E819;
	Tue,  7 Jul 2020 20:13:06 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8575B6E7E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 20:13:05 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id o2so468876wmh.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v6mLNvmwV0mXXFCJp1CZ5e+LEhcYSNx/dxx3MEMckRw=;
 b=I+82JJmua6H54T91fmYUr8DAr6NrwnR+mkHvBYi78d5aDPpW3+51mLiZmLWpatmsVZ
 7UZkmP80kTFgcoEpPk4rtMeZpVJWOIuNxSW1ZScEeiy2ttA5BTAFxF1utpsJipJarIxb
 cjMyFkg21+NB7V8zjtGNczY53Qq7GLqyckRu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v6mLNvmwV0mXXFCJp1CZ5e+LEhcYSNx/dxx3MEMckRw=;
 b=giLllLV2XScb+26Yzl+APPnm95lCFIukm75CZLtlMSH+C8OkZ/apb3xu8zfON/pq1j
 q9sYz1OrhyvcOBbAlE/kOCvGKX2WBLhdhyYAuaOchIc876fO05iVm3it88z11A1lPe+r
 py83GBhk63Av+vnNGKaL4PskKxYgh+MZFDQ0bHQwhs2kNcqQbSZjDDrRjRnITSDPR4NK
 xncQOjuXv24kz7dU4O63u5wbFOUmmxwwxLjMnRPjV4ax/qzAdeCWFNUviigWiAf1WhgF
 MMd45iZwlTK7agSHZ4gYRKSsuwqe2M78Hy/yX5fq+FrNOGXiEkdEflXtnabolRrTFy/n
 OiYQ==
X-Gm-Message-State: AOAM5314QOO32/MX5d5VK9kSp2UJlK4hXWmWiI+0zpM7ED4yZ2y/oYIz
 BG5+ddiNhzv60SqoFg55r9EB9g==
X-Google-Smtp-Source: ABdhPJwb8lrdzNzimlB7WFs1FDrPYBlKDSPiN4WBOCVQt3QuE500w5Nk7OIYzGADJypoV3zm1LNAIA==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr5900441wme.139.1594152784201;
 Tue, 07 Jul 2020 13:13:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 13:13:03 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 19/25] drm/amdgpu: s/GFP_KERNEL/GFP_ATOMIC in scheduler code
Date: Tue,  7 Jul 2020 22:12:23 +0200
Message-Id: <20200707201229.472834-20-daniel.vetter@ffwll.ch>
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
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCmluZGV4IDhkODQ5NzU4ODVj
ZC4uYTA4OWE4MjdmZGZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZmVuY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVu
Y2UuYwpAQCAtMTQzLDcgKzE0Myw3IEBAIGludCBhbWRncHVfZmVuY2VfZW1pdChzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsIHN0cnVjdCBkbWFfZmVuY2UgKipmLAogCXVpbnQzMl90IHNlcTsKIAlp
bnQgcjsKIAotCWZlbmNlID0ga21lbV9jYWNoZV9hbGxvYyhhbWRncHVfZmVuY2Vfc2xhYiwgR0ZQ
X0tFUk5FTCk7CisJZmVuY2UgPSBrbWVtX2NhY2hlX2FsbG9jKGFtZGdwdV9mZW5jZV9zbGFiLCBH
RlBfQVRPTUlDKTsKIAlpZiAoZmVuY2UgPT0gTlVMTCkKIAkJcmV0dXJuIC1FTk9NRU07CiAKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwppbmRleCAyNjdmYTQ1ZGRiNjYuLmEz
MzNjYTJkNGRkZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lkcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYwpAQCAt
MjA4LDcgKzIwOCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtaWRfZ3JhYl9pZGxlKHN0cnVjdCBh
bWRncHVfdm0gKnZtLAogCWlmIChyaW5nLT52bWlkX3dhaXQgJiYgIWRtYV9mZW5jZV9pc19zaWdu
YWxlZChyaW5nLT52bWlkX3dhaXQpKQogCQlyZXR1cm4gYW1kZ3B1X3N5bmNfZmVuY2Uoc3luYywg
cmluZy0+dm1pZF93YWl0KTsKIAotCWZlbmNlcyA9IGttYWxsb2NfYXJyYXkoc2l6ZW9mKHZvaWQg
KiksIGlkX21nci0+bnVtX2lkcywgR0ZQX0tFUk5FTCk7CisJZmVuY2VzID0ga21hbGxvY19hcnJh
eShzaXplb2Yodm9pZCAqKSwgaWRfbWdyLT5udW1faWRzLCBHRlBfQVRPTUlDKTsKIAlpZiAoIWZl
bmNlcykKIAkJcmV0dXJuIC1FTk9NRU07CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfc3luYy5jCmluZGV4IDhlYTZjNDk1MjllNy4uYWYyMmI1MjZjZWM5IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKQEAgLTE2MCw3ICsxNjAsNyBAQCBpbnQgYW1k
Z3B1X3N5bmNfZmVuY2Uoc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLCBzdHJ1Y3QgZG1hX2ZlbmNl
ICpmKQogCWlmIChhbWRncHVfc3luY19hZGRfbGF0ZXIoc3luYywgZikpCiAJCXJldHVybiAwOwog
Ci0JZSA9IGttZW1fY2FjaGVfYWxsb2MoYW1kZ3B1X3N5bmNfc2xhYiwgR0ZQX0tFUk5FTCk7CisJ
ZSA9IGttZW1fY2FjaGVfYWxsb2MoYW1kZ3B1X3N5bmNfc2xhYiwgR0ZQX0FUT01JQyk7CiAJaWYg
KCFlKQogCQlyZXR1cm4gLUVOT01FTTsKIAotLSAKMi4yNy4wCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
