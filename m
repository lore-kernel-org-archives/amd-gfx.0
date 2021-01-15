Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70640C433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304172388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304172388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A3D6E45E;
	Fri, 15 Jan 2021 15:08:47 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EE86E241
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 11:21:11 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id e15so882955wme.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 03:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=N6uydng3TnvqnckF/CPFf5kyUc/6RUvK2FCorvNIeR0=;
 b=JLJDeS6NKIsZLjFbj00lo6b56D93RljqHLRy1Gnwj8xGMK3ZB7mj05zQFXrX4uE9nC
 cD9+lSisxJmUQ69ph4o3Jui/BOUoHQrPuVZED4BCWxz8bHmdEeYJ9x89i4hERnWB87Eq
 xwACZ3EjMbvUkKnRWRGWQmWWN+7YdqEwKivrqDQdKtYUlTKhjgDg03XpcSRePfaqdqTK
 tCByeN+UMcf5kYJ78R2fdlKuS51LaLJqnVt6niMzHf//ShCy2oJVGbc0943KjVnmn4iB
 rJ5vzBKupIGMOVcXC1f9uug5cmht5tajAmo+THvSf64EwqUlr+y8jQeQ1YY9b+fieHEW
 KZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=N6uydng3TnvqnckF/CPFf5kyUc/6RUvK2FCorvNIeR0=;
 b=Bu0dslABWLhFC5BJm/1KpxPP7YRr3hCubVCJnZmFUhOXZqG40u1nJjalWD0eGAGPmy
 th5zpIaap1Z7XmMJrDu4+5myA8Sw6Eb1uT5KEQkzywjd50k34/SvwAEctjIWR+G0O7uD
 V2oFUf8A8z7TIrl99ZP/DdmctPdhQog8BqeYqBYx3qVMOnWMRbjJ8phYbsz8ssbMV+jr
 oh+ZJetuHeknMbbb+a5dpZegXH+CjQrBAb+ca61Jf6oPc2tKrAxa69SSNsbiE4PIomOn
 5wb3oKB8Bknnh7RE17N4+Yb+ilpqdUvR5cnzdsvroQFFazH8fDhxnlRTUpHGlZcSNCo3
 8Riw==
X-Gm-Message-State: AOAM530aQHYjWXPWHmFxi6yohhHvGLNgf/GQmgkglFArc6Nxl1KxEEZk
 mqQeOlD3hMRR4/4VwGH/lGrEOQ==
X-Google-Smtp-Source: ABdhPJxnU7RYKT99lVTSgmdKVyBSdUgdsKZI6oZE1EeKDVVgN3uhOEJ5c+NN6StdON4gWExBXEjjww==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr8221713wme.137.1610709669848; 
 Fri, 15 Jan 2021 03:21:09 -0800 (PST)
Received: from dell ([91.110.221.158])
 by smtp.gmail.com with ESMTPSA id m82sm12657489wmf.29.2021.01.15.03.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 03:21:09 -0800 (PST)
Date: Fri, 15 Jan 2021 11:21:07 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix the system memory page fault
 because of copy overflow
Message-ID: <20210115112107.GI3975472@dell>
References: <20210115184658.513045-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115184658.513045-1-ray.huang@amd.com>
X-Mailman-Approved-At: Fri, 15 Jan 2021 15:08:45 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>,
 changfeng.zhu@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAxNiBKYW4gMjAyMSwgSHVhbmcgUnVpIHdyb3RlOgoKPiBUaGUgYnVmZmVyIGlzIGFs
bG9jYXRlZCB3aXRoIHRoZSBzaXplIG9mIHBvaW50ZXIgYW5kIGNvcHkgd2l0aCB0aGUgc2l6ZSBv
Zgo+IGRhdGEgc3RydWN0dXJlLiBUaGVuIHRyaWdnZXIgdGhlIHN5c3RlbSBtZW1vcnkgcGFnZSBm
YXVsdC4gVXNlIHRoZQo+IG9yaWduYWwgZGF0YSBzdHJ1Y3R1cmUgdG8gZ2V0IHRoZSBvYmplY3Qg
c2l6ZS4KPiAKPiBGaXhlczogYThlMzAwMDViIGRybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bms6IE1vdmUgc29tZSBsb2NhbCBkYXRhCj4gZnJvbSB0aGUgc3RhY2sgdG8gdGhlIGhlYXAKPiAK
PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IENjOiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCj4gaW5kZXggNjk1NzNkNjcwNTZkLi43MzE3ODk3
OGFlNzQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGluay5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
bGluay5jCj4gQEAgLTEzODAsNyArMTM4MCw3IEBAIHN0YXRpYyBib29sIGRjX2xpbmtfY29uc3Ry
dWN0KHN0cnVjdCBkY19saW5rICpsaW5rLAo+ICAKPiAgCURDX0xPR0dFUl9JTklUKGRjX2N0eC0+
bG9nZ2VyKTsKPiAgCj4gLQlpbmZvID0ga3phbGxvYyhzaXplb2YoaW5mbyksIEdGUF9LRVJORUwp
OwoKQWggc29ycnksIHRoaXMgc2hvdWxkIGJlICgqaW5mbykuCgo+ICsJaW5mbyA9IGt6YWxsb2Mo
c2l6ZW9mKHN0cnVjdCBpbnRlZ3JhdGVkX2luZm8pLCBHRlBfS0VSTkVMKTsKClVzaW5nIHRoZSBm
dWxsIG5hbWUgbGlrZSB0aGlzIGlzIHVzdWFsbHkgZGlzY291cmFnZWQuCgo+ICAJaWYgKCFpbmZv
KQo+ICAJCWdvdG8gY3JlYXRlX2ZhaWw7Cj4gIAo+IEBAIC0xNTQ1LDcgKzE1NDUsNyBAQCBzdGF0
aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNfbGluayAqbGluaywKPiAgCX0KPiAg
Cj4gIAlpZiAoYmlvcy0+aW50ZWdyYXRlZF9pbmZvKQo+IC0JCW1lbWNweShpbmZvLCBiaW9zLT5p
bnRlZ3JhdGVkX2luZm8sIHNpemVvZigqaW5mbykpOwoKVGhpcyBzaG91bGQgYmUgY29ycmVjdC4K
Cj4gKwkJbWVtY3B5KGluZm8sIGJpb3MtPmludGVncmF0ZWRfaW5mbywgc2l6ZW9mKHN0cnVjdCBp
bnRlZ3JhdGVkX2luZm8pKTsKPiAgCj4gIAkvKiBMb29rIGZvciBjaGFubmVsIG1hcHBpbmcgY29y
cmVzcG9uZGluZyB0byBjb25uZWN0b3IgYW5kIGRldmljZSB0YWcgKi8KPiAgCWZvciAoaSA9IDA7
IGkgPCBNQVhfTlVNQkVSX09GX0VYVF9ESVNQTEFZX1BBVEg7IGkrKykgewoKLS0gCkxlZSBKb25l
cyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMK
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBM
aW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
