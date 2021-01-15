Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD5C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FEC2388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FEC2388B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34BD6E47E;
	Fri, 15 Jan 2021 15:08:47 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8536E241
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 10:07:40 +0000 (UTC)
Received: from [192.168.1.41] ([92.131.99.25]) by mwinf5d49 with ME
 id Gy7a2400L0Ys01Y03y7agg; Fri, 15 Jan 2021 11:07:37 +0100
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Jan 2021 11:07:37 +0100
X-ME-IP: 92.131.99.25
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
To: Colin Ian King <colin.king@canonical.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20210111114638.16530-1-colin.king@canonical.com>
 <20210112100706.GF5083@kadam>
 <51efd2a7-f2cf-dc28-4b86-5e89d13564ca@canonical.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f57062ac-499d-95bb-cf4f-bb7b5b1dea5b@wanadoo.fr>
Date: Fri, 15 Jan 2021 11:07:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <51efd2a7-f2cf-dc28-4b86-5e89d13564ca@canonical.com>
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

TGUgMTUvMDEvMjAyMSDDoCAxMDozNywgQ29saW4gSWFuIEtpbmcgYSDDqWNyaXTCoDoKPiBPbiAx
Mi8wMS8yMDIxIDEwOjA3LCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+PiBPbiBNb24sIEphbiAxMSwg
MjAyMSBhdCAxMTo0NjozOEFNICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOgo+Pj4gRnJvbTogQ29s
aW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KPj4+Cj4+PiBBIHJlY2VudCBj
aGFuZ2UgYWRkZWQgYSBuZXcgQk9PVFVQX0RFRkFVTFQgcG93ZXIgcHJvZmlsZSBtb2RlCj4+PiB0
byB0aGUgUFBfU01DX1BPV0VSX1BST0ZJTEUgZW51bSBidXQgb21pdHRlZCB1cGRhdGluZyB0aGUK
Pj4+IGNvcnJlc3BvbmRpbmcgcHJvZmlsZV9uYW1lIGFycmF5LiAgRml4IHRoaXMgYnkgYWRkaW5n
IGluIHRoZQo+Pj4gbWlzc2luZyBCT09UVVBfREVGQVVMVCB0byBwcm9maWxlX25hbWVbXS4KPj4+
Cj4+Cj4+IFN0aWxsIG5vdCBlbm91Z2ggdG8gcHJldmVudCB0aGUgYXJyYXkgb3ZlcmZsb3cuICBJ
dCBuZWVkcyBQT1dFUlNBVkUgYXMKPj4gd2VsbC4KPiAKPiBUaGFua3MgZm9yIGNoZWNraW5nLCBi
dXQgdGhlcmUgaXMgYSAxLXRvLTEgcmVsYXRpb24gc2hpcCBub3c6Cj4gCj4gZW51bSBQUF9TTUNf
UE9XRVJfUFJPRklMRSB7Cj4gICAgICAgICAgUFBfU01DX1BPV0VSX1BST0ZJTEVfQk9PVFVQX0RF
RkFVTFQgPSAweDAsCj4gICAgICAgICAgUFBfU01DX1BPV0VSX1BST0ZJTEVfRlVMTFNDUkVFTjNE
ID0gMHgxLAo+ICAgICAgICAgIFBQX1NNQ19QT1dFUl9QUk9GSUxFX1BPV0VSU0FWSU5HICA9IDB4
MiwKPiAgICAgICAgICBQUF9TTUNfUE9XRVJfUFJPRklMRV9WSURFTyAgICAgICAgPSAweDMsCj4g
ICAgICAgICAgUFBfU01DX1BPV0VSX1BST0ZJTEVfVlIgICAgICAgICAgID0gMHg0LAo+ICAgICAg
ICAgIFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUgICAgICA9IDB4NSwKPiAgICAgICAgICBQ
UF9TTUNfUE9XRVJfUFJPRklMRV9DVVNUT00gICAgICAgPSAweDYsCj4gICAgICAgICAgUFBfU01D
X1BPV0VSX1BST0ZJTEVfQ09VTlQsCj4gfTsKPiAKPiB2cwo+IAo+ICAgICAgICAgIHN0YXRpYyBj
b25zdCBjaGFyICpwcm9maWxlX25hbWVbXSA9IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJCT09UVVBfREVGQVVMVCIsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiM0RfRlVMTF9TQ1JFRU4iLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIlBPV0VSX1NBVklORyIsCgpUaGlzIGxpbmUgaGFzIGJl
ZW4gYWRkZWQgeWVzdGVyZGF5IGluIGNvbW1pdCBmNzI3ZWJlYjU4OWQuClNvIERhbiB3YXMgcmln
aHQgd2hlbiBoZSBzZW50IGhpcyBwYXRjaCwgYnV0IHNvbWUgZWxzZSBmaXhlZCBpdC4KCkNKCgo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlZJREVPIiwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJWUiIsCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQ09NUFVURSIsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAiQ1VTVE9NIn07Cj4gCj4gCj4gdW5sZXNzIEknbSBt
aXNzaW5nIHNvbWV0aGluZyBiZWNhdXNlIEkndmUgbm90IGhhZCBlbm91Z2ggY29mZmVlLgo+IAo+
IENvbGluCj4gCj4+Cj4+IHJlZ2FyZHMsCj4+IGRhbiBjYXJwZW50ZXIKPj4KPiAKPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
