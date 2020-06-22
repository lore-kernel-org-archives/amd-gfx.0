Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F94C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 14:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EAC20720
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WIaGQZFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EAC20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9A889EEB;
	Mon, 22 Jun 2020 14:23:13 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C2489EEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 14:23:12 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id u23so13168635otq.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WyXZWmBpbzEo+Phm6ZvRFTBhULTv1iYromZnyvkMduE=;
 b=WIaGQZFaYtrpZQVpp88VLhJOkqa/Rxo5eYPQTFi558vrLuIvRzeLZ+nzTzAmG0kdri
 h9kg6PCxM2ENTvBUA/8a/3vc3AY5BjEw7K3bxWuSNLvZlE/+ZK1Sg8obMHTlpvg1rDjP
 Y3+GGtCfV3HsqyypVEl4b+Cp6tobrGShCkv2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WyXZWmBpbzEo+Phm6ZvRFTBhULTv1iYromZnyvkMduE=;
 b=gkPOnnzVF+6MLjt9ajlnMkJrXShatU93BB8O9viMAzkQwb+TmKuyRFx2LbYVEVRWVP
 C+XKK92uRVoS4e4whTZ6E2XocHrf+FLwH64SvnT3oPB2MhZ5LGShEdKuXmiLA8UhONUv
 WuTg3oYXu9duVDAazOCptt/DlZuz3XYBZ8xcC/Nvxa2OybPGYLv2ia2BVCFNeD/t7TZQ
 JbmtD/5H/XNSHcbS8qvWC0DceOk8DQHUZ+kt4UFxT6lX2zc9/TZRk6ywhlXRdvWSvk0b
 7UmuU7AztCdenRFk8KtIdc71cvDKdw/YC92b0FYBordkQq/bFovKcfdmVOmBwaIbBZTQ
 nX3g==
X-Gm-Message-State: AOAM531HRtGgtS9QjZoGC89JkFFqKgZrFz8eTTl0OmnnltCOmv3Ax24g
 R6KcpjjXyGt+BR5j/0tg1ch0zOeVbx2OuijLkrFRnA==
X-Google-Smtp-Source: ABdhPJxJVNdtFnys0+kG3cqaZy+Y0cB1s+N36TWZE3WOri9YJcGHU6DAkaniOnNyg6+IHsaPJNkGTEcVR8plhXafalQ=
X-Received: by 2002:a05:6830:54:: with SMTP id
 d20mr14982897otp.281.1592835791884; 
 Mon, 22 Jun 2020 07:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-2-git-send-email-andrey.grodzovsky@amd.com>
 <6809de08-2035-edda-ebd2-05e7f77a1068@gmail.com>
In-Reply-To: <6809de08-2035-edda-ebd2-05e7f77a1068@gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 22 Jun 2020 16:23:00 +0200
Message-ID: <CAKMK7uG9UyFyD22tf0-k28UbK2drP=VEAhsN3fNkQznYPrG3nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm: Add dummy page per device or GEM object
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gMjIsIDIwMjAgYXQgMzoxOCBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAyMS4wNi4yMCB1bSAwODow
MyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+ID4gV2lsbCBiZSB1c2VkIHRvIHJlcm91dGUg
Q1BVIG1hcHBlZCBCTydzIHBhZ2UgZmF1bHRzIG9uY2UKPiA+IGRldmljZSBpcyByZW1vdmVkLgo+
ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNr
eUBhbWQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9kcm1fZmlsZS5jICB8ICA4
ICsrKysrKysrCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9kcm1fcHJpbWUuYyB8IDEwICsrKysrKysr
KysKPiA+ICAgaW5jbHVkZS9kcm0vZHJtX2ZpbGUuaCAgICAgIHwgIDIgKysKPiA+ICAgaW5jbHVk
ZS9kcm0vZHJtX2dlbS5oICAgICAgIHwgIDIgKysKPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZmls
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9maWxlLmMKPiA+IGluZGV4IGM0YzcwNGUuLjY3YzA3
NzAgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZpbGUuYwo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9maWxlLmMKPiA+IEBAIC0xODgsNiArMTg4LDEyIEBAIHN0cnVj
dCBkcm1fZmlsZSAqZHJtX2ZpbGVfYWxsb2Moc3RydWN0IGRybV9taW5vciAqbWlub3IpCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfcHJpbWVfZGVzdHJveTsKPiA+ICAgICAgIH0K
PiA+Cj4gPiArICAgICBmaWxlLT5kdW1teV9wYWdlID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMIHwg
X19HRlBfWkVSTyk7Cj4gPiArICAgICBpZiAoIWZpbGUtPmR1bW15X3BhZ2UpIHsKPiA+ICsgICAg
ICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiA+ICsgICAgICAgICAgICAgZ290byBvdXRfcHJpbWVf
ZGVzdHJveTsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICAgICAgIHJldHVybiBmaWxlOwo+ID4KPiA+
ICAgb3V0X3ByaW1lX2Rlc3Ryb3k6Cj4gPiBAQCAtMjg0LDYgKzI5MCw4IEBAIHZvaWQgZHJtX2Zp
bGVfZnJlZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGUpCj4gPiAgICAgICBpZiAoZGV2LT5kcml2ZXIt
PnBvc3RjbG9zZSkKPiA+ICAgICAgICAgICAgICAgZGV2LT5kcml2ZXItPnBvc3RjbG9zZShkZXYs
IGZpbGUpOwo+ID4KPiA+ICsgICAgIF9fZnJlZV9wYWdlKGZpbGUtPmR1bW15X3BhZ2UpOwo+ID4g
Kwo+ID4gICAgICAgZHJtX3ByaW1lX2Rlc3Ryb3lfZmlsZV9wcml2YXRlKCZmaWxlLT5wcmltZSk7
Cj4gPgo+ID4gICAgICAgV0FSTl9PTighbGlzdF9lbXB0eSgmZmlsZS0+ZXZlbnRfbGlzdCkpOwo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fcHJpbWUuYyBiL2RyaXZlcnMvZ3B1
L2RybS9kcm1fcHJpbWUuYwo+ID4gaW5kZXggMWRlMmNkZS4uYzQ4MmU5YyAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fcHJpbWUuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2RybV9wcmltZS5jCj4gPiBAQCAtMzM1LDYgKzMzNSwxMyBAQCBpbnQgZHJtX2dlbV9wcmltZV9m
ZF90b19oYW5kbGUoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKPiA+Cj4gPiAgICAgICByZXQgPSBk
cm1fcHJpbWVfYWRkX2J1Zl9oYW5kbGUoJmZpbGVfcHJpdi0+cHJpbWUsCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgZG1hX2J1ZiwgKmhhbmRsZSk7Cj4gPiArCj4gPiArICAgICBpZiAoIXJldCkg
ewo+ID4gKyAgICAgICAgICAgICBvYmotPmR1bW15X3BhZ2UgPSBhbGxvY19wYWdlKEdGUF9LRVJO
RUwgfCBfX0dGUF9aRVJPKTsKPiA+ICsgICAgICAgICAgICAgaWYgKCFvYmotPmR1bW15X3BhZ2Up
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiA+ICsgICAgIH0KPiA+
ICsKPgo+IFdoaWxlIHRoZSBwZXIgZmlsZSBjYXNlIHN0aWxsIGxvb2tzIGFjY2VwdGFibGUgdGhp
cyBpcyBhIGNsZWFyIE5BSyBzaW5jZQo+IGl0IHdpbGwgbWFzc2l2ZWx5IGluY3JlYXNlIHRoZSBt
ZW1vcnkgbmVlZGVkIGZvciBhIHByaW1lIGV4cG9ydGVkIG9iamVjdC4KPgo+IEkgdGhpbmsgdGhh
dCB0aGlzIGlzIHF1aXRlIG92ZXJraWxsIGluIHRoZSBmaXJzdCBwbGFjZSBhbmQgZm9yIHRoZSBo
b3QKPiB1bnBsdWcgY2FzZSB3ZSBjYW4ganVzdCB1c2UgdGhlIGdsb2JhbCBkdW1teSBwYWdlIGFz
IHdlbGwuCgpJbW8gd2UgZWl0aGVyIGRvbid0IGJvdGhlciB3aXRoIHBlci1maWxlIGR1bW15IHBh
Z2UsIG9yIHdlIG5lZWQgdGhpcy4KSGFsZi13YXkgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UsIHNp
bmNlIGZvciBhbnl0aGluZyB5b3UgZG1hLWJ1ZgpleHBvcnRlZCB5b3UgaGF2ZSBubyBpZGVhIHdo
ZXRoZXIgaXQgbGVmdCBhIHNhbmRib3ggb3Igbm90LgoKRS5nLiBhbnl0aGluZyB0aGF0J3Mgc2hh
cmVkIGJldHdlZW4gY2xpZW50L2NvbXBvc2l0b3IgaGFzIGEgZGlmZmVyZW50CnNlY3VyaXR5IGNv
bnRleHQsIHNvIHBpY2tpbmcgdGhlIGR1bW15IHBhZ2Ugb2YgZWl0aGVyIGlzIHRoZSB3cm9uZwp0
aGluZy4KCklmIHlvdSdyZSB3b3JyaWVkIGFib3V0IHRoZSBvdmVyaGVhZCB3ZSBjYW4gYWxzbyBh
bGxvY2F0ZSB0aGUgZHVtbXkKcGFnZSBvbiBkZW1hbmQsIGFuZCBTSUdCVVMgaWYgd2UgY2FuJ3Qg
YWxsb2NhdGUgdGhlIHJpZ2h0IG9uZS4gVGhlbiB3ZQpqdXN0IG5lZWQgdG8gdHJhY2sgd2hldGhl
ciBhIGJ1ZmZlciBoYXMgZXZlciBiZWVuIGV4cG9ydGVkLgotRGFuaWVsCgo+Cj4gQ2hyaXN0aWFu
Lgo+Cj4gPiAgICAgICBtdXRleF91bmxvY2soJmZpbGVfcHJpdi0+cHJpbWUubG9jayk7Cj4gPiAg
ICAgICBpZiAocmV0KQo+ID4gICAgICAgICAgICAgICBnb3RvIGZhaWw7Cj4gPiBAQCAtMTAwNiw2
ICsxMDEzLDkgQEAgdm9pZCBkcm1fcHJpbWVfZ2VtX2Rlc3Ryb3koc3RydWN0IGRybV9nZW1fb2Jq
ZWN0ICpvYmosIHN0cnVjdCBzZ190YWJsZSAqc2cpCj4gPiAgICAgICAgICAgICAgIGRtYV9idWZf
dW5tYXBfYXR0YWNobWVudChhdHRhY2gsIHNnLCBETUFfQklESVJFQ1RJT05BTCk7Cj4gPiAgICAg
ICBkbWFfYnVmID0gYXR0YWNoLT5kbWFidWY7Cj4gPiAgICAgICBkbWFfYnVmX2RldGFjaChhdHRh
Y2gtPmRtYWJ1ZiwgYXR0YWNoKTsKPiA+ICsKPiA+ICsgICAgIF9fZnJlZV9wYWdlKG9iai0+ZHVt
bXlfcGFnZSk7Cj4gPiArCj4gPiAgICAgICAvKiByZW1vdmUgdGhlIHJlZmVyZW5jZSAqLwo+ID4g
ICAgICAgZG1hX2J1Zl9wdXQoZG1hX2J1Zik7Cj4gPiAgIH0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2RybS9kcm1fZmlsZS5oIGIvaW5jbHVkZS9kcm0vZHJtX2ZpbGUuaAo+ID4gaW5kZXggMTlk
ZjgwMi4uMzQ5YTY1OCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvZHJtL2RybV9maWxlLmgKPiA+
ICsrKyBiL2luY2x1ZGUvZHJtL2RybV9maWxlLmgKPiA+IEBAIC0zMzUsNiArMzM1LDggQEAgc3Ry
dWN0IGRybV9maWxlIHsKPiA+ICAgICAgICAqLwo+ID4gICAgICAgc3RydWN0IGRybV9wcmltZV9m
aWxlX3ByaXZhdGUgcHJpbWU7Cj4gPgo+ID4gKyAgICAgc3RydWN0IHBhZ2UgKmR1bW15X3BhZ2U7
Cj4gPiArCj4gPiAgICAgICAvKiBwcml2YXRlOiAqLwo+ID4gICAjaWYgSVNfRU5BQkxFRChDT05G
SUdfRFJNX0xFR0FDWSkKPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgbG9ja19jb3VudDsgLyogRFJJ
MSBsZWdhY3kgbG9jayBjb3VudCAqLwo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9n
ZW0uaCBiL2luY2x1ZGUvZHJtL2RybV9nZW0uaAo+ID4gaW5kZXggMGIzNzUwNi4uNDc0NjBkMSAx
MDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvZHJtL2RybV9nZW0uaAo+ID4gKysrIGIvaW5jbHVkZS9k
cm0vZHJtX2dlbS5oCj4gPiBAQCAtMzEwLDYgKzMxMCw4IEBAIHN0cnVjdCBkcm1fZ2VtX29iamVj
dCB7Cj4gPiAgICAgICAgKgo+ID4gICAgICAgICovCj4gPiAgICAgICBjb25zdCBzdHJ1Y3QgZHJt
X2dlbV9vYmplY3RfZnVuY3MgKmZ1bmNzOwo+ID4gKwo+ID4gKyAgICAgc3RydWN0IHBhZ2UgKmR1
bW15X3BhZ2U7Cj4gPiAgIH07Cj4gPgo+ID4gICAvKioKPgoKCi0tIApEYW5pZWwgVmV0dGVyClNv
ZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
