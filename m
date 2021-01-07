Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF50C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 08:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1005623133
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1005623133
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4366E400;
	Thu,  7 Jan 2021 08:42:22 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 51E276E400
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 08:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 513BC2A6042;
 Thu,  7 Jan 2021 09:42:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Ap_JarD5KwUs; Thu,  7 Jan 2021 09:42:19 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id E76DF2A6016;
 Thu,  7 Jan 2021 09:42:19 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kxQs7-002tFa-Ch; Thu, 07 Jan 2021 09:42:19 +0100
To: "Deng, Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-3-Emily.Deng@amd.com>
 <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
 <BY5PR12MB411509E4392319DED71623C28FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
 <43274fba-2ba2-76fc-3f9f-b9af7658af89@daenzer.net>
 <BY5PR12MB4115AF59B6C76E2A731D9AA38FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Message-ID: <50fd49e8-e1dc-ceaf-8bf5-f50ae65a3339@daenzer.net>
Date: Thu, 7 Jan 2021 09:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4115AF59B6C76E2A731D9AA38FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-CA
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMS0wNyAzOjI4IGEubS4sIERlbmcsIEVtaWx5IHdyb3RlOgo+PiBGcm9tOiBNaWNo
ZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0Pgo+PiBPbiAyMDIxLTAxLTA2IDExOjQwIGEu
bS4sIERlbmcsIEVtaWx5IHdyb3RlOgo+Pj4+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNo
ZXJAZ21haWwuY29tPiBPbiBUdWUsIEphbiA1LCAyMDIxIGF0Cj4+Pj4gMzozNyBBTSBFbWlseS5E
ZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+IHdyb3RlOgo+Pj4+Pgo+Pj4+PiBMaW1pdCB0aGUgcmVz
b2x1dGlvbiBub3QgYmlnZ2VyIHRoYW4gMTYzODQsIHdoaWNoIG1lYW5zCj4+Pj4+IGRldi0+bW9k
ZV9pbmZvLm51bV9jcnRjICogY29tbW9uX21vZGVzW2ldLncgbm90IGJpZ2dlciB0aGFuIDE2Mzg0
Lgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseS5EZW5nIDxFbWlseS5EZW5nQGFtZC5j
b20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2Vfdmly
dHVhbC5jIHwgNyArKysrKy0tCj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZGNlX3ZpcnR1YWwuYwo+Pj4+PiBpbmRleCAyYjE2YzhmYWNhMzQuLmMyM2QzN2IwMmZk
NyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1
YWwuYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5j
Cj4+Pj4+IEBAIC0zMTksNiArMzE5LDcgQEAgZGNlX3ZpcnR1YWxfZW5jb2RlcihzdHJ1Y3QgZHJt
X2Nvbm5lY3Rvcgo+Pj4+PiAqY29ubmVjdG9yKSAgc3RhdGljIGludCBkY2VfdmlydHVhbF9nZXRf
bW9kZXMoc3RydWN0IGRybV9jb25uZWN0b3IKPj4+Pj4gKmNvbm5lY3RvcikgIHsKPj4+Pj4gICAg
ICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBjb25uZWN0b3ItPmRldjsKPj4+Pj4gKyAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7Cj4+Pj4+
ICAgICAgICAgICBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSA9IE5VTEw7Cj4+Pj4+ICAg
ICAgICAgICB1bnNpZ25lZCBpOwo+Pj4+PiAgICAgICAgICAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
b2RlX3NpemUgeyBAQCAtMzUwLDggKzM1MSwxMCBAQCBzdGF0aWMKPj4+Pj4gaW50IGRjZV92aXJ0
dWFsX2dldF9tb2RlcyhzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yKQo+Pj4+PiAgICAg
ICAgICAgfTsKPj4+Pj4KPj4+Pj4gICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KGNvbW1vbl9tb2Rlcyk7IGkrKykgewo+Pj4+PiAtICAgICAgICAgICAgICAgbW9kZSA9IGRybV9j
dnRfbW9kZShkZXYsIGNvbW1vbl9tb2Rlc1tpXS53LAo+Pj4+IGNvbW1vbl9tb2Rlc1tpXS5oLCA2
MCwgZmFsc2UsIGZhbHNlLCBmYWxzZSk7Cj4+Pj4+IC0gICAgICAgICAgICAgICBkcm1fbW9kZV9w
cm9iZWRfYWRkKGNvbm5lY3RvciwgbW9kZSk7Cj4+Pj4+ICsgICAgICAgICAgICAgICBpZiAoYWRl
di0+bW9kZV9pbmZvLm51bV9jcnRjIDw9IDQgfHwKPj4+Pj4gKyBjb21tb25fbW9kZXNbaV0udyA8
PSAyNTYwKSB7Cj4+Pj4KPj4+PiBZb3UgYXJlIGFsc28gbGltaXRpbmcgdGhlIG51bWJlciBvZiBj
cnRjcyBoZXJlLiAgSW50ZW5kZWQ/ICBXb24ndAo+Pj4+IHRoaXMgYnJlYWsgNSBvciA2IGNydGMg
Y29uZmlncz8KPj4+Pgo+Pj4+IEFsZXgKPj4+IFllcywgaXQgaXMgaW50ZW5kZWQsICBmb3IgbnVt
X2NydGMgYmlnZ2VyIHRoZW4gNCwgZG9uJ3Qgc3VwcG9ydCByZXNvbHV0aW9uCj4+IGJpZ2dlciB0
aGVuIDI1NjAsIGJlY2F1c2Ugb2YgdGhlIG1heCBzdXBwb3J0ZWQgd2lkdGggaXMgMTYzODQgZm9y
IHhjYgo+PiBwcm90b2NvbC4KPj4KPj4gVGhlcmUncyBubyBzdWNoIGxpbWl0YXRpb24gd2l0aCBX
YXlsYW5kLiBJJ2QgcmVjb21tZW5kIGFnYWluc3QgYXJ0aWZpY2lhbGx5Cj4+IGltcG9zaW5nIGxp
bWl0cyBmcm9tIFgxMSB0byB0aGUga2VybmVsLgo+Pgo+Pgo+PiAoQXMgYSBzaWRlIG5vdGUsIHRo
ZSBYMTEgcHJvdG9jb2wgbGltaXQgc2hvdWxkIGFjdHVhbGx5IGJlIDMyNzY4OyB0aGUKPj4gMTYz
ODQgbGltaXQgZXhwb3NlZCBpbiB0aGUgUkFORFIgZXh0ZW5zaW9uIGNvbWVzIGZyb20gdGhlIGtl
cm5lbCBkcml2ZXIsCj4+IHNwZWNpZmljYWxseSBkcm1Nb2RlR2V0UmVzb3VyY2VzJ3MgbWF4X3dp
ZHRoL2hlaWdodCkKPiBJdCBpcyBvdXIgdGVzdCBhbmQgZGVidWcgcmVzdWx0LCB0aGF0IHRoZSBm
b2xsb3cgdmFyaWFibGUgb25seSBoYXZlIDE2Yml0LiBXaWxsIGxpbWl0IHRoZSByZXNvbHV0aW9u
IHRvIDE2Mzg0Lgo+IGdsYW1vcl9waXhtYXBfZnJvbV9mZChTY3JlZW5QdHIgc2NyZWVuLAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IGZkLAo+ICAgICAgICAgICAgICAgICAgICAgICAgQ0FS
RDE2IHdpZHRoLAo+ICAgICAgICAgICAgICAgICAgICAgICAgQ0FSRDE2IGhlaWdodCwKPiAgICAg
ICAgICAgICAgICAgICAgICAgIENBUkQxNiBzdHJpZGUsIENBUkQ4IGRlcHRoLCBDQVJEOCBicHAp
CgpJIGFzc3VtZSB5b3UncmUgcmVmZXJyaW5nIHRvIHRoZSBzdHJpZGUgcGFyYW1ldGVyLCB3aGlj
aCBpcyBpbiBieXRlcy4KClRoaXMgZnVuY3Rpb24gaXMgb25seSB1c2VkIGZvciBwaXhtYXBzIGNy
ZWF0ZWQgZnJvbSBhIGRtYS1idWYgdmlhIERSSTMuIApJdCBkb2VzIG5vdCBsaW1pdCB0aGUgc2l6
ZSBvZiBvdGhlciBwaXhtYXBzLCBzbyBpdCBkb2VzIG5vdCBsaW1pdCB0aGUgCnNpemUgb2YgdGhl
IHNjcmVlbiBwaXhtYXAgKHdoaWNoIGNvcnJlc3BvbmRzIHRvIHRoZSBmcmFtZWJ1ZmZlciBzaXpl
IGluIAp0aGUgUkFORFIgZXh0ZW5zaW9uKSBpbiBnZW5lcmFsLgoKQWxzbywgdGhpcyBpcyBhbiBp
bXBsZW1lbnRhdGlvbiBkZXRhaWwsIHRoZSBsaW1pdGF0aW9uIGNvdWxkIGJlIGxpZnRlZCAKYnkg
Y2hhbmdpbmcgdGhlIHR5cGUgb2YgdGhlIHBhcmFtZXRlciAodGhvdWdoIHRoYXQgd291bGQgYmUg
YW4gQUJJIGJyZWFrIApmb3IgWG9yZykuCgpYd2F5bGFuZCBpc24ndCBhZmZlY3RlZCBieSB0aGlz
OgoKU2NyZWVuIDA6IG1pbmltdW0gMTYgeCAxNiwgY3VycmVudCAxOTIwIHggMTIwMCwgbWF4aW11
bSAzMjc2NyB4IDMyNzY3CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
