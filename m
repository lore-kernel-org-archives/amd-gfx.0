Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02938C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 17:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD572073E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 17:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD572073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AE36E86C;
	Mon, 22 Jun 2020 17:28:47 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8ED6E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 17:25:53 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5af529.dynamic.kabel-deutschland.de
 [95.90.245.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 86A8B2002EE15;
 Mon, 22 Jun 2020 19:25:50 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Warn about disabled DPM
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
 <20200619185009.12966-3-pmenzel@molgen.mpg.de>
 <fdcc2c10-26cd-3183-42c6-daf36d5df1e9@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <5916b5fa-cc2d-f8df-ca55-505034f09f58@molgen.mpg.de>
Date: Mon, 22 Jun 2020 19:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fdcc2c10-26cd-3183-42c6-daf36d5df1e9@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 22 Jun 2020 17:28:44 +0000
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciBDaHJpc3RpYW4sCgoKQW0gMjIuMDYuMjAgdW0gMTU6Mzkgc2NocmllYiBDaHJpc3RpYW4g
S8O2bmlnOgo+IEFtIDE5LjA2LjIwIHVtIDIwOjUwIHNjaHJpZWIgUGF1bCBNZW56ZWw6Cj4+IEN1
cnJlbnRseSwgYmVzaWRlcyB0aGVyZSBpcyBubyBleHBsaWNpdCBtZXNzYWdlLCB0aGF0IERQTSBp
cyBkaXNhYmxlZC4KPj4gVGhlIHVzZXIgd291bGQgbmVlZCB0byBrbm93LCB0aGF0IHRoZSBtaXNz
aW5nIHN1Y2Nlc3MgbGluZSBpbmRpY2F0ZXMKPj4gdGhhdC4KPj4KPj4gwqDCoMKgwqAgW2RybV0g
YW1kZ3B1OiBkcG0gaW5pdGlhbGl6ZWQKPj4KPj4gU28sIGFkZCBhbiBleHBsaWNpdCBtZXNzYWdl
LCBhbmQgbWFrZSBpdCBsb2cgbGV2ZWwgd2FybmluZywgYXMgZGlzYWJsaW5nCj4+IGRwbSBpcyBu
b3QgdGhlIGRlZmF1bHQsIGFuZCBkZXZpY2UgcGVyZm9ybWFuY2Ugd2lsbCBtb3N0IGxpa2VseSBz
dWZmZXIuCj4+Cj4+IFJlc29sdmVzOiAKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
ZyUyRmRybSUyRmFtZCUyRi0lMkZpc3N1ZXMlMkYxMTczJmFtcDtkYXRhPTAyJTdDMDElN0NjaHJp
c3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3Q2E5M2Y2MTIxYzJhYjQ2NGI3YzE5MDhkODE0ODFhMjRh
JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzI4MTg5NDMw
MzM5NDg1NSZhbXA7c2RhdGE9bGJjcEI4SDlUbmJJU0c4VkZmY2lLaCUyRktHQzdZd2tWWXhVZjRZ
N2REVnQ4JTNEJmFtcDtyZXNlcnZlZD0wIAoKVGhhdCBVUkwgaXMgbm90IG1pbmUuIDstKQoKPj4g
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IFNpZ25lZC1vZmYtYnk6IFBhdWwg
TWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+Cj4+IC0tLQo+PiB2MjogVXNlIG5ldyBwcmlu
dCBoZWxwZXJzLCBhbmQgaW5mb3JtIHVzZXIgYWJvdXQgZWZmZWN0cy4KPj4KPj4gwqAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMgfCA0ICsrKy0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgfCA0ICsrKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9rdl9kcG0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9rdl9kcG0uYwo+PiBpbmRleCBmMDU0ZGVkOTAyZjIuLmM2MDE1ODdjNmQ1OSAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMKPj4gQEAgLTMwMTQsOCArMzAxNCwxMCBA
QCBzdGF0aWMgaW50IGt2X2RwbV9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4gwqDCoMKgwqDCoCBh
ZGV2LT5wbS5jdXJyZW50X21jbGsgPSBhZGV2LT5jbG9jay5kZWZhdWx0X21jbGs7Cj4+IMKgwqDC
oMKgwqAgYWRldi0+cG0uaW50X3RoZXJtYWxfdHlwZSA9IFRIRVJNQUxfVFlQRV9OT05FOwo+PiAt
wqDCoMKgIGlmIChhbWRncHVfZHBtID09IDApCj4+ICvCoMKgwqAgaWYgKGFtZGdwdV9kcG0gPT0g
MCkgewo+PiArwqDCoMKgwqDCoMKgwqAgZHJtX3dhcm4oYWRldiwgImFtZGdwdTogZHBtIGRpc2Fi
bGVkIHBlciBwYXJhbWV0ZXIuIFlvdXIgCj4+IGdyYXBoaWNzIGRldmljZSB3aWxsIHJ1biB3aXRo
IGxvd2VyIGNsb2NrcyBpbXBhY3RpbmcgZ3JhcGhpY3MgCj4+IHBlcmZvcm1hbmNlLlxuIik7Cj4g
Cj4gSSdtIG5vdCB2ZXJ5IGtlZW4gYWJvdXQgdGhpcy4gV2hlbiBhbiB1c2VyIHNwZWNpZmllcyB0
aGF0IERQTSBzaG91bGRuJ3QgCj4gYmUgdXNlZCB0aGUgZHJpdmVyIGRvZXNuJ3QgbmVlZCB0byBp
bmZvcm0gdGhlIHVzZXIgYWJvdXQgdGhpcyBvbmNlIG1vcmUuCj4gCj4gSW4gb3RoZXIgd29yZHMg
c2hvb3RpbmcgaW4geW91ciBvd24gZm9vdCBpcyBzdXBwb3NlZCB0byBodXJ0LgoKTWF5YmUuIFRo
ZSBvdGhlciBwb2ludCBvZiB2aWV3IGlzLCBob3cgZG9lcyBoYXZpbmcgdGhlIGNsYXJpdHkgaW4g
dGhlIApsb2dzIGh1cnQ/IEZvciBleGFtcGxlLCBpZiB0aGUgdXNlciBhZGRlZCB0aGUgcGFyYW1l
dGVyIGludGVudGlvbmFsbHksIAptYXliZSB0aGV5IG1hZGUgYSB0eXBvLCBhbmQgaXTigJlzIGFj
dHVhbGx5IG5vdCBhcHBsaWVkLiBPciB0aGVyZSBpcyBhIGJ1ZyAKaW4gdGhlIHBhcmFtZXRlciBo
YW5kbGluZy4gSGF2aW5nIGV4cGxpY2l0IGxvZyBtZXNzYWdlcyBpcyBnb29kIGluIG15IApvcGlu
aW9uLgoKU2Vjb25kbHksIHRoZSBwYXJhbWV0ZXIgY291bGQgaGF2ZSBiZWVuIGxlZnQgdGhlcmUg
dW5pbnRlbnRpb25hbGx5LiAKSGF2aW5nIHRoZSBtZXNzYWdlIGluIHRoZSBsb2dzLCBtYWtlcyB0
aGUgdXNlciBhd2FyZSBvZiB0aGEuCgoKS2luZCByZWdhcmRzLAoKUGF1bAoKCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgSU5JVF9XT1JL
KCZhZGV2LT5wbS5kcG0udGhlcm1hbC53b3JrLCAKPj4gYW1kZ3B1X2RwbV90aGVybWFsX3dvcmtf
aGFuZGxlcik7Cj4+IMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOwo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKPj4gaW5kZXggZjdlZGMxZDUwZGY0Li4x
ZjM1ZDVhMzYzMDAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Np
X2RwbS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCj4+IEBA
IC03Njg3LDggKzc2ODcsMTAgQEAgc3RhdGljIGludCBzaV9kcG1fc3dfaW5pdCh2b2lkICpoYW5k
bGUpCj4+IMKgwqDCoMKgwqAgYWRldi0+cG0uY3VycmVudF9tY2xrID0gYWRldi0+Y2xvY2suZGVm
YXVsdF9tY2xrOwo+PiDCoMKgwqDCoMKgIGFkZXYtPnBtLmludF90aGVybWFsX3R5cGUgPSBUSEVS
TUFMX1RZUEVfTk9ORTsKPj4gLcKgwqDCoCBpZiAoYW1kZ3B1X2RwbSA9PSAwKQo+PiArwqDCoMKg
IGlmIChhbWRncHVfZHBtID09IDApIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGRybV93YXJuKGFkZXYs
ICJhbWRncHU6IGRwbSBkaXNhYmxlZCBwZXIgcGFyYW1ldGVyLiBZb3VyIAo+PiBncmFwaGljcyBk
ZXZpY2Ugd2lsbCBydW4gd2l0aCBsb3dlciBjbG9ja3MgaW1wYWN0aW5nIGdyYXBoaWNzIAo+PiBw
ZXJmb3JtYW5jZS5cbiIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICvCoMKg
wqAgfQo+PiDCoMKgwqDCoMKgIHJldCA9IHNpX2RwbV9pbml0X21pY3JvY29kZShhZGV2KTsKPj4g
wqDCoMKgwqDCoCBpZiAocmV0KQo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
