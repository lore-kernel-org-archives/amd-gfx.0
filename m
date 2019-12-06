Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AFDC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 16:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5162F206DF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5162F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043A96FA55;
	Fri,  6 Dec 2019 16:12:47 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 22F626FA55
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 16:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id E24D02A6046;
 Fri,  6 Dec 2019 17:12:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id h5zNH0tvGLNZ; Fri,  6 Dec 2019 17:12:43 +0100 (CET)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.245.116])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 621CA2A6045;
 Fri,  6 Dec 2019 17:12:43 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1idGDi-001hBe-It; Fri, 06 Dec 2019 17:12:42 +0100
Subject: Re: amdgpu: Enable full DCN support on POWER
To: Timothy Pearson <tpearson@raptorengineering.com>,
 Harry Wentland <hwentlan@amd.com>
References: <756058159.3882541.1575581964361.JavaMail.zimbra@raptorengineeringinc.com>
 <582048180.3885508.1575583105358.JavaMail.zimbra@raptorengineeringinc.com>
 <DM6PR12MB3466D303A5F55B13F084A6459E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <13591609-36b0-00f8-7c41-c32dcbda9f9d@amd.com>
 <796794305.3897032.1575588884804.JavaMail.zimbra@raptorengineeringinc.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <4087606e-848b-6292-2036-d3a98a1f865c@daenzer.net>
Date: Fri, 6 Dec 2019 17:12:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <796794305.3897032.1575588884804.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-CA
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Liu, Zhan" <Zhan.Liu@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0wNiAxMjozNCBhLm0uLCBUaW1vdGh5IFBlYXJzb24gd3JvdGU6Cj4+IEZyb206
ICJIYXJyeSBXZW50bGFuZCIgPGh3ZW50bGFuQGFtZC5jb20+IE9uIDIwMTktMTItMDUgNjowMiBw
Lm0uLAo+PiBMaXUsIFpoYW4gd3JvdGU6Cj4+Pj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmCj4+Pj4gT2YgVGltb3RoeSBQZWFy
c29uCj4+Pj4gCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9NYWtlZmlsZSAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9NYWtlZmls
ZSBpbmRleAo+Pj4+IGExNjA1MTJhMmYwNC4uM2UwMjZhOTY5Mzg2IDEwMDY0NCAtLS0KPj4+PiBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9NYWtlZmlsZSArKysKPj4+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9NYWtlZmlsZSBAQCAtMSw1ICsxLDYgQEAgIyAjCj4+
Pj4gQ29weXJpZ2h0IDIwMTcgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiArIyBDb3B5cmln
aHQgMjAxOQo+Pj4+IFJhcHRvciBFbmdpbmVlcmluZywgTExDCj4+PiAKPj4+IE5BSy4KPj4+IAo+
Pj4gSUFOQUwsIGJ1dCBJIGRvbid0IHRoaW5rIHlvdSBjYW4gYWRkIHlvdXIgY29tcGFueSdzIG5h
bWUgYnkKPj4+IG1vZGlmeWluZyBwYXJ0IG9mIHRoZSBjb2RlLiBUaGUgY29weXJpZ2h0IG5vdGlj
ZSBzaG93cyB0aGUKPj4+IGF1dGhvcnMgb2YgdGhlIG9yaWdpbmFsIHdvcmsuCj4+PiAKPj4+IFdo
ZW4gbW9kaWZ5aW5nIHRoZSBjb2RlLCB5b3UgYXJlIHJlcXVpcmVkIHRvIGFncmVlIHdpdGggdGhh
dAo+Pj4gY29weXJpZ2h0IG5vdGljZS4gVGhhdCdzIHRoZSBwdXJwb3NlIG9mIHRoYXQgY29weXJp
Z2h0IG5vdGljZQo+Pj4gcGllY2UuCgpXaGVyZSBkaWQgeW91IGdldCB0aGF0IGZyb20/IEFkZGlu
ZyBhIGNvcHlyaWdodCBsaW5lIGxpa2UgdGhpcyB0byBmaWxlcwpjb250YWluaW5nIGNvZGUgdG8g
d2hpY2ggb25lIGhvbGRzIHRoZSBjb3B5cmlnaHQgaXMgc3RhbmRhcmQgcHJhY3RpY2UuCgoKPj4g
SSBhbHdheXMgdGhvdWdodCB0aGVzZSBjb3B5cmlnaHQgbm90aWNlcyBhcmUgbmVhcmx5IG1lYW5p
bmdsZXNzLgo+PiAKPj4gVGhhdCBzYWlkLCB0aGlzIHBhdGNoIGRvZXNuJ3QgaGF2ZSBhbnkgY2hh
bmdlIGluIHRoaXMgZmlsZS4gSQo+PiBkb24ndCB0aGluayBpdCB3YXJyYW50cyBhbiBhZGRpdGlv
bmFsIGNvcHlyaWdodCBub3RpY2UuCj4+IAo+PiBIYXJyeQo+IAo+IEFncmVlZCAtLSBsb29rcyBs
aWtlIHRoYXQgc251Y2sgaW4gd2l0aCB0aGUgb3RoZXIgY2hhbmdlcy4gIEkgY2FuCj4gYmFjayB0
aGlzIG9uZSBvdXQsIGhvd2V2ZXIgaW4gZ2VuZXJhbCByZWdhcmRsZXNzIG9mIHRoZSBub3RpY2Ug
aGF2aW5nCj4gYW55IGFjdHVhbCBsZWdhbCBtZWFuaW5nICh0aGUgR0lUIGNvbW1pdCBoaXN0b3J5
IGhhcyB0aGUgYWN0dWFsIGxlZ2FsCj4gdGVldGggZnJvbSB3aGF0IEkgdW5kZXJzdGFuZCBhcyBp
dCBlc3RhYmxpc2hlcyBzaGFyZWQgb3duZXJzaGlwKSwgb3VyCj4gZ2VuZXJhbCBwb2xpY3kgcGVy
IHJlY29tbWVuZGF0aW9ucyBpcyB0byBhZGQgdGhlIGNvcHlyaWdodCBsaW5lLiAgSXQKPiBoZWxw
cyBhbnlvbmUgbG9va2luZyBhdCB0aGUgZmlsZSBrbm93IGF0IGEgZ2xhbmNlIHRoYXQgdGhlcmUg
aXMgbW9yZQo+IHRoYW4gb25lIGNvcnBvcmF0ZSBhdXRob3IsIGFuZCB0aGVyZWZvcmUgZS5nLiB0
aGUgb25seSB0ZXJtcyBpdCBjYW4KPiBiZSB1c2VkIG9uIHdpdGhvdXQgYSBjb21wbGV4IG11bHRp
LXBhcnR5IGxpY2Vuc2UgcmVuZWdvdGlhdGlvbiBpcyAoaW4KPiB0aGlzIGNhc2UpIHRoZSBHUEwg
djIuCgpEaWQgeW91IHJlYWQgdGhlIGxpY2VuY2UgdW5kZXIgdGhlIGNvcHlyaWdodCBsaW5lIHlv
dSBhZGRlZD8gOikKCk9yIGFyZSB5b3Ugc2F5aW5nIHRoYXQgeW91ciBwYXRjaCBpcyBpbnRlbmRl
ZCB0byBiZSBhdmFpbGFibGUgdW5kZXIgdGhlCkdQTCBvbmx5PyBJJ20gYWZyYWlkIHRoYXQgd291
bGQgYmUgYSBwcm9ibGVtLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
