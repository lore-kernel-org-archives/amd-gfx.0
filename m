Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E29C55179
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 18:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2052078E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbOOCp73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2052078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7493E6EDE3;
	Thu,  5 Nov 2020 18:31:51 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FCD89F63
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 18:24:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id k18so2544707wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=7e8j21DIlVBcunOHbbwXMePhmrXVH5+IQyI8wkPXuKI=;
 b=zbOOCp73xw34Lh9ZE9TmMA17YqxGcG/n++dEYWrXi9dqE1MOd0lEYj1vvi+UNj9QUQ
 90lixqIWlw9UB6wc0PrwkjTCKT1+fi4eU5o9FOJa/uxXVDX4fXv6frcTQ0mf/t0UsWkd
 0EN+1xr8MAL6U/VtZ+d7h8NNR/glGlfmPFguvEacM6hMsXANML7oKQ6BSp02R7Lp5C3V
 MWHYT9DB3OhymND7jnk6G68pw69bodQQf/HsG/77bvSA3n47x2JVL9J1TH4tAs0ErvBk
 runK6vWTCca3VQCIQVr/ARVEAdg4c3GzpSYqYbVg+b3R0XPgJ+et8BXxm/gMGiActXg2
 A7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7e8j21DIlVBcunOHbbwXMePhmrXVH5+IQyI8wkPXuKI=;
 b=Ifi3GeYdlVwl9LPEdun2olSkiipM/WOuSv0HmUUsweOZrPEqI3PzhtMTGCP9zhdNp7
 eVTc/MjxaMZmcvPFmMsE7wDJOE45fTRGp0PuzCKIqQ9XPv3wuI3ye1+NtHeHeakvFsAu
 ZIkdy7poNrbOvL4k9RX0jD2yysk9960kTjwikvy/WFd0kBs2V65pjZgtrApsKI7cDnDV
 MF4Hb/jomswmc00DVtFuKdGKyJ3xsahTTwrce63DGBZU8DB+tzDvGMpO4plW5+ixxa/O
 RBHvVdiMvC5Ard3B+LaxQgaikONaZILI/Mx33jVnPUbAITsmm++mjBSrMkISppJjH54b
 wO4Q==
X-Gm-Message-State: AOAM530kHC2N6VyTcQVyGuWfazbIqGnKSp/FmjE1Cajvsm2s/HB+PlPx
 DlHSRN63Wei5chcvRhlrEi/cEA==
X-Google-Smtp-Source: ABdhPJwYVvq6FoC+0cr98mQMZnvjXjAJewz6nP8jiRlkwCTioWlJ7DNR13bFrLL5RbyIiktf3wZlPw==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr4062598wmb.1.1604600692803; 
 Thu, 05 Nov 2020 10:24:52 -0800 (PST)
Received: from dell ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id z191sm3751615wme.30.2020.11.05.10.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 10:24:51 -0800 (PST)
Date: Thu, 5 Nov 2020 18:24:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 00/19] [Set 1] Rid W=1 warnings from GPU
Message-ID: <20201105182449.GR4488@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105164841.GH485884@ulmo> <20201105181053.GP4488@dell>
 <CAKMK7uEyW_KJ1qC3gLASDe4Qyk_5UMr+yCu7VVVdAq+Z0J6RwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uEyW_KJ1qC3gLASDe4Qyk_5UMr+yCu7VVVdAq+Z0J6RwQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 05 Nov 2020 18:31:49 +0000
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Huang Rui <ray.huang@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Gareth Hughes <gareth@valinux.com>, Fabio Estevam <festevam@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 David Francis <David.Francis@amd.com>, Jingoo Han <jg1.han@samsung.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Rob Clark <rob.clark@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, NXP Linux Team <linux-imx@nxp.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonas Karlman <jonas@kwiboo.se>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 linux-tegra <linux-tegra@vger.kernel.org>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Jason Yan <yanaijie@huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alex Deucher <alexander.deucher@amd.com>, Shawn Guo <shawnguo@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAwNSBOb3YgMjAyMCwgRGFuaWVsIFZldHRlciB3cm90ZToKCj4gT24gVGh1LCBOb3Yg
NSwgMjAyMCBhdCA3OjEwIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IE9uIFRodSwgMDUgTm92IDIwMjAsIFRoaWVycnkgUmVkaW5nIHdyb3RlOgo+ID4K
PiA+ID4gT24gVGh1LCBOb3YgMDUsIDIwMjAgYXQgMDI6NDQ6NThQTSArMDAwMCwgTGVlIEpvbmVz
IHdyb3RlOgo+ID4gPiA+IFRoaXMgc2V0IGlzIHBhcnQgb2YgYSBsYXJnZXIgZWZmb3J0IGF0dGVt
cHRpbmcgdG8gY2xlYW4tdXAgVz0xCj4gPiA+ID4ga2VybmVsIGJ1aWxkcywgd2hpY2ggYXJlIGN1
cnJlbnRseSBvdmVyd2hlbG1pbmdseSByaWRkbGVkIHdpdGgKPiA+ID4gPiBuaWdnbHkgbGl0dGxl
IHdhcm5pbmdzLgo+ID4gPiA+Cj4gPiA+ID4gVGhlcmUgYXJlIDUwMDAgd2FybmluZ3MgdG8gd29y
ayB0aHJvdWdoLgo+ID4gPiA+Cj4gPiA+ID4gSXQgd2lsbCB0YWtlIGEgY291cGxlIG1vcmUgc2V0
cy4KPiA+ID4gPgo+ID4gPiA+IExlZSBKb25lcyAoMTkpOgo+ID4gPiA+ICAgZ3B1OiBob3N0MXg6
IGJ1czogQWRkIG1pc3NpbmcgZGVzY3JpcHRpb24gZm9yICdkcml2ZXInCj4gPiA+ID4gICBncHU6
IGlwdS12MzogaXB1LWRpOiBTdHJpcCBvdXQgMiB1bnVzZWQgJ2RpX3N5bmNfY29uZmlnJyBlbnRy
aWVzCj4gPiA+ID4gICBncHU6IGRybTogaW14OiBpcHV2My1wbGFuZTogTWFyayAnY3J0Y19zdGF0
ZScgYXMgX19hbHdheXNfdW51c2VkCj4gPiA+ID4gICBncHU6IGRybTogb21hcGRybTogb21hcF9p
cnE6IEZpeCBhIGNvdXBsZSBvZiBkb2Mtcm90IGlzc3Vlcwo+ID4gPiA+ICAgZ3B1OiBkcm06IHNl
bGZ0ZXN0czogdGVzdC1kcm1fbW06IE1hcmsgJ2hvbGVfZW5kJyBhcyBhbHdheXNfdW51c2VkCj4g
PiA+ID4gICBncHU6IGRybTogc2NoZWR1bGVyOiBzY2hlZF9tYWluOiBQcm92aWRlIG1pc3Npbmcg
ZGVzY3JpcHRpb24gZm9yCj4gPiA+ID4gICAgICdzY2hlZCcgcGFyYW10ZXIKPiA+ID4gPiAgIGdw
dTogZHJtOiBzY2hlZHVsZXI6IHNjaGVkX2VudGl0eTogRGVtb3RlIG5vbi1jb25mb3JtYW50IGtl
cm5lbC1kb2MKPiA+ID4gPiAgICAgaGVhZGVycwo+ID4gPiA+ICAgZ3B1OiBkcm06IG9tYXBkcm06
IGRzczogZHNpOiBSZXdvcmsgYW5kIHJlbW92ZSBhIGZldyB1bnVzZWQgdmFyaWFibGVzCj4gPiA+
ID4gICBncHU6IGRybTogc2VsZnRlc3RzOiB0ZXN0LWRybV9mcmFtZWJ1ZmZlcjogUmVtb3ZlIHNl
dCBidXQgdW51c2VkCj4gPiA+ID4gICAgIHZhcmlhYmxlICdmYicKPiA+ID4gPiAgIGdwdTogZHJt
OiB0dG06IHR0bV9ibzogRml4IG9uZSBmdW5jdGlvbiBoZWFkZXIgLSBkZW1vdGUgbG90cyBvZgo+
ID4gPiA+ICAgICBrZXJuZWwtZG9jIGFidXNlcwo+ID4gPiA+ICAgZ3B1OiBkcm06IHBhbmVsOiBw
YW5lbC1zaW1wbGU6IEZpeCAnc3RydWN0IHBhbmVsX2Rlc2MncyBoZWFkZXIKPiA+ID4gPiAgIGdw
dTogZHJtOiBicmlkZ2U6IGFuYWxvZ2l4OiBhbmFsb2dpeF9kcF9yZWc6IFJlbW92ZSB1bnVzZWQg
ZnVuY3Rpb24KPiA+ID4gPiAgICAgJ2FuYWxvZ2l4X2RwX3dyaXRlX2J5dGVfdG9fZHBjZCcKPiA+
ID4gPiAgIGdwdTogZHJtOiB0dG06IHR0bV90dDogRGVtb3RlIGtlcm5lbC1kb2MgaGVhZGVyIGZv
cm1hdCBhYnVzZXMKPiA+ID4gPiAgIGdwdTogZHJtOiBzZWxmdGVzdHM6IHRlc3QtZHJtX2RwX21z
dF9oZWxwZXI6IFBsYWNlICdzdHJ1Y3QKPiA+ID4gPiAgICAgZHJtX2RwX3NpZGViYW5kX21zZ19y
ZXFfYm9keScgb250byB0aGUgaGVhcAo+ID4gPiA+ICAgZ3B1OiBkcm06IHJhZGVvbjogcmFkZW9u
X2RydjogUmVtb3ZlIHVudXNlZCB2YXJpYWJsZSAncmV0Jwo+ID4gPiA+ICAgZ3B1OiBkcm06IHBh
bmVsOiBwYW5lbC1pbGl0ZWstaWxpOTMyMjogRGVtb3RlIG5vbi1jb25mb3JtYW50Cj4gPiA+ID4g
ICAgIGtlcm5lbC1kb2MgaGVhZGVyCj4gPiA+ID4gICBncHU6IGRybTogcmFkZW9uOiByYWRlb25f
ZGV2aWNlOiBGaXggYSBidW5jaCBvZiBrZXJuZWwtZG9jCj4gPiA+ID4gICAgIG1pc2RlbWVhbm91
cnMKPiA+ID4gPiAgIGdwdTogZHJtOiBhbWQ6IGFtZGdwdTogYW1kZ3B1OiBNYXJrIGdsb2JhbCB2
YXJpYWJsZXMgYXMgX19tYXliZV91bnVzZWQKPiA+ID4gPiAgIGdwdTogZHJtOiBicmlkZ2U6IGFu
YWxvZ2l4OiBhbmFsb2dpeF9kcF9yZWc6IFJlbW92ZSB1bnVzZWQgZnVuY3Rpb24KPiA+ID4gPiAg
ICAgJ2FuYWxvZ2l4X2RwX3N0YXJ0X2F1eF90cmFuc2FjdGlvbicKPiA+ID4KPiA+ID4gQXMgY29t
bWVudGVkIG9uIHRoZSBvdGhlciBwYXRjaGVzLCB0aGUgc3ViamVjdCBwcmVmaXhlcyBvbiBtb3N0
IG9mIHRoZXNlCj4gPiA+IGxvb2sgd3JvbmcsIGJ1dCBpdCdzIGdlbmVyYWxseSBhIG5pY2UgY2xl
YW51cC4KPiA+Cj4gPiBUaGUgcHJlZml4ZXMgYXJlIGF1dG9tYXRlZC4gIEknbGwgYWRkIHRoaXMg
dG8gbXkgbGlzdCBvZiBhd2t3YXJkCj4gPiBzdWJzeXN0ZW1zIGFuZCBnbyB0aHJvdWdoIHRoZW0g
YWxsIG1hbnVhbGx5IGFnYWluIHRvbW9ycm93LiA6RAo+IAo+IHRiaCBmb3IgYXV0bW9hdGlvbiB0
aGV5IGxvb2sgcmVhbGx5IGdvb2QgOi0pCgpPbmx5IHRoZSBwcmVmaXhlcyBhcmUgYXV0b21hdGVk
IHVuZm9ydHVuYXRlbHkuIDopCgo+IEknZCBzYXkgaWYgeW91IHJlcGxhY2UgdGhlIGludGVybWVk
aWF0ZSAiOiAiIHdpdGgganVzdCBhIC8geW91J2xsIGJlCj4gcGVyZmVjdGx5IGluIHN0eWxlIGZv
ciBkcml2ZXJzL2dwdS4gQnV0IHJlYWxseSBJIHRoaW5rIGl0J3Mgb2sgYXMtaXMsCgpJdCdzIHVw
IHRvIHlvdS4gIE1ha2UgdGhlIGNhbGwgYW5kIEknbGwgYWJpZGUuCgo+IGltbyBubyBuZWVkIHRv
IGNoYW5nZSBzaW5jZSB0aGlzIGlzIGEgZ2lhbnRpYyB0cmVlIHdpZGUgZWZmb3J0LgoKWWVzLCB5
b3UncmUgbm90IGtpZGRpbmcsIGFuZCB0aGFua3MgZm9yIG5vdGljaW5nLgoKT25seSAxMCwwMDAg
KGZyb20gMTgsMDAwKSBtb3JlIHRvIGdvIHRob3VnaC4gOkQKCkdQVSBpcyBhIGJpZ2d5ICg1LDAw
MCksIGFsdGhvdWdoIG9uZSBwYXRjaCBpbiBbU2V0IDJdIGZpeGVzIDIsMDAwIGluCm9uZSBoaXQs
IHdoaWNoIGlzIGdyZWF0ISAgSSdsbCBwcm9iYWJseSBzdWJtaXQgdGhhdCB0b21vcnJvdy4KCi0t
IApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVy
IFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29D
cwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
