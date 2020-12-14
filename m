Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258DC4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 16:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F692253D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 16:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F692253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED1A6E3EF;
	Mon, 14 Dec 2020 16:05:48 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA0A89A9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/LLfPnwPv+xy5ik0BT7mCiIofpDnoIFTdS6n9UnY6AU=; b=0CGQ4Dmn0xGxY54eB0B1rcdW9R
 qro4LwWQY1Z/xVft78ZFH8K3L3XqBM2iFMFPGI1mLJO8aK1AgqAaIs8SLrbgYZoMT80+zsCYqthVQ
 PmuwGh6t3L4KQg+E+TVLI2VRaq6jAH7f+yS7ZnZgChCow2JYqMdUEjYsS8S2o1YqiUINN+9eEs03h
 jImKRyoACPkdnWhctV9Fvty58VZvyn4mO0sMKKUS3FUkn/Ewym+9aeuSLBicO/+bHqyLO2d+sv3Zy
 /lCSicuU6AYlFGtDyhYuUJc9o/r4p8+bPq3WFDIHBcFcXVkjHoUShYbCzo/mW5jXVN0UV3ipSwBk1
 HXOLNyZA==;
Received: from [2001:8b0:897:1650::2]
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koqLb-00068Y-Ii; Mon, 14 Dec 2020 16:05:15 +0000
Date: Mon, 14 Dec 2020 15:46:58 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: christian.koenig@amd.com
Subject: Re: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
Message-ID: <58E43922F8%devspam@moreofthesa.me.uk>
In-Reply-To: <1d482d3c-ef99-ffdf-84c6-61182fd0f757@gmail.com>
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk> 
 <20201211005506.4554-4-devspam@moreofthesa.me.uk> 
 <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com> 
 <58E2B73AC8%devspam@moreofthesa.me.uk> 
 <1d482d3c-ef99-ffdf-84c6-61182fd0f757@gmail.com>
Mail-Followup-To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Darren Salt <devspam@moreofthesa.me.uk>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Mon, 13163 Dec 1984 15:46:58 +0000
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
bi4uLgoKPiBBbSAxMS4xMi4yMCB1bSAxODozMSBzY2hyaWViIERhcnJlbiBTYWx0Ogo+PCBbU05J
UF0KPj4+IElmIHRoYXQgaXNuJ3QgdGhlIGNhc2UgdXNlIGZscygpIHRvIGdldCB0aGUgaGlnaGVz
dCBzZXQgYml0IDwgMTMuCj4+IFRoYXQgc3VnZ2VzdHMgdGhhdCBpdCdsbCBiZSBlYXNpZXN0IHRv
IGNsZWFyIGVhY2ggYml0IGFmdGVyIHRoZQo+PiBjb3JyZXNwb25kaW5nIHNpemUgaXMgY2hlY2tl
ZCwgSSB0aGluay4KCj4gT2ssIHdlbGwgeW91IGRvbid0IHNlZW0gdG8gdW5kZXJzdGFuZCBteSBj
b25zdHJhaW4gaGVyZTogTmV2ZXIgY2hlY2sgCj4gbW9yZSB0aGFuIG9uZSBzaXplIQoKQ2hlY2tp
bmcgY29udGV4dDogaXQgYXBwZWFyZWQgdG8gYmUgdGhlIGZvcigpIHN0YXRlbWVudCBpdHNlbGYg
cmF0aGVyIHRoYW4KdGhlIHdob2xlIGxvb3AuIEl0IGRpZG4ndCBoZWxwIHRoYXQg4oCcdHJ5IGFu
ZCBlcnJvcuKAnSBsb29rcyBsaWtlIOKAnHRyeSB0byBlcnJvcuKAnQp0byBtZTsgSSBub3cgdGhp
bmsgdGhhdCB5b3UgbWVhbnQg4oCcdHJpYWwgYW5kIGVycm9y4oCdLgoKPiBGaW5kIHRoZSBmaXJz
dCB2YWxpZCBzaXplIHdoaWNoIGlzIGdvb2QgZm9yIHlvdSBhbmQgdGhlbiB0cnkgdG8gcmVzaXpl
IAo+IHRvIHRoYXQgb25lLCBpZiB0aGlzIGRvZXNuJ3Qgd29yayBhYm9ydC4KClNvLCBiYXNpY2Fs
bHksIHN0b3AgZXZlbiB3aGVuIHRoZSBuZXh0IHNpemUgZG93biB3b3VsZCBiZSBmaW5lLCBlLmcu
IDE2R0Ig4oaSCjhHQi4gSnVzdCBhcyB3ZWxsIHRoYXQgc2l6ZSBsaW1pdGluZyBpcyBkb25lIGlu
IGEgbGF0ZXIgcGF0Y2gsIHRob3VnaCBJCndvbmRlciB3aGV0aGVyIHRoYXQgc2hvdWxkIGFsbG93
IHBlci1HUFUgY29uZmlndXJhdGlvbiAobm90IHNvbWV0aGluZyBmb3IKdGhpcyBwYXRjaCBzZXJp
ZXMsIHRob3VnaCkuCgo+PiBBbHNvLCB0aGlzIGxvb2tzIGxpa2UgaXQncyBhZGRpbmcgY29tcGxl
eGl0eSB0byB0cnkgdG8gbWFrZQo+PiByYXJlbHktZXhlY3V0ZWQgY29kZSBzbGlnaHRseSBmYXN0
ZXIgaW4gc29tZSBjYXNlcyAoSSBjYW4ndCBzZWUgaXQKPj4gaGVscGluZyB3aGVyZSBhdmFpbGFi
bGVfc2l6ZXMgPT0gMHgzRjAwLCBmb3IgZXhhbXBsZSkuCgo+IFRoZSBpbnRlbnRpb24gaGVyZSBp
cyBub3QgdG8gbWFrZSB0aGUgY29kZSBmYXN0ZXIsIGJ1dCB0byBwcmV2ZW50IGlzc3VlcyBvbgo+
IHN5c3RlbSB3aGVyZSB3ZSBwcm9iZSBtdWx0aXBsZSBHUFVzIGF0IG9uY2UuCgpQcmVzdW1hYmx5
IHNpbXVsdGFuZW91cyBwcm9iZXMgYW5kIHJhbmRvbSBvcmRlcmluZ+KApgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
