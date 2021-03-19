Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83546C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7AA64F4D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7AA64F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DEE6EA1B;
	Fri, 19 Mar 2021 14:23:25 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49D56E9A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 08:24:41 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id l4so8268246ejc.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aMrUqo0YqYh2lLrOaeq1NIAU7nPi5AK4ygCC5+IgXJs=;
 b=xMzgbPZVOLQWV/WNZ8/zEFm7gXF06+16gnuNa/aVAK/QKIuo7EHaH+rwqwNGLQjtif
 jLAgrbn2DMVYgyKAh4q8fTdNeE5eSDIaWn8r5CtBX12ewcz2WSn+XnR08LDXXGAmBnXL
 8HFIyQCuQlni67VIHl/TZ5hLVGq8KJKlGpFg8e+J40gcX9yqYxdq0sFefFdYBYqlq1p7
 u40JNKLG2Z4Ca3mThnxGSZs+dR7H1Xw+Z825hmVNUjE4gHbvDv95ue3pc2RgzbvR4dLw
 luQ8c4ljbt4ONQQCVTSFcI+2k4OdBa6RY+a9GuFjhhIccV1z4OngdsUVSx/Ymxkp1YXZ
 brrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aMrUqo0YqYh2lLrOaeq1NIAU7nPi5AK4ygCC5+IgXJs=;
 b=sVWdAHAhcTpGaYJ1bA7sw30xAC+iDkqHteGmot3SZrppGSoV9nMWDNUCSD21P2maTA
 s88UuNhxauduPrbzm5ynp+CgRBD/4s5IvTzL/5lI0YxQCY+04Rt024bWArCNTwRx1+Ck
 UQJF4CbYP0fpvawlaaw4Nh7zRHx06dKqjExUkVrUVLz4ojgLDGSBlDXv8bSEPbcYOTac
 sFANPmL+b9JAPcGKxmvUILw2XvTkCIEbFZr5rQagCDgq2IxYXscUpfROO2KZKFZulMtZ
 FaQuyQicqIL07g5WRhERBy40+zKAbW2ZjoI3lomwc+tsFYwHPE0HLrE6rcPGhu9EqXRC
 uX5w==
X-Gm-Message-State: AOAM5329zCEhXWvzmpPw3ZGc12JRRdWcuT3ymEl6zN/fm3wI0+N71Cw+
 YaPGzW9v/wK2hq0AvWtdwLNMxw==
X-Google-Smtp-Source: ABdhPJzCaJaYhWu/7aVLIj1OQefDJ0Zu0iphS7NUCv/3Jcao8PWD08wakjGaaz0dRN3665HiRtM6Bg==
X-Received: by 2002:a17:906:86c1:: with SMTP id
 j1mr3063849ejy.373.1616142280425; 
 Fri, 19 Mar 2021 01:24:40 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
 by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 01:24:40 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/19] drm/amd/display/dc/dce80/dce80_resource: Make local
 functions static
Date: Fri, 19 Mar 2021 08:24:17 +0000
Message-Id: <20210319082428.3294591-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 19 Mar 2021 14:23:23 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5j
OjUyNzoxNzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U4MF9hdXhf
ZW5naW5lX2NyZWF0ZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX3Jlc291cmNlLmM6NTY1OjIwOiB3
YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTgwX2kyY19od19jcmVhdGXi
gJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jOjU4MToyMDogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U4MF9pMmNfc3dfY3JlYXRl4oCZIFstV21pc3Npbmct
cHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNl
ODAvZGNlODBfcmVzb3VyY2UuYzo3MTU6MjI6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlw
ZSBmb3Ig4oCYZGNlODBfbGlua19lbmNvZGVyX2NyZWF0ZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlw
ZXNdCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTgwL2RjZTgw
X3Jlc291cmNlLmM6NzU0OjIyOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKA
mGRjZTgwX2Nsb2NrX3NvdXJjZV9jcmVhdGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJj
ZS5jOjc3ODo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTgwX2Ns
b2NrX3NvdXJjZV9kZXN0cm954oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlODAvZGNlODBfcmVzb3VyY2UuYzo4Njg6
Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U4MF92YWxpZGF0ZV9i
YW5kd2lkdGjigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jOjkxMzoxNjogd2Fybmlu
Zzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2U4MF92YWxpZGF0ZV9nbG9iYWzigJkg
Wy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFu
ZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEFudGhvbnkgS29vIDxB
bnRob255Lktvb0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVz
IDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgw
L2RjZTgwX3Jlc291cmNlLmMgICAgfCAxNiArKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX3Jlc291cmNlLmMKaW5kZXggNjEyNDUw
Zjk5Mjc4Mi4uNzI1ZDkyZTQwY2QzMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZTgwL2RjZTgwX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX3Jlc291cmNlLmMKQEAgLTUyNiw3ICs1MjYsNyBAQCBz
dGF0aWMgc3RydWN0IG91dHB1dF9waXhlbF9wcm9jZXNzb3IgKmRjZTgwX29wcF9jcmVhdGUoCiAJ
cmV0dXJuICZvcHAtPmJhc2U7CiB9CiAKLXN0cnVjdCBkY2VfYXV4ICpkY2U4MF9hdXhfZW5naW5l
X2NyZWF0ZSgKK3N0YXRpYyBzdHJ1Y3QgZGNlX2F1eCAqZGNlODBfYXV4X2VuZ2luZV9jcmVhdGUo
CiAJc3RydWN0IGRjX2NvbnRleHQgKmN0eCwKIAl1aW50MzJfdCBpbnN0KQogewpAQCAtNTY0LDcg
KzU2NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGNlX2kyY19tYXNrIGkyY19tYXNrcyA9IHsK
IAkJSTJDX0NPTU1PTl9NQVNLX1NIX0xJU1RfRENFX0NPTU1PTl9CQVNFKF9NQVNLKQogfTsKIAot
c3RydWN0IGRjZV9pMmNfaHcgKmRjZTgwX2kyY19od19jcmVhdGUoCitzdGF0aWMgc3RydWN0IGRj
ZV9pMmNfaHcgKmRjZTgwX2kyY19od19jcmVhdGUoCiAJc3RydWN0IGRjX2NvbnRleHQgKmN0eCwK
IAl1aW50MzJfdCBpbnN0KQogewpAQCAtNTgwLDcgKzU4MCw3IEBAIHN0cnVjdCBkY2VfaTJjX2h3
ICpkY2U4MF9pMmNfaHdfY3JlYXRlKAogCXJldHVybiBkY2VfaTJjX2h3OwogfQogCi1zdHJ1Y3Qg
ZGNlX2kyY19zdyAqZGNlODBfaTJjX3N3X2NyZWF0ZSgKK3N0YXRpYyBzdHJ1Y3QgZGNlX2kyY19z
dyAqZGNlODBfaTJjX3N3X2NyZWF0ZSgKIAlzdHJ1Y3QgZGNfY29udGV4dCAqY3R4KQogewogCXN0
cnVjdCBkY2VfaTJjX3N3ICpkY2VfaTJjX3N3ID0KQEAgLTcxNCw3ICs3MTQsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGVuY29kZXJfZmVhdHVyZV9zdXBwb3J0IGxpbmtfZW5jX2ZlYXR1cmUgPSB7
CiAJCS5mbGFncy5iaXRzLklTX1RQUzNfQ0FQQUJMRSA9IHRydWUKIH07CiAKLXN0cnVjdCBsaW5r
X2VuY29kZXIgKmRjZTgwX2xpbmtfZW5jb2Rlcl9jcmVhdGUoCitzdGF0aWMgc3RydWN0IGxpbmtf
ZW5jb2RlciAqZGNlODBfbGlua19lbmNvZGVyX2NyZWF0ZSgKIAljb25zdCBzdHJ1Y3QgZW5jb2Rl
cl9pbml0X2RhdGEgKmVuY19pbml0X2RhdGEpCiB7CiAJc3RydWN0IGRjZTExMF9saW5rX2VuY29k
ZXIgKmVuYzExMCA9CkBAIC03NTMsNyArNzUzLDcgQEAgc3RhdGljIHN0cnVjdCBwYW5lbF9jbnRs
ICpkY2U4MF9wYW5lbF9jbnRsX2NyZWF0ZShjb25zdCBzdHJ1Y3QgcGFuZWxfY250bF9pbml0X2QK
IAlyZXR1cm4gJnBhbmVsX2NudGwtPmJhc2U7CiB9CiAKLXN0cnVjdCBjbG9ja19zb3VyY2UgKmRj
ZTgwX2Nsb2NrX3NvdXJjZV9jcmVhdGUoCitzdGF0aWMgc3RydWN0IGNsb2NrX3NvdXJjZSAqZGNl
ODBfY2xvY2tfc291cmNlX2NyZWF0ZSgKIAlzdHJ1Y3QgZGNfY29udGV4dCAqY3R4LAogCXN0cnVj
dCBkY19iaW9zICpiaW9zLAogCWVudW0gY2xvY2tfc291cmNlX2lkIGlkLApAQCAtNzc3LDcgKzc3
Nyw3IEBAIHN0cnVjdCBjbG9ja19zb3VyY2UgKmRjZTgwX2Nsb2NrX3NvdXJjZV9jcmVhdGUoCiAJ
cmV0dXJuIE5VTEw7CiB9CiAKLXZvaWQgZGNlODBfY2xvY2tfc291cmNlX2Rlc3Ryb3koc3RydWN0
IGNsb2NrX3NvdXJjZSAqKmNsa19zcmMpCitzdGF0aWMgdm9pZCBkY2U4MF9jbG9ja19zb3VyY2Vf
ZGVzdHJveShzdHJ1Y3QgY2xvY2tfc291cmNlICoqY2xrX3NyYykKIHsKIAlrZnJlZShUT19EQ0Ux
MTBfQ0xLX1NSQygqY2xrX3NyYykpOwogCSpjbGtfc3JjID0gTlVMTDsKQEAgLTg2Nyw3ICs4Njcs
NyBAQCBzdGF0aWMgdm9pZCBkY2U4MF9yZXNvdXJjZV9kZXN0cnVjdChzdHJ1Y3QgZGNlMTEwX3Jl
c291cmNlX3Bvb2wgKnBvb2wpCiAJfQogfQogCi1ib29sIGRjZTgwX3ZhbGlkYXRlX2JhbmR3aWR0
aCgKK3N0YXRpYyBib29sIGRjZTgwX3ZhbGlkYXRlX2JhbmR3aWR0aCgKIAlzdHJ1Y3QgZGMgKmRj
LAogCXN0cnVjdCBkY19zdGF0ZSAqY29udGV4dCwKIAlib29sIGZhc3RfdmFsaWRhdGUpCkBAIC05
MTIsNyArOTEyLDcgQEAgc3RhdGljIGJvb2wgZGNlODBfdmFsaWRhdGVfc3VyZmFjZV9zZXRzKAog
CXJldHVybiB0cnVlOwogfQogCi1lbnVtIGRjX3N0YXR1cyBkY2U4MF92YWxpZGF0ZV9nbG9iYWwo
CitzdGF0aWMgZW51bSBkY19zdGF0dXMgZGNlODBfdmFsaWRhdGVfZ2xvYmFsKAogCQlzdHJ1Y3Qg
ZGMgKmRjLAogCQlzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQpCiB7Ci0tIAoyLjI3LjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
