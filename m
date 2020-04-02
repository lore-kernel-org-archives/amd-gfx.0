Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473B9C2D0F3
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 13:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB672078B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RmbAMcl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB672078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E926EA8A;
	Thu,  2 Apr 2020 13:11:24 +0000 (UTC)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF32D6EA00
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 07:56:46 +0000 (UTC)
Received: by mail-lf1-x144.google.com with SMTP id q5so1869265lfb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2020 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NLxAfO/+CXjGBU0lneDYEfTm3/RVeCex0QsJS4HUhZc=;
 b=RmbAMcl888PHsTzOLIAl3LFnAF/LaClsZoOPozQJSeYjsZqb0oxpAyEx6/MxUb3vFY
 Q2kOTxQb/Gp67rDIH00o5g7ZBUV1U1VoYnaTHxaeGVwNWK6fkxOQODwh+Z2bnvv5ymsJ
 sijSpJjrPsy8TmsG2arBREV/jexcBBiKN+uhkIlwRKTF08AOQJKOujRbDytrEkKempwC
 hmbnjA5WnLz0YNt8y32d+aeA89hLAOiBH1eWsnssiGJIqFn8K+dZST9PfqBKJWg1FXy8
 DnviHEtx46AAaVg5SurPy8EP3SIZDbX1Ukd8lM/iwKozhzQUzTok7u1zT18BzBpufgPQ
 LHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NLxAfO/+CXjGBU0lneDYEfTm3/RVeCex0QsJS4HUhZc=;
 b=hWBkIEFdlr/KUxlQXpHjB8txW/lWyP1BCciCkrIds4S7Z6dC/bptoDjn+FSoYb0VFv
 vz0Ge/NZepdvJAJ15MojJwaAINHP5RaNfJ5HdUGzHavubRNTbnJCLU4K4xCYLI6TKCCz
 PN4vz3/cvO+RzbSSoF775tVrPuySmMpDooORvrZ6Y1xxRhs2HNH3fKpDDwxTwuzLbbaR
 JuLDJ/kmHteWE9Ocp0V5Z1OIteAHULVbjHlpGdFONyoZOpKfuNwYiSNkE9O1agCENM6N
 08Q9OAZRMTnO1+F9c7aO89A8bfVwlaX9jUeXArZ3KK8/WgWYmhVzhnD8E5R/V0ibbZIm
 U4cQ==
X-Gm-Message-State: AGi0PubzS6pUkLlHxdteebMber9jvLHBpUw5LKxsd84T8OfYjkHe6sko
 5qUeh0iQAQ8GQazYdkuNb+re67D6Bdz5pp7aCLL03uF+BZaXrQ==
X-Google-Smtp-Source: APiQypJ4cqTyHEJt4zQugpcoHs1N3egWTunLDxTUril9LnntFZT1U1twMztpRgVqvm7g5n1lG3YDWUTVbxU80Ip3k7A=
X-Received: by 2002:a19:6e47:: with SMTP id q7mr1311472lfk.164.1585814204978; 
 Thu, 02 Apr 2020 00:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
In-Reply-To: <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 2 Apr 2020 09:56:18 +0200
Message-ID: <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Thu, 02 Apr 2020 13:11:23 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Leo Li <sunpeng.li@amd.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBBcHIgMiwgMjAyMCBhdCA5OjM0IEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gQW0gMDIuMDQuMjAgdW0gMDQ6MzQgc2NocmllYiBK
YW5uIEhvcm46Cj4gPiBbeDg2IGZvbGtzIGluIENDIHNvIHRoYXQgdGhleSBjYW4gY2hpbWUgaW4g
b24gdGhlIHByZWNpc2UgcnVsZXMgZm9yIHRoaXMgc3R1ZmZdCj4gPiBJIG5vdGljZWQgdGhhdCBz
ZXZlcmFsIG1ha2VmaWxlcyB1bmRlciBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvCj4g
PiB0dXJuIG9uIGZsb2F0aW5nLXBvaW50IGluc3RydWN0aW9ucyBpbiB0aGUgY29tcGlsZXIgZmxh
Z3MKPiA+ICgtbWhhcmQtZmxvYXQsIC1tc3NlIGFuZCAtbXNzZTIpIGluIG9yZGVyIHRvIG1ha2Ug
dGhlICJmbG9hdCIgYW5kCj4gPiAiZG91YmxlIiB0eXBlcyB1c2FibGUgZnJvbSBDIGNvZGUgd2l0
aG91dCByZXF1aXJpbmcgaGVscGVyIGZ1bmN0aW9ucy4KPiA+Cj4gPiBIb3dldmVyLCBhcyBmYXIg
YXMgSSBrbm93LCBjb2RlIHJ1bm5pbmcgaW4gbm9ybWFsIGtlcm5lbCBjb250ZXh0IGlzbid0Cj4g
PiBhbGxvd2VkIHRvIHVzZSBmbG9hdGluZy1wb2ludCByZWdpc3RlcnMgd2l0aG91dCBzcGVjaWFs
IHByb3RlY3Rpb24KPiA+IHVzaW5nIGhlbHBlcnMgbGlrZSBrZXJuZWxfZnB1X2JlZ2luKCkgYW5k
IGtlcm5lbF9mcHVfZW5kKCkgKHdoaWNoIGFsc28KPiA+IHJlcXVpcmUgdGhhdCB0aGUgcHJvdGVj
dGVkIGNvZGUgbmV2ZXIgYmxvY2tzKS4gSWYgeW91IHZpb2xhdGUgdGhhdAo+ID4gcnVsZSwgdGhh
dCBjYW4gbGVhZCB0byB2YXJpb3VzIGlzc3VlcyAtIGFtb25nIG90aGVyIHRoaW5ncywgSSB0aGlu
awo+ID4gdGhlIGtlcm5lbCB3aWxsIGNsb2JiZXIgdXNlcnNwYWNlIEZQVSByZWdpc3RlciBzdGF0
ZSwgYW5kIEkgdGhpbmsgdGhlCj4gPiBrZXJuZWwgY29kZSBjYW4gYmxvdyB1cCBpZiBhIGNvbnRl
eHQgc3dpdGNoIGhhcHBlbnMgYXQgdGhlIHdyb25nIHRpbWUsCj4gPiBzaW5jZSBpbi1rZXJuZWwg
dGFzayBzd2l0Y2hlcyBkb24ndCBwcmVzZXJ2ZSBGUFUgc3RhdGUuCj4gPgo+ID4gSXMgdGhlcmUg
c29tZSBoaWRkZW4gdHJpY2sgSSdtIG1pc3NpbmcgdGhhdCBtYWtlcyBpdCBva2F5IHRvIHVzZSBG
UFUKPiA+IHJlZ2lzdGVycyBoZXJlPwo+ID4KPiA+IEkgd291bGQgdHJ5IHRlc3RpbmcgdGhpcywg
YnV0IHVuZm9ydHVuYXRlbHkgbm9uZSBvZiB0aGUgQU1EIGRldmljZXMgSQo+ID4gaGF2ZSBoZXJl
IGhhdmUgdGhlIGFwcHJvcHJpYXRlIGdyYXBoaWNzIGhhcmR3YXJlLi4uCj4KPiB5ZXMsIHVzaW5n
IHRoZSBmbG9hdGluZyBwb2ludCBjYWxjdWxhdGlvbnMgaW4gdGhlIGRpc3BsYXkgY29kZSBoYXMg
YmVlbgo+IGEgc291cmNlIG9mIG51bWVyb3VzIHByb2JsZW1zIGFuZCBjb25mdXNpb24gaW4gdGhl
IHBhc3QuCj4KPiBUaGUgY2FsbHMgdG8ga2VybmVsX2ZwdV9iZWdpbigpIGFuZCBrZXJuZWxfZnB1
X2VuZCgpIGFyZSBoaWRkZW4gYmVoaW5kCj4gdGhlIERDX0ZQX1NUQVJUKCkgYW5kIERDX0ZQX0VO
RCgpIG1hY3JvcyB3aGljaCBhcmUgc3VwcG9zZWQgdG8gaGlkZSB0aGUKPiBhcmNoaXRlY3R1cmUg
ZGVwZW5kIGhhbmRsaW5nIGZvciB4ODYgYW5kIFBQQzY0LgoKSG1tLi4uIGJ1dCBhcyBmYXIgYXMg
SSBjYW4gdGVsbCwgeW91J3JlIHVzaW5nIHRob3NlIG1hY3JvcyBmcm9tIGluc2lkZQpmdW5jdGlv
bnMgdGhhdCBhcmUgYWxyZWFkeSBjb21waWxlZCB3aXRoIHRoZSBGUFUgb246CgogLSBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLmMgdXNlcyB0aGUgbWFjcm9z
LApidXQgaXMgYWxyZWFkeSBjb21waWxlZCB3aXRoIGNhbGNzX2NjZmxhZ3MKIC0gZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgdXNlcyB0aGUKbWFj
cm9zLCBidXQgaXMgYWxyZWFkeSBjb21waWxlZCB3aXRoICItbWhhcmQtZmxvYXQgLW1zc2UgLW1z
c2UyIgogLSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3Vy
Y2UuYyB1c2VzIHRoZQptYWNyb3MsIGJ1dCBpcyBhbHJlYWR5IGNvbXBpbGVkIHdpdGggIi1taGFy
ZC1mbG9hdCAtbXNzZSAtbXNzZTIiCgpBRkFJSyBhcyBzb29uIGFzIHlvdSBlbnRlciBhbnkgZnVu
Y3Rpb24gaW4gYW55IGZpbGUgY29tcGlsZWQgd2l0aCBGUFUKaW5zdHJ1Y3Rpb25zLCB5b3UgbWF5
IGVuY291bnRlciBTU0UgaW5zdHJ1Y3Rpb25zLCBlLmcuIHZpYSB0aGluZ3MgbGlrZQpjb21waWxl
ci1nZW5lcmF0ZWQgbWVtb3J5LXplcm9pbmcgY29kZSAtIG5vdCBqdXN0IHdoZW4geW91J3JlIGFj
dHVhbGx5CnVzaW5nIGRvdWJsZXMgb3IgZmxvYXRzLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
