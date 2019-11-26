Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF036C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 16:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1782071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 16:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1782071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9796E435;
	Tue, 26 Nov 2019 16:31:46 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE376E435
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 16:31:45 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l17so3929861wmh.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 08:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uPBfbHLHOYnIiwhEVXI/vwNgpQ7AIVeNxZVm2uDVPx8=;
 b=b4Fb/KFYLoTL4U48hwSfp1BE9g1RzpoFpep4UyrtIwHW+DXxsJH7krg2/8nG35Vpun
 MQCuOgRp6N3cc4VlHDhXWjn1cE50Nc3Lr3c8l4ZUXchI7t8kbFbQNxft7ZUT+yAXpEDt
 VhN9dOqvftVM0r64JAjy9jH8+1swX9E3eOymLggVdb80+exV3NMfd+l9jfgmP+3wMl28
 0Zta6ev/kOxKdq1qFHFy4y5jddCQLQlRIDu3MdQ0KUON8g3rf/2eYeEANT8cUI79iw4B
 Ipg8Nkiq9TovWmvtW3R6f1ZbIyeuT4S4nTzef7W5SEBfmOu7dCTUYXMnecWIHNj0sFVW
 nIrw==
X-Gm-Message-State: APjAAAWkp0Aoqwn+VyROL3Ik/juXyFC8NHesfWvNAkCmho0C1UKhmBlh
 NuzZPfC+84VM9srxXsEAikyOs1/d3pyBiH+ZiAGfPg==
X-Google-Smtp-Source: APXvYqxfGZhH9SXtCw0riPxWWxb9MQ4+9ht8XwGXmDWWF1FV+E93D1nyr6Ll4m1k9inMZSrgDwJ94DzTeyjIr8Girz0=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr5137803wmi.141.1574785904073; 
 Tue, 26 Nov 2019 08:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20191126094251.32368-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191126094251.32368-1-xiaojie.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Nov 2019 11:31:32 -0500
Message-ID:
 <CADnq5_M4LKy0vv08=oYpMRO1Fedxtz_HtokeFwbhxEwPLp9+8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: unlock srbm_mutex after queue
 programming finish
To: Xiaojie Yuan <xiaojie.yuan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=uPBfbHLHOYnIiwhEVXI/vwNgpQ7AIVeNxZVm2uDVPx8=;
 b=cxpTt2RFVIKiV6/SYqR7WyJYlL7rYc5rCTEpweOz+MneEBrl1297b2xrmKcref/K/H
 jJaNFKQYHg4HO/eMk5GOEJnhatI3/IrQ6CQe4uxrTqef59flyGg6i0mEGuy2MkdpyEip
 yiF9WovpvbpDanGmGgv2QcXhSqC33pPI3lELm/fvJLO8Unf0/X2aywHFb5RS7qNjaOsl
 byWngyaMMUCw7pUKSbfyBnZaoSupqF/aw1NYo/WKMYoLnkJYq/6nsiN6pbpkh/r21hvg
 61/jbHnqtGfGGu1cuQr6B7FLQCkXLysKy06hYMLrQ4Bibj9Yhh+G09ts0OOCByzBXXsZ
 E3Og==
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
Cc: Jack Xiao <jack.xiao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126163132.EoSOfoijf2JLWLC7pLWNDkKBi8H59U2sb6RzFrjI4Sc@z>

T24gVHVlLCBOb3YgMjYsIDIwMTkgYXQgNDo0MyBBTSBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVh
bkBhbWQuY29tPiB3cm90ZToKPgo+IHNyYm1fbXV0ZXggaXMgdG8gZ3VhcmFudGVlIGF0b21pY2l0
eSBmb3Igci93IG9mIGdmeCBpbmRleGVkIHJlZ2lzdGVycwo+Cj4gU2lnbmVkLW9mZi1ieTogWGlh
b2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDUgKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCj4gaW5kZXggNmJkOGQwNmRiZGU5Li44NmRiNDA3MTdkMzggMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IEBAIC0yNzQyLDcgKzI3NDIsNyBAQCBz
dGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+ICAgICAgICAgLyogSW5pdCBnZnggcmluZyAwIGZvciBwaXBlIDAgKi8KPiAgICAgICAg
IG11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwo+ICAgICAgICAgZ2Z4X3YxMF8wX2NwX2dm
eF9zd2l0Y2hfcGlwZShhZGV2LCBQSVBFX0lEMCk7Cj4gLSAgICAgICBtdXRleF91bmxvY2soJmFk
ZXYtPnNyYm1fbXV0ZXgpOwo+ICsKPiAgICAgICAgIC8qIFNldCByaW5nIGJ1ZmZlciBzaXplICov
Cj4gICAgICAgICByaW5nID0gJmFkZXYtPmdmeC5nZnhfcmluZ1swXTsKPiAgICAgICAgIHJiX2J1
ZnN6ID0gb3JkZXJfYmFzZV8yKHJpbmctPnJpbmdfc2l6ZSAvIDgpOwo+IEBAIC0yNzgwLDExICsy
NzgwLDExIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2NwX2dmeF9yZXN1bWUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4gICAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfUkJfQUNU
SVZFLCAxKTsKPgo+ICAgICAgICAgZ2Z4X3YxMF8wX2NwX2dmeF9zZXRfZG9vcmJlbGwoYWRldiwg
cmluZyk7Cj4gKyAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwo+Cj4gICAg
ICAgICAvKiBJbml0IGdmeCByaW5nIDEgZm9yIHBpcGUgMSAqLwo+ICAgICAgICAgbXV0ZXhfbG9j
aygmYWRldi0+c3JibV9tdXRleCk7Cj4gICAgICAgICBnZnhfdjEwXzBfY3BfZ2Z4X3N3aXRjaF9w
aXBlKGFkZXYsIFBJUEVfSUQxKTsKPiAtICAgICAgIG11dGV4X3VubG9jaygmYWRldi0+c3JibV9t
dXRleCk7Cj4gICAgICAgICByaW5nID0gJmFkZXYtPmdmeC5nZnhfcmluZ1sxXTsKPiAgICAgICAg
IHJiX2J1ZnN6ID0gb3JkZXJfYmFzZV8yKHJpbmctPnJpbmdfc2l6ZSAvIDgpOwo+ICAgICAgICAg
dG1wID0gUkVHX1NFVF9GSUVMRCgwLCBDUF9SQjFfQ05UTCwgUkJfQlVGU1osIHJiX2J1ZnN6KTsK
PiBAQCAtMjgxNCw2ICsyODE0LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X3Jlc3Vt
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgICAgICAgIFdSRUczMl9TT0MxNShHQywg
MCwgbW1DUF9SQjFfQUNUSVZFLCAxKTsKPgo+ICAgICAgICAgZ2Z4X3YxMF8wX2NwX2dmeF9zZXRf
ZG9vcmJlbGwoYWRldiwgcmluZyk7Cj4gKyAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPnNyYm1f
bXV0ZXgpOwo+Cj4gICAgICAgICAvKiBTd2l0Y2ggdG8gcGlwZSAwICovCj4gICAgICAgICBtdXRl
eF9sb2NrKCZhZGV2LT5zcmJtX211dGV4KTsKPiAtLQo+IDIuMjAuMQo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
