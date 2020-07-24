Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0CAC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 17:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD54206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 17:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1QRkHyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD54206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A955D6E9DE;
	Fri, 24 Jul 2020 17:45:14 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179406E158
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 17:33:52 +0000 (UTC)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so5668979pjb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6fXu93/1jlX07Hr4lqHKy5c8vfIRiF2jqmKmeTYOgAM=;
 b=Q1QRkHycMk52/bKVqxlla4kawMVY7rJ9Glz8gLDV/8MbzJ1hbsWxA2Nvw14uWnHUyR
 7i0ZEaE+GxwOv5WddwQKgaFbyK/Zqqm89mDtGLrSm4Eo9MCONhkoAcHQdJYOautUQtIl
 BrY8mEeiP/cjryNq+KgqmCIVo1Ikw2cnJeoJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6fXu93/1jlX07Hr4lqHKy5c8vfIRiF2jqmKmeTYOgAM=;
 b=M2wxmkoqnLDn5Wz7T4L+UXxLi3g6ANXxvEiE8nZlzRfEYhVPsYPLmttgYQ254JIjWI
 ayppitNJX3qKH2B5H02bu/zwi1n2KpJjmfHFglcyFp3VB/v8IDIKxpWK4d9U9mU7qvNq
 Uis1jJweX4cXnIhaCllqV7yYU7L3oyv5YnsyJcmdxwkwo10/z7u73MfzQinA+xqcXBIh
 54pS8QdAlmwIX09/41bYeJmwb7/hkOeo05W4qA2gHDrcATAay7gnofHIadNYVNc4OyvY
 YUjVeqMVYOFHDbmbcllYgxwk410vN8lbpgQW7cfviaMvmz1L3IYdXbrMpJLFiOKnavHk
 5gmg==
X-Gm-Message-State: AOAM530QclUngfj7lkT/ZLExBzYlBjneJU8hTLwfuwFSLP04CaCPed21
 Us4KsJKb54To6bs9PkisJJZ07w==
X-Google-Smtp-Source: ABdhPJw0sCIj9SGPQi9/3pSeTdjP3tUKlGQY9tYxdh47l36JCwKd/wL2+T5d4l7kWEKYH9l49xhmsg==
X-Received: by 2002:a17:90b:238a:: with SMTP id
 mr10mr6130742pjb.187.1595612031653; 
 Fri, 24 Jul 2020 10:33:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id a9sm6938080pfr.103.2020.07.24.10.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 10:33:50 -0700 (PDT)
Date: Fri, 24 Jul 2020 10:33:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <202007241016.922B094AAA@keescook>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
 <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
X-Mailman-Approved-At: Fri, 24 Jul 2020 17:45:13 +0000
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
Cc: anthony.ruhier@gmail.com, 1i5t5.duncan@cox.net, sunpeng.li@amd.com,
 Mazin Rezk <mnrzk@protonmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, regressions@leemhuis.info,
 amd-gfx@lists.freedesktop.org, Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, mphantomx@yahoo.com.br,
 Harry Wentland <Harry.Wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdWwgMjQsIDIwMjAgYXQgMDk6NDU6MThBTSArMDIwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gQW0gMjQuMDcuMjAgdW0gMDA6MzIgc2NocmllYiBLZWVzIENvb2s6Cj4gPiBPbiBUaHUs
IEp1bCAyMywgMjAyMCBhdCAwOToxMDoxNVBNICswMDAwLCBNYXppbiBSZXprIHdyb3RlOgo+IEFz
IExpbnV4IDUuOC1yYzcgaXMgZ29pbmcgdG8gYmUgcmVsZWFzZWQgdGhpcyBTdW5kYXksIEkgd29u
ZGVyLCBpZiBjb21taXQKPiAzMjAyZmE2MmYgKCJzbHViOiByZWxvY2F0ZSBmcmVlbGlzdCBwb2lu
dGVyIHRvIG1pZGRsZSBvZiBvYmplY3QiKSBzaG91bGQgYmUKPiByZXZlcnRlZCBmb3Igbm93IHRv
IGZpeCB0aGUgcmVncmVzc2lvbiBmb3IgdGhlIHVzZXJzIGFjY29yZGluZyB0byBMaW51eOKAmSBu
bwo+IHJlZ3Jlc3Npb24gcG9saWN5LiBPbmNlIHRoZSBBTURHUFUvRFJNIGRyaXZlciBpc3N1ZSBp
cyBmaXhlZCwgaXQgY2FuIGJlCj4gcmVhcHBsaWVkLiBJIGtub3cgaXTigJlzIG5vdCBvcHRpbWFs
LCBidXQgYXMgc29tZSB0ZXN0aW5nIGlzIGdvaW5nIHRvIGJlCj4gaW52b2x2ZWQgZm9yIHRoZSBm
aXgsIEnigJlkIGFyZ3VlIGl04oCZcyB0aGUgYmVzdCBvcHRpb24gZm9yIHRoZSB1c2Vycy4KCldl
bGwsIHRoZSBTTFVCIGRlZmVuc2Ugd2FzIGFscmVhZHkgcmVsZWFzZWQgaW4gdjUuNywgc28gSSdt
IG5vdCBzdXJlIGl0CnJlYWxseSBoZWxwcyBmb3IgYW1kZ3B1X2RtIHVzZXJzIHNlZWluZyBpdCB0
aGVyZSB0b28uIFRoZXJlIHdhcyBhIGZpeCB0bwpkaXNhYmxlIHRoZSBhc3luYyBwYXRoIGZvciB0
aGlzIGRyaXZlciB0aGF0IHdvcmtlZCBhcm91bmQgdGhlIGJ1ZyB0b28sCnllcz8gVGhhdCBzZWVt
cyBsaWtlIGEgc2FmZXIgYW5kIG1vcmUgZm9jdXNlZCBjaGFuZ2UgdGhhdCBkb2Vzbid0IHJldmVy
dAp0aGUgU0xVQiBkZWZlbnNlIGZvciBhbGwgdXNlcnMsIGFuZCB3b3VsZCBhY3R1YWxseSBwcm92
aWRlIGEgY29tcGxldGUsCkkgdGhpbmssIHdvcmthcm91bmQgd2hlcmVhcyByZXZlcnRpbmcgdGhl
IFNMVUIgY2hhbmdlIG1lYW5zIHRoZSByYWNlCnN0aWxsIGV4aXN0cy4gRm9yIGV4YW1wbGUsIGl0
IHdvdWxkIGJlIGhpdCB3aXRoIHNsYWIgcG9pc29uaW5nLCBldGMuCgotLSAKS2VlcyBDb29rCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
