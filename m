Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBBDC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BBD20678
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjuCRv71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BBD20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF176E8A3;
	Wed,  8 Jan 2020 15:04:29 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCD16E8A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 15:04:28 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d139so16714448wmd.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 07:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+F7ZVIX8GwjXFrdkVMq3WuJElWwZtHv0tHkyzOn2Es0=;
 b=VjuCRv71WgYjHqHC+0Z+ezW6O+5Lm7OtJyJYIy5FMOa6v1EcqIw5zzXFw16bOWlLL2
 1B1lMVVL2KXH2WBFPkHbEDVVKrnIT4ig3Nd45uTaX9EE6x6eqlOuaFB3uoOM+EAVYzRa
 mz8oCg5hML0K/xxsbTHkIbEDNXaMyeyy/JwVDy5PjNlihYuU7ZNqLEKVcAshyopZMO3n
 OF3BhS2hLblcn00p1vKU+bKOn85yiWvELHSWElQo5KPeyVRp2cjuve9ZhWy5kqDxT8Bi
 d/VchvuHmwu4IR6kEO8PNPXE9LswZCTvQtoMF2LO+8HEqvHshvyA3oLbW0Se/5rAX0MX
 MfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=+F7ZVIX8GwjXFrdkVMq3WuJElWwZtHv0tHkyzOn2Es0=;
 b=OaGMAaNR8Pl1EGTizyX4ju5Bdp0GnK5VjQPRTK/3EHBJT5DyZU8Wt4jYfYbknHhtZd
 dEAOXjwTu6qVWGforTGdX35KIk8LVqhh8sIpp6X4ZprKEpquGTRsACfzhNj+pvmDSU+E
 WMKito5eWs7Rsfgeh4JEohOzyma/+z67u0SwxweXy5Qi0LniF9ZIf89TC7zMvCdH4fML
 8WtVU51pKVQdSh1CNaYkD6UG+VgAObSv1G9DQjL104mQqnd4zbjFZCnqPC5BCchszEJh
 XCKChDjxY1+e4Z4t5WCRlPWr/tWtXyWSFVMI9sxUyc3uzpaEl6qhbBAN+knTzRUsx5gj
 tSwg==
X-Gm-Message-State: APjAAAVOn3BnCpmblQMk4OMtr3ehR/hD47eR2tuo309DqW43O0uqnllt
 ReekPknHVROAFOmqzm/zZpBeFEhZ
X-Google-Smtp-Source: APXvYqzyuQZgmsYSOXSRX5UBYoUxSx+3W1p7TOtW7BTOM8ShaHEb98QmsR+zUouOdRruRt1b/jDxiw==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr4369191wmb.113.1578495867044; 
 Wed, 08 Jan 2020 07:04:27 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s3sm4075394wmh.25.2020.01.08.07.04.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 07:04:17 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when
 GDDR6 training enabled
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200108123648.7422-1-tianci.yin@amd.com>
 <ba1754a0-7230-5df7-cfb3-7b0d7c892c47@amd.com>
 <CADnq5_MQ1S60QX3=U2=LYSoiYg965yViTk0Y0WbaFTRXhvNZww@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <aca36233-68fd-c692-1080-daa9c32efa14@gmail.com>
Date: Wed, 8 Jan 2020 16:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MQ1S60QX3=U2=LYSoiYg965yViTk0Y0WbaFTRXhvNZww@mail.gmail.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDEuMjAgdW0gMTU6NDkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gV2VkLCBKYW4g
OCwgMjAyMCBhdCA3OjUyIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4gd3JvdGU6Cj4+IEFtIDA4LjAxLjIwIHVtIDEzOjM2IHNjaHJpZWIgVGlhbmNpIFlpbjoK
Pj4+IEZyb206ICJUaWFuY2kuWWluIiA8dGlhbmNpLnlpbkBhbWQuY29tPgo+Pj4KPj4+IFt3aHld
Cj4+PiBJbiBkdWFsIEdQVXMgc2NlbmFyaW8sIHN0b2xlbl9zaXplIGlzIGFzc2lnbmVkIHRvIHpl
cm8gb24gdGhlIDJuZCBHUFUsCj4+PiB0aGVuIHRoZSBib3R0b20gcmVnaW9uIG9mIFZSQU0gd2Fz
IGFsbG9jYXRlZCBhcyBHVFQsIHVuZm9ydHVuYXRlbHkKPj4+IGEgc21hbGwgcmVnaW9uIG9mIGJv
dHRvbSBWUkFNIHdhcyBlbmNyb2FjaGVkIGJ5IFVNQyBmaXJtd2FyZSBkdXJpbmcKPj4+IEdERFI2
IEJJU1QgdHJhaW5pbmcsIHRoaXMgY2F1c2UgcGFnZWZhdWx0Lgo+PiBXaGF0IEknbSBtaXNzaW5n
IGhlcmUgaXMgd2h5IGlzIHRoZSBzdG9sZW4gc2l6ZSB6ZXJvIG9uIHRoZSAybmQgR1BVPwo+Pgo+
PiBNYXliZSB3ZSBuZWVkIHRvIHJlYWQgdGhlIHN0b2xlbiBzaXplIGFmdGVyIHBvc3RpbmcgdGhl
IEdQVSBpbnN0ZWFkPwo+IFRoZXJlIGlzIG5vIHN0b2xlbiBtZW1vcnkgb24gc2Vjb25kYXJ5IEdQ
VXMgYmVjYXVzZSB0aGVyZSBpcyBubyBwcmUtT1MKPiBjb25zb2xlIHVzaW5nIHRoYXQgbWVtb3J5
LgoKQWghIFllYWggdGhhdCBtYWtlcyBzZW5zZS4KCkJ1dCBpbiB0aGlzIGNhc2UgSSB3b3VsZCBz
YXkgd2Ugc2hvdWxkIGNoYW5nZSB0aGUgcGF0Y2ggbGlrZSB0aGUgZm9sbG93aW5nOgoKYWRldi0+
Z21jLnN0b2xlbl9zaXplID0gbWluKGFkZXYtPmdtYy5zdG9sZW5fc2l6ZSwgCkFNREdQVV9TVE9M
RU5fVkdBX0RFRkFVTFRfU0laRSk7CgpBbmQgaW4gYW1kZ3B1X3R0bV9sYXRlX2luaXQoKToKCi8q
IENhbid0IGZyZWUgdGhlIHN0b2xlbiBWR0EgbWVtb3J5IHdoZW4gaXQgbWlnaHQgYmUgdXNlZCBm
b3IgbWVtb3J5IAp0cmFpbmluZyBhZ2Fpbi4gKi8KaWYgKCFhZGV2LT5md192cmFtX3VzYWdlLm1l
bV90cmFpbl9zdXBwb3J0KQogwqDCoMKgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCguLi4uCgoKUmVn
YXJkcywKQ2hyaXN0aWFuLgoKCj4KPiBBbGV4Cj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+
Pgo+Pj4gW2hvd10KPj4+IEZvcmNpbmcgc3RvbGVuX3NpemUgdG8gM01CLCB0aGVuIHRoZSBib3R0
b20gcmVnaW9uIG9mIFZSQU0gd2FzCj4+PiBhbGxvY2F0ZWQgYXMgc3RvbGVuIG1lbW9yeSwgR1RU
IGNvcnJ1cHRpb24gYXZvaWQuCj4+PiBUaGUgc3RvbGVuIG1lbW9yeSBvZiB0aGUgMm5kIEdQVSB3
aWxsIGJlIGZyZWUgaW4gbGF0ZV9pbml0IHBoYXNlLAo+Pj4gbm8gbWVtb3J5IHdhc3RlZC4KPj4+
Cj4+PiBDaGFuZ2UtSWQ6IEljZDBhZDdkZTQxMzMzMjgyOTQ5YmIxZTNlNjc2YzZjMzA3ZGRkMDgx
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBUaWFuY2kuWWluIDx0aWFuY2kueWluQGFtZC5jb20+Cj4+PiAt
LS0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCB8ICA2ICsr
KysrKwo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgIHwgMjEg
KysrKysrKysrKysrKysrKysrKysrCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlv
bnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4+PiBp
bmRleCBjOTFkZDYwMmQ1ZjEuLjQ0MGI3OTMzMTZkZiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4+PiBAQCAtNjAsNiArNjAsMTEgQEAKPj4+ICAgICAq
Lwo+Pj4gICAgI2RlZmluZSBBTURHUFVfR01DX0ZBVUxUX1RJTUVPVVQgICAgNTAwMFVMTAo+Pj4K
Pj4+ICsvKgo+Pj4gKyAqIERlZmF1bHQgc3RvbGVuIG1lbW9yeSBzaXplLCAxMDI0ICogNzY4ICog
NAo+Pj4gKyAqLwo+Pj4gKyNkZWZpbmUgQU1ER1BVX1NUT0xFTl9WR0FfREVGQVVMVF9TSVpFICAg
ICAgIDB4MzAwMDAwCj4+PiArCj4+PiAgICBzdHJ1Y3QgZmlybXdhcmU7Cj4+Pgo+Pj4gICAgLyoK
Pj4+IEBAIC0xOTIsNiArMTk3LDcgQEAgc3RydWN0IGFtZGdwdV9nbWMgewo+Pj4gICAgICAgIHVp
bnQzMl90ICAgICAgICAgICAgICAgIHNyYm1fc29mdF9yZXNldDsKPj4+ICAgICAgICBib29sICAg
ICAgICAgICAgICAgICAgICBwcnRfd2FybmluZzsKPj4+ICAgICAgICB1aW50NjRfdCAgICAgICAg
ICAgICAgICBzdG9sZW5fc2l6ZTsKPj4+ICsgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIHN0
b2xlbl90ZW1wX3Jlc2VydmVkOwo+Pj4gICAgICAgIC8qIGFwZXJ0dXJlcyAqLwo+Pj4gICAgICAg
IHU2NCAgICAgICAgICAgICAgICAgICAgIHNoYXJlZF9hcGVydHVyZV9zdGFydDsKPj4+ICAgICAg
ICB1NjQgICAgICAgICAgICAgICAgICAgICBzaGFyZWRfYXBlcnR1cmVfZW5kOwo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPj4+IGluZGV4IDdkYzhjMDY4YzYyYS4uMGM5
NmI2N2Q2Y2E3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5j
Cj4+PiBAQCAtNTY2LDYgKzU2NiwxMSBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9sYXRlX2luaXQo
dm9pZCAqaGFuZGxlKQo+Pj4gICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0
cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwo+Pj4gICAgICAgIGludCByOwo+Pj4KPj4+ICsg
ICAgIGlmIChhZGV2LT5nbWMuc3RvbGVuX3RlbXBfcmVzZXJ2ZWQpIHsKPj4+ICsgICAgICAgICAg
ICAgYW1kZ3B1X2JvX2xhdGVfaW5pdChhZGV2KTsKPj4+ICsgICAgICAgICAgICAgYWRldi0+Z21j
LnN0b2xlbl90ZW1wX3Jlc2VydmVkID0gZmFsc2U7Cj4+PiArICAgICB9Cj4+PiArCj4+PiAgICAg
ICAgciA9IGFtZGdwdV9nbWNfYWxsb2NhdGVfdm1faW52X2VuZyhhZGV2KTsKPj4+ICAgICAgICBp
ZiAocikKPj4+ICAgICAgICAgICAgICAgIHJldHVybiByOwo+Pj4gQEAgLTc1Niw2ICs3NjEsMjIg
QEAgc3RhdGljIGludCBnbWNfdjEwXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+PiAgICAgICAg
ICAgICAgICByZXR1cm4gcjsKPj4+Cj4+PiAgICAgICAgYWRldi0+Z21jLnN0b2xlbl9zaXplID0g
Z21jX3YxMF8wX2dldF92Ymlvc19mYl9zaXplKGFkZXYpOwo+Pj4gKyAgICAgLyoKPj4+ICsgICAg
ICAqIEluIGR1YWwgR1BVcyBzY2VuYXJpbywgc3RvbGVuX3NpemUgaXMgYXNzaWduZWQgdG8gemVy
byBvbiB0aGUgMm5kIEdQVSwKPj4+ICsgICAgICAqIHRoZW4gdGhlIGJvdHRvbSByZWdpb24gb2Yg
VlJBTSB3YXMgYWxsb2NhdGVkIGFzIEdUVCwgdW5mb3J0dW5hdGVseQo+Pj4gKyAgICAgICogYSBz
bWFsbCByZWdpb24gb2YgYm90dG9tIFZSQU0gd2FzIGVuY3JvYWNoZWQgYnkgVU1DIGZpcm13YXJl
IGR1cmluZwo+Pj4gKyAgICAgICogR0REUjYgQklTVCB0cmFpbmluZywgdGhpcyBjYXVzZSBwYWdl
ZmF1bHQuCj4+PiArICAgICAgKiBUaGUgcGFnZSBmYXVsdCBjYW4gYmUgZml4ZWQgYnkgZm9yY2lu
ZyBzdG9sZW5fc2l6ZSB0byAzTUIsIHRoZW4gdGhlIGJvdHRvbQo+Pj4gKyAgICAgICogcmVnaW9u
IG9mIFZSQU0gd2FzIGFsbG9jYXRlZCBhcyBzdG9sZW4gbWVtb3J5LCBHVFQgY29ycnVwdGlvbiBh
dm9pZC4KPj4+ICsgICAgICAqIFRoZSBzdG9sZW4gbWVtb3J5IG9mIHRoZSAybmQgR1BVIHdpbGwg
YmUgZnJlZSBpbiBsYXRlX2luaXQgcGhhc2UsCj4+PiArICAgICAgKiBubyBtZW1vcnkgd2FzdGVk
Lgo+Pj4gKyAgICAgICovCj4+PiArICAgICBpZiAoYWRldi0+ZndfdnJhbV91c2FnZS5tZW1fdHJh
aW5fc3VwcG9ydCAmJgo+Pj4gKyAgICAgICAgICAgICBhZGV2LT5nbWMuc3RvbGVuX3NpemUgPT0g
MCkgewo+Pj4gKyAgICAgICAgICAgICBhZGV2LT5nbWMuc3RvbGVuX3NpemUgPSBBTURHUFVfU1RP
TEVOX1ZHQV9ERUZBVUxUX1NJWkU7Cj4+PiArICAgICAgICAgICAgIGFkZXYtPmdtYy5zdG9sZW5f
dGVtcF9yZXNlcnZlZCA9IHRydWU7Cj4+PiArICAgICB9IGVsc2UKPj4+ICsgICAgICAgICAgICAg
YWRldi0+Z21jLnN0b2xlbl90ZW1wX3Jlc2VydmVkID0gZmFsc2U7Cj4+Pgo+Pj4gICAgICAgIC8q
IE1lbW9yeSBtYW5hZ2VyICovCj4+PiAgICAgICAgciA9IGFtZGdwdV9ib19pbml0KGFkZXYpOwo+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
