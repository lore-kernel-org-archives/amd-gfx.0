Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189AC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 14:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA5661165
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 14:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA5661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402F06E90F;
	Wed,  7 Apr 2021 14:04:10 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F106E90F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 14:04:08 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id j18so4912553lfg.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Apr 2021 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=g295EFxs1YYsD6pwsQkE1wDUagx/Fncy7BYcjj30vE4=;
 b=X5ObZkoPvy0mt4+4dEk6zNuM2/BX75bvviI/McW4tLkbN04Ge0R2znzaPjgpsphBDg
 TRn8qSMcOnmWM6wKyN1mjYZ9CC6CZIj0WZESRB+x/Y6d5iutF5sBVpnP8X9jBDe9dwZY
 J1b2Re2O2yV8r5tV+jCRRfbbEzDPtKkpWL/BbgqlhsCrFzGAxhjYD1a2qIjwMJOFLLPA
 wxaJVf8+LStHWFZoHGtAlj4v7WW9wytzkaiV36mSL6aILZqnz7g28SZqHNo5Idu00T9a
 E67UM8jq3d+g8l7N3Q8lV2mL2v6dpmyxcMPVok+Uv5h+H7gDJ5JVCnyKV8Y7dMwo4MXU
 9LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=g295EFxs1YYsD6pwsQkE1wDUagx/Fncy7BYcjj30vE4=;
 b=BAhqapXzGJk4rNDba1K6nntpeXl8R/QDzMcxa461DWCd+Adp1FK6sXOx7t3JXftMw6
 2dt1nYhDoit4Swj0ec8XTOww6SAjU3b6uNJr4o0/areLwhgtpL6VzL9A05MJu5hMKJRq
 NqziiOVwtD1RWzneDgKlchkKG+SDIFSXSAW8+NhjYCiQUsxpVsT6BBwq7erW9Tdotb8Q
 Q+dbaKXQaOhWL+HuCYlJl14li7Tc04PJuHGeA3C9R8AJqFAt3gighhulSx1tFcWrPWyu
 PiVKyLUEq9Brv/EgAlqPI6Ic0xiCvj76LxaBkdbzl/b4P8GIouSZaEiWQTcszSCdDTB0
 3ocQ==
X-Gm-Message-State: AOAM533cbuN/8kg58dA6pRGWGS5EAoF9KHiHf0Pb9lw/dq2TXZlHB36X
 SoXFJo0WvlJdbPjyxAmE4EQ=
X-Google-Smtp-Source: ABdhPJzcqucBVZjlMLh/p1SQt0o1y07nH/i9IyWbKP8XiskL8+YhViyX9aEv7AFS514kiOVw1+mo3A==
X-Received: by 2002:a05:6512:695:: with SMTP id
 t21mr2572110lfe.60.1617804246735; 
 Wed, 07 Apr 2021 07:04:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0?
 ([2a02:908:1252:fb60:c8cb:bea6:b85a:47d0])
 by smtp.gmail.com with ESMTPSA id h17sm2499910lfc.289.2021.04.07.07.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Apr 2021 07:04:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/scheduler: Change scheduled fence track
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210407133105.39702-1-Roy.Sun@amd.com>
 <20210407133105.39702-2-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <beb308cb-f1b9-f2c8-263d-b8aea85b5436@gmail.com>
Date: Wed, 7 Apr 2021 16:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210407133105.39702-2-Roy.Sun@amd.com>
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
Cc: Alexander.Deucher@amd.com, David M Nieto <david.nieto@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNy4wNC4yMSB1bSAxNTozMSBzY2hyaWViIFJveSBTdW46Cj4gVXBkYXRlIHRoZSB0aW1l
c3RhbXAgb2Ygc2NoZWR1bGVkIGZlbmNlIG9uIEhXCj4gY29tcGxldGlvbiBvZiB0aGUgcHJldmlv
dXMgZmVuY2VzCj4KPiBUaGlzIGFsbG93IG1vcmUgYWNjdXJhdGUgdHJhY2tpbmcgb2YgdGhlIGZl
bmNlCj4gZXhlY3V0aW9uIGluIEhXCj4KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNIE5pZXRvIDxk
YXZpZC5uaWV0b0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFJveSBTdW4gPFJveS5TdW5AYW1k
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwg
MTEgKysrKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+IGluZGV4
IDkyZDhkZTI0ZDBhMS4uNGU1ZDhkNGFmMDEwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9tYWluLmMKPiBAQCAtNTE1LDcgKzUxNSw3IEBAIHZvaWQgZHJtX3NjaGVkX3Jlc3Vi
bWl0X2pvYnMoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPiAgIEVYUE9SVF9TWU1C
T0woZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMpOwo+ICAgCj4gICAvKioKPiAtICogZHJtX3NjaGVk
X3Jlc3VibWl0X2pvYnNfZXh0IC0gaGVscGVyIHRvIHJlbHVuY2ggY2VydGFpbiBudW1iZXIgb2Yg
am9icyBmcm9tIG1pcnJvciByaW5nIGxpc3QKPiArICogZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnNf
ZXh0IC0gaGVscGVyIHRvIHJlbHVuY2ggY2VydGFpbiBudW1iZXIgb2Ygam9icyBmcm9tIHBlbmRp
bmcgbGlzdAoKcy9yZWx1bmNoL3JlbGF1bmNoLwoKV2l0aCB0aGF0IG5pdCBwaWNrIGZpeGVkIHRo
ZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KCj4gICAgKgo+ICAgICogQHNjaGVkOiBzY2hlZHVsZXIgaW5zdGFuY2UKPiAg
ICAqIEBtYXg6IGpvYiBudW1iZXJzIHRvIHJlbGF1bmNoCj4gQEAgLTY3MSw3ICs2NzEsNyBAQCBk
cm1fc2NoZWRfc2VsZWN0X2VudGl0eShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+
ICAgc3RhdGljIHN0cnVjdCBkcm1fc2NoZWRfam9iICoKPiAgIGRybV9zY2hlZF9nZXRfY2xlYW51
cF9qb2Ioc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPiAgIHsKPiAtCXN0cnVjdCBk
cm1fc2NoZWRfam9iICpqb2I7Cj4gKwlzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9iLCAqbmV4dDsK
PiAgIAo+ICAgCS8qCj4gICAJICogRG9uJ3QgZGVzdHJveSBqb2JzIHdoaWxlIHRoZSB0aW1lb3V0
IHdvcmtlciBpcyBydW5uaW5nICBPUiB0aHJlYWQKPiBAQCAtNjkwLDYgKzY5MCwxMyBAQCBkcm1f
c2NoZWRfZ2V0X2NsZWFudXBfam9iKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpCj4g
ICAJaWYgKGpvYiAmJiBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoJmpvYi0+c19mZW5jZS0+ZmluaXNo
ZWQpKSB7Cj4gICAJCS8qIHJlbW92ZSBqb2IgZnJvbSBwZW5kaW5nX2xpc3QgKi8KPiAgIAkJbGlz
dF9kZWxfaW5pdCgmam9iLT5saXN0KTsKPiArCQkvKiBhY2NvdW50IGZvciB0aGUgbmV4dCBmZW5j
ZSBpbiB0aGUgcXVldWUgKi8KPiArCQluZXh0ID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZz
Y2hlZC0+cGVuZGluZ19saXN0LAo+ICsJCQkJc3RydWN0IGRybV9zY2hlZF9qb2IsIGxpc3QpOwo+
ICsJCWlmIChuZXh0KSB7Cj4gKwkJCW5leHQtPnNfZmVuY2UtPnNjaGVkdWxlZC50aW1lc3RhbXAg
PQo+ICsJCQkJam9iLT5zX2ZlbmNlLT5maW5pc2hlZC50aW1lc3RhbXA7Cj4gKwkJfQo+ICAgCX0g
ZWxzZSB7Cj4gICAJCWpvYiA9IE5VTEw7Cj4gICAJCS8qIHF1ZXVlIHRpbWVvdXQgZm9yIG5leHQg
am9iICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
