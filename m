Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3267C47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 11:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DA36135A
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 11:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DA36135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C620B6E8E3;
	Mon, 31 May 2021 11:19:57 +0000 (UTC)
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839996E8E3;
 Mon, 31 May 2021 11:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 108073F68D;
 Mon, 31 May 2021 13:19:55 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="E0Qtd880";
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdTArg-DHVBK; Mon, 31 May 2021 13:19:53 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 167CE3F29C;
 Mon, 31 May 2021 13:19:52 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 83B313600E5;
 Mon, 31 May 2021 13:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1622459992; bh=QYIMOTjKRSGFpFks5MLAgWIY0L5P+8zUaL2rYrtpIIs=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=E0Qtd880px3OjbbSCgzhoi1ZENt1aRSJXH6npvz/dfAVWh/A4wT4ll6BlXTJcX5Pk
 ZgmDMb4poGlVRMn6OmSznShnpcWTQDNsoN5UijRjS3IazPYu0DxM1ZuWq5AO9Vx+7g
 h06L5nFUHqOyLCr5vC3SNi9lVGnM86v/LWpHrlXw=
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
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <6c4c8c57-7cc7-7e24-1d19-b91a312d44a0@shipmail.org>
Date: Mon, 31 May 2021 13:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <888c52a5-ec10-0dee-c462-93cef8510e9f@amd.com>
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

Ck9uIDUvMzEvMjEgMTI6NTYgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMzEuMDUu
MjEgdW0gMTI6NDYgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+Pgo+PiBPbiA1
LzMxLzIxIDEyOjMyIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMzEuMDUuMjEg
dW0gMTE6NTIgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+Pj4+IEhpLCBMYW5n
LAo+Pj4+Cj4+Pj4gT24gNS8zMS8yMSAxMDoxOSBBTSwgWXUsIExhbmcgd3JvdGU6Cj4+Pj4+IFtQ
dWJsaWNdCj4+Pj4+Cj4+Pj4+PiBIaSwKPj4+Pj4+IE9uIDUvMjcvMjEgMzozMCBBTSwgTGFuZyBZ
dSB3cm90ZToKPj4+Pj4+PiBNYWtlIFRUTV9QTF9GTEFHXyogc3RhcnQgZnJvbSB6ZXJvIGFuZCBh
ZGQKPj4+Pj4+PiBUVE1fUExfRkxBR19URU1QT1JBUlkgZmxhZyBmb3IgdGVtcG9yYXJ5Cj4+Pj4+
Pj4gR1RUIGFsbG9jYXRpb24gdXNlLgo+Pj4+Pj4gR1RUIGlzIGEgZHJpdmVyIHByaXZhdGUgYWNy
b255bSwgcmlnaHQ/IEFuZCBpdCBkb2Vzbid0IGxvb2sgbGlrZQo+Pj4+Pj4gVFRNX1BMX0ZMQUdf
VEVNUE9SQVJZIHdpbGwgYmUgdXNlZCBpbiBjb3JlIFRUTSwgc28gc2hvdWxkIHdlIAo+Pj4+Pj4g
aW5zdGVhZCBzZXQKPj4+Pj4+IGFzaWRlIGEgbWFzayBpbiB0aGUgUEwgZmxhZyBmb3IgZHJpdmVy
LXByaXZhdGUgdXNlPwo+Pj4+PiBIaSBUaG9tYXMsCj4+Pj4+Cj4+Pj4+IFRoYW5rcyBmb3IgeW91
ciBjb21tZW50cyBhbmQgYWR2aWNlLCBHVFQgbWVhbnMgR3JhcGhpY3MgCj4+Pj4+IFRyYW5zbGF0
aW9uIFRhYmxlIGhlcmUsIHNlZW1zCj4+Pj4+IGEgZ2VuZXJhbCBhY3JvbnltLiBUVE1fUExfRkxB
R19URU1QT1JBUlkgbWF5IGFsc28gYmUgdXNlZCBieSBvdGhlciAKPj4+Pj4gZHJpdmVzLgo+Pj4+
PiBJIGhhdmUgbWFkZSBvdGhlciBwYXRjaGVzIGZvciB0aGlzLiBQbGVhc2UgaGVscCByZXZpZXcu
Cj4+Pj4+Cj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+IExhbmcKPj4+Pj4KPj4+PiBNeSBwb2ludCB3YXMg
cmVhbGx5IHRoYXQgdGhlIGZsYWcgbmFtaW5nIGFuZCBkb2N1bWVudGF0aW9uIHNob3VsZCAKPj4+
PiByZWZsZWN0IHdoYXQgY29yZSB0dG0gaXMgZG9pbmcgd2l0aCB0aGF0IGZsYWcuIElmIHRoZXJl
IGlzIG5vIAo+Pj4+IHNwZWNpZmljIGNvcmUgVFRNIHVzYWdlLCBJTU8gd2Ugc2hvdWxkIG1vdmUg
aXQgdG8gYSBkcml2ZXIgc3BlY2lmaWMgCj4+Pj4gZmxhZyB0byBhdm9pZCBmdXR1cmUgY29uZnVz
aW9uLiBJbiBwYXJ0aWN1bGFyIGEgd3JpdGVyIG9mIGEgZ2VuZXJpYyAKPj4+PiBUVE0gcmVzb3Vy
Y2UgbWFuYWdlciBzaG91bGQgYmUgYWJsZSB0byBrbm93IHdpdGhvdXQgbG9va2luZyBhdCBhbiAK
Pj4+PiBvbGQgY29tbWl0IG1lc3NhZ2Ugd2hhdCB0aGUgcGxhY2VtZW50IGZsYWcgaXMgaW50ZW5k
ZWQgZm9yLgo+Pj4+Cj4+Pj4gU28gaGVyZSB3ZSBhZGQgYSBmbGFnIHdoZXJlIGNvcmUgVFRNIGZv
cmNlcyBhIGJvIG1vdmUgb24gdmFsaWRhdGUgCj4+Pj4gYW5kIHRoYXQncyBpdC4gQW5kIHRoYXQg
YXBwZWFycyB0byBiZSBob3cgaXQncyB1c2VkIHdoZW4gYW4gYW1kZ3B1IAo+Pj4+IGJvIGlzIGV2
aWN0ZWQgdG8gR1RULCAoYnR3IHNob3VsZCBpdCBiZSBhY2NvdW50ZWQgaW4gdGhpcyBzaXR1YXRp
b24/KQo+Pj4+Cj4+Pj4gVGhlIG90aGVyIHVzZSBpcyB0byBmb3JjZSB0aGUgYW1kZ3B1IGRyaXZl
ciB0byB0ZW1wb3JhcmlseSBhY2NlcHQgCj4+Pj4gaXQgaW50byBHVFQgd2hlbiB0aGVyZSBpcyBh
IGxhY2sgb2Ygc3BhY2UsIGFuZCBJTUhPIHRoYXQncyBhIGRyaXZlciAKPj4+PiBzcGVjaWZpYyB1
c2UgYW5kIHdlIHNob3VsZCBhbGxvY2F0ZSBhIG1hc2sgZm9yIGRyaXZlciBzcGVjaWZpYyAKPj4+
PiBmbGFncyBmb3IgdGhhdC4KPj4+Pgo+Pj4+IFNvIHNob3VsZG4ndCB0aGlzIGJlIHR3byBmbGFn
cywgcmVhbGx5Pwo+Pj4KPj4+IFdlbGwgb25lIGZsYWcgbWFrZXMgc2Vuc2UgZm9yIHRoZSB1c2Ug
Y2FzZSBhdCBoYW5kIHRoYXQgZHJpdmVycyB3YW50IAo+Pj4gdG8gc2lnbmFsIHRvIFRUTSB0aGF0
IGFuIGFsbG9jYXRpb24gaXMgb25seSB0ZW1wb3JhcnkgYW5kIG5vdCAKPj4+IGNvbnNpZGVyZWQg
dmFsaWQuCj4+Pgo+Pj4gVGhhdCB3ZSB0aGVuIHVzZSB0aGlzIGZsYWcgdG8gaW1wbGVtZW50IHRl
bXBvcmFyeSBHVFQgYWxsb2NhdGlvbnMgdG8gCj4+PiBhdm9pZCBwcm9ibGVtcyBkdXJpbmcgZXZp
Y3Rpb24gaXMganVzdCBleHRlbmRpbmcgdGhhdCB1c2UgY2FzZS4KPj4+Cj4+IE9LLCBidXQgaXQg
bG9va2VkIGxpa2UgdGhlcmUgd2VyZSBhY3R1YWxseSB0d28gdXNlLWNhc2VzLiBPbmUgZm9yIAo+
PiBwb3NzaWJseSBsb25nLXRlcm0gVlJBTSBldmljdGlvbnMgdG8gR1RULCB0aGUgb3RoZXIgZm9y
IHRoZSB0ZW1wb3JhcnkgCj4+IHVzZS1jYXNlIHdoZXJlIHRoZSBob3AgcmVzb3VyY2UgYWxsb2Nh
dGlvbnMgc29tZXRpbWVzIGZhaWxlZC4gT3IgZGlkIAo+PiBJIG1pc3VuZGVyc3RhbmQgdGhlIGNv
ZGU/Cj4KPiBPayBzb3VuZHMgbGlrZSB3ZSBuZWVkIG1vcmUgZG9jdW1lbnRhdGlvbiBoZXJlLiBU
aGF0J3MgcmVhbGx5IG9uZSB1c2UgCj4gY2FzZS4KPgo+IEtleSBwb2ludCBpcyB3ZSBuZWVkIHRl
bXBvcmFyeSBhbGxvY2F0aW9uIGR1cmluZyBtdWx0aWhvcCB3aGljaCBzaG91bGQgCj4gYmUgaGFu
ZGxlZCBkaWZmZXJlbnRseSB0byBub3JtYWwgYWxsb2NhdGlvbnMuCgpZZXMsIHRoYXQgcGFydCBp
cyBjbGVhciBmcm9tIHRoZSBwYXRjaGVzLiBUaGUgcGFydCB0aGF0IEkgY2FuJ3QgZml0IGludG8g
CnRoYXQgcGF0dGVybiBpcyB3aHkgdGhlIGV2aWN0IGZsYWdzIHdoZW4gZXZpY3RpbmcgZnJvbSB2
aXNpYmxlIFZSQU0gdG8gCkdUVCBvciBvcmRpbmFyeSBWUkFNIGlzIG1hcmtlZCB3aXRoIFRUTV9Q
TF9GTEFHX1RFTVBPUkFSWS4gV291bGRuJ3QgCnRob3NlIHJlbWFpbiBldmljdGVkIGluIHRoYXQg
cGxhY2VtZW50IHVudGlsIHJlLXZhbGlkYXRlZCB0byB2aXNpYmxlIApWUkFNIGF0IGFuIHVua25v
d24gZnV0dXJlIHRpbWU/CgpQYXRjaCAzLzM6CgogIAkJCWFtZGdwdV9ib19wbGFjZW1lbnRfZnJv
bV9kb21haW4oYWJvLCBBTURHUFVfR0VNX0RPTUFJTl9HVFQpOwoJCQlhYm8tPnBsYWNlbWVudHNb
MF0uZmxhZ3MgfD0gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZOwoKCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+
Cj4+IC9UaG9tYXMKPj4KPj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4KPj4+PiBUVE1fUExfRkxB
R19GT1JDRV9NT1ZFCj4+Pj4KPj4+PiBhbmQKPj4+Pgo+Pj4+IEFNREdQVV9QTF9GTEFHX1RFTVBP
UkFSWQo+Pj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+Cj4+Pj4gL1Rob21hcwo+Pj4+Cj4+Pj4+PiBUaG9t
YXMKPj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4+PiBGcm9tOiBZdSwgTGFu
ZyA8TGFuZy5ZdUBhbWQuY29tPgo+Pj4+Pj4gU2VudDogVGh1cnNkYXksIE1heSAyNywgMjAyMSA5
OjMxIEFNCj4+Pj4+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+Pj4+IENjOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgSHVhbmcsIFJheQo+Pj4+Pj4gPFJheS5IdWFuZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsKPj4+
Pj4+IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+Cj4+Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBkcm0vdHRtOiBjbGVhbnVwIGFuZCBhZGQgVFRNX1BMX0ZMQUdfVEVNUE9SQVJZCj4+Pj4+Pgo+
Pj4+Pj4gTWFrZSBUVE1fUExfRkxBR18qIHN0YXJ0IGZyb20gemVybyBhbmQgYWRkIFRUTV9QTF9G
TEFHX1RFTVBPUkFSWSAKPj4+Pj4+IGZsYWcKPj4+Pj4+IGZvciB0ZW1wb3JhcnkgR1RUIGFsbG9j
YXRpb24gdXNlLgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVA
YW1kLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQu
aCB8IDUgKysrLS0KPj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1f
cGxhY2VtZW50LmgKPj4+Pj4+IGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaCBpbmRl
eCAKPj4+Pj4+IGFhNmJhNGQwY2Y3OC4uOWY1Y2ZjN2MyZDVhIDEwMDY0NAo+Pj4+Pj4gLS0tIGEv
aW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaAo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9kcm0v
dHRtL3R0bV9wbGFjZW1lbnQuaAo+Pj4+Pj4gQEAgLTQ3LDggKzQ3LDkgQEAKPj4+Pj4+IMKgICog
dG9wIG9mIHRoZSBtZW1vcnkgYXJlYSwgaW5zdGVhZCBvZiB0aGUgYm90dG9tLgo+Pj4+Pj4gwqAg
Ki8KPj4+Pj4+Cj4+Pj4+PiAtI2RlZmluZSBUVE1fUExfRkxBR19DT05USUdVT1VTwqAgKDEgPDwg
MTkpCj4+Pj4+PiAtI2RlZmluZSBUVE1fUExfRkxBR19UT1BET1dOwqDCoMKgwqAgKDEgPDwgMjIp
Cj4+Pj4+PiArI2RlZmluZSBUVE1fUExfRkxBR19DT05USUdVT1VTwqAgKDEgPDwgMCkKPj4+Pj4+
ICsjZGVmaW5lIFRUTV9QTF9GTEFHX1RPUERPV07CoMKgwqDCoCAoMSA8PCAxKQo+Pj4+Pj4gKyNk
ZWZpbmUgVFRNX1BMX0ZMQUdfVEVNUE9SQVJZwqDCoCAoMSA8PCAyKQo+Pj4+Pj4KPj4+Pj4+IC8q
Kgo+Pj4+Pj4gwqAgKiBzdHJ1Y3QgdHRtX3BsYWNlCj4+Pj4+PiAtLSAKPj4+Pj4+IDIuMjUuMQo+
Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q0NocmlzdGlhbi5Lb2VuaWclNDBhbWQuY29tJTdD
Mzg2OGFmMmJkNWQ5NGFlZGE5NGIwOGQ5MjQyMTViM2ElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTgwNTQ3OTgwMTkwMzkxJTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFX
d2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPUM3YjV3ejhLcGg1Yk04ZmtGVnlYS3dT
TmtTajNsRGF4R1Vud3c0alklMkZlTSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+PgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
