Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E96C64E7C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F52F22263
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjRgiF3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F52F22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDE56EA20;
	Mon, 16 Nov 2020 19:18:43 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDEC89F3B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:17 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id h2so40317wmm.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
 b=vjRgiF3sSV4IhUHRkfrW6zpxaiOTAP5+ndmpMJ5njzwICymUi4FgUOeakjFqSbhu4P
 Ux+bCPQFOWiIKcYf5U+jGLeG+dNLaoDVDRnxbur3utiqelyXUWvmqV5okLCcKN+XHXGK
 3PTAT4CET3cVGb445Pcpfunq48d+MHHvGL8PFGirnEA9uULw5eR0b38qaAFibnFf2Kg8
 Vv06ZwvmKCQdSstEOvE6BbwJlK4BDuM8nEZo67fVcHjSfstZ/2DVeffUp/aDK3dofOkn
 3AsUz+crAA5fDsvaAni98zlrqW8tFV4fJAe46+wuXXTDPWp3Dt6Dr0c1P+61dZyZYABK
 cSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iZGU4hgv9ySSnT3lm5gi+Q8yFIEoSUWPQdVLIUJTRR4=;
 b=uhI8Ru6KjmsNK+I9kfk+CuyyXD9kJanIDLbAsJTxZImcY1CCMoSYCYclhqeiNr2K+v
 xQflV6euPVNKegZohvKFg5mCW/tWlt43Xvam482Zk4mJXWLkhnZ2Bvf5/ZUoGiegyybu
 WqEc59cYYU3bd4am2vGz2WLb8iy26HMH4dGycG6R8PIf0wTHgnii73LoHTZpA4xSYguF
 ib289Mpr2qP0LBVIUPUzkHSMiaGKHBmRzIvjKmVqSWFswECNr8NnidiwNYIUMm6bnRFs
 Hgn3NXqf4aVu1oTOIBUf/cSjkN9V8Jk0AH4XslkI5yi9K01HT1k+005nJzPkgqIcUERk
 XTOA==
X-Gm-Message-State: AOAM530kqflW6ORC++E3YreohkJOsxeJjpxUmaCsLtarPeZRw04Kx+TO
 +W3+n+fIwvf+dYENohJjP1pi3Q==
X-Google-Smtp-Source: ABdhPJxbzdfNIyAFT2LF3a9ZdTCAEIeELmy4y2jPN9Zvr+QlzxMIe75PBAOzGqb0m2oCDoDMXOde/Q==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr23442wmi.42.1605548235694;
 Mon, 16 Nov 2020 09:37:15 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/43] drm/radeon/radeon_irq_kms: Demote non-conformant
 kernel-doc fix another
Date: Mon, 16 Nov 2020 17:36:25 +0000
Message-Id: <20201116173700.1830487-9-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjU2OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdpcnEnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9kcml2ZXJf
aXJxX2hhbmRsZXJfa21zJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5j
OjU2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhcmcnIG5vdCBkZXNj
cmliZWQgaW4gJ3JhZGVvbl9kcml2ZXJfaXJxX2hhbmRsZXJfa21zJwogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjU3MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
IG9yIG1lbWJlciAnbicgbm90IGRlc2NyaWJlZCBpbiAncmFkZW9uX2lycV9rbXNfc2V0X2lycV9u
X2VuYWJsZWQnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9pcnFfa21zLmM6NTcxOiB3
YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdudW0nIGRlc2NyaXB0aW9uIGluICdy
YWRlb25faXJxX2ttc19zZXRfaXJxX25fZW5hYmxlZCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25faXJxX2ttcy5jIHwgOCArKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9pcnFfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9p
cnFfa21zLmMKaW5kZXggYjg2YmM4OGFkNDMwOC4uYTI0MmI2MDUzZDQ3ZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2lycV9rbXMuYwpAQCAtNDMsMTEgKzQzLDkgQEAKIAogI2RlZmlu
ZSBSQURFT05fV0FJVF9JRExFX1RJTUVPVVQgMjAwCiAKLS8qKgorLyoKICAqIHJhZGVvbl9kcml2
ZXJfaXJxX2hhbmRsZXJfa21zIC0gaXJxIGhhbmRsZXIgZm9yIEtNUwogICoKLSAqIEBpbnQgaXJx
LCB2b2lkICphcmc6IGFyZ3MKLSAqCiAgKiBUaGlzIGlzIHRoZSBpcnEgaGFuZGxlciBmb3IgdGhl
IHJhZGVvbiBLTVMgZHJpdmVyIChhbGwgYXNpY3MpLgogICogcmFkZW9uX2lycV9wcm9jZXNzIGlz
IGEgbWFjcm8gdGhhdCBwb2ludHMgdG8gdGhlIHBlci1hc2ljCiAgKiBpcnEgaGFuZGxlciBjYWxs
YmFjay4KQEAgLTU0OSwxNCArNTQ3LDE0IEBAIHZvaWQgcmFkZW9uX2lycV9rbXNfZGlzYWJsZV9o
cGQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHVuc2lnbmVkIGhwZF9tYXNrKQogfQogCiAv
KioKLSAqIHJhZGVvbl9pcnFfa21zX3VwZGF0ZV9pbnRfbiAtIGhlbHBlciBmb3IgdXBkYXRpbmcg
aW50ZXJydXB0IGVuYWJsZSByZWdpc3RlcnMKKyAqIHJhZGVvbl9pcnFfa21zX3NldF9pcnFfbl9l
bmFibGVkIC0gaGVscGVyIGZvciB1cGRhdGluZyBpbnRlcnJ1cHQgZW5hYmxlIHJlZ2lzdGVycwog
ICoKICAqIEByZGV2OiByYWRlb24gZGV2aWNlIHBvaW50ZXIKICAqIEByZWc6IHRoZSByZWdpc3Rl
ciB0byB3cml0ZSB0byBlbmFibGUvZGlzYWJsZSBpbnRlcnJ1cHRzCiAgKiBAbWFzazogdGhlIG1h
c2sgdGhhdCBlbmFibGVzIHRoZSBpbnRlcnJ1cHRzCiAgKiBAZW5hYmxlOiB3aGV0aGVyIHRvIGVu
YWJsZSBvciBkaXNhYmxlIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIKICAqIEBuYW1lOiB0aGUgbmFt
ZSBvZiB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIHRvIHByaW50IHRvIHRoZSBrZXJuZWwgbG9nCi0g
KiBAbnVtOiB0aGUgbnVtYmVyIG9mIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIgdG8gcHJpbnQgdG8g
dGhlIGtlcm5lbCBsb2cKKyAqIEBuOiB0aGUgbnVtYmVyIG9mIHRoZSBpbnRlcnJ1cHQgcmVnaXN0
ZXIgdG8gcHJpbnQgdG8gdGhlIGtlcm5lbCBsb2cKICAqCiAgKiBIZWxwZXIgZm9yIHVwZGF0aW5n
IHRoZSBlbmFibGUgc3RhdGUgb2YgaW50ZXJydXB0IHJlZ2lzdGVycy4gQ2hlY2tzIHdoZXRoZXIK
ICAqIG9yIG5vdCB0aGUgaW50ZXJydXB0IG1hdGNoZXMgdGhlIGVuYWJsZSBzdGF0ZSB3ZSB3YW50
LiBJZiBpdCBkb2Vzbid0LCB0aGVuCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
