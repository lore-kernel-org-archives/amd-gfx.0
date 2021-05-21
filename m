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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4BBC43460
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FC8610CB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FC8610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF4D6F875;
	Fri, 21 May 2021 13:35:56 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3808A6F64B;
 Fri, 21 May 2021 13:35:55 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id r11so23291358edt.13;
 Fri, 21 May 2021 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=CQNC5tcnBn2sqXfCRtfQO1Epq9bHKf0uPXF2miAwK8c=;
 b=fLsWWbaiDOqeBWiqz6Z+lTChhnRdQXJhHKLIfA8sFTt4eb1cfC4Lt3RrcQ21kaW+jW
 OHIxj5PhomewXQVDOd/NF4aWy9+nfK225wjSgNf4pICpSZapsAFD8LYus0KDiKKUuQ8g
 q29dSw99YdnCWDV0xwHNcRcX6NgiJpwFfWk5fk2Ot7V6FoTtgokzv/SI1lCWzOgnr2Lc
 FU/z2kh1YvgJfgjqA275Qr3tRFOI5QZVbtUGtxUdON110xwRCN7lFaz+JPDs9sgDLpka
 7E+Uyoi5ddadvNEHHi1V3c2eC9DHyCLuYNLje5KHnohs/PqXiQcNWWZsqQZnDUp3ltdP
 CmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=CQNC5tcnBn2sqXfCRtfQO1Epq9bHKf0uPXF2miAwK8c=;
 b=Nbo6raYsAsWQ60RXy6y4jVRlrbJ6X1Lo6sdZN/9NoPAG1z0McitPLBxcTZM8K1ivXO
 VQmLS6oSfW4bjmVxDU+nOLV95JIorZau0+5ZUAtXCDWVIzsVeoTkINKpCT4lMX/d1Xgu
 uL+gLP/a2N/LED3zkohPch3CZ056ctvMWH1CAnGIOzbFqDQ3k0JnFEyKLsQGhoP/PTtB
 EvKdu3HR+dJc56/97lyV2FAssrnBv6X7pBSAGhyskTD4BR1nJ8oe/7OcH1QT7L4yDF6v
 ZEN9bejUEfHtd7U5GzBUfRtoEE0yrIWy9CTNbmBC4mDi+RMgw9WiF5hs251zwY6nyOQt
 UkOg==
X-Gm-Message-State: AOAM530ZCv0r1VW5KBBSGu2QZv+WoMue6azw/iHJSxuiMVWfmDUfSWxA
 7uJ9ze0Hct1PerfGicIXOHU=
X-Google-Smtp-Source: ABdhPJyPW3mc2rl6LjDNVIo7U/7GXPuRodp/tiEJiegxksa2IqC/S5vF1kHBS0G+Zgd1fxT0kjpidw==
X-Received: by 2002:aa7:d550:: with SMTP id u16mr9565282edr.72.1621604153975; 
 Fri, 21 May 2021 06:35:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d?
 ([2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d])
 by smtp.gmail.com with ESMTPSA id df8sm3942018edb.58.2021.05.21.06.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 06:35:52 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix inconsistent indenting
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, alexander.deucher@amd.com
References: <1621590628-75988-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <09e40764-1d3a-0dfe-b278-5b5ce04670a9@gmail.com>
Date: Fri, 21 May 2021 15:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621590628-75988-1-git-send-email-jiapeng.chong@linux.alibaba.com>
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
Cc: airlied@linux.ie, Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, sumit.semwal@linaro.org, linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDUuMjEgdW0gMTE6NTAgc2NocmllYiBKaWFwZW5nIENob25nOgo+IEVsaW1pbmF0ZSB0
aGUgZm9sbG93IHNtYXRjaCB3YXJuaW5nOgo+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NV8wLmM6NDQ5Cj4gc2RtYV92NV8wX3JpbmdfZW1pdF9tZW1fc3luYygpIHdhcm46IGlu
Y29uc2lzdGVudCBpbmRlbnRpbmcuCj4KPiBSZXBvcnRlZC1ieTogQWJhY2kgUm9ib3QgPGFiYWNp
QGxpbnV4LmFsaWJhYmEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEppYXBlbmcgQ2hvbmcgPGppYXBl
bmcuY2hvbmdAbGludXguYWxpYmFiYS5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjVfMC5jIHwgMTMgKysrKysrLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjVfMC5jCj4gaW5kZXggNzVkNzMxMC4uYzQ1ZTFiMCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCj4gQEAgLTQ0MCwyMCArNDQwLDE5IEBAIHN0
YXRpYyB2b2lkIHNkbWFfdjVfMF9yaW5nX2VtaXRfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
LAo+ICAgICovCj4gICBzdGF0aWMgdm9pZCBzZG1hX3Y1XzBfcmluZ19lbWl0X21lbV9zeW5jKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIHsKPiAtICAgIHVpbnQzMl90IGdjcl9jbnRsID0K
PiAtCQkgICAgU0RNQV9HQ1JfR0wyX0lOViB8IFNETUFfR0NSX0dMMl9XQiB8IFNETUFfR0NSX0dM
TV9JTlYgfAo+IC0JCQlTRE1BX0dDUl9HTDFfSU5WIHwgU0RNQV9HQ1JfR0xWX0lOViB8IFNETUFf
R0NSX0dMS19JTlYgfAo+IC0JCQlTRE1BX0dDUl9HTElfSU5WKDEpOwo+ICsJdWludDMyX3QgZ2Ny
X2NudGwgPSBTRE1BX0dDUl9HTDJfSU5WIHwgU0RNQV9HQ1JfR0wyX1dCIHwgU0RNQV9HQ1JfR0xN
X0lOViB8Cj4gKwkJCSAgICBTRE1BX0dDUl9HTDFfSU5WIHwgU0RNQV9HQ1JfR0xWX0lOViB8IFNE
TUFfR0NSX0dMS19JTlYgfAo+ICsJCQkgICAgU0RNQV9HQ1JfR0xJX0lOVigxKTsKPiAgIAo+ICAg
CS8qIGZsdXNoIGVudGlyZSBjYWNoZSBMMC9MMS9MMiwgdGhpcyBjYW4gYmUgb3B0aW1pemVkIGJ5
IHBlcmZvcm1hbmNlIHJlcXVpcmVtZW50ICovCj4gICAJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywg
U0RNQV9QS1RfSEVBREVSX09QKFNETUFfT1BfR0NSX1JFUSkpOwo+ICAgCWFtZGdwdV9yaW5nX3dy
aXRlKHJpbmcsIFNETUFfUEtUX0dDUl9SRVFfUEFZTE9BRDFfQkFTRV9WQV8zMV83KDApKTsKPiAg
IAlhbWRncHVfcmluZ193cml0ZShyaW5nLCBTRE1BX1BLVF9HQ1JfUkVRX1BBWUxPQUQyX0dDUl9D
T05UUk9MXzE1XzAoZ2NyX2NudGwpIHwKPiAtCQkJU0RNQV9QS1RfR0NSX1JFUV9QQVlMT0FEMl9C
QVNFX1ZBXzQ3XzMyKDApKTsKPiArCQkJICBTRE1BX1BLVF9HQ1JfUkVRX1BBWUxPQUQyX0JBU0Vf
VkFfNDdfMzIoMCkpOwo+ICAgCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFNETUFfUEtUX0dDUl9S
RVFfUEFZTE9BRDNfTElNSVRfVkFfMzFfNygwKSB8Cj4gLQkJCVNETUFfUEtUX0dDUl9SRVFfUEFZ
TE9BRDNfR0NSX0NPTlRST0xfMThfMTYoZ2NyX2NudGwgPj4gMTYpKTsKPiArCQkJICBTRE1BX1BL
VF9HQ1JfUkVRX1BBWUxPQUQzX0dDUl9DT05UUk9MXzE4XzE2KGdjcl9jbnRsID4+IDE2KSk7Cj4g
ICAJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QS1RfR0NSX1JFUV9QQVlMT0FENF9MSU1J
VF9WQV80N18zMigwKSB8Cj4gLQkJCVNETUFfUEtUX0dDUl9SRVFfUEFZTE9BRDRfVk1JRCgwKSk7
Cj4gKwkJCSAgU0RNQV9QS1RfR0NSX1JFUV9QQVlMT0FENF9WTUlEKDApKTsKPiAgIH0KPiAgIAo+
ICAgLyoqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
