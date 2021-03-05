Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D4EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3BA6502A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3BA6502A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD126EC26;
	Fri,  5 Mar 2021 19:24:25 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D766EC26
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 19:24:25 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id e17so693170oow.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=E7bYmmQnBtxuu0GSOMPrVtMrLCdHJZyjBI4C1rcrOdY=;
 b=oCciSgjxJNeAMPw8H3mNbPlO4SAEVbo22+tBG0BdxQ0TyHUQOla+izEdEamO2e5/cf
 mL/AfdyHNKsL+03dWNlN+rc6EUdXr74FmJ1T1Pgl3ehCJCHGBYB0eKHXE1p+MtW15ilT
 UFM5SfyB0RA1E4bl3E1TnfUIBMtZN42ynXmzcG3oMe0HOpH8ps0XYR6C9TYpIpv+Ox/9
 +aAwOEKPPx5QKmIWEsAQL8TW/pjOp2+8jBpi1uk/NMwrm/mPPsvMFVcUgtQfBXk2WsnG
 Tt7uLaOo2DuQrs8GvcPeTvlGyDWukSejdbNb9rDF7r9J7Kl2XemA0pl5uN27CUhsDGzj
 dYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E7bYmmQnBtxuu0GSOMPrVtMrLCdHJZyjBI4C1rcrOdY=;
 b=ph4mPECPoWkCdwiLf9TRlchDpxfx2Z22EooDV9iblKXcYqlZB2ZVPyaW5Yv7bCS/p2
 hR1VigCZaIXYm6L3pi5rXMGyB7b6YVEO+0nQ4lrgXSO2t7VS9taWPL+vmQyunVYX9zyL
 bERPtXEl6yZGVJczcmKRxXwStMN3FGlVQ0zlHmxJtJp0nUNtff8DaCirM3Ohgn93xi3e
 JP6ccWQMBX/zdx4Jj5vKaPgH7SSBqdGLFdOgEeKofX59FSNRNZcNgaNN+lWMZxK5rdCs
 l/8NdKZjxjADGO2vN7z+7E5XruMKf4K6UNzvA9kboLDMDRkkoGgF1wfYoz5+b5w5nwbM
 TT2Q==
X-Gm-Message-State: AOAM530PjKroE8WsRrAohzb/E3GWABgkWRLkxjU4DJ5RcIZcbe+wLx0N
 hbxkzc2n5cI03j8gpcyErDjtszcki1NX+xYv/zKxYUgU
X-Google-Smtp-Source: ABdhPJzFGYJSgC5BvyYNVMOrJv33UD4IHWLYeXSMH05YHdlSpZzMcU3b77eBbllMsVGaQFSC4TqPsmB/ghuaPqHrLxc=
X-Received: by 2002:a4a:d155:: with SMTP id o21mr8891552oor.72.1614972264280; 
 Fri, 05 Mar 2021 11:24:24 -0800 (PST)
MIME-Version: 1.0
References: <eac22f1b-ad84-ea5a-1c6e-ac55656f1be2@applied-asynchrony.com>
In-Reply-To: <eac22f1b-ad84-ea5a-1c6e-ac55656f1be2@applied-asynchrony.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Mar 2021 14:24:13 -0500
Message-ID: <CADnq5_M7-C1KUVH8K2tzmFirbCW4cQXUnQkVOcCtqLW-QHUwrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: use GFP_ATOMIC in
 dcn21_validate_bandwidth_fp()
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBNYXIgNSwgMjAyMSBhdCA5OjIzIEFNIEhvbGdlciBIb2Zmc3TDpHR0ZQo8aG9sZ2Vy
QGFwcGxpZWQtYXN5bmNocm9ueS5jb20+IHdyb3RlOgo+Cj4gQWZ0ZXIgZml4aW5nIG5lc3RlZCBG
UFUgY29udGV4dHMgY2F1c2VkIGJ5IDQxNDAxYWM2Nzc5MSB3ZSdyZSBzdGlsbCBzZWVpbmcKPiBj
b21wbGFpbnRzIGFib3V0IHNwdXJpb3VzIGtlcm5lbF9mcHVfZW5kKCkuIEFzIGl0IHR1cm5zIG91
dCB0aGlzIHdhcwo+IGFscmVhZHkgZml4ZWQgZm9yIGRjbjIwIGluIGNvbW1pdCBmNDFlZDg4Y2Jk
ICgiZHJtL2FtZGdwdS9kaXNwbGF5Ogo+IHVzZSBHRlBfQVRPTUlDIGluIGRjbjIwX3ZhbGlkYXRl
X2JhbmR3aWR0aF9pbnRlcm5hbCIpIGJ1dCBuZXZlciBtb3ZlZAo+IGZvcndhcmQgdG8gZGNuMjEu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBIb2xnZXIgSG9mZnN0w6R0dGUgPGhvbGdlckBhcHBsaWVkLWFz
eW5jaHJvbnkuY29tPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyB8IDIgKy0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNl
LmMKPiBpbmRleCAwNzJmOGM4ODA5MjQuLjFhY2FkZjlmNTYxOSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jCj4g
QEAgLTEzMzksNyArMTMzOSw3IEBAIHN0YXRpYyBub2lubGluZSBib29sIGRjbjIxX3ZhbGlkYXRl
X2JhbmR3aWR0aF9mcChzdHJ1Y3QgZGMgKmRjLAo+ICAgICAgICAgaW50IHZsZXZlbCA9IDA7Cj4g
ICAgICAgICBpbnQgcGlwZV9zcGxpdF9mcm9tW01BWF9QSVBFU107Cj4gICAgICAgICBpbnQgcGlw
ZV9jbnQgPSAwOwo+IC0gICAgICAgZGlzcGxheV9lMmVfcGlwZV9wYXJhbXNfc3QgKnBpcGVzID0g
a3phbGxvYyhkYy0+cmVzX3Bvb2wtPnBpcGVfY291bnQgKiBzaXplb2YoZGlzcGxheV9lMmVfcGlw
ZV9wYXJhbXNfc3QpLCBHRlBfS0VSTkVMKTsKPiArICAgICAgIGRpc3BsYXlfZTJlX3BpcGVfcGFy
YW1zX3N0ICpwaXBlcyA9IGt6YWxsb2MoZGMtPnJlc19wb29sLT5waXBlX2NvdW50ICogc2l6ZW9m
KGRpc3BsYXlfZTJlX3BpcGVfcGFyYW1zX3N0KSwgR0ZQX0FUT01JQyk7Cj4gICAgICAgICBEQ19M
T0dHRVJfSU5JVChkYy0+Y3R4LT5sb2dnZXIpOwo+Cj4gICAgICAgICBCV19WQUxfVFJBQ0VfQ09V
TlQoKTsKPiAtLQo+IDIuMzAuMQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
