Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E3BC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE18564F60
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18564F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBA06EA65;
	Thu,  4 Mar 2021 18:55:04 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45C86EA5B;
 Thu,  4 Mar 2021 18:05:55 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id dx17so23591338ejb.2;
 Thu, 04 Mar 2021 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1kFbFZPA0oqUzyK6k1THFBO4JGyWy6axKrA1ySkqkG0=;
 b=EZcYifieQPOY3UzN/TTrHw1uGwcr/xOpWgejGfki5fh5OGvfRGw7NWPb4iml+oT7D/
 0sdH8AZNpVCn+PG35swfOOZ6KclMkVajlL48RQIIONOR+HQcoForzm0u+8eS7eKOA/0E
 +jBkYVxay68hpG3on+h9C/Slz1vn7ywHdE8xp7F3DU8uE1ir3B0l/9+104Bhea4yNWIx
 y7Uc3CjP5fMgcf1qIcSW87J9vkA5lMn5vY8DaIXW68W1qEKRpVkkSIQ/F81GtBWC11OR
 rfKl3MOirFvok4YZo2Zh1ACEV/tWltEnJQyDdUCjqRyiUvNczW9VhVmt0VCPA/7EkcuD
 WH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1kFbFZPA0oqUzyK6k1THFBO4JGyWy6axKrA1ySkqkG0=;
 b=QquwfD+ii98rvFUq9GTJ2vuk0AGIy0wpQQMh15lisMf/FRbu2ktNi1M70Bw7wwynkJ
 JEVrQ1Al0SpSoHomH1GAplf1lRgtw5K3rqqhs9ngJoFtrqPtMDy0K01ZMjbfdMA5+nE3
 /837g+69LL7uDA9DNlvOBQ/W5zZjNhU7Ype1KNjcfdulgKeD+0CmaD+IiS8rSE+eRZBS
 fba+PfzGM6ynoZq+FDpvV4ecLGXG3yzzs5d34BDH8xX4zc9fMroI2UWPb9Bvxnk4Nr/F
 7Ak3J7/QXHoCbCQEUrwdJU9qY3zuhH6oYfZSSOMUBiPM9R52hgJdT3HLm1XxZJls1bNd
 MQ9Q==
X-Gm-Message-State: AOAM533UIUQFNZ2qXvdOW2Ljmb60x7Udk49FFP4UNDnc+RsDdXOF5jDv
 hnI6G7fo4d0exfr5girasi4=
X-Google-Smtp-Source: ABdhPJzfXRQwiddGgkdTWQ9x5UtvXBwSjKAXf2IUgmn4hC1E5lbsS+uKa6NKDDhdZkNEemeOuN6bxA==
X-Received: by 2002:a17:906:3b99:: with SMTP id
 u25mr5587920ejf.277.1614881154444; 
 Thu, 04 Mar 2021 10:05:54 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:3d04:4b7c:635f:3a0?
 ([2a02:908:1252:fb60:3d04:4b7c:635f:3a0])
 by smtp.gmail.com with ESMTPSA id y12sm2368ejb.104.2021.03.04.10.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Mar 2021 10:05:54 -0800 (PST)
Subject: Re: [PATCH] drm/ttm: ioremap buffer according to TTM mem caching
 setting
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, brahma_sw_dev@amd.com
References: <1614873891-5836-1-git-send-email-Oak.Zeng@amd.com>
 <69501a46-ffbe-437c-3651-03400b3455a5@amd.com>
 <4fd6a67c-34dd-9510-4057-835c0c8eb190@gmail.com>
 <cc59a59a-116e-68d7-88fd-6c359a5e98c5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d02a157f-55b0-0454-6470-889055cbfb43@gmail.com>
Date: Thu, 4 Mar 2021 19:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cc59a59a-116e-68d7-88fd-6c359a5e98c5@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 04 Mar 2021 18:55:02 +0000
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
Cc: Alexander.Deucher@amd.com, jinhuieric.huang@amd.com, Felix.Kuehling@amd.com,
 harish.kasiviswanathan@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNC4wMy4yMSB1bSAxODo0MCBzY2hyaWViIEJoYXJkd2FqLCBSYWpuZWVzaDoKPgo+IE9u
IDMvNC8yMDIxIDEyOjMxIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBbQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWxdCj4+Cj4+IEFtIDA0LjAzLjIxIHVtIDE4OjAxIHNjaHJpZWIgQmhhcmR3
YWosIFJham5lZXNoOgo+Pj4gSSB3YXMgd29uZGVyaW5nIGlmIGEgbWFuYWdlZCB2ZXJzaW9uIG9m
IHN1Y2ggQVBJIGV4aXN0cyBidXQgbG9va3MgbGlrZQo+Pj4gbm9uZS4gV2Ugb25seSBoYXZlIGRl
dm1faW9yZW1hcF93YyBidXQgdGhhdCBpcyB2YWxpZCBvbmx5IGZvcgo+Pj4gUEFHRV9DQUNIRV9N
T0RFX1dDIHdoZXJlYXMgaW9yZW1hcF9jYWNoZSB1c2VzIF9XQi4gT25lIG1vcmUgc21hbGwKPj4+
IGNvbW1lbnQgYmVsb3cuCj4+Pgo+Pj4KPj4+IEFja2VkLWJ5OiBSYWpuZWVzaCBCaGFyZHdhaiA8
cmFqbmVlc2guYmhhcmR3YWpAYW1kLmNvbT4KPj4+Cj4+PiBPbiAzLzQvMjAyMSAxMTowNCBBTSwg
T2FrIFplbmcgd3JvdGU6Cj4+Pj4gSWYgdGJvLm1lbS5idXMuY2FjaGluZyBpcyBjYWNoZWQsIGJ1
ZmZlciBpcyBpbnRlbmRlZCB0byBiZSBtYXBwZWQKPj4+PiBhcyBjYWNoZWQgZnJvbSBDUFUuIE1h
cCBpdCB3aXRoIGlvcmVtYXBfY2FjaGUuCj4+Pj4KPj4+PiBUaGlzIHdhc24ndCBuZWNlc3Nhcnkg
YmVmb3JlIGFzIGRldmljZSBtZW1vcnkgd2FzIG5ldmVyIG1hcHBlZAo+Pj4+IGFzIGNhY2hlZCBm
cm9tIENQVSBzaWRlLiBJdCBiZWNvbWVzIG5lY2Vzc2FyeSBmb3IgYWxkZWJhcmFuIGFzCj4+Pj4g
ZGV2aWNlIG1lbW9yeSBpcyBtYXBwZWQgY2FjaGVkIGZyb20gQ1BVLgo+Pj4+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLb25pZyA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyB8IDE0ICsrKysrKysrKysrKysrCj4+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKPj4+Pgo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMKPj4+PiBiL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvX3V0aWwuYwo+Pj4+IGluZGV4IDAzMWU1ODEuLjc0Mjk0NjQgMTAwNjQ0
Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCj4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCj4+Pj4gQEAgLTkxLDYgKzkxLDEwIEBA
IHN0YXRpYyBpbnQgdHRtX3Jlc291cmNlX2lvcmVtYXAoc3RydWN0IHR0bV9kZXZpY2UKPj4+PiAq
YmRldiwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtZW0tPmJ1cy5jYWNoaW5nID09
IHR0bV93cml0ZV9jb21iaW5lZCkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRy
ID0gaW9yZW1hcF93YyhtZW0tPmJ1cy5vZmZzZXQsIGJ1c19zaXplKTsKPj4+PiArI2lmZGVmIENP
TkZJR19YODYKPj4+Cj4+Pgo+Pj4gUGxlYXNlIHVzZSAjaWYgZGVmaW5lZCAoQ09ORklHX1g4NikK
Pj4KPj4gQWN0dWFsbHkgI2lmZGVmIGlzIHVzdWFsbHkgcHJlZmVycmVkLgo+Cj4gb29wcywgaSB3
YXMgcmVmZXJyaW5nIHRvIElTX0VOQUJMRUQgKENPTkZJRykgYW5kIG5vdCBpZiBkZWZpbmVkLgoK
V2VsbCwgdGhhdCBpcyBpbmRlZWQgYSBnb29kIGlkZWEgZm9yIG1vc3QgY29uZmlnIG9wdGlvbnMu
CgpCdXQgaW4gdGhpcyBjYXNlICNpZmRlZiBhbG9uZSBzaG91bGQgd29yayBhcyB3ZWxsLgoKQ2hy
aXN0aWFuLgoKPgo+Cj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGVsc2UgaWYgKG1lbS0+YnVzLmNhY2hpbmcgPT0gdHRtX2NhY2hlZCkKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhZGRyID0gaW9yZW1hcF9jYWNoZShtZW0tPmJ1cy5vZmZzZXQsIGJ1c19z
aXplKTsKPj4+PiArI2VuZGlmCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyID0gaW9yZW1hcChtZW0tPmJ1cy5vZmZzZXQsIGJ1
c19zaXplKTsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFhZGRyKSB7Cj4+Pj4gQEAgLTM3
Miw2ICszNzYsMTEgQEAgc3RhdGljIGludCB0dG1fYm9faW9yZW1hcChzdHJ1Y3QKPj4+PiB0dG1f
YnVmZmVyX29iamVjdCAqYm8sCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtZW0tPmJ1cy5j
YWNoaW5nID09IHR0bV93cml0ZV9jb21iaW5lZCkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtYXAtPnZpcnR1YWwgPSBpb3JlbWFwX3djKGJvLT5tZW0uYnVzLm9mZnNldCArIG9mZnNl
dCwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2l6ZSk7Cj4+Pj4gKyNpZmRlZiBDT05GSUdfWDg2Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGVsc2UgaWYgKG1lbS0+YnVzLmNhY2hpbmcgPT0gdHRtX2NhY2hlZCkKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBtYXAtPnZpcnR1YWwgPSBpb3JlbWFwX2NhY2hlKGJvLT5tZW0uYnVzLm9m
ZnNldCArIG9mZnNldCwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2l6ZSk7Cj4+Pj4gKyNlbmRpZgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBlbHNlCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFwLT52aXJ0dWFsID0gaW9y
ZW1hcChiby0+bWVtLmJ1cy5vZmZzZXQgKyBvZmZzZXQsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSk7Cj4+Pj4gQEAgLTQ5
MCw2ICs0OTksMTEgQEAgaW50IHR0bV9ib192bWFwKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAq
Ym8sCj4+Pj4gc3RydWN0IGRtYV9idWZfbWFwICptYXApCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGVsc2UgaWYgKG1lbS0+YnVzLmNhY2hpbmcgPT0gdHRtX3dyaXRlX2NvbWJpbmVkKQo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyX2lvbWVtID0gaW9yZW1hcF93YyhtZW0tPmJ1
cy5vZmZzZXQsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBiby0+YmFzZS5zaXplKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAo
bWVtLT5idXMuY2FjaGluZyA9PSB0dG1fY2FjaGVkKQo+Pj4+ICsjaWZkZWYgQ09ORklHX1g4Ngo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyX2lvbWVtID0gaW9yZW1hcF9jYWNoZSht
ZW0tPmJ1cy5vZmZzZXQsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJvLT5iYXNlLnNpemUpOwo+Pj4+ICsjZW5kaWYKPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZWxzZQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyX2lv
bWVtID0gaW9yZW1hcChtZW0tPmJ1cy5vZmZzZXQsIGJvLT5iYXNlLnNpemUpOwo+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wNCU3QzAxJTdDcmFqbmVlc2guYmhhcmR3YWolNDBhbWQuY29tJTdDYzQzODY1NDRlYTEw
NDg3ZDNhMGMwOGQ4ZGYzMzYzYTElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3NTA0NzU5MjY0NzkzOTcwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzEwMDAmYW1wO3NkYXRhPW5NMlV0UVFkQWN0eWFwZlpTcmhmeCUyQm9KJTJCZHN6VjRZ
cDYyTFRlaHNVV3dZJTNEJmFtcDtyZXNlcnZlZD0wIAo+Pj4KPj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
