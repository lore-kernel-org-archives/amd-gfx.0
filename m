Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C930C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D63D2071E
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raptorengineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB69589F4F;
	Mon, 25 Nov 2019 21:06:45 +0000 (UTC)
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD33F89F4F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 21:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 114E0D9B46D78;
 Mon, 25 Nov 2019 15:06:44 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id wPcfxlPIppV3; Mon, 25 Nov 2019 15:06:43 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 5ED1CD9B46C56;
 Mon, 25 Nov 2019 15:06:43 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 5ED1CD9B46C56
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CDY879B5afZI; Mon, 25 Nov 2019 15:06:43 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
 by mail.rptsys.com (Postfix) with ESMTP id 3B07FD9B46C0E;
 Mon, 25 Nov 2019 15:06:43 -0600 (CST)
Date: Mon, 25 Nov 2019 15:06:42 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Message-ID:
 <535694171.2118031.1574716002431.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <44175d39-e507-83f9-6596-cbde108dd65a@amd.com>
References: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
 <44175d39-e507-83f9-6596-cbde108dd65a@amd.com>
Subject: Re: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
MIME-Version: 1.0
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: amdgpu: Enable KFD on POWER systems
Thread-Index: ezrPmJhmmbGziXLMqcr+Vnso5cSoxQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1574716003; bh=D+uV31AQb6e5I0M8jFqawSbf0FFuNC/urp//CtSoSFg=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=rKHH/rIwdx7cTE+E3obFNWSwaF07T4qbVBcztgHFN3y1Liz7adU/ehg9grWsAQI2B
 sq73cQp2XbtSPbMfzusL80itOCqadmqtmgC35nXxMtDtfsOfGXAQpjUlj94qbPJvD8
 zDWJrNwAMPl96JtpuYJYcphZAuwQcZKUmXB+6T80=
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
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125210642.fwFYY8UZ38fP5-S1sHaWeYStHGYTUcgigf_HbwRjwQ4@z>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkZlbGl4IEt1ZWhsaW5nIiA8
ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4KPiBUbzogIlRpbW90aHkgUGVhcnNvbiIgPHRwZWFyc29u
QHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4sICJhbWQtZ2Z4IiA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+Cj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyNSwgMjAxOSAxMTowNzozMSBBTQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBhbWRncHU6IEVuYWJsZSBLRkQgb24gUE9XRVIgc3lz
dGVtcwoKPiBIaSBUaW1vdGh5LAo+IAo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIGFuZCBmb3Ig
Y29uZmlybWluZyB0aGF0IGl0IHdvcmtzLiBXZSBkaWQgc29tZQo+IGV4cGVyaW1lbnRhbCB3b3Jr
IG9uIFBvd2VyOCBhIGZldyB5ZWFycyBhZ28uIEkgc2VlIHRoYXQgVGFsb3MgSUkgaXMgUG93ZXI5
Lgo+IAo+IEF0IHRoZSB0aW1lIHdlIHdlcmUgd29ya2luZyBvbiBQb3dlcjggd2UgaGFkIHRvIGFk
ZCBzb21lICNpZmRlZgo+IENPTkZJR19BQ1BJIGd1YXJkcyBhcm91bmQgc29tZSBBQ1BJLXNwZWNp
ZmljIGNvZGUgaW4gS0ZELiBEbyB5b3Uga25vdyB0bwo+IHdoYXQgZXh0ZW50IEFDUEkgaXMgYXZh
aWxhYmxlIGFuZCB3b3JraW5nIG9uIHRoZSBQb3dlciBhcmNoaXRlY3R1cmU/Cj4gCj4gQW5vdGhl
ciBwcm9ibGVtIHdlIHJhbiBpbnRvIHdpdGggUG93ZXIsIGlzIHRoZSBwaHlzaWNhbCBhZGRyZXNz
IG1hcC4KPiBTeXN0ZW0gbWVtb3J5IGNhbiBiZSBhIHBoeXNpY2FsIGFkZHJlc3NlcyBvdXRzaWRl
IHRoZSByYW5nZSBhY2Nlc3NpYmxlCj4gYnkgdGhlIEdQVS4gVmVnYSBoYXMgNDQtYml0IHBoeXNp
Y2FsIGFkZHJlc3NpbmcuIE9sZGVyIFBvbGFyaXMgR1BVcyBvbmx5Cj4gaGF2ZSA0MC1iaXRzLiBE
aWQgeW91IHJ1biBpbnRvIGFueSBzdWNoIHByb2JsZW1zPyBEbyB5b3UgbmVlZCBhbiBJT01NVQo+
IHRvIG1ha2Ugc3lzdGVtIG1lbW9yeSBhY2Nlc3NpYmxlIHRvIHRoZSBHUFU/Cj4gCj4gUmVnYXJk
cywKPiDCoCBGZWxpeAoKWWVzLCB3ZSBhcmUgUE9XRVI5LiAgSXQgbG9va3MgbGlrZSB0aGUgQUNQ
SSBndWFyZHMgYXJlIG5vIGxvbmdlciByZXF1aXJlZDsgYXMgeW91IGhhdmUgc3VybWlzZWQsIFBP
V0VSIGRvZXMgbm90IHVzZSBBQ1BJICh0aGUgZXF1aXZhbGVudCBpcyBPUEFMLCB3aGljaCBpcyBh
IGRpZmZlcmVudCBpbnRlcmZhY2UgZW50aXJlbHkpLiAgV2hhdCB3ZXJlIHRoZSBBUENJIGNhbGxz
IHVzZWQgZm9yPyAgVGhlcmUgbWF5IGJlIE9QQUwgZXF1aXZhbGVudHMgdGhhdCBjb3VsZCBiZSBh
ZGRlZCBpbiB0byByZXBsYWNlIHRoZW0gYW5kIHByb3ZpZGUgc2ltaWxhciBmdW5jdGlvbmFsaXR5
LgoKS2VybmVsIDUuNCBlbmFibGVzIGEgPiAzMi1iaXQgYW5kIDw9NjQtYml0IGJ5cGFzcyBtb2Rl
IGZvciBQT1dFUi4gIFRoaXMgaXMgb25lIHJlYXNvbiB3ZSBjYW1lIGJhY2sgYW5kIHJldmlzaXRl
ZCB0aGUgS0ZEL1JPQ20gZnVuY3Rpb25hbGl0eSBvbiBQT1dFUjsgYXMgaXQgdHVybnMgb3V0LCBh
ZnRlciBmaXhpbmcgdXAgdGhlIHVzZXJzcGFjZSB0b29scyBLRkQgaXMgaW5kZWVkIGZ1bmN0aW9u
YWwgb24gUE9XRVIgd2l0aCA1LjQtcmM4IGFuZCBhYm92ZS4gIE15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCB0aGUgUE9XRVIgSU9NTVUgaXMgdXNlZCBhcyBhIGxpZ2h0d2VpZ2h0IHRyYW5zbGF0aW9u
IGxheWVyIGJldHdlZW4gdGhlIDY0LWJpdCBob3N0IGFuZCB0aGUgNDAvNDQtYml0IEdQVS4KCkkn
bSB3b3JraW5nIG9uIGdldHRpbmcgYSBEZWJpYW4gUFBBIHNldCB1cCBmb3IgUE9XRVIgdG8gbWFr
ZSB0aGUgdXNlcnNwYWNlIHRvb2xzIGVhc2llciB0byBvYnRhaW4gZm9yIHRlc3RpbmcsIGJ1dCBw
cm9ncmVzcyBpcyBzbG93IGR1ZSB0byBsYWNrIG9mIERlYmlhbiBzb3VyY2UgcGFja2FnZXMuICBQ
cm9iYWJseSB0aGUgZWFzaWVzdCB3YXkgdG8gcmVwbGljYXRlIC8gdGVzdCB0aGlzIHdpdGggSElQ
IGlzIHRvIHVzZSB0aGUgQU9NUCByZXBvc2l0b3J5IHdpdGggbXkgbW9kaWZpY2F0aW9uczsgcHVs
bCByZXF1ZXN0cyBhcmUgYWxyZWFkeSBpbiBwbGFjZSBvbiBHaXRodWIgZm9yIG1vc3Qgb2YgdGhl
IHVzZXJzcGFjZSB0b29saW5nIHVwZGF0ZXMuCgpUaGFuayB5b3UhCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
