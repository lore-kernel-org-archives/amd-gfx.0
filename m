Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED4C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 08:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DA961132
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 08:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DA961132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634206F5DE;
	Fri, 21 May 2021 08:43:24 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCF56F5DD;
 Fri, 21 May 2021 08:43:23 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id s22so29087701ejv.12;
 Fri, 21 May 2021 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7EH/eu2A9F13TZP+cLtxx5mHYbMmjIF3AHkw+YdUTwY=;
 b=gtnfZueMFiF2wc93vVK1PBMtd94tUhuW7uq/PRKILbGWnBs5bZbPHzvtDNnFHtF/Qt
 E+kHnhRyYLFpMeueETgH/oimXip3HrwF+AtnmxoIph82zyj3ze219z+pKQ7hVn9OYMHw
 5Tpx3It2YffP4S2aaTGSqYhKEAFbxCUtzlZkczOuV5x2+qhGkczELJMvMfzAXsttjz8x
 B3W7wp0EX/GeZbmWgHHlta4aiPOK+SSMRRlu0NreTdAuxijEPAY6X7X1I7+gPaLaBnOR
 C5oXRnW6rSR0WD3nPVlzp2wjUsuFuOu84CMkeTIq3U2o7y4AUYT0GDfFqBPqgKo/+u9u
 XbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7EH/eu2A9F13TZP+cLtxx5mHYbMmjIF3AHkw+YdUTwY=;
 b=tJc+LOcP5r5SzPrY/XTPKDOM2S8GeYDqt1gJz7Zy4UZdcYGy6ki/HpbOXhwoi+JCb3
 i2B5XWmFTlMU0JEiFP6LIY3mZaMngrNqKUYBsIUflCMhfO3rNBt8co2Ypip/nJtXXc3c
 dMXH0x7n+Xn5S9lMXtBG1EwwMaTuSsRl5IJghSSUzLGogLCrd9BGO0fq00J0t5RXB4pq
 N/WtswCSJGV0GMp2fE9QHRHwdKBIGSg1oQgUepoBCAoQo2mP7W1aWXDG2RLpH2Y+jX4p
 wLRnfZQK5Sc/Wvq+OTZ8FQRubi1XiHLD3UVXof1HYAdtgvH9iJBUOY+1WxiBwzvMfFdw
 ebHQ==
X-Gm-Message-State: AOAM5303Z/ztcca4IHP9FlZ9012tcelWwp743I63HZriuebrak/iqGNZ
 kG0dP1Gz06XC5iDPor5x2R/DF6I7wj4=
X-Google-Smtp-Source: ABdhPJwKVhRUoa+TF+FIFqbdsI7EwgTCt8GTAPP8WSLGRACidwYWZy8WDgZ7Xr4TSWGfasHZrmim6Q==
X-Received: by 2002:a17:907:9691:: with SMTP id
 hd17mr9109737ejc.67.1621586601825; 
 Fri, 21 May 2021 01:43:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d?
 ([2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d])
 by smtp.gmail.com with ESMTPSA id k26sm3031315eje.67.2021.05.21.01.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 01:43:21 -0700 (PDT)
Subject: Re: [PATCH] drm/ttm: Skip swapout if ttm object is not populated
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521083112.33176-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3dbc2de5-d741-f3c9-c41d-093ff29c39aa@gmail.com>
Date: Fri, 21 May 2021 10:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521083112.33176-1-xinhui.pan@amd.com>
Content-Language: en-US
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
Cc: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, daniel@ffwll.ch
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDUuMjEgdW0gMTA6MzEgc2NocmllYiB4aW5odWkgcGFuOgo+IFN3YXBwaW5nIGEgdHRt
IG9iamVjdCB3aGljaCBoYXMgbm8gYmFja2VuZCBwYWdlcyBtYWtlcyBubyBzZW5zZS4KPgo+IFN1
Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpHb2luZyB0
byBhZGQgYSBDQzogc3RhYmxlIGFuZCBwdXNoaW5nIHRoYXQgdG8gZHJtLW1pc2MtZml4ZXMgaW4g
YSBtaW51dGUuCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fZGV2aWNlLmMgfCAy
ICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9kZXZpY2UuYyBiL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX2RldmljZS5jCj4gaW5kZXggNTEwZTNlMDAxZGFiLi5hMWRjZjdkNTVj
OTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fZGV2aWNlLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9kZXZpY2UuYwo+IEBAIC0xNDUsNyArMTQ1LDcgQEAg
aW50IHR0bV9kZXZpY2Vfc3dhcG91dChzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwgc3RydWN0IHR0
bV9vcGVyYXRpb25fY3R4ICpjdHgsCj4gICAJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJvLCAmbWFu
LT5scnVbal0sIGxydSkgewo+ICAgCQkJCXVpbnQzMl90IG51bV9wYWdlczsKPiAgIAo+IC0JCQkJ
aWYgKCFiby0+dHRtIHx8Cj4gKwkJCQlpZiAoIWJvLT50dG0gfHwgIXR0bV90dF9pc19wb3B1bGF0
ZWQoYm8tPnR0bSkgfHwKPiAgIAkJCQkgICAgYm8tPnR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdF
X0ZMQUdfU0cgfHwKPiAgIAkJCQkgICAgYm8tPnR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZM
QUdfU1dBUFBFRCkKPiAgIAkJCQkJY29udGludWU7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
