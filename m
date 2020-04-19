Return-Path: <SRS0=s+k6=6D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9867C38A30
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 16:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7D6214D8
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 16:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJDqFGCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7D6214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3030F6E0C1;
	Sun, 19 Apr 2020 16:54:10 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7370C6E0C1
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 16:54:09 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id g13so7040479wrb.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=noIUK3iZQG+GSNtwy2yGBRDb5qv2/goBSbNzAJ2ZcNs=;
 b=dJDqFGCfUaxCw1/IvTSTJtT9xzhyVTQIIz/15+9wj7YxelqjL4B/HC7SQ5Ne2a6vFd
 j/VA39mVoxWg+GWFDO4LTy4wF3dltNk855zKHD/XRDoBKoPraPaCUiPIOdTW1i3L4Jkz
 T+oP5s4TF628Ycu/h76rB0/aTi4PaYc1E4GqiR+U2heFhrOFdpJ/GKX/qIJqIoduQ0HB
 NC+4mJaC37A+XvHHnW4JFO6MRuBBdI/Z4rdCuHUzqXnuFEYxLUP7AF3tWuc3HxIDa+wO
 F+rBBsrQPEf2y0eJK0aee7qBcL8vy5fEJgT5ElRRp00/J7mk1uCou7B03/HL+ec+1ien
 BTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=noIUK3iZQG+GSNtwy2yGBRDb5qv2/goBSbNzAJ2ZcNs=;
 b=J4bslHH2D+KKtQfKGP6EmsPs9Kl34M9gCJ4Sg4e2epCaGPdeZ5cts8s9slbKR1ZTml
 WZfzs2KwrbeDBAKYppk3hjnYjj0J18kqedU1UvXAZFo4WoajHMwljAoVwJj7Wei5adVT
 oTbboXc1TnI8NRBb8X1p5fyeq3OVWUGzUPY9ayVI9elG92VuzzVsNuGw5IJ0jaycv9rj
 XYmyn50/pO/5HrfuEmYEVkZKLlytjNnyH80JMNLUs/fOnD4gxuouAWWMorJp2cgX57VS
 M0fqmckRWcHaQQWXUxqcfF687BENs3W0HJuKcm6fkPjkrpGA1y3HnIQQQG2uXlOJ3n0E
 hj3g==
X-Gm-Message-State: AGi0PuZ1we9BolWbzv0rkHjwhQbXMoeFfaBY1X3HmUGk87Ii/O/aKBtp
 vYPTWLDKpwOuzq9bdvBqq4H3WYZ0
X-Google-Smtp-Source: APiQypLJPx8tijc9AQm0YdQDDIL5B4ScO6LmOPhsSIdA6yVLRmox5RaF2RYj3ZiSCIvD6RtXSO22FQ==
X-Received: by 2002:adf:f651:: with SMTP id x17mr14176737wrp.230.1587315248081; 
 Sun, 19 Apr 2020 09:54:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j13sm14703471wrq.24.2020.04.19.09.54.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 19 Apr 2020 09:54:07 -0700 (PDT)
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
To: Harry Wentland <hwentlan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
 <9442cdf7-4aef-7831-2609-4610b09e15b8@daenzer.net>
 <1bd26e82-3afe-192f-36c0-01d836329196@amd.com>
 <5732a88b-50b1-8b48-b354-906a8c2c2284@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9698c3b1-5fd0-12f0-639a-61e109d0a749@gmail.com>
Date: Sun, 19 Apr 2020 18:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5732a88b-50b1-8b48-b354-906a8c2c2284@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Wood, Wyatt" <Wyatt.Wood@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDQuMjAgdW0gMTc6NDAgc2NocmllYiBIYXJyeSBXZW50bGFuZDoKPiBPbiAyMDIwLTA0
LTE3IDg6MDkgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTcuMDQuMjAgdW0g
MTI6NDMgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMjAtMDQtMTcgMTE6MjIgYS5t
LiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBZ3JlZWQsIGp1c3Qgd2FudGVkIHRvIHJl
cGx5IGFzIHdlbGwgc2luY2UgSSB0aGluayBzb21ldGhpbmcgaXMgbm90Cj4+Pj4gY29ycmVjdGx5
IHVuZGVyc3Rvb2QgaGVyZS4KPj4+Pgo+Pj4+IFRoZSBjcHVfdG9fYmUxNigpIGFuZCBiZTE2X3Rv
X2NwdSgpIGZ1bmN0aW9ucyB3b3JrIGRpZmZlcmVudCBkZXBlbmRpbmcKPj4+PiBvbiB3aGljaCBh
cmNoaXRlY3R1cmUvZW5kaWFuZXNzIHlvdXIgYXJlLgo+Pj4+Cj4+Pj4gU28gdGhleSBzaG91bGQg
YmUgYSBOTy1PUCBvbiB4ODYgaWYgZXZlcnl0aGluZyBpcyBkb25lIHJpZ2h0Lgo+Pj4gVGhlICpi
KmUgbWFjcm9zIGFyZW4ndCBOT1BzIG9uIGxpdHRsZSBlbmRpYW4gYXJjaGl0ZWN0dXJlcyBsaWtl
IHg4NiwKPj4+IHRoZXkgYXJlIG9uIGJpZyBlbmRpYW4gYXJjaGl0ZWN0dXJlcy4gVmljZSB2ZXJz
YSBmb3IgdGhlICpsKmUgbWFjcm9zLgo+PiBZZWFoLCB0aGF0J3Mgd2hhdCBJIG1lYW50IHdpdGgg
ImlmIGV2ZXJ5dGhpbmcgaXMgZG9uZSByaWdodCIgOikKPj4KPj4gSSB1c3VhbGx5IGNhbid0IHJl
bWVtYmVyIHdoYXQgZG9lcyB3aGF0IHdpdGggdGhvc2UgZnVuY3Rpb25zLgo+Pgo+PiBDaHJpc3Rp
YW4uCj4gSSB0aGluayBrZXkgaGVyZSBpcyB0aGF0IGRtY3ViIEZXIGlzIGxpdHRsZSBlbmRpYW4s
IHdoZXJlYXMgdGhlIG9sZCBkbWN1Cj4gRlcgd2FzIGJpZyBlbmRpYW4uIEhlbmNlIHdlIGhhZCB0
aGUgY3B1X3RvX2JlIGNvbnZlcnNpb24gaGVyZSBmb3IgdGhlCj4gb2xkIGRtY3UuCj4KPiBOb3cg
aXQgbG9va3MgbGlrZSB3ZSB3YW50IHRvIHJldXNlIHRoZSBzYW1lIGZ1bmN0aW9uIGZvciBkbWN1
YiBjYWxscyBhbmQKPiBoZW5jZSBuZWVkIHRvIGVuc3VyZSB3ZSdyZSBub3QgY29udmVydGluZyB2
YWx1ZXMgdG8gYmlnLWVuZGlhbi4KPgo+IFRoZSBiaWdfZW5kaWFuIHBhcmFtZXRlciBpcyBzcGVj
aWZ5aW5nIHRoZSBlbmRpYW5uZXNzIG9mIHRoZSBGVy4KPgo+IFRoZSByaWdodCBhcHByb2FjaCB3
b3VsZCBiZSB0byBkbyBjcHVfdG9fYmUgZm9yIGRtY3UgYW5kIGNwdV90b19sZSBmb3IKPiBkbWN1
Yi4KClRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLCB0aGF0IG1ha2VzIGl0IG11Y2ggbW9yZSBj
bGVhciB3aGF0IHNob3VsZCAKaGFwcGVuIGhlcmUuCgpDaHJpc3RpYW4uCgo+Cj4gSGFycnkKPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
