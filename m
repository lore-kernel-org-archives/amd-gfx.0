Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BA2C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFE620936
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt523y9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFE620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383026E889;
	Tue, 22 Sep 2020 13:32:50 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D2C6E871;
 Tue, 22 Sep 2020 13:32:22 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id j2so16149469eds.9;
 Tue, 22 Sep 2020 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xRUJd0COa+i3Aa6yqn5QA7E5WTZJ2f/R2EV6GUAkocs=;
 b=qt523y9uiUhAKQWHgcQHF9MfD8A1myDqz9H1rI468qUhwe1RPF0T6OUKP6FD6RlneX
 bZgnfslu7R8AWY6EMpCjw8dDjOdRGLCcddGNADtjW7Lgbkrbdci6J+x00mIVpzypqdA/
 fE4U1dkwbJCl6No5DTYfl1Ntc/YpypP8te4u7vSVe3c2hRhZ5jLAwZW7aJuPDwaeCxU7
 Vfpzo54PcBfwAzAHCjO4b3ymfsH3331PiID/QHSDqbmyHJTQUcJwcPx3aUAlHE+LzXFY
 M3wh9CSA/IEUfuGyypPrryG8E7cgVZaVV4tMaPbVYkRClCthYcGpuEEvgxcHAtVwvaXr
 E6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xRUJd0COa+i3Aa6yqn5QA7E5WTZJ2f/R2EV6GUAkocs=;
 b=Ow6gHk4aAhOP+ldD5FCC1FAeh1m5tpnTaySh3rRBwaMenk5xZevZzGdgsi7+3TZynT
 ps/tnEmZSAs2DkSLqMwXJ5BflWgI3ZQBhSbh4nhvxP3WQXMPYIhpBBRcTuwOnJ8Qw7Yt
 L8SArqXscuSmcEMAaDNYds3A1vEyHsfHVTEi1PMynyPFXIxqs/ZAzbRVUQlN5bZZsWfS
 nqoLZEh7d93LltRPY7FlytbDrsN0wknUwTXxwJBFLqB+tAx8dzSKBUr+Pi317Hbu9Oyx
 hASn4RddYM0L3B06vvhBzz3P6uRsScAtETTVeZsPyIP8CFsumg3gVoFQZGkYFNsHKa+i
 kjFQ==
X-Gm-Message-State: AOAM531gB6+8B0RTdvB9mfV6dmquMoG/lFjYTJP7EJaikmaZRIhI6aim
 9fayWMQNcTOeh1a8+qAdh/Y=
X-Google-Smtp-Source: ABdhPJzY7vYHhFnZIwgjTV8d5Lxp+nJO9WTbY033Bvb8zOpOCOlhz1UCtnmw/I8D+2xC0ieNo9ohRA==
X-Received: by 2002:aa7:cb44:: with SMTP id w4mr3944612edt.139.1600781540791; 
 Tue, 22 Sep 2020 06:32:20 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:11af:3d77:a1c7:4f3a])
 by smtp.gmail.com with ESMTPSA id z21sm11541028eja.72.2020.09.22.06.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 06:32:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-graphics-maintainer@vmware.com, sroland@vmware.com, airlied@linux.ie,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, ray.huang@amd.com
Subject: [PATCH 11/11] drm/ttm: remove TTM_PL_FLAG_NO_EVICT
Date: Tue, 22 Sep 2020 15:32:08 +0200
Message-Id: <20200922133208.1273-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922133208.1273-1-christian.koenig@amd.com>
References: <20200922133208.1273-1-christian.koenig@amd.com>
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

Tm90IHVzZWQgYW55IG1vcmUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyAg
ICB8IDExICsrKy0tLS0tLS0tCiBpbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oIHwgIDEg
LQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvLmMKaW5kZXggMWE0YjI1MDgzMzI2Li41NzM3YjNmYWUxYjMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYwpAQCAtMTE4LDkgKzExOCw2IEBAIHN0YXRpYyB2b2lkIHR0bV9ib19hZGRfbWVtX3Rv
X2xydShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCWlmICghbGlzdF9lbXB0eSgmYm8t
PmxydSkgfHwgYm8tPnBpbl9jb3VudCkKIAkJcmV0dXJuOwogCi0JaWYgKG1lbS0+cGxhY2VtZW50
ICYgVFRNX1BMX0ZMQUdfTk9fRVZJQ1QpCi0JCXJldHVybjsKLQogCW1hbiA9IHR0bV9tYW5hZ2Vy
X3R5cGUoYmRldiwgbWVtLT5tZW1fdHlwZSk7CiAJbGlzdF9hZGRfdGFpbCgmYm8tPmxydSwgJm1h
bi0+bHJ1W2JvLT5wcmlvcml0eV0pOwogCkBAIC0xNjUsOCArMTYyLDcgQEAgdm9pZCB0dG1fYm9f
bW92ZV90b19scnVfdGFpbChzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCXR0bV9ib19k
ZWxfZnJvbV9scnUoYm8pOwogCXR0bV9ib19hZGRfbWVtX3RvX2xydShibywgJmJvLT5tZW0pOwog
Ci0JaWYgKGJ1bGsgJiYgIShiby0+bWVtLnBsYWNlbWVudCAmIFRUTV9QTF9GTEFHX05PX0VWSUNU
KSAmJgotCSAgICAhYm8tPnBpbl9jb3VudCkgeworCWlmIChidWxrICYmICFiby0+cGluX2NvdW50
KSB7CiAJCXN3aXRjaCAoYm8tPm1lbS5tZW1fdHlwZSkgewogCQljYXNlIFRUTV9QTF9UVDoKIAkJ
CXR0bV9ib19idWxrX21vdmVfc2V0X3BvcygmYnVsay0+dHRbYm8tPnByaW9yaXR5XSwgYm8pOwpA
QCAtNTQxLDEyICs1MzcsMTEgQEAgc3RhdGljIHZvaWQgdHRtX2JvX3JlbGVhc2Uoc3RydWN0IGty
ZWYgKmtyZWYpCiAJCXNwaW5fbG9jaygmdHRtX2JvX2dsb2IubHJ1X2xvY2spOwogCiAJCS8qCi0J
CSAqIE1ha2UgTk9fRVZJQ1QgYm9zIGltbWVkaWF0ZWx5IGF2YWlsYWJsZSB0bworCQkgKiBNYWtl
IHBpbm5lZCBib3MgaW1tZWRpYXRlbHkgYXZhaWxhYmxlIHRvCiAJCSAqIHNocmlua2Vycywgbm93
IHRoYXQgdGhleSBhcmUgcXVldWVkIGZvcgogCQkgKiBkZXN0cnVjdGlvbi4KIAkJICovCi0JCWlm
IChiby0+bWVtLnBsYWNlbWVudCAmIFRUTV9QTF9GTEFHX05PX0VWSUNUIHx8IGJvLT5waW5fY291
bnQpIHsKLQkJCWJvLT5tZW0ucGxhY2VtZW50ICY9IH5UVE1fUExfRkxBR19OT19FVklDVDsKKwkJ
aWYgKGJvLT5waW5fY291bnQpIHsKIAkJCWJvLT5waW5fY291bnQgPSAwOwogCQkJdHRtX2JvX2Rl
bF9mcm9tX2xydShibyk7CiAJCQl0dG1fYm9fYWRkX21lbV90b19scnUoYm8sICZiby0+bWVtKTsK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1fcGxhY2VtZW50LmggYi9pbmNsdWRlL2Ry
bS90dG0vdHRtX3BsYWNlbWVudC5oCmluZGV4IGQ0MDIyNjU1ZWFlNC4uNTBlNzJkZjQ4YjhkIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oCisrKyBiL2luY2x1ZGUv
ZHJtL3R0bS90dG1fcGxhY2VtZW50LmgKQEAgLTU4LDcgKzU4LDYgQEAKICNkZWZpbmUgVFRNX1BM
X0ZMQUdfVU5DQUNIRUQgICAgKDEgPDwgMTcpCiAjZGVmaW5lIFRUTV9QTF9GTEFHX1dDICAgICAg
ICAgICgxIDw8IDE4KQogI2RlZmluZSBUVE1fUExfRkxBR19DT05USUdVT1VTICAoMSA8PCAxOSkK
LSNkZWZpbmUgVFRNX1BMX0ZMQUdfTk9fRVZJQ1QgICAgKDEgPDwgMjEpCiAjZGVmaW5lIFRUTV9Q
TF9GTEFHX1RPUERPV04gICAgICgxIDw8IDIyKQogCiAjZGVmaW5lIFRUTV9QTF9NQVNLX0NBQ0hJ
TkcgICAgIChUVE1fUExfRkxBR19DQUNIRUQgfCBcCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
