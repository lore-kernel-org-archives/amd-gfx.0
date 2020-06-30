Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B4C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 14:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBC72072D
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 14:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBC72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159256E2C4;
	Tue, 30 Jun 2020 14:10:46 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id CA2F96E115
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 12:14:28 +0000 (UTC)
Received: from [10.130.0.52] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT2ifLPte1wpNAA--.794S3;
 Tue, 30 Jun 2020 20:14:23 +0800 (CST)
Subject: Re: [PATCH] gpu/drm: Replace "%p" with "%pK"
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <1593502561-15190-1-git-send-email-yangtiezhu@loongson.cn>
 <26fcd5ec-4e90-8b98-8fbb-605f5906ad75@amd.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <286d0a26-c0bd-f151-12c7-dafb34016230@loongson.cn>
Date: Tue, 30 Jun 2020 20:14:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <26fcd5ec-4e90-8b98-8fbb-605f5906ad75@amd.com>
X-CM-TRANSID: AQAAf9DxT2ifLPte1wpNAA--.794S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fGF47Aw1fWrWrGFyrCrg_yoW5Wr1kpF
 4xGFyYkr95Zw1j9347AFyUAFyFyw47Xay8GF1UC34S9w15ZF4jkF13Jr47XrW8XFs2yr42
 qr1Uuay5WF1jkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
 c2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
 0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
 AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
 CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
 67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
 9x07j7F4iUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Mailman-Approved-At: Tue, 30 Jun 2020 14:10:45 +0000
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

T24gMDYvMzAvMjAyMCAwNDowNSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAzMC4w
Ni4yMCB1bSAwOTozNiBzY2hyaWViIFRpZXpodSBZYW5nOgo+PiBXaGVuIEkgdXBkYXRlIHRoZSBs
YXRlc3Qga2VybmVsLCBJIHNlZSB0aGUgZm9sbG93aW5nICJfX19fcHRydmFsX19fXyIgCj4+IGJv
b3QKPj4gbWVzc2FnZXMuIFVzZSAiJXBLIiBpbnN0ZWFkIG9mICIlcCIgc28gdGhhdCB0aGUgY3B1
IGFkZHJlc3MgY2FuIGJlIAo+PiBwcmludGVkCj4+IHdoZW4gdGhlIGtwdHJfcmVzdHJpY3Qgc3lz
Y3RsIGlzIHNldCB0byAxLgo+Pgo+PiBCb3RoIHJhZGVvbl9mZW5jZV9kcml2ZXJfc3RhcnRfcmlu
ZygpIGFuZCAKPj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKCkKPj4gaGF2ZSB0aGlz
IHNpbWlsYXIgaXNzdWUsIGZpeCB0aGVtLgo+Pgo+PiBbICAgIDEuODcyNjAwXSByYWRlb24gMDAw
MDowMTowNS4wOiBmZW5jZSBkcml2ZXIgb24gcmluZyAwIHVzZSBncHUgCj4+IGFkZHIgMHgwMDAw
MDAwMDQ4MDAwYzAwIGFuZCBjcHUgYWRkciAweChfX19fcHRydmFsX19fXykKPj4gWyAgICAxLjg3
OTA5NV0gcmFkZW9uIDAwMDA6MDE6MDUuMDogZmVuY2UgZHJpdmVyIG9uIHJpbmcgNSB1c2UgZ3B1
IAo+PiBhZGRyIDB4MDAwMDAwMDA0MDA1NjAzOCBhbmQgY3B1IGFkZHIgMHgoX19fX3B0cnZhbF9f
X18pCj4KPiBXZSBjYW4gcHJvYmFibHkganVzdCBjb21wbGV0ZWx5IGRyb3AgdGhlIENQVSBhZGRy
ZXNzIGhlcmUuCgpPSywgbWF5YmUgdGhlIENQVSBhZGRyZXNzIGlzIG5vdCBtdWNoIHVzZWZ1bC4g
SWYgbm9ib2R5IGhhcyBhbnkgb2JqZWN0aW9ucywKSSB3aWxsIHNlbmQgdjIgdG8gcmVtb3ZlIHRo
ZSBkZWJ1ZyBpbmZvIGFib3V0IENQVSBhZGRyZXNzLgoKVGhhbmtzLApUaWV6aHUKCj4KPiBDaHJp
c3RpYW4uCj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9v
bmdzb24uY24+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9m
ZW5jZS5jIHwgNSArKy0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ZlbmNl
LmMgICAgIHwgMiArLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZlbmNlLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zl
bmNlLmMKPj4gaW5kZXggZDg3OGZlNy4uZDRkMWU4YyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4gQEAgLTQyMiw5ICs0MjIsOCBAQCBpbnQgYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKHN0cnVjdCAKPj4gYW1kZ3B1X3JpbmcgKnJpbmcs
Cj4+ICAgICAgIHJpbmctPmZlbmNlX2Rydi5pcnFfdHlwZSA9IGlycV90eXBlOwo+PiAgICAgICBy
aW5nLT5mZW5jZV9kcnYuaW5pdGlhbGl6ZWQgPSB0cnVlOwo+PiAgIC0gICAgRFJNX0RFVl9ERUJV
RyhhZGV2LT5kZXYsICJmZW5jZSBkcml2ZXIgb24gcmluZyAlcyB1c2UgZ3B1IGFkZHIgIgo+PiAt
ICAgICAgICAgICAgICAiMHglMDE2bGx4LCBjcHUgYWRkciAweCVwXG4iLCByaW5nLT5uYW1lLAo+
PiAtICAgICAgICAgICAgICByaW5nLT5mZW5jZV9kcnYuZ3B1X2FkZHIsIHJpbmctPmZlbmNlX2Ry
di5jcHVfYWRkcik7Cj4+ICsgICAgRFJNX0RFVl9ERUJVRyhhZGV2LT5kZXYsICJmZW5jZSBkcml2
ZXIgb24gcmluZyAlcyB1c2UgZ3B1IGFkZHIgCj4+IDB4JTAxNmxseCwgY3B1IGFkZHIgMHglcEtc
biIsCj4+ICsgICAgICAgICAgICAgIHJpbmctPm5hbWUsIHJpbmctPmZlbmNlX2Rydi5ncHVfYWRk
ciwgCj4+IHJpbmctPmZlbmNlX2Rydi5jcHVfYWRkcik7Cj4+ICAgICAgIHJldHVybiAwOwo+PiAg
IH0KPj4gICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2Uu
YyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9mZW5jZS5jCj4+IGluZGV4IDQz
ZjJmOTMuLmM1MWIwOTQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2ZlbmNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZmVuY2Uu
Ywo+PiBAQCAtODY1LDcgKzg2NSw3IEBAIGludCByYWRlb25fZmVuY2VfZHJpdmVyX3N0YXJ0X3Jp
bmcoc3RydWN0IAo+PiByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgcmluZykKPj4gICAgICAgfQo+
PiAgICAgICByYWRlb25fZmVuY2Vfd3JpdGUocmRldiwgCj4+IGF0b21pYzY0X3JlYWQoJnJkZXYt
PmZlbmNlX2RydltyaW5nXS5sYXN0X3NlcSksIHJpbmcpOwo+PiAgICAgICByZGV2LT5mZW5jZV9k
cnZbcmluZ10uaW5pdGlhbGl6ZWQgPSB0cnVlOwo+PiAtICAgIGRldl9pbmZvKHJkZXYtPmRldiwg
ImZlbmNlIGRyaXZlciBvbiByaW5nICVkIHVzZSBncHUgYWRkciAKPj4gMHglMDE2bGx4IGFuZCBj
cHUgYWRkciAweCVwXG4iLAo+PiArICAgIGRldl9pbmZvKHJkZXYtPmRldiwgImZlbmNlIGRyaXZl
ciBvbiByaW5nICVkIHVzZSBncHUgYWRkciAKPj4gMHglMDE2bGx4IGFuZCBjcHUgYWRkciAweCVw
S1xuIiwKPj4gICAgICAgICAgICByaW5nLCByZGV2LT5mZW5jZV9kcnZbcmluZ10uZ3B1X2FkZHIs
IAo+PiByZGV2LT5mZW5jZV9kcnZbcmluZ10uY3B1X2FkZHIpOwo+PiAgICAgICByZXR1cm4gMDsK
Pj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
