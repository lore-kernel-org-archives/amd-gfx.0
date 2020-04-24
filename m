Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E04C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 06:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C412076C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 06:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwPAMFux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C412076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961AB6E441;
	Fri, 24 Apr 2020 06:37:28 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3986E441
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 06:37:26 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b11so9354105wrs.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=cML0r2Wvk0BBV0uyxLw8g1bKvPRGAH30AV3xYjbRU7U=;
 b=VwPAMFuxVb4VRX9Jeec4n627wZIxDpYOXMjVHawGpBg2ZElUhdRxpO+PcwoTB/C2XZ
 Ja8XcuWIvYu0m715bIItJy9Yuz/Oh2JHhznDG3TJx1zt2z/SPazRfksnfUYv4AtiB85G
 7Ci5fol2PaQ2qYUqTBmfViujxkHMhs8z+u41nZuPYp1seFlT5z4o8AQCyhV2OHjIhW53
 Z6+ciec2JZRK58NC9Gc833KHNwWAdOvqwKD8cJWIE0WXfjgCI6gwhfGMyPW0U4l2b9NV
 NaCm7cA7Hu/tKCg9WTw8tMD0u7HD/HrK74UxdaFv6E+TFKo0jHofa3F5EfD31i4XGuA3
 AKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=cML0r2Wvk0BBV0uyxLw8g1bKvPRGAH30AV3xYjbRU7U=;
 b=t0ICKQqphgIS8Gk5kTZQlnPYnSjw8lOgIraf9Xl0+93ESQGysA4a4OaNYOiC/w24jn
 773MYh5mfywH8PxYq9FBkdTyMtRRF9WWaILreqMLAUuR4uWIU62ZruXvV0Ink0nKdJ9n
 xtKwA/L4gzKYRMjWzRazV3Z/VdYZrV+Z0MJlC49WYcq+YKE+FYfcxuxafcS9y4Vay7Gr
 ogWylvAg+j4whc5mIAYDXAtNlUHktrexh+CcukJhbeu8xBtA0E8qBC6swJzo0tRKAxgC
 KSxZrwHlc0dt5SCVbk96LK1cuPzH3H2kE+3IawTS6fGtv9hDhUWi03KoyxoratchzzBB
 9SXQ==
X-Gm-Message-State: AGi0PuYvBIc0HPVaNTOqZxyj03zL8iD9XCwfG9Gr4jIHGWeuF9Jsy8lT
 6PSsz1Ne0x2dU8S6okZPL1rNc3fb
X-Google-Smtp-Source: APiQypJ0zp7s4bkFo5IzVbqwXruDU+rVZxpnLqo5FuJrPP1gCbJEVWhQJwpr+3tmgvZelxOul6GDDQ==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr8946177wrw.406.1587710245170; 
 Thu, 23 Apr 2020 23:37:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 60sm7224345wrr.7.2020.04.23.23.37.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2020 23:37:24 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: check ring type for secure IBs
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200423204720.1063581-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ba732761-0724-4bf0-d553-f81976838f8a@gmail.com>
Date: Fri, 24 Apr 2020 08:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423204720.1063581-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMDQuMjAgdW0gMjI6NDcgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gV2UgZG9uJ3Qgc3Vw
cG9ydCBzZWN1cmUgb3BlcmF0aW9uIG9uIGNvbXB1dGUgcmluZ3MgYXQgdGhlCj4gbW9tZW50IHNv
IHJlamVjdCB0aGVtLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWIuYyB8IDYgKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+IGluZGV4IGVjMmM1ZTE2
NGNkMy4uYjkxODUzZmQ2NmQzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2liLmMKPiBAQCAtMTYxLDYgKzE2MSwxMiBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZywgdW5zaWduZWQgbnVtX2licywKPiAgIAkJcmV0dXJuIC1FSU5W
QUw7Cj4gICAJfQo+ICAgCj4gKwlpZiAoKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHU19TRUNV
UkUpICYmCj4gKwkgICAgKHJpbmctPmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfQ09N
UFVURSkpIHsKPiArCQlkZXZfZXJyKGFkZXYtPmRldiwgInNlY3VyZSBzdWJtaXNzaW9ucyBub3Qg
c3VwcG9ydGVkIG9uIGNvbXB1dGUgcmluZ3NcbiIpOwo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsJ
fQo+ICsKPiAgIAlhbGxvY19zaXplID0gcmluZy0+ZnVuY3MtPmVtaXRfZnJhbWVfc2l6ZSArIG51
bV9pYnMgKgo+ICAgCQlyaW5nLT5mdW5jcy0+ZW1pdF9pYl9zaXplOwo+ICAgCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
