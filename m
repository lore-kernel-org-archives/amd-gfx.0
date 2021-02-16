Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C66C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 15:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13CE64DF0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 15:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13CE64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6016E434;
	Tue, 16 Feb 2021 15:24:45 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A676E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 15:24:43 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id k204so11585343oih.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 07:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=konGv52blHEjPX0CQArl4p0UjVKzJJohBfzvinExEtk=;
 b=bM4DZhtKtMlOtLyJUTcs/BPXQtK6sLsCI2BYl3V5CBEjVD5HVAydvKtGnkRKTsEyjs
 nW+5JOuTphdLx3oZRRIKrIVSLIyFroe6JXGfPzEQvFpHH3cJcIPO2I0Aoqhpl9Oo7/cN
 ikHIB9BmVTfRk4Y5LA62C04+EGnXjskeyjYDWEqJbxEJz0ijCBX9PkIU6sb8Pkj2UaAX
 EVW3K+VIj8QeC2NuNYcTdSA60lYlfkm9pZy8qgVbgI0st9FdF/FCaH3yHicN4ofhd03t
 Pi1K9DE3f2xQxVMz5KN0hj9PZaJzFzEKzwqZ3U9AsiXpaA0yuxHbLKHFDurrl9IF1Qvh
 2B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=konGv52blHEjPX0CQArl4p0UjVKzJJohBfzvinExEtk=;
 b=oHhPrPNV4dcrJ/Nq2FH6N/u/topgvJbWl9CqqEBCD+JD1lSB5uq8eGVmOY+ClzcX7n
 9ZJkBId4BpXw8SOFEvu87xjMYssiKXZJx12cPmwXp72b7+3u4lmbIgjow47ghav+tMwU
 +lcCE/Zjjwe1Ly0t+/pMkUgmOMBN3G6dGFwvggOg39MpbsECwmk6TpqSvcxiQTx6UFSe
 wht1DHP7ehen2DQ8KwZjyHs3R1qo240xSHs/ertouOXQMC8LrsOXD6mHHWQKxZZeZzMP
 Zim2Cm67j4v9gVQqHLunLmnTGo2wMWYg7GdbzF9W8HAj/X+xx8auTTQ/GMen7XaPLONa
 mTsg==
X-Gm-Message-State: AOAM533r453MwqQJfIlcLg8M9NxVa5DheyyniyzFUYl2/lEy0w/2HJF7
 frEmsYYQSOkysU/Zu6oZF8HooNOTG5ogQVDOqCT4OZ3r
X-Google-Smtp-Source: ABdhPJzpSCGJY0uPleUu1IBYztnsThXLMTOJzhADE5JUJzbcdOsNyFSvE/EQI6PWxv6VWOXiNNoeFvaDp4wkfRkGsx0=
X-Received: by 2002:aca:c786:: with SMTP id x128mr2901725oif.120.1613489083091; 
 Tue, 16 Feb 2021 07:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20210216152216.50637-1-nirmoy.das@amd.com>
In-Reply-To: <20210216152216.50637-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Feb 2021 10:24:32 -0500
Message-ID: <CADnq5_M-+Z7KPqx2jrxxZ_-ZGD0Y4ZW6xr+YZm=Gyp=K=WT8fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/radeon: fix compilation error
To: Nirmoy Das <nirmoy.das@amd.com>
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
 Mark Broadworth <Mark.Broadworth@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBGZWIgMTYsIDIwMjEgYXQgMTA6MjIgQU0gTmlybW95IERhcyA8bmlybW95LmRhc0Bh
bWQuY29tPiB3cm90ZToKPgo+IEZpeGVzIGJlbG93IGNvbXBpbGF0aW9uIGVycm9yOgo+IGNvbmZs
aWN0aW5nIHR5cGVzIGZvciDigJhyMTAwX2RlYnVnZnNfbWNfaW5mb19pbml04oCZCj4KPiBGaXhl
czogNmY4NjcyZDY1MjNiZmUzOGUgKCJkcm0vcmFkZW9uOiBkbyBub3QgdXNlIGRybSBtaWRkbGUg
bGF5ZXIgZm9yCj4gZGVidWdmcyIpCj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95
LmRhc0BhbWQuY29tPgo+IFJlcG9ydGVkLWJ5OiBNYXJrIEJyb2Fkd29ydGggPE1hcmsuQnJvYWR3
b3J0aEBhbWQuY29tPgo+IC0tLQo+IEhpIEFsZXgsCj4KPiBDYW4geW91IHBsZWFzZSBzcXVhc2gg
dGhpcyB3aXRoIHRoZSAiRml4ZXMiIGNvbW1pdC4KPiBJIGFtIG5vdCBzdXJlIGhvdyBJIG1pc3Nl
ZCBpdC4KPiBJIGV2ZW4gdGVzdGVkIHRoZSBwYXRjaCB3aXRoIG15IHJhZGVvbiBjYXJkIGJlZm9y
ZSBwdXNoaW5nLgoKU3VyZS4KCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjMwMC5jICAgICAgICB8
IDYgKy0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2FzaWMuaCB8IDIgKy0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMzAwLmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3IzMDAuYwo+IGluZGV4IDAzYjBkNGE4MWY3YS4uOTI2NDNkZmRkOGE4IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjMwMC5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yMzAwLmMKPiBAQCAtMTMyNiwxMiArMTMyNiw4IEBAIHZvaWQgcjMwMF9z
ZXRfcmVnX3NhZmUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gIHZvaWQgcjMwMF9tY19w
cm9ncmFtKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qg
cjEwMF9tY19zYXZlIHNhdmU7Cj4gLSAgICAgICBpbnQgcjsKPgo+IC0gICAgICAgciA9IHIxMDBf
ZGVidWdmc19tY19pbmZvX2luaXQocmRldik7Cj4gLSAgICAgICBpZiAocikgewo+IC0gICAgICAg
ICAgICAgICBkZXZfZXJyKHJkZXYtPmRldiwgIkZhaWxlZCB0byBjcmVhdGUgcjEwMF9tYyBkZWJ1
Z2ZzIGZpbGUuXG4iKTsKPiAtICAgICAgIH0KPiArICAgICAgIHIxMDBfZGVidWdmc19tY19pbmZv
X2luaXQocmRldik7Cj4KPiAgICAgICAgIC8qIFN0b3BzIGFsbCBtYyBjbGllbnRzICovCj4gICAg
ICAgICByMTAwX21jX3N0b3AocmRldiwgJnNhdmUpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9hc2ljLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9hc2ljLmgKPiBpbmRleCAyYzc3ZjE1MWVmNjIuLjFjZjJhNWUwZDkxZCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hc2ljLmgKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9hc2ljLmgKPiBAQCAtMTA4LDcgKzEwOCw3IEBAIGludCByMTAw
X3BjaV9nYXJ0X2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICB2b2lkIHIxMDBf
cGNpX2dhcnRfZmluaShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIGludCByMTAwX3Bj
aV9nYXJ0X2VuYWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIHZvaWQgcjEwMF9w
Y2lfZ2FydF9kaXNhYmxlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAtaW50IHIxMDBf
ZGVidWdmc19tY19pbmZvX2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICt2b2lk
ICByMTAwX2RlYnVnZnNfbWNfaW5mb19pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsK
PiAgaW50IHIxMDBfZ3VpX3dhaXRfZm9yX2lkbGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYp
Owo+ICBpbnQgcjEwMF9pYl90ZXN0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBzdHJ1Y3Qg
cmFkZW9uX3JpbmcgKnJpbmcpOwo+ICB2b2lkIHIxMDBfaXJxX2Rpc2FibGUoc3RydWN0IHJhZGVv
bl9kZXZpY2UgKnJkZXYpOwo+IC0tCj4gMi4zMC4wCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
