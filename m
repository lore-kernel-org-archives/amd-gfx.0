Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1554C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CAC2225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRLJ1q4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CAC2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AF76E0DF;
	Mon, 16 Nov 2020 19:18:13 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF896E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:40 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 10so30210wml.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
 b=WRLJ1q4UqmT47CdbxnEAngUmUOahyGqrN/s44SVmCRGE6+Btb4XOge97Tzm/ASOQvQ
 kHutEnIMP6rdOJgwGTAuB09lr/dhhN/C9SIIs5MrfN7Hw1/lT9c19lWAECUjdPa/KzFp
 9WRrW4r8nRawZqPNQclJS4KzH2uIjbHP4ys9TnqtcZPjX+SZRjt1oNPvWGWb6WeY5OHz
 3GnCQNaU27a0kw0JU1LPD5VPe/xWhnp19+XdWN77fMIVozxsf5337JKUQThHXJ5HuR7d
 8pR0Uwf6UbEh1hBKF0a3CAPdBv/gWuvcX04dnPdYdSsvHxCMg2WVTP6jTa433VpmMBi9
 8DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
 b=sdMvZrMSjsjE5XnViQth0QfrXarPKDtVrUp5gheeghJpjphrC7SwF+P/NHtYT+YpI6
 SF2Qv68pq0fyM0MKNxT8UMeNVMYvkc7ru0yl6O+ZmDUM0ZRMRNUxtgcjfhVNkjl98Ts8
 rA+QsbhgF96LY+Xa6ExttxpwwnEsGDRI95AAY15s4Rn8HNpm0FD8HN5UYWA735QlNSpk
 hTgV9oC9CsAlWc2m08qim9he2RqKLi2ligvSbZFQKgQDQaZBhLvGIDFxMtSatwtQicXp
 Ys5j6vz4CcLozO4oDcgycR0z8m+5j/pxyZ4/cFSXQs46U4hbU8FY8yOaG0Z+Zk/EQNP4
 Txsg==
X-Gm-Message-State: AOAM531Qrk6QocI2RDYh+TJ0pbM5NWLnbXgUIEdzzc7hLhpL/SDIzCfm
 NeUhnqPU4KSDPsb9FO6sCvUvvaYtMK8ZPqYW
X-Google-Smtp-Source: ABdhPJw0MoOwO876rhqimSbMBMXrkpTGHAmxxSzdJkaUcBzp1n6ZUGdVjsQTISfCOxCG5I7moeivOA==
X-Received: by 2002:a1c:c203:: with SMTP id s3mr16952678wmf.77.1605548259534; 
 Mon, 16 Nov 2020 09:37:39 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:38 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 25/43] drm/radeon/ni_dma: Move
 'cayman_gpu_check_soft_reset()'s prototype to shared header
Date: Mon, 16 Nov 2020 17:36:42 +0000
Message-Id: <20201116173700.1830487-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9uaS5jOjE3MzM6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhjYXltYW5fZ3B1X2NoZWNrX3NvZnRfcmVzZXTigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQogMTczMyB8IHUzMiBjYXltYW5fZ3B1X2NoZWNrX3NvZnRfcmVzZXQoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYpCiB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmggICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL25pX2RtYS5jIHwgMyArLS0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuaCBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuaAppbmRleCBkNjNiZTFjODhjMGYxLi45YTVmMzFh
MDVlNjhmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9uaS5oCkBAIC0zNCw1ICszNCw2IEBAIHZvaWQgY2F5bWFuX2Nw
X2ludF9jbnRsX3NldHVwKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LAogCQkJICAgICAgaW50
IHJpbmcsIHUzMiBjcF9pbnRfY250bCk7CiB2b2lkIGNheW1hbl92bV9kZWNvZGVfZmF1bHQoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCiAJCQkgICAgdTMyIHN0YXR1cywgdTMyIGFkZHIpOwor
dTMyIGNheW1hbl9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7CiAKICNlbmRpZgkJCQkvKiBfX05JX0hfXyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9uaV9kbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmlfZG1hLmMKaW5k
ZXggYzU2MTM2ODQ4MzYwZS4uYmQ1MTVhZDRmZTRjYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9uaV9kbWEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pX2RtYS5j
CkBAIC0yNSwxMCArMjUsOSBAQAogI2luY2x1ZGUgInJhZGVvbi5oIgogI2luY2x1ZGUgInJhZGVv
bl9hc2ljLmgiCiAjaW5jbHVkZSAicmFkZW9uX3RyYWNlLmgiCisjaW5jbHVkZSAibmkuaCIKICNp
bmNsdWRlICJuaWQuaCIKIAotdTMyIGNheW1hbl9ncHVfY2hlY2tfc29mdF9yZXNldChzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldik7Ci0KIC8qCiAgKiBETUEKICAqIFN0YXJ0aW5nIHdpdGggUjYw
MCwgdGhlIEdQVSBoYXMgYW4gYXN5bmNocm9ub3VzCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
