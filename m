Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430BBC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 15:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F182088E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 15:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F182088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CAA6EB1D;
	Thu,  2 Jul 2020 15:54:19 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id F31EE6E05D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:51:57 +0000 (UTC)
Received: from [10.130.0.52] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxL+g5rv1eD3FOAA--.7310S3;
 Thu, 02 Jul 2020 17:51:54 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
 <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
 <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
 <7aa4d0c5-14ba-594d-e3fb-9acba82cf45d@amd.com>
Message-ID: <897b806e-dba8-710f-6b62-2493e3033417@loongson.cn>
Date: Thu, 2 Jul 2020 17:51:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7aa4d0c5-14ba-594d-e3fb-9acba82cf45d@amd.com>
X-CM-TRANSID: AQAAf9AxL+g5rv1eD3FOAA--.7310S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4xJrWUZFyrKrW8tFWDArb_yoWrGw1xpa
 yrGa4YkrykZw1jv342vryUXFyFyw47XFW8WryDC34a9wn0vFnFyF1xAw4UuFW8Wrs7KF4I
 vr18u3yfWF1jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
 02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
 Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
 6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
 kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
 wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
 7IUYU5r3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Mailman-Approved-At: Thu, 02 Jul 2020 15:54:18 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMDcvMDIvMjAyMCAwNDozOSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwMi4w
Ny4yMCB1bSAxMDozNSBzY2hyaWViIFRpZXpodSBZYW5nOgo+PiBPbiAwNy8wMi8yMDIwIDA0OjI3
IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMDIuMDcuMjAgdW0gMDQ6Mjcgc2No
cmllYiBUaWV6aHUgWWFuZzoKPj4+PiBXaGVuIEkgdXBkYXRlIHRoZSBsYXRlc3Qga2VybmVsLCBJ
IHNlZSB0aGUgZm9sbG93aW5nIAo+Pj4+ICJfX19fcHRydmFsX19fXyIgYm9vdAo+Pj4+IG1lc3Nh
Z2VzLgo+Pj4+Cj4+Pj4gWyAgICAxLjg3MjYwMF0gcmFkZW9uIDAwMDA6MDE6MDUuMDogZmVuY2Ug
ZHJpdmVyIG9uIHJpbmcgMCB1c2UgZ3B1IAo+Pj4+IGFkZHIgMHgwMDAwMDAwMDQ4MDAwYzAwIGFu
ZCBjcHUgYWRkciAweChfX19fcHRydmFsX19fXykKPj4+PiBbICAgIDEuODc5MDk1XSByYWRlb24g
MDAwMDowMTowNS4wOiBmZW5jZSBkcml2ZXIgb24gcmluZyA1IHVzZSBncHUgCj4+Pj4gYWRkciAw
eDAwMDAwMDAwNDAwNTYwMzggYW5kIGNwdSBhZGRyIDB4KF9fX19wdHJ2YWxfX19fKQo+Pj4+Cj4+
Pj4gQm90aCByYWRlb25fZmVuY2VfZHJpdmVyX3N0YXJ0X3JpbmcoKSBhbmQgCj4+Pj4gYW1kZ3B1
X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKCkKPj4+PiBoYXZlIHRoZSBzaW1pbGFyIGlzc3VlLCB0
aGVyZSBleGlzdHMgdGhlIGZvbGxvd2luZyB0d28gbWV0aG9kcyB0byAKPj4+PiBzb2x2ZSBpdDoK
Pj4+PiAoMSkgVXNlICIlcEsiIGluc3RlYWQgb2YgIiVwIiBzbyB0aGF0IHRoZSBDUFUgYWRkcmVz
cyBjYW4gYmUgCj4+Pj4gcHJpbnRlZCB3aGVuCj4+Pj4gdGhlIGtwdHJfcmVzdHJpY3Qgc3lzY3Rs
IGlzIHNldCB0byAxLgo+Pj4+ICgyKSBKdXN0IGNvbXBsZXRlbHkgZHJvcCB0aGUgQ1BVIGFkZHJl
c3Mgc3VnZ2VzdGVkIGJ5IENocmlzdGlhbiwgCj4+Pj4gYmVjYXVzZQo+Pj4+IHRoZSBDUFUgYWRk
cmVzcyB3YXMgdXNlZnVsIGluIHRoZSBwYXN0LCBidXQgaXNuJ3QgYW55IG1vcmUuIFdlIG5vdyAK
Pj4+PiBoYXZlIGEKPj4+PiBkZWJ1Z2ZzIGZpbGUgdG8gcmVhZCB0aGUgY3VycmVudCBmZW5jZSB2
YWx1ZXMuCj4+Pj4KPj4+PiBTaW5jZSB0aGUgQ1BVIGFkZHJlc3MgaXMgbm90IG11Y2ggdXNlZnVs
LCBqdXN0IHJlbW92ZSB0aGUgZGVidWcgCj4+Pj4gaW5mbyBhYm91dAo+Pj4+IENQVSBhZGRyZXNz
Lgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9vbmdz
b24uY24+Cj4+Pgo+Pj4gU3BsaXR0aW5nIGl0IGludG8gb25lIHBhdGNoIGZvciByYWRlb24gYW5k
IG9uZSBmb3IgYW1kZ3B1IG1pZ2h0IGJlIAo+Pj4gbmljZSB0byBoYXZlLgo+Pgo+PiBTaG91bGQg
SSBzcGxpdCB0aGlzIHBhdGNoIGludG8gdHdvIHBhdGNoZXMgYW5kIHRoZW4gc2VuZCB2Mz8KPj4g
SWYgeWVzLCBJIHdpbGwgZG8gaXQgc29vbi4KPgo+IEZvciBtZSBpdCdzIG9rIHRvIG1lcmdlIGl0
IGxpa2UgaXQgaXMgbm93Lgo+Cj4gT25seSBBbGV4IGNvdWxkIGluc2lzdHMgdG8gc3BsaXQgdGhl
IHBhdGNoZXMsIGJ1dCB0aGVuIGhlIHdpbGwgCj4gcHJvYmFibHkgZG8gaXQgaGltc2VsZi4KCk9L
LCB0aGVuIEkgd2lsbCBub3Qgc2VuZCB2My4KCj4KPiBUaGFua3MgZm9yIHRoZSBoZWxwLAo+IENo
cmlzdGlhbi4KPgo+Pgo+Pj4KPj4+IEJ1dCBlaXRoZXIgd2F5IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIAo+Pj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRoZSBwYXRjaC4K
Pj4+Cj4+PiBUaGFua3MsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IC0tLQo+Pj4+Cj4+Pj4gdjI6
Cj4+Pj4gICAgLSBKdXN0IHJlbW92ZSB0aGUgZGVidWcgaW5mbyBhYm91dCBDUFUgYWRkcmVzcyBz
dWdnZXN0ZWQgYnkgCj4+Pj4gQ2hyaXN0aWFuCj4+Pj4gICAgLSBNb2RpZnkgdGhlIHBhdGNoIHN1
YmplY3QgYW5kIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UKPj4+Pgo+Pj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA1ICsrLS0tCj4+Pj4gICBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9mZW5jZS5jICAgICB8IDQgKystLQo+Pj4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgCj4+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4+IGluZGV4IGQ4
NzhmZTcuLmEyOWYyZjkgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZlbmNlLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZmVuY2UuYwo+Pj4+IEBAIC00MjIsOSArNDIyLDggQEAgaW50IGFtZGdwdV9mZW5jZV9k
cml2ZXJfc3RhcnRfcmluZyhzdHJ1Y3QgCj4+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcsCj4+Pj4gICAg
ICAgcmluZy0+ZmVuY2VfZHJ2LmlycV90eXBlID0gaXJxX3R5cGU7Cj4+Pj4gICAgICAgcmluZy0+
ZmVuY2VfZHJ2LmluaXRpYWxpemVkID0gdHJ1ZTsKPj4+PiAgIC0gICAgRFJNX0RFVl9ERUJVRyhh
ZGV2LT5kZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2UgZ3B1IAo+Pj4+IGFkZHIgIgo+
Pj4+IC0gICAgICAgICAgICAgICIweCUwMTZsbHgsIGNwdSBhZGRyIDB4JXBcbiIsIHJpbmctPm5h
bWUsCj4+Pj4gLSAgICAgICAgICAgICAgcmluZy0+ZmVuY2VfZHJ2LmdwdV9hZGRyLCByaW5nLT5m
ZW5jZV9kcnYuY3B1X2FkZHIpOwo+Pj4+ICsgICAgRFJNX0RFVl9ERUJVRyhhZGV2LT5kZXYsICJm
ZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2UgZ3B1IGFkZHIgCj4+Pj4gMHglMDE2bGx4XG4iLAo+
Pj4+ICsgICAgICAgICAgICAgIHJpbmctPm5hbWUsIHJpbmctPmZlbmNlX2Rydi5ncHVfYWRkcik7
Cj4+Pj4gICAgICAgcmV0dXJuIDA7Cj4+Pj4gICB9Cj4+Pj4gICBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2UuYyAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2ZlbmNlLmMKPj4+PiBpbmRleCA0M2YyZjkzLi44NzM1YmYyIDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ZlbmNlLmMKPj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9mZW5jZS5jCj4+Pj4gQEAgLTg2NSw4ICs4
NjUsOCBAQCBpbnQgcmFkZW9uX2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKHN0cnVjdCAKPj4+PiBy
YWRlb25fZGV2aWNlICpyZGV2LCBpbnQgcmluZykKPj4+PiAgICAgICB9Cj4+Pj4gICAgICAgcmFk
ZW9uX2ZlbmNlX3dyaXRlKHJkZXYsIAo+Pj4+IGF0b21pYzY0X3JlYWQoJnJkZXYtPmZlbmNlX2Ry
dltyaW5nXS5sYXN0X3NlcSksIHJpbmcpOwo+Pj4+ICAgICAgIHJkZXYtPmZlbmNlX2RydltyaW5n
XS5pbml0aWFsaXplZCA9IHRydWU7Cj4+Pj4gLSAgICBkZXZfaW5mbyhyZGV2LT5kZXYsICJmZW5j
ZSBkcml2ZXIgb24gcmluZyAlZCB1c2UgZ3B1IGFkZHIgCj4+Pj4gMHglMDE2bGx4IGFuZCBjcHUg
YWRkciAweCVwXG4iLAo+Pj4+IC0gICAgICAgICByaW5nLCByZGV2LT5mZW5jZV9kcnZbcmluZ10u
Z3B1X2FkZHIsIAo+Pj4+IHJkZXYtPmZlbmNlX2RydltyaW5nXS5jcHVfYWRkcik7Cj4+Pj4gKyAg
ICBkZXZfaW5mbyhyZGV2LT5kZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlZCB1c2UgZ3B1IGFk
ZHIgCj4+Pj4gMHglMDE2bGx4XG4iLAo+Pj4+ICsgICAgICAgICByaW5nLCByZGV2LT5mZW5jZV9k
cnZbcmluZ10uZ3B1X2FkZHIpOwo+Pj4+ICAgICAgIHJldHVybiAwOwo+Pj4+ICAgfQo+PgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
