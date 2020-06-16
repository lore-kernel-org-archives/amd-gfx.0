Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0CBC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 00:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F01A20768
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 00:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdR/peAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F01A20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788D989BC2;
	Tue, 16 Jun 2020 00:50:48 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A8A89BC2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 00:50:46 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id c12so10676329lfc.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dzcxewUesQIaJXhjrgJDCuOwv2Ejo5xKdiKtqVcXOfQ=;
 b=JdR/peAsz5XGnghTc4agGoPeC2q0WBh0tvngZuvhIBkofrdMs/daNSzgOnLgEo9KE3
 4qHB+25Ou7QW/s+pw7G0Gr44q4cwwembbMI/T/XKEg+CVFZK268Q1InH5dj+rHyKCJmN
 3msemdp7/HYnuKZO5sLjnyR4W5udzXLzIqxlG1SWOCjq2aqcplY2iYDffkGWkmi5Kjn2
 zcD97Cq/ARMCR6biXN8Gz8kOD0iIAgAn8PyqWlqpMe771f3s+VMVXhKmsCuYtf2yg0sY
 WMw4OhqZE5kv8ijC5MwFaHJSe1E4UNZY+c6FQ6k10UZ78miPFam0Zj68gJuv9IGZNgGe
 uW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dzcxewUesQIaJXhjrgJDCuOwv2Ejo5xKdiKtqVcXOfQ=;
 b=if9hvRwbuQi/p3u+pqYw6JTxDGMF3Czdk1+TEqEGCvZI7TwDg9HDZX9jeysUr9b3zG
 g50qJpUHFh2UO+DsV0Yu+2rzZM6JZ6yKduvU5akwAws6M7do/D1mcSP5RafJLe/l4cZD
 tbjkErI+kTx38eOdpwLNnpvWnD3LqZlNYmRtQ516zVCqB5IciYMZwJOUC+vUnkf+i/EA
 GRUFXeyyjkP0HnFeZjpH98yvv6gr2SD15HCv2wRVu/8G27+f+mwFr47OBNF5pppyem27
 J66Ldio3z61xo8Q60F0hbB0fTG5RMEo1ElZ7qxJtRWk0fywsl3s3a71LHeoGdiT+MiLh
 aq6A==
X-Gm-Message-State: AOAM532AD+q31IByAxH8WPvMdaMadfMoyRZStHzwPx7ZEewIl/uNdSDr
 54ZxvOJ0aMBibuSSmnbw8Mh/4gIBTy5AFQem5m0=
X-Google-Smtp-Source: ABdhPJzZ0deM4Hu2gZNnuuCoP27lJFOuV7Y+mmFG5V+x4J+qK6TM+FEZdQ1TPcSJ7QdVVei+l86ModhLOSIWYF4Y19s=
X-Received: by 2002:a19:c8a:: with SMTP id 132mr298008lfm.23.1592268645339;
 Mon, 15 Jun 2020 17:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpQs4L6=Fh8XEoz0K7t1rd34ZRXhW--NPp_CWa7fNoo+CKGUA@mail.gmail.com>
 <CADnq5_OCOmKSSid8nV8tPJTkY-CQXSkiYxGx5xoRkDj0G06QxQ@mail.gmail.com>
In-Reply-To: <CADnq5_OCOmKSSid8nV8tPJTkY-CQXSkiYxGx5xoRkDj0G06QxQ@mail.gmail.com>
From: Aaron Chou <zhoubb.aaron@gmail.com>
Date: Tue, 16 Jun 2020 08:50:24 +0800
Message-ID: <CAMpQs4+4O9aDb4CDaxwfSc8qA9gpRHAMjAEyESAHv+ALyzNU4g@mail.gmail.com>
Subject: Re: The inherent defect of the AMDGPU driver about hotplug
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVzLCBJIGFncmVlLgoKT24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgMzowOCBBTSBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1biAxNSwgMjAy
MCBhdCA1OjMwIEFNIEFhcm9uIENob3UgPHpob3ViYi5hYXJvbkBnbWFpbC5jb20+IHdyb3RlOgo+
ID4KPiA+IEFib3V0IG9uZSBtb250aCBhZ28sIEkgaGF2ZSBhc2tlZCBhIHF1ZXN0aW9uIGFib3V0
IEhETUkgaG90cGx1ZywgdGhlIGxpbmsgaXM6Cj4gPgo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTEzNSNub3RlXzQ5MjQ2MAo+ID4KPiA+IEFuZCBJ
IGhhdmUgcHV0IG9uZSBwYXRjaCB0byBmaXggdGhpcywgYXMgZm9sbG93czoKPiA+Cj4gPiAgMzkg
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3Jz
LmMKPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwo+
ID4gIDQwIGluZGV4IGYzNTVkOWE3NTJkMi4uZWU2NTdkYjlhMjI4IDEwMDY0NAo+ID4gIDQxIC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPiA+ICA0
MiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jCj4g
PiAgNDMgQEAgLTk3Myw3ICs5NzMsNyBAQCBhbWRncHVfY29ubmVjdG9yX2R2aV9kZXRlY3Qoc3Ry
dWN0Cj4gPiBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsIGJvb2wgZm9yY2UpCj4gPiAgNDQgICAg
ICAgICBjb25zdCBzdHJ1Y3QgZHJtX2VuY29kZXJfaGVscGVyX2Z1bmNzICplbmNvZGVyX2Z1bmNz
Owo+ID4gIDQ1ICAgICAgICAgaW50IHI7Cj4gPiAgNDYgICAgICAgICBlbnVtIGRybV9jb25uZWN0
b3Jfc3RhdHVzIHJldCA9Cj4gPiBjb25uZWN0b3Jfc3RhdHVzX2Rpc2Nvbm5lY3RlZDsKPiA+ICA0
NyAtICAgICAgIGJvb2wgZHJldCA9IGZhbHNlLCBicm9rZW5fZWRpZCA9IGZhbHNlOwo+ID4gIDQ4
ICsgICAgICAgYm9vbCBkcmV0ID0gZmFsc2UsIGJyb2tlbl9lZGlkID0gZmFsc2UsIHVuZGVmaW5l
ZF9mbGFnID0KPiA+IGZhbHNlOwo+ID4gIDQ5Cj4gPiAgNTAgICAgICAgICBpZiAoIWRybV9rbXNf
aGVscGVyX2lzX3BvbGxfd29ya2VyKCkpIHsKPiA+ICA1MSAgICAgICAgICAgICAgICAgciA9IHBt
X3J1bnRpbWVfZ2V0X3N5bmMoY29ubmVjdG9yLT5kZXYtPmRldik7Cj4gPiAgNTIgQEAgLTk4OCw3
ICs5ODgsMTIgQEAgYW1kZ3B1X2Nvbm5lY3Rvcl9kdmlfZGV0ZWN0KHN0cnVjdAo+ID4gZHJtX2Nv
bm5lY3RvciAqY29ubmVjdG9yLCBib29sIGZvcmNlKQo+ID4gIDUzCj4gPiAgNTQgICAgICAgICBp
ZiAoYW1kZ3B1X2Nvbm5lY3Rvci0+ZGRjX2J1cykKPiA+ICA1NSAgICAgICAgICAgICAgICAgZHJl
dCA9IGFtZGdwdV9kaXNwbGF5X2RkY19wcm9iZShhbWRncHVfY29ubmVjdG9yLAo+ID4gZmFsc2Up
Owo+ID4gIDU2IC0gICAgICAgaWYgKGRyZXQpIHsKPiA+ICA1NyArCj4gPiAgNTggKyAgICAgICAv
KiBDaGVjayB0aGUgSERNSSBIUEQgcGluIHN0YXR1cyBhZ2FpbiAqLwo+ID4gIDU5ICsgICAgICAg
aWYgKCFhbWRncHVfZGlzcGxheV9ocGRfc2Vuc2UoYWRldiwKPiA+IGFtZGdwdV9jb25uZWN0b3It
PmhwZC5ocGQpKQo+ID4gIDYwICsgICAgICAgICAgICAgICB1bmRlZmluZWRfZmxhZyA9IHRydWU7
Cj4gPiAgNjEgKwo+ID4gIDYyICsgICAgICAgaWYgKGRyZXQgJiYgIXVuZGVmaW5lZF9mbGFnKSB7
Cj4gPiAgNjMgICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3ItPmRldGVjdGVkX2J5X2xv
YWQgPSBmYWxzZTsKPiA+ICA2NCAgICAgICAgICAgICAgICAgYW1kZ3B1X2Nvbm5lY3Rvcl9mcmVl
X2VkaWQoY29ubmVjdG9yKTsKPiA+ICA2NSAgICAgICAgICAgICAgICAgYW1kZ3B1X2Nvbm5lY3Rv
cl9nZXRfZWRpZChjb25uZWN0b3IpOwo+ID4KPiA+IE1heWJlIHRoZSBmaXggaXMgc2xvcHB5LCBz
byBJIHdyaXRlIHRoZSBhbm90aGVyIHBhdGNoOgo+ID4KPiA+ICAxNiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jCj4gPiAgMTcgaW5kZXggYzc3
MGQ3MzM1MmE3Li5iYjU5ZWJjOWE2YzggMTAwNjQ0Cj4gPiAgMTggLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYwo+ID4gIDE5ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPiA+ICAyMCBAQCAtOTkxLDYg
Kzk5MSw3IEBAIGFtZGdwdV9jb25uZWN0b3JfZHZpX2RldGVjdChzdHJ1Y3QKPiA+IGRybV9jb25u
ZWN0b3IgKmNvbm5lY3RvciwgYm9vbCBmb3JjZSkKPiA+ICAyMSAgICAgICAgIGlmIChhbWRncHVf
Y29ubmVjdG9yLT5kZGNfYnVzKQo+ID4gIDIyICAgICAgICAgICAgICAgICBkcmV0ID0gYW1kZ3B1
X2Rpc3BsYXlfZGRjX3Byb2JlKGFtZGdwdV9jb25uZWN0b3IsCj4gPiBmYWxzZSk7Cj4gPiAgMjMg
ICAgICAgICBpZiAoZHJldCkgewo+ID4gIDI0ICsgICAgICAgICAgICAgICBzY2hlZHVsZV93b3Jr
KCZhZGV2LT5ob3RwbHVnX3dvcmspOwo+ID4gIDI1ICAgICAgICAgICAgICAgICBhbWRncHVfY29u
bmVjdG9yLT5kZXRlY3RlZF9ieV9sb2FkID0gZmFsc2U7Cj4gPiAgMjYgICAgICAgICAgICAgICAg
IGFtZGdwdV9jb25uZWN0b3JfZnJlZV9lZGlkKGNvbm5lY3Rvcik7Cj4gPiAgMjcgICAgICAgICAg
ICAgICAgIGFtZGdwdV9jb25uZWN0b3JfZ2V0X2VkaWQoY29ubmVjdG9yKTsKPiA+Cj4gPiBXaGlj
aCBpcyBiZXR0ZXIsIG9yIG5laXRoZXLvvJ8KPgo+IEFzIHBlciB0aGUgbGFzdCBkaXNjdXNzaW9u
Ogo+Cj4gIlRoaXMgaXMgdGhlIHBhcnQgSSBkb24ndCB1bmRlcnN0YW5kLiAgVGhlIGxvZ2ljIGFs
cmVhZHkgY2hlY2tzIHRoZSBIUEQKPiBzdGF0dXMgaW4gYW1kZ3B1X2Nvbm5lY3Rvcl9jaGVja19o
cGRfc3RhdHVzX3VuY2hhbmdlZCgpLiAgRG9lcyBpdAo+IHN0aWxsIHJlcG9ydCBjb25uZWN0ZWQg
YXQgdGhhdCBwb2ludD8gIEFmdGVyIHRoYXQgaXQgdHJpZXMgdG8gcmVhZCB0aGUKPiBFRElEIGlu
IGFtZGdwdV9kaXNwbGF5X2RkY19wcm9iZSgpLiAgSWYgdGhlIG1vbml0b3IgaXMgZGlzY29ubmVj
dGVkLAo+IHRoZXJlIHNob3VsZCBiZSBubyBFRElEIHNvIGRyZXQgc2hvdWxkIGJlIGZhbHNlLiAg
V2Ugc2hvdWxkIHRyeSBhbmQKPiBmaWd1cmUgb3V0IHdoeSB0aGUgZmlyc3QgSFBEIGNoZWNrIHJl
cG9ydHMgY29ubmVjdGVkIGFuZCB0aGUgRURJRAo+IHByb2JlIHJldHVybnMgdHJ1ZS4iCj4KPiBU
aGVyZSBpcyBhbHJlYWR5IGFuIEhQRCBwcm9iZSBpbiB0aGUgY3VycmVudCBsb2dpYy4gIFdlIHNo
b3VsZCB0cnkgYW5kCj4gdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCBhIHNlY29uZCBvbmUgcmF0aGVy
IHRoYW4ganVzdCBhZGRpbmcgb25lLiAgRG9lcwo+IGEgZGVsYXkgYXQgdGhlIHRvcCBvZiB0aGF0
IGZ1bmN0aW9uIGhlbHA/Cj4KPiBBbGV4Cj4KPiA+Cj4gPiAtLQo+ID4gUmVnYXJkcywKPiA+IEFh
cm9uCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
