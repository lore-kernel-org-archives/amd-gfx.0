Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB0BC432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897EA20637
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897EA20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B956E07D;
	Tue, 26 Nov 2019 12:03:59 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622D589C6A;
 Tue, 26 Nov 2019 12:03:58 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id a11so7336715ybc.9;
 Tue, 26 Nov 2019 04:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Egcgiemhj8kre9EwT0ub5jfvwRsXmfoi8C5NLd8n6QA=;
 b=IWzl3VnWTa0okL1OzX7P5C9aeeaPWMLcLMLEcBMJKLdvfg4fAhQNLDPqd7bFmhSYHV
 CssKtW/ekI+1kx4jbpwSGVzgc7LpftWf+i+W0k1X0WoNDZuEIEqeVVl7D5ItOpZ0/fnA
 +CMNY3wD2hmfouGU6dr3VfQNnGEC+AL8fd+0R8NqoloGYy68Cf/fAaZKkMw8cnOLEKot
 8BCGbVImBzM60g/uuC2pOHZuMceKrRko8faPUbpE6IGOwW1zmBOP42g5Rirx2XfhzcNo
 Vl23pqQxff90K0LivHfdR33zpVopLi5Hb6idvVzfXI3gdLJ/KuWjRiOmVK34e4jqo48e
 88MQ==
X-Gm-Message-State: APjAAAWKZmdw9d65igk8DEpTxQCfGnHuesAyibn/f9IaICr6H4OVCwlD
 nks6dUsLXOhBTlQ1LklGhM8=
X-Google-Smtp-Source: APXvYqwzhk3EvpMHx9R4LOt9G22XV5QDzuY58AGGtCc0boix+8zD+ryTP2XZqrT5LZKyP2VfoQxUVA==
X-Received: by 2002:a25:6385:: with SMTP id
 x127mr27188029ybb.468.1574769837209; 
 Tue, 26 Nov 2019 04:03:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e198sm5284853ywe.96.2019.11.26.04.03.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 04:03:56 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Drop Rex Zhu for amdgpu powerplay
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20191122191841.441550-1-alexander.deucher@amd.com>
 <MN2PR12MB3344BBC1DD8197F263BAFC63E44A0@MN2PR12MB3344.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9539dac8-d9be-7615-d1aa-05fb208c1d65@gmail.com>
Date: Tue, 26 Nov 2019 13:03:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3344BBC1DD8197F263BAFC63E44A0@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Egcgiemhj8kre9EwT0ub5jfvwRsXmfoi8C5NLd8n6QA=;
 b=i3O7HEMzfG11JZvmHLcL2p9WU1rXde1Na5ndT5QrH2Vs3xLCD6N5pU8WcABVbLI+xX
 iOC+UivyHHpvYEiBstUUbb0Oy+rin68JoyuJS5BEPdlGL5r9CVZmamm8L1sDHhOHo5Y9
 2DBjo00gEhq9ZiY8RJPWwQGjipWlMWevBC2YXv3k8N2Oe8cc0sRbFqP0Jgp2cLsmjlfX
 cVoRGWRdcmQvoXuJcIe447f/9UFbpjXJM7h28wC6MMfhzZV5KoE/WGLi+vuNDUZosMCU
 ZJpwFxc/qdiejhwPv42mSFeR096KQ/lazNj58DkwJn87IBKBZNa1yA/8tcjlHEK0FvkO
 qFTQ==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126120354.xBF_ADacaZKIOFuRsQqOGXbzt3jV9h-5viUtNJM74eg@z>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
CkFtIDI1LjExLjE5IHVtIDA2OjMwIHNjaHJpZWIgUXVhbiwgRXZhbjoKPiBSZXZpZXdlZC1ieTog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPgo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPiBPbiBCZWhhbGYgT2YgQWxleAo+PiBEZXVjaGVyCj4+IFNlbnQ6IFNhdHVyZGF5LCBOb3Zl
bWJlciAyMywgMjAxOSAzOjE5IEFNCj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+PiBTdWJqZWN0OiBbUEFUQ0hdIE1BSU5U
QUlORVJTOiBEcm9wIFJleCBaaHUgZm9yIGFtZGdwdSBwb3dlcnBsYXkKPj4KPj4gTm8gbG9uZ2Vy
IHdvcmtzIG9uIHRoZSBkcml2ZXIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+ICAgTUFJTlRBSU5FUlMgfCAxIC0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvTUFJ
TlRBSU5FUlMgYi9NQUlOVEFJTkVSUwo+PiBpbmRleCBiNjNjMjkxYWQwMjkuLmQ1MTg1ODhiOTg3
OSAxMDA2NDQKPj4gLS0tIGEvTUFJTlRBSU5FUlMKPj4gKysrIGIvTUFJTlRBSU5FUlMKPj4gQEAg
LTg1Niw3ICs4NTYsNiBAQCBTOglNYWludGFpbmVkCj4+ICAgRjoJZHJpdmVycy9pMmMvYnVzc2Vz
L2kyYy1hbWQtbXAyKgo+Pgo+PiAgIEFNRCBQT1dFUlBMQVkKPj4gLU06CVJleCBaaHUgPHJleC56
aHVAYW1kLmNvbT4KPj4gICBNOglFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+PiAgIEw6
CWFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+ICAgUzoJU3VwcG9ydGVkCj4+IC0tCj4+
IDIuMjMuMAo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlCj4+IGRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGYW1kLQo+PiBnZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2V2YW4ucXVhbiU0MGFtZC5j
b20lN0NhNjRjYTg1YTdjNGE0MWMyZDUKPj4gMjQwOGQ3NmY4MGQxOTElN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3Cj4+IDEwMDQ3MTQyNDY2NzE1MiZhbXA7
c2RhdGE9SWxuR2hGSDFqSExURms2TmZMc1pOR0klMkZDN1FOY1lyRVI3VEdHCj4+IHVNYlZFNCUz
RCZhbXA7cmVzZXJ2ZWQ9MAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
