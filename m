Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A7CCA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 13:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B0B2196F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 13:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B0B2196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0E26E128;
	Mon, 28 Oct 2019 13:59:27 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94AC6E101;
 Mon, 28 Oct 2019 13:59:25 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id 11so9595728wmk.0;
 Mon, 28 Oct 2019 06:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Epuh0LHyo5E1PcR7w0+WUob9Z/yP2vynavOw5oUf4/c=;
 b=X7CvrXbCQnNu2wiGhwUF67oy7s2t0XF7U3N+rN8xhsUA4hwvnNdn+w4Ata5ogkctkn
 6bM/JszvYkfZYwfnD6AitQIwx6ui4ri1VFrejoIKXQRcRleWqLBT75zUoeefgGyHa+79
 PqjTk2qWynf9YxwFOvjJPTILahCmFnYwbO9c/aCRWN10h+UxPPdUiHOzBPHiEHHnMrBb
 CRHi7VbLIVYKlsRupHMhnTnuP/dHW5IUr9ewMm6HmAbdNFFxBY02sJUevhMu7s+NtmSq
 /2TMWDFWalEKRCoD2qAk3rNXdAkOKM03cmya4oHqqIyWDbUWWcT/q7qEr/hKmMa52Apy
 dZGQ==
X-Gm-Message-State: APjAAAXqgav8suWj/OiujprvpvBz/cD/dKCEV1A+p+/xnOp8//DcXe+8
 7l8X4IY3SSgjM04MRCjbc4hGlj/fkhaGRhmqdr8=
X-Google-Smtp-Source: APXvYqyw5UtXQzVT9itPlyAx1eqR4HO6pq5cZguj7I/ZMP22holSQoobOmFx8TWW7cHP8ML1HZ07F//NeLk7saYWNKA=
X-Received: by 2002:a1c:2008:: with SMTP id g8mr139878wmg.34.1572271164178;
 Mon, 28 Oct 2019 06:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191028133436.30608-1-yuehaibing@huawei.com>
In-Reply-To: <20191028133436.30608-1-yuehaibing@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2019 09:59:11 -0400
Message-ID:
 <CADnq5_MrrJkDVC_yRkNTem7MQ3shcmwHt_ZMDyKd5AxJhR84Mw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Make calculate_integer_scaling
 static
To: YueHaibing <yuehaibing@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=Epuh0LHyo5E1PcR7w0+WUob9Z/yP2vynavOw5oUf4/c=;
 b=QBIYIyYoGcYa3jo8c5+ov/rVPeuL+6GQN+52vm8NB3NS6etmbREn2GD8lexjjBAxZ7
 1JRHzSCbfwGEvMqLbWBTokoYrPkCqbxwQKQGCF0vqyDp0oGATyL+Uj8nPawQi/vKmRGL
 sVaqwCjeo8R9d8nlzUTARFBhWjzYWo5Bf4h8oSb52L4XpVQJkbGxRlKCiBJqm5hPqnBn
 C4yplxDikJ+1iyoU+rCNh+YUR1vUoXo5dEcwWmK6AU+gatifXL93RFzFPgdQ22Xuur7+
 MclWTZFPSjbfXietlwbpCNZ+GEpHLt3J4waHkBO0xMZ5NAnCINy7ehLotdrX54fpD37m
 TN1Q==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Chunming Zhou <David1.Zhou@amd.com>, "Amini, Reza" <Reza.Amini@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Tatla,
 Harmanprit" <Harmanprit.Tatla@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <eric.bernstein@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 "Wentland, Harry" <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028135911.g77KiG3usGbn9VG6CbB9bvD4fA6FDvowTU4n_b5zpVA@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgOTozNiBBTSBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+IHdyb3RlOgo+Cj4gRml4IHNwYXJzZSB3YXJuaW5nOgo+Cj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmM6OTYzOjY6Cj4g
IHdhcm5pbmc6IHN5bWJvbCAnY2FsY3VsYXRlX2ludGVnZXJfc2NhbGluZycgd2FzIG5vdCBkZWNs
YXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KPgo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxo
dWxrY2lAaHVhd2VpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5n
QGh1YXdlaS5jb20+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKPiBpbmRleCA3MGU2
MDFhLi4zNzY5ODMwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX3Jlc291cmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19yZXNvdXJjZS5jCj4gQEAgLTk2MCw3ICs5NjAsNyBAQCBzdGF0aWMgYm9vbCBh
cmVfcmVjdHNfaW50ZWdlcl9tdWx0aXBsZXMoc3RydWN0IHJlY3Qgc3JjLCBzdHJ1Y3QgcmVjdCBk
ZXN0KQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICB9Cj4KPiAtdm9pZCBjYWxjdWxhdGVfaW50
ZWdlcl9zY2FsaW5nKHN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgpCj4gK3N0YXRpYyB2b2lkIGNh
bGN1bGF0ZV9pbnRlZ2VyX3NjYWxpbmcoc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0eCkKPiAgewo+
ICAgICAgICAgaWYgKCFwaXBlX2N0eC0+cGxhbmVfc3RhdGUtPnNjYWxpbmdfcXVhbGl0eS5pbnRl
Z2VyX3NjYWxpbmcpCj4gICAgICAgICAgICAgICAgIHJldHVybjsKPiAtLQo+IDIuNy40Cj4KPgo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
