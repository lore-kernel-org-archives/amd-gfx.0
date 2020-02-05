Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A55C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 19:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346A020720
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 19:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kea8LUPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346A020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E976889AB9;
	Wed,  5 Feb 2020 19:25:00 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338FB89AB9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 19:25:00 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so4207667wrr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+6etbyOth5pMxXkcE8HaqKM6khgkgksXD/eH9UJNJEA=;
 b=kea8LUPwju4mf0/GuitOCtd4RcakZ3//Hbo/lrpf/J2v8cjFp9EELIa05iM/s6kRG4
 AldWv2McCuLH573q1GeUa7fjFPrtJHPtsAEZhgvdV87+qE+wWDpNZ0P5XQ8zvkj3cGKs
 mVVukXjY6jxRJ0RCTLkX0T0AETpzR8RLH31M9ypQ/FvyB9LX6I/GUxzJgniZrTJbSRDR
 7554ffIVunUUpkqfR2x6N8CCaYeyW7TexjzUcK/PQyuITdsIPErc2+QDH8STImI0PJ/M
 dCWhm7yws9tZbxmfGvhdyxV69r5/0LQIFjipTZZYGPJq0Z9f4RdG4tQORz3UJjp3tWOa
 ipng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+6etbyOth5pMxXkcE8HaqKM6khgkgksXD/eH9UJNJEA=;
 b=fNlR/9tWSBllnIQCYcZZS5KIbhNGoYuLznrezl8EJTYPtR5AeLE3KQLq1M9Ou8KEFg
 kmzGON9trEIhQvtFj6RIIvZNQbHTVHE43bXegUJBgTs3AHDjwa0q+NWBhsFekEpkEy2O
 eTcsIcPkNH4zW6NCB2vHcogai5jStdAZKVMWyNvnUX4hsrpMtTo2T157OHn39LMjP2nu
 cYMfWRJ9cd6YECmqAO8suM7Gk1EFlo5jBVfMeuqtKRgCqxdu3Fc2F7mOtOnYq8m40h/Q
 5oBt3zDJOhzFQwceYKZpgHN5wXqSEfab3P4lgMVqDv/COyZwkrlnecT9yxItZzSGOl3c
 p8Pw==
X-Gm-Message-State: APjAAAXHlwrbd73BTIPP4cuJvKOdwvM49n7xUFD6iRoEiJeQMXrCg4wL
 brCsEd4dsIJ2L6f15zpELR7dWtl8rh3t91CmD6U=
X-Google-Smtp-Source: APXvYqyMLJBwyVxuotgLvKnfj9oNGmWehdUKnu2ODm8IuE8L4oG5vN33hTqu5Uzf1HExm07/WCxf+URHGHMmvSz67kw=
X-Received: by 2002:adf:8b59:: with SMTP id v25mr29638010wra.419.1580930698911; 
 Wed, 05 Feb 2020 11:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20191128082714.18609-1-tiwai@suse.de>
 <8a2e290c-f06d-07e6-3768-59f40539bf7d@amd.com>
 <s5hd0at9dof.wl-tiwai@suse.de>
In-Reply-To: <s5hd0at9dof.wl-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2020 14:24:47 -0500
Message-ID: <CADnq5_PfxHrTr=Mndn1fQQ=9EEamydL8M+TFc__kyg=w12wjCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix wrongly passed static prefix
To: Takashi Iwai <tiwai@suse.de>
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
Cc: David Zhou <David1.Zhou@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Christian K6nig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBGZWIgNSwgMjAyMCBhdCAxMTo1NSBBTSBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+IHdyb3RlOgo+Cj4gT24gVGh1LCAyOCBOb3YgMjAxOSAxNTozNToyMyArMDEwMCwKPiBIYXJy
eSBXZW50bGFuZCB3cm90ZToKPiA+Cj4gPiBPbiAyMDE5LTExLTI4IDM6MjcgYS5tLiwgVGFrYXNo
aSBJd2FpIHdyb3RlOgo+ID4gPiBDdXJyZW50bHksIGdjYyBzcGV3cyBhIHdhcm5pbmcgYXM6Cj4g
PiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY24xMC9kY24x
MF9odWJidWIuYzogSW4gZnVuY3Rpb24g4oCYaHViYnViMV92ZXJpZnlfYWxsb3dfcHN0YXRlX2No
YW5nZV9oaWdo4oCZOgo+ID4gPiAgIC4vaW5jbHVkZS9kcm0vZHJtX3ByaW50Lmg6MzE2OjI6IHdh
cm5pbmc6IOKAmGRlYnVnX2RhdGHigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlz
IGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdCj4gPiA+Cj4gPiA+IFRoaXMgaXMgYmVj
YXVzZSB0aGUgY29kZSBjaGVja3MgYWdhaW5zdCBhIHN0YXRpYyB2YWx1ZSBhbHRob3VnaCBpdCdz
Cj4gPiA+IGJhc2ljYWxseSBhIGNvbnN0YW50IGFuZCBndWFyYW50ZWVkIHRvIGJlIHNldC4KPiA+
ID4KPiA+ID4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSB0eXBlIHByZWZpeCBmcm9tIHN0YXRpYyB0
byBjb25zdCBmb3IgYWRkcmVzc2luZwo+ID4gPiB0aGUgY29tcGlsZSB3YXJuaW5nIGFib3ZlIGFu
ZCBhbHNvIGZvciBsZXR0aW5nIHRoZSBjb21waWxlciBvcHRpbWl6ZQo+ID4gPiBiZXR0ZXIuCj4g
PiA+Cj4gPiA+IEZpeGVzOiA2MmQ1OTFhOGUwMGMgKCJkcm0vYW1kL2Rpc3BsYXk6IGNyZWF0ZSBu
ZXcgZmlsZXMgZm9yIGh1YmJ1YiBmdW5jdGlvbnMiKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUYWth
c2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Cj4gPgo+ID4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRs
YW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+ID4KPiA+IEhhcnJ5Cj4KPiBUaGlzIHBhdGNo
IHNlZW1zIGZvcmdvdHRlbj8gIFRoZSBjb21waWxlIHdhcm5pbmcgaXMgc3RpbGwgcHJlc2VudCBp
bgo+IHRoZSBsYXRlc3QgZm9yLW5leHQuCj4KClNvcnJ5LCB0b3RhbGx5IG1pc3NlZCB0aGlzIG9u
ZS4gIEFwcGxpZWQuCgpBbGV4Cgo+Cj4gdGhhbmtzLAo+Cj4gVGFrYXNoaQo+Cj4gPgo+ID4gPiAt
LS0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJi
dWIuYyB8IDQgKystLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYwo+ID4gPiBpbmRleCBhMDJjMTBlMjNlMGQuLmI1
YzQ0YzNiZGI5OCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjEwL2RjbjEwX2h1YmJ1Yi5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYwo+ID4gPiBAQCAtMTI4LDggKzEyOCw4IEBA
IGJvb2wgaHViYnViMV92ZXJpZnlfYWxsb3dfcHN0YXRlX2NoYW5nZV9oaWdoKAo+ID4gPiAgICAg
ICogcHN0YXRlIHRha2VzIGFyb3VuZCB+MTAwdXMgb24gbGludXguIFVua25vd24gY3VycmVudGx5
IGFzIHRvCj4gPiA+ICAgICAgKiB3aHkgaXQgdGFrZXMgdGhhdCBsb25nIG9uIGxpbnV4Cj4gPiA+
ICAgICAgKi8KPiA+ID4gLSAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgcHN0YXRlX3dhaXRfdGltZW91
dF91cyA9IDIwMDsKPiA+ID4gLSAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgcHN0YXRlX3dhaXRfZXhw
ZWN0ZWRfdGltZW91dF91cyA9IDQwOwo+ID4gPiArICAgY29uc3QgdW5zaWduZWQgaW50IHBzdGF0
ZV93YWl0X3RpbWVvdXRfdXMgPSAyMDA7Cj4gPiA+ICsgICBjb25zdCB1bnNpZ25lZCBpbnQgcHN0
YXRlX3dhaXRfZXhwZWN0ZWRfdGltZW91dF91cyA9IDQwOwo+ID4gPiAgICAgc3RhdGljIHVuc2ln
bmVkIGludCBtYXhfc2FtcGxlZF9wc3RhdGVfd2FpdF91czsgLyogZGF0YSBjb2xsZWN0aW9uICov
Cj4gPiA+ICAgICBzdGF0aWMgYm9vbCBmb3JjZWRfcHN0YXRlX2FsbG93OyAvKiBoZWxwIHdpdGgg
cmV2ZXJ0IHdhICovCj4gPiA+Cj4gPiA+Cj4gPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
