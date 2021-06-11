Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01AAC48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1EF6124C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1EF6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A33C6E02B;
	Fri, 11 Jun 2021 10:05:02 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DCC6E02B;
 Fri, 11 Jun 2021 10:05:01 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id d184so7797007wmd.0;
 Fri, 11 Jun 2021 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5xVxhVrGpeYgPINr7CYadkVeo4fwTn98UNDLrVw0lLA=;
 b=Y6YVR596mrBeh0jqyZNxmBsD3ZRzCOpAeNsWY8Ywo8p6Q8d78laE5dMl8idiebpli3
 omITRKl4PuOkBOuqLeMLLfW5iEWE9QEV4l+zYnYA19nwq2dz5svJ7BE5ulfzqP+5J+0x
 byaR0LAlN/ZXzbxmbQ11TXQ5Cfx3H7WWOcf5w1/xZrcAxCgT7Kj6scAt/oooof8/U1bR
 OCaW0+D0SZ58eQj6Q6oVGHqA1Oyg+c965ZmQz9NIETv1uKSkhdxx9ajK50X+4wmWp0EQ
 kfk6/1LBKzmh7Z6lwsVRzVfg+h2BsfaG/U7crYOYIEzPVmmB+sPGTLz7AcqTmDtjnysl
 FeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5xVxhVrGpeYgPINr7CYadkVeo4fwTn98UNDLrVw0lLA=;
 b=aFpU0UrKE8Ck7QtsScQOs/9Zro3agDCiAB7a5L2JIDKZQol7EXw5ODBzFtLL14wyGL
 ITVRp5b5iWi2BbXehbc67ujBp/u4OEF6d9Io5W6DxWmCppWtguj7MYobKF/0B6OqOCnl
 zwwCcUpo7rhQPdwS6EOQxtyZkRmIhj9YwKv1EA8X+KW4+YLUFLHuxOiF5wWiTSz8YGZl
 hNZksUc8CDkn3s1qtNTfCtiizZ1QwxGMPHf0uT+Za7LXf9tV9h+nFYNH8WfeARnv4wMV
 DTQa1fM/RIafa+7wxikirxHI3R3fTx/xGkzPMI6AdkeQJOrGHGpNuCC/sariXlKagCSu
 pRdw==
X-Gm-Message-State: AOAM531UTJFOLZZ7rbSuT35szuxxF4p0DSLeNWhWOyTRsPC1dwzZnWuW
 rSlUsVSqaPB+34GbDQ9m9MAjzTh5/Oc=
X-Google-Smtp-Source: ABdhPJzJc5/S5B1hzsNZ2W9NdfCfL7C75qTUMj95HYrgYWvQFdeAPHUJFvkU4HADRHHnU0CZ7LTd6Q==
X-Received: by 2002:a05:600c:1c28:: with SMTP id
 j40mr19509365wms.102.1623405900066; 
 Fri, 11 Jun 2021 03:05:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:108e:ba37:cb49:9c3?
 ([2a02:908:1252:fb60:108e:ba37:cb49:9c3])
 by smtp.gmail.com with ESMTPSA id 2sm6345120wrz.87.2021.06.11.03.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 03:04:59 -0700 (PDT)
Subject: Re: [PATCH 3/7] dma-buf: add dma_fence_chain_alloc/free self tests
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210610091800.1833-1-christian.koenig@amd.com>
 <20210610091800.1833-4-christian.koenig@amd.com>
 <YMMXlF5A7uB0sORs@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e1f4954e-2c7b-49ab-5782-f06d81a6304a@gmail.com>
Date: Fri, 11 Jun 2021 12:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMMXlF5A7uB0sORs@phenom.ffwll.local>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDYuMjEgdW0gMDk6NTggc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFRodSwgSnVu
IDEwLCAyMDIxIGF0IDExOjE3OjU2QU0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
IEV4ZXJjaXNlIHRoZSBuZXdseSBhZGRlZCBmdW5jdGlvbnMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBJIGhhdmUgaG9u
ZXN0bHkgbm8gaWRlYSB3aGF0IHRoaXMgY2hlY2tzLiBTcGF3bmluZyBhIGZldyB0aHJlYWRzIHRv
Cj4gdmFsaWRhdGUga21hbGxvYy9rZnJlZSBmZWVscyBhIGJpdCBzaWxseS4gTm93IHRlc3Rpbmcg
d2hldGhlciB3ZSBjb3JyZWN0bHkKPiByY3UtZGVsYXkgdGhlIGZyZWVpbmcgaGVyZSB3b3VsZCBt
YWtlIHNvbWUgc2Vuc2UsIGJ1dCBldmVuIHRoYXQgZmVlbHMgYQo+IGJpdCBzaWxseS4KPgo+IEkg
Z3Vlc3MgaWYgeW91IHdhbnQgdGhpcyBleHBsYWluIHdpdGggY29tbWVudHMgd2hhdCBpdCBkb2Vz
IGFuZCB3aHk/CgpUaGlzIHdhcyBzb2xleSB0byBmaWd1cmUgb3V0IGlmIHRoZSBnYXJiYWdlIGNv
bGxlY3Rpb24gaXMgd29ya2luZyAKcHJvcGVybHkgYW5kIGhvdyBtdWNoIG92ZXJoZWFkIGl0IGdl
bmVyYXRlcy4KCk5vIGFjdHVhbCBuZWVkIHRvIGNvbW1pdCBpdC4KCkNocmlzdGlhbi4KCj4gLURh
bmllbAo+Cj4KPj4gLS0tCj4+ICAgZHJpdmVycy9kbWEtYnVmL3N0LWRtYS1mZW5jZS1jaGFpbi5j
IHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0
OCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYvc3QtZG1h
LWZlbmNlLWNoYWluLmMgYi9kcml2ZXJzL2RtYS1idWYvc3QtZG1hLWZlbmNlLWNoYWluLmMKPj4g
aW5kZXggOGNlMWVhNTlkMzFiLi44NTVjMTI5YzYwOTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
ZG1hLWJ1Zi9zdC1kbWEtZmVuY2UtY2hhaW4uYwo+PiArKysgYi9kcml2ZXJzL2RtYS1idWYvc3Qt
ZG1hLWZlbmNlLWNoYWluLmMKPj4gQEAgLTk1LDYgKzk1LDUzIEBAIHN0YXRpYyBpbnQgc2FuaXR5
Y2hlY2sodm9pZCAqYXJnKQo+PiAgIAlyZXR1cm4gZXJyOwo+PiAgIH0KPj4gICAKPj4gK3N0YXRp
YyBpbnQgX19hbGxvY19mcmVlKHZvaWQgKmFyZykKPj4gK3sKPj4gKwlhdG9taWNfdCAqY291bnRl
ciA9IGFyZzsKPj4gKwlpbnQgaSwgajsKPj4gKwo+PiArCWZvciAoaSA9IDA7IGkgPCAxMDI0OyAr
K2kpIHsKPj4gKwkJc3RydWN0IGRtYV9mZW5jZV9jaGFpbiAqY2hhaW5zWzY0XTsKPj4gKwo+PiAr
CQlmb3IgKGogPSAwOyBqIDwgQVJSQVlfU0laRShjaGFpbnMpOyArK2opCj4+ICsJCQljaGFpbnNb
al0gPSBkbWFfZmVuY2VfY2hhaW5fYWxsb2MoKTsKPj4gKwo+PiArCQlmb3IgKGogPSAwOyBqIDwg
QVJSQVlfU0laRShjaGFpbnMpOyArK2opCj4+ICsJCQlkbWFfZmVuY2VfY2hhaW5fZnJlZShjaGFp
bnNbal0pOwo+PiArCj4+ICsJCWF0b21pY19hZGQoQVJSQVlfU0laRShjaGFpbnMpLCBjb3VudGVy
KTsKPj4gKwl9Cj4+ICsJcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyBpbnQgYWxsb2Nf
ZnJlZSh2b2lkICphcmcpCj4+ICt7Cj4+ICsJc3RydWN0IHRhc2tfc3RydWN0ICp0aHJlYWRzWzhd
Owo+PiArCWF0b21pY190IGNvdW50ZXIgPSBBVE9NSUNfSU5JVCgwKTsKPj4gKwlpbnQgaSwgZXJy
ID0gMDsKPj4gKwo+PiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHRocmVhZHMpOyBpKysp
IHsKPj4gKwkJdGhyZWFkc1tpXSA9IGt0aHJlYWRfcnVuKF9fYWxsb2NfZnJlZSwgJmNvdW50ZXIs
ICJkbWFidWYvJWQiLAo+PiArCQkJCQkgaSk7Cj4+ICsJCWlmIChJU19FUlIodGhyZWFkc1tpXSkp
IHsKPj4gKwkJCWVyciA9IFBUUl9FUlIodGhyZWFkc1tpXSk7Cj4+ICsJCQlicmVhazsKPj4gKwkJ
fQo+PiArCX0KPj4gKwo+PiArCXdoaWxlIChpLS0pIHsKPj4gKwkJaW50IHJldDsKPj4gKwo+PiAr
CQlyZXQgPSBrdGhyZWFkX3N0b3AodGhyZWFkc1tpXSk7Cj4+ICsJCWlmIChyZXQgJiYgIWVycikK
Pj4gKwkJCWVyciA9IHJldDsKPj4gKwl9Cj4+ICsKPj4gKwlwcl9pbmZvKCJDb21wbGV0ZWQgJXUg
Y3ljbGVzXG4iLCBhdG9taWNfcmVhZCgmY291bnRlcikpOwo+PiArCj4+ICsJcmV0dXJuIGVycjsK
Pj4gK30KPj4gKwo+PiAgIHN0cnVjdCBmZW5jZV9jaGFpbnMgewo+PiAgIAl1bnNpZ25lZCBpbnQg
Y2hhaW5fbGVuZ3RoOwo+PiAgIAlzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2VzOwo+PiBAQCAtNjc3
LDYgKzcyNCw3IEBAIGludCBkbWFfZmVuY2VfY2hhaW4odm9pZCkKPj4gICB7Cj4+ICAgCXN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc3VidGVzdCB0ZXN0c1tdID0gewo+PiAgIAkJU1VCVEVTVChzYW5pdHlj
aGVjayksCj4+ICsJCVNVQlRFU1QoYWxsb2NfZnJlZSksCj4+ICAgCQlTVUJURVNUKGZpbmRfc2Vx
bm8pLAo+PiAgIAkJU1VCVEVTVChmaW5kX3NpZ25hbGVkKSwKPj4gICAJCVNVQlRFU1QoZmluZF9v
dXRfb2Zfb3JkZXIpLAo+PiAtLSAKPj4gMi4yNS4xCj4+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
