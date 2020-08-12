Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400EDC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 14:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCA420838
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAR/xXia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCA420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97F889BB2;
	Wed, 12 Aug 2020 14:06:31 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B1989BB2;
 Wed, 12 Aug 2020 14:06:31 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id p24so2373813ejf.13;
 Wed, 12 Aug 2020 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=d8f3pH5/ZCKSKStfszgIlZxnw3uyn/996p8sG8HyjxQ=;
 b=fAR/xXiaC+iP55fNn6oDuokITntCFEBi1xlzqIOiXdpufTT+WXrxe16rF8df2MiHZY
 er7UtqFH2MHRU7xYYD1IApTAK7fdlpfxic9pzjkwK5cY5cYUmVOs2zgzIvB8c+XvSiZR
 3L25GBDd93gJK37iUq3pqEhk5NLOUD9oT6bLhsIDtTdX/ne0Yg0xt9gS1NnFCxJxEQIB
 sskLpOZFE0XZFdBoFghrvl7obOn7ywiRYPOrKLFwLku3v746zDYlZPGdpOyW7kwQ8mQJ
 Wf8ihmeQWtY7mcxKWzJxDDH4F7cARHazoA3nwmdj5ULhEOfNu4ehVklCkuUeqEuOJ+vS
 FrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=d8f3pH5/ZCKSKStfszgIlZxnw3uyn/996p8sG8HyjxQ=;
 b=HvDHOsX0IEK9lI9FxinbPobQyMOQnXlh/ehVOz1kuAiaVe0AknoRuAhEFOr6J0i5cx
 cgpBxxIFJWL4RDoU7RkTucD/hxAomjGniF8P7VXHFrTt4qkUUw30zk2+3vmlqJohpOgI
 CJpee5x1Apjpts2lpVIuxbONaSSD7TrSXpj05SLGq1uv5EYrdLZVuI1Ias7GPO4juP5w
 XOTJL4xtSTx70ff2tVxDQwvUVhMMpQIwZd7PL7aZyAwHle5i8lYEeNoELcAHSKH+uUx1
 QttCVBkMv34AL0GMZnQXXD/Ts44is2Y0JfbUBmjpwne0LQyrLEG347lcmDZ7WRpA8rM6
 yQZA==
X-Gm-Message-State: AOAM530aYbCch0rXb28DQpxV1Lrb+GphR+ByjOcSf4Xg7gnXvXCHw+mM
 Nfnk4FO5xXsu2Vg0+Uc+3uE=
X-Google-Smtp-Source: ABdhPJznwOGp/qyo5pGS6jX40SdNtqxQhEKTMsJPS7+o051ebKYTfT0qr3V1BC6oqvTcaOqZcyqkbw==
X-Received: by 2002:a17:906:140e:: with SMTP id
 p14mr31966727ejc.430.1597241189936; 
 Wed, 12 Aug 2020 07:06:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id gl20sm1674979ejb.86.2020.08.12.07.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 07:06:28 -0700 (PDT)
Subject: Re: RFC: How to adjust the trace pid?
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Ingo Molnar <mingo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
 <CAKMK7uF7nTgJE38Krhnw9Ca4FtFpw4b=nFr8-tWqPxTkRrh=Pw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dca018cb-8455-874f-7473-fbfbd1d4c7a9@gmail.com>
Date: Wed, 12 Aug 2020 16:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uF7nTgJE38Krhnw9Ca4FtFpw4b=nFr8-tWqPxTkRrh=Pw@mail.gmail.com>
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
Cc: Shashank.Sharma@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMDguMjAgdW0gMTU6NDkgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFdlZCwgQXVn
IDEyLCAyMDIwIGF0IDM6NDIgUE0gQ2hyaXN0aWFuIEvDtm5pZwo+IDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IFBpbmc/IERhbmllbCwgRGF2ZSBhbnkgb3Bpbmlv
biBvbiB0aGlzPwo+IFR5cGUgcGF0Y2gsIGNjOiB0cmFjaW5nIHBlb3BsZSwgc2VlIHdoYXQgdGhl
eSBzYXk/CgpBZGRpbmcgSW5nbyBhbmQgU3RldmVuIHRoZW4uCgo+IHRiaCBJIGhhdmUgbm8gaWRl
YSwKPiBidXQgdGhleSBoYXZlIGJlZW4gbWFraW5nIHVuaGFwcHkgbm9pc2VzIGFib3V0IHNvbWUg
b2YgdGhlIHRyaWNrcwo+IHdlJ3ZlIHBsYXllZCBpbiB0aGUgcGFzdCBpbiBpOTE1IHRyYWNlcG9p
bnRzLiBTbyBub3QgZXZlcnl0aGluZyBpcwo+IGNvb2wgaW4gdGhlcmUuCgpXZWxsIHRoYXQgd2Fz
IHRoZSBmZWVkYmFjayBJIHdhcyBsb29raW5nIGZvci4KCj4gT3RoZXJ3aXNlIEkgZ3Vlc3MganVz
dCBhZGQgYW5vdGhlciB0cmFjZXBvaW50IHBhcmFtZXRlciB0byBkdW1wIHRoZQo+IGNvcnJlY3Qg
dXNlcnNwYWNlIG1tLgoKV2VsbCB0aGUgdHJhY2luZyBzdWJzeXN0ZW0gbG9va3MgbGlrZSByYXRo
ZXIgY29tcGxpY2F0ZWQgbWFjcm8gbWFnaWMsIHNvIApJJ20gbm90IHRvdWNoaW5nIHRoYXQgYmVm
b3JlIHNwZWFraW5nIHRvIGhlIG1haW50YWluZXIgd2hhdCBhcHByb2FjaCB3ZSAKc2hvdWxkIHRh
a2UuCgo+IDNyZCBvcHRpb24gY291bGQgYmUgdG8gZHVtcCB0aGUgY3VycmVudCBtbSAoc2luY2Ug
SSdtIGFzc3VtaW5nIHRob3NlCj4gdGhyZWFkcyBkbyBrdGhyZWFkX3VzZS91bnVzZV9tbSB0byBp
bXBlcnNvbmF0ZSB0aGUgcmlnaHQgdXNlcnNwYWNlCj4gcHJvY2VzcyBjb3JyZWN0bHkpIGluIHRo
ZSB0cmFjZXBvaW50IGluZnJhc3RydWN0dXJlIHRvbz8KCk5vcGUsIHdlIGRvbid0IHVzZSBrdGhy
ZWFkX3VzZS91bnVzZV9tbSBzaW5jZSB3ZSBkb24ndCB0b3VjaCB0aGUgcHJvY2VzcyAKd2hpY2gg
aW5pdGlhdGVkIHRoZSBvcGVyYXRpb24gaW4gYW55IHdheS4KClRoaXMgaXMganVzdCB0byBpbXBy
b3ZlIGRlYnVnZ2luZyBzaW5jZSBpdCBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZSB0byAKdHJhY2Ug
dGhlIHBpZCBvZiB0aGUgd29ya2VyIHRocmVhZC4gQW5kIHNpbmNlIHdlIGhhdmUgdGhlIHBpZCBv
ZiB0aGUgCmluaXRpYXRvciBhcm91bmQgYW55d2F5IHVzaW5nIGl0IHNob3VsZCBiZSB0cml2aWFs
LgoKUXVlc3Rpb24gaXMgcmF0aGVyIGhvdyB0byBkbyBpdCBjb3JyZWN0bHk/IEkgY291bGRuJ3Qg
ZmluZCBtdWNoIApwcmVjZWRlbmNlIGZvciB0aGlzLgoKVGhhbmtzLApDaHJpc3RpYW4uCgo+Cj4g
Q2hlZXJzLCBEYW5pZWwKPgo+PiBDaHJpc3RpYW4uCj4+Cj4+IEFtIDA3LjA4LjIwIHVtIDE1OjM2
IHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+IEhpIGV2ZXJ5Ym9keSwKPj4+Cj4+PiBpbiBh
bWRncHUgd2UgZ290IHRoZSBmb2xsb3dpbmcgaXNzdWUgd2hpY2ggSSdtIHNlZWtpbmcgYWR2aXNl
IGhvdyB0byBjbGVhbmx5IGhhbmRsZSBpdC4KPj4+Cj4+PiBXZSBoYXZlIGEgYnVuY2ggb2YgdHJh
Y2UgcG9pbnRzIHdoaWNoIGFyZSByZWxhdGVkIHRvIHRoZSBWTSBzdWJzeXN0ZW0gYW5kIGV4ZWN1
dGVkIGluIGVpdGhlciBhIHdvcmsgaXRlbSwga3RocmVhZCBvciBmb3JlaWduIHByb2Nlc3MgY29u
dGV4dC4KPj4+Cj4+PiBOb3cgdHJhY2luZyB0aGUgcGlkIG9mIHRoZSBjb250ZXh0IHdoaWNoIHdl
IGFyZSBleGVjdXRpbmcgaW4gaXMgbm90IHJlYWxseSB0aGF0IHVzZWZ1bCwgc28gSSdtIHdvbmRl
cmluZyBpZiB3ZSBjb3VsZCBqdXN0IG92ZXJ3cml0ZSB0aGUgcGlkIHJlY29yZGVkIGluIHRoZSB0
cmFjZSBlbnRyeT8KPj4+Cj4+PiBUaGUgZm9sbG93aW5nIHBhdGNoIGRvZXMgZXhhY3RseSB0aGF0
IGZvciB0aGUgdm1fZ3JhYl9pZCgpIHRyYWNlIHBvaW50LCBidXQgSSdtIG5vdCAxMDAlIHN1cmUg
aWYgdGhhdCBpcyBsZWdhbCBvciBub3QuCj4+Pgo+Pj4gQW55IGlkZWFzPyBDb21tZW50cz8KPj4+
Cj4+PiBUaGFua3MsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
