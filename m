Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5ADC49EA2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EDB60FEB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EDB60FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFA46E59B;
	Tue, 22 Jun 2021 15:25:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 24F8E6E598;
 Tue, 22 Jun 2021 15:25:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2F9DED1;
 Tue, 22 Jun 2021 08:25:55 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E2263F718;
 Tue, 22 Jun 2021 08:25:55 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
 id 63299683943; Tue, 22 Jun 2021 16:25:54 +0100 (BST)
Date: Tue, 22 Jun 2021 16:25:54 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 05/22] drm/komeda: Don't set struct
 drm_device.irq_enabled
Message-ID: <20210622152554.vc7mnohj5u2trxpi@e110455-lin.cambridge.arm.com>
References: <20210622141002.11590-1-tzimmermann@suse.de>
 <20210622141002.11590-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210622141002.11590-6-tzimmermann@suse.de>
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
Cc: heiko@sntech.de, emma@anholt.net, airlied@linux.ie,
 nouveau@lists.freedesktop.org, alexandre.torgue@foss.st.com,
 dri-devel@lists.freedesktop.org, michal.simek@xilinx.com,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, benjamin.gaignard@linaro.org,
 mihail.atanassov@arm.com, festevam@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 jy0922.shim@samsung.com, krzysztof.kozlowski@canonical.com,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 wens@csie.org, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 xinliang.liu@linaro.org, kong.kongxinwei@hisilicon.com,
 james.qian.wang@arm.com, linux-imx@nxp.com,
 linux-graphics-maintainer@vmware.com, linux-sunxi@lists.linux.dev,
 bskeggs@redhat.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 puck.chen@hisilicon.com, s.hauer@pengutronix.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, inki.dae@samsung.com,
 john.stultz@linaro.org, laurentiu.palcu@oss.nxp.com, matthias.bgg@gmail.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 mcoquelin.stm32@gmail.com, amd-gfx@lists.freedesktop.org, hyun.kwon@xilinx.com,
 tomba@kernel.org, jyri.sarha@iki.fi, yannick.fertre@foss.st.com,
 Xinhui.Pan@amd.com, sw0312.kim@samsung.com, hjc@rock-chips.com,
 christian.koenig@amd.com, kyungmin.park@samsung.com,
 philippe.cornu@foss.st.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 tiantao6@hisilicon.com, shawnguo@kernel.org, brian.starkey@arm.com,
 zackr@vmware.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMjIsIDIwMjEgYXQgMDQ6MDk6NDVQTSArMDIwMCwgVGhvbWFzIFppbW1lcm1h
bm4gd3JvdGU6Cj4gVGhlIGZpZWxkIGRybV9kZXZpY2UuaXJxX2VuYWJsZWQgaXMgb25seSB1c2Vk
IGJ5IGxlZ2FjeSBkcml2ZXJzCj4gd2l0aCB1c2Vyc3BhY2UgbW9kZXNldHRpbmcuIERvbid0IHNl
dCBpdCBpbiBrb21lZGEuCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6
aW1tZXJtYW5uQHN1c2UuZGU+CgpBY2tlZC1ieTogTGl2aXUgRHVkYXUgPGxpdml1LmR1ZGF1QGFy
bS5jb20+CgpCZXN0IHJlZ2FyZHMsCkxpdml1Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYXJt
L2Rpc3BsYXkva29tZWRhL2tvbWVkYV9rbXMuYyB8IDQgLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNw
bGF5L2tvbWVkYS9rb21lZGFfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29t
ZWRhL2tvbWVkYV9rbXMuYwo+IGluZGV4IGZmNDVmMjNmM2Q1Ni4uNTJhNmRiNTcwN2EzIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2ttcy5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfa21zLmMK
PiBAQCAtMzAxLDggKzMwMSw2IEBAIHN0cnVjdCBrb21lZGFfa21zX2RldiAqa29tZWRhX2ttc19h
dHRhY2goc3RydWN0IGtvbWVkYV9kZXYgKm1kZXYpCj4gIAlpZiAoZXJyKQo+ICAJCWdvdG8gZnJl
ZV9jb21wb25lbnRfYmluZGluZzsKPiAgCj4gLQlkcm0tPmlycV9lbmFibGVkID0gdHJ1ZTsKPiAt
Cj4gIAlkcm1fa21zX2hlbHBlcl9wb2xsX2luaXQoZHJtKTsKPiAgCj4gIAllcnIgPSBkcm1fZGV2
X3JlZ2lzdGVyKGRybSwgMCk7Cj4gQEAgLTMxMyw3ICszMTEsNiBAQCBzdHJ1Y3Qga29tZWRhX2tt
c19kZXYgKmtvbWVkYV9rbXNfYXR0YWNoKHN0cnVjdCBrb21lZGFfZGV2ICptZGV2KQo+ICAKPiAg
ZnJlZV9pbnRlcnJ1cHRzOgo+ICAJZHJtX2ttc19oZWxwZXJfcG9sbF9maW5pKGRybSk7Cj4gLQlk
cm0tPmlycV9lbmFibGVkID0gZmFsc2U7Cj4gIGZyZWVfY29tcG9uZW50X2JpbmRpbmc6Cj4gIAlj
b21wb25lbnRfdW5iaW5kX2FsbChtZGV2LT5kZXYsIGRybSk7Cj4gIGNsZWFudXBfbW9kZV9jb25m
aWc6Cj4gQEAgLTMzMSw3ICszMjgsNiBAQCB2b2lkIGtvbWVkYV9rbXNfZGV0YWNoKHN0cnVjdCBr
b21lZGFfa21zX2RldiAqa21zKQo+ICAJZHJtX2Rldl91bnJlZ2lzdGVyKGRybSk7Cj4gIAlkcm1f
a21zX2hlbHBlcl9wb2xsX2ZpbmkoZHJtKTsKPiAgCWRybV9hdG9taWNfaGVscGVyX3NodXRkb3du
KGRybSk7Cj4gLQlkcm0tPmlycV9lbmFibGVkID0gZmFsc2U7Cj4gIAljb21wb25lbnRfdW5iaW5k
X2FsbChtZGV2LT5kZXYsIGRybSk7Cj4gIAlkcm1fbW9kZV9jb25maWdfY2xlYW51cChkcm0pOwo+
ICAJa29tZWRhX2ttc19jbGVhbnVwX3ByaXZhdGVfb2JqcyhrbXMpOwo+IC0tIAo+IDIuMzIuMAo+
IAoKLS0gCj09PT09PT09PT09PT09PT09PT09CnwgSSB3b3VsZCBsaWtlIHRvIHwKfCBmaXggdGhl
IHdvcmxkLCAgfAp8IGJ1dCB0aGV5J3JlIG5vdCB8CnwgZ2l2aW5nIG1lIHRoZSAgIHwKIFwgc291
cmNlIGNvZGUhICAvCiAgLS0tLS0tLS0tLS0tLS0tCiAgICDCr1xfKOODhClfL8KvCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
