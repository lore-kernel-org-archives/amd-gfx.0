Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A691C43141
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7977220672
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7977220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCBB6E943;
	Fri, 15 Nov 2019 16:15:01 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F646E943
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:15:00 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b11so10208265wmb.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZVYBvIJFP8NheUH3YpNGwkgdULIT0OQ4e4uIjKd7CCY=;
 b=JQ1vJRk0gY44b2mqRYxejQv2q0yq407wd1FIQuSwTbFiXDP60+bNpD7bD8AzVJ9mdD
 ZxR22VNbRHABeVOcg1itz5iF6soWKME9x78ENKzzXkS7IVdyoYnZEfiUFYq39CEY2StC
 IaOPgmUxKUe2VliMsOQ7qdTLTP+YdZmr2jPTnR7I4mKQ0ifb2VkfyBAsgcJIwN3sJhVT
 sj8ObG/HobDKbKNpclFjlz4nv2Q5Ou4QdabMG17+9ynhPi8+rzZXH8vcpTXdcmB+3lbB
 381Wms68GUA/HmKhep17f31UoRzjxlwBWWS0ABUmEGuuFaPpe772rN9UBUQhYYB3xwh6
 1aUA==
X-Gm-Message-State: APjAAAUa5xzHLlBp8fT8pRZqq2qBr0sNgO5p2NPV+TFFsnLvRz96vd9p
 Ht0QGdnHsEhGQAyXdiSxd3w/vFK5TOZmsXARNQqRHJMV
X-Google-Smtp-Source: APXvYqzODFc/Pi9rjsSeY+zWPno0E75OS/MFPW1z30m0v29Nv5+nXRG1NlRZIq1zzb1f3wnd/oM5Jj+LUJ7t+UnNjfE=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr15252177wml.102.1573834498607; 
 Fri, 15 Nov 2019 08:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20191114164148.2304223-1-alexander.deucher@amd.com>
 <20191114164148.2304223-2-alexander.deucher@amd.com>
In-Reply-To: <20191114164148.2304223-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2019 11:14:46 -0500
Message-ID:
 <CADnq5_MKU5thSrH=wXBe8gQREWs0=7E_qeH6Q64QntoR1X=FUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=ZVYBvIJFP8NheUH3YpNGwkgdULIT0OQ4e4uIjKd7CCY=;
 b=HUpTsccwEg31I2ZQ3KEP/r9BtIkDDZplFDUywFCQ+W3hKmi9nuOc6RRB3yGKO0uQdk
 0cpZPfsqKBuN3xg/fldKEF8z5I+rVVJh4vohTuFESzQNzuXqdH6wtu8HiiMqyyaK0wmV
 7XEun9bIP8KoS10U8yPCMrlBDcNVwmpyLro1asgMXtEodWeZzhpF4rBQhTJHFo1+QQCK
 OrOyhzrIe9vsUCsqohfSczegB4bv0dIrjOuTwf5jnH6vZlrjOYVTsC6iZgyubKkBDVHI
 dZkNtvQ0M3i94gybEfPRfypWyUbUBaH19oDZ8lN1kcMa/eDIi8GnPK1cUWn3sPzw0tc5
 f+QA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115161446.fgHQWZnAtsHt7n_5ntf2FDaIgECgB9FROUx4l2L2V-A@z>

UGluZz8KCk9uIFRodSwgTm92IDE0LCAyMDE5IGF0IDExOjQyIEFNIEFsZXggRGV1Y2hlciA8YWxl
eGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPgo+IFdoZW4gZ2Z4b2ZmIGlzIGVuYWJsZWQsIGFj
Y2Vzc2luZyBnZnggcmVnaXN0ZXJzIHZpYSBNTUlPCj4gY2FuIGxlYWQgdG8gYSBoYW5nLgo+Cj4g
QnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTQ5Nwo+
IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
PiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgNiArKysr
Ky0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwo+IGluZGV4IDZkZGVhNzYwN2Fk
MC4uNWYzYjNhNzA1YjI5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9r
bXMuYwo+IEBAIC02NTksMTUgKzY1OSwxOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9pbmZvX2lvY3Rs
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+ICAgICAgICAgICAgICAgICBh
bGxvY19zaXplID0gaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50ICogc2l6ZW9mKCpyZWdzKTsKPgo+
IC0gICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50
OyBpKyspCj4gKyAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2Up
Owo+ICsgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaW5mby0+cmVhZF9tbXJfcmVnLmNv
dW50OyBpKyspIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYW1kZ3B1X2FzaWNfcmVh
ZF9yZWdpc3RlcihhZGV2LCBzZV9udW0sIHNoX251bSwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5yZWFkX21tcl9yZWcuZHdvcmRf
b2Zmc2V0ICsgaSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmcmVnc1tpXSkpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IERSTV9ERUJVR19LTVMoInVuYWxsb3dlZCBvZmZzZXQgJSN4XG4iLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5yZWFkX21tcl9yZWcuZHdvcmRf
b2Zmc2V0ICsgaSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShyZWdz
KTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwo
YWRldiwgdHJ1ZSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVG
QVVMVDsKPiAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIH0KPiAr
ICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsKPiAgICAgICAg
ICAgICAgICAgbiA9IGNvcHlfdG9fdXNlcihvdXQsIHJlZ3MsIG1pbihzaXplLCBhbGxvY19zaXpl
KSk7Cj4gICAgICAgICAgICAgICAgIGtmcmVlKHJlZ3MpOwo+ICAgICAgICAgICAgICAgICByZXR1
cm4gbiA/IC1FRkFVTFQgOiAwOwo+IC0tCj4gMi4yMy4wCj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
