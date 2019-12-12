Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC36C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC542077B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMedH/43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC542077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2BF6ECAB;
	Thu, 12 Dec 2019 08:31:41 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802A86ECAB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 08:31:40 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b11so1337514wmj.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WygmEJtsca/yl8a9Xs9MG1WCVH1GkPTlgipXdcrnmGc=;
 b=NMedH/43zsxgOJ+nHrO2rRtJwXpPbhUsObauFINMZFnhaOagNsdlL+2ExiyNeZeMJe
 YeU4uCGjaD2yOWwOiYF7CP9spfWkC3Nl+sSC6qohVqtPMD8fvPChaXSJS1g325v+wK2C
 2N6DqN/WTmbt69kw2ku2S1kIwxeAKm73ywbV59ln8vWx8jicmGQ9iRd/EuawjSTRbRyB
 d0OHo17l0PEe+gd+dNKFPtJWSGLZni5AjfU1gNPD4qgqoUNq6vX7Nlj30EkIxnXuACph
 xR3xeOu4nUxJ61OC5LgioUmKkaHZqTz6nCxB2CUQEHUa/wnxpNFp0Mjr9RfztJEz2X4g
 XIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:from:to:cc:references
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=WygmEJtsca/yl8a9Xs9MG1WCVH1GkPTlgipXdcrnmGc=;
 b=beb3jpmeq5GxteZB13T6yOfWR8x0SibQJj02st1DeTz7vdeL1re0yifnJ1N5Ycs+iV
 /xnYggF2W+CZOdP01aiFkV+RRFpIaSyOHClJBDXZjnqcok5/BmpeRdeR0RJPsdsL3t0+
 MIZUpt5+25Bs50sZCfHsyOma/R2R0vabKjUolTbmiuOyxWSjHZp3macGtDQzZDQCiSDV
 oSDujR8rPQgLPVe9c/wmayiSCZrtkbeqc3sHzlL88pmrtbQRC03C662O7Y/ZbvhBXn2t
 KsKMalTiUMyk5zptYzKsq3HZ5CuiXYEaJmwD07z3U8aPMw+yh2Y+gREwXwfTDiHD8ecl
 rBig==
X-Gm-Message-State: APjAAAUrOJCItwhxkuYk217i+cKTGZFX3m6Ncwom85n9xUcLYnCbUB7P
 ZRhDVw/yuK6fzSZzBiJ38OI=
X-Google-Smtp-Source: APXvYqym+Ylqx62+gVUcqPJOagf9bG+gWdFH3BoHXKcIyZi++98ihGRMR9Gzp8fj3jqGjNDpox5KEA==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr5120575wmm.143.1576139499080; 
 Thu, 12 Dec 2019 00:31:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 16sm5330340wmi.0.2019.12.12.00.31.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:31:38 -0800 (PST)
Subject: Re: [PATCH 2/5] drm: Add Reusable task barrier.
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
 <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_OCzqh_t5YHithp2Kh0rxHsk4XxnfHm-Cm2_T7ZGSA4Ow@mail.gmail.com>
 <2b12b91a-e40f-25f4-bc7c-71566ffdabd4@gmail.com>
Message-ID: <fa72ffe9-39fb-4bf2-f8e7-8b4f53cfa7ad@gmail.com>
Date: Thu, 12 Dec 2019 09:31:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2b12b91a-e40f-25f4-bc7c-71566ffdabd4@gmail.com>
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
Reply-To: christian.koenig@amd.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Le.Ma" <Le.Ma@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMTIuMTkgdW0gMDk6MjQgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDExLjEy
LjE5IHVtIDIxOjE5IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+PiBPbiBXZWQsIERlYyAxMSwgMjAx
OSBhdCAzOjA3IFBNIEFuZHJleSBHcm9kem92c2t5Cj4+IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQu
Y29tPiB3cm90ZToKPj4+IEl0IGlzIHVzZWQgdG8gc3luY2hyb25pemUgTiB0aHJlYWRzIGF0IGEg
cmVuZGV2b3V6IHBvaW50IGJlZm9yZSAKPj4+IGV4ZWN1dGlvbgo+Pj4gb2YgY3JpdGljYWwgY29k
ZSB0aGF0IGhhcyB0byBiZSBzdGFydGVkIGJ5IGFsbCB0aGUgdGhyZWFkcyBhdCAKPj4+IGFwcHJv
eGltYXRseQo+Pj4gdGhlIHNhbWUgdGltZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
R3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPj4gWW91IHNob3VsZCByZXNl
bmQgdG8gZHJpLWRldmVsIHNpbmNlIHRoaXMgdGFzayBiYXJyaWVyIGlzIGJlaW5nIGFkZGVkCj4+
IHRvIGNvbW1vbiBjb2RlLgo+Cj4gQWRkaXRpb25hbCB0byB0aGF0IHRoaXMgd2hvbGUgdGhpbmcg
aGFzIHRoZSBwb3RlbnRpYWwgdG8gcmFpc2UgbG9ja2RlcCAKPiB3YXJuaW5ncyBhbmQgaWYgSSdt
IG5vdCBjb21wbGV0ZWx5IG1pc3Rha2VuIGRvZXNuJ3QgZXZlbiB3b3JrIGNvcnJlY3RseS4KPgo+
IFNlZSBMaW51eCBrZXJuZWwgc2VtYXBob3JlcyBkb24ndCBhbGxvdyBuZWdhdGl2ZSB2YWx1ZXMg
KHRoZSBjb3VudCAKPiBmaWVsZCBpbiBzdHJ1Y3Qgc2VtYXBob3JlIGlzIHVuc2lnbmVkKS4KCk9r
LCBmb3JnZXQgd2hhdCBJJ3ZlIHdyb3RlLiBUaGF0IGluZGVlZCBzZWVtcyB0byBiZSBzdXBwb3J0
ZWQsIHNvbWUgCm90aGVyIGRyaXZlcnMgYXJlIGFscmVhZHkgdXNpbmcgc2VtYXBob3JlcyB0aGUg
c2FtZSB3YXkuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4u
Cj4KPj4KPj4gQWxleAo+Pgo+Pj4gLS0tCj4+PiDCoCBpbmNsdWRlL2RybS90YXNrX2JhcnJpZXIu
aCB8IDEwNiAKPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspCj4+PiDCoCBjcmVhdGUg
bW9kZSAxMDA2NDQgaW5jbHVkZS9kcm0vdGFza19iYXJyaWVyLmgKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kcm0vdGFza19iYXJyaWVyLmggYi9pbmNsdWRlL2RybS90YXNrX2JhcnJpZXIu
aAo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+IGluZGV4IDAwMDAwMDAuLjgxZmIwZjcKPj4+
IC0tLSAvZGV2L251bGwKPj4+ICsrKyBiL2luY2x1ZGUvZHJtL3Rhc2tfYmFycmllci5oCj4+PiBA
QCAtMCwwICsxLDEwNiBAQAo+Pj4gKy8qCj4+PiArICogQ29weXJpZ2h0IDIwMTkgQWR2YW5jZWQg
TWljcm8gRGV2aWNlcywgSW5jLgo+Pj4gKyAqCj4+PiArICogUGVybWlzc2lvbiBpcyBoZXJlYnkg
Z3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gCj4+PiBvYnRhaW5pbmcgYQo+
Pj4gKyAqIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9u
IGZpbGVzICh0aGUgCj4+PiAiU29mdHdhcmUiKSwKPj4+ICsgKiB0byBkZWFsIGluIHRoZSBTb2Z0
d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCAKPj4+IGxpbWl0YXRp
b24KPj4+ICsgKiB0aGUgcmlnaHRzIHRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlz
aCwgZGlzdHJpYnV0ZSwgCj4+PiBzdWJsaWNlbnNlLAo+Pj4gKyAqIGFuZC9vciBzZWxsIGNvcGll
cyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byAKPj4+IHdob20gdGhl
Cj4+PiArICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBm
b2xsb3dpbmcgCj4+PiBjb25kaXRpb25zOgo+Pj4gKyAqCj4+PiArICogVGhlIGFib3ZlIGNvcHly
aWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgCj4+PiBpbmNs
dWRlZCBpbgo+Pj4gKyAqIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhl
IFNvZnR3YXJlLgo+Pj4gKyAqCj4+PiArICogVEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJ
UyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIAo+Pj4gRVhQUkVTUyBPUgo+Pj4gKyAq
IElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0Yg
Cj4+PiBNRVJDSEFOVEFCSUxJVFksCj4+PiArICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBV
UlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC7CoCBJTiBOTyAKPj4+IEVWRU5UIFNIQUxMCj4+PiAr
ICogVEhFIENPUFlSSUdIVCBIT0xERVIoUykgT1IgQVVUSE9SKFMpIEJFIExJQUJMRSBGT1IgQU5Z
IENMQUlNLCAKPj4+IERBTUFHRVMgT1IKPj4+ICsgKiBPVEhFUiBMSUFCSUxJVFksIFdIRVRIRVIg
SU4gQU4gQUNUSU9OIE9GIENPTlRSQUNULCBUT1JUIE9SIAo+Pj4gT1RIRVJXSVNFLAo+Pj4gKyAq
IEFSSVNJTkcgRlJPTSwgT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUg
T1IgVEhFIAo+Pj4gVVNFIE9SCj4+PiArICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRXQVJF
Lgo+Pj4gKyAqCj4+PiArICovCj4+PiArI2luY2x1ZGUgPGxpbnV4L3NlbWFwaG9yZS5oPgo+Pj4g
KyNpbmNsdWRlIDxsaW51eC9hdG9taWMuaD4KPj4+ICsKPj4+ICsvKgo+Pj4gKyAqIFJldXNhYmxl
IDIgUEhBU0UgdGFzayBiYXJyaWVyIChyYW5kZXZvdXogcG9pbnQpIGltcGxlbWVudGF0aW9uIAo+
Pj4gZm9yIE4gdGFza3MuCj4+PiArICogQmFzZWQgb24gdGhlIExpdHRsZSBib29rIG9mIHNlbXBh
aG9yZXMgLSAKPj4+IGh0dHBzOi8vZ3JlZW50ZWFwcmVzcy5jb20vd3Avc2VtYXBob3Jlcy8KPj4+
ICsgKi8KPj4+ICsKPj4+ICsKPj4+ICsKPj4+ICsjaWZuZGVmIERSTV9UQVNLX0JBUlJJRVJfSF8K
Pj4+ICsjZGVmaW5lIERSTV9UQVNLX0JBUlJJRVJfSF8KPj4+ICsKPj4+ICsvKgo+Pj4gKyAqIFJl
cHJlc2VudHMgYW4gaW5zdGFuY2Ugb2YgYSB0YXNrIGJhcnJpZXIuCj4+PiArICovCj4+PiArc3Ry
dWN0IHRhc2tfYmFycmllciB7Cj4+PiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBuOwo+Pj4g
K8KgwqDCoMKgwqDCoCBhdG9taWNfdCBjb3VudDsKPj4+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHNl
bWFwaG9yZSBlbnRlcl90dXJuc3RpbGU7Cj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBzZW1hcGhv
cmUgZXhpdF90dXJuc3RpbGU7Cj4+PiArfTsKPj4+ICsKPj4+ICtzdGF0aWMgaW5saW5lIHZvaWQg
dGFza19iYXJyaWVyX3NpZ25hbF90dXJuc3RpbGUoc3RydWN0IHNlbWFwaG9yZSAKPj4+ICp0dXJu
c3RpbGUsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBpbnQgbikKPj4+ICt7Cj4+PiArwqDCoMKgwqDCoMKgIGludCBpOwo+Pj4gKwo+Pj4gK8KgwqDC
oMKgwqDCoCBmb3IgKGkgPSAwIDsgaSA8IG47IGkrKykKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVwKHR1cm5zdGlsZSk7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbmxpbmUg
dm9pZCB0YXNrX2JhcnJpZXJfaW5pdChzdHJ1Y3QgdGFza19iYXJyaWVyICp0YikKPj4+ICt7Cj4+
PiArwqDCoMKgwqDCoMKgIHRiLT5uID0gMDsKPj4+ICvCoMKgwqDCoMKgwqAgYXRvbWljX3NldCgm
dGItPmNvdW50LCAwKTsKPj4+ICvCoMKgwqDCoMKgwqAgc2VtYV9pbml0KCZ0Yi0+ZW50ZXJfdHVy
bnN0aWxlLCAwKTsKPj4+ICvCoMKgwqDCoMKgwqAgc2VtYV9pbml0KCZ0Yi0+ZXhpdF90dXJuc3Rp
bGUsIDApOwo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgdGFza19iYXJyaWVy
X2FkZF90YXNrKHN0cnVjdCB0YXNrX2JhcnJpZXIgKnRiKQo+Pj4gK3sKPj4+ICvCoMKgwqDCoMKg
wqAgdGItPm4rKzsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGljIGlubGluZSB2b2lkIHRhc2tfYmFy
cmllcl9yZW1fdGFzayhzdHJ1Y3QgdGFza19iYXJyaWVyICp0YikKPj4+ICt7Cj4+PiArwqDCoMKg
wqDCoMKgIHRiLT5uLS07Cj4+PiArfQo+Pj4gKwo+Pj4gKy8qCj4+PiArICogTGluZXMgdXAgYWxs
IHRoZSB0aHJlYWRzIEJFRk9SRSB0aGUgY3JpdGljYWwgcG9pbnQuCj4+PiArICoKPj4+ICsgKiBX
aGVuIGFsbCB0aHJlYWQgcGFzc2VkIHRoaXMgY29kZSB0aGUgZW50cnkgYmFycmllciBpcyBiYWNr
IHRvIAo+Pj4gbG9ja2VkIHN0YXRlLgo+Pj4gKyAqLwo+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB0
YXNrX2JhcnJpZXJfZW50ZXIoc3RydWN0IHRhc2tfYmFycmllciAqdGIpCj4+PiArewo+Pj4gK8Kg
wqDCoMKgwqDCoCBpZiAoYXRvbWljX2luY19yZXR1cm4oJnRiLT5jb3VudCkgPT0gdGItPm4pCj4+
PiArIHRhc2tfYmFycmllcl9zaWduYWxfdHVybnN0aWxlKCZ0Yi0+ZW50ZXJfdHVybnN0aWxlLCB0
Yi0+bik7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgIGRvd24oJnRiLT5lbnRlcl90dXJuc3RpbGUp
Owo+Pj4gK30KPj4+ICsKPj4+ICsvKgo+Pj4gKyAqIExpbmVzIHVwIGFsbCB0aGUgdGhyZWFkcyBB
RlRFUiB0aGUgY3JpdGljYWwgcG9pbnQuCj4+PiArICoKPj4+ICsgKiBUaGlzIGZ1bmN0aW9uIGlz
IHVzZWQgdG8gYXZvaWQgYW55IG9uZSB0aHJlYWQgcnVubmluZyBhaGVhZCBvZiAKPj4+IHRoZSBy
ZXNldCBpZgo+Pj4gKyAqIHRoZSBiYXJyaWVyIGlzIHVzZWQgaW4gYSBsb29wIChyZXBlYXRlZGx5
KSAuCj4+PiArICovCj4+PiArc3RhdGljIGlubGluZSB2b2lkIHRhc2tfYmFycmllcl9leGl0KHN0
cnVjdCB0YXNrX2JhcnJpZXIgKnRiKQo+Pj4gK3sKPj4+ICvCoMKgwqDCoMKgwqAgaWYgKGF0b21p
Y19kZWNfcmV0dXJuKCZ0Yi0+Y291bnQpID09IDApCj4+PiArIHRhc2tfYmFycmllcl9zaWduYWxf
dHVybnN0aWxlKCZ0Yi0+ZXhpdF90dXJuc3RpbGUsIHRiLT5uKTsKPj4+ICsKPj4+ICvCoMKgwqDC
oMKgwqAgZG93bigmdGItPmV4aXRfdHVybnN0aWxlKTsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGlj
IGlubGluZSB2b2lkIHRhc2tfYmFycmllcl9mdWxsKHN0cnVjdCB0YXNrX2JhcnJpZXIgKnRiKQo+
Pj4gK3sKPj4+ICvCoMKgwqDCoMKgwqAgdGFza19iYXJyaWVyX2VudGVyKHRiKTsKPj4+ICvCoMKg
wqDCoMKgwqAgdGFza19iYXJyaWVyX2V4aXQodGIpOwo+Pj4gK30KPj4+ICsKPj4+ICsjZW5kaWYK
Pj4+IC0tIAo+Pj4gMi43LjQKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
