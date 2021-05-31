Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F246C47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 10:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6526108D
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 10:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6526108D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF886E8D3;
	Mon, 31 May 2021 10:46:35 +0000 (UTC)
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931336E5C6;
 Mon, 31 May 2021 10:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E2B783F66D;
 Mon, 31 May 2021 12:46:31 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="PRjIlJnS";
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EncB3ffrIzzj; Mon, 31 May 2021 12:46:30 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 2E3053F5AF;
 Mon, 31 May 2021 12:46:29 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id BF8AB3600E5;
 Mon, 31 May 2021 12:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1622457989; bh=gvQ5vJiB+2Eh4zc0FiF1xfvvI4FQHh8M6ep5tLGE40c=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=PRjIlJnSnAt8gPhwma2zA2ZO0VY70mmAFSepZmJTQGw5wVzn2WrM7sdayDs1BZKfQ
 xdZdNp6heVmHMhyIpIx7uG7RnTBqmwsAxfEjOGSRj0jU4kxWgYd5uilehPtK56ouqZ
 NiiHjR4zPtzC1mAMC9/CbwrzPIwVN6ongZfeXTns=
Subject: Re: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
 <883bd629-e3ad-07a2-8952-994f42cb02be@gmail.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <86054733-9b7d-de96-4ab2-21dca85f1e6e@shipmail.org>
Date: Mon, 31 May 2021 12:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <883bd629-e3ad-07a2-8952-994f42cb02be@gmail.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDUvMzEvMjEgMTI6MzIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMzEuMDUu
MjEgdW0gMTE6NTIgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+PiBIaSwgTGFu
ZywKPj4KPj4gT24gNS8zMS8yMSAxMDoxOSBBTSwgWXUsIExhbmcgd3JvdGU6Cj4+PiBbUHVibGlj
XQo+Pj4KPj4+PiBIaSwKPj4+PiBPbiA1LzI3LzIxIDM6MzAgQU0sIExhbmcgWXUgd3JvdGU6Cj4+
Pj4+IE1ha2UgVFRNX1BMX0ZMQUdfKiBzdGFydCBmcm9tIHplcm8gYW5kIGFkZAo+Pj4+PiBUVE1f
UExfRkxBR19URU1QT1JBUlkgZmxhZyBmb3IgdGVtcG9yYXJ5Cj4+Pj4+IEdUVCBhbGxvY2F0aW9u
IHVzZS4KPj4+PiBHVFQgaXMgYSBkcml2ZXIgcHJpdmF0ZSBhY3JvbnltLCByaWdodD8gQW5kIGl0
IGRvZXNuJ3QgbG9vayBsaWtlCj4+Pj4gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIHdpbGwgYmUgdXNl
ZCBpbiBjb3JlIFRUTSwgc28gc2hvdWxkIHdlIAo+Pj4+IGluc3RlYWQgc2V0Cj4+Pj4gYXNpZGUg
YSBtYXNrIGluIHRoZSBQTCBmbGFnIGZvciBkcml2ZXItcHJpdmF0ZSB1c2U/Cj4+PiBIaSBUaG9t
YXMsCj4+Pgo+Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBhZHZpY2UsIEdUVCBtZWFu
cyBHcmFwaGljcyBUcmFuc2xhdGlvbiAKPj4+IFRhYmxlIGhlcmUsIHNlZW1zCj4+PiBhIGdlbmVy
YWwgYWNyb255bS4gVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIG1heSBhbHNvIGJlIHVzZWQgYnkgb3Ro
ZXIgCj4+PiBkcml2ZXMuCj4+PiBJIGhhdmUgbWFkZSBvdGhlciBwYXRjaGVzIGZvciB0aGlzLiBQ
bGVhc2UgaGVscCByZXZpZXcuCj4+Pgo+Pj4gUmVnYXJkcywKPj4+IExhbmcKPj4+Cj4+IE15IHBv
aW50IHdhcyByZWFsbHkgdGhhdCB0aGUgZmxhZyBuYW1pbmcgYW5kIGRvY3VtZW50YXRpb24gc2hv
dWxkIAo+PiByZWZsZWN0IHdoYXQgY29yZSB0dG0gaXMgZG9pbmcgd2l0aCB0aGF0IGZsYWcuIElm
IHRoZXJlIGlzIG5vIAo+PiBzcGVjaWZpYyBjb3JlIFRUTSB1c2FnZSwgSU1PIHdlIHNob3VsZCBt
b3ZlIGl0IHRvIGEgZHJpdmVyIHNwZWNpZmljIAo+PiBmbGFnIHRvIGF2b2lkIGZ1dHVyZSBjb25m
dXNpb24uIEluIHBhcnRpY3VsYXIgYSB3cml0ZXIgb2YgYSBnZW5lcmljIAo+PiBUVE0gcmVzb3Vy
Y2UgbWFuYWdlciBzaG91bGQgYmUgYWJsZSB0byBrbm93IHdpdGhvdXQgbG9va2luZyBhdCBhbiBv
bGQgCj4+IGNvbW1pdCBtZXNzYWdlIHdoYXQgdGhlIHBsYWNlbWVudCBmbGFnIGlzIGludGVuZGVk
IGZvci4KPj4KPj4gU28gaGVyZSB3ZSBhZGQgYSBmbGFnIHdoZXJlIGNvcmUgVFRNIGZvcmNlcyBh
IGJvIG1vdmUgb24gdmFsaWRhdGUgYW5kIAo+PiB0aGF0J3MgaXQuIEFuZCB0aGF0IGFwcGVhcnMg
dG8gYmUgaG93IGl0J3MgdXNlZCB3aGVuIGFuIGFtZGdwdSBibyBpcyAKPj4gZXZpY3RlZCB0byBH
VFQsIChidHcgc2hvdWxkIGl0IGJlIGFjY291bnRlZCBpbiB0aGlzIHNpdHVhdGlvbj8pCj4+Cj4+
IFRoZSBvdGhlciB1c2UgaXMgdG8gZm9yY2UgdGhlIGFtZGdwdSBkcml2ZXIgdG8gdGVtcG9yYXJp
bHkgYWNjZXB0IGl0IAo+PiBpbnRvIEdUVCB3aGVuIHRoZXJlIGlzIGEgbGFjayBvZiBzcGFjZSwg
YW5kIElNSE8gdGhhdCdzIGEgZHJpdmVyIAo+PiBzcGVjaWZpYyB1c2UgYW5kIHdlIHNob3VsZCBh
bGxvY2F0ZSBhIG1hc2sgZm9yIGRyaXZlciBzcGVjaWZpYyBmbGFncyAKPj4gZm9yIHRoYXQuCj4+
Cj4+IFNvIHNob3VsZG4ndCB0aGlzIGJlIHR3byBmbGFncywgcmVhbGx5Pwo+Cj4gV2VsbCBvbmUg
ZmxhZyBtYWtlcyBzZW5zZSBmb3IgdGhlIHVzZSBjYXNlIGF0IGhhbmQgdGhhdCBkcml2ZXJzIHdh
bnQgCj4gdG8gc2lnbmFsIHRvIFRUTSB0aGF0IGFuIGFsbG9jYXRpb24gaXMgb25seSB0ZW1wb3Jh
cnkgYW5kIG5vdCAKPiBjb25zaWRlcmVkIHZhbGlkLgo+Cj4gVGhhdCB3ZSB0aGVuIHVzZSB0aGlz
IGZsYWcgdG8gaW1wbGVtZW50IHRlbXBvcmFyeSBHVFQgYWxsb2NhdGlvbnMgdG8gCj4gYXZvaWQg
cHJvYmxlbXMgZHVyaW5nIGV2aWN0aW9uIGlzIGp1c3QgZXh0ZW5kaW5nIHRoYXQgdXNlIGNhc2Uu
Cj4KT0ssIGJ1dCBpdCBsb29rZWQgbGlrZSB0aGVyZSB3ZXJlIGFjdHVhbGx5IHR3byB1c2UtY2Fz
ZXMuIE9uZSBmb3IgCnBvc3NpYmx5IGxvbmctdGVybSBWUkFNIGV2aWN0aW9ucyB0byBHVFQsIHRo
ZSBvdGhlciBmb3IgdGhlIHRlbXBvcmFyeSAKdXNlLWNhc2Ugd2hlcmUgdGhlIGhvcCByZXNvdXJj
ZSBhbGxvY2F0aW9ucyBzb21ldGltZXMgZmFpbGVkLiBPciBkaWQgSSAKbWlzdW5kZXJzdGFuZCB0
aGUgY29kZT8KCi9UaG9tYXMKCgo+IENocmlzdGlhbi4KPgo+Pgo+PiBUVE1fUExfRkxBR19GT1JD
RV9NT1ZFCj4+Cj4+IGFuZAo+Pgo+PiBBTURHUFVfUExfRkxBR19URU1QT1JBUlkKPj4KPj4gVGhh
bmtzLAo+Pgo+PiAvVGhvbWFzCj4+Cj4+Pj4gVGhvbWFzCj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPj4+PiBGcm9tOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPgo+Pj4+IFNlbnQ6
IFRodXJzZGF5LCBNYXkgMjcsIDIwMjEgOTozMSBBTQo+Pj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+IENjOiBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgSHVhbmcsIFJheQo+
Pj4+IDxSYXkuSHVhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47Cj4+Pj4gWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT4KPj4+PiBTdWJq
ZWN0OiBbUEFUQ0ggMS8yXSBkcm0vdHRtOiBjbGVhbnVwIGFuZCBhZGQgVFRNX1BMX0ZMQUdfVEVN
UE9SQVJZCj4+Pj4KPj4+PiBNYWtlIFRUTV9QTF9GTEFHXyogc3RhcnQgZnJvbSB6ZXJvIGFuZCBh
ZGQgVFRNX1BMX0ZMQUdfVEVNUE9SQVJZIGZsYWcKPj4+PiBmb3IgdGVtcG9yYXJ5IEdUVCBhbGxv
Y2F0aW9uIHVzZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVAYW1k
LmNvbT4KPj4+PiAtLS0KPj4+PiBpbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oIHwgNSAr
KystLQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaAo+
Pj4+IGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaCBpbmRleCBhYTZiYTRkMGNmNzgu
LjlmNWNmYzdjMmQ1YSAKPj4+PiAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL2RybS90dG0vdHRt
X3BsYWNlbWVudC5oCj4+Pj4gKysrIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaAo+
Pj4+IEBAIC00Nyw4ICs0Nyw5IEBACj4+Pj4gwqAgKiB0b3Agb2YgdGhlIG1lbW9yeSBhcmVhLCBp
bnN0ZWFkIG9mIHRoZSBib3R0b20uCj4+Pj4gwqAgKi8KPj4+Pgo+Pj4+IC0jZGVmaW5lIFRUTV9Q
TF9GTEFHX0NPTlRJR1VPVVPCoCAoMSA8PCAxOSkKPj4+PiAtI2RlZmluZSBUVE1fUExfRkxBR19U
T1BET1dOwqDCoMKgwqAgKDEgPDwgMjIpCj4+Pj4gKyNkZWZpbmUgVFRNX1BMX0ZMQUdfQ09OVElH
VU9VU8KgICgxIDw8IDApCj4+Pj4gKyNkZWZpbmUgVFRNX1BMX0ZMQUdfVE9QRE9XTsKgwqDCoMKg
ICgxIDw8IDEpCj4+Pj4gKyNkZWZpbmUgVFRNX1BMX0ZMQUdfVEVNUE9SQVJZwqDCoCAoMSA8PCAy
KQo+Pj4+Cj4+Pj4gLyoqCj4+Pj4gwqAgKiBzdHJ1Y3QgdHRtX3BsYWNlCj4+Pj4gLS0gCj4+Pj4g
Mi4yNS4xCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
