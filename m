Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14428C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 15:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA5461A13
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 15:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA5461A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8066A6F406;
	Fri, 26 Mar 2021 15:03:20 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513216F406
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 15:03:19 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a7so8910558ejs.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=JfZ8lU08jgjrBdB+hZIupT49KDbZaCfq1JwHNuONFTE=;
 b=IdRYEm8O/a4NWf7Tp3hlTSU8keCLeRhhrdiY/vfZpIynD3mHPCUL5xSBhkF/hX6vkL
 DepEFlu3aXd1Y5Fw5nokpm+SqRUczbfj2KEZ30S24BaDKA3gTdWhv/ZDcSQHOes1nyaL
 aH3SSFu7szZGHdrNdiYxps0WRnyzlRXj13TQY0Mo/tJQQHS3sQTo4q7FZibzGWo9QAdP
 ZdaLIJTfhlLX8nyUFBNfDllwhfjonHO10/A8h6NkHOwwYEAcVnDUrFAVM8LFGQhjgM8B
 0FM13lmcRVQzM2bLkUSZdRZgM6jjuF4aZAnJlgCPgEafKgXsWb3mdDr2z6SgMC/0BZjU
 fhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JfZ8lU08jgjrBdB+hZIupT49KDbZaCfq1JwHNuONFTE=;
 b=Yp8t8FBNQc4z3o1oou8USkJbDI6lC0ASP0yrY/Ip8o2Ix5NHlRP1M9Z54LeJ+Ba447
 8G6BlOPFKL6t052PLcQeqBy96CG0GohG15h/hHpq45xAGqwRTdaXWb0FhJidNdd+zFir
 9xfgai+j/hYL5zqxskvIA7TBe2UNRaTYZI4lK3uM+yFeONBvzF5pzLfb3QQXXX09x8Eh
 QmborY4emp0qyu1zPvCNP70lFneZkhLWgtjlW3tHovhfmeF322dJiVZDHhoylkGG/vky
 fglRJSES9ua2tKDYrDC3rI7ZlfStuqQGavJnXcB8PP/usbpH9oIf851Yxa0QQntas47p
 0JWQ==
X-Gm-Message-State: AOAM5311YnteB6p74OCMLiIjzP3SPnLFJUWX0jxEQ6C3thLZz5n1MEHX
 46vogP7dfooJsIgfREDyH777yFQe2JU=
X-Google-Smtp-Source: ABdhPJwFJsNLRZuEK34M5D/3sjBCKxie32sIS8yZrq9n5SEQm8DyEdVEppiGWoqtfGk6B2mffkOeZg==
X-Received: by 2002:a17:906:18a1:: with SMTP id
 c1mr15200527ejf.62.1616770998017; 
 Fri, 26 Mar 2021 08:03:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:77f2:59e3:2172:d342?
 ([2a02:908:1252:fb60:77f2:59e3:2172:d342])
 by smtp.gmail.com with ESMTPSA id cb17sm4357353edb.10.2021.03.26.08.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 08:03:17 -0700 (PDT)
Subject: Re: Need to support mixed memory mappings with HMM
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
 <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
 <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
 <94b1e462-eff6-77f3-f0c4-1ae99f02a178@amd.com>
 <7c4be3bd-8d73-bd8d-3eed-9ddc68a9c364@amd.com>
 <6bfefd19-ca3f-72d4-6d29-34f2f4885aab@amd.com>
 <1ce7475f-f52e-e44c-d9b4-3ba1a7b2f0a7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <336988b6-7931-ba45-2bb3-f8cffeec66f7@gmail.com>
Date: Fri, 26 Mar 2021 16:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1ce7475f-f52e-e44c-d9b4-3ba1a7b2f0a7@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjYuMDMuMjEgdW0gMTU6NDkgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTAz
LTI2IHVtIDQ6NTAgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+Cj4+IEFtIDI1LjAz
LjIxIHVtIDE3OjI4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBBbSAyMDIxLTAzLTI1IHVt
IDEyOjIyIHAubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+Pj4+Pj4gTXkgaWRlYSBp
cyB0byBjaGFuZ2UgdGhlIGFtZGdwdV92bV91cGRhdGVfbWFwcGluZyBpbnRlcmZhY2UgdG8gdXNl
Cj4+Pj4+Pj4+PiBzb21lCj4+Pj4+Pj4+PiBoaWdoLWJpdCBpbiB0aGUgcGFnZXNfYWRkciBhcnJh
eSB0byBpbmRpY2F0ZSB0aGUgcGFnZSB0eXBlLiBGb3IKPj4+Pj4+Pj4+IHRoZQo+Pj4+Pj4+Pj4g
ZGVmYXVsdCBwYWdlIHR5cGUgKDApIG5vdGhpbmcgcmVhbGx5IGNoYW5nZXMgZm9yIHRoZSBjYWxs
ZXJzLiBUaGUKPj4+Pj4+Pj4+ICJmbGFncyIgcGFyYW1ldGVyIG5lZWRzIHRvIGJlY29tZSBhIHBv
aW50ZXIgdG8gYW4gYXJyYXkgdGhhdCBnZXRzCj4+Pj4+Pj4+PiBpbmRleGVkIGJ5IHRoZSBoaWdo
IGJpdHMgZnJvbSB0aGUgcGFnZXNfYWRkciBhcnJheS4gRm9yIGV4aXN0aW5nCj4+Pj4+Pj4+PiBj
YWxsZXJzCj4+Pj4+Pj4+PiBpdCdzIGFzIGVhc3kgYXMgY2hhbmdpbmcgZmxhZ3MgdG8gJmZsYWdz
IChhcnJheSBvZiBzaXplIDEpLiBGb3IKPj4+Pj4+Pj4+IEhNTSB3ZQo+Pj4+Pj4+Pj4gd291bGQg
cGFzcyBhIHBvaW50ZXIgdG8gYSByZWFsIGFycmF5Lgo+Pj4+Pj4+PiBZZWFoLCBJJ3ZlIHRob3Vn
aHQgYWJvdXQgc3R1ZmYgbGlrZSB0aGF0IGFzIHdlbGwgZm9yIGEgd2hpbGUuCj4+Pj4+Pj4+Cj4+
Pj4+Pj4+IFByb2JsZW0gaXMgdGhhdCB0aGlzIHdvbid0IHdvcmsgdGhhdCBlYXNpbHkuIFdlIGFz
c3VtZSBhdCBtYW55Cj4+Pj4+Pj4+IHBsYWNlcwo+Pj4+Pj4+PiB0aGF0IHRoZSBmbGFncyBkb2Vz
bid0IGNoYW5nZSBmb3IgdGhlIHJhbmdlIGluIHF1ZXN0aW9uLgo+Pj4+Pj4+IEkgdGhpbmsgc29t
ZSBsb3dlciBsZXZlbCBmdW5jdGlvbnMgYXNzdW1lIHRoYXQgdGhlIGZsYWdzIHN0YXkgdGhlCj4+
Pj4+Pj4gc2FtZQo+Pj4+Pj4+IGZvciBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgcmFuZ2VzLiBCdXQg
aWYgeW91IHVzZSB0aGUgaGlnaC1iaXRzIHRvCj4+Pj4+Pj4gZW5jb2RlCj4+Pj4+Pj4gdGhlIHBh
Z2UgdHlwZSwgdGhlIHJhbmdlcyB3b24ndCBiZSBjb250aWd1b3VzIGFueSBtb3JlLiBTbyB5b3Ug
Y2FuCj4+Pj4+Pj4gY2hhbmdlIHBhZ2UgZmxhZ3MgZm9yIGRpZmZlcmVudCBjb250aWd1b3VzIHJh
bmdlcy4KPj4+Pj4+IFllYWgsIGJ1dCB0aGVuIHlvdSBhbHNvIGdldCBhYnNvbHV0ZWx5IHplcm8g
VEhQIGFuZCBmcmFnbWVudCBmbGFncwo+Pj4+Pj4gc3VwcG9ydC4KPj4+Pj4gQXMgbG9uZyBhcyB5
b3UgaGF2ZSBhIGNvbnRpZ3VvdXMgMk1CIHBhZ2Ugd2l0aCB0aGUgc2FtZSBwYWdlIHR5cGUsIEkK
Pj4+Pj4gdGhpbmsgeW91IGNhbiBzdGlsbCBnZXQgYSBUSFAgbWFwcGluZyBpbiB0aGUgR1BVIHBh
Z2UgdGFibGUuIEJ1dCBpZgo+Pj4+PiBvbmUKPj4+Pj4gcGFnZSBpbiB0aGUgbWlkZGxlIG9mIGEg
Mk1CIHBhZ2UgaGFzIGEgZGlmZmVyZW50IHBhZ2UgdHlwZSwgdGhhdCB3aWxsCj4+Pj4+IGJyZWFr
IHRoZSBUSFAgbWFwcGluZywgYXMgaXQgc2hvdWxkLgo+Pj4+IFllYWgsIGJ1dCBjdXJyZW50bHkg
d2UgZGV0ZWN0IHRoYXQgYmVmb3JlIHdlIGNhbGwgZG93biBpbnRvIHRoZQo+Pj4+IGZ1bmN0aW9u
cyB0byB1cGRhdGUgdGhlIHRhYmxlcy4KPj4+Pgo+Pj4+IFdoZW4geW91IGdpdmUgYSBtaXhlZCBs
aXN0IHRoZSBjaGFuY2UgZm9yIHRoYXQgaXMganVzdCBjb21wbGV0ZWx5IGdvbmUuCj4+PiBDdXJy
ZW50bHkgdGhlIGRldGVjdGlvbiBvZiBjb250aWd1b3VzIHJhbmdlcyBpcyBpbgo+Pj4gYW1kZ3B1
X3ZtX3VwZGF0ZV9tYXBwaW5nOgo+Pj4KPj4+PiBpZiAobnVtX2VudHJpZXMgPiBBTURHUFVfR1BV
X1BBR0VTX0lOX0NQVV9QQUdFKSB7IHVpbnQ2NF90IHBmbiA9Cj4+Pj4gY3Vyc29yLnN0YXJ0ID4+
IFBBR0VfU0hJRlQ7IHVpbnQ2NF90IGNvdW50OyBjb250aWd1b3VzID0KPj4+PiBwYWdlc19hZGRy
W3BmbiArIDFdID09IHBhZ2VzX2FkZHJbcGZuXSArIFBBR0VfU0laRTsgdG1wID0gbnVtX2VudHJp
ZXMKPj4+PiAvIEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7IGZvciAoY291bnQgPSAyOyBj
b3VudCA8IHRtcDsgKytjb3VudCkKPj4+PiB7IHVpbnQ2NF90IGlkeCA9IHBmbiArIGNvdW50OyBp
ZiAoY29udGlndW91cyAhPSAocGFnZXNfYWRkcltpZHhdID09Cj4+Pj4gcGFnZXNfYWRkcltpZHgg
LSAxXSArIFBBR0VfU0laRSkpIGJyZWFrOyB9IG51bV9lbnRyaWVzID0gY291bnQgKgo+Pj4+IEFN
REdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7IH0KPj4+IElmIGEgcGFnZSB0eXBlIGNoYW5nZXMg
ZnJvbSBvbmUgcGFnZSB0byB0aGUgbmV4dCwgaXQgd2lsbCBlbmQgYQo+Pj4gY29udGlndW91cyBy
YW5nZSBhbmQgY2FsbCBpbnRvIHRoZSBsb3dlciBsZXZlbCAoYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVz
KS4KPj4+IEkgZG9uJ3QgdGhpbmsgYW55dGhpbmcgbmVlZHMgdG8gY2hhbmdlIGluIGFtZGdwdV92
bV91cGRhdGVfcHRlcywgYmVjYXVzZQo+Pj4gYWxsIHBhZ2VzIGNvbnRpZ3VvdXMgcGFzc2VkIHRv
IGl0IHVzZSB0aGUgc2FtZSBwYWdlIHR5cGUsIHNvIHRoZSBzYW1lCj4+PiBmbGFncy4gQW5kIHRo
ZSBleGlzdGluZyBjb2RlIGluIGFtZGdwdV92bV91cGRhdGVfbWFwcGluZyBhbHJlYWR5IGRvZXMK
Pj4+IHRoZSByaWdodCB0aGluZy4gSSBob25lc3RseSBkb24ndCBzZWUgdGhlIHByb2JsZW0uCj4+
IEJ1dCB0aGVuIHlvdSBjb3VsZCBhbHNvIGp1c3QgY2FsbCBhbWRncHVfdm1fdXBkYXRlX21hcHBp
bmcoKSBtdWx0aXBsZQo+PiB0aW1lcyBmZWVkaW5nIGl0IGZyb20gd2hhdGV2ZXIgZGF0YSBzdHJ1
Y3R1cmUgeW91IHVzZSBpbiB0aGUgSE1NIGNvZGUuCj4+Cj4+IFVzaW5nIHRoZSBwYWdlIGFycmF5
IHNvdW5kcyBsaWtlIGFuIGludGVybWVkaWF0ZSBkYXRhIHN0cnVjdHVyZSB0byBtZQo+PiB5b3Ug
b25seSBjcmVhdGVkIHRvIGZlZWQgaW50byBhbWRncHVfdm1fdXBkYXRlX21hcHBpbmcoKS4KPiBZ
b3UncmUgcmlnaHQuIEl0IGNvdWxkIGJlIGRvbmUuIE9uZSBuZXcgY2FsbCB0byBhbWRncHVfdm1f
dXBkYXRlX21hcHBpbmcKPiBldmVyeSB0aW1lIHRoZSBmbGFncyBjaGFuZ2UgYXMgd2UgaXRlcmF0
ZSBvdmVyIHZpcnR1YWwgYWRkcmVzc2VzLiBJdAo+IHNob3VsZCB3b3JrIE9LIGFzIGxvbmcgYXMg
dGhlIG1hcHBpbmdzIG9mIGRpZmZlcmVudCBtZW1vcnkgdHlwZXMgYXJlbid0Cj4gdG9vIGZpbmVs
eSBpbnRlcmxlYXZlZC4KCkkgc3VnZ2VzdCB0aGF0IHdlIHN0aWNrIHRvIHRoaXMgYXBwcm9hY2gg
Zm9yIG5vdy4KClRoZSBvbmx5IGFsdGVybmF0aXZlIEkgc2VlIGlzIHRoYXQgd2UgaGF2ZSBhbiB1
bmlmaWVkIGFkZHJlc3Mgc3BhY2UgZm9yIApETUEgYWRkcmVzc2VzIHNpbWlsYXIgdG8gd2hhdCB5
b3UgaGF2ZSBvdXRsaW5lZC4KClRoaXMgd2F5IHdlIGNhbiBlYXNpbHkgZmlndXJlIG91dCBmb3Ig
ZWFjaCBhZGRyZXNzIHRvIHdoaWNoIGRldmljZSBpdCAKYmVsb25ncyBhbmQgdGhlbiBjYWxjdWxh
dGUgdGhlIGJlc3QgcGF0aCB0byB0aGF0IGRldmljZS4KCkUuZy4gZGlyZWN0IGFkZHJlc3MgZm9y
IHN5c3RlbSBtZW1vcnksIGNsZWFyaW5nIHRoZSBTIGJpdCBmb3IgbG9jYWwgCm1lbW9yeSwgdXNp
bmcgWEdNSSBmb3IgcmVtb3RlIG1lbW9yeSBldGMuLi4KClRoYXQgaXMgc2ltaWxhciB0byB3aGF0
IHlvdSBoYXZlIGluIG1pbmQsIGp1c3QgYSBiaXQgbW9yZSBnZW5lcmFsaXplZC4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+ICDCoCBGZWxpeAo+Cj4KPj4gUmVnYXJkcywKPj4g
Q2hyaXN0aWFuLgo+Pgo+Pj4gUmVnYXJkcywKPj4+ICDCoMKgIEZlbGl4Cj4+Pgo+Pj4KPj4+PiBS
ZWdhcmRzLAo+Pj4+IENocmlzdGlhbi4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
