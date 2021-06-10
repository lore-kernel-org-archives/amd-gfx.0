Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F1C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A529C613B3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A529C613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9486EDE7;
	Thu, 10 Jun 2021 21:00:42 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CF16EDE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:00:41 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id u11so3590700oiv.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3is+BGZL8/9678eVDiplfm9nk5D6OdpkQWQ2XRZvFjg=;
 b=CXFHgzacy0e97+sqalocq81s55Krh5cNqdSIIK0vZkVVPwKTkzwxI4tuuAQuSX0Teg
 jb+l4gUaYYaUvUVs1j/Q+TfDwIM4j+0R+7qZBKDWov4MUY8VNpIq6sDQJXyz+u3Ymr2R
 2moHFGPvAE2TW8fsRUZDOvg3zWbDPPkKkk83WwtdK1dn9ZEyhefiWmrJgi9srBrSGCxx
 8QaLD5vq/T1PqVULv3TOwgcPSBLqWnQoaJT7+cLTCyqMaSzR0qnm+ZeNUt3elqypbg1F
 QF2dt9Mnwx+iVqQFbOUPTCw9vlkT/SYlCZEXKmNE9IEMgRMuNxNujoEcI5f/T3p3nDg+
 ycQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3is+BGZL8/9678eVDiplfm9nk5D6OdpkQWQ2XRZvFjg=;
 b=W8uEUw4zx8FtkmGec4BiwYDBP980rbBlbGb7v1wC3vPTTya57bD47KdjMJmirujwaL
 4vDsuW6uVA1REZnGXvqT4kxBGHR9CYs7FIfjHkQngqRmOoObKWp9VqG7i/f/FxVYiuaq
 t6W3tDCvz6a/xfFjd3G4GPtkeHZf9NUGp1M67LjMfKRmHrhXevYx3MjuOm0rZzpWBq92
 SevuEcPKi3QS2LiZcj9ZCmsegjycYKWeL6bgp7oFwf1IUD3UABox8ZLpYDKrLBhc1egX
 ukOXVslqdLB83ARBu6KHO5RGnvwcKgQrm5aqa76CIbjx3Tohbr+Ezw2A8fGpOeA3ZkTX
 ahWA==
X-Gm-Message-State: AOAM530QdKYTQL2BkSc2jjmWE5nVMN1gWn8KzWYtBrOjLImrcS18WZcu
 viyXSyG5xZ7c8pP2T8/LVmk48YxES93qxMO/lP8=
X-Google-Smtp-Source: ABdhPJz2axsRYFzoFgXCsOQECnwlz4uxdbKpzHJSpD14A/WT+iOtPICvmsMZhidflvlr6tql9+qB1E1mrR7VdRs7om0=
X-Received: by 2002:a05:6808:999:: with SMTP id
 a25mr245142oic.123.1623358840414; 
 Thu, 10 Jun 2021 14:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-24-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-24-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:00:29 -0400
Message-ID: <CADnq5_M-SVXkbdX6eDELN_E8ORJZgrNUquDsFdL8XG0+b8sbXg@mail.gmail.com>
Subject: Re: [PATCH 23/40] drm/amdgpu: Fix wrap-around bugs in RAS
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gOCwgMjAyMSBhdCA1OjQwIFBNIEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292
QGFtZC5jb20+IHdyb3RlOgo+Cj4gRml4IHRoZSBzaXplIG9mIHRoZSBFRVBST00gZnJvbSAyNTYw
MDAgYnl0ZXMKPiB0byAyNjIxNDQgYnl0ZXMgKDI1NiBLaUIpLgo+Cj4gRml4IGEgY291cGxlIG9y
IHdyYXAgYXJvdW5kIGJ1Z3MuIElmIGEgdmFsaWQKPiB2YWx1ZS9hZGRyZXNzIGlzIDAgPD0gYWRk
ciA8IHNpemUsIHRoZSBpbnZlcnNlIG9mCj4gdGhpcyBpbmVxdWFsaXR5IChiYXJyaW5nIG5lZ2F0
aXZlIHZhbHVlcyB3aGljaAo+IG1ha2Ugbm8gc2Vuc2UgaGVyZSkgaXMgYWRkciA+PSBzaXplLiBG
aXggdGhpcyBpbgo+IHRoZSBSQVMgY29kZS4KPgo+IENjOiBKZWFuIERlbHZhcmUgPGpkZWx2YXJl
QHN1c2UuZGU+Cj4gQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPgo+IENjOiBBbmRyZXkgR3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4K
PiBDYzogTGlqbyBMYXphciA8TGlqby5MYXphckBhbWQuY29tPgo+IENjOiBTdGFubGV5IFlhbmcg
PFN0YW5sZXkuWWFuZ0BhbWQuY29tPgo+IENjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1k
LmNvbT4KCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Cgo+IC0tLQo+ICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMgICAg
fCAyMCArKysrKysrKystLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhc19lZXByb20uYwo+IGluZGV4IGYzMTZmYjExYjE2ZDllLi4zZWYzOGI5MGZjM2E4
MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2Vl
cHJvbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXBy
b20uYwo+IEBAIC01MiwxMiArNTIsMTEgQEAKPiAgLyogQmFkIEdQVSB0YWcg4oCYQkFER+KAmSAq
Lwo+ICAjZGVmaW5lIEVFUFJPTV9UQUJMRV9IRFJfQkFEIDB4NDI0MTQ0NDcKPgo+IC0vKiBBc3N1
bWUgMiBNYml0IHNpemUgKi8KPiAtI2RlZmluZSBFRVBST01fU0laRV9CWVRFUyAyNTYwMDAKPiAt
I2RlZmluZSBFRVBST01fUEFHRV9fU0laRV9CWVRFUyAyNTYKPiAtI2RlZmluZSBFRVBST01fSERS
X1NUQVJUIDAKPiAtI2RlZmluZSBFRVBST01fUkVDT1JEX1NUQVJUIChFRVBST01fSERSX1NUQVJU
ICsgRUVQUk9NX1RBQkxFX0hFQURFUl9TSVpFKQo+IC0jZGVmaW5lIEVFUFJPTV9NQVhfUkVDT1JE
X05VTSAoKEVFUFJPTV9TSVpFX0JZVEVTIC0gRUVQUk9NX1RBQkxFX0hFQURFUl9TSVpFKSAvIEVF
UFJPTV9UQUJMRV9SRUNPUkRfU0laRSkKPiArLyogQXNzdW1lIDItTWJpdCBzaXplICovCj4gKyNk
ZWZpbmUgRUVQUk9NX1NJWkVfQllURVMgICAgICAgKDI1NiAqIDEwMjQpCj4gKyNkZWZpbmUgRUVQ
Uk9NX0hEUl9TVEFSVCAgICAgICAgMAo+ICsjZGVmaW5lIEVFUFJPTV9SRUNPUkRfU1RBUlQgICAg
IChFRVBST01fSERSX1NUQVJUICsgRUVQUk9NX1RBQkxFX0hFQURFUl9TSVpFKQo+ICsjZGVmaW5l
IEVFUFJPTV9NQVhfUkVDT1JEX05VTSAgICgoRUVQUk9NX1NJWkVfQllURVMgLSBFRVBST01fVEFC
TEVfSEVBREVSX1NJWkUpIC8gRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFKQo+Cj4gICNkZWZpbmUg
dG9fYW1kZ3B1X2RldmljZSh4KSAoY29udGFpbmVyX29mKHgsIHN0cnVjdCBhbWRncHVfcmFzLCBl
ZXByb21fY29udHJvbCkpLT5hZGV2Cj4KPiBAQCAtNDAyLDkgKzQwMSw4IEBAIHN0YXRpYyB1aW50
MzJfdCBfX2NvcnJlY3RfZWVwcm9tX2Rlc3RfYWRkcmVzcyh1aW50MzJfdCBjdXJyX2FkZHJlc3Mp
Cj4gICAgICAgICB1aW50MzJfdCBuZXh0X2FkZHJlc3MgPSBjdXJyX2FkZHJlc3MgKyBFRVBST01f
VEFCTEVfUkVDT1JEX1NJWkU7Cj4KPiAgICAgICAgIC8qIFdoZW4gYWxsIEVFUFJPTSBtZW1vcnkg
dXNlZCBqdW1wIGJhY2sgdG8gMCBhZGRyZXNzICovCj4gLSAgICAgICBpZiAobmV4dF9hZGRyZXNz
ID4gRUVQUk9NX1NJWkVfQllURVMpIHsKPiAtICAgICAgICAgICAgICAgRFJNX0lORk8oIlJlYWNo
ZWQgZW5kIG9mIEVFUFJPTSBtZW1vcnksIGp1bXBpbmcgdG8gMCAiCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICJhbmQgb3ZlcnJpZGluZyBvbGQgcmVjb3JkIik7Cj4gKyAgICAgICBpZiAobmV4
dF9hZGRyZXNzID49IEVFUFJPTV9TSVpFX0JZVEVTKSB7Cj4gKyAgICAgICAgICAgICAgIERSTV9J
TkZPKCJSZWFjaGVkIGVuZCBvZiBFRVBST00gbWVtb3J5LCB3cmFwIGFyb3VuZCB0byAwLiIpOwo+
ICAgICAgICAgICAgICAgICByZXR1cm4gRUVQUk9NX1JFQ09SRF9TVEFSVDsKPiAgICAgICAgIH0K
Pgo+IEBAIC00NzYsNyArNDc0LDkgQEAgaW50IGFtZGdwdV9yYXNfZWVwcm9tX3Byb2Nlc3NfcmVj
b2RzKHN0cnVjdCBhbWRncHVfcmFzX2VlcHJvbV9jb250cm9sICpjb250cm9sLAo+ICAgICAgICAg
fQo+Cj4gICAgICAgICAvKiBJbiBjYXNlIG9mIG92ZXJmbG93IGp1c3Qgc3RhcnQgZnJvbSBiZWdp
bm5pbmcgdG8gbm90IGxvc2UgbmV3ZXN0IHJlY29yZHMgKi8KPiAtICAgICAgIGlmICh3cml0ZSAm
JiAoY29udHJvbC0+bmV4dF9hZGRyICsgRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFICogbnVtID4g
RUVQUk9NX1NJWkVfQllURVMpKQo+ICsgICAgICAgaWYgKHdyaXRlICYmCj4gKyAgICAgICAgICAg
KGNvbnRyb2wtPm5leHRfYWRkciArCj4gKyAgICAgICAgICAgIEVFUFJPTV9UQUJMRV9SRUNPUkRf
U0laRSAqIG51bSA+PSBFRVBST01fU0laRV9CWVRFUykpCj4gICAgICAgICAgICAgICAgIGNvbnRy
b2wtPm5leHRfYWRkciA9IEVFUFJPTV9SRUNPUkRfU1RBUlQ7Cj4KPiAgICAgICAgIC8qCj4gLS0K
PiAyLjMyLjAKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
