Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C26C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 20:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6404121835
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 20:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6404121835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raptorengineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B456FA91;
	Fri,  6 Dec 2019 20:29:12 +0000 (UTC)
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341026FA8F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 20:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 95E8EEBFA3F11;
 Fri,  6 Dec 2019 14:29:09 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id MNbQw2SFlyO1; Fri,  6 Dec 2019 14:29:08 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 4D788EBFA3C66;
 Fri,  6 Dec 2019 14:29:08 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4D788EBFA3C66
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cYkSr20NVbVY; Fri,  6 Dec 2019 14:29:08 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 27F41EBFA3C0F;
 Fri,  6 Dec 2019 14:29:08 -0600 (CST)
Date: Fri, 6 Dec 2019 14:29:07 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Message-ID: <166642689.4051759.1575664147344.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <4087606e-848b-6292-2036-d3a98a1f865c@daenzer.net>
References: <756058159.3882541.1575581964361.JavaMail.zimbra@raptorengineeringinc.com>
 <582048180.3885508.1575583105358.JavaMail.zimbra@raptorengineeringinc.com>
 <DM6PR12MB3466D303A5F55B13F084A6459E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <13591609-36b0-00f8-7c41-c32dcbda9f9d@amd.com>
 <796794305.3897032.1575588884804.JavaMail.zimbra@raptorengineeringinc.com>
 <4087606e-848b-6292-2036-d3a98a1f865c@daenzer.net>
Subject: Re: amdgpu: Enable full DCN support on POWER
MIME-Version: 1.0
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: amdgpu: Enable full DCN support on POWER
Thread-Index: d5WLGJTT0yWnhsBrQtxSSUUnKauSCw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1575664148; bh=ZlRX16BXX3wRINed7CQTJd8jV4LxdXD/+uIWOoPdp7M=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=GC3JA94AbxB5AseYcEMHimeLig+m6Ftr32Mew04Z5ZjlwYhkZDJ4TPX5nsh45QsTS
 ciEW8NBgNSNWeDDBKSe3qO9Kf9nMGv5lgCBbrDpeV1zbEuh0q+M8Vab1hkxkmiOD1f
 XqmFvf5q9xIKYyyR6cRMWll5mj1/Gn7aPOJcjOL4=
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Harry Wentland <hwentlan@amd.com>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIk1pY2hlbCBEw6RuemVyIiA8
bWljaGVsQGRhZW56ZXIubmV0Pgo+IFRvOiAiVGltb3RoeSBQZWFyc29uIiA8dHBlYXJzb25AcmFw
dG9yZW5naW5lZXJpbmcuY29tPiwgIkhhcnJ5IFdlbnRsYW5kIiA8aHdlbnRsYW5AYW1kLmNvbT4K
PiBDYzogIlpoYW4gTGl1IiA8Wmhhbi5MaXVAYW1kLmNvbT4sICJhbWQtZ2Z4IiA8YW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+Cj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAyMDE5IDEw
OjEyOjQyIEFNCj4gU3ViamVjdDogUmU6IGFtZGdwdTogRW5hYmxlIGZ1bGwgRENOIHN1cHBvcnQg
b24gUE9XRVIKCj4gT24gMjAxOS0xMi0wNiAxMjozNCBhLm0uLCBUaW1vdGh5IFBlYXJzb24gd3Jv
dGU6Cj4+PiBGcm9tOiAiSGFycnkgV2VudGxhbmQiIDxod2VudGxhbkBhbWQuY29tPiBPbiAyMDE5
LTEyLTA1IDY6MDIgcC5tLiwKPj4+IExpdSwgWmhhbiB3cm90ZToKPj4+Pj4gRnJvbTogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmCj4+Pj4+
IE9mIFRpbW90aHkgUGVhcnNvbgo+Pj4+PiAKPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9NYWtlZmlsZQo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9NYWtlZmlsZSBpbmRleAo+Pj4+PiBhMTYwNTEyYTJmMDQuLjNlMDI2YTk2OTM4
NiAxMDA2NDQgLS0tCj4+Pj4+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL01ha2Vm
aWxlICsrKwo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9NYWtlZmlsZSBA
QCAtMSw1ICsxLDYgQEAgIyAjCj4+Pj4+IENvcHlyaWdodCAyMDE3IEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4gKyMgQ29weXJpZ2h0IDIwMTkKPj4+Pj4gUmFwdG9yIEVuZ2luZWVyaW5nLCBM
TEMKPj4+PiAKPj4+PiBOQUsuCj4+Pj4gCj4+Pj4gSUFOQUwsIGJ1dCBJIGRvbid0IHRoaW5rIHlv
dSBjYW4gYWRkIHlvdXIgY29tcGFueSdzIG5hbWUgYnkKPj4+PiBtb2RpZnlpbmcgcGFydCBvZiB0
aGUgY29kZS4gVGhlIGNvcHlyaWdodCBub3RpY2Ugc2hvd3MgdGhlCj4+Pj4gYXV0aG9ycyBvZiB0
aGUgb3JpZ2luYWwgd29yay4KPj4+PiAKPj4+PiBXaGVuIG1vZGlmeWluZyB0aGUgY29kZSwgeW91
IGFyZSByZXF1aXJlZCB0byBhZ3JlZSB3aXRoIHRoYXQKPj4+PiBjb3B5cmlnaHQgbm90aWNlLiBU
aGF0J3MgdGhlIHB1cnBvc2Ugb2YgdGhhdCBjb3B5cmlnaHQgbm90aWNlCj4+Pj4gcGllY2UuCj4g
Cj4gV2hlcmUgZGlkIHlvdSBnZXQgdGhhdCBmcm9tPyBBZGRpbmcgYSBjb3B5cmlnaHQgbGluZSBs
aWtlIHRoaXMgdG8gZmlsZXMKPiBjb250YWluaW5nIGNvZGUgdG8gd2hpY2ggb25lIGhvbGRzIHRo
ZSBjb3B5cmlnaHQgaXMgc3RhbmRhcmQgcHJhY3RpY2UuCj4gCj4gCj4+PiBJIGFsd2F5cyB0aG91
Z2h0IHRoZXNlIGNvcHlyaWdodCBub3RpY2VzIGFyZSBuZWFybHkgbWVhbmluZ2xlc3MuCj4+PiAK
Pj4+IFRoYXQgc2FpZCwgdGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgYW55IGNoYW5nZSBpbiB0aGlz
IGZpbGUuIEkKPj4+IGRvbid0IHRoaW5rIGl0IHdhcnJhbnRzIGFuIGFkZGl0aW9uYWwgY29weXJp
Z2h0IG5vdGljZS4KPj4+IAo+Pj4gSGFycnkKPj4gCj4+IEFncmVlZCAtLSBsb29rcyBsaWtlIHRo
YXQgc251Y2sgaW4gd2l0aCB0aGUgb3RoZXIgY2hhbmdlcy4gIEkgY2FuCj4+IGJhY2sgdGhpcyBv
bmUgb3V0LCBob3dldmVyIGluIGdlbmVyYWwgcmVnYXJkbGVzcyBvZiB0aGUgbm90aWNlIGhhdmlu
Zwo+PiBhbnkgYWN0dWFsIGxlZ2FsIG1lYW5pbmcgKHRoZSBHSVQgY29tbWl0IGhpc3RvcnkgaGFz
IHRoZSBhY3R1YWwgbGVnYWwKPj4gdGVldGggZnJvbSB3aGF0IEkgdW5kZXJzdGFuZCBhcyBpdCBl
c3RhYmxpc2hlcyBzaGFyZWQgb3duZXJzaGlwKSwgb3VyCj4+IGdlbmVyYWwgcG9saWN5IHBlciBy
ZWNvbW1lbmRhdGlvbnMgaXMgdG8gYWRkIHRoZSBjb3B5cmlnaHQgbGluZS4gIEl0Cj4+IGhlbHBz
IGFueW9uZSBsb29raW5nIGF0IHRoZSBmaWxlIGtub3cgYXQgYSBnbGFuY2UgdGhhdCB0aGVyZSBp
cyBtb3JlCj4+IHRoYW4gb25lIGNvcnBvcmF0ZSBhdXRob3IsIGFuZCB0aGVyZWZvcmUgZS5nLiB0
aGUgb25seSB0ZXJtcyBpdCBjYW4KPj4gYmUgdXNlZCBvbiB3aXRob3V0IGEgY29tcGxleCBtdWx0
aS1wYXJ0eSBsaWNlbnNlIHJlbmVnb3RpYXRpb24gaXMgKGluCj4+IHRoaXMgY2FzZSkgdGhlIEdQ
TCB2Mi4KPiAKPiBEaWQgeW91IHJlYWQgdGhlIGxpY2VuY2UgdW5kZXIgdGhlIGNvcHlyaWdodCBs
aW5lIHlvdSBhZGRlZD8gOikKCk5vcGUsIEkgZGlkbid0LCBhdCBsZWFzdCBub3QgcmlnaHQgYmVm
b3JlIHNlbmRpbmcgdGhhdCByZXBseSAtLSBJIGRpZG4ndCBoYXZlIGEgY29weSBvZiB0aGUgZmls
ZSB1cCBvbiB0aGF0IGRldmljZSAsIGFuZCB3YXMgd2lsZGx5IGd1ZXNzaW5nIGJhc2VkIG9uIHRo
ZSBvdmVyYWxsIGtlcm5lbCBkaXN0cmlidXRpb24gbGljZW5zZS4KCj4gT3IgYXJlIHlvdSBzYXlp
bmcgdGhhdCB5b3VyIHBhdGNoIGlzIGludGVuZGVkIHRvIGJlIGF2YWlsYWJsZSB1bmRlciB0aGUK
PiBHUEwgb25seT8gSSdtIGFmcmFpZCB0aGF0IHdvdWxkIGJlIGEgcHJvYmxlbS4KCk5vLCB0aGVy
ZSdzIG5vIHByb2JsZW0gaGVyZSB3aXRoIHRoZSBleGlzdGluZyBsaWNlbnNlLiAgVXBkYXRlZCB2
ZXJzaW9uIG9mIHRoZSBwYXRjaCB3aXRoIGEgZmV3IHRlY2huaWNhbCBpc3N1ZXMgZml4ZWQgc2hv
dWxkIGJlIGNvbWluZyBsYXRlciB0b2RheSAvIHRvbW9ycm93IChkZXBlbmRpbmcgb24gaG93IHF1
aWNrbHkgSSBjYW4gZ2V0IGFuIEFDSy9OQUNLIG9uIGZ1bmN0aW9uYWxpdHkgZnJvbSB0aGUgcGVy
c29uIHRoYXQgaGFzIGFjY2VzcyB0byB0aGUgTmF2aSBjYXJkKS4KCj4gCj4gLS0KPiBFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9y
ZWRoYXQuY29tCj4gTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
