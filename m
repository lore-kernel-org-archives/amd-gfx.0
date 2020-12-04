Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 11:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A526722B2E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 11:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A526722B2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0960C6E138;
	Fri,  4 Dec 2020 11:52:17 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id B30D96E138
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 11:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id B33192A6045;
 Fri,  4 Dec 2020 12:52:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id UzhW4r--SiMK; Fri,  4 Dec 2020 12:52:14 +0100 (CET)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 393402A6016;
 Fri,  4 Dec 2020 12:52:14 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1kl9dI-0008m4-Ut; Fri, 04 Dec 2020 12:52:08 +0100
To: Simon Ser <contact@emersion.fr>
References: <j1fYvGbEZdykS0AhDWeyCo79c5aqNmrQBIuTcljx8@cp3-web-016.plabs.ch>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd: print error on convert_tiling_flags_to_modifier
 failure
Message-ID: <71eb00a6-d442-8ff4-394f-554e5f5d020f@daenzer.net>
Date: Fri, 4 Dec 2020 12:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <j1fYvGbEZdykS0AhDWeyCo79c5aqNmrQBIuTcljx8@cp3-web-016.plabs.ch>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMi0wMyA5OjE1IHAubS4sIFNpbW9uIFNlciB3cm90ZToKPiBJZiB0aGlzIGZ1bmN0
aW9uIGZhaWxzLCBpdCBtZWFucyB0aGUgdGlsaW5nIGZsYWdzIGRpZG4ndCBtYWtlIHNlbnNlLgo+
IFRoaXMgbGlrZWx5IGluZGljYXRlcyBhIHVzZXItc3BhY2UgYnVnLiBMb2cgdGhlIGVycm9yIGFs
b25nc2lkZSB3aXRoIHRoZQo+IHByb3ZpZGVkIHRpbGluZyBmbGFncyB0byBtYWtlIGRlYnVnZ2lu
ZyBlYXNpZXIuCj4gCj4gU2lnbmVkLW9mZi1ieTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJzaW9u
LmZyPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6
IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBhbWQuY29tPgo+IENjOiBOaWNob2xhcyBLYXpsYXVz
a2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Cj4gQ2M6IEJhcyBOaWV1d2VuaHVpemVu
IDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgfCA1ICsrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gaW5kZXggMmVmOTczNGViMTE5Li40NjdmZjE2NTUzNDEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXku
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKPiBA
QCAtOTAxLDggKzkwMSwxMSBAQCBpbnQgYW1kZ3B1X2Rpc3BsYXlfZnJhbWVidWZmZXJfaW5pdChz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+ICAgCWlmIChkZXYtPm1vZGVfY29uZmlnLmFsbG93X2Zi
X21vZGlmaWVycyAmJgo+ICAgCSAgICAhKHJmYi0+YmFzZS5mbGFncyAmIERSTV9NT0RFX0ZCX01P
RElGSUVSUykpIHsKPiAgIAkJcmV0ID0gY29udmVydF90aWxpbmdfZmxhZ3NfdG9fbW9kaWZpZXIo
cmZiKTsKPiAtCQlpZiAocmV0KQo+ICsJCWlmIChyZXQpIHsKPiArCQkJZGV2X2VycigmZGV2LT5w
ZGV2LT5kZXYsICJGYWlsZWQgdG8gY29udmVydCB0aWxpbmcgZmxhZ3MgMHglbGxYIHRvIGEgbW9k
aWZpZXIiLAo+ICsJCQkJcmZiLT50aWxpbmdfZmxhZ3MpOwo+ICAgCQkJZ290byBmYWlsOwo+ICsJ
CX0KPiAgIAl9Cj4gICAKPiAgIAlmb3IgKGkgPSAxOyBpIDwgcmZiLT5iYXNlLmZvcm1hdC0+bnVt
X3BsYW5lczsgKytpKSB7Cj4gCgpUaGlzIHNob3VsZCBiZSBlaXRoZXIgYSBkZWJ1Z2dpbmcgbWVz
c2FnZSBkaXNhYmxlZCBieSBkZWZhdWx0LCBvciAKcmF0ZS1saW1pdGVkIHNvbWVob3csIG9yIHVz
ZXItc3BhY2UgY2FuIHNwYW0gZG1lc2cuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29m
dHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2
ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
