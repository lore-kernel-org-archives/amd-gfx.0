Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED888C55179
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEF42078E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSfGiLj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEF42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6EE6EDAA;
	Thu,  5 Nov 2020 15:41:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6326ED84
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 14:52:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id h22so1891937wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0KKycVwNcN4IWLbGSyRzWYkLNsHKS3R2bLFdIm3mqe8=;
 b=WSfGiLj1AtIr3Mr5iw/J8/JMfzybNz781V7wTogkME2iCY5pRK2wWg8HlsZzIOtkKq
 ki8wRPLECzRJASu7rk0b9PjAenZiRTjua9ICZPJr3zEiPWj9eU6rW7eeQ8gn4kE7QmLd
 OUuXIAsL3nHS/0kw0QQxS9RtHovm/+2FAajjJ6RnVPCQoCOm9kUje1d6B0A3OuCABiO4
 1HGZh+RJgtcoPMqxtU+8zAIiTxumn+ZHI/bp4XSajjur0ftLr49rsOzF3E5xPcB4FRI2
 oa+NugSZZR1XLISINFrM3XCDcp7LlzxFloSAGS0DmgRFC5ruF56/olBaYTLmwJj532ea
 NHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0KKycVwNcN4IWLbGSyRzWYkLNsHKS3R2bLFdIm3mqe8=;
 b=qdw316w4Q6FZCWETJVdvttv4clAl82P5iZ5jDn9bjggWvawwIEkYHAVYLqSjykvt06
 X3sxDiG7ENiZz1xt6dz+Kuew3Loj+5cdtNuFfz4+AS2WDJnJVZUvxXfwZoXUY2H24is+
 rY+1vum2ue6mM4Vklpcd6EshsB2hVMOfB27ib6zRI9S518ek5OYGNAvG31MDOfHhTUrz
 PhK7sKG3Uu6/QTryKAcEB02Z8sni4UF7Nhnrcjx3dhDNVZoS3Z8tsFqPPmVA2jsKWg47
 GOSjqLBTVq7YztZvtVqA+QbtPVeSi94GnyxKEDwCHeqiU7HMSpKCLq0bTbPadeLEV3bD
 6uyw==
X-Gm-Message-State: AOAM5313SzQkGlrZaoo3rO2xXb+37n2dc+J2RAiAQ+eXDXNFb4FAuRAG
 L7bfc4GE1+8fPoyufuoP2jdcWA==
X-Google-Smtp-Source: ABdhPJwv3vBJOFuk/npzxyZAo4HZ1+ZwOqI3+/ois9rIDQtSy2R+EWO6d4lgC3qrR1jiNCMNVeB9BA==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr3234684wmu.85.1604587934709; 
 Thu, 05 Nov 2020 06:52:14 -0800 (PST)
Received: from dell.default ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 06:52:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 00/19] [Set 1] Rid W=1 warnings from GPU
Date: Thu,  5 Nov 2020 14:44:58 +0000
Message-Id: <20201105144517.1826692-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Nov 2020 15:41:05 +0000
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
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Gareth Hughes <gareth@valinux.com>, Fabio Estevam <festevam@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 David Francis <David.Francis@amd.com>, Jingoo Han <jg1.han@samsung.com>,
 amd-gfx@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, NXP Linux Team <linux-imx@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
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

VGhpcyBzZXQgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0byBjbGVhbi11
cCBXPTEKa2VybmVsIGJ1aWxkcywgd2hpY2ggYXJlIGN1cnJlbnRseSBvdmVyd2hlbG1pbmdseSBy
aWRkbGVkIHdpdGgKbmlnZ2x5IGxpdHRsZSB3YXJuaW5ncy4KClRoZXJlIGFyZSA1MDAwIHdhcm5p
bmdzIHRvIHdvcmsgdGhyb3VnaC4KCkl0IHdpbGwgdGFrZSBhIGNvdXBsZSBtb3JlIHNldHMuCgpM
ZWUgSm9uZXMgKDE5KToKICBncHU6IGhvc3QxeDogYnVzOiBBZGQgbWlzc2luZyBkZXNjcmlwdGlv
biBmb3IgJ2RyaXZlcicKICBncHU6IGlwdS12MzogaXB1LWRpOiBTdHJpcCBvdXQgMiB1bnVzZWQg
J2RpX3N5bmNfY29uZmlnJyBlbnRyaWVzCiAgZ3B1OiBkcm06IGlteDogaXB1djMtcGxhbmU6IE1h
cmsgJ2NydGNfc3RhdGUnIGFzIF9fYWx3YXlzX3VudXNlZAogIGdwdTogZHJtOiBvbWFwZHJtOiBv
bWFwX2lycTogRml4IGEgY291cGxlIG9mIGRvYy1yb3QgaXNzdWVzCiAgZ3B1OiBkcm06IHNlbGZ0
ZXN0czogdGVzdC1kcm1fbW06IE1hcmsgJ2hvbGVfZW5kJyBhcyBhbHdheXNfdW51c2VkCiAgZ3B1
OiBkcm06IHNjaGVkdWxlcjogc2NoZWRfbWFpbjogUHJvdmlkZSBtaXNzaW5nIGRlc2NyaXB0aW9u
IGZvcgogICAgJ3NjaGVkJyBwYXJhbXRlcgogIGdwdTogZHJtOiBzY2hlZHVsZXI6IHNjaGVkX2Vu
dGl0eTogRGVtb3RlIG5vbi1jb25mb3JtYW50IGtlcm5lbC1kb2MKICAgIGhlYWRlcnMKICBncHU6
IGRybTogb21hcGRybTogZHNzOiBkc2k6IFJld29yayBhbmQgcmVtb3ZlIGEgZmV3IHVudXNlZCB2
YXJpYWJsZXMKICBncHU6IGRybTogc2VsZnRlc3RzOiB0ZXN0LWRybV9mcmFtZWJ1ZmZlcjogUmVt
b3ZlIHNldCBidXQgdW51c2VkCiAgICB2YXJpYWJsZSAnZmInCiAgZ3B1OiBkcm06IHR0bTogdHRt
X2JvOiBGaXggb25lIGZ1bmN0aW9uIGhlYWRlciAtIGRlbW90ZSBsb3RzIG9mCiAgICBrZXJuZWwt
ZG9jIGFidXNlcwogIGdwdTogZHJtOiBwYW5lbDogcGFuZWwtc2ltcGxlOiBGaXggJ3N0cnVjdCBw
YW5lbF9kZXNjJ3MgaGVhZGVyCiAgZ3B1OiBkcm06IGJyaWRnZTogYW5hbG9naXg6IGFuYWxvZ2l4
X2RwX3JlZzogUmVtb3ZlIHVudXNlZCBmdW5jdGlvbgogICAgJ2FuYWxvZ2l4X2RwX3dyaXRlX2J5
dGVfdG9fZHBjZCcKICBncHU6IGRybTogdHRtOiB0dG1fdHQ6IERlbW90ZSBrZXJuZWwtZG9jIGhl
YWRlciBmb3JtYXQgYWJ1c2VzCiAgZ3B1OiBkcm06IHNlbGZ0ZXN0czogdGVzdC1kcm1fZHBfbXN0
X2hlbHBlcjogUGxhY2UgJ3N0cnVjdAogICAgZHJtX2RwX3NpZGViYW5kX21zZ19yZXFfYm9keScg
b250byB0aGUgaGVhcAogIGdwdTogZHJtOiByYWRlb246IHJhZGVvbl9kcnY6IFJlbW92ZSB1bnVz
ZWQgdmFyaWFibGUgJ3JldCcKICBncHU6IGRybTogcGFuZWw6IHBhbmVsLWlsaXRlay1pbGk5MzIy
OiBEZW1vdGUgbm9uLWNvbmZvcm1hbnQKICAgIGtlcm5lbC1kb2MgaGVhZGVyCiAgZ3B1OiBkcm06
IHJhZGVvbjogcmFkZW9uX2RldmljZTogRml4IGEgYnVuY2ggb2Yga2VybmVsLWRvYwogICAgbWlz
ZGVtZWFub3VycwogIGdwdTogZHJtOiBhbWQ6IGFtZGdwdTogYW1kZ3B1OiBNYXJrIGdsb2JhbCB2
YXJpYWJsZXMgYXMgX19tYXliZV91bnVzZWQKICBncHU6IGRybTogYnJpZGdlOiBhbmFsb2dpeDog
YW5hbG9naXhfZHBfcmVnOiBSZW1vdmUgdW51c2VkIGZ1bmN0aW9uCiAgICAnYW5hbG9naXhfZHBf
c3RhcnRfYXV4X3RyYW5zYWN0aW9uJwoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oICAgICAgICAgICB8ICA2ICstCiAuLi4vZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9n
aXhfZHBfcmVnLmMgfCA4OCAtLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vaW14
L2lwdXYzLXBsYW5lLmMgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL29tYXBk
cm0vZHNzL2RzaS5jICAgICAgICAgICAgIHwgIDkgKy0KIGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJt
L29tYXBfaXJxLmMgICAgICAgICAgICB8ICA2ICstCiBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFu
ZWwtaWxpdGVrLWlsaTkzMjIuYyAgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVs
LXNpbXBsZS5jICAgICAgICAgIHwgIDIgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
ZGV2aWNlLmMgICAgICAgIHwgMjMgKystLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2Rydi5jICAgICAgICAgICB8ICAzICstCiBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X2VudGl0eS5jICAgICAgfCAgNCArLQogZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9t
YWluLmMgICAgICAgIHwgIDEgKwogLi4uL2RybS9zZWxmdGVzdHMvdGVzdC1kcm1fZHBfbXN0X2hl
bHBlci5jICAgIHwgMjkgKysrLS0tCiAuLi4vZ3B1L2RybS9zZWxmdGVzdHMvdGVzdC1kcm1fZnJh
bWVidWZmZXIuYyAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL3NlbGZ0ZXN0cy90ZXN0LWRybV9t
bS5jICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgICAgICAgICAg
ICAgICAgICB8IDIzICsrLS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jICAgICAgICAg
ICAgICAgICAgfCAgNCArLQogZHJpdmVycy9ncHUvaG9zdDF4L2J1cy5jICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvaXB1LXYzL2lwdS1kaS5jICAgICAgICAgICAgICAg
ICAgIHwgIDQgLQogMTggZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMTUzIGRlbGV0
aW9ucygtKQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBBbmRyemVqIEhhamRhIDxhLmhhamRh
QHNhbXN1bmcuY29tPgpDYzogQ2hyaXN0aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYXZpZCBGcmFuY2lzIDxEYXZpZC5GcmFuY2lzQGFtZC5jb20+CkNj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+CkNjOiBHYXJldGggSHVnaGVzIDxnYXJldGhAdmFsaW51eC5jb20+CkNj
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgpDYzogSmFzb24gWWFuIDx5YW5haWppZUBo
dWF3ZWkuY29tPgpDYzogSmVybmVqIFNrcmFiZWMgPGplcm5lai5za3JhYmVjQHNpb2wubmV0PgpD
YzogSmluZ29vIEhhbiA8amcxLmhhbkBzYW1zdW5nLmNvbT4KQ2M6IEpvbmFzIEthcmxtYW4gPGpv
bmFzQGt3aWJvby5zZT4KQ2M6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRl
YXNvbmJvYXJkLmNvbT4KQ2M6IExhdXJlbnQgUGluY2hhcnQgPExhdXJlbnQucGluY2hhcnRAaWRl
YXNvbmJvYXJkLmNvbT4KQ2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CkNjOiBs
aW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz4KQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGlu
dXgtdGVncmFAdmdlci5rZXJuZWwub3JnCkNjOiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29t
PgpDYzogTmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPgpDYzogTmlybW95
IERhcyA8bmlybW95LmFpZW1kQGdtYWlsLmNvbT4KQ2M6IE5YUCBMaW51eCBUZWFtIDxsaW51eC1p
bXhAbnhwLmNvbT4KQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+CkNjOiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPgpDYzogUm9i
IENsYXJrIDxyb2IuY2xhcmtAbGluYXJvLm9yZz4KQ2M6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5i
b3JnLm9yZz4KQ2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vt
d2FsQGxpbmFyby5vcmc+CkNjOiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwu
Y29tPgpDYzogVG9taSBWYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4KLS0gCjIuMjUu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
