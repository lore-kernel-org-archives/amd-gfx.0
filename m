Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B23C64E7C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF27F20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+ke7JtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF27F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AFF36EBD0;
	Fri, 27 Nov 2020 10:15:07 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147A56E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:29 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id w24so2469164wmi.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g0apstHJcdeOJJW9Rp51CgUS07wmlnhOot/Yb8U7ShY=;
 b=R+ke7JtZPgsc78EmFR6U0OdvfKYXOPVsJWKDRwLe3Ib/J8HQUt/IyO9zTCBy6ycOwp
 3W6aObfhdCgvjBaLbR9kCaf+DYxtlxZGQ1ThIPq8Vds/1uNBJWazJO23cK6YqcZ3c+Yc
 MqfvUgwieLkQBpToE6a7CdkpYbfdLiWr5VWEPlODGD5Zk31w7mwaLI/kjS7sA2rMeum0
 1S3ERwYCziOtrYZLOk9P+xCMMFHkzDKyBpVRoDA4vmDWdGi9vr0zYxIMCGF3GF85HU6U
 EuaaisE1ndR/xqpCDhrU3qdVwT5AsQIhI1HHu6GIos3y7XyF9T0c5b90tmIIEGgwTWJ8
 621Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g0apstHJcdeOJJW9Rp51CgUS07wmlnhOot/Yb8U7ShY=;
 b=hm75Mm6q8o+RcrRRRIWP1VQChqELGcJ7vkKLh+yt/cg5jU4NpCNEJBNoLn1JLYaYx9
 DVJsmGJuLiEH+uRBlq5a7KFuC9lTXQ6TTH2Y+7hf8LMbSnxj6D31KYgovI92R2v6cBgD
 /z1WTmw+2ldY1VyN8kTfPhbi6ZosrPo2HDXhmQh0oA/B3hYX3/UcnfmhLUZ559a7Q8JL
 NMAh9/M9RHWnoPzRxRksftx9ZO+N8DzRlA6cEcjOaDbWrTKuVyQokZH3VYKtDrDHcQRH
 RYyfqlT3ChlX/cjSyLi2QOC6Z9MfOJROQbzvt1YgCvNMdoMkQ9TCfY1d/ON00LWl4wq/
 9hxA==
X-Gm-Message-State: AOAM530uQ6zOxtcnQoFQXdkPX0r0sa09QgXML/9wC7U16ZHt2hR3AEEe
 8uJ9WLKkUuf4JkSnvxVX/xrS+2DfDHuQ5WlY
X-Google-Smtp-Source: ABdhPJzlIHc2c/XjQl02c0jI8u0yuAVD3Oew92DIaDaYRljVrBeZBuPDQMsWkUM7OAdpfTfPo5rbqg==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr3666442wmj.36.1606398207768; 
 Thu, 26 Nov 2020 05:43:27 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:27 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 28/40] drm/amd/pm/powerplay/hwmgr/smu_helper: Demote or fix
 kernel-doc headers
Date: Thu, 26 Nov 2020 13:42:28 +0000
Message-Id: <20201126134240.3214176-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYzox
MTI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2h3bWdyJyBub3QgZGVz
Y3JpYmVkIGluICdwaG1fd2FpdF9vbl9yZWdpc3RlcicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL3BtL3Bvd2VycGxheS9od21nci9zbXVfaGVscGVyLmM6MTEyOiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpbmRleCcgbm90IGRlc2NyaWJlZCBpbiAncGhtX3dh
aXRfb25fcmVnaXN0ZXInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBs
YXkvaHdtZ3Ivc211X2hlbHBlci5jOjExMjogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9y
IG1lbWJlciAndmFsdWUnIG5vdCBkZXNjcmliZWQgaW4gJ3BobV93YWl0X29uX3JlZ2lzdGVyJwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxw
ZXIuYzoxMTI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ21hc2snIG5v
dCBkZXNjcmliZWQgaW4gJ3BobV93YWl0X29uX3JlZ2lzdGVyJwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYzoxNDU6IHdhcm5pbmc6
IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2h3bWdyJyBub3QgZGVzY3JpYmVkIGluICdw
aG1fd2FpdF9vbl9pbmRpcmVjdF9yZWdpc3RlcicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3BtL3Bvd2VycGxheS9od21nci9zbXVfaGVscGVyLmM6MTQ1OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpbmRpcmVjdF9wb3J0JyBub3QgZGVzY3JpYmVkIGluICdw
aG1fd2FpdF9vbl9pbmRpcmVjdF9yZWdpc3RlcicKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3BtL3Bvd2VycGxheS9od21nci9zbXVfaGVscGVyLmM6MTQ1OiB3YXJuaW5nOiBGdW5jdGlv
biBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpbmRleCcgbm90IGRlc2NyaWJlZCBpbiAncGhtX3dhaXRf
b25faW5kaXJlY3RfcmVnaXN0ZXInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9w
b3dlcnBsYXkvaHdtZ3Ivc211X2hlbHBlci5jOjE0NTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1l
dGVyIG9yIG1lbWJlciAndmFsdWUnIG5vdCBkZXNjcmliZWQgaW4gJ3BobV93YWl0X29uX2luZGly
ZWN0X3JlZ2lzdGVyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5
L2h3bWdyL3NtdV9oZWxwZXIuYzoxNDU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBt
ZW1iZXIgJ21hc2snIG5vdCBkZXNjcmliZWQgaW4gJ3BobV93YWl0X29uX2luZGlyZWN0X3JlZ2lz
dGVyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3Nt
dV9oZWxwZXIuYzo0OTQ6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2h3
bWdyJyBub3QgZGVzY3JpYmVkIGluICdwaG1faW5pdGlhbGl6YV9keW5hbWljX3N0YXRlX2FkanVz
dG1lbnRfcnVsZV9zZXR0aW5ncycKCkNjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYyB8
IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Iv
c211X2hlbHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211
X2hlbHBlci5jCmluZGV4IDJhMGNhNTE5NGJiZTkuLmJmZTgwYWMwYWQ4YzggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdV9oZWxwZXIuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXVfaGVscGVyLmMKQEAg
LTEwMyw3ICsxMDMsNyBAQCB1aW50MzJfdCBwaG1fc2V0X2ZpZWxkX3RvX3UzMih1MzIgb2Zmc2V0
LCB1MzIgb3JpZ2luYWxfZGF0YSwgdTMyIGZpZWxkLCB1MzIgc2l6ZQogCXJldHVybiBvcmlnaW5h
bF9kYXRhOwogfQogCi0vKioKKy8qCiAgKiBSZXR1cm5zIG9uY2UgdGhlIHBhcnQgb2YgdGhlIHJl
Z2lzdGVyIGluZGljYXRlZCBieSB0aGUgbWFzayBoYXMKICAqIHJlYWNoZWQgdGhlIGdpdmVuIHZh
bHVlLgogICovCkBAIC0xMzIsNyArMTMyLDcgQEAgaW50IHBobV93YWl0X29uX3JlZ2lzdGVyKHN0
cnVjdCBwcF9od21nciAqaHdtZ3IsIHVpbnQzMl90IGluZGV4LAogfQogCiAKLS8qKgorLyoKICAq
IFJldHVybnMgb25jZSB0aGUgcGFydCBvZiB0aGUgcmVnaXN0ZXIgaW5kaWNhdGVkIGJ5IHRoZSBt
YXNrIGhhcwogICogcmVhY2hlZCB0aGUgZ2l2ZW4gdmFsdWUuVGhlIGluZGlyZWN0IHNwYWNlIGlz
IGRlc2NyaWJlZCBieSBnaXZpbmcKICAqIHRoZSBtZW1vcnktbWFwcGVkIGluZGV4IG9mIHRoZSBp
bmRpcmVjdCBpbmRleCByZWdpc3Rlci4KQEAgLTQ4Niw5ICs0ODYsOSBAQCBpbnQgcGhtX2dldF9z
Y2xrX2Zvcl92b2x0YWdlX2V2dihzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogfQogCiAvKioKLSAq
IEluaXRpYWxpemUgRHluYW1pYyBTdGF0ZSBBZGp1c3RtZW50IFJ1bGUgU2V0dGluZ3MKKyAqIHBo
bV9pbml0aWFsaXphX2R5bmFtaWNfc3RhdGVfYWRqdXN0bWVudF9ydWxlX3NldHRpbmdzIC0gSW5p
dGlhbGl6ZSBEeW5hbWljIFN0YXRlIEFkanVzdG1lbnQgUnVsZSBTZXR0aW5ncwogICoKLSAqIEBw
YXJhbSAgICBod21nciAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5h
Z2VyLgorICogQGh3bWdyOiAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBt
YW5hZ2VyLgogICovCiBpbnQgcGhtX2luaXRpYWxpemFfZHluYW1pY19zdGF0ZV9hZGp1c3RtZW50
X3J1bGVfc2V0dGluZ3Moc3RydWN0IHBwX2h3bWdyICpod21ncikKIHsKLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
