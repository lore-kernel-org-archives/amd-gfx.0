Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1AC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 02:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3260E23DE8
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 02:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3260E23DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4FB6E7E5;
	Fri, 11 Dec 2020 02:03:34 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6ED6E7E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NtkXN1Pgk+cPekklFFUHblZpoRAvy46jbEWZIVUHrAA=; b=Yb+eVABcvjTY8eXTmyuDi2S7mI
 8DIWOT9NvLsb3wABU91I4aWYecErPvjKxlXEs34ddzcHupcficxonubU8iTk63MItAkM5EAt3DHe2
 JxtXMZo9V1nEohkPlnQRCxSrC0NDMUkTxuR+cZt1uImjHrzm3/zyJ/iJJvyKUP/ENHOz5QNKM6R39
 t2zp8jI2WrqqxxKFkB5irKkocJsG2SnlNi8tv+wlTjrBFK0EouSV8+s9CMHbkXsgTGk2uYaOcv18H
 B3hgbdGl1UsZKMpbXv+3ZU9SlDsnCAVL4gfTGFCc6eWrP80S6Dyz/8KKWra5qp35SNBJHZJQUY3Bz
 eSrW5Hmw==;
Received: from [2001:8b0:897:1650::2]
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knXmO-0003So-NH; Fri, 11 Dec 2020 02:03:32 +0000
Date: Fri, 11 Dec 2020 01:42:02 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: christian.koenig@amd.com
Subject: Re: [PATCH] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM
Message-ID: <58E26045D8%devspam@moreofthesa.me.uk>
In-Reply-To: <9d3cee7f-366e-4e7e-9f63-b0a51af7436c@gmail.com>
References: <20201210005744.5877-1-devspam@moreofthesa.me.uk> 
 <621ae252-ab39-383e-61a9-746fb47c6e01@gmail.com> 
 <58E21FF244%devspam@moreofthesa.me.uk> 
 <9d3cee7f-366e-4e7e-9f63-b0a51af7436c@gmail.com>
Mail-Followup-To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Darren Salt <devspam@moreofthesa.me.uk>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Fri, 13160 Dec 1984 01:42:02 +0000
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBkZW1hbmQgdGhhdCBDaHJpc3RpYW4gS8O2bmlnIG1heSBvciBtYXkgbm90IGhhdmUgd3JpdHRl
bi4uLgoKPiBBbSAxMC4xMi4yMCB1bSAxNDo1OSBzY2hyaWViIERhcnJlbiBTYWx0Ogo+ID4gSSBk
ZW1hbmQgdGhhdCBDaHJpc3RpYW4gS8O2bmlnIG1heSBvciBtYXkgbm90IGhhdmUgd3JpdHRlbi4u
Lgo+ID4KW3NuaXBdCj4+IE15IGN1cnJlbnQga2VybmVsIGhhcyBhbm90aGVyIHBhdGNoLCBhcHBs
aWVkIG9uIHRvcCBvZiB0aGlzIHBhdGNoLCB3aGljaAo+PiBhbGxvd3MgaWdub3JpbmcgdGhlIHNp
emUgbGlzdC4gQXMgc3VjaCwgdGhhdCBCQVIgaXMgY3VycmVudGx5IDhHQiBpbnN0ZWFkCj4+IG9m
IHRoZSAxR0Igd2hpY2ggaXQgc2hvdWxkIGJlLiBJJ3ZlIG5vdCBub3RpY2VkIGFueSBzaWduaWZp
Y2FudCBwcm9ibGVtcwo+PiBhcyB5ZXQuCgo+IFBsZWFzZSBncmFiIHVtciwgdGFrZSBhIGxvb2sg
YXQgdGhlIGFtZGdwdV92cmFtX21tIGRlYnVnZnMgZmlsZSBhbmQgc2VlIGlmCj4geW91IGNhbiBn
ZXQgc29tZSBieXRlcyBmcm9tIGEgYnVmZmVyIGF0IHRoZSBlbmQgb2YgVlJBTS4KCj4gSWYgdGhh
dCBkb2Vzbid0IHJldHVybiAweDAgb3IgMHhmZmZmZmZmZiB0aGVuIGl0IGlzIHByb2JhYmx5IHdv
cmtpbmcgCj4gcXVpdGUgZmluZS4KCkkgdXNlZCBkZDoKCiAgIyBkZCBpZj0vc3lzL2tlcm5lbC9k
ZWJ1Zy9kcmkvMC9hbWRncHVfdnJhbSBicz0xMDQ4NTc2IGNvdW50PTEgc2tpcD02MTI3IHwgaGV4
ZHVtcCAtQyB8dGFpbAogIDErMCByZWNvcmRzIGluCiAgMSswIHJlY29yZHMgb3V0CiAgMTA0ODU3
NiBieXRlcyAoMS4wIE1CLCAxLjAgTWlCKSBjb3BpZWQsIDAuMDY5NjAzNyBzLCAxNS4xIE1CL3MK
ICAqCiAgMDAwZmY4MDAgIGNhIDUzIGNhIDUzIGNhIDUzIGNhIDUzICBjYSA1MyBjYSA1MyBjYSA1
MyBjYSA1MyAgfC5TLlMuUy5TLlMuUy5TLlN8CiAgKgogIDAwMGZmYTAwICBjNiA2MyBjNiA2MyBj
NiA2MyBjNiA2MyAgYzYgNjMgYzYgNjMgYzYgNjMgYzYgNjMgIHwuYy5jLmMuYy5jLmMuYy5jfAog
ICoKICAwMDBmZmUwMCAgY2EgNTkgY2EgNTkgY2EgNTkgY2EgNTkgIGNhIDU5IGNhIDU5IGNhIDU5
IGNhIDU5ICB8LlkuWS5ZLlkuWS5ZLlkuWXwKICAqCiAgMDAwZmZmMDAgIDlhIDUzIDlhIDUzIDlh
IDUzIDlhIDUzICA5YSA1MyA5YSA1MyA5YSA1MyA5YSA1MyAgfC5TLlMuUy5TLlMuUy5TLlN8CiAg
KgogIDAwMTAwMDAwCgpbc25pcDsgVkJJT1MgQkFSIHNpemUgbGltaXQgb2YgMUdCXQo+IEFueXdh
eSBJIGFncmVlIHRoYXQgYSBQQ0kgc3Vic3lzdGVtIHF1aXJrIG1pZ2h0IGJlIGFwcHJvcHJpYXRl
ZC4KCk15IGN1cnJlbnQgcGF0Y2ggc2V0IGltcGxlbWVudHMgYW4gb3ZlcnJpZGUsIHdoaWNoIGlz
IGRlZmluaXRlbHkgdXNlZnVsIGZvcgp0ZXN0aW5nLiBBcyBmb3IgYWRkaW5nIGEgcXVpcmsg4oCT
IEkndmUgbm90IGxvb2tlZCBpbnRvIGhvdyBiZXN0IHRvIGRvIHRoaXMgeWV0LgoKW3NuaXBdCj4+
IEl0J2xsIGFsc28gcmVxdWlyZSBzb21lIHBhdGNoaW5nIGluIHRoZSBQQ0kgc3Vic3lzdGVtIHRv
IGV4cG9zZSByZWxldmFudAo+PiBmdW5jdGlvbnMuCgo+IEp1c3Qgc2VuZCB0aGF0IHRvIG1lIGFz
IGEgY29tcGxldGUgYW5kIGNsZWFuIHBhdGNoc2V0LgoKRG9uZSwgdGhvdWdoIG9ubHkgdG8gdGhl
IGxpc3QuCgo+IEknbSB0aGUgb25lIHdobyBhZGRlZCB0aGUgY29kZSBpbiB0aGUgZmlyc3QgcGxh
Y2UgYW5kIEkgaGF2ZSBubyBwcm9ibGVtIAo+IGFyZ3Vpbmcgd2l0aCBCam9ybiB3aHkgd2UgbmVl
ZCB0aGF0IGluIGEgZHJpdmVyIG5vdy4KClRoYXQncyBkZWZpbml0ZWx5IGhlbHBmdWwhIOKYugpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
