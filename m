Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F8EC55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4360820781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYI9zgZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4360820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9EC89C97;
	Tue, 10 Nov 2020 21:48:39 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C4B89C97;
 Tue, 10 Nov 2020 21:48:38 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p8so13547456wrx.5;
 Tue, 10 Nov 2020 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Up1aG6ydtrr1/JYHxw8NlS2buR9mdLMPGDsROtKbZk8=;
 b=cYI9zgZDB3t1XzLKMSr8g7Z5wHFN4jdHxMIv9jFAeSZadz1dNiLKs8Nj4gx3O903O2
 LWtCIncvDlZ8nHTMRg2VFI8VLAa7isUGYPslLnF3CqAEFxBgElFv/nF1JIVn3gDWlpLm
 32oWoXTz4l/HSEHf1F7jQWd/JGV4zIWQU3Fk12+8Rb7bgdkpImPb/FuvSqH4cA/B5Mw5
 2grvW9CBXll/TJzcvLM+LwPJASQAKE2FBb+dMZ30SH8l9vo85MPJcfJcznBEvnlvjZdt
 hwLjihO75N9zeH8RHPSPM1Y+Zp4wp3crUvsuiBAQWEC2FSHyaRckztAABipNeRxcwfkN
 +O6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Up1aG6ydtrr1/JYHxw8NlS2buR9mdLMPGDsROtKbZk8=;
 b=tZdZlrSaDQ3ANjZNCM0OTrVnMi6ekrufQ6LYcvBo3CQ/GHKqSbzpP+B7eWLLcHMYLx
 PQ+70+XHkdfQgZxgw8XtIBOOdD6eqRK7AW9gbVdr73qFH+TFgpW0eneqQ7zpjfc0ufYE
 9FMcR0KJdg+VahiXZ4r3bMGZsFs1ViKMxXhQIszBOgrftuRa8R9i1uOvcLUXs3JNEYwA
 tLmGUaOH8p5C2Kym1kUwaP893rVRqH2vBkWm9dGR8TGwNIs97+0/EIg9/Fb1GMEgCtNy
 ZzPTQsec+rOV2LAFv9bxBEPLYRKJyaIxfukjfLZQwmBvM/WYh7jPLvI6HJCHAt2yqW/X
 uy1Q==
X-Gm-Message-State: AOAM532ZOPsHQuzd+AtQho3OgVg1KnziiuuXzQC7RUZKDj4qHfAQyI/z
 f+2HqhNFd8pT+0IrxNwrBprAtuErRxVHcz8rdB4=
X-Google-Smtp-Source: ABdhPJy0RUmp6/kZ5soVHYMu10l5Y1AvwxF0c1Q4+XZ4V5PKLlnBkZmIH1vULyJL9AQs6Yc/XgVzbGFetswrD7SAgog=
X-Received: by 2002:adf:e350:: with SMTP id n16mr26964608wrj.419.1605044917283; 
 Tue, 10 Nov 2020 13:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-19-lee.jones@linaro.org>
In-Reply-To: <20201105144517.1826692-19-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 16:48:26 -0500
Message-ID: <CADnq5_PUZbPh0gmrTcY-cuLeUjfXNt8bS5YBz8g3VgCskYeh4A@mail.gmail.com>
Subject: Re: [PATCH 18/19] gpu: drm: amd: amdgpu: amdgpu: Mark global
 variables as __maybe_unused
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgNSwgMjAyMCBhdCA5OjUyIEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gVGhlc2UgMyB2YXJpYWJsZXMgYXJlIHVzZWQgaW4gKnNvbWUqIHNv
dXJjZWZpbGVzIHdoaWNoIGluY2x1ZGUKPiBhbWRncHUuaCwgYnV0IG5vdCAqYWxsKi4gIFRoaXMg
bGVhZHMgdG8gYSBmbHVycnkgb2YgYnVpbGQgd2FybmluZ3MuCj4KPiBGaXhlcyB0aGUgZm9sbG93
aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBmcm9tIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oOjY3LAo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaDoxOTg6MTk6IHdhcm5pbmc6IOKAmG5vX3N5c3RlbV9tZW1fbGltaXTigJkgZGVmaW5l
ZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmg6MTk3OjE5OiB3YXJuaW5nOiDigJhkZWJ1Z19ldmljdGlv
bnPigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmg6MTk2OjE4OiB3YXJuaW5nOiDigJhz
Y2hlZF9wb2xpY3nigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlh
YmxlPV0KPgo+ICBOQjogUmVwZWF0cyB+NjUwIHRpbWVzIC0gc25pcHBlZCBmb3IgYnJldml0eS4K
Pgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KPiBDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJv
LW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUu
am9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDYgKysrLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaAo+IGluZGV4IDE4M2IwOWQ3MWI2NGEuLjU5Mzk3NTMwODAwNTYgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+IEBAIC0xOTMsOSArMTkzLDkgQEAgZXh0
ZXJuIGludCBzY2hlZF9wb2xpY3k7Cj4gIGV4dGVybiBib29sIGRlYnVnX2V2aWN0aW9uczsKPiAg
ZXh0ZXJuIGJvb2wgbm9fc3lzdGVtX21lbV9saW1pdDsKPiAgI2Vsc2UKPiAtc3RhdGljIGNvbnN0
IGludCBzY2hlZF9wb2xpY3kgPSBLRkRfU0NIRURfUE9MSUNZX0hXUzsKPiAtc3RhdGljIGNvbnN0
IGJvb2wgZGVidWdfZXZpY3Rpb25zOyAvKiA9IGZhbHNlICovCj4gLXN0YXRpYyBjb25zdCBib29s
IG5vX3N5c3RlbV9tZW1fbGltaXQ7Cj4gK3N0YXRpYyBjb25zdCBpbnQgX19tYXliZV91bnVzZWQg
c2NoZWRfcG9saWN5ID0gS0ZEX1NDSEVEX1BPTElDWV9IV1M7Cj4gK3N0YXRpYyBjb25zdCBib29s
IF9fbWF5YmVfdW51c2VkIGRlYnVnX2V2aWN0aW9uczsgLyogPSBmYWxzZSAqLwo+ICtzdGF0aWMg
Y29uc3QgYm9vbCBfX21heWJlX3VudXNlZCBub19zeXN0ZW1fbWVtX2xpbWl0Owo+ICAjZW5kaWYK
Pgo+ICBleHRlcm4gaW50IGFtZGdwdV90bXo7Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcg
bGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
