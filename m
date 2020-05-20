Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AAAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 16:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B73A20671
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 16:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk7ztX4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B73A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0FB6E871;
	Wed, 20 May 2020 16:11:11 +0000 (UTC)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B386E86C;
 Wed, 20 May 2020 15:59:06 +0000 (UTC)
Received: by mail-ua1-x936.google.com with SMTP id k4so1415941uaq.10;
 Wed, 20 May 2020 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BHfEA/DVUQZGf7fRE//YGM+GmMZzgkOgMuhXtjnCXu8=;
 b=Tk7ztX4h0Zbv4X/0IN7ShZ/Or663/Xr2lyArvmn/TkR+BzEheCLcViF2VHSZ8TWOH0
 1g+i7Z31WyIJMaGSya/SzgF72E4ByxogMr1NC41mATpirBzRS4unOuNsKIQApz4Dj59b
 tqLbJpmIQryxABL5RB01/uetUS7Zy4C7au+ZRhn04cgu0iY/hl2qMgi5g+9cvYqLV+c9
 hCLM7ABMADTNtdhNjB5BqQdQdfv9jpxB7UJHWDYokml3IeSNWur94rVYEZ39Aka42L9w
 8+sIw7VFABLitmi6LHhSiaTbKqCmfuBrrp2cRkcoCl6Y3q5QpgAWUP0PqUFkIkKAlPw+
 J9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BHfEA/DVUQZGf7fRE//YGM+GmMZzgkOgMuhXtjnCXu8=;
 b=iUR+a8FrhWUmNzPmeI2XOtMg6WmQNoMdXg2iGUEEOUBJF82jDSO3AmJCy8uEAjmJCH
 zOnf6hmPLPzaDOlxR8UyWcfqg4pAm3AXnoKxERNuz/d5qd62fcclAaQEGKvfeptS5VjW
 HJbCS5TlVYPY3XknhBedODK+xNjDbqnp80tfhaCDh9muKtuj2eeBuI0okwictJdjlII9
 6VJIX9kq8wdneAS9NDchiPJuRqINsUSdzlkjxDUymXOtaEeKnNLa/PqOoH/I4qKhMlq/
 3nRnbbLUqgwurm5Bf1WvCpTuDZH/qG3zAcQu9s+m0hg4dSzOKynsGOQDwJqPy28rSN++
 qh1A==
X-Gm-Message-State: AOAM532LeCc6A4fNlJJHsZifbBYflb+50sWzqE/tEgcFiSreQTaizCeg
 CIb+zZOYvvm6wdL0FutNWR8MBA1H641oP6i4zw==
X-Google-Smtp-Source: ABdhPJw0Fw1dJDC1P8Nbnw/wOU7o3UxXruJraXNr6pFwkIBC1kJSRg2CojsDLMoN8UhqR8JCFuUXPvjPP0uMr3LJvrA=
X-Received: by 2002:a9f:2c04:: with SMTP id r4mr3850708uaj.10.1589990345951;
 Wed, 20 May 2020 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200513110313.12979-1-christian.koenig@amd.com>
 <9d784383-905e-59af-b17c-923c92474ece@gmail.com>
In-Reply-To: <9d784383-905e-59af-b17c-923c92474ece@gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Wed, 20 May 2020 16:58:54 +0100
Message-ID: <CALjTZvaFfHt5ujdFmzDku5fDXGvn4GJXAzc5bLDehr6DDGLUDA@mail.gmail.com>
Subject: Re: [RFC] Deprecate AGP GART support for Radeon/Nouveau/TTM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
X-Mailman-Approved-At: Wed, 20 May 2020 16:11:11 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nouveau@lists.freedesktop.org,
 debian-powerpc@lists.debian.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksIENocmlzdGlhbiwKCk9uIFdlZCwgMjAgTWF5IDIwMjAgYXQgMTY6MDAsIENocmlzdGlhbiBL
w7ZuaWcKPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IFNvIEkn
dmUgdXNlZCBhbiBhbmNpZW50IHN5c3RlbSAoMzJiaXQpIHRvIHNldHVwIGEgdGVzdCBib3ggZm9y
IHRoaXMuCj4KPgo+IFRoZSBmaXJzdCBHUFUgSSBjb3VsZCB0ZXN0IGlzIGFuIFJWMjgwIChSYWRl
b24gOTIwMCBQUk8pIHdoaWNoIGlzIGVhc2lseQo+IDE1IHllYXJzIG9sZC4KCk9oLCBJIGhhdmUg
b25lIG9mIHRob3NlIGluIGJveCBzb21ld2hlcmUsIGJ1dCBubyBBR1AgbWFjaGluZSB0bwppbnN0
YWxsIGl0ICh5ZXQpLgoKPiBXaGF0IGhhcHBlbnMgaW4gQUdQIG1vZGUgaXMgdGhhdCBnbHhnZWFy
cyBzaG93cyBhcnRpZmFjdHMgZHVyaW5nCj4gcmVuZGVyaW5nIG9uIHRoaXMgc3lzdGVtLgo+Cj4g
SW4gUENJIG1vZGUgdGhvc2UgcmVuZGVyaW5nIGFydGlmYWN0cyBhcmUgZ29uZSBhbmQgZ2x4Z2Vh
cnMgc2VlbXMgdG8KPiBkcmF3IGV2ZXJ5dGhpbmcgY29ycmVjdGx5IG5vdy4KPgo+IFBlcmZvcm1h
bmNlIGlzIG9idmlvdXNseSBub3QgY29tcGFyYWJsZSwgY2F1c2UgaW4gQUdQIHdlIGRvbid0IHJl
bmRlcgo+IGFsbCB0cmlhbmdsZXMgY29ycmVjdGx5LgoKSSBhZ3JlZSwgY29ycmVjdG5lc3MgYmVm
b3JlIHBlcmZvcm1hbmNlLCBhbHdheXMuCgo+IFRoZSBzZWNvbmQgR1BVIEkgY291bGQgdGVzdCBp
cyBhbiBSVjYzMCBQUk8gKFJhZGVvbiBIRCAyNjAwIFBSTyBBR1ApCj4gd2hpY2ggaXMgbW9yZSB0
aGFuIDEwIHllYXJzIG9sZC4KPgo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoaXMgb25lIHdvcmtz
IGluIGJvdGggQUdQIGFuZCBQQ0llIG1vZGUgcGVyZmVjdGx5Cj4gZmluZS4KPgo+IFNpbmNlIHRo
aXMgaXMgb25seSBhIDMyYml0IHN5c3RlbSBJIGNvdWxkbid0IHJlYWxseSB0ZXN0IGFueSBPcGVu
R0wgZ2FtZQo+IHRoYXQgd2VsbC4KCkkgdXN1YWxseSB0ZXN0IHdpdGggbXkgZGlzdHJvJ3MgKERl
YmlhbiBvciBVYnVudHUsIGluIG15IGNhc2UpIGdhbWVzLgpGb3IgZXhhbXBsZSwgSSB1c2VkIE5l
eHVpeiB3aGVuIHdpcmluZyB1cCB0aGUgc2hhZGVyIGNhY2hlIG9uIHIzMDBnLgoKPiBCdXQgZm9y
IGdseGdlYXJzIHN3aXRjaGluZyBmcm9tIEFHUCB0byBQQ0llIG1vZGUgc2VlbXMgdG8gcmVzdWx0
IGluIGEKPiByb3VnaGx5IDUlIHBlcmZvcm1hbmNlIGRyb3AuCj4KPiBUaGUgc3VycHJpc2luZyBy
ZWFzb24gZm9yIHRoaXMgaXMgbm90IHRoZSBiZXR0ZXIgVExCIHBlcmZvcm1hbmNlLCBidXQKPiB0
aGUgbGFjayBvZiBVU1dDIHN1cHBvcnQgZm9yIHRoZSBQQ0llIEdBUlQgaW4gcmFkZW9uLgo+Cj4g
U28gaWYgYW55Ym9keSB3YW50cyB0byBnZXQgaGlzIGhhbmRzIGRpcnR5IGFuZCBzcXVlZXplIGEg
Yml0IG1vcmUKPiBwZXJmb3JtYW5jZSBvdXQgb2YgdGhlIG9sZCBoYXJkd2FyZSwgcG9ydGluZyBV
U1dDIGZyb20gYW1kZ3B1IHRvIHJhZGVvbgo+IHNob3VsZG4ndCBiZSB0byBtdWNoIG9mIGEgcHJv
YmxlbS4KCldlbGwsIEZXSVcsIEkgd291bGQgYXJndWUgdGhhdCBhIHJlZ3Jlc3Npb24gaW4gcGVy
Zm9ybWFuY2UsIGlmCmF2b2lkYWJsZSwgc2hvdWxkIGJlIGF2b2lkZWQuIEkgaGF2ZSBub3QgbmVh
cmx5IGVub3VnaCBrbm93bGVkZ2Ugb2YKdGhlIGRyaXZlciB0byBkbyBpdCBteXNlbGYsIGJ1dCBJ
J2xsIGdsYWR5IHRlc3QgYW55IHBhdGNoZXMsIG9uIGJvdGgKeDg2LTY0IChSYWRlb24gWHByZXNz
IDEyNTApIGFuZCBwcGMzMiAoTW9iaWxpdHkgUmFkZW9uIDk1NTApLgoKQ2hlZXJzLApSdWkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
