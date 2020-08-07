Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83D220855
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j8CS2Cay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83D220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3C86E98F;
	Fri,  7 Aug 2020 09:20:38 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8006E98F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 09:20:36 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id 25so1371632oir.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2020 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lvtNVK89KjmknIpCZu1MGD0RAR5CBgxXkHrtWzJkUwk=;
 b=j8CS2Cayy6XXt9q56/ME0DQfbP/qU+f23yfv/MGs0BgAXS008WX6ceKrt7fQZFgID0
 qbaSuzCorDZsu9YK6IRH3JdKFkpwiHyDuCk1mVGyoYx/pZfMtWjc/n9NzPgpO7DdhtP/
 FsWXqy8OQQ0OFvVa2DbZHPYsGYzwYtZ9bFG5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lvtNVK89KjmknIpCZu1MGD0RAR5CBgxXkHrtWzJkUwk=;
 b=SOca94DH6lOJe84hxWfqXUcYOXvIGluzn8f6KoYSh6wc6sFLtlXAIBw50A4Exb+vHp
 CfRVC6RpD5NJMAkSvH60W9wXu8dDx+s7YXNXiuCTDoLYFYtN4LuHsuRj/PavAi66po+t
 s4ZTJ/iO+rD/5Eqsrhkr1qhYBxJ/j9QRvNbm3P0cB0V/41MCf9rNkE63wP6ebp6/ZzIO
 irKG1ntlwrSPKE6icE/S7mTCP33glnt3FmHv4DSj41uxRaSuaAaLi7bJeUVZjlmkCkyN
 NiyJ4G56mGvox5uaZL02FrWGvtboZyaFWYiKOHlA1bEluCLsaEHR2HYvcKMBPRYiRBdF
 7xRQ==
X-Gm-Message-State: AOAM5331fwkSUJ0akK9FhmekCnkSAcr+EML4smPv2qCaJ1T9pilCuNQc
 ZtH8FAI4mTPZSv2fweTl6WOC/Ti3SG/OEK4mkoqOHA==
X-Google-Smtp-Source: ABdhPJyLWOxF45Xrcv0PGxdgGM9OKWrqj1fYqxaSEw8zj/7jBZu8JXTwC20Hx6HNawv9wVK9BOpl18frevV6sDo9MqQ=
X-Received: by 2002:aca:ab87:: with SMTP id
 u129mr10456792oie.128.1596792036150; 
 Fri, 07 Aug 2020 02:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200806070230.21457-1-Dennis.Li@amd.com>
 <84678659-b4a6-8332-a71b-28d1b412ae16@gmail.com>
 <DM5PR12MB2533F4B9325903B915AD41F9ED480@DM5PR12MB2533.namprd12.prod.outlook.com>
 <031236ab-0646-bf1c-a93b-aec90bc6dab1@amd.com>
 <SN1PR12MB25447D63750B41887E893668ED480@SN1PR12MB2544.namprd12.prod.outlook.com>
 <cf4bc6ce-fca0-1c45-5665-4085a835196a@amd.com>
 <SN1PR12MB254440D6E152B08D3CA8D4C5ED480@SN1PR12MB2544.namprd12.prod.outlook.com>
 <b5d73714-9064-9baa-e687-406f9f4b1b69@amd.com>
 <DM5PR12MB2533C80EDE996B5E79ED169BED480@DM5PR12MB2533.namprd12.prod.outlook.com>
 <9121c08e-9043-b1fc-414a-03e4d7a280e3@amd.com>
 <DM5PR12MB25335CB16FB3B4CE6584355CED490@DM5PR12MB2533.namprd12.prod.outlook.com>
 <77def862-07d6-1079-b767-0ff4827a6234@amd.com>
 <DM5PR12MB2533453E6A4B046D4C7EE9F3ED490@DM5PR12MB2533.namprd12.prod.outlook.com>
 <b4375e2c-d28e-011f-4c6c-b4b05bf87e79@amd.com>
In-Reply-To: <b4375e2c-d28e-011f-4c6c-b4b05bf87e79@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 7 Aug 2020 11:20:24 +0200
Message-ID: <CAKMK7uEi53vmZFCkeQdMUF2SWsT9322aVLnbi85ZuvOo3=KGag@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: annotate a false positive recursive locking
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBBdWcgNywgMjAyMCBhdCAxMTowOCBBTSBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gW1NOSVBdCj4gPj4+PiBXaGF0IHdlIHNob3Vs
ZCBkbyBpbnN0ZWFkIGlzIHRvIG1ha2Ugc3VyZSB3ZSBoYXZlIG9ubHkgYSBzaW5nbGUgbG9jayBm
b3IgdGhlIGNvbXBsZXRlIGhpdmUgaW5zdGVhZC4KPiA+Pj4+IFtEZW5uaXMgTGldIElmIHdlIHVz
ZSBhIHNpbmdsZSBsb2NrLCB1c2VycyB3aWxsIG11c3Qgd2FpdCBmb3IgYWxsIGRldmljZXMgcmVz
dW1pbmcgc3VjY2Vzc2Z1bGx5LCBidXQgaW4gZmFjdCB0aGVpciB0YXNrcyBhcmUgb25seSBydW5u
aW5nIGluIGRldmljZSBhLiBJdCBpcyBub3QgZnJpZW5kbHkgdG8gdXNlcnMuCj4gPj4+IFdlbGwg
dGhhdCBpcyBpbnRlbnRpb25hbCBJIHdvdWxkIHNheS4gV2UgY2FuIG9ubHkgcmVzdGFydCBzdWJt
aXNzaW9ucyBhZnRlciBhbGwgZGV2aWNlcyBhcmUgcmVzdW1lZCBzdWNjZXNzZnVsbHksIGNhdXNl
IG90aGVyd2lzZSBpdCBjYW4gaGFwcGVuIHRoYXQgYSBqb2Igb24gZGV2aWNlIEEgZGVwZW5kcyBv
biBtZW1vcnkgb24gZGV2aWNlIEIgd2hpY2ggaXNuJ3QgYWNjZXNzaWJsZS4KPiA+Pj4gW0Rlbm5p
cyBMaV0gWWVzLCB5b3UgYXJlIHJpZ2h0LiBEcml2ZXIgaGF2ZSBtYWtlIHN1cmUgdGhhdCB0aGUg
c2hhcmVkIHJlc291cmNlcyhzdWNoIGFzIHRoZSBzaGFyZCBtZW1vcnkpIGFyZSByZWFkeSBiZWZv
cmUgdW5sb2NrIHRoZSBsb2NrIG9mIGFkZXYgb25lIGJ5IG9uZS4gQnV0IGVhY2ggZGV2aWNlIHN0
aWxsIGhhcyBwcml2YXRlIGhhcmR3YXJlIHJlc291cmNlcyBzdWNoIGFzIHZpZGVvICBhbmQgZGlz
cGxheS4KPiA+PiBZZWFoLCBidXQgdGhvc2UgYXJlIG5lZ2xpZ2libGUgYW5kIHdlIGhhdmUgYSB0
ZWFtIHdvcmtpbmcgb24gZGlzcGxheSBzdXBwb3J0IGZvciBYR01JLiBTbyB0aGlzIHdpbGwgc29v
bmVyIG9yIGxhdGVyIGJlY29tZSBhIHByb2JsZW0gYXMgd2VsbC4KPiA+Pgo+ID4+IEkgc3RpbGwg
dGhpbmsgdGhhdCBhIHNpbmdsZSByd3NlbSBmb3IgdGhlIHdob2xlIGhpdmUgaXMgc3RpbGwgdGhl
IGJlc3Qgb3B0aW9uIGhlcmUuCj4gPj4KPiA+PiBbRGVubmlzIExpXSBGb3IgeW91ciBhYm92ZSBj
b25jZXJuLCB3ZSBjYW4gb3BlbiBhIG5ldyB0aHJlYWQgdG8gZGlzY3VzcyBpdC4gSWYgd2UgbWFr
ZSBhIGRlY2lzaW9uIHRvIHVzZSBhIHNpbmdsZSBhZnRlciBkaXNjdXNzaW5nLCB3ZSBjYW4gY3Jl
YXRlIGFub3RoZXIgcGF0Y2ggZm9yIGl0Lgo+ID4gVGhhdCdzIGEgcmVhbGx5IGdvb2QgYXJndW1l
bnQsIGJ1dCBJIHN0aWxsIGhlc2l0YXRlIHRvIG1lcmdlIHRoaXMgcGF0Y2guCj4gPiBIb3cgc2V2
ZXJlIGlzIHRoZSBsb2NrZGVwIHNwbGF0Pwo+ID4KPiA+IEF0IGJhcmUgbWluaW11bSB3ZSBuZWVk
IGEgIi8qIFRPRE86IC4uLi4iIGNvbW1lbnQgd2h5IHdlIGRvIHRoaXMgYW5kIGhvdyB0byByZW1v
dmUgdGhlIHdvcmthcm91bmQgYWdhaW4uCj4gPiBbRGVubmlzIExpXSBJdCBpcyBub3QgYSB3b3Jr
YXJvdW5kLiBBY2NvcmRpbmcgdG8gZGVzaWduIG9mIGxvY2tkZXAsIGVhY2ggcndfc2VtYXBob3Jl
IHNob3VsZCBoYXMgYSBzZXBhcmF0ZWQgbG9ja19jbGFzc19rZXkuIEkgaGF2ZSBleHBsYWluZWQg
dGhhdCBpbml0X3J3c2VtIGhhcyB0aGUgYWJvdmUgbGltaXRhdGlvbiwgc28gd2UgbXVzdCBjb3Jy
ZWN0IGl0Lgo+Cj4gWWVhaCwgYnV0IHRoaXMgZXhwbGFuYXRpb24gaXMgbm90IHJlYWxseSBzdWZm
aWNpZW50LiBBZ2FpbiB0aGlzIGlzIG5vdAo+IGFuIGxpbWl0YXRpb24gb2YgaW5pdF9yd3NlbSwg
YnV0IGludGVudGlvbmFsIGJlaGF2aW9yLgo+Cj4gSW4gb3RoZXIgd29yZHMgaW4gbW9zdCBjYXNl
cyBsb2NrZGVwIHNob3VsZCBzcGxhdCBpZiB5b3UgdXNlIHJ3Cj4gc2VtYXBob3JlcyBsaWtlIHRo
aXMuCj4KPiBUaGF0IHdlIGF2b2lkIHRoaXMgYnkgbG9ja2luZyBtdWx0aXBsZSBhbWRncHUgZGV2
aWNlIGFsd2F5cyBpbiB0aGUgc2FtZQo+IG9yZGVyIGlzIHJhdGhlciBxdWVzdGlvbmFibGUgZHJp
dmVyIGRlc2lnbi4KClllYWggZG9uJ3QgZ2l2ZSBtdWx0aXBsZSBsb2NraW5nIGNsYXNzZXMgbGlr
ZSB0aGF0LCB0aGF0J3MgZmFpcmx5CnRlcnJpYmxlLiBUaGUgcmlnaHQgZml4IGlzIG11dGV4X2xv
Y2tfbmVzdF9sb2NrLCB3aGljaCB3ZSdyZSB1c2luZyBpbgp3d19tdXRleCBvciBpbiB3aGljaCBp
cyBhbHNvIHVzZWQgaW4gbW1fdGFrZV9hbGxfbG9ja3MuCgpJZiB5b3Ugc29sdmUgdGhlIGxvY2tp
bmcgb3JkZXJpbmcgYnkgc29ydGluZyBhbGwgdGhlIGxvY2tzIHlvdSBuZWVkCih1Z2gpLCB0aGVu
IHlvdSBjYW4gYWxzbyBqdXN0IHVzZSBhIGZha2UgbG9ja2RlcF9tYXAgZm9yIHlvdXIgc3BlY2lh
bApmdW5jdGlvbiBvbmx5LgoKQWxzbyBpbiBnZW5lcmFsIHRoZSBpZGVhIG9mIGFuIHJ3c2VtIGlu
IGNvbmp1bmN0aW9uIHdpdGggeGdtaSBjcm9zcwpkZXZpY2UgbWVtb3J5IGhhbmRsaW5nIGp1c3Qg
cGxhaW4gZnJlYWtzIG1lIG91dCA6LSkgUGxlYXNlIG1ha2Ugc3VyZQp5b3UgcHJpbWUgdGhpcyBs
b2NrIGFnYWluc3QgZG1hX3Jlc3YgYW5kIGRtYV9mZW5jZSAoYW5kIG1heWJlIGFsc28KZHJtX21v
ZGVzZXRfbG9jayBpZiB0aGlzIGxvY2sgaXMgb3V0c2lkZSBvZiBkbWFfcmVzdiksIGFuZCBpZGVh
bGx5CnRoaXMgc2hvdWxkIG9ubHkgZXZlciBiZSB1c2VkIGZvciBzZXR1cCBzdHVmZiB3aGVuIGxv
YWRpbmcgZHJpdmVycy4gSQpndWVzcyB0aGF0J3Mgd2h5IHlvdSB3ZW50IHdpdGggYSBwZXItZGV2
aWNlIHJ3c2VtLiBJZiBpdCdzIHJlYWxseSBvbmx5CmZvciBzZXR1cCB0aGVuIGp1c3QgZG8gdGhl
IHNpbXBsZSB0aGluZyBvZiBoYXZpbmcgYW4KeGdtaV9oaXZlX3JlY29uZmlndXJlIGxvY2ssIHdo
aWNoIGFsbCB0aGUgcndzZW1zIG5lc3Qgd2l0aGluLCBhbmQgbm8KZmFuY3kgbG9jayBvcmRlcmlu
ZyBvciBvdGhlciB0cmlja3MuCgo+ID4gICBDb3JlIG5ldHdvcmsgZHJpdmVyIChuZXQvY29yZS9k
ZXYuYykgaGFzIHRoZSBzaW1pbGFyIHVzZSBjYXNlIHdpdGggdXMuCj4KPiBKdXN0IHRvb2sgYSBs
b29rIGF0IHRoYXQsIGJ1dCB0aGlzIGlzIGNvbXBsZXRlbHkgZGlmZmVyZW50IHVzZSBjYXNlLiBU
aGUKPiBsb2NrZGVwIGNsYXNzZXMgYXJlIGdyb3VwZWQgYnkgZHJpdmVyIHR5cGUgdG8gbm90ZSB0
aGUgZGlmZmVyZW5jZSBpbiB0aGUKPiBuZXR3b3JrIHN0YWNrLgo+Cj4gQSBxdWljayBzZWFyY2gg
c2hvd2VkIHRoYXQgbm8gb3RoZXIgZGV2aWNlIGRyaXZlciBpcyBkb2luZyB0aGlzIGluIHRoZQo+
IGtlcm5lbCwgc28gSSdtIG5vdCBzdXJlIGlmIHN1Y2ggYSBiZWhhdmlvciB3b3VsZG4ndCBiZSBy
ZWplY3RlZC4gQWRkaW5nCj4gRGFuaWVsIHRvIGNvbW1lbnQgb24gdGhpcyBhcyB3ZWxsLgo+Cj4g
RmVsaXggaGFkIHNvbWUgcmVhbGx5IGdvb2QgYXJndW1lbnRzIHRvIG1ha2UgdGhhdCBhbiB1cmdl
bnQgZml4LCBzbwo+IGVpdGhlciB3ZSBjb21lIHVwIHdpdGggc29tZSByZWFsIHJld29yayBvZiB0
aGlzIG9yIGF0IGxlYXN0IGFkZCBhIGJpZwo+ICIvKiBUT0RPLi4uLiovIi4KCkFzaWRlIGZyb20g
IkkgaGF2ZSBxdWVzdGlvbnMiIEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhbnkgcmVhc29uIHRvIG5v
CmZpeCB0aGlzIGNvcnJlY3RseSB3aXRoIG11dGV4X2xvY2tfbmVzdF9sb2NrLiBSZWFsbHkgc2hv
dWxkbid0IGJlIGEKc2VtYW50aWMgY2hhbmdlIGZyb20gd2hhdCBJJ20gdW5kZXJzdGFuZCBoZXJl
LgoKQ2hlZXJzLCBEYW5pZWwKCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+ID4KPiA+IFJl
Z2FyZHMsCj4gPiBDaHJpc3RpYW4uCj4gPgo+CgoKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUg
RW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
