Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1499ACA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C7920874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C7920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A875B6E9DB;
	Wed, 30 Oct 2019 13:08:58 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.36 at gabe;
 Wed, 30 Oct 2019 10:41:19 UTC
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16DE6E934
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 10:41:19 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4734bL4bqkz9sPJ;
 Wed, 30 Oct 2019 21:35:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>, alexander.deucher@amd.com
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
In-Reply-To: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2019 21:35:10 +1100
Message-ID: <87o8xyfrmp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 30 Oct 2019 13:08:58 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=ellerman.id.au; s=201909; t=1572431711;
 bh=WmtX+xAbYWaAbWorI0MYAttJQLuDF1ZuIP0rN4t19I0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QqJNQWV+M+xtPfWh3QSjZ/IXALxkPJ6eN4NSrLxoYUPzowgXqqVyyJni/2RY7uCXA
 oaHsjkf2fE8GEgwFaxTExQBji18BbVLN9yChBAJXmudBZ0+dN586yNhcPR2/eFqm6/
 iT6C9vZyNC+3M1FqrcoGv/5NvTvlr4vlr1KpTKpKxc5Sa3JM7Z0zKzQVJc80XT2z5B
 Dm00Ujq7n4lvh3uXdPpCYMOsZ6scz9pGOPLxu1eD0Ekt9PlIGRagXnx1YsTyqDWkVI
 UwDA9mdEIrIRVrY5f9rfIu8a3mQfLZTZ5r0RL1rPw6E+72ENOknYR7SSC8YmETnD+s
 HYFzp1vND1mNg==
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
Cc: linuxppc-dev@lists.ozlabs.org, Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030103510.eUKmYmj_mjHpXsLMfVhfh3KoJHiKkVc8-riXAMHzM1Q@z>

SGkgS3lsZSwKCkt5bGVNYWhsa3VjaCA8a21haGxrdWNAbGludXgudm5ldC5pYm0uY29tPiB3cml0
ZXM6Cj4gRnJvbTogS3lsZSBNYWhsa3VjaCA8a21haGxrdWNAbGludXgudm5ldC5pYm0uY29tPgo+
Cj4gRHVyaW5nIGtleGVjIHNvbWUgYWRhcHRlcnMgaGl0IGFuIEVFSCBzaW5jZSB0aGV5IGFyZSBu
b3QgcHJvcGVybHkKPiBzaHV0IGRvd24gaW4gdGhlIHJhZGVvbl9wY2lfc2h1dGRvd24oKSBmdW5j
dGlvbi4gQWRkaW5nCj4gcmFkZW9uX3N1c3BlbmRfa21zKCkgZml4ZXMgdGhpcyBpc3N1ZS4KPiBF
bmFibGVkIG9ubHkgb24gUFBDIGJlY2F1c2UgdGhpcyBwYXRjaCBjYXVzZXMgaXNzdWVzIG9uIHNv
bWUgb3RoZXIKPiBib2FyZHMuCgpXaGljaCBhZGFwdGVycyBoaXQgdGhlIGlzc3Vlcz8KCkFuZCBk
byB3ZSBrbm93IHdoeSB0aGV5J3JlIG5vdCBzaHV0IGRvd24gY29ycmVjdGx5IGluCnJhZGVvbl9w
Y2lfc2h1dGRvd24oKT8gVGhhdCBzZWVtcyBsaWtlIHRoZSByb290IGNhdXNlIG5vPwoKCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBpbmRleCA5ZTU1MDc2Li40NTI4ZjRkIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiBAQCAtMzc5LDExICszNzksMjUgQEAg
c3RhdGljIGludCByYWRlb25fcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAo+ICBzdGF0
aWMgdm9pZAo+ICByYWRlb25fcGNpX3NodXRkb3duKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICB7
Cj4gKyNpZmRlZiBDT05GSUdfUFBDNjQKPiArCXN0cnVjdCBkcm1fZGV2aWNlICpkZGV2ID0gcGNp
X2dldF9kcnZkYXRhKHBkZXYpOwo+ICsjZW5kaWYKClRoaXMgbG9jYWwgc2VydmVzIG5vIHJlYWwg
cHVycG9zZSBhbmQgY291bGQgYmUgYXZvaWRlZCwgd2hpY2ggd291bGQgYWxzbwphdm9pZCB0aGlz
IGlmZGVmLgoKPiAgCS8qIGlmIHdlIGFyZSBydW5uaW5nIGluIGEgVk0sIG1ha2Ugc3VyZSB0aGUg
ZGV2aWNlCj4gIAkgKiB0b3JuIGRvd24gcHJvcGVybHkgb24gcmVib290L3NodXRkb3duCj4gIAkg
Ki8KPiAgCWlmIChyYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWwoKSkKPiAgCQlyYWRlb25fcGNpX3Jl
bW92ZShwZGV2KTsKPiArCj4gKyNpZmRlZiBDT05GSUdfUFBDNjQKPiArCS8qIFNvbWUgYWRhcHRl
cnMgbmVlZCB0byBiZSBzdXNwZW5kZWQgYmVmb3JlIGEKCkFGQUlLIGRybSB1c2VzIG5vcm1hbCBr
ZXJuZWwgY29tbWVudCBzdHlsZSwgc28gdGhpcyBzaG91bGQgYmU6CgoJLyoKCSAqIFNvbWUgYWRh
cHRlcnMgbmVlZCB0byBiZSBzdXNwZW5kZWQgYmVmb3JlIGEKPiArCSAqIHNodXRkb3duIG9jY3Vy
cyBpbiBvcmRlciB0byBwcmV2ZW50IGFuIGVycm9yCj4gKwkgKiBkdXJpbmcga2V4ZWMuCj4gKwkg
KiBNYWtlIHRoaXMgcG93ZXIgc3BlY2lmaWMgYmVjYXVhc2UgaXQgYnJlYWtzCj4gKwkgKiBzb21l
IG5vbi1wb3dlciBib2FyZHMuCj4gKwkgKi8KPiArCXJhZGVvbl9zdXNwZW5kX2ttcyhkZGV2LCB0
cnVlLCB0cnVlLCBmYWxzZSk7CgppZSwgaW5zdGVhZCBkbzoKCglyYWRlb25fc3VzcGVuZF9rbXMo
cGNpX2dldF9kcnZkYXRhKHBkZXYpLCB0cnVlLCB0cnVlLCBmYWxzZSk7Cgo+ICsjZW5kaWYKPiAg
fQo+ICAKPiAgc3RhdGljIGludCByYWRlb25fcG1vcHNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4gLS0gCj4gMS44LjMuMQoKY2hlZXJzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
