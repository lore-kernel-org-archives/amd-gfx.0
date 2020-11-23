Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9597FC6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342A4207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzzgfZmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342A4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B38892FD;
	Mon, 23 Nov 2020 08:04:53 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D787892E6;
 Mon, 23 Nov 2020 08:04:52 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id h21so16337686wmb.2;
 Mon, 23 Nov 2020 00:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Nb+XTI9jea9tV50c+4dlxofzVqcRsJCoDAXlu472El8=;
 b=MzzgfZmJHkHI+7gPUHWK4vrtuyHAT/8HD21jJqwVglDBjMeATF8cGEgGqNY158JnnY
 gl8hpt9lskvRmQRUBSnygcI4UgnpSe8Fb6BRLPs65ygEaRFM+aoybPbCjF2Zmt4evYfH
 i99LK+zMGgrePZ9lX5rj2z5RL2sj1jXCGZb2ELExorBB7LN8SPlyamt7ItS6Z5/yaSaw
 UkL355oky1Tt07FvhkgMWsl25bFHyS3VmBy0XOlJldznYAmvgQ5PINjDyXj6YiTqOfzU
 qO+WDi1B6ihHiitRTSPsWehFP7NWodYauCRggk1U6h5d3mmqmgTgkmfCzPYS+vQKlsKH
 weiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Nb+XTI9jea9tV50c+4dlxofzVqcRsJCoDAXlu472El8=;
 b=rJ0uIpCGH49z3CvT6ZRGjp6RoxNLMN7RzCcbzZsgAsTOIcn5tU59+4Wx3OiqDejMVs
 XyqTfxV405BwXa6PbQuc7Iz8MUNz7Y5NyAJIW0NInfngHu85CR5blebBGfOQsnvlgiAN
 wj/H51JsQBX+yL+QBuolCblyOn9Y/GWhhyqPtnM6IXhqodc0F6ueOWt74TudyuherTHC
 Fo8sOrBOdHJM119+XUk2mGSz+pqXigHR6e0yz7EDKhTwrPkS+ThI2RCSYtpeXhEpep90
 n1VfxG0jxO1fmgiSVrE21KFsIYm//6fiSeGqD3lnEHS4T8mcNgFGxs5Oq97LoL5ihCa6
 lQIQ==
X-Gm-Message-State: AOAM531svaysvBBz07hWAsAdIY+XzXGsdtaumDLWgk8dT9Hx+9BfZEzD
 2lH6BNYz+1BmEHdkTHZtLpY=
X-Google-Smtp-Source: ABdhPJzvj5FMbYFNudDf7UUkWnfmfwX6DpICNoCJ0pe4m65wtKjCwNO38zZdtzi7HFrpqyRk/onZ2w==
X-Received: by 2002:a05:600c:22d5:: with SMTP id
 21mr21119100wmg.33.1606118691157; 
 Mon, 23 Nov 2020 00:04:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 134sm10383524wmb.17.2020.11.23.00.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 00:04:50 -0800 (PST)
Subject: Re: [PATCH v3 04/12] drm/ttm: Set dma addr to null after freee
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, robh@kernel.org, l.stach@pengutronix.de,
 yuq825@gmail.com, eric@anholt.net
References: <1605936082-3099-1-git-send-email-andrey.grodzovsky@amd.com>
 <1605936082-3099-5-git-send-email-andrey.grodzovsky@amd.com>
 <cc970f95-ae21-ab8d-232e-abbddf7d6a0f@gmail.com>
 <dd7e107a-d1c0-404d-81d6-7ecca358cd8e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6e03ac16-18ce-fa4b-712e-b6835242d6c5@gmail.com>
Date: Mon, 23 Nov 2020 09:04:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dd7e107a-d1c0-404d-81d6-7ecca358cd8e@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 Harry.Wentland@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMTEuMjAgdW0gMDY6MTUgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDEx
LzIxLzIwIDk6MTMgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDIxLjExLjIwIHVt
IDA2OjIxIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+PiBGaXhlcyBvb3BzLgo+Pgo+PiBU
aGF0IGZpbGUgZG9lc24ndCBldmVuIGV4aXN0IGFueSBtb3JlLiBXaGF0IG9vcHMgc2hvdWxkIHRo
aXMgZml4Pwo+Cj4KPiBXaGljaCBmaWxlID8KCnR0bV9wYWdlX2FsbG9jLmMKCkkndmUgcmV3cml0
dGVuIHRoZSB3aG9sZSBwYWdlIHBvb2wgZnJvbSBzY3JhdGNoIHVwc3RyZWFtLgoKPiBXZSBzZXQg
ZG1hX2FkZHJlc3MgdG8gTlVMTCBpbiBldmVyeSBvdGhlciBwbGFjZSBhZnRlciB1bm1hcC4gVGhp
cyBpcyAKPiBzbyB0aGF0Cj4gaWYgZG1hIGFkZHJlc3Mgd2FzIGFscmVhZHkgdW5tYXBwZWQgd2Ug
c2tpcCBpdCBuZXh0IHRpbWUgd2UgZW50ZXIgCj4gdHRtX3VubWFwX2FuZF91bnBvcHVsYXRlX3Bh
Z2VzCj4gd2l0aCBzYW1lIHR0IGZvciBzb21lIHJlYXNvbi4KCkRhdmUgYW5kIEkgYWxyZWFkeSBm
aXhlZCB0aGF0IGFzIHdlbGwgYnkgaGF2aW5nIGEgZmxhZyBwcmV2ZW50aW5nIGRvdWJsZSAKdW5w
b3B1bGF0ZS4KCj4gVGhlIG9vcHMgaGFwcGVucyB3aXRoIElPTU1VIGVuYWJsZWQuIFRoZSBkZXZp
Y2UgaXMgcmVtb3ZlZCBmcm9tIGl0J3MgCj4gSU9NTVUgZ3JvdXAKPiBkdXJpbmcgUENJIHJlbW92
ZSBidXQgdGhlIEJPcyBhcmUgYWxsIHN0aWxsIGFsaXZlIGlmIHVzZXIgbW9kZSBjbGllbnQgCj4g
aG9sZHMgcmVmZXJlbmNlIHRvIGRybSBmaWxlLgo+IExhdGVyIHdoZW4gdGhlIHJlZmVybmVjZSBp
cyBkcm9wcHBlZCBhbmQgZGV2aWNlIGZpbmkgaGFwcGVucyBpIGdldCAKPiBvb3BzIGluCj4gdHRt
X3VubWFwX2FuZF91bnBvcHVsYXRlX3BhZ2VzLT5kbWFfdW5tYXBfcGFnZSBiZWNhdWUgb2YgSU9N
TVUgZ3JvdXAgCj4gc3RydWN0dXJlcyBiZWluZyBnb25lIGFscmVhZHkuCj4gUGF0Y2jCoCBbMTEv
MTJdIGRybS9hbWRncHU6IFJlZ2lzdGVyIElPTU1VIHRvcG9sb2d5IG5vdGlmaWVyIHBlciBkZXZp
Y2UgCj4gdG9nZXRoZXIgd2l0aCB0aGlzIHBhdGNoIHNvbHZlIHRoZSBvb3BzLgoKSXQgc2hvdWxk
IGJlIHN1ZmZpY2llbnQgdG8gdW5wb3B1bGF0ZSBhbGwgQk9zIG5vdy4KCk1heWJlIHlvdSBzaG91
bGQgcmViYXNlIHRoZSBwYXRjaGVzIG9uIGRybS1taXNjLW5leHQuCgpDaHJpc3RpYW4uCgo+Cj4g
QW5kcmV5Cj4KPgo+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5n
cm9kem92c2t5QGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X3BhZ2VfYWxsb2MuYyB8IDIgKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxv
Yy5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPj4+IGluZGV4
IGI0MGE0NjcuLmIwZGYzMjggMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9wYWdlX2FsbG9jLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxs
b2MuYwo+Pj4gQEAgLTExNjAsNiArMTE2MCw4IEBAIHZvaWQgdHRtX3VubWFwX2FuZF91bnBvcHVs
YXRlX3BhZ2VzKHN0cnVjdCAKPj4+IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHRtX2RtYV90dCAqdHQp
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hX3VubWFwX3BhZ2UoZGV2LCB0dC0+ZG1hX2FkZHJl
c3NbaV0sIG51bV9wYWdlcyAqIAo+Pj4gUEFHRV9TSVpFLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBETUFfQklESVJFQ1RJT05BTCk7Cj4+PiDCoCArwqDCoMKg
wqDCoMKgwqAgdHQtPmRtYV9hZGRyZXNzW2ldID0gMDsKPj4+ICsKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBpICs9IG51bV9wYWdlczsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoCB0dG1f
cG9vbF91bnBvcHVsYXRlKCZ0dC0+dHRtKTsKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDYW5kcmV5
Lmdyb2R6b3Zza3klNDBhbWQuY29tJTdDMWM3MGViNjAyYTQ5NDk3YWZmMzUwOGQ4OGUyN2FkMWEl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDE1NjQ4Mzgx
MzM4Mjg4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRh
PXA4SGpyRWZ5ZEtyc3BzRkNwMXY4S0NkVDZsS3IxT0VLWGRGMyUyQlNvaDR6ayUzRCZhbXA7cmVz
ZXJ2ZWQ9MCAKPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
