Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7635C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 21:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76886216C4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 21:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnzSJgQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76886216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C257D6E43B;
	Thu, 12 Nov 2020 21:08:36 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0116D6E43B;
 Thu, 12 Nov 2020 21:08:35 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id h2so6480746wmm.0;
 Thu, 12 Nov 2020 13:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+uWZD9FIXBDt/FLwqqCp+AOrNnm42PFk2YUQ8URNfJw=;
 b=OnzSJgQWFb0jmu8Z0ztvodOnTtW+rNQsCRd/NgGB2oAxHG7ENqD5Tgi3xf3fqvgnc5
 AuCO2f487/z2cuENXMhv+LN8qbKGblyCZH1qtw37DnL9+Vfk31puwk4rHViWPCvF3cA8
 N+mbdxYQ+2kAgOlD4mZ00xwA6w+U/ygfcCovwE0bWvK+VOxsTNZBtAmwO8r1xg0nR4iK
 xKB31ttXILvIf/HtiZWy4wAxk7gRjQjG97LrdNFZQZTr+eQOpffQtYwz2u0AELaq/FW3
 bHy3cNO16zRNjGLojIF6ssNftSJeQCVPDLABR2tkic8MZLzs/H6Nn+kL8JwSAg1tN/ww
 xaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+uWZD9FIXBDt/FLwqqCp+AOrNnm42PFk2YUQ8URNfJw=;
 b=BD0i9s1genZg/wwV/RZHU3+zZ4jQ/Q3YZBpAmmQr9N8bwdCsNPxc/HDdkxB57+8EeW
 ccim9zQ4h7EQEapuHQtdkvpr/pTKmI132bROxaOmQMVi8c5jqxCOlFftO1DNap8tZVpP
 l6O8rLd/BUDm/jhljC53noS71HOln8R15j8X3ImhAcYcmx3PrMJdNPtKTjgfeqcnle7n
 08XdF1CFoLQjcCHRwM6WWS0sqXChY+e4v2QON+3Us/C0FPqzm0YC69vwQTWaIhx2WGaJ
 wKiF6r4n5+OM7dBiBF+HQFwUdyn4f3192iH7ndrSB5MggqekI+G5koLa7k/dxSDIiRZq
 4/Yw==
X-Gm-Message-State: AOAM531/pCb2bG7uyNsPC4kkcYtBfOP4lUi2+8IPNJIaCxzFXlNyy2Hi
 XIL9ntW1ZFy9Go1go/7Z+VgayBUyrHeggrMhpho=
X-Google-Smtp-Source: ABdhPJz/VgYcNcf8vhPSfH2uiDexOmE2ZvnT4ScZ7zzX9HFIqhjUcVls3fY+mh4NejYDadUdcouiECKJf3p5PoxxtsI=
X-Received: by 2002:a05:600c:2319:: with SMTP id
 25mr1615761wmo.102.1605215314715; 
 Thu, 12 Nov 2020 13:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-7-lee.jones@linaro.org>
In-Reply-To: <20201112190039.2785914-7-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 16:08:23 -0500
Message-ID: <CADnq5_PP5biKiPMGFDeE0-9cTyoaX12+NnbmLPFkT+UY25ifBg@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/amd/amdgpu/amdgpu_kms: Fix misnaming of
 parameter 'dev'
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMjowMSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYzo0
ODc6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Rldicgbm90IGRlc2Ny
aWJlZCBpbiAnYW1kZ3B1X2luZm9faW9jdGwnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYzo0ODc6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2Fk
ZXYnIGRlc2NyaXB0aW9uIGluICdhbWRncHVfaW5mb19pb2N0bCcKPgo+IENjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpB
cHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9rbXMuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5j
Cj4gaW5kZXggY2VjOWFhZDhiZGZhOS4uOTg3MjFhZTkzMTg0MSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiBAQCAtNDc0LDcgKzQ3NCw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2h3X2lwX2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gIC8qKgo+
ICAgKiBhbWRncHVfaW5mb19pb2N0bCAtIGFuc3dlciBhIGRldmljZSBzcGVjaWZpYyByZXF1ZXN0
Lgo+ICAgKgo+IC0gKiBAYWRldjogYW1kZ3B1IGRldmljZSBwb2ludGVyCj4gKyAqIEBkZXY6IGRy
bSBkZXZpY2UgcG9pbnRlcgo+ICAgKiBAZGF0YTogcmVxdWVzdCBvYmplY3QKPiAgICogQGZpbHA6
IGRybSBmaWxwCj4gICAqCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
