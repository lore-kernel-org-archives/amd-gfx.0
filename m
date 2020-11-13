Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7453BC63697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341F220715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzX7/w5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341F220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7DAB6E588;
	Fri, 13 Nov 2020 14:28:20 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841496E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:21 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a65so8578264wme.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xrnyrit0v6fzfrooRNMi88M6HiPrfycz27kzVEg4yYM=;
 b=xzX7/w5JkEJWFNmWJ9XhEULYWxZdlL484sgDqokJC2N74ZDAzRW9fNa/+pZRfQXoPX
 w8vSlD7sbufyf6Tbg3R5IVs4V60sFs7/H1PbDBA3gNe9bY4Alpdn5tnIKN9vL33TD/0/
 mBKobWhQGaWzcEpKoZgfmMMnI6AFkzBZ2vwAbhyHidq2K495ZRsaes76xKfe29AD2cyR
 nySZLdB8HAYVQO489IHNmmRwG9MTK+nyLd/nS9jyON3UfUIlWkwfmGp8vli3eiE1+llt
 U96cfho0m+d73d4rKqV6kECpeYyodlf1MvO+KdIAWSFaXtAEGdGp4kXCjLjro1ttEEA5
 qnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xrnyrit0v6fzfrooRNMi88M6HiPrfycz27kzVEg4yYM=;
 b=qk3rrAFrqM3X2ouFdnP/7PEKE13xJb9MVoUmkGJ1pS4wMpL3qeExYz3L9K3hLuvU16
 QLtMBYsfUeOtMgDFtDWv29QGmWbQfQ01K4cUiEX9V3AP8y44PsjWitC2KlLHauhZsHom
 TWn7ZtmcqHJ1m6hCXLOcqUy0c0dEEbayJknr2qIjyS9M1H7pn/vtkXIoKqD2xdOI1P42
 zACzabMeEV/h1++/ml74cjALBp/Yofufz4+mDtjuQMU68e1QiMSiZjodqq9Bpegy9VzZ
 y+9mMTN6kb9Bji9Oe5Fk21wZDTsE5ELD8QPakErxw+MRs4xhIZImZ7EdyyeMasjALVfc
 jdeQ==
X-Gm-Message-State: AOAM531G4Y9qBlqStoQH0cYRRW+blbj302OHhCZBGdxtowU9K6WASy6d
 iM0G9w6HDq8lVAZIMB4snWxElA==
X-Google-Smtp-Source: ABdhPJxleAxe551m1648cnVusxHBA+2YOfp8Wr3sW/9AY28jfMWSIiglJKFPwmqZEbfjZhTBw2Q2Yw==
X-Received: by 2002:a1c:448:: with SMTP id 69mr2516516wme.12.1605275420178;
 Fri, 13 Nov 2020 05:50:20 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:19 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/40] drm/amd/amdgpu/amdgpu_vm_sdma: Fix
 'amdgpu_vm_sdma_prepare()'s doc-rot
Date: Fri, 13 Nov 2020 13:49:29 +0000
Message-Id: <20201113134938.4004947-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYzo2Mzogd2FybmluZzogRnVuY3Rp
b24gcGFyYW1ldGVyIG9yIG1lbWJlciAncmVzdicgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3Zt
X3NkbWFfcHJlcGFyZScKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1h
LmM6NjM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3N5bmNfbW9kZScg
bm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3ZtX3NkbWFfcHJlcGFyZScKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmM6NjM6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlv
biBwYXJhbWV0ZXIgJ293bmVyJyBkZXNjcmlwdGlvbiBpbiAnYW1kZ3B1X3ZtX3NkbWFfcHJlcGFy
ZScKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmM6NjM6IHdhcm5p
bmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2V4Y2x1c2l2ZScgZGVzY3JpcHRpb24gaW4g
J2FtZGdwdV92bV9zZG1hX3ByZXBhcmUnCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5h
cm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzog
bGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtX3NkbWEuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm1fc2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3Nk
bWEuYwppbmRleCBkYjc5MDU3NGRjMmU4Li5hODNhNjQ2NzU5YzU4IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKQEAgLTUxLDggKzUxLDggQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fc2RtYV9tYXBfdGFibGUoc3RydWN0IGFtZGdwdV9ibyAqdGFibGUpCiAg
KiBhbWRncHVfdm1fc2RtYV9wcmVwYXJlIC0gcHJlcGFyZSBTRE1BIGNvbW1hbmQgc3VibWlzc2lv
bgogICoKICAqIEBwOiBzZWUgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgZGVmaW5pdGlvbgotICog
QG93bmVyOiBvd25lciB3ZSBuZWVkIHRvIHN5bmMgdG8KLSAqIEBleGNsdXNpdmU6IGV4Y2x1c2l2
ZSBtb3ZlIGZlbmNlIHdlIG5lZWQgdG8gc3luYyB0bworICogQHJlc3Y6IHJlc2VydmF0aW9uIG9i
amVjdCB3aXRoIGVtYmVkZGVkIGZlbmNlCisgKiBAc3luY19tb2RlOiBzeW5jaHJvbml6YXRpb24g
bW9kZQogICoKICAqIFJldHVybnM6CiAgKiBOZWdhdGl2IGVycm5vLCAwIGZvciBzdWNjZXNzLgot
LSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
