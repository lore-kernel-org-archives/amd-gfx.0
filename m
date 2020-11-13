Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D1C61DD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEF122240
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVPSe3gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEF122240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292E56E5BD;
	Fri, 13 Nov 2020 14:28:30 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3276E527
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:49:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 10so8207209wml.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7u3R7+OjGQISbkuCs2m/TsCWsUoo+j2lw9OomX7FkgE=;
 b=oVPSe3gKajXzmTwgKcAiPMc6n66vSQUTIbxQGrlpz617vtWWaflWGSCujuQ8cnhsl8
 Flp6j1U3fpCW7BBDGzKQP/99ib4s8fxs/3AQJXmBbOgVUYM9cW6lcnZJ6CnLvJKja8Ko
 d8CatTkf5GLBuTFXz+J+cf8WtmeIFmL5KsDnbuSwPcotT3zNcJ6w1GsXt+oCK9Lbw+nZ
 gm0psYuaDRRopbobUkafy6BIEHXJI+i+Eh5apV9e39CP9yF7cHUUGtaYNL6A+xjJB/xM
 6gmjz6brGCBOeN1cuNZFWtroPbG536JOhvA1Fyspe4+AV4ymKme21mmgH9JPXwIC3zjR
 ZyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7u3R7+OjGQISbkuCs2m/TsCWsUoo+j2lw9OomX7FkgE=;
 b=rH5ZqEOCR57t54sFlLF7p3XhjmlmUV3L364xH52ZM/8VbjHyfthvi647vgmX9ubqwd
 scUpcfqY0GznoGW2JU3qF32/EyWznoxmDg9gpYRaZMsZcd8G2iic6j02+OqC5t6EDMCi
 2vCfmkKGaX9hHY7M1HJ0JUx5hFIqo9wnj5/FQQQitTpLSvGn2It+3Ijcrl6UMXNdDyBO
 XaG0i+infDXSRfuGteiuTBeYJVTOjsfVoXVpJ60gGaIMwZ8G4axac4g88yNr2jXG8ZMS
 FamghhAISxcskRkfwutxAtPNyn5E3XWo/dMnnFTgnexQXF23o3/BXumCSwHSRFX3oH60
 Reqw==
X-Gm-Message-State: AOAM5334uXAKf5TT3obf+3qpHynpbOIj2txHWtwa1bvHzvFFGgkKijNm
 /o2Q4igd7rNMHjfeiwMPDezjSQ==
X-Google-Smtp-Source: ABdhPJxQxDqy7G7JaMskfG7ggUP9cLK1dW0ajER8rOj49sVwLKSqBc/GlSBicq1fC1nSz6FeOTHKOg==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr2531152wms.182.1605275395681; 
 Fri, 13 Nov 2020 05:49:55 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:49:55 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/40] drm/amd/amdgpu/amdgpu_pll: Fix kernel-doc formatting,
 missing and extra params
Date: Fri, 13 Nov 2020 13:49:09 +0000
Message-Id: <20201113134938.4004947-12-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jOjEyMTogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnZnJlcScgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3BsbF9j
b21wdXRlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jOjEyMTogd2Fy
bmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZmJfZGl2X3AnIG5vdCBkZXNjcmli
ZWQgaW4gJ2FtZGdwdV9wbGxfY29tcHV0ZScKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wbGwuYzoxMjE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Zy
YWNfZmJfZGl2X3AnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9wbGxfY29tcHV0ZScKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYzoxMjE6IHdhcm5pbmc6IEZ1bmN0aW9u
IHBhcmFtZXRlciBvciBtZW1iZXIgJ3JlZl9kaXZfcCcgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1
X3BsbF9jb21wdXRlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jOjEy
MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncG9zdF9kaXZfcCcgbm90
IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3BsbF9jb21wdXRlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BsbC5jOjMxNzogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRl
ciAnZW5jb2RlcicgZGVzY3JpcHRpb24gaW4gJ2FtZGdwdV9wbGxfZ2V0X3NoYXJlZF9ub25kcF9w
cGxsJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMgfCAxMCAr
KysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYwppbmRleCAxZjIzMDViN2Jk
MTM1Li5mMmUyMDY2NmM5YzFiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcGxsLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bs
bC5jCkBAIC0xMDIsMTEgKzEwMiwxMiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcGxsX2dldF9mYl9y
ZWZfZGl2KHVuc2lnbmVkIG5vbSwgdW5zaWduZWQgZGVuLCB1bnNpZ25lZCBwb3N0XwogICogYW1k
Z3B1X3BsbF9jb21wdXRlIC0gY29tcHV0ZSBQTEwgcGFyYW1hdGVycwogICoKICAqIEBwbGw6IGlu
Zm9ybWF0aW9uIGFib3V0IHRoZSBQTEwKKyAqIEBmcmVxOiByZXF1ZXN0ZWQgZnJlcXVlbmN5CiAg
KiBAZG90X2Nsb2NrX3A6IHJlc3VsdGluZyBwaXhlbCBjbG9jawotICogZmJfZGl2X3A6IHJlc3Vs
dGluZyBmZWVkYmFjayBkaXZpZGVyCi0gKiBmcmFjX2ZiX2Rpdl9wOiBmcmFjdGlvbmFsIHBhcnQg
b2YgdGhlIGZlZWRiYWNrIGRpdmlkZXIKLSAqIHJlZl9kaXZfcDogcmVzdWx0aW5nIHJlZmVyZW5j
ZSBkaXZpZGVyCi0gKiBwb3N0X2Rpdl9wOiByZXN1bHRpbmcgcmVmZXJlbmNlIGRpdmlkZXIKKyAq
IEBmYl9kaXZfcDogcmVzdWx0aW5nIGZlZWRiYWNrIGRpdmlkZXIKKyAqIEBmcmFjX2ZiX2Rpdl9w
OiBmcmFjdGlvbmFsIHBhcnQgb2YgdGhlIGZlZWRiYWNrIGRpdmlkZXIKKyAqIEByZWZfZGl2X3A6
IHJlc3VsdGluZyByZWZlcmVuY2UgZGl2aWRlcgorICogQHBvc3RfZGl2X3A6IHJlc3VsdGluZyBy
ZWZlcmVuY2UgZGl2aWRlcgogICoKICAqIFRyeSB0byBjYWxjdWxhdGUgdGhlIFBMTCBwYXJhbWV0
ZXJzIHRvIGdlbmVyYXRlIHRoZSBnaXZlbiBmcmVxdWVuY3k6CiAgKiBkb3RfY2xvY2sgPSAocmVm
X2ZyZXEgKiBmZWVkYmFja19kaXYpIC8gKHJlZl9kaXYgKiBwb3N0X2RpdikKQEAgLTMwOCw3ICsz
MDksNiBAQCBpbnQgYW1kZ3B1X3BsbF9nZXRfc2hhcmVkX2RwX3BwbGwoc3RydWN0IGRybV9jcnRj
ICpjcnRjKQogICogYW1kZ3B1X3BsbF9nZXRfc2hhcmVkX25vbmRwX3BwbGwgLSByZXR1cm4gdGhl
IFBQTEwgdXNlZCBieSBhbm90aGVyIG5vbi1EUCBjcnRjCiAgKgogICogQGNydGM6IGRybSBjcnRj
Ci0gKiBAZW5jb2RlcjogZHJtIGVuY29kZXIKICAqCiAgKiBSZXR1cm5zIHRoZSBQUExMIChQaXhl
bCBQTEwpIHVzZWQgYnkgYW5vdGhlciBub24tRFAgY3J0Yy9lbmNvZGVyIHdoaWNoIGNhbgogICog
YmUgc2hhcmVkIChpLmUuLCBzYW1lIGNsb2NrKS4KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
