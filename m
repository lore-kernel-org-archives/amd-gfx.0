Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9666C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 14:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5590611C2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 14:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5590611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5F36EDC5;
	Wed, 19 May 2021 14:15:17 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF316EDC5;
 Wed, 19 May 2021 14:15:12 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id h16so15551909edr.6;
 Wed, 19 May 2021 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TtP8WVW+tcp98Fr66u48tzo0yVxMukLz/us7XyyQfO0=;
 b=L3fd4Ue0cwgbLoLKhQ0G1QwPmmtSSs0L+08FFlHNTTc3XxvGzkcE59S22AlHvuGBno
 MWgkJzcAeHdJKWqnCJmrBGDNYJx5dca9GGbXyBdy10DwiiL0xli+qbDu95FEFKhS12hh
 ydthdRpENL5mo7MFuIgzVmzoD1hsyXggBWcx8zpE66J2ps4NHqSinXjh7Y/I7rkk88+1
 PiH+1aYmU5w7obWmZ4CFZzpMXYe6oUECKkO79DLhjD+AQrLc4fyNqpPcJfs5IqbN19Ja
 JWnf9n608wLrgMvBmxcZYRS9GYMnxufXBV6fAE+/AnOU5jEQgfSc+3fupuZeQfVyfsew
 cmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TtP8WVW+tcp98Fr66u48tzo0yVxMukLz/us7XyyQfO0=;
 b=HaQD/Ou6uMavE2pG95HnLUqMz25ZwTLLKEjr+Z/Kv21RVrXYPBpwYTTAqvCb9Q53To
 tbluXzMsAAQN4ISA6UdTU0Z1L/1xAuiyc7RM3Q8WoiYcZKWIziL2itJcBt36X4pwg1fA
 QxrcV7Gxj5o3MPAJbbor3Gnpx72FM84T9ccjtyM/tAoboAKMJgirKGiiW4z9UTdYSrt8
 FkYJSyh2UFrumWZwWJJYXsWYavsIlVXFg3JHRnVNSsxcHxk0xdCrHMOJ1IA8bjRrrNcz
 PZiL0uRVaMPVfd61nXlYEdi4S1+J+hI+JxxBm9g5MCKfteqA+w9nhfW6vHeirDfv5hBn
 E5Mg==
X-Gm-Message-State: AOAM531FwynJjEcQfte9va/4x3dk4pSlOeVXJUWQfy/scif5X6OgngdI
 h0OcwEIpyiVBA3tCprYImwI=
X-Google-Smtp-Source: ABdhPJzJUFi4X4JkOfXlS4GBwyBhso5zyGqdyI0xZ4exkwDbf4pf9WqJu+3fM53IHc7WvecZOLXQPw==
X-Received: by 2002:aa7:d413:: with SMTP id z19mr14809405edq.37.1621433711484; 
 Wed, 19 May 2021 07:15:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a?
 ([2a02:908:1252:fb60:8e28:1d3:41f3:e15a])
 by smtp.gmail.com with ESMTPSA id c3sm16593506edn.16.2021.05.19.07.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 07:15:11 -0700 (PDT)
Subject: Re: [PATCH] drm/sched: Avoid data corruptions
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <fa81de6a-e272-66cf-61d8-5bb2d0ebcb03@gmail.com>
 <20210519141407.88444-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ce0d6f1c-4cb6-e21f-28c5-93531b687976@gmail.com>
Date: Wed, 19 May 2021 16:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519141407.88444-1-andrey.grodzovsky@amd.com>
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

QW0gMTkuMDUuMjEgdW0gMTY6MTQgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBXYWl0IGZv
ciBhbGwgZGVwZW5kZW5jaWVzIG9mIGEgam9iICB0byBjb21wbGV0ZSBiZWZvcmUKPiBraWxsaW5n
IGl0IHRvIGF2b2lkIGRhdGEgY29ycnVwdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
R3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDUgKysrKysKPiAgIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
c2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9lbnRpdHkuYwo+IGluZGV4IDJlOTNlODgxYjY1Zi4uZDVjZjYxOTcyNTU4IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4gQEAgLTIyMiwxMSArMjIyLDE2
IEBAIHN0YXRpYyB2b2lkIGRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzX2NiKHN0cnVjdCBkbWFf
ZmVuY2UgKmYsCj4gICBzdGF0aWMgdm9pZCBkcm1fc2NoZWRfZW50aXR5X2tpbGxfam9icyhzdHJ1
Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+ICAgewo+ICAgCXN0cnVjdCBkcm1fc2NoZWRf
am9iICpqb2I7Cj4gKwlzdHJ1Y3QgZG1hX2ZlbmNlICpmOwo+ICAgCWludCByOwo+ICAgCj4gICAJ
d2hpbGUgKChqb2IgPSB0b19kcm1fc2NoZWRfam9iKHNwc2NfcXVldWVfcG9wKCZlbnRpdHktPmpv
Yl9xdWV1ZSkpKSkgewo+ICAgCQlzdHJ1Y3QgZHJtX3NjaGVkX2ZlbmNlICpzX2ZlbmNlID0gam9i
LT5zX2ZlbmNlOwo+ICAgCj4gKwkJLyogV2FpdCBmb3IgYWxsIGRlcGVuZGVuY2llcyB0byBhdm9p
ZCBkYXRhIGNvcnJ1cHRpb25zICovCj4gKwkJd2hpbGUgKChmID0gam9iLT5zY2hlZC0+b3BzLT5k
ZXBlbmRlbmN5KGpvYiwgZW50aXR5KSkpCj4gKwkJCWRtYV9mZW5jZV93YWl0KGYpOwo+ICsKPiAg
IAkJZHJtX3NjaGVkX2ZlbmNlX3NjaGVkdWxlZChzX2ZlbmNlKTsKPiAgIAkJZG1hX2ZlbmNlX3Nl
dF9lcnJvcigmc19mZW5jZS0+ZmluaXNoZWQsIC1FU1JDSCk7Cj4gICAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
