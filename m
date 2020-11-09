Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7294C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2F4206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnIwaAtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2F4206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6548966C;
	Mon,  9 Nov 2020 21:21:41 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA108958E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:12 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id 23so10375554wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A+pA8ZHZ/BWRZ/+5idjB7jAn1iVLFLVHhzg6ecfAKK0=;
 b=rnIwaAtcMH8I2ZxIUoGWsSl6kKjHPDJJrShyAVuGGXNBBDSIsump85D8GU4POVebMN
 E1L8xTS69PO2A8bD7eNCLX1g2XSl+7BuiBQOD/qhy+xQod6/Q8/Ef7akcS/Jtzzrm61R
 9c2sGZxrqEZ1+XxS7jIAj6abpTvKU9oCNdXo4u6GnbxzmQkOQFukaOTpLHoBacS7XwuP
 GQvsqcIDdgOqdqoj4ibSXlHmHb3CgUGENsNWH845TfYVrbh1zjrnx39FoMVR7dC0FQS+
 L3SNZRoVvGLdM5finrmbU6TJiCv4M9wW5PsZ2yDhmovVUU9POtXHWjZWnrXwCkw+MhSp
 16Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A+pA8ZHZ/BWRZ/+5idjB7jAn1iVLFLVHhzg6ecfAKK0=;
 b=RBIpJy4XTjniFokan+xx3N8p5iJwubtpRJ+YPHemKBnOxeGyAph/oOq4HTk4GP54ns
 ZU6j2OBjEDnMh3TvapDzhs9aCb28TFOBGj0J5ZQEj7JhLwDMZgOtZBPesdiRERD5Nbrp
 uPe7YZpQsfoo4K2z+q76Q8pctYSIXTxZgDkSS6AMocihSq2fJesVyIVsCqb/Lz7K8c0y
 diO4KmBwRkJZ4eIKxLj2JOswNKlzb3NAgmD0EOKU7Q3LlDrIXHjNsBkGq/1v9ICOgRDX
 XcZRIwEMbrVMJWrunG75H25+SPpCi6hnNsOYiBo05u8RIPwXU9APBkcHuz9B2BH79QHR
 0JwA==
X-Gm-Message-State: AOAM530cdzvyajs39+OxBAGb0DdWyunZeRCaFPN8oMa0KulSuF/Vfubj
 aj6QYS1IL+t75rFzx8p8YvIAMA==
X-Google-Smtp-Source: ABdhPJyVLaYOP1nCrPZ+uOSyurYo3tOkqxKMbnUwj1C/Ynr5/ZZEq6yFW8JJHxW2WWj6RHgTRiD5Cg==
X-Received: by 2002:adf:93e5:: with SMTP id 92mr20405072wrp.421.1604956751344; 
 Mon, 09 Nov 2020 13:19:11 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:10 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/20] drm/radeon: Move 'radeon_add_legacy_encoder' prototype
 to shared header
Date: Mon,  9 Nov 2020 21:18:39 +0000
Message-Id: <20201109211855.3340030-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogIGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2xlZ2FjeV9lbmNvZGVycy5jOjE3NDU6MTogd2Fybmlu
Zzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fYWRkX2xlZ2FjeV9lbmNvZGVy
4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIDE3NDUgfCByYWRlb25fYWRkX2xlZ2FjeV9lbmNv
ZGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVpbnQzMl90IGVuY29kZXJfZW51bSwgdWludDMy
X3Qgc3VwcG9ydGVkX2RldmljZSkKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQg
U2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1t
ZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpT
aWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmggICAgICAgICAgfCAyICsrCiBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVycy5jIHwgMyAtLS0KIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5oCmluZGV4
IGEwYzI0OTdjZDRjZjQuLjBjYzhmMDgxZTExM2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb24uaApA
QCAtMjgxNyw2ICsyODE3LDggQEAgZXh0ZXJuIHZvaWQgcmFkZW9uX3diX2Rpc2FibGUoc3RydWN0
IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogZXh0ZXJuIHZvaWQgcmFkZW9uX3N1cmZhY2VfaW5pdChz
dHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiBleHRlcm4gaW50IHJhZGVvbl9jc19wYXJzZXJf
aW5pdChzdHJ1Y3QgcmFkZW9uX2NzX3BhcnNlciAqcCwgdm9pZCAqZGF0YSk7CiBleHRlcm4gdm9p
ZCByYWRlb25fbGVnYWN5X3NldF9jbG9ja19nYXRpbmcoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYsIGludCBlbmFibGUpOworZXh0ZXJuIHZvaWQgcmFkZW9uX2xlZ2FjeV9iYWNrbGlnaHRfaW5p
dChzdHJ1Y3QgcmFkZW9uX2VuY29kZXIgKnJhZGVvbl9lbmNvZGVyLAorCQkJCQkgc3RydWN0IGRy
bV9jb25uZWN0b3IgKmRybV9jb25uZWN0b3IpOwogZXh0ZXJuIHZvaWQgcmFkZW9uX2F0b21fc2V0
X2Nsb2NrX2dhdGluZyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgaW50IGVuYWJsZSk7CiBl
eHRlcm4gdm9pZCByYWRlb25fdHRtX3BsYWNlbWVudF9mcm9tX2RvbWFpbihzdHJ1Y3QgcmFkZW9u
X2JvICpyYm8sIHUzMiBkb21haW4pOwogZXh0ZXJuIGJvb2wgcmFkZW9uX3R0bV9ib19pc19yYWRl
b25fYm8oc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibyk7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVycy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fZW5jb2RlcnMuYwppbmRleCBjZWQwMjJmYWUxOWQ3Li4zZTM0MmZkODEyZmY0IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9lbmNvZGVycy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2VuY29kZXJzLmMKQEAgLTMzLDkgKzMzLDYg
QEAKICNpbmNsdWRlICJyYWRlb24uaCIKICNpbmNsdWRlICJhdG9tLmgiCiAKLWV4dGVybiB2b2lk
Ci1yYWRlb25fbGVnYWN5X2JhY2tsaWdodF9pbml0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqcmFk
ZW9uX2VuY29kZXIsCi0JCQkgICAgIHN0cnVjdCBkcm1fY29ubmVjdG9yICpkcm1fY29ubmVjdG9y
KTsKIGV4dGVybiB2b2lkCiByYWRlb25fYXRvbV9iYWNrbGlnaHRfaW5pdChzdHJ1Y3QgcmFkZW9u
X2VuY29kZXIgKnJhZGVvbl9lbmNvZGVyLAogCQkJICAgc3RydWN0IGRybV9jb25uZWN0b3IgKmRy
bV9jb25uZWN0b3IpOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
