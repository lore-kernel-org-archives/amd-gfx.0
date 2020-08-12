Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFA3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 06:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C36206B2
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 06:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm+zfXvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C36206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C8C6E8A6;
	Wed, 12 Aug 2020 06:46:06 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0586C6E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 06:46:04 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id c10so690807edk.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=V1UbQsWuVbBoOiMfo/nOwK5gJAryoGh/RHYeyzDMcU8=;
 b=Pm+zfXvVKYNaDhXzNGpACdk30pCjynIk6LezXfCsnDV4ChSIERLqEUyawQnMloeWWT
 OwNl3KOK8Y7LNf6Ua8lxlMxeri2De1NDTQIGW+cf9YnF6Ak7LJA3qWGEZz/OKy1vpu+z
 UDCyyglE5RTASnHXcIeqkjJKlmcZ5mX9XQCTGBrPYehE9NWFGFswEbUwAYCtXMg4NR1u
 8Q6UtNypLHckEFNDGjH2fnbZxj5KzXdU/utdvtxkvIpZV4qTCSXqfk5RlwZQ3MFU+Hj9
 NWZoXAtfMrww/A4Zj34FA8P/t1xiPXNYtPahKXilCXnLuNd9+43DNJxv3OUeF0npBr8B
 iM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=V1UbQsWuVbBoOiMfo/nOwK5gJAryoGh/RHYeyzDMcU8=;
 b=BAQz2Dp80UgBPFgTTF7yoyNAi7QbLghXhftMiuvADqQqqDAAxliJMMNuW7/riw0ZEJ
 sxaax1CBd24fiN6EMX5oWAQpcAV64YUFmrSozeaI9gxEPJxqHtOSKBecVe0/BvcWdluE
 EMP+WBEgE1QyE4Okwjbp2L9keFb7zIS5TRBFMGiuBda6dyDgwMXPZ17cfQ9EH/ngvp6L
 Hn8KupaIwg935EZX/PvfhKT+yCp+lk8hMWnNjNJUoMfxMPkroh7w2iD6XsfkIxyR0MOB
 8ifl7eO++njC8r5xdMO8H4SgxTl2sp96rRl6RLjYZcTpjKaQrLfEPtxaaK21aK5XA+O7
 wRcQ==
X-Gm-Message-State: AOAM531enlA+4+oZk19HULoSJ7QMhs5wNTbfMGGOWJSI2hu5zFyyWJjm
 4dGPAJKrIBVkGMggizFQKnQ=
X-Google-Smtp-Source: ABdhPJwvzXy1bimMwocRo9oqW5NbVgpRkMRAWMbjnsI/jR2v9/L/Y1lo5wrKony7CdQV739JcpxLjg==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr30614627edt.333.1597214763679; 
 Tue, 11 Aug 2020 23:46:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t19sm837054edw.63.2020.08.11.23.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 23:46:02 -0700 (PDT)
Subject: Re: [PATCH v3] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200812043336.127057-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e32e6e5c-d808-44eb-7136-9b258c0201c1@gmail.com>
Date: Wed, 12 Aug 2020 08:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812043336.127057-1-shashank.sharma@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMDguMjAgdW0gMDY6MzMgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gVGhpcyBwYXRj
aCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRlCj4gZXZlbnRz
LiBUaGlzIHNwZWNpZmljIGV2ZW50IHdpbGwgcHJvdmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+IC0g
c3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4gLSBIVyBlbmdpbmUgZmxh
Z3MgZm9yIHRoZSBtYXAKPiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPgo+IFRoaXMg
d2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkgcHJvZmlsaW5nIHRvb2xzCj4g
KGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRhdGUgZXZl
bnRzLgo+Cj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJlc3MgbG9va3VwIGxvZ2ljIGluIHRyYWNl
IHBvaW50Cj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5Cj4gICAgICBhZGRlZCBu
cHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPiAgICAgIGFkZGVkIHBhZ2Ugc2l6
ZSBpbiB0aGUgYXJnIGxpc3QKPgo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFA
YW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFj
ZS5oIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgIDkgKysrKy0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHJhY2UuaAo+IGluZGV4IDYzZTczNGExMjVmYi4uYjlhYWU3OTgzYjRiIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPiBAQCAtMzIx
LDYgKzMyMSw0NCBAQCBERUZJTkVfRVZFTlQoYW1kZ3B1X3ZtX21hcHBpbmcsIGFtZGdwdV92bV9i
b19jcywKPiAgIAkgICAgVFBfQVJHUyhtYXBwaW5nKQo+ICAgKTsKPiAgIAo+ICtUUkFDRV9FVkVO
VChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4gKwkgICAgVFBfUFJPVE8oc3RydWN0IGFtZGdwdV92
bV91cGRhdGVfcGFyYW1zICpwLAo+ICsJCSAgICAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVu
ZCwKPiArCQkgICAgIHVuc2lnbmVkIGludCBucHRlcywgdWludDY0X3QgZHN0LAo+ICsJCSAgICAg
dWludDY0X3QgaW5jciwgdWludDY0X3QgZmxhZ3MpLAo+ICsJVFBfQVJHUyhwLCBzdGFydCwgZW5k
LCBucHRlcywgZHN0LCBpbmNyLCBmbGFncyksCj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+ICsJCQkg
X19maWVsZCh1NjQsIHN0YXJ0KQo+ICsJCQkgX19maWVsZCh1NjQsIGVuZCkKPiArCQkJIF9fZmll
bGQodTY0LCBmbGFncykKPiArCQkJIF9fZmllbGQodTY0LCBpbmNyKQo+ICsJCQkgX19maWVsZCh1
bnNpZ25lZCBpbnQsIG5wdGVzKQo+ICsJCQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0LCBucHRl
cykKPiArCSksCj4gKwo+ICsJVFBfZmFzdF9hc3NpZ24oCj4gKwkJCXVuc2lnbmVkIGludCBpOwo+
ICsKPiArCQkJX19lbnRyeS0+c3RhcnQgPSBzdGFydDsKPiArCQkJX19lbnRyeS0+ZW5kID0gZW5k
Owo+ICsJCQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOwo+ICsJCQlfX2VudHJ5LT5pbmNyID0gaW5j
cjsKPiArCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKPiArCj4gKwkJCWZvciAoaSA9IDA7IGkg
PCBucHRlczsgKytpKSB7Cj4gKwkJCQl1NjQgYWRkciA9IHAtPnBhZ2VzX2FkZHIgPyBhbWRncHVf
dm1fbWFwX2dhcnQoCj4gKwkJCQkJcC0+cGFnZXNfYWRkciwgZHN0KSA6IGRzdDsKPiArCj4gKwkJ
CQkoKHU2NCAqKV9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0KSlbaV0gPSBhZGRyOwo+ICsJCQkJZHN0
ICs9IGluY3I7Cj4gKwkJCX0KPiArCSksCj4gKwlUUF9wcmludGsoInNlZzoweCUwMTBsbHgtMHgl
MDEwbGx4LCBmbGFnczoweCVsbHgsIG5wdHI9JXUsIHBnc3o6JWxsdSwiCj4gKwkJICAiIGRzdDpc
biVzIiwgX19lbnRyeS0+c3RhcnQsIF9fZW50cnktPmVuZCwgX19lbnRyeS0+ZmxhZ3MsCj4gKwkJ
ICBfX2VudHJ5LT5ucHRlcywgX19lbnRyeS0+aW5jciwKClRoaXMgaXMgbm90IGNvcnJlY3QuIFRo
ZSBpbmNyZW1lbnQgaXMgTk9UIHRoZSBwYWdlIHNpemUsIGJ1dCByYXRoZXIgdGhlIApwYWdlIHNp
emUgcm91bmRlZCBkb3duIHRvIGEgcG93ZXIgb2YgNTEyKzRLLgoKSW4gb3RoZXIgd29yZHMgcGFn
ZSBzaXplIGNhbiBiZSA0SywgOEssIDE2SywgMzJLLCA2NEsuLi4uMU0sIDJNLCAKNE0uLi4uNTEy
TSwgMUcsIDJHLi4uLgoKQnV0IHRoZSBpbmNyZW1lbnQgY2FuIG9ubHkgYmUgNEssIDJNLCAxRy4u
Li4KCkFuZCBkbyB3ZSBuZWVkIHRoZSBucHRlcyBoZXJlPyBXZSBqdXN0IG5lZWQgaXQgdG8gcHJp
bnQgdGhlIGNvcnJlY3QgCm51bWJlciBvZiBkZXN0aW5hdGlvbiBhZGRyZXNzZXMuCgpSZWdhcmRz
LApDaHJpc3RpYW4uCgo+ICsJCSAgX19wcmludF9hcnJheShfX2dldF9keW5hbWljX2FycmF5KGRz
dCksIF9fZW50cnktPm5wdGVzLCA4KSkKPiArKTsKPiArCj4gICBUUkFDRV9FVkVOVChhbWRncHVf
dm1fc2V0X3B0ZXMsCj4gICAJICAgIFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRfdCBhZGRy
LCB1bnNpZ25lZCBjb3VudCwKPiAgIAkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBmbGFn
cywgYm9vbCBkaXJlY3QpLAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
aW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0xNTEzLDE3ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFy
YW1zLAo+ICAgCQlkbyB7Cj4gICAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwg
ZnJhZ19lbmQpOwo+ICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQp
ID4+IHNoaWZ0Owo+ICsJCQl1aW50NjRfdCB1cGRfZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVf
RlJBRyhmcmFnKTsKPiAgIAo+ICAgCQkJLyogVGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhp
Z2hlciBsZXZlbCBQRHMgdG8KPiAgIAkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4K
PiAgIAkJCSAqLwo+ICAgCQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPiArCj4gKwkJCXRyYWNl
X2FtZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4gKwkJ
CQkJCSAgICBucHRlcywgZHN0LCBpbmNyLAo+ICsJCQkJCQkgICAgdXBkX2ZsYWdzKTsKPiAgIAkJ
CWFtZGdwdV92bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBwdCwgY3Vyc29yLmxldmVsLAo+ICAgCQkJ
CQkgICAgICAgcGVfc3RhcnQsIGRzdCwgbnB0ZXMsIGluY3IsCj4gLQkJCQkJICAgICAgIGZsYWdz
IHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsKPiArCQkJCQkgICAgICAgdXBkX2ZsYWdzKTsKPiAg
IAo+ICAgCQkJcGVfc3RhcnQgKz0gbnB0ZXMgKiA4Owo+IC0JCQlkc3QgKz0gKHVpbnQ2NF90KW5w
dGVzICogQU1ER1BVX0dQVV9QQUdFX1NJWkUgPDwgc2hpZnQ7Cj4gKwkJCWRzdCArPSBucHRlcyAq
IGluY3I7Cj4gICAKPiAgIAkJCWZyYWdfc3RhcnQgPSB1cGRfZW5kOwo+ICAgCQkJaWYgKGZyYWdf
c3RhcnQgPj0gZnJhZ19lbmQpIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
