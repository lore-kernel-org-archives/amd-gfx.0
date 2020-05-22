Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A810C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 13:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EFB2065F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2N2kPDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EFB2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B780F6E9D4;
	Fri, 22 May 2020 13:26:57 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8199C6E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 13:26:56 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id z4so8649893wmi.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 06:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nt1+thcwZQ6h5Zg+MoB2ZFloKr8cmoxgQIanGmc3m3c=;
 b=V2N2kPDC+Nk/KWnqG2blZiAdz+4kf96Cs7Sj6zXMqQnxSaN4eblhnW1VwSb96xCIns
 Qsoh7sZPGcwd2d9veTBbF/f5TWgDLctg9Bae4t3Gy8GbFyKjo6Wx91o8+BlKcUrpQOlE
 rRSGdDaerDTH/Prm0XioTCj9FH4JUFGyAGv3+w63RwnzTh8r/rW6OFfblVX8X5kF5SAw
 HKcgexG20Z5Y7bIPRVeaz2otJUcFOvuQDSnhvq0a4iUGpEIWQ85VMaxvkoDctZkW1+5K
 9bgRhTYH/K26EkIWTC4SD+H2H7gsa1SjhNqe7tl5/pV+1QSbOV4H9MdgDFCN62z4Vbbc
 3WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nt1+thcwZQ6h5Zg+MoB2ZFloKr8cmoxgQIanGmc3m3c=;
 b=lvAA2RaZzISWcPMKB0v/v22cSnITopdIhFdIFEKRB0NC3genzsQUxSnaOApCsmEh0s
 2W7IMQ9YyOHlbkGxDe30zL+2/5XOD+Y5ZWJtrtxBIBuctX6HXcKduIcjxCKU/PecZEcx
 8uInxR9Emm9IKwjIB83lZSgPCWXAUdQI/liCQ+Pp73VJIglGJVwdmSdvr+nVASY1MOaU
 Xql3tE3fExm4d1LmMLmRqbFnEtOTxvGR6KNx744aNfxoNMuFoz9CD7FopPlXTPN0Hnvr
 5HzhlkSvFr8PA+nWi2ndAnG6jHUyq7HIyzPTc5tQXgvopicIc1qtOMxNOPWpYgOeGfgg
 4a9A==
X-Gm-Message-State: AOAM530IACRhKqhO0JeZIpXVIZRRbwR83z1FrjtDoT/pv2rY2G4epgS5
 7rPO3jlXXDsgSchDy3XsGUvTyzS58JNSBM2UkRiP3A==
X-Google-Smtp-Source: ABdhPJzwctAOS7qFQb9P1l+FlUL9z0Sz6nbjQc8fXNz++eaKjqzFYk7kc/cGYeqbtFVX3rvx+vJUdvSkpO3H8ysH5gE=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr13324937wmh.39.1590154015140; 
 Fri, 22 May 2020 06:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521202308.1996496-1-alexander.deucher@amd.com>
 <a6e85019-8c0c-fab5-2ebe-431662c9b646@gmail.com>
In-Reply-To: <a6e85019-8c0c-fab5-2ebe-431662c9b646@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 May 2020 09:26:43 -0400
Message-ID: <CADnq5_PEnn33nNgneiCZVE7z-ic=Gauj=o+-CrHxVWSJMQqL_g@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling"
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBNYXkgMjIsIDIwMjAgYXQgNjoyNSBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBXZWxsIHdoYXQgZXhhY3RseSBp
cyBnb2luZyB3cm9uZyBoZXJlPwo+Cj4gQXQgbGVhc3QgdGhpcyBvbmUgbG9va3MgY29ycmVjdCB0
byBtZSwgYW5kIGlmIGl0IGJsb2NrcyB0aGUgcmV2ZXJ0IHdlCj4gc2hvdWxkIHByb2JhYmx5IHNx
dWFzaCBpdCBpbiB0aGVyZSBhcyB3ZWxsLgoKSSBjYW4gc3F1YXNoIHRoZW0gdG9nZXRoZXIuICBU
aGVzZSB3ZXJlIGp1c3QgZGVwZW5kZW5jZXMuICBUaGUgaXNzdWUKaXMgdGhlIHRoaXJkIHBhdGNo
LgoKQWxleAoKCj4KPiBDaHJpc3RpYW4uCj4KPiBBbSAyMS4wNS4yMCB1bSAyMjoyMyBzY2hyaWVi
IEFsZXggRGV1Y2hlcjoKPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYjQxZDlkZjJiNjgwYjk2OTEz
Y2MzY2NmOTI5MjUyZTJkY2U3MWIyNC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgfCAzICsrLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BtLmMKPiA+IGluZGV4IDJmYzUxZjgxNWVhYS4uNzJiYmI4MTc1YjIyIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMKPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCj4gPiBAQCAtMTg0
Myw4ICsxODQzLDkgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2F0dHJfY3JlYXRlX2dyb3Vw
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiA+ICAgICAgIHJldHVybiAwOwo+ID4KPiA+
ICAgZmFpbGVkOgo+ID4gLSAgICAgd2hpbGUgKGktLSkKPiA+ICsgICAgIGZvciAoOyBpID4gMDsg
aS0tKSB7Cj4gPiAgICAgICAgICAgICAgIGFtZGdwdV9kZXZpY2VfYXR0cl9yZW1vdmUoYWRldiwg
JmF0dHJzW2ldKTsKPiA+ICsgICAgIH0KPiA+Cj4gPiAgICAgICByZXR1cm4gcmV0Owo+ID4gICB9
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
