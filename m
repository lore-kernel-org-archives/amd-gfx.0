Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A819AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788BD20714
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 21:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CAVO4gWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788BD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0E96E526;
	Mon, 15 Jun 2020 21:48:40 +0000 (UTC)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D301B6E506
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 20:51:46 +0000 (UTC)
Received: by mail-pj1-x1042.google.com with SMTP id i12so361733pju.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=NEGpBhzajRvF6MnLoS3/tW4o+xI54R1ORmU7+pXtHgE=;
 b=CAVO4gWs4evuqxTXK2KCGxd4s8FQi+TTDSLN297LSL3es1KODeKbGPV9mlrfjetsXf
 v0HKTGVYLoAqhJhrwOd5Vk0N5GOco/ahrHy/bgts2ivjvsbkW6XgnzOHmBrYE+Pp2Y1J
 nGdFYpsbdrlQlebSLBTotHPvmRSjaUsVZqye4Dd2PA0OURe3oRw0zP2eMBDcd6VQZihT
 FRcuywOs/douthqwTVN6eo7mcBIE7qXFhbRpBk2SHNXj25Qi3MP8jltZVZIXtbslMuaB
 VD3oaozewaoKV4crG14zN+9m85zBgfwiDTmWyKTBDDSH261G6U1wYGLJwtEtYDDK+7kb
 c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=NEGpBhzajRvF6MnLoS3/tW4o+xI54R1ORmU7+pXtHgE=;
 b=PUpG3arMADsOcMwRVOZlgi2TmXpS7DqxU2C3bgqHHYC1i+YgaHk2maQPGsdbmoj7Nn
 /NiDKTxS997nJ4FgI/5+NkFiiuXu7zViA9k59cCEn+gFdRYbpZvsulh6OSiB7c5wsKdf
 RmyYDspfrB0Fi4HPzZUvUfHh5qwgA0I7Psr9jfqeJrmFfTBV36JxoqwqH+3tVNN3JMof
 IvUyZm7EcbMT93GkDefMzz3K2P8RGpk6AOB+KinvN3azT5jYI5+JgVi+Bu8Hz+lAqmU5
 Cmq1aFpYTj3RvY1ChlySi6vCApZsV4Nki45kmjrUzaF9i5g2wIxAiw2ALb2DWJcIoP9G
 Zwyg==
X-Gm-Message-State: AOAM5307TSjgi5fzW9i9WnzcU4yBu+vVJ3B5uh268IovRrfslJhpHgS4
 lWvj674RtkKwBeT9W5ywPZtHLw==
X-Google-Smtp-Source: ABdhPJzJVNx7nQtAyuRZTQv2cHaZxJpL+9jFfYmiZnjQELc31r77D7nEgtShc/qKvBOxL6bGQEnZAg==
X-Received: by 2002:a17:902:7896:: with SMTP id
 q22mr13701253pll.338.1592254306139; 
 Mon, 15 Jun 2020 13:51:46 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:bdcc:b60c:73b8:18ca?
 ([2601:646:c200:1ef2:bdcc:b60c:73b8:18ca])
 by smtp.gmail.com with ESMTPSA id i5sm14721024pfd.5.2020.06.15.13.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 13:51:45 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date: Mon, 15 Jun 2020 13:51:39 -0700
Message-Id: <C41D099B-BE2E-4D0E-A7B5-7CE587E11930@amacapital.net>
References: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
In-Reply-To: <20200615201735.GE13792@romley-ivt3.sc.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17F80)
X-Mailman-Approved-At: Mon, 15 Jun 2020 21:48:37 +0000
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
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cj4gT24gSnVuIDE1LCAyMDIwLCBhdCAxOjE3IFBNLCBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGlu
dGVsLmNvbT4gd3JvdGU6Cj4gCj4g77u/SGksIFBldGVyLAo+IAo+PiBPbiBNb24sIEp1biAxNSwg
MjAyMCBhdCAwOTowOToyOFBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPj4+IE9uIE1v
biwgSnVuIDE1LCAyMDIwIGF0IDExOjU1OjI5QU0gLTA3MDAsIEZlbmdodWEgWXUgd3JvdGU6Cj4+
PiAKPj4+IE9yIGRvIHlvdSBzdWdnZXN0IHRvIGFkZCBhIHJhbmRvbSBuZXcgZmxhZyBpbiBzdHJ1
Y3QgdGhyZWFkX2luZm8gaW5zdGVhZAo+Pj4gb2YgYSBUSUYgZmxhZz8KPj4gCj4+IFdoeSB0aHJl
YWRfaW5mbz8gV2hhdCdzIHdyb25nIHdpdGggc29tZXRoaW5nIHNpbXBsZSBsaWtlIHRoZSBiZWxv
dy4gSXQKPj4gdGFrZXMgYSBiaXQgZnJvbSB0aGUgJ3N0cmljdGx5IGN1cnJlbnQnIGZsYWdzIHdv
cmQuCj4+IAo+PiAKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQuaCBiL2luY2x1
ZGUvbGludXgvc2NoZWQuaAo+PiBpbmRleCBiNjJlNmFhZjI4ZjAuLmZjYTgzMGI5NzA1NSAxMDA2
NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2hlZC5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
c2NoZWQuaAo+PiBAQCAtODAxLDYgKzgwMSw5IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCB7Cj4+ICAg
IC8qIFN0YWxsZWQgZHVlIHRvIGxhY2sgb2YgbWVtb3J5ICovCj4+ICAgIHVuc2lnbmVkICAgICAg
ICAgICAgaW5fbWVtc3RhbGw6MTsKPj4gI2VuZGlmCj4+ICsjaWZkZWYgQ09ORklHX1BDSV9QQVNJ
RAo+PiArICAgIHVuc2lnbmVkICAgICAgICAgICAgaGFzX3ZhbGlkX3Bhc2lkOjE7Cj4+ICsjZW5k
aWYKPj4gCj4+ICAgIHVuc2lnbmVkIGxvbmcgICAgICAgICAgICBhdG9taWNfZmxhZ3M7IC8qIEZs
YWdzIHJlcXVpcmluZyBhdG9taWMgYWNjZXNzLiAqLwo+PiAKPj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jCj4+IGluZGV4IDE0MmIyMzY0NWQ4Mi4uMTBiMzg5MWJl
OTllIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvZm9yay5jCj4+ICsrKyBiL2tlcm5lbC9mb3JrLmMK
Pj4gQEAgLTk1NSw2ICs5NTUsMTAgQEAgc3RhdGljIHN0cnVjdCB0YXNrX3N0cnVjdCAqZHVwX3Rh
c2tfc3RydWN0KHN0cnVjdCB0YXNrX3N0cnVjdCAqb3JpZywgaW50IG5vZGUpCj4+ICAgIHRzay0+
dXNlX21lbWRlbGF5ID0gMDsKPj4gI2VuZGlmCj4+IAo+PiArI2lmZGVmIENPTkZJR19QQ0lfUEFT
SUQKPj4gKyAgICB0c2stPmhhc192YWxpZF9wYXNpZCA9IDA7Cj4+ICsjZW5kaWYKPj4gKwo+PiAj
aWZkZWYgQ09ORklHX01FTUNHCj4+ICAgIHRzay0+YWN0aXZlX21lbWNnID0gTlVMTDsKPj4gI2Vu
ZGlmCj4gCj4gVGhlIFBBU0lEIE1TUiBpcyB4ODYgc3BlY2lmaWMgYWx0aG91Z2ggUEFTSUQgaXMg
UENJZSBjb25jZXB0IGFuZCBwZXItbW0uCj4gQ2hlY2tpbmcgaWYgdGhlIE1TUiBoYXMgdmFsaWQg
UEFTSUQgKGJpdDMxPTEpIGlzIGFuIHg4NiBzcGVjaWZjIHdvcmsuCj4gVGhlIGZsYWcgc2hvdWxk
IGJlIGNsZWFyZWQgaW4gY2xvbmVkKCkvZm9ya2VkKCkgYW5kIGlzIG9ubHkgc2V0IGFuZAo+IHJl
YWQgaW4gZml4dXAoKSBpbiB4ODYgI0dQIGZvciBoZXVyaXN0aWMuIEl0J3Mgbm90IHVzZWQgYW55
d2hlcmUgb3V0c2lkZQo+IG9mIHg4Ni4KPiAKPiBUaGF0J3Mgd2h5IHdlIHRoaW5rIHRoZSBmbGFn
IHNob3VsZCBiZSBpbiB4ODYgc3RydWN0IHRocmVhZF9pbmZvIGluc3RlYWQKPiBvZiBpbiBnZW5l
cmljZSBzdHJ1Y3QgdGFza19zdHJ1Y3QuCj4gCgpBcmUgd2UgcGxhbm5pbmcgdG8ga2VlcCBQQVNJ
RCBsaXZlIG9uY2UgYSB0YXNrIGhhcyB1c2VkIGl0IG9uY2Ugb3IgYXJlIHdlIGdvaW5nIHRvIHN3
YXAgaXQgbGF6aWx5PyAgSWYgdGhlIGxhdHRlciwgYSBwZXJjcHUgdmFyaWFibGUgbWlnaHQgYmUg
YmV0dGVyLgoKPiBQbGVhc2UgYWR2aWNlLgo+IAo+IFRoYW5rcy4KPiAKPiAtRmVuZ2h1YQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
