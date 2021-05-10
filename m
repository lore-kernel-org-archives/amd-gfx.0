Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A824BC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4910A61494
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4910A61494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4256E924;
	Mon, 10 May 2021 21:52:04 +0000 (UTC)
X-Greylist: delayed 1330 seconds by postgrey-1.36 at gabe;
 Mon, 10 May 2021 21:50:30 UTC
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com
 [192.185.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92126E926
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 21:50:30 +0000 (UTC)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id 9B267400CA1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 16:28:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id gDRllGejk8ElSgDRlloQLX; Mon, 10 May 2021 16:28:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KgfgvAJslFXT/V//YjtBHOgr5mG9TcHB2XOA5MwkyEc=; b=jBEbMKAMemcnb4u3CBVuzDGDg/
 9TAQOBwBZc8a0bYT0mZXv0Az0trVtcXMbJaj5NTPgpRHn6s8y6j9uwqjqS9TO2hXOeHcP6Y0zMlct
 z9W1UgaHqhQSY7T8JBksNrS9m5YBhU4iOQS+pLgMqGY0Qgm+IUudasrrN/xO1kvLqNi0Ycg4g2706
 dA9uU9e9MrQr8v0rFuJjnU9fULOrz1TNk3rGPp6zZrd2J5Bj08W8MDxSWiTwC9QXFnZM2fu/GSFkw
 EehqKoYJrDqeSoZ/os8loLvV5zVg8oT0KrbTAIYcP7tF3lqOfk1Rb0OFLoj8R/w5YMlENzZ0NyLsY
 1A/4VDyA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:42170
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <gustavo@embeddedor.com>)
 id 1lgDRg-00137t-Uf; Mon, 10 May 2021 16:28:08 -0500
Subject: Re: [PATCH] drm/radeon/ni_dpm: Fix booting bug
To: Alex Deucher <alexdeucher@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20210509224926.GA31035@embeddedor>
 <CADnq5_OWk+rXK5xrwu0YOMVC45WyQgFQBTUNkcF8oO3ucp+=XQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba5f2a73-58e8-6b3e-4048-bb19f238be51@embeddedor.com>
Date: Mon, 10 May 2021 16:28:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_OWk+rXK5xrwu0YOMVC45WyQgFQBTUNkcF8oO3ucp+=XQ@mail.gmail.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lgDRg-00137t-Uf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8])
 [187.162.31.110]:42170
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Mon, 10 May 2021 21:52:04 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 linux-hardening@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwKCk9uIDUvMTAvMjEgMTY6MTcsIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBTdW4s
IE1heSA5LCAyMDIxIGF0IDY6NDggUE0gR3VzdGF2byBBLiBSLiBTaWx2YQo+IDxndXN0YXZvYXJz
QGtlcm5lbC5vcmc+IHdyb3RlOgpbLi5dCgo+Pgo+PiBCdWc6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2RyaS1kZXZlbC8zZWVkYmU3OC0xZmJkLTQ3NjMtYTdmMy1hYzU2NjVlNzZhNGFAeGVub3Nv
ZnQuZGUvCj4+IEZpeGVzOiA0MzRmYjFlNzQ0NGEgKCJkcm0vcmFkZW9uL25pc2xhbmRzX3NtYy5o
OiBSZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5IHdpdGggZmxleGlibGUtYXJyYXkgbWVtYmVyIGlu
IHN0cnVjdCBOSVNMQU5EU19TTUNfU1dTVEFURSIpCj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnCj4+IFJlcG9ydGVkLWJ5OiBDaHJpc3RpYW4gWmlnb3R6a3kgPGNoemlnb3R6a3lAeGVub3Nv
ZnQuZGU+Cj4+IFRlc3RlZC1ieTogQ2hyaXN0aWFuIFppZ290emt5IDxjaHppZ290emt5QHhlbm9z
b2Z0LmRlPgo+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2ZWwvOWJiNWZj
YmQtZGFmNS0xNjY5LWIzZTctYjg2MjRiM2MzNmY5QHhlbm9zb2Z0LmRlLwo+PiBTaWduZWQtb2Zm
LWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+Cj4gCj4gVGhp
cyBzZWVtcyBsaWtlIGEgbG90IG9mIGNodXJuIGp1c3QgdG8gdXNlIGZsZXhpYmxlIGFycmF5cy4g
IFRoYXQKPiBzYWlkLCBpZiBzdGF0aWMgY2hlY2tlcnMgYXJlIGdvaW5nIHRvIGtlZXAgY29tcGxh
aW5pbmcgYWJvdXQgc2luZ2xlCj4gZWxlbWVudCBhcnJheXMsIEkgZG9uJ3QgbWluZCBhcHBseWlu
ZyB0aGVzZSBwYXRjaGVzIHNpbmNlIHRoaXMgY29kZSBpcwo+IG5vdCBsaWtlbHkgdG8gY2hhbmdl
LiAgQXBwbGllZC4gIFRoYW5rcy4KClRoaXMgaXMgbm90IG9ubHkgYWJvdXQgdGhlIG9uZS1lbGVt
ZW50IGFycmF5cy4gVGhlc2UgZml4ZXMgKHRvZ2V0aGVyIHdpdGggY29tbWl0cwo0MzRmYjFlNzQ0
NGEgYW5kIDk2ZTI3ZThkOTE5ZSkgYWxsb3cgdXMgdG8gZml4IG1vcmUgdGhhbiBhIGRvemVuIG9m
IHRoZXNlIG91dC1vZi1ib3VuZHMKd2FybmluZ3M6Cgpkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25p
X2RwbS5jOjI1MjE6MjA6IHdhcm5pbmc6IGFycmF5IHN1YnNjcmlwdCAxIGlzIGFib3ZlIGFycmF5
IGJvdW5kcyBvZiDigJhOSVNMQU5EU19TTUNfSFdfUEVSRk9STUFOQ0VfTEVWRUxbMV3igJkge2Fr
YSDigJhzdHJ1Y3QKTklTTEFORFNfU01DX0hXX1BFUkZPUk1BTkNFX0xFVkVMWzFd4oCZfSBbLVdh
cnJheS1ib3VuZHNdCiAyNTIxIHwgICBzbWNfc3RhdGUtPmxldmVsc1tpXS5kcG0yLk1heFBTID0K
ICAgICAgfCAgIH5+fn5+fn5+fn5+fn5+fn5+Xn5+Cgp3aGljaCBzaG91bGQgYmUgZml4ZWQgaW4g
b3JkZXIgdG8gZ2xvYmFsbHkgZW5hYmxlIC1XYXJyYXktYm91bmRzLiA6KQoKVGhhbmtzIQotLQpH
dXN0YXZvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
