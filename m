Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E741C4741F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 18:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D082078E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7PPYcDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D082078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A0A6EDDE;
	Thu,  5 Nov 2020 18:31:50 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BB16EDD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 18:12:29 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 33so2852531wrl.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 10:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ic+OQ+6OsCx7cFXr4JAm3oNxN2Q6/gjUkT+ZKV1Hdn8=;
 b=z7PPYcDnQviEoc/NsFlZZbqRuYfpjYIygazPCOrkSgHhTI2t+ZgLTpPzO3Zl8poseB
 0rZqhEErwPkjLRMiEaevcCKADxlaiGS0QHxhYz6fV+wLpLfina9I0+F3jr2OSBSj+k5W
 SeqXNp0L+q2rgHZsfM9EmRUTPBi8upchSzrxXPOh9POtBeBFsOHeJyobHvKMeX7WP91k
 5HIkeJVdb32QoUO6rO+DBO7yBqn35/4s5G6uYQRkUqNie8K5vk0tuYMXCr9PZy3Hadxc
 VUmKB/NkmFLZDX1EdjK52aYAb4gkUdWu5L3I1ddLvzodlid/pTO69skeMQk4zG8pK5Zg
 oNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ic+OQ+6OsCx7cFXr4JAm3oNxN2Q6/gjUkT+ZKV1Hdn8=;
 b=myDoV98IgB/CHKLh7jnEIGYz7beQ5e+IY5taAoCCnaoJh5aL6WNT/oT+fEuEupBpMO
 WppJuOZQPhEsb2919h4lS2iYW4gc/hvyfoRSxXi8LrC0uZp3ZJuKrPZBAbo/f5OSYynC
 zqJoymTEpoqgBxx29Ec7PuS2ZsJimC8X7ILzjABvw2o6zmVybK1VGtQ40N9NoldctA9c
 2jL1uaDxZ0B/wFPJgq5Q61M4KJw1TIfdF/wYM9BgqPtZbEn4W/L5hyXVmj/7YpODMMjf
 /qkI4CxIBKvrLwjpWbFrQcYNX1lbpf20a+zxpavGh54KwfMKp4dnAi2ceCVrm6wlq+yr
 tBqA==
X-Gm-Message-State: AOAM5326ef+hZMpYFGieFS+bmB9oB8OXkOJXEuyl+ib0RF/tvq+Wzs5Q
 gayr6+HOF/UBtgtaIy0FqmeUfQ==
X-Google-Smtp-Source: ABdhPJwTA5RTYhIiZWN3Q1b8BKggEpACTRVotMVkDJ/e+Bs6VZmMVWLdr8tXiLM5Q6NXEuVyXn6Zbw==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr4571549wrq.106.1604599948074; 
 Thu, 05 Nov 2020 10:12:28 -0800 (PST)
Received: from dell ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id s12sm3394261wmc.6.2020.11.05.10.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 10:12:27 -0800 (PST)
Date: Thu, 5 Nov 2020 18:12:23 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/19] [Set 1] Rid W=1 warnings from GPU
Message-ID: <20201105181223.GQ4488@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105163831.GA86540@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105163831.GA86540@ravnborg.org>
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
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <a.hajda@samsung.com>, Huang Rui <ray.huang@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Gareth Hughes <gareth@valinux.com>, Fabio Estevam <festevam@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, David Francis <David.Francis@amd.com>,
 Jingoo Han <jg1.han@samsung.com>, amd-gfx@lists.freedesktop.org,
 Rob Clark <rob.clark@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-media@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Jonas Karlman <jonas@kwiboo.se>, Sascha Hauer <s.hauer@pengutronix.de>,
 linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, Jernej Skrabec <jernej.skrabec@siol.net>,
 Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Shawn Guo <shawnguo@kernel.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAwNSBOb3YgMjAyMCwgU2FtIFJhdm5ib3JnIHdyb3RlOgoKPiBIaSBMZWUuCj4gCj4g
T24gVGh1LCBOb3YgMDUsIDIwMjAgYXQgMDI6NDQ6NThQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+ID4gVGhpcyBzZXQgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0byBj
bGVhbi11cCBXPTEKPiA+IGtlcm5lbCBidWlsZHMsIHdoaWNoIGFyZSBjdXJyZW50bHkgb3Zlcndo
ZWxtaW5nbHkgcmlkZGxlZCB3aXRoCj4gPiBuaWdnbHkgbGl0dGxlIHdhcm5pbmdzLgo+IAo+IFRo
YW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMuCj4gCj4gPiBUaGVyZSBhcmUgNTAwMCB3YXJuaW5n
cyB0byB3b3JrIHRocm91Z2guCj4gPiAKPiA+IEl0IHdpbGwgdGFrZSBhIGNvdXBsZSBtb3JlIHNl
dHMuCj4gOi0pCj4gCj4gPiAgIGdwdTogZHJtOiBwYW5lbDogcGFuZWwtc2ltcGxlOiBGaXggJ3N0
cnVjdCBwYW5lbF9kZXNjJ3MgaGVhZGVyCj4gSSBoYXZlIGEgcGF0Y2ggaGVyZSB0aGF0IGlubGlu
ZSB0aGUgY29tbWVudHMgLSBhbmQgZml4IHRoZSB3YXJuaW5nIGFzIGEKPiBzaWRlIGVmZmVjdC4g
SSB3aWxsIGdldCBpdCBwb3N0ZWQgdG9uaWdodCBhcyB0aGlzIGlzIGJldHRlci4KPiAKPiA+ICAg
Z3B1OiBkcm06IGJyaWRnZTogYW5hbG9naXg6IGFuYWxvZ2l4X2RwX3JlZzogUmVtb3ZlIHVudXNl
ZCBmdW5jdGlvbgo+ID4gICAgICdhbmFsb2dpeF9kcF93cml0ZV9ieXRlX3RvX2RwY2QnCj4gV2hl
biBJIGxvb2tlZCBhdCBoaXMgSSBoYWQgYW5vdGhlciB1bnVzZWQgZnVuY3Rpb24gYWZ0ZXIgcmVt
b3ZpbmcgdGhlCj4gZmlyc3QuCj4gCj4gPiAgIGdwdTogZHJtOiBwYW5lbDogcGFuZWwtaWxpdGVr
LWlsaTkzMjI6IERlbW90ZSBub24tY29uZm9ybWFudAo+ID4gICAgIGtlcm5lbC1kb2MgaGVhZGVy
Cj4gQWdyZWUgb24gdGhpcyBzaW1wbGUgYXBwcm9jaCwgd2lsbCBhcHBseS4KPiAKPiA+ICAgZ3B1
OiBkcm06IGJyaWRnZTogYW5hbG9naXg6IGFuYWxvZ2l4X2RwX3JlZzogUmVtb3ZlIHVudXNlZCBm
dW5jdGlvbgo+ID4gICAgICdhbmFsb2dpeF9kcF9zdGFydF9hdXhfdHJhbnNhY3Rpb24nCj4gT0ss
IHRoaXMgd2FzIHRoZSBvbmUgSSByZWZlcnJlZCB0byBhYm92ZS4gVGhleSBzaG91bGQgYmUgc3F1
YXNoZWQgaW50bwo+IG9uZSBwYXRjaC4KCkkgY2FuIHNxdWFzaCB0aGVtIGlmIHlvdSBwcmVmZXIu
CgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVs
b3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJt
IFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
