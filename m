Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C5C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 09:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4F32084C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 09:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4F32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B832989295;
	Thu,  7 Nov 2019 09:35:33 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA3089295
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 09:35:32 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id z19so1589109wmk.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 01:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qMNgbHKsx1OInxHYy+e453lTdjamYtF0cHzSgRAk5v8=;
 b=QJRdq/9Bp+isIOd24qCbW5ujlX0f8eu0VBOqOZGc5541LpddpuyaaEcMRrK8HBSuJT
 nXOFPkj57B+BRa3NZz3S0lk5ar70hjg1kj8UDZhmvihVwJNrvwK/RzM8REFwouEhGisa
 AOtfIWtEAsYTnpNA1dh0qv9ph3L8vAIYfhFBVv9TY6ryzGBVQRVb2aPrxI0wt3Cu57OQ
 nMVV+za8q5YJLM/Rykk+FDy56pxewUOgWnQ/8L7Ae8MpWjyKwrxb2MLrgEm2ml/yLkjZ
 BX4ZweZ5MdeMLtMCc4afTXeP7KDBkQzf3m6/3EOmNYaMDZvl7An4ROw5SXRzA349SN6K
 XzDw==
X-Gm-Message-State: APjAAAUJ7xGNxOlKmSf5lQp52gWTy2RnMb1xK86RUfZfOL+YQDgBdpxx
 6OfuEXzNMt3Um2o1GC+vy5t5+TNL
X-Google-Smtp-Source: APXvYqz42zvrfzstUXamrcjGHF20ubjsXoyhpYlTz12FjnnGoRtGNd6YxHqfcOHN0drYrvR4O37xkg==
X-Received: by 2002:a1c:9c82:: with SMTP id f124mr2023172wme.25.1573119331302; 
 Thu, 07 Nov 2019 01:35:31 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a6sm1256114wmj.1.2019.11.07.01.35.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 01:35:30 -0800 (PST)
Subject: Re: [PATCH] drm/amd/amdgpu: Cancel delay work before unload driver
To: Jesse Zhang <zhexi.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573112184-14195-1-git-send-email-zhexi.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3faa0879-7a6d-7791-5941-347c87b1ba86@gmail.com>
Date: Thu, 7 Nov 2019 10:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573112184-14195-1-git-send-email-zhexi.zhang@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qMNgbHKsx1OInxHYy+e453lTdjamYtF0cHzSgRAk5v8=;
 b=pP1kEP3MqPYXOT1RB/htTZOWGANdn3j3TkFL1W/aPNZ4NcLR6IlRmhAzCL6zre4Roh
 JEbE0oPLvgXk0GUjZq4UyGjcBFCdqRZJD3gknovTQfEz3e/AQw0ZHniydsmnM8FQLXnd
 /631qVG6o9vqTkEAlMxdvLIZO5bm0I/sZ/38ugVW1Rchy+kwGVLOGb65c4SG1er3hbZk
 tiOoWSoVFysdqxQC8RiX35HFmQPVOlNtu+UCJBXWZSVlrMvexAyiYj/m8PXjFNwIOSgJ
 u85Hn+ovlg8Ok75Cnaftk5vjI5SSiaxL8auc4R1BKubFrypuV96sXpvQ3xGScfZyTWKj
 Ownw==
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107093529.1G0y-W6AKRhYmEYqwW85t2tkaZxW8xTG0RsjcYyl6nY@z>

QW0gMDcuMTEuMTkgdW0gMDg6MzYgc2NocmllYiBKZXNzZSBaaGFuZzoKPiBtb3ZlIGNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygpIHRvIHRoZSBiZWdpbmluZwo+IG9mIGFtZGdwdV9kZXZpY2VfZmlu
aSgpIHRvIGNhbmNlbCB1bmZpbmlzaGVkCj4gd29ya3Mgd2hpY2ggYXJlIG5vIGxvbmdlciBuZWVk
ZWQuCj4KPiBDaGFuZ2UtSWQ6IEk4ODMxOTM1Yjc5N2M3OGI5NzFhYTcyMzM2OTdjMzYxNDAzNzRm
MWFjCj4gU2lnbmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPHpoZXhpLnpoYW5nQGFtZC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA3ICsr
KysrKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jICAgICB8IDIg
KysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXggZjBh
ZDA1ZC4uNWI4YWY2OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKPiBAQCAtMzExNSw2ICszMTE1LDEyIEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCj4gICAJRFJNX0lORk8oImFtZGdwdTog
ZmluaXNoaW5nIGRldmljZS5cbiIpOwo+ICAgCWFkZXYtPnNodXRkb3duID0gdHJ1ZTsKPiArCj4g
KwkvKiBDYW5jZWwgdW5maW5pc2hlZCBkZWxheSB3b3JrIGJlZm9yZSB1bmxvYWQgZHJpdmVyICov
Cj4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsK
CkdvZXMgaW50byB0aGUgcmlnaHQgZGlyZWN0aW9uLCBidXQgSSB3b3VsZCByYXRoZXIgZ28gd2l0
aCAKZmx1c2hfZGVsYXllZF93b3JrKCkgdG8gbWFrZSBzdXJlIHRoZSBkZWxheWVkIGluaXQgd29y
ayBpcyBhY3R1YWxseSBydW4uCgo+ICsJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT51
dmQuaWRsZV93b3JrKTsKPiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNlLmlk
bGVfd29yayk7Cj4gKwoKVGhpcyBiZWxvbmdzIGludG8gdGhlIFVWRC9WQ0UgY29kZSBzaW5jZSB0
aGUgaWRsZSB3b3JrIGhhbmRsZXJzIGFyZSBub3QgCmluaXRpYWxpemVkIGlmIHRoZSBkZXZpY2Ug
ZG9lc24ndCBoYXZlIGFuIFVWRC9WQ0UgYmxvY2suCgo+ICAgCS8qIGRpc2FibGUgYWxsIGludGVy
cnVwdHMgKi8KPiAgIAlhbWRncHVfaXJxX2Rpc2FibGVfYWxsKGFkZXYpOwo+ICAgCWlmIChhZGV2
LT5tb2RlX2luZm8ubW9kZV9jb25maWdfaW5pdGlhbGl6ZWQpewo+IEBAIC0zMTM0LDcgKzMxNDAs
NiBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgIAkJYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncgPSBOVUxMOwo+ICAgCX0KPiAgIAlhZGV2
LT5hY2NlbF93b3JraW5nID0gZmFsc2U7Cj4gLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFk
ZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKPiAgIAkvKiBmcmVlIGkyYyBidXNlcyAqLwo+ICAgCWlm
ICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9ydChhZGV2KSkKPiAgIAkJYW1kZ3B1X2kyY19m
aW5pKGFkZXYpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gaW5kZXgg
ZDEyMWJiZC4uZmM2Yzk0OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jCj4gQEAgLTM2NCw2ICszNjQsOCBAQCBpbnQgYW1kZ3B1X2liX3JpbmdfdGVzdHMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFk
ZXYtPnJpbmdzW2ldOwo+ICAgCQlsb25nIHRtbzsKPiAgIAo+ICsJCWlmIChhZGV2LT5zaHV0ZG93
bikKPiArCQkJcmV0dXJuIDA7CgpUaGF0IGxvb2tzIHJhdGhlciBzdXBlcmZsdW91cywgaXMgdGhh
dCByZWFsbHkgbmVjZXNzYXJ5PwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiAgIAkJLyogS0lRIHJp
bmdzIGRvbid0IGhhdmUgYW4gSUIgdGVzdCBiZWNhdXNlIHdlIG5ldmVyIHN1Ym1pdCBJQnMKPiAg
IAkJICogdG8gdGhlbSBhbmQgdGhleSBoYXZlIG5vIGludGVycnVwdCBzdXBwb3J0Lgo+ICAgCQkg
Ki8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
