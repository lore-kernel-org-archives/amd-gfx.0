Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3DEC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221022388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221022388B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF076E461;
	Fri, 15 Jan 2021 15:08:47 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3006D6E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 10:16:51 +0000 (UTC)
Received: from [192.168.1.41] ([92.131.99.25]) by mwinf5d49 with ME
 id GyGn240180Ys01Y03yGoD2; Fri, 15 Jan 2021 11:16:49 +0100
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Jan 2021 11:16:49 +0100
X-ME-IP: 92.131.99.25
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
To: Colin Ian King <colin.king@canonical.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20210111114638.16530-1-colin.king@canonical.com>
 <20210112100706.GF5083@kadam>
 <51efd2a7-f2cf-dc28-4b86-5e89d13564ca@canonical.com>
 <f57062ac-499d-95bb-cf4f-bb7b5b1dea5b@wanadoo.fr>
 <01121c1c-5e7c-9d47-2400-c7644f6b8254@canonical.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <2e688654-cbac-ea86-b248-c863a2dc6747@wanadoo.fr>
Date: Fri, 15 Jan 2021 11:16:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <01121c1c-5e7c-9d47-2400-c7644f6b8254@canonical.com>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 15 Jan 2021 15:08:45 +0000
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TGUgMTUvMDEvMjAyMSDDoCAxMToxMCwgQ29saW4gSWFuIEtpbmcgYSDDqWNyaXTCoDoKPiBPbiAx
NS8wMS8yMDIxIDEwOjA3LCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6Cj4+IExlIDE1LzAxLzIw
MjEgw6AgMTA6MzcsIENvbGluIElhbiBLaW5nIGEgw6ljcml0wqA6Cj4+PiBPbiAxMi8wMS8yMDIx
IDEwOjA3LCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+Pj4+IE9uIE1vbiwgSmFuIDExLCAyMDIxIGF0
IDExOjQ2OjM4QU0gKzAwMDAsIENvbGluIEtpbmcgd3JvdGU6Cj4+Pj4+IEZyb206IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4+Pj4+Cj4+Pj4+IEEgcmVjZW50IGNo
YW5nZSBhZGRlZCBhIG5ldyBCT09UVVBfREVGQVVMVCBwb3dlciBwcm9maWxlIG1vZGUKPj4+Pj4g
dG8gdGhlIFBQX1NNQ19QT1dFUl9QUk9GSUxFIGVudW0gYnV0IG9taXR0ZWQgdXBkYXRpbmcgdGhl
Cj4+Pj4+IGNvcnJlc3BvbmRpbmcgcHJvZmlsZV9uYW1lIGFycmF5LsKgIEZpeCB0aGlzIGJ5IGFk
ZGluZyBpbiB0aGUKPj4+Pj4gbWlzc2luZyBCT09UVVBfREVGQVVMVCB0byBwcm9maWxlX25hbWVb
XS4KPj4+Pj4KPj4+Pgo+Pj4+IFN0aWxsIG5vdCBlbm91Z2ggdG8gcHJldmVudCB0aGUgYXJyYXkg
b3ZlcmZsb3cuwqAgSXQgbmVlZHMgUE9XRVJTQVZFIGFzCj4+Pj4gd2VsbC4KPj4+Cj4+PiBUaGFu
a3MgZm9yIGNoZWNraW5nLCBidXQgdGhlcmUgaXMgYSAxLXRvLTEgcmVsYXRpb24gc2hpcCBub3c6
Cj4+Pgo+Pj4gZW51bSBQUF9TTUNfUE9XRVJfUFJPRklMRSB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDC
oCBQUF9TTUNfUE9XRVJfUFJPRklMRV9CT09UVVBfREVGQVVMVCA9IDB4MCwKPj4+ICDCoMKgwqDC
oMKgwqDCoMKgIFBQX1NNQ19QT1dFUl9QUk9GSUxFX0ZVTExTQ1JFRU4zRCA9IDB4MSwKPj4+ICDC
oMKgwqDCoMKgwqDCoMKgIFBQX1NNQ19QT1dFUl9QUk9GSUxFX1BPV0VSU0FWSU5HwqAgPSAweDIs
Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoCBQUF9TTUNfUE9XRVJfUFJPRklMRV9WSURFT8KgwqDCoMKg
wqDCoMKgID0gMHgzLAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgUFBfU01DX1BPV0VSX1BST0ZJTEVf
VlLCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IDB4NCwKPj4+ICDCoMKgwqDCoMKgwqDCoMKgIFBQX1NN
Q19QT1dFUl9QUk9GSUxFX0NPTVBVVEXCoMKgwqDCoMKgID0gMHg1LAo+Pj4gIMKgwqDCoMKgwqDC
oMKgwqAgUFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NwqDCoMKgwqDCoMKgID0gMHg2LAo+Pj4g
IMKgwqDCoMKgwqDCoMKgwqAgUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09VTlQsCj4+PiB9Owo+Pj4K
Pj4+IHZzCj4+Pgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgc3RhdGljIGNvbnN0IGNoYXIgKnByb2Zp
bGVfbmFtZVtdID0gewo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJCT09UVVBfREVGQVVM
VCIsCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIjNEX0ZVTExfU0NSRUVOIiwKPj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUE9XRVJfU0FWSU5HIiwKPj4KPj4gVGhpcyBsaW5lIGhh
cyBiZWVuIGFkZGVkIHllc3RlcmRheSBpbiBjb21taXQgZjcyN2ViZWI1ODlkLgo+PiBTbyBEYW4g
d2FzIHJpZ2h0IHdoZW4gaGUgc2VudCBoaXMgcGF0Y2gsIGJ1dCBzb21lIGVsc2UgZml4ZWQgaXQu
Cj4gCj4gQWgsIG15IGJhZCBmb3Igbm90IHNlZWluZyB0aGF0LiA6LS8KCkhvd2V2ZXIsIEkgd29u
ZGVyIGlmIHRoaXMgY29tbWl0IGlzIGNvbXBsZXRlLgpUaGUgZGVzY3JpcHRpb24gb2YgdGhlIGNv
bW1pdCBpcyBhYm91dCA1IG1vZGVzLCBidXQgNiBhcmUgbGlzdGVkIGluIApQUF9TTUNfUE9XRVJf
UFJPRklMRS4KCkluIHRoZSBodW5rOgorc3RhdGljIHN0cnVjdCBjbW4yYXNpY19tYXBwaW5nIAp2
YW5nb2doX3dvcmtsb2FkX21hcFtQUF9TTUNfUE9XRVJfUFJPRklMRV9DT1VOVF0gPSB7CisJV09S
S0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0ZVTExTQ1JFRU4zRCwJIApXT1JLTE9BRF9Q
UExJQl9GVUxMX1NDUkVFTl8zRF9CSVQpLAorCVdPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJP
RklMRV9WSURFTywJCVdPUktMT0FEX1BQTElCX1ZJREVPX0JJVCksCisJV09SS0xPQURfTUFQKFBQ
X1NNQ19QT1dFUl9QUk9GSUxFX1ZSLAkJCVdPUktMT0FEX1BQTElCX1ZSX0JJVCksCisJV09SS0xP
QURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUsCQlXT1JLTE9BRF9QUExJQl9DT01Q
VVRFX0JJVCksCisJV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NVU1RPTSwJCVdP
UktMT0FEX1BQTElCX0NVU1RPTV9CSVQpLAorfTsKCkl0IHdvdWxkIGxvb2sgbG9naWNhbCB0byBo
YXZlIHNvbWV0aGluZyBsaWtlOgorCVdPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9Q
T1dFUlNBVklORywJIApXT1JLTE9BRF9QUExJQl9QT1dFUl9TQVZJTkdfQklUKSwKCk5vdCBzdXJl
IGF0IGFsbCBpZiBjb3JyZWN0LgoKSnVzdCBteSAyYywKCkNKCgo+IAo+Pgo+PiBDSgo+Pgo+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJWSURFTyIsCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIlZSIiwKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiQ09NUFVURSIsCj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkNVU1RPTSJ9Owo+Pj4KPj4+Cj4+PiB1bmxlc3MgSSdt
IG1pc3Npbmcgc29tZXRoaW5nIGJlY2F1c2UgSSd2ZSBub3QgaGFkIGVub3VnaCBjb2ZmZWUuCj4+
Pgo+Pj4gQ29saW4KPj4+Cj4+Pj4KPj4+PiByZWdhcmRzLAo+Pj4+IGRhbiBjYXJwZW50ZXIKPj4+
Pgo+Pj4KPj4+Cj4+Cj4gCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
