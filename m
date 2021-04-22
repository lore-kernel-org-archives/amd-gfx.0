Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA4C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 07:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E59613D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 07:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E59613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D4E6EA35;
	Thu, 22 Apr 2021 07:06:30 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FC46EA36
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 07:06:29 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id h10so52108656edt.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6oFWh5SuLkaELOgGvZVWf8Fd4bYDcP/jD7GpE0uC2L0=;
 b=I6HSaIaoCdY7p20L2KmKC26BRq7OAkC9l0cwQF9njS7WOKcCtAQ6w0RsSp8oa1ISzd
 Zir08T0QZWbKAZcU8p7URcUaQYSBbF4FbZlOcmy+GzVIkGbrz8zRM65NApHn75M7R7tG
 aAilsfBffjK8R/eDPTC4xFEUpxvJfmYUzbHyBWrPbb0Cwl4fksO1RsDqrd3zDGlV1YOf
 rG0SZA4mY2T8tn6VQ3T9KoXaqG7ACqB0uqRz3TNlA5Fid7Ay8JgVhyOnudRTqQcVL8/U
 EzjZa9B9YqY/J0dkdDoPy499PekrtvCq17JYEVe3bOBr80iC3wMropSHXEmXhKtNUZMp
 a7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6oFWh5SuLkaELOgGvZVWf8Fd4bYDcP/jD7GpE0uC2L0=;
 b=X3ZtkI6iJzNZQqhTwXYTXuM5CFUsuHZyMbrrc01umaW7cAS97j7FM6d/swm7LAh2N8
 jyYB5xS9LpO7OLwS3NZsfyGRJs9jNwtH/BN8osl9RHGZmO850K+pFYFldYSzVkvpFfAg
 pOWTKOCYVsvErVYEWB0/q4s1550XCDBJvt/kBJ0nXMwcjTG/QskBEnQ2wF2R7NDN4h+D
 iPvFLvPh5WNJfhgt5lm0S+jtOCrI+GhfVZbuUM1VfkCfbpJrD7IH/4aaUe2QFpI51kVS
 iXvdiPsDTV8wUlDFIbNaEdmA+qoMc+uz8LSSfpIROOKcA5+HYdC3dFbfHUjHCzxNH8EJ
 nC9w==
X-Gm-Message-State: AOAM530NJce0riJd0H6LEHULsyOZiWE52MwM7j+zeorTodCf42d7kbBu
 /a9LmIg0SF5AzucB4QCw2Wvdheoo0uo=
X-Google-Smtp-Source: ABdhPJzB9JuRz8LceDGFvIABSOCSNnNx24+evRQn5cpXYRgiO2YnpVvcexHaqMGoeuqsY8tg081gJA==
X-Received: by 2002:a50:f28e:: with SMTP id f14mr1956614edm.371.1619075188525; 
 Thu, 22 Apr 2021 00:06:28 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2fbd:d2a4:da7e:4526?
 ([2a02:908:1252:fb60:2fbd:d2a4:da7e:4526])
 by smtp.gmail.com with ESMTPSA id jw7sm1204463ejc.4.2021.04.22.00.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 00:06:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210421034636.27816-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <11583238-7e2e-38c8-a8e1-503cd6d4126f@gmail.com>
Date: Thu, 22 Apr 2021 09:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421034636.27816-1-Roy.Sun@amd.com>
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyMS4wNC4yMSB1bSAwNTo0NiBzY2hyaWViIFJveSBTdW46Cj4gVXBkYXRlIHRoZSB0aW1l
c3RhbXAgb2Ygc2NoZWR1bGVkIGZlbmNlIG9uIEhXCj4gY29tcGxldGlvbiBvZiB0aGUgcHJldmlv
dXMgZmVuY2VzCj4KPiBUaGlzIGFsbG93IG1vcmUgYWNjdXJhdGUgdHJhY2tpbmcgb2YgdGhlIGZl
bmNlCj4gZXhlY3V0aW9uIGluIEhXCj4KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNIE5pZXRvIDxk
YXZpZC5uaWV0b0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFJveSBTdW4gPFJveS5TdW5AYW1k
LmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+IGZvciB0aGUgc2VyaWVzLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jIHwgMTEgKysrKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX21haW4uYwo+IGluZGV4IDkyZDhkZTI0ZDBhMS4uZGMwNWEyMGE4ZWYyIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiBAQCAtNTE1LDcgKzUxNSw3IEBAIHZv
aWQgZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hl
ZCkKPiAgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMpOwo+ICAgCj4gICAv
KioKPiAtICogZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnNfZXh0IC0gaGVscGVyIHRvIHJlbHVuY2gg
Y2VydGFpbiBudW1iZXIgb2Ygam9icyBmcm9tIG1pcnJvciByaW5nIGxpc3QKPiArICogZHJtX3Nj
aGVkX3Jlc3VibWl0X2pvYnNfZXh0IC0gaGVscGVyIHRvIHJlbGF1bmNoIGNlcnRhaW4gbnVtYmVy
IG9mIGpvYnMgZnJvbSBwZW5kaW5nIGxpc3QKPiAgICAqCj4gICAgKiBAc2NoZWQ6IHNjaGVkdWxl
ciBpbnN0YW5jZQo+ICAgICogQG1heDogam9iIG51bWJlcnMgdG8gcmVsYXVuY2gKPiBAQCAtNjcx
LDcgKzY3MSw3IEBAIGRybV9zY2hlZF9zZWxlY3RfZW50aXR5KHN0cnVjdCBkcm1fZ3B1X3NjaGVk
dWxlciAqc2NoZWQpCj4gICBzdGF0aWMgc3RydWN0IGRybV9zY2hlZF9qb2IgKgo+ICAgZHJtX3Nj
aGVkX2dldF9jbGVhbnVwX2pvYihzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+ICAg
ewo+IC0Jc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYjsKPiArCXN0cnVjdCBkcm1fc2NoZWRfam9i
ICpqb2IsICpuZXh0Owo+ICAgCj4gICAJLyoKPiAgIAkgKiBEb24ndCBkZXN0cm95IGpvYnMgd2hp
bGUgdGhlIHRpbWVvdXQgd29ya2VyIGlzIHJ1bm5pbmcgIE9SIHRocmVhZAo+IEBAIC02OTAsNiAr
NjkwLDEzIEBAIGRybV9zY2hlZF9nZXRfY2xlYW51cF9qb2Ioc3RydWN0IGRybV9ncHVfc2NoZWR1
bGVyICpzY2hlZCkKPiAgIAlpZiAoam9iICYmIGRtYV9mZW5jZV9pc19zaWduYWxlZCgmam9iLT5z
X2ZlbmNlLT5maW5pc2hlZCkpIHsKPiAgIAkJLyogcmVtb3ZlIGpvYiBmcm9tIHBlbmRpbmdfbGlz
dCAqLwo+ICAgCQlsaXN0X2RlbF9pbml0KCZqb2ItPmxpc3QpOwo+ICsJCS8qIGFjY291bnQgZm9y
IHRoZSBuZXh0IGZlbmNlIGluIHRoZSBxdWV1ZSAqLwo+ICsJCW5leHQgPSBsaXN0X2ZpcnN0X2Vu
dHJ5X29yX251bGwoJnNjaGVkLT5wZW5kaW5nX2xpc3QsCj4gKwkJCQlzdHJ1Y3QgZHJtX3NjaGVk
X2pvYiwgbGlzdCk7Cj4gKwkJaWYgKG5leHQpIHsKPiArCQkJbmV4dC0+c19mZW5jZS0+c2NoZWR1
bGVkLnRpbWVzdGFtcCA9Cj4gKwkJCQlqb2ItPnNfZmVuY2UtPmZpbmlzaGVkLnRpbWVzdGFtcDsK
PiArCQl9Cj4gICAJfSBlbHNlIHsKPiAgIAkJam9iID0gTlVMTDsKPiAgIAkJLyogcXVldWUgdGlt
ZW91dCBmb3IgbmV4dCBqb2IgKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
