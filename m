Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28603C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1674616EB
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1674616EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727446E9D1;
	Tue, 11 May 2021 06:52:16 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE566E9D0;
 Tue, 11 May 2021 06:52:15 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id c22so21537121edn.7;
 Mon, 10 May 2021 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Zt9EleFqgDHEIQ+oyw3ngecefo9r13zwLFGMGvURmH8=;
 b=r73SwMKHhbYruy6BCD5buaACaKWq2AQGvkxITQjYzjfzNefUgDjucpCsQOqzqEWZSk
 7r90u0g6F7Kkt9jQkY3mfalz6Tn/X6YQat7hkP60TFYGxn70hNGuANDSdkDD1VGToNCy
 6v1mo36cvSKDT8z7JVHJucgBjjUtHMx2evDc0+dMoDkrtJ2ll/VgKMTvdLvIgogGvoXq
 lL0ynfOHclDArMQIpkR6fSnltTF9NXHjL2BsHEoSaGnZM5aYUHlxjxY6+OG7nyAxjysK
 35dnpYLLxj+8UDaBxTJMTzCus6ntlgQpX/iRfYutDO81zi2ZxcnWqqvl/XwxLTa4rFBd
 q9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Zt9EleFqgDHEIQ+oyw3ngecefo9r13zwLFGMGvURmH8=;
 b=dePTTJY1fQB3mfR+tfF5g0TKhUp3M/iogPr+lJEVIgG2mCsg28FFtQgEEGftTUwwCH
 JNY5s8msCV5HAnatQm8iXKh3HYI+s7U/QGHoTMwdfmxAsPGzpB9w6VI6pvKqc6cm59w1
 6qfylwN4/CvQnbNBRovmDAA8p5JA/lr5DsoPwBnPIty+5uZ0TVG3q3HMJpui8TEbMQzu
 YqDsXPIVxVvDynsWu/y2I0Pux8V4bybJOOdmeydRNPocIiCbxt3e7zt5AnOu+T6IyNfc
 nF2VuRR1APIZ0gvkmmXTI78kC9r+9w9BqA7AGs/93OYigZvgqL3PBo6ArpptkvHJWNNw
 Gv3Q==
X-Gm-Message-State: AOAM530PRsRvlD40nn6x5xT9hAo+nU49WCqf/FkerJ8zagFndMWtMHYZ
 7pnjPCtyV8G9K5B837lRe0E=
X-Google-Smtp-Source: ABdhPJxaATkCokEl6gpmLVR7OoX83MdgZZq/1DLhoe1faroKDNCmn4MMGzqnYoihRwxrCcsd9IGV+Q==
X-Received: by 2002:aa7:dad1:: with SMTP id x17mr34212261eds.47.1620715933847; 
 Mon, 10 May 2021 23:52:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e?
 ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
 by smtp.gmail.com with ESMTPSA id um28sm11148190ejb.63.2021.05.10.23.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:52:13 -0700 (PDT)
Subject: Re: [PATCH v6 11/16] drm/sched: Make timeout timer rearm conditional.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-12-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d0fb2146-7f35-9667-10d0-88424b403d85@gmail.com>
Date: Tue, 11 May 2021 08:52:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-12-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDUuMjEgdW0gMTg6MzYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBXZSBkb24n
dCB3YW50IHRvIHJlYXJtIHRoZSB0aW1lciBpZiBkcml2ZXIgaG9vayByZXBvcnRzCj4gdGhhdCB0
aGUgZGV2aWNlIGlzIGdvbmUuCj4KPiB2NTogVXBkYXRlIGRybV9ncHVfc2NoZWRfc3RhdCB2YWx1
ZXMgaW4gY29kZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXku
Z3JvZHpvdnNreUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX21haW4uYyB8IDExICsrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9tYWluLmMKPiBpbmRleCBmNGY0NzQ5NDQxNjkuLjhkMTIxMWU4NzEwMSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gQEAgLTMxNCw2ICszMTQsNyBAQCBzdGF0
aWMgdm9pZCBkcm1fc2NoZWRfam9iX3RpbWVkb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykK
PiAgIHsKPiAgIAlzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkOwo+ICAgCXN0cnVjdCBk
cm1fc2NoZWRfam9iICpqb2I7Cj4gKwllbnVtIGRybV9ncHVfc2NoZWRfc3RhdCBzdGF0dXMgPSBE
Uk1fR1BVX1NDSEVEX1NUQVRfTk9NSU5BTDsKPiAgIAo+ICAgCXNjaGVkID0gY29udGFpbmVyX29m
KHdvcmssIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciwgd29ya190ZHIud29yayk7Cj4gICAKPiBA
QCAtMzMxLDcgKzMzMiw3IEBAIHN0YXRpYyB2b2lkIGRybV9zY2hlZF9qb2JfdGltZWRvdXQoc3Ry
dWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCQlsaXN0X2RlbF9pbml0KCZqb2ItPmxpc3QpOwo+
ICAgCQlzcGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOwo+ICAgCj4gLQkJam9iLT5z
Y2hlZC0+b3BzLT50aW1lZG91dF9qb2Ioam9iKTsKPiArCQlzdGF0dXMgPSBqb2ItPnNjaGVkLT5v
cHMtPnRpbWVkb3V0X2pvYihqb2IpOwo+ICAgCj4gICAJCS8qCj4gICAJCSAqIEd1aWx0eSBqb2Ig
ZGlkIGNvbXBsZXRlIGFuZCBoZW5jZSBuZWVkcyB0byBiZSBtYW51YWxseSByZW1vdmVkCj4gQEAg
LTM0NSw5ICszNDYsMTEgQEAgc3RhdGljIHZvaWQgZHJtX3NjaGVkX2pvYl90aW1lZG91dChzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gICAJCXNwaW5fdW5sb2NrKCZzY2hlZC0+am9iX2xpc3Rf
bG9jayk7Cj4gICAJfQo+ICAgCj4gLQlzcGluX2xvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsK
PiAtCWRybV9zY2hlZF9zdGFydF90aW1lb3V0KHNjaGVkKTsKPiAtCXNwaW5fdW5sb2NrKCZzY2hl
ZC0+am9iX2xpc3RfbG9jayk7Cj4gKwlpZiAoc3RhdHVzICE9IERSTV9HUFVfU0NIRURfU1RBVF9F
Tk9ERVYpIHsKPiArCQlzcGluX2xvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsKPiArCQlkcm1f
c2NoZWRfc3RhcnRfdGltZW91dChzY2hlZCk7Cj4gKwkJc3Bpbl91bmxvY2soJnNjaGVkLT5qb2Jf
bGlzdF9sb2NrKTsKPiArCX0KPiAgIH0KPiAgIAo+ICAgIC8qKgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
