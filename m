Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C9C47097
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 12:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C6E6139A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 12:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C6E6139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8766F472;
	Thu,  3 Jun 2021 12:50:33 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09ED6EDBE
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 11:52:38 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 l11-20020a05600c4f0bb029017a7cd488f5so3573584wmq.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Jun 2021 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Nxij94IMFMsp61zYWJS5XKMycKfWOvntSLUdgR9Luec=;
 b=PP1Vx2P7z4p7uzC7frRq63E4x3I08msTGMShcvAdEGFQwbgoSQLam6TY7qFtZnfrip
 sZ2vdZz58OMVJtBV+LV7UtfH3hRj1TGjasngZ2KltASWY+0UFk1GkCFvbmMy1zh8VBMP
 dPoAp8/Papp6e6Y9syxE5WTIn3EkF63IUFXhjOyvBnTk1EZXXSJ1zWN+ZFpLmyfRRgmV
 zaZeW5clEklapwp4mQNAksAoChe6wCnp4zD6/sK7bIoELjiqOV1BWj7Fd7qq0A12wR59
 YBj4xTZnnoKIwJpwtS8WL69eLi0TYKCyPQcOnDWAOzYthTaMGxq+z6P1knTVhENqAX1n
 l+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Nxij94IMFMsp61zYWJS5XKMycKfWOvntSLUdgR9Luec=;
 b=f9miD+9hsqNzm/plnerUiJJKPmZYpjbKC8h2C94T6LmsS9CXomiOEwED/N1e0kLJJt
 R5vTDFNGev0tvtNsgq1Pmvken3B6GgemjYWZPyqSwjQGdb23OvLNnChZovZj1zFh6Bil
 23ohyf9dz5Ke2s2MdnlRxa+7kkRzU/68CEIpDDPjvT2yQ9CNNz9tTwIJl+2demP+muxj
 BRto5fSH4whW2sXO1TtKJ8EGAZutf9aCcjjS498855+s4wIZHKGyFEPuNm6YG6ZeYuOU
 25LwmwkqFPtPZb/hlEK6IGqIDUg7VoT/iZJJYzAHzgosGMjzlxECU4A8QLPaGfG6KlUw
 X1bQ==
X-Gm-Message-State: AOAM533+aeBl48dyK+Lba9d1NciMpn3I9XOgUiiUzCSbHgtORmZXuXJp
 WSPkYs9PfI/UERb6Q19CZl2T5Q==
X-Google-Smtp-Source: ABdhPJy5Njm66nMjE/L6HCMm1K6dzFQlD8FyCcfSndwd7kIwe0+i4mO9AXShjFboYjDIKB2XcsUlUA==
X-Received: by 2002:a05:600c:4e8b:: with SMTP id
 f11mr4461550wmq.40.1622721157306; 
 Thu, 03 Jun 2021 04:52:37 -0700 (PDT)
Received: from dell ([91.110.221.214])
 by smtp.gmail.com with ESMTPSA id h9sm2479488wmb.35.2021.06.03.04.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 04:52:36 -0700 (PDT)
Date: Thu, 3 Jun 2021 12:52:34 +0100
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Adam Jackson <ajax@redhat.com>,
 Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agarwal <akshua@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alistair Popple <apopple@nvidia.com>, amd-gfx@lists.freedesktop.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Ben Skeggs <bskeggs@redhat.com>, Ben Widawsky <ben@bwidawsk.net>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Eric Anholt <eric@anholt.net>, Fabien Dessenne <fabien.dessenne@st.com>,
 freedreno@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Huang Rui <ray.huang@amd.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Krishna Manikandan <mkrishn@codeaurora.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Kuogee Hsieh <khsieh@codeaurora.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Li <sunpeng.li@amd.com>, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, nouveau@lists.freedesktop.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Clark <robdclark@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sean Paul <sean@poorly.run>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Stephen Boyd <swboyd@chromium.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [RESEND 00/26] Rid W=1 warnings from GPU
Message-ID: <20210603115234.GA2435141@dell>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <YLi+KJrLjKbdXLxH@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLi+KJrLjKbdXLxH@phenom.ffwll.local>
X-Mailman-Approved-At: Thu, 03 Jun 2021 12:50:31 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAwMyBKdW4gMjAyMSwgRGFuaWVsIFZldHRlciB3cm90ZToKCj4gT24gV2VkLCBKdW4g
MDIsIDIwMjEgYXQgMDM6MzI6MzRQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gU29tZSBv
ZmYgdGhlc2UgcGF0Y2hlcyBoYXZlIGJlZW4ga25vY2tpbmcgYXJvdW5kIGZvciBhIHdoaWxlLgo+
ID4gCj4gPiBXaG8gd2lsbCBob292ZXIgdGhlbSB1cCBwbGVhc2U/Cj4gPiAKPiA+IFRoaXMgc2V0
IGlzIHBhcnQgb2YgYSBsYXJnZXIgZWZmb3J0IGF0dGVtcHRpbmcgdG8gY2xlYW4tdXAgVz0xCj4g
PiBrZXJuZWwgYnVpbGRzLCB3aGljaCBhcmUgY3VycmVudGx5IG92ZXJ3aGVsbWluZ2x5IHJpZGRs
ZWQgd2l0aAo+ID4gbmlnZ2x5IGxpdHRsZSB3YXJuaW5ncy4KPiA+IAo+ID4gTGVlIEpvbmVzICgy
Nik6Cj4gPiAgIGRybS9tZWRpYXRlay9tdGtfZGlzcF9jb2xvcjogU3RyaXAgaW5jb3JyZWN0IGRv
YyBhbmQgZGVtb3RlIGhlYWRlcgo+ID4gICBkcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWE6IFN0
cmlwIGFuZCBkZW1vdGUgbm9uLWNvbmZvcm1hbnQKPiA+ICAgICBrZXJuZWwtZG9jIGhlYWRlcgo+
ID4gICBkcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsOiBTdHJpcCBhbmQgZGVtb3RlIG5vbi1jb25m
b3JtYW50IGhlYWRlcgo+ID4gICBkcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYTogU3RyaXAgYW5k
IGRlbW90ZSBub24tY29uZm9ybWFudCBrZXJuZWwtZG9jCj4gPiAgICAgaGVhZGVyCj4gPiAgIGRy
bS9zdGkvc3RpX2hkbWlfdHgzZzRjMjhwaHk6IFByb3ZpZGUgZnVuY3Rpb24gbmFtZXMgZm9yIGtl
cm5lbC1kb2MKPiA+ICAgICBoZWFkZXJzCj4gPiAgIGRybS9zdGkvc3RpX2hkYTogUHJvdmlkZSBt
aXNzaW5nIGZ1bmN0aW9uIG5hbWVzCj4gPiAgIGRybS9zdGkvc3RpX3R2b3V0OiBQcm92aWRlIGEg
YnVuY2ggb2YgbWlzc2luZyBmdW5jdGlvbiBuYW1lcwo+ID4gICBkcm0vc3RpL3N0aV9ocXZkcDog
Rml4IGluY29ycmVjdGx5IG5hbWVkIGZ1bmN0aW9uICdzdGlfaHF2ZHBfdnRnX2NiKCknCj4gPiAg
IGRybS9tc20vZGlzcC9kcHUxL2RwdV9lbmNvZGVyX3BoeXNfY21kOiBSZW1vdmUgdW51c2VkIHZh
cmlhYmxlCj4gPiAgICAgJ2NtZF9lbmMnCj4gPiAgIGRybS9tc20vZGlzcC9kcHUxL2RwdV9od19p
bnRlcnJ1cHRzOiBEZW1vdGUgYSBidW5jaCBvZiBrZXJuZWwtZG9jCj4gPiAgICAgYWJ1c2VzCj4g
PiAgIGRybS9tc20vZGlzcC9kcHUxL2RwdV9wbGFuZTogRml4IGEgY291cGxlIG9mIG5hbWluZyBp
c3N1ZXMKPiA+ICAgZHJtL21zbS9tc21fZ2VtOiBEZW1vdGUga2VybmVsLWRvYyBhYnVzZXMKPiA+
ICAgZHJtL21zbS9kcC9kcF9jYXRhbG9nOiBDb3JyZWN0bHkgZG9jdW1lbnQgcGFyYW0gJ2RwX2Nh
dGFsb2cnCj4gPiAgIGRybS9tc20vZHAvZHBfbGluazogRml4IHNvbWUgcG90ZW50aWFsIGRvYy1y
b3QKPiA+ICAgZHJtL25vdXZlYXUvbnZrbS9zdWJkZXYvbWMvdHUxMDI6IE1ha2UgZnVuY3Rpb25z
IGNhbGxlZCBieSByZWZlcmVuY2UKPiA+ICAgICBzdGF0aWMKPiA+ICAgZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfdHJhbnNmb3JtOiBSZW1vdmUgc3VwZXJmbHVvdXMKPiA+ICAgICByZS1pbml0
aWFsaXNhdGlvbiBvZiBEQ0ZFX01FTV9MSUdIVF9TTEVFUF9DTlRMLAo+ID4gICBkcm0veGxueC96
eW5xbXBfZGlzcDogRml4IGluY29ycmVjdGx5IG5hbWVkIGVudW0KPiA+ICAgICAnenlucW1wX2Rp
c3BfbGF5ZXJfaWQnCj4gPiAgIGRybS94bG54L3p5bnFtcF9kcDogRml4IGluY29ycmVjdGx5IG5h
bWUgZnVuY3Rpb24gJ3p5bnFtcF9kcF90cmFpbigpJwo+ID4gICBkcm0vdHRtL3R0bV90dDogRGVt
b3RlIG5vbi1jb25mb3JtYW50IGtlcm5lbC1kb2MgaGVhZGVyCj4gPiAgIGRybS9wYW5lbC9wYW5l
bC1yYXNwYmVycnlwaS10b3VjaHNjcmVlbjogRGVtb3RlIGtlcm5lbC1kb2MgYWJ1c2UKPiA+ICAg
ZHJtL3BhbmVsL3BhbmVsLXNpdHJvbml4LXN0NzcwMTogRGVtb3RlIGtlcm5lbC1kb2MgYWJ1c2UK
PiA+ICAgZHJtL3ZnZW0vdmdlbV9kcnY6IFN0YW5kYXJkIGNvbW1lbnQgYmxvY2tzIHNob3VsZCBu
b3QgdXNlIGtlcm5lbC1kb2MKPiA+ICAgICBmb3JtYXQKPiA+ICAgZHJtL2V4eW5vcy9leHlub3M3
X2RybV9kZWNvbjogRml4IGluY29ycmVjdCBuYW1pbmcgb2YKPiA+ICAgICAnZGVjb25fc2hhZG93
X3Byb3RlY3Rfd2luKCknCj4gPiAgIGRybS9leHlub3MvZXh5bm9zX2RybV9pcHA6IEZpeCBkb2N1
bWVudGF0aW9uIGZvcgo+ID4gICAgICdleHlub3NfZHJtX2lwcF9nZXRfe2NhcHMscmVzfV9pb2N0
bCgpJwo+ID4gICBkcm0vdmJveHZpZGVvL2hnc21pX2Jhc2U6IFBsYWNlIGZ1bmN0aW9uIG5hbWVz
IGludG8gaGVhZGVycwo+ID4gICBkcm0vdmJveHZpZGVvL21vZGVzZXR0aW5nOiBQcm92aWRlIGZ1
bmN0aW9uIG5hbWVzIGZvciBwcm90b3R5cGUKPiA+ICAgICBoZWFkZXJzCj4gCj4gRXhjZXB0IGZv
ciBtc20gKFJvYiBDbGFyayBwcm9taXNlZCBvbiBpcmMgaGUnbGwgcGljayB0aGVtIHVwIGZvciA1
LjE0Cj4gc29vbikgYW5kIGFtZCAoQWxleCBpcyBvbiB0b3Agb2YgdGhpbmdzIEkgdGhpbmspIEkg
cGlja2VkIHRoZW0gYWxsIHVwIGFuZAo+IG1lcmdlZCBpbnRvIGRybS1taXNjLW5leHQuCgpTdXBl
cnN0YXIhICBUaGFua3MgRGFuaWVsLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3Ig
VGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdp
dHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
