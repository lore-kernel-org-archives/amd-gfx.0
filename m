Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED5CC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 19:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EED24057
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 19:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EED24057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99CF6EC4C;
	Fri, 11 Dec 2020 19:06:54 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5463F6EC4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 19:06:53 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id y24so9192456otk.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=pgGxHwlrr2gKYMmNXpy7LRiDURyR6jbR4zm589m1SLE=;
 b=uiP3dzNB3eComtVEqXAoyRULUqCL0wziPE35bR3e+FNlWZS0kx+m0I6Aq/u4IhKTmY
 Bp6OSAyErmHMXRzstpdG3XNctycQrv8oRae7fSpg3uKrnyelWYoAP+gHRkoZQHRveUQH
 CYpASC3L7XS7s6pZdhVP9yHEZtpEoyr4Jk/xFVVhj+Sx/lpUBH+ubTiuKGRfnWBYYPnt
 LhMkJtl5PTQ7ydmct6pdmE1Bflr8m2/239Dkzkd6cXqYpikzDLcSqLdO6FkpMprOVjl6
 963i9+2HJmNQbtxBZYxSBbYhjIQH3m4JRc3vYnMpM3zQVxavoAnt4J6JxmVlQ+FwWYPp
 Z9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=pgGxHwlrr2gKYMmNXpy7LRiDURyR6jbR4zm589m1SLE=;
 b=LhQIJXXIlBXCGHMHzd4VN+rTfdk7NtpAZifXm5OW9FbFeSXxE3Rs1PTYtWm6roNVmp
 lqoBse2Kcj+dSjJFiNcCReoQQyRV45urAj5lwCTdIyniGrlUcFPkAespRKccvf+nnVLA
 GoV7/5Sdlf6LlkMGYLGZIf+Zpk+YSSmCJ9APLkL7z0G2yOQJC2D3oYAzgfzWxyIAlS/4
 SX+MuP65vLcog612w4Q3DhFGjDj3KjpoF9Ib9iiwtts1xtNkhsIdSvSAzIMrmsh1bdtU
 F6FO/u9RlO7kHDnDnAl1a3bnjxPPKeoekTz6zNTxzx4Ejb92rNofEvFoXUxNAqZK4ohe
 /eWg==
X-Gm-Message-State: AOAM533CBcDUphi4qjqWGUqHuohB56Z1o9bgWF5vhgcKoS2z2BRHS6s4
 A9AqMjb8xksB36KnXjDQ6BdlrADorsuXMoG72kqu9o5U
X-Google-Smtp-Source: ABdhPJxqJmy3Zql3kmCdz5tREjdIX+yfK4vAp4my8tv1A9MOH/nIogbfQCV/UmVp5cBvv3ho5AQG5P74EFS7vsr/sT8=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr11358519ote.132.1607713612604; 
 Fri, 11 Dec 2020 11:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
 <20201211005506.4554-4-devspam@moreofthesa.me.uk>
 <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com>
 <58E2B73AC8%devspam@moreofthesa.me.uk>
In-Reply-To: <58E2B73AC8%devspam@moreofthesa.me.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Dec 2020 14:06:41 -0500
Message-ID: <CADnq5_OaJD78OOWLBOQCn1dWkAkJALqNrYmuC2E2kRL1tmeRLw@mail.gmail.com>
Subject: Re: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
To: Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Darren Salt <devspam@moreofthesa.me.uk>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBEZWMgMTEsIDIwMjAgYXQgMTo0OSBQTSBEYXJyZW4gU2FsdCA8ZGV2c3BhbUBtb3Jl
b2Z0aGVzYS5tZS51az4gd3JvdGU6Cj4KPiBJIGRlbWFuZCB0aGF0IENocmlzdGlhbiBLw7ZuaWcg
bWF5IG9yIG1heSBub3QgaGF2ZSB3cml0dGVuLi4uCj4KPiA+IEFtIDExLjEyLjIwIHVtIDAxOjU1
IHNjaHJpZWIgRGFycmVuIFNhbHQ6Cj4gW3NuaXBdCj4gPj4gKyAgICByYmFyX3NpemUgPSBwY2lf
cmViYXJfYnl0ZXNfdG9fc2l6ZShhZGV2LT5nbWMucmVhbF92cmFtX3NpemUpOwo+ID4+ICsgICAg
Y3VycmVudF9zaXplID0gcGNpX3JlYmFyX2dldF9jdXJyZW50X3NpemUoYWRldi0+cGRldiwgMCk7
Cj4gPj4gKwo+ID4+ICsgICAgLyogU2tpcCBpZiB0aGUgQklPUyBoYXMgYWxyZWFkeSBlbmFibGVk
IGxhcmdlIEJBUiwgY292ZXJpbmcgdGhlIFZSQU0gKi8KPiA+PiArICAgIGlmIChjdXJyZW50X3Np
emUgPj0gcmJhcl9zaXplKQo+Cj4gPiBZb3Ugc2hvdWxkIHByb2JhYmx5IGtlZXAgdGhlIGNvbXBh
cmlzb24gYXMgaXQgaXMgYW5kIGNoZWNrIHRoZSByZXNvdXJjZQo+ID4gbGVuZ3RoIGFnYWluc3Qg
dGhlIFZSQU0gc2l6ZSBpbnN0ZWFkLgo+Cj4gUGVyaGFwcy4gSSB3b25kZXIsIHRob3VnaCwgaWYg
SSBzaG91bGQgZG8KPgo+ICAgICBpZiAoYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplID09IDApCj4g
ICAgICAgcmV0dXJuOwo+Cj4gaW5zdGVhZCBvZiB0aGUgZmlyc3QgcGFydCBvZiB0aGUgb3JpZ2lu
YWwgY29uZGl0aW9uLgo+Cj4gW3NuaXBdCj4gPj4gKyAgICBkZXZfZGJnKGFkZXYtPmRldiwgIkJJ
T1MtYWxsb2NhdGVkIEJBUjAgd2FzICVsbHVNQjsgdHJ5aW5nIHRvIGdldCAlbGx1TUIiLAo+ID4+
ICsgICAgICAgICAgICBjdXJyZW50X3NpemUgPCAwID8gMCA6IChwY2lfcmViYXJfc2l6ZV90b19i
eXRlcyhjdXJyZW50X3NpemUpID4+IDIwKSwKPiA+PiArICAgICAgICAgICAgcGNpX3JlYmFyX3Np
emVfdG9fYnl0ZXMocmJhcl9zaXplKSA+PiAyMCk7Cj4KPiA+IFBsZWFzZSBubyBleHRyYSBkZWJ1
Z2dpbmcgb3V0cHV0LCB3ZSBzcGFtIHN5c2xvZyB0aGF0IGVub3VnaCB3aXRoIHRoZQo+ID4gZXhp
c3RpbmcgcmVzaXplLgo+Cj4gT2theSwgSSdsbCBkaXNwb3NlIG9mIHRoYXQuCj4KPiBbc25pcF0K
PiA+PiAtICAgIHIgPSBwY2lfcmVzaXplX3Jlc291cmNlKGFkZXYtPnBkZXYsIDAsIHJiYXJfc2l6
ZSk7Cj4gPj4gLSAgICBpZiAociA9PSAtRU5PU1BDKQo+ID4+IC0gICAgICAgICAgICBEUk1fSU5G
TygiTm90IGVub3VnaCBQQ0kgYWRkcmVzcyBzcGFjZSBmb3IgYSBsYXJnZSBCQVIuIik7Cj4gPj4g
LSAgICBlbHNlIGlmIChyICYmIHIgIT0gLUVOT1RTVVBQKQo+ID4+IC0gICAgICAgICAgICBEUk1f
RVJST1IoIlByb2JsZW0gcmVzaXppbmcgQkFSMCAoJWQpLiIsIHIpOwo+ID4+ICsgICAgciA9IDA7
Cj4gPj4gKyAgICBmb3IgKDsgcmJhcl9zaXplID49IDAgJiYgcmJhcl9zaXplID4gY3VycmVudF9z
aXplOyAtLXJiYXJfc2l6ZSkgewo+ID4+ICsgICAgICAgICAgICAvKiBTa2lwIHRoaXMgc2l6ZSBp
ZiBpdCBpc24ndCBhZHZlcnRpc2VkLgo+ID4+ICsgICAgICAgICAgICAgKiBUaGlzIGF2b2lkcyBw
Y2lfcmVzaXplX3Jlc291cmNlcyByZXR1cm5pbmcgLUVJTlZBTCBmb3IgdGhhdCByZWFzb24uCj4g
Pj4gKyAgICAgICAgICAgICAqLwo+ID4+ICsgICAgICAgICAgICBpZiAoIShhdmFpbGFibGVfc2l6
ZXMgJiBCSVQocmJhcl9zaXplKSkpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgY29udGludWU7
Cj4KPiA+IFdlbGwgZXhhY3RseSB0aGF0IHRyeSBhbmQgZXJyb3IgaXMgYSByYXRoZXIgYmlnIE5B
Sy4KPgo+ID4gV2hhdCB5b3UgbmVlZCB0byBkbyBpbnN0ZWFkIGlzIHRvIGxvb2sgYXQgdGhlIHJl
dHVybiB2YWx1ZSBmcm9tCj4gPiBwY2lfcmViYXJfZ2V0X3Bvc3NpYmxlX3NpemVzKCkgYW5kIGRl
dGVybWluZSB0aGUgc2l6ZSBjbG9zZWQgdG8gdGhlIGRlc2lyZWQKPiA+IG9uZS4gW+KApl0KPgo+
IFdlbGzigKYgdGhlcmUncyB0aGF0IHJhcGlkIHJlamVjdCBpbW1lZGlhdGVseSBmb2xsb3dpbmc7
IGFuZCB0aGUgb3ZlcnJpZGUgcGF0Y2gKPiBhbHRlcnMgdGhhdCBjb25kaXRpb24uCj4KPiA+IEUu
Zy4gd2hlbiBuZWVkIGEgc2l6ZSBvZiAxMyBpcyBuZWVkZWQgeW91IGZpcnN0IGNoZWNrIGlmIGFu
eSBiaXQgPj0gMTMKPiA+IGFyZSBzZXQuIFlvdSBjYW4gdXNlIHRoZSBmZnMoKSBmb3IgdGhpcy4K
Pgo+IFNv4oCmIGZpbmQgdGhlIGxvd2VzdCBiaXQgc2V0LCBhZnRlciBtYXNraW5nIG91dCBiaXRz
IDAgdG8gKHJiYXJfc2l6ZS0xKSwKPiBhbmQgdHJ5IHRvIHJlLWFsbG9jYXRlIGFjY29yZGluZ2x5
Lgo+Cj4gSSBjb3VsZCBoYXZlIGl0IGNoZWNrIGZvciBsYXJnZXIgc2l6ZXMgaWYgdGhhdCBmYWls
cywgYnV0IEkgZG9uJ3QgdGhpbmsgdGhhdAo+IGl0J3Mgd29ydGggaXQuIElmIHRoZSBCQVIgc2l6
ZSBpcyA+PSAyw5cgdGhlIFZSQU0gc2l6ZSwgaXQncyBhIHdhc3RlIG9mCj4gYWRkcmVzcyBzcGFj
ZTsgYW5kIHRoZSBhZHZlcnRpc2VtZW50IG9mIHN1Y2ggYSBzaXplIGlzIGFyZ3VhYmx5IGEgVkJJ
T1MgYnVnCj4gYW55d2F5Lgo+Cj4gPiBJZiB0aGF0IGlzbid0IHRoZSBjYXNlIHVzZSBmbHMoKSB0
byBnZXQgdGhlIGhpZ2hlc3Qgc2V0IGJpdCA8IDEzLgo+Cj4gVGhhdCBzdWdnZXN0cyB0aGF0IGl0
J2xsIGJlIGVhc2llc3QgdG8gY2xlYXIgZWFjaCBiaXQgYWZ0ZXIgdGhlIGNvcnJlc3BvbmRpbmcK
PiBzaXplIGlzIGNoZWNrZWQsIEkgdGhpbmsuIEFsc28sIHRoaXMgbG9va3MgbGlrZSBpdCdzIGFk
ZGluZyBjb21wbGV4aXR5IHRvCj4gdHJ5IHRvIG1ha2UgcmFyZWx5LWV4ZWN1dGVkIGNvZGUgc2xp
Z2h0bHkgZmFzdGVyIGluIHNvbWUgY2FzZXMgKEkgY2FuJ3Qgc2VlCj4gaXQgaGVscGluZyB3aGVy
ZSBhdmFpbGFibGVfc2l6ZXMgPT0gMHgzRjAwLCBmb3IgZXhhbXBsZSkuCj4KPiBJbmNpZGVudGFs
bHksIGlzIGl0IHdvcnRoIHRyeWluZyB0byByZWR1Y2UgdGhlIEJBUiBzaXplIGF0IGFsbD8gVGhp
bmtpbmcKPiBtYWlubHkgb2YgdHdvIHNpdHVhdGlvbnMg4oCTIGxpbWl0aW5nIHRoZSBtYXhpbXVt
IHNpemUsIGFuZCB0aGUgQklPUyBoYXZpbmcKPiBhbGxvY2F0ZWQgb25lIG11Y2ggdG9vIGxhcmdl
LgoKSW4gdGhlb3J5IHdlIGNvdWxkIG9uIHJlc291cmNlIGNvbnN0cmFpbmVkIHN5c3RlbXMuICBF
LmcuLCBpZiB5b3UgaGF2ZQphIGxvdCBvZiBkZXZpY2VzIGFuZCBhIGxpbWl0ZWQgTU1JTyB3aW5k
b3csIGJ1dCBJIHRoaW5rIG9uIG1vc3QgcmVjZW50CkFNRCBHUFVzLCAyNTZNIGlzIHRoZSBzbWFs
bGVzdCBzaXplIGFuZCB0aGUgZGVmYXVsdC4KCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
