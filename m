Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F3EC48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 10:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95D5611C1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 10:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95D5611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7178489E26;
	Mon, 21 Jun 2021 10:27:49 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B6689EBD;
 Mon, 21 Jun 2021 10:27:48 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id gn32so510318ejc.2;
 Mon, 21 Jun 2021 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Kc8gTRhJVr4mndMt5T7ehgGK2e5385ss7fdEgOEpQTo=;
 b=YmWk+Kc4MY64T3MCmC0pNT5dWGVw+LrDGMV9GH22IfNzjkAFoKX5NB4COcFBmXpVJB
 Rm6TWSsWIhI/+Esdm4MXOK+a/sW/Wwgvr8eTdNIoh70kX+EIf4y3MOEY6C8NoCoy7A17
 3TEZshxSKv/cy8SgwDPr0bcTD0575na0MtoiKQAPjprHney1ODTxhjTH5Cv8gwfQwtLg
 Z9bBrvjh+zWyddKzUI/8jSqj/hEjYbGZbtBcYntCWt/3WvYkgMe5K12Lvg6OKQ3pnQhv
 5aX/HuKGFeD+gTaDuZiQCdgJ2bt5yCPwqNu6xC+w+VzE7CyCwjK6Cl9XpRsuT2Nt+8i1
 hI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Kc8gTRhJVr4mndMt5T7ehgGK2e5385ss7fdEgOEpQTo=;
 b=iQ1S745WVM3DN8/x7Yqy38qCPzRnF/GiuSdgkMXa6i/OI4iRvqRXGSvOVYl1XjjHtr
 q03Wq9Qt/wEOv2te7RImoaKr8KoiGB3lwQ+6cw3FZRUu4XnR/sxpySFvhbbO47SCxEJq
 aG/HumI0a2UKQzhgFtTbsTVn7uj67dgkjAIrtITO3sQMkjIDn/BFvH5ZJ/TMxONp9PgG
 GduDbY69fjVpI2eRCOcncRZpH9HTV3LPB2j4ABrGQg4yChiIEQAV+CQJjFGTMzz/SDHy
 2Ii29b/MoUVk3Xv4SIvTPaetF/XgWqC3QkJ7VVw+OKruZJHl5xzi3g4EVoiTYFyY/do5
 o8jA==
X-Gm-Message-State: AOAM530FlH6Ano016CRzVF9Aq3Y9F0jLPiH3IDxiARgP2oi8PB9qEbG5
 ciN5vcIx220VAqT6aBtI1as=
X-Google-Smtp-Source: ABdhPJyfI7mARehNoaiS3lUuteXfRbgWc21/TfrpBJf99V1xt5UmnZ5cjD+im8w8DLqgPIWXchAjrA==
X-Received: by 2002:a17:906:2b18:: with SMTP id
 a24mr15959584ejg.239.1624271267213; 
 Mon, 21 Jun 2021 03:27:47 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:aae5:6e05:c:d69?
 ([2a02:908:1252:fb60:aae5:6e05:c:d69])
 by smtp.gmail.com with ESMTPSA id jl10sm360145ejc.56.2021.06.21.03.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jun 2021 03:27:46 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_preempt_mgr_new()
To: Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <YMxbQXg/Wqm0ACxt@mwanda>
 <fadcee22-d830-c1be-09f0-9788b98c45ec@amd.com>
 <adee15a2-f531-688c-1121-7504163ae441@amd.com>
 <CADnq5_MtwTXEv=HitiyBfdSyBb-izSRiR3W=zxKNKRNvxdKO1A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <79eb1bb6-b77c-73e0-31f0-028743c98a36@gmail.com>
Date: Mon, 21 Jun 2021 12:27:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_MtwTXEv=HitiyBfdSyBb-izSRiR3W=zxKNKRNvxdKO1A@mail.gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDYuMjEgdW0gMjM6MTggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gRnJpLCBKdW4g
MTgsIDIwMjEgYXQgMTE6NDAgQU0gRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5j
b20+IHdyb3RlOgo+PiBBbSAyMDIxLTA2LTE4IHVtIDQ6MzkgYS5tLiBzY2hyaWViIENocmlzdGlh
biBLw7ZuaWc6Cj4+PiBBbSAxOC4wNi4yMSB1bSAxMDozNyBzY2hyaWViIERhbiBDYXJwZW50ZXI6
Cj4+Pj4gVGhlcmUgaXMgYSByZXZlcnNlZCBpZiBzdGF0ZW1lbnQgaW4gYW1kZ3B1X3ByZWVtcHRf
bWdyX25ldygpIHNvIGl0Cj4+Pj4gYWx3YXlzIHJldHVybnMgLUVOT01FTS4KPj4+Pgo+Pj4+IEZp
eGVzOiAwOWIwMjBiYjA1YTUgKCJNZXJnZSB0YWcgJ2RybS1taXNjLW5leHQtMjAyMS0wNi0wOScg
b2YKPj4+PiBnaXQ6Ly9hbm9uZ2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0vZHJtLW1pc2MgaW50byBk
cm0tbmV4dCIpCj4+Pj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRl
ckBvcmFjbGUuY29tPgo+Pj4gTW9zdCBiZSBzb21lIGZhbGxvdXQgZnJvbSBtZXJnaW5nIGl0IHdp
dGggdGhlIFRUTSBjaGFuZ2VzLgo+Pj4KPj4+IEFueXdheSwgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gVGhpcyBpcyBv
YnZpb3VzbHkgbm90IGZvciBhbWQtc3RhZ2luZy1kcm0tbmV4dC4gQ2hyaXN0aWFuLCBhcmUgeW91
IGdvaW5nCj4+IHRvIGFwcGx5IGl0IHRvIHRoZSByZWxldmFudCBicmFuY2hlcz8KPiBJJ3ZlIGFw
cGxpZWQgaXQgdG8gbXkgZHJtLW5leHQgYnJhbmNoLgoKSSBhbHJlYWR5IHB1c2hlZCBpdCB0byBk
cm0tbWlzYy1uZXh0IGxhc3Qgd2Vlay4KCkNocmlzdGlhbi4KCj4KPiBBbGV4Cj4KPgo+PiBUaGFu
a3MsCj4+ICAgIEZlbGl4Cj4+Cj4+Cj4+PiBUaGFua3MsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+
IC0tLQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmVlbXB0X21n
ci5jIHwgMiArLQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wcmVlbXB0X21nci5jCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHJlZW1wdF9tZ3IuYwo+Pj4+IGluZGV4IGY2YWZmN2NlNTE2MC4uZDAyYzg2MzdmOTA5
IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wcmVl
bXB0X21nci5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3By
ZWVtcHRfbWdyLmMKPj4+PiBAQCAtNzEsNyArNzEsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9wcmVl
bXB0X21ncl9uZXcoc3RydWN0Cj4+Pj4gdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPj4+PiAg
ICAgICAgc3RydWN0IGFtZGdwdV9wcmVlbXB0X21nciAqbWdyID0gdG9fcHJlZW1wdF9tZ3IobWFu
KTsKPj4+PiAgICAgICAgICAqcmVzID0ga3phbGxvYyhzaXplb2YoKipyZXMpLCBHRlBfS0VSTkVM
KTsKPj4+PiAtICAgIGlmICgqcmVzKQo+Pj4+ICsgICAgaWYgKCEqcmVzKQo+Pj4+ICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07Cj4+Pj4gICAgICAgICAgdHRtX3Jlc291cmNlX2luaXQodGJvLCBw
bGFjZSwgKnJlcyk7Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
