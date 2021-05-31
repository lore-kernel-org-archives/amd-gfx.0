Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7105BC47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 12:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE8661263
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 12:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE8661263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC096E8EF;
	Mon, 31 May 2021 12:18:05 +0000 (UTC)
X-Greylist: delayed 481 seconds by postgrey-1.36 at gabe;
 Mon, 31 May 2021 12:18:04 UTC
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se
 [213.80.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3106E8EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 12:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7A7103F71A;
 Mon, 31 May 2021 14:10:01 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="M0KF649V";
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9wo6bk9VmlS; Mon, 31 May 2021 14:10:00 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 316A93F6BE;
 Mon, 31 May 2021 14:09:59 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id BC3F83600E5;
 Mon, 31 May 2021 14:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1622462999; bh=Y5BqkkCrLzjckxB/iPLYEH1anqsml90Pb+tjhUY5K18=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=M0KF649VDfgiPSQrTvWZdZLONzcU4S3xZgdhMmrUejzlxL6ST1bYgdLp+Mn3d9k6/
 1HoBSO2YANuz5R1ra6Igsk6i//TurmwBBg/QQ9NrEPhbbLrJNLYUtRKZva/0H6+qZz
 BYonG82VhE+cXtE30RgGV5QZAs6RPAQ49Td1uprg=
Subject: Re: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
 <883bd629-e3ad-07a2-8952-994f42cb02be@gmail.com>
 <86054733-9b7d-de96-4ab2-21dca85f1e6e@shipmail.org>
 <888c52a5-ec10-0dee-c462-93cef8510e9f@amd.com>
 <6c4c8c57-7cc7-7e24-1d19-b91a312d44a0@shipmail.org>
 <cd081dda-7430-d891-6b02-8aedda7b67be@amd.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <7d545d70-8212-3fbe-e803-5198af69f5c2@shipmail.org>
Date: Mon, 31 May 2021 14:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cd081dda-7430-d891-6b02-8aedda7b67be@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDUvMzEvMjEgMjowMiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAzMS4wNS4y
MSB1bSAxMzoxOSBzY2hyaWViIFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCk6Cj4+Cj4+IE9uIDUv
MzEvMjEgMTI6NTYgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAzMS4wNS4yMSB1
bSAxMjo0NiBzY2hyaWViIFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCk6Cj4+Pj4KPj4+PiBPbiA1
LzMxLzIxIDEyOjMyIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAzMS4wNS4y
MSB1bSAxMTo1MiBzY2hyaWViIFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCk6Cj4+Pj4+PiBIaSwg
TGFuZywKPj4+Pj4+Cj4+Pj4+PiBPbiA1LzMxLzIxIDEwOjE5IEFNLCBZdSwgTGFuZyB3cm90ZToK
Pj4+Pj4+PiBbUHVibGljXQo+Pj4+Pj4+Cj4+Pj4+Pj4+IEhpLAo+Pj4+Pj4+PiBPbiA1LzI3LzIx
IDM6MzAgQU0sIExhbmcgWXUgd3JvdGU6Cj4+Pj4+Pj4+PiBNYWtlIFRUTV9QTF9GTEFHXyogc3Rh
cnQgZnJvbSB6ZXJvIGFuZCBhZGQKPj4+Pj4+Pj4+IFRUTV9QTF9GTEFHX1RFTVBPUkFSWSBmbGFn
IGZvciB0ZW1wb3JhcnkKPj4+Pj4+Pj4+IEdUVCBhbGxvY2F0aW9uIHVzZS4KPj4+Pj4+Pj4gR1RU
IGlzIGEgZHJpdmVyIHByaXZhdGUgYWNyb255bSwgcmlnaHQ/IEFuZCBpdCBkb2Vzbid0IGxvb2sg
bGlrZQo+Pj4+Pj4+PiBUVE1fUExfRkxBR19URU1QT1JBUlkgd2lsbCBiZSB1c2VkIGluIGNvcmUg
VFRNLCBzbyBzaG91bGQgd2UgCj4+Pj4+Pj4+IGluc3RlYWQgc2V0Cj4+Pj4+Pj4+IGFzaWRlIGEg
bWFzayBpbiB0aGUgUEwgZmxhZyBmb3IgZHJpdmVyLXByaXZhdGUgdXNlPwo+Pj4+Pj4+IEhpIFRo
b21hcywKPj4+Pj4+Pgo+Pj4+Pj4+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cyBhbmQgYWR2aWNl
LCBHVFQgbWVhbnMgR3JhcGhpY3MgCj4+Pj4+Pj4gVHJhbnNsYXRpb24gVGFibGUgaGVyZSwgc2Vl
bXMKPj4+Pj4+PiBhIGdlbmVyYWwgYWNyb255bS4gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIG1heSBh
bHNvIGJlIHVzZWQgYnkgCj4+Pj4+Pj4gb3RoZXIgZHJpdmVzLgo+Pj4+Pj4+IEkgaGF2ZSBtYWRl
IG90aGVyIHBhdGNoZXMgZm9yIHRoaXMuIFBsZWFzZSBoZWxwIHJldmlldy4KPj4+Pj4+Pgo+Pj4+
Pj4+IFJlZ2FyZHMsCj4+Pj4+Pj4gTGFuZwo+Pj4+Pj4+Cj4+Pj4+PiBNeSBwb2ludCB3YXMgcmVh
bGx5IHRoYXQgdGhlIGZsYWcgbmFtaW5nIGFuZCBkb2N1bWVudGF0aW9uIHNob3VsZCAKPj4+Pj4+
IHJlZmxlY3Qgd2hhdCBjb3JlIHR0bSBpcyBkb2luZyB3aXRoIHRoYXQgZmxhZy4gSWYgdGhlcmUg
aXMgbm8gCj4+Pj4+PiBzcGVjaWZpYyBjb3JlIFRUTSB1c2FnZSwgSU1PIHdlIHNob3VsZCBtb3Zl
IGl0IHRvIGEgZHJpdmVyIAo+Pj4+Pj4gc3BlY2lmaWMgZmxhZyB0byBhdm9pZCBmdXR1cmUgY29u
ZnVzaW9uLiBJbiBwYXJ0aWN1bGFyIGEgd3JpdGVyIAo+Pj4+Pj4gb2YgYSBnZW5lcmljIFRUTSBy
ZXNvdXJjZSBtYW5hZ2VyIHNob3VsZCBiZSBhYmxlIHRvIGtub3cgd2l0aG91dCAKPj4+Pj4+IGxv
b2tpbmcgYXQgYW4gb2xkIGNvbW1pdCBtZXNzYWdlIHdoYXQgdGhlIHBsYWNlbWVudCBmbGFnIGlz
IAo+Pj4+Pj4gaW50ZW5kZWQgZm9yLgo+Pj4+Pj4KPj4+Pj4+IFNvIGhlcmUgd2UgYWRkIGEgZmxh
ZyB3aGVyZSBjb3JlIFRUTSBmb3JjZXMgYSBibyBtb3ZlIG9uIHZhbGlkYXRlIAo+Pj4+Pj4gYW5k
IHRoYXQncyBpdC4gQW5kIHRoYXQgYXBwZWFycyB0byBiZSBob3cgaXQncyB1c2VkIHdoZW4gYW4g
Cj4+Pj4+PiBhbWRncHUgYm8gaXMgZXZpY3RlZCB0byBHVFQsIChidHcgc2hvdWxkIGl0IGJlIGFj
Y291bnRlZCBpbiB0aGlzIAo+Pj4+Pj4gc2l0dWF0aW9uPykKPj4+Pj4+Cj4+Pj4+PiBUaGUgb3Ro
ZXIgdXNlIGlzIHRvIGZvcmNlIHRoZSBhbWRncHUgZHJpdmVyIHRvIHRlbXBvcmFyaWx5IGFjY2Vw
dCAKPj4+Pj4+IGl0IGludG8gR1RUIHdoZW4gdGhlcmUgaXMgYSBsYWNrIG9mIHNwYWNlLCBhbmQg
SU1ITyB0aGF0J3MgYSAKPj4+Pj4+IGRyaXZlciBzcGVjaWZpYyB1c2UgYW5kIHdlIHNob3VsZCBh
bGxvY2F0ZSBhIG1hc2sgZm9yIGRyaXZlciAKPj4+Pj4+IHNwZWNpZmljIGZsYWdzIGZvciB0aGF0
Lgo+Pj4+Pj4KPj4+Pj4+IFNvIHNob3VsZG4ndCB0aGlzIGJlIHR3byBmbGFncywgcmVhbGx5Pwo+
Pj4+Pgo+Pj4+PiBXZWxsIG9uZSBmbGFnIG1ha2VzIHNlbnNlIGZvciB0aGUgdXNlIGNhc2UgYXQg
aGFuZCB0aGF0IGRyaXZlcnMgCj4+Pj4+IHdhbnQgdG8gc2lnbmFsIHRvIFRUTSB0aGF0IGFuIGFs
bG9jYXRpb24gaXMgb25seSB0ZW1wb3JhcnkgYW5kIG5vdCAKPj4+Pj4gY29uc2lkZXJlZCB2YWxp
ZC4KPj4+Pj4KPj4+Pj4gVGhhdCB3ZSB0aGVuIHVzZSB0aGlzIGZsYWcgdG8gaW1wbGVtZW50IHRl
bXBvcmFyeSBHVFQgYWxsb2NhdGlvbnMgCj4+Pj4+IHRvIGF2b2lkIHByb2JsZW1zIGR1cmluZyBl
dmljdGlvbiBpcyBqdXN0IGV4dGVuZGluZyB0aGF0IHVzZSBjYXNlLgo+Pj4+Pgo+Pj4+IE9LLCBi
dXQgaXQgbG9va2VkIGxpa2UgdGhlcmUgd2VyZSBhY3R1YWxseSB0d28gdXNlLWNhc2VzLiBPbmUg
Zm9yIAo+Pj4+IHBvc3NpYmx5IGxvbmctdGVybSBWUkFNIGV2aWN0aW9ucyB0byBHVFQsIHRoZSBv
dGhlciBmb3IgdGhlIAo+Pj4+IHRlbXBvcmFyeSB1c2UtY2FzZSB3aGVyZSB0aGUgaG9wIHJlc291
cmNlIGFsbG9jYXRpb25zIHNvbWV0aW1lcyAKPj4+PiBmYWlsZWQuIE9yIGRpZCBJIG1pc3VuZGVy
c3RhbmQgdGhlIGNvZGU/Cj4+Pgo+Pj4gT2sgc291bmRzIGxpa2Ugd2UgbmVlZCBtb3JlIGRvY3Vt
ZW50YXRpb24gaGVyZS4gVGhhdCdzIHJlYWxseSBvbmUgCj4+PiB1c2UgY2FzZS4KPj4+Cj4+PiBL
ZXkgcG9pbnQgaXMgd2UgbmVlZCB0ZW1wb3JhcnkgYWxsb2NhdGlvbiBkdXJpbmcgbXVsdGlob3Ag
d2hpY2ggCj4+PiBzaG91bGQgYmUgaGFuZGxlZCBkaWZmZXJlbnRseSB0byBub3JtYWwgYWxsb2Nh
dGlvbnMuCj4+Cj4+IFllcywgdGhhdCBwYXJ0IGlzIGNsZWFyIGZyb20gdGhlIHBhdGNoZXMuIFRo
ZSBwYXJ0IHRoYXQgSSBjYW4ndCBmaXQgCj4+IGludG8gdGhhdCBwYXR0ZXJuIGlzIHdoeSB0aGUg
ZXZpY3QgZmxhZ3Mgd2hlbiBldmljdGluZyBmcm9tIHZpc2libGUgCj4+IFZSQU0gdG8gR1RUIG9y
IG9yZGluYXJ5IFZSQU0gaXMgbWFya2VkIHdpdGggVFRNX1BMX0ZMQUdfVEVNUE9SQVJZLiAKPj4g
V291bGRuJ3QgdGhvc2UgcmVtYWluIGV2aWN0ZWQgaW4gdGhhdCBwbGFjZW1lbnQgdW50aWwgcmUt
dmFsaWRhdGVkIHRvIAo+PiB2aXNpYmxlIFZSQU0gYXQgYW4gdW5rbm93biBmdXR1cmUgdGltZT8K
Pgo+IE5vdCBuZWNlc3NhcmlseS4KPgo+IFRoZSBzaXR1YXRpb24gd2UgcmFuIGludG8gd2FzIHRo
ZSBmb2xsb3dpbmc6Cj4gMS4gT09NIG9uIFZSQU0sIHdlIHRyeSB0byBldmljdC4KPgo+IDIuIEdU
VCBzcGFjZSBpcyB1c2VkIHVwIGFzIHdlbGwsIG9rIGV2aWN0IGRpcmVjdGx5IHRvIFNZU1RFTS4K
Pgo+IDMuIEZvciBWUkFNLT5TWVNURU0gZXZpY3Rpb24gd2UgdXNlIGEgdGVtcG9yYXJ5IGJvdW5j
ZSBidWZmZXIuCj4KPiA0LiBXYWl0aW5nIGZvciB0aGUgYm91bmNlIGJ1ZmZlciB0byBiZWNvbWUg
aWRsZSBpcyBpbnRlcnJ1cHRlZCBieSBhIAo+IHNpZ25hbCBzbyBCTyBpcyBzdGlsbCBiYWNrZWQg
YnkgYm91bmNlIGJ1ZmZlci4KPgo+IDUuIE5leHQgQ1MsIEJPIGlzIHZhbGlkYXRlZCB3aXRoIFZS
QU18R1RULiBUVE0gc2VlcyB0aGF0IGl0IGlzIGluIEdUVCAKPiBhbmQgZG9lc24ndCBtb3ZlIHRo
ZSBidWZmZXIuCj4KPiA2LiBDUyBnb2VzIGludG8gbmlydmFuYSBiZWNhdXNlIGJvdW5jZSBidWZm
ZXJzIGFyZSBub3QgbWVhbnQgdG8gYmUgCj4gdXNlZCBmb3IgQ1MgKHdlIGNhbiBpZ25vcmUgYWxp
Z25tZW50IGFuZCBhY2NvdW50aW5nIGZvciB0aGVtKS4KPgpZZXMsIG1ha2VzIHNlbnNlIHRvIG1l
LgoKL1Rob21hcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
