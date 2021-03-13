Return-Path: <SRS0=AASI=IL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5282BC433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 10:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E936064F18
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 10:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E936064F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939FA6E0F3;
	Sat, 13 Mar 2021 10:15:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E4C89DB5
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615626328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwD5LMOgKeRPZ5nSkFEP+M5N1M+YvkcuNUmSBezDSQg=;
 b=HGPmzYJH6Z6iK/HHrsMfw6XklpFbfVo7yIH/61ANYCqfZIjQHFeAs+uvpkuBc94OT863eG
 zaA4DyXli2nuKOx8r1TH0o8IP32uUf1einGDcODgQ4G2aSH4FSbwzbhol8JkoN+yazPyMa
 V5uUSZ3iC7XQC3s4/Q7rk98w23zzzNQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-IgPHkCzfOLKjvH0l44dGHA-1; Sat, 13 Mar 2021 04:05:26 -0500
X-MC-Unique: IgPHkCzfOLKjvH0l44dGHA-1
Received: by mail-ed1-f72.google.com with SMTP id f9so8561791edd.13
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 01:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=NchNRTSEGkiqYTAyE/uiRINWxzMLW7q/Qg9kJjYYUV8=;
 b=ofTzlz7dmueZWwpQAFXcgcHpeVsYJsvcQEAQTif7tVw9x+kJM/eoS4gm3C4cLODEj4
 sNL9afAtasalwZhHptE6f93CFpc4KepY183OWUy1G0ZCOEJ8TFPKfPEjM0F9dL8KKMYo
 dEMcMHZQw1RAY2Q1yCelfrQWX57KpZmG3rd7Bx+68ks11DgqxBCAQ9JQgJfo6Nxz0bFI
 s2Q42kNl2/AThpLe25YVWzf4F6r/BEBLbb3qNgf+h8CQjGePshBDmStLibNBdTqRmkND
 qS/oFmpYFxe0UycB2SEmpZ1NplEJBfxZqCX5CKAE6qEXDOhREfZpk6NMm7EIV0MVws0J
 JWUw==
X-Gm-Message-State: AOAM532Cp+F8wxUuWLR1kMNiLge3+FFsOGepM7/hsyW1gMSMTmvxrNXT
 bkEnHWPi/pEbtXAWchdTIgfzA6qPaeeOrW502HqCdEYTAMK6NA27vWM6tGFmC3g8/b1QXZDPb75
 gJeMU+Dm2sL0/wCRsJSJbogdz3Q==
X-Received: by 2002:a05:6402:1d33:: with SMTP id
 dh19mr18681219edb.362.1615626325550; 
 Sat, 13 Mar 2021 01:05:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjqpozZGLXrOMTuUlFEgJyDdDMB8J3TH5iIeMOahQvz63gH7NYmRPQkaJGZfjOHxqndDpeYg==
X-Received: by 2002:a05:6402:1d33:: with SMTP id
 dh19mr18681207edb.362.1615626325366; 
 Sat, 13 Mar 2021 01:05:25 -0800 (PST)
Received: from [192.168.3.108] (p4ff236b2.dip0.t-ipconnect.de. [79.242.54.178])
 by smtp.gmail.com with ESMTPSA id k9sm4364576edn.68.2021.03.13.01.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Mar 2021 01:05:24 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Date: Sat, 13 Mar 2021 10:05:23 +0100
Message-Id: <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
To: "Liang, Liang (Leo)" <Liang.Liang@amd.com>
X-Mailer: iPhone Mail (18D52)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Sat, 13 Mar 2021 10:15:38 +0000
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
Cc: David Hildenbrand <david@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mike Rapoport <rppt@linux.ibm.com>, George Kennedy <george.kennedy@oracle.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cj4gQW0gMTMuMDMuMjAyMSB1bSAwNTowNCBzY2hyaWViIExpYW5nLCBMaWFuZyAoTGVvKSA8TGlh
bmcuTGlhbmdAYW1kLmNvbT46Cj4gCj4g77u/W0FNRCBQdWJsaWMgVXNlXQo+IAo+IEhpIERhdmlk
LAo+IAo+IFdoaWNoIGJlbmNobWFyayB0b29sIHlvdSBwcmVmZXI/IE1lbXRlc3Q4Nisgb3IgZWxz
ZT8KCkhpIExlbywKCkkgdGhpbmsgeW91IHdhbnQgc29tZXRoaW5nIHRoYXQgcnVucyB1bmRlciBM
aW51eCBuYXRpdmVseS4KCknigJhtIHBsYW5uaW5nIG9uIGNvZGluZyB1cCBhIGtlcm5lbCBtb2R1
bGUgdG8gd2FsayBhbGwgNE1CIHBhZ2VzIGluIHRoZSBmcmVlbGlzdHMgYW5kIHBlcmZvcm0gYSBz
dHJlYW0gYmVuY2htYXJrIGluZGl2aWR1YWxseS4gVGhlbiB3ZSBtaWdodCBiZSBhYmxlIHRvIGlk
ZW50aWZ5IHRoZSBwcm9ibGVtYXRpYyByYW5nZSAtIGlmIHRoZXJlIGlzIGEgcHJvYmxlbWF0aWMg
cmFuZ2UgOikgR3Vlc3MgSeKAmGxsIGhhdmUgaXQgcnVubmluZyBieSBNb25kYXkgYW5kIGxldCB5
b3Uga25vdy4KCkNoZWVycyEKCj4gCj4gQlJzLAo+IExlbwo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IAo+IFNl
bnQ6IFNhdHVyZGF5LCBNYXJjaCAxMywgMjAyMSAxMjo0NyBBTQo+IFRvOiBMaWFuZywgTGlhbmcg
KExlbykgPExpYW5nLkxpYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWQtZ2Z4
IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KPiBDYzogSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTWlrZSBS
YXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPjsgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBr
ZXJuZWwub3JnPjsgR2VvcmdlIEtlbm5lZHkgPGdlb3JnZS5rZW5uZWR5QG9yYWNsZS5jb20+Cj4g
U3ViamVjdDogUmU6IHNsb3cgYm9vdCB3aXRoIDdmZWY0MzFiZTljOSAoIm1tL3BhZ2VfYWxsb2M6
IHBsYWNlIHBhZ2VzIHRvIHRhaWwgaW4gX19mcmVlX3BhZ2VzX2NvcmUoKSIpCj4gCj4+IE9uIDEy
LjAzLjIxIDE3OjE5LCBMaWFuZywgTGlhbmcgKExlbykgd3JvdGU6Cj4+IFtBTUQgUHVibGljIFVz
ZV0KPj4gCj4+IERtZXNnIGF0dGFjaGVkLgo+PiAKPiAKPiAKPiBTbywgbG9va3MgbGlrZSB0aGUg
InJlYWwiIHNsb3dkb3duIHN0YXJ0cyBvbmNlIHRoZSBidWRkeSBpcyB1cCBhbmQgcnVubmluZyAo
bm8gc3VycHJpc2UpLgo+IAo+IAo+IFsgICAgMC4wNDQwMzVdIE1lbW9yeTogNjg1NjcyNEsvNzIw
MDMwNEsgYXZhaWxhYmxlICgxNDM0NUsga2VybmVsIGNvZGUsIDk2OTlLIHJ3ZGF0YSwgNTI3Nksg
cm9kYXRhLCAyNjI4SyBpbml0LCAxMjEwNEsgYnNzLCAzNDMzMjRLIHJlc2VydmVkLCAwSyBjbWEt
cmVzZXJ2ZWQpCj4gWyAgICAwLjA0NDA0NV0gcmFuZG9tOiBnZXRfcmFuZG9tX3U2NCBjYWxsZWQg
ZnJvbSBfX2ttZW1fY2FjaGVfY3JlYXRlKzB4MzMvMHg0NjAgd2l0aCBjcm5nX2luaXQ9MQo+IFsg
ICAgMC4wNDkwMjVdIFNMVUI6IEhXYWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBD
UFVzPTE2LCBOb2Rlcz0xCj4gWyAgICAwLjA1MDAzNl0gZnRyYWNlOiBhbGxvY2F0aW5nIDQ3MTU4
IGVudHJpZXMgaW4gMTg1IHBhZ2VzCj4gWyAgICAwLjA5NzQ4N10gZnRyYWNlOiBhbGxvY2F0ZWQg
MTg1IHBhZ2VzIHdpdGggNSBncm91cHMKPiBbICAgIDAuMTA5MjEwXSByY3U6IEhpZXJhcmNoaWNh
bCBSQ1UgaW1wbGVtZW50YXRpb24uCj4gCj4gdnMuCj4gCj4gWyAgICAwLjA0MTExNV0gTWVtb3J5
OiA2ODY5Mzk2Sy83MjAwMzA0SyBhdmFpbGFibGUgKDE0MzQ1SyBrZXJuZWwgY29kZSwgMzQzM0sg
cndkYXRhLCA1Mjg0SyByb2RhdGEsIDI2MjRLIGluaXQsIDYwODhLIGJzcywgMzMwNjUySyByZXNl
cnZlZCwgMEsgY21hLXJlc2VydmVkKQo+IFsgICAgMC4wNDExMjddIHJhbmRvbTogZ2V0X3JhbmRv
bV91NjQgY2FsbGVkIGZyb20gX19rbWVtX2NhY2hlX2NyZWF0ZSsweDMxLzB4NDMwIHdpdGggY3Ju
Z19pbml0PTEKPiBbICAgIDAuMDQxMzA5XSBTTFVCOiBIV2FsaWduPTY0LCBPcmRlcj0wLTMsIE1p
bk9iamVjdHM9MCwgQ1BVcz0xNiwgTm9kZXM9MQo+IFsgICAgMC4wNDEzMzVdIGZ0cmFjZTogYWxs
b2NhdGluZyA0NzE4NCBlbnRyaWVzIGluIDE4NSBwYWdlcwo+IFsgICAgMC4wNTU3MTldIGZ0cmFj
ZTogYWxsb2NhdGVkIDE4NSBwYWdlcyB3aXRoIDUgZ3JvdXBzCj4gWyAgICAwLjA1NTg2M10gcmN1
OiBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgo+IAo+IAo+IEFuZCBpdCBnZXRzIGVz
cGVjaWFsbHkgYmFkIGR1cmluZyBBQ1BJIHRhYmxlIHByb2Nlc3Npbmc6Cj4gCj4gWyAgICA0LjE1
ODMwM10gQUNQSTogQWRkZWQgX09TSShNb2R1bGUgRGV2aWNlKQo+IFsgICAgNC4xNTg3NjddIEFD
UEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIERldmljZSkKPiBbICAgIDQuMTU5MjMwXSBBQ1BJOiBB
ZGRlZCBfT1NJKDMuMCBfU0NQIEV4dGVuc2lvbnMpCj4gWyAgICA0LjE1OTcwNV0gQUNQSTogQWRk
ZWQgX09TSShQcm9jZXNzb3IgQWdncmVnYXRvciBEZXZpY2UpCj4gWyAgICA0LjE2MDU1MV0gQUNQ
STogQWRkZWQgX09TSShMaW51eC1EZWxsLVZpZGVvKQo+IFsgICAgNC4xNjEzNTldIEFDUEk6IEFk
ZGVkIF9PU0koTGludXgtTGVub3ZvLU5WLUhETUktQXVkaW8pCj4gWyAgICA0LjE2MjI2NF0gQUNQ
STogQWRkZWQgX09TSShMaW51eC1IUEktSHlicmlkLUdyYXBoaWNzKQo+IFsgICAxNy43MTM0MjFd
IEFDUEk6IDEzIEFDUEkgQU1MIHRhYmxlcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYW5kIGxvYWRl
ZAo+IFsgICAxOC43MTYwNjVdIEFDUEk6IFtGaXJtd2FyZSBCdWddOiBCSU9TIF9PU0koTGludXgp
IHF1ZXJ5IGlnbm9yZWQKPiBbICAgMjAuNzQzODI4XSBBQ1BJOiBFQzogRUMgc3RhcnRlZAo+IFsg
ICAyMC43NDQxNTVdIEFDUEk6IEVDOiBpbnRlcnJ1cHQgYmxvY2tlZAo+IFsgICAyMC45NDU5NTZd
IEFDUEk6IEVDOiBFQ19DTUQvRUNfU0M9MHg2NjYsIEVDX0RBVEE9MHg2NjIKPiBbICAgMjAuOTQ2
NjE4XSBBQ1BJOiBcX1NCXy5QQ0kwLkxQQzAuRUMwXzogQm9vdCBEU0RUIEVDIHVzZWQgdG8gaGFu
ZGxlIHRyYW5zYWN0aW9ucwo+IFsgICAyMC45NDczNDhdIEFDUEk6IEludGVycHJldGVyIGVuYWJs
ZWQKPiBbICAgMjAuOTUxMjc4XSBBQ1BJOiAoc3VwcG9ydHMgUzAgUzMgUzQgUzUpCj4gWyAgIDIw
Ljk1MTYzMl0gQUNQSTogVXNpbmcgSU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwo+IAo+IHZz
Lgo+IAo+IFsgICAgMC4yMTYwMzldIEFDUEk6IEFkZGVkIF9PU0koTW9kdWxlIERldmljZSkKPiBb
ICAgIDAuMjE2MDQxXSBBQ1BJOiBBZGRlZCBfT1NJKFByb2Nlc3NvciBEZXZpY2UpCj4gWyAgICAw
LjIxNjA0M10gQUNQSTogQWRkZWQgX09TSSgzLjAgX1NDUCBFeHRlbnNpb25zKQo+IFsgICAgMC4y
MTYwNDRdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIEFnZ3JlZ2F0b3IgRGV2aWNlKQo+IFsg
ICAgMC4yMTYwNDZdIEFDUEk6IEFkZGVkIF9PU0koTGludXgtRGVsbC1WaWRlbykKPiBbICAgIDAu
MjE2MDQ4XSBBQ1BJOiBBZGRlZCBfT1NJKExpbnV4LUxlbm92by1OVi1IRE1JLUF1ZGlvKQo+IFsg
ICAgMC4yMTYwNDldIEFDUEk6IEFkZGVkIF9PU0koTGludXgtSFBJLUh5YnJpZC1HcmFwaGljcykK
PiBbICAgIDAuMjI4MjU5XSBBQ1BJOiAxMyBBQ1BJIEFNTCB0YWJsZXMgc3VjY2Vzc2Z1bGx5IGFj
cXVpcmVkIGFuZCBsb2FkZWQKPiBbICAgIDAuMjI5NTI3XSBBQ1BJOiBbRmlybXdhcmUgQnVnXTog
QklPUyBfT1NJKExpbnV4KSBxdWVyeSBpZ25vcmVkCj4gWyAgICAwLjIzMTY2M10gQUNQSTogRUM6
IEVDIHN0YXJ0ZWQKPiBbICAgIDAuMjMxNjY2XSBBQ1BJOiBFQzogaW50ZXJydXB0IGJsb2NrZWQK
PiBbICAgIDAuMjMzNjY0XSBBQ1BJOiBFQzogRUNfQ01EL0VDX1NDPTB4NjY2LCBFQ19EQVRBPTB4
NjYyCj4gWyAgICAwLjIzMzY2N10gQUNQSTogXF9TQl8uUENJMC5MUEMwLkVDMF86IEJvb3QgRFNE
VCBFQyB1c2VkIHRvIGhhbmRsZSB0cmFuc2FjdGlvbnMKPiBbICAgIDAuMjMzNjcwXSBBQ1BJOiBJ
bnRlcnByZXRlciBlbmFibGVkCj4gWyAgICAwLjIzMzY4NV0gQUNQSTogKHN1cHBvcnRzIFMwIFMz
IFM0IFM1KQo+IFsgICAgMC4yMzM2ODddIEFDUEk6IFVzaW5nIElPQVBJQyBmb3IgaW50ZXJydXB0
IHJvdXRpbmcKPiAKPiBUaGUganVtcCBmcm9tIDQuMSAtPiAxNy43IGlzIGVzcGVjaWFsbHkgYmFk
Lgo+IAo+IFdoaWNoIG1pZ2h0IGluIGZhY3QgaW5kaWNhdGUgdGhhdCB0aGlzIGNvdWxkIGJlIHJl
bGF0ZWQgdG8gdXNpbmcgc29tZSB2ZXJ5IHNwZWNpYWwgc2xvdyAoQUNQST8pIG1lbW9yeSBmb3Ig
b3JkaW5hcnkgcHVycG9zZXMsIGludGVyZmVyaW5nIHdpdGggYWN0dWFsIEFDUEkgdXNlcnM/Cj4g
Cj4gQnV0IGFnYWluLCBqdXN0IGEgd2lsZCBndWVzcywgYmVjYXVzZSB0aGUgc3lzdGVtIGlzIGV4
dHJlbWVseSBzbG93IGFmdGVyd2FyZHMsIGhvd2V2ZXIsIHdlIGRvbid0IGhhdmUgYW55IHBhdXNl
cyB3aXRob3V0IGFueSBzaWducyBvZiBsaWZlIGZvciB0aGF0IGxvbmcuCj4gCj4gCj4gSXQgd291
bGQgYmUgaW50ZXJlc3RpbmcgdG8gcnVuIGEgc2ltcGxlIG1lbW9yeSBiYW5kd2lkdGggYmVuY2ht
YXJrIG9uIHRoZSBmYXN0IGtlcm5lbCB3aXRoIGRpZmZlcmluZyBzaXplcyB1cCB0byBydW5uaW5n
IE9PTSB0byBzZWUgaWYgdGhlcmUgaXMgcmVhbGx5IHNvbWUgbWVtb3J5IHRoYXQgaXMganVzdCBo
b3JyaWJseSBzbG93IG9uY2UgYWxsb2NhdGVkIGFuZCB1c2VkLgo+IAo+IC0tCj4gVGhhbmtzLAo+
IAo+IERhdmlkIC8gZGhpbGRlbmIKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
