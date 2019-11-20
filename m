Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE0C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1748220715
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1748220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB9E6E116;
	Wed, 20 Nov 2019 08:43:53 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0292E6E116
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:43:52 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id b18so25647074wrj.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 00:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Wpf5IK2z8zhka31g+qLl/ydVrIvL+7zH2dkK+na10hA=;
 b=rWejBwpS882EtWLFQlxpk83hK9EI5Q+O+dcWVXPksj0X/pNVtzW2cWkVmfmsKPKxUD
 LB8HqzGUuyQN0K1lMMyqwzVqvLQuv5FBKQM2vyEMmLfYCRpgcW4ehsIHF+/JjC6IklxN
 4a5kBFM/znNQnW1zGxpuFor7wgVXM3H2NV4GTxA5rV1KocKz9cLqmGOnSZHtqqte1Lev
 BMEEGslQu45Mo66Ifdc++91a/1LSbkn2vE85wrJ3kuKxCbN+P2iFAEpxrtxQ/YKsn+Fg
 lBCl0ASYcot3dZaXRCaLodGB0qLqKJi1Iiy+t+oBLO0D3Lg14lkOc/s7yvQTLJlaUDKq
 JqxA==
X-Gm-Message-State: APjAAAXfX3aeHWdohysOnNpTcM1hJ9ga7RdPVr+rhm+aLMvag7hZ4KOT
 50ipK5zlhjz+0p4WmTp5E6mdOpcy
X-Google-Smtp-Source: APXvYqzZiytQEG3wpQtKifPzdLsvJAlwJBkjt+KqvELnFm6DVd76OqCF7zDCA/M+4SMxruNy8QRwpA==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr1716168wrt.36.1574239431440;
 Wed, 20 Nov 2019 00:43:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id m3sm32688410wrb.67.2019.11.20.00.43.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Nov 2019 00:43:50 -0800 (PST)
Subject: Re: Potential BUG: [PATCH 2/8] drm/amdgpu: add a generic fb accessing
 helper function(v3)
To: Luben Tuikov <luben.tuikov@amd.com>, Iago Abal <iago.abal@gmail.com>,
 "Tianci.Yin" <tianci.yin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <CAGbDTvpmPfrK=7a=mbnR-gKgi2ah+w6AeGYDU+9M9JOnWTzhBQ@mail.gmail.com>
 <2361d8f1-c43b-9581-5957-76deb15d3ef3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4095ae44-4b16-54a2-7acd-364b539c40b8@gmail.com>
Date: Wed, 20 Nov 2019 09:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2361d8f1-c43b-9581-5957-76deb15d3ef3@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Wpf5IK2z8zhka31g+qLl/ydVrIvL+7zH2dkK+na10hA=;
 b=N8j6zA3uQlS8dDd3J89bWasmJNAxLrtaz3L0N/tgH9cukvR7+KQyAQSxlEPezGqJPF
 1DbWdj8gvfrlXBVbMp/fOdqsrbCJbUQkW8JIK2iGot+QUzKXSBdEFHiWYi4kpCFbT8nS
 hgW8ajsTb/S6Ur7IV0D1c/Idf9X9LvRJoROzLarAS8rx/96oOqVN/paIZ6AJEYRXEzfx
 EDKT98gP+LwYgA3pNh4klgRypI4SbpEZtFOUqzvfczB1HaaQQnn/WRE+9NnehFlugnBt
 KqLwxUN2ZaoWKlSThveJnulPwr+L2X1LO2dtUX5AX1bu1cY/EuPb9VbuLJGWCzAeiuOr
 O3Tg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120084349.H8FNldWju_QtKd5YqS0_AnS8C7PV0sLlk8WgEg4fOhc@z>

SGkgTHViZW4gJiBJYWdvLAoKbm8gdGhlIGNvZGUgaXMgY29tcGxldGVseSBjb3JyZWN0IGFuZCBp
bnRlbnRpb25hbCBsaWtlIHRoaXMuCgpTZWUgdGhlIGNvZGUgcGF0aCB3aGljaCB0YWtlcyB0aGUg
bG9jayBpbiBhbWRncHVfbW1fd3JlZygpIGlzIGEgCndvcmthcm91bmQgd2hlbiB0aGUgcm1taW9f
c2l6ZSBkb2Vzbid0IGFsbG93IGFjY2VzcyB0byB0aGUgZnVsbCByZWdpc3RlciAKQkFSLgoKSW4g
dGhpcyBjYXNlIHRoZSBNTV9JTkRFWC9NTV9EQVRBIHJlZ2lzdGVycyBhcmUgdXNlZCBhcyBzaWRl
IHBhdGggYW5kIApiZWNhdXNlIG9mIHRoaXMgd2UgbmVlZCB0aGUgbG9jay4KCkJ1dCB0aGlzIGNh
c2UgY2FuJ3QgaGFwcGVuIHdoZW4geW91IHVzZSB0aGUgTU1fSU5ERVgvTU1fREFUQSBwYWlyIApk
aXJlY3RseSBhcyBwYXJhbWV0ZXJzIGZvciB0aGUgZnVuY3Rpb24uCgpSZWdhcmRzLApDaHJpc3Rp
YW4uCgpBbSAyMC4xMS4xOSB1bSAwMToyMyBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPiBIaSBJYWdv
LAo+Cj4gVGhhbmsgeW91IGZvciBmaW5kaW5nIGFuZCByZXBvcnRpbmcgdGhpcyBwb3RlbnRpYWwg
ZG91YmxlIGxvY2suCj4KPiBZZXMgaW5kZWVkLCBJIHNlZSBpdC0taXQgY2FuIGluZGVlZCBoYXBw
ZW4uCj4KPiBOb3csIHNpbmNlIHRoZSBwcmltaXRpdmVzIHVzZWQtLW1hY3JvcyB1c2luZyAiYW1k
Z3B1X21tXyhyfHcpcmVnXCguKlwpIi0taW4KPiAiYW1kZ3B1X2RldmljZV92cmFtX2FjY2Vzcygp
IiBkbyB1c2UgdGhlaXIgb3duIHJlZ2lzdGVyLWFjY2VzcyBzcGlubG9ja3MsCj4gaXQgbWF5YmUg
d2lzZSB0byByZW1vdmUgdGhlIHNwaW5sb2NrIHRha2UvcmVsZWFzZSBpbiAiYW1kZ3B1X2Rldmlj
ZV92cmFtX2FjY2VzcygpIi4KPgo+IFdlJ2xsIGxvb2sgaW50byBpdCBhbmQgcG9zc2libHkgc3Vi
bWl0IGFub3RoZXIgcGF0Y2guCj4KPiBUaGFua3MgYWdhaW4uCj4KPiBSZWdhcmRzLAo+IEx1YmVu
Cj4KPiBPbiAyMDE5LTExLTE2IDExOjIxIGEubS4sIElhZ28gQWJhbCB3cm90ZToKPj4gSGksCj4+
Cj4+IFdpdGggdGhlIGhlbHAgb2YgYSBzdGF0aWMgYnVnIGZpbmRlciAoRUJBIC0gaHR0cHM6Ly9n
aXRodWIuY29tL0lhZ29BYmFsL2ViYSkgSSBoYXZlIGZvdW5kIGEgcG90ZW50aWFsIGRvdWJsZSBs
b2NrIGluIExpbnV4IE5leHQgdGFnIG5leHQtMjAxOTExMTUsIGZpbGUgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jLgo+Pgo+PiBUaGlzIGJ1ZyBzZWVtcyB0byBiZSBp
bnRyb2R1Y2VkIGJ5IGNvbW1pdAo+PiBlMzVlMmIxMTdmNCAoImRybS9hbWRncHU6IGFkZCBhIGdl
bmVyaWMgZmIgYWNjZXNzaW5nIGhlbHBlciBmdW5jdGlvbih2MykiKS4KPj4KPj4gVGhlIHN0ZXBz
IHRvIHJlcHJvZHVjZSBpdCB3b3VsZCBiZToKPj4KPj4gMS4gU3RhcnQgaW4gZnVuY3Rpb24gYGFt
ZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3NgLgo+PiAyLiBFbnRlciBmb3ItbG9vcCBgZm9yIChsYXN0
ICs9IHBvczsgcG9zIDw9IGxhc3Q7IHBvcyArPSA0KWAuCj4+IDMuIEZpcnN0IGxvY2s6IGBzcGlu
X2xvY2tfaXJxc2F2ZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpYC4KPj4gNC4gQ2FsbCB0
byBgV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQzMl90KXBvcykgfCAweDgwMDAwMDAw
KWAuCj4+ICDCoCDCoDUuIE5vdGUgYCNkZWZpbmUgV1JFRzMyX05PX0tJUShyZWcsIHYpIGFtZGdw
dV9tbV93cmVnKGFkZXYsIChyZWcpLCAodiksIEFNREdQVV9SRUdTX05PX0tJUSlgLgo+PiAgwqAg
wqA2LiBDb250aW51ZSBpbiBmdW5jdGlvbiBgYW1kZ3B1X21tX3dyZWdgLgo+PiAgwqAgwqA3LiBU
YWtlIGVsc2UtYnJhbmNoIGluIHRoZSB0aGlyZCBpZi1zdGF0ZW1lbnQuCj4+ICDCoCDCoDguIERv
dWJsZSBsb2NrOiBgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdz
KWAuCj4+Cj4+IEkgdGhpbmsgdGhlIGNvbnRyb2wgZmxvdyBjb3VsZCByZWFjaCB0aGF0IHNlY29u
ZCBsb2NrLCBidXQgeW91IG1heSBrbm93IGJldHRlci4KPj4KPj4gSG9wZSBpdCBoZWxwcyEKPj4K
Pj4gLS0gaWFnbwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
