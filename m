Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA552C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5769620719
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxte3824"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5769620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B345289733;
	Mon,  9 Nov 2020 08:59:17 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072B06E0FF
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Nov 2020 15:13:48 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c9so4183690wml.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Nov 2020 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Fe6CFZHB4eN2243CFprUL/n+G4vxgYInJJ6wj8YKWBk=;
 b=yxte38245MaYCKkeFpeoucGOLM90V4xE3nz3Cnj3+Pam0t1F1fbMS9wC9MundIMK2H
 UPpv/s3qUlbyQ01axD3II1Z2BuBIDINgXKwK2bhp+vaisZiHk8VTRAbqY8tzzKxgEU9M
 E3GiuyMz1aPvkPSGfy0Rw0HBumWxid8ptFtJOzcgegABv758cPFg4Fi2/SarChNNob1s
 E2C//PdsYp1Sok8XurQ1QdtUexRfPcjHbcN37l8HpHhDpfsyGgWi5n0VtIOA0z+mpBhk
 yTJVLKMMUL/ibfnKoPsTUVZ+PiKhaeuOMpHLv2gghWo190HmeMHu687awnTuITzS+hTM
 Fouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Fe6CFZHB4eN2243CFprUL/n+G4vxgYInJJ6wj8YKWBk=;
 b=th6h+FYxOa0mA49q4h9rgLDnalHean9hYY9Rfqrf0t16hJi4DJGnXcUBVPHSTUcXTT
 rl1io/AamaSe2SYKQ0WvXXM+Sz8yBGus8ll4qAK4HZt8UmY0Wm1e1C2l8CE/J7w7nujT
 o3CWxVuP23XueJYaA57pdx2jrG9Ac42nPH5gT2qWpKsdxIWVM1Lg86jh+AM05bumsLIE
 i50sv04yh4QIP1InKdGQcaiPBU7Euz+Kny0q9JlisgoYJ/Oqolj/Iu37vGf2kAktBtxh
 8Wu3cTki81kaJWrWmQwbPx36wII9ciX8nkwFGG3QGUMf5jWq4klRjri32jQSJMYM1CPW
 tbrA==
X-Gm-Message-State: AOAM533lM+t/+Y8Uc/4WhC1M+dzfLqlhJD4ECy3EmoEvWGZYL5ZUc9mB
 Pp1zX4uDyQ66k/RmOUsTutKFhQ==
X-Google-Smtp-Source: ABdhPJy6Ii661kV3KJTNGTIaBkDIcEjLcbtut88fwfWuPoGhumpi22jfpd/9QuNPLMHXcJ8vc855nQ==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr4969499wma.57.1604762026726; 
 Sat, 07 Nov 2020 07:13:46 -0800 (PST)
Received: from dell ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id l16sm6447087wrr.83.2020.11.07.07.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 07:13:46 -0800 (PST)
Date: Sat, 7 Nov 2020 15:13:42 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201107151342.GQ2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <20201107142919.GB1014611@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201107142919.GB1014611@ravnborg.org>
X-Mailman-Approved-At: Mon, 09 Nov 2020 08:59:16 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCAwNyBOb3YgMjAyMCwgU2FtIFJhdm5ib3JnIHdyb3RlOgoKPiBIaSBMZWUsCj4gCj4g
T24gRnJpLCBOb3YgMDYsIDIwMjAgYXQgMDk6NDk6NDdQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4g
PiAKPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYzoyMjY6IHdhcm5pbmc6
IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Rldicgbm90IGRlc2NyaWJlZCBpbiAncmFk
ZW9uX2luZm9faW9jdGwnCj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6
MjI2OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdyZGV2JyBkZXNjcmlwdGlv
biBpbiAncmFkZW9uX2luZm9faW9jdGwnCj4gPiAKPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4Lmll
Pgo+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyB8IDIgKy0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKPiA+IGluZGV4IDBkOGZiYWJmZmNlYWQu
LjIxYzIwNjc5NWMzNjQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9rbXMuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMK
PiA+IEBAIC0yMTMsNyArMjEzLDcgQEAgc3RhdGljIHZvaWQgcmFkZW9uX3NldF9maWxwX3JpZ2h0
cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+ID4gIC8qKgo+ID4gICAqIHJhZGVvbl9pbmZvX2lv
Y3RsIC0gYW5zd2VyIGEgZGV2aWNlIHNwZWNpZmljIHJlcXVlc3QuCj4gPiAgICoKPiA+IC0gKiBA
cmRldjogcmFkZW9uIGRldmljZSBwb2ludGVyCj4gPiArICogQGRldjogcmFkZW9uIGRldmljZSBw
b2ludGVyCj4gPiAgICogQGRhdGE6IHJlcXVlc3Qgb2JqZWN0Cj4gPiAgICogQGZpbHA6IGRybSBm
aWxwCj4gPiAgICoKPiAKPiBEZWxldGUgYWxsIHRoZSBrZXJuZWwtZG9jIGFubm90YXRpb24gYXMg
d2UgZG8gbm90IHB1bGwgdGhpcyBmaWxlIGludG8KPiB0aGUga2VybmVsLWRvYyBhbnl3YXkuCj4g
Cj4gS2VlcCB0aGUgLyogQW5zd2VyIGEgZGV2aWNlIHNwZWNpZmljIHJlcXVlc3QgKi8gcGFydC4K
PiAKPiBBdCBsZWFzdCB0aGF0cyB3aGF0IEkgc2VlIGFzIHRoZSBiZXN0IHdheSB0byBkZWFsIHdp
dGggaXQuCgpEZW1vdGluZyBhbGwgaGVhZGVycywgZXZlbiBpZiB0aGV5IGFyZSBjb25mb3JtYW50
LCBpdCBub3QgdGhlIHdheSB0bwpnby4gIFNvbWUgY29udHJpYnV0b3JzL21haW50YWluZXJzIHBy
ZWZlciB0byBrZWVwIHRoZSBrZXJuZWwtZG9jCihwcmV0dHkgY29sb3VycywgYXV0b21hdGVkIGNo
ZWNraW5nIFthIGxhLCB0aGlzIHBhdGNoIV0gYW5kIHRoZS1saWtlKQpmb3JtYXR0aW5nLCBldmVu
IGlmIHRoZXkgYXJlIG5vdCBkaXJlY3RseSByZWZlcmVuY2VkIGZyb20KL0RvY3VtZW50YXRpb24u
CgpGb3Igbm93LCBzbyBsb25nIGFzIHRoZSBidWlsZCBpcyBoYXBweSwgSSBhbSBoYXBweS4KCklm
IHlvdSB3aXNoIHRvIG1ha2UgdGhlIGJ1aWxkIHVuaGFwcHkgYWJvdXQgdGhpcywgeW91IHNob3Vs
ZCB0YWtlIHVwCnRoZSBhcmd1bWVudCB0byBlbmNvbXBhc3MgYHNjcmlwdHMvZmluZC11bnVzZWQt
ZG9jcy5zaGAgaW50byBpdC4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRlY2hu
aWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIg
fCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
