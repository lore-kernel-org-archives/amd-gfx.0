Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463D8C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D286117A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D286117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8EA6EC72;
	Fri, 16 Apr 2021 16:27:38 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C616EC75;
 Fri, 16 Apr 2021 16:27:36 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id v6so41692925ejo.6;
 Fri, 16 Apr 2021 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0ShXI12foOcUA52ohYfIDfBgnWFXNmaWhwrX+YYN+/c=;
 b=VwWwajPp3/0Ms76Fxjwoz46Olg8L5SIaPEFb3v9yziS5wH/de3mpbhCSHTtECY0T5r
 MWaINdL+0Bma7in/I0wq7kYVjFRScvbi6pBRjBcSijjHdPuVp2MPxMIYv6D5w84hUe7E
 PHe5z6AtXYEiL3mqU5r9KWn13/w2wZeaU9ONVOJrajq6TEVsIt/5PtPfxVUjpoFocvSc
 j5gP95YIWuA8L6PCyCCzUJBjkDdOi+HVzSornZzPBASPaKB4mmuBlXBNjGVUmlwywHPj
 zuWLgqSi3k/YgyZx3tDRsJj2bC5Gi8Eg82RasP86HojHoRuLBUjJutfsl9NGBFGyttC1
 y/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0ShXI12foOcUA52ohYfIDfBgnWFXNmaWhwrX+YYN+/c=;
 b=osXMtgwNoXK+yogu+YXbbfG/t7kkAWqh30hRMoP+N1EeXLIZKw39BT2vYG8cNQ8FR+
 C4MdnyGBYtcjZxuji5+vnctvGcUjIj9uK1ZECnLKFUJjYQOYwrMVNne11PL638j9Weju
 e+UPv5k/z9ldGnae9PTaEvy6d4jVEg5YNEbvkDYm99fFFURwIOU9VywWdPu7OFSyVMiP
 9o2TLMTsBmk6kKpE4X9M6QATl/Bj9UMm2VsV9qWdvJ2UYMKfJGKQdRy3nWWqtczLZiy8
 t/yIyZJTUU4IsiqS4V9wiyba6Q7mZt3hO5Y2YsmnA4UvH1zy/WDaLvYqHc5qgBQbar5K
 zUrg==
X-Gm-Message-State: AOAM531csUwWxY9ef2/cqgFLNwVCafseAePR5ZxYgruo7jWNTFotQnc4
 tM2CDwbG7yeOMA+G9gRBUUoSpMRvdGBtzxQintg=
X-Google-Smtp-Source: ABdhPJy0+4tmvilhSb0/zfPx6hf0AM+IScMnABDoeEdWCAdBc8M++WbytCTjRTTCf1Wh9nDtlzgV1SZe/Ym0UacbsHw=
X-Received: by 2002:a17:906:4112:: with SMTP id
 j18mr8964664ejk.171.1618590455579; 
 Fri, 16 Apr 2021 09:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210319210317.32369-1-mario.kleiner.de@gmail.com>
 <YFi9Nu/rAjfEdnBg@intel.com>
In-Reply-To: <YFi9Nu/rAjfEdnBg@intel.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 16 Apr 2021 18:27:23 +0200
Message-ID: <CAEsyxygUbyjCS0V6AGdh0HPu20wWQaRuTy9pXJmS1XNS+LLcMw@mail.gmail.com>
Subject: Re: 16 bpc fixed point (RGBA16) framebuffer support for core and AMD.
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
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
 Harry Wentland <Harry.Wentland@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBNYXIgMjIsIDIwMjEgYXQgNDo1MiBQTSBWaWxsZSBTeXJqw6Rsw6QKPHZpbGxlLnN5
cmphbGFAbGludXguaW50ZWwuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0
IDEwOjAzOjEyUE0gKzAxMDAsIE1hcmlvIEtsZWluZXIgd3JvdGU6Cj4gPiBIaSwKPiA+Cj4gPiB0
aGlzIHBhdGNoIHNlcmllcyBhZGRzIHRoZSBmb3VyY2MncyBmb3IgMTYgYml0IGZpeGVkIHBvaW50
IHVub3JtCj4gPiBmcmFtZWJ1ZmZlcnMgdG8gdGhlIGNvcmUsIGFuZCB0aGVuIGFuIGltcGxlbWVu
dGF0aW9uIGZvciBBTUQgZ3B1J3MKPiA+IHdpdGggRGlzcGxheUNvcmUuCj4gPgo+ID4gVGhpcyBp
cyBpbnRlbmRlZCB0byBhbGxvdyBmb3IgcGFnZWZsaXBwaW5nIHRvLCBhbmQgZGlyZWN0IHNjYW5v
dXQgb2YsCj4gPiBWdWxrYW4gc3dhcGNoYWluIGltYWdlcyBpbiB0aGUgZm9ybWF0IFZLX0ZPUk1B
VF9SMTZHMTZCMTZBMTZfVU5PUk0uCj4gPiBJIGhhdmUgcGF0Y2hlZCBBTUQncyBHUFVPcGVuIGFt
ZHZsayBPU1MgZHJpdmVyIHRvIGVuYWJsZSB0aGlzIGZvcm1hdAo+ID4gZm9yIHN3YXBjaGFpbnMs
IG1hcHBpbmcgdG8gRFJNX0ZPUk1BVF9YQkdSMTYxNjE2MTY6Cj4gPiBMaW5rOiBodHRwczovL2dp
dGh1Yi5jb20va2xlaW5lcm0vcGFsL2NvbW1pdC9hMjVkNDgwMjA3NGIxM2E4ZDVmN2VkYzk2YWU0
NTQ2OWVjYmFjM2M0Cj4KPiBXZSBzaG91bGQgYWxzbyBhZGQgc3VwcG9ydCBmb3IgdGhlc2UgZm9y
bWF0cyBpbnRvIGlndC5hIFNob3VsZAo+IGJlIHNlbWktZWFzeSBieSBqdXN0IGFkZGluZyB0aGUg
c3VpdGFibGUgZmxvYXQ8LT51aW50MTYKPiBjb252ZXJzaW9uIHN0dWZmLgo+CgpIaSBWaWxsZSwK
CkNvdWxkIHlvdSBwb2ludCBtZSB0byBhIHNwZWNpZmljIHRlc3QgY2FzZSAvIGZpbGUgdGhhdCBJ
IHNob3VsZCBsb29rCmF0IGZvciBhZGRpbmcgdGhpcz8KCnRoYW5rcywKLW1hcmlvCgo+IC0tCj4g
VmlsbGUgU3lyasOkbMOkCj4gSW50ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
