Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21BCC54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 15:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B361920857
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSzbaYxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B361920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746076E88C;
	Thu, 23 Apr 2020 15:07:12 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2596E88C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 15:07:11 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id x25so6793199wmc.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8ncbJWKV+rNcTdK+KVuKp4j0fLygGSVmRZe31lBGcKY=;
 b=YSzbaYxDkZGVLqe44UsM3mezPajFn2VxRCROA7+DqqX/OwmY1XtgrVirq0EJEJ7afk
 SmVx4V83grO5OMJ26eCMzWvq50nl4wtMtft0v9itxmfeNOZQWVonku7Dd2GJloh6zqB0
 pOfiTKw7xfO9/9g6nBDjEcssRvtfVVIDHr9acgikIv7pnGVPn1qCoXD/ezCeygJfoVv5
 XFHNa2bNciPjag7Tqpr2XxpN2uZbp1Pg1qWjgx7/iSExMI/Q32/QvVTX0CsQuLFVLfXD
 jvxI5MA9zBbZ78dALwKFvjgihlLjW6ua6MrFMeNKV5YAgkzAxLRNbnrh/S9k1z8TK3lq
 tlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8ncbJWKV+rNcTdK+KVuKp4j0fLygGSVmRZe31lBGcKY=;
 b=P+wSkAo+8YIczUZ0vB81wze5Nnvy5/Eo3niJujZyYVKq0Amjxfrf3uxeafvZ6tWFqr
 2uesvuFpFt++OdnqfduRsuCuTKDhstlioPYRl5yESQgoDod8dsUnQyDflXbIGxsvfnSa
 YlnOvwH6eCMlqRpqXBHsqJY8Z4RsuK0CN/ucanwLo44PqWyIHVGMY9PGaxRBHf/Tw7XQ
 l4bNtRWXfPyhMhKhtA7z10dJxxhbog/cl/e5lICj5jRYDhiXKPUZnfBdKN1HR10r2aIB
 dDu2RLNsNbad1EoR7yXl5AtffTPfJ2M4uzUGRUINQvwgh04jKnSspyP+EnnGDMXTQ+h5
 uz2w==
X-Gm-Message-State: AGi0PuYshuy13qf5dcWqOM3PPdFlaMfDtM1wUhlNFDGtgEaFZkvMxENg
 SGxfMVPJnao5yAL+L7b/v7LyRQMz3SDWEpfjFFE=
X-Google-Smtp-Source: APiQypLFNbtFXKgyRMOwxgbAoPEwz8L8gVbuEXe93zj+Ut2PMYoZbJVs3p0UFR770MK4P81GvvLfOMo9Jr6dHuRZFaI=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr4724039wme.79.1587654430096; 
 Thu, 23 Apr 2020 08:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
 <fe584171-c45f-4b97-f141-5f2a516a88c2@gmail.com>
 <DM6PR12MB4075AD71C58D06670395B0EAFCD30@DM6PR12MB4075.namprd12.prod.outlook.com>
 <16fa3733-d478-ab23-57e9-80eb853c3790@gmail.com>
In-Reply-To: <16fa3733-d478-ab23-57e9-80eb853c3790@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Apr 2020 11:06:58 -0400
Message-ID: <CADnq5_NMRz4btHRQkb6ityRG=6Ew+STQeRDoawgEmuc5=U=MkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: stop cp resume when compute ring test
 failed
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBBcHIgMjMsIDIwMjAgYXQgMTA6NTUgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gWWVhaCwgd2UgY2VydGFpbmx5
IGNvdWxkIHRyeSB0aGlzIGFnYWluLiBCdXQgbWF5YmUgc3BsaXQgdGhhdCB1cCBpbnRvCj4gaW5k
aXZpZHVhbCBwYXRjaGVzIGZvciBnZng3LzgvOS4KPgo+IEluIG90aGVyIHdvcmRzIG1ha2UgaXQg
ZWFzeSB0byByZXZlcnQgaWYgdGhpcyBzdGlsbCBkb2Vzbid0IHdvcmsgd2VsbCBvbgo+IGdmeDcg
b3Igc29tZSBvdGhlciBnZW5lcmF0aW9uLgoKWWVhaCwgdW5sZXNzIHRoZXJlIGlzIGEgZ29vZCBy
ZWFzb24sIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGRvIHRoaXMuCklJUkMsIGNvbXB1dGUgcmlu
Z3MgcmFuZG9tbHkgZmFpbCB0byByZWNvdmVyIG9uIGEgbG90IG9mIGh3CmdlbmVyYXRpb25zLgoK
QWxleAoKPgo+IENocmlzdGlhbi4KPgo+IEFtIDIzLjA0LjIwIHVtIDE1OjQzIHNjaHJpZWIgWmhh
bmcsIEhhd2tpbmc6Cj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJp
YnV0aW9uIE9ubHldCj4gPgo+ID4gV291bGQgeW91IG1pbmQgdG8gZW5hYmxlIHRoaXMgYW5kIHRy
eSBpdCBhZ2Fpbj8gVGhlIHJlY2VudCBncHUgcmVzZXQgdGVzdGluZyBvbiB2ZWdhMjAgbG9va3Mg
dmVyeSBwb3NpdGl2ZS4KPiA+Cj4gPiBSZWdhcmRzLAo+ID4gSGF3a2luZwo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVp
Y2h0enVtZXJrZW5AZ21haWwuY29tPgo+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIw
IDIwOjMxCj4gPiBUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0g
ZHJtL2FtZGdwdTogc3RvcCBjcCByZXN1bWUgd2hlbiBjb21wdXRlIHJpbmcgdGVzdCBmYWlsZWQK
PiA+Cj4gPiBBbSAyMy4wNC4yMCB1bSAxMTowMSBzY2hyaWViIEhhd2tpbmcgWmhhbmc6Cj4gPj4g
ZHJpdmVyIHNob3VsZCBzdG9wIGNwIHJlc3VtZSBvbmNlIGNvbXB1dGUgcmluZyB0ZXN0IGZhaWxl
ZAo+ID4gTWhtIGludGVudGlvbmFsbHkgaWdub3JlZCB0aG9zZSBlcnJvcnMgYmVjYXVzZSB0aGUg
Y29tcHV0ZSByaW5ncyBzb21ldGltZXMgZG9lc24ndCBjb21lIHVwIGFnYWluIGFmdGVyIGEgR1BV
IHJlc2V0Lgo+ID4KPiA+IFdlIGV2ZW4gaGF2ZSB0aGUgbmVjZXNzYXJ5IGxvZ2ljIGluIHRoZSBT
VyBzY2hlZHVsZXIgdG8gcmVkaXJlY3QgdGhlIGpvYnMgdG8gYW5vdGhlciBjb21wdXRlIHJpbmcg
d2hlbiBvbmUgZmFpbHMgdG8gY29tZSB1cCBhZ2Fpbi4KPiA+Cj4gPiBDaHJpc3RpYW4uCj4gPgo+
ID4+IENoYW5nZS1JZDogSTRjZDMzMjhmMzhlMDc1NWQwYzg3NzQ4NDkzNjEzMmQyMDRjOWZlNTAK
PiA+PiBTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
Cj4gPj4gLS0tCj4gPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYyB8
IDQgKysrLQo+ID4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgfCA0
ICsrKy0KPiA+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgNCAr
KystCj4gPj4gICAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuYwo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYwo+ID4+
IGluZGV4IGIyZjEwZTMuLmZjZWU3NTggMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYwo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92N18wLmMKPiA+PiBAQCAtMzEzMiw3ICszMTMyLDkgQEAgc3RhdGljIGludCBnZnhf
djdfMF9jcF9jb21wdXRlX3Jlc3VtZShzdHJ1Y3QKPiA+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+
ID4+Cj4gPj4gICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9jb21wdXRlX3Jpbmdz
OyBpKyspIHsKPiA+PiAgICAgICAgICAgICAgcmluZyA9ICZhZGV2LT5nZnguY29tcHV0ZV9yaW5n
W2ldOwo+ID4+IC0gICAgICAgICAgICBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsKPiA+
PiArICAgICAgICAgICAgciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKHJpbmcpOwo+ID4+ICsg
ICAgICAgICAgICBpZiAocikKPiA+PiArICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsKPiA+
PiAgICAgIH0KPiA+Pgo+ID4+ICAgICAgcmV0dXJuIDA7Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMKPiA+PiBpbmRleCA2YzU2Y2VkLi44ZGM4ZTkwIDEwMDY0NAo+
ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPiA+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4gPj4gQEAgLTQ3ODEsNyAr
NDc4MSw5IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfY3BfdGVzdF9hbGxfcmluZ3Moc3RydWN0Cj4g
Pj4gYW1kZ3B1X2RldmljZSAqYWRldikKPiA+Pgo+ID4+ICAgICAgZm9yIChpID0gMDsgaSA8IGFk
ZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5nczsgaSsrKSB7Cj4gPj4gICAgICAgICAgICAgIHJpbmcg
PSAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXTsKPiA+PiAtICAgICAgICAgICAgYW1kZ3B1X3Jp
bmdfdGVzdF9oZWxwZXIocmluZyk7Cj4gPj4gKyAgICAgICAgICAgIHIgPSBhbWRncHVfcmluZ190
ZXN0X2hlbHBlcihyaW5nKTsKPiA+PiArICAgICAgICAgICAgaWYgKHIpCj4gPj4gKyAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHI7Cj4gPj4gICAgICB9Cj4gPj4KPiA+PiAgICAgIHJldHVybiAw
Owo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
Cj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gPj4gaW5kZXgg
MDlhYTVmNS4uMjA5MzcwNTkgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYwo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMKPiA+PiBAQCAtMzg0Niw3ICszODQ2LDkgQEAgc3RhdGljIGludCBnZnhfdjlfMF9j
cF9yZXN1bWUoc3RydWN0Cj4gPj4gYW1kZ3B1X2RldmljZSAqYWRldikKPiA+Pgo+ID4+ICAgICAg
Zm9yIChpID0gMDsgaSA8IGFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5nczsgaSsrKSB7Cj4gPj4g
ICAgICAgICAgICAgIHJpbmcgPSAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXTsKPiA+PiAtICAg
ICAgICAgICAgYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7Cj4gPj4gKyAgICAgICAgICAg
IHIgPSBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsKPiA+PiArICAgICAgICAgICAgaWYg
KHIpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4gPj4gICAgICB9Cj4gPj4K
PiA+PiAgICAgIGdmeF92OV8wX2VuYWJsZV9ndWlfaWRsZV9pbnRlcnJ1cHQoYWRldiwgdHJ1ZSk7
Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
