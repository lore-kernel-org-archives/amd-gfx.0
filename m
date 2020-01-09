Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B79FC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1DB20678
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8/sDa7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1DB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCF56E8F2;
	Thu,  9 Jan 2020 10:23:32 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EF96E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 10:23:31 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t14so2173490wmi.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 02:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7D0Yh0xlg5uJ3SkH5qR6VcUOLq/fum8/vZd7CJKfI7g=;
 b=u8/sDa7Dt1HKmQ+yGLcJ6SLPz8/yN2UuGgFfDWvFTg5XgUHlvngzRUF4tip7r1oqcP
 HBIeAOYRRNE0chRYUOJJHHV22xpPdVvtXyubIidv/5AdgfgPMqaYUmI0h+b+Za4I6Aer
 JKf+hjuPQVw+fDBJSgFZhkx0i39hKSEaxn9VfiGe8Q6WPuDB8Am7uOJgekBJZT7zfeZ6
 wO7brT3PX5IR8fvaE2bsaDD6ijNeJ5tu4zfcB2Er60Lk9BIk9X44RXUuz1SDPpZOS3C7
 9HwEpMLg4UPVMRnC9H/dDC4heJfAIrEhVUJdgIMxJ4HXl7q8QzoBME7jMNC/AZ1860Lb
 iBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=7D0Yh0xlg5uJ3SkH5qR6VcUOLq/fum8/vZd7CJKfI7g=;
 b=Pl69OS101V04EcKEs89ypNqspwpp8XWeoXQun171bobIWgkbMUW1XoB6nedhU1uu9l
 MbuNhyzvL6LZGnb1n2N6+S73bzGsRmp2b2ex6uFFsfagC7DHHRLY+MQPR1eMyEZgQ+Xd
 1xXp5ccmc9XW+yl2sZ3/+6PkAWjiU8C7LOt9V+Ky1PuqJ3YOAzH0wOnHLcGTkerQnXvk
 glGJJBi3AvWI/xBBzXKcPKBGzGYX0H7KmulB5YaoMwZYssQHLA+MQ0mjFDazCHfgO0/w
 wnCoGGDnEhwbF6daH9LyK1DhmpOSusfsxQwnB/0VL2TVXJ1agdT4FmrcQoo6KhB3a/VO
 dy9g==
X-Gm-Message-State: APjAAAXfstj0IJ2ou9uoiB+uszjNUCd6wtSKtpg4ikC6kCyzY1Bgy+wi
 wjggKehmlWqf9gpfet6hEMc=
X-Google-Smtp-Source: APXvYqxdoSbe1papoyVsHwNuhuiNlRusEnNaYM2bOlRVCNG+qUgi1+GsnePVn4uvBPMokQWBeXT49A==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr3623065wmc.145.1578565409832; 
 Thu, 09 Jan 2020 02:23:29 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t1sm2370892wma.43.2020.01.09.02.23.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 02:23:29 -0800 (PST)
Subject: Re: [PATCH 1/3] drm/amdgpu/display: set gpu vm flag for all asics
 which support it
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200108224910.289731-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <be75d123-7f91-2bc1-fdc5-6faeadfef400@gmail.com>
Date: Thu, 9 Jan 2020 11:23:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200108224910.289731-1-alexander.deucher@amd.com>
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

QW0gMDguMDEuMjAgdW0gMjM6NDkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gSXQgd29uJ3QgZ2V0
IHVzZWQgdW5sZXNzIHRoZSBkcml2ZXIgYWxsb3dzIHRoZSBndHQgZG9tYWluIGZvcgo+IGRpc3Bs
YXkgYnVmZmVycyB3aGljaCBpcyBjb250cm9sbGVkIGVsc2V3aGVyZS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkFja2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDE0ICsrKysr
KysrLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jCj4gaW5kZXggMTEyM2Y5Y2U4NmVlLi5mZGY0ZDIwMmVhMWYgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBA
QCAtOTA2LDEzICs5MDYsMTUgQEAgc3RhdGljIGludCBhbWRncHVfZG1faW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKPiAgIAo+ICAgCWluaXRfZGF0YS5kY2VfZW52aXJvbm1lbnQgPSBE
Q0VfRU5WX1BST0RVQ1RJT05fRFJWOwo+ICAgCj4gLQkvKgo+IC0JICogVE9ETyBkZWJ1ZyB3aHkg
dGhpcyBkb2Vzbid0IHdvcmsgb24gUmF2ZW4KPiAtCSAqLwo+IC0JaWYgKGFkZXYtPmZsYWdzICYg
QU1EX0lTX0FQVSAmJgo+IC0JICAgIGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX0NBUlJJWk8gJiYK
PiAtCSAgICBhZGV2LT5hc2ljX3R5cGUgPCBDSElQX1JBVkVOKQo+ICsJc3dpdGNoIChhZGV2LT5h
c2ljX3R5cGUpIHsKPiArCWNhc2UgQ0hJUF9DQVJSSVpPOgo+ICsJY2FzZSBDSElQX1NUT05FWToK
PiArCWNhc2UgQ0hJUF9SQVZFTjoKPiAgIAkJaW5pdF9kYXRhLmZsYWdzLmdwdV92bV9zdXBwb3J0
ID0gdHJ1ZTsKPiArCQlicmVhazsKPiArCWRlZmF1bHQ6Cj4gKwkJYnJlYWs7Cj4gKwl9Cj4gICAK
PiAgIAlpZiAoYW1kZ3B1X2RjX2ZlYXR1cmVfbWFzayAmIERDX0ZCQ19NQVNLKQo+ICAgCQlpbml0
X2RhdGEuZmxhZ3MuZmJjX3N1cHBvcnQgPSB0cnVlOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
