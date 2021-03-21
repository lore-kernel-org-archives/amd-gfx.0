Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42557C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78CF619A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78CF619A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5E389EB8;
	Mon, 22 Mar 2021 08:20:09 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1526E214;
 Sun, 21 Mar 2021 15:20:49 +0000 (UTC)
Received: by mail-il1-x12f.google.com with SMTP id t14so2713852ilu.3;
 Sun, 21 Mar 2021 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4iveq/InwG0NxRodieZpwalqg0AiIbR/FGTza27sje0=;
 b=U5pUfTYFylM3ZfFzbk0ZGABNL3nP+UgnVGq/byUUlCFZo7j7h0yPanbrEAq6quQGiG
 7OaOgxoXU8zhuqKqZjyeWlbBD6TCS8f9iXd+VHGktbLb9n5S6hWXGMHTEHyNykfaBSre
 w0p1YtHFefHX+EY1vxfWR3uQTMiE5NEEp2QAhoCVsuNBq88VLJ8Vb57+cmwkJwAviSG2
 yk/wRhQpbrO+8pM5exPiolJW9dHyY31uz5uk4jLcWWg8xdy0bCJ+PlYEqdRyskVmjC7r
 PclTC2AD7nlVCINnHDspHGSXkJ3Iaq1Z4NRGXJJ9FZzJevC1hEgI6+IzE0X1HZNdMqGo
 L/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4iveq/InwG0NxRodieZpwalqg0AiIbR/FGTza27sje0=;
 b=gFahHgcFSJUt63wH9kNP9yiwdbTJamK3Teygk4WAE3y+SwWuApjrqxJj6esvRGry8O
 SRWT9j9dtBEDD5cZfPCAh8rCXpisXRt9pKrzN7uznT8KhU2PjQXD4SQfVbzX7SprW1zx
 52xGSmFCSIudR1jTX1bpApqQ/TOiUumr9pKe+h3211eTjNaOAJIBSFPEncvnRCKWPiWT
 jfe+PjsqW/SDjdH6Zkv7IZ3kqlYKW0xkKBIu4Zn7ovMHtOFs6S9x0ftWQb//rQG0sUyq
 q3OkKkwIJGVMFGF5Ee1rlGaiJbf0zOB3VOZsgRvsQbyMilhgDQjt3iDEp6gTdKWLc743
 Kjmg==
X-Gm-Message-State: AOAM532YBroogg+g4/x7zcuacaO7sPytudvsgNqyHymYtNmu2GL6J+OQ
 Cp6QSI5mNJYJms4bszwIYo5ikl0LbkXCcSkRjBk=
X-Google-Smtp-Source: ABdhPJzNj2lIIaszPhO1R9rGn2EO3uB5F5zPoFTWKCNBbA73YHQJnZTdQQDlsiNAFSl0Vf5IHu+KM0O8tz7YuKKudHk=
X-Received: by 2002:a05:6e02:2:: with SMTP id h2mr8729495ilr.81.1616340049181; 
 Sun, 21 Mar 2021 08:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210320201052.114775-1-ztong0001@gmail.com>
 <d50c08e5-51d7-148c-464f-7699e6f6a115@amd.com>
In-Reply-To: <d50c08e5-51d7-148c-464f-7699e6f6a115@amd.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Sun, 21 Mar 2021 11:20:38 -0400
Message-ID: <CAA5qM4DCN1PQqyWxH3o27ixAkbWHf3so12Ba7=9gxUpdk2wkGA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: don't evict if not initialized
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Mon, 22 Mar 2021 08:19:58 +0000
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzLApGaXhlZCBhcyBzdWdnZXN0ZWQgYW5kIHNlbnQgYXMgdjIuCi0gVG9uZwoKT24gU3Vu
LCBNYXIgMjEsIDIwMjEgYXQgOToyNiBBTSBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4KPgo+IEFtIDIwLjAzLjIxIHVtIDIxOjEwIHNjaHJpZWIg
VG9uZyBaaGFuZzoKPiA+IFRUTV9QTF9WUkFNIG1heSBub3QgaW5pdGlhbGl6ZWQgYXQgYWxsIHdo
ZW4gY2FsbGluZwo+ID4gcmFkZW9uX2JvX2V2aWN0X3ZyYW0oKS4gV2UgbmVlZCB0byBjaGVjayBi
ZWZvcmUgZG9pbmcgZXZpY3Rpb24uCj4gPgo+ID4gWyAgICAyLjE2MDgzN10gQlVHOiBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDIwCj4gPiBb
ICAgIDIuMTYxMjEyXSAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUK
PiA+IFsgICAgMi4xNjE0OTBdICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQg
cGFnZQo+ID4gWyAgICAyLjE2MTc2N10gUEdEIDAgUDREIDAKPiA+IFsgICAgMi4xNjMwODhdIFJJ
UDogMDAxMDp0dG1fcmVzb3VyY2VfbWFuYWdlcl9ldmljdF9hbGwrMHg3MC8weDFjMCBbdHRtXQo+
ID4gWyAgICAyLjE2ODUwNl0gQ2FsbCBUcmFjZToKPiA+IFsgICAgMi4xNjg2NDFdICByYWRlb25f
Ym9fZXZpY3RfdnJhbSsweDFjLzB4MjAgW3JhZGVvbl0KPiA+IFsgICAgMi4xNjg5MzZdICByYWRl
b25fZGV2aWNlX2ZpbmkrMHgyOC8weGY5IFtyYWRlb25dCj4gPiBbICAgIDIuMTY5MjI0XSAgcmFk
ZW9uX2RyaXZlcl91bmxvYWRfa21zKzB4NDQvMHhhMCBbcmFkZW9uXQo+ID4gWyAgICAyLjE2OTUz
NF0gIHJhZGVvbl9kcml2ZXJfbG9hZF9rbXMrMHgxNzQvMHgyMTAgW3JhZGVvbl0KPiA+IFsgICAg
Mi4xNjk4NDNdICBkcm1fZGV2X3JlZ2lzdGVyKzB4ZDkvMHgxYzAgW2RybV0KPiA+IFsgICAgMi4x
NzAxMDRdICByYWRlb25fcGNpX3Byb2JlKzB4MTE3LzB4MWEwIFtyYWRlb25dCj4gPgo+ID4gU2ln
bmVkLW9mZi1ieTogVG9uZyBaaGFuZyA8enRvbmcwMDAxQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4g
ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYyB8IDQgKysrLQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMKPiA+IGluZGV4IDliODE3ODY3ODJkZS4u
MDRlOWE4MTE4YjBlIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fb2JqZWN0LmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVj
dC5jCj4gPiBAQCAtMzg0LDcgKzM4NCw5IEBAIGludCByYWRlb25fYm9fZXZpY3RfdnJhbShzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldikKPiA+ICAgICAgIH0KPiA+ICAgI2VuZGlmCj4gPiAgICAg
ICBtYW4gPSB0dG1fbWFuYWdlcl90eXBlKGJkZXYsIFRUTV9QTF9WUkFNKTsKPiA+IC0gICAgIHJl
dHVybiB0dG1fcmVzb3VyY2VfbWFuYWdlcl9ldmljdF9hbGwoYmRldiwgbWFuKTsKPiA+ICsgICAg
IGlmIChtYW4pCj4gPiArICAgICAgICAgICAgIHJldHVybiB0dG1fcmVzb3VyY2VfbWFuYWdlcl9l
dmljdF9hbGwoYmRldiwgbWFuKTsKPiA+ICsgICAgIHJldHVybiAwOwo+Cj4gWW91IHNob3VsZCBw
cm9iYWJseSBjb2RlIHRoaXMgdGhlIG90aGVyIHdheSBhcm91bmQsIGUuZy4KPgo+IElmICghbWFu
KQo+ICAgICAgcmV0dXJuIDA7Cj4gLi4uCj4KPiBBcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0
byBtZS4KPgo+IENocmlzdGlhbi4KPgo+ID4gICB9Cj4gPgo+ID4gICB2b2lkIHJhZGVvbl9ib19m
b3JjZV9kZWxldGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
