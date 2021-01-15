Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B936C43381
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409DB2388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409DB2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC8D6E46B;
	Fri, 15 Jan 2021 15:08:47 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0DA89893;
 Fri, 15 Jan 2021 10:10:16 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1l0M3b-0001kr-77; Fri, 15 Jan 2021 10:10:15 +0000
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20210111114638.16530-1-colin.king@canonical.com>
 <20210112100706.GF5083@kadam>
 <51efd2a7-f2cf-dc28-4b86-5e89d13564ca@canonical.com>
 <f57062ac-499d-95bb-cf4f-bb7b5b1dea5b@wanadoo.fr>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <01121c1c-5e7c-9d47-2400-c7644f6b8254@canonical.com>
Date: Fri, 15 Jan 2021 10:10:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f57062ac-499d-95bb-cf4f-bb7b5b1dea5b@wanadoo.fr>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMTUvMDEvMjAyMSAxMDowNywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOgo+IExlIDE1LzAx
LzIwMjEgw6AgMTA6MzcsIENvbGluIElhbiBLaW5nIGEgw6ljcml0wqA6Cj4+IE9uIDEyLzAxLzIw
MjEgMTA6MDcsIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4+PiBPbiBNb24sIEphbiAxMSwgMjAyMSBh
dCAxMTo0NjozOEFNICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOgo+Pj4+IEZyb206IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4+Pj4KPj4+PiBBIHJlY2VudCBjaGFu
Z2UgYWRkZWQgYSBuZXcgQk9PVFVQX0RFRkFVTFQgcG93ZXIgcHJvZmlsZSBtb2RlCj4+Pj4gdG8g
dGhlIFBQX1NNQ19QT1dFUl9QUk9GSUxFIGVudW0gYnV0IG9taXR0ZWQgdXBkYXRpbmcgdGhlCj4+
Pj4gY29ycmVzcG9uZGluZyBwcm9maWxlX25hbWUgYXJyYXkuwqAgRml4IHRoaXMgYnkgYWRkaW5n
IGluIHRoZQo+Pj4+IG1pc3NpbmcgQk9PVFVQX0RFRkFVTFQgdG8gcHJvZmlsZV9uYW1lW10uCj4+
Pj4KPj4+Cj4+PiBTdGlsbCBub3QgZW5vdWdoIHRvIHByZXZlbnQgdGhlIGFycmF5IG92ZXJmbG93
LsKgIEl0IG5lZWRzIFBPV0VSU0FWRSBhcwo+Pj4gd2VsbC4KPj4KPj4gVGhhbmtzIGZvciBjaGVj
a2luZywgYnV0IHRoZXJlIGlzIGEgMS10by0xIHJlbGF0aW9uIHNoaXAgbm93Ogo+Pgo+PiBlbnVt
IFBQX1NNQ19QT1dFUl9QUk9GSUxFIHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBQUF9TTUNfUE9XRVJf
UFJPRklMRV9CT09UVVBfREVGQVVMVCA9IDB4MCwKPj4gwqDCoMKgwqDCoMKgwqDCoCBQUF9TTUNf
UE9XRVJfUFJPRklMRV9GVUxMU0NSRUVOM0QgPSAweDEsCj4+IMKgwqDCoMKgwqDCoMKgwqAgUFBf
U01DX1BPV0VSX1BST0ZJTEVfUE9XRVJTQVZJTkfCoCA9IDB4MiwKPj4gwqDCoMKgwqDCoMKgwqDC
oCBQUF9TTUNfUE9XRVJfUFJPRklMRV9WSURFT8KgwqDCoMKgwqDCoMKgID0gMHgzLAo+PiDCoMKg
wqDCoMKgwqDCoMKgIFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZSwqDCoMKgwqDCoMKgwqDCoMKgwqAg
PSAweDQsCj4+IMKgwqDCoMKgwqDCoMKgwqAgUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09NUFVURcKg
wqDCoMKgwqAgPSAweDUsCj4+IMKgwqDCoMKgwqDCoMKgwqAgUFBfU01DX1BPV0VSX1BST0ZJTEVf
Q1VTVE9NwqDCoMKgwqDCoMKgID0gMHg2LAo+PiDCoMKgwqDCoMKgwqDCoMKgIFBQX1NNQ19QT1dF
Ul9QUk9GSUxFX0NPVU5ULAo+PiB9Owo+Pgo+PiB2cwo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgIHN0
YXRpYyBjb25zdCBjaGFyICpwcm9maWxlX25hbWVbXSA9IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIkJPT1RVUF9ERUZBVUxUIiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIjNEX0ZV
TExfU0NSRUVOIiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlBPV0VSX1NBVklORyIsCj4g
Cj4gVGhpcyBsaW5lIGhhcyBiZWVuIGFkZGVkIHllc3RlcmRheSBpbiBjb21taXQgZjcyN2ViZWI1
ODlkLgo+IFNvIERhbiB3YXMgcmlnaHQgd2hlbiBoZSBzZW50IGhpcyBwYXRjaCwgYnV0IHNvbWUg
ZWxzZSBmaXhlZCBpdC4KCkFoLCBteSBiYWQgZm9yIG5vdCBzZWVpbmcgdGhhdC4gOi0vCgo+IAo+
IENKCj4gCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJWSURFTyIsCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJWUiIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJDT01QVVRFIiwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkNVU1RPTSJ9Owo+Pgo+Pgo+PiB1bmxlc3MgSSdt
IG1pc3Npbmcgc29tZXRoaW5nIGJlY2F1c2UgSSd2ZSBub3QgaGFkIGVub3VnaCBjb2ZmZWUuCj4+
Cj4+IENvbGluCj4+Cj4+Pgo+Pj4gcmVnYXJkcywKPj4+IGRhbiBjYXJwZW50ZXIKPj4+Cj4+Cj4+
Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
