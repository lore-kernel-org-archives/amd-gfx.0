Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F2C17441
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB65206A3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB65206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF6B6E046;
	Mon, 11 Nov 2019 20:36:12 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD356E046
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:36:12 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f3so657622wmc.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 12:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Hs8WKz86XzUIoluSOZo0Sxzyo8CVkAKNCavkYaNLGw=;
 b=i0OqkwZY8Ten5BxWEEUqcUT4D+iXAcmPnRaVpaGRnoUjxHKHhIRlIwuiMXWGf1I9jj
 1ZVhTXKtPthfUCb1CU8nsvqPiKE68vnspXUvk6YBuzpua9Q+m1XA7IIRrYeMc6ej2fxg
 iYMbDhhMArsQifOtl40DPciQoaexVmRoIcWmn0MsJDs2WpVLfQzoelqBu5W0JaSaxr9s
 1bFuN3sSxi/Hs/6b7Z4I9uDvWsziWRgYRnBkDpqhfD5kP81e8odTEBb1wmqSN43sHF3q
 cdMMUEXADpcKK9b3OcfSjCVBg3m1AyPdTCFhfaBdZ8GUsbw5bl+0sDryXmgubkTixygl
 29uQ==
X-Gm-Message-State: APjAAAWe6Bn2cNrKXE0nRUbpL+Id82SsYqMPX7528ar7Y0X2xCcJW2xv
 sncimtAiDXgJ5Lr2NTtnm2671jMpurkJyze+GtgUzg==
X-Google-Smtp-Source: APXvYqwlG/2OIQhaPChGUJzXk1eNkMHqGbXaIe3aV9yzHDBxGh6AxWYo/M0y57THQ4STLSIuzBPpulqUP/0eKpB6Ic8=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr754117wmi.67.1573504570718;
 Mon, 11 Nov 2019 12:36:10 -0800 (PST)
MIME-Version: 1.0
References: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
In-Reply-To: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 15:35:58 -0500
Message-ID:
 <CADnq5_PL1y0O=w6DcZ4uq7B8tJxFx-KpTEr+m2-vVz+d64sVbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Clean up code in radeon_pci_shutdown()
To: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=0Hs8WKz86XzUIoluSOZo0Sxzyo8CVkAKNCavkYaNLGw=;
 b=QH7tBeUVEVlA5jM/gxqSk27QzuUocFCCtBKHp/KhmIws/ve+jW1kwLgGQock2xhwDo
 pMPHUSBY5mQhQk1dGlDAwzsNulaz1U8qi4iOAbC0AdV/qxkS7BZKJMA1G6yLPNpEbbf9
 w+th7huiKfGVn9FmXt9B4THl2ZFnhaXr6a2uX/gZFmvyQIVT6ARZ/Qcel4NfYtlXqdbs
 6pRsyVqwM7PI7IRHzJPvCo5o2aTR+angYBjSXjDmIdn3ummriEKZoa6PKJ3TUn52jQ56
 1c332P4a5VI7jtGXiEOn3rKBPOrnrswHLDd6BQGZ2CIV2YFXFGRA0msz7Ji0hr7U5C5P
 6h7g==
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Chunming Zhou <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111203558.vjRbYOAhigT-WLV5go4tFDVdpLKatrVaUmuGOrbE9lg@z>

T24gTW9uLCBOb3YgMTEsIDIwMTkgYXQgMzoyOSBQTSBLeWxlIE1haGxrdWNoCjxrbWFobGt1Y0Bs
aW51eC52bmV0LmlibS5jb20+IHdyb3RlOgo+Cj4gRnJvbTogS3lsZU1haGxrdWNoIDxrbWFobGt1
Y0BsaW51eC52bmV0LmlibS5jb20+Cj4KPiBUaGlzIGZpeGVzIHRoZSBmb3JtYXR0aW5nIG9uIG9u
ZSBjb21tZW50IGFuZCBjb25zb2xpZGF0ZXMgdGhlCj4gcGNpX2dldF9kcnZkYXRhKCkgaW50byB0
aGUgcmFkZW9uX3N1c3BlbmRfa21zKCkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBLeWxlIE1haGxrdWNo
IDxrbWFobGt1Y0BsaW51eC52bmV0LmlibS5jb20+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoK
PiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgfCA5ICsrKy0tLS0t
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBpbmRleCA0NTI4ZjRkLi4zNTdkMjlhIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBAQCAtMzc5LDEwICszNzksNiBA
QCBzdGF0aWMgaW50IHJhZGVvbl9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4gIHN0
YXRpYyB2b2lkCj4gIHJhZGVvbl9wY2lfc2h1dGRvd24oc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4g
IHsKPiAtI2lmZGVmIENPTkZJR19QUEM2NAo+IC0gICAgICAgc3RydWN0IGRybV9kZXZpY2UgKmRk
ZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7Cj4gLSNlbmRpZgo+IC0KPiAgICAgICAgIC8qIGlm
IHdlIGFyZSBydW5uaW5nIGluIGEgVk0sIG1ha2Ugc3VyZSB0aGUgZGV2aWNlCj4gICAgICAgICAg
KiB0b3JuIGRvd24gcHJvcGVybHkgb24gcmVib290L3NodXRkb3duCj4gICAgICAgICAgKi8KPiBA
QCAtMzkwLDEzICszODYsMTQgQEAgc3RhdGljIGludCByYWRlb25fcGNpX3Byb2JlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LAo+ICAgICAgICAgICAgICAgICByYWRlb25fcGNpX3JlbW92ZShwZGV2KTsK
Pgo+ICAjaWZkZWYgQ09ORklHX1BQQzY0Cj4gLSAgICAgICAvKiBTb21lIGFkYXB0ZXJzIG5lZWQg
dG8gYmUgc3VzcGVuZGVkIGJlZm9yZSBhCj4gKyAgICAgICAvKgo+ICsgICAgICAgICogU29tZSBh
ZGFwdGVycyBuZWVkIHRvIGJlIHN1c3BlbmRlZCBiZWZvcmUgYQo+ICAgICAgICAgICogc2h1dGRv
d24gb2NjdXJzIGluIG9yZGVyIHRvIHByZXZlbnQgYW4gZXJyb3IKPiAgICAgICAgICAqIGR1cmlu
ZyBrZXhlYy4KPiAgICAgICAgICAqIE1ha2UgdGhpcyBwb3dlciBzcGVjaWZpYyBiZWNhdWFzZSBp
dCBicmVha3MKPiAgICAgICAgICAqIHNvbWUgbm9uLXBvd2VyIGJvYXJkcy4KPiAgICAgICAgICAq
Lwo+IC0gICAgICAgcmFkZW9uX3N1c3BlbmRfa21zKGRkZXYsIHRydWUsIHRydWUsIGZhbHNlKTsK
PiArICAgICAgIHJhZGVvbl9zdXNwZW5kX2ttcyhwY2lfZ2V0X2RydmRhdGEocGRldiksIHRydWUs
IHRydWUsIGZhbHNlKTsKPiAgI2VuZGlmCj4gIH0KPgo+IC0tCj4gMS44LjMuMQo+Cj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
