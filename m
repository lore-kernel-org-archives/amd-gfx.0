Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B42C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B010523122
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B010523122
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349178952F;
	Tue, 12 Jan 2021 22:34:38 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFB48952F;
 Tue, 12 Jan 2021 22:34:37 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id 9so62856oiq.3;
 Tue, 12 Jan 2021 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uWV9ceqZFVv/wAByH++CvwhWZufrTBFrlInqOCZZ3L0=;
 b=IRFlsM7In+J88xzxIo6EfAP+qdV43Z98KaGEJCXm4bM3L3HsrZ857Vmxfy4MFMXUkC
 5KyhZVQzjHXFkY4Sbr4GrlQcTPbPsyd84LlfE786B3EDvEvOXpg1Zlwc5OlytTSwuIAQ
 DvU8GNlkw+s9O90esE5RhALzBkw1/Uiov+m4cQnwf9cpz0rmZ5XKYPVSgah6tYCDcBOu
 i0Jnc2AoFcrjKG5b/srqQoNcyiVNPE0W4Hs0Qw5JNxDGiFxQ94x47WevExkij/t6VIEs
 7PNhOxbXAwhsJxs8HV2HhE5cE/QZewmJlE/06bT39szk5749dgp2YsEDLAQRxkV5BLOO
 9Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uWV9ceqZFVv/wAByH++CvwhWZufrTBFrlInqOCZZ3L0=;
 b=SVKf+NIfC26XAr/ZUMjtHakWH/2eT49bjfAPx23bg3+H/dz1QT8xnZrtqYH7kMLWBX
 TT0xsvvp0HvRe251kjlQ74PW1Tf18CmNJlh8QnWHENFFF+tGF4bjlyPiaTgkz4M0USXi
 S+LNVeqZVEssUlwLRhEMWEe6qx4/gjXELiirhnadUX5wRc3lLyoc1z7Z6ph1nyH1pZHB
 EflcwJhOknrYBchb0GS2NfjG/E7i+cJ0jAyergF2iREKbmN8Zx35AwT1QH/lbIOMQZM8
 HegQPeZuQ8ccUeDNaBscYg2vsxDitCjMqhVHxefQp25WEIdiTroLwcciArsGf6TMLYX1
 98Qg==
X-Gm-Message-State: AOAM533oyGDMK04uZ6Bh/PqFw8Ma51L1jwWBc/Jxs+8zOYW2v4PZENDS
 PKztRMaJ+IXl8V5BF86x8juz0H+FmgY4fA/TClo=
X-Google-Smtp-Source: ABdhPJz3936rIaftzr3hfmlwXHzQq9qFMfV8P5SSAADDlVlFzMl8vsY/z9JXkerRylQuSkGKDDnyx8CDbPRzWRkY6lM=
X-Received: by 2002:aca:6202:: with SMTP id w2mr795855oib.5.1610490876691;
 Tue, 12 Jan 2021 14:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-32-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-32-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 17:34:22 -0500
Message-ID: <CADnq5_OyFORY9gibkiNmfTLNMDQOd_Y=cO1cWo1UWM6m2qtMyA@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/display/dc/dce110/dce110_mem_input_v:
 Include our own header, containing prototypes
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMjoyMCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlMTEwL2RjZTExMF9tZW1faW5wdXRfdi5jOjEwMzQ6Njogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhkY2UxMTBfbWVtX2lucHV0X3ZfY29uc3RydWN04oCZIFstV21pc3Np
bmctcHJvdG90eXBlc10KPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1k
LmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1i
eTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpB
bGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTEx
MF9tZW1faW5wdXRfdi5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNl
MTEwX21lbV9pbnB1dF92LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9tZW1faW5wdXRfdi5jCj4gaW5kZXggMTliMTk3NjEzOWI2OS4uOGJiYjQ5OTA2N2Y3
NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2Rj
ZTExMF9tZW1faW5wdXRfdi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjZTExMC9kY2UxMTBfbWVtX2lucHV0X3YuYwo+IEBAIC0zNCw2ICszNCw3IEBACj4gICNpbmNs
dWRlICJpbmMvZGNlX2NhbGNzLmgiCj4KPiAgI2luY2x1ZGUgImRjZS9kY2VfbWVtX2lucHV0Lmgi
Cj4gKyNpbmNsdWRlICJkY2UxMTBfbWVtX2lucHV0X3YuaCIKPgo+ICBzdGF0aWMgdm9pZCBzZXRf
ZmxpcF9jb250cm9sKAo+ICAgICAgICAgc3RydWN0IGRjZV9tZW1faW5wdXQgKm1lbV9pbnB1dDEx
MCwKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
