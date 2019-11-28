Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B91AC432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 12:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677B22084D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 12:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3095C6E7D5;
	Thu, 28 Nov 2019 12:06:04 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797706E7D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 12:06:02 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p17so5488488wma.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 04:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=fF3EOiKOXL7pXYxR3f02m3QXpPBgur77+L1FVqYpXX4=;
 b=UJIz4eEwBLANKNMBT9MB/vu5Yap3T2nmDoYH33NLgQupiCnuCp7RbT5aqzYj3SZmCO
 1bkUCPdDIjXl0Aau19472kmXlv2OvD0ibfFccB5YJDKqwjp36FzdP0zUb9P+oxy9uwql
 iu+SUlb2F9rxcs8MD3B6oA6RX2tncJayX6jHE4eDHSJt0MErrA6HFYGPmTWyByAjebP4
 VJ1frmtXjhcC41lAWnWoYxBu0Ia+kbkWsck7Z5RW9iLBXSPvBtcRnh9g4ORIy551W2l3
 F8N+LXj+u8u+on1wzcwlWzOKH9ckcinskhScL9i7SuhVtPnweckqrBl+5u8z5n0CQFvH
 Y3Sg==
X-Gm-Message-State: APjAAAWa1FOP2OXHfM1YYEn+bMYlwyxsPb26exyoJhTz09odLYHlCIw3
 ApoM7zzXmtPZWQx3olYAboo=
X-Google-Smtp-Source: APXvYqxQdWtBuuz8ocVH8FUcqiYWa4Dkzm7FiaesE44CgqmIPKqxTGv8vXlgYNGLlGT12Zfs3L+NBA==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr121854wmb.73.1574942761198;
 Thu, 28 Nov 2019 04:06:01 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id m3sm24467515wrb.67.2019.11.28.04.06.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Nov 2019 04:06:00 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: move CS secure flag next the structs where
 it's used
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191127205646.953566-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <55588fa0-9e8c-8ee8-94f9-86c4ee4e8a21@gmail.com>
Date: Thu, 28 Nov 2019 13:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127205646.953566-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fF3EOiKOXL7pXYxR3f02m3QXpPBgur77+L1FVqYpXX4=;
 b=h8wXvhKnCEu50xOTBPXS1rfc5rxXkKrhu4+YDZchdHVCX0nJdDSgtyX47zdos+c9Lm
 D98ZEYOrIAnsadZMPt5MOmTuYZ16Y3xo++3XRFAXb2cvJsEUPXjV1TCPvqEh0fc9B8U0
 4WqfUUjFUv1h0EYa8e1V/vdBYhkWkVPIFVIuejkfEPgu9Zw3ftdtNQ0P4KHo1eGFMKgi
 13HnbwLUYZStorO/NHUHO2C12pNgkHuIYtUVe95OG2zCgrtheVREKzBirmjBgvo+Kb3E
 6wVwgm9hCQ+qqm78x5TpboiIVP5UuKUkPY2pgVvK+K3a0erUXv+/d2j2JZhcFkuxMJ++
 NUIw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191128120558.uOHEd0XT6mqzELOwbTxMwXbr786GHgMk0NAdKO-5KFs@z>

QW0gMjcuMTEuMTkgdW0gMjE6NTYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gU28gaXQncyBub3Qg
bWl4ZWQgdXAgd2l0aCB0aGUgQ1RYIHN0dWZmLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBpbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaCB8IDYgKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0v
YW1kZ3B1X2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPiBpbmRleCBmNzVj
Njk1NzA2NGQuLjkxOGFjMzU0OGNkMyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2Ft
ZGdwdV9kcm0uaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4gQEAgLTIw
Nyw5ICsyMDcsNiBAQCB1bmlvbiBkcm1fYW1kZ3B1X2JvX2xpc3Qgewo+ICAgI2RlZmluZSBBTURH
UFVfQ1RYX09QX1FVRVJZX1NUQVRFCTMKPiAgICNkZWZpbmUgQU1ER1BVX0NUWF9PUF9RVUVSWV9T
VEFURTIJNAo+ICAgCj4gLS8qIEZsYWcgdGhlIGNvbW1hbmQgc3VibWlzc2lvbiBhcyBzZWN1cmUg
Ki8KPiAtI2RlZmluZSBBTURHUFVfQ1NfRkxBR1NfU0VDVVJFICAgICAgICAgICgxIDw8IDApCj4g
LQo+ICAgLyogR1BVIHJlc2V0IHN0YXR1cyAqLwo+ICAgI2RlZmluZSBBTURHUFVfQ1RYX05PX1JF
U0VUCQkwCj4gICAvKiB0aGlzIHRoZSBjb250ZXh0IGNhdXNlZCBpdCAqLwo+IEBAIC01NTksNiAr
NTU2LDkgQEAgc3RydWN0IGRybV9hbWRncHVfY3NfY2h1bmsgewo+ICAgCV9fdTY0CQljaHVua19k
YXRhOwo+ICAgfTsKPiAgIAo+ICsvKiBGbGFnIHRoZSBjb21tYW5kIHN1Ym1pc3Npb24gYXMgc2Vj
dXJlICovCj4gKyNkZWZpbmUgQU1ER1BVX0NTX0ZMQUdTX1NFQ1VSRSAgICAgICAgICAoMSA8PCAw
KQo+ICsKPiAgIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2luIHsKPiAgIAkvKiogUmVuZGVyaW5nIGNv
bnRleHQgaWQgKi8KPiAgIAlfX3UzMgkJY3R4X2lkOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
