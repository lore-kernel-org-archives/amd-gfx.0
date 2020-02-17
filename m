Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B5C34021
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C5A20801
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1BKvnTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0A96E97E;
	Mon, 17 Feb 2020 15:02:14 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690326E97E;
 Mon, 17 Feb 2020 15:02:13 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w12so20124815wrt.2;
 Mon, 17 Feb 2020 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cyco2q7SRiKrM2o/wxUNgK4fgTFrOkL7S+k0K1ueUkc=;
 b=L1BKvnTvBO0PTlN0z6+hx6xgerdeSm1UB/f/b58Vv6SEc8wxhve7BUSC7JcLc0XqwT
 R6f2qEjG1wYvEfH4OkRPG0pVDbcqf6rX4hirbGlzLo3OKOIp1X0hnpAnxTEp2VGBgK6m
 aIy0QCH7qI5WKcn/+BQ9SWF2RzUqxPt6+mIZmyf1/C+JVRYAsweofqr1mK7QO/0GXoEK
 Hg+yKObILGElgq5/V0YM3JmMH/NabsW47AgqRrjG5EhaAE7QOMHMeQQaGWpdwsWYCWv1
 bPukGrAbOU2hq0pCfEKSJAPM9r7GnsPVF5BNqMKRxUsvawF5+kWwhBdtI4aaVBJ3cooM
 rN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cyco2q7SRiKrM2o/wxUNgK4fgTFrOkL7S+k0K1ueUkc=;
 b=RvXTJdeVWv4mki1XA5WSc1dj/+/YCyof++7YhrR/jLFTYSGc6cOs0/FwliH0mfj/9w
 515X2ls8drhzc4K4oBODdgGEc7W7F3Hr6CKGOin9S6rn6KPxV2tvdWQ1IJ7wEldqfnw0
 GSStO0x35b+wGTte5KywX2+2rIF8PZMaDAaw7dzeDxFFkw2cSXV2tfez5DHkosB9xzvX
 vawHiso7iTMvk7zxs2zzhmW3yvq3f3zEzY373vkNRhQCuNlSFj08wyh/Q3KBJ6TadTEg
 /MGQK+3RUvnRd6k9ufcr4x7wAxnNSoOs55cvzzbpGkOeIgPp3UI0bNTGByRLQoucZQE9
 In2w==
X-Gm-Message-State: APjAAAVNhqbH7HgfZNQhBHmMjvpZd8fySUv45syiR9SxCbfCZr7eshGN
 zkhXgOcKa/G1hf/DZTySDdjU9kOtVzGQ2A==
X-Google-Smtp-Source: APXvYqxMk31toxG94T0PKH45PxBdgGqsIZWjE1Xszq2WNu2gRhwLDV6Y50PrAqx3qBpIB2SJcn5rRw==
X-Received: by 2002:adf:df83:: with SMTP id z3mr22495409wrl.389.1581951731588; 
 Mon, 17 Feb 2020 07:02:11 -0800 (PST)
Received: from brihaspati.fritz.box (pD9566D64.dip0.t-ipconnect.de.
 [217.86.109.100])
 by smtp.gmail.com with ESMTPSA id j15sm1441099wrp.9.2020.02.17.07.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 07:02:11 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 5/8] drm/qxl: don't use ttm bo->offset
Date: Mon, 17 Feb 2020 16:04:24 +0100
Message-Id: <20200217150427.49994-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217150427.49994-1-nirmoy.das@amd.com>
References: <20200217150427.49994-1-nirmoy.das@amd.com>
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBhbHNvIHJlbW92ZXMgc2xvdC0+Z3B1X29mZnNldCB3aGljaCBpcyBub3QgcmVx
dWlyZWQgYXMKVlJBTSBhbmQgUFJJViBzbG90IGFyZSBpbiBzZXBhcmF0ZSBQQ0kgYmFyCgpTaWdu
ZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBHZXJkIEhv
ZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9k
cnYuaCAgICB8IDYgKystLS0tCiBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYyAgICB8IDUg
KystLS0KIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX29iamVjdC5oIHwgNSAtLS0tLQogZHJpdmVy
cy9ncHUvZHJtL3F4bC9xeGxfdHRtLmMgICAgfCA5IC0tLS0tLS0tLQogNCBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9xeGwvcXhsX2Rydi5oIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZHJ2LmgKaW5k
ZXggMjdlNDVhMmQ2YjUyLi5kZjU4MWYwZTY2OTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9xeGwvcXhsX2Rydi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2Rydi5oCkBAIC0x
MzQsNyArMTM0LDYgQEAgc3RydWN0IHF4bF9tZW1zbG90IHsKIAl1aW50NjRfdAlzdGFydF9waHlz
X2FkZHI7CiAJdWludDY0X3QJc2l6ZTsKIAl1aW50NjRfdAloaWdoX2JpdHM7Ci0JdWludDY0X3Qg
ICAgICAgIGdwdV9vZmZzZXQ7CiB9OwogCiBlbnVtIHsKQEAgLTMxMSwxMCArMzEwLDkgQEAgcXhs
X2JvX3BoeXNpY2FsX2FkZHJlc3Moc3RydWN0IHF4bF9kZXZpY2UgKnFkZXYsIHN0cnVjdCBxeGxf
Ym8gKmJvLAogCQkoYm8tPnRiby5tZW0ubWVtX3R5cGUgPT0gVFRNX1BMX1ZSQU0pCiAJCT8gJnFk
ZXYtPm1haW5fc2xvdCA6ICZxZGV2LT5zdXJmYWNlc19zbG90OwogCi0JV0FSTl9PTl9PTkNFKChi
by0+dGJvLm9mZnNldCAmIHNsb3QtPmdwdV9vZmZzZXQpICE9IHNsb3QtPmdwdV9vZmZzZXQpOwor
ICAgICAgIC8qIFRPRE8gLSBuZWVkIHRvIGhvbGQgb25lIG9mIHRoZSBsb2NrcyB0byByZWFkIGJv
LT50Ym8ubWVtLnN0YXJ0ICovCiAKLQkvKiBUT0RPIC0gbmVlZCB0byBob2xkIG9uZSBvZiB0aGUg
bG9ja3MgdG8gcmVhZCB0Ym8ub2Zmc2V0ICovCi0JcmV0dXJuIHNsb3QtPmhpZ2hfYml0cyB8IChi
by0+dGJvLm9mZnNldCAtIHNsb3QtPmdwdV9vZmZzZXQgKyBvZmZzZXQpOworCXJldHVybiBzbG90
LT5oaWdoX2JpdHMgfCAoKGJvLT50Ym8ubWVtLnN0YXJ0IDw8IFBBR0VfU0hJRlQpICsgb2Zmc2V0
KTsKIH0KIAogLyogcXhsX2Rpc3BsYXkuYyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3F4bC9xeGxfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYwppbmRleCA3MGIy
MGVlNDc0MWEuLjdhNWJmNTQ0ZjM0ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3F4bC9x
eGxfa21zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfa21zLmMKQEAgLTg2LDExICs4
NiwxMCBAQCBzdGF0aWMgdm9pZCBzZXR1cF9zbG90KHN0cnVjdCBxeGxfZGV2aWNlICpxZGV2LAog
CWhpZ2hfYml0cyA8PD0gKDY0IC0gKHFkZXYtPnJvbS0+c2xvdF9nZW5fYml0cyArIHFkZXYtPnJv
bS0+c2xvdF9pZF9iaXRzKSk7CiAJc2xvdC0+aGlnaF9iaXRzID0gaGlnaF9iaXRzOwogCi0JRFJN
X0lORk8oInNsb3QgJWQgKCVzKTogYmFzZSAweCUwOGx4LCBzaXplIDB4JTA4bHgsIGdwdV9vZmZz
ZXQgMHglbHhcbiIsCisJRFJNX0lORk8oInNsb3QgJWQgKCVzKTogYmFzZSAweCUwOGx4LCBzaXpl
IDB4JTA4bHhcbiIsCiAJCSBzbG90LT5pbmRleCwgc2xvdC0+bmFtZSwKIAkJICh1bnNpZ25lZCBs
b25nKXNsb3QtPnN0YXJ0X3BoeXNfYWRkciwKLQkJICh1bnNpZ25lZCBsb25nKXNsb3QtPnNpemUs
Ci0JCSAodW5zaWduZWQgbG9uZylzbG90LT5ncHVfb2Zmc2V0KTsKKwkJICh1bnNpZ25lZCBsb25n
KXNsb3QtPnNpemUpOwogfQogCiB2b2lkIHF4bF9yZWluaXRfbWVtc2xvdHMoc3RydWN0IHF4bF9k
ZXZpY2UgKnFkZXYpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9vYmplY3Qu
aCBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX29iamVjdC5oCmluZGV4IDhhZTU0YmE3ODU3Yy4u
MjFmYTgxMDQ4ZjRmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9vYmplY3Qu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9vYmplY3QuaApAQCAtNDgsMTEgKzQ4LDYg
QEAgc3RhdGljIGlubGluZSB2b2lkIHF4bF9ib191bnJlc2VydmUoc3RydWN0IHF4bF9ibyAqYm8p
CiAJdHRtX2JvX3VucmVzZXJ2ZSgmYm8tPnRibyk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgdTY0IHF4
bF9ib19ncHVfb2Zmc2V0KHN0cnVjdCBxeGxfYm8gKmJvKQotewotCXJldHVybiBiby0+dGJvLm9m
ZnNldDsKLX0KLQogc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHF4bF9ib19zaXplKHN0cnVj
dCBxeGxfYm8gKmJvKQogewogCXJldHVybiBiby0+dGJvLm51bV9wYWdlcyA8PCBQQUdFX1NISUZU
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfdHRtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcXhsL3F4bF90dG0uYwppbmRleCA2MmE1ZTQyNDk3MWIuLjYzNWQwMDBlNzkzNCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3F4bC9xeGxfdHRtLmMKQEAgLTUxLDExICs1MSw2IEBAIHN0YXRpYyBzdHJ1Y3QgcXhsX2Rl
dmljZSAqcXhsX2dldF9xZGV2KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2KQogc3RhdGljIGlu
dCBxeGxfaW5pdF9tZW1fdHlwZShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwgdWludDMyX3Qg
dHlwZSwKIAkJCSAgICAgc3RydWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4pCiB7Ci0Jc3Ry
dWN0IHF4bF9kZXZpY2UgKnFkZXYgPSBxeGxfZ2V0X3FkZXYoYmRldik7Ci0JdW5zaWduZWQgaW50
IGdwdV9vZmZzZXRfc2hpZnQgPQotCQk2NCAtIChxZGV2LT5yb20tPnNsb3RfZ2VuX2JpdHMgKyBx
ZGV2LT5yb20tPnNsb3RfaWRfYml0cyArIDgpOwotCXN0cnVjdCBxeGxfbWVtc2xvdCAqc2xvdDsK
LQogCXN3aXRjaCAodHlwZSkgewogCWNhc2UgVFRNX1BMX1NZU1RFTToKIAkJLyogU3lzdGVtIG1l
bW9yeSAqLwpAQCAtNjYsMTEgKzYxLDcgQEAgc3RhdGljIGludCBxeGxfaW5pdF9tZW1fdHlwZShz
dHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRldiwgdWludDMyX3QgdHlwZSwKIAljYXNlIFRUTV9QTF9W
UkFNOgogCWNhc2UgVFRNX1BMX1BSSVY6CiAJCS8qICJPbi1jYXJkIiB2aWRlbyByYW0gKi8KLQkJ
c2xvdCA9ICh0eXBlID09IFRUTV9QTF9WUkFNKSA/Ci0JCQkmcWRldi0+bWFpbl9zbG90IDogJnFk
ZXYtPnN1cmZhY2VzX3Nsb3Q7Ci0JCXNsb3QtPmdwdV9vZmZzZXQgPSAodWludDY0X3QpdHlwZSA8
PCBncHVfb2Zmc2V0X3NoaWZ0OwogCQltYW4tPmZ1bmMgPSAmdHRtX2JvX21hbmFnZXJfZnVuYzsK
LQkJbWFuLT5ncHVfb2Zmc2V0ID0gc2xvdC0+Z3B1X29mZnNldDsKIAkJbWFuLT5mbGFncyA9IFRU
TV9NRU1UWVBFX0ZMQUdfRklYRUQgfAogCQkJICAgICBUVE1fTUVNVFlQRV9GTEFHX01BUFBBQkxF
OwogCQltYW4tPmF2YWlsYWJsZV9jYWNoaW5nID0gVFRNX1BMX01BU0tfQ0FDSElORzsKLS0gCjIu
MjUuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
