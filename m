Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D9C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 22:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1BE22E00
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 22:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1BE22E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=froggi.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E2B89817;
	Tue,  5 Jan 2021 22:31:40 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0630D89817
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 22:31:39 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id c5so704058wrp.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aArhdd0Y3PFeb8/j3y2HfIfc19FJco8r8erkg0Z7zqY=;
 b=eO5+R8hulDQqiR97rycym7UnQ7hydCiTmK80aQib1m7uMcz2VUEZ/RFopmkGvBJBBk
 60uQf2n1U1hJgosx0hCeTFdrqJsbshGcCmjFf/Bbfo7OGBsRCMiyNGxz9Zb93mVUV81H
 EeyvPCl/yCg16YeAEq314b/J9Ldsu+z5Y8lfDLC7pG7pWJ9PHwzCtdBcf/YjXLT79qw3
 aGhAIxNHITmBuZSljeOLyqt9ipnZLwTXjtUhlEdGMcXVGSHgq/hzrfayGEnt4C9lHkSx
 NiTTGtEPW1Ti/qZu0i5ejTU0lpmZXiSSivR5F0bZLLqx6tJOtajBzKa3VcZM13DRb+La
 Uo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aArhdd0Y3PFeb8/j3y2HfIfc19FJco8r8erkg0Z7zqY=;
 b=CKMHpEKM6GNEbAzdkj6E+SWFSJu5zuOz5ZB/HeGgl3ft6/zLFpydjn2nczbHSbltk4
 BIk/4qN3GFQOsFEQueHv8SZVX6uDvXjwFCUYk0AgQo2staPx7eMIeSaEqqZ+wxJR/TD0
 TuHgY+VzveN+IJ6RfHhacwucu9gYcRcrjn9cgvLp959OvU/Ktzp8RnsP8ezFAp4ImT4n
 /8sYs3utaGrXLAn3LBgQqeBpIPSQJSoJlu6n9K6UEUJ5Tc4XZ3kY5GFrQZs559h+yDut
 mFHgTIq09opBW/I6QUGm4LJiQ8CaDnwXDVChQQGpDys1/ykgBndrEENI1b7zrAifjTGc
 b6EA==
X-Gm-Message-State: AOAM532ZgAJWZKHbBMKrjeuD4/cci/ahpK5cZpFnqEIDdvGbGDXC+4+9
 HutpjTqcagqXB/B4tYNWy94T4m2AwzKyXQ==
X-Google-Smtp-Source: ABdhPJzoewC9X2tvJrdWBJEZXWLoO52a8KH3w3u17K05IBb/HsahTuBt2CAenqWYuYHmIFU7atiAiw==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr1460696wrn.179.1609885897686; 
 Tue, 05 Jan 2021 14:31:37 -0800 (PST)
Received: from [192.168.0.61]
 (cpc89720-darl9-2-0-cust754.11-2.cable.virginm.net. [86.2.110.243])
 by smtp.gmail.com with ESMTPSA id x18sm680751wrg.55.2021.01.05.14.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Jan 2021 14:31:37 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
From: Joshua Ashton <joshua@froggi.es>
Message-ID: <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
Date: Tue, 5 Jan 2021 22:31:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
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
Cc: Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMS81LzIxIDEwOjEwIFBNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gVHVlLCBKYW4gNSwg
MjAyMSBhdCA1OjA1IFBNIEpvc2h1YSBBc2h0b24gPGpvc2h1YUBmcm9nZ2kuZXM+IHdyb3RlOgo+
Pgo+PiBTaW5jZSBjb21taXQgMjQ1NjI1MjM2ODhiICgiUmV2ZXJ0ICJkcm0vYW1kL2FtZGdwdTog
c2V0IGd0dCBzaXplCj4+IGFjY29yZGluZyB0byBzeXN0ZW0gbWVtb3J5IHNpemUgb25seSIiKSwg
dGhlIEdUVCBzaXplIHdhcyBsaW1pdGVkIGJ5Cj4+IDNHaUIgb3IgVlJBTSBzaXplLgo+IAo+IFRo
ZSBjb21taXQgaW4gcXVlc3Rpb24gd2FzIHRvIGZpeCBhIGhhbmcgd2l0aCBjZXJ0YWluIHRlc3Rz
IG9uIEFQVXMuCj4gVGhhdCBzaG91bGQgYmUgdGVzdGVkIGFnYWluIGJlZm9yZSB3ZSByZS1lbmFi
bGUgdGhpcy4gIElmIGl0IGlzIGZpeGVkLAo+IHdlIHNob3VsZCBqdXN0IHJldmVydCB0aGUgcmV2
ZXJ0IHJhdGhlciB0aGFuIHNwZWNpYWwgY2FzZSBkR1BVcy4KPiAKPiBBbGV4Cj4gCgpJIHRoaW5r
IHRoZSBjb21taXQgYmVmb3JlIHRoZSByZXZlcnQgKGJhODUxZWVkODk1YykgaGFzIHNvbWUgZnVu
ZGFtZW50YWwgCnByb2JsZW1zOgoKSXQgd2FzIGFsd2F5cyBzcGVjaWZ5aW5nIG1heCgzR2lCLCAz
LzR0aHMgUkFNKSBvZiBHVFQsIGV2ZW4gaWYgdGhhdCAKd291bGRuJ3QgZml0IGludG8gc2F5LCAx
R2lCIG9yIDJHaUIgb2YgYXZhaWxhYmxlIFJBTS4KCkxpbWl0aW5nIEdUVCB0byBtaW4obWF4KDNH
aUIsIFZSQU0pLCAzLzR0aHMgUkFNKSBzaXplIG9uIGRHUFVzIG1ha2VzIApzZW5zZSBhbHNvIGFu
ZCBpcyBhIHNlbnNpYmxlIGxpbWl0IHRvIGF2b2lkIHNpbGx5IHNpdHVhdGlvbnMgd2l0aCAKb3Zl
cmFsbG9jYXRpb24gYW5kIHBvdGVudGlhbCBPT00uCgpUaGlzIHBhdGNoIHNvbHZlcyBib3RoIG9m
IHRob3NlIGlzc3Vlcy4KCi0gSm9zaGllIPCfkLjinKgKCj4gCj4+Cj4+IFRoaXMgaXMgcHJvYmxl
bWF0aWMgb24gQVBVcywgZXNwZWNpYWxseSB3aXRoIGEgc21hbGwgY2FydmVvdXQKPj4gd2hpY2gg
Y2FuIGJlIGFzIGxvdyBhcyBhIGZpeGVkIDEyOE1pQiwgYXMgdGhlcmUgd291bGQgYmUgdmVyeSBh
IGxpbWl0ZWQKPj4gM0dpQiBhdmFpbGFibGUgZm9yIHZpZGVvIG1lbW9yeS4KPj4gVGhpcyBvYnZp
b3VzbHkgZG9lcyBub3QgbWVldCB0aGUgZGVtYW5kcyBvZiBtb2Rlcm4gYXBwbGljYXRpb25zLgo+
Pgo+PiBUaGlzIHBhdGNoIG1ha2VzIGl0IHNvIHRoZSBHVFQgc2l6ZSBoZXVyaXN0aWMgYWx3YXlz
IHVzZXMgMy80dGhzIG9mCj4+IHRoZSBzeXN0ZW0gbWVtb3J5IHNpemUgb24gQVBVcyAobGltaXRp
bmcgdGhlIHNpemUgYnkgM0dpQi9WUkFNIHNpemUKPj4gb25seSBvbiBkZXZpY2VzIHdpdGggZGVk
aWNhdGVkIHZpZGVvIG1lbW9yeSkuCj4+Cj4+IEZpeGVzOiAyNDU2MjUyMzY4OGIgKCJSZXZlcnQg
ZHJtL2FtZC9hbWRncHU6IHNldCBndHQgc2l6ZSBhY2NvcmRpbmcgdG8KPj4gc3lzdGVtIG1lbW9y
eSBzaXplIG9ubHkiKQo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKb3NodWEgQXNodG9uIDxqb3NodWFA
ZnJvZ2dpLmVzPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMgfCAgNSArKystLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYyB8IDEyICsrKysrKysrKy0tLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+PiBpbmRleCA3MmVmZDU3OWVjNWUuLmE1YTQxZTkyNzJkNiAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+PiBAQCAtMTkyLDggKzE5Miw5IEBA
IG1vZHVsZV9wYXJhbV9uYW1lZChnYXJ0c2l6ZSwgYW1kZ3B1X2dhcnRfc2l6ZSwgdWludCwgMDYw
MCk7Cj4+Cj4+ICAgLyoqCj4+ICAgICogRE9DOiBndHRzaXplIChpbnQpCj4+IC0gKiBSZXN0cmlj
dCB0aGUgc2l6ZSBvZiBHVFQgZG9tYWluIGluIE1pQiBmb3IgdGVzdGluZy4gVGhlIGRlZmF1bHQg
aXMgLTEgKEl0J3MgVlJBTSBzaXplIGlmIDNHQiA8IFZSQU0gPCAzLzQgUkFNLAo+PiAtICogb3Ro
ZXJ3aXNlIDMvNCBSQU0gc2l6ZSkuCj4+ICsgKiBSZXN0cmljdCB0aGUgc2l6ZSBvZiBHVFQgZG9t
YWluIGluIE1pQiBmb3IgdGVzdGluZy4gVGhlIGRlZmF1bHQgaXMgLTEgKE9uIEFQVXMgdGhpcyBp
cyAzLzR0aAo+PiArICogb2YgdGhlIHN5c3RlbSBtZW1vcnk7IG9uIGRHUFVzIHRoaXMgaXMgM0dp
QiBvciBWUkFNIHNpemVkLCB3aGljaGV2ZXIgaXMgYmlnZ2VyLAo+PiArICogd2l0aCBhbiB1cHBl
ciBib3VuZCBvZiAzLzR0aCBvZiBzeXN0ZW0gbWVtb3J5Lgo+PiAgICAqLwo+PiAgIE1PRFVMRV9Q
QVJNX0RFU0MoZ3R0c2l6ZSwgIlNpemUgb2YgdGhlIEdUVCBkb21haW4gaW4gbWVnYWJ5dGVzICgt
MSA9IGF1dG8pIik7Cj4+ICAgbW9kdWxlX3BhcmFtX25hbWVkKGd0dHNpemUsIGFtZGdwdV9ndHRf
c2l6ZSwgaW50LCAwNjAwKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Ywo+PiBpbmRleCA0ZDhmMTlhYjEwMTQuLjI5NGYyNmY0ZjMxMCAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBAQCAtMTg2NSw5ICsxODY1LDE1IEBAIGlu
dCBhbWRncHVfdHRtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgICAgICAg
ICAgICAgICAgc3RydWN0IHN5c2luZm8gc2k7Cj4+Cj4+ICAgICAgICAgICAgICAgICAgc2lfbWVt
aW5mbygmc2kpOwo+PiAtICAgICAgICAgICAgICAgZ3R0X3NpemUgPSBtaW4obWF4KChBTURHUFVf
REVGQVVMVF9HVFRfU0laRV9NQiA8PCAyMCksCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBhZGV2LT5nbWMubWNfdnJhbV9zaXplKSwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICgodWludDY0X3Qpc2kudG90YWxyYW0gKiBzaS5tZW1fdW5pdCAqIDMvNCkpOwo+PiAr
ICAgICAgICAgICAgICAgZ3R0X3NpemUgPSAodWludDY0X3Qpc2kudG90YWxyYW0gKiBzaS5tZW1f
dW5pdCAqIDMvNDsKPj4gKyAgICAgICAgICAgICAgIC8qIElmIHdlIGhhdmUgZGVkaWNhdGVkIG1l
bW9yeSwgbGltaXQgb3VyIEdUVCBzaXplIHRvCj4+ICsgICAgICAgICAgICAgICAgKiAzR2lCIG9y
IFZSQU0gc2l6ZSwgd2hpY2hldmVyIGlzIGJpZ2dlcgo+PiArICAgICAgICAgICAgICAgICovCj4+
ICsgICAgICAgICAgICAgICBpZiAoIShhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpKSB7Cj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGd0dF9zaXplID0gbWluKG1heChBTURHUFVfREVGQVVMVF9H
VFRfU0laRV9NQiA8PCAyMCwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2
LT5nbWMubWNfdnJhbV9zaXplKSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
dHRfc2l6ZSk7Cj4+ICsgICAgICAgICAgICAgICB9Cj4+ICAgICAgICAgIH0KPj4gICAgICAgICAg
ZWxzZQo+PiAgICAgICAgICAgICAgICAgIGd0dF9zaXplID0gKHVpbnQ2NF90KWFtZGdwdV9ndHRf
c2l6ZSA8PCAyMDsKPj4gLS0KPj4gMi4zMC4wCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
