Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD3AC43618
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F74611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F74611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D485E6F46B;
	Thu, 20 May 2021 12:49:17 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5D96F43C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:37 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id r12so17404900wrp.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=25hbKCKPnZleCOPr+RSYM8icUrz00DW2ZJX4QTilpw8=;
 b=T+NtzJmFUghwg7s32gDqjUu8IBC4kxHD18dAQVtRRVAmbg0mCylHk99kLxQQPe45t7
 mQwRZi00yTostuRy+A6rYt60NFhyn5sMWlWDlrC/SgC684FQxmPGwrOBcjAWxsHYiT6m
 X2QhXN5aCsKAbsT0nir4URuVJYeK46Emef0w3uyEPkFy/dsc834OSj5V6xX/Cm+eywih
 YYIEL5odB9rBQzvi3rR42Qy26ybZkPttc/evZ2pDRDawBBBcupFY7l6jEAEZ9KOfhWqW
 fdbNuvFM1uzpcK7ZyGlIyXPRPfemXKC0Ecpj53AbEx+IzL/YMlxvUoBwZUs1ajfWbbbO
 Hsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=25hbKCKPnZleCOPr+RSYM8icUrz00DW2ZJX4QTilpw8=;
 b=VUbTKakg37m+P6FSbBeGcMrB8yalZ2yzLyWuaMLNnj8S4xhg+8YcqoxkYiRgvww9g9
 UX1BkqcMRu20pWK0plxfHyhzpH3cp+ZIt7EiGB/UGhr5hjptAr1v9jCV37gse+i0ivPg
 b4iQkTC7ZMv7P3yf8Dz/lOBl4d/y1+HN/CiddojUgGOwiYulPBk3diccVDipUGpxhQAo
 h6qcZU8aXwhpGBq5p3px1gt/7IWBzO0N2bpSV1NZmvIlESwsEw94lwKo6+oKgivryTis
 fnNjzxAXRIeDvhb5XV+tWIeFm32JIf2zeHfGtZSWKE29wKctsd/zC5ZrNbdas5CEOj/W
 nhIw==
X-Gm-Message-State: AOAM530mvZVzjk7Wy7lyGDsHbr7/5UlEAYycb8Cy7vlfN96JCI0s5xl1
 zWaM4+2D+oE8AVVlN6TsWR39bQ==
X-Google-Smtp-Source: ABdhPJyL3A14u1dIYxWZuBNDzCNakC9GYeqVMGa1CSSlfC6rvVzVOSJi3RJqmvSko5JP/WBPAWzp9g==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr4040620wrt.189.1621512216601; 
 Thu, 20 May 2021 05:03:36 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:36 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 34/38] drm/amd/amdgpu/amdgpu_vce: Fix a few incorrectly named
 functions
Date: Thu, 20 May 2021 13:02:44 +0100
Message-Id: <20210520120248.3464013-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jOjk4OiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBhbWRncHVfdmNlX2luaXQoKS4gUHJvdG90eXBlIHdhcyBmb3IgYW1kZ3B1
X3ZjZV9zd19pbml0KCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZjZS5jOjIxNDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1kZ3B1X3ZjZV9m
aW5pKCkuIFByb3RvdHlwZSB3YXMgZm9yIGFtZGdwdV92Y2Vfc3dfZmluaSgpIGluc3RlYWQKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYzo1OTA6IHdhcm5pbmc6IGV4cGVj
dGluZyBwcm90b3R5cGUgZm9yIGFtZGdwdV92Y2VfY3NfdmFsaWRhdGVfYm8oKS4gUHJvdG90eXBl
IHdhcyBmb3IgYW1kZ3B1X3ZjZV92YWxpZGF0ZV9ibygpIGluc3RlYWQKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYzo3MjQ6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5
cGUgZm9yIGFtZGdwdV92Y2VfY3NfcGFyc2UoKS4gUHJvdG90eXBlIHdhcyBmb3IgYW1kZ3B1X3Zj
ZV9yaW5nX3BhcnNlX2NzKCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZjZS5jOjk2MDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1kZ3B1X3Zj
ZV9jc19wYXJzZV92bSgpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfdmNlX3JpbmdfcGFyc2Vf
Y3Nfdm0oKSBpbnN0ZWFkCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1t
LXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5j
IHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKaW5kZXggZWE2
YTYyZjY3ZTM4MC4uN2FkODNkYTYxM2VkZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y2UuYwpAQCAtODcsNyArODcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92Y2VfZ2V0X2Rl
c3Ryb3lfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgaGFuZGxlLAogCQkJ
CSAgICAgIGJvb2wgZGlyZWN0LCBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UpOwogCiAvKioKLSAq
IGFtZGdwdV92Y2VfaW5pdCAtIGFsbG9jYXRlIG1lbW9yeSwgbG9hZCB2Y2UgZmlybXdhcmUKKyAq
IGFtZGdwdV92Y2Vfc3dfaW5pdCAtIGFsbG9jYXRlIG1lbW9yeSwgbG9hZCB2Y2UgZmlybXdhcmUK
ICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKiBAc2l6ZTogc2l6ZSBmb3Ig
dGhlIG5ldyBCTwpAQCAtMjA0LDcgKzIwNCw3IEBAIGludCBhbWRncHVfdmNlX3N3X2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKIH0KIAogLyoqCi0g
KiBhbWRncHVfdmNlX2ZpbmkgLSBmcmVlIG1lbW9yeQorICogYW1kZ3B1X3ZjZV9zd19maW5pIC0g
ZnJlZSBtZW1vcnkKICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAgKgpAQCAt
NTc0LDcgKzU3NCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZjZV9nZXRfZGVzdHJveV9tc2coc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1aW50MzJfdCBoYW5kbGUsCiB9CiAKIC8qKgotICogYW1k
Z3B1X3ZjZV9jc192YWxpZGF0ZV9ibyAtIG1ha2Ugc3VyZSBub3QgdG8gY3Jvc3MgNEdCIGJvdW5k
YXJ5CisgKiBhbWRncHVfdmNlX3ZhbGlkYXRlX2JvIC0gbWFrZSBzdXJlIG5vdCB0byBjcm9zcyA0
R0IgYm91bmRhcnkKICAqCiAgKiBAcDogcGFyc2VyIGNvbnRleHQKICAqIEBpYl9pZHg6IGluZGly
ZWN0IGJ1ZmZlciB0byB1c2UKQEAgLTcxNSw3ICs3MTUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92
Y2VfdmFsaWRhdGVfaGFuZGxlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogfQogCiAvKioK
LSAqIGFtZGdwdV92Y2VfY3NfcGFyc2UgLSBwYXJzZSBhbmQgdmFsaWRhdGUgdGhlIGNvbW1hbmQg
c3RyZWFtCisgKiBhbWRncHVfdmNlX3JpbmdfcGFyc2VfY3MgLSBwYXJzZSBhbmQgdmFsaWRhdGUg
dGhlIGNvbW1hbmQgc3RyZWFtCiAgKgogICogQHA6IHBhcnNlciBjb250ZXh0CiAgKiBAaWJfaWR4
OiBpbmRpcmVjdCBidWZmZXIgdG8gdXNlCkBAIC05NTEsNyArOTUxLDcgQEAgaW50IGFtZGdwdV92
Y2VfcmluZ19wYXJzZV9jcyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwgdWludDMyX3QgaWJf
aWR4KQogfQogCiAvKioKLSAqIGFtZGdwdV92Y2VfY3NfcGFyc2Vfdm0gLSBwYXJzZSB0aGUgY29t
bWFuZCBzdHJlYW0gaW4gVk0gbW9kZQorICogYW1kZ3B1X3ZjZV9yaW5nX3BhcnNlX2NzX3ZtIC0g
cGFyc2UgdGhlIGNvbW1hbmQgc3RyZWFtIGluIFZNIG1vZGUKICAqCiAgKiBAcDogcGFyc2VyIGNv
bnRleHQKICAqIEBpYl9pZHg6IGluZGlyZWN0IGJ1ZmZlciB0byB1c2UKLS0gCjIuMzEuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
