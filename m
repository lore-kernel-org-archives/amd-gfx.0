Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A3C64E90
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5BB20725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiV20Ruu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5BB20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7A089CA4;
	Mon, 30 Nov 2020 23:00:43 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2164C89CA4;
 Mon, 30 Nov 2020 23:00:43 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id x15so732540otp.4;
 Mon, 30 Nov 2020 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c2OtGSBC7TESexKrUVyZrfSsC93ikbUp2j1aDogad7I=;
 b=CiV20Ruuz3z0SrYSz7pHUGehHyKwapSqeMEMA4JshZT2zlNhnqiHgOvZqhDZjbRaqQ
 F7hbbNFtQxwgU2wqFEXPS6dQG5h8KdEKVuVEDqodBdkabVb1eNFP/wDado4lYZQSL6KV
 fr9WAMLKRb/nA74/1Olai+S7rgM6xthhBJlqqHTK5MXZNnpoPuYRfKsn2z4mAGOGtgkY
 8upoVTAW7LwIdDEHOx3P3cTcs3ioZGe3UChp/uiK8k1UwNgBUXHo8+lDhVsn8vT37Y7T
 Z+h1pVWsfyHba5exvH8vebXsTErreVpvzAqx539uN6gMs1GPMNeybpeNZWl7+BL3dHui
 28Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c2OtGSBC7TESexKrUVyZrfSsC93ikbUp2j1aDogad7I=;
 b=KFfR9w2MjIXhISlicYAw46IwTaOznI6j581An8M7QFEQNeO3uDKgXR1LlFE8jzwqib
 ZQcRPXsL1qUgVRoucuDrLe6sF3ed6/yH9Mb8XK2yF3mUl1Xl5Q2VAvgS1PlOIwlbO4uD
 lE47q557TWQyn+zW39DbZRuxh5VqTodsi8LPmWVEpUJl0eUac7w54LPL44CK3k2nAuco
 QGbwqZoAe4ev3VTTLfTUU1Grxn/6naix5/59D5WsZ3zpvRwep3WsKLP3PrMb1/LUeVAZ
 Hoxql+kSVTqakSx39qCryafSm980Xi3W+6MLY0U6vP0448OpPXN4eU7i3I8SJffqEBB6
 PLjw==
X-Gm-Message-State: AOAM531ZwFnPimm/9v6ppw9UYlUU+2J0HiiNSB54AiPa9SfQA6f+1qzq
 buBePI1joCvVh0cxsIREKSzsey9DE2ayB1uK+iw=
X-Google-Smtp-Source: ABdhPJwgNfM7b2UZgVPJnnlUV4BdyS78F8kAPr5fNml5z3/Al2+I/kobGylistYkJYci2iMC7fQizizRoOiPVQzy6JQ=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18849654otg.311.1606777241064; 
 Mon, 30 Nov 2020 15:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-38-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-38-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:00:29 -0500
Message-ID: <CADnq5_MiLffHWwF4tMh_y3CBkjcrH5ixZw-pwEyd=RBosrwZwA@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/pm/swsmu/smu12/renoir_ppt: Demote
 kernel-doc formatting abuse
To: Lee Jones <lee.jones@linaro.org>
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
Q2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEyL3Jlbm9pcl9wcHQuYyB8IDQg
KystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTIvcmVub2ly
X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMi9yZW5vaXJfcHB0LmMK
PiBpbmRleCA0NmM0NGYwYWJkZmI4Li5kMzY0MWE4ZWQ5OWMwIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTIvcmVub2lyX3BwdC5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMi9yZW5vaXJfcHB0LmMKPiBAQCAtMTcwLDcgKzE3
MCw3IEBAIHN0YXRpYyBpbnQgcmVub2lyX2luaXRfc21jX3RhYmxlcyhzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkKPiAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+ICB9Cj4KPiAtLyoqCj4gKy8qCj4g
ICAqIFRoaXMgaW50ZXJmYWNlIGp1c3QgZm9yIGdldHRpbmcgdWNsayB1bHRpbWF0ZSBmcmVxIGFu
ZCBzaG91bGQndCBpbnRyb2R1Y2UKPiAgICogb3RoZXIgbGlrZXdpc2UgZnVuY3Rpb24gcmVzdWx0
IGluIG92ZXJtdWNoIGNhbGxiYWNrLgo+ICAgKi8KPiBAQCAtNjU2LDcgKzY1Niw3IEBAIHN0YXRp
YyBpbnQgcmVub2lyX2dldF9wb3dlcihzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgdWludDMyX3Qg
KnZhbHVlKQo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+IC0vKioKPiArLyoKPiAgICogVGhp
cyBpbnRlcmZhY2UgZ2V0IGRwbSBjbG9jayB0YWJsZSBmb3IgZGMKPiAgICovCj4gIHN0YXRpYyBp
bnQgcmVub2lyX2dldF9kcG1fY2xvY2tfdGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIHN0
cnVjdCBkcG1fY2xvY2tzICpjbG9ja190YWJsZSkKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
