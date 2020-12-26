Return-Path: <SRS0=wP2z=F6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7370C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Dec 2020 13:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAA62084D
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Dec 2020 13:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAA62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CA489834;
	Sat, 26 Dec 2020 13:16:39 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9620A89834
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Dec 2020 13:16:38 +0000 (UTC)
Received: from [192.168.1.11]
 (dynamic-077-013-170-023.77.13.pool.telefonica.de [77.13.170.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C9C620646219;
 Sat, 26 Dec 2020 14:16:35 +0100 (CET)
Subject: Re: [PATCH] drm/amdgpu: Fix macro name _AMDGPU_TRACE_H_ in
 preprocessor if condition
To: Chenyang Li <lichenyang@loongson.cn>
References: <20201226085607.155289-1-lichenyang@loongson.cn>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <1898b3da-9958-ebd9-dc58-26168ee67653@molgen.mpg.de>
Date: Sat, 26 Dec 2020 14:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201226085607.155289-1-lichenyang@loongson.cn>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Chen Guchun <Guchun.Chen@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVhciDmnY7mmajpmLMsCgoKQW0gMjYuMTIuMjAgdW0gMDk6NTYgc2NocmllYiBDaGVueWFuZyBM
aToKPiBBZGQgYW4gdW5kZXJzY29yZSBpbiBhbWRncHVfdHJhY2UuaCBsaW5lIDI0ICJfQU1ER1BV
X1RSQUNFX0giLgo+IAo+IEZpeGVzOiBkMzhjZWFmOTllZDAgKCJkcm0vYW1kZ3B1OiBhZGQgY29y
ZSBkcml2ZXIgKHY0KSIpCj4gU2lnbmVkLW9mZi1ieTogQ2hlbnlhbmcgTGkgPGxpY2hlbnlhbmdA
bG9vbmdzb24uY24+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHJhY2UuaCB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4g
aW5kZXggZWU5NDgwZDE0Y2JjLi44NmNmYjNkNTU0NzcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+IEBAIC0yMSw3ICsyMSw3IEBACj4gICAgKgo+ICAg
ICovCj4gICAKPiAtI2lmICFkZWZpbmVkKF9BTURHUFVfVFJBQ0VfSCkgfHwgZGVmaW5lZChUUkFD
RV9IRUFERVJfTVVMVElfUkVBRCkKPiArI2lmICFkZWZpbmVkKF9BTURHUFVfVFJBQ0VfSF8pIHx8
IGRlZmluZWQoVFJBQ0VfSEVBREVSX01VTFRJX1JFQUQpCj4gICAjZGVmaW5lIF9BTURHUFVfVFJB
Q0VfSF8KPiAgIAo+ICAgI2luY2x1ZGUgPGxpbnV4L3N0cmluZ2lmeS5oPgoKUmV2aWV3ZWQtYnk6
IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+CgoKS2luZCByZWdhcmRzLAoKUGF1
bAoKClBTOiBOZXh0IHRpbWUsIGZvciBwYXRjaCBpdGVyYXRpb25zLCB5b3Ugc2hvdWxkIGluY2x1
ZGUgdGhlIHZlcnNpb24gaW4gCnRoZSB0YWc6IFBBVENIIHYyLiBUaGUgc3dpdGNoIGAtdmAgKGAt
LXJlcm9sbC1jb3VudGApIGhlbHBzIHdpdGggdGhhdDoKCiAgICAgZ2l0IGZvcm1hdC1wYXRjaCAt
MSAtdiAyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
