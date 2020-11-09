Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C234CC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 20:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B314206E3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 20:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR+OwL0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B314206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F3A89333;
	Mon,  9 Nov 2020 20:06:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038C889333;
 Mon,  9 Nov 2020 20:06:20 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d12so8634201wrr.13;
 Mon, 09 Nov 2020 12:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Iy1xPaJP1RLahUMonTQA7uwMfpq1Q9nhzx/7OzBh5HI=;
 b=gR+OwL0DSP3nmXja2FT2NQXa3GZBLkj208UVIlNZNLAPmOm7McX378MITBppNVwqB5
 knZvmVAu1X+9c5EKNS+CowCbGgJOV5oVWllrajuwHPUUFA7bcM9ZXFyXQKlQe8Cb6LQh
 ICCdyVqoQsPtk32JZkY4hTvaE4j4iQZ213dA4emsRmEhbuxf49pEUIbLvot707yA4IVt
 ToqCUdzYnArRvfPzQg3pvUCLe5vrmb6HAgctbDq5lNlQFkQ6VLR4VtQrcwQq/+i9RyMA
 5DQzu0vtpYwtm09pKl0/iEaRkv9FUqE+bQAWFMWPyr3wfYetrfp3GZE/3fka+TxTM9+8
 FlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Iy1xPaJP1RLahUMonTQA7uwMfpq1Q9nhzx/7OzBh5HI=;
 b=NiT3PwsUTGZQeA7HJRBecZJVyi4oCOC7lP1zTt6pF3ECKoCQfAC/0rNU27BV+0787n
 t2BvdPAO3JofFiPI9gJA18C2Wb+V+T8A+5j1HIQwqn43z/Funjer/ZlKW1yX6IKs5W6L
 1Dnb+qRQ6Wu7eODYmBrGVM4f+TY7y0Sb1JPLnH5l9Beh4ipIWJ89kVGGIiBouOH2NOgb
 eHw1nIN9mrJscc5J9c0wATxE0AXQf4iWQPNO7Kpqrqooc6+a3YasxJugqGoy9KbTYPgX
 pQjtXfYLMEAl2PNpiCLH3NSXrFqFfxJIUsMf9At6//ZhgprHa7NnAc3+rJUgfKCCE97k
 9IUw==
X-Gm-Message-State: AOAM531YvkbYY1A9w5767Zi2msvoXGI6YSqnvc7Jij+ijdoYSgmDbAqZ
 QguZYeuJ6ERp0alY9/UtDDcj7AkJAAtCiEAUKmo=
X-Google-Smtp-Source: ABdhPJzYSuaz92h+G6EWiAsIK4TeCchRsXCbsrwZAHYNgu49K7nh20b/IWe3P2GMd5scEfGAOk788sEEoW5SZ6Z/gTU=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr19681883wrn.362.1604952378759; 
 Mon, 09 Nov 2020 12:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
 <20201109195557.GA1940813@ravnborg.org>
In-Reply-To: <20201109195557.GA1940813@ravnborg.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2020 15:06:07 -0500
Message-ID: <CADnq5_PpjYOwk1a=ioHXpeK239ToDS3GeObutiWBQ6OWK2i9Ug@mail.gmail.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
To: Sam Ravnborg <sam@ravnborg.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgOSwgMjAyMCBhdCAyOjU2IFBNIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3Jn
Lm9yZz4gd3JvdGU6Cj4KPiBIaSBBbGV4LAo+IE9uIE1vbiwgTm92IDA5LCAyMDIwIGF0IDAyOjUw
OjM1UE0gLTA1MDAsIEFsZXggRGV1Y2hlciB3cm90ZToKPiA+IE9uIEZyaSwgTm92IDYsIDIwMjAg
YXQgNDo1MCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4K
PiA+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4g
PiA+Cj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYzoyMjY6IHdhcm5p
bmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Rldicgbm90IGRlc2NyaWJlZCBpbiAn
cmFkZW9uX2luZm9faW9jdGwnCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9r
bXMuYzoyMjY6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ3JkZXYnIGRlc2Ny
aXB0aW9uIGluICdyYWRlb25faW5mb19pb2N0bCcKPiA+ID4KPiA+ID4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+ID4gQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgo+ID4gPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+
ID4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+ID4gQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+ID4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxs
ZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9rbXMuYyB8IDIgKy0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9r
bXMuYwo+ID4gPiBpbmRleCAwZDhmYmFiZmZjZWFkLi4yMWMyMDY3OTVjMzY0IDEwMDY0NAo+ID4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwo+ID4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwo+ID4gPiBAQCAtMjEzLDcgKzIxMyw3
IEBAIHN0YXRpYyB2b2lkIHJhZGVvbl9zZXRfZmlscF9yaWdodHMoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwKPiA+ID4gIC8qKgo+ID4gPiAgICogcmFkZW9uX2luZm9faW9jdGwgLSBhbnN3ZXIgYSBk
ZXZpY2Ugc3BlY2lmaWMgcmVxdWVzdC4KPiA+ID4gICAqCj4gPiA+IC0gKiBAcmRldjogcmFkZW9u
IGRldmljZSBwb2ludGVyCj4gPiA+ICsgKiBAZGV2OiByYWRlb24gZGV2aWNlIHBvaW50ZXIKPiA+
Cj4gPiBUaGlzIHNob3VsZCBiZToKPiA+ICsgKiBAZGV2OiBkcm0gZGV2aWNlIHBvaW50ZXIKPgo+
IGdvb2Qgc3BvdC4gSSBhbSBjb250aW51aW5nIHRoZSB3b3JrIG9uIHJhZGVvbiBhbmQgd2lsbCBw
b3N0IGEgcGF0Y2hzZXQKPiB0aGF0IGNvbnRhaW5zIG9ubHkgcmFkZW9uIGZpeGVzIHdpdGggTGVl
J3MgcGF0Y2hlcyBhbmQgYSBmZXcgbW9yZSBieSBtZS4KPiBJIHdpbGwgZml4IHRoZSBhYm92ZS4K
CkF3ZXNvbWUuICBUaGFua3MhCgpBbGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
