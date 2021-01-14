Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 13:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E6223A57
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 13:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E6223A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF016E28A;
	Thu, 14 Jan 2021 13:00:07 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554116E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 13:00:04 +0000 (UTC)
Received: from [192.168.0.6] (ip5f5aeaac.dynamic.kabel-deutschland.de
 [95.90.234.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8A9A620645D7C;
 Thu, 14 Jan 2021 14:00:02 +0100 (CET)
Subject: Re: [PATCH 1/2] drm/amdgpu: Add Secure Display TA header file
To: Jinzhou Su <Jinzhou.Su@amd.com>
References: <20210113034354.14557-1-Jinzhou.Su@amd.com>
 <337dfe8b-bd6a-2321-fd9b-1c93644e5856@molgen.mpg.de>
 <DM6PR12MB2812F15A7F0C33E08BDC6F1B90A80@DM6PR12MB2812.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <103ddb64-52a2-df24-1ef1-72ae2d9846aa@molgen.mpg.de>
Date: Thu, 14 Jan 2021 14:00:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB2812F15A7F0C33E08BDC6F1B90A80@DM6PR12MB2812.namprd12.prod.outlook.com>
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
Cc: Ray Huang <Ray.Huang@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkRlYXIgSmluemhvdSwKCgpBbSAxNC4wMS4yMSB1bSAwODoyOSBzY2hyaWViIFN1LCBKaW56aG91
IChKb2UpOgoKPiBUaGFua3Mgc28gbXVjaCBmb3IgeW91ciByZXZpZXcuIEFuc3dlciB5b3VyIFF1
ZXN0aW9uIGlubGluZS4gUGxlYXNlIGNoZWNrLgoKQW4gZW1haWwgY2xpZW50LCBmb2xsb3dpbmcg
c3RhbmRhcmRzIHdoZW4gcmVzcG9uZGluZyBhbmQgY2l0aW5nIG1lc3NhZ2VzIApjb3JyZWN0bHks
IHdvdWxkIGJlIG5pY2UuCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogUGF1
bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KPiBTZW50OiBUaHVyc2RheSwgSmFudWFy
eSAxNCwgMjAyMSAzOjA2IEFNCgo+IEFtIDEzLjAxLjIxIHVtIDA0OjQzIHNjaHJpZWIgSmluemhv
dSBTdToKPj4gQWRkIGZpbGUgdGFfc2VjdXJlRGlzcGxheV9pZi5oIGZvciBTZWN1cmUgRGlzcGxh
eSBUQQo+IAo+IFdoYXQgaXMgKlNlY3VyZSBEaXNwbGF5IFRBKj8gUGxlYXNlIGdpdmUgc29tZSBi
YWNrZ3JvdW5kLCBhbmQgZXZlbiBleGFtcGxlcyBob3cgaXQgY2FuIGJlIHVzZWQuCj4gCj4gSG93
IGlzIHRoZSBoZWFkZXIgZmlsZSBnZW5lcmF0ZWQ/Cj4gCj4gSm9lOiBBY3R1YWxseSBJIGdvdCB0
aGlzIGZyb20gRGlzcGxheSBUZWFtLiBEcml2ZXIgdGVhbSdzCj4gcmVzcG9uc2liaWxpdHkgaXMg
dG8gbG9hZCB0aGUgVEEgYW5kIGFkZCBpbnRlcmZhY2UuIPCfmIoKClRoZW4gcGxlYXNlIG1lbnRp
b24gdGhhdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuCgo+IFdoYXQgZG8gdGhlIGNvbW1lbnRzIG1l
YW4sIHdoZW4gdGhleSByZWZlciB0byDigJxmb3IgdmFsaWRhdGlvbiBvbmx54oCdIG9yIHNpbWls
YXIuCj4gCj4+IFNpZ25lZC1vZmYtYnk6IEppbnpob3UgU3UgPEppbnpob3UuU3VAYW1kLmNvbT4K
Pj4gUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4+IFJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IC0tLQo+PiAg
ICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L3RhX3NlY3VyZURpc3BsYXlfaWYuaCAgfCAxNTQgKysr
KysrKysrKysrKysrKysrCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNTQgaW5zZXJ0aW9ucygrKQo+
PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdGFfc2Vj
dXJlRGlzcGxheV9pZi5oCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS90YV9zZWN1cmVEaXNwbGF5X2lmLmgKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS90YV9zZWN1cmVEaXNwbGF5X2lmLmgKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi41MDM5Mzc1YmIxZDQKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS90YV9zZWN1cmVEaXNwbGF5X2lmLmgKPiAKPiBXaHkgaXMg
dGhlIGhlYWRlciBhZGRlZCBpbiBhIHNlcGFyYXRlIGNvbW1pdCwgYW5kIG5vdCBib3RoIGNvbW1p
dHMgc3F1YXNoZWQ/Cj4gCj4gSm9lOiBIZWFkZXIgZmlsZSBuZWVkIHRvIGRvIElQIHJldmlldy4K
ClNvcnJ5LCBJIGRvIG5vdCB1bmRlcnN0YW5kIHRoZSBhbnN3ZXIuIEJ1dCBsZWF2ZSBpdCBhIHNl
cGFyYXRlIGNvbW1pdCB0byAKYWRoZXJlIHRvIHlvdXIgaW50ZXJuYWwgcHJvY2Vzc2VzIOKAkyBp
dOKAmXMgbm90IHRoYXQgaW1wb3J0YW50LgoKPj4gQEAgLTAsMCArMSwxNTQgQEAKPj4gKy8qCj4+
ICsgKiBDb3B5cmlnaHQgMjAxOSBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuCj4+ICsgKgo+
PiArICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFu
eSBwZXJzb24KPj4gK29idGFpbmluZyBhCj4+ICsgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5k
IGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlCj4+ICsiU29mdHdhcmUiKSwKPj4g
KyAqIHRvIGRlYWwgaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGlu
ZyB3aXRob3V0Cj4+ICtsaW1pdGF0aW9uCj4+ICsgKiB0aGUgcmlnaHRzIHRvIHVzZSwgY29weSwg
bW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwKPj4gK3N1YmxpY2Vuc2UsCj4+ICsg
KiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNv
bnMgdG8gd2hvbQo+PiArdGhlCj4+ICsgKiBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8gZG8gc28s
IHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgo+PiArICoKPj4gKyAqIFRoZSBh
Ym92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxsIGJl
Cj4+ICtpbmNsdWRlZCBpbgo+PiArICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9u
cyBvZiB0aGUgU29mdHdhcmUuCj4+ICsgKgo+PiArICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVE
ICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsCj4+ICtFWFBSRVNTIE9SCj4+
ICsgKiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVT
IE9GCj4+ICtNRVJDSEFOVEFCSUxJVFksCj4+ICsgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIg
UFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiAgSU4gTk8gRVZFTlQKPj4gK1NIQUxMCj4+ICsg
KiBUSEUgQ09QWVJJR0hUIEhPTERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElBQkxFIEZPUiBBTlkg
Q0xBSU0sCj4+ICtEQU1BR0VTIE9SCj4+ICsgKiBPVEhFUiBMSUFCSUxJVFksIFdIRVRIRVIgSU4g
QU4gQUNUSU9OIE9GIENPTlRSQUNULCBUT1JUIE9SCj4+ICtPVEhFUldJU0UsCj4+ICsgKiBBUklT
SU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRI
RSBVU0UKPj4gK09SCj4+ICsgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCj4+ICsg
Kgo+PiArICovCj4gCj4gV2h5IG5vdCB1c2UgU1BEWCBoZWFkZXJzPwo+IAo+IEpvZTogc29ycnks
IEkgZG9uJ3Qga25vdy4KClBsZWFzZSBmaW5kIG91dD8gOy0pCgpb4oCmXQoKCktpbmQgcmVnYXJk
cywKClBhdWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
