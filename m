Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893AC56201
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33292087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oia3Jh4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE08A6EB3A;
	Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070F96EB26
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:11 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 33so2779640wrl.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SjA8v4JLA0wt0cf7/uKVTogVLZnV31tTyBrzOli6fTM=;
 b=Oia3Jh4+Z4jZyw1RDFWjabOewBGewQgIFa2hSMdeANo/YNjwRKSyyHR/LmjPTFtqt1
 s1PWVzmYK/yiFcYzVOiScC7s9flKEXDvrwkM8+oFQquVQSrvMGl3gMbuKiDFQZsoSMb0
 rVNafzN6YaSO41UutCfcOGF7aLMiRl5tBPvTD3hz392MP3sMQmLcsT4BykIuFqirx8xj
 L0xAzBNZGRx/MvGtnG1EMg+6rETJR5G94Dl9+sR3bxebp6rscL2fgQ57Y0TR5TU2S0dL
 hBmeBZSxQW/agwFMc4PH6qo9+jx7lpTW+LKLienKAzuco0zomsAXcRe7G/4pzTNyydrt
 sa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SjA8v4JLA0wt0cf7/uKVTogVLZnV31tTyBrzOli6fTM=;
 b=uoXg+OgQNHD24Szpd0HMjunNY3LllxtkmBd0ZC5JP4b3QqOIAqANg40iF9yWRwHAXB
 E/IkGi4Yu5nnxQtGOxIDrHJFwmVc6FxGgRyYzjqXKBcLq2Dztu15hC/4Y6PCHBC9HER5
 PgMABh+dlOZOwpHXwClEvaCz9/dwFKejb1ESoXNiN+z4atM8MdFmih/mDJ+bEHmsX0TM
 iDTuxGvQH8M9yQhY22/TOjr3MeqtN/giQo0zwKafZnGa8UtBrBS/E/JWJSrpTwSHwt7r
 AXC3VuDE2lAYojBqOUpK5cDz6KaYOoaU/1HICZ5943xrZTUU8lXNCWj5+HhuDTS2CSLJ
 eW1g==
X-Gm-Message-State: AOAM533zxkKvz9kMyMVHxAuoqvMtROtfdpRhFtk1Q3NJOkJAy6nuthb0
 lLLOL4o5Z+HCQeXkuPzz5Sp8VZkjXFKJpD5D
X-Google-Smtp-Source: ABdhPJz+gy7qopMT/b5AA8BVa5aWxWSV04A6Br6J+M2a8ma5BFJoYvg7Jj40fv8t9h+032uRRuXJ8g==
X-Received: by 2002:adf:c14c:: with SMTP id w12mr5035604wre.40.1604699409717; 
 Fri, 06 Nov 2020 13:50:09 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:09 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/19] drm/radeon/radeon_drv: Move prototypes to a shared
 headerfile
Date: Fri,  6 Nov 2020 21:49:43 +0000
Message-Id: <20201106214949.2042120-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
 Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogNjIgfCB2
b2lkIHJhZGVvbl9kcml2ZXJfdW5sb2FkX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogfCBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2tt
cy5jOjEwNTo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9k
cml2ZXJfbG9hZF9rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogMTA1IHwgaW50IHJhZGVv
bl9kcml2ZXJfbG9hZF9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWduZWQgbG9uZyBm
bGFncykKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fa21zLmM6NjE5OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
cmFkZW9uX2RyaXZlcl9sYXN0Y2xvc2Vfa21z4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDYx
OSB8IHZvaWQgcmFkZW9uX2RyaXZlcl9sYXN0Y2xvc2Vfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fa21zLmM6NjM0OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
4oCYcmFkZW9uX2RyaXZlcl9vcGVuX2ttc+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiA2MzQg
fCBpbnQgcmFkZW9uX2RyaXZlcl9vcGVuX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1
Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdikKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6NzA1OjY6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RyaXZlcl9wb3N0Y2xvc2Vfa21z4oCZIFstV21pc3Np
bmctcHJvdG90eXBlc10KIDcwNSB8IHZvaWQgcmFkZW9uX2RyaXZlcl9wb3N0Y2xvc2Vfa21zKHN0
cnVjdCBkcm1fZGV2aWNlICpkZXYsCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogR2Fy
ZXRoIEh1Z2hlcyA8Z2FyZXRoQHZhbGludXguY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1i
eTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9kcnYuYyB8IDYgLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9kcnYuaCB8IDcgKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYwppbmRleCBiYjdi
MzNlNTM1ZjgxLi5lMGQ2NjRlOWUyZmViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYu
YwpAQCAtMTEyLDEyICsxMTIsNiBAQAogI2RlZmluZSBLTVNfRFJJVkVSX01BSk9SCTIKICNkZWZp
bmUgS01TX0RSSVZFUl9NSU5PUgk1MAogI2RlZmluZSBLTVNfRFJJVkVSX1BBVENITEVWRUwJMAot
aW50IHJhZGVvbl9kcml2ZXJfbG9hZF9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWdu
ZWQgbG9uZyBmbGFncyk7Ci12b2lkIHJhZGVvbl9kcml2ZXJfdW5sb2FkX2ttcyhzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2KTsKLXZvaWQgcmFkZW9uX2RyaXZlcl9sYXN0Y2xvc2Vfa21zKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYpOwotaW50IHJhZGVvbl9kcml2ZXJfb3Blbl9rbXMoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgc3RydWN0IGRybV9maWxlICpmaWxlX3ByaXYpOwotdm9pZCByYWRlb25fZHJp
dmVyX3Bvc3RjbG9zZV9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKLQkJCQkgc3RydWN0IGRy
bV9maWxlICpmaWxlX3ByaXYpOwogaW50IHJhZGVvbl9zdXNwZW5kX2ttcyhzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2LCBib29sIHN1c3BlbmQsCiAJCSAgICAgICBib29sIGZiY29uLCBib29sIGZyZWV6
ZSk7CiBpbnQgcmFkZW9uX3Jlc3VtZV9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgYm9vbCBy
ZXN1bWUsIGJvb2wgZmJjb24pOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuaAppbmRleCAx
NzNkZWI0NjM0MTQ2Li5hYzc5NzA5MTljNGQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9kcnYuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cnYuaApAQCAtMTE4LDQgKzExOCwxMSBAQAogbG9uZyByYWRlb25fZHJtX2lvY3RsKHN0cnVjdCBm
aWxlICpmaWxwLAogCQkgICAgICB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFyZyk7
CiAKK2ludCByYWRlb25fZHJpdmVyX2xvYWRfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVu
c2lnbmVkIGxvbmcgZmxhZ3MpOwordm9pZCByYWRlb25fZHJpdmVyX3VubG9hZF9rbXMoc3RydWN0
IGRybV9kZXZpY2UgKmRldik7Cit2b2lkIHJhZGVvbl9kcml2ZXJfbGFzdGNsb3NlX2ttcyhzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2KTsKK2ludCByYWRlb25fZHJpdmVyX29wZW5fa21zKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2KTsKK3ZvaWQgcmFkZW9u
X2RyaXZlcl9wb3N0Y2xvc2Vfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCisJCQkJIHN0cnVj
dCBkcm1fZmlsZSAqZmlsZV9wcml2KTsKKwogI2VuZGlmCQkJCS8qIF9fUkFERU9OX0RSVl9IX18g
Ki8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
