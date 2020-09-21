Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E389C43465
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E660B21D91
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="r4E87SE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E660B21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jlekstrand.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085EB6E36F;
	Mon, 21 Sep 2020 14:28:23 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6A46E362
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 14:28:21 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id k14so13054701edo.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VzVFv87gEs+DoQS8yQmlQI7hV0/JZ6iyGje6mT9KAwE=;
 b=r4E87SE8cRmNC5/QVPBZTvtY0WwQCAYq610H3TrqushG0vNVlKdRr1yDB+OGvjsEsh
 S3FMPazSyqly4DhCb4U7Daasb48nWMYCRokGTGWWDWr9Lzd6KgGSzsSL2bf8JN8hSUUg
 fRzGoMda0izTxUfQ1oDoraADyOixRpShNlZWwVuWp+90kzwtm6dXywXfCJwfHNYTDPPC
 BRvwUcCNbRJRVtNCA8XAXeWeF7BEiteuUSc0wY4jwhVuicLkHdBYv1A9LX7rLKMIuKyJ
 4unfy8WbdjnYnXrOLoUKtowSivIVSvfiJ9L/35cPYAO2P/1sV7m+awpIj8vkbInTptyh
 hePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VzVFv87gEs+DoQS8yQmlQI7hV0/JZ6iyGje6mT9KAwE=;
 b=tRjUhkhYMJDXdVX751v9wKCHYtTyY1tWURICnYFO10UIY7j35L+Ezs7N9hCt5FwIcf
 pjXXekf762OO6n1855iT/znH+VYTOAMm7OgXzIelsqJDlzV6N9DutOBMllnj7FVhe/9p
 QNrRXfKXCMQLHq+u0+jRXNoVdMZXmJAik8ZxJpy0sU++C6e9eBqYhgveaS3g+SoilSUp
 rZZ+Nw/rJV5zUD/IhAk/Xvi5qQlUq/0cnHeZ6CJIeafWlXRL2zoU6b62Aor9+/PO8i/2
 a1Lke+qaV/YcPYTQYT6nVgv7PK85VkKd54aRjrFEtvzhF3P/+kcNGyE+wG9zElFWNW/2
 5sUw==
X-Gm-Message-State: AOAM530FrU8DDgK06gbnQgm9k3NM9uYsqV1Z/4vFAP7ySvMRjjBYILQs
 WNhmoyqmZm6qfWE5Cp/KjP3YB7DlQevx9ZD5vuE4aQ==
X-Google-Smtp-Source: ABdhPJxzM6EYIqImTXX3nZVDlcUVt4Reycl0v4NuDxz6VB7H68kqhbvAzdwYiX9PD8RD0OTNupjfeVlIQGuz17LfGtQ=
X-Received: by 2002:aa7:d747:: with SMTP id a7mr51024393eds.304.1600698500267; 
 Mon, 21 Sep 2020 07:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <4eaa69879014a406424b9702dd6574a305f4c98e.camel@igalia.com>
In-Reply-To: <4eaa69879014a406424b9702dd6574a305f4c98e.camel@igalia.com>
From: Jason Ekstrand <jason@jlekstrand.net>
Date: Mon, 21 Sep 2020 09:28:09 -0500
Message-ID: <CAOFGe97CpYKkNC3N=2kxCnFSSw5sQuQCEdkKGudCEL6em3YTGA@mail.gmail.com>
Subject: Re: [Mesa-dev] XDC 2020 feedback and comments
To: =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>
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
Cc: "xorg-devel@lists.freedesktop.org" <xorg-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
 "board@foundation.x.org" <board@foundation.x.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "events@lists.x.org" <events@lists.x.org>,
 "mesa-dev@lists.freedesktop.org" <mesa-dev@lists.freedesktop.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rmlyc3Qgb2ZmLCBJIHRoaW5rIHlvdSBhbGwgZGlkIGEgZmFudGFzdGljIGpvYi4gIEkgZmVsdCB0
aGF0IHRoaW5ncwpyYW4gdmVyeSBzbW9vdGhseSBhbmQsIGFzIGZhciBhcyB0aGUgdGFsa3MgdGhl
bXNlbHZlcyBnbywgSSB0aGluayBpdAp3ZW50IGFsbW9zdCBhcyBzbW9vdGhseSBhcyBhbiBpbi1w
ZXJzb24gWERDLiAgSSdtIHJlYWxseSBxdWl0ZQppbXByZXNzZWQuICBJIGRvIGhhdmUgYSBjb3Vw
bGUgcGllY2VzIG9mIG1vcmUgbnVhbmNlZCBmZWVkYmFjazoKCiAxLiBJIHRoaW5rIHdlIHdlcmUg
bWF5YmUgYSBiaXQgdG9vIHNjYXJlZCBvZiBvdmVybG9hZGluZyBqaXRzaS4KSGF2aW5nIG1vcmUg
cGVvcGxlIGluIHRoZSBpbnN0YW5jZSBmb3IgcXVlc3Rpb25zIG1pZ2h0IGhhdmUgbWFkZSB0aGF0
CnBvcnRpb24gZ28gYmV0dGVyLiAgQXMgaXQgd2FzLCB0aGVyZSB3YXMgb25seSBvbmUgb3IgdHdv
IHRhbGtzIHRoYXQKaGFkIGFueSBsaXZlIHF1ZXN0aW9ucy4gIFRoYXQgc2FpZCwgdGhlcmUgYXJl
IGEgZmV3IGFkdmFudGFnZXMgdG8KaGF2aW5nIHRoaW5ncyBmdW5uZWxlZCB0aHJvdWdoIElSQywg
dGhlIG1vc3Qgb2J2aW91cyBvZiB3aGljaCBiZWluZwp0aGF0IHBlb3BsZSBjYW4gYXNrIHRoZWly
IHF1ZXN0aW9uIG1pZC10YWxrIGFuZCBoYXZlIGl0IGhhbmRsZWQgYXQgdGhlCmVuZCBpbnN0ZWFk
IG9mIGhhdmluZyB0byByZW1lbWJlciBpdCBmb3IgMjAgbWludXRlcy4KCiAyLiBJIHJlYWxseSBt
aXNzIHRoZSBoYWxsd2F5IHRyYWNrLiAgT24gVGh1cnNkYXksIGFmdGVyIHRoZQpjb25mZXJlbmNl
LCBCYXMsIENvbm5vciwgYW5kIEkgdXNlZCBqaXRzaSB0byBoYXZlIGEgY2hhdCBhYm91dApyYXkt
dHJhY2luZy4gIFRoYXQgd2FzIHJlYWxseSBmdW4gYW5kIEkgd2lzaCBJJ2QgZG9uZSBzb21ldGhp
bmcgbGlrZQp0aGF0IGV2ZXJ5IGRheSBvZiBYREMuICBNYXliZSBpdCdzIG15IG93biBmYXVsdCBm
b3Igbm90IHNldHRpbmcgdXAKc2FpZCBjaGF0cyBidXQgSSB0aGluayBpdCBjb3VsZCBoYXZlIGJl
ZW4gbWFkZSBtb3JlIGFjY2Vzc2libGUgKEkgaGFkCm5vIGlkZWEgaG93IHRvIGZvcmsgb2ZmIGEg
aml0c2kgaW5zdGFuY2UpIGFuZC9vciBlbmNvdXJhZ2VkIHNvbWVob3cuCgotLUphc29uCgpPbiBN
b24sIFNlcCAyMSwgMjAyMCBhdCAzOjA3IEFNIFNhbXVlbCBJZ2xlc2lhcyBHb25zw6FsdmV6Cjxz
aWdsZXNpYXNAaWdhbGlhLmNvbT4gd3JvdGU6Cj4KPiBIaSBhbGwsCj4KPiBIdWdlIHRoYW5rcyBh
Z2FpbiB0byB0aGUgZW50aXJlIHRlYW0gZnJvbSBJbnRlbCwgZm9yIHRoZWlyIGdyZWF0IHdvcmsK
PiBvcmdhbml6aW5nIFhEQyAyMDIwLCBvdXIgZmlyc3QgdmlydHVhbCBjb25mZXJlbmNlIQo+Cj4g
QXMgdXN1YWwgd2UncmUgbG9va2luZyBmb3IgZmVlZGJhY2sgb24gYm90aCBYREMgaXRzZWxmLCBh
bmQgdGhlIENGUAo+IHByb2Nlc3MgYW5kIHByb2dyYW0gc2VsZWN0aW9uLiBCb3RoIGFib3V0IHdo
YXQgd2FzIGdyZWF0IGFuZCBzaG91bGQgYmUKPiBrZXB0IGZvciBuZXh0IHllYXIncyBlZGl0aW9u
LCBhbmQgd2hlcmUgdGhlcmUncyByb29tIGZvciBpbXByb3ZlbWVudC4KPgo+IFRoZSBib2FyZCBk
b2VzIGtlZXAgc29tZSBub3RlcywgZm9yIHRob3NlIGludGVyZXN0ZWQgaW4gd2hhdCB3ZSBoYXZl
Cj4gYWxyZWFkeToKPgo+IC0gWERDIG5vdGVzIGZvciBwcm9zcGVjdGl2ZSBvcmdhbml6ZXJzOgo+
IGh0dHBzOi8vd3d3Lngub3JnL3dpa2kvRXZlbnRzL1JGUC8KPgo+IC0gQ0ZQIG5vdGVzOiBodHRw
czovL3d3dy54Lm9yZy93aWtpL0V2ZW50cy9QYXBlcnNDb21taXR0ZWUvCj4KPiBJZiB5b3Ugd2Fu
dCB0byBzZW5kIGluIHlvdXIgY29tbWVudHMgaW4gcHJpdmF0ZSwgcGxlYXNlIHNlbmQgdGhlbSB0
bwo+IHRoZSBYLm9yZyBGb3VuZGF0aW9uIGJvYXJkOiBib2FyZEBmb3VuZGF0aW9uLngub3JnCj4K
PiBDaGVlcnMsCj4KPiBTYW0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IG1lc2EtZGV2IG1haWxpbmcgbGlzdAo+IG1lc2EtZGV2QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vbWVzYS1kZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
