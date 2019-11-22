Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41072C43141
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 15:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213F82071C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 15:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213F82071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C492A6E373;
	Fri, 22 Nov 2019 15:32:13 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AC16E373
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 15:32:12 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l17so7898627wmh.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 07:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f59CCVfdihRZS7ABtJ0WDahBA/Iy5s/bA0O3KEpFY/E=;
 b=AyhAN48uTptGRpDKn/iNTLFlNXspLsOokuj/RCVnZ2lhMV2zKC1PEIB+STuwYWiy/6
 EeUAhttwW9yDsmxhBqAL0vqAnd3quSOo9EZONwoO4ec1h9oKMbge759zepan4R50erAK
 8IoMNp3QoF6CynzxyLw7Y6Qkpj+B8zcgjpPGmVYAlyBQquzntjywSramWFCm6VO8/mRZ
 RIgKR5bvya+jkALkjHZFmNyc634DuIT7lBQPIZZtBp40Q8yEnvOjJHJ5GyjUjRJE59Tg
 YVFZA2hM7FfYpgryUeAwvW9+O7KK4oI9Pe7o1oyMGqWhIPnTmTeljwPBhOgHZqOk4Lhm
 oclQ==
X-Gm-Message-State: APjAAAXnuBEgcEMfXEeney6gYAX+JAgYlxWHvhL9PJp09cAwBptN7Qbl
 4NcQVzgPNSypOS18Ad4IQm4RwsmTZeE/NOj02tE=
X-Google-Smtp-Source: APXvYqxkvzqFIGq5vSlIDYpnyQujQVYMTlOWzqVWoKNhRKOEL0jWqVRBLWBWMeYtS4PPpcgTyBhHJdbdAFBDmoy33+g=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr17022781wml.102.1574436730664; 
 Fri, 22 Nov 2019 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
In-Reply-To: <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Nov 2019 10:31:58 -0500
Message-ID:
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To: Daniel Drake <drake@endlessm.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=f59CCVfdihRZS7ABtJ0WDahBA/Iy5s/bA0O3KEpFY/E=;
 b=Uh2amNqwsPriinB9f10eWW+TPFILFo4KxSfpIEHM3KvBQX7JKAopy83o94uVwpi9IW
 qhOp1EN1DvZvGv36bsfnqdqhq2IlesC/i4qdwh+kLYQxx4gknws+uhGduim+N0rCjD8I
 tj/8vQ+pcNRI9ibch0NgeBojkFdEihVti+2twm4qmohKwPc70aiULFFrQISwdzfiCszm
 ZpJWld7ESjOy1ZGwp0QxRQuCJ5RSrw9M/z7pdcadGwhcWmXe+kI7zgh6Cz232uEIQeMt
 qhPJx/kkCELGnyPoFgaIcjs/WFr3cjEFEL31BPMzux+RvUJ+pice08CYehD09MlRVa+Q
 /lwQ==
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Chunming Zhou <David1.Zhou@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122153158.cj3HWJYigk_76HPgJhHB5rktfsnyXUl3b5rHKaRhDho@z>

T24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgMzoyNCBBTSBEYW5pZWwgRHJha2UgPGRyYWtlQGVuZGxl
c3NtLmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE9jdCAxNiwgMjAxOSBhdCAyOjQzIEFNIEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPiA+IElzIHMyaWRsZSBhY3R1
YWxseSBwb3dlcmluZyBkb3duIHRoZSBHUFU/Cj4KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQg
czJpZGxlIChhdCBhIGhpZ2ggbGV2ZWwpIGp1c3QgY2FsbHMgYWxsCj4gZGV2aWNlcyBzdXNwZW5k
IHJvdXRpbmVzIGFuZCB0aGVuIHB1dHMgdGhlIENQVSBpbnRvIGl0cyBkZWVwZXN0Cj4gcnVubmlu
ZyBzdGF0ZS4KPiBTbyBpZiB0aGVyZSBpcyBzb21ldGhpbmcgc3BlY2lhbCB0byBiZSBkb25lIHRv
IHBvd2VyIG9mZiB0aGUgR1BVLCBJCj4gYmVsaWV2ZSB0aGF0IGFtZGdwdSBpcyByZXNwb25zaWJs
ZSBmb3IgbWFraW5nIGFycmFuZ2VtZW50cyBmb3IgdGhhdCB0bwo+IGhhcHBlbi4KPiBJbiB0aGlz
IGNhc2UgdGhlIGFtZGdwdSBjb2RlIGFscmVhZHkgZG9lczoKPgo+ICAgICAgICAgcGNpX2Rpc2Fi
bGVfZGV2aWNlKGRldi0+cGRldik7Cj4gICAgICAgICBwY2lfc2V0X3Bvd2VyX3N0YXRlKGRldi0+
cGRldiwgUENJX0QzaG90KTsKPgo+IEFuZCB0aGUgUENJIGxheWVyIHdpbGwgY2FsbCB0aHJvdWdo
IHRvIGFueSBhcHByb3ByaWF0ZSBBQ1BJIG1ldGhvZHMKPiByZWxhdGVkIHRvIHRoYXQgbG93IHBv
d2VyIHN0YXRlLgo+Cj4gPiBEbyB5b3Ugc2VlIGEgZGlmZmVyZW5jZSBpbiBwb3dlciB1c2FnZT8g
IEkgdGhpbmsgeW91IGFyZSBqdXN0IHdvcmtpbmcgYXJvdW5kIHRoZSBmYWN0IHRoYXQgdGhlCj4g
PiBHUFUgbmV2ZXIgYWN0dWFsbHkgZ2V0cyBwb3dlcmVkIGRvd24uCj4KPiBJIHJhbiBhIHNlcmll
cyBvZiBleHBlcmltZW50cy4KPgo+IEJhc2Ugc2V0dXA6IG5vIFVJIHJ1bm5pbmcsIHJhbiAic2V0
dGVybSAtcG93ZXJzYXZlIDE7IHNldHRlcm0gLWJsYW5rCj4gMSIgYW5kIHdhaXRlZCAxIG1pbnV0
ZSBmb3Igc2NyZWVuIHRvIHR1cm4gb2ZmLgo+IEJhc2UgcG93ZXIgdXNhZ2UgaW4gdGhpcyBzdGF0
ZSBpcyA0LjdXIGFzIHJlcG9ydGVkIGJ5IEJBVDAvcG93ZXJfbm93Cj4KPiAxLiBSdW4gYW1kZ3B1
X2RldmljZV9zdXNwZW5kKGRkZXYsIHRydWUsIHRydWUpOyBiZWZvcmUgbXkgY2hhbmdlCj4gLS0+
IFBvd2VyIHVzYWdlIGluY3JlYXNlcyB0byA2LjFXCj4KPiAyLiBSdW4gYW1kZ3B1X2RldmljZV9z
dXNwZW5kKGRkZXYsIHRydWUsIHRydWUpOyB3aXRoIG15IGNoYW5nZSBhcHBsaWVkCj4gLS0+IFBv
d2VyIHVzYWdlIGluY3JlYXNlcyB0byA2LjBXCj4KPiAzLiBQdXQgYW1kZ3B1IGRldmljZSBpbiBy
dW50aW1lIHN1c3BlbmQKPiAtLT4gUG93ZXIgdXNhZ2UgaW5jcmVhc2VzIHRvIDYuMlcKPgo+IDQu
IFRyeSB1bm1vZGlmaWVkIHN1c3BlbmQgcGF0aCBidXQgZDNjb2xkIGluc3RlYWQgb2YgZDNob3QK
PiAtLT4gUG93ZXIgdXNhZ2UgaW5jcmVhc2VzIHRvIDYuMVcKPgo+IFNvLCBhbGwgb2YgdGhlIHN1
c3BlbmQgc2NoZW1lcyBhY3R1YWxseSBpbmNyZWFzZSB0aGUgcG93ZXIgdXNhZ2UgYnkKPiByb3Vn
aGx5IHRoZSBzYW1lIGFtb3VudCwgcmVzZXQgb3Igbm90LCB3aXRoIGFuZCB3aXRob3V0IG15IHBh
dGNoIDovCj4gQW55IGlkZWFzPwoKRG8gdGhlc2UgcGF0Y2hlcyBoZWxwPwpodHRwczovL3BhdGNo
d29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMzQxNzc1LwpodHRwczovL3BhdGNod29yay5mcmVl
ZGVza3RvcC5vcmcvcGF0Y2gvMzQxOTY4LwoKQWxleAoKPgo+IFRoYW5rcywKPiBEYW5pZWwKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
