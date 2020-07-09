Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D20AC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 07:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EFC20767
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 07:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="zLm4SSk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EFC20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9C56E9AE;
	Thu,  9 Jul 2020 07:32:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5E06E9B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 07:32:53 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id f7so1244150wrw.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Jud8gvQk5riwJAQJGuwXf/WPCVvJ3Rgrb7LcC+OGLek=;
 b=zLm4SSk5z97AJg6wYQWGtiXRJWSitYdo31xqKn0gBxQYkDc/O8TNqgmdajvWHTc0Kq
 rGwaApXSclxBjqko2/Imk9PsR/5u4P/dFPZ9vnPTcqas0kKsEXgqhgF3t0RafiX5Slpt
 JeQpVI0kr0Ku8fqaHq0LjC1TI8jp96YL96hlw5mEdqcM3BGaUheuStZw9Zp7Ip4b+qMo
 G8ZaPEuNqWQyW5xojChELdclmASsdPKtzfHhPpgkGLUC1m/SFhDwvbCu0ULyt2e6O4l4
 gmydb794XLx3M6/yeu4lieZBx/uX1mX0dOMcySh4xW9eVoMMSL0MVJyZib2fBoxie8xs
 axQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jud8gvQk5riwJAQJGuwXf/WPCVvJ3Rgrb7LcC+OGLek=;
 b=llPsQxKx730CY46Q3RowIqKtKbJSbIcyJ2Vt4Qq6iGR/BsnH5VNcBm5oCEFuJvdjl8
 5hgyvNqS5vMgTQJS1NngBi0IFVym86u+rsUqhTcAsBxrkzg9E3t1g0IfnhnC6P/V90Sx
 Ctxq3e+Q3CbDpBmOWQbZ45Y8C/r8Oz1eQz9a4X5qWk5d5xwdtReKoCqBsrG/tKwawGqK
 A1uRIUjw7J5NV8hJDlYCTiYq+1AnS9D0qvH8nR+vnLVHDfeSxDxe/HwxFw66PeZxJ5rf
 EVrg8Qlmdb+a2Ef8byRsGk5zN+GB+XqMSkkN+OpsG45hPShlKsFZ920InsuUqXTBBU8r
 rVoQ==
X-Gm-Message-State: AOAM530ZjmmHoqQ32TcQ31V8yuT1RW26MHyKWxpXFX1dxlmSWFCBokpT
 JUsXxzf0DuwWY4oHm508/3heea2/5pJSFNURDWGMxA==
X-Google-Smtp-Source: ABdhPJwgsWk0Cll+yWUxQEOGAdwXBKFxNE0yBvBai49LXxv7MVRksA8PL+EvQ8au/BG5aRKV6xpbDv9YTf7SNQSV164=
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr50931091wrw.244.1594279971984; 
 Thu, 09 Jul 2020 00:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-2-daniel.vetter@ffwll.ch>
 <20c0a95b-8367-4f26-d058-1cb265255283@amd.com>
 <CAKMK7uFe7Pz4=UUkkunBms8vUrzwEpWJmScOMLO4KdADM43vnw@mail.gmail.com>
In-Reply-To: <CAKMK7uFe7Pz4=UUkkunBms8vUrzwEpWJmScOMLO4KdADM43vnw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 9 Jul 2020 08:32:41 +0100
Message-ID: <CAPj87rNXneE+Vry4aSV11=Qv2mbUsFjCLmNzRmx-Oeqj=u9dyw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 01/25] dma-fence: basic lockdep annotations
To: Daniel Vetter <daniel.vetter@ffwll.ch>
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksCgpPbiBXZWQsIDggSnVsIDIwMjAgYXQgMTY6MTMsIERhbmllbCBWZXR0ZXIgPGRhbmllbC52
ZXR0ZXJAZmZ3bGwuY2g+IHdyb3RlOgo+IE9uIFdlZCwgSnVsIDgsIDIwMjAgYXQgNDo1NyBQTSBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+ID4gQ291
bGQgd2UgbWVyZ2UgdGhpcyBjb250cm9sbGVkIGJ5IGEgc2VwYXJhdGUgY29uZmlnIG9wdGlvbj8K
PiA+Cj4gPiBUaGlzIHdheSB3ZSBjb3VsZCBoYXZlIHRoZSBjaGVja3MgdXBzdHJlYW0gd2l0aG91
dCBoYXZpbmcgdG8gZml4IGFsbCB0aGUKPiA+IHN0dWZmIGJlZm9yZSB3ZSBkbyB0aGlzPwo+Cj4g
U2luY2UgaXQncyBmdWxseSBvcHQtaW4gYW5ub3RhdGlvbnMgbm90aGluZyBibG93cyB1cCBpZiB3
ZSBkb24ndCBtZXJnZQo+IGFueSBhbm5vdGF0aW9ucy4gU28gd2UgY291bGQgc3RhcnQgbWVyZ2lu
ZyB0aGUgZmlyc3QgMyBwYXRjaGVzLiBBZnRlcgo+IHRoYXQgdGhlIGZ1biBzdGFydHMgLi4uCj4K
PiBNeSByb3VnaCBpZGVhIHdhcyB0aGF0IGZpcnN0IEknZCB0cnkgdG8gdGFja2xlIGRpc3BsYXks
IHRodXMgZmFyCj4gdGhlcmUncyAyIGFjdHVhbCBpc3N1ZXMgaW4gZHJpdmVyczoKPiAtIGFtZGdw
dSBoYXMgc29tZSBkbWFfcmVzdl9sb2NrIGluIGNvbW1pdF90YWlsLCBwbHVzIGEga21hbGxvYy4g
SQo+IHRoaW5rIHRob3NlIHNob3VsZCBiZSBmYWlybHkgZWFzeSB0byBmaXggKEknZCB0cnkgYSBz
dGFiIGF0IHRoZW0gZXZlbikKPiAtIHZtd2dmeCBoYXMgYSBmdWxsIG9uIGxvY2tpbmcgaW52ZXJz
aW9uIHdpdGggZG1hX3Jlc3ZfbG9jayBpbgo+IGNvbW1pdF90YWlsLCBhbmQgdGhhdCBvbmUgaXMg
ZnVuY3Rpb25hbC4gTm90IGp1c3QgcmVhZGluZyBzb21ldGhpbmcKPiB3aGljaCB3ZSBjYW4gc2Fm
ZWx5IGFzc3VtZSB0byBiZSBpbnZhcmlhbnQgYW55d2F5IChsaWtlIHRoZSB0bXogZmxhZwo+IGZv
ciBhbWRncHUsIG9yIHdoYXRldmVyIGl0IHdhcykuCj4KPiBJJ3ZlIGRvbmUgYSBwaWxlIG1vcmUg
YW5ub3RhdGlvbnMgcGF0Y2hlcyBmb3Igb3RoZXIgYXRvbWljIGRyaXZlcnMKPiBub3csIHNvIGhv
cGVmdWxseSB0aGF0IGZsdXNoZXMgb3V0IGFueSByZW1haW5pbmcgb2ZmZW5kZXJzIGhlcmUuIFNp
bmNlCj4gc29tZSBvZiB0aGUgYW5ub3RhdGlvbnMgYXJlIGluIGhlbHBlciBjb2RlIHdvcnN0IGNh
c2Ugd2UgbWlnaHQgbmVlZCBhCj4gZGV2LT5tb2RlX2NvbmZpZy5icm9rZW5fYXRvbWljX2NvbW1p
dCBmbGFnIHRvIGRpc2FibGUgdGhlbS4gQXQgbGVhc3QKPiBmb3Igbm93IEkgaGF2ZSAwIHBsYW5z
IHRvIG1lcmdlIGFueSBvZiB0aGVzZSB3aGlsZSB0aGVyZSdzIGtub3duCj4gdW5zb2x2ZWQgaXNz
dWVzLiBNYXliZSBpZiBzb21lIGRyaXZlcnMgdGFrZSBmb3JldmVyIHRvIGdldCBmaXhlZCB3ZQo+
IGNhbiB0aGVuIGFwcGx5IHNvbWUgZHVjdC10YXBlIGZvciB0aGUgYXRvbWljIGhlbHBlciBhbm5v
dGF0aW9uIHBhdGNoLgo+IEluc3RlYWQgb2YgYSBmbGFnIHdlIGNhbiBhbHNvIGNvcHlwYXN0YSB0
aGUgYXRvbWljX2NvbW1pdF90YWlsIGhvb2ssCj4gbGVhdmluZyB0aGUgYW5ub3RhdGlvbnMgb3V0
IGFuZCBhZGRpbmcgYSBodWdlIHdhcm5pbmcgYWJvdXQgdGhhdC4KCkhvdyBhYm91dCBhbiBvcHQt
aW4gZHJtX2RyaXZlciBEUklWRVJfREVBRExPQ0tfSEFQUFkgZmxhZz8gQXQgZmlyc3QKdGhpcyBj
b3VsZCBqdXN0IGRpc2FibGUgdGhlIGFubm90YXRpb25zIGFuZCBub3RoaW5nIGVsc2UsIGJ1dCBh
cyB3ZQpzZWUgdGhlIGFubm90YXRpb25zIGdhaW5pbmcgcmVhbC13b3JsZCB0ZXN0aW5nIGFuZCBt
YXR1cml0eSwgd2UgY291bGQKZXZlbnR1YWxseSBtYWtlIGl0IHRhaW50IHRoZSBrZXJuZWwuCgpD
aGVlcnMsCkRhbmllbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
