Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85526C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604742173E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604742173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166D36EE15;
	Wed,  6 Nov 2019 17:37:21 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD716EE15
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 17:37:19 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b11so1691614wmb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Nov 2019 09:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+gylgXj2rS+RC9ymyu9JVxawda9O0bUyARQMmggJXB8=;
 b=euo+GukXrxuEX7nf8ZmdApVnT2aHfn/bNEpb/K9kjwo4ZWaxZEqmB6K4FLQh0kNM27
 1tRSifvTlMeljbtS7GS2nPWp4Du/BGdqhiLOakAvOKganD8Hv5q+u2feV26/c0usdAoy
 DbY91YJKb6vU8igedD9rMLT9eCPh+Kx8VFsQae2lDogqiNWNKzViVJvagpaxl/1E6bZG
 0Ql6qGt4nikeOfDZX6lEfBE1XuBXzV8eNE2pSsro22eWkBVxeQliir+MdGq1sPp2wpem
 xrr0w+A2zL/IDLXkrJuQnHGOgewy5d9ZPX9HiVSYGoq87aKPiDeqAs8vaUpchO9+SdjA
 wzzA==
X-Gm-Message-State: APjAAAVEkBgSNIccPeqylFHzCjNKhoTkVr7+oxZYVPnK4dZP+/v/DI8o
 Jeg+perl8u1Ckv0Lq/NDu5GW0vuYtMM2u9DpmgiWhA==
X-Google-Smtp-Source: APXvYqwuTk72ai6IQAbqtMVHuCAjDm2OLmQ39ItYzBGy/Ex3YbDm3cnWm5J5KytlYlKmCdVCpPdiqlIH/O7WW5JgHK4=
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr3375201wma.34.1573061838402; 
 Wed, 06 Nov 2019 09:37:18 -0800 (PST)
MIME-Version: 1.0
References: <1573060895-13033-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1573060895-13033-1-git-send-email-Oak.Zeng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2019 12:37:06 -0500
Message-ID:
 <CADnq5_NAyRJF-26XV-QnVEQ4pD9NobmBvcGcnJTUqcO0OOe62Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure
To: "Zeng, Oak" <Oak.Zeng@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=+gylgXj2rS+RC9ymyu9JVxawda9O0bUyARQMmggJXB8=;
 b=OLCgA9ML1EiywbAnrYuFKR6aNJmAUeQjN/Fg39KI2MLXi/GWmjux8BiYS4xHr8U+b8
 Rpubnb8KVW+utoDL1/mCljNC7BasxcNBjkc/5hbi4M/dY870BDmT5/Tshqvrt6Ta9DFV
 RnnzZY+Akh8UpOocstYXEKjNfE98R5EkVRYTiz89vxqI9j6ly00L++rfihz/uxh9xFQl
 9mNI2CUgndTVLJa5m1KyTybLTjGMNo6LrXhyZrE7WvMa7maXfrl0YEl8Dj0NGzEOU/hv
 9xm+74UN0j9FEBmQ4uzubwpBsLPVskOuJ3PxHl6I2AEi6H1ZKbY76fdtN6zWTRTeQnZw
 pBtg==
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106173706.F73bYzJuNW01nN0yovi206nChebu26830Ud0Nm74XzE@z>

T24gV2VkLCBOb3YgNiwgMjAxOSBhdCAxMjoyMSBQTSBaZW5nLCBPYWsgPE9hay5aZW5nQGFtZC5j
b20+IHdyb3RlOgo+Cj4gRXhwbGFpbiBmaWVsZHMgbGlrZSBhcGVyX2Jhc2UsIGFncF9zdGFydCBl
dGMuIFRoZSBkZWZpbml0aW9uCj4gb2YgdGhvc2UgZmllbGRzIGFyZSBjb25mdXNpbmcgYXMgdGhl
eSBhcmUgZnJvbSBkaWZmZXJlbnQgdmlldwo+IChDUFUgb3IgR1BVKS4gQWRkIGNvbW1lbnRzIGZv
ciBlYXNpZXIgdW5kZXJzdGFuZC4KPgo+IENoYW5nZS1JZDogSTAyYzJhMjdjZDBkYmMyMDU0OThl
Yjg2YWFmYTcyMmYyZTBjMjVmZTYKPiBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdA
YW1kLmNvbT4KCkEgZmV3IGNvbW1lbnRzIGJlbG93LCBvdGhlcndpc2UgbG9va3MgZ29vZCB0byBt
ZS4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCB8IDI1
ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiBpbmRleCA1
NTVkOGU1Li44MDAzMjAxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nbWMuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuaAo+IEBAIC0xMjcsMTggKzEyNyw0MyBAQCBzdHJ1Y3QgYW1kZ3B1X3hnbWkgewo+ICB9Owo+
Cj4gIHN0cnVjdCBhbWRncHVfZ21jIHsKPiArICAgICAgIC8qIEZCJ3MgcGh5c2ljYWwgYWRkcmVz
cyBpbiBNTUlPIHNwYWNlIChmb3IgQ1BVIHRvCj4gKyAgICAgICAgKiBtYXAgRkIpLiBUaGlzIGlz
IGRpZmZlcmVudCBjb21wYXJlZCB0byB0aGUgYXBnLwoKYXBnIC0+IGFncAoKPiArICAgICAgICAq
IGdhcnQvdnJhbV9zdGFydC9lbmQgZmllbGQgYXMgdGhlIGxhdGVyIGlzIGZyb20KPiArICAgICAg
ICAqIEdQVSdzIHZpZXcgYW5kIGFwZXJfYmFzZSBpcyBmcm9tIENQVSdzIHZpZXcuCj4gKyAgICAg
ICAgKi8KPiAgICAgICAgIHJlc291cmNlX3NpemVfdCAgICAgICAgIGFwZXJfc2l6ZTsKPiAgICAg
ICAgIHJlc291cmNlX3NpemVfdCAgICAgICAgIGFwZXJfYmFzZTsKPiAgICAgICAgIC8qIGZvciBz
b21lIGNoaXBzIHdpdGggPD0gMzJNQiB3ZSBuZWVkIHRvIGxpZQo+ICAgICAgICAgICogYWJvdXQg
dnJhbSBzaXplIG5lYXIgbWMgZmIgbG9jYXRpb24gKi8KPiAgICAgICAgIHU2NCAgICAgICAgICAg
ICAgICAgICAgIG1jX3ZyYW1fc2l6ZTsKPiAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAg
IHZpc2libGVfdnJhbV9zaXplOwo+ICsgICAgICAgLyogQVBHIGFwZXJ0dXJlIHN0YXJ0IGFuZCBl
bmQgaW4gTUMgYWRkcmVzcyBzcGFjZQoKQVBHIC0+IEFHUAoKPiArICAgICAgICAqIERyaXZlciBm
aW5kIGEgaG9sZSBpbiB0aGUgTUMgYWRkcmVzcyBzcGFjZQo+ICsgICAgICAgICogdG8gcGxhY2Ug
QUdQIGJ5IHNldHRpbmcgTUNfVk1fQUdQX0JPVC9UT1AgcmVnaXN0ZXJzCj4gKyAgICAgICAgKiBV
bmRlciBWTUlEMCwgbG9naWNhbCBhZGRyZXNzID09IE1DIGFkZHJlc3MKPiArICAgICAgICAqIEFH
UCBhcGVydHVyZSBpcyB1c2VkIHRvIHNpbXVsYXRlIEZCIGluIFpGQiBjYXNlCj4gKyAgICAgICAg
Ki8KCllvdSBtYXkgd2FudCB0byBhZGQgYSBjb21tZW50IHRoYXQgdGhlIEFHUCBhcGVydHVyZSBq
dXN0IG1hcHMgdG8KcGh5c2ljYWwgYnVzIG9yIElPVkEgYWRkcmVzc2VzIG9uIHRoZSBwbGF0Zm9y
bS4gIEl0J3MgYWxzbyB1c2VkIGZvcgpwYWdlIHRhYmxlcyBpbiBzeXN0ZW0gbWVtb3J5LgoKPiAg
ICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgIGFncF9zaXplOwo+ICAgICAgICAgdTY0ICAg
ICAgICAgICAgICAgICAgICAgYWdwX3N0YXJ0Owo+ICAgICAgICAgdTY0ICAgICAgICAgICAgICAg
ICAgICAgYWdwX2VuZDsKPiArICAgICAgIC8qIEdBUlQgYXBlcnR1cmUgc3RhcnQgYW5kIGVuZCBp
biBNQyBhZGRyZXNzIHNwYWNlCj4gKyAgICAgICAgKiBEcml2ZXIgZmluZCBhIGhvbGUgaW4gdGhl
IE1DIGFkZHJlc3Mgc3BhY2UKPiArICAgICAgICAqIHRvIHBsYWNlIEdBUlQgYnkgc2V0dGluZyBW
TV9DT05URVhUMF9QQUdFX1RBQkxFX1NUQVJUL0VORF9BRERSCj4gKyAgICAgICAgKiByZWdpc3Rl
cnMKPiArICAgICAgICAqIFVuZGVyIFZNSUQwLCBsb2dpY2FsIGFkZHJlc3MgaW5zaWRlIEdBUlQg
YXBlcnR1cmUgd2lsbAo+ICsgICAgICAgICogYmUgdHJhbnNsYXRlZCB0aHJvdWdoIGdwdXZtIGdh
cnQgcGFnZSB0YWJsZSB0byBhY2Nlc3MKPiArICAgICAgICAqIHBhZ2VkIHN5c3RlbSBtZW1vcnkK
PiArICAgICAgICAqLwo+ICAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgZ2FydF9zaXpl
Owo+ICAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgZ2FydF9zdGFydDsKPiAgICAgICAg
IHU2NCAgICAgICAgICAgICAgICAgICAgIGdhcnRfZW5kOwo+ICsgICAgICAgLyogRnJhbWUgYnVm
ZmVyIGFwZXJ0dXJlIG9mIHRoaXMgR1BVIGRldmljZS4gRGlmZmVyZW50IGZyb20KPiArICAgICAg
ICAqIGZiX3N0YXJ0IChzZWUgYmVsb3cpLCB0aGlzIG9ubHkgY292ZXJzIHRoZSBsb2NhbCBHUFUg
ZGV2aWNlLgo+ICsgICAgICAgICogRHJpdmVyIGdldCBmYl9zdGFydCBmcm9tIE1DX1ZNX0ZCX0xP
Q0FUSU9OX0JBU0UgKHNldCBieSB2YmlvcykKPiArICAgICAgICAqIGFuZCBjYWxjdWxhdGUgdnJh
bV9zdGFydCBvZiB0aGlzIGxvY2FsIGRldmljZSBieSBhZGRpbmcgYW4KPiArICAgICAgICAqIG9m
ZnNldCBpbnNpZGUgdGhlIFhHTUkgaGl2ZS4KPiArICAgICAgICAqLwo+ICAgICAgICAgdTY0ICAg
ICAgICAgICAgICAgICAgICAgdnJhbV9zdGFydDsKPiAgICAgICAgIHU2NCAgICAgICAgICAgICAg
ICAgICAgIHZyYW1fZW5kOwo+ICAgICAgICAgLyogRkIgcmVnaW9uICwgaXQncyBzYW1lIGFzIGxv
Y2FsIHZyYW0gcmVnaW9uIGluIHNpbmdsZSBHUFUsIGluIFhHTUkKPiAtLQo+IDIuNy40Cj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
