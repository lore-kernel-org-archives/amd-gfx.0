Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A5C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 19:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE8023ED2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 19:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE8023ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E346E203;
	Fri, 11 Dec 2020 19:49:10 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 597CC6E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5YQtjIk0++T0oNuCRwJjsrWGECHhF6X5qwrdcidXR7A=; b=bnwFfB2+eKiCm87lxA+lr+BRe2
 IL506lpwh8Jt3yGIdNvgCjRi/E6Q5hqX952Rtsj9i027zrAyhPK9zeuSIY0OV3nhxovme7Aq9HPaj
 w7oFcOau34h7NW6B0GRXuSGgNxJf17ntC6bHfSi1LBbGkugErHxCtifxAylKfJ9ry5pZlQN69Z82I
 mLKgCYAN7e/rJ+mSSjQfxJVzRm1VwabdZmy6k6lqeULXzxmlSLTgCkpPmBFgkrLrqk1aKQGYTKOS1
 vktkjGPSK+mb73cmu+CIQ/hHHaSK15e0xg63/KZbOQhXWzAZ/DjBxcLu/gg1Qh4DHWH42BoWPpAlq
 NlQ0v/Qg==;
Received: from [2001:8b0:897:1650::2]
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knoPa-0005qK-Kd; Fri, 11 Dec 2020 19:49:06 +0000
Date: Fri, 11 Dec 2020 19:48:08 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: christian.koenig@amd.com
Subject: Re: [PATCH] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM
Message-ID: <58E2C3B550%devspam@moreofthesa.me.uk>
In-Reply-To: <77805324-8fdc-8d72-f033-7d75ae04947e@gmail.com>
References: <20201210005744.5877-1-devspam@moreofthesa.me.uk> 
 <621ae252-ab39-383e-61a9-746fb47c6e01@gmail.com> 
 <58E21FF244%devspam@moreofthesa.me.uk> 
 <9d3cee7f-366e-4e7e-9f63-b0a51af7436c@gmail.com> 
 <58E26045D8%devspam@moreofthesa.me.uk> 
 <77805324-8fdc-8d72-f033-7d75ae04947e@gmail.com>
Mail-Followup-To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Darren Salt <devspam@moreofthesa.me.uk>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Fri, 13160 Dec 1984 19:48:08 +0000
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
bi4uLgoKPiBBbSAxMS4xMi4yMCB1bSAwMjo0MiBzY2hyaWViIERhcnJlbiBTYWx0Ogo+PiBJIGRl
bWFuZCB0aGF0IENocmlzdGlhbiBLw7ZuaWcgbWF5IG9yIG1heSBub3QgaGF2ZSB3cml0dGVuLi4u
Cj4gW1NOSVBdCgo+IFdlbGwgSSBkaWQgd3JvdGUgdGhhdCA6KQoK4oCcZGlkIHdyaXRl4oCdLCBz
dXJlbHnigKYKCj4+IEkgdXNlZCBkZDoKPj4gIyBkZCBpZj0vc3lzL2tlcm5lbC9kZWJ1Zy9kcmkv
MC9hbWRncHVfdnJhbSBicz0xMDQ4NTc2IGNvdW50PTEgc2tpcD02MTI3IHwgaGV4ZHVtcCAtQyB8
dGFpbAoKPiBUaGF0IHdvbid0IHdvcmsuIGFtZGdwdV92cmFtIHVzZXMgYSBNTUlPIHJlZ2lzdGVy
IHBhaXIgdG8gYWNjZXNzIFZSQU0gd2hpY2gKPiB3b3JrcyBldmVuIHdoZW4gaXQgaXNuJ3QgQ1BV
IHZpc2libGUuCgo+IFRoaW5raW5nIG1vcmUgYWJvdXQgaXQgdW1yIHdvdWxkIHByb2JhYmx5IHVz
ZSB0aGlzIGFzIHdlbGwsIHNvIHRoYXQgd29uJ3QKPiB3b3JrIGVpdGhlci4KCj4gWW91IGNvdWxk
IHRyeSB0byB1c2UgZGQgb24gL2Rldi9tZW0gd2l0aCB0aGUgb2Zmc2V0IG9mIHRoZSBCQVIuCgpM
b29rcyBsaWtlIHRoYXQncyBSQU0gYWNjZXNzZWQgYnkgcGh5c2ljYWwgYWRkcmVzcywgc28gdGhh
dCB3b24ndCB3b3JrCmVpdGhlci4gQW5kIEkgZG8gc2VlIGRkIHJlcG9ydGluZyDigJhiYWQgYWRk
cmVzc+KAmS4KCj4+IEFueXdheSBJIGFncmVlIHRoYXQgYSBQQ0kgc3Vic3lzdGVtIHF1aXJrIG1p
Z2h0IGJlIGFwcHJvcHJpYXRlZC4KCj4gSSdtIGdvaW5nIHRvIGRpc2N1c3MgQU1EIGludGVybmFs
bHkgd2h5IHlvdSBoYXZlIHN1Y2ggc3RyYW5nZSB2YWx1ZXMgaW4gCj4gdGhlIFJCQVIgcmVnaXN0
ZXJzLgoKSSdtIHRoaW5raW5nIHByb2JhYmx5IGFuIGVycm9yIGJ5IHNvbWVib2R5IGF0IFNhcHBo
aXJlLCBidXQgd2UnbGwgc2Vl4oCmCgpIb3BlZnVsbHksIHRoYXQnbGwgc29ydCBpdCBvdXQsIGF0
IGxlYXN0IGZvciBuZXcgY2FyZHMuIEkgZG91YnQgdGhhdCBtaW5lJ3MKdGhlIG9ubHkgb25lIGxp
a2UgdGhpcywgYW5kIGl0IHNlZW1zIGxpa2VseSB0aGF0IG1vc3QgYWxyZWFkeSBvdXQgdGhlcmUg
d29uJ3QKYmUgdXBkYXRlZCAoc2hvdWRsIHRoZXJlIGJlIG5ldyBWQklPUyByZWxlYXNlcyBhcyBh
IHJlYXVsdCkuCgpBbnl3YXksIEkgaGF2ZSBhIHF1aXJrIHBhdGNoIHdyaXR0ZW4gbm93IOKAkyB1
bnRlc3RlZCBhcyB5ZXQsIGFuZCBwcm9iYWJseQpnb2luZyB0byBiZSBjaGFuZ2VkIGR1ZSB0byBv
dGhlciBjaGFuZ2VzIGJlZm9yZSBJIGRvIHRlc3QgaXQuCgpbc25pcF0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
